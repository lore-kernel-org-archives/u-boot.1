Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD328CD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1163084825;
	Fri, 22 May 2026 09:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BOxt8xgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABDB84815; Fri, 22 May 2026 09:53:07 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3934B847B0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeZHI8GP3X0YfNOuTQYCRhxjleRf20tXaVWifQaH1gVe1DPATlcpfpR04nzaPfpz6aTbmTWgYp4PvcPFpR3jq9noEr7zOP31pzFzTrmlIkYo7bUT+GLWF8/RlrzhQLDj5bN2OZ9a0PYFmCLP9q83QtvYtAqNDfaVn8Jddx4VAQKkVhURQfkh9h+6FP8enSAlqfiaYSqCBPIhWt25C4Ou+2wlXiqA2tfMQ7+b7kK30zXMBy9CyW/bG/la81iZmNQ0YilGCQBKIFb0V6CLaTrY7t9mzgW1GoL1Sagy0jLGu7BclvSqb3hipEY9fuhAoRdasXxfE5b7/t6q9d8OTFB+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkB3SQIIEqFtuRfycDq+OZQDArXEKDUaO8ej3hlegVo=;
 b=VfCrK3fwnIHaCRBcGhBJ8tuZiaZQ5tTjWiCSJ/6pTfxiJWynur0d6pBf1qjYe/kOV7nrYNP0BvM0PiKn9NG/cIwsgM2IT7yAIEsFiYTIbBo8QXfBizExF4QMNU1/oIob9mv8PquMAwFL7aqo5fwv7XmJQCW7UjIlrJy2b5yJwLM4qQgecxh+OuDGudX8WvJMY/4K8E2PaqejMnAaUGVz/BTjYsEb/zz3nPRTpg4ZRJu0yMCeyq/dHgSI07aMO+3tbzN4fc76Hv46+eKoiV8ujcusDn5mw+d8AotxAfZC0B09n3+Z/xE2FaShZKK9vWQZ/fiSlE8yviMJJSrE/kKQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkB3SQIIEqFtuRfycDq+OZQDArXEKDUaO8ej3hlegVo=;
 b=BOxt8xgw6rjrj38su0B6cbVLWZkLpJ4ldidl4ckiLzU2gWgsCAe2kKBMdfTQuOf1VGrdPuoqmcD/xRBni54WxlJnmEPzDi+jxAUPNehiymBf9Qm1aZ1iRIPG7woPet7YjYGL2wpPwsEzxSyK8/L+ol7uNgHDXBkzTAma9wW4clOdOQwztadqbirc/yAjsFQj6Pc66mpqoD+gkWuq4Ksb8KzbFcuBTIeYbil/km4Mlnf9ImJX/meiIeSJZlYBc3t5AWqIWL22EMjBqN8o+TDlNnKQijjYnKANmkz3ckC7wKyNLLV/ETMC149boFuwg4HBnDAzs70lGGcyKT/FDfsPrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PAXPR04MB8174.eurprd04.prod.outlook.com
 (2603:10a6:102:1c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:53:02 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:53:02 +0000
From: Ye Li <ye.li@nxp.com>
To: lukma@denx.de,
	mkorpershoek@kernel.org,
	u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com, ye.li@oss.nxp.com,
 xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: [PATCH 1/3] usb: ci_udc: set correct ep type in ep_enable()
Date: Fri, 22 May 2026 15:55:10 +0800
Message-Id: <20260522075512.1291485-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 238f173a-560c-47f6-5534-08deb7d7262c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|42112799006|376014|52116014|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: jTc1NMEA80AoyijmAomvkAHFyCc1TB3qYp+z+xw68p8gz6QRe/9ltKZORxrldh6A7IAxjXiCMPBX/Sh5NqX+0djWfUQZTUgzAP2T6QT9PcFxSl3EtErxs/6Za4b9EeylBG6b4ecKTQ861Z+11CuSVTqp1sYWEPASZ3Nz1orYq1VRW2L9pzWzBOTnZoi5S9aFej6hSSNWbzDvDHG5kFRSryfZIhmKvgepWw0JD3Ib5FBObS7Qra3K2KED5Z/RbAD65WCnW75spwHcIjyVZRuWUAbfDmAzmZbAHBaE/7G1dnSDVgsXBZMfwz6ktomlo31mR2jy39nRxP/Qa2bWHVXOCPzQZjjv1OpaK0PvmH3fINXS6CIUevI2Oo4zmW8KODH0xjDuD6qqgzS+nmR/iSCuUL+Dm3IoOvQw9uX+axzLlf34gndc+mc13Bkr6l0Kzs5NugA+urcbIDrO79eL2dFmIE4HiVBDCpW051tU97UWQpr3jXEr8am2QpSMbZ6sVyioIHHJXIyA2+oU/kOANxtrpQ3jz0PUnMmpQofmeIWqB9hww20bmIKRbj5nYGUX5B8QafgjfJlMd39yckBQoIH3JtCvT2/EroQoaTqiOwGChuwPtezofLL1k7e7rkHDuxSSzVxEYrLmDBeDObd3rSfTk7k6uZ3kJrvHTpVyMix1P/HQ3PvtJZshx4CYf9gQYC3NvWMtQ0cMLZEBAdHc90U1pTH38TKMRbSwMx4r3OtZOAtMoHIc5ICdYC8qjvFhNsQo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(42112799006)(376014)(52116014)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zaXcfa2UYR7C+EkawTsUQjceMQ+bk74lD3OCmBK08tXGZ9PfPqe/4gVepErr?=
 =?us-ascii?Q?XhWqoLqkBz0OvATgHld+gmtWxnU+WX3CV5oNa7ftjrf+TqhVxLu+MrFPaX13?=
 =?us-ascii?Q?eEhyt5sMB1XqQzn4RV26wmuzytbuGsr6gW3VveCbzCX0yD/gePWvkeu3kCK8?=
 =?us-ascii?Q?GagSboVApdOFnnaiUKO5pS6lneIcHS5xd2BtkXTDeAcKnslFk6IIoScFUkDp?=
 =?us-ascii?Q?mLaQtpBXYYcuS5tonn4Obbyq3KJbyihcTHkqHYsLIRaHNqXvgi7+UN9J6nse?=
 =?us-ascii?Q?1jO7KeEvMmtHD4b6DDd49xKTPVZVw178X7/GXXWneRONM//m+0Rt6WXhNh/k?=
 =?us-ascii?Q?gIyKw5W3iw1bGHQHCHHiBeWnerCY95D5oz6ZlcNDDwaLyDTG3JqJUAfO+5DR?=
 =?us-ascii?Q?SQCm4G9RFUTFPZJFeiFWlOydD7/XFnkkPEGepuFsHEOrgNDxwg42hs6OWOAr?=
 =?us-ascii?Q?kmgAH7F64Nn9eBXFQ5W+S0TwzfRQNTN8Q0/enhKMNB8a7R88lxoQ2aYB9VPK?=
 =?us-ascii?Q?oY+m6qLkG2EmneZASk65KVCtwmFFr0e0hZavqDSYCzXTrC6CGJ7a9rHSy5VH?=
 =?us-ascii?Q?dVjr1eJCNJf76Et7uZ4+D6eKEJu7/jc8mTZ4IE72muukbLyMVEGma+gxHrxA?=
 =?us-ascii?Q?5bREn6P/Wu3482zPUQ4X1L0AMLND2MMs/YS1N/eMlCTtubCo3wS6zpBLEy9W?=
 =?us-ascii?Q?kFJY0ZjXsHldm3HSq0YMl4OOPrKpsTEvV2ZI6X/jGZG+XUCZDgSDBNbv8d5O?=
 =?us-ascii?Q?FjT/fU3SgWXRJBt28GzJ7D8B8dAECY13DSK2XhNM6niv/i8at2jXtwppj1Di?=
 =?us-ascii?Q?LZIrgmYsZboNkWV55s8AsjBXLNx3OlEEyOgpdL6lm++naVh8Stn0TB/1ONSM?=
 =?us-ascii?Q?OLR/oYQRHSsbD1+LDhJoxnx1L8kd7xOJk/9mWYt+ewapJfYSfRgObqO3p2Gm?=
 =?us-ascii?Q?cWsDXdkICkdLNX/6FKqONP75Ugc2NlfqkZFRWRXTul9TwxHn4KfTpu35VpjB?=
 =?us-ascii?Q?EHDu2vc36ARPpZrBAlvelhZcitjtDQOrKXKl0OYsfzEqype+5flNKXBoXNlm?=
 =?us-ascii?Q?Jd1BhHCXmFIZIQXKDp5laASVstINIyEVGgyARpFPlT1wbHkUTAnXcwZjjf+n?=
 =?us-ascii?Q?XBZHznf5tcyE+pYRO3G4bJdpC5igqXEIu2o//lfq+L4S3ddMmREgJRGDNnU2?=
 =?us-ascii?Q?DqPWNifJb1+52teUFdAwcMlPoDomL85Gnq7799bSajMZPyicuNSww9HBFXdk?=
 =?us-ascii?Q?zidmbaS+2EYnsFtD7Dr1xdIrapy8amoO8arRhw+qH0eptAhkhaIYhaigzOk8?=
 =?us-ascii?Q?PPKriO8+DvSRBAslFzsnknClEifoUwBTEJpohWy0W5Es9o9E2DeHHACpGZYh?=
 =?us-ascii?Q?nWvo/KSeBtRlvqy1aBw68Q4EQ5YI+T+14MA4IOiNClkEyUsqB5etEK2aubcS?=
 =?us-ascii?Q?EY6PVArRt3KdETxBkGaEHtFWSWPAkcO8+xNriv/rkiHqcpx63F6KLkHx0n/x?=
 =?us-ascii?Q?fR7aQpzQveJQ7rfDQtI8PRc5Qr8qNJqp4GtpbqejArBsiAEn1DGE5Ken92vS?=
 =?us-ascii?Q?PJiiCvowEABQtaNXwJegP3mNV7g7JNcWAUXTHU8YEPBry8v/GaeH2MKEXCtE?=
 =?us-ascii?Q?S66FV5Rh/H89b+jWW2VCVOcvhKTbtcexN9AvJlhkOupKXjaejol+KEO0QYTQ?=
 =?us-ascii?Q?rZLyVnyMSk5lJEs8lrBqvPb2Qbcqklurg4/iPCqlL6Gcuvuv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238f173a-560c-47f6-5534-08deb7d7262c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:53:02.1323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFnk2z4KvQ+2hCDiNTgYw+NNEbQAiVNc1ZRJpNH997YSZtR+KG+/mJRO6N+ktMBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

From: Xu Yang <xu.yang_2@nxp.com>

The Endpoint Type in ENDPTCTRL register should be correctly set
according to endpoint descriptor, not fixed to bulk. Otherwise,
unexpected behaviors may happen.

Fixes: 26cc5129ee64 ("USB: gadaget: add Marvell controller support")
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/ci_udc.c | 16 +++++++++-------
 drivers/usb/gadget/ci_udc.h |  4 ++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4729570c525..a62e5ea5658 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -333,16 +333,16 @@ static void request_complete_list(struct usb_ep *ep, struct list_head *list, int
 	}
 }
 
