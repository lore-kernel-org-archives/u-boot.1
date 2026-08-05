Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE128C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 17:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ACE1607F2;
	Wed,  5 Aug 2026 17:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ZjFd4jSFzXv; Wed,  5 Aug 2026 17:54:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5E95607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785952478;
	bh=sAHwk1RZKQX0qjynMDCpmJZGgs8gqQLASO6MxPonFS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jvO5xXapvJUS2sRMFgqOXgtnlXK8n5U4M2nvAjhuiExOmWZPItHvN1qUG9HV4jqxw
	 tSlQfskVevcDZ4XGIJDRiBFxmvbXQpuUnFkSebf67x7r1CbP9g+/JCqheJ0ZdPs0No
	 l+bwjGD1FnYuDnHwEKVOnMWpYKN5joDtFnZqUr2g+R0aZOeKtxEJaXDDYyoxYYhK7g
	 Hzm2JpaAolH7bm7dwR+rJXUVVerlAAS+ITSdxFcsJSkL0SttOp3WEi7pSXnUtE7tLE
	 Sq+u9be55htmLgijbEF0M28zNWZazmhFjkwnlx/i1XNRBlUC2R/NlPNu44XUdaK0yl
	 ta0JtD+AN0APw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5E95607CA;
	Wed,  5 Aug 2026 17:54:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22A5C730
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20723607CA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7VPF7V-22dIl for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 17:54:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=b88b=f7=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1A52060786
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A52060786
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A52060786
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 17:54:36 +0000 (UTC)
X-Forward-Email-ID: 6a7376de5694ca629d62bd4b
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
Subject: [PATCH 30/30] rockchip: rk3506: Remove unused rockchip_get_cru()
 helper
Date: Wed,  5 Aug 2026 17:45:01 +0000
Message-ID: <20260805174509.2968252-31-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805174509.2968252-1-jonas@kwiboo.se>
References: <20260805174509.2968252-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1785952475; bh=sAHwk1RZKQX0qjynMDCpmJZGgs8gqQLASO6MxPonFS8=;
 b=Yu2gqsfz/zpRZ9DMWVIA8KRaXHPY4xdf5MmzbaVSS4DVQCjgQ7eKrypzYAAU8WFIBc2dQhAq+
 UyrA+D0p6VZju7MYbRSQcM8x3L4kWgSuQ1dtTNcdQ2q1o0qfsq9OA4B5a5bPJ6DMeWBNDm0WuPQ
 g8KpWOMpD1LGZLEnqgSmAwYqZdMxvDTIfhc7bwfDaWnCiMqtBIfHs1BsR0D5OKBS0WU5ZwBZkyk
 St/RVmvpbj6hXrf/yO7ON+GI+hTLxQPnzmZ1chQh8PSvomRONcsW+wBlK3wez5d0ry2WF0Y3X1W
 M6FWqm0if/lcIR/rKmeuxQgshkxPbTDf5KrdsSZvoDpQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=Yu2gqsfz
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

RK3506 have no uses for the rockchip_get_cru() helper now that the
sysreset driver and cpuinfo no longer use it, let's drop it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3506/Makefile     |  1 -
 arch/arm/mach-rockchip/rk3506/clk_rk3506.c | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c

diff --git a/arch/arm/mach-rockchip/rk3506/Makefile b/arch/arm/mach-rockchip/rk3506/Makefile
index 63a6c2c2d18d..8b633d5c383e 100644
--- a/arch/arm/mach-rockchip/rk3506/Makefile
+++ b/arch/arm/mach-rockchip/rk3506/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 obj-y += rk3506.o
-obj-y += clk_rk3506.o
diff --git a/arch/arm/mach-rockchip/rk3506/clk_rk3506.c b/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
deleted file mode 100644
index e3161418302e..000000000000
--- a/arch/arm/mach-rockchip/rk3506/clk_rk3506.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-// Copyright Contributors to the U-Boot project.
-
-#include <linux/kernel.h>
-#include <asm/arch-rockchip/cru_rk3506.h>
-
-void *rockchip_get_cru(void)
-{
-	return (void *)RK3506_CRU_BASE;
-}
-- 
2.54.0

