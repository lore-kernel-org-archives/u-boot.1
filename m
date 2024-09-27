Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC87CEBF7D
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E3C89027;
	Fri, 27 Sep 2024 09:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cuEEQ5Xr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFD798909F; Fri, 27 Sep 2024 09:20:11 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19DC88ECD
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbIbh9nuZEBZ8YquX6oWnG98xM9urm5mdgyg3YdvoJvvxW0rQnvfHNwcYCr5FWJB75WaD0E8eiQ3PDH9EBwbeBPRkFDP4adZj5XOulzX+3dVk3WNrqYqEloyPT9cjJooGw+B20ZYgH/kUdEaE53Q1GLXrnqyCcWWu8TAupsbAYfJbrXvttzrSZkCMWksixUtSjKP2Ms7zR7+C6aSWeS+prPHDRb2/HdFAaxwkm/dhOxPuFnLm7tzlLFFgrDwMUjh3ShuR1AicrFuaHhfADOYleyflU9CXCIRwH1oqwq7OZi55YM6SYIfQvJbN/TpiWtS1joZaPm7c+JWQ4WxvQxHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NhPYwHA0fn275SzkifDBkndMYT0p0+5gwUm+VZX3EQ=;
 b=FSY7ScbapKc0w11/ybCKSxTPtJUwZ8nT6Ty2l9uChUqs693I67yj6qXNy/luz73H8n+Evp6WTE5IVyP9HuNynmBg2urspY5ddBSNwlVZ4j11F9U7a2ThDv0Oqgg/sJILHWx+1bHdhLHB75J0mxhZZrfu/+X5gdyw0kWcF+xTqv2SdRWgwM6uaHsi7F7MVsVN/WD8QZLwW4/cugpiyApWRMyOCbsBtVsYAyBPX1/zUx/d9SDzpKVufWBeiKzNYHk/GOs3FgWgrNcK5SlEiFSHIeUOfBVUiROZtY1S/PbiYcJ2WOLRSIucBO/RKTt+pSdm7ds2Y3Q8hhpLdU0RtkcUeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NhPYwHA0fn275SzkifDBkndMYT0p0+5gwUm+VZX3EQ=;
 b=cuEEQ5XrCPY1msFd0YKVXG4Cpl2DE3HVmIvr3wCa535l7KGQ/RdktXSBL3S7eWiPelhpgf1rBHZ/pyPlwOr277lS68prSwFdTCZ9Zw8QnPWjyIC797cnKkL/caCDeQkc6Xq18uRjoamQ458acK+YHMEttV0URV/g65XCi9Z4x01F+YhswJbm6BEr0Wpohiu1SJDgCU2Tl4SrQ0hFSfUtH+iw/8oqyKOBeb2ofcXDqdjByRf/PKi1Ke11pCjVnXG2nqnMsGEbgWSovMDoRH71jHukG4XIuJYOdyXCu4we/KtO5Uy2VThlkccL2kC9EIPLRTME2ia688QTSGUG0zAdSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10937.eurprd04.prod.outlook.com (2603:10a6:102:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Fri, 27 Sep
 2024 07:20:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 07:20:07 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, clamor95@gmail.com,
 paul.barker.ct@bp.renesas.com, michal.simek@amd.com,
 andre.przywara@arm.com, ye.li@nxp.com, jim.t90615@gmail.com,
 billy_tsai@aspeedtech.com, kabel@kernel.org, caleb.connolly@linaro.org,
 biju.das.jz@bp.renesas.com, sr@denx.de, piotr.wojtaszczyk@timesys.com,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1] gpio: adp5585: Add SPL config for ADP5585 driver
