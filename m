Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31AECD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDA7843B6;
	Tue, 19 May 2026 11:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="EkBMm1Tg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="EkBMm1Tg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635D28465A; Tue, 19 May 2026 11:28:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E123803C6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cG2R72jkZQbS3uM7vOglArinTR+c2sf2hiCMmPg+ObM1HaHLwk/U0QgjRo2+dghWWUsVhZJwub559Y2wQDJyattalkWt0eoxQHiOIxo44xAphtFw9Xx0oxwRicDHldQDIoW/skqgjTMot9254NKUm7Ci/Ddc53Ctk//GIMN5UaS19AcFVikBQcBHu/5EMCqkjWHtkFR1eq6f4BLwhp7ASidtr/uoBdl1LRC27RsuJZ2rQtv7pxc+qqbkhC70joPYIwEj/BWlEIC43JAGUcFhsyXJ8vZrLzTKxLXDaJRqBA0nAhiglcWd7XTK7RZLeksBBdItR01KCfxFg1CNYRaCWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dcrak5nFLtH7xPrXW+0Yh/ovFurBkd67UPluWss7q6I=;
 b=KMI6OrC6PZ6yQuvk1zuZBIv6IM5U0T2aBy+Eduw2UE9fnKsQVFMA0gMbPw2DxyXq39U7hlojWSgxmcJ9SYSqUJXtDBi5CxGKhNtlqbDY7PXYaA1xAsyK4JtTGLlxXZs/UuOhY29sR+uZAVzZJXlfq8++w9iAcYHDzBKhivRNG8CEsWA+vqpSfb34HaL6iyeEKxDZLIUGKXMt51RCA8kz7NLjLRQOlW5LIa7LoKpZ45UkUYJRE8qlbCbSJj1ErmZyUASbEzw6WED8k6BAL+QGntQjHX93KkAkh6sFANZLCUrliWPWpz0rvoPPODQW/oT4sud0cMOPTB1FF6gFmJyW6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=outlook.fr smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcrak5nFLtH7xPrXW+0Yh/ovFurBkd67UPluWss7q6I=;
 b=EkBMm1Tgvb7BTMt6ClYQAA2wQKchWCxIneTP8Y+8FIjiaHDk/TaC6XgbwqkkTNf4LO2ppIQpmMPVr6JdYqkmoqWZ4DK8CRDgp5Jc+fGcDPuGQyuCe6GjWprK+rQrBCoEfkD2RnIZDA0GBdrUizwH8qAYHmQdvA6udT3/I1iswGk=
