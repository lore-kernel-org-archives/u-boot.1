Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397EFCD4846
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 16:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7218586199;
	Fri, 22 Sep 2023 18:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fc3mFtst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7588C85DFA; Fri, 22 Sep 2023 18:41:24 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA2B864CD
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 18:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c137f74b23so22235691fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695400878; x=1696005678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GpYFknj3z5EKVTxO6cfpXQVTxGL8OVJwzoD2KmSseZ8=;
 b=fc3mFtstTEXIx75ySGAMZ9Xdw/xj6QQPLiYSVixWysvLRu8TG3BmGd6d8bifv+qLqB
 6/vYvVyh8zb8+jobuY7dkGAYd48aC8SfL0tsvOZHJvmKYHZCy/ja0+i8pxfvU0dq9uUz
 roysPZf09M0BEpr30AojMCmrtkfmXCZvtAsZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695400878; x=1696005678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GpYFknj3z5EKVTxO6cfpXQVTxGL8OVJwzoD2KmSseZ8=;
 b=IsHAvU/IHAIHYqFTd0fee+enBGPcvVXFR7X535jTcAT3Eo5O71iDxbgtINc1+F4psB
 jdSJ6ECgQ84p0Idj5k+Uqzqovb6RdResC2llMEiqbXNc8/NmwBGqHunxaqcsGw0HhGDu
 9oWNxJ1UeaGfpNia+2dqWbr922f8Gb+bHo/hZz16bGAXpftcBuitnDyiFnjHb0ex18/y
 jzgG4xsND8F+HdWPBHAOJjoz203utbDEI5SqvXM70d3H2h5IrAwGOrPVsdNmUlNY4qA7
 ne9gf285j1Xd5WJXtPgVUp7BHcaTNxMxMcsP1Zoj0w4U58riktNkshYN5Z7QF+8/b34P
 d0ZA==
X-Gm-Message-State: AOJu0YyB1tdQuW/M/jbkbRx251SB69QkeEesV14BdRak3g2weByC9rGE
 zsSVnICCXpHoc29yq2flbxFF5FKtOmUDVk5w/8fZQQ==
X-Google-Smtp-Source: AGHT+IHQhuuSpxRH5MMqW1AtdUJVgrbbZ0IJhqLrYbKVpSw35H45cwSRcXCYZF8sXjGywXaKla36AtUs9t9W8CDSiQY=
X-Received: by 2002:a05:6512:488e:b0:502:ffff:feff with SMTP id
 eq14-20020a056512488e00b00502fffffeffmr46131lfb.58.1695400877399; Fri, 22 Sep
 2023 09:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASYfwjuCQ70BZ5Gco+rme=H_fArxyT5rFsE334p2viSoA@mail.gmail.com>
 <CAPnjgZ2W_2d-xhdKPbatR4L3BjE08ZEH4SdBSi6YVDWqs7Swmw@mail.gmail.com>
 <41a5e281-9dcd-9720-380a-ea59566d7dc1@ti.com>
In-Reply-To: <41a5e281-9dcd-9720-380a-ea59566d7dc1@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 10:40:58 -0600
Message-ID: <CAPnjgZ34hW-61MNEORQU8xofBaoBu_piau4rKd2hdTJgFbSZnA@mail.gmail.com>
Subject: Re: [Question] TI's u-boot.img is built twice
To: Andrew Davis <afd@ti.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nishanth Menon <nm@ti.com>, srk@ti.com, n-francis@ti.com, s-vadapalli@ti.com, 
 m-chawdhry@ti.com
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

Hi Andrew,

On Fri, 22 Sept 2023 at 10:35, Andrew Davis <afd@ti.com> wrote:
>
> On 9/22/23 10:01 AM, Simon Glass wrote:
> > Hi Masahiro,
> >
> > On Thu, 21 Sept 2023 at 09:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>
> >> Hi.
> >>
> >> Since the TI platform migrated to binman,
> >> u-boot.img is built twice.
> >>
> >> It is created by "mkimage -E",
> >> then overwritten by binman.
> >>
> >>
> >> So, the data are embedded in the FIT structure
> >> instead of being appended.
> >>
> >> Is this intentional?
> >>
> >> To me, it looks weird.
> >>
> >>
> >>
> >>
> >> To confirm it, apply the following hack.
> >>
> >> Since u-boot.img is overwritten by binman,
> >> copy it to u-boot.img.backup.
> >>
> >>
> >>
> >>
> >> diff --git a/Makefile b/Makefile
> >> index 87f9fc786e..4cffa8a061 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -1112,6 +1112,7 @@ endef
> >>   # Timestamp file to make sure that binman always runs
> >>   .binman_stamp: $(INPUTS-y) FORCE
> >>   ifeq ($(CONFIG_BINMAN),y)
> >> +       cp u-boot.img u-boot.img.backup
> >>          $(call if_changed,binman)
> >>   endif
> >>          @touch $@
> >>
> >>
> >>
> >> Then, build it for the main core.
> >>
> >>
> >> make -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
> >>     am64x_evm_a53_defconfig all
> >>     TEE=~/ref/OP-TEE/optee_os/out/arm-plat-k3/core/tee-raw.bin
> >>     BL31=~/ref/trusted-firmware-a/build/k3/lite/release/bl31.bin
> >>     BINMAN_INDIRS=~/ref/ti-linux-firmware
> >>
> >>
> >>
> >>
> >> Compare the two files.
> >> Run fdtdump to see what happened to them.
> >>
> >>
> >> $ diff -u u-boot.img  u-boot.img.backup
> >> Binary files u-boot.img and u-boot.img.backup differ
> >>
> >>
> >> $ fdtdump u-boot.img
> >>      => u-boot and dt are embedded.
> >>
> >> $ fdtdump u-boot.img.backup
> >>      => u-boot and dt are appended after the
> >>         FIT structure
> >
> > That seems like a bug to me...at some point we might consider building
> > u-boot.img with Binman, but for now it is built by the Makefile.
> >
>
> This is not true for K3 as we now use Binman for u-boot.img generation
> (we need this as we have a signing step injected at this point).

No, no.

You must not mess with the outputs of Makefile - create a new file
with what you need, e.g. u-boot-ti.img

While we could use Binman to produce the .img we are quite a way from
doing that as not that many boards have been converted to binman.

>
> So as Masahiro suggested in the other branch of this thread, we need
> to disable the Makefile generation of u-boot.img for K3.
>
> Neha,
>
> Can you take this action? I assume you can add it as part of your
> work in making the data external again, which would make the u-boot.img
> identical to before and hence Makefile version could be disabled at
> the same time/series.

If you are suggesting that we slowly migrate boards away from
generating the .img using Makefile...perhaps that makes sense? I'm not
really sure. But in that case we need another Kconfig option.

Regards,
Simon
