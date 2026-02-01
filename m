Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C03E65294
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 15:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1E883B85;
	Sun,  1 Feb 2026 16:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HMJK9cn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3452F83BDD; Sun,  1 Feb 2026 16:14:03 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF72883B5E
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 16:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxpdNBv0d7hgO7KFBVUPJogTClDc34oRdJZ3pUWKZilajnSqQR/BBq+iV3jBsdERqCT9h8eu9tn0OkPZq1vp5A2WqN+6TGHvdA96wBUaF0OyzBfhQFwg6PasTxCP4ZN9jJNjM+RkEcRi3OGb6dxj2Qo6yZVc/WTMOoDZplxWU+8XKFVCgwWa92+CIeiU4qsLR9Iv7A9MJPO7XimUiyJ6BU+2StuFzSy/LBDF4n5Ya5KMuf9CAYEwllYw+bjpRb/MpVT9IECYS/3g0nbmLPHwuCzQkUM4GHYpsM+Eke2aV5pQ+DMuYwMYI++8eWSiRbohYEjzPgFLsQt8tspCf8wDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FK1lk86DgFPp07vSMbwMti7i5ke8EcGOc1wFnhQ+Iw=;
 b=MTgEiNHPGoH4qh0MT441qXDqsnER+XFaB3M4PNjcBdwXLAbUVW2jnDF/3BsYWIqEqXs+0aA+qPap8E3eDuIZnhNy1Wt6XUwOx0b24m/ta9z6rxf0t5KsGvDcpODwZ+hqXstr9eio7Ita9n/Lne1gqbpMXrmm7IDcZf/ayuf3fCWv4HP/BMjf7d/lZee50vC32RHqHDHWMP6VEWAhXO4JmuWdrA5BjesDjzCDp56n9XfhT+VRjVfFy6xH2MzX2tDyq6Crqn/Z1xmSCH2on3ktgyLcslI2GwTeXF4S+WtaiYt5qsls9ALehpmJF6ZSkonRl148oGBP0VyplkAZllWHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FK1lk86DgFPp07vSMbwMti7i5ke8EcGOc1wFnhQ+Iw=;
 b=HMJK9cn5Tu4BYGvxsNw2B06ZCLyEljN9ss11cpizo8K05+FPW0/DmXmN3UdpghpGi5BL1Tj7+2AO0wI3qRVnlW+VAJihWTtqaZMrDCsLDb3Zz+xXa71f8TxdR+ZuO66gJDfWTn02XbuZ50NBn2mAETfMGM1tFGRFrVyijyTu8Z1mwOS1dRXU9L8rymmGYfq3Pk17++CRnYPUU9BjS2fbes+C1kzV3mKkh75oA9/Im8tL2+KpkJEeROEKzWchPrIr0suGRBPhpckn7jUbL0tMI4/VlezKszSG5hJBjAiITFHrtjhWrpebAYHsaQcmn7MUp4ayo0rLYzGpwl899zIzWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7901.namprd03.prod.outlook.com (2603:10b6:806:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 15:13:57 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9564.014; Sun, 1 Feb 2026
 15:13:57 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v2 0/3] arm: agilex5: Enable high-speed MMC modes for SD and
 eMMC
