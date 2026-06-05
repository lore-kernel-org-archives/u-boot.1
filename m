Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCFDCD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 01:57:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF50849CE;
	Fri,  5 Jun 2026 03:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wHviobHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF0A84999; Fri,  5 Jun 2026 03:56:59 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CAE849DA
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 03:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0ltlVjefzSAykp0pnarBkF6Ymmd0+wAVbzRrhKFZ7qBEz1Q39ITuTCs6aSRdr+r3Q1TpIbG5jcikFuPuOejtsZjnkQY+9IWwly2/VtVUj6lK5fn8NRVlB7g0b0gK12X0NLYKHPhNkW+qM+XKzjfzCuuJmT0gshx2TlAYk1Sj8J3zz+HKkRFfEdzw3FbvKgbWTlKl0P8I+9PN6IE8KhG6clyA5kyGc0MzsmNbnn+6w42rHC1+wcMI8TpwWDAJ2KyctT1kbgJYFYlBJGRR/ipC2I97MZmqdWtrP0b6jnK6jGz/MGdq1/S7hMX5lenKkztIlNqVI+e18WaewhnEVEeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOh5R+ZIMbCiawcio+iagJODd7E2l7uCvOQ6PLralgU=;
 b=b+UnlEgs/680KgJnc6xEgHjJeo8eiBnkf7CfLH8jztXNMDJ01qXu4WM6n91mkaAeoMspGOO4p9bDZgARfcHabnDSCacpjS9xm8NBvGLjd456ga9jORRDZdwPybCIw2TMvWD+EhBZ1WH9rZfy7GU4DZDWcs5oDg8nFw5BwiprCp19SRqt16hpvUKarGe0UdXZQNizq6tUOxsJwBeyTVw2dk83QHonz+v+Dfc7HIVV1HoQ7FQB97H7g9kP8QBoHrn7c6li/X0kzipCkRBFyLzzJq4FIs3k76JsFqG9Zny8QbuLhHMDtBOXMAZ/wfDID5vgVkq2tMRUyQNO53Lvbbwsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOh5R+ZIMbCiawcio+iagJODd7E2l7uCvOQ6PLralgU=;
 b=wHviobHHzXlkhzVPYxACGwnuGSxDl/gsK4crsGAnLLsmvmhUhlevOiN/hCqZPOKsi/N9Bb4/Pg9hzLCiP2GeAB+KZdCbPVyUxaKt06CyAnxPX5K1HbFmXeR2jaFPCAEWhmo9OVT/qtAbcDzdvTTZtUB20S8d/sM8Ldk55ZddbGl+mLCDyaj7luEfDltYqIiqS5D7a6vvXGJzbWkQh7NyH92yuZzdi5Z/0qEgHz62pWvnYzgHd38U8wZIkzP9Slv4wLU223hJfM8YbXcS/pg40g/JMfhXRoG2F5GDuGOs2D1co6O3d5/sPY/oCFDsZprB4XdaTHvV85UekeXvIn7bvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989315.namprd03.prod.outlook.com (2603:10b6:8:3ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 01:56:54 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 01:56:54 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v4 6/9] ddr: altera: soc64: Add secure region support for ATF
 flow
