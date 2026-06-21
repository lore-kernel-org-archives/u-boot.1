Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68733CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 05:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E106E84874;
	Sun, 21 Jun 2026 07:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="D8LNZ/I2";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="iO2BeLXB";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="b0vy105N";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="ICx558Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30997849D2; Sun, 21 Jun 2026 07:15:09 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F59483FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 07:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L4wA2H2392644
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=tZf
 tnT+iiG13OvcyJqPZeVTFQ3FisWn8SQhCygEwfBE=; b=D8LNZ/I25rFhDKgir2z
 ubICpfeF/QouTP11FQ833Pw31PLgSFp9qUHN1hFuWahgbRsZmaZlFp5F20PamuQZ
 sK+8gkVcwn0iW5QrXgcQc5uvLB5PU3TrjiCwIpZQd2s+hAsPgXSvYmuxWxfW5A7l
 9FPwe3as6wIzh8Ojh8WO7UpI1vU5gESJ1Gsen/f5dqsTaSUVPR9yRrRE76lB5F1n
 6Q+6BlQeHLcpg4mK1dAOfp+arhseObTq66KXAkoZA9qf3DwhOBqAlEwWvaf4u36c
 YRRNJswyxQQHNwR++NXyGbPjgmknFPzKMTYJgXHR64lCuAOHsJwkkNvVgaT13yuy
 K1Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ex5290rut-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 05:15:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSQNbeOEx8t8zMqLYMps2KAY1oYe3HwSW6pypkr7AM1KuAXozbd2wQwRP8kGk1GWp9f1cgEvbiFotm3MrLI8flCs7jUL3/aqf24LWB1JQx7W4liLiPE5mKXnx2pYlDjwixArfj+OQNtU2NXvouLJgI0pV09J8GrXJSLUWhTDLvrQmYTLc+imss85RrXpos2toKW7fdxTV9E2BTuuKgvhjIxuE10D/MxcUXFHeqpveJL6HL7UvH07QoeXtDnPlzDkso6v4BlwWU1cOzXCwnT1ZkCV5w2ucMoMJgx1oMR7+sr72xYkNXzQCHnahH7G/YGQUgGrutSuYk/l4RYrQmRNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZftnT+iiG13OvcyJqPZeVTFQ3FisWn8SQhCygEwfBE=;
 b=ARr3fSYnL1hku0p24a3uFOFd8At5LMI3yyik64IlF/NSiNjbBNF1y8H0FO81ACYqX2jFbXRiPa2lGPIyI3e4TXHuI7lTzdOxGBnCQ/L+kYw8C9DYOJaGpXMIn4WpdCV0eWj+M2yb8zVa1t4dsngpD7oV/uEfSWF3pGleTyQPJPSwYTuhn2qwVOAUgrZh9PrnzoEnX/hEkNvSU/87UXRgQAysJ6TZrkDjzlonrQT9/+Mkep6MbykkZzJ0VvpQEvlejCTlico6boh7ZQjNDyaqcRQg0rUvO0zZEFf/UZn3t2jeSPGS9djkhH+CMZfx7Lo2pw3F20mokv4qWWlXGzSELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZftnT+iiG13OvcyJqPZeVTFQ3FisWn8SQhCygEwfBE=;
 b=iO2BeLXBt3E6vTugFVgpe2qLRpC/jKXgWSmwFtEjSRJEU9T40EO0H1zIlW8jw8TH6ZalySvIfOkdUditmHF8fUKubCvDbGf0BdDEdyUJifsP1Klxkc9+62t/dxL8e7nHFyjqhbn5DwOfPo5lBUazfvu/usGL0f1y3j1PiAAu65c=
