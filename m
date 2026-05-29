Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAA9CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ACC84659;
	Fri, 29 May 2026 05:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="lX3ou+j/";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="f+odMZgj";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="DzJo3zfN";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Hn5CvKOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A10D84671; Fri, 29 May 2026 05:25:21 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39B68341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3NXRY310257
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=IidEGRbQufBHEwC0Sk6tZC9Nwgs
 NoczrJn4jcm+dNKI=; b=lX3ou+j/kxYWtbZQZNBI6lus/ts/nrpNzhU0dXdY1B/
 0mHBcMMrXjMa00wmNMP8i3Rd0auaKw7l4//DMoC46tEwLV7nFxGd+6PPP4Jgi3r3
 q3qFV/o8y0JFUAzafQ58P2dmd2Y7fQYiNMkpwmjG5et9xm4UyVw1XduuVEd83q+W
 RVR5dFf+8K6ClA3r+iedcuqfrk3JcrLejYMFF2tLulvwPJ8cHTzeGrGe4bU3NHmY
 OxgDLar0oLzrQ2cvVKJG9RCeuFy7lyicsdKbVPrYf7Pxnw6fh0Y65vh0S7AXNGsU
 ARpBfzc27Lv+2EUd1emnw+L8HmdD9p0l4OBo9kR9Jww==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef2uv007a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:25:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/6O8cHVKRjdi9Q4n+HOu101BfEgSBDPx2C1FG7t/4xeNO/wFRentbMm4Cs8UHWVqayW4IxC99nMWxSM19acKG6rUuYS7zCYiQP04RqzZlUhJvO7ixJyGIZWcWVnzynamauI6hSPeWCR25wuOE4Ti9djTAjNTRpVlm+sBtAateDnzUtbbTGzRY3P+OBTbwa9/CbNaQBkpqNdhEPYg5l3Y0Izj4GFwHJeXnpCiZOUmmF4VZDP9aMNNLl55CHVohwWB4XVyuCsQiL/T6cgR0/DyrnLbbpMZ0P/acuASwrRBJVvC83u1TsBWx6E3TlTkQpAAR0as+FpijemKDlSyUo6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IidEGRbQufBHEwC0Sk6tZC9NwgsNoczrJn4jcm+dNKI=;
 b=KrnviIdPVW8I8wGcj0Y/nuF4cogbqVX4btKsuxs3Tdwt6zKaXhDQArprzCw7/IHqe8dtAhmDbzbygq+BP3wky8Nzj7A/9gge26+yx9xzDxx6BOBLZKibQKrQZs8tLMkkI/VVYHjl+WWPTQCbH02Di08IaLCr6KHp81o2GQZsogrB+X65fUUzR2d7dVV1CjV1AnuxrCWy4RQlb2noJL0X5oyThK9oHtkQ7IM5EPUd59t5/nXTu5ZgD21oLJg3sfrM1c/lIvJdmznkM44AiK1VLjqb02s4gVZhinFpf1Po4s2Si1xeQFXzByu67Dl1INY28MUObem7WCmv4HycuM5dUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IidEGRbQufBHEwC0Sk6tZC9NwgsNoczrJn4jcm+dNKI=;
 b=f+odMZgjlIWmsjpHSlPxdjB8ZdatvGvsOiL076YgNFERIG9VPg4OVpn8+jyzqJGV/yoI9oUJjxKYOmndcWX9P6xTBrEagP37GW2ar5Whntf4gKEzkd+vOzGyzZigkuneu138kF5Njkp8Mnk2dBZR1qLxsGVLiou1upUhPrENyfY=
