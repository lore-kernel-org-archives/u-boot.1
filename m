Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D043FC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 06:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54AAD819B1;
	Fri, 14 Mar 2025 07:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQzdbEGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3900781760; Fri, 14 Mar 2025 07:47:45 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F13B81870
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so262199566b.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741934861; x=1742539661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bs5vDH3Pao9BaGk8XeKtoTrSrgUrLCFEpX3GQArSZiE=;
 b=fQzdbEGlrl5YCejPASJtCrexrHectFUqaR9X2RMCEORs9FPVIFK0+kFVJI7gKBnSra
 v/5poyxCQfZ4XZaexXE1L+TxQKdEX6LDSz0BSz0sQeKWoX9b1Z0rn1SsxPg+OrVWMBP0
 3LQ/ZrGzBTMlHBqDfgj8rchKIVPO5E354ACLrKH8XUuAkNKn91tpmEzaErQjH8wVv4a2
 iL0ng5L4o7oksQQy/SjSko3G0D+tmRmG/Z6z0fEZyUoD+vlRBvaJhJ1VvdtfL47yguyl
 jb9eaoF0RfHWQpzYahmI4VhumRnLainbTAATo778HSir9P/0C/ghge2CRzI+ufHx/wbS
 Y+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741934861; x=1742539661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bs5vDH3Pao9BaGk8XeKtoTrSrgUrLCFEpX3GQArSZiE=;
 b=Boqpl/1BtCW1psIKdtOfxBaM7FQNs7BsRgTWCqnkRkgk3onb7ofgo7Ptd7VfBCG/Tz
 nXlE5iV9A8Xi3EFjSPHwqjdAx4e9OHd0vfwjBAYZtWO+UbHH2qJ+AYYziPngR+qFbZq0
 osUlbi3cHdXxMoGMF+G1NMYapnnFvUK4AgkKsUn/boKke9N/wKfcSM+07JE6TTOuUI01
 1/Pa9WY3oBQK1i4SmUMrK9fMRcJ7UDotIWLfOFe0+2jMGCQeRbhgTcthvPWQu+u+0FKT
 9PbC6nUZjiFPszaN/IlE8PRgQN/QbJ7xzNdXDIVH7+6HkKa7X3QURURWp6GMuDFSqm9f
 ZddQ==
X-Gm-Message-State: AOJu0YzTQfc0smFTPW6aR6enDkTwxXliBTET6kmZm3DfmuAm+TtGd2RS
 SiTYzwDoi4QGmcNIVC2CQC6tZ0TnUPJ3H0JqXKRI2lpKmu/2rrQHiiM30A==
X-Gm-Gg: ASbGnctVbqqmy8RbW2zH39hmtUyQLsrNiL1z1cQdz7k+Q/ZaxZdpVITnuTChRnunWu0
 z5RfC7x6L+TIC3H16uGkDpSKcbJo8tFH5cvUpMCEAI01W9uHL2EFJUxqMrIXdPSjDjQBfhITkaq
 zRuSXmw0uqXr7YTSRy+pDHQ6NvDPsQT6mdPl1opxm5yfEpVNVXxuOzcZdk5b5U0jQMEuuzLTVf2
 mcUHHjkM31lKoiyc324bLTUj+hP975gsUmY5MovX6SXNh9ROaTxz4qEIZXSPfyfU352LLJX1Plt
 jYtfcc3ZxS6UGa6BIV9PeYJ6uJQ1j8Md+JUp
X-Google-Smtp-Source: AGHT+IEI+JORcs24XFKRuB1AVvn4zBaG953mBos+xony8rl5BXVlb3gSgvJs35wRD0t8JB5skU0uLw==
X-Received: by 2002:a17:907:2d24:b0:ac2:622f:39c1 with SMTP id
 a640c23a62f3a-ac3302c574emr107246566b.22.1741934860892; 
 Thu, 13 Mar 2025 23:47:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a49c37sm179471766b.158.2025.03.13.23.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 23:47:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] video: edid: guard standard timings EDID expansion
 behind kconfig
Date: Fri, 14 Mar 2025 08:47:20 +0200
Message-ID: <20250314064720.5767-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314064720.5767-1-clamor95@gmail.com>
References: <20250314064720.5767-1-clamor95@gmail.com>
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

Since EDID only indicates supported standard timings, a large table with
detailed timing information is necessary, consuming significant space. To
mitigate this, the table is made configurable via kconfig, allowing it to
be excluded when not needed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 common/edid.c         | 6 ++++++
 drivers/video/Kconfig | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/common/edid.c b/common/edid.c
index e2ac7100a88..e5aa4ca494f 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include <linux/string.h>
 
+#if CONFIG_IS_ENABLED(I2C_EDID_STANDARD)
 #define TIMING(c, ha, hfp, hbp, hsl, va, vfp, vbp, vsl, f)	\
 	.pixelclock = { (c), (c), (c) },			\
 	.hactive = { (ha), (ha), (ha) },			\
@@ -206,6 +207,7 @@ static const struct display_timing dmt_timings[] = {
 	{ TIMING(556188000, 4096, 8, 32, 40, 2160, 48, 8, 6,
 		 DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW) },
 };
+#endif
 
 int edid_check_info(struct edid1_info *edid_info)
 {
@@ -417,6 +419,7 @@ static bool edid_get_standard_timing(struct edid1_info *edid, int i, unsigned in
 	return false;
 }
 
+#if CONFIG_IS_ENABLED(I2C_EDID_STANDARD)
 static bool edid_find_valid_standard_timing(struct edid1_info *buf,
 					    struct display_timing *timing,
 					    bool (*mode_valid)(void *priv,
@@ -446,6 +449,7 @@ static bool edid_find_valid_standard_timing(struct edid1_info *buf,
 
 	return found;
 }
+#endif
 
 int edid_get_timing_validate(u8 *buf, int buf_size,
 			     struct display_timing *timing,
@@ -493,10 +497,12 @@ int edid_get_timing_validate(u8 *buf, int buf_size,
 		}
 	}
 
+#if CONFIG_IS_ENABLED(I2C_EDID_STANDARD)
 	/* Look for timing in Standard Timings */
 	if (!found)
 		found = edid_find_valid_standard_timing(edid, timing, mode_valid,
 							mode_valid_priv);
+#endif
 
 	if (!found)
 		return -EINVAL;
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index b1ef73f3e5c..11d17076a96 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -721,6 +721,12 @@ config I2C_EDID
 	help
 	   This enables library for accessing EDID data from an LCD panel.
 
+config I2C_EDID_STANDARD
+	bool "Enable standard timings EDID library expansion"
+	depends on I2C_EDID
+	help
+	   This enables standard timings expansion for EDID data from an LCD panel.
+
 config DISPLAY
 	bool "Enable Display support"
 	depends on DM
-- 
2.43.0

