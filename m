Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C920D3E194
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 23:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F73D88E75;
	Sat, 19 Oct 2024 01:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rOLCVIT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E6488E0F; Sat, 19 Oct 2024 01:47:53 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1B188E77
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 01:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Df0ggOVXqnruZbjRKLIx0LTsFgi5KvNaZ9VJcvOh2+yInOFdw7leMbhMpYtOkUF44qZxBiKrz7EBuQk0uhLQtb7orroxjUHjpV+iaJnd0ss1PhFSfVN2aqsYa9jp7FQsuYZMo7A7SGFL46K1d/nKLdAGfPSZgUbIItVSswFgnVjtYztELHsVNGXbUp6yBXzdPuLbIsstIu+OJwTQUa5/EdhBbaO2AsZ7wWStLuPFFui9je0F2zJechXZPacL8Iu9El0/IcBj8WiDU/C8Yf2t9fwjaaNzCLoJdb2+61jAFKKgCglgqGOdye7mdU7nya2tN12yIyHgDHvr4tTUtvBcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw6yr9MN62tpdT+hmVnjZzmO80OGGcCpzbr/hXUCRzo=;
 b=mLvm2No0EvDO2ed3Z6WXkDmefhqS21xpxNJqpV3t9b89T20iEtyPZwbrsJYgtpOqAQovV/Q4TwBKrJOangQcVmzG8wgN5+XTcDSs3RztmvAAFzEIPfg5PjwxR4LKKGp+8ErH7tUvX8oGZnA/fFZ3HaP4uc+cwbOhiST0BcP8bh/WmBrXeEcoH0KC8LMawmxVzk70gB9IfQfTR9tdiI3zv6WfP4ExElynXzBl/gZd5pSdAzicZMmj3esYovHeP9+rVAzkxsOokQfTxdoTSCYPSkhElbnml3VhMCRK048stMJcjjd1P/OeJ1qYrUBfHdeQ7RVio+XMaTawWInt21/kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw6yr9MN62tpdT+hmVnjZzmO80OGGcCpzbr/hXUCRzo=;
 b=rOLCVIT8Pf6qt10S6pVcicejfe5mlijWFoVhj6euHKMR2zYx3A0L2DPMcP1gJFZ6sCPIZ+VjDwT5kK9kanyXpf1VSB5FyvActZluBQHao9WcNyu3EIurOZSHyxNjwBZxkGeoeZWElGHW56uVN3MDs2eP04yV+AGKP6yx8ZGcQdu+gmNCB/X1Unl7YLEQiTp6DTpswQH7B1QgL7+6d1YMFMvyiYrofRNKLmdUSUQMUWPASGc4b0LazCSB38LW01etc1p66W0eV6iOILSLeCqL8i1PZN1xGYBQ90/vouR0QiC4F+b4qsPfqD3tbPS2MO+IyYSYgoOD7B9tnReeRWxVYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 23:47:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 23:47:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm: dts: imx8qm-mek: fix boot
