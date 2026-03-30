Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4451061B04
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB90583DBF;
	Mon, 30 Mar 2026 16:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Z6GEMUYO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z6GEMUYO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E660983EB3; Mon, 30 Mar 2026 16:37:20 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB3D83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IvR0TmqgbOgQv1BOBxN8DsJPyiGUL79y6aR7DVPq85HoSQHOxzv4C30u0eT7XUIaQYI29a0Jd2tYmPJoI286o5W343aKCONxur2kmQxC1SrAN1uAc9nHc1ngswO/lWCGq8dUdV+Ejkk3mRfxm4x57bThQl4HqnJDwsYUwYqrYAxtPoirwc3uGW6ogzx6Ew4rj8qMpFAmVGsv3hj87B/Q8yoouw2vpWLiWOS7ZLXvtyvB6JPb0tOGvhQT1c0ZY+bcQU9hVfhCmul16vajg9dqjmFm5m1l+XyIE7G2ZAbFNXrGes5GF/p8n33+dAGv8mDQyxJrs8xaIVw+11tlNb5wrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnKEsDVJWwXCVDS3kI6zkP82eTsns7eppcmhV6B9p3A=;
 b=PxEg4UfKN5rTSxWcaiVAMYNsvKcfaA02cLJhiGOkNcbniw1BKqgworwpKZ3Ify6nyOZ5yAClU4xj0OdbU3bVEsO9xiPYGCIwEu4IehsTgpxLk0wQ28G1LSVIaSX01xh8JzDwkwpQ+zSUz32/ZVwaWtOojkK5AjokU1u1Px/klKkrOnXLr+VXjtiS3Qn1s69JuwtjyoHoyVrkmm9IGxHZ2TTnmm7nT29DnuQ+vQmOSlpYns0W8mVmRRxPUtz6V+Z9FOnZFHChRIMpE5M9Sery5MCbQwYDVEi3rCdMIi2m3XYbDV3C5WO5f9vAD+qw9s9CQ5BqTYH6UGjGB6F62yv+4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnKEsDVJWwXCVDS3kI6zkP82eTsns7eppcmhV6B9p3A=;
 b=Z6GEMUYO383+A05RdHwKucRBr8YZRuTacz/mxf7mB7FyzI9VgoD1XPdk2ZcfXCxhmjn2QVW5Mx7fBWnaTVhMGb1HRzZEP2MwxPwZvfjxFKyQowKerK+YnUulfyU/HLBW83fjb6+ro3CS7tmuHAh9Wt2C3QEP4SpQttiQ5uAO8zk=
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by GV1PR08MB10840.eurprd08.prod.outlook.com (2603:10a6:150:160::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Mon, 30 Mar
 2026 14:37:14 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5da:cafe::f2) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:37:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlX0+fGtbIP2x4vfh6WrK7hT55vL0L5vuJ/CiauuqxeRxsiRWMlx15BB+Mj+hEMd7P6nuDH7nu22MdhIZ4uXqd6x6SB80V3pLPnU6nyb1rLlxhZ3/j636F3F5sBdR6qHU1PBi6Aoatd7F5W7KRTQF/mpeloys5Yi805CYzQm2EgBF8xYN8IYo/C2SljGHMgCAQdhCieOikGRtGj6xMiFdvphhOuoVrmyte9ORgA/89MUeWDwDkXRmfg0cxSuyWjyoxCFSGB9aVGegT4QSSNLnHzS+8uJRhbe3eKYD7Eqy2zNIzCdgsQMhbK1R+6ItY3OHEESdc9IJ6LJiTzGG7rSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnKEsDVJWwXCVDS3kI6zkP82eTsns7eppcmhV6B9p3A=;
 b=wENs6q14y1QjCnKIoOuexPKl1p59baryiGIm3itP3ZmcSBrAFiU2feHiPbTEZg1cbK4yRd3CWWzLvRtuY5Pk+ZldjXkflyMd2Xp6T7MGjMq4XMyZtgQIwa/ier0RtFjL4CqpvN4BqurA9U9hoXFePprr2PnI+boIB0t25uKCExrtzCHkPI1tJLfq1KSNH0i4GbHFNKfjYFZieV40Gypwpuj/Q+we1cYeiJn0MwUCerZD3XlYvrj0J6XW06di1mXx7WIsdww9+dsEk0/fX5aakR7raKGywfHwVZAm8k8T+QcE0Y9jQE8v3rhCTHz/Y3TpQsDthItNn+1MfulPlO2hgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnKEsDVJWwXCVDS3kI6zkP82eTsns7eppcmhV6B9p3A=;
 b=Z6GEMUYO383+A05RdHwKucRBr8YZRuTacz/mxf7mB7FyzI9VgoD1XPdk2ZcfXCxhmjn2QVW5Mx7fBWnaTVhMGb1HRzZEP2MwxPwZvfjxFKyQowKerK+YnUulfyU/HLBW83fjb6+ro3CS7tmuHAh9Wt2C3QEP4SpQttiQ5uAO8zk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB4PR08MB7960.eurprd08.prod.outlook.com
 (2603:10a6:10:38d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:36:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:36:08 +0000
Message-ID: <8a54096c-b62e-4fee-bd4b-4204248a8c27@arm.com>
Date: Mon, 30 Mar 2026 16:36:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: dp83867: reset PHY on init to ensure clean state
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Pranav Tilak <pranav.vinaytilak@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com
References: <66795e9c91026c8fc6d40703f200eedd62ada355.1774452992.git.michal.simek@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <66795e9c91026c8fc6d40703f200eedd62ada355.1774452992.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB4PR08MB7960:EE_|AMS1EPF0000008F:EE_|GV1PR08MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 59455a28-b432-40b4-dbfd-08de8e69d5c1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: N3mCKm9vGWCd58/6ZV2vORIncpIrWrbK9M2MAYaUeYDI+9gQSBBlibzgRw3TYXbh04bT+Lew65lZPi++dXFAt1KvoiWTp7GRGKNeOU7Icr6b1IbZ3Yo9FdO+D7lYdZyRyncIferkcJ3V13VWgsV/X69DP5hnNC6sg5vOvilhOc3eF+jZz843VkQDCkl4V8YgYg50X7UkJIt/ciGwK86m4Jr+lBgnIIi2Gbw4gwTObytzqUYD/pcAOBvx5Pp/mTA/olcsd+syNJDZgKpAsZT3hDnEwEHOegha6kfa621azIkeTDn5C9SrCk6ekWFGbjfb9OxOu2kpHhh08gbm28OQAgcR8ACQz1kCuCD8PFVmJaGF2dGUn4Sz4TXa3Xvl2mTKcDMUPB0mzs2TTdi4SDa1hhs9nfCJIrk+5rg5c6jYLXpBVwDTODEsqOkzzmaPX4B82rWR2K4YtMfb/8FlP1ApGUGMkSQWmKmUG6PYN8MjX3giKI0awUE/z9FJtzvKyPZnd9A2OyH2+EpVnl6crob9xzG2hRaBSlS3BMv6DdOEhMAzC5CPi3Zfp+RNW4QuuymQl58idLydrPDcEjeAry9evWZbXCpLN/v1iTyv34JvwxZ7roQDS8il7P/E0WJBXOVP53v5nax8oYB26v+43BZVmXBWcbtj8IcLMjFbkknszAMVWtm6CWKqDptDL1v8+5T7Ui8jLu5+tWj3aie0OX88/XZEVmkihjLYiiQUH0mvio0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: THV9vED8QgzoO4cypeqgl4e0ym3AgjANn6GcXzgBZUD/7diutN7sKpL9WiRigEVlkRTs3ZT0+iiFFFFdbRCyVcqfu/CbqI++LHurXdKoTYIo1PisxSRblN8uTNz/wl9xZXNW5vEQm58JGQ0Rh9DHL4ceECwtrsOrovLHrrdcSWiAtymDMfK9NzFk5plVSttHKkOF5kTAMep+3g65MjtO5wglkO/iV5nplQgtfbRdNp6BenUmpSibAy5oo3Fk1i/gyV+PDLxhpBbUAKJczhtIVcBQQ5Rcz/RZwTusuL4Qe6hLezt/40tpHgbbnZB7fXaSWuF5eOzwJhLRoDCVz00bVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7960
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5119511-d73d-4831-a16e-08de8e69ae78
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|35042699022|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iYNxyMyGnftM/cd5AwCdoreM9IQe6p6hBvYtviBxGvmF9fBr3i2SkX4pKFRJ1w2WMuXvBIOgC81bXZWrKQKL12HL58hU+IH1dYswuLY184X2XaWGcazbFhEzcwwdPYyguz9hzq9K8Us61e9kgG3xkjb8iJyJ/0hcjYNiXluyszu+q5xo+faOvlUn4CTA9EBx3RNdVGGWL6n68mPnrYGKDx/tjptfPA0+IqSr7ldsOrh0bGopTM6cbwE/p4nVcu4KQ/mLg2nEYrCXd0WwLziC5WcIdS3pt7bLpxP7E1PrEyv3ggJ4KEZ+xnI+9v8IZ7n0x+6p0YdXKCnJJkxkTZcr9L2RG5UVc6YtH098Hl7/cB7dTlX71Ex+TRAxWCXloHvmpazBeruiSQygAT8tyilzushs7gQFnteD4jOG71LV9vWvfVb8wi58Maa3WbhKYdC1zTv8lAk6OgItqX95XqOui36/TJMCeCUnmlTMoQZ7bLkmbR9de/54pM7CS5crmlOp5ezZ6tzvg+jorN2X5RELK1FbPQpAfxWFKFFX+rSBoJmZdn6d5+nuAO3SExLLu3DRR0Q2EOAd2X01kmDRJ16Ipz55YFotO/pzk/dIQ8a0UqyWj8iqyvtjuLoDxleKPGFRm12YfRykLPDnYTdNrtxwyIIK1XG7gd/baBRY49fIq8WE9ir1SyQ/gpTf9xcW5JlgiYMCYrrmdGJNZWRN6efhiru2qxg8HJHftsn8X2fm5Yl4v+waXP4jh7skHPZ0BtnR5jOmGUvmYJTkAUijBxaUNg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(35042699022)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JZCSEwwn2L3v2pOsxOcuSTqgLeQBufOv/ecYrmQjF7YwD+HK3p9jt2orpMBX5+DU/gBlep0CIuoD6p3VLHvPUCObkWuFZvyYa76qArSxYxuO2Ekv7MckVVL4Ge2V4OPoCpG5V30LRxsujiGJuOP3EC1qkMsiBN+Vc4GGf/KASLeEFY4O18NYbIyCPT3mf9lFeEEMj11qLFEi27wkdVAi6jTg4lJ33AV75JyQhQvw3ReUWUwtiS6iSj84LufyfyMDyyRVaqzrdlfc6F/mU/0tqAQY/qoh/o3jIwz2Rd9blxevrgR3LjSrw6ZSks3EMt8wC+jPb+ZeU7wTp/M910EQRHgWM0hoNynNGsqkszdb1lzoZqXIwi1EfubW0g6p6cbfkItVF6BcSKXyCsQn28zWTZeVYcSb3wjdyZBkRTqbIsmGVUoJK2kz9bl14JTwyhyr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:37:14.1157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59455a28-b432-40b4-dbfd-08de8e69d5c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10840
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

On 25/03/2026 16:36, Michal Simek wrote:
> From: Pranav Tilak <pranav.vinaytilak@amd.com>
> 
> After a warm reboot, the PHY is left in power-down state
> (BMCR_PDOWN set) causing auto-negotiation to timeout when
> running the dhcp command.
> 
> Fix this by calling phy_reset() in dp83867_config() which
> brings the PHY to a known clean state. The existing
> DP83867_SW_RESTART is removed as it is redundant after phy_reset().
> 
> Fixes: 721aed79126b ("net: phy: Add support for Texas Instruments DP83867")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  drivers/net/phy/dp83867.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Added to net-next, thanks!

-- 
Jerome

> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index 772cde1c520c..7ce03b59b6ab 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c
> @@ -257,14 +257,14 @@ static int dp83867_config(struct phy_device *phydev)
>  
>  	dp83867 = (struct dp83867_private *)phydev->priv;
>  
> -	ret = dp83867_of_init(phydev);
> +	/* Reset PHY to clear any stale state after warm reboot */
> +	ret = phy_reset(phydev);
>  	if (ret)
>  		return ret;
>  
> -	/* Restart the PHY.  */
> -	val = phy_read(phydev, MDIO_DEVAD_NONE, DP83867_CTRL);
> -	phy_write(phydev, MDIO_DEVAD_NONE, DP83867_CTRL,
> -		  val | DP83867_SW_RESTART);
> +	ret = dp83867_of_init(phydev);
> +	if (ret)
> +		return ret;
>  
>  	/* Mode 1 or 2 workaround */
>  	if (dp83867->rxctrl_strap_quirk) {

