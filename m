Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D765CA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 07:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52B980FA1;
	Wed, 20 Aug 2025 09:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uLYTsrEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF0582F30; Wed, 20 Aug 2025 09:32:28 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B70B8006D
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 09:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YO6uR09hmSP2SH4fbzR8qw8HrBPFtpuHyL8OBqsOtpeYP9FZA8St9cJT+NgWOyBBXOcsoLl5k85sisa8wIR9bECTQXk23Fz/RhX71NxDFBPuz/danaE9LYrb0TFu3vbn3J8+F+Pbmf0FyAPhYPxf3vVoS98L/LEOMgZPcD2oHO6s6L15bqOZiy0jzA+onBq2ovWzS6F0d4NsxTmfnFbCO2vtS4slRZoDJ0jhYilqnTSCqjSZB47wZavslEOyYcEm6Z+sRJDvpcM+Ta7rGuhGtzx6xG3utDURfKh+Rn/wUqorIkFcvMg9jWbx8JKBzeZBMygR+ifQdO1B+SVbXQPCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+eoaViVTed8FVNjVFLITEJJvyFZXPptWr+2sxZ9VOc=;
 b=DUbpQ+ioRH3VKNYXWAwXoWSAaSA2mgjNyfHy27uoP9pv9AZs5cu6ZIi5nFRaKW5MeriBAXjdu7+A6itlKNonuk9FIPgrYlsxM5Mj07gWKNXE6CvW5usBZNaMkjSTRL+UgcVSQKg3faI20yCVsaeTbMwTnSowIIP2mrbbhg2kYB3mCiUbCM7VC3IuwZRfIWFQ1nJKchG57zbErC6eUuafV8EKUIrTogzhREAfZNEhhCJ5mZ/VtkFrNmsH1M1GVdL3rh357gaKMIpyZRVuKF6ZRISklhLyRwAFuzQT5/2SJ2VhjCx5T2mgG6qRE6JmMhboBj+Zs1RX0EZTDZhWqnJ9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+eoaViVTed8FVNjVFLITEJJvyFZXPptWr+2sxZ9VOc=;
 b=uLYTsrEzU3LqAj3C113XsWnOiTWpFvO/hzxcEWIFQn4ugdNlEMGHGVsKulWmZdt4yyIWpM5RzRsIEBly1mtonIHj5+i+2nqcvFEq04twsTtnR1cvRCo4bSG4K54Vj1QF1WNzOd7tcfZJ8wlcYzBRJ7Cek55/wo9GzJzgoly1cqwgq9iw4QlzOmoac0ZNwMB8y99gAnQYImyl8eQDaxZQjHi+FjjGpC2As/7GVUH3DyfbyS21xMGu8lgCAvD/qpau9QJ/EzIXcnfn7azZ1yuUi6jhQXTiL6DrXQnx0ToVSTYCbV9u7gxDBs+phZoh/qBZPj808qj7EuSWTz7967okxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 07:32:22 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 07:32:22 +0000
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
Subject: [PATCH v2 0/3] Add SMMU support for SoCFPGA devices
Date: Wed, 20 Aug 2025 00:31:58 -0700
Message-Id: <20250820073201.8649-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d67d1b5-eb66-47d7-ad64-08dddfbbb3a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w6kYCw/cqZEqaWmi4RKvFtTxXCa9Nmtb70ddZ8phYaonG/rA5cq992qEzyD7?=
 =?us-ascii?Q?rutzRTGy1IfAbcdpCMoH4dLwo9p0Hc1fZbULh6/wqp4CO/1iz/ZWvP2t9N7p?=
 =?us-ascii?Q?G0djz7CQsRpwIiRfsd69FxeZyGscZBrGoR7iSkUGdJO/FuqymRggnUh9fEVH?=
 =?us-ascii?Q?gv9vyu1C4DxTTg5ybvb6CPrdWtnxIyU6mCE9uo4nVHVChrQ4cFiPimD52cU8?=
 =?us-ascii?Q?7cBAu1eAQCSdUAAeqdQvM6L98t5bwXOXOV6r7rEvkXNST93MthQ48+uSuZwt?=
 =?us-ascii?Q?vBls2bCBG60e158secPyUuFsULcRZmOvsNpmAVTHKwkIOl1szPYcFSkGC9X4?=
 =?us-ascii?Q?6zlTjtYFRuU8l/UhOChVZZ/gCBodUQHfXnrSDMhtUX65QCE+o9qt+eUEPDii?=
 =?us-ascii?Q?5ETvGfSA/cOJeU9P+WnTu2naLCNByoz9mdQcZg2F22p74qZrjl1+y3DnohT1?=
 =?us-ascii?Q?QjVMBIf0ju01MzjDMdu4qyz8zSWFD8mqAriuGHt5kLeLfM5xrt2xpfPvbqqx?=
 =?us-ascii?Q?S2VaD7yM3F6zEzYWP+qmavvLJulSInTx6oj9eS72CQMyWr4r0wxko4mYu9kJ?=
 =?us-ascii?Q?gLy3yMINlqzHoQSiV3exH6HqcX0mMqRGVJ6NrtZoZXVx9PtOeO+D9yvkcrdJ?=
 =?us-ascii?Q?HwhYd2hdXEboTvNkGccuLdswA3Cn4nbH9L/0ESNh1ynkfUSyRGEwHnkllsl5?=
 =?us-ascii?Q?QztuymdoY6kfTselb2OS3sZSmpLJR9gB4ZyEA5yYRNtH6MEHq5PbgeUa+b6/?=
 =?us-ascii?Q?Yq3DKqMz9IF3t7VDeGIllODDjcqzKdNsBD0poroiqFlT74ROMtqEbaGTqm8Y?=
 =?us-ascii?Q?u9LwF0TVSHfX/yASCDd/w6wJvtlY7KPHjFY/amLPOGE1KGdKy3Ws9zzESSPV?=
 =?us-ascii?Q?MMwASxoopffaGCOh4UiahO8gOnLX5ki1ekdnZrCc1TgvMiSHnTkyFX3bwCzW?=
 =?us-ascii?Q?FXfXz2mgN7dyMbuy+biR+EQ5H86UnTTdQ0oOxqsQbFsLOfZOt50sGr9hyude?=
 =?us-ascii?Q?tgVSxVQR+JeEY1V1g8/QmiLCXiXLRkTJsZyjH4hFH3NKB/iJj/tMaaZR7DBy?=
 =?us-ascii?Q?bB+BpSC55v19GT6MxJ43qzPi6Vncx0+xWuySnZ19Lq6rzFBjsNYkBLllsWNJ?=
 =?us-ascii?Q?Bo6m3yiHOoMdDt8ImQcfemKyKOuACbBfR8sPt3RMfr9+4+2kLjLu1JEYVxNx?=
 =?us-ascii?Q?NnMfD4aCsnnw+7geWKg8OzmrRjk9hYIUFWD4vRvfcQakSgT31EsUfRWHBe9K?=
 =?us-ascii?Q?QuDV550bxbYG0xfpCUi2Jhzz5yCcow52ZEzdBWZDvHUIgvKh1txXR4hxKVJ7?=
 =?us-ascii?Q?HDhfzGGd0hWTAZFfxv9jXW2o0K4UkxgXNc3C9FwQY62aw32Pu3/3D8AOYZsm?=
 =?us-ascii?Q?QzFH8t3I2b9B1kfxz6IYduyoSJd6OYSLo0XUa3eOqvERH09ZECXIm8yVT+Sq?=
 =?us-ascii?Q?8eBzH4z43oE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zjxQl0ITr9qOZ2RfE48LQrho7YxX3dC5cJAwelky2RJUGNLJiJgCzhEraqa?=
 =?us-ascii?Q?slZnGjEnFvNiHXH6dLbc+Vxo86luUu7jS+o9VlTE55ny5hXHwx4w3sa0kqD3?=
 =?us-ascii?Q?SvOPcnC3ZkKrlLvCSB+L6GQ9X0j5gk0x1Xz8nDJHEYlsdNyB0z63GNAPMzlw?=
 =?us-ascii?Q?uJG7O3oVMdUSaFEjy5LjDVCZ+Qf/A7KNOgxgj/ZnKgrzboU6HVKaT+I72/UM?=
 =?us-ascii?Q?ycuIF6uIk7Wv0Ud2bH3xuVCUvuPgVw8O3jkMvrtu4jMEP+ef5iKP4ui7xMbK?=
 =?us-ascii?Q?YNzSnaueaLYiAZ10cGkzDGWdaEulTzkau+LeNpzpaTE0LhwdhsuqkYm3PcC3?=
 =?us-ascii?Q?odH+e7kOCbg/OqCNCrk7kA5JyAVcoVhcNulIE4HC9G1taihk+IQNJ9CSR1vL?=
 =?us-ascii?Q?zJyROU7aeLZ3ToDdbhDrvQdhETnYV74yltvRu4ndWrt6l6AUnAeqIhL5rnS6?=
 =?us-ascii?Q?Sr4DFf/mVOF2fz6fVxBvEN41OrC9l8QV/3RlsqIj6OCehkl2xNBN5B8CmbGY?=
 =?us-ascii?Q?g+GQXCpvPqB4gToNNOK9Tgq91I2ajRzg3qLmwqZ7aWcin/qO+1nQqwa2ZE6i?=
 =?us-ascii?Q?30pKmfCwb+NIplms0vHaZne5bdKRZDpeW0TQ1x6RcKy6nUv1AKj4g3uVlpdz?=
 =?us-ascii?Q?dT86hLZyKqIOL/TpmUmnvuCpepWlxOkWQqpyAxHrpEcV0bEFD7Fvh7dDVSj3?=
 =?us-ascii?Q?raZY/A44KK122KRrNHxAS/zns8zDnloop57tuXbljatKpnPM/gbNpZKbPY6w?=
 =?us-ascii?Q?6tXC8tY5wP7b024liYrA9+fR2Y0Kbx7sX8Ec49t79dDtvf7D0nrZPgwJkz8i?=
 =?us-ascii?Q?iykVZRd+smD/mxKl5CTr8tOLzatKJU4d+/p4UMmYM/6jtzPWXU3Hjxss9FDz?=
 =?us-ascii?Q?nMyMtMAcRXX6RUee9LdNIw18CoCUVZ0kouzvS2HkT4nFFy2kZRBYMFC9aSpr?=
 =?us-ascii?Q?eCOIWcKczas60OFp6M9j4qHWu4STAS52bD84huYu2k3oKZP7vvWW0BXyy42V?=
 =?us-ascii?Q?lpOAHREw50vejb/hbUj32GNGNcIwt1zuArARC9u2u8boPTdo0ip84g6Rv10n?=
 =?us-ascii?Q?CvrsN+yd6CKDOrRUwmWu1s1lj13Yp6jFaSA1DFbZKsefgxjc+rtxJ/tOZUaz?=
 =?us-ascii?Q?oSbHWdK+viiIB6m+twEIzgA594mGBzuMmJNxwa8+fRNHkHM0T7mC4FHkxHiT?=
 =?us-ascii?Q?4Ix4PnZFQF7gGA2ixDgvoyAzZ/LGSJmaRj9x/pR3bQNNX4CbQ4Syy1jdFOsn?=
 =?us-ascii?Q?aUAf3nxx/qdwgZlTIJ0jS3c+lJV4egwUtFcuyH9dIbnq33IoJHfMTU4JIPNZ?=
 =?us-ascii?Q?n0G8b9PfkpSSAHMfqGEDvqLQUsMPHdreeFS/NCiG2VPqrYnceJd07A2Hh5SD?=
 =?us-ascii?Q?VBHFD/+/LUO8+sxjQx4LbnN11JtOwfxkRdE4JiEzQSQ838Q5qI22OlOQgsJ1?=
 =?us-ascii?Q?7SJxtEIdQQEeeqaWnoK7wI3PMV1sYvHwAhb3oNDfdZiTcqeOxvQMenaFfVY9?=
 =?us-ascii?Q?T9ub4zCZEv4ElXR21L2tNLRfE+2D/3Ple7UG0L/rzM0h+VFr9CWXZm59Sm8d?=
 =?us-ascii?Q?smz/qqkPff7Y7TSOkiuuuWsAoceSE0WJB+oaNqcGg3jc5jc39vLMiGauSrBY?=
 =?us-ascii?Q?vMeXlHzx3/ardyXrUk0Da+g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d67d1b5-eb66-47d7-ad64-08dddfbbb3a6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:32:22.4574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c08kZAJqz287S4DL9yBab3LB7iOS6Uf1wQxV1OThCUvnEhTNHa15o1R06ar4HRjsT9KohmFVzwtDf+mgqaqqs3r1lkcyyfkUjMLYuf4bJjNJ0Tc9FB+l6/ywXAucaDdw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982
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

Changes in v2:
- Restructured commits to avoid duplication of code

Naresh Kumar Ravulapalli (3):
  arch: arm: socfpga: Add SMMU initialization and setup
  arch: arm: socfpga: Add SMMU checking functions
  drivers: fpga: Check bitstream address doesn't exceed 512MB

 arch/arm/mach-socfpga/Makefile                |   3 +
 arch/arm/mach-socfpga/include/mach/smmu_s10.h |  73 ++++++++++
 .../include/mach/system_manager_soc64.h       |   3 +
 arch/arm/mach-socfpga/smmu_s10.c              | 125 ++++++++++++++++++
 arch/arm/mach-socfpga/spl_soc64.c             |   6 +
 drivers/fpga/intel_sdm_mb.c                   |  13 ++
 6 files changed, 223 insertions(+)
 create mode 100644 arch/arm/mach-socfpga/include/mach/smmu_s10.h
 create mode 100644 arch/arm/mach-socfpga/smmu_s10.c

-- 
2.35.3

