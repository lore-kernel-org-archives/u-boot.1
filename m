Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CEDCAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D928329B;
	Tue, 16 Sep 2025 11:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nhT9x/pA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 067E2832AD; Tue, 16 Sep 2025 11:45:31 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCE08329B
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUgBagjUSYZ5AU/hatkiScLOXJ6ATu6KGuv1t4RAu1cXaIKLuZNw3PrYIE4ocxYIBm+I8n4fpY1uigFaGLg6Wxrrx2usCvXI96gysdUE05FE+yy2DA4DXkFKvOdpHSAQNl8kI7VU3YeG7LK0H30jUqDA8/o4feu9qCPntacNxeqSkA56ziirU7pPoxUliBYEI2G6JuGblZJmTlNLXdaUE2AK/qrfgVg3o0GBXGGOt5TZ3K0ZanFmOWxHpjPFgOHY5GhoYMdcxEPfJTPAuvon1cP2I3eTsNME/bJNXodnWWcKLIiMiA1fSAE4arR0kBE8faGhH1UafW4bptVfDciwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMxOlm8IQjqpkwyL1sIUOjN8snfc6lKrDVJ8LKx+3FY=;
 b=Nx1d3ADdnviIdF19BWWVNIx1x1Nbkqcd3Q4n+gnHRiFeqzm609VTi6AyTfEGZwPaqGpz8nPvZtAO98Xtqo+pj8aVJWHMgUhB2lRr3kO7hCKKRxBBmyp1D+3ktbcITBvOeY2wXDTIFHx5ZO0g4qiHf3jU2oV2tyQiCj92a0yAnFtXRaQ3odgdYG3Dj3L+KBtpca+IJJ0XA4r5AkVAMR0M5l4HfstXYswlHfEbTODw2YQjCwsu+kUMhwHSV+MG09VHD5Fwi9X9JMOMRaqm/RSqG9Oi3J2CJvWJM0ZnqHVI/cpZaYk9rPZgucza5gbLpHAN5s/ilnmyJnPKtpUzUv/7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMxOlm8IQjqpkwyL1sIUOjN8snfc6lKrDVJ8LKx+3FY=;
 b=nhT9x/pAS9BsaiaTigwt7eYlCJdcNuJ2pa2IqpxdI8y22vWZ6rehHDnLM6X7IRtBniHvz3DYDrrKZJq7AbX+DcdTv371AhAM9KTxf7joVzhNgRiWfJAGLdomqnEAPvz6HYEWTuvtLKgnq8F37oDwAn8ZeWQ8GQxJ036li/4iKQmPQ7z1R6k59jZDRhMpV7V7kZ4m41Z6T2P2i9XrUHVrdzfIZnLo1/7tV1TYx+a/DHy6u11nITnWqLlk2UpOe3qAghCvFi/AM2pXLdfnnN7/Xjv65rTsxaKm8aGtEIHmnBS9dU+g9vlj3jdnWyLjQ0QrmPYZMwYEIQMtfwMBUIb5zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 03/12] imx95: Add get_reset_reason() to retrieve the LM/system
 last booted/shutdown reasons
