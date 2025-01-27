Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D38C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 04:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EC5810D6;
	Mon, 27 Jan 2025 05:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lKaS7FTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8F7810D6; Mon, 27 Jan 2025 05:16:33 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF7380F98
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 05:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R97cgCHQbezB+tZxbDzidIgRh8Nyu/VbPcsEDU0EYs4z6yhsOXRN9b1p0NbfZYF5Nh1eVACb7CSNCNZ/rlHbg7CtFNb1M1+9weQcO1WA8Vj9oHXzreE0mtP2LqLcj34FesGKIwWNSc0AqxJ+EH2bXuULVIkN0kcU90MiF9cR5/96wsvpjssd0SkbMWCaX619jFR+iIqXQDntvm/O81s0r4h/TjlCkBfhA3MLZPkUlm4rNT+RePXSnJhu0sJRD6PlYOFalZNE7gEdwV8MPQqsPPiWTlQp8UFyqIzbadNpiF6N8X6NoSwJ5X405VorPoRhsqUW5rUH6FkBW6j7Nqa4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJHYHuaxH1Z+v3C8f25DGTd2F0u4d0SbJGqb3AF9PnA=;
 b=Hi7TF2OBET5lhCqWMz3MbRu+N9t8Nh91DC5JJr9h/mrTNGznf97/6FMKr0n1cFDDz9TaZJlXTKYhRlzdGuugm1wy0QHCduKSKbv/Ce/igXjqbJFLH4bNNz0B3vSaYRNBvWNAmoR4+f+hJcJOpSySk7n1EO4W96ofXbIEq1QeONiicVfYPGpyKqNJgtlF6bG5+2kGM1raw3oRbEsuyU59yR1aqX4hTAnB4n55PFqi820i4sMV3yDp8kzCdj5nd6p0ZzIOVdU2G13b3QZtGm7FDYQATh/VH2CxstDjC0qnjwGpSRGu4r4QtR6svxs+nynil5xdPm7CYxbfyMDhvpgU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJHYHuaxH1Z+v3C8f25DGTd2F0u4d0SbJGqb3AF9PnA=;
 b=lKaS7FTGxxfW0F6j2gEJp6/ZDPcXrKl00lXxyks9RCeKrCycSpsYSLCJwBpTXCSvRitk5dXSRuVQxS1IXHdpN/x9X6BqBhfm4YFTvzztiWRd50VBjY0Y8OTNzh2zxrqwDVt388tNOP5fmspCsI7cUPpxGOIw/oHDOQ90Az5VZyLeVcDMfAvy2kCpfpWba3PFJCKdeUMr6hXdOUGw8ELaAxA7RpsAbKxyVrOY8vCbG+GmejkHGeH86X68XT97lgAhxvFCCLTxRp2PPOOWYgpsfhVRC6XMsNjBQBtOoP6bd0P+iA77IGK5vMT/JtB+aQxdwtkIlEAU3EK7GyFHaXcjpw==
