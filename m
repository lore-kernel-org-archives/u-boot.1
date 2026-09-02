Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CCBC624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E58180FAE;
	Wed,  2 Sep 2026 08:54:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hlYhthR1axM4; Wed,  2 Sep 2026 08:54:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339249;
	bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rageCmY7S4nhPfjucBzP1qBFDE57FXFFL/wQXHD9hPUDkJLZXT/OiUu53NKePOvkG
	 BfGc9PFbwRt7QvM1t0TK/cyo8OaK6Fec/OqBOX0EHeuk2l4+WYs3x3ymBvZv1TdP3/
	 m0cS1v8VNlvsrFAAKCLVSsSD4YxBxS4g0/W6p/368Eb6DCNiQzgpEwVt0DEd0vQF8z
	 wVK9GzaUMN8mpqFFzOva0LfuhzWJtL8mBlmfoq+qpuNnHdE4acH+SBqcJj72oe8UK0
	 SqpFzMm412wCoRgu3kFwFXKHpZQbC3HpFquSqT5BHgB0Dv5A7tP+KS3Kpd1wHilTuh
	 aBa26yGQg6hYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CEE880F81;
	Wed,  2 Sep 2026 08:54:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8D70498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D79EF81067
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2px_MKsFre4 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:54:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=MaiCeqGp
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDF8C80F37
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKqoWpwHQSh2fCm0i2Wt7ci2GssX52K2FolLrrav9XEKCOzrDeVLDZfVWdxHr9BBPuFFieGyOu2/xxhckLwCc8EMV4+2Xt2eJANeoy3f/IdUNd8xOaCgt7Lr49wlUJGJp1JDtriILK0dB6LQnd5wxQJTMeIqIecrmfTsNzC/JreW3/fnn2qxJfyJAe/WXLfPKzMn23rXZ6IAgk3yps79cFrVV8jhtq9nxbUYkPINoGfxfZVT/Mp3M2tYh/ZEsdYVya2rWrNN7SwJIcmGplY9i6nmQbdxP9mHmh31vMBqoh0sYWkZ0yb9qc2ShB62EoeppmXxkpJsGT3n6HaQNGP4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
 b=W5295fPa800T7C204sRxFrfmuhy6mRln4TeiT1EnG+lcWKZcWrWpOCtsoj0enAhks8XNA5drXeDZHztrchjbfze4+iat2kSSq1Hl2AJCCvpT/pGG23WvmgdC7xLYv8hW24Tr465+lDN1Th81+oGac/kM7ZnJjgmgEmLCLxqlvjpOzDSa1hi38RPL0Q9AuCWlmGGu96zGm/nfR9LcXLIQb/D1QiaXdt93oZk56Awzg1A3ZolRbWOfatVoBkIOHUFbf/ARGiTWypTRmOHTrAm/jfN4v8nAdgRi6XMewHvyO13OHmZHdMzQCve4QviztmirxRL8HEoil44chTlHAhKS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI4gfeE7kCjACPrQ7wsYtVrkjFbTZnsCShCWwyU+QIQ=;
 b=MaiCeqGp98YKswGENd9tLIO+IMxdX42Wspi7D0WZ2+9p1lDshG05Nof2Tvifhxj1fVz4M/3kOrZRjM9MytdTQZfgy2LJqyZH3avXPtpwcIFFdQg06HBRZiQk9dgfRTlbaLoIZoWWgC9VPvlS1+tI3SZjuoTLIqsNFDcHEtvdeERVQgkNyqQZjKKCfU2rb0S9KECh+6EJkoBumjygvya3jrxKrY3NeYMl1y+z+uq/T7yvX/Xd2Z8rqxwl53zz8XIxl+Lu+8BEdpHUbz0BYv2jirvTmdvVJlL8Oq0Fln3WISQVx/ba8y3Bkon5vaLnc0kcPk4vdtIbSDZdH3vnN42JHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:54:03 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:54:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 15/16] an7583: fix system controller mdio nodes
