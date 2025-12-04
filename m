Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EEDD1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C01A8404D;
	Thu,  4 Dec 2025 05:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="M2BSUeyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8692B83FE6; Thu,  4 Dec 2025 05:15:11 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796C783FE6
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLUVIleCpkZK20TLtjiEcM4/Vf8SqixJeZStkcjeFonsVAjh61jRqUSn3GCqwHXP5LCM+pbLk9JYyEZF8VjY0XR+X4wwbLI3afaDBt+k8sexVozoYG2rHVVV2xZK/0L4scl/G7L4G4R4cc5YnfxXXZiVdg8uOGXptZqv/2kP4xlIaur8cUD4X7ICOaBdwqg8DeG/8C/U5IuhQoH5Mfvi8rjAQ4EJjc5a+BK34BDwWIWuYg284/Ud4ONeXyZaeCWWF0b9eqotf9LQB/VDw6jNWgMujxVMg/SnRmd9m70rHX2Tfmd/4YTu3f3NV5tpES1jjqGU+stlhdJMHwNpFlkodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iv7MgZ5oe8DX1rJh6M3fGaUoUIpCjeZpNFWB3JT0WpI=;
 b=j1zrtlLLvtJJk5zjBMkjLMKIFl8WA94M1aKmY1iV6ifQ2luEsQXThnWxpH82JFwaGmrBCEwvTHN7i2Ge6V/H2lZ0JNwtGJ0ZEWciHHWUdhY6ddZjc89w6Npznx1VnTqabAVviEWoRci+0DinCgsRNfZq+qltYNMO3v9NV/jmrtEF4eWGodC2Eng6GTdkfJeus0tfll78Uy+ewDeybyDLCtSopEgXr7sFGZLaCCksjSoemFRcwOnZupGlUs3seH+MM0BC+CkUzHVoyzYdD74Hc9D/rSXzc14G++Yr9AryHkr2Nc/lWj4q7TMia/vrYwcyXS5tqWqabojMnWL4m0pBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iv7MgZ5oe8DX1rJh6M3fGaUoUIpCjeZpNFWB3JT0WpI=;
 b=M2BSUeykbGAviT1AE4vhHcJHfIVCO+gWagH8pL1MvCf1NWePnOxTKAhdVWz7WIQxzzdIKyz/6KsI5GhlVdYCr2uWFYFKARi6OBMjBscWfML0GlgfuCJ5xCmY/Sq9yn16CGc20oumG++iUUlOvguUM0S8zb0L3IxD0xJT/ugwR0H/FybqTRs4BxxL4swcaVVmY47FWdPctxyadsGqQCx8NUvWEcrPuHUT8H3s1p9OsvzpiooxCXxP/zXsId6l6OB/uqjyTCxd7uBYMULZcBJSCqHJxeI9lFwZ10L+bB+2iZdckhKWobJbaLEhPKqFDUOt/5chbKcOqx3L63XrbjvXBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 17/19] net: airoha: use mt7531 mdio for GDM1
