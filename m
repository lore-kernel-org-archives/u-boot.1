Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278D9CED618
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 07:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410CF89020;
	Wed,  9 Oct 2024 09:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KJmsnCw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A0688EE0; Wed,  9 Oct 2024 09:25:58 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D199488EE0
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 09:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNXgim7w5JQLWJASxIhJFl0qWxEDJRFjPvvi0674PoQ5YENAtGtngOp9GhAwq2m+79H0WAsIaF/qhLxOYb/3xhsX7IXlE6H0r776rHwGC1HwPuMqbXuRb6tLMQQabsHCnQCgxEv/knVkf4P+r61y3Bfo4Gb7yLyfBh712FLcvykh+96266VeoI68WkRvGwW6Gl+UDylYNHuJ82YzjDBWwo2mMKZxaeBxyc5zG18QD91zJIXFo6QSd/tI2hZqtkXBP+nLZI9BqOTZkQhY0m0BYiazQMPg2OpN6tNIsTA12aCHEbOV7U2sH6izVunmJuoShGkFO55gnNgcLtzQlx1Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbiPYQFHI7av99vXCF/FXRbm7xYSOEbok6rtqWCoUOk=;
 b=TOoBG94SlLKJOC9wEh7zhyKkd1RjhnNH5lMvdoWp1hC2IrbkGxa/wz4TmMK3yzhhgTG6yyVJ+L5/QslbceggA9AWIUB7yD9zKG642LefduxitBgz4vnxJ38+t9h3vqYsejAPa3M+dXBYDFryyeKKmppyG1YcPPOBXR68DaFy0Ts0F4D7wCT0as7oEjxKByy1yjqk/bqAwkb0POB1AWvQcV4+Uq3O4EcKQvszxBXf9GI74j5JOk1nEDtyO94HvK9n7T7/vFY38evL6YM2AbcJTYh5BYd8AbWh+tICCGn/YuDu2Dwr9f8JpJpu34Ytt5TlVl3laQgu9EI2po88+vhmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbiPYQFHI7av99vXCF/FXRbm7xYSOEbok6rtqWCoUOk=;
 b=KJmsnCw/bJhL0EZxHVLAcRR0dWErIpi0Ei1dwZIIHCHJcaQgwBy0wKoHU1C+0MLKn7WUj8TB/GlwfgHcAHj8mkLJyfYsc+iAXisOd74RfNri44unVzwbvqR0Z5Af5ZBAWcMidT7mZomYqZBdcw+yzbrLcqOvpczcuV+SqY2LYQLhEb3ojLYTS+m75x+qFc/Cv1CMxnvrOn0fP2/Kroo4ytvxxPnItzgh0VRtjyP3AHGzl+4BcpRGEOToruXlljiQd+ecfE5ZcDHbOYo+eySFqeeJ1sSqPfvITqHmLaPj3luQf/Jb/mAkRRUxDa84WOilgjYhtU7f6DaBtyE5Qaqu1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:25:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:25:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] imx8: Correct the SCU API return value check
