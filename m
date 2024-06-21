Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCFC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2088B8839C;
	Fri, 21 Jun 2024 10:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hp1m2fcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D314E88013; Fri, 21 Jun 2024 10:07:30 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0EF88405
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 10:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-48ed52b59acso642500137.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957247; x=1719562047; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xUb8+fvQKxgAnYAiwiBS9avcC8+rltAFLr7A2v7/3X0=;
 b=Hp1m2fcxmL6Fc61qG18171WNPH9DFGOeotvB1+ANt2PVBkya4bYmZXYF4Acgh+RqWm
 9ON1sQQWoxDnLr4hayw7RugijEDc63CjXlUQfgk53QlTNl3ORE1OJvaQ5Qs+Fn3oDezN
 yp23SzPFhkk4DRi1/PQqznmhK27czb/VFyrrD6HgOT4ERCq4YdMfhvUG1ej8Kj+PtG0W
 pwW7/+3HLdVwgY9oc7QNupRkAjhGS5YjNks87rK9vAE8UlAqB18lin6eib+nhP5vNqIS
 QjkaWdQ5u5dQ3JwkKncsFyASAgkfxcsV8Mar+Ij1YzffJ4cOTzg8VV3dfFRw1ckIqBVd
 99oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957247; x=1719562047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUb8+fvQKxgAnYAiwiBS9avcC8+rltAFLr7A2v7/3X0=;
 b=h4d9dV7Eyby0rM7sdypG4/wbWg5efqo6tmFkER7MjdPLpjl8Di8D3NmIc2pU0hUjN2
 TYrYuFnxhJ9Mol64TQE8d0wQLSNZ7b0Hmbw6vlhw1JyWVvSTfhBP5mnjMnicflVTisds
 gKsxMrPoR6oDWg+K2xUQy1cH5K3kqqcDN221m5iM45hII5EDWiJkAGgzQVQOi0FCjrIy
 e+RAcjvXDXIj6Ef/Cf9D5jHcTUvFuy8eYkxDmVf0Cn6Tft48hoqjaBcKU2AwZzohrXNd
 20BtN0ITLHtPHfD39LIerss8ID/vDf5a+t6QkNrCV2jEpg28PlFZDoO5zTFUOAfKe+vA
 6gng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtSGLvA+ksaxyGFNCesFnOYhmdZIUQpTvs699+g9dJM0my3ROwAIxQFsb455pZnWBzpKbAX8ycT3BLvEMfkmuiCOQU9A==
X-Gm-Message-State: AOJu0YzTHax1Nsj9uO7G+tP0N2bBqBj8cSL4gUl+MysCqE0Z/2ognLVK
 K3DXUCSWWLBSWWlbPpu39QYd+fnVxSp3KEE9uaLNLsY16O6YpG6BfthynjzaU2+Qan0d0ZrcNYe
 iWBKxOQdN4FMhL9eaXdF+UnvSwvl4Cl5DckUq9w==
X-Google-Smtp-Source: AGHT+IGM9Wq2Clgq7Cxwjkdq8liM8dLECSKqfWsvp8ipDesH/6SgQQPvOOy1QKSj/U9PP8tNumA19lGQVrT9ej//hkM=
X-Received: by 2002:a67:ad05:0:b0:48d:7702:99e2 with SMTP id
 ada2fe7eead31-48f130e0859mr7585920137.31.1718957246999; Fri, 21 Jun 2024
 01:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240617085629.1744017-1-caleb.connolly@linaro.org>
 <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
 <d64e6ce3-0bc5-4175-af7c-6146d4402c60@linaro.org>
