Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EFFCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525D4847AF;
	Tue, 26 May 2026 09:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UaFKM++X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0407B803C6; Tue, 26 May 2026 09:53:45 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2791184702
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TniMT9eCMXQ4UKP+77onQnDyo1LSMbl1ppzrCxRa/dug5Bmk5xGzs7ndOV/Zf2U1TtG35xxASOm6gVUz9fHgjPOwPUBRu6CenzMKYj3KZ9Cen/YHBC9bBI3F5dKDLFI37AXjGs5C0cxBwJiKJ2nzLxYETiRWE5fmSe6enFKyFK3jpvwVMWZ9Lmjm1iRuQqnRyJvFYQJ4AGmMEmPcEMiubVZ1oLAgoyGzSasgEWHiwHwSh/DjGaIkxBJ4UBJfcXSHj52oGuyxPQJhyItwN0czp0HG1kJtiISBmtIkV3uzWQhzZfFC892JNRy4WDY/KiMdejijg9P0FP6UcadxJd9/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8jLBBF36qEndGW4TH3/Bb0uVE5CLDt8MVQMv0rR3vg=;
 b=Vjb3FGJ0uHjl7J71kLL/2hgmiwAm/DgOIl+kdyKyHl6WgpQNorvt5gPVSClJarjiRCyoOrlogkGip8dpuh79NkrMVc4j33f6tUtCF86b4dVHSNSsV33GskwTJWOV7I27LITT/riAtIQarsFkvPvAhaczrAS5XEoSke3aIEiIJaYWN4Rju6126pQ82/TsB2anvzNZ67Tuw7RG1l1OEasrP0d6OJ25nL4nT3JcRTYZqlPJj2/vx2aN37XeQnZUOgZl63jZmZWnZf5sCORlic78gPaHiX4KOBIfJ37mWU8Ea8Pbh+JIqEJeHOWGVd/GYX9bQMpt5ecmHYvaBR2e/daung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8jLBBF36qEndGW4TH3/Bb0uVE5CLDt8MVQMv0rR3vg=;
 b=UaFKM++X0CHazmXrS6Yc9ivhw+6OzBm4rqvKRXfwlC6c2Ogy4BHmlgMHMtmNeS5pJhRwzKNCSMTvE+kw8+1gU2QOHv6EhBccFUoEzdqexTBMUdEXh+kDomnTu0ewvfShL4bp5xE5uWzwXiNZNzA6p9Pu/+TuV0YBjSg98og4+ZVXjpL3A2mUbpR415e4cwqw1X7pl/kw0f80X4rKBEG6qlBBTQJQBJAjg6XtbNTQV4W5TRt51vGw4OLyh1bJD4fja3e+Ez7tc2CnFmrEqsbpyYUoY1T34USZDlLPItxdBPPT8tRuZoWOupLnfDApQdwXWJGEG38ej4pJkp4Q2o72pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:41 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:10:02 +0800
