Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01651EA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E6283FF5;
	Mon, 20 Apr 2026 06:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EEKkT9aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7862980087; Mon, 20 Apr 2026 06:07:00 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C305C83FF5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9c745e18a0so438306866b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658017; cv=none;
 d=google.com; s=arc-20240605;
 b=cIP/DJ8BgdNmT3DZl4xQxnGapcwPTWsU/xp9SKYJVh1zi1LtrPD52vZ4Iq0eg/kwlo
 rUucdOsBWsqbXXrvIUwnU0KCmakYoVPmrw+SWx3eos+ZszRsD9YAZP4f2Iu6LWYPgZ4f
 9bBBbw2jVPlrwu5Idm0FBXhpbi1RkUH7880mckznynu7lRjHRo0rCG8qFZN7FOQ0L1Er
 bHVCXBGVCv3mG5gq/4pXHQtxw7EER/xbeEGGWkArT6rAX64yiyFmZAGWgjPE4Hyqg3cf
 +FB7/NAJG83wRATJT/gVE2rAn4iJxdzm/N4EkppxKyNZNoWVSBHQz64H3YEQDRaF853W
 x41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jutW5CJA7Au8f5SRE9lGXcSXQZPeTahFwQVeKmGsSFw=;
 fh=P+mPADOC4JY7F1QcPIf2jkotJUUo5seZt1UiNM0KlC0=;
 b=jB8GmfbOdTUAKJ/Vvkrq/LbWBwPv5PTjiTGj21wz7ugbgb1Q7I46lYeil54nMLPtVs
 peqSrwTvkZUpIlsbhwmP8u7OH2qke+3xB6aVGf2aarhLJCP9mYVH0IQdBJQX68hinP5u
 kiGcwjey4kanCq1DWjgGJ6/pDB4x/FjmXmDlKSltBjV6ZxCUwHMhMP0qpBZzfjXaEeVL
 ZN5SGtodly3dnpe0dE4c/vzAwiSDShGvChR2Tkc2vPcRE8SSAcASsTxoZ+HASz01xh6R
 6DjQZzWSw5FLNiewiGAWCULhouRrAUT26tWWbxc61/JDssiezPDWBJKTG0gRReyEbvvm
 ghPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658017; x=1777262817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jutW5CJA7Au8f5SRE9lGXcSXQZPeTahFwQVeKmGsSFw=;
 b=EEKkT9ajHVOqv9716bQND4bDPtrLfAJz0t93Oa/HCfcOoPbMNOu/NitqEnVFzPmATd
 ALt9QRyi0nCdUktZu2yzLwK5X06KE8rArVExErgJ+FLJfeDSe2zJlZp+nYghjL0WMhNk
 un5+mMvryQSm4TU346APAc0uXHENJPZDF8bak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658017; x=1777262817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jutW5CJA7Au8f5SRE9lGXcSXQZPeTahFwQVeKmGsSFw=;
 b=me9OH3l1lNV4Cz7d74Q/TZiIjsaXzeFbjBkLi/3G4Gqg3iLahT1VpITLSu+9LbqZa2
 kII32evaEjSfnauYMLTNTh1ni0TxW3D9q6/mD10VSWFA105CxE6TFk52kPoDDsv3Q0Zi
 r0P7SMxvMKrbcN94WdYDVIfx4gWwLbhTXpdDzeknQyisToW7t1SBBrTumH6vLOwDlEsZ
 scMgpZ4VJTTv3llRzUPjh/zYIN++TfOHuU5U31J8osSwWKrXIy496/JtwQ4cIRpDff0R
 ahSS2LSszQUYTz9hrmE19dsOOCo8SQdkLPgxvNLZo5ITAq3iKXcGrbjxL39/ZsH4oBvI
 w8eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IFeSLHwwPEUtUmModUh4rI+bl0Z5pVSzxYKb1pGfs+vn5x2iXcj1GI23AaSpnYD7WarAtAYQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyBox+m9iIsoOfApnwseJWajWd8b9iK8+Ca0y//+Bx3uFij3mzo
 DsjtNlY5ZtEyVTw+mmfQurJrOS4AKm79tutlt8U8xIY0BBCcwjA8YEEmkXISmjHWvvaqJnt++wH
 p/86Dxecpcgrvr0EjBXWswQn7CuzyFd4c/WDSR+ZP
