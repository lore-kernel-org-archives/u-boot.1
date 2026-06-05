Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B869CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B4E84999;
	Fri,  5 Jun 2026 05:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="g8idFLtf";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="OPkmmCQZ";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="MKxscF6Q";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="HNrGQHeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28638495E; Fri,  5 Jun 2026 05:43:21 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC138490B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654L5h502665757
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=5VtWIMkkjRQq0FkQ157NtQuGwUi
 7zf10rG/zw1i9jZU=; b=g8idFLtfoTHacjmDrBWIgLbI7bXSBMPN8PjserbRhTO
 Ig455z4BX+9hzVR2tYK7oysggM/AyD92CRA1AA53d619PXae8ohDCBsrxXEWnZjN
 OGnJ6dxJHFjICZaDapO9Lrc4ogiVuc28Yrgc3N3wj5J6kNwVxHxYqRceOAxpI4gY
 COiZNcQZD/1ypMSPq8PY2kTkVgCoKBZ+sPov2Foo0U5yvTfeCCtzMaBP7GTst/Gy
 vNjnC33+poV6rz27rWyZ4avu0w/kMwYI+LenMCD7SG747shEx5z7vt9rldUc0Jco
 1AI6NApJA164unZX9PpbwNeOQcSDTIqXv7FsI3cRdKw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ekgys9vnx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:43:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQ3y/ixpaq0e56e1KfUVbeIq94EyCowZtBV0s0aSNK9y45btYdk5PVxVyI8c/y3EEwCHOkdVPQGqyljxWB3f6vPZn9Ts5UZinGAUwic6ao3qmRI6Zl0hjZByrl+6p/5CC31XdbAeMWjizZHpLXgcAD4+8VsZce1swvEmzxtTKH6FSFLVTMG8D3AsrywYZYp0V92bM7cFHvrMTok2OP3TM8eAo4iW65+bAqIrSu+BrDW6MWarLpyOoIORG37EPUlk5sotAGK13m0lpVauaJzfgP1d23LLjC4yozVx7xLH84iWzR33ZpnzrJ8dp+9YvP8kYFILBUdiu3u8Mm2JBTAKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VtWIMkkjRQq0FkQ157NtQuGwUi7zf10rG/zw1i9jZU=;
 b=tCkd+gi0TftVs8yXRx1NsKWxoslCJeytIriB55NyEeaHEKCXjRdo0NaJXxwTIg4Dk2r32dRZO9nS0YIGNNdwGrGVnZy/LmXibVUBU+kHVa65JTKeyc7Ve8RrpHScERXwRXB51W6xL18gdi4qNjsYpUfNXo9A2LiRAlbVd6y6/7xyeQUD9JJyGD3WFfnW2YB50kI+DinOFOmjRfD5+d0CqOIJBCWgf0LnP5T8OuFdAJ2rsQExxAORiBPT+OXuVzCQkTyAppwK1c4a4DI7KZppW0uvDjYtBOm93xZjO6wx8LozQooftFv8zbXg1x4lU+54ey6OcZi4TmswaUBGVtjwKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VtWIMkkjRQq0FkQ157NtQuGwUi7zf10rG/zw1i9jZU=;
 b=OPkmmCQZJrC2c93oWiuooltyAXJWRhcDYvnr3XI2kKKtJ53oUP14pOOC4yW832u4wXkYzEmLnSrFSNG0ERSwpuKgB9NV8cc5T6Qycrx+7xj/pB9mnzNcJm0l6gNoxD85ggWsisQFvtw9/Hh9EXLbXzteQXLqqJ03f2kXxGmb3bQ=
