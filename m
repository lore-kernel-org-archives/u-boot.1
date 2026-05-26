Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4751CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0582F84659;
	Tue, 26 May 2026 08:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HR8KICyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7410E846A5; Tue, 26 May 2026 08:52:30 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0E084659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzskYg0jdoDNEFnwe5YqwxEfdV2YUfeYyhbMTm9AjEB/oDBCne38If87NnshvcWLyI9sa8cFu/VnURoJa+fmjDuy49TpFTE5etnYiMsMqiuJhkRynZvq79EPIR+AHDM+s8Mot+qc9vS8gi1kBzHnJzIY/1rpzreU9iDrBCj4HPFO06s3FIYs2OcCVIurEAvwYF+DUxweiPkvrCx4DX3PD89PREot/rCKyRXVpg9YA0FRBXP1RM8aF2CKhDPxoYaRQ+OlktTDFdtSZ3P2XE5qBLFrM8Ti/nbPubGcN5oJ65ujoG4xjcZ2ErauGfS8KGmCKzWnDtGcql/1cFFdlf62jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UuvpilvX5nGlcto5i6My2LfP62pVYOrwscODf5Lxp0=;
 b=TFgKmoR74LsnGj1SHOw2JVRX8I+LCf9p7BVNW+if8msDWmMMZJJS54bVu+u4fi4YYqvXZ3UVcjyPLTn+89dqhwImXY6UFXjTVV61QMyRO1eJIpuHBs9yZqryquRyetqTlL7F2NIZcUpuGamMVDcgYE3uHB8soANQ8sgxW/0xEmrK80+fPfNgWCCQpb7HY1HH/ATTL8tTf95E6GGnyWGGYM9X8007w2Hrh8t6zdz/qzpmqLBdjUzK2XIn327alXktltlRviz+HQnNa6OS70WVHtWqCk3iJsP1OAbg601jEz5N+0sfWxUVGdDBhBbCYQuJmVldoLtgw02Pqt8xA6Z0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UuvpilvX5nGlcto5i6My2LfP62pVYOrwscODf5Lxp0=;
 b=HR8KICyjVpHBpwu7356CDQUjfAjXkNT87R7qH+UzCqZyir6xtcsNLdbeZqM+etlA1tf9u5AW1wxFEOB9RK631bAhuh1jQCyiUXefJnuSyQOXQd0jA1//e7hfc/zLklIMWx+OXWilpAlMk3ihQ91mXnOXwlZuu1hgFmLjxH1C3tWTXqQ815sqpBBc9tONIen6nER3jJbCfXChMplOwQfcKrOjunoUf4xJc/picOs6tCMlE+vOcHc2TcUsU88EUYrFM7yKprJQN3ro57XjOCcXcZuxQykEvr6ZugebX10d1XMDl0vYT9PRFNwdtBZjURdQjnDqnLZ1UoUbjHVo6iVeyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 06:52:26 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 16:09:09 +0800
