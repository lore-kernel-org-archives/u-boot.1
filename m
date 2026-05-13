Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AECCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 06:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD60C83EEF;
	Wed, 13 May 2026 08:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H7KM/M8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FE383E36; Wed, 13 May 2026 08:36:26 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FA38341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 08:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-65dead17c24so1328588d50.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 23:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654180; cv=none;
 d=google.com; s=arc-20240605;
 b=QdRqZJH6c9kfSFKhqUFit3o6tzCcjiNoRXKe+9fjCmY+SVZj1X4AwA8AypeTMCfIhs
 rSoSAqwayWrvyv1fvpNfsH3FmbIA7fyvRtf8Mz4V/LCezOoHBuR5bus60vzCce/V/Yzr
 l/xdja+ySQdBvljC3rcueaAm3Vm0yPnUqqA5f7fK1fXwdAx1d5y7xuuQk83mRLpIczg/
 nESQUDJrlVMy3I7KJEy0Y1UjWyGiobUjqm4ZkODfKcsQ+J97QKiSE8YLd1g4TgJhl21z
 WcOM+wbsSlNDvwW6HUPfme+GYJJSW549RlUo0J4I3wqHTLjAr2lhGjWz796BuE5FZimi
 iVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2xqGiqCRx38IL7/O/Fo0X4A/qNgzAEwzP3CMcuAEfDU=;
 fh=gT0QuHFpj2YqfYVLxDV+1XeIFSSKLinxBCxfZQRgcRM=;
 b=P4TMB5X77xTmBo38ply3aTuem4RQvUa0B7VwOpv7ywT48Jr4rXnesCK4MK4k+pgEHu
 8eQLmerwjkWN3pH6xCNS78BOSg8Tf8R6RNTVef1Zdojbt6+Sc7ZcUANHEglL8/j4XKWD
 BD27VLfNTqdqkjeKDCQ0Af3pzbsMqZZadduMBb7qVtDw22DvOHLZaciNG/AtlNY2oDm2
 JLqFrJPJ8uAGYYOqMBl8l46J5kaeU00nb3AcZux0PTIyx99WDAFiiC1986bTmxxWhCsP
 WOBdU4JT5QnK5zppB9RDWKGGxW6UrQFxgwjwkLwzNDqTsBqyaS1xWUGzk4kCwoPl26nG
 QAWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778654180; x=1779258980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2xqGiqCRx38IL7/O/Fo0X4A/qNgzAEwzP3CMcuAEfDU=;
 b=H7KM/M8Wt7uNKRiSXNy3ygkr7WIwtcCJtSOOHHtk9u1QzBMk9r0HQf8d5g871C4BQE
 FUC8Fm2MBl/D2GUrqOIKRI8wQ8TTSe1XF7G3+JG61UHYx4WzrkL147ITvgYNcoPEWXSm
 g2tnBE3yF+IEEp1ype3DjKnjR4YPtzado3dCf94z+o++YKdMXZDOzA7HzjdJTmT8Iev7
 OVNgVxJB1adW0JXE5sls/2Mk2eajPw7Iftyrz/NAdrgG2RxDYMnNlBwndy/n/7Bg1enB
 zfZaoGOgLq1HOL1o7tx0Qk42ZsRcNq7uoCWsP1QxgKUm9NCPZXUiKQR4yrNeWqbfUY/V
 +vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778654180; x=1779258980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xqGiqCRx38IL7/O/Fo0X4A/qNgzAEwzP3CMcuAEfDU=;
 b=AmBNzzqX+NdVo1ZbhcO3EohB+t75rHitzEcnKPonGLywdHuaAP/KjjiKcAf6FOlLgZ
 gPE0aw1NHopYNi1q+njwAgPGSqcshGeg5Utlm7E30cb4rbxrxDdhIctOIgaMPIumFcRw
 qrpciPhInB92rTuhnOdSebp3YyhaS+/zxnjC1UTqcHsIHJHlUNMHi6HxYq9ILxEFPBcO
 cBxjfqxmw330+7qSconPn6TO5DwiAB547bLHoy3l+AkZcLO0gg0yhhsdLoHg73EAkvxQ
 i8s1/oiJoTLoEEgV43zEO2i6HO40OpO7z/cFxtJUhlh1GzYGwqtk+I3YF3VeAgew1fUT
 E/KA==
