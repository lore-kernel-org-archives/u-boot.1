Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F7DC7115B
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 01:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DEE88A75;
	Thu, 29 Aug 2024 03:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EC5688AC0; Thu, 29 Aug 2024 03:31:24 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BF888B29
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 03:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWVKEbzTgDcqLrWE6VYP8g/3geFtZoJTZjNw2+6p1NwQcl9zGWCXj4T6bQHTi3c++TglKnXarjDe95+0AI+QhEVSvSKuhLuAUeh2I4608yEo+PLEP6qb/vXNV9q7cSlx202zeo2rcsKKF/75uIPAN23CXtLILsE9ylfB1gCqLHKW4g8GmJRs8sukRd5cyDJtHU7wtn/CYFieL4w3iCGbPceXM+1b67dePkNo5Q3G6xZtnyfHFKTIf/ulJasSeC5eEQ5GYJMQLEm7PzUdVPACYYYBkK6NO6EI3AhXMS0heY+Xn5FwlolLA15suxv1FgxpgaTwSSXnt38OkxhxZAMQIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+lWbjZTKfzwlPGdXIqMcgrm0zQfnQd+vm8HZbBriqs=;
 b=VRAwMNWAInlGJjpBiQWXvLGLU/Xg/6DFofe1N7HVTjEvq55Qa0eSxcoUGG1nCB+Giv3hMCOFil/qVCWcR/1StBXCg1vKaPf1ZD9dowpWbtVVkN5frCtfsmZw0nizUG2U5pPcjUkt1HEc0sxNA/VLjbHjObqFpo/mD+rUOP3/nyeRv5FqgG1Wf/nDOpC2TaEIpiN0zmCcM1Bvrao6O6FMlsmjQ647Um1WDrYG+WV1xuahKY+EPLQe4Nw14foTb4qYZ6NIo/yUUt0fFRQGXtRcaZESvgdvbOt0qROCXkyEDsEzm+fcLpKzusEUcMEjhDPFTD0C5uBYZ6MJEvQ6LQYGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 01:31:17 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%5])
 with mapi id 15.20.7897.027; Thu, 29 Aug 2024 01:31:17 +0000
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
Subject: [PATCH v4 8/9] spl: starfive: star64: Setup USB fdt fixup function
Date: Thu, 29 Aug 2024 09:30:57 +0800
Message-Id: <20240829013058.6178-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240829013058.6178-1-minda.chen@starfivetech.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0574:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2e3be1-5b22-4883-95ce-08dcc7ca478a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|41320700013|366016|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 6JBsU+0oZP3tqux8tkIa4NgPMdjDR4R3fNNrCpg33AORge3v7Gz9k6lpTbhO+mGnssltKF7ezlyock1nRo4UhFAu0PocVZ00TjLeJZe9Sxtj9cGjyIOTZ7VgOnK+zdJZoz9KfEdBewvIhWCyYmbxKCd6nRQHOjCgIqo0bS//6AEewkBXY+wiWbM06pTgosSq0FYZQfsfcy+7tF/eglB/ee3hfVWhC7GfhMQtI1NOM8uPOYGmGkd2UJxoaksZoypsrSgBY9fVHgJ+ns+dG2E1a3BdgGnUfV0xprFY8T2MEC0fj8cElEfbqME07ZrgmAk6wpYzefsrOMlC2jNjjCNMzMa8YnCFaJA/ychYbwnWZz5VDUwBdoTzaVM3wAersGl4BdFRRBTudeuDlsFNcmuh0/EDRG3yB5RdAKwnta8/rYa2aVwaHgqb0Qu7bRdst53bUVHcbm/nFOeXVmqm5EpnIxqZCRDd/Fx9aJ0vqlGUKn4o6H1jbAlUTAWepAjvknzM5bCgOghUqnFVJhDh+sCRLW6pU7Z4AhhMjBiDZlU8SZwll9cYQzWsDRHJMIed6ExS4c2DuoV366vMp9floALfJvjrFFliDFyADg1boYXw12J12PyVH1tADMuHNejH/faVwE8qm4AH1c35JdMfPIn2Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKm3XnJSCVEGOIHYmdFdM9I8UB/rAGEguwFHlZIqTQ6S8eSesMw2nbP7eMwd?=
 =?us-ascii?Q?eVvWN00QLToRc2pWhmpcB2FCJO3neSfLXJS5tiX9zEcXwexH4jQZKjlPims0?=
 =?us-ascii?Q?pMSaXMiSRYLXjnGZfjiNwUZw7hhNb9vcWvTULapxT/VEW+BBDfrKU+FW1MfP?=
 =?us-ascii?Q?p/pJJ0Pq4ajzf4G6+sfDjQVYBqg3LNn0nK2bWNuAW2lW0tpYJtKdqVN6xCs9?=
 =?us-ascii?Q?O+p6rquxCPDQ+f43vPzmkiP8SyFcmvcewGTQdutrowNjGqcj2Cn9PriT4lqP?=
 =?us-ascii?Q?K1B1xqHY0JO3OeYu3IQ2/FV6R16mbu2lMZpyFFv+k/1UPj+WXlzXUi0p6hvn?=
 =?us-ascii?Q?IbQmiA9YMD3WRHiXtK1mqarJh6OSIXRrW+PaFmiICJIL21IhgZyfcqeH0K5d?=
 =?us-ascii?Q?0IrtgXYolyI7xKq1zaRuCXqxQtvcWx5OaEqMKCaivSCEON9misJsi3Fxyv5t?=
 =?us-ascii?Q?CzTR1wr13/sTbbkHAs6/ALa/tnFd7gwUppzmdcXRkqhkj+gaAwuk+OpAoEvk?=
 =?us-ascii?Q?yEQUYXBRwQX2L/DzRXNVna/hQn8bHSKO/TaHhkOXZXw8ylt7ddgJAz0WSxCW?=
 =?us-ascii?Q?QGtFtRZ0WMLUllfuz+pNxe/GDjEAlhTM4nLL7xwkvYonbjyOmCxRCYC7sD4S?=
 =?us-ascii?Q?32+MVMgAeMeCNyYi8VHqUxz9BsHdhEWj5XZ9U9eR7Kk/vkn4qXtlJNCxz4l9?=
 =?us-ascii?Q?JcAobdsWon2faUs+c/lxpejGOfLlF3IofcvsTdWAYhbclhFGOnHsQHetvbNO?=
 =?us-ascii?Q?9oUzOT354AumwtCkZ9kqbyVw2thRpzkcKH3ZpsYLocRJM3zcziw4zLw3aGnI?=
 =?us-ascii?Q?I2OjBw9apPwkvHZrQ0SdVKEiuxxvrsMZgFLQUIcnCAYopZ2HIR/ULjpRWg8G?=
 =?us-ascii?Q?8CE3NUi2VLoLT5+wv5YxOQPC87Y/f8g1LjljkhoUH91ZixdIhbC1tZqVucI2?=
 =?us-ascii?Q?35l/QgbTt2/wm60FvtdqZVIVOcrZ7WLcAQGGyevExkk0EMsfLithVw+EL5TY?=
 =?us-ascii?Q?C8Ogx4GLg0b/yMZcw7iIlJvbRnwu4bgaVy/ahdZDozN8c6QJm7Od+1INu3DI?=
 =?us-ascii?Q?VrhnvsEpQ+yld44hggKiRlDbN8hmQno1H2RUxCGI5U7mzI2oaBOQHV4iSv7t?=
 =?us-ascii?Q?RbpsizrzjN//uzCaNprI+bb1oSwp3YzKqNhZOd73t8bsqKXfYAFNt+O7Ko8v?=
 =?us-ascii?Q?HvEC2Vwi+PdYVDRvWZA0CyyS+6uql6rVpGuxO9OFpCr9zN991E4GbAsvWe4h?=
 =?us-ascii?Q?nBC/9ZF6qy4KYQRilWlud2VEhmqmKM9Oq5bGsSI4yb57HKZUZgoMW4SCYABz?=
 =?us-ascii?Q?KgcGca9rLMTKfYoQm3GgvbbxErEsq+Pbmp/vOcMMjWx0ZpvB9fLTsfIBb9dn?=
 =?us-ascii?Q?FiBweoVEVd19pRpGHfJlfCWSja9JIbBzdA5ETR27Rcq/5aC6LC6BngJWQzzg?=
 =?us-ascii?Q?aB0drGFps8SW/qJBVHsqR4XUWtSX00cuLOsgYvBd7Un+s3UomVkiRpT77UeS?=
 =?us-ascii?Q?c7NzmImJ/TQy1o/9iPIjkE2AD8QUK31I53DGrhtWK6aooGhvxz4jjxVVm7NV?=
 =?us-ascii?Q?y6f/6yhLkVvagsbx7J+T3UF8abR7ArjFX45sl9D17g+vvEMsfI081qgnvtjJ?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2e3be1-5b22-4883-95ce-08dcc7ca478a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:31:17.8374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVCzX2V1Tgb5mKW7q4UbTtBdV9GicF21fjn3GW+cGG2bcrSCOThaZ2+2t8pk0bITjtZiStOKUbLpC7ylIHd69I4Ig80T5IzCvmG/xU6RNxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0574
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

