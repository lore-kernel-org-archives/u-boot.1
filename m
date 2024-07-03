Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3E8C30658
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 01:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49C488784;
	Wed,  3 Jul 2024 03:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ivhrzkSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E20A2887BA; Wed,  3 Jul 2024 03:10:05 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A8FA88495
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 03:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR5CDj1JWDFq9KLzvOjuyC9ZVQojFCooXiTLWaIEGb3UTio5y/NL70HmrAqrYUD2+SzwlszPoSG0fM2TdpimtB/kjq73r4RnNyAQa/BoF03UZkxmjt5yRRMeqJpYpIKC81UzWyUELgQ7moNMC/r81qblVFT7llcy3x1LZzGGlJEbJOTJerd4JR56ylaY76653zuee3AxCf/ghoIpMw6MxTlDqLyGEjhdUpXzzhh3EH1G0AF62wkYyLnfllYYF6FH6YPSr2hVRr2aDyVvCR4RrfXijfyCRJUD+A9lmC7jhJb5xIC8BHY9INNEBHCg2Ww4KMjRzBYDfr/SbTJnJ0nXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoInMuUocsU/HhiWh70T8JNUzRpamp9pMDoJk6qfE5k=;
 b=TEviAxCtlEE7QID6SSaBs4X0OH3NAJI2ulj2GHMqXEd5ViVtttSmtLP4jwgnAxFpb7rUegtgGmg8kyuRcY67yqydbRAFKDcqTNZlssAQTw2iddOYrrjS/E2tGEpftmmVGQxIpmAfcwr/6J0Bo2MSWLIj8M2ZlxJr+o/M00HkSKsnWU8zf0X9upaHAibpIpxXb1buYytPIr06qM8VLjTc6fVEpJlAyHYij1NJ7bRE8rfiNWZJRwvueZXyubkku0foJUVQIT85o4nEx3TCGWtKuqt6Ufccrh1xhMhU6E5VASASq1J/i6xukiGKXFHkLia7HxvggzirdihqTfgDRWc8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoInMuUocsU/HhiWh70T8JNUzRpamp9pMDoJk6qfE5k=;
 b=ivhrzkSNxcgYpkzRj7e4GLBw4cRzIYzA1xDlMJF5Y07Yy6FOwGvbrEmZg/979zYmJt+ebc8b4NVyW8HJpdDdsNSmeOnfyro192IBGW8FEqF4xAvxmLLnUHkNGZhPr6gNBQqohgt2jBD4VvYfJb/hp5BlUpguyXCiN4cLsYoMibb1cqzJEuCKppVv8SwyWdnXaD1dO2c1owT/ugSxfMW9+TNvidXTroxU3o5hf3S0VZssvLiPvIcwuK5BYVJHvDtW0zDEs3I0SFn70DAZnNEelxtI/krjjYVgm7NlaAUrYpDcU6kCIXFW1g3o2YzbBJjk3X6DK6TNA8FYnVuJi/nEwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 01:10:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 01:10:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, u-boot@lists.denx.de
Cc: Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 2/2] spi: soft_spi: Parse cs-gpios only if num-chipselects is
 not <0>
