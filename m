Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB1AC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 12:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 174518826B;
	Fri, 21 Jun 2024 14:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PF4TumTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD4A8826B; Fri, 21 Jun 2024 14:19:32 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAB6488013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 14:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d35f1dfda2so996441b6e.3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718972368; x=1719577168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+BwfE+MOXR96dYX7kJQiFTMofSu1RVi4H3sn4SLaIYg=;
 b=PF4TumTgAR+oQEMIq23+YGNVoejMbb4L1iGq/ouG8MMNLhMzmgA32VtJPuCEhcItEK
 xKNsV6rFpn6zbg+SsGXdj49mCe5tVtOr72H+FPbU48YHWV2wFzB2wIrFR3wuRvM65MV0
 kxN8V0bvvd7wytxOvPwDZ8I5/npP2cErpdGWgZ4RMCczjY7A8J1rwc1u/QAWitAj6bvQ
 oeQlhovoiXj4DKqrcfa3YbmR69C9PabWMZJbHLBEPz1PG2gWADbTImogasT4bQ7lMq1W
 3XCJphKWvZQAu8oczzo5zYLYxuIokauVLNX9W0F11pBJQvJScsbYf6botUqdq/fNZVjA
 psSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718972368; x=1719577168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+BwfE+MOXR96dYX7kJQiFTMofSu1RVi4H3sn4SLaIYg=;
 b=kceGPHs7Xup3TSXCdS8eM5+oZ7ejxSbKAaUifT5UkaBJenVfwg5KPGve7Y7n/dXjIl
 uN2kK/QpNkJ6IVJPz3K3UkBeE+xze5bo29OBSbq7Pf+eNaIH8oEpMVMH81FBS6p8E5Gl
 9LsG8P5wUzVTgz+gOXj3x1D2CbFWFF3YVbJdnUMPBqmd89NiSRuX39ZwTvikJ2KAAIt2
 EeRljj6rYej/pwyBdc5kAecEp8KHma0bgAdjHCe91rw6ZM3Oym2mlVhLVH0BcnGOa4zE
 xj5+Ff3RLdVrqN0shfWEkadKvSv/mg3ZXizgFPTo4atORJUNx1s52kqtQvRGwDPKsmkk
 q08A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcf9NlVGFmmGLoFleZDEPWLQXaMWaDrGRK7UY9puJ4I3hDEzyuhTw/j8wnhMFNsbLxs5wDMHIzh06dVC6kIhC8VGFsUg==
X-Gm-Message-State: AOJu0Yyf1I8fII1umfwkfED8wazvl72j5+bLNLU89nK6iWWWmLeBP4IK
 uvnCtloEiz5IKpsgPkGM/292qvJZ5Ocf7V39XNrlivFn4FXAoAN3aPfo7QONsjVRtuLUzupoPnt
 BRGQKERPgXHYDDXgeV/NwtFrxSWT8z+eTWliK2Q==
X-Google-Smtp-Source: AGHT+IH6aMZIUKr3eTsVQEHTd9Y2/HCyk9ZqGTp5Ha0rSpZ55vqY65T9ow+3N47RFgbd+nRzCE9378WU3iDzKOUsFDw=
X-Received: by 2002:a05:6808:13d1:b0:3d1:d3f6:455a with SMTP id
 5614622812f47-3d51b9c9eb1mr8662923b6e.20.1718972368403; Fri, 21 Jun 2024
 05:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240617085629.1744017-1-caleb.connolly@linaro.org>
 <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
 <d64e6ce3-0bc5-4175-af7c-6146d4402c60@linaro.org>
 <CAFA6WYOZjm6akShXbL2UG+Cs=CAxZAmdG+WkiVt=KESOvvbc+g@mail.gmail.com>
 <ceba95fe-32d4-4bbc-99e7-b76fed9ebb2a@linaro.org>
In-Reply-To: <ceba95fe-32d4-4bbc-99e7-b76fed9ebb2a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Jun 2024 17:49:16 +0530
Message-ID: <CAFA6WYOVReocckDmw0CAWbt=WqbnP-0XT2V5NOKpB_PqnEKKfw@mail.gmail.com>
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

