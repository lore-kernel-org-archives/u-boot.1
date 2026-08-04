Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E5C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E190180B9C;
	Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IsfJX7ZaBR_s; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 014BD80BB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880533;
	bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYCW9OX3BR5pvtwA/DhDJNm5QjjxCUVN14954lPAS/qSFA+bLIc8a6/nW0a9tLAto
	 ty7ibX/h92RezYILJtRiYKOyKQtoNDEiWHOFYCnr1To5Br7poUztF9JFFYtgUSIuQV
	 J62GJfBJkPhOX+V5hXGXcHIZohZINl8MmFjcUF+g1kri3VdvA7hn89THvm3JmmLUfM
	 3ZZVCKxfY5wqQZQ/Ihu5S7CldGyS0mUUcywGZbzi8jWXm7jCODpkX8oiuwwciPyIpX
	 V1sFQsNcA+fa4g0i1v8uZCx2vlaAMQZ4oWWHmJgmjR4rRCBahrKTIqA+u/URwxJQhB
	 GBl8Qcvd/NzuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 014BD80BB6;
	Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AAD32FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48B37606BD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jXxDK2Ynj_Qa for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4420360671
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4420360671
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4420360671
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:30 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoF8g3496917;
 Tue, 4 Aug 2026 16:55:24 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49dde3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdKvmh3EGcCnwXAVEay0q/adnpyn6yiGOS9F+qm7Oq36rGRG/dVZUZmv5WFLF9xO1sPCfql/hxxBRXejAGPNzbeq775jTwURr3S58vUd9y5SR763AZDGSg4PpxnNy7NmQF+au+S3SNivi7UeQg9bqVE/by9l9E5lY2Bs1hDgW9lvCFWHPHEaGLw0c8BXqho0gxlCbAjAU+4HbgGQHPXudjjyILtz84DqhlCXciugGuYyOC5tqM8VuM8sO5Hk7obL6/2JwJGQOCOVOMR+qkgr60SKuKR5qblIgrubicW525enFPeN24jiDTA6u5lDRcocZgQMZsQP6IYcjxullwgAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
 b=XY1PnlDCt08JLXjyoMJ0NkS2twesqYwK3L8075895+p6rJ54F/1ymeSUFpq4cbsbeDzNTFIrYSTozZgx2pKHBsJeNWUo3/XOVguK4WLMZ7O0DJTgy10kK9eA9MoI8YIL/CiZQgaMs4L2b3XQEt1PAi22eieBWvRaor16ebX6bqygk4PwF7ggNSJStu1pJA+mmCGQwHulc190Al09TrOlXTDXmg0taMK7GkSDCX3DlP1SPANbsyKorQmCFod0el8y+RoA92ijHnrxKqyjlDH/DkWK7hHRuX/mauFzxvUXgcRfvJp8kM2WVSNT4Gd+Yb6iUCEnsQT2lf3iNtduSbvbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by LV3PR10MB8156.namprd10.prod.outlook.com (2603:10b6:408:285::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:20 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::4d) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 21:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 21:55:19 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIlY968763;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:02 -0500