Date: Thu,  4 Dec 2025 07:14:31 +0300
Message-ID: <20251204041433.3459826-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: 87af578c-0e67-42a9-63e1-08de32ebb565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3wNjsNyHR6Iu8ShOff4GYxY+VGXdRB2kvo21q7ZYtwqHJGH5ZeTujHuUGln?=
 =?us-ascii?Q?z0e01RnDApDqRJ6znjNt/EpEhAD+BtjblcHeW4bZ5P7drjICULC0rmM2hr2Q?=
 =?us-ascii?Q?nR9K1fdbW7tVAmnlnvaBCXRWyVMQ1+UWLWf570s+wlHYvcuyM2Sfv16KCqxu?=
 =?us-ascii?Q?rWYFSKOMizbw1XoaVK2wI4dT9mHR4Ikks53oQxfjGIpGYgjMJ/+G9q0PEu2J?=
 =?us-ascii?Q?dbW50QUiigi/ECA2OPL6AcO+irloDWgnUDWb3oMpgNgw6X/ZjHiz27b7UENA?=
 =?us-ascii?Q?exAQpI/ZhOU1lW6gKdB+wOdvEpiAMStPuM5+CDAIpeZoOUdkBTQQpUY0u3Ei?=
 =?us-ascii?Q?zyUgRxbVUDCVTnsr1E5+59/ooYjS/6+QTIF+W3Jpb0U5MO1JQTb6qq8DMjpu?=
 =?us-ascii?Q?gH3V5RR9VZc3qZY190maulNh0iLQORLRMrWvP9BLvvYEyhliqNLRWV9qqEmN?=
 =?us-ascii?Q?NBJbVaT8tcMSSTvhjgfZ3z6DT087oCgLpDG5FkQbyo6w77YnJTZBQ5JGbW2O?=
 =?us-ascii?Q?QSl204z5jSL3v2L4ntvHCahZ9VI+FzUk2yvjkErluuwHQ0pxnRAyRx/AUEMr?=
 =?us-ascii?Q?HHF9Dc050lzyPuYyz9I9KBlSH/vp0Kw800VX/C1MF5+h14Iv5FbuRp9eJoaG?=
 =?us-ascii?Q?sAJu/OZ0DFBExxWtynQHF7z/LuJLkyF4BmTJjYseO7Cj/ODJ0NpKhxph1pTy?=
 =?us-ascii?Q?9kTKoOvkx9s6/sSFt4Iuwez0IPWgh1nMBX5nw/valffnOcFRgZGrw+x+pS37?=
 =?us-ascii?Q?SwsFozjYzn4tXhnrVv8mVmJd+sI9LoLR2qZ7gNWy5HX3uwE5Rf70AtYa+zL/?=
 =?us-ascii?Q?G523d+c90qbi9HygNiuwQF1CzPKAAegIp/PCghjYZ5XX4vKR9CxuOw2f/ceT?=
 =?us-ascii?Q?Ntg26TqZGWxBYSjnNerVk7a4RfIGCnDJMofjs5V5VaDAAozs5BDp7OElxfQ4?=
 =?us-ascii?Q?Qazgo6E+EX86fHsze3/3loS5HR4cxpDBDhQa3Si92dZGVly+UyRsVzYUIr+1?=
 =?us-ascii?Q?dRe8AyiXa37I5thrclbN909cvXAwrj1Iwv19ehnPqaVLruN1giypVmFYDjFk?=
 =?us-ascii?Q?964nVAiQFH/yn+N7uFa0o+41JoSgWsde8ZEmf0sDORpRwfWzQSN042ymfj09?=
 =?us-ascii?Q?q7G/iof0FMIShVXfuJ8/yiF5qE9kdCwG2PBogKsh9f3meDSa6q0IwJxTFlgf?=
 =?us-ascii?Q?g1A9Rybtb+G188+4rNPmxJGU4PT9MlwwvJnU4zBy3ENledcBoLyNI0yuFgPL?=
 =?us-ascii?Q?N6HO9GYiXXkaZsfygZXFfYtpbH340/KUjNil1LkYPHxt0PuDAkEu2U6znSqc?=
 =?us-ascii?Q?PYntBC4hYz4RsyFMWn1Pe+wva2cIcV7I1UbOI9ShSXMV7V12gvcrt45r4xL9?=
 =?us-ascii?Q?Z3FusbruPj6AgRrm0IyCndlxEx118jr5L5GqNaBGzNsqkZpetGAK5KNKusaw?=
 =?us-ascii?Q?L+wO/mXdG2r150S8isrDV8rY6tJDnTX68MBAP6BVmJUSrhOEkf4d5CwuFzB+?=
 =?us-ascii?Q?8OjSayX+Oy3e419oAaPi0KhGnv4sv1xvcWaAY6KlPZLAmSTKX0xoxOB5nQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BkL6ynkGbyUUC2ZPF9+12yATFT6GJqZ7xo/LeZbF/CefBDTAfl3kbjgtrRrV?=
 =?us-ascii?Q?xAxr5bogKYk8XrE3EDmMxcP9zX62hyc65DE7vVSWXCylZiV7jryamL+vYB66?=
 =?us-ascii?Q?ui9WkKwfmUG64jdhqmnzmf03fZFRnEAeEqGfWMi8AhRxy4t+pTVv/nK72g8O?=
 =?us-ascii?Q?QxtcZr6nE2Yd+7kg5WjGNgmiypwaFovp9/dAItyNIcsmYFMrJbVfGgjvjudQ?=
 =?us-ascii?Q?uHq48C419rnHvwvs0rmfwi51QFnEt0F/AbdTFa0v5HCc3LM3HFhAX6Kj8/fr?=
 =?us-ascii?Q?qYlMPwU7YETHo1Qefl7ypS6dRL5hQ2bOvOrC3WMmLHGpdFc+MD8O0YMg0xqm?=
 =?us-ascii?Q?FUjqBQggIn8aIWtSKV6gfUROVidvgTBcVbyOou452d+8YWZCf15OpdPoIAjp?=
 =?us-ascii?Q?rxnbpZ/McImS4DcuDrlQ02eAG/fYnhZzSLp80YExNYKlT/c93K38YBK2BKUB?=
 =?us-ascii?Q?MgJLI0e4UV3d3/Rvs0S6RsQicEoVeLJK2MmeuDojwcHbprSU/fPq5H6jBepe?=
 =?us-ascii?Q?xvGpN7/5tulDx09XSkMBt+ECSX45L/7XJuRScCBl1hGHElJ+1CHnovz1i07g?=
 =?us-ascii?Q?ZK59Iby8A7g2MADJkaZLt2+qe3h706woyJwCH3uD86f9mdm/lXwzn+w3VN2n?=
 =?us-ascii?Q?/0jM70BWJy3BJXP4B918k1YYa6DLSwtk25GeD9d2KN71CKc3M/fOto5grzO7?=
 =?us-ascii?Q?/1QXuEPf/W5JxVyZWEPVVEs1o+KNt5/6FtcbPoJZvZWCvfOWDelE+vjTZhCk?=
 =?us-ascii?Q?oJK2aZfrpRQwzW8u/3XYEQMV7BS9dIga/9upKA43B/vgXB3Fkni80822EGFN?=
 =?us-ascii?Q?bNTy5th5BsBnJq7fQFfc4OrwA6O/vSAI+HVHlK65mU1Vrc9rXhthVqUISs7M?=
 =?us-ascii?Q?tlYpCFmitEthMhdEw0wTz2GH9nDFp0tglj1itedQ5HGnZCFxJN00lANEK8JI?=
 =?us-ascii?Q?D78lDijRVOd6UzNkFuIkzF+1qKZW4chWaflQlMfp0I2EqB8uT5fGvt3Pef90?=
 =?us-ascii?Q?c6QyjsuP4O0aiYdDmous6Hc1CswGwyzJyvBr2UK8pOGiQdZzDIn/Lk+Cdt96?=
 =?us-ascii?Q?vG2r3Yk28w8R5KFYT8B8io9POa/ICgPoosTWW8TQs+yodTsPf6uZVAA7fmRG?=
 =?us-ascii?Q?q9y47f8YlUMLDnSd7jf5cbXPmhBOZSh7l3SC7yeyQ0t0f8lB38us8qLTQrvi?=
 =?us-ascii?Q?rQaLK2BRRdaswsTIdAjYW99jc1vH9aupsaP1UnFyv+WhunSdvQXij3hf8qMb?=
 =?us-ascii?Q?zXmjvgW2ffcYF0BSnJOApehTLNeGsPiFErHvl+C9cy+G1pN6X6uNDd1/PyMY?=
 =?us-ascii?Q?4taxwGneDvuaeDpiAv6LHryeYXP36xBVhvQNrKNNUO5adUmgZiwi6wGkAvAT?=
 =?us-ascii?Q?t24D8yl+gLVyVdysukcn9RKVerGUJRyXcsGMrseutL8kNOkAiL/ap+Q9twd+?=
 =?us-ascii?Q?08ScRq/cc/WDv5ST3coMNxVfXDwbBNqxPc57evYHopAK+83+XqXGQo1wwTLE?=
 =?us-ascii?Q?HJoxbYT1mTwvSP9gdK+AN6TiYBwwKJK85X+bvzU56hX7W6EgunsWRfD74bRK?=
 =?us-ascii?Q?LF/GAUYsBxMyQ6qS0KWsCX3vLDanEV7lMLatb10W1F+fVl1TGmmwohOhu2VZ?=
 =?us-ascii?Q?eBF3tlQ+KG2EcR/Qy1EF8h0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af578c-0e67-42a9-63e1-08de32ebb565
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:07.6929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t29mnQntWj3qFtPrDgHr/tA5of9W84LYJ+GedQPRi+b4NVjZ6uCeZAUrEE35nDaEOBocmMTXUCo29hIbN+XrGIdZgvGnZPs7WsLGzOCTP8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

