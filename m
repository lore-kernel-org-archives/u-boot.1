Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B3C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F9C8175D;
	Tue,  4 Mar 2025 13:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="J/47N8Sy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 415E680F92; Tue,  4 Mar 2025 06:07:07 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02B038006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4qJWNagfrVCVfVOCCjtO+PSHKhTmv97eSL1h6/l4YpuOYZAg6MYHtDuznX39gyaKs4HFibTo2bsZsUV9AfC4EZFsuPZn3ITATx2Sbf4Wy2+JDJPiNsUcXCIqAPfOdI4ZePY6tdxbMvd10ijYFnUNg18IF6epJKvg2BE4bp//gwZj0EFia/ZYm7vUlceFev+Tlv3FZ3aVkqEIOpLtswPeWxLGP2JfOImK31t9vphYSmRkQ6iUO+jZfwevLU6dE1QS3l1E9LkohYjyoQR/DihFIVELRZoTbpaRVntaH3JaBPhnydBsoJsLqw5WvFIT4FDQMmsjxOgtHSZHQOvXwF+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgrPOmiP8ewhsNCmfzHpgWb6rXnSw2csOsri+Qn/rpU=;
 b=f1qM9C9G4Rv+dzq9F5HvR9R9i91j+PUu80CyoGFDT6cUd3lj8hSCF5bvCP5Puzq5G/W5qRPyp7Gm2U6iISRjdib9soOWG0PibNR4J0LdSbzFoCKSLF+0gAn0pH1ZWwnZ/c9HJNTfvcmQpElWxDO2YlGsFaEpJsN6voSAh592GsLHq/wHi13B+7Ky890QGoxEJGhDr/CoCPK2IQRjf+bMRTh4uujpcvsxlA2r8egNzkCBhGvqM4xA7YMukyHwZwUUSuPR0xGe0l7bXyAo8TzWc0Zhznbnifd3/TQix5bK1ROk+NMjsdyM+OxBnIkmcx3ZuyAAFni4FL5RRKzZKosuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgrPOmiP8ewhsNCmfzHpgWb6rXnSw2csOsri+Qn/rpU=;
 b=J/47N8SyCPS4G28IEUUhxzlsTqWXs1EbzCCD1PLGziXzmeEWDqyKiarVZtJiOqjyXCid1TYpbaE5+5sIZzo/dq61gAbeZKj8IKNDspp+P5SxgwZMTjsbm5F8ZoQm7dpEqU5e2AXGNo4b4kyO8aOlUiWDOb9pu92sf/JNMGUZQtFhDfXOJeKZ6xNN3wRZUMFZEEpX9A5u43SZpnr39i+7e3o+Homm5lDoM/FFrqe5u5+lCwbvGfThMYKE7y+5V49+4WJzSUDzNAd0P4RnQR7mrmFC/WZ9e3SO60TtNEyw/tK6nqq/MNg9aGdFfa/E4eYHXAKAOFrqMXVP4tykkNSumg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CO1PR03MB7939.namprd03.prod.outlook.com (2603:10b6:303:273::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 05:07:01 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 05:07:01 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 0/2] Enable support for VAB flow on Agilex5 SoCFPGA boards
