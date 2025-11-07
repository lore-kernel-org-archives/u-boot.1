Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A646ECCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C79F83CEE;
	Fri,  7 Nov 2025 05:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n48g4uy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D115483C96; Fri,  7 Nov 2025 03:26:51 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC20C83C9F
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ha2FRpKWrPcH65fpXOfeNbZ2BrZiYe6JYeC3mt0F7JfMOI4+rUT12PRarViAzc1Q1CmdOE1mZ6wBhcI8HDJ0lXX9lYBy+7xAPpUzfSni9kWPNanF1OZwFkjVDV1Gr3S0XI/H77j14TZOanCfNyauzydC3oKfLx5uo+tcN5bbAL6S5SCswpBHL5IJ76KBoW/ThCPs2RSm6Kxdv4NGb7Ih/5K65I/ED15v0HL6VYrUomhVCUy2e/UEYkQ1lQOsOciNB+ybomPHqvMIbVfn++JqdswdLnosi+WzIxmfCHCvA0uA0wfe/q3tJYbp8XqycTiynlBHvYrauPmfL5oP82VsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQK/9s3KFSsBSemv+NTa8mdcbD0NbWjBPThCWOc02KY=;
 b=nooSnUMgdiNmH0O5lvNnmEC33CLwjipFFKeqjY7nS8zm2u4EzPffq4SCw0Rh+6SjUu0o5eOSwhQqhuuUR4LTDzqeQ3EfMzo1RAnUcL2w1Df3wEyyCBJPIjwfNOzZM8k8cykqZ42kDIl8wthJ28xAmQH9CfPm56Sd607uRCi03T3Zblnq1xYFRK8F65TrikOR5o+DIcHN8tUME+8GVwf5MC6r5ONA2YiUV8ngR7nU+/DGKaWyPdgu5j3Jk3fFe9O4CQnVOqpxFBUmSdPSNOo90frK9hXe+6kY+eVKIyuaULzeMl06HaT6G9f4ffKp+Go14Rc4wVtAswRz940jPidTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQK/9s3KFSsBSemv+NTa8mdcbD0NbWjBPThCWOc02KY=;
 b=n48g4uy6WdyfPGZ4JMclX81bPr0tDMOMq3E99mG8qfydh/SUoXz6TfORefprzKCgME8rnxyni9yAa+8IZpqIvR+3TtcV0bbi0vSfCDnXLxmKzFQkvZvoJUNovSBytNKI+uFEHHJcGZe4Ckrgz6YZEmGzX0pzDv1Snlkc2kvaFuyBfrNEeDRUTw8CMYjzS4Dp+tXQggoMu0PlZFcrl/dhs8S/Cvu5MfZL9klelDXKzaNNpPDpvu5fU6yOxSnfTe2HAOXkoRv7tp6xjwHSsbu7BqN46UIg28/mIYYlOpvVpYMria3Q/swBldRbq5z2SzZp842Ik+84TuDB9e7fvNMt5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10579.eurprd04.prod.outlook.com (2603:10a6:102:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:26:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:26:38 +0000
Date: Fri, 7 Nov 2025 11:39:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Maxim Kochetkov <fido_max@inbox.ru>, d-gole@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/2] clk: scmi: add compatibility for clock version
 3.0 and onwards
