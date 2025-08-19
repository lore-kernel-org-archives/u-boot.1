Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CF8CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8271D802C1;
	Tue, 19 Aug 2025 06:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rRyLSWrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3577B80422; Tue, 19 Aug 2025 06:52:54 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E10B8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I17fQH059ttxycgOy61s+BR1LlmoGReJtsfwwMaH2OSqS51HcrxqqC5w4Rs7hxIHLoah7mLq84dap2LWCdjpfhA7OA+3mj4RXwgq29DF1RaGAnGWQQngD/vH3Rg3gDfl0Psizsb2MMYUUXCtIIeQqRTtRl9zAwwvmvPbzEy0aCqNC6WBEALNkcbAIPRMupVQGWBsCYVqpNKsxWfkhE4sTOHdbI7u4WeK/4iZnWkxq3C1BS4DPZERdSaghp+jS/1Hy9GTHzW4WdoVQWdkWnFY/EZ45QVuHs0Gt2Xl5HQuLpOV5dkTRk+s5SI1CTeUZFn40jx+d+xnI32Jehiuku1png==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmh16lL//L7xo1WLjSoo2hJ1PApB3D9LhqCIHfSsUac=;
 b=f5eLSI4zzeJCraOqbzEJufCr3FO1gj1UsjZnrjehjDQSQmbK3vb+0kQyp3F7odbPVxG+FJbm02EDxQRwHLwAXv1AlhuyHuccrYRFlALAlbQNTfk20SnBPL6GBZV2ywbWlnfO0VKLY259rKlJUN7SXNBC+lY6m4THH/hI57aVcfde5JC/pSNE2qE7xgzV9r+CcLhBn5ZX5MADj41Wcn+0/4N8jJZvmubfuIvjnV3LrxhMXQJ6iLc0MRFDkVfqJjeKmyti4zCUR8CHXdq5YA1YQnBAVA4Exr1NJE00d+zj2JNgqMKsBF9ueMx7Aa6ZLJ3txbqOJk5Jo1axzhvar5gv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmh16lL//L7xo1WLjSoo2hJ1PApB3D9LhqCIHfSsUac=;
 b=rRyLSWrRlcxgth1KpYf1moPyO0SbFxk1RFFWrr+kkOQsumNv4dePJnxYFIlPNxbPsy4pGNhUxrXpJAqOPEFa/RAxEvs1+e3WAnthtwOfkJSCJyfjKFtH5IjM4DCPn2o3SKUXJc28BukX6yFagzErpV/djaPJbno04hn+3r6FEK4plHuFB5OERcAVd1vfqPUVBdJY4bHKCebFyCSrbl2c5k+p1Mmq21sNxPIfCofWvnNAuL+fqRe7m1DXRWxBM8HKVRdBauRsAyh6gcYTmShWYvU15/EP6N37Q5eDaxs3M/Oe+tHOW2C6NiQMLJKI71X0lBVEdJ+IEIJSOGIyirGLFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB8000.namprd03.prod.outlook.com (2603:10b6:806:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:52:48 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:52:48 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 0/4] Add SMMU support for SoCFPGA devices
