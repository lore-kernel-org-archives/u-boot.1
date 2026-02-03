Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1377FE87842
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C49583C4B;
	Tue,  3 Feb 2026 17:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ntb61+Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F5883BF4; Tue,  3 Feb 2026 17:49:40 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF8E83BC8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOy7K7Pf3/xxGrnGfV4JADkfAAjMO9/8ave9YGaFwcJe+qe7FYP6QowBRvGmeRhYgAF1w424MekoxnrBkknxKigB/qbnKcQdM7tP0aMGDdct6Kt6iBOoh5txOWBLSBSSBJrBH85Jdf+n7DZlpvyxzJxS9Sd79cYE0erS6lBz1trLqUd7fav0MhKJIqalnvvgWzxbLkG9/83RFt3mByr6pP2qoHlqT964filzMOEte1kx3DEZtGd7yunMKZMS7o2c2Ip2r5BXIzfsndwy9ZaDz4FX9uc5dR0sUxij8WDc0osLg29ntdKG2U3Pc5SD5h7P06xgwJEkFEHVmZ+SGPcltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdzToiBuiwO8z39vQ0I4zrz6UN20xctSJYzqSSVCydU=;
 b=qS/ZgfLLEUlnlq4cABgNk5Fpg3uBC4orQRHjxqFWkQa+88JX30+2SdEnGrZ2rQoFOX4HT8X7tjOhajVwI/BBtTfVNUA2nVPaHHTGMXK9YDvpHkUhsLo2C7CDH/iF3IXj7MEX/h5f5bvyvGFnfCdfV2SPo9O688z44jH2Gr9HVg5YtjWg3FBjxE/JpfzGlDnZVa2vk0hLJ21/EhSX5YhzcMSkxAiyQ0+o9S2hYnyylB9YhJZViuFda4T4OsQeLqOnNBQU+xuPijCFfIDV1cQPt6BkBP/x/BAqP6IQ19SFX2UrseSqMKbfK6S8bQbeuRh1cHiqcPs51W7dCUhLtS3SoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdzToiBuiwO8z39vQ0I4zrz6UN20xctSJYzqSSVCydU=;
 b=ntb61+MjX/qSp7nz3PnmVFuSu1+q1ZZ2XiRysPO8/6Mhl0235B7GQb94Thyz7zljZWVmlWugxDFaG8mrxWUlv5teutogeT8+XDTOrtxGmnpqJwWKsblz8+pR5PWriOqwZi0GB/9plX5fDW4R2Q7NluQ2i1qUSLcY7KgWGXs0NXBhOSHu5irIqGV3T+JkZbSsk5fulc3AEYIpkiZR2Wy+phMPRzevKJ8up9XRZxRK78ExBT0cLUGmneKNOQqf5K9Z/OiLVUs7vsCWUJ6vnlRYiwePJEyBe50gyZ0CkcwbDozJBUwRTbOtNWijbQP2wKRI5q5lGl9n6/3wEAzIakH4sQ==
Received: from AS4P190CA0069.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::15)
 by VE1PR10MB3968.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 16:49:34 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::6) by AS4P190CA0069.outlook.office365.com
 (2603:10a6:20b:656::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 16:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 16:49:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:51:20 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:49:33 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/7] ARM: stm32mp: Add STM32MP21x support
Date: Tue, 3 Feb 2026 17:49:20 +0100
Message-ID: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABAngmkC/x3NwQrCMAyA4VcZOVvIOlH0VURKXaLm0C0k3RDG3
 n3F43f5/w2cTdjh3m1gvIrLPDX0pw7Gb54+HISaIWK8YMQhLOrVOJeUiZLXMsSisU++qM5WA76
 QCa9nonyDFlHjt/z+g8dz3w+5VqmrcAAAAA==
X-Change-ID: 20260203-upstream_add_stm32mp21_support-0b0ed074dda9
To: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, Simeon
 Marijon <simeon.marijon@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|VE1PR10MB3968:EE_
