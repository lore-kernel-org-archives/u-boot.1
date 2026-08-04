Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323F6C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC04F80C06;
	Tue,  4 Aug 2026 00:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2NPIbUAlGI1; Tue,  4 Aug 2026 00:10:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1D8780BF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802205;
	bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hTv9Qq+sa/g29cHvsVXk4h18im6ebjIZZrSl0WEjHJ6lVYmm5XOChU5dw28BkXGzf
	 FJ14/DYgKWnntDgS2jeVkFmxlws5FBEUrlGKNbnuc+TqqK/XrxSbt1SCIfWOuqYxsI
	 eEtg+R1aFW1TvBo6nknOiK0ngxmO2NRvZi5W0W0KP/W7sl9B3FnDCin7QTWngwPzG1
	 omlmmvKNQhuMIP7b2f1BgZNJ6fyzvFYDQT+kCyi+lkQSta0f3U/QQKQLV/kHwCnqYD
	 XUptTvzYG3eriPAcL+IkfpCEzaGHWINJo7RgMNeoaKIwq6ts7GPcjmfVzui7rsQbXn
	 7tLU/TJYWTmWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1D8780BF0;
	Tue,  4 Aug 2026 00:10:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68176282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A5B34065C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VR-BuH7aqvGR for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F28BE4065B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F28BE4065B
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F28BE4065B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673Jj6FV438684; Mon, 3 Aug 2026 19:09:56 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0rdb78-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfWjxXr58t22sfWpvUG/E5P4VP11M/gdy2GLwM6gDmk0zLjZc06it3EAJbImE1mSDBT5/Piwzxa4K2aG0+G7lkfWrrf7c90ZOqTCJ18E1lh2FaqLaox5zgorcMJJg2vCwpSbuybh/967VGtOm4Ox4pKXauGWm0ghs6kWiLWunxKB0uOw8mwbD5LcYUezyGunf568fl2aqWoLFvPaPutsCNTF7mgvALNLmphQxZXm0Ske4ISi72B6Pq0Jk8hj9VRlA/98gkQD+bYDKC13o6gsWUXjLVU3Fi42P/exPCYSmPsiZav7Vv5eQhubeKBSx6nu4nxrBy3CrNHMmfmgggLjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
 b=uc60A3zw32PFJOdMbLiekisG31RR0LWQdhEMlU0RIxXimyvVApjrycd0dlEK1pZCKbvLemILakV/8LiWlcpi/HmfA1xAvl10RmRbT8sgSVAw93ta/kC5+Whf9eaqzfKfHByDQ16K8KFwpHFbNHcnWySU8yyj1r1TuUVplARtXTrVjUIP4k8chdR7Cl0goN8T+Tcr6IX+x3NX62VQrHl1JlcntW2mkpEyXOY5QwsQ67PT/RBhWS0tP0/SZ/oGib5IqDk+Nas250lSk1xJcHLKt4rVxDA0U1QCzJjnNepfxBS5Jzi+cjiyabS6lHvFI813dFl8Gb9qMkrf6b8867pMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from PH7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::35)
 by DS0PR10MB6032.namprd10.prod.outlook.com (2603:10b6:8:cc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Tue, 4 Aug 2026 00:09:54 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::a1) by PH7P220CA0036.outlook.office365.com
 (2603:10b6:510:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:53 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:48 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:47 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409l0J3381174;
 Mon, 3 Aug 2026 19:09:47 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:27 -0500
Subject: [PATCH v3 02/11] tools: binman: extend ti_secure_rom to handle op-tee
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-2-b4f4302b09b4@ti.com>
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8018; i=bb@ti.com;
 h=from:subject:message-id; bh=6ymAz1ZZel9JB9+6+hQTEObfLWYlwg35xCguH9w6yFk=;
 b=owNCWmg5MUFZJlNZEZHr4AAAZ/////7/Mue/f7/dv793P/7+wV227135+//t/e0ez1v+/e+wA
 RsYIeoAAAAepkBpoAAAA0BoANNABoBoAAAGg0A0NGgAHqaDTR6Jk0aDJ6YUMoAAHqAAeoGgAAAA
 aAAAAAaAPUGj0nqPUyDQ9QPRBoADQ09QekbUAAGQ0HIyeo00yDTIYgNGmgDQYQ0GgaDJkA0AGgN
 MQyNGgAaDQGmQ0aAZGQAaAAAAoXXDnRIFsrqgIID5E+VEMv4qQgQwbRheWPwnK0GjARyf4gd6HV
 v94QBdAMjXJoVTanweQ5xRMaxk71ONZJ9wzWzQOKi8xgDUwsphH0p8LU8M2dAwvr9NZSQQMPBPo
 0AJEhpBJPu6xCTgDPDf2GPyqygW3LIHCeNMpoUcGtup/xHGd4550Jbl0V77JQtN7onUalQ3JEUA
 4+y25r/MYAuGAQ8yC4GiGh1XcwgzaiRiH8zoBdqUpLSHTJMYL1LBKflWnE4WcriIT05dFynGCaC
 5QxAyhxNVfhirBSDgYDclJLNsNFAjDmwQ/QqnFNeKD9LQFahfRVhipRiqNDtRLV5FpkvYCkaDqt
 cPt+pKKl+aA32BMAD7kE+eosz9GBGsSqJUjdxfkaRNY2J9L1IOSFGQHlCvKay4otiOBCLEZk4Q4
 7WGMQR/i7kinChICMj18AA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS0PR10MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: c71965e7-49ae-4536-6784-08def1bcb57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|6133799003|18002099003|22082099003|17002099007|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: oOCh7nE6Uzq5G3Ry/w7hdZjQdnFBd+tnEJzadDxW8uPdQZSmPvBoMeQ8Kj5oHmOnouA449hTzUYcqxsGceS/2OT7WBkIqNFozEpoc8VN9ISKd6UlX32DL+oy7sQBHGTCJpHtgZs//zIZdh8vz2jj2ovsaJwi4AKiDMQfp9GgEgfy5hgIFEjYOex44xCeTUqNF0eyQdrkjn5AivkFThQRUr8AwzywPgZ0Mv5YDoaYTr3KMwOJqMLGnwhBFdi7NzFK0GY3BRI0iZLCzacNXpspfIafa7trQtxL7daBx2bGuBPvB+tjuDVOavXY7c1S7zSpAaEcFuaX3gp5yiK0aGdqCxUR1sEn5wPtZ0U5zLZIm0kpUR3A3ePWocgbDts7dtzZtHRu5cEHSc/UNlKN3lGb+2SPGcoT7RAZEvwPBPe1ry76f3RpaRLeQ6BHGBFWCncQGKEwupwdbAgyCf29wNnfpuLzOUOoJ0B17aQOKebCAOLcs35knXLB7PY8JpZjvyXgpKZSfNDnvEv+5Cf+bKakcXv8BsifDDEMmKAvN+ORiYAnMYnvlJKsy2ZemLKHSWdaNv3bGYb9soAMMhkjL/TLs2dqxrkIbHiY1V/G+OANaz85FFIw1kIA9lWcWXmeoEAo17SqqN3fdgvBT/jhjCREIa47EAOWQr4yh7UWSISex7tPHTmD5upp0T/0Re/HVyCbzpl5pUEOxcPSIVdPrEYhzg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(17002099007)(3023799007)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60YPlYLxQxyXCgqbwDoAAu/PetPR30u8GBnEWqiRKuCIl/OoIlwIPHnr9NJDYs9mUJotmL9Et1S+sVX3Rrvk7Z9duDTvEwhbvpceHYH0HmfePSDziXtIVjY0fl/O50WKFWvm5ec7dCLJKEUxszuEWbsxKrpBop4pIOrNSWocntMNAiZbtaecLnc+19mpc8nL7u1JrFJSTKxdmCbtsUFGcPJk8O613ut0zrfY/cqQSnFgK9th7aDWSdpKCYNzg0BTvZWOWuHRruGEhcvs5W+v5ByXAQ40aGBtuVY42KU5wQ6PYvF0HrsP99mugrKZ0Xb0LnQLhweeB3SzBit8jsNyxw2wj5cNLUkqhYMSb86MyDEKLcMTgcUlhVMHSlQtaY/k34BlVsmwEd5CNT/FZntBH/HU7J/kRpctbLOoDaYx8LtXAS9z6fdtl9k5wPS7QSel
X-Exchange-RoutingPolicyChecked: ggq0s36r71DPpbFysUzSn8t7/FOrdbaCvD3xxS3x3nCwxooL65zUMvMEC+XUJWII0ZdnttyAGkUf4RE2mDU0CqQmlaj4H1255iTgHje38/MrqvpwdlOdovHdeqoEboN5NUnv2Hny/+/jlhOSiTg9TYw3jLHChMv4+brRZHVjn82f9tufySxlkrLhZ50pCUs1WpdKVYGtb503SMwvQe5X6+AfqWeJH5Di4pm3bO6yoO4t7/m6pNS+lgxBcLtbTvCkV4s4rN6nXvetxDtDALJ0+cvhMeXs59TXocr1yQ2sXs5zLb97HysMqz2MSnCB0PZ7uN6KAIC7ciwmWBnrGHmv7g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:53.3419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71965e7-49ae-4536-6784-08def1bcb57d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6032
X-Proofpoint-GUID: 317Ep6rkXDlpQONxkkNTgvxTRHHtjiW-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX/QI8ah7MXJas
 KVlJbqJa2OslJcExx5HxjQFC37EW/xuPjvFNAw+fowRH0DTsLSTl25wX7fWAgHs0T65QciLNEXM
 GMBHVWviF6uyhkci4QzNQ9VEGWavPF+mdFHRNISbiUREH791jLdag1WkAjCS/Hifa362eJfcIWX
 YCH8jEdrvLWkuiKY8bikHyvzXlLgQB60SqC5KFrAeYb1H9x/OMCJnWvpkGM3KETeKJOV3TOBdPM
 BKZ4w9OilqHjSHeYZ6jmKJJJzNCH3rVoM7EZ/gCsGfsdUy81nLmbkHz8bg3r1NYJq9xMP4JupCl
 UXO+oSYBNVgtjX2TW8E3msHOtMYuHLwL/6K9XVd1CZ2GNuUBT+/pm2fekHmT4VM5i49IcaZ2BZq
 /CwP8e7Jevv9rKBiV3w/AEzoKSv0dMyjTLpq31qyJRQ4vsBNMmYC4l+NaV9szHQCKvnN7qTtGm1
 cPiSaca7CD7BjSnxhTA==
X-Proofpoint-ORIG-GUID: 317Ep6rkXDlpQONxkkNTgvxTRHHtjiW-
X-Authority-Analysis: v=2.4 cv=eOUjSnp1 c=1 sm=1 tr=0 ts=6a712dd4 cx=c_pps
 a=z4Cvy7J80qD6KqIazgzwmw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=ZdKUUdNxhPkhoCELuMkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX2Mruv61PDFu0
 IFslOlbZO5dK7t37rOIOqq2gnb0Z9ncp9O8dyq7RcdAmiTaJRdeSP3BYurxYADyaZD0/uSB5v75
 r9hf4LS/WcivDktz6uHSI/NtCm6kWo4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY
 /U=; b=aP2GxQqPSpB8QjJkfyArh0wGfFWWXWuv8mpq8hScfOGypnlttEXRzhmDw
 0OPzdqak89yRd6w7vlXLKyDSHjFQ2Rf16x1B6f/uq8zO+gu8naMAR1Z/JC+cnIaB
 JMTMsvwIZSknnYj85yBZv9xX4CcYad5KS2dP775hofDagTsGsdmcGyBeGY7kR4By
 4VoazIkCgBeHxukToYREAy8WaJVXNy02rWGn+hwvwMPCGX9PDtbZW+Pl83zp80yn
 egXfC/Kd3zhCWhRihhhYwnQObdqFvYyfgOh1RpAQ8fC+Ncu81dgdBthcziTPUops
 Lz9of+vMfsSpcjnKBtuaz8bFxAlRA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61iP1eoc2dLmXP9tbmHS/GPfQWAxL9PKeNqSd0VvY/U=;
 b=S+9hCf0CWAELvlqyPzeTG/VvLYFDPaMFRfyaq+KGXoJHsTZfm7r76NBlV4FnRgfTXA2HrYUw6NzoJl2l4TnFayuvGQL1IbDrIT784+et1LX66HQIuKJUqG4zf+GvcuhzZUISAOvEqIq5xvzx/NJYo8k18DrbF20jpFHl7VH3EdU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=aP2GxQqP; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=S+9hCf0C
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

Add an optional 'tee' entry to the x509 certificate template to include
optee during the second (tispl) boot phase for the AM62L.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Extended documentation and testing for ti-secure-rom etype
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 tools/binman/btool/openssl.py                      | 11 ++++---
 tools/binman/etype/ti_secure_rom.py                | 34 +++++++++++++++++++++-
 tools/binman/etype/x509_cert.py                    |  4 +++
 .../binman/test/vendor/ti_secure_rom_combined.dts  |  1 +
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c4470..c4762f6ccee6 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -239,10 +239,10 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
     def x509_cert_rom_combined(self, cert_fname, input_fname, key_fname, sw_rev,
                   config_fname, req_dist_name_dict, load_addr, sha, total_size, num_comps,
                   sysfw_inner_cert_ext_boot_sequence_string, dm_data_ext_boot_sequence_string,
-                  imagesize_sbl, hashval_sbl, load_addr_sysfw, imagesize_sysfw,
-                  hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
-                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block,
-                  dm_data_ext_boot_block, bootcore_opts, debug):
+                  tee_ext_boot_sequence_string, imagesize_sbl, hashval_sbl, load_addr_sysfw,
+                  imagesize_sysfw, hashval_sysfw, load_addr_sysfw_data, imagesize_sysfw_data,
+                  hashval_sysfw_data, sysfw_inner_cert_ext_boot_block, dm_data_ext_boot_block,
+                  tee_ext_boot_block, bootcore_opts, debug):
         """Create a certificate
 
         Args:
@@ -299,6 +299,7 @@ sbl=SEQUENCE:sbl
 sysfw=SEQUENCE:sysfw
 sysfw_data=SEQUENCE:sysfw_data
 {sysfw_inner_cert_ext_boot_sequence_string}
+{tee_ext_boot_sequence_string}
 {dm_data_ext_boot_sequence_string}
 
 [sbl]
@@ -340,6 +341,8 @@ coreDbgSecEn = INTEGER:0
 
 {sysfw_inner_cert_ext_boot_block}
 
+{tee_ext_boot_block}
+
 {dm_data_ext_boot_block}
         ''', file=outf)
         args = ['req', '-new', '-x509', '-key', key_fname, '-nodes',
diff --git a/tools/binman/etype/ti_secure_rom.py b/tools/binman/etype/ti_secure_rom.py
index 7e90c6559409..0d7d3e602a9a 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -42,10 +42,12 @@ class Entry_ti_secure_rom(Entry_x509_cert):
         - content-sysfw-data: phandle of sysfw-data or tifs-data binary
         - content-sysfw-inner-cert (optional): phandle of sysfw inner certificate binary
         - content-dm-data (optional): phandle of dm-data binary
+        - content-tee (optional): phandle of the tee binary
         - load-sysfw: load address of sysfw binary
         - load-sysfw-data: load address of sysfw-data or tifs-data binary
         - load-sysfw-inner-cert (optional): load address of sysfw inner certificate binary
         - load-dm-data (optional): load address of dm-data binary
+        - load-tee (optional): load address of the tee binary
 
     Output files:
         - input.<unique_name> - input file passed to openssl
@@ -80,6 +82,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
             self.dm_data = fdt_util.GetBool(self._node, 'dm-data', False)
             if self.dm_data:
                 self.load_addr_dm_data = fdt_util.GetInt(self._node, 'load-dm-data', 0x00000000)
+
+        self.tee = fdt_util.GetBool(self._node, 'content-tee', False)
+        if self.tee:
+            self.load_addr_tee = fdt_util.GetInt(self._node, 'load-tee', 0x00000000)
+
         self.req_dist_name = {'C': 'US',
                     'ST': 'TX',
                     'L': 'Dallas',
@@ -219,7 +226,32 @@ compSize = INTEGER:{imagesize_dm_data}
 shaType  = OID:{self.sha_type}
 shaValue = FORMAT:HEX,OCT:{hashval_dm_data}"""
 
