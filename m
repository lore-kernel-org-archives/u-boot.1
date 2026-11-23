Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O8dAkqTG;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XkS2ZX75
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C1EF406ED;
	Mon, 23 Nov 2026 18:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rCYXcDF7-4Z8; Mon, 23 Nov 2026 18:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70D47406C8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795457829;
	b=g5YrcAfEWBsmPjww+yjtM4Lr4xjDo2XUpc6CjMu+s3nRqX6ivVAEfQzVTJiXjfsckt8K
	 nGJsIhXis9T2xw2wHRtgqGiZhfzJorQ/UEmUGP/a6ffcSGEv+6pwfGlr2GNn8FcowI2rE
	 QU/fmzFDjxQmLuR/wUQNU32x/SWqdJRVZ70wzc+uSl0nBwtDW2u/i77fU02xGcxuf+rZQ
	 yZFzinGqT/0c4SeoqftrhPzZ6kLsHGRa8BdAxhjP/D8fcvLDbgkTagMcu3pKARWnh8m34
	 J8hYQ4txhUSazfZm2rm8w75Wl+rLJnTDz/gnUHEbnzcLFNGRx/1MKjMp/PKZBCbY/iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795457829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EIWsnfTzklW11i37dkrzfwvcQEorXh357acwCbAAvuE=;
	b=WApOLn1tSW3Gkdd4UT8UasaMz8mXFC+8rohMa39GxMGt4Vovn11ECBAo1C5OmT/fxXuk
	 WHp8ly+v40S5Wj3vEZzJoPwgUStPR50QEGUcUihiUrAr8YIX5GRqEF145xp1SBMoDap9I
	 iEkq2gM0yzQ7w4/zq4Tz0dIo8f2y3Jj5ldCD05Dm1jm4syYjWaR4hXn0se9LKGL2b8CDl
	 MRTg4jhUt9vbGSwEkSOCs0tl+f/66NAnD2dENeTxCNUZJ8ySwYl1kyLOBYWZCARu7jFO3
	 o0XfsiRhUJtDQlSvOwJ25Iwh5SMnNgz4NZLOaAlh71lGqedN+Tue8nYzeQwH9nD7Wcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=XkS2ZX75;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795457829;
	bh=EIWsnfTzklW11i37dkrzfwvcQEorXh357acwCbAAvuE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O8dAkqTGr0sgZQHlOTLBR+JBaDP3GGYCyGSbPsV13VK258wUOB65BIbKtWwRm9Ouq
	 o9NB34bPDaBA7IEzUrkwqd34PPHpYyRFQ0GUUc93L3vhF8YJSCxacqsIfbzQNHGiVc
	 7OGR6wYyo4qrXdn7L+Lp3rqmZp8LMvnxkt2+2HJjYCcXXFV8YRYrfRqYDmTJ54/x12
	 TggRsxbbBDWceqGLC7iO6FOGyGyXRbEy1HepArIxIcJUoQJOnO3xwhbW9VflKEO37i
	 RRXu7gFvsxsGHEVQ+DLCmegSsmJz9yjhrjlP+b4DEuN15IokO9dSkny/xPbAInFYDM
	 WeRViXoJC9SxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70D47406C8;
	Mon, 23 Nov 2026 18:17:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A10F311
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B431406E2
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwRtvpI_ZmUx for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:17:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23D59406C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=XkS2ZX75
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23D59406C5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:17:04 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jYDg16ltdzKqVq
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795457821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EIWsnfTzklW11i37dkrzfwvcQEorXh357acwCbAAvuE=;
 b=XkS2ZX75ut8hDOZ/ulVTdAah90eZ2dgRzw1uzJH/QlL1bMycKMGeZLZmLZQJbwKQt/w/7+
 AqVl8TU1Xl1H9pdERrXrk0e6+2zFhiz1c0l+oBJwwbndriitb/dKrORkX4ZvtXd5emG2Gi
 dN15luNPx2zQnacA47bVf4ZmrpmU89zbn/8CjdPfDPxj/lWXGTn9FrPPEMZ1KYAordyduM
 ShpVDYSSNqEKblRDZ1WASKkzUneg0yb+4O9N+cjdzMRx8jiAwowyYQcdvgUT86GfhSiQRj
 iDwYn8qTliNBsVQ6DDzTi2+0/1trR0Jy7o2ILmrWfsXUSreOei10CU1sc2j17A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] clk: renesas: Add SDK SCP 4.40 map to Renesas R-Car R8A78000
 X5H CPG clock driver
Date: Mon, 23 Nov 2026 19:16:49 +0100
Message-ID: <20261123181659.168464-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8n691fazmcy3fougabsxmmtz3q1itj8p
X-MBO-RS-ID: 3e9b326025f6136841c
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.40.
Add SDK SCP 4.40 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 0fd06f578ad..45985831c7e 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -108,6 +108,7 @@ struct clk_map_in {
 #define GEN5_SCMI_SDK_4_36		0x01100000
 #define GEN5_SCMI_SDK_4_37		0x01120000
 #define GEN5_SCMI_SDK_4_39		0x01140000
+#define GEN5_SCMI_SDK_4_40		0x01150000
 
 static const struct clk_map_in gen5_clk_map_dt_sdk_4_28[] = {
 	{ SCP_CLOCK_ID_MDLC_UFS0, 202 },
@@ -192,7 +193,8 @@ static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 		   priv->basever == GEN5_SCMI_SDK_4_32 ||
 		   priv->basever == GEN5_SCMI_SDK_4_36 ||
 		   priv->basever == GEN5_SCMI_SDK_4_37 ||
-		   priv->basever == GEN5_SCMI_SDK_4_39) {
+		   priv->basever == GEN5_SCMI_SDK_4_39 ||
+		   priv->basever == GEN5_SCMI_SDK_4_40) {
 		map = gen5_clk_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

