Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F22DCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55569848D1;
	Wed, 17 Jun 2026 09:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lJTtpFX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFB884962; Wed, 17 Jun 2026 09:06:41 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B864803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTB8F7qoj8G0KR1rvzWDc6g7uB/rG+FG9aJBNXf4PcnbqcOcTRSiQOg8f9BNvbtTEmDZ0Y1cozpk5Jh29eBUkXOx7jnkFaBuLV5Mj2OVXUTnd3FkrVJhQRVWs1w/FnqbkvgdbfjZ43L1QvHO5vpanH1iEatiQNaXrVpfStQ9ri7CxbLEAGjONT/X8xA06XKPofyaJIuw11aO3wAFjpnG+6JR0PMGxldZt+DkO08BBpeOyNmhGa0K9cUhKw1iHhd3NoeT1yPOA0zeESadLAmnqbbi0UsI+0gBWfQ8inIH60ogg9z6YPD7/bN6QbHBsXSouMsR3Vq8yDsC81jxTl6NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx2U1KrweoZu4V/x1NHCBdJlpy/MZn+kiNwO6tPNtIU=;
 b=NTPcnZcqwLCcJ06INJ4AB70jFK9LsQHb5vFkp8Z88bLvRVmJeE+hCkaUoeP8B5oo4AoIJfq/UPC/tGXmdKkH/DB+g82F0ga8xc881cdeRn0yU87GzceXPlXTyeAP7AiHZJ0hNM5cn1aEMDifcJjQ0XW0qTBPASiwrPmySWrX+ftbHE9gM/dA8krS22u3DIgdOq6E1KybZpTcGSH3RERRP8p1WOIcp8RHpux6nvCJE/+SNrgvQfXcM56xfuuAUlgwxPmrMyteyaFrI8l1vv+pFrpCIsYE/hvwwFdtFsqzsVwvYKFZHtvTPWZKJpmTR02oct10XWksn9J7nMM4WdB/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx2U1KrweoZu4V/x1NHCBdJlpy/MZn+kiNwO6tPNtIU=;
 b=lJTtpFX23dN7A1mbJEgB6MGu5TjCyNc64twt261dzrWvFOlThaLbnhNJwjggrYwsAYdL4Cm99Rgb+d/BN0ii7hTgQaCHnOQ+xxlYfUfYWBoJjVIdAOX+wOTQ+eeb5j/Z0xrOkW0sNwtViYnf/vGqyTq1yt38gkwAHLYTn3/QJoKY9Ikxu07BdCahnF/gVS/OxoFmoLmb+VwU2W+H2WEdjT4xeqqY4HFF+ZT+hRQxDVd0Get7S6SEDWGDY7zQi5Ivv6T2ycVW6fBNJhLQTkSrRjfBtn3SNOeHqkZ8HvfAN1Ax5dvgT5BYDOyk0/Qzl5QDJAYSjnqEgwhQk6/HJSm2zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:35 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:04 +0800
