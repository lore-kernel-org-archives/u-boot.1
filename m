Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A697CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A29F848D8;
	Thu, 28 May 2026 01:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="ZP78vS0e";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="EAST0GAp";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="SrTyKeOB";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="NmDGKyUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1746848A2; Thu, 28 May 2026 01:13:29 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6759846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKhunv1427244
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=XOI
 ePy8gB8LXHjwLM2b484HNENOumTxEYT8CcSHLnts=; b=ZP78vS0eD27ZSvf1j0E
 Y3roTJNgwhSo4M3IybJ8oR6JaZeNsRO/mpLu65q7rI+VGibc8UctuSFPIugMkXfQ
 gHkenoKlEnHKQxBv9hm6O+WVD5AujVmCfy52E2PtLoIOR+a44jOhLVX3PHHVMERw
 SQMCj5wpzx0dMXFDnYKa0RFeTidCFumZJLLzbvcJe+uJlUqTWYi6swPZb7lXO1PE
 gP1P2nRTdaRG9BnZAz7dXH79x3WUUNF9O8xoCDSuufk9EnlgcBBP/qpjA5ohGKAG
 tTBhoCGbrzMewfPPR9WRfHBxYkLKtA36oacbAiY9ku/UGnU4GHXf+xOg0cYN4ZKb
 G6w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wjrvng-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwbAm94ZyFD/qeDQDeX3KnMpROpPSTboUQax3I43X1Nr8WflUYhVnN+GPk1JHHqmy+RXeKXKFSA1gQOmjB013Wl19fifIJMImAAAVEa3G52mM5zlLJ05mRqY8piR96Hs6qD3paw8y+okzmrvhMBzCoNIgE+MbRM+1ddeuqFdNj9pC6xKB9kIaCF8rTPDLrYNRnSWCre1fFBplihZCqxsRr1xHvfxRwE4trea77e97ayAcnYeuw9hB1A8KGhie9k7wnH7yK6YI5C1wX8JEZTtebwsrXW07P7BPz6HcFpu9jzovI9uD5A5F2XVZAIZjgAhM2fQobWSXUuuLrKTGW1V3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOIePy8gB8LXHjwLM2b484HNENOumTxEYT8CcSHLnts=;
 b=RtF7L8r4wJPAiwUZzaJuGjIbDrNBF+sy1OGUEJdFn49wDirhvHhfGIAZMKU6gH1xVEaTQZJGc29hz/90Uu0dK3e3i7OBbN/kag3QdxP5zkZhTLLz0OuZh1vZdZfqLA6HTEthy1fX26asb4inKDgBTKabayuc5ZmuGRXJ9iA2wON2FknLu+iivDmikBkqz7RLrBvboP2AGr87znqn7xXq4whNCyTseJEr9XgB/9Csg/jgfmwydOZD5SHetlsG+RPcMTvZTrjWCyWvFU4TANwkPnw1iu9Quim38mVm1MKHACXZAIKHuG3j8TEc/doLHBoBrYTB0eRlstuZkegEx7GclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOIePy8gB8LXHjwLM2b484HNENOumTxEYT8CcSHLnts=;
 b=EAST0GApTHTVxvGp15dXq3PRo2Fuz+W7/5wWcXoh/njnNbwHIjJZEV+c0U+Iw5sC8JjzOMtrwOFKTVCgWKXUmqPIIzzwCuFYomcTGTTzwApjmbRUrivWyM9ssGbaYLOLzxPSlDz/BtqHQKzHQUrx0hyAfMBOLH0HEmUr/KvlwnA=