Date: Wed,  9 Oct 2024 16:29:36 +0800
Message-Id: <20241009082936.22269-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be0fefc-aa6c-4ddc-c964-08dce8339b78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lZzTnHQzVZ7F89dYijc4BZKTMO/1RnhHXjmYKpPQa0nCDv1KfCndod3nIkDH?=
 =?us-ascii?Q?bFdBBQI5DJLkU6FqksD7GA1UtKMC9zev44fIiTcKnpSXx89vayYtbl/F9bdG?=
 =?us-ascii?Q?lKkZvVLOcUOYcowRddkgLqRWa495kn1tXbWfqB9sCoooUWnX7/bqekG0DNpK?=
 =?us-ascii?Q?98v4nR8fG220fn4KqDI8UqofHk+ETV+faSBw/W8soNqF1j1knqUzmgWzmoi0?=
 =?us-ascii?Q?diZj0lWp4QfQF5ExwA9oi/s0tRVqBEn+nQZ07tkcNUHLf0/PutgsuXdj3Jxq?=
 =?us-ascii?Q?dGrxzgWD4fZwDGry9wEfqWs9cwNsh+NeOlVFsP7jTaEnHHb3+DUWUnwZTCh+?=
 =?us-ascii?Q?5w2wiRZf77Mv43zjWWiu5zhJXTbhjXZ1GuAvQgzqRhncjXoHmM8bqOJYU5tH?=
 =?us-ascii?Q?G9N3EI3QldNfM2UjTSIK5HzxvYpp2Gn39RnSL4gC/a1WVrYtIHyvvBwO/npV?=
 =?us-ascii?Q?H6D69At91Et64EJ6HE30glqQC6NVjzBNsvVtm7/FLns2cCZ5499Qprx2L9cr?=
 =?us-ascii?Q?WjgmQeQk7dpOHI7U1M6Tvu38u9ADcWKQDkJjuy0QEgzHvLMJHWdx/NiseSaO?=
 =?us-ascii?Q?6i1sNCoYJdO6vf4+OUU3aHDUrlxzkJX9TMwo+9r4aIZmodv6qGAzUDr8SNVA?=
 =?us-ascii?Q?w1X001aQqzbITntTm6c+TxRzJL6a/asAouuLK8kM6d6J1g8pfWXBeLqGVYIr?=
 =?us-ascii?Q?Gf2bZgLMf1wF+Z1iOqjTgHqbtueeKAioPKAG2wvQp4bqv7ImDYIuW5cfCMjw?=
 =?us-ascii?Q?r0lLHrpBvVX8OAsudKDCveIvTe5r2iMUboBvJZvOXvVrfYR7Gp4+wiAc599r?=
 =?us-ascii?Q?2a3CqFaK5xGqEX/DfadfvjGPU3OOw6PnFvurTVlZbVlF7hdGdtKM9ZgiYmG8?=
 =?us-ascii?Q?t3ldLxpmv5g5wrQtgXYnUQt/krl/OWEEHii0KgJ7GIgx73D/XFKTMIttzml5?=
 =?us-ascii?Q?wJHN8pvEGk63NLmfSGGNYMDDPHc7dfcfRPMqtuz6ixatnqUka24UMSTqPRFE?=
 =?us-ascii?Q?5RWGRbkAwMyri8LSyNlcEPDRr+BJjZP2q+D03PW9nfj+NHhQb+fDejGDHMpv?=
 =?us-ascii?Q?3+mayGNN+UPrq0dbIz0uoloDG0W7BxRqqsHqNNxSTv1uMZAw+9pjomJRHYZu?=
 =?us-ascii?Q?Ud2yHam7iRn5t5US0U6Ad9kE+vdZcxTB9DP9wd3OiYEdVtxy0tLFpeCYfvY9?=
 =?us-ascii?Q?Ft34RlCS77z/7WhP4iRehlHZgf6ELkOPdbLsCvQZXBk2GL5IasGUQCVslwvt?=
 =?us-ascii?Q?mNopz9uRh01bLLSGezMmzU/9QLfalv0kFKDQaIZT4sYQlO2Pj7vUnbWwiEV/?=
 =?us-ascii?Q?jk3j6/+TSUriSu1HaTfAs1SBdi+nR85FkwdKlm0kw5/28g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMj5ZfZL+3ec67vCqKot9eaQgKUWVai/jLJA5eYd1fZFcwj85KzbOz+bzR3F?=
 =?us-ascii?Q?yckuaguoKjeKrIvwk9NNFpe0YhebbuUnytd0VPuzDXOpRnlVth4zYecFXcJ8?=
 =?us-ascii?Q?bykxAyFS7hoEGJapfdupWZtfVGNhhaKaqvKweAMbcMAqewupVPtv7iv8GMRC?=
 =?us-ascii?Q?bR2lj0AtPeuLeWES2I9VLcdvevr3zdzhMPTYSw+uVwmK7r7TdsGReYV6pyQs?=
 =?us-ascii?Q?CtXP23dHuLFNrtng5F4JqooXhfgxLH0rMcOV5Bc20HNysor9nQyqeJMYtxp5?=
 =?us-ascii?Q?xbXTHXmt13TwpFJ2hnU84qvJaKw38fuaXOSMlVGbxb1YrF8qao2CCZJ+hRz4?=
 =?us-ascii?Q?ed4CnUVLnuxSLQOCoe9GDuUECElUH+YXM35AFv+m+7Mri0oWymAAsDLZkBag?=
 =?us-ascii?Q?MU21Oiz1BA0T7TD7QuAzu3hoaWY+rhrYKokykNwyu4O9weKMp7rfUSVLG+Er?=
 =?us-ascii?Q?NY1mc6FDV+iquxvD8a2dVEeGIpUEvipMUc2zMt5e0TxuYhfzlZJigy9r3LLW?=
 =?us-ascii?Q?qMRIBJkMDvUouwAJxda3Vm0tR6MDFw+MbFwQn2wBCCXCMAx6HyE1RUfpyG7Z?=
 =?us-ascii?Q?8Ukqz578aY/KqRKYxxc1XuKz9fFEE/8ctzNrlqlX6KIJSKNkbHghse0/nXTf?=
 =?us-ascii?Q?17xyJQ2tsuilnwy58jilAV7FAuNtqch3qO/lMLf6b9z/iAeT3Wy5vNCeU7r/?=
 =?us-ascii?Q?xKTXTep2SgIp8h+sqyzOYZy8d3sW7U+Z9VaXkas9j/GOrsCp4EHprRqJ+CBk?=
 =?us-ascii?Q?aywm1AWIBj6rF5CxEPwFOEbNJ1r6N9QZZf1UwDPRKCo8haidv0hZ9RFNMSG0?=
 =?us-ascii?Q?uyXM2gbR2NuZtcJkAWvP/PHIhUMMh5wAN9oudD8kmzKlfVPYN4xxcJ4p5ltq?=
 =?us-ascii?Q?xK8BYKIuPzNeIMntA7uO/hZJXRfEgSSCX7SVZIxj44xYp5uB4CrQaxDTqMoz?=
 =?us-ascii?Q?53iz527dAaDyt3svQiMJhd27TnLTLFhy2dCkzL7V6Z2+9ypgUE4vGESDlggy?=
 =?us-ascii?Q?AeXD4pjnHMsrztVeezCzFHU5jJYtU5tWqv25sjxKYwrLN8UA+6QjAocJ7QBV?=
 =?us-ascii?Q?TIvhtV5D+00qxp4EKhS+ixdK/YTJ6LRAhQrzb0rMdBXmyWDCWyIp7quWBuRa?=
 =?us-ascii?Q?t6I0AXxa9V/bHuOqZKaAnafpiAunLPwlrq5oCMipcpyqyPhc1dR8RUvIO1yC?=
 =?us-ascii?Q?qUazZ3gdocjpZAQhFRxlixT7hQYw5AK6xiahhCSOqIgaZe97alrm4YHgCXOb?=
 =?us-ascii?Q?+wl4vzB7nZsX5IAd0oKHKt/JbZHIVj13z0EudguF1n7U1mrHj11SvmPOgeM5?=
 =?us-ascii?Q?+EF6s71+X5kinLR8dxGVdUtGZtyvGpToDG7Z95l/tKSfO1MpA7keopG42bmy?=
 =?us-ascii?Q?ueNba4bChOb1POftvoPn8NszOAeSkLQbVrjRHJehASw3TxgHc2Lx5lwgHQVj?=
 =?us-ascii?Q?0iWOJmc9+7QlYjTnP47Ynfvn+60PpROWUADz3Ygq+yaQqXO06PnaRYmU4OrN?=
 =?us-ascii?Q?H2LQYT+bH6gkA4UyHkH7LYwBfj48XbWLdRY4mp6JSBqc25YsSwNQxOZK2xIV?=
 =?us-ascii?Q?4a8APOkWpEF00/stblO3oarGaj3i+WfO0eaTyOPF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be0fefc-aa6c-4ddc-c964-08dce8339b78
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:25:53.2785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H4i7vbwNf5vHbDMLm4yVWtgpxGi0FBF7yDTIoYd9T5XnV89tYeTzboyPmRDUh8uhBDT0MK89MFLcDL5dXRPPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