Date: Fri,  5 Jun 2026 09:55:00 +0800
Message-ID: <20260605015503.11709-7-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989315:EE_
X-MS-Office365-Filtering-Correlation-Id: 7938829f-df2c-4c18-9403-08dec2a5b7fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: axfdcvOEL9yik8RvTiLkMKQ7CcSaLrlM2yXHpWQCyvtGiaVKg3OCNPOPRynPDWC/q0WSvibn1xKN0130zdgCe2IE37OcVER3VuTNv4gQkHQtXQHCNtKrFoLAduSPbDucipjlrEFNRcaFiNLZ2q3MRxGiJexxR73M2n5fpsiFNtUjMyXhEpzluEjen+EaA53p6Xa4c6mkaFL9Z77TZyUnWmX921txEklE9sWcm5YiolhC9JSmeC8s0auIJC+aHgBeWpgrK9CoXBRtg2mEEnQp46DqqxPYSpiWjSoWxN5bmLpVPqwAxiQP8ocTDYWKGsoE9E80iBU2THek1Ux6KhApO6e9fHxAldTTwr/XIBe4C4SU5togbzqe+x+NwHoEQiITuEOcNAJgSXrQYxpoHI2lVzajA+bfw+czhNgGxp4GltTNvfhP7LDR2LkszI3Gs4eSblRd62Pow22OY/7XT1MYXd0qkdMh0Nb0F+1pfkt3BvE5mk657uzaoSr7qGQMjGC+lgN9uWBEENR6uxFRr12PS3bdVnFCka3eq57tPld4slzNUVwPFsoeHpwVP0/o/WY1kjY07uXJwMG3Ur4wP5psy9yn0jOZ2bpVG10Rni08IOE52STznvlqAvcr25cbBG/2pw5ebJ2WZ91ABcFok6w+Bv3RaScheLR8vYM2hvuvBMIkZ0aIt17x615IQf+DFOPC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rqVOsC5C1C4Y5s2XWqcYZiREpFLotFpolLUXVCD6HZ/6UoB+CwxDJshz7O6j?=
 =?us-ascii?Q?9clfhQZj4+y9eI7j7LgP1fYh6kY0fb4V0WA8/Qq4iAfyNFRQ5wmlbNv86FdN?=
 =?us-ascii?Q?Gh5GOibP/VFvVTm6F2Ij5y8oITsfJ1dfuhBCxh55GK+dmhs2oifhPLcrHdQe?=
 =?us-ascii?Q?cBasdMqWdL1e+jYhuy0/tFS/VUcc2hN4ouckVMvn+ETXaL8m42W3T6V8S1Vp?=
 =?us-ascii?Q?EeYaICrt2xSY7q203ICaZ9Es9K1OvOuicygDXLhSD/Pzq/H7NwU8qFTxLDKM?=
 =?us-ascii?Q?xu6jl+4AhsCy486Uq7i0lglclEaGnoEAbp0R90VBT1/2hS4KegTTxjxszlbw?=
 =?us-ascii?Q?I02FyhI5YL9WAHp01NOTDbGKuvVMDJNkhl8Sns5IM8zPmtqWl69QjYXEMn+D?=
 =?us-ascii?Q?9h38O1rvh4jMUKYnim0Fvo/YWev7g3dEo0egRBcPsHvu0lyZxtiYxC14axc6?=
 =?us-ascii?Q?HHhkr7jtX3HXQsCZZ1eOvku2sdkR+kELHrSiihN2Va+uk/kEpdvZDcYcbKdV?=
 =?us-ascii?Q?zq/zTM2JOXdlSgbR+d9wKJ4womWHEXgF0qfzODjNqDs6bDApreC6aXF5jW2x?=
 =?us-ascii?Q?bnm0jm9EREBKPovB8foMRY5HPQECPWS22sAjku4Mw6ZvjvYuAvQ+VxSTHxbt?=
 =?us-ascii?Q?oGZ51JXSMziu0Zm3pI0/HeDk1BEtBsMXJevX/7TcaABr/x2MzuNSBid3SpqM?=
 =?us-ascii?Q?M/x1tQkQIoPxcUkHC1ucKVa508078rSrMfzKXzaVJpxQsRtI4ON80hXkyp48?=
 =?us-ascii?Q?h/6ReF8+QIoVgmqBT+4y3H5bDBWP5WrfgAo+gc0+vzq6VRYcT+iKnfqrtEGk?=
 =?us-ascii?Q?t+yDfpeTrxm1EZpmLqPGmkRkceKr48KGtXrDOopk7zFy8Df9DMEnTp/NHUMl?=
 =?us-ascii?Q?MfQrljg0DUPkztQvt3f805u59t1is55ATrxGjRyUOXrgp6q/MksL7AdKaf2Y?=
 =?us-ascii?Q?UApcHMg6M7BvqdOKSUbjHmDlM5ISuEdAkFQcYqQc1X7/BGIp+BIKt9FIYgHD?=
 =?us-ascii?Q?qMFOW+6ltRgfRKtc8fywSr6REFruTN6cLIc/Y09sZWNNOpevpkeEfwdDsIus?=
 =?us-ascii?Q?UQ+AP2ZuGss0FpqFNlnDAzolvEQqXIulhj+vNJI+KV9W0DjZ/1WXa+6BytJP?=
 =?us-ascii?Q?I4CjCKwQI4mcVvnmkIiANmRI94ROFWpnoRSqv+Ko8O44c/b1Z78i1Zt5q9Bm?=
 =?us-ascii?Q?Kxfkx8K1y2Mdnzju+3qddtXmJ+O2tqELf8VjDICU7HmZ6qXGwqhYgm4nCaEC?=
 =?us-ascii?Q?h26FqGovKFmTlT1Ml4FbHZWr5Z5KLT8g+Z+Ib9rrfad2Gqo5nDND6brzqAnt?=
 =?us-ascii?Q?p/CLhb9jFxdM8eOPREFfkp/s0FrB9Pl/d6nVsejB9WXhcBjNo6qUfnO1Ryp/?=
 =?us-ascii?Q?7/sK+sX46coQalMtkMygWVf9BR8XTR84a75g5FqN9hvZ0w+KQartZNMAlKKr?=
 =?us-ascii?Q?LlsX39QSZPNb2BzHyq4iS+BNa9V7/ZrPB3oyz1F7dBSUMAzxUM221Z2Res5r?=
 =?us-ascii?Q?UrLJH3t9ICbMVHhgZ3/o5I4WA2KofHtBtjVQpjyv9vh0ISpEAQDfE56kSXjr?=
 =?us-ascii?Q?lI6XA5WrCaOhfjtLO3UY6HNo5ndgQhHGOgQQNCAhBZei6VCZFT2k4VHODvV9?=
 =?us-ascii?Q?uGPFmSuOtdwuN2ArYVZHksf2P9JTbxk/vZigcIgDCK3oHYavgBaZ4543N2E8?=
 =?us-ascii?Q?aGLH5+F6BRdGGaPr6UD5IcpntZWWebaLv+en1mHw7Sbz2pCnU4ywvqqOj/Ok?=
 =?us-ascii?Q?UEAhpcJVtnAeRIH4XOwV1XOYEv84cPM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938829f-df2c-4c18-9403-08dec2a5b7fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 01:56:54.8247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS3rKNIZPtFqYN+aDvMzHe5zAZU8b0oNYcXbPQhy5Kx36x+OZbX0koYYmmpHvT+gWYdiaxoLis2W4xp5byJ1QpAdXOyL4H1FI+Mz1chqpp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989315
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

