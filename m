Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE4FD064D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 07:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F2D83F93;
	Wed, 11 Mar 2026 08:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="MEKD5rZe";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MEKD5rZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7209083FB6; Wed, 11 Mar 2026 08:46:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E1E83F6D
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 08:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gMmkwiVwAhVB9DfD8Ug0vvnrQhaSwCE6z85QxT9XqB9TFGqZZeBrZh9h8osO1gWdjHiXrBtyf5BsJuJW4CETa4uJ1c6wm4ihGsgw3FgE6lV4c/ppxiQJZVL1MJnEr8jrq7OmVX6UYbzK75zTxenmQpECt+c553761CL/791W0o7Z1/p9Oon/Wt40YBL7nFX3hABGEFtWSDLY5Zkqe/D/aAV9P42KM/sr+PKzONtDvl5N3nBxCTBLTH7oeKw1p/vU4Uq+x/1G86Tr8oBhydemRKNI0DGYo6o3l7bm5eaaOuvNzO93KCH+GtFiXXJAFuEHwHzeGq1syt7e5Hflm4hTgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47fekn6lnF5gB25rRp5Zwxgb5NAMBoqgUr5Y/buckO8=;
 b=mBDnL++Tt13U+vfa4pXiiRI0VWUWiFzZB16kqhXCSzifgqycCyNpZ1O9VyTkhmHbQG0N5KkNCR6eI8z/fbUFio/zSed3id8RYH33p3EIurjarRWNHhXoyZgpqVJfVxr1AXAY1wpyyavXgPN0yfPM7c+NhtV0kIapFQOMrfc514e9c5mLxHZCAGWXF7DOOE9jMwKfzm++p4AfITZQP7Y78JgQfRn5pNxzyjAtv5b8XFKLZFzFdDwAr5BRDt3K8Z6b8sIcGAAgJJLfuv8CA9ZCSiHFZqen70WKWBt2DkiwpGRdZCFvqBd8bfdcBU871jx7RQhRm0sBKVoHDLHlRk6IAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47fekn6lnF5gB25rRp5Zwxgb5NAMBoqgUr5Y/buckO8=;
 b=MEKD5rZeB2QNtHsgV3v97CpHYIXdqXjFms9WK5AmuZDeWJLIygXSEJZsFdvDB112xLS/4W9xABllNyjJyendzOKRcNM8r74QpZAj0aLIHXO3TPEIKhk2QinTGPJhE/CLsY4hgGs6WsrrtC8kU4JkZ6vo5Q3yfgkjmCnXLE2DPjA=
