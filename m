Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81738C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6EF880DD;
	Thu, 28 Mar 2024 00:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BPhtipCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2113687D2E; Thu, 28 Mar 2024 00:53:26 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DA688073
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db0RZQbKNbMjDEkRHRQtTKlpUGJj9aNmdxVCdwRVW9IMJqYbZ4GJrSt0rw/mXug2LDp4h6oUZ68syQrLwqVxllk3Od4ebnBznTkZakmsx83dyuH3Yf3QRhbepu8kmCb1963Pp8C3P1caF0B2446Wcept6DxLCKasi9J2FEV+aYtwhpuOc2VmvXzag2jTmJoqeDCmc01IUPmwBwc66C2zPCHvgTfKoLLd+vDXETmkb42gYFF2qtVSBgQZU0Nq7NI3DquRUO0iXnC9gafK1h76E1S18xGL9uBJ7SydpY57Q9/2QRXvcJhsnBd/iVwkRsWB+AzWEMZQ1973WH3LJNWglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EARXFSBUHIoyqheAFh9huRdn8UprStyTPGjQQe2lGZw=;
 b=LSyDz7UmvYs4JfETmlCNyVBHIPh2tmLAG6kx9fuwuT+26a50MXBT7ofv9+NrI9elj/TdQ0dIPvKU3YjNCSUKV8q/21hWHhvQddes2u6N9oZsTtKYt6b6qpdzoxWB2cVpXI0jZGQhI63mTYak7mzEScj4ALdea4CLmbKvM7DxTB1YMOGSHyWd1F3XT3vvijo6UP2PFf694oVPxpHcjzEgAY+BJrib9ue+I9QPB43HryPRsORvuOIaWxxP1HIcxwxUMRtYBYorwB7/Z2EKdv+M205gfONYFXyAekHqvSXDGh+t83qUrifip0fLHMzo72ifxoIOvaKTndqhjO4fMNp5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EARXFSBUHIoyqheAFh9huRdn8UprStyTPGjQQe2lGZw=;
 b=BPhtipCf6FX8ejiVbbSKq50u3aNbM3i4jFk6Jq20OYLcNPjK+ZbHWQ1AlpVoNnD1SvY5jrzG/pYxZ0rl5z1LwB2MS5t7bp3JDSyo3IhV4R18ZEIIXL+uB8ygtphoEf5PWoEtE5PanypRPmiBzBbpozv2URMSoN5FpT4nN91uSdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/6] imx93-11x11-evk: convert to OF_UPSTREAM