Subject: [PATCH 1/5] pci: rcar: Use dev_read_addr_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-pci-v1-1-ed7f31d73938@nxp.com>
References: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
In-Reply-To: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 854e3bed-08b9-49af-c62e-08debaf358eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MaMHPd0f+JX0rsgowUitlKJXEbo5P1M5LeBRnZpd8P2ifSL+NcDJa9lbKvuv1eXsT53PpSJ69WQDjVereYfJsmfm0AIklee9LXDhA0ht9eK1ki3o7YWCjpCVKE8XZenimP+aQYFKhYvgcmUuEslIhEYUQItwk/JdsfW/eINGnyr6U3g9R/w+CdhskURfPImilthKDeBKQso4bssqUMKXhLbP9U4VN/RGt0YnuH+Ho+S98wGhWfkVaVI2IgtHsMTO2+jVcKzme5GsJP8MUgF9eu4LnIc/TkMewMixaEETcXCi5LJaUM85B1BUj8uR+dln1y5BgnET31Xa1HIGhT0J65mjFO4X1HRxWv6ANyuV0vVetPzLeqbAZ4S1FhbyUEs9888VyOL1P8998LlQgG7SWQmdxyUIAliXWd/5wOibXdZuxL2xO7Law39Tiv8NHGavT76vz1Gu7KdOPWM8QuoPhCbwnQgLnQyhbSFc+H5SqFaABE1UayTjKglV5EMuKhE8qO1hmen5ZP4T++8TFsDJihqrn00XzEKkW/7jpN32Cv0M2vzS66ZA+PtjSfKf5aDi5GOdSdah8oUsgUpE/HGLjuPRud91eATgOo+IrS8L0pE0biMuy0JR1sAmmVhJIq7SiH76Omjpv4yrk8Ca5PqXGkySz5qWaavbuPqVMaFZIyEomlRZFwycs4jFag8mcgaTyoqHWpDn7GLicrNZmMzoqxyCYiU5dX/6amdZL0JVW1y8YYD1+6zlrur93zxWHdIk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEt5ODBvb1FEeGhiSlNLMDJBZWZQcWRwWmF0Rk9XTkJENEd6cjlmY1pwWHR4?=
 =?utf-8?B?bVpDNkVzd3ZOajg2YWNPS1p0RDJTRFZqMFBGMldLN245V2pXTzhER1hSejlo?=
 =?utf-8?B?QVQ5R3Y0NjN2OGhIRkFoaDdwU2ZjUmI3QktmV2NjeXhJbTQ3QkRBeXNoMFlq?=
 =?utf-8?B?S2laQnlVcFJXN0hHaitrNEdScFZtT3RBU2ZoNGJJZmNGeXppaTFiZHdLcmd3?=
 =?utf-8?B?SXJaR0F1WXdYeWhISm1KSlVPYy8zS0xpNEE5b1IwQzFLWHF4bEVnQ0dDejIy?=
 =?utf-8?B?OG9id0lCWU00NC9zUHZLQThsVkVCYzdHclNaOWIrckZBZDJwRjYrdmFydGNI?=
 =?utf-8?B?c29sbm9NYU51YTFNdmd3ZEUwWk5jS0p6QVhMV0ZuOTVpcEdYOWt3eFhXMzkw?=
 =?utf-8?B?Q3pUNXQxYU9UbW9UTUdCaWRJUzd4dzJWQ0lrVmdpR0xnSHdMa3QzWTc4ZXk2?=
 =?utf-8?B?dklNb2kzSUJOQ0JXV2k4dnNLNE91bEh3OEszNlhYL2o3aXVTSWlqaVh6R3A4?=
 =?utf-8?B?SS9TSXlnYnNDZTdjUEtGNUZqR2dIb0QyaHVWRDAxc2ZVMGU0MTlFSDF1cDVO?=
 =?utf-8?B?MXpGVDBxVjRzTkNYa3d6SGRLMXJPUEljOGNzS3ExWEZRTWJQWEJQYUlpVGc3?=
 =?utf-8?B?QndlSWhsandXTzBNTkp1NXFXelBPOEpFcTBrM2pZWitmZ3ZkQ0xtYnpYNzd2?=
 =?utf-8?B?R3hJY3EzYUZQQ05hNU1rOHgyVStraHpuazdDWEEyWU5SOUtKdy8vanZpZkto?=
 =?utf-8?B?VjQ2aFZJZUdqWHdld0lQVDJCUEwrYjNJNUdUbnJZTXl0alUwc2g0S2NqTzNO?=
 =?utf-8?B?QytmRW9OcS9RNlh1aXJZYnJ5K0xEUHNxSXFCUEtvb29IOGllODROaWtFUCtO?=
 =?utf-8?B?dEpmaFdpdXdUUnlzR1hvRkJYT2UxcVJVSXhqYUtFMHRycUJjRDgwYzJ3YllU?=
 =?utf-8?B?blE0cGpyeWNmNWVuTlBLNE4vRnN2NGpCUkhlUGlRK1NiZFFXZ2NKN2wwejNI?=
 =?utf-8?B?bE9JRlFZUmc3WTNiUWpwdnJRUmp2WmgrWTBhR1NNRmgrUE9VdXJmUEgvY3dl?=
 =?utf-8?B?SUF5NjQ3M3A0VkkvdlZZU2R4Ujl1cmN4L3NiRDZKY3pZZ2loMXBKa00zTStq?=
 =?utf-8?B?UkVVTU5oNzdvWGNDK3pPYksveCswbGtTQWsyTEQ0WUhEOCtObXhwNU5zSks4?=
 =?utf-8?B?MThMWnVSQzZFMjA5UnlCb2JFU3B6eVo2OFB0WE1tMEZlUytWYUdPdFJ4VDFV?=
 =?utf-8?B?YlN5eWlDb2s4S2JONGkyT0x2NFZXWTlwTVI1QklJVDVacEZ5TEY1YmhYb2dy?=
 =?utf-8?B?SVROd2J3bjVKeS9GMUR2ZHhUNEFqa0JRK3RHQitQaGlFNUM1R0pQK2piL2Nz?=
 =?utf-8?B?Tk9ZNXROcHg5blZ5WWQzdHJGVlN2ek91WkxFd3hKdC9uQ2RkbFM4enZyN3Zv?=
 =?utf-8?B?dm5SOC9SZnk2Qk9hcS9Mb1pNUCtURW5JRkwwTDRzTDNOQUlPd1d1VHhSakJF?=
 =?utf-8?B?amxGL3dNcEZ4TjVraTM1WWx2S0tOdGpCZTZNZCttVzJPa2s5SGpXNEVSRVpx?=
 =?utf-8?B?Zk4wcS9hNVJZdHBLUlV3SWVuaG1Jb1JpZFZHS2lIcU54c0ZLWHJVMUhnTVc2?=
 =?utf-8?B?dVpnRlVJZmRVdUsyNHlSVEh6ZkhGdFJ4OVBqa3U3SDVxVW5JNFdmZEhwM2xq?=
 =?utf-8?B?d1dCQS9qRUF6ZTVOWWd6c3B4ZTM1YWtkcnVuNHQvQnRGUkZUY0RDRGRnSVBQ?=
 =?utf-8?B?c2l3dlBNSktBL2RTWktZVlYrMGYrUUQ5UDhrN1lLYU8zdEtWaXMrZjFxZzVC?=
 =?utf-8?B?TjVsckdwQ2hjTXozYm9BR0xMNUNNSHFUbVZIN0FLOWZzTjA2ekIzV2FWTDVL?=
 =?utf-8?B?QzdjNnRsN0swMjNXN2FhQ1lEV2pZOVJWL2JqZlo1ZmdjbmU4YWJOOXRjZzJP?=
 =?utf-8?B?R0FJQlFwTG1DK1NRTmpOcmRUaWNyUkp6dXRPVzAyK2xxZ1kwZUlBTmhzKzVl?=
 =?utf-8?B?elVnRzZLZlh1UG8yVXlwb0tpWWVFaElGcDZZOUdUTFFvS21IMWx1TFVUbDNw?=
 =?utf-8?B?NlN0dW5xV2lsMExNN0lqdnJGdWx4WkpXRjVtRHlwK2RmRUNsb3I4L1UyTU44?=
 =?utf-8?B?R1Rwa09ha1YyYkdmb25QM3c4R0dod0RSYkNUT1d6OUxGeHNUV2N6d1RQRU5U?=
 =?utf-8?B?aWQ4TlgxT1R1cjFieFJrSlUwZDZSOGVWRENtZ3A5QlRpaHdWS0pDblFTWXRn?=
 =?utf-8?B?ZTh4eUM2WEJmQVhxejZHeEkrVjFqdGg3djdnb2d5RXVDUWpFd2g4aWttaWsy?=
 =?utf-8?B?OVhQRTArNGZqNC8vblVUTjhObGRZV2NqUXhZYk05MHRrcG1vR0FrUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854e3bed-08b9-49af-c62e-08debaf358eb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:26.5716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM6ux6cbEFSy7o7scFQZi/UbDZX1XzeAP3Hiqm0Dwu91erkCNrugt3SXw1rWwyatvw0iS2z7ZzAAzms2x286DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

