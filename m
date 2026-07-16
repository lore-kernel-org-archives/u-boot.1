Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F2EC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A1584DB5;
	Fri, 17 Jul 2026 00:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="pZ78j6KK";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="jI5KpDpU";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="TMKgVpcP";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="phPhIhTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA4C84DC4; Fri, 17 Jul 2026 00:34:22 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F5684DB5
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GK9YFA3145888
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=jz6
 M78yut0NBq/eCjNzihoS0IWZ8bcD7vOJKppLn4Tk=; b=pZ78j6KKlCt8mhD04+N
 gGwCil/IASWW8xJ4gY8rAczJGmL9NAjmSWqktKMxhZP5A/TjYeeCyYL/McL9cQY3
 /YgfgtuIXEaojyonvVRTsmc2IYxHzwvUjGNDI9IMCwgRhMxhob6jGtG7KPCBB/BQ
 41i/sjtkLJC371m4FjPpBeZqbOGm8l86k3g4bPFKTf7bHStMQPcPmdB/GYcWy1A+
 7gERWUbiOMBJVE++Cfpz0mfxItFo6BbSDsOPIzfipEd88Pu+Z31O+r/qDGH+NlxZ
 CyS3aKw1wseYwtP7S5UM6ypOXebLYqBznS8eXb7MHUoW4xB5bn9NzMVHt4Dx6iN1
 tOA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ff30nka5k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNoQ0cu10YOsTwP1yT63lK4fYDJdNjpjH9mvCTAt0speuo9u7tD7XY6V1gUPwArA6tm60k+KdKGA22WZwcVQxgWVl+G+51hjA77QGxEP1wvolsV2lZ1d+XIA6eGG4LwZHvQnrm+tqidJfDzPK0mO/yBAKeIoN1yW6q3kPJZg820GHFsMokzuzjhgtP39PCCMYk3hO5gehg+eqBUPjYeLuQlM/9eYzJRgJm7X7JhiXbmsKR2gc/XS2kS0RCGjqXebSzMYue2Z9Vab3PTn3xVShR0j6NedfZimKRd5SLrhWJLsH+zKHuU5TXbtKWGgigGsQCRL3afYohrkPNmZxopb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz6M78yut0NBq/eCjNzihoS0IWZ8bcD7vOJKppLn4Tk=;
 b=fraZySMEcY3VR4MPp+IKgludfdvkh7+7MBQ3dDyB80v8j/BONTPQ+tp5Zd2fzHdhNDFTXk7OS6o9+3Go1JWl7pt8ZRwqDBt2dUBpbZAvBoG1akURE+D0NMvXRjiXkAmmgdb117t4isGtJu8de7avBlUt4ywX+ue3Qf+hjL1Wi/a5Nd22ck496Ww/OZdBzTBZpnqYpq/OeEiC/4IL9bJo+fHLRfFPxFh5oMZPbWFFs9dRZomXhehvpza2NA6vSG+adj+Nt7P3Gr798aTS1G0QAx8UiQld3xgnGrYXSGv0nUT+Tbz5ZhLYt5GilX2550XscpHz2yRG3b/4byDrd2hITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz6M78yut0NBq/eCjNzihoS0IWZ8bcD7vOJKppLn4Tk=;
 b=jI5KpDpUwEttJtXZFOESB7aiR9Wc+cale97Zd8rfTNlLNqoGOi5yk5Br1KYGtgF6bPESTog/d6sG0XFlt0f8aGWIuWFS+C7miaBXEAlR+RNQt8u2QIL4PT6mQx8Eab91MPWWwsZ7cqTTyBwrJBHi1yWZUShhF9bPGeRmbmJQcwk=
