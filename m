Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42355E99076
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 10:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67FB084099;
	Fri, 10 Apr 2026 12:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="abeQy5/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C748484105; Fri, 10 Apr 2026 12:11:08 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C93283DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 12:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9c01854477so308231766b.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 03:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775815866; cv=none;
 d=google.com; s=arc-20240605;
 b=UCka8jWqRTEWdmZMGyQsHVPXzrIt/2s0+rJODK35EwMKKA3ZXnsDWAECEdIMemiiyc
 YjZ4tri82xQ03/awnAI0N+bX9X4eidjPByux79avVWJElHvYZvcG4EAp6K0p4ZrFm/5w
 vqPu6WgwRb8aCBg6fnA1PZOEFisrOqcTcTe7+fPKSp41azjCFY/IofcvNGBNPsb4gUgK
 tQ85jOHnB5H9OhWcLo1xH3AZJyaox/OwWd6NwBXbS4ALoYYGMWH2WnA2esUgYELI5u1E
 r8BJvZwxcd9Y9sRW9c7QTSDCcAdEHu+KjIlVMDLk+LnJG/6ExdVU8n3mQ9WVSXLGCs13
 UOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
 fh=l7yysKdAExrxCUqLzFmRAfJ42xeBPQbhTaYcoW2dpPk=;
 b=T2M/+GnufSO8DGuhfA9mP5TEuz/cDV5abWzRQGK3l2H1iSs1KqewvV9Sl1Y9fBZCLU
 h4nm0nUJ3xzH/7A3Dpm8e0mEIv9tD9z+hPBn/ZH5En6PJ/CqTMIzGf19FQ143AkQN6Lu
 8QcNtKzjz4CwC1J57SaoGeamAKmul3AH72g6/KVxcmNETcaXaidYpyaJKxnTLCSJPG89
 EJRiys7FMzpdbJqyw7/FiZlmjGPiWGePtffzukNjEW51CwoZSE6FiBagouA7OXfuWZ+6
 jSpWAtIsVMRogDFVUxwGQbCveu8nwgbRjzGGzv3fQOZJT5xRtFvTmYh/U+TUvQiDUNxj
 RX2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775815866; x=1776420666; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
 b=abeQy5/sFKjI+oSnYHctnRyno112QCEq3wfC6S4z/2JCFRjFDOwpWWaSUr7r2Brf8o
 SKk0v4M/CvuJBw47stOyjJl44X9gTRTxLK5f0AqAxBg3GCG4KMMlWJd90TPbyhFYZNcj
 MtvRQYxWf/S1iGf8Si/n6UpzWn6LLT7/iPVp0yqo7ZVfJn/oA4I0O+zgE7Nom4TV1Zmm
 Dgr2zjpxXE9HpzdCRMm4Zm7aFQe5mqatTq9YcuSHHxEDAqcErbA9dnDUfzHaqIr+WDUp
 usKRwp3McgTzUCAguYPM0Yl8jdCpyhKkmZ62LED5Z3RsnbAq/XnC8gvZbNYAsXjY4VqV
 nSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775815866; x=1776420666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JI9MPqZe/XsUWHnvAdpwMk+syRqJB2KyqIeJUkQFlWE=;
 b=ZoqLHf2qbKeu46/RH3mmPeINM7le6snSKfGte2PHlek9jEMltT8C9SsDVTgWQWMWHo
 UNByhbVk+ZqAEcWvBtKCBKPJ6NOMsTeS5chI+7TosKBkdwY/j3Cf0CAWLF5g6fVPaluU
 04dRSb2IhdBiuQAMhCrTGw+yfY7z+ap6pffAnS4cKQnuLqTRWWL05nFLGW81z3D89OXo
 YyMVwvRkKW0UuNuATcZ/JUZikByIs9KNrTqFthRCRRkTPM8eF5mFqyyZoJ5FogdTdenE
 Q9mq0vOBi7+Zhppy+CCVRw/6Cytdurq2R3I6pQSAFgHiujzKw4pCLIBMI1HERb5ReLjT
 w+1A==
X-Gm-Message-State: AOJu0YyAMX3e/E3S8ZgRz0CDBr6TY2MDbpUMK25tJSBil/IDn0Mc9KVW
 IUAxyonfONH4Pm0DUDNmTGdlQcFt+B0wa1+mr1Zu/0YlPdduN4VtnrilPv8qZ6yj1PsJOfOSUXW
 2JuXLIxkdYnLv00oroa06ajAd8lgeFyXSJg7/
