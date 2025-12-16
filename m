Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFFCD5C0C2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D89E80325;
	Tue, 16 Dec 2025 09:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CnbmrGyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37908042F; Tue, 16 Dec 2025 09:46:03 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F7F800D0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6498850d3f6so5611548a12.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 00:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765874760; x=1766479560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iVDrDrt3QjWeGqHMnE/g/9XejvuG95QodjxjxIPwjvM=;
 b=CnbmrGyS/3ZKt3EO4Ss2ELf/j6/5ZjINE6J0Cmpdcpk/CN+3VHtq4OF8RSpbj/YjUj
 81K+bTWjZ/qFjv4RwxRoJGfpQKxJCMNDrF2U15GAnzVvS79sU+rS0p9XDw+qzMOLomi0
 3YJlJcU5l11InEE0hQZTlfzN54i0tI4BkNk6f08rCMQdNQnQap0Jjpk+mbOkdEbRtl7k
 fDKkcK+n+M+nshhi9E4P9wkjY42iWMFecVRshWeP9hdKjiAtvPWRbN7wabnum4/5OmPG
 Y6x9DRQpTrSOd5EAx11vo2mYjv36p6QwuvNSNCden9lFQxsE+mNOFQ43tmQA4ZXIXnEu
 wPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765874760; x=1766479560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVDrDrt3QjWeGqHMnE/g/9XejvuG95QodjxjxIPwjvM=;
 b=QCWNXb+JWa6i7yw9+h5hX/+EKWr76EuYxDmlt49VLITlrKW6ozAb9lCYWTTrG/YI1C
 mM+grezRRh93OCME7068OICbmiSeROAATyhVuLhuyw2YYXikXIzc3tt/b7yQDm/TKD7U
 NjwSahTF42IZQFqFSEY0CCPsQbkTUTNBdeDItoRegwHNWCldbitfERVkXl3PPDuvnjBL
 xxvIcYt0PQLgj6kYn9mk9peL3hKdAFClqTTKcWp9u4zXMeB4G1HgTQ/PYSrJpOCWFrAY
 XZ/lGB1Nk/FnMcZIayozlWyF7OpkXIaVyfV8JkYOfQcpnsEIMoO0y2K9PRUZZqBEgYt2
 6LZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpOUWRkjMe11ljem0NAAk9TbPHG0Tk4p1ahgsgdUsGXq8bMWIzxb5Y4zRN2PBkHbDieye9Svg=@lists.denx.de
X-Gm-Message-State: AOJu0YykGMAneKlXTIicGv5IBTNcsxluOLFExo4YXS9FzY0L8+pWvy1A
 dyr3DaTca1dF8gSrispKCTEkt5VFumme23ufIyjeOAR4tLkck2qnnNHq
X-Gm-Gg: AY/fxX5lmH6o2TgMZVbpaBcxKsifiijj0aw3w0s7N3cSMw3+YCFVw3fM32/tH97RhtN
 97D7vUVVDm0Kl/K/5yOKglvQaQGsxPSsgxjovrdjfldDUeYAk7eSrOObZXcU3QTOowCMQIT7SXp
 IRfWjfEPGvxf0W0FOVozHoIcnfsmLilXfWeRgGSDxjoY8qScdCapYb5ikOKUEtPIz7/tQzTC8ln
 tumCO6VsZx6T5P/y1reH8oRTzv+gKg3C+a8D9AN0YmJOpI9+hBLMnnsX+EzLHdOjSVmhBN4g+8b
 lGkYh6PYCoBVpCnVH+Of7aTMGfZbMrxh4MqE5Q54r7EoUWl9t6by3YRFyHbSwvifIAN42Cl0yLU
 fsDeudjfYVFEwktJUOjFHH7VdI/j/Q4JLtB57HIEyngCBZUUAvW7RqoEsvVg5QrXduJc2Qo1r3n
 /f6yaRyWaACDrRjDQF/dReoiL4Rr5Pd/tN5rTMNyeX0h68NhauabM++609Yiwuo+33KVgtJqGyI
 slVdSg/DrzA2qyX2qM2WYTgPcLEwQ==
