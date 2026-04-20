Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85569F5581E
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 11:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2362842D7;
	Mon, 20 Apr 2026 13:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IMVEw3ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 966E4842E6; Mon, 20 Apr 2026 13:26:43 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9700A83E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7WW9A4t629MvDv0uk17RP3da9g2XR46bNomD4JNnsK6OmGwKF6QAAYfJHWqCsLIMOzo7q7rXkjgj7CfOD4csRyl4nC4MdVhSiqxslz2+DCg7Q27SVAws+m2RaaYPkAbRxgKBxg1EiNr/zmJ3sPW1b+CN2vZXQQjAsLtPR7tG2JZkyC8on3bL0LdKJRSqUEWkIsJU0SqjbchaqwApVVnC47p+74QTcJtTd5r/pZZ2t0Txe51bP+K8kbQMtcTQbWx2NMbo2dReW/oxZcYC30AlEvkwBCUd+z2+6n2Xi6uM/ei5ld3lBA1VwX73ZRjFusTV3DgsvNTKoDdZKT31ohV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nyy0nKmkem2NpD1gkQmiVcxD0PL2S0yALpACg62b1ms=;
 b=fwx/QzTTQdXi6frrJdWGOOiyYqE2rIEAiRcjBBgr9Opg/sUbVkee8p26ZhFXCETQgcueM3plKLp8XdnaATwoEem81fhYj6WC1pAoOcksVYi6L54ikVxc8tZRhXx4z3+DUqD+otTWb+ssox3qtu7P9kbsasw1n2Ee4CrGz53xzcshH+7TXhTZfjpLHA6RKB5j1XeujUtH9z3HHXAcmiBBFF3rnyGZ7BXTnG+gpMO6lfll6qa6ha2EBcpO46Ge7UxP4dVStYrGOiDX3LfUWSdx/Bo1sgmnl6EJoGAkaAK1UqHOdr1Jtx9GK9mEutp3jz3CyaKWb/U8s2u1G81ICVt6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nyy0nKmkem2NpD1gkQmiVcxD0PL2S0yALpACg62b1ms=;
 b=IMVEw3ll8X+Y5ithCSXXV5zMQyiQp644/uAH/4lScf5exo5pS6rb+rolbQNpm/7YVhKjWNJIhBpECKiMaEA50XjDF65ZPrcxh4HCmAcy/8rl0UFtX/S2kQn2fU+6RNI64V1S0tKMH1RbwcGpkSeno0MayHmu3sQEgT0nVtI4UQ22ltq7F0gP4Z1UGZ//zPzl7+UbhxiMIcWq57ltDqVxS6pgxBwAvLGyibL6YEgrnLMZrw+CTDjhPSgIc6S3HhInc2cDtKjF7ZlJa7rvtxOP63Y40GdVl3xKPqNxpqdNzukRnb8ejj0gLE6RxhD6CoHEZZg9Dy3GSJfG3Fr7NLXWLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 11:26:37 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::21f6:947a:1f40:18af%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 11:26:37 +0000
