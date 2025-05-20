Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36BDC54754
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C3682B00;
	Tue, 20 May 2025 14:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VujBToQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E72482B97; Tue, 20 May 2025 14:11:40 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F82482A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 14:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-551ed563740so3332731e87.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747743098; x=1748347898; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RFH15dHvDrz3vW19vb/3l6wKSP5wQrCCyFhZg31ps1Y=;
 b=VujBToQ5mGx1IObOAb81mFZfcVV2HxkoSW1Y0jt87tKgNQZZjciwQOiAymZ2OYn74P
 a0rK2181TiSgWLrDFHdOX0f0BaJD9RD27yzkJHdNqZt8gSwHZ6D5LFKel3DmHoew9YW8
 zvLGCwV9edKd4z/8WpHEORjOph/sLbxqy60WAjBGkMDJCyp71D1npPR9oR3W3/OFXkoF
 1Vudr94hP1bGSDkY7cuqYhqysErEXYbqvK4s/bBSyXbxj1T7lVxFKapS8NwAnFVKWYK6
 f9PFy1IA3B9+xmYGKWkI4NOpHamGV1FgfWlL0RyK9YEusC6nhaGWJYS+usGBNt+vq2A6
 Zc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747743098; x=1748347898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RFH15dHvDrz3vW19vb/3l6wKSP5wQrCCyFhZg31ps1Y=;
 b=P1dJaf2GFgIUEFaN6gYH54yL5I0C49dIRno5gwpA6GOnWwb2quqqIZnQGcI/iZxQ6D
 6L/q2SAgQxYM9P4rM4wDNHVJuFw9gAJZfAXB38dOcjGlyI7lrbw234AvlB87N3HZaMtK
 4sYazWXoZWPdwCUxQ/Q3TqhiowIBsx12Qg1BPHjXCP3gccZbVLxmqZ0zeA3abupQ9x3c
 aYB4A+177gC/KXmry3V+qcTI+wCscXE1ZAORI68wWwR2oFrrD9VWYBytJ4lIabQlvhjk
 t5FhvV/tFkhpGSCRcIQtf1E3Mvxc8B/8dw5+mwhqOFjym8AXZTRG1jk+oxOHVLRl8nQI
 Qdcw==
X-Gm-Message-State: AOJu0YzwhsLdC9sMdvV3dDJmA28D1iSX99ASg+mfUcUXaAPON0miJ8Io
 DBb5u1fBpnvErGiV1B9EkhA+K9HCr7MIzopO3TX5hm3lJIg2VPJkNSS8hmucOAsScznZ+AD03oi
 AQ0mGDP7VlKo18fS159Rdn9TdO35gcO8=
X-Gm-Gg: ASbGnctj38UGOHUUBZydQxtW9FisantWSpIYX4f9d5mPgEKFSWAENBdnXpu4ETpZDk1
 gLNaO2vOQdybkh+Z5d6cI9dtDwj8q4yxw4R5suhd8/TBXlXqa9AjQ5CsQlno2RltvXjdvDpo/B/
 ltRKVMeMXHz9ikS+w2W+E665T0k2R69NfEq/2V4XJUXWOwih22I5+WOT8GhbVX3MI=
X-Google-Smtp-Source: AGHT+IHX8X/jRD5JGkP2a9R4LfE/2lV1NdWKGV1cEYDcNvfwj6yt88fXYeRdtrMRhFqg9gs+LkBgkCBWIifBn6ppF4U=
X-Received: by 2002:a05:6512:4508:b0:550:dea0:3491 with SMTP id
 2adb3069b0e04-550e72299eemr4474263e87.39.1747743097581; Tue, 20 May 2025
 05:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
 <20250520085436.925901-5-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250520085436.925901-5-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 09:11:26 -0300
X-Gm-Features: AX0GCFtA19iSZOSevLOp5s94TVsInY3xcBu7QvRzyBPjidCH3qTo9hYGA0Wbnd0
Message-ID: <CAOMZO5As4Uxmunk4-LGFC71mR2mCZdJDYWtYk0wM565tpM1_wA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
 CONFIG_SPL_SYS_MALLOC_F_LEN
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: u-boot@lists.denx.de, Sven Dembiann <Sven.Dembianny@bshg.com>, 
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com, 
 Simon Holesch <simon.holesch@bshg.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Dario and Michael,

On Tue, May 20, 2025 at 5:55=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
> breaks the booting of the BSH SMM S2 board. The analysis of the issue
> revealed memory allocation failures during the registration of UART4
> clocks as well as other peripherals. Increasing SYS_MALLOC_F_LEN to
> 0x10000 fixed the issue.
>
> Dropping this option allows it to be set to the default value of
> CONFIG_SYS_MALLOC_F_LEN, which is set by default to 0x10000 on
> i.MX8M platforms.
>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  configs/imx8mn_bsh_smm_s2_defconfig    | 1 -
>  configs/imx8mn_bsh_smm_s2pro_defconfig | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm=
_s2_defconfig
> index 1c11d4705419..206d216394db 100644
> --- a/configs/imx8mn_bsh_smm_s2_defconfig
> +++ b/configs/imx8mn_bsh_smm_s2_defconfig
> @@ -15,7 +15,6 @@ CONFIG_SYS_MONITOR_LEN=3D524288
>  CONFIG_SPL_SERIAL=3Dy
>  CONFIG_SPL_DRIVERS_MISC=3Dy
>  CONFIG_SPL_STACK=3D0x980000
> -CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x2000

Thanks for investigating this issue and getting to the root cause.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

I'm adding Hugo to the Cc as the imx8mn_var_som_defconfig target also
uses CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x2000.

Hugo, please consider doing the same change on  imx8mn_var_som_defconfig.
