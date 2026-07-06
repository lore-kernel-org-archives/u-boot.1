Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2973FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 03:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1424484686;
	Mon,  6 Jul 2026 05:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fV9bYmNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5D6846F8; Mon,  6 Jul 2026 05:42:32 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D33B284105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 05:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywYU4dQOyxaBfBH7Y40cexWha6ELOkpNI52nKr4Y/Dwwev64gTMcSspFahlBgn+1yU0HnquEnTUSmYfgjHps8NLgXpQwPCY/SMWDn6zpzvQOqXDTIQ2zYHUT/hoeZNzz0cN3od9aUQcPSKBpJE/gKPu3TszakzFxFFfGaFiSL6ogT2sUx3BgesGgeYhen1Ti5nirH2K04mFsRe/ODqlUsgvzoSxIzlVffZST5uRTq1/KH1QFJDYFWo1x+8OO7mjfWXMYqV6Szne6jdU5q5Wk6rylJfgfCOJsZdKCTWD9Q0+mPl7kL0wF6e9z+olfSonk0+n0HmCEWKLjRpI7p3xlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qDnIXGB9Lj6UtM46J1fhb3MoQRc5wxL616CgpIjQs=;
 b=FEonrIb1iP76OJ/w6lfFgjcr8vaFoVWN5Ge6nJNQPXP8HoKtFarSvPdOYOzGxH+rYtq2HfirnHJ91x+TSGvAvCsq7a7sEW2PVuaAI8zz2PCz0CLFDsw1aWdYjII54zK8gU2JzDnOAww7L0/E17Kbh6Gt/gGoA1ZrJH6p0Rsvtb4sfhlFwvxdWCYRSJHwvJvGfEoAJKYz6Da5a26agK1hdUhBcBpoR1qsfvB3rYma3CoybuIg1/3XqLs2JFKMUy/2cbReU+p1pmkg+j4Gd/Pq3QPJMamvz09B8SR9/4rDVFK67KhwCShq5SEgAAj03A2osbr9aAj4n8BA48mEZTnWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qDnIXGB9Lj6UtM46J1fhb3MoQRc5wxL616CgpIjQs=;
 b=fV9bYmNbP3dMQDEL/c9HiU/iHOX/vJhHTiCGs1AMp78dXAMKDky5MFSXVW4RC9Q/1shjbgHIAVXopX2OXNJe7eq/12Tl0a1OisUQOWRYocFkedkFjTnb5Hj0G0JlVcVHKSov4+pdLrhlVjOtmXie99y3oXEVq6g2R12TNe0jQSVqQwIgxiU7gXej0qgdBUokP0hvaQuCsHfLG6HPKK1hQ12WqSVtnu5Cj832KcsdQUr97k8TwThm+yiJaFXSefbcRyBoMl/sNy5rTcBDm0GwdGDGfTqhYv1hv5dOTK7XlVzq0V4FehEEgLw6u6NKXKKK5g51z8CAWEOcqUrOkQs4NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 03:42:27 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 03:42:27 +0000
Date: Mon, 6 Jul 2026 11:41:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 4/7] board: nxp: vid: introduce PMBus framework support
Message-ID: <aksj2G-G0onkMunB@nxa18884-linux-1.ap.freescale.net>
References: <20260702195619.1857591-1-vjardin@free.fr>
 <20260702201542.1861631-1-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702201542.1861631-1-vjardin@free.fr>