Date: Mon, 20 Apr 2026 20:43:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 2/5] board: ten64: add fdt fixup to hide usb hub topology
Message-ID: <aeYfYKCh3zRgtHT_@nxa18884-linux.ap.freescale.net>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
 <20260409-ten64-add-usb5744-v1-2-2094496f72c8@traverse.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-ten64-add-usb5744-v1-2-2094496f72c8@traverse.com.au>
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: f477319b-88c4-476f-4c00-08de9ecfaf99
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oLAKSf8O7olAGREVl9+c6wvUtDVI8Uk9BZIbJcaZ6O23Wic7GEh+PPs80QGr0e4/bZMLFMdmykQk/hFwplAItdWKxsFPebBTcnVgs3zo2Q7ZrDvjw2kxLFITknJy5+qcWjOqLEulNC/rhLgfMKshsZF4W0kYLedKDMHWfAcN/SXsR8/pf10xpZ7bZfSEoXFdl8VfZp235qvfhVhN4P31eONzFiNmal4QFVsDq/xDPhtoPaCWUgOtnZ9ycryNIBZyVRVMlIZMyUZJvNg6PhbQXyxpXAJfUnHQub5SmkXOgVz4UWuWtv49V1otgftG+YwfPHlmTHfuQX5ALsg+smMULXL/bpkmrT2QcYn7lX5lcHhFlJAG1OkRsPSJWINNPiOZv64KtL2sKmB2Xsz1PNRNGhZXa3PfiFHHMLaUkoH1IQgUL4zFUhFQ/r4KEWQcYfpfMxcOrbjKmYjNs5PFdXBi4HwmsHVS5+LpHCR6Ymm9ZawFrESLqg0jlZmsV/I22UfFu+pTK0dfnbVLgpDuNS5Xjx7Bc4Of6e0n6WCCDlnJtHQFdOcyYs+HnHB/rOGTBX1a5chuZVzU4LL/DBSIhuzQGPf2IWSojkbDnpHGeR/OukPAT7MHxXCujwX+5h20qGRdvTtPgiWtZe26N9gFg+UcG3vPkV0F5F9/EylELj9mEB7/QiIlQVGARr3vTRuBwUZAud2Ae8OZmnKndaXFtfVxEgh5dcxEYEKgjbRluVHRWMI25/d9DRZHXRa8e8gbl5xxRg5ZF3x1WDoVKg38Cpeonp93fWrFI7QEqoUudO7x3Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvyeEpdG3CpfxFH3rUiOzwXhINnGSLWebx+00rsUhWyHg99IlhmXm+4Hbzk1?=
 =?us-ascii?Q?Et1xOqn+5tkB2JGeQAl1mBy7SxZxPzT65cZC7cGiCaihchhZM1z9177jaVXD?=
 =?us-ascii?Q?VR3KSFQ/zJz1Wrfn8evsQH+hpZ2KLmEFrqRJEucI4DxHhjWt4JzuB0x5NrsM?=
 =?us-ascii?Q?08o88A3mZCuZBl3L2smFhE8qr6FeISC6xxNun0Odu+0kRzT6cfW6rkSt5w0N?=
 =?us-ascii?Q?H7WesPrgFiCzssgeqjwEi7YtgrvGokwv+CyXcJe95uY2WuvSf2+uhqG1ZPvG?=
 =?us-ascii?Q?oW7GG7/J7HHS5O3j3JzKT8wnwVHfkih5Ec2BUM/5fqglDqdNeneLCJ/nSAYA?=
 =?us-ascii?Q?9/z+co/AIupfYAgdQOInRGsHC01mpLQTd3SanjZPdc0DsVWCdtz24FKaQrxA?=
 =?us-ascii?Q?fnjkjq8VY/QTJP/IZ3ObgGcnskg1L7J5X6J5zVQ6a+5A3cYyPM/0AlQ0NAJz?=
 =?us-ascii?Q?xTcatrx7xxdSx3uGFnD3F2s/3XypavUYViANDRcYPve/oNjslQO8uPuFnbHC?=
 =?us-ascii?Q?RoUWPoJeZrpjNH5FeaGGbLaTEL8g5Mm2Zf/ksz40oO/i8bOnUCYeUlNYA/Sg?=
 =?us-ascii?Q?CMNTu3lIVQQIu0rxRANiOLqKBthSIK6AI3hnvRQQABp1hRmtVt4ON9gtXt/H?=
 =?us-ascii?Q?67Q1f5nI9gFc6x1YHn/L8HPzB2mD2CMIrF5TjuPNciw9NkIGJdFRoN3JUTFY?=
 =?us-ascii?Q?3ZK+G9lr4a6OJXgJP+fADN7FIAjCoNcOOKs391iJ1Pyl4MQW3QYwjgtWS0Hw?=
 =?us-ascii?Q?0UhWu5p81+zD9p3aKh1Z4eXA/HnVffW6Xj+2Vml09/GO8l9dFObrMD15Aqnj?=
 =?us-ascii?Q?FbvzmmiRp6LB7/GrLageiQWnahXk8/xd46rHdkLxpd+M/Z/d81+TI0cAnmnn?=
 =?us-ascii?Q?jCB4VkcjSqoGO02nolbth2MwpGpaDys8j/7lwLU+Mgx/sfLnyTTk1eUgoTle?=
 =?us-ascii?Q?R9PgAz76fsdxuyMekMZaIVhwdEgsRl6xkzlBQMPDF/cy8WaaizQGtDOXfQoG?=
 =?us-ascii?Q?zAVMas5oOgfwLspttZaJjICe5K3Qc27is/LgvD+HcBcrPjfbsFyRW09DzJ4/?=
 =?us-ascii?Q?HLwFxtmkG33HvM5gKBDVJvkqaY2pSEABDRgN0R7ZZcRcPIRLChR/6jotgaWE?=
 =?us-ascii?Q?HNHP7jzkqbQa54sEK1hMi+WT8HvIMAEBou7Caq5M9YZeMaDSyGk/J/73vCsD?=
 =?us-ascii?Q?E7wa8e3s9WHbfCouJ1uTMvMV7vIeo4kFYFDXkcs4QBdY5LAoNMfj5GRz6kmm?=
 =?us-ascii?Q?cAzoI4Sa8l/4Y78jmSp/sxH//QfP3HGi8jWwyboNno1Hmc5zeV17oNojqmjC?=
 =?us-ascii?Q?oAT+In1jlQGGYFy9Ng5HUqqvERh1KB1iZwvUX5jr33ey1KnJaCGcctsW3FZF?=
 =?us-ascii?Q?IZa/4nqUuX7Yqqf/2T9WPAIwTrev/oHqr+hLXkfYDvZbd0jayb6nv4MeCsAS?=
 =?us-ascii?Q?0kaSiIA9AkUa0N0+fwCz5EHjkIBgvavyBdpuyLdmcT+VMm0PPFQcwHvAxDKJ?=
 =?us-ascii?Q?pexGvRZfDClnu9qn3bMdV4k+k6jgT054UwFo2oIiMQYiuEUr4fq2KsEfXwyV?=
 =?us-ascii?Q?AxJMOz/AcQQzzUpBM3JD7KIyCldESNHyEh65kn/XwS6EiLRe4bpLVJJTAIXw?=
 =?us-ascii?Q?4fYMocNTuRfdVZNmORo7BgdDcWoMHRFDfkybKam+iRpMJUGuG3SWlok7dZCq?=
 =?us-ascii?Q?yvewt4vDYy4isNVClThaVTyNUn8lu4/ROKWV1cv0WjNgnSNY4OJINEJMPJwC?=
 =?us-ascii?Q?UvLw3dDr0w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f477319b-88c4-476f-4c00-08de9ecfaf99
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 11:26:37.7252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3Qr3aeitKs88eo+B3BpAUhusOiGkEmKuf3mWCxTFLl0W6fRVzfI2uuzKWDyeP+RYK8nyEjpNf17wr1IGeOyDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909
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

