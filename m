Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61ADC44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 183C4409BB;
	Thu, 23 Jul 2026 00:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5sV41_H8VZyy; Thu, 23 Jul 2026 00:49:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C681D409A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767764;
	bh=7sXAfLNR7S5vLVMaq5l0nk13u7RT3Adek5TpyDilLWE=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Iav/pTqU66O+aWqq/xhKW8GRXxDv07OH3qPeL/FNTNluW/UtZf9CmdQZfFYpK7mTw
	 sRjiA4vzludsSH6bRRlq/j3Vq5uI9/TsnLahle/6vbGMR5vLHE9r9t6Ip3oD4Weqm4
	 ZHBX4cJvbhiJ43zqyoFQ5llJXXM462zp62zDXXEEp7/+zJ2OCIet1OK22e5X5mMgyp
	 b5LfL8o4KpghUOu5XxitRo1GehSwD1v3TVpObPC8glmrDZigbu2lcr2D/FDSNmSzwz
	 1AO2wPnAP0ybQYXdF0X6U7PDM12EN1EjfZcX4VqrbpMASWc3DDu2JwVC71zo4Z7BQ/
	 2nU2RbZRY6z1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C681D409A0;
	Thu, 23 Jul 2026 00:49:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AB52EB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8099F6077D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBC4ufG3lF6x for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 00:49:19 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dmukhin@ford.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC31D60770
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC31D60770
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC31D60770
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 00:49:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4035C8494B; Thu, 23 Jul 2026 02:49:05 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A54E8404D
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 02:49:01 +0200 (CEST)
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0Y3483705469
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:48:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010021.outbound.protection.outlook.com
 [40.93.198.21])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4fk5ycgxm4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 00:48:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwpHzKTz+GsSxT0v/JQ3ywluiGlo7tCrSnJw8OsFfQ6qjVZewySbvSUnWK1iROHF7utpEvjquCmH61sWOYTgQ4zj3h0R6SPLiufbFKuW+32JrCqZB1z20bwhQdiMipntvJpAQfVc9wUiITgapf+Uc1RjIfzDUUl06sKgmLTv2FPaveH11xwwvzFqNupvAoYKN1dlFJqZED35IaTDR4Z6PWVfyMlw7IcXCjVBiPSGPMukgcbTOT++NYXvDWAMLnMk5nDh/DYvUyTa3sUFOO05zCqYqsADbNVVSB4GHAY5T8TW33YFfqnAS2x5glOXcJgBx2qrRYVe9ClZQAZwpxmuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sXAfLNR7S5vLVMaq5l0nk13u7RT3Adek5TpyDilLWE=;
 b=GzD2z/bTW0fDaAAlBIOb+KXOvw2t1iAAF5U+o8Vr/AoI5lVGKNvdbUqgEB+qoOvqiEV6LfKgARy9G2bX2GXf2MwbuTUsPoS2bDjz3HYNOBRLw1f/w5+dnbR/QuxpW90/o9gCY0GArCM4Ut3b4UJVycnaJWNZH8uENCZpdAv1NG612F1C4Iezk5FvawO7FFIcnvsjuGLG44uAoqiQvBB8Z7g/rDLcNxDdIkTPh4vhtBYBTxlQUGgL9Axa0Us/ZtoIsoPMIYH3dhK7fOUKxYCBrS3Jd1PINZEK1rtFbFIXg4iNxLPYVbPIXG+y8nY67vWtxgJG582p/CM6fsX2bmbqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
