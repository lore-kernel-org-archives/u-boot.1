Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A79D6100C
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 12:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C675C83EF9;
	Thu, 29 Jan 2026 13:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OFNRg/4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCDD83F20; Thu, 29 Jan 2026 13:24:16 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF4F83D9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R98JSAGnS0BbXE7Hgta7bn26Boww4vy5zt9F3WM4m/PN6Y7HWORYOl9p5gCzThwx4Pm7c0ZA7Wi+mmvaw59GgliA1t/ObZA6rABiXjpbkT4uXM1R0jWJaOelfGgdw3+MXpp1llYS1Ca+aXZkW/QnBzAy06qZyfWcnZcrrQtwZP3QthZjf239smFCwahZmrJ0SShCtxEHDbGgWuz2EwVwQ5TrAQudujr20Aq/ISA9VKs64W4mbqPvvwY9f2bjAtdVY1b6W6F9CF/vL18++8SDagJZBdYe2ixCkaPgPP9ogxILTLrWfFXpXG8of5GWOZrK7EhWbP25KVu7yLhtyZc5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPyODK7tB3AkilgPyP1RaqRU3qw78rZ3bNA1T8ZnTpo=;
 b=EbkavNuB94P0ib0secu+K72fqHVmwUr751SFhFZ4AKrHlAPcIXhT6FDcE/ZsKDU5n5FNj10iGATA94fo2hFVm/YAXzJ1H2x8m7zRJRrvc8BzMzk+tlk7CvOwkNxFiLcaPaurVUkMR9GJ6Ff8yyjSBVm8ipqoFkn4sVKZ9swYPPzXJin8AhLBrPt+nBGYUJyaYjUnqXyTmWAU/vntWBUHmGo4ATawCjb9/zH991QYtTq0oi2QUxjRJ8ay0h+Ykll013SwCJuVY+fcmQKZ/MPgKmuYcjMsqhMoeAcYbGCf/nw0AW1MECadQrHjD+qXxZ1dJT14Y16HJe2ns24KB1PU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPyODK7tB3AkilgPyP1RaqRU3qw78rZ3bNA1T8ZnTpo=;
 b=OFNRg/4lc4l5sG4mQwA4nmA3MD7TMxdPX/ZEaJHRD/Di5KcOT784qtgdCU1YTiKQ/CSEmrSJy2qiTRD/3hHdJgDxBieXUlnmv3q0y+DIUVeVEGvm+BJacEoPASvyDyLBLSPKjPk4EfsSTg+nt1EVveZCRUivuWo11olOY/AuJhvoacK/iJ+B9Bur+/vl2eMF/4wIWTJ+uwxvcFr2IiYxN0ZQcIv9LcKnurNkfyktxlsbV7I3jMcC96nQ9Wovc6m1NVV+9amvO/bjdxToVYbK/6j21+u9iWV3BzGhvzGwTYRlEyhRnjpDc5eO2as1cbfH2wX6sTSEVRoJRM1Zvs4dAA==
