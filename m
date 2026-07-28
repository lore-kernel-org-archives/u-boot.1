Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B185C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 06:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6751260826;
	Tue, 28 Jul 2026 06:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jCDh3OznmoXK; Tue, 28 Jul 2026 06:29:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF8546081B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785220174;
	bh=z5C3jnE55gX7hQgCVvCb3hV+zFlgRtuI9gK+3pHs0lQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sjusNeWR8iBQzGA/szNb9ZUffluuyNTm2MHsnx2LQ5off4B1qdpSN0KveNo1ZFVVY
	 KqFz9iKHh9KiDQZpdeRIIB8wunEmFM93HLACqMxu5BQxPJv5ZWC9YBMzt/lakd/AWD
	 owaunjHhygF+I0YGBbo4uIpFLgq3kMZ74wcGHevvzvzy141mhYFYESoUVa0rluqr4i
	 yMzfYf1U+AIOL16ehehdee2ToFEU/Ucz8P0cfBXqJisiMKca4IuIUN3FrANssq2/NL
	 NggB3JHPjti0ZPxA6lPRsYLfdqKzqFfelRhC4TH2O27AqLzlAfoLrBRK21z/xVLL6a
	 PKK7oDCAzNSKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF8546081B;
	Tue, 28 Jul 2026 06:29:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7754836E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6940940882
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rhqFmO1TH8uk for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:29:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5C7E940880
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C7E940880
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C7E940880
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:29:31 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3Z1qu2916385; Tue, 28 Jul 2026 01:29:30 -0500
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpj0a1mg9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 01:29:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1CB1yB5A9QzcGWy64FOx9HtdqlcGwbIPDxcHlbkeHPBGJdq8y6QvfCaSZB1oadSEnVhNF9es5iWSH5Ok0OgvvLMv1kZp37QXLxoxl2pX6AHWU10nBz1E11RVznB7iDQ9vMvNQhJkee4Z9TmS7cX7G2hgUTE7qpkZqu/oEMg3mQ0pAO/rOTwqLudnFtPKonCTkSB7fpN+l5X2LC3S4bUZN1gkg7F3KCzJPWqz2iSwfhq4lK1s6rSvlksZacghkAAjsunhe30WaVXEDKlKLPbYBF/DusXuVQGdLFIzWUr7mMinCgV71pyD2p5HhN+CSMcCfejxsmKLxVpSkzEUvF34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5C3jnE55gX7hQgCVvCb3hV+zFlgRtuI9gK+3pHs0lQ=;
 b=BNr6Xj5sQvPetHFdLvVscExZecqgTJ/lUftD6KcEsSriudGfqXMngc8XvpjtcgU5tgtGdf15uG/PhcBhZHSWKhrtlINXMdG1c8xsD35reAWRedpzA0Fw+idoPPzkyh6As9Kopps4m5MA3ah9xxMZRu8WZ/xhUr6KifTgaDJvKGd6GG2BeMLyzdSCVss4SdWzCyybbDTU027wKmsuk70uTMoiN0NVkN8ECYN+Iry2INA3CLb3M+K4nqINwYPjLj3/amvNPL+opGjDG2o+/2IFXPeyzok2PLDmZZvtk4N0vHUWSRUygy0PbamwA3Y5mL8W4yneT8XbYLUXkGWEZKmRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from PH7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::27)
 by LV0PR10MB997615.namprd10.prod.outlook.com (2603:10b6:408:340::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 06:29:27 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::66) by PH7P222CA0022.outlook.office365.com
 (2603:10b6:510:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 06:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 06:29:25 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 01:29:24 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 01:29:24 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 01:29:24 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S6TL5Z2725975;
 Tue, 28 Jul 2026 01:29:22 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <anshuld@ti.com>,
 <gehariprasath@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] include: env: ti: k3_dfu: Add condition for sysfw.itb
