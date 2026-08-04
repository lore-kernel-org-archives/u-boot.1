Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4059FC5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 566E680C94;
	Tue,  4 Aug 2026 11:15:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfwFzbG5iqDl; Tue,  4 Aug 2026 11:15:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F6D580BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785842123;
	bh=FSpAZ+BpdpTdAt9wR5X0IyZa9zFQ/FxKVXTLXVX4Bhc=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOfU8sikWq3KqPq7Vkc0FkWubMAP+v9AdLZh9aUUHvum83pF9mb2fbs/76xPYbRCe
	 iXFg1if6yWBfLUkjPuO/sCERU911QKFr4piKnrOkcJ1c4nZ1dMDRxBzobAI0Ju4AYF
	 JLPFR8AOowGHvxz29iGQPIz1ZdGCPtxXH/mT56rj2ORdlppjkKxNGLwAe2ArR6HvLA
	 1XpZ54RdPc20MQd+l+836Lb1AaOg9NdodSh5CcnbluGYGuuLEgAz8hZqe9NTSASM2g
	 vno+s9nArdC4QUTgrzcrcrroY7AvCNTXU9WzsMb8s9hP6O/XTyBx67xAcy2270FNT3
	 4qvt6pac1xFVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F6D580BFB;
	Tue,  4 Aug 2026 11:15:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 300C823F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 166DB4070A
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:15:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGh-cHmKcXgy for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:15:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3AF4440702
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AF4440702
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AF4440702
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:15:19 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67489fXG2293897; Tue, 4 Aug 2026 06:15:14 -0500
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fubrn97r8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:15:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEdTmTHWZVG3acDdp+4tVPrbifLrgleZkEjrfINXms2Gxji+PO9T7G9JSUxMIH9g81/3OslZlBxlDxPjvQny0m5fE62ilHp9fUSNOPNKfkMfvRjdKuSnil7f9LBo+EanFP9PTa/nCR44BoJZisoZDUP0Lb+sy2F4Kee0X9xBEMPALPo6CkQe2+R/JYojNUT2AkHc0K/JAh2iI8K7eXP46kotGq+fJvEv6A/nUljUK6tqspuAZn5EYSUJUTk9oJDCsBKggvq27coa6qwBwsQXsUwK95PL/4riEsyxbtmiOsSC3ri8io0eb7g51XXi+GH0EWLOJ2SlIecOXeJiSTID4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSpAZ+BpdpTdAt9wR5X0IyZa9zFQ/FxKVXTLXVX4Bhc=;
 b=XsP15EHT6PIPCSHcaKS+hxsu4KdYcpBsiuwPc7p2TC1UqrZaKuRLiS6HSiz78Qm0Lrbd22aMts5PkNLYvT/omPyFrXAw6BJLjBE3xT64n8M2I5IR3erZklz2JC1Il0W0tkUO4ytfigEYqSpX5Q+Oi/b3gKDnTN2suncpIuXODzGrb6zSGVMs3q0YY9DuSNy+0u2QW/4ZpjLZRFxMrd0YXaWd66m0Vqrk/BGvjZ6ttHNdo3AdRSyv5ooICHSr0XEsrGM/qDna2V+fDDsUS0zMLvi3xC23BcNGSUom5Y83seR7eA/8ons5DJAsKXw1DyibP4jE+FRl/eOLCWgylnJfwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by LV0PR10MB997969.namprd10.prod.outlook.com (2603:10b6:408:396::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 11:15:11 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::96) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 11:15:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:15:10 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:14:51 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:14:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:14:51 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674BEmqn3578850;
 Tue, 4 Aug 2026 06:14:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 16:44:48 +0530
