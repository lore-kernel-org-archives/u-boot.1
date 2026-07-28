Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CDEC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 08:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1964C408F0;
	Tue, 28 Jul 2026 08:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-KKJj8zOETf; Tue, 28 Jul 2026 08:13:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 336E6408E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785226401;
	bh=jvkCPBEfOAihI04TWhGBxlL6ejOvo5lcr5sC1DRBRl4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n02uDUGoknW7YP8EK1P2phQ4nERRSaYrGKqX7pXrjXyDINLawbTMMBDjbrQQbH9fp
	 0ABi6uEAqqBzJATkDOJfA+SYloT/ULVDyfBn/Dbr9kNf2HkTMJuqONTcVDtjKu7rfM
	 HhW6LD5sX/KSvxKPjLAVCa845Wi9xoirmKs92t1bo+loiU1LOhANkc+sevM6Mxrn9z
	 FkH2D0NBKBeCgyhMEDSfFYPWnziFI3zh92h5aXiiGqs/tS2VGvU+AJPAIEjG9tW12Y
	 NZ76fDUpY941TEuLc5cBalSDkjHdNk7kitO1p6RdK9rbp2I4RdERrLayrCGRh7sIxK
	 i5dgIc7rgx7Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 336E6408E9;
	Tue, 28 Jul 2026 08:13:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A27DE350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 946028129C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUh9tvPkWL8r for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 08:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=m-shah@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2C66881292
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C66881292
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C66881292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 08:13:17 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S80a4O3135561; Tue, 28 Jul 2026 03:13:16 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpkvthg1g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 03:13:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDp9Ng5+GaEf+vCHXHLQRaI7MhhqZqw2r04cd+nlJuC6eMrgCBZ8eIvBbkgQkyLF6A0cSsJwiN0jqQlggFRy2KKWH+NCk4I9O1l99Dx8tlT14ro68G3W8+Y20VCJn1Hv6MzHlOBUUCUo5xt6wDfmbhFXZH2veS74C50I6W/qHW4ILLkpfskqvi5XZbBluEqH0piibYuB3CaU/G/kudCmextgtAL97Ho3Dzka+htc12K4h53nRxbM+z2J/cP0vHkKUrEMQ0+MxBR8MxnR+owISOfycqJOSE0TDxSClbNsHXXxM+7+o6ICiuOX6I25vnYBYoJjX8RO+j9AOTV9HxNKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvkCPBEfOAihI04TWhGBxlL6ejOvo5lcr5sC1DRBRl4=;
 b=kZoKC70apFRbN5AjswsL02lq7hrRpx06dLhFwAYP4B8ALESEx64wf/Cb8py+vGucpi7H0xDNV1Hfd9S2G9195iE0oCGMGNYUfXPp9KckCJ4Rl/0Q66P+ExNP6j/F8MZgt36H+5me66/QvwRK8Xw6dudddXr+PRdAdn4+/uoDatL5jfzptFXVRCLezZW6azvxgzPUflkr/k2v3jV4cHKPT4PYbAt43uhjioy84wFnnJdWc8ewBe+gESES4a6+ZiuKmFUC00U+zZDe+Bv30s9HXJYBxRESJ3I7WExJ7FHXuI7lnsAclG38iGvvtmih+O9q+jqTgvwhxednrBK9kLvahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 08:13:13 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2da:cafe::16) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 08:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 08:13:12 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 03:13:12 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 03:13:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 03:13:12 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S8D89P2892832;
 Tue, 28 Jul 2026 03:13:09 -0500
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>,
 <gehariprasath@ti.com>, <n-francis@ti.com>