Date: Fri, 27 Sep 2024 15:18:44 +0800
Message-Id: <20240927071844.2738740-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b632b7b-a2a4-446d-103c-08dcdec4d086
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+O3p2UpFgdorZ2GXqbqt+4tX9CnioeKr4wqCjrsAJF2+/fJ3XUURbQvd3KJ?=
 =?us-ascii?Q?GWFZ5H9quCpZ/W/uqVeGP5aXacu0eSsezteZ5fXYNV+3TfEsiMW5KZdNl7U6?=
 =?us-ascii?Q?ImTDTppFR8Xqe5s3hZHG0AdWDY5qZAMTHOa8013HUQNt6fHDMTISp/t70AJW?=
 =?us-ascii?Q?0gAQx23WxNA7vA3pAC7olQgaozXsktqxPesmzrrX5j3RKBeEicUNnwOc5dR2?=
 =?us-ascii?Q?pzYc7QQb5283mtNg4bJfeqfEnrTQp4TuTBmoCSvE2wzbn4t6BDT8fqMYZNb4?=
 =?us-ascii?Q?DEojJgcXp3nRQncf+HrQE7RISMwh0IQxTP9i8abfq8cnVFvNdGOgHrirRB2k?=
 =?us-ascii?Q?AAwI224G7aM8zgE+DYvknVTqCX1bR+yK/C2H22aUw2KuG1hayALEUWoHuJqD?=
 =?us-ascii?Q?IqD0hOBptpcfqXJnwpCtAipWAbE+IPLQDdfm1wRU2MUhEtUA15cVyXm68FfL?=
 =?us-ascii?Q?kEUwxQT0Y4KgorXOfGkaK92Jhr50Fi1K2YqRask+HoekG2EQVKZiG9dyOd5d?=
 =?us-ascii?Q?TbkO22akS+nYrM9GKGxbHr/3HeCPhkWjOdNtb/KuwvX6856a/xL0vlNmnjJK?=
 =?us-ascii?Q?9YBYVhuXbjiZsFwMjM7HGSgqz82KtA1/1n0LNRNBVYmqVT7L8TbO+vJg/wpj?=
 =?us-ascii?Q?YGRJjVnd0l/YFd5Scu4LPUX3DguOIaBpf242S9+j4dmzp/zEB/yMbq8RA1P8?=
 =?us-ascii?Q?fGUeN2Xx/ymmUbsSC9Mfi+9sasNB5pUsT9RTYN4tsCK9Khzbyjk+mLVcuf54?=
 =?us-ascii?Q?R6v8SNL74G9ydIg+pEuy84mObhwM+rgmhJcYbyaFNOZhTwlyWB6NCSAGuQ4V?=
 =?us-ascii?Q?O2Jp+goeYVMH+28sQmKk1AZaxcl5CqRhFhB0hMi/oRAsXUtQfg9AdM2uRtOp?=
 =?us-ascii?Q?TxeGIu0tYI5aFxC9XF6WsjBxfMJQlDsjLcf4D5xxjtVCgDXRHbemMsWaJGuj?=
 =?us-ascii?Q?i+wefgGBrZ0YfuF8p2pUHXhptX17eFid458edeStQYkmi+Rr9aZLG23A8Ipg?=
 =?us-ascii?Q?k7XWZzmfp4TBCL0f92oHKs+0XjWEjxcT88fEbQDYSZQRg9zPWzamO8dUEWPg?=
 =?us-ascii?Q?zTTskUBo+jm/ELEBpHO9WbMo6wCZ/aVPYyFf7MNiwsLXtgEqK4RfzW6ZAA3G?=
 =?us-ascii?Q?sJaeNrXqEnFCYq/YPtqzBCX4XWo8EUMLtow7xwMROhj5zaSqXVKCtj55S2px?=
 =?us-ascii?Q?JveSDL7bYiq0YfPa2GixO4HQPDHUEHGjGbwjRzMcYvT05t2JNH3PwMGk7HLt?=
 =?us-ascii?Q?nDxIkZmoDjC5BQ04oui+OIb0Nymyj7fwPih3MP7uU2hJOGmK6V5XzA1OuLRL?=
 =?us-ascii?Q?x149Eqx1f5QAKrEFqI4cx454yZf1gZVGQCg2JB33Lq4Hag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbGN7vxCEqnTZCVM+fhYj3yFB/+nnAh8l4Kj5e+55QFNOpLRh9Qfm4mRas8v?=
 =?us-ascii?Q?QFVMO3mu88h1jMkeFiK2dvSh7pVz1he7UEJmvKGMmfIwXfTBFjN+hPlDvFC3?=
 =?us-ascii?Q?uzLtdW/D6l8O+Wj5wGadUsTN/rw7xFdF6E9KicSy9SyM5bEzFg/eJidXq7C3?=
 =?us-ascii?Q?5/Ty22Iexnb0ktCIfcL/a8EGVaNU3a/7+4C5OADzH+9ehfJMo62m6msjt7p2?=
 =?us-ascii?Q?kXJRuAXlQvBK9qeGBmT34KU6zl5OVhQzWolLFwvpEovN+hhhkrppOVYcExCt?=
 =?us-ascii?Q?qWcbtEr55k7893g5aTNajxrZFTc8lYfOPIUVAQ8VWxILIcEZ7xhSYjz8RwWT?=
 =?us-ascii?Q?bZXl1LO/409ci4B8jGJSne4qTis+UoHVgM3VwDX3BA7s/O5631lbntGcvO1f?=
 =?us-ascii?Q?klRLp3LMaDAHWc0nvuAuzuJlaIpRlLtQxLwnsMAJDmT46MVmvabCzCLrfd/E?=
 =?us-ascii?Q?bHGtvw5A3V6A1jvSc7imh7Sd4ZYhdPor7IjeL5ZAcH1bPZZjScyI5yr7kqd2?=
 =?us-ascii?Q?Q16wGE0moIRkNhuaXU00MJkwkByHCyXuh0HMRs78Qjir79TIeEtRfgFVjmjL?=
 =?us-ascii?Q?nUmlhw2oaxwl28xR7lvnuu9dxH9ozuacVCOvEosyOBRkmJq3+aOUEtwD+1R7?=
 =?us-ascii?Q?yLm8EDaOLmYj3MhQ1ZFgsWFBxlro5c8zUPtvp/VQ2ZAhDM8QMmG5Z0Wy/ua6?=
 =?us-ascii?Q?Q+8JuyEXgwzUqdyCmY6/uNaV+55IGFi5mr/qYPQYylK/cF5v0Tz3npjuISrp?=
 =?us-ascii?Q?dFNGm6+GHYESBBdZYqDVHAGRg6FgJs0R+t5IaWG600RxBr8D31ovtJ83yil4?=
 =?us-ascii?Q?erXTLkgYKbJSkWQWCq2pu4kUiZDJatCE28gEd3Ia9z0aN76B4+eIPl3mE4bX?=
 =?us-ascii?Q?Yg+th8toTA7hIgYhUAzjdW9sK96V6iZQWVV8kliKWoGDX8T8JJpoLPmAXsck?=
 =?us-ascii?Q?pgPi8zLJk+4l7KKNHo9saF6hRg0d4xCcRPuxGU06kn4vd+MZmzZIIWb6wWpa?=
 =?us-ascii?Q?/rBdR9uI3sCxftdH+O7bLzbqju7UNk7krlByEoWs9gR28nMaAsJUznQUAUhO?=
 =?us-ascii?Q?RaL4sK62rs9BfvC3426uO48WAepDzv286uePtFxJCkmoJPcwBNJPDRJFyUGq?=
 =?us-ascii?Q?6Pdoo6ojL2ELl2HK6XBPP4YV8/lYVR0lazmsynyyup8Ml5sugWNFLkeveAWA?=
 =?us-ascii?Q?ur3r6YrJh2oczSoKkDhFdsL2S1k9ePcSMDwehWoTpX2t09D1ECeOoNxurM8v?=
 =?us-ascii?Q?NyTtzSkXj7ku0Xxz9X0ILzvsH1iR+YSSi55zwFbCuv6B9oulK2YgHh3j+X6m?=
 =?us-ascii?Q?+NjeDrRYfyvYNB/yp1g45OJxmPKBJy40sZbpIEBGZmPB6tNq+zrSSsiwgYRW?=
 =?us-ascii?Q?8Z625SOvRSL4RhfyJSA9flg1f6oNtDRnLEYHPzY9T51es4TlHau+ORhi8+/o?=
 =?us-ascii?Q?C14qtCJ6DhoCRDT2GXwxoyINiI89VCvLvPSFTizDaARupMS0XtPHfYb+8YbF?=
 =?us-ascii?Q?9bMjetOEf4+K/92We1NYQ0lOf+rec2e4JFHFwtRhXgNhqnpLbuJpO5Zae3Xs?=
 =?us-ascii?Q?dwlDFtB7lrSB7xLJdb3D2d0K+DR8zhOfomKbcOs/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b632b7b-a2a4-446d-103c-08dcdec4d086
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:20:07.7605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OrJiRhUC0dkOLWdsunbuC+OY6MxG7Dru4i92JZk2O3oXRMiVAoYkgXX2VmAFq1pbX/S/IcHJfWF4NfdrT+b5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10937
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

