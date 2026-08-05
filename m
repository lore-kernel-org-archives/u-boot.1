Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3574C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 14:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D52140776;
	Wed,  5 Aug 2026 14:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cb_c5fU26ZzJ; Wed,  5 Aug 2026 14:10:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51377403F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785939024;
	bh=LI7qbcPEAJ7ECh+vzgt10PJwVZIo9zBxJviHeCy98WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z7y4uwW0gdlMlkN80m9I2tcR3Wg/00umHM+q+FSHgNpqMSS+qOx2ybIwAfznD9Chb
	 uM4sQpQwkBBtBF0rhoXdWMZe/ljt/7ujEg0uixqUHSbWInIYLrtIJZapGoNXHJQwox
	 O0UqGf3BsA2TGKH+GUnclY/rj6d+1MEnoSmLtPAOHFrJ0BQAlTi4+a4O38tei+F2N0
	 LVgNBqq4yhpH2hoVIN63z5tKBy11ugk7BQRnRlu5lgDp0mEMCvDZU2k3bvSrNjf0Kf
	 uPEjcanhPzPF1CIYsEQKESjPy64ZHU+CqNx5Rr9nQgt0I+0P9YfebjtM7BkVThCjCa
	 0TLykovTTbrjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51377403F1;
	Wed,  5 Aug 2026 14:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F13C9397
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1E6980C74
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uc05VBB_0v6b for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 14:10:21 +0000 (UTC)
X-Greylist: delayed 3686 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 05 Aug 2026 14:10:20 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2059F80BFB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2059F80BFB
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2059F80BFB
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:10:20 +0000 (UTC)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675C1hn22022434; Wed, 5 Aug 2026 09:08:52 -0400
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fue5uwgm8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 09:08:52 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ0wzkHXpK+Dg5Bt+Xi0DcVLfLCD4FVeOtwm69wWf7dPXf4vuiSFgPb2uQ2GQP1gac32aU70i37r261UZ4xEANW/FXCmsjcCxRAPCWhVgYM/mql1AhH+ag+ourtpxNHwPZZEXKYXvAYyAIGY0CQa9GXfsxzxaWZGSadFuBxfgw3jkHSOtjq2gCmbdGi6HLcxxWyy1ey2hL4cbksMGaQmmZw+TPd5xLPn43T2a/imMcHRRiKO3Em4xrBrrJWCLgHmB5U8BsDRIwiyJ5J5aWC94ukWq91/L/h3C1WNFh+iZcImCw1hgICQkYCQrYcavgYcwybG//MdBnU0Ka2PYrn+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI7qbcPEAJ7ECh+vzgt10PJwVZIo9zBxJviHeCy98WU=;
 b=RUYEng0J9z6rC6lYdMXoRnh50CMgEIoNXKxYu+QKNs7I8teCNKJ15zQJ+60JQwOyFEmhlj+sb8o1mNeLc6b3XaxL+50YFSyXXVWWETp1MRE8MQFELYp++an/LzJm08mcFjpHjm14/dNr9SJrwfEXP/TOqaR+Ee2jLD0THEwUtbX1wMgTea1UrM5Hc/yrCOgfuSeK1UFPH2TmZ8BelodU1eTMhcEKzJuKw4K4oslAdtzkvqvW/3QptsiVyNOSx0YA/Hz8H8Ks1a1RNaXkdAVov42yEdtWQZQL+an1JqBDQJLi0SDB6ZlKBRJ3MfVKqgYIPyxRH1q13ff5ajydgAT2cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH0PR03MB6445.namprd03.prod.outlook.com
 (2603:10b6:510:b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:08:49 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 13:08:49 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 2/2] configs: adi: sc594: disable CONFIG_EFI_LOADER
