Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A9AC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4F182FEE;
	Thu, 17 Apr 2025 06:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="k/PDnysr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FF982F75; Thu, 17 Apr 2025 04:20:16 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A2EB82DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrbMMnAhYZ4STioCsbZzMwi5mCe6HbpnYRNrVuVmlqDmd4pNwszeke//j9IbDHs6ejUeb2glYBKC+jC42kIQNJQ7o0xfA0tLIgMdpsy7/f46jVtcpd7d5/SI6wx+xQsAxrrwqtmlusI+al+4q65o6o811OORri6VAcAgdyxLv6Zew1ZIt9qmP2o8OGD7eFXILc1lFJ9kfgGaTCuauVTKf5P37F4euF8+u0E3leR5Krq5BgvH8G7fjS2KvvwAcfVG2cNA+BWNfrQ3Pwqr+kgmqrk78O/nfz4iS8ZX4ItgXLZ/zSE6L2TxrWHNGRoKBVVaDTpHhi2+gciB/TOA4bGhPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXp9qerZ6G2wdi4OsAwSG/YqiO4UJNkPOGTgJeFtjY8=;
 b=oSC0s0wzNB+I7I7OQnTmwJ0EhKEaik/k5i8ZIcXcfU5ry5L9B3byIn/fAZPCvEs9DqpfPhczBi9do8LdyqP6xg22QFMF3H2LB5l9azoeT1+eqOAGZ3VsSsBghbIFZRYOLVCjcRqmuCmFfe8y2eApDNc27OTdhceWUn29Jm1A1dp8h9Y0RhcvkkzM3STttcyRUOYOlxAMLRuPOi0BlibA37EqFf6ehMoY5q0qFk9EEcQc++d1K+2Ks/tAE6foRE6WZfzHCk/otvvlZ0wyIGMnzQvA84gU3NoBc8fiJstFQC/HiWdjyi+bJpLXzLqzaGXs0E+1cPRyGvyIcmuiuMw+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXp9qerZ6G2wdi4OsAwSG/YqiO4UJNkPOGTgJeFtjY8=;
 b=k/PDnysrv0XgRrSMjW1oJ0v82J8Ce/dMOe6v978B+BE4JmEYKF2CLlpNw0f9flctZkQBMDazoniwLVMecqUrJ0/eUMOOGfWLoGcR9793Em3Sm7buoECSrR5Df7qPSYy2clSyvBP8mGd+q9gTNt5NKkFo3vQ1/LRhPX4DDBhZ4xG9/HVFWjgOBtMrXSZfw6dIKwAbaZPcDvHFuZE0qOK6wGjZGia5GQnYD6hXIle3mhd8foa8BOusgMxGMS4/dt0HfEBgPoi+tlsjiglHqYfry1lr5umigWoc9itkieX3H6o3fkGw/2wSz5PO8nMLQlL8zSqsJ3UBMOKIhsBMprcSrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:20:12 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:11 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Thu, 17 Apr 2025 10:18:34 +0800
