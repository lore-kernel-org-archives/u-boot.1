Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D25ACD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 05:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB096844CF;
	Fri, 22 May 2026 07:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="vgFzx0mG";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="dAnKp3h/";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="nNUM0HTw";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="RSACLRHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B69848C5; Fri, 22 May 2026 04:42:43 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1550F846CA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 04:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LN0X571003431
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 02:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=w+9o+YkShTpQUYgmcB6XYltNj
 RuTObFNW44F+Hq/+G8=; b=vgFzx0mGAvrOY8Em9k3wFKv82TwyfVLJP4jEb4pdo
 nommMZDXC4YVLeTl+1JDisY5boGISPOGp2EY9Yvmw2L8SuCvMG1pPGz+5uLI9/AQ
 Ny/FzSyjQEoTI40pB39U38ZyC6XWVowdmAoJaDnMvdnCVAJfadhciT/T2MMg7eqR
 7/9Z8GjumrWUHnNF5toMw+0QRcU6K2k3b5RRv9+CR8l/vO1gCattyc2Pg4UfGVoQ
 taIzaJOvmvcLxNXs/tJVaMpxazYP1e63cryR9bXmVp6v4TIQmehxPDeBbSxUGLt8
 /EbjVS0cqDfoQvPZS4xDBMIFpCZHxRATJmJ6RwRv5VmZQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eabbhh1jt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 02:42:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eik52f5O+d9h7lwgeKqj3Y3fPbZ+ljQXtOS005/WvwNMeiBcA/XVFpfMMdjvw0WVi1lB9JwiWCMRIs9eUOduSK7tFt8Qn05LOoLq14VRO/Yv+ZtHoC32w2z8sX6UO+XrbsDK4AThRNaq1lUpzKjAnFW2mbOSKP8M4yKz3YBx7MO7iJ41aU610ebmkfZR9MTeoDue8OGJ3HKy1mx+02CSaVm+kOmMW1j/zXzpL/e/CACNw47+YuAWgebpVAskzBiLeTSSTBYA60XpTfb3gEpPocQ/nTOAs36GSKFRtJyEBuUjjEm7RIlKXJ0VjO7rsjxcROQt3qjshVweuQh/pEqI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9o+YkShTpQUYgmcB6XYltNjRuTObFNW44F+Hq/+G8=;
 b=ZKJP5WlVfFF6PZwyP1UZSdAfWPFmboIUvSP9JJTwuW+KmMEaEV4O+q7ez/Shijp2aLn4GfuwIDhfojMFCpPW1Tnz2j7gZo8MOG4pKpoUMuZAN01PGVDiAXl1o+8hZXfqp4pCGHvy7oYoFdg29vFZrt0B3PX8kqjDK1vnkUS/ToWfZU/ndeJpKjwDkV+dk8FCx/+l4YIBuA1+mBwa8DZzhX7d+YVoKJ6jJsfsrh0XIjscCgog1CG3ii/V2iRDwTIfsr+Db7c2X7hzdpjFowkSRCFlvGCa8sANFSHWcHZjyF9udzSTtyrJbKj1wBTgNLeC1C+9fHaP2XCKYgqhEu034g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9o+YkShTpQUYgmcB6XYltNjRuTObFNW44F+Hq/+G8=;
 b=dAnKp3h/mwP1DKTxl+XKh38sgluQRNN5/1f0Uf5W82/Fy9umc7z1BVPHSIktSpymH39CD6xrk2L6jl36Z9aeXV+Uh+xGdGhQthEujh7lPSK7b3zax0za1v2acQKH0FFvP9bWLBTdn1UdrL6sBXOw+qmDrsXxACguZHnCwdGU/ws=
