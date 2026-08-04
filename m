Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAB0C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CCDF80B03;
	Tue,  4 Aug 2026 00:10:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MD2BfVA5W-UQ; Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A92AB80A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802201;
	bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l8WnrV/E5sULYCpB6eMrz9i08ojqIaVFNeF65KJ3vRymDZk1eDhuT9fJCpbXvDfuc
	 +ijP6ipoX7cErLl9VjOQ0eovFOT2+md8hCf+KQTdXFZ1d2kmbDoZO/CmwZNXrFC84s
	 ACS7nmeL2W/m7NrVIevaSvI3ctY8WQl0jD7yCoMdIO0IyE7AxOGQ7DVRiloc0j+ttF
	 FjMCPIt5gq842FrpUm3xxe46lZyALPdOPlnsXx9Hg0ttrdgst4y1ao93NHciG5wo6S
	 R0yU4iOwrD+aszlZHX8S9ZxiUaolgPPjWmKy3K4rUCw6MziCa0wClgsdo00t3PDwF+
	 OWcwkriz8+bew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A92AB80A47;
	Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75628218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59F1B4065C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rfxtCZ6HpFnN for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:09:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BDD464065B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDD464065B
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDD464065B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:09:58 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673JjAW2438746; Mon, 3 Aug 2026 19:09:53 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0rdb6r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFSNgEnQiAbajOSfQcTIlXoZOla+J08lRLhPSvgeR3ox5p4NZ+2StX6l18dzwIr4UvUvPlFqTwPdr783xKcJO64miE7Zcz5fgvlUjR+52SGRtfqBEyqeF5mGFPwOJSX0Mqo+kJfgANIMpC7lb9nnD11v8xmUgkio4Z2/XFbyKX4zSpateQRScGSq1bwW8eHC0UCOQwdZBpxqGhvQR7Q/64K7Ra0/vOeIxei13v7d1hTXjehoqpxL+gO+Kp2QgdtCqvgsanTeC1pX3fs0BPx3/H5G0h7sFxqHG8ArPr/WANCMYWJkygMt8SWfVw2QRufoVd4jTLKyO2jsK2W4QFWkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
 b=j8FhUoktviuxg6rlfjt7PFuk+SqC1W/GaikCE26KVdmN+KTQDmjaZ8s7lhtFVpiSHXQrAiQdByDFip9rOcSVAbfg5RFikcXKN1V3cObykyqG3BZXuF3kbFF7YJ0WbXBKWpjKy7XVJUiW++YHH6haYv71ZWXy5wdNJ8UcvM6JpqD4YfeuS2xgG0VNb6nvgcafYPsK/F/5OqmOyKWkl5ccZrKjHy9kOvAI1FuFoDSWr4s4yADq1VqaRpSeQLFLFCGrq6OsCruiRn6ScIYfMKs8jyXzatsrv7ccJS6JwOMaDNGaH6Vz8o7kA5own1Fl/sZNt+hJoZA4BATaoZXoMUPDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:332::23)
 by DM3PPFE9EDA11A0.namprd10.prod.outlook.com (2603:10b6:f:fc00::c52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:09:49 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::94) by SJ0PR05CA0078.outlook.office365.com
 (2603:10b6:a03:332::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.14 via Frontend Transport; Tue, 4
 Aug 2026 00:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:49 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:49 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:48 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409l2i2655361;
 Mon, 3 Aug 2026 19:09:47 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:28 -0500
Subject: [PATCH v3 03/11] soc: add data to identify the am62lx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-3-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=bb@ti.com;
 h=from:subject:message-id; bh=wLiT/fRszDiXogdjRvZY8HhozaEuziejhnSRyIRNJJk=;
 b=owNCWmg5MUFZJlNZrePFcgAAZn///7/f+/P3XXjZT2/73Jt/Pdf+3/9n6ten3n+vt3DOvuWwA
 Rtq0Q/VDQaGg0APUNPUaBoBoAA0AAAAAAANAAANGg0BtQeoBkNDINNDwaUOgANA9IAaDQNGgYgG
 QA0aaG0QaHqBk9TIyADIMINGg0zRNDTRk0GmgDT1AAMhPU0PUPSA0ZDEAANGjTIZNAaABoAADCA
 AZBoZMgMIZDQANGmIeoMjE0BBXBVryheAwhzCrKxw3ou4sKNggwLwRiKzlulnry1CU53SE97Ch9
 IyFwoeQ5CZMAnB95T0EgZ76cuKA1L9IeilUDQWhHfzxicx4ABMEVTRNgzVCIYUIKpuvPC2zUs6E
 KtINxDCL0HkPhNkol2pHryepjMNXa8xH3pjIgHflJM3LZX7Z06NbgGetcxv1wgxGCgjMc/qvXE1
 NMuBMTFs30ET2cB8yvcjeX0HVpPUdK1n1FigDbonSTpCsxUQidN/NnVMuf3X2q5Uw6Yj2OFwSg8
 M5f3AiVrPH5W+fu8CAR1yotDGdfhEO1sCJPPSlgV1lXvJu4n0UlOMeOtWQEACs8yAT2IJDwi5U2
 DPfVE2Yr24F52grQigSzRz0PsDGGI7d4TpXJtgwcUjPI+Cgi7zWWYoJsDQiGpze364Qfa6sDlm6
 v+LuSKcKEhW8eK5AA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DM3PPFE9EDA11A0:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bdaad4-8b58-4e48-4b2b-08def1bcb332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|36860700016|1800799024|82310400026|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zSIuAXzD7MSPkiDamY1hU9BPvc4C1k9VjW8IpZcFaG4ldNkMuVq3/AqUbj5ln2nD2fsxxz0dFammKDk0j8Y5L6uGXLbEIHKWOBzRnu3CdjQ2Y2VM/l+ToI7OOThnjwsksULri80YjwQ0GNzSLkboIupBZRXHc/oBeZJMnsMm47kw/EIgDURcbgJei0/8m7SPRgxJkD/xir7I097n2tLv39bhQK/Ume6gYei+kMmDgA5tmlDdOP7xUMFtlFxuhDn2wi9Y77lzI/9ddgqnc3i7JHU7ABES49jEMf8MrnMITntNaRQ8L9IoJ4NIr4CBMA2aHo+WeVcAkJHMM186N8kl9TqI3urMc7CnN6W157CcyL9GOIW4LViBXEFr8lU3Q2y4vbzt6XftB7DuyFfEjQJVCq+fcf55CAXiIs7FtWKLx6kD//+5OpxIzmfggyMFPBd3iaO3MM7gryl/TqeTFax+aB2djwN6jSKS2zaC79TUZUdZxdRNTqDpe9VhqYLFMstHLs85SBgzgNELWRoX1RkPiFwebVGhQ50PhvGdSUiz2BpFgHma6bZhHzDpr00F3BelGI7JCBC1kZbjQEOHi1vka4H33whnfVcSN3RrSg+wQ0EdwI6D/n7CNmvcaLEGTq2UrEU9xzVHwP+ZSCSz+l4giaaTGzWaSMhkO45J0NqGsVDfdrR4QOGHxGwYTQz9U36kO4hDJdY81s8cn1safenvxQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iMR2L2gSvmNm72/4mi03mmH/fIEshdulskaIrukZMIK9bDKSnqNzxcQf8clvGHny0M1CgaNfZLjwWlglukMn5TuYasaF7vFlqmNezGgSDrZBqbnjbwZKFffk3rOr030isdAMVSp71D4/vCsTlPfN7ci0X/KTqJuikhHOrUC+S5J4iVhKp68eEV20f0M4WjYpQakLVKIDI7jkJ9BrDmZDE0RzGKPOqVTfsI4jox0RnvZhS6TaPGTAizVlb1DMKMG6vHYopXaiOHE+8UvGWWJQGEMD7jEW5mMhpxYWniXqWLIbD2vBQYx50qNs0pyVN9rwN9g/HGWHrEzA9m/jA35/vMosUBi3qbuEiLlrIm7Q3rJL+iJif1RGlb3YBTo4PXje7wOjMZ1mqhgEYohDo6dGMFknu0P4JcnPsAGcsMafebR2tVcSsXQG672RpGrQV8vb
X-Exchange-RoutingPolicyChecked: JqTpeqAXpk2OxGQ9bsEhl7p4ZBJpLKhQT7LDwBeQsKdD06zxVOuYy5DjCl7lVkd7OOp8OSpTNfCObB5YwrAdsxHMXrE2LUYBysUBSo390eP5T8SyoUVtZnW1Fg0oQSSr2s5wTrKo4Y17683wdoWPEBfRbr3i2DQK5ZXW5XVnQiNdGs0X90Whs8PHkwSb8I5fZo0yHCfmZL8QW366mrj/JjxNrIMmfOUkZlCVktzW4kBsH1Vu9XO+z2ZqdkQuiyZ0hOxurFhrNJoxwm9Lbm093Jtepq2mjAT2pqRnAkDFo4FXEEfEoUwYS+VhRBhBCaL/1S5+peA2lsx8+U2w6EcMZQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:49.4412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bdaad4-8b58-4e48-4b2b-08def1bcb332
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9EDA11A0
X-Proofpoint-GUID: iRAQJx0fAA8KwjNwJQnLjFWNKYx_HWPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX6Ce943B66U8s
 vGScaJJH++riHH4HL8vMXRf9JJhRnHosk79r+rl7Eb1Sc3JCr3nMQjj2h0dmz0fV3CQaiq5/+wJ
 Xhy0h6UzJc2sWHLc8/8CRKrE68PrM+YhJsrm5aGKoxkIwcH/g5lQSUwSk2jSOPg9KDXhBRpBTyw
 i2HtlglAUXPs+IjX2p5uMxxuDKZa5aYZKWcnoxbZ/9PDUN5jfGBmRlkiUXZ/YoTixXTN2Sgo9Qp
 piFSbF7P7rbExghc3gXpes0UKVhaBG3pJntWHlPC66boz9F3CQKAwphZvoJifrm9Fcog8pE7C1x
 XpPkbUyeVXernmd8Oyi+1t7y+Hvbe0r9IpztOm7NftBqR7+uiPtHDhS5KWa0PU8DBFZnr0oUyLt
 r6XBlHObE2eCnU3hJ9kf5W0zPJvhUuE0X5m1Sp+ch1BnRKBTAl3jlXUSytTR71eVJUDjRXARf80
 NGP9wPx2paBs9diu4Cg==
X-Proofpoint-ORIG-GUID: iRAQJx0fAA8KwjNwJQnLjFWNKYx_HWPd
X-Authority-Analysis: v=2.4 cv=eOUjSnp1 c=1 sm=1 tr=0 ts=6a712dd0 cx=c_pps
 a=wFYUR1nkr81kUUYKqjx/LQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=56ctJiXxMvbzIHRyPDoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX8hRb/a1T2lzu
 4bVjD7Y0JvfPNUOpmM6Bf/uYGfFgqSwYhPKXUQPbDPgckJbL55bZLQg5+T7AYJiJsv3H9XG3+Cv
 VjmeUcrsHs7fNr/2yzN6MVbrMPlijho=
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
 proofpoint-05-2026; bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggF
 aI=; b=fhfIhjOabiQY3S9eO7lqDAVgg3NcPYhGD6HJQW9qL3ALZnPBAXDGgNz7q
 Hdj2zhNP2FhOLGhdpjK7uW/o+HIKdJl3tVrytkRkdzj7nbc6gBsZlsin98OiSzNd
 5qjb30Src+ZAAQYHmdTdAZavNADV7pXSc/1v6L0DHI47Bn7BRWX3/mwMHaS5L29z
 GNXFuI7aLoCHxhu4n/c3SoVLr8Z5y4lgyityPOeLN00Y0dg/Ysq3uhmw80re+fBi
 Tq4GkDAypPBqtwMLAS6fi7AUrVzt/gglUroMiQoEhTXGhFFJR/Q/NfAyCvaw1SNm
 8oQfZQRJD2QcgNif0C2fdNWI6+Ryg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGNxnIL7SeokoqTdAaRdG0agrOMQpWp1t3NjlfggFaI=;
 b=xDGXBnMX6dnFcoP/PaGL5KSNzqBz2bbMEt86MTsuiFqD+MwZrse0SRZvttfRnb1KftaQQdYHsVImIZZOHS14kXFgh5Y48vQSZCD5Cf756ewixO/L34+VLGkauBx/vU8+GmX1ykW4UDo9r/PLseoZW71WPiQN6atGjXycvSj6yIk=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=fhfIhjOa; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=xDGXBnMX
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