Received: from BL1PR13CA0381.namprd13.prod.outlook.com (2603:10b6:208:2c0::26)
 by SJ0PR16MB5059.namprd16.prod.outlook.com (2603:10b6:a03:435::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 22:34:11 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::91) by BL1PR13CA0381.outlook.office365.com
 (2603:10b6:208:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 16
 Jul 2026 22:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:10 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwQDH2663716
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=jz6M78yut0NBq/eCjNzihoS0IWZ8bcD7vOJKppLn4Tk=; b=
 TMKgVpcPpl+wS01eBWA5LmXD2K1N9vGCU8P0/v4uuZTwVE081Vb5/TGLIP2aof0S
 0zv0ufp71v1GEkrM9hO+AScAU9m5Ox7JHCxTRA3FMvQ0xi16ITSCTW8afGnNAzp+
 OKvBRFdEQ9rwE5CY1sDoxx+CiQ1RAqtFA0veKcZc4u33SKty8gPb3I8I3sTUIkZ6
 ju70PZwtGd12R3fxv4VecN5HgteTOoPsEZevgpPL/30HSLPHIDXLCv6S9owvLthb
 J/NF+XUal1MWqoih2wMKWRsfQtV8ro4qGZZuBbvTXbT2nmFuvfy41XTJzGi4l5lU
 8Lj2te5TXthVpJvrZ/nyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=jz6M78y
 ut0NBq/eCjNzihoS0IWZ8bcD7vOJKppLn4Tk=; b=phPhIhTQOMNDagW95vfVm9K
 7p0fi0YCG4Bi6WGiC2IZA4Ykcd+JrBPoctLFh5ieP5TweeHVEQXjCzDePBXkNWR/
 yAKUtlzYR2L3aH4p4lnpL8e92s24ZnXDWS86Zt66SKLyIjSjOtTVfZaykz/5VdT+
 5n5ecN+9CGMNwDcbGt1P7JJjvyb5ytk97PoYjamxuJgXXpRnVh0DPQf8qTSOM9Ss
 TuhWm2fcWbqEjccN9298RpiztnuO3X2zT6erneirluHyB6b+cSlWsoQoloHtJglH
 EoPk9vzyV9o7CJM0bHeX6uCQXh2vnv20P2kF/hKxCn4TCZ/Yv3hNgMfNK8xLHSA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fc7qrx6uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:09 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id kUecwWCOvAJcNkUedwzXpa; Thu, 16 Jul 2026 22:34:08 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUecwWCOvAJcNkUedwzXpa
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v3 1/7] drivers: nvme: Enable Force Unit Access (FUA)
Date: Thu, 16 Jul 2026 15:33:55 -0700
Message-ID: <20260716223401.378989-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR16MB5059:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 147ca587-8536-49e0-435b-08dee38a5b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I0WYjPuM6dn5DGW8Ex2SJumkNGyJbcA8kAKWEtrdC5ERs95N1ejl+vrofjL2OdNR8b77NyGZ0vmafp4enq6Eov9ADevRzi79GmUuZ4K9S8giaVs0Ubl9cK7UmcAP/UGY4fmc742T1r+2LAlRSt0sT1uw/AgbZqyBlvblCmSVie3v7LxE93KfD4ewGYxBAk3GB/vRLpNDI0PFkQANViZt3qtNjID/uUWGQ79ASa3bWMhi4j201e3ZL9FuFcfD8w7fAnQwy5j4pCSnydaY27MuNgW5nVxgKiJ/cwpl6651hLV3nhiarflrEUXgYKvWsV/NMZCRuspqVftO0biE4JkUNCPW/WaSAU7qz8uZyB+wBrYR9HS59W/BG9STv0c4zOOImkQSFjKYLKtvalsa7nWkJly6U8WB5HcebG3ufDip86EvpZg8iHzHN/P0cncKCKKmPEztZTaKYpxOpzN4Itkhu+0QUitBBEhM4+kc7zYoR2vdoiKUI5tskYKKxmXkTJ1weBKvnMvTNPqUb0tklz0toRCpN8QrIFAwRnfnx+xlcy5ks5WyQgwenj78Uqz2Qoer/YnNb5s3+hsD3BvfFQ9fX9qjbKY9CubMi7Y1ypSvoXP0uomUodn5HFshKrX9qpS9JLVXF4lyHcspubG4ii83P/7vaaKDWsZWjKmZerhLmXqd/pAUHM5xi7DpJQptWSDWuROOeeACv0HiH14Sm5w79w==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 91iBhQOVuNXIrJkCb4QJeBXZou6luyxz3JI4Qy84xr4+imD8z3G6M3pkDZtNGf+q/YwQXZ9ehDMJf1qybkJ2tsELZGL6dj26MPSNcnbE/1y6Pf/4sftqlAbaQWY20uxWrnJDpLO7rWg6L/IGq1+wlNVtpxqGpVsq0hrV3h8adt9m+w5sD1vRCPv5+GBUnOsGd+hRklhhdkEcgqs9tArmIbT6Qm89bY/JJcKGGDOl0uMzSKE0f/Xq2szZ1z2oaNXvF4OZJo5C7mV/J1fK90eonjzJ57CS/kpTi8FyFZdGTNQv/nv7fDdI0QSdi2AokGR+0aN69JNxyqxNmfVsIO5yJRhk48xH+bI1TQtiK68VyYbJpJ65RNt4jO1qXYEhpsgt5tMoxbTycjcnERwMveBkyNGsxHsi2xDwmseIqiFdErOd4zplgNHKEb2MsKD7HTWV
X-Exchange-RoutingPolicyChecked: Utnk/PcxHttZxcvgHg62iXVV9yaTlV3tmUG2huBt0nOKds2c7Hsz56CgvKCb5xJv/QwokVHCBazWTN1xC/GaZPLX6jBPgEa8q6mb83QvJC83Oh1hcKqeUgWb7IbgD5l9ElxO+UyF5uFW2Ji2nOvUjVpl9UepGwXZtCr/xDm+pKQP1ktXiYdfqgMuXjxerIcvU8Or9a8YlZDOoR961BFB1wTzuHOfjFKpsO3nf/wn8zsoQhgo76GVCTal51MbWMGLEJuM+3bnH2m0ottVzf8yA5ZH01H5MBlRooI7hgjyvGkNrMflZy01qy30Ttpt3WbjCyLdcdAEusZeOYjDdYoL9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cfnFrI4hUQ01ttXsF1M6q8IImVX/EBthm5jnO14F9fVBtvbRzg5xYZOSzDN6bPAbgQHl/xUpMEAllV5DC62loz+GmOWgnTpjjXd4qZLCZnhrrjtCjoikoXd83r+G7jv8mMoaqB2n1eZebiCuUJrkESggoXrag/8V+FczKV9A5iZNIrp83W+bCBr0AOXTfGtjQarK4i9vey/OmVwyQo95xapZ79APc++f2fSSffdHr0nRalXdHBSG0K4qAkgS0/v983HcFLM2+T6zydnK5D0/xdBT/Wa2c7trkd5SWnbB+gjj2IGiXBCspm9gqmjd609I8eTK6x00rq1hC2Z5li58aCpLodvd9tRWPwE1V6Y0bau/p3jc+Wg2+Md493U4UGVKCvYXBnLLabKwh7UVjcNojtSHhKI0gti5TbaORXyhX2qeS5g282J/SQhy+5yZhAD79Btlk9lUo6ezS15xRJnQh7FGoOIngwrt5wHMtptDemROuU4aBYdqGahKyAqdTtgefj31tR61Y0DCixOoF3pY3B+3wVAGVu8cUKoLJD2pDz6e0UN3JtQTBf3CkearP6K0ebJsmAVh/3rqOSYiNLIcgL/szNi2+HYovIYp33fZwE47WJQcnE/THNerclKo5LvP62uUceI6FZorJLdsoDzauw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:10.6231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ca587-8536-49e0-435b-08dee38a5b23
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5059
X-Proofpoint-GUID: 0k9rhAKQgXhtbDAFZRNGo2TwrAu8VLRI
X-Proofpoint-ORIG-GUID: 0k9rhAKQgXhtbDAFZRNGo2TwrAu8VLRI
X-Authority-Analysis: v=2.4 cv=UaVhjqSN c=1 sm=1 tr=0 ts=6a595c6a cx=c_pps
 a=9H9ADJ10uJ0pYmVeXPB43g==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=s8YR1HE3AAAA:8 a=i5ItEkwz_ceUT8cMBKMA:9
 a=P0bj-C3X3jJDpopQwM1U:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXx13MwChHrNf7
 xRFaEbo/mXcO5n7RG8mNMrkOhTocM0/e1xShBleXy9CtocDqTD+BhY6M+53qyl4CTXydbBWmsBh
 3OQ5c4EyoJCoTW7BUbvjnI4B8vA/aM9ZhjcV8YwvHu/KRuK477Dq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX7eVAjLMYSCjn
 PwJmSGqzxww3bjtUSkx/UH3oaKpJuaAvIe0TUczT0zxpcUg6FVkbE5TSwVejBDWfJr3KrPSYX1M
 jZet6pdnpDrDpZpGhG1yUp5MfrPHLhl3U8UQbrW1oyntWFjh/DQbrTGW0d7nYz/uio4yXqKTA8K
 lqYiz6UN4/RmB0Y1bTqBesHeeKrxQKpuom471EnSLDzLNAS+i8bsVQ/o5OQmlfG1Y+SvlDAFV3t
 W6B5v7d66tdHt78bqtEPj88JCOBZ6JGIKJQNI0woGxCAx/Dp7LxMbQmRKKswk3KlPqDZKnRFW3a
 hcacmEh8bRo2vBmVdjIGL7xu8bL5ieBBkgMCmn5P3hYj6Uk8TV4Mxs3RsXurrDyCCZCyWzeMnl6
 kQmj1WyNa/Ev+qYZkm2RGKqw6SNs37V+I2qta0EGdFU/QFMD8gAg7dJae5E7g2oCx5Ob8uhR28V
 JCTUPFk0mfYOz63yryQ==
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