-        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data
+        # tee
+        self.tee_ext_boot_sequence_string = ""
+        self.tee_ext_boot_block = ""
+        imagesize_tee = 0
+        if self.tee:
+            self.content = fdt_util.GetPhandleList(self._node, 'content-tee')
+            input_data_tee = self.GetContents(required)
+
+            input_fname_tee = tools.get_output_filename('input.%s' % uniq)
+            tools.write_file(input_fname_tee, input_data_tee)
+
+            indata_tee = tools.read_file(input_fname_tee)
+            hashval_tee = hashlib.sha512(indata_tee).hexdigest()
+            imagesize_tee = len(indata_tee)
+            self.num_comps += 1
+            self.tee_ext_boot_sequence_string = "tee=SEQUENCE:tee"
+            self.tee_ext_boot_block = f"""[tee]
+compType = INTEGER:17
+bootCore = INTEGER:16
+compOpts = INTEGER:0
+destAddr = FORMAT:HEX,OCT:{self.load_addr_tee:08x}
+compSize = INTEGER:{imagesize_tee}
+shaType  = OID:{self.sha_type}
+shaValue = FORMAT:HEX,OCT:{hashval_tee}"""
+
+        self.total_size = self.imagesize_sbl +  self.imagesize_sysfw + self.imagesize_sysfw_data + imagesize_sysfw_inner_cert + imagesize_dm_data + imagesize_tee
         return super().GetCertificate(required=required, type='rom-combined')
 
     def GetCertificate(self, required):
diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
index b6e8b0b4fb09..79b7b37baee7 100644
--- a/tools/binman/etype/x509_cert.py
+++ b/tools/binman/etype/x509_cert.py
@@ -41,6 +41,7 @@ class Entry_x509_cert(Entry_collection):
         self.num_comps = None
         self.sysfw_inner_cert_ext_boot_sequence_string = None
         self.dm_data_ext_boot_sequence_string = None
+        self.tee_ext_boot_sequence_string = None
         self.imagesize_sbl = None
         self.hashval_sbl = None
         self.load_addr_sysfw = None
@@ -51,6 +52,7 @@ class Entry_x509_cert(Entry_collection):
         self.hashval_sysfw_data = None
         self.sysfw_inner_cert_ext_boot_block = None
         self.dm_data_ext_boot_block = None
+        self.tee_ext_boot_block = None
         self.firewall_cert_data = None
         self.debug = False
 
@@ -132,6 +134,7 @@ class Entry_x509_cert(Entry_collection):
                 num_comps=self.num_comps,
                 sysfw_inner_cert_ext_boot_sequence_string=self.sysfw_inner_cert_ext_boot_sequence_string,
                 dm_data_ext_boot_sequence_string=self.dm_data_ext_boot_sequence_string,
+                tee_ext_boot_sequence_string=self.tee_ext_boot_sequence_string,
                 imagesize_sbl=self.imagesize_sbl,
                 hashval_sbl=self.hashval_sbl,
                 load_addr_sysfw=self.load_addr_sysfw,
@@ -142,6 +145,7 @@ class Entry_x509_cert(Entry_collection):
                 hashval_sysfw_data=self.hashval_sysfw_data,
                 sysfw_inner_cert_ext_boot_block=self.sysfw_inner_cert_ext_boot_block,
                 dm_data_ext_boot_block=self.dm_data_ext_boot_block,
+                tee_ext_boot_block=self.tee_ext_boot_block,
                 bootcore_opts=self.bootcore_opts,
                 debug=self.debug
             )
diff --git a/tools/binman/test/vendor/ti_secure_rom_combined.dts b/tools/binman/test/vendor/ti_secure_rom_combined.dts
index bf872739bc13..ea246599c6c6 100644
--- a/tools/binman/test/vendor/ti_secure_rom_combined.dts
+++ b/tools/binman/test/vendor/ti_secure_rom_combined.dts
@@ -14,6 +14,7 @@
 			content-sysfw-data = <&unsecure_binary>;
 			content-sysfw-inner-cert = <&unsecure_binary>;
 			content-dm-data = <&unsecure_binary>;
+			content-tee = <&unsecure_binary>;
 			combined;
 			sysfw-inner-cert;
 			dm-data;

-- 
2.54.0

