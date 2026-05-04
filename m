Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A15FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D235784653;
	Mon,  4 May 2026 15:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hYaw7g1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E7C846AD; Mon,  4 May 2026 15:03:35 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A933D84653
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vs2fWtSpaT2PTPRldqJ8Fv1JTG1TXbhBxoaDAKZ7/nQWo/wjCh1IuyaWCOOWh0KghvS2AfLkTWg1g47Y0P1hnhpqDkGoncsdPfLEKn/bl/ZtPb05ziHYPZd/BO3k7LP5K0sM6iQXP5HAiAzbXR/xyo6iGKGB/iXMGxMmkbzagMHVtGQTUH0NBRLFfXXI4dE1d9Z3JdUnJnnWLEmuSUDtPLvijc/TihK0jkZvoIdozQhXmSmFBipxR46by9OkJEks0PcULfuUT8gktNcbExQ3hTlpmnSkwh3LvrAWZq93ttDF3slxm85sU/4449tEF/fmFy27pxd0mFfqhxrB2bG3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=FYmuSxCtTMviNNwuICcK3sQn+NUnJi6wIydaNGdUvnqRznrMmUohQg2G3uUmFym8+Jry0efyaZcIE71riJB7bcRYWA10f0bkLJHBTiNsbOsQz2SqihS9LDSJ1c3rmiaQAIOR8U/balFFPNnufkSUSvj4XSsCohNLMO/v2Yk1ya609DfgxOJT/qLlJ3tT28BlzhJbmR2KstCMqQLvOgDaGlx/nzhkjScMDUIzaYsSnD1URWzHenFFyM9QeJBsV6dloTGQ+EAB1zFBzlEPyGXm7rXRsa2MXZ+/ufb40A0dANKYLcJ0fQMIQ7dDoESNsKHHCLaxAo+/GHRFe0GyMRTv9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6a+/t+1ZPQb7rSwddvp5elEkCVPW+Vq1ha77zanakA=;
 b=hYaw7g1VmjCfPVZgAFlYCz5LKcMLYLu2HR7DxSW2fQNPehY7uy2Ev9y/5efbx+/5EVAOfyy+wFr2N00k8zWzXHQW11s5mrCQswwkBI3epGRKJ+i5RGcOhr5CRwlKe1oEpV614H3NGuS2ckuvdNItp9RS4ojl8iU2bzFWN0lgDHnyCkoGwhOKySIz7jJVbQA02+pfpd1/ukhPNdRuhgTJpWFC2F3JetE9iR2fMq3Gp1yIvEEBTtEBcR04/LTAItwBDpwv1TMNmiT0IiYyNcv3muaUmkRQ53vRx6zo3ZvLltxUPTZ8Xs9qjDUg6G7XJvvBv9fS3sQv6kAhNDXE67UZCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:03:30 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 13:03:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Crt Mori <cmo@melexis.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, u-boot@lists.denx.de,
 David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 7/9] configs: airoha: an7581: enable pinctrl/gpio support
