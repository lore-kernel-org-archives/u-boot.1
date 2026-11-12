Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF3606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cRivxkiD;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=CS2M+QWO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5ED8640AC8;
	Thu, 12 Nov 2026 08:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CkrwJlFP02cV; Thu, 12 Nov 2026 08:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9151340A58
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472067;
	b=Lue1uQ4zytne0veO551cVFpS0AkWUk/fgA8LFlqbnL3wsBACCdmW9fdodGnkxdSpqU55
	 oreh+8P4EgbiA4B3sYZduXA+mFvzVsc9Sk44uMT0SaxmtcfLX/PQurOIhRx9iYd8xjGAT
	 Q3PCvSP5rkAINIpF1E/4LOZCJyLJgKlTQ90FvAERC/1fTL7AbDCnigXipmFyrG/5u3ppN
	 GLu9TkAeeSXeUittgX2KSRbZUdU1RSYVReGnssw8q0vyXKndQ2ksuSA8ZhmQurBQWtaeh
	 WL/UeXLWgTZD4JDeKdJEFpys2QwI9rYjrwt1zCBceDqaTzHiYiPZUJ/buAxOaB7BfJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g+uD6U4MGYw/Xrkp1fb8fThox94fD+oKZs2103PiHUo=;
	b=o8eqyWu23JYLp74evrElW1g3NQclJ4jQbQrSSN6iqPJ1waT5LNHQW4f0V/A17bNpVXhD
	 yMxq7rIxTlruFSaZXXV9PW3BIuPZvoKgNp7iC54XsR3U7TpkrR6GG9GOIxzkTSn7D2KOk
	 SkJ1BgG+SW5uX1kFZ5A7oS2R0SmTmP2yjhJmsLkhWDJfhmMkmfMFDhCRTTMvOWrRBxPzH
	 NlAdEw1KyC+7Dq6spPQBZM512TIU7KBMFmPsma6r4R/MyStkXVpQHFuXxCHnwEX6mqOoX
	 JqWJ+kFhu+NHnCA++O6tW6+/fFqK7hCy7JHqYqnEjWVok/n+0/xQsLSnAnZ6UhV7cEQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472067;
	bh=g+uD6U4MGYw/Xrkp1fb8fThox94fD+oKZs2103PiHUo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cRivxkiD4A5HwUa1Pbmfxsl0OL017UvMnPyb3B+q/Gwv+tb5wGr4RnJK5tsDJvsaj
	 OEZ0hIcKT6u/QgbrzoBzXk944aJVyHHsNQABF/Xgqdr2JSychvfCDWsTKv8Mqlv3g7
	 aD7B1bJ/SMRXkOkDRFUpHjIGyCTTDYRsvovX10iuitZ3GcDrkzEofNklTvFnREclPA
	 0aqT+Oenraake58+Kr6nGQNJ1wU3dTS10VfrfAbfOE4/vuVB4EE4D7vnzqT8F8J8vo
	 xIVYpm3gtobUTspAOJXIOmWT8Tc4wZwWNpyrAOUQu/gQTzg/DantcUPdmnYOBSV+jb
	 WN+BmPJR7dpmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9151340A58;
	Thu, 12 Nov 2026 08:27:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB0C3335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0A0340418
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lr3Qpkm17ePh for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7A5940416
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=CS2M+QWO
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7A5940416
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+uD6U4MGYw/Xrkp1fb8fThox94fD+oKZs2103PiHUo=;
 b=CS2M+QWOEb3/dYZyG1zdE8Mjfe4eKAcV7AFYNmUz+23zvrGRSNjRH8u7IJBq1ZzqcGc8MoIOVZXIYn9CZQTG85yVA/uwjFxY8TIP5QAE2iTueWcXrbAOwkKj7QDERnKEjrsc2S3lv7N3pIzSWy8KO0UM/CZq2IURHV9ZtVPIPzSVyXX7iKjGelJACt9Skx+7nhMIhPePi0G96/mG8yEGeX9wdq6FLvC6k34eH8RxRxVnAiIJv36jRvwJggso83LaxxSyXHNU3UXJQ4OCTZ/CjAwMcBqesfk4PMzVx/EYTeah10cXZ71yTucMU2CEzNFNivNXkTGW96bGNQGZBFI40A==
