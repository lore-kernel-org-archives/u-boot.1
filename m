Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C3CE9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC96783FA7;
	Mon,  2 Mar 2026 14:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mh90h1aU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D02883E63; Mon,  2 Mar 2026 07:42:04 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538DB83D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuRDh2YnyRxdfQtxs/34GdJ8wBoqjZh2dwV4cyQyg+cEbRAUHTF2fwL+I9I8qwptS12EOr4HV1ddPX7gBsjij3s5PO5+I+EbQ+XB5NEqU63mFZ4wCai/q2IdlVNpKlkUBxjQQ3AT1YX5DB/ldeUM5EP2se9rqQP1ch6/qn/5qPNRtcVPT0MFSX0fjdLWRXXdZ63V+nZSIh/eTw0t6uJmjZ6KOi+M/ffpPaHMwleaJFWL8ea3hB1t/bYAUwRZiKTnXbzj4ehMkbOTntUVUCyNpfygu7W/T7jl/lof2w3w3VvIoVnqTovtggdlIzzEAviykMqe+LiTIgrloqjtS/QqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXW4xpA/wNBjcE752buhS33F2eFqzQ+O6Hct+glLEP4=;
 b=OVhiInwj0isVAM4h9scJ8nhz00nNqy8rBr2V4r/dfsE1kg2zXIBqbLyiIuD5WoiipErte89blr+Dji1OgL6fLKrnd9vgSyp3YGvWDcPT3+vbkPd8WmbZUZtHCWe1VkMUMg01h85+83J5ds7ZqoywWjxgtbYNoWwKBCTey7z1TXHjL7mLIBf0xu3510V3RuZF7bs4KLgcnYQaZh5BMMfJH+KcV2FyoVBdXz1SIgoXkrQx09Paj0Kx48M0+72hVkHQ9qn8g0kru+XfQh8jFDK8r0HVvdoHIiz4vh7OvSeo7ngf9NbMxEL0oQV6y8GQMS6XMlkUTL91goz1ySA3vCUv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXW4xpA/wNBjcE752buhS33F2eFqzQ+O6Hct+glLEP4=;
 b=Mh90h1aULU+0dJG7BJkqiRZDRL/B46XDu4VUyEkrEVoEuo69yuO+iLPeqEGo784BeWAeXmY6AMdTIR9UHtIYvpExeNEk0bt2avacLsnPVHdEQiOSKxl1IVTZpqqv/Vbar5VXPTgbbJKGeKC8LOb4jUSEtMJ0SfVSmdAeMwNrje3tMdr5f+2czx31P2lsVqZJKn5OvaeGZqmY005eMAgpDOgW8OKJ8S+JiHt9c7cgcBWM47xqIrZAKZ5Ijny8WQA8aKF6sPXLyHItg1rdCxXh7iWBDbnMCGpu4ZdLJINgyq+DLWc02sJRJYGIFZnWlQP0uqmk50KjNOxOo82mrruzHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:41:59 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:41:59 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:13 +0800
