Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61BDCD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 06:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656908488B;
	Tue,  2 Jun 2026 08:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="BeuBsiIi";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="bXWS7FPH";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="N4QEnCZ+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="EsI/Qfbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25FB58488F; Tue,  2 Jun 2026 08:30:08 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FEC84884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 08:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6523MxW63188289
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 06:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=hhvHVcxklL4j21oMvv7txY5Nnip
 yTWzRVrZv0zss2jo=; b=BeuBsiIiv3HaebuJuJb2WU72MwaQPGnwZzcMQXhCxQU
 kmAf0rZQblhpNn71G1Wo0WI6hGCI9CenvPKYKms4zLqh79XaVvPuk1m7YKS3ka0a
 R+Vt3eOCCHmh1423J2RXAYsc+npkrQLZzZvwd6fWjIFqV6fPdkaCdTJ6Qlxd9dVh
 LhEETKO7XBrOz2zAQb+WuQ4Y2CNnpHircTXF9+qLUeQmenRJuBufdAZDN61SAP/v
 BWmJzDQv/BCcN8mdomdICiIVOpmABMhuyp8CFZokc6Vca64fZnrjPU2dWUQUVMEY
 7lK2qTYdhV4RxKFX6fPclT+Am+/jpTvqevOfX6SUZHw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ehq7mgxjk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 06:30:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ly/DoiW/ps8zDE+Bki+NWsxQlsP3YDDNsIaZVLpShQR0XlVelAW9xomWtJNufHBYx7v4dQV1Ykz9EvVqSBxVKX5ZnH/2YKpPoCNGFsYDbCWjMtw0Ru/FXAsMsLli3ThRkmtt+mnhxklmlAxQpRjSiTEvko4HE61IMC1Uiez/CRS88jZMOeIJcOPaCuW1YdaeWZsy8cK0Wf7eO6mAzDkWaV8HqqF0tfZS8oJMobzBo/MzknO1sKLi45O+0c3YhwnURAPur1QCf2LDO7jvVlOQLHGKtK0MG2Wk4RTbsSh+YrQa2+mQeB2D2vmcJJOeOj9GBu6fx/6ANTLwtmho1RBuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhvHVcxklL4j21oMvv7txY5NnipyTWzRVrZv0zss2jo=;
 b=OynpXhIyRfwdpS7JEhAwkBMg1ZQSnr1g40VUKB+hdQDaDMdkFBzEYRBp4mOuQsAZD/F44cHL5Tl3ov+ysTeXM3p7Pyfz7wL1nXvfCKcZ6J7U30Vu9E6qqvd+8+XzPencdID1zc5h9ufpBltSPykzFXSFVgSMsYFAKxQqso/5iKQthKX7OFBcYpcxm1f8OIwKIVR4uqYhvI8rx+xvfqd9/eJKbmYXebsVu7vhLp6JcaovZE76+UDd2VSngMoP51kmzpneDxaxXCkAQ3CThHP6DjUVApmIBXWHiqCJdiCnCK5jomrsJhsHFtCIxNuC6R6WGsk9KqNCMPWYVVRGR7bukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhvHVcxklL4j21oMvv7txY5NnipyTWzRVrZv0zss2jo=;
 b=bXWS7FPH3I8RFWwK0zY+mvFBTJb7XldZtbE5201yGFLw2SniwJvgV4csVNhUIiXbo6PHOS6fnJsgtItUtPV8t+jjRbw+rNWsE3jrVhP8hHdwy5vFmkn3k7IKfhfr/Igs91BINkVrbQEcZhJn0HPi4NENgdAlRx1mMuD0yXu5QLI=