Subject: [PATCH 05/11] usb: tcpm: add TCPCI (Type-C Port Controller
 Interface) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-5-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: 700067cb-a868-47f9-5044-08decc3ef771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: JTIITzyDz9ApoB5zprU7m0OvmMna+SWtPzGggZKxq0mqipEk6/Pl1tQ1ZaJO7S08/YKvkOpViby4uMY/RuxqInuKyxcfS+Z60D1svwlkO0RHWSpVRVyDBYpnRV7sDmg2EeuE/bqtjaInxebXpT8Zn35cDlB3rUT2kBzqjh10QXVOOr+OkkZ2ORh7u+CmO3Rxu1RMnSLq9WC4Iurlt1oC8sUxAeQwTAgVXBEcsAFlUeFAH5YSmbddwdVcswocNV3T29H/gHekNFZXdqQ5ftbgDkJcqRfu9zN1e0afyqgucVRMmMKllrgBw+PuwJ6EwtfaGUljzA3KmJOMvvJjniYx0MqctBIGKWMvLGZQOJFcWFS5VMafIyQxsuNiCY2mo8xnZDR0c4umHyVEOEfAn0JWAYivkbsMxTgs84lSpPH3Mpvpy7De5Y9sCfT2s0IrU/9MLiAOtheMFn8u1h4dcxBxgukwkJuMEPvh8pfSL961+caMJBteos7kwyrfwCWBIuiwKZ5njLU32v50oxalXnFMlh9vZ4YuGbICZijudw3A1LHbRJarQ6f8tKZcKkwKLwfo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1JCeHR1YTRDd01LT3NSTGU5cXNQMzg4bms2UmttMERyaFlLQ3JMaE9XTEFD?=
 =?utf-8?B?NlJHNmpTNW90dUlyMUZZNkR4aXZXZS9zN1Y4VGxiejJWMFlveG1yZ25CQUM3?=
 =?utf-8?B?NWxEbVczYXZoYnFETjViUmRsajMzM25RY0g4K2hDYncwOHBGZDhOb2VLcDk5?=
 =?utf-8?B?L0VCMFNNZ0JTMDdDcXhGVlV6ejN1dXBYaTk1TS9TZ2JwY2NZQzEyalB4ZW92?=
 =?utf-8?B?Zlc2eUFQNU1rVE82YU9PTkdEY2EwRnYrVXVYWll1TUNtMEx5b0trMEkzZ2xi?=
 =?utf-8?B?d0JZZzVRRmdvY3RaWmRWdmZzVGxtcmJDb3dPOEE1VmtvQW1FZlpDcUptV2k3?=
 =?utf-8?B?bzcyOFdjUENJaU5ndlJ3bWNsMTJQRlNIQ25lbW5peGtYNFo1SUtRR0Z6Q0NG?=
 =?utf-8?B?LzhhaElJQjVQWk11S29jMWY2Z3hHUzJyZ0NFaWN0RzZidU5PdjNkZ0tQV1cy?=
 =?utf-8?B?bk1DVW1VTUR6OUZFcTZJL01xalJLeFd0Zzlsek9Pbk1iR3FRZ3BHMngwSnlT?=
 =?utf-8?B?bnlpaE05RFZvV3RiZlJZVkhtZHBGYUlWM3pCcmJjVW9LTTdLRWRLQWJTS3Er?=
 =?utf-8?B?eUNSZnhUT2ozTzQvRDJGbVI4b0RUT0I5VUo1a2xMRUQxemE5RWo5VmM5SE5M?=
 =?utf-8?B?SHk3OTFtYnJoSmpnSDNGaks1Rnl6anNvMDFkV3ZXSDJKdEFuaXlBYmxRZXBk?=
 =?utf-8?B?SGE5cklmeDY3N1pEcEtDSXZvcHJUejMwTXZ0ZW5QSDRBVlNqRWIxOU43Vmt0?=
 =?utf-8?B?ZnJSYWdNZ0drZ0RBV1VWUW5qWEY4cnVZZjJqcSt2TEhUbjVhNzZHemJucXB4?=
 =?utf-8?B?OXRCT0V0TThDM1VvZVRzcThUekRZbktkRnJxd3N3Nm16bDZlVCtqOEp1VEpX?=
 =?utf-8?B?R0NqWjFVQWVlZjNEaTIrekZad1p3TmwzRmJ0TjE2ZHdBMlF2V1p3QVBqL1Ir?=
 =?utf-8?B?UHNHaFJEMHREUktZM3loWCtsanlMNFE5TUZoT2hBTkF1V2h4UVlnaTh3cTQ4?=
 =?utf-8?B?dTRlckpTREY5WmozMlZYVGFCYWcwZUY4TG1OaHducWNFNEdjWFRPZDk1UURs?=
 =?utf-8?B?aUc4bVJ5WGd4cjdnS09sVGFtbHVpU0JiTHduZnJYQ3VPVmFDRzQzR2lNN0pL?=
 =?utf-8?B?VkdjRy9pRnZsaktGYnZXZUYwZ2VtNFJoSjJZaG9xSHh1U09WT0ZsS3FZR3Vv?=
 =?utf-8?B?NUlGWk5odWJ6d0ErSVZsTTJ0RytaSmUrTlk3Ymx2N2JSTmFHdC93SlJrWjVO?=
 =?utf-8?B?aUFReHR2K09HU1Bvb2txUnhGTEdScERBb1g3Uk16ckw5WnRxeitPdGlwbTM1?=
 =?utf-8?B?OWVBR3FacUM2NmwwQU9pMFQ5ZW83RG4ranZNTWdaOWlKR05KcG50OEM2TUY4?=
 =?utf-8?B?aU1HQk5QVXB3TTJnMndVYXZBN3lHaldNVjdJaldYWWFKS1RNSXEvVlhnZTJk?=
 =?utf-8?B?N3dIcXZpZXJSNDVOZEdSV2xIR0NpSWd0SXhYMWVITnBJanlBT2VHSVB6M0pJ?=
 =?utf-8?B?N2hESkZqbWVINnVNalNabit0OUdiQllhWlF3WVhDbVQxQlNQWmJKQmRJQ3lG?=
 =?utf-8?B?em1JaWhsU3g0ZHpGVXFkNzU1blJmWkpSUjhXNjNQd2pHY3ZVNURuc1daaXli?=
 =?utf-8?B?ZHkyR0tjMzRrUnBrZk9pTStyMzAxSXFvU214WmR6dDlGeCt6Z2FLZ2lSdWdP?=
 =?utf-8?B?V3VTbzBDZVRkWlBqUURQTlN0UVgxQ0JYNlpQZWYwU3RHVFp3bFJRbE1KSWwx?=
 =?utf-8?B?OHhuRnRDSnNHNFJpTVdKZEN4b0poSUpLekQvbWRWOVJrcWpqcXR3VEN0QzFO?=
 =?utf-8?B?b29QSytUb1VGWG4wT0NYUXp6bENDSlVzVDNRZkZXUVF4LzZFbXJGazdHc3ZG?=
 =?utf-8?B?ck1iYzdEYnRkbjAwa0VvdlZQMEFVVFVJbDh6dzNzRE02eitxZDVDSUVZN3hv?=
 =?utf-8?B?ZTdwL2R0c0FNNDl5LzMvTlNLdG5jTkJpRjJINVNtVzErZnZzeHpDcjg5MDNE?=
 =?utf-8?B?dDlmYnl4Nnhac0lGUmNNYlpnVldubGlhNExiK1EvUS9HRVNWdXVYQnpTUG9E?=
 =?utf-8?B?RG11T01YWGZkQUMvQW9VNk43a0dIUHdzcm96cjJDWkIwVDZPRDdoWUpuMUtU?=
 =?utf-8?B?T1hZb2E0RTBrb21MOUJHSldnU1JqSWpYTnZQYm10dUV3MzY2dTRtcCtLNnN2?=
 =?utf-8?B?eHlSSFppbXQ5VmozNm9ncStQeUJjYVhSTUFjVHhDQkhLVUlON0V6dHVWTzcx?=
 =?utf-8?B?N2UrcmxSSnJUcitldG8zUGV1am10cldSVzF6amI3UFFFdHNNd0ErK0JGUjY1?=
 =?utf-8?B?UDdnVGo3aERoZG11Ykdvd29ZaHVXTUtIOFZmM1BnR0pWYnNaVGJUaGNYVUg0?=
 =?utf-8?Q?o+2zOZPxLUTEQ+nbcZ8KnhdRVCkvYQnHUt160?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700067cb-a868-47f9-5044-08decc3ef771
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:34.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLIUosi64aqQyoXFObbYaXJKlRbm2BTRvaRrsxjuaAfK0mOT0WpUeITwV9Jj0POSgdt7AbxDZV1AerGtZ1wZdLobmBITihIrdHmWJxeswyForWSK/Ij4s9I9x486+YZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906
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

Add a generic TCPCI-compliant driver for USB Type-C Port Controller
Interface chips such as NXP PTN5110. The driver implements the
dm_tcpm_ops interface and communicates with the TCPC via I2C.

Key features:
- Full TCPCI register-level implementation for PD sink negotiation
- Proper TX buffer handling (burst write from TX_HDR)
- Alert-based polling for RX, TX completion, CC and VBUS changes
- Re-entrant poll protection to prevent state machine corruption
- Low power mode with RX_DETECT disable and alert masking to
  prevent post-negotiation Hard Reset from PD sources
