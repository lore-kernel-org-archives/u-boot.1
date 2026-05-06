Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB90CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 09:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6A684897;
	Wed,  6 May 2026 11:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rdikRGia";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rdikRGia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F47084897; Wed,  6 May 2026 11:04:49 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE1B8488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 11:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=U5lSeHAg/P/X+kC6tlJJUL0qNZu7C8/O2j+JO4xt1LHQil6pqhdhQ91eiUYgPC0QOj2wWlvY4ll/A8H9SLORVs4+Yh8/h+AtwUjCYu3coGIvkda85dz6zWjrg39qCNeKVav1AXqaQl+fbguKwmuQ7VZxl5zI/ExgZ/wnUBMUT72yhSB/PB/IRcRxK0MxV6h/mvvCoEQELXJVWYv1oGlU4yO6EGRufgQ0Ih/sVPcQspjVotRmQuDWHpvzPdeuw9JymLFH4RCCuolc70GzGuFVsEEVfYTGeaTNgP3hlIErSOIuspZUITuYRxD5IZZ98eLU2SQwQwQbmCzH8t5UFI7hHQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2TOqPLZcgAeDScvmsOA7PRu4DltteybnGV1ElXxOxw=;
 b=RxXCUKbf+ssCOgL3/fKxqW8uUk2PSL8Av4hmE/fJCB4faWSf8sDXCctLdbpnIhSFsLKEXlE2I2yj0dd5k49ZFooti+6g80gYwat0+eBIHsJNta5ABmq/rwZx1pPm0PCxhv4sMoT1GoPen7bnwo0TqvpNTXJK/nH5SjCXRJ1hB3BiS5GOOzI1lYm8rPFz9+ehwvetPXFXz2SSM2VuMCEGuxPwv8RACCBS2O1a1RbaIM3J09BoaxSQXOZKqOeZmoj72r0M/Adzr/LBw19PouHSuRkOMXTboQhO9BgOBokrkEflPbmEeYDYpX9COkaiDst9jDtra8b8KUFt2Vb+ozut3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=microchip.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2TOqPLZcgAeDScvmsOA7PRu4DltteybnGV1ElXxOxw=;
 b=rdikRGiaWEsKs2D5p3oGEn8aMqpnnfuf4g94gQw1iI78TvkK4wftgXvRP88ap2LuNAgyhCDjaRO1INPQCvkWvzY3qvffzBaN9ZJeKi5ZadsHTIm+Zk7fslNsgGQTvKdnv7Gbv4fIgQutD8p29JByWzoVS634a5xdlM4/0Cxv70Q=
