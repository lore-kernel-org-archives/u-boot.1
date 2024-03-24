Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF99C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 15:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B89C875FA;
	Sun, 24 Mar 2024 16:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTZSDzTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 908D787D2F; Sun, 24 Mar 2024 16:19:14 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA211879E0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 16:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56bf6418434so1385106a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711293551; x=1711898351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
 b=jTZSDzTpvRWx0g3jiXUAskcYf71PDf2wnMg2peu5r9DBsEsZnxxlKp45Xy413ekT7k
 8LHG7N2LX++OkWik8CEVKyY1Ab4sauQKc/819hBMSMD8kWg37tHrrZoKeO1WaeILXHmh
 3N1VOSHGEmq7kgawSamfmgVXMQ7y29bNvLbax9dbHRXoYARpKmcnStU8A4No+/tzorxv
 +fguPy3+nyfPMQPF1ecEg28BCRMp/+s/JI/wppru/VFbW0WQG27TEjoIMQC0o94XYmLP
 RfBRLfVHxbpoIGjECTrHNEl4xsLd2zMECqRPIujvmYHBNZqdHdiCCaytyfeBIUQ1q+9v
 wcVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711293551; x=1711898351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ze781fdYMJC8X6yPwfz4FQS/isO5gR11eLckzIKPCfI=;
 b=fxaYJgj8exwgFU/YyO1SWoyerCz+D4NoTvhb+7JHUtYaSOvLQD0ocd2tnhUEFFk3s0
 JiPX5OaDw0nuhQqIUYh6Z8FeNMa+VNIlTnymSSib0l2DkpHFBL5q9YdTxBaWSWJwFEkb
 QpHrqWz6wog+fP7FohULJO31LXoZ6ikvHdYjGOo1/Esz2HReEiP64RD+VZjQCMicBcI1
 mSF1WQgia0cyVU5VPfjO1j0FX+P1zZd9QNvipRq0eSj1zGTbcMPpI8W3RYg9r2Ix+rK3
 V4iTPAMlYTqYiKOF1MdDYkqucU9eAJCjRHjWANiB4TO+VHGJGyQGIrdKY89HjKat0sje
 lu6w==
X-Gm-Message-State: AOJu0YyQvLbrTuD9U4eGS4zeU7kX2lK98i6CGXMw0iiFy01DJDlvSnXH
 eBpMLQGgprngkqTem2VJ+WTXDvYt7MUZAum27c2YGXB+7kMkJDjrdgF+Bc0Ww1k=
X-Google-Smtp-Source: AGHT+IGWop+tRdvatwhyMLUo6vB2OpRCupGJ56dqduh0sfpCfS2PruM3icraWlMqlzpjp74V6KKbQQ==
X-Received: by 2002:a50:d594:0:b0:56b:902e:b144 with SMTP id
 v20-20020a50d594000000b0056b902eb144mr2966510edi.12.1711293551532; 
 Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 o26-20020aa7c7da000000b0056bf34d656dsm1996114eds.29.2024.03.24.08.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Mar 2024 08:19:11 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: fix Ethernet on WeTek Hub/Play2
Date: Sun, 24 Mar 2024 15:19:04 +0000
Message-Id: <20240324151905.3817732-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240324151905.3817732-1-christianshewitt@gmail.com>
References: <20240324151905.3817732-1-christianshewitt@gmail.com>
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

Placing the snps,reset content needed for Ethernet to probe in a common
uboot.dtsi results in the content not being used and broken Ethernet. Fix
this by creating two board specific dtsi files with the right content.

Fixes: 67d5128df950 ("ARM: dts: add support for WeTek Hub and WeTek Play2")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 ...u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} |  0
 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi     | 13 +++++++++++++
 2 files changed, 13 insertions(+)
 rename arch/arm/dts/{meson-gxbb-wetek-u-boot.dtsi => meson-gxbb-wetek-hub-u-boot.dtsi} (100%)
 create mode 100644 arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi

diff --git a/arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
similarity index 100%
rename from arch/arm/dts/meson-gxbb-wetek-u-boot.dtsi
rename to arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi
diff --git a/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
new file mode 100644
index 00000000000..3743053eb9c
--- /dev/null
+++ b/arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include "meson-gx-u-boot.dtsi"
+
+&ethmac {
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+};
-- 
2.34.1

