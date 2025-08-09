Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A160C87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5294847C3;
	Sat,  9 Aug 2025 03:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="W20tHxqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96283847A8; Sat,  9 Aug 2025 03:05:23 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5A5847A8
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8SzagJc8VuKD9KsBe1hcbLocuoocgsomaS2FsSh9h917+wjLDO4Z3pvu0ruyxRKDLjQQX7IIH8cdd5frd9yKZ4JZhhzUWdhYqQzjbtqzCKWoJwFPI/VybsOklNxrZa5A8lgDSbUWMM+d0ixhArYvtHlBp+VsZqlGlqqqW7bplD16Y4IRaVu41xrMkiuwMpqwWIH/enPDL2aHLVkjd5IXrVQ1y/6AA7eOt6fREDffD/YPT+azWbETWGD5XdWP8ET9jpmtt+XbOUp1cY3t0MT2ZAxBVQ2X7w1fqLWQMCuwbsvOXWizCYQg4HB4r1dfFtCKuOxHkTqm8UWscuJ4LMVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JRl+GqaCy0KR9mVAJ6z73pJk6Q6RU9TFtRRUZKL84=;
 b=Nlg+Rby+JNtOifDtI3Lxp/gPwXdeAs1xD0kbbvfzIUyWdoG0BYEfUJSQZ3PzSu/3Xh8mgaBcfPO8kzXG6Rmc7FNwdL0ENDEHobMKWVD3tJ42iEqa4LoKw+phvT1LI8yhne8z9vqvtApnNxflsas6ABHEUlYT29MnQJs/Nb8Wp6PdtZ+UXSuASwZevX3yLybZFVUU+la+k6m1a6kS21WS8gcuGan71RjOHrOY1o7tLe8CPWbmL9oDnx1muGhewYTeJY5Eb26R7tjM7osp5VEVl4Vo80H5mxl5sRFxp+9JGBmOl3gVwUy1rs4hZ9rQR/WMtfyCfJ8Y6pTsZk04fLPb0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JRl+GqaCy0KR9mVAJ6z73pJk6Q6RU9TFtRRUZKL84=;
 b=W20tHxqJgwgRs0yvKU5bnZlumkkaY1bYULSLTdrteMr4exAm8qbuJjvaedW+ArK+wriQnyOlOXqr8KXq/JWW8T0Hy02nWmegpBYTeo1qL72GHiLTWwUq8mYbuLBT7lvyXY+3rVSt6YIeV6jJ3sqHaL5eLgJkKoidS/ooawhnP9fY94A8E1h9iDAY5TnorftPJA0FiI25YQ9v+mpebi0mw/UpzwJ55A43RQPttbfXJAs7mfj2tBm2h7Kb8pP2bF/hSwvlZg09yBERRbVMu5IEOpHY6mWN5oCvRB2zNiFV3AG/Tz3HCyy7v5lJop8nwGDKKWvx1Q3CXLAC0pGCYKKdcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH v4 04/24] mtd: spinand: core: add missing MODULE_DEVICE_TABLE()
