Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B549ECD5BC9
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3A4848D7;
	Thu, 28 May 2026 03:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Bx1Bofml";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="YPHWlKQb";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="IttBYk8W";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="F+Hq0Ap4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1CF848A2; Thu, 28 May 2026 03:21:14 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4749D844CF
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKiFTO2199011
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Lgd
 acpwfnGalFM3PvWY4Y69ACnJ+YkPNiQpWOzydFtQ=; b=Bx1BofmlqhsyrULgj1z
 LKJlPBT9sM4QiLAfrG8424YoYitPvBH+eRuPyv5/eN7OQrWtowFWsrKfqRmBHYqT
 1V6amLgLvPFQuCNJrW1rVmYtKRHZjODrKQ+mEJqTBSdkTOD6Mj7u05GkgzeXjt/q
 cOBmFKBKuVrzvP1Y+i3ZRBpHKvbGf6kRbjTKbgAbw7Ho/5IDg3u9clG4Jh0M6oO8
 inMr9tLVIcrH3xBQJbmouPBie8iuIJb7at0v+figJm7ALf3PT07okyHDDP7dQ58y
 ccANVxW4zi1+0KbcNVRZ9tHOjnc+y42X0G/ybvxNdOiCDk19r6Si1O98bpq2gyCt
 syg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wq9dwn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNsOs1l0bnZfDVM/3C5l4XbrpJqUj45ieZ09tyQkulv+rUS3H17eW0rpkEKSGH+M+Ep/ArVGzexS16cJleG2Wkh7YCy6YtE2Kg0D7RYZ73fon0MGC4ivLJOMALZ0ZndP8iAU8vvkyNXtdGpitgdM+80gO50sVLLRshx6aU35BHHZgpBdSBq5ag2FMFT6yst6ahyhpUDl5L90lqVSK874hqfqChS0LoK2l9bFPTw2JEcVwk2HF7ToGPqwQRMRxSzpMDZHK5ZjLYmOZPwaJ5VM8ELslR64WLzMmBRpP+5czYuINA3TFjys7qAzlozspcs0hryrOUhuZ6F2iOnuerrd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgdacpwfnGalFM3PvWY4Y69ACnJ+YkPNiQpWOzydFtQ=;
 b=IL0oy5pI0g03IuXMCoW2nSN71ZeWPT5JzPUWoH0TpNg8983HMiwJneydwm2aCJeFJRxOtQnDh498CDZaTqjgi08xMakZNvLeI1AcQnuRDRIBALDCAYmv5SDWqJY97763zIK60U8gzUOlMx3h54ePlCJjTmeu+RNdQn0c9lMdEH8UTSA/pSqP3TvanqtgeGUuZ0KKVnWSBwUDal1RKWXhSq2E5qYnywOKZ6Jnv4KRSpxxAJi4rS9YMU8jhCYPE/Abu1DusDBqcOzKS3DOEVOuvZ8CdjJuXsFQ7egoQBPOHizkZdMkMqKUSndf4guhv7zkLNWaobCXxGrdo4C+eUD7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgdacpwfnGalFM3PvWY4Y69ACnJ+YkPNiQpWOzydFtQ=;
 b=YPHWlKQb4+Agc96FOLttgl6+Wo5hLHXMgrbKm9OJnjThwk1CJa2xwVdQ5qXeUCHfn01FIrHMHquYyhJYadPM9YdnSXxPWPT5na27lr05So+MOLX1MMLd8WAi5Opbd/pX6DUx4jbN8R42RvSpHTzov48mFvNHUm5WID+AxwSSiW4=
