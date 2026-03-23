Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44705D58CDC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 07:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD4F83DB6;
	Mon, 23 Mar 2026 08:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cBXqwuyy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cBXqwuyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC2983BE1; Mon, 23 Mar 2026 08:36:15 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D511C8408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QkoUyV2GUvYpzNJWnnOZXiDlHFhOckW6ScYqwplY846DcCo3yetwKJh3akW9MjI38lBdtpSY4kOt1ohrjX8Z6r/qzNBGsT3oUCxexfqyQ5d9wW9YRO4q4z9r7hzYI+e32DyK1DSHUFKHorY3yK7G5yp9mLbUu+1HOyuBX7XMENXXiOAQE66z6DWEQM6Yz93KZ/5DsvuCLMi84BOQuleUYQHcDSv89Qz0o/DU08q+ochztHFMeIWmvJWMEuyqOpHN2QtQFHgv22V7xhBsjYSGbi0ERC3X5fodpCcDOVKkJnAvOmD13pgVMfsWJp6xX9hkn7IBol82K4rW7AJD3GN4oA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1PcSEVyzsYJb/PA8ckSyml4pbcvJtCa+lHPP4c5Fv4=;
 b=ZLwerY5sw9sI34k21zpTVeifelJwMj9JCkC9pC6IrfZYbMAAXAU6XCn8lsUWzy4pzZb5IgfQW2vvQWzDN9e5HGx2zEUHoJpIUQaM9RsSSO/VF8CUvS5x9Vb9w4FOtcbZn45ttDPZEd4LrZukKHY2xtCTgyKzK5H/Az4FtN5uWRrhvm7PMvetDh91vYeA8iMmJvIwGT7sI4M+Qw2g88ohhjkcGWRmRHXd33P0oWgo3s8s2R29Xs3PiUSv5s3tFEQbpKsZAwmOokMkP/u1MoMJTpr9tVMhKfInxE1mABNvvAFzyfGEEl8S70L9UW/h6CH67uCsmxZYh3nHVDz65asIJg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1PcSEVyzsYJb/PA8ckSyml4pbcvJtCa+lHPP4c5Fv4=;
 b=cBXqwuyyXXV+dvNstjv3ejc5ft75P9zU6xEhy2oLP5xCqoLqBWGPPAS9UpW37pet990nubWwdCerb1ysCHbNMOpZ6HtKuXSmo2o5R/n+bt3mHAN7JjW6YByZ4ZwMnTzfwhb1vV4Yz+23/KCOqDEO3lmT02KHBXjp/jzIwh1wQKk=
