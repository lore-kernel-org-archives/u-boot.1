Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABCCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6EC838BB;
	Wed, 17 Jun 2026 09:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f9qWLRxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A560B803F0; Wed, 17 Jun 2026 09:06:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C3484962
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GngVFY9Iz6YHGhGSZQoC/NiwkXHI7SxxBBvXNMAOjL1gbAogKjLvJmOFXnqoek45cxNbJteu2zJy6mkamrjQ7m2OlN+NwRj2jFZdmoo94MnVR6/8awXdIcQef5Osu4gPKHb9W1yorn1BIkpGE3rk8EaqMx+ZhGBUaIGBOseptWZIQYRUTj6eXsNpJDqa/SbqgRbKHM0bTl6JnC6e6fytaJDXnq/yjQilz4oqbPaGxbAMeXw2+XSPgxO6C5fa45fZRG3d6Ly3LxS8weBrUNGU4p6hrMqLeT4uNamadYLMHDx5sM7sykw/NxpMk/g20UB0d416z2P8DvFkshb5PmAVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruuhzyD8ydeVgSGhPAYu5unWoAEG/yaLypc1ATkysus=;
 b=BkOCLVN8c9Cj7XvdCXzbPc0+lDOtNXD3JYDJ9CnSWLDQZoPNnipuYX4w8pt7s0LM+bVlabHts+tHdPt8xJVshCrbwjt8s2aWkuu0GOFy9TyR2bjpc2AUjHFYnUR9nrx5cxqms6PownY5KeYHQJ9Riu4Y82aGmXd4uo1nhpelz6a8DZx8L0l6nk0LyX+LXiGFWgxGTULaqtzqVqAIRMkw9mXZbsen7zbEZjtjA3WLYPclITWlXohYRhRtzqBu1a8Fny/pMmWpBow9fdhuS+i+oJ9Dz1eEtoit1mwnSf76lLqW06Gi8WD33ykuykAzdaiH9xm5rZQW4ZtF6ISPHexwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruuhzyD8ydeVgSGhPAYu5unWoAEG/yaLypc1ATkysus=;
 b=f9qWLRxDYruHNYc3mHB0jlh/dpoc14m8SAU+pG+noVTeq95M7uwJrBL9gG5SQxg1ju9zcPsBeb8e0iuzUQtOHDEsxdKzfkmJJRmeeJVyBsgCu7bzleRaP147JJDbS41reVw9ipQqA7nYXwe3MxCAcJCP1Zu38eOzpwim1IiLuBiXznA1AGAS/iZbIpd9m9eu5UuIU0YI+8uAqDXXmVwrhUmJuSnTcyPT6pxgY6frH386wOmqo3JtiFErrt/5JafX8Vu5bimV78A0WsZcXJDqIxbFmCRvywQw3PgckovgSv5qCmvr7q0skg9zaOWm+FmfecyyjS5uAYUOa2/J36dAhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:05 +0800