Received: from SJ0PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:33f::30)
 by SA1PR16MB5968.namprd16.prod.outlook.com (2603:10b6:806:3b0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 03:25:12 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::87) by SJ0PR05CA0055.outlook.office365.com
 (2603:10b6:a03:33f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Fri, 29
 May 2026 03:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:25:12 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T26hL22743668
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=IidEGRbQufBHEwC0Sk6tZC9NwgsNoczrJn4jcm+dNKI=; b=DzJo3zfNldkM
 KIGf+RgxsCDIt3T6+IHi1nePfr9EC1fkRX6ec5I28pccfaiAakp/gLtV4CqNGQr9
 We5GdRzlularU1OUPoDvHZMlvpGjf+22PaRNq7xW6ad4qE0m1spZRZ582wbDKWFg
 DiTkv8gNUls1pdrm6bh9Wm/vAWRObIBy+a/3gmfAvTSV2PJVJmiDaH9Sf8WugzLW
 poanmSvvnASX/nM0P2WwcgkclmqnfSygh3GdMJSAK0034/PLpOxfBl7PgLcxWuG6
 hleXBqSx5s7KdmbLyD6JBRAEIPM206F9ahYgt0BA/2LPTd6viEoBOrdFpPLRhZOn
 sB4zXKeNOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=IidEGRbQufBHEwC0Sk6t
 ZC9NwgsNoczrJn4jcm+dNKI=; b=Hn5CvKOZ84/bCaStMjH0Q2AFDf8L6Qd+ZigD
 Vnpa6vuBoUvT8hT7bZjGoTmwNVp2Lq2XnbtKJfy4aMjxTaJiXQJL5hSOniCytwUm
 ugLngrf0RhUNDcuujsxH5HbFqYhTrwH3rHNLvGC4CfjWQaO4m/K/GfsVDmK1399I
 XZfot41bsvSSy5Iu064oluuzBBj0oQ8aLMoG5VrqW0SR43mKKBujQJH+06V8PgDV
 74jwL7onrgiZduPp6IqcXvaqCMtzptJWDurkcc2eCqoR6Yj4HfDxNmG5qIZrV0rt
 ksFkFu59+mm2+nTmHKGgBbdsRPFlHKm+ssq4JeAoqZK7omL8YA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5stdq-5
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:25:11 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id SnqPwbbdhntbrSnqQwE758; Fri, 29 May 2026 03:25:11 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SnqPwbbdhntbrSnqQwE758
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 28 May 2026 20:25:08 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com
Subject: Re: [PATCH v1 1/5] drivers: nvme: Log I/O timeouts
Message-ID: <ahkHFKauIqi9SKqI@kraken>
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-2-dmukhin@ford.com>
 <d93ac979-23fc-4229-a414-96c9bb2d8fa0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93ac979-23fc-4229-a414-96c9bb2d8fa0@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290032
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|SA1PR16MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d06f308-fba9-49ae-742c-08debd31e4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: HTDCxL+SOA/VxhJnyatX9Cz7+CzfdkoN0mnjFjWp9REALiGC4+DQMUb+DOjmSBhKTDwITiEvuiSyM4vOOvGjOL1dnVsfwkA6+d4dncN8BF2zoHhqHNHczD7O9q2WRx1IRdiX0qQ5OgEp1g2O/z8liVbmnLWuHFjMEJcFCQ5AIt8TDluKgMLP417LVOg7wEouktHo5kG1hQGp188vNKfy62kdmBVSKr/EenjtGXPMpUloWiSPhCU/Uoj9fo0PLNM9EkhDLlbMVGZGk6cURfDM7xkIrhuViVHQYa65bfVA6hwK+z0IpIjtRII7AEL5lkVxGU4JBo0bM1xooW7XJt79Q22zR21v4NUKFN8jzEviqtd+dUwCQAHUfdekz6j6Goz9RYrrpR7CvqxASK1TFJoScDeLLwQnjW389jrElXfstA5wJ23u8lxchscWxVIKHNHxhfFKMDa1nwO+MzNgQPPMQk89+P7VLyAJ6+nGyRd5SQiF8nHZlhF42iNO2O8+hgq/5jvpfsYdiwHlGaJ3tsyfIYwOlnVi+1nLtTbjDFwJiIJnYN/kCuuuM6iyV0bB1YVNyX6ZzvkesKh4PaZmQnbv0V+QVx/E91Qbub7+dO86EA3sqOoSjhGI1CLX4NbMx5e6iphaX24t5RIIuxMnQ6KObsUdP6C/1UzFDopoe50BAsw1IZ1yIGh5pqZBgbejDZv745kL3Ki8VWURnleocYByB5qQNK/Kq2wA1YgYsDry4X0=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kFQT1oXxYrUfo6iAuv6yOABhlfs06sZZa1UHPV1dNvU1y5ojYNSXDIqRWNbadERifhCTDs3x5FY4awbi4z4YmhqLkbQxN5mw/dftQ5tLqBvt7GaG8KwSg5Qa3oWXetXlyaSms6hoByCj9Q4Mwfyo8Hqre3qyPN4hExU0p02rXduy7d09l9DFvHx5ZD54LB/Drkk9XRz4L4H0ywhlGjkOoz9NEe+Rs3GsxT16RalLlmlVbkC/DNFHo0K5/Uqks52tlnHWtgUoKZeVKILRg48hMffuLsssoFZIL6OgVJycCuAc+hXHwIJfnSxuWpWZjJwZNC351FhaXOQ0MGUJQlRbilgevMqkS6FFOxjFWVgqcrXmeQQD28ZNEFhFxPeRLnOxnCo9JVEMfscwEtJDBJdXPaBJM8xQLuL1Idq7AoEF1ZYLuxsittJaBIBuQg9QLhxT
X-Exchange-RoutingPolicyChecked: fAk3hPdRZXLM5PI0NE9kg4YvLyjeiy2u22CrvcnqR+CaxxvKyUxoDHLq6oMagvJjOyWTkHgodilsZKeXH5bkN5Iu6AVdi+15BAvxld5cJ+ta2t2x2ct/dOTMcwHj6fuxlglFyDrwLacRWRACWBczlhihnxM7gro9IkIJTWLeCbe30j7pcz7yGUPb0hsGVthb6hQsLv8knvfY6aL/dWa8QvIunmlZ+oHE2/m3POJXyV3825+gFzDBaX2rqMY12v5Cq4eLMzfj0GeQSLfVLSK7+gKHUjJ8CMV/pA3URXUhB32iQ99ASbtPx53Q2St0/9olcRSCmjWSyYcpaGuR6KI6cQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: q7GTg5tuIm1Z4fp1wDtVwslsZDC3iEEtjUkcIalOQ1RmnrLlrd9TiCvIvkecPs72fJie4N7ZBw+SJykk/klsEnidzJKHRweeeBIKxzegItrfA6yDhrRt0w8Td54MlL+a99yQYrdbC8qdeZJv7CF4fkcLnpiyPcF0D/uZWDiiGsyK9Pw/IXTjZ6GV8czovFFmpjC/E9HF1hs7i3SIhj2bJcyKgCM4DJjkRCAbdTDGx+8JE8wzfy2U3f/ef/1JhO5ILy7ovrJcpocExEtrbc3Y9GJeG3L9zwGQqitBf3FDwRoJUfrvGhckPs7IScxroI9/sWy0S3ZFmDghQxxyNhrEb+Csti1pYdZAxNDjYTeB7i8SECxhgo12+6jj40/cwKfpg1gC1ASM/etPlcRviVrxrvl1samBZbPfUPn5yR8wptq2RLxfSYMoUWUotSSURHIkRxKyl4iCqZZrZbJqecislCexHO7sTpzEiWeuQ6NebWTcJr4gbSC1mggqZh3aKoII9CXgjt9ot7XBZP3J2qBdfDoM4wXf8SZ6lruY3inymz9K3ZvSvAPFm58IjZld2PsChQ0mOWcAtOLwzXEeYXmU/9oeeMy2Xx3qSNfJux/RjagEOJnqUIhOzrlwfnwBOvWslbjHXB6Z8Ej4V1EnVL/IEQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:25:12.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d06f308-fba9-49ae-742c-08debd31e4bf
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5968
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMiBTYWx0ZWRfX4RO4m3C5rG3y
 +V0UsuyAzaqXlh9L4+WXOLH3rBLuOw/jUxKdEfHSWjge4sapBpauSUfBbdSFeufo1suklMZ96ju
 lT4sx9iHW9svi/E5V871EN9doYYXf09h604dKARIYa10/NHrWnAXrqgyhpEEFqhSHvDimEBfYSF
 tbWdyrGyB8i3p/oXLO8RKYQkcObH6v9EFUWJcCF6hyQ2eZ2CoTbIt8cMmp6Wc9CBSIw8pnTkdN4
 xrfiVg+7hkJlfstw/kQzA+QA61CT8NEpdtRikv/HfJw0raxSNvMi37ILz8LWwLK8Oo2glzPwgeF
 XaVGWw3xWDMQ8PT3MtCvIJjUNKu63FYyal/4lCNR6BB8UTVxyotTgeBoJV3Rb67HEgMUfQVFfjt
 5o3I3TRYveufpfT4CVvIP0Y7QDZeyhhHpG5aMl6Id5FvJvdl6ICA2tEU9XqOD3kP0mW4eGaUTCR
 /cDVTmO1mleNXrfyN3A==
X-Authority-Analysis: v=2.4 cv=epLvCIpX c=1 sm=1 tr=0 ts=6a19071c cx=c_pps
 a=HO36DfDzC3pv6rVb14NK+A==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22
 a=cbNQJ9GKAAAA:8 a=KKAkSRfTAAAA:8 a=8wcHP27ZyHCryiCvkmAA:9 a=CjuIK1q_8ugA:10
 a=DqJYxgmhk6moR-_7_KoZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0BC8sp3MnMsTbNl_s_iEADzB0g6nLlbq
X-Proofpoint-ORIG-GUID: 0BC8sp3MnMsTbNl_s_iEADzB0g6nLlbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290032
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

On Thu, May 28, 2026 at 11:11:35AM +0200, Neil Armstrong wrote:
> On 5/28/26 03:20, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com>
> > 
> > Current code silently swallows any timed-out commands scheduled
> > to NVMe. Log those to be able to debug any potential problems with
> > the NVMe hardware/firmware.
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> >   drivers/nvme/nvme.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> > index 0631b190b978..c3c44e50f19a 100644
> > --- a/drivers/nvme/nvme.c
> > +++ b/drivers/nvme/nvme.c
> > @@ -182,8 +182,10 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
> >   		if ((status & 0x01) == phase)
> >   			break;
> >   		if (timeout_us > 0 && (timer_get_us() - start_time)
> > -		    >= timeout_us)
> > +		    >= timeout_us) {
> > +			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
> >   			return -ETIMEDOUT;
> > +		}
> >   	}
> >   	ops = (struct nvme_ops *)nvmeq->dev->udev->driver->ops;
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thank you!

> 
> Thanks,
> Neil
