Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F56C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3033C60859;
	Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrXZh7MocOxf; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65B0960855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059894;
	bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bFe2HBQpwtNfJKR4yOCZE7+0wSeghL7NAGLFlpcfjKyBLOcB6pOQRvkzbk6yJFIvp
	 6W3k6/FQ0uJYc9fFiJLRJ8f8Etp6pWfadoLZ5QHWhMgis685CewWdXt1SuxkI7FDoM
	 c94ehFczI7BOq+zoQ7Nf/7Pt+VE7UlSzZPZ3RZTCRAjc49oDAgJYrTF5y8P8IU0ekf
	 573A8/tD+vUOqsL0dtHD2ATJHLkb0RH8NfzzgYWC1yc7Bl02bnW1cVXGAosHp5wI4g
	 YOgm/l+LzTLCjqSOszIAjBkXApTX2BZo/qc+WRwGpwNjmE+oM0cTUYOP+R7/2eccH1
	 t2SJhw02A3HFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65B0960855;
	Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4002F392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 260C24090A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_zDlqbDY2UW for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E0AA140909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0AA140909
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0AA140909
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1fIImSDDFmmE1wmdgR6tpL3hrapxSSxNOHxrmb/mLlHStPJbiBup0jtNOedY0pmk82dR0skhHXVRxxnUmwDshkXi6puqMr4SYvdTu8rFUkyuRt3IvukpNM0l7sPm+enSm2sPOpGtYgRe1vp4ImBdHf/WARBYjDtYElVmWjpxa6kjyICGa6Y8D3E0ldnHoxz0whwbWbs31PSReCS2RrCsQ9EIg1mBj7Cjz6EUHKFkw0Hv1tKlBJsCFNLWTQsP2xMp7ooxnJ0yCPwPZGUyuRj3X1LpNL1tJoNKkvTDnAjOK0QT1rFcYINCyMLJeBfXbAbYzNgbH0iIeI6tCFkJE8iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
 b=huSiPRind89C1nh2QUxQIp9KcsdiMVwvT89kVVwDG+c8JtHRtD3pan0u598jjzO03aAaWc2Wr8f8qK3SITnoSjSe/JaWXRXqv8Qp8GHhXMhoZ1YA93OMC2CFwUIoS3XIiPOOMtTICr4/JOuRSZ8kRDiW/xBwdNny0O1UenkYGFIE9nuVs4xozeIfUHZGo6Rcby9ZSPidp3Iy+FuIVVplhxT/NKcOSjpgd03K1u8v950Vm7/hFhgk+XYxepzLel8rhrroCe92aJ8JipBAUPUKUll9oagnmswHwtqffBQ37XDuC6p7/xozvai6db0xocRcCgjrCTtt2FgM4xIqNDYfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:42 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:42 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 02/16] arm: airoha: introduce AN7583 helpers to get SCU and
 CHIP_SCU regmaps