Received: from CWLP123CA0216.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19d::16)
 by AS8PR08MB9576.eurprd08.prod.outlook.com (2603:10a6:20b:618::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 07:36:10 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:400:19d:cafe::80) by CWLP123CA0216.outlook.office365.com
 (2603:10a6:400:19d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 07:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.0 via
 Frontend Transport; Mon, 23 Mar 2026 07:36:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwDCt7O3iihg0VJtQYd7vQ4LYhZV42lNpBthm6TCxisZR3tctk1FAU6eJz8yzQgfij0fBYl6pLsf9utAQfbXTRaH6IZ4rkpXxvePTCYSdTO3VM+/Azi3yJa8IdCbEHEYmoEg/9ODTQoKCPQWMgahK2iib1SBcDWeFKSUPbHjFIY8DVflcJCEMFj2KPDrIK0BHOR9A+fQIECxVtApNpbUugLbk5u8IDm54GWQt0jUhdVK24AREqePugjI3734LefT9gyyWnsfCNPXPjd3zjQ1fB9ZDMPm3nsfyKwtbMacIg24K6BjyJg40uwd7vIC+4hn5x+w5hMD0DTI9qqfg45hnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1PcSEVyzsYJb/PA8ckSyml4pbcvJtCa+lHPP4c5Fv4=;
 b=HjqejyjVll9g7ks8n6itBfUMh8B1pmNZ2UFIGXD6DmdDZsIHhlK1GOFDUbb+8+CZEnqoOaXCvzAcY6GRxKpnGPOPi7/G/KybmKpXDOERR3ik6+PqjHDWW6C7LdnpPtUvriwZqWLYz8bJp+gEEmPFFtczt0y837MEknWGNJ1EwwMfI2TbDECUxpSGESuOnlzQTW1v/3Da/g1MKuFIvEWlQFziyPU1gthf2WVsHGupxAoX4eIV1a3DjXrt3wWkwWaHJ00U85UOYNPBEV9BXznXqzhJgfft2y/vG0RtSfNLu5fb0LASD1Nw/QKFb8FP9rQl8+QqdSt8nC8/1aIY+xESXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1PcSEVyzsYJb/PA8ckSyml4pbcvJtCa+lHPP4c5Fv4=;
 b=cBXqwuyyXXV+dvNstjv3ejc5ft75P9zU6xEhy2oLP5xCqoLqBWGPPAS9UpW37pet990nubWwdCerb1ysCHbNMOpZ6HtKuXSmo2o5R/n+bt3mHAN7JjW6YByZ4ZwMnTzfwhb1vV4Yz+23/KCOqDEO3lmT02KHBXjp/jzIwh1wQKk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB8PR08MB5449.eurprd08.prod.outlook.com
 (2603:10a6:10:119::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 07:35:06 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 07:35:06 +0000
Message-ID: <0736673d-564c-4833-ad38-2d125c1cd227@arm.com>
Date: Mon, 23 Mar 2026 08:35:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: nfs: Add missing dependency
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260320205329.3788642-1-trini@konsulko.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260320205329.3788642-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0500.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::17) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB8PR08MB5449:EE_|AM4PEPF00025F96:EE_|AS8PR08MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5926c9-765d-4c01-19b5-08de88aeda12
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: TNMZlkvtGnLYXMlewapo6DbwBN56QSxZgu1qxuC+UwKEbhWqAk3aZnKCi0EIAFDTA8xXncXeylcr9dDshLUfNwTnb21VlVQfeaaLVWs1FPN/dIIDrQ9vUNzzHFMRo3DsKg9bJfI6wQ4yoWSSTLHuZpqMXk70wVGunx4B9qE8kW89k/rK3dJEWzgAIJJmcUTF9GPdQB5041iJVsiNB9RJMJVdtXS8rE4rBARLkdYz2g6GYoUMeNeolruTOXex2Owt0q0ZPTS0W/hIL89BoW6SXL7Ljb8ExNERLo0XY5o6wDB04ENva2uTKx2JfZvSiefV9d72DSExrK64P71rv6D5mRK8LgHidIhd3WoEZMUagwbQRSi267g9f1o8EgEc2hzRAnAsZgFMjAFBzVqZ/c0v6cnRL4ufOWxNGQtUhaRuHMJqaJNuXHmRnyyWQspPcswyiJi/NNsO0yYeLnpXD4HJzhuRegKgbUx5VNlMpJ4YIjn8NKwF03Z921fGyZkkSpMwDyMxzyDWSpY62xUKOSkWn5CzspIUoNiopm6/Y6ySarFnJUfxXbqm85yHqo8ci3WU+W6a98a4PA8Rl0mbVk9GpW+EExkpR0SbmYLk5lcQjIvob/5G5TJTrixrR0rTBfbJbgvxiMiGpYDPntQtaJhG+qkt0Q8pWT0ArQmcr02zK/1OZOSNRNTD5G8Ti+6o9ZUb0YOE+9eKXqnYTIlYSUgu5Wpp7s6dD+uwCv1tnhsZzbA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: m3ONtrTgeFrNE6fo18nF7TpI7+QiDUYzaF1WwJqNcMTV52UydCAVHl9hzqkH/f11FQav7ofVr2HQ1ihD5SxNrqlSVOkanorIDRwdXb8TcXYxojo8G89yA3wFR5yPYjYECJlR/wcNsY6BYj7GS8OLnM7r7SDJMz/iRM8Wu2xn0yo6IxXFPmTbaFfo4s1LooBdhEhbMZiEmypE+wrNQgmy8O3oIssNNoGz7HqAHsR2b1WhVWh25hk635dXu/P1zAPwrD2VWeZPj31fNj6SspFQULYw1cY3/GrnED9L8D7UsW4UuCaBCkiZvMlkK1Fh+ClvP/P3Zod84vNrF5qIHu9k7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5449
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90885fab-1ee8-4a93-ed3d-08de88aeb417
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|376014|36860700016|35042699022|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: DPzwI49vLg69iplzLPDsm2HJj7QaztKqQiWMR5+T3tJq3q89Q45kz1L82d1i5rnPF/cqVAdWgBhJ1CVzFXdgaSIVRkS+ctZ3goF22fM707ff3tM/qaiqToQFkVbl529bFNu/LApdvBFCoQH2yhvU+8BiwM+nEXoeXx7ZW+2f1GDt/ABIy3Axt2uNPVlJ3KnqdjX7SuPfOzSpyvhi9oWMrU+WYW/6KnlVSfvArbaUvFqEzRQ8QXXWDtNf4eOIAAeWxt1aZ7mi9je+Oe4X7SmmwnzuLeYoTGHG0L/bA18TA6aqNKXiruUTI3GcAERc/rtc62ngoTIjiGepRszBQ2ep7PzuaQwHDGx4J95kMHc3RubK32WXDgI42bpSNp8xJtDewdH0mNvKRgi4VyYUi/eDI5ufDofuG06ZvwF3l570eRFXkpFkeTPZuD1SH5gCkmGslWJgtT6VjPPgz3SOSm0UXJKpu8m2qsib8mBUiTHVjCr+BZCkS/h/lAaHa4hQFRUFRtDn+Vn0dDvccdPaIOl9JD0jL8fAVjdDIaO0FeyIwCaq9XsTspgD84U9sigEejhLZe9j5qIvXWWzbCOP5yRNXVXQqSw3lZKrBvX8y84ucvMvAYJDcmt0OyW5HRI1wVlnZ2gABd/cGlJuizxCTvwn27DEIKdnxDZ1gBU4gjLtASAIX/mwn7UOWX0UgWR9fm6UwMXjspslsyE1+y7VpqmRCMPlnpGocfUiyWIKGPVeYRbypag87NJS+nkZj0cq6B+h1P2QlZngwWqbCY679mEYng==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(376014)(36860700016)(35042699022)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o57mNeoyga2q8OwqrRxdD3adnmPji+nMrS89mEUIpW/yuclBNEvUzaRqD5DDcU02xAIukKOWnJzVfMBmVfcn1CiW4qZlcwPLrOtrvS8C0oppkPSRnbLg/c/gVXqAgudJDzfP+eVWOOnIvII81YsjgaZOpLCnD/tNifu5SG7XuR4r7m98GSqmh0IgpS5FeVTIZc8b2mXCpFC9aDb3WzcG+f3FKGt994U4GLLsH9XHYeGSVer4illIXvDluPOG+iwYjOIxOdB8BppL7YaPiONTHX8frjeOoKfVsbhyPOejja+4/Nupnp56FNdcMOcV5MDfgQvbrWaKaQ95FsnUbTh2wSNCBluDukA7Yzy0a1pyJSra5xNLffG3gVSY3hlpg2GXxckZsxo0qGQFN50DLeceQ1q5ATNDFPMIMcxi5yL1NeQG7emEdYDvpAUuNO1BX+ZW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:36:09.7073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5926c9-765d-4c01-19b5-08de88aeda12
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9576
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



On 20/03/2026 21:53, Tom Rini wrote:
> In order to use NFS with lwIP we need to select PROT_UDP_LWIP.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 667c4e0ae811..f459f6b029c2 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2221,6 +2221,7 @@ config CMD_MDIO
>  
>  config CMD_NFS
>  	bool "nfs"
> +	select PROT_UDP_LWIP if NET_LWIP
>  	help
>  	  Boot image via network using NFS protocol.
>  

