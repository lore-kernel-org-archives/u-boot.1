Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904ACCFB424
	for <u-boot@archiver.kernel.org>; Sun,  6 Oct 2024 09:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6C188C9C;
	Sun,  6 Oct 2024 11:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jYDdSVgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A5E88D3C; Sun,  6 Oct 2024 11:06:59 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7693888C9C
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 11:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP8IuBLItgA0J5ZpfK6kVXeUCclkfqqN/N4VGo3aqfsNz0OQjXAkC4t7skYLlLctOMUxjz4XqGwBd8HYM3QXCX1kczdrw85DT7IEZPcoHXG6W0fT9Wm++iefDAPkddvJqHIhx49YCsQ+mq4Ym9xgduVVGocobLv788zo5qoEKspfqTUPbzwWlrtSf2IGkX6qhuU1KjSorvwt4M1X8WUjpNSLMDiluo8cYWhMWDF+bM5h5wqc/ECoeHvJMvEvDTT9KT4SIoiCKbUt2VqZtstpKDxCd+LwBAaUogS+MUUUVY3VeBClMvr7a3acWrLS8nPp5h2idAHFl/ftEbLY9q2rPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Vdt+B0Nc9UPHSIdOoNFvFT4ZAPlx4WuSZAWu3fT4mE=;
 b=SwlicnlNOrYbmlrojq5vti/aD14qHxiFKdV/4ur6kKNtNk36Y1iLdsYFGl1eMiCXTez+NcvtyQ2Tl7XYxBPLr1hPbvOYxLdbHfCP9l4PvmaCS/wCDPILeYcZzVwhaBGlp16nUwhWf0mLE8LZKwNYLiAWbswngSzRnBXS+j1PDvGV02bsavSK3UxHDbDMRUFF7ioaXDeMPge2vpaDbHOo8CyPnglPCRIHjPwUotmFvtRDVoIbmh8/tkewN4lbWOEBJyVrQdJhCuRb3oAKPKwzP5b7Ccv1wgzlS8LJDdtNmazWmLTNeOzmjl1aH1O5ZTKAqSkRwfL/xAcMInCHdqh62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vdt+B0Nc9UPHSIdOoNFvFT4ZAPlx4WuSZAWu3fT4mE=;
 b=jYDdSVgLwfE5LRio8GO6jOnzPpHPnx/lDQoezbSxrMvozzptj65hIVHHfHmsJpb1hEMoHWz0Q9bbjrqQRvSThqOhNOZSSiGd9Iql7kIwgd3D+xadarFIx3tx3LWuNKBJK4/S6LOlRIoudFgjWlR2H2Ngkq3XZMcx1rT5PXtWXkCKPliW/yurFk+7JwOq4POyo7rwTnjol/0ThCMjMcfxD9p8+JVDfKGVJo/5JGaj1N82A4V7H6OZpLRcbCfJ8KGde5BP7Zysk83UobyROoD54nSY33cR+9ZmMo6QF+jpTl4WVgNg8QNZqAr+oBGdTEJgOo0sJdEGkcLkypyEDqeMhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 09:06:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 09:06:53 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, akashi.tkhro@gmail.com, sjg@chromium.org,
 etienne.carriere@foss.st.com, ilias.apalodimas@linaro.org,
 Ranjani.Vaidyanathan@nxp.com, peng.fan@nxp.com, ye.li@nxp.com,
 pbrobinson@gmail.com, festevam@gmail.com, marex@denx.de,
 Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v1] pinctrl: nxp: add SCMI pinctrl driver
