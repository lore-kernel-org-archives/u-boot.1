Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ECFC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 00:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BAC8606F2;
	Tue,  4 Aug 2026 00:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G5SF92TnLj8L; Tue,  4 Aug 2026 00:10:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00264606DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785802204;
	bh=3Pz+KYAwdYSVUYdjHjmo+wJgPXXORYM5GCmKMVXW/is=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nkDAAREs5+evTFADH6nxsc9MsW8vt2mZ/Cpjvr8Ko29TBV/yC8E+zr3BjUaWBrkfV
	 wVXXxKfs65SUmwqvR4iusdNDzjdpsdvYJCaVUJWAX54x23RYtZLUNwdXAACZ41OckO
	 LMwilOA/mUBV8gc1rU2YxZwzhZX/AHQ4wvhbr8TMiLYk5rz549z2zgXMN4AgQuKLqI
	 qUzlpYefE2haAC5BFdmTNkXAn2H53U3BrH9/qJh1jRAZf5atwv8kjiD5y/Jlv9PoZI
	 o1rEt+0Mfu9hvB5HhHIcId0xr1GzY4OdLJH/7mSgUyWSc6c3UZ/8LouP6JOaQcLch6
	 4ekVaD2RBtKJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00264606DB;
	Tue,  4 Aug 2026 00:10:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 407862BF
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3263D400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNcJc794Ww3f for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:10:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BA5C2400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA5C2400B4
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA5C2400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:09:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673JiwXh1687782;
 Mon, 3 Aug 2026 19:09:53 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ftt70dppf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 19:09:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHc8KRPrJFBieKTxyYdzreOiH837fzHB+bpAuf1TKgBoUmtqcQLrhnRfO6EGNotEoCSpjBTju5kAxL+u8JowbghJQ3VG+Pc/fC79b+BSH4ptr0VCaF5Ug5tJrXEdSDOqUkLihVx14i3rj1w1Es+i2HZh3D/UxJL3FE3YoXJwc5gfmtMgHFzUdtpmrmiL/So/soRfuk+eVX4VV+VaJUPiog+CMUrsNmpDgHXfCfD7OJy3XgYKuKv0wi3y0TtXQiX9psD72AF9lgbdllHyfScex9IaeU7OMrC1sXQgtGvlh6tAF5P7sHp/PRRM37oXktEXKlE1FLyLcZek9l8Npmy4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pz+KYAwdYSVUYdjHjmo+wJgPXXORYM5GCmKMVXW/is=;
 b=KujzvKP39Eu94ovCi32KKq41ouV4+qLKlFKH7nuHi+FPKw78N4t7yJjYpQMrbnOQbm03KmvCJ2KNmOn9/6ZJX6xFgqKL88AS0Vd/E/ibPwxHHmiptJ/aDLZHiKpK8P6YvArbE2gqqoK+3u7iBHCzqKhCVbih2LjF9ZNhVGIXogJIiohP3sCt9o8ZaI0yhTG3AQlRRvagHYfe80kP6EHKUpET/q9FK1+T7teB4PGwiW5IyvrcfeZkWO2D2nngV+7Ti/YanRKoWRxB+tSF+U1wayuFBy6EgWMuqat4FukZkhTcuz3vmgJy0efPWagaE3H4YVodDgExX6P3BCwTXgErRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR05CA0087.namprd05.prod.outlook.com (2603:10b6:a03:332::32)
 by LV3PR10MB7982.namprd10.prod.outlook.com (2603:10b6:408:21a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 00:09:48 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::9c) by SJ0PR05CA0087.outlook.office365.com
 (2603:10b6:a03:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 00:09:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 00:09:48 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:46 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 19:09:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 19:09:46 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67409jTZ2655335;
 Mon, 3 Aug 2026 19:09:45 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 00/11] arm: mach-k3: introduce basic support for the AM62L
Date: Mon, 3 Aug 2026 19:09:25 -0500
Message-ID: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALUtcWoC/02MwQ6CMBAFf4X0bE27C2315H8YD1Ba2UTAtKTBE
 P7dQiLxOC9vZmHRBXKRXYuFBZco0jhkwFPBbFcPT8epzcxAQCkFVLzuFbxmro21TqEv0SuWz+/
 gPM176P7I3FGcxvDZu0lu65ZQQkv9SyTJBW8uBoVCrH1jbhOd7dizzU/w54A8HMgOoveVERaUb
 g9nXdcv+1iEas0AAAA=
