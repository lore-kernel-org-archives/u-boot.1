Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D0DEDB7D0
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC77984106;
	Tue,  7 Apr 2026 23:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GoHSbTM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CEF840AB; Tue,  7 Apr 2026 18:47:22 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464AD83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simons.philippe@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso828953266b.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775580440; x=1776185240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PGSig8GqnAlSNmuufg1Id6q9PGg/xK+9L2KlsNyD0ts=;
 b=GoHSbTM8pFWUAm4IkNp0jbinIQ5OpcJCCSklBDy6ooP9LDG3u1FEPjjeCRTMBp3rBK
 YwWPvpjWjfX6ZjmaOdfyQfC7Q1aQwRA2H7BmL3Utz38HAVcu8KZFkhcedRMOSPfWN7EH
 UpZcV7J47drfaSGavLFojV2u0PaK3x2iw+TMfuTXbntsROKAm7/XWFzgn8dwxxnTjB36
 K87B0yIfIiCvVdNrc9G7nwCurdXBu33DGMBTd1cGg/LJJO3+A6AWBKoYY/V22eVaNkTA
 MXgYFXaE2wEV5ME+7vEYF8QecpKenWeOFdUk2JotDd8H5ldr21C5n51R21wSUS2I+RVz
 rOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775580440; x=1776185240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGSig8GqnAlSNmuufg1Id6q9PGg/xK+9L2KlsNyD0ts=;
 b=T33/P8FjfDKOJ0drf4CKWzeOYnPKhOJLiD23XZ6dICuRykLuvr1CW4BYuaPYpeujP6
 8moBLJcal3xni7a3IZbomMlKO4MF4xy8UbyE/65Hr3bO3pshCTW8j+c9HBgjd0k9rxLY
 wFcCYG9mSTCsyLJvO5/KbG9DvgeuOj8sFbomi/9QdcpYPoIB5TXuhGMwjIvxDImAIi+X
 CF04fAxwryWusP2DVCrgriY4onwXHrWNrCE+2d1xCu/yAk2+GxBxPWGmUSk7zYgWqssS
 x6ouYc9TSUSC1TQGTgPhBXw9D1NOOgWWcI7r6qWjZFymCoQWkRPbbDEt2s1ikTH5yFTa
 LYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpzvCMS9rCBSfet1frniXrDqvnodc2a5Yzgh2AMtjq3dL3NlHjeQxvVsn8lMFu1k6BeFLIzzw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx276ScJ6xyTZ7/xI73xpsHK5RKobU0CCifVyVhtWl/XXPiy6v3
 KWgOD3XEHAJwVE7OqV0qy21Y2RDZzf4MK5GEpucKYkkmEE4ymna3OxY5
X-Gm-Gg: AeBDieukE1JO96uIywAZXhUNf3+7zAGiGP2VRF3lwf2UXE+K6jIqbmn1HFXvgSJF3aC
 d9JRfpSD4CKv/JuakqI9MT//7qfFo2gnrcZvMGiwEKQ4FC9BTKVEBI6ywR2iqoE6gFz2DCKmnZL
 gu+VxJdyhs92qI9+5Qu2ZqEgCCPK0mh/ZLPJm1Nvxo993FZ0UmJ9tgYVXkaiczc73o6XAg4FeVL
 vgqvVYQrhHywIiWEv1z1l5tp/I6p/gQhEMPzN4cnIe/uijSYFIT7GSvSFx1Jfso1FquNdpMCSlg
 iqfkYJFCHGPHS6ZfIbRzOmJIYYzHoqrbw9rQcLFai5aRq/QYYydMrmq6LDmH59snPPN/zhG+srs
 GqVlTOvPo2p2sQBqo1z50aifeS5b/skp2vgjosiCKuRqhg29ZTGmWMTBBC3ti8LpG4R6IxdbNYs
 3TeWnBuBVOIvBKv+sVmUsDu0AOgq7UFH+ByzwjoZLJPo/B9fObRSr8ldsAl82+XLr1ESNpf2Q=
X-Received: by 2002:a17:907:7fa2:b0:b9c:9b75:70c5 with SMTP id
 a640c23a62f3a-b9c9b757d1cmr734911766b.35.1775580439256; 
 Tue, 07 Apr 2026 09:47:19 -0700 (PDT)
Received: from bob-linux.lan (113.73-65-87.adsl-dyn.isp.belgacom.be.
 [87.65.73.113]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c972e28sm570621866b.1.2026.04.07.09.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 09:47:18 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2] sunxi: H616: dram: fix LPDDR3 TRP6 parsing
Date: Tue,  7 Apr 2026 18:47:17 +0200
Message-ID: <20260407164717.7356-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 23:24:13 +0200
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Allwinner's BSP DRAM code uses parameter TPR6, presumably containing
some "Vref" parameter, to encode the values for *all* four supported DRAM
types. The code selects one byte based on the DRAM type used at runtime.
To allow copying DRAM parameters from vendor firmware, we used this value
and its encoding, but wrongly: the proper order of bytes is DDR3, DDR4,
LPDDR3, LPDDR4, from LSB to MSB, cf. the A523 and A133 DRAM code.

Correct the masking for LPDDR3 to fix DRAM operation on some boards
using this DRAM type.

With LPDDR3 TRP6 parsing fixed, adapt default DRAM_SUNXI_TPR6 value.
Also change LPDDR4 default value to 0x38 used by A523 boards.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
[adjusted commit message, update default value]
Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig            | 2 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index e979ee4a2cc..a1ddc6a1fc8 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -144,7 +144,7 @@ config DRAM_SUNXI_TPR3
 
 config DRAM_SUNXI_TPR6
 	hex "DRAM TPR6 parameter"
-	default 0x3300c080
+	default 0x38c00080
 	help
 	  TPR6 value from vendor DRAM settings.
 
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 3345c9b8e82..42a0550e015 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -975,7 +975,7 @@ static bool mctl_phy_init(const struct dram_para *para,
 		val = para->tpr6 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR3:
-		val = para->tpr6 >> 8 & 0xff;
+		val = para->tpr6 >> 16 & 0xff;
 		break;
 	case SUNXI_DRAM_TYPE_LPDDR4:
 		val = para->tpr6 >> 24 & 0xff;
-- 
2.53.0

