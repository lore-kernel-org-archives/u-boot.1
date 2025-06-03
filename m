Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D6BC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF0482B33;
	Tue,  3 Jun 2025 13:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Db5Eyh9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E174C82145; Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C629828A2
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feQ8Gl8h17XZCtf9aZil0Ei+jEgSrKSDHVvffon5hLlSlXOdIdAG0WQf9ZcLO8P9w7ZE78tIEcFOR9CCeDL3y2hFqwgUu/etvQKml238jHJF2E9K8vh3zlKxMsyTP7zG1RUeCFqvpf4Z2XKM5o0KVUJitZwMjg3qEyWU/k8xaa2DgT/YXiDRKPuOhQDflTcaVRkErLNJmeAWPzDzr2SJtEnTaaewq1sUv4vJPwAaJf/iJ23O7K51riP3D7TZkrX0s7bEZJJupxJiKK1q8dqBn1Dkd3uLADzzN/TT+xY+g3dqW8/Era+9/vBxKM+RlIsFsmY+jlAJ/obVp6ILD7XeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg1FkHFkFiJ7O0Evdr65LFSJEw+3L70bpcgCX+GmTmg=;
 b=MRC99R6qao7p1MEWSdRHBWMYfjTVtxMYYBvniCdVPsHtaMBFtB0Xl1LyNR7621WRWTrjiq9pla9FbU1N9n5oadp/rBulZaOA3fsF/CkgYDHj+ylHCFHIZqchQ62w2xDIytRO+Fd+0eCCjDcG48F/3cDkIPqp/ua3mU9f1vdzUqgrLHbNO8WfgjQhR+tzBqkNT1TTz2dv98nVysZV2VqkoizrSRPJnHfX7xjhLGTrtOuNCGVzugikDFhejScJqz+YbfT+8mAzbeTtcbRRiXhUAvDUzFLbpfshVi6oP+b37F9d/d/26yOGEY2Nv0xPo5HDD7hKqeYCJ6npBmh6tDwWGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg1FkHFkFiJ7O0Evdr65LFSJEw+3L70bpcgCX+GmTmg=;
 b=Db5Eyh9m7ZH+zKKXa1WzI3mFksslJe0pPe7zIuaL3+DRU5HKEwO3l34Lmi+sq7mv0MvhK25YqUvSfoa61smznuZXGv69KdPjah5Ryr43z3L0ZDFk0qQ38GzuD+voTNWgFox/mnFf14ewZ9o0yu3JSyepX7DuF4MFAkvjpjbxuNkTz9g4lZZ+x50hCdExb2HU0ay8wGPZePZaZMM1aR0Fclgd5F8dwoNT0OavXFrXxen7nWUNif7SrsohsNaBtfUrbKCDsxUk9U7CyqU8bdI4XuGJJl2FG4U2kwkyMpdLCczkWfQXk3CD0bb6RgQheJrJ6+3NGoZaYRF160MgBMYomQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:59 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:59 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 5/7] drivers: ddr: altera: Correct code alignment in sdram
 file
