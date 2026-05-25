Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A4CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C513846DE;
	Mon, 25 May 2026 05:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="IZk6srdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DDF8465D; Mon, 25 May 2026 05:20:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429E5846BD
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhCHqZBl72fk6Z6cGumRCQeyee/fFh3IdmmEggqAxniUVDqdQt5Z7dQge665oX8U5SNlz0lNYsDwvlg7MKbCt+k4iocoJHi0nfGPxq/NnzsR46+WWMwEwF2RX1BZciFYRyhNgeLtwMXPhH0/Hp64B/fxsM8mnWcWC2Lohs6J/4MPIJfTlHu6yprver7qvuIxBgdmzosPyZ7Vc+Vem8ItmbvFwIeyqv+GDmkbpQaqUXoNJdLWrxL7kesv/RnBTFgTmQ/aYz/NMXazbSe0O0PnkZPlfGpNAutcE4W50mxn6avGvcFMGlsZs9HNHBGjkgDmCSzUAOZiTpdf/VMNRVypmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh47qcqVXjFsk4/X6E2u0RCAR/DuoC/BRfg83XCvJSE=;
 b=BVitdJzfm7LVbmq1PNLpcxsAqYfeyXTDLhSq7lU7DyM4oNDgyN82M2x+NfrYkp3qh03KWj1SyX3mzpwxwIjfeZOVA8RDeFIIEvjMaEmlRBqwyI5pjw7i12lB91KnuDh4uBplq+LlvRdeysvLBvQqPMggvNjfECA6udiy3ywf0ucuDJNhl/AiFYnmXSxyqNXZPaxetSODtbuqUufzz0QgXUmu2WfdNr5C1TD4zPN4FailNRyloWtWvh2ok2Fqg/r7FmgrmqKUvQLZGr9HzaQx4P1cVaqGp+gv17PpjE59WFq2+lHzHjoFalbntBwNYXAWctfeZPOozQvwFhJuo/Jl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh47qcqVXjFsk4/X6E2u0RCAR/DuoC/BRfg83XCvJSE=;
 b=IZk6srdNAT7r77nQOislIUJMCglYv6vhv7cAy7MR+Ne3BdTLbYKaZUANIg9pC1XTdWQsLURK7VAOAZd45f/VJ4djmh+zwv7PfyyryGFNLaoaiYY95k7qWJ3gj9TYI0bhWCb5QaoFiuERiUlDmXH8+3dbL38AL+/L/SKZ3p4Aab8H/5yaXPp53iS9CfjOAENGeu0EzpnhN29SHSh7Y+UXqhLXMB/E28G2rFw2kErPHLk6IQtwb8vDugJKFlXPz5ZZaQik+O0juyeY9IFbdrXb9rL/udzJFYS4iYuFCOPXSkXG/exyx20DXpHH+roJtyXjqZAn16OimPSAnmEAFfo2EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 25 May
 2026 03:20:43 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 03:20:43 +0000
From: peng.fan@nxp.com
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, treding@nvidia.com,
 clamor95@gmail.com
