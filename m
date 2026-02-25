Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26765EFD204
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DF183D8A;
	Wed, 25 Feb 2026 08:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Zd/Nl0NH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD6183DCB; Wed, 25 Feb 2026 08:52:22 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B1082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3AA6P7Vm3ZV00GQWVZ8MdLlcJVvGjBpB8O4PlKH2yZQifcDOPcTMjLdg7zWlV5FUUUgzHYMJV2v52FrykZ3RVsiIjmadwd9nXMAmnpvtQIIRsGIHNkedWH5cKB4QDhJmLBUFFbp3xQs7ZIsKOAXgYtdA13XRArCoCFZdUsxdMwRfLIiHgiuC+Ow9zZlx5nELBxwHT5CkWzyF3dwhgrP+G403c7NWxnPrKrI0BPYqc/tnJgxRg5qyoExm5dIH/lzYMXmsLk/fe5bkwwE1S2U33u7fZ0jL1AnAOLlz4cpishcie+U/y0JLfzusHpFFoJBhrtYXKokKTZFt5xmauF54A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNSgVFLuHkh35UTv2fAZpAabXXNowkO7PLLK6tSqC2s=;
 b=SqO294sRZLSHp/2dRtrILGkvX9p9UzQhkoDTaXsc4iob6bcemI6V6shW0lazX/vnjd3Y17ft7G6TIGOexP7JGaemWvEH4waKjHlzieaa1dyyPcKPHaTEsfv00T/kbtCLwS5IewMbxpeWrHNPOUHdGZ5NbHDfLadz8irBeTkjvoz5MYo8eYSnP2l4++BxGmnEjuf0EUk4jVmOu/odlqsIiZqUYFKgYh2vSOojzyal2Kr1S/6ODsPV6DaQ0ed7UTFR/yXBl3XmXPL+em1PvImV4iSc8l2V/iHXMMhuqhj4+AsuoJm6panOB3JRHIVbe4npEP1fga3HAwM22Sfs+xLEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNSgVFLuHkh35UTv2fAZpAabXXNowkO7PLLK6tSqC2s=;
 b=Zd/Nl0NHsUKxQscMHOo0VL9+Q+jKWFTRu0wLuNx1bYSbUijNd4Ja1IVMzLAIEWj5ISGukK7hlX6iecXgXXz4IEJQcQ9x5/OlvoqyVlRX8bshQPlr9TgZ1T90TSqKSTGzDIfOrFBWWsHTa4y6e7yPRgBLIDhvKmkEMoWGdjNSBle3xErjULbhIJlrV19uaPLdOzNCxfAZqAAULUsxgNgYW9ZaOwZl0UmcWSucGikWMT1QNcoxu4FLe1JSO9bbaWAdHT2rXB69nbZVKDlycveGRGKItDWGUl8+i8YOJceAbjFT25N86SlEy4RlDgOm7OJ/KKqfCHQLHKDZRe62qQf0UQ==
