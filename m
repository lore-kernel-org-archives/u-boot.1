Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B426C5516F
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 04:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ED8340792;
	Sat,  1 Aug 2026 04:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvfITq9G4iqT; Sat,  1 Aug 2026 04:00:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 344F340775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785556832;
	bh=lZ1Jtz0rRMwLw1Z75KrxiVbSB0KsZ5JJ5MiwK10/JX4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bxXa0znqdT5TXB7yMvP03JCdycyLQXXCtwoymEnpiI8H0kSYkWDCvUz+T7EvR1YKD
	 d6xI1sYc2jzVOoId4xRZRCB9Ci1ze4myKl2MjVGT9Z98KcaFwxXVdwojkIogdGfwSB
	 Ma//hwemPTB3oB7dMbJ1ckpMAxf/NVac3A0J9tnDW2Cg1/89o6PvwxzdTZdcaUF40o
	 cHKxL1ZsXzjSfH8AmIUBrFKsFPUW2/xId8xYEPYURm8Cr75krZ7g2dCuyyQQ0MbT7X
	 /h7AZJcImrTB99+vmnu4FPfO/TXSd4P428Z6B44DrEqAj6aOnBj8jt6/xDd3330qBd
	 g14spWdGj41Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 344F340775;
	Sat,  1 Aug 2026 04:00:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 96A273A6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 882E180D1F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:00:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMq441gGMOIs for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 04:00:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6E06080D18
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E06080D18
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E06080D18
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 04:00:29 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6713QNe91525247; Fri, 31 Jul 2026 23:00:27 -0500
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fs8vsr2ex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 23:00:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSm7u6xkzzZBHPxRhTkqlYqLKBxWYO95fWv8+6IbXl49K+yt2fkCU+McQmygTERXHjtNZLkSQ6nSAoQBTSaHC6CAnS/07EbfBy0ESMP8WlXGjIVkhF5YvLR7TCV9TXLeYzDkZZVn7ABH53etLQiX05BxllLwOkDOMYwMvzPIqyonURvy7GdxtLwpKNqhrOHgbPRwacwcLOdvV2EVmTCI17+kNY1pVKRt/mPGBLDjMWEk6bok3GIF7NlTQGmpWOwZt9hK93CECr1tSZNxaQwwEBRtz8de+e9asYEYz6DQwFbRc3GnbG4e9EdgKXBbc2fjPZ68Poe3dJnwNpp5oJziXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZ1Jtz0rRMwLw1Z75KrxiVbSB0KsZ5JJ5MiwK10/JX4=;
 b=uWX0iPUUkvoZPkIphMgMRaA2q5QRHZP+F99+pbdrhqxRYTtZgD7vn1SG0i8rXt84LcAIpKpuYn2GyN8mswCNBJ3qdQz/dxeeI4TaC9Dad/1438viNjSYV/aD069tnP4ffwmvOPpsf9Hx0EYHtSVTYpKAHRuYg1yUXT9IG9E0mr5clJ70mc8eTIITDi1398lp38WuIMFVidmvAXT5HYpx9ecNSc0M3he3Mq2oP/FB+F2FVZPqUSGvGBCs8BWjskKT16d1DjfKa6vQUuhU4mnOxAgpg2NesqXsPNlKmkrHtBqJ430SNPx0ouCy5+5RrFZjsIPvaNxUh0kp6/pxyFTj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from BLAPR03CA0069.namprd03.prod.outlook.com (2603:10b6:208:329::14)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sat, 1 Aug
 2026 04:00:22 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::37) by BLAPR03CA0069.outlook.office365.com
 (2603:10b6:208:329::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Sat, 1
 Aug 2026 04:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sat, 1 Aug 2026 04:00:21 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 23:00:20 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 23:00:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 31 Jul 2026 23:00:20 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67140HPt1800808;
 Fri, 31 Jul 2026 23:00:18 -0500
Message-ID: <38ab7255-bbbc-49a2-9643-9c2a2127baf7@ti.com>
Date: Sat, 1 Aug 2026 09:30:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: env: ti: k3_dfu: Add condition for sysfw.itb
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <anshuld@ti.com>,
 <gehariprasath@ti.com>, <u-kumar1@ti.com>
References: <20260728062921.97912-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260728062921.97912-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: d186fd44-e82c-4775-dba5-08deef816841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3Uh6Q/nbdeLw9e5TpWDcTzorPDwLDeQPnQq5a0FnmqwZKEJSiCNsxvxNwYaJ6XjLOD3ivteml9Icaa+Wr+V9oz0Aa71t688FlRSIhlIkueXX+zarMoUnIqzl0RzruSFSYv8/t7HK+NDRhsReVSCGPdm49iDdpKpaceO2bUkbWy39ZFR3Dl9dZklmCDoPyarDkyTS70/V902jmzxbmCvsWUv0bN9fpJHkQCH1cvBV3ToVGI7ijyypsUc8NX3uifUi1Wu4wfjwzSFlhsaCMyF7E2YI+022qrC743tdWuPh6637aRMsAMWxyMcKoOqWPwq6NnfT3h05HxNJfFf8WHsU4DMXCDicRlvGOd72MYWbIV/xKuHYamziBtBz3fx/M1hvb8p7Nct1g9hG1auKyafzhc53VLSKwhnMFRQ6NR/Nq2G4eBp9ztq7dwSyRYQ99zs4siY58up03J8FmdmAaZlfR8yZpGOZu55mtGsGK9RsxQ6K4lSYbOoznT2NLFyuVhIAk5cc4Y93w60uBmHbP2jFw/slaHPjI/94VZnqnBBMCpHSkdFwE84ZzuMuYnStm7KR7WjT5sJpKHCvGCWnCdqqbWWlhrCM4xtSvUGvwMOZ+NsxFX7aTCHv6Z0D6FeJFya15ZoIELTewaFLL/2c4aIqg4CEhYVBDlMPGgV/6gXXXRAPDWE/Bvp1DQUL1mC/p1gpWWbspQ8PSgwFiIn14ewsAw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qIYy8f0zno9uvYjOR+AjoY2+oKh0m/pdxYBgElmRq2AswBj8I0SEgafpODO49yGG8pYmVU9phQm2+KAd6lHRJSIs36b6uCIyYr8WF5B44YnhdXOpVPCQAIOOM/lHlnHR+IRhDdhykbo1zPLL6UaVG1CNjTIlAmKmOMa1Gri4jNYy1HZ+jC41i9YG2PDRzHGTRvKbcLjZ1EaH9GogzY/dhGYbhjG7dPDatzd5pUXaLofdIVhVWoTn89mxqyOG5677liC2SHJoBh/q8cOgGMLucSF5vSGNFBwQ65+EPSTg5/XmXt9KIX+SgsZN2mpSrAIwLT5ajGU8TYaILeZFWP7Z7JXH+pDe1SmG3EbhKv4Wvy2JCe6o+/SDuCE6RPmtCeO839xXpifc3jqmYTOb4UJsJeqkRXCiT6+i0XcnW9TDx3QQnw6ALnN7GECC7GV0f+wJ
X-Exchange-RoutingPolicyChecked: se6QOrNJBJeDWAI3B5A6/dgRoe5vSkJIhKeeKTiAYQtEglitn+fPnyMGfjBqn9VxIiqpNTHcjAe0KJrrZJ5OEHTxFYkZGX5zXHi8B+InouM91NZNCCL861fImazkf/wwkLFtrIHWU2Z7N+kQ8M3qtLS5tmG2Vit98jBtVDYE9GCouOqUYodnn6TYdA3epawZABKJ24NWlW0fttQvXya1/8VQk2UQ0hD9F1qi0I4PH927I2LJ81y/8iE0CwfCAvasMYNWyxLF2ZgV8kh9HYl9N7fPnptaMDFu2hCbYIVFFcWXBrOzopGttwUyFTDmGY8uo/vfcUfeH8GDRPTJ32OK1A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 04:00:21.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d186fd44-e82c-4775-dba5-08deef816841
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-ORIG-GUID: A4g2Qy_GDYnYunhALYoJgtOFUNxMqBlQ
X-Proofpoint-GUID: A4g2Qy_GDYnYunhALYoJgtOFUNxMqBlQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDAyMiBTYWx0ZWRfX51lzIDXE/WYF
 XGDITkAurnRch0XdyLcvX/SBmxJ9UyQAF1F/gduDadGh/PoeXDf2uOsGkr5HG1J7lXDd6iPHa5B
 ZqVfnyblP9+3eMk8l5P0C72kaRHAhTI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDAyMiBTYWx0ZWRfX0fNpotuVqLUv
 vIvQi2FxTtXy8uGivbseC9hKI+52WjeEwahID+4BcWj5EfXmi6JN5BfNS1paw2FVaRftc23FSgk
 PZHBsE0DpuOAiUJ2W0KNU+RCCFjAXI65n+lf/7XSPo+gle6VGiCVxJxVIrlTXI2BbFHI4Qi4GuW
 9zh4gM0ky9OLUQLGnNTqtP85OsRn2mJs9oypM9K44L5gm5mfCOAkQBanUhZTs6WGXeUV0AZe7YO
 cq3gG3mRBJuNzAMf428OoJt8tSSRtO8yRCeX4CcrFHbKllkWsl/G3mkEM4GZFshsPrj0dIu+vDe
 ED2Oq/aX6vIzzH4CArX4VuXR0DKlcdHnVcwCJJe5kN78dg9a4Yv5lmDY5xUNutNhkjEE4zgPueP
 UdUteDeyxqJBLFROp6dkGCcPN7eZkEZGjLoA91oJNcCho58Dzz2crc3ipqdKcjYcxK7pd+s2mn7
 OrRV058d5XUJWhSrKKA==
X-Authority-Analysis: v=2.4 cv=bJkm5v+Z c=1 sm=1 tr=0 ts=6a6d6f5b cx=c_pps
 a=TLqzh4Vj95vWg92rYJ0Jsw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=wvBcNzyKp9oIxKCtEkoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010022
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=lZ1Jtz0rRMwLw1Z75KrxiVbSB0KsZ5JJ5MiwK10/J
 X4=; b=clbXh7U5kPOZSOKwABDejgVNQ8eX7eZTyFZ2v3co4b3YJPpo+IfSsNf4c
 xA0wvqpefdr4wJE01+8rTBBle+80aM32e2CiC+sbcjSjgzOkEp2fB+mT+GPT0XCv
 /LIINRV67yR7tL4QvPQrQ/8yPGFbwTY3A9dIOGHu6FrNT4b2ROmtR4gG24422M6b
 zyU6adSanwSu8T2gAeln9jnmSi4s3PJBYU0TMpIpz6IlRrxLIGG6OxPK8NbkfRkh
 eI9ixM+ktNoxUXL8SlTJaMWa/7sOEr+gz02duKZb2OWsugimNGUwsx0e8F5DNW5f
 K2PXgpCbHjZpEudYTvMQ2ULooHYzQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZ1Jtz0rRMwLw1Z75KrxiVbSB0KsZ5JJ5MiwK10/JX4=;
 b=Ief5BzTN1lDNZo01q/IVlHzF9oPbqZcLpf92HOJG2bPAjJ9hkqPOC90S2CU1ZOdRANxvB90TVWH00Br0E080PU8pFOUyc3iWA2AE5mz3b2fD5csztulfVzV6O6dAJl8oMVwqKaEgqqNs4Egd3EnnqVO9fIN9c7+ESXQ1nGZFI54=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=clbXh7U5; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Ief5BzTN
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



On 7/28/2026 11:59 AM, Neha Malcom Francis wrote:
> sysfw.itb is not part of the boot flow for all K3 devices except a
> couple. 

Suggestion, instead of couple,  think of mentioning name of devices

Conditionally include them as part of the list of DFU raw
> offsets and fat arguments.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Tested on J721E-EVM (uses sysfw.itb) and J721S2-EVM (does not use sysfw.itb)

Link of test logs please
> 
>  include/env/ti/k3_dfu.env | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/env/ti/k3_dfu.env b/include/env/ti/k3_dfu.env
> index b42cf21d986..f0b68283723 100644
> --- a/include/env/ti/k3_dfu.env
> +++ b/include/env/ti/k3_dfu.env
> @@ -5,7 +5,9 @@ dfu_alt_info_mmc=
>  	tispl.bin fat 1 1;
>  	u-boot.img fat 1 1;
>  	uEnv.txt fat 1 1;
> +#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
>  	sysfw.itb fat 1 1
> +#endif
>  
>  dfu_alt_info_emmc=
>  	rawemmc raw 0 0x800000 mmcpart 1;
> @@ -14,14 +16,18 @@ dfu_alt_info_emmc=
>  	tispl.bin.raw raw 0x400 0x1000 mmcpart 1;
>  	u-boot.img.raw raw 0x1400 0x2000 mmcpart 1;
>  	u-env.raw raw 0x3400 0x100 mmcpart 1;
> +#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
>  	sysfw.itb.raw raw 0x3600 0x800 mmcpart 1
> +#endif
>  
>  dfu_alt_info_ospi=
>  	tiboot3.bin raw 0x0 0x080000;
>  	tispl.bin raw 0x080000 0x200000;
>  	u-boot.img raw 0x280000 0x400000;
>  	u-boot-env raw 0x680000 0x020000;
> +#if defined(CONFIG_SOC_K3_J721E) || defined(CONFIG_SOC_K3_AM654)
>  	sysfw.itb raw 0x6c0000 0x100000;
> +#endif
>  	rootfs raw 0x800000 0x3800000
>  
>  dfu_alt_info_ram=