Received: from MW4PR03CA0128.namprd03.prod.outlook.com (2603:10b6:303:8c::13)
 by LV3PR16MB6317.namprd16.prod.outlook.com (2603:10b6:408:1d5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 00:48:56 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::a5) by MW4PR03CA0128.outlook.office365.com
 (2603:10b6:303:8c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 00:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Thu, 23 Jul 2026 00:48:55 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N0WlwW2848989
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:48:54 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fgucpmqys-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:48:54 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id mhcKwfOvEVWzXmhcLwMgCH; Thu, 23 Jul 2026 00:48:54 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: mhcKwfOvEVWzXmhcLwMgCH
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Wed, 22 Jul 2026 17:48:52 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v1] x86: add support for CONFIG_REMAKE_ELF
Message-ID: <amFk9Fy+c5fZHZ2L@kraken>
References: <20260716205213.340109-2-dmukhin@ford.com>
 <CAFLszTgTACNfa+_LnLGvivq+vr1fjz9-c=Phfxe2Kgb4mLHh3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgTACNfa+_LnLGvivq+vr1fjz9-c=Phfxe2Kgb4mLHh3A@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230003
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|LV3PR16MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b849d82-3e4e-4b6c-9cb1-08dee8542c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|3023799007|10067099003|4143699003|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BylvuUY85+g1RZvEVxpMLqJ4g0VvxOhoolZq+ypvXAsf47+MBobqS85zVmrmL7GGULZnnTFqHek3jImaD9VCME5dmICKQyE+1/eNpzKHqLWb5XaqU9QyUGgWjhtCEjwkma02BUIyn5YlgKiGwhfQmQeV8e6j5oMPaWx+GnmFPPPy6iJzDCiqi/Fg1S/jl+nSuY9YIBPb/JuPsaqEYrv1goP/lPcPmI9gkWN8J+Bv7kD2XUYTURKdZ3nnRXOiJ/mWJVr57tz5WQwz43vWj7ofAZOQiiU34F/t2ZrC5S+dft+t7qxOjte+rZpQJ67IyckWuXQW4tsZ4j4u6DrbqoyGQQG+L8t5wa6vaSEq97SP8QitDq7aO6YFhuCJlx2g8txceFqr2UMYOakDugdoNcObfrQhyuXTaTqHGmt8AJqOR8q9LP6VfM0qCUJcpiNKvmbAS/jzYTAM2b6pYzfI8aoz/0nmps0hh+r3pJZp2oB0ZyPRDl9nQnxaGzKJCrV8f4FhEKxrPhbvtSFZcq6TCnCdjse96ikzWnBQkUvkpaUJoDHSEDIImQJltjCzaaCG/Wtkfmt4wG9pOWzep4Lk6fjmOzZ7XQlD5gglylUSV7FsCJbky40QccncoE1F+bnS+7FAW7TqU3/KYLNs0nyqT76p4vzjRsCAmn68GaaLQAOIMlt3BZi243XuAKp30+ahQQ1JsWQNohm1S7YWkMPR7fo9SA==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(3023799007)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CrnxzKf0Uhe3BeGvtyMUN3cC3HhTjpUAdnezLBBer8kYiePsjZq2qzpkr4T8fcPlDZqOnszS/G3JM62p6GWt7zK+7zpyNJieD6iiXU58Y/ex9zbF1ho4DDCMvokJJg/mfS+x1fZRtDLGlQGvHUKCrdIykdvJaoqzWXXAXboIESGDC8dcOsw1RnI4s9Ruq5aGFtUX2rprMuaTHNJl/UUdeKEKygSNI9UJFL0tEzkam/9wofnTfLVnRXLZJoDV0AioQB1i+4qtwHhP0L0LzhmvGWAoCp5X0WVEZu+F9vUB3FIdsWL41EDRPw9k52zjX8Uwww1PGGAxbQLG5A/HpUXQlCo47avfrL3NE/YhzfOi1AOUPgH4sw5SYV8rvzLDwR1YwEvUYMS5L+5EC+G+eaZFa/c2q3cwXdQHdsBEaGV4jegI8jUDFFOwNkxHxs8+0uET
X-Exchange-RoutingPolicyChecked: sABpsdwZyoumoGWTYxp47Y4yys7AYX5+RhyLOskpU2GqeY1Wljy63GYuDP2u64bxaTn80czx8K14wL5LjW9TYHUVwE74W7iQ83dlmDwPjMRWeRZBWl+QGgUpY0Z76GvyBGGimSbcoFbN90h63Wj2w2qhC0EHETu6nfuBsRNiMcooNHsbF67cQL9MEFRiezPUa9U/A7HtzgyT9UbcoXJYxkV7BOuD3dhUK9a3UZxZ+aC6ZZBBEghyUe3NWRjfdUyzYYes2DaKeKPlTHSAIqwYxon1VhcxQJH2l/075BjPp/f47jCUS15Fbxh1Je5fajp72ppMtbkKa5TRVDKGp4EQ2Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7wEepc3+KTlgYSlxWWNlDvvzk2R/NT0G8Hx1C8bWCsDqeIf+IUTD0kediasrVDGgojSwy7HwKd962imCK/dmP0L/EJnNHReElsd/B6ncT3HqwFnBI3dZlsp063c8oonFpvjbWQJu5joAbdPHFrULWzObo+kw3iQFhhQoOzM5kYOQVBGvxVRGg4Q46cyoyj2Vq9Ma34G28FfamTrQsoqGHa+Gw31m4lsInuTzFYo//qq07vNMJ8QCQQgwugVMwxBlcnq+aAXZuWgFfrOljU6AKUC78wxTllgo0S8PWmHTDZlEUn8fhj2jAvfLk7VC1rjYSAbmrDkrPUWrSXQsQLblFiWYPtdB99Ruiqw4SQFtAdH+JHLwiqcU4k9h9Ox0s5G7V6k7/TU8a/jHfcBt3a9UB9c/301hbHW6+L2GBGPLY4NRkVc1ugX9Wo6EpbWtJU3ko1TJu1ygI1Gop7pmADCPth6E/ZOeI6MxpneAGLJA1hniQL8owXakEOY8cKrWcg5Ig/XoGYG+qe2OM/ObvVF58DtSiBH4ttex872HAfl5kxJXcXpFS0Lti1cwNahj8nYGn9sgkT7YY5xYQ2QDiBKg/IMb9fXTZFQgRRAYbCQl4a9BoZhIULBylXkHZvW5JtOAxAbS2AMeK4YILgPVIbVEnQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 00:48:55.3707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b849d82-3e4e-4b6c-9cb1-08dee8542c9c
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR16MB6317
X-Proofpoint-ORIG-GUID: 42lJ8F8e8BeTTHBaUlomIJ7p1zAls7Vq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAwNSBTYWx0ZWRfX8klPuEq2K+Ec
 AP9g6/W+S3e/KzFANurLASguB/+685tQ+LsjOAOBEZRjf+LpyRwNIq7pAHqmIYlwIykncwfQ/Zd
 srWD2NP+Uuj5ldBzioXKUzU/LWx60R5HWPBuB2Gu6EiAt+5sXUf0qQ0gD0VYRNS8HB0qepx4aHS
 NVOpzbfSrHnmZ65UAoGUFMV3y3tEtiEfthnOMfc9aw+49253SRTE5ihRrd4OnMQQxImyKuUeDzR
 4hmgyV7kawBG7P7XjZQPIHoXY2Ikdath/BjCcRZMFiehixCdsHVGeqtOuDBClbF545XDbAAoei9
 LB9m2v7rdHxryezUWREyeGCabfh6s3x0nElZjgriYievFfJMK0faWgf7wZDf6J1MQwrU0XTtx8Q
 XSqi1uMGGEbVq72/YXyuGHGcTwTbF/Eq/el7VAJfeFMHcu2uJULmtplYSucJfSI4dD0SeUjfpvp
 O9UfbNcNeeYH0qgF+3Q==