X-MS-Office365-Filtering-Correlation-Id: 52050e89-a713-41f4-fa05-08de63443589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHJqbWZPUXU5ZVF2ZkJPY2VQd0hnQWdqUHBDUUg2Ymg4UkZmcmNHVEpGUjBC?=
 =?utf-8?B?NkxlR3JNeE5qaW5HSnRuaFZHaEVqeEFBMFcxdHlDS01nOC93WkJVb2djVC9G?=
 =?utf-8?B?eFVubFFVZ3ZjdHU5VUMxV01CUVBoZHplSXZtd0NtUE5EdXVEaEFpZWtPNFZm?=
 =?utf-8?B?U0M3ckhJMDBpQUI3TVdyUFpVTTcvZ2ZNNWM0RzlpM3B4NXZ5dHZQYm0rSlNa?=
 =?utf-8?B?cmNQckNGckYxKzhWS2NHN0ZzR1R2TVZkNUUyUUc0NzhRMmljOHhVNjVOeVBq?=
 =?utf-8?B?QjMrYmJ6YlRsSDhObnVDdFIyL1dkbEY0ajJ3QUVrbWh3bmhQWUFleHA5RkhP?=
 =?utf-8?B?azVrSXVzZWNzeEluZ1hzUndRWDZvdnl6OVBubzFnYU5aM2JyOGVGVDFDNExB?=
 =?utf-8?B?U0JkSEgwcVNrRnRVcDIvZDU4UWlLbUNMWUptakhjNHpjKzZ6SnhqZFdPOXcr?=
 =?utf-8?B?emw2Wnd1cjd4NGR6dTJ5YWM1dlVoNkVZOElQZGV3ZWcyeWF5cG1MWTlCaUl6?=
 =?utf-8?B?clJEek9aTHRSdkIwZUg1TG1jU2YycWxsaTdhaXp6MmM2NFkvbFRQTWc5R0ho?=
 =?utf-8?B?MU9oZjlnMTg4Q2k2OGU2MXA3UkIvTDNrK05QTXJPeEpGSWlreHVlTE1JMjJL?=
 =?utf-8?B?TklHNG40aU82QkxNRjU2aXBGZ1JPeTlXTXNSWTVjbVRJMEVLcW1zL0hMWVdj?=
 =?utf-8?B?bWMwSk1EQ2dtUmhIazIxYkxwcm1zOFlmZ1dKYmhtckd0SDNUYkpLZ3diYXZu?=
 =?utf-8?B?RDJWQmNXSzdDSTBUMTIvQjVSOFpyYXc3ZTQ4cWNZTzBjdFhGUWN6US9Da2t2?=
 =?utf-8?B?bTBSUDNwc1VYcEdzVG94Q0ZIck96NHpnbVpYTlVUb0k5dHRhZFB1c0s2OXZU?=
 =?utf-8?B?S2ZQODFOMmUyRktMY0kxTlhBRldhSytlS3oyVWNYb1oxeUFCdVQ5a2lJcWc1?=
 =?utf-8?B?RnQ4UWZIdVQ1YjZkcDlUQkVuaEs5MEphbUpnekFsbnRoUVYvaGUwTUxFakRy?=
 =?utf-8?B?WWZ6QTN5UDBuTU5BQXF4dGN1RGpLU0dCZnhCRm9NTVphaUJLa3pwem93bEtj?=
 =?utf-8?B?dklzUHR5TThRRk44bTcrVmdvOFNGcElaYUp6MkV5MFNBUlVBLys0RnNrZkJl?=
 =?utf-8?B?b0dKcjdUOU94Vy84RDNlbEd0RDFMR0dYOG9aN2RxcTkyd3lVeE9xMGxZWEpi?=
 =?utf-8?B?R3ZseUJydEMwOTNTdUdLcjZoNEE5TFRSbWhZVnZXQlovYkgyQkMxTzZINHk0?=
 =?utf-8?B?TDIzcHVFSGJydmRFa0RvbjhtTVVISnI5SFNBeWdKdllZWm01L2RKandSUVMx?=
 =?utf-8?B?UmhoQ1BCYUVlM3lYSWxGdEpmL1RYWHZQY1lTNmpvV01pdWF3cjZIMmdocVNL?=
 =?utf-8?B?cjRucHFKWGNCbGxPZ25nNC9RVXZQVUZxVVRaTzZsOEd0WCtmeTlPV29PR0N1?=
 =?utf-8?B?VUMrc1J3ZEpTK01kMnppSklqd09FQ2VQd3ZvaTdsSW5xQktNdmcxS0VuVnhE?=
 =?utf-8?B?OVFyZ3FqZzJiSkNnVTByV3lQelloYkhMSXdWdy9RWE9kbHdPY3N6WGdMVGpn?=
 =?utf-8?B?L05kUUtha0k4RWdJZ2RJbmZLbXl1bHIwRlVNQ1A3U2ZJS2wxUFQvd3NnNGt0?=
 =?utf-8?B?QkduS1MyVm1NNy8vcEFlL3VUTTkrbDlqSktoUFA2TjFDQnRxc005bzZIQVc5?=
 =?utf-8?B?YSs3VDh5dHA2NTdJcjNWUkVVN2ROUU0rUisxaWxYNjhidk45YzhKNG01MFdT?=
 =?utf-8?B?TTJVbmkxd3BRWUU4eEtyVVltQ08rY2hlaC9VNzFxL3o0QWh6cm1MbHR6c2Ru?=
 =?utf-8?B?WHdrVHI1WGFTdUFKR2tJSm0waTlkMGRHSmtPWjFVWmoya3lkdWZ5SHExQU1H?=
 =?utf-8?B?YUJXaXZibWh0MFF0cVdCSHZHaFdRYUZTY2JxcjhaQkhNQmU3NDNOc2pzKzg4?=
 =?utf-8?B?WklJTGROYnd1TUowcUNxV0Jqd3c0KzlUaGZYUkVGbndXTjd0cEZFM1BZNjhC?=
 =?utf-8?B?cDY0SWREd0pUdXc0dTZzSUdyWC9LNlFyNFMzMnJ6c2lrSjF1MWNPRDNmQU9q?=
 =?utf-8?B?cWJOaWdvQlE5Y1VoOWNmZXlnOHNvRXpBRW5Kck5kYjk5UDUwUS96c0t0dGNB?=
 =?utf-8?B?NWZMZkNsSnA2TGVjZUlkYlU4ZGdTNHJqb1lXVVJCUCtEYndxSlBHTUtJRzJR?=
 =?utf-8?B?V3RiZW83a1d0L3FQZVFYaERna0oxUmNDV2NHQlc5aVF0aFlIY1RBWHd3QkEw?=
 =?utf-8?B?TXZmOGtTZG1OWVZSdkk3aWtKcXhnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EQsIQxxHjvHpbUWjHgSbklDiFgAZrd2O/W78vF7i+mhQ3bK3u+T2vvSwRCvoX8BY875dzVBVk73Tc6yaUc+DH4pM48ArwbQ8Z46bT4JSocZDwR5P8mri/OWuqHyyLCjxTyUBcxVB8S0ZkZONd9xRX8I0eJN+G5FrmCZNhxoH7rA60e7hxwgnDlTF+eu55gm04UVLvzc1rK4r2j2YDluT/aD52nTBj8VMykHnhExJhBazkNaYTMlCgHoKO5JqIOu5hxWxKIAQ+OtU8sA04N7Y8muChbtICZT7MlA8lkQq0UZrWLqxawMzfQQPf169F0CmGSjk5GtTY2a03/x8ahFQ/hQRlzHiUExkcudjPSrilSJYvqbBChL0VlYE2o2+4Nw/oT5wctZWxxx4JMu8AVk8bU/NVnJPfXVoQ0zNkBj5IF62Gaj6vjxtb01vt8VZuCzN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:49:33.9486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52050e89-a713-41f4-fa05-08de63443589
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3968
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