Date: Fri,  7 Aug 2026 02:44:18 +0300
Message-ID: <20260806234432.4098414-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 545fc666-150c-4c92-1356-08def414afd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZFWnBwIoyLji7KAhoSZXHsqjYtDUCzIDo3LSLkYv+RpIO6smuucuR2yGSsdnlV9JJV9APMOLEYoopT3DwJd1uXMBmxjRF6bfQdTa1RMM6XH6/1X5H82Wo/JZRIhPiJs4fDZNpUmpbvMTB1objh1FHJP8IP3Za+553JkqzAr2Sbioje+WOXoIFk08Gv1852Jgn6gU2OFcXJ1QumW6Y+3b48hQY49MYSOao4B8RFIOokM9B1iCmM8rXyR0bO61FfK8JKXKfUz47uJN+C8FMK2tBhimYvO9Msbcobffq/29TAOvgIPYtPz2X7IJ6Fru1G1yuEvpvghcH5/M5yAWFBqfDWl8U3WtsJr85e02C5/CiP73uoFkZFGg5XUocktA0DZc6bPd5v4G7tAgmUA7/woUHCZj0ssWNXp6VErLwnRjqkYjUxKf8RWY6IMo03x7pAGnwuT44/M4lsyQf8ep9Th5HDoYKN/TdGvRTcXWj/2if64W2VP1mkXGzI1UQ2Nb6iAFBG4KCYhL4xhLb+U1SS843wHi4c6s3M0eGoZylchUjbzCpQBqzNCJYU/VHKJgf4nXMJzj7Ic4lcI95z1g/A3Rjmrsc2VkcA2ZLdURBKbI7se4WUXBzf1SGzvE47sUIM032xVkOKIx/TqHl05cmNDtk3Vr5zhcCH+EkcEyXbc5BrwsXUPQn4b9wiZxt5aRzHna52gpasirZ76SxY7VZhenTB9iv+7LmjPTjSNsasNXTtY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0sDU+HCy10omipdhMo0oPUwTQVimDVNUzEhyAXKfZwwYbkeMD9aKcJBFN6l?=
 =?us-ascii?Q?gL3NjktWtidE972EIZrfTBslGbKHPDydr4/Qqjl4iEBeWdosOStEvTldsKLt?=
 =?us-ascii?Q?1F58fZgl2bmhm+76KZBH52tWuyTXDZ+C8LkROOCJEZKNmD9aaA5FmUr6+I1i?=
 =?us-ascii?Q?ePiBsIigk9yMQF5ZOkuG6GLMh6dFkyB6YgEeTyIlg2N71xvQWns3tSwTcGTm?=
 =?us-ascii?Q?4a1+vybIY9EDoHEhhqgJ6JEyzlABQtWwY57PWA0AgomlXPgrXcRbqcK8TTuT?=
 =?us-ascii?Q?e2Yuxhpb9t2CQIzW09yuvCRq6WaF8zE8ZBgv3ZZaKgHDRMgVIASh0L406ylb?=
 =?us-ascii?Q?O7HGW34Pnya89V3+hXWMKy0criiMrQZFdxUJjjNUDpge+0kNqJlmUu+ADzJn?=
 =?us-ascii?Q?g2vmMtIkBYyAxR26nY20It986M4wAjzTQr90kd/jmoKsyqbyHTZ6TEPCcW21?=
 =?us-ascii?Q?+TzAqurx1gYD+yKapXrib66sUA1MZn8YfsvcfPi+iPmCPQAKSzef7COrAHW8?=
 =?us-ascii?Q?nuJH+G8hJotYDJfqUzRkMrewzMliOmhfvTPgwHgAFS1dA2VDw55lABEAyUoI?=
 =?us-ascii?Q?XK5TzaOw0CSZmRC3AN0y+aOixDbsH8b6VAnY0RaJ6uQg4ITMUdHvebbN/SUB?=
 =?us-ascii?Q?ZbeWgUnbgDPs68JQykAIE4WTvxxo0E4Dka2QV33TGavlZy8+Z6lX9yHibOY/?=
 =?us-ascii?Q?aAUsVVBy05m2nkqHjzHEjXZi0jFDjK6pKDwd1WmZiYboCOePE2Cg+txXB7yB?=
 =?us-ascii?Q?VI94uKTDGk/5YcuaoPtRpfjkgf6uJEjTbX/HZwJHqwlMm/GfRWZoK1H9dCkj?=
 =?us-ascii?Q?V+H4TJWbNM9WegmeMU4Y7RVQgY4QzPk6IWWnGD03JkWhGbetzhO3hOK++Fy+?=
 =?us-ascii?Q?y5jHxnDsfxQxHVX+5DXO46z88qlIDFSA5yx1REDRwo4GJkVi3x1vhlyRVnVL?=
 =?us-ascii?Q?aaGJwJUNyOKm9qJpkTRTJX0FBum8zOBKKOdjXMQKWHdU7DyOMmxeVYfQbrh5?=
 =?us-ascii?Q?rdK452LqR0goX6zJ3N7ZyI4A4tD1p32EIbKXEABtCYvA1I2sW6ccknVSs9c1?=
 =?us-ascii?Q?fzM1YrTYGWh+wFqCf3R5FMssa0h+SOQfTqCPdKoCHZvd6/ojhYVdzX9yNTzr?=
 =?us-ascii?Q?BkKqoxTJjOcoHJyLS8lnOZpytRUix3DbPArK7A67oxrkp/nxh2H8keFlfXKu?=
 =?us-ascii?Q?j931TX599uISV+mb4AVL3TrWMY5SaNZc5zeWNw2lCnZw7wrgyquIuA1/Bh/r?=
 =?us-ascii?Q?jRJ9+awStu43m1g10UTvhFs1atMhFKNtJ3crm7e1nPt/Sv9/DZnHhS1REfOD?=
 =?us-ascii?Q?KPG2VmuVmzHP1/Gy9yYZnZvcHzh3idodRbw7EIzK9DGSWUnGdRYV0KLUpYDL?=
 =?us-ascii?Q?pfz78LwBRWc/hN5IWU/txHqVjcdE59AieBv2XzEatueMwbiyXuiHN4Kkpqyy?=
 =?us-ascii?Q?/PCVX3FlWct7JF0TJ90vSNtRkkc2e3O+LVviyVO/XZTjKRj4SkLcGxkioQZt?=
 =?us-ascii?Q?r7ub5e7Fs5GtFW3/vU7oH7bVj4WjPcDHpafm77eBWxLxczr2E24vTHSA4gDr?=
 =?us-ascii?Q?uNGOIk2G/Lu680y86BPmCfLN0f0AFVx4/YIHFqnjYlF9vUu+vHVK9XJhDjYn?=
 =?us-ascii?Q?2kYLbKMiledkc8jUjUIVj8mBm9HX/G4h6z5I7DEbx4a2d6VMa1IepaSDIc6V?=
 =?us-ascii?Q?JqlDP9PfDQrv7qZd+kh0tr/wXHpbD+jy+NIL01JHbLw90X8Ay63WEycuXEsb?=
 =?us-ascii?Q?sV5ytLY5yZBdf+3OwKyjkHUxXhKVb9c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 545fc666-150c-4c92-1356-08def414afd9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:42.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKlKQTl+kP8PktrTdTGOZ1bCRrECDrTaQlwT03p9bPOAl8C3XMcx7sFv1Ii19/RQKWUXh7DMpq+nf4CqQIdN5DUeBtU1Rp6BqdPzKFAkWAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki9Zo/sSS49EOJ2DLIsNmG2k94TMhmqGs1YVTbmXrdw=;
 b=OE/1QPhawNkUVngXT2ZfOvX/hG6oQHlcsQ50ybvAD0JaXBIxaU92/tws0DNTVgOG8sEsIBxhvQNpHrSXFmwqvdTMW7ku7sd7vDZlr9RZqFMW7JjKkd/t55Y8AKTTtAoKo9c6gLnA7v7UX1xBc/B7ER1eYoBuwN7ReZhnbIey67y2QOfUB70JHr2+R8yrmvqwzMOH76Nk+/o8DK0XaHraWeTzbDK8jC+tUbupZzb0s0BSaxFQwKFVv40qBkEFwYro6Z0pJRCk7fgpguXiTvWV3ZmF7Pu90dI0ywsFmls1dENIZqW7LT7+/lmo+JA1nUw905Lh9tlGirYdkHAfwKtn1g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=OE/1QPha
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

