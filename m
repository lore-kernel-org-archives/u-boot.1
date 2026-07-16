Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328B4C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5340684C15;
	Thu, 16 Jul 2026 10:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ILIEoKU8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ILIEoKU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D41584C2A; Thu, 16 Jul 2026 10:05:10 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 738A084AC5
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q011X6xEYjk5GwiFBgHqfdtSspM2f1V4EczE73OJiUBhIvm0SJh12Ch0O91AyNhwRFM1zGKLbL6IQUN2JfnAln/Qm2fH4HOUU5QzmgburKwLGgDxNTTfL6ZE+yhgwwqRS6tPa0WcUb6SObNte5M2mVxq+sh2k7Z+ACYKZnkGTVbcSVpNAApjNiodCpQZR7QgqSmGtdCZBMXf+A3Cj0vH/OwuehgMT+agyheUDGMljZMeA9vvKl2pYCpLSQr5ykjrpce5viRLIhmZ4gfmovEGO/Bnuc50MBBri/MoZ5XpxYTthCUfR1o657UkgtJwayaJggvopGdlCAtyQsn/9t0Lzw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FE8HhuXzl7vJ0JRMgrcbzuA43wPc80cxdFCjmbRMk=;
 b=Mq7pu7FOssbxsEBI1VQ7R5Vy+1w+nJuwONkx4npMUlKsUGsiY40fzezBh3I+hCjKfttZZI4Mu93FddbKFWS/Rf/HrxtWuBd64mYqf2crz0efnyGE/Kz7s17Z7AIJLPHdXkLYMHfXSmTcGZ9hDgw75Q82gAQ1GxrtFeYXUl6cQw6N20xOQHr9xE8P4vqEIfYTZ8734EETOBbTYk4jLcPvRQW7b0dLSmq1xrKy7pNZhTMMTkrVSstjdaW4PW0kXddVZpl/YdqEVauBOMF6xZj20/ILh+pNYG3KDBht2mhWvHp3zGwEKP57v4aIYEpOKZbNfc04nTKmVCL/rD1UWDXO3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+FE8HhuXzl7vJ0JRMgrcbzuA43wPc80cxdFCjmbRMk=;
 b=ILIEoKU8Frg/k56GtgoUMx+g1pSZfYpqg0O2hl4V5Bv9IxWIdfp8Gbx8T2tusBCzZQPgZKc8anoOZH6VaRkBy5YfSkpnhIrF+Aa4EFLH+3allgxZgrS/g1HVhMWpuSZA1Qs2Kb0Q7j5Coqtx6HqZ6+aKGn8/b/ZO6a4frn0e68o=