Date: Tue,  3 Jun 2025 04:54:40 -0700
Message-Id: <20250603115442.19971-6-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: f6026050-c449-4045-b19c-08dda295777b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fdYVAq2Vq6QdtHQcQDBBK3Cif/Tm/hty0HT9G9bOS5cmbmS3tmzMGMwsBIg9?=
 =?us-ascii?Q?jJ7+ghslK9Nrm2iJmLxA8b4i20l/+LzYswwovV/k0BgG8wuUHo+7JtYQTsB4?=
 =?us-ascii?Q?dS9iqsugcLtq8pB8UjEYtVKgEx9+MNSG8HQ9LSl0ut2iSszfethYxjlqxZnA?=
 =?us-ascii?Q?JnqTw+QI88eOGjdJwFwWs8MqzFynkw3RHI2t3zLivGZ9hX4kJG6SksQL1VoE?=
 =?us-ascii?Q?DL+12xThkmpqrZ4N1JSW6/ks8019a/YRyXrKvs0DBSFSbGe2O3AVqbJDufiS?=
 =?us-ascii?Q?kF2AhQV0ybGdcaJ4V5Mxd5KLY6JFovk8HZ7tkvqYtYlNo7xZA2zwWgPEMEQG?=
 =?us-ascii?Q?DRq2BaaY9UDM1xaeTDFrO9iBB4dZ5Vw13wym845MInB/qfj88PxxtjbS8+Cz?=
 =?us-ascii?Q?6USNhwASEl8RrdAYEexdQnPqzCC3F4EMHVN6Qc4SwSTmxX7k/6hG06fDeDAf?=
 =?us-ascii?Q?jnjGUduu0Q/eYl6MpnqjuIyAydburuh+LtVZSXgvXZQd1QB9g8jnzmNgAE+2?=
 =?us-ascii?Q?2g4pFUlfV+ZdK4Ze7k5ohN9r68CjVBYNCp6NiNclXQqI8T8FRWsqITuiyjWX?=
 =?us-ascii?Q?JQpvM1+M99zhD9xjPqWCaA8DDwKIJ3XIa1AvjfMYUvMpT1RY3H2QoPITkhAf?=
 =?us-ascii?Q?Na0JRzYrIg/78MLSavqjo6rRnEo19mxRScHNHBSr1FLlBl/oirLsf/syeT5s?=
 =?us-ascii?Q?l1Ix/MGzW4GiqgTo0Rdc8z0i4EEe7Z53zi3RUwtVKpwjJftnYsItg85/TUVk?=
 =?us-ascii?Q?bn3TY337wU2u2yFNutVYVmX+ImBPtKbG98B16t/TPCr7cb2x0qG1NyWh4mEt?=
 =?us-ascii?Q?do5DxPvTDmdEW3PzEcRCWa3cpIS0oZFvw45p18QOQXhaKmCMaLLg3oT+sOZj?=
 =?us-ascii?Q?hWDrYleOa/MA/arQyOmUmzlDOYZCaFMvvW3u3M6VVLtaxLKlBYwxibrCZVMl?=
 =?us-ascii?Q?dm7ZvJWkYWmbd255KtAyT2eMOn4wiI1GDSFkfvJPX+1M496Y+J03v9+SIBWs?=
 =?us-ascii?Q?MQcmAKiwanSDZQ/lUyMkonVb/0f0D6hwxTHqUISI64V68aLwAvOdCDu9wF0J?=
 =?us-ascii?Q?JlBTZKq7NgctqFSFqSlLDimzRIRPHLnJLhfrWB7OfZROV2Y3QrhmPhJgCNSQ?=
 =?us-ascii?Q?VOOtuYvOB0750CeoVHStEvcOi87PXPu3U3tFtfshj5T/WpXETMIh+uy7/AGp?=
 =?us-ascii?Q?tsT9S0Gna71eqHuv4QX9NFGgHVnw5wM94K8ff9z1u0P1Q1yBM1TolOfN5kWG?=
 =?us-ascii?Q?VoNYAxoLouNrE/qf7EzsQkWlv+h761gCPhySNGZWKjLMUVRRXV91axR3yvH3?=
 =?us-ascii?Q?dkBVXWxK33JO3J8L09opm2DyF4n4IfmD/UHRk6Ck5+YgasBMdfKMTAaTxZnB?=
 =?us-ascii?Q?GjtJAOKomd9Vitg8kwFfWc3WgCG+NnU5fyCRSpMSRBd2dFZvjjMpA/Ve97kz?=
 =?us-ascii?Q?KdVmbN9yJO4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XRI4W3JyHRdJtYXp470GZY1YMq4h7T3bAP1LkK0ZGks4GRSAdLovfJO/dqCl?=
 =?us-ascii?Q?cqmki3QkBD31/SiMCTNolkBnWSFhc15HrYUU2YNVyWM2PK9i+LT/89ZA8+eT?=
 =?us-ascii?Q?agbOWiw7cCC9Gb7i/4Uitnu29gJZoPbcXYVaDZrDIEqUiWlWAlBklG/5mqg4?=
 =?us-ascii?Q?RdFwKlNnzqanfO7lnC/euAEpxC+xkaJO6v2ZH0EaiqQRsHtR5fOkFYiI4k8V?=
 =?us-ascii?Q?wYyAsTgqWRw8EMSM2oS3BTRmWvShTZHfZusn0QAnqhsa/J+mstYJJttkgjI9?=
 =?us-ascii?Q?CHiqjgc9TksDf8hxvNE1RmW7+wPqglUPlwP+IrUQRTDMxws9m+ZKOGVjnZW+?=
 =?us-ascii?Q?SZH7R2KSrhTotFhcxWDxO8IAOKtOSdNrgzs7Uk1kbsRMy1XA1hqKfO4knfct?=
 =?us-ascii?Q?bm+eR0zHq7O1Ld3thKXB5V8bWNbYELxy6IGf8eMD4LUaShMYmBF39O9J30sM?=
 =?us-ascii?Q?QqFw/HzuFwoGJIKZidDErSGqCcDzyBT1m5WLcS1MiCUDaxhE+vVlT2QBzIOE?=
 =?us-ascii?Q?AaibAK+yburz3nCTLpO6TFv/C0GzGaRwvd3t/DuProqOddFjnPJyrzXOI0Xm?=
 =?us-ascii?Q?xdBqhcrrDEITlUYPxqmnmnuZhbBLLtkpiSlC6CQqMoDYMJLGP6n1vMpg7elw?=
 =?us-ascii?Q?6CHfVmIoeYXfR4IJT++5G8AGUzfIWq5arC1Nh5riFRClpt4BL35DvmaR0G/u?=
 =?us-ascii?Q?SnQ4Ah1QQE6moeBSQlxhiIxeW60cJHdTQRsHWMyFchUSNZ5c3WrG8ig1SwV/?=
 =?us-ascii?Q?iSlPSaPV5E0xQP/jSN5yNn+Rb3LUpkXHMa2zcINvpM6HA+i8kr3qPfdWluLS?=
 =?us-ascii?Q?8FGlVfsYzl+k3s0Pxeoqpy0n8UFlZy12EBoBYm9mypoGsOHOwq3lmAo1hfse?=
 =?us-ascii?Q?gCS7i5iWxcZYLGej/9aMYlyPyg4kNZq3iqxADQFP3aVh8DXxTM17vUYr2IbP?=
 =?us-ascii?Q?SzU8XZ4pLSsTmj5X9VB44xGBszoRtgklZtKzNczmo5yrCgRfaP47iamU0xXu?=
 =?us-ascii?Q?ZWqcDG0rS1AXy16bwWu3Hz6Yp+CHx9HEkQ3N5RAzaesEALUt/4neXcXrw7yh?=
 =?us-ascii?Q?n1YsZbIWMQsEV2bR4zmMuHc2CN/qmkAZmUj5YyP5Ok7uigtkrb+i4k1kqeCZ?=
 =?us-ascii?Q?RMolyjdX3HciGPyRlJTjzcqqjupBq3/qVlj+wLpOS68lJnuxeSiKJ7Ti31v8?=
 =?us-ascii?Q?pc69NCCe2Up1/cZrEVDOG7oWoteSEJ6S5sHHQy8drOwQLWknMGUzxi4xxG1W?=
 =?us-ascii?Q?PT9iaRcKzWO6yeRV5XOtZ7hfZnulIRUTHkA1SxCTaDGJ5NCrjgm3pvAmMfkI?=
 =?us-ascii?Q?qO0jBO9aZoGd6SeW+FcVQQIxlACq4b3GhV976I2uxfufs3fNBySyfMguplMh?=
 =?us-ascii?Q?Y22ApOWSVn8cdRcqcEeodqHV0AU39fjo29aprQVwisfftpWZ4wJo54la5iA0?=
 =?us-ascii?Q?5kon1QjYjeWv1Uw7w4a1eQSkWYE673F1Y6Vdhff1oW5m3M8Vv7mJDNWBTtWq?=
 =?us-ascii?Q?Fmp8Hq2FF4hcVXflBCiXT+rgSq0oD1viLUUlOz/b5ThCpCwxt60Ji+30A0S+?=
 =?us-ascii?Q?pn+RkGZLLV0iPCXj3LXZ8DPneAPllZcVrfWAhI4Xp98DuJRZ9as8ff6W5ZWN?=
 =?us-ascii?Q?2zr4aRlC8cdW1PqYNkYmtVQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6026050-c449-4045-b19c-08dda295777b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:59.5941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCu9pZyxtvABOJsVQD8Dhf5vjrs8ceLnny9PzcDF9tfL58s0zo8PLB6YakyprGObuOlirxy2U+60CVCgCS+TPgkewXsHvLm2RT91gCmFmg85Vo+w9ny0yFjWr69rFdjF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