- Stale RX buffer drain during initialization for dead-battery
  boot scenarios

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/Kconfig  |   9 +
 drivers/usb/tcpm/Makefile |   1 +
 drivers/usb/tcpm/tcpci.c  | 778 ++++++++++++++++++++++++++++++++++++++++++++++
 include/usb/tcpci.h       | 185 +++++++++++
 4 files changed, 973 insertions(+)

diff --git a/drivers/usb/tcpm/Kconfig b/drivers/usb/tcpm/Kconfig
index 9be4b496e82..695c49b64ce 100644
--- a/drivers/usb/tcpm/Kconfig
+++ b/drivers/usb/tcpm/Kconfig
@@ -14,3 +14,12 @@ config TYPEC_FUSB302
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
 	  Type-C functionalities.
+
+config TYPEC_TCPCI
+	tristate "TCPCI Type-C chip driver"
+	depends on DM && DM_I2C && TYPEC_TCPM
+	help
+	  Generic TCPCI (USB Type-C Port Controller Interface)
+	  compliant chip driver that works with Type-C Port
+	  Controller Manager to provide USB PD and USB Type-C
+	  functionalities. Supports NXP PTN5110 and similar.
diff --git a/drivers/usb/tcpm/Makefile b/drivers/usb/tcpm/Makefile
index 668d33155bf..5cabcc06e0a 100644
--- a/drivers/usb/tcpm/Makefile
+++ b/drivers/usb/tcpm/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_TYPEC_TCPM) += tcpm.o tcpm-uclass.o
 obj-$(CONFIG_TYPEC_FUSB302) += fusb302.o