Date: Sat, 19 Oct 2024 08:51:25 +0800
Message-Id: <20241019005125.4165-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241019005125.4165-1-peng.fan@oss.nxp.com>
References: <20241019005125.4165-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb60a6f-8811-4cc9-b893-08dcefcf45b6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6f7XymsVAOBzPln0qTak02oWSb1kL0mZdHE/NKCe0bG2FGvNlUKNY39+W8X?=
 =?us-ascii?Q?9jSoa9Rjztuwpgjb3ggGbQxUkrK/Sm+b/Gx0AkB+OgATj97e/kWt++U96GXU?=
 =?us-ascii?Q?5tyL4+VoinWqcGMvLK5ne2nX1D+K9x+OdLql59Kt+QcAmT+dE4T29Hq30XjC?=
 =?us-ascii?Q?tE+3X9+Z42isq0LbdWyexrcNNm19TF722I+GC5mND1e1jKll2fbIU3eE1L7U?=
 =?us-ascii?Q?l3QvOQ2IUa6KGdyLS/6+Ay8dHgyK2feg9pyESzw9IjsNXLUAIVm0cMJw2aND?=
 =?us-ascii?Q?1qzBSREBwww/gWzvAynOnXLZxpQAuuiidHTQjqaeJ+IMCITFEtJLgwim1PWI?=
 =?us-ascii?Q?DwEc64/tc6eyizFMq4jdFzaob1CLPxPWxxOzIknPBxIx/GpWJD7mw0N7SivP?=
 =?us-ascii?Q?fi/VZEOQ8ODTShT/00hztebhE4I/oVNjyU0mBHrqFKF9ybGjKUwaPSELKlI4?=
 =?us-ascii?Q?GoZb1bekvtkT3DVBQYInFLXlsvOtGuE7z5LL/oSZRscNx9UWCpELhBB98CHk?=
 =?us-ascii?Q?MvJVrNdkAe25APgGH6cW8FqIA8Dy0U2bXojNKogQe4qmD634L/gyEzfp2NIw?=
 =?us-ascii?Q?y0DYY3T4qn8r3fzorok4SpVrZPic9CjPzDWsNwCwcWSnbJA1WCUY+z/s5Coc?=
 =?us-ascii?Q?JEZdtBXz3w/8CXx5/VrkZV3oi+EYSp+v1JHNoamkNk5qAJOqJSNGlS7MxWqO?=
 =?us-ascii?Q?/8ttiov/iVwo5/X3hNtQjDnT5qO4VvVpn0Eo8lwJC2fXCS+3UH1AisbmjX07?=
 =?us-ascii?Q?UC3yOpvEgWPyUtcumUkzAfjwd7vc8IGaHf+rpQELxi0hVHfAF75CXKT5O4/N?=
 =?us-ascii?Q?bKbHfE1UFAUr4BvDXHSCK8xAJ84P58RxlCZQ9hxDoXQeNn4O9UPSu8J4pJ0S?=
 =?us-ascii?Q?XcmjdpZzXCSdPcPcc0GH2O3CBBoSEc/b9yPIHubQMxFOIMRFNqsqTHcExGEU?=
 =?us-ascii?Q?ir7AeEocETZe65XItt2UM/P9RfsYVVKnngD1gr96lqmguZNLRVUdyCnwufMM?=
 =?us-ascii?Q?m0ftc+3ulpYXGhQxU4PpD7OWXhrI8Iq8JVKcyKHP5HkZPmck4QtOPsUUcsWV?=
 =?us-ascii?Q?RK8dqdSohxGsRjiHpCuSt3oJWyxy0JeZ0a8pYBfdE++MxJteWI5eIgTSWDLX?=
 =?us-ascii?Q?+iM+ngM7TigBlBxwHXOmXHyMEWC63vI9RTRFqwsGBw8xAG+zTyPhWPALBhys?=
 =?us-ascii?Q?f9keIgZGOLSCxer6K4SBvCr1+ZTAFcwlJxMwedCi1ape5pcvt0hbw1KBzVwW?=
 =?us-ascii?Q?xUk2BZ9Rq+HQb55eanKRryCuAcdrgY7QqzgznsXfKAe5Lvv5YMLMBNFGxCu5?=
 =?us-ascii?Q?swY0U2HcbKz004ZVvWPfInXYNKp8UDwu4IzIrUwc1jbtR7vE4o1RREJWThxE?=
 =?us-ascii?Q?aFWf8RE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ibT9B0RegdgXnsjLtWia9cgthw2YUaIfGvgl51HMuVXo7JqcTIaHQDFBHVlk?=
 =?us-ascii?Q?E298vBmFQupuwoioPLkinzaqA7gafRVTz2e5mNPwx2X7F/Y7iF7pMpWaf9pV?=
 =?us-ascii?Q?fqwSJSdmA21oV/+X8FUO1uObSOHg1Ab11rS9P2tWu8qy4dQe3LchIIf+mFDO?=
 =?us-ascii?Q?rmDkZ5fO2jKZLsggloNB0fJU6wkz3HUv4YoYlrBCdh7cNDGKM9FBzH0w7MjT?=
 =?us-ascii?Q?DPOOqV1rBy7EyPIX1IENp7WHTGiR4tax9R9ojHn5c7n+nWuKyuWCYCj5fGpE?=
 =?us-ascii?Q?5YWnvJ5F7eA67wo+rP6V+3ot1Alcg9SKGMGYvHsMHdQSJUsT77MjyUpI+oyd?=
 =?us-ascii?Q?/0b9j6nBuQ2ncQfVca/MdTGwX21jlgPiqmMu8KXYwTbKX9HNDsYG3O2X54gS?=
 =?us-ascii?Q?1HZhoOchG2w2jQsyxHqD63jkpRa/r6tiOSs5T0EEzTNQFPO1JZZQxw4sc7xo?=
 =?us-ascii?Q?tNp/zGld9mXp5VGkldfL2wcF5Ev50rcghZsgctpC8TcQbE/a1kgQbsHnVIlu?=
 =?us-ascii?Q?vg6JuQ6jSnrPr+rwrgF42Sjic2h6VUEAbxcLYV8Gdd6kKjV+c7ISI7YFlIoa?=
 =?us-ascii?Q?ZHtpqSubMzL9i5VzTeS5jJICur/TTJdGPaYyY08zGbYqDvOvsdCmNgDBeOa5?=
 =?us-ascii?Q?+w1hLX56KKZlMSn/c37KsNIEeybGh66NJvwWyi91Lhg2uEdsMhV6bs+4dELa?=
 =?us-ascii?Q?S+r0PspvJEmkbbOQ+qtALFQrOtvhsFoQlLnHzr9a1F78GGnpZvgy5o2VDahX?=
 =?us-ascii?Q?cHj2uie/yMswAlzCLPpyExB04r+7Iy1yUpzW2xRGsPu2GATBcHRY5OBpp6Oo?=
 =?us-ascii?Q?zY6/g8e5nqh0m85bizHOdgwroxXZ/bpJGYFIahcvlJRWhuIOXucVJ7Vg0+HE?=
 =?us-ascii?Q?gVhVsG6uTpGsCRoQr97ZZD79juLe4RUJ3Pf7+/cB0U8NmoKgZl4BtFnpisgl?=
 =?us-ascii?Q?bm5LX7QeW1R05SzqF14NcDUtfRH23U3A7y3PI0M7DGDiNdns6MYQL2XePkW+?=
 =?us-ascii?Q?1kPK6PmY7p3Hv445R/Q+4oHADxWV67FCRXaZmX3bFGkGr603OAZBNjUhXviW?=
 =?us-ascii?Q?OfUL9zmvGWV8dSqSZvGgleIYRmkusW02x/YYEUH7QKs4XNyr09gC5g+8o7qq?=
 =?us-ascii?Q?p0pYpWv1FFHzncWYRq/HqCSJXXGyud8wmJ7u7Ox3LgcfXpzV23rMRYFrUo1Z?=
 =?us-ascii?Q?0aNO0Y3dGlUVAEdtGkHYkHe47fBuimKZMW+IaR5qQI86AGsfsrc6ozzDeTsR?=
 =?us-ascii?Q?h5jbCO0zhDwq2G6n+lFXc9EmnX7wjPN6EyJo5ikP07DVqNPVgq7u7kN+4vHW?=
 =?us-ascii?Q?p7TmcuVgqvUGEGGfBICf6QCnZKQxDmWVlqvb9M6ocC7FFilRwrTrTB7FDSmt?=
 =?us-ascii?Q?3sESx7kjbBD6k/e57HQ0uRrAxYDnX9KQ2kJ6HS+qSi2MQNBGYSdt2b3I/S+B?=
 =?us-ascii?Q?hz4aBjmOhlRlwZTaal65qZzYQkJo1+Xbwyyn2qJckOJDcHLau8XEeQj+8jfk?=
 =?us-ascii?Q?RVtrCDZy6Qv13tM4T6NQ4Apoe54YJBpd8LFbxD+H3OOe9PsJTZ6WSMbx/0Rs?=
 =?us-ascii?Q?XtbdC3hWJmUVKUSX1+taX5uqrn943urySaKAex+d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb60a6f-8811-4cc9-b893-08dcefcf45b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:47:48.8474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4ochV1TgnodUpsbYILe1YTkKEkzNW4dOw9WtAaVZAJsBZQdfmURbvSd7X0BEk84gzRaU+kWBQY3oG36kLIR6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10073
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

