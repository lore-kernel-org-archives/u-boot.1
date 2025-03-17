Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6130AC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 11:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936B980107;
	Mon, 17 Mar 2025 12:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D2D480F4C; Mon, 17 Mar 2025 12:36:43 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20708.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE9BD800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 12:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXbopx/LC8lcsECTE+u39LfzbsBSqh1PXY6702Jt2lNaQrZYaLiPdQ6gc2Vpq0keKm7CxcBtZFPHwXxHaRp2gUIVdNAjsmct9JQaRTQuZWd9kFoxDmUCebTVAQr8uSwe2OFDKATu8m9Jxq7GNRRB10vGrGSzxYatw1NZQt1ks40L+00CrojVPd119dc/QW4B21xhMuflW/1sNSaXwUNVCiqfj5e1zEC5q1RSndquALqGinnky2BD2TAFu8z84aed59V9g30h44L8Ezm2FVdfhrp5r2kFB9g2yhp5mXOF8nZQ5Ojg933BeU/rA9p3KhM1d9qI8K+VInI10Dv7J8z4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbFRzmsHYVGKgAxMddJJvW4ZyK15S9vnDwVo3D8WnKA=;
 b=kDotA1rfsfNfH1z+SOBHhodYLv29vwD9sUbEZ/7OiTTqfxtFgWYOvWl65E74thrnCbzvBQvuBRnh/zEA/bulyC354kN8hwybEcQdCHFKIaWnLE8R5J0hcSh15MmkicwtTkneit8Xs6Kv5mN0G9rclOBXC+FI+KSLMYlLA53PPeotw3/LVG0YunTrUBcpeELXE4f/xh+xz3jNbPT+O7E1vjvL4gDRmwnEdDr1QOdulUJqx00ZBu2WMdP2+7T2Yf3iEd/1RVF53SB9AECJGcSPIgA8t3L+GYJpnz6P6F08tQ7I+dDlNNtk3Y2AOe+PJmjwP4VKJvx93YYpLMdKhSzQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0605.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.37; Mon, 17 Mar
 2025 11:36:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Mon, 17 Mar 2025 11:36:34 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2 maintain
 files.
