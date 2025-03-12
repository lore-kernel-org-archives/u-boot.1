Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743D2C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F438056A;
	Wed, 12 Mar 2025 16:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="dYSoX8UD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686CE80756; Wed, 12 Mar 2025 16:37:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44424800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YK+Ay8rnsXL2qOBr+xX29VirxV+RRAuehjONmyrEgyaQ/9X6/yVpDwOieE7dbUlE7oWwTh3cuX/Yt6Am37VyGU5isuKYwtcrWq9/V7PM/5pI/i9FqtSxh2aiziW9URHP1xYAY3lg0Gt0aXE7TVrhr9wrjRHrchvX3Q/FKdjTmMXxU1qSoUC5zoyQwI0z7+SRoGFzWYflyeLWbHJL/vi90sGvNTHMp7Q6qnIXgSsDpQFW51ILBT962LHRuhgVG3RLAtanYlklCKM7yVr6iUaGyP2rXxdEs4MRm026pVAa40n9jZmVTsSCxLILdgfdsKcaf+Iv05J8T7FbbtwAZZcVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tP8hPd9mrtaCY/kzoidQVPjDLV3K9FnrfKpBiMcEf8k=;
 b=pi7KtAnXTyYr2gLvYHNRzWf8M2NwnviyIvCe44/ET5lUDn8/YKos690PzDR4997Fl+vvExufwK0vd9pjDgxvcmkKtfbIh6NyIA3Xt+kdH5yM5JbD8uvQQxcY5N7UhJUnIU/pYjYCY4WK4F/zA9J3E4nmwfg4vDI+bpdPfBJPPBH3l5u7gXXpEVI8JxlfN6u3FfdDuifun2xnIT6n9cQ5QmCdhtUhVzQFJsLkDbxW+sJS212519G9m/+Nos/BXlcMZ8AmhooIhK4XVJfz05TBcTV82Awc6r9IXPgDTQjXLwWX1BQFvTaAvwm8cI8yY4uyCNjEwljIBN6M+Cl8USUw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP8hPd9mrtaCY/kzoidQVPjDLV3K9FnrfKpBiMcEf8k=;
 b=dYSoX8UDHM/W5PwYGeToxMgi0XOORLQVPvXmpR7klX4/6B9ozuYvdVzHdLZ+na1jYNG0uxC4LIvpn8GrbZJX09g51tzWKyglAfdQw/k97NSsqZ56ui3sd8tm1cQACZ/3EK4sPeZN+N/n0lyngm7RT+6LBoyKBEBfmV/pUcPvpFNeKnUZj54MU6CAe0/5rpFo3KBVWx9rk7J9QrD6+9+bGr4j7RMo8dPIEnoaTeB5HOYbXDEat50GcGTKGosvjKLEhA+5auFdvvWFZUjTI5DlJNYWyJ4qjydUss8KFrdtoh3Qop8tt6UXfypdkgWu3DEgdk03X/wgeVZg9ld/bObnvQ==
