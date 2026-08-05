Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E680C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45E03407C1;
	Wed,  5 Aug 2026 17:52:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXqUcvnHjsPo; Wed,  5 Aug 2026 17:52:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 848D5407B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952323;
	bh=GPLxCCSaNmsyTevm/QKKumxpPhX7q1x4M5FJ3x35KE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mc3HUJaF4T6wQ0CDVJM1X3VInwFLbmpmNUt27Kww4ZGVCQrlYiNsoSZsI3Ucq5h6l
	 dZZxXcwFTdnHLBCm8sI9inIWhjfKV3s2iHfTO9WpozCpemhKv7v0hbuTQSc1j1B/Ud
	 zH/qSCZ76N3t/bV1NyTCrZr8oZmEMQIa/kgY5QT0wtmfwyN56PHgtfoPM599yfjeim
	 NLbnXbUYYWteM3xzYOEesJix9yifzfkDsYXF+oOaHFsRhk0h2gwhbNyQXesBoh9iW9
	 Ihj/hmu/UFKc4yOL+WK+BLTbnOjNaSfNvT/s4cYmGMTcIjn+i+cX9nqR/uFBYfkkGR
	 Jv/VjFcJ/vCMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 848D5407B5;
	Wed,  5 Aug 2026 17:52:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 28775730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F369607D2
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MreU4QAt6i_p for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:52:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2342D607B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2342D607B4
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2342D607B4
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:52:00 +0000 (UTC)
X-Forward-Email-ID: 6a7376dd5694ca629d62bd2d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 29/30] rockchip: rk3528: Remove unused rockchip_get_cru()
 helper
Date: Wed,  5 Aug 2026 17:45:00 +0000
Message-ID: <20260805174509.2968252-30-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952319; bh=GPLxCCSaNmsyTevm/QKKumxpPhX7q1x4M5FJ3x35KE0=;
 b=uElk2SDfoeS2xVOZAq8JKBwUfJ83zsOT6jMJoPf1PkFZj8bIeC2yRnwWZisKMt+XGShMRUip4
 4DHvDI/+JN7zZUW/YtONkaBQcdrA5fnqKM0sqeFWDYGpIoitygAPMHejZZnphst77xQO6qqmroi
 TPmc44ST+hOh/WxX0UiVZawpW0j9BhppmrimYKOdaAsETa/Oua1F6dmhzs4T8FZ0MN4hsRGaK9v
 VHEwN1J58t9cFsCkcipJn9JStFwsGA8eMOCGEHDMWNzAiCtJndHhDohBLTRhPjpvAtyD4X9QfuV
 oi7OrBXFC3jJHcBht1MC2Mr5YjQv3g2fvzJD16LRuceg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=uElk2SDf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

RK3528 have no uses for the rockchip_get_cru() helper now that the
sysreset driver and cpuinfo no longer use it, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3528/Makefile     |  1 -
 arch/arm/mach-rockchip/rk3528/clk_rk3528.c | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3528/clk_rk3528.c

diff --git a/arch/arm/mach-rockchip/rk3528/Makefile b/arch/arm/mach-rockchip/rk3528/Makefile
index 150536f59025..024545224818 100644
--- a/arch/arm/mach-rockchip/rk3528/Makefile
+++ b/arch/arm/mach-rockchip/rk3528/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-y += rk3528.o
-obj-y += clk_rk3528.o
diff --git a/arch/arm/mach-rockchip/rk3528/clk_rk3528.c b/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
deleted file mode 100644
index c9328ba4427a..000000000000
--- a/arch/arm/mach-rockchip/rk3528/clk_rk3528.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-// Copyright Contributors to the U-Boot project.
-
-#include <linux/kernel.h>
-#include <asm/arch-rockchip/cru_rk3528.h>
-
-void *rockchip_get_cru(void)
-{
-	return RK3528_CRU_BASE;
-}
-- 
2.54.0