On Fri, 21 Jun 2024 at 15:14, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 21/06/2024 10:07, Sumit Garg wrote:
> > On Fri, 21 Jun 2024 at 13:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 21/06/2024 09:35, Sumit Garg wrote:
> >>> Hi Caleb,
> >>>
> >>> On Mon, 17 Jun 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
> >>>> environment to a file under board/qualcomm.
> >>>>
> >>>> This is much cleaner and means we don't need to recompile on changing
> >>>> the environment.
> >>>>
> >>>> Additionally, extend the environment to include a boot menu and
> >>>> auto-boot using EFI instead of bootm. Since we now support MMC and USB
> >>>> on most platforms, these are much more useful defaults.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>>    board/qualcomm/default.env | 12 ++++++++++++
> >>>>    configs/qcom_defconfig     |  2 ++
> >>>>    include/configs/qcom.h     |  7 -------
> >>>>    3 files changed, 14 insertions(+), 7 deletions(-)
> >>>>    create mode 100644 board/qualcomm/default.env
> >>>>
> >>>> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
> >>>> new file mode 100644
> >>>> index 000000000000..243aede77be7
> >>>> --- /dev/null
> >>>> +++ b/board/qualcomm/default.env
> >>>> @@ -0,0 +1,12 @@
> >>>> +stdin=serial,button-kbd
> >>>> +stdout=serial,vidconsole
> >>>> +stderr=serial,vidconsole
> >>>> +bootfile=/extlinux/extlinux.conf
> >>>
> >>> Is this file used to perform EFI boot or is it redundantly copied from
> >>> somewhere?
> >>
> >> This is here because there's a bunch of codepaths in U-Boot that
> >> implicitly expect the bootfile environment variable to have something
> >> useful in. It stops a whole class of null pointer exceptions.
> >>
> >> extlinux isn't used for EFI booting, but it's supported, and having a
> >> sensible default here is nice-to-have regardless.
> >
> > extlinux is a different boot method as compared to EFI, so it looks
> > confusing to use extlinux as default when we want EFI to be the
> > default. AFAICS, bootfile simply means the file to load and boot which
> > makes it more suitable for Linux image ("Image") to be the default
> > option.
>
> Image? Why not Image.gz, vmlinuz, or vmlinuz.efi?
>
> The value is meaningless, since all this does is stop U-Boot crashing if
> you run some commands without arguments.
>
> The only times I've ever encountered bootfile has been in pxe or
> something related, where extlinux.conf was expected. Obviously this is a
> heavily overloaded variable...
>
> Maybe I should just leave it unset to encourage folks to fix more of
> those unchecked accesses...

That was my original suggestion too, drop it and feel free to keep a
review tag with that.

-Sumit

>
> I don't think changing this to Image would be any more sensible than its
> current value.
> >
> > With that change, feel free to add
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > -Sumit
> >
> >>
> >> Kind regards,
> >>>
> >>> -Sumit
> >>>
> >>>> +preboot=scsi scan; usb start
> >>>> +fastboot=fastboot -l $fastboot_addr_r usb 0
> >>>> +do_boot=bootefi bootmgr
> >>>> +bootmenu_0=Boot first available device=run do_boot
> >>>> +bootmenu_1=Enable fastboot mode=run fastboot
> >>>> +bootmenu_2=Reset device=reset
> >>>> +menucmd=bootmenu
> >>>> +bootcmd=run do_boot
> >>>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> >>>> index 80ad3b32e139..a9e3797bb39a 100644
> >>>> --- a/configs/qcom_defconfig
> >>>> +++ b/configs/qcom_defconfig
> >>>> @@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
> >>>>    CONFIG_CMD_LOG=y
> >>>>    CONFIG_OF_LIVE=y
> >>>>    CONFIG_OF_BOARD_SETUP=y
> >>>>    CONFIG_BUTTON_QCOM_PMIC=y
> >>>> +CONFIG_USE_DEFAULT_ENV_FILE=y
> >>>> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
> >>>>    CONFIG_CLK=y
> >>>>    CONFIG_CLK_QCOM_QCM2290=y
> >>>>    CONFIG_CLK_QCOM_QCS404=y
> >>>>    CONFIG_CLK_QCOM_SDM845=y
> >>>> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
> >>>> index e50b3bce5cdd..5b5ebbd844df 100644
> >>>> --- a/include/configs/qcom.h
> >>>> +++ b/include/configs/qcom.h
> >>>> @@ -10,12 +10,5 @@
> >>>>    #define __CONFIGS_SNAPDRAGON_H
> >>>>
> >>>>    #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
> >>>>
> >>>> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
> >>>> -#define CFG_EXTRA_ENV_SETTINGS \
> >>>> -       "stdin=serial,button-kbd\0"     \
> >>>> -       "stdout=serial,vidconsole\0"    \
> >>>> -       "stderr=serial,vidconsole\0" \
> >>>> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
> >>>> -
> >>>>    #endif
> >>>> --
> >>>> 2.45.0
> >>>>
> >>
> >> --
> >> // Caleb (they/them)
>
> --
> // Caleb (they/them)
