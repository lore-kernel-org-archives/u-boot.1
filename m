Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EB606A332
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ofxvmjM2;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=rvR8At/7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 055C460854;
	Wed, 18 Nov 2026 07:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rbTBJn7osRbN; Wed, 18 Nov 2026 07:23:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C6DA60842
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794986593;
	b=pTypRRuQCWgJSoiHHh9BmMEwXAqbzVWaQ3kQ32UlZ+hsH/Ket3+2S3VIhYPeTRCzXvxG
	 +UoSwrLJYLyofDHGUiOBrVi8gQoDVW56BFWd6Wmgcs580wG/C4J2dPAcVGWnqAmELMsto
	 JXjHm8OJtxusEGO4aHZgEL5vb4EF9HJMgFrpUwzbR9eal+dTcA75hP71zNKJToGHj3z77
	 TxtxvcEEyBhIZP+Wu61cc6NXhW+bCUnHpBGDOBQaM64AdYg2CbSIHtF+jjgym2ENTLv5t
	 zz0bhcLY3zdxOt7WefJlHO0EbSMsTG2T8dywiipdRNI9QJ7uPELxygyGXD9VDHiUrYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794986593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xgYJoc1WbCPkitl4VJMJjqJCkgU74Nyzqni+s47pOio=;
	b=HsrOrLV9B887iRfeFgwNvzX2q0lCeg9yPFncLGm0Id2Wc3bhAeEfhRSlRETm0Z+iAGfK
	 jpVlZpbNS5AbHAZdvTyf3BHhwgv3UTZwj6pZ4fCtflIb8V0/nuCVSmDKZ7yMon0GkYXJ+
	 hRYICHl72sDUyZfFd/co9i0xdOIbgMON59NHaAOTHveB35fRyopKqDkdYXaj4BJwlkKea
	 +MtjbtXJP0xbP0oivLKu/De/6Okpnd9HEkxcPcqvgjy1gb73Ki8zcS+0VphdazFy8r9JI
	 e8XrddwbsqkhrbHYUxMFZN79C7ojuzthXYfk8x+qIpwuKi6TGaIErPDsnavM3yvaRUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="rvR8At/7";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794986593;
	bh=xgYJoc1WbCPkitl4VJMJjqJCkgU74Nyzqni+s47pOio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ofxvmjM2UUzTxXl4O55bF0AbJsgtS25dXAgJxY2keeLpR639cGSsThBOqfobJtjs4
	 qcTi3szohgB0BNub/KqPKcaAXTHExJHtOJmYAXjAsd2GF7/jtmHwJofatJ3w98dfQ8
	 r8rLwIvwuWFvgEQFOlx2PetRCmWR29F+I6Llfod6zVMPVUzbQirs5zfntUIy77ale6
	 ZpIzkaoK47TedfKiGfq6UQ3NV9A+hbmh5kGqgoj2wcBXHjwNO2z6164kAhQ1DL8xYX
	 6VWaSv0laQH0rVeUhpubKmXr8K7UtGLPyQtonaRYtQWr2+5AiUTT6nEfvEmJMbaeYd
	 yIme68WDVCowg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C6DA60842;
	Wed, 18 Nov 2026 07:23:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B2E949B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 489E060842
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hSVKpe7Xrnk for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B05E76081D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=rvR8At/7
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B05E76081D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:23:09 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jTtNn0STqzMlrX;
 Wed, 18 Nov 2026 08:23:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794986585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgYJoc1WbCPkitl4VJMJjqJCkgU74Nyzqni+s47pOio=;
 b=rvR8At/7UKKsHZrl+2VgBDb+ma9OSHQkWJekAGz9X69SNABa+YpYRRhvJb02+NsYx5v9K8
 YFwd3y0pE6gHvrAIW6i2UuHyfsH5xpno3YGNLp8hEKoL5gexEu86TFWotpeq9OlVuYhctJ
 niDQ0C6bOiYqBd4GDyQ7YZwcMxiKZV2PWTmGKVVTEEMuD738rYbAkD3nLHPpjIgLbGUYRy
 ZH3SzNd61k5xDjaJ29vdUgBxb1nPbsM3xFUIzrvwWK4G27ay01FL4XgN1GNM3/zh9MXTK2
 nE8qMRGCKoWdXh2vnkHx1EvB6Ek+HcFebKnCVAiCR6kEjasWz8xe5Gr3/bD9dQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/20] clk: altera: Constify driver ops
