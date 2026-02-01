Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5BE65294
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 15:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F4483C72;
	Sun,  1 Feb 2026 16:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DNk82UTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF4983B5E; Sun,  1 Feb 2026 16:14:09 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE93F83C51
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 16:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL/m3uBc7BndXS3B732lIvOYBYjXl8uDTIbMe2AoONMsUjfa5Ynxih7f3ZIm12Yd9LAUFnQ6SQMamw2yuw3x8WXpBf20i9WshuzkhM4stxS1ermn+hxPzMlZM8IQhKp4c/BXPpAJvcBMA2GcTHARccAp1VULCT7mi0A/mqNZFAQNxHrbdw/p2fajXm1g2/t6737+RR1s4oNSMWMQ5hq313XO4LQS4KHcrRBDX/VLrTC7WCrwUS/Rlz8O/Z7+QSsF8ZHdcqzqE0mgyPAWCCl3D9LtQXb9zFp92g10WfrtCHpF8IqL/XsUFS9AUIka2l1vZqVHNchDbnW5Hy8V6OHJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8D25RgB8YB2/Wae4sFXQu6Q8Xtz+p+nJTzOR1+SCJ9s=;
 b=urc8P2KelerXM0h8n/0yeicRoX9APyD+rFH9y3k8LNkhXXJrB0eyiktbSE5h6IhI3VHp1UGqq0a/vG+bk2UUZ30Lqxr3rw1PMKk9B+T88+xjMzTuy9uCblR4bH3MYBNk88jaN3yzyvXHQn4Edf/tjZzT21Y3/POFa30IZVKAPJg8rGsz6VmbZ3wL963X4RGDYUCmkbbeEpp9Tsx4yk1r9rF48Qxbyvb9YnhZaYle9/BQPvYbSg5WLaqDJeei+Bh+onsPzmgRQtxUhO/O5ZNRfBmZV0AiJDdKgyhd3HccOCUDniWBcDCBR1/gja3BH9zIvz9qzEFr6yyMEWe3J349aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8D25RgB8YB2/Wae4sFXQu6Q8Xtz+p+nJTzOR1+SCJ9s=;
 b=DNk82UTMUryrt679ppG456rsTzJNMy/9eys9nT5ou00N2QLjuwumOIT0YvaL6hkjpolfUMk4Tq8QqqNun2XH2iwJlQ6q8RWsKAVGBZ9bPaJECHJdl5/Oku9dEI0yqb4AZ4wLxmhQoIhu2+XadCwY+6AESkhpuKug+0+CjDoGR4Wq3o8CQqVc/8QgyMdEiQ6TvLiZ7Zh04e77mmrFpZQx2rmETM0KhErPQLZgSUV+XSHdFXql6XEGtkyxdrXHrLAl/Vvj52RUR57wViMjRQSZrebeu/6tKPKSm+n1GQkJnE2EZUQ9MXO3rkUN33o8TEDO6O2ukD+xOrn1Dr0KXKGGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7901.namprd03.prod.outlook.com (2603:10b6:806:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:14:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 15:14:04 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v2 3/3] arm: agilex5: Enable eMMC HS200 and HS400 mode support