X-Gm-Gg: AeBDiesjtrigkRhy5/VJlOJC8tt0c/DRjTUwalT+mMG/ZlTMVw5M6lNvwyLy4RhtI6/
 uXgy0P1TONqYdO7bXH2rr2ckrkjQP/sBI24hrVzo5oQxZOBCdvxrH9CgGWKuMgA+EnuZ521rGiv
 WGc7bOhJv5DLJAhgPJ2GvrTOAFKqjOtjU70RnK+zSKy3SGTN4VJh+/G6/j1aZrVGau4hr36P4Oh
 joKL7A6DooRklz/pJU95tjrcDilqv46A4/wOfBgyX0VAdvjQfrogpQIqpEfIVSahdSnGh4Kj9pI
 I3e0aw==
X-Received: by 2002:a17:907:2d89:b0:b9d:8697:73ad with SMTP id
 a640c23a62f3a-b9d86977702mr92740166b.26.1775815865367; Fri, 10 Apr 2026
 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 10 Apr 2026 15:40:48 +0530
X-Gm-Features: AQROBzBMFysIRYGQff-xMaTKxZCOgrIUq-ZXogZbNmvViQGIf9QVzVRuppW4pQ0
Message-ID: <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: u-boot-amlogic@groups.io, funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi  Ferass,

On Thu, 9 Apr 2026 at 02:00, Ferass El Hafidi via groups.io
<funderscore=3Dpostmarketos.org@groups.io> wrote:
>
> Mostly everything is already in place to enable EFI capsules and in parti=
cular
> EFI capsule on disk.
>
> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> functionality expects sysreset to be present. As the current reset_cpu()
> function in board-common.c is basically only doing PSCI reset on U-Boot
> proper, we can replace it with sysreset's PSCI support, which works just
> fine for that purpose provided BL31 is running (SPL stays on an
> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> sysreset is too high and we don't have PSCI yet at that point).
>
> Then we can enable capsule on disk. LaFrite has Capsule updates enabled
> already, so it is simply a matter of enabling CoD. LePotato does not
> have Capsule updates enabled by default, however it can be easily enabled
> and setup to update u-boot on eMMC/SD.
>
> With Capsule on Disk setup, it becomes possible to update U-Boot directly
> from Linux, without having to worry about manually using `flashprog`
> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> can be handled by `fwupd` and applied upon next EFI boot.
>
> To test:
>
>  * build U-Boot as usual
>
>  * in that running U-Boot, run: `efidebug capsule esrt` to get the GUID
>    -OR-
>    run the following in your tree:
>         tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESON_M=
MC
>                                            (or U_BOOT_MESON_SPI on LaFrit=
e)
>
>  * proceed with the following guide to create a capsule file:
>    https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-uefi=
-capsule-update-feature
>
>  * generate a .cab file suitable for fwupd using `mkcab`:
>    https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/mkc=
ab
>         mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc "Le=
Potato" 2026.04
>    (as of writing, the README.md suggests this is for Qualcomm only. It
>     actually does nothing that is Qualcomm-specific, and works on any
>     board that supports Capsule on Disk and fwupd)
>
>  * on the board itself, boot to Linux via EFI, install fwupd, copy the re=
sulting
>    .cab file, and run as root:
>         fwupdtool --force install u-boot-libretech-cc.cab
>
>  * reboot, make sure you boot over EFI, else the capsule update will not
>    start
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
Thanks for your work.

I haven't tested the EFI portion yet, but I have a few questions regarding
the previous commit 17d80a3b326e ("arm: meson: spl: add support for
SPL DRAM init").
Could you please clarify how you generated the Meson DRAM timing parameters=
?

I=E2=80=99m curious about the boot flow since we can apparently boot U-Boot=
 without
the Amlogic-signed BL1 firmware.

I just wanted to understand how to upstream U-Boot for the Meson8b (Odroid =
C1+)
platform, as it=E2=80=99s currently stuck on a very old version (v2011). It=
's
ARM 32-bit.

Thanks
-Anand


> ---
> Ferass El Hafidi (4):
>       arm: mach-meson: move reset_cpu to spl only
>       arm: meson: enable SYSRESET_PSCI
>       configs: libretech-ac_defconfig: enable EFI Capsule on Disk
>       configs: libretech-cc_defconfig: enable EFI Capsule on Disk
>
>  arch/arm/mach-meson/Kconfig        |  2 ++
>  arch/arm/mach-meson/board-common.c | 14 --------------
>  arch/arm/mach-meson/spl.c          | 10 ++++++++++
>  configs/libretech-ac_defconfig     |  1 +
>  configs/libretech-cc_defconfig     |  4 ++++
>  5 files changed, 17 insertions(+), 14 deletions(-)
> ---
> base-commit: 4dc4080805fac1b1ed7606ce3bc8fb44a6d59d5e
> change-id: 20260408-b4-amlogic-sysreset-capsules-8f5962defafb
>
> Best regards,
> --
> Ferass El Hafidi <funderscore@postmarketos.org>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2952): https://groups.io/g/u-boot-amlogic/message/295=
2
> Mute This Topic: https://groups.io/mt/118732104/6056667
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [linux.amoon@gmail.=
com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
