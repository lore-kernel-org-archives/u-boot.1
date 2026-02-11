Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6533ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171C083E3A;
	Wed, 11 Feb 2026 19:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ckHwbaBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33F183E70; Wed, 11 Feb 2026 19:23:29 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B34F283015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBN7VnsMWrxRoDpVxlxhbTHB+MZq3lb60i6eabvWL6OLpSyVXLC4GegOFxSlckhjVViTbI52DhfdldMLTrbURB0eoFUybehRzvEr3N1wU+OhJLhMzf/cajs2GwNxjxKZ8KNI0QFeuB5VxeG7d38ZZBcOyuu53Be0G5ee/Qj7fUWeW1odkpwVzWldkDGK2oI2Drfq/lUNdGS1xOyUR3LhKpSX2PQlO9BE57OojzJN34IpX2TRnh9nF6FuS/oXitELXjA+KNONSk/gNYyz6MOaS2CYrYn09UQprcXjd5NIBw01r6SZK3TU49uc335Nyb8Ex3tCa5RHhXR/16aj90aSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ0e7GR0y0mYSpKrt7ZDnuYrThbd7RGChlZ9keeL8VI=;
 b=QiPNrUdKxAbFJKpCLhGYsuzUlQCEK6s+Ei95zGzOuZ4auRsMbNV2LAaWvwyBRLwUTBVkOVqvyO86At7dGQfAii57e7Qe8qa4vZjkuph+u/CUW+TjMwqelBxlKmBc4F0phEusSt8Hpwa5LjgZaIVC6l+B1GGVM4q0NcBXm3Zh3WQtGP8cSvjyDb+xjYurVRmJmpBgyDVVIryZhdEyzLlmZIAKEyhLHB29D7KTkjjNuQ9Wysu7HjK3cIpB6iJ+dI0v4BBcCWRi5ZBb+RDeZjBnto9cPqHtmL5szNkLmsKFrpM4cF9eeEcejubKHbWrIxZBNUFdQB9alhT2X/95riL78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ0e7GR0y0mYSpKrt7ZDnuYrThbd7RGChlZ9keeL8VI=;
 b=ckHwbaBfNlzwXJCU5cJvbFAXWU8jn8RKg1EtAvMmygfIhRr8XnEq/GOshgOWoXecWqtXsPibkhz4W3NMqknlpAzKK+tMk7oYU/XzWKF+TZ+ps1Q9g1slnX/T2nJUMzoQ88Cyb/ByMwM8RUJSFAdswI7XBV3oGbGOV6kbf0oeujQVR4dra9CDDDW7kTSVXd+XcSHXiYOAw+404LTd+OwXCAAWEhEzoXgfiZhhT0LPIP6jD3DqnXu0KGjGrt/sdIRuHIhy/Xe09iwrM3+dR+pmW3JL6DRE1HHWWa0ASH9NvzMC7+46LUn7PNS+5KWpsavXpd4Ik2SZIhacIxReV+jL+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:25 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 11/16] airoha: add GDM1 sub-node into EN7523 ethernet
 controller node
