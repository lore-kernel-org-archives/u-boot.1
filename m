Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9E0E74AE0
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A391F84262;
	Wed, 24 Dec 2025 09:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="fzrt46s7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0E8784223; Wed, 24 Dec 2025 09:25:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E772C841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZcMzV2ncEv0TQ9cJdJR9LBO92JTRx46kVCcR90MDQwhdUfUwJGgcxO+iG7kpiTtWmWNQ95mIB5ZAGsuslE8GlTHawqQ19X5fXzeFNGbN4om30KokazWxqEzxfG/gzgyPjDMekLe6UrN+HjoYC+E3zsk54lnoRcbUBC+rkQqbg/+3h05W1hLLRdjb3r9MuaJhTioTL9m1v3xwSsDtokVy+TqGlB/O7LqCVLX6Twh9V/zQaLFmzr4HhCGby0rM9eQmF52QrA6dyk8IB2tAflhnDa7hf+cCp0tMxdkrsXptle/cp0fuYp0yQDF9a4DNAicNgx4XFqGuNqiWLyeFEZinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bTzNX6l24YmXNHkt03JhltYk5IAdKW10/X9J9my8hs=;
 b=tq2MIWVyMg5ivCx/TLY5j8Y3TBRRya7rdX0skOPUBVr8jtxa5ef6d/QSRDaqDVXuOd+u0E0LN/lCx5BJyewgHFzh7X6IgLCdeLWNlOkVw/yWweBVKAHFoGuMGMd1BCAjGWruu2ddP31B0OwnBY+ZruXpkMVUIknFpVPiWEfS6g3SyYpM5nYQi6HCDMgYmdJ7B+a/4Gpok2Q3kO/gHZk+SiL6KY4ZDsOJ3EI7oYrDLBUyf2R45Hm6t0hudhH05mGHI46S3C95guNLOmxGEefXGnxjjUyHeH09O3VIxgSrZ+bNXWbPVn9C1peKdQwvrmnLYLVl2pcwCH8Qd7208plb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bTzNX6l24YmXNHkt03JhltYk5IAdKW10/X9J9my8hs=;
 b=fzrt46s7AVAfJ/5d+rcVhPl/cmhvI6IrE9PEjo0XXldqWX8galFK7yX/6oCaSXfHxkip5NbnATNpL1xonFkjwvPY7+I/I7pMXSCeF9hYxL2HkI1p1UlEBUnRXndgZpdEnB2Gg3jFYpDwk3/45GZPelZHXc/OOiebEXz3XjeIqMv19LfwdU+IvXPDukGgAI+v3YcXQQIgdYqEkXRwS3tZVu3eChv273Y6Wk9gtKoSO/Wb2JPw4a4uxsE+Xzu8W8+cuouiewlYFVubCFuhsj15Yz9XPKkKhUHs/eb/fTWeh2khwJye8BrZvbaDTEtBInK3N0I/pvgo5BoqoHMcaSyyug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 18/19] airoha: add mdio child node to switch node
