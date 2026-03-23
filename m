Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC34D58CBB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 02:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A9783DB6;
	Mon, 23 Mar 2026 03:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="a+kuJRWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C90283FEC; Mon, 23 Mar 2026 03:26:12 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4086B83AC5
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 03:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnlEzCgb24wrHtXbcXMeeX4hg/rqDKdJEKTyHbZ/ZRO9BKHmnj5oDN9/aavMGbFCqrZHlXXKUUWuIK2p4tKWzAVjLtzzSlboI5xxUQ3GCbU+Uj/PU4hQcXfEt2mWMQMzVB8GluB5V0I3ggwUcnAbSdcgOYkIqAQ3izK6a4o24lls70YtYXOGTSmGC2q2uQCp87P6CyXi6h3UzptnfoDCm5sWFEWTsUNTmnRfioPYn42pKIQRohi4QOjGFz01TwK4EdMaRNTz7ZiEjK+MHB4gO5fHSAI5C2tRuNdK4so5epYFS/KkcjhHfE84/XnnGu3qL6hxepiWdEVWNFMSDCsAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWY8BF6Y/02769wV6mOaUw0igxtwTL/AHaGguHKDGE0=;
 b=S2JBePasaGKCATApfvlCRI2E8kbFaS3G/qQ6FzI7wHUSbJ6uuW5xNB1sT/wa+Sb3ZwfKd1uHxMRz8bQEQyXeSGZy5rq8xfb+VDQqZAa8OF1OS1ZBEDD1zdg5nz9yTgZOz/dYQNJJ2tlNUtuUXJeV1YiJMk2nmWzXq3l8lLCS7jEVoj+MSsZiAmYNsVBwFZZT7onhT89fKubLCeNrswINZ9NTuLGqYfgQChYLgbpdwwCatN05w4NEVBeAFfXqFze1RcOMdI3svs6tohAMWOsGA52UBQCzURLQ+A/Q0RSIIAZ/rCEd6b1D+4K+5HwFJRPw65rZj3zJ965Oqdx5IIu/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWY8BF6Y/02769wV6mOaUw0igxtwTL/AHaGguHKDGE0=;
 b=a+kuJRWg1ljTcOXDESnULnZ3ASZwOID30ngAOTR70/mAIML12xix5UuficVcpsLBzyG0A/ohmOLCTA1mFagwcilzHDDODWUtSky9YA+fjp+xVV+RszmQe/mfY1cTtN01uRXYpE24CRPr581CH4/ybeWW0eOyqQrJoUacWxaS6L7w5PYwni7maUAOQFq0jLko4RKrTcU0RH8Pe+SWU0ueN2gwcKAkYMbTHXWHCSQnJPVa3CQOwyS4DbwGVKzxY4VR29B55YxMulhj1hWesEouW6CF805KPeLbXYQozMS5pxSEr3MQjrbvlyeMdtd6119JLgqEOV644o+UKAumSDxuFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB12299.eurprd04.prod.outlook.com (2603:10a6:10:62b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Mon, 23 Mar
 2026 02:26:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 02:25:49 +0000
Date: Mon, 23 Mar 2026 11:41:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.denx.de, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <acC2fSdjDmj5Wp1a@nxa18884-linux.ap.freescale.net>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
X-ClientProxiedBy: MA5P287CA0279.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bc0132-ee30-4add-c09d-08de88837e88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kf+Uufo7Y6lbHg97pNZHCIKC34S2qDFnruw04K6nOQfaG/xBwvjI6HwMAU3RLViGOu6W58codRpHExDZSp7WO8F70kESAXGFqxa4GyNdib/e0FwRUSSR2dlJR8Axau9TO2JcdoZKhCI4B6DiVUf4senl2C2RtCRqDOfxMLxlmU1ls2I36lVGL0VizHqdkI/gHnmZ2y4TdkL8TWr+Gbv09u4O3/tar+kuN12CgwBjWcpkEwsm7/UKuAM6lrnlfz/HNAKCrXlENFmICM0ZHhTE67myfrtbH90R0IMvjkPC6nu3cr2gPbDbOQ7kPuxLcV+jmceRVPus0uEr8GdK3JjW8XMhgwkLhJdFK6J+JMBoshAFCa6WjrHp4TqeBr67+lkHI+GfKtSgtkP7LZTjgVItT5gT3k52qxms1WQgi5El1MWLlCuhjxKb3sn+rCrMEm2vAFpeUWruUbpOWoAW4f1d1qrIWKI91/bbHoCLMTT5sZ1YTzGc7dxXGk/48LeLqZPNo2Jbi+qdXSXYi3fpin6H6a/N6C9jDZxvFTDyCnJVAQe9NsO3q40Vzin1CJMP4wtQITwWnPkUo/WQBbLRIFKseEGQUffhYpuWl+odwJ/znZ41UaEEO9ltuSGQdufe8eFiw5jtagF8dLOeW1uBkYY157yoziLAuRElNxaa4oX6VWlefsn9vcqptIzUW2D+tgTKSabFfI6YzWdKua9anmthWArWIsj9N7XVHgclpTbC1rk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFQI2+6FHQMLtm4Q5QaM59wO9U8GVcG4xv1jVo3SARsmyAtb3Twl0AN6g+GD?=
 =?us-ascii?Q?OyUAFOzkbMSJDZ6jr+JQTMuqJtxrpdKENlXAtJdM1O9d3yLyqc6ZvZHTnLZE?=
 =?us-ascii?Q?ks0MCWYsxBP4nVVOl+rA1j+sVPWTnrFJfeyWh8G5+djnb5+X4o+yoIBUOw9L?=
 =?us-ascii?Q?TwBm1LKL12j683ahxgsju3qyJB85Az3yjbUYpEMWs8vBwEmJaETral9R8Z3L?=
 =?us-ascii?Q?0XQUH68QIUEwBdndRrt/KIEU8ivrSK5Xxt0V+BDTmOhrS8gt6FUC04bEoFMt?=
 =?us-ascii?Q?geBulnJWriTQty/v7h8NRLPG7j3Amf9lWGVUftxYFCoBEt1t0Dm7M/04xnid?=
 =?us-ascii?Q?6WocKtZeRUWcZ1/qKS7Mn2o3gFi0DT/iDM2iLnaH0Cfl1cpluI/7wE0HGOe2?=
 =?us-ascii?Q?d0T5CaPz5C+1pMlYo65rUw90vtRMBPq2B84bUTSVIj7Ih3KzEpJE6wxQ9fZx?=
 =?us-ascii?Q?p7lV+ENdxZt04ES6VeB2wmwEeq4grcp7Ez/x/d+PY45OddSFXy2jxGT0CrZI?=
 =?us-ascii?Q?3XHVGYhkKrx35Bv1mKzjhYxqDHHVvvJWA+gIhO34UOnCYOnx3DJ2L5v8SIzA?=
 =?us-ascii?Q?0xaBh1fTlIj4IFuQQeeRTdFVX3DclXaU41J5obJzKkSIm0QY9qqRovA0ioYN?=
 =?us-ascii?Q?khEypRRR2n+jGQg3Vo3jJ+HEnRlK0RtBYYA3sR2A3bl8R4uGVzF6IMV2fnBj?=
 =?us-ascii?Q?dy+oTYa7y+O+C+Doh5DWIRWrb1z3+eH/+UwYWNU0X2e7ZvAKslid4gVg11hI?=
 =?us-ascii?Q?Nv75fJ51+brpoBzCIItHtoJJVMgJNOOKjnTX1qEqi7FBHGEC8xOUP51Rl9mh?=
 =?us-ascii?Q?AcDAO9UQ4w7g6IZa5pKnjLj2akRZjdeNCgFVXF5yhN3GcGODOxTqVnpNtkzo?=
 =?us-ascii?Q?QObWlk0btswKBTRhUhxgWq6tOjQMQXOiq0/7n8n4KEg80DdHF+dXWL0WWJo9?=
 =?us-ascii?Q?O+JS0lI1sfJ+A9tMaL1h0ZPf/2d7YcUt5XcigaaNrHTw4O2WkZ/J9JuxbJ8w?=
 =?us-ascii?Q?QsSiadsqQ76lKuwgyRFDMMv4S2AtG/5dUYEe9aoeqMN/y0ndTplwNSY3rb/R?=
 =?us-ascii?Q?knqXfglX+aKy6tYdCINVXER/2P67g8M3e1gVqO7valmNF4K7JogdXENTQfZh?=
 =?us-ascii?Q?IX/LRZwZZYY9kABSL4zUilYbcraJWIOqKmjXNi5/XEEuU4p6pKwszML+uYe9?=
 =?us-ascii?Q?2Mm3+QjUlEP3rmlqcnYequWWGwC3W6PbbetoMuNaryiOBBaXhWghbN3NqrmK?=
 =?us-ascii?Q?39FOdxUvTRFxUND4oA3j7B/z3EeYmU5PkJ1WulqDoesJ4GLRZaGUrfLs8lKB?=
 =?us-ascii?Q?OiWgs4Cl9QD1TNf+Rv3zczEv62IiLQphXC7LJsc84Xl402srtODSwyqrl4LH?=
 =?us-ascii?Q?42O76OfjIjqvKBpzS68CbL3jmvYQuWqiQWDV8NNXzLdpbY1aBHCPRes13Aaj?=
 =?us-ascii?Q?vBZ0f7j/dZVOtcXqFSvR+1pFKtYblUasZ+Dc7gJoIHZr+zWK5Hk1LB/i5Ocb?=
 =?us-ascii?Q?Gqn/vmHxcVZIENw5F6yN3KclGugzSHldQ+lnqnUPd7ygZ6YCk6KROBxmqPow?=
 =?us-ascii?Q?vDkbdDt/tk3bY61Cv0eW8OpIAPzqM/HDcJIoP2vU4E0mq3FNoF257Xr7lb4b?=
 =?us-ascii?Q?lzywvRw6HWhG/yh2LNZbGCnqkeecd1df3AZlZpxX43MTaoYIFAzsOpCiQzAN?=
 =?us-ascii?Q?qVrwqWr351g/pmzCx58661chQLONAhqVZh4kVzUaU4XryzRjMhM52N+INnq0?=
 =?us-ascii?Q?WEv3QQTLaQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bc0132-ee30-4add-c09d-08de88837e88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:25:49.1880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaQLbHCxJdsGd3ExRyIaOF1fKSqsJ0LLu2MJb7fhDq/IRMHx6Ng7yk6RY3XuTe4NHPEITeoIVN0qDCNNgWb96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12299
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

Hi Dan,

On Wed, Mar 11, 2026 at 10:41:36PM +0300, Dan Carpenter wrote:
>This provides GPIO support over SCMI.  It is built on top of the
>pinctrl-scmi driver.  The device tree entry would work the same as
>in linux.  Perhaps something like this.
>+

[....]

>+	ret = snprintf(NULL, 0, "gpio_scmi%d_", bank_cnt);
>+	uc_priv->bank_name = devm_kzalloc(dev, ret + 1, GFP_KERNEL);
>+	if (!uc_priv->bank_name)
>+		return -ENOMEM;
>+	snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);