X-Gm-Gg: AeBDieuAtIgQZXGaPZzVDMOuLRZEHsQHrpS42C9nHAkoG/5Y5CeKmJG9y4uRBnAXWAE
 Yc6LVHDE3DxhCQyIZj9oYCn06o1IVSghbY8fVOvpOfbGlF18SK1pocKVeYxBI17e/JI/kc1WDxK
 1MT73n/1xTnBWwir+Lv7MKpOg35urzKWoFCqGHM8rPncUYFDRPfzOVttELd7lC2cJxtjVqMYzJP
 HWiXejQFeGZXMf7gZUokurbPwfv13sAGTkBAk9cJfGILNo516qiEXHiZ8mtA6U0mNi4skU+3AOx
 JKCmErQKgHEekZS4cTG0
X-Received: by 2002:a17:906:7946:b0:ba3:bc3e:d5f3 with SMTP id
 a640c23a62f3a-ba420066392mr433784666b.5.1776658017198; Sun, 19 Apr 2026
 21:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-3-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-3-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:40 +1200
X-Gm-Features: AQROBzC_09IVQTj7R1DMY3aAHDhvIat973gv1LssVGTqsC5yui73Ly14YPe3Cj4
Message-ID: <CAFLszTimLSp8BFunaTzZszUhMXRtTE5vP=TpR3r2sCMBjQjtyA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mach-snapdragon: Add FIT multi-DTB selection
 support
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add FIT multi-DTB selection support
>
> Implement multi DTB selection from FIT images based on hardware
> detection via SMEM.
>
> The implementation provides:
>
> 1. Hardware Detection: Reads SoC parameters from SMEM including chip ID,
>    version, platform ID, OEM variant, DDR size, and storage type from IMEM.
>
> 2. Metadata DTB Processing: Parses a metadata DTB (first image in FIT)
>    to build a "bucket list" of hardware-specific node names that match
>    the detected hardware parameters.
>
> 3. FIT Configuration Matching: Uses standard FIT mechanisms to find the
>    configuration with the most matching tokens in its compatible string
>    compared to the hardware-derived bucket list.
>
> 4. DTB Loading and Overlays: Loads the base DTB and applies any DTBOs
>    specified in the selected configuration using standard FIT overlay
> [...]
>
> arch/arm/mach-snapdragon/Kconfig             |    8 +
>  arch/arm/mach-snapdragon/Makefile            |    1 +
>  arch/arm/mach-snapdragon/board.c             |    7 +
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1103 ++++++++++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  189 +++++
>  5 files changed, 1308 insertions(+)

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> @@ -585,6 +586,12 @@ int board_late_init(void)
> +     /* Try FIT multi-DTB selection if enabled */
> +     if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
> +             if (!qcom_fit_multidtb_setup())
> +                     log_debug("FIT multi-DTB selection not available or failed\n");
> +     }

The logic seems inverted, since qcom_fit_multidtb_setup() returns 0 on success.

> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> @@ -0,0 +1,1103 @@
> +#define TCSR_SOC_HW_VERSION        0x01fc8000

This address is hardcoded - does this mean the same TCSR base is used
on all SoCs?

> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> @@ -0,0 +1,1103 @@
> +     *ddr_type = 0;
> +     if (total_ddr_size <= DDR_128MB)
> +             *ddr_type = DDRTYPE_128MB;
> +     else if (total_ddr_size <= DDR_256MB)
> +             *ddr_type = DDRTYPE_256MB;
> +     else if (total_ddr_size <= DDR_512MB)
> +             *ddr_type = DDRTYPE_512MB;
> +     else if (total_ddr_size <= DDR_1024MB)
> +             *ddr_type = DDRTYPE_1024MB;
> +     else if (total_ddr_size <= DDR_2048MB)
> +             *ddr_type = DDRTYPE_2048MB;
> +     else if (total_ddr_size <= DDR_3072MB)
> +             *ddr_type = DDRTYPE_3072MB;
> +     else if (total_ddr_size <= DDR_4096MB)
> +             *ddr_type = DDRTYPE_4096MB;

If total_ddr_size > 4 GB, ddr_type remains 0. Is that intentional, or
should there be a final else clause for larger memory configurations?

> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> @@ -0,0 +1,1103 @@
> +     printf("DTB: %s\n", fdt_name);

Maybe use log_info() here for consistency with the rest of the file?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