Date: Wed, 24 Dec 2025 11:24:08 +0300
Message-ID: <20251224082409.1347373-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: cf081755-6d63-458f-9ad6-08de42c5f5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zgDdzpCT8EM+FFxPSbGowlhOUpM21VkAgpexlA0+K/P8D91tS5Bb3hXpY/pA?=
 =?us-ascii?Q?PlQo0an5qOzgq4NKttzXTJt51rePt3rT8cN2qgWaw0D/5LyMnyCcXpkZo2eZ?=
 =?us-ascii?Q?MIzFLc3Cy6W7r1T8v9O28LV4LZ+a/axYxgs2Xy/qHYUqdiAJk4GQYwPHPe5e?=
 =?us-ascii?Q?wPC3kBO+dUJHmVFOx+Jsx7Mp0lrfLRrbigjzmBFEBLPoicQsLF7zYlsOAKkn?=
 =?us-ascii?Q?jGY+MsAh9hZOnviUdgVg0MY/CrmtYs//sUUQKMDZ82dynKpLzOmJD6RMGs8W?=
 =?us-ascii?Q?cq8Nl/p9aPGgb46GxB3ZYpi7zOiH6CDTc+aCmdA2QtPB0VrZ9xFTGFoK8Z64?=
 =?us-ascii?Q?MZuDPdKVMbvNKuWF77hbNjZRLp6RtX3A4P5J+8kn7+0ysYyF2WY0r4Qbx252?=
 =?us-ascii?Q?FH17S6fgHU8whQ1Nm70WZAE9KRs4TG0NH+ZylEf0l87fT+EMAmqfa67DBi1F?=
 =?us-ascii?Q?vKhWZOSJCOdF32vv30a35cpCXIzfgKbW1EzEr/TVfhDwgyk9/qdS9Y/p9AcN?=
 =?us-ascii?Q?tAHqKgIVRGYZFUD1HUUUtCITkaxNbEVZpTHToLt6JrBZw9/3S+L/Mphs4OFz?=
 =?us-ascii?Q?wsFPI2b4ul5sWFR/KmlQDBgW+YJ1qVIMlZlsdkjROV9kHUvvG7q5HuIg4JtW?=
 =?us-ascii?Q?Ow0n9cYoqBI3ImMkRhu6TPR5TLy9wEyQmukomx307RKPXOPwdUewgk5y1kLS?=
 =?us-ascii?Q?SsCfuqNyP9lWjl/l5Z8umFaV3Adl8lweIkkGPZyQB6qHeddZrifJNvmoiOvn?=
 =?us-ascii?Q?zUZFAOB8KVdQV6CftkL/6pifxRi3r8dCNH1Atz38pld0RHd90WWPQ6gUGtVo?=
 =?us-ascii?Q?OCFC4Ly0NOU2xOe8b8G+4xvPrqGzhYgYQwLK+rGdYR7KIMpzHjhP+1B+hnL7?=
 =?us-ascii?Q?nn4nBzPeLuNRe7jPB4px9ZCXPxd38xr42Az+40QCrVTjfT6hFx7neaFUELyi?=
 =?us-ascii?Q?VXlp3RHOaojG2wdtq6pgt6OVbDq2/Q9aI2htfmLQWtIs5NVnrBJghdMcg03D?=
 =?us-ascii?Q?yiIkt2ChtWWhJ0cs0j0fEc3NAjxNP05hWb/4dfCj/SJYvWK9FloSTa+lX5Bg?=
 =?us-ascii?Q?pKdsyIWmTTk8R91b4M9mLkawKBisNUkeeJqMV9QNCWZloBBH0l5/zO8wnkbk?=
 =?us-ascii?Q?j1ayWRYmVwHBPDtVH3sRETl1eknbm/5J4Q6j8ePsf+IZvTKCVSJrEBpMAEer?=
 =?us-ascii?Q?250v+88RQ2NkJXWfTVOPOsOrOo4JJYFDHcKFKOQ8vUzjqty1Siu8DCQd4hS6?=
 =?us-ascii?Q?Ka8GRlcRmb9RRnHOiUoxopKtg/CWdKOJwGOXQDutAov21PHzJB9Kec95sjf3?=
 =?us-ascii?Q?9gB77+ECbtuWPg2RC2g0t3Q4KG3Ik3FIGm5kW7GEBc77XnZ+I+e74IduhyE6?=
 =?us-ascii?Q?XB/29F/h26C7M4ELeHySC/TOiDNNH10fW7X7nskvkrSge/pRIxSQjGD5fZmS?=
 =?us-ascii?Q?Qyg56FiOUXf62FnmqAuT7A/ZGRc8E4QCPG1Ntl8t2Pp1Ofjyg4Ycx/nEOZJC?=
 =?us-ascii?Q?oZvmxu7Subf8CgZM+rru+1U+wRcHOk6/FKdQOgtNnLsYDJWJIxVprn1znA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfDqXZ23QiuGf2KMn48x4zHbOujv/101YwQJyFXlrnM4OvHkfwt/k6wA0VlI?=
 =?us-ascii?Q?QWcCh3uo05G2r18ak7kqQtDoZgi0uKyV8XBXY+jj0DPkViqaH0aWlSt1Zd4Y?=
 =?us-ascii?Q?+EXj9f5BgJHITINogWmrsL8a0I4Vs69VcY2TSbxIQJ8SlUdp7ClRJZqBmgrN?=
 =?us-ascii?Q?kH1wVXRwFBmt+9iMhz6byVOZRKOEajQR5dopeBSGK14saVs9BRrDhCld2E2a?=
 =?us-ascii?Q?lIS6U4M5gE/jpWTIrVjPUwyoJpo5no1+4FZ8dTnxqiL9bFEKUyHZQbkhBsY/?=
 =?us-ascii?Q?FjBHj3AgsF1TJCaas0L4DnrN10FFmDp9WL20VzyxLtE16+2dj4Ognn9DMBIf?=
 =?us-ascii?Q?8Bs2Iv9t/ft4co0VDoiSk4J0zRz80Aco1UuiTYP1YWWBQkVFAZ2bd/XJak1y?=
 =?us-ascii?Q?NmqePN8hhRohIwXLEGX6qHskPPjgC3Tnsgn00v5mLAQtrMQdjCJKMvbH4O9+?=
 =?us-ascii?Q?N6apNge3EfohIblACCPEKT4qfQySWeBTayLSa20tpzWdRs/xjlTWc6RNtJq+?=
 =?us-ascii?Q?orKBkFCRkgXNLZJ85K/wLNuQ4eJ8y088fXSAov80cpRBb4Zfe9x4ilNNv2Ct?=
 =?us-ascii?Q?q3B7iMDoF6k5KBwL8mVGqVOybiJNdwdnj0xUMyuZDl8HBULumG2+XWe+HxAB?=
 =?us-ascii?Q?wmyCRqdyd8NmVhaf0mX97nhzSbTGHkhUEjJYJZ0UiFNKGC+0WYc+261Xwxz5?=
 =?us-ascii?Q?abhJcSwrC3DycH5CH2W4/kkBewbvMLTlB0LGcohWUZavXFFs4/wkCiblI6OM?=
 =?us-ascii?Q?QnI+UZN04FIyFwciZ2LwwbXDWAZ3IXcq49nGY+TY3RkYsOFz9D78c2XBCS1f?=
 =?us-ascii?Q?s4TJz580ZPtTVPKWo5CRAVzGrIxGKaijVb/QQBQOx7IJ24m0ERxXvvkyLydt?=
 =?us-ascii?Q?esEGKaRTn5qep0jur5IYVu6Xet2PL2OiDwRCSnG1oE0qrUXcApLn1c5byndp?=
 =?us-ascii?Q?tLj1diluvd0czy6bahJvrjAQ35PwbVQNyOVA4wqw9Ti2yQqMOsdtoPxGwdyP?=
 =?us-ascii?Q?mXpDlf7B3GDofLOIOcJNRQqNg2AK5nH6GHeHH9x7upkb43cnoLI5iFCio4VF?=
 =?us-ascii?Q?dR0TZLnyy+mLDb8QDx8+skHtPqBGEfuio6Mak/LFCd+mnn+AOYRdr/WCwKQw?=
 =?us-ascii?Q?7pzq/GdM7MQwyg5BT0b8ujH0wVt7gaxon/VcVzcXSitAH6DibTqLTKLpCPb8?=
 =?us-ascii?Q?YNUssE++JS/fvTntXBooppOfeXzepCu+t+PmH683vV2dy/9o0zN+5mTtajjb?=
 =?us-ascii?Q?fbckqR5nroRE+fE6x0Z2sZCO6mJD1TxSzQjoCw4/ldvVzIPdTcTYxs5PpJ2C?=
 =?us-ascii?Q?8+4jB9JT5nJ1Donvi7QGtl/8m709b4J9roMA9WvJ5s9RIzDva9LxZtKpzHdb?=
 =?us-ascii?Q?T5u0LmDdUju54R7v1F875zBHsWN13+PIyO19AuQMGI41nL7hh7Veu3y0wXwX?=
 =?us-ascii?Q?kl5HR5IsyL9xRX6OBfuBAtKb9wCmwa7RvOGCc52c1uS1J5n3RPynDlT1+KZm?=
 =?us-ascii?Q?c5XXknwlcEnh2jvkGciWi+Dc55JLFf/8xuwy5RaA5P/zW6mhpKbnDMkGKnIA?=
 =?us-ascii?Q?H3F4gBQ1NUnmCP47HRMxltagmpXdC0zXvf8QygdAw/zzRFo4Hd/6hKzNgCIz?=
 =?us-ascii?Q?Y+5k68Hg9fYPGLxm/K3/SFUVmbYqs1ChWrtFGEEqs97cRCLgdeoWXOUK/nQp?=
 =?us-ascii?Q?cCX4TV7T9yQYXhfolinRXiG8q0E6k/iB2qJmP9OFqSkpdSmBQDYgh3LjkS0h?=
 =?us-ascii?Q?GwMYNmYbyZVazWUfmFloYYXY96J9wtU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cf081755-6d63-458f-9ad6-08de42c5f5d7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:13.5744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogSuDYHFSplM8GjSukhQRRN4LTb6KM/PP6N9rf0lwp4sp3/whXPH/MkJU8dfUTiZ9nkaZ0/x8WPMmuNoFy7TgTWtZO7M7OtxHkUatMNsR/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

Add mdio child node to switch node to reflect upstream DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 5 +++++
 arch/arm/dts/en7523-u-boot.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 9ee0f808660..4548076b96a 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -128,6 +128,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,en7581-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		snfi: spi@1fa10000 {
diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index a403e684adc..62d1a724678 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -55,6 +55,11 @@
 	switch: switch@1fb58000 {
 		compatible = "airoha,en7523-switch";
 		reg = <0x1fb58000 0x8000>;
+
+		mdio: mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	snfi: spi@1fa10000 {
-- 
2.51.0