Date: Sat,  9 Aug 2025 04:04:36 +0300
Message-ID: <20250809010457.3125925-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 807500b7-3803-436e-da97-08ddd6e0c987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5cTnTShp45JJvxfCch6Lb7v4UWUKCAF0z/hVlQEqWzEfX32BKxmx7tDvDwf?=
 =?us-ascii?Q?Nosam4mJC50DONRR/E7bXTMVRHfbBUAJdcot08dJ68t24G0oIAEMI5UHmxkL?=
 =?us-ascii?Q?Ryp0DhXeyS41fLaTARsDn2FS+GSzX2J3xcMe11mX7ukxTghlpSe6Lfa4Q+cw?=
 =?us-ascii?Q?a45nF5LHz0BisKu0LI7K3FBCmyyUgtPdMyfhP7DbVPXelqMolDgq5NjO/rxu?=
 =?us-ascii?Q?8h0D9UXp3HsJhxCmiM5S6jpMKsmOqH0NGyAdtxXgKFGJbnqHAspeI4hjnYl9?=
 =?us-ascii?Q?CkccqhjSXMO7vWaH63RAF1IbVFqhZKbnzWwKsSl6SUEqEiUE6Y+c3qVei4CF?=
 =?us-ascii?Q?51BmqxhBjFo6B5Fd0GpJILM/l2M1iDvSKsPJw0NxerVPzlmAV8sMxUT+iuIk?=
 =?us-ascii?Q?E6UkmCE5fHTfOIoEAjbNLZtjzC5LzGQ+nRLb4e4T6NHhZ19Y9YQRdvnktKlB?=
 =?us-ascii?Q?f1W9NipJ7YQvxiEH9AgFfLwzFnrCY7PCkAwLqjwaAgQQtOMpi6lokaIS4VVF?=
 =?us-ascii?Q?Ykf/BvCF9Il7mS+2ybxRM0I4dz5jIAbTzcO7iHJwL8cBOKbmN1y88yqKA9ef?=
 =?us-ascii?Q?AXEkJhng+2bwixoMbx4MgQGQnV3F2+pzSxLM+5PaJ3btKp8hHQAk0TRE5Dht?=
 =?us-ascii?Q?TstK/+ykOB5KbCoO0y5rfd5zaQVhqTpEsFd4LRnPHIi49W2Ck4gZ57++eAOI?=
 =?us-ascii?Q?Hp4/nQFPVsW4AzbPYB/cHh3etsBVjSuZuNRfw4v5tsjIVIgWWnqTppXNk7/q?=
 =?us-ascii?Q?afDcTRdP1YyEFLuWGLChd0T3yp8mHi2c2r4SjyMUjHTVuOBbfN9upJrGnB5l?=
 =?us-ascii?Q?rtI3lA+mKIzm0OdIv0YXYB1Zy7B5fArwiCgw+5doycwvTG9ofuOZcPrjbYMG?=
 =?us-ascii?Q?qJbDir27xGT2qxIj6Z00B7a9q3wYLDsm8M9QXlMbeU9A0DF3HFKT+aFZYSbf?=
 =?us-ascii?Q?UcBWcZBKO9GlfZA8Zgw2wSnnLlpVnuq1WIWPa5apbFVfex6Gwndv/taeJu7G?=
 =?us-ascii?Q?N8qjOMFmFTv/parCjO5xUImlO4JERES5V1xrj4RDEZuEKCeoj8ki0j5T1AwV?=
 =?us-ascii?Q?biKusnBDLYnNIrr3qvezhdfs9k0P56Jb28/xuoHbtiJ0IgHLORLOI01HKqfb?=
 =?us-ascii?Q?9J4Jg7PKi1RUgDkpgydXMdHL5fPOONqPTlA0zzhVUn8TXOnqvlhrg6DXW/FN?=
 =?us-ascii?Q?TC3SghDhXSjKPsnpoiKQ6IRCaMo7Gu97oM9YG/PQXuKs1BeixSGDAthrFmbl?=
 =?us-ascii?Q?tss8MGiVM+eY7rz2B/Rjh5aGDd3yXt+zACTTOTOPVE4jerIEzanPTlLMF+Oc?=
 =?us-ascii?Q?qtFmSY66bRHnax+c6m6SNtqcaXsJx86PvYtH4BFuKN4n4tdGiOp0ee2Fc32j?=
 =?us-ascii?Q?qevPJfzWp0l67q55gMqnqWB7jVTlc2yln0Mhou4EtMJm3Z+Mqfc4z9e9fGE6?=
 =?us-ascii?Q?78IlVAIThPl5mSVNpLCXY3IQY70ZdPa/8grV3W20DOdCVD9XLtyWrTfsEboo?=
 =?us-ascii?Q?07o8Kix2USYWTa4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZiG5cmizuBngAs+K1HHqScbXpTx05RlzbY9F73CCv2yJstzC/If+p7AO6GTT?=
 =?us-ascii?Q?QqkeA3DmXTE1YHGb8LIe6Ei+3ZInCNrPCVKPKNHT9RDNcTbZkrLHCxISK4fc?=
 =?us-ascii?Q?KHgfOpvHpa9aRx4B3f6STphpSD3zH6OhYiZgOJgJJ+UpN9jTKbb2mI2UPtrn?=
 =?us-ascii?Q?p6EpvWhq0D/WiE/XkVFdsCQMBqIz5XUOnjGs5c+/rW7BpgSg3yoy0BMcHVwI?=
 =?us-ascii?Q?mEjwpw9pJCdLv6LkEYqDY195rdvxX0DRTLPRxxYuWKtP0gYnuoguC110I83P?=
 =?us-ascii?Q?XrIqzNOAcDZEijF7pp7ToJLX0J4x0AtnlpGt9Wmx5t9rRK3FHZjkoOC/rldv?=
 =?us-ascii?Q?86GGFJOFbazq161LXMw5dhL3AadXS8di0pSc61+8FNfxLa6Jp8KMz5/bSkgK?=
 =?us-ascii?Q?6GgNbjsfvNDxpcDc2aYVgMfmiEJt1zGtyuLTmgorzFGL+h/GS8PUFM/56/04?=
 =?us-ascii?Q?1WG+LSntKBa6QJ3WnDo0lQEVfxTuUF36zcKGzddcLhCLpfxHQngrWxIaiQpS?=
 =?us-ascii?Q?EMKgnyJizSnLSRyrpF4ctqGRYuhvvKMTqit+6k/IpkwvDj5L5ecd7VjFGaI6?=
 =?us-ascii?Q?4qrNsUfDPav7BS9T1wAQwbfCSvwsVmJbo9v0LJrfkU4JXmm/1r+REl67Bi/Y?=
 =?us-ascii?Q?RjrMgIVGawEF6XEFSV0jtETQtJpkETX228R8AhUb6c4/YS3B3kLDkuhNyq1h?=
 =?us-ascii?Q?qtIfKWC/hInWGKlv98LparDFrV/0a6M88p863Wcluq81BpyjXpAmNUBxUWZd?=
 =?us-ascii?Q?63NYefl2fXqob/LhifZ1n6SKx3N6Japp0jEEC4oyF14pmV3nmnx9bOLCh0rd?=
 =?us-ascii?Q?GYC7Gb6aj+1/1w/VjNwjZeg6smq7BQ09FpyEXfjFGlv2mREDwMrryc7UtWDe?=
 =?us-ascii?Q?XqKKoYGBp2Qh37tqKM7xkgW65RDxRkt7wz2pHF1gmDdK6Mp/1mdT2HBBmocO?=
 =?us-ascii?Q?s7L0COis6wreCQ0tXfehygYhRz0Nr6q/QvQMA/3CwRsHQTqtYKK0/DCNl3Vg?=
 =?us-ascii?Q?SDj1BtwWuN5VabjsC7DxhEpWyv8RUwcCxdQQJCW+hhe6Nt151VdM41+Z0WC0?=
 =?us-ascii?Q?Ocz67pj3NbGzuRquhIhui9c/arLWbgEBb6OC8xjptgpQ2hcmgzFM+YgpimL1?=
 =?us-ascii?Q?prsxmemPTOg8ESb48b/zcVRdN3yX5Vi1L7xWFYtmgdngcR6q0T1JkHpIPkVC?=
 =?us-ascii?Q?s8Fb6vyJHNPGOjpoyZwc0NWePJengaYSg1qKn+0N2pOUXiXqolHlIf47dR9T?=
 =?us-ascii?Q?a/rQtSNkTacgqPEGwwmeV9XGqEEgH3IMEPx8NVwnIBqykPmj+C9mAMDpWXR5?=
 =?us-ascii?Q?hBZjoM5c7jJLmtS2hyajs9B1zctRdDdq31YeHqgi4qnQ4z7bfW6WyScsY7BH?=
 =?us-ascii?Q?B3CXikDcqXlHdYoBgwXTXiluzo3ixeyFhvlW6CZ3AKxHWpgaiKNYpFFX00c7?=
 =?us-ascii?Q?OaJj4E2u8uuiOdXFfHCLvH8bbj34zJK/gzXBXBcAEg4OIL4RV5V5NogeH2+g?=
 =?us-ascii?Q?SYLz4siMvHNZ9pIJqr3jCiMvbQTTabAUZSzbg1LgPoR1HAXTLvZRHNXr2pHH?=
 =?us-ascii?Q?jzQFXP0eBc3JrUkcvSKPKEkyyW3vTziJuHpYfGWOEIAl1L+nfd0Rg3795FiZ?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 807500b7-3803-436e-da97-08ddd6e0c987
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:10.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN4EN1D6MhQg5F1kU6rYDTnl0ya26x83BvmRWnKcKR7tOENJSTM7GYkd8SjFgtiYa2an1au39E7nPfVnTv7E8H9NrRkzf1g+p25g21ViWl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

From: Alexander Lobakin <alobakin@pm.me>

The module misses MODULE_DEVICE_TABLE() for both SPI and OF ID tables
and thus never autoloads on ID matches.
Add the missing declarations.
Present since day-0 of spinand framework introduction.

This is a port of linux patch 25fefc88c71f47db0466570335e3f75f10952e7a
(mtd: spinand: core: add missing MODULE_DEVICE_TABLE())

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.47.2