X-Authority-Analysis: v=2.4 cv=Uc9hjqSN c=1 sm=1 tr=0 ts=6a6164fb cx=c_pps
 a=4YE3MzgntgO4dypjGrF/tw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22
 a=cbNQJ9GKAAAA:8 a=GDEvjTGLzTAHxSBqPYwA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAwNSBTYWx0ZWRfXx6u/KpuTLMG3
 p8/njyO9lng2vXR/uwW6hcLIPnvGWjGuzfQdWt3HPrbIcth8JLL57vZtILT8wxd8DgeGMHRS5QY
 i+sYg7ZzmJ8hctmSCAeuLTxEpJB7quawZyUe6XmVaeMcNdomxiEl
X-Proofpoint-GUID: 42lJ8F8e8BeTTHBaUlomIJ7p1zAls7Vq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230005
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=7sXAfLNR7S5vLVMaq5l0nk13u7R
 T3Adek5TpyDilLWE=; b=W9LNwOlxo9d39RjijCrTHw2nLFmgEs3OwyEaOeMbp2x
 fAFBMsHqZnSk65rQ1wb0PLoDVlOz95yX3zRjWIxBD8CSibRaD6awq0MbqMs1XRCN
 KcNecr8+/su2FYHqYppjvxtL/YG/EJzKkvq0dYAdOml0mvLdHHwee9ms2xrI8gR5
 I33nJTOi1skd5Qq/Dv8nFeoa/7XJ5yQQOcIw26M2vkB7kv5Vxw+YEhgaWz9a1H05
 dr+uZsmpBiHGIjPk+1Eq9QT/gPW/2L5X83Ae9jg/Jy0MoVQyRgEDfE9NqPc02tWp
 5c77+pGNSZiZvAk2fSSslCvMCEUTXV5aeXewXaib92Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sXAfLNR7S5vLVMaq5l0nk13u7RT3Adek5TpyDilLWE=;
 b=GAaGBNvWGORkEgCwkP2FSudam/lf6NfqGKDpJ5uqYBgVoRhwllx8DOMh5dWKBTyjMCy+W36+PAfem2THiRG2FibVSmXNVHohSGzqDgXwabZczUYzcEPK7qJ6l6WvdXms7X1FOfA56WPYIDos8lYUKlvVp6avlnF0mkiaSjo8PJA=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=7sXAfLNR7S5vLVMaq5l0nk13u7RT3Adek5TpyDilLWE=; b=Gma3G28NJ4KR
 a2xi7ApYNHuke5RcHYuB3tFs39nMq01u8AgoQOdbRGq/QA2JTDUU5/IK1/ijTS7/
 qLWnRbzOawIPsfGGr3I/4mU50Dbark4K4/Pk8g7yv/Xq08NtIzRL/EYEsxc1AhFA
 EmYBo4E2kE3qdTscejqoyPpz+I68b257OGS5ybm1rD7ZL2Dsth5/PErtY5p+iMYI
 0hPAia/74COhk4xXFKs3mzjnSMcJAtAahNJbbDd5WkOm+li+46abqOx02WoaZxW8
 p82atvhYykOFccTo8zMPRyMftzcwfQiqBZXhlMUkC77G62HWNJyKbc/cyas5mJEx
 prsGXdNalQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=7sXAfLNR7S5vLVMaq5l0
 nk13u7RT3Adek5TpyDilLWE=; b=OfOtIH+sW/wh9gDf9naXqVnKdLp3W6dABOEa
 UjA/fG4gh4FY+HwYdgIQbQ/5zMvk/xzbJ7h6P1Epy0lZOofcANfDamwsIejYueNh
 mJcnBpcVAG7XjNMOtrSkagPaHLiPLuY2BDsM5BcYMkIVjSG1wT3bcpWFbGkNp5BV
 HgdSZ71IuJRYXxFCn1FOljgYRKWhYuQEILHrd/591mVsVhNDpHcVXLe4JOUaJLY0
 BM8HYdSlDJK/+FYRJJX9RnVowyin2XZV+qqNN7DROc67rw+9S8f48kCH7DaRUjn5
 MW1o7tIe+5ZhICPX/bdk0gxR63wfEd2jb2qIHZklzfKZSczSzw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=W9LNwOlx; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=GAaGBNvW; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=Gma3G28N; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=OfOtIH+s
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dmukhin@ford.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=ford.com header.i=@ford.com header.b="W9LNwOlx"; 
 dkim=pass (1024-bit key;
 unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.b="GAaGBNvW"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com
 header.b="Gma3G28N"; 
 dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com
 header.b="OfOtIH+s"; 
 dkim-atps=neutral
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sun, Jul 19, 2026 at 11:59:29AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-07-16T20:52:14, None <dmukhin@ford.com> wrote:
> > x86: add support for CONFIG_REMAKE_ELF
> >
> > Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
> > configurations.
> >
> > That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
> > proper linker arguments when u-boot.elf is requested.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > Makefile           | 1 +
> >  arch/x86/config.mk | 8 ++++++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> > That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
> > proper linker arguments when u-boot.elf is requested.
> 
> The variable is actually called PLATFORM_ELFLDFLAGS - please can you
> fix the name here. Also, please use the imperative ("Add a new ...
> variable") and mention what fails today when CONFIG_REMAKE_ELF is
> enabled on x86 (presumably ld picking the wrong emulation).
> 
> > diff --git a/Makefile b/Makefile
> > @@ -2003,6 +2003,7 @@ u-boot-with-spl-pbl.bin: spl/u-boot-spl.pbl $(UBOOT_BINLOAD) FORCE
> >  quiet_cmd_u-boot-elf ?= LD      $@
> >       cmd_u-boot-elf ?= $(LD) u-boot-elf.o -o $@ \
> >       $(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> > +     $(PLATFORM_ELFLDFLAGS) \
> 
> Please can you add the same to cmd_u-boot-spl-elf just below,
> otherwise CONFIG_SPL_REMAKE_ELF still fails on x86 (SPL is always
> 32-bit, so it wants -m elf_i386).
> 
> > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > @@ -24,9 +24,13 @@ EFI_IS_32BIT :=
> > -PLATFORM_CPPFLAGS += -march=i386 -m32
> > +PLATFORM_CPPFLAGS    += -march=i386 -m32
> > +PLATFORM_ELFFLAGS    += -O elf32-i386 -B i386
> > +PLATFORM_ELFLDFLAGS  += -m elf_i386
> 
> Please drop the whitespace churn on the existing PLATFORM_CPPFLAGS
> lines - the rest of the file uses a single space before +=
> 
> BTW, further down this file there is already:
> 
>     KBUILD_LDFLAGS += -m $(if $(IS_32BIT),elf_i386,elf_x86_64)
> 
> so you could set PLATFORM_ELFLDFLAGS the same way in one line outside
> the ifeq, next to that. What do you think?

Will update!

> 
> I'm also interested in which x86 platform you are using - I am working
> on getting Alder Lake supported at the moment.

Thanks for asking.
Unfortunately, I'm not able to share details about the platform.

> 
> Regards,
> Simon