Code alignment is corrected in sdram_arria10.c file.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 56 +++++++++++++++---------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 4c48b1bab6d..a1288d5fb50 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -128,10 +128,10 @@ static int emif_reset(void)
 	s2c = readl(DDR_REG_SEQ2CORE);
 
 	debug("c2s=%08x s2c=%08x nr0=%08x nr1=%08x nr2=%08x dst=%08x\n",
-	     c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2),
-	     readl(IO48_MMR_DRAMSTS));
+		c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2),
+		readl(IO48_MMR_DRAMSTS));
 
 	if (s2c & SEQ2CORE_MASK) {
 		ret = emif_clear();
@@ -161,9 +161,9 @@ static int emif_reset(void)
 	debug("emif_reset interrupt cleared\n");
 
 	debug("nr0=%08x nr1=%08x nr2=%08x\n",
-	     readl(IO48_MMR_NIOS2_RESERVE0),
-	     readl(IO48_MMR_NIOS2_RESERVE1),
-	     readl(IO48_MMR_NIOS2_RESERVE2));
+		readl(IO48_MMR_NIOS2_RESERVE0),
+		readl(IO48_MMR_NIOS2_RESERVE1),
+		readl(IO48_MMR_NIOS2_RESERVE2));
 
 	return 0;
 }
