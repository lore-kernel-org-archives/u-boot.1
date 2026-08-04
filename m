Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087CC55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C323A60756;
	Tue,  4 Aug 2026 00:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGHQed23Rx5Z; Tue,  4 Aug 2026 00:10:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51B1C606FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802235;
	bh=z9P7FFRpTUJ32gB4Mjrfak7C5HtbYKM5sWHZ3I88hbY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xEvWhJdaWQ2tniBARSo76+wtbHzueF/clOnul6/ugDK6l0i6k2ba3WKvH23UGNR8k
	 ErRk4ZyDEIj34APKzh0uVdX+ixANZzHxVTctVI3maR10XrIuVPFP4+zAP9ccGs1ZJD
	 od+M3K+QfXJVR+QiwwJ6kC6DooICwWY1PNOxosuTg9GdGoU+u4eHY14+UE7JVxaR9v
	 1CWCMkoyupRNOdiNIAXi2OpNA5XRu34eR9RZo1O6WFljB1zbqNg5GpOrWzVWgndLeX
	 PNVkHaE2B7ThMSrcPWQ5CzISUD+h0uanEw99UPlDXJMbImFN0fgmuChwMhp2lOVyru
	 PerGKUa5IELWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51B1C606FD;
	Tue,  4 Aug 2026 00:10:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C655282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E7B7400CB
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GFoJ53hvwUkY for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B269400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B269400B4
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B269400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:33 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673JjBwB565260;
 Mon, 3 Aug 2026 19:10:27 -0500
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ftsxpnvut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:10:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYP70dwTNCFaQ0VrCN8JmtyPBKupNktXetrs5zGgCMUbdLpycDA0O8yY+Xw5SQOEFDK41aBK96UV3K8pYsS8UOtzc5t4wqqePeI1fckExTfNCE8xcbnCWQrW+CjafHnW82uc56E85IrHhLaQ0n3Q1aq7EzMV2PEm+6jVf5O4f+8YnQ215Ji6Msxz7aEVmoIWlwjt7pjP+3QWvYMIXbxGfJNTdFMkKm1Iaud60Sbk32x1GxWga8HUhiZfPO/KtcNRUSk06xcXIQBAauwIOQg0Yn6v77y2YZWTXTlnvPQcKJh8Vj38m4IrV2sIOJE0+si1zFeIi37Wl5zWAlRX1008/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9P7FFRpTUJ32gB4Mjrfak7C5HtbYKM5sWHZ3I88hbY=;
 b=sA/odPXNp2N3ACdtTG0AKaKLEkCK917bBpbyq+kfL1Aa8czr3GTZEiV8JjsfQBCQXx9h6FFQZpwl3cLtE7Ql7tSLWKLrSbLfDiG29fnrwwlz8o43hMnuVGDATO1bpWLhmN5haTlh0XYtviyQ6drBO19WxQOj6TkAG+3buWj2X9RhYvc+4/IEU98f5nm6wWeJTze9RKcPOb4LIW80riD58bE41pOyFVHO2d9Xfvjt/DIkg7K4GbTQF/VCEorv0Ng4xtHBZdF0SWuVHmUvMLTfS6cLFOnSXC+jE+9OfDaRicklzkAE1O7VXL/knKsot2bp8jTzDPfdnQNG6Ffafqgh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:610:57::21)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:10:23 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::2b) by CH2PR12CA0011.outlook.office365.com
 (2603:10b6:610:57::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 00:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:10:19 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:51 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409pk13381226;
 Mon, 3 Aug 2026 19:09:51 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 3 Aug 2026 19:09:33 -0500
Subject: [PATCH v3 08/11] configs: am62lx_evm: add initial defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260803-am62lx-v3-8-b4f4302b09b4@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=bb@ti.com;
 h=from:subject:message-id; bh=vh1xia89QWZs7ZOn+jHWefEhoSVYvwR//4mcfHBZXzM=;
 b=owNCWmg5MUFZJlNZ8GfsPAAAZX///7///v+/28TM+Sb+sz3vXae32T1963bH/d7f83/5788wA
 RssZD0gNA0NAAGgABkAGTQNAD1AAeoAAAAMg0AaaAADT0E0wj0mhk08mnqh0NBkGjRoNBoZAxNB
 oGQ9Q00YgAwTQBoaGQAyG0mQaGahoZAGgaDTQANGjA4TCNGI0yAaDQ00NAGmgyaaA0aA0NMIGga
 DCAaAyGgyBpkyaGQaAxDRoAwgQIvEalkGR+1UkDjKsWNKkgr4R0IsiDHQoB5yNgOJmIqRHAEGKX
 wlbhegdOQN7rDdkAYCi47aiy+Qd/9JyoPyOjtIjfQAj/AgGi2h4q4OKvFIZWn5fqm/fWkpa1+fI
 6DdlKoJHuKHJ0a5FOlxS6z7+1zgZTQVWjjYdSHgD3zbjympUIdwK4D3DdilO3nShcg0F6VTl3++
 uAPhpULEChyTto1gmi71oco44FlNMCXb1B5Lfjudxs3gMccy5H2lmo7ESsoDoUMfTSDTU3Wex0z
 p9DILpB63DL4d/HDCoFyQCVozEJVGTwoDumsOEWI6lCGfXijEwoz2UJti0et8xxOW0OxJAX2Bet
 DKrwmAlIV4/7OOEmzCMwEuMmqxjfMx2Q6eqNCl0TBSjz0m2s7W9nsluZURFq/cBIAi6HfaJ0ru+
 f1BxDcgvBdyRThQkPBn7Dw=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: e34831bc-1de4-4da7-a30b-08def1bcc55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: QXsdcgqcjdYAkWm/I3Q3J0G7vWth6GeqwaJFhB4uLg82KCqMj3WrvmesBNuY7SRoDhGwV/c7TfinVY1lnhoV4isjbQQToZseY4lPfsEpNp5rLGDEEpUSLTLsI/hIgsjvr1J3RkVVIEK/0eWU88pbbY0bz/r226i8TtGhMkM0wgkMyIj95McrRU/kmaMxuob+nA0IC173zILHm2E/p9lYPCj5VPfOuYEtt6GrEplQEHfw7YSqXMb9LXMNxbu//OXnPvB6bJ8HIc4pKu+1H7uGHztkCYblFcbaTIy6yBo8+A23cGAAI29sUIPzHEzvN7MUkrPKKDe+hTZLRxY1uICOQYl89qemOCE/eVfsBOsc+hYGM465p55GdUY2dp+bX6UJJN5sSCATDbzjbSHjCJjWSJPmUGSzeRbxBhcFy1Skqm/yp+bc4uN7UfTrSwcWrSQ5gE3DYtPDk8/G6xgzypKuBXKnk62BtfncW0mTcmWS9eObduLULODDhZbqV3ceClYD7ReNus1lu9HiZ6lNnuj9Ns2i2o8jzmxJBiQozeIMS/jCrikQ5586ng+D9Bulr3Gmo8c77Ir3rGlQdu8ExCwPr5lug8klye0djFsdRbu6zQ0sMH2TlB3U0wz5kG1zCoLAsPiqt8Sc4PNdE6b/FZ/BVr2YWP0TeUvDk/qPbjs2NmD3tNOcKaZqF7dC7nGxjKTCJ6G5PuwUZwMHjWif5FdIuQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dOYfiwSpeZthDNUFAZEibiIJmbHZaKjTQ85Bm2S9wD25n8v7/zDbM+yw/zzPb7C0k3qfPpEjBYB3h++N4BBahEYw0XV5tkfC+Uuz7OrQUbeTdp3gNIFV5O/dXFRhIZjR1Q+nWjFxjEyKxzKY3WGs44R8UC9mbPkDLG/WdAYqvOs5rbZDYOjKh4+eJdUqLoXyHhaJEKREtZfKWqhdvTe84+LUmN6Dzc3lWcTzklQeNc5iCGDOb6Mtb3ARNUcJ9op1ZC7Jc6hYm1/xnCVBcx/ExJEEEXY2RAJygh17zeVFMCcpemJ5nJkaJ/+oBZ9CsgJdoVvdSjcLVrsa9JFurDiYAmtm9gjnG62QYrZgXeh2gmvtHXOg/RQvtjhQPlZKg8iLd9nbiUbeRSOoHGJmfrYJl54zTKWBhfZ9TNz3snR4h93zwhyPBqbVtEATQ0/c3zGz
X-Exchange-RoutingPolicyChecked: jOgoRtqf81nzP5flFxdTrGQT7VCh6tPSa73YbNW3tPYqu60Q25nniUJOZOFbNnsdkujsEuhI4L5EJI3uS2Uhsq2X5tFD6V9zDCewvvuo66jeabIxVkTbod2L3ewi9Jybrn9Fdzz4Fsk97X0ZRFEiECobwCyIZzkkVyMSiLuqC+1xSaP/csopz0T8ilG2IQSZCNCfgkdNvRIYn4JVI9GiP5m+2QmdZQQLMW92Ccml0MHN+UJTSJKkbF1PAtOEhMRpoiQAjUl27SzMc4jCDtgltzn6ciV0mLIjzjjs5Qm/yNdWpf4iRje2B+CGKgDS5wq3oebrixQYD/qE2RlDcQAIGw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:10:19.9455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e34831bc-1de4-4da7-a30b-08def1bcc55b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX0ucO+0NcBw2b
 JJKBpgucGWUqUGi9xvG1c80aaviOx2YtUvDdxrJ1BtwZaxry32Nnev4OVT4a/9t9oUWe5BIC82V
 +N4CKOVkoyHup4tkG9PClZlpJHa09P01H+DX9R0Vh61Che7RTWUx8QkcL3QQiNh32Q7EhEuO9xV
 WQQb+5386oTEbNwEfAQN9TA//BFHYPWR1Uew8LxDWmT+NHOluAF4g46ptmLlUOgJJ7KRRvjM3GF
 vVcwHSIQVM6/HfNCizbNM5OpeP2j+hQDmBhxckuMVIhlffHYJsV84Ceatu/6Eqxm3bl8/DLAy5F
 wgGlTfMBbfcbbFqHh0GUr2+gx+oZ3HiFezQStzMw8EDEe9TBW0v+LGUSqH4HBEJRpXlQi12aQ/8
 e4JUM0NLOeT1YK6Y4zLNf9bsC80VtN32oCAkmifrfvHOL5yQJAancbdHnNuy5rdC4+XZu0ttQ/C
 u9k+zFqfSjoZ2wilgbQ==
X-Authority-Analysis: v=2.4 cv=YaaNIQRf c=1 sm=1 tr=0 ts=6a712df3 cx=c_pps
 a=6cA/pxPA0XCUgbB+gUSklg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=mgJN0jjOy1CJ0z1pLmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xpcus_soR_-3_W44aX__VjQ8Bzvqvect
X-Proofpoint-GUID: xpcus_soR_-3_W44aX__VjQ8Bzvqvect
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX6oKLSUQBhha2
 6CiVjhPPqG39WWLH0jhLen2+PcmM+wtn1tRRfRWsafU83ck7VBQgnq90q+0biXrFTqeke9fXBPc
 ixtExFLunZP0dsjw42AkYRlqXvAdgnM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=z9P7FFRpTUJ32gB4Mjrfak7C5HtbYKM5sWHZ3I88h
 bY=; b=JaA4uj9WwwK6APIffGeBSgTyRSPQU80EpB5l957kJbABPupPlG+9jaDCr
 PxP+6O0CxRijm1N4ZM7rOljrpvuLPw7sFIWfPvxLnpfLtVuNSO7bxigVReGDabGN
 rsMMDTA1xj4OXecy6+ZPRjPk8YGtooGXJLdPlB6OMrK3RLTDqWO5j77VCwvWMcKB
 wQniBuEbHhU+A18BVMdDlzMrYbwY4H5RfYJAk09XoFytgR6gVTvsHJ0x9J2Hu0Pf
 tfmp0+NMjOet/q+zbzYEe+5mV5ZMze3RF9rR96uplKhKVwx4gPsgaPeFh9dfY/5n
 /Rkq/NS4H48RVqC4F1Q8jjBPCeOgg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9P7FFRpTUJ32gB4Mjrfak7C5HtbYKM5sWHZ3I88hbY=;
 b=m2yZWEYLLtTLi9RgyDVJJ7GpXdIHOKM5lAP90hnBXIvaTJhW7cYug9PjEfvXPufhp1Atzv25ZBwW3qR9TRLUeQTIvOInR4AFXrC2h5GpB3iGTt96nRcf+ehbydueAsjdfMvAt36+UZIroktBZ/5aG1NtePvmF4VqGTDQKAC64Us=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=JaA4uj9W; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=m2yZWEYL
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

Add the initial minimum configuration needed to boot the AM62L3-SK
reference boards.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- removed options used for fit image signing
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com
---
 configs/am62lx_evm_defconfig | 139 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/configs/am62lx_evm_defconfig b/configs/am62lx_evm_defconfig
new file mode 100644
index 000000000000..2db07b508c2a
--- /dev/null
+++ b/configs/am62lx_evm_defconfig
@@ -0,0 +1,139 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SOC_K3_AM62L3=y
+CONFIG_TARGET_AM62L3_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82b80000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62l3-evm"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x85000000
+CONFIG_SPL_TEXT_BASE=0x82000000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x82c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_SPL_SIZE_LIMIT=0x50000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_SET_TIME=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x83000000
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+# CONFIG_SPL_BINMAN_SYMBOLS is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_FIXED=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+# CONFIG_TOOLS_MKEFICAPSULE is not set

-- 
2.54.0