-static void ep_enable(int num, int in, int maxpacket)
+static void ep_enable(int num, int in, int type, int maxpacket)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
 	unsigned n;
 
 	n = readl(&udc->epctrl[num]);
 	if (in)
-		n |= (CTRL_TXE | CTRL_TXR | CTRL_TXT_BULK);
+		n |= (CTRL_TXE | CTRL_TXR | CTRL_TXT(type));
 	else
-		n |= (CTRL_RXE | CTRL_RXR | CTRL_RXT_BULK);
+		n |= (CTRL_RXE | CTRL_RXR | CTRL_RXT(type));
 
 	if (num != 0) {
 		struct ept_queue_head *head = ci_get_qh(num, in);
@@ -357,7 +357,7 @@ static int ci_ep_enable(struct usb_ep *ep,
 		const struct usb_endpoint_descriptor *desc)
 {
 	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num, in;
+	int num, in, type;
 	num = desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
 	in = (desc->bEndpointAddress & USB_DIR_IN) != 0;
 
@@ -366,6 +366,7 @@ static int ci_ep_enable(struct usb_ep *ep,
 		return -EBUSY;
 	}
 
+	type = usb_endpoint_type(desc);
 	ci_ep->desc = desc;
 	ep->desc = desc;
 
@@ -380,7 +381,7 @@ static int ci_ep_enable(struct usb_ep *ep,
 			ep->maxpacket = max;
 		}
 	}
-	ep_enable(num, in, ep->maxpacket);
+	ep_enable(num, in, type, ep->maxpacket);
 	DBG("%s: num=%d maxpacket=%d\n", __func__, num, ep->maxpacket);
 	return 0;
 }