Date: Wed,  2 Sep 2026 11:53:10 +0300
Message-ID: <20260902085311.1550804-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cde82c-6024-4ef4-286c-08df08cfbc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|6133799003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qhY0KW76awnWKxzLhTBSrXf/FeaLwoPR0nkuZ4ki5HXFopqk9ygMar4yYt++Tq+cYlxSbUIw1eDXN5GMzhxmrOPWbcRNilMKRGFB+sQ7erPMuu2P6KrmEPDa/EQ628sTPQ7Q38CnkpBFBStu6W9ZdO+xSj+MIi2MUGKRU7zsyX5OAGQjOF4OXCuyEMuCNyOLcc50LZ7vCVA+2eWXi4DhaG0x0JhfvnarD6RvKS8qhBlaBubUzK6jdrwqUQRo0hVT3wN/rWWYOrdQAjfmX8+mekAPlby4nzBoMZxbFB0NjgU2JzF94C9sQsMEYYRfpz9v0jkpgXBuPly8i6FOBO+gaoejDV+v3qumoUYpl1yCqvh3R+ZDmtTlSGOAdmdyEFGDrmRb1DepVXpQf0DFHVnMVkBAX4BqIwoA6GAww316zTdaUfccUvqlgRouNb4yirjRXt1eJZOHSSsJBtynFihXICI/9z3o9e8fqqBabBkqOMInrGFbKSJgC6yEyGU8KmOWc4ffHHXvFWFls6qfHMh9RPW7V0WJbihUD4C12JH98NAVjkMktnhcRfYtJDE7sKigd4St+519hQXK5j0HN00w/YGg3/42qG0yRZG8j1XPBtfc7YdJ9ujzrWxKn9p+NFKF0RULuz40r/WwQ8lOeug3cgCbOWWa6xYKPUrgbcR56etaCIJFxX4Uz3eX+vbvgYZs2ZVR2D9MyFWkuGKPRgOowUvOS93asSA6SZ2m3s5t/raCnRzxlVR5TEMN6RRu8Y/U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(6133799003)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S5Stk24jG3HYjvIBglN/BW1CE5074z0tVZ1Iaq9M0jWXZ8cHUSOkVU+SVUl1?=
 =?us-ascii?Q?FQKxMGA01iH8Bt308ZkZjDgGYXV4lwTuXh65LMJXHSEhYq29PUZdsN0gJHkV?=
 =?us-ascii?Q?bNgFKeKFizauiUou+yOQmx29jgCpVAW1F0Ttz/OcBjlXYEIQCVZGw4wlE05Y?=
 =?us-ascii?Q?0IuSwXaZYRqR5Y5vQnCRbY91GgNPjEstlcrm257HTsImSNLWG45boc7cwTiJ?=
 =?us-ascii?Q?3fvV05+qUh0vBLjkeu3QsmtMUxFL1L1ojNhsWaNp9hOWi82LX62fraZOdHUK?=
 =?us-ascii?Q?ov3maH7AHY4Ry7IWcG1mI0ewz0wtoKpWsY5DsOiL9rQQQHbJamH/S7ch3C45?=
 =?us-ascii?Q?0arfdjpiDAu84CSezAqKdluJzjl7qtWk4Wi7Vlkg2geJOafIudGyFayr+cZi?=
 =?us-ascii?Q?+3frdUgLWMC6z1RxdUMmmxQtwB/6g47rlp6aEiO7qt7BPmA1j1Y/M/cM+fq9?=
 =?us-ascii?Q?3T7pRkH0eAr/zdclYQgelOJddeoxrPh79Se0Uhf95UVw8thO0HYp9fA4cpS4?=
 =?us-ascii?Q?BtXFnw1qGIGx988KJdIODbwAOS6Ryn86VhzhUZPBQigFE8QIpG/Ks+KZiVd4?=
 =?us-ascii?Q?OUBZhl+NQT3I4uWvoRAK4PTrBEiFAcWNnPLf4YsXUx5VwAT/g7HD75qaK6d3?=
 =?us-ascii?Q?gPoHCHVhgNcqMqyMmzhGvrKaH3BG1pixZe2XryGsLhMzQrKr9x3hE5PZWJfx?=
 =?us-ascii?Q?bvjrH+XhdppGIKWQmwElLmvClpUNcEiT+D1Juy7FQFMjkHtwqB6ahqfTf8a4?=
 =?us-ascii?Q?GZmsFGp0xM9CwB/IHPMsdPABCp0jh/yTnrtdqYz01CyMK7jtFZ6I+m4Kap6R?=
 =?us-ascii?Q?9gJLYYOb2wHnXeg2BdApAQv1qql4L2L3gl3v64bIfK5o4+pog93efJBt+656?=
 =?us-ascii?Q?rnyzT2/eo9aVRTSS0LBGXL39I7YqEGLrbaBhfaibXhnhv+UlNuTWlX4Jm+sd?=
 =?us-ascii?Q?BMupO3pfh9a7IDFZtKLe059OekOtfERkuHUahsKCor7Q/clTNw9X9YZBf4wu?=
 =?us-ascii?Q?nRVTW6ywcSkKX47q+cD09J6o6nQtw1oX4PeB+LCyJ4kzl1IRDpYDSA45RF/K?=
 =?us-ascii?Q?eQ2IOQRpm8EKwtzOrAXew3qb97zZU7LtbCIs6Lo4NeIrYFuemwfiUL7E+1wu?=
 =?us-ascii?Q?2vRgrslLQTanVU8jVSN2Gqk4cu/rkgNFBP5qyNw1vLJWL6OmI62z4L+eaGmF?=
 =?us-ascii?Q?ppArJoe/Wg8jWneCtPZT5sEi2iB6ZWzOpwhApxQkCFOB7WNOEu2TZ/I7jXif?=
 =?us-ascii?Q?ppTgdc6R/D2g4wjS+BBSobcbLbDwcvHtDQzSddY3t/k8HWBJLv37CO2RjkOG?=
 =?us-ascii?Q?B8xujGBsws+pFUOfxsZZL5l7o0I+Bhy0zJK4hHxeSOf+HBUHcV6dFwdv1Msy?=
 =?us-ascii?Q?82rHbnmqg4J4PUTpcK94BM+duyfflL+lSr5Rf5+/xOyGUj2BCQY5rapdRgzn?=
 =?us-ascii?Q?8gf9mf38HU9PvfluzlFSdMUJAJtt26PsHpMnaG/4gjHLKl/RI84aOxz4eD6U?=
 =?us-ascii?Q?VJWAswQ+2FyG61rYg1nNTu2i0OS3efI8dvnjMI4ASKs9/a9Itqw86d/Dmme1?=
 =?us-ascii?Q?Cd/Nti+Z7G2Y45Wzw7br9Px6UsiU2uhgAI/GE8C2Xe8KQESDZ3JqYvWNqQF7?=
 =?us-ascii?Q?biHXi/bjVmk783sw0+qDtFE8ESIXJ/cRAws0DR5WmG+yDThprBSiIIRfXII8?=
 =?us-ascii?Q?Sc2T1uY+9p6ph2XDspIjQTYjJLE+Qd5x2f5Fd/8MdImAqgSlPIMraarPqaSd?=
 =?us-ascii?Q?v8QcqYzAaJt2Uq4KrHsrs10idpb1O7Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cde82c-6024-4ef4-286c-08df08cfbc7f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:54:02.5418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPN8WZxM70Acw0mw482olAA83nUbB6VdlYYcZQb9GCJXVdgGMVJNdlZ+fsgkwLzOEEbCEvTjbdd/OFCF6EbB6ThrMBRGzAslYo+qgIoG1VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The properties 'reg' and 'clocks' should exist for the proper driver initialization.
This patch adds missed properties and renames a bit mdio bus nodes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7583.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index c8f445b2c41..cbb2a96a1aa 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -260,18 +260,20 @@
 				#reset-cells = <1>;
 			};
 
-			mdio_0: mdio-0 {
+			mdio_0: mdio-bus@c8 {
 				compatible = "airoha,an7583-mdio";
-				resets = <&scuclk AN7583_MDIO0>;
+				reg = <0xc8>;
 
-				airoha,bus-id = <0>;
+				clocks = <&scuclk AN7583_CLK_MDIO0>;
+				resets = <&scuclk AN7583_MDIO0>;
 			};
 
-			mdio_1: mdio-1 {
+			mdio_1: mdio-bus@cc {
 				compatible = "airoha,an7583-mdio";
-				resets = <&scuclk AN7583_MDIO1>;
+				reg = <0xcc>;
 
-				airoha,bus-id = <1>;
+				clocks = <&scuclk AN7583_CLK_MDIO1>;
+				resets = <&scuclk AN7583_MDIO1>;
 			};
 		};
 
-- 
2.53.0