Received: from DUZP191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::20)
 by VI0PR10MB8598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 12:24:12 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::26) by DUZP191CA0041.outlook.office365.com
 (2603:10a6:10:4f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Thu,
 29 Jan 2026 12:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 12:24:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 13:25:54 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 13:24:10 +0100
Message-ID: <812749b7-c7b3-49df-a2f2-519caa830959@foss.st.com>
Date: Thu, 29 Jan 2026 13:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Marek Vasut
 <marex@denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?=
 <raphael.gallais-pou@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.04 =
 u-boot-stm32-20260129
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C6:EE_|VI0PR10MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6245f7-1820-4205-3115-08de5f314f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVWOWVZVlRMUzBrVGp5dzJaTXlJWDhOQlEyR1I1QnJlNUZMTTF5d0FBdkFk?=
 =?utf-8?B?SStNdG55dnNMK2tqSDNLUmlQSVU0U1hTQ2JSamxCV1g1ZTBDbzdBMWJXOUhV?=
 =?utf-8?B?ZDFsSG1DRGFTaEwzVGM4S1RJakZaa3FiR0tkSmNwY0RlN0hQK3Vzam5HcFB0?=
 =?utf-8?B?cGNOcWJxby9jZjJNcG44a3kvYVkyK1l1VlhoQlVOTU4rRDR0ZUZTaFU1MDRm?=
 =?utf-8?B?SUZBMkxlMSt0by80N01uL3o0TTI4VzUzb2prb2piTUtsZGRJNEhua1J4bVk4?=
 =?utf-8?B?VFBOSGRtMU5DSitoK2RZb0NoWjlpam9HREc2N1RrVkZYN1YwTldtNXFxOGtT?=
 =?utf-8?B?Nk5oYXZqTDRYOFdZbWF6SE1wV0tBdUdVQkdrTHhNMGJob2dsR2xKR3Q4Zi9o?=
 =?utf-8?B?YnE2SC8xTUl2dWR0Z0crMnREN2xXUEMvQ1pCMmNXVXBHejJWeUQvWmZPTzRt?=
 =?utf-8?B?YUhnWGxxbm4zTWpOZDU2ZGRPeTUvcy9ONFlsSDBzaGNEU0pXK0hYcDVtOWNG?=
 =?utf-8?B?Y09EakZWbXN4UW5rcnlydFZjb0xRTXdyZXZxZGlNQ1RZUm4xeDFMdW4zV1Zj?=
 =?utf-8?B?M0RGTVphb29DcXVNRDdFcXgrV3NkMENBTERZai9PclEycSswT0tmeWJNQnNM?=
 =?utf-8?B?c1UwNk91OUF0Q21YUmd4YTdsdzdpUmhYL1AxY29jUDlwSjc3NGpwN2Y4aTJh?=
 =?utf-8?B?bkNtaUNETnZaMXVVZGpYRGpIUVFLeE5oKzBOcWdNZDRZZWpnKzlsQWpxVzJy?=
 =?utf-8?B?anovMGN4NVFwWURLeGV3dGplKzJMdG8wYk1PSDZ3MXZHd2h6Zk10RWFYa1Ix?=
 =?utf-8?B?cldjR2JzcVRFYjY2QmdNcWFVdElkMU5jdFlmM1VqRzhmaG9CTjQvaFZkNXVE?=
 =?utf-8?B?Q21VWVRidnRoRStvU2N2MWtCdmZXdkZ4ajN5L1NRRDkzek9tSkRtUW03Zitv?=
 =?utf-8?B?ZlhLVlkrL0xXWkdydHJtT0hDNEMrVnNzcGtiQzFGV012VWk5VkNIT1pITDdt?=
 =?utf-8?B?RXVJMUtXNFh6cGVOSnFtVFVnZUc0MVBYN285ZzlzTE1EeUdVSEM4Y2h3MXlK?=
 =?utf-8?B?eHNhZmR6eDgxNUN1dDdhMjlLendZQ3ZyN1dxZG9RUENsT0lSU0xlRGNVY3Mz?=
 =?utf-8?B?aDl1VlNWQ2ZDdVVyWkRVQ091UTFZckVBZ2Nva0N0VXpEQkpIdGxlUkM4NHRq?=
 =?utf-8?B?S2FyVWlWalJwcGdiOGVVWUFrREtWamNPeUFxM3BzZEZTcGJQMGRrOEI0Q3o3?=
 =?utf-8?B?WGpIZC9BbTJ3ZVdyb2UrQ25ORVQyNVpud01SY2loYU9XSVN3VGQ3dlZFcDRn?=
 =?utf-8?B?R3kzWEc3MCtuYXUrMWlEWllQUGV1MzZPSVd6ZytucElvdmpvZmRTa29sM2w0?=
 =?utf-8?B?TDVWczB0WDl6Um9zQ0ZWZi80ek8zMVhOQ3Q4VVVTWWZOYVdVMG9yMURWbEcv?=
 =?utf-8?B?OFFLT0RSWHFCL1pUaUlGSUpqNXZIMUI1cFpJNWFhKzF5bGsveW51S0hJajVC?=
 =?utf-8?B?R3o0TjI0NU9yRjBhaWNxSjlpUUwvYTBXMDc0bE1nWW54dG1wc1RVRUdGS3kx?=
 =?utf-8?B?ME9VUVVoQU1EallZVDhLc2dlWHFGRENUQmJLSFNHOFNjOWIybndhbGEzaHFt?=
 =?utf-8?B?enlUSUFxK3JvZzJJYVh3Sy9OSTQ4K202MlhuQVJrTnlTYXEvSTlFb3poakl5?=
 =?utf-8?B?SzNWZFRpNmNxZmNqWlBQTEhDR21wbURRUmZyYjluRFFKcVpnTStDOHBGVGFn?=
 =?utf-8?B?TWZ3ZUdOdnJweWVtYm1ycTN0SDBUZmphNGhzVzJpVG44UElEOGpZU1JzU2Z1?=
 =?utf-8?B?QW41RXV6ek9UY01qUS9zd3RMRGRmdzFSblN3ZWx4enZyV29RSXdYaWRheldh?=
 =?utf-8?B?NGQwWStDKzBoTWJHMVJleWEzNngxd1c5NVJVT2R4S28rZXhLaGtNaEJuZTJU?=
 =?utf-8?B?S1JBd1IxekF3MUM5TEh3akVQZWVva1NqNkNldURPZnRqbWpmT2VLc1lIRGpk?=
 =?utf-8?B?MG9FSitWcjEzV3FBTjFlN01WMzhVN2l5M0x1THVEcXNyd0FyRHN3cERZNFUr?=
 =?utf-8?B?THNmTWJKWURNMVFZWlVoNVdRbG9MOTZsYm5ydHVXUVowWVVxQ2txeXEyalVT?=
 =?utf-8?B?NnVoWFQ0L3hpUFUvbm1mekhpSHZpM0EwRjBLSjJxZHBrMjlqQUNwZ3lyWWV2?=
 =?utf-8?B?Tmc9PQ==?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FZlUdf/QrgaOlIIony8qKrd5fuVP2ej/1ruzRRSCocsoX6lkknm75btm8Ht4oDMUdsVlybdFszERVkQtudqCU1x5HtB3RbDX8fSZUICxUpcpRRKX0cb9Q85RhkrpPA2N71OV128s+fDGDkXpFZzGn/2ZpGZTja5G2ZBr+/gZZ6Kk3Qpms2vmVBHEy1kSf2OLxs7zNrgnFDHoxIAQSfhZRxNyho8J5bGgpg8q4ZgIQLGTqZsPMqCzhpd5oQUTaNS/849loxh50/snw3r3GFmy+PPhqIxRLeYYK73xrHcwUg1Gq6HajMOoN7EjEmpMfDRIIC4PvVDmu3oaVMD2TKCUgzBxwq4UscpNsnMU/EjdBcVfZmty0hCiKo7QfP0TG20ly2qnBFysqvLCr/em/216ihSMR6NVH4QSv9UHb6xB1s03kmX0qAliyZS46eZ/2obvIoEzuUAZ5vbMh3mwn9nbnSK+z/5wLN6ocez06FjiVkT93lp2uJ1lLA5W1JFZd5eWfptv6Jop7nxHfL9xYup2dfpMic5AumQaICQoRqp41SovAfnQumm5T92IjZnFQvx+hXCDuZKySL7Y25zyqYbKjvyfnhRZEJQHiZowaqYRS32+h7pt0zHwlQaLHENY0jZuu7ol1WrLYEM4pUtX0IjVpjBiOiW1DNiAjfrbptytaqfRDJ5DJrniMzL1B0JOJNbUn/hwgU6+AxBPJqDa/5dq1g==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 12:24:11.6687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6245f7-1820-4205-3115-08de5f314f12
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8598
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

Please pull the STM32 related patches for u-boot/master, v2026.04 = u-boot-stm32-20260129

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29139

Thanks
Patrice


The following changes since commit 6a1bdb7e952d5841f42742fefa907cae5dc8d50a:

  Merge tag 'doc-2026-04-rc2' of https://source.denx.de/u-boot/custodians/u-boot-efi (2026-01-28 17:04:34 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260129

for you to fetch changes up to a8f12fa7af3f6962cc5cd529b5360099d2012387:

  video: simple_panel: add support for "rocktech,rk043fn48h" display (2026-01-29 10:47:57 +0100)

----------------------------------------------------------------
spi: stm32: OSPI and QSPI optimization
Update stm32 clock drivers to restore boot for STM32MP13/STM32MP2 board family
Add bootph-all in ltdc node in stm32mp257f-ev1-u-boot
Use CONFIG_STM32MP15X to discern STM32MP15xx on DH STM32MP15xx DHSOM
Reinstate missing SPL configs for DH STM32MP15xx DHSOM
stm32mp2 boards: read boot index from backup register
video: simple_panel: add support for "rocktech,rk043fn48h" display
Add .of_to_plat callback in stm32_ltdc driver

----------------------------------------------------------------
Dario Binacchi (1):
      board: stm32mp2: read boot index from backup register

Marek Vasut (2):
      ARM: stm32: Use CONFIG_STM32MP15X to discern STM32MP15xx on DH STM32MP15xx DHSOM
      ARM: stm32: Reinstate missing SPL configs for DH STM32MP15xx DHSOM

Patrice Chotard (7):
      spi: stm32-ospi: Increase read throughput in indirect mode
      spi: stm32-qspi: Increase read throughput in indirect mode
      spi: stm32-qspi: Optimize FIFO accesses using u16 or u32
      clk: stm32mp13: Reorder include files
      ARM: dts: stm32: Add SCMI clocks in rcc node for stm32mp131.dtsi
      clk: stm32: Update clock management for STM32MP13/25
      ARM: dts: stm32: Add bootph-all in ltdc node in stm32mp257f-ev1-u-boot

Raphael Gallais-Pou (2):
      video: stm32: ltdc: add .of_to_plat callback
      video: simple_panel: add support for "rocktech,rk043fn48h" display

 arch/arm/dts/stm32mp13-u-boot.dtsi         |  27 ++++++++++++++
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi   |   4 ++
 arch/arm/mach-stm32mp/include/mach/stm32.h |   4 ++
 board/dhelectronics/dh_stm32mp1/board.c    |   2 +-
 board/st/stm32mp2/stm32mp2.c               |  21 +++++++++++
 configs/stm32mp15_dhsom.config             |  10 ++++-
 drivers/clk/stm32/clk-stm32-core.c         | 116 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/clk/stm32/clk-stm32-core.h         |  42 ++++++++++++++-------
 drivers/clk/stm32/clk-stm32mp13.c          | 441 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------
 drivers/clk/stm32/clk-stm32mp25.c          | 405 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------
 drivers/spi/stm32_ospi.c                   |   4 +-
 drivers/spi/stm32_qspi.c                   |  63 ++++++++++++++++++++++++++-----
 drivers/video/simple_panel.c               |   1 +
 drivers/video/stm32/stm32_ltdc.c           | 200 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
 14 files changed, 912 insertions(+), 428 deletions(-)
