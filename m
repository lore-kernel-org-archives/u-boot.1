Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E691C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07FFD80D86;
	Tue,  4 Aug 2026 21:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wf-a2Bx3DDYf; Tue,  4 Aug 2026 21:55:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB87280D81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880548;
	bh=KGEgkQ19+XW/JoH4E3ja9zV8L82EhFMVfjY21cfjCaI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GvQ7HfhHkbfR6pgw5+EZ7/lZPXOzG9fFpnZjLONsS18OccxMlDBBfLTU9lb1DIsr1
	 mBPRotlzHcthUYgZ+caXgmIDLuU/8wbe8Xt51S6MJgCLvMrTVIv7l9U8YHnpwZTOMG
	 hP+bIZ8yD+Lv36k2Ho0fnZNifGBCuU02PbTGFyNsrV2Pv7gHhX/6fNie4bGey7CfZ3
	 5XEfWmWjoAqApaHALX0Fx/ZFCYx7CIsy44ZKUBXSnGq08JLDSg7ax33BIYc3JHf7RS
	 xl9XgBdQ3noHUjb22j65wkFw7tS/H+dijoBJSIBojzEYlzZceaZMH4iHgQw2jmgkUa
	 MgZFscj8GQQNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB87280D81;
	Tue,  4 Aug 2026 21:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70F4E270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5707040608
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0gDYNhS6WbI for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41C9F405D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41C9F405D0
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41C9F405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoGD73496970;
 Tue, 4 Aug 2026 16:55:31 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud49ddef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0LdUvxhR/fF65abLv6huqoBTANjzsTKIOQs7Vb/IH6N7dAhAovaOr05r3fD2A1ptOawOXUlWWu4hLEWherpZWXoL8ruV4FyAGrbhngh2+n/oalW+fkaw9/8s42/hozdoHSJauFWbaHFrEltoTraxYMWS1w6Eg8M4bvAwzld0DN4dIRjwdsfARAklnb8Vr5UeRKCQVB+3Alrpdo41E1cT5+H7emCS3F+M5jvO/znRmuf2dB+8L9sIq9Dm/Vujowm7Rz91nytMqkUNhSsh6mG0RN8oJeW4NCKQlOvlfSK8LlvcFGFQr6BBIRGqKDp7LRQ43n6qEiNtGuIGOcawiwg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGEgkQ19+XW/JoH4E3ja9zV8L82EhFMVfjY21cfjCaI=;
 b=Go6io3xzH3CyFF7imetZ+zCVLIde9dz2pI0QEXCnn+cYhd3+Ik01W0GRgyw9EKOnbRZXsoxg4k3t/oSwWUOVAJiTxoNzpIoaDrkkPX2VKPZEZU6zMX29Ce8n3LJ0NVWo+OwWkl/lLpUCS2AW11BFeaGAebLgwRUOEWgdZRHKpJ7V9lLTvNXA13QXn3qiXXD6clngLzDCgfHf5m+iQEPcZI3URdOTma6IjLHhIC8vDEU+habeq2me0WU62kEAZQ3nitPvrsQ3Ee+/XryEeLTE9Pyqv/CNNrxx40bNOoPgQWeBZQbRPTt2E5aUvYW5GhT9Nb6kFw5s77w7kY7sEb8vjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BYAPR21CA0024.namprd21.prod.outlook.com (2603:10b6:a03:114::34)
 by PH0PR10MB5780.namprd10.prod.outlook.com (2603:10b6:510:149::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 21:55:27 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::a5) by BYAPR21CA0024.outlook.office365.com
 (2603:10b6:a03:114::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Tue, 4
 Aug 2026 21:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:25 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIVE968772;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:06 -0500
Subject: [PATCH v4 07/11] arm: dts: k3-am62lx: Add binman support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-7-01746157643d@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7418; i=bb@ti.com;
 h=from:subject:message-id; bh=7/1kkObrFIrYrM+rIFqsDMokulGeow4E6C1xMPMyprY=;
 b=owNCWmg5MUFZJlNZQVNwmgAAYf////f/jv3pjtTr/vl6+356095r/z+//079bd97lPdP2dcwA
 RsZSGQDQDIDQDJkDQAGQyGmmTIBk0aABkGQaaAyZBoBkyaBoNAwnqaDEep6ahkO1AAAAAaBpoAD
 Q0DTQNBo0ABoBo9TQG1NNGj0EDRiaNNB6jQGTJtJoAGnplB0Gm1AwRkBoGmTTRkaMhkNA0GmgaN
 AGgZBpo9QGIYmQyZNAyZGgNNAA00GmgMChWsQeajQMbkDC6oRrjOCdIgeX4Mgq1NmiM9kBFhAY7
 FI9oS3gU2qDQ3czk5GDgdIvp5gCsKkYQ2njGj9uQuncVmaUCZYrlvKI5e07HlHdYM5/NqXUqG6a
 mLBqsgupZ3NugB9iUMGRYpFQTgVsMwWnhHVeeQs0SBl8m0nQVJA9aNmd23ovDyzIrZ8+sbOMVfw
 OMZEJCoco5fn1IZphKrVGwUXGSaxraDnaBqm96duX5dIwtiAuEJXekmdOCmGvoxo2KK9MizZNvu
 IgH9x1JVteW8hKlr4YggACYagd4z2uDYVyTD627sEs5ZcjmDoHnQoCR/t32X6pLwfI0SixcJ1o+
 5+NDBeROM6z4svdWQYTu+kE6IBdCa4IEXXu5gZP/MRMMA+ECGPP5I+/MKlhCtS4JhGqtKNEpf1w
 WIIjS8MIepnv0R8/8XckU4UJBBU3CaA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH0PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc1a799-312c-4024-2ada-08def273170f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8Oav4KcIoEpUK14R+yacMfL2bngs7WrM1gRdsUl7P6a4BASai0rFJ24LpVMSKeEp7LdHPWrLcthV788nwpSeuVvW07sTZGhxBUSEjeZkxPNMFAO2bIj0uOZWCuEur92Zi3VBpdOFQ9pip8YnDVOeL+JWf1O3GK07MFAufcbjAbX/3KIVXaEuM+8zBfw6/XtLLJ3SjDpAK/UXDO3o/OH95JM0gPBU1R0ZfEJrSCE54/QEw/dNw9oocIUbTaHM/69qDJhMMGf32IEPoubgRNarir4TueARjQ0xaLz7euW4ppOIVhF8vytfKoNZNU4TC6z49LN/nvEQB8zeB0NrS6vYDoNmNasSpUx9FgeiqD/A2ERxg/uBXsMvgkJEVdnn1NTIjwcEpAOm4Py3YQnj0q5ATtgWi4c4F3gRO4OTN3ZK9bscIbzYiCRrolOp9T5vq5TeeESGbj+XElpMaejGmqRoety8K8ZPMcdY7Iu4/PYsO6zZOofopaOoSLDA2vaHdkbS0T1nNaTarf8hBlPP5cVIyPT5iHRnTx8dRE/a3ycII77lgTUX++nR00W9W+jpLYzkcISShhBcqIGwijFG75gVS6C3chQqulWsL/rTUcm/VzulSNgLfKpYrvPRBH8Xt4LeeICnqkF1qdBMat1Wo4bUdg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2/DqmdPXizOA9nqEX73f1MHOACCwhp/zvIKoVjBtZPYSq3LqTsJgmtsPzw9pMnzxnlg8Imlq5hdI57gcBhDZYF34IjQuL0csvjEUadpHYN4eTHNVr0lP9q66k8HtAhDIiJHpo2GceaJCfUMyYrKoN97TrE5R3wAAIIFNoNr+l9F2xYU8OB37sXaouRfwIP5P1YIAVkVsoqQ7FPxDC2SQ5UssPDi2BpV2Za7WiaqJ2Wux2O86qs2yN3ExnARVv/O2wj3jYNF8N1FnAOAz9u7gOxANvq8/PeMLEntBa6Gsm0uODigFv/uENhwEIAxFT/U1/Q9W5hvMhbdD9+6v0sXtOc7StESjs9PEyq9e/MupbzhEqVRB7dsVJRh8NwPy92k1doeYhKvwfS9pyc/hPOcpN0g6xzK8Sfep/msKOpll/TrjvYoih7QXIEnfPrL40KrM
X-Exchange-RoutingPolicyChecked: FKUOAuZLPN70Kd78MBrXp4TgvmaeoEVsfv22qNqIU7w/Moq3Hsj0ANs+yiHdPQywNABGBxB60bodt6AUXodz75Su6+9PDKV6lyifNeKchSTKqxIwKT+FOFhqywklXEEIXnsNth3m5Zxjt14wIXGM46B7XTfWRROrHXRK9mRjFZOmw63PoIBZbq86VGDCDMrjIvly6zIfEEjsIiSDT1fb7aQM+D36dUKAFzVN+fXofooXB9R61MGLdrvIZffw3BW5XfWg121yrR8pI+OX2i2ydBcGftbfhZoxaQf/1Hhdq/O5ck/C8kBIP6haZ7pedac8cUwk5bD4mmG2VEQNb60zTA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:25.3891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc1a799-312c-4024-2ada-08def273170f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5780
X-Proofpoint-GUID: gKKqCpYfNmtuhR0WwQl8EbZzuS2Qa51i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX7Jlt8pHQoghF
 ahIMBeIYUsElDZWFquXGd+gCo3MUM0tHlNMHlWp3WX+oTuCwUCqbjmSeo14eLNJ+P2WI9IfNiFj
 1EUTLNozEDvUpK1Q3/xVyue39lBfASGvpfGRHiEkbN9thDdz/nUPbS4fu3zzqehdyHKnTmT2xix
 scShz/KYBkwsRSVCuB573JzesnnhY3uHlZoDq5hKGxfNZf/At+A6Ug7UaQtBAH35rZGhE35hJph
 /ZBuBcyFn0k4tAJMkdKfHDseTSU6Zm6EzV5cwnI/9igvdUxp80bc348PLTN/ReGLkhvVsMBzaMs
 NVOt/2iIIFjL1kBZ+LKgU7Cy0/B4lfgY2aDwFqWPrZmzPJFUqL35+eP/4IK68iQUSvfqnJQCc2B
 ehrmpYV6+RtqvUyIgQRdi9aN7D4EdDqWltZ2x0cr9l4j7pU8jZ/wef8m+88N8cOB/cdWIWSIxLe
 ApE1Glxy+Yp2hmV/36A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX4GA70eGRhIGJ
 X7HiVZFfdzXF1zn1+vuEMxvJ3wt6bAYF781ZGWNtH2CTVx0TuSjQdn7/rCsMWK9fBuThbZZhjNy
 Y6EPhFJaagqOq/DCHFKrbkr1MLwL2/s=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a725fd3 cx=c_pps
 a=qaGWf3H7ZUycNCJ7m3WmPQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=6G3Wt455AjdQPmq9yuUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gKKqCpYfNmtuhR0WwQl8EbZzuS2Qa51i
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
 proofpoint-05-2026; bh=KGEgkQ19+XW/JoH4E3ja9zV8L82EhFMVfjY21cfjC
 aI=; b=nm2noP97e4+YaDF8Ffj9wB7gPfllxuQBu9jckKPw+hxJr9PRoLpecNi0q
 bV8tYsOwJ4y0ow319E2ynQulozpoh2YQd6CYO6OoOp8tEi0rHW4vTvPq5AD/vDdJ
 NGf7E7kRylEl/vsEPr53O+L3O+IuXQKp9WpAq09DblWi5xdJaGPN6IT4f62uVCGQ
 Dtne3si2T2oP2XmVOD+6McLAEoQKDdHfPjXNZMZP/m7ryvxg0uyzmZAti34+GRiM
 dkruaXKCGBs0RD+77fz4I71SmqUFcBI4a/9zg3IHHfRG1x0dOYe/meexsSk+kZWm
 tOwEcVKXUlmfcvC32CZ7hu7FgNsEA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGEgkQ19+XW/JoH4E3ja9zV8L82EhFMVfjY21cfjCaI=;
 b=hL+XWatOHELQw0VNn5HvP3B7L4x7aTwddnDKjSEMZjnlaq1HgwnZoEXxzIm+kk7BtzRLx2WrNxSv87PzC7bsddVO/+vHkcAkArIl1ajlfpdnukAZfg5H1D37Yhuc2jLlj1jYVF1Qy/rgX6E6t3N+OyrsFn7MNKa3muY+FqrZMfI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nm2noP97; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hL+XWatO
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Add the initial configuration to build the boot binaries for the AM62L
family of devices

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Removed bootph from scmi{} node
- Removed signatures from u-boot fit image
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 arch/arm/dts/k3-am62l3-evm-binman.dtsi | 218 +++++++++++++++++++++++++++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  12 ++
 arch/arm/mach-k3/Kconfig               |  21 ++++
 3 files changed, 251 insertions(+)

diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
new file mode 100644
index 000000000000..3f7e2097e521
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/ {
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	custMpk {
+		filename = "custMpk.pem";
+
+		custmpk_pem: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.pem";
+		};
+	};
+
+	custMpk-crt {
+		filename = "custMpk.crt";
+
+		custmpk_crt: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.crt";
+		};
+	};
+
+	custMpk-key {
+		filename = "custMpk.key";
+
+		custmpk_key: blob-ext {
+			filename = "arch/arm/mach-k3/keys/custMpk.key";
+		};
+	};
+
+	board-cfg {
+		filename = "board-cfg.bin";
+
+		bcfg_yaml: ti-board-config {
+			config = "board-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	sec-cfg {
+		filename = "sec-cfg.bin";
+
+		sec_yaml: ti-board-config {
+			config = "sec-cfg.yaml";
+			schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+		};
+	};
+
+	combined-tifs-cfg {
+		filename = "combined-tifs-cfg.bin";
+
+		ti-board-config {
+			bcfg_yaml_tifs: board-cfg {
+				config = "board-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+
+			sec_yaml_tifs: sec-cfg {
+				config = "sec-cfg.yaml";
+				schema = "arch/arm/mach-k3/am62lx/schema.yaml";
+			};
+		};
+	};
+
+	tiboot3.bin {
+		filename = "tiboot3.bin";
+
+		ti-secure-rom {
+			content = <&bl1>, <&tifs_enc>, <&tifs_data>, <&tifs_cert>;
+			combined;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&bl1>;
+			content-sysfw = <&tifs_enc>;
+			content-sysfw-data = <&tifs_data>;
+			content-sysfw-inner-cert = <&tifs_cert>;
+			load = <0x70800000>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			core-opts = <160>;
+		};
+
+		bl1: atf-bl1 {
+		};
+
+		tifs_enc: tifs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data: sysfw-data.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert: tifs-cert.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tispl.bin {
+		filename = "tispl.bin";
+
+		ti-secure-rom {
+			content = <&atf>, <&tifs_enc2>, <&tifs_data2>,
+				  <&tifs_cert2>, <&tee>, <&spl>;
+			combined;
+			sysfw-inner-cert;
+			dm-data;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&atf>;
+			content-tee = <&tee>;
+			content-sysfw = <&tifs_enc2>;
+			content-sysfw-data = <&tifs_data2>;
+			content-sysfw-inner-cert = <&tifs_cert2>;
+			content-dm-data = <&spl>;
+			load = <CONFIG_K3_ATF_LOAD_ADDR>;
+			load-sysfw = <CONFIG_K3_TIFS_LOAD_ADDR>;
+			load-sysfw-data = <CONFIG_K3_TIFS_DATA_LOAD_ADDR>;
+			load-dm-data = <CONFIG_SPL_TEXT_BASE>;
+			load-tee = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+		};
+
+		atf: atf-bl31 {
+		};
+
+		tifs_enc2: tifs-enc2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-enc.bin";
+			type = "blob-ext";
+		};
+
+		tifs_data2: sysfw-data2.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		tifs_cert2: tifs-cert2.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62lx-hs-cert.bin";
+			type = "blob-ext";
+		};
+
+		tee: tee-os {
+		};
+
+		spl: section {
+			u-boot-spl-nodtb {
+			};
+
+			u-boot-spl-pubkey-dtb {
+				algo = "sha512,rsa4096";
+				required = "conf";
+				key-name-hint = "custMpk";
+			};
+		};
+	};
+
+	u-boot.img {
+		filename = "u-boot.img";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "U-Boot fitImage for AM62Lx SK";
+
+			images {
+				uboot {
+					description = "U-Boot for AM62Lx SK";
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+
+					blob {
+						filename = "u-boot-nodtb.bin";
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62lx-evm";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					u-boot-dtb {
+					};
+
+					hash {
+						algo = "sha512";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62lx-evm";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
new file mode 100644
index 000000000000..d48b478b89c4
--- /dev/null
+++ b/arch/arm/dts/k3-am62l3-evm-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am62l3-evm-binman.dtsi"
+
+/ {
+	aliases {
+		mmc1 = &sdhci1;
+	};
+};
diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 8249fc97bc93..02f82364777d 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
 	  Use this option to set the index of the serial device to be used
 	  for the early console during SPL execution.
 
+config K3_TIFS_LOAD_ADDR
+	hex "Load address of TI's Foundational Security (TIFS) firmware"
+	default 0x40000
+	help
+	  The load address for TI's Foundation Security firmware. This value is
+	  used to build the x509 certificate to tell boot ROM where to place the
+	  TIFS firmware in memory.
+
+	  Unless you know what you're doing. Do not change this value.
+
+config K3_TIFS_DATA_LOAD_ADDR
+	hex "Load address of TIFS configuration data"
+	default 0x6c000
+	help
+	  The load address for TI's Foundation Security configuration data. This
+	  value is used to build the x509 certificate to tell ROM where to place
+	  the TIFS firmware.
+
+	  Unless you know what you're doing. Do not change this value.
+
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
 	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S || SOC_K3_AM62L3)
@@ -149,6 +169,7 @@ config K3_ATF_RESERVED_SIZE
 
 config K3_OPTEE_LOAD_ADDR
 	hex "Load address of OPTEE image"
+	default 0x80200000 if SOC_K3_AM62L3
 	default 0x9e800000
 	help
 	  The load address for the OPTEE image. This value defaults to 0x9e800000

-- 
2.54.0

