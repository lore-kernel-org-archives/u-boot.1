Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C0BC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C72081ECD;
	Sun, 30 Mar 2025 11:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q7n1YIkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D59B981E5B; Sun, 30 Mar 2025 11:36:16 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C800E8129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so642637266b.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327374; x=1743932174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2miUrZ7HY8nzYCdxNGkwlKz5v+P5/7e/iIMoHC9Og28=;
 b=Q7n1YIkQ5d0BRW0k+y+FNXvatpTvncNBEp/qia4xDnn8TLgG8m0+RLRr7msAeADpiK
 H+2TQnUEnCt0lY+15Yh7JMGtimgHFSGzqwCQETbYaNHFOQ+HeJiVn/kxooaTek8D8E9R
 xoEBlc9gqP7BAkuIkgXc8KbaG6EUEeGsWsqsqI4mSaBuEIwrFWEzLUocNPEz6T/t+jKX
 Pgi9cwYRjZP1TJDbLA4nN3xfvO5uoHnTvmTU1EThTyHrEnq+dS6jjt69HFIApRewJrqW
 /e4m2KnOJ99L6Akgp2b53akrRop95GIa6XrTJU0xcIApiX7V/3FXsXHexUtJpBvrcY34
 nfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327374; x=1743932174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2miUrZ7HY8nzYCdxNGkwlKz5v+P5/7e/iIMoHC9Og28=;
 b=pNa57U1M9YVBpMdWIsWUndp8ffvBfeoQ7jLYwAeASnQqye1CY0nGQU5yRdEP2G22DX
 vYsUzGmo5cwkGj5hwSFC15M4OAOjhmca9Wgg6x3C1ZyjLMiau8/JOllxX0q/K8MIk0QX
 eFv0wC/Ewt6Y5o7IbuVIWqtVlsxeG4zZZ+MUQAzhKolc5Vs3SysZX9pFsPEqQJb7eCDI
 VNyT2TkF7FD9osr1gfKa4iNNKzqgQCXrquERo7lGbZ+eNhwKh8QYJpLhT7IkdnkTZ7hX
 JlKjGoFvEisEHOB0r5MBedRfMRVFax+CQX9h6yZ+6Sm25/jgZI70/b2x2bfX5WPOZEup
 aTzQ==
X-Gm-Message-State: AOJu0Yxg/3Ve6qBynDHxQqTDaLCgm6K5HVDRW2N8N4NtLSwS+pKqOT3q
 GxLIqugBX/GFqnZAgJRc5IpX/eip52X/hac9tK5m4dmwZMsZ8kJa
X-Gm-Gg: ASbGncsY6GJgx0rgctCPbtDQJ+MebSITw1Xc0tUEPxgMI6u+rhBGwtntXaJN+tcEibG
 /Du8j6HcSM2/0dVehoLbaFys7jIEqpt9dMODAgPAKG5hUAKIY1JNNvw1Aeelvgejior9ZbgWW5o
 ngwd0+C/gk0f8jqeRm8W4Xice0dauydxw35voMfuav7w/dOCdu6pxe61ITJNTEOa13LGgSVT5PK
 hpcbRKfee558LB17hhFCCAbephdPeES3gkGEPz+wviw6txqg8OxZ8GiwSaUlhSfZEX2DA0OWgCD
 fcfVsXPGnyenOcoBaB9Xw0oJ8rmI//QrYEV91nxupnkqmy8=
X-Google-Smtp-Source: AGHT+IFvWJZoJlqlmyt2OcfAHn3Wnf6AdoyapSlPIO+Kuuxh+qJQpbGGFXwN+eJjI5wck/fZnzUExw==
X-Received: by 2002:a17:907:2ce4:b0:ac3:afb1:df32 with SMTP id
 a640c23a62f3a-ac7389762bdmr401830466b.6.1743327374164; 
 Sun, 30 Mar 2025 02:36:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:13 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] video: rename tegra20 to tegra
Date: Sun, 30 Mar 2025 12:35:57 +0300
Message-ID: <20250330093600.10871-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330093600.10871-1-clamor95@gmail.com>
References: <20250330093600.10871-1-clamor95@gmail.com>
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

