Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A4BC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6139180F0A;
	Tue, 18 Feb 2025 13:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DZV44cUF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E4380F5F; Tue, 18 Feb 2025 13:06:53 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994818043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP2C1raevgNqnFnjoH4sXPJnKNONqBELcCdwg6GfoAdjzu7QWp02l5+maQeZAG5AkM6eYV6s4Amsln59/+sLkyv31cC2vinnHqWIpzetGBFwPiAkc85XlES4AFA8ZnHUms+ZarpIKB7gyFg0rPhkSp/lv9VrhdGVN2EGSkGNu57hjvEkHEZV4f0TUKZdh6+tTgNrFWnLEZrsz0h3jSiaJBAMz5y6xGJVcDotjhtmd0O2Nv1Q+SGoa0SQGZTvdaimP24BTI4ZXhDfc4/wiY71VRp6BRGECcnYyO9ApV6jodFA7dfJE2EL20OtnHDcAAH8qOGb7BuD38fifUfJ/gmSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUgpYSb8FEQ/Xk0+ll4F+GC3f+IKvpBAz8Cq/zKAehw=;
 b=jyREnxx7xabMstGnSFnkfvl5b4oPOwUt149WJsx3+Y0zVJd8feKvzozKFLeSYIijoWtWr0KtZWELzMSzLGTd1NRUf8qh5HOgrm3HNn/nLOdvi2USjPtlw+3M99hATUEf3RIcGtnsbvQImifmNHuxjN7XMV/oVBTD5dCVMeCQYg/BFLYdDrnOglege/Da+KE50K37cfMPQuwArPsWhhMs5yQzwgpUykNz+Fgis4Tri8VJjpwc7CNGmPnaAdgVLu2xuqvHIqjtp0LC0W0AGQdKTqdF2MeYj57oIeCwd3Btq+ru3V6/GPLoiWMqT9GIPxkTrdlzRiwS1qxRohcq7YnhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUgpYSb8FEQ/Xk0+ll4F+GC3f+IKvpBAz8Cq/zKAehw=;
 b=DZV44cUFQWPudzONrfCKEzTiLZd8exO/UEXJfmavFH84XvNuvrSa1tEasX/2huG1jLiCBea5yN4SVcultf1oKF2IfZ5JIC3fMT8Wv13aEG/4wZ9oQEfQU3h6YcJHx5S2flpdWtB2lwXQYS9Wg1BlsKKS7ESaRCBayt3GS1xtPVemazs2gWPpG8YrsAGoKgpezvyTG2pQT0//1NPkq9vknr2W2iMXon98qGD8JQdHLw3Cv84lNeSU21EX+ZTNIsgP3I1IP404Afb1O5/sFak2FGSPxHn6YSXHZ8biA4dz+Me8TIvmP78TJ3BW4ETB52CZV2xnUrR5EEEMAHfrV+A2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:06:50 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:06:50 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 02/20] firmware: scmi: smt: Interrupt communication enable