Subject: [PATCH 06/11] usb: tcpm: add
 setup_host_mode/device_mode/disable_src_vbus APIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-6-b824fe1e9299@nxp.com>
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
X-ClientProxiedBy: MA5PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e2523d-9e1d-42cb-a8a9-08decc3efc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: GcC0R0JkpWVDSJBcbR1ZbsJqE/Or6loVFZsZWMkL8CUPbiQ3gByINfRT+Uyiv86jIUwVXfNAkzMACXVfcFW25wYZJmijFER1cq2zyJ+DFNGe/2BoLsnPBi0H0qn7fZro0GFIZ1wiwlQAi6O6gbDBo1lH1Sbp5pqri/9+lnGPnxTQVSocw67dkut4EUf7zDxJ0XjejUyVtTnEpTB4Si+uS1f3EWgAB4gwrPYxgMD2f0koqpmhRIOxCgjkfrd8m9SZ/O5z3mefV/W55VCs3ll25N5daLdS6pKBZAY1Ckq8YwHrFYBrf56T3vMx/Yy+UH6Wl35NN9hp9ITc5Hd3odg2MhW91OzRxxGDtc0aIfDWHh119W30LUvbqUWSQNSAAbFSDszo93pTRZVsMF0Aj+2kq7tqDcIwU5jDwBq6VjprGn/0G3apC6iMHU55BNPQyBQM1lJPgfPkBC1AwwTvYr2TozoOtlFYY2CkVbELJo9+TUcUs73wRLoF4qgwlmXrBnFuI4h8kSanU6Mm+QR5wofHFWIVZZrts5Y0cms1Kn1DnlVSivbj0vH5Zvi5/nnJgUx17uDvqNt9+2ItUiAb23kUkNl4husm7LUfa0zh2MJWhTOr9C+ve5au9iCRIty8bEFHBijwl8h41/UJ+8s9PuNY4rq7GFIaix8cBkm5vYqyea7VRHn2/r/Ka+MmWgBIyqBi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhIc20wM3A0WTByV0xncUFLVW1Ka2Q1ZmtuVnFNLzMyMmRsbEs2aHVWaENw?=
 =?utf-8?B?L2dQbFZEK3JyNEZSL2k4YjYySS9Ucm55TVdCTWtTcVArdi90QW1CcE54aVBM?=
 =?utf-8?B?SWJwdFFUNnpqVXlpN0t3L1lDYXBJbHJINHpXTmFiU1ZmN1hPTXZPSWdVYnVP?=
 =?utf-8?B?ZGRObjRvay9xYVVtK1dwRVFta1FRTWNBUkU4bWRSMmdDRXgwekRjYWN3QVo0?=
 =?utf-8?B?NW90ZnJteE1xREJxZmJBSUEra3BqSmJXNGsxbVZFQjlsczFoSTkrUVB0ODFG?=
 =?utf-8?B?V1hvQ2Z5UWVlVUk2YVViU3Y4aVQ0M255YXdXTEw1M2pqdGRHVk00elVTdVN6?=
 =?utf-8?B?NmsxeGxNZE9VaG5aREpHbzhSeTg4UHYyVWh1N2FIYU54VlJ1d2RLL1NiWVZM?=
 =?utf-8?B?KzZHRG9UcGJ3WHI4Mm5JMWU4V0tiZFZPRFZIUWg2aHp1Y2J5Z3ZrNWF6SEV4?=
 =?utf-8?B?MlhBRno4UDBIZ3BPSE5mbUxqWjN2Mkszdk1wOVdOTVlRZ2lUbFU1T0VkeFp2?=
 =?utf-8?B?TEpSQnZSSUxrQktKM1hnNmRMa3ZVcDA0Szg4V0ZkUHl4cGE1ekNhYXBpZXRl?=
 =?utf-8?B?RmZXeVJRaVdqdzRCSDdlWSs2Y1ZCRUpGOVZVai9OVU5EUGVxUXozTnRJR3hh?=
 =?utf-8?B?cWpUMU1YUklPRjlsdjBua21xY2czb28xcHExSUxSbEhmU3pkUWtiYjRtRmYv?=
 =?utf-8?B?TDNiOHo5ZkU2UWNXWnFiMWE3TVFmd3pxd1RQT2pCS3dxNWxyN2lWbURvMzFB?=
 =?utf-8?B?bUt0dHJ4NnZhK2VtdWdDUTkvN01VMG9wcVpxcWhwbEpKcXJkQk5TL1R4dVBa?=
 =?utf-8?B?elExSTVSZkM0bXRSVVBLZ0pFSkV4WmhuWHNjVmZxWFlYbjU2Mzg1aU0zcEth?=
 =?utf-8?B?czIrdStwblBaUmN5VzhZdU9nUjFIbGd2c25uaEMwS1ZKN2J0SDFBUmt1Z21y?=
 =?utf-8?B?dlErSkZvTHk3NDRwL1JKOFhBVVNiYWdKNWlMR1VwTnA0dm1DYy9iZGdRc3RH?=
 =?utf-8?B?anNVTXBWWEU5aTdxL1lvY29zSDJtaFlyUC84STR6Wi9MeDUzY1BnVW1CNTRt?=
 =?utf-8?B?dTR4cWNDa29ISWVjOWl4V3Y5ZDRUM0lDRnA4YnF3SkhXR0puZGoxYjI3UHMz?=
 =?utf-8?B?eFNPZEV1aXhuTjFKOHN6Y1VERWU3cFJMY1JzeEs2ZlBGL2t6N09HM1U1Zjlo?=
 =?utf-8?B?MkdocFRvRzYvMUQ5OEZxM01VbVpEWnk2blVicTBHb0tPY3Z1N1BCOTFZbDVa?=
 =?utf-8?B?elZDK203R2hBN3pGUStLdnYzTzExaGgzQVI1YWdmM0EvS05seEhZLzlVdUNz?=
 =?utf-8?B?S2FLSDRIdEZqdkZBbVVyWEhFVG9VdXlGcGZPOW5MWmZuMk1tRmtmVU9abjZy?=
 =?utf-8?B?VVFVZGdsUGhtVWhaNE5qSjF4aXB2VVBLS2dVNjFuSDA2M2pGNURzcFJlbmY3?=
 =?utf-8?B?MmFYc0l5U0YrM1pHMTZSUVljaDRDaHIxWWJqZ0pySVloaVNzRjVtL2p4U3c5?=
 =?utf-8?B?Sko2ek1yQjNsTzNISHFsbUQyZDJwd0M5V3doaThtMVBJdHJFNVpNY2FQdDRJ?=
 =?utf-8?B?SzRYWDNORk5DR3M3S3pwUVVJYmlGM3pneGI3YVp2RFZmakNPdkcyVGtkTGRB?=
 =?utf-8?B?UE13OW1CMHIxWnNOblFZTE1QaFEwK3Q1d09CN3lWSG5NemMrL0NDSVF1RHpN?=
 =?utf-8?B?ejZhdVdRSVF2eVBNVjE1R1h5c3NYSFZJV01raWI3TU8wNTBaS2hTRjdsQXJr?=
 =?utf-8?B?TzhDUkJtRW5WZHhLVUhaUUdoaXZqdHA4Q0tFNnhZZGZLdE1WeVpacWdPWXNX?=
 =?utf-8?B?U0JQUllMakxMelhmQlh3bXMwRFFlT05OTnFMRTZud1pEZlNWY01FVGlWdE9q?=
 =?utf-8?B?OHhkaE1Rd2piNDM5TktHdG9CTkg2eFN5SXF4RktPK3lxVGwxT214YTJHdUpG?=
 =?utf-8?B?OENnR1lCOFBscmtSV3NiVU0vc2xyRUNYVWgrOXpDY05hWmhqcXoxMzNTZk43?=
 =?utf-8?B?dUhMdDk3anp1UStOaENVL0JYYWMySVgrKzA4cDFzSE9rQTBlck5Mdis5UmVT?=
 =?utf-8?B?SmpKTldaMFdZN3lzYzkzLzVVTWxPc05LaHNwV0RuZ01XUnV5RldIYnNBcnRE?=
 =?utf-8?B?OXBNS3gyam5UTjBhNFdGRldVV0VqQnVXOVdrRDhNcHF5RzcybVhoR0NMd0NG?=
 =?utf-8?B?aVFnTkVvNmYzZUs2ZmZmQUwwbkVlTG5uLzBlTHAyS2MxTTBjeG9QN3VPVkgy?=
 =?utf-8?B?ckVsS3JpOTVjT3lHbVBKN01kWGo5UjBZMlBuN0hsK2ZUT3RKcFNhbFlWTSsy?=
 =?utf-8?B?RE5TcVltUFBaQjd0bFIxZVBoSUpVbTEzaVB6bTI2eXpSN2Y2c2l6YXI0SS9n?=
 =?utf-8?Q?33WUpk7dJzsRKd5IUIZkwY1UYyKVcNjXoFWBB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e2523d-9e1d-42cb-a8a9-08decc3efc27
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:42.6656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8DzfmO26wsQSoCAvFOPBMhGMHBJ+G3s1Ma6uc5IY4BVaqK8gRl5Xy2ldyXv5U018X6P2i3Dr9UTEG0ZSoSL97QY2DQZXo+eKz6DyrBaej1Gi2kMBJHIknqj+sLBlI/G
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