Since this set of drivers suports four Tegra SoC generations, lets name it
just 'tegra'.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig                                  | 2 +-
 drivers/video/Makefile                                 | 2 +-
 drivers/video/{tegra20 => tegra}/Kconfig               | 0
 drivers/video/{tegra20 => tegra}/Makefile              | 0
 drivers/video/{tegra20 => tegra}/mipi-phy.c            | 0
 drivers/video/{tegra20 => tegra}/mipi-phy.h            | 0
 drivers/video/{tegra20 => tegra}/tegra-dc.c            | 0
 drivers/video/{tegra20 => tegra}/tegra-dc.h            | 0
 drivers/video/{tegra20 => tegra}/tegra-dsi.c           | 0
 drivers/video/{tegra20 => tegra}/tegra-dsi.h           | 0
 drivers/video/{tegra20 => tegra}/tegra-hdmi.c          | 0
 drivers/video/{tegra20 => tegra}/tegra-hdmi.h          | 0
 drivers/video/{tegra20 => tegra}/tegra-host1x.c        | 0
 drivers/video/{tegra20 => tegra}/tegra-mipi.c          | 0
 drivers/video/{tegra20 => tegra}/tegra-pwm-backlight.c | 0
 15 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/video/{tegra20 => tegra}/Kconfig (100%)
 rename drivers/video/{tegra20 => tegra}/Makefile (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.c (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.h (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-dc.c (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-dc.h (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-dsi.c (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-dsi.h (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-hdmi.c (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-hdmi.h (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-host1x.c (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-mipi.c (100%)
 rename drivers/video/{tegra20 => tegra}/tegra-pwm-backlight.c (100%)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index df607303616..afcdb16c599 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -819,7 +819,7 @@ config VIDEO_TEGRA124
 
 source "drivers/video/bridge/Kconfig"
 
-source "drivers/video/tegra20/Kconfig"
+source "drivers/video/tegra/Kconfig"
 
 source "drivers/video/imx/Kconfig"
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6073bc5234a..f506f4ba050 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -85,4 +85,4 @@ obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
 
 obj-y += bridge/
 obj-y += sunxi/
-obj-y += tegra20/
+obj-y += tegra/
diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra/Kconfig
similarity index 100%
rename from drivers/video/tegra20/Kconfig
rename to drivers/video/tegra/Kconfig
diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra/Makefile
similarity index 100%
rename from drivers/video/tegra20/Makefile
rename to drivers/video/tegra/Makefile
diff --git a/drivers/video/tegra20/mipi-phy.c b/drivers/video/tegra/mipi-phy.c
similarity index 100%
rename from drivers/video/tegra20/mipi-phy.c
rename to drivers/video/tegra/mipi-phy.c
diff --git a/drivers/video/tegra20/mipi-phy.h b/drivers/video/tegra/mipi-phy.h
similarity index 100%
rename from drivers/video/tegra20/mipi-phy.h
rename to drivers/video/tegra/mipi-phy.h
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra/tegra-dc.c
similarity index 100%
rename from drivers/video/tegra20/tegra-dc.c
rename to drivers/video/tegra/tegra-dc.c
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra/tegra-dc.h
similarity index 100%
rename from drivers/video/tegra20/tegra-dc.h
rename to drivers/video/tegra/tegra-dc.h
diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra/tegra-dsi.c
similarity index 100%
rename from drivers/video/tegra20/tegra-dsi.c
rename to drivers/video/tegra/tegra-dsi.c
diff --git a/drivers/video/tegra20/tegra-dsi.h b/drivers/video/tegra/tegra-dsi.h
similarity index 100%
rename from drivers/video/tegra20/tegra-dsi.h
rename to drivers/video/tegra/tegra-dsi.h
diff --git a/drivers/video/tegra20/tegra-hdmi.c b/drivers/video/tegra/tegra-hdmi.c
similarity index 100%
rename from drivers/video/tegra20/tegra-hdmi.c
rename to drivers/video/tegra/tegra-hdmi.c
diff --git a/drivers/video/tegra20/tegra-hdmi.h b/drivers/video/tegra/tegra-hdmi.h
similarity index 100%
rename from drivers/video/tegra20/tegra-hdmi.h
rename to drivers/video/tegra/tegra-hdmi.h
diff --git a/drivers/video/tegra20/tegra-host1x.c b/drivers/video/tegra/tegra-host1x.c
similarity index 100%
rename from drivers/video/tegra20/tegra-host1x.c
rename to drivers/video/tegra/tegra-host1x.c
diff --git a/drivers/video/tegra20/tegra-mipi.c b/drivers/video/tegra/tegra-mipi.c
similarity index 100%
rename from drivers/video/tegra20/tegra-mipi.c
rename to drivers/video/tegra/tegra-mipi.c
diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c b/drivers/video/tegra/tegra-pwm-backlight.c
similarity index 100%
rename from drivers/video/tegra20/tegra-pwm-backlight.c
rename to drivers/video/tegra/tegra-pwm-backlight.c
-- 
2.43.0

