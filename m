Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CB606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PxT6bNBF;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=kijoyS5A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81AD48109F;
	Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOcvpJDca7HZ; Mon, 16 Nov 2026 17:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C3CA481094
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850564;
	b=ZnI4DKT9odS9MwDTU6cfM6d69oRgGNrdeKnBbcdwhfbH9Wv9GBdwnmxs/vZRz4jJS2/H
	 P03seWuesZD9TIOWD/Wb49kYxTsnaD/XvBhEI7uobjl4sF6sQzH536SLRKZb5gzuLugOK
	 J51gmDtvyvT8jvJah4vUO0cjQbQ3I+r6Hr24SQ8VWB5PFjN2UQtOh/VGFsYPHArqDNPUD
	 2fmUYk4v2lpMbi+wE0m5uyUmP1mhpHbZseD0I00cZGc9q0uYc4Pnvwt6kISynWvNLMu78
	 cTGYMu+ISkQu5AnFn1Na7LgbiuaX9ZEIFCpVhXHk5OYlPcyx28zjXDfOA+fStVCK9cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uDWUZwAH6QkCIDzLbfg/7+cvrrtS2rBwYYQaz/JBRNU=;
	b=lnNLcf68BVMeBuYxf0nR8rdRpcPJhFiDt/1ougRsxkV53a60OVdwXD9MTBA5ne9l+uoM
	 BTESg/+TBlcKuYIKDXC9zOkbdpi5DTP8UpBAOdtNnAF9NkFTBcCBYwdQLQG9az0S83krI
	 PDMuFEyZ6HUK3//qXsK9+8LMirf9atLL/QHMGf6EcdnVUqlQZiEaaiqnDD1t/qcuPwyxt
	 tTrkcHzHsSobEgQkoty5hl2/827om6BOqdFWjTl1hA4oNvixKsc38kHu8BSTFlFefnIv4
	 nsnBDhyPZUsWvoCtjY31IquwEOy/RiMJjNVpXFQdMFmNrEgS4sPkfc7dgHPGfmA9ICg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850563;
	bh=uDWUZwAH6QkCIDzLbfg/7+cvrrtS2rBwYYQaz/JBRNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PxT6bNBF0sF/tZwfLMYs0KgfLPm/Zh+DyciYfG5d5wlA6iTXaHNztxqk+UbMV443g
	 IpqivD3BosW4ZuvSiDty8XOXap4ZNu/QfK+PT4+bThItqDzBt6koScbdkgUlR6NAqd
	 +zQzv3sVRNJqKSsZddJMfY1h5lfk+TluCnsn/FtS2vUoHRyMMTJenx4F3kwyBgeh+a
	 vZFdbkPAuQMxEn96G5BWg1rsZ0Av2ADeRzF9BAt2euFKXaLuD+gdxD7k2qBmFaVaFW
	 2Woa9KK4kbNFbRZ4zLJDu/bCkVZBXo/PQ2wWR06H/MgX8uccl1mVhzYEwh4fPpMGUA
	 6Ov5eFQuMM34g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3CA481094;
	Mon, 16 Nov 2026 17:36:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D97FE4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9B876075D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UV2aJD2eTEVK for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6A2A607EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=kijoyS5A
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B6A2A607EB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:56 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jSw4n0qNTzMlvB;
 Mon, 16 Nov 2026 18:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDWUZwAH6QkCIDzLbfg/7+cvrrtS2rBwYYQaz/JBRNU=;
 b=kijoyS5Aq0yXy/Xu5bkbY4zi2hngFaR6KBkmNcxo60xzRE/Qb8jU4hcMP1wuIMrDkEwn+M
 nHP1L8/CLI+R9lvzWsRzR8BVTfzv0Jb20ZmndimxRlp98fvcCFc4kOckR5PmuCJc9fUYud
 LSVF+c3Lz6V7LKnGJijwANi9QW5odzsylDypbXcuhKenBhGHg/naOKN7+g13/26fFDKu+F
 JnJXcoITMy51QfBw5PTWYJL1/R+ukLzveXa/L1IFGgG9qIkOnryOSvX9eLkTx1KLf9JBR8
 7MPD43/Mdj87RpUnK8thUXSUBd+3DSWPXRWhmbZmr7wGHV9dWLtui6VCLEYExQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/20] clk: exynos: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:43 +0100
Message-ID: <20261116173546.3487841-4-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: bhxmckjusi9iidk65g1im4198nqbam46
X-MBO-RS-ID: fdb419c4682a019a71f
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

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/exynos/clk-exynos7420.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/exynos/clk-exynos7420.c b/drivers/clk/exynos/clk-exynos7420.c
index 7de4e688f03..bd81dd1605e 100644
--- a/drivers/clk/exynos/clk-exynos7420.c
+++ b/drivers/clk/exynos/clk-exynos7420.c
@@ -104,7 +104,7 @@ static ulong exynos7420_topc_get_rate(struct clk *clk)
 	}
 }
 
-static struct clk_ops exynos7420_clk_topc_ops = {
+static const struct clk_ops exynos7420_clk_topc_ops = {
 	.get_rate	= exynos7420_topc_get_rate,
 };
 
@@ -155,7 +155,7 @@ static ulong exynos7420_top0_get_rate(struct clk *clk)
 	}
 }
 
-static struct clk_ops exynos7420_clk_top0_ops = {
+static const struct clk_ops exynos7420_clk_top0_ops = {
 	.get_rate	= exynos7420_top0_get_rate,
 };
 
@@ -207,7 +207,7 @@ static ulong exynos7420_peric1_get_rate(struct clk *clk)
 	return freq;
 }
 
-static struct clk_ops exynos7420_clk_peric1_ops = {
+static const struct clk_ops exynos7420_clk_peric1_ops = {
 	.get_rate	= exynos7420_peric1_get_rate,
 };
 
-- 
2.53.0