Received: from DUZPR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::12) by AMDPR08MB11676.eurprd08.prod.outlook.com
 (2603:10a6:20b:73b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:04:42 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::43) by DUZPR01CA0111.outlook.office365.com
 (2603:10a6:10:4bb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 09:04:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 09:04:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHOzK1ybPngVCFKDsV7DUeAASJudunaHxzEK5RkMeUWqr6+UPsRnenjWaQCmz3ZRTd6lMAEvYgNv96WuMmvKyQzART05upOSpd5WNsJU5Ec94xFRV1HLj2gjWyeEr7Har7hdLtrKnbmDOQYsQEdlS1GkDnQkOf0zf4bpmmr+gGLujst7LaYtlTqgX3uSi+MgUpFLZFb3le7Mggr+B7JmCMOHP/enLPnneuQGiqu7fkyzXkphVFcqAFoHSiGwJhdQJ6ZLh0n1077vQBR8PBKmIAx9kqho5708LzFE1bTycUk+iM5esJazkflf2JiMsyrXnQTHeCnQ4Yp6YyGmRTAQ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2TOqPLZcgAeDScvmsOA7PRu4DltteybnGV1ElXxOxw=;
 b=NE/6NTPzqwqF9W4340pb+idzAtfbn8UplDPAksqCR16kqgADM9LpRRrqS1TBsctn4s3pr1SAUTGqbb8OxEtgIT8RqUly/nfgbMLzi7b5rQtgu35IiN3tgG84oI4CbTmsNYFxpTwydvH8D9laACoN5jVz3V74FwaYJ6miwqcZa4U7TNvQ71xm6javQPSfueSHjuWaR63W3JM725qmFRWA8yfyNAIsfCnVfcvOo+xuMEkD65f8F3MiKB9E2kYnrCMknEEUklic/bWKP0nxm62cWJdyWy+KwvABV44uLR4ZjwzK6SVbeRREI8hqdzx6/krXSTfFcUScPIklmaakqEze5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2TOqPLZcgAeDScvmsOA7PRu4DltteybnGV1ElXxOxw=;
 b=rdikRGiaWEsKs2D5p3oGEn8aMqpnnfuf4g94gQw1iI78TvkK4wftgXvRP88ap2LuNAgyhCDjaRO1INPQCvkWvzY3qvffzBaN9ZJeKi5ZadsHTIm+Zk7fslNsgGQTvKdnv7Gbv4fIgQutD8p29JByWzoVS634a5xdlM4/0Cxv70Q=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA4PR08MB7570.eurprd08.prod.outlook.com
 (2603:10a6:102:26f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:03:36 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:03:36 +0000
Message-ID: <79ca6bf5-fe6e-44af-830c-29e1d072cf2d@arm.com>
Date: Wed, 6 May 2026 11:03:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: mscc: add support for the VSC8572
To: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>,
 Michal Simek <michal.simek@amd.com>, nd@arm.com
References: <20260505135750.3137160-1-charles.perry@microchip.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260505135750.3137160-1-charles.perry@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA4PR08MB7570:EE_|DB5PEPF00014B93:EE_|AMDPR08MB11676:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fc432d-58ce-4ad7-3e61-08deab4e8286
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: CSldhVuOTknJIPgmoivJFiXVDCXh+rjA+IAVLGUUS9krOsr5wABdyAA0SIZtuvivgDH9FSVeF1Q0eHMKwCampI/T+7PejAJMSDLXxP40jaUdza1PU5+56dwo+BSsC3/rKEEixJWUS3HAYTtO7LBrkEUgfLaf+AM952Gb+cG5JvJPsluXh/DkGBWo23l6IksvZIglS1mTYyyH66m0NnLgCbkKIqlZGpst9HC2aGa9b8UQczoGgrpzAQTIYo7/nMWT3yGRy09HCVyM32Sw72q0uE1cwrLONq37QibAV5LUX2Z4HSIKDjoxLk6pFSyxHKFBrt5v+/aSSjeBll0eLI7aRA63SvspLCOKzzs3EtrrFmqxkb9QUnXAFg55k1BhZQSR5MIT4iekFB2Gi1UupcOQE67n9jJDsRPiUlEf26DA3ZSS4HWJJ6zTpox70HaGw73NmcdFhpxmkDjtPFKXq/EnPcOt4BbEbxopAAJ+KA7YqBQt9ymepYkf9c5k+I2qnID5JLZ2fyKltEqniFGA+qVHJ/1+Qgow8sJ19RZN2O46vADRGXVVggxhJW5b3hGczVsm81v5Ck1ofoDIUxzFYw0cM+LT99CrAvhHUN42Lxykut0YEvfzgJx8KNBZ0rkYVlfb+O4r2gUjJbx21hBggd/C2XV9DVZTeJKUELWxoiOENSHzqt+V90trp0ucMDFvhpHX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: GYDy1Q6y5ifwRpJFZwcPtDzgQE3Sfx4yBiIXzshZNfkq6tqWSyMnpqk7HE1hinJprg1qghVAng5khL1EHm67xNWyBv/WkMcfAdzwNymQHrqKuhzd9cjHiyq6lN0ZQkmjq/WltEGQxcHPRhUEmzV5BePsOziHUc3oNnAmuc+P7z6zhLlmjUSBxigYIZ8lKOYF3N2SMgOT0DOiA6Bf7+1GAKx7GTSc0stl7ebrZQBhCoX4s/SMHcMeYoWnj+f+BpfLOFlUHYIE55k6IwQvfbmWIG9vxT/dLPvIQN1A0/WWFMUXlBcHlEWwIr74PkPsFUPwJk2Ho0dxu66yRbrUK6hF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7570
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 723c6c26-04cf-4bc5-ca5c-08deab4e5b86
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|35042699022|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: nqxtE+TRMxtdayU4RWd0hcFG1pt/u/ZprfmsbjDYcFuiMBgvfcbu9WAaeTL/lLcIqdoONXqvnCLZfmeMJd1cqCvj9aCvxAwydE5y6oicNpylYUp0MiEqS1AgJwg8/Uvxv36NypNTvflAzaCgaTSUk5IDudBLX3x3w7Ko6b0cJjlapnQ9e4/UYXA/yVKHxONrarrByHRn1iW5n47L6LNjCzHlka7Eu2ifh7ujkVLcyAAx8K8uL9WswJ03ZgJcBZayqMaz2MnNpmRPWdgoDIzHjRgmur9IZUv2MBPqO5QUYLA9gNLSpBJPIaLg893s41YDTypwxxgGwrWr20EV9h6mHx2sfX1DH1wgGjiWx/v5zSmNja7llzTAOPsbSjsuhoZCR/KiR+wPyRUwOgMA3nYvamyKGM/iCXey/oo0Cw93mb24jH7BahfQ/7zq3x7+VoYReq4L9Nl2+yotS0tU1C8cGESttcQTP0T9wC2rvszmkBAF8nFwjfqbOB2pjYKULCbZ3fzmts1thZShD9J7sY4jVg6HF40OSZNV+NII77yIhy+/zrM0woKP1EhS7vuOwIP4T9eCYMI6r+r817BUan4OP+mBfhs+V5SzCbAgqFnh01Gd45LvBnPGj10FomHuQWsnMKrh8ch8bd/+7LJZTLKGw8ozgUv7EsUjFyBKc0+o6Qt7ZEWYbHhzE9sMnkRIBq4Ykb0ZxjJjOBEmwcY5xWJzJJgzL6gG7773AAAjiM0c9B0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c/nzABJ6+w+eSiR5Zf5ZY77DyYLo4mbjwVPndJ5LiqbC6RiFxJB8HXqJ2ffgYIBR4YK6uA6URU2BrTzKWKN+a2KH4X2njF/RB4GXdvrY8b+YJeI+ZoYpmVqWOBVcUPBxuHRg3Ys2EzYhFSnj0E9uIrQ4+xMgnR+XndafsitkLnJnVSpT3N1jIXYBDymC/zhswIb87moaxdtBwxa4HgpgOvjCK7elQm9rK4WdDtb/UpPS3y3IhiK+fDwd1fUj6QTpZB2U/Z2wN7xytkegwuQjzWjHZB6nxbm98/kWtjNsOvtH1YbJS2vCWdEsDU/ci6WkirVQojDtSJ98QiVPqctuVF4YH34dv6zzg/+rpejAePxhNw09MmdUy7861ko6EecriX4PX3f3iKF1ptfGU9lLPgJmpMmjjaLUnpqZbtTHJGqpUHS3642wAOwx4me5HPsp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:04:41.7721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc432d-58ce-4ad7-3e61-08deab4e8286
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11676
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



On 05/05/2026 15:57, Charles Perry wrote:
> This is similar to the VSC8574 according to the Linux commit that adds
> support for it [1].
> 
> This was tested on an HX1000 board with SGMII (PIC64-HX SoC which has a
> GEM MAC).
> 
> [1]: https://lore.kernel.org/all/dfabe39a52efcd2cfff9358f271b8673143503b8.1480497966.git.neill.whillans@codethink.co.uk/
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  drivers/net/phy/mscc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 16387eea41b8..dd7a10047bbc 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -23,6 +23,7 @@
>  #define PHY_ID_VSC8502			0x00070630
>  #define PHY_ID_VSC8540                  0x00070760
>  #define PHY_ID_VSC8541                  0x00070770
> +#define PHY_ID_VSC8572			0x000704d0
>  #define PHY_ID_VSC8574			0x000704a0
>  #define PHY_ID_VSC8584                  0x000707c0
>  
> @@ -1623,6 +1624,16 @@ U_BOOT_PHY_DRIVER(vsc8541) = {
>  	.shutdown = &genphy_shutdown,
>  };
>  
> +U_BOOT_PHY_DRIVER(vsc8572) = {
> +	.name = "Microsemi VSC8572",
> +	.uid = PHY_ID_VSC8572,
> +	.mask = 0x000ffff0,
> +	.features = PHY_GBIT_FEATURES,
> +	.config = &vsc8574_config,
> +	.startup = &mscc_startup,
> +	.shutdown = &genphy_shutdown,
> +};
> +
>  U_BOOT_PHY_DRIVER(vsc8574) = {
>  	.name = "Microsemi VSC8574",
>  	.uid = PHY_ID_VSC8574,

Added to the net queue, thanks!

-- 
Jerome
