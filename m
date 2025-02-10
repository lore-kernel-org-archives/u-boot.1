Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8957C0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D69880C58;
	Mon, 10 Feb 2025 12:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="exAuHFXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9534D80548; Mon, 10 Feb 2025 12:18:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A74A80AE1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 55FC14006A
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 11:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739186327;
 bh=K4MlDsi3LOkfrP1U1UBmOHhd1+5/MHPgYq/Uxp5U5MQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=exAuHFXgotWneXkOIL8O7hW5rHqVTEMuXmUOtFvPEcl8kwEo12lFe7otHrU6TSBW0
 hOJFjv+vMsGR331sbWBuZQF1gmsL3xbUuirQo6eVdOSRGhNF21jmYkxaxbtj9HeCti
 Z8BNo5c2iRaAmbXO0ZfVDsYd+Rt9XIdqL3Ud2JPqOQoVmUUm9W+Mr1jM9J6IwJYIaQ
 DkeF/5LCgNI4QTfm840fWFp0lKuMZWAxBQBZ6uXREc9GnqC2iRe+8X8pXyLvCzvGWn
 gEaVPztsmaknRBH/B0MAQGJ5hUvUBngbiJNfrPtgjiWQFT+Nf2KrP/1r0ZWn07dXUa
 3bHiSXKx2RYKA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dcfd8ac9fso1169545f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 03:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739186324; x=1739791124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4MlDsi3LOkfrP1U1UBmOHhd1+5/MHPgYq/Uxp5U5MQ=;
 b=Ek0z0SCqAI4CmbKzx9bV9I7WowDy0Cd5XbD+o+oZr0DBYvB6wnUA2FwKQjdJqR4WOj
 FqOw6Rr7hpDZwIokE5d1uX+naq5oudXXk6gHo5QF9+zj3u5h059Jkyh01qVKuS0kqSk0
 gMF7Oh+k5n9TKwElgv3P4GADz0zBYO6POi4Cw8WLDqiolv9nteeFlk0fZuUT1GFf88zE
 wPBXntA3Dd8GbNC1rt7z64YpPEZhsHPL2TcTNCEbN5gtWWY6S+sfrtXssblTQ3pbIQ5t
 24JAyiTV+tJZ8lIReGYzfuLuSeJ0BQFlf8+0OyAendZBp/rU9FOKAbIpNjo/bQhKSr/V
 N0hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9cN8HojC2N9s/GjhMlsErHZigMqMHC5oi63b5jNkJ+w0pc/0K9Hgb//HA7zb858IZv41WV4Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz79mA5B9iBTp81LhZ367psGHlomIl+KJqHsmYWQmpsLZ09UEKM
 IpJlAaZc3yf7zRMz9PCSF20s7Dtasqf/EAfPTKijE5oazzx/tAedFgt0gSCli6sXpiWx3FkmuL9
 QmbPwc9Iv2/SFt2TkPXu6nyvmDXJDTz6L8RnP/EVWfK+EfIz0vqya4DowDpk6lArCoZo=
X-Gm-Gg: ASbGncseRqY40rvZKdPE5YXQek86r5U4xcec32pd3SU0O1uwgL8r16gcm1K51jBk7C/
 hmugBGcPQj4mQCNCxNgjVF1R87/ATVoNkEmDMyzh8Ryr8zx6ZJcIXeBnCjNZ89ruRjSoFxutvSD
 zTNHgRsbezdq9fxWv+ftN//zbsUyVz5eI6m8sRPu08/XcBVrdxzjqA8Ic8zSwkvKTmdgab9iQSK
 npciRZIoG0hDVe1nz7KHwcoQVH90ixu61GWY2MX0ZzNH30EcOYM1r29PATfQaUOe48R/n7WVt+m
 hUbvBo/5GLgm6A33J7JQ8M23aRFrVS6A3pLC7/qnAIhXmH/eK4Aw+THqr4lFnmiNFdiO3LUCDUK
 CNpynGXw=
X-Received: by 2002:a05:6000:1448:b0:38b:da31:3e3e with SMTP id
 ffacd0b85a97d-38dc90ee504mr9988701f8f.28.1739186324317; 
 Mon, 10 Feb 2025 03:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5nebcT5exFShsewri7vT8CTiDNr6la2GmOU/BiYVTbO5WCKfhfsdM7rjJgd8IuUsHs5dxg==
X-Received: by 2002:a05:6000:1448:b0:38b:da31:3e3e with SMTP id
 ffacd0b85a97d-38dc90ee504mr9988672f8f.28.1739186323976; 
 Mon, 10 Feb 2025 03:18:43 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dda26c6f5sm4194243f8f.68.2025.02.10.03.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 03:18:43 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] riscv: dts: starfive: remove duplicate itb entries
Date: Mon, 10 Feb 2025 12:18:29 +0100
Message-ID: <20250210111830.72055-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
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

As binman already creates nodes based on CONFIG_OF_LIST we don't need to
add extra nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org> # StarFIve VisionFive 2
---
v2:
	no change
---
 .../dts/starfive-visionfive2-binman.dtsi      | 76 -------------------
 1 file changed, 76 deletions(-)

diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 4cce001e80d..05787bdb92d 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -13,82 +13,6 @@
 };
 
 &binman {
-	itb {
-		fit {
-			images {
-				fdt-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
-					};
-				};
-
-				fdt-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
-					};
-				};
-
-				fdt-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					load = <0x40400000>;
-					compression = "none";
-
-					blob-ext {
-						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
-					};
-				};
-			};
-
-			configurations {
-				conf-jh7110-milkv-mars {
-					description = "jh7110-milkv-mars";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-milkv-mars";
-				};
-
-				conf-jh7110-pine64-star64 {
-					description = "jh7110-pine64-star64";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-pine64-star64";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.2a {
-					description = "jh7110-starfive-visionfive-2-v1.2a";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
-				};
-
-				conf-jh7110-starfive-visionfive-2-v1.3b {
-					description = "jh7110-starfive-visionfive-2-v1.3b";
-					firmware = "opensbi";
-					loadables = "uboot";
-					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
-				};
-			};
-		};
-	};
-
 	spl-img {
 		filename = "spl/u-boot-spl.bin.normal.out";
 
-- 
2.47.1

