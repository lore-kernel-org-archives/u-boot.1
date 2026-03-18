Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77388FCD0A5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A50584261;
	Wed, 18 Mar 2026 05:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cFwt/rca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB593841CD; Wed, 18 Mar 2026 04:02:36 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CE1841FF
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkWvX+KTXZ4y0BCyPLtfpgKKU1Rf5Mt9WVbSYsTX4xsZ/tV02yzULpiOyEYac7gle1cJTdnBJnfVgELWFLOQKySbsToh8hefjn5btCTapzANxuEMo59GGAEZPAf1IZgv8e8WDzbZkoKDzHO3HwKR5RQtMJxr684mSe+WAwHs4xcO7FeEUSVRHMth1oW6Epepu6wjxBL/Gb0z9RXAsNpM8Jxwk7FQ5ZoJSgKUuttWLei5O2alwNG8mfBkttCtVSrYC8uru5ZS7nkwbIX3ALJdo74/z04ayDgsn0r1w6+kaSXMkT81Eg2rJTRzMROfl8y+Zns1YkfnnyiEtfbBadrUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/4gDB9Q+PDOAAiJM2GT2E1Q9+RgJk5xfknLW6HWPjA=;
 b=dUaHENco1YZ075dP/r2pkHxrZVp++O8Le9WbkWArmuKJM5wTNT0Kap8/vAdJ4KnXrAfMCzQOfu38BYKgcuHCrbGZrRrDLvuTtKmp7xovM61NC9pq99cl9nbsnL1V34p1+1HMs9JPceVglIQ4ABxUziJWi1d+VBDMdcikYtXwX/K8amqP1O/xGu/3PnIfaITQ5S9/CJGkODexx8Zz0uWAoaF00wVLEb+m15U9UUJC0D5NxfNR6CrrHJbQXWO8/9YH6fT7eS4oVwYOWlOmnuiaF0vyPmEQZ8eaG0Rjo3A7MoSGMU/FVDjsvQ4wU3OeElTv1ngr5FgmsAWpocq45B33BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/4gDB9Q+PDOAAiJM2GT2E1Q9+RgJk5xfknLW6HWPjA=;
 b=cFwt/rcaIMYPeSLS4iZlX4PgxkL89+PLgwMtVgeyHpaCQG4V+Z9n8ltEgpDQeGcf0X/NafOJjOKr+qC+fQuNGq/4gssJIs5l6SkZKqKdzw6PX158XXe00Ud1FJ/v6BTJEDiqDQYTJ3FujgAXUA8Ox/XReUV4t7ZqxDSHHEvp60nLFiqrrK+hYluT7VSRbGEQGJwzhV8u3eOvD/lXfKrzk35rmR1PoYP7NOmo8qHAeLCmA9iQp9B53Ts4LyVvsTJYquoscrWrw5RV0PwYfLuAq8gB9LvoKgCH9ZQurJElpyu5wAZiKCcAiQBxiNRyxaW/Wse24WS3zi2f7PbOsoOn0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BN8PR03MB5092.namprd03.prod.outlook.com (2603:10b6:408:da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:01:06 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:01:06 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1 4/8] configs: socfpga: n5x: enable required configs for DDR
 retention