X-Change-ID: 20241025-am62lx-78cce63f43f6
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7710; i=bb@ti.com;
 h=from:subject:message-id; bh=XiISdgh+ki2NfVR8dXeGXa5CmWt/YYjZ12NsdnEZ4FY=;
 b=owNCWmg5MUFZJlNZPxI99AAAaH///v/fazXij8X3n7Dv+JV69fw/wX9/uv9Z/v//2nHd90+wA
 RsYIeoANND1AGnqABo00PSDINGgAAAaMh6QABoDagAaZAABk09TTIPUZqMxNIZQAZNBoaaaBoA9
 TQeoNGgDTRoAD1DTT0IANlDIZNA9TQyHlAaG1A0ABkGTEBxHpBpiMgxMIBpoGExMBAAGIaBkGEa
 MAQNGgAaNBk0AaZAGmjJoAAAG0GsQp7CdhZQ+IFoKP6nZ6Q7gwBaMGS4q4Cb911AhIRgjFQcCbF
 6VJuX8EHTuqsQ/TnUJyL9Ln2bC0uGbcrrQba6ZhUp4HpSAciQ0bNpVDk+WxkF1w1iNp26EQNGXd
 9oCshqS1cArR/jSTb10Dv2DdwyRSMp/Mr1AnqDbFYw4a0UyKN0EqiQF4Q+ZcZOdUqEoIDFLrqAz
 LTGKWu4eGZ+AVMReFMAj6viO3y8hyV9tg0AjotNjHibxHfw/i43jzZgiSwCcerrM8EVSH1lKBBf
 xL1Lug0ChZpwP5caafG7CnNplSL6Cx0D7zxK2K+KdBkhzzYEEu08yMKBITe5uzrTsq7rA1fIRsr
 fAALyQJG+iBGuqNoOfRNhywBCpQRrdCtenHiN/9JeljMluWEStGGDKtFLEhy4AUBIDL5D7GHXP+
 LuSKcKEgfiR76A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|LV3PR10MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 83548d7d-3df3-4ff6-3f58-08def1bcb26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|23010399003|3023799007|56012099006|10067099003|13003099007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: caeu4/qx0AC50D/VQbSCOvCVjOcIo7YVSziXnJmZnsQoKxEDJ/GrAt7BG8CjqviH+iUSno5JMz6YXgdKkGJPszrleEOKJ+5bIK8Uiq1VKEXaS9jPCXwC3hC5CG4RM7zUBnUYGKKC6uk1/5cJEv7DfuBiZiNknLayZtwe9ub+WFSIBiujhdRxCh/22NkoS+g1Nh3MVNa0HPhD+7xwwpQ9SuBfDDP/9nY30wYKU7qjFSx05fBYrWB8cZ2w3UfEwSAvmWZaNIY+b8G+ZLeEQlTV+6HyWJaqYwd/SQ39y9k/VufI81txXOGiwB91aiklcUxDvIMMGYrqVCfjfI9SVFQ/JekfJr/fg+mudv9XILwZ9vomXyzWGycNJTl+0MW56T2kCBGrjJ+g12TFNqXkM4q1qLOF++qgQI5YVSHoq6W0pu3u+5NtRXOmSzJpr0eW1gHC7LFlfTk44hPp14AFwbciw7zXyFF6NGDSCduu0hrNvwcYjqZ8Kmmd2oeocm/PIez5ZQ+M7EU9Du8lvbaAGQ+DxjPhcnOpAUK+j19V9UCC0fEwa5wdCg0NmxqjKJVcfFA3dWYDWnsvGZLtmj7VaTUiG07A3I6UxreK6ra0eqABbEFgbys9NYjRf0lC0bGbMMb5bz8Hdjbztj2KxHqK/dnOno+30PZ4spDNP+kUbsqcaeA=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(23010399003)(3023799007)(56012099006)(10067099003)(13003099007)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QxZR6zcq4j8CveDnr9nHExQiji+ucRXGUrzL3gjPgDaADJR+gqbIM2VQNFtAxIRWKKGeKuA63N2oK21xEvoEE9BiQzpCKogFs7gvWigUVhp4kjfMT5ZNOu6RktFuzWHY+b005sqFtLgGwHeLLAudbmMCDYnxVBphQzme9DHxdg0pOphPecWNOv35JL/phWVlwOddwkdA+D1zTRVHRznf4nl37uA+R4QmT1iw40I3RmdIxYIzHPHAV/mhTW8aOtUaLYtJix9dh/iA2gbilLq/eecunbTVc93QqJ/b5txBiiXgESxSx8BqEqHhklLTBq3MVuXJ12b1MQpZnWwWzCIEjpAaUmNf4wrph+a8zSNTyZH6q/XE6hZyu1erlORZw2nzNFzHdzIIiy7RVE3Crdmut9hGVPRssO+DmSD9n7eDhh28AJavF00EE6piI92qT/pU
