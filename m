Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16ACD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C361B8486D;
	Fri, 29 May 2026 05:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="EgEfC6xA";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="V8h++Xar";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="cURhNigj";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="nbAHLkUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957E983FF5; Fri, 29 May 2026 05:49:01 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D2584839
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3Zu5N2887823
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=qLU
 eKkQjr0JWjt79sLhP+mH+CmyPron+PxUS4xMEUfE=; b=EgEfC6xAI/q1MV6C3jM
 COE2EwWDlUAJEaOIS3iqiUCV4zkSlp30HEw+sGp9sGXUizZprcZUJ/9uzKEim2EE
 biLJQAofSbXTPM8i2Z9jmIUGFdyN/hAojgPe4Ka5Uzhs7jISJKrEzdpADE2HarQB
 r3K8wXFTJIB3JRW/zOJ0/xofbOgdMC3RR8YkppovoY0DD6JrMsjJ2YREFG5j5T3t
 4nCYcFWKqK4csvGZgeeVk6uFjBrnkwwPIcrZR6Lw5qQ663uPsL6ll6inlkjOI7l3
 W+H6WEBJ9iv68DCxBBalqXNPxJZm8+T59FUlqI5XqE2omTNDUgCCE9YTv2KaLE8g
 pnQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef31kg1n6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSlnBSLK4qapMSF1rfbJBWdMrp3DAOTEUIgUB/zsH5knHfIapvXBithp2J7MwBpVdj2mPGKxB9GaIpqb1Eewb1CK6zfmLoqPw/Gw/22EeXHcFnDlrvysTBMKgM/3BQk6Edv3FdYxSGOaCseIb+hHSRVOMGGDjPsmyGznGIvS2YXc5aH4hoMf3uMOYA0smaynqYoml74JuJb420nxpOQB0o8pAMT4D7UdEjwbFA6Sygg0P7+5lnDe4LwV9F8q73KfPavLfgKWLjqU3bfgjW3x2Dr538ybPk3QVp3Iv2B3v0Csx/tvn8CiwSwyc6OKgLN1Uu64c984Lx7vGuIM5XRrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLUeKkQjr0JWjt79sLhP+mH+CmyPron+PxUS4xMEUfE=;
 b=sHlK9u6NwABXo3qU/A5FlorDzN8BAcxXkQD2jxjfk6Y6SzebazzJJH3GDVCryXN5wnj/FcU8frHeGa7CLu5D0pfa4iqt4OyHNDxzu4NAmsNyz2/DJW6045Dq++xyJu5Y71mdWI6d6eELdbVn/CupfyN+fKeAuou5mfuABX+uyBmPOzx8spUiEmk5yOkUviTWfQZjv7nodlK5ogBIGEKf+uGTTUrmdaoDFJlt9jGJ5sy3zTb5sf0cWqaEKhCNickiQlZP6LTJt3XECe32hHknI3BlLLGvRWy3cqbx89HRqrTweOT31IFp7fb1ieEs1mKBLzcZkn2xFF5mG7Ki0eftiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLUeKkQjr0JWjt79sLhP+mH+CmyPron+PxUS4xMEUfE=;
 b=V8h++XarcIN58MTaEiXFs0soQX459qCQVHi1+qGiqCCez/gzsHL82nNzTu/SmcvRTN5CXwjcG8A4yRpicCl9C5FikMBoaM3nv5rP2Ocn2688KNPnqJ2Q9+VwhxvDrq/VlMcpb68sQzD2M/lQnJWBlAYVIdfVRMk5Ripkvj0LcW4=
