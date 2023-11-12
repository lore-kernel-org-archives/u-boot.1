Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4359AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613A587006;
	Sun, 12 Nov 2023 21:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fghL8Sy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727788744C; Sun, 12 Nov 2023 21:03:34 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670DB8749A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso4075375276.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819409; x=1700424209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WV/lN8k/W5GydWngAND9viXwzyKW4w3CIovT5iWBRqQ=;
 b=fghL8Sy5jS88U/u195cVKEFuVDrTUVwVACY56MEZhopsBUVbFn6eUM3DAhBp+E5SMQ
 k9b6OC66K+1HN1JlVqB2iygDjW+T1hbFTyCfTEOyqzocV62sioT/OzhSJIiYNnBnz+yl
 EA0qhESqExBRoMh6WBPHf8+EXk6VkvzmA3NWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819409; x=1700424209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WV/lN8k/W5GydWngAND9viXwzyKW4w3CIovT5iWBRqQ=;
 b=myFOpt1kn7giuGGIEiNKB6ofboQOuvBzAs0rAhC7BG9GOymmDeCF2nlSvMeZhl+5l6
 ltDani1CCfZlEWh+HRcZh11knjtEwUhCkoa76V+XfvqSvLbKbs3AZzN8qIlb9DL1U8lu
 eZ0rYaJv7A85eJNvHnX++L0Nk1XdlxX6z1o7JY3o2tLZaKBK8EtIfY9x0SwJ4pgo7tCK
 +ywKDiCtF0JFsdNCzeKFeG0eWP9zDvbFLTEd61LVwUqAXQ3oXwgSOcle6lb/xSeUjNlM
 FynQWAyXUFNnSrXEeYR+TG+zX1WsYllygPMeZ7v1TfwmXYyTS1ywAeqQJ/ANHWztHyNy
 qVYw==
X-Gm-Message-State: AOJu0Yxf917Br+8Xu/K0eYpK2MuuXxalymtTs7X7WXtWDqcS3FpqPmkx
 0MGER4IyFFhZOFhEXM1Id0ZsVgbV1poPAR8gr99VoZIM4urncaDDz/A=
X-Google-Smtp-Source: AGHT+IHvO0vzYaejimin6NSxm5GSBz457DQlheddIFZZDzBnElHLTyPXTqomV+zKprM7AUJnmgLCnNFqLJm7QSJrwc4=
X-Received: by 2002:a25:df95:0:b0:d9a:5244:32e5 with SMTP id
 w143-20020a25df95000000b00d9a524432e5mr5702206ybg.35.1699819408961; Sun, 12
 Nov 2023 12:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-5-sjg@chromium.org>
 <20231112180357.GD6601@bill-the-cat>
 <C8077CF5-6258-4699-9204-BB9B23F391A8@gmx.de>
In-Reply-To: <C8077CF5-6258-4699-9204-BB9B23F391A8@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:26 -0700
Message-ID: <CAPnjgZ3NBJ+Hgv8K3qPYef0176ohzGJ6qbT_qw0WeS_xECyy3Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi: Avoid using dm_scan_other()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom, Heinrich,

On Sun, 12 Nov 2023 at 12:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 12. November 2023 19:03:57 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Sun, Nov 12, 2023 at 08:58:05AM -0700, Simon Glass wrote:
> >> This function is defined by bootstd so using it precludes using that
> >> feature. Use the board_early_init_r() feature instead.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >>  configs/efi-x86_app64_defconfig | 1 +
> >>  lib/efi/efi_app.c               | 5 ++---
> >>  2 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
> >> index d6b6c3d82995..e6a62b30dd09 100644
> >> --- a/configs/efi-x86_app64_defconfig
> >> +++ b/configs/efi-x86_app64_defconfig
> >> @@ -17,6 +17,7 @@ CONFIG_USE_BOOTCOMMAND=y
> >>  CONFIG_BOOTCOMMAND="ext2load scsi 0:3 01000000 /boot/vmlinuz; zboot 01000000"
> >>  CONFIG_SYS_CONSOLE_INFO_QUIET=y
> >>  CONFIG_DISPLAY_BOARDINFO_LATE=y
> >> +CONFIG_BOARD_EARLY_INIT_R=y
> >>  CONFIG_HUSH_PARSER=y
> >>  CONFIG_SYS_PBSIZE=532
> >>  CONFIG_CMD_BOOTZ=y
> >> diff --git a/lib/efi/efi_app.c b/lib/efi/efi_app.c
> >> index c5eb816655ea..1bced775a4d0 100644
> >> --- a/lib/efi/efi_app.c
> >> +++ b/lib/efi/efi_app.c
> >> @@ -302,15 +302,14 @@ static int setup_block(void)
> >>  }
> >>
> >>  /**
> >> - * dm_scan_other() - Scan for UEFI devices that should be available to U-Boot
> >> + * board_early_init_r() - Scan for UEFI devices that should be available
> >>   *
> >>   * This sets up block devices within U-Boot for those found in UEFI. With this,
> >>   * U-Boot can access those devices
> >>   *
> >> - * @pre_reloc_only: true to only bind pre-relocation devices (ignored)
> >>   * Returns: 0 on success, -ve on error
> >>   */
> >> -int dm_scan_other(bool pre_reloc_only)
> >> +int board_early_init_r(void)
> >>  {
> >>      if (gd->flags & GD_FLG_RELOC) {
> >>              int ret;
> >
> >Should this file really be board/efi/efi-x86_app/something.c ? We don't

OK will fix.

>
> The EFI app should not be x86 specific.

Sure, but so far we don't have an ARM version.

>
> Best regards
>
> Heinrich
>
>
> >define this function outside of the board directory today. Or should we
> >just move the function as the rest of the code is used in other EFI
> >applications we build (or no, the hello world one is too simple to need
> >this) ? If all of that sounds too wrong-direction, can we use event
> >lists or something?
> >

Regards,
Simon
