Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18A8C4451C
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCC384E72;
	Fri, 17 Jul 2026 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZDiQV2Gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5436284E6A; Fri, 17 Jul 2026 15:58:46 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7279D84D6D
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdLHqKt9Aa3iBv1IhSCCXYtAUT6e90uylEsoqw0l5M9+vnKkHtniLU2J3jtSbwZ/O+9bhoxljAPggQFKu6I99NMBavHKdiPv5ngkJNOLx19lCZm0fDMCNAYdHqNLg6AVUm9iSzVGdWg3gX6mgr24Oryc1PCC7qCfrhA+CJNf39GvpCMB7XSSi6vCLvVN0KM2Rl4DLg7d9dweiCvixOH+y6tANv67b66LRRtGHmt7r/r8kpJZGAtQwUeNbICz1+DeuLYhuV34ShXX8UlErArLfGRX3orB6zv2jL1pQjDGw0qovH5bTyWqC6/KXy22CKSrQrmGYB421QhCSmFexagC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65suFPXGKk2TqSW1OCPsOAqKaoT2OVGodMGl4cuPbDM=;
 b=gQDMzlQi7heEpU6t9nJQnY6OprRZ3KzYIikvY48vn5+7UZNRfh4UNRsommWCr0Pv7QRcQT9vXS+5a7tLPHs8s+9DzhZqONyx+VKc7naPOM53KUcJBvxkzMWXBrnTCafQNlXPGy/IyJKdUXK1UPPyjBUY1LO00VxcZh1wjft0bSaf1eJrP1jZIRU0hBxJOygpJJ4YDUaxhTcs/cCpwt0jQ7oE/4kQAxqWX0QzJ2qG+o9yL/IkeTX1UUsw8YdeJlVwsCyOo/NeCaUIt7VJpivBW8pBp1KIHtvlwHiYjL/sXO3lUWsBJzhArbWZv9AjBrpy7RJMlLuFQDOlG5ULsjFoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65suFPXGKk2TqSW1OCPsOAqKaoT2OVGodMGl4cuPbDM=;
 b=ZDiQV2Gz7Ny+Sh2Jpcrmf0WhTVyUYVsjRp7vyQUscnSxfh4uOJ3S5AwlQNDbnblfB7c0SUZKxO0jylbCs/owKydihXjTFiJpqPISxIqKfGv19fctw6TmyJ2rBaFlWcYPgjXtt2NZXAjbxGvhx4QLyVB2eVDWZMAHrcmmFu5jlrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS8PR10MB7426.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:58:43 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:58:43 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 4/7] k3-binman.dtsi: add keyfile_template node