Cc: BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] crypto: tegra: Use dev_read_addr_x()
Date: Mon, 25 May 2026 12:37:14 +0800
Message-ID: <20260525043714.2374516-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525043714.2374516-1-peng.fan@nxp.com>
References: <20260525043714.2374516-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d54ba9b-52c8-40ff-7feb-08deba0c9a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: BiQlfqvq21olys2h/ruZtMG781Jevp/dHFpRaPNOi8iAw8bifXFBnPA/0OuFU2XUuXfPwV2dc6hM2MYiL77CqzqJMCmamoakGZFGNv984esI9/dZb+akYjfJY2IRJtMrRtT23GIeXLF5wQauT+E3wY3WExQ1z/j3WOLqHiVRDNW5naUv201qneHJnCUa6qok5YNd/Dw9V8qPC4lMuGB9Btsn1vkpaHN3QPi3IKCTF/UQHd6Ma3y1NdBiByk1S6FfZulJKcbWaEOynNCHwozxQ9N6Qj+CnW4ByMdf48DPEJJyBPZGSpYP95YTPZhgin5kMF/xVqrL76TriQLtSI+74M5GC8rMIo4FpWWS2rpA7lAm3Fc4/Jrp1TphciMcw9obTLyAxd6jRo2Wm5kz0UHAWYPzbJ1BRTovu8DswP+judiQlu4Sw1zwJxRVZQBA5xJUoydgKreugOF0Xpq3ADi2wyNcTasmZEnGaGNnqPSIq5KUssAyihaSAaNgXg8U5Nje492fA3tlwHfTK3TB4PyltuneN/7k0OpBce0aJRh1TnjcKLQ85Lx88eTYw5dyb4MvUwYWTJWOPzJ/2bCZZM4MDKBlILrVwDLXqLGqPsWEZ5UH/hmboVzFeSJw+I5EQTjkIOZQEUTOJVLjRYnan/CLIBvp1EVw63vuQun6PvWXtILpnA48cd2+mybzYJ91YqJWASehpt9YF9/Qmde1hasylUMYMvJbXNFceVfYa0RUwVaSVaR0RG3UVXKo8E3Q26pE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDP2ut1G1dyJAHWxqn/W4zTz3KNOSnlAmix6yM2zjI7X9X2ILM2mIwufthUK?=
 =?us-ascii?Q?Bwy/VEthGyZFBQz4QNE9iSPXex3MRDzQI5ce0GJA1uQu5Lnjjo8WStuZGnxj?=
 =?us-ascii?Q?K7Q2anc+RDfX69tt65av23V5Hp4K9qaNIYYSL9Anp9nT3/suf1thQuRtMik8?=
 =?us-ascii?Q?5YNVhqwVY7pb+1E086Uo+gHMuLKmUPAQC5NZ+EG1GWpvir3U4LwpzSoTpaK/?=
 =?us-ascii?Q?RnxwmziBLDyC7cjCojBF91cft4pWOE5bnJyXkBAVwbHaDG/jxUnZvzrMx9lb?=
 =?us-ascii?Q?sc/0he6NUmUgs+lEMFZ4r6pSJq7bskmIbgPRae9SIwmBX92yT7KKGUXlnOM6?=
 =?us-ascii?Q?9MXNsQDBJne/a/Kdcj7GkoWrnqURkGsPjmSzoxcTJjG+6s5LDXN6B9iaTZqB?=
 =?us-ascii?Q?3RfyT4Vg4cGlsPLiY2phR/1UJXkldTtYwtninpb9bWf1kWBvVoTZR73s/4w/?=
 =?us-ascii?Q?Zsey+Rupq+kin1dYOThI4jj6oHREbt9X+fnZriEATUkvaX55oStUV0KFQ5UX?=
 =?us-ascii?Q?hDDfBZJhHQ3/jxzOhS23zE0ZSULnY1ifcdrxgy4bfepYks2CIQgWPs7nLtZ9?=
 =?us-ascii?Q?RP19PjXBcdt2bZK8SWoa3MwV+dm+MTSaqTzjizIix3bgDk4irMrreHtYh3Ue?=
 =?us-ascii?Q?nXP9eoAgNFbzBGPCzOxRwXlYq925is1e3KKtdeIw3j6VWJRxuGuAwRGA7MmG?=
 =?us-ascii?Q?Ra7ovK/skfiJfXyIalilVYCOKAORkf7xk6QWWo9AOUDmZ5BhcP4aSZioo7uW?=
 =?us-ascii?Q?+VZkT4AnaSACfVbQxXt5+WUgCbKsrlphSJ/GET/xhAy64OdQQMKpp/DpisA8?=
 =?us-ascii?Q?IJRoiBC2Gb1OfJc3WSpMCTCVMAhoy9ROCyClN5nf0KZf6SamNycYTBIh1bPa?=
 =?us-ascii?Q?JSPfBTjn5lQSSS3Sm2bA2mPiaor1+HuA+UqKgaxDRzC04tgrkdRCx6MMkRnG?=
 =?us-ascii?Q?qnMsu3zSSQfm7A6d/5l2oF2rOUkohvJ4DOTEnSxFaFB3x1JellV35GzspTaR?=
 =?us-ascii?Q?6jHQg9inWOPO5s3vtRCzxlwgMa9kCQErSsGRPXC4YIEf7D4OhRfrprRfo/yP?=
 =?us-ascii?Q?pRz276PLk15kks1VlK4BYApC6QW9gAIgj7ciBF1LcJsXLpDGiF+LiNW24syy?=
 =?us-ascii?Q?bmznv6uNAO1SHQO/Jv5Y2MKkp2rA4Cs/X5gF2ooL1lL4SxZhuQ49CgMKTF0A?=
 =?us-ascii?Q?grpF/CB9Ps+V7LtJz90u2lUktoQ8ZxAXrNThHmGMh0O3Y3bloz7Wm02IVcQW?=
 =?us-ascii?Q?aLSswYMkqkvte1V7h+FRsM4B6U7fFlmww9bb7ks4KAfT5TyTMcA7LmzVHXr/?=
 =?us-ascii?Q?sMVR1YHk+oXZJFrK2M2s/ykWSvGr+cKS1WBvOJ8+BKLIQNtT5F9s8FD6WAH0?=
 =?us-ascii?Q?T+rdO8vLj/ElsBK17Ia7s3XkCm2gLr7GjtRZIK90xblZNk6Civq9Rv7QP6Ae?=
 =?us-ascii?Q?bVxMWyDdUFQb548Fu+K0jOFenyqitPa5J4UBWcOWxECTqQfw9JdD4BrQHQSN?=
 =?us-ascii?Q?QcoFyu/6FMoZWwzvwRE9mr1UpzpMRGE+I3QCGF8mOrq1WURMiLU7S/BikhAr?=
 =?us-ascii?Q?IyNg6NwEQAK4AF4xLrvaQLlLpyadW7BePmt25saFSQ+fiDxvtZX3n0wyEJXR?=
 =?us-ascii?Q?dSomWM9hZ32obAhwV1GAeiG+uuxtW/ZbZo8xU5973FMd6BGXDN2nRlfR7CrH?=
 =?us-ascii?Q?Jj9HMexKQ8eHTBqwEGpticMfXAthGERma6Qhi2Dt6E7cxjR1j42R5xLowARJ?=
 =?us-ascii?Q?3XWIpjRoNA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d54ba9b-52c8-40ff-7feb-08deba0c9a7c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 03:20:42.9913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzag1DWNpi2hxywiim16APsqDo6cmGfU1R4beiozbTkWt8KzRhCl9VBrjpEUAC3mpUBbXO3SArp/iHBdKUdsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr_size_name_ptr() which supports both live device tree and
flat DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/crypto/tegra/tegra_aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegra_aes.c
index 7b374c757ba..55a4cec525b 100644
--- a/drivers/crypto/tegra/tegra_aes.c
+++ b/drivers/crypto/tegra/tegra_aes.c
@@ -518,7 +518,7 @@ static int tegra_aes_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
-	priv->iram_addr = devfdt_get_addr_size_name_ptr(dev, "iram-buffer", &iram_size);
+	priv->iram_addr = dev_read_addr_size_name_ptr(dev, "iram-buffer", &iram_size);
 	if (!priv->iram_addr) {
 		log_debug("%s: Cannot find iram buffer address, binding failed\n", __func__);
 		return -EINVAL;
-- 
2.51.0

