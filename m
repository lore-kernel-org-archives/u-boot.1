Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FC4E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 07:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE7883AC5;
	Wed, 18 Feb 2026 08:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XnyQ0CX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAB383AC5; Wed, 18 Feb 2026 08:37:42 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21F483AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 08:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad62a294bso4851898d50.1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 23:37:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771400253; cv=none;
 d=google.com; s=arc-20240605;
 b=gttlZz4MhVEbkNiE+KviUQzlDkoC82AJ+vXQrjFtNbN03XYFe8/AIdNe0PIuLwzYSz
 7i8abxO1DeApkmYkI8wq27wlMBqAOW8z2sE0sMftk7PiWcrb/nS2os761WuzXUt+JTmg
 x+ss7f6tbz0X8M1SxxVxq7xKKDAeAPXrFttOvTBOa3L51PzdyyIRkGurk9gmMckrL17O
 6fpd09R7UuLPWM9gLnnEucFkH4JVrCwjtJoAfI0DiGIKb6MmMrEUy4zOymLaeHZDPoAY
 HaERPq8pBOWNBloYvayqc7VmK/muAZAADv12cVRri8R0QGEeNRWh1BM+rNY685KUxWuZ
 1DzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=N2oMQbH9rCW8sfFZ8F52Tv59sQzaIvXbkD5/d1KVaWY=;
 fh=DhEiqiGIkoJvFaHFSgdtXxl4bDyiAcW9Hu4vuZPB8SY=;
 b=YNNQ0yyKcDZF/DApxqqLuUCI0KKBN4CkZ1MRNFCT7wix2Ctty9OH0NfgvW29kP+7Gx
 pvadYEuMW8mIUjJoqKRfois+4txkZGIdrfvm78nztJGUe/RsZs3HyrSK/MngKiTR8gBz
 5b997VEEFuYnropRtA87vv62KBr9Sit8cuMLIN4mIDNvF4PocqtpOTJMPWlf7CWB6ing
 r+WB2MJtNDYqxarCmvL5fL5pnSOQLYXYWIyNGTkz3SxwBc1WmbotOjHXQuKHCByyr/D0
 YZuSQeEpHM9iW4J311CqCWz9JydTUsdfkUkm42PepD9B3KZb5sBfjqwZgoLq/vYwa1eb
 NX2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771400253; x=1772005053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N2oMQbH9rCW8sfFZ8F52Tv59sQzaIvXbkD5/d1KVaWY=;
 b=XnyQ0CX0k/Ji4ziijDtgivt6bAbU/49XjYrZIIvCfjmrp8ktDKoGP09p9qt/zAKZlM
 QKJe+VSOyTuYSh7hfdCwPtCxyvYhKi7tMdkXnz0nxJgfycI8E8ZcHWZdIfmeXL1HucPf
 hiKFOktzB0w/KZBqFFLMGkwgwcabYVw2Rx8TcAIPKNvsMTZJQU3/JRtO4pDFZz9rZoNR
 OUXfzdbEcloiDHfLqzVdhn++mLhbu72UFvz+zMWHaLcJZwtLkPxysUOsi4m8T7eCe7Ra
 FeggJuygQFRYMNBOcFhPl4WEbldQwLJ9i3ni07ZEKHJ2l8MLkgBYiveWazit8wmI5DvI
 7oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771400253; x=1772005053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2oMQbH9rCW8sfFZ8F52Tv59sQzaIvXbkD5/d1KVaWY=;
 b=nj1Xgh5o8ssxq+r0GvzkM3n9GZK6T3tShLoMPBnM5w3FeqQfwr2C2fh3VWrcADydN0
 lF5SbAq5x1M7baJmBLxfe5SSWeoPmzCnd68m+k7RtPb3L+M5SDQqJHYMzS0h8hRzcAOt
 6MThLDYRJ8yauDdznOeu+9kwYEOSg2E5xibFyWOfdQccoiHu3Bh8eH7qLI9FNpPcxB75
 +ykNqqcfTlB2CiGJsMQxnkqT4WeUQ8nBfqbebdTPEAGibzJG8QXwoaLMVqcfv61w941H
 Fd7VF/1IKBhBRaK/LucPPger9FDuSWAn7K2LbEIOowaW9V0yeAyXFwZy7vKxiprhge5G
 XrfA==
X-Gm-Message-State: AOJu0YzmpNGLFqjmE3sygIua2VTNXfo4KbXIYBSElx5Nh2VrF9XghYqU
 EAiryjV9hqZsTzKjeVVgOwx8jiCRQ3OJ05RXgUvSM5AjKEoAIT/Ogx6z69+FAqa9j1+KdqUwCgd
 P4o+B7Ze2Onx9O6k1faujwIuDfJjDJfD2bUqSlX3jbQ==
