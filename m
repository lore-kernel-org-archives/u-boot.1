Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1860DCD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86BFE84704;
	Fri, 22 May 2026 09:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ToOvK3Sb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63ACC847AF; Fri, 22 May 2026 09:24:56 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 783CD8432A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRLc027MOTBnWeFeknA/s9b31thRr91r6BqqIOy5B3tWj7b3felImgX23w9QzzuYvZ+6PaJsLrkxClG8EDn0QJfAoZ9vM8uD1ldp8hQ8wFJpKQLwB+V4BC5AN6bAR8PBHNe3Slbo2DZG0LImgZ6sN2rfr8fjTfZpIdEiIhK6gbnFeyopktC4FuO6OpD+BPGKSOQYxAO/YP5VYt+liMnrMZS+OUgupTBkIATbDJCf8W239XcCW6OhFKJ2W/pWom4esKV9eLcNlOQulUyLU8ebi8M8fxTNbuSwcruD9OZorkPxClT6QCUnh7v4xmRUujhZMDDaWOHeZKccqm8GJLLMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V3BDyf+vlV7U8w3k3LO5SyDxUoBh+BrsL7atAKzr+g=;
 b=raQBN1EOuSeB0zVWq/7Hwn9C1wcK11f0MP4lNuQYfkibIx0ohLSqhcBoVSfZSDAIglC0BYeX2QqE8OrUri//2MbolGX/YOs5A+NbINh5Yj7f26Q8KaXyME6L+Gbp2FX88onqupwNiVPfzi/KHwk/CKdhYK077w18ujJxXSUtr+mVN00MZl8hSwE2LITtQen2+/rtxxRTz0OgzGfRL48NiHWQq2JIJm+g6OZvv6wVpUMW6yhAz1bqkL11kT0N++ZXgwOLmTVb/izCo2sml+1G56umUUtr78vADUQ5IlXbAVapGWW004DuHybvJDFXlmv2dwdiMYn6uWsAvjZCBRmISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V3BDyf+vlV7U8w3k3LO5SyDxUoBh+BrsL7atAKzr+g=;
 b=ToOvK3SbOJwwAfH9TIqw2WL+2T7BqKtWE69gqZG/KA5iUHuhTfm8mvVw4Mf1TCqH+tPwpCg8GQwTDc8Aauxyzx9UMOanv3I7mpQZRloryGQW7VXgSgSgWUP7WwnzrgMpOwUCi5jg15olwaVRW+OeysFlPJXMbsdcH9QDLrD4Mv6fAiACsiYOSrtUybn09H//tsKYwhSSch59s+YGTyUx29A5AYo8EDse1Iq8CmiwyLohjRw49kLIPjOKpkjiKVwHcGEkx8BAy8s639TEypxJZnQFDESVLrF0D3o0GCIMf7cVMrT3O203rimAqAQ7BW8fshgq8edI4L/P+Nl1U2Kxrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by AM8PR04MB7362.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 22 May
 2026 07:24:52 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:24:52 +0000
From: Ye Li <ye.li@nxp.com>
To: lukma@denx.de, mkorpershoek@kernel.org, festevam@gmail.com,
 u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] usb: f_sdp: handle the spl load function failure
