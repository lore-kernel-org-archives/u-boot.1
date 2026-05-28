Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D22CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 06:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AB3846E6;
	Thu, 28 May 2026 08:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="er28L8qS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2082846B4; Thu, 28 May 2026 08:43:48 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F6D3803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 08:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHZi676SShzXIwq8Wb+EzGFPpynP51/k9/Y6aVeGntXV5ZKGm55KHLXIJpPKP3hXVnSZitURgYTQKl5KdOB0p0Gpz2oZwXydtz+kZHTIx5GSpmjDnK8XRjA/+qzV5muJ8VfEuqnCuZ5Ovf3ukKckic1kPBLpI+FohNdK76Ynn0xAwTfGRdnK/GMrWQalXigB7HLStIb8lnoTPmpgfinINGQPfNMtVPKEhZWJY4OhFD0MJbj4NW0rOVhn8wUL0eJy8SA0f6blRu5vNe3bF8SNeVf5TVHDWvuvfUE1ZXAZmnMBlTbhyr/xj7lYQJDzjfwpGoLHKleuDWikdcKJZfhqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+M9KXtMdV4k+n4uvcN8befJBzIwqaLDPC11fwVjKOEU=;
 b=WMCyHhL1WEcFwK75TjPGZcGvRKpYexe/+xW94cElMVfBd9xRCKQtSuR6u5l7hgtmXBI4jgovOtWuvar8YMJ0sJhUT48SM7y1Ip3s4uec8+8kVsKP8FcvPp6ENTCxE+S+ffxsHvZW+8yKvrSxs8dQ4lcD/WjJojo3Su/61EVXmL4vAn2mNLqH3rJg6lGOtA8aV7Tfurr4Rc9zjkDn3NyZ7bGLLHfwAbhkwzkTRakG7LA19eCyV0dhCQy04LbJiXAYZXgMt/uokd/zwIkfttJa7k5WJjwwe5xNKwQeQOMjg0VoVliVWFm8r09R5hVWJnPUIPOTc0ClLWdk1EkIMG12lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+M9KXtMdV4k+n4uvcN8befJBzIwqaLDPC11fwVjKOEU=;
 b=er28L8qSU8IqfzkxUPd1wyIVUEq2tf6MD5EvWJxGKl3jxJvmcKoBGOhsecocD6GQE7yFVLJF51i0zuGCH5c3g2JtsXQvVqtJR6+cOvFdzZXmWIJ4f1tHbmvuwtWm7E3yVWj/hLvpebo5e8AojcIV25Te6gzKvM87335DnvlzCfcPmKwbqR+l4EBK7ipsi4pYJb6STv7REN5KtA4A+aU9tYJ09GA5JBydN0eco+LZU3qVLNjmyUEBxnlTThT+zw/EQVIVRHWfGyA0rDcc4oLyxfccCIIOFSUOAmRLu4GJ/TgaYX+ktBSHmqwmhfLz72/4MrJiN3eWbL4Hl9SrI1arDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB8516.eurprd04.prod.outlook.com (2603:10a6:20b:343::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:43:43 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Thu, 28 May 2026
 06:43:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 May 2026 16:00:21 +0800
Subject: [PATCH v2 3/6] net: calxedaxgmac: Use dev_read_addr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-devfdt-net-v2-3-dc6f20b82611@nxp.com>
References: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
In-Reply-To: <20260528-devfdt-net-v2-0-dc6f20b82611@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: dadce20f-7d9d-4acc-8d14-08debc847618
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /wXZjULYb4rBKz5C6+BIwAmpy40c8JTb1NHReYS+kbPGu2oy0r9GBIccMT0pkLaZmm0Zgjd8/695ZU/t5U8o0F19BWxEN/YXpu9dFCEa4582flG72PQ3Zk/dmHC7jjoFF3UCsWsTerK2ZUV4sOwNpNbRSWsj2JmloHV0DvgYwVIWeaJ5Yobc8IDnxg4TrTcpaA03n1CP7ZGE9fEXniS1vle3S0yX/M4mcfs0GFqCviGD7mgMi3E17vJJoJn6mPRxor9akkQsCPeYlLTI6OiulG1E80HPEpY4il4D/4eFNrd8bYH3E/ep0suu5tYszx3XOCAlQiOjibkS/bXuEMI6gzh8RgWqz0+27ivHu9bwaA5HgYJrQbQaohpcBnNkXPw8EGMdeYc5r2CtbtCBP+v8cn/43gof6xhIxZcCFaI3Ddb5xBIlQnFkros24RCVebnhx4YPI67eQ4RfYhI7mvReLt2tpuQD9psLy4JDwNdnnxUelU5/p63w3VqlF2c+GYAGDNQOpQMcO9IN2aXOKAedhtOZQ4gJJLw50VruK+nj3TvXByqO9Fmw1SN5HQMnALvwnigdYjg5P3YjyhfdAA2O+XkLXuCpAl0iuyDr5xT2AtwLHr/ob9vWSHkclHpOk1hBBgHjZleDX0a7P+2q7m5mddNAtDceH/F+VVBnA/Nw3NbZ+WDAJtAZN7ssO8mcb/3485FB5WvnkD3ozYkWQ3G2DT4EQQyUxYhkgmvIbSnABLkpCp+zqINlkvD3Dyx0U77W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhsMk1FWnhBKzQ5elExYzdjZHo4ZHRYR0JnVjJYVHlXUVhob0pyaGdmcVln?=
 =?utf-8?B?YlFNQlV4aEZtM0V0Z2tIS09BaFBzTkJKZFpEU3pBcnFRRml6OGVDcEFiclhW?=
 =?utf-8?B?QlV5djJmYzFYOE92dG8yTXc3Z05SMlcvVWtIN21mcGZpYUtLbTNyWk5vZ0Rx?=
 =?utf-8?B?MTZ5dy9aQ09qVGZ3M01RaEloNkYwZXhEckNOa2o5OVozZVpBZEVtVGpmNWcv?=
 =?utf-8?B?OVVLMCs3dFljLzdDWUZuWFBObldlaFpLNm0zTGlhNXJIbE90a0lIelozQU41?=
 =?utf-8?B?UFJlRTR2SkMvNHZtUXJBelUrQ3VBVUQyYXpDU2RlbnFQaXBwanYrQjk1dm10?=
 =?utf-8?B?SlFCWjUzOXFjdzlBZlVjODRrNUxia3JhcnFiTysvNmI5Snpnc0EyQ0FqOEJQ?=
 =?utf-8?B?RU1ub0hNNThTYmk1dVhHemwyMG82b3ZTRXZ2NThIR3c5Z1JzS1VNZndVQTVx?=
 =?utf-8?B?S1VyOEdGaGN3b2Y4Vk5WS3VPUU1LUEg0OXFzSkQ1L0NzV2ZhUGFmQzQ5ZTVO?=
 =?utf-8?B?YnVNQWlyQnorb0xXT2k3RjcyRC9aMlFMaDNRQmtuSG8waVErZUhFUjFBMWlY?=
 =?utf-8?B?S1J3Qy9jazdKWHFOZ3AvTFZFTURtSVp0SThsN0JLYlRkazNsVmxOdGtkOHNT?=
 =?utf-8?B?WmVXRDhBUmVtN3RGS04xU1VBMGREUmZaUE1lSzRwK05xTFBDcS9DSkFwMFBu?=
 =?utf-8?B?WG4vdjZ6QnU5bWhOSVcySnY4bjR5Zm1JdUtaZkR3UGNkMVF5TnFXSHFIV09z?=
 =?utf-8?B?d1l1NEtOYm92QysxU3BENWxIczBNeTNMTjgwWXRWRUE1OUJjV0FkUTNqeGx5?=
 =?utf-8?B?cXdVR0d6WEdsUzJtNmZrOFExMmFEdmN5QnJqakxQekZNeDNXNFFULzJWa2tM?=
 =?utf-8?B?OWw2N3lWalNFREcxakVDN2IzSlF1dlh3RGsvNmZ6ZGhBamFiNWNKNVIvOXVm?=
 =?utf-8?B?eEducW1KekFTcjlPRHNmRHRUV01HUkRiOHFBbmtWUi9TZ2tlbzl1NGZERnRF?=
 =?utf-8?B?VWtOVmxSVW5OU1NLSlVtRzl2bExVQzhXd3drTnBjdWNWNTJDaEYwZmJKY0hH?=
 =?utf-8?B?bGp1VDRKT1U2Z2pBUTRISnZGSXMzL3FRY1FXOTgySnBITXY0bUNGUzBUZ01z?=
 =?utf-8?B?M3lQdmNBWmZraEVXT3BaN2FEMGM5V29UMGtZVEljbzJaeEx3R1BsT2JvVlM0?=
 =?utf-8?B?UG02UkZpR1VwMVc0K3BRMzZObE1uR1pFeHZkWTdSSDRtQm56LysvSG8yTXNn?=
 =?utf-8?B?SElSaTYrRTRNRXpqcE5ocDBUakUxYlV3VksvTGFPSTFyeUhUdXl3SjZacElx?=
 =?utf-8?B?Y1plV1BoSEVPWDBac3hmd3FQMG1hNitpUXhTbE1jTGRveEJiTUVua0FldkRE?=
 =?utf-8?B?R0EvRlNWaVc5TFQzdUlJYVBJZGk4UXJ4TUhFWkRiWFdxWmJ2djQxRnRyZ0do?=
 =?utf-8?B?UGlvNDVzSThMemU5bmt1ZXBKSlBtempQQ1Nta1lpMFlEUTlaL0dhamdldDd4?=
 =?utf-8?B?b3hWMjhkc29obWtJRXovQXJIZnNvMGVUT0M2cUZmV1lXUmpOTUxyVnhtR3FO?=
 =?utf-8?B?dGZFaExtVlg3Zk5xYVZ2bzE4ZVM4RXo2MXpKOU1uM094UmpjNTBRVmZReCsv?=
 =?utf-8?B?REM3YURoMUlBcFU2NHlLaElWeTlEcXRERld3c1RSM29OZUs2b2hNUEs5bnk1?=
 =?utf-8?B?dG4rK0t5RDQ3aW04Vk41aVJ1SnFvQjVOOEkyQzBwTktUMk9TMjQxSFpaNFJM?=
 =?utf-8?B?dFVlejJ4dWd3TlI4UjhNTmpEdzQzL3czaE9HcnhVL3kzc2FtSDBPNGJMUWFH?=
 =?utf-8?B?MlRzbFJVQmRmYUEvSXZBWnpETU5ncmdFRERXeFNoS3ZJM1ZnbjIzUllaZVhx?=
 =?utf-8?B?TkVjNHR6WDdNcHZYcnRHZkU3NHJNd0NZZVJ1Um9XL2JYdWU4bHJXRVdZeVhz?=
 =?utf-8?B?UHhZcUVFNVU4dHYySXh6ZWpHMk90N1puMzBwVU5aR0xIb0VOK3VrV0ZJV1hW?=
 =?utf-8?B?azRNNDhLY3k3d1N1ZkxobDlUd3NQd2dwVUtFV3dTZHV3NEVqSFN0dHVoR1Bt?=
 =?utf-8?B?NGk4S2srK29QeisxeEpWcnhXQ0RPM1grNHF0NjFIZmE4SkpsWk4zUktKRGZJ?=
 =?utf-8?B?eURrTWhoc2p6Z29tQks3N2FaZ1dMSkNxRjRuQndLK2Q4aDlPZDVITXV3S2ZR?=
 =?utf-8?B?dTVSUDJteVViTGVDNkJGY0tqSHcrNERHRUVnNFBaVjhjdlRrbWhYYmwvWURL?=
 =?utf-8?B?Yk9jUXVmR3ZaYmYyS2JnQjZuUUVMRjBmbnJhSnpJc1M4aWlJNWtJcExlR3FU?=
 =?utf-8?B?dkdtTnJsWjk1SG0rbmtsMlVVRVpXLzR0dWF6dE1ZMFFRdXRhaDYwdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadce20f-7d9d-4acc-8d14-08debc847618
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:43:43.7776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUWXCMtxfv7uy/pHNQOPDKxISM1yUHHBLF1sAC661amoj6EpTR0QtkwxQLbYuwSB/k4zkOZ49Q9wqyHE+NhQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8516
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

Use dev_read_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/calxedaxgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/calxedaxgmac.c b/drivers/net/calxedaxgmac.c
index 92990fa6d47..df0ed820e06 100644
--- a/drivers/net/calxedaxgmac.c
+++ b/drivers/net/calxedaxgmac.c
@@ -555,7 +555,7 @@ static int xgmac_ofdata_to_platdata(struct udevice *dev)
 		return -ENOMEM;
 	dev_set_priv(dev, priv);
 
-	pdata->iobase = devfdt_get_addr(dev);
+	pdata->iobase = dev_read_addr(dev);
 	if (pdata->iobase == FDT_ADDR_T_NONE) {
 		printf("%s: Cannot find XGMAC base address\n", __func__);
 		return -EINVAL;

-- 
2.51.0

