Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD4C36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4951E82B48;
	Sun,  6 Apr 2025 02:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gejUdj9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2F782B4A; Sun,  6 Apr 2025 02:25:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2BA82B6B
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899112; bh=fX4JTgj3YY0VaQVdUMMCZOti2O3gRXsAAc79gSDfle0=;
 b=gejUdj9WW9jSLcZ4ylVgJTqSiFK2Xxil8U+Nu8rw7EurZPTNvpVsYfM4rFX1gRN/BGvWbNA8Y
 U2OAU4pC2kbGRIVlmnkj5ITaxkKbidVZmISKF3A4pK2UIoZcuu8PUzDFchY7SwhqTyyf0OO6613
 F3t18CC6xcYzoTI2QrU+WGgFaLnm/FhkXSJTsBioAqmZxIj/AU5a2QECxxrGSQKi7V4s21Gr504
 qQOFvDLtjproxjGjGfcacC5ti/zAxGZyVBt+ZVS9GU/Eu8cBzfQRmQzSGwnERRsX2fffb74J0ps
 hRzsXOoj1D4ihe9ojUR99vLy8Ayerpg0KdfCYpPRoUdA==
X-Forward-Email-ID: 67f1c9e2fb2b6fde09d69f74
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>, Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/11] rockchip: Ensure device settings is defined before
 rk3568_common.h
Date: Sun,  6 Apr 2025 00:24:25 +0000
Message-ID: <20250406002447.1555596-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406002447.1555596-1-jonas@kwiboo.se>
References: <20250406002447.1555596-1-jonas@kwiboo.se>
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

Ensure ROCKCHIP_DEVICE_SETTINGS is defined before including
rk3568_common.h in board include/configs files.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/anbernic-rgxx3-rk3566.h | 4 ++--
 include/configs/evb_rk3568.h            | 4 ++--
 include/configs/powkiddy-x55-rk3566.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/configs/anbernic-rgxx3-rk3566.h b/include/configs/anbernic-rgxx3-rk3566.h
index 3c4ea4e7d843..3d9e05a976a5 100644
--- a/include/configs/anbernic-rgxx3-rk3566.h
+++ b/include/configs/anbernic-rgxx3-rk3566.h
@@ -3,10 +3,10 @@
 #ifndef __ANBERNIC_RGXX3_RK3566_H
 #define __ANBERNIC_RGXX3_RK3566_H
 
-#include <configs/rk3568_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 			"stdout=serial,vidconsole\0" \
 			"stderr=serial,vidconsole\0"
 
+#include <configs/rk3568_common.h>
+
 #endif
diff --git a/include/configs/evb_rk3568.h b/include/configs/evb_rk3568.h
index a0f2383bf2f2..9070160cf58d 100644
--- a/include/configs/evb_rk3568.h
+++ b/include/configs/evb_rk3568.h
@@ -6,10 +6,10 @@
 #ifndef __EVB_RK3568_H
 #define __EVB_RK3568_H
 
-#include <configs/rk3568_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 			"stdout=serial,vidconsole\0" \
 			"stderr=serial,vidconsole\0"
 
+#include <configs/rk3568_common.h>
+
 #endif
diff --git a/include/configs/powkiddy-x55-rk3566.h b/include/configs/powkiddy-x55-rk3566.h
index 4b25c6a87740..8ace435434fc 100644
--- a/include/configs/powkiddy-x55-rk3566.h
+++ b/include/configs/powkiddy-x55-rk3566.h
@@ -3,10 +3,10 @@
 #ifndef __POWKIDDY_X55_RK3566_H
 #define __POWKIDDY_X55_RK3566_H
 
-#include <configs/rk3568_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 			"stdout=serial,vidconsole\0" \
 			"stderr=serial,vidconsole\0"
 
+#include <configs/rk3568_common.h>
+
 #endif
-- 
2.49.0