build fail in CI [1]:

drivers/gpio/gpio_scmi.c: In function 'scmi_gpio_probe':
drivers/gpio/gpio_scmi.c:227:25: error: passing argument 1 of 'snprintf' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  227 |         snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
      |                  ~~~~~~~^~~~~~~~~~~
In file included from include/log.h:12,
                 from include/linux/printk.h:4,
                 from include/linux/kernel.h:5,
                 from include/linux/libfdt_env.h:13,
                 from include/linux/libfdt.h:6,
                 from include/fdtdec.h:17,
                 from include/dm/ofnode.h:11,
                 from include/asm-generic/gpio.h:10,
                 from ./arch/sandbox/include/asm/gpio.h:24,
                 from drivers/gpio/gpio_scmi.c:6:
include/stdio.h:60:20: note: expected 'char *' but argument is of type 'const char *'
   60 | int snprintf(char *buf, size_t size, const char *fmt, ...)
      |              ~~~~~~^~~
  CC      drivers/net/phy/broadcom.o

[1] https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/jobs/1408382

Thanks,
Peng

>+	bank_cnt++;
>+
>+	uc_priv->gpio_count = priv->num_pins;
>+
>+	return 0;
>+}
>+
>+static const struct udevice_id scmi_gpio_match[] = {
>+	{ .compatible = "scmi-pinctrl-gpio" },
>+	{ }
>+};
>+
>+U_BOOT_DRIVER(scmi_pinctrl_gpio) = {
>+	.name	= "scmi_pinctrl_gpio",
>+	.id	= UCLASS_GPIO,
>+	.of_match = scmi_gpio_match,
>+	.probe	= scmi_gpio_probe,
>+	.priv_auto = sizeof(struct scmi_gpio_priv),
>+	.ops	= &scmi_gpio_ops,
>+};
>+
>-- 
>2.51.0
>
>