Date: Wed,  5 Aug 2026 09:07:59 -0400
Message-ID: <4a5c72ba9a9a9cb5b4faca56ed265880f83ce158.1785934620.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785934620.git.caleb.ethridge@analog.com>
References: <cover.1785934620.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:408:e3::35) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH0PR03MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: c211b4c1-39e2-4704-a9a2-08def2f2b07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wVHMN7WB0pzSAqcdBFtFy1Bf/w2p9NA0dWRyXQGxhkmT/UlzB+XV5YZjSmRsb0Xv/JVaKyu2E25YL+G19PQubryNUjy14DT/8nCqQw81IFAxbNmNsGXcjU42PCQuoxOpUa6gIE33RHW15LTmSZW1/ACvgduuwumzWU3fED7GoG+Gn9J0PRFvzekml7tv/Egfjn3EJE9UT+aO41bFP28zY9VLmhpD14MOnEnAfcqqqPXNexRl6pck4OvGPqKbN/kpiV4yMNOp2FnfvUs0JEVKHFb91T0lDq71L4x4v0Z4gYDSM5Z61DL72KdUY2g0fap5I0yfI7lbYgI/quG0d+V92622Yjd9Mc9yVp1VH8o3rcnTp2Y08tFmm/v/fDjcQycjBU87zsg2Uwg8wVNxtMotQ4KJ+TGhQ938+gwieTViArYhuRRidk5P5Q6x8L8YyW0xSzq+xnroI6Pcwf7rRIemK6SaMDMdVFpnVEEosPB7RXKY/cGL5Ml/CBngP9NbvuUxP/q4crLv7GgPV5OL/hAViukMLdGz98qgVfYPkr03B+y1chKVBfLatWefaVWGO93qF8woe4NfauPuT4f0L3u0mmHU4/8cqxBO4f9TjALDs8ji0XajtNlGOm9sgwYz+KQB0Y65mL8q7dy4fPCFTcJyD55q0XIJNejn8ZoeNuA/j+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T6pOUwA4rHYc0LQmlTvx6i8G+o++eaTiiAQawhGM5QPPjLEAf7UiJj78Ycay?=
 =?us-ascii?Q?a6O4cnfyLrwr3gCgK/SMh8Vs4n9q+ltOX010rbvUVzYiAE7ngrtaGbq3mgEQ?=
 =?us-ascii?Q?f7jJhFHyk/0sNffU87IciFUExK504gF5G4kE3HNed+h5xTKIlg+gu8R+H7/e?=
 =?us-ascii?Q?Yu17w7ETGxJY1npS4FCb+RPHFMbzjPzjUWB3eS5rzSJSIVxCUWY5Z1c/kFdf?=
 =?us-ascii?Q?rwut9J5n2BD9YCSjoIp3DK3ceqiSHaFCx11SUFqav3OjnXOwtD03B2u8Bmw6?=
 =?us-ascii?Q?iwD6Qs04UbgHTXwIaQV3H2l+GrMvf3WfyIMuMVB2I6/O7I4No+Ppnw9usmb9?=
 =?us-ascii?Q?wan/1UC/EfIbQKcc1O2N+QRwMdb+yfIK+sYVETCk4Gn68nOA4fOEXeR4++dB?=
 =?us-ascii?Q?bFr4eAHcXavIlZMYI/vpCj9LiulNPoT54tiO+7t9HNjeDFyXB8O+memp/CEq?=
 =?us-ascii?Q?PGKUIV71gFI0S7zUPHX9i7eFtNpOAHChD9rT5Jh77IGJ+8pvLpwvVBPqqU7U?=
 =?us-ascii?Q?dyjO/0442D42ysZ6L/vNLAVBLdocSDsf81dmX9NxKmgWSSo/OQdge6fKlywr?=
 =?us-ascii?Q?ZqlEdL8mioMnkOJNtJcyPfAnXkKM1wBAioRYPqO5ln1qPN2owyq8pBa1SfVk?=
 =?us-ascii?Q?qrdycI0odezxLqsDG/jSJFuRyXeJ0cT6hTieE1AGnOqMADEdh4jqjmhJ3dMb?=
 =?us-ascii?Q?ntpdpn3xfGI8i069s6Eg0y7AuFw/oSEFj+zsxB9Bwf5oG9e2G622bDcrhcNv?=
 =?us-ascii?Q?23NKb+EPHvRBQDyNHyXLQEjcbNFV1b/VQi6sgFnELN5jBZC+Bd0SF4Y22wQQ?=
 =?us-ascii?Q?XPnwcXD46rNkz0P2nXN6AImCpXFW11iLrtmuAx5GrxFMVddM93qx/aSwIkMd?=
 =?us-ascii?Q?EdUc6fZdLI7jkV5e52YIFx3xmZzY1/CcFfaOGpTZ9nIHHZDwPzwo/nc9g5FZ?=
 =?us-ascii?Q?PeDgmZyizboXSXm1jPIbUT4iKnCr+9FkLyEucvsbDemr4EDbRxgqoDN7VelY?=
 =?us-ascii?Q?f3aQHSNt10mmoKdLJuysPdRtkmlFlrjALWmSzfBrimSOyCXqIm8kiWyXiJjf?=
 =?us-ascii?Q?8PMDmJVzgZEFZLgAW5ctfpMFA7/r3AnC8/hJ2/ic72yxu3uTHfRxVO1sVsdk?=
 =?us-ascii?Q?wwF7Mv6wgT5lRewPddvzmnjOAc/Uawo6cBV8WrUPn0c7RDNs6A/FxtZDGZcO?=
 =?us-ascii?Q?NsvYIbV11iwp8PPNfDJjaEHu2f6kXnT+xLBksWg/O5E3bWQKSdhvS2GNvmRC?=
 =?us-ascii?Q?ydYKAoAqlp1oNb7tL6wyoHlVN58D3BC55kRqJvKL2VLobA8q3EpNb3PLCMAx?=
 =?us-ascii?Q?4naKQq+ZJF25Nhwg1bZeb2ixEp4inhLAA2/dtMRYCK6SCauVIC57jqmKScO4?=
 =?us-ascii?Q?DS1OCrwOLge3ucRPWoQDJF6fgiEKF+yqt3AMGlATnfzIEGiXc//HlrW+NqGl?=
 =?us-ascii?Q?oFYWt6G1T/hmEK0awXheMHsYE+9zj1qdI0iv+2GgHz9Os5aSyMDipGHH6FBH?=
 =?us-ascii?Q?dlOHGnw+5NK1TydG5ld+SmEfYvN1hQkTL2jRSMahyyMCBR4EmixePIlpE0DJ?=
 =?us-ascii?Q?6856x84g/3i2keXt5H+LsY8QfoNrKlmVFqhYfK2tfKi/6piW8clcKRrI1474?=
 =?us-ascii?Q?g0L6L+r+rWCpsb3/2aY3990mMI38ZXJH+CYtfi87GYg7WvWkuBzI0Yp360+h?=
 =?us-ascii?Q?EPQdj+yK/mPaQm4r94bD04+Fh2Qi9g0OFWbCcE1b765NAIhcZ/ikKbzpMHzs?=
 =?us-ascii?Q?jPiP6NmpiYHy9bnlMi9BXthKDcfzcCM=3D?=