Enable FUA (if present) on NVMe devices to prevent any potential data
integrity issues caused by accidental power loss or malformed device
handoff sequence to the OS.

Original FUA effort has been started in [1]

[1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
Original-patch-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
I mentioned Jon's work under 'Orignal-patch-by' since current
version differs quite a bit...

Changes since v2:
- new patch
---
 drivers/nvme/nvme.c | 17 +++++++++++++++++
 drivers/nvme/nvme.h |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2b14437f69c2..7bb6bb7b53f3 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -771,6 +771,13 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
 	c.rw.appmask = 0;
 	c.rw.metadata = 0;
 
+	/*
+	 * Enable force unit access (FUA) for data integrity if volatile write
+	 * cache (VWC) is enabled.
+	 */
+	if (!read && (dev->flags & NVME_VWC_ENABLED))
+		c.rw.control |= cpu_to_le16(NVME_RW_FUA);
+
 	while (total_lbas) {
 		if (total_lbas < lbas) {
 			lbas = (u16)total_lbas;
@@ -899,6 +906,16 @@ int nvme_init(struct udevice *udev)
 		if (!id->nsze)
 			continue;
 
+		/* Check whether volatile write cache is enabled. */
+		if (ndev->vwc & NVME_CTRL_VWC_PRESENT) {
+			u32 features;
+
+			ret = nvme_get_features(ndev, NVME_FEAT_VOLATILE_WC, 0, 0,
+						&features);
+			if (!ret && (features & 0x1))
+				ndev->flags |= NVME_VWC_ENABLED;
+		}
+
 		/*
 		 * Encode the namespace id to the device name so that
 		 * we can extract it when doing the probe.
diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index bc1d612dde40..a938da728506 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -594,6 +594,10 @@ enum {
 	NVME_CSTS_SHST_MASK	= 3 << 2,
 };
 
+enum {
+	NVME_VWC_ENABLED			= BIT(0),
+};
+
 /* Represents an NVM Express device. Each nvme_dev is a PCI function. */
 struct nvme_dev {
 	struct udevice *udev;
@@ -621,6 +625,7 @@ struct nvme_dev {
 	u64 *prp_pool;
 	u32 prp_entry_num;
 	u32 nn;
+	unsigned int flags;
 };
 
 /* Admin queue and a single I/O queue. */
-- 
2.54.0

