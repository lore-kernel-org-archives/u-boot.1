Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F91DCAC587
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 01:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 221DE833D1;
	Fri, 12 Sep 2025 03:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mqZfBmYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C344083403; Fri, 12 Sep 2025 03:37:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7454483322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 03:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPCyJRUA4oL4G6vGbLgnhcbmdWi4JoDVQXoVXjW3o6/cxhvOHefeucr1zYcjFDcqso08hxh+6sVPefmdKv2GKrJuq5t/4C2xDmDCVwv9ow/WhOgMFYZxV6BgItoAOhA+vZOJrYJ5aiQm6zYhhD0hyQyDYzOWneWAdL9nxT0Zc3X8W+fA2bTiluikzoH3DDOXibOqn5yKPhb4ABDGMwkhmgVbI8DpOQej90Vw4KIBLjAoMPt0+GXpd6R7QrLg6f6p8GdoLJ4zxWAJM/PG7lq7vs7FRc2cyfKHhP02Zd+/KyXhB42eV+92AVsKZzeP85iBjf3xBr5DjNMghShGSQJLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU6VKTGtyaQkMji3arb/6/mRun9HVLfljvq6P/vUvRo=;
 b=sGh/MGiXVSSfk3/5zRrF7q2gKI85EOQPsR3LkgW3v8y2B7lEodAKDpMj3hCzKyAKR+pKmJY4Qq42ye+Kf9KIc5rK3OSo/bl54Qop+1Wuk+/pZlGzR00L6hDlsvexxK5CjNssz/Xuvw3JN4zZLuxV4BjHr2RVeZJH3acjRUQoRSr/IwVt7VjohxybbWW94eYQM/i0zAevMl5rPCgMM6JR0mfKnhKJWOUxcCZQBRYs4UvTTCcYdgKm8cb4tJPJVAfZSScipkQ9isFIJBpZSyJfKC8a5Z3/kTXD1jkRoTNTqYAWm+k4wOTZq0YCZuLgqLJ2o+5KVyfMRqIFdPYEEVA0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU6VKTGtyaQkMji3arb/6/mRun9HVLfljvq6P/vUvRo=;
 b=mqZfBmYAZVRn4bqGmCYCwEFSJvPZW2K0h3wA3bPrqdk2R90qvjv4GY5fGMq3wX5BSf8dgCtBRlP9VzVX8xS3CE7jtFMeHq2+AG0u5freoKBtXu3isuB70VMea3mUDMvUPcsHAh6rrtu4kemMTmCeSg1f71c7LwcF4VW8NAPA+Z+p0q1hEZHuvzHmSXqHnMUZj8NDf3d+eMRBteR8wnaUqh/X7WMmqnjgTvm0d1zZtF7aLXU9q5r2k0f13dXaqa9ZwNu/peuK8xQ2xao1S/+9mQTBRg1sG6eU3fCxC/1/BQJX0vMbZnGbpPEtvoWhLsARZMonddr1TzAmfP7IQuvNpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11627.eurprd08.prod.outlook.com (2603:10a6:800:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 01:36:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 01:36:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] cmd: mtd: improvements
