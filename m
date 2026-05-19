Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C1BCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A591884693;
	Tue, 19 May 2026 11:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pOXvx550";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pOXvx550";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 268088469D; Tue, 19 May 2026 11:29:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28539843B6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V07jwznqf1utkDqqj39s56GbN+Fm28ItLPZGAOLsWnfQk6hdYVh/rggTrHiK61oVEZ3PBb7qjebDhZAFCjOrCKJuQfTvyYMquXyF+VhID8YzwBfoNckKR4U/i154noSyLFb4z3Brcre1j1mvMmyeaDWcwuVu3RF1GmAwrSCqK/5iu50Zsr9eQVgIzQFyp5vJ4BcqREPhxhbbjletwGw/62p/SyfP7aeXvRJfpqJUJk7SjE9v2C5eXbimduTpIROsAyIDH6i3CtUTQGIWBYEUPZx+BA8q857sWm/0O/3DoyOnEWXliEecjZfQ1W7P2v2MsrIx0uCzEodXK5ZscYeaRw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB4uChHFXi+aLbReoFUb7KE4e97HZE8dDP7hgPZOUNU=;
 b=JtopS5VQq9LeX/3tMtFWKvF4nenXSDRH5K9az48NDUJ0UI0zS0UHjFuJ0NUZm0vLfOt1HE+7NASBLxrDP/hhb3tbA2my52QvUWZrcgq+1mhqtjvBJCkUCLsvjVPHpIorUOmkYOSMI70+p974GI0jf016pu0hjcmypxs1cdhzqAAcuDFsAPPKA0qjqkl7nc/i6jREHtBXqEGO9HaEScqIGv3O/TiDiOZRdHGlM5YoGodYlBo+75ZUMtXMDWLiUdp4c0EXXQr3bcakH8iYKSVjktqRxBv/xIFnnBiP12uAKWH2h9SGuTXVi/6cJxJfRp2L3cQ188w8tTeZVuCIZRKi1A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB4uChHFXi+aLbReoFUb7KE4e97HZE8dDP7hgPZOUNU=;
 b=pOXvx550LI7ZSLDX55fyap6wUg4JWoMJ0Ba+fbx4qMGGwAw57A/xnnAdKs19kUDbQZ5xz1j7bEBL4KnybRxlV0GaqE4mueUouXJjcxcTEAXczrSaxuS0zA3CpRExB6O1PyWx6AdbWkGF/EQFR+7Ts4FvGb+HfVmIasIQ0oZqc5I=