Date: Tue, 28 Jul 2026 11:59:21 +0530
Message-ID: <20260728062921.97912-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV0PR10MB997615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5764d8-84f5-4563-cb7f-08deec7191de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2Wo9HXH9ue1Z7aGV7vj66EzHk+qCQdhDWNSj/mAp8WKBf7/3mbQk4U9W1TPlgnuh+EzPGURJO89oZjBYeVPBYNd6Sbr/Fvdwsox68mzBof4HkCRqpl6N/Nf4PmSDuWbXLnhx4sTwKw92Kf/YHMpO6UJ55DiBwtzXjgpx5cAyqnQe4ekZKJmIqEp0d9jpWWAtujLqWCDIZm9sRfGpjLfPboHQW24PyETjWrz88Wun8eoI9+HSPbjNSx8kNw5vDxfnkd+wdHlJLNEacm0dTt3mIvY/JrbeKKMe/iGKr65gaUa+yxDvfQDGsmDstUTh3xiVo7DiyrIGjve6aIWi2H7ex5lNyho5zGAmEZCNLb9u76QtOPK3SZlKzHqh87uq75f/YXLG6K0UYErvmumM7QjnvM+TJBs5jR0mxqJIIIT480/Kg3/FkydJAXMALubifoGCoS0fKcZ9PrkxHVhACEBN208ENH+YpAYUHh4tLJ/sCfAubuFs7+YwVNneB2kfMe0W+ARlfQGCeDIlNl12FslFCcKgPT96olJJeku8EwhfmkzxAeVpmBn6VY5enmpl8VBbZ0RsOusYwT55u+d/kfxnQOx2MhqncvTtioMsDGbRM/h7zxxWxjLxWsao+lURNF2VPKsTCx4dGVaX+sdQkZATVXsRtkrV05RlFAmDXCVhlTcOe1jeJ+2DvWbhAR8SGmGLQ8N3rYI+2B7n73Irl0ESdw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p8zsLB/8Jn5JoHeC8ZmVqwOuJnpclSZ1CHKdfDX93/hkEcNvqiTvLTbygEIhe5M62p/pzS6LimMGg7FwTmtu8wQYGofc0qXOlw2W7+ZWBwAMETITFRJlg879l4XmntTtcBV/vSagl6dyP75/RkZjS8HzsgOSY6g8qSQDwST5m+BKdvAsoW2KsGN/w09ZGAqrY0J5YCcAlPTj5F4SmuppwdOxeN3jQyXhKBLbiMPlKn+5kcEW55cLo+P3JSPxI9hxzaijFroPj4CvbpnzW4mJyVewKJh7RwbZWMqIXGYNaWl5F7DqK7jc1qD9S6XGq8yrXfrp9N+aEYar3ivflkqOt3wuW7noSJgo6davE3cZxPbpSHVya8dVfTjU2ycItyNoFTZjzwLV63yOEQWz69IibfoCUo4aK6j2mIkLK+jBhPAwgjRwjy9u9L4kjCVjUzLA
X-Exchange-RoutingPolicyChecked: jc72zSvugJczhtUxuPQXJLBTxcFY8/q9Gtiwvi5BnMLcv3tSbKBF6hkyT9CzdxqGqjsWVPBA7ANUihK/ESJqyN10f1/W1u0FnwwDtFNSpJKjFQ8xuJHaH1iaWur/A9RFynFJw5XxniUlkB+5pVUfhy6BHiad8Q6RxaZT+MJs2W60qdC32rTq5HGvG0f8t3Gdv1ItlRLGADRj0CPpDB9LMrWgOEgn8gJHvHqa6ywMZZ4I4ck3atlDzc6MrUbeE5H9fPnAZyOP+0cY7q58aSajoQVttuyXXXzyEVyME/Gl6d8vP3bf1E3kpF4xUrKjxtnpatlpo+NY/MpguDcXMBkyPg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 06:29:25.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5764d8-84f5-4563-cb7f-08deec7191de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997615
X-Proofpoint-ORIG-GUID: WDi7wwON1PX8kbopyo8hD2e6AbgFV-dn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1OCBTYWx0ZWRfX7my9q8gvMI5C
 5U8CfQ1RmnjdoErMJTKGALzOpLowreLbaPsv9FRYWrw+C2LBC1p8Cq8zeqm5Rgag923h+qJ3koA
 L6lFzdPo1ygDvITEgRyX1O4DJPH2Ht7mgw5RmtjU4OiANn3htauLIiQ/URDJPceHa8QTlDs4Wgc
 vUy7eAObWiKmVbklMismwVjU0mX5n4OIMHC/pSUKiuRKpZyYiqko9BuuhyOk8YS7I2ehma5a/75
 zfcmr5rwezQq/LgRHZI3DnWbxJem0h6t5iqXbzbTO9A1PKTU3oNi/njmj08ZQ+55qB14eZRcUNE
 ePZZyycZi1j9T9NA1mactEy6aldZ8Ou3Y0Vp/XOFp21MEEA/kgBickwVmhn+QkuA5X6uH6905+g
 BtHxsmt36G108PnwRURXYdXE9exFSp4ECrCq9P5h8RBYdcnx1eCbqzJ+YQyfOfwPZ8gDBSGB7XU
 EhiAhtdBUpaku7uw0yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1OCBTYWx0ZWRfX3/5nKGKfWjHm
 WyGu84YqPg8d0XBJZGitela05dFcWLeRd7cNeCiKtoFJc4Kgw+2rwzVaZg1SSbgm4ieh4gxLOp4
 vRo0lXOEixDflO3btOFnMas/N1WO+OY=
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=6a684c49 cx=c_pps
 a=F9MFHRSrL/QBKEkL9+MzCA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=agyV0T5uEQBLG0eEqJ8A:9