Date: Sun,  1 Feb 2026 07:13:43 -0800
Message-Id: <20260201151343.27560-4-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
References: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: b785f5c0-66a2-425e-1f92-08de61a48925
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X3p+oRBPL4LqyU3WV5lDNQUdNfWeLhfv0QR/qCFJt+Y6s1I1Mk5aHp4yK6zQ?=
 =?us-ascii?Q?F9aX49yPJd5eg861iRPL7INHfoNI9RKffmFqQeHx/MQW+havZG8H076PV67e?=
 =?us-ascii?Q?LN06nsvmiLoFi5eR4jJ4jGTUhm0jwC2RQr1pRDIijLT4aGUxoAtxRQY0pnsI?=
 =?us-ascii?Q?I8FJqEnZjv3hUXWwSvkPNMndEPwRdRenV/DtHUQJzD5qUJjNWzlhmUGm6VQN?=
 =?us-ascii?Q?QXzg4pt3f496yukyfleWbH5Ah0/l2yr+t/OiQV/JJ9es8CMGcSHkdj1eVEvH?=
 =?us-ascii?Q?z3xE7CGouqjowHpUj9rHSjbTjMJYLC/sfbYyV1zMoOROnlJkqPNTCs79vuwC?=
 =?us-ascii?Q?IELzJFZRCvfcsmaqwpVMdjU0jkunYgvMsrvIMExdAI7FeIYOwsfU+q5w5Rku?=
 =?us-ascii?Q?oTPm1mkBwJsl8UcVZBWFwr2f/rTUD8799EdGDRWJzyw97lJEi4b9NKmrZzrd?=
 =?us-ascii?Q?DpbCzOdVtsgNU7Y9i3hVe+fzKK1BBb/IM8Wm48Pt4vuTJWIOVmgkEK8bxw2y?=
 =?us-ascii?Q?ovSFMLT+5RbRX70HO8D7cUdEd8EsyGQMa39Le1FQP84p8sBGYyQsqkKQexOj?=
 =?us-ascii?Q?phtiAzvBLYh+a0LkSJmYLa1fYOc9320RJ3qVJBJGUlDmVLa8hLKcUP5hs6XB?=
 =?us-ascii?Q?9ZCM8JmIp6B3n/a8D6TRLN9k1oVwOLTodxMJ9jlTAJxGaLKZbTB/F38XUzVJ?=
 =?us-ascii?Q?qhWWjjG63F1Wazv8T0zmF/TgYTTD9Jw3/tmyQ07+xRdISu65tpsF50IyqxUT?=
 =?us-ascii?Q?kBDQ+6B/aT7sRQ5LF4F9fA1N5pf0Ft6oQKrhUL59FwvVod04qC9fGK9PdFoe?=
 =?us-ascii?Q?xeNjvKjHsJe4Af2egUqpgU1YYB3nTtmfC/YhhhFCRp55g8MsA+I7U2zAgCqe?=
 =?us-ascii?Q?gnAJT2IYQHzA5d0K41sKOaAAKHT9CrHQDWk64jn8XMdzogyko3Zpx6Pb6yD2?=
 =?us-ascii?Q?/eqaIc0HTMPxWMM916EkIBu6R/oLyFG6XuZCSDTzMD9D+GJlGEM19kF/J7d6?=
 =?us-ascii?Q?CwDw6NfZ+pW+6H+6fWk5YK1J1vBaxC/hVLfuC0n7YNFQ8Fb6etUb8wSA/eQx?=
 =?us-ascii?Q?SMX228kM7nVUmVq+uK8GCJLQB1YZnF+v+breMCv7d/zcfHRfkX/K1fBMrmd6?=
 =?us-ascii?Q?4XE/yP0zHtAsFAga25X/YB6gyGBFULpJEF3UxSnSUFt8oRnYpF1WOB1Nzcfv?=
 =?us-ascii?Q?GdAVwIlUS8hhcFuCzqonObUx0RCsKhojfcNGm57KJ4PLJ+BbINCeKYfEAnlP?=
 =?us-ascii?Q?wXZajwKWDPiViWPd7NPhXd2+SorKjPA/3yoUi5fb4H2EPaWMBtQd8u19nz3Q?=
 =?us-ascii?Q?AY7zIc791oK7CKXPGPFtZQMEKBqGNHau7f6r6Yqv6Hn2LTIGVnvkGpNayaJb?=
 =?us-ascii?Q?9WKApBimO3P348E8bn4Fm1Wc4SFnkaOsExRx20ZbiMinioeVC8zlYX3KpS1V?=
 =?us-ascii?Q?lhoYO5pGxBRXODK7TFxoomCy3/YfRKG2tfp6RL1PiAh+1KAzFACFy8B+bHc9?=
 =?us-ascii?Q?+AuNE4Mx9+J2kFknLVmaXalEli6GmmTS+udG2ysuPHoqEwvp0gL4HMP4mLS0?=
 =?us-ascii?Q?uR7K1CUErWtBLweQNPk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dUNpSTHANsjHFhzQYm8Fwbd34ucceVwblOpRoLQDOGepFwXharrK6qmem1NY?=
 =?us-ascii?Q?DXy++TC0/AYfmKl/GtMIIBpIDMTNlK51bNsb+4Z3FfAmsdpBuW6W5N3MqI0N?=
 =?us-ascii?Q?k8IDesesoNkGyR0uU+Pm5AchBS8Pk+AM7JojKth2CKHPZNiaM/C1BUmebVmK?=
 =?us-ascii?Q?eQra4fvECqdlpxPd5c03prC28m9f6F7BcgRbv0mscs1ktZaXeQ1Hh14RvMRs?=
 =?us-ascii?Q?vh1P1SW19nMwPMoogsKipDvuQld1GYlvcbGSVOCMQ+Z53nAVXw+cALPzC6I7?=
 =?us-ascii?Q?bo9RLoQf2bwy/33760Q5j7K29QXIzvCnoYBiBztUelpgV+XeZ8lVzOzQy2Qb?=
 =?us-ascii?Q?bLDOfHJNzj+F2DNEYT8fFFL+7j91bkpXQk1Z2qTr9chUgMB8PxNJ/VLz0JST?=
 =?us-ascii?Q?w0lhZUfzaPFDMjEkF+a7kSwaMMjX9gIg1ThFjyBDMBj8+kw4AdMQkAkc6LXj?=
 =?us-ascii?Q?T+1moCy4G4ZYP79c/Uhqixy7K6cZ+XMkjfS+BUW7PhWea8OfbA8rELhPFPSj?=
 =?us-ascii?Q?8Y+1Ks0FJduf+9zyKR+i1xNSz1MsObMNezG4MKIWB7j6llkh4EE6lrjrfhY9?=
 =?us-ascii?Q?qCSeh6jvqlqkzhwKlRkg0y/OfOMbG2WT8vXx4twafcZhYRix2LR3Fc2Ogc8b?=
 =?us-ascii?Q?TPoICwTQMavAn890NYCcFPmudKvQ3bvui4zp3Sr7BtjEg3jqfIqFtElJB3yC?=
 =?us-ascii?Q?yFa4rfn27oTCXb/lIukP6h7zwpzHmTGW7bGmEaSBVEZrbBt5M56zGB75Zgt6?=
 =?us-ascii?Q?zXYIhtsdFrXoxoxRYU8rbEut+BsRHT0T3lfOKDw/ckpQ909KlG7Z0g1tCun2?=
 =?us-ascii?Q?jtCW+cFqRtidhjaFId4m5lY1Kvuahgf0ha4K2ulo1Hr3PdV7UYR8PncPrgRf?=
 =?us-ascii?Q?b+e4BH7Z2K4VFdBVNdu21kEdyIZ58iuIvpFbzRaEnJTY0DUKJ2rAFMaY3/av?=
 =?us-ascii?Q?a4gqdZcZYoSH8PdTQzjxBi+jpsay2FA5JyRgfCElu6SezUK3JQZNRS+DNIns?=
 =?us-ascii?Q?cvW/1OaOUXG4YIBJOi/bfoE06eh19lV+1QU0dd0lpJWQ4YXWZYogzICmlbnv?=
 =?us-ascii?Q?yXUno0O3U0eB4U2fLRc0/ok6Gp8eauN+tdwB3hso99U1hzdp6QlLknzfD6pO?=
 =?us-ascii?Q?meNx0BjMKTcodh+6FBj9aCCZsUO8SLu2su3cuKKPoy2w/0chjMOPj3QeCY/m?=
 =?us-ascii?Q?DJOuji+I2tbldmgKbz75Pn5n3LuSrXwVwvJDgldsisjX1gA9x4c9buZ9QhTZ?=
 =?us-ascii?Q?2swVKrMxNUnrvRU9AAH6JwgfiZX8kbDu9VfZzLBlqt4ybvUpfwcmhiWMFwJl?=
 =?us-ascii?Q?D8gu/6VAEhZUj0GF1NStMqJqWhRdqHIee4WGFDdB4uhRPSEgfVCbrS83tztm?=
 =?us-ascii?Q?Z6B0svxrGZtCtIdaIvCVbzdTFM9bpp/eV4mPjYwB8rs6hYqLP2tPKjrT+A4Q?=
 =?us-ascii?Q?NdzYHr1aMD1Whg/Igye4m+93QFzy1Y05HBiTx3zIAh2lXVvqJlC8yG7s3NEp?=
 =?us-ascii?Q?EY3O+KumVqlYFc0MNXMzDfa0LaInGfhZf9E1DPYeHehdidc8RiX69herRngv?=
 =?us-ascii?Q?V3O/OM7IrDeuD655tNa14ay0aCCiS2BhOq6AkffhQ0Hi21CwddxFhgrKzjvk?=
 =?us-ascii?Q?mKlcQO0zcMlOxsloWrB8uMMfgpNEars37C+9lLKVaJcYrqcOzQY3g8AF4k8g?=
 =?us-ascii?Q?I74BdKt1yA0PGn+y0zPpa4aDn7zw9BGZ2/b99OM6NHlGwUOFttByOWPxIpPs?=
 =?us-ascii?Q?T0GA+4e5qhLMg/FF9fV8yXbdcJ0iDO8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b785f5c0-66a2-425e-1f92-08de61a48925
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:14:03.9602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH3eE0wghr+x+Rqeox7EDY3CkN9Npb5b+fCCQlGnuAhqGh9SjYuLhWq1EgdICpE18Sgn72VP3kfOZFzWvVpG+5H0rqpQ/FuvEhYiBVcv/PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7901
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

