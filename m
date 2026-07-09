Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBECC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 20:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C021184C15;
	Thu,  9 Jul 2026 22:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bXvILvE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B63584C17; Thu,  9 Jul 2026 22:18:58 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E401384C12
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 22:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso384894a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 13:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783628335; cv=none;
 d=google.com; s=arc-20260327;
 b=PxpTI3j7LVUqEzCxCcMzA+jFMqySAFCd4h81jKUMVFvavQt5wd8zKy5qhinkH20g+s
 5pa22FeNpFeomVk7/0JpABbzTjWp56OOuPQqs8IeGvCfmPtAEE5MqUX1LthWT91ZmPEb
 HkldqXwpo/yLnKlbC/E6c8z7K5Q4c+DOAgviHPQ2R0RF2Ip79fBiLyBPlSRaLjP5Z5gA
 e7wfEo4FTg3JpI8tMtzJGmXY1Ntc/OeuvOrrtW4pyMgpyOb/Ic97g4OsNojPcFa5UvYm
 VWmv4N0Bc4+7NNghW90619dkU4HW44qbAaG+QYdXs7z8VTc9HmnSjdVlhEm7GEQiz0Yj
 T3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+rG6mlOBom+tMSOB8mDCzSLEe41wjvS1hoaZ0JsVFDo=;
 fh=Pxq0yxYGRjphnM+U5aBE5iEiDvtwTenPIVGTvPAHeLA=;
 b=K4DAZTiNpXMSj3XuE2S3FO7JBNv8hkAuOuFHJ42wp9GijKxyv9rgfevPeMqWzBXVEH
 JvnGbLAT65Xv/zxkmq+XqFNgYazeC1N/6YPofAzDFH05uIy8YdXCm9jxRXzZkLz3WbzO
 2O9glFXTsozpOQHl49prK3+FuprbG6poPcPajR/33AzG9oHtmz/jG9Wslx68nS/TE1Lt
 snVqntHrOsxBnY8vBiAl8ThxsQ8QKLkpf00f3vkAOICbLP2A/3GBzzU2BKJ/dskKDK4J
 5aVUu3RZcf7vcYXJsG7FHP2nNSgPkAbfHbgWCKQnlQ3yOH6fjarLZGfWPHntJ4QTnZoV
 3Iew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783628335; x=1784233135; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+rG6mlOBom+tMSOB8mDCzSLEe41wjvS1hoaZ0JsVFDo=;
 b=bXvILvE3oJzZ6AAjeyNGXO0hngEWzI7IVy1oIJHJjSvbXpjEwPWthy6jaGAQ4EtDSz
 wHlLMYfhk6s1gK7k/93BrMbYSZCA6JDNM5Zfi7P2nhC2b4W62xg70vWE1wHhVwDTeFJS
 TUaSKzVSNkp2kyksS1i/yEy/tAC8ElijKV6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783628335; x=1784233135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+rG6mlOBom+tMSOB8mDCzSLEe41wjvS1hoaZ0JsVFDo=;
 b=hTb+cNVN30iKqCO7UqVUKuUvnHaFbFsMZozXASUncHOZYYAz9c/iv6HqVYhHOIEG3r
 UW7Hw8Sy8OOS5ph2BxSoiI9esis3og/nrNBno1+KEcOvB8Z1Aq7udwyC0HERC2N8AFIJ
 gsgAyvHMdooyO4H2GlHPtYUXEmdpiCvR2tTvzlFfvnG2iZOKWQ70tX2R29o7YBmaQr/O
 1SagLEzli7wGaHrC806JX9lzOea6/IZSJyhEVmnQmGQsfWHqy7CJwgTJ8Zj4P9aajpae
 zIvO3I9fP1Bo48EgIypfZLbbAnHOLHmHJXGZQkqGcEIYeeB57epOayYI4QbkuQgKH7Oc
 Jc8w==
X-Gm-Message-State: AOJu0YyR2lnNMIyLwwtpph+Na1Ri1aS6EvDkbkHIV6F8ly3tQdg7MNmF
 JRivtGnu+aIMWga2Dizq7bhLyUPinFNyrIj9Rfo8QYh1Auwd4HQrgjcsn1aqVyOXX9rZQd3/cFM
 dWvuddhXndBZgi9UtgyBvipX17Hi4BhHtCIz7hlyI
