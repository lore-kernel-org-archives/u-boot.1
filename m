Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0885FC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB6082952;
	Thu,  8 May 2025 15:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GsLWiWzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDA68294C; Thu,  8 May 2025 15:14:59 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70ED8212F
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaQtBx0fvg6l0Up9zsWuG8faQlyXS6vPYkwbnRKFxtrKLa7mzzUkkp8xLDy+iTOZ1RDVrxMW6+UaFKA+n+Yr+CbKVhh34HfpoJOQADvseZ/pfphFM40WKY4Y3YR2pYkE3NBK2e2mJsAozPsBtLWpTPasx+qZju4ZyHcFA9cXua/V8gTNUm/0t0w6UL4twL8J8siijFKgnwCpviK0sLMqTA3kV0cuCRop01tFUJQiYOEfkLkUc88rjpQj59/GKgnmosqyvW1GDg2jSRghACsZw0e9ois+EzxTR6JV8aLxTauxLsF0DEQgA/dT6aPOOKWKUvLQry+MLdr3dy+/x50hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2oH1T5S/HylFU2Qlk12srS+xw3i9zNu5mqsNXfnMHE=;
 b=KJPwmyl7BGNZvxPffIuUFahKoSHaADHfQC7i3iAgcrrFWuMzIZTo2SdLLnE236WToRsKULv7hEC/jZNB0N/MGPXpGj760Q7Plo7Quy5U7pUfGDeqTS3MSnVgsBsnry7iaM+4QNuQwCckGtNLQIsXxTH+H+sd/bKgim4OIJAS1eMcaBexyD9PvXuZwqVJTigybRHPOeh6uw0Tk9Zay6moE42RfhCxhjCT87ofFPfSrFaE5xjAoGqQYpl8hM5aCOQRdG0tSKRgg4GTuSsgccCShRS7onKFDbesKM8CvZLKoLMd0R9RJCtgaaWZUtYmXDxiWRtUzCXOLnGNV+e3+h4Vvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2oH1T5S/HylFU2Qlk12srS+xw3i9zNu5mqsNXfnMHE=;
 b=GsLWiWzZy8UVBWgEAUlnZ/bgWdu5mBzDcdljPgOw/9GKdqIvdXX4NLhB9NvJA40pJ6DgP27wBoUSp+Z3zS6PF95/0o2jw/ry3Z6ML/YYEEapYpg4EKmvBWVmETcNna7XqvnR3CsjSMVWZVuUKl+VEm0lnKhHdmRaXqj+g9npzTJ2hyWjxQ4de+Jagi4YBBNg2D2UOLkd80RegEjBCp/eKCInIswhDe1a27PbrHnM9zsdhw+7g6Ivo997/Z7a4ZsL/PQY9ebxPZtqoGcPSHjSGg9tD7E9aiJSNINNFVlKH4DEkb4xiX8Qet28kRQpcZKOzzl1eDv2KjeBD+VhuZIxYA==
Received: from AS4P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::20)
 by PAXP195MB1199.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:14:54 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::18) by AS4P189CA0005.outlook.office365.com
 (2603:10a6:20b:5d7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:14:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:53 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:52 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 0/2] *** boot: Add Kconfig options for script-based boot
 parameters ***
