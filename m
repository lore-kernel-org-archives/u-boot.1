Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E7AE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0AC580282;
	Thu, 12 Dec 2024 11:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWcBi5QS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E15A80224; Thu, 12 Dec 2024 11:13:55 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6736801DB
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so734507a12.2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998433; x=1734603233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oD8VRAt9jSZv/xteB5kK6DoRP/el/8/etAgK0cnGEo8=;
 b=QWcBi5QSmsyPRdfYv9WezlF5tN6QWpH2vA7E/kUOtFxyDIv70iLPecfm9qtwF79Ogm
 BfBb+F5NQlF0LQmNe3hklj9cDYfwd43Dvvc2Y5aDdaG47C+pLqfQ1sNGOwiLvw12umHv
 zlQ9MlP/fUmjVLeAp8BV2yPD8ohdA9di6uCO+La1hsTFbFrANf78n7/kH7KXR9Sjbl82
 35myHGBohX9ac9PdC91XZeaHTMR44hRCFdFD4KKm2aFqs2uGYCC/WMph1Cape62utnWo
 3wP12VAWU0P9DBUnKtGBD8iSFjxUlgs6srXZA5yNMny2+di3zrMCdKChpnCoEvlPIh2c
 ebJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998433; x=1734603233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oD8VRAt9jSZv/xteB5kK6DoRP/el/8/etAgK0cnGEo8=;
 b=TZJLode6zedGRT0jaM5AL9Kxqp+PHaZyrmLG05xro8i/E2RhuIW+OrLthvVhEOrAG9
 h07cJc6xYfNcBT9IadTVmcRQ8LxotGBjfgx5KMpiyAiVLoUtEfXLOrPpCd5HgqcE8izs
 RNo8Dxm0ynV9TvEjlHMR4ajgyftmfPBgUozYL2oXyJPIOPv+gJXuPr3H3dvDom1r2sx+
 lFFQAO/K3Pl+/qRFmlo6DKJ3u6uPAdSDz4OkgOfj2Yxby/gERhaYpU8RX7ue9sbS4tuC
 76yt+sqgFXoqg2uz+pqPTOfbAVTWD1hBIzKVYEr5XV8bsOoUnI+oczVmu0qWBQw4sBOe
 VPEw==
X-Gm-Message-State: AOJu0Yyri+COwW3JeCY2jvPYj3yFBhcr3cEA+ZpTQeWaYAonABEXYNW6
 fgiDnRQJTi744FqRn8Yk6lsiPmai9PNhJ8s4rH/XYik3zvjgr/Je
X-Gm-Gg: ASbGncvP2o0CEbZd7h9fCKazr/FLbw63HVVAMvLKOJO4BMxgaSFvjhde/NJYs6JUIsW
 c7I4ebPOc0J0ZECE71iJGWQLO/F+82tc5chW4BKtV4jdnmTtXkgIjnwleDblE2zYWGM+ebN6KEJ
 ILXIyamx9g//HBM6+yHraXtrSOEUSpSbmrWO8KQ/UhrMWGbmrZOVUTRi9uffjCt7oGAT/d42ZiK
 +xYkCgqWMKVYCscZahY9dE9SLU+GaAFwjprmSBmVEBgi/NM
X-Google-Smtp-Source: AGHT+IGYCmTnje1+pmGI/1P8rw8x522/ptFVz3ZWYMCyN9EkyZDHQFawp8bDsIi+XrnTMvEvV5QKtA==
X-Received: by 2002:a05:6402:348d:b0:5d1:2377:5ae2 with SMTP id
 4fb4d7f45d1cf-5d5476281efmr344867a12.7.1733998423462; 
 Thu, 12 Dec 2024 02:13:43 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149a25cdcsm10192647a12.9.2024.12.12.02.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:13:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] ARM: tegra124: dts: mark HOST1X and DC with
 pre-relocation flag
Date: Thu, 12 Dec 2024 12:13:31 +0200
Message-ID: <20241212101331.6135-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212101331.6135-1-clamor95@gmail.com>
References: <20241212101331.6135-1-clamor95@gmail.com>
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

Same as on previous SoC generations this is required for proper
video output work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra124-nyan-big-u-boot.dtsi |  7 -------
 arch/arm/dts/tegra124-u-boot.dtsi          | 13 +++++++++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi b/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
index 376dcdf68fb..79de06761bb 100644
--- a/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
+++ b/arch/arm/dts/tegra124-nyan-big-u-boot.dtsi
@@ -7,13 +7,6 @@
 #include "tegra-u-boot.dtsi"
 
 / {
-	host1x@50000000 {
-		bootph-all;
-		dc@54200000 {
-			bootph-all;
-		};
-	};
-
 	spi@7000d400 {
 		spi-deactivate-delay = <500>;
 		spi-max-frequency = <3000000>;
diff --git a/arch/arm/dts/tegra124-u-boot.dtsi b/arch/arm/dts/tegra124-u-boot.dtsi
index 7c119725528..6a02714a258 100644
--- a/arch/arm/dts/tegra124-u-boot.dtsi
+++ b/arch/arm/dts/tegra124-u-boot.dtsi
@@ -1,3 +1,16 @@
 #include <config.h>
 
 #include "tegra-u-boot.dtsi"
+
+/ {
+	host1x@50000000 {
+		bootph-all;
+		dc@54200000 {
+			bootph-all;
+		};
+
+		dc@54240000 {
+			bootph-all;
+		};
+	};
+};
-- 
2.43.0

