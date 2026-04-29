Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A31FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3859846F2;
	Wed, 29 Apr 2026 10:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZBA+P3tK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E21DE846F5; Wed, 29 Apr 2026 10:15:39 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB58D846EC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIvc5WvqUl7QsFRHLWbC5+b+3nBZowLfjaaSNhShlzZOEKZL+z2jau9j+tvPS1k0n28PkZFwL1INvEaVyFL4nK1QuTsQIPkoos8jQgBQeyqFkWLa3d1mXCmVKIVM6Banwle/w71HZk2F8jiS5l6skrsbkLOgxk/J1RlhAZYMDyoiX2eSlIaq82YPhL0vfT9AcOBPbTKoj0pAWMh8V14OevY2oouVhMqJfFMNanONLuqKDiQwnHhT8aTdeBmM1K+9UGtYQh9d4BOJnHFzXigVxJEObMx9AbBr8YFQVR7E3A9E+hmEz6AjH3mZhqLompbMdT7RGW1se7KIUc9pxKzbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2zjgRXLazJCh+nTUbgjoyrIOE+V9kZmrKBKHnirBUI=;
 b=Vhuhi/fMGbEVQa0+VCNXnk2Zb8K9473UMIgq7LxAnxcbo91ZJ+xGgCtZKo/UcOQcv7SevZ6Bc8rTOc+HkEdzra2YHVev+RTSq4v7Ak0GosV0c1EFxAO8Vq8IM9nuTnfic7CWde6I8VBUp+9q6vqbzemWzMxi/wbCDOmWeBYYPceDqaG2TmHja0coPJ3alYgYowtN/iHNPpSjVWiSTcwr0jkmscYBq7KkpU6XPo64gRFD7nyd1zB4KSPr/o+xFVWs4Uz0yo6ZQvRpmRdY6ckDztfxjzw57C1VDPbRwF4llPkcVGJ2NL0ms+HIswLTjC5wB3Ijjx9Wt2DO9ugRGVb3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2zjgRXLazJCh+nTUbgjoyrIOE+V9kZmrKBKHnirBUI=;
 b=ZBA+P3tKkU/qB8Q0kPVWxFlfJt1Jg6C8BPUnjsrNPVAoHaFjFGgdUAE5LpVMCyCKzLyAcJS18ipkUC7Wd42LN7/qSnihYVkrBi8jSqvj+vKNtzThiM643Aj0BnmGnAD5zuCl/IBePURh1xiUrh8+O0QLYHwp4q8Q6tx7NR7HVRVIlwKgP5DZ4VtG77R+gMYAm6SOdEslH+eWRry56vi+hiCIDtWhVB+DVht/WWKqgEKgsODu71nWH7epVHktAZDbIzyrxKhl1lKoEzXlzTJx/7hNocgARit1doNlmevJ6LdTNmJWdeABEYm3q+I2kV4KSpxRsF9KdKW5CvP1fK40tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSWPR03MB989143.namprd03.prod.outlook.com (2603:10b6:8:361::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 08:15:34 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 08:15:34 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arch: arm: dts: agilex: Disable gmac2 node for Agilex7M
Date: Wed, 29 Apr 2026 01:15:29 -0700
Message-ID: <20260429081529.5713-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSWPR03MB989143:EE_
X-MS-Office365-Filtering-Correlation-Id: 56562319-7f14-4f80-3542-08dea5c77c82
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: B67480rvOZXwW/fmmMyJn/X2yPLU19x4rbFSJD7IYnu7PmfbJIHjsZUWg0XfXOOWMOncMZI7+TrNWwyLQ61gvg+nSDea0uQKmz3ivPFA9OjmdxOjfF6q79VA2MRVD4glHurGca0/aav0qxEJVbwKzZF55aAn5DrQQSjxCT0wMvq8zq+Hjjr9moGJT/VPweBsjdnpfKI812i4w/hvkWJStfY6pke7W+tro9i+00uBV979FmMikqcy2P/7s+Ws2/wosKmDfveb1/hUB24ZkKdbdX/GNG69+4LDZdwEzgeKX2OqbI8CQO/axTtEx9XtwirfkQHtQW1VhXaIryrP0HSuF/q1DmABWTRJXYvVFbzKW0oQmWo49iBBU3Qgc+EuaGlcNYUkZOAp7zqhS+I1l2lNC5ZHiRURpYv32JsX7N6J4kwTFy+Dhgwa47z/yffADeYZULK3Kqov0fJkXrLsWqJ8VfHBZJNR+tDlFHXzxoUKE8JncApJNB7CSWqsdUZpBoyBZ9KA5qOjZI3Rmuc/DrKvhYXeXqI3MvVBGsx5MJ5BtFd806mEgbVLNKI/q7Yw0ALcX91t8qaYAJPeU4Lf3F+wM+a8PymCTjw4WQHJT7/STep9Si/L/gKMhYHHeJIhLRIW5wenPpq1KtcCQPNt/5vdSl13X1joFBfj8/ZDA8BnkVwHkL+xf5DIYIc1FB2ycUVRipdNok25CVBgCJykxcYLVE9cN/bbWWyzmgH9e4uAccc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qziA3ppmgWsGY4f5IrTtWk0gy8PRivwNo14mra6d064u/k25T1wZvgv8CPKu?=
 =?us-ascii?Q?Z+1NRnFKbUcFgLzpiQFo5V31Db19EJ/RFBnVgYMPuOh1VU6OJr17EQ9LiYtj?=
 =?us-ascii?Q?Ura+JPdDZahPgl/IwegP6G9pJ78VJh3R9ejpKrAiZS38mXTquaOOitl9EN3Y?=
 =?us-ascii?Q?NRkp21iTlGSpdNpBuzvNx+6cY3AzH8YwI9a74ZdOitMLQEfjTwwF+RTcGjOI?=
 =?us-ascii?Q?5E+X8I3eVe7IOj2TqZe2YXL/8vn8WrKSRi8/70HoUi8S+vIT5Y+0Q9Se/AMW?=
 =?us-ascii?Q?b/l5zOjgSPoVHO4iKt9Pwkcxo6hUqjn+mxJslXRd7tCVTQgJSdHovJeiB+Va?=
 =?us-ascii?Q?IhekZ15WRxJDKxwuFqpFsVVedN8HyFCRwQfof/niKx8DVjjIQlc4PmQtkGHZ?=
 =?us-ascii?Q?EgXOUQQuYD+3szTenTl2fKOqF4Ej25dtUoSiBj1BTF64Gm2YJDQeiI534nZZ?=
 =?us-ascii?Q?Ff7T3NqRVlwOtOy6Tt8TmuX/i7T/tlmfoe+mnGDkbLgZIHr92in/+0VxsB3d?=
 =?us-ascii?Q?XWiVrBxdcwLbL4cDQ5/cTl5c5u9l6zUKUQXtSKZlYSIy0cIT6pCG5p3Y253Y?=
 =?us-ascii?Q?VZJuFwIm9coFOiHOgvdlCSq+UyJyh3begMSWcLpuWbbJ2MwhxWw6IlgRGTYV?=
 =?us-ascii?Q?J5ttSVTz/FQPNdYkQnzy+OyBuew+3IYQk4O2OEB7i1mK5N3lxraO7aksdkEb?=
 =?us-ascii?Q?SP7isw4w48x6KCyYZmxdllAiqVDwhGG8cjot5BkVhU6YrY3MEE0b/aOz97cH?=
 =?us-ascii?Q?Xb9voI+nNpe98dgfa5Exvk4O8frKFCig4S9VrzCMaFxJVSYcVC5ad+JIbk8C?=
 =?us-ascii?Q?E967OU8lyb72dg/Ub/79pFtmKnXCP1c2LN5Q5uoSjiB91XB19kIE0BytzqBg?=
 =?us-ascii?Q?TrUHWP6bOXCjLdXCVsIV9I3srXHDx3haux3C35STb5eVVYhR2TdEwOnfZADx?=
 =?us-ascii?Q?GhzyhhK6bTqUWfJZF+J1NCQCobwl3fSOkLJ3eUMyoGR/s8XTKj2NYHjm8/ZQ?=
 =?us-ascii?Q?jF/9fDzYh9T4hHO+h2U1VZ2o311AQnclHevgxS5egZvqBH0fBJKtRtS4ateI?=
 =?us-ascii?Q?ReX1qM088xt0R4T/MRKCYa91Ia9pAQ07ilyXHNvFIZZbdPN42mC/mZ/AEbFR?=
 =?us-ascii?Q?6GDfx1NJ94x9oIXIo13QgpZHI/ZgYqb5YrhBf65BBPjwYz7LBs3fukZRvouo?=
 =?us-ascii?Q?2j20Vvjg1YiYBcPMvindDKICpN5mcaCbfD1wXF5TeYvJFUDx8NdA7aHQcRyj?=
 =?us-ascii?Q?IbUhz08RgD1tuHY6Ihpdx6MGgG391DXxQ03r041h5At4ay4k5hOs1jYKXKcM?=
 =?us-ascii?Q?bf8XSLuw05yUWwK+V/10N/3DhqwxEqbFTs48FxW7LHYiEUAlnqR3d8PFYZdu?=
 =?us-ascii?Q?FXoW8CAuRcNEww4vFneg9fwCmbrtaqbZ2D0gNURroOK+L4XJ9rpeIAeA6vAY?=
 =?us-ascii?Q?7fb2tZGIAd28/jy3rCGrD1wiZ/asR69vEu59SdnxNIVCNj6P5rcoOzz73Pmt?=
 =?us-ascii?Q?s7ZHHwOx6I7MPNQfuENV5mZPemw2T9Tj3z/UMMqySL3LVSoxdejowNDDqlgY?=
 =?us-ascii?Q?iAFIMAcEgqdnT77X5hvst7vpPxjL1WeTyJTP+roMcrS0+1mfVscfWCca4+ly?=
 =?us-ascii?Q?LxlcPOn8QR9CcctLbJM8N8HNp9++aZhUpsIHStjRmuPGXt9L6qMbU36ut+S0?=
 =?us-ascii?Q?oGrYk/HZleYxg07jfeH+rXJfEuus4EohWKJ7+TxatI/FRg8q+K4mHt/KpuEq?=
 =?us-ascii?Q?ObQwSnF2jWFz28LpBFrjerIABjEWSLs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56562319-7f14-4f80-3542-08dea5c77c82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:15:34.1026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW1g6gFs0QIwJhb3EnI3NQIkFfA+4oXVYXN3V5KFn2c4e2EI6UsfFadHaceLORPhEFKk0C2hobtNwhj2kysIaK7AKOELSRjTsXvk22TdDr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989143
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Disable gmac2 node with the incorrect settings to only enable gmac0 as
default for the standard reference Agilex7M devkit.

The gmac2 node can be enabled and configured with the correct
board-specific settings for other Agilex7M board variants in the Linux
device tree.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index f2150b7eb7b..9dc2c66f6f1 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -69,36 +69,6 @@
 	};
 };
 
-&gmac2 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&phy0>;
-
-	max-frame-size = <3800>;
-
-	mdio2 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		compatible = "snps,dwmac-mdio";
-		phy2: ethernet-phy@2 {
-			reg = <4>;
-
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
-			rxd0-skew-ps = <420>; /* 0ps */
-			rxd1-skew-ps = <420>; /* 0ps */
-			rxd2-skew-ps = <420>; /* 0ps */
-			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
-			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-		};
-	};
-};
-
 &qspi {
 	status = "disabled";
 };
-- 
2.43.7