Hi Mathew,

On Thu, Apr 09, 2026 at 10:06:32AM +1000, Mathew McBride wrote:
>The USB Hub (microchip,usb5744) can enter a dis-/reconnect loop
>if a driver tries to re-initialise the hub over I2C.
>
>On the Ten64 board, this process only needs to be run once
>per system reset cycle, which is carried out by U-Boot.
>
>As there are distributions shipping with the affected
>driver by default, the best solution is to remove
>the USB hub toplogy information from the FDT passed
>to the operating system, so the OS won't attempt
>to re-initialise the USB hub under any circumstance.
>
>Signed-off-by: Mathew McBride <matt@traverse.com.au>
>---
> board/traverse/ten64/ten64.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 49 insertions(+)
>
>diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
>index d41bd2e9dee..69632fdc31e 100644
>--- a/board/traverse/ten64/ten64.c
>+++ b/board/traverse/ten64/ten64.c
>@@ -186,6 +186,50 @@ void fdt_fixup_board_enet(void *fdt)
> 		fdt_status_fail(fdt, offset);
> }
> 
>+/* The onboard USB hub driver (microchip,usb5744)
>+ * can cause a disconnect-reconnect loop if the operating system
>+ * attempts to re-initalise the hub after U-Boot has already done it.
>+ * (This process only needs to be done once per system RESET cycle)
>+ *
>+ * To avoid this condition, make the hub topology invisible
>+ * to the operating system.
>+ * It is also required to remove the hub on boards
>+ * without it (RevD).
>+ */
>+int fdt_fixup_usb_hub(void *fdt)
>+{
>+	int usb1_hub2744_offset, usb1_hub5744_offset;
>+	int i2c_usb5744_offset;
>+	int err;
>+
>+	usb1_hub2744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@1");
>+
>+	if (usb1_hub2744_offset < 0)
>+		return usb1_hub2744_offset;
>+
>+	err = fdt_del_node(fdt, usb1_hub2744_offset);
>+	if (err)
>+		return err;
>+
>+	usb1_hub5744_offset = fdt_path_offset(fdt, "/soc/usb@3110000/hub@2");
>+	if (usb1_hub5744_offset < 0)
>+		return usb1_hub5744_offset;
>+
>+	err = fdt_del_node(fdt, usb1_hub5744_offset);
>+	if (err)
>+		return err;
>+
>+	i2c_usb5744_offset = fdt_path_offset(fdt, "/soc/i2c@2000000/usb-hub@2d");
>+	if (i2c_usb5744_offset < 0)
>+		return i2c_usb5744_offset;
>+
>+	err = fdt_setprop_string(fdt, i2c_usb5744_offset, "status", "disabled");
>+	if (err)
>+		return err;
>+
>+	return 0;
>+}
>+
> /* Called after SoC board_late_init in fsl-layerscape/soc.c */
> int fsl_board_late_init(void)
> {
>@@ -208,6 +252,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> 	u64 mc_memory_base = 0;
> 	u64 mc_memory_size = 0;
> 	u16 total_memory_banks;
>+	int err;
> 
> 	debug("%s blob=0x%p\n", __func__, blob);
> 
>@@ -251,6 +296,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> 
> 	fdt_fixup_icid(blob);
> 
>+	err = fdt_fixup_usb_hub(blob);
>+	if (err)
>+		printf("%s: error %d fixing up usb-hub fdt\n", __func__, err);

You will not able to know which function returns error inside fdt_fixup_usb_hub,
with just a simple printf here.

Regards,
Peng

>+
> 	return 0;
> }
> 
>
>-- 
>2.52.0
>
>