Add lightweight Type-C mode setup functions that bypass the TCPM state
machine and call TCPCI driver ops directly:

- tcpm_setup_host_mode(): set CC=Rp, detect device, set polarity,
  source VBUS
- tcpm_setup_device_mode(): set CC=Rd, detect host, set polarity
- tcpm_disable_src_vbus(): stop sourcing VBUS

These are used by board_usb_init/cleanup to configure the Type-C port
for USB host or device mode without running the full PD state machine.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm-uclass.c | 87 ++++++++++++++++++++++++++++++++++++++++++
 include/usb/tcpm.h             |  4 ++
 2 files changed, 91 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm-uclass.c b/drivers/usb/tcpm/tcpm-uclass.c
index d4fe260e0db..e0f7ce62a79 100644
--- a/drivers/usb/tcpm/tcpm-uclass.c
+++ b/drivers/usb/tcpm/tcpm-uclass.c
@@ -8,6 +8,7 @@
 #include <dm/device.h>
 #include <dm/device_compat.h>
 #include <dm/uclass.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <usb/tcpm.h>
 #include "tcpm-internal.h"
@@ -140,6 +141,92 @@ static int tcpm_post_bind(struct udevice *dev)
 	return 0;
 }
 
+int tcpm_setup_host_mode(struct udevice *dev, enum typec_cc_polarity *polarity)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+	enum typec_cc_status cc1, cc2;
+	int ret;
+
+	ops->set_vbus(dev, false, false);
+
+	ops->set_cc(dev, TYPEC_CC_RP_DEF);
+
+	mdelay(100);
+
+	ret = ops->get_cc(dev, &cc1, &cc2);
+	if (ret) {
+		dev_err(dev, "Failed to get cc for host mode: %d\n", ret);
+		return ret;
+	}
+
+	if (cc1 == TYPEC_CC_RD) {
+		*polarity = TYPEC_POLARITY_CC1;
+	} else if (cc2 == TYPEC_CC_RD) {
+		*polarity = TYPEC_POLARITY_CC2;
+	} else {
+		dev_err(dev, "no device detected (cc1=%d cc2=%d)\n", cc1, cc2);
+		return -ENODEV;
+	}
+
+	ret = ops->set_polarity(dev, *polarity);
+	if (ret)
+		return ret;
+
+	ops->set_vbus(dev, true, false);
+	mdelay(300);
+
+	return 0;
+}
+
+int tcpm_setup_device_mode(struct udevice *dev, enum typec_cc_polarity *polarity)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+	enum typec_cc_status cc1, cc2;
+	int ret, retry;
+
+	ops->set_vbus(dev, false, false);
+
+	ops->set_cc(dev, TYPEC_CC_RD);
+
+	if (ops->start_toggling)
+		ops->start_toggling(dev, TYPEC_PORT_SNK, TYPEC_CC_RD);
+
+	for (retry = 0; retry < 20; retry++) {
+		mdelay(100);
+
+		ret = ops->get_cc(dev, &cc1, &cc2);
+		if (ret) {
+			dev_err(dev, "Failed to get cc for device mode: %d\n", ret);
+			return ret;
+		}
+
+		if (cc1 != TYPEC_CC_OPEN || cc2 != TYPEC_CC_OPEN)
+			break;
+	}
+
+	if (cc1 != TYPEC_CC_OPEN && cc2 == TYPEC_CC_OPEN) {
+		*polarity = TYPEC_POLARITY_CC1;
+	} else if (cc1 == TYPEC_CC_OPEN && cc2 != TYPEC_CC_OPEN) {
+		*polarity = TYPEC_POLARITY_CC2;
+	} else {
+		dev_err(dev, "no host detected (cc1=%d cc2=%d)\n", cc1, cc2);
+		return -ENODEV;
+	}
+
+	ret = ops->set_polarity(dev, *polarity);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int tcpm_disable_src_vbus(struct udevice *dev)
+{
+	const struct dm_tcpm_ops *ops = dev_get_driver_ops(dev);
+
+	return ops->set_vbus(dev, false, false);
+}
+
 UCLASS_DRIVER(tcpm) = {
 	.id		= UCLASS_TCPM,
 	.name		= "tcpm",
diff --git a/include/usb/tcpm.h b/include/usb/tcpm.h
index 10f0515fe12..caa67a5639d 100644
--- a/include/usb/tcpm.h
+++ b/include/usb/tcpm.h
@@ -96,4 +96,8 @@ enum typec_data_role tcpm_get_data_role(struct udevice *dev);
 bool tcpm_is_connected(struct udevice *dev);
 const char *tcpm_get_state(struct udevice *dev);
 
+int tcpm_setup_host_mode(struct udevice *dev, enum typec_cc_polarity *polarity);
+int tcpm_setup_device_mode(struct udevice *dev, enum typec_cc_polarity *polarity);
+int tcpm_disable_src_vbus(struct udevice *dev);
+
 #endif /* __LINUX_USB_TCPM_H */

-- 
2.51.0

