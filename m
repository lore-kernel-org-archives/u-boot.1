Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480EFCAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C506783390;
	Fri, 19 Sep 2025 12:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DTUV4Exe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441DD8331F; Fri, 19 Sep 2025 12:10:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5982E832DA
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3nu/lpvCYV3bbPXhVOPJ3fUAJoJEGlUHJ7lVKKW856mH1sgn/uQmKx3RTgM8NigoTewlgnILUzWWqAo/0aOxIZjgE+bAb/9J8AhGmo/V0/BGllz4zEuKiTP3ALkJjmV6yEmuKkUuzZBwu8vbDTHi/97VA9/h0R+1CsMzZ1rmGihXuwgZECbfmWRXD/1dVICDXLjTqu8xxLTVM2AiwI/3LFHoQ4HhWM2CkaFNrsMKnFekvLvDSUrklUYbQvAJYnbeHPCnY1sOjJm4zV4/vq8TM1v4vRtJQZ0jU6mffhBgZZwRkDTLNFLoTPFJSm8aGDp0pYLTaIqQ8Z8X8cu8JHH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3Sp3fxuxWsVFHpGeIZy8HeqcWHud5yaL9ehfYa3Soc=;
 b=BizUYKHytwycmUOlfYo/j3YQzmuK2sBceecHt7EVZG/KVNZZq7VhKNxFkocep1/mi9bzeEDC9bLlnvSvoQJY5eNAItFMQ2SYkt+IRo97GuMF9RspapkhKLSaqPd+XqUtQSmFgEPfeebb0UwPN21+eff6NUNxAg1ROF1ejwenDN/S2QxOHaQl/2COkM3tVDQUSj+rPd8Lkt95W1lWX/ONlomubSLr7W+gaCUOUFfP8ZYRGLyhaS+H6hVo8AJrBW9anR4aY0HekZ2utp1QXIa+XphuZQ5cdyaWOTXvl4NOb2ZsoUXXVE8NFXamIc++f6KAYsaSTxQ+Lz+FiUUvQaKdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3Sp3fxuxWsVFHpGeIZy8HeqcWHud5yaL9ehfYa3Soc=;
 b=DTUV4ExezyDGDuCWVU7NpBnc/xFC76ou/5fn81DkiCURDLUTUEijR9BBgPhLm8YS6Ut0ow8bd+Z8YnKtNPbYTkslF/3DhRre4KauvFrkv685uosIz3eT2SgRkEOwoUKEZFXG92tFzH4aZHmsRlWB5yUUKYIhk0uZcL9upksk1RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:10 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/9] _exports.h: simplify condition for including spi functions
