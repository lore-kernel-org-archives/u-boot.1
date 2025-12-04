Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E25D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB10E83F39;
	Thu,  4 Dec 2025 05:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Du+kTqhw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3116183B24; Thu,  4 Dec 2025 05:14:55 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E8C83F2F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohgH6hkQSvn2txFt+xrcdYv8We93KdmkI4WRdhl+95BCQcAl6E+VXM5P1uo1Y4KOFXGm3IWm/HLLO39garG1JcsPiplCUdblu4SAS04tLUFHP6SD8xAiK9YRb1MS0qEkaM2IsdC6sq+3LuIqHU5vgrku+LOKtOQXzueeitd+zm05QdtI80SAjdrLuu+641iclyyh+AYbxVsYFRpLF3/vYiHsGA8Eu5eT7sZkVz2x4ISS2i3/Smt1fYs1yFkkTF3FCSB0t40NJFPKFwenMtKHfvVeoat1Lf0PX7ujH7e50A+j9Ljx+vuvhCyNzP5TJp0PdLrEXjtgGb2AA6ZWZqUtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP0k6WowTuJhb5tNllSwegm2NL7rF7fx5QdENGDcjgE=;
 b=NBie+Y04OUVVtqFHsV/xDkcw8CiTUNQdP1HULjlXXua/GZiSDPVZTsx7qCcgmYWdnbs8KiMkcIH9orRvccHCFHkmy4NKzdUlksx55MILZBJhDNuVVi89G0fJbLnvAC1/TCeuQ6rCoFWH5sXQkNs8I7Us7yO600iDws+1rdP4wkDFux9catZWTYMjcjkSKIHXHKNl5hDKXnZmt80xcoHkXWxf9sVHA6NYcOo2rOvFanLwUwHAmHUz1PkkBq+TOEwuDQ91ULVuRqDf+umX4Ol2mFhSRdQkSG4t1197XE6+UXq345tOQg+moi34uNYBjy/s/C0PFLVzg0cR0EUjqqmd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP0k6WowTuJhb5tNllSwegm2NL7rF7fx5QdENGDcjgE=;
 b=Du+kTqhw/uZ/2HMrMRuaSQ6KGS55T72U+bOLy7vUfXfMeBR8dYUg+UX4U8WPwXBaU1+MCOtPlJjvQX81GLDygBl5SiXmKQIqFTmHFWPhKpXI4XaKvSgjmqn+pdp5TvBXTxy6sooUzNy27Fj13vxg8TNZlfGuL7YLX/8BwZRNxR7z9rCeS7Cy5ZQFQzWJ3mlRzzI6fn0vl1pcetGpIYBtuOdU6bCMydZN+WEE8bukYHo7IjCOnLJTag70WtaL+efTmlM1NQyligES+e0aPXnRunvqSusQrBGeycqk18qkvMCIuQu/moc0TAkVhntJTzrFw+IbCOFKHM/QWy8Kfrew/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10009.eurprd08.prod.outlook.com (2603:10a6:20b:64b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 04:14:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:14:51 +0000
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
Subject: [PATCH 06/19] net: airoha: init switch before GDM port initialization
Date: Thu,  4 Dec 2025 07:14:20 +0300
Message-ID: <20251204041433.3459826-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10009:EE_
X-MS-Office365-Filtering-Correlation-Id: 471481a9-dc79-4122-61f8-08de32ebabe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEmmNxOsRh4ONT1i16CyUgJjgBY2Oh286Q208S5+D9GMH3ixpGFfszpJBzoY?=
 =?us-ascii?Q?EUysAECplHpW9WeZugthVBTu+La6iNvQZe9brRTsydyMTghtm3qb6nlL51u/?=
 =?us-ascii?Q?lYRJXqvzjBKxvwIQ0fddfMKmZ3s8locw1hjVrKH+9ANsgDilxhh0gU7B5ztH?=
 =?us-ascii?Q?z3fe8f4C1RdFZPgYgAZPqsMrm00CGImpRmw+m+BBBX2qzRcBMuUuCub9iHMc?=
 =?us-ascii?Q?3nq4OQZ+/+gsMjAe+497wE9KFLCAFwsVETsYYtj/N+V35XvJS72e8IWFve56?=
 =?us-ascii?Q?NWPzXmJE2NvrWW7kFdVtjoRXh8nJn2AkNjeRFMewAfI/8UyEwG35No41EoAU?=
 =?us-ascii?Q?M0r/ev+MU5BTKQ8wWOe9RjY2yZGDz30OFMvwFuQsogLuXRcVlw4GqfeaVmDY?=
 =?us-ascii?Q?wokyAuTqGDePoypLcggcdb4Gf279uYrWXXeW3BEW0QTKDdsQMzneR7CV6avb?=
 =?us-ascii?Q?TNV27McyKoq8I2PQeI8pPcpWy2n6Qjb4/e2KERGpqeKzAvLo8kYwH8LvQmu4?=
 =?us-ascii?Q?DlbIrbqPRUx40oV9BLVXlh3cKc77J3TUMC8nhOWhLFru3C70ItmxxE5480K3?=
 =?us-ascii?Q?DeH9qw5ofSPoFlBMwbnDLqFGIm3IDYx1QEBOYQtg8tqYXZStvNHqN+YOaJKb?=
 =?us-ascii?Q?fAqtebbo0trLDlRH/QEd2v9dmy+f80fZACdLrJp2u6UkTaUJFsI+ooOoRc7D?=
 =?us-ascii?Q?+NarIz4gLo/ZVwM8PkkKEtfREM/T9i9q0fmcLWWfgA7W0Kt/Q4XUSSVPJwV6?=
 =?us-ascii?Q?E2UQjErOBP7FrLygyW2I7lW4JiP/pg2dnM1Hjnqm3913u4PDFLeeKPPAw8u9?=
 =?us-ascii?Q?c1/JlPE6y8aqVbOhkCeY5vXkGQZV/w/QNdASHrueQ24vr70BmJmTvrNwS5iz?=
 =?us-ascii?Q?qsbXMiWEl6blV4XBPtp0DTfLZoPrYvyR31z5Hq7E83BgO/4ephrL8ovLc6fL?=
 =?us-ascii?Q?UJ3J3PLQCwnr1J4K8kRl8SAdBlYfbivFXB2fYRjNTJaMAVmbj4OmYQJal/PA?=
 =?us-ascii?Q?CQju0w8gKyAjyG2e4UsWB7sl5nste48xbBBXTBU0V20WNRBYW3GNhYl8Ym5N?=
 =?us-ascii?Q?94yH6go6DvegS70BTPKEZ5JyXmwcCatYJtb9aNLInXon5+NZn6eQAlTDPycq?=
 =?us-ascii?Q?OfNH/GCnVE3O16HGB4jZ67pnJyRgYJLEpInGeRqmluumzHNYose4m8EApXkX?=
 =?us-ascii?Q?QIUktYsk5RO/NPQwNukz0JFOK7Y+6JovOahh02k/Ecta+uuaZYBzjHV52d3R?=
 =?us-ascii?Q?XvSruPYLWNjfx69BwRw2Ry7YgyQMoaTPE+RN8k8MILRDIzrKBJsUcycVMwiC?=
 =?us-ascii?Q?Mgmcui+ZsdcRfiIWu+ia+1KLaaa/mdI1kYEmpYvSicGuhg2uc+Ar9vpp2JBt?=
 =?us-ascii?Q?ZyZBsf2drLCp7NGzIpvsEoIAUobBdb7nMP8+scB1hCnSpFVTVFvI2fRPtfQC?=
 =?us-ascii?Q?K4mHuyOYef6JAAN7jXj1trqrqNm4X1x8typ/xNeIyTfLnZvyJb5S1SAqn6jW?=
 =?us-ascii?Q?Q69rbg6PPwt2Nsry3BNdCcz7LhFR5HM1X4ikSaLcT54d75aiEi+GlzEgdg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjm9oRtoOJX/3qy6pASWisMOhA03B2giKKHTQGsIPubCVcp+t8ehX7ZZ+ckd?=
 =?us-ascii?Q?1FuPO6g8EftcnvViDdCkIm+A+AXULupVeahlfO7pLmmCgK9rNq5JGu8ckH3t?=
 =?us-ascii?Q?GSUn7Ywn8WI/Eh/p2yyC48vQh78zyZDtjQ2uPjuPAvr0HMqWeL89HanwrWO9?=
 =?us-ascii?Q?fkQmVmoJO2I2vRIsbgsKXWk/yfr3DAQOu/l4PXXjGlrTdWIx6LgDACYJDOR1?=
 =?us-ascii?Q?zVnu9iMqpPuPoavMkdrYhrQxVq71yv+JE2ZNd7G4HIb+g/2fOe30i8BEEw71?=
 =?us-ascii?Q?4A5uj3JVAnvT5+CVW7y6TkE4dWZ9nLJvaYEyubmY7lZDADflRqFwaWDDMAEd?=
 =?us-ascii?Q?vRnw1GB0x/GeeiLmqZGFZT5G76Ql9/B3dQvOcVQg6XT5bYBirfYlHncWVEmI?=
 =?us-ascii?Q?V1hxSaSxz6PBZQSGuXSfvQ8loMDZ7MjU7O00OcF/77qIvMK/tsEXROkmrfEC?=
 =?us-ascii?Q?oCBqmPerdSwqXOF+FD6PMJ0eKT9tHWMEqhRei7yoFMeOP6AW6QOmCNnu7BvK?=
 =?us-ascii?Q?Bt2jWCSlEY91ke0R6/RGQsGok2kXFWMmuVK/z0h5S4ZgcLbQauekEAC6y0c2?=
 =?us-ascii?Q?mWXY55ih6K3bXvDK9e3XPLuCW7vkLprpGR+MEf0Aro8FikhdFgtfGm3iz2Cw?=
 =?us-ascii?Q?KghRV7t6aVzqIkwBTT0EYUNNQ+kwFk/P/YamT8ftVNRAj7RZjKXNii/sYHbG?=
 =?us-ascii?Q?egh5HWXq0DwlWIzRPaiTDnMoAz4HjcoMNtsNAPCs89HVC10vuNwn4XFKldBV?=
 =?us-ascii?Q?Yzkbfsu7WpIFXrj/0vYm4Cvk7nQlAZObP3LkpsGwbzOpvhKDyxZauK9+SFl+?=
 =?us-ascii?Q?O0lFbVYBRuVbqbM3hQgLHjug3/KKNrenJFFEe7U/6eP3qUeZltIcWP5Uj+g7?=
 =?us-ascii?Q?JQ7zMKUoNpllDXsFrwwfWO/5M/K1+BaYS+l4ahJTkLRN78q9Yl82rt+kQd+B?=
 =?us-ascii?Q?Mwi3mHyZI9LkWCANDGsfinmkGfzgOuj4Z0eE24cFd0u+jc+gfusV32ZuqdIQ?=
 =?us-ascii?Q?kaDPTo6HdefnaYvmDH5UxMJlKv+cG1snsuCGTe2wiTpTNTyn0zIpI1Kx2WmN?=
 =?us-ascii?Q?I2NzHSYYKJlvt955LUpBV1QdmqLq+Fhzv2Ea3lyhgDQEeEUVyr788fqgxANq?=
 =?us-ascii?Q?ss5mPA5YkUSuouA+t4VkkRR7Fq6K917s7jRbvPPCWr/YH5Cp3uuDWXdCIEci?=
 =?us-ascii?Q?XlSzI/LIg54vtkaoJbTZOv3M5FycWuYWgLptnTvXe/H8kXQEHUAROxqJTx8H?=
 =?us-ascii?Q?brWaf3mag9EXILN4rwdnC9Gl14hrRsiMGqUaq2y7mqTErowEd594Y0gua94n?=
 =?us-ascii?Q?INlg60O6sRKsuMshO7oGETZTtBL6K3Ppial92nfGg+9A2n4+zcMO6SlcRUJz?=
 =?us-ascii?Q?jVY1Uo5et40xv4Ms8j8CCttu/2NFtuKK62poFBbvR5KtUEKsnW6RQF5Wy+mV?=
 =?us-ascii?Q?sOBqwksA8zvk4TYKbFFquJgYxS4wsCFTxWqmZf3+ytRhNt26voO1qRtqViSU?=
 =?us-ascii?Q?oP7gFFcnxQ2NLLzGF6gtfPD0LadzyC9+yxv60+6WM+EANse+JkVFjiaFqxWt?=
 =?us-ascii?Q?4yIFhenG+jg8gY3FF61xQUrP8xkEM//mom8ph/zn8ygIZZclg2BORlEaxkdN?=
 =?us-ascii?Q?oJUaQw9v65kiWSQ16DyesoM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 471481a9-dc79-4122-61f8-08de32ebabe5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:14:51.7408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fapQheo42JdC7SPneo9vZiEWP4Sz3tnO2v/T0vprNcsAgTipKclP0AfWi5db8zVZ0QqvICVFlfJDA5RKKurmPqKQ9t0pRp6OHnHupyCm1Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10009
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

Call airoha_switch_init() before creating GDM instances, so if
allocation of GDM port fails, early created GDM instances will work
normally.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index b1256866046..7f984f56dc8 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -861,6 +861,10 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = airoha_switch_init(dev, eth);
+	if (ret)
+		return ret;
+
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
 			continue;
@@ -873,7 +877,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			return ret;
 	}
 
-	return airoha_switch_init(dev, eth);
+	return 0;
 }
 
 static int airoha_eth_port_of_to_plat(struct udevice *dev)
-- 
2.51.0