Date: Fri, 17 Jul 2026 15:58:21 +0200
Message-ID: <20260717135824.2142135-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717135824.2142135-1-ravi@prevas.dk>
References: <20260717135824.2142135-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS8PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: dc887a30-5926-437e-059e-08dee40b8331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: POK3oZdjoXx70UthSaYeSP95cFO9pzkBoCVjLytYv57rQozhgbn794W/askDMvw9utueLgrCZGYx3zMjHwsUbGTFzZvZ/AbaF09xgyYH+OrV/ADhHqT23Aqx0Qrg+KL8CZ51Ouv2yy82UwCFo3fizIbHlN8HIuXoWB2Py/TqzHjz+gnSMo4ipZzq6Xqu2LGzW2JlRyxiWjMevPgkkPie0L1QIBVjAAshT5eGPr2T20742t9AUQOIYU038NV6lfcx2xpMzpzg801reF8qeZTJUF4p+kIy9N33e6sEc0UBGyw7RwZxVz0X2Htbb5xH6lgi5vdrjC3M7yQDSR7Vg3RwuEwmZJB8GVYlSfQqza8nrG1BU4vuYegxWAxakd23e6+HZ4GNX0RnHeeyK/9veqSd0JoK6gkM/+r4SG3vllFNKKWeuqH12vz50xBjZBDh9aa8TM1S6YX7eKdJ2mugweLDjcDRjkV1GQC2iNEkIPNSk4WBGoYdhf9CjzhXrcD4Dg2u6SyaPq949umiiFLnUWjunfmzL6tbDOG/ir/2rS+4Q2Bo83ZPzIFM1h+zSj16It4pLUlTT5Zk3NU2HDpS9OT0G7vJ4RBpyJv8jbzAYLQgRqxWgQnalr+dGpkEc8BP3HeoQq5pjww8Ha/IPH0inTIFIqC0pHpOj56i3WCuc+pWXL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rnJQ1XgXfa8KaAn2Qijj9AbSBzAl0XcxisoOh5SIg0707WXCvvZV+o2x9SZ9?=
 =?us-ascii?Q?Ga21WZALqQzgEwfk/Cg7FmSpNulcJ5eFuXaCRYLX4JYUPKUlGg7Z0nryGr0l?=
 =?us-ascii?Q?QzB3aIiYZHL2B3J2nnh3N/YHNLMLGoIV6ddSSfDxWOhNsZ7PXDApJjbGtBb6?=
 =?us-ascii?Q?RPdJpBQFwpI49LMigdJAKK9nSWTgaOKYrE48/hTB2WW9tSjMgJuKp3S81NDP?=
 =?us-ascii?Q?1kWMvEWp6qqnQcOtrbQvytS7CI4LfKxbmuzsy/dkMDAI0wcb+bmTystZiTgC?=
 =?us-ascii?Q?fvfxFiLB+cm35vZKlTuc0ODGBRa92MBPssiIK12Bzx94S1aK85vcez6bp1Lx?=
 =?us-ascii?Q?gyimQkd+AXFrwxX6q0ShqZFwSKExR9P79fp0jpRFmvDglhUcqX2hHcK92TO3?=
 =?us-ascii?Q?oHTuP2E/He1XrbxGHlguvSwXHXdvvduRCaTQQWZpzTu66U9M1Yvbq39tbY5C?=
 =?us-ascii?Q?xsx92UiE1ONJINyF8vI50LSq4F5PWY/eedaLqIBIbo6oeP13WHMqNNvvz16/?=
 =?us-ascii?Q?3JN47E+Niab95Hg6Q2jEMld84RI95hpvgpCo+FxrsCHMkm+0+TsvqvsosZGk?=
 =?us-ascii?Q?lHDWI/CtUbpvGJ1GlV6wK7+6E8d9Mu1PLXjN/46bVxNgcP/HVdLuKBUWIp3o?=
 =?us-ascii?Q?pTlgbMCQcEIzkMNDgMOvo2cRn0C2uVsrR0lapFMzlgNluT7Ywee2fAjrZ8uQ?=
 =?us-ascii?Q?qO3zJNfKMXkCmvqPjS1F/bANcmolBNCFHdiHCLoHgyRcO3un2A7RKlPDvW8U?=
 =?us-ascii?Q?UM4Cz2+TzLUzxIVCjrCXVjWOev77LBVYlr0tVUyAJx5vv4mBa2Y3ATeICjGZ?=
 =?us-ascii?Q?RlbCIiVEZNm4AeHgHMfUOH4vr7SsHXdis2KkyQzzl1QUWxe4Nk5UpX7H7Jba?=
 =?us-ascii?Q?utjNE4hS1k0bYR0/jVtZTYi/YSgAOMNs5//nG+mWNOXYw6uyQWNzlrffu4DX?=
 =?us-ascii?Q?TD+pytpCfiVn798uL0GeFPGTIhVWpWU9FFgVwnO5CxfEtt5rohkFFr5OtYud?=
 =?us-ascii?Q?FZ0FfOIQcstpl+wJ2oGIe0Znc011M6hWbqnIRb6Fcf2so/Tusf5JetvBKO44?=
 =?us-ascii?Q?j7nJIpDr8Rji4GwXSDl2eHeUbszU7M1ReHK4dX7jwpmhA025cQ8e+rQi2VEb?=
 =?us-ascii?Q?CziDtKwIDOqzFn6i2te1wpUJ80DVrkZxc26M+Xe7FnUgaC617JgieCcgQPWH?=
 =?us-ascii?Q?1KuDp/kMad9/I7trmSlllTZfzuBCiJs7sqIibmXQuYfyXPP19hfCo0czDyic?=
 =?us-ascii?Q?NQiWMCywNsEZgOLA1ygTPhehj9/hchylWMciIIXfsJ/78otC+PAK2jBqgck/?=
 =?us-ascii?Q?Szwpz/sZPuMr7aIl3HkiTRA7HPUsk5DLYF/XAsIZgkIX4IrC6Ljv4Nl5RXm+?=
 =?us-ascii?Q?mZQVOcWnxsBbiz1dCnJBvS5sKl5l2WasQl6bxJmdIftK90dxD2eW3+qu1TYz?=
 =?us-ascii?Q?R13bvIakJnDjG83UlFNelGBQ9snxQHI6DdjG3G6XWUvYhGjspk54u2SkxSP8?=
 =?us-ascii?Q?7JO0uIjrsqMgaFBko6AeXZIDN3ar8/ycbqLcLH2qYdocf6uMnMPYm9KSezeO?=
 =?us-ascii?Q?2cqP5YACaRX/OFjwpxfaxzPb1FB2Es8SxKO2RGeNxUrU/9hWFNSSnQKcbU1y?=
 =?us-ascii?Q?gOl8UQqXQ+z8u42+os0EU+VeHhuvrHi10W+9fIzH3CJRv5vbzukcsfSwHJjc?=
 =?us-ascii?Q?cBdcxcJZlZoGJZNQApCW6UIVa5IiPEJ9Q3ExVPWDV/2N8559H8cywEBSZKxW?=
 =?us-ascii?Q?YHLuiXv6DhhQ8CykhC28S6g4o/JhkKs=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: dc887a30-5926-437e-059e-08dee40b8331
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:58:43.1065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxBKWeCos7M7RoxeyET1LiuaxYcWKqqcLcAp/5HfkbF+MJ0FejQ8MZaNLIF9crvBfWFm8xe1B1clwdVzkhhEAjg1CJJh1VWfwmX4lYdCq2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7426
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

Currently, it is somewhat tedious for downstream/custom boards to
override the keyfile used for signing all the various artifacts
involved in booting on K3 devices to point at their own key. For a key
stored in a file, one could override node which "generates" (copies)
custMpk.pem in the build dir from the one in the source dir and point
that at another filename=. That works, but is a little misleading.

However, when the "keyfile" needs to be, say, a pkcs#11 uri, one has
to have overrides in one's .dtsi for each and every ti-secure /
ti-secure-rom node, and a lot of those do not even have dts labels, so
one has to use their full /binman/... path.

Add a small dedicated template that only contains the keyfile
property. In a subsequent patch, we will change nodes that contain an
explicit 'keyfile = "custMpk.pem"' to instead have this template
inserted. This way, the downstream board's .dtsi file only needs to
contain something like

  &keyfile_template {
    keyfile = "pkcs11:object=my-key-identifier";
  };

and that will then automatically propagate to all the nodes.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/arm/dts/k3-binman.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..69214bb32fb 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -25,6 +25,10 @@
 			filename = "arch/arm/mach-k3/keys/ti-degenerate-key.pem";
 		};
 	};
+
+	keyfile_template: template-keyfile {
+		keyfile = "custMpk.pem";
+	};
 };
 
 #ifndef CONFIG_ARM64
-- 
2.55.0