Received: from AM9P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::8)
 by DU5PR08MB10514.eurprd08.prod.outlook.com (2603:10a6:10:527::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 07:46:51 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::4b) by AM9P192CA0003.outlook.office365.com
 (2603:10a6:20b:21d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 07:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 07:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj2RGw1K5OKp/SqKDBl3awYcOjFHtQpeKWlVZYNsuPMqnLKAg0P6QwreEaXAanaeiW9pZfaZTatldRru4Q0xv8v2Mv7uXX4BmezB5JhWfTIHC9Vho0cTJJCnSuJkgQgItS/8I1pFNmLCFLQwgI+7XUP/2EhaWAMZga3UEwBMceN+C1751dAyd2UgoEzOD1jdsDoMmApQ8g+C6uuvD/E0G9D3UD7Y6SpLpc6/ybH0BDamLWWp1lt8iUJV2InVB+6mDjmVtPA5VMLtI8gQE1TbPilsBUtv0j5azlKb9Usqvm8fAgt3X9owp+1fxaSS8dzBjkP/4zuNNPKQoAgb9mELTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47fekn6lnF5gB25rRp5Zwxgb5NAMBoqgUr5Y/buckO8=;
 b=Hcqk3vNprZLyXeEshR64idHUmCHfJNjntHcgd9RW+7xXGMYloNyqJhLR0fpndtuWqj5SG7WlclpkLl0vAG2t/5oKQyaWitur854b4XcXJMAVVZflYsd26B1q8BGQBH5dlAhUT05sPIuQUK6J/iJjp2rCDoTzDXjVtJJ3A22GjZ+tpz2ePIoS1wqL0PJWyd0RUtFFNt0gR6z3+IazweaBsxdKIS3mN5gXzGgdSm7LHdQL7u/AsjTA+rGjCB6kbGdKsKzyowU9/5nCqrPE09acx5RfdxrLWLND69kWEC2TMCYtad64teajon0T1UBRCgiITbamBk9jy5NOx7zM0ICGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47fekn6lnF5gB25rRp5Zwxgb5NAMBoqgUr5Y/buckO8=;
 b=MEKD5rZeB2QNtHsgV3v97CpHYIXdqXjFms9WK5AmuZDeWJLIygXSEJZsFdvDB112xLS/4W9xABllNyjJyendzOKRcNM8r74QpZAj0aLIHXO3TPEIKhk2QinTGPJhE/CLsY4hgGs6WsrrtC8kU4JkZ6vo5Q3yfgkjmCnXLE2DPjA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB8746.eurprd08.prod.outlook.com
 (2603:10a6:20b:55e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 07:45:48 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 07:45:48 +0000
Message-ID: <21b5c334-2535-4d55-9e64-9b3acea8aa43@arm.com>
Date: Wed, 11 Mar 2026 08:45:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Move network PHY under NETDEVICES
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260310162614.1163871-1-trini@konsulko.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260310162614.1163871-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0293.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB8746:EE_|AMS1EPF00000045:EE_|DU5PR08MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: e6839586-af92-40d8-bbec-08de7f425baa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: fkZrymPDtBXPGa/4nwobQSjdM5tfPUVKozfCrz6OQt/Md3JP6NJkH6Jk+rtPoTDEsw8C30lEefs0Zp1v1lUAE64YKVh0Uj2POJisgEykwmn+u5BpNWcidfWNCtC5LXeZe1exELyD0EdT7jIr7Gjro0BZBQuLVim7mU4NRUr6IC/z9kcU1Wq3X11d/Y2d9mSL5kjJ8kx1ePfIDQohE15bAzp5iUhsAUME1oFeBJyPLfjb1ya2ZX1fS10Xn9e9vUZLoYHHfHr7l1jDQpnYQya/+cmDLkT/zE5Nr8JuYEfVpkD63/8uIqSh/Wd0E3ZUar2m+2U9xY2PartRmqui+byjuhCm7VOhScI3Wk3XJMrxwNVggUfv8OBeB5ExT4kihtumu/RkedYjUWUj/C8k1IFGXua+pnRdC90CLSLIy+qpCBL6fq0aPBI4IB/cuRybtLRSSKdw8S/Y24yIJrmZowcO/RaT+zvkE6kegVSrFraJN+lPuC6pjTQ0ZXS1Lvv8OFEXFD+0NFjMOZ0TU/p5eTvKYZCzXQnhzFb6JBqwhZvvprGPzPGuRxTs8kxvZ0tF7oLzFNgqYnvXYHYLk7fq48wDUncxMuDRiEr6nbNYPw62joFsRQFJ2Ekt3Umj7eB2a+I4IKMxCWqCnGbtMLCEbcRIb5MJ4FIdomxXfSo35NBcA65S70r2JQxeLDiUoHbfatg/C9zssyvqNbtHTtPXCT2mkFVLepE4KlBhoRl0Do26z6k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: nu5DUr1a9kbFLrU1YWemO1pKmv9ze+umCSRXV22kLNqGoxeEVS+qRBzarzzB1eaehsTy7fNja/4BfoXgafi+d8J2L9birHadi26wKwA8Tpk9kx6EWbzQU30/s3q9Zw5olpvFzEF/nXEJYdx2SQcBShT84bSnrpr2J5MThWoURBf64In9rd+aXPaKNHKRZ85BwLdO6Slt2kitptB+n7a6DaG0e5qNamC1oFsB3+i5NuRiHtJDmxMNQndvjdlfhXipAm7AioYRJjvfBkPB4IsQt1udJsGK8BbpR6wMnghZX5ZIMVhkqfJNKeC3fSHoi22yI2Tfp+Xnqf4l4gBoKpqkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8746
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 91a3c811-b884-436c-b1b6-08de7f42361d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|14060799003|1800799024|36860700016|35042699022|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NYlKecaU5kn4XdTTjq6uvjkLQLl6wfpYGrE2KAeuuyox3LqXVhgrjnu5OqH5/s2DMuDOjWfz4uIINUyjdzn9MEIAm6trcTtV2Dd+L0d3B2hhdCNdI8wbOMgCnt+KbMdXp6EUc2hSZablEDsoAW6j0WbCAxe2l/e8FZXN3DHtBsfSRuCzpFpn1M0whe5yLYcQ1FC2EMZy8ZGFMCx9XNOHaaIyCJwoSacrAQwIPsq0vkJO3n+88pX5E7VG6cPWwy9W6Lhv97nV8VJKupOxCllGBXa3FeLkaAfQx5NTJsrpNWad4WWhomYlu2nDQ/zsbQfZTNl+jublOVJSoEMxSuR6eiX0tz6BU1SRFvCMFBAtjrw75hGIQ9+qivzvcACmN7gUL9U6yJ/+rX5ifXChCVR0IzQkoboVXDzY6AYnRHXJL1R6rZTYbmc8eTQ0qAFS49h+x+S4r0djlcdP9Sle0pcuI3P7FxkhfDgcsYXSLpeYPeXn398Dr8sYzduSJtEcS1sEkG2/04xTSFlBSHabzYtClJxhRplMJyiImgdNK9dP2UBzdzpIX8VX+Z7fl6LHonnzoduao/pmBu/02zTk18HggreYlHszkKytlRGQo60mJ116a9dpNwD80ng5ZFn4SaUUCbcz4KSmEy7JaaISyY4GOaXQ6wB1I9zo5GixNHBL0pCZ6a1RkcKKV0gLsSbX1p5PNs3k4q4GF8RQ3wERLgfIr0zslxtbzCflh75XAr1B/vWXRm3IVZYabi4gHjhb3Ey+owIiav/X4ugXt68659z8cQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(14060799003)(1800799024)(36860700016)(35042699022)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I7OQaOAzsnbeZ9gpwn6n7So1GPNDjtKPf0G4o1h1IYWZPkm1gLWZEmAwWfnNu/paQzKy7nJgerJeu0KSpm4nXfOpzdptN2lSKZxbEOqSeD6YlRdA885HvHJK8L0p/Rb3NZX+Ws/ArKXG7HLgunOk5Cpl4NnZrJcgvAiF+6TG3YseqThoFppQXJVLAhfBQOJr5q+GhUTg2XUrPr/2116A4OhwbPknSV2+fxlMGh8ElPYFt7u0q9ckxzWXXUBRKuSRfQJpKUbC96bnmB0GkbjA7HyK14u+22zV//Dl8vKpF6MkK34hph4C3ZihWoREVV0mhq/FKf4L4XstZf9Y8XHU2jieyAwL7wMWWKcpGhZszCNCvNnPAgEc5Uc9KFOV7p3mR7o4jgl/MlHXBj8wYtkF98drsJpxPE8N3vCK9WdtKzb7pAP8tgT1mS3Y73vCwLmY
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 07:46:51.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6839586-af92-40d8-bbec-08de7f425baa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10514
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



On 10/03/2026 17:26, Tom Rini wrote:
> A number of network PHY drivers have Kconfig dependencies on various
> network drivers under NETDEVICES. This is in addition to logical
> dependencies of network PHYs needing network drivers. Resolve the
> Kconfig problems by moving the network PHY lines to be after the network
> devices, within the overall NETDEVICES guard.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  drivers/net/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Indeed.

Acked-by: Jerome Forissier <jerome.forissier@arm.com>


> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index d3ef050d1a13..42c232abc001 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1,7 +1,3 @@
> -source "drivers/net/phy/Kconfig"
> -source "drivers/net/pfe_eth/Kconfig"
> -source "drivers/net/fsl-mc/Kconfig"
> -
>  config ETH
>  	def_bool y
>  
> @@ -1098,4 +1094,8 @@ config MDIO_MUX_MESON_GXL
>  	  This driver is used for the MDIO mux found on the Amlogic GXL & compatible
>  	  SoCs.
>  
> +source "drivers/net/phy/Kconfig"
> +source "drivers/net/pfe_eth/Kconfig"
> +source "drivers/net/fsl-mc/Kconfig"
> +
>  endif # NETDEVICES

Thanks,
-- 
Jerome