Message-ID: <aQ1p4BiM5XpqO3Zg@nxa18884-linux>
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
 <20251104-b4-scmi-v1-v4-2-51f101a6f8c3@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-b4-scmi-v1-v4-2-51f101a6f8c3@ti.com>
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aae7289-db0e-4c63-2f44-08de1da5145b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u1bgxIBz7noGzl74PvDluzh9xrQ+rhAHIAqsnEZL9Zbc6rd42CTX2WB43Hu3?=
 =?us-ascii?Q?94ncdwFJLn1wDCLlOlKvaB9+92gesTzdNi3rczEfYoZ+8Q/rPj6rCg28uvLP?=
 =?us-ascii?Q?kefBkRMlXj5U0BYWK9ZHgzgTnelnXDJXiuWwJxCu5jlsg777eTBPH3HzslOD?=
 =?us-ascii?Q?nuz5vcKJnl6BCTG/9qHRsicaRnllvJ2hWynyTG7eUf6OUlyrcbPPDd9M70DQ?=
 =?us-ascii?Q?H0LQJU33QFaqra+4BVsqKKtf4xxX+m3JHoXHYyxEUZi2g58UIMMc8vnRvVs1?=
 =?us-ascii?Q?BZVEOD9LTXOtTla5TXgl5EUvN8EgzY696s9imKowow0JKI3TZOGhYEExBtar?=
 =?us-ascii?Q?7dK17+/fxtX1BQJ0gfUYlbSBDOVqySm8+ebI1i9aY7WI6RNQL7zytJ8pjEZK?=
 =?us-ascii?Q?HL+YMRQFc5F+TwRaBYjIK+iauPAZrxqVy+C6L3e1+v/PmSmfEifuOlkMezZm?=
 =?us-ascii?Q?PhIwO1ruGEFcogbYGdkWLLMk3BKwVfF38mlgWvKa60tk+JwTWWycLP5VBhdR?=
 =?us-ascii?Q?BYx+vb42d9hVyET1mee9wWqsf+/BJ20pC/WQcru8+A1TZb0tBIsiV/aYHRVE?=
 =?us-ascii?Q?pIepAAJIrHS3oLiamGlgwuXvVk0sZrqv5Yv68NOG5RdvHy8dGGxNLE/5VTNy?=
 =?us-ascii?Q?EAy0Lf90UXj5FSYA1OmOzOEzSiXRobuV5zH+n4FtfbOQpRs3jdwvmzuIuWSX?=
 =?us-ascii?Q?tFT0+fJOtx0V7mKVZmJ3YF/a1IaTBxaZt6D/CvHrcTNJ2BF4cJPBrUKBmdzC?=
 =?us-ascii?Q?jFR2FUJ6wEFoBYSBXYFC3vcx+GJPj+jWVQhnprQYDsq2f0hKbAWYnxpF8mrS?=
 =?us-ascii?Q?Mfa1s0vNz9vhjrI4Nq5HIGLkCp73as+7JQ6hOvyXfHiC0Qj84IC2cYzfkooo?=
 =?us-ascii?Q?kF1oMTk3G+u7nnER+sYR9ZLUxloyhFDzJFl1Ol/jUVBHI5s021bejysjr/74?=
 =?us-ascii?Q?MWB457A1V8cZSrfQ6RB+yBDJUxsqyXFdl2CK7DffBcUhpH/+GtT7Pi2mLDYO?=
 =?us-ascii?Q?aN7LjCE0T55TZcR6yPK6FBr2R/3g9xVXCMwo2663xUB1Aj6tOfyNEa63KAXS?=
 =?us-ascii?Q?VHGGO2ug6XDutbK62P0MiugCvyEEWT6cv4ylO527lPJ9r/9JjhSylHLIvs+b?=
 =?us-ascii?Q?HLFN83O1CWoGRfe/aOnP9Ox9bxAHHtIA1WYjvOvNptlgVm/SZhrJz0dgxbZQ?=
 =?us-ascii?Q?4fppJwR3BLpmrddJGi3zPVd8ry9stefU1+oM5xjYGleNcZXNJyCoGKnO6HxW?=
 =?us-ascii?Q?u6M5UPn98hlkGhUnw85yX9sxCBdf0sz6AjrImOt9anDjn07vC/bRjL2d6gOc?=
 =?us-ascii?Q?Jmx+DOLU7ap/r0TX99Eg/ch+1LjpQdI5BlkWQnsBvNc8CPa/bw5WdaVUis1/?=
 =?us-ascii?Q?rYg5cbJY/AL4PRstvIPuxXvudSdKI+b06VncOAliffySYdh7qemLPUdLU6PI?=
 =?us-ascii?Q?9Mzr0Z2p7wyvKmnlbk/xN+1rXK8ACCuq07BcfrOrM5g2JsIuw23E5vuZZAgS?=
 =?us-ascii?Q?FXvFAq06rtcE/m6CJuitgUbAgp4fBQUQWIqp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfUXFsUZZ3lOu4mz7BeMa6i6uRP+e8T8p97kzxfTcjOpb9B2p/+VbpMQ3Hx3?=
 =?us-ascii?Q?0jguZ8tnNRpT0p2VBBdPIWCh2KJILsM70m53lzdFaiyeklfenNKijCLfezeQ?=
 =?us-ascii?Q?2df9RSJe0cgKIJao9xwuXr/8VMMSOU41NDWcGUJiTqbhw0iXlGC4i7g+dIGI?=
 =?us-ascii?Q?lYZhBgJQlYp+6jdiPwSwqC6eDtD1memdZ2nTboiekFnxHK8f+os3nahqe2+t?=
 =?us-ascii?Q?5xQr4oGTbqUUhHKO6N32m66rCj66Qs/U5WN8BOcxIhjeKFKn/3/bwM0ycesa?=
 =?us-ascii?Q?/W+O5RXWkNs4KNKsAg/WhSwvrUlwdpOK9yE01UD93ZVPpMUawZ0CrgjhRlS1?=
 =?us-ascii?Q?/nQrfmbmHqfn2Fh4o0ax/7qzCRUx2vuoMpiqNf1Mdaz8XVz+llalG/vkuXTo?=
 =?us-ascii?Q?mj/viNGUPY5rcuFtNp8fIlChGDfsesWZpbN03rW/imnymKlX8l3BzapcQK9q?=
 =?us-ascii?Q?M+Rhe38OndxEhmcovDoJTol69suMWTQLoeo5RUcQiqIVlzznLyiocVwi6rre?=
 =?us-ascii?Q?Iz/0MeSIwxFpq7MRelz+q0Nj3Lgx5wJXwGxXEhdKhAZRhzVP5ZOkstnFumF8?=
 =?us-ascii?Q?KKmVno28KBCvC1ZhiYdnbXrSEBO6S8h1S902p/tkfhkv1bilycRwF0DVMv76?=
 =?us-ascii?Q?OGm26XYQ+5VQDwKUc1llyElh0QBfcBfDQRtWwrSp5OJfJJ/JSUwPcs2suPiH?=
 =?us-ascii?Q?vZT+Zn2ffMySU449A58XFUasbg1XHxCIht10r1KTMS6m6dnWXFBlVyOL87yX?=
 =?us-ascii?Q?TQCkPAVIFovzumanQFRfRBc1khu9D0iWRYW8emVmmPJP16Emb+ab7Prc9elQ?=
 =?us-ascii?Q?W4amAli5coAqnGy5HqA1a/9dlL9GelGQx2MRsksXhJEq6szmnryaDMfQTfZM?=
 =?us-ascii?Q?GFgMSwOWEziQzr+Jj5pZIR+7HYmHakvPZuYVV/g17sKruseEjm54fd2k+zw/?=
 =?us-ascii?Q?cMNEKwNA/D7r7dCAs4g15aXG27yN6rh49vQ23Y+ls8aasmJbeI2tK08iha5j?=
 =?us-ascii?Q?/vlnecpZJ7q0qVVg1bofFoWbmrpbM+TiLczsv2E+FIKPOzWa2mJdLMKTIW1Z?=
 =?us-ascii?Q?IrZ1QStB4pb/ZG1BIf4r6P4ZwgQ0d3+WToTTogc7rpvasYTmnG2GSdxCjcOM?=
 =?us-ascii?Q?yWRLsvCTQxFBMxySpBHw9P1CSLSfgeINxvFrUddYMbNqgW3HpuccvEYjvu3i?=
 =?us-ascii?Q?aUcmgRIs16drRhmK/zBDiVQF70HDDhv/xnXXxJ1e73iA8UZxUwl/N7uhFy4c?=
 =?us-ascii?Q?UE9lCBR1DOkNnusRRj5peEqeH63iPjTIbGRgearnDHV27vkIoTa55YCIoV6f?=
 =?us-ascii?Q?7TTVRFQnXjwuzyO+wzYTqzSA5XBf2cz9wBP9RAdeMQRfHb28hrs99Bqi7LhV?=
 =?us-ascii?Q?7uQmd1/BSr87k7YseYnFXQWTCIekDiDzWTaGECRgvsm8DAuNpCsCBdsbKYVd?=
 =?us-ascii?Q?gCrT5a+WuOKtOVkiXZFfMSN1yYio734C/oo/BpVg1ss8pLTD4Jc2wbfjwdlY?=
 =?us-ascii?Q?1/1F7hP7me1prxl9KE0QQb8ViIzDJgPyJqDkWep7/K9ovi9Tl/pNAowmM4d8?=
 =?us-ascii?Q?22JnMQCiiWKyd4Bflk7RWSB/dTukeLfHiV7lhJHD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aae7289-db0e-4c63-2f44-08de1da5145b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:26:38.3059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4fXCRIwYNVRy6pTppZBtib+nKqxsb2haRF8P+1+CXLsQe67SqQafE5pzBCsNOYQnhKh4bClVyfjM3+3h90c7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10579
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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

