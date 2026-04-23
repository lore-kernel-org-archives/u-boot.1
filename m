Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD778FF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4925E8425F;
	Sat, 25 Apr 2026 22:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lI+nyi01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4F484413; Sat, 25 Apr 2026 22:29:15 +0200 (CEST)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F0484099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-56f8c77ca6aso6123961e0c.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777148952; cv=none;
 d=google.com; s=arc-20240605;
 b=iZ2wQH7gbYxfbWHs+3HH3f2V2gcJe7r0m/AUOH906HkSgmtoV4dv0OJbWeTxfiJrso
 Ku8t6u3lnfT+Fii5A0BiqPLoXPhr8ec03zGVQu/OQBw6/tPK31CJ9fIkC4NmQdvoCDL6
 n9yGFnsGfh3PjdC/htHYa4LVqLgC6WDZiSbswJfZVZ4JQf5JaR1Yi74wpk7qnRq194bl
 oMkB1hMPyb//hnU11ka2inQzGUiRW8Xs87oy2mD8y4LAImuxnhsHy0f8ZXiU5kHAchT7
 0xymmdgwtwCx9KsASmLEFtMk+2dV3roD5MLB5bJSkVbirPv5WeOfv2ASh5aUlQkehLBQ
 SVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fk1BxS6YuCEhcq9QN4kYWYP+cfYP6zQjrQQY0dXSpck=;
 fh=k35IO2L1j89wb6y1sDvfp+bf1e6g8N/OsFBPLpxMlRg=;
 b=bi16qUSQtgNTEpsTGYK/okXToMZ52rVa/rC1p6rhSc1s8WDl3QwUXeVXiKBgRnauWl
 bJwqLkpC4YApdu27t4SdR9ccly4aqw0LYeEZhGI83WX7YkOI+mHVfP2sMeLt1cOCsfNo
 hHVnZjEnfMiVVGer/k+DXrsGaUTTtmojrzf8KO93eyavIv0Roy9etNf1t/j516upSHtL
 EhioACe4gMkXVIyGCnSeAVNdILIld5AbIyzrgLEcmkbWQ8M/7ywj5vjEwQQ2RscEAcok
 TZTr6uf7nTNn4tfXnTIsGwRpn5IumkN1BPfM2mt3cMuYkW56tAZnv2MCe/NPBC9llpIE
 HfRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777148952; x=1777753752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk1BxS6YuCEhcq9QN4kYWYP+cfYP6zQjrQQY0dXSpck=;
 b=lI+nyi01GrRuMgniIqrnzJm7FzU7Y8mg3e7K8O0pvE/M6Ftog8FhilHRfjH7bFz7sb
 e1vEdGGORLA55ApdqVbjt1qFZnz/70aNqRFdpYuTL7ODpyp/Twgij5kk9Dh0pM8eJfUt
 4aQOBZcDxasRdSvJWrEoHHJJl6hsCEUlBr4yIu+yx3XZlXKoEjoGb5akfidv8jDfkUHK
 33CyK85QutEtNjty/txode14+MqXNdJvMiK0LTkD1/ytNiDFgEwtJmgJon+wgyw5btuV
 Eihpyprbpxa+KKZuJKP3IKL4P8JFf27A4co5fr3NsRxxHwHY/3MS5xK4IoiMbJ4bg0O2
 uGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777148952; x=1777753752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fk1BxS6YuCEhcq9QN4kYWYP+cfYP6zQjrQQY0dXSpck=;
 b=MUgFB8DK/K89afBIyjTOyEDhZepdgmUIM5d/DLvD8z3AW6QQzv/lKThC3cEGAuxD2K
 aQcCptPouoOrDZiuWWrv7j3PUSDdVFcNSwhqujmEG+LBHIefuehG6SX30uLNNFQNrZG7
 Ms/8OMYaiezKAinz89gEn/lBc81aNwDXN8W0jBnxQfy7ekpVROHCeQ4cB2smXePVr2Qk
 7UM+8b5NGeophfpriryZSfHDW9c+Os2losbGmk5rCm07/hZWvXrvEoeQFn4Cg3vYlatX
 Q18091cO4p7FRoloRAvYPuLcyTHrLRZhwc72qKfckr3ztbJDSSk+1hsLQPxQRP8tyyG+
 MkBg==