Subject: [PATCH 6/6] usb: xhci: mvebu: Use dev_read_addr_index()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-6-a4e22b23bfae@nxp.com>
References: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
In-Reply-To: <20260526-devfdt-usb-v1-0-a4e22b23bfae@nxp.com>
To: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU4PR04MB10401:EE_
X-MS-Office365-Filtering-Correlation-Id: 284f0d6b-686d-4737-678b-08debafbe6fb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: o+MrwFQ7QiOrYsmupexblTENF5crdWhedkEyPulVAF77+iHHhcvg+BTPGF4L97yu/trOzXegV9yEyzZoTM+HdQGAfiCLFo2QjikpKHXc5EcLjfNAKmqSyMd62th2Wt50kCLmZmsUxGZxp9WVjY1I09b+Ckn9Y0NcY1zsPOBzMNxxqGJd5waXeTEihs7mtW1pSOC47XcM80rHEEzd1i2sKEUoRP48NIsb9my+p628xvmI/DXPm1rOObk4lbqsQmPPEPVWXVzVqGDlgk/A/me7bZZMwmO6S8EB6QfLOYkZZz6QH/R8pVSqU3O2gpirLwxQB5jL5xgg4v2MvSmga2ZYSoBureYlQJ561EiLbmebznfaNJYdnxZpeTHu29eAxf556KTer1gIXX6uGDJOac9D/miAhoXAB8jx8qTqX1loXQfwdz62Bqs6j231PZZSDV6o1SPZF63ITuL6U/KIps7v0Qy0WuUo9j7RAMCnKsp5N2v87ftt2jm8tqT3hEiWnp8CqR+UhFYXobxPgHpw04zOeLy5UNPgXyVPSYVHs9VYV0GbczlQPR3PkMrzcbgp0CZSXLl1tkSMclg/cyOkWr8jkRGqbzAGK25OFHuUzmCVNdNG/YxY72x+EwjfROk4lnA/gqKPoutf8HtP6TQ2HpBS8SRNkASx2sBbZ1o5Ia0juqIxTE6HMz3HVIPQ1LrzEmpNLEIJDQsAvnx6EvXKuHXwJyNpvGvgDnIKqF3/Wt0iqqURAm0DlAhAl/xgNJ7NniCj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytGWVEwWkJHZjQ1UXFUcHdmdXpqTEpRbXA0VzM0ZDRCM0VqSEwxQ3EyRlRu?=
 =?utf-8?B?Zyt6L2t0V3AxTzJRZzYrRktrSy9PV3BwcVNTRzJnSWZKZ29JbDlaaGd1cldH?=
 =?utf-8?B?ZGNUOTArYTF1eFpUeFdLc0JLbVdoVTBUdjBTekRTYlMybGdkZzMzckYwVWhh?=
 =?utf-8?B?eFJ1UUNuajU1TWRzTXM4NmRRWWI3dmduZDhJbUl4TW9sbWNhQUdTTnJ1d214?=
 =?utf-8?B?U1pIWFllcFJlWlBsQUIySmcyWERheVI0bVUyWUEwRjlTakNjWklhckJiQWt3?=
 =?utf-8?B?cHRETFhaM2JvSURTd1VvTzhpejc3dzJ0bW0yQWtpOVlzV3ZOdDdQZ0IxWVM2?=
 =?utf-8?B?M0RGVjBRVE9NUy9PNm90M25qVWg3TW1kM1JVTkhVZDZsK0RsajJySjVac3Iy?=
 =?utf-8?B?WlFxUmtZMEM4MEV0VXNyRlc1V2F0b1NUbDVrYkxIbzluU0Z2YWwrMFZYTGFp?=
 =?utf-8?B?UVJSRWhwRGlYVnNmZGRiRzlmd2IyMUFhTzZXVXVkemVrZXhnb1paSUZ2Wk9Z?=
 =?utf-8?B?Z0lsam8rSVpBekc1TCszVGptRWdRaXlkVUNwcFZ0S29HMVJZUlBiWUpuNnh0?=
 =?utf-8?B?NDYrYithd0hvcjNMOGlRZnlPeTNkeTMybFJ3RkN6cDhDVzJpOGdZSlhwMFRp?=
 =?utf-8?B?RDBpbkg3ZnNuZU92NEdYS3lKYkdvSFh3VTNWSEJvVnkwa2U5YjRiMy9xdmo2?=
 =?utf-8?B?UDU3L2NmemxNRk1WVjFSVDlldmloOEFtNHhweWdqRzhRYUZ0MFB1R2VTRmlv?=
 =?utf-8?B?Wk5yREVPY2Zsby9RUjNDNmNCSVdlSVNQYTVwZlZZSkhWdUxLb2k3ZU1BR2VY?=
 =?utf-8?B?ZkVKRUlvVTRZQTJwYmZnWDgvbE94S2dJenpycW5PRGRSYnlXR3JwMEFmQTJJ?=
 =?utf-8?B?MXJQd0ZFK3Z0ZXdrUER1QXhXUXdOL2RpS1NEZmJFVlhLTnJFa0x2Q0twZHVE?=
 =?utf-8?B?eHUvK2JjVjdSa3ZYTDN2YnJIVUw5aVdCVFR5aVdtd2svRkl4ZnMxNlEyMllP?=
 =?utf-8?B?ZlAyS3hzSVJ4NisvZFRqREJ2Yms4WTdMSUdkNlZwRm1PbVV3b2hac0E5VjBD?=
 =?utf-8?B?MUhpS1NEL1FacFpFM1ZrZnBlaXhxWFRjSEhZQ2lVV0xMNlFoQ2I2VUcyVlRZ?=
 =?utf-8?B?Qlh4ZnhwWE1tVkNtcXk3ZTdTRUJiT25BRWVuMFI5QkZMdzF6U0JhVDQ3TWZw?=
 =?utf-8?B?Y055TjRQMFVqV2dMUXlYaW1CZ3NhcjVXbnBrcTJLYmo2bDhiSzA4UEdhc0RX?=
 =?utf-8?B?ZmRzaDY5RU9TN0ZTU210ZytDZmh6MGNJeWlvRTZVSUNEdjZsamJDSTBIelJW?=
 =?utf-8?B?RGZlSHVkTE9uQ25zYUtKVGNLblRMeGJtcDRYWmdjcDQzbFY5Wnk3N3k2MUZ2?=
 =?utf-8?B?T2x0YjRuRmlCT0x1U0lCZGJIUStWeFZoYjA4dXNBVkxrS2NKZUlMYmdWTUVo?=
 =?utf-8?B?czI1aTc1aVR2VC85TUsraWVOV2djUXRZYzg2dkpzbHlZYkFGRHZ5R3JMVThX?=
 =?utf-8?B?ZjNzTE1ZTUFLRU1Ed21MeFVsYVNHeDhpc1B0VmtFR0cyNGx0TnRucldiNDRx?=
 =?utf-8?B?cXZ3emxCUzE3c21PQmFya0VKTW1SQnE0empOMnl3bEFHdkNpbzFwd0R3U0J6?=
 =?utf-8?B?cWhRdlZReGNZKzVzNDFBZ3M2SzhOc1ozM3NEKzRvM2NDOUt0NFgzY1lWSi9r?=
 =?utf-8?B?d1R3WGxla01XSHV1MFFsaEdHUzVXOTJpTmdQVFNYUGR0aktPb2czV2pXaHhN?=
 =?utf-8?B?NzhXNE5SVVZWcWRuM3VJRlBYZHZYeTlZbXQ2VitqT0doclJXZ2M3RjdEU0ti?=
 =?utf-8?B?czVtMGpmSVhnOTB1bDRXTy9kUVd5bDVWUVRpcXpIMFoxYUlJbTcya3BRbWdR?=
 =?utf-8?B?RXdYQ2U0STlLSS9hTTVnRTU1c29aTkM2dXJzWSs3RGlWMkxZeVAyQ3NrYm8y?=
 =?utf-8?B?bjNwQlFLd29vK0xaWUtuQk5qMHpqeXR5VG1IbTRXNHg5VDFZWUhsSTkvWXFN?=
 =?utf-8?B?TVlNNTEwZEpjdGpxcjR6YjFpbXN3UUN1TTA1VHBQL0g1YjZVNGQ3OWFVZlRn?=
 =?utf-8?B?YUV0clZQZlZ3K0xLWWF4QXBzNWRlQmQ2RUk0N1EzTGo1Ny9oYi9hdG5taWdZ?=
 =?utf-8?B?RzZiNDk5Nng0M09jUVRMNUJVQTRCdk1hbTMveWxCclhUN0lkQzBHdUVQSFJJ?=
 =?utf-8?B?cUR4aW1yVUR2eDJ4cHBFSXc3K1M0Mytwbk9Jam1GOU0xcW5zempNZ2Z5Q1dF?=
 =?utf-8?B?K0hHMG9Ec1JuMWV5NnZZd1pZenA1S3R5dGhsTVZrOG9lZDBCcVk2NWVBbGg2?=
 =?utf-8?B?ZG9paUVJSGtvT0g0ZjA4RCtkOUNrRlllMVJueGVEdXlUZXZhQ2hlQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284f0d6b-686d-4737-678b-08debafbe6fb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:40.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3z3oojnq2jukUVdjYze9UA5Ujh4DegyQqXmbhQzsH4nATkLA52bOP+5jP7cKpocl/ZSZb53eMdv/c9KxpxwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10401
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

Use dev_read_addr_index() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/host/xhci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.c
index 12dc61aee9d..bd17fe717cc 100644
--- a/drivers/usb/host/xhci-mvebu.c
+++ b/drivers/usb/host/xhci-mvebu.c
@@ -59,7 +59,7 @@ static int xhci_usb_probe(struct udevice *dev)
 	}
 
 	/* Enable USB xHCI (VBUS, reset etc) in board specific code */
-	board_xhci_enable(devfdt_get_addr_index(dev, 1));
+	board_xhci_enable(dev_read_addr_index(dev, 1));
 
 	return xhci_register(dev, ctx->hcd, hcor);
 }

-- 
2.51.0