serial_init runs into panic because no serial device found.
Update the device tree to include bootph-some-ram for some critial
devices needed in pre-reloc stage

Also update usdhc related properties to avoid card initialization
failure.

Fixes: 8c103c33fb1 ("dm: dts: Convert driver model tags to use new schema")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

CI: passed

 arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi | 33 +++++++++++++++++++++++++
 arch/arm/dts/fsl-imx8qm-mek.dts         |  1 -
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi b/arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi
index 6e5379e53c5..38925d53065 100644
--- a/arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qm-mek-u-boot.dtsi
@@ -7,18 +7,48 @@
 
 &{/imx8qm-pm} {
 
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &mu {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &clk {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &iomuxc {
+	bootph-some-ram;
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&{/mu@5d1c0000/iomuxc/imx8qm-mek} {
+	bootph-some-ram;
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpuart0 {
+	bootph-some-ram;
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
 	bootph-pre-ram;
 };
 
@@ -75,10 +105,12 @@
 };
 
 &pd_dma {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
 &pd_dma_lpuart0 {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
@@ -131,6 +163,7 @@
 };
 
 &lpuart0 {
+	bootph-some-ram;
 	bootph-pre-ram;
 };
 
diff --git a/arch/arm/dts/fsl-imx8qm-mek.dts b/arch/arm/dts/fsl-imx8qm-mek.dts
index 63908ba6bf1..6cf7ce3d5e0 100644
--- a/arch/arm/dts/fsl-imx8qm-mek.dts
+++ b/arch/arm/dts/fsl-imx8qm-mek.dts
@@ -6,7 +6,6 @@
 /dts-v1/;
 
 #include "fsl-imx8qm.dtsi"
-#include "fsl-imx8qm-mek-u-boot.dtsi"
 
 / {
 	model = "Freescale i.MX8QM MEK";
-- 
2.35.3

