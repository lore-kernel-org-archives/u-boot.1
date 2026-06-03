Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4406CCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F9C84881;
	Wed,  3 Jun 2026 18:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="aaso/R9r";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aaso/R9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7071848B9; Wed,  3 Jun 2026 18:16:35 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFF68469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TqDR6ilWr+W6wvxL4arA9VoDsnPsQRAJVGfTa4hNoh7JuvwCrXQ0iYBa/5P/1K7+0X6qh7zr5AlHKf9/DIvSrj6FKsiGakeEki2uW2brQLz8zUSc5ETSSMdmqWrPEyNhY/pf8CH6ZejLi16U6nyrSiBH0uEIlrCY7xquubAmKemWc2OJ4aSSehn3bh2G3yGtlZrIKTTD5x4f8JAdzekVUGDTmsGhyM+ZsWkzboB6+QQ/HBwGU2cHE4MC/+Z4LmxnGFZlKVCouYGAU07jYyO3SZDFZL/FhZnCxT/8regYXfeu7j4+JJfbXENdF8qZdGOBpX0QuZDvC67CfEl4wc8V6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv3N8pddoxfP9j6guDBPs6KL8pMSlLaUr7WwP9Hl5ws=;
 b=jl25f8caadCoA8auVoQZm6okjkJtkyI13aJj2n0N11xAGBa6+IkTnTYiMWfq0YFM5J6G76go3yS0TnuGfW146nqGiCyhWCZYuPTDtALLJugv4e9PSpATdelK7vBtM3I1hl4CQCMI7zKimuVX0MJSQz/GYbbyRnTn/JeBAeDahfrm3b7gojhsjGDTfnOkmme/Mf277zZeQ4lcgg8MeGs5aYlP7tI0HFvq0cdWal3sl7OPYOfEzqOj1OP1YOFUN69C2VEn0VDLymUONyqiCxbiMSyUJmtWG2HjWXnnEW0x42AW8zKGbqKorpCfBAGSKtmycp8Z+AUdOCnNy/UypI8ARw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv3N8pddoxfP9j6guDBPs6KL8pMSlLaUr7WwP9Hl5ws=;
 b=aaso/R9rKu+IH0r3qE49H9ePf9Khrb5OiW/1QNb/9e7VbMbO8M2wHgDk0+YAMEMXUC2mSRaq8sr9SKC8OWrhufiIvMyHlh7326O9bprt9+WivYJQj+N+xmcboFgHUZ/U4oPwtWjg2pfFKVEP1NxNoJHtyW7kZ3vorsT1WOJaEZk=