Date: Sun,  6 Oct 2024 17:05:40 +0800
Message-Id: <20241006090540.2799505-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 73192197-e0fd-4bf1-5d4a-08dce5e63869
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/OhjZ3N4AeCnmEjJOpAy/Ef4cyCvgloCzVeV8bQvi8LkfxYjdN+PBDUNyNi?=
 =?us-ascii?Q?seF8ZzoJLR6HoUY/spo1i9ilkWCm4LInKfVOkOLblyVk9ZaR5fkzlqFIjKgK?=
 =?us-ascii?Q?/fqmDqDJIq7KPNcQq7mAwNb09b/0qsLJmw2r01Y0+oXYgE2RAP9JxiCsPWiO?=
 =?us-ascii?Q?Skin3NDAOuk0TsXwbvRwE8AEwdLzpeKDFHs1Ml38Jm8Q+XEehpRy/BTlBkOQ?=
 =?us-ascii?Q?gug74RgdRg24TnKscJmcwXgTt+Whx7uNIKOwQc5uOtcrdrP66Ly3x7C15gC2?=
 =?us-ascii?Q?70shDoAiSOx7vxtatdAdWWa/dIYg6khuYG4m1AhyRl8aZQK9KYVijuDfbzUa?=
 =?us-ascii?Q?78OrpI1itzey+hnzl4pBf2lNwlN2ZYKxHCFPnYf9Tax60sUH4yC7+5PwRRkJ?=
 =?us-ascii?Q?pho+zi2zoqLwVQDI62txGaynMQLeDqfDE+WB4dukVS5BhKSEU2lqoO1eoD6M?=
 =?us-ascii?Q?gpuCpdBKbsNr7iA6qfvR9ER3I2Ve1J8K7ShjGzcHkZI67y0BWDgSwHDh8drE?=
 =?us-ascii?Q?JUvnqs4nIStWWlfFrcYMkjbhRzCxuUdQ5sNwLlvLNYbOqidW76y9doe5/m6X?=
 =?us-ascii?Q?XTzA2phqQgX6EA5SiC7DtZRWLMZLyDog3wCLsZOLl3E3iQuPPKhfK2pv66jA?=
 =?us-ascii?Q?nXvuo3+UY7XfYSemMgFgtFQozqkQzO0K5ue2FtucATQpKkbAaka09oAFRGD2?=
 =?us-ascii?Q?Y2zuZ6EdIMbtmL8pIIo2tmmt2XUU9UnRwVU/xUsFxCw9j7IrM8IQAz4csgiu?=
 =?us-ascii?Q?EbroQY1xZAHyl405d1Ex2WWw6RSMyVD0xxAiZ7BtWsd2+9k97jx++GHMKrPv?=
 =?us-ascii?Q?F1w7xJmVpVPn5aRpyjHwOhiVEXPieN900U5XEO7U8ora5/PefCDr5iooiH6i?=
 =?us-ascii?Q?ejb8O0YbNcmTKo5OUYgSzQxdDphkTpgybY6eYCGFhSg3fK8/VOB2kn7HA/jg?=
 =?us-ascii?Q?SyYIs7T7wPVLX7Fq7hQ9YWIKKqh3jJ97E8i1k2kKTB6G+fXZOyF/NJ1ROvyu?=
 =?us-ascii?Q?aetyJggCJ/VxQNJmzNN7Mo+IiC63XCaZOW3sRg5ayllA7j/V5YfAEQwt90LO?=
 =?us-ascii?Q?6sb/Peo2CA645Pm6HIYeLKopMI69lQG1+RZPfjuQBCxTg+2S6FEUqtXhuy2d?=
 =?us-ascii?Q?Ty8hqoTE7Hxwjzlp2rrjUo3pdS721/Y4oXoGYwcUj4TxFSLD+9oUI9HTIDRZ?=
 =?us-ascii?Q?7qepekTd88pBbEAvD5cRdkspPQAZGSLIl/duM0zlTBSKYC0pBaQtbXlRJQVW?=
 =?us-ascii?Q?vK5R9hHTj5G3KOfOXDScRF4Fl1Bg+JdFCFLDRXMArSElSGsusdSU4nGwX3XK?=
 =?us-ascii?Q?9CPtNBALtnQzJT8OHLhaz1iB7c+ANhI9fp+wuPcuT8aSew=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAQajaPJ0rNTfTYUYCHIw9frFnkvS1xkMmRrzn5Q5g48tbQ4sbmkU0o1ZTL2?=
 =?us-ascii?Q?7kUKPViTb6ZlJADn486RZutZ0n4SSgAYrWXKIiglWhIX+stcgpbn8PVO48jU?=
 =?us-ascii?Q?lQM0kwai7Rh4IrUiQbzGUuHSVgEIbDqFJTBJ9KnBJE+BeTFVMFcb+A0n02tK?=
 =?us-ascii?Q?nsHkd6MP1nuXG8ZI6Mffn835msf1NYlIQzLsjoqd00mveXEzTafIxx5aH6kl?=
 =?us-ascii?Q?qG7hh6lIl72EiLdiGtY1zmLK7jcEvtZDRAO+ARHkltOEPWojyBTbsYzuDh2Q?=
 =?us-ascii?Q?c2ijPe9eawWR9ciigaln99f2Dhc8TBX+p9xdLEvZznBSzBSqTLz58zMaJHNF?=
 =?us-ascii?Q?Z9e2XH3is36NKF4JH3sDzX+hpxzGZ/6ERYuM+n6otm30S8YJfmc5xW8761ns?=
 =?us-ascii?Q?KcIuhTCgFOZl9zjbpNizd5aso8uokLVcjFau3E/sfVEOMPkM1qmN+wwfQyaJ?=
 =?us-ascii?Q?ZwXXZVJeZUchKiOCa1KZGrrYEOPqpnDXiFCccieRUuxqSLoSDbgbGDD7yhZL?=
 =?us-ascii?Q?Xg/vMQOy/KQs8WwyuUdrmmsFd2csWXwLltL/V3TuLHWRq6JpZH3rqIqols3c?=
 =?us-ascii?Q?twYe3q+4v0X5gXF2PS7nZPaLyqeX+DofzyCW7qCer6JK2k/2Sa3mYT65Cb2W?=
 =?us-ascii?Q?oMOnOuZXyrXbGKq14peIs0x43GnzeHPOxe1H3y208lBbVeDh8RBlj3ummHfS?=
 =?us-ascii?Q?puuspq3RGmk0DtH4bGWbv2SakiZ/bVNxfmp8WL8GBm+lwgJEgnFcDCGoiYqv?=
 =?us-ascii?Q?NkaDwWDNdcyK2QgdwVB/VPUTcko9/GkLMP1c2VwjHoKiTKzHfQFTiPYw/lZp?=
 =?us-ascii?Q?Cnw9NZ9ix3fR2DCsLjqcGKRm5y7hDduRPBOvj55vdrlIKZSOe26W9Ko8gtdt?=
 =?us-ascii?Q?HDHEsB+u0HWsXyKCuMHxAODnFWkN81bApWKerY1F2Wa8rljDLR8hc7C3NGvZ?=
 =?us-ascii?Q?iZsVeylXWn1fNAxjg/GC/s4UdITOzdYowNIkcpm8J6YFS+qz3ytDtkZ1wXyn?=
 =?us-ascii?Q?4ZMM8hE20/McmEMG8o7aWsAgeUxOkboEuZdOUWt3Edm3ZYjKOsOe7mGGFna8?=
 =?us-ascii?Q?yoRKe37+2igYdNlChwQK0lnMlX52aKQTcnefNIEeGpCeIsmekb0fOXsnRDhI?=
 =?us-ascii?Q?gTXCEKUdO04J2VMCu1c5g5NTfV0LJ5TjrQKvXoZBaU6SLIIhNDNeWRQbWgD0?=
 =?us-ascii?Q?jU+UcX+7SRY92+9QaVGaVE7j+IKcnwlVdas4HlewzxFSunLiaEa6t4M6YEi7?=
 =?us-ascii?Q?2JdYTygjE4QwO4ZETiTbdCheVeopWPSoGiPe+mYPR9pf9RZt02EfbkLAva0Q?=
 =?us-ascii?Q?N5IlAMYjZf1sg/w0BJPWQPyqOXkxAI+2LijE1dkk9uBr+1maPjTRyVxXCUCT?=
 =?us-ascii?Q?5oUXHyhaiQu0vPaYrDJ3mSEOHNjWboMdPLLEF+E+FktREzTa52yfcGGTTpDQ?=
 =?us-ascii?Q?8PVzF1SCBZ7hw7WcwfMbxIeUqoMZjZJEFsUtMAC5K1EiFT242babuK7jePQ1?=
 =?us-ascii?Q?9KBODrQZNW7N8z8tg8/a42iR5bXevJ9Ic0mviNuFYUZ0xikOxDKr9wiQHiga?=
 =?us-ascii?Q?KSG0j7jLY8m5C0xMwnKJmxCQLH7ERh49BnoNua4r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73192197-e0fd-4bf1-5d4a-08dce5e63869
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 09:06:53.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/cvqjscuoHrAckMYCSUdsASM8lYoyo8rWsuy1u3v0n8f/yAD7ogI357x7d9LNLuAUdezbNysxIzqK1MvzTQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
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