Message-Id: <20250417021840.6212-7-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2975d6-9cd9-48a2-a077-08dd7d5661b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xLXeeBpAVNzLTJMZlESGwEbXQp3pPWotCfsn7rpUDfvC1fLbmHp2Qjk1lf+?=
 =?us-ascii?Q?BRautLMlyDFXODcTAjnvMzcCA8zurlfgRkAsHrpj0gjuPfracy3w4qfjF3gu?=
 =?us-ascii?Q?5NZkGznWg1/rYf5Y3SdCXZWo7x8ujLbP8YUok3j3+SZQz2d2IxQugrXgw0B7?=
 =?us-ascii?Q?KU5194m+AAl0LvBhZ1HO2fa61W99l5mtVA887l4+uN+xWKuVZ3dld2dvQU7C?=
 =?us-ascii?Q?/mpnHxSgvmPLkggvB6/JhVNO7G8mw0q45syjy2v0o8zimFVXDZVjfKX32gUT?=
 =?us-ascii?Q?+AATvKZdpLeGIY+JzipwSYbxxm1ys2mLX8KAwCGHSLrLwvdpa+hOVMLNi6WH?=
 =?us-ascii?Q?AB173/4j8/xWp5pNvpV4zUeHRCqM5zylTVqwLvdxGz2N2cnx4ldLFhMf2vWF?=
 =?us-ascii?Q?HSs1s9FL8XNHNg4TFPJ+2t14ZhMB7J4cmwhnAUORHiz5Tmx2Oryr/N8/bHpj?=
 =?us-ascii?Q?ewoL/DFj4fWR5Wdoo7sWZrJll+zaUy/dqOU0T8IIq31YXysY70CnPbfx0mnI?=
 =?us-ascii?Q?BOeJZ56sc2Ru/dKvq9p2XzhKpUrIm8Y8oswHUFy1stotYVBFXkcBVmj9Nntp?=
 =?us-ascii?Q?IqMKkSggVOoHi3YxqL5v4nRE0TRF/aDB8n5g82Lleh+yCNmCucgbfzFtq0bS?=
 =?us-ascii?Q?0BhdxyiPgttqwVJRtmz4yP3eT8RkY5g7XGwFjhpnPewNTA1uirpgxpeYNDZe?=
 =?us-ascii?Q?1C1BzejoVoWLbHpP9P0Qkl+rSS1EeEVf5JV7VfeRTjXakIGxyUB0kpd+s7sB?=
 =?us-ascii?Q?6QUPw/627ZP5KO5DPxj1yYsNean3ANhf/1VV75iWw1A7YjgfdUoKEwQI5ruS?=
 =?us-ascii?Q?T9dA7y+qf2WYsfb2S8VI/p8sxx/rNZSpKzNwdsG7FEeTzU8iBdv9aSNpPEF3?=
 =?us-ascii?Q?OTDlnLnCIrIWg8X3fxMrlEP5rQNhgxsttm4ShKAekd13HiizOZACyNdmxNHb?=
 =?us-ascii?Q?wcsBj2VRNzVU1ttYdtvh6n8KKvlx5vlItersL2YvsLwQ4ZNYqZbP/6xZHc7s?=
 =?us-ascii?Q?0nyLGb3EY8MEYPyvGKsCng/2PotEJd5SsQaCfjUCJC3TWBlNxFUy3qv/NPHe?=
 =?us-ascii?Q?CLijoU/DJNvE1m6eqPp424U9amgMgz9mCll+fLPjhl3rQpJgcW8rybycvdvB?=
 =?us-ascii?Q?KDX35ldYgK8PBfjwTBRXyf8oWwzNxL7yBUULamTatwFfRY/cqNlOP7R099/k?=
 =?us-ascii?Q?9nUoa4a5t1OhhsXtdiZjlDVcqbNWF78XUVVhT95jUlZeZnqxKVX6g7RV3Ntf?=
 =?us-ascii?Q?6uWhdJTYYm8b6EaGIaoFXaj/P+8jxlYKvl22gp5kubn50wOSiwQjeTChDpxu?=
 =?us-ascii?Q?ajH8KGF3zO+3pD6/9HLe6vjuvJLwyiWdXuD/XWYjTzPxp7TePJh7HR1s+LX6?=
 =?us-ascii?Q?UMbSApc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+VENfcZCrQrGMJ7/8klLznOMKM4+rBs7mW28BFAFBX1o7hcXWaoT4nOHDDo?=
 =?us-ascii?Q?TD2RhzPuIueRq5x4DNBNN6m5y/MIKE9qO8Sgte+3F9p3+LxSalMhtjG46sli?=
 =?us-ascii?Q?xFXFFI9+/Derzg+SPpbR6i2LEDTzoFRZjtMras25UhoCx3jMEGHTmasprLQn?=
 =?us-ascii?Q?UwRWRxuF7oISiQAkcwINWTMc3fCFP98yrABdLTBqeqDNhATrzT68vTMqvN3S?=
 =?us-ascii?Q?rzBTWn2HSyBxY8onF+se6JjOWuC6pfaI74HY/HPitnhBeGo0hZHwoWnMWhP/?=
 =?us-ascii?Q?iHjeXHlbwJPPxdMfaD1fbQHDdoDzJydQLji3YF9fA797T07GgijCHJA4LJNC?=
 =?us-ascii?Q?438BJ9mwf4T0HIh61MvHmSNX1Mx4fpLbaeaukSIz+BwTT0ahzaWWbfibNpV3?=
 =?us-ascii?Q?G9aqa4yiB0GrJLjsw+ccqjdqNMwUL2/Qv+ydZG2+1CY78GSQMrpVzweObVkP?=
 =?us-ascii?Q?B9ifowdmY7w7ha2SRu+A4XGEzqIZYNx8Skt7oIT2DEzA3di+NrWtt7sEHtNO?=
 =?us-ascii?Q?hU/q8cMcdpiWSKRKGIJxsFdIYTqRCMbdfYbh05mNyJ4/cFpsoqeO9lXrFvIp?=
 =?us-ascii?Q?jt+3EEU1hkF1eJg+1jMnvRMPNLgOBGTUprshI9Ndph9LGpU2/vYBp57Z64Yt?=
 =?us-ascii?Q?K6eLvZyDH8qbyStSFqGOw7WyuCoVe+NKTLhYlSqJQzThEJ2lNugsBzQQR1LS?=
 =?us-ascii?Q?SF/keedVTY0f0vGPTRtgAfO1baaNC60N/Rxfr2ThQUtbl0Ke66nJdAWNGd/u?=
 =?us-ascii?Q?jX4HrTvLX/HgRwW2HVw0qFWH9RO+MO+kXJxaBIhcrw+uKQhrxqKCiKN8nCrx?=
 =?us-ascii?Q?2oFbrFUb3OHt5rfVXLBYq64yoKr1AFUQZnqrJrxHcQlnRf1t/lIaacNGlZPW?=
 =?us-ascii?Q?otLXE7j1E3IwqkpJHqfnpp6NJEz76c8SCkKLi5CqoMkNs5PeVHwfajjwB+QK?=
 =?us-ascii?Q?4dF74HoKun807s4IWrzcYXXKbwaK3VaVjunVTlcBM1YQeEJRSX0a65WV04fk?=
 =?us-ascii?Q?b/eyysRZp8cGrA9Sx6F9hlwSVYJjzFQ0Po26WMdQZGw1BfZMsJVGfTcBUphl?=
 =?us-ascii?Q?U98s+595HrppZ7/MnKpUxrvi6vDLT8U1+j24sORWPx3RGfl1ix53n+IpAvBV?=
 =?us-ascii?Q?BcgXvBMEdSIgERtk3a48JF7akMJ3u65Qb0MSnZfEiC429/wu+yY7RXC63ze9?=
 =?us-ascii?Q?+xkO6wsiUCHGWLRMB0UH6rVeuwOT3kkhuQq6uYL3F5HUMt7DeYSLVHe3eRTJ?=
 =?us-ascii?Q?Z2calVPNW+oN3nCuEWonmbMjxlRK3/uA1uMfB1KsX2z8fCswxfpoa99Z3LEM?=
 =?us-ascii?Q?IkNK81b3CdOxAeBIpqPLgYqjzr0Kr8Hr8rm5X0NEUiIs676BOp7hv2J7hT+i?=
 =?us-ascii?Q?4H7I4vjZZb9iBN5UzMAbhN3KnzHuhYlj05txhL/I1AqmI8+piouGbroYQN1t?=
 =?us-ascii?Q?sNbsuq6+WGKlEeamX/NCH6rbQJh6YOlrAUA0Gds05vp788yLqy/1S73Tbeuo?=
 =?us-ascii?Q?dfjMfbov2nn2lqKbd5qhH6wWq88APJMj2xBwd0AlMGT+81bWfPg6biavDYBk?=
 =?us-ascii?Q?WTi9m4yX1Arwnv+20TDtchBNxMUzrrOd94GrBf9505o4SaPSfP5/3jtcB1oX?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2975d6-9cd9-48a2-a077-08dd7d5661b1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:11.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhJjaoRsq1dgaISzlhilGTKhSow+MDtpBxdbtBClUo9BMpj7tHjK+ud1IglLGXOMlJWwgDrvrvbVnqGKgFuplI+colMXzzQ8VRiwyT2nRQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add s simple test for the I3C uclass in sandbox.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/sandbox/dts/test.dts |  8 ++++++
 drivers/i3c/Kconfig       |  6 +++++
 drivers/i3c/Makefile      |  1 +
 drivers/i3c/sandbox_i3c.c | 56 +++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile          |  1 +
 test/dm/i3c.c             | 34 ++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 test/dm/i3c.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..491c7dd56b1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -935,6 +935,14 @@
 		};
 	};
 