Received: from DU7P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::12)
 by DB9PR08MB8649.eurprd08.prod.outlook.com (2603:10a6:10:3d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 16:16:29 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::61) by DU7P189CA0010.outlook.office365.com
 (2603:10a6:10:552::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 16:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 3 Jun 2026 16:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4PNnTm8FTK/3rMxmyqlBU4krWbPQmj8Jo7YE0YOdb6UN8qDrkTRfNh723CDRjq0CNV9PRdH3xvI5nR3aqrSMATeYRmlWSh7nOaIFZAMrRgaVdHQm88Jkg6iq6al1KoiM20LRb59SkayQ9Y2tB4xQVdP0I71iohgRTF+0no2Kf018vKXKpp/Em4ebggztVQy4S83GpxpKV+mKZXrZLlKrX50xza0dJgcDwGVzXVyzx7hYL4oWvDEc+HdUyet1wdiKKNYSHa2q3rjIeNPu0CaOoGs6rDeXPlQLObY2C8pGP7JFQdKyFjfGJQ8Cj2QB6sU2MI3ey/qAT9yn52hbz6Yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv3N8pddoxfP9j6guDBPs6KL8pMSlLaUr7WwP9Hl5ws=;
 b=TxFdz2wAqipsVNatPSIkdbArLjPFPauDFd+hRHDn27+hd5YzgKAgA0NLX4aSIVZ8eR6JUTuB151q2xp7FRy+h1gB3xGP+HG/McCUW4+dV7y/TuZEF1dWt6Dw27Q9pDWl5cdf6KKAKJXMxLpkjoBFLkESP2OvLUFne638Fo1zwZRpX/OgPwtNkJMuKj7rvlwbuAddjvroKVh+N7ZJSRbLXEmo82044ysOAie8HSPRtP+VMGBdzxObszmI13EhkfK6MABXc/dhpDsObPZ/a0UrHggulhVDlA4mleiTY6YV3QuY6Vg4Iw43PHhXqv011YKmGex1OqgkcEBZ2J+xchng9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv3N8pddoxfP9j6guDBPs6KL8pMSlLaUr7WwP9Hl5ws=;
 b=aaso/R9rKu+IH0r3qE49H9ePf9Khrb5OiW/1QNb/9e7VbMbO8M2wHgDk0+YAMEMXUC2mSRaq8sr9SKC8OWrhufiIvMyHlh7326O9bprt9+WivYJQj+N+xmcboFgHUZ/U4oPwtWjg2pfFKVEP1NxNoJHtyW7kZ3vorsT1WOJaEZk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22) by PAWPR08MB10240.eurprd08.prod.outlook.com
 (2603:10a6:102:366::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 16:15:18 +0000
Received: from GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c]) by GVXPR08MB11741.eurprd08.prod.outlook.com
 ([fe80::d47d:7756:5c28:de2c%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 16:15:18 +0000
Message-ID: <db435411-332a-44e6-9589-051d46667308@arm.com>
Date: Wed, 3 Jun 2026 18:15:16 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20260603
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To GVXPR08MB11741.eurprd08.prod.outlook.com
 (2603:10a6:150:312::22)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11741:EE_|PAWPR08MB10240:EE_|DU2PEPF00028D0D:EE_|DB9PR08MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3bb1f7-09ce-4e2a-93e4-08dec18b77ec
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|56012099006|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: BpGd4hYynkoGIWkBEYjBUhEtEFE8EF8Bv2g8DC2wRHch9pu2UfYEO5jD2H+keIC2TaflITZWauXneAxZTt4ZOoKWnrawbSiDg41NdpFRDKYVCT9UnPbqydAmJAxDkZtsNWSsqDwnekh5lO610PRMV+RBjI4Fb/bsTpr+l8JqFsjmc5mAgLJ/0yew9PTPRQBSteQ9acdYJX63IkJJFAd0UT7Pne7ns56RMJ0++C8R9z+uVPvnZZ3n0NIetsJKdpeavt1e26ukqyAA9JaNo1Wn4Mqzi3fj/nnrRJ/YsPfyu8hYZH78Foz2OxHqhkNFLZv9itraPRPJnpHxCtNi8LEDTcgINTOfn2vO68zkxUAqGEc2vCPj6/Wd1VablOQJ+Dg23H+tVtjMO5b+MGPipQfXiv3kw8JuhlFsR7uDxrWCNyuM+F73jPNOt//ye3I93j+yJn4c8ZTTMCw+E7BIyvppZ7JS1Kuu44H82hjZNyFt3Q7C6pvcrW92nGfc5lBMgiNOngy76fDlp33mNsZp3DnbCmzKyLbzo1691UP5kUvCq3kJsEDG0Bbcwww3sOXbigOH5+i//sVd6fKZcFPgDDgkLWysHSnWt91XDADI4x1vvOc42F2FksKRkxKy0HyHzxVxYGt/UUqgOPcu70rpHXWY+g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11741.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: r/UWx1jxYT4LKKSjf6NevbJf3GvEy1n++tuh/qIuEBlADYjxvd79e1JD8EbnMl2uAPaJzMEE60xrSoXIdSzBy0AC7pllXQi8We8XfguR8NtdU9x0mcp8wOxL1b9s57XygfbT1NH+rk98LdRjg4v4Gqu+n9cHn7hi+TQW5QEInDVtPoyJPgfWjgFV2CGrpDWvORrzsP+hyvjPXATsSDvxVS08I+AG827jr2mI57i53zjpLCs4Mua4KUL72vmbuM1Tg77bXTE0hYXKogixSnx2YMSMYbkM7QQJ4nup+HkA8yRs9ozo4VB2CLj2btnEsP1nJp6s3LSQA/Qd8x9qXMYZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1599f54f-6364-493c-900d-08dec18b4d35
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|35042699022|14060799003|82310400026|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: K5XvH4qBUpkxDb5fleV9Wb5juyt7udnATuhpXqRmHYdiEq5j9hCNUW02BabZ/4cvxDf4K7tYHw8Dj6vyQ3ccUgQbQPYedSAMY1BtgOFV1d+RskoHRF0/Lc/TZyVRFuZA0HYaR31wUadqVe7fqfXWlBIoNuHdtITvYLOHYfbZEwkOe59oDbYfYDxIy+kWkhVcNpwV/jmxASHBooLwRDQ9f+ztMZizERgm7nSmdfPCGvrE2QgARJwmwDROwwTsZQ6X1SIPVfNbWejfvA0PMxBYOcjabIi4+BVto0N4ZSSr2jDl24BSE+X1BfN11w/PFfqlFGQtzacq52ugwEjrhZgDeyy9JIXWIsLwmSTsgan6UHoaEzoil1YmP6BoojRnQNae9tkD81kq1VSqBEFs2gi96iSo6eCigHVAIZZkM5yeoEWFp+mUsn2n5RTMwmssTzBkRoLQp+8RHw9StHtwaOHASuUPGlZaISaE+rqj7G6UBBUliqV9RVIA8tyFEY/fo8AA24lF7telxZCgEmXPhbl1MQB4TncUFMhAN0WvhIQnPrS971G224mrNntuUFpomoFkIk1Ezh+40Ifiu2N0bAsCg7eSgodmjF40vhPzqEnhVyydjvkGLCgqc2tw+ipKNVTBJhCpkRYyywx9bVaOw1ZUNPEG3BO8C0220cbfcRC+h+uTnzpWTRb55kwv6TcpV9Ba
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(35042699022)(14060799003)(82310400026)(13003099007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dHfSDC6fwz5XufP6dJ3nXkc9cHsh0PYJscRFPbORBoCYn2pLK/IX1fZE23EeKgvf0jKsSsYX4fTMjFr3yuxLCxDwaKWilhmt+II3+gOGk7p/r9NrD/Ofe3jnsEZpoTuShoKQVkp1LYdc/2LY4Ehk5/Mf3Uc3z0+hkZg6irSzRTQuZ+KirKAxHroJz17kY6BYlDcG67YkN1UmqL6lBVHa7sPH21unoTOAsQ7ALDKOlw9bX55ESr3zU9C2WPwB3PMZnfl0gt/xaAty0rojt/jCut5CcIZKUnLLa5F4s1KpHilwgVH77U19sZXWlTaOyJoyvVUlYmyH8QmKXFgniWIytIBgCh4abqR+M0XxloJBJT33hoUep1IIdkMDlxr+/PJ84Ob8uUBS7OhmCeavoUxxuxjRQfSqUBaVQ9O72WSbyCc/LPeXup4guIqXe/rKLjrS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:16:28.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3bb1f7-09ce-4e2a-93e4-08dec18b77ec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8649
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

Hi Tom,

The following changes since commit 30b77f6aa146c96b831cb4ece038130b655b6a41:

  CI: Sage: Drop rpi_arm64 lwIP variants (2026-05-29 11:03:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260603

for you to fetch changes up to fac46e5aa7c448444764044467e0cceb9d12f3f0:

  boot: pxe_utils: Fix potential initrd_filesize buffer overflow (2026-06-03 17:22:24 +0200)

----------------------------------------------------------------
Pull request net-20260603.

net:
- ti: icssg: Fix portname buffer overflow
- pxe: Fix potential initrd_filesize buffer overflow

net-legacy:
- bootp, dhcpv6: Prevent out-of-bound reads and buffer overflow
- sntp: Check packet length in sntp_handler

----------------------------------------------------------------
Francois Berder (6):
      net: ti: icssg: Fix portname buffer overflow
      net: sntp: Check packet length in sntp_handler
      net: dhcpv6: Prevent buffer overflow during BOOTFILE_URL parsing
      net: dhcpv6: Prevent out-of-bounds reads while parsing options
      net: bootp: Prevent out-of-bounds read in dhcp_message_type
      boot: pxe_utils: Fix potential initrd_filesize buffer overflow

 boot/pxe_utils.c              |  2 +-
 drivers/net/ti/icssg_prueth.c |  5 +++--
 net/bootp.c                   |  8 ++++----
 net/dhcpv6.c                  | 32 ++++++++++++++++++++++++++++++++
 net/sntp.c                    |  3 +++
 5 files changed, 43 insertions(+), 7 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/30329

Thanks,
-- 
Jerome
