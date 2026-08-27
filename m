Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D02BC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2316780D66;
	Thu, 27 Aug 2026 07:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDtARsNa7D97; Thu, 27 Aug 2026 07:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816982;
	bh=E0wRKiyhWeD64ymcFihD65s244PVbfgDDsnk4GdBwKE=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TM7KrRsXwIK0ASDRKVaciAWQ/d01a8sHml/UyuvnH2BUlUyxITd44xcMy0qWaKkGD
	 mGCkbu5G7bnec6F3S9aBtwNpf3vBofa7gphIRPH+utyHUvuT0B6pkGSmVJ94SVaWJh
	 fSqNJmze/mi9Og3g+Dgf9Nwmga0biJZc3lzCDImStt0IzzD1K6VJR8NkgCBadRucFS
	 xQJqSScg/Tpd8JxBz8tSmoLVzM/B3YDddxkuRLROSDNqgnDQ07RBospuKSrYHmqjLn
	 BRkTlvvRFXSYBZc1c7Un/RfSCeoIk3/2OWy/xT/0AHwu1tCSjbhLOUsAO3AHo/KPEu
	 kOVN+2CndmzOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AD0580D3F;
	Thu, 27 Aug 2026 07:49:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB37A334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB732406B3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0l6WB7A8moiC for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:49:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=LP3xqw+M; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=kZRPlbwL
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9E8F406B2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:49:39 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R7Jr2421660; Thu, 27 Aug 2026 02:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=E0wRKiyhWeD64ymcFihD65s244PVbfgDDsnk4GdBw
 KE=; b=LP3xqw+Mqtpk3FRY2nDuHwJ4YfovW87aKK9aXRv0JH4ma9cyTKME8Wo7f
 SjBNKpir2s//iW1wcmVrmO3O6Vsn19xPycm4c/sUFp85FZA1wP8OZt1Bgqt5VTHA
 /I4x8H51M7kltrmrDEV8hqkdrzt4iybij+jwHwhZaYJ839rIZ8G88bqpJSBwHYbG
 JuR39AkzEfH8QLyyTZ2E+quslG+6D3XupClDzD0+Qc9VqZQRWRHQIR33bfnrsuNp
 aX4FCLW9HSEVL0zg08GBHLouBgT4toDzmASuC9hmRE/fL4/4mH3EvkFL1/zOgRpH
 mYXK3vtFhwlb6rxdXSuC2RNlci6lg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g9uwa72nb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 02:49:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH9Whm6N11eUclP+qiVdSLXYvVVf979tX3hUG2ZSjZEpCEwVxlf9kX+ZXR72DkGYgxrSnvKPUIOfs71nDnG/pIqIs0BtCNVebhNcO1gNu/rueiLCzRRbK018R/Rq9IJ7Gcz/S6ZnL4XZThKOAcykZOYPWXBqUCmXMkdqCs+qQZB20ACLPjZYWMVxAMueoCMSLXrwZfb2i63btjw/tjFNmy5XhN3J3ccBCUY8242HejWu3d96BP7LOlwWCDpe+sPOsGps+eVrdBFoIMnCYYQCB/vmnnMJgjsk9BlhZCq6YGzYwRohw+RX8PKdQrdDikdz9fSIw2iTizVraX2mGYCRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0wRKiyhWeD64ymcFihD65s244PVbfgDDsnk4GdBwKE=;
 b=qqEhRvb4CstF74OastfzO5upPiiZlfmSgspCloHDNcZ/JDaBGfwqiK+niCu4Gib7FxRiqaQvB8lh3uW1OM4DOZ2+x60Yc63t1CZZ3ywcsNFDhJ1lRZ5hsOLUyCht9FaCX6mFxbyKe+UT7tZSpMHrnnZiOz44cULJ6C9QMOTvyj26jeZp7hrsZHPwvbyOM3I4NWDGlVMXdVhuxL/643wejQQ8crqsOofUTSERfLq2K10l4GzqlkO+2ydLZe4LdSGf0rcQbi4HGPu9+P7c1jTknGrb6e+lzOziDPAUsvajWK7L43t52PvyEcObia4ov6p6p5fI2KVdx6mTz4kQviMkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0wRKiyhWeD64ymcFihD65s244PVbfgDDsnk4GdBwKE=;
 b=kZRPlbwLXKNALWfhfZ2PyEYDl7hjm+g/ZEPoKX9tvIOAZXYPD1fFMdSy3EJe7h8sNtF7aJVA0w8Mq5A0rVch1RlXuudqxKRc91J5mbv3wOs2ZgvZYdr3CbfVhuMO+efOf3j+6iTXjkFJ1UIeS4KLJK7xQGs0veg91G/NVLgp4pQ=