Received: from AM0PR03CA0040.eurprd03.prod.outlook.com (2603:10a6:208::17) by
 VI1P195MB0607.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:146::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Mon, 27 Jan 2025 04:16:28 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::dd) by AM0PR03CA0040.outlook.office365.com
 (2603:10a6:208::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Mon,
 27 Jan 2025 04:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 04:16:27 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:27 +0100
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 27 Jan
 2025 05:16:26 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <sjg@chromium.org>
Subject: [PATCH 1/3] arch: arm: dts: phyboard-electra-uboot.dtsi: Add bootph
 props to i2c
Date: Mon, 27 Jan 2025 05:16:10 +0100
Message-ID: <20250127041612.985929-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|VI1P195MB0607:EE_
X-MS-Office365-Filtering-Correlation-Id: 8621a3fe-3b57-4be2-23e9-08dd3e895eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zwsBNyXyp0PrXDSwvmvfYPTqh6fLBilFG5A6MF7/iR3Wx8P19vOF8iCAGxd3?=
 =?us-ascii?Q?vYy4aWKA4d9Ishs6d731XfzD6MUUhgKx79BKkh02EN2+8PjEk5PD9lmPTuil?=
 =?us-ascii?Q?8ccqlYsxmqoSe3UGR2b4EsZaOXI96DAlI64iiB+lft/EQ48tQGnMBUMZUKu/?=
 =?us-ascii?Q?wgnQL4l9/YxHljYh8GfPjiz0djI77iGkiZRQ0Mj0PEo9YbmAHm+rm7GM0zc5?=
 =?us-ascii?Q?Ni4Q8hjlsaZS79/mOeTnkXVngecOhqjgXQkhLSoCBmKHdwWUM2WLNLO45ObL?=
 =?us-ascii?Q?pgqrCVGpl00eAxJESzuK0k8Bw/S+cbzqEZNqRE20g4SqcOEyf+moUe+e+lFs?=
 =?us-ascii?Q?gr7RcUQpdrpxezO/nrPrI6Hopjao7z6NT0+UgEkHUdt8sndkh+eJB+xJGssC?=
 =?us-ascii?Q?zJZ6sc2NgLm6RHYg8o4P81ZO83gEdEbIk485dEIAYsisGoLE6VM52AYbLyNL?=
 =?us-ascii?Q?DqMxFnMYZ0Y6YTcl73rwgJ7myyxE+FzVVw0TK7qfitXXkUeUxz+xy0XYgrxc?=
 =?us-ascii?Q?kriEr5ns+06yNkUs9YZza0666HtdaaM7SABrg5ZNfSniJH64knzoG2sS28dN?=
 =?us-ascii?Q?gVbZ3VJd7SsC/SdimHrqnSntDxZnu+cv8HQ1gmcZEx7kVmpoh6Zwz8X+5GZF?=
 =?us-ascii?Q?EdxZiRhrZmtOwHdcghQLYCgVXidHQD+H48MRTs0I27OGCw5JBxmlRFUv2d82?=
 =?us-ascii?Q?2DDtz61QsnYh6Y+965SqjGavHD089sIg67lUUv5wPnTGRAi9DrlnFw8VJfob?=
 =?us-ascii?Q?ALQb4rUHv3TgcVZcn2ycyDlIngKMlgDUTmmDw5bA0HKFpLmaggA0fvSOwVVF?=
 =?us-ascii?Q?tFVMD2rrtjgSGNd5EXSOtzz0DOUztkD5RdvBz5XZV3bqe97JuTb4CYk3mmNi?=
 =?us-ascii?Q?abXsK6p434J23LNkJ2Dx2xDmQ9o14yVKALZ4KPGWW0tz4ihQbjXqTihNHDLD?=
 =?us-ascii?Q?2raQ1hndp1L/hV7c6SOa1il//DMhNoFtKJqaI5u9ArWe6fNaCNlPcGD+2yoG?=
 =?us-ascii?Q?BNSQD50unFMGRtqZa5f6EoiXpPH790CFUNoXdd638jf22LwbbcWbijULYWmk?=
 =?us-ascii?Q?I5mv+iq3rbn9nwyj4l3TdftaSS9AL4BvtUXdTywjNddD5Fvq2+yQOBBYVCiz?=
 =?us-ascii?Q?YXS4FY7wKtcRMdP7/ABpruZBqTEpM+4ZwjeT+cmz46jlY/5N4N2ZoQ+F5wMx?=
 =?us-ascii?Q?2/nto9b9l6znRxo/Mc/GGULv2rEmYBZESs9KX3qflvSCJIgGKrcqYFKSXryB?=
 =?us-ascii?Q?6uG6H4LUikBHZNPM+mLs1BUMjaA4UNI7JkRgkvdYpivzFFO1PRHgFw1jB+Xi?=
 =?us-ascii?Q?188Id1Uk/aAMIJoGUHDz5IZ4f/abMGwaZwBYBfJYD66PxsH1oFHZ8KQO7Cc8?=
 =?us-ascii?Q?l179rnj5zP26Z76LxTJtEK8BBiwHV7Dho/n+fqT1zn6422xpJxCXfbYeTtHW?=
 =?us-ascii?Q?CvHGYsLTfLoSFvMQR7059dsgF+4LmsQkll6zW5nBWM4Ahe/dcMMybySou/5U?=
 =?us-ascii?Q?v+Nbk1v3EyduZaU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 04:16:27.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8621a3fe-3b57-4be2-23e9-08dd3e895eb4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0607
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

Add bootph-all properties to I2C0 nodes to ensure the bus and EEPROM
are accessible across all stages. This enables reading the SoM
configuration at any point during the boot process.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
index 8f3c3a185ae..c68a48678a2 100644
--- a/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-phyboard-electra-rdk-u-boot.dtsi
@@ -72,6 +72,14 @@
 	bootph-all;
 };
 
+&main_i2c0 {
+	bootph-all;
+};
+
+&main_i2c0_pins_default {
+	bootph-all;
+};
+
 &main_mmc1_pins_default {
 	bootph-all;
 };
-- 
2.34.1