Received: from MN2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:208:23b::12)
 by MW4PR16MB4854.namprd16.prod.outlook.com (2603:10b6:303:186::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 02:42:34 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::d) by MN2PR11CA0007.outlook.office365.com
 (2603:10b6:208:23b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 02:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Fri, 22 May 2026 02:42:33 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0eh843360424
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=w+9o+Yk
 ShTpQUYgmcB6XYltNjRuTObFNW44F+Hq/+G8=; b=nNUM0HTwadq3r/hYiY56VEL
 4VeKWVD7AuMqBibTOrsp+l1dKgkAavleKP/KO28TRy7AOdqVEwwuJLx+8qtdAT3l
 7BrMPwGkUMeSmi6+7R6IpVFUDW0IobDjPept1Ag5RxkSJmBROLTX4A5Je/IB0FI7
 c2kIxRqL/yRoS8nByMvQpdLGEDRFsmS4SIsdHdUXi7Wp6xm656JXO1oEv49Mr9Ug
 /G1CDot6tbOR3LWYCD9VlwgY6cyAm5aL0JqC7aGS70WggRGYWaT11hSFPkDsGNNj
 WFD1g1SLKCWRObjvgXd9ZL5sbqsiM/ydW+K+iC2TDsnmE7AaVBn9i7OB4FmgHOw=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=w+9o+YkShTpQUYgmcB6XYltNjRuTObF
 NW44F+Hq/+G8=; b=RSACLRHqG0ZOsLaJTLjgZCWEY8NKTC8I+Mte/OR435YKr8M
 uqJ70900cEywGLejwp4ix2grTaBi+vctVYrz/DXSMs9EWhMCTjsIPDE0YRTvuXW2
 WdZgTYzsogC3Q2g7aKyjq/n0Mej5wqZUv9z4DsN7t4C6+mD01r6scha3pU380DJf
 N1rstz1hwYT5fA4KddD9SJXQbsh7pYGJvXmrl3SMYK/sctsPtINp2kcyCrOJ7cKU
 KHcBgZIaD93RP5rd0fi7+futh+HKlyd186jIrZwO9wT2wAFStGwZfpHj5kRHzECb
 A9T1Gxycr0HKLeofYIQEnAYxJUQIhIj2Gx/Fldg==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eactj82wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:42:32 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id QFqIwE3Tml9zvQFqIwOjvh; Fri, 22 May 2026 02:42:31 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QFqIwE3Tml9zvQFqIwOjvh
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH] .gitignore: exclude logo generated file
Date: Thu, 21 May 2026 19:42:27 -0700
Message-ID: <20260522024227.2950976-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220024
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|MW4PR16MB4854:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22bfaa75-ea6e-4600-933d-08deb7abc6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: DLFnMuZyS5rEwJgKVCsvn4wx6RUwHOfyYirl4MtU9+JcRUA9iQt19iNiztM4lFecci4SMmpAjx2V33+ExVkaG4wiW3OJR5mrvbsng3maLqQny3ttzwxlnt4SYQWeoRXF42Mviq7r63YfwMZa2hDIdC104KdDbb9CDcE0wrVWdeudBshOMi3OcyChlfFXWx46y0pyEj7Q+g0Xw/kDKa/DgfgacwzMnUfY/daZBod4aJhtwijtWQVu75kf9cIHpcGPp5Ao0nyg9EWuXPqQRwb7695WOu8Hf6tQ5VxthRxEyyAApWrf+t4l5fzdiJ7HB2iHZNgjxa8muNFhCiEp8Stb+qn+DcFU1UVNtx+9VDcsMpHLwahm8HsbL7Hw8ZKYnAai+FJav4pGMkLuxPtx/1B0lwN9IDNeuWM19xgbOYEn82/l6Mr0DuVAFvrvDi4cEm4h24eUwClYQEKRmsY0Rq+U4mF0ukI04pb7+SDBko/lEH+l+lpI5jBPCCOOwUtN9+xPIKzrWY4nx0UdM2XNjD3r7ymvyk7z6O8tYGD2IJG4Zus4vPORW3BaH9qXGc7nXWL/B0rOqAIJJMrUtT0vaikQ92hj1q20a1gsnl2aA2Kf6Hl2WeMAKYhBi1jVazKaMEL9y0Om5/IG5I1v5Y9ah7vb2WOMSSHx4rRSiV7fk9ElimKXOi9z/N5K53aeT636s16QaNhtybxkL3WPVWDKwKy7w26eUoSIdYDGst1+S12vg64=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: su4/LyZYhC1IMjpiRTxsJouheifbEC8154rl8DA1/UXgf7iS2iLCev8TN0MWxyJN8aPpmczTY6kU7f4LzrrAlSEF1v/O8WhJH7tfMKQlVWt15suUlipiTo5OlwxhlY2u5F8IZUqapAT/K5kxWVIgVvb2HrGyaD1DAl+72eIS6wpFfhJOUIZFEVxJF1OmarKyoKzsDfbxSUHPlRyLodiyt5ly4bVRwICHCyw+bl3tNoe10i1mIunklZc9mlhjR+fG7UM4PU7y4WRh65JSQ9cvTzQQTwmVwu6zQQkos0Ae4Xy6bqAoRcH8oxdQROje6EPN5FScytl1RJZvk/j2ijSw3vksBpNIo0wucV6ycwA66e+f3hIJOXmvEMwDmjmtULuGu7Ks4Sa5RoIMvUhFgLNxry5+vy4y8d8g+gxQgFNjGOTO+wd+gfAnXbhMgUBclR0I
X-Exchange-RoutingPolicyChecked: VhRWZFXQ+NSKfEWcjNrBpK/BKeTjCFtIe+MBKhK6Wi89D3A9X5hSTzHp67xxzUwffj54m3jbCwsGyteK6dqsCD9xfATCF5q1uIJo3GqAayDqp17qKywSPugmWd8y12ZdY8Gt6rRfjqY9RSnfAxAxEYlEtlxbKznEdIiS4GizflF0IV5WHSajaNUXijF6P77pNEt+V0zof/RJ+rw2WYMf0SPwZNtIv2GBH6lBfhxqGBE/zbCHQU95WzyuR5Wo1dipSV9blxEhiqilqJamPdvOQU7HHJgJo231sbUjCWQ6XbKdgx4wtwH/V77QRSv30aRdWnp7HxswEHw1ZgG5bmqnEg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 71CGOfPkVODR1XU7trWC6q/YZtIrXg9un1HWrmI4rBmYW6P7KUTfhWNAzjD3O5n1WNwAo8g9NKbdZz1MtyX2gUjOHQDTmS6SVyPOOJ/Z+Gj/i/ujWPzS4+8PUeCZQH8eAw5lP+6wlrT9rh+JSPzjqAr/59O89PDJyP4oChQnK++qph6HTrKDya8dujW+jD0vO85UwGTDwPWvb4GZa5T98iuggAnt+Sp2TvF5bbzEk5OFyBJEPoIAbHKoTpS5VIds64kdQ/lc9m02EsqZAYS4VQg0fxzD4m8+a15q35Fd4qk8okX4Fbuw7KZL8tLo3K8rKGrxA3Jk5/f/23EM4CfoHzBIF81KwL07K40AVz8n+iq7VR2qpnImx7hd14bUHb6JCEp9Kdce0BGAhPUHQCc77rRIZexQ8FcfPMCSZT6yOoV2WNl71l7ANxNX1xNuZTbs23L16tcGYZO/UC7Y7RvVpMvhuf0qjxYLyTtc3o2a4mGaYjBd/LaA/YMkEZ0qOFd2gmHkM3llLaDa0hYNWU1RxlTxzgQQRpokgvG+biHa3TDbII0DMeqQ+PUUba7pOOnHkR482IFqVqp210ck6IdsJD3AOHkNQ2TTQX0JfYC+p2N9l5FiHVMAeBBKkiCqTNMWgoK9cZCxgY1IArPLUpWmyA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 02:42:33.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bfaa75-ea6e-4600-933d-08deb7abc6b3
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4854
X-Proofpoint-ORIG-GUID: ftYgAcwBoqKULYm17E5tbTSAlB3ED5ZT
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a0fc29f cx=c_pps
 a=z/e76aUa2pYXdP5U8KLfNg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=_nE0efwHwLixut1yhcsA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: ftYgAcwBoqKULYm17E5tbTSAlB3ED5ZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAyNCBTYWx0ZWRfX/DqyES34fvmZ
 wJUNDWYk2qJ6WAK1Q/0z7uNxDBb+DnjhcEykcRGqXuak78Z/L4Sn/Rwug6x2H+GcY9dwLcgAG2z
 v9I9nGIxauwvF1mtWWBcuTus+8bEF37sMk+WFYUMJb6haQzgd7knja1HSKtAlHvStT8mgB06Cx/
 QZUxl4Epb3e1qi3sSZibyDo+5Qmkdv/FTUF/SB28ZBQE5ffquGhCX3VOeCtFlfNSAUdHl8Z7NMr
 w4vnDxjAOB5l2oP6G4WiGB4kNUlbUm1HnE2MpSyfGk2bu8wylXXzR+nCOgqt+ggjfHfp4P7w1Fa
 kXie7GsQt9xoyLVGLyJ/i6MPBkXLLK/mHjGw83zVbjWn1SguEkWSxdTpxsnEiaOTDOSBJ4qjCpv
 A59uxGgIJyV69Wa78xvfSSYJtV9XBOtn9Y0hAT5xcrL7l872iCzx+fQfMouVSzxvm0ymuDGrjdr
 5Pe4MkrsOynqSRCXsNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220024
X-Mailman-Approved-At: Fri, 22 May 2026 07:02:43 +0200
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

Correct the rule in .gitignore to skip generated u_boot_logo.bmp.S
artifact in sandbox_defconfig environment.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index e5d22dbe8e96..d599d8f4e8af 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,7 +80,7 @@ fit-dtb.blob*
 /*imx8mimage*
 /*imx8mcst*
 /*rcar4-sa0*
-/drivers/video/u_boot_logo.S
+/drivers/video/u_boot_logo.*S
 /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
 /test/fdt_overlay/test-fdt-overlay.dtbo.S
 capsule_esl_file
-- 
2.54.0

