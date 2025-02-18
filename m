Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0A5C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CE180F92;
	Tue, 18 Feb 2025 13:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i/JZagJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8676580F7B; Tue, 18 Feb 2025 13:10:51 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761A1807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJHNqr4p1awqfdhBBzd8TxYF3xxjyKUvXbhovx3dl3RgEuW6DyXIWmCjEknSHYwuGfhAWg3WIWYRDTy09s8dnxEQIMXiDlvHI0UQA484KoahxUydwy6YW1EtscgmNi1YCVJEKVsVmN+xMiy4wMbf8w1ykpRUXFOwtdK1cN+1+avcBLoaEPb8Jzf3byykk+Dr5j8sSlAtP+cYw9Eje2Chk23DtlmzDl/K7gC6LilTV+fKjuGmZYQa0bq7iTxp6hiSL9YIk6oDa1UqYtoYPySZNf0vc3K6csakowLtETewIrjWvJqJs4qLoWpTAMewwhMl3MrAFfD1sv7qSPajWdhaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbCDvXlMCx/jDDlkFuGU4kmZmi93SKvpOhy+wTSp1SM=;
 b=nfXMMm6aL+XhwOj0JZ7Ny2Y1BbocgOtsXccWAZf2IB6U4Yfl9I+Equu/uGZusZe/9JqO8Wp0aDtr1dKRZohRJp/NquJx4Zzjb7p5tEYC3mr8Jru0ily87OQbWcwO/4CzBDqlYl4+SakdtQBAJBoGQ3nElIdNSm7eM35AO2AQwT1oZqs92TwV76q85TYSf6tD/282ocUS0irq15vwD57Dl6gqIuIkMiu5Amz7wJUyMjoISYkARbUlp+ubqzGiP2kAdyUJABC4+meUNoiLuqy7OQ8785LdAXHzy1r+d2bPcvI2birPO6fIuYalpPA/D5THUKL2fsVkoHMyChOqTU2k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbCDvXlMCx/jDDlkFuGU4kmZmi93SKvpOhy+wTSp1SM=;
 b=i/JZagJIfKxo2Z/TvueSOWtergDbeypzeSa+NftxkgwCc0D6c/LdDIoEuZ5IWumKPVkpOTuaHYIXtAHpXxjFPKuQF/GlvvA9OOg1warR2M2ayHZVw2RM86705Y/dr4O8RM3HytnkwMuKVb8HHz+PhjX4N6UpEnnUrVdm5qbyYDBEpEHXtuZKbMau2pnUjld1AAUbtIXBXrxICvUiW028pOxUwiDsScJ+zCPfSTJifrNsI8e2RkVK7Mdbaa+bjNRc6rxkACXaG14OlwPYgYrwTq9crArBIVuN4zkqVe31ZYJ1OB+GNq3P55XuPWgH0fo2hOA3kNx/oh7UjHbW7P+SbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9900.eurprd04.prod.outlook.com (2603:10a6:10:4da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 12:10:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:10:46 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 12/20] spl: imx: use trampoline buffer to load images to
 secure region
