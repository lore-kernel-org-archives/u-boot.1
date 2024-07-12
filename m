Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32EEC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 09:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D0B88756;
	Fri, 12 Jul 2024 11:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ChjPO7Nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F128B88771; Fri, 12 Jul 2024 11:07:25 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C038875D
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 11:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDXL3mt8Tooyo6+Tm9OH0oZ1IzkmSKisC9z6VH1HInbW3oq3Os5BRDF6zRyfYTYWaKf021md2qr/XLuEuE++gIbP6lo4bNnSXg2XequFHzWItjnVPE/Fvh9WUAvILVKNdjhQ9LLn3brcR7TkgzRQKEvZQSSyCEs+cB1n0yuPUONmkQqB+ilLzd+A6Mvu798LjH1ZJHQGOhSIxna9TTg5mXa5hgaIqgc6pqmqVfRNSfHC5U+l2nLNwen4s6rS4vtIKj8q/4bNzVeA4P/moJnGWWb4ssnWv6YVVQ3n9GVCnNTxB9kO0aaHbQTecHJ+FdawQirKxeNec9t1zwftBof5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERy2V9dwg+RjACpwRSz9TvDM6pFORdeII1ZAqP/vEdY=;
 b=Pf6zjW13oqC5knQC//zMzCEkel71+i8ISSPvt903yYDYrBMnquYXMm5g5B70+kthH+nduNn28ToClFWVCeCPiPsk6KZmn/zsyHESn/G1RqSUkKI0kpAGGY2mtCbCrhtELAov18IqNXQEFDcsKsfud86PutT44d8Zlt5CtbLt9gDQyPX/EGW96hCCaGL9fA9u/WSgwPTBK1BLy3kuB1Q6dc3rmcrrYqL+VrX6bdSOlKWjJympli0NH+q6+qi16aE2+WiOHuILyifRGHY6cmOXcy/UCUB78pVEvOW//xGj31M2zdcntpK8VYC2qesDhS1kDu9SlZSXUglJupKqy/ZR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERy2V9dwg+RjACpwRSz9TvDM6pFORdeII1ZAqP/vEdY=;
 b=ChjPO7NbiQaBblwvqCJTME46zxiX7mF+pbMRD5/58y/wM606qBnXBwoM+CwouC5Jyj8RnkNPTB1GerUpUg1kWkwKEhHLpmq3GuWwkNlBsz0tFMId231yRDlUG0Cjrlmnpm5oeZEJC35yyxiXKzZfoB0B955dMW0pWXabQoAwph8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:07:22 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.016; Fri, 12 Jul 2024
 09:07:22 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/2] board: rpi: remove leftover CONFIG_HW_WATCHDOG block
