Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4DEC01C1
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 10:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FDC8408D;
	Mon, 23 Mar 2026 11:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RKeKrhqC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RKeKrhqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E0684118; Mon, 23 Mar 2026 11:19:46 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89FAE805D7
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 11:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pF+ymmUkrh4hvP2sIvBm1agdkWNM12U+rAN3n7BIWlxdY1yrj0kqgLnIdWyzlsm8EohLD/A60NopnjhAUZmikDBQx0k8jiUlmg4cayqf0xz+NH4JWHkVzEtsVxNSDsTlQrqzALmY2r0U0gsuQlJYt4OXkbaVBFkrNCfo6gFUnwlnp2+wgasvQ+B2DvyRn94EvWr6PBZ/Blu26b8G3QgBRBeF2fwbykiYtC35YRMr1IvbS7zxoQwU7WgbqiHOTrtPPREkMwCNdU7BAelURrBZCgIYOKpA5/Sq/6IzJIKxiiEFqdtn0PxgJqfLE8pneJ64tPKtaM1LtOVFAxpNeTbqBw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSuCDoCAfVIJHqCki3g1BYJzWvtIIsW2tzuQFRG/vXs=;
 b=Nh/lpSK4yEiraZ4Mt6q2RkVUDyC8TLDtCAhKHGSzYfQ0VVgJs9ZLp0aRdqxlZuq5lOJzPVP7hLV3J14rNfzbrtbUYd3SPlS2YzGnV+Ab+M/ZBGEXQAxPtny+Uc1ngEt3aqIL8QihMllv3L+CQ+CchLNsLRx16wGuILhjPCByf0UzXKjwpJbBfBFf1iMQdLjqHo4Cf2i8IeoIR2MDKFHcRcFqcG22W5Mt8CwQTlvz/IImwA60RG7LcwmKIYldhkez60MhPVrI3mkuK2hawkScBJmREdk3l1wnwxlAOiTkAWay0XStk4z95gqKyqOkbSK7sl014rPzUKY7EijfUQ8A8Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSuCDoCAfVIJHqCki3g1BYJzWvtIIsW2tzuQFRG/vXs=;
 b=RKeKrhqCK24k9scYvTuJ4tS1KKRvgXdjgpjcuWUrkeelzH0mSBDC6rOipwe2x5dLzPdgvj+K/AdHy3di8wYGbDJAH+3xeD5PS8eOspvAJORgpJ1UgyV5SeoMDbWmPLf08kiwn3hlbxbY1fBnpEe3H6BLXfiV7TlIl8geXarhpWw=
