Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4147FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5C2849B2;
	Tue,  5 May 2026 17:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXrnuyFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B324884951; Tue,  5 May 2026 16:03:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCB7848FC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 16:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67b6dc50b61so7908406a12.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 07:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989782; cv=none;
 d=google.com; s=arc-20240605;
 b=F4PUOxaUGT9hETO9GEEK3eg7GlPtQ64tztPrS1owNnmSSTLf7cGS32b7yVuyCJGcMI
 Z+54kw2TAc2HIlsSPuFY4eU3Ln7YqiNLkzA9JOyh/Cs7eXQE69ouTA8th7WTQtN9VMjn
 6kmn8/JOxwJjiZayzJOXOy0+Is45w/BtOv2ElxrcqDl1wAdsykVqWfPad/LP/ej7JvIM
 Rzq/9X6OlglYkorKDdzD/ZwEUA961G6Y9Sw+kwlbH/bqFqMFkd2OSgIXpN03NzpEk/uU
 /jUycWt+6K1hps9BIrTlpKoRsDLzDP66hyC8kotSuXTWkbM9TFYAJTXOoTCryybOp/1X
 c/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=haSFuehn0ABHCYtrugr8FASxi3N5CreEL6jHMKo4DMA=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=AXvF1vQtNXI7C565/K7PFw4troEcirSw8R2bqFdFBCqRmf4AsaErwYVGSzFdnbZ/9a
 b8jYkrt5hVuZGTPUxO8SBRBoiUIHvkbPZS9vtLJObcPbkHUynlFZjRncaGe6zcZpoF8W
 kKAHOp8Ux2UTtM/VeiGjLaKNPQIWyF/JoP4ldD0sjQVtgUleny9EIzFD5jsfvfF+mFw8
 /nG5zv43Sp8zt4HP+8QjB1FOvOmr5WNCfBOdQeuRUjTgt7Q8Vx1twxGcniNm3mjuJ+aQ
 ajlKwv7UvsnqCzKVrvfRl/jXY7Ba/WMcsHYdOtHoS8MXpWo2XmIvh9fq+AxfVSKR+b2x
 6qDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777989782; x=1778594582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=haSFuehn0ABHCYtrugr8FASxi3N5CreEL6jHMKo4DMA=;
 b=LXrnuyFRu8FRIw8KzF1wS/+n/34T8ItGl+ewrzxziBeAiIWjuPUzot01/A0CEkuvpD
 4V5CzLMY4H1Ed6h8FVYoohG046vR2KGV/ODSX5gXiSKQw36nqa1N+8Knng7Ed7IhAuJ8
 utBlC81kj/NO+96K04UMKG00R5/nEqFoijw6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989782; x=1778594582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haSFuehn0ABHCYtrugr8FASxi3N5CreEL6jHMKo4DMA=;
 b=VtVMr2UPWewMn/z20l7tceOU+jFSNLfnNLcd6ODyPCYP0PYRMiKG5omLs7++7B+5Ea
 2/klzFAOjOwemQnr7wVR5Rvn2mXQG2oU3UmIIJLEEcIMMKKcNQ7rfE+kWnkZrjYQ29qX
 JFgpGiZa7yIZQsDq0QEPNzXuLBfbl9pfVLO4LhS+Lw9gRJbQRUsQdM2VtRFCFLB4Tg46
 +f85R0eTnY0Y/iYVAMhVEtzGyqNvtkJV+wOEInGtMo/DGTA5KrumHSJ+9QjPorUXhx35
 1DKplhSU+m1qld8fAPYxn+ZKkY2hnFWFjMv+PBwohbbkxFdai4bsYft68BXQQatslGLE
 ttjg==
