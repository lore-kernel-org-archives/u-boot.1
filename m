Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661E4CD5BD1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE008464D;
	Tue, 26 May 2026 09:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ReBYyRO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087AE8469F; Tue, 26 May 2026 09:53:30 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE4483FF5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qg5dept+m5fETED1gE9DY3j/xAmXFn0cuc/DUXTXa9OJ6SKEPdubUM/IYoCH8jo0iko4dqzLpTFY53KEBBnwA2VxycqvgzvKnCR9mK9xhPwYKuSXsg8fPyao/4TS9RDuURfxnISoR1bt5Cx9JFmS0OwnKVVjJ1LiHDw90mgNU2xubZCQnszASxUNwg3iufPzILPmBYKi8cw+6uQwq64l640wUUmFdqgRsx+6R0rKS6za6gGRU/+cEgoE6Fq6bQqtqhnoEihgdGoCLXRRhpGqaJ4J+AHbLNBIBL/dv+YIVkRbpAg7qXuSlcDrMMDM0GPvWfHy27e/n11w58IX9qhnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lq1fh7o3icTUjw0nAiRYtBD4ccgP0kwHH+AQ6v07zCI=;
 b=ljJOvnobwlZD+iW2f9iUJSO091jX8MN6cpeT7oPqGY4sNXIfvB2ozudZqPK246C6aH9ybikJ+x2XsBsu4w750kNAmETUmmuLymzGiRRb/y6KrMmKEQ3xZg5GqngvkzR00GeptBK089AcjT0Gtoxs4Mml1NO9ZzkbGNDdZpsPTaHwMdcF//NreXiQi5CdW55wCw9dEJlXScTT/u0J7VCmzlj4gnw1Y8S0h9V9ECSap/lQ/kFfwVXOiCkCRnrJDmxqhBfMMKhcGdaghmyqXsVX0qwvKg3csDxbWQb40A3SUyHW+poSphlF7UH6Qyr+9MS+XmYL1LEcpBIlIvvE0K1xmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lq1fh7o3icTUjw0nAiRYtBD4ccgP0kwHH+AQ6v07zCI=;
 b=ReBYyRO5wyMOIhBgrA1d6UZ40VOv4VpeeG3gbwiz7T1yWXqqS2OakOdjsoj9I1Bo3OHDhxQedrGgpDC6lRrPmSs0vrqM9IQor8Y5FvD9bG1M1K9LCsbxNCvZ1FdGCLah7aVX9PVrNvbhl8F3+hfsja1MHYMiFe4ABbz+I+yJ6by7SQFupaNuUjlxVkyHLHZEJdXdfvLHgxqnQV879iC79Gt3Co/w+fNGIRkdEsNWLsgWrsUVGS4udXyv+KhuUAd2jMdrqpbFUq+vDkm5oH+09HJywftgdcQFUgTCME2ibHeaUtFPIbKqd3mfvBbspLu1Xq7wL3oxMelVQeLF0ZOMnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU4PR04MB10401.eurprd04.prod.outlook.com (2603:10a6:10:55e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:53:17 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 07:53:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 17:09:57 +0800
Subject: [PATCH 1/6] usb: musb-new: Drop unused variables
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-usb-v1-1-a4e22b23bfae@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 86f4fdff-6dda-42ef-f402-08debafbd922
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: RpRV+VINHh+y2IPHBltHejgRunA7qWSxHin8H6MAXDrAxymtxvYn8hSbMKyf/C2oIgw3eYqB2sA1AopOMdMUyonMnLtfvSU/P45sLx7G8Sc3pJcM/X1vlhdKooLABlOhuILyjdHyd+sC7eOnRzcCpbrz05oW5bXKjhDHFF2HlTbJiwUA0x31IamT/uT6ONbFyu6K/U2/QU1EJS00BsZpRdvM9CVihzdGA+BY2VKRFxUveIR+5E1IBX59yHZySgyixZ2NZu5BGyqMC1NcLGNoDA8N8wWOlZE76P2dlLoqLG0r5yl5T+H/5uTzbAxqAs6zIhYH8+VgB5i1ITGoE3D4QlVUzTJoiVbKs1ayT+rbUr+RFsf8HLH0FZ7hp/KUwMvUiRZTTbBjZfFP2l3IcUVeyNy1xN4O4hxjns3/Nb1ddTNECLn68HB+Vkh1tQThPe61Yu7NGTGMvAGoWlRN2n2WC2GAZEcRkYl0VQSR1CKJOqNkGePrH9mCOiQtpgpbd6hDsCelGQcTYCKmZIH4p8lfAnPkneIlg0eZSPxtXQ6shxiOLpCmW6Uz5aApY5/vw/UfN2aMyUkDS6qJ4CLB63KSGdjAXTTcensgh2Cg8V+b4ruyEwoybkKI7/us8x7eK9W8LrNaA9CwfYq0FPNTClYhYXnTnKOg/zZ0sA43vnJamvX4bV3XoqvfMdhT0Bt3/UgQ2ntimq84qqZ6xICw7MS9brQzB4j9oXQqsv7NsnNt5rZHMjnV8J26GJGi8Xvu1XxP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3JuMUVYQzRtZnY1Y0pTaU5zeEdxWUo1QTNtNTEwQXFnR283VFVadG5rUkdE?=
 =?utf-8?B?Q1JNc3BabTlzOWIvUEIvaTRiaHVlSlIxMEZXZGRjMzRQMFZWdEJDYUpiM283?=
 =?utf-8?B?dU9LZnlaQWF2SFpVT3RuRjJwbURxSnMxZ3hDVWRwS3JmaFFKQk0xOEg1WnhN?=
 =?utf-8?B?NmF0a1NMS01OZUJRMnFZZW1kWFNveVdaOXJYODczTzFZejkxTDZ4cGtYcUJ5?=
 =?utf-8?B?eXRQandaL0dNY0FjSENIZ3BGMzZhaFVpRW8yZkhMSXZBQTBMY1NZRTdxengv?=
 =?utf-8?B?Qk1QK0kyS3lTOUhZUTJ4V20vR0R2UW1DVGN6MGFXV2FsbzZIR1dqQ0tUUXFI?=
 =?utf-8?B?SnhodUJMU05ITG9GdUZXQWl4T2dsQk5TWUQzZGw4MmJibnBSaWFBWVk2Z0M5?=
 =?utf-8?B?dEZ0VHVkM2p0a1R0SzExUUJmeVFkNVhJeGtvUEdEZEkwbjlKNUttRGxiVkN6?=
 =?utf-8?B?OVlFU3B4dXlDTlBubENkeXpiajZWaFBxaEQvVlNCK2xpT3kxcjdSUUxOZW5W?=
 =?utf-8?B?VlBRa1ZtSHQ2eUt1cWZUY3FNdDhpOU45L005Qzd2ME1rNGZZRUlta29iZ3I3?=
 =?utf-8?B?RUFiemUxdUJHM3NENmFmZk1TdGFwR3ZpRXd6dzlKN3llUGllRmx6L1JuU2Rm?=
 =?utf-8?B?ZFlHbWJCcEJOMVEvalZJcmYyQTI0ZUJicUVLRjNKYWRhRXVQOUF3ZkFVYVls?=
 =?utf-8?B?eW5kK25lV1JFbCs1czV0c3hIZ24xS2Q3a2FOVHhMY2ZIMXhLWEhTalhCazhH?=
 =?utf-8?B?UWVZRFFBb2ZiVmVxemtSdzRZb0t2YWMrWHROUE13QnZpWmlydkxJSDVibG9C?=
 =?utf-8?B?MnpwK05xcloyYXl4dE94dnE3cHNKNTRvaFJIMzFnQ2VUMlVoTnk5Q3o0YWxT?=
 =?utf-8?B?YjVTSHJzTDhuZW9yMnU2M0dkc1I1a0VZbU5RWnFzMkF1UXFuUHZINGp3V2Ns?=
 =?utf-8?B?OVB2UERuMXowUUc0UlRBdjlOTnhTUjZ4SHZFSnhRalhXTHQxRGkxM2F1bklH?=
 =?utf-8?B?cUs1dXBpVHZTcGcvamt5ZnJNUnN5VVVvblZIUW5jMG5jSks5bTRxSmZJL2tj?=
 =?utf-8?B?c0R5TnM1TEhtNEVUWlFKeGsxQnlCbUkxNXdnQVhaOWs5OEQ3MnoxZ1FKUzFt?=
 =?utf-8?B?YjJHRUNXeDRmTXk2allkbElLY0pvQjRRZzZqWlcyV0VPb3hQcUx1T0J1bVB3?=
 =?utf-8?B?SE0yNDNkZTlKeE00Z3hwaHRydUoyTjh6bFdGNTVVK09GeUpTUU5WeGxFRzNX?=
 =?utf-8?B?Mm9JdjlZUVFmQkFoQWp0dTdzOXZBSURBTHhpeU9LTDlJclp4WVlWbXVkb25G?=
 =?utf-8?B?Y1RHU3NvL0g2R1p5QW13MCthQU9LYnd6MHI3OXBmRnkrQ0E3QjlKZ3pFN3pD?=
 =?utf-8?B?ZnRvWGF4Qmxzdm95TVBXd0FHeDRnWE1sTXpab3pCYUxFYS9oS1cydlBJaXBJ?=
 =?utf-8?B?WVRjN3phVk5Ma2Z0OEUrM3hJOWYxZkNabnI3ODRiUENaTmZQSnhWbzgyZklX?=
 =?utf-8?B?Y1FIb3Q4VjZpNEdyQUJUb1VUVVVDY3R4Nm9yU3A1RW90QysxK1R2TnplUHhP?=
 =?utf-8?B?Q3NPRkxUL0tZRE9ham9aV3V6YjlPK01nbnFhM3Z1enZPV3QwdEFIZUEzR2tm?=
 =?utf-8?B?cFpWTS9kNk1rclhoOExDRDdFMDVZNkJGU242alQxNHZNUDgzTzEzemxCRUV1?=
 =?utf-8?B?Unpqa0x3R1I5ZW4wWG91d1BOWmVpZ05OVzZmakZzRlB1dlBNVVY3NGxjSHVz?=
 =?utf-8?B?Nlg3RnVOVHR3eTk5UldRanhNTjFPSVlGeUZtdGpJUnRWeUFKbmhCNXQzdjZ1?=
 =?utf-8?B?T0VGaXZDcXBWeXFpQVRiZE1yd0RqK2NBaURKdWRLem1LSmNxVjZpWUJFVlkv?=
 =?utf-8?B?UklSaFRXaTNvbUZoRW9WZWQ4dzZjQzlFZGRmQ0VCdjVmT0o4Y0IvTHlDS2k5?=
 =?utf-8?B?cERXVThCN1JqQncxcEliYVFmdTI5WUpQRjBQL0FpRm0yNTdpYVYyQml1VjBC?=
 =?utf-8?B?Wll2NnpJZktFZlp4SDErU0hVVFZxUXNMTGF6YlRET3lYY0NUVkQzdkpaTUZR?=
 =?utf-8?B?eVdJMXdXNC9JRGZiWTZrMEQ0RHBPempnN1lmLzA3bUxjYjZETnJwU0g1WDVJ?=
 =?utf-8?B?L2c5Q1Y0NkUraHBtWDBoM1NPbUJML3NGRHVYQTFoVVNuZUJjR3p5RStSODBa?=
 =?utf-8?B?Q29PVENhRFBpZXRCdmQ0L2p0R1VXU01lQm11UUUrYUhBdFRGM2hTL0FhZURw?=
 =?utf-8?B?QTdCN1BPVTkxYkxoM2VXeUh1ZWRuM1UxamY5c3JkaUVMM0pxSkpNTkxBQjNB?=
 =?utf-8?B?MVMzUTNOWHRpbEtlbFNCdzlLcTNLOVA5NU53OGc2bW1SNDEwVDl4dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f4fdff-6dda-42ef-f402-08debafbd922
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:53:17.6944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJTP/FmoK6GDWXxFESZygLso6yh3St4DCmvwyZwUl1NaSQT31hfLQO0RFcRPlTQ7naZA2fpN1kQpRXIcBaEioA==
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

'node' and 'fdt' are not used, remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/musb-new/ti-musb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
index cc6c3b94a65..e083cb7d0ff 100644
--- a/drivers/usb/musb-new/ti-musb.c
+++ b/drivers/usb/musb-new/ti-musb.c
@@ -201,8 +201,6 @@ static int ti_musb_host_bind(struct udevice *dev)
 static int ti_musb_host_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
 	int ret;
 
 	ret = ti_musb_of_to_plat(dev);
@@ -251,8 +249,6 @@ static int ti_musb_peripheral_bind(struct udevice *dev)
 static int ti_musb_peripheral_of_to_plat(struct udevice *dev)
 {
 	struct ti_musb_plat *plat = dev_get_plat(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(dev);
 	int ret;
 
 	ret = ti_musb_of_to_plat(dev);

-- 
2.51.0