X-Exchange-RoutingPolicyChecked: i3e/ypVAbkVJGyqF/EvNLbN+0OUJedIJeJyBiQMKdVAqWqdZtF429cAAhO/6K5y7BBJtSSn5FLiCwmcA1FNjpMysqVl3rV1bipErAurZLrNsfwWm44uEi1VCHSf7P+c1qx04BZsJ2hGXH1lTr0BJ9nmr/L4pMJ1lpN2rAvmov/MApyKNIH8L/k60zOY8cc7YFoZ6kswoxm85EymI7ih5HfD4r/ApbMU7zr5hU3NZlmXKVVaWM3zubYlpS7jwDQMizIR5M4AevkIEa16xRAwlsKgES4YkQDyBN8LZYK6CLQ9EGQayFg4AqzhNvPABOPWSi9uE2gSD4l5Uo2sujIFuFA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:09:48.1676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83548d7d-3df3-4ff6-3f58-08def1bcb26e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7982
X-Proofpoint-ORIG-GUID: WO1KnpBFMU-20bgXNZ3PrbqL372PVFf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX8v4OO7PJrFw+
 QCLWA9j7wH0bCiwU4RkPbD63Fy12fFErdCjv6X9COLYQUB17+Q9/2wWJwIuVXTmt4xvJqq8kjFr
 /IgPkMHf42+jz0EFl1xP3NS7swjYmTfRIRnZIjPxp8JkyyL5Pxz+RV2dXnM2ggPQblK5nUx909U
 +xlLk8rJdg221b0oWdXTUvS/mR+qzJvzi3NIsEejxX/NLkGxPnXapJk1HOmDDVsg/2iztbJqnB0
 tmqcnVdT5i0D1IiaXHqyvJXQjioaovo8K2BCbxpi4a2aqsli3eYui8V82lytucs2SlKuuyZ3+jv
 huMI83Wa7OAlKkkl8Ksjsj919rXiZy/EuDCfgKBLmrV9olqeMNvkh9xslWcr5GCQ2HOQbxRyxev
 oGYv53eU163DwWifla0EyaycbMZaJnF07N6XEfgs+sV9cHRBOOMxrCNerFVXBGktzQ8bxr0M3NJ
 mxTahaPxInZt8IUUCJA==
X-Authority-Analysis: v=2.4 cv=MbdcfZ/f c=1 sm=1 tr=0 ts=6a712dd0 cx=c_pps
 a=I468VFW1STRMRX/li1H5LA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=k-42gJp3AAAA:8 a=KKAkSRfTAAAA:8
 a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=DfNHnWVPAAAA:8 a=VT4XjZGOAAAA:8
 a=m8ToADvmAAAA:8 a=b3CbU_ItAAAA:8 a=1VxDqnHFAAAA:8 a=S6PgHPCMtElXQeZobLEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=uCSXFHLys93vLW5PjgO_:22 a=cvBusfyB2V15izCimMoJ:22 a=rjTVMONInIDnV1a_A2c_:22
 a=6CpsfURP9XNmmWg3j1mJ:22 a=kCrBFHLFDAq2jDEeoMj9:22 a=Rv2g8BkzVjQTVhhssdqe:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDIxMSBTYWx0ZWRfX8b6EH2NLdFf/
 FrzGif6ZWj+1hMJAPHRe7sjr8Qfld+ie4vD1AIh8L/SnIfyE4uIIg6Bq7U+3jQS4tfg7Zmb2C1/
 vADQ1romJHB9CwJUbD7PzkUr+9gqq+M=