X-Exchange-RoutingPolicyChecked: JjxQXA8hfUcUjMEZmM8TUkaQO2p8qgFAQpw/u234rvmX2O9u1H8lpqxdjGroV9uWr7/FuBF56mWlyzB/qt3iEDPDOyKVBO4WUhHK2kWaMUNHkz8ss8W6vdfZe08ANdv5MgQybZbH7VOgtA4Ug+PT1wkDjLPpP2sYGP1URggpYCpNaUcMokcrtK3TjArETNrx76+nV1fXeLRhgGosVE6hvsp9NBrlCfgOmZsUqPK0Z3i/LnbAklHkeM6frzOQB5t+LZncSrKZAX/XNIOXd4s03n86t7SSjYeFEYEFS6/FbHrluZOChp/lkGIZUoI0G7cRlZk2uMaxs9lp5Evn3NwWDg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c211b4c1-39e2-4704-a9a2-08def2f2b07a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:08:49.0791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jf9g1Wc4VFZSFhdnI3MKUJUI5vCruwxjFiLM1BXZv1CTMcmrCRdyBWiRlqomZcOOHqD/o+2F6RrU4xplvjSlaI82X9dOXCCjrFmaoFh8OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6445
X-Authority-Analysis: v=2.4 cv=G4As1dk5 c=1 sm=1 tr=0 ts=6a7335e4 cx=c_pps
 a=f30+ahQCdjj2/zPB7vFTLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22 a=gAnH3GRIAAAA:8
 a=PHwNFRM_nU-O8OdgQzEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX/F5geWteTINu
 txSgsZVUy7L9JKJm4CC57UVZIGTWppssYv6j6hLSMzKMvXyvuiOLlLL7/tS3N/APpjhk+FR6l6U
 IUffWlBceBnEnmhTnqDpuhZDntkJGJcQmJWCTNSm5L8Yeq3DIgoZ
