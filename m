Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59644606A32A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iywdr6ai;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tnOc7q1F
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 309BA406ED;
	Mon, 23 Nov 2026 18:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxOe36d6hW38; Mon, 23 Nov 2026 18:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D610406E2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795457943;
	b=YHtR+5XUiE3hjNpSMqVeZsJlI5tzmMQilyVMPbG0vWBywZFfw2GF6E2a2b96AK1fnhfn
	 Y3C+524KeMq6zan1UBM4sIpC9rQgx4gzPurks/dz7rhsZ00Ltg79Q8BTWkiE95QcxzZEy
	 Ktc0p5sRrg5uMtMftXVKYEtnmdApUpuaMfsIGpcYDUkFc8H+Fxz/oPb9KpdZdc92HyCwe
	 k3kKAKC6XCpxDxg25ypb36KS9xa4jhHP8+S7DavNu0x+tOL8v2GYOBQpLdwDlSZZPK7T+
	 lA0FX6AUW8DovoXGEk1yN5szWkXtWC5vvDaBh5N8wI5qIl4tAZrbO5srn3S+ZmyXNpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795457943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hn3m6pHDtBn/WEAdkR9hgt1D3r9AOK66vdq6FXOrC0g=;
	b=qvPstmDR9bfvskJ0tyfu4+0n9wO4eR2i+Nsiw9MQ25oJBpRqqzimB8iIZqauuYQvN+yb
	 x9HfVzVfXTSiYm557gh8VEsNLsjUY8uYEyxisTprZga11V/WNDT6fCyOIZXeTqadgEFRD
	 3kMuolDmvczi4zHiVBrrRRCARdYGB/WE28hH2WO2ked+5tqR6OCDlx5Xt3PMfA3VVGuEy
	 cI4jDkwbuoVoQZOLrCXHezO5JvVDubZEbWKPXemv5qBvpaNEpo7W3rEXfecQ0lQYNwsqW
	 yEYrOdFsi5+DTP3YN3TCQ0D0FskHozRsZfp5B+7Yu/AKTvyU5TnVjH4HgeSMIbC+1rA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795457943;
	bh=hn3m6pHDtBn/WEAdkR9hgt1D3r9AOK66vdq6FXOrC0g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iywdr6aiuGpmxUCX+KeA0mSl0ea8SPy2ZsJ++LuvyBgscgEoQWROm5Pjwz3df60jo
	 6jNmpCVqVjcO3oYiLhL3wH4CvReYMkr3JPjM/Xiw0qiZb26q8tyaVvwSoBvMCFRg5c
	 4QBJg8lFMvcubR6PeKriS4Ro8fKnE8ffyPDWZF8/HuorHND00AN6kfR9VhbHKWsNGj
	 Hupy4KnuyynqafCeuMlTxQXP/0X0PlbYGxiAxCfZk8wZIdb0j+x0zTBg+0FA4KE8m8
	 l4GNj1x95iGKRjJPc6mZOkiHfIkTImKLL7dX+pMMcL8VuDO3RbITgr4ZYek4usGmnC
	 R5XD+TCiM65Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D610406E2;
	Mon, 23 Nov 2026 18:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8D82371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EEEB4022A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrJg5O4_8vdz for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 18:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C201440093
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=tnOc7q1F
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C201440093
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 18:19:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jYDjF4ZhYz8txD;
 Mon, 23 Nov 2026 19:18:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795457937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hn3m6pHDtBn/WEAdkR9hgt1D3r9AOK66vdq6FXOrC0g=;
 b=tnOc7q1FeYk5EQGSVQfE68MIQ6BD17PXUYAmb61V7SDCM9IMYRrrSK4m5ePwRimu6VNczW
 cTuuJTSwWZ7yO/jwgQJyVxgJ5gy4GF6/vv4bufkJd7NCAL4w50m7MA03pcqYmnLQRUGPdQ
 gtDrzLNVHPKd3tn82QXnWdaQu1+VttKQmFcvxjOz7Pi6+X1Tleel3kFboqdjaH7Z5S02cV
 LxmNcg/3WVXNJm2KBIUJKCFbgKepY+P7s4yacKc/LVWgdDGmaBsGz9k627lScB3skT3mK2
 4YPdduQ9Nxu5FgoN5e58LT4w1+jA7bzCTpXAjU+FVpc5SilWhSm+6cUCFjG0Iw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH RESEND] clk: renesas: Add SDK SCP 4.40 map to Renesas R-Car
 R8A78000 X5H CPG clock driver
Date: Mon, 23 Nov 2026 19:18:32 +0100
Message-ID: <20261123181855.168848-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 97b4f184b6bbc19b680
X-MBO-RS-META: 539jabr5gaj81mybwbnb73dbomrpys1s
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.40.
Add SDK SCP 4.40 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
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