X-Gm-Gg: AfdE7cmXZj5seLafrYgHe239SnOGAVt+RsaWPzDMLBbuL4lYx3/JmraE2NSMljItbWy
 GuIKfIc0jpVScslJOWzBMc4r6hgQiTUIpFjoAjlca3JhoLWa1RvIUrOF43B5+ASU99wQhCzQ+N4
 0uBwyRuJsvw3MHMU1uYscbJeEIboVzJ+v/dqaQy2k0V1egotI5HM4GsXe+qT8nQWrHVk8kac+hp
 jgaOkY6p7yI+9VG+bcPYn2tDQbuT0/wawAOSNZJRVxEhfMUmKN9w2Xaek/uTT4/A4FLaMo=
X-Received: by 2002:a05:6402:34c4:b0:698:3b7c:be63 with SMTP id
 4fb4d7f45d1cf-69ab44af3d7mr3635619a12.31.1783628335040; Thu, 09 Jul 2026
 13:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-2-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-2-e742cdd6abe5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 14:18:43 -0600
X-Gm-Features: AUfX_mwiLLdct4AAMWeDc716lwzGXdIQmMw5I_SEpSPYsYGz_2S2b3ScXafgHaA
Message-ID: <CAFLszTim0-enzDb+hYrNZKYhgTs5PVvw_bB+O9b5a5TLOUnMWA@mail.gmail.com>
Subject: Re: [PATCH 2/4] bootmeth: efi: source the devicetree from a firmware
 partition
To: ccaione@baylibre.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <floss@jetm.me>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
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

Hi Carlo,

On 2026-07-06T15:06:41, Carlo Caione <ccaione@baylibre.com> wrote:
> bootmeth: efi: source the devicetree from a firmware partition
>
> When a firmware-owned devicetree source is configured (EBBR / Arm
> SystemReady IR), assemble the devicetree from the FIT manifest on
> the firmware partition instead of reading a DTB from the EFI System
> Partition, and hand it to the EFI application through the normal
> bflow->fdt_addr path (efi_install_fdt()).
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> boot/bootmeth_efi.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -73,6 +74,61 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
> +     ret = firmware_fdt_load(&fw);
> +     if (ret) {
> +             if (ret != -ENOENT)
> +                     log_err("Failed to assemble the firmware devicetree (err %d)\n",
> +                             ret);
> +             return ret;
> +     }
> +
> +     /* stage it at fdt_addr_r, like any other devicetree */
> +     fdt_addr = env_get_hex('fdt_addr_r', 0);
> +     if (!fdt_addr || fw.size > SZ_4M) {
> +             firmware_fdt_free(&fw);
> +             return log_msg_ret('fwa', -EINVAL);
> +     }

Please move the fdt_addr_r lookup above firmware_fdt_load():
assembling the manifest, applying overlays and running
fdt_check_full() only to discover we have nowhere to put the result
is wasted work. The SZ_4M cap also duplicates FW_FDT_MAX_SIZE inside
firmware_fdt.c - please share the constant via firmware_fdt.h

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -130,6 +186,18 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
> +     /*
> +      * A staged firmware-owned devicetree is complete and authoritative,
> +      * so return without considering any other devicetree source. The
> +      * extension overlays below are deliberately not applied on top:
> +      * such combinations belong in the manifest as configurations.
> +      */
> +     ret = distro_efi_firmware_fdt(bflow);
> +     if (!ret)
> +             return 0;
> +     if (ret != -ENOENT)
> +             return log_msg_ret('fwf', ret);

Just to check - once you move the env lookup into the helper, the
outer fdt_addr = env_get_hex(...) still needs to run for the ESP
fall-back path. Please make sure the two lookups cannot disagree and
state the contract in the doc-comment.

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -268,6 +336,19 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
> +     /*
> +      * A configured firmware-owned devicetree outranks the network-provided
> +      * one (and the prior-stage / built-in devicetree below): a DHCP/TFTP
> +      * server must not be able to replace it.
> +      */
> +     ret = distro_efi_firmware_fdt(bflow);
> +     if (!ret) {
> +             bflow->state = BOOTFLOWST_READY;
> +             return 0;
> +     }
> +     if (ret != -ENOENT)
> +             return log_msg_ret('fwf', ret);

The two call sites are essentially identical except for the extra
bflow->state = BOOTFLOWST_READY here. Please factor the "try
firmware fdt, return on success, fail on hard error, otherwise
continue" logic into a small helper - patch 3 adds a third caller
in efi_bootmgr.c and it would be easy to forget one of the checks.

> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> @@ -73,6 +74,61 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
> +     if (!CONFIG_IS_ENABLED(BOOTSTD_FIRMWARE_FDT))
> +             return -ENOENT;

BTW the stub in firmware_fdt.h returns -ENOSYS when the option is
disabled, so this early-return exists purely to remap that to
-ENOENT. Cleaner to have the stub return -ENOENT directly and drop
this guard.

Regards,
Simon