Received: from CH2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:20::40)
 by LV8PR16MB5912.namprd16.prod.outlook.com (2603:10b6:408:1e5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 21 Jun
 2026 05:14:58 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::54) by CH2PR07CA0027.outlook.office365.com
 (2603:10b6:610:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sun,
 21 Jun 2026 05:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Sun, 21 Jun 2026 05:14:57 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L4pZLr3159726
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=tZftnT+iiG13OvcyJqPZeVTFQ3FisWn8SQhCygEwfBE=; b=
 b0vy105NX6Fl1zf7tweb2dEXHQbVlsEVp9guvjUOfFRyDfWcn2Da8bGm7CzX1zNx
 Jyp3rh/Ox6QwhbpFdZUf9mMshqZeLy8Hokru3wHtUs8wvWbsa7O1vBITQ85SckPL
 Sa293Spy7eGZDwYXyk9AhZwzmt2UtcWg6WOVEPPzdREa8UN4WnJchOa3RKzL9GKm
 9sZW4NSHO2tukvn86xhk/zskSfedlXq24B4RnzGwsPZXbo4ZUKr+5vUXWkCEtPPX
 ERD2c7HvEwFZ2ccHjcNatDCbpxrNBuFDMRb2qlEcvw0mTTU4uj7IhyCOalpWHNtI
 WLpECXget+zSgYozUh6d/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=tZftnT+
 iiG13OvcyJqPZeVTFQ3FisWn8SQhCygEwfBE=; b=ICx558VlrwmYZhJx9b0r90J
 TrM5eSdAxQ5ED7tyFiTBCI82jQdXMGvQKYBcriYl/JpVOnsBU+xcJGfuIirOtLz1
 8Y8Nr7VWCAJUaw/zyJ0+hk9pi9zba38De3BptDEYM77/ns8EPW59LNzTk+xFB9bJ
 cNStUqHPWIG4k4Tvqf+Ctq1zf6DdDSPvuX2llti17JiYGfFM7UZ+CZTK0aWpfWYi
 305LGn/QPgKF++RkApHWQdgOQGdLUv4GCWljaPz2bQr2n6XCWSZmrv5XQ/6eLMZ8
 PA72GP8kYcLZxT89yFdSQmOWdYg7ZJE2I7iu1hlSrNyWviTiXu0ioxFerCsoSNg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ex9a4r0gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:14:56 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id bAWEwnXGieBX2bAWFwUZjP; Sun, 21 Jun 2026 05:14:55 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: bAWEwnXGieBX2bAWFwUZjP
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 3/3] test: bootdev: scan with a broken high-priority device
Date: Sat, 20 Jun 2026 22:14:45 -0700
Message-ID: <20260621051445.1763952-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621051445.1763952-1-dmukhin@ford.com>
References: <20260621051445.1763952-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606210049
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|LV8PR16MB5912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eab0f510-a0af-45e9-95e8-08decf5409ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Kf6cY6TZ7Au3LGvwGrcXcgt+V6GrAdzF5xOLIKzxFFd4ORFoqtJckLwEMBxEomnN3OQTrmzc2FO8VG/nyuuAamAjjgU7gk5aewSscX7t362a2wcVomow3rTZ7DChhJpERYAl8wSXfHqKuAZzmW3xa7Z+P0x22UG07+cBDN1eWxOyFp8kUTSI3wEMFFb82Gcxn5+rvHNS/15tHqg69ePh1A/wqvOEFiypu31P00A133cC5NAyc3WGPIVG4NdtnTtgDJJlMkbTyMd+/p9B14Gk2tQ8RHh0rwAcHpUWG7/XFv9+CZJSjT3uPk8i1ucjLJo8r0mlQPNSotSkvAvTyKH6JbPQg8bZLpKKk3cR9jPrvdCNHPKFUv25ZId8lpjzATqlCBWZjd/gBV51hVri3hTdPEbanPI5oFZaqObiABNK/4E1FjGotzSDHmHv/fTjIImNfWf+Nj2E2vd/avsVFWT78AYUNhsymtLkwf6A/3jT20FZO+xaOuiXGnHA7R/RqULXMW6WksnLyFZL8rE2kwrHox0SrABTZvJ/4wbcGzNgDZV/XqnT1Ga5NzZErTWjaUXccLYgl7ShucYJKv3B6tZaORxLAP00c34QGDWMjhfVqSUBlHs9iXeZs0pyEcX2KcuLROahADPRkKeJaoHZOp6x2k8YzEP1gDzAcMv2O+YTlqi5bUUztCCFTOgccUf2eHFmO3JgL1DU17LZMSdGgQe6Ow==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n9GhzI8fM7p/WGOc8C7+NlPBqiMCnrnFH0Kby1ZHRg3vsrswnbaqm+UAQzK88OBH88SdkiNwiDqqvliXipwwFpNcExAW4krm3Pgmy5z3NZOo1AxKbOEp4xj2qNUOHfmFFC+IMnOEiun8fDKBEIcvXejYeA+kVJhC2tx9ornL2t3hAs+YNZWELNijdtN8nBOcGgDwKc/WlS6U6MWoV4h718fWiT7GMA/aXwjLSIkHc4/+Y95YoYMGNLOr1Spdm2hHgLwL+rDN7zpq2uO7eruplSG536pLRKt9wer44Ay7ggh9NhXVHiw8X+00Jy9jZXjRPYNobK7QvpcN0oDWHzKwzo6Y95ByVL+LF0F6Wrl4E2j7LrKg24jdbcurmlnl0v6jyAzddRqlI9BepA08bV0MGZw8a97F+/jLR0Drgr7INav17EEKM9WKFVvFwUCkBEdE
X-Exchange-RoutingPolicyChecked: h9yV4vFEuk878AvDcj4Be+zPmSR308i6KJYLEsaYQO8MUbBd6dpJdgyn2osWJjzMF7gvNAW9LTNf6ac2ij6iXLGI2xcxx+qvi0CcjfZlFTJzV4AQHE1ncWg0SAiioYzPVPfhQTPqWQualwM/UON73aKFwYR0bJ+aBGRYQkPaayH1cwVKv5wO52vuy40YRUBsWFWagerhtezOmrA9l3vic+5URS11pnBWK+P48TZPOodZ6CuLDno07XxGUT6y7J8QOPkfEoSRKI+M+DFLCWthvSTFLlPjOIFuo7EJqngrif6KHZU9scKabmbEL79qbGrZLOaw1lXulQZPTX6y25LkHA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OU30caGoWnIWCo4uLIx5B/iKS5INQs50Ipv7dpFSxCGHRolbfrBoysIdO649qVX4jSgls4t10ZDQVyToI4retruQOmCNW0+8aZiG68uBeTbjIE2P/bxAePvpx/6yRBFIP+zHtGIStAdGjoKptkOfsdi+siXcsXKDAu8BwaH6y+r8MxfQ2UbrxVpyjQ0LhIXiyLJ1oY0d0EFEK581TW23in5yGvdmOgAohmOw7+cZAFLOm/T6DyqiF1/J0oD76S1rdYGZijrviyoEjhYqxXRSQuK0inTAXPrAFnUovqGdUd0H3g/lt70lUKsAlCygWaKYSqrL4q6rSZNslUpiD4B4Y++1pFeYbVMiwPzIsBFtI3TMP3WEhhQS9Gb7IgdEdke36OG7o5cq4bDgqAmLhX1A2PC4LHlK6c9x2OMRj6Fz9ZC2ylha7VrGfmvrmZjxsv3qlMzIMn+fMHVStbPRZt0ESA0X9wD5FJ8hs3VwjMbrroHqSO8to12XvBgnIwfF8QSjFvRroWVo6937jyAuJOEWFK89bngs/DVf9tSFSO4B7nvDJux08EJRz8xctysvxAB/wIbnNeyd4ARjMhswJU4SUOM4X1WmCQlDBfuf8l5g3HubMbmBEKBQmIB/+/cP7OLhxOfxJx1vMWFgJ4/8Q3aKYQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 05:14:57.7378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab0f510-a0af-45e9-95e8-08decf5409ad
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB5912
X-Proofpoint-GUID: gN4U0k0I-JXpB51dIjLlKW2fWKK3vE7E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfXxuM2GdDiT+oc
 ZVG+AxC7RMmLe+NoxkHPSJXe0BmxpLPjex30Ptwm5dm/z6od6ApcNbxglh3X5eweDVsUn+m8HCO
 sr+AWyGZCzrsvthzSVxs9w0vKPqoBv8r1k/SbDzSnwC/GuELXT9TwG4lpOxMLOjDvhmvxbSMrU5
 X3riZmX0rP2GS3hIEzmbDhVvxdyRHBbOvHKQLUxPh0gm5pfG9a3VNfIPEMILnxMRuB6pWZzFp8V
 6T8PX1ZuUJxvCBZNsBSBA+XPrz4/cLKvrM+AoTElEAcqJnF0xKPVHNJEMVh1iuL/4R78nssF4aG
 7HOsEaaWXM3F1q0u8l50Dt1ly2xG7XyH1YO7ao5188lOS06GpK+0LP5akuo/ADCun2l0f3hUOZq
 4Efv6fBi18w4+hLa45tQ3sLdycur/XhlB7cJYJyrQdi5Ikg1E7a82hqEW1Y8j9uJ32bbS+gsOms
 C1qUno905SYs0rRsczg==
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a377358 cx=c_pps
 a=jRvQvoFr2LhS1HEjeZSEyQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=i1MxBqhcqyiCWgHNAf4A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA0OSBTYWx0ZWRfXwU1AiTm5GJNB
 7qeUM85+q7VSU+Zvsim3gVa5+H/vAn/n7+w8KyPEgqlmKwBZKzFRbC54L/Pes0Pqhn4Pq9lnxWf
 xZcx/vgmmz6SZMg4AxcrE6QvEvLOcQPn2FWFQ7S0JeMjhJZDSQWl