Current code just bind mt7531 mdio with it's driver, so mdio device may
not be probed and hense not usable.

This patch
 * use mt7531 mdio for GDM1 port
 * set mdio bus for the GDM port (if corresponding mdio/phydev is available)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 63f57d299ed..d31e44b652d 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -12,6 +12,7 @@
 #include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
+#include <eth_phy.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -334,6 +335,7 @@ struct airoha_gdm_port {
 struct airoha_eth {
 	void __iomem *fe_regs;
 	void __iomem *switch_regs;
+	struct udevice *switch_mdio_dev;
 
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
@@ -941,6 +943,8 @@ static int airoha_eth_port_probe(struct udevice *dev)
 {
 	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
 	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct mdio_perdev_priv *pdata;
+	struct mii_dev *mdio_bus;
 	int ret;
 
 	port->qdma = &eth->qdma[0];
@@ -949,6 +953,7 @@ static int airoha_eth_port_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	mdio_bus = NULL;
 	if (port->id > 1) {
 #if defined(CONFIG_PCS_AIROHA)
 		ret = airoha_pcs_init(dev);
@@ -956,11 +961,24 @@ static int airoha_eth_port_probe(struct udevice *dev)
 			return ret;
 
 		port->phydev = dm_eth_phy_connect(dev);
+		if (port->phydev)
+			mdio_bus = port->phydev->bus;
 #else
 		return -EINVAL;
 #endif
+	} else {
+		if (eth->switch_mdio_dev &&
+		    !device_probe(eth->switch_mdio_dev)) {
+			pdata = dev_get_uclass_priv(eth->switch_mdio_dev);
+			mdio_bus = pdata->mii_bus;
+		}
 	}
 
+#ifdef CONFIG_DM_ETH_PHY
+	if (!IS_ERR_OR_NULL(mdio_bus))
+		eth_phy_set_mdio_bus(dev, mdio_bus);
+#endif
+
 	return 0;
 }
 
@@ -1205,8 +1223,10 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 static int airoha_eth_bind(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	struct airoha_eth *eth = dev_get_priv(dev);
 	ofnode switch_node, mdio_node;
-	struct udevice *mdio_dev;
+	const char *name;
+	char *mdio_name;
 	int ret;
 
 	/*
@@ -1231,10 +1251,22 @@ static int airoha_eth_bind(struct udevice *dev)
 		return 0;
 	}
 
-	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
-					 mdio_node, &mdio_dev);
-	if (ret)
+	name = strchr(data->switch_compatible, ',');
+	name = name ? name + 1 : data->switch_compatible;
+	mdio_name = malloc(strlen(name) + strlen("-mdio") + 1);
+	if (!mdio_name) {
+		debug("Warning: no memory for mdio bus name\n");
+		return 0;
+	}
+
+	sprintf(mdio_name, "%s-mdio", name);
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", mdio_name,
+					 mdio_node, &eth->switch_mdio_dev);
+	if (ret) {
 		debug("Warning: failed to bind mdio controller\n");
+		free(mdio_name);
+		return 0;
+	}
 
 	return 0;
 }
-- 
2.51.0