Received: from AS9PR0301CA0030.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::30) by GV1PR08MB8059.eurprd08.prod.outlook.com
 (2603:10a6:150:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 08:04:58 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:468:cafe::87) by AS9PR0301CA0030.outlook.office365.com
 (2603:10a6:20b:468::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 08:04:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Thu, 16 Jul 2026 08:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs+/l9VtEy+bHmiziZT5FJYulExhzZpQfzpgZzf5UtnDBlgQTHpE1eNDd9FnzN91iyEuzz8lQSWiiSYio48PPSpcIePqzPRG5vCAYJAcdNkulIRvy49tPeJqVNntBSr9JWWjKb2bY0WiyZ4FxjJvy7pB4vhdzAdBlfL9qWPVbSVkGUhPRqePV79qPdnrAYmCuv/3BHU0v/qCMB7fMULNWdJpOYecVqxZbxpTG3SHcb+pQHJN1aoF7Hr8vapRyYH4Wy+HKVyT49Di2CN7Hu6cpVA9R0jWqTuF8BaIliea9bap5lGYBw4h6uVzlu0Jo/ttJvj6A59JOWcYwPv43WHZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FE8HhuXzl7vJ0JRMgrcbzuA43wPc80cxdFCjmbRMk=;
 b=V5/wg7SuVbZodkrABJtSqq2vq9VPhwrQkTtANCOsW2tKf5uNI9l8OOgCj3p+XQMenyQyiXpscIq1FAlrTi2heF3Vizg9OPkoG8d3eWXcMPH/kXDS+pqf0Ex5eA2LWhWUNjUj9Abo/qVIH3wAGH7ctgcRLom4jXdu9KwMPeAhcmunnmuZR/734UUN52cY0ReC3HSdpIw7E9UQJasGHbtAShLtutJjWJpJbmfh198iEVRdotY9udkls2MWPtDX2l3Hvyhnxdqkul1XranPItMYdB5VTzmCnOtQ3e9zbvD0v5B01OatsoJhvS8mJZxaX2J6+kO+7d7FD3uUyPL546Fwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+FE8HhuXzl7vJ0JRMgrcbzuA43wPc80cxdFCjmbRMk=;
 b=ILIEoKU8Frg/k56GtgoUMx+g1pSZfYpqg0O2hl4V5Bv9IxWIdfp8Gbx8T2tusBCzZQPgZKc8anoOZH6VaRkBy5YfSkpnhIrF+Aa4EFLH+3allgxZgrS/g1HVhMWpuSZA1Qs2Kb0Q7j5Coqtx6HqZ6+aKGn8/b/ZO6a4frn0e68o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5868.eurprd08.prod.outlook.com
 (2603:10a6:102:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 08:03:56 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0181.016; Thu, 16 Jul 2026
 08:03:55 +0000
Message-ID: <24b7557e-3867-4256-b8b4-8b0cba14c6c3@arm.com>
Date: Thu, 16 Jul 2026 10:03:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: lwip: sntp: fix netif leak when ntpserverip is unset
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, nd@arm.com
References: <oggze2g2aloxhrxqmcnt6tqa5e2lf473vy647b72odfvahwosx@zqawezfx5t7c>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <oggze2g2aloxhrxqmcnt6tqa5e2lf473vy647b72odfvahwosx@zqawezfx5t7c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5868:EE_|AM3PEPF00009B9D:EE_|GV1PR08MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 218d05db-5d70-4788-ee99-08dee310edf8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|18002099003|56012099006|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: O/8IeFRqg1vAwpLXB/pG8qxO6QunfJHViqvHkb0Sw9hGQ1KuoNQ5sMsvQ3CWCVsmvuANLGYUEy1+ymlDXmUp7Eckb1NkZ4zTX9tagLiWe3cdBQwoOnMaXi3YkWAHsnTI/4gIfcip9Ea0O/JmOU9QR3SBRqbwchHxh0PuZGMvfp85B0xaOAhQX7xpVBolqByCem3J4OKzHIF8bZ3Je3bF/yJR2vbkl2ucPsV5U7/313uLmV9EYtKu4/nezcJNLYvLwbuDF60DXlsMwWFRGQ2lBIdBbNbS5A6gLD1PBLaCXGuF6ijA4ieDE/ENrz/4BgyiamrWGEEsZL6v7Vayn7GOatjFURVpWfMnqbVsseIphN5bzGcXSjE3nnMVjbjdhsUiD3vmpRiQ4Fc7CLoyjxoE1yGqdPQTzGK9GvudCsBYsi0gkoQwT+f1HEXHLRB7E+2lsAdZdkJ3s7WcOKonm1hMo/c1dFhFkuVv5YYhIu5GBYSOHRpNCuixfzvdw9RpY7wQS8zQhEY53/ebAq1lZQ3moAKBsukRp2sJ6HwOuX15y1ugo+7dOL+UXQFuE618xdUMjLCiFZ/9bLbhOtZ4U3j8b3VKjPkiHp7VkWMBxlcIEYn88iDBuOAomwAlGYP96xo1LIaoVbSN1WTpZk5HgZR67796qxIoqQhqvFfKXp1wKe4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099006)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: dhoF2NwNu10i6WWOgZcQFFHRYHVV8aiPjhkvryAQS1xCsrxhisMkUgGde6Tkl+31FacNqHh5Y8GCw/bWYbA9sPLl6Aloc840HIDbyOeXu0d6tDTzLW1WyoxuZXQs1NV2QiPpVJcCu9Bpwofhj5xaztPaCRLE2bXSwyVKlbGh45ZTIf9MgBN+mCwTYeZOO73Q7Zx2auYkXriegxCaRkw8q8nJk6qYAVtweOCu2bgGjFIIucvym5wXi9gnaz9ywPtCuLwvvOlvxIbSVQ8z834CmfdMZq57d0DdOn44JZz2v8x+zyNvmB9a21RxZe0jz6YRgRem0dZSiacqaNMcgXXWuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5868
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d5df4d1b-d658-4fc1-d946-08dee310c89c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|35042699022|14060799003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: feIJiW0Ntd296Ryd8VcBCD+/u+fPpU5gKiTL1wOLXpWr6hnbaik0pVaRQfY/trxDne1inPTwrFMI2ASXuk5Rz448h+x98GtFD+a7IM+57zXn06PhyiY4M2fiE4PNQMheCwX3jhBRkA3Mx+MIpQ+3zzXxW7cylo2VKk4g/5F6gM5WLrF/KLMGh8CbHduG+e5HPf2J7XKgPhuilZc7y7FROzBDI04ak+ZZfckPdSlqJYThPwZ+ClE75x7fTlx5DrUGxvgWwTaVWxeMSSP9oVdSU8oocOzOiAJILaPY+yysXEvXnAeqzhkJXSzoiuiPCpAUlzyeeSmEx9sZe/MgzQxHyCYwOOoP1MHSxfgWrImceCU49Z3Dv1ekwNr6l7UX02y1i/mBpsCSvHIZr1UPFhkESeJYJWskOXcXzbNdrpg531f6hl2/XUZ1RI3vZn0utQKGczlfRAgIsLaV/FbSBtSQqZAm2g3nXvu6tLGf0yktrXmv84X7fJ2E5QuJM/59a5EdMPEeDnuB/QIFLNkEb1iJSRcxJvP5gt9j7cCLeOf5RiK59u/RYOcb5VA2p5cGany5MOlyikjAXJiiREsIVXatFLiGVciA/oyeA3+njfT78HnHCwArPG1FcN8Vb/iccbr4OtM7kQBuwAXAyxC3UVkl6Umq0opeLO1fab1dFHk6C/lj85+fsr+W0qjS6mni2acgwa9/GojpSAUk2hBPdc0K0w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(35042699022)(14060799003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zk66iST5+ubCIHrmzMKTgE6I304wxaoP+KQUOYcxYi5HwJkgsRZ0O/nkOPl+9y+3eoXVKlPDArAmQktmu+Wup9W9dpT1SaG2pcAV068C9Zd1Lub05Tqhqc0oWAO74D//dAFsk+Q7phJU4xV64qFyS3GUOnPFDp/EULjlEVIf2ojSvliG/g8fj3qPHKJfht8Gs9sq7XCFkX0S/br5uu97RpLd4tzmyvPliI75lREqBnmaAt/2ConQvBvv+cUV32U7x4TbaEGhkMJiQKhNiGrIMN8362MzbW2Un8BrxsXJbRVZuaF9XTDLiS+A91USY3ktHb03WK4xUoOd+tnR8kMcb5zTyxU1qjxV2nrO6klnWnUTqlJ/kFijm/9tSEmvaghq1KIUrNIAKSWe8dGdB3q10cq2hqWreBuMBeo/WGzMnwult8axCBIztorZjUaIZ3Pf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:04:58.3812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218d05db-5d70-4788-ee99-08dee310edf8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8059
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

On 10/07/2026 17:20, Naveen Kumar Chaudhary wrote:
> sntp_loop() allocates a netif via net_lwip_new_netif() and normally
> releases it with net_lwip_remove_netif() before returning. The error
> path taken when no explicit server IP is passed and ntp_server_known()
> is false returns -1 directly without freeing the netif, leaking the
> lwIP netif structure (and its associated state) on every failed
> invocation of the sntp command.
> 
> Call net_lwip_remove_netif(netif) before returning on this path so it
> matches the other exits.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
> ---
>  cmd/lwip/sntp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/cmd/lwip/sntp.c b/cmd/lwip/sntp.c
> index 608345c873b..a3659c73ce1 100644
> --- a/cmd/lwip/sntp.c
> +++ b/cmd/lwip/sntp.c
> @@ -71,6 +71,7 @@ static int sntp_loop(struct udevice *udev, ip_addr_t *srvip)
>  	} else {
>  		if (!ntp_server_known()) {
>  			log_err("error: ntpserverip not set\n");
> +			net_lwip_remove_netif(netif);
>  			return -1;
>  		}
>  	}

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Applied to u-boot-net/for-master. Thanks!

-- 
Jerome