Date: Thu, 28 Mar 2024 08:52:57 +0800
Message-Id: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGm/BGYC/22MOw6DMBAFr4K2jiOz5udUuUeUwsA6bAFGdmQRI
 e4eQxOKlPP0ZlYI5JkC3LIVPEUO7KYE6pJBN5jpRYL7xIASC6mwFjwuWglnRVmRxVZXFgkh3Wd
 Plpcj9XgmHji8nf8c5Zjv659IzIUUxpq2alVeIJr7tMzXzo2wJyKeteakYdK01LbsVd2bpv5p2
 7Z9AW8c49/VAAAA
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 328f39be-901f-4c50-0b9e-08dc4eb915e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoawIPfsr+ImrJ3AytEKTeyEOBI4E45r3beC+ZsI1z6l4tT3SYHHme7vu2Z5iXJoRlQaURn5HMz5hZETrIaMcTbrbazLOUJ3QEyBgK+Eltsfb9xQQYNtbgsS5g+Idbpe7MzlQVhReRb4HuZgJB69TZQ/mqVseedrHS2Pi6ezJt4dEMyzg1h1yaZfbGzLu05fJ6ECBVIIrninzMNHOqAV0IihqobLSgK2FSQLVLxfv53eCkWLQq9/FxDIBiemgerttOUhQBdFUrk0W+SSSwaC2p3dS/TCwNjFgOPBZZ5EzcB7oUQYeQ12xSBonWQj3/cj1SLkvPkFrifM26IEhS8/VZYde4npuogndDI4u27hlWPigOmcPixR8q+mhMpOy2sIPrzpsZI8nqaRuh1N6JUOAS4LAShhU4Gor8EYVqyfPFYi51TsWMoa7CLXHMVPl1DYCMmu2OXH58FTqu97P3DsXC3xHZh/q7EDC+boqR9EX4++4k6Ipo+oBQ4q6jWh5y1CTKoMmI5l0JycWBMsxnQFoNAFxWfRaFBSdY1t2lZ5Kzss0c2AA8UHGnPFJnGELhA4DPKn6amU9ZCtaIqzaaIDoKVlx2SyAzPIAcoYMXrDm/UzV9zQbmE1MBnIa71ah1tOdThXpps5Tu1RkRdZXePgO7++6TKZr1cTKbGXzcyud9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNCOUJxK1Z0SUlETzBlbzVhZTFGOVZnVjVnTU8xSENOU09XTG9tL1NrL2Ey?=
 =?utf-8?B?RElndDlVemxvNTRQU3hpd29jamdEbGJBQUxydnBZVlk5b2VZUlJSaWJXekFK?=
 =?utf-8?B?c2VNWEdYOTAvR2Zlc3JlSFNZQzVQdlFFUi9HT0JZUXc1UWltRlJCTDgyT29y?=
 =?utf-8?B?bDFkR056WmlFVTZxajcwRVVoV3laM2pJeGIxVGt1Vm4xQWl5TE55aFFNdDk5?=
 =?utf-8?B?czI3Z2doKzVCSi9TQTF3UzlFWlBmdU1QQ0FnM2VRUzVKRzBMdkZtd3grbHJl?=
 =?utf-8?B?Sy9BQW5mQUdhZHpjcFBvVlZwUGdoaFZsVTVMblBVb0RUYjNiOXRwSXVqeVBO?=
 =?utf-8?B?YW9haHlVWUtmeEZTcisxK2Urcy9uTnJQeEd2WlVDb1FlaU1tMjZTRmpYZmdp?=
 =?utf-8?B?Q3RHL21nVmZWNkkyczU1NWd5Q0FVbmNaaHc3MW81YmZTL2xYVUl5ZmJJRi80?=
 =?utf-8?B?czlYNmlBZlltUUNEc1FZZG5iU1AxUExlV254emV0ejdkN3dZREN3dDJJSFJz?=
 =?utf-8?B?Vk9qbmNMRS9WZXJWRzJpR2RNL2dBaDBvV0pMMlJRcGovOEp6YTdqeGhWR0pu?=
 =?utf-8?B?N2xVYmswMDNRMDdNUWVuWXI5ZHl4dlV0Qi9VcThKNThmR29odUFIa1ZIMGFL?=
 =?utf-8?B?TE0xcGdmSGRLSTRlaytLcTdYMDI1Yk1PUGdoUXlqdGZ3Y3REcGpWU1hNUjZU?=
 =?utf-8?B?OE9rZldBeVZwSktqTmp0VElnaXk2S2tldEVPK2JFdDlnYndHSCtQQk5RQmFP?=
 =?utf-8?B?ZTBPZytWTlphUzNZOENUY0J6L2FFcXI1L0RBUDBzdnYrTjBpbDhGQzIvdEJw?=
 =?utf-8?B?aHhmZENsSisreG1yaE13eFcvVGs2RXdqNmxNZ28wT3NpVkxQbVdxMkZkWjl3?=
 =?utf-8?B?dy9ENTVVY3VNUVVsMTFBa0JzTXBUZjBQR0haYkZOdGNNUEFRVnhZd3NMdG9M?=
 =?utf-8?B?dzBkODl0ejhBMDNwODliNnpkdUhhMm5GaUQ5YlorOERSTjcxZENobnYxYXdT?=
 =?utf-8?B?VnFURkl2b3UxZTNTaG56S1dHM3RpU3psMDRINXVWZTBvMlU0YmJ4SUNQUGZt?=
 =?utf-8?B?YjZqZG9Sd3FRamE0L0cyd1ZTYnM0UFhLZmZ6Y0FYZjczVDhqQVV3M2pxZ2RN?=
 =?utf-8?B?VHF6c2VtYTNBOXJWS3J5NTJRbWFFV3QrSlNQQkJLc2ZwWkV6VDF2dUlDYldv?=
 =?utf-8?B?UVRmMDdMUGpxS0pwdVUxL0tnbi8yaDFyc2xoczJNRTUwR2ZPOVpEZ3R3MUEx?=
 =?utf-8?B?NzlwOUN4eEtPWFg3RWZiK3hGdFhnZ1lCMS9ZY2lXQXVmTnBVS3NGd0V2Z3Zr?=
 =?utf-8?B?dGo4TnhzMGJ6bWZPTHB4aXpyMm1TY3AzaUxqeldSbXRYOGhaV3MvL09HQnhx?=
 =?utf-8?B?anNMRmpPd21GR05KbityRUxXa0J5Ui9aTUt2MzVYOWVIazdvOVRvQXpsQmFj?=
 =?utf-8?B?OGRnNU96RUlkRkMzQTVsUUFoZUcwV2lxUmsvSVRNak9UNzBMRi82ek0zSEZM?=
 =?utf-8?B?QVlOaTR2TnNvUW13QmRhTm9scTRnTXlTWlBocERYQ2J4cndVemlXZEVSd1Nk?=
 =?utf-8?B?LzdQaGdRWnJ6eDAxYzBEOEtPQWREQ3BWc0Jhem51SnU5dDQyd05JTllMUEpp?=
 =?utf-8?B?TWJnNzVGQ3hhNWxIbVNwaDhxSVgzNDdXTGYrdmQvYlhDVXcwc2phUzBuVkRJ?=
 =?utf-8?B?bEVvc3FBaDBkRnZIdE0rdlV1WW5hNStRcTJVVHBkV3d1Z25ObzIwTEtXbXdT?=
 =?utf-8?B?NjRNb1BpV25rVld6NmNVNUJ0cFdQYXduVGVDd3NMMW9OazhkeldpenhTeVMr?=
 =?utf-8?B?bFYxU2V4RW14T2VhOHdSMmVRM0oxT2hvbXVvWkFybHNsdVdRUEFIMmRvOXoy?=
 =?utf-8?B?Yng2QkE3emI3ckxhQjgyY0xGVG1wV0xNN2pnTEJVaHV2U0xyMzBXNVE1bTlP?=
 =?utf-8?B?UjJPaHNvMldpODE5T1ZLL3VYY09ld1dSQjMwcnB6WXVhMS9UcEhFWVcyNWtR?=
 =?utf-8?B?STNuR0JiVEpFSVFydjdhR3hOWmJOdXN3Um01WmQvZkF3YXhmQmo5VUk3Wm5L?=
 =?utf-8?B?QzZPak1kb3Rma2VZMER5T3kwZFFtQUdEUE1xdExYUVBxOWFCY1NhTzR5Ukc0?=
 =?utf-8?Q?xW9c2zjvSn+QVAw7AUAOsuXdB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328f39be-901f-4c50-0b9e-08dc4eb915e6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:22.3885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj4IzCSRqqtScWfVl+xHHIx+IjNXeGChI6zJlMRBfxTaQBpaN7pKMFHgWVBakhoE6yhEd+Jq8PmlpOG+MEGr6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