Received: from BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::13)
 by DS0PR16MB7125.namprd16.prod.outlook.com (2603:10b6:8:301::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:13:22 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::9b) by BY1P220CA0041.outlook.office365.com
 (2603:10b6:a03:59e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Wed, 27
 May 2026 23:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:22 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjxYV3408790
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=XOIePy8gB8LXHjwLM2b484HNENOumTxEYT8CcSHLnts=; b=
 SrTyKeOBdjIZ323VYtPyTn4GgF7S80EbM6UZ5lvAyljPtmMixB2sFmyJ9Ul2B+sV
 fusm96TePn+rJk2mMbB6fJdjYAiUzrMAMI4Zf6o7w089HqryhiAwHYf7LB6x3hLt
 Cc3chjJhOPLLfeH+dKboBHd2DC+Bc9GusP0O+LR8aSRGEHPtW7sq0L3oSo8ma/jw
 6lx2fr1qzeewXOXoH5MeN1wKnd8x/lVHHsOfeYxdJYLeJFdApWzVRWJz2br60vq7
 dytepwYOZ+6EWqryRU1lQpfhGuRGSHSiA2y0rVuCeUAkd0ADxXp0QzoXiEmmYeiQ
 g2LfUd8f8FF6+Bg9VWzDVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=XOIePy8
 gB8LXHjwLM2b484HNENOumTxEYT8CcSHLnts=; b=NmDGKyUGuI0KCeILpOnts1i
 0FgkTQRAhoBtNmBwCDB7QWukADfkAm6INcljmpWTjq2GygixdGfgEPPg5CItI5r+
 h36CgVRkCh72vlHwtw+hNGlF5vVNvGuF71StqZgWtqCfbgN0NJtcL6f6LyovErrF
 WFsRC5shCXW/AQILBag7WTHYgsByB4rsvVSAKeOMY+yR8Feyy2lH29SekQ9HmXHk
 terKx2emY+l9qMABBnQQymQEqgSGhkUEqFAz6iY56w0a8ChLKknvG9MvEQlySySg
 dNxF+A5tEPCBzi89NQJhJQO9/QuekMcHDd+rFwhE1Mg/I8mRVyj5Ik46JUaYv0w=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x9g41m-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:21 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SNR9wYwuE9jbESNR9wAE3p; Wed, 27 May 2026 23:13:20 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNR9wYwuE9jbESNR9wAE3p
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 5/6] docs: reset: document cold reset option
Date: Wed, 27 May 2026 16:13:05 -0700
Message-ID: <20260527231306.1714741-6-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527231306.1714741-1-dmukhin@ford.com>
References: <20260527231306.1714741-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS0PR16MB7125:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e6dbc8f-70d8-4e4c-080d-08debc458c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8suUSFO0NpexuXpkXp5DQnMmiK5OhkOV9vwx+5F22ixL/Bo9gMxWHkDhkk9vG4bdYj++O/jhEW8klrpoxF+MWlW19fs5Z8ERG8KyI3iXU9GJvOXojjnmJdaAK/mGRNnOj92rENm+HzfcH+1PvYH1Ikg+8Vme+kWZYoqpNWXXPZSqGmGF68F8/XyY3uu9qPjMuRGkIfHb3IYVPT0MdaNlD/fT8HjKlcpNX4E9GNZmRTNp0m/leBU8EXuZ6G79vCo94Gk1prk7OEYiAGa76BHkG6zGrUnq/6zvuxx+TmhpVIGw33vkWYDHOQvzQCJZ/d2zZYWB4wAgrBxq2KqQ2ZaF6dtA+Rk4WXrSSoBZiw48OWLhyoGx/5UJzr6QExDp6fFo+mOrjEn0RaErjKnHBQnGfQtiGI/Q+7Mftc7zvGYL32YeVoyYxs5n68lFWsxZ+hVTeCfdw2bH9Vyls7rmudyQeml4qvv/UB/m7NElQTX8kjPJL5uwv1abcETCThSEnbjWwmgQKD0TC/Bdm56tiszUgFEaeYlCYwGPHCd2gc1uCDVM6fpwfA/nHVnYjj7CTaD4m1ziMm6APwlJsk7EkbZ2mU6QicvSNDmRbktg+ojtNsXDTY4uqnjUlLmJpzP+Zrgdv7HejPrZElz9UuBYdZs+/nzTPcrVNM94wsgM8QWeQjmVFVyggWFlrXJIqj1+nNnGeadJuPakHStuTTT2JLukgL8DiQHAXpDLVsjAElcxgho=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yue/8PsMkkbycKsbLnWc7zJcTIVXz5INgdQyDy+WUtXtRydKHqkvHkYY5Nvq30lcCb6SRCWuopGKjlQu+lWM4C41os4yqe0G3rEbYKwML0ih7ngnYeqeXfs68JXCw+v36Cw9sTxraImqKzSCHvZ4v3x6vW1sEeaaPYyHOca4mTwt1SQgnIl2hmmM9NYfaRp+YmNf9f4x2w2PEmiRZ2RlunjlIUJSmQIJlccb72qzz1GjVlXaHw552hs45Sp7LNGWy2RdHVs9CH6adpKRnsLlQwMPzZbxYfM+YfmcSgyBxLLUQTxGzrWmd14AfiPIaF7rE/Nr/E6SNyE5h8/7bzSL2qLO6OqWF3hk1gAlvX39W6bj2ZL1vp/z6wsx0aTNLPevbgElgBrFjHom8yJ3PbQsqu1uMEkAikH18Ib9fkwxU1p/RuKyf+AVOSHaHO2MqFkY
X-Exchange-RoutingPolicyChecked: oEcSQfxxYx+LQeixjpYeM19duwchCEdsc/hgSTF4UliobZn4Bevw4oNPEJJKGNqrmoRS/ZA5UIeBJ44Ww7EEM/rRsRvkPq5CORv1cgrQVyfWK8h+Km1ulvBZHHJl1tJ6j2n3TV/DEZuyBuk3x9DnOsCdEn2h8MjlQ+Uw7UB3Sm9a9WyWCzqOf93Gk3fvA/R1F4SgBJLQ0LBjVxtS1dAAMtbsqnrhWNf4dfTKTr/GcWI2TuaW5M7isc3uCl31RMpupaBBF5YVk2GV1d2BwxKdU82MiOsHuPavVzNXhaDv54mK922vDiokAOFUN90ji/POX2mr9zm6K4pLPvn0ImS3Gw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BXeULLT/I34SnxFabzPE+qf7mV4vWwpm27zXeGJLpcTwB/9tB4XrGv13/fdfn7U5sLnvg82dGQYh6xcWavlUpGmfUFCR06EexgefjLHAvtq5hxb0hLIAqdpRQzpyX+qJA9HnkLXLcLSXQ88CsY8WNqeQAzc8TXwWuyXpxZcd9Utob/I10PdgAry0kxj5AIyivMKmR+hREnDA1ZkIn9vxNj4/ukvTELo8ZRsoBubqn2SijSVhY1Q1uTPxHqmfulAnr/lM9yNo9ozioVN0SoBZZFRAHJ8A6tvrt48Ub8KO+KpcZ0PtP2aYWwNKqxGfzLsvTqztCunfoqi/Ps6LJieOagndspq9dNgpthekOJqH/7xEiGEJdXpo3zAscsi31dTtH6BYBd2uqsyWhIw80ChqPyahymmgK2EAY+b4r9Eu+e8ImpVV28WX0aDjFWOcVMUwvaReylj0jYKuceAhbwKrFQAO7KVfCb6cT43Y4NYV+giLIqsz9p2DMSqkxdFethZkVGl2SB/btQGy9/WcmtP4Cej8O7KP559FMPOxkdBdyXr0KyMkN/8ZpabYBS/L8wdh3iQrYxGNah9q65s3xkNFxKqTO96GITO+tn2tWWzBNctnmHqkSUz22/PZZ63Z8BEfYnVV4l2Qlo9MnBBDI3d2aA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:22.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6dbc8f-70d8-4e4c-080d-08debc458c23
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB7125
X-Proofpoint-ORIG-GUID: 8g7LF6ORGZAyLsfyLBVeD1Y8gMM7Xy5l
X-Proofpoint-GUID: 8g7LF6ORGZAyLsfyLBVeD1Y8gMM7Xy5l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfX6tFu9lLsz4aa
 Le/G3nZivbtUSy+TaMCYXeRyZU9owsquttzczYsfsw6Zaw2xWOnEwS9U35i023zhcKwrQCo2XyJ
 9vlRbjoPbYbfm4/wq0Yi5PMzxGj1e61xBiCGaYsWdYkKa87ou+Vm/l9mnJIMyNliuXXuRO5D6ld
 o3FzSqAhdCdYChx82iejDBkqpKodBPppvfhSXjkMPOLxpZe7CKqah5s350Ojc41VCLc9/sMOK8i
 Vundiz2hZHtdS+98QnIu4MrGTIVCfnkdftanaJ8Ok8XfhdMnRGm3jJ0MsZh+Obe31CzpSyreViB
 omOrSfz0MSbyLlyNqEkv9GP514Z8xnnE5qJE/D+DziPQuHPCoP7mDKzVXEVghOZUOp4JJWN9Qh0
 iFGG7E89SMQy82rwMNGz0vqjeXUw7nZ+fVo1oU1vCHmIWXDPeETk30x2oqL84+TiZbf6Z2fKl38
 j0pzq56/f+Q8Rd7CthA==
X-Authority-Analysis: v=2.4 cv=O48Jeh9W c=1 sm=1 tr=0 ts=6a177a96 cx=c_pps
 a=M+4CHf8fKMkYOwSYEMZyZQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=wkF2nE8tNcg9G46RHpkA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

Update the reset command documentation to cover `reset -c` and explain
that the default reset type can be overridden through the relevant
Kconfig choice.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- new patch
---
 doc/usage/cmd/reset.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 79bc8b9deca5..e319d2146caa 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -12,6 +12,7 @@ Synopsis
 ::
 
     reset
+    reset -c
     reset -w
     reset -edl
 
@@ -21,6 +22,13 @@ Description
 Perform reset of the CPU. By default does COLD reset, which resets CPU,
 DDR and peripherals, on some boards also resets external PMIC.
 
+The default behavior may be overridden via
+CONFIG_SYSRESET_CMD_RESET_DEFAULT_{COLD,WARM,POWER,POWER_OFF}.
+
+-c
+    Do COLD reset: reset CPU and peripheral/DDR; on some boards also resets
+    external PMIC.
+
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
-- 
2.54.0