Received: from DUZPR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::11) by FRRPR08MB11966.eurprd08.prod.outlook.com
 (2603:10a6:d10:1d0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 10:19:42 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::2f) by DUZPR01CA0032.outlook.office365.com
 (2603:10a6:10:468::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 10:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via
 Frontend Transport; Mon, 23 Mar 2026 10:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTED0Ewe7YfeCYEhAt/z+MnDej25Q4za7bllu9+EOKJ68DTLFhnzfdNvvc+smHSmFL9veijbBvn1DuxEYVR+yXfwH+GJhpWek7JQs8qIGF0ybdfmFU6i4cSnoi88Y+Ciry2forPkh/bmmzQB5tSj/O8jPOMPx9vMTCpl6pbN6ix8cd8nLYOGad137XZ4LGIJTzXhBNrEAkEo5EHbCZvVtKuJdUehVqdiBurVu8gdh5l1v4yoW2VNN/vCPOUnUC7zepAv9LoabJ6oLcTS8NW59HcgYN2mZOlVKYQBGpX7/CTv6PM8RauJ6FQMbCmrF2NVsS+pw9uXB4UckEZCwepIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSuCDoCAfVIJHqCki3g1BYJzWvtIIsW2tzuQFRG/vXs=;
 b=SPm+kfxQFkxvhPsRyAqwGwhpEbf9d+HVzcAhP56y4tz1FTNvF2eh2L4ptk9Sp6iBwxqwJtdLTKyocrRi6hphefWY0rXfFHcjFFnwW8ob3KsJ8A+7Hw/z+Sr/ArLgZWip7IDPpbbiV3zdZq1p/9OSP+Jh5LqA9BUzpIQaTP2ia16Tnz5avyKl1fgTF/A8tRZ9atFff31+vnc+BR1oBjK28UB/iy6/ngrwGeXSvC8UoXSvoLC3D6Iz3NIK+xQ+rHYvBSYZmAxBNrJUFTgsX7RgBzpoqsWyGHWHgmUbT997DdRgA+I53msl+cz6tDrspqKDwh6+2+ZBLghjoxYw4IwjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSuCDoCAfVIJHqCki3g1BYJzWvtIIsW2tzuQFRG/vXs=;
 b=RKeKrhqCK24k9scYvTuJ4tS1KKRvgXdjgpjcuWUrkeelzH0mSBDC6rOipwe2x5dLzPdgvj+K/AdHy3di8wYGbDJAH+3xeD5PS8eOspvAJORgpJ1UgyV5SeoMDbWmPLf08kiwn3hlbxbY1fBnpEe3H6BLXfiV7TlIl8geXarhpWw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8287.eurprd08.prod.outlook.com
 (2603:10a6:20b:556::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 10:18:37 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 10:18:36 +0000
Message-ID: <cef6f0c1-d357-4960-941e-733095940b09@arm.com>
Date: Mon, 23 Mar 2026 11:18:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: lwip: nfs: fix buffer overflow when using symlinks
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, nd@arm.com
References: <20260323094437.138927-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260323094437.138927-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0068.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8287:EE_|DU6PEPF0000A7DD:EE_|FRRPR08MB11966:EE_
X-MS-Office365-Filtering-Correlation-Id: b8761e5d-ea6a-49fa-8722-08de88c5b27e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 0JoKjn2hHRwHqUG+SqU2KvNaiBwctMcDp2WiqJ7BYHfThsOgDIkMIsnOryIuils0+KN4HSJxVjRAQcmzJ+mbOLbSmQf7Su5AYI3wOyxTfPmub/7fIoqeqZeaRO+OX0MSXMETJ9RLT4u67HbdNTdAlr/4fw3gGc2IBmFG4V10PHHYCISzSJVkuQ1QH3y+4AV1t2rOrZDgMgkmRgd6QeOVHZUJi6dCryGPzHXA62eIBopcWXtSYHFU+1PoQ2mp+yvKvqLMfdWIOUN4zf44tIji1V1OxGV6YqASMu9Yx1WiMowOdr1oDGyEtLzCCER3rD0akDSm94qhvCnY8Cswy6P58PTWuyCRzDY3ukr+uWZVKSM2ZZOOExbJPiJZMHxCwO1A4clM/PXJbn6GiUJAQgzGfB2fmyzBelCHqbg70dPGAC5c3A+IhtYLGSf1VEJnhfVu7ZhpHG9fw0jBB0pDLXf4tNC5r2Zz/QbqeA/IUpJWVi+YqkVHQv3/nI9EXq5pbcCb1V4ORbFCFQLzt6UJNFwFn6iQabPNd1BnUh4u3rRpICRD9DTUv5b2isTGfLNVqIv/mNDAGhSIVN9Mzhs0UNDZHzF5u++JN284D/YL1LilaqSWYcfE4B/VKLl26s47ApE+Bn06JkabML3bw4fg1szlt+dVwvKAhR938ohBmHFRkEklDlfXy9GCfMOg1OWqWDMFbsEhEQ6XiZe6LoCEdOnteP2PH6jn4qdKdOdygXLbE/Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: GqvtTBfNTMoazNpYG8djqFsRz/QSbhgA8AqRUKF+82AiSvYM8aO0iGVYPsTtgSzH1cxlWgv6nADLbKSf5qOc2kUC6gNlSFbyQKbpv/KkH+Q8H0x55vnkOoAqsSfqL/lvNsqIvCYfVCQrfLW0k6GYWnBVTR185cj/naooSfMkdLkXGF4ax/LYhJz88oqOXSwVmYnAUKK9CPvEtNV0Akx/+hd+epb9bL6K5v1B4/91jllteQ5dtE8HxEuEdqvGGLqbU9MLUNuhZ8hxzxHeSrw2dj0IRjDtXpGfr8SQvCzh0P2Vx5E4S46/a/SDJwFzMYY0zpYM4QcZbebvrYKGd2iCqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8287
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ab0e2806-ab09-4977-d126-08de88c58b81
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|1800799024|14060799003|36860700016|376014|18002099003|22082099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info: AKa477mnX9YHs0bhLQMY8ZZCqqBNFj9v7JQfm14/NFrlnMVyv7A175x2s5vyE7qBMUMQBqsTG7lwNJybGj0OSO9yc8TmY2kR/X9FN97TNZpUUaSyrHgEPXecVwfbPBeB/OH4I/Z5ERWSu4JyiHLbNVVnL4A7lL39L08q4nvqepF5+EYYPnLmbgRf6R9h1KYEKX3iaffLq0INy8whvEuFeeDDpoSujEMGZzynC1QFVzigeBbrjBj8Tis4MVWWjH2Z2ezNAwhNlvbbFOuFqVYLGGvYZkANe7DjmK/73Yus4IFttIZwx2IB8mybNcW3PcUOjcsPcmw4PkKy3nfEKQPrMI4jE/HuENaI8Dtx8HNivMwEg47iFXvgT3O54edJmYhHCkIJ4JmdkP6ibTUPrepuZhhyUlEl8N4H8uDIIvECydbIehGaPrnz2akNl29r/HwF5ifsyRtKrVUeYnOzNakbCZwcH0tFlDdCZK77cfahQioDAc7K9N21ac22bIQ6g/bh3T/d74dn1fqmVaEJIfyg5fJ74bklyWnJZoMyYLbOxAPNtAsklGhOjVCfzJCR1mzNKiFXrvNmkmGUpX2SdrkZl1XG3ywYlGZ/+8XrCXJ5YWI8LroT+MrGKGnCcFvr39QQcAxDzsVUbgEKIC+s/p0UKIAPSILxy8fto4iFGFbDX/QyrzLZIEwhHgwZk1PuAxEl+8Qum2RNwNtPZf/IQ2eND4jtMQeu+29iGbFf8gypLIF+1Opbn8w8rxp/V6OJR7paqatVmtpQBKLhkSQjlc7UEw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(1800799024)(14060799003)(36860700016)(376014)(18002099003)(22082099003)(7053199007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p+5jDTGIvgwLJI9tAPn4LkQsPk3m994nPYOcvfw4RTvA9UQAAvIK9OvB6EEAN916AA/HPm+msSLTTdkRIvAax5w0dvV2bPC/UuJuDUQRujkW1jgwPn8BNE2qRqyW9QTzgC7e6hUyxx2cukfzPbCPH2/SKuPJ1OQe6jn9LZaIGpAshRYJ+qUIY+4SBAA9SpbbVj3Vn5/f2kBXCrXwwW5x1E43eLtP4dvJS47yuLEV5PlJ5kXaVK/b0qfGicsEfSrdkgBwUmc4JL7VdwCbRQvCwbL+FGsYpH+mTmKiGIkKTwDvTE4rQsYHjroxaN2mZZPEl7P208wYDnNg7DTYGbX2UuNGYJvjHlKiz56GX+6OG4CwhxjHTCShzX/aeNXGCk7+nJLmBaOxVylw7S29+5wgJbWfIrk8dCv9qpqmySU+MtU5K/GJsBrQp9IQCUgdFAcs
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:19:41.6778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8761e5d-ea6a-49fa-8722-08de88c5b27e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11966
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



On 23/03/2026 10:44, Pranav Tilak wrote:
> When resolving a symlink, nfs_path points into a heap allocated buffer
> which is just large enough to hold the original path with no extra
> space. If the symlink target name is longer than the original
> filename, the write goes beyond the end of the buffer corrupting
> heap memory.
> 
> Fix this by ensuring nfs_path always points to a buffer large enough
> to accommodate the resolved symlink path.
> 
> Fixes: 230cf3bc2776 ("net: lwip: nfs: Port the NFS code to work with lwIP")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> Acked-by: Jerome Forissier <jerome.forissier@arm.com>
> ---
> Changes in v2:
> - Remove redundant nfs_path assignment.

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

>  net/lwip/nfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lwip/nfs.c b/net/lwip/nfs.c
> index c3b819a091e..9e6b801e465 100644
> --- a/net/lwip/nfs.c
> +++ b/net/lwip/nfs.c
> @@ -114,8 +114,10 @@ static int nfs_loop(struct udevice *udev, ulong addr, char *fname,
>  	if (!netif)
>  		return -1;
>  
> -	nfs_filename = nfs_basename(fname);
> -	nfs_path     = nfs_dirname(fname);
> +	strlcpy(nfs_path_buff, fname, sizeof(nfs_path_buff));
> +
> +	nfs_filename = nfs_basename(nfs_path_buff);
> +	nfs_path     = nfs_dirname(nfs_path_buff);
>  
>  	printf("Using %s device\n", udev->name);
>  

