Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8610CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F108088860;
	Mon,  2 Sep 2024 18:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PJ01qUbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E250788C72; Mon,  2 Sep 2024 18:31:26 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9DB88C55
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374bfc395a5so1190196f8f.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725294684; x=1725899484;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P0vnigSa4swRPXEaQXR9o9GVecuyzii85ioKtXd3Swk=;
 b=PJ01qUbdiWl0j9LrFlF4glGt3GspR9k2IC6wZRmRK1ZcY7+7b5eLWA0x1g+gF65JT1
 jVj2CMphyVefOCSLNDktRwxlE+3N+3Y3CaboiI2MlUZd29kMRcrlApHSK6hknGF63ItJ
 7YdIerNEDAeG0mBqHtoCvKQc8eitfgdjTiphWQTh8zUjq12aeXBZXkDYIeDR4FhFb7Hq
 Ovmw5OREIueZk0/qKU3BQBiO+1C3phejA3nbnpLKpqA+AQ0a5dsDYgOpLbt3lD6ua1zB
 RlfnpgsCMj48FjFkZhxxE0ZXBRum2vyv8tpK44/TrP88Do1Rjh2pwYRJcqF/tGS4pIe/
 +vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725294684; x=1725899484;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P0vnigSa4swRPXEaQXR9o9GVecuyzii85ioKtXd3Swk=;
 b=XMt0AN2OpTHLecE7bPa2M4V2YVQjpZwkFpqBQmECBn41EePAnHCUv+EVKj3xpYl2a5
 oi2pksqQSinqYRUPo/KfnR1ghNXT1aMkrUP9/85ri9SBZxG3wMNC91VqyWPx81BcDxH8
 AQZsBXTpS1O9DV4GhkcUe63+TY6yjyrZTPd/e3IRQj+e84FKZ8oOJmuRWvgEW60ch59o
 0UbGDEGfzsHS1/hv3jmSGMcsEWoyOb+16hhLZt05HKZ4O2whKuMjsovSW4KK1D5D/qzX
 dNri/S7JXH737pVp35n0U4h+2yMIjLjB/v2Ly7abwFwm2hrpzAWHyQsL3cAUg6QpAXZy
 8Y+Q==
X-Gm-Message-State: AOJu0YwxtTrzQb+CyVoDCE0iTeoMwTgtY6U2gjOqnNzyNfHCCm6opL7D
 Mxm1KxrISaV7X7E5N/gZxHib0A40G5XABR4KkiYY9DmzV6k58hw6P+19JCuazUI=
X-Google-Smtp-Source: AGHT+IFtvzfUxB5nR7HDDQDXuuiAYcqTZPFuy5VroDdDAdoibdSLhBqK1YFZtEX3hNK5u6eNnF5CRA==
X-Received: by 2002:a05:6000:2a8a:b0:374:be24:a81b with SMTP id
 ffacd0b85a97d-374be24a8aamr6923664f8f.7.1725294684356; 
 Mon, 02 Sep 2024 09:31:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:36ea:3dbe:c83a:7e39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274ccsm145122185e9.37.2024.09.02.09.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:31:23 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 02 Sep 2024 18:31:21 +0200
Subject: [PATCH 3/3] board: ti: am62px: Add android bootflow support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-sitaraupstream-v1-3-0c478c33c08b@baylibre.com>
References: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
In-Reply-To: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

When CONFIG_BOOTMETH_ANDROID is set, enable Android boot flow support.

To build for AM62Px for Android, we can re-use
the am62x_a53_android.config fragment when building A53 bootloaders:

  $ make am62px_evm_a53_defconfig
  $ make am62x_a53_android.config
  $ make

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/ti/am62px/am62px.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
index f8b6aff2c2fd..7ef54079aa8d 100644
--- a/board/ti/am62px/am62px.env
+++ b/board/ti/am62px/am62px.env
@@ -13,3 +13,8 @@ mmcdev=1
 bootpart=1:2
 bootdir=/boot
 rd_spec=-
+
+#if CONFIG_BOOTMETH_ANDROID
+#include <env/ti/android.env>
+adtb_idx=3
+#endif
\ No newline at end of file

-- 
2.34.1