Received: from BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12)
 by PH0PR16MB6918.namprd16.prod.outlook.com (2603:10b6:510:386::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 01:21:07 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::56) by BY3PR04CA0007.outlook.office365.com
 (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 01:21:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:07 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjTBE3452362
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=LgdacpwfnGalFM3PvWY4Y69ACnJ+YkPNiQpWOzydFtQ=; b=
 IttBYk8Wjy5UKFuIe/c0F/61DX56L7xoooaUkPCuLsutjYZp2aWjdw/4D71AgKY/
 IFq+UD4hzFA41aQJ8oFS63vZ8ADUrEKDgtsqx/3Sf8lGZGZ+rQ62uUfWPRE/pp4c
 7v8VvlWUh/SVN3yJIEMbnMDTzdrDFhgO9zfBoILu5kM49t/kVzRwHOpRuLju6Bfi
 Iqlz5X7t07+TKICrMWmqBMU+KkSqX6D6j3kaZztOCXs0yx4Sdh6GjsYUf+0YDTu4
 oe9mYNGh6q7XEoMDB6nYQdXwHACgx08CvxE3AZnD/GsEcfH2loEWv6VNvNljqf2F
 PjTdgM7XXrXA9hTu/2J40g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=Lgdacpw
 fnGalFM3PvWY4Y69ACnJ+YkPNiQpWOzydFtQ=; b=F+Hq0Ap41dXUVFDVWwOAb1m
 Xm4S0l0mnwusrviT1ep4/RD2FTvuuIweHeJkkoeBCnbw/gP6cpxQFeIm58gIRpjz
 UX15VTRkkfBPpry8MyZ5Jscvv6UiW0dHmv00Tlit54f9b7m9WC/kzpaIj7EbnWru
 Y4zsM+sc8nVQZtxwsTlcpTNsDWVbJMiA2xS5ELdir6bs2lwcIgE5YY3stbitAlqD
 qKrxubzeo1fl13WfTFekhI1R4egBkStj9iolGmNz66Nbbwxto4ix2/wBVbtzWvEL
 1e2eTf8obo9zG2nXKYQxcShofaQKr/GFKdWExUGIuy8sdJfJpcSitr6GPSZzuzw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x887f5-5
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:06 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SPQmwck2l9jbESPQnwGSoK; Thu, 28 May 2026 01:21:05 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQmwck2l9jbESPQnwGSoK
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 3/5] cmd: nvme: Add flush support
Date: Wed, 27 May 2026 18:20:54 -0700
Message-ID: <20260528012056.1744362-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528012056.1744362-1-dmukhin@ford.com>
References: <20260528012056.1744362-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280010
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH0PR16MB6918:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15b0b41f-fd45-4d55-62f5-08debc5764dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hXM62GjJXmmG+vy+Pe6f9bMqpafW1RnQC+08GrZfcdS47FqjbTTnuH39MGW0gUryfZI3mAZqu3RlWNv6zv3YbPbB3mv6tqKxuB/HlolsplVYXkAakcahMim3q8mHNYl9sB7VpHa/O7dmRV56oTBXFv8WqTCRoRyuSFNE0U3K8fkObqLqc46yG6Vgw10oqCyQeb3xnGg3X1SOIfOdj3rtym7sZ8HybvfV0QL/Q6yPfCgVH3Z9WqR7SLM8ElEgeFO/3z31nTmJicTvDMBT5YpRm9D5Swb7n06tAWruIZGL4z8KSypDqj5czglFrQ9gKWtivQqJWbnhdPYq8QE3AqfJE+khbAg/XYFUG1QmwgL+WElvHNwp9yXQceyMCclryfnLy8CjGcHJnqwnAV3XrsNy9HuX3IQMw48dLNtZlHWwvASFLOJ6irsTEBOgRD3CehsTUA0BJUjyIIpnGlsCyd87lfSeG7MCWvyZcJWgl2XOaFhDhyxfXADZy/Pey/vj9xLTDXXhJes/IWX2d69mo5ZemH3aHdmf3ManP6K7tDtAixWagoQMXUOEsGh6DBfeSZKjFmogsYi/6lonX2ZfBvxROupYGY5SYe4iZ2zcVnlilvCJW2hSdReY8AbsttbQm1Ug86iBwXkR2UhYmy/ieMWGcLtvq38xb2zx6km1inf2XnbuIY8fiXCCU8qSnpsQRi5fhkFf+cqYZjzY19fprWiY2WCZQqPT8NFK5+T39aF79fI=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Sw9yl1yPAdyfwZcjOGDed2Vq/jIx4EDucYIUTn0q6kR0rmGwBn0NeoUc18QRUFyraN90+9U1V7nD9uToNCJNx/kl9B7gY1rydxti7fDe4wTl0AHuB1P31ZHiq0zmS1TFYCsg7KD60BtElPWGyWuPlDLY2bYDwzPQ7eqdHmGWKrM5jnaroDjrh+uqgBOGKtmiTZmZkXFMyNjGmkKddavUTx2owu51h1feasYgUlEyN0ueSO+3Vfm2IKjlwVBzzBJcGtk5qW/3dp8S0gMoGNattlgMeeEkwpqh+olxEIZxoOWyURsoKHJnk5WkiBRFEWe15bJ74YANrAvvcMfrLrPPlXv8BzUCgNM/mdVW+xABHhqKGhQ6pgPZt3cYtNfr2cYgknrY5ZNnD5DV8YYqThBzyQA4VEmKsWE2tP25ATM/oUUde9JBkeyku7hDFbkiBsy1
X-Exchange-RoutingPolicyChecked: lpJwLWdr/OSOWxXmxSpkxMjMm/5R8wDav7o9IsMFgKZAz0a2o40WUqRxL2s4BHZuHq5fJLn3oC71zofOXQIwUhIbDZy25bcuFOlnuGnCczqsu/B3tBU5Q9YGIINgZx+zpfP52nD1Jiv0aTLpUGYhZ2g/QPF2v9ffomWjtgv+un3cxV7stkkqce85aJCOKfdNfNQN2ue08pIuqJ2p3xjBeDrtBwXXcSNNIfHsk6XVSdNilC95RBKb7BaUwQjIe0jQp2+Q/zVTJU+wJ1kx8Evyuq6nooWiwnJTCPMsUexfKF9iuiVln5xLFLpaYhyVx5Gl9Hh/Q8VvBYqgQfwVuYWtRg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ha4x/1pgKo7PFZiJpmXNqTzwKHhBSBgFkAwRHWwg+x72Oi6kL0wZR0sSuV65C9sHPfUUe/KWvyRwDgQOXRcqpo7zfqIKa3eUt/EY7zJZP5udm13aNS4cOzyeDlNtWvtCpQ4sgyilLUNGU6puyQcqKXnAKIe1W6kx+V+bTFTyS3IfMP4dRftvZMOi4nMndZ6IZ7PMjD1xvJuHxPbdcDQGRjnf6BqrdMYS2Pa+1W52+gtUWmjkm1I9ubZ7YRr/a6u9tCnrcC3j+aKBUH2/a/zc6tzQ91r5ESEuxDMob4UF3JI0rWVP6oYYt8F3APJ5ikkVO555iuV7tMHkIMlWt7IjucJea2FSgZUJ2ipWN2G7UGivxlNTshf/WWM6byaT8UrJ8xiDkEFaqLIhzjb7bAh1eMyvCnpjl6Jf0MMWH2uysMmG1JNKfOxAc6DSqkped8h6FJujGnsY1wEZcE/o9E3sCKKk0aw8y2Ah9Ntye66cYPy7fEV8TtGSbc0Uf+TCdaE7WFBatpRxqJaEj+eFNEfKUB9eqeaxBokZNeXTZuDROHU+2XVeQcxO3twx2zdfbXHuA5dDC0xVUEe1Ys5mAMcRGHBUiN1ALk3hxBQ3a8V0lf4jt9Tpsvrv01WRWKf5pMO0bMvJuN9Qt6Ac7+DXtAVsGg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:07.1379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b0b41f-fd45-4d55-62f5-08debc5764dd
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB6918
X-Authority-Analysis: v=2.4 cv=GbEnWwXL c=1 sm=1 tr=0 ts=6a179886 cx=c_pps
 a=V+mzYH1ZSfwt9Wwm8MCB5w==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=cbNQJ9GKAAAA:8
 a=7wNMokDlTEXuVYewFesA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: kgpf_iJsyr_erP5bwCkaysj2SF2ifeWa
