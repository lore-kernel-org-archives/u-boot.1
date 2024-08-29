Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA49C7115A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C42F88AD7;
	Thu, 29 Aug 2024 03:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB5988A75; Thu, 29 Aug 2024 03:31:18 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20711.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A87088A95
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfIs98D+hJc8ILPeP0MsFxw8B+vQZv2sGq/jSFTw/Y833cq4fzRdsvVGDUgTbtNY2yRwhzmPZwn7rnY1g8UrL4E25QiuK13VzC6afTYnY1vIdacNFMhxbVD8Swxk7KWjy3tmlk4auH1k87S1GeaFW85q1RLt4ZsKkAGPd+aUymZ5N6oMF5PHbX52eULjz5tRZOpv3cYalF74ZQM6ZJKC708CigvO7UgY2DLRgaPWpmEDv5mZrqc2uLuowNvoCzkbt0H4os+Wn3io0rV+OwioxTUBE+7XPh6rsaKFlSqJi7XNGpOJYtI2Y4PEj6LXK5wH6m3fOlV8/+1YMBqzTM9tlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDZ4j+h7uR2b5Nnj3PrAHWen7gzNZDHPmpjKp5cAKdQ=;
 b=R3XAuzteXhEMxn/0zaqKogXuUCzj3ufXIXsrsfg7VSOtxnF+Hh0ft46mTxOPPLclJnmNoyPlVkftJR6WuagTjZaNtharfwOpDu7cFz2uK/x/UyGKgXXUwyKM4YSecOG6Kx+vLf7afgtw1ku86w6YQdSVqSgtbTFESw21wo5z760Xtxg3RhWetxmw1xjEsQDjZIuhjjmvzKCcoUYY0H54WT6arIEXTH7JY9+qLummb03lszb6W1dZR7VI63/75CJEboc1sdXfquXJsLNPnloykgfOymew+Q/OKXc8Qd6Fq3eOzWoy87FkLgePYFC3JCLBZFs+QHg9jPJtUOcK/tPHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0830.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:31:08 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:08 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v4 1/9] usb: cdns3: Set USB PHY mode in cdns3_drd_update_mode()