Subject: [PATCH] board: ti: j721e: Fix up eMMC OTAP delay for HS200 on SR2.0
Date: Tue, 28 Jul 2026 13:43:07 +0530
Message-ID: <20260728081307.3911823-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR10MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e67f801-8561-494a-a4c9-08deec801194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|6133799003|13003099007|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +MM2RhqVoluILFb0YlpGn3ryYc3y217qBpqtpdPYZE07236TfbxqTc+EQmO8euiLgGZxJ9+QP3NiILFohxTOKRpEhItuc9Rw6JemeTZtpscziaez3JhkhArBCnaro3TIsnkULiCmCHvW2zGUjnWmPlgQrAXdWtMzBSKZkPEgG+9f4SqzNKpF/uiysp9ngr4lQnk+BKYMkP0FjbnvSyEGQN3WzvPigxxOSz3dxMZOX0GiiBjfbQdqMXb4kp/34fEW3kSbd/f/7GjEt4J0hfFbcuxq6P0PuVNyIhuoWUbDI0WXJ+otueT04mO4lhyJrnp4SVkNI7eAekbYEwawkfuiwF+8jYlqBF6Z/NJnWJuNLTQLfmlEZfVEOx2370H+xawTmhkiItiqoDS+Q5yMJOoZ5PsrprfRpQGmaydE8/jfMtm7ZrSUEQDSFrXpH3F+O2ycvwRNC9dGj3oOF9Xrdy6jvOY+Pt4R5pOCmwVpoEdZY3cvQNHf+FDBR0DZco3O8pAeFYiLP9CfLNxFrONZGATbXsipOzbIGUxNwGRB5qAYF1icNaV1Ps5WoPCzbcZZItYgqVxfZ1lj0ICC3ipCRIJbA3iBcjlI8Vi9oTjKt/o8EsOYwaeNG36qNm5TNJfNY75Q5Yp5Xuxo4V26DD3W++B2aLYARbY58XOHW7hyralSteA=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(6133799003)(13003099007)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kZqpNAtx9i92UOvHgP1COXwcq3nfIGmuqoJg/q4zRrYK5mAlkhnoUY3UOPdh1OnZ1qP+tSMykMTvNhSkfBnpp1ve7QveX7Xbk3KchM6HNX9OwipkYzitwwILudFUvXlBTRN4MS6G/LCt7TcAmIBDbkBHE0OPuPJpChcIdV4ZKqt9ztfJ0ULs9exgjA4fah1xsjl7rBAZ++9mExfl67PGkT8w18aOcSEFCSpng3LnRfRcptJv1tGsd0hv4MkOPpd5IMX/WtmJUyxPH9bNoBUJcbm/ritkUKP5dfMlDqOXs1ETBCulnQpZD5WpaCR9lRtWJ7yiiqIVxvm6H3AXVI8HfiuDBZ++K67u95SXB8sCLJY+SSZiWJztXwepw/bB+PSp935M13i0S622ri4rwfV8ocxH0yDmm5sjXVwy9HUyWUhISa/sWMkW0tfj04hE/Wkc
X-Exchange-RoutingPolicyChecked: EaBEw5EguZl4yoe6cpUjlTj8obTJiMzVD6ArD6wzV5JTrI2HfGENp6mk7QjzTDNvHgQo+2+Wav7fcZ76znJ1uFmiP+AFxXhLhUhuIsW/k9Q1zN3hsM+R3Jajp7kP+JW1iV/2dhcQtADpa5LVS6/CQyW3y+zAiIKFlJDDkbMUXA9vBhS0mnuHgJJmZBAt57rAc2GIagT6ilD21Bgxct6HLRHe5QH39Jfza5CyRVrANaPjt2Oc6W8FWjf0Vbcsihz3VMOzwOyEvYmTx0hw4Zg3EvZlReQy3DgiGXMgAGSVkgsRTMQu09iMM4jI0XuNq57pK21lht9yYh0pHn1UqKUKpg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:13:12.6790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e67f801-8561-494a-a4c9-08deec801194
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6379
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX7pCilNlQwGOY
 7lcFjqVUItV3dSaRm9wFLhQhaTGjN9hm9/8ZyBBgdFBLWXGQ8Qad8+UPnbQgDtxGQXFH8399qES
 KQSlQ0hOjpzihnYzMmsMBjI40d9Z9Fw=
X-Proofpoint-ORIG-GUID: V3L7UT_wdLd7PpGsuU-hM_Jon5GvjI_b
X-Authority-Analysis: v=2.4 cv=W88IkxWk c=1 sm=1 tr=0 ts=6a68649c cx=c_pps
 a=1c0oZQ8MA7sDNsoFSDv1iA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=Z7R9Haq8394pxuHmFM0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfXzWpG9qhgS9fB
 NcqwPcpZMyryKvkgLs0zE4VpbAt1aAo+P0PcsE8HRGCX0FcElB19V6C/o6NZ/vol/ey+sS/Br2w
 Guw4LboXCh6D2bYswoW03wvooLuPdCQ6++mDT0I8FX+YvJ57l1Dt/Qe6oh44YZWjdxCzkIcLW1s
 QPk/3VZ7+SEA0DGJ6emDQaAy6Hu7FL1ts+SgCKA003Mirp2Nj3iY1Aj/V8yAKlgikCGd+ezuU+/
 dYV/L5VrewNC6LwAWHOzOQg+imt4bVmUx5/mIPHwtCKwbOeeCZOQqQfoFTeHIbZinlTwSKJ+PNq
 /Xuwz2hjayyJUfdKZJB46NCTZd2fYGojaXutLaecLbUvdkmOwFu/CN/4YLNydeFfX7JlVDBawEX
 67tiW6rQ6ABZPQQRkiVxjtnB0cWeT0xunxHO/pjTVfI2C7yiJBNK/1DozWR9Sp74Yuh8HdfgdRV
 qIXbzQAKqbqC6kCAM9g==