@@ -783,7 +784,7 @@ static void handle_setup(void)
 	struct ept_queue_head *head;
 	struct usb_ctrlrequest r;
 	int status = 0;
-	int num, in, _num, _in, i;
+	int num, in, _num, _in, i, type;
 	char *buf;
 
 	ci_req = controller.ep0_req;
@@ -837,8 +838,9 @@ static void handle_setup(void)
 						& USB_ENDPOINT_NUMBER_MASK;
 				in = (ep->desc->bEndpointAddress
 						& USB_DIR_IN) != 0;
+				type = usb_endpoint_type(ep->desc);
 				if ((num == _num) && (in == _in)) {
-					ep_enable(num, in, ep->ep.maxpacket);
+					ep_enable(num, in, type, ep->ep.maxpacket);
 					usb_ep_queue(controller.gadget.ep0,
 							req, 0);
 					break;
diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
index 807f2084c1e..f1c4537859e 100644
--- a/drivers/usb/gadget/ci_udc.h
+++ b/drivers/usb/gadget/ci_udc.h
@@ -74,8 +74,8 @@ struct ci_udc {
 #define CTRL_TXR	(1 << 22)
 #define CTRL_RXE	(1 << 7)
 #define CTRL_RXR	(1 << 6)
-#define CTRL_TXT_BULK	(2 << 18)
-#define CTRL_RXT_BULK	(2 << 2)
+#define CTRL_TXT(t)	((t) << 18)
+#define CTRL_RXT(t)	((t) << 2)
 
 struct ci_req {
 	struct usb_request	req;
-- 
2.37.1