X-Gm-Message-State: AOJu0Yw9pmg/yXLtix7PsqcL6AErrjoM2LUueMwmgWs2f+/xjwSCp3pC
 uN3/Sf1Sucfi/FhrbDAkQYAnVXiRWno9VRMFJRZSfsakFv0NKWBid6BDBFsVEn7Zj61AFxVYbbP
 uOp0BmaMtbJ6LtwqqFKG7IGwPp9Sndl9sPkC0/8R4
X-Gm-Gg: AeBDievQ1uG7yxEWjCITjBapojdY90twj92ra1TOouDmhD6712NgujuBT192M3tvIYl
 1EQ16tSHaY30uT/hokOvfu6xCrBdYJ0ego3MZW6/CfqpR+FJF5lypuNvtrJKixnSwWHKPVxBzZX
 OoQunfQ33mPvcT6AtCDV+i/UOfaQ1ebKZS+0TdbnzyC1tSa/4gwcC4cg6Y3PuzEo8c9X0FODTwC
 H2AUOJImgu5qX5Al84I8of7DqTwYh7tSgXtp03dcXUsqvnXcIXlwB46uwnIko8pnDEqmrJfw28i
 aX3NvzlZc8w47GSm
X-Received: by 2002:a17:907:ea5:b0:bb7:beb9:b6d5 with SMTP id
 a640c23a62f3a-bbffbf8531fmr862847066b.39.1777989780795; Tue, 05 May 2026
 07:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-qcom_spl-v5-0-11817415d664@seznam.cz>
 <20260505-qcom_spl-v5-7-11817415d664@seznam.cz>
In-Reply-To: <20260505-qcom_spl-v5-7-11817415d664@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 08:02:48 -0600
X-Gm-Features: AVHnY4LvwlLc5fbQOmSvW0cviJJoqzVEJkH93FHSlc833JEnn9Cok-tvggJJfeE
Message-ID: <CAFLszTjUniOCbnGdR9_d8HmQrt8SFV_u8dDonPvOEyCeOUZCTA@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] mach-snapdragon: Kconfig: changes / additions to
 support SPL
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 05 May 2026 17:49:47 +0200
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

Hi Michael,

On 2026-05-05T00:47:48, Michael Srba <michael.srba@seznam.cz> wrote:
> mach-snapdragon: Kconfig: changes / additions to support SPL
>
> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> arch/arm/Kconfig                 | 34 +++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
>       select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>       select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>       select SYSRESET
> -     select SYSRESET_PSCI
> +     select SYSRESET_PSCI if !SPL
>       select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>       select MMU_PGPROT
> +     select SUPPORT_SPL
> +
> +     select OF_LIVE if USB_DWC3_GENERIC
> +     select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
> +     select ARMV8_SPL_EXCEPTION_VECTORS if SPL

The commit message only mentions SUPPORT_SPL and SYSRESET_PSCI, but
this hunk adds ~30 selects plus default overrides in
mach-snapdragon/Kconfig. Please expand the message to cover the rest -
in particular the OF_LIVE/SPL_OF_LIVE and DM_EVENT/SPL_EVENT
selections gated on (SPL_)USB_DWC3_GENERIC are not obvious; readers
will want to know what breaks without them.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
>       bool "Qualcomm Snapdragon SoCs"
>       select ARM64
>       select DM
> +     select DM_EVENT if USB_DWC3_GENERIC

Just to check - does u-boot proper genuinely need DM_EVENT/OF_LIVE
pulled in by USB_DWC3_GENERIC, or is this only required for SPL? DWC3
has worked on Snapdragon without these so far. If it's only an SPL
requirement, the proper-side selects should drop.

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -1149,9 +1150,40 @@ config ARCH_SNAPDRAGON
> +     select SPL_OF_REAL if SPL
> +     select SPL_OF_CONTROL if SPL

SPL_OF_REAL is already selected by SPL_OF_CONTROL (when
SPL_OF_PLATDATA is not set) in dts/Kconfig, so this line is redundant.
Also swap the order so SPL_OF_CONTROL comes first, since that's the
option doing the work.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