Date: Mon,  3 Mar 2025 21:06:42 -0800
Message-Id: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CO1PR03MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb07602-4d60-49c0-3320-08dd5ada6590
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KO3642/jWHXR/vUXNm5Dzp3qYHzTCYnJjaYsEQZ01Bk0LktGkpv0yR5tExni?=
 =?us-ascii?Q?TBHVclI555XrktNLLmX5fOiFOXG2VFMaRyQR4Lp0SuBLmRUXrBVP9bDucreM?=
 =?us-ascii?Q?Nb33SUS1+URqLfukCBpj+1YEdxARKygoW73QsgEcWKGrLlZcvVucs4o/k8vc?=
 =?us-ascii?Q?Garcb2RPgiUvMj+JM8Y7kzfFy0P0yJyGLkx7HuBFd4udyoPOqZTCoGlBpjJv?=
 =?us-ascii?Q?gDn6mAY7WT9cty5dCOTgZwvxvpG8apVUdFApg7spdtICKxtcPMSDVDP6FIlP?=
 =?us-ascii?Q?8ddUXj0OUHmWftYPtws9C8CR0FtNjNHfG9BKE5R8mobcuIg/kaejjKjEZ+3q?=
 =?us-ascii?Q?xbBX6ZD97beti/xQqwiuSMsMQ2BcCGJOJpgK2La3CfFHGMg3i5SNy6PeqPxP?=
 =?us-ascii?Q?mmYda1w3uIBt8UTg1mr0ku+wjWMW4RUiIcjoqbkD8blwmandHaX4xxYj0PDA?=
 =?us-ascii?Q?LhgRQmuCXaC8wk3SIomGQ1ryELEBJl8TR7aHQVqme1cthzbX5fG3hTPwv0eH?=
 =?us-ascii?Q?g79qaIKMRo7NsogkPboDW0EvvCcquTnDd1SLqNuGWVNvNHQ8Q6LpuhyiGM4O?=
 =?us-ascii?Q?qjNJKWXTWc8k7iJFJNSAQFdY2YjbUGUzw7g1uVhxakVNxtrGPog3ZMDa97CM?=
 =?us-ascii?Q?s0NjyN84LUYfrWPDM6LTQPmIhB62+mz/ILNsKaTgxHwvmW2QsPVQcEKbszMK?=
 =?us-ascii?Q?4xme5/m3ShoNPo3g/1Eji68iKVnX+DdmVeoKWFDJQw+hAQHyORTUgHrze5E4?=
 =?us-ascii?Q?6E1AP70VT8YKZEPHcxnKubN7V+Efsh66VMyxSerDqVwjBSssf74PVgE2slFn?=
 =?us-ascii?Q?ltqeFwQGQNJydSXjJafQEmp36qJa/jMT5IZ0FcZit6yJiKXbSgmiRvBOM+62?=
 =?us-ascii?Q?wAtIeXc+Dq1zThkQnGcvR22vnmts97DSrut9sJptZNevW5P7oEqDoXUyvW+x?=
 =?us-ascii?Q?TbAGr9V7g0XDd/UB74C54kPNe+zhNhxEcFWY3ZISIgcGtB0WtgI/tJcDp1MX?=
 =?us-ascii?Q?PDBj69dBnIBGYKnh5UTdJy+y8Go7C3u1J/uiZRACqlALD1i1F1JiQ3SMT52P?=
 =?us-ascii?Q?kMdKubsrPX0iBneYEbMFFwpeo+tFsvOch5LL+lw2FuB+GBKopx4fpXwTxn45?=
 =?us-ascii?Q?23Jg0RV6XJz6j6z3ALd+ZIb4yGYSFO6FFmRVvS9Pl+0JIXa2dl9vbWYDIbYW?=
 =?us-ascii?Q?HdFO1cY7n025wmkxMPqC63FdHopbzYY1qiuywlfg3YEhsUyDI7NVzXYnYCzW?=
 =?us-ascii?Q?kvX5u/hS2rqGfxZxelU/6uRN0Dc/ougrrz2fNHsuUV1UVezhsuC6YkxuAQ+r?=
 =?us-ascii?Q?tSWP/a21+6UzQBCRkawrYn+psf8ytIZalKu0b6MN/Lp4e9V+ZH2RuqrgxaqX?=
 =?us-ascii?Q?OKmhNTe6ofy2fUZcjsV6vh8Br3YH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aq4xrZZLaHcWf1P5wXtNkAvWP3Lu65QRB90/2GElwdXIcC9SUWcKt1rG7qZU?=
 =?us-ascii?Q?qouaxRcxgXKPDDJhaD6qkKbBmocSQdCCFholB51z/hVMEVjfzNfc3HvnaFAu?=
 =?us-ascii?Q?JZvtHe4eHfaaIYJzL7Y8WFFs16DAfPJ9Obzg3NyFGHSLJBWmggkGrFHlEEVt?=
 =?us-ascii?Q?e+/A4b3TCSW77UpFubEp9lqqOsITcVbhUN5PzY8GyN0bX82KijlpB20JOsJB?=
 =?us-ascii?Q?N6Q3M4LqMbj9umJxNkg+hUCM7tGHHgQx1yxnMov/z8nSIQBT6rNazLbcrYSK?=
 =?us-ascii?Q?yEYtW0J3R6zeApejIniHzrTITGHLACqMbQcDLVYcZJUTEfA3n/01ugj8AGhV?=
 =?us-ascii?Q?Uq6kaSZfGnpom0oxvYq8TK+lCgYoOf83Ur0aC7kPHKfthZHJ8JJFNlMaXT28?=
 =?us-ascii?Q?Kvl9P3PIoxTvM77pB6xwXFUoN76d4ztR+TFkcmHB9OvOMVO3gY6Tqr2mv/Lu?=
 =?us-ascii?Q?Keva8GeTygFMJJJK9vNHhgN/4DbjIcCdOhyolk9dNDW77DXQbAO6qWcDRpyc?=
 =?us-ascii?Q?QI3zu9N0Fb9oDK3AEhbqqUWZbyOG1+sHDhkOYSHKBssLFPSJaNsi6R8zAPgh?=
 =?us-ascii?Q?T/Z4yLvT8b2XXTpOV5GaaLYzfPZeab+/w/TJaD81gO5jcVv98o42dXNL9yut?=
 =?us-ascii?Q?w0y+gEC9YTriHHHKaKN/i5GHc8hngiuTOpUl1pK3mY/cVhWDXa9DDS2ursb6?=
 =?us-ascii?Q?ZSAMU07oP/q+YGW4FCUctyUpfUTI9tlzpSt+eLe5oZnO3RWwl82KDB9j5KZ2?=
 =?us-ascii?Q?sSzfZlnddmMbKZLq7LDCtGL5w8u5qKtD1cg/K00akVXIvSZ2pEJcCKgNJPTh?=
 =?us-ascii?Q?xrw+T00AkN2FfN0om6g7Q7Stv9ON91v7pJw8M/ne6JqgFHnpmOQUQpGVh6Hq?=
 =?us-ascii?Q?yiD8OZDb0UJ/qgOq2cQckJd5nuKCtohc25wMPw+H6KaZmKB18zO0EX3OnjxJ?=
 =?us-ascii?Q?d99CSnvyfFyx0gsh2co85pxWZR9ZIPdpUCMea2TIftnog1eeoKyCXJDM2N8Z?=
 =?us-ascii?Q?zjzVA+/f9IcdBNLvVJUAqVesVh4boXpYfircBQN0otF/+LJKFVMSPHqaR0ZL?=
 =?us-ascii?Q?NFRR3Gdwwpcu7Lmxasm1NcK6vqkL2SpyJpYFmsfPutAaLIhYaaCR2LEJKGeB?=
 =?us-ascii?Q?XZEZkSC4WJa3pJWO3Pu3jYzs903EEv7XWYRRhIyeiv0ynr5UbW6H77sFCeXb?=
 =?us-ascii?Q?3jnY6ogZpJ/uzWQZj8FE/9RHIM6VPO9UT+ifGvB9wWB6zROnEGFldS1mOeCu?=
 =?us-ascii?Q?n19cnC+AFNLiNnaDvBpOLjy9UMYHf8mGlryU4uVGjyayr4vnDBEhzyXOvcXY?=
 =?us-ascii?Q?Vsb53LvgFAzBuzKMfEbeL0Wt75+KyV5uYTa+vh6uglvTOBjZh4mkisbkJVmZ?=
 =?us-ascii?Q?LxSsWhe5NiWDeJwCHfhD6kX+YlYURiF2ItNdYAZclDU6GoTXzXGSoExsLkvC?=
 =?us-ascii?Q?PinwubEvCBXF5ob8ap1PvPhIHxD2A5EZHFeif7XyjKDo85yU0v+B6A53nDTO?=
 =?us-ascii?Q?YTvCXqffx2icU6TMIBO5FFTIjqXcF/ZNcYZHOPg/R72XD+60467GcSPEjfrr?=
 =?us-ascii?Q?Ntp93kg2+vnZldfanjpDl0SaYzX/IoAK8gn0bMhzTmJ32N7G8k/oeQd8b1nN?=
 =?us-ascii?Q?5gHrOhFS3rMtwsmW/gGJCGs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb07602-4d60-49c0-3320-08dd5ada6590
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:07:01.2721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGdlRVZdy3W2CbKaU7Nxilb+6LHWtIjNwkUt91lZOrbkWb6wotu8gqMixtHttFoaeZ7Hp9cynVeDspOK9efiR5ariNuwUxxdnCJK+lK8yGpmgdIfld4RxhYR3ysVez+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7939
X-Mailman-Approved-At: Tue, 04 Mar 2025 13:58:09 +0100
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

Enable support for VAB flow on Agilex5 SoCFPGA boards
boards. VAB flow authenticates image certificates during U-Boot
booting and halts the booting if the authentication fails.

The flow has been tested on Agilex5 SoCFPGA board and confirmed by
checking the UART console log messages which logs successful
authentication of the image certificates.

Naresh Kumar Ravulapalli (1):
  configs: Enable VAB flow for Agilex5 SoCFPGA boards

Naresh Kumar Ravulapalli (1):
  arch: arm: dts: Enable kernel itb file generation for Agilex5 SoCFPGA

 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi |   5 +
 arch/arm/mach-socfpga/Makefile             |   2 +
 configs/socfpga_agilex5_vab_defconfig      | 102 +++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 configs/socfpga_agilex5_vab_defconfig

-- 
2.35.3