While at here, correct the return value check.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pci/pci-rcar-gen2.c | 7 ++++---
 drivers/pci/pci-rcar-gen3.c | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-rcar-gen2.c b/drivers/pci/pci-rcar-gen2.c
index 08d5c4fbb8b..53cb0916741 100644
--- a/drivers/pci/pci-rcar-gen2.c
+++ b/drivers/pci/pci-rcar-gen2.c
@@ -10,6 +10,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
+#include <fdtdec.h>
 #include <pci.h>
 #include <linux/bitops.h>
 
@@ -235,9 +236,9 @@ static int rcar_gen2_pci_of_to_plat(struct udevice *dev)
 {
 	struct rcar_gen2_pci_priv *priv = dev_get_priv(dev);
 
-	priv->cfg_base = devfdt_get_addr_index(dev, 0);
-	priv->mem_base = devfdt_get_addr_index(dev, 1);
-	if (!priv->cfg_base || !priv->mem_base)
+	priv->cfg_base = dev_read_addr_index(dev, 0);
+	priv->mem_base = dev_read_addr_index(dev, 1);
+	if (priv->cfg_base == FDT_ADDR_T_NONE || priv->mem_base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/pci/pci-rcar-gen3.c b/drivers/pci/pci-rcar-gen3.c
index d4b4037ce19..1925d968c16 100644
--- a/drivers/pci/pci-rcar-gen3.c
+++ b/drivers/pci/pci-rcar-gen3.c
@@ -19,6 +19,7 @@
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
+#include <fdtdec.h>
 #include <pci.h>
 #include <wait_bit.h>
 #include <linux/bitops.h>
@@ -391,8 +392,8 @@ static int rcar_gen3_pcie_of_to_plat(struct udevice *dev)
 {
 	struct rcar_gen3_pcie_priv *priv = dev_get_plat(dev);
 
-	priv->regs = devfdt_get_addr_index(dev, 0);
-	if (!priv->regs)
+	priv->regs = dev_read_addr_index(dev, 0);
+	if (priv->regs == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
 	return 0;

-- 
2.51.0

