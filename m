Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8398606A33A
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YefQi6CQ;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=JaChmHx6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B653605D6;
	Thu,  5 Nov 2026 09:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZFNfSxNC0Ez; Thu,  5 Nov 2026 09:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B16E060858
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869422;
	b=ESec5sncBPgIhashlFKuW9Kwn2nZtMn/c1cf3gDN2ZynC0LGT43uVFC27960DkOel1pf
	 NFMIGt945dVwqrSqdo/flcmUv8GCTOnLcs//otg2o+UetHLbwVfvdjFo4AGO9Nr0y5QJW
	 06KGzSaMrM6Q4HzlOC0mKp04N0nqWHhgxx6LA7sG5rBxgKWeC8A6Pqcr2ZHprG4Aic4cY
	 l06bP0UbF3FYI+A84FSxtiiA7Z1QkYme2ztYgqLC1dpDywpnnyooa9djFiAG1dYbMYedx
	 czK38q61bb66ZvupSu2bFoHh6oV4Hp2ypdYk0bbIulJyptyxCJ2Z/FPJZBGGo4xCxPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869422;
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
	bh=YpAaLx0qdVBAxJCMPhvN3hqHZBgGrRMAWlfUPUbEC9M=;
	b=UvRemV9594MsPiFgh0NcOcavo1fEaAGPl5iBdh2UKWeyzejuk/UvFKEvb8d5uieYjSVE
	 R5Ae+ezfdC33GM1aup3ePBv6ymg0nTbp8QQr0qq7hTFf72cy5VjaGUufwUMdLaQNdtWE5
	 GcOplL2ldDf0yoc5Zl5trvR8/x8UzJkuf/4R4M/NRn/tqMzdZpb8OVnAhpOga97bcea1L
	 JS7Dy1rHZ8/5egjkBSBS8jRWuWxNTNZm/G5hqUwKC8DSHU+MqvY1xNY7Zp1GEEPvbJC+y
	 5axbrxiK6pdiEgKjbj5/Zi/+cvSDgnJXvvqFgNbvtQbWBkBGG/BRGSRKv9LHdSamL2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869422;
	bh=YpAaLx0qdVBAxJCMPhvN3hqHZBgGrRMAWlfUPUbEC9M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YefQi6CQg5PdK2GVMMNMBTfCW5vlb/GdgCSo2uYrx9IaAJL+cDX6s/mdwf8wgyYEU
	 5gcdL+Ian25Loy693qOBPuSNkeeha/juC6rLrOv2v2yOuX0txFhxPIshPPOonmgCY5
	 MxhFv/FWlbS7Ju/t2C/CHPUvGJlRQsd5ZUZ1+9mcyQ48CK1jRC/xQcJSSkr54TB4NX
	 aYPTQC/fijWqNMrL0OTSBu5U+WfMOU6cueHLh4qBWOYAFkG+xrN+IxdnSuA+TVI0dY
	 hA6oR6qovfmdGnxZomBh6ZSmHinAInmTkcwcdUyYmJjGBmK7h0i74tCT+TNaEa5HUS
	 OlWxUN640W4vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B16E060858;
	Thu,  5 Nov 2026 09:03:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D41C831F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1736810F1
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f1_OfeUYuxaZ for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF1D8810DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=JaChmHx6
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF1D8810DB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpAaLx0qdVBAxJCMPhvN3hqHZBgGrRMAWlfUPUbEC9M=;
 b=JaChmHx6tkHnT+gubtw5sPdWUXPQr7dfdcRZoobAjPWBYoD4nHkHDkIECOHbbKJAayCT2W3lgWIo1z94v3d9UU+Q3oTKKJILpufuXc78RfnMHIAmZzvDucadZATLGE+Z1dU0CUP0XTMWdrhaPMXX8lotu8+0ugouWUM75dOWfDInMeMxkxmLd6WTeI8eyuNpjMNjactgU9HtGSaFlNvxUN2wLbdi1AJUSH8TdswQgP99Sacyx7uNWpF58T73U0YSaSzs4gwWn1VrzvKXW12vFP/E3VhyRKkPk1nAgKQV54s5ajDtG2GsrPLUKsjJ4twW5Z7z8Uz9ZPZGjlpnJ6w1rQ==
Received: from PAZP264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f9::17)
 by DB9PR10MB6313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 09:03:30 +0000
