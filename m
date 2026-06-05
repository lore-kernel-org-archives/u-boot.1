Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF76CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C284784999;
	Fri,  5 Jun 2026 05:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="mXSytTKG";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="BPIhI8Xe";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="ESVjbF+B";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="neoLZi74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096B8849CE; Fri,  5 Jun 2026 05:39:37 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D01984999
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654L0kDN1817866
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=uqR
 lWvofprUM3kVL+jv2fPh2wyna0yCdy2YDHiZuq1Q=; b=mXSytTKGT+yIvUfA7wo
 ijZ6ri18BCA27K7VMj+wprZC0K5zrv8JqZ1OUdNCsyT0X/3s24o5J6nkGztyiYMx
 BwiRtZq9fmsirl7eRNmBTyQEWH4BmkDIvLePbcpQypvDb6vpUzbMYePCTJUWxRaq
 hEDHfJCrcXnxJHRiXOb+rncP0wB7ofb8zGfkx1LXL//1KHkVaJga8CuoPCFR9Nye
 cVcd6KGy4HkJ6rb9M1J58VmhGjssAyGTaH68ocnX4miMfSxuEgizo/7msXUKC80M
 QSeiAHXSmroscKGp9lzGvRfwCeoGKUNbVYtmcPGb7tYU9wtXVM1ZDkiYGNOCOKMq
 /jw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekgwf1wut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uhn/v3rTLEyhMvRLMpRtitYn3Gro3ypvz4FaJuhZWAIX4u8XkzzNyFXx8jLQDH3u8jkqiXdGfIDnWgF+7qLEae0wvd5CD5oIKNEMSWJ/c1LNrGgfM6zz8nUQA3jKvWQdlDnFjHCMqQ7XjIOpbMqU7/kCV1Eny2wh8AD2AA7SobvXIpZpkvcbXEBbCWxPFHMXYAaucrakjh3uU8GRxhk20RFA4T8VIayVn+hSq430wNsmL8FexxulfxdnWO+IZqFoMXTFBCkeZwXEQQRVRomMYhFYVxQCQGNFGMcxVjLdLiZJdUbnb5W/kSUBqIBTsn0I3Am/0bH7tpDJNWNM7tlHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqRlWvofprUM3kVL+jv2fPh2wyna0yCdy2YDHiZuq1Q=;
 b=oZl9iosjH61Pky19aa3reE28cxkLad08ead6cCnyxL1nLKAqsakspUI/KYCqI7e/bCJc3I05HraVHqL9QyhGQO4gitxiuLkjPtjShjY7L8HKmy5y4a+Qu3gYK/2HdOfKg/tBSEJfAOBA9Hd5xkmOomb5fL5VEzu9etToQQ/vtiXw+0U379j38o+VX46rPo/1IzUUV9wcsvDezPThiyQV2p8E/2+ScC1w2MAwzIQjdd1qv/9x0at5EUkq4Llld5uOXUthfupPcswNfClOYFC0AhzafbA/DFLUE59vq5p0AS0ZfCLHG4exSZfJkz4VGJKHFqJGIVJJ4UXoShP1BaRtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqRlWvofprUM3kVL+jv2fPh2wyna0yCdy2YDHiZuq1Q=;
 b=BPIhI8XeZ5IaBAKfSeQzH8k7rYE1vf55KyQ2DeytGh0dHuylT/RLi26j9WY6bvMFFSt4NPi4rspAWyFTm+ltezzA/PykcCOk3c2P9TEGnSoD1o5iTSv3jbWg653HFenC1YHaui4fVGg2dy+fN/G4CNmco/Mq3DtyUUXU20KZuZ0=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by SJ2PR16MB5143.namprd16.prod.outlook.com (2603:10b6:a03:4ff::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:39:28 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::29) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Fri, 5
 Jun 2026 03:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:27 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6551ElUg475542
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=uqRlWvofprUM3kVL+jv2fPh2wyna0yCdy2YDHiZuq1Q=; b=
 ESVjbF+B2aENE3WHSiszFfmaPBccO/w19oNVo4oA8xMJ9212B65LYR8I02josQET
 8CzorMaAVLD+iLU7bFeZDGURRzcKrYckVLrbd/sRJdChiuRpl5uPUw6X1S/6HjHk
 dtNEkVEtxlzVF2fM7wRNm6/4cCqgvXvc9oT1P0VTfYtSGzfjtbPB4dtWn2sYT+qK
 qvukimVHoR6sM/wZBzg9/Bl5s2YcrXonOnlS7Akq5th4DjN+em6dI56JYVT7CstS
 HeNG4DqcRAsUaDnBRP7YeS/WBelYrKVbqIW7RGFedgwGBd+4C5gfu0VMRvDMuxSw
 zk1s/6JsGXem4NrAan6WzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=uqRlWvo
 fprUM3kVL+jv2fPh2wyna0yCdy2YDHiZuq1Q=; b=neoLZi74tuI6JMsJ4SMzcLI
 dxyCvCIpQjzdIZsMbeh93v5aMcErkCUe/h+col1OW23thV4JzihADZ/MPYw50t9Z
 TBJJpN/W5k/7keEFDfmD1yzNI7GYmQ+o9lw4MysAd38L3ZI19je4L9pmLkVqx6Ix
 CZPAJNN3FHHjx//83P76XlfTimf8ge3/+fGcbrb6XroQFST49tF3baE6KWlMQ2md
 fkcP/AV8w9u496bzlwbJQaiToJ888k8GXVPSnrQ4MDv7St6Q3zI0mZt9ypxBmcE5
 G9veIreBPCyD4ne05gFjHn/PSylKhSgW6eMh+DT/6nNocx5krcaYhtWQuiw0RdA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4egeb91h0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:27 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLP3wZjNm8Hc9VLP3weE5j; Fri, 05 Jun 2026 03:39:26 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLP3wZjNm8Hc9VLP3weE5j
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 7/8] bootcount: gpt: ensure coreboot payload enables
 DM_BOOTCOUNT