X-Gm-Message-State: AOJu0YyzwW9EF66dgMTv17UfVtukjurge/ixfx1wh4N2Z1Shl+VnkYhf
 A8iOcKSsbfzb6a4NHaakezwRuz+aKHspWp78p+1Gal1HykmYkcpw2K6p1slikXSaDqPvXKyHo7B
 rLzLwmICVyeRG5wLop7/6ugovb6VpRz7tdcu9evZSMA==
X-Gm-Gg: Acq92OFBaNfvS/auHF5DVMzIHzIIAGXodqXzRD8fXnT9vtPd3IUdzdgNeQ2axz76bYM
 5cSPb7rDysUSMadh7iHRT7NuPu/Ij32o7Lgip6BltpodCIyoF3zQBMjXOtvIPMRvXl820SzFxE7
 fX/CSjeL/ZBaBF2HCTmz2UpsG9Np+ODOWglYSxWfFFxR/rb+oSjrERs9Xlr6ypocMY7DzV9FucL
 EsHb2ZzVnA2dk8SohhnBFXgqO1IOf3NbjFr+jCX+gF+sKsKhhRkr97PKJYB8Ga+xURPi7Q70jJX
 yag+Yi2rbqcLONVgzfHhbikPMnPL4UMmdvcUCLTegHiqCxCVs7taYkg/4ho7B12AnZHK7AO4tp9
 /uhh1QFHhj/LrzH95sfuS8tkzyzfs8eEVF5D5xSClyZleubIV01IuDLcZGw7R08b65a/Qquar1l
 kIlOL0wsrCw0DkqJIz8eVS7jxAzRknmiK1cx8qVJEPkjaDtvZo52pQwcpEkqO5/tJZs90K9jjXY
 dSGLu3a8QIk94+rQ1MRlv+da0wbZSk39Xi69ovSoiniX5Qmx55Pg0rjI/G+RHpq0zm97++AgF3V
 PxNbxbAV3CKgbgCEPvdO0SGFDVwif/DbuOZCi9UpBX9ZdAz48LHQ+RpBteeWkBCZLqvgGMMLFdc
 AF+6lkw==
X-Received: by 2002:a05:690e:4804:b0:65c:ca50:d7 with SMTP id
 956f58d0204a3-65df6358169mr1110151d50.49.1778654180422; Tue, 12 May 2026
 23:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1778619453.git.aidan@wolfssl.com>
In-Reply-To: <cover.1778619453.git.aidan@wolfssl.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 09:35:44 +0300
X-Gm-Features: AVHnY4L53PDUtMIZL5Hdh9faiQgCk0NsqJcV90fmhmaywtVEFLs6_dH3kghzPN8
Message-ID: <CAC_iWjKGzwsb88AEx=Q5nibTnqpMf0j-tFxaPsjKrpmGfUCpiA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] tpm: Add wolfTPM library support for TPM 2.0
To: Aidan Garske <aidan@wolfssl.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 David Garske <david@wolfssl.com>
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

Hi Aidan

On Wed, 13 May 2026 at 03:26, Aidan Garske <aidan@wolfssl.com> wrote:
>
> Hi all,

Thanks for all the efforts. Unfortunaltely I don't think we can pick
any of these up. WolfTPM is listed as GPLv3, which is incompatible
with U-Boot [0]. Tom am I misunderstanding any of this?