Date: Mon, 17 Mar 2025 19:36:27 +0800
Message-Id: <20250317113627.84885-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::11) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0605:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4010a1-4cd1-464d-9a46-08dd6547f85f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: oWrEWDH6VXlhO7jJFd/bmaGuUGFEx63gO/mJ515kbzK/oAAk8cR+0GJUKCUUNeAQ//PashdbbOv1KIg0+jqM8phz8oENQ0F002qHvsibmfY1JYl68KX1/NnHqeRxItpxPEYZGAtIa6R+se+e5GmLlP5R307pb1LOplFlP8crirLhhOKZYPaqZulOxN4aU1+KC1p+GD9SJC1l4FHs91vVfihLWkWKY0NQqEX+hAgD9ZJ/cOyNmVrMUIkoFGT9R/zYzPrnQRLEXZf3O1jPTmUkIukrg/YH4Fe2zRSvNAZocKPvQXtsg9+0OIUPvYA4YnOCpU3efz/aL/25p7/WmVYH+MfMYH1gKqkJG0SUbmWNbwnlUzyhnRviZiC13Z7Lem6y3jFDWtSu/vV4jOe1VZNN4ORFZ9gbKrtR0+S4DfADqpC0IpFpqkiMgFzhr0rDUfYO9TzEl5SZG3OU0ztylT5fQWehjpRb10VQwUGSmO+euxohZJeNVhuvE8RdPVZJCL2FqFA+d3aVL6zhHOHokRuNXG0lI9kQf2uh6eYKYLEDJAdENDaCLRi5eMuzXFXJtf/ilLCtNir+1XaU9T9oKBPV5Z39omAjvFicNUT+3XIUd74=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOfE/uncASRFw7YgcQ8uO+Cd13mWa2hw+eclO+Wq5RnUhOlGD0xouZWHo5lO?=
 =?us-ascii?Q?YhKKHwLo0tygDEkbpYXd8o5RBNazFmmFuRlpGzrLVSZoWOKcI0/m4zY8kXqk?=
 =?us-ascii?Q?ec/jNhVEauiTnO+jjB6lX5Gnu54OaUqnhQzfI6TGPAVe/1v5qi55iZKU8X37?=
 =?us-ascii?Q?1LH3kcE3NypN5ZXn3o7L/wPJd4ds7HtyDH9XPn3N18+2IWLmw83RsCFALrgd?=
 =?us-ascii?Q?moIoapZYPXeXOfy2/yjEU5s0+/ayMNaG6ydDB5MeDV6igf4kbT3961tEVvT9?=
 =?us-ascii?Q?ujr5nlTU+dA2q0aYa8792R9u1t2vJdwiaVnzIPgVICmtf3uIaK2O6HFDoGwK?=
 =?us-ascii?Q?v0za9RBWn9wz43MOv2FckI0J9nbaXDH2Uw79F1TmwbMyCGon1/qFuhZAN7F4?=
 =?us-ascii?Q?G13WPYYu4KLJBLqLznIejvK4g2k4av9cXC5Ti3TIUi6ODRucBcaVJVsU5ugc?=
 =?us-ascii?Q?xqdTW2ZXa+fyNaPhNz+to6Pc68zX9KZHluTHz/K6K7W0/XhX5ILRW7qM8L1b?=
 =?us-ascii?Q?yDvfMZRfayKYXQwiirJtUu+8+atwVknSwhk5rQiGgcWDUsC6ibZ2Yjp4qHQZ?=
 =?us-ascii?Q?eD+uIF8UoCf4qQCHL2R7ZZ3OezzkSJVHWv5X6WJbciWB1/LT0GMN+etbSmCz?=
 =?us-ascii?Q?cf3Y+aKF8d4pGOf7jwBNBJexMFzRGQYrUdr6CZjfesjenEK5kDM2D0luFmNX?=
 =?us-ascii?Q?9rakcK4G0YCawV87afdRdonqAoZr6RbLmMQK+edfRph67M/yvdkP7TeEz8Ei?=
 =?us-ascii?Q?vGdIDY8ib4iRzx4Cnc3iRlcswxhlN/eUz3sUgssVloc6iy3J3sOdeE0kQg/U?=
 =?us-ascii?Q?pZP/R5h9UteSz4GRL0bO5QH9G5LgT9MnWpiuoY6KkMPsqs6Z+zEM/mOF/gOP?=
 =?us-ascii?Q?u9yr0CNDYQW3qLtgsf2SJKF66fR46YyH7Z3yoS4yq784Hz4d52ijf5zjs9uR?=
 =?us-ascii?Q?V103kfGeAdwADXjTBK0n73SYNHXcFplxabNHzQ/mU1NbXXKw3Sx5yKeqO21E?=
 =?us-ascii?Q?bDVV2upVz+CjMU1T2BsWre9l/EF4NdwPF385o8Ke3V63RxtwUjDB1Xq08TRy?=
 =?us-ascii?Q?7bSM928MQ7vpnrOp8dVJst9hTcqNzEUFwvi8KIu7TkvLUMbrDyQYv2ttA+Zz?=
 =?us-ascii?Q?tpQtY4YgMtixx1HScDOUA/2xzbE4HFKHajpgZB8gvUMdZCZNnSKDSHdTXYAw?=
 =?us-ascii?Q?m4ddh3hHN4ZsVj1mNFn3zZPellnyj5IB5MYJ5MyK7P0S1mIOX5iwSn30VdWI?=
 =?us-ascii?Q?nXrDXoPyyVsOPOP1LVFcWJLf8vrohKIkIT/HLC6DvFMs8FfulAAk94Wm3lne?=
 =?us-ascii?Q?0cnpWYkCiXNQfAuTsDpBb2Qya2FiJnY4GR/NXuaBJ9RpX7CBXlu7flSA25nb?=
 =?us-ascii?Q?ifIiPUVswnhM0Zgakm37T4dhDPZGQ4/1QKBoIX6Wh2fg7CFo2dAbVX7PvXki?=
 =?us-ascii?Q?rWxuvTL9eLnemvAPJrAcj9QjWPU7f7Jmw1CaNVo6/qvddvEyNWK1jZO4ml0W?=
 =?us-ascii?Q?/gXoM6WlfMY1rKn+3er0AIvZBuQ2WEcMoTBDpQB7VrpyqQz8Jugpv3SgxWqk?=
 =?us-ascii?Q?Bo33vmztMNW34GQ5fzjfv0uwwUgd40w5BOVJAy92mqg8ZclCSrKoyndT55b8?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4010a1-4cd1-464d-9a46-08dd6547f85f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:36:34.2413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O022tzBDgGrGF034k979o2vc87DJO/M7V8YFhD63vkqm9aUlHTRojx7O64KgVECpQ21J77Ga8RNG5XWgeZw4x5PTQJPUtQ+z1N7xXh7Cm6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0605
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

Add USB related file to Starfive visionfive2 MAINTAINERS.
The N: pattern can override this.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index 898e284ce2c..f1d2deb9f5c 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -3,5 +3,6 @@ M:	Minda Chen <minda.chen@starfivetech.com>
 M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
 F:	drivers/ram/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
 N:	jh7110
 N:	visionfive2
-- 
2.17.1