Date: Thu,  4 Jun 2026 20:39:06 -0700
Message-ID: <20260605033907.1909319-8-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|SJ2PR16MB5143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eb941bfe-e551-4187-1b8f-08dec2b40ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HnnoDS96qhWyH+QI7L6gIRyMGJgnX+xL1gWwq49qFD3AQWRJkSwYTgJhYgcvVThosamHx03wLEDFYceqt2A5j64CYmI7QM+9sf81qzffOFgc/nXSDPplM2ua4lcuvG1p3zmZ9Q36CnOFYF2otdQJwW7IJmW42zQ0K0ou+Eeiaz7GUyvAcYy0AmBTxml6U1m15IMv309PxAeHLm0kIVp+kd6QpdSx+bLi0mQIBn8fNdoZvG0sU+k+ft0zl2dBx3aCJQEIz0aYNVxOWo/X+asoA2aKjIlyd1y5Bl5NttVtwPJVPhSldA9FtkkcIOl+QyEYOMH2w0QsuKReiL7TcSzGFkS8KYAEfKCQAZvf4jDXVUvjUgQxjZhpSX1e4TgdZg/2Ys3Sd8XasvxoDF7EXsUKa2p9TiTHKGqyJhqg7xgtygWPHOEu8sKqOAgX2AW504lLTR6wP10SncwopjP6rytmmjAqbIy9SBWUDcDVBWd431eHNWyyDAdkS+86wTMv3gyO7w97E3XgIpiOjwcf4Ou+jVWmtydMCpOQXkmO3Kh9KA2A/mBIbK+CA1sdzeH41HZhlEk0rWsHuegdlYDjP52XIhU4SFJd9abo/qxnU1WB/GXYGQu45qyndcxWHvYILXaD7/FEmAvw8rNUdlD1iCyZxZ5XbYtOIqnCtH37WPEDe1RTZCdI/j7cLvy1PdhtbeG9+cwLg0Ji2SiHleZMfh+DiFIiraKOa+OXypDesn4U6Ag=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: omj8M5HjUEjzhwydDdMcSKlgD/I/k+bBX7v1cED3J5Er1AxPD6GadSHL+WxMmNbhRYefgdAMVqVIF2Lka4Nnr7mrcf/XfyNk721BNtMZffugPzN62ifJMJ2nEf5Ff04r46de5T6aU4Z79EH0fJNBXQZdahmoV67mskaLD/l7ReFC1O2ZEm11x1xx47QFBH6B/lu0fbuFYRY+Dyl9Ex0QMu1nJWkzA7aeTdfLNQi++/9HRlrDNHBrn+DcjZJ47qhNcgZ08ZY54KaQDSH/lFTOuz/MM9RnKGiIdAszTuJudSw5lQ0EgqkvbE2sC689wCdi8GGYQW7e5G97kwdB6WRivfNE5DoKUgte/SnfqUSzfPPYnRP6xEifIHmkuks9CQTnDNHPc+AWYgduyhLRV7DGqkvXjA2r9dV2Bm+KU5gEbVUc3wkQnHwnkexV4psP6MJD
X-Exchange-RoutingPolicyChecked: jM4GlyYC8STeXk55KPAMgrBjIVlBRAJsz0eYPISeMzIwDrHuxqtZLjIqhWAb/lTyoS3DRPHlzG/PMLMVmRfp6sip9GXZJP3tMcCmgxfecWCOU4HkB0AIt6eUTtA2hqC/yU1RYhaEalF9oQ9JMzocR0JYy7bKyACF9kOsEZ6JR1iQrg5nsFCzskJ5FACHNfd7kgKIJO+7n2HtEGos9tZgQ39ZYHPFDfVbWZmd3G4Ijy0Ur9JpXUseYmYmgcS+of6LRHdPD1TtONv70uw8eOrrE9wKWG1btSx9Z0R4xQ/mY1tCZWFE0ElFEOtsYpE1167hsOmIxt/M7hjkJ08AqTuXFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: //+9yaWf+DW+7QA9HoxikA7QvBkIHUGsun5IWvZvHfQDLUdwlUunCLflcrTnQz6UumYcaM3Z9+iqxdaIqhu8getfE6Lasyc4Jq4tF8CL6RSCexEeKN8vvrB/9bjOnPdDEW5HEHkTD/YSlsJZZLfPpdGm5gnfy/bvcCnFfiaxCZFcmLyK/MdBoaiuqBRZ5jZZ6Xvo8YYlVVmto4nA/TxrKp8UqTStzpzOBLUEZeFY6uH7ihMDjWpbVE3VdIKX2Nq0nzjtBGi7kwzrzGDKt4avjL4NM+ARINA60+HYRDdK0MyOxewah3MH3J0aa+1En1GEnBRud+V0VbAoMTTWdDZgxYkTfwCbA2PNuZgR1vgBDAZ8ZRrfTa9sebn3Ib2yVzKAnhEzsfP253BpkCElImwzmfQNxKHz0CgtxRRv6gUtb+wjwLlN6ahO1RvxKOs6JCPm62Vbd3Ga7rQ81Y7qajv+ubJ8dhkyGwtW2JegZvBMVpTEYJT8cQY8T7STE1P0QS4N/i5pvHiL3I45q36hxhpLq++y6trqGmfxbJBbvpAXu2vqIXZTIoHmlkiTT04LMeK0rjWuZC7AI62OICSpSfts+et72U8ykju0IZ/DXTp1r4FRtX0+Z2XlUZgmBSNdd0sz
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:27.7628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb941bfe-e551-4187-1b8f-08dec2b40ba1
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5143
X-Authority-Analysis: v=2.4 cv=YJWvDxGx c=1 sm=1 tr=0 ts=6a2244f4 cx=c_pps
 a=91TlPzG7kPfjcj/W1M6+cg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=cbNQJ9GKAAAA:8
 a=Ywa299VSVsyQXN45340A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: daN26ydXvhd737zr4gPIb9gOQjDuCPZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX8huzoSvJljSp
 mcOenVR67XWPJjjlumLsVIJXFR8uRcfGxJfJ0ak/iVoTxwr2uJdmog3Xjq6vNoTm0e7p6AhUjqL
 EglU0HCuhm32HW0VLxy4AL+KtLYeKQESN/u+2itZM4oRXLHoym3QeDsBfcN6P/QYkJRbEfZLs6m
 FfLdrjbz9j2iJtMTC4sH/K4IUOYySJssYrXkKD6iA8QsHyT3TqMUpvrh4vEqt3nt/ijv3N0XRCn
 J+xTIqm9+42ignEQIAOdEVZflLeQITQDRcw1zRuEEv7vcEX9XGlGZtQFg2QFXnp6SuvDmUYlffG
 I5umVbIxlkXcIB818AREThYKa/C0KwurQi1WmKiRIwmHIRLGGQAmZfJItW46gNOKIV+Nky8p+Yg
 nm3zcrI38AlKy77Ov4NySbcILYTmYhH7vcsebmSFAeOuyqd+VZ91mtpgSc7Rw7dTn8u373iakiB
 bTn+JJ4DfmH2Eu+mA/Q==
X-Proofpoint-GUID: daN26ydXvhd737zr4gPIb9gOQjDuCPZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050031
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

From: Denis Mukhin <dmukhin@ford.com> 

Ensure that bootcount-gpt device is enabled in U-Boot when running
as a coreboot payload.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/bootcount/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index eccd610e3390..70ef44a0dc82 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -13,7 +13,8 @@ if BOOTCOUNT_LIMIT
 choice
 	prompt "Boot count device"
 	default BOOTCOUNT_AM33XX if AM33XX || SOC_DA8XX
-	default BOOTCOUNT_GENERIC
+	default BOOTCOUNT_GENERIC if !VENDOR_COREBOOT
+	default DM_BOOTCOUNT if VENDOR_COREBOOT
 
 config BOOTCOUNT_GENERIC
 	bool "Generic default boot counter"
-- 
2.54.0

