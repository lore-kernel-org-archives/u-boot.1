Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D23EC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 06:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAC4780E7E;
	Wed, 19 Aug 2026 06:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hdbCPJGNkFRd; Wed, 19 Aug 2026 06:59:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787122793;
	bh=pCYEVE0mN/3RFzULpQjoEiiLWREjfNRl8BVc46eS9co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kfqMiNRGaNh/O0EtLGeJGirFmbQxhovwAelzDuK9T2KXMHrIO1KFLshV7xvM5e1gD
	 Cmwjd14ofP0Bol0UeahObhE+VyESWCaxuASYNgfcXVok2/JH2ZmPq25d97j1RHB6hZ
	 zRn+0MzjhsdB9Q2tDT/Z9GLBVMUMhNDKaCePS25jIWT81AS8LfZ1CT0UqS3ZgBSoDL
	 NXXtboptcL8AC3RLWz3NITq4fR7eGQuGYsEiZ2XRd9llsmzZfP94seb8eqx8/5xreX
	 M4ywGJ7DWeVvLa8xtu6ZezHdrqbnUlR9f5lp74gKF286mx6fHdu4/MLFR6o9ykqV0k
	 qTXfU2shJFQyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDB0A80E51;
	Wed, 19 Aug 2026 06:59:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09E90230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E40B440026
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gF7U6qoaVL1f for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 06:59:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=OWZGtskv
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDF584004D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:59:46 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787122785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCYEVE0mN/3RFzULpQjoEiiLWREjfNRl8BVc46eS9co=;
 b=OWZGtskvTyzjvsfZRnvoAkNw7OcyT+I0H+oBCTR5Sw/L/PrHWlazofBRAM8O7tjGJSbXsf
 JylcBaJTRs3bj637+3Z+2hdxPfproyHKmmD764snrhYBMNA2TiYhkb0Zh5pVNaVyWbxCRF
 +koAeTxJPnz0NemAKGtoXK+c0KgukVeQcJ7j3xJxk6Kk/lpXUT+A8RkBxlzJGBWcIabrT5
 C7cmt34GdmkAzy92/wTITyvkKm0dPiAQuwMeGvIWgPNWtX61pBT4GLfeZI9SgI6fO2QfO0
 fJypt/wrgnvhS3qx0GUBxwtXxPyfp5Zk1t4qeCQgSathG2dFRsNkjZV0HOezYw==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com
Subject: [PATCH 4/4] imx: kontron-sl-mx8mm: Stop printing error message on
 first DDR init
Date: Wed, 19 Aug 2026 08:58:01 +0200
Message-ID: <20260819065804.32156-4-frieder@fris.de>
In-Reply-To: <20260819065804.32156-1-frieder@fris.de>
References: <20260819065804.32156-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The first try might fail and we are retrying for smaller DDR sizes
after that. Don't print an error message to not confuse the users
of 1GB and 2GB variants.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/kontron/sl-mx8mm/spl.c b/board/kontron/sl-mx8mm/spl.c
index a5cdd2ab6d1..ebb883f861a 100644
--- a/board/kontron/sl-mx8mm/spl.c
+++ b/board/kontron/sl-mx8mm/spl.c
@@ -77,7 +77,7 @@ static void spl_dram_init(void)
 	 * Try the default DDR settings in lpddr4_timing.c to
 	 * comply with the Micron 4GB DDR.
 	 */
-	if (!ddr_init(&dram_timing) && check_ram_available(SZ_4G)) {
+	if (!ddr_init_silent_fail(&dram_timing) && check_ram_available(SZ_4G)) {
 		size = 4;
 	} else {
 		/*
-- 
2.55.0