X-Google-Smtp-Source: AGHT+IGcMtM4TpssxStRQymKBoHvPQHJ1II7cvtYWHCCQD2AcTDyqdXlVjBRPTjAUiOhGpgHDyduJw==
X-Received: by 2002:a05:6402:440a:b0:649:6411:c88c with SMTP id
 4fb4d7f45d1cf-6499b1d839emr12798877a12.26.1765874759779; 
 Tue, 16 Dec 2025 00:45:59 -0800 (PST)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64982227ba1sm15504346a12.33.2025.12.16.00.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 00:45:59 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] toradex: tdx-cfg-block: add pid4 support for new modules
Date: Tue, 16 Dec 2025 09:45:28 +0100
Message-ID: <20251216084532.613791-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add new PID4 to ConfigBlock handling:
 - 0217 Lino iMX93 Dual 2GB IT
 - 0218 Lino iMX91 Solo 2GB IT
 - 0219 OSM iMX93 Dual 2GB IT
 - 0220 OSM iMX91 Solo 2GB IT
 - 0221 Verdin AM62 Dual 1GB ET

Lino and OSM are two new SoM families.
The Verdin variant differs from the existing 0073 Verdin AM62 Dual 1GB ET
by the presence of the GPU (AM625 instead of AM623), the absence of
DSI interface (bridge not mounted) and eMMC size increased to 16GB instead
of 4GB.

Link: https://www.toradex.com/computer-on-modules/lino-arm-family
Link: https://www.toradex.com/computer-on-modules/osm-arm-family
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 5 +++++
 board/toradex/common/tdx-cfg-block.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index cb81646f9a1a..0fc3759695fc 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -184,6 +184,11 @@ const struct toradex_som toradex_modules[] = {
 	{ AQUILA_AM69O_8GB_WB_IT,                "Aquila AM69 Octa 8GB WB IT",           TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 	{ AQUILA_AM69O_8GB_IT,                   "Aquila AM69 Octa 8GB IT",              TARGET_IS_ENABLED(AQUILA_AM69_A72)      },
 	{ VERDIN_IMX8MMQ_WB_IT_64G,              "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
+	{ LINO_IMX93D_2GB_IT,                    "Lino iMX93 Dual 2GB IT",               TARGET_IS_ENABLED(LINO_IMX93)           },
+	{ LINO_IMX91S_2GB_IT,                    "Lino iMX91 Solo 2GB IT",               TARGET_IS_ENABLED(LINO_IMX91)           },
+	{ OSM_IMX93D_2GB_IT,                     "OSM iMX93 Dual 2GB IT",                TARGET_IS_ENABLED(TORADEX_OSM_IMX93)    },
+	{ OSM_IMX91S_2GB_IT,                     "OSM iMX91 Solo 2GB IT",                TARGET_IS_ENABLED(TORADEX_OSM_IMX91)    },
+	{ VERDIN_AM62D_1G_ET_GPU_NODSI,          "Verdin AM62 Dual 1GB ET",              TARGET_IS_ENABLED(VERDIN_AM62_A53)      },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index f78e69645cfe..b28033d8332e 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -142,6 +142,11 @@ enum {
 	AQUILA_AM69O_8GB_WB_IT,
 	AQUILA_AM69O_8GB_IT, /* 215 */
 	VERDIN_IMX8MMQ_WB_IT_64G,
+	LINO_IMX93D_2GB_IT,
+	LINO_IMX91S_2GB_IT,
+	OSM_IMX93D_2GB_IT,
+	OSM_IMX91S_2GB_IT, /* 220 */
+	VERDIN_AM62D_1G_ET_GPU_NODSI,
 };
 
 enum {
-- 
2.43.0

