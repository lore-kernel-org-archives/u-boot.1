Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A34EC87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C364C83D46;
	Fri,  8 Aug 2025 11:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="No1fNT8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932DD8451C; Fri,  8 Aug 2025 11:40:12 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA8D83D3D
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXLfTo+zahRkum7oGKB11Q6UP9TWiOgLI5hMPpEMxPV3lc2EmIJfG3GzYgOQxi+JFKBqmoxfLBnFEpzD/ADfSNIDmZSpMJG4EkmOhJgm+gFVBvC/ktELM1wckgVf2fdX5LBXNTtyGsvDbzu/vrMPUVr/R5MbBLHTCTDUjJvZRHH6BpMZrbXuBntTampwW6rRe7es8BgzUf55QBcVL7MboCvE32OUc+mY70WsorNlcouGgXEtJj+ToH5/fUf8MGMJAA4/k9iFyGRxa7R/khZiVtiJlnuhdYU+0dXpOlh4p/Nkd5XZD/PKnpCgoGkqDRKfR1MFjQyAKIWPtAiVuoBf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tstdyxbzm87s1r0is+YBaf/qz+K2/n2Wg4Q9YFHwubg=;
 b=FeRHDMJ5RnAdEjYuzyl01Adk6RsERqzYh+irFxZ2jHvTNwTV/FY3z4YnjcFDFpvSXXWVrN1JtzeMYC7PFvB2EkVhjWAW4fg8TbkeI89J/zcGnSiQGwThwvxB8JuMeuEOEt6HnuRniRatfBligo2wZL53vKasNtehmZzERu3Dx0DCq/LmqsGV3L3zEsiXwpxoBxARUP28RSL7twNQzPRt3jxEtJstlE3lL1xyxM8hrMxWbi3yMl1rJ+V0L2aVh+i7phdV6dEe8kZ040NRQNmyq1Co/X6A1obxjwVIly4BZDuwOl7j+kyhyWD8sFgFBsahv/4Jbq4HWcsfKP+W4CFYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tstdyxbzm87s1r0is+YBaf/qz+K2/n2Wg4Q9YFHwubg=;
 b=No1fNT8Fv2hZYao8yblIdezmoT76bmKhagLKTw9Vx9ABOF4LHY8bVHFXq4m8mrQWlffBvYYEBSqKMyrgFa73wG6ETU2y/M3BjF5E0+aLRJ5NaEgbCkDZSQAAd0nBQMR0aRX5hnq9PJRo9Wbp5BthzfimihHSXiZRmaCOMtSCXp0Ug00GEBwAlocRUyP8I2LTSwrx8e3soFk3jx19WO+bTMdaVyNjDEMKFICWs/8jrGjiTVc624kb/vgs9B01+Vb0u6oDydHRFJBy+LtbDhKnutVMA3FiZWuzW8H1Tt9NptTSqsFSPOqwH6r/fKF1iUwRSNywBb12KIGXHXo8wMOamg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV3PR03MB7730.namprd03.prod.outlook.com (2603:10b6:408:27f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:40:08 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:40:08 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arch: arm: dts: agilex5: Disable cache allocation for reads
Date: Fri,  8 Aug 2025 02:40:03 -0700
Message-Id: <20250808094003.24604-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV3PR03MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: fa04891f-6157-4687-a41a-08ddd65f8fd0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E7kAQTE0vwqmJk0beRHg3dcKiK6E7IejJDIlykvj6cn0X+ayHE4HPCBiu5/n?=
 =?us-ascii?Q?8Hm2VoO2TM2rGMMJ1sg6xXzFMMsRplt2NfrjwmKTXaDiP4k0zQuSCWgvjWGU?=
 =?us-ascii?Q?+ndpRBxlLC4rESAUlPG6Nj3NVKJPa+J6h4gbVzUso7nBCzh4sNhKhKf2yNtd?=
 =?us-ascii?Q?sC/LUGyB23tq56RlcYEcptalVBPfTuMBt0FUEFRBEIFQjsNn5BGTGS7/22+B?=
 =?us-ascii?Q?EAMRy+2CWZb1RENsbCEDPmB4w+k3F/kECiTW7bkJFn0nzt14aqmPAYb53/oE?=
 =?us-ascii?Q?bAx2rj6xiiHi6sr1JZyjpNLWG5ktJ2ZnQjqS10FIas9SyBR3wVKc0nIi1Cr4?=
 =?us-ascii?Q?tDCtZcZhURWjRqea4llr07vJcJz2aX+lztox23+ilk3GMBhLWPgvIaoOBNW3?=
 =?us-ascii?Q?t1hme8kGPSTOVpw3evNGS6f64IDi1Nqst2xLFGCq6fmfsodLbaTNORcEGCT4?=
 =?us-ascii?Q?+A0ABxTL6f7xqUWswVbKKHi4gjvDo33kZhQK5ArjEiuK+uBX1usgLmN3Vywi?=
 =?us-ascii?Q?ppfh6mHLbL4aawLTyt9jd6hd1/eZgvw0KQrifVhTLVhW70ahdA5E3LgMh1qE?=
 =?us-ascii?Q?ic8r0ABvB3EsOd77I9VZrCAW2Z2MdKpG76OhPItHpehy7zplXe1DJ26BVjur?=
 =?us-ascii?Q?A672f6lPyOIMX/+UXB6Z643SeZzd4cA7IVBojEjdanYyoB91sGkXXEma+b7j?=
 =?us-ascii?Q?mxBqnwV0CWaS8alEVWR7Uns1fuqf3d16nl7m3xFnLR40MQzX7mEDtCgjUbxa?=
 =?us-ascii?Q?qvWVpE9GkSS6Ne4LRC9rFgN8zUIyWCR7Bq8SM40qoAm9Nt38axwFS1CjtMPy?=
 =?us-ascii?Q?HXH8XY75ccXoe/X9lDv1Ec0uHE69+epa8FgBRyUYehmZJdBiECf5TiRPKF0L?=
 =?us-ascii?Q?TsNR77g7MB2JldfEM5hu5BQGcIaQSb3PFw9sr9dUbWTRMLeA0+ZQkhJpPfjy?=
 =?us-ascii?Q?ScyvpZdS0jeNWXB5jQtw0poVthBDRPWWCun6iiWNVO7dMWAMRoRa7ZX6WSOI?=
 =?us-ascii?Q?00923qrfUsLMqIrzBxUW015V3ISuLOK7hiMHVjxdlaTWY5XjFAAt6RVoccfu?=
 =?us-ascii?Q?mgm+ftTaPJ9mrJqwQkPJIRGeBYtDfiz+31GUmlIvasw7ZvAbi3S2W9Px1w6o?=
 =?us-ascii?Q?UYF4VYLKz25QNr0E8lhtCY+YKDvKuT8ySrHddohbiZuuPBlmzJ0q+GulCzJV?=
 =?us-ascii?Q?Ewxmi6JM4Msn3uq5VFbAt5w3Kwex+zFet+DohJw+An3NtZ3N2ajJMVxAnzfq?=
 =?us-ascii?Q?qD7s5XU5edS44rPtQUPHSuSB3qcrXl4NZ4SDnADNImTTsAK1fb9PpDGa0+d6?=
 =?us-ascii?Q?CxIPQ6eUO4NvVUpYoRGkxEQjtjYDYWdQXG1O+jxv+NSR8mN3jf15Ih9smQj6?=
 =?us-ascii?Q?7EGngM38IgFqdBME1fizwQOKYQMNbs0lw+tQWLjoE37gjy3YEsFnwwWcnhM5?=
 =?us-ascii?Q?xfDNAT/yU4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUWrYYTrbvpsr1OuhfsPB7TqtwaTTgDkO2KZh0joo0bXqq8YGGowwDcmNwFD?=
 =?us-ascii?Q?kJ2Gy/B7eUC/yUyd2Wi2FHm54uQvvkkJ5ZopX6CfajnhVUMFpQK5wM5TgWrt?=
 =?us-ascii?Q?vVXK2+Urrn+jsYhvPZg4KcjF/ctON3EvHFnnGwut/uGhHwBsgYM44OS24JJJ?=
 =?us-ascii?Q?5eoGiP1Cubcylo8c1GeqIyfL5aeqSdnP1F1nnmhPfYKQkSWoylIPpzKlpeUq?=
 =?us-ascii?Q?HzV4rouE7brYB5ljcz0f+vx+JTm5uW7kAm9vDqtFWixhAgdxnxNgejqIqeTN?=
 =?us-ascii?Q?Cl2IiHRaIfrM8+YcqxImIAoA9tvF+FoRZD/nbIFXJEbbtCB25Lyb9SzVYY0o?=
 =?us-ascii?Q?t3AHaA2DHEONB3feDTKu2qbo2HiUm+y8DCjlWNjHWpNa02jRvdAo06bkefRU?=
 =?us-ascii?Q?kD80m3UzR14UATVQfT1fGsQ9achy1r+9sa8W8JiUrhDIbJ2boC08/mNf1XYl?=
 =?us-ascii?Q?b0Ni+YsfKPfrGBSD3hWwwsxQo3eOJ4Ih7BIjHEe1bgPEhPmerSFIhcIaCyH/?=
 =?us-ascii?Q?eHO30GUFjy7RylllJRaT89mOTwhSx3F1XcuphJWqwwUvjyqati5sbjSR0H1C?=
 =?us-ascii?Q?YuS3b8kBc59RQ2m+FYuFcYpHRhjFmZRk7k5Ut3auGj/Ae1vs61CCHjy0/+2U?=
 =?us-ascii?Q?YnOXeEQ7yB2wVDgFEBLECLGpyPlub3ZqyWKS9AyUdOQ7DZwLxNReZ/JLbA4X?=
 =?us-ascii?Q?6akm2ZH47KOtCMoBPV/E+wYrqfQg8aV86mvIsfExgm74mEGyWwvlR7Qchhos?=
 =?us-ascii?Q?RMy38rdfSv4ax63MD2AAT/xcqPz8w0vjAV2apiXOh6qm3R+6eR8cUA/6vsds?=
 =?us-ascii?Q?aLGdUMF0kL4dPMWUGZkHrXU7N2pUFJsgEgyMWO8VQ1fDYEKPx7AZnUuJnN8R?=
 =?us-ascii?Q?Cat6Y3cFWNHUxFH04vGbfySLZFdLDr4zTimfBYvzBx2ETtmWwPRdm1sOwDW2?=
 =?us-ascii?Q?7P3G3uxyq+dhSwZ3PmWgG9vzFgO/UkCASykzsSML6HvnyqsYJMOH5fzHfZOS?=
 =?us-ascii?Q?3ZgiWTqggqotQk5ZIGz7ER32T1z0xQ9KoQ5HQVa5SLjuh+d5+c6hPsmTatMZ?=
 =?us-ascii?Q?OH31Y9zH3PKDz2iqUqsH791ARdEJtNcfrWyDp7FmwEagy9v+Lvx85nu08JhE?=
 =?us-ascii?Q?/VQUDQQXRKcVsJDXam+9hHQARSR/OiRsmYYCCNQlhjNMOc1mJlfl5vRHLWc3?=
 =?us-ascii?Q?VakmhwNX5b9NT3lBhPd9SOVXJl130gO6jUEPWwGKvkhn2pvT/ea0oVspPFT7?=
 =?us-ascii?Q?All2bQJsfEelUyZEZZptP/gGzCM4Gp6cHI5YCOIu4hxVCMrX/Xbcn8Y1IXKG?=
 =?us-ascii?Q?oVdMJaMdPetOr66vJiLu7zPfDXMZeY//lMfWR0OxNOgJuW0UhD6aKVjOM3qL?=
 =?us-ascii?Q?SwTZzkKqbnRc2pojNydRPdKx/K/Hg4adLSP3sil5adiXVvOoR/DSju/1JFyq?=
 =?us-ascii?Q?yD/v38VeIJ6IhjJTt730NzW4tq9gicv6xliXU2fqe5Vc0ArUu8zO1KvSYgzE?=
 =?us-ascii?Q?18AqeWMMAiuqgjY+29TEJ2whH6+qHbprm4hgG4kXe8NGLvF2Oiv+1z3EE+XI?=
 =?us-ascii?Q?Kkft0CvX/XhvN4fkcubcPJdnySBfrVooCjvjBaCPzs4btZnHtDmG6bml3PxQ?=
 =?us-ascii?Q?YdNvEbjychkSCRK+S8jDGmE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa04891f-6157-4687-a41a-08ddd65f8fd0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:40:08.1259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro91XK9KNunWf5Ywo2FG3wJg9BQaMeHNHNJ4zGOdTmpcV4r/rzrjppP/pIUhZrB92L+9AaJAXGwae0XlSW1uq0jWgk5Xd6+L+QXxaavtHz+Pmu05UpYPQyPWvApOFXho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7730
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

In order to circumvent CCU NOC issue in Agilex5, it is recommended
to disable cache allocation for reads. This prevents hang issues
caused by CCP (Common Cache Pipe) Fill Done FIFO overflow.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 402f0bec173..d51a9e2ff7f 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -209,7 +209,7 @@
 					/* DMIUSMCTCR */
 					<0x00000300 0x00000001 0x00000003>,
 					<0x00000300 0x00000003 0x00000003>,
-					<0x00000308 0x00000004 0x0000001F>;
+					<0x00000308 0x0000000C 0x0000001F>;
 				bootph-all;
 			};
 
@@ -220,7 +220,7 @@
 					/* DMIUSMCTCR */
 					<0x00000300 0x00000001 0x00000003>,
 					<0x00000300 0x00000003 0x00000003>,
-					<0x00000308 0x00000004 0x0000001F>;
+					<0x00000308 0x0000000C 0x0000001F>;
 				bootph-all;
 			};
 		};
-- 
2.35.3

