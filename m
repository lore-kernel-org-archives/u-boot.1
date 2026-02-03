Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E94CE8305D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAC584008;
	Tue,  3 Feb 2026 08:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Is3SfksX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D62B84006; Tue,  3 Feb 2026 08:53:01 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2362883FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oieaa1uNBebi5KwBDMHbO8JHtJi/iH7d0VhlZ/PQYDrsmRZDg2WjuUyyQu7fYyYe0gL9XwgDKHZi5HdfSx28/C095d/bnJI8ShrL5q7FoL6vOg3BVVpeOa4ewCDYG7DB+5UrsihHp8NbMNap8DjdJ2u76jtLnKLLS02eFo5fw5A1Jfo4ygBD9gGeeW7qllv+LZARgw1PTdIPiZbc4ho9GysjatzVVaQd9ih8zc2ucMji5im5zOA5QGELOSUW9obt6BK0tzkJz+WCkMRa0iKMBjUcdY79SzrSoWf8QqQ20s+o8Q8Re3M/8/IKjEujrS8VGj+pzj+kmjw9B5EgtkhILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBau5nBBZUDDAvwOwZAfpW2+0xf7OJSEt0VWkwzKpD4=;
 b=Oic9G99WVaGVmFA8Dd56WXs/4FeUNBwlQYJ1hRSoLnXARro+cJwi2RD3bWFTel3W+pmL6vcnbidxze7M19C8etul1k+NIFGeOMI0VQI/KyWJSMm1bGaZnGpvNtpsEKSGvfsd9fK99kN/GKSLV95YWW8P88AkU9Hl1cdJKqSUGKFN/4KJAyxruuHa2CPepgErh6on5xw5BeI++UfY+qDrU+aqdJNvnTYW8p3uFHIF7O9Uw1ZQdwcxBS2isQzr5w4rZnJDAXMLckcQ5XqkjLbE82JhV3JocBC9KkkpNkcjLwORl+Cilo5rIIHGVtcvoC02vJYVAvR2Yt8HCcHi0xPjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBau5nBBZUDDAvwOwZAfpW2+0xf7OJSEt0VWkwzKpD4=;
 b=Is3SfksXKCrGICdQ81zYg0HpO+2pmjrJ4ilxrpJfXCtiYHoILdK4lO4ROSgWKPLsmPBzG8BbJ4uDwG4kVZwzYTiemUDlBFt27l4is0M2TrM3++/JFWMzNfBMMHVDMA8nibuv/sUskW4iGuIRq/1UkpNxAK+RmO3Uh+tc1zKjpqM=