>
> This is v4 of the wolfTPM TPM 2.0 stack integration for U-Boot.
>
> What this series does
> ---------------------
>
> wolfTPM (https://github.com/wolfSSL/wolfTPM) is a portable TPM 2.0
> library that provides a full TPM 2.0 command set, an SPI/MMIO HAL,
> and firmware-update support for Infineon SLB9672/SLB9673 hardware.
> This series wires it into U-Boot as an *optional* alternative
> backend behind the existing 'tpm2' command, plus the supporting
> infrastructure to make it run on QEMU+swtpm, sandbox, and real
> Raspberry Pi 4 + Infineon SLB9672 hardware.
>
> Why a second TPM backend
> ------------------------
>
> U-Boot already has a working TPM 2.0 stack and Peter Robinson asked
> in v3 review what value this brings. The honest answer is:
>
>  1. Firmware update support for Infineon SLB9672/SLB9673.  The
>     existing U-Boot TPM 2.0 stack has no firmware-update command;
>     wolfTPM provides the manifest+image flashing flow used by
>     Infineon's recovery / security-patch tooling.  This is the
>     primary "why now" reason for boards shipping Infineon TPM HATs
>     where the field-updatable firmware is part of the supported
>     lifecycle.
>
>  2. Optional native SPI HAL.  The wolfTPM library can talk to a TPM
>     via either (a) U-Boot's existing TPM driver model (the
>     WOLFTPM_LINUX_DEV path; this is what QEMU+swtpm uses in this
>     series) or (b) its own SPI HAL bypassing driver model.  Path (b)
>     is what lets the BCM2835/BCM2711 driver in patch 3 talk straight
>     to the Infineon HAT on a stock Pi 4 without needing the broader
>     TPM uclass machinery.
>
>  3. Backend selection is a Kconfig switch; CONFIG_TPM_WOLF is
>     default-off and 'tpm2' continues to dispatch to the existing
>     backend unless the user opts in.  No defconfig in tree turns
>     this on today except the new rpi_4_wolftpm one this series adds.
>
> Maintenance
> -----------
>
> wolfTPM is imported as a git subtree under lib/wolftpm (mirroring
> how lib/mbedtls, lib/lwip and dts/upstream are maintained in tree),
> and tools/update-subtree.sh knows about it.  Updates flow through
> the standard `git subtree pull` path, not as separate patches.
>
> Note on license: github.com/wolfSSL/wolfTPM currently shows GPL-3.0
> in its repo badge.  wolfSSL is working on a GPLv2-compatible release
> for upstreaming purposes; this series is being sent now to get
> review on the integration shape, with the understanding that the
> license question is being addressed separately by wolfSSL before
> this is appropriate to merge.  I will follow up on the list when
> that's resolved.
>
> Changes since v3
> ----------------
>
> Addressing review from Peter Robinson on v3:
>
>  - SPI driver copyright attribution fixed to credit the original
>    Linux kernel authors (Chris Boot, Stephen Warren, Martin Sperl)
>    the U-Boot driver is ported from.  The driver is still in this
>    series rather than split off, because nothing else in the tree
>    uses it yet and decoupling it would just create a "blocked on"
>    dependency chain; if reviewers prefer it split, happy to do that
>    in v5.
>  - rpi_4_defconfig is no longer modified.  v3 added CONFIG_LOG /
>    LOGLEVEL=7 / UNIT_TEST / CONSOLE_RECORD / HEXDUMP to it - that
>    was wrong, it's not what the average RPi user wants.  Instead,
>    v4 adds a *new* rpi_4_wolftpm_defconfig that enables only the
>    bits a wolfTPM user actually needs (SPI + TPM + wolfTPM).  No
>    debug / unit-test pollution.  Users who don't want wolfTPM
>    continue to use rpi_4_defconfig untouched.
>  - The TPM device-tree node for the SLB9670/9672 on RPi 4 has been
>    moved out of bcm2711-rpi-4-b.dts (which is Linux-derived and
>    should match upstream) and into bcm2711-rpi-4-b-u-boot.dtsi
>    (which is the U-Boot convention for U-Boot-only DT additions).
>    This means SystemReady firmware-provided FDTs and the upstream
>    Linux DT are no longer polluted by this series.
>  - DT changes are now split into three per-device commits (RPi4,
>    QEMU arm64, sandbox) instead of one combined commit.
>  - Commit messages rewritten to explain *why* the change is being
>    made, not just *what* configs are set.
>


[...]

[0] https://github.com/wolfSSL/wolfTPM/blob/master/LICENSE

Thanks
/Ilias
