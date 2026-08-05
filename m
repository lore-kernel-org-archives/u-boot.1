Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA48AC55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 18:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D1A040A82;
	Wed,  5 Aug 2026 18:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGRU9nWjVk5R; Wed,  5 Aug 2026 18:04:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17B1940CDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785953038;
	bh=by/5yuSVQLATVuouyo+NX2rcSf6OG/XbxSyFHX6NPpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNp9uftJlh4WD2/nkj8DyyaVQhfPdXutGxVZ5KSnlwoTEv7tlu+TOpdRsz3mQ2END
	 immSwWyc4Jlc5x7fSAU+3hDyYIIZtKZ7gmxz8Xs4WAMJAdOhnQ6ZOxUWescaRa3VrI
	 tgPKibv7A2aY4pjw2kIizBC2CXW7vXO4kRJlHpfbhxqKJo1H/mMqVlntVqeHaMMH/r
	 CRWGew1eNdWurIYHFQTmPT2tWwhZWR2lXln1xJhN762oxAVWfWvV2ZVG9lKNl5YYWZ
	 0n9HbdaIpp24M3XSj5D1lTKYmlm+c4t3Jpu5oP/REGPtWtXOzkSNM9R9ZlOLQnpxyE
	 K4zMYF5sy1qMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17B1940CDF;
	Wed,  5 Aug 2026 18:03:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CC002730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:03:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BD7A1607DA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sioOu_OUxmak for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 18:03:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B2EFB607CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2EFB607CE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2EFB607CE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 18:03:54 +0000 (UTC)
X-Forward-Email-ID: 6a7376db5694ca629d62bd0f
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
Subject: [PATCH 28/30] rockchip: rk3576: Remove unused rockchip_get_cru()
 helper
Date: Wed,  5 Aug 2026 17:44:59 +0000
Message-ID: <20260805174509.2968252-29-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785953033; bh=by/5yuSVQLATVuouyo+NX2rcSf6OG/XbxSyFHX6NPpg=;
 b=ftpsViHE8JNN9LM6KQdYmZ2mcAifwWDkl6egRUMZbA7vg0FjPNxnBunvvIQXfWgfmZo9Xy4kj
 O/uLT5R+/hIDrrKQgMvZaRSxiSCBmVfbX8gUf3bZ0McmWp4P9bKP+ZK0MFPTdzwskpc38oWOgWN
 /d/NWRAm2pvhuIoTy5wJWOqx7+wZvKL/GJp9LWl91TmFURpPpcfgEeXwT5bM4xaNlM+axG/qaYd
 NCPh4AELmF9wSwllwWK+ysoyEdlEcB2YaoD7mL03iyva4vb2zNECw0toc14rzQBhSz+xMo5g6fG
 JZ1IDb2t/uo2OLNFBkrAWx6gIUU9t60UcvUEoXFevY+A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=ftpsViHE
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

RK3576 have no uses for the rockchip_get_cru() helper now that the
sysreset driver and cpuinfo no longer calls it, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3576/Makefile     |  1 -
 arch/arm/mach-rockchip/rk3576/clk_rk3576.c | 12 ------------
 2 files changed, 13 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3576/clk_rk3576.c

diff --git a/arch/arm/mach-rockchip/rk3576/Makefile b/arch/arm/mach-rockchip/rk3576/Makefile
index bd7399cddaac..a8b09c24a50b 100644
--- a/arch/arm/mach-rockchip/rk3576/Makefile
+++ b/arch/arm/mach-rockchip/rk3576/Makefile
@@ -5,4 +5,3 @@
 #
 
 obj-y += rk3576.o
-obj-y += clk_rk3576.o
diff --git a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c b/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
deleted file mode 100644
index 6e16a61772e2..000000000000
--- a/arch/arm/mach-rockchip/rk3576/clk_rk3576.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
- */
-
-#include <linux/kernel.h>
-#include <asm/arch-rockchip/cru_rk3576.h>
-
-void *rockchip_get_cru(void)
-{
-	return (void *)RK3576_CRU_BASE;
-}
-- 
2.54.0