Received: from DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) by AS8PR08MB10196.eurprd08.prod.outlook.com
 (2603:10a6:20b:62b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Tue, 19 May
 2026 09:29:34 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::95) by DUZPR01CA0061.outlook.office365.com
 (2603:10a6:10:3c2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Tue, 19 May 2026 09:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8mMw1lo65lzJ/ue1wfa/COlTIawQHmXMv11+T+GYMk0eOqFwTyPu3JicBvMipRhoLAZuvQiCYuW0X0daoGWSXdq0V79tqubsQEdmtnNLqQnwTHRdze22NlTcyxwxFczmEd8jjwSvWJTCl/23LYtYrd/3BzRl7GAdBbdPJjaqJSSvty9MUDxJPI1uCx29zuhbcLOUtrgwp6enMPVL9e4+xrJEP3YvXNXNN5XceojJF6bndMbs4Am3poNt9+30sS4jLVxtymwypL/P/hAlO5oU9vkFoADE3vN2UiOi2dbJ84PbVPOfWPkTBSTTnvzK5BA03bB/MLkiTpXBcYeFguaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB4uChHFXi+aLbReoFUb7KE4e97HZE8dDP7hgPZOUNU=;
 b=S7kQ/hyH4dV/cvxvxZ8oYGhE6AM69tmK4N1ZAIvH07gFNnABNPVokSTF1zGnP8GnBJxcpvn+civAzs4FNAaHRv4CVxHp9Ffli3U0sH4kndtCCD4YvwmKs2W2AHMOHFM92n8r/1ku6lOmT8JtowTfnhl1OP5yaBk+gFfiDYX3pVx/G/RYXRcHcIFyVY2yp7VSCXlZdq+3+jrjBvC2NfKIGJcruEV+G+2dvHPsdl29yBkeqA9UJY9CcdsD0FFdi+2lDGGgBCNxSHdwdV2sHk+RsAMSRd4bXf+A77akmQ+d8Bx7RwxV7I5e0rst1yy9Cbnn+zpeaaxTijil0o6GoflYcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB4uChHFXi+aLbReoFUb7KE4e97HZE8dDP7hgPZOUNU=;
 b=pOXvx550LI7ZSLDX55fyap6wUg4JWoMJ0Ba+fbx4qMGGwAw57A/xnnAdKs19kUDbQZ5xz1j7bEBL4KnybRxlV0GaqE4mueUouXJjcxcTEAXczrSaxuS0zA3CpRExB6O1PyWx6AdbWkGF/EQFR+7Ts4FvGb+HfVmIasIQ0oZqc5I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAWPR08MB10281.eurprd08.prod.outlook.com
 (2603:10a6:102:367::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:28:28 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:28:28 +0000
Message-ID: <307baf1b-3e0e-4a20-8b5b-43e5c4fb23b7@arm.com>
Date: Tue, 19 May 2026 11:28:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dhcpv6: Prevent buffer overflow during BOOTFILE_URL
 parsing
To: Francois Berder <fberder@outlook.fr>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB2805928BF5055166EE7F0B11DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB2805928BF5055166EE7F0B11DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAWPR08MB10281:EE_|DB1PEPF0003922F:EE_|AS8PR08MB10196:EE_
X-MS-Office365-Filtering-Correlation-Id: e33bbd4b-7652-4dc1-2cd9-08deb5892305
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: tjqxRBNuRzXTXq2+wvdVfpWPZewrNdia4NdY6SiiKHTLsOQ0dxwwrDPy3N62jw4D3g/P4L+VK7B2uDsYESIwee/yhkgpEYHKbOWyqfEVhn6i6Ji9BmJdMIM4NE6d2FF0gpjVZCEQVQencbFaAXegVr3bRjCDt06VvcVFTZEBvNe+jRfCCWT2m91kTxxgCiBFyjN7pJJceoVCLNbvJ9uCxQrBsKeTYdrOflw2Bvp0w1Gg67fYkAYe8lVOfBdri5zK+x5pwmWhEwmQB2yofOKBteu4s1hFTimX3monv3ISVWwPw2giq1WM/b3FVoeERXiSc1zVp0JRR1IZCRRotmnGs2DPVInWRtrPDsjGFvXh4FWrCAO7qQISS+3TcS4id474YBRawogd0gaxkZqK+/O7Q8NMeJuJ8OQkv8PUV3xi7u0MtH+Si/AUX4C164Vx4DFvXq4jVeUyDGrlbs7FUz8mgTrobPiAQa08bdHEzqf32VHciat87yeATZrH6inyCdsHfmFOhHo4wzd2qwa0WEcqxCZjAJcCCZZ/1nbqFv7CjUD8vcA0PyFcJJtA+gzY9AeVEbkkUENeNmMsCx0Q/AJ+7jj/jdoM8EU9jbQvvWQrEzb+/RW8CIRCgBHOqiooWkLqrFD9vjJuY0eDdAapTN41rwZjhIXCbK/+lFPDKIyDYex6IV68t2JFrNPqkujC9nFZ
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Oq5A3na9ruwDjTFawuPnqrATiZY+NOe9udWcUDul5HY5z5W9U+O4pvCcfYJ7pifR0/XgYrjnlM91/UDD7Cvw9/HeTfuFSJqyhHQcN9W+6fG+A1dLOyuDjWrKKrh8WyjdNz0/OBZziJb0nDsoz4lCMUka95UPs8mo+VxxLn4RhPRqPykg5U6ZLsmVF1GGtyY13CaOgm5K2jW5sdpPAlhM73OUwb1OMZFDHGAEQpmvxuPNLSI7rEUzGdkt4D35kFfaoitPEfc6rNDmr8JmJzv1xd0kwYWVHkcgmDTrv5BZEekn3lNa47Q2yft/7bAB44QgomDJvpRNUtg60/mPGR2I4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10281
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 42a787a5-0131-46d2-1436-08deb588fbf1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|14060799003|376014|35042699022|32650700020|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: tCDbJYEv4nCWUBr8/nj4Vh6DUbAzTpnYjqna37V9LH2Pq+AdOVRACYM41GdDlElfOj+ierIxQA2lYN/Aqsm1PuR5tILaSczPLJD2gZmXHdUKT5xF9U3p3VxH5IV5Oaw3FPLI/pHmDEpW2KWNM7YY1ERGiEtjElyD+0o2EnljtNuy8i2ABnSfeJkDhpmHlrpwaObW6WG2CWg91ECMdeKVUZk9gUCn7p7nq5oO0Sc+GooKHrjqC5V/aMZPO5f8rTR18dTjvDEBZLkd4UYYBnyODkQv9x7qEKzBqUhBUUTYoIKaMqSOGEPy/UB4/yF4Xvb1LlgKwqY6E6CG4IqYPEXbATqdugI3gmdnodV0k8nd2gZ8qVwfeLe3IMp+Jkoi8JZZOa8eCf5f6CLeD7W5S02awxdXvLXeHNmNM85o8b79hOQ1N4BpBBuFuOrTrp6Xn9He2A/88yk2cBPjwIEpp2bmZ+FVNSYlbdzg2iEJOjx7qglHGZpFuHqm46eArfOgBxxT/Q0OsDwwAXPwFN9Ohsq/dtF60RC0Hm8M9W20Zrlu6ebGl9TLUH9kAlN3cg75bQqqYvH2hyu4mJ+JEXCFtQn+6q5x+eEiLjnTNl5uU6+pLBM0LwLQflP2M12zS/u2m3t4RaraBQebjFJ6j5cDm0mJXP7cjb+o5znGaovrHYEV39fq7PTTc1amNMYoMTxmC5HMFHfyeDPAad/xxgrnhL7gv3XFNxXWRNEedoyXjbjQDUk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(14060799003)(376014)(35042699022)(32650700020)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HOZzyYt8T0wmJQzkUl0ZXQ0nf41clsOutWtFtJfMZjEf9sxCfgJX5Y6Ga/aaSJHakUi8hnJpDcGEjl6uFyjY26RqG/DcNPl0Df1m5xrytaWQVEURu8jMa2ADunvCUczYH9sbWLjqZ8idwI0+FG3411R/PTHqeAAQb7lAe3Vy7BE46yhp2+siBRJMm4ac5V1ax+54Ynpowm95Q98cnYAcAIc1IsQysNdDGYlI6Vp4xtT93ocMy28oMRzYGNN/7Pe0HFZIn4qgpeponcsOmGeJZI2F8DcB5aMuz6m7Tw6L7P3Oqaw+avWDiWHA4QoOP21LQUFHhGE+7AvXm8CQhFb+TQJSP9O0zkcUYVutuj7ChQrOLj5xaqU8MMnysMvT6fRX9C2LDVLGm+/21LqKpC5U5EXW+ld/2AD7gMNcwPLHxnnxsCFBpTZRfEG0BGYOQZQO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:29:33.4893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33bbd4b-7652-4dc1-2cd9-08deb5892305
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10196
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

On 11/05/2026 21:55, Francois Berder wrote:
> The net_boot_file_name is a 1024 byte buffer.
> However, based on DHCPv6 RFC, bootfile-url length is
> specified by option_len, a 16-bit unsigned integer
> (valid range: 0-65535).
> Hence, one needs to make sure that option_len is less
> than the size of net_boot_file_name array before copying
> bootfile-url to net_boot_file_name.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  net/dhcpv6.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/dhcpv6.c b/net/dhcpv6.c
> index 5bf935cb6a3..51f44979f8e 100644
> --- a/net/dhcpv6.c
> +++ b/net/dhcpv6.c
> @@ -377,6 +377,11 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
>  			break;
>  		case DHCP6_OPTION_OPT_BOOTFILE_URL:
>  			debug("DHCP6_OPTION_OPT_BOOTFILE_URL FOUND\n");
> +			if (option_len >= sizeof(net_boot_file_name)) {
> +				debug("Option length for BOOTFILE_URL is greater or equal than %zu. Skipping\n",
> +				      sizeof(net_boot_file_name));
> +				break;
> +			}
>  			copy_filename(net_boot_file_name, option_ptr, option_len + 1);
>  			debug("net_boot_file_name: %s\n", net_boot_file_name);
>  

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

...and added to the net queue. Thanks!

-- 
Jerome
