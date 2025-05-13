Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B673DC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C9982A1C;
	Tue, 13 May 2025 14:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="i9DJy/oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23638129F; Tue, 13 May 2025 12:21:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D59638091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJ8hxG7czB7buaT4yjnpl/kxBhsvCLmGzp2tlkBPF15BEH7ED2XvZwio6+1+WQN8T6134C+3aWEaidmgO/vLe8qqdCGedysdyeV9oLaC3fBkdoGUwbcyMNQMQwGiQ4QAAGDYr42bFSlT6rbIHvqoMWAFgOqqMXsc3lhf7XlNnjj7rlyCuhUqiZCRzhH4ufb3S8tIS2h0Zbox4WCVHUYdY+OavmuZn2w88A+DjLzQjWrg7T6fvAwGwALOmwKA5lYVAxo2zTVyL4p9XPRgNYVi2ij2ctZ3HRQsjVVnMck8YQ6rPJFIqZzB26ALGS2ydxX3qfhUYSEQ+URjjChOZt7hDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VokLj4ZjN/gDJYbelDCYsdHJvt3648tMWUIC3SZkrsw=;
 b=Q/cWi00JGTFfjAf5zV9+UrcwJUFDdC2fb8SnGNFFanhZCWyN2SKI9TPo513HeKyWN516ht5VsS+2g+U2UykHuU7bH5xc0C39AcyAt8OnT6P7hHuyvF01a6Ec+U+bXk69blJym3JgL/3xuN6Eyaa3X00Ne96YlKsHfR0iPNwWfOzv8OGUNrz6Rb0ftF21dJRKjEZn+ynxy4BJ2uuXtiC9MRYOs3fSIImsYVfqk4pJ0CY91yhiWNb2/TrX53p57qfl8BkQypcnazvHAc1wK0asgQFrVOTVDrVRc0xOjRRUtis26HYwL6UfJe43Vohp+ViJdeFJvnQITHSOs1TzCaeRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VokLj4ZjN/gDJYbelDCYsdHJvt3648tMWUIC3SZkrsw=;
 b=i9DJy/oj7TXxf6gHcG6OrTzTShnizqKBBL41HipivTp6Tj2mmJq3HtfxJP0Dt5BLG+whnAbJ7FT9/yAcKje+yIHnuIaogA8XF97LTCrjgBodJycoxEpB0Jdyt7MlUb/23LDhzpaJ0xctLpC37otVhxcoBp3VQp5qALd9dJU4HfwhdN9pK7Y/GsC03FMm4EzPtRyYxa/BHEKbndJYj/BPqCbnpepWOYc0zamFsEGjAC2Vzztr70Hz7ubW+ubFzfDd6whzAbu45+w5VKQL4QTmmsogQuzaKlH6uR1teAfP7dyYruayQVeFXHNl7iu8VrqdlkksPISIOUoKLis372U0Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:21:23 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:21:23 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Tue, 13 May 2025 18:19:13 +0800