Received: from SA1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:2ce::19)
 by IA0PPFEEF394D01.namprd16.prod.outlook.com
 (2603:10b6:20f:fc04::fe7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 03:48:54 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::5d) by SA1PR04CA0013.outlook.office365.com
 (2603:10b6:806:2ce::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:53 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SNVpeE3751999
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=qLUeKkQjr0JWjt79sLhP+mH+CmyPron+PxUS4xMEUfE=; b=
 cURhNigjJY0C4je4u0QEd/lXt3Nlr3iXHfuXhE5JWcPXfQJMgB1Un3B5NbL3xkFG
 h+/liBoQs9n7Xza5oL2QTAqD7t0U6wvt0ARZ7sJY4ER4Ew2OMv11pdp1mCllsV+Y
 fhTILDDpIXQz8uGM63tEOrZ1tJU0YjHLvvBwU+7/LIcgpQbLpbZjbIjiMLlGcFqv
 vPpmhr22LBmdVJLlj/NC+rXNmuDApXZxqVgm+0yrA7tAqt/84S51MIesrfS2EKaK
 SjD/UFctpkOwgcVXg017h+ewYNOdsgoMFCVfi8t01D5TzRCq+AeSruSkENOAaY6J
 mIFgFQexlEGomhkx01yRMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=qLUeKkQ
 jr0JWjt79sLhP+mH+CmyPron+PxUS4xMEUfE=; b=nbAHLkUcdnHL7FntaX2v/VM
 vsreH2Ttak8g5LOr4vt+9+ENVHTLuF7VQLtTQycovP21CBxD5ZrKzisiC/P3VIxn
 n+w6UG89AuwDwEkyaLw7gChGxdkZcoOYDFL/IfWB3ZPNZI6tUcAa/gJh6+R83vq3
 AIp0XRf7+icTCEehe6XcS6LXU3BbfKE4yOBOi+ifPQKKL7jfp4TGFOCTNrMJ1FLm
 OCzISb0K2UkSm79EnujJ8YCL+eY5nQaOl7pHgqbfrOSy4dKPcugnEo2e4xoBFb64
 W5fCkI3ALPUyrqV2+5HG7MF4L3pTDtJ0yB/1h1SvltYKNdp6sWhFSPAbPHMoYUA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81u0j-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:52 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id SoDLwZSCY5kHRSoDLwEdPL; Fri, 29 May 2026 03:48:52 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDLwZSCY5kHRSoDLwEdPL
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 4/6] reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
Date: Thu, 28 May 2026 20:48:37 -0700
Message-ID: <20260529034839.2075806-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034839.2075806-1-dmukhin@ford.com>
References: <20260529034839.2075806-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|IA0PPFEEF394D01:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b6b8c72-e76b-48b9-012b-08debd35340f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i/eM8wr+CwMy/X2PpMW2ZSj6VZ+YdONDE3A0FU56OFfcIyuWAMa3hdAflZECXZ8kXZAeLoudK+aq/G0CkCq3/XdKHLw7WqUEHv7xiDzotgjO5eAzZUSzCacT9zxC1g+ZCg5m9sXIauJqsL9BfBzezmtNCFRKuIdAU4lMQAK/MVn9bTpxadyT4KAPOuv4vO+sfynKgAfcWKaOSo5WW6/VpQQm35DJRqWimUo0dGcV4b7uvgVMczgJnIkHQDKv0prIh9KqZZYjKLckHGEd1pXu6oNN5eEt6qWiLhFwqMiJ1N+Xr+ZJnU0LixtvnIUro3vNQr1YLPnYKYiAMicnO3smB7H+UUv//nn6aPIoBXZvyc+v2AoOVSJWdZ9+oW/UDOuNAwUV/pMmUz3VxiKXphnpoNcG16qp1G/lBsuxwBFfqamjINxMF8Bi12Hqf5UiLjDYeBh7O45bQkiudYsfv6WrY5Lhlbbu2q9o3Rg7qZTFganBZLcycXbooTf6v+AE6WkW+l5gNnrvKg0Zgb3pVT0QGeRSx3KKgeocHcPyEFvT2M0HbdffzyPYgwUnazqVfqXViYFF8vuwr3Zukfz13QM6sIS/n7D2cqudYcxcGYTmJmu3CgQ6JtpiglrF3BArsCr64Ucon/RKrbPUOuP5wwRrDXE7YBxiiVioc+HhJR06YdVEiCrQkI+X+5sTrzHZvMkCit8wj1Uz3rWL5P6/uZu5/o7dE4Vkvjf9JaI6xLnJse4=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xR22r8zTVbgIGKjhTo9nhCDZ9/8Z3JDpeK+735c725WH3+fLtk362lAJtSFJ+ZktzPGDrkhQLBD5FvpqX69v8xhLeNU/hxLpZkiozBB70JxydftxxYUGXctyX2p84x/k+C5nsLx8ezUWA0NqgVeZZ+1maYTdeBOGnjz1knZNj+UCPYf1Haz/oWX5feZigY5aZTSDv1jJJPxU3DuFN66OUbT6RSTZtYjbRWRVVxaYov2CYJ/dbu3K8xZzU4Mf4aFKIxWDid6ryIEqAXPSYePoCB7NFmxlE0PvD+RhApM0RizKhZVnNmJlhyyYjPz7ELl3oU7ndk1ItOzvsQeNODMVfSdqSM/bArHJ+dWBgsKYPsuAXtU4NdI/vcg9QPIsUFS+Qv5vX0CuguOBT9yEMUWLdvRwZLQCFFY50TVFw9a7yMBhl9IHVrtNnSIIlkf0QjXC
X-Exchange-RoutingPolicyChecked: r6aR67HmgF6WmFwzyEQAfXeoFkmhSYkr8wc2+DUD+BDFxqZi7A8qPLKCRPg/Er4xLEXk7CDPtrAZvssCpPev6xYRknUD8yodU96MN2AHIk04Owi2YWBFt6zqwDCu8LerUvd8vReyFxo1Ahhef96JLp7izf3d30mVuTo3mZ22W+rXXyl+GuESxTwFKluUZmKMqh/g++kGFImAEkHnmky6pQ4Oqb7RC8QPOqMdB3vOqqVCb01Rlk9RmwOnIT6IlESlTvAIRI9wUnEsU0JKCsDFu5AkgZP9UQrLv9HkLGvD+hN9U/0x7K3kyK+P2G/LzAFuT588KzOqO2NTnwROekkNJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U2xmE6mhnP9OSJbGHnVPsRItMyUIG0L2HQbU58Yr1e0MraFpEdMDh6c1tQm7kxZOkLiojm+YXFAura3uqYCBkTyNXLBzSGIpGWrqv7+WA8IHvRA+3FV7F5s06pq5FWJWLOOkeORgRkLJno7mrQJhP0X/AVLgUcazfgSeccdH08iuUQtHXpWmUDck3ywMmn/siytBOPtaC9gaOJ0NGsfd/wiYXNrVhCnQc7DmCWfvfB//Aq033eXZyc0EYwdo8x9DalZWVN6rLKOOFEMpFSAjx5YEXCHZQ9nsWfKuXeHyL0KRRnN/7fBEm2GVtEV/Afycx7gNpWa46KPdghwkPiB7nwljKrdJanPZJBsZFeGXaAVyD4HgHM1LVkh2gjVltxkoC5qQYw/1aXvCOAvL4fEq6Vj0VTkYP8jUWSDqCEFQO+gAt474giUCz4r7+Aq36VpCGlvwW0m1CX8zOAzkbxyDVIb1ZPf8WOS2zs1nRJXFdNNZglCfU6aDUUWXtJ7ipmIt/oc1QCPrXHZgy+0tr2lqLHf8n6zrpW6OSaphYDsT4rhFgscnAed5j+dPzpfT79nC+zHEsPRUr69zWZCnUM28z4TcW5/GGmDqBkXPetd08yXFvyhe3ZkawtDPkpc2Q2265CDmFhm3DKbVPmqExC3CzQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:53.5713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6b8c72-e76b-48b9-012b-08debd35340f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFEEF394D01
X-Authority-Analysis: v=2.4 cv=KIJqylFo c=1 sm=1 tr=0 ts=6a190ca9 cx=c_pps
 a=gUoplhyZVfsoAH38zi7lgQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=cbNQJ9GKAAAA:8
 a=vSM5nWOnqLUKsW1qPdsA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: -5FDG303Yg94Q3a4pL_tCwdylZd9O3L9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX58RA/4opZKWo
 ZttdunFy1Ngn1doPW8Vql6eWOw+OOUZm35cQ3sMan73Dec+/5fUVjDWEigXKlGY9DmzswS5Cyz+
 o0Yagkyt9XIZgwqTHRilBAMxcd/A/UylT9EeV+6oZ8ZNxGUOt48uKkl2tnvXxfpNtMYpk/wxXzg
 FQ9Lg68WEeVY1oeyUhx4scr+jv+jAmhxgkrYFhF86f50CcDSaIOWE/FNX9ngyIZlJm6D8hVhsJZ
 2KfgxRqrtcmWQLVpaiZyypPbSp8YgMygWWWdp8vgDG4rSk62rrjsyLrkgevEJqr2KiFYPxYYz7q
 iW85rOQcqAOKbeTAxI2BoOdHd1sNtnO8GqKooQXRaXYpLqydUgjuK2pWhvQqoGoExYIZuRVc45K
 DUL/JVwqNXjFck6XnzXsp1k+kE+a/tzMSITTEaroSvrr4HtwqnEkXgmTyzqDgaNRppM1J49pa7j
 m44p544cwPHL9er/m0w==
X-Proofpoint-GUID: -5FDG303Yg94Q3a4pL_tCwdylZd9O3L9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290033
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

Use cpu_hlt() instead of open-coded "hlt" in pch_sysreset_power_off().

Also, replace the open-coded busy loop in efi_reset_system() and use
cpu_hlt().

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- n/a

Changes since v1:
- dropped unneeded #include
- corrected the commit message
---
 drivers/sysreset/sysreset_x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index c2f28c65280f..afb77d9c5c21 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -65,7 +65,7 @@ int pch_sysreset_power_off(struct udevice *dev)
 	outl(reg32, pm.base + pm.pm1_cnt_ofs);
 
 	for (;;)
-		asm("hlt");
+		cpu_hlt();
 }
 
 static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
@@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 	/* TODO EFI_RESET_SHUTDOWN */
 
-	while (1) { }
+	for (;;)
+		cpu_hlt();
 }
 #endif
 
-- 
2.54.0