Date: Mon,  4 May 2026 16:03:04 +0300
Message-ID: <20260504130306.2764862-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260504130306.2764862-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8168466d-1c45-46c0-7781-08dea9dd8a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|7416014|22082099003|56012099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Gtfle1/eoESYCmASFGh3e2UuPFyVvVh6vhsdea7dbGWIPDtA0cHQSVn7YgJKwDeDw77cjQHvtNl98zmmgXxnmOdWsQYJI7lngU25ybkcJ/+2ew3GqJEaA67PuNM3pDMKhFjDpCazCYxpbFniUY46JnYXPV4ngOo2a+//kciCbYyPeWxzHm3dd21cNXQQzBZkqTCcJZfE05kLllvUC+zHp5g6VA7ODfmGNyAoA3Q785RBkTKruZ3kzhGIUQjLoCtOtw0MEAbx1YnEW1mwSSj/qrxC7ViJokQUHMgbv5l8l0eK9+W+DvWEviWTYvF8LECrbEhsloQTOkHZaoUvSBuSHm8Tm3MJMD0GfBqp7giz9OribPIpRAt3eJ9LN4niTgrFUBilqdSwzVUXyWdYefq+eZUGPAHV7KVrS+uoboOaVa/mfKU2VZVd8W7Rc95mMTnilRSWZ8mGcUxA4org5Dydvvp3Mv6LWhtNmOxwiNicLyogHvolJgqOUJwkkWwlnXdA2pVphTYWiv8l9LKaloRiL+dUrh3G6f8RVK3GQvvrcU1lSbuUOV3f2DcfwqP6SE9tvmMdtgQJTATqCOXmJJEIfFDwqx0Ol7OKb0Yzk8FnHtFD2TrwLmI+Atsg2Sx+hChqO5NLFsuwGUukD6poEURsGOMMf1hwtqBRXa099bpt2nyshwDsTg+OUv4H6lCAmluUaJ03vsIQTs5zdzZmft2+Xs5Ae/n+p/tTugbMIeouYQiEWolgpd+t3WQAwCnFmfi1Itb6S6dlQGvc64R8cQP6lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(22082099003)(56012099003)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FppgFdALSQawbcV/+fyBIVlzeW0KZ4oC/t1fsuJ/IszzuweZGhrWryMFsKWy?=
 =?us-ascii?Q?BdLbPq12Ov06MXzdIXpEohZg8ft7GlDurpBOhQJ1zyD/puw0wwNo42OPEa8O?=
 =?us-ascii?Q?BZvpgBXIiFcfgc2B/Sx5Ag+ZjqFsR1VvqT1Kdh4GdvFUScNvvLNd54/vaF+4?=
 =?us-ascii?Q?+pEzKHwbiHu8sLgIbNNRhlD8sghfFIiIjXVDqK5tI07lTF8ic0xOayeSG26I?=
 =?us-ascii?Q?r2DXQ2MR5xUkTk1fF5RzoYvIBwPdPalPiIeW9VlzbeoY1XxLldsIXMYQZ978?=
 =?us-ascii?Q?nv64ayziNVM0fO25LYYfzEZff662Ha4eNScMLvagTh6T0FT2ITtaOhps5vbO?=
 =?us-ascii?Q?mcKEgM8Vx3706C69RHIr5bpoKKszmE2/j4PjHoYBUbS28CJYONtRmi0qwgVS?=
 =?us-ascii?Q?27xTZdPYrzMacr3IMxj4QACoapHrpmKwvZbxijDRwzAbrzIAmkw+/0d3XCTc?=
 =?us-ascii?Q?HNFRaQswnq5uODekK8A5gDZdfTE6A7+hCAEommykX3xXEI3MYSpL41K/uRE1?=
 =?us-ascii?Q?V+95uRYSnVjgs6VdJjWhi2GH9ACszU4it+4ZrAVJ3Wl+IMCqw8VsvhU7Mdqo?=
 =?us-ascii?Q?t+B0pGN7g8xPPTRtNjwq9+D/AD3Y+w+8AkXrx4Jj3IGgiP/VyPJ+J1Ka1ktX?=
 =?us-ascii?Q?EX0EBD6gXBwxdApjJf4u13ZZ6pIGap+c6G5n5+c9ToNeomKr1/nHHbeI9W0r?=
 =?us-ascii?Q?5KEhbDepuit2i2vtv9He1PgIbIWjcebCN6Yx4Ggu8koMApZcGcRBwbJ02zwE?=
 =?us-ascii?Q?TB0w8DtGyZMOJ4mjk4GPZVxduUnsjl2l7QaGaRRpYJH7Lt6tTLSYcJUDrGNb?=
 =?us-ascii?Q?iDJhRXfwpWFkBCBHQwh/TrSB42DnZniuO0imTPLkMYn76kuHOw650uRJKbd1?=
 =?us-ascii?Q?fyajbToLiuyO1cZXkR+9BF7FtMeu5F0iLHQY741a6INTkU2E/oyPG0ZDa1Lm?=
 =?us-ascii?Q?/UXC4Sd0jcIyfxMYCAkNS/VD40ic87pqb+d6lLujqD1fFgnWvghHA5LODAI9?=
 =?us-ascii?Q?E5V3ql7NDYaBlTGflkC/Vo2+NsS3WN+S8190YFGQkQ1I20vWHx8ET4TD0/Yv?=
 =?us-ascii?Q?QWg5FoLKMZ9Dvwi34thbbYTXGLPz5qYTJUIGEe8AeqQXR/mEisDxz2yhNEhl?=
 =?us-ascii?Q?mW/hP6us2rKqmZyKOnlMNvg0Zxi573LdScuIRzFp8dujYTtOWfhAZiG75PWw?=
 =?us-ascii?Q?nK7khsOX+1JyeEmqkHDHTP9A6ZywCCMVWnctGnxNUN13C3seN/qQQa4W/1NW?=
 =?us-ascii?Q?RIDGtWMbB7BkOyG8R7x+wHEtrV1M0KhdkG84l9m6XoTpe1pKBhIKCaRf8hce?=
 =?us-ascii?Q?fSZh5P8JRaeQPz9JdE3WnOf2UG3mEzdZ2k7Sx4B8cwt3Q3xO1zexbHzhF+FN?=
 =?us-ascii?Q?J69oZTOnOk5idpwRzhF456z2fEDD///EKTP0nrizCPnITw9sV5HmlvlSO6fc?=
 =?us-ascii?Q?qgu4KeCmODokucY/MPIurudHtsZwMVWBvXgOTjASkJ5L57AXey4gmoXEQIRt?=
 =?us-ascii?Q?q9Uc6DCe+6QXeUDOpOi3nZGdYTSum5NaYQiSKuv/gNSC44TVk+We8RK3cAxB?=
 =?us-ascii?Q?rcQndwUJ+J3wCQASXSG7Chsi/oGhDrhJqnUDy4O8QRQuZwo/0Hjn6GTUGmqN?=
 =?us-ascii?Q?0153psVFN6RcITuimm85erIYymlboQ0ajrCk5DB8674Us//cjpP5peSWBO8W?=
 =?us-ascii?Q?a0yPr0Ghbe9NvKJYxNlkfgLKhky/J9ffFWSQ0QTm37/uwTY8pTImSDwQWzKY?=
 =?us-ascii?Q?RpUF326vnMIl3jRxdC3GzzuYJADjeG0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8168466d-1c45-46c0-7781-08dea9dd8a1c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:03:30.4826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHmUjBETVAjXuygcS/OXeuOf/DgLGRH97kuoXsCk9P3ED1gcvPkR3GJbuQswPQqrD5KlEJb+vU3v0t+RPhHGP/TWoYd8D+J+NkvJhqCmkOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 configs/an7581_evb_defconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index a94730cf564..eb9623d6b47 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -46,8 +46,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_DMA=y
 CONFIG_LED=y
@@ -67,12 +65,11 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
-CONFIG_AIROHA_ETH=y
 CONFIG_PCS_AIROHA_AN7581=y
-CONFIG_PHYLIB=y
+CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