Setting up firewall regions based on SDRAM memory banks configuration
(up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.

First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
image is located in this first 1 MiB memory region. So, this can prevent
software executing at non-secure state EL0-EL2 and non-secure masters
access to secure region.

Add common function for firewall setup and reuse for all SoC64 devices.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

(no changes since v1)

 drivers/ddr/altera/sdram_s10.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
index 1497a8e4aab..aed53ae58eb 100644
--- a/drivers/ddr/altera/sdram_s10.c
+++ b/drivers/ddr/altera/sdram_s10.c
@@ -78,20 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 	phys_size_t hw_size;
 	struct bd_info bd = {0};
 
-	/* this enables nonsecure access to DDR */
-	/* mpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
-
-	/* nonmpuregion0addr_limit */
-	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000,
-			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
-	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT);
-
-	/* Enable mpuregion0enable and nonmpuregion0enable */
-	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
-			      FW_MPU_DDR_SCR_EN_SET);
-
 	/* Ensure HMC clock is running */
 	if (poll_hmc_clock_status()) {
 		puts("DDR: Error as HMC clock not running\n");
@@ -284,6 +270,8 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	sdram_size_check(&bd);
 
+	sdram_set_firewall(&bd);
+
 	priv->info.base = bd.bi_dram[0].start;
 	priv->info.size = gd->ram_size;
 
-- 
2.43.7