+	i3c0 {
+		compatible = "sandbox,i3c";
+	};
+
+	i3c1 {
+		compatible = "sandbox,i3c";
+	};
+
 	bootcount@0 {
 		compatible = "u-boot,bootcount-rtc";
 		rtc = <&rtc_1>;
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d4451057de0..d877a744353 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,6 +14,12 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+config I3C_SANDBOX
+	bool "Enable support for the sandbox I3C"
+	help
+	  This is a sandbox I3C used for testing. It provides 2 interfaces and
+	  records the settings passed into it.
+
 if I3C
 
 source "drivers/i3c/master/Kconfig"
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5ddc4743c86..d38d2350c9a 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 
 obj-y				:= i3c-uclass.o device.o master.o
 obj-y				+= master/
+obj-$(CONFIG_I3C_SANDBOX) 	+= sandbox_i3c.o
diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
new file mode 100644
index 00000000000..1b497a49041
--- /dev/null
+++ b/drivers/i3c/sandbox_i3c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <i3c.h>
+#include <linux/i3c/master.h>
+
+struct sandbox_i3c_priv {
+	struct i3c_priv_xfer i3c_xfers;
+};
+
+static int sandbox_i3c_priv_read(struct udevice *dev, u8 dev_number,
+				 u8 *buf, int buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static int sandbox_i3c_priv_write(struct udevice *dev, u8 dev_number,
+				  u8 *buf, int buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static const struct dm_i3c_ops sandbox_i3c_ops = {
+	.read = sandbox_i3c_priv_read,
+	.write = sandbox_i3c_priv_write,
+};
+
+static const struct udevice_id sandbox_i3c_ids[] = {
+	{ .compatible = "sandbox,i3c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i3c_sandbox) = {
+	.name = "i3c_sandbox",
+	.id = UCLASS_I3C,
+	.of_match = sandbox_i3c_ids,
+	.ops    = &sandbox_i3c_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index e44f3d89e77..c6c12713d7f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock.o
 obj-$(CONFIG_DM_I2C) += i2c.o
+obj-$(CONFIG_I3C) += i3c.o
 obj-$(CONFIG_SOUND) += i2s.o
 obj-$(CONFIG_CLK_K210_SET_RATE) += k210_pll.o
 obj-$(CONFIG_IOMMU) += iommu.o
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
new file mode 100644
index 00000000000..81336e67555
--- /dev/null
+++ b/test/dm/i3c.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test of the i3c uclass */
+static int dm_test_i3c_base(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 0, &dev));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 0, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 0, "AABBCCDD", 4));
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 1, &dev));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 1, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 1, "AABBCCDD", 4));
+
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_I3C, 2, &dev));
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.35.3