Date: Fri, 12 Sep 2025 04:36:43 +0300
Message-ID: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004525.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::346) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 83acc97c-2d05-4acc-e16a-08ddf19cdb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w7tU479Jg9McpL5k+Om2H6TMYP+Kf3vHWld2zhB7ygQ2j3tyUBJNH3xGLaQ+?=
 =?us-ascii?Q?CcV0A05beGGehCRxy+MHUjd1M6mUHsIfpJShZ85GvAyqcgTH1lrLcUZyue4b?=
 =?us-ascii?Q?+ee5Ra1qFt7PSOBMOj+aPoGowO2NxNqrmnCrwx6KuLlp8DKbW0ApxpLEKWtu?=
 =?us-ascii?Q?mZgCyrHQ3n64lKvXqwsy0j3NBow5JNCf19KTgcE/a06iGKQNNkwRB9uq0+lX?=
 =?us-ascii?Q?fenHL20euI8l6zXwrSbmz+NaZYi+G3jq9Dj06QDWGAjtgafA6hwKtiWXTaC+?=
 =?us-ascii?Q?9WG3SGRws2GUYf6Mjh+v4F515pjofls819XcZsjrLZ7zCVxCtrMMMt9Edzd5?=
 =?us-ascii?Q?MqrlcF/okawYrpopgpVp5piySqYu1tQ5oSjmo8aeAeh4EZVFv52IYdkMh7mH?=
 =?us-ascii?Q?50DwTGSF9K9HmCsFbpCliHI1dgJ45EQUpU7T7CuBmZV6VKuCGyuYAb0SJbPs?=
 =?us-ascii?Q?QdAKx0/xdynVmVtweFwSYfmNAJMIdIcBFUlDUuJYfcQ2LuJwusHQ4Dopyluq?=
 =?us-ascii?Q?Ak4WZI59nxLv7w8U9ZRTa4ctXR4DdE3PHh5U1wH6pElkVEXCaZOUZmZ6rfca?=
 =?us-ascii?Q?EyQMiP0RDX5ge/fqfmKfJ0EMcPbzGgjNhBttpeejO7BNVp3A9mIQmenwmCEF?=
 =?us-ascii?Q?mD1Q+5A12l6ojf+y80/1w9Z0RNL5npM5SCsrjGsdZwIo2UkEByqVYhYhGZi7?=
 =?us-ascii?Q?QvR0dHmMGjdpErfkyqluqUrf0aRPydUdbxZ/cB4sXcBd5RvArQYVWEEtaP07?=
 =?us-ascii?Q?E5R6/BFYlAGMXjtJCkHpc0/C+NGKuzHu0AFFBzTgUgr2MD/a5tJ7fUuqhHRo?=
 =?us-ascii?Q?MzDAx8juE1IJILwxmkUDilyuFHlMmLeW/NPhGWakLbe2ACvA+L52p0XDr2V/?=
 =?us-ascii?Q?bswgdG94EQCl5iFRWQqpeEjjbCj7bpEkvWoUZaBMDfZ7a+9S5usEnFMYTU3S?=
 =?us-ascii?Q?VzEQeSIDh/HzCEpSFnxlDN+iNMT5B7bZmEpceCT8JsA4fRGdW4dWoEZqjpr3?=
 =?us-ascii?Q?TDWoaO4Zh7LYHv4wk5fZiecGDXwdZDpa/WVN5U8udVsZl7p2KHrkBC0HhXxW?=
 =?us-ascii?Q?vG/9m3+hpofEHhT6W9AZJT1165sTHwBpDozUoAJoPeyRi0K34kMCe1rvZFLv?=
 =?us-ascii?Q?9FBCiQEFilflcmk19DDl1F55EfQRf4vEf8v4uuxY9IFmlcpB6OjDzLR2lTRA?=
 =?us-ascii?Q?/YA0nF5HKhw+4kDJPfqOGavV2hilx0GYrovMvHG+1mkKMx+fj1To7UtzUmxR?=
 =?us-ascii?Q?ERqofIaD5UZwW8vbBwT1guxsNWdectj2Sg6jSNds+JnL9U582oyyAJjRPudt?=
 =?us-ascii?Q?WjoVhIVtW5ktq876EBP7BT6+fofrCbXNHJxFHPmVra7gVQ3bLHesKXBonIgx?=
 =?us-ascii?Q?FWbs7RBZB+6Yu63kFQFWj3tLgdcKf0KRLPDOSN4+hRkMgW6HzQJBHVsTY+nr?=
 =?us-ascii?Q?c+RZt76HAEzN41x76Zy9i3WjHgdpkQyFmBP4N+of3kbHA7siYrbjMedjY0Kd?=
 =?us-ascii?Q?k6iFA+3m0n4f5Dg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YCqjOVIyeMxaI+ERFEScMytjaMnT6CPcR6Dmsc5sbQKynTZrl0FyhNkIMrYD?=
 =?us-ascii?Q?TgBQak4wVGkU0UmLeE5ZKBpuNDSLfWPAuhw5v6pThO7fMdbjacWIupm5dY3p?=
 =?us-ascii?Q?lTJqmNVy2Ly7X8uck5IeTJhbnmJOaJtWIM+FMaQdjYyYOTkPzoBnG8TYF5MG?=
 =?us-ascii?Q?9ZDUCU0fUSm7gwOVQCK1zK7xmUm05HHXDVU/AUn+2Jj6Ud1re2NfMeF/jB9S?=
 =?us-ascii?Q?hkNiyosHHodaP2n6eyja0ElWUALeGDX4wEtJrqCI97REGtbMiiEXEIhFAyYQ?=
 =?us-ascii?Q?2Ja6A6/ljDx2E7z4hyhY5Ux2YN60XbkV5bKGbA2vChIv9m5Dm4z0Jd6cY1zv?=
 =?us-ascii?Q?IUKzp81+QVcTJXQNUDJa/cgE3z24oXrNo3ydmXUup4EakQZ3SSnMsv5oDHB9?=
 =?us-ascii?Q?Lfbv0bKYnCxI3W0tLFWw+uYUfbPuSKtBWemy0a8FC/GY81MIa5t5calKiFos?=
 =?us-ascii?Q?xNIc6oeRu3DnxNzUKxihGuChBsp0Ot8rSfQGPpzfSh3XPlQUsRHnoVBS3lB6?=
 =?us-ascii?Q?aHFF9MalsYCPLSVCI5sTsBh+5xlNNSK2J1AP9otta4J2G95obNtYKc49OR9D?=
 =?us-ascii?Q?/p56OZeDEt2B3FQLLwho84oznu5JNHgmslrlnSOcQHEW3NtXFJuhGXicuG3G?=
 =?us-ascii?Q?GCY6aiNGUuR2/vuLUSNtqZnRrNdPhAxNCeXPT1L/rsvUh82UWIvS1AyHW1KG?=
 =?us-ascii?Q?3v3n+Knv3IP94/O1UVqXLZ3fH+0E7RAnxDeyZbV7BMGlZlHR7W6IhLOlRAyP?=
 =?us-ascii?Q?1NT4vBIHW1ttSkJ1liz+ycpUhBBFfrd621Th3zS4GBudNjiFpOtbcHqZ/fBP?=
 =?us-ascii?Q?IWXlMeP4x3CBHZEyZLXxPepc7uFePbcV3EIQ4zQcJ+e+kMlCS+uA3VuTD7DT?=
 =?us-ascii?Q?Sd/gHXkjQbp/qjXptpu/F7RqgLDZGYlNEyNIcYESTeqPRmYSblnvxDwy2DKY?=
 =?us-ascii?Q?xdCNr1trX5/qykCtsx+T+TMFMVefkXD+e6KK3wSPcxHctXGdq15ZvZ1K8Tob?=
 =?us-ascii?Q?XGqQEU00fdkN9fJOfvvRqCX7cyf8HgRSimz60Dxz8qLDqQT8yvXitY8eCNBi?=
 =?us-ascii?Q?FZmsosdTGNKX/3CRAh3jBs8/544LLjMYLzl17685LJ2Py1WLGtrZHCPlLp+g?=
 =?us-ascii?Q?PS45lQPJOkejEza832xGdOIlkrHKeLs8DEaGfLIUeyXc/ERz/B22hc5U87Pi?=
 =?us-ascii?Q?lHScDmTrk/je6lGGinkK5U9aGzkigKIDmktTvqsmTLOG8YO5baa82CrfuxNl?=
 =?us-ascii?Q?ARW6N8WYB74KKCer9BETgXowEXrjfuYXv4GLIhBfwuQHxG5LX2pb/yUllnzY?=
 =?us-ascii?Q?/WWnZqkX21N4n5uX3jwhMGmIMQJg6QIPvICucBitgIjjNCT7wo6A2YgyI4gE?=
 =?us-ascii?Q?4mHuPIPmSUHxn/xCifsKSzQ070UX5YOqRutVXD3MtYLKV8ziB5JnkSCufYna?=
 =?us-ascii?Q?F9OhvgHEQVTvkmTeZeHo1G4AjxAZIQi8eacxCvAhtHUrrmQ/SX+4dPo3TFev?=
 =?us-ascii?Q?vVRytr7lA8m3Xru5K2gmwa4WPN8Ntz9fmn5stOkQ1LhmOfh8nmw92DVtRsTJ?=
 =?us-ascii?Q?hFnRghLjGmJ+i+iwf7aqjuXIdtr/Q2N7Ezhq0B6Bs7zsduMbK2HC+0Enw94C?=
 =?us-ascii?Q?HimZ42IEUZJXju9baZl7lJI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 83acc97c-2d05-4acc-e16a-08ddf19cdb0b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:36:56.0532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVzUI0IElJwKEJkixHdBH+fim28ay9fkkO9mfSVk+YfWacRO1F6duPHTSVLLP75L+EYCYOdfqrlx3lWU7QhcGN201pQU+twpbI+683GzK+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11627
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series introduce following features:
 * 'mtd markbad' command (clone of 'nand markbad')
 * 'mtd nand_write_test' command (clone of 'nand torture')

Also a new command 'mtd nand_read_test' introduced. It produce readonly
test of flash. It's mostly usefull to:
 * check general flash state,
 * check the correctness of returned number of corrected bits.

Changes v2:
 * added detection of the blocks above ECC bitflip threshold
 * minor cleanups of 'nand_read_test'
 * comments of Michael Trimarchi was addressed

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 457 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)

-- 
2.51.0