Date: Sun,  7 Sep 2025 04:37:33 +0800
Message-ID: <20250906203743.3352805-4-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a0a207-25dd-4151-6069-08ddf505c3c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NxtFz9AQ2W9DRRT5daKCUY94P/mUaCYG7ipRnEkQjy55hx6/Z2c5K4jPymfd?=
 =?us-ascii?Q?dwAw2UKqbzwzu+tON9cr5UwwlxaHKUWarP2FcAAs+gl2BqpvZDukgGnhZ5Hy?=
 =?us-ascii?Q?bH+MTs5XT+7NcQ2SEzCLJQ4NmkmS+iniEjYNNbW5RYgn9f0K4geCP0gsN3/p?=
 =?us-ascii?Q?ZNiSZ2BIpgxxfUM9as/DSHD6p8pkX5vYVIfeWJn78He9JamJefxql5W8oIHz?=
 =?us-ascii?Q?c8K/Shc3l5rxEAr7vahK4OA9OCW6zJbxaZL/mEBcj/ESq0DoGq/o2MBc5epK?=
 =?us-ascii?Q?z5Ht+g0lkDH6O009u6OMDecUnAeC2egm9YOXp6FQ1IJtrFwq0EN3P+ULGMMS?=
 =?us-ascii?Q?+zKVaU42pyuYD1lrvW4WWYbsoL+2PDYkwVRyA/kB8zROOkbJbn6R6KyoLttj?=
 =?us-ascii?Q?TPL1IMUTKdNKl+WKqHtdSxtlyB7vO+vJtiRj7RzXTaVxLMjd+V/hSqXQoZfm?=
 =?us-ascii?Q?M7RuDI73AS3J2dZyVsgZXIIhLhyy2TmdIo9ZVXaMNSWvRl7VC67YsSuI3frD?=
 =?us-ascii?Q?JF8frMOdV6+13Sg2WREoBpuIj6Zg7rtR4OS6u91MtYLpMR5tIfitCv17/WwV?=
 =?us-ascii?Q?wKQmMZS5tUAeqp950hb8xdvmnNDIyXg29ul+7JMBN+/wx9MD3UW665gOfA7w?=
 =?us-ascii?Q?b9PeKyr8svY1HPHzRK8HUMVNeEjw+PjEdZMHbV8Cit7p9ZCiwbxE+0vMOowL?=
 =?us-ascii?Q?QPIr0g6hGnrMnB+XowKRRE2DRokRZDzoaSrzufE6VxR4EZu/RptSlxXXtYV8?=
 =?us-ascii?Q?+yzQB3bct7jeleFMVal7CJL+6ddGsRi3j4bAiI29wa7Tph/eZbvdC8i9cjhF?=
 =?us-ascii?Q?0ShiCv9Ecxoh8FoRoZ5x+Wdq2DFcNAvEhAx8DgndkLihJgVbUClNRNqNbkVv?=
 =?us-ascii?Q?2fGr+Xui03crB/1c6by93Wyi36L6656UJYww3lrOZ0FH6OnkXvgXMRSXYTtT?=
 =?us-ascii?Q?c5HQ0UsGQ8APOzpn9iAtIfRj8JF+R9BXSLD1x0uhXVZebwmaZX0keoi5j6SP?=
 =?us-ascii?Q?LqLmA6aTw4g8sTYgMre9VYAgrOKbQCbqFrsL8GyjnJ4yQqu3BijdYozFr3qm?=
 =?us-ascii?Q?OWHKVUA12/onsqkH0CACOHFJUjPYJa5F9Zl5cE8i0hQh379ul3g9LQI6Ej7m?=
 =?us-ascii?Q?S0svLsCU+y5Q5nyZw2+AFcWk2CP1dg/8Rani+N0I6V+LwyZS/RUBa9Q1yaPr?=
 =?us-ascii?Q?vDPWFh8BOObbZaSSqFhxTfH+GF/GZC30jjYs/24igDejTbPXjqHfRhh3bbNE?=
 =?us-ascii?Q?ecxZi1IPNB7xGt0EDmTU8V7dCk8yMdFvKJUr20UY1fztWraTMsvFH4CE9reh?=
 =?us-ascii?Q?UwwmWlrK0woLysoS4OmYYtVXldcCOpP1iVbQdRIHBxxZx1BfxdyamQjb1HuQ?=
 =?us-ascii?Q?w1A5md5HclHTUIY4pRk3HN2UCh80secG3RGKK0rFCpQV+nV4w0nhm5lFk6RX?=
 =?us-ascii?Q?8AAexEB+OOGJoe1kbVIly8MT65FRC+t4nHeei/7G9MAsPjYDbXvP+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdqySxsYvOESsDevJ+6HOs0lKHG2m2TcegWnNyD8cA7NMvZ/mfdIdyoLEA3Y?=
 =?us-ascii?Q?Fww9LgHDX4GFKfRqEk42Q4bXGDr04aym5WxdGnBQYJqjLCGJXcxw1lbN8sGJ?=
 =?us-ascii?Q?86buvxmspYkHb3IDyYp61hgTe9WbUnTOdcd+hmzzqGt7md9PRXRkqjrGfhJz?=
 =?us-ascii?Q?qvNpUKCJTZDhYttzfa0ZfxY0Ux2gr6yboyDU4++aPM2w4YngXBMtFht5Crj3?=
 =?us-ascii?Q?LjXzy4l6yds5IeL2BP+zpSiOA+bdWKSFAXzExYK2eVzS3G/MgLBxW6sP3ppE?=
 =?us-ascii?Q?EUcCPJAgTK4as9CNQRKu8sXGb0BHgTXJfS/nar5sWgjsa5JzUox8gD08wlfh?=
 =?us-ascii?Q?lrtxsSaWVCaiMBVBsd4KulcE4sRZTr53+42Pjj+kP1tRaRm8fULqFgJSl1l4?=
 =?us-ascii?Q?kaXM+HF0g4OAcmL8RClrzbuPvbeMf5R4M3n354HvQSYh6FAouxNnYpGGcnMN?=
 =?us-ascii?Q?bGnLP9DOxzW8SVqaFn6BSGe48i8I0dr2W2UBdaNcU5ottnevzg0CHg8dgzKm?=
 =?us-ascii?Q?+W0NFa7f5SbYPDkocwS3gtnnwsdRkLExnFDDWRpABUivw8TP48mPTox9eSxt?=
 =?us-ascii?Q?EhN5FBVe17Gn/U6w0cShbrlrupTkDJyewhKn3zBj8Mkfdzu7wj4JVG1Uz8Se?=
 =?us-ascii?Q?LV7TS9Gb8rrQjQw6NafuYazqqCvPVH7sW3pn32Iyj8QYHrOpK5bQ8fBQLgJU?=
 =?us-ascii?Q?PTSefEEWAVZsMXNSjwbmnollnkoMBVbXFC7hS7tyoSRVVVkKdMPurZZvcqJB?=
 =?us-ascii?Q?dvTY4xke9Yl/AJ0YItYoQVDF1/7WxhQTNyimsFfoPMMClf0aZo4asBT0WhBz?=
 =?us-ascii?Q?0SeWQhtbKJ5tevty/yy424RfqYFjeTXutDvAUbDDzA8iGEdjdz4AmBA8K434?=
 =?us-ascii?Q?mMZl01yGJca7ECck+XHRLaFGLCCeDrhsZJujlNPv9VcCUWYmz7Dsok4h8m31?=
 =?us-ascii?Q?JJJ27AXuyLE1CdJnOyKYGAsGt72Wi109CJ3tTRSCEKe7l47VzqIAG5ScdE3H?=
 =?us-ascii?Q?v/Orbu4GIRnwJvqmsSbtxwStIaX4+MrskOoLDpHYmIACCj68MD5wxB1BaBFU?=
 =?us-ascii?Q?IF3zRDqJ11SBnKKRnlKaLS1rhylBlVmT89wjY8D8i7TrFdPbLoky72Dd+r3d?=
 =?us-ascii?Q?T3L+gM5Alex4FuLKGcQE1ASL4T8ikyEcjfZVzv38mnrygkLJGQaf0HLzKJ1x?=
 =?us-ascii?Q?GJNw+IjmXqlDzNqZCu/kWZMKkVEqNhdwKt+dQnvXTIC1pXWp1kRfuE/Ug4QH?=
 =?us-ascii?Q?BUBm7EoyjnFUd5ADB1a45nMuOJz9kTbXU7EheKnSFuMSHkBI9+bJF0o+W1t1?=
 =?us-ascii?Q?VsI33IDQvI7umYsz9P1SutAqRxWpFhccX43FNb1VxWzMdOkhiaRkNjmOD0C1?=
 =?us-ascii?Q?oN1elQYp54FPtHoLnDP8+thpJ9NJcCxbDtGRELgmiQraLG5SiwrlcZJE9Ibv?=
 =?us-ascii?Q?4vw5Yrr4JZ0XFASROkWiv8+Gy9qdcjoUd2aU0oPATR7nhB4bPuz1IcRylGUH?=
 =?us-ascii?Q?PUyRDTUV9Wp0mY7jbGR5BMTRwgdTms/hpfxOSxnmd++6qD2PbzFFdpG10S95?=
 =?us-ascii?Q?jiFAV1J79TJ4HtYSKmMAsuPDT0uwNb1Uie4OY60M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a0a207-25dd-4151-6069-08ddf505c3c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:26.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ki1AVPSwtCUvMN2YY23YzxmL9BiRE5uJXIzZs4KhVGicUXlWVCevHWZz7b191qgz75o2QfGYbb+H+Zv7+4PWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

