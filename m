Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80768C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A41181BC0;
	Wed, 12 Mar 2025 19:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UDCWpMsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D22381D67; Wed, 12 Mar 2025 19:15:43 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6910B8056A
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso27295266b.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803341; x=1742408141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN9d7+RJv0xWCMhBpu1kT00Qge/LWwP9YcNtvDoBH/0=;
 b=UDCWpMsSfrHsSIgO3hjyBU65/T/Cr3Zd2KGZyxQIyvhXIDU1djtekz7iIfqSHGlEo1
 VUA9HBoq7xS2a2GDR38XrcWPlTZNrvEC27FFSg4BswFpJr6HINSAaFTDoi4XpkZuJLfO
 GTtRP5ppukql/U1DcmBSKRkSMzt9uUesYkUPeT1WHcdjEVVqWJMqcfV6HhNeQAZBPXpk
 /O1QcJhehHGziWhSbOYnfVrBOJkZlzqANe7zKVtlZ3443Ims1P3J1gLRN756Lj/TUC0w
 bZPHu2GnnzChul7OsjE1U7OGwvgGCcSt7iF5UmqIJ9LiyV4l8iLsPMBqnk0kfA/nxbg7
 hp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803341; x=1742408141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PN9d7+RJv0xWCMhBpu1kT00Qge/LWwP9YcNtvDoBH/0=;
 b=sSa4/QFXIGHDdSwIev/diyX68PUCo374TMi40aMVayStaEj4f1m+dU8lh9VyMJO7W2
 VJuGkAKgPtdPkBKpFDJLAQI1Os1Y8oatCfBwGSDYIDUKsCMWO3FwrshaonAMw9s13EuC
 QlE1gAhzTaaOOP16+97P0ftofm9SGZEfAuCDPf6sK9cvPGeXjFROIlaiwmfGG0G/RN8K
 uHUMaPTN9p3OCaZlbbSaf+OTERcX6zyQBnhOqLRD1i9BU+b+yoE/G8sQiZDV93NYLem2
 03UZOvGZ/X4YfG2cWrBF1iOvboxeRCUj52zbEKXldfyE+yHDbtgo4BKR8UiYkod2Zzk6
 dsaQ==
X-Gm-Message-State: AOJu0YxI5mUCYU+AqLnmFvADPtINjThbp0/x6Mr92JPhIsts2sAZLBf9
 Ajhd432GW//M6cKWz6QL2f4+tJYylF8L4XY+K4f12OVj2zQ6aM5I
X-Gm-Gg: ASbGncvArUIlNWXZltYNdj1MrNDZqtlAn7MPXfiOTn1gLmf1R8t4VCoDFeWn6WJBzsz
 M8nVHUjpLRxsCVEWSf1mUzafHGeuFQ5nqwI8L5PZulzhVE3Ynii/35ijfJCd9vI5zo5CtYiX/bZ
 LtU1nTUuUPp45qHO7El1PRWQcP8IP8JXS6dD1jF6dya5FcNOtknI00UoMy2v3L+yL+jztP2mPEV
 YXxi2io1aycm+VvhflUl7i93VUjE8kG+RChr028MxOHEoIfovVDySwFSYANd28ce5FoZiKdgkUj
 T7Qz77wLrtIROZFia21UFrg3qb12Lrf0Fo4HDTFlg4jFu+k=
X-Google-Smtp-Source: AGHT+IFTSL53d+9uH06JRMOjyh/TamUUGXjnK3LsW3H9yFAvrCY4na1xOP9/ZwdFTVP1EYYyCA/tYg==
X-Received: by 2002:a17:907:82a5:b0:abf:7a26:c47b with SMTP id
 a640c23a62f3a-ac2b9ea18d8mr1015207966b.39.1741803340672; 
 Wed, 12 Mar 2025 11:15:40 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac28c11561dsm641906666b.145.2025.03.12.11.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:15:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 07/11] video: renesas-r69328: add missing mode flags
Date: Wed, 12 Mar 2025 20:15:19 +0200
Message-ID: <20250312181523.121313-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312181523.121313-1-clamor95@gmail.com>
References: <20250312181523.121313-1-clamor95@gmail.com>
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

Add missing MIPI DSI mode flags.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/renesas-r69328.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index 9861c3fef11..1147785c1e2 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -216,7 +216,8 @@ static int renesas_r69328_probe(struct udevice *dev)
 	/* fill characteristics of DSI data link */
 	plat->lanes = 4;
 	plat->format = MIPI_DSI_FMT_RGB888;
-	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM;
 
 	return renesas_r69328_hw_init(dev);
 }
-- 
2.43.0

