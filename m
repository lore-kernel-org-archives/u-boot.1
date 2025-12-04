Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD256D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C775284013;
	Thu,  4 Dec 2025 05:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0WnVJTQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1326D83FEE; Thu,  4 Dec 2025 05:15:07 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A61383F9D
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd9eyg5qC5Vj29ruFHYLrxuvbHbZDWkrqW0vvtXjoUm33YPr3F/I0/l2GayvIxFvLqK9m5LTIizZ/oc5DCoXKI/il9xDh5Ac//jHWSZl7KKUftRn78XuHGqUstGVuUQlT4eljlLLUh+NPgWU4w+KX/8Tq6CK4J4+e7ToobRP9HS5FhvnScmlkwaKlC4k2z3t5K2XxOONH4sMbz09jC9mmAq69POfCf852W7ZGdPz9hKnFOV+953ycELhEz0kTLJewa61GYvBDfqKCdl0zxMI7OS3REdbdjkRTkstuv2YEp6EHsPVHO6NQ292hvKWxBdQ1jmZOo2S1hVwRHjGr291/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iizGJLWNPeqja1yB0DdpnrzXd2nq3LUSYnXzMoG0/s=;
 b=w6WmP7lboh0wiDyUawrI0oXYkpoHkmkTJfnJEhXtyYDe3I+P3f/y2e1MLw1+iM3SCmg0trtqyk9LZG6R2bWsIOgWMmrM53x4v1RinuZI5flgzTPLjnv6zzzzvVgfvhTNQ/Ks86A1tStqfzOEzKQHgxP3AVhpmGi1/JShEYEuO43Lg3AEZp2ZzBp0qMULO2bt6nLzkTjlRjcZZVE8tncEiWUK70Nn6zszMqgeUZ+vRTbWzFqsiM4X9xfnluQlwxHcNVWoR5d8BsEanMNph16KcKjsG8/izY67MPJYJBB0bHAavKJubKVj2j9xmHavIhi0imTpLQ8sEO2NJY82Nx8Lpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iizGJLWNPeqja1yB0DdpnrzXd2nq3LUSYnXzMoG0/s=;
 b=0WnVJTQt37/BZdiSh5lY0/RvsGLvrjSq/ATFhYeLhI9hSyqWjyZ/0e+Vf8nJyn2nHkgal9g67RUKX9B4ulDV9yo3gyesHPiwd/lq47/B6X2n0L6wXB9PpjUC27wwaNoQjvix3zfo9JuY0tVtIQ6t3/3DDEzS2MCA0fecHlxfDEyfMjAPhOw5iPE+5alJsk6OiyYZO3GxtgpHJCkN3H3t9Uh5rvF7VgsSpRv1yYNyTRexTyUKD4vDfW5Uo3FCsXw8Polaj/wK+KTG9LAGMoF27i2avcjhJeWj3kJkX2UW2KgXx6CmwRV9jA6WEl7DeqyYLWBkUD3BNbnCVFbmTTBujQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:02 +0000
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
Subject: [PATCH 13/19] configs: enable PCS for Airoha AN7581
Date: Thu,  4 Dec 2025 07:14:27 +0300
Message-ID: <20251204041433.3459826-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 62f082f3-fb26-45c5-380e-08de32ebb1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R8+hc7O0BhPJLexpO9cwLMUW9sABGmYG00iggCTjQdBpXaGyU1JFIP8eC8Go?=
 =?us-ascii?Q?w/SgCAQ+Uqo6j45Mwh7updaJCuaScsTuL1/Y6LvdCOBINNfcLCWjNsxlNov0?=
 =?us-ascii?Q?rVHoyG/GTqLEItp11MlszrfGEsap/Ucp1QKzRQymDQZUBFjFLftYvBWm3OUC?=
 =?us-ascii?Q?9WLk2dn3pnRHKTFzlpQbCNMRRHv4+Bh5ylL2PZRNZ3Li0M3kCY2agkj/xgGy?=
 =?us-ascii?Q?EPf5t4pjg2gP5kQBgZH4z0bXeMJr4HV6FR53IXRH+zbKZksNc8nnzoqYdGer?=
 =?us-ascii?Q?ixqkUQeNotTqAfpg6G4RcmKAEQBTD1zQfgCvLJBsgifhpivfnHjLevQwTvPT?=
 =?us-ascii?Q?+w4oMynI0LLfTBe8CPkNz0Z04m8JAnPlhPvBoLvyx19eRzQp7Yn1XnTpgg17?=
 =?us-ascii?Q?imBCENKQ+vOyP52vgUoGfKhgBEQlzDz0R+07DgNqx+uTtkz34ayO87C6MWsG?=
 =?us-ascii?Q?6+YeiByIr5SzYmlsuBkIPb8Q0QGyYhbFNumRN5Jz1DfwaIHvL0VAMYQY6aOn?=
 =?us-ascii?Q?GcgMRQJ+97rXP8Vzl3kB/0MH9zPex6Lpc5/LmJvXuiXNGCGxwEuAZGZ3MJXK?=
 =?us-ascii?Q?ILTDWJmIzysdlwyZ9grcm/LbyYhsMek0wPd5oIV2I1KDZprgRLSgSGsiO46q?=
 =?us-ascii?Q?RvByPuRYklxVUeQdwzLuHdr4fw8ZCciwg3WpstYaeynxioq3SP92u5O/MNs+?=
 =?us-ascii?Q?CejCgDz2H24GvFRGODDyXez/HZjSui6+7Jipw1cRs/HRytJSqMwd2PKSY6lb?=
 =?us-ascii?Q?093CzAXdE48ZqHTRCXfAXnPmyB2spsTUMXNFI3y0zJc3Ukv6PIrzrZH4zvN1?=
 =?us-ascii?Q?oyusq4+2W67IbBQ2WqIXk+F8T+/GYOxQh3FTiA6G/XHSs8/uoYtSYsnrk96J?=
 =?us-ascii?Q?rSQAbmNHMSpNfMTiB+uwBSRWpYXEQkl+E3DH0PdZ/UFqKhF9wcIk9oKeZDSu?=
 =?us-ascii?Q?TepnL9lLhvepIvvQfCPQwSLFvLYZ47bCVbi/19YMNdOJvugzzzhGpR73eOEX?=
 =?us-ascii?Q?THzFJEREMAxO+iUZ2XqAFgwoOe385N9Ey6XdYJizEbcm3vi0QQbb2fhPrruu?=
 =?us-ascii?Q?bdiJAWH2SS/Tyojh/eg0Um/14cM/67Q/o9OiRlXXGnKNBsRnf9HvSoeMwtgA?=
 =?us-ascii?Q?Glg7sq59j2ARPrVmuXL3MtX5c+0+W1rvNywnf3N5a2BHTXKxIzGlMJ5Sqg/M?=
 =?us-ascii?Q?ppT6UPF56hIeDAPGxRU/cdsIycg7gkAe77+gGTf6yA+iqNgYp4zbKeVb0htH?=
 =?us-ascii?Q?R+Y/i9EqxmpzS28xRjPEuRskyG+8StE6fhRCbxy6TSf5pKgZqEUqfWEHGcTN?=
 =?us-ascii?Q?9fp3n5lZqTdGjkQNTMwME6KuC6Vnxw8B8ZC7dPZDnCS4t+KSrJ08hUXSMmqR?=
 =?us-ascii?Q?VKZYxknl67AgQkQzgBeaJNS+dRgDMPdgOp2JJQB+6p7Wj9hWXzYh6LEneIPy?=
 =?us-ascii?Q?5Xpw6IGRJx3rf6KmeHkljETAlC0geR5CrAMBOcD51ykW6rrzsislx8aCicvH?=
 =?us-ascii?Q?sGhLTJbKw9Hreq2xUFyVD6TaF56+kj0zVqCsKIItjF3xRoc7gZZ36xmayQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhWtwcg7V1DrKE+fGnejL7giDerX/RHVV+BTsEfjQgkKyWqhCiuvcK4/ygMk?=
 =?us-ascii?Q?vCf6RWZ1CuIPBA8q/FlX57GzxSE/Q3zNLB+61ukCvbBm5IDmt9GNgwhJPkZF?=
 =?us-ascii?Q?FFofgtc3t+ZcwFD+nxD/cjaecBVYLGK34S5hRNnB+U5kdQgjQYGbKRzj/OoO?=
 =?us-ascii?Q?XC4kJpC7mFq8AxMp2oXLgYQv6BuA9nxlDH7hsuYfclvILWcwQblxNzP83GL8?=
 =?us-ascii?Q?oxVeiELL4ZF37SExNJdd2ELDmuSv7u1yUvcQbgG0umt+jbnQfiGEQxh55AbZ?=
 =?us-ascii?Q?NyzxvR4Zx1vh+9QL4dR5jeq44KQOLu55piWvpNXb1FVCdNCwMu9VE9Nk9/RO?=
 =?us-ascii?Q?68SEiocVQYX1ClI0T1dQCferBZIXWFAoYXuE9lMBabLhzKN8/6R+V6mEsSoC?=
 =?us-ascii?Q?Xr8cMCcWzogbeDHhjOhtaVMbm1gIUL6Crne6Xcp7mc9moUolHhVaHNSgjm5R?=
 =?us-ascii?Q?urq6SfnWSzEhZeHGkh4QsfcqjGIe3kzyo7TuIPJycHgeaXO4028OHntKvfvC?=
 =?us-ascii?Q?QqIOImr5SBqnzr43P/N6iF72Ik+wwYrOid1P+TdJ1L3d01tMgf/ZuZWWDsTN?=
 =?us-ascii?Q?MX+TSG7tGx0D/AI4xOtJz+0XZMUenQvJchZ7ysoXQcfTd4tZ3YNLzML8wX51?=
 =?us-ascii?Q?vOedpnkb1oPFL7pJgE2XA/ET95RZu62WKRZRyNqwc6OIr4e8WKKOzxfaIcL1?=
 =?us-ascii?Q?TfgO6rxdGwPgr/RFo47IHKUX5eVpnfhDHokQyeYSqx/iMDuV3up8ykUWyAn0?=
 =?us-ascii?Q?Ketp3ue5+C8fE+ejkG8cMa6ejr/0JOCCg5a6VQlIgg2SKIS0jHnQdmol1HlN?=
 =?us-ascii?Q?GTbOJ4EEcLIN98zjQY3V/b3H3P/L2FoU33sp5NG85ofiVegQAMXOTDPOHnvU?=
 =?us-ascii?Q?b4cABAj02IGV62J4/ygeCxqwYWAmeGeENDQ8A+e5U0872Y1Ff6q/nz/n11Kf?=
 =?us-ascii?Q?ZLU4tOcaNcoJRikqmf684/8jtHMrgGnnZd0rrk0cTMBazaKNVI0ksd2S085J?=
 =?us-ascii?Q?Jlhsx5xs7ILsTi/OkKlqTCESouOpY2o5CNFuEMP2bpCFTo2O6XBRZhocQ4RQ?=
 =?us-ascii?Q?KYY0IIAg8/Iw9yigSsnuZ3Q/orHTBENUR7bww+knl2a4moE29f1M40HoOJIc?=
 =?us-ascii?Q?+oIML0C96J6oY5X3oy0lXlGPwZm9IPa4OOTDun/ctdmKdOHOIMr/GLLFF5sw?=
 =?us-ascii?Q?Ihl6O0S88XismDok+wS25p0MiKq5/1mkuN6DE4sNiBd+pHo+19d/nOEtuUHD?=
 =?us-ascii?Q?t9aw+yHRaKOr3CaMaOZYDySlHnlnaMcQokQySzxt5hz5nL/LLmQaqcYdxLWS?=
 =?us-ascii?Q?t3NC/CXBHgsWpo0ZmnwfNPXDOwxyMhruA94bHX7SwAn/0HKpeV0VF8jOaN9f?=
 =?us-ascii?Q?o7GA9KQ5w+ZFIMsbNpDti+bF7bgLbv1jsObDtkvsF4ISyIjLsDUYbSKauEAq?=
 =?us-ascii?Q?x3GrxRVlpULEgG6rVX9TEJsPB1p0aSwGopsmZRHLou0B6RdmbaD5Chggp+m5?=
 =?us-ascii?Q?A2gAq+lp4Vds3t8wPseILBUJ/8lFZwL1sJNysDTHUmvusuVcX2Ai3gAKSoMr?=
 =?us-ascii?Q?f+HzC0QJEyB1l9uAbncRfky9D61qjn7Z4X8KrPVILt6p7khj3M6evPm+h06D?=
 =?us-ascii?Q?vobjDYHmgWfHlm3Ps89T+Sg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f082f3-fb26-45c5-380e-08de32ebb1ff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:02.0631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IevgZUFxmJS25qbvDux8+wwLc40upJQ02s0UfuO4HZ2REvXFXujW2Gn8+PgKBIAfj6zZJa3qppPuj9V6QAVWGcn92q7ko3UilW+MCwaylGU=
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable PCS config for Airoha AN7581 SoC by default to enable
support for External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 73af30cd693..37786ace2b4 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -66,6 +66,8 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_AIROHA_ETH=y
+CONFIG_PCS_AIROHA_AN7581=y
+CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