X-Proofpoint-ORIG-GUID: gN4U0k0I-JXpB51dIjLlKW2fWKK3vE7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210049
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

Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
falls back to a lower-priority bootdev when a higher-priority hunter
fails.

Introduce a simple 'sandbox-bootdev' device for the test. The new
bootdev can be configured to produce an error at the hunting stage.

Adjust boot{dev,flow} tests which depend on bootdev hunters.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- dropped 'flags' from 'host_priv'
- added description for 'flags' in host_sb_plat
- switched to log_xxx() calls in sandbox-bootdev.c
- corrected sandbox_bootdev_hunt()
- updated boot{dev,flow} tests which depend on bootdev hunters

Changes since v1:
- new patch
---
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 17 +++++++++
 drivers/block/sandbox-bootdev.c | 62 +++++++++++++++++++++++++++++++++
 include/sandbox_host.h          | 18 ++++++++++
 test/boot/bootdev.c             | 25 +++++++------
 test/boot/bootflow.c            | 51 +++++++++++++++++++++++++++
 test/boot/bootstd_common.h      |  2 +-
 7 files changed, 164 insertions(+), 13 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index f5a9d8637a3c..c827fa81a2d8 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_XPL_BUILD
 obj-$(CONFIG_IDE) += ide.o
 obj-$(CONFIG_RKMTD) += rkmtd.o
 endif
-obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
+obj-$(CONFIG_SANDBOX) += sandbox.o sandbox-bootdev.o host-uclass.o host_dev.o
 obj-$(CONFIG_$(PHASE_)BLOCK_CACHE) += blkcache.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap.o
 obj-$(CONFIG_$(PHASE_)BLKMAP) += blkmap_helper.o
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index cf42bd1e07ac..7862b988fd68 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -150,6 +150,23 @@ struct udevice *host_find_by_label(const char *label)
 	return NULL;
 }
 
+int host_set_flags_by_label(const char *label, unsigned int flags)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		if (plat->label && !strcmp(label, plat->label)) {
+			plat->flags = flags;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 struct udevice *host_get_cur_dev(void)
 {
 	struct uclass *uc = uclass_find(UCLASS_HOST);
diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
new file mode 100644
index 000000000000..ccd3a379dd21
--- /dev/null
+++ b/drivers/block/sandbox-bootdev.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define LOG_CATEGORY	UCLASS_HOST
+
+#include <bootdev.h>
+#include <dm.h>
+#include <log.h>
+#include <sandbox_host.h>
+
+static int sandbox_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_4_SCAN_FAST; /* at least priority 4 */
+
+	return 0;
+}
+
+static int sandbox_bootdev_hunt(struct bootdev_hunter *info, bool show)
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret;
+
+	uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
+		struct host_sb_plat *plat = dev_get_plat(dev);
+
+		log_debug("hunting %s\n", plat->label);
+
+		if (plat->flags & BLK_HOST_BROKEN) {
+			ret = -ETIME;
+			log_err("cannot hunt sandbox device '%s': %d\n",
+			       plat->label, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+struct bootdev_ops sandbox_bootdev_ops = {
+};
+
+static const struct udevice_id sandbox_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-sandbox" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_bootdev) = {
+	.name		= "sandbox_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &sandbox_bootdev_ops,
+	.bind		= sandbox_bootdev_bind,
+	.of_match	= sandbox_bootdev_ids,
+};
+
+BOOTDEV_HUNTER(sandbox_bootdev_hunter) = {
+	.prio		= BOOTDEVP_4_SCAN_FAST,
+	.uclass		= UCLASS_HOST,
+	.hunt		= sandbox_bootdev_hunt,
+	.drv		= DM_DRIVER_REF(sandbox_bootdev),
+};
diff --git a/include/sandbox_host.h b/include/sandbox_host.h
index f7a5fc672300..075d39cfecea 100644
--- a/include/sandbox_host.h
+++ b/include/sandbox_host.h
@@ -8,17 +8,26 @@
 #ifndef __SANDBOX_HOST__
 #define __SANDBOX_HOST__
 
+/**
+ * Device flags.
+ */
+enum {
+	BLK_HOST_BROKEN			= BIT(0), /* Simulate broken device */
+};
+
 /**
  * struct host_sb_plat - platform data for a host device
  *
  * @label: Label for this device (allocated)
  * @filename: Name of file this is attached to, or NULL (allocated)
  * @fd: File descriptor of file, or 0 for none (file is not open)
+ * @flags: Device flags (e.g. for unit tests).
  */
 struct host_sb_plat {
 	char *label;
 	char *filename;
 	int fd;
+	unsigned int flags;
 };
 
 /**
@@ -122,4 +131,13 @@ struct udevice *host_get_cur_dev(void);
  */
 void host_set_cur_dev(struct udevice *dev);
 
+/**
+ * host_set_flags_by_label() - Set the host device test flags
+ *
+ * @label: Label of the attachment, e.g. "test1"
+ * @flags: Device flags
+ * Returns: 0 if OK, -ve on error
+ */
+int host_set_flags_by_label(const char *label, unsigned int flags);
+
 #endif /* __SANDBOX_HOST__ */
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 0820bf10ee08..fedb2ce90565 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -384,19 +384,20 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
 	ut_assert_nextline("   2        mmc              mmc_bootdev");
 	ut_assert_nextline("   4        nvme             nvme_bootdev");
 	ut_assert_nextline("   4        qfw              qfw_bootdev");
+	ut_assert_nextline("   4        host             sandbox_bootdev");
 	ut_assert_nextline("   4        scsi             scsi_bootdev");
 	ut_assert_nextline("   4        spi_flash        sf_bootdev");
 	ut_assert_nextline("   5        usb              usb_bootdev");
 	ut_assert_nextline("   4        virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_assertok(bootdev_hunt("usb1", false));
 	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
 	ut_assert_console_end();
 
-	/* USB is 8th in the list, so bit 7 */
-	ut_asserteq(BIT(7), std->hunters_used);
+	/* USB is 9th in the list, so bit 8 */
+	ut_asserteq(BIT(8), std->hunters_used);
 
 	return 0;
 }
@@ -417,7 +418,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("Prio  Used  Uclass           Hunter");
 	ut_assert_nextlinen("----");
 	ut_assert_nextline("   6        ethernet         eth_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Use the MMC hunter and see that it updates */
@@ -425,7 +426,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assertok(run_command("bootdev hunt -l", 0));
 	ut_assert_skip_to_line("   5        ide              ide_bootdev");
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
-	ut_assert_skip_to_line("(total hunters: 9)");
+	ut_assert_skip_to_line("(total hunters: 10)");
 	ut_assert_console_end();
 
 	/* Scan all hunters */
@@ -441,6 +442,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 
 	ut_assert_nextline("Hunting with: nvme");
 	ut_assert_nextline("Hunting with: qfw");
+	ut_assert_nextline("Hunting with: host");
 	ut_assert_nextline("Hunting with: scsi");
 	ut_assert_nextline("scanning bus for devices...");
 	ut_assert_skip_to_line("Hunting with: spi_flash");
@@ -458,11 +460,12 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
 	ut_assert_nextline("   2     *  mmc              mmc_bootdev");
 	ut_assert_nextline("   4     *  nvme             nvme_bootdev");
 	ut_assert_nextline("   4     *  qfw              qfw_bootdev");
+	ut_assert_nextline("   4     *  host             sandbox_bootdev");
 	ut_assert_nextline("   4     *  scsi             scsi_bootdev");
 	ut_assert_nextline("   4     *  spi_flash        sf_bootdev");
 	ut_assert_nextline("   5     *  usb              usb_bootdev");
 	ut_assert_nextline("   4     *  virtio           virtio_bootdev");
-	ut_assert_nextline("(total hunters: 9)");
+	ut_assert_nextline("(total hunters: 10)");
 	ut_assert_console_end();
 
 	ut_asserteq(GENMASK(MAX_HUNTER, 0), std->hunters_used);
@@ -646,8 +649,8 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_asserteq_str("scsi.id0lun0.bootdev", dev->name);
 	ut_asserteq(BOOTFLOW_METHF_SINGLE_UCLASS, mflags);
 
-	/* SCSI is 6th in the list, so bit 5 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5), std->hunters_used);
+	/* SCSI is 7th in the list, so bit 6 */
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(6), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -657,7 +660,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* dhcp: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(6) | BIT(0), std->hunters_used);
 
 	ut_assertok(bootdev_next_label(&iter, &dev, &mflags));
 	ut_assert_console_end();
@@ -667,7 +670,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 		    mflags);
 
 	/* pxe: Ethernet is first so bit 0 */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(6) | BIT(0), std->hunters_used);
 
 	mflags = 123;
 	ut_asserteq(-ENODEV, bootdev_next_label(&iter, &dev, &mflags));