Date: Wed,  3 Jul 2024 05:09:34 +0400
Message-Id: <20240703010934.1735889-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240703010934.1735889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: ca10f68e-bfcc-4fed-df90-08dc9afcddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UTGYd2Db7+ieotlhfZRehgL4FMnX3nx24kCSDc1A54CdEEkR/shhmYa6EcJ0?=
 =?us-ascii?Q?JhkQEWaUzccntJbILMRkoNwGig6PZDruPzxugEwY1uIhwfQ55Rm+cTsENhxJ?=
 =?us-ascii?Q?esSdwjGTEaUjLfaXjCbjdJ74q27znZa88uZN4rJqmtvPhnxhePkgWvT5KZ5b?=
 =?us-ascii?Q?L9X92NTz/NN8/959lNs2wNnwMG1nzeaBJ9QgIy/jJ254bnP3ULFYjKDiylIm?=
 =?us-ascii?Q?QqIaLIdmTqGvSG4ta/9Du9hFKIrVjEW9G2R36VFrUtA80gCqec/jp1qLsy/V?=
 =?us-ascii?Q?a9nN0TP3YVkDUWbEevJ0Ltod5FPhWENlvt2kUgqn/TONWDM5o44Fnq7vK6lR?=
 =?us-ascii?Q?F1IONoh7A6rfNkcuHOqY/pwDxJKX2rBXnxhS8Khq3oHSXnKO8Fsd75NG1WUD?=
 =?us-ascii?Q?82GeXVaualtZqYU9lq/1l2EJ1zzid9su/s5w2YLK8J+ub9oXHB2bhBYuHmpp?=
 =?us-ascii?Q?puFEKOEYLzaOO+V6sYNV/Fi47Uif6c/3uLilqFJo0tQOIeBYR2PKL4pNad+P?=
 =?us-ascii?Q?k+5ifQvPOkHjjy4jRa2HUPaIHxW5shU03tMUjqE8Hu8tfvFt3+AQ0eCl6Pbc?=
 =?us-ascii?Q?8qE+W7Kln4a+CBxNxvwgKbjhI7Yf8/JYPMlYnXP1Tlm2GSLL+8K79ttIzxgU?=
 =?us-ascii?Q?8UhJ6isK0vA8JzA7y5FsxqX4pv5EvuTSQIfg+r+55XhKNXBCpQ4K2e1F2SKH?=
 =?us-ascii?Q?/gm7KooQRIQnkOP/Xlnw0KlYGV+uyEAtAGEej7yxIg9HknGMGpRnMxU8gp4u?=
 =?us-ascii?Q?/MmEb0EfgjeriNzbGdE8uvpKBbIbOX7B4xbTGljwmUZzDTW1a2+ztk20e5Ql?=
 =?us-ascii?Q?GudTJpVC1jocVJy2FyenQZlYp5sdPDzhCx+o3Sqqob/5+C61CK8QZ6fFwmiH?=
 =?us-ascii?Q?8rs8xQs+Asfq2pCGRybKKIliS2X6TZdwiWIJx/IpUWQZ0iOMROVfToeLIwxP?=
 =?us-ascii?Q?Z0H4qOfjlOjnso9gn7MWAzRXi6I4h5Tca5gnAIGkgr+/l2nYrbwO3vMT/81j?=
 =?us-ascii?Q?1InVLKfiYEBggUi+FCTdcpn6k61tlfqyIFgoZwYv7IBJ+2qcDTGJg5RGl+Qc?=
 =?us-ascii?Q?xbEAfG4eVdvK9rxawy+EnggdZkWbpDDotrwBPptE7d6Yan66L5zUe6HfAvy9?=
 =?us-ascii?Q?H9J5tHIhA5v+yshfsEFoGEjvPzinwT1pfd5yGo8hYSpNAi4rtGG0bQwfHssR?=
 =?us-ascii?Q?f/cCpIu6h+JdSAvdTpo63OCmfqemeganzW4eFxOL76fVeck6577zrU18nRho?=
 =?us-ascii?Q?EFtZudzb2RIR4svdGL00Z98zXCIaqyP9CrTwCrD3DViclEOH+ouVJc+s/ZGn?=
 =?us-ascii?Q?F4FGiFVU8jS5Wlemjjrl7LgOuz1BFkbtKqmK6GqaISe465RAu8Vi88C1TMa9?=
 =?us-ascii?Q?gZZtmZTqRg6b/KYhQKMif3ZrRezXASXHQ7IxRPYmSXgvIPTKWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqICooy6FbUYhmrfC1d4P6vNpIknZ7oEoMYB9WPIDh1IiT1bcItnWvxvrF7s?=
 =?us-ascii?Q?oWAPNYbcmTdn3rkYe55KqCZjgNnrKBZhWacTGJdnoBv5tE7f0HIdXEes+OUN?=
 =?us-ascii?Q?IT78fFh231YRSg5Cf1+eUkqFFtMnm4OYFF7VNYpLntAbFe06Z5s7W4xg36pV?=
 =?us-ascii?Q?Z1jOQX36yePrnEaqcxKARSKiyjb5i6h2WSrVRe+MXrdPvgjcLiyRe93HBtOc?=
 =?us-ascii?Q?1gJsxFePxdVQtzVl1fkARWnLiDQasAArSmozgvyagEIfYBWGW6bXF+1g2393?=
 =?us-ascii?Q?Uc1/c+poTKKcgwH9SDljR/hkIwuc2xvc9n9Fg0cj4zFyw+cbEO5DEcR+ja9p?=
 =?us-ascii?Q?h1rEcfH5uPUzJ4Qaw371rCzQ/YdO3Cm8xCcIRdx/0pazGLRafQ57UZwzIWED?=
 =?us-ascii?Q?owcHqxxdc4GW55a9GguzcCCLg0qlS+mkUU7RNoG4JLJAlZI71hhCseSKeO/L?=
 =?us-ascii?Q?R6daj8I4qhKUZAKHgNl4P4ZC1l2tZKY/q621sT0kLbKEzoB70J5v0Zzvppmn?=
 =?us-ascii?Q?jo6idku+pz0fsqL8uhkTMXAc6/hrRapy3dECzIxpMQ8Zrh+qF/hQsf6FtuGF?=
 =?us-ascii?Q?4FRWeir9B85CETZZtsHBZmYMPN0pSMu/mebBHVS2uP+7LKLcg9jPIZWblx5L?=
 =?us-ascii?Q?pwXXSc3KqziAXTyt9r41N4yXVNuvvN5dWx3TecvBJXHSmtDnQ7wb9Wvb4Tj8?=
 =?us-ascii?Q?GUTOn1RtGOAwEuwp2L0xVH+m2r4hAyqeFICD/SHreN5/8Wk76OGcPvi3j6RV?=
 =?us-ascii?Q?z9r7Vf/3/lsEDrj7iHC8jcgsx+SwWfIFgFYwTPelb6/uSAHRmCsXvNs+Cait?=
 =?us-ascii?Q?Wm2cLCqM0ET7U2eIzGSG2H3htXHwlwxL31oE+qPYTvdMfNNbiEDdQpFcLnPB?=
 =?us-ascii?Q?71ZKLBhYpZc2Uu5b17NFNBvl0CqIfq/4BLlhpVbjvXe3irwHdtp3BykSt5Au?=
 =?us-ascii?Q?sbodnpD37ZG73jWCMW2wujQySP1IGW744SDtEi7uQb50UpsAOc8trVg0VDq7?=
 =?us-ascii?Q?cosDcYwEJoVgocxWrYE0ZF22Q30eK/48EsRb//cCkz1bXiZiFReV00r4DVlH?=
 =?us-ascii?Q?qu2tQuywVACLVkszZWL132Ol8HfydyshiF9UOJyaL+g2nhj5fSP1eEhUvJvJ?=
 =?us-ascii?Q?66GF7AFz+RQSdXEvLcmhMFsMjZBH9eBqjksfw9tZKGE82Zve7xT4vV/v5n/i?=
 =?us-ascii?Q?M+fTGhkHqw3T7RTaNeEj92hb/WtFw+HcRgB2HfAHQEwWuCWxwq1vT64HYKHG?=
 =?us-ascii?Q?Gf9h0hPJMTzr86ecxCNKwnN6lvB82i3IGHjltKuWH6K4nJiXC4h5RwEbVQuX?=
 =?us-ascii?Q?ecRKhvu3FWBfb0z1L1CgzQicouuiWuxAJP8kvdyqTlH0b5NEUyMufB/89/9g?=
 =?us-ascii?Q?B7s5pPqu/zxbKAF726mu9zWRpIIXRClfK2rrMeujm/+hY49jc4lrHZaK1PvR?=
 =?us-ascii?Q?wfRu+TcGV50M/e2/HrGRd+XNhoyWtREXFudOlrgRBNH2PyVadtqVIaL+JC5Z?=
 =?us-ascii?Q?RNdjIjPSUaaX05brHe/Iea9RdD19mkkk/Cq0SQtlxRHhmuewwsNtBxelF0PS?=
 =?us-ascii?Q?oM+o6Z3GVuidla6fsZHrzZ67QD9dgGN+VQQ1ai3d3cda72Y0HmE/RVTgjiE1?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ca10f68e-bfcc-4fed-df90-08dc9afcddc4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 01:10:02.4288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSYLG73CBOCTwG4Y+jQbBS6T5fQlC3WPSuP6sAISR6h1NNXX+a4WKR2no7TAwlKg+ozwdMFn1JbPXByz6Gw7ohftTEWw3nfpdmRpJAVG24o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
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