Date: Tue, 18 Feb 2025 20:05:49 +0800
Message-ID: <20250218120559.451678-13-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DUZPR04MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ca89b2-9e02-4856-85fa-08dd50154678
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oeUD5fVXhXMhI3hWlXYc6YufHAfWYv+6xAn0119ueggo+nC2Cs/aWoAk5f6J?=
 =?us-ascii?Q?LWS+VFhNyHk/ymvI5Q6oPf1c137wqXEJk1rwkS0oMuNMxeU57fFUsIQR8qzb?=
 =?us-ascii?Q?YZU+CJMGOD3Bh51l3FtV+5sfOOv/wQlKlPUd+IWkaPlMWJgRpSqXaJRWpot+?=
 =?us-ascii?Q?F9eIBdWiRZrrOheFOfbNciNujsLCcySzF3cCPn4+YQgZgrllYiUQ63rL2Un3?=
 =?us-ascii?Q?x1pWPPHM1uBCkyc6bTY0SU3PViMhr5Ed1fk4bwQQ+udYEKKYCzuK5i7WtRD3?=
 =?us-ascii?Q?mbBDEGTZqP/vZrQ7KNtf3oD3BsUbvxzZLIgsjBidX8mMolt5RkQ6KGiTk4AF?=
 =?us-ascii?Q?s8cdlSgjuVsXWw1viZYP3ZN0YHx3yc61sFricvxUCAe7eZgCZGUjpCDfbHoy?=
 =?us-ascii?Q?nwX/aUE+ZMFi1Wc2x4gMsAdMzNkb3bUoYSl5MdR08TPT/tpWmdbMm7JIRlj1?=
 =?us-ascii?Q?9mdFDg0KtwY3LZCnmF+22lEnVuCc22TeZtv1YCILwrK8JCSuVlGXRiIkX5MK?=
 =?us-ascii?Q?Ly8WSXn1vMohPEYIwiGo/ag88rnCDoOsrQ+OQUP0MVSWZ+3joIc2/Qgn5tdM?=
 =?us-ascii?Q?lJ82rUfxpn0INa7E0j4H3//ze92xkPMPvw2QkRA7o0QihjdWJDGkUJiH+aa9?=
 =?us-ascii?Q?LQcsJNCc+Y/txayNSPGPGMlDLD9FL4V8VOvSunoSJ34DmyOIXYzL8hzuCEyq?=
 =?us-ascii?Q?ExoRBzjv9KHRtPlaCwloAu9lAj/Pf9l/y2OGGS9/qwuqJz+Qmzer/GUCbk0n?=
 =?us-ascii?Q?lxvPMliFKqweVy8XA+tqDm2nBJf4Z7YVC4GvhetTeAWh94LWntxFn1iSPtmn?=
 =?us-ascii?Q?t6wMqUyXCggViQic8WiA1Pr5NVmi3WQPlI7cKkknmtQZBRRCOdTEH9OrJRo6?=
 =?us-ascii?Q?4vNTO2QZzWN78peuLZtYdqplTjwjfVmcvw6lAl4iOL1abJ2GOQbTJ00VvgJH?=
 =?us-ascii?Q?wBq69Tx2lAKtk+oDelpp7M1ZvoYF2I+nAq6jzA54MRn9Kt6raD4dYskcK4q4?=
 =?us-ascii?Q?PM0bNlXjus3uhTT7paLBXlFSNV6eYNtJdRZnV2xdpc8IslyaBJ4jWgCtn8Wu?=
 =?us-ascii?Q?vXIlPxEz6KGl8x5YceIpA1+14FCTF6qsThJNySdbskUAxzmQXLxDGz3f0Nna?=
 =?us-ascii?Q?54g8lFoeyRc5HlQrUkSV7bgGPVyL2L66R95y3RPJdhHN17HIW3919mBWw9JY?=
 =?us-ascii?Q?xm1gz8CmJw65cAt59IgCidbUzrj/6GxuNZ5hy83aVuF1poZ1CHxoQ3x9/rHx?=
 =?us-ascii?Q?vMC4ZMc8ZEIfaHm1BDUTgqrXYZ45BT6O8buPyCKXfxdPrZbuC96eNBmzhh9I?=
 =?us-ascii?Q?K1x9wpWSffXIAlyQHcLm7mU3UkdE1MtifvDVr9F9CRkn1HmOeGWd0r8PsA8V?=
 =?us-ascii?Q?+hiD3VkRY5dpc2gh4AHyYITHoypDXS07k20W2GjW9+WFJY+CAtKEAh9ZX1AH?=
 =?us-ascii?Q?+kJeIw5RgQrW05Z3tBKyDUTrclv8pznD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tx6Lfqa3a6ztCyVPj+RSmrPrTsNSAANGvoitA/JH+vGDqqtZkEr4rRTfmXvB?=
 =?us-ascii?Q?vDtDsNY6OWi/WEt5imkcJIrGNQoqMa8rAvRTSV7NQjcYHlboTTjAQymXA1b6?=
 =?us-ascii?Q?Jw6WyI8QFr0Yz084zmpSJ671y0qPGzZwLtSwZySMjGorHeVphWtZjqh3ggw9?=
 =?us-ascii?Q?rgWRiw54s+X7Yu0DmPMaJIvOSXa9rFXNtJj+IO+WtD2lzrWBgHVdmuxkgooB?=
 =?us-ascii?Q?zkY2E3aFND2Cq+Pko5u1POHYpVSESuBV63hwczcYvfGCmcqRlHy6UozT9r4t?=
 =?us-ascii?Q?LT1uPspIKXF7zcbh5XziTp319keBaV0MAOLWISWv2XRJCizuj7h/SyuM5nRJ?=
 =?us-ascii?Q?tr1ncVwfV2MGg1axcCJxjS+hL3rRF8sJq8dMqAJGtmf+ovn6PISP/ocPUG4j?=
 =?us-ascii?Q?i7/CDfU1eavAgkVRwaxD1ZOelano38SPEU4+CufXW4+I2pEXjefivMhjnyIE?=
 =?us-ascii?Q?Cp46tl8ZZm9uvzNXvfAO0Ct75Wj84NqsNggKpl7IEEUgfy/SbiWGVzYyMlld?=
 =?us-ascii?Q?lylrpwG84/cqbBONh899JDwgBFUMJwvg1NV0hwb3RIO4NqkmQvAK3Dmc+egN?=
 =?us-ascii?Q?3ZFj9QQA3aZXb/x0VaRYSED4uMQ1OnyCl8pAkBkMG7T12NP9PL/OWncLR6A9?=
 =?us-ascii?Q?gTqc8GLgYiHU3BA+hCLklEFXHFNnw78oCuK11q4MOn6RnCYK5n8ta91oBLJe?=
 =?us-ascii?Q?A9lYMlN5Nt4eLXhvrNxHdeLni8dXPrEnrn06+hf33tvUf4N72qeAQgdJfbN+?=
 =?us-ascii?Q?fclH5ueffLRXuvXxX+N/F5/KWYGwzrXic9zXNHx0T5jHCcNWtSkUIK5mNOv4?=
 =?us-ascii?Q?kSo5i3XZqf7KqVM45uIaGqaa1QUyVMKB/PPSJmaZGyyQy7HCoqrwENBPROGU?=
 =?us-ascii?Q?EIzHVrCOc605ke9Q0zNQrYvpJfPPzteUO2t1cIPIcMpPUZ8Jj1WHINvhMGsF?=
 =?us-ascii?Q?clSSxaXHriNIJJ6w+I4oZtF8Q3RogxVL/kWexk+YcJEwtQG9cJ9Mdnm8zoG9?=
 =?us-ascii?Q?46NqkC9vawvEOkCwzzVnGL+cUOhHBnmt6PVttzsmpce6wXNXRnAfSWMunsG4?=
 =?us-ascii?Q?RRZ1BUe4Y5EKZa7YkqGMU40WTB20vuly0fQEuxe9POmHs7taQTG+1Jc5cs9I?=
 =?us-ascii?Q?ZgATYABny3ws+3XfIUC1Dx7Azdw9QX1RV1B8dRwt7BgdLZ1j0ir1plfPeib5?=
 =?us-ascii?Q?7cv250e7ndSQtiRLkA03ahJKQk+F4MAOWtGxIKt33NevNqohDXq/IofsdqZQ?=
 =?us-ascii?Q?JVWgQxsovKQPPGZunKnqV9nwhUzylh8Ceiou38kGfMrS4JoM7isWjFjiLtLA?=
 =?us-ascii?Q?avcgiVyYxMtLBBg+v0Ah6ZpXEtUA+26+VeO3gJBstV5QAY7PL6JvOdzATnZt?=
 =?us-ascii?Q?jdRH+XLfgkswErbK6Glkj5ZXahCimpFPuUEOiP/vvcyoGewsRJa+znZC7+iT?=
 =?us-ascii?Q?hZyGHPUV8T0kTVwutjhYelR6vZ7Ap2qwGaNZZT1xHQQkoyXWzUgFb2JJ/NHG?=
 =?us-ascii?Q?YIJklhXghx56avSNhrmuECPsr3grR933GMlj39xl2Y3SwXcEpvfMBsoq4bG3?=
 =?us-ascii?Q?9KjO7aBUHrfZ5uVu9b6Zo6SrAH5SSSRt3VQB+aES?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ca89b2-9e02-4856-85fa-08dd50154678
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:10:46.5429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rU/ajsLEVb/SVg/yUB4hArp/Sjg7zsd2IgfBc5uzBCAHmEBfLcVE5VKeU0uK+cOvMRWgK0d3fzmGC+9TUBEl9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9900
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 ++++++++++++++
 common/spl/Kconfig                |  6 +++++
 common/spl/spl_imx_container.c    | 41 ++++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 217e7ed41a4..1bacf526577 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,3 +786,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7d6780936d1..29bc119bb2e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -362,6 +362,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3..47fb2e65e34 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT
-- 
2.43.0