We need access SCU and CHIP_SCU regmaps in several places (clk-airoha,
reset-airoha, airoha_eth). Unfortunately these regmaps can't be easily
retrieved with a common code, because of different Airoha SoCs uses
a different dts structure.

To make life easy we can write a commonly named SoC specific helpers
for these tasks. This patch implements helpers for Airoha AN7583 SoC.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/include/asm/arch-an7583         |  1 +
 arch/arm/mach-airoha/an7583/Makefile     |  1 +
 arch/arm/mach-airoha/an7583/scu-regmap.c | 34 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c

diff --git a/arch/arm/include/asm/arch-an7583 b/arch/arm/include/asm/arch-an7583
new file mode 120000
index 00000000000..d2317ed3bc3
--- /dev/null
+++ b/arch/arm/include/asm/arch-an7583
@@ -0,0 +1 @@
+arch-airoha
\ No newline at end of file
diff --git a/arch/arm/mach-airoha/an7583/Makefile b/arch/arm/mach-airoha/an7583/Makefile
index 886ab7e4eb9..51f978aa101 100644
--- a/arch/arm/mach-airoha/an7583/Makefile
+++ b/arch/arm/mach-airoha/an7583/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier:	GPL-2.0
 
 obj-y += init.o
+obj-y += scu-regmap.o
diff --git a/arch/arm/mach-airoha/an7583/scu-regmap.c b/arch/arm/mach-airoha/an7583/scu-regmap.c
new file mode 100644
index 00000000000..96f3564eec0
--- /dev/null
+++ b/arch/arm/mach-airoha/an7583/scu-regmap.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <syscon.h>
+#include <linux/err.h>
+#include <asm/arch/scu-regmap.h>
+
+struct regmap *airoha_get_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,an7583-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	node = ofnode_get_parent(node);
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
+
+struct regmap *airoha_get_chip_scu_regmap(void)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-chip-scu");
+	if (!ofnode_valid(node))
+		return ERR_PTR(-EINVAL);
+
+	return syscon_node_to_regmap(node);
+}
-- 
2.53.0