Received: from DB9PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:10:1da::19)
 by PA1PR04MB10465.eurprd04.prod.outlook.com (2603:10a6:102:44a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:37:53 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::fd) by DB9PR05CA0014.outlook.office365.com
 (2603:10a6:10:1da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.28 via Frontend Transport; Wed,
 12 Mar 2025 15:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 15:37:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.176)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Wed, 12 Mar 2025 15:37:52 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:37:49 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:37:49 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.denx.de
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
Date: Wed, 12 Mar 2025 16:36:31 +0100
Message-ID: <20250312153741.24007-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371::19) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|PA4PR04MB9685:EE_|DB5PEPF00014B90:EE_|PA1PR04MB10465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f954d44-0a49-4d99-6fad-08dd617bda6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?ALnLmEtgzBtS6xDTVB1SgX0w3bHlhUfnnN20KDVAj7S+0voKn3INMbc2biVp?=
 =?us-ascii?Q?0yA5KROwfShookR5w2nQmluC11EYeoqb0ft99OSvP5LMWJw2r8h77EKwdUr2?=
 =?us-ascii?Q?ZLBbsdliMLvNQz59L/9jIF9AbRXSRKj02wDKqjYdUg0GpgZvTh028hi+Av1c?=
 =?us-ascii?Q?IpbtQ8wCa1qEnuvrksTc+mnE5SQF43uDHlg8n3zyAp1SaAYF/YeWsa1mz5Oh?=
 =?us-ascii?Q?R8S4w0GdVdeBvh7WYVmdzYWVIvle0D9g/GkSXarE7Xk3eKUYPr2Eo9IHtGQG?=
 =?us-ascii?Q?kx2mbSsADv08u1lPsjVCZBnpNeVSNvEKQYUtvc1LZ8qdlW0wZPNNj36x4vup?=
 =?us-ascii?Q?nacGKGFvYgVdr+kL0IVN+RAUI9n2hWjt7JUQGzHoN4hqkRV67jgiqZMyrhHo?=
 =?us-ascii?Q?qeBMC1KLdva50TlhE5EW79beBwjkiHyKk+83LEGlLbyZEMsjt5J9Wl6SK8s3?=
 =?us-ascii?Q?rRS66KmTFb1AYgqFuy76AYJAsGC+j1yLSpfuS7tkHX/QkqdatYDQ6Rmuzx2b?=
 =?us-ascii?Q?XT4Jd5grAWaj6JJY2c5GCPLN2d/30SMm5x06qAM2GSqaJIsVF3wNzu4ZppaN?=
 =?us-ascii?Q?E07Tz9VT0VC1ygyfGMDr4Xq0rbG5QgyYSMOUjquw5rNswlh4I+B4cJKfEhqw?=
 =?us-ascii?Q?A/fr6OrgufdHznrTa4/1dX7WbbYgYXQtSVT+cmgLoNpKvu4m5MTFwtQij9Vs?=
 =?us-ascii?Q?npFegAXJHPenQuGN/tpfIq1BFH0SzVyobxkI11KkOdUChsrI3GPKBuj0PRXX?=
 =?us-ascii?Q?deGPfUdltZ/xalTHzlXQd5UINvHZ1rQ5Zj9HvUqnRpM9WHgRgMuqmiS4OOyb?=
 =?us-ascii?Q?lumnFlbm14nZSfo2DGwxLssQtlDmCx1rAqq+NplJcYRYUflrBS4MkUzo9P5f?=
 =?us-ascii?Q?0LjN17NOKmaw9zdd97iAiTJVy8QIbOuv/mehYyY1SGP34etAFoC6JVknInb2?=
 =?us-ascii?Q?/FahEQyhVZTKJMRcSwGGt5JpOyEAANkKFheAfu8veEbFkT+RYL0/zEzNFRmf?=
 =?us-ascii?Q?wxEzaF0cT11H9f7JVg/ZlRyCe+fQSer31XwklCfcq8SFn7a1y1HS0sgalDpM?=
 =?us-ascii?Q?ZUDuHvsOzh8zfpv3v9in/smd7zQ/jXgrw0OSbaJxgyw5UcVnKkVIVb+ZWu4X?=
 =?us-ascii?Q?H6Ji8FaGgZ9x+hN2X7VsrMtZSszyPEZVDtQIRapZA9CIk4G4SP/h6D35ANPc?=
 =?us-ascii?Q?smmHV0qYxnievhzc6GSfmF74vDV4Nx+dZXTaDrUWrpdnW7Q06c+aNPYQk6AG?=
 =?us-ascii?Q?FIqFah6/9RCzBBr/QpNA8gKBx0W7X6m23ae6RwW/yZeiSSBzBsx3WL4D51e7?=
 =?us-ascii?Q?N6RjC5nlTsJ6Pmxz9weKQZwnjS69Gv19fpBd4JeQCwwKjUhhgPQ9vlssveBa?=
 =?us-ascii?Q?oF6DpTuuhA8Yf6pmmX1EvvMkc4/u7nzqhw6UotGQHAHeaizTwHlCMILk0DFd?=
 =?us-ascii?Q?1nM2o5mBgYy4FDRB2rf0c6701KuBEHfZ?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685