X-Gm-Gg: AZuq6aIqco5uuepxB7DfENusodG/CT3TTdKPGIQhaYsoiTD1X2FnEUHCuWqeEruVFum
 /zwMeFH0ZMgYy8DPiTwTB0o63tSNyVlOVZoThbVicegBFewGZy8Xd8d965uohdo0ppXW1HO8ZcX
 nMek3K6rJ0Ff+VyBshSCaPSvVR/RZUzKZQnHbV+WPRU2064IH+3sO33MSIoc37DE9FiSCsIipi9
 IbbKLyJZOBF17x8ee5go9764+zMeeWAjIbogoQHVDCr3hGNfpdQpR5bjLwYnYJNPEUIYAA3nqo7
 9UvzE59v3V3zQrVs5Q5XlN64iTT+CXwcWkn7KAipQZYz2nNnxC2wJ1B1nTqulBLH1qsKq/mw1XB
 8sQGVri5NlSLQFljYvdM4UANROb0WI8FnPA7srCHypIMaRsea7ZjjZX5sOExZVYjHvDDFYVcdtB
 grAOUPmU8ilOcqcpivXGwtv8KrMKTwgOyIcLFnh0/prFqGQ0ghEMt9fdHz8w02NsFXp2BbAthFZ
 p70Pr5fv4rzs8CBfE74kZrfXD6WrelPmWr1DF8i/c3ABTDWxiHAVOxdJQdUFHRt9ugR6/2uU8sQ
 yFe8QASrnXIDKh8MC6T6hL+nH/vp1CCAiAfDkp2AhLD1
X-Received: by 2002:a05:690e:118e:b0:63f:9fcb:2050 with SMTP id
 956f58d0204a3-64c21b27bf6mr9852574d50.50.1771400253362; Tue, 17 Feb 2026
 23:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjKzr_nYSJft_HbkHB+F5UKiPBr3sdEZ5vc=gTT-p+WFMA@mail.gmail.com>
 <174996d6-a4c2-4cf2-b25d-b59a9d7dd767@oss.qualcomm.com>
In-Reply-To: <174996d6-a4c2-4cf2-b25d-b59a9d7dd767@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Feb 2026 09:36:57 +0200
X-Gm-Features: AZwV_Qh23LmeO5bYkvTjHhj4Jyu6x6umViY2zf0O706mjLK6M7jUdSBFXvN8aqI
Message-ID: <CAC_iWjKZXsE86J_wJ=JTE0TGL=MqGm8YRYsq4BrkU2ba3me6OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org, 
 u-boot-qcom@groups.io, trini@konsulko.com, xypron.glpk@gmx.de, 
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com, 
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com, 
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org
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

[...]

> >> Changes in v2:
> >> - As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
> >> ---
> >>   drivers/firmware/psci.c | 4 ++--
> >>   lib/efi_loader/Kconfig  | 8 ++++++++
> >>   2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> >> index 2e3223e1c32..009c6153d0c 100644
> >> --- a/drivers/firmware/psci.c
> >> +++ b/drivers/firmware/psci.c
> >> @@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
> >>          uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
> >>   }
> >>
> >> -#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
> >> +#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
> >>   efi_status_t efi_reset_system_init(void)
> >>   {
> >>          do_psci_probe();
> >> @@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
> >>          while (1)
> >>                  ;
> >>   }
> >> -#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET) */
> >> +#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
> > You also have to adjust the RT config table in
> > lib/efi_loader/efi_runtime.c, but I really think we should reuse
> > EFI_HAVE_RUNTIME_RESET
> EFI_HAVE_RUNTIME_RESET is enabled by default & depends on PSCI_RESET config,
> So even if i disabled EFI_HAVE_RUNTIME_RESET  on defconfig it was
> overridden, since PSCI_RESET is enabled it was auto enabling it, hence
> introduced a new config CONFIG_EFI_PSCI_RESET_RUNTIME to control psci
> based EFI runtime reset control.

That's something we should change then. Having PSCI enabled doesn't
automatically mean you can have a runtime service for it.
Also this patch seems incorrect, since the EFI RT config table still
claims it support runtime resets, but it only uses the default
function.

In your setup should the firmware claim it supports runtime resets?

Thanks
/Ilias
>
> Thanks,
> Aswin
> >
> > Cheers
> > /Ilias
> >>   #ifdef CONFIG_PSCI_RESET
> >>   void reset_misc(void)
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index 13e44be1d06..3882de273bb 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -106,6 +106,14 @@ config EFI_HAVE_RUNTIME_RESET
> >>          depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
> >>                     SANDBOX || SYSRESET_SBI || SYSRESET_X86
> >>
> >> +config EFI_PSCI_RESET_RUNTIME
> >> +       bool "EFI Runtime PSCI Reset Support"
> >> +       default y if EFI_LOADER && PSCI_RESET
> >> +       depends on ARM_PSCI_FW
> >> +       help
> >> +         Enable PSCI-based reset implementation for EFI runtime services.
> >> +         This allows the OS to reset the system through EFI runtime calls.
> >> +
> >>   endmenu
> >>
> >>   menu "UEFI Variables"
> >> --
> >> 2.34.1
> >>