Date: Thu, 29 Aug 2024 09:30:50 +0800
Message-Id: <20240829013058.6178-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0830:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f2f509-fccf-44df-5d2f-08dcc7ca421e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: uhmGuhknIr21TLY06z92VewbKdv836SnQmeeMOsMYQMxqU62fTjsrYHra7z5mj38L6cnj/bQTGQDXzCk6bIunqf6YRI4vmviFN4KiX2G9n5K33zoEOzLMVcgHoLqyNuMbHMp+YZIGH4z+Cu3EccZPO0Mi9fl/yfvHXpF9JA8ykLUBPeLNPI7Ojcdz/RwrK2+JBWzFfnjEoHQT9dmgYUmfbdFMLzxGB0ywYKGLv+ok4MUgh3D4SRRydejGX16jb9e9o/8FQuIenTmo4zPbPiPKWFF/DCHysXHo8XCyLEgHEeGyeFnqaaIkWLnLBmaRDRmXwBCLjQqpR/5zFdt9LesSa9g3XIyRy7rJKSlDya0J5x9l85TY1LdVHxQBPWdBaVVZMK+t6f1S9m8ACVubNlJEGrp43yn+KdeY/hYEKkTfwUqSWwfWBlxXNhkmnURACtnRF21AV/flDI0hk4hmMyW0HkB83yfTdyADFBlxsknctY+RR1q0sWEUHk5jG2hOxhhN4rVB88Cm17QwuDXgjGXUyU/pcvHVym2aHaxqXZpDI7ZAejlfdd/63e3TYFznGfcKyofGygv0pQbw4foMTtz96wuOVGtL8sA0Fj7y8KQXMl+v1noSI8x2DHLl8KfoOnbyBa1fijOYdsk3/3q1UEMrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(52116014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Am2enKlaqgOuv4SJgd/J8t0MZH0lZ+eh9AiQyvN0Tkztx+tZNctanGU96Jd3?=
 =?us-ascii?Q?oFrI8vbIg3yM7kknqBaXNasndpDfjo6IU9x7QBGXpHIjtcuv6F8w7tOh5BXX?=
 =?us-ascii?Q?W1NRpKIu9QNoa5e5Nq/k4E9MriTLHWA2aN4VAJkiDIT+AN5zXQfJr+9D7yHY?=
 =?us-ascii?Q?a3BdD1Vymr5K2XHKG8CwiVS+aWuX+w6vIl7ouU7EyUn5Va1FrUgw4O2x9vmG?=
 =?us-ascii?Q?Ohwk2VBFejN2jIXeL0fA0Bkw6SSWtQD/u4K8LG7cj62mYbs54r+YUC+8M0pi?=
 =?us-ascii?Q?xuR3+RDxa2OYjmix6Ch8QPZ1qveOEHx6xdflJIsYVCIxaYVh9M0fKsd/RXM+?=
 =?us-ascii?Q?CdgGvnJDFOQkTazjisLOsaRAlbTnuCbPdLoWd21D+5D1LsjPnt23RU+969il?=
 =?us-ascii?Q?3guCAutmWWFwUOpKtRh3VlKer3M9jFhYyN60tPJh1MVBMmL8r8zlHE7/+s/s?=
 =?us-ascii?Q?z20VBfNK/M78fiqYIKcS7c86YWNnX+g6G8UF7N7V1oIlET8LTGNfvCg9/cf8?=
 =?us-ascii?Q?756UUY8RG7CWSgHJGMLo7/XmTtAFo5GYJk873AqQgc15DJnlA6LkKuKxArrw?=
 =?us-ascii?Q?vT7e96TcWu1mw3+0sZWFVPTShUPiI4A5FQhWE11oIxw703YoJMcIbNnGz1BM?=
 =?us-ascii?Q?dkUWTzjWQZYWppT9JKP+q1LE1eIOJlxp7xtC/5ocCTfeL/Bt+ULcL++2Oa69?=
 =?us-ascii?Q?xUt3dZqFYuGBQ0ubEK1VUVykmxf0BzlvwZ1xzf1l1SSEpU9qOiY7UMtT3dio?=
 =?us-ascii?Q?YRbO5fpFhdN2FfmJAEYpQ/h0w/k7VMggiFBVt898eOA1X7pgfNhuC31OmthE?=
 =?us-ascii?Q?G6AAkLa21h46wXKzfi+pNFGWa1Mha0DUHJmM1wVgRx4wBWSmAOMHY7miqg/K?=
 =?us-ascii?Q?kedfC3HL7cDLhDnMv4D9swwT7aCLbznYjPRNM6lEbVqOe69czEWiOUbG+yO1?=
 =?us-ascii?Q?ac/5m7fKVW4yF9DP5V4h+vsfIOwQ0DgSFlI2oXuC+Hd+sNAeYDxNxAvz432J?=
 =?us-ascii?Q?zrJiLJ+umvhE3/r7x6hUf28fJU5lDVYjqvg39M+wlO9oLHvFUgcr/2cBu1cL?=
 =?us-ascii?Q?HZBkyKdiZc3duc9AC5+O3cMkxjC1KzxWQpS5QimxiHjtlePqvrgZLvCZIRJ2?=
 =?us-ascii?Q?zgaAjdnFzKh1umeih03VQmtqMXSBcr6vMOVP/j53mxBYieRYEFtpBjW7pRG2?=
 =?us-ascii?Q?2HwyA90sf+C837FovGkFxP1lxeVXk41/R0s0NEg0CQ8MA+KWnVKLYWluub3J?=
 =?us-ascii?Q?DMzG/FvMfccql/H2pGS/zL6CzNhjzf5D0R/xOobv7elJw6YftpZR+AxhHNI6?=
 =?us-ascii?Q?OaaYfdVe5YxHhLGxJ+LqjAqQWHbvE4vsiZfh6FDqxtuUDUIrURvFp0dnj5Un?=
 =?us-ascii?Q?ROuVAT/p6m7p59b/HERFmarl5SYnUM0YvykLn2iH4YJErHdxBPshI47D2e95?=
 =?us-ascii?Q?vxrcaCbc+dcERthoITaUyZpBIxWfz0+/JpXngd2geO7CA5A7tMLNd4utL0zQ?=
 =?us-ascii?Q?9DPiN64B1g9WzLhPPIiTf+8pZSghtUdHrnyHz8eTeP//eRrtT+nunX3wcQ9y?=
 =?us-ascii?Q?faVgHEXENQrq45jv34lO/NAy1GcTqGWN352Xo0rEr6XTXVBpDp+kI9mDQ6tT?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f2f509-fccf-44df-5d2f-08dcc7ca421e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:08.7327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PbJWIX7x31jGiX0Doq84jUfiSeMGV2+cXPNE27zz03sSrreX5zuZMgsmNwafjeF46GxiJTSnzi7bov2BT92ZwdZPjsrXp84RyyAqZyQc0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0830
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

USB PHY maybe need to set PHY mode in different USB
dr mode. So translate USB PHY mode to generic PHY mode
and call generic_phy_set_mode().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/usb/cdns3/drd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 47874fec29..cbb1334234 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -217,15 +217,19 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
 int cdns3_drd_update_mode(struct cdns3 *cdns)
 {
 	int ret = 0;
+	int mode;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
+		mode = PHY_MODE_USB_DEVICE;
 		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
 		break;
 	case USB_DR_MODE_HOST:
+		mode = PHY_MODE_USB_HOST;
 		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
 		break;
 	case USB_DR_MODE_OTG:
+		mode = PHY_MODE_USB_OTG;
 		ret = cdns3_init_otg_mode(cdns);
 		break;
 	default:
@@ -234,6 +238,16 @@ int cdns3_drd_update_mode(struct cdns3 *cdns)
 		return -EINVAL;
 	}
 
+	ret = generic_phy_set_mode(&cdns->usb2_phy, mode, 0);
+	if (ret) {
+		dev_err(cdns->dev, "Set usb 2.0 PHY mode failed %d\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_set_mode(&cdns->usb3_phy, mode, 0);
+	if (ret)
+		dev_err(cdns->dev, "Set usb 3.0 PHY mode failed %d\n", ret);
+
 	return ret;
 }
 
-- 
2.17.1