X-Proofpoint-GUID: WO1KnpBFMU-20bgXNZ3PrbqL372PVFf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030211
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=3Pz+KYAwdYSVU
 YdjHjmo+wJgPXXORYM5GCmKMVXW/is=; b=lMijPA7JMuHc1jupDa7Pz8dTOLzuy
 4CGNC71LoysgpDu/agzOlNuKsg84nFGmje4fSGfoi4zdPJ9l3oQ30Hwr8DqDx9vx
 aFNfhaIlnIkHfh8myaPYsQXqJEU5n5B5XZvEna955vMbXEe/4aeFmVMp/9GbdHrQ
 L53osYoOFfjYNz+jyQpdKNva9i7kf1v7HjW19K1lM2w2XPbRVek4aWl3SOhHpdWQ
 E2oiEN38oMkvisvNtqgo4yUZdVhuJ+OpGU65uhO7zsxH8VhVQhb7a+u6mK7DERaT
 JKvDqSv9wXp8nhZd2nVAkF9lEw4RjAQD60fBQ9hK3cweNbOZEtuh3fQDg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pz+KYAwdYSVUYdjHjmo+wJgPXXORYM5GCmKMVXW/is=;
 b=DEcvdruKgpRAe+BbmKTG9WXhV+hXTJ/U899UMjlkJfM8hfikgLvMCaCb3iG80/JR30/2c9XKm2EhHw/mHcOTZQNtBAge4oxX77WEbH6Rh4VLDRL83mHmrdDgFkKy+yzGtJY5PmTE6Uz5JM/3B9jiqpQBhRruXfO0Dj+orKEWJnk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=lMijPA7J; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=DEcvdruK
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

Hello Everyone,

This series adds the initial support TI's AM62L SoC family along with
the AM62L-EVM reference board.

The AM62L is a lite, low power and performance optimized family of
application processors that are built for Linux application development.
AM62L is well suited for a wide range of general-purpose applications
with scalable ARM Cortex-A53 core performance and embedded features such
as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
power management modes, and extensive security options for IP protection
with the built-in security features.

Additionally, the AM62Lx devices includes an extensive set of
peripherals that make it a well-suited for a broad range of industrial
applications while offering intelligent features and optimized power
architecture as well. In addition, the extensive set of peripherals
included in AM62Lx enables system-level connectivity, such as: USB,
MMC/SD, OSPI, CAN-FD and an ADC.

AM62L is a general purpose processor, however some of the applications
well suited for it include: Human Machine Interfaces (HMI), Medical
patient monitoring , Building automation, Smart secure gateways, Smart
Thermostats, EV charging stations, Smart Metering, Solar energy and
more.

Some highlights of AM62L SoC are:

- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
  of two external

- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.

- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
  DPI (24-bit RGB LVCMOS)

- Multiple low power modes support, ex: Deep sleep and Standby

- Support for secure boot, Trusted Execution Environment (TEE) &
  Cryptographic Acceleration

For more information check out our Technical Reference Manual (TRM)
which is located here:

    https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf

Happy Hacking
~Bryan

---
Changes in v3:
- Added TI Copyright
- Used CROSS_COMPILE=$CC64 to align with other board docs
- Extended documentation and testing for ti-secure-rom etype
- Kept warning about which versions of OpenOCD have the tcl scripts
- Corrected TFA reserved memory size
- Removed 'emulated' from the board configuration file
- Capitalized 'Include' in commit message
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com

Changes in v2:
- Coalesced boot parameter table Kconfig address
- Removed signed u-boot fit image to align with older K3 devices
- Removed &smci{} bootph override in the u-boot.dtsi overlay
- Link to v1: https://lore.kernel.org/r/20260717-am62lx-v1-0-b9830633afb8@ti.com

Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>
Cc: Swamil Jain <s-jain1@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Shiva Tripathi <s-tripathi1@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Hrushikesh Salunke <h-salunke@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>
To: u-boot@lists.u-boot-project.org