X-Proofpoint-GUID: WDi7wwON1PX8kbopyo8hD2e6AbgFV-dn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280058
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=z5C3jnE55gX7h
 QgCVvCb3hV+zFlgRtuI9gK+3pHs0lQ=; b=Ta+zspxxauGTzA47N5hukcI+iPTz8
 SyFkPhgSX/HYahUBXmJjKhKMfRGmzi+vJL7AjiG+aS2a3AQhQGXwzQZ7pzozZwB1
 VuW3wnqL9SXcdmTp5ln0+2QyDkTqL8OmAcA0RJnS4j1jPLMx7kSaHSsdVH/V+sBt
 C8u9V6B0DQV7+mtQwuFtQTjS7olGtBMqyitaJBQM3ghC6q3SVcqAEanRA8B5XGib
 0lfWsiKNW4Lkdyu5gtUZwt6k5chB0tdV16WXoNzhqorQsBUd+Q5OvpQGePA4P8Yc
 OATBKKSvHjYhddJiONhwUUaekpjlgqvXZQJ/kqDVJERCrE+YFlsX7c2pw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5C3jnE55gX7hQgCVvCb3hV+zFlgRtuI9gK+3pHs0lQ=;
 b=xS16G533tIRgJ9bTVRoKEO7RiXZV1Gom3cuj/3UaMJTEnkAbdWBqyee8OyXcM4xqIBho9nyVmSc8IN9PKetLYKz4GSUyfjQfPo8JfNLwmlk8HafddKhTiDj1QCOpg5WvU9Pv/L1mUANzphtpU12j+Q4sEsccOadsJv6i3YrWZDg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ta+zspxx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=xS16G533
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

sysfw.itb is not part of the boot flow for all K3 devices except a
couple. Conditionally include them as part of the list of DFU raw
offsets and fat arguments.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Tested on J721E-EVM (uses sysfw.itb) and J721S2-EVM (does not use sysfw.itb)

 include/env/ti/k3_dfu.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/env/ti/k3_dfu.env b/include/env/ti/k3_dfu.env
index b42cf21d986..f0b68283723 100644
--- a/include/env/ti/k3_dfu.env
+++ b/include/env/ti/k3_dfu.env
@@ -5,7 +5,9 @@ dfu_alt_info_mmc=
 	tispl.bin fat 1 1;
 	u-boot.img fat 1 1;
 	uEnv.txt fat 1 1;
+#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
 	sysfw.itb fat 1 1
+#endif
 
 dfu_alt_info_emmc=
 	rawemmc raw 0 0x800000 mmcpart 1;
@@ -14,14 +16,18 @@ dfu_alt_info_emmc=
 	tispl.bin.raw raw 0x400 0x1000 mmcpart 1;
 	u-boot.img.raw raw 0x1400 0x2000 mmcpart 1;
 	u-env.raw raw 0x3400 0x100 mmcpart 1;
+#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
 	sysfw.itb.raw raw 0x3600 0x800 mmcpart 1
+#endif
 
 dfu_alt_info_ospi=
 	tiboot3.bin raw 0x0 0x080000;
 	tispl.bin raw 0x080000 0x200000;
 	u-boot.img raw 0x280000 0x400000;
 	u-boot-env raw 0x680000 0x020000;
+#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
 	sysfw.itb raw 0x6c0000 0x100000;
+#endif
 	rootfs raw 0x800000 0x3800000
 
 dfu_alt_info_ram=
-- 
2.34.1

