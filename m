Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB86C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B492A84DD4;
	Fri, 17 Jul 2026 00:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="EoBTBmUc";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="QVlZaewq";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="L8sxtgCk";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="f/omQqI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7BD84DBB; Fri, 17 Jul 2026 00:34:35 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C8D84DD4
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GK9YiK3145882
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=8a/
 TwoZgaFlgXPxOOThJ7yLrmTmOjNw5TjSNvsqpixU=; b=EoBTBmUc//xxAzVyNbr
 kNmJh9TRtBFPM8zO1Ecfm/6CDy3Cj1koP9rgwBtcelmZCUKz2CylVg+2FHvy+53p
 i1nldVvWH3wtJeRhI0NeynsuwkGMCSQEjazFPELgLFqWRH5gLPln4AVU1IE7ZS5I
 lNxiA/fTjYF/tuzX+DO7SYX9RkbBXNJ5UjZokWYf8dERqvEMLxQF0dgSPg9eerCs
 LH0RXULgMMNogsrAXYXsmoAi7caoeqEIIjyR06lmIPpT0zGOAnDL5W7P4hjjBzNY
 FwwAioWe27tvTKpgChvqtFV1RDYL/I6VcMLnysKIBbQxJ6CKXwVl3xE61TWLvd0O
 6CQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ff30nka77-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIkLjeB3eWQE2SP7HVCsfRK+JCFcebgfTlTWaB/tNS42kU4ibxLu5kgfjoBUHzsJDVIhTiwoFROQa32/glt/kbJCkAmbOFbpkpzhmffazv5Oq/7K74is3dUn4Aq9Fs6p36st/Xzzk7AIDK/+YXJoFs8gtI1PdIMAvSkXRLO5DrWbME6vu/294s7cz2kqD7rZQZiOyQP1DtuKVLvX1ZMA9ixaiYRBmO+cNY4s7Hz6lN1/f9PHuoy8mP29pNwMOSSZjWLsWlWphFXepTfiPomkLSQ3jgcXjxrhd4Cd58uaqcej+h+ynAcWILUfCsgVwNmUrJ2MpeZoWaa5BfTx8rjyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a/TwoZgaFlgXPxOOThJ7yLrmTmOjNw5TjSNvsqpixU=;
 b=hBjmo+ZkpJoEqEjFbygXYJ4DGNp2j9mq9ztoO1w0WLuuI7edPtequWlxfPNLEuDnl2/NvQ8bhYKeT2Y2J4stSnC7l43LlmaLkTUP2q8IBOxbk7Xt/z9buvFjLeqJeSi9ehp0LRsBi1Ej3s7fGPUuXnjm62qYVKZvWlR+8uyMZTbLipURgiVy3sFyHz4SjZIfqB6W8e3mb9BOuJdSz9Trrli2SnKd46RVoD2eJUCAwjKMFoHR59gwU+TCW/USMktVZIQPTVN3XYHV1W+VGqiV4IYQWy7MFAIyb7d/CztfuCMk1IKx3fV9U7i/7xbQbP0m3Fdxp/WIt5QmRnnQOMVLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a/TwoZgaFlgXPxOOThJ7yLrmTmOjNw5TjSNvsqpixU=;
 b=QVlZaewqvmMKQqO4yY8WoNomhEgtQ63AJR9uL80X4fav6+Gxhi96PgkbGcbfQN9dNJziEXnWQ+lKUekbkh1fIXtKn05igolV/5IJrZ/KqzQd3qVaYG4MuMuVNETl4Od7D7h5h0DoKkK4TDTWtNdEzk3O9PVpkhsvuBKB8yrXvTg=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by SA1PR16MB5942.namprd16.prod.outlook.com (2603:10b6:806:3ab::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 22:34:18 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::3c) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 22:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:17 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwLos2637082
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=8a/TwoZgaFlgXPxOOThJ7yLrmTmOjNw5TjSNvsqpixU=; b=
 L8sxtgCkdANIKdTKCBhPTULfjimjIbj1d8sp8oOT/bImTEtLiC2yv8x8oOJsRQr0
 j6G/An7CKug16MjRKs+1MgFEeWoTwGntei/x9LpPy9P4fPeNOjxDJk/hzJH+TVVs
 Nhee+WtXqD1+1cqrHQLZes1gBrAgJyUzMzmtaeiyhAjYulW7D8OD0go+ToQ+vU/f
 cvbYBT/WQuqjFjCwzkUeFw6JlYtDajSz+7HAuZjZdWQfIjGGPNsPtcqetKvDEtVq
 ybo5jTM/3j8vgKMMyvPrQNoME9Dt7aeTN3A6Px6AFHijWGSkJv6Pro/ws6DwwhUs
 40HrezE4wZ1RtnTSmtW7hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=8a/TwoZ
 gaFlgXPxOOThJ7yLrmTmOjNw5TjSNvsqpixU=; b=f/omQqI79W1D/imZe7MFen+
 VVnxIQl6Q9U6OiBvCny6HGpDPFuIkbgPaCVpOmX9lB8PJzB+RCXDoIYUYemmaM8p
 h+ySNA39KYg+lUzi7e95YAlPdO+AdWRLUwMJQkfQPglma9ZPvvpt9+Cwtn/mFTyC
 MIS4pNZ03Gl58pTdoC3S09c1Pmn4ZkdxSrSXRvqSajtdidO4149bw1V0KZyhR0wc
 TqrFTBr3rMlSdUP4Wglza6LgpCH88CnnF7HAY7QiMKlWE7oB/rYTZbRTgKjkHZcW
 ZaxAhzAnPjUHYbPvSpOsYSmpX/Cypv1Sw7Xa/KdYxhbvXJe9Ibi54TqEWM5Y0fg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fe3euacuf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:16 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id kUejwF9yiuq5TkUekwAed1; Thu, 16 Jul 2026 22:34:15 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUejwF9yiuq5TkUekwAed1
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 4/7] cmd: Add flush support for all blk devices
Date: Thu, 16 Jul 2026 15:33:58 -0700
Message-ID: <20260716223401.378989-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA1PR16MB5942:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 14793109-1c88-483a-ce8e-08dee38a5ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: xHQ3+3iAPt8zntYZvUOq6DJ8MayMMnptXlWmbG9nYbzKMBvdc9VIRrEQotRdN9F8Sv+dqNZHMEiUb1SO/BvQ6/TnGLGO07w70Oe+GUG63Ha5tm1CTgphRfC+1ldASwZ1Vx8g/mFvgqoeqg0XbUUkihp8cgB8LcpgYpSRpgYb5N34h9Fj1U/7c653g7Ewt0gZj9/dnth3thgB42ez5wBVYguXKOTI48PN04v8wI+h7FaJqsOQRrV9Plach85c6F2nxT1/KG08w0yRw/Mz5VrlXr8M/IuL7jhKNKbegKborj/eWGZCbtq2PyuFN3tVqSMRUZ3graqbpgNfLZWKdspew4f4yLMUL0s4tU6zDMRDdkAAY8986Wi7jUbl+xrI7sqsHD3/Hi6OD2W1f7A5ooYIGNevnXSMhpT4ebj8MsEF4tlkm73T1R5XC76wR4auxn2jy/0jPrL/MVSCX6fLD5OweeP/zEMt/zaEjaQVbltPylxXps2ppBFte+RDk0PtTmF9RB+MsIfX389PzB06KJJIOrM1xTuow3UjJ7Wc8zgNueOuTHM6IKDDLpc5Vx/LtXDx/pk0vBiaNV0RfaNWmIsd4/ky7sg6OF5/aUhVfWuCXDE00d+lHquyPvss87G8c7V3hZi2ZBr98/Vn5d/RgaMOVOzN5ct6C1NkFHohw3+aEPKo5YxsVg+YfsiY+6pdv8CJb1H48tZP4+poWAj8M4iDIQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MuTfqO+xtUNvyQBajpz4/aSQLQFwu5kHu+1XPL/fyzv0Q4M8r2CIjBnrM95Hz6/bc4A/N52vNoDMvZJiI8+E9mR9JF0mTGngFyYwISngo5m1k+iCly2h3QUnrce6Uep1bQQ05oXkPJ0FfJyFDjLTYEc/J5YwfM8leI/ERicksmxKid446nCARnCDX6Da0lJH6cQPVdztT4DAJw8HD3XYoFAcyiahP92DS/hOXhTGyeS6uuePET1Rx1AR+4G40Y0RMW1bX/TGOhNDB7sTDoFc2+DkBACtlahVSU+6F0lvs/tqrd+ZRt77RZik5J901SRInkz8FMt/eWLOhvswYJzFbhWePr7QdHUSkjQXEj9dC/p0S9R20w7s2f3ziVZ/O2mb4qxdz7nbGdOtghZjDFfTXaEZ/YaXDo3CDtXWE4FcHI3znbalgKLBFRUrfdnpnlFZ
X-Exchange-RoutingPolicyChecked: LHfUraYm8id94FM8vgmiTnx4jZasDIBQxII12Tx2s6rguyYPtrCrNntdG5d8k6ZG7eA1kHoSY7S1CVmj2kZ1v5hoLXnuEi7rrEG9kyEvdfF++RyIBcaGotzBaXisPNFLwY0cnm0hSGygOxBABE1hm4bNtcSlYcY8//3/tpR3w4aSlXcU1Bb1FBEotLTmaY6nhGsT+965zR4w6VeC8tO3KCibqSTKvsNB1qyTEfZpXZxHoWIeB7NeyY/XH5iaOxZC9UWB69f8CX8Ytj745wWaATP7xKJ0DEtf8c517PS3c1jIHmKycjI5q0aqI/Fd5LE02Pt9Y9PofLxxv2znbVX3DQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s4HDgQdFHd0IjHX2gnZKkXP4AIUrLMHNV2m71R8Xw1EzJ+FA57JpngOy+FSgaZOijbOeoYcjWay3+WNOZnSB4eWUKD1CtN6RVlRPPmfGrRxtB5T+GHXV3Mt3qoFmiCKTACS9WA+WdJXUIAeyw7/lOyhAJT3xVepvvTEfScfidpepcpvoBdS3btFsCMr6hm93GyQIhcNmAV6KTudsEPRe3E2WwzXqJTTKPevYrPQnNVwSD0Ai5wDuCEYzdFrm6zo+pkWx0FV1X+strIBzH+YCkyhwUvokGAC3fJHdmSHoqguVu2xjXvqVNGGWuAngEREu/qPFCvb3qYTVD38oKlBkNPygRHPibQl7y3U1j6/9Do28yJQD1QayZbqxsa7pvZAxPeTQYgnHsnPlHX/GB9y08zy2PLQ2Qf2sw2Yyo9zYDVzeLCaPXXkCtrOVy9b0JWWWOfta/9js+vJEae4vF43vNC7E2PB/514ICY5lXfQto72RGV3yTwHCxsWvJm/X2emJrtd0r23iG+X95MIJKYi0jj5KGpYRFzbYmt26mrH0e/nJU/a9PfYS7CTjUcwKch22kHjEk9ljqOjlsGzymS8OfQhMY7E28gbhTfzUkl9oT4LIFd150uyirdxp2cTqnZZP7VN66VsevoHD0QxADHK2RQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:17.0084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14793109-1c88-483a-ce8e-08dee38a5ef5
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB5942
X-Proofpoint-GUID: 1iFb0dQhKIKatV_W7Egd0AdfkZzbyDIi
X-Proofpoint-ORIG-GUID: 1iFb0dQhKIKatV_W7Egd0AdfkZzbyDIi
X-Authority-Analysis: v=2.4 cv=UaVhjqSN c=1 sm=1 tr=0 ts=6a595c77 cx=c_pps
 a=3EeCZaq8L1ZepF5DamB/SA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=cbNQJ9GKAAAA:8 a=YrsVF1V-F22JerpZSZwA:9
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX7VErOyEqcn9e
 PYsSeKxlLT5+uGOAeOgEppTpXJhFbxgkuZ4IYG6OoKX/Jklli2Tr1y0HxpbhF/xUBUSghzrTCqc
 pE3GQIILD96vzg1DSMqdkt3nSwgenF2ApEIVlH/9N+Ikrzhwi/RX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX9aY9lv4K80U6
 ujFUZGfThD7Dmd9KxNMGQvLTfWVYFSORtUDUR/0aofMIcwELQp+5dTdk0GbKIPnF3D1nl+teoHd
 rnbSwWU1otVyOO3YK9+4oJeWu5W+JKy4+OA/mMURerVRwlxGo1UBq7ePcHNMuRl4ffBpCELCWDy
 Pmk6cWrNxQUDXubM6vn0h7zl+akC4go4YXOjj3MBR7Tkbpp14Epz/qEFtTVPB5RCqFTriTF8yyt
 tcT64gsH9A9lMm9cDzTBVD9StoupoLXjmZrys7ork503PM3adz2qWdxF4ZX9+xict5DtGxS8Yc0
 OIDM/0pVSY6Qy1xNXo5YGxvvoUjrfIy7AVI/HJ2iehnxKIKnxPmnYj2wtmx2nbjG5mgtPz+N1Rx
 Cuf/37Y26HvogPirPU36o5t0A32J1/6Vhp7vQ66PAfzwxNaD7a70UsTLY2sxpI7wW/BiJL8BDxj
 FKx5C95sCK6EDI27PLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

