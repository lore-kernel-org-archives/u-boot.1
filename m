Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE55C79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 03:48:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD19F80BE0;
	Mon,  7 Sep 2026 03:48:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDNlTo0fZm-R; Mon,  7 Sep 2026 03:48:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A522980BCF
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788752931;
	b=TJk2GMtCVOxFFGWpBeS4Vo89FdZseU+734z+ikX6DS0cKo15OuJ57wcm7loLYuMgB2q+
	 9ScH3k6Ik/rTKTNkvMtlPjxhOqR4ZyCgfSx/KO1DPioVbPwmXHtjd8hzOrYQtJfqoIE//
	 PSANmzgXq6/SLAmsuc2xDFbcLB2Vjtayeza/cr2csurR/OGWM8F534NWNub6vsRVb/Ceu
	 QryVND8DPJuvzqWvVZR1lOXiiDZxIfFhFzGzlAeiDrizkaDWTXSQT2hHBM61w8XKJOTKn
	 QNPeVVhU/qpTC87xSOftvcKPfSbBEYs7hktbARHenUrSM1ugLutzAlUbnwMH4ZfoMoA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788752931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VvuKGVP2tZM8rN+QEinXiAQeyHdsGeGBiwICHNX1iMU=;
	b=p4Dd6CWIEGBl+j4R5Nd18RnhFlEttPP3AtuDSBQ2PXhsdeOCBgA5U0GpU5soMgD7+3Ws
	 lW9mxrNR4hiol8FDW/qnu5MMSkncqxz8s8vlgd/26FpbqYV/EYwGsTeqJtxEJ6RbEMY3f
	 D8SwYoixhFBH8ozijgJ9rSwweL2bUx/q4SY0vEYKx7dSRpBbw9ndfqJw2JnrM4PgIeXJL
	 HKWEMm7435fVeym2Mb9giXN3B7OkUR9ZTRcXclZXshrGO10HqVyOqbIy0KmE29dtRo1+p
	 6Y0MDa44awtKyGbg6yPK1oIH54+DLUqcFfZ6t6FyLDYd6HGr6zLkMMtGD7iimfEtS1w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788752931;
	bh=VvuKGVP2tZM8rN+QEinXiAQeyHdsGeGBiwICHNX1iMU=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eCJlYYS+grg/lXieUa3QNKoGNi9PxMWNNehLqyajcpB1k1Po6nYH5/ni35kC9gTzt
	 +xRPsvW0249BQ1JOrG+SOsJCRGiBerN+1iJb8ljOz1YrZHCtTvIKkJPVFweg7ZX1LD
	 8XkdnN3W55p1ajSY9X+Ol8U6u+Z2c31JkI0f0KXRpB+WeVflL525iJIFzHVJGDjYjA
	 b1NLXqhrSSnfe+edmkA4EG1x7enQULMF0EeZzCsBhrXn2ZZQhjYHpMu1VNx+ZhJx6t
	 OHpSISr3Njx2ttlU6zFZbJInwGw7OGBvUlZ/fKNHT3C7Q7dUMrjGw2yYkm8f08Znjr
	 +YdTSwzMlEctA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A522980BCF;
	Mon,  7 Sep 2026 03:48:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E83C118
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3417840580
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDq56rARAP16 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 03:48:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E69740560
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788752929;
 b=Q5e53wnijXTuzFx2v3w4GeSnEIQBKEkXX1BzlCgVzj3Rf3SVX8D1NP59/Dvp+8DJHI5g
 HcnuwmZQ/kcL1aDVOOK+S/DPtWKmIrKnsbdr3VAZW4ARPztNJ2dZFVCt7LPp05sGbXP+s
 gNse1qWSJc6TF+Pxe0DclqJTuNNq9Xscjid6BacTtFuwC0xf2ITKrs+1eBRRRQIZlhu0Q
 B/D95gV5YoQMkOMnW7Sr3w+WBXLolQ+Q9QnpLtalmYBJVRGjoEWp8USrelgeqBzwNGCUe
 Ie4R0jGQYgHUB/cetiF4A1oFonpAhaOe5fwxjJ+rGG4DjrFCEGl4WwaBCmSoY7zCpDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788752929;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=VvuKGVP2tZM8rN+QEinXiAQeyHdsGeGBiwICHNX1iMU=;
 b=JQDdL9VSnGezutpl2pbqKZ/rlHMpzDA1zYhD9YKo5otNJJ8eth+/phj/3vV0Uutpt2gO
 bvNK8/eLlHYVIGqXi9mANKbaJrtmV5lspm318rtwvVE6ENfx7BhkBdHuQHk+BpTYJB9DZ
 ZP3L8rArhvKj8OyFPosE7vAW7F63wKQyumk89kXn+DjgYUOPmP4YVOkxwAOxozCziJU3J
 5kOtzX55LMqtOsIxJOMfYPxHHWxyISE8SMXOpoJ1hy0mL2lVXnDPeoLlQ1yB87ehqSiOG
 9hQK/3bNIOmmGbRuTL2rr91KO1RWHrC+u1tvsoLon+K98i78cj6B8fdxF09PN3S0WWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xR3mC39w;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=xR3mC39w
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E69740560
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 03:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSsws738mDYHrUKf9HjadwsfaK5Jh5AI9TmY1vBLVR7qykS9Ah+b/tpJPQuDBMDeHs70lLTNQgV5/bjE72giE6qHDo/pczmkYXWTVnjNREFZBOpafiLNNNgt1kr5T+gmEbkRGtvGJwB+2nl3nK1j2g+f7p814oJeZqjsZoyfUCt61ws4jYEF6k4qRxd2EV1EZFvJ520IDMRG8WuHI0zCvuG8fkI2F/bnVKTz4s+6AStdOZH9eswtT6LpBXDpUsddvd1djE5wiqmECkORtukLpODfr6vSTKYsYXXIlFPEGmswOhCsUjx8NtxzQEeQqQxI0clJGo+lnEAoY7nqpzjxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvuKGVP2tZM8rN+QEinXiAQeyHdsGeGBiwICHNX1iMU=;
 b=LYtNGmneXlMzt6MbpRv0osXanRDYyUs4AnfjQqUlVF4M+ayT+6vxGQpov1rISJ5TqOnBLOv5PeKImr6MbysKv2ARq8hoSnSnEjfMYeAjtdXC68bu6OmutePzpIlL4hb5xeARe85yx958dxk6AX2vfu+SXvkEBT7KPT7rpkm+pSH3F76JVrclTEwA+6YihSdvqpdzp7vpSIXo18wNCbZlZjqaGQO6K0DH7YwrO185RTR3EM5n0kAOt0kVjGQBD8Y3FCrwg7m2Rf5DTEtb5AR9Gytc9kxiYLODZZNlx592fhsi+qh0Aa50hK+kXW0v0m9FtJRZEtleAxqAtMPVx4C4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvuKGVP2tZM8rN+QEinXiAQeyHdsGeGBiwICHNX1iMU=;
 b=xR3mC39wOOS9j9pKZjQZIsV7eESmUVgbCp++RYopSNwJumcZkZSkN2cecjWi6fqHJA/at3dH0Sz6W8tm4kT7wEiEiBD3gZRu+zVJUYI2i6bIp2ZHXOsDGpNVDsXAQdNhBD5ZDyD+rMvM2xvGZZbOKkESwQjLx6wiPVkFLMAk8lQciu8hnzp/DGnGmkDMyEpnr4Q7SuflW5ZJerLhYguZH9HlV4ZAT4AtrAm5tz07pLvj3zKaY54W0fEOWkhU3hYPG3XVsAJV0qMAm8h3iFlNiJ7PgKz2ikhGTTevxhum3Q9CENfREius9gHYXkpAKYvUIbn5g/W0PdUefWoHT6ORSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA1PR04MB12223.eurprd04.prod.outlook.com (2603:10a6:102:55f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:48:43 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:48:43 +0000
Date: Mon, 7 Sep 2026 11:45:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Vincent Jardin <vjardin@free.fr>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, peng.fan@nxp.com
Subject: [GIT PULL] Please pull fsl-qoriq-for-2026.10-rc4
Message-ID: <ap4zcCvivppeXnM_@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA1PR04MB12223:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a83f7c5-c24e-48c6-bb2b-08df0c92e96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|10067099003|3023799007|18002099003|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: 7pdo3qDgEwh2o/pBnXhoJoUoH6jo4D8iPdJaD2WRDQDXDoh5Htw7RsEYRJQcwyPoa3BF3yLZziR8U68jwOHzwBQhFhis7kEMm84CO+8LoIDotdZrMadZQYlD4ppAIW+vdt/7TmUyo9r1TiYzxqhVF6nQUSBONMrJPqBtrttly7+Iidl39RH27PN3dnsC5KmmFSmTfy4qYC4UUmgPgEFzCw2Qm/Q6FpSQ+N1QoVMIUkuMD54CEArwN6CUTF8OE/OWVxk8e894yulZJyynSBVWkMbMj+8FB0O7b2bh/8SE21FMqCCKOD/Ors438cryBD8W7YCtNr9oGWqlCbtqIKP4suU5M2vumjyZMu3Z00zrYZdNdrru+khhQsg9g/Zs1S1Q0L8W57/l9J8ZkoAX445Rm/ED3YubkZBD5QkfQ9l2kAPlcuxHJ4b8u0kPUc5kk3VWoozmuk8AzvYVCor5MXHxo159igKR893lrALGJ5uAUSKmz7QlN/hs6qt1+TsnnCf2HswlP0SAZNYGx2Gm6N5Hi+F4qm5a1SfnIO/L1zGtIlWNgnqgg0fcQnn9KtPhL7hCwxrQUFmuLHFq5Uaus/HOMut9gDaA3bWuwylhAs9gQYv1L42z+9epvoPlH6Ig15/yq5H0+B7FqoA1Z00SU32ZhPO3F1RwN13yazCoQAKHW+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kekQvel0Egh6tkLO0NPSV+1QYo8YC2SQ9CYti2ulA6+35tfjmi5qIFr6w35+?=
 =?us-ascii?Q?MGonui4M4AY2rdWNh0FmWxYV02PvNMQeG5R+gyCEicvVvHNcNxEvAfDNWUoW?=
 =?us-ascii?Q?QqcBTwdXQIi2xjDZBE8ByAKUKBfYJCMyVq71s9Xd+nqkKOdB9/j/1f5iBE4z?=
 =?us-ascii?Q?KV1hwABAjaKEY3oJTOTn7xOaUZ3KdhizaNv8IfjtSGNvDywAJbh8uI5h406G?=
 =?us-ascii?Q?3oaQwqL8NitMejmjFniYSNXTJOdq30F0HKsl4ld9NAjqQe5mpTkeyakxuu0J?=
 =?us-ascii?Q?QeMpghgErD0b1fql+Om1bvglVvRT2ktaP35sm7Xduk0mXHprGKH/tTCGXHBk?=
 =?us-ascii?Q?MbxHbMb1nt2W9dSaKxFf7vLiC0TF6NF5jaDHC9c9/f71Q6ToKH9QnAq6kMJB?=
 =?us-ascii?Q?uo/h9vZ8/i3uwgWCXRYCaJfYwtmEhlmnmboobBEuBGcWMHD5CIfk1fbUQpE+?=
 =?us-ascii?Q?GoLHi2jC1wYJpfJb5yfiIpsBjynpmbe+EATV1P8AVXB4aFOA+fyc02xkThz2?=
 =?us-ascii?Q?cH5wUnxNZKD+gy7tozVw00a0ZwnOYObVQJuBZp30RoWx5j4WiauQAE9OLLsI?=
 =?us-ascii?Q?PZBFBXc0f1mVjH4cQ3tV1/9nhZ6sft7JF072lLeqPRImJB+RLoT0MasVmMvm?=
 =?us-ascii?Q?whlUBcXHUh+/uljiAjemmh+sdshPjUgsp9a6CpB0VJEcskX0NXai+PVL/qhh?=
 =?us-ascii?Q?nfqwQ6HdquZAQknqSR2nnFoalMYYOoJxu0Miqp8T7+4PJrkD9helz4hlwGog?=
 =?us-ascii?Q?W5pMq3sxeXYyy8Uat2j8/Q+tCgMaYaXG+9wbkNujxkrtsdCOpI8tWgQkBCJd?=
 =?us-ascii?Q?fuOZB1QWX+EjBIcoqDK7dzodMpmRlKKUCluh+09JPlj2XRAXXYxL1/5peV6U?=
 =?us-ascii?Q?tUNG/I02Jf6C6Ponkwoux5LSNTuiC3gr/TL8WEYWuV5bRZgniGZnKMx2Wnhi?=
 =?us-ascii?Q?AtGLxdfou7vatdDFZCnIQftItGPzTrac0LUHzh2bjk+Dj8ZodSQIGp4H8I5G?=
 =?us-ascii?Q?e5oqntLmeOipjQSsBbM86jzQ4cTky/BAfDw7XNjLNftrO3y94mbBYVvqHEUD?=
 =?us-ascii?Q?5OFJiowH+XjLMnOp3p1mManX0+9fjTRwNBahU9xK1cYmQWONYIsCrVTwo4xK?=
 =?us-ascii?Q?dUnm/Ql2IKF/xedRITNCAr4cc7iByoVCysayF4n2En4m30u020OhrjzVcNGN?=
 =?us-ascii?Q?ytqrnsMjn1EoWYwioCjC64ZNA/j8ysXOU+wBsWV7hoAP9OzHKhgpUTW9Fuwh?=
 =?us-ascii?Q?gQVyp2W/+mpxWOwqy/AVvEXfWWFhpBNFIaVIkP12JFJHarGr3AtU3qxfThrn?=
 =?us-ascii?Q?SzgYE/m0NgG5EaR9SfqBntXFaWsNulcKLolkZs/Uknf5QzKLZOk9KgbFKN/g?=
 =?us-ascii?Q?lN0JQtgCGfDxNZVjYGLCz3uPgq2H+ZV/ufySmMYIMmNUzX+K1OXb0Tqgmpan?=
 =?us-ascii?Q?zKTXkq4HV8Pt+RG/6t8BufxtgTlYD1l0ZXpfxVchrReqmjyFODfE/1lBSpf3?=
 =?us-ascii?Q?vffQMVPDMIZNHfXHWs8seYkTIZk7FIIEEF+aM//AJupGwTcojLnaW6Guo/li?=
 =?us-ascii?Q?K98ZO1Z9I1a0hI286FWVrIiU4fqulIhAIMPYqBze238/GCwnTnJUchyhBsK2?=
 =?us-ascii?Q?EHeWWNn9oIQll60iP6QmzuW0xjCrrdr9CB3iwTni/XwFJTk5S/AuDYnnUXB2?=
 =?us-ascii?Q?YLRIh49+kqNHjA6g6pUubFgtIlIqpK23P2b8C5hQ91+FQQJ6iGRql8lqN6DA?=
 =?us-ascii?Q?AZLO15CkvIqXL9BB76u5TxHIBauDVNO830IaDP5SKFBQe3ZBAaak?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a83f7c5-c24e-48c6-bb2b-08df0c92e96b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:48:43.3405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naGUWgnWuVapVNfqgVw4A9oe1u69DzT7XBHJnVHvfgqgeT7peFmTPfr8hPkjnKBfKPa0RuNAWRFk1r2GzjjIiLs0CIKCPravKuhpJXTwEDqwacbOLCvCQxC9bzsmo+R9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12223
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

Hi Tom,

Please pull fsl-qoriq-for-2026.10-rc4

---------------------------------------------------
Various config fixes for Layerscape/QorIQ boards
Fix fsl_dspi by adding missed Layerscape compatible
Fix ldpaa_eth inverted error logic
Extend mpq8785 for MPQ8646
---------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/jobs/84506

Thanks,
Peng

The following changes since commit c46bd5b2136158d3380d626d79c96827818226c5:

  include/env.h: use plain old #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG (2026-09-04 16:55:10 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.10-rc4

for you to fetch changes up to 4832fe371d4ad2e6f112497b2b51a94985ac1b27:

  configs: ls104{3,6}aqds_tfa: enable PCIe Ethernet (2026-09-05 19:46:09 +0800)

----------------------------------------------------------------
Vincent Jardin (3):
      spi: fsl_dspi: match the Layerscape DSPI compatibles
      net: ldpaa_eth: fix error logics of unconfigured DPMACs
      power: regulator: mpq8785: match the MPS MPQ8646

Vladimir Oltean (7):
      net: fsl_enetc: fix all interfaces getting named enetc-0 on LS1028A
      configs: layerscape qds: disable ENV_RELOC_GD_ENV_ADDR for NOR boot
      configs: ls2088aqds_tfa: fix NOR flash write failure
      configs: layerscape qds: enable OF_LIBFDT_OVERLAY
      configs: layerscape: drop CONFIG_SYS_PBSIZE=532 override
      common: kconfig: raise SYS_CBSIZE default to 1024 for FSL_LSCH2/LSCH3
      configs: ls104{3,6}aqds_tfa: enable PCIe Ethernet

 common/Kconfig                                 | 3 +--
 configs/ls1012a2g5rdb_tfa_defconfig            | 1 -
 configs/ls1012afrdm_tfa_defconfig              | 1 -
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1012afrwy_tfa_defconfig              | 1 -
 configs/ls1012aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/ls1012aqds_tfa_defconfig               | 2 +-
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1012ardb_tfa_defconfig               | 1 -
 configs/ls1021aqds_ddr4_nor_defconfig          | 1 +
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig   | 1 +
 configs/ls1021aqds_nand_defconfig              | 1 +
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig   | 1 +
 configs/ls1021aqds_nor_defconfig               | 1 +
 configs/ls1021aqds_nor_lpuart_defconfig        | 1 +
 configs/ls1021aqds_qspi_defconfig              | 1 +
 configs/ls1021aqds_sdcard_ifc_defconfig        | 1 +
 configs/ls1021aqds_sdcard_qspi_defconfig       | 1 +
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028aqds_tfa_defconfig               | 1 -
 configs/ls1028aqds_tfa_lpuart_defconfig        | 1 -
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1028ardb_tfa_defconfig               | 1 -
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig   | 4 +++-
 configs/ls1043aqds_tfa_defconfig               | 6 ++++--
 configs/ls1043ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1043ardb_tfa_defconfig               | 1 -
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig  | 1 -
 configs/ls1046afrwy_tfa_defconfig              | 1 -
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig   | 4 +++-
 configs/ls1046aqds_tfa_defconfig               | 6 ++++--
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1046ardb_tfa_defconfig               | 1 -
 configs/ls1088aqds_tfa_defconfig               | 4 ++--
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls1088ardb_tfa_defconfig               | 1 -
 configs/ls2080aqds_nand_defconfig              | 2 +-
 configs/ls2080aqds_qspi_defconfig              | 2 +-
 configs/ls2080ardb_nand_defconfig              | 1 -
 configs/ls2088aqds_tfa_defconfig               | 5 +++--
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/ls2088ardb_tfa_defconfig               | 1 -
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/lx2160aqds_tfa_defconfig               | 2 +-
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig   | 1 -
 configs/lx2160ardb_tfa_defconfig               | 1 -
 configs/lx2160ardb_tfa_stmm_defconfig          | 1 -
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig   | 2 +-
 configs/lx2162aqds_tfa_defconfig               | 2 +-
 configs/lx2162aqds_tfa_verified_boot_defconfig | 2 +-
 drivers/net/fsl_enetc.c                        | 4 +---
 drivers/net/ldpaa_eth/ldpaa_eth.c              | 4 ++--
 drivers/power/regulator/Kconfig                | 4 ++--
 drivers/power/regulator/mpq8785.c              | 7 +++++--
 drivers/spi/fsl_dspi.c                         | 2 ++
 55 files changed, 50 insertions(+), 55 deletions(-)