Subject: [PATCH v4 03/11] soc: add data to identify the am62lx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-3-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=bb@ti.com;
 h=from:subject:message-id; bh=wLiT/fRszDiXogdjRvZY8HhozaEuziejhnSRyIRNJJk=;
 b=owNCWmg5MUFZJlNZ8xyH5AAAb3////9/+/9if6f3/Oq7/r9ep9DnzfT7T8u73r276xtX5vWwA
 RlQO1GnqADRoaAAAANNAAaADQGgAaMNINAaeoNGhiMjT1DQ0NANDRoYIbU2mUQADQGjTRoDTEGE
 AyMhoNDTCDBMTQaAGgABgmgYJkGEaDIaaYTJiAGgyTT1PUbSD1PUNAaGQAD0QAA0aNqNAMjI0MI
 GgBpo0Bo0DQ0eoAA9T1ABkBoABBIM1bUK8BEMshRg4gLYUDCLymY5vvRion80Ayw0nSWj2E229G
 0XyrVtU1LJdMd+nS+5fXpCok+9hjm9BWegnRB7nMCBFTlJpHeOmP06GgUasgjIX+R9d1DRBtBFM
 D7Lii0SxV31yStPaYWSIjUFUnkFsp9hGK56FSKJLY+23IaXo4epyILfXEAb808rSZZpj9YUqVKE
 6SZ3k2CdExBObecFu9ku58AwBOa3teJdQ5LON+S8svW/K347ZASXTiB1bvU+5EK2NplZRMYt2iX
 qY+K/9csFm4OyC7jklfsy4h1voYIG6QDlOPD2YkUAZd/UJ2qEPFOFVwzMkzU/y9QWaCvPDatSa6
 +OEijWAocN8ShNjRgUBuPBeu19gAlt4mMMOBpKtXlVwy5ziOFI7IV1Cox0JmbGPH6I6AZINCkAg
 kf4u5IpwoSHmOQ/IA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|LV3PR10MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: c73d08e0-544e-41be-72bf-08def273136e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 509ZTJKyl30WJ7/CUESd+NvYtCf83JYknYDaQkViAJuVFL5punThIedNUMSstalOD3QdM/+oLm00N6IEpmFTN9QXNv0tF3ztSJ4ceq+Q9cOE0aqdNlZSQytq82aArba0lw1IK7m0gI/at2nbCAHBm4eAJWqi/bnbqFgLQ1fMwmkEBl/houtf6QSujAt9/pL66A7SdajTb4N577vInzXdlkfIM99G5aF4Aer8yhSZ1Qaydjz2bD3pfOBT6DQFLvKZLamuVdoNNeXDenEVDJtwewPPTcTacxwq+k8P5eIhk5eH3ui5ZeSnEHZHWooYrGv/xmZCBhYEmvxyuGLGXdq+VATKIyoJAu3aKCTwv+R6tjQv0gVNSoR1/XGkctPinv0KrzS9kQgJrovhO85KTdKfHE4uV0DboOrMdbqHiaYA47us+3evhRR3BQgd/8lGUPNyITPpAUSxPLPLV03+tNmcHE09EOjTpcrxU/aISgLna2CrDwBtS6xOPcILyynUWisB+hIUiXt0YF8M3DJSPLhy5WZd+yi0iEg0gl/VDmSIta+elpWmmc+Y3Fan+94ULwaWsUFVlH1Q4acliA6mYSkZlRq6Wjcwl3OgHFksKgzgRAlUE7Ytat33ACo5j3FwAw3LXEcwYnr1w5kr8UHRpZbv30gSfEE7etgjOM2oh0E5UUxM5QFAbLfBttyQV6QVMT+QfNaGt2iA+Eu8/mYNIecoNg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E8u4rFuLwqcmH0VFpdvy0gWJF69aDhaztsI0qrLU//zCV7PQFLBEvz5mqFmrJchPkz8L95qgkeFVp2qkBpmBnX5bs/plsw3bhR1cFvs6RA6nNSTzwI+rl0Z9qxW52ucUexrjKhOv3DF2ED0NOB7XnGRTP/qvmDlmyqWsDUBiIYp6P5xno89OstyZDQHWDveqMbjjrq4fnxqRXdYW9Q9LeLVFtqmyzbbKa1CeZ14jKRFsVvGMP57zxSEJhY7gUIN4aCtnU3MF/js5YhffcQskZzzZtydE6FBp62J7zQcWGzP3aJ2sgnc9Rc6pOok36FMf1o+FyIsMv+3QXE/QAdLTVdHHGQuk21g+muy+lm4wywszBy97//zC4G1L7xJq8jHYQuQb0lWpJEZqy6V6asnsGu54u9R1NdNpqY4l4f1qFyReUzTq4lUgR/CetGBig3y/