Received: from BN9PR03CA0763.namprd03.prod.outlook.com (2603:10b6:408:13a::18)
 by BY1PR16MB6454.namprd16.prod.outlook.com (2603:10b6:a03:4b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 06:30:00 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::96) by BN9PR03CA0763.outlook.office365.com
 (2603:10b6:408:13a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 06:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.0 via
 Frontend Transport; Tue, 2 Jun 2026 06:29:59 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6523GStY1072902
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 02:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=hhvHVcxklL4j21oMvv7txY5NnipyTWzRVrZv0zss2jo=; b=N4QEnCZ+FHh2
 6X7XhU5W8TtqkuTXh77lSL7tlyD50bZZUFbiQVLyInFezM2A2uP/GSnKhYrHWCiC
 BSWwDxvGrA07HiJVhiR7apOGaQwA640A5cGkAkbvRUV+yeGaHuDX1eE5/E8yEHbK
 KQ0Xp16NDSa+YnlCIvSgCRq8o8akZpsm7CRI2NrtNCampW91rz0cauYT0437lH8W
 yRw1ei+2D9TlTE/0FDeKsxfU6I2fn46uUhm9lr1U92ZCzkNYHAujWu8zUOZxoT1u
 HdF5wrNOI8+aRhf2thUF2tdN4mayow1JbWWIXhS547CU8RzdopLhMyK6M+czo3JB
 c8TmQPATSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=hhvHVcxklL4j21oMvv7t
 xY5NnipyTWzRVrZv0zss2jo=; b=EsI/Qfbq4h8X6EH5LN7219vdfsrHUvxGH0re
 X3Pv4XA7u5fxUp7P93ZwW+AAB7F1VuKK/bl0cB8VUKJ5EBSbW9nuRB6+cC/CGWxd
 5O3ioR5dHjM9Vw62JhUPfP80KC01sNA5+mdr2T5Kt9bwiUWD4fTBpHYmmb0NMAJI
 Fb29rNLJmefI/H4J5ToTve3MygIhuZVIxx4c3OSyrigGjAoEugvxVvwWY0tvxXcV
 DVXEIYgEAjl9I4XXbTepq8N7/OLVtlKSV4Enn4pWDabOKUJpxBKigeacforXP6pL
 gIuOh/lMwvmnKAlYStCascrhMP7Q6nlwaaMmTCufErRsgIkwVg==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd330e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 02:29:59 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id UIdQwP2mvbrKTUIdRwBuul; Tue, 02 Jun 2026 06:29:58 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UIdQwP2mvbrKTUIdRwBuul
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Mon, 1 Jun 2026 23:29:55 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v3 1/6] reset: Allow per-board reset type
Message-ID: <ah54Y+7it06w9zku@kraken>
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-2-dmukhin@ford.com>
 <CAFLszTjYa_=jNmRXO5rbMh4K=uEimwBdq1HS1iNmtAGhznVfqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjYa_=jNmRXO5rbMh4K=uEimwBdq1HS1iNmtAGhznVfqw@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020058
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|BY1PR16MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1054da-ff9a-45b2-1f4c-08dec0705f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ez/Opw/MEbbd87JGHm2pykjQOUMWzx1ZtkC8ONwYxnojKEZr8Q0VeihiRsfVA9CVapWQtGN3AoZbgg/WZFuWQVTxazv4BDYjj/nbTC0jOmXe87lXOrAtG3Hm6KK6dG+r2F4KzC5Emjn9hvveT/Q7Mlt/zmwoKvLdCrtjdE8Tl+Zj38KQ1+bxbQHZReOwbUWJRaLv+jFp9YP0udyWlYJ8yPiFWINr6Z7QchujDzSYwW2ONMoqzUCaBOylApgpy79xkKUvmQBAI/akrrQqHWzlLuxu14VRe+l7bU38l+l8wSpSpLo1LlF8CJL3MtJyX41sfsHkAG5p4uTlD/RaFQ+WNcQ6fKdYHcXVGn5chGkzLejFtOaWS6tS5foi1YzwULcwhTQtdmnIYJ4BBLPwE3FZQ+CB7hvUnaOSf5/KpiH6ldANm10jSIESkgMp7MM1aIcDhwodG85x33a0x4HQP8FHLiG9f/cyOwDs/fPUfCoCCBj8UG2iTi+iphnG5/UJ5eeaKiEvPAwoQqgCSrdLw8jwEgg/SZYVRK6erCNHVNMoY7btsbyzHrr3dlMYwVH7XXQUBVY8m5n3cvWWqM21E2RkZg2arQF6sicn4JHNLvseWPmYlA5B1xz2QEeymwsMgVDXCQCkYfn84kTJIcmxycGLNBYtbraq8zcMrSjB0/iMjEnv0Mwek98RhlSnxKhvzQQvC3ugdOU6nJZ8IHwZO9Q34BV/ezgRPfoj3EZ/VcHkJ1k=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wJOz5uxmzlLBpq4Od1vovhuqe7I/IyKK6777k5HZN2Kcleg7UbtCQ+mrRqLeFw8IcQdslE31rzKjoUE70UWFlPKTx/XZvRN1okdxYbnF5EVm3/MftS1Yzt+hoOJw1jIfjZnw1Y+oJetH3KSXPD0ytVQy0mNXSgjVRxtqFKcXOUQMs9/7CicftDGfYTd3tWMFazxncV3hR5ChudaGW1n03VOZUeXA5hugCNGGI6O0oJHsn2rzch/MOzoQnyJaMi+VtgighUZL5a17wFkyFTSfPtFzoxtKDwOLzvrQMkzypL9Bl2QlQTQFvIeoIk0Jj6FT7f6wkVkI/BLJiL3eupMIFTdpLcjriIDI144jAcC7nAstdtKcRor647wPtFwo89rDQ1Hy381Di5KSJVK/hOYKqmMt2eTFTOkVgaoyZz1EGt6lE6avfRBDWzzqyRx0lsPi
X-Exchange-RoutingPolicyChecked: hOQn+9+HXpWCBYqXwX7BBWZpkLYfPpMJZW2YKFgAd7xp1SX3lMg2i7Q//aPoVDbmOd5bUxaHADrGshJtPl15fYz9meFeWknx4mJvQZgDJuL1eXogi+cmIusioIS8/eMlNzxPO24b+8E5PHgNFlsUrZodXQ4s4ChB7v5cCr9ickALLvR0v5NNZxtps4BI+eHPG1Z/8DE7tYsbkIprVAS3Nn23y76GdSkcRU8mdzCnpPNxDV2Yj9h4l8HdHhlsoAwyBl0fkaGCeews8MKfXsGRuOY2YvJGDUV+DeLIh62eu+BLxq06UXhjy7+J7EdD61aSfR//CnsrNvJgvckg0TR1yA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A4tnLHyA3Nem9/aqxak+6E7pesQpz9sbLIA89dg9gW5QAtZbjFvo3dtKoTC57pxcWhGFto3bhPa+67jx0xNsfXccNxd2/a2IOymnSFIknk+oIDvB5nhB7oALkc4Yc7EE2It7UIuowI40dN1UuH8iiM91ggkLXUbjzcF0G2c+Ov9lUdJO4xC2njrUOuNG6Y6zRoon2mTorwzL/28DsxJTsJQzCVzrWEu2F85vGdFqXbwJzYNpANVStBKzzJMNDX3xWamocDhPiAr5AnRy7U0RozFOFTzSNLAq5hzkKVvDN1k/VuI3mw4crFq0pXFtINhKOv6WJqPHt6FIkE/VGaLWgKlcPVKcECi2ihKhlTCAp62MmipX/Dyhq8G4K3xFrV69OG4UXOUIY53K1cxcnOzFgBKpCjrphMs1Hq2nGIzU8TjdHgugb+alLNptMMiRP8uiaVh8lOdimyLm2BJN09bAeWvtT/bX+sPKrfkltkfzcVX37RS8eZqAqhdOkWcdFYFmmsEx+2vsL4wz9bMjyLEeW9OGF4AfjkMQqRm1HKeW8bEXcYRJYsqaRt2eUGWG6Qbw2L2HguFTEwIHyBDk46FA+q56IPi5UUxujFU/61AyVUz7Dqg+Qb2/LhbeShQ7AfjF
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:29:59.8981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1054da-ff9a-45b2-1f4c-08dec0705f3e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR16MB6454
X-Proofpoint-ORIG-GUID: 2f1af_aHBwKzd0WwHGnLQV62kySP4_-u
X-Proofpoint-GUID: 2f1af_aHBwKzd0WwHGnLQV62kySP4_-u
X-Authority-Analysis: v=2.4 cv=DaMnbPtW c=1 sm=1 tr=0 ts=6a1e786c cx=c_pps
 a=NhzRQjsTkbCjHKaZ4k3NFQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=3vaZYHch1vSBohAQO70A:9 a=CjuIK1q_8ugA:10
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OCBTYWx0ZWRfX/uwyKpzjopCh
 szgeoGvKwAej6gRp4TEkZnjR8Fc1qKuODIpxUMNGHpceafzAUmOWscHb75RutL0zj7tKtX0iw6J
 hifbLbUAlk/28wA9aYrSjlIEn9jt+xCq28INarXtp96s7wmGN7SlnS25QXBBNHIVvq3VE3JdroA
 rNbKCBIF1sk7Or0HCCZY3XsSY6EGIAB1xXP7clMI/CKMkhvsnJe4eD/tfEZoZ7/aM+vn+sBX2gj
 XLkXvyT77+Eh6BO6rwzwxTXzM3mOqhK/GQjZq4FgbdhHHtUmllk9Ox36qNI8QBs0keZyDL/Qfbp
 r3a6i6PurtdSI9GajYXWaO0Eu3VsJzns1Mm1DU0jvrCFn1TTFOh2uU3U7wYADa0HMKZM7VbaneU
 ZSnRdfrEgTioLIthT/2Jul7gVof+IjX/D0ygbzLyLRYUH38V/RAxiEh77KfvQBuDektYM6srF9W
 ZhnsrwFBgbiSM2gYC3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020058
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