X-ClientProxiedBy: MA5P287CA0203.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: bff37e17-c45c-4cfb-1c0f-08dedb109938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|23010399003|376014|18002099003|22082099003|3023799007|6133799003|4143699003|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: G3Et03+LwmhClfH+klNimOHobt5ZgUFakaI1bTMleBn4byJhuOigdAWf+2tdXywbTXriFNJ+29jgfSQcBceX/t0UK/liHXxJuPqwOz7r0SnoLR8TN/zbRmkt/FrgUtQh257pAoXDOtWPtNUSS/HPtns9lEgm8EKxwHx3Jv6HpWP4XtGw+pfLNJslQjyCsVKFIxXXMywTrjQsBVrQLLZ9aaZlJkaG2O2H0Kwx1N4Q3TNhEP7pyw30k9RknERG6dHjz7/tofdDYMWA9KuQKrp+qpCkkTrcLkRAeEvm1yOwBNa8PKCJTmdnhHp9pk6oX5InR+b8RbJgOWJy7jNQowEelddv1nAsfi2xZVU4QReb0Tcs2ITz+ZjiG6qQYV+T63reW61Zns8VfP39G0htt1ut0DDt80bsz1WJ42Lq+jQuWKTZJJbvWigvwDByiB1Fwv7TWVzhLcJyNp9x49qoNitwawfETxW2vXoTpIKVU37y7Y+vdkxXLUD6qEYl3QKKBQPLONyCVV6/K71z72dhUt5bGBg2juUFbIEvIrixSjQ90AvVtFKjnFtL/jWkLrwxWAmhS/jdM4/Ku9vMvfqI5ZgYQfQKeb5xHTxq1BYJMjmyUXX79qRI4EnVsnFV7/+zN5GjGfCTJOEZMpK8LycMtRXMwgtIdMmFcD4h1bCx9y3hu4pTg5tCxnY7OXqt/1jOOwRE1Ggj+giC2lNgr1c7GvZVqJZvsWI3WihaI7emSlPGAgaMEoo9G3zH8kIpqd3bLoUd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(6133799003)(4143699003)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o+G6nlQJX6zLIJT2emfbATyMyvYRaSc4s2MmsOUIABjZXL+S+ntYdTQD0VSd?=
 =?us-ascii?Q?EdzD5IZXrSpDbZzhcKqk9DUFqKo4KmH3G70oa5JSxosNNnPZvUUU/+pxUy8z?=
 =?us-ascii?Q?kTPF3FFfmFPyw94QmePrUwW0m64FcUscPiNdb2HgHiTx0oWmkKDKDhCIQ0Vg?=
 =?us-ascii?Q?FzzwFP+6evS24gPkwijeufxjrAu96ZTl30e04A3qAMGCfajslTqmq0i+0bbM?=
 =?us-ascii?Q?6aurfawRk/ef7S7ou1u7XttbRCN9r5Z0vHbnZlCVxXOhtNaLgJugvfYkJOnY?=
 =?us-ascii?Q?UYCKBA/i6DCWT8SWClO4F4fybvw8l3D2jsY4plimnMKSFqEujARyEOZBmDpo?=
 =?us-ascii?Q?4GVyNmE2TIJAzaqsD3rtAlE//mxlkd1j9nGEaCpcVMBbpOfuKuf7Tyj6HsMR?=
 =?us-ascii?Q?8L83NsEqQGf2rwxsbjmx9jDLp6VFo/S/BpFmn1eXTU8P+5cgJiGtd9ZMivak?=
 =?us-ascii?Q?ULG1mjoJ8LArKLIWgpFXPjaTuBw/lTbWJTxJIDGR3KqXgSsmHzMzltvTs+G/?=
 =?us-ascii?Q?MNlS7zQQlua//HJvLWkIIU9q8rVSfQX8IKKkPVs96KQKOS8echZ/1TUmYIbQ?=
 =?us-ascii?Q?AaHXAonqjMdesUQ67/cztHYZroRFz4KfEWXxip6q8Rqk91g6QuY7pGiYg015?=
 =?us-ascii?Q?NUGeWitkCopzSQTrk4lrIK0ckuhqs+aXFUiBFWEmH+d0rkwtKgFztk9t+Oqc?=
 =?us-ascii?Q?V57VVj+zwt/wj66DMgQV7APfx4+GDTUbADd0ef42JUy/bBA/N6n0hUKlpS/5?=
 =?us-ascii?Q?nSfQLWKvDVEwo+Sov5lSpJ2S/uUKC/lRhF1g7eWffYmrE7VyJhX2oBHBsTGl?=
 =?us-ascii?Q?18Y5A0ejLzruQuC4yf6APEUnOp7798PEriMEfrpZYTMC+/aEOyWupACR5kDI?=
 =?us-ascii?Q?lw5grKt/gwcRHA6JKFofzeg+6mmfB4vVr9LIf0QmHZ9R62hcJSK8ODDoXDAz?=
 =?us-ascii?Q?OL9p9vUyevMlujvmotjgT+vqs2ar0LounyjyaV6D2MUkmgakzNeel6q7QZpL?=
 =?us-ascii?Q?T4uVfZ9w9GcirL1kwI42nlcotPZ8Lrz05pjKm8/35EVPfYiTabfBovmWSYFt?=
 =?us-ascii?Q?NN0CB+EiM+OZozXb6N3LopKFt5ETDxMYi3LaKcPapqyANIeyyX/WvvuOmDzX?=
 =?us-ascii?Q?ZRLINURU1m1uEostfXFmVzDYPjU87p4U84yqs2v3HJDGVfMidH9iPGlL73O4?=
 =?us-ascii?Q?8nnZEIJiA0aCHx1Q8fJiqljQiZZ0rgN8d1SJqsrVdaj5ub5TgH/GkLn7L44k?=
 =?us-ascii?Q?p5D0FQo4Phq/kGpZjctnV6idskqm1U/TwhKzL+Grf7lIxvaWhhwYcNS4abSY?=
 =?us-ascii?Q?0D1jJp3wXrhgdGicYb7sCBC+X4BZq5utq3/WB6sv7j84ajGMnFdGI5M9qaY2?=
 =?us-ascii?Q?mDomHgAaHsabdXyyvV4IjsUvMLZXlhiaL05Q/hAbiMDQDTKWwW8se76E23YI?=
 =?us-ascii?Q?PY8CVzE5mc9X6KfBia+rY7LLOQhvss32oU9rqdx2hjYj/ZEhZjkVOI8NUm7P?=
 =?us-ascii?Q?VWtQ5Ng98oWqVnnTWQZ88HjrShRsr2ZhnvVyiq2X+VeMcoMVdBLJv+SgvM/g?=
 =?us-ascii?Q?LhjeRE66VE8fhGiv2HHMo/0iK31K39oaHFhuz8u7Xbwcrs8Y/8kZbY7oKzeU?=
 =?us-ascii?Q?UskVZ3xw7M1XpWnwb6r7JHoLTBe81M+Czq9cBOIlBVbxHpFMeBfwJf4XeKU9?=
 =?us-ascii?Q?9+WEbcL13QFgeqD9GmK23FlbYEHGl0lwTf3c+QDEF7p9wLqTp+CfUtQyDfnr?=
 =?us-ascii?Q?yQq9RQnL/Lno3k6HqUHurq+o4w9TazNAhcmffr+GFcqRjMTzYi9j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff37e17-c45c-4cfb-1c0f-08dedb109938
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 03:42:27.3863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrAFknmWKDGj6buXUPWR8vjP4wkXqhu9SHRGYbNTZw7hfeRWrtG2PrISQavOU1a6OeFy0CUZ/99uIt2p09QYo/KzSAzFzg1S57GeiQfHlI2CpK/nV8z07u4UeM7qCXgZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
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

