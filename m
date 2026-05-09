Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6A3CD343F
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 11:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07EC884D3F;
	Sat,  9 May 2026 13:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2n/noX9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA23784D3A; Sat,  9 May 2026 13:12:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013E684D2F
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 13:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zskesrw84W9g+cszTwAH6Vp7KG3nPvhbNlN4PamqzyDGFbw13pj6RWO7QH+99rmkMTrkxVOoTC/qh2JjzjJJn52oguRL3xSvvDf4dZr6zZvC48BrX7WN+oeX1JL/J6144vMJeY7prYBgfJJMUnw6W6otDn5IapnLJyrqLjBQK6KvFFhfyQxQJCyxKxvbMgR6MCWBWIRNPs427S89YGLCr4TyltX+z/z7t5laYypmWX7xkgqVJTgDkhFm3+O+kWnfzcNjizKR3NqXHB0SXOKP2P5JTvEuNXE1s1ctHmx90aq6T5cqNeR1DYHjcSDFgR3ea3VpYDfCUFlOgPFevEqXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=JcJIljPC55qiW31BV72/qiywndRR5UyNqEmNvnMJTKkaAaPxhs1MA7lBD0Fwcu1zbRgLx3SlxH0k7T3D6/aV/iOsBuCb32sxHMAut/wYwOcJ98R483q9wRaEbt7w+fGQv+5KjndhiVn7HYFcAuAx2pL2Hk+L1UfWFzvoKh/PPf/WMgqjNnaQ2Zwiw+Fcxo58zDVfurUv7asMSAm3C+2gsvZbfChxQ2I5QSWiHuhRjhIvLCejKgk/f+/xOezGEItO315d//eZgP0EYs7WCtPPWS84N0G8Kz4pwR+s3PuyTlSzFsNGqupTdOflT4/3kGAcRXIl3x3+s2Z8lPNtLMUuKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=2n/noX9R/b59jFt7r/764FTcXcVNilFUS4pdf3bhoUp9nCGqakakCltuWoJP9SnMYS2C/fO2OijZxva74FGEPZNuFpLF9S9iERXAX6NQKuQQWqDORQ5I1WU4XP6TxiBUWwvCa7SVNpx1737pAI80uunscz5vtrQJd2qnxca1jAek5PwRcDStuwOj8q6YxDKLNrE6GO1q+RPK4MO2Uo+KLhtjZUrW3U+HdG98ULya1oqP6fVRErGxlLJ4JgRpShiSdC1TZaguI3kV7dwLryv9WExO/PsbfxtfQre9mUmUXt8NiPLuNPaGWOe6LVTwClPsnI46njSF1YkyzpqS40Wx6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8617.eurprd08.prod.outlook.com (2603:10a6:150:81::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 11:12:30 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 11:12:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 09/11] configs: airoha: an7581: enable pinctrl/gpio support
Date: Sat,  9 May 2026 14:11:55 +0300
Message-ID: <20260509111157.4039434-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::9) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: ff576c9f-4d8b-46d8-81ec-08deadbbdca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: no8KTLzDC5kS9NJhLsqZiImaoa+qjS/NNasy03JRlEnzpX2SZ8GZHjfjesbxJasQOXQ8bybouJgkW/UIquUcVffOGz+tK1r5NQQfjJJyVboSObmOg8rNhRolkFH0x2zEwunFXtReTAoJY29IZqukqQAj+B4aMUdioygbACbFlRkaVKhqoLP+QSXgbXmVN0BhgaEdAIKV25GZVjFBDFMHhge/rt7lBFJIBa5NFGqrEqC1J9nR1zM61Me3uuxb7NBLXRXfc+i4bnGpkgcYnoWnK3k6vODhLtLy4AaMahHdJPeKalLnfXsqoSnLiGTpPxQ3qRLi0uKwCvmuh6+NnIG1GDLTCZI9G2fCt7644gX9e1jdHs64paOzEXtEQPmNxwGDOdYMmZS3epzu8c6q7FVT2fq+VZ65Q69ftrgCYTbpxzLYptIEkoM/m6c/1IPZuyGfRT3f4EnrdOJhjdeZc4caZtnJegUM4wj3tzbhY16CJHbNlWNhR2lELpEU0Tre3RDkLdXjD7s2BMDHni2Sa6I61RKyaqY6m2DMDFqXHqlGb7YUCcry7/BKy1gb79xIpZOsi7/JaZIy2kKH/oHcz7O5gVXVPSRKIYYai7u2g2hMl1jzX3h+HZlq5ze18fSaq1ORuUHr+rdTvHqOD50KdjDS52yt9eVt0FfnlR1C36QwzvrPDCn1fNhwNTPKGeRY4p7OEoHiUT/hwz55AFIomfFA7xbCLp4I/L1M0UJz7jnzoDyLYVzm7wjua/x05/OUVWBW2CC76YC8zJmssIIEYdc6Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g6I+p93sIcUEOXKe5AYs08/eZT9EObUSSNsRHVAShtav1GPzK3DNI60HvGzt?=
 =?us-ascii?Q?pgQ9lZXu7fbIcbaaDB0i8JJ9SHjBVb2Hw2UcQvx/vzKt3AFz4+PThzewnTV4?=
 =?us-ascii?Q?QxvlaMR7EsnUkfAWweAd2SP8UDULXwJZ/CBHgdLew8c7mFt1cB3Ye+z/rSsS?=
 =?us-ascii?Q?ncK47PIsQI/vvuk5fAFPoPc3mHx3mc70+3JiApl2rDs9IDPWT++P8EqFxtcO?=
 =?us-ascii?Q?6o10NqUF+KodYDErbzjFvb08RsOB0bDknMO9j1sDGtolv3ewAOgE4pFEvU4X?=
 =?us-ascii?Q?VFTGC26Lc0el5R0DtxMMZVfN620wrmMI3tD2mGUrtMORhZwxZBl5aq0Oc5wT?=
 =?us-ascii?Q?MznFlypJApm2CAaKd/Al7urEk1oHp+jHW+ZXW87OeNUqZljWo0wSJH8DqawG?=
 =?us-ascii?Q?hiJTDi+X+1P2zXRYDgQt6BxKUOj/UQUqLq05LQ0OKn4gfA5GB+CwyXtzWvtd?=
 =?us-ascii?Q?4cDhFgx6DZazEmjBJ8xudvSAde3zk0nijlfzyWGyGi59l86fD4hxFqf2ln9R?=
 =?us-ascii?Q?UfwhKeSM86RZz+E4sCS4ka124mdISQuvBvVvCtBSTb8jYxiWILGwt+ZnQ2lO?=
 =?us-ascii?Q?x+v5ev8PBGWES7uWFoQK7vrbAnhStB1p79jwQ6d2NZnOkTVYRKUUmU2Fynub?=
 =?us-ascii?Q?pQjctU6f61NI9NIU6i77xT9VopfdOf4qOfUdCRocsWY4vpkC9Ph7ewW6INE1?=
 =?us-ascii?Q?pzgS0C8siJ4Nb21BNwHcDxuGZy/0571clRPkzQRNo6eJDvhP+Y55WYBxuTDD?=
 =?us-ascii?Q?9YdYqWwgfYokjnieZLBWvX4bJl11Ua8S1DpigWY3fA4fihReMlJoWCCml68t?=
 =?us-ascii?Q?osV5p7N7ex09WzMeBZT/gRCOziIJwZ1Q4DWu161VA7riYkJeX699qg4XOiPs?=
 =?us-ascii?Q?nCYkvhMq5dkKkK1+iQXyyUYlTT+JF7wU2/CW45QbZqkYQ4lG31cIMzSb6vlw?=
 =?us-ascii?Q?KtUQYM/NlfOhxVizISrtSFbzypHwIcVZdjYyciG4DmIMwHQyXZQ3t6m5OD1I?=
 =?us-ascii?Q?pLqJtBjnOOHFQBPGdsAupND8mznarbHhcBUGOXvcqwcG7DAiUleo9zZcEn5L?=
 =?us-ascii?Q?HX3d0pnX/ZVfHWfTAk2KlD406pPcO7Duia5XYaEpPQA2KIPkD2zV8Fw977sj?=
 =?us-ascii?Q?3Fokp+ZCH173qXDx3SWBWbyAeLpRFzdID3TCVW2/7tbHoJQPPj+4lH3NU7VV?=
 =?us-ascii?Q?dIuF4Ec5fh45dVRq+CaSIt/e0rfXBZxERrDOmDqBYsZR5b3tlMC7xcAUHJjE?=
 =?us-ascii?Q?xFjYDDrf9iKPZ22W+efYlSk4R2eVYy6C8kwyTDnzaBo5PboMhBiUJ5f8xpOd?=
 =?us-ascii?Q?MUkh0bXijK8/fANZqp0uJ/vxdOIeXzr1idvRKF0rVIgJcE5FADZGNHAHuY2w?=
 =?us-ascii?Q?zbPMn0TuteEdRmHyHNsbOb/R8t3v+dC67R7SlB4X+2kg959/YRIVk0VQVngg?=
 =?us-ascii?Q?A8ZLfpbRVUbDpan65fx0IY5CH1JeNzwZUBtV1PLNB/CY6f8kN+I5IEDmAlo/?=
 =?us-ascii?Q?V/ffrbZXDc4N1UnOQ8R2TfBGG+KjX/pA0Ce9VslAKKl/MRSqDDKbdlyRRgiO?=
 =?us-ascii?Q?RioAqhlAXNDGDQyGx2TIJ0TeehEg9odos1tihmltBgLIg/QiGlWcea9rIt0f?=
 =?us-ascii?Q?eoEvlkzwKyMpeniI+UFSxwWFg8DRZ8RIOdT69oFZU09cdVnO2saXS4wpF+rB?=
 =?us-ascii?Q?nT3KeTsi9EOXKksuAkV8h6mwjf/DsXqtPJpeWzYenqTVs9Q/hqbvf3C8p2sk?=
 =?us-ascii?Q?0hcTu7bm+MkY52VT9nZ3ulB9rNAcl9A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ff576c9f-4d8b-46d8-81ec-08deadbbdca0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 11:12:30.6822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcL52hRcOSbSU/7Uf/C2ljyHdP8MZUd9PybMrJWY6e+0TgOhOrtszJs+n7pAQLfX6eW9qC81gJKx146I5tPzVoivusjt8HJSdAxTBUDxHS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8617
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a94730cf564..eb9623d6b47 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -46,8 +46,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -67,12 +65,11 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
-CONFIG_AIROHA_ETH=y
 CONFIG_PCS_AIROHA_AN7581=y
-CONFIG_PHYLIB=y
+CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

