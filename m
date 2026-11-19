Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83001606A337
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=09HsM3My
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5281C81374;
	Thu, 19 Nov 2026 18:34:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5k5ZZDWxMmQy; Thu, 19 Nov 2026 18:34:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 828CF81380
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795113285;
	b=pcP0qxCU61bjxMKC6AL8I7spanH7PYDBKyQtrYxX0gQApGGW8jkdYaYBZ3rhmzMJvxc9
	 jWbpW0aV6L/wn6fi60zSCLlev/JTtPe52O5coQQFN4zV1jooPWO/L6LKit5ZPhIEai8VF
	 71CHZPI4CH37HznzivFAm0YUP7c5p6vE5cypXN1W1a7L6qMCEa1LOjkmdxZm3a5MSlg2j
	 K37wSEV0Sa5PxaFij2u6jiFFV/Rhg05T6d7Q43glzsC2r1Sm/Ev4vuWpbY+NipSwmP4KD
	 A+xU9JBQ0O7tkF/vWF+XOZ1HqWTiv0blRDuWF1V8xLR7dcYqU/HV2WxPsjMDPMCYDqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:From:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2OgCy2uN7QPWYnvKGBCm7py3gctm0ER1NyhrKOljOOc=;
	b=hSEmTjARBnDZUuvcW5PiIthTL29a6ADHUHcGNyDyuf1KV08uqAOjsYaLS4TWntRF3QLm
	 wJfvATtu/ocEkBjrGk3IRLPMirtmsLAtSZ+N8kWzcQu3T79sAWw8aKy8dRmavM3Lu25JL
	 MmZJrQ6mMaG2TDLlpnJEdzr2lhanhPEnM6i9HBYRwyOlTCQn2n1oLuxon80E6clMqew1C
	 kMXWN2x2mfXYYzhOF31SDYJP8DWdZx+8D5UoEICUKMIS/z6R9QD4p+mo7KgBmHen849n2
	 wFKidr8QCJB8G+plEZHv1xS/F6/5pJXHSyfaV1+nj9qQuxtYPM2XU6duNvZ91qmLYyw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=lst.de;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795113285;
	bh=2OgCy2uN7QPWYnvKGBCm7py3gctm0ER1NyhrKOljOOc=;
	h=To:Cc:Subject:In-Reply-To:References:Date:From:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=09HsM3My6Jw+affRoGArdmsieiyKXUdLD6xWXYT06HrPBLSFgT2eq4fUjkf1GeN3Z
	 GwnViPVIPB2lWSg22QZGpP7/MzzGxAqnJRy1o9nyHG6VIex2QIutJhozdliB1aWjwF
	 rtlKB3TaNKghBYFpsHGvCzfsPdM4PdWt9kQwl1OTtd5a2QkdlN9d/C1SpM1XQCC39p
	 DUUSWfPd65Y6AxWXGvEEi4L0yTSNSXSmH0XhFdUF+uFd/rN1Yq85YYpfKdUruxoLNR
	 a1nnG1x3uuAqbF66ttp+m8/HRqXU+Xnm/4tC30AngquiaARG1EFG5JcxRSzhdt9lex
	 PGLOQzhK3z6ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 828CF81380;
	Thu, 19 Nov 2026 18:34:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04D6122B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBAA381374
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lC7tSR9X50K1 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B2D8812CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=213.95.11.211
X-Greylist: delayed 112 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 19 Nov 2026 18:34:42 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lst.de
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=213.95.11.211;
 helo=verein.lst.de; envelope-from=duwe@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B2D8812CF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:34:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2005)
 id 5D39D68C7B; Thu, 19 Nov 2026 19:34:36 +0100 (CET)
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 1/2] dm: core: try harder to find a DT node for DMA constraints
In-Reply-To: <20261119183244.D163768B05@verein.lst.de>
References: <20261119183244.D163768B05@verein.lst.de>
Message-Id: <20261119183436.5D39D68C7B@verein.lst.de>
Date: Thu, 19 Nov 2026 19:34:36 +0100 (CET)
From: duwe@lst.de (Torsten Duwe)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Torsten Duwe <duwe@suse.de>

If a device node got created dynamically, there is no guarantee that the
parent node has an associated device tree node which could specify dma
constraints. Especially PCI(e) enumeration adds intermediate "bus nodes",
also dynamically, and thus without an associated DT node.

Try harder to find the correct configuration by walking up the tree until
a DT association is found, skipping all DM nodes without one.

Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/core/device.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..6646358a6ad 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -459,12 +459,20 @@ static int device_get_dma_constraints(struct udevice *dev)
 	u64 size = 0;
 	int ret;
 
-	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent || !dev_has_ofnode(parent))
+	if (!CONFIG_IS_ENABLED(DM_DMA) || !parent)
+		return 0;
+
+	/* Walk up until we find a parent that has a DT node */
+	while (parent && !dev_has_ofnode(parent))
+		parent = dev_get_parent(parent);
+
+	/* No parents have a node, bail out */
+	if (!parent)
 		return 0;
 
 	/*
-	 * We start parsing for dma-ranges from the device's bus node. This is
-	 * specially important on nested buses.
+	 * We now have the nearest ancestor with a DT node.
+	 * Try to parse the 'dma-ranges' property from that node.
 	 */
 	ret = dev_get_dma_range(parent, &cpu, &bus, &size);
 	/* Don't return an error if no 'dma-ranges' were found */
-- 
2.51.0