Date: Fri, 22 May 2026 15:27:05 +0800
Message-Id: <20260522072705.1156220-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 958f6738-e32b-4def-6945-08deb7d33702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|42112799006|38350700014|56012099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 7k6erbWhucHZ+/G8OkOLP5L9SUEZQ4jbEMYTd7FGr8hIfEK0fRG+aEe6W+Y9YlJ7svpkwQI+AsHr1XHlUivIIYpkK126VFOQYnn+A+2s/Jzuv/AgqDQP679XIcGupegUKuCQ+H4yhDcvmRWe7B96lsrHmR2n3OEU78u1nVVSPT8jyhhXwO8ViEnEVP1tQ6zzWDTgWF5b1pnv/F7kjFJACHhT9kd3LErTX89LPfistBtutNwmUyxzP2qH7ghoD9CppAzirPkWtBDyhADhy/EWg/DReSlQU+p1GvonP+YQehZRW3i2/4I8KDXh1GVb5vIAlcEiG1X+l9zhJddUUSiJQWbxekP2QDdTyD0fTcEuJ2SGvqCwbKtOhDfeQPPkZ5k1jUe5CIZdiKjwsgmernCSL5Tk3Wkq9TNSgCEEtrpWGh1XcT0L3HCnANUFLNQoqBE7URrvBtdYXOpbOTI8efvg0i6weYZdf2PKv4wkaaCNtfciqam4gijsNqIzMqweXcH0swPvmfJPMPdM4KfnXCoF4Ym8hktAj90Q/OGNh6JDQWnuSzUiuycp/LGlRiwhvNiMfMRxPGDW5/zrozpPlVS5o1M0Kr4ny+pkudPZrhV6sPS81EmYq36G+wRzQjHXwJhJF1NEDRNyxP9wDzP7nw5KHiWMNS5WROq3R8U81xF77DsvgHK/RaENPT6UV3mb+SydpA4MpJXzFP1ELQvSgd7dIlw4uL1gFkkAIBrMSMPFH+XoFkUq/4lzeQXQht1rXErB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(42112799006)(38350700014)(56012099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HN8HgEYVMJL+aV9SGtJZfvQ5COSEtGI+TexJ479BI9PZ7K/bPvnXieDlCOmx?=
 =?us-ascii?Q?DU9WR5GnCnAoxQR043S+WPrRHZjvuYRw0gBPcScXyf74jpiKq8IsT7/3RBc0?=
 =?us-ascii?Q?SzkMLmNJqjTNJSN2j9KK1j1d2kzJOyHOZxiQih3PvWzsLYEoOnvc7WkP1mKD?=
 =?us-ascii?Q?xXHfmKeLyuczuGSvqhEPHeCSK710sNUzTT3S8+c66nkqAzMDiwEtVO6bGIff?=
 =?us-ascii?Q?hGr2vSeA6Cbjof8X6/VkkiQif5wnIc6jz2Mpnih6sR0mZ5HwOaMTlXQCmAh6?=
 =?us-ascii?Q?7reTHaw4KGpa49CHBhSJJBXwSsuo0YHQDyRs1j+Z2ULmSY+tbQj5wLaSSCu4?=
 =?us-ascii?Q?acSMhnU6i/ElMBy22hMt8oCtqNKiyIY3eNMACQtJ9/ih5Tr4pXOrBDn2X9Mr?=
 =?us-ascii?Q?Ggf7ug0HGUgdIP2sQpZvKTFGo0VdPBOazXVugQ/DURm9hTZJWJO8hwr3OqQS?=
 =?us-ascii?Q?xSXIIv29ui+g5BgKFnmMmbNMBZweWlaaHTmwY02Rq9X0T5aQ6h86/cbug5OU?=
 =?us-ascii?Q?qkjqzhDOmjB/3ju6kcUEmMaJ1tMDF04+zrOS6WMpXmw18CJVzO1tLT7KnOOx?=
 =?us-ascii?Q?NIfN4zenJKZk6U76N+oUGdRFbtN0k3DtJfCgulvqJpXjdWGXKJhMY6BEEbui?=
 =?us-ascii?Q?XkENbm5G7wPS234PQdsE2o0NcwNMJUTB4RoYLY0UJwD5//mqzh5/pVv+44La?=
 =?us-ascii?Q?zU6WaU3gfcRKxUzbkeVADmLd2GBa+96POnNmAVRx+cunIQ8R4k7larYYP8rd?=
 =?us-ascii?Q?fm3S6Dsk5G0qIY0DS/aLLmt3Eum5MRyyM/fZuHvKgDDxA15LWhRCQGOsXOM+?=
 =?us-ascii?Q?Ay+mrarukYXpiR14sqKVj9C4ZRvii4GFwoeiZV85u69P0knQWaikLVmHEfSv?=
 =?us-ascii?Q?wrUljqd2pLZ/p8/Z8KNgMDb/YxvJO35UPbrEW2iftWLjto7qx8dpx4SL5N+z?=
 =?us-ascii?Q?AxLnNzSqSvIH9hbqrqIxT4yOuUQ5AEOzXMhIyuZ7vkQrwPykE91n4utUPUH/?=
 =?us-ascii?Q?RsHy5QQY2UiBaOe8N23hWzAMX919+/rsGh1PBqJHDD4uwNGs3ZuX9ewJ9DbH?=
 =?us-ascii?Q?v7k9321f8qpmICvbafm6qfjLvpwUmqikabTFKMb3ZUqfw0AH/7nC47V5++r4?=
 =?us-ascii?Q?YA+PD+gD8YwP8tswosgwleVXz13RkfmbaVDRB51CPIqXZ/m/BEoPq75r5FfM?=
 =?us-ascii?Q?9f9jQyiFJZFaAcpFEA76XyIEncpBisohXv4BJVxEEP678jikp9SPW0kdSuDA?=
 =?us-ascii?Q?VyxsCJNFLqDhAi0ZmXToS2WwV8NUaeiBxxS3OHzHB+68hQIO8J+is40U1HAw?=
 =?us-ascii?Q?VB8BdbTg3foFgu5Tqo74KF87p2HjZOcSDzO8eDX7MiBAo+FsUJnBTA6FhY1B?=
 =?us-ascii?Q?3bpEEiPcegGXVQpa991RfF7kNOCriRNb8ZySkGrwL29yufn/i5SmYwvGJ9U4?=
 =?us-ascii?Q?eQKU88Cht1WEIDcEbqSTiYqkOq0uE6p+/r3uf0z1voDQICaDljTUe7Dl5k53?=
 =?us-ascii?Q?xTRf7HW1n9e95bg771+P6cBuAYmY33+AClQMQfObHAwT13oZbHpNro8V4e6X?=
 =?us-ascii?Q?MncymwkOqQY+Ii94xpkQZJ6o2LuCz4vC69RUFzyS1RIjZYSEdkY5umhhYOsk?=
 =?us-ascii?Q?K0lV0lEdNPpGy7UeeP+nG7IWNitJSJVtfx29iAX+KMHMUmK8BVl/8vYJ/ps+?=
 =?us-ascii?Q?pWYyyvQyWrf4QUDb7jvLO6UA/ycSexL1W+Wen2HBZIsP0MVh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958f6738-e32b-4def-6945-08deb7d33702
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:24:52.5190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehZJcixkgfc6/LDmmYTTvrs33naRIH1y8AKuA9NCVy+lYdpdaxnbAppH00LcyBmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362
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

Current implementation does not check the return value of spl load
function. If the spl load is failed, SPL may meet crash due to
spl_image variable is not initialized. Add the failure check,
so SPL can print and stop with error.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/f_sdp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index f72e27028b7..cd2c282247a 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -75,6 +75,7 @@ struct hid_report {
 #define SDP_HID_PACKET_SIZE_EP1 1024
 
 #define SDP_EXIT 1
+#define SDP_FAIL 2
 
 struct sdp_command {
 	u16 cmd;
@@ -840,11 +841,14 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 #ifdef CONFIG_SPL_LOAD_FIT
 			if (image_get_magic(header) == FDT_MAGIC) {
 				struct spl_load_info load;
+				int ret;
 
 				debug("Found FIT\n");
 				spl_load_init(&load, sdp_load_read, header, 1);
-				spl_load_simple_fit(spl_image, &load, 0,
-						    header);
+				ret = spl_load_simple_fit(spl_image, &load, 0,
+							  header);
+				if (ret)
+					return SDP_FAIL;
 
 				return SDP_EXIT;
 			}
@@ -852,9 +856,13 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 			if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 			    valid_container_hdr((void *)header)) {
 				struct spl_load_info load;
+				int ret;
 
 				spl_load_init(&load, sdp_load_read, header, 1);
-				spl_load_imx_container(spl_image, &load, 0);
+				ret = spl_load_imx_container(spl_image, &load, 0);
+				if (ret)
+					return SDP_FAIL;
+
 				return SDP_EXIT;
 			}
 
@@ -924,6 +932,8 @@ int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
 
 		if (flag == SDP_EXIT)
 			return 0;
+		else if (flag == SDP_FAIL)
+			return -EIO;
 
 		schedule();
 		dm_usb_gadget_handle_interrupts(udc);
-- 
2.37.1