Add SCMI based iMX pinctrl driver to use SCMI 3.2 pinctrl protocol.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c |  11 ++
 drivers/pinctrl/nxp/Kconfig               |  13 +++
 drivers/pinctrl/nxp/Makefile              |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c         |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h         |  11 ++
 drivers/pinctrl/nxp/pinctrl-scmi.c        | 136 ++++++++++++++++++++++
 include/scmi_agent-uclass.h               |   1 +
 include/scmi_protocols.h                  |  28 +++++
 8 files changed, 206 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-scmi.c

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b03..6b9d8361c2 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+				scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f..0086f98258 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,6 +1,19 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx pinctrl scmi driver
+
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
 config PINCTRL_IMX_SCU
 	bool
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef18..3ec3e2a9c6 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index ff466c4910..496aeed219 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2023 NXP
  */
 
 #include <malloc.h>
@@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	npins = size / pin_size;
 
-	if (info->flags & IMX8_USE_SCU) {
+	if (info->flags & IMX_USE_SCMI) {
+		return (imx_pinctrl_scmi_conf_pins(dev, pin_data, npins));
+	} else if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
 	} else {
 		/*
@@ -215,7 +218,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
+	if ((info->flags & IMX8_USE_SCU) || (info->flags & IMX_USE_SCMI))
 		return 0;
 
 	addr = devfdt_get_addr_size_index(dev, 0, &size);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2f..3cbd5e2607 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2023 NXP
  */
 
 #ifndef __DRIVERS_PINCTRL_IMX_H
@@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
 #define ZERO_OFFSET_VALID	0x2
 #define CFG_IBE_OBE		0x4
 #define IMX8_USE_SCU		0x8
+#define IMX_USE_SCMI		0x10
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
@@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 }
 #endif
 