X-Proofpoint-GUID: yfHVuujALOF9qVqzLWcNfIoEb28OPN0K
X-Proofpoint-ORIG-GUID: yfHVuujALOF9qVqzLWcNfIoEb28OPN0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfXz0QaB4q0dQVt
 IrRRvgt/A62RVykm3PtHriwpB4x2kzctBc+q5S6ftvqI+n+FgCq7B/CTjQ8T+2iCShVSJudpqeg
 bBcegoxOghscAH+cNR1k0tkVviRWgvZiLIlbBsIs91GT3M7TAmKKSlTVbHwNXgqZ0ZJ4YPgaI1Y
 sqIt5F4PutgzFG+U5JAJNIFHH7iXKGwmm+LedqMXsTUnzjmTLjywgKXI3HdY9rbF0NhipVg5768
 mlrcFFihXJBgbUstxKNOibb1jPZaj1/C8f+lM0A7+zNfD6Gy46kRpZ4kHvh9bW5aETIiFq37fx1
 MopzJdull5AvjInZr/6X6gUpAt+qamvuBsDMHkFpoW5Qkt1pSJyKwOiqOZf7d6fiX7mC4OsyOOW
 DFVlY4lNpuEfcWHSPt789IHFoSWIj9stP6cg+dVHUPNGOMKiUg2M5PrjLS0juK+5vALHeEYH0ic
 Aa5bPMAy0lPsRmizlpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=LI7qb
 cPEAJ7ECh+vzgt10PJwVZIo9zBxJviHeCy98WU=; b=NFkd7ftjnR2apVJO/ebl9
 UinmsOmXLARerQoPCLPQ7fB/fRkJi3fyd3MRkXKEeCwTZm2LdN6+Qd7MSRpZBIoF
 nyt7UN6pczo5GXcUqxAFJWm18NsduMeqR7BxsUePm6Y4afH0knl/fyTZ5vxM/pCo
 P6Nyq/UDjD4P/QSWuiJO6o1ADqpEl9G1N8RbovYhtE+0IsFwjO6m/Mf3K0P1mFj3
 FZBRIm3dfzHiEjWfrIwVA/9Irv5TZ7R8NUlrtYJ6Vyzw2seJzyoKG3KYCqlorxDZ
 9zV+oO3iq7ADVOyyg2hvG5paLopMFOmJye09l/d8mTeGDNYBUrj/r2QjVANDjhJa
 w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=NFkd7ftj
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Caleb Ethridge <caleb.ethridge@analog.com>

The SC594 boards do not use UEFI support, CONFIG_EFI_LOADER brings in
unused code. Disable CONFIG_EFI_LOADER for the sc594-som-ezkit and
sc594-som-ezlite defconfigs.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index c62097a2ac9..b157849060e 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -14,6 +14,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SC59X=y
 CONFIG_TARGET_SC594_SOM_EZKIT=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 39481351102..dadff29f827 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -17,6 +17,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_SF_DEFAULT_BUS=0
 CONFIG_SF_DEFAULT_CS=0
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -86,4 +87,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.0