Received: from CY8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:930:4e::27)
 by SJ5PPFACCDEE1A8.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.7; Thu, 27 Aug
 2026 07:49:12 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::9) by CY8PR12CA0020.outlook.office365.com
 (2603:10b6:930:4e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Thu,
 27 Aug 2026 07:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 07:49:10 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:48:40 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 02:48:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 02:48:40 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67R7mdV4420087;
 Thu, 27 Aug 2026 02:48:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 27 Aug 2026 13:18:39 +0530
Message-ID: <DKZK7EJH891Z.2NDLCYZZ1OXF0@ti.com>
CC: <u-boot@lists.u-boot-project.org>, <marek.vasut@mailbox.org>,
 <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <michal.simek@amd.com>, <lukma@denx.de>, <alchark@flipper.net>,
 <jerome.forissier@arm.com>, <dlechner@baylibre.com>,
 <sjg@chromium.org>, Chintan Vankar <c-vankar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code work
From: Anshul Dalal <anshuld@ti.com>
To: Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260824154133.217744-1-anders.roxell@linaro.org>
 <178765097973.1498018.5668901885485543636.b4-review@b4>
 <ao6kAOgauISZ1-dx@monster>
In-Reply-To: <ao6kAOgauISZ1-dx@monster>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ5PPFACCDEE1A8:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c734ebe-9a1f-4ab6-92b4-08df040fae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|7416014|23010399003|82310400026|1800799024|6133799003|10067099003|4143699003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EHekrQeCO0aN8Ae8V7YQijbQPz2k7J70c3onPBBzWYXFG6lm8wfCD0nB0chI4hkp3/EMBcvqeto2V5oj7y/fnXCKGMEgI3jsNo53IEbhRe4zSYW6bjSZmkDQ/oecw4B9n7q4wlcD+fzwqNHEaWzmPhIn9DICSDjPs1Lzv6CjzNtKmwbaa02jTUvVQZnrVWQSKxDkN48mVVN5YC2T47IJ/OVWTjhZUIYZ/Jdi+624u4ERKMJFlfXMFmk4Omhz3g1hkIJq7iWbCrvqta1GNaoq3saTsJdEnEaW9hPt5osiD3XC1H8z9PwU4incYaEraX6Wsa64FWsQ2wHfqLqCfhxCJFgPAQCvObVn7yBdv2PAHyO5l469xWHF4Q2CuvE1sv9VRBnrP8XKyhxKJGJfQkWzT5H/SvNtO090/6dlUc7G9E+to48TBuAQFQk07scLIRsViGfTALjQfgW2DFFaN+MPusJ9cnosBsBnk41fY9+bbd17VN52VZf9/jshb7AozrS1QYERlxoAMf0AZJqhzbSAkLi8VTfLazInhDOuf/9XQHKZ8M1pTmZp3BhGNULFnkRRFS4XiO+juuaETiyg5ho+lCC9TIZ3/LNSxstKMH/3QEwiolmugPuZCMP3VRgKrq/rk+LIh0qS+MigwozYAdbKcv076oWBJLdoKnXO8KjjUcNTjI3b6jrYEwYgy0I1ZZ6ugrDx2o6ToJpBtk6EJ52FAQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(7416014)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(4143699003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eDUBPOmxbzs58A6nbxYD6jlbEvBfXaxth1Bqx8AR+zQWza3CFicWnXaxz3GJQocyd5DMUMZ/iEJZNmC5lm46ZRH7HCtgrYMp0DnhxhoLQM5332HBDhskKT5zDPXsnLAVnQlqM13XMCr8Sl0H8PB2u0tjeJUorvKpBMtn0JOlyTUwUTHIbkqxTgyOMQUjH3gdG1g3lJvh0F2kdow4FrgxeGD9bvNPH0O77x/33d3eO+57y+PBF/rUVpSoYmCXbFgwtqAazDvEiL6qSuG4Rpwp/hAtfnBUMpYuxAuc1jOCRCL5JB6N8E/bViIsTv8CYGpoCx7/3vmfFcZNC/vzjD0YL8f2nR1z9AsGDCUwHpzCiLyI2D8mYqxFOZ4ETu4LIAEQZheA75FLDJlcabIvOt7xdgaB71T1xwn965z8+eXz1FkvStU4Hpt3KRguhLKcpKRg
X-Exchange-RoutingPolicyChecked: UvV82umaJMaFVBOAxHpdHtHYiNIk9XRisqebGwqSWBQvlqRxrQuo3tB9Ugtod1ORuOANP6PJZByhxXBgOQHB03Ubr9jwzumGy8ny1h6mH1gDTJG2z68dvExUd6p6MTkrYuvz37V72ncuxjDgyb9eU2TRb4R4X6nkgp5OOfMXiE7tJa9vhjp3oNuHRHbLCbvckHTLQ6kqmwhG75dkpPYG68YI/Z5Nqqw0wRY+nxx00JRw18ImOTR7tZ+g41Mm7dhOncsR7v9WBQ7AoUAGzX/WP6KJ/+v2YWjiV5hGGo1x+5Hpk3XofTB3TghZIZe0SYuJO8Inqk1ChTjBqLOBD81JZQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:49:10.1868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c734ebe-9a1f-4ab6-92b4-08df040fae29
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFACCDEE1A8
X-Proofpoint-ORIG-GUID: pKWkfgQI6pNiRnFOFaAiBmFw6z9tk-94
X-Authority-Analysis: v=2.4 cv=K5ES2SWI c=1 sm=1 tr=0 ts=6a8febfd cx=c_pps
 a=K+v9EGn/BNkpiusdgAbxhA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=KKAkSRfTAAAA:8 a=JGTDXKEKqPpSmCyMA_gA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MyBTYWx0ZWRfXw0L5mFsP7dLL
 HFFvcRzXf5371P6ZZRAe8YQL06X4ADmXRNc6Qqiv3VqJ3yW+dylqAGJxRtwJkjPye2xHqAP2xH+
 1rfnzbQPUb/eUI84wSJKxNOpgWbZ2n6cgawvojTmb8o6UNd0+LA0IfM3ptVzbhCVQwKWDBbcr1P
 Q6hgSQhTFfKW+BnydYiJXWH8soyx/+6c4BdFHmn5FkH1zFmtB7tVpXLiZlNvItC8QBG4vu1KZN4
 +vrNysprRHqg6RraIA3rvjcn2zw6i1bNUKI5XUkcwqJmYTTxnbi5l+BWUdpCpOKw5wbQNg6+2JO
 WTmG2BhLDgggVWh6UWyb1nthY2ewtO3Ef4YTWrRrjDDiLz7vJ5J5YVPE+UmcX7cIRFuublm77F8
 muAtuNYaoF1cpb0ZMxelDaVc4d897ctcsCS/OXxd6k0tJTDbtXXOxHNGCrHH4FRJenZ/qSfPFbr
 4OAVeEFk03h767DjzBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MyBTYWx0ZWRfX43Ee4MJhW82r
 FZJwQg9KUJHAxoAkUIp6ypJN9stig15IQnOT2+Qj5PIsFGueGLlGdEzzTNtNBMHtyUSbYUUuUMC
 ryGgytpdqUZZPn/amin7DKUcNyvmstM=
X-Proofpoint-GUID: pKWkfgQI6pNiRnFOFaAiBmFw6z9tk-94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270063
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

On Wed Aug 26, 2026 at 1:59 PM IST, Anders Roxell wrote:
> On 2026-08-25 15:12, Anshul Dalal wrote:
>> On Mon, 24 Aug 2026 17:41:09 +0200, Anders Roxell <anders.roxell@linaro.=
org> wrote:
>> > [...]
>> > dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
>> > musb-new and mtu3. 17 boards in total.
>> >=20
>> > DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
>> > Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is buil=
d
>> > tested only.
>>=20
>> Hi Anders,
>>=20
>> Thanks for reworking the series, I was able to get DFU boot to work prop=
erly
>> and the usb devices are being discovered properly too.
>>=20
>> Though I ran into an issue while using ums with your patches as the host=
 isn't
>> able to detect the connected device. With default logs I only see a
>> '\dwc3-generic-peripheral usb@31000000: unknown endpoint event 0'.
>>=20
>> Further debug logs are below on TI's AM62p EVM:
>>=20
>> @    =3D> ums mmc 1
>> @    UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400
>> @    g_dnl_register: g_dnl_driver.name =3D usb_dnl_ums
>> @    g_dnl_bind: gadget: 0x00000000fde7fb68 cdev: 0x00000000fde5cdd0
>> @    usb_add_config: adding config #1 'usb_dnload'/00000000fde83cc0
>> @    g_dnl_do_config: configuration: 0x00000000fde83cc0 composite dev: 0=
x00000000fde5cdd0
>> @    adding 'Mass Storage Function'/00000000fde5c110 to config 'usb_dnlo=
ad'/00000000fde83cc0
>> @    cfg 1/00000000fde83cc0 speeds: high full
>> @    usb_add_config: interface 0 =3D Mass Storage Function/00000000fde5c=
110
>> @    g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
>> @    usb_dnl_ums: ready
>> @    -dwc3-generic-peripheral usb@31000000: unknown endpoint event 0
>> @    |set_config: high speed config #1: usb_dnload
>> @    \non-core control reqa1.fe v0000 i0000 l1
>>=20
>> I observed a similar issue on the beagleplay too. Regards!
>
> Hi Anshul,
>
> I could reproduce it on my BeagleBoard-X15. First I only saw it connect
> and got happy, so I forgot to look for the disk. It never shows up, and
> the host gives up after 20 seconds.
>
> The resync dropped the cache maintenance in dwc3 gadget.c. The
> controller reads a stale trb and nothing moves, that is your "unknown
> endpoint event 0". DFU still worked because it only uses ep0.
>
> With the diff below the disk shows up and 64 MiB reads back correctly.
> It applies on v7.
>
> Can you try ums on AM62p and BeaglePlay? Please let me know how it goes
> before I send the next version.

Thanks for the fix Anders, the block device shows up properly now.
However the 'dwc3-generic-peripheral usb@31000000: unknown endpoint
event 0' error log remains, is this expected?

Regards,
Anshul

>
>
> Cheers,
> Anders
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 028ebd9b9c79..fd0ae9e3e092 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -228,6 +228,10 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struc=
t dwc3_request *req,
>  	dwc3_gadget_del_and_unmap_request(dep, req, status);
>  	req->status =3D DWC3_REQUEST_STATUS_COMPLETED;
> =20
> +	if (req->request.dma && req->request.length)
> +		dwc3_invalidate_cache((uintptr_t)req->request.dma,
> +				      req->request.length);
> +
>  	spin_unlock(&dwc->lock);
>  	usb_gadget_giveback_request(&dep->endpoint, &req->request);
>  	spin_lock(&dwc->lock);
> @@ -1382,9 +1386,12 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>  	 * controller to observe the HWO bit set prematurely.
>  	 * Add a write memory barrier to prevent CPU re-ordering.
>  	 */
> -	// FIXME wmb();
> +	wmb();
>  	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
> =20
> +	dwc3_flush_cache((uintptr_t)dma, trb_length);
> +	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
> +
>  	dwc3_ep_inc_enq(dep);
>  }
> =20
> @@ -3153,6 +3160,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(str=
uct dwc3_ep *dep,
>  {
>  	unsigned int		count;
> =20
> +	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb));
> +
>  	dwc3_ep_inc_deq(dep);
> =20
>  	req->num_trbs--;
> @@ -4181,7 +4190,7 @@ static irqreturn_t dwc3_process_event_buf(struct dw=
c3_event_buffer *evt)
>  	 * Add an explicit write memory barrier to make sure that the update of
>  	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
>  	 */
> -	// FIXME wmb();
> +	wmb();
> =20
>  	if (dwc->imod_interval) {
>  		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);