Message-ID: <DKG46PJ4QNJG.1GN5F12ZB4T3@ti.com>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 06/11] board: ti: am62lx: add initial board files
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-6-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-6-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV0PR10MB997969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e87ffc5-ff2a-442f-a737-08def219a61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: HaIw4SoimHJPyqZoM1NFu7/6tCCjIYm5kSf5I4LAsza6lZLDGSZdfLhV9VIqNTVal6XNw3SYqLFW9CNinSw2O2gNAl4CkfhB0GFKzmUUWk/msQFPxv0eL+PtmTklhREcjoCTwIx7V4mgWsujgITeidK+YLZumK5kJori1DOA1ih8KtUQ2sq635nayp5t/S0jtrsVjjH0iiQXGqsQ8x4DecuJsabr0ICeqEM3kO3FTjNEujR3Kbm4tFF1e6MhpX/nhVtENEgSeDzEx9neVRDiTvxlgxFKoVfVsu30HuQ6jH83GbXuIENRuDSrjx4X3Z+KVQb7P6w0cVnrd2Us9gj2igjA9nys7fyCVNcEt4C/VtMcCEGYRyXhoiVa+uukeQgzEsv+8oDt8E0iNvwpWAXpJoaq7ojO/O14ykmVzmI7ywab3QGtTXAuPXrXExoFpjMtpcAhF3Z3Dc8mrRBGLKqPdc2KYRn2y6HRbwDMLPqiHDodweBrKB/B/sRBn9Lu4sOjT/gAGJfUrKHQPXu8n00FuCbYqMVGy0CuQbxuv+g8JclIVZ5oG9pDl+zqkDKXWNn+ieFLoyNi4lHky0dwKcDmofVNdafXJ8E7+dxGpIeRNHywIyUu/w/Flgnj5S1EQc6ECp8KzHhmcdo0DzN/Ho3iSKlaf5Lh4qmxV6LIxA4gXE3BelGgtFnfRJM01va2MQm3bMJsdBpbMzcspyGS/VQAmQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /dqjMAjdCulUqtGa61gAeDkatfUlaBlyCYPTpnFFbWA4VVLphXstD2Zz/KRf00rXsWu6IGaWrgn6Kn1wOsUEXwYl14dnBvd6XM8ULP/KJyUnvDUs66KkdlwtM2U2VKV+R5I7L6dY1uBXKtjKMs3B2Z5L/VwpiPby9yMatwjwOUOalHnNMAvus2iN/pzBngZhAS3WTAD3vlaEn9ERNJroiPyg/Z/kAg0cm3CrdtCml5QCH0IA0eIj3Lg5QCy/LtlSZf9njuKQCuRMksqRzUglCwM8mY+XF6cxMu0UqWDU6C+BHWjSSvHBdjyuZQp7Durb6QbyZFS+opDy5X/SAkG2atrmbbzEXjCYoyeWTbH/H2jAVRVwF24mCM5aI7W+7BZJGlaBKJpSETXQwL8yoXjY8dABQUX93JJvk1e6aQbaqAYt7YjPih/3sYCU19xUs9i4
X-Exchange-RoutingPolicyChecked: JvWC+DSxJXWTFvipt0RWG2v1NTLfFcjZJe5b3dF0ZgLsHLVS+N0VENaic03F8C6pT6yeBl5gqCoGlAPLiAOZA8I1D4+NZ/ssIXSUiGiusWCc2AlpbIToDJt7eE5NRM8xonczTiuAKK3aAGO3v9SMnerwM5iyjfnLJf3uT63Uamsf0oS9b3ImjXr5sZlXClsBaGlxEU84LQmibC51jqGdGbbhjck+IEqot7etUn+QP+Bjsu1mAoEW9E5xqJ8Oik0E3KqCwjVrEdsGAuXAvbTXrtwamQgt3NMDOKvMlSOVGoOpaO5VW/UT18ohfmlEtMFCOZjW60jdaoaQ29qJegx3DA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:15:10.6795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e87ffc5-ff2a-442f-a737-08def219a61a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997969
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfX4g/jQORdoyIr
 ID3sI7xh8RfcFCwRYRO3EZVkQMMrrdEkVWroQrH5ULZThdijHU7vhLYtW/5L598a4jzTNYFkMwQ
 as9LhRp5P2zhBDMklThF0799Xb7m0ik=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4OSBTYWx0ZWRfX+WN8btz456CV
 m2SRzikyp+w8DV7lFNU/hCj/ji2LwsURlvtl/BqBiuQbp4pqzLLEnuJTykx2To4ZPMpNUlIr4/g
 DYcKPOXek4Kloi4gOM05mc6V3VcQOqXqQQ8B3L95ELVen98OjseMzX0q9s7xvNnfiRusM+0d4CM
 GXNpDVtxyIXBFJxP5Cd60f3+5G6tJs5aw3uBNI4jvvuFob5B8kJh1R6SEelR75DDl+C1Vrefgc+
 qzo1c1ej8/3FnePxSE+pNsqolM+uZJSELpwa2FYMOX3P6k2bAwZep7yaQyz2q7P41nI3Sc864mv
 xPDLeW6VPJYrBuVP7Kvo0TnDQkecF4iPKCSP/D0UAt1/MzGPoVZa2OfXVAVZXqxEoIJHkPps8Ic
 30ilds5p4QDKn2wxFsMRMm0R4gNhljGN2jEb8U3//w7nBRS1SFcV+YP1o9se61M+HU/b2LLWA/w
 Wkx4Yi3iBbziOGXhwjg==
X-Proofpoint-ORIG-GUID: RCWwwwGluftmDoOxCnNa5bs78rSKNCDo
X-Authority-Analysis: v=2.4 cv=c4Sbhx9l c=1 sm=1 tr=0 ts=6a71c9c2 cx=c_pps
 a=Y5aTAp+79vj4S64KMabfRQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=ltq5i8fsLGWfElaBJ5sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RCWwwwGluftmDoOxCnNa5bs78rSKNCDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040089
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FSpAZ+BpdpTdAt9wR5X0IyZa9zFQ/FxKVXTLXVX4B
 hc=; b=N6VoL4VBxN0eKwsNuVPNFwE9h2p4sg8L9gDkLtU7Zoaf0zXVPzRlOU6py
 5/Yh8A4TGqVlwga9nvA7kfRU6a3i4JYYQMv7Pvfsqz9vA/y1XOdTDuecFv0CTD46
 ZLv9xT92ZywJZXuLLRZCbkQ/lH4kgZwkXwJsacMtyfzItxb/ADJ3Guoi/mnKISke
 tp1rsC+R8XGe2qSjQ72qmlQ+8hK4ZoTavwS6+waPvh2XGdnb91F5jnrSGb2Jr70A
 47eg0rl6qX6qB/HySI/H6tnt4877ORK6fV/TIUa+G84y63JsmQC6u8RuGMRByNxn
 CkJq8tw6er6LQwyJSbo83xWvps1Lg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSpAZ+BpdpTdAt9wR5X0IyZa9zFQ/FxKVXTLXVX4Bhc=;
 b=qntbUfr1T+REw/PMaRK8nZ+n2cJfRsZnNd09RXdbD7vO55WZNYCdljV195w/3CwWCNriAGL9NzQ5YbAQW8MkM81wC50WaepsI8EvX9aIqTCDTucra9ly3NQAx/kxHRQNTvNbuPA50cGSddphF75vmcn0r+2UFU9io6T6bfcOkBY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=N6VoL4VB; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=qntbUfr1
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

On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> Add the initial board files to support the AM62L3-SK reference boards
> for basic boot via SD and MMC
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>
