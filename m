Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A00AC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 15:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EDD8295C;
	Sat, 10 May 2025 17:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0aHile89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A943282A7B; Sat, 10 May 2025 17:32:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC8D82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 17:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c8d5=X3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1746891132;
 bh=9z/PyFcbUyV5HPsIPjVtNvx/xjOJttpl/eeRHB+OBBI=;
 b=0aHile89xpF7Tp1ZJvjNERc9VYZ5rtE1pu4hWa9DWml0uyZwWvszo9bLWdW3hB1/lF5GxDu++
 QMTubjkLkNbWjTnsFOPUjc4BBGmvdYtYY2/hsJIjsrM5a0PakJP29TYdphgeHlOKq7/xTLdfFfB
 sFOaj3yRdygRgC8wLicLwoI4ajiWt8dxU2vnMjUQxxoSVv6kyy5k9z+ftf8O2TpG6R4sYIPJqlF
 XRvRfrQnihDy7Wqwp96275ERP0JyFuqm2BnUb6q8T3ADbde/opvK41cak3VOesTAwqQfyqUspyG
 2cyVk/O8gfS03htbwUbh2yXQh7KoF1RtMw2sIrncRKgg==
X-Forward-Email-ID: 681f71783f6f4dc1ea0816ea
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Dang Huynh <danct12@riseup.net>, u-boot@lists.denx.de
Subject: [PATCH v2] clk: Fix clk_set_parent() regression
Date: Sat, 10 May 2025 15:32:01 +0000
Message-ID: <20250510153203.569240-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
while reparenting") add a call to clk_enable() for the parent clock.

For clock drivers that do not implement the enable() ops, like most
Rockchip clock drivers, this now cause the set_parent() ops to never
be called when CLK_CCF=n (default for Rockchip).

clk_enable() typically return -ENOSYS when the enable() ops is not
implemented by the clock driver, with CLK_CCF=y clk_enable() instead
return 0 when the enable() ops is unimplemented.

Change to ignore -ENOSYS from the newly introduced clk_enable() call to
fix this regression and restore the old behavior of set_parent() ops
being called regardless of if enable() ops is implemented or not.

Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Dang Huynh <danct12@riseup.net>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
- Fix ENOSYS typo in commit message

This fixes a regression introduced in v2025.07-rc1 that stop
assigned-clock-parents being applied, affecting network and video
related clocks on Rockchip platform.
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index bc4d76277cd9..2167cd5ad0fe 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -627,7 +627,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		return -ENOSYS;
 
 	ret = clk_enable(parent);
-	if (ret) {
+	if (ret && ret != -ENOSYS) {
 		printf("Cannot enable parent %s\n", parent->dev->name);
 		return ret;
 	}
-- 
2.49.0