Date: Thu, 8 May 2025 15:14:43 +0200
Message-ID: <20250508131445.2557222-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|PAXP195MB1199:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc6f741-0d0c-442b-b5a8-08dd8e325244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t5jpoKC+653bhb4hYBRZW4/NvYlnZnZEoj7BdJluWVsEx85zjochdnHTaVGl?=
 =?us-ascii?Q?FGBff7sLk6sLr+gnuD4hYSJP2mo0SmGf6qdPbU1BeBQt0o5dDWY75UzFOQz1?=
 =?us-ascii?Q?oLgahb1mK7uVVhTnd8k0T5KMBngLPn58WAvIE4P/AzjaIvta/DKz4cb3fufC?=
 =?us-ascii?Q?v6Rxk/7rcSNKTel/UhKcB36Nv5oeccbheGXVV92pNQD+JL64FcJ88WsbK1Pq?=
 =?us-ascii?Q?BQovIvUWXuDA+OZCamg3ZJL/tkt+UBg6FyN+/uDnaCKfyjHTDUeyXg3eNvdr?=
 =?us-ascii?Q?/RUndaKNe9R7+yVGUwRuw8Bn/HjBOgxkKBaNjKn5pO0tWVubHbk/6O3VDKHv?=
 =?us-ascii?Q?7+LqSByEnADwPgASrov+jriZBcbS5WO+Zyk2TUpokCkjQ3h+HaErJuvj+FNM?=
 =?us-ascii?Q?sf0TXbp6VHav15l5T70WK2FPSUb10UMR+Oj6+PmAUnXtu/wq/Ql3sDtBvXnt?=
 =?us-ascii?Q?8eRyx5O94UQQA/XtRmvdkNcMm1aLLktsp0tau7T2DKiHfSnc5774Q0JcEH5n?=
 =?us-ascii?Q?O/fr7Jsf8fVE4nqETxFe4nio/zNRTdZ2sjeZuVqPY1jfNH/+O0XtlI2qsOE/?=
 =?us-ascii?Q?J935r2jfOy6tRhKpH/gXB1IP11Yv58kHHaGQwNufZDSCVyJMkB7vA3jD/HpI?=
 =?us-ascii?Q?BdeAysG/ailh34A2M28eKel52P2EK37svMTmB1LHPxPmk64ZPF/2HlwRNnoA?=
 =?us-ascii?Q?eKM0frF76Ge45zXMpYoLjpES2ah1ze44xaZKnmznUeE3ddWtytj5df1XZMsy?=
 =?us-ascii?Q?VoFRid2RbV4fUuNHw15sESQsK44gsAqYaT/Oyjh9mF+qFxboelOdHwvxgwoy?=
 =?us-ascii?Q?aH+J/WQNBuXa0m0L6W3ohy66+0ofLemYQATT5XsSHUMwralqgc5Y5//0KhWf?=
 =?us-ascii?Q?XHVxdlaGYAJvKXfmiBXYTf7GWAMklOptHpQJw0/BfZUwDMAY04IvHpjwYknk?=
 =?us-ascii?Q?gIbruSETFYJYAPUxukLWLibOSAHBpotgChodSddQ1uaVmlIErCv4D40H+WmZ?=
 =?us-ascii?Q?oKSbOyQgX5nQXcHwWo3tB4jsZl7ZC1v6NQjwZ46eVUcsqfE/G+YYS8VtmQo6?=
 =?us-ascii?Q?GeOzLcWS26IbCEKNaxAd6t1stxbiF2SuNOsXSvY/mBrnCYGFSMvePfNGPYUA?=
 =?us-ascii?Q?wsYVV6re+/XZ52jbyyGupQ3IsIi/KPg4WXkXzp4gztHRkLeNM9thk2afaV+u?=
 =?us-ascii?Q?cANwFnWR3rSF/qa1smT2HRVck+y38Jo9HK6xfg5MofPGr7hJlRy7ZOPWqjWm?=
 =?us-ascii?Q?iAYemf7U0J7qA1z75oLxWmjwT9Sn9oyM264XnNbWbTmXC8tsGxxVlBHhU5vS?=
 =?us-ascii?Q?Pt/xbljbDd3KalVv/e5lXzqYgFzYKscE9XkFW4b4moYv5U8x7LOg3gv0nQ3s?=
 =?us-ascii?Q?EmypbdObjEMfvphwgDEzOidSv/ZFEVeqvUi0QlyY50cJxRv4gYBHfbY0PVLs?=
 =?us-ascii?Q?sAbYrOgg69nIlVgbKrQAbK4Aw+JIS0EyiZTBf7pX45C68uH81oygfCld/4Rq?=
 =?us-ascii?Q?Er5NunbEqUoDOq5Le0pynZiscrTRGHcJHUAs?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:14:53.5758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc6f741-0d0c-442b-b5a8-08dd8e325244
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1199
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

This series introduces new Kconfig options to configure default environment
variables used in script-based boot scenarios. Specifically, it allows
setting the following standard boot environment variables:

- boot_script_dhcp via BOOTSCRIPT_DHCP
- script_offset_f and script_size_f via USE_SPI_FLASH_SCRIPT and
  related options

These changes make it possible to define standard boot environment variables
directly via Kconfig, allowing higher-level build systems like Yocto to set
them at build time. This avoids the need for post-build environment patches
or runtime overrides, improving reproducibility and simplifying integration
in automated firmware build workflows.

Wadim Egorov (2):
  boot: Add BOOTSCRIPT_DHCP Kconfig option for boot_script_dhcp env
  mtd: bootdev: Add Kconfig option for defining script parameters

 boot/Kconfig            | 18 ++++++++++++++++++
 drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
 include/env_default.h   |  7 +++++++
 3 files changed, 51 insertions(+)

-- 
2.34.1

