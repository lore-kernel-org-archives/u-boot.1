Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19931C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 14:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 576318852E;
	Tue,  4 Jun 2024 16:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="XdVDwWN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA99388528; Tue,  4 Jun 2024 16:27:57 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F31884C6
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 16:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4OZlU4EFeWoStJ8PXq80Po9PrhHM2ZIzM+BN1uu7/22Bewde78Dqf+PIEGLG2RWaXAA9ggI7gDNXL13yzDBJ42kUQ5h0wz04pL6d4XbTVsowD9kH6ur7nxr7x0wOHlPRRJTjGMt2apFyVqJ6/tkdeNPZHCXxFtyM8V+V/2jKJOXpK7s/dsi8DLzgiSCEDCQQxUXFAfeT59kW/hRxFk1AIPBUSfBVtyvc+5Mv/biloGqvygDQcGAXxmven9rjormthvj+ewhXuuj4sWu7dKnN2Kj8CZkN8ca7J8jLq0xYbcVNa+Z2svFMVb0/i4TheFAu8dCJ9warFb3ibYA7fw2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JroC1DJuHAet2N3R4z/PIqJwiWgrAPsiTjnvRiOO6GY=;
 b=Pao2w9g1DuouLqEJHKO3jmE5xFrN9dAkmuxdmPaHoTPB3LLx0OoUBFWmn5UCbFIFrjVPXxcqhcZko0rD/cIro/Em4Q/TALpIAzhHm2fbWG/yVA25keyAsUkNX1+jJZ2rbMKLbbQz6hxv9fL/Ebn9/6GVMZCWDpZTICv2tDcJ04bYtXNKu2HFbMESPqV5qtw4JPtm6Po/HPnVok3t7uJySVoQp7cYUZDLa/A5evztIUyaJFlyc9XDp3CkHQWrjXoofS0+V6oWwBag+DipnqwRo/eYV9bUFCkUdVtBUpyaf9/+KW9d+3pDymTXRgso/Z3IwTQAMMNdtVYGVytU6JaPAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JroC1DJuHAet2N3R4z/PIqJwiWgrAPsiTjnvRiOO6GY=;
 b=XdVDwWN4aYF/toES67Vo3PkdU6l/elkqDpmKUcyEpkU7LyT/SbOQ8kNLNNia5nAfouL3b2BM4x+zZDvQ/BUI5eIL/mm6ROTT5VPrTNRZgsoJCEhQX8Eryj3C7wnCQOcuuAJR8yRWQhOG/YV2pGl+Dowsx90LIFS1DMNTtAp/XF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5827.eurprd08.prod.outlook.com (2603:10a6:20b:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 14:27:52 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:27:52 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 5/7] soc: xilinx: zynqmp: Use zynqmp_pm_get_chipid() to get
 chip revision
