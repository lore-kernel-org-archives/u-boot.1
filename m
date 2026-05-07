Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDABCD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B9884BC7;
	Fri,  8 May 2026 01:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="MX36paMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1602E84BCF; Fri,  8 May 2026 01:49:07 +0200 (CEST)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com
 [IPv6:2607:f8b0:4864:20::122c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409B984B92
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hfranco@baylibre.com
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso964994c88.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778197742; x=1778802542;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d/nGJxaMlSzgHGuUuAFU936n74mdc1ozVcAK9nIZv6g=;
 b=MX36paMnm3ZTpCSIt37fU6VIR1k5Kg9Br+hMmrgkCycjJw0sKCdpPCBYy3MIm5hVwC
 tAaSrzF3/fp3htI75nO8FQYXeeD4FarY/nEdU5ThcbTGO6t9PotH7A0wij7QoJoLHdfD
 nNeRaHBQ/to4i+/OX/APEVlhllRTIllBWySTSuEasTQMED9fNR6Aq6msuOyDuaMMb0Ma
 wLsHvACNC475Qi4Wvg5Uu/MnxqHBUtjy3T9+LPlMkd1+9bNIQTnLgbvna3xegW/ehvj8
 n4CtSvOV63T5yZotOpp5BPOwDwN8wmvmhSR6aVXnlRCAYdUPQpd5AVoTSfY9VpcksVQA
 vb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197742; x=1778802542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/nGJxaMlSzgHGuUuAFU936n74mdc1ozVcAK9nIZv6g=;
 b=hmK4bTokj1Cqt0iS61bkDacCWoES+A3sa8s6gp46DxxEj3GV4l/RrYOZjaD6Um4pcR
 ZGOA+Y4MC4se7FiUCrrXW9DQO5ytSxOY5I7HCtDJAJXLhRrdelr/dNejb+BYenc9yiZ+
 NdL+Nkjltjh/yknnczOwEdriWoGGi4IRGTVhtojUi/dY7RoWGiuIBeqdi/AmH6N1oejn
 9use6CTDD3+Fmqgndz7S3QYfgb4EjqMKRUTtj0jvVX/B1qcLZEmCkfObNJqUumHyipId
 ALxW8bg2uxKAwDp8Eycsc9mhr9+WVzm3SOYTUK0Sy2FsMUxc3e7WYeAeadtjFobCUDc5
 oHLw==
X-Gm-Message-State: AOJu0YxLWG9suXgItVSbs0/gK6/33w3X20d8fenSvz/Lmgl1pEneoY8N
 T9m/D3jYMeBZfKSnf4SjBOzmIzitJLLCDnJDseBX913+z1OycUDgnwUsWEiHFDjroeFraJ2muRt
 UybKRZaE=
X-Gm-Gg: AeBDiesM4veLBr5m2TwHJZCVIfH+iO4MGy0GMenkPKmSshGy0qOx0qiGzK+en5zsFve
 8sGRrbClnmFZ02re0WbOMFcF/FKcOaMCA2vBoDotFpBD040AacmopWEBcphL5oub2Y+/8weeZ6b
 LgewUq2761w+4z8LbIowZj+qnGmi75Fv4I0T7+eb1yIzSrRPnfG0Ulv65CxCsQDDvwkaNeb108a
 /9TmO49KD6NLm0Ep4r5FAsMi8R6+mg2vXDX8wnjimslnIKMTUtP+g1Boqhl8kmJZ4d0aTdJBFJO
 VIX/zQZyc06ajaPqYrC81IeRO1sUJqNUJF+WhcEMLoSnsiwT4QYUlMMxkTh7WG+2IjuwGN4GOsZ
 BR8daa0letmZyW78g+ZSjbGEKLpNJ8TfvRu3Bt21e3w25XvtNWL6zReO1cEZxFyl6aih4+hYLkx
 KCjjvM7QD9kewzPLGA+BBlkkAeUUoo7C8bVjQH9UCvnDt68C0anKUXVFfQ3zjE4vfKO5vTwAI3f
 IUV
X-Received: by 2002:a05:7022:439c:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-1323aa56dc2mr2208985c88.4.1778197742131; 
 Thu, 07 May 2026 16:49:02 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c5:9534::8143])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13272db63basm620933c88.15.2026.05.07.16.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:49:01 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: [PATCH] mmc: cv1800b_sdhci: honor 'no-1-8-v' DT property
Date: Thu,  7 May 2026 20:48:36 -0300
Message-ID: <20260507234836.284918-1-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

CV1800B SDHCI controller does support 1.8V, however, boards like
MilkV-Duo 256M do not have a VCCIO 1.8V regulator (the bus is wired for
3.3V only).

These boards set 'no-1-8-v' in their device tree, and mmc_of_parse()
does respect this property. Later, when sdhci_setup_cfg() is called, it
reads SDHCI_CAPABILITIES_1 from the hardware and unconditionally adds
the UHS caps again based on what the controller advertises. Since the
board cannot switch to 1.8V, the host issues CMD11 (voltage switch
request), the card transitions, but the bus stays at 3.3V. The SD card
stops responding until the next power cycle.

Before calling sdhci_setup_cfg(), set the SDHCI_QUIRK_NO_1_8_V quirk
when 'no-1-8-v' is present. The quirk causes the SDR104/SDR50/DDR50 bits
to be masked out of the caps, allowing the card to initialize properly.

This matches the pattern used by zynq_sdhci.

Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 drivers/mmc/cv1800b_sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index 036e798f374..72c5bfc6f35 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -94,6 +94,9 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 	host->ops = &cv1800b_sdhci_sd_ops;
 	host->max_clk = MMC_MAX_CLOCK;
 
+	if (dev_read_bool(dev, "no-1-8-v"))
+		host->quirks |= SDHCI_QUIRK_NO_1_8_V;
+
 	ret = mmc_of_parse(dev, &plat->cfg);
 	if (ret)
 		return ret;
-- 
2.47.3