Received: from DUZPR01CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::10) by DU0PR08MB8115.eurprd08.prod.outlook.com
 (2603:10a6:10:3eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:28:09 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::15) by DUZPR01CA0054.outlook.office365.com
 (2603:10a6:10:469::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:28:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Tue, 19 May 2026 09:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqMZ0lK9CJG0eTSVs3Qr3BN6QQ1lCDdUZaHbMHJiz43dAWj62PhFPULREBtNxfNFjz99QGbtmgXBbpolRctfR+a59HpkiPnMNoIT5Hum6AzB5HArkedWntGwBiWTWTMfAMK+tGwWQJCQJz5Z+pL9hHOH+oQSvS1GGY7X0LytO7OOB96L4onXCCf35/WvaMEa/h/dzYZcEbtJzaUjwQxFGa0HzK52OKPVCDRQ3vmJC+n9Raidiao9o/9vS8u+zHUIasjaT0nlYzZcKjhxJ2gytTTErm/8xJTERLyuS52UKnYJt1QHNqDHquVBlr9e5xFtcJe9jedqAdDEuyV4NfT9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dcrak5nFLtH7xPrXW+0Yh/ovFurBkd67UPluWss7q6I=;
 b=oAv9Ddv9a4QvKo1e98fal4mb5hs87rF1Yo+lrqiotfbsfzBwmSCCAcwTErMqMAUMWhx/YPyAZUp24pQNZ9CKrb08HCloMSenrr4EN8yj5/qZslbXxXjrWworh9EwlmSqZEGEhfGXmydBysxPeu0qnYC6/xQ7QuTdDRQowtEozGFzkHCRIbA1H/lfxugptfKHbzI/jUHliTU6F6a+MBwyyZ7kfBpLfUAx6lJyAFjn8M36zcsrW+PR5R1j2ROph8bMI+FT0IZ4rT/Sw6Rp/Aa92ATi96CBp6Ir5WR9Pwy1bca9hKc4u7ioBPGZI8bgMVKTOMyVB0uy9JsKmtcHrqCyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dcrak5nFLtH7xPrXW+0Yh/ovFurBkd67UPluWss7q6I=;
 b=EkBMm1Tgvb7BTMt6ClYQAA2wQKchWCxIneTP8Y+8FIjiaHDk/TaC6XgbwqkkTNf4LO2ppIQpmMPVr6JdYqkmoqWZ4DK8CRDgp5Jc+fGcDPuGQyuCe6GjWprK+rQrBCoEfkD2RnIZDA0GBdrUizwH8qAYHmQdvA6udT3/I1iswGk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6082.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 09:27:04 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 09:27:04 +0000
Message-ID: <92bf1b6e-d43d-4a10-919e-661f6cf4849e@arm.com>
Date: Tue, 19 May 2026 11:27:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sntp: Check packet length in sntp_handler
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <BESP194MB280543D9B308D6ECEB5C6A53DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <BESP194MB280543D9B308D6ECEB5C6A53DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0266.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6082:EE_|DU2PEPF00028CFC:EE_|DU0PR08MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2ff1c9-a0d2-40cf-9a1c-08deb588efe4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: H34cRXJqJ5K+R7Eoz32iGysaaMVsZ5YPC0N84cvBuTFebbv7pV/QoOFZkN0izRiHKtCfL4EeIqw3n3U5PbZg2oZMIscv4Wy7Rlp7V6jdF/itVK5Ke2fOhRoBGNFVT/dN1l3F8W2WOMw3PXAK9EnIK2vFdqZjPE/QpVHUVlF5Gd8U1SR4iAwT0vqLIKJk/kQID3+44xeupPeTFItnM5LH/HiUhsvvjLZk2enEN+a5nJRuF4zd9iFek2QTuW8TohBUJGTOyf/62xwmxc+OHho0j9Lb3/oRtoi15jtA/16bDMBaYNXxFGqHqwRER2K7leWng2MjX2ad5sDqeJath+wvuSqJSAfs9Z7ttCkegb2u3dHe4pLTd7EYxKOG16mvrKHDl05uLoyYHOp2gYe6KGMjcwyNVeAFwoYQ0MNkNqozEH1SJMsx3szs6RoA5nqhKPm2ZMJGQqgbmfxMOk9tGIpgbVmgZBXfOqWzPSRUQSIkv5AsCfRHrVOVZ+hVZU4dDNtk71tWf1Gb6p7KI2OtnMZv1V4H7bZiO5COvP4rfW/lKq2T9StLDFTXHhK97grKoe2PfkjfmWL6/oUEL0xnjcbGE9SF1hT27ciw8LNTrtzYbdcerivtEwqCyxktYtdDqcPEq1Znar+Q8++1nHcMZu17ufp43x2M2HkaYrz7Qs9rYZ63PpDUD0yhDMiwoE6fXb9W
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YTC/DkrZMqsHQ/MuvGX5zxsAzdeDUHVZySNou8VU2nJ6TEjCn10FS6wSpoie9NqtLO5L/nBUE6UcQv5LIADwpK479llAP7CDKDdr2e/JRD9H05shgKH0KF62LDQJK16eq7DxY5k77gxWdNklou2FgNwLuk5NCA1j6/3AE8nplvW0lg6AHRuXIOia62a02oCyz2boWDF7gopSn2/f/caGzeDD6x9SM4HspUxtHCX4ncDs9TzgIR8U6vFtuxHWU3Mb++8kAwCuXayR6kXFDk6Ix14fAc0krIPES+jasWLmmcIfMduI7LuCRc3mmlIGmmVLAEnvRmMGOUmnMtgdVJZv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6082
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 915f22de-5104-4da2-b649-08deb588ca52
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|35042699022|1800799024|82310400026|32650700020|14060799003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: RqIlF0NLD3OYZS5RxYZpnjAV/wxf0OqrqLKG0KW1U/sgFgDxeBgK+UXFA9bAzMsPcRuiCRUEZMsrE+2XZYhuJOGHYNdsXUBDQa0YywxqA71TZVHQkWEDHO7RYNncAAiVIqNPHRZooEW8K3lMrdeE+d9fwoGDyPhGd2uMJI/ABmrHgKWbvANH7Hal+k4wPm5xKkmr2VWcFyfUlN/REkt5oq184wx7D9A5lC3hSptck5PVqVo9E71jL5UTVoAj1vxZXgFf3kk5hpUXk2GKmMbhZ9ZEkZaW9YHBv0yAJLzFtOiqrSO0iRxeehjB1DEXzK5EutG9kDzL6T6Nt5X8kNI0Q8eACZv3XwpjLiAGb4FEuf6+43aJBacigxNDZkzjAez3QqLB5T4DaJcMbNEBlMqhq1pXWDfKpuolVpLQWzCZmkxuObn7h6YRYXbcKK7p0UN/kCi/MXmaAkkTDGbqKQjPMUh6kCiw+7/I51pB3D8uTLjjdBs048ZFAuiaQXry/Uz3toNOeFzYVVcVhQcVdlNfipZDZCch94xlx1WnrkEnWc/oZrSF4GL6E5EZku3qUPJQszqqG8dAV4A2exOzHRcp1CL0dakHUhywJPJi8nYRbGyMolKndeog8MFaakBztNibMdGPFUOh2LZewr9a9xpzOT4nm8+hR0ZUXVWzh+WMzLrGO7TtUHsOkrBcuzEUUge4Rd6GVy3pBM0K7YxCcy7mLLepWew5+Rr0/AiAficPvko=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(35042699022)(1800799024)(82310400026)(32650700020)(14060799003)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bt9EnyEORyiOAgEk7aSqSID0W9vbYySRZw7xfYGOeEZb0/ecVKdLAOrTXKZqO7xLdsxN4GPAi6z4UA5N/rjYrHUja1J8jVo/l+yN4nraR7slaICVAxzo9ZS5jLY6B9fp3KBXcZ13ffja9olEqG7hMP/xVufsEa+6ZnHgVz/7f1mluoKC2SUYiSkB4T81aXBqCrcm6CfbaHpPNWHzWPmAusFByKTuE9HWX1G3bA+FZrKPqiKFYrBkdgnNIdcCPABAsMSLT9KPuPzEHMfcWYh72iV6LE/7clfJJbX0HWMyAkezfgiaiYTLJgSKQ1981HCe2+7IJJHm6a3yMAUK/6wyY5LXBaTJmXt4tOtpGQYJu95x7XI9U4qimnYTkhzOazpfaUtUwg/C7wdY5lCGsZE+DED67sIs2+/Aqy4CTzYtRvqBGC7kZYFwjokfbO3mYwgn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:28:07.7129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2ff1c9-a0d2-40cf-9a1c-08deb588efe4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8115
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

On 11/05/2026 15:37, Francois Berder wrote:
> Currently, the sntp_handler uses data in the UDP packet
> regardless of the actual packet size. A OOB read can occur
> if the packet is too small.
> Fix it by checking the packet length before extracting
> seconds from a SNTP packet.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  net/sntp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/sntp.c b/net/sntp.c
> index 77cee0046bd..4b3dc675bab 100644
> --- a/net/sntp.c
> +++ b/net/sntp.c
> @@ -64,6 +64,9 @@ static void sntp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  	if (dest != sntp_our_port)
>  		return;
>  
> +	if (len < SNTP_PACKET_LEN)
> +		return;
> +
>  	/*
>  	 * As the RTC's used in U-Boot support second resolution only
>  	 * we simply ignore the sub-second field.

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

...and added the the next queue. Thanks!

-- 
Jerome
