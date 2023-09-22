Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9200CE6FE41
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851D886199;
	Fri, 22 Sep 2023 17:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsZ32EU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC50863DD; Fri, 22 Sep 2023 17:01:32 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF3A84003
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53087f0e18bso2661620a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695394890; x=1695999690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IKxzTBMpkJJiYgpwuxDwSPQzGnwAUeiT7sMXOjni010=;
 b=nsZ32EU/avXL/bnhZnh4DZA6E8yqf3EiMyeuNBi8Al6E1w2o7nQlhCTMADrioV5Uyd
 K1wlTzvOIRdf+Xdu6XjXzrtzxvg3O1cVT5V7xVzRkTmS5BWBISXIED3psJ58Klc1eNLP
 rx0XFRJHHZBfavNjJ0SvtB3WVIkKp0cqpSsfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695394890; x=1695999690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKxzTBMpkJJiYgpwuxDwSPQzGnwAUeiT7sMXOjni010=;
 b=pGZV/x5YQaUIigQMSAMD9dxvVMa+QXc6WPXTvVSzumA+mOnB433uMfLDn3qDscdXRb
 NOpY0Hnw7/9YLYk27biLB7waB0gUhYm2mhKE4V8iC8DUgeO4G2ISLU7w6rkwsEALrX+n
 O3pSKA4Vw7unk8lnjtcT/Hu/q1vdNPiedq5Ik7psk0UwF6ZLYSKU2bJ/EFniV+1lK182
 8erK5TBMQzPDPla6ckCdkZt8xMewfbUpo8YA33vsNcDALOSswRQOTsowOupNHGg661zy
 spChq/1fTvNu1Fvvnww52kX7zOOV3eg2HTkfHFl/srYGxNFgwHXWwzafyTEJyv7uQxMF
 auGw==
X-Gm-Message-State: AOJu0YwvHrk74qLMQ4HoQfztQYjrP94EAbTnjPzXFY4GcpfK+28HVY2w
 FqtlnokreRQTfsPS61uHwhwTMAcJkMSg+/YxTF7hng==
X-Google-Smtp-Source: AGHT+IHqmYjd/dCy3ZSKOvDgLL1VPdgGkAf9zLGoDLKfeb3Mv1ImZMuP9aN/pEsxpQYP2hvU9GznJtdx8OZ8tOOp52I=
X-Received: by 2002:a05:6402:22eb:b0:533:6ef4:9f5b with SMTP id
 dn11-20020a05640222eb00b005336ef49f5bmr1801839edb.6.1695394889631; Fri, 22
 Sep 2023 08:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
In-Reply-To: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 09:01:18 -0600
Message-ID: <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
Subject: Re: [Question] TI's u-boot.img is built twice
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, n-francis@ti.com, s-vadapalli@ti.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Masahiro,

On Thu, 21 Sept 2023 at 09:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi.
>
> Since the TI platform migrated to binman,
> u-boot.img is built twice.
>
> It is created by "mkimage -E",
> then overwritten by binman.
>
>
> So, the data are embedded in the FIT structure
> instead of being appended.
>
> Is this intentional?
>
> To me, it looks weird.
>
>
>
>
> To confirm it, apply the following hack.
>
> Since u-boot.img is overwritten by binman,
> copy it to u-boot.img.backup.
>
>
>
>
> diff --git a/Makefile b/Makefile
> index 87f9fc786e..4cffa8a061 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1112,6 +1112,7 @@ endef
>  # Timestamp file to make sure that binman always runs
>  .binman_stamp: $(INPUTS-y) FORCE
>  ifeq ($(CONFIG_BINMAN),y)
> +       cp u-boot.img u-boot.img.backup
>         $(call if_changed,binman)
>  endif
>         @touch $@
>
>
>
> Then, build it for the main core.
>
>
> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
>    am64x_evm_a53_defconfig all
>    TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
>    BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
>    BINMAN_INDIRS=~/ref/ti-linux-firmware
>
>
>
>
> Compare the two files.
> Run fdtdump to see what happened to them.
>
>
> $ diff -u u-boot.img  u-boot.img.backup
> Binary files u-boot.img and u-boot.img.backup differ
>
>
> $ fdtdump u-boot.img
>     => u-boot and dt are embedded.
>
> $ fdtdump u-boot.img.backup
>     => u-boot and dt are appended after the
>        FIT structure

That seems like a bug to me...at some point we might consider building
u-boot.img with Binman, but for now it is built by the Makefile.

>
>
>
> --
> Best Regards
> Masahiro Yamada

Regards,
Simon