+obj-$(CONFIG_TYPEC_TCPCI) += tcpci.o
diff --git a/drivers/usb/tcpm/tcpci.c b/drivers/usb/tcpm/tcpci.c
new file mode 100644
index 00000000000..9ade6d16009
--- /dev/null
+++ b/drivers/usb/tcpm/tcpci.c
@@ -0,0 +1,778 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ *
+ * USB Type-C Port Controller Interface I2C driver for U-Boot.
+ */
+
+#define LOG_CATEGORY UCLASS_TCPM
+
+#include <dm.h>
+#include <i2c.h>
+#include <watchdog.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <dm/device_compat.h>
+#include <time.h>
+#include <usb/tcpm.h>
+#include <usb/tcpci.h>
+#include "tcpm-internal.h"
+
+#define PD_RETRY_COUNT_DEFAULT		3
+#define PD_RETRY_COUNT_3_0_OR_HIGHER	2
+
+struct tcpci_chip {
+	u16 alert_mask;
+	bool controls_vbus;
+	bool in_poll;
+};
+
+static int tcpci_read8(struct udevice *dev, u8 reg, u8 *val)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, val, 1);
+	if (ret)
+		dev_err(dev, "cannot read 0x%02x, ret=%d\n", reg, ret);
+
+	dev_dbg(dev, "read 0x%02x, val=0x%02x\n", reg, *val);
+
+	return ret;
+}
+
+static int tcpci_write8(struct udevice *dev, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, &val, 1);
+	if (ret)
+		dev_err(dev, "cannot write 0x%02x to 0x%02x, ret=%d\n",
+			val, reg, ret);
+	dev_dbg(dev, "write 0x%02x, val=0x%02x\n", reg, val);
+
+	return ret;
+}
+
+static int tcpci_read16(struct udevice *dev, u8 reg, u16 *val)
+{
+	int ret;
+
+	ret = dm_i2c_read(dev, reg, (u8 *)val, 2);
+	if (ret)
+		dev_err(dev, "cannot read 16-bit 0x%02x, ret=%d\n", reg, ret);
+
+	dev_dbg(dev, "read16 0x%02x, val=0x%04x\n", reg, *val);
+
+	return ret;
+}
+
+static int tcpci_write16(struct udevice *dev, u8 reg, u16 val)
+{
+	int ret;
+
+	ret = dm_i2c_write(dev, reg, (u8 *)&val, 2);
+	if (ret)
+		dev_err(dev, "cannot write 16-bit 0x%04x to 0x%02x, ret=%d\n",
+			val, reg, ret);
+	dev_dbg(dev, "write16 0x%02x, val=0x%04x\n", reg, val);
+
+	return ret;
+}
+
+static int tcpci_get_connector_node(struct udevice *dev, ofnode *connector_node)
+{
+	dev_dbg(dev, "%s: entering\n", __func__);
+
+	*connector_node = dev_read_subnode(dev, "connector");
+	if (!ofnode_valid(*connector_node)) {
+		dev_err(dev, "'connector' node is not found\n");
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "%s: connector node found\n", __func__);
+	return 0;
+}
+
+static int tcpci_set_cc(struct udevice *dev, enum typec_cc_status cc)
+{
+	unsigned int reg;
+	int ret;
+	u8 power_status;
+	bool vconn_pres;
+	enum typec_cc_polarity polarity = TYPEC_POLARITY_CC1;
+
+	dev_dbg(dev, "%s: entering cc=%d\n", __func__, cc);
+
+	ret = tcpci_read8(dev, TCPC_POWER_STATUS, &power_status);
+	if (ret < 0)
+		return ret;
+
+	vconn_pres = !!(power_status & TCPC_POWER_STATUS_VCONN_PRES);
+	if (vconn_pres) {
+		u8 ctrl;
+
+		ret = tcpci_read8(dev, TCPC_TCPC_CTRL, &ctrl);
+		if (ret < 0)
+			return ret;
+
+		if (ctrl & TCPC_TCPC_CTRL_ORIENTATION)
+			polarity = TYPEC_POLARITY_CC2;
+	}
+
+	switch (cc) {
+	case TYPEC_CC_RA:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RA) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RA));
+		break;
+	case TYPEC_CC_RD:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RD) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RD));
+		break;
+	case TYPEC_CC_RP_DEF:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+				  TCPC_ROLE_CTRL_RP_VAL_DEF));
+		break;
+	case TYPEC_CC_RP_1_5:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+				  TCPC_ROLE_CTRL_RP_VAL_1_5));
+		break;
+	case TYPEC_CC_RP_3_0:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_RP) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+				  TCPC_ROLE_CTRL_RP_VAL_3_0));
+		break;
+	case TYPEC_CC_OPEN:
+	default:
+		reg = (FIELD_PREP(TCPC_ROLE_CTRL_CC1, TCPC_ROLE_CTRL_CC_OPEN) |
+		       FIELD_PREP(TCPC_ROLE_CTRL_CC2, TCPC_ROLE_CTRL_CC_OPEN));
+		break;
+	}
+
+	if (vconn_pres) {
+		if (polarity == TYPEC_POLARITY_CC2)
+			reg = (reg & ~TCPC_ROLE_CTRL_CC1) |
+			      FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+					 TCPC_ROLE_CTRL_CC_OPEN);
+		else
+			reg = (reg & ~TCPC_ROLE_CTRL_CC2) |
+			      FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+					 TCPC_ROLE_CTRL_CC_OPEN);
+	}
+
+	ret = tcpci_write8(dev, TCPC_ROLE_CTRL, (u8)reg);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_start_toggling(struct udevice *dev,
+				enum typec_port_type port_type,
+				enum typec_cc_status cc)
+{
+	unsigned int reg = 0;
+	int ret;
+
+	dev_dbg(dev, "%s: entering port_type=%d cc=%d\n", __func__,
+		port_type, cc);
+
+	switch (port_type) {
+	case TYPEC_PORT_DRP:
+		reg |= TCPC_ROLE_CTRL_DRP;
+		fallthrough;
+	case TYPEC_PORT_SRC:
+		switch (cc) {
+		default:
+		case TYPEC_CC_RP_DEF:
+			reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+					  TCPC_ROLE_CTRL_RP_VAL_DEF);
+			break;
+		case TYPEC_CC_RP_1_5:
+			reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+					  TCPC_ROLE_CTRL_RP_VAL_1_5);
+			break;
+		case TYPEC_CC_RP_3_0:
+			reg |= FIELD_PREP(TCPC_ROLE_CTRL_RP_VAL,
+					  TCPC_ROLE_CTRL_RP_VAL_3_0);
+			break;
+		}
+
+		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+				   TCPC_ROLE_CTRL_CC_RP) |
+			FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+				   TCPC_ROLE_CTRL_CC_RP));
+		ret = tcpci_write8(dev, TCPC_ROLE_CTRL, (u8)reg);
+		if (ret < 0)
+			return ret;
+		ret = tcpci_write8(dev, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: done\n", __func__);
+		return 0;
+	case TYPEC_PORT_SNK:
+		reg |= (FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+				   TCPC_ROLE_CTRL_CC_RD) |
+			FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+				   TCPC_ROLE_CTRL_CC_RD));
+		ret = tcpci_write8(dev, TCPC_ROLE_CTRL, (u8)reg);
+		if (ret < 0)
+			return ret;
+		dev_dbg(dev, "%s: done sink CC=Rd\n", __func__);
+		return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int tcpci_get_cc(struct udevice *dev, enum typec_cc_status *cc1,
+			enum typec_cc_status *cc2)
+{
+	unsigned int role_control, reg;
+	int ret;
+
+	dev_dbg(dev, "%s: entering\n", __func__);
+
+	ret = tcpci_read8(dev, TCPC_ROLE_CTRL, (u8 *)&role_control);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_read8(dev, TCPC_CC_STATUS, (u8 *)&reg);
+	if (ret < 0)
+		return ret;
+
+	*cc1 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC1, reg),
+				 reg & TCPC_CC_STATUS_TERM ||
+				 tcpc_presenting_rd(role_control, CC1));
+	*cc2 = tcpci_to_typec_cc(FIELD_GET(TCPC_CC_STATUS_CC2, reg),
+				 reg & TCPC_CC_STATUS_TERM ||
+				 tcpc_presenting_rd(role_control, CC2));
+
+	dev_dbg(dev, "%s: cc1=%d cc2=%d\n", __func__, *cc1, *cc2);
+	return 0;
+}
+
+static int tcpci_set_polarity(struct udevice *dev,
+			      enum typec_cc_polarity polarity)
+{
+	unsigned int reg;
+	enum typec_cc_status cc1, cc2;
+	int ret;
+
+	dev_dbg(dev, "%s: entering polarity=%d\n", __func__, polarity);
+
+	ret = tcpci_read8(dev, TCPC_ROLE_CTRL, (u8 *)&reg);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_get_cc(dev, &cc1, &cc2);
+	if (ret < 0)
+		return ret;
+
+	if (reg & TCPC_ROLE_CTRL_DRP) {
+		reg &= ~TCPC_ROLE_CTRL_DRP;
+
+		if (polarity == TYPEC_POLARITY_CC2) {
+			reg &= ~TCPC_ROLE_CTRL_CC2;
+			if (cc2 == TYPEC_CC_RD)
+				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+						  TCPC_ROLE_CTRL_CC_RP);
+			else if (cc2 >= TYPEC_CC_RP_DEF)
+				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+						  TCPC_ROLE_CTRL_CC_RD);
+		} else {
+			reg &= ~TCPC_ROLE_CTRL_CC1;
+			if (cc1 == TYPEC_CC_RD)
+				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+						  TCPC_ROLE_CTRL_CC_RP);
+			else if (cc1 >= TYPEC_CC_RP_DEF)
+				reg |= FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+						  TCPC_ROLE_CTRL_CC_RD);
+		}
+
+		/* Transitioning from DRP toggling: set unused CC to OPEN */
+		if (polarity == TYPEC_POLARITY_CC2)
+			reg = (reg & ~TCPC_ROLE_CTRL_CC1) |
+			      FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+					 TCPC_ROLE_CTRL_CC_OPEN);
+		else
+			reg = (reg & ~TCPC_ROLE_CTRL_CC2) |
+			      FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+					 TCPC_ROLE_CTRL_CC_OPEN);
+	}
+
+	ret = tcpci_write8(dev, TCPC_ROLE_CTRL, (u8)reg);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_write8(dev, TCPC_TCPC_CTRL,
+			   (polarity == TYPEC_POLARITY_CC2) ?
+			   TCPC_TCPC_CTRL_ORIENTATION : 0);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_set_vconn(struct udevice *dev, bool enable)
+{
+	int ret;
+	u8 reg;
+
+	dev_dbg(dev, "%s: entering enable=%d\n", __func__, enable);
+
+	ret = tcpci_read8(dev, TCPC_POWER_CTRL, &reg);
+	if (ret < 0)
+		return ret;
+
+	if (enable)
+		reg |= TCPC_POWER_CTRL_VCONN_ENABLE;
+	else
+		reg &= ~TCPC_POWER_CTRL_VCONN_ENABLE;
+
+	ret = tcpci_write8(dev, TCPC_POWER_CTRL, reg);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_set_vbus(struct udevice *dev, bool on, bool charge)
+{
+	int ret;
+	u8 power_status;
+
+	dev_dbg(dev, "%s: entering on=%d charge=%d\n", __func__, on, charge);
+
+	ret = tcpci_read8(dev, TCPC_POWER_STATUS, &power_status);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: POWER_STATUS=0x%02x VBUS_PRES=%d SOURCING=%d SINKING=%d\n",
+		__func__, power_status,
+		!!(power_status & TCPC_POWER_STATUS_VBUS_PRES),
+		!!(power_status & TCPC_POWER_STATUS_SOURCING_VBUS),
+		!!(power_status & TCPC_POWER_STATUS_SINKING_VBUS));
+
+	/*
+	 * If VBUS is present, don't send any VBUS COMMAND register writes
+	 * at all - the PTN5110 uses a shared power path and disabling
+	 * source or sink while VBUS is active cuts the board's power.
+	 */
+	if (power_status & TCPC_POWER_STATUS_VBUS_PRES) {
+		dev_dbg(dev, "%s: VBUS present, skipping all VBUS commands\n",
+			__func__);
+		return 0;
+	}
+
+	if (!on) {
+		ret = tcpci_write8(dev, TCPC_COMMAND,
+				   TCPC_CMD_DISABLE_SRC_VBUS);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!charge) {
+		ret = tcpci_write8(dev, TCPC_COMMAND,
+				   TCPC_CMD_DISABLE_SINK_VBUS);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (on) {
+		ret = tcpci_write8(dev, TCPC_COMMAND,
+				   TCPC_CMD_SRC_VBUS_DEFAULT);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (charge) {
+		ret = tcpci_write8(dev, TCPC_COMMAND,
+				   TCPC_CMD_SINK_VBUS);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_set_pd_rx(struct udevice *dev, bool enable)
+{
+	u8 reg = 0;
+	int ret;
+
+	dev_dbg(dev, "%s: entering enable=%d\n", __func__, enable);
+
+	if (enable)
+		reg = TCPC_RX_DETECT_SOP | TCPC_RX_DETECT_HARD_RESET;
+
+	ret = tcpci_write8(dev, TCPC_RX_DETECT, reg);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_set_roles(struct udevice *dev, bool attached,
+			   enum typec_role role, enum typec_data_role data)
+{
+	unsigned int reg;
+	int ret;
+
+	dev_dbg(dev, "%s: entering attached=%d role=%d data=%d\n",
+		__func__, attached, role, data);
+
+	reg = FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
+	if (role == TYPEC_SOURCE)
+		reg |= TCPC_MSG_HDR_INFO_PWR_ROLE;
+	if (data == TYPEC_HOST)
+		reg |= TCPC_MSG_HDR_INFO_DATA_ROLE;
+
+	ret = tcpci_write8(dev, TCPC_MSG_HDR_INFO, (u8)reg);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done\n", __func__);
+	return 0;
+}
+
+static int tcpci_get_vbus(struct udevice *dev)
+{
+	u8 reg;
+	int ret;
+
+	ret = tcpci_read8(dev, TCPC_POWER_STATUS, &reg);
+	if (ret < 0)
+		return 0;
+
+	dev_dbg(dev, "%s: vbus=%d\n", __func__,
+		!!(reg & TCPC_POWER_STATUS_VBUS_PRES));
+	return !!(reg & TCPC_POWER_STATUS_VBUS_PRES);
+}
+
+static int tcpci_pd_transmit(struct udevice *dev,
+			     enum tcpm_transmit_type type,
+			     const struct pd_message *msg,
+			     unsigned int negotiated_rev)
+{
+	u16 header = msg ? le16_to_cpu(msg->header) : 0;
+	unsigned int reg, cnt;
+	int ret;
+	u8 byte_cnt;
+	u8 buf[TCPC_TRANSMIT_BUFFER_MAX_LEN];
+	u8 pos = 0;
+
+	cnt = msg ? pd_header_cnt(header) * 4 : 0;
+
+	schedule();
+
+	byte_cnt = cnt + 2;
+
+	ret = dm_i2c_write(dev, TCPC_TX_BYTE_CNT, &byte_cnt, 1);
+	if (ret < 0)
+		return ret;
+
+	if (msg) {
+		memcpy(&buf[pos], &msg->header, sizeof(msg->header));
+		pos += sizeof(msg->header);
+
+		if (cnt > 0) {
+			memcpy(&buf[pos], msg->payload, cnt);
+			pos += cnt;
+		}
+
+		ret = dm_i2c_write(dev, TCPC_TX_HDR, buf, byte_cnt);
+		if (ret < 0)
+			return ret;
+	}
+
+	reg = FIELD_PREP(TCPC_TRANSMIT_RETRY,
+			 (negotiated_rev > PD_REV20
+			  ? PD_RETRY_COUNT_3_0_OR_HIGHER
+			  : PD_RETRY_COUNT_DEFAULT));
+	reg |= FIELD_PREP(TCPC_TRANSMIT_TYPE, type);
+	ret = tcpci_write8(dev, TCPC_TRANSMIT, (u8)reg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tcpci_init(struct udevice *dev)
+{
+	struct tcpci_chip *chip = dev_get_priv(dev);
+	ulong timeout_ms = 1000;
+	u8 power_status;
+	u16 alert_mask;
+	ulong start;
+	int ret;
+	u8 cnt;
+	u8 rx_buf[64];
+
+	dev_dbg(dev, "%s: entering\n", __func__);
+	dev_dbg(dev, "TCPCI: init start\n");
+
+	start = get_timer(0);
+	do {
+		ret = tcpci_read8(dev, TCPC_POWER_STATUS, &power_status);
+		if (ret < 0)
+			return ret;
+
+		if (!(power_status & TCPC_POWER_STATUS_UNINIT))
+			break;
+
+	} while (get_timer(0) < (start + timeout_ms));
+
+	if (power_status & TCPC_POWER_STATUS_UNINIT) {
+		dev_err(dev, "TCPC initialization timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "%s: TCPC ready after wait\n", __func__);
+	dev_dbg(dev, "%s: POWER_STATUS=0x%02x\n", __func__, power_status);
+
+	ret = tcpci_write8(dev, TCPC_FAULT_STATUS, 0xff);
+	if (ret < 0)
+		return ret;
+
+	/* Mask all fault alerts (ALL_REG_RST_TO_DEFAULT, VCONN_OC) */
+	ret = tcpci_write8(dev, TCPC_FAULT_STATUS_MASK, 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_write16(dev, TCPC_ALERT, 0xffff);
+	if (ret < 0)
+		return ret;
+
+	/* Drain any stale RX buffer (e.g. from dead battery phase) */
+	ret = tcpci_read8(dev, TCPC_RX_BYTE_CNT, &cnt);
+	if (ret == 0 && cnt > 0 && cnt <= sizeof(rx_buf)) {
+		dm_i2c_read(dev, TCPC_RX_BUF_FRAME_TYPE, rx_buf, cnt);
+		dev_dbg(dev, "%s: drained %d bytes from stale RX buffer\n",
+			__func__, cnt);
+		tcpci_write16(dev, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+	}
+
+	power_status = chip->controls_vbus ? TCPC_POWER_STATUS_VBUS_PRES : 0;
+	ret = tcpci_write8(dev, TCPC_POWER_STATUS_MASK, power_status);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_write8(dev, TCPC_COMMAND, TCPC_CMD_ENABLE_VBUS_DETECT);
+	if (ret < 0)
+		return ret;
+
+	alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_FAILED |
+		     TCPC_ALERT_TX_DISCARDED | TCPC_ALERT_RX_STATUS |
+		     TCPC_ALERT_RX_HARD_RST | TCPC_ALERT_CC_STATUS;
+	if (chip->controls_vbus)
+		alert_mask |= TCPC_ALERT_POWER_STATUS;
+
+	chip->alert_mask = alert_mask;
+
+	/* Program hardware ALERT_MASK so unwanted bits never fire */
+	ret = tcpci_write16(dev, TCPC_ALERT_MASK, chip->alert_mask);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "%s: done alert_mask=0x%04x controls_vbus=%d\n",
+		__func__, alert_mask, chip->controls_vbus);
+	return 0;
+}
+
+static void tcpci_poll_event(struct udevice *dev)
+{
+	struct tcpci_chip *chip = dev_get_priv(dev);
+	u16 status;
+	int max_iter = 5;
+	int ret;
+	bool was_in_poll = chip->in_poll;
+
+	schedule();
+	chip->in_poll = true;
+
+	do {
+		u16 raw;
+
+		ret = tcpci_read16(dev, TCPC_ALERT, &raw);
+		if (ret < 0)
+			break;
+
+		if (raw & ~TCPC_ALERT_RX_STATUS)
+			tcpci_write16(dev, TCPC_ALERT,
+				      raw & ~TCPC_ALERT_RX_STATUS);
+
+		if (raw & TCPC_ALERT_FAULT) {
+			u8 fault;
+			tcpci_read8(dev, TCPC_FAULT_STATUS, &fault);
+			tcpci_write8(dev, TCPC_FAULT_STATUS, fault);
+		}
+
+		status = raw & chip->alert_mask;
+		if (!status)
+			break;
+
+		if (status & TCPC_ALERT_CC_STATUS)
+			tcpm_cc_change(dev);
+
+		if (status & TCPC_ALERT_POWER_STATUS)
+			tcpm_vbus_change(dev);
+
+		if (status & TCPC_ALERT_RX_STATUS) {
+			struct pd_message msg;
+			u16 header = 0;
+			u8 cnt;
+			u8 rx_buf[64];
+
+			/*
+			 * On re-entrant calls (during TX poll helper), the
+			 * state machine is locked.  Drain and clear the
+			 * FIFO without processing, letting the NEXT poll
+			 * (after state machine unlocks) handle the message.
+			 */
+			if (was_in_poll) {
+				ret = tcpci_read8(dev, TCPC_RX_BYTE_CNT, &cnt);
+				if (ret == 0 && cnt > 0 && cnt <= sizeof(rx_buf))
+					dm_i2c_read(dev, TCPC_RX_BUF_FRAME_TYPE,
+						    rx_buf, cnt);
+				tcpci_write16(dev, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+				continue;
+			}
+
+			memset(&msg, 0, sizeof(msg));
+
+			ret = tcpci_read8(dev, TCPC_RX_BYTE_CNT, &cnt);
+			if (ret < 0)
+				continue;
+
+			if (cnt > 0 && cnt <= sizeof(rx_buf)) {
+				ret = dm_i2c_read(dev, TCPC_RX_BUF_FRAME_TYPE,
+						  rx_buf, cnt);
+				if (ret < 0)
+					continue;
+
+				if (cnt >= 3) {
+					header = rx_buf[1] | (rx_buf[2] << 8);
+					msg.header = cpu_to_le16(header);
+
+					if (cnt > 3) {
+						unsigned int payload_cnt = cnt - 3;
+						if (payload_cnt > sizeof(msg.payload))
+							payload_cnt = sizeof(msg.payload);
+						memcpy(&msg.payload, &rx_buf[3],
+						       payload_cnt);
+					}
+				}
+			}
+
+			tcpci_write16(dev, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+
+			if (header != 0)
+				tcpm_pd_receive(dev, &msg);
+			}
+
+		if (status & TCPC_ALERT_RX_HARD_RST) {
+			pd_trace("ALERT_RX_HARD_RST", raw);
+			dev_dbg(dev, "%s: RX_HARD_RST\n", __func__);
+			tcpm_pd_hard_reset(dev);
+		}
+
+		if (status & TCPC_ALERT_TX_SUCCESS) {
+			dev_dbg(dev, "%s: TX_SUCCESS\n", __func__);
+			tcpm_pd_transmit_complete(dev, TCPC_TX_SUCCESS);
+		} else if (status & TCPC_ALERT_TX_DISCARDED) {
+			dev_dbg(dev, "%s: TX_DISCARDED\n", __func__);
+			tcpm_pd_transmit_complete(dev, TCPC_TX_DISCARDED);
+		} else if (status & TCPC_ALERT_TX_FAILED) {
+			dev_dbg(dev, "%s: TX_FAILED\n", __func__);
+			tcpm_pd_transmit_complete(dev, TCPC_TX_FAILED);
+		}
+	} while (--max_iter > 0);
+
+	chip->in_poll = was_in_poll;
+}
+
+static int tcpci_enter_low_power_mode(struct udevice *dev, bool attached,
+				      bool pd_capable)
+{
+	int ret;
+
+	dev_dbg(dev, "%s: entering attached=%d pd_capable=%d\n",
+		__func__, attached, pd_capable);
+
+	/*
+	 * Stop SOP reception so TCPCI hardware won't auto-send GoodCRC
+	 * for incoming messages.  Without this, the source may send
+	 * Get_Sink_Cap or Get_Status after negotiation completes;
+	 * TCPCI auto-ACKs with GoodCRC, source starts SenderResponseTimer,
+	 * nobody sends a response, timer expires -> Hard Reset -> VBUS
+	 * drops -> board loses power.
+	 *
+	 * Per PD spec 6.5.2, failure to receive GoodCRC does NOT trigger
+	 * Hard Reset, so source stays in Ready state with VBUS up.
+	 */
+	u8 pwr_ctrl, pwr_status;
+
+	tcpci_read8(dev, TCPC_POWER_CTRL, &pwr_ctrl);
+	tcpci_read8(dev, TCPC_POWER_STATUS, &pwr_status);
+	pd_trace("LOW_PWR_PWR_CTRL", pwr_ctrl);
+	pd_trace("LOW_PWR_PWR_STAT", pwr_status);
+
+	pd_trace("LOW_PWR_ENTER", 0);
+	ret = tcpci_write8(dev, TCPC_RX_DETECT, 0);
+	if (ret < 0)
+		return ret;
+
+	pd_trace("LOW_PWR_RX_OFF", 0);
+	ret = tcpci_write16(dev, TCPC_ALERT_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = tcpci_write16(dev, TCPC_ALERT, 0xffff);
+	if (ret < 0)
+		return ret;
+
+	pd_trace("LOW_PWR_DONE", 0);
+	return 0;
+}
+
+static struct dm_tcpm_ops tcpci_ops = {
+	.get_connector_node = tcpci_get_connector_node,
+	.init = tcpci_init,
+	.get_vbus = tcpci_get_vbus,
+	.set_cc = tcpci_set_cc,
+	.get_cc = tcpci_get_cc,
+	.set_polarity = tcpci_set_polarity,
+	.set_vconn = tcpci_set_vconn,
+	.set_vbus = tcpci_set_vbus,
+	.set_pd_rx = tcpci_set_pd_rx,
+	.set_roles = tcpci_set_roles,
+	.start_toggling = tcpci_start_toggling,
+	.pd_transmit = tcpci_pd_transmit,
+	.poll_event = tcpci_poll_event,
+	.enter_low_power_mode = tcpci_enter_low_power_mode,
+};
+
+static const struct udevice_id tcpci_ids[] = {
+	{ .compatible = "nxp,ptn5110" },
+	{ .compatible = "tcpci" },
+	{ }
+};
+
+U_BOOT_DRIVER(tcpci) = {
+	.name = "tcpci",
+	.id = UCLASS_TCPM,
+	.of_match = tcpci_ids,
+	.ops = &tcpci_ops,
+	.priv_auto = sizeof(struct tcpci_chip),
+};
diff --git a/include/usb/tcpci.h b/include/usb/tcpci.h
new file mode 100644
index 00000000000..f87d10c6c53
--- /dev/null
+++ b/include/usb/tcpci.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2015-2017 Google, Inc
+ *
+ * USB Type-C Port Controller Interface.
+ */
+
+#ifndef __USB_TCPCI_H
+#define __USB_TCPCI_H
+
+#include <linux/bitops.h>
+#include <usb/pd.h>
+
+#define TCPC_VENDOR_ID			0x0
+#define TCPC_PRODUCT_ID			0x2
+#define TCPC_BCD_DEV			0x4
+#define TCPC_TC_REV			0x6
+#define TCPC_PD_REV			0x8
+#define TCPC_PD_INT_REV			0xa
+
+#define TCPC_ALERT			0x10
+#define TCPC_ALERT_EXTND		BIT(14)
+#define TCPC_ALERT_EXTENDED_STATUS	BIT(13)
+#define TCPC_ALERT_VBUS_DISCNCT		BIT(11)
+#define TCPC_ALERT_RX_BUF_OVF		BIT(10)
+#define TCPC_ALERT_FAULT		BIT(9)
+#define TCPC_ALERT_V_ALARM_LO		BIT(8)
+#define TCPC_ALERT_V_ALARM_HI		BIT(7)
+#define TCPC_ALERT_TX_SUCCESS		BIT(6)
+#define TCPC_ALERT_TX_DISCARDED		BIT(5)
+#define TCPC_ALERT_TX_FAILED		BIT(4)
+#define TCPC_ALERT_RX_HARD_RST		BIT(3)
+#define TCPC_ALERT_RX_STATUS		BIT(2)
+#define TCPC_ALERT_POWER_STATUS		BIT(1)
+#define TCPC_ALERT_CC_STATUS		BIT(0)
+
+#define TCPC_ALERT_MASK			0x12
+#define TCPC_POWER_STATUS_MASK		0x14
+
+#define TCPC_FAULT_STATUS_MASK			0x15
+#define TCPC_FAULT_STATUS_MASK_VCONN_OC		BIT(1)
+
+#define TCPC_EXTENDED_STATUS_MASK		0x16
+#define TCPC_EXTENDED_STATUS_MASK_VSAFE0V	BIT(0)
+
+#define TCPC_ALERT_EXTENDED_MASK	0x17
+#define TCPC_SINK_FAST_ROLE_SWAP	BIT(0)
+
+#define TCPC_CONFIG_STD_OUTPUT		0x18
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_MASK		BIT(0)
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_NORMAL	0
+#define TCPC_CONFIG_STD_OUTPUT_ORIENTATION_FLIPPED	1
+
+#define TCPC_TCPC_CTRL			0x19
+#define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
+#define PLUG_ORNT_CC1			0
+#define PLUG_ORNT_CC2			1
+#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
+#define TCPC_TCPC_CTRL_EN_LK4CONN_ALRT	BIT(6)
+
+#define TCPC_EXTENDED_STATUS		0x20
+#define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
+
+#define TCPC_ROLE_CTRL			0x1a
+#define TCPC_ROLE_CTRL_DRP		BIT(6)
+#define TCPC_ROLE_CTRL_RP_VAL		GENMASK(5, 4)
+#define TCPC_ROLE_CTRL_RP_VAL_DEF	0x0
+#define TCPC_ROLE_CTRL_RP_VAL_1_5	0x1
+#define TCPC_ROLE_CTRL_RP_VAL_3_0	0x2
+#define TCPC_ROLE_CTRL_CC2		GENMASK(3, 2)
+#define TCPC_ROLE_CTRL_CC1		GENMASK(1, 0)
+#define TCPC_ROLE_CTRL_CC_RA		0x0
+#define TCPC_ROLE_CTRL_CC_RP		0x1
+#define TCPC_ROLE_CTRL_CC_RD		0x2
+#define TCPC_ROLE_CTRL_CC_OPEN		0x3
+
+#define TCPC_FAULT_CTRL			0x1b
+
+#define TCPC_POWER_CTRL			0x1c
+#define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
+#define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
+#define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
+#define TCPC_DIS_VOLT_ALRM		BIT(5)
+#define TCPC_POWER_CTRL_VBUS_VOLT_MON	BIT(6)
+#define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
+
+#define TCPC_CC_STATUS			0x1d
+#define TCPC_CC_STATUS_TOGGLING		BIT(5)
+#define TCPC_CC_STATUS_TERM		BIT(4)
+#define TCPC_CC_STATUS_CC2		GENMASK(3, 2)
+#define TCPC_CC_STATUS_CC1		GENMASK(1, 0)
+#define TCPC_CC_STATE_SRC_OPEN		0
+
+#define TCPC_POWER_STATUS		0x1e
+#define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
+#define TCPC_POWER_STATUS_UNINIT	BIT(6)
+#define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
+#define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
+#define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
+#define TCPC_POWER_STATUS_VCONN_PRES	BIT(1)
+#define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
+
+#define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
+#define TCPC_FAULT_STATUS_VCONN_OC	BIT(1)
+
+#define TCPC_ALERT_EXTENDED		0x21
+
+#define TCPC_COMMAND			0x23
+#define TCPC_CMD_WAKE_I2C		0x11
+#define TCPC_CMD_DISABLE_VBUS_DETECT	0x22
+#define TCPC_CMD_ENABLE_VBUS_DETECT	0x33
+#define TCPC_CMD_DISABLE_SINK_VBUS	0x44
+#define TCPC_CMD_SINK_VBUS		0x55
+#define TCPC_CMD_DISABLE_SRC_VBUS	0x66
+#define TCPC_CMD_SRC_VBUS_DEFAULT	0x77
+#define TCPC_CMD_SRC_VBUS_HIGH		0x88
+#define TCPC_CMD_LOOK4CONNECTION	0x99
+#define TCPC_CMD_RXONEMORE		0xAA
+#define TCPC_CMD_I2C_IDLE		0xFF
+
+#define TCPC_DEV_CAP_1			0x24
+#define TCPC_DEV_CAP_2			0x26
+#define TCPC_STD_INPUT_CAP		0x28
+#define TCPC_STD_OUTPUT_CAP		0x29
+#define TCPC_STD_OUTPUT_CAP_ORIENTATION	BIT(0)
+
+#define TCPC_MSG_HDR_INFO		0x2e
+#define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
+#define TCPC_MSG_HDR_INFO_REV		GENMASK(2, 1)
+#define TCPC_MSG_HDR_INFO_PWR_ROLE	BIT(0)
+
+#define TCPC_RX_DETECT			0x2f
+#define TCPC_RX_DETECT_HARD_RESET	BIT(5)
+#define TCPC_RX_DETECT_SOP		BIT(0)
+#define TCPC_RX_DETECT_SOP1		BIT(1)
+#define TCPC_RX_DETECT_SOP2		BIT(2)
+#define TCPC_RX_DETECT_DBG1		BIT(3)
+#define TCPC_RX_DETECT_DBG2		BIT(4)
+
+#define TCPC_RX_BYTE_CNT		0x30
+#define TCPC_RX_BUF_FRAME_TYPE		0x31
+#define TCPC_RX_BUF_FRAME_TYPE_SOP	0
+#define TCPC_RX_BUF_FRAME_TYPE_SOP1	1
+#define TCPC_RX_HDR			0x32
+#define TCPC_RX_DATA			0x34
+
+#define TCPC_TRANSMIT			0x50
+#define TCPC_TRANSMIT_RETRY		GENMASK(5, 4)
+#define TCPC_TRANSMIT_TYPE		GENMASK(2, 0)
+
+#define TCPC_TX_BYTE_CNT		0x51
+#define TCPC_TX_HDR			0x52
+#define TCPC_TX_DATA			0x54
+
+#define TCPC_VBUS_VOLTAGE			0x70
+#define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
+#define TCPC_VBUS_STOP_DISCHARGE_THRESH		0x74
+#define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
+#define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
+
+#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
+
+#define tcpc_presenting_rd(reg, cc) \
+	(!(TCPC_ROLE_CTRL_DRP & (reg)) && \
+	 FIELD_GET(TCPC_ROLE_CTRL_## cc, reg) == TCPC_ROLE_CTRL_CC_RD)
+
+static inline enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
+{
+	switch (cc) {
+	case 0x1:
+		return sink ? TYPEC_CC_RP_DEF : TYPEC_CC_RA;
+	case 0x2:
+		return sink ? TYPEC_CC_RP_1_5 : TYPEC_CC_RD;
+	case 0x3:
+		if (sink)
+			return TYPEC_CC_RP_3_0;
+		fallthrough;
+	case TCPC_CC_STATE_SRC_OPEN:
+	default:
+		return TYPEC_CC_OPEN;
+	}
+}
+
+#endif /* __USB_TCPCI_H */

-- 
2.51.0

