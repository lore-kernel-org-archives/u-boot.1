Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDDD586B79;
	Mon, 16 Oct 2023 08:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XDO9Z7c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C32E86BD5; Mon, 16 Oct 2023 08:35:56 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A0E869D1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso2456317a12.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438151; x=1698042951; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RyVqMq38b2b4q90E5O5V120UhZwN7d5NtwR/xxKajWY=;
 b=XDO9Z7c/qOT8jsHtkBvYzzFybmlyVUUoDQQhmoSoGkLBE5r7H7OSoj9cW86OIOwlAf
 HCDGD1XxnIAS1LFKFpoY6QbucsxEdNsyWj/VUUy9dEwIe7dietfjNXkN7C+/TkG3/n0E
 KnBQKUxqMWKBRodLH1WotX8gJmWrTqQaYR0xzN3f6p1Bq2FGh6h00NrICnyjaj4GE7Ko
 YqJhRvBy1yCHS7gnhre7bvOuyhzjK3HpBkJuhBRNtv1bVOvO3eeDvmy943sfBUw4lT6W
 HHx7SsicQf50kxEQaFbYrOsUIlqhWsIZFQSqO1jki5U6fDVbmvFCu0VJfuBjMaitvB3N
 UCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438151; x=1698042951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RyVqMq38b2b4q90E5O5V120UhZwN7d5NtwR/xxKajWY=;
 b=UBreNDCnE56QUMPjToCnuaCNYy9KlR8FSDCZz8N0hmKs8rXdES3v75ZqbbXGkz/yin
 D2atef/gE1VJhQrIqmFdNywJq41b2POXVo24Q3iVmcoIogOFPDTLlbW849zI3Gx7EzNf
 fL9WkToGtqAmDfLo174NJOwAr2iR/yBg5VpgyTuHTjUX54573hGnriH57jrq9dHojecx
 wu1wcDRqhPSi2Qpgfq3M/8qU0Dl507lVnepeYhU1xmZ2DTtbvRLuiSfHTfvVMT58Yeyi
 pateGHMjmYBbtO/L2p3qRTZ0+VFB4EF+KGoLelF+QpLvfc2FDb8/DCIxZApi8AhTYMh2
 eRKw==
X-Gm-Message-State: AOJu0Yz1ThHL4pHHgQlYAyz6JVi9y7qssw8RsurNZ9fRn7A7nMOjZV5n
 rrEz4xwZQ12neiyDU9CRF6/eur2N+1jse0JwLH/fGw==
X-Google-Smtp-Source: AGHT+IHs3U52IrgvWIRfXsuzEW4K1HZK4RlhECfKYfhgYSsYay0moCR6SBaTTWzelMr+qjtsG+D4ss3x9iH3Yoq/Zgg=
X-Received: by 2002:a17:90a:4584:b0:273:b0bd:343b with SMTP id
 v4-20020a17090a458400b00273b0bd343bmr27593429pjg.41.1697438151331; Sun, 15
 Oct 2023 23:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
 <CADQ0-X-=4q7dCeny2F_J6DqY9bVxQ01p-zLyu4rnwVXmE=iiEA@mail.gmail.com>
 <c3dfae22-94a0-4d64-9175-dde259c421ef@amd.com>
In-Reply-To: <c3dfae22-94a0-4d64-9175-dde259c421ef@amd.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Mon, 16 Oct 2023 15:35:40 +0900
Message-ID: <CADQ0-X_-5VfP2EmApHQrvDaXbBZHeUUuPk4wbaD5FnZRP75Q_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add EFI HTTP boot support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

Hi Michal,

On Mon, 16 Oct 2023 at 15:25, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 10/16/23 04:39, Masahisa Kojima wrote:
> > On Mon, 16 Oct 2023 at 08:50, Masahisa Kojima
> > <masahisa.kojima@linaro.org> wrote:
> >>
> >> This series adds the EFI HTTP boot support.
> >> User can add the URI device path with "efidebug boot add" command.
> >> efibootmgr handles the URI device path, download the
> >> specified file using wget, mount the downloaded image with
> >> blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
> >> by selecting automatically created boot option when the new disk is
> >> detected.
> >>
> >> This version still does not include the test.
> >>
> >> To enable EFI HTTP boot, we need to enable the following Kconfig options.
> >>   CONFIG_CMD_DNS
> >>   CONFIG_CMD_WGET
> >>   CONFIG_BLKMAP
> >>   CONFIG_EFI_HTTP_BOOT
> >>
> >> On the Socionext Developerbox, enter the following commands then
> >> debian installer is downloaded into "loadaddr" and installer
> >> automatically starts.
> >>   => dhcp
> >>   => setenv serverip 192.168.1.1
> >>   => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
> >>   => efidebug boot order 3
> >>   => bootefi bootmgr
> >>
> >> Note that this debian installer can not proceed the installation
> >> bacause RAM disk of installer image is not recogniged by the kernel.
> >> I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
> >> will be one of the solution to recognize RAM disk from kernel.
> >> (In EDK2, the equivalent solution is called ACPI NFIT.)
> >>
> >> On QEMU, I can not make DNS work from the QEMU guest.
> >> The following commands work on qemu_arm64(manually set the http server ip in URI).
> >>    => dhcp
> >>    => setenv gatewayip 10.0.2.2
> >>    => setenv httpserverip 134.160.38.1
> >>    => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
> >>    => efidebug boot order 3
> >>    => bootefi bootmgr
> >>
> >> [TODO]
> >> - add test
> >> - stricter wget uri check
> >> - omit the dns process if the given uri has ip address
> >>     -> this will be supported when the lwip migration completes
> >> - uri device path support in eficonfig
> >>
> >> [change log]
> >> v5 -> v6
> >> - add patch #4 "Boot var automatic management for removable medias"
> >> - boot from automatically created boot option
> >>    rather than searching default file on the fly
> >> - introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
> >> - comment in one place
> >> - use log_err() rather than printf()
> >> - use env_get_hex("filesize", 0) instead of return value of net_loop()
> >> - use more suitable error code
> >> - blkmap can be build for SPL/TPL
> >> - add CDROM short-form device path support
> >
> > Sorry but I forgot to include the necessary changes.
> > I will resend this series soon.
>
> Which pretty much means that that next series is v7. If not you will confuse
> tools like b4.

Thank you, yes, I will send the updated version as v7.
Sorry for sending so many emails.

Thanks,
Masahisa Kojima

>
> Thanks,
> Michal
>
