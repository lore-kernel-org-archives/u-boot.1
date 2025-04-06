Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D82DC36010
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 00:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B0C82B7C;
	Sun,  6 Apr 2025 02:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lxOwFbBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841A882B41; Sun,  6 Apr 2025 02:25:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22A482B6C
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 02:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1743899112; bh=iUZ53uiF1pg6Roha8KlPpzsILKMcHLiqHIKYjwMVVWU=;
 b=lxOwFbBFRCskBrLiVQ32yrZ5kOhosFHDKCVAIDAjVW010Dsl+8fVYJ/LwVsohMh9HQ7K3SG0t
 rO3q8WffyjPlntc0h3+k9lZVJzMX89xXWzrpM8B7XoB/A8AS14n4a4Lq562AKralsbHuFt0Z2t1
 w54SDrq2AooNjnc2PlLSlSepyc+gM+FenqIbGR/2uo+W+NXvMislyGRroum24T6HzZGBbjQqoX+
 r5kTMR+U32uF7QGD2i0Nxm0mLBMaAfdsAhIVl5YsgcxFDLKddXElmUiM+bIm8MK4sXGNwO322ik
 1DW39PUR4U3hvMln2OcvxbCAQcKE5lZ5pbreu2Jtvg2Q==
X-Forward-Email-ID: 67f1c9e6fb2b6fde09d69f89
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
 Jacobe Zang <jacobe.zang@wesion.com>, Elon Zhang <zhangzj@rock-chips.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/11] rockchip: Ensure device settings is defined before
 rk3588_common.h
Date: Sun,  6 Apr 2025 00:24:26 +0000
Message-ID: <20250406002447.1555596-6-jonas@kwiboo.se>
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
rk3588_common.h in board include/configs files.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/evb_rk3588.h           | 4 ++--
 include/configs/khadas-edge2-rk3588s.h | 4 ++--
 include/configs/toybrick_rk3588.h      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/configs/evb_rk3588.h b/include/configs/evb_rk3588.h
index 4568e2cace66..5ff1ddbfcbec 100644
--- a/include/configs/evb_rk3588.h
+++ b/include/configs/evb_rk3588.h
@@ -6,10 +6,10 @@
 #ifndef __EVB_RK3588_H
 #define __EVB_RK3588_H
 
-#include <configs/rk3588_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 		"stdout=serial,vidconsole\0" \
 		"stderr=serial,vidconsole\0"
 
+#include <configs/rk3588_common.h>
+
 #endif
diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/khadas-edge2-rk3588s.h
index d279cf3826a9..fe8461d63626 100644
--- a/include/configs/khadas-edge2-rk3588s.h
+++ b/include/configs/khadas-edge2-rk3588s.h
@@ -6,10 +6,10 @@
 #ifndef __KHADAS_EDGE2_RK3588_H
 #define __KHADAS_EDGE2_RK3588_H
 
-#include <configs/rk3588_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 		"stdout=serial,vidconsole\0" \
 		"stderr=serial,vidconsole\0"
 
+#include <configs/rk3588_common.h>
+
 #endif /* __KHADAS_EDGE2_RK3588_H */
diff --git a/include/configs/toybrick_rk3588.h b/include/configs/toybrick_rk3588.h
index faa2e6c19c3e..005650896760 100644
--- a/include/configs/toybrick_rk3588.h
+++ b/include/configs/toybrick_rk3588.h
@@ -6,10 +6,10 @@
 #ifndef __TOYBRICK_RK3588_H
 #define __TOYBRICK_RK3588_H
 
-#include <configs/rk3588_common.h>
-
 #define ROCKCHIP_DEVICE_SETTINGS \
 		"stdout=serial,vidconsole\0" \
 		"stderr=serial,vidconsole\0"
 
+#include <configs/rk3588_common.h>
+
 #endif
-- 
2.49.0