Enable high-speed eMMC modes on Agilex5 SoC development kit for
improved storage performance.

Defconfig changes:
- Enable CONFIG_MMC_HS400_SUPPORT and CONFIG_SPL_MMC_HS400_SUPPORT

Device tree changes:
- Add mmc-hs200-1_8v and mmc-hs400-1_8v capabilities
- Add sdhci-caps-mask to mask SDHCI_CLOCK_V3_BASE_MASK bits
- Add sdhci-caps to set 200MHz base clock and 8-bit bus width
- Add PHY and controller timing configuration for HS200 mode
- Add PHY and controller timing configuration for HS400 mode

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts | 27 ++++++++++++++++++++-
 configs/socfpga_agilex5_emmc_defconfig      |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index f6848c373cd..c06781064ca 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -25,11 +25,14 @@
 	disable-wp;
 	non-removable;
 	cap-mmc-highspeed;
-
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
 	bus-width = <8>;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&emmc_io_1v8_reg>;
 	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0004c800>;	/* SDHCI_CAN_DO_8BIT */
+	sdhci-caps-mask = <0x00000000 0x0000ff00>;
 
 	/* eMMC legacy mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -46,4 +49,26 @@
 	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
 	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
+
+	/* eMMC HS200 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x10000001>;
+	cdns,phy-dll-master-ctrl-emmc-hs200 = <0x4>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	/* eMMC HS400 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-hs400 = <0x680004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400 = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-hs400 = <0x4d4b40>;
+	cdns,phy-dq-timing-delay-emmc-hs400 = <0x10000001>;
+	cdns,phy-dll-master-ctrl-emmc-hs400 = <0x4>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs400 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
 };
diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
index 9254ab92e0c..47d345be97c 100644
--- a/configs/socfpga_agilex5_emmc_defconfig
+++ b/configs/socfpga_agilex5_emmc_defconfig
@@ -4,3 +4,5 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
 # CONFIG_SPL_DM_REGULATOR_GPIO is not set
 # CONFIG_DM_REGULATOR_GPIO is not set
 # CONFIG_SPL_DWAPB_GPIO is not set
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
-- 
2.43.7