Setup star64 USB fdt fixup function. Set dr_mode to host,
and add vbus pin (GPIO25), and set USB 3.0 mode.
the functions can be used by other 7110 board like Milk-V
board.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 388a06e4d9..b3034b19a3 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -123,6 +123,69 @@ static const struct starfive_vf2_pro star64_pine64[] = {
 		"tx-internal-delay-ps", "300"},
 };
 
+static void spl_fdt_fixup_usb_vbus_pin(void *fdt, int pin)
+{
+	int offset, pin_offset;
+
+	offset = fdt_path_offset(fdt, "/soc/pinctrl@13040000"); /* &sysgpio */
+	fdt_add_subnode(fdt, offset, "usb0-0");
+	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/__symbols__"),
+			   "usb_pins", "/soc/pinctrl@13040000/usb0-0");
+	offset = fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
+
+	/* usb_pins */
+	fdt_create_phandle(fdt, offset);
+	fdt_add_subnode(fdt, offset, "driver-vbus-pin");
+	offset = fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0/driver-vbus-pin");
+	/* GPIOMUX(25, GPOUT_SYS_USB_DRIVE_VBUS, GPOEN_ENABLE, GPI_NONE) */
+	fdt_setprop_u32(fdt, offset, "pinmux", (0xff07 << 16) | pin);
+	fdt_setprop_empty(fdt, offset, "bias-disable");
+	fdt_setprop_empty(fdt, offset, "input-disable");
+	fdt_setprop_empty(fdt, offset, "input-schmitt-disable");
+	fdt_setprop_u32(fdt, offset, "slew-rate", 0);
+
+	offset = fdt_path_offset(fdt, "/soc/usb@10100000"); /* &usb0 */
+	fdt_setprop_string(fdt, offset, "pinctrl-names", "default");
+	pin_offset = fdt_path_offset(fdt, "/soc/pinctrl@13040000/usb0-0");
+	fdt_setprop_u32(fdt, offset, "pinctrl-0",
+			fdt_get_phandle(fdt, pin_offset));
+}
+
+static void spl_fdt_fixup_usb_host(void *fdt)
+{
+	int offset;
+
+	offset = fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /*&usb_cdns3 */
+	fdt_setprop_string(fdt, offset, "dr_mode", "host");
+}
+
+static void spl_fdt_fixup_set_usb3(void *fdt)
+{
+	int offset, phy_offset;
+
+	/* disable pcie0 */
+	offset = fdt_path_offset(fdt, "/soc/pcie@2b000000"); /* &pcie0 */
+	fdt_setprop_string(fdt, offset, "status", "disabled");
+
+	offset = fdt_path_offset(fdt, "/soc/phy@10210000"); /* &pciephy0 */
+	fdt_setprop_u32(fdt, offset, "starfive,sys-syscon", /* syscon */
+			fdt_get_phandle(fdt,
+					fdt_path_offset(fdt, "/soc/sys_syscon@13030000")));
+	fdt_appendprop_u32(fdt, offset, "starfive,sys-syscon", 0x18); /* append reg offset */
+	fdt_setprop_u32(fdt, offset, "starfive,stg-syscon",
+			fdt_get_phandle(fdt, fdt_path_offset(fdt, "/soc/stg_syscon@10240000")));
+	/* append reg offset */
+	fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x148);
+	fdt_appendprop_u32(fdt, offset, "starfive,stg-syscon", 0x1f4);
+
+	offset = fdt_path_offset(fdt, "/soc/usb@10100000/usb@0"); /* usb_cdns3 */
+	phy_offset = fdt_path_offset(fdt, "/soc/phy@10210000"); /* <&pciephy0> */
+	/* append <&pciephy0> */
+	fdt_appendprop_u32(fdt, offset, "phys", fdt_get_phandle(fdt, phy_offset));
+	fdt_setprop(fdt, offset, "phy-names", "cdns3,usb2-phy\0cdns3,usb3-phy",
+		    sizeof("cdns3,usb2-phy\0cdns3,usb3-phy"));
+}
+
 void spl_fdt_fixup_mars(void *fdt)
 {
 	static const char compat[] = "milkv,mars\0starfive,jh7110";
@@ -335,6 +398,9 @@ void spl_fdt_fixup_star64(void *fdt)
 				break;
 		}
 	}
+	spl_fdt_fixup_usb_host(fdt);
+	spl_fdt_fixup_usb_vbus_pin(fdt, 25);
+	spl_fdt_fixup_set_usb3(fdt);
 }
 
 void spl_perform_fixups(struct spl_image_info *spl_image)
-- 
2.17.1