X-Exchange-RoutingPolicyChecked: hblESurzTDPmMi35mKdANmDZRCrr+eTfhx/ldix6l7XQqNNO9FZABpJGGMi3W1EbVwhdlaRKMI0RJ33cV92/6LbonYHfus5XgJPpheHdYfktA61OyqqSYfmevp2QLsoHexgSxhpn+N0Zn6g/+SH98+gJbz0CJtn4Ev0N6XUQ4w+BmcO5TVev+6qLcXq1ZKmlxLi6rnSgmSr4k1NLpjINl+flW+1fTl9Qwz02CAEUFJA/b3htST7lYFSCRepdD274QtZ6T7v2ZWm5JNPM538WXfRqyHvZVTOBDMvg20TIIdhkUiNokNN37SjK87/FewXtWAZa21AipYDjsYJnhhknKQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:19.2989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d08e0-544e-41be-72bf-08def273136e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8156
X-Proofpoint-GUID: HdgDA4cy8rrAI5zRHGmMl3ukFxA9IHXy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXyvV6LAhVPnDn
 +wQZTZUCGwZ5GRWBjBkKuGgKWqHPzNX/GFJzWWbSFb/ckmqegxhY/NuLYqo2k123l2znynCZr2u
 y/6E+E6hPR2+nttGKCicdRte6mCmEyJv1Lvwt6/vnACecitjg7+v68RQ8XI6iRMZ4hrvM9uQmRd
 H3ze16auaeG7JmFVdZ1rlYI+jVnlPSxAv7oUQgHfvbZ3EAL2ZJQDPeUO5Elvq4WzURLAQhUVvdQ
 C62qqWq5w7ds/uLUnHwH5dHJQ0r98M+X9b4shq2dZZGFbMufsdq/BWNRdP0AwFIY/R0JvBeIHzK
 dYMFqGdHNa/Vfry5Ar7Ygq2XMMpHTjc6AmaqXhrdPSqoW5jKsmk0/nefVcTGMXlyuQGL5GETq3n
 R1jl3rDA8zOlYDwGrTr6mmznvkv1k/g9+oSw1NNUMSs/nvAXc5bdPY4uflxN4AOqBIP3uEy+dsn
 aE2OJHheBgU6R1OAm/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX45jDnMgIdAnF
 ZCnOUA7m0K0Nmo1bocN12yDdh/h8eNwytUhtX/iiF4QySFURA0eg6bBLXDKejwQqXGuEH102DJR
 hi/n66qc0s4iv+BQf+f1JzY3wsimAGQ=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a725fcc cx=c_pps
 a=6F35cL4xT6GZaKJ9H0o0MQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=56ctJiXxMvbzIHRyPDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HdgDA4cy8rrAI5zRHGmMl3ukFxA9IHXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggF
 aI=; b=B2Tv5qkIrMSoQHsflr6+drYlG/Sc+Rwr5GzCQts8W3RgLwSuQpZaZJs+S
 KYC5loFJwe4ssRonYyadFYmVbVXG9RxqiBJHpTK5fH7L4ZKqKeV8DFoT6W3AVhbh
 0RoX3HuZXyd0Nji5hKjxVE7LoLjvXHQLAw7txJyDznXCWG+bRx4HGhkrtjNS+9e/
 kRJMh53BnT3TM+Oj3fgah9D66pNKz26gQt2AmJSxQC+zez2WHlEkFuuNnGp/HJoM
 dEtHBlALNuR4L5bO5ByeaasCw6693IUi2UrpeNk9GWXEllJsO+he+Lk8LFhGYwFH
 HtQJgzTx4IKDp8QqtxigZ3l+0YUig==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
 b=QPq7wTHpbk+lkooMAYNumsA40ZIWoWUre1gFoSkjan6XnErGpFXoTe4OpO3uPhgqvEuAk0cEYMXCc+L/H42s8eBxsQK/gnvSzunkUkMV8sIqG0ApLR9Ujc8xDci8KYytJ4DJR7i5RShoV6mki7u6LflX/yMMFBPqelSsjnCx4ds=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=B2Tv5qkI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=QPq7wTHp
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Include the part number for TI's am62lx family of SoCs so we can
properly identify it during boot.

Tested-by: Anshul Dalal <anshuld@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Capitalized 'Include' in commit message
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 arch/arm/mach-k3/include/mach/hardware.h |  2 ++
 drivers/soc/soc_ti_k3.c                  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..6b86f6ed12e6 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -56,6 +56,7 @@
 #define JTAG_ID_PARTNO_SHIFT	12
 #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62LX	0xbba7
 #define JTAG_ID_PARTNO_AM62PX	0xbb9d
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM64X	0xbb38
@@ -81,6 +82,7 @@ static inline bool soc_is_##id(void) \
 }
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
+K3_SOC_ID(am62lx, AM62LX)
 K3_SOC_ID(am62px, AM62PX)
 K3_SOC_ID(am64x, AM64X)
 K3_SOC_ID(am65x, AM65X)
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b34cbd08e073..6ffd88f22c09 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -36,6 +36,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_AM62PX:
 		family = "AM62PX";
 		break;
+	case JTAG_ID_PARTNO_AM62LX:
+		family = "AM62LX";
+		break;
 	case JTAG_ID_PARTNO_AM64X:
 		family = "AM64X";
 		break;
@@ -72,6 +75,10 @@ static const char *get_family_string(u32 idreg)
 	return family;
 }
 
+static char *am62lx_rev_string_map[] = {
+	"1.0", "1.1",
+};
+
 static char *j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
@@ -89,6 +96,10 @@ static const char *get_rev_string(u32 idreg)
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
 
 	switch (soc) {
+	case JTAG_ID_PARTNO_AM62LX:
+		if (rev >= ARRAY_SIZE(am62lx_rev_string_map))
+			goto bail;
+		return am62lx_rev_string_map[rev];
 	case JTAG_ID_PARTNO_J721E:
 		if (rev >= ARRAY_SIZE(j721e_rev_string_map))
 			goto bail;

-- 
2.54.0

