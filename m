Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2064C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10B9846F8;
	Sat, 18 Jul 2026 17:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="StYNrfKM";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G1oWzm4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF34B80517; Sat, 18 Jul 2026 01:24:04 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB9E83EEF
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HNFi0b2064543;
 Fri, 17 Jul 2026 18:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDV
 s8=; b=StYNrfKMN3awjGvtxtVQXw5F9Cwrg6FWiGJ+LJJ6al8fzZScb53rre/ZJ
 +dllhJbCp6g3WK7xyfU6pH5+RrNAp+S55+p6Y7JCWgMvpnrwco6txzbrcBreFikM
 6WooK7lMY+77P8nOqgUo0mmd/CEsGHGCIQUMLQ8G74tHboSTM9myYcSNLg1wd98m
 eaAlVzjy4uXa9u8kHcaAx4XCs/dFcOToyB/fu26xwXIPQMOsVFwbUWuHNIeQiI6F
 xf8f4oCh0AT/d+5NPtUA5bJP5Zrd54OYOPlxgyVW3bpNOQFLyP2RS5v2Qr+8LS/N
 QWQjqZ9xjPaufovAmsLp5g1lJLRUQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ffgsmcspy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu/kweCxt65GE/00/JUAPEj+HRkYqtT/Adq7Owvy6CW2LIc0NgfOQ6Ug5Mg8znZz+feEflNDXWQ4FioVfwFrDMf78VGrluMdwlPwLYtDbKHELGRfDysGNYFndkROlYXbSdJ0bNEiVt6t3RE35o2IPrrLg1Zbzplh+XhALu/5TS+ObeF2Qre4PJR6m6BJHzwtU0Vrhjix4fy9XrJR3Jf7qCAa87ICMyoyODLcwbiOoxhCMMNmJotOcf2tt9xJ++MPni4xUVi7y091vDfYIWN4pnlWPZ5BrEUNQ/r8Q0hDlnx+K8i0RhaotwTtj1feKtYgSISV50tsshlB7hXJKWAdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDVs8=;
 b=mVkwBMgZeFMZtErh3wZ+1p2zVhLFXa/X9PH+PGY/euCnEQEIL59dbdaeqYmqS3eHBIcUBFQEJg9nfZuISNFMHo6liWDhRwC+uDPV9yIWRDIsgWswKiul3wPZEC24pd03IsFGER5VL50LKfbtt2UZGDykSd4I1zXAEV/s1SUaGfB0dbIosbyoY8BesaA6sYFXTaez7gzAhyc8uk4kB+IhwPS4g//JGBXcKoPPkIzTQr6azhGIXGCCVMEN8LvLXBTRUr/wYhm85rj5y6csEEf9MELhAD02kHJ1Mauxw/xFz2M+CgdfikE4l67eEe9Jy+UTOnZd7QDOoXY01oKT5A+v3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f3AnSj/EojCMWQemgJtSIa4zFBilAC9Xp3Pr9gDVs8=;
 b=G1oWzm4TkVW+hb4LP177Coyyat6EoAYSwL8u1uXdnBsOKEWiT1IgarY8kX0ZdsHfxWnBkjfBnzubbzt1x3wPGMI2DdeHgaEMoQG9jtdM1k+XswWdgobnst3D3auWMegNTN9fPuZf7N7sCobdeMmIZ95G3S8oOdetAk2B1E8zBlU=