System Manager provides the last booted and shutdown reasons of the
logical machines (LM) and system using the SCMI misc protocol (Protocol
ID: 0x84, Message ID: 0xA). This path adds get_reset_reason() to query
and print these reasons in SPL and U-Boot.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/mach-imx/imx9/scmi/soc.c          | 110 +++++++++++++++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 include/scmi_nxp_protocols.h               |  55 +++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 include/scmi_nxp_protocols.h

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 455aa95339e..dead7a99a66 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -21,6 +21,7 @@ int m33_prepare(void);
 int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+int get_reset_reason(bool sys, bool lm);
 
 #define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
 
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f973652d0cb..f04b9255cdb 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -17,8 +17,10 @@
 #include <env_internal.h>
 #include <fuse.h>
 #include <imx_thermal.h>
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
+#include <scmi_nxp_protocols.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -468,6 +470,114 @@ err:
 	printf("%s: fuse read err: %d\n", __func__, ret);
 }
 
+static char *rst_string[32] = {
+	"cm33_lockup",
+	"cm33_swreq",
+	"cm7_lockup",
+	"cm7_swreq",
+	"fccu",
+	"jtag_sw",
+	"ele",
+	"tempsense",
+	"wdog1",
+	"wdog2",
+	"wdog3",
+	"wdog4",
+	"wdog5",
+	"jtag",
+	"cm33_exc",
+	"bbm",
+	"sw",
+	"sm_err", "fusa_sreco", "pmic", "unused", "unused", "unused",
+	"unused", "unused", "unused", "unused", "unused", "unused",
+	"unused", "unused",
+	"por"
+};
+
+int get_reset_reason(bool sys, bool lm)
+{
+	struct scmi_imx_misc_reset_reason_in in = {
+		.flags = MISC_REASON_FLAG_SYSTEM,
+	};
+
+	struct scmi_imx_misc_reset_reason_out out = { 0 };
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_IMX_MISC_RESET_REASON,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	if (sys) {
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for SYS\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("SYS Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("SYS shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	if (lm) {
+		in.flags = 0;
+		memset(&out, 0, sizeof(struct scmi_imx_misc_reset_reason_out));
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (out.status) {
+			printf("%s:%d for LM\n", __func__, out.status);
+			return ret;
+		}
+
+		if (out.bootflags & MISC_BOOT_FLAG_VLD) {
+			printf("LM Boot reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_BOOT_FLAG_REASON],
+			       out.bootflags & MISC_BOOT_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_BOOT_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_BOOT_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+
+		if (out.shutdownflags & MISC_SHUTDOWN_FLAG_VLD) {
+			printf("LM shutdown reason: %s, origin: %ld, errid: %ld\n",
+			       rst_string[out.bootflags & MISC_SHUTDOWN_FLAG_REASON],
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ORG_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ORIGIN, out.bootflags) : -1,
+			       out.bootflags & MISC_SHUTDOWN_FLAG_ERR_VLD ?
+			       FIELD_GET(MISC_SHUTDOWN_FLAG_ERR_ID, out.bootflags) : -1
+			       );
+		}
+	}
+
+	return 0;
+}
+
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 08f4da0bb73..3d64097b4c7 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -5,6 +5,7 @@
 
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/sections.h>
 #include <hang.h>
@@ -65,5 +66,7 @@ void board_init_f(ulong dummy)
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
 	debug("LC: 0x%x\n", gd->arch.lifecycle);
 
+	get_reset_reason(true, false);
+
 	board_init_r(NULL, 0);
 }
diff --git a/include/scmi_nxp_protocols.h b/include/scmi_nxp_protocols.h
new file mode 100644
index 00000000000..fe6ecd6a7cf
--- /dev/null
+++ b/include/scmi_nxp_protocols.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_NXP_PROTOCOLS_H
+#define _SCMI_NXP_PROTOCOLS_H
+
+#include <asm/types.h>
+#include <linux/bitops.h>
+
+enum scmi_imx_protocol {
+	SCMI_IMX_PROTOCOL_ID_MISC = 0x84,
+};
+
+#define SCMI_PAYLOAD_LEN	100
+
+#define SCMI_ARRAY(X, Y)	((SCMI_PAYLOAD_LEN - (X)) / sizeof(Y))
+
+#define SCMI_IMX_MISC_RESET_REASON	0xA
+
+struct scmi_imx_misc_reset_reason_in {
+#define MISC_REASON_FLAG_SYSTEM		BIT(0)
+	u32 flags;
+};
+
+struct scmi_imx_misc_reset_reason_out {
+	s32 status;
+	/* Boot reason flags */
+#define MISC_BOOT_FLAG_VLD	BIT(31)
+#define MISC_BOOT_FLAG_ORG_VLD	BIT(28)
+#define MISC_BOOT_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_BOOT_FLAG_O_SHIFT	24
+#define MISC_BOOT_FLAG_ERR_VLD	BIT(23)
+#define MISC_BOOT_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_BOOT_FLAG_E_SHIFT	8
+#define MISC_BOOT_FLAG_REASON	GENMASK(7, 0)
+	u32 bootflags;
+	/* Shutdown reason flags */
+#define MISC_SHUTDOWN_FLAG_VLD		BIT(31)
+#define MISC_SHUTDOWN_FLAG_EXT_LEN	GENMASK(30, 29)
+#define MISC_SHUTDOWN_FLAG_ORG_VLD	BIT(28)
+#define MISC_SHUTDOWN_FLAG_ORIGIN	GENMASK(27, 24)
+#define MISC_SHUTDOWN_FLAG_O_SHIFT	24
+#define MISC_SHUTDOWN_FLAG_ERR_VLD	BIT(23)
+#define MISC_SHUTDOWN_FLAG_ERR_ID	GENMASK(22, 8)
+#define MISC_SHUTDOWN_FLAG_E_SHIFT	8
+#define MISC_SHUTDOWN_FLAG_REASON	GENMASK(7, 0)
+	u32 shutdownflags;
+	/* Array of extended info words */
+#define MISC_MAX_EXTINFO	SCMI_ARRAY(16, u32)
+	u32 extInfo[MISC_MAX_EXTINFO];
+};
+
+#endif
-- 
2.43.0