On Mon, Jun 01, 2026 at 08:54:18AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> > reset: Allow per-board reset type
> >
> > Some prototype boards may not have (temporarily) all required reset
> > types supported (e.g. only warm reset supported).
> >
> > Add a Kconfig choice to select the board-specific default reset type
> > used by the reset command, allowing it to work on such boards.
> >
> > Keep cold reset as the default.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > drivers/sysreset/Kconfig           | 31 +++++++++++++++++++++++++++++++
> >  drivers/sysreset/sysreset-uclass.c | 19 ++++++++++++++++++-
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!

> 
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > @@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
> > +config SYSRESET_CMD_RESET_DEFAULT_WARM
> > +     bool "Warm reset"
> > +     help
> > +       Reset CPU while keeping GPIOs active.
> > +
> > +config SYSRESET_CMD_RESET_DEFAULT_COLD
> > +     bool "Cold reset"
> > +     help
> > +       Reset CPU and GPIOs.
> 
> This is very thin - as is the comment in include/sysreset.h - how about:
> 
> "Full cold reset of the machine, including CPU, GPIOs, PMIC and other
> logic in the machine"
> 
> > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > @@ -57,6 +57,37 @@ config SYSRESET_CMD_RESET_ARGS
> > +config SYSRESET_CMD_RESET_DEFAULT_POWER
> > +     bool "Power reset"
> > +     help
> > +       Reset PMIC by removing and restoring power.
> > +
> > +config SYSRESET_CMD_RESET_DEFAULT_POWER_OFF
> > +     bool "Power off"
> > +     help
> > +       Turn off power.
> 
> Could we use the 'poweroff' command instead?

Will drop SYSRESET_CMD_RESET_DEFAULT_POWER_OFF in v4 and leave
a code commentary to rely on poweroff command.

> 
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > @@ -150,9 +150,26 @@ void reset_cpu(void)
> > +static enum sysreset_t sysreset_get_default_type(void)
> > +{
> > +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_WARM))
> > +             return SYSRESET_WARM;
> > +
> > +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_COLD))
> > +             return SYSRESET_COLD;
> > +
> > +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER))
> > +             return SYSRESET_POWER;
> > +
> > +     if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER_OFF))
> > +             return SYSRESET_POWER_OFF;
> > +
> > +     return SYSRESET_COLD;
> > +}
> 
> The trailing return SYSRESET_COLD is unreachable, BTW.

Thanks for the catch!

> 
> Regards,
> Simon