Received: from DS7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:3b8::28)
 by SA1PR10MB6494.namprd10.prod.outlook.com (2603:10b6:806:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 23:23:39 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a1) by DS7PR03CA0023.outlook.office365.com
 (2603:10b6:5:3b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:38 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:33 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNXfI150088;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:32 -0500
Subject: [PATCH 02/11] tools: binman: extend ti_secure_rom to handle op-tee
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-2-b9830633afb8@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
In-Reply-To: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
To: <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR10MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbb8edc-c88b-4c78-abbb-08dee45a6e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|3023799007|22082099003|18002099003|17002099007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: XO+bS5b4DGqcz5dLPproFD/Cqczta+BBKD78P+kQuyWohVTt9n1ie77Nmf4pv4mjKRsGUFdzvxMpYRBQB3Q56rrWwGMAIzUhIwhnObIucun1ixDT2CtOHiNBhV3q8JVUE5T0Nr1RJjVkTEgJpqmK+hLTXdB18BjU3H9/hi5V4iHV7/FUuui+7iGFAhyCi/qJvFkofuMwlfYUm7SzU8smxtUYQdnAGze25sL0js+n+/bU58zadehbut17HArgUmSD8sOc3ZPn5oCT316zcN4b1PjMM0f4ZWTMli68GGX76ZId+8rvt0uhfHoEB68qKduMY3LrEMonGG0LIc3l2k2g0bl7CnpYqrxZ+BJ2WR2ixLR0trrSlm+69bxZ+ktbDON7E7x53MSPaBBXy0nkfVKaY/pr9wOBI/Nv8Z3Nfdtf6sRsISRQsiBrcGJz+Tv4VXECfLxNZYinV8bIlrgkj1BUs9BhEWEUuJs8dOXaAMB42iOsGzu1yCpGXDDdhZvpuhwhXdStJwjtTzThKA1acgYgsqA/g/JAM828XJ0hpBq+UTEQgPcs61Rg8qg+FhlkJPk6RynfdGOhC4cvsJ7HQrDY+/lmRn+e0MUATQ2WFhzykQOz9W5Ol1OAyMQQTrC644AipoMJIGyepdwq+l0GizG9B/W4xbDUfuOZDaEwZN2E1ao3y2I/XNwJhnOly17f9RB7ycBEdXNcQ0x+PKL6lkCizw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(3023799007)(22082099003)(18002099003)(17002099007)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wKEAGrd+Cirajsc6L3jbSzM3lOZTOcj9oLTxOVBUaJUuRjYnM2R0O+rHdjgKG6qhOl0Qb3f+fYKCdh0kJM42S+4PEwSJeXtMm5J9ZFrTyWFr/VuZKuLqxB0FF9xbZp8CrB10OmrpRriBP7F54AHXMmkOQbY+J3HDoHpIm3BLNVSQtUR/9diDk7edRjgvV51+QDeoz4RPJBfmNe9E57Hf4gC/+CkkGs8BubFb3fNAUld932t3aRsjaWhcphG9j38pOVgGJYGAGFplk5IdScrgk+J21vwWslukhcVTfjRb9U+zX24Bn3bfuBKGPhJd8xLtB4IEpeCMNuZsRWu8MgtEfjU4QZ/AeZz6yztyBeVwIlVPvvmc8T6FwF7LsYd9pqA2kXHyckmQ0G8PfRjZ3jeDzkTdSaRau8tuMsejr4lYpIPB2Qwlh8w7rkb6Eqfdw9et
X-Exchange-RoutingPolicyChecked: sdUNMWhhCFLINMw8ddUb08XS/My99cAtcT/7/fVNn3v39Qyo06Pcl6WY+ushS58Evms5FllR3OwzvFRMlSNHcn3bNjlLQw9WjZQVjBk86dTPbyNyGz/MDsqjVJlKs6UZ6MbzlakWxlw8UYuCmuWp4kcf9sWBidvNZ4aSQ1hDV8gIf/afepbciEjnI7tuwyIRyY9Wme0fZ6W81lX0DyNxPwSGlBvo2knhjf+Q1q0f7oJ7gfzZNUSZEIm3VyMHjM6jiZoaADRU660COceAnp8lIq1G4QLmbk9jlaOjofry1N9/7a6epTe5+X27Lmbxj2KWfUpFsbymR7tB7qT6n9AvaQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:38.1325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbb8edc-c88b-4c78-abbb-08dee45a6e53
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6494
X-Proofpoint-GUID: 0i4pLmExgg02sVFmG-Pp6GoHRgPO71UC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXzW9Le01ULQNd
 5M2k79y+InnbHDpnU7vH+wnHpsC1S9NFNQQhxAa9FSwobOrZ37SmpEzOokwLN65EsKHtofPDCBN
 jFgy8+xHk1qSFHEDaRSRucAPnzY79PbbrHh4Rkcc/fzdYb11tjLBQihXMBYuv4BYPblr41lthj+
 E1NqmzcGf9fMsC7kiu96NwIZEq63830Y2MbBOl19/bzEK5LR4lHg6A+oC23dsYOmz7ZrShkitpk
 p041Xp39iS0qpil97467HqPoYmFjBhu9gcuvscmbS6Vf7cCSp9ftmJgG18W9j6X5BD/dCPuE/tc
 WE1vz7QxQ6vJXS0dFnvE3l28WheEqksD5vwYXjGg0D2KSWm2VjVey4PDlHMzTrkpxP68TGhkvyv
 s3zLN10sMT0OBK+6tlgCei+lKkWuSQDT8Rnj8KVlH5ZarsmYRs6HA/wSsOhmxoujgmfyXjKoXK9
 EP71UJKDntztvIRMR4w==
X-Authority-Analysis: v=2.4 cv=GJ841ONK c=1 sm=1 tr=0 ts=6a5ab97f cx=c_pps
 a=PeFxPTU/9IdxQzUa63kYNg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=9IcOKVw8tvNm7E74pWIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0i4pLmExgg02sVFmG-Pp6GoHRgPO71UC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXw3dPIS3yyiAi
 BHqRwneTyhTFja9bIBwewk5EkSqLe2CH/JjVHlmHS7W78dviBZTBWF3IQCM00m7rUk6sCmZyG/0
 x9M/rz8e131lb7ha8GFLqu+AxdkWZY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add an optional 'tee' entry to the x509 certificate template to include
optee during the second (tispl) boot phase for the AM62L.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/btool/openssl.py       | 11 +++++++----
 tools/binman/etype/ti_secure_rom.py | 32 +++++++++++++++++++++++++++++++-
 tools/binman/etype/x509_cert.py     |  4 ++++
 3 files changed, 42 insertions(+), 5 deletions(-)

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
index 7e90c6559409..4e0c9d54bbc4 100644
--- a/tools/binman/etype/ti_secure_rom.py
+++ b/tools/binman/etype/ti_secure_rom.py
@@ -80,6 +80,11 @@ class Entry_ti_secure_rom(Entry_x509_cert):
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
@@ -219,7 +224,32 @@ compSize = INTEGER:{imagesize_dm_data}
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

-- 
2.54.0