Date: Sun,  1 Feb 2026 07:13:40 -0800
Message-Id: <20260201151343.27560-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdf8837-3df2-4950-92fa-08de61a48312
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2lP2+1j4lN2MBJcGHNSPsQQYEvTK9tCFABl6pBU78Rf1EAAqytXcR8NphD5F?=
 =?us-ascii?Q?aT90T6re+hthyrfsS3o1+At/N5PFonNK2IUSHIAdYaO9R7SNe5xVYsfEX53E?=
 =?us-ascii?Q?RYlEag2lqdqPT5Prua8Jf+O2VQ7vnlLA1mspg14u2YPrm/q3CrmsypdJIHCA?=
 =?us-ascii?Q?2WE9Axc8E+5vrVjXRkYoqxJdIPdstWuUh4J7JEciITamPoNLf18lwJOXzCNH?=
 =?us-ascii?Q?kAiJTzAdw3G0tj0vuPtjrIQohlLFCu0u0GhzWRX7/5D/5VrOM/X2U/6vn1uj?=
 =?us-ascii?Q?r6Q2DnHZ7gQMi+36zjO2bmzi1yPJacI2pSlnj7LLNnoIv3OD9iFN+uSbvQjS?=
 =?us-ascii?Q?L+uPRq5qotl8m5ay8vJ1H/GsnBo/sLIoH8l7sTXjJMmkpHHDAKz1NeXEycg9?=
 =?us-ascii?Q?/idKZLcWa+NiuKpafKUigs82LTfqnxHwTSPSfRils1Joi0iYI0K/Q2RllGTr?=
 =?us-ascii?Q?axshit8AAaOPNtnHpnkLX9iBvFNhakAzkDGOZCorzwO44cueV26SVqUV7kjr?=
 =?us-ascii?Q?8K1IGX9BlRq4PJHXOgl3aXZZ+Qb3zJatOa/gdaCgXVZhjel2J9Gu9syxSPOC?=
 =?us-ascii?Q?stKaBtKzxXU1PmzVBr+IARplomGq/WSASkBK0ATKmFgOlrilCxcF0JE646G+?=
 =?us-ascii?Q?jE57ne5TlVXW/4iRRlf8ZLvcefc7ohIduNBe+qQqDX/78RZdZqy0roDRLDz9?=
 =?us-ascii?Q?E5+vJxi+KBcaW+CX+n4Dza9kRikWgAV17FM0/CHJBn13gxhHR1KN8MoIHAbM?=
 =?us-ascii?Q?1NsuK74qBm5hOy8B9AZ4HwhKb9GhhgxEVZaWmAs6qMf2MiS0sl8Y1JnGeRaw?=
 =?us-ascii?Q?PnyA0XjM31WCA7bXk1fn2kXNiCD3jZI+SY83Bm3GmeVj0opQt6EmDtfEKCwq?=
 =?us-ascii?Q?pLB48quVDP9ygmDxSVhuDYXjYbVwvKE3KH1XAxJjj4+vCPFdcchCwSUQMNky?=
 =?us-ascii?Q?X+qpIDM7x2FuH7xgpnNFq8ccyb8C08POmPHSARUnwO8lQfHbz/0eBC8FODhi?=
 =?us-ascii?Q?Ur/QxAq9x9d2XknhZeMJ8V1G765UimVuk7gghv+8mWNCKdz0T5r8/t5qvAC2?=
 =?us-ascii?Q?i3FaANyfetXvLXpus/fefzgipBtmKzwVHxLDf82xZ/9UIBDTZJS5dBhxaY44?=
 =?us-ascii?Q?5cdOXNR/srQkWrIMWFnSGqNPlifnHFG6NBPW0uOeBT+zMm7AiPI5hmH+MCU9?=
 =?us-ascii?Q?joxPvqdEZLgQmKSC30jA2V1wDBHF8ulha3/jYMWr8HeAtyWuU+mPi5//4DgF?=
 =?us-ascii?Q?iLym3ASWF4XLiE6G2CCjkLjjSR6/49njsWFp+dpMyf6h3ixNjJjHTlZPECqg?=
 =?us-ascii?Q?45PAiqL6GZA69YUa5mPdug1hJAJZaUD1G5LAX9mImHB9wX2YmcNR3lr0lh1a?=
 =?us-ascii?Q?L6kl/sAL0jtY1IkhqJY3S9XQcmepdmNVKGIs3cJH97pWg2Kl4KtuswlZ9gMC?=
 =?us-ascii?Q?+waZXOgXRI2sIWbSlNhkUhB4KMxvkNmyzNG04eZttZ0ndssqM4PW6CEz15j2?=
 =?us-ascii?Q?0eeJHKiax2ibnq4tAOIwxsvWIO9dvc8v9aysRxQ/O4MIk9SKsylpDZE2lCUS?=
 =?us-ascii?Q?ij3MG5W5OHhOXcon3rI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuhFBvEqwCEGYWaocGYecQtTrmU7uSHAEgftz8ZS9eGUzm73YEWnE57HUF2Y?=
 =?us-ascii?Q?buoFwqL5uOYIWMfIPD7YXrgN2wgAeZV3fG8kkrdSGsBH2mHcmB0dDI875dE1?=
 =?us-ascii?Q?umJQF3weiyVouznxVll7aXx9cppKcJr3+36cIWtUJ1kq+7y9nohnYVfG5vh6?=
 =?us-ascii?Q?JQmz6ggyGEEHTjOlcrfVogRCtnb5KBcJmStC2f3Zdd7zHXlnN9tFiQ5xrYq5?=
 =?us-ascii?Q?YcHPK0XsHo8Suq8zflmJVNuqwndXLpoiHJ8AoLN7d3/BAU74FbZBXDWY7KQ2?=
 =?us-ascii?Q?I7egBOQLCRWuIt+jCsqfbsQpH0yPxcPAXC3eXcUNBJXQFp+teK2MBzRiMsU6?=
 =?us-ascii?Q?9EAkXHN98vQFKEsbcNcbc/r29xa5OApRnbuX4JqmUhnffluNMmdSfzsTFxu7?=
 =?us-ascii?Q?8SxTcQFgvo8UlpcbEzwY2yG2XgccXwPaUL0BUJZw8hWBguhXkQsrr4qgs5wd?=
 =?us-ascii?Q?wsrEWFuiCLS6yC1pSmQz+z/PiPfsBMqBOSpimp6fCJoHhJDRcwdpIpP/IO1c?=
 =?us-ascii?Q?KKb7gmPJedDXyB8HA/UQoVmid8yHfxT2BI5KZJo/Is/k/C45lV+tXcAuxz3r?=
 =?us-ascii?Q?2e2EsDn2MAtIDi+WhZYuTCHUQGmlB1GsmvzHjAR/zD7+cZ0KWEEe1G7M1+vk?=
 =?us-ascii?Q?JrfNQhQvpSJC+IxJDhM4S+NZoYDsWeNS94R0Ku6NIl94ScDmaCC8i1lEIWcQ?=
 =?us-ascii?Q?bGdAr4jV6XGliqyJfLHVrU+9OmYPmbvC/t4CrzYTnpcz44x78OESNXyCN7Go?=
 =?us-ascii?Q?r0mrrUs7gOoXRrwQ+EaD1GrV+G8nWlbcvWbm3cJ7IEdhEavAWKoGcPqwQIsH?=
 =?us-ascii?Q?LL2Q9zW0yqUf1V5vV0NtcMgDtiRrbLwr9jajq/CsyOHihNI5BiCeuhRL0Xm5?=
 =?us-ascii?Q?NyyjZvzwOdSk2Yxp8/+rK7UXEE0RZP55LgKqrYLEwZFF/obz22fFcnxmW/zP?=
 =?us-ascii?Q?LbS5CmX70cdJX5jcGzCclSCmX4B71hP0FDYusn7LE4ImnZ0yWc+rz88Gh3kw?=
 =?us-ascii?Q?wxf6D80cGV0Ke6KZRe31UkZYWUmazyFJGnndsG2swRXvnNVZWfWrr+2OBqO0?=
 =?us-ascii?Q?86XJkpDtaOObkueMjZ5CtxiAph6XcjGdNik0plDpdHNHLHJbnZseOp/QFU0z?=
 =?us-ascii?Q?sSgEmxxCG4KKzPvxfYH+My5GoiNGA9x2pH/Wx43Df+1rtDzZu84/Ju/1SNEs?=
 =?us-ascii?Q?UGORhuNH6484wGdnyYMd95toou+N7FoQ/ALhVfd6imJsOBp3qUmdPouBYan5?=
 =?us-ascii?Q?M63kw+M1q7QAgCYhDAua3UVagIoewS/UrFT3AvazJ0NxUzqOKWH2Ov5hLY0x?=
 =?us-ascii?Q?PaGzfolOHRsFQ4ocbVjygiYtRZIgYYm6c7ydukHsRNAd8O+2qtz95hzsydv6?=
 =?us-ascii?Q?KxydwB6Oybh8E/Ns75q/7ycVcVhvthzTugJnUywRro8YPEgXjdfyf36UeUyX?=
 =?us-ascii?Q?+ZJHCJRI/a0VlFJOr41pr7D/KZIWbniWToBIXKm+72f1kikbiS5ur2YGEiJh?=
 =?us-ascii?Q?Aq04fNh5lSdh02S5golqZgyNbEOUKz99zDiULLSqWN78K5kiVOS+VFZ6TrGz?=
 =?us-ascii?Q?ekAeHOHpEAomz/bXK9II+fnWEXQnZyC+DHkzz6wHkYyW2p0Oa0vbQdg5IY6h?=
 =?us-ascii?Q?d7AnXCMJH+SKMhfib0IUFIVm3Y5Ryp6OBm0T26VlExQ8a2rqzuQoPLbNxmXe?=
 =?us-ascii?Q?Zhs0oXVAjcplqEG3r4VD6xL25GY4ZTAJW+9vcNn9Ivp8VZNWbektSxKw2xeu?=
 =?us-ascii?Q?uvg2bulEmcgSMsKmwDkvZxyn8w+W2j4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf8837-3df2-4950-92fa-08de61a48312
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:13:57.3643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS8XC4izUQ89h3rWcW4YSgV/kYXDHfnATaVD7gJMXMgz53M74eCYArgMnGzogDpp7z85peP6Q1eD4z+Zk3grREoGYmUODvOJKbJW0Ppm0hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7901
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