On Tue, Nov 04, 2025 at 04:49:31PM +0530, Kamlesh Gurudasani wrote:
>Clock version 3.0 specified in ARM SCMI Platform design document
>v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET and
>CLOCK_CONFIG_GET. Add support for that.
>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>---
> drivers/clk/clk_scmi.c   | 52 +++++++++++++++++++++++++++++++++++++++-------------
> include/scmi_protocols.h |  6 ++++++
> 2 files changed, 45 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>index 83ea7bb4286..6d47cc6cd01 100644
>--- a/drivers/clk/clk_scmi.c
>+++ b/drivers/clk/clk_scmi.c
>@@ -131,19 +131,45 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
> 
> static int scmi_clk_gate(struct clk *clk, int enable)
> {
>-	struct scmi_clk_state_in in = {
>-		.clock_id = clk_get_id(clk),
>-		.attributes = enable,
>-	};
>+	struct scmi_clock_priv *priv;
> 	struct scmi_clk_state_out out;
>-	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
>-					  SCMI_CLOCK_CONFIG_SET,
>-					  in, out);
> 	int ret;
> 
>-	ret = devm_scmi_process_msg(clk->dev, &msg);
>-	if (ret)
>-		return ret;
>+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
>+		/* CCF: version info is in parent device */
>+		priv = dev_get_priv(clk->dev->parent);

This is wrong, please use dev_get_parent_priv after
you rebase with fsl-qoirq/next. There is conflict, I could
not directly apply this patch and change this line at my side.

Thanks,
Peng
