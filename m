Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8137E8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BB484308;
	Tue,  3 Feb 2026 15:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="rQCgs4nV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254008423E; Tue,  3 Feb 2026 15:43:35 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA08842C9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBv7YefdUEnJE1Au/rUVseWxUAdbIQaFdGNJ96sFdfuPaH4P2AIasTddmKvLIHJXb0IwIKd0A0l+32uzAY1/W2S4RstFQ0xTsVKqAJx/UTHJ0WTXFJTFd7SoRDdjBM3gFZDO2o+scRtYbWZ8Ds2tSr6Z+92LsOfxX952UAVpeAJiVQAeJi8LnQda+tB1nwsXOBIFnMyapvWLnh4uw7ZEmT+ta+fol1zV9s4JJwWMIOiZmCiP1zdGcRp5IBf14xaK5xNLwI9S0eclG2iCOuAm4DlGEtvELPqJXYAHb1kdUKZypUAbaBOugVmCTG6RAvyEndoH0nvRBCB8lo7pCtP/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVC0zunKks1V1sxVNtOhEsSimQNdX4wmstfc2cBydYE=;
 b=sun3mQdPix87Zs6oSuGxsinMCd3yVsUwpq+6tb+DRqmWh5hC0A9a/bzazPvWMZtpk9o48CaWCLqRLUzXdgEsRN0hY23bxlPisVI3bTF2cVKg/GNy/7bITsjmGHeyUXWdY7QRqPNDJGpxV/Sf1ewbEx0NF2x8ALr8wsJt5wMnHXryrpVLD3yMZDCKFi1kJZamYsHc5RxX79Dek0APFHdkXXhs5a2st3EXGuep3KwB7nhigXFVC/XR1tezuLNSo32kwmdkqnhoooUEW591qOAoc74jisMdxiY/3wlb5O3FI/6k8ioR6/GDvM0DJb35IKfXmjaB7suu/ye0g0+XhpmNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVC0zunKks1V1sxVNtOhEsSimQNdX4wmstfc2cBydYE=;
 b=rQCgs4nV5dUuhRiZgk1SyO21loWLeQu6hLe0hfpBZbwwQhKOaa2ibiMy+QlE2xfI1w88GiX/Lz74Wf7K60FDm1LzMJoyz5xD1GO7lipLzp5poHUMULlD3Nul2ALYNbVW5AcPKibdTa/nFOhRibJnfo3aowfbmLsd7kStBmTJ3d7PisTNZ6Se/Ho3tT/nwyOLvANRHq1qBbs9NMtuZSfMgUJxoUGTA9145rKTMIjVr1OtwCdRN26MlCU6K/bWE/emiTKTNEWarchHYqhZuwE9WC1O87nyilsqODq00BxOZxsncPAyZETF05bfbzhFBef9qYhzrcujy4InAf4tz7fGXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com (2603:10a6:10:371::13)
 by AM9PR06MB7267.eurprd06.prod.outlook.com (2603:10a6:20b:2cb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:43:31 +0000
Received: from DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c]) by DB9PR06MB8439.eurprd06.prod.outlook.com
 ([fe80::18c4:93fb:c621:fe6c%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:43:30 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 2/3] bootcount: Add missing count value masking
Date: Tue,  3 Feb 2026 16:44:03 +0200
Message-ID: <20260203144404.12093-2-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203144404.12093-1-niko.mauno@vaisala.com>
References: <20260203144404.12093-1-niko.mauno@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0000662D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d1) To DB9PR06MB8439.eurprd06.prod.outlook.com
 (2603:10a6:10:371::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR06MB8439:EE_|AM9PR06MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2431ce36-4d19-44a3-ed32-08de63329951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8do1CWSlEGkKNal6SVSEMmi9vAcKUlIRaK3giZPANeOOhyd8kgKI9Y2whfRG?=
 =?us-ascii?Q?O6BGoEAB0sAW16km8ULOIqmoP7nwRBLOKOWiPfO9pzfTgZhzCZfaXS0F74IP?=
 =?us-ascii?Q?VSpl3OGJSl48GZqgxw7sdV9mt8bac4nmYSYHgzJGnrMDcfDe4exI0TMaIzG5?=
 =?us-ascii?Q?0RUg4l6KlJS3UfFD+jjEONtZ2q6C33d5Re7obBrPQDikReHuBTXIe7tOaKWp?=
 =?us-ascii?Q?TGgtcwjU6VnAUvgaehXOruuVqJ8QForrLhimPnL8nlXbqYHAW0+8aGGGsHHd?=
 =?us-ascii?Q?XVpqsH86xrnHtImycQKe5n8++gKDIJGyGD5ogp3hJgzueumrD5+/ZpUq9XsZ?=
 =?us-ascii?Q?YImEBlWOby3u+rJfaJY0yvx7FKUjfIyZwTex0jmYldiNdCMfCARjWBSdUqKn?=
 =?us-ascii?Q?1zo7zyditorZL8EziSVWL/8JUaJ31efX5i6tbojMZRSCVGGa0kTwRP7HH9W/?=
 =?us-ascii?Q?Xr28PxB34PruCT0Q+MJ0gFnrdSByRWF/4U5y3/crmkFiIfDNydynR+HDJ196?=
 =?us-ascii?Q?tRyeRvZgadENoyelFO1JUISVh/nXyuDJ8WTRdLepkIR30uEEz17JHLc9Ncaj?=
 =?us-ascii?Q?CWYBL6M5G4wVESB3YvzI9LrQKO49WC//CbP3kk6fiIIVPvdVBdyTIOGYUImz?=
 =?us-ascii?Q?z9Jr3NwEoykcX9uZ6astUbwcuuiSZqkmAzhDyvMs4/Gop6vudt7MXvTjm7ak?=
 =?us-ascii?Q?lmxiHtNqQhv4YLh78rIQqBHS+0rRWQwdmEyMmTvGbYgunRuBgo1GzblQ+CD2?=
 =?us-ascii?Q?JidkS7HyNipMca0ykLE47nWb37vOWwl58avuh9bFcZ1AhfdFdRifuBNndY6/?=
 =?us-ascii?Q?yBonkBi6p02BNna1+MJqrl9CeIjBSVpMFMSfnaTrPVNY8CUT8PL+32PZJKJL?=
 =?us-ascii?Q?3C8A+YS7phmYu5RaV+qSmgSc9OZ0TKEC44+C7MjX0GHXqpkAyZ81uxxqc7ZU?=
 =?us-ascii?Q?bNeKdYCkm8eZ2Q2i2+Bk3rcssAG0fXBZJpQdMTekpNhPXb9CWvSRBc92Oh8B?=
 =?us-ascii?Q?CTORMYvZTFlGkj/H0k38SewGa5Qh6KUGdAGyswDaB5SrZgojh9/wSGAhxeNB?=
 =?us-ascii?Q?rQn8LQ+sz4ZIvQmsnZRxnk6jKIYXXZVTsoZKG6+0q9Zon0KFzuFMKFUPHySg?=
 =?us-ascii?Q?e2XPQQWQzUCv0zoKVzJYy8DYEvRQR6mPzzPMaUd1JG+zFhK0Z2yEiDQAUnMC?=
 =?us-ascii?Q?taaeXrXzFKJqWpcbC477wl8exCTXnzLZoWylLKTlVfy848l1Qua7PS/EhyJ8?=
 =?us-ascii?Q?X6iLUn8D7YmgHXgSSfNdlK6OqJRBVASg4l28WhPjPXO6GNDSdy7j4O9gnAzt?=
 =?us-ascii?Q?ytYOMcCxXmOImxI5MBje33RsZ0hwBgKWW3ka+RoalNsQFT/9jfV9TEdshLZx?=
 =?us-ascii?Q?N32jCwMyffyrarxVgdit+z3TgNhj3/GqE3ztryDzNcCNeD+JHTH4OdjXEcbY?=
 =?us-ascii?Q?qzOaC/Pvk/BGXQEYnN6nhU0ppNgT6xZdsrldJ3JcfC3OEcnB0PxFyVCKIgD+?=
 =?us-ascii?Q?RWVyFJe4CUSg5Oi35NV8ljxnTgfhO2xBkvxv4/hJnc3pcbShUtwn5Bw4/olK?=
 =?us-ascii?Q?BO6MULX8U0PvxLyY6JGgvFCaTnXy7qHR0U12RU1EAK+MsmMR3iT0xOqdYy+b?=
 =?us-ascii?Q?l+PW39bm7TOZ2EZsITxdkKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8439.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wm63GvhLqv7nXJAjRD7X2PObIpv7Ljoiq072U3zZIM3jQLOH9Dsm8lITi0QE?=
 =?us-ascii?Q?pKyTYpx7kNMvFK03j4X0lBNFqfHkvaeIGVFZ/lQZl2AGgZbMQvcVW7mhtEOX?=
 =?us-ascii?Q?gfd5Dgx5VTN/QFe6eo2fdfhpXaBQAdJ8o0B+OIgIDFEw8+xS7XXRvuswo2rD?=
 =?us-ascii?Q?1Y5gjxeIZvIuY5AcEOnYNYnGR69b32KyKWdtWCiXkYW3w9qTkeODSWDoAnGp?=
 =?us-ascii?Q?TBLFvlEfEZtiTfDvZoHaQHU8pkM5kMFUg9gcg0GBbI9eOYPYeYx7wgBN+gnL?=
 =?us-ascii?Q?LiwJidoAyUT5Hh8xbnKVkig5eHUezuhlYScW/bE6oyGx4W2oKPnwXZBbubnG?=
 =?us-ascii?Q?5cBxK99N7+OB+RIFXdQQ0PfPjpMzpSxHouvmffQWkVyA+VDgi1pSye3s0n1m?=
 =?us-ascii?Q?UKAnOwcMNeYWbO4k4wykkwYUBZHEIuqD+12uG6Jl1iD6A9adk8+0rJnXV+Tn?=
 =?us-ascii?Q?dgmlBuly6NOECQpKS1K1E5gISKhdje3Lfy1z4kyj8+GDW0I9FSpXb74P8CeH?=
 =?us-ascii?Q?xPpFdjcG4MA5oebyrbe4VJlPNhQzy7HjLb6AzuZ3KKgqGG9ak0R+8+0bqnUM?=
 =?us-ascii?Q?eK/9odG1gOIrof31aYsadTqakbFELPm21pBP8soh7WbOH08EGKy51hYxzI8S?=
 =?us-ascii?Q?VnqyBjCWO5Kuhv2XW9w9cX9zUZEb+t1vGrdbGZLzpIsEyKp6Mx4lDd/Z0zYY?=
 =?us-ascii?Q?NFSFtn28DQMQwrrQWqghHm0MIk32Q5fLcrYcUbPTobTYaA1c3ItjsgCgqzsL?=
 =?us-ascii?Q?KYw67LIkCYiXunvLcQ8QgWogJu9R9EbQVQhx0wvVu8v4kHsQtxSjw/lWoZAL?=
 =?us-ascii?Q?hqzrS48TIeCFFVIgIXXXFY/aW3tplRUb7BXPQcKca0UPU1ul4EPws4/tYb++?=
 =?us-ascii?Q?kHEwBaOx1lAbglPGcxtl3COAt1Z/aFkSlcEvLBI+8hqWFJTKwjdyuDIjko1T?=
 =?us-ascii?Q?TKfLA70qEkAaKqc2mHzSX0ortzZD7yW/Nqw3xnBnHhANa77w2ABroG1C6Nhy?=
 =?us-ascii?Q?CclSgdfB/5+84PjzlWam0Ni+mzbtk+6owI5gvJ8YpFx4MxN8ItsAN/wwYdlG?=
 =?us-ascii?Q?BXRvFHu9NI3wzWnpfdjlABKPa7X43DnvXvyuP/qiDCv1AcrjLv9HbdE9JAe9?=
 =?us-ascii?Q?om0N/BMU8saJ3Rz0SkBKmWEyEJPzB90EkhZ59nhlTHptFIs0O/1ODL4/lzfC?=
 =?us-ascii?Q?yA/7vLmEPZ4qJ9DX/ItZX7P/9RtcmZi/Vpiusywzs6nSW2tcnXsRSElZdOS6?=
 =?us-ascii?Q?Vd/sEpYqe6YFzBVDtQKTGZrAwVXGg6y+C54nD8hrmFBXlAdXhtcp/94U2nbH?=
 =?us-ascii?Q?ZsAEfvxsJj5du/hSRiLDhV5wulIdBTuYgMgj/dFp7/SRs0x4sfnSh2wHoeFm?=
 =?us-ascii?Q?xfJwBircnYDGQNjx/3oDwNToGlGOZbG/t4cI1rE5GwNknapqMuL3q7a9Fir7?=
 =?us-ascii?Q?dUDBTHC7SEmdJ/NfwPrCrdAf9erLW5brTcgW/jMpoklLXUzz3UE7dct0Fc/q?=
 =?us-ascii?Q?ulRU1X77R6sHcYXUWYPUZT5aPBI6NgVcrQYO76j94vPVIWSmpgGTt77mMwxI?=
 =?us-ascii?Q?xf1X5N4veE2t7l9f+0eRbtGZnqTGikhf7AXzLCpCFMOKwOiWd1ZyZu6yaPdW?=
 =?us-ascii?Q?Z31Tpug0D09unxnSfcsjDCUZ8XKIxjjOgy2D2Pd2sROjDj1cov+ljgtmHvVb?=
 =?us-ascii?Q?6e4TR+gx3ZYkzBVzgCVfkQ5Oa4kp2RE2PR7Ph3shZhDIXBxDDPzkrwZIaJoG?=
 =?us-ascii?Q?/m9JH3mzikDzmSEvj99aNF0XENvbeN8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2431ce36-4d19-44a3-ed32-08de63329951
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8439.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:43:30.9011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vsp8HKoYPGhlaDfC5bucoURpn46q/hRqb8xs5F+ugppeX37V5JTPydDUQqSHy+liHkcK0JM85NUyO8ZqDIWUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7267
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

From: Niko Mauno <niko.mauno@vaisala.com>

When storing the single word bootcount value, add applying of the
bootcount count mask which seemed to be missing.

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 drivers/bootcount/bootcount.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bootcount/bootcount.c b/drivers/bootcount/bootcount.c
index 454e50591df..2c0114d9705 100644
--- a/drivers/bootcount/bootcount.c
+++ b/drivers/bootcount/bootcount.c
@@ -19,7 +19,8 @@ __weak void bootcount_store(ulong a)
 	uintptr_t flush_end;
 
 #if defined(CONFIG_SYS_BOOTCOUNT_SINGLEWORD)
-	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK) | a);
+	raw_bootcount_store(reg, (CONFIG_SYS_BOOTCOUNT_MAGIC & BOOTCOUNT_MAGIC_MASK)
+		| (a & BOOTCOUNT_COUNT_MASK));
 
 	flush_end = roundup(CONFIG_SYS_BOOTCOUNT_ADDR + 4,
 			    CONFIG_SYS_CACHELINE_SIZE);
@@ -98,7 +99,8 @@ static int bootcount_mem_set(struct udevice *dev, const u32 a)
 	uintptr_t flush_end;
 
 	if (priv->singleword) {
-		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK) | a);
+		raw_bootcount_store(reg, (magic & BOOTCOUNT_MAGIC_MASK)
+			| (a & BOOTCOUNT_COUNT_MASK));
 		flush_end = roundup(priv->base + 4,
 				    CONFIG_SYS_CACHELINE_SIZE);
 	} else {
-- 
2.47.3