Date: Mon, 18 Aug 2025 21:52:33 -0700
Message-Id: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d05a5bf-7524-4586-75bd-08dddedc3e79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f/fdC9gFqZ/fEXdSc/TdDoYrKtUMRFHsypRc0AbDCooE/D5YQp4keYdriJWt?=
 =?us-ascii?Q?e2CKdEGDlaovj1onw81lECgGa3AhGLOm3flVAb+tIUwftAsiGBklIhuesOwh?=
 =?us-ascii?Q?GURq0lrw4bcwgeGjNDgxG+hL98lZBX7tHRnvQ4ndkg4ar0+vPFhBFpgzGdm8?=
 =?us-ascii?Q?3a82JwakqFWoCfbz81n/NLdNSPWL9kNCannNYNPvDFVOYUxhyPJ2qAa9EVXm?=
 =?us-ascii?Q?JxiDWn21luRmwQzqH46m/rul51A/XGM+offYPzkLSsdIHryFMDBIJe1Aia7u?=
 =?us-ascii?Q?wSSc9hMrg8elrnIL/P4Vk6TBjWIOdqoYAtw28UsCX9I2CgxPjEqPvkHLbGEP?=
 =?us-ascii?Q?GjGKuuBTEcD5MVWUA2HSZfde4XU6ubXRaFPyjvhIkt6a1BLR9hA832sw0zE2?=
 =?us-ascii?Q?hwhL3fPU4bBzjzv1HDS3UaHweCx+xiJM9kDE/S0+pKf5DXlkmowisn8uPh5V?=
 =?us-ascii?Q?uw66edZUHRvjqYgqTr9tH5V/B2GGufTCcJvpEgGZnBOSzh29ncf4cByt+L76?=
 =?us-ascii?Q?YBHSaubFJemcikv8y/DECXrD1tjMfQDqBmSrL2hxrLfAdxLMO1oPt5BdodO8?=
 =?us-ascii?Q?IG+dGqFLtpfZjcSwFQuW8bXybmX8w7XaLLHenKxh2fIvNfWX/d9qHW/Q7Vb9?=
 =?us-ascii?Q?B2MvXI8W38TdTyyNZRo4f07/WBIFYI9LUvlQ2ZF2SCiFJKEfYxMz65G1eGqQ?=
 =?us-ascii?Q?uv0X/XjH+lwQaRZhAoHI7e6GB739bqEeeyqHxgC185i1XzBKFyr/aEDu5kXO?=
 =?us-ascii?Q?Gh0kpuyFWqXONJ4dfV8OcrUCbMtB+6e2YiUWnG5hBWOO9jqmTKUlDI9SjG8f?=
 =?us-ascii?Q?35mfcoWiobiDYqicJs199sYIu9HCqcWesuxwktllFLzLKGnEMDxbZNXKXC9f?=
 =?us-ascii?Q?ds5nQm6zJuvUlQzQwIyqiJsge8xLWGW5kVw+r8iRE9AZ0Y8Li0w0PKpdESnf?=
 =?us-ascii?Q?Ivd3mtlVxX8MBfgqAooUQ5sGwdPRtZxxswszDtiY3JhKM/ZE7Og9WSeQhcW6?=
 =?us-ascii?Q?joBPgxuzzfdkHPcqPRQ9Xv4r/mkwK+cC2/1zYrLvGWT0LMklrDG2I4Mx9lJ/?=
 =?us-ascii?Q?S8Nz03i0r7tsPG/YNg9incLq3QIQj5U5tCUUXrBpu0McvRG1bTWQg4hTr22T?=
 =?us-ascii?Q?ac6T9f9Fhezv/QZCz8lMTeSwHBdhrR/VRWsYlO1PG/8RaBDRJrNdtqhpVK9M?=
 =?us-ascii?Q?axtwyGKzCcnH7QUKeCAW2cjb7h0ZDbXs3/WDk6JGBfOinVWEwlLB+/6wVb1g?=
 =?us-ascii?Q?P5pDDteGI3A8GkUjwKBYB2g8SwPYRRlkSyTJUL+M5ZkewyVeDdXfx2a3qHLG?=
 =?us-ascii?Q?yWXmF6Bry1VUxRgGmz5AH9T/z0zbSaVwvU1z1ja/NmWYP4mniyDhY9Weusdu?=
 =?us-ascii?Q?UgOY7eIfDHULsgdjO9SiaBSBdxZZvq6VCyo+GiUoO6mjPmEIijvttjkUJcAj?=
 =?us-ascii?Q?cqNMfUKv008=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mLoJI5pW0IlgDUUSgsrTOso07GVA13Gn6jld3quQYn7rYGowoeYaTjGsclt?=
 =?us-ascii?Q?HlMfrIMIStmPY8c+YG/Zbpur9IOSScFNgRH9Wpu4ZZZ3+3bU7aXdDLUL3V/o?=
 =?us-ascii?Q?yPz2S+1lXOFpwwkhSRDf9yxJVay6E3k6f87eopEcWSB4tWQ/YBfuEIiityDh?=
 =?us-ascii?Q?SqWo2wQpTAlr90pYjx7/VCeq4RjruIiPbEoqi8onNJuavAEmGwZ9/MnMoMtP?=
 =?us-ascii?Q?52k0q3uGfbDfpvJiDWDnWZqQxj8UgEXZN7u8o979dFh9j85v6gAuRf750zOk?=
 =?us-ascii?Q?HqoteaDzT923vSmdLfLaY0NpaIVJs9hRHqDoXypufyNBtBk2uZTgIY457KGK?=
 =?us-ascii?Q?zRVhyicLDQevG+AdfE5MNSpPyVl5kd2wwHVGds4ChaDnwteNSJwCZ8GHVGSV?=
 =?us-ascii?Q?pEceeR4eVHSYsqiefGO33wZG9f2StakVHEDhoww4++q4G/ov9mNEC1VDDssl?=
 =?us-ascii?Q?yS/5cO9FyXMURdGvn1cFwtD/QU78BuX879aO51810rM9Q+d1p1oxvX2ayI1P?=
 =?us-ascii?Q?PxA+VjTPP5TWGSXSPn+lUyBE6YVQmu9a5CUBOd4vP1I+a8rpbXIOmY2+M4oC?=
 =?us-ascii?Q?CKZAlJCDFkRxT9Rb8nWkAwom68pHU9pSLdPvGMPA9IZDUB5eoPrGy5w0BRHn?=
 =?us-ascii?Q?/ApY4kgIKMLpNpLWv3EnElL9aTySgcT2qVHFdD0t7ogrVk7Cc5cKIfBOaQru?=
 =?us-ascii?Q?KoiX8tkSSOZPLPUrKhNS3HCsZoZrFkIjx/JFFMFZrrkYf0RuEqIT9m9Wi/dv?=
 =?us-ascii?Q?QqCgxOA8kVzbkdKrcmE1WfuSGE4lzzD67QBe63cTj4pWwKxNFLy8eIKLHoyR?=
 =?us-ascii?Q?0bFjQ9Rs6kXCAzv6u+InLGuBSnIwpcdeTZa7MN/sXPQknBKMoFS+NFefSqhl?=
 =?us-ascii?Q?qd6d70l2D3elhpvL53T7waPyLxyatz4pXu7pbSfTe6Bcqfch8PTrxb9x8GM1?=
 =?us-ascii?Q?d9zOe4Z/TG1bdqQ6mY2bdm6KbnVFRPcMzsWBwzXgN52d0yxXhPG1wq5OMOVR?=
 =?us-ascii?Q?tOSlSUIMe6OjcqsTw8Q4nDbV/n0p+V2RRfjV0t4xcGtvxQk7/c4rSN1lmpoq?=
 =?us-ascii?Q?cK82kez3gbe1WEmL/tYLTiXN8ZMVoe67wIrQwSaxwuXpoXLkY5z5C1Q9pY/U?=
 =?us-ascii?Q?BfuhFsXjKE74FrUqUS1wm+Iq8yI3BOV2AWXZBBDT/zSF/W2KdBSaExmoIHYm?=
 =?us-ascii?Q?XJZ9TdLJXFt/iVCOgPF/4cdThS1LcuiyGfp61V8rCICjQKUqg6U4ZvEys/sS?=
 =?us-ascii?Q?jmadpakVHsfGUcBanmgtGsPWmEtla/2o15lgxLKzpbz/LaJrD6q/yncM+wXB?=
 =?us-ascii?Q?XkAcLEE1wkSpTjg+WQZ4ZyCP4lZxkaO3w2YRAqW3urGZ6LlPAk2fCF1rCesZ?=
 =?us-ascii?Q?qOXJAT4nv5hw16GowznKKL6hPbshwh270NlEwfxvzbhSTl5Fo81MApfi/6oL?=
 =?us-ascii?Q?mz9uP16wFNBQrOfox7tC1hrazfT3GZDGzFCBd4GL0QN0HLEtnKE+gpEVt0JU?=
 =?us-ascii?Q?pVE3HzxGqVZO5qtJFvhOfYBIsxI/QxE+1P9p7XH+18WEZJCWfXQk8WVYZypD?=
 =?us-ascii?Q?UIQtilqE2XeDI2xphap3d7YWn1eEJ01sdPY2n83Gqr3I5Sol3pBYm3I282si?=
 =?us-ascii?Q?d9rPqw5nQc+skX/0nI7jKoc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d05a5bf-7524-4586-75bd-08dddedc3e79
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:52:48.1769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5T7IuAVPDlSqHfUMcwCENZ4Rg+tZtd29/bOEfK0Dhf/HMcRwcczuyzoTffStKjaBAS/13hgjVmW5V0WA64NleRTJdV4qNtGz7SQ7JWGBVFp3Cb8/VJPsOOQT7aHPxmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8000
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

