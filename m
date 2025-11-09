Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9848CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5336883F26;
	Sun,  9 Nov 2025 08:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xEgw0vfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C99483EDC; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A0A83E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/CNY6tl8otEdpLVUEe7r8DDMCx1oeI4Oy49lwt99MNHdWhES+typJvSYkQxrnvN71toeb0/YM2c3/A1o/Eva53ZPAQogfezqFAGVyjYqpHyHQjsiz1fFdGIMRAWY73yzTXx8j1sAkyKhpfwV2CgyUNmUmTMa2x5grHjkWsLAa9Ln4/6ZkatD6VaS0icUbtGPRoDkZJrxzmthmrqStGsDG8XH5oMYJ9sJ1AX5iiBES8HhVY5lULce0U/Qg5WSnpKh30V3OwDnJ1dOMEW2KV0AcEZict1huetQSqKpwtcxz1ar4oncjCIpy0G6tKVsD9Hn9//ZpnrvTPPH48kHbdimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM6eKn6PCsOJaRmc5ssaJsKnvVhzvnCLZZisdWa8X90=;
 b=kAH0NjJxwAxpEE9vFKgqXEXZIPSmpa+wI9y9mzsvLPNNmj80+pu9wkin2c82VgdN6sp+U1M/E2n/tpLhT670+S5qaJo9gnv6Pnr+mqPsmCPq237f0d3sFW0JkOU0NKUc0KGv/KuMOhz5Sywn2dn1m2f6wAHkJIGzXbcUFNJMJf7xK4GPdVXnZ+zWes5J0/vhVti0eCXoxTtQIQV5z79oWaomNpcg6XAWcP5HuJMBKyvgbEuKsX6dmKg0WUriu00MZe2ce59jIHgVkri3srGkyuYMCGAFwEY0+LcqA+nyPswkUPiLF0o2s8CzAEIhdebC9IzqLGyCIZ1KNqD0rGxqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM6eKn6PCsOJaRmc5ssaJsKnvVhzvnCLZZisdWa8X90=;
 b=xEgw0vfDJl9fi7+gwfARq2rrrega375VkAjyG3aCR+BXTuq5oVpwh4k07iwamvnvxAjd08iYPn+vWnL9i3e09ggbGp0jMlC3imdBjtuRp54H3vLBiEwwoO/ORkEkRPTgOyf5+rCqwxGamNCDDrDvsSYQ5e9ihgvXminadjdP/9Yk+9ewjASLxJo6FXnqW5wKLfGiXw5g+UUSl9SkEW5yrk2RtI7l8dYFpq/EzKZk/6rPNJ+53QFBvuO/wS06QWnU+N5K6ewcwSm+HWPSppwvByiQUIg5qcww48lgx3Q8rNJSZDo2ydBHQq6c4T1TEZUio76pFXFFiOP/ceBiHCUjbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:15 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 06/12] spi: airoha: buffer must be 0xff-ed before writing
