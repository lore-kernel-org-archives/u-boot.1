Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2745CD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D64FA8341A;
	Tue, 12 May 2026 06:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="J1C2bjYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5DB8394E; Tue, 12 May 2026 06:12:08 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAD883015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 06:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd63WOMlRxYS0bpZd6SRwBx7WgbXjG8QC5bcKaxbGxIjyNT6hsfnT4jhui9keHTon4aVJjsL1hdQjGntQZiSMDn5siKJokHkwFcIKuA8ecEcfL6HAIKaD7eqvnHsKoYmBtwsilmFTaaxvPkEG0xhhs7WCCk8gUEpWovPek2doTCnUH+C3PjTcazHzS7ZT/PCBwOjMyiWgKxmi3A3PwNDY1fC7xzKgwhkewz2pecFd3sIUbBTqwVJF6MYS2HXaJnErJNOph9Q7oVZvCtHAHiWWyi95iVgIjU5N0KOWQIeYDVpwbbwqXsZNqLbEnZQCi0k11PlII2qRwKjK1oxWI4+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVv0uQVkYfO/IeOe2I7X62rZgTgsPmNbjuYNwzuj0hU=;
 b=xM6XLaWq5QuA5I0ZDmYjU8rBiXm6UeeBcSnu2XInlcKhs0szIvjfH0otvtm9SPzpXyCakLoLWC/18LUtuHKzgXCUSoGtmmlKq2licPvog/xXN0wQp+ygKaiRYBJMg+QYnpNKGhKK/y8qn3zOolAEnPQJ8Cmm6kzhG9fxGoghEtpsponzI4TGlZP6sJqDS/xLZC+ezOMBkvOxgXSOI06cJA+ELntXJwyLdvNwD/LbqZnuXPGCJXrC1sYVmlX18Am7s1hUYVXhcbOw62aFquVmCZtOWX/nKrGJkNp3gt7wtkrsFjHpptfj8+nN6eCKmSSQVjfFBUJrNiGSPQkkMMKhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVv0uQVkYfO/IeOe2I7X62rZgTgsPmNbjuYNwzuj0hU=;
 b=J1C2bjYkJQCmRzBERu0TCeSKkado7JKN6n9T0BQlRJz/5ztH5aiX4geeG0MYyA9PQDdE17MbkrmtLv7AQXAfe/cxCoFLbxKPGlN+j97Hf9HZnelkZF9pBF7UiP/LnDpGQ2I0sdcOZc/UwB+BPs+Z00yzovKBdhbl2OKxnmJbRNXmpSFBAVZekXM+cb8w3Hhd6num1xaHpiKYs+JsszpYV1LLthMakgfm8fMC6aC19YKpcZnh0VTf3L2aZhhNUXTFlD7nfR+x0lo24PqYzGVr+HnXw8D0xgbVjvAMtObnsRW+eHjeoUBwOxdCZ1XAJ/atTKAfSGxu48mpAROmZFwNsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7346.namprd03.prod.outlook.com (2603:10b6:806:382::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 04:12:01 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 04:12:00 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: dts: soc64: Remove kernel node from binman for
 non-VAB flow
Date: Tue, 12 May 2026 12:11:48 +0800
Message-ID: <20260512041148.32021-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: fae77fd0-3c78-4315-a782-08deafdc9d3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: vfESXsochFTFQnaMunm4jHneRnYd5D++gYi0GPCDYi36zz0UujY6pCKFm5PA2RuEhi0Tsa+Ap8xwQK3u6Go5XA3/GFgE4DwgiRCNab+Tt6FMl1ASbsj0w2l8P1b1PdIremkg+tAGDxmoJOTf2Y9wyuZsfBaCzlGJkgf/AJeLcueue9f877L+oXxRgf3Tb99jfKLZQqgXjqxrg2rWlSM+JVruI+jFEYJp8NN/wVk3UZTvFlVThwgyCgooF0Tzd5MHZJEcEO9vGHIHhYhtRqX+2+J8U4q0Q28gVGMBuDCywZXlbiwuWps+KhlZYkXTXJnwIMtvCF718sUQjRr0HgOKQPAm/QtEGKPy71WLXO1UjAkq9jl7xB/ZVP8/LtNfBf7ms9ArmZki4U66/46WhbVryfjmCg8l34iy3Qb5jR7AxjLyJNC9/uuo9PObot8RidkSo95Md5xxcgfNCcpUKmFUDb2tAS9+DasSSkXoukAxmyPVUf9leka8Gdq7CoQRpY12uhpq4e7IVjcg5tiMP9uVRAvEub+j8sjIh3PS9RZz2BJXOrnR5Tf9GjUqskadP06sm7JnBy/QMDQfpub23qLsclktl8WygIdjVO0ov/N7wV+UTcRk4vEIBTaf5oSGsPGgUzGgYkASqdtrn9q06vNywWkLY6rTzL7O3UKejYwFVA5Pa5C4A2+Usaxo13lasNeF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWpVB1TA6YQm8At8ovTN9z/JnZpbwpnxiATHjxlLUvE/mrjUxWr+81Skvel+?=
 =?us-ascii?Q?ZLHD+AbmvGta6sthYprKpHMhwd5jl0cXjtQ5znfB7c/vHtcvYbggD9IUuf3a?=
 =?us-ascii?Q?iQXd9uBrasxhUbW6uQlg+qjWnAEQkSAciciHb9XubOoaVGxc3wQnq8sXkiIt?=
 =?us-ascii?Q?ZG9YQLqjJzSS9P7tvo63PaAknE8NSTcarNJ3wEOGEi55JfjR17EiqE/Q99vs?=
 =?us-ascii?Q?025mHrGjj3a0dYPJQUxIELl2rYewusgJccYi380CxkfnXJGPU3/8B/3HT3tb?=
 =?us-ascii?Q?njm9U7v6MtJG5zW0eroZTP3PW7DbXMP50u+FGR/JMRYN1V4oBaeutQVCRNYk?=
 =?us-ascii?Q?oBt25c20mLSEV0jZ3baVAHe6umgH0ABR35Z3ChXOBcSO38xzYbWTW0H0kBy5?=
 =?us-ascii?Q?g7/YofH1r5o4F2265erdYI+bkuHEJGqqZlKEc/hDarjORoLLReCws08DzTZm?=
 =?us-ascii?Q?J4ZXXW3C+qEocnQF9Yq8S40dvZbexQisuQrHtd9yrehvGTpdZl9LjiXDnWn2?=
 =?us-ascii?Q?UvUfmXLT/f7gf9NJeGkXHV15EYeqZ/QZ+9Wxeg2t5Iw5tts/3QYegVDQBbvA?=
 =?us-ascii?Q?yVK2N62jxDgLIeLd8PyED1b6E0RbN/MGdoPU/r6v+eBDnBLj2P32mBjQs5SI?=
 =?us-ascii?Q?u0XbDWdJwvorP1W/xqiiK/MlT+upb9SgvxUA28z5NSPEZusLba12duea9XZs?=
 =?us-ascii?Q?wRz+YmpBUQWH/6n5g9OcGLNtQacYvT+AI3NLyyv0QVwdaGm/R3JljMj0SDgI?=
 =?us-ascii?Q?2VY5Z3nI8FSnNsen9R9zlMS9m9+4vrHyrQvt+64QbsS0Y98AiNYBrOclWnuo?=
 =?us-ascii?Q?Y3qrLE405LO7rm7IOSLDUEHlvQAXCUD9U/oRoF4U0Gm+dGl4xFCGwANnb+9O?=
 =?us-ascii?Q?jxj0zMT/YasagSa3nfb6L2yOtmK+CFICCbLRBYLbHGCoR0ctuEaHV4ZEL6Gk?=
 =?us-ascii?Q?5IZIqZOXtr4i1OtrkwbxS7UmpsRFQrjyD1d/FGJzN9gs5fBjCklMJimS/6tj?=
 =?us-ascii?Q?wDKLAuXjewUWWsToxnK0GaWV1X3c0rbd7MdDwz8/xbnroz0a0yDqiaZnmsQD?=
 =?us-ascii?Q?fPvEmjur97tIWMthlNeWIq5RFhyO9Z2ZLwIX0u/BpS9suCiBeOeBnhWSo0S7?=
 =?us-ascii?Q?hQfj89GwuNro2PyVDUQT6Whdk6m1ShYc/WCVLYDxvLOwMdpf8t2kTNgz+Fti?=
 =?us-ascii?Q?PYHBOppRYpkWDbr8M5g63c9DUqCxiuu5yqqjFrJmBJLURdV2zcQlKyQXi25L?=
 =?us-ascii?Q?jzSPv07oKwjyPDqqStfQMUnkHc9zRawIQNTAea1aMcnUetBG2kVFOO4nk0Ac?=
 =?us-ascii?Q?U83WTpLMn+qPSYdw7m9ITCP66oFLwKhsIZMLdCdocCgM6oHcUG8X1xpwS/J+?=
 =?us-ascii?Q?Gcy7GwGga3oe48oh55ag471ZmChm8j4Ie8vp0t00qQTcXR4kpw1z1E3rYlBU?=
 =?us-ascii?Q?bn+e4cqCIFn8UtzIiuXCr7Hlp17OdmsvaoCzzSGxFFVfkCwxZHKpkr48DTA+?=
 =?us-ascii?Q?5LO3QGd82oSTqJkbznJqlgWeS7SfcVgFo8qBoPi3+TNUTqbiHlPNVoGllNPj?=
 =?us-ascii?Q?1tI5vYrBmZvNEidI91DoiKK41jeEdXHS0gBesU+uv2oAxB5S0z6UHznUsPqF?=
 =?us-ascii?Q?6twWI4rwl+/CafYCcdekhzwDfT9E7ZhFv2s0JSNutylTulbKTbvRiirPADtp?=
 =?us-ascii?Q?IlGiIoNHNgeVe4zQHPFhbStm3sTOBhCBWB6mZnHYz5Y712vfsFY2uZ1TPZsc?=
 =?us-ascii?Q?6PJX2ISvQeh4XSjCRM/RVKAxOHIw1ZM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae77fd0-3c78-4315-a782-08deafdc9d3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 04:12:00.6564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4kn1K2UPGW/f2BOckZ15J4YLBiciqVYjBHhCgyb02rscdpC3HBGXsQ12w9RPbReZOAWMR1PULFw6g9k3zCmhJcLfjwfUIbzEHndFVotI2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7346
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

Binman will attempt to package kernel.itb during U-Boot build, expecting
Image and linux.dtb files that are not available in standard U-Boot-only
builds. This would cause build warnings with missing blob errors.

Add conditional deletion of the kernel node from binman when FIT is enabled
and CONFIG_SOCFPGA_SECURE_VAB_AUTH is not defined.

Clean up binman node setting in Agilex device tree as this will apply to
all SoC64 devices via the common the dts.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v2:
- Implement this for common SoC64 dts instead of only Agilex5 eMMC dts
- Agilex dts clean up as this is now done in SoC64 dts

 arch/arm/dts/socfpga_agilex-u-boot.dtsi       | 6 ------
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi | 4 ----
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    | 2 ++
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex-u-boot.dtsi b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
index c0f932d0e11..148c71a0eea 100644
--- a/arch/arm/dts/socfpga_agilex-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex-u-boot.dtsi
@@ -258,12 +258,6 @@
 	#dma-requests = <32>;
 };
 
-#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
-&binman {
-	/delete-node/ kernel;
-};
-#endif
-
 #ifdef CONFIG_ARCH_SOCFPGA_AGILEX7M
 &sdr {
 	compatible = "intel,sdr-ctl-agilex7m";
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index f2150b7eb7b..c7e0ee2bfd1 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -214,8 +214,4 @@
 		};
 	};
 };
-
-&binman {
-	/delete-node/ kernel;
-};
 #endif
diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
index 88f0154463d..ddd99f87942 100644
--- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
@@ -93,6 +93,7 @@
 		};
 	};
 
+#if IS_ENABLED(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
 	kernel {
 		filename = "kernel.itb";
 		fit {
@@ -150,6 +151,7 @@
 			};
 		};
 	};
+#endif
 };
 
 #if defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
-- 
2.43.7