X-Proofpoint-GUID: kgpf_iJsyr_erP5bwCkaysj2SF2ifeWa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfX0etYg41Ik4v5
 BLV7PALYnJ8VGwMMEKAPAfldsCiJvIgAGxE4ZxCp/NGaonYQPD8KjWnFTetQO2X6EdX/crKdads
 vw8Ml4HxNxLCejg8ysp9U5ZkJ4zUARXk/L/QHjRLGWAjkUlbP3h7TAAVZ3WXYVTSbPBmZTm8qwX
 BRS20HE2H6swP05KGpc1EZuO56XC9go/iEo3nbb751iVMtQezFjUljlTPNKz7EL1kFT8lO0jxDU
 cGe1Nur5r1wXtqcnEwFIA5lW5x4muinSJ5D6aVYreHRXdwCtWZTRMIWFrjy3mkfaFrQ5ITnDFrh
 HkNC+ueh9JZuJ2HtJak+hecZ2PqUbY1xB33cUkPFbj6W4o3vBiGxJq9w/+qhiW5Pt2lzEYXsphf
 eq0oo5ogdsNSNhtTNf1Am06p3Lw4jOALTYJmG/HeNAYjlV6jOjMOligFtnvFwCg9x0F4dX9h24H
 rUizZS1zUQGv3b43Z+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280010
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

Introduce `nvme flush` to allow users to commit all dirty data explicitly
to the current NVMe device.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 cmd/blk_common.c | 14 ++++++++++++++
 cmd/nvme.c       |  1 +
 2 files changed, 15 insertions(+)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 56529702a470..d3b00e10f17c 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 				printf("\nno %s partition table available\n",
 				       if_name);
 			return CMD_RET_SUCCESS;
+		} else if (strncmp(argv[1], "flush", 5) == 0) {
+			struct blk_desc *desc;
+			int ret;
+
+			ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
+			if (ret)
+				return CMD_RET_FAILURE;
+
+			if (blk_dflush(desc)) {
+				printf("\nfailed to flush device %s\n", if_name);
+				return CMD_RET_FAILURE;
+			}
+
+			return CMD_RET_SUCCESS;
 		}
 		return CMD_RET_USAGE;
 	case 3:
diff --git a/cmd/nvme.c b/cmd/nvme.c
index f2c9acba5c32..21ac9a6fac7a 100644
--- a/cmd/nvme.c
+++ b/cmd/nvme.c
@@ -46,6 +46,7 @@ U_BOOT_CMD(
 	"NVM Express sub-system",
 	"scan - scan NVMe devices\n"
 	"nvme detail - show details of current NVMe device\n"
+	"nvme flush - commit all dirty data to the current NVMe device\n"
 	"nvme info - show all available NVMe devices\n"
 	"nvme device [dev] - show or set current NVMe device\n"
 	"nvme part [dev] - print partition table of one or all NVMe devices\n"
-- 
2.54.0