To support OF_UPSTREAM, a few driver changes are included.
For TMU, still use U-Boot node, I will prepare a kernel update,
then back to U-Boot support.
Add the pmic nodes to x-u-boot.dtsi, since upstream still not has it.
imx93.dtsi still kept because other boards still use it as of now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Update patch 5, to drop the imx8mp-evk changes which are wrongly
  included
- Link to v2: https://lore.kernel.org/r/20240328-imx93-of-v2-0-909f5d37da87@nxp.com

Changes in v2:
- Add a new patch to sync clock header to avoid breaking
- Drop the Makefile change which change including order
- Link to v1: https://lore.kernel.org/r/20240327-imx93-of-v1-0-afab6b31422a@nxp.com

---
Peng Fan (6):
      gpio: imx_rgpio2p: support one address
      serial: lpuart: use ipg clk for i.MX7ULP
      cpu: drop imx9_cpu
      clk: imx93: fix anatop base
      dt-bindings: imx93: sync clock header
      imx: imx93-11x11-evk: convert to OF_UPSTREAM

 arch/arm/dts/Makefile                    |   1 -
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 +++++++++++
 arch/arm/dts/imx93-11x11-evk.dts         | 322 -------------------------------
 arch/arm/dts/imx93-u-boot.dtsi           |  15 ++
 arch/arm/mach-imx/imx9/Kconfig           |   1 +
 configs/imx93_11x11_evk_defconfig        |   2 +-
 configs/imx93_11x11_evk_ld_defconfig     |   2 +-
 drivers/clk/imx/clk-imx93.c              |   2 +-
 drivers/cpu/imx9_cpu.c                   | 224 ---------------------
 drivers/gpio/imx_rgpio2p.c               |  42 +++-
 drivers/serial/serial_lpuart.c           |   9 +-
 include/dt-bindings/clock/imx93-clock.h  |   3 +-
 12 files changed, 185 insertions(+), 556 deletions(-)
---
base-commit: ab8d9ca3044acf51d8ff3bf3c4718c48f30ad606
change-id: 20240327-imx93-of-56ef2b96f2e2

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