Message-Id: <20250513101913.30880-13-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5208ba-3bdd-401e-f482-08dd9207e8ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CfosJUhWNoGv9RGnpiahlZiczU0Bq0Rv+K/WHHXLPrsWbUdTW7egI7qvqhYs?=
 =?us-ascii?Q?IynqMou/2J4qFW1aigYDzvl13STwp+xsmZ7hFbR586wl313JrJDDgt28ldXn?=
 =?us-ascii?Q?wGFGaf+3WRkjqG0oIi6so2r9rsSTTE9NJOfGwbIdQsp9zX5h9cp3Eu7D5MvQ?=
 =?us-ascii?Q?5Vb34bEzb2XgkW79eRU247sXnmOW0oUDs6F0hHaBZaNLqv0oSZowidG79Q6l?=
 =?us-ascii?Q?3esFZvSBE7KBjN0UE1SVK/aj/v4KasAWZ5JocfUj8vtyGzqxLlpI7NVPM/Ag?=
 =?us-ascii?Q?z4nF3Qd97NfPsmkHBv2YzY1f19gdUpdyVBEHO4v6IJfGqTIt+952n2+0p49C?=
 =?us-ascii?Q?uKGcDZQ1UYbQJqAfoyYIaXBUu38cScIscwn0D415U8U/J5XIfqYMJGhO0hN2?=
 =?us-ascii?Q?IFRgcXZRFLRg/lN7Tawhl6xxV8tLokMPvuBjSgeFtmslaSkKw8HUeM4nlxl7?=
 =?us-ascii?Q?s5Ghz35sF9cEpB1CtjAy11HwZEK0/8p0+3RPPndCPOLn3ZaZLNqk12CPDFPn?=
 =?us-ascii?Q?Uq3hAU2g1TM6Wk/XrtHD7xz00lLSCkAk4ydgoS3i0axjS/d21MRXRUbjYyJV?=
 =?us-ascii?Q?eXC+1+N4YU5EcBxttWnCOWRkL2DwX19yi8v6Pue1jYgDvjkDapAdeUrTp8H9?=
 =?us-ascii?Q?1srV0ShWIGxsV7QUISPhecuDmHRLbvhawbJE8/33T3RECjxuRIgKiCjliNRw?=
 =?us-ascii?Q?rGiQ5Rk+V76kbZoJtxkAOtK47B/leUOgJEjGDSN/d4t6PA+fcDmtFzoGzMXY?=
 =?us-ascii?Q?DjWoqg1TNSN14sf9ung/xWn7v8HmXezI4W4D8qzkvqopVeChzusPlkpm4FPq?=
 =?us-ascii?Q?fZ5dvEh6f3rvcPao+y+l7h0AWsait8bHTCjX7qUySm83Ypr1GA9Wdy5SN4eV?=
 =?us-ascii?Q?p6ZoI6rghqdAHlFyYit6nIWNTlDYHt8iwRYxtSz5VaZutdPpQAw5QkVL/qKS?=
 =?us-ascii?Q?7IY2Dexmvjly2o0Q4oYujrNG2l97ARihMigQy8PwV23hq4/sK6dphnlatE1j?=
 =?us-ascii?Q?SU3sNLWmRZULebR7OjRKavsK21JUJl6nI1wvxH/em2CCcTa7RW4n0Q13jZhf?=
 =?us-ascii?Q?MlyJuoS8NLq+hm8R45ry6TgRf1p+CARMhvY9o7A7xJkZCesYxkedEKniVh7C?=
 =?us-ascii?Q?q7goqq3nF4q883R6jYjjwHVSpQe/IWPESr8RsScBufbEPO1wnCHRu4OWncei?=
 =?us-ascii?Q?Lk0ZwQl2pFfR/j6UkTz4j/knhLhF4NxsdPVFpGcU5KhQxCLawUrTui9o3U4X?=
 =?us-ascii?Q?fjRou8oBRvR5Kjyjc89Yq/DEu2AGjdL6z3lTkiprgiKaAWOZYBmHD2H03AXp?=
 =?us-ascii?Q?EzqsXBeB/7d4UgIYbuJDxbMVMMGjjvoqjTZimJl2Vy/GfujIs4BWZgtbvCNf?=
 =?us-ascii?Q?fG3qO49pwHtLD3O3nkdlWG0CHzho4YkvZtWNhkSmVM/XtG8hUqS+T+daOTU7?=
 =?us-ascii?Q?qOlTrd0GPuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOhWIbKmzWPKKYUtGJxtnMZtEZSzL4d/UW9nRH/OVA3qZweuBQxDsOiwaHTN?=
 =?us-ascii?Q?qqloqjdGfOnXt/+WengHSlP4ovhVLY+FPz+bUHLim81xjt0OgNjhqxD42Slp?=
 =?us-ascii?Q?yZJRZt9QubKfBPJ8020QHugt1M5SWUNqMb/PtHJTQ+rQPx6O3sA2DdS5uE3d?=
 =?us-ascii?Q?we4mlhY3tkvJt8Kge2W3d27vehq7SK3KoRd+Rr6/xvnRqtjk6Ca0S97ICv3X?=
 =?us-ascii?Q?Kff5UL4cAhB108iVz+yth60AQuRcQ72jvT+851uNS5A1md6WWlVmxKXO76JZ?=
 =?us-ascii?Q?Y84h2yDPPF65ytqgPGjhXR8sqAPM4ZqFSp71dUJweni20ibp6pTLxNePN7e0?=
 =?us-ascii?Q?/ui9NaU6uWZyi9ZDrGfxd0dmjdAHRqPCMX/8nFCw+2d1+VV5io0byrk4erGo?=
 =?us-ascii?Q?WNYH9WUx/PAvjV3ZaoiWLD7fCWd99cSG0ObBciiTkXaWu/YHoFYw337ScMa0?=
 =?us-ascii?Q?knpqbH/X+JNmXqhfzwbIPCnr9im0Wiz0urB5ENZJ7w9/Ua3QdSGAiiQHoQHg?=
 =?us-ascii?Q?RylD+R3hls7zPfpgeCn/X4zktplMU/AN+Iu+4gfGb4hHaUUkYppzitKbGh9O?=
 =?us-ascii?Q?+qScbW1evptDFM6YLcF3fcvlbQFVnb08JNT7jXZmvWuwH61dIJz/0R/M/BbL?=
 =?us-ascii?Q?eB6ee7859r6IPKwET9yeNszDcAmD+4XrC+nBwBr2OlXZbwb5rXhdR6QKECY3?=
 =?us-ascii?Q?kVQfH21gZQDJ4H9HAx2yDwE7DxlQSxZGCs+BYa/DsClX/PD0ivI4gfPorJRM?=
 =?us-ascii?Q?UJBGX98FQGc+c5+s69D1/uSDwK4Meq7B7Lqb0BIMuUYQVxxL0M7j2ICnpVCJ?=
 =?us-ascii?Q?srFS9JqwnG6lN+wnQAJIQkAbqBMWyxlJkB+xwLeJRcdQpm4hBvPh+IfLgOxp?=
 =?us-ascii?Q?WBpIjUQxvc/Aehu7Qhy7LJuCzi5KYWdOsMl9K/k4x+ZVm4Z1TG3QOl2cFp6p?=
 =?us-ascii?Q?KNUCTNx3mHIKMSvBgNVUY/5iKA78FhkjyDPAkIKBFVvmaN/LJgREWfjPqECj?=
 =?us-ascii?Q?eXwOg6so/X7VYMoVZb3Qrqj1u1+dfmTOGWGldDHoMy4nrh7w9v3yCceU1PZZ?=
 =?us-ascii?Q?7Un2JfJvqpGIpnRt8RZf0YNVAOPM+dAVRWMpjE2nVQhKU2PPpLi9L2Fdu5AJ?=
 =?us-ascii?Q?8E5Gz9CKiKx017gmY1D9nAZ52YoCLezV1ZrglOrazAJKyjEqf0bNY4FkPKa+?=
 =?us-ascii?Q?WTremZDAlqSDVdBTbeaC4aeZ3/+StZLRguALPKe39oXBNRCJGV084PmpDig5?=
 =?us-ascii?Q?1kbVCkomH1Nbg8PBlxvpWZlrHlaBwbg7nJ1+U2H6htDWpVN6cYOm/rn3Iru/?=
 =?us-ascii?Q?Z5uSX/5RQbR1FEWzGxcqJAGpAzmVSNxkIw/VAS1oRRGVynkpObsNMlHLJUKh?=
 =?us-ascii?Q?F1gX2K4JU/a82Nv7J4gn2LfWGmHpZcS+9QnRfQcJ/AI4GqPkhbd5EZfHgA3z?=
 =?us-ascii?Q?qlowMDU5Vw6XuL4h4WuMN2cfMMtHh94qCzJ0BMVk/QG4OfZq/zHY4uLKIPid?=
 =?us-ascii?Q?YJofR6DiH1lsyEX4JqkK6awdVItTiLQEN/qQCK+8LVmSRNQhVzOhbySkzuOM?=
 =?us-ascii?Q?wuR1xUtCPEM+Amr4x9pf1mwtLYoigvotfRP4z6wBINJkhPDLrITbi0RjAKN1?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5208ba-3bdd-401e-f482-08dd9207e8ff
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:21:23.0812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N5GH8qHbXvl061XcwVoT77kpffMw1cYMeCJyEdkMjsIUFzSN16Etd+Dty/ayeEbd5OeZxMOjkuSZWAJ54HEYJi3Kd1pSgFV4JRgbTHm5Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.26.2