Date: Sun,  9 Nov 2025 10:06:52 +0300
Message-ID: <20251109070659.801344-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af7557c-c15b-4299-1a6c-08de1f5e9cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O67RQYpZkE1adSFXeTTyNiceE+iU5ZA4ihOpfIekmh8XUETIQNVaJXDczaO9?=
 =?us-ascii?Q?MXoK+kUUVdd/Uj6LFWlYZ5wWYaS/YZzutHnP6PD4YqiGyT1g0/No48834o7T?=
 =?us-ascii?Q?S/R//5szhsR9ywUN1gv8CWXU7ZLA+Dxgud2Xs68FSzO75lQ/lAlcbnQ/GPEM?=
 =?us-ascii?Q?5MbGThpCR/nnJI3WYXNu/DJXwpZCf7xhUtUm9YQLzMbPFgB+vrsDlWD8DVN5?=
 =?us-ascii?Q?OUhUeWFg63WsEm5mpbbsnugCEzEujwnHvhQBk6mGUARS2JgXAf5cxbtJ7hcv?=
 =?us-ascii?Q?gaFrbBz49b/krou6ZMbaUc8EWFElnw5+23raemeQ+1mbCJsnRJ9BwPCnRwrM?=
 =?us-ascii?Q?qUsf+RmcGhgkpbiPAt5gYdkim3oZ0YqTWfsOPxQ3HXLCBCoT7rMt2AoHuuKy?=
 =?us-ascii?Q?MF4T41rqv6CzxLdbKvH8GhqBjqOOfN9la3EI6k2WzjvOL8jXjH875pH+gv0h?=
 =?us-ascii?Q?67NQcmoCgk4ZbKmyxceFHPh9xiYXUU/jzu9S7Gaosmy6aYfHAq2KITkwW3RJ?=
 =?us-ascii?Q?POIKXJduLHVwh7LV4bV5QnoRFzjuuq+C5zpxRrzI6fT86cddWbmZU6trz6wR?=
 =?us-ascii?Q?bg2y7q7KBj0zBOkkg7bqI6DVzIONz/rvVwp5qKPVX7LjmI0vfHa6dR+SCETu?=
 =?us-ascii?Q?E9MlUoLNz85uo/BW+0l6arrI1tpt9oJDBVGBCvuZUIj/82YJZsGf+KhxURjh?=
 =?us-ascii?Q?HeGQvXbhzscnzYXuf9YOH0l28eKaqDu8d7YGr2YnnfGhRdMYkdwO+JlZlf5v?=
 =?us-ascii?Q?9/IP6i/nZp8L068pLZLxP+YQu+3H8MvNz8Xdy3Q6j7SFihj/wdm0T4gfOYye?=
 =?us-ascii?Q?Vv/lzIOs1Sg3ZzKjMGIKP3FcH7IoSMb8H2ivd7koFOv1gXMc4Zhe6Excn6IX?=
 =?us-ascii?Q?ciBzAOc712Rbdvyns4GDZ8+M1YxweqO+HBD5kekf835O7t3CdGElnfhuAZ1X?=
 =?us-ascii?Q?qS/NLBOjblmZwFECMfLnrfzfpMq9EPwCLm0LO+UH6TjW886TVmFTQ4kwK2CR?=
 =?us-ascii?Q?LOyZiVkxUnjq8ol8kJgw45HDABD/eo8EDxNcD/L0dFOGmjIad5CqIyRAJ11K?=
 =?us-ascii?Q?EJPOWNaK8HZR/V1jEcL1M3c4oBXuoWfIemkBzwplsUuEpP0GFJwi7nvDXfwW?=
 =?us-ascii?Q?A0ZiRC4ZPRvMbwlOSV0IN4j5Cj84qvY2hOZjEI4r1eE+kN1miI5MY3Cn8Gtj?=
 =?us-ascii?Q?aBfkDJy2OM+onmpMs7lb+X7+BTRgCt01y7HE+/WCw324GFfo+0Kw8bffLWT7?=
 =?us-ascii?Q?WDgBAa5qAd6PrqHx0EtetQcOF5kGGJl9LVr9dLGXEO6NUvMLycDKNKBlrRW+?=
 =?us-ascii?Q?jh/GgqmmeygpNXf8+3T7MuYexYoCcj8+QGGLp/1YH/n81m5x4Nkxik5/w1Tg?=
 =?us-ascii?Q?Ba2rxi1Isece4wiTX27xFa9vsbovyoC9wEu/ExUgQSMGZuReot4CPWCCgwP1?=
 =?us-ascii?Q?lncGtFxX/898YM2UFGII9DdmZB+JZzcCZWzkxq4pc7TJdiCZKjGnv0NTmEb1?=
 =?us-ascii?Q?ukaDQ4WU7SQ299T1bBtUJwk9brIzyt9+jjTn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4zZTxKdllC9Gidd8+uGjwakIxXA2RM7KE3IxwCD39YRaYQeL3M02+KQbmcS?=
 =?us-ascii?Q?DkVFYJ5BSoEstmIx8VaUVUXPfwS1LisS0hHL5CrLBumYUHkqt+B79s6aGuw/?=
 =?us-ascii?Q?dHU990FPLIJ0MEo33W3IPV2m+LbTUn2CIb5hPG7Lpo3PbGfNF607g1kqVQQT?=
 =?us-ascii?Q?AJzcggwZNDJdrR2uF/JEh9+/jx0I40FPoxww2cH8y/WkJ1CI14W2uosoWNV8?=
 =?us-ascii?Q?NXQpQFHi0ubRLLtGEF87bZJAsBRKC1taRW1TYIrkcz8x7TGeV0LsgIanZtCY?=
 =?us-ascii?Q?es7wVeZ1NVy0vdGQfIHXOBFBp1A3YmimHdfbVfTF8/tJDwcWXRJeKztemc1M?=
 =?us-ascii?Q?oeLFEa2OR0+KZbiDRj2rSDCCufp9mrEAHkYhVo39niYrQVbZmNkKTmIVCOSe?=
 =?us-ascii?Q?ujnWPb+AILEcQu4QdVKLyguZuNN12jmhn+YPkAMb3BkCjG2R8IcMX+mEnR7R?=
 =?us-ascii?Q?s6owPGv3tgMvLLtqIYICZzaSmynuKoNl+zdBcXOGBfMKs/6O/4+vgF/dpqbq?=
 =?us-ascii?Q?Ec5zQA5lys2NzI9MdaQR343o/X1oPdsrb6uiHN8XlqlVra3bcWVxLlWpN63r?=
 =?us-ascii?Q?al2KGLAzRdtsegW4m64OJMuoJVcH1Q6J9W7ccg75HPa+DchJOKavqLWj2UkI?=
 =?us-ascii?Q?8GB2XG/UmxKNvq2VKZqzN8yVGevwAr7pu8xsElChPTI3CCLiDYptmmz1Zw8e?=
 =?us-ascii?Q?wJhJQi/wGWqfJNMYgrPNRaAm+DgHvDm8p8zl7RAUpKoeUAjYQt5vlPxAmIlA?=
 =?us-ascii?Q?omzzho+cm9Xj339pVwOOE7znKS5lwSSIQFdz1DSQfkqrCp+7u7g9dgyHQPeA?=
 =?us-ascii?Q?PiywTDDs5RcxQmo9WNMlO0pB9F4Rp+bI+XE9ZVUoKrvObu0bu9/kG2nsJ7a/?=
 =?us-ascii?Q?+cDyqE5FuXpTa2V1DiNZZ6ZhV/GndYoofO+gDBblRoqrvY+Qk6z/l9Rqex9b?=
 =?us-ascii?Q?Wn8cvB/pKcikEB17h91Nscn9mY7ETmZ+/D9sQEtOeMfUgTrY/rAJSWG8jAzf?=
 =?us-ascii?Q?BrdLfOGsBAZ/jsu+JjNvu0RcEdVG3EJ0VvWEOUM+Yd06rl0dRIGCJf42mFqp?=
 =?us-ascii?Q?8Caxp8Hc/eOXzfF7M0kBoQ7iY+n5udTgoIQutEMbz5ODmOoukTEWVDqUVO9o?=
 =?us-ascii?Q?ncaaXw5gLtlw1C1PQZTd5ij2DgWuB1kK5roXq6+yaYk1Dz13ELWh4Oq3kD5r?=
 =?us-ascii?Q?iDrpUv4IIRvjAGQJs4hQF0V3dXGdmF6mfsEo8NQejRdkEB1q1sFD4XlVgad2?=
 =?us-ascii?Q?dxkJFx5PaolPnR74o0okISnOHMCpC1r1VMG8pCpT9qcf+bb24CzVLu1EG760?=
 =?us-ascii?Q?hWEvorYhexWbe9RwIdHaHQ8d+G0xf7KukdfaMJ4U7qYGWwaQSzkhBk/hWWPm?=
 =?us-ascii?Q?75lnPODcoFS294EHQ21rsDfEZzxdDLiTM8JtdKaIazam6yvVuJapIDdqygbF?=
 =?us-ascii?Q?7ZozGnEYZqyGdzf0088FoRKKMlT8mijXyoRUjffpDCP/7NUY8hJEVUDYAkjh?=
 =?us-ascii?Q?6vlbMREvXQMnw1UtFvfLPdQrhz9lFX1hkgt8cablBUBKuTiqjUbT7wESjMnW?=
 =?us-ascii?Q?Ljwt3Ap3+CC83aWDnV+2f2e/Woc6HeLxvIjzZb0bf0g/8ASw61JRUur39KJY?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af7557c-c15b-4299-1a6c-08de1f5e9cda
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:15.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NU1oY4BuWy5cNTLw8hDE7K8ZOJZhAmDuZPjadNCuFUYszwaCG/sRqfgpryciNN/2uka3ZypOFf4hZMGIui4uULBkS02hDntZP4VxJA7zdIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 65381060407..23c4507b10d 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -819,7 +819,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0

