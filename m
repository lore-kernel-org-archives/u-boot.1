Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F94606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z/gBR3Jg;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=EHu/B6l4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BE3460808;
	Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ah-L1DXj1d_P; Thu,  5 Nov 2026 09:03:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D57D4607D5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793869418;
	b=nfagia3mmi/fF/0hEy+pWF1Xh2hdNpyvtTE1qPqdHXJd1aBv0ZOqbkTTqkqfQAMC7llH
	 eRGopKRjtq8mwZzo4+nxs4ahsq++RVkPvk2RYbV6nDDtF8rtvbPOA/4CA8SnPxckmJoAK
	 m/dZ4h6vRvng4kHbFjE1oTAAtpmFWqs6c/x14l/5w+pNWD9q9l3OSaXto2nP5lKss/vJ2
	 AwQ8jiOuxcSNxi1Gc9THnwChiQFAXlVM/oJii275+55J8eszN+T9tzj4HmZf7h8dOAE9N
	 pYaTcbd1ZIYhjz/OgRqCMFuZnLHCHE1M3R0pJzEQPbMg2HIppIzRCanSAxykbIq6JSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793869418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=MeJxFJZ358o8kKksMVH5Snw43sPtHhj0jv3v14H6/pc=;
	b=HvryjeXWwyXlK+BR/mgGl4zQNgxkl31pxD4N0tjENOVf5+a1lcfFaxLHgsjCZxTCB8+n
	 It+pDqpYaRC3kHiXAtim3i78rDjg8AhGmO4iTrLMEDq88/m2JgAXNWBoNnYoq1ApXqNMu
	 GE7PJqdkr9puSekx4wclDeD+fdVHxt7LRTxBGeg/4JHbBA3vPMXicq2Ely8emnZ0IEziX
	 f5eoOuPzxziEULB0pZ8eQzN0f/z3rzJnT5D0GZBg2NnNfv9v+f637cTn2QeJwLgtJPHQ5
	 He+/YTdZO2t3QGRI6fHDvHMAVIG1lUmVuP/JJzONxGgkD1+3lE1UnXvNUjZ5EQrOn9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="EHu/B6l4";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793869418;
	bh=MeJxFJZ358o8kKksMVH5Snw43sPtHhj0jv3v14H6/pc=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z/gBR3Jg5LEwQNN7jjYalYIewnDVDe+vlMPMwB5gzTKc3wPK2nKDC6r/cReMx9xgj
	 pCqW6EKQQCcvI0SmBd/uAnJZBHGYkFX8175rikmF+9nK9gpyybVY0bVgTCD7xC1w8k
	 ujSl4oE/VlG35V1mIWu7d1UijtpzFhKOG6HMoOxcnAgy0PVjxGJImSLoSh6DGV1BOt
	 Ua8+CsYf9x5/q+WYE4bARWqCQecsBqFt+G0G3IxVfox6MgOR88iSEM23ZN6vM3r+yf
	 TyxznFLUohZ7FOoUJ98Ru2OxU7WrfyCwA9Hs2BhdoDwbgNOIOi1uCqnAvYeHw3mbDa
	 Ebf3RuGWR5N4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D57D4607D5;
	Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F33131F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 251FB607D5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSG8-JflYDgS for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 09:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFBD9605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=EHu/B6l4
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AFBD9605D6
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeJxFJZ358o8kKksMVH5Snw43sPtHhj0jv3v14H6/pc=;
 b=EHu/B6l4VFWIYKJ538ljkJqObd0MaG+MB070B2GWCtTMrWbCX8HSdfJTbsGhnqu3W9Z47zDQEsi40eG8ave8L4Ar7FAZ3uR8rgn/FxpZVBCfaaeo0TSWrezphqmlg4PeMzrhnjnhg0i00dN6c4Zr0sCFBn6JpkL9qsybG5RwdId4DboJjbKFIEK9QPUQaMRABS5A0rI614itCkWUIpZBuy3oo7czGkSZfVSodfFCdws/PVlKEz11vJkMAllwWhhzdi095O1K1xvfdOsihwjH+/mXMndhDL6lxt9FYvwlZWxloJJyfEC4Zyx+mV22jcCTgF0MOd6XFZOlggeLIsZYqg==
Received: from AM0P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::21)
 by VI0PR10MB9834.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:30e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 09:03:29 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:208:190:cafe::86) by AM0P190CA0011.outlook.office365.com
 (2603:10a6:208:190::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 09:03:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 09:03:28 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:04:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 10:03:27 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] mmc: mmc_set_part_conf() fixes