Received: from DUZP191CA0040.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::18)
 by DB5PR10MB7751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:27:35 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::37) by DUZP191CA0040.outlook.office365.com
 (2603:10a6:10:4f8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 08:27:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:27:34 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:27:33 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:26:51 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 12 Nov 2026 09:26:48 +0100
Subject: [PATCH v2 1/3] cmd: mmc: Add mmc_set_part_conf() parameters sanity
 check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261112-upstream_partconf_fixes-v2-1-5eba1cf22b1a@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|DB5PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edcc3c4-e619-4def-9c21-08df4096cd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261009223027099003|261021130227099003|261021121427099003|11063799006|261022105027099003|261026135527099003|261026130827099003|261021135927099003|261026121527099003|261022075727099003|261021123027099003|261022115727099003|261021133027099003|261026140227099003|261028144727099003|261102123227099003|261022113327099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GF23J04FhEE1PrjzUj3gyT4WoCUHRg9uoiJBbXC4L1iTfRZoUP+rchEC85nve1jGoZ/+QdlPNta6NfyZn9TtSq34RS4KWq/+EgvdVzpCda0SwJROxxD9DLw2o/E6UXcl9dehc84PmjdIHQIh88NLL6TP3Jsk+buXIhHPaV5vf3F7nmuBIE0XTpv9r0OG7CDlEnVKyHAuT2L+v1Spl90vyEiVxpcHWcGv6kKsj/H5P2O0rrlY7vbSvAKfIuVOtfuUSTJKuEBMi1AOb5LFO1gNOAkM5PYTUjeyVjN1XqMjgbwoPGNuH/z7Xwspr2RPnrsFfvlC7akj2W2TXZ3DMsJGBHIL6Xm36F9fOgENfowmruKXXSd5Rfb1NWBWEHTcIsGil1ENvgL6Ajj1zvNjv2nc+5Jk3QZhbhCVk7lXCdSB4dU2AymBoRjle3zb78WieGthz6/liGkLbh1CbYMMoPNrKmiufvojraOTRZiKLKN0BOxad6kfeQ8Auy3cTNeBXiYa97P2xVMUXMoqLztx7ITV3s7+lceybZtcaiXTTWbBSxZzPk6HCZG97dMU/JGDeZOoAWQhTJqeTha2fE5tGXUrWDWEmkRLWMRowxIaTh7YRprAdIYgj4PZANIZR/2KBjSZOtSgu3VvL1wui0wphxJ+NNDJ/LC8yC2N863KzL9q7BtjiOtm+6yYUAeJUTr1WcqLmR0y2pdsNUZiVvxdbTJCkA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261009223027099003)(261021130227099003)(261021121427099003)(11063799006)(261022105027099003)(261026135527099003)(261026130827099003)(261021135927099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022115727099003)(261021133027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022113327099003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FeAmrkmcgAFvGQX+t/z9+kbyuEaDl3ShpGoSOcWae6tf1ZzNv/GJagoMqU/At2i5BHJe/EURNgi6k+v7KSv1KJdAOFWgaiR85bi0tqo3K9V7k6Mx8lZwMMP0EwjothvVmMuFFqN4QX0QPi2sxuIANaVpgKId1Z2RyXVotXBK1/iqJLCCAlUhHefoI1soDyLdTj92rkcXn3rGeT8V2c86SlPb3NPs3mdHQ1fTTZRWrs0uuh4+OnJ7r2PgHmAwdVuK6RsHrcFnhKCUuWvWCJPu3bvQYnyQd1evmAHLgETeQWpFLjFZrPGgNi+Ik9157D4LuXXpD2tQl21bgd5woA5xjCeiAH6o8ZJpn8JB8x7bQSjco0MvruaiPHFYyHeFYoCVamELsFyDSY1DnUGlW85YYnBe6g3X6eeXVfK1xJrrn0c4N3mH1uDZoSeTCRTsBFCO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:27:34.6696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edcc3c4-e619-4def-9c21-08df4096cd8d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7751
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

do_mmc_partconf() accepts numeric inputs without checking their
bitfield ranges.
Update ack, num and access type from u8 to ulong to avoid truncation
before range value checks. For example, mmc partconf 1 0 0 257
previously passed, last parameter became 1.

Add sanity check before mmc_set_part_conf() call.

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 cmd/mmc.c     | 17 ++++++++++++++++-
 include/mmc.h |  8 +++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 8bf3bf794ff..59cd9f9ea64 100644
--- a/cmd/mmc.c
+++ b/cmd/mmc.c
@@ -989,7 +989,7 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 {
 	int ret, dev;
 	struct mmc *mmc;
-	u8 ack, part_num, access;
+	ulong ack, part_num, access;
 
 	if (argc != 2 && argc != 3 && argc != 5)
 		return CMD_RET_USAGE;
@@ -1029,6 +1029,21 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
 		access = dectoul(argv[4], NULL);
 	}
 
+	if (ack > BOOT_ACK_MASK) {
+		printf("Invalid boot_ack value '%lu'\n", ack);
+		return CMD_RET_FAILURE;
+	}
+
+	if (part_num > BOOT_PART_MASK || !*emmc_boot_part_names[part_num]) {
+		printf("Invalid boot_partition value '%lu'\n", part_num);
+		return CMD_RET_FAILURE;
+	}
+
+	if (access > PART_ACCESS_MASK) {
+		printf("Invalid partition_access value '%lu'\n", access);
+		return CMD_RET_FAILURE;
+	}
+
 	/* acknowledge to be sent during boot operation */
 	ret = mmc_set_part_conf(mmc, ack, part_num, access);
 	if (ret != 0)
diff --git a/include/mmc.h b/include/mmc.h
index bf685a06a50..17edbe4742f 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -297,9 +297,9 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 #define EXT_CSD_BOOT_PART_NUM(x)	(x << 3)
 #define EXT_CSD_PARTITION_ACCESS(x)	(x << 0)
 
-#define EXT_CSD_EXTRACT_BOOT_ACK(x)		(((x) >> 6) & 0x1)
-#define EXT_CSD_EXTRACT_BOOT_PART(x)		(((x) >> 3) & 0x7)
-#define EXT_CSD_EXTRACT_PARTITION_ACCESS(x)	((x) & 0x7)
+#define EXT_CSD_EXTRACT_BOOT_ACK(x)		(((x) >> 6) & BOOT_ACK_MASK)
+#define EXT_CSD_EXTRACT_BOOT_PART(x)		(((x) >> 3) & BOOT_PART_MASK)
+#define EXT_CSD_EXTRACT_PARTITION_ACCESS(x)	((x) & PART_ACCESS_MASK)
 
 #define EXT_CSD_BOOT_BUS_WIDTH_MODE(x)	(x << 3)
 #define EXT_CSD_BOOT_BUS_WIDTH_RESET(x)	(x << 2)
@@ -343,6 +343,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 
 #define MMCPART_NOAVAILABLE	(0xff)
 #define PART_ACCESS_MASK	(0x7)
+#define BOOT_PART_MASK		(0x7)
+#define BOOT_ACK_MASK		(0x1)
 #define PART_SUPPORT		(0x1)
 #define ENHNCD_SUPPORT		(0x2)
 #define PART_ENH_ATTRIB		(0x1f)

-- 
2.43.0