X-Proofpoint-GUID: V3L7UT_wdLd7PpGsuU-hM_Jon5GvjI_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=jvkCPBEfOAihI
 04TWhGBxlL6ejOvo5lcr5sC1DRBRl4=; b=WnpnOy4gwXV48f/MOxIyqBYjuSNNP
 6MPR1yVd+gK8DC5+8mvBc9m8aLYPtczD4C8jinE1iHOAlkBig2yG+U6KsZRP5Cdk
 Y7aaMXUudad/0uI4A91N4Vs1cPUYBwLsobkbIEjpL6JUK8jWKlRVsmXg2Vc2Qr5n
 pwg6ir0RcYkrLOX506/r11YOnu3LpGbqznm/iWe2K1NXNmQcNTj5GChGSeVPcqmO
 DdcrCzpDiRSKWGI7cinqWhTiM/TJMt0hkB64WVFLAgEY1d58yUrE9bB22e0+h9ek
 0VAmAsN4cqggAp2H/Mm1h0F9jayxRImI4Bm5A3XER9TkS5OZgry2MxBHA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvkCPBEfOAihI04TWhGBxlL6ejOvo5lcr5sC1DRBRl4=;
 b=TKTwXFi6G6DySlDR6buv5zVVw/cDwaR4D6wwRkIaIOykD0bHW2R41DWdj9kjJpJmY3EQvWvJ2ZFfP1MdqNhdwnCd8IN1XgiH9pZID4Fut7HDBZVFqIu65oAMN4fbrJu6Jt55sImLj/YHkpjfkjj/oHX65Tu0KvHGLFnwF+JEE64=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=WnpnOy4g; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=TKTwXFi6
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

The J721E SR2.0 silicon revision requires an OTAP delay of 0x8[0] for
eMMC HS200 mode instead of the 0x6 default used by earlier revisions.
Hence, detect the SoC revision at runtime and patch the devicetree
accordingly.

[0] https://www.ti.com/lit/ds/symlink/tda4vm.pdf

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 board/ti/j721e/evm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963..8e8a5362737 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -16,6 +16,7 @@
 #include <asm/gpio.h>
 #include <spl.h>
 #include <dm.h>
+#include <soc.h>
 #include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
@@ -33,6 +34,9 @@
 /* Max number of MAC addresses that are parsed/processed per daughter card */
 #define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
 
+/* eMMC HS200 mode OTAP delay used by the J721E SR2.0 silicon revision */
+#define EMMC_HS200_OTAP_DEL_SR2		0x8
+
 DECLARE_GLOBAL_DATA_PTR;
 
 struct efi_fw_image fw_images[] = {
@@ -125,11 +129,42 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 }
 #endif
 
+static void fixup_emmc_hs200_otap_delay(void *blob)
+{
+	struct udevice *soc;
+	char revision[64];
+	u32 otap_delay = cpu_to_fdt32(EMMC_HS200_OTAP_DEL_SR2);
+	int offset;
+	int ret;
+
+	ret = soc_get(&soc);
+	if (ret) {
+		pr_err("WARNING: can't capture SoC details for OTAP reconfiguration\n");
+		return;
+	}
+
+	ret = soc_get_revision(soc, revision, sizeof(revision));
+	if (ret) {
+		pr_err("WARNING: can't capture SoC revision for OTAP reconfiguration\n");
+		return;
+	}
+
+	if (strcmp(revision, "SR2.0"))
+		return;
+
+	offset = fdt_node_offset_by_compatible(blob, -1, "ti,j721e-sdhci-8bit");
+	ret = fdt_setprop(blob, offset, "ti,otap-del-sel-hs200", &otap_delay,
+			  sizeof(otap_delay));
+	if (ret < 0)
+		pr_err("WARNING: can't reconfigure OTAP delay\n");
+}
+
 #if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
 					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
 void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	detect_enable_hyperflash(spl_image->fdt_addr);
+	fixup_emmc_hs200_otap_delay(spl_image->fdt_addr);
 }
 #endif
 
@@ -137,6 +172,7 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	detect_enable_hyperflash(blob);
+	fixup_emmc_hs200_otap_delay(blob);
 
 	return 0;
 }
-- 
2.34.1