SMMU initialization, required stream IDs setup and checker functions
have been added for SoCFPGA devices. A potential FPGA
reconfiguration issue involving Secure Device Manager (SDM) when
end address exceeds 512 MB is also handled.

All the patches have been tested on SoCFPGA devies successfully.

Naresh Kumar Ravulapalli (4):
  arch: arm: socfpga: Add SMMU initialization and setup
  arch: arm: socfpga: Add SMMU checking functions
  drivers: fpga: Check bitstream address doesn't exceed 512MB
  arch: arm: socfpga: Move SMMU init to before booting SSBL

 arch/arm/mach-socfpga/Makefile                |   3 +
 arch/arm/mach-socfpga/include/mach/smmu_s10.h |  73 ++++++++++
 .../include/mach/system_manager_soc64.h       |   3 +
 arch/arm/mach-socfpga/smmu_s10.c              | 125 ++++++++++++++++++
 arch/arm/mach-socfpga/spl_agilex.c            |   2 +
 arch/arm/mach-socfpga/spl_s10.c               |   1 +
 arch/arm/mach-socfpga/spl_soc64.c             |   6 +
 drivers/fpga/intel_sdm_mb.c                   |  13 ++
 8 files changed, 226 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/smmu_s10.h
 create mode 100644 arch/arm/mach-socfpga/smmu_s10.c

-- 
2.35.3

