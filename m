Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF610C54FCD
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 08:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AE4160BCD;
	Sat,  1 Aug 2026 08:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ArRt4nv4SJn; Sat,  1 Aug 2026 08:55:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CF5160BB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785574541;
	bh=RtyzKP1A4VRJG4s1HwJLB8yY3umueRRuj7Gxc3meh1M=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=elAljv9HT+jpM1Q7LxBqJydQ9fA0G7EreTOFQ4AfnEm1J/BoRcslJTHmC/+wcZdxQ
	 dYVaZQCaOdCp/9qma5wpknwp3Z2cvVMq/FrS6vHoL69tzV2mFfqiKj0TUSi5mPwS+9
	 R+USDm+XasVRbCGRnEK/q1xA94gMAijnC0KE9zWnCRgabp+bdoM76wjkGNjS1y2YSD
	 3/2K6NB4A4c6eHLu1p3lrRfObd1o5PtKuS6w10syYmBOO+RFn6vubrwabC1Ng6/I5+
	 wAJjEMoloVVpu4n4wqKbez6Gg9Y8mK7dexj7zG/2TzlLVp/tl0Jb4glHnoR1tljnzx
	 aq4vZ2VZptwYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CF5160BB7;
	Sat,  1 Aug 2026 08:55:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EBB23A6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C8D080E2F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 166q9Kd8ilAR for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 08:55:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 16C1180E46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16C1180E46
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16C1180E46
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 08:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785574517; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hSlkXPkdJ8nSqCEGFvwVsSrLkk937ME9frhgaRH0Fz9tB+wbLpU1WP9/Z44iiYqh17O9Fm5R9TMCoghhELPw/+yhF1pn6xUdrzpPP/yGR+ecCCKsMnt236zXkXGUKsBcHlbXnfaFqfy1HcAw+O9yO8JUhNgjD8QfIRkjBla0DZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785574517;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RtyzKP1A4VRJG4s1HwJLB8yY3umueRRuj7Gxc3meh1M=; 
 b=BijoZV+wY3mwzziK6AmfNPxWBa1mb4AC9ejyIAYiAjBrkpT1joBJhxAwQbbuJGAd5rtvnryRO2uM8B6Nu+HHVTrFZa3LDS/dYuaFp+mdjnM1dJP0RIyHb8qZseAg95169EAvs6ozWq2JoRPkJsT05o5m7A+qR9n903Cwv+16ZKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
Received: by mx.zohomail.com with SMTPS id 1785574515385414.7919067279614;
 Sat, 1 Aug 2026 01:55:15 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 01 Aug 2026 16:54:24 +0800
Subject: [PATCH] clk: spacemit: Fix empty PLL rate table handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-k1-pll-fix-v1-1-5ad65231a361@pigmoral.tech>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWZukdedVxEJ1MAjSIhLx7orld
 5LzX2DJMFkovAsMHWx5mR2k70HT13NHyNoZAhEkIhMSR4nrNGHLJ4axrnWcRrlWCtxhNeTmL1Z
 Wv+2uBmq2twD3/QBj/qewbgAAAA==
X-Change-ID: 20260801-k1-pll-fix-35dad5749dbb
To: Raymond Mao <raymond.mao@riscstar.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Coverity Scan <scan-admin@coverity.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=vVRDnRhcdXkLSou0K3XpHBxUoftFkQD87tDXqt0XgzQ=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJyt8Rs23f5/Zm4SV8fbHcWX7nqYfGp0xsZgt76LykUk
 qmYL6ByraOUhUGMi0FWTJGFy1/8n7UOz7cjAq33YeawMoEMYeDiFICJGC1m+CvCwZi+nNXquefE
 zG0dyQUGASsLPun+OrYxeNIbZhOxXyyMDGv51x9R+zM5vfCJPEe67T+uPY99co19GgQWuX+p4v5
 exgoA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785574517; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=RtyzKP1A4VRJG4s1HwJLB8yY3umueRRuj7Gxc3meh1M=;
 b=BmHrXDMXTYenj6sOh7m4yVHH6RYowa+PVfHc0chiDw5T/gaEgITd3jK/QjYBsjPz
 gaUj7b0kzF2qKtKkYhTeJMds5dbG8fadKDaqi15evwF4bsBQcK3bkISUEr1bVwcRNU1
 3sWYKgUr+OBeDJ5uLfbN1yIXg2uMN1hBI2Y9f4+I=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=BmHrXDMX
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

ccu_pll_lookup_best_rate() leaves best_entry uninitialized when the rate
table is empty. Initialize it to NULL and have ccu_pll_set_rate() return
-EINVAL when no matching entry is available.

Fixes: 3aa2882a3e1a ("clk: spacemit: Add support for K1 SoC")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/spacemit/clk_pll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/clk_pll.c b/drivers/clk/spacemit/clk_pll.c
index 56da70af58af..d0fa43a4ee63 100644
--- a/drivers/clk/spacemit/clk_pll.c
+++ b/drivers/clk/spacemit/clk_pll.c
@@ -10,6 +10,7 @@
 #include <regmap.h>
 #include <linux/bug.h>
 #include <linux/clk-provider.h>
+#include <linux/errno.h>
 
 #include "clk_pll.h"
 
@@ -24,8 +25,8 @@
 static const struct ccu_pll_rate_tbl *ccu_pll_lookup_best_rate(struct ccu_pll *pll,
 							       unsigned long rate)
 {
+	const struct ccu_pll_rate_tbl *best_entry = NULL;
 	struct ccu_pll_config *config = &pll->config;
-	const struct ccu_pll_rate_tbl *best_entry;
 	unsigned long best_delta = ULONG_MAX;
 	int i;
 
@@ -105,6 +106,9 @@ static unsigned long ccu_pll_set_rate(struct clk *clk, unsigned long rate)
 	const struct ccu_pll_rate_tbl *entry;
 
 	entry = ccu_pll_lookup_best_rate(pll, rate);
+	if (!entry)
+		return -EINVAL;
+
 	ccu_pll_update_param(pll, entry);
 
 	return 0;

---
base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
change-id: 20260801-k1-pll-fix-35dad5749dbb

Best regards,
--  
Junhui Liu <junhui.liu@pigmoral.tech>