Date: Wed, 11 Feb 2026 21:22:25 +0300
Message-ID: <20260211182230.968921-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: b74d9ddd-5f2e-4526-e91a-08de699aa572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oyQ9li6j8WtHrE16jo6KMD8wVpnWMxYNEu3Ze6c8dvG6WUZCTLeQ3dqJHWa9?=
 =?us-ascii?Q?egoOR/8HfGlgkuERR5JQg/ottX8rPZev1QZ1urh7Hqth3V0zqXzdusXE+afw?=
 =?us-ascii?Q?d1r9aTf6lSCJVEL/NjQOxBZs4WgdtZb2gQiH7nWDDAK0m8oXzB3pv0rxPNlm?=
 =?us-ascii?Q?BWhMrJVVAy07vwfUcb9qapH0LbbffOxZ2ywY0exeCILqV7OP/QGT9Nez/RT5?=
 =?us-ascii?Q?HysorSEvxjKQc644xxTD4ATvgpdovEUQPv3D7g5f2JoY/IUlPNPKnSCyWKG6?=
 =?us-ascii?Q?WYpo73wVVcdUGkJQoeHgzH7jcmiAttkoREho1zV01jlOKbnPSAE2jxkA348/?=
 =?us-ascii?Q?imvpg0zGxGO3AwjxFAAhEpKMS2C4f5j2hfTIkoLpp2B9LGvK/INCjC6nLglS?=
 =?us-ascii?Q?CDDOdYa6wu+y9SoWDXbtLncTbh9iNybVj1Ae4YfppbUXkRPOr/YsahgFyQZ8?=
 =?us-ascii?Q?Ii2GoELlnlg7VXBcbg2Q4NqYsByLdmJ4Dfg/fk3p7NotsgGI35LLGZ8oBJew?=
 =?us-ascii?Q?pKdYeFMMTmZcH/WGmq6lTtE9711bDKxmVz5UQYHOQrZFvhm3Di/baj23UJD4?=
 =?us-ascii?Q?PWx1oGA2it1JEZlOL2x4AiG2MxP6fPwknqoVCiDToGqHzy1OfXbtK3O2/uIj?=
 =?us-ascii?Q?bPEeUeQCXs4CQVRRyg7Hk4FoMS9WTHOdGuYm9DdDDQEbU18PhPaE9tUs33oh?=
 =?us-ascii?Q?IjgovqNIk2U2c/1iLx9bkqYqKck1ICcYip4EB1uWMOGGLghi1IZEtJWU3lRf?=
 =?us-ascii?Q?qIzhiUqvCxV1UYKIhcaOa/VeVxhG5vSPKg1b/stPCBOpnmM4DSefpGUhwHaK?=
 =?us-ascii?Q?Dcv9yt3ZxZMMwzKLv0f5kp1bX79G5AM4rIKW4XYQlDUvGz0zaX7/IFsFLnKo?=
 =?us-ascii?Q?HZ4nQZO0721GJr8V+hSXyzw3Cl6jApYgrRJnSJQ9YStYsKQ1ZggCKT62Cnrq?=
 =?us-ascii?Q?L6YNYB67CKatUDv7iXQBGhpE0QvdG5dbqjWbR2I8a/3F4AtSaXDRM3pxSuUE?=
 =?us-ascii?Q?jL1IpyPnHxbpPAvVD/HeunpniYj6R0vCWGiQAklC0SvTwpa4bDFkHVrIu4K2?=
 =?us-ascii?Q?mYBc1OpRr5oZKu3qb/pLfHl1f0PoDYCiGu68WLitR3nPZmRaDaaLa6j5ecmj?=
 =?us-ascii?Q?ZDv/NzVNezu3aF//TpNE7A2kcux98LdXEaXwAvgfNIHPXfGcgs3DS4HKTJE6?=
 =?us-ascii?Q?gmDRl1wwiX5+uoy7AsxN0XcubAUngB9bFQKQuEhCMK+E7lkQ5stTRRMWVq0O?=
 =?us-ascii?Q?zFwMLdoLlfQQbDR6sqb76VzbLH2NFxQgKyDdEjclJsqKS6N5QdNi4hux+3ha?=
 =?us-ascii?Q?nYMk3aWVvCk3Xu7+m9K3alwjkeF6HfbJv+wkwZi44bNLAMSOpoQB0SDiUEG5?=
 =?us-ascii?Q?+9LgWYTllalTiwY2O8wi3LXWEhTQRiL/5KDxvmQLXi/hWtB5+nsZKij7dU3T?=
 =?us-ascii?Q?4sYRdOI1l1qRJw++Pmck/xD/8Zueq4w9i4196ThUClDAiuN9BMb5M8/3jQ0J?=
 =?us-ascii?Q?RH3kWJAqrj0Jy/7CaFVAjCSJsumiTdRjIfhPUJa0XL89roalNFzlT5n2hpEr?=
 =?us-ascii?Q?vCuF1N3NRlj+GdhBm5/ru7lBdnuAvovghE4Nln6TXtJyJ/yoneYfWNDYqQvb?=
 =?us-ascii?Q?epfFunxZL7UDIUbnBy6+gjlMvXYqOsvc69F4zMQoxrRL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJfsQmZDiZCCTe/0/J/REupL3WuGnBnoyvWw9bp0hin3TV+8F56J3cMlLCIF?=
 =?us-ascii?Q?00hMzb9widHbzOHrHI02FTOQSqu5qFi6KF/W9rZn/J/9YV0v9sEnWIs5UthX?=
 =?us-ascii?Q?ySSrxBqzgrBYjUBiCDYXodt56T0/FLycfUlSCcYtbMRXp2uLHn6jP21U7PmI?=
 =?us-ascii?Q?ipAUF3SFGUtxH6VNjUxgjTKUAjgWNisNG6R47XAHE80nSddUFlb1VaWc8yML?=
 =?us-ascii?Q?UKJJ0P/4rTnFAduXbFcldFlMLosJ+iypIxq+MscZ0LA4ArXjHrF3vE+h1j+A?=
 =?us-ascii?Q?pIpKX1257j8sw88iWyR9iBf2TdabWPzfCQvl422gkC6jPHJ+5Gd5iyx73f+/?=
 =?us-ascii?Q?0pQ9tbN/UxeFGOiGIVxk0nSJbeC552+Rwn8YybBYIIvHmPvZ2Kz8aOR3tAJn?=
 =?us-ascii?Q?ky9SUzb/iX7zedCdkdGDKArG7kLmVtOkI3axpu2xJsWdYu5bHtK9MmHk1vCn?=
 =?us-ascii?Q?zaI0gnDkMuUIeDO8bw35nQlUackbN9RrCsJmflGDzFr1BGlCXi46R5nzqwpu?=
 =?us-ascii?Q?fgjkBdiy2xYsHePc660UbLTVIo+Qk+/CRR/2/4n8QMDLLE7fT70vTrjzQKWT?=
 =?us-ascii?Q?rXMaTywqRMmlh+p+inuzHzuXNRi7aIRBX0RE9dewOJ4i2saWTo/Vsoya3X3l?=
 =?us-ascii?Q?pe9EgqisItuuCInh5vswf0HydcLvggZPcbAI+yMkKpbp7uba8E6MHeZcuWDR?=
 =?us-ascii?Q?01RoQn1QY47iJF8RG91AWSQV+PwOUsjmVdziUEAhJkQ3lUFmwFq5ysHi0U9+?=
 =?us-ascii?Q?58c/iJXFAHHEudTGchsx4nSHDhCl7vHuaYjsSmGd/hAlI/18Q9OYjpISXdu9?=
 =?us-ascii?Q?HbZyxZtXLyeyesM0xbj/IBm0lUDtiQbQCCsbd47Hwx7CYBGSIZ6xsQtpDph0?=
 =?us-ascii?Q?lPJQzQ1LprfeGVy1lPeDcA9SNAAaxeetHYzQGvIs4RlUIDnV/RS52jvH32n8?=
 =?us-ascii?Q?s2yYV3+HR1FfdC1r3cMJhXyo/beuUXGR2IBuZiJ9Vv3/4wnYtXpCmJq1Leue?=
 =?us-ascii?Q?qk3gGy5FHa/03BRuWgTccdqUC0IBp+p4gBBYZjXEV8seLco0OJIz4hr34ZHP?=
 =?us-ascii?Q?zkWhkhT2u+07DUIdpFkWrHWO5bFLsf9BkWv3k2f8bYw0o0RPnahpEFizmUJq?=
 =?us-ascii?Q?V1QOz2GJ7XCRu7GnSryCQKltn+E8xg4XNQ6Ig8qztdL5IrRbu+V5ZOtfaMX3?=
 =?us-ascii?Q?7zLiAEjUWi2qIOYo3zGU5HsXBlnd9Et/xxRVev3fA5dEHs6v7+DeIDU9rOgI?=
 =?us-ascii?Q?ldyfIDdMeuADWH3Ss39BSAeHANF4xDFX7Vc+U+8el2/JM/oKTPIVLuwYtri7?=
 =?us-ascii?Q?xUCm7Kdpt6/IDckC18kYW1HKUWzH8XWju7M6rwXNepv+JKLWypURLl1tn3L9?=
 =?us-ascii?Q?lh41i49ffUoK31Y/dgK9rDeiQiDQVo7+u1Vbtu25/a2iXlDZcsEyGUMGCZ+E?=
 =?us-ascii?Q?T3LVaa0UpCxXbkPpZ/LQWjao7OV7a6R5AGmCMePfwdb8Dzgkpxk7pammhNAL?=
 =?us-ascii?Q?26vzPGdmCER6NIn1hokF7Uv79+Kks52vi9zqBhhCAv70a6el6RVNEn2p2C8R?=
 =?us-ascii?Q?t8Mkd85C08X69tZw+6TcWITwEhMereRBP3zTau5FYkDxZpDiRw+C17vORvk7?=
 =?us-ascii?Q?t/vWzxDVj2TOyDN0Ur46Z9pW77+/QEWLpySGauOsKgmwOR9alTSOd758m+Z3?=
 =?us-ascii?Q?6b5YXUFQQJ7ns0ydijj0yWxbZYhUXpKUPYxNdXoN9fqOkOzfACjuALXdzkRB?=
 =?us-ascii?Q?xTmVJ55V5ad1F0OtEvWskhJoWDy71TE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b74d9ddd-5f2e-4526-e91a-08de699aa572
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:25.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HZ6zeid79Qo7o4VatMVaMQGIiJ2V8rurRwvrIqZaeUNdfiSguUANkeHwoPGAV9xCDia5ZoH1GfWHxtg6sTqAJm60HQIDMRA2K4LqWa/Lu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

This is required to make ethernet working after PCS support changes

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-evb-u-boot.dtsi |  4 ++++
 arch/arm/dts/en7523-u-boot.dtsi     | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/en7523-evb-u-boot.dtsi b/arch/arm/dts/en7523-evb-u-boot.dtsi
index c109d6794fb..d6ab621d590 100644
--- a/arch/arm/dts/en7523-evb-u-boot.dtsi
+++ b/arch/arm/dts/en7523-evb-u-boot.dtsi
@@ -9,3 +9,7 @@
 };
 
 #include "en7523-u-boot.dtsi"
+
+&gdm1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index 9eadaccc500..62d1a724678 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -37,6 +37,19 @@
 			 <&scu EN7523_HSI_MAC_RST>;
 		reset-names = "fe", "pdma", "qdma",
 			      "hsi0-mac", "hsi1-mac", "hsi-mac";
+
+		gdm1: ethernet@1 {
+			compatible = "airoha,eth-mac";
+			reg = <1>;
+			phy-mode = "internal";
+			status = "disabled";
+
+			fixed-link {
+				speed = <10000>;
+				full-duplex;
+				pause;
+			};
+		};
 	};
 
 	switch: switch@1fb58000 {
-- 
2.51.0

