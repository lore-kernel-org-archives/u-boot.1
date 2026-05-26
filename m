Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1997CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC393846D1;
	Tue, 26 May 2026 09:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tuoqvz8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3B1803C6; Tue, 26 May 2026 09:53:35 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A14846CA
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+vwhXbyDUX+1JlwjYwgfpwLwgKbz/frEEy/EUweICp+h4qdG8EY9/Oot3mui9Y9YwikNdVe4a4P9OnCirFOrb3mg4Kr/ERuiWE+hGlO04adZjiUoU+PXWhvoWyakJsgsLEe4orZV3vZjSEOj5okGJMoyB549HKauWPFwumnjxA5xTWcQoagxMudKNax6TKhbGg/vmMfyBnytXcOIHtMDzShI4NUV2ogqIX+Q8faGqNvYTSOY74vGhDQ3ZbE7wg4XpXpJ0lQ4pStGWQDxttbkE5OJdOUjHt5/49x6k3P1kRHibL9ENVFOd7329h7/aIt4iGGIZsEQnWAnXimOvFMCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsXPK6bk1VR/zUdFSVBqYyNeCHcaifr5hGV/bAOuvUs=;
 b=GopqRAMoyCds2Dwtz+3kNJRr0kHp8tApKEry1lsJkJ5mSTfBIyIdWxASBQQst02Maryc+5td8a4gtsOE4Lu9fHsT4eSKOktMgMaEKoX1prrJD8FUSlnzWAFYwMMYPU0PS19Xa0+zRG8wTfG7WLrq36QXuPD28LYRtY/vn+ZUJQoa5hXfjoRGbMxU1Xxa2ApGhDrDkh+q2ZYcii+QhDp+ApBkqeUGvN111zI3HZUtq2Zxpbq8EcsRp60kW1Fm5zCJVLORfu0VsdiMbrmbyjY2jQKv7MXvzdziANaWa85kCDMMI3gEtlMUpDTytzHgjgrrMymVGeC56ARXt8OcVDNj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsXPK6bk1VR/zUdFSVBqYyNeCHcaifr5hGV/bAOuvUs=;
 b=Tuoqvz8Uuv7Co+goRy+8/PD8u7e6rRYR4CWKNxJifwawtI7ZiPcviHVqZ6aD1NPSdEVaVYZi2gSfQzFYr7ZBT2bwNm4aH5T7RvaSNoq79gFcImvV7VvvJ65UYt16tvWNgAJF3IlxNQk9+C3XO5VT7qTmTf//W+BKTJcrJDvfFd+JMsqCTkHWFIVO7vyoxhMchXOaOJKydd7JkvawGkUqL4t+mu2j3eZiE18luMPIIuPBwlHO/VZRLqyo+NmKdDv42RiHf1aog5TZP60dpsqM+qlSkbmX5YSBqjhUZkcHfr9qxpuTCpUWr2XyF39SNGxWiCCd4Y25+hq4V/MD3dtUrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:31 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:10:00 +0800