Subject: [PATCH v3 12/13] arm: dts: Add U-Boot device tree for i.MX952 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-12-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: bb09409a-4e5d-4ac1-5c37-08de7826cdb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: sgvrU53kqebzoN2CKqrzqNh0F14Mt4BeAI3kbg+j+qklNj9Ht9lFIuwGw3buHex1x9lhqhRtnNarMX0QQwLDyEkgy0ztzqYd5cScLQwqBsMij6makp1/L6KcGNjsTrHqSXu5OMr23CBj7YJ6JCXPz6BPEjVng/R0sez30p5XrCIkPhjvfGI/xhfg0LUkUAa+eeuSrnqMWRJTBejeOZlS/HRcWs1IOSpUWW8O4BxrxvmhGObJtD3d9gE2o0DB0o+IjB5NDoN2XLe4/Up1NddPzJI9PgXraSrT28K6elgT9liQr7Q1dB6eRrW6KMVtWHbqmXcbRzkT/ZiP0HSmwWE6PA70+O3qkVNza7JMz+uGD6DkLJFr6mxNpnNGv5vRsvHCMgdOyh9ljyAjwY6pN5/26bDFufWOQllS34TTukTbFCaI0a4/dPyd6Y4PHg05AvYYyhrML1hsM8iYs+wL7RCqUOy6bP31p067V47nbWF/1knxpPrjYhIW5KIGThSzMWQOq9u8ARr0MMZkp/ZH940vZC8pihLGPQU2S4IB5bkDJ8gazYPzAM6PR7dNQGYZ8edNBzda+mQgquu0IoN2tSLGJ7vHes2qGibDbM38RZZkj5j5m1mMmLooeGJZYBl7mfmc7RszYbCK/51+9qq7kMa4FiaVKxkFyA08IVfRlq8CNUBP++IwGRBZTnLMJRs678yKkMpoAEPwbH5Y/+xIt7FqU4Qbud8sp6tbrCv7FOIJQU0dJarUS+pFHFNdhkEoau59q1I2mp6WLbSGkpCbAjhU0oJY9Wi+GBf+L1ajQOxjcio=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmt6TTh6amQ1S2lScWxrQ2RHYlZ6dDA3ald4S21STXFNNTFGZTFWYTZRcmRQ?=
 =?utf-8?B?M2FZS2lzN29OMEpua3NSeWNxaG12Rkl3d0huWkZBcHdzV1NYaGs5YisvZS83?=
 =?utf-8?B?VkdDZWI1R1JEZE5ySWxJc1l2VGZvSmF0TlNwcEZlZEk1ZTJ3bU9yeUZBd3pT?=
 =?utf-8?B?UUJmVHJ0YkY4bVpsZlJiU3VDdWRWS2llbWViRE1ReGpuMDlPMG14OWluMTRM?=
 =?utf-8?B?VGVkTEF5SndOYlNJWFpqUFd4SGV3bS9RVlNLbFFwMzNHeGxxSFhXZ2VVSytQ?=
 =?utf-8?B?TTJodGhNS2hvR2dMT1A4SWdNcU5Wbmw2cmZwRmFzSUhqeThRcjBGSjNkcFJR?=
 =?utf-8?B?TVoveEhzVlpjYWtxam56b3luQjJ5dXIvemlacUVmc2ZEU29EZEpkZXNxOU51?=
 =?utf-8?B?RnVBNkVoTG9wZmdXaHRYaHhVaGVwUy8rdEVoZWZyZUNoeE02dk9OdkppaS9T?=
 =?utf-8?B?akYxdTlkanczQ0pyRlF1aVJTb3JkNEhxQ0dhUng5Wm9mQk1JQ01SV2VJdUZE?=
 =?utf-8?B?aVhlSlYxOFVjaXpIODlIWnlYand4ZmdIZS9NSDltaXg5LzY2ZHNrVkx3TTc4?=
 =?utf-8?B?OGc0aS9NNjVDY09BTlU0YU55TE50Y2hza1lVRGc3T3QxdzQvNGdXU0N2Umwv?=
 =?utf-8?B?aWI1Sm94cnNmdW55ZzU5SHRrdkNsaGpqQllwYUgyS3l1eFU2NDNhMVBtUXB3?=
 =?utf-8?B?ZURnZS9zbDBDYVhPd1NOaHhRRzZOOW55UW85b1l0c2oyRlcyVUc0UFJETm9Z?=
 =?utf-8?B?dGd3MHNVUTVMQzB5OW9UK09ibGpJVWhVWC9kZkZyMWdiS0szY3o1a3RyY0RI?=
 =?utf-8?B?Tk9WY3g1U0RBKy9kbmR5S3p0a0VuRDhvSEtMUXVPNDJIR1VKMU1SOElJemRL?=
 =?utf-8?B?a2d1ZUF2ZDl6dFhrSHRLbmo3cU1TdElJN0g0SXNub0FEa29iR0V4d3hzdllW?=
 =?utf-8?B?WGlOUXo0QWFGQmdnUU84V3ZXd21PcnpKZnlJaithVW82djRQWFdLK3BEQi9o?=
 =?utf-8?B?TE9jNnpWeFc4ek01MW12UWtyU1FwaXo4QjNwckJLOVFhNGR0RlFuS1FOcWJ0?=
 =?utf-8?B?ZTllZDdkU0FZZm5nUlpaaXFLeVgzQmlSTkdCS3htdXdudldma3FyeTRmS0F0?=
 =?utf-8?B?Si9IdFNDSnBNTkhRdUh6SkNSM2tybHFOdzRwRWxteGNkbU5XaG1QMTNFK25j?=
 =?utf-8?B?Q2piOWVURnIwWE1kUFA3aHMxRjBxdjhmdXlDQUgzeUpMTzdjSlUyYlZuYWRk?=
 =?utf-8?B?UlJyMmkydktKY04yUTdmVHZlVUxmUk9vVlJXRW0veW11U1daa2pYdVBwYTdR?=
 =?utf-8?B?S3ZsNlZYSnlUaWJDOWZpbEpESXY4cUJPaVZUMUd3TEdwZnphRTB6QlR1dUNZ?=
 =?utf-8?B?TUloRnB3VnkxaGphMVJGSVd4U0E1LzRnY3JlTnFzbFNrdXRQRzYyWFlRaE0r?=
 =?utf-8?B?eEFiUGxxM2d1VFZXVUdLUEpHMUFER3h5Si9XZzh5QkpPYnNMeHZBUmdpRGhN?=
 =?utf-8?B?SHpFZGU0cytEOG1rMzZ6VkVKbXRwVGNlUzBoQzlHWng2TFgrVDJ4SzRzemNU?=
 =?utf-8?B?WXIvZzdNbFBDd2lOTDRxS21qVkM2VGlYRjhQZ0ZiYkh4cE45Nk9iV210K25W?=
 =?utf-8?B?SS9uY1NsZDFIektKdkNMT3pRdm94dUloeWxzTW5tQ056bTlSZmljNDQwWG1a?=
 =?utf-8?B?R2Ezb2lEdW5jbVh1NnpuRHI4VlBYNXlKNklVajF1a25WVDVWTkd6RW05Qk9P?=
 =?utf-8?B?cUJRSXZFT3Yxc3lmeUFQR1UrUWhab3I3YStHOUVtTjlxdzg0SlVJR0NjK0ox?=
 =?utf-8?B?SkhBbUpTU3loL24vOEdnZFJYTjNQRWdTZlVZajBsWCtCZ1pOM1d2Yk9HdytM?=
 =?utf-8?B?UG5PNUdmZW1yV2RnYnFPVmtWNUdGQXZuR1EwbmFGdldLd0lMODFjSHNkMFI5?=
 =?utf-8?B?ckhuQVNjenJjWjVZZkJ2S3BhUW5iZ0F2Qlo4ZGxjdXlQTzhmcmFOVXljOEF3?=
 =?utf-8?B?UUJtWjVIaUx1Tis1M3VzNjBPSUI0ekgwakx5U1pueUlkZFJJSnFPTXk1MEtw?=
 =?utf-8?B?ZEVteUM0eEJxczFvN2RWUGx3T25UdDlKY0NnYVZBRjc0RDIxUEY4dzhDZ0o2?=
 =?utf-8?B?ajMyVlZCTFBTSktHZ3JGekNUdXA5eVY4QmwraVFNZG9LMnpvM3MyN0R5UWs1?=
 =?utf-8?B?OFllOWhkR2FoSG9BczYvK1I4SWFXbXRDekdwTk5wRkJ5cW9ON0Q5ZE5SVGcy?=
 =?utf-8?B?QWZReStQUDJOeXNqengwOEtmZm9TNXFyNzdoYUNUdytneXB4Z0lWeWF5SHlk?=
 =?utf-8?B?TmNJTlFsM0tGVWtzVXJ4c0dCeTRKYm9qck5UMnFsd0xpTnQwS083Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb09409a-4e5d-4ac1-5c37-08de7826cdb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:41:59.0552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDnVPWcmJBJ66OdFexJ83nmnd2OGU4rB8UTl/uQdCq7dXxdgNPrFLyeCZSt4Y9ynbCFVinOwSMRos7SxcSM5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Add U-Boot specific device tree configuration for i.MX952 EVK board.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx952-evk-u-boot.dtsi |  10 ++
 arch/arm/dts/imx952-u-boot.dtsi     | 290 ++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)