Date: Wed, 18 Mar 2026 11:00:30 +0800
Message-ID: <20260318030034.25889-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260318030034.25889-1-chen.huei.lok@altera.com>
References: <20260318030034.25889-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BN8PR03MB5092:EE_
X-MS-Office365-Filtering-Correlation-Id: c5035357-d73a-4ddb-36f1-08de849a98ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eh/kvo0Hi68ejBYwDdFSSTcAxTGdfiACRYAorT6sfijFztbZxqYeGa3k8rIxlXhyoJEEaMirNxdsUMCWW/EBGSWYK1u8p2T1GjoTBQmTCOsL8WhYQyOz4JO8129q7PfZTBo8lKfH0v8wb6HcqoN2243qddHx8RtopGu/9ckV2XxVSK2jKjjSF86z7Gf2VazvBDVRw+DXWm2Eiw9N/RJ92g51+Q0wWJxI3iwwmcHh6unhtAUMOAamax28tqK+6WzFslf2JtOnSwd+o9pwM4DJQ2INVrXiThg5+1VQ+AluoR6AFtiEZud4hHhjgmjMfjJAwh6/8EfWjMlszVA/9AIFFj85GdPSQMArja/3plnlC+wkQwsNQcj8VSorMFSBDab4MVZAfdmgb8B/GGQyyZKZKliU+nyjTtM3iJfEM2U4XQf5JjpwqhmGkyFuEboLZVz0yz1KrWNvaOY1ZqixKAnu6hdQ1ooL7tguEUdrei8XR+5EO4gJ8V6MS7atuFl7AVs5qxcLDUUxCselEslKDnaWtxBYE+pzQIqvcIysYXZhaT8aN8gwV6eBzI6X028JVldbbNdExY/wtd7VCNKRHpa1KWH2aFIcYVdyJOWTeOJiDEzdgCEOQffkhyjkVAA8H8gBQ5l73CT4nrFtStMIu7wRIZLnZ5vE1CdGRielQSQuw5HVGgGGEkGrMFwVCz/VjFQCSerLBeSqfK/8nYGFp3YQ2et7KoK3lVu/0fXQJivcdGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8ALs929Ew6w0o37JYimwXMIxVw1oj7xDsZ6ShfLCHZUCvMXkE3zWihfGKUG?=
 =?us-ascii?Q?hUBqHaWQN4L/1eDULRtRBu3wstITsH07m3En+dtHO4Ai34DeAPqXi237mMU6?=
 =?us-ascii?Q?kbPIxL4qGUN5+KA0i0YwK0xJvQ1AtZjRfxBH6NzqY92MrNMuPeUbJE3PHfW8?=
 =?us-ascii?Q?f9v0OaD6j3U7VnLR14BLazs9kWG1wzyEz8It6OghU9Q1rk0g3rxLHRfONexO?=
 =?us-ascii?Q?0kDtCca9v8mYz7b17NJa8kIOHisCD6582+nDXNmJkjVDISWX2Wt1X01m34Bi?=
 =?us-ascii?Q?tQVCX/DWiOZD5Rk0Hk2E/dY6qTA7JWD9S+uQYxR3T+0rJqfm9Kzjw+1hCyLy?=
 =?us-ascii?Q?RwiysEsI4eP8oNYHBdfDufKsjREi+i+HbZbMgPKlNmnbm/Vym3XNexDnsERP?=
 =?us-ascii?Q?DppOHf+f3hfTFlEmqcnUB0wo7w9RAK5ZpEwtFcrW+hIkPTdFcjMuUACKM29/?=
 =?us-ascii?Q?kv+Q55BMTLVh3pxbVZBylfAtSWVPpHkpjhzg3M/r9oQzUQOxyOxRr6uuMKG0?=
 =?us-ascii?Q?7iMngnGVMc6qOyVMe979bYqmUidFJAus5v7Ztjt9p7ArQWeccpZ6co9zSgKW?=
 =?us-ascii?Q?o8Al/092bFMSACZx7krcQ9F+CzIwPgHAcH7Uw8hfXlAH+jg2DD/Ma2nS2mQt?=
 =?us-ascii?Q?1x5vOw03hFW4QApMl8WbVtqYUr9NYmKKsfIttvdvGvmbQ+zYmCKtSSHFI3UI?=
 =?us-ascii?Q?dmYQezAuQex0xGMfiepOn9B7SKBXLeF9/c9qyzRTL7SAAgPnt+Mol2ZmDX44?=
 =?us-ascii?Q?Z3TXZw7sLqBian7z2EcRyOLRd0iq4x8ny0l5lVOlAWdol/HBswKUTsGG3ylH?=
 =?us-ascii?Q?aZuiCqiJcePqOK5KpVu+3EmPeYWJhoayuDVL82M07MtaaxD8EiEPXhLUud7M?=
 =?us-ascii?Q?YlONFNrTK1wi4in96m2mD54DSjJ0a9ROqIM4h0gR6NHPofVauDufhlKe5c9y?=
 =?us-ascii?Q?Xnwp3j6v3v1IBldCBRuNtqJtojJg19+ckUTqag0SCFYr/T/obPi45DL45X1f?=
 =?us-ascii?Q?gdVpK56i2DBvPodT/+0KARXJStys86KIUdOKWM9n50VVt89msnnFhaqH/UNq?=
 =?us-ascii?Q?Eqxwfk7x7oaTnV4N+tmFPhPf+KQB4IgH42Kx/nibOi7AyKLrR4ctHXzHzuKL?=
 =?us-ascii?Q?GEcXBW/vSUK9dzyH3+S4TFGONBDOz9Xf0EScE4swfUykZQWZQrjPRrk9HHZG?=
 =?us-ascii?Q?njuLG19mAmyWncr3jAxxOxHD1ehkOpG1M1EbZYAcceS8VLCZlT7ddx+r5UE/?=
 =?us-ascii?Q?nU/lJOun+hf0vcyDdPiDkPuZVcRkcotD0lHQAeIMRJOTX4yuY5gf7jFbVUNU?=
 =?us-ascii?Q?kS+onLPZ9UyZB0yTqBV7yFb6tMsndFOg+TO5ihcRSqT1ej3NBYdGcrS4DYxo?=
 =?us-ascii?Q?Ok/cehdQh0cXQWddGDay2PC4Z4llUzt0lJuaxrqmpxAMRb93N3Pom8QFMymJ?=
 =?us-ascii?Q?mhOfUL0sONTfKGbGHbRLY6KQo0I3ALriRoBk82Ip7GdV82E1d5g9QUOlqRXT?=
 =?us-ascii?Q?qhjdcXscgRKVSIfviIjPTbpNNOZ8H+jvCSKOmvUXPVztK4GhJUawtB4Azpj1?=
 =?us-ascii?Q?MElsbz970NrhJx5VKzQrNrmA7R/BIdPj6ogBPFt/gPTW9vJcOOtM6IwT1pku?=
 =?us-ascii?Q?Vwwld32htk5mcPSuH81kQRcaZptDStyOgW//+/IH2de2cyIQEVpeU8ACMu/J?=
 =?us-ascii?Q?JYtzbFkWSloR9oo+vk9z9oTugKPLcFtaohw/2C0yYXzl4hRd6TakSXORV6cL?=
 =?us-ascii?Q?lRI6Px1HCVT0wd29CRQjmr63ZpOb2FE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5035357-d73a-4ddb-36f1-08de849a98ce
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:01:06.0438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNP0T+I+/DW6EJax95yg0W+tpByH2RmG3o4ZmS8LUWf8gpimmX4aEEoYmFRyqwTvg0EfW8pxtQEBtKpkXdxqIGRmQ+7IZI5MOyelEQMW7Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5092
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Enable required configs to support DDR retention. Including generic
firmware loader for loading backup calibration data, and SHA384/512
checking.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 7f567cb92a0..fe63756fd95 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -91,4 +91,9 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+CONFIG_SHA512_ALGO=y
+CONFIG_SHA384=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_ENV_SUPPORT=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
--
2.19.0