On Thu, Jul 02, 2026 at 10:15:42PM +0200, Vincent Jardin wrote:
>Wire board/nxp/common/vid.c into the <pmbus.h> framework so the legacy
>NXP AVS path stops carrying its own duplicate copy of the PMBus
>protocol and instead consumes the shared constants, decoders, and
>transport helpers.
>
>vid.c is the legacy NXP AVS/pre-kernel voltage-trim path for lx2160 CPUs.
>It does PMBus to whichever core-rail voltage monitor the board carries:
>LTC3882 or ISL68233 are selected with
>CONFIG_VOL_MONITOR_LTC3882_*/CONFIG_VOL_MONITOR_ISL68233_*.
>
>Before this change the file kept its own local PMBUS_CMD_* command-code
>defines, its own inline LINEAR16 mantissa/exponent math, and called
>into I2C through the I2C_READ/I2C_WRITE NXP wrappers in
>board/nxp/common/i2c_common.{c,h} which is a parallel implementation of
>exactly what <pmbus.h> + lib/pmbus.c provides.
>
>The intent is to make vid.c an consumer of the new PMBus.
>
>Compatibility with the former support:
>
>  - CLI unchanged: vdd_override and vdd_read keep their existing
>    semantics, return codes, and diagnostic output.
>
>  - I2C transport unchanged on the wire: the framework's pmbus_*
>    helpers call dm_i2c_read/dm_i2c_write: the same DM I2C
>    backing that vid.c's former I2C_READ/I2C_WRITE macros already
>    routed through on DM_I2C.
>
>  - Numeric decode is bit-equivalent: pmbus_reg2data_linear16() and
>    pmbus_data2reg_linear16() implement the PMBus 1.3 Part II
>    mantissa/exponent.
>
>Signed-off-by: Vincent Jardin <vjardin@free.fr>
>---
>
>(no changes since v1)
>
> arch/Kconfig.nxp       |   4 ++
> board/nxp/common/vid.c | 104 ++++++++++++++++++++++-------------------
> board/nxp/common/vid.h |  15 +++---
> 3 files changed, 68 insertions(+), 55 deletions(-)
>
>diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
>index ef9087d0197..152692e3230 100644
>--- a/arch/Kconfig.nxp
>+++ b/arch/Kconfig.nxp
>@@ -242,24 +242,28 @@ config VOL_MONITOR_IR36021_SET
> 
> config VOL_MONITOR_LTC3882_READ
> 	bool "Enable the LTC3882 voltage monitor read"
>+	select PMBUS
> 	help
> 	 This option enables LTC3882 voltage monitor read
> 	 functionality. It is used by the common VID driver.
> 
> config VOL_MONITOR_LTC3882_SET
> 	bool "Enable the LTC3882 voltage monitor set"
>+	select PMBUS
> 	help
> 	 This option enables LTC3882 voltage monitor set
> 	 functionality. It is used by the common VID driver.
> 
> config VOL_MONITOR_ISL68233_READ
> 	bool "Enable the ISL68233 voltage monitor read"
>+	select PMBUS
> 	help
> 	 This option enables ISL68233 voltage monitor read
> 	 functionality. It is used by the common VID driver.
> 
> config VOL_MONITOR_ISL68233_SET
> 	bool "Enable the ISL68233 voltage monitor set"
>+	select PMBUS
> 	help
> 	 This option enables ISL68233 voltage monitor set
> 	 functionality. It is used by the common VID driver.
>diff --git a/board/nxp/common/vid.c b/board/nxp/common/vid.c
>index 84cb43fad56..a91d6c9381a 100644
>--- a/board/nxp/common/vid.c
>+++ b/board/nxp/common/vid.c
>@@ -11,6 +11,7 @@
> #include <i2c.h>
> #include <irq_func.h>
> #include <log.h>
>+#include <pmbus.h>
> #include <vsprintf.h>
> #include <asm/io.h>
> #ifdef CONFIG_FSL_LSCH2
>@@ -260,45 +261,38 @@ static int read_voltage_from_IR(int i2caddress)
>  */
> #define VOUT_WARNING "VID: VOUT_MODE exponent has resolution worse than 1 V!\n"
> 
>-/* Checks the PMBus voltage monitor for the format used for voltage values */
>-static int get_pmbus_multiplier(DEVICE_HANDLE_T dev)
>+/*
>+ * Read VOUT_MODE for downstream LINEAR16 decode/encode through the
>+ * tree level <pmbus.h> helpers (pmbus_reg2data_linear16,
>+ * pmbus_data2reg_linear16). Returns the raw VOUT_MODE byte on
>+ * success, or 0 on bus error. Emits VOUT_WARNING on Linear mode
>+ * chips with a non negative exponent (resolution >= 1 V is unusable
>+ * for sub volt SoC rails) and an informational note on the
>+ * unsupported VID format.
>+ */
>+static u8 vid_read_vout_mode(DEVICE_HANDLE_T dev)
> {
>-	u8 mode;
>-	int exponent, multiplier, ret;
>+	u8 mode = 0;
>+	int ret;
> 
>-	ret = I2C_READ(dev, PMBUS_CMD_VOUT_MODE, &mode, sizeof(mode));
>+	ret = pmbus_read_byte(dev, PMBUS_VOUT_MODE, &mode);
> 	if (ret) {
> 		printf("VID: unable to determine voltage multiplier\n");
>-		return 1;
>+		return 0;
> 	}
> 
...
>+	/*
>+	 * Decode LINEAR16 via the tree level helper from <pmbus.h>. For
>+	 * non Linear VOUT_MODE settings the helper returns 0; fall back
>+	 * to the historic mV pass through so existing LSCH boards keep.
>+	 */
>+	vout_mode = vid_read_vout_mode(dev);
>+	if ((vout_mode & PB_VOUT_MODE_MODE_MASK) == PB_VOUT_MODE_LINEAR) {
>+		s64 uv = pmbus_reg2data_linear16(vcode, vout_mode);
>+
>+		vout = (int)((uv + 500) / 1000);	/* round to mV */
>+	} else {
>+		vout = (int)vcode;
>+	}
> 	return vout - board_vdd_drop_compensation();

When vid_read_vout_mode() returns 0, the return value here seems
not correct.

> }

Regards,
Peng