X-CodeTwo-MessageID: c3183ce0-0724-4387-ab71-1d735fd176f8.20250312153752@westeu12-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.956edb5d-5d6c-4991-9875-8dc26491146e@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89dce08e-ff43-4b20-ca72-08dd617bd7eb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|35042699022|1800799024|376014|14060799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1coCQygMxPCMvUwFkeAmERGylb+tN85DH1PwBG2GduSekNfES6xGfRojwotR?=
 =?us-ascii?Q?QsUP2As9Wnz0Csl1Gla6+L/0a0eR3NXH7mkO+WLA61CKzdixeMTb/M5C1g99?=
 =?us-ascii?Q?E/hXVF9HFKfEKaKmOp6emHqJHgZtbDQJnqYzFGUWoDLweB5mduxO/BYJUiZE?=
 =?us-ascii?Q?OzUMvIQx2L1g733WdBaV+5xB161g7v6QjK5mseGe+3QcoxIPRvhWL0CGsi0B?=
 =?us-ascii?Q?xLZOomfo+aIigGNx2FAjjcnj94h+kPMxSsUtLr1UKsD4Da3dh3BMvLDUlpYk?=
 =?us-ascii?Q?EhdyU7bq3xJyFbnhxFDd9pLjltHrhSyVFGct2XFHh0T6S2agVAci1YlJCtwC?=
 =?us-ascii?Q?NS6nNhbMElx5jWFra+uq6Uc2iAUIQBzbXiRKXK+gTJHwNcBc0Es1BQ/cj5kZ?=
 =?us-ascii?Q?tDcJ8HyRo0/Z/OgZ1VVSlShIkue8GG5Aqi/qQfykOdKuXrmganHTPbDBw6e0?=
 =?us-ascii?Q?fK5eVTjQqxt4nLg6VVkLvARxMW7Q0lTEThYdTW08Qtyg1YbQglYIn7IQZ2Rw?=
 =?us-ascii?Q?ynqkf0oB77Wc9UNc3hrxlC4jyq2wx5IwntGzM/ZajRWZbbHuiSol5QGizD+k?=
 =?us-ascii?Q?6+7nFF3CPHHpILgD17cLyhsPIbhAMlCX9jresgFOfSZOgEGDsppZ0g39sw/h?=
 =?us-ascii?Q?dT+GesChU1F+GbROrMlSlP2m6ZwIkyw1juDc7hwgpKXvNwIxUxjSDdXa0Hfy?=
 =?us-ascii?Q?Pz1rJU0bVu7qgiYJ4nmAbWOsSdkguZ7QZmDxzD2LOhv27sB7P5Nq3/W00IFR?=
 =?us-ascii?Q?3s70I1XdRH5Zc2zK5mWQgtdHUB416QrXjFDxrt9PvPfKHU87T9WdpgoS2BPH?=
 =?us-ascii?Q?CgYp9uYUVMjVsRPinim+CwIqxh7dao+8c4EdQwVJvoazdnZpKMH/S+xskYaq?=
 =?us-ascii?Q?POi9uwNAfk4v1jQPpzpAHcY6l3ke9DI/UWhuU95OJB2ROdzwKT7lvjN5Ck3P?=
 =?us-ascii?Q?S2auheM5AMdD8CB0akPP1dC+7zh8qJ6KrFNM4FI/kA6UG4PaF1fEY8Yd3L5F?=
 =?us-ascii?Q?tXY/yDFjOSLsHNcXvJEMhfk94SSL0q5zjlcPqp3cLhajv6s5eyr3ZkgoNjC7?=
 =?us-ascii?Q?LvLsBpyVYs9k7h7ItTJoOpfpNaj1fr7jObtxeQOPh4w2Yce3A5oKpUlHRyCA?=
 =?us-ascii?Q?ZlaOh7/Mf3gzZACHivsW8AlsJ4fVX3/X88p3Uh+PzQRmMQgANZzdkOgaisMO?=
 =?us-ascii?Q?zA9plemUWRPpPQI6KJsXFTNoCNuPZPBUi6OMvCgpL+WDvucLKZf7QWjTYGzB?=
 =?us-ascii?Q?y7pb9L6zd8BJ9yz6gUGRhAHcY8GS+kUBijD2HOt072lEYAx1cUn7FuEP+gwn?=
 =?us-ascii?Q?z+vzkb5im9mHCNKxJp1yHuVFUixVqdwmIfQeNeXQyQi76RHRJ3l3CFwu0/Ij?=
 =?us-ascii?Q?XHcd2vjr1b2C1C11X5wrS+ngUOtHch0xfOgJmwzvBb2dVRpOu4mtALWItAUb?=
 =?us-ascii?Q?cniGaqfXvII=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(35042699022)(1800799024)(376014)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:37:52.9017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f954d44-0a49-4d99-6fad-08dd617bda6d
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10465
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

Allow config headers that include zynq-common.h to provide their own
(distro) boot strategies. This is implemented by skipping the section
when BOOT_ENV has already been defined.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

Changes in v2:
Avoid #ifdef nesting (as suggested by MS)

 include/configs/zynq-common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 37c77aa1611..7bf58d3b2f7 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -46,7 +46,10 @@
=20
 #ifdef CONFIG_XPL_BUILD
 #define BOOTENV
-#else
+#endif
+
+/* Only use this section if no BOOTENV has been configured yet */
+#ifndef BOOTENV
=20
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
@@ -167,7 +170,8 @@
 	BOOT_TARGET_DEVICES_DHCP(func)
=20
 #include <config_distro_bootcmd.h>
-#endif /* CONFIG_XPL_BUILD */
+
+#endif /* BOOTENV */
=20
 /* Default environment */
 #ifndef CFG_EXTRA_ENV_SETTINGS
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