The SCU API alreay has been converted to return Linux error code,
using SCU error code is not correct here, although SC_ERR_NONE is value
as 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix build error, passed CI build.

 arch/arm/mach-imx/imx8/ahab.c |  8 ++++----
 arch/arm/mach-imx/imx8/cpu.c  | 35 ++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/imx8/ahab.c b/arch/arm/mach-imx/imx8/ahab.c
index ed44df394b1..324e010bb2c 100644
--- a/arch/arm/mach-imx/imx8/ahab.c
+++ b/arch/arm/mach-imx/imx8/ahab.c
@@ -345,9 +345,9 @@ int ahab_close(void)
 	u16 lc;
 
 	err = sc_seco_chip_info(-1, &lc, NULL, NULL, NULL);
-	if (err != SC_ERR_NONE) {
+	if (err) {
 		printf("Error in get lifecycle\n");
-		return -EIO;
+		return err;
 	}
 
 	if (lc != 0x20) {
@@ -357,9 +357,9 @@ int ahab_close(void)
 	}
 
 	err = sc_seco_forward_lifecycle(-1, 16);
-	if (err != SC_ERR_NONE) {
+	if (err) {
 		printf("Error in forward lifecycle to OEM closed\n");
-		return -EIO;
+		return err;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 834aca82bcf..0f75674adcd 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -48,7 +48,7 @@ static char *get_reset_cause(void)
 {
 	sc_pm_reset_reason_t reason;
 
-	if (sc_pm_reset_reason(-1, &reason) != SC_ERR_NONE)
+	if (sc_pm_reset_reason(-1, &reason))
 		return "Unknown reset";
 
 	switch (reason) {
@@ -160,6 +160,7 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 	sc_faddr_t tcml_addr;
 	u32 tcml_size = SZ_128K;
 	ulong addr;
+	int ret;
 
 	switch (core_id) {
 	case 0:
@@ -187,10 +188,12 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Power on M4 and MU\n");
 
-	if (sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
+		return ret;
 
-	if (sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
+	ret = sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
 		return -EIO;
 
 	printf("Copy M4 image from 0x%lx to TCML 0x%lx\n", addr, (ulong)tcml_addr);
@@ -199,7 +202,8 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 		memcpy((void *)tcml_addr, (void *)addr, tcml_size);
 
 	printf("Start M4 %u\n", core_id);
-	if (sc_pm_cpu_start(-1, core_rsrc, true, tcml_addr) != SC_ERR_NONE)
+	ret = sc_pm_cpu_start(-1, core_rsrc, true, tcml_addr);
+	if (ret)
 		return -EIO;
 
 	printf("bootaux complete\n");
@@ -214,6 +218,7 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 	sc_faddr_t aux_core_ram;
 	u32 size;
 	ulong addr;
+	int ret;
 
 	switch (core_id) {
 	case 0:
@@ -242,20 +247,23 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Power on aux core %d\n", core_id);
 
-	if (sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MODE_ON);
+	if (ret)
+		return ret;
 
 	if (mu_rsrc != SC_R_NONE) {
-		if (sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON) != SC_ERR_NONE)
+		ret = sc_pm_set_resource_power_mode(-1, mu_rsrc, SC_PM_PW_MODE_ON);
+		if (ret)
 			return -EIO;
 	}
 
 	if (core_id == 1) {
 		struct power_domain pd;
 
-		if (sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER, true, false) != SC_ERR_NONE) {
+		ret = sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER, true, false);
+		if (ret) {
 			printf("Error enable clock\n");
-			return -EIO;
+			return ret;
 		}
 
 		if (!imx8_power_domain_lookup_name("audio_sai0", &pd)) {
@@ -286,8 +294,9 @@ int arch_auxiliary_core_up(u32 core_id, ulong boot_private_data)
 
 	printf("Start %s\n", core_id == 0 ? "M4" : "HIFI");
 
-	if (sc_pm_cpu_start(-1, core_rsrc, true, aux_core_ram) != SC_ERR_NONE)
-		return -EIO;
+	ret = sc_pm_cpu_start(-1, core_rsrc, true, aux_core_ram);
+	if (ret)
+		return ret;
 
 	printf("bootaux complete\n");
 	return 0;
@@ -313,7 +322,7 @@ int arch_auxiliary_core_check_up(u32 core_id)
 		return 0;
 	}
 
-	if (sc_pm_get_resource_power_mode(-1, core_rsrc, &power_mode) != SC_ERR_NONE)
+	if (sc_pm_get_resource_power_mode(-1, core_rsrc, &power_mode))
 		return 0;
 
 	if (power_mode != SC_PM_PW_MODE_OFF)
-- 
2.35.3