Date: Tue, 18 Feb 2025 20:05:39 +0800
Message-ID: <20250218120559.451678-3-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe000b3-d74c-4833-bdc3-08dd5014b99c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DfeyiHooi//bT3o7FN1t9bRYECiAXeJXMvHMlwx6JdUBubLFXV4/fu5H0rN+?=
 =?us-ascii?Q?qeFzoFhhBpSg6Cob5pWp4CyJnyvKLG3wLCSSonnzgUmpH5pD8kbZZX7ZzHzr?=
 =?us-ascii?Q?l/ru0AB6RKOREqawUTBd3cK31IM2IznCoH4JkFr41rajQ5zJaJxLSwE8yFnb?=
 =?us-ascii?Q?5ho8GdS8qQnXRmwbV9G7FOBNligeE/q3+Owgy7Qw8RKNMvwOCW+blKg5RsPV?=
 =?us-ascii?Q?79BRnv2LMLjMrUXfMa7f6afHLbcv6xsCS1dK0kGFpo3Q0cpykjMKJ/V54f4s?=
 =?us-ascii?Q?a+XTl8ex/hlLQTwH1WMadRMqObJ4uC/YATzpp49QXiGahl0A8ag2ijeskNFX?=
 =?us-ascii?Q?AmbY136+tdhkJjX99pHz+R7Gyb3X1XxXDOMUjul80ksdR+nDUnu18gjKY5RI?=
 =?us-ascii?Q?Ax1yRB19th6lrPLszI14Ife9uh7N12IL31F7dzgxNRFd56Z+ZG4m6E6OeIM2?=
 =?us-ascii?Q?Hl08T4yHicE27ATH0YGtdDrjKKgbp7h4cOSFgjeFHOOimpnSPyjlxp3Bmby2?=
 =?us-ascii?Q?3pMyieFaTFvATjOCV+WwfphG9KXvWJu2hdTnZjIyXnRp2M1YOXGbYunnM3Ow?=
 =?us-ascii?Q?MS6N9BY8xN3QUAFa5iWZmVUJlxYzPgNIoIxq1F6E2Q9lMnlXhjnpVEo2GnYC?=
 =?us-ascii?Q?UIprVDfmWgBtq38E6g2Tupi+1dhZyDfEjGFqyQWcUs+S/Kmtx/BiLRtzogcp?=
 =?us-ascii?Q?pJy8uiiww4jjPiWYHiA1vSHNH9kYaWOoL+9orEJHHfoOuIip+D4vvTVNLR6Z?=
 =?us-ascii?Q?1ghDzcaJfQws+XfAbvlkDTv6+36vMS8cSS2Q+vRfYHQFp1Q3DE3SVT0y7Nf5?=
 =?us-ascii?Q?Tm1qstIUDMqb+uE65ElKppi5gddb5nPwaD5xOs4EWiJgyz7306b7ybW7mgXt?=
 =?us-ascii?Q?VIq6F+ZufTHVx1c9SPbeJ0wN0zUvFiGJ5XQlsjHDN/lWBweiEETxGWhOR+ow?=
 =?us-ascii?Q?vS8ZjCEFPwac8D5bPDQjRq2Hy3UyHnjv36x5lrYe9fc0TxkY8CL2ex9lIbWM?=
 =?us-ascii?Q?5HAKW1RF8imDsx9NLhuX4gjTyarX8KSRc8VIglzZ5BNgS8HOf49wBJFzWez+?=
 =?us-ascii?Q?PtaKSMSMaZkivcdWU02tzLFVSAC/toYbo/q/vCaNykFLhz7Nr9Ov3MDRcyg/?=
 =?us-ascii?Q?38X8Oq8l9AGfNAb6nTqYkzH1dUccJdzZ87MG8HELiSeJDcNWVlxLjilB775p?=
 =?us-ascii?Q?y9GSrtv5u7+92cLGJA1Q6Bd9UuW637HPZndqwvFbRa22Giz8l29/XcWxLr7Z?=
 =?us-ascii?Q?zk8XcC/NgFamegy0C/0NU+RyZX4908qXueozSDvw9f8UFAbMrY7tZZp/5okI?=
 =?us-ascii?Q?ZVJSX/UAc9IG8cZIlKl8jGFT0D7HB3KYZr2u1vQcF9MEW8K1eAzjfAFkIfYh?=
 =?us-ascii?Q?lGXfAxGPAO0wyB2Xva0ubXfXmck/LTnXHY9UItrMo+ciCY39Sr3EeaDhfVBG?=
 =?us-ascii?Q?7k8HpXIxcGpwc6D/Xh7uJAVDR/RIkP1G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xA2blEFKQeO4ed23jBECDJkHngH8MeorBXk0UBnONQaqEwnsnWJiZ68F87Ec?=
 =?us-ascii?Q?1R33GobdbTd/ynrLcT/cpwBUspsWstLcNZjpN6dOGzgGBgKV8zxJKyp5ZaFi?=
 =?us-ascii?Q?1a1KVJUgv1suGW+Eo/O7k2VBToxbrHwO46cZWKeXt+uBjAKWk0tVqxxhEVTe?=
 =?us-ascii?Q?4eo/nyxLIOhuJgedq0BdnXMIvFGpZQGzzg6/NPy0hJ3mH6wf1gWoL6zrSvYj?=
 =?us-ascii?Q?LYkBbIv2JvqSCdM80VYVf3f7x4zoUtApXQS9w7hYBiiLxmfGFVn3nF+0SRQg?=
 =?us-ascii?Q?czFFrKDc43/uDjnwvoMFfB2/s6mfBP96hNGwWcjhUG0k2gGADJN2iT7W5EB0?=
 =?us-ascii?Q?MgTKU1AxoGugvtv7jL8+z1FIp9sg/8mlllUORZv6YGDuJTeKTp27l0siRL/o?=
 =?us-ascii?Q?Uj9gpkHwtt7rSH6EGet/HUThNp8ijX1qDi8cggPvaBCHUHWla6ILj8FoYu3U?=
 =?us-ascii?Q?ex9lxgS6/AErMZGTDUj9x8OmzOZNWKEYIfFm6H5nDoRceQlW3FJt68bxyhu0?=
 =?us-ascii?Q?kNt1jAKDre0mC/UbbSIWaMwcEyAn+9Po3p3XWRLwhFRFy42KcljlBCKtZv+m?=
 =?us-ascii?Q?EW4uFl7lTYAtfMytk2e2n8laqse/8jogWd4QL4re1wU8BZSod3gXzHzO/uDX?=
 =?us-ascii?Q?3vHW5aCFCY6afufV/JtRa/rCUDCITKaKkKrFwIsWh2Hv/V7BXiiP2in7u3bR?=
 =?us-ascii?Q?1ZT3JOJDPvFlDMpv9NXkhdY5cE2oveM/ecD0Du0doM//FJe42IYY2s6voHyz?=
 =?us-ascii?Q?3KXW8mVeaAYTL+W1RHFqXqcjfzGojFzLk1vmYhy8OqN38xFv1X6UaeWAV6y6?=
 =?us-ascii?Q?vmOdj2BFheMm7F435/orpWtIFRSpngqY3pH/guWVHjko+A3igsEPniNrwrtJ?=
 =?us-ascii?Q?jTc47W9Qlilo4vn5ZmpkRcJh2cjdxDnf+p9BLvyJwQ36s2Xu01aJjYoP5W3c?=
 =?us-ascii?Q?IfOONJTO8cx60bC/0dbPZJ4vRZ88zEhvKmm0dNGOuHQEohxukKqya1LWiiFP?=
 =?us-ascii?Q?4RY56xaQrZa8219Vr1Yi8YEq07mkn6YdsowzGKgEBUD6dH/T84jAElGjMAko?=
 =?us-ascii?Q?qqaurT/vOo/0+wzeMxSDaeUw902EizxhJZeNSyO0RTMEEVkKNtL+h89loKTY?=
 =?us-ascii?Q?RH7RjZtQzuwgYd9BQuitWFqdPI27xz2RfhsxkQV6drxr0Ak/iZBzi39ctJ/0?=
 =?us-ascii?Q?wvgR2h2jOncC+00ICxphEOOJu2beW9maMDMQ1qVnxmZeTg2eVDtq7r3L5t1c?=
 =?us-ascii?Q?nte+yqHLQ4/N36sVfmItkgV1oGyoyZBjaVDux9cSs7r5uKFv9vxnsg701gvN?=
 =?us-ascii?Q?gyPJlVETPiWDxqEC0f2FGLrDvpg2cWJ9ICe7fzNKjdNilSDNUVQ4kjsK+xUD?=
 =?us-ascii?Q?Xr+EA0Kjb4UmTAY0mxbgw3QyKoMi8XWz3XZY/Xf0wvYZ/wSXA4CDh2ZH2p3E?=
 =?us-ascii?Q?KPTS7VAWWhOUGhej9wgEH6VvGSwCJhQ1HXnHP8sfyRWlzkJTpM5Bsug58Osd?=
 =?us-ascii?Q?H2GwS526spUfQ+jXMZlv3zrNQdMzKxs4ihmKcwAg6SKjnZuw/QaEAtJ/Zvgt?=
 =?us-ascii?Q?iwW8tgHEBojNHHwLZzA6CKqQi5DvWqG1naYDLeCg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe000b3-d74c-4833-bdc3-08dd5014b99c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:06:50.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n67ORY+k7H93YEa7XVIs1bN3NeShL6v1dVkhWeIczRg3NEPARlp0AT0ktrqN+BgtGTAHMpUV8Yurv+uSv+W7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
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

From: Viorel Suman <viorel.suman@nxp.com>

i.MX95 System Manager uses interrupt driven communication which requires
the caller to set Bit[0] of channel flags to 1. When transmission
completes and the previous general purpose interrupt has been processed
by the other core, i.MX95 System Manager will set General Purpose
Interrupt Control Register (GCR). U-Boot polls General-purpose Status
(GSR) to check if the operation is finished.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/Kconfig |  6 ++++++
 drivers/firmware/scmi/smt.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index 8cf85f0d7a1..eb62b88615b 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -41,3 +41,9 @@ config SCMI_AGENT_OPTEE
 	help
 	  Enable the SCMI communication channel based on OP-TEE transport
 	  for compatible "linaro,scmi-optee".
+
+config SCMI_TRANSPORT_SMT_INTR
+	bool
+	depends on SCMI_FIRMWARE
+	help
+	  Enable interrupt communication of shared memory based transport.
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f450024..a0489f9718a 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -20,6 +20,16 @@
 
 #include "smt.h"
 
+static void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 /**
  * Get shared memory configuration defined by the referred DT phandle
  * Return with a errno compliant value.
@@ -48,6 +58,9 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_SCMI_TRANSPORT_SMT_INTR))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
-- 
2.43.0