From: Michael Polyntsov <michael.polyntsov@iopsys.eu>

Some boards don't have chipselect lines for leds so cs-gpios is not
specified in the dts leading to probing error. Fix it by making
behavior similar to the one in Linux, parse num-chipselects and
if it is zero, ignore cs-gpios.

Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 doc/device-tree-bindings/spi/soft-spi.txt |  5 +++--
 drivers/spi/soft_spi.c                    | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/doc/device-tree-bindings/spi/soft-spi.txt b/doc/device-tree-bindings/spi/soft-spi.txt
index bdf7e86befb..77b01b2fd9a 100644
--- a/doc/device-tree-bindings/spi/soft-spi.txt
+++ b/doc/device-tree-bindings/spi/soft-spi.txt
@@ -8,14 +8,15 @@ The soft SPI node requires the following properties:
 
 Mandatory properties:
 compatible: "spi-gpio"
-cs-gpios: GPIOs to use for SPI chip select (output)
+cs-gpios: GPIOs to use for SPI chip select (output), not required if num-chipselects = <0>
 sck-gpios: GPIO to use for SPI clock (output)
 And at least one of:
 mosi-gpios: GPIO to use for SPI MOSI line (output)
 miso-gpios: GPIO to use for SPI MISO line (input)
 
-Optional propertie:
+Optional properties:
 spi-delay-us: Number of microseconds of delay between each CS transition