Subject: [PATCH 4/6] usb: host: xhci: Use dev_remap_addr_name()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-4-a4e22b23bfae@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3296aa21-0052-4d27-1df3-08debafbe17d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: yjgsNjVZpc0aO7h78MYxeC/TYUGfCDAf+RyCF9U5Wk2og2jRsm9hQmJd6CDu8L4o95mK9WdSPSQS71d/7EXZlul+OMrlBD4/O/P+E5JawRpo/4WXg839CkdTWwkdCAwiMTeTjLJ5f0CqXPtyuypsnvg2vjr+g+gFr6XeOmqg9dTO1DknIqwlQDtfAsgms6cUO4J8j0PCHYwai4y7t21U+E5TT/Ob5tVju1FpUtTCVckE1OkIJ9nmNjzAO353ryDJBBH9KCGM83m2xV3NWRzdb/7tsVQCCh2V6JcUaP9M7sWroCBYsbbVBPpT6qDKne2gqZgU7xJvVKmOoye3+02YiQ4F63k4LJRQQ65aGRUNTurtY5QxI8cpnLrZ2J19HiyxnIST/FZLyyOHOTtM0hQ6q+W2MjySPJAXbrgwBai2H553hasM1HwfEQ2nOPUtFMsmeAIlu7dkxziwo/mWEOIQ0ChELDHv6EaW6GYaPjhig/HzWL7DhPqZxJhMFZ2yUKrc/WjbpxfGaGAlHqyjzQgx6sDY90AAG1jPR9tngW/yR+RPg9A/40t4Kl+coZGD0wOowOFBzepCthO9kytvK/Qk/lzmcY0fmwCCyXSy/vAaE8xYMHdxezSH9wFWMlrB9fg6I362BTF+Y4JiDZXHakhBEx/k9aaFft4oV+IYFiD0pH6QRMMuA0p7OmvSdrKRfxtvRFnMzDRwh/Zkf8/72re4PNoKXooQV7Nm3uTFkDNklpifvkasJnh/RteCnsRhwoKH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhXVWo1NmsydGhZY3FjOVJCNkRpWkovQUpwWHlJS1Y2dHBnL0pydnMrUm0x?=
 =?utf-8?B?UjcvZlFzbW9UYUV2MTdrQ2Y3UXN6aThCOCtrUGhpemFhdW15ZlVMNEdFZy9N?=
 =?utf-8?B?WVpCQklQMm5FMkk1VGQyZGFzZG9iYmRoaWdYRFlsdHVITU5rMk5MQllJMTI5?=
 =?utf-8?B?VFhGb2tKUnlKenhiNFR3SFFUb043OUQ5NzVwbTJtRkRqYUhNaTJyeGNWSWEr?=
 =?utf-8?B?eC92UXJTa3lnSkdyWk9kdTAzTDVPVUwrcUl2RjhLL0RsTWgrRFJvdlRiQWE0?=
 =?utf-8?B?ZHFxbDBpUU9pSjc3ODV2cG1yMlZkM1ZLdUxSMXJNai8vQzdrdlhuUXB5d3BP?=
 =?utf-8?B?R3FKdlBmazRkWWtPb21sYWdvMGNtK0Ivc2xCT0RjNDRVWmtHUXEySnZXTVE0?=
 =?utf-8?B?a3FGdmpnTm9mcm1CS2JLT0szZ3dhQWNuUWdaZ2dBcU8remxudFg2YVVnSWZq?=
 =?utf-8?B?MTN1d2xraHB4eVc3Y1h4dDZhMXQrRy9hS1BUQ01zSi9sNnpPWVJFdzhPbmNH?=
 =?utf-8?B?cWVRQ0ZBS2p4SkdaMW41dGJzWjB4QU90ZzA1YlFYYjI5TVg5UEhzd2tHa0xZ?=
 =?utf-8?B?cGFTa0Z5QWVuSTFiYjB0UnNxNXNXSVgzWU9jVHBVQW5oZ3RibnV4cDVpQ08z?=
 =?utf-8?B?VDdSaWp2MVpkMTZtUDE1N3UzYzNxN01JVkQrVU9yRDg5Y3gyQWVnT1ZlTkxS?=
 =?utf-8?B?bWRFS1d1NGRhSkIxSWozaXJNWlV3am82Ny9mZUdhby8zdGt0WU1BVG96dEhF?=
 =?utf-8?B?VEgzQ1plbE50Tk5RQ2RQMjRwTHh6N29zRk4zQjVaZ2Z1WVJSeXZIdEZxZTh1?=
 =?utf-8?B?bWVxdTdtZ2VKbHlndTNaYTdxTkhKTk00VkpyNGRBbUlwemJpSDZVczJDMFJx?=
 =?utf-8?B?RzNEdmFDUEJGNldOMlpYZjFLMjB6MzdWT1FjUnBJZnlaQmVRM05KZ0xpTDRr?=
 =?utf-8?B?dWk0TEw5Smx0bllXV2dEMDFSYkJGQnprRWFIcGYwR1VhaFFSTGdteFR6TzEx?=
 =?utf-8?B?OWU2VmptSjB2TlZGb2pzdTFSK3dBaVdIN3RUK1plb1NOMDVUK3BFbDhlcU85?=
 =?utf-8?B?bmlzVnhDZmE0aUl3aExZMUtZOHVldUZBOFQzQWhsVDN0N0RLd1gyVGVEZzl1?=
 =?utf-8?B?VVdNL3lnK2RmUzQ2ZGlPNTJ3MGVHM2VVWWVFcjRXQVB4cEVhRU9PQ0VLK3BZ?=
 =?utf-8?B?UXFBL21QWXFSMGFWQmNmZit2MmZXSFhxSXQ0UGlJQ2Qrb21sczhnTGNjbFdH?=
 =?utf-8?B?VDR0ellkdmh4SXdRMnM2UDZvdDdodHdkUVFRcmxpcUJDbFMzVkNybHJMS252?=
 =?utf-8?B?bmlFYjU3aU9HdXNIOElxTWp1dE8rdVZoaDlvM2tjM3BScUZwMFVPT1dSQVRX?=
 =?utf-8?B?MDlncHVFcE1ab1NKNmhHcTczZk9HTWpwKzBzL25MLzExMlFPYS92UVBRdUNi?=
 =?utf-8?B?SjkwaHhNTm5ZU1BvZDdHUTU0TG9YTk9Iam10MUxiUU1RaHlsUHFqWno5MS8r?=
 =?utf-8?B?RDNYaTFhUDA4ckI5T0pvZENkSy9MdCs0ZHBqUS9sT3JqMXJURjVUcjJZQy94?=
 =?utf-8?B?RHF4VVg2M3dlS2FYSkpwZTRxUDMyNFo1cDJYL1RvWE5NN0h2UVVqSzRJTmlC?=
 =?utf-8?B?M1JDQnpiMzNkeTRoT0R6ckN4NVN6TlhpY2JlbTNRdE8xVGhBR0J0Ym1tMW5P?=
 =?utf-8?B?Tlhma0hFbzAzVmJGdkltSGVpaHR4ZGlZTWJZVkJBUVBXTVoyN0IzelFSWGRF?=
 =?utf-8?B?b0hZWTIwUmRSTjVNcmNWOUlsRkVxa1ZieXlXaWF6aG5YdnpiUGgvSGVSOTBB?=
 =?utf-8?B?bzBqc05kZ3hjVk9jN3VlZVdjcTgxYXVMckJ1d3FTK3ZuYzhQVDd5dUFkOXRN?=
 =?utf-8?B?ZzU2d2hLM2xxQkZ0RlBIRURYUXRYOTk4RWg0eVRlSFlyQjZCbGE5UGVhTER1?=
 =?utf-8?B?V1NWNTNQdmk3VE8xYmFwV1ZlZ1MyNng4TkJMUGZlZEt4TWJGSU9obC9xWUV4?=
 =?utf-8?B?K3JMQWFPa1BLZGFNYVJLMENKMTQ2cUFsbk1ycTBwUVQ4OEg2dzlod0tFcktF?=
 =?utf-8?B?elB4K0YzZXZaWGlxYUFXS0ZEcm4weS9hTHBySEoyWUtKSmt4QVRFN01IdTFG?=
 =?utf-8?B?RlgwTVBEMjRjdTBYd1JXazVBT3hFc09aZ29LbzgrMFVVZ0xHbXNWQUIwR2wr?=
 =?utf-8?B?YnNvUjhGQS9nZmN1WmRUVVRSaGJOOFpaNWhVaEVhOEF1NTJ6bUJzTFFsZlFT?=
 =?utf-8?B?REdxLzRNb2sxMS9VQTd1dHI1bnAySHBDUnN3anA3WjlubVZ2dEpGdmJTS3hE?=
 =?utf-8?B?UEFhekE0Y0lsM0tjaXZxbmY0a3FFRlR4ODI0ZnpmcGpSUWFpV1Azdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3296aa21-0052-4d27-1df3-08debafbe17d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:31.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqvRQ777XSxCknPrvZzbjwFWdrJfvOQGI7ujz1FW7gKu7XKQq6Leun5cjtR7IMp3TxP1nu1V0AoeIBKAa40Eow==
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

Use dev_remap_addr_name() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/host/xhci-mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index ffe80c0bbdc..27caa3ebf86 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -202,13 +202,13 @@ static int xhci_mtk_ofdata_get(struct mtk_xhci *mtk)
 	struct udevice *dev = mtk->dev;
 	int ret = 0;
 
-	mtk->hcd = devfdt_remap_addr_name(dev, "mac");
+	mtk->hcd = dev_remap_addr_name(dev, "mac");
 	if (!mtk->hcd) {
 		dev_err(dev, "failed to get xHCI base address\n");
 		return -ENXIO;
 	}
 
-	mtk->ippc = devfdt_remap_addr_name(dev, "ippc");
+	mtk->ippc = dev_remap_addr_name(dev, "ippc");
 	if (!mtk->ippc) {
 		dev_err(dev, "failed to get IPPC base address\n");
 		return -ENXIO;

-- 
2.51.0