Received: from SJ0PR13CA0073.namprd13.prod.outlook.com (2603:10b6:a03:2c4::18)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:52:53 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d4) by SJ0PR13CA0073.outlook.office365.com
 (2603:10b6:a03:2c4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:52:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:44 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:52:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Anshul Dalal <anshuld@ti.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Eoin Dickson <eoin.dickson@microchip.com>,
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, "Ian
 Roberts" <ian.roberts@timesys.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, =?UTF-8?q?J=2E=20Neusch=C3=A4fer?=
 <j.ne@posteo.net>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Nathan
 Barrett-Morrison" <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nithish Kumar Naroju
 <nithishkumar.naroju@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Rasmus Villemoes <ravi@prevas.dk>, "Rohit
 Visavalia" <rohit.visavalia@amd.com>, Simon Glass <sjg@chromium.org>, "Tanmay
 Kathpalia" <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>,
 "Utsav Agarwal" <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
Subject: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on Kria
Date: Tue, 3 Feb 2026 08:52:29 +0100
Message-ID: <cover.1770105146.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1277; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=tGcpPUmyWtPIWpqbQzka/I8eIKfq9rGgWhRgcC6yN24=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rrTblpm7WJn9SBZz44eWt6zP5ySKJdn9UW7M7Q1a/
 Zc3IGBjRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzEq5/hv0PHguOBijVGDzqN
 vTInrOpbJHdF73LZX1vOVb3zWXme3GFkmPTx7q+fW3eqCPw7sTb/6JxHuVWO1144G98zED21Qf1
 xFB8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c44f53f-7f09-4eb3-dc0e-08de62f93c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GFgrmunuI555VbJYSgZpm1pXogGuCQ3thCZraLgDjJMqvEpzXFVgGZNo9B+D?=
 =?us-ascii?Q?6eyvC8ChQib6bKhy+/MckE8sVjgibiwgRwQud0u19Y/tkZtGUNiqUlKaueb0?=
 =?us-ascii?Q?jnjOY3JvKogxMXOVFrbIHBUvRZYD+T5NcqTlJtfBcuU/UkOISO9Iu+6TF4MV?=
 =?us-ascii?Q?QrwZ3KiU7QDXC1pZijbdOK4LlmfEHILyO1ztnxkTTJRLpyAozD20lh1ZHWON?=
 =?us-ascii?Q?1evDQfiBMweTIuMHSRVMvvqbBopMt4cq9216GWW3Ziu/jfiTfdUWI3x9KtpN?=
 =?us-ascii?Q?dTVTQbfPQBoTDFNVBayUgjrVhvhZCjAdbaTlgYjRSVo2ogCDHLC38fCUE3sb?=
 =?us-ascii?Q?XccTDyehiiAgWrQUrJkDOy9xo0k1Xb7MylM2myoulCyqrQ9E9MNLwvn3vTgz?=
 =?us-ascii?Q?qq/zgXYed5X/ElCN5pPY9iNAzQNKd3WQOXST6Roat4+yrEo9RyZb6zLYKzW1?=
 =?us-ascii?Q?2apkEGPFn0rG5Yli1p8OQVXIAMOz8numdT2aT4tAZUogrlCEE4yjoMmvYWSR?=
 =?us-ascii?Q?JMHRYwBhwcamQ0VOOTZ0zZ1rv2GUv5zzKUAB/1yrJ64vIaezOiU+oVdc1B5d?=
 =?us-ascii?Q?33hOG/1qnAONYQteK+cncvKGzVRIvVhiEGDGq9iMxyamwtVY/+gKI/U2dZs7?=
 =?us-ascii?Q?Ujo5FSk9+8kE9ftfGoxdvWtEMOncWUcHJq1BSpahi48c3InJ+QuqWXu+tJJ1?=
 =?us-ascii?Q?mUTiJXZp1Q8Uiok4UCEsc4QcGF9Q5Q2zme1LcKM3S9JZ7X3fT9cVUE16BZG/?=
 =?us-ascii?Q?+LEq8Zb6iFPQQyyZ1DI1BOPKlmhpUVquOe6xg2iS70sVlm81LSCyNk0XNsrc?=
 =?us-ascii?Q?YcatMxVD8B4HiJ85vPtQp+YHwxBc4ZTZ0vrmze7ceJsDStlw+VSYiL8rS05D?=
 =?us-ascii?Q?B8FwjQdkO8uAjsaHFiKk7C/lUTTN2QNas9+GIl+eqorSSgzM2UlAAbqZNtbs?=
 =?us-ascii?Q?p8bj/vWznB71+6UVddlwBggu1rFjQqgxXWJORgFJvxHDCaupcFFxlPg00fCC?=
 =?us-ascii?Q?I+uQxAdI3PZLuWT2vddtWDHdncGgnts5CRIxAHQh8/V/r3OLxdUoe3PB0SNt?=
 =?us-ascii?Q?2AK9ybFRRyRnQbBXpTlU6csc71bGlXFk0+Wx4OH30DEBaJRC2TuL97WN+vAk?=
 =?us-ascii?Q?NsMzOriRVh2FHQBRCplfUCAe2vGNPDgF6YD80AluHPTbH0TAgfKUDJG7sINs?=
 =?us-ascii?Q?7zyjUxh6m+2sCfLpeu556szH6dl2/aJd31IKP2uhGdsf7D9RKjuIYxWuumGS?=
 =?us-ascii?Q?zrSWKxGj8qO5jEB8CuxistZODVkYPfcjNJEj9YgxI8rbJAKpKL2TPg9uO8mi?=
 =?us-ascii?Q?ghwiAs0JLAogA6ayRk7aYx9F1fmJYEsx9LuUSDwKkpAlcM6fTv3lDDjyDzhI?=
 =?us-ascii?Q?/L/qIW39s6g+mf3JcEQo0FbABhjKWoJQdufPt+QHH8+P/8/AsOW47gzbKjDS?=
 =?us-ascii?Q?9+Nr2Qa9Z6yDHx6jagzvoe7BN096zJ1Kou2uQbLK2PiHMFEg2JaUpYiRGGXb?=
 =?us-ascii?Q?fj+A8gTdoV0bTBVI8rpgq7uLxMqc58u4/7cOCaF3FTC4q3qI9lXyDLqimR/v?=
 =?us-ascii?Q?Lvv79HnUMrzQx6eRjRQFWd8RmCpUd1ZUsh5pGT4Yw0clh+79/487kjbKbFV0?=
 =?us-ascii?Q?hfd8KCnNpJ5hcvoUfUfLT3IyoRM8B35EycqIGDTAxhZrfiH+zYDrYW9X3NUg?=
 =?us-ascii?Q?plGHCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3jzFoI/R/GTiHZzzLthqm/g7JRKjKIP8hKi0GZpU71VuFy6Vf7htLTlVu5rhSxbmISVsbhuw8oeTzkG4UxnFUHTUkrw+d46PdlSpqUwRIzmmxn1fHMbhIcDARN4/xlUOS98pwNZQN/zX5mFi2bT12rTVDvNJZaEutEy/zau6gSA1y8x4Iood/aXNlvn5DjvouzmNm+G/RlMdfCQrGfS4oVm9TvwKxiSvkk4AorN8HmY7tbOUZR218tyf/G39lvfFuPlQJPci4mDDw89hiYfNVkF+Gpq2x9CHvpg8p1YbdPvIb5IPkWApx0+gtRVsmKxhUYOU4G4b0PTDpfSBtvVecTiCDQq2v3pu++bj2D+H3sdlkxP2wTZIdBQE3VJ2Q8LyikqanahAlodS76zUDrWvGK0O3XxWa+oBj0Cgcuy9tNl5Z+ACABxcPvmWy65UyrJm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:52:53.3831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c44f53f-7f09-4eb3-dc0e-08de62f93c88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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

Hi,

we need to wait more time for getting USB hub out of reset to be able to do
initialiation over i2c that's why use gpio-delay driver instead of changing
waiting time in usb hub driver. Waiting time depends on gpio wiring on the
board which is in some of our case going via SLG programmable device.

Thanks,
Michal

Changes in v2:
- Check return value from dm_gpio_set_value()
- Do not use GPIOD_IS_OUT when requesting gpio
- fix commit message

Michal Simek (3):
  gpio: Add GPIO delay driver
  xilinx: Enable GPIO delay driver on Kria platforms
  arm64: zynqmp: Wire gpio-delay driver for USB hub reset

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso |  13 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso |  16 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso |  16 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso |  13 ++-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso |  11 +-
 configs/xilinx_zynqmp_kria_defconfig   |   1 +
 drivers/gpio/Kconfig                   |   8 ++
 drivers/gpio/Makefile                  |   1 +
 drivers/gpio/gpio-delay.c              | 139 +++++++++++++++++++++++++
 9 files changed, 202 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpio/gpio-delay.c

-- 
2.43.0

base-commit: bc3e36d5bbfe1cc3cd3bf8b0e5ddcc261fbfa14d