+#ifdef CONFIG_PINCTRL_IMX_SCMI
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
+#else
+static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	return 0;
+}
+#endif
+
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000..1e8a7fe6af
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include <asm/io.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <linux/bitops.h>
+
+#include "pinctrl-imx.h"
+
+#if defined(CONFIG_IMX93)
+#define DAISY_OFFSET	0x360
+#endif
+#if defined(CONFIG_IMX95)
+#define DAISY_OFFSET	0x408
+#endif
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	int ret, num_cfgs = 0;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs - DAISY_OFFSET) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+					  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out.status != 0)
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n", mux_ofs / 4, input_ofs / 4, out.status, ret);
+
+	return ret;
+}
+
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	int i, j = 0;
+	int ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM)
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+	}
+
+	return ret;
+}
+
+static struct imx_pinctrl_soc_info imx_pinctrl_scmi_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID | IMX_USE_SCMI,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get channel: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s %p %s\n", __func__, priv, dev->name);
+	return imx_pinctrl_probe(dev, &imx_pinctrl_scmi_soc_info);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+	.priv_auto = sizeof(struct imx_pinctrl_priv),
+	.ops = &imx_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30..511f0063a9 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -43,6 +43,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36..e52c740cb3 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -780,6 +781,7 @@ struct scmi_clk_attribute_out {
 struct scmi_clk_state_in {
 	u32 clock_id;
 	u32 attributes;
+	u32 oem_config_val;
 };
 
 /**
@@ -1005,4 +1007,30 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @clock_id:	SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.34.1