+num-chipselects: Number of chipselect lines
 
 The GPIOs should be specified as required by the GPIO controller referenced.
 The first cell holds the phandle of the controller and the second cell
diff --git a/drivers/spi/soft_spi.c b/drivers/spi/soft_spi.c
index 3fe62818a44..2e80b7bb08e 100644
--- a/drivers/spi/soft_spi.c
+++ b/drivers/spi/soft_spi.c
@@ -238,6 +238,18 @@ static int soft_spi_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
+static int retrieve_num_chipselects(struct udevice *dev)
+{
+	int chipselects;
+	int ret;
+
+	ret = ofnode_read_u32(dev_ofnode(dev), "num-chipselects", &chipselects);
+	if (ret)
+		return ret;
+
+	return chipselects;
+}
+
 static int soft_spi_probe(struct udevice *dev)
 {
 	struct spi_slave *slave = dev_get_parent_priv(dev);
@@ -250,7 +262,15 @@ static int soft_spi_probe(struct udevice *dev)
 
 	ret = gpio_request_by_name(dev, "cs-gpios", 0, &plat->cs,
 				   GPIOD_IS_OUT | cs_flags);
-	if (ret)
+	/*
+	 * If num-chipselects is zero we're ignoring absence of cs-gpios. This
+	 * code relies on the fact that `gpio_request_by_name` call above
+	 * initiailizes plat->cs to correct value with invalid GPIO even when
+	 * there is no cs-gpios node in dts. All other functions which work
+	 * with plat->cs verify it via `dm_gpio_is_valid` before using it, so
+	 * such value doesn't cause any problems.
+	 */
+	if (ret && retrieve_num_chipselects(dev) != 0)
 		return -EINVAL;
 
 	ret = gpio_request_by_name(dev, "gpio-sck", 0, &plat->sclk,
-- 
2.39.2