Introduce `flush` subcommand for all blk devices to allow committing
dirty data explicitly to the given block device.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- addressed feedback:
  https://lore.kernel.org/u-boot/CAFLszTgO6Gbg+TrpSwyTffPVjd5Pv8Pw79eq7RG_gj0W-E2uqg@mail.gmail.com/

Changes since v1:
- updated commit message
- updated blk commands to enable flush
---
 cmd/blk_common.c | 17 +++++++++++++++++
 cmd/blkmap.c     |  2 ++
 cmd/ide.c        |  1 +
 cmd/nvme.c       |  1 +
 cmd/pvblock.c    |  1 +
 cmd/sata.c       |  1 +
 cmd/scsi.c       |  1 +
 cmd/usb.c        |  1 +
 cmd/virtio.c     |  1 +
 9 files changed, 26 insertions(+)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 56529702a470..ea6c407eb222 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -37,6 +37,23 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
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
+			ret = blk_dflush(desc);
+			if (ret) {
+				printf("\nfailed to flush device %d (%s): %d\n",
+					   *cur_devnump, if_name, ret);
+				return CMD_RET_FAILURE;
+			}
+			printf("\nsuccess!\n");
+
+			return CMD_RET_SUCCESS;
 		}
 		return CMD_RET_USAGE;
 	case 3:
diff --git a/cmd/blkmap.c b/cmd/blkmap.c
index 65edec899e2c..828754cf6ac8 100644
--- a/cmd/blkmap.c
+++ b/cmd/blkmap.c
@@ -220,6 +220,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
 	blkmap, "Composeable virtual block devices",
 	"info - list configured devices\n"
 	"blkmap part - list available partitions on current blkmap device\n"
+	"blkmap flush - commit all dirty data to current blkmap device\n"
 	"blkmap dev [<dev>] - show or set current blkmap device\n"
 	"blkmap read <addr> <blk#> <cnt>\n"
 	"blkmap write <addr> <blk#> <cnt>\n"
@@ -230,6 +231,7 @@ U_BOOT_CMD_WITH_SUBCMDS(
 	"blkmap map <label> <blk#> <cnt> mem <addr> [preserve] - memory mapping\n",
 	U_BOOT_SUBCMD_MKENT(info, 2, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(part, 2, 1, do_blkmap_common),
+	U_BOOT_SUBCMD_MKENT(flush, 2, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(dev, 4, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(read, 5, 1, do_blkmap_common),
 	U_BOOT_SUBCMD_MKENT(write, 5, 1, do_blkmap_common),
diff --git a/cmd/ide.c b/cmd/ide.c
index ed30f9468660..3f38c1e633fe 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -67,6 +67,7 @@ U_BOOT_CMD(ide, 5, 1, do_ide,
 	   "IDE sub-system",
 	   "reset - reset IDE controller\n"
 	   "ide info  - show available IDE devices\n"
+	   "ide flush - commit all dirty data to the current IDE device\n"
 	   "ide device [dev] - show or set current device\n"
 	   "ide part [dev] - print partition table of one or all IDE devices\n"
 	   "ide read  addr blk# cnt\n"
diff --git a/cmd/nvme.c b/cmd/nvme.c
index f2c9acba5c32..dbccb69042bc 100644
--- a/cmd/nvme.c
+++ b/cmd/nvme.c
@@ -47,6 +47,7 @@ U_BOOT_CMD(
 	"scan - scan NVMe devices\n"
 	"nvme detail - show details of current NVMe device\n"
 	"nvme info - show all available NVMe devices\n"
+	"nvme flush - commit all dirty data to the current NVMe device\n"
 	"nvme device [dev] - show or set current NVMe device\n"
 	"nvme part [dev] - print partition table of one or all NVMe devices\n"
 	"nvme read addr blk# cnt - read `cnt' blocks starting at block\n"
diff --git a/cmd/pvblock.c b/cmd/pvblock.c
index 3a83ac9cd92c..5e4a98a6b13b 100644
--- a/cmd/pvblock.c
+++ b/cmd/pvblock.c
@@ -20,6 +20,7 @@ int do_pvblock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(pvblock, 5, 1, do_pvblock,
 	   "Xen para-virtualized block device",
 	   "info  - show available block devices\n"
+	   "pvblock flush - commit all dirty data to the current device\n"
 	   "pvblock device [dev] - show or set current device\n"
 	   "pvblock part [dev] - print partition table of one or all devices\n"
 	   "pvblock read  addr blk# cnt\n"
diff --git a/cmd/sata.c b/cmd/sata.c
index 8b923f9378b2..417e027cba4f 100644
--- a/cmd/sata.c
+++ b/cmd/sata.c
@@ -119,6 +119,7 @@ U_BOOT_CMD(
 	"init - init SATA sub system\n"
 	"sata stop [dev] - disable SATA sub system or device\n"
 	"sata info - show available SATA devices\n"
+	"sata flush - commit all dirty data to the current SATA device\n"
 	"sata device [dev] - show or set current device\n"
 	"sata part [dev] - print partition table\n"
 	"sata read addr blk# cnt\n"
diff --git a/cmd/scsi.c b/cmd/scsi.c
index 9f7613424e59..05850726a87a 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -55,6 +55,7 @@ U_BOOT_CMD(
 	"reset - reset SCSI controller\n"
 	"scsi info  - show available SCSI devices\n"
 	"scsi scan  - (re-)scan SCSI bus\n"
+	"scsi flush - commit all dirty data to the current SCSI device\n"
 	"scsi device [dev] - show or set current device\n"
 	"scsi part [dev] - print partition table of one or all SCSI devices\n"
 	"scsi read addr blk# cnt - read `cnt' blocks starting at block `blk#'\n"
diff --git a/cmd/usb.c b/cmd/usb.c
index 13a2996c1f00..3e156f54c50b 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -706,6 +706,7 @@ U_BOOT_CMD(
 	"    Available modes: J, K, S[E0_NAK], P[acket], F[orce_Enable]\n"
 #ifdef CONFIG_USB_STORAGE
 	"usb storage - show details of USB storage devices\n"
+	"usb flush - commit all dirty data to the current USB storage\n"
 	"usb dev [dev] - show or set current USB storage device\n"
 	"usb part [dev] - print partition table of one or all USB storage"
 	"    devices\n"
diff --git a/cmd/virtio.c b/cmd/virtio.c
index a42a563ab727..94f1e82cc902 100644
--- a/cmd/virtio.c
+++ b/cmd/virtio.c
@@ -44,6 +44,7 @@ U_BOOT_CMD(
 	"virtio block devices sub-system",
 	"scan - initialize virtio bus\n"
 	"virtio info - show all available virtio block devices\n"
+	"virtio flush - commit all dirty data to the current virtio block device\n"
 	"virtio device [dev] - show or set current virtio block device\n"
 	"virtio part [dev] - print partition table of one or all virtio block devices\n"
 	"virtio read addr blk# cnt - read `cnt' blocks starting at block\n"
-- 
2.54.0