Date: Fri, 12 Jul 2024 11:07:25 +0200
Message-ID: <20240712090725.2093317-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a1ca55-39f6-438c-af5e-08dca2520a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zi9Mcy3HlRj+CrRGjwFFfu4Nsb6Y+ZOW8+67IlSGharEvpj/toqE+IRTwQx?=
 =?us-ascii?Q?xwgxV4cTmXyGQaT5g8OZOgjPWSpznNZi1JP8kQK3jBbaZJmZhOvLyFq90vO/?=
 =?us-ascii?Q?oTuMvzI7X9RVlSnNWqWOFRDsM2j7MXxLnSzL5EaIUqb6s0W1hOxiBhwKxfat?=
 =?us-ascii?Q?l0xIzLpf6cdt3CmDdQ/iEAx5IKBmthpgJdyM3ojFtWC+/Wv+4yN4vVVRSDxn?=
 =?us-ascii?Q?y0uVkkCQLk/FgCBlJm6yL3vTHu1HIU6FQ/4lZemNMMu5VSHTx1DJs1P6nEG6?=
 =?us-ascii?Q?ctqQXHWniwtho2jMQW3i70yiZwHg2QWqO2pR+zh2D/IKotOCLTaKCCDkqcs5?=
 =?us-ascii?Q?vHtDnaTZVIpLqni5fHjqkAubvTWgqAmGhvPBPzAbJjZliKddZ7v0CHZygjL3?=
 =?us-ascii?Q?W6pgG/smENfQe72CHNu6LMa7VshccFOWJYue/v2R57lSx8BDdSi/D13g35LG?=
 =?us-ascii?Q?T2rlENAoQj3wXo8tFqkEmEaQDXp64/sh7XfcBlirO78zqG1qc5iBUT2LHyYA?=
 =?us-ascii?Q?rXXt7v1mvAOFAP6TjLBSQyecMR09eKaTsq/iUzLOhv3Eo5yH7WAYl+dYuOQe?=
 =?us-ascii?Q?oyujIZitPFMQiEMSBsX1XA0uVUnhaB/8Fx18WrIV7dWgdN5VtEdxIe2tJI2B?=
 =?us-ascii?Q?dQyDNVXfwIu0luOyiYqE2S8f1eK40JkmOuN7/GdqRrVHvJi1r6KsgfTvTQbS?=
 =?us-ascii?Q?Pv7YTLSWOZ2LYM1LKHWHNhe+rhr6lGmEX0qeTe0KEljfAEVfevd/cVzcqfZf?=
 =?us-ascii?Q?L/+W3Rj3cLPE9sp4BGDc9MnB2xfo8wAP0BsQiOPbnQ7cZTq5NZPZM5dGrV3t?=
 =?us-ascii?Q?TBxAu4qFpCWoei1xE3pdBhrROKglHBjWhq9ePJi26Fid1DBlq+13mceK7NUq?=
 =?us-ascii?Q?UT471WTZBz/NeeYCP/Z7GXubNr0fQ0+GXyl82Xm3Xdrub8Ysmc/Zfge4P05o?=
 =?us-ascii?Q?7dlgkBNTILtaU6+2IHKqrnpSVH73XuAX7jZ73/i5gfO+bt3ucC1aVvba7+KR?=
 =?us-ascii?Q?IkjOyIVs71H+mFqPXrL3dwcbcne3u17Juwg5j6ULT8tCfTLYOPpzfbB52Bvh?=
 =?us-ascii?Q?+kLLGyK7SkmRHaIPP8Fh7mLV9GHA2poo2uC4CK34KxTykamIzlafaRASUpUQ?=
 =?us-ascii?Q?s+XssJDs1b9XLV5Vjdpe/BYVZ5361x+ChKgLYYBsg5rggxMBvp7lkn6uRkG3?=
 =?us-ascii?Q?2B035oAmpvkX8x+bfg6OiSGBpkoIaf0qB0jmmcwvstZ1nBSYzhy+3vqobxc1?=
 =?us-ascii?Q?PzXU2/kbOrJpSkB1MtoxqFpRlfPLTO9N0BOYIwVycOuVL+JPjeEQXHXez9nE?=
 =?us-ascii?Q?Jeafjo7DgoiUTaWAOpyQlpUBZdWlgEGvMXE8u1dmeWAhms39+gAWyxXaW7MY?=
 =?us-ascii?Q?4Hd5ssW9XIulzBUO8ulsRfSUVqfTz2kKTFQXuIInscKZMUwvzg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DNIjlHeSyWlqOaAbpobmOP7cz3y4ulQFkN9MEJNW1VZDqDXmP3WZNivhcnn?=
 =?us-ascii?Q?KDux7h1KC5Hmh51eD8CrtL9yYQ3+V6gvbLb+bwHMS5dCz9fcr4BKQwWnRL0j?=
 =?us-ascii?Q?XeVNQ4CDAkOR9HSBrQFqCHlZQOJflQsRR/qWjwCpgSnS+OrK3T7atfIZqy7L?=
 =?us-ascii?Q?8zt9wN/2cz2yjBHR7hkqlwdYn+rUrzV3VLi5hs1Hzs4RbeQDRoxfZqoH0k5s?=
 =?us-ascii?Q?93Hu40YEeZMeMDUAQooz3r8OOAYrVkhFsB1Ae9siUfRCaxlEIK2MBRHk5Qgp?=
 =?us-ascii?Q?uVW3RGiC4AhTgfu5uKDtILnBxTjxdUFB1RhRGxXbWvfuxqbxk7IGek7PaEQo?=
 =?us-ascii?Q?P1IJ/Y87uNMyT2bpPKniugg+Ke0VLpjP1V1bHREGanAnZ9GumsDNdzJOw3u9?=
 =?us-ascii?Q?AOSLM6QQW/2iuCNboTo2aViyOfOJA6pqYZFk6dKcdk4w0LhBZ5MWHIVaitVF?=
 =?us-ascii?Q?l6ItEGd45inCbI4QiV6ao5KNF0CE4UHo0DBUAriJYUFf/42pc1tlIaGRcRpq?=
 =?us-ascii?Q?VOYfA0iQ0YP5vSUz/GH2cIGcIpvuxGkiSiEPL73rK8T7e6B3CUyW5joPB2Pd?=
 =?us-ascii?Q?qj/LibpBm3GuEudTcFJn6yglNsxW+2wsHPr5QcFhvsjmOgsipOr80MfB0sHk?=
 =?us-ascii?Q?oz/kRCJYG+hlza820mvUEjJhv/M+WInVEW42S0HVBsrRq3UAr+TtYmu677qM?=
 =?us-ascii?Q?mDU7mfOjqlEKOivxgHcHGGqBkVYQ9YuQm6fV2ZCyPBORn2so840X1HidyoFP?=
 =?us-ascii?Q?OBoMUySU8uUkZ7/5jDHSod7ePhD9217xrOV3Px46rHF/shUDulPNtjot6S6e?=
 =?us-ascii?Q?HJqCtOmKMSt7JFdNAmqASpB7wC1zyFgrblm3nXfvpkwORkW6n+WDZdYN7xjU?=
 =?us-ascii?Q?ciw25jGGDNlPtAvnP7YS9dZcPiZiUEGGcx3LPkHgNWu746AladW2S0bbzUqD?=
 =?us-ascii?Q?xFWQ4Zi/sL1On7To/sd2Xiu2XlpQwTNZzbzuqLig6sIpEoQFfemRDh5qO/wn?=
 =?us-ascii?Q?V+c2QZs6PXXI/m4CMT6ZkBeBaiSXSBY5TCqF8laiNto8cfAXM+3d7NhoBzRO?=
 =?us-ascii?Q?ODI6+UALUIEixr1wjOpAVkjGgT2T3uw/OogblYxuBCd6BYRUVzp+vEHYoXUN?=
 =?us-ascii?Q?WKIozz7pbvxGIsu+p8xYWrVPWgimDn9EVkdvdD5rvq+dQj2+xbj5EYe+8A8a?=
 =?us-ascii?Q?ooV8Jm8zKKVkj3/KZX/7XRCW1pPolznH7lucyVkOEmRI/4EsYebHu2TeeO6g?=
 =?us-ascii?Q?3b9IbJpLwSHxf02TzPNWL9LuP7PEbpnse+rlDsCl9uMo83QKE/xLMzXS5rcT?=
 =?us-ascii?Q?6KEG7i1SVX2Of3APyCKT3XPr9EpC+Msu37AEX9IdwktUAhwFC1/fUZgUen9i?=
 =?us-ascii?Q?I28VsAjqWFYYpEB0P2/Z+TpUxq+aPm5BtqQlaRVnnOpjXvOF8bj4qYylKcmE?=
 =?us-ascii?Q?kIxEPukxTbfhq+lob41xYg8LHsC9J0AUf30V6QdxBCjUzO0LYNbbhkRZFLJ1?=
 =?us-ascii?Q?jM6ksw4jxgSImHQZFcZJ70pKPugSSRc6jnlJ+2W+xLoHZBGAXEoZbh4iuVk9?=
 =?us-ascii?Q?5UH0uwicw7cRiF6no0O4OWn3wRv4bQQSDnR5jJJLVI91vkq/gOVVAZeW8RVs?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a1ca55-39f6-438c-af5e-08dca2520a44
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:07:22.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIr+Llgc5bS8SE/KGvSVRnh6ycFn/sRVdMUw4GDpZHeCGrdnLO9Hnfro6mQyDCuynMA1d9K3WMJ/ef6C1xz8/vz0s8JRNl0fQRKNC/NBNbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8780
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

This was added in commit 45a6d231b2f (bcm2835_wdt: support for the
BCM2835/2836 watchdog), which did do 'select HW_WATCHDOG'. That
incarnation of the watchdog driver later got removed in
c7adc0b5f98 (watchdog: bcm2835_wdt: Remove unused BCM283x watchdog
driver and its references), but this block was left behind.

Another rpi watchdog driver has since been added, but that does not
select HW_WATCHDOG, so this remains dead and unused. Remove it.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/raspberrypi/rpi/rpi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index d996eb0cf69..9a83cf2d6a7 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -493,10 +493,6 @@ static void get_board_revision(void)
 
 int board_init(void)
 {
-#ifdef CONFIG_HW_WATCHDOG
-	hw_watchdog_init();
-#endif
-
 	get_board_revision();
 
 	gd->bd->bi_boot_params = 0x100;
-- 
2.45.2