From: Ye Li <ye.li@nxp.com>

So we can disable to build ADP5585 in SPL to save size

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/Kconfig  | 6 ++++++
 drivers/gpio/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3996333fe8..1e5711663e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -700,4 +700,10 @@ config RZG2L_GPIO
 	  Support the gpio functionality of the pin function controller (PFC)
 	  on the Renesas RZ/G2L SoC family.
 
+config SPL_ADP5585_GPIO
+	bool "ADP5585 GPIO driver in SPL"
+	depends on SPL_DM_GPIO && SPL_I2C
+	help
+	  Support ADP5585 GPIO expander in SPL.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index da0faf0524..56c20e4c63 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -76,5 +76,5 @@ obj-$(CONFIG_SL28CPLD_GPIO)	+= sl28cpld-gpio.o
 obj-$(CONFIG_ZYNQMP_GPIO_MODEPIN)	+= zynqmp_gpio_modepin.o
 obj-$(CONFIG_SLG7XL45106_I2C_GPO)	+= gpio_slg7xl45106.o
 obj-$(CONFIG_FTGPIO010)		+= ftgpio010.o
-obj-$(CONFIG_ADP5585_GPIO)	+= adp5585_gpio.o
+obj-$(CONFIG_$(SPL_)ADP5585_GPIO)	+= adp5585_gpio.o
 obj-$(CONFIG_RZG2L_GPIO)	+= rzg2l-gpio.o
-- 
2.34.1