Received: from MN2PR05CA0037.namprd05.prod.outlook.com (2603:10b6:208:236::6)
 by BY1PR16MB6412.namprd16.prod.outlook.com (2603:10b6:a03:4b6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:43:12 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::92) by MN2PR05CA0037.outlook.office365.com
 (2603:10b6:208:236::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:43:12 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Nt4Ab1342179
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=5VtWIMkkjRQq0FkQ157NtQuGwUi7zf10rG/zw1i9jZU=; b=MKxscF6QKCrp
 SXcxlzmEwIj13tXX64G0P8DpZ5m8j61oKrS5K3Sh5N2JC9zfMJqG0qqgPJtds1iU
 GhyGYDjyxDYaJG21peAtOqH0Ztlo2YxDiKVNDTha4Cw2LDio/HYT8ALJYl1LI3dY
 YEX705SwBDi2Da+979ZzbHBkOUdqH1hBt0NJQ0CxiJHCm+KRly0FsZlEtzKb7JF6
 1FgJ42RakSktGdo8RR+gyMDrZmqFAOo9PFZxWK5fwYCgMJd0HKkn5dgsulG9MAll
 4NGxbfgIhRSJADKNBk42nS3TC1DGBjQLmjNzAWYFsmPtFXJ/sSSVloQZNkgoYz9G
 bBCMnEgqvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=5VtWIMkkjRQq0FkQ157N
 tQuGwUi7zf10rG/zw1i9jZU=; b=HNrGQHeXKTtyz5nJlPsNLmbkbEka+AgiMftm
 FPIx9Chagz9ByWZGWqk+kseHJGJJvAG/rZoPfkggaDUymbdEWTUgOookWApBLO2g
 bLsv6IxXNjF0d+aSMl/LH8wjDVB6/n5J9BWFih4r/+Z3gEthAcZHzXjPlrL7np3Y
 uswBEpblu6X6AUF8lV5/0WD4PibHXC0mML9fM1eYNjjYvcL6w5gXNcseNWkTvf3o
 LZX3TzfoIwrJtKGwDVqBAVAY0lcuhBp5T+RJioMmk+r0Fm6GL4+XKe4i1PP8/5XO
 JJsIStaIgp/nsRG2CjNaI4AYrQhdTd/mtWPDUHsAIwF/HPOhCA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4egeb91h3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:43:10 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id VLSewmRNzpOFEVLSfwPBdn; Fri, 05 Jun 2026 03:43:10 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLSewmRNzpOFEVLSfwPBdn
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 4 Jun 2026 20:43:08 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com
Subject: Re: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
Message-ID: <aiJFzMdcCu5sAktz@kraken>
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-3-dmukhin@ford.com>
 <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org>
 <ahkJpZXnVVz5n26b@kraken>
 <162d730d-934a-42ea-adf6-18376971086e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162d730d-934a-42ea-adf6-18376971086e@linaro.org>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|BY1PR16MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 005aa1a3-f50e-4834-6d56-08dec2b49198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|22082099003|4133799003|4143699003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Kf5JVDD72qsrx84zd4CBMH1sW7o24KFSVmlE2lmcjwmlEKGevjUtr5UPTad8VqCOjrj8A+HuQhfgUJUFR0v1RybEURGxIcpSb8JVVdqm0dAH6lGTcmiXe0Xn3JkDW5ifFYBZuTQS90+Z/5pMNOuxjoJBkYnQJxpwOopy5qNEvSJT/73B3waCvrzCfwbYtPZob5hFZrbYWRjTYVFnRKu7EPmCGVQn5w2C3CAgDNiVYnW4ncweVRA3Dd+0Pzbs3IHnZR+rj5/SWx4EyvqXNNGINSu+LaNeiUCoH0BbIqE3DkOGQe1/rIRUnoVaIY7tvYJWg0X4Zq+4CEqXKcvl6iAzLCydz2XIFSF4GxmB0CenMisnY/E4tahd3+9OdCT4+ZmVpTmH3SlWjsDIGWuaPBBBca6Yphb6q0EZgmt2Hlvtj5aPr2kB6noZKIy2DljQDdoMGZFKxT3hFe1s/SeKt4xuHMLyqbqhMSaf0dX6INK/yBmr/voY6VSsBNpg7++NoEP+xCYoBnuGQkHUFxY8wLS1cdTKu+nkRVR7ExZJJCSAb9wwMzNMp6NF/A49MvL9Euvr448LGdxOjT39DPY5PmsSurmB/vTE0aizBtmVzjIvILlHU8gCw+7nStesKesKjALXshq5rbgOh+Yk1R5fx8QQy33OYQKzpo7Q4TZir+30Bf5mNWzMxjZ5/ClH+xqXfVDOkci+VIs0F8h8KTRBUetkweOLgiRDfHdv9q0jYi7Uono=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(4133799003)(4143699003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JlLgXIsS4JhuwnUFB/16mbCAj4KgQRsIR6buzoSdpeiZ41lpTb7fR6ycpX4bx9ErrrRoR0ruPeKBiLoyXWp9ewPcteZ6tQ1jlsb5LxdWD4uQu47Ee5s4zAQ9Exm6ocqMmG6+FoKJKpvLAGylSa+AWu/0aNMkuDn/3zIAMZqdt2p8H577a2yrJ1WBDxtyml1sKJcOokiPboFco15CaHmvaJPPYLoQhtF6xC1WtjiT7xpT2C0KFRkwOMYHIWO16eALUYolmkS7VR3dCpKKqiZ+oycjIxLzgCaxcWql8RVVbsS9gOaIbp+iXZmiFd1pmBCOytT0jce+X2jZUAGTNc4aLKAFrjFL0vRzrnghlsTCTxkIv54y7TpLcSg1GgldLmyDaMhbiI6rfEdWJVHj+8A2rbEZEYeWGS7DOtJ88tKFO+NKa0CLBluZpGZZHxzrUY7M
X-Exchange-RoutingPolicyChecked: tGOXn8M+DepZSSa5IkIwB7sLi+4Vr/JaaKbOJfCStty5eJo6AfwDdqhTeuyoGc5/VPWhuxkhfkfTAUMxavEnx593qMSroI4tZ//L77jD0iw0bAb321yaUtzpcNrplrQdzEGmnPlUd0uXRowQrKEQD0/4/bcjtRORjedkw9WFLnWweHbHpvh77ZmQ6qAeWRh+cmTGcsvibsHS7pI/hV4sBLIkISjgbnNj4nswkM4NFKww3gtWn6gLH9CAfDsEpxlY14QWfGQhzPINYseMx7JfSJ6IxZEzL0jytri2SJ7YKKD6YbW7a/BDuXKCBpJ0soro/gjOq/p0DyLs05+4d4Ap8A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LaOqxseM0JsYXlvrZ6Z9kJ6TgYUpCdkxPPDSCzJXu8kj3hsUTMBRqBjd6vtg9yOLAbRGODv0bd8kOBvBpFzvK2Dy5zRFsrDGy9EbBlJ1bqu8JlzHNkKItZB7Qki6nB0Q0mpTOU7P/HblBTdAgYHv5w5yXJUbmEbjwNgwp/WSQNDzWqE8eI/ZB9WOBW9tnVHc/uYy2xh34DZLyvNHOydAchUs8OEggrSyab734dfRkfsViNk+e/DF7irRC4D/Lt+GN8w/PA+lPg7JdYWeXGxaiWMUYDakESPDaFxnmG1wumpiorDEusZ9aQdWiG+MA93OIQEBKPIpHRHiXCu3GopmpVjkkX2BstW4uQeMcTUtZ+lDx9QMI3wL1DtsvGlPc1DL6R3VUBPnKFvm144siZL9/FrF0OEZIai0+xI6uEF4mK11oKpicNRjYfJCT/KVjJd2iW7mIdYJIlY24MTQC/eMiZtffORR1UcAk5CAV1j5EnXcGgqCbDpMump0Rcq4P+xsHMjN0gbjzRiQwJw+N9ggKuSZZk6+a1yD25U3n0TzT+wSZilIdXAj5gJLnwHSujNc62hBk4IeR4h+G9WJ78V5lhrkaMcjP3lahIZFvKVL55MnXmQ20prBH4KhuRELMg5n
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:43:12.2407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005aa1a3-f50e-4834-6d56-08dec2b49198
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR16MB6412
X-Proofpoint-GUID: ih8GsPBnmatNGRF18X1ISh8NctHMCWfa
X-Authority-Analysis: v=2.4 cv=BbjoFLt2 c=1 sm=1 tr=0 ts=6a2245d4 cx=c_pps
 a=57vGMAxBKyli4KBmgVngpg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=2D_qUbb6ghhTRWU4tHEA:9
 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: ih8GsPBnmatNGRF18X1ISh8NctHMCWfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMiBTYWx0ZWRfX8sx5MveoFqlX
 5v43Cb8DsjM6GWsm5df5VdukfAtB5Ls+0dcZPFbuqJ3XGShQackx3pz2yQwnLRHBHU6zX42SWYf
 QkdPTcj+VmanBeh21GReXd5dbuOdl94hxhvGua7rpxr5azBcjT/ys5D7/lk4PSgmWHEy9eDpY2l
 a12YMp9qBrcCVzGIP1uTB7ASC+/mHChze3fJvJIMqHTfTGW7KOSPTWM/P7ejB76s1fabn8h/e3H
 naUk9Kq3tAxxKXhb1tPk0DZWVjiXr6qSgUYXFn7oc4D7phJCrSAMUummnSM6YCB7g/f2PzXrsfu
 MdUeM3YNzcSQT5Rqq7vt52YE+xLpL9fdB6mW26QGS3c4rc2yBWqnc5a6njK3/+wcI6fne81nMX1
 CgqaTDNmmnWEqVPE26l6MTejRxIeBATqxZ2GvEQXtNmb8mvpNMEA7o5LbEJaTONWN1T9IBVTzBQ
 +xlukeQTF67bgCCXcZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050032
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

Hi Neil,

Thanks for your feedback!

Sorry, it took me a while to respond.

On Fri, May 29, 2026 at 09:54:32AM +0200, Neil Armstrong wrote:
[..]
> > 
> > > 
> > > The for NVMe, can it support write-through like SCSI FUA (Force Unit
> > > Access) which bypasses the cache on writes, with slower writes
> > > but safer and simpler than calling a flush before OS boot.
> > 
> > Yes, I've seen there was FUA patch [1], which was then reverted [2].
> > 
> > For our purposes, flush seems to be enough: the use case is
> > updating NVMe-backed boot counter from a custom bootflow.
> 
> OK the FUA was reverted because Bin's comment was not adressed:
> https://lore.kernel.org/u-boot/CAEUhbmU02GnqEEfuqNrSj8R5XEZkmkTUaLp1+BMbYQNdzTUZ7A@mail.gmail.com/
> 
> I would prefer having FUA added so all board could have this enabled
> and not have to update their boot flow to call flush, this was basically
> why the SCSI FUA was enabled.

I will take a look into FUA.

The problem I was solving is providing a guarantee that GPT headers
will be updated correctly on the NVMe device.

I have a new bootcount device which implements a counter backed by
GPT PTE flags (the top 16 bits) [1]

Patch [2] adds new APIs to update 16 bit flags in both primary and
backup GPT headers (the proposed write_gpt_pte() call).

This is where I originally used new flush command: to guarantee that
NVMe received all the updates before it is handed over to the OS.

[1] https://lore.kernel.org/u-boot/20260605033907.1909319-1-dmukhin@ford.com/
[2] https://lore.kernel.org/u-boot/20260605033907.1909319-3-dmukhin@ford.com/

> 
> As Bin's comment, perhaps a way would be to disable the Write Cache if
> the cache is present as init time (WCE), and it's even simpler, or
> get the enable state of the WC and use FUA if enabled.
> 
> Because the same question remains with the flush command, it's
> only valid if the WC is present and is enabled.
> 
> Thanks,
> Neil
> 
> > 
> > [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
> > [2] https://lore.kernel.org/u-boot/CAGi-RUL96GK5nfHx73UQQd_4sFByt3gNwqhFpHps+h58S20JwQ@mail.gmail.com/

--
Denis