Date: Tue,  4 Jun 2024 16:27:39 +0200
Message-Id: <20240604142741.425307-6-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c869b9-396b-4c60-d679-08dc84a28461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nXeFrAYlKMVEpsNGWefXRGgG/K+4e06oJ9oQAt/P6aQFfuxLjbKx/vGGvh6O?=
 =?us-ascii?Q?SgEnOXGGjPt1Cnlu1VMQ+h51iuchTIDKsgZCnvhpsT005I3hdR5FrqQzxxLk?=
 =?us-ascii?Q?1FJUWtsK21Mh38ReUNhH0/rbI6bvX0nt8uiWudApYcJGzrfW+NwF372qupm9?=
 =?us-ascii?Q?FXScrI/F37FEthJ+lbZz33Ui+Riu2XTeFC3usgCLC3w1uM9g7A1eQ40nArZZ?=
 =?us-ascii?Q?Dzo6j8dCOA0YhMRRs8RfXAQ5PdJFi27HV/KFgVXKWqizZd3PwibLwRSnXEkZ?=
 =?us-ascii?Q?bUOIUZz8II5xrVQz0EvOOf8ZbN0c9BTkH5SN5V/RH9k7sahI50m/H3wl/mfJ?=
 =?us-ascii?Q?aVXldEbitdm6oRem/2UNWXeZjqkrV89nXO8/osdxzZM9vvCwKug8ZXLHxGxQ?=
 =?us-ascii?Q?MOucJHlmOwEd5WXS9HbqUIixNjy1gSigHGxmPOk2hmdHzLNnrrXNleYPUOKz?=
 =?us-ascii?Q?TNVIKJTXtrQDmJABISzIUfbJujt58Crg0D9p03dSfDnXnD6x3j9WIIEr0K/b?=
 =?us-ascii?Q?7RPul/vA/1MW1/YiBducGH20CvXkKcebgeIUtMJZo+IDTHA2Aghwb+v1xp5d?=
 =?us-ascii?Q?+40tzvzW3ksxQAkGjBxjkD8QEZIHkRJq1oTN1z2cacbhbcU0BFMIdWng68vl?=
 =?us-ascii?Q?WedNKpRc72qnS16ZUv7iB8mHoGOBrcYZdttIxoCDhY808shZ/isyS+vdcQpZ?=
 =?us-ascii?Q?kU0rbIemfSYuMMUqUGqtNvSoE9eWg3K8RP/j2QcBaYQeIDChN/NLkoYSdORN?=
 =?us-ascii?Q?vl6DByK6tX+pOueRJe2aOYXWx82HWt3hfQOW3IU+EtS6h+uPLD6pkKJ6upyS?=
 =?us-ascii?Q?LRFU7Ay/SsJsMkp6wJFw5ul5IR+lOiMomVJ6UFnzAXXWvX3/WhUPei208kPC?=
 =?us-ascii?Q?zw4Ikc+7gJHsIh0BcQu8YkQjGWgd50FPHPD5OKE/293R1Hg+cMA/Y5sEhaEH?=
 =?us-ascii?Q?o2X3B+3nLeX+tMJw3W3D8imWpt8dkksdhRYBMqnxJEeBwiRyziFmv07ZoYMe?=
 =?us-ascii?Q?OatOIULN/HJ9JPvTxOkW+J5P4g/LZiN3eC2wrq2eMeCNgjvaiODgiW91ACB7?=
 =?us-ascii?Q?XNh5ReUs+f2jzR5R3GVcGl91QesshLi4gztasuY78kZUldHX5oTwzxza11uh?=
 =?us-ascii?Q?/GNPAsis2Ly2HXgbA2/N+d6myqnVzanqegb/bauPPg4Hf8EGql0I4O+X85EV?=
 =?us-ascii?Q?iG0QIB+toYemvofI1OQm/tdAM6PSogBd18JNdvocdoOW6nOQjzMDeKTwaE1U?=
 =?us-ascii?Q?xlDcWkfbGXYw2LjjuL7BOSzIm9o6GlJ5D5i19Fw4Xo7JvozrYawzwX0HcvQL?=
 =?us-ascii?Q?7YTmAqWF7yrSbgZqWJhC+YGfrAD2YzcJ4PfFocAqPqL/W/rxCKAHANnTboFH?=
 =?us-ascii?Q?r2f5NeM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AmMYLHZVaglSaoB5yXXNoOGiUnsJ1aBpKnONkF7cUy4RdoIjcdB5D1oKtpqw?=
 =?us-ascii?Q?WiOXaHdg0y2I4bTz86sDRv97rPxZgG4RF8pSOW1dJjlN9H5bAf5wp6ekfMwr?=
 =?us-ascii?Q?o8Y69S9Noi9hEW4bScKS9aXwqGwKg5cckxIcTen7rxqcywrlxPj8EFgetuzn?=
 =?us-ascii?Q?PodwQIzXW2lN9C4m/yOIwsseO2vnNxLLpL9E9XEXAwJgMaRdjSzxGMExwmpu?=
 =?us-ascii?Q?rgVjhtYkbyAi8dxlyvWSAzufK6bP4agB4dHLQLNeTKnqql1bI4qF7DCi3GSd?=
 =?us-ascii?Q?zOrgMHVsQSogFcX+66w5TTL45Cp/n2RpKV8Ue1c5WH5q6R84AZLaj6bya2D/?=
 =?us-ascii?Q?ESLM9XO1Y98PIgCRWxRgmcxOgjenPkzbuSNIR//5nSBc7fo4Bibbz4LsJW2u?=
 =?us-ascii?Q?oPdpSKQAybaamcWqEITPGhAoahh+K54CVipnVd/B+ncBtL3djrJnW7ZyusKb?=
 =?us-ascii?Q?K+/9C3R+NKLg0vWaRv4ahQUoBl+oC5wOykkV+lY1eGXkFtLRlJdjxnxq9Az2?=
 =?us-ascii?Q?OiIlezg49peqFQVmF7CReXrlpaJ7cKeptE/lAQiaFPy5J4bbHWl3Dl70ENoV?=
 =?us-ascii?Q?PVd74QmAZyyChnJU89jJ65IP7V+MoZtRUBDGn5kpgsia4PNRCV7J0YVTgNqn?=
 =?us-ascii?Q?xq1fvQo2jKta5IZw6e+E7KLEkfbiQzIzCPh7PI13kNv0zsEi6C1TlnWx4RIX?=
 =?us-ascii?Q?VxUNuGX7dcrgWSCb0pEvpPoXvi2T//7DAjA7ccXDTgW094WLpJAQLOuUdRqk?=
 =?us-ascii?Q?G3eW33BWhivjNEY4iji/MwVMQ7p342GQZlmZJ282XwwMUk5SSApmDPZkPAhJ?=
 =?us-ascii?Q?GwxqSbFlqaQIZ1R+R52RZrdwrPO7Kf9ssBHdoOa45E71MJKSjfsR+wLv0w7g?=
 =?us-ascii?Q?Dj59Hfj9WHoNXzMFHlFB9wXz9gPYfrwEmR8V0K1A1NuReoEp6VidDHxQ8T/m?=
 =?us-ascii?Q?+OLXi5XPdU1qgRhdDlK5VR3gOsyZ47f/2fCyJne4S6jk396dTzYuXbMWh1Ck?=
 =?us-ascii?Q?3a4SVy1ngnPaBfuVyzu9BUP/hNh3Bt620aaHqu1ZLa50v3wbZBxRjRDOH6pM?=
 =?us-ascii?Q?aXEO1+sL1g5qZi1GjXnYVd/pO+B5y5fFZ9k5J+GUQ3OA7tHPc1wdRBisBSmQ?=
 =?us-ascii?Q?cRYQ+fY8qw0bv3s+cZfDNgRl0ZEroqAJIS+QKomp8F+sujcTgI9swvIC8Hu2?=
 =?us-ascii?Q?+EyIgdkw/TJyi1/PkBzYdfLrPd9ioQe6ObhWaURTrHvbMx8lvW7AmboYkU2L?=
 =?us-ascii?Q?I6gYeigJvsBJQsR09qNMgA/52LKFEA0kxMQ4nz91wFErAd2+TUx8ZW5rfyRZ?=
 =?us-ascii?Q?ZtM/SEWC7b7GEAz65TQ0ISe3P0O4tQT1VcmCrdRIC1ljTg7UURD6tzDqUHZh?=
 =?us-ascii?Q?izaHKATJPOjqu0Isq7R+V1uM3Cm399tN9Gomq4px8mhgKeXjySssHbfsFP+X?=
 =?us-ascii?Q?LCpVaPb5ODty5vcxYDV8oADHigi5DiJboGL+oMTNOUJ9rUXX6vXNcNPVjVjN?=
 =?us-ascii?Q?HlqV4OkOqeytUq/qhP8kzM8UN5zKngOq8S0d9ZiuQwYM8q0Ng1Vo7GHuNeGB?=
 =?us-ascii?Q?qKvb6ORuoMT+TgbXasK+Itkt/uMNrgGBZ/Ta4AO9ZU9jHUwkeXh6JO2lp3Gx?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c869b9-396b-4c60-d679-08dc84a28461
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:27:52.1066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +g/r3Qz5bxXMJog7ncmzdD7NRDY8CuVR8sD73yUDFbuRpdc7h/E7MChgapo2TEl9kwylebnXooWg4hthBDHWyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5827
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Use common zynqmp_pm_get_chipid() function to get the chip revision

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 drivers/soc/soc_xilinx_zynqmp.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index d8b4f172a39..8a65810b7d7 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -346,22 +346,21 @@ static const struct soc_ops soc_xilinx_zynqmp_ops = {
 static int soc_xilinx_zynqmp_probe(struct udevice *dev)
 {
 	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode, version;
 	int ret;
 
 	priv->family = zynqmp_family;
 
-	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
-		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &ret_payload[2]);
+	if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE))
+		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &version);
 	else
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					ret_payload);
+		ret = zynqmp_pm_get_chipid(&idcode, &version);
 	if (ret < 0)
 		return ret;
 
-	priv->revision = ret_payload[2] & ZYNQMP_PS_VER_MASK;
+	priv->revision = version & ZYNQMP_PS_VER_MASK;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
+	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
 		/*
 		 * Firmware returns:
 		 * payload[0][31:0] = status of the operation
@@ -370,11 +369,9 @@ static int soc_xilinx_zynqmp_probe(struct udevice *dev)
 		 * payload[2][28:20] = EXTENDED_IDCODE
 		 * payload[2][29] = PL_INIT
 		 */
-		u32 idcode = ret_payload[1];
-		u32 idcode2 = ret_payload[2] >>
-				   ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
-		dev_dbg(dev, "IDCODE: 0x%0x, IDCODE2: 0x%0x\n", idcode,
-			idcode2);
+		u32 idcode2 = version >> ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
+
+		dev_dbg(dev, "IDCODE: 0x%0x, IDCODE2: 0x%0x\n", idcode, idcode2);
 
 		ret = soc_xilinx_zynqmp_detect_machine(dev, idcode, idcode2);
 		if (ret)
-- 
2.30.2