Date: Fri, 19 Sep 2025 12:09:56 +0200
Message-ID: <20250919101002.568488-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f44730-cb51-4a52-a674-08ddf764b769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FCGid3v6JKwooQN3hn3O7meqyTKtLc3NqSEdMRsVMEjpyh8DDDN/z8Ecywy2?=
 =?us-ascii?Q?dxjaBmSHWc5MK7ZsfdqHomQfuYl9EbOFTxP4XvfoIjx5MRBT76LDM1S5idIH?=
 =?us-ascii?Q?Vjy5WOOwkejtOjB4xSMheDrU9oot6DbHhcSJEp8uCy9naJMkIF4IPfSo68SZ?=
 =?us-ascii?Q?jIb5ydU5dcO1cOyTNtuzfvWUrlJB9MtATt5dSJ7tgVAe+3318/Z99MslRMrB?=
 =?us-ascii?Q?1zuWdgth1PVuWXevK/5UAolsDzuKLfD/p5z0VIqfurn//c4xft68yq5S4DgK?=
 =?us-ascii?Q?TN+zTmU5skmCu2d1MoKDKLaprbeY8ihZJ/WPBd26PXJgZkrR8g8u2dBYVV4i?=
 =?us-ascii?Q?bcYDEZ1EHJHqVExmihFE5V+qHTQxlyc/4aTCdJJOTqBxPT45emAOvz9z/rpP?=
 =?us-ascii?Q?CcbU84TxsieP/dkqj9Na+Tk04vA8rQO33M+JHqT9B38UhoRQqBzz33Ug9YKI?=
 =?us-ascii?Q?Q40IaqIy9eyTS3xksyDFny5wFaQnj8dHiO6D+UspDxpAmzt9emo2lFKYit1H?=
 =?us-ascii?Q?ScbnX2JvtA2xOGJxkyoaKJJf7iFqPHASjtDsSCXbTOUnAH2ZW7XznxhyR1I9?=
 =?us-ascii?Q?iseKwqP1mwH6Wd7Upnf3UNVF8SVo/uAVDbOSudlWZzfEob2t4mspooA5OBTA?=
 =?us-ascii?Q?n7yyQQVsFp297h2lAoihi2kpVjLpFEUX2IuyvmSRzr/awg+TURLbKC+E6BN6?=
 =?us-ascii?Q?a7t5wG2iHQMMqJN1y79BEf8SLy/MK85N8xERdbs8Ndh7loz4L0IcoKWJxL6E?=
 =?us-ascii?Q?ghA5jLWfFApOB3qfdmUNhnixMYBCbZ3o9eWLmVmoZ8BVTgOeX/v9+Irje/JA?=
 =?us-ascii?Q?zrwA02jmjcDk0daaollWveGsNWkrBjAiH5ha6Ah2PO+XeJPLvyhMrL01NY/y?=
 =?us-ascii?Q?ajQ5nHGnLV5tEExbUk8SFEiwYkwYEkbhgwcT2fUmzkzR7KezMHRg50Rt798o?=
 =?us-ascii?Q?ttYiJFKvlwkw6dENd6mL93RFHs7/ebWlaiqQGJ1PhNsWdX04PnpkOSQ/v1LU?=
 =?us-ascii?Q?LIjqOCPM1w4mRc4w0B/bZQlb3O5GVkcRj+4cImTM4hQLBIq2C/CnZvJAWBch?=
 =?us-ascii?Q?ZHQ57sQrD8ZvEwU6y7Mi9ybLpNOXGAJkMltzF8Wo9DKHKIgQl+pDNJdRFCE7?=
 =?us-ascii?Q?ly3PtghEcOHcnAUjIrdbzgT6NEtvQBusZHka2sSYeaL9LTNf2JMx3N0Wpk2j?=
 =?us-ascii?Q?Kl39+CtmPaFavyCzeEpGOOLfEwxMSI+VpS8I/Sni7UZhLCAkO6Zb6I5hwJig?=
 =?us-ascii?Q?PS3sCc2GXvj5Pf80YISlHQfxc0MxoJKwSxASn0Fgs+9AmRYxXRBc72bTvb5j?=
 =?us-ascii?Q?w9v1uRyO9KZAx/07qk2FAf9CkeFO02HJwDignkxs0yfuAY8c8DetfXsMQDHk?=
 =?us-ascii?Q?0+LgPRPJrKnS1KP71ShOkKfAdHqgniDs+5PdwEipebmVodnpAtiMdb6Dp6cA?=
 =?us-ascii?Q?7vn+fXEgcD5c5FQY1oDcDXLLavYx1W8RnxAgr6Ogw7iIlZEhqeuNmQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RJIb9EOfsGwAjuzRP5n3G3IgnWYrpHBOB196dFdeWz8Eg+5amHKluJT26Mna?=
 =?us-ascii?Q?3RKQyJXSUK2w/Gdlpdj86Pyy0bbjX8G1rTvzPXr3VCB6jZN/sU9G9+4K43Wq?=
 =?us-ascii?Q?8cQthrAPlll7uOXrTzOQqlGGSs2pvEdTcT4lYZZej5fELXaS0HEucAs3RtHA?=
 =?us-ascii?Q?EplbYYFjgOe0tRNdd323/M2Q9OQhEhk8KiAmXG4EiWjOloNwHnY9w9hxLWu+?=
 =?us-ascii?Q?w4FQW1QPx/g8LTGMgW+3Vw6zSVYbv+kMazF9HVg5MTBIz6B5vPgWf4vpOeX4?=
 =?us-ascii?Q?HxfleRPjEOU6mBe9H97G/q3MrSdFNApxRVxZGFBD50fT3DmpgScFolwxOMZg?=
 =?us-ascii?Q?ASziLQq+4uBywgveKzXCtcAkCo2M8jOrfomDm17rvFtvAzpMQiJlFZEDUKs9?=
 =?us-ascii?Q?aWiAMpSMyuTxnxlyiA+jOn9z6Hc6kBK5MA+LYpidJxmQdtN++Fgp2ap4izwa?=
 =?us-ascii?Q?EvmDWlpDovx5jeoF1RE+b8/lc81SAJNK9g3kNGU4I6mkF/XzXsSWaBaESWSi?=
 =?us-ascii?Q?9plRs5e4e6X8pfyWfOJppurcnmy6oyntg7Hr14Qxvg0sd22LXRAes/Anb+Cw?=
 =?us-ascii?Q?RVU0vZNHZ/W6IaANAhyMgbCXugF4qlknYCgSsA/wXU7mngWuYORHJlPtt/Ip?=
 =?us-ascii?Q?PqK4FBk0HaUYXoGoX/2mfvgYDnb/8MA+R5YG6APAEY/6ItPFn8cwB1ug/Pmg?=
 =?us-ascii?Q?lGC+jqdq11+s0pL/Mb4vES5ydqoeJtUR1w+bHldhxK8IIgeKSQMjER/hxSZY?=
 =?us-ascii?Q?Cl6qZhEogfSeJn3RcKCy3Vb7VP8uLu6btvEeUskVyUFVtouyhlUS1flJjK3r?=
 =?us-ascii?Q?x5+a2cxTVeWkQ4zWzwpTFDY/zQ8w25ApjDszi7OjuPIG9KkgBD+u5vHyG5BB?=
 =?us-ascii?Q?oHT7LjSnbPySQckftwBPesR0y8JWpePp5RKas2mP5QtPeHjcx9NuPxJLfNkX?=
 =?us-ascii?Q?PZj3pP58PGkqDPGi7NejRFXN5XoscKczZG2c54nhvZmezA4GeiOyPR+9zVmq?=
 =?us-ascii?Q?OiGTF4l68fzDXBzeKHgYWaxdboZ/t265lvffcqzQv1qFlt7r6lrvJliCiShO?=
 =?us-ascii?Q?3LSleieygdchnWsHR7hIYTePSJRqZDRJAP9ZQFMc92gSpq9/kH6ugRTM214o?=
 =?us-ascii?Q?um7uzCaQ1hXOmo/bQ91jKjyG7RDUpqnDdfviJZEUO24wh1hiQSAxZk2lA/aV?=
 =?us-ascii?Q?LeuieGoMB3UNpXhaIgH76KnXvEmVe1f4g2tDmOd8juYo81/sIL3SDg2CaFNE?=
 =?us-ascii?Q?TW80lEUQYBTSsxD8sww2JK16RKNsvm3VXDGE7+82cqgZL2uJBDI4yyUB6nBm?=
 =?us-ascii?Q?JhqmWviK2fxKsLhAiHK2UHuTkfxx/0C3WTPeMs8vBoQmN7bsBGpVRsqSc4N8?=
 =?us-ascii?Q?IhZQ0kJYLJLr5Epo7Uqcj0J7WSQhp5BoD8Hr4xkMeSq4qsfK51Ms1+8u9hAb?=
 =?us-ascii?Q?Dt7sEHM6SYC+VOAyacBgww/C8g88DqdNFRUB31149LWLCypNJqLALIHK7Wzp?=
 =?us-ascii?Q?4ya5llGKe/Y101AoFYoGXnWf/ze++37BdBYGo1Gk3WT12Dts9XOF+jz3x/FG?=
 =?us-ascii?Q?X8HvSxvtowjn9NRCiddyL1ocnFZ+a0WoydZmLIglJH4HBgGkW0kjH/HSkR5i?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f44730-cb51-4a52-a674-08ddf764b769
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:10.3733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgDzjQmx71cvmv2mA1GCgZkZDszKFnQHfLooF71Aw+9q/KmetZZTNObjzX2bMCi5Kb7T64Y8uRi3IBSpIk4DIMgxSJpnOocYTQ131LX7MQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