Date: Thu, 5 Nov 2026 10:03:19 +0100
Message-ID: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdG7GoC/yXMUQrCMBCE4auUfTaQLbYPXkWkxHSiK5iG3VSE0
 rsb9fFj+GcjgwqMTt1GipeYLLmBDx3Fe8g3OJmbqff9yOwHtxarivCcStAal5ymJG+YO3oGpxE
 Y5kCtLorf0OLz5W9brw/E+r2jff8A7B+1NXsAAAA=
X-Change-ID: 20261105-upstream_partconf_fixes-401e1f6ee5da
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|VI0PR10MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b9f565-9643-440c-fc79-08df3b1ba83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|10067099003|3023799007|11063799006|261026121527099003|261102123227099003|56012099006|261021121427099003|261102130727099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: zbv42j6kCzQ9v96qTTj6l6tN2D9KED7XbGuOwWD0yYODDXa0hLawELVPz9RChTlkSCp3xELq9NsJOoO23nZKsa/rS+EceyFP1m3E5dq+jMZXQebaRrIO3L1sbApK84/73zDS1RmFypHrmJxpkvUrOL0Jr46ocGj9F6frUyH+5lhjcOiiu5W0SVtG4hgMS5apKQs8gitR9+0hbShXoTD/p+GPSpGxYR8f9IiTMTk4c/WbkQ9phQ9ffLfGpkJjxSIp0yaeW5xZlpUGP7j1Kvc/w2jMOuINFPKv0qcqEgjDzeAk8GhSLXgm39HjSz9/A9aZVYjiaDtWMe9bDd5oB3fU+rXxvoz2gz+Fc5oYAHyiVt/oocQJ+DmstjshW7wIaOke5h8t/D8LjrSSv2/Y/AZOSKHkKR70h6ZUfjWSjrQYw8dPBKMDsb/KZjQ39pzNoAO8HimkSDYEY7GFYXUG6Xy1aG59KftUjl52rQMDUfzGVuHJwcHbTc30oJ7x0Z2wyiZtDCBK9Ze+DhykuJ4twpZHi/CiyAgza8aDBH7SzL8RCD056Lg9w+9kYOhWCL4Rb3S3ISaKkvzSYC9OjC56cDZMwixA3SyW6dzdXRX7wJst+CR74m0PtkUlc2LZSDYOpLnEhCD1EkR1iU07I8l3y6qU4TNnH1csXWcmX8yGs5SMOJ/v7X6g+lB6dd4aIrt+++y9I8ceNhiiJffPA+64NJqLnw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(3023799007)(11063799006)(261026121527099003)(261102123227099003)(56012099006)(261021121427099003)(261102130727099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KSQw4CiszFl76yTZoosJQUesrNErQUuUAaED7vZ6X/DTcC9Ev5qCHWrNbqh7kf5MrlO3h15Qe7J62ZFHl7Hm7nGwIE7trRKjGz9K+Y4sYNUPtnJw+lhksGFFeA51BdEW1Wr9MW/Rca/SPNZJeGqP6XErHbxnFPnNlSNtzqTWNdGEXkIwxKQxGdJ8WQogNUH6sq35CnojOnW11e2epwlWID2vUDKUqG649dEI8/W0wf3HyexGV/cCbXQmu2C9cM2m66hwpIWWTC0r3VIdl2/c4Rwoo8uv1Ptp5rkQa74SNT5agtbY1Dd2xoP33I/13qxT9aTEGgQsvvW17vQVZoyRxcmdEwupWfKcId9DUTOXLcAcllkXpa0ZvZhcJXzAqQJY1I82h2CkwMiWlcqeXtErlswKGPhEpgPfs3ZMZg3mVqhBPrUpBCK+ONgrDKhRtSh5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:03:28.1620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9f565-9643-440c-fc79-08df3b1ba83e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9834
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

This series adds mmc_set_part_conf() parameters sanity check 
and fix the partition selection after "mmc partconf" command on eMMC.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (1):
      cmd: mmc: Add mmc_set_part_conf() parameters sanity check

Patrick Delaunay (2):
      mmc: export mmc_set_capacity()
      mmc: select the hardware partition after partconf command

 cmd/mmc.c                 | 17 ++++++++++++++++-
 drivers/mmc/mmc.c         |  2 +-
 drivers/mmc/mmc_boot.c    | 17 ++++++++++++++---
 drivers/mmc/mmc_private.h |  9 +++++++++
 include/mmc.h             |  8 +++++---
 5 files changed, 45 insertions(+), 8 deletions(-)
---
base-commit: ca397fed3948483c4708054d3e73a51962f2b27c
change-id: 20261105-upstream_partconf_fixes-401e1f6ee5da

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