Add STM32MP21 support which is an application processors
(STM32 MPUs) based on a single Arm Cortex®-A35 core running
up to 1.5 GHz and Cortex®-M33 core running at 300 MHz.

More details available at:
https://www.st.com/en/microcontrollers-microprocessors/stm32mp2-series.html

This series adds STM32MP21x machine, clock and reset drivers and update
cmd_stm32key, mmu, rifsc, syscon for STM32MP21 support. 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (7):
      clk: stm32mp21: Add clock driver support
      reset: stm32mp21: add stm32mp21 reset driver
      stm32mp: syscon: Add STM32MP21 support
      stm32mp: cmd_stm32key: add support of STM32MP21x
      ARM: stm32mp: Add STM32MP21 support
      ARM: dts: stm32: Add stm32mp215f-dk-u-boot
      ARM: dts: stm32: Add bootph-all in stm32mp215f-dk-u-boot.dtsi

 arch/arm/dts/stm32mp215f-dk-u-boot.dtsi        |  19 +
 arch/arm/mach-stm32mp/Kconfig                  |  27 +
 arch/arm/mach-stm32mp/Kconfig.21x              |  37 ++
 arch/arm/mach-stm32mp/Makefile                 |   3 +-
 arch/arm/mach-stm32mp/cmd_stm32key.c           |  70 +--
 arch/arm/mach-stm32mp/include/mach/stm32.h     |  12 +-
 arch/arm/mach-stm32mp/include/mach/sys_proto.h |  22 +
 arch/arm/mach-stm32mp/stm32mp2/Makefile        |   1 +
 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c     |   2 +
 arch/arm/mach-stm32mp/stm32mp2/cpu.c           |   2 +
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c         |   1 +
 arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c    | 192 +++++++
 arch/arm/mach-stm32mp/syscon.c                 |   1 +
 board/st/common/Kconfig                        |   2 +-
 board/st/stm32mp2/Kconfig                      |  14 +
 configs/stm32mp21_defconfig                    |  78 +++
 drivers/clk/stm32/Kconfig                      |   9 +
 drivers/clk/stm32/Makefile                     |   1 +
 drivers/clk/stm32/clk-stm32mp21.c              | 709 +++++++++++++++++++++++++
 drivers/reset/stm32/Kconfig                    |   7 +
 drivers/reset/stm32/Makefile                   |   1 +
 drivers/reset/stm32/stm32-reset-mp21.c         | 136 +++++
 include/configs/stm32mp21_common.h             | 126 +++++
 include/configs/stm32mp21_st_common.h          |  51 ++
 include/stm32mp21_rcc.h                        | 651 +++++++++++++++++++++++
 25 files changed, 2135 insertions(+), 39 deletions(-)
---
base-commit: 66891ffb14920e35abfafcae795cf4604de6682f
change-id: 20260203-upstream_add_stm32mp21_support-0b0ed074dda9

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