The Cadence SDHCI controller on Agilex5 supports UHS-I modes for
SD cards (SDR50, SDR104) and HS200/HS400 modes for eMMC. This series
adds the necessary device tree properties and defconfig changes to
enable these modes.

Changes include:
- Fix DT property naming to use hyphens instead of underscores
- Enable SD card UHS-I SDR50 and SDR104 modes with PHY timing config
- Enable eMMC HS200 and HS400 modes with PHY timing config

Tested on Agilex5 SoCDK board with:
- SD card: UHS-I SDR104 mode at 200MHz
- eMMC: HS400 mode at 200MHz

Changes in v2:
- Dropped unrelated copyright year updates from patch 1/3 and 3/3
- Reordered PHY timing properties (dqs -> gate -> dll -> dq) for
  consistency across SDR104, HS200, and HS400 timing configurations
- Fixed missing newline at end of defconfig file

Tanmay Kathpalia (3):
  arm: dts: agilex5: Fix DT property naming convention
  arm: agilex5: Enable SD card UHS mode support
  arm: agilex5: Enable eMMC HS200 and HS400 mode support

 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 29 +++++++++++++++++--
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   | 27 ++++++++++++++++-
 configs/socfpga_agilex5_defconfig             |  2 ++
 configs/socfpga_agilex5_emmc_defconfig        |  2 ++
 4 files changed, 56 insertions(+), 4 deletions(-)

-- 
2.43.7