X-Gm-Message-State: AOJu0YzV6PltCB6HDVBPeApwdj5GraUFTOHlgGahCWb8iziXC4pqKSM8
 YFs6DaLtO4tIx3JNj/pBdX+38U6bTwk2ZeibrNVfSax2Y+rfF1RGUerlsASq7e3+nzMc2Glzf6Q
 wiTlXL1281z+mRfdRjegO3nj/eDTEi0JHlmo/VT/Hlg==
X-Gm-Gg: AeBDieuvljyKXKjRdKy5V5O3LzCZvakMc4HwNccCh6ikk85QCdw9P7bd4hiLUmE3w7c
 zo8Wrbmke5xuXix4fM+fkVOquqEnVEYsuAXRUe5B45rON1rgI35hRc9hKo/Jr3tDdn63T9W8GdW
 RV4HK/v8IgaQOopV3r+AwvDZMv0/A/f1S0kiz5RJ2WUlP4jGgdispMO0XJbprdl/l57GG7BleDe
 G7kd+1C4PSeU1fkp3P/TZ0kA6/uWhiizEoRtEB1Wy3AiP2EgccEjw+6Gml7XcG6Nx5VVYQGIwl/
 QJXRK1FAe/rm3Ur9n4c=
X-Received: by 2002:a05:6808:894d:b0:479:ead7:2a53 with SMTP id
 5614622812f47-479ead745a7mr7895489b6e.11.1776946695012; Thu, 23 Apr 2026
 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260423080637.30006-1-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 23 Apr 2026 20:18:02 +0800
X-Gm-Features: AQROBzA1akF-CUsGspDVY_sLdM_y69DUEveVTJ5RI1Ldx9KtUTyy4avLuCdUtMI
Message-ID: <CAN7C2SAyU4nFoBNdO1S2NzX==CvzQja5h3NQGEjWwNZ3aUYO6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de
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

On Thu, Apr 23, 2026 at 4:06=E2=80=AFPM <alif.zakuan.yuslaimi@altera.com> w=
rote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria=
10 platform in U-Boot. The changes include:
>         1. Update MMU/dcache setup across Gen5/Arria10 using common drive=
r
>         2. Add ECC scrubbing support for Gen5/Arria10
>         3. Add DRAM size checking for Gen5/Arria10
>
> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM=
 boot (TFTP & ARM DS debugger).
> Tested on Arria10 devkit with RAM boot as well
>
> v1->v2:
> --------
> - ECC scrubbing, Gen5 DRAM size checking, and shared dram_bank_mmu_setup(=
) is set as optional via Kconfig and
>   defaulted on only for the reference Arria10/CycloneV boards to avoid SP=
L overflows on size-limited Gen5
>   defconfigs.
>
> History:
> --------
> [v1]: https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.195=
89-1-alif.zakuan.yuslaimi@altera.com/
>
> Alif Zakuan Yuslaimi (3):
>   arm: socfpga: Consolidate dram_bank_mmu_setup()
>   ddr: altera: gen5: Add DRAM size checking
>   ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>
>  arch/arm/mach-socfpga/Kconfig        | 21 +++++++
>  arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
>  arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
>  arch/arm/mach-socfpga/spl_a10.c      |  4 ++
>  arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
>  drivers/ddr/altera/Makefile          |  4 +-
>  drivers/ddr/altera/sdram_arria10.c   | 34 +++++------
>  drivers/ddr/altera/sdram_gen5.c      | 64 ++++++++++++++++++++-
>  drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
>  drivers/ddr/altera/sdram_soc32.h     | 15 +++++
>  10 files changed, 252 insertions(+), 49 deletions(-)
>  create mode 100644 drivers/ddr/altera/sdram_soc32.c
>  create mode 100644 drivers/ddr/altera/sdram_soc32.h
>
> --
> 2.43.7
>

Hi Alif,

Just a small question.
The size issue for the failed board in the last pipeline test is unsolvable=
?

Thanks,
Brian