In-Reply-To: <d64e6ce3-0bc5-4175-af7c-6146d4402c60@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Jun 2024 13:37:15 +0530
Message-ID: <CAFA6WYOZjm6akShXbL2UG+Cs=CAxZAmdG+WkiVt=KESOvvbc+g@mail.gmail.com>
Subject: Re: [PATCH] mach-snapdragon: move default environment to a file
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Fri, 21 Jun 2024 at 13:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 21/06/2024 09:35, Sumit Garg wrote:
> > Hi Caleb,
> >
> > On Mon, 17 Jun 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
> >> environment to a file under board/qualcomm.
> >>
> >> This is much cleaner and means we don't need to recompile on changing
> >> the environment.
> >>
> >> Additionally, extend the environment to include a boot menu and
> >> auto-boot using EFI instead of bootm. Since we now support MMC and USB
> >> on most platforms, these are much more useful defaults.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   board/qualcomm/default.env | 12 ++++++++++++
> >>   configs/qcom_defconfig     |  2 ++
> >>   include/configs/qcom.h     |  7 -------
> >>   3 files changed, 14 insertions(+), 7 deletions(-)
> >>   create mode 100644 board/qualcomm/default.env
> >>
> >> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> >> new file mode 100644
> >> index 000000000000..243aede77be7
> >> --- /dev/null
> >> +++ b/board/qualcomm/default.env
> >> @@ -0,0 +1,12 @@
> >> +stdin=serial,button-kbd
> >> +stdout=serial,vidconsole
> >> +stderr=serial,vidconsole
> >> +bootfile=/extlinux/extlinux.conf
> >
> > Is this file used to perform EFI boot or is it redundantly copied from
> > somewhere?
>
> This is here because there's a bunch of codepaths in U-Boot that
> implicitly expect the bootfile environment variable to have something
> useful in. It stops a whole class of null pointer exceptions.
>
> extlinux isn't used for EFI booting, but it's supported, and having a
> sensible default here is nice-to-have regardless.

extlinux is a different boot method as compared to EFI, so it looks
confusing to use extlinux as default when we want EFI to be the
default. AFAICS, bootfile simply means the file to load and boot which
makes it more suitable for Linux image ("Image") to be the default
option.

With that change, feel free to add

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Kind regards,
> >
> > -Sumit
> >
> >> +preboot=scsi scan; usb start
> >> +fastboot=fastboot -l $fastboot_addr_r usb 0
> >> +do_boot=bootefi bootmgr
> >> +bootmenu_0=Boot first available device=run do_boot
> >> +bootmenu_1=Enable fastboot mode=run fastboot
> >> +bootmenu_2=Reset device=reset
> >> +menucmd=bootmenu
> >> +bootcmd=run do_boot
> >> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> >> index 80ad3b32e139..a9e3797bb39a 100644
> >> --- a/configs/qcom_defconfig
> >> +++ b/configs/qcom_defconfig
> >> @@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
> >>   CONFIG_CMD_LOG=y
> >>   CONFIG_OF_LIVE=y
> >>   CONFIG_OF_BOARD_SETUP=y
> >>   CONFIG_BUTTON_QCOM_PMIC=y
> >> +CONFIG_USE_DEFAULT_ENV_FILE=y
> >> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
> >>   CONFIG_CLK=y
> >>   CONFIG_CLK_QCOM_QCM2290=y
> >>   CONFIG_CLK_QCOM_QCS404=y
> >>   CONFIG_CLK_QCOM_SDM845=y
> >> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> >> index e50b3bce5cdd..5b5ebbd844df 100644
> >> --- a/include/configs/qcom.h
> >> +++ b/include/configs/qcom.h
> >> @@ -10,12 +10,5 @@
> >>   #define __CONFIGS_SNAPDRAGON_H
> >>
> >>   #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> >>
> >> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
> >> -#define CFG_EXTRA_ENV_SETTINGS \
> >> -       "stdin=serial,button-kbd\0"     \
> >> -       "stdout=serial,vidconsole\0"    \
> >> -       "stderr=serial,vidconsole\0" \
> >> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> >> -
> >>   #endif
> >> --
> >> 2.45.0
> >>
>
> --
> // Caleb (they/them)