---
Anshul Dalal (1):
      firmware: scmi: switch to dev_ofnode during bind

Bryan Brattlof (9):
      tools: binman: extend ti_secure_rom to handle op-tee
      soc: add data to identify the am62lx
      boot/Kconfig: disable fit post processing for AM62L
      arm: mach-k3: Add initial am62lx SoC support
      board: ti: am62lx: add initial board files
      configs: am62lx_evm: add initial defconfig
      doc: ti: k3: fix pygments warning parsing device-tree
      doc: board: ti: correct path to tcl scripts
      doc: board: ti: am62lx_evm: add initial docs for the AM62L-EVM

Vignesh Raghavendra (1):
      arm: dts: k3-am62lx: Add binman support

 arch/arm/dts/k3-am62l3-evm-binman.dtsi             | 218 +++++++++
 arch/arm/dts/k3-am62l3-evm-u-boot.dtsi             |  12 +
 arch/arm/mach-k3/Kconfig                           |  38 +-
 arch/arm/mach-k3/Makefile                          |   2 +
 arch/arm/mach-k3/am62lx/Kconfig                    |  23 +
 arch/arm/mach-k3/am62lx/Makefile                   |   7 +
 arch/arm/mach-k3/am62lx/am62l3_fdt.c               |  12 +
 arch/arm/mach-k3/am62lx/am62l3_init.c              |  58 +++
 arch/arm/mach-k3/am62lx/boot.c                     |  83 ++++
 arch/arm/mach-k3/am62lx/schema.yaml                | 427 +++++++++++++++++
 arch/arm/mach-k3/include/mach/am62l_hardware.h     |  48 ++
 arch/arm/mach-k3/include/mach/am62l_spl.h          |  41 ++
 arch/arm/mach-k3/include/mach/hardware.h           |   6 +
 arch/arm/mach-k3/include/mach/spl.h                |   4 +
 board/ti/am62lx/Kconfig                            |  19 +
 board/ti/am62lx/MAINTAINERS                        |   8 +
 board/ti/am62lx/Makefile                           |   7 +
 board/ti/am62lx/am62lx.env                         |   8 +
 board/ti/am62lx/board-cfg.yaml                     |  32 ++
 board/ti/am62lx/evm.c                              |  19 +
 board/ti/am62lx/sec-cfg.yaml                       | 380 +++++++++++++++
 boot/Kconfig                                       |   2 +-
 configs/am62lx_evm_defconfig                       | 139 ++++++
 doc/board/ti/am6254atl_sk.rst                      |   2 +-
 doc/board/ti/am62ax_sk.rst                         |   2 +-
 doc/board/ti/am62dx_evm.rst                        |  11 +-
 doc/board/ti/am62lx_evm.rst                        | 222 +++++++++
 doc/board/ti/am62px_sk.rst                         |  12 +-
 doc/board/ti/am62x_sk.rst                          |   2 +-
 doc/board/ti/am64x_evm.rst                         |  24 +
 doc/board/ti/am65x_evm.rst                         |   2 +-
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg    | 450 ++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg    | 525 +++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg            | 170 +++++++
 doc/board/ti/img/am62lx_tispl.bin.svg              | 222 +++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg             | 143 ++++++
 doc/board/ti/j7200_evm.rst                         |   2 +-
 doc/board/ti/j721e_evm.rst                         |   2 +-
 doc/board/ti/j722s_evm.rst                         |   2 +-
 doc/board/ti/j784s4_evm.rst                        |   2 +-
 doc/board/ti/k3.rst                                |  39 +-
 drivers/firmware/scmi/scmi_agent-uclass.c          |   2 +-
 drivers/soc/soc_ti_k3.c                            |  11 +
 include/configs/am62l3_evm.h                       |  14 +
 tools/binman/btool/openssl.py                      |  11 +-
 tools/binman/etype/ti_secure_rom.py                |  34 +-
 tools/binman/etype/x509_cert.py                    |   4 +
 .../binman/test/vendor/ti_secure_rom_combined.dts  |   1 +
 48 files changed, 3456 insertions(+), 48 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20241025-am62lx-78cce63f43f6

Best regards,
--  
Bryan Brattlof <bb@ti.com>