diff --git a/arch/arm/dts/imx952-evk-u-boot.dtsi b/arch/arm/dts/imx952-evk-u-boot.dtsi
new file mode 100644
index 00000000000..b872c3a7273
--- /dev/null
+++ b/arch/arm/dts/imx952-evk-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx952-u-boot.dtsi"
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
new file mode 100644
index 00000000000..e977014992e
--- /dev/null
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr4x_imem_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr4x_dmem_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr4x_imem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr4x_dmem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx952a0-ahab-container.img";
+				container;
+				dummy-ddr;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyLP0,115200 earlycon";
+	};
+};
+
+&A55_0 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_1 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_2 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_3 {
+	clocks = <&scmi_clk IMX952_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&clk_dummy {
+	bootph-all;
+};
+
+&clk_osc_24m {
+	bootph-all;
+};
+
+&elemu1 {
+	status = "okay";
+	bootph-all;
+};
+
+&elemu3 {
+	status = "okay";
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@15} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+	/*
+	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
+	 * is assigned to M7, disable gpio2 here
+	 */
+	status = "disabled";
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	reg = <0x0 0x400>;
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&scmi_iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		bootph-pre-ram;
+
+		fsl,pins = <
+			IMX952_PAD_XSPI1_SS1_B__WAKEUPMIX_TOP_GPIO5_IO_11	0x3fe
+			IMX952_PAD_GPIO_IO12__WAKEUPMIX_TOP_TPM3_CH2		0x51e
+			IMX952_PAD_CCM_CLKO1__WAKEUPMIX_TOP_GPIO3_IO_26		0x3fe
+			IMX952_PAD_CCM_CLKO2__WAKEUPMIX_TOP_GPIO3_IO_27		0x3fe
+		>;
+	};
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};

-- 
2.43.0