Received: from MAD0EPF000008B3.eurprd04.prod.outlook.com
 (2603:10a6:102:1f9:cafe::55) by PAZP264CA0156.outlook.office365.com
 (2603:10a6:102:1f9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:03:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B3.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:03:28 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:58 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:28 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 5 Nov 2026 10:03:20 +0100
Subject: [PATCH 1/3] cmd: mmc: Add mmc_set_part_conf() parameters sanity check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-upstream_partconf_fixes-v1-1-6abda284aacf@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B3:EE_|DB9PR10MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 108f3298-5542-482c-5a5f-08df3b1ba8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261022115727099003|261022105027099003|261022075727099003|261028144727099003|261026140227099003|261026135527099003|261026121527099003|261021135927099003|261021133027099003|261021130227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022113327099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: mpJB/vgdxcsanPWds/cQIH4dxsZRzbwgLo8ZnUSDzJUCVSVjy5QsjSyUjhnXDtHUYVLC58SrZuj4nqcg0jmkCL79eDHVIoEEDKbnI/ebfxJ9EuWwi8uIAoBRwGUTeTMVMpQRzSoFsvkLLdeqAultiushIaajBVwQaUmydAUSk8dInAR2iQF3rnhBMPGzbR0i51j64FOMUnFp4nrIubHy/ipmtJmFQnfl8hO1O1Ua0B9+4JfjrEMIwlndgCpuxE9NDemlgGidKal1DL6htwVCQqy0yTvKTZAxbsqd++pfizqPKQfMl4HG+tfqlDFMK+9YB+HyPdVMCg+G2jlNCsTWnblh1tKCRP7svRFvxuFeeLzLs3bM+b1GjgldgLOXlzSSD2IhOeHFF4nTOXWCOy4Nwm+CeIqSBBaSGAjPus4gkQLyhuP06ItF80wBmoQ7CyfBU5PPE1exkW3gncmV8Zy8OKFK2iQ4kQOMqjH43QlK+6ZjKnFdTnZxW8tHhXd/mHpbX4W9zUuQFjFGqdg23MOUERFIXQwACpZyttQjN2DNTPD4leXP1477UdKaefvbusOeLK9uM6gmnN5sgRl9DJ+tEkLH31fXjmeEBASRlAfRl6eyfGi+CW6lrqIFG1H+VX8zeIBz9+cKWY4ZqAletTqEajh7lRdHhClZkkUJevyTh2zxZ81ITvf68t35KADHicv2wq6vL5xkMsfn6ELaEO/Vqw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(261026140227099003)(261026135527099003)(261026121527099003)(261021135927099003)(261021133027099003)(261021130227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022113327099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F6q/5B3Dw9rMUdLc08VKsuaEDE2U8WCRkZAoXCg0iaedmoMJe0DD8YVqF2atv2c4TpTp5w/yFiuQMYyn4cpP81+qay4DEUG65hVkMhjBFH5fNAWGE6GUU4QRTznbwXryC1J+QWsy2vVv2GwX2+/5drNl8RmOxGtbp3lB6cYulyN7u82MB122c6RdYWYo80uRm3fWdL16A/PJkHNv4evX3tVxlZCe9Wz8vL8zhiILVhcfq4fnb5FzSj2QjQz/4Pv0ZRu/VMIrvj8s2Gyd8xOY5HntVshOuL8YwKb4YuAEUfZZ+v2VP+Tuu08pBQMeVHXydQA3xIKW0n9r/BwXs8OrdNWcGu3gUaLfE2ah1ZFwal7wgBzZbkMgU0o5Cs3VavQEEewh3A41pA/T0tMEu5nYHlBVKWoguseMGN0KJ1ldRiZdxQU9S2kxqznhSC66tJNv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:03:28.9015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108f3298-5542-482c-5a5f-08df3b1ba8b0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6313
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

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 cmd/mmc.c     | 17 ++++++++++++++++-
 include/mmc.h |  8 +++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/cmd/mmc.c b/cmd/mmc.c
index 8bf3bf794ff..173e3cc7140 100644
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
 
+	if (access > PART_ACCESS_MASK) {
+		log_err("Invalid partition_access value '%lu'\n", access);
+		return CMD_RET_FAILURE;
+	}
+
+	if (part_num > BOOT_PART_MASK) {
+		log_err("Invalid boot_partition value '%lu'\n", part_num);
+		return CMD_RET_FAILURE;
+	}
+
+	if (ack > BOOT_ACK_MASK) {
+		log_err("Invalid boot_ack value '%lu'\n", ack);
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