Date: Wed, 18 Nov 2026 08:22:16 +0100
Message-ID: <20261118072301.627121-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <PH7PR03MB7063CC325305C2B9A92A091EAD7B2@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <PH7PR03MB7063CC325305C2B9A92A091EAD7B2@PH7PR03MB7063.namprd03.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a032d3afe435c004f3a
X-MBO-RS-META: 4hp5bdjhu9uaurtkaisu9zkb73t18tbk
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Reviewed-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
V2: - Fix up Stratix 10 clock ops
    - Add RB from Alif
---
 drivers/clk/altera/clk-agilex.c  | 2 +-
 drivers/clk/altera/clk-agilex5.c | 2 +-
 drivers/clk/altera/clk-arria10.c | 2 +-
 drivers/clk/altera/clk-mem-n5x.c | 2 +-
 drivers/clk/altera/clk-n5x.c     | 2 +-
 drivers/clk/altera/clk-s10.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index 426f400159c..b29a7ee145f 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -784,7 +784,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 92b91a9dfc8..3a5ac3a3e8e 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -733,7 +733,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.get_rate	= socfpga_clk_get_rate,
 };
diff --git a/drivers/clk/altera/clk-arria10.c b/drivers/clk/altera/clk-arria10.c
index 081f8f2b7aa..fb409d1094c 100644
--- a/drivers/clk/altera/clk-arria10.c
+++ b/drivers/clk/altera/clk-arria10.c
@@ -170,7 +170,7 @@ static ulong socfpga_a10_clk_get_rate(struct clk *clk)
 	return rate;
 }
 
-static struct clk_ops socfpga_a10_clk_ops = {
+static const struct clk_ops socfpga_a10_clk_ops = {
 	.enable		= socfpga_a10_clk_enable,
 	.disable	= socfpga_a10_clk_disable,
 	.get_rate	= socfpga_a10_clk_get_rate,
diff --git a/drivers/clk/altera/clk-mem-n5x.c b/drivers/clk/altera/clk-mem-n5x.c
index 149e3016dd3..595daec9f7c 100644
--- a/drivers/clk/altera/clk-mem-n5x.c
+++ b/drivers/clk/altera/clk-mem-n5x.c
@@ -114,7 +114,7 @@ static int socfpga_mem_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_mem_clk_ops = {
+static const struct clk_ops socfpga_mem_clk_ops = {
 	.enable		= socfpga_mem_clk_enable
 };
 
diff --git a/drivers/clk/altera/clk-n5x.c b/drivers/clk/altera/clk-n5x.c
index 6fdc4e11baa..742d365966e 100644
--- a/drivers/clk/altera/clk-n5x.c
+++ b/drivers/clk/altera/clk-n5x.c
@@ -592,7 +592,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
diff --git a/drivers/clk/altera/clk-s10.c b/drivers/clk/altera/clk-s10.c
index 20de98cdbe9..b4db3d2fc68 100644
--- a/drivers/clk/altera/clk-s10.c
+++ b/drivers/clk/altera/clk-s10.c
@@ -594,7 +594,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static struct clk_ops socfpga_clk_ops = {
+static const struct clk_ops socfpga_clk_ops = {
 	.enable		= socfpga_clk_enable,
 	.disable	= socfpga_clk_disable,
 	.get_rate	= socfpga_clk_get_rate,
-- 
2.53.0