@@ -675,7 +678,7 @@ static int bootdev_test_next_label(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* no change */
-	ut_asserteq(BIT(MMC_HUNTER) | BIT(5) | BIT(0), std->hunters_used);
+	ut_asserteq(BIT(MMC_HUNTER) | BIT(6) | BIT(0), std->hunters_used);
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 56ee1952357b..65ad72e0d6bf 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -19,6 +19,8 @@
 #include <mapmem.h>
 #ifdef CONFIG_SANDBOX
 #include <asm/test.h>
+#include <sandbox_host.h>
+#include <os.h>
 #endif
 #include <dm/device-internal.h>
 #include <dm/lists.h>
@@ -1532,3 +1534,52 @@ static int bootstd_images(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_images, UTF_CONSOLE);
+
+#ifdef CONFIG_SANDBOX
+/*
+ * Check that bootdev scanning does not stop if higher-priority bootdevs
+ * are failed to be hunted.
+ */
+static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
+{
+	struct bootstd_priv *std;
+	struct udevice *dev;
+	const char **old_order;
+
+	test_set_skip_delays(true);
+	bootstd_reset_usb();
+	console_record_reset_enable();
+
+	/* Reset bootstd state */
+	ut_assertok(bootstd_get_priv(&std));
+	old_order = std->bootdev_order;
+	std->bootdev_order = NULL;
+	std->hunters_used = 0;
+
+	/*
+	 * Create a sandbox block device (BOOTDEVP_4_SCAN_FAST) and mark it as
+	 * broken so that bootdev_hunt_prio() returns an error.
+	 */
+	ut_asserteq(0, uclass_id_count(UCLASS_HOST));
+	ut_assertok(host_create_device("test", true, DEFAULT_BLKSZ, &dev));
+	ut_assertok(host_set_flags_by_label("test", BLK_HOST_BROKEN));
+	ut_asserteq(1, uclass_id_count(UCLASS_HOST));
+
+	/*
+	 * Scan with hunting.
+	 * The sandbox hunter at priority 4 must fail, but the USB hunter at
+	 * priority 5 must still be reached.
+	 */
+	ut_assertok(run_command("bootflow scan -l", 0));
+
+	/* USB was hunted despite the sandbox hunter failure */
+	ut_assert_skip_to_line("Bus usb@1: 5 USB Device(s) found");
+
+	/* Clean up */
+	std->bootdev_order = old_order;
+
+	return 0;
+}
+BOOTSTD_TEST(bootdev_hunt_fallthrough,
+             UTF_DM | UTF_SCAN_FDT | UTF_SF_BOOTDEV | UTF_CONSOLE);
+#endif /* CONFIG_SANDBOX */
diff --git a/test/boot/bootstd_common.h b/test/boot/bootstd_common.h
index dd769313a842..e60f6ba6a0e0 100644
--- a/test/boot/bootstd_common.h
+++ b/test/boot/bootstd_common.h
@@ -21,7 +21,7 @@
 #define TEST_VERNUM		0x00010002
 
 enum {
-	MAX_HUNTER	= 8,
+	MAX_HUNTER	= 9,
 	MMC_HUNTER	= 2,	/* ID of MMC hunter */
 };
 
-- 
2.54.0