As for the i2c functions, drop the dummy entries that, if ever used,
would just have the standalone app get some random content in the
return register.

While deprecated, the spi_{setup,free}_slave functions do exist even
with CONFIG_DM_SPI - and a standalone app can't really do anything but
refer to a spi device via a (bus, cs) pair.

Eventually, one should probably export some function that could allow
a standalone app to get a struct udevice* corresponding to either a
full DT path, an alias, or perhaps a label (provided one builds with
-@), and then export functions that can operate on that.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/_exports.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/_exports.h b/include/_exports.h
index 39278a34942..c1511903088 100644
--- a/include/_exports.h
+++ b/include/_exports.h
@@ -47,19 +47,10 @@
 	EXPORT_FUNC(i2c_read, int, i2c_read, uchar, uint, int , uchar * , int)
 #endif
 
-#if !defined(CONFIG_CMD_SPI) || defined(CONFIG_DM_SPI)
-	EXPORT_FUNC(dummy, void, spi_setup_slave, void)
-	EXPORT_FUNC(dummy, void, spi_free_slave, void)
-#else
+#if defined(CONFIG_CMD_SPI)
 	EXPORT_FUNC(spi_setup_slave, struct spi_slave *, spi_setup_slave,
 		    unsigned int, unsigned int, unsigned int, unsigned int)
 	EXPORT_FUNC(spi_free_slave, void, spi_free_slave, struct spi_slave *)
-#endif
-#ifndef CONFIG_CMD_SPI
-	EXPORT_FUNC(dummy, void, spi_claim_bus, void)
-	EXPORT_FUNC(dummy, void, spi_release_bus, void)
-	EXPORT_FUNC(dummy, void, spi_xfer, void)
-#else
 	EXPORT_FUNC(spi_claim_bus, int, spi_claim_bus, struct spi_slave *)
 	EXPORT_FUNC(spi_release_bus, void, spi_release_bus, struct spi_slave *)
 	EXPORT_FUNC(spi_xfer, int, spi_xfer, struct spi_slave *,
-- 
2.51.0