@@ -224,7 +224,7 @@ static u64 sdram_size_calc(void)
 		(dramaddrw & IO48_MMR_DRAMADDRW_CFG_COL_ADDR_WIDTH_MASK));
 
 	size *= (2 << (readl(&socfpga_ecc_hmc_base->ddrioctrl) &
-		       ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
+		 ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
 
 	debug("SDRAM size=%llu\n", size);
 
@@ -263,7 +263,7 @@ static void sdram_mmr_init(void)
 	if ((readl(&socfpga_io48_mmr_base->niosreserve1) >> 6) & 0x1FF) {
 		update_value = readl(&socfpga_io48_mmr_base->niosreserve0);
 		writel(((update_value & 0xFF) >> 5),
-		       &socfpga_ecc_hmc_base->ddrioctrl);
+			&socfpga_ecc_hmc_base->ddrioctrl);
 	}
 
 	ddrioctl = readl(&socfpga_ecc_hmc_base->ddrioctrl);
@@ -351,11 +351,11 @@ static void sdram_mmr_init(void)
 			(ctrlcfg0_cfg_ctrl_burst_len >> 2));
 
 	io48_value = ((((readl(&socfpga_io48_mmr_base->dramtiming0) &
-		      ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
-		      (ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
-		      /* Up to here was in memory cycles so divide by 2 */
-		      caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
-		      caltim4_cfg_pch_to_valid);
+			ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2 + 15 +
+			(ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
+			/* Up to here was in memory cycles so divide by 2 */
+			caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
+			caltim4_cfg_pch_to_valid);
 
 	writel(((caltim0_cfg_act_to_act <<
 			ALT_NOC_MPU_DDR_T_SCHED_DDRTIMING_ACTTOACT_LSB) |
@@ -413,23 +413,23 @@ static void sdram_mmr_init(void)
 	/* Enable or disable the SDRAM ECC */
 	if (ctrlcfg1 & IO48_MMR_CTRLCFG1_CTRL_ENABLE_ECC) {
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
 		setbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	} else {
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
-			     (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
 		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
-			     (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
-			      ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
+				(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
+				ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
 	}
 }
 
@@ -642,8 +642,8 @@ static int of_sdram_firewall_setup(const void *blob)
 		}
 
 		writel((start_end[0] & ALT_NOC_FW_DDR_ADDR_MASK) |
-		       (start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
-		       firewall_table[i].cfg_addr);
+			(start_end[1] << ALT_NOC_FW_DDR_END_ADDR_LSB),
+			firewall_table[i].cfg_addr);
 		setbits_le32(firewall_table[i].en_addr,
 			     firewall_table[i].en_bit);
 	}
-- 
2.35.3