Received: from AS9PR06CA0262.eurprd06.prod.outlook.com (2603:10a6:20b:45f::16)
 by AS2PR10MB6399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:557::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 07:52:15 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:45f:cafe::ee) by AS9PR06CA0262.outlook.office365.com
 (2603:10a6:20b:45f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 07:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 07:52:14 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 08:54:21 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 25 Feb
 2026 08:52:14 +0100
Message-ID: <41b7139c-9b00-413b-a6c5-0d7e7b5508b3@foss.st.com>
Date: Wed, 25 Feb 2026 08:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.04 =
 u-boot-stm32-20260224
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Gatien CHEVALLIER
 <gatien.chevallier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Fabien Dessenne
 <fabien.dessenne@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008F:EE_|AS2PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb17e3d-f334-4f02-d9b5-08de7442cab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE9HbysrUmZid29nUFFHaVpQSUdGSmdFa29hYnI0QkhGbjk1aGN5SkMxaHh0?=
 =?utf-8?B?eElaM2FuT0NtZGRla0RsWkVNWWJtNkorSTVpeURndHo4NitFUjZxcG5CVEJp?=
 =?utf-8?B?ZEQvanZBQXhQMFpGc2pDZkJtREZPRlhRMzZyVnlQN3djUHI5WEtibTh6clFJ?=
 =?utf-8?B?azh3VlNPMml1dzd2SjNuTHRWMURnblNITkRPRXZQUWRZS2JGUU4vZWVFN0k2?=
 =?utf-8?B?dWVMeFJEejVGc1F6dzVsdDI5TTU0cTNFYWd3U1I0YlY2RVM1UnNtQVFLcWRT?=
 =?utf-8?B?RGlOU3NhN0t6U0hvTzVQM1ZTeUU3U21FWVhtWENTbGliR3dUQnlrK0FpNjU0?=
 =?utf-8?B?eEJadXNSZmRxdG5RcFRFMmU0U0lmdlYyUHBHcWF1aFlZeWFBdVphZGl0RGxP?=
 =?utf-8?B?ek0yZFJ4dDhPOVgvYjB1NXJ4eDZpQ1dUVDI0SE45WGszVzJrK3NYRlJ4cmNp?=
 =?utf-8?B?Tk8yL3htUHMxTWRPWDBpUE8rQnQrckY1c2J6dm12YlRSNnJQb3NyY0Z1S3RV?=
 =?utf-8?B?WjJFdVNmemxjdmZ0aUxDUzJ2OFNLQkI4R0VGL0I4QXVzREVPbHllWTgzbkRk?=
 =?utf-8?B?QWlnZjczNzg1b3pTV3BqcmNvOWFEenFiUzRzRGlaK2JJTkFaWXAxZUJHTXJn?=
 =?utf-8?B?Q29IMUd1NE1GUTMwNmJtNlh5bnpqc3cxWVh2bHE2aEhHb2ZiNTNnT2pTeDV3?=
 =?utf-8?B?T2N6RU5XeG1Cb3h5bWUzSSswWTNvenhLUTYwbW9Ka1p0TUVyMHNJemg3dEty?=
 =?utf-8?B?ZGsxdmRmZUFORFBHUlkwNTlrc2QrallGVHNaZDlkTi94MGlJWGRrRDE2aDRn?=
 =?utf-8?B?UGYzZzdEaGxtQkZNSjJpVnhPSWZObk9UN0k4dVgxK1JzU1dLbitlMGN4b1VB?=
 =?utf-8?B?Z0ZjL0IrRUlkM0R3VnRnNXdBTk5KRlJDYlhWSFZaWWpJcG5ZZXd1c1phK2gx?=
 =?utf-8?B?SWlpdXdjZ2NsY2lETjdlcjBydGlnc1FaT09aeDBUa3QzL0ZyOWZxbXZSaW5a?=
 =?utf-8?B?OHh4VlAyd1VlUkNzbmRIWUVveUVJZDU1RmVSSExINWxQYVJPZzQrT2lwMzU2?=
 =?utf-8?B?RTZNWXhCaHJ4dGFmTE8wRHpiRi9MV2NKNE41SUV2WnA3dS90ekFmR0xpODlS?=
 =?utf-8?B?aTBUYUpIYTJEYmNUWTZBRTN5Y2VvVkFuSkpmdFlsdVA5L05zNUttcWs1UmFQ?=
 =?utf-8?B?V3ZYSnpKT055SXRlalZPZ281dzl0Tmk5ZkRsNmxIaVNQU1c5MENSbjFWNU9C?=
 =?utf-8?B?ejhlOFZMWVorYnVmY2RDSU1VSzVhWFBlTnIwNHkrMFltQnlXcHd0cEpLR1hM?=
 =?utf-8?B?a3lQVEUxS3hKYy9kSVNpbXBTNXQvY1dWOU9jcmNDWFNMdTE5THhOOXRwRmtp?=
 =?utf-8?B?bGVqY0pleGszUklKaUwvMm13MzBWa2lodWFsaTBwRDVMajU2dVBjcWhaTUZy?=
 =?utf-8?B?bnpuTzZBN3kzbTdwZERnQ3dkQmdqTi9iNWFzUVNZL3Vpa09sd2NjYTNISCti?=
 =?utf-8?B?L1hoTmZRUUN6bkwrK1RTV2tUK0xaVEIrQ242M1p6TnpVamhZSWN2YzI2K0Ex?=
 =?utf-8?B?bFRxaklRYmVnTlMzc2lPQWY1L1hpaHA3bHFHcVhhT0JUeVdzTHJlZFBlZ0px?=
 =?utf-8?B?TTAvT3pzeDI1OXdDaXZLNjFBVW5QQ1BXODlMOFFjODB1Wml2N0dGTFYxOHJM?=
 =?utf-8?B?RG9uRTZCVDFPSnNuL1prYkxyVXB6TzFCNmZ0eHYvbGtISm1icm5DUVM2WDRF?=
 =?utf-8?B?SE9VbGhkRUFRSTlvNzNVaHJmVUM5NGdmdTRiOW5EQ3lDMk0wMDRESjNFNVl5?=
 =?utf-8?B?eHNhZ3FBakhZc2VxOFUwYUx0aVdHcjVZWVJIK1M0Sm5udDdqSkZGNDFZUG55?=
 =?utf-8?B?QU40cWR4bFB5NnJ2ZG4rc0JNU1lzYXNqV2NiL1ZQbURmbUpyODI0Vk9JK1Ja?=
 =?utf-8?B?eTRBbUtLc0ZXSHpHSml2bzVNOWFiQ1ZYcThCdGp2am1LNjAzbzY5ZDBzWWR5?=
 =?utf-8?B?SS9lZm1WTzFWNTFWMFpQUEpYZU5aNnJycHk5WW85VWRyQVdHaWgwRld5Zlk5?=
 =?utf-8?B?cFc2eGQvRnorbjFNNVgyOVFsZmh6d2dNYlEwY3k3QTc3WGNvVmZ1R3NaZUZU?=
 =?utf-8?B?WW5PczRpbm1udVMyME53akJHRldwdTA2S01WUlBTZ1hrMTI1MjhkcWNCc3Iv?=
 =?utf-8?B?Wnc9PQ==?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: On7JBRB7wQnRhSiZJTnwP5wRs2mAltU2xkjXE0XtdFs7xPW8cMrCZ9qM13LKMEbl+5hLaqNUu70H4YITCNQUDIv3OEPPuPsh+CULjX7hZf3RUE1omDZqxuIDrXJxxGRgf0tscFZ4tjk5gCWJEhtjvR/3OU5ShVN+sRJgpjtXrI1PuUdfV2dAJUXFVunhhJnsOwvVfed0rFLsFrPj6XvedNYxnkoNjtL3cj0k9AJuV6wtFuQJbeqoHkTFPTLIz2+Hzx5HQjPJNjO6871lL1e3wN49q0cIw9X1APGqDG1dpt+nkIyZWpE1p/w8JIEPEi/mYSRMrZNsVQApozwNAl0pftSsq23TjkCt6p4aXAhTgfTFEumoq3FDPvOKq2bjxMiNRoguE9Nht8eOi+IF/XDD/3bIm5VNcM55XX3IfrVIeFMLQ4TGNeXKZIZiAMFHS8jC
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 07:52:14.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb17e3d-f334-4f02-d9b5-08de7442cab1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6399
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

Hi Tom

Please pull the STM32 related patches for u-boot/master, v2026.04 = u-boot-stm32-20260224

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29353

Thanks
Patrice

The following changes since commit 4f70106beafe30df8b0528a3d8b2543cd48fe241:

  Prepare v2026.04-rc3 (2026-02-23 13:17:02 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260224

for you to fetch changes up to c61d6f67f46f05149182b33c3c0ba5d9b6b46889:

  ARM: stm32mp: Check secure state first (2026-02-24 17:49:43 +0100)

----------------------------------------------------------------
STM32 update:
_ Add STM32MP21 support (board, machine, cmd_stm32key, cmd_stboard, rifsc)
_ pinctrl: stm32 : various update
_ stm32prog: clean stm32prog_data struct
_ stm32mp2: Fix array bound check in setup_boot_mode()
_ stm32mp2: Update dynamically DDR size in MMU table
_ rifsc: various fixes

----------------------------------------------------------------
Fabien Dessenne (2):
      gpio: stm32-gpio: prevent the use of the secure protected pins
      pinctrl: pinctrl_stm32: prevent the use of the secure protected pins

Gatien Chevallier (3):
      ARM: stm32mp: Do not acquire RIFSC semaphore if CID filtering is disabled
      ARM: stm32mp: Fix CID and semaphore check
      ARM: stm32mp: Check secure state first

Gwenael Treuveur (1):
      stm32mp: cmd_stm32key: add support of remoteproc firmware public key

Patrice Chotard (16):
      stm32mp: stm32prog: Remove fsbl_nor_detected from stm32prog_data struct
      stm32mp: fix array bounds checks
      stm32mp2: Update size of DDR entry in MMU table
      board: st: common: Add support of stm32mp21xx-dk board
      board: st: common: add uclass_get_device_by_driver()'s return value check
      clk: stm32mp21: Add clock driver support
      reset: stm32mp21: add stm32mp21 reset driver
      stm32mp: syscon: Add STM32MP21 support
      stm32mp: cmd_stm32key: add support of STM32MP21x
      ARM: stm32mp: Add STM32MP21 support
      ARM: dts: stm32: Add stm32mp215f-dk-u-boot
      ARM: dts: stm32: Add bootph-all in stm32mp215f-dk-u-boot.dtsi
      stm32mp2: Migrate duplicated code into stm32mp2x.c
      stm32mp2: Add check on syscon_get_first_range() return value
      stm32mp1: Add check on syscon_get_first_range() return value
      configs: stm32mp25: Enable CMD_STM32KEY

Thomas Bourgoin (4):
      stm32mp: cmd_stm32key: add support of STM32MP21x SoC
      stm32mp: cmd_stm32key: add support of OTP key format 2
      stm32mp: cmd_stm32key: add support of remoteproc firmware encryption key
      stm32mp: cmd_stm32key: add support of ADAC public key hash

 arch/arm/dts/stm32mp215f-dk-u-boot.dtsi             |  19 ++++++
 arch/arm/mach-stm32mp/Kconfig                       |  27 +++++++++
 arch/arm/mach-stm32mp/Kconfig.21x                   |  37 ++++++++++++
 arch/arm/mach-stm32mp/Makefile                      |   3 +-
 arch/arm/mach-stm32mp/cmd_stm32key.c                | 225 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 arch/arm/mach-stm32mp/cmd_stm32prog/cmd_stm32prog.c |   8 ---
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c     |  10 ----
 arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.h     |   1 -
 arch/arm/mach-stm32mp/include/mach/stm32.h          |  12 ++--
 arch/arm/mach-stm32mp/include/mach/stm32prog.h      |   2 -
 arch/arm/mach-stm32mp/include/mach/sys_proto.h      |  22 +++++++
 arch/arm/mach-stm32mp/stm32mp1/stm32mp13x.c         |   7 +++
 arch/arm/mach-stm32mp/stm32mp2/Makefile             |   2 +
 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c          |   2 +
 arch/arm/mach-stm32mp/stm32mp2/cpu.c                |  20 ++++++-
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c              |  37 ++++--------
 arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c         | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-stm32mp/stm32mp2/stm32mp23x.c         |  44 --------------
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c         |  46 ---------------
 arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c          |  63 ++++++++++++++++++++
 arch/arm/mach-stm32mp/syscon.c                      |   1 +
 board/st/common/Kconfig                             |   2 +-
 board/st/common/cmd_stboard.c                       |   6 ++
 board/st/stm32mp2/Kconfig                           |  14 +++++
 configs/stm32mp21_defconfig                         |  78 +++++++++++++++++++++++++
 configs/stm32mp25_defconfig                         |   1 +
 drivers/clk/stm32/Kconfig                           |   9 +++
 drivers/clk/stm32/Makefile                          |   1 +
 drivers/clk/stm32/clk-stm32mp21.c                   | 709 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpio/stm32_gpio.c                           |  25 ++++++++
 drivers/gpio/stm32_gpio_priv.h                      |   5 ++
 drivers/pinctrl/pinctrl_stm32.c                     |  83 ++++++++++++++++++++++----
 drivers/reset/stm32/Kconfig                         |   7 +++
 drivers/reset/stm32/Makefile                        |   1 +
 drivers/reset/stm32/stm32-reset-mp21.c              | 136 +++++++++++++++++++++++++++++++++++++++++++
 include/configs/stm32mp21_common.h                  | 126 ++++++++++++++++++++++++++++++++++++++++
 include/configs/stm32mp21_st_common.h               |  51 ++++++++++++++++
 include/stm32mp21_rcc.h                             | 651 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 38 files changed, 2447 insertions(+), 194 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp215f-dk-u-boot.dtsi
 create mode 100644 arch/arm/mach-stm32mp/Kconfig.21x
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/stm32mp2x.c
 create mode 100644 configs/stm32mp21_defconfig
 create mode 100644 drivers/clk/stm32/clk-stm32mp21.c
 create mode 100644 drivers/reset/stm32/stm32-reset-mp21.c
 create mode 100644 include/configs/stm32mp21_common.h
 create mode 100644 include/configs/stm32mp21_st_common.h
 create mode 100644 include/stm32mp21_rcc.h
