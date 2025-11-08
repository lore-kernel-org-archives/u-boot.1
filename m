Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997D0CCF9E3
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 03:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CF383E23;
	Sat,  8 Nov 2025 04:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HQ9u35Ch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A924283E48; Sat,  8 Nov 2025 02:01:20 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A98383E23
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 02:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQ1bY46ZSS6Ptlifssk3Ht8EhddnnV3o7qF/6+6cCXfjm3F7TO/IgP3FJv4ChnCAxfjF9XktUsQN7O5aL+x2mmptrjgmpMUGugmUSn6jawdFKUcd6/TLGeELlExUmeqC/j1zxUTAynyDQ566af7oJfud/JR0+JQRdNLLiAPuV6mBF9qWZ+nh48JTz5oCYyDtcgHp2q5u8E25zwp5cO4QbkfQRVKaF+JKQNOijEslbePU7IB/X63KDplwjBOVWQC7gIJmJQFENksMXYqJS3zwCfEtc3mVHjPc/D5Qxn6poMwzbW31mu907IaR6sjtI8GgwueUdoAJ9OjsYmeCesXO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/VRK9eV4SG2cZHv9JmXS9cTAfx0ZrWb1CzASAjTQ1A=;
 b=pokNvlxC58hYkNYzuGkGuH+i52uZSss9dpcSmRHQ7mk90NAgv8QrNvq3MrCJjtS+FXZPmkF5RbWuTK99Yh7QG/ZvLKJ1EtPm/i6aJLBl9tApgUYZTlGVIzD6Y7fCTE3Zu4M0k21W7QCi5Nd5QZdhpsphN1VQfJkIbcnQ7jBgE9n2RE2UE78HGSMoFcubn7tWZN0MKmTtF6L9uJ+ZD5j/2Czys8QtFhzQNQdbXOSYIPWGReuZVjg9adI3ArvczaxeCMvTOuTV8d+QTa/BPBB7wz+h/H8TR035GO9r3bYe3K0LVXCH8zzl7V34q0PTAN40EUriYIea7LHc6NR9Gv/wgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/VRK9eV4SG2cZHv9JmXS9cTAfx0ZrWb1CzASAjTQ1A=;
 b=HQ9u35Ch2vtkf0sY/pXbv7fVJS0PAM01dM2CCtXiiliQ9te21BVBdR5y6+XzBoo9XCtdz2heDPdJXzA8VEPWxlgZ0MbqjipJAQDQpxvi3nJfOkoP2olMA3ZOcOdEkzex213g3GguaH5CiW1MqWi0VZD0pORfgnjzNf/ys6NTY6ULHUUCh0FJAAZ9L3XirwD1SgEeEkKzfhZ+0/EcT87CdlceyMuwqtPCGYdze7hwBzUQIQs0AzG8x50pvTwL+sKyUA8oZz8mY1Djnbn7RE3+1jU9smR1dG4IS0uX4+eYztw0A3PxeSspk4tYOATDbj1IM9jx3GKhH6wjPyCvf6lTeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 01:01:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 01:01:07 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 08 Nov 2025 08:59:57 +0800
Subject: [PATCH] board: nxp: Rename board directory from board/freescale to
 board/nxp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251108-nxp-v1-1-6169a1692ff4@nxp.com>
X-B4-Tracking: v=1; b=H4sIAAyWDmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwML3byKAl1L8yQLS7MkQwMjA0sloMqCotS0zAqwKdGxtbUA0F+Wa1U
 AAAA=
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Huan Wang <alison.wang@nxp.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Mario Six <mario.six@gdsys.cc>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 Adam Ford <aford173@gmail.com>, Patrick Bruenn <p.bruenn@beckhoff.com>, 
 Troy Kisky <troy.kisky@boundarydevices.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Lukasz Majewski <lukma@denx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, 
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Jesse Taube <Mr.Bossman075@gmail.com>, 
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>, 
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Wasim Khan <wasim.khan@nxp.com>, 
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>, 
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Sinan Akman <sinan@writeme.com>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Jason Liu <jason.hui.liu@nxp.com>, Eric Nelson <eric@nelint.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>, 
 Shengzhou Liu <Shengzhou.Liu@nxp.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>, 
 Richard Hu <richard.hu@technexion.com>, Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Vitor Soares <vitor.soares@toradex.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, E Shattow <e@freeshell.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?utf-8?q?Benjamin_Sz=C5=91ke?= <egyszeregy@freemail.hu>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Benjamin Lemouzy <blemouzy@centralp.fr>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d33a89-499f-43a9-5855-08de1e624bb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEJ6VUQxQ0tpS1NJQmswbFQ0am5idnlJcG5vWklJYTFBZVJSMlR5MklLSk45?=
 =?utf-8?B?WEVwOGlmL0ZQN1BZcXU4SDljVlJXOWtUZlp3VTZkc1VwaUJhdEJPVm8weU9s?=
 =?utf-8?B?a2lWZFJocmhVTSs1b3NGcDl1dWIyQ0dHNE9sSDRNVXFwd1MvUDFEdDR2d25T?=
 =?utf-8?B?Q216WGdQejBkL1pGUjZmWk5jRnRmQlU1LzRJYW5vUjVvSWtCam1tS3J2MDdU?=
 =?utf-8?B?T0VFcFZyMXdoTTYybklVSkZlQWg1cjZpT2FCU09ZU2V6R2l6ZVNlSGs2Z3N1?=
 =?utf-8?B?NzhEL3RwMHdLWE1uZnRLd2s4cXBnL3NUN2I5eUFsT3RnNGdtRHk4NzQ0SExo?=
 =?utf-8?B?NWsxWFRqUnhhRmVTeG1JdnlPemtaUk5LREFWcFd6U3Axc1I5dys1V3YxbDVQ?=
 =?utf-8?B?dWwxbFFTOUg2a2lhOUUyV01FalpOZFNDNHordUR4SEg3TUhPUFEwNUE1cmZ3?=
 =?utf-8?B?NllzZFA2NEw1SkZTNUVseHRjbUpwelh6R2NCZ2YrbUhoTXF5aHhrTkd5ZUFG?=
 =?utf-8?B?Z2NYOUY4bU1iVUpjai9NUURucjZhMnVwZmtGQU1RVVNQRVV6VFhhY1hDbDBR?=
 =?utf-8?B?OXovNHhBWWNtZmhuV3N5T2dzZUZhWSt0WDducWMzUDRrdGpiQk9oTTlNbHR2?=
 =?utf-8?B?cUtuVnAxRGxESFdtL0NqVjIzL2FCa0lQeXlCWkhKQitYQ2VxVnFwdUFwanRP?=
 =?utf-8?B?SmRteWtPTW82TTZRZ1lVbVlPWEY4VjdHTWFLWUlJN21OdlB1WVFveUlDZmRQ?=
 =?utf-8?B?SmtZZUZxYjM1SDVhdVNqbWxGSTB1a3lXczFBS2c3L3dDdTRMZFdBRzB3NWN4?=
 =?utf-8?B?SGpob0hWRTJkQjk5YkF3aXhiSDNObWxlS09TRUFlMlcvbTlyd0dpRmgxTjZr?=
 =?utf-8?B?VnpZSks2RW5GV0NHSG42S2Q4RWtZUkdCbDA0dGc4eHFINVNqcE5WU2VaS0RU?=
 =?utf-8?B?RDRjUGl0Yk5rMVk2SDh1UUQ1VXo2anhaWk5DblFlcGN5dWk5Wkl5cnZMK0tR?=
 =?utf-8?B?VzBONGZFUm8rSWtlQUVXMkRXOW5vWVc2azR2bFVRZHhxdGdwNzhmaEdDWEgw?=
 =?utf-8?B?eUt0R215STVpem9jZFBxL25VREI2RW5ZRStoenRKOGFvQjJ1SkxzQUZXNzhZ?=
 =?utf-8?B?VFRlNm1IMTV2WjA1eFNFUDhOYkNnNnJmakhscXFNSWhwa1lXYXlTMXJ6YTRq?=
 =?utf-8?B?ZTVZbkJXT3grU29UNTZadDM3L1I0REFkaFRMY01ZZ0ZNakxsK3h2Ym1TaEZZ?=
 =?utf-8?B?WVBYRHdBYksyODQvK0RwVk9FdmdvM3VrNFlubWxvTzROaWo1UUV4OUlpa0Ew?=
 =?utf-8?B?TTZHbVJXYWZaakpGY3lzd2kvQ0JESVhNZ2ZGeitXaUVrRjYvT2t0MUxxdWlY?=
 =?utf-8?B?K3oyODdGRHRvUC9GSEVYV2o0Yzlkc3RZS2E1TVlRZzhuNzNka2tqbHB3c3BY?=
 =?utf-8?B?cmUwUThBaFVTbll1c3kweVRtcDY0aFRxNURTOXFkYlJXOWJiMXBheG11alFt?=
 =?utf-8?B?cFNyL3pieVVUUXhxK3FtQmVsUGhoOGMwZnkxWUl5dTdYSWN1M1p3TDFEUGhB?=
 =?utf-8?B?WTJ6eVJ3QytzSlJkT2tBNzdIeFU1dVhjcTlIZlp0VUFXL0pYR0ZKY0g4czI1?=
 =?utf-8?B?S0dkVGl2dlVTZCtzeTE0WUNVMDZzODFER3Zmczh2VXNYanJ6MHdLa1VicmxT?=
 =?utf-8?B?aVFVRVA1SWpyV1JteDc3NFYyUWNLaVpLOERqcDZpOWdLMEZWVUY5bE12eENz?=
 =?utf-8?B?OVZFU2REc05tYzArRHRQM2UxcEN1cUdZMFdaK3hIY21EOFJRZUZwNHR1Vk1E?=
 =?utf-8?B?bVJTRWF6V3l1bmlFTW9MZ21aRDc5UndYd3lKWWQxdFZIc05NZ2psRDJHbGlH?=
 =?utf-8?B?cmdtT2hzVGFvNmljUWxBOVBkS0pob0d3dmFnQWp5UVNRN09tUE90Z0oxbVdy?=
 =?utf-8?B?S1NWek1nY0hIMFE2eW1lb0dKc3IySTMwNEJWRzZpSURmeUNsNElPQmNBL0V2?=
 =?utf-8?B?dzN5NVh4RGo4bHhOWDhhNXJoQ2htV3hqNVYwTmxrTzNNQmwwaVZsYWNmZUh5?=
 =?utf-8?Q?EYK4iD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC83a2Z1bmRBYkpnZ2I4QkJRMFpZMTBtdVVMS3hoL2ZYTnBPaWUwYmExaHI2?=
 =?utf-8?B?YmF6L0NoK0M0SUhYd2FJbU5lMk96R1QrZDJTR3l2c2V3cG9hbER3aGZaeHE4?=
 =?utf-8?B?OHY4U2p0eUNZWEZ0bk83YlJmWGliRmN2bGpRNFhRRHBKbGpnQmpxMmdUdmlt?=
 =?utf-8?B?N2NHNEwzbDZuOHRTbUxHSGh1WkFEamRpbW0ycjFKMXhxNm5Kem0vL2grSFVp?=
 =?utf-8?B?SnI0TXNNREtleWNpL1Zub2ZJSG85WWdOaXc4Nkx4UE8xZnVyeHdGYkhxTlRN?=
 =?utf-8?B?MVJ2NlBBVDMyWWR2MGtqU2tYUmxkbW1XYndNRlB2aG42cGtBOUFKcnJ3SmVG?=
 =?utf-8?B?QzJFSlc3UzRQVzdNVExRRlZHYlBUK2FxaGhsOUZJdzZiV3RkcVVSUzNxNkFU?=
 =?utf-8?B?bEVhV0lHVXhibXVqK1lzeUxyNVYzOGhSR29ReWZmWnViSzRKS2I1QkdHc1JO?=
 =?utf-8?B?eUZIUGIxVW1JT1k5NkErUzV1eVRUMnpkSm51a0c5MGlzUFFDVFBpY0FSZEV4?=
 =?utf-8?B?ZDRqM3pZZjFDbXpKaUVHd01jQ3JQbksrVTVTZmFZMnBuZW9MdzRTTU5YVmov?=
 =?utf-8?B?eEV5U2JodU5zMnMrcndFQU5naWwzTHZWZ2labnAyZmxHVHhGeDVIdERSWlBO?=
 =?utf-8?B?YThYVHlpRXp1dy9ZS1N6NWx2N2FYeU44eXFZM0V1bDBrb3RMVUtXQkw5SG1U?=
 =?utf-8?B?a3JMMUE1MEppd1kxblcxRWxRMEtwSHNHL25MTlZPaVIzQWcyL2Vpd0V2NnFx?=
 =?utf-8?B?OU53Wm9CbmlKV0FWOTFxVGpydWw2aVFZSm8vUHRZWXlRelJycXhROWJLT2JL?=
 =?utf-8?B?T3ZiYVJiek41blpYcTFDdkQ2S3VIVVBHTVIyMGw2K2Z5NUFGaHhTTnZINzlj?=
 =?utf-8?B?OEQwNXI1U1ovdVUvVEJQVkVNUzBhekFGbVdVTU9Pd3p1NTYrM3BRbnY3VXFn?=
 =?utf-8?B?Ukxrald2L0Z6Y3F3MTBCTEhYNjF6MHhaSTFnck5pRmVYZnZRc2FZaTBSTFBh?=
 =?utf-8?B?MEh6WUVjUDh0V1Z0R0dWemV2Q0RIL2krTU91WjVROC84OGRIallGZGtMVG8z?=
 =?utf-8?B?TUxZdDJqejRhc2JLWXVCem5QKzU4eExqWjFxeGdjOXdxSHluZmtRZVljakFQ?=
 =?utf-8?B?U0tpR3VoS1BJL0hnczJodkZWcVRxQVlNWFV5MGRpYWRENTVwSzVSaE9zSzNJ?=
 =?utf-8?B?RW1FK2l6WWlqOEZkb2k3bjZUMFIwb2lNaFh3ZlFEOVJDcUNVeUNMaHU5R2pK?=
 =?utf-8?B?aHdmVzNzeXVsTGFudXkvQmZOaW1xS1MySGdVa0pENHdsUlRqTGovYnY4MUFQ?=
 =?utf-8?B?WXNrQnVkRGRBd3ZPM09sYXJQUDB1UkJyWWhXU3FpSHdZbnE4NmJPamtZdnZz?=
 =?utf-8?B?a1cySkx0V1BhL1hDQ2Y5YXFDSStremFnN0FkZWlmRTBJcUdGcldvazlrR2Y0?=
 =?utf-8?B?aUpVNnphaXEyeWNZQWdWVXkxeStGb3JldE9Ecm41N0hFbHgvY3QvZmN4ajhM?=
 =?utf-8?B?bzhxZnR6Mm5pL2lkeVEvVE5tQnRtTkUwVi9uNU9kZVkzUXJpeXpsNkxJUU1n?=
 =?utf-8?B?Q0xyTGduK3lBMS9mNDAyZ1dTanBwcTAyd0tCWUZvb0xZbEtIaXRTdVl5K1pK?=
 =?utf-8?B?VG9oQlI2V0dBZnNWYnE2TExsZ0FDMHM3V0FWNk16R0J1ckYxc2RXOGhrTVNy?=
 =?utf-8?B?K3lBL1JISlNOYVBQa3dxNnYwY3dnRWFFQXZJVWtZekdWSWdsOFNPaGd4RllC?=
 =?utf-8?B?WnpYNHpNdUZZbjBQQWp2NjNsZnJGTEluLzZsdk9XZklKdU16dzh0TEVsdjNv?=
 =?utf-8?B?c3p4bzM2dXQ3VEsvdmRTT0swc05YanBVamdhU2psdjVrYktqblJ3TjErUjI5?=
 =?utf-8?B?OVRuaWpIcHN4K204eTNab3lRejZlVFBpTUZZcHFlMm1ybnNDNC9wWVpNcXhv?=
 =?utf-8?B?UWduQ3UyNmlsaENFOG1teWpBc2gwRGo0WU1NeGwyN2ZkWnlqMlFhZ1NjbE8w?=
 =?utf-8?B?dCs1Mk8wSys1T3o0TzFHdFVCVzZpUGFKSmRTcnorMXQ1WUtSeVRuV21WWVhw?=
 =?utf-8?B?K3ZnNEpvbGJYemxYTS93WFZubXF0T25sTlRnd0l6NHcxY2lYVVREZ0oxL3VL?=
 =?utf-8?Q?CpNRCyZCDQlI4lU22ot5Y33um?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d33a89-499f-43a9-5855-08de1e624bb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 01:01:06.7865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wph82p9vXh3NXAXhTmEWjssTLPycu9YQUbBfXgT5LP9m9h3V8AaqbgUoQ1UvK4QzzK6KpdsANsEp7NUQdXXefg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Mailman-Approved-At: Sat, 08 Nov 2025 04:08:18 +0100
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

From: Alice Guo <alice.guo@nxp.com>

This patch renames the board directory from board/freescale to
board/nxp because NXP now provides Board Support Packages (BSPs) and
tools for the former Freescale i.MX and other i.MX products.

All relevant references have been updated accordingly. This change does
not affect functionality.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
CI: https://github.com/u-boot/u-boot/pull/830/checks
---
 .azure-pipelines.yml                               |  4 +--
 MAINTAINERS                                        |  4 +--
 arch/arm/Kconfig                                   | 34 +++++++++++-----------
 arch/arm/cpu/armv7/vf610/Kconfig                   |  2 +-
 arch/arm/mach-imx/imx8/Kconfig                     |  4 +--
 arch/arm/mach-imx/imx8m/Kconfig                    |  8 ++---
 arch/arm/mach-imx/imx8ulp/Kconfig                  |  2 +-
 arch/arm/mach-imx/imx9/Kconfig                     | 12 ++++----
 arch/arm/mach-imx/imxrt/Kconfig                    |  6 ++--
 arch/arm/mach-imx/mx5/Kconfig                      |  4 +--
 arch/arm/mach-imx/mx6/Kconfig                      | 18 ++++++------
 arch/arm/mach-imx/mx7/Kconfig                      |  2 +-
 arch/arm/mach-imx/mx7ulp/Kconfig                   |  2 +-
 arch/arm/mach-imx/mxs/Kconfig                      |  4 +--
 arch/m68k/Kconfig                                  | 20 ++++++-------
 arch/powerpc/cpu/mpc83xx/Kconfig                   |  2 +-
 arch/powerpc/cpu/mpc85xx/Kconfig                   | 18 ++++++------
 board/CZ.NIC/turris_1x/MAINTAINERS                 |  4 +--
 board/CZ.NIC/turris_1x/Makefile                    |  4 +--
 board/CZ.NIC/turris_1x/turris_1x.c                 |  2 +-
 board/beacon/imx8mm/Makefile                       |  2 +-
 board/beacon/imx8mn/Makefile                       |  2 +-
 board/beacon/imx8mp/Kconfig                        |  2 +-
 board/beacon/imx8mp/Makefile                       |  2 +-
 board/beckhoff/mx53cx9020/imximage.cfg             |  2 +-
 board/beckhoff/mx53cx9020/mx53cx9020.c             |  2 +-
 board/beckhoff/mx53cx9020/mx53cx9020_video.c       |  2 +-
 board/boundary/nitrogen6x/README                   |  2 +-
 board/ea/mx7ulp_com/imximage.cfg                   |  2 +-
 board/ge/mx53ppd/Makefile                          |  2 +-
 board/ge/mx53ppd/imximage.cfg                      |  2 +-
 board/ge/mx53ppd/mx53ppd.c                         |  2 +-
 board/ge/mx53ppd/mx53ppd_video.c                   |  2 +-
 board/k+p/kp_imx53/Kconfig                         |  2 +-
 board/keymile/pg-wcom-ls102xa/Makefile             |  6 ++--
 board/{freescale => nxp}/common/Makefile           |  0
 board/{freescale => nxp}/common/arm_sleep.c        |  0
 board/{freescale => nxp}/common/cadmus.c           |  0
 board/{freescale => nxp}/common/cadmus.h           |  0
 board/{freescale => nxp}/common/cds_pci_ft.c       |  0
 board/{freescale => nxp}/common/cds_via.c          |  0
 .../{freescale => nxp}/common/cmd_esbc_validate.c  |  0
 board/{freescale => nxp}/common/eeprom.h           |  0
 board/{freescale => nxp}/common/emc2305.c          |  0
 board/{freescale => nxp}/common/emc2305.h          |  0
 board/{freescale => nxp}/common/fman.c             |  0
 board/{freescale => nxp}/common/fman.h             |  0
 .../{freescale => nxp}/common/fsl_chain_of_trust.c |  0
 board/{freescale => nxp}/common/fsl_validate.c     |  0
 board/{freescale => nxp}/common/i2c_common.c       |  0
 board/{freescale => nxp}/common/i2c_common.h       |  0
 board/{freescale => nxp}/common/i2c_mux.c          |  0
 board/{freescale => nxp}/common/i2c_mux.h          |  0
 board/{freescale => nxp}/common/ics307_clk.c       |  0
 board/{freescale => nxp}/common/ics307_clk.h       |  0
 .../{freescale => nxp}/common/ls102xa_stream_id.c  |  0
 board/{freescale => nxp}/common/mc34vr500.c        |  0
 board/{freescale => nxp}/common/mmc.c              |  0
 board/{freescale => nxp}/common/mpc85xx_sleep.c    |  0
 board/{freescale => nxp}/common/ngpixis.c          |  0
 board/{freescale => nxp}/common/ngpixis.h          |  0
 board/{freescale => nxp}/common/ns_access.c        |  0
 board/{freescale => nxp}/common/p_corenet/Makefile |  0
 board/{freescale => nxp}/common/p_corenet/law.c    |  0
 board/{freescale => nxp}/common/p_corenet/tlb.c    |  0
 board/{freescale => nxp}/common/pfuze.c            |  0
 board/{freescale => nxp}/common/pfuze.h            |  0
 board/{freescale => nxp}/common/qixis.c            |  0
 board/{freescale => nxp}/common/qixis.h            |  0
 board/{freescale => nxp}/common/sdhc_boot.c        |  0
 board/{freescale => nxp}/common/sgmii_riser.h      |  0
 board/{freescale => nxp}/common/sleep.h            |  0
 board/{freescale => nxp}/common/spl.h              |  0
 board/{freescale => nxp}/common/sys_eeprom.c       |  0
 board/{freescale => nxp}/common/via.h              |  0
 board/{freescale => nxp}/common/vid.c              |  0
 board/{freescale => nxp}/common/vid.h              |  0
 board/{freescale => nxp}/common/vsc3316_3308.h     |  0
 board/{freescale => nxp}/imx8mm_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mm_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mm_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.c   |  0
 board/{freescale => nxp}/imx8mm_evk/imx8mm_evk.env |  0
 .../imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg        |  0
 .../imx8mm_evk/imximage-8mm-lpddr4.cfg             |  0
 .../{freescale => nxp}/imx8mm_evk/lpddr4_timing.c  |  0
 board/{freescale => nxp}/imx8mm_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mn_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mn_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mn_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mn_evk/ddr4_timing.c  |  0
 .../{freescale => nxp}/imx8mn_evk/ddr4_timing_ld.c |  0
 board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.c   |  0
 board/{freescale => nxp}/imx8mn_evk/imx8mn_evk.env |  0
 .../imx8mn_evk/imximage-8mn-ddr4.cfg               |  0
 .../{freescale => nxp}/imx8mn_evk/lpddr4_timing.c  |  0
 .../imx8mn_evk/lpddr4_timing_ld.c                  |  0
 board/{freescale => nxp}/imx8mn_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mp_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8mp_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mp_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.c   |  0
 board/{freescale => nxp}/imx8mp_evk/imx8mp_evk.env |  0
 .../imx8mp_evk/imximage-8mp-lpddr4.cfg             |  0
 .../{freescale => nxp}/imx8mp_evk/lpddr4_timing.c  |  0
 board/{freescale => nxp}/imx8mp_evk/spl.c          |  0
 board/{freescale => nxp}/imx8mq_evk/Kconfig        |  2 +-
 board/{freescale => nxp}/imx8mq_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8mq_evk/Makefile       |  0
 board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.c   |  0
 board/{freescale => nxp}/imx8mq_evk/imx8mq_evk.env |  0
 .../{freescale => nxp}/imx8mq_evk/lpddr4_timing.c  |  0
 .../imx8mq_evk/lpddr4_timing_b0.c                  |  0
 board/{freescale => nxp}/imx8mq_evk/spl.c          |  0
 board/{freescale => nxp}/imx8qm_mek/Kconfig        |  4 +--
 board/{freescale => nxp}/imx8qm_mek/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx8qm_mek/Makefile       |  0
 board/{freescale => nxp}/imx8qm_mek/README         |  0
 board/{freescale => nxp}/imx8qm_mek/imx8qm_mek.c   |  0
 board/{freescale => nxp}/imx8qm_mek/imximage.cfg   |  0
 board/{freescale => nxp}/imx8qm_mek/spl.c          |  0
 .../imx8qm_mek/uboot-container.cfg                 |  0
 board/{freescale => nxp}/imx8qxp_mek/Kconfig       |  4 +--
 board/{freescale => nxp}/imx8qxp_mek/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/imx8qxp_mek/Makefile      |  0
 board/{freescale => nxp}/imx8qxp_mek/imx8qxp_mek.c |  0
 board/{freescale => nxp}/imx8qxp_mek/imximage.cfg  |  0
 board/{freescale => nxp}/imx8qxp_mek/spl.c         |  0
 .../imx8qxp_mek/uboot-container.cfg                |  0
 board/{freescale => nxp}/imx8ulp_evk/Kconfig       |  2 +-
 board/{freescale => nxp}/imx8ulp_evk/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/imx8ulp_evk/Makefile      |  0
 board/{freescale => nxp}/imx8ulp_evk/imx8ulp_evk.c |  0
 .../{freescale => nxp}/imx8ulp_evk/lpddr4_timing.c |  0
 .../imx8ulp_evk/lpddr4_timing_266.c                |  0
 board/{freescale => nxp}/imx8ulp_evk/spl.c         |  0
 board/{freescale => nxp}/imx91_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx91_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx91_evk/Makefile        |  0
 board/{freescale => nxp}/imx91_evk/imx91_evk.c     |  0
 board/{freescale => nxp}/imx91_evk/imx91_evk.env   |  0
 .../imx91_evk/lpddr4_timing_1600mts.c              |  0
 .../imx91_evk/lpddr4_timing_1600mts_ecc.c          |  0
 .../imx91_evk/lpddr4_timing_2400mts.c              |  0
 .../imx91_evk/lpddr4_timing_2400mts_ecc.c          |  0
 board/{freescale => nxp}/imx91_evk/spl.c           |  0
 board/{freescale => nxp}/imx93_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx93_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx93_evk/Makefile        |  0
 board/{freescale => nxp}/imx93_evk/imx93_evk.c     |  0
 board/{freescale => nxp}/imx93_evk/imx93_evk.env   |  0
 .../{freescale => nxp}/imx93_evk/lpddr4x_timing.c  |  0
 .../imx93_evk/lpddr4x_timing_1866mts.c             |  0
 board/{freescale => nxp}/imx93_evk/spl.c           |  0
 board/{freescale => nxp}/imx93_frdm/Kconfig        |  2 +-
 board/{freescale => nxp}/imx93_frdm/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/imx93_frdm/Makefile       |  0
 board/{freescale => nxp}/imx93_frdm/imx93_frdm.c   |  0
 board/{freescale => nxp}/imx93_frdm/imx93_frdm.env |  0
 .../{freescale => nxp}/imx93_frdm/lpddr4_timing.h  |  0
 .../imx93_frdm/lpddr4x_1gb_timing.c                |  0
 .../imx93_frdm/lpddr4x_2gb_timing.c                |  0
 board/{freescale => nxp}/imx93_frdm/spl.c          |  0
 board/{freescale => nxp}/imx93_qsb/Kconfig         |  2 +-
 board/{freescale => nxp}/imx93_qsb/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx93_qsb/Makefile        |  0
 board/{freescale => nxp}/imx93_qsb/imx93_qsb.c     |  0
 board/{freescale => nxp}/imx93_qsb/imx93_qsb.env   |  0
 board/{freescale => nxp}/imx93_qsb/lpddr4_timing.c |  0
 .../imx93_qsb/lpddr4_timing_ecc.c                  |  0
 board/{freescale => nxp}/imx93_qsb/spl.c           |  0
 board/{freescale => nxp}/imx94_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx94_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx94_evk/Makefile        |  0
 board/{freescale => nxp}/imx94_evk/imx94_evk.c     |  0
 board/{freescale => nxp}/imx94_evk/imx94_evk.env   |  0
 board/{freescale => nxp}/imx94_evk/spl.c           |  0
 board/{freescale => nxp}/imx95_evk/Kconfig         |  2 +-
 board/{freescale => nxp}/imx95_evk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/imx95_evk/Makefile        |  0
 board/{freescale => nxp}/imx95_evk/imx95_evk.c     |  0
 board/{freescale => nxp}/imx95_evk/spl.c           |  0
 board/{freescale => nxp}/imxrt1020-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1020-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1020-evk/Makefile    |  0
 .../{freescale => nxp}/imxrt1020-evk/imximage.cfg  |  0
 .../imxrt1020-evk/imxrt1020-evk.c                  |  0
 board/{freescale => nxp}/imxrt1050-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1050-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1050-evk/Makefile    |  0
 .../imxrt1050-evk/imximage-nor.cfg                 |  0
 .../{freescale => nxp}/imxrt1050-evk/imximage.cfg  |  0
 .../imxrt1050-evk/imxrt1050-evk-nor.env            |  0
 .../imxrt1050-evk/imxrt1050-evk.c                  |  0
 .../imxrt1050-evk/imxrt1050-evk.env                |  0
 board/{freescale => nxp}/imxrt1170-evk/Kconfig     |  4 +--
 board/{freescale => nxp}/imxrt1170-evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/imxrt1170-evk/Makefile    |  0
 .../{freescale => nxp}/imxrt1170-evk/imximage.cfg  |  0
 .../imxrt1170-evk/imxrt1170-evk.c                  |  0
 board/{freescale => nxp}/ls1012afrdm/Kconfig       |  4 +--
 board/{freescale => nxp}/ls1012afrdm/MAINTAINERS   |  4 +--
 board/{freescale => nxp}/ls1012afrdm/Makefile      |  0
 board/{freescale => nxp}/ls1012afrdm/README        |  0
 board/{freescale => nxp}/ls1012afrdm/eth.c         |  0
 board/{freescale => nxp}/ls1012afrdm/ls1012afrdm.c |  0
 board/{freescale => nxp}/ls1012aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1012aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1012aqds/Makefile       |  0
 board/{freescale => nxp}/ls1012aqds/README         |  0
 board/{freescale => nxp}/ls1012aqds/eth.c          |  0
 board/{freescale => nxp}/ls1012aqds/ls1012aqds.c   |  0
 .../{freescale => nxp}/ls1012aqds/ls1012aqds_pfe.h |  0
 .../ls1012aqds/ls1012aqds_qixis.h                  |  0
 board/{freescale => nxp}/ls1012ardb/Kconfig        |  4 +--
 board/{freescale => nxp}/ls1012ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls1012ardb/Makefile       |  0
 board/{freescale => nxp}/ls1012ardb/README         |  0
 board/{freescale => nxp}/ls1012ardb/eth.c          |  0
 board/{freescale => nxp}/ls1012ardb/ls1012ardb.c   |  0
 board/{freescale => nxp}/ls1021aiot/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021aiot/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021aiot/Makefile       |  0
 board/{freescale => nxp}/ls1021aiot/README         |  0
 board/{freescale => nxp}/ls1021aiot/ls1021aiot.c   |  0
 .../{freescale => nxp}/ls1021aiot/ls102xa_pbi.cfg  |  0
 .../ls1021aiot/ls102xa_rcw_sd.cfg                  |  0
 board/{freescale => nxp}/ls1021aiot/psci.S         |  0
 board/{freescale => nxp}/ls1021aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021aqds/Makefile       |  0
 board/{freescale => nxp}/ls1021aqds/README         |  0
 board/{freescale => nxp}/ls1021aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1021aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1021aqds/ls1021aqds.c   |  0
 .../ls1021aqds/ls1021aqds_qixis.h                  |  0
 .../{freescale => nxp}/ls1021aqds/ls102xa_pbi.cfg  |  0
 .../ls1021aqds/ls102xa_rcw_nand.cfg                |  0
 .../ls1021aqds/ls102xa_rcw_sd_ifc.cfg              |  0
 .../ls1021aqds/ls102xa_rcw_sd_qspi.cfg             |  0
 board/{freescale => nxp}/ls1021aqds/psci.S         |  0
 board/{freescale => nxp}/ls1021atsn/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021atsn/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021atsn/Makefile       |  0
 board/{freescale => nxp}/ls1021atsn/README.rst     |  0
 board/{freescale => nxp}/ls1021atsn/ls1021atsn.c   |  0
 .../{freescale => nxp}/ls1021atsn/ls102xa_pbi.cfg  |  0
 .../ls1021atsn/ls102xa_rcw_sd.cfg                  |  0
 board/{freescale => nxp}/ls1021atwr/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1021atwr/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1021atwr/Makefile       |  0
 board/{freescale => nxp}/ls1021atwr/README         |  0
 board/{freescale => nxp}/ls1021atwr/ls1021atwr.c   |  0
 .../{freescale => nxp}/ls1021atwr/ls102xa_pbi.cfg  |  0
 .../ls1021atwr/ls102xa_rcw_sd_ifc.cfg              |  0
 .../ls1021atwr/ls102xa_rcw_sd_qspi.cfg             |  0
 board/{freescale => nxp}/ls1021atwr/psci.S         |  0
 board/{freescale => nxp}/ls1028a/Kconfig           |  4 +--
 board/{freescale => nxp}/ls1028a/MAINTAINERS       |  4 +--
 board/{freescale => nxp}/ls1028a/Makefile          |  0
 board/{freescale => nxp}/ls1028a/README            |  0
 board/{freescale => nxp}/ls1028a/ddr.c             |  0
 board/{freescale => nxp}/ls1028a/ls1028a.c         |  0
 board/{freescale => nxp}/ls1043aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1043aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1043aqds/Makefile       |  0
 board/{freescale => nxp}/ls1043aqds/README         |  0
 board/{freescale => nxp}/ls1043aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1043aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1043aqds/eth.c          |  0
 board/{freescale => nxp}/ls1043aqds/ls1043aqds.c   |  0
 .../ls1043aqds/ls1043aqds_pbi.cfg                  |  0
 .../ls1043aqds/ls1043aqds_qixis.h                  |  0
 .../ls1043aqds/ls1043aqds_rcw_nand.cfg             |  0
 .../ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg           |  0
 .../ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg          |  0
 board/{freescale => nxp}/ls1043ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1043ardb/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1043ardb/Makefile       |  0
 board/{freescale => nxp}/ls1043ardb/README         |  0
 board/{freescale => nxp}/ls1043ardb/cpld.c         |  0
 board/{freescale => nxp}/ls1043ardb/cpld.h         |  0
 board/{freescale => nxp}/ls1043ardb/ddr.c          |  0
 board/{freescale => nxp}/ls1043ardb/ddr.h          |  0
 board/{freescale => nxp}/ls1043ardb/eth.c          |  0
 board/{freescale => nxp}/ls1043ardb/ls1043ardb.c   |  0
 .../ls1043ardb/ls1043ardb_pbi.cfg                  |  0
 .../ls1043ardb/ls1043ardb_rcw_nand.cfg             |  0
 .../ls1043ardb/ls1043ardb_rcw_sd.cfg               |  0
 board/{freescale => nxp}/ls1046afrwy/Kconfig       |  2 +-
 board/{freescale => nxp}/ls1046afrwy/MAINTAINERS   |  4 +--
 board/{freescale => nxp}/ls1046afrwy/Makefile      |  0
 board/{freescale => nxp}/ls1046afrwy/README        |  0
 board/{freescale => nxp}/ls1046afrwy/ddr.c         |  0
 board/{freescale => nxp}/ls1046afrwy/eth.c         |  0
 board/{freescale => nxp}/ls1046afrwy/ls1046afrwy.c |  0
 board/{freescale => nxp}/ls1046aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1046aqds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/ls1046aqds/Makefile       |  0
 board/{freescale => nxp}/ls1046aqds/README         |  0
 board/{freescale => nxp}/ls1046aqds/ddr.c          |  0
 board/{freescale => nxp}/ls1046aqds/ddr.h          |  0
 board/{freescale => nxp}/ls1046aqds/eth.c          |  0
 board/{freescale => nxp}/ls1046aqds/ls1046aqds.c   |  0
 .../ls1046aqds/ls1046aqds_pbi.cfg                  |  0
 .../ls1046aqds/ls1046aqds_qixis.h                  |  0
 .../ls1046aqds/ls1046aqds_rcw_nand.cfg             |  0
 .../ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg           |  0
 .../ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg          |  0
 board/{freescale => nxp}/ls1046ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls1046ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls1046ardb/Makefile       |  0
 board/{freescale => nxp}/ls1046ardb/cpld.c         |  0
 board/{freescale => nxp}/ls1046ardb/cpld.h         |  0
 board/{freescale => nxp}/ls1046ardb/ddr.c          |  0
 board/{freescale => nxp}/ls1046ardb/ddr.h          |  0
 board/{freescale => nxp}/ls1046ardb/eth.c          |  0
 board/{freescale => nxp}/ls1046ardb/ls1046ardb.c   |  0
 .../ls1046ardb/ls1046ardb_pbi.cfg                  |  0
 .../ls1046ardb/ls1046ardb_qspi_pbi.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_emmc.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_qspi.cfg             |  0
 .../ls1046ardb/ls1046ardb_rcw_sd.cfg               |  0
 board/{freescale => nxp}/ls1088a/Kconfig           |  4 +--
 board/{freescale => nxp}/ls1088a/MAINTAINERS       |  4 +--
 board/{freescale => nxp}/ls1088a/Makefile          |  0
 board/{freescale => nxp}/ls1088a/README            |  0
 board/{freescale => nxp}/ls1088a/ddr.c             |  0
 board/{freescale => nxp}/ls1088a/ddr.h             |  0
 board/{freescale => nxp}/ls1088a/eth_ls1088aqds.c  |  0
 board/{freescale => nxp}/ls1088a/eth_ls1088ardb.c  |  0
 board/{freescale => nxp}/ls1088a/ls1088a.c         |  0
 board/{freescale => nxp}/ls1088a/ls1088a_qixis.h   |  0
 board/{freescale => nxp}/ls2080aqds/Kconfig        |  2 +-
 board/{freescale => nxp}/ls2080aqds/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls2080aqds/Makefile       |  0
 board/{freescale => nxp}/ls2080aqds/README         |  0
 board/{freescale => nxp}/ls2080aqds/ddr.c          |  0
 board/{freescale => nxp}/ls2080aqds/ddr.h          |  0
 board/{freescale => nxp}/ls2080aqds/eth.c          |  0
 board/{freescale => nxp}/ls2080aqds/ls2080aqds.c   |  0
 .../ls2080aqds/ls2080aqds_qixis.h                  |  0
 board/{freescale => nxp}/ls2080ardb/Kconfig        |  2 +-
 board/{freescale => nxp}/ls2080ardb/MAINTAINERS    |  4 +--
 board/{freescale => nxp}/ls2080ardb/Makefile       |  0
 board/{freescale => nxp}/ls2080ardb/README         |  0
 board/{freescale => nxp}/ls2080ardb/ddr.c          |  0
 board/{freescale => nxp}/ls2080ardb/ddr.h          |  0
 .../{freescale => nxp}/ls2080ardb/eth_ls2080rdb.c  |  0
 board/{freescale => nxp}/ls2080ardb/ls2080ardb.c   |  0
 .../ls2080ardb/ls2080ardb_qixis.h                  |  0
 board/{freescale => nxp}/lx2160a/Kconfig           |  6 ++--
 board/{freescale => nxp}/lx2160a/MAINTAINERS       |  6 ++--
 board/{freescale => nxp}/lx2160a/Makefile          |  0
 board/{freescale => nxp}/lx2160a/README            |  0
 board/{freescale => nxp}/lx2160a/ddr.c             |  0
 board/{freescale => nxp}/lx2160a/eth_lx2160aqds.c  |  0
 board/{freescale => nxp}/lx2160a/eth_lx2160ardb.c  |  0
 board/{freescale => nxp}/lx2160a/eth_lx2162aqds.c  |  0
 board/{freescale => nxp}/lx2160a/lx2160a.c         |  0
 board/{freescale => nxp}/lx2160a/lx2160a.h         |  0
 board/{freescale => nxp}/m5208evbe/Kconfig         |  2 +-
 board/{freescale => nxp}/m5208evbe/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m5208evbe/Makefile        |  0
 board/{freescale => nxp}/m5208evbe/m5208evbe.c     |  0
 board/{freescale => nxp}/m5235evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5235evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5235evb/Makefile         |  0
 board/{freescale => nxp}/m5235evb/m5235evb.c       |  0
 board/{freescale => nxp}/m5249evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5249evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5249evb/Makefile         |  0
 board/{freescale => nxp}/m5249evb/m5249evb.c       |  0
 board/{freescale => nxp}/m5253demo/Kconfig         |  2 +-
 board/{freescale => nxp}/m5253demo/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m5253demo/Makefile        |  0
 board/{freescale => nxp}/m5253demo/flash.c         |  0
 board/{freescale => nxp}/m5253demo/m5253demo.c     |  0
 board/{freescale => nxp}/m5272c3/Kconfig           |  2 +-
 board/{freescale => nxp}/m5272c3/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/m5272c3/Makefile          |  0
 board/{freescale => nxp}/m5272c3/m5272c3.c         |  0
 board/{freescale => nxp}/m5275evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5275evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5275evb/Makefile         |  0
 board/{freescale => nxp}/m5275evb/m5275evb.c       |  0
 board/{freescale => nxp}/m5282evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5282evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5282evb/Makefile         |  0
 board/{freescale => nxp}/m5282evb/m5282evb.c       |  0
 board/{freescale => nxp}/m53017evb/Kconfig         |  2 +-
 board/{freescale => nxp}/m53017evb/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/m53017evb/Makefile        |  0
 board/{freescale => nxp}/m53017evb/README          | 12 ++++----
 board/{freescale => nxp}/m53017evb/m53017evb.c     |  0
 board/{freescale => nxp}/m5329evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5329evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5329evb/Makefile         |  0
 board/{freescale => nxp}/m5329evb/m5329evb.c       |  0
 board/{freescale => nxp}/m5329evb/nand.c           |  0
 board/{freescale => nxp}/m5373evb/Kconfig          |  2 +-
 board/{freescale => nxp}/m5373evb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/m5373evb/Makefile         |  0
 board/{freescale => nxp}/m5373evb/README           | 12 ++++----
 board/{freescale => nxp}/m5373evb/m5373evb.c       |  0
 board/{freescale => nxp}/m5373evb/nand.c           |  0
 board/{freescale => nxp}/mpc837xerdb/Kconfig       |  2 +-
 board/{freescale => nxp}/mpc837xerdb/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/mpc837xerdb/Makefile      |  0
 board/{freescale => nxp}/mpc837xerdb/README        |  0
 board/{freescale => nxp}/mpc837xerdb/mpc837xerdb.c |  0
 board/{freescale => nxp}/mpc8548cds/Kconfig        |  2 +-
 board/{freescale => nxp}/mpc8548cds/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mpc8548cds/Makefile       |  0
 board/{freescale => nxp}/mpc8548cds/ddr.c          |  0
 board/{freescale => nxp}/mpc8548cds/law.c          |  0
 board/{freescale => nxp}/mpc8548cds/mpc8548cds.c   |  0
 board/{freescale => nxp}/mpc8548cds/tlb.c          |  0
 board/{freescale => nxp}/mx23evk/Kconfig           |  2 +-
 board/{freescale => nxp}/mx23evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx23evk/Makefile          |  0
 board/{freescale => nxp}/mx23evk/mx23evk.c         |  0
 board/{freescale => nxp}/mx23evk/spl_boot.c        |  0
 board/{freescale => nxp}/mx28evk/Kconfig           |  2 +-
 board/{freescale => nxp}/mx28evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx28evk/Makefile          |  0
 board/{freescale => nxp}/mx28evk/README            |  2 +-
 board/{freescale => nxp}/mx28evk/iomux.c           |  0
 board/{freescale => nxp}/mx28evk/mx28evk.c         |  0
 board/{freescale => nxp}/mx51evk/Kconfig           |  4 +--
 board/{freescale => nxp}/mx51evk/MAINTAINERS       |  2 +-
 board/{freescale => nxp}/mx51evk/Makefile          |  0
 board/{freescale => nxp}/mx51evk/imximage.cfg      |  0
 board/{freescale => nxp}/mx51evk/mx51evk.c         |  0
 board/{freescale => nxp}/mx53loco/Kconfig          |  4 +--
 board/{freescale => nxp}/mx53loco/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/mx53loco/Makefile         |  0
 board/{freescale => nxp}/mx53loco/imximage.cfg     |  0
 board/{freescale => nxp}/mx53loco/mx53loco.c       |  0
 board/{freescale => nxp}/mx6memcal/Kconfig         |  2 +-
 board/{freescale => nxp}/mx6memcal/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6memcal/Makefile        |  0
 board/{freescale => nxp}/mx6memcal/README          |  0
 board/{freescale => nxp}/mx6memcal/mx6memcal.c     |  0
 board/{freescale => nxp}/mx6memcal/spl.c           |  0
 board/{freescale => nxp}/mx6sabreauto/Kconfig      |  2 +-
 board/{freescale => nxp}/mx6sabreauto/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sabreauto/Makefile     |  0
 .../{freescale => nxp}/mx6sabreauto/mx6sabreauto.c |  0
 board/{freescale => nxp}/mx6sabresd/Kconfig        |  2 +-
 board/{freescale => nxp}/mx6sabresd/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mx6sabresd/Makefile       |  0
 board/{freescale => nxp}/mx6sabresd/mx6sabresd.c   |  0
 board/{freescale => nxp}/mx6slevk/Kconfig          |  4 +--
 board/{freescale => nxp}/mx6slevk/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/mx6slevk/Makefile         |  0
 board/{freescale => nxp}/mx6slevk/imximage.cfg     |  0
 board/{freescale => nxp}/mx6slevk/mx6slevk.c       |  0
 board/{freescale => nxp}/mx6sllevk/Kconfig         |  4 +--
 board/{freescale => nxp}/mx6sllevk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6sllevk/Makefile        |  0
 board/{freescale => nxp}/mx6sllevk/imximage.cfg    |  2 +-
 board/{freescale => nxp}/mx6sllevk/mx6sllevk.c     |  0
 board/{freescale => nxp}/mx6sllevk/plugin.S        |  0
 board/{freescale => nxp}/mx6sxsabreauto/Kconfig    |  4 +--
 .../{freescale => nxp}/mx6sxsabreauto/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sxsabreauto/Makefile   |  0
 .../{freescale => nxp}/mx6sxsabreauto/imximage.cfg |  0
 .../mx6sxsabreauto/mx6sxsabreauto.c                |  0
 board/{freescale => nxp}/mx6sxsabresd/Kconfig      |  4 +--
 board/{freescale => nxp}/mx6sxsabresd/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/mx6sxsabresd/Makefile     |  0
 board/{freescale => nxp}/mx6sxsabresd/imximage.cfg |  0
 .../{freescale => nxp}/mx6sxsabresd/mx6sxsabresd.c |  0
 board/{freescale => nxp}/mx6ul_14x14_evk/Kconfig   |  2 +-
 .../{freescale => nxp}/mx6ul_14x14_evk/MAINTAINERS |  2 +-
 board/{freescale => nxp}/mx6ul_14x14_evk/Makefile  |  0
 .../mx6ul_14x14_evk/mx6ul_14x14_evk.c              |  0
 board/{freescale => nxp}/mx6ullevk/Kconfig         |  4 +--
 board/{freescale => nxp}/mx6ullevk/MAINTAINERS     |  2 +-
 board/{freescale => nxp}/mx6ullevk/Makefile        |  0
 board/{freescale => nxp}/mx6ullevk/imximage.cfg    |  2 +-
 board/{freescale => nxp}/mx6ullevk/mx6ullevk.c     |  0
 board/{freescale => nxp}/mx6ullevk/plugin.S        |  0
 board/{freescale => nxp}/mx7dsabresd/Kconfig       |  4 +--
 board/{freescale => nxp}/mx7dsabresd/MAINTAINERS   |  2 +-
 board/{freescale => nxp}/mx7dsabresd/Makefile      |  0
 board/{freescale => nxp}/mx7dsabresd/imximage.cfg  |  0
 board/{freescale => nxp}/mx7dsabresd/mx7dsabresd.c |  0
 board/{freescale => nxp}/mx7ulp_evk/Kconfig        |  4 +--
 board/{freescale => nxp}/mx7ulp_evk/MAINTAINERS    |  2 +-
 board/{freescale => nxp}/mx7ulp_evk/Makefile       |  0
 board/{freescale => nxp}/mx7ulp_evk/imximage.cfg   |  2 +-
 board/{freescale => nxp}/mx7ulp_evk/mx7ulp_evk.c   |  0
 board/{freescale => nxp}/mx7ulp_evk/plugin.S       |  0
 board/{freescale => nxp}/p1010rdb/Kconfig          |  2 +-
 board/{freescale => nxp}/p1010rdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/p1010rdb/Makefile         |  0
 .../{freescale => nxp}/p1010rdb/README.P1010RDB-PA |  0
 .../{freescale => nxp}/p1010rdb/README.P1010RDB-PB |  0
 board/{freescale => nxp}/p1010rdb/ddr.c            |  0
 board/{freescale => nxp}/p1010rdb/law.c            |  0
 board/{freescale => nxp}/p1010rdb/p1010rdb.c       |  0
 board/{freescale => nxp}/p1010rdb/spl.c            |  0
 board/{freescale => nxp}/p1010rdb/spl_minimal.c    |  0
 board/{freescale => nxp}/p1010rdb/tlb.c            |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/Kconfig      |  2 +-
 board/{freescale => nxp}/p1_p2_rdb_pc/MAINTAINERS  |  2 +-
 board/{freescale => nxp}/p1_p2_rdb_pc/Makefile     |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/README       |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/ddr.c        |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/law.c        |  0
 .../{freescale => nxp}/p1_p2_rdb_pc/p1_p2_rdb_pc.c |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/spl.c        |  0
 .../{freescale => nxp}/p1_p2_rdb_pc/spl_minimal.c  |  0
 board/{freescale => nxp}/p1_p2_rdb_pc/tlb.c        |  0
 board/{freescale => nxp}/p2041rdb/Kconfig          |  2 +-
 board/{freescale => nxp}/p2041rdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/p2041rdb/Makefile         |  0
 board/{freescale => nxp}/p2041rdb/README           |  0
 board/{freescale => nxp}/p2041rdb/cpld.c           |  0
 board/{freescale => nxp}/p2041rdb/cpld.h           |  0
 board/{freescale => nxp}/p2041rdb/ddr.c            |  0
 board/{freescale => nxp}/p2041rdb/eth.c            |  0
 board/{freescale => nxp}/p2041rdb/p2041rdb.c       |  0
 board/{freescale => nxp}/p2041rdb/pbi.cfg          |  0
 board/{freescale => nxp}/p2041rdb/rcw_p2041rdb.cfg |  0
 board/{freescale => nxp}/t102xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t102xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t102xrdb/Makefile         |  0
 board/{freescale => nxp}/t102xrdb/README           |  0
 board/{freescale => nxp}/t102xrdb/cpld.c           |  0
 board/{freescale => nxp}/t102xrdb/cpld.h           |  0
 board/{freescale => nxp}/t102xrdb/ddr.c            |  0
 board/{freescale => nxp}/t102xrdb/eth_t102xrdb.c   |  0
 board/{freescale => nxp}/t102xrdb/law.c            |  0
 board/{freescale => nxp}/t102xrdb/spl.c            |  0
 .../{freescale => nxp}/t102xrdb/t1023_nand_rcw.cfg |  0
 board/{freescale => nxp}/t102xrdb/t1023_sd_rcw.cfg |  0
 .../{freescale => nxp}/t102xrdb/t1023_spi_rcw.cfg  |  0
 .../{freescale => nxp}/t102xrdb/t1024_nand_rcw.cfg |  0
 board/{freescale => nxp}/t102xrdb/t1024_pbi.cfg    |  0
 board/{freescale => nxp}/t102xrdb/t1024_sd_rcw.cfg |  0
 .../{freescale => nxp}/t102xrdb/t1024_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t102xrdb/t102xrdb.c       |  0
 board/{freescale => nxp}/t102xrdb/t102xrdb.h       |  0
 board/{freescale => nxp}/t102xrdb/tlb.c            |  0
 board/{freescale => nxp}/t104xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t104xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t104xrdb/Makefile         |  0
 board/{freescale => nxp}/t104xrdb/README           |  4 +--
 board/{freescale => nxp}/t104xrdb/cpld.c           |  0
 board/{freescale => nxp}/t104xrdb/cpld.h           |  0
 board/{freescale => nxp}/t104xrdb/ddr.c            |  0
 board/{freescale => nxp}/t104xrdb/ddr.h            |  0
 board/{freescale => nxp}/t104xrdb/eth.c            |  0
 board/{freescale => nxp}/t104xrdb/law.c            |  0
 board/{freescale => nxp}/t104xrdb/spl.c            |  0
 .../{freescale => nxp}/t104xrdb/t1040_nand_rcw.cfg |  0
 board/{freescale => nxp}/t104xrdb/t1040_sd_rcw.cfg |  0
 .../{freescale => nxp}/t104xrdb/t1040_spi_rcw.cfg  |  0
 .../t104xrdb/t1040d4_nand_rcw.cfg                  |  0
 .../{freescale => nxp}/t104xrdb/t1040d4_sd_rcw.cfg |  0
 .../t104xrdb/t1040d4_spi_rcw.cfg                   |  0
 .../{freescale => nxp}/t104xrdb/t1042_nand_rcw.cfg |  0
 .../t104xrdb/t1042_pi_nand_rcw.cfg                 |  0
 .../t104xrdb/t1042_pi_sd_rcw.cfg                   |  0
 .../t104xrdb/t1042_pi_spi_rcw.cfg                  |  0
 board/{freescale => nxp}/t104xrdb/t1042_sd_rcw.cfg |  0
 .../{freescale => nxp}/t104xrdb/t1042_spi_rcw.cfg  |  0
 .../t104xrdb/t1042d4_nand_rcw.cfg                  |  0
 .../{freescale => nxp}/t104xrdb/t1042d4_sd_rcw.cfg |  0
 .../t104xrdb/t1042d4_spi_rcw.cfg                   |  0
 board/{freescale => nxp}/t104xrdb/t104x_pbi.cfg    |  0
 board/{freescale => nxp}/t104xrdb/t104x_pbi_sb.cfg |  0
 board/{freescale => nxp}/t104xrdb/t104xrdb.c       |  0
 board/{freescale => nxp}/t104xrdb/t104xrdb.h       |  0
 board/{freescale => nxp}/t104xrdb/tlb.c            |  0
 board/{freescale => nxp}/t208xqds/Kconfig          |  2 +-
 board/{freescale => nxp}/t208xqds/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t208xqds/Makefile         |  0
 board/{freescale => nxp}/t208xqds/README           |  0
 board/{freescale => nxp}/t208xqds/ddr.c            |  0
 board/{freescale => nxp}/t208xqds/ddr.h            |  0
 board/{freescale => nxp}/t208xqds/eth_t208xqds.c   |  0
 board/{freescale => nxp}/t208xqds/law.c            |  0
 board/{freescale => nxp}/t208xqds/spl.c            |  0
 .../{freescale => nxp}/t208xqds/t2080_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xqds/t2080_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xqds/t2080_spi_rcw.cfg  |  0
 .../{freescale => nxp}/t208xqds/t2081_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xqds/t2081_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xqds/t2081_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t208xqds/t208x_pbi.cfg    |  0
 board/{freescale => nxp}/t208xqds/t208xqds.c       |  0
 board/{freescale => nxp}/t208xqds/t208xqds.h       |  0
 board/{freescale => nxp}/t208xqds/t208xqds_qixis.h |  0
 board/{freescale => nxp}/t208xqds/tlb.c            |  0
 board/{freescale => nxp}/t208xrdb/Kconfig          |  2 +-
 board/{freescale => nxp}/t208xrdb/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/t208xrdb/Makefile         |  0
 board/{freescale => nxp}/t208xrdb/README           |  0
 board/{freescale => nxp}/t208xrdb/cpld.c           |  0
 board/{freescale => nxp}/t208xrdb/cpld.h           |  0
 board/{freescale => nxp}/t208xrdb/ddr.c            |  0
 board/{freescale => nxp}/t208xrdb/ddr.h            |  0
 board/{freescale => nxp}/t208xrdb/eth_t208xrdb.c   |  0
 board/{freescale => nxp}/t208xrdb/law.c            |  0
 board/{freescale => nxp}/t208xrdb/spl.c            |  0
 .../{freescale => nxp}/t208xrdb/t2080_nand_rcw.cfg |  0
 board/{freescale => nxp}/t208xrdb/t2080_pbi.cfg    |  0
 board/{freescale => nxp}/t208xrdb/t2080_sd_rcw.cfg |  0
 .../{freescale => nxp}/t208xrdb/t2080_spi_rcw.cfg  |  0
 board/{freescale => nxp}/t208xrdb/t208xrdb.c       |  0
 board/{freescale => nxp}/t208xrdb/t208xrdb.h       |  0
 board/{freescale => nxp}/t208xrdb/tlb.c            |  0
 board/{freescale => nxp}/t4rdb/Kconfig             |  2 +-
 board/{freescale => nxp}/t4rdb/MAINTAINERS         |  2 +-
 board/{freescale => nxp}/t4rdb/Makefile            |  0
 board/{freescale => nxp}/t4rdb/cpld.c              |  0
 board/{freescale => nxp}/t4rdb/cpld.h              |  0
 board/{freescale => nxp}/t4rdb/ddr.c               |  0
 board/{freescale => nxp}/t4rdb/ddr.h               |  0
 board/{freescale => nxp}/t4rdb/eth.c               |  0
 board/{freescale => nxp}/t4rdb/law.c               |  0
 board/{freescale => nxp}/t4rdb/spl.c               |  0
 board/{freescale => nxp}/t4rdb/t4240rdb.c          |  0
 board/{freescale => nxp}/t4rdb/t4_pbi.cfg          |  0
 board/{freescale => nxp}/t4rdb/t4_sd_rcw.cfg       |  0
 board/{freescale => nxp}/t4rdb/t4rdb.h             |  0
 board/{freescale => nxp}/t4rdb/tlb.c               |  0
 board/{freescale => nxp}/vf610twr/Kconfig          |  4 +--
 board/{freescale => nxp}/vf610twr/MAINTAINERS      |  2 +-
 board/{freescale => nxp}/vf610twr/Makefile         |  0
 board/{freescale => nxp}/vf610twr/imximage.cfg     |  0
 board/{freescale => nxp}/vf610twr/vf610twr.c       |  0
 .../sifive/unmatched/hifive-platform-i2c-eeprom.c  |  2 +-
 board/technexion/pico-imx6ul/pico-imx6ul.c         |  2 +-
 board/technexion/pico-imx7d/Makefile               |  2 +-
 board/technexion/pico-imx7d/pico-imx7d.c           |  2 +-
 board/warp7/warp7.c                                |  2 +-
 configs/P2041RDB_NAND_defconfig                    |  4 +--
 configs/P2041RDB_SDCARD_defconfig                  |  4 +--
 configs/P2041RDB_SPIFLASH_defconfig                |  4 +--
 configs/T1024RDB_NAND_defconfig                    |  4 +--
 configs/T1024RDB_SDCARD_defconfig                  |  4 +--
 configs/T1024RDB_SPIFLASH_defconfig                |  4 +--
 configs/T1042D4RDB_NAND_defconfig                  |  4 +--
 configs/T1042D4RDB_SDCARD_defconfig                |  4 +--
 configs/T1042D4RDB_SPIFLASH_defconfig              |  4 +--
 configs/T2080QDS_NAND_defconfig                    |  4 +--
 configs/T2080QDS_SDCARD_defconfig                  |  4 +--
 configs/T2080QDS_SPIFLASH_defconfig                |  4 +--
 configs/T2080RDB_NAND_defconfig                    |  4 +--
 configs/T2080RDB_SDCARD_defconfig                  |  4 +--
 configs/T2080RDB_SPIFLASH_defconfig                |  4 +--
 configs/T2080RDB_revD_NAND_defconfig               |  4 +--
 configs/T2080RDB_revD_SDCARD_defconfig             |  4 +--
 configs/T2080RDB_revD_SPIFLASH_defconfig           |  4 +--
 configs/T4240RDB_SDCARD_defconfig                  |  4 +--
 configs/imx8mm_beacon_fspi_defconfig               |  2 +-
 configs/imx8mm_evk_fspi_defconfig                  |  2 +-
 configs/imx8qm_mek_defconfig                       |  2 +-
 configs/imx8qxp_mek_defconfig                      |  2 +-
 configs/imxrt1050-evk_fspi_defconfig               |  2 +-
 configs/ls1021aiot_sdcard_defconfig                |  4 +--
 configs/ls1021aqds_nand_defconfig                  |  4 +--
 configs/ls1021aqds_sdcard_ifc_defconfig            |  4 +--
 configs/ls1021aqds_sdcard_qspi_defconfig           |  4 +--
 configs/ls1021atsn_sdcard_defconfig                |  4 +--
 .../ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig    |  4 +--
 configs/ls1021atwr_sdcard_ifc_defconfig            |  4 +--
 configs/ls1021atwr_sdcard_qspi_defconfig           |  4 +--
 doc/README.pblimage                                |  2 +-
 doc/imx/mkimage/imximage.txt                       |  2 +-
 drivers/mmc/fsl_esdhc.c                            |  2 +-
 676 files changed, 352 insertions(+), 352 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 3b684ec73ba..e4cb49eaa21 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -11,9 +11,9 @@ variables:
   container_option: -u 0
   work_dir: /u
   # We define all of these as variables so we can easily reference them twice
-  am33xx_kirkwood_ls1_mvebu_omap: "am33xx kirkwood ls1 mvebu omap -x siemens,freescale"
+  am33xx_kirkwood_ls1_mvebu_omap: "am33xx kirkwood ls1 mvebu omap -x siemens,nxp"
   amlogic_bcm_boundary_engicam_siemens_technexion_oradex: "amlogic bcm boundary engicam siemens technexion toradex -x mips"
-  arm_nxp_minus_imx_and_at91: "at91 freescale -x powerpc,m68k,imx,mx"
+  arm_nxp_minus_imx_and_at91: "at91 nxp -x powerpc,m68k,imx,mx"
   imx: "mx imx -x boundary,engicam,technexion,toradex"
   rk: "rk"
   sunxi: "sunxi"
diff --git a/MAINTAINERS b/MAINTAINERS
index 60772a494a3..99856273bad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -314,8 +314,8 @@ F:	arch/arm/include/asm/arch-imx*/
 F:	arch/arm/include/asm/arch-mx*/
 F:	arch/arm/include/asm/arch-vf610/
 F:	arch/arm/include/asm/mach-imx/
-F:	board/freescale/*mx*/
-F:	board/freescale/common/
+F:	board/nxp/*mx*/
+F:	board/nxp/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/board/nxp/
 F:	doc/imx/
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3db5474a05b..17a19547a50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2422,23 +2422,23 @@ source "board/cavium/thunderx/Kconfig"
 source "board/eets/pdu001/Kconfig"
 source "board/emulation/qemu-arm/Kconfig"
 source "board/emulation/qemu-sbsa/Kconfig"
-source "board/freescale/ls2080aqds/Kconfig"
-source "board/freescale/ls2080ardb/Kconfig"
-source "board/freescale/ls1088a/Kconfig"
-source "board/freescale/ls1028a/Kconfig"
-source "board/freescale/ls1021aqds/Kconfig"
-source "board/freescale/ls1043aqds/Kconfig"
-source "board/freescale/ls1021atwr/Kconfig"
-source "board/freescale/ls1021atsn/Kconfig"
-source "board/freescale/ls1021aiot/Kconfig"
-source "board/freescale/ls1046aqds/Kconfig"
-source "board/freescale/ls1043ardb/Kconfig"
-source "board/freescale/ls1046ardb/Kconfig"
-source "board/freescale/ls1046afrwy/Kconfig"
-source "board/freescale/ls1012aqds/Kconfig"
-source "board/freescale/ls1012ardb/Kconfig"
-source "board/freescale/ls1012afrdm/Kconfig"
-source "board/freescale/lx2160a/Kconfig"
+source "board/nxp/ls2080aqds/Kconfig"
+source "board/nxp/ls2080ardb/Kconfig"
+source "board/nxp/ls1088a/Kconfig"
+source "board/nxp/ls1028a/Kconfig"
+source "board/nxp/ls1021aqds/Kconfig"
+source "board/nxp/ls1043aqds/Kconfig"
+source "board/nxp/ls1021atwr/Kconfig"
+source "board/nxp/ls1021atsn/Kconfig"
+source "board/nxp/ls1021aiot/Kconfig"
+source "board/nxp/ls1046aqds/Kconfig"
+source "board/nxp/ls1043ardb/Kconfig"
+source "board/nxp/ls1046ardb/Kconfig"
+source "board/nxp/ls1046afrwy/Kconfig"
+source "board/nxp/ls1012aqds/Kconfig"
+source "board/nxp/ls1012ardb/Kconfig"
+source "board/nxp/ls1012afrdm/Kconfig"
+source "board/nxp/lx2160a/Kconfig"
 source "board/grinn/chiliboard/Kconfig"
 source "board/hisilicon/hikey/Kconfig"
 source "board/hisilicon/hikey960/Kconfig"
diff --git a/arch/arm/cpu/armv7/vf610/Kconfig b/arch/arm/cpu/armv7/vf610/Kconfig
index 5d485a3ce24..6689494b488 100644
--- a/arch/arm/cpu/armv7/vf610/Kconfig
+++ b/arch/arm/cpu/armv7/vf610/Kconfig
@@ -30,7 +30,7 @@ endchoice
 config SYS_SOC
 	default "vf610"
 
-source "board/freescale/vf610twr/Kconfig"
+source "board/nxp/vf610twr/Kconfig"
 source "board/phytec/pcm052/Kconfig"
 source "board/toradex/colibri_vf/Kconfig"
 
diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
index 257c14e61b6..2ca0d7465f4 100644
--- a/arch/arm/mach-imx/imx8/Kconfig
+++ b/arch/arm/mach-imx/imx8/Kconfig
@@ -104,8 +104,8 @@ config TARGET_IMX8QXP_MEK
 
 endchoice
 
-source "board/freescale/imx8qm_mek/Kconfig"
-source "board/freescale/imx8qxp_mek/Kconfig"
+source "board/nxp/imx8qm_mek/Kconfig"
+source "board/nxp/imx8qxp_mek/Kconfig"
 source "board/congatec/cgtqmx8/Kconfig"
 source "board/advantech/imx8qm_dmsse20_a1/Kconfig"
 source "board/advantech/imx8qm_rom7720_a1/Kconfig"
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 030ed2f0633..2ad37c70d4f 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -428,10 +428,10 @@ source "board/dhelectronics/dh_imx8mp/Kconfig"
 source "board/emcraft/imx8mp_navqp/Kconfig"
 source "board/engicam/imx8mm/Kconfig"
 source "board/engicam/imx8mp/Kconfig"
-source "board/freescale/imx8mq_evk/Kconfig"
-source "board/freescale/imx8mm_evk/Kconfig"
-source "board/freescale/imx8mn_evk/Kconfig"
-source "board/freescale/imx8mp_evk/Kconfig"
+source "board/nxp/imx8mq_evk/Kconfig"
+source "board/nxp/imx8mm_evk/Kconfig"
+source "board/nxp/imx8mn_evk/Kconfig"
+source "board/nxp/imx8mp_evk/Kconfig"
 source "board/gateworks/venice/Kconfig"
 source "board/google/imx8mq_phanbell/Kconfig"
 source "board/kontron/pitx_imx8m/Kconfig"
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index fbca241e106..197089a41b5 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -30,6 +30,6 @@ config TARGET_IMX8ULP_EVK
 
 endchoice
 
-source "board/freescale/imx8ulp_evk/Kconfig"
+source "board/nxp/imx8ulp_evk/Kconfig"
 
 endif
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9725a96043..0d62da90816 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -138,14 +138,14 @@ config TARGET_TORADEX_SMARC_IMX95
 
 endchoice
 
-source "board/freescale/imx91_evk/Kconfig"
-source "board/freescale/imx93_evk/Kconfig"
-source "board/freescale/imx93_frdm/Kconfig"
-source "board/freescale/imx93_qsb/Kconfig"
+source "board/nxp/imx91_evk/Kconfig"
+source "board/nxp/imx93_evk/Kconfig"
+source "board/nxp/imx93_frdm/Kconfig"
+source "board/nxp/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
-source "board/freescale/imx94_evk/Kconfig"
-source "board/freescale/imx95_evk/Kconfig"
+source "board/nxp/imx94_evk/Kconfig"
+source "board/nxp/imx95_evk/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
 
 endif
diff --git a/arch/arm/mach-imx/imxrt/Kconfig b/arch/arm/mach-imx/imxrt/Kconfig
index ccccf702f67..6bc0de54e8b 100644
--- a/arch/arm/mach-imx/imxrt/Kconfig
+++ b/arch/arm/mach-imx/imxrt/Kconfig
@@ -38,8 +38,8 @@ config TARGET_IMXRT1170_EVK
 
 endchoice
 
-source "board/freescale/imxrt1020-evk/Kconfig"
-source "board/freescale/imxrt1050-evk/Kconfig"
-source "board/freescale/imxrt1170-evk/Kconfig"
+source "board/nxp/imxrt1020-evk/Kconfig"
+source "board/nxp/imxrt1050-evk/Kconfig"
+source "board/nxp/imxrt1170-evk/Kconfig"
 
 endif
diff --git a/arch/arm/mach-imx/mx5/Kconfig b/arch/arm/mach-imx/mx5/Kconfig
index 0dfd6849687..6ce27257708 100644
--- a/arch/arm/mach-imx/mx5/Kconfig
+++ b/arch/arm/mach-imx/mx5/Kconfig
@@ -71,8 +71,8 @@ config SYS_SOC
 	default "mx5"
 
 source "board/beckhoff/mx53cx9020/Kconfig"
-source "board/freescale/mx51evk/Kconfig"
-source "board/freescale/mx53loco/Kconfig"
+source "board/nxp/mx51evk/Kconfig"
+source "board/nxp/mx53loco/Kconfig"
 source "board/ge/mx53ppd/Kconfig"
 source "board/inversepath/usbarmory/Kconfig"
 source "board/k+p/kp_imx53/Kconfig"
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 3f5e91da204..f64bebfc14b 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -713,15 +713,15 @@ source "board/dhelectronics/dh_imx6/Kconfig"
 source "board/embest/mx6boards/Kconfig"
 source "board/engicam/imx6q/Kconfig"
 source "board/engicam/imx6ul/Kconfig"
-source "board/freescale/mx6memcal/Kconfig"
-source "board/freescale/mx6sabreauto/Kconfig"
-source "board/freescale/mx6sabresd/Kconfig"
-source "board/freescale/mx6slevk/Kconfig"
-source "board/freescale/mx6sllevk/Kconfig"
-source "board/freescale/mx6sxsabresd/Kconfig"
-source "board/freescale/mx6sxsabreauto/Kconfig"
-source "board/freescale/mx6ul_14x14_evk/Kconfig"
-source "board/freescale/mx6ullevk/Kconfig"
+source "board/nxp/mx6memcal/Kconfig"
+source "board/nxp/mx6sabreauto/Kconfig"
+source "board/nxp/mx6sabresd/Kconfig"
+source "board/nxp/mx6slevk/Kconfig"
+source "board/nxp/mx6sllevk/Kconfig"
+source "board/nxp/mx6sxsabresd/Kconfig"
+source "board/nxp/mx6sxsabreauto/Kconfig"
+source "board/nxp/mx6ul_14x14_evk/Kconfig"
+source "board/nxp/mx6ullevk/Kconfig"
 source "board/bosch/acc/Kconfig"
 source "board/grinn/liteboard/Kconfig"
 source "board/phytec/pcm058/Kconfig"
diff --git a/arch/arm/mach-imx/mx7/Kconfig b/arch/arm/mach-imx/mx7/Kconfig
index 4e0e8ed0582..f576ee650f0 100644
--- a/arch/arm/mach-imx/mx7/Kconfig
+++ b/arch/arm/mach-imx/mx7/Kconfig
@@ -97,7 +97,7 @@ config SYS_SOC
 
 source "board/compulab/cl-som-imx7/Kconfig"
 source "board/ronetix/imx7-cm/Kconfig"
-source "board/freescale/mx7dsabresd/Kconfig"
+source "board/nxp/mx7dsabresd/Kconfig"
 source "board/novtech/meerkat96/Kconfig"
 source "board/storopack/smegw01/Kconfig"
 source "board/technexion/pico-imx7d/Kconfig"
diff --git a/arch/arm/mach-imx/mx7ulp/Kconfig b/arch/arm/mach-imx/mx7ulp/Kconfig
index 632c4bf6fa5..e8cb58bc89f 100644
--- a/arch/arm/mach-imx/mx7ulp/Kconfig
+++ b/arch/arm/mach-imx/mx7ulp/Kconfig
@@ -46,6 +46,6 @@ config TARGET_MX7ULP_EVK
 endchoice
 
 source "board/ea/mx7ulp_com/Kconfig"
-source "board/freescale/mx7ulp_evk/Kconfig"
+source "board/nxp/mx7ulp_evk/Kconfig"
 
 endif
diff --git a/arch/arm/mach-imx/mxs/Kconfig b/arch/arm/mach-imx/mxs/Kconfig
index b134d04b210..204252ed3c6 100644
--- a/arch/arm/mach-imx/mxs/Kconfig
+++ b/arch/arm/mach-imx/mxs/Kconfig
@@ -24,7 +24,7 @@ config SYS_SOC
 	default "mxs"
 
 source "board/olimex/mx23_olinuxino/Kconfig"
-source "board/freescale/mx23evk/Kconfig"
+source "board/nxp/mx23evk/Kconfig"
 
 endif
 
@@ -74,7 +74,7 @@ config SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR
 	  This option enables the 4P2 linear regulator (derived
 	  from VDD5V) - so the VDD4P2 power source is operational.
 
-source "board/freescale/mx28evk/Kconfig"
+source "board/nxp/mx28evk/Kconfig"
 source "board/liebherr/btt/Kconfig"
 source "board/liebherr/xea/Kconfig"
 
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 8ade6f7b9d1..f5d495f9935 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -180,16 +180,16 @@ endchoice
 
 source "board/BuS/eb_cpu5282/Kconfig"
 source "board/cobra5272/Kconfig"
-source "board/freescale/m5208evbe/Kconfig"
-source "board/freescale/m5235evb/Kconfig"
-source "board/freescale/m5249evb/Kconfig"
-source "board/freescale/m5253demo/Kconfig"
-source "board/freescale/m5272c3/Kconfig"
-source "board/freescale/m5275evb/Kconfig"
-source "board/freescale/m5282evb/Kconfig"
-source "board/freescale/m53017evb/Kconfig"
-source "board/freescale/m5329evb/Kconfig"
-source "board/freescale/m5373evb/Kconfig"
+source "board/nxp/m5208evbe/Kconfig"
+source "board/nxp/m5235evb/Kconfig"
+source "board/nxp/m5249evb/Kconfig"
+source "board/nxp/m5253demo/Kconfig"
+source "board/nxp/m5272c3/Kconfig"
+source "board/nxp/m5275evb/Kconfig"
+source "board/nxp/m5282evb/Kconfig"
+source "board/nxp/m53017evb/Kconfig"
+source "board/nxp/m5329evb/Kconfig"
+source "board/nxp/m5373evb/Kconfig"
 source "board/sysam/amcore/Kconfig"
 source "board/sysam/stmark2/Kconfig"
 
diff --git a/arch/powerpc/cpu/mpc83xx/Kconfig b/arch/powerpc/cpu/mpc83xx/Kconfig
index 582e1412211..8ac83420ee2 100644
--- a/arch/powerpc/cpu/mpc83xx/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/Kconfig
@@ -207,7 +207,7 @@ config FSL_SERDES
 config NEVER_ASSERT_ODT_TO_CPU
 	bool "Never assert ODT to internal IOs"
 
-source "board/freescale/mpc837xerdb/Kconfig"
+source "board/nxp/mpc837xerdb/Kconfig"
 source "board/gdsys/mpc8308/Kconfig"
 source "board/cssi/cmpcpro/Kconfig"
 
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index fd0ef3633b7..c5c2220593f 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -1542,15 +1542,15 @@ config FSL_VIA
 
 source "board/CZ.NIC/turris_1x/Kconfig"
 source "board/emulation/qemu-ppce500/Kconfig"
-source "board/freescale/mpc8548cds/Kconfig"
-source "board/freescale/p1010rdb/Kconfig"
-source "board/freescale/p1_p2_rdb_pc/Kconfig"
-source "board/freescale/p2041rdb/Kconfig"
-source "board/freescale/t102xrdb/Kconfig"
-source "board/freescale/t104xrdb/Kconfig"
-source "board/freescale/t208xqds/Kconfig"
-source "board/freescale/t208xrdb/Kconfig"
-source "board/freescale/t4rdb/Kconfig"
+source "board/nxp/mpc8548cds/Kconfig"
+source "board/nxp/p1010rdb/Kconfig"
+source "board/nxp/p1_p2_rdb_pc/Kconfig"
+source "board/nxp/p2041rdb/Kconfig"
+source "board/nxp/t102xrdb/Kconfig"
+source "board/nxp/t104xrdb/Kconfig"
+source "board/nxp/t208xqds/Kconfig"
+source "board/nxp/t208xrdb/Kconfig"
+source "board/nxp/t4rdb/Kconfig"
 source "board/socrates/Kconfig"
 
 endmenu
diff --git a/board/CZ.NIC/turris_1x/MAINTAINERS b/board/CZ.NIC/turris_1x/MAINTAINERS
index e858c97b962..36e27a57221 100644
--- a/board/CZ.NIC/turris_1x/MAINTAINERS
+++ b/board/CZ.NIC/turris_1x/MAINTAINERS
@@ -6,8 +6,8 @@ F:	arch/powerpc/dts/turris1x.dts
 F:	board/CZ.NIC/turris_1x/
 F:	board/CZ.NIC/turris_atsha_otp.c
 F:	board/CZ.NIC/turris_atsha_otp.h
-F:	board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
-F:	board/freescale/p1_p2_rdb_pc/spl.c
+F:	board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+F:	board/nxp/p1_p2_rdb_pc/spl.c
 F:	configs/turris_1x_nor_defconfig
 F:	configs/turris_1x_sdcard_defconfig
 F:	include/configs/turris_1x.h
diff --git a/board/CZ.NIC/turris_1x/Makefile b/board/CZ.NIC/turris_1x/Makefile
index 1bf370122d9..c5c47adac0a 100644
--- a/board/CZ.NIC/turris_1x/Makefile
+++ b/board/CZ.NIC/turris_1x/Makefile
@@ -2,10 +2,10 @@
 # (C) 2022 Pali Rohár <pali@kernel.org>
 
 ifdef CONFIG_XPL_BUILD
-obj-y	+= ../../freescale/p1_p2_rdb_pc/spl.o
+obj-y	+= ../../nxp/p1_p2_rdb_pc/spl.o
 endif
 
-obj-y	+= ../../freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.o
+obj-y	+= ../../nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.o
 obj-y	+= ../turris_atsha_otp.o
 obj-y	+= ../turris_common.o
 
diff --git a/board/CZ.NIC/turris_1x/turris_1x.c b/board/CZ.NIC/turris_1x/turris_1x.c
index 7a0b68caaef..2f9557a4170 100644
--- a/board/CZ.NIC/turris_1x/turris_1x.c
+++ b/board/CZ.NIC/turris_1x/turris_1x.c
@@ -315,7 +315,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-/* This comes from ../../freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c */
+/* This comes from ../../nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c */
 extern int checkboard_p1_p2(void);
 
 int checkboard(void)
diff --git a/board/beacon/imx8mm/Makefile b/board/beacon/imx8mm/Makefile
index b33dc8b05b9..8484b85ae12 100644
--- a/board/beacon/imx8mm/Makefile
+++ b/board/beacon/imx8mm/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += imx8mm_beacon.o
-obj-y += ../../freescale/common/
+obj-y += ../../nxp/common/
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
diff --git a/board/beacon/imx8mn/Makefile b/board/beacon/imx8mn/Makefile
index 48b7b0952cc..54735792b93 100644
--- a/board/beacon/imx8mn/Makefile
+++ b/board/beacon/imx8mn/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += imx8mn_beacon.o
-obj-y += ../../freescale/common/
+obj-y += ../../nxp/common/
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
 ifdef CONFIG_IMX8MN_BEACON_2GB_LPDDR
diff --git a/board/beacon/imx8mp/Kconfig b/board/beacon/imx8mp/Kconfig
index 3c0fca9be8d..b0dd98cf9fd 100644
--- a/board/beacon/imx8mp/Kconfig
+++ b/board/beacon/imx8mp/Kconfig
@@ -10,7 +10,7 @@ config SYS_CONFIG_NAME
 	default "imx8mp_beacon"
 
 config IMX_CONFIG
-	default "board/freescale/imx8mp_evk/imximage-8mp-lpddr4.cfg"
+	default "board/nxp/imx8mp_evk/imximage-8mp-lpddr4.cfg"
 
 
 endif
diff --git a/board/beacon/imx8mp/Makefile b/board/beacon/imx8mp/Makefile
index 7b994d2c8a1..669b54d63e7 100644
--- a/board/beacon/imx8mp/Makefile
+++ b/board/beacon/imx8mp/Makefile
@@ -5,7 +5,7 @@
 #
 
 obj-y += imx8mp_beacon.o
-obj-y += ../../freescale/common/
+obj-y += ../../nxp/common/
 
 ifdef CONFIG_XPL_BUILD
 obj-y += spl.o
diff --git a/board/beckhoff/mx53cx9020/imximage.cfg b/board/beckhoff/mx53cx9020/imximage.cfg
index 159f50e2a5f..be2ec43d346 100644
--- a/board/beckhoff/mx53cx9020/imximage.cfg
+++ b/board/beckhoff/mx53cx9020/imximage.cfg
@@ -3,7 +3,7 @@
  * Copyright (C) 2015  Beckhoff Automation GmbH
  * Patrick Bruenn <p.bruenn@beckhoff.com>
  *
- * Based on <u-boot>/board/freescale/mx53loco/imximage.cfg
+ * Based on <u-boot>/board/nxp/mx53loco/imximage.cfg
  * Copyright (C) 2011 Freescale Semiconductor, Inc.
  */
 
diff --git a/board/beckhoff/mx53cx9020/mx53cx9020.c b/board/beckhoff/mx53cx9020/mx53cx9020.c
index 3a766728a6f..ffbd639921d 100644
--- a/board/beckhoff/mx53cx9020/mx53cx9020.c
+++ b/board/beckhoff/mx53cx9020/mx53cx9020.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015  Beckhoff Automation GmbH & Co. KG
  * Patrick Bruenn <p.bruenn@beckhoff.com>
  *
- * Based on <u-boot>/board/freescale/mx53loco/mx53loco.c
+ * Based on <u-boot>/board/nxp/mx53loco/mx53loco.c
  * Copyright (C) 2011 Freescale Semiconductor, Inc.
  */
 
diff --git a/board/beckhoff/mx53cx9020/mx53cx9020_video.c b/board/beckhoff/mx53cx9020/mx53cx9020_video.c
index fd28a70f4d7..e3eaf0393ba 100644
--- a/board/beckhoff/mx53cx9020/mx53cx9020_video.c
+++ b/board/beckhoff/mx53cx9020/mx53cx9020_video.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015  Beckhoff Automation GmbH & Co. KG
  * Patrick Bruenn <p.bruenn@beckhoff.com>
  *
- * Based on <u-boot>/board/freescale/mx53loco/mx53loco_video.c
+ * Based on <u-boot>/board/nxp/mx53loco/mx53loco_video.c
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  */
 
diff --git a/board/boundary/nitrogen6x/README b/board/boundary/nitrogen6x/README
index 973b18fa93f..0b59289e7f0 100644
--- a/board/boundary/nitrogen6x/README
+++ b/board/boundary/nitrogen6x/README
@@ -10,7 +10,7 @@ Freescale i.MX6Q SabreLite boards.
 The configuration in this directory supports both the
 Nitrogen6X and Freescale SabreLite board, but in a
 different fashion from Freescale's implementation in
-board/freescale/mx6qsabrelite.
+board/nxp/mx6qsabrelite.
 
 In particular, this image supports booting from SPI NOR
 and saving the environment to SPI NOR.
diff --git a/board/ea/mx7ulp_com/imximage.cfg b/board/ea/mx7ulp_com/imximage.cfg
index 1731da814d0..c77a9966076 100644
--- a/board/ea/mx7ulp_com/imximage.cfg
+++ b/board/ea/mx7ulp_com/imximage.cfg
@@ -24,7 +24,7 @@ BOOT_FROM	sd
 
 #ifdef CONFIG_USE_IMXIMG_PLUGIN
 /*PLUGIN    plugin-binary-file    IRAM_FREE_START_ADDR*/
-PLUGIN	board/freescale/mx7ulp_evk/plugin.bin 0x2F020000
+PLUGIN	board/nxp/mx7ulp_evk/plugin.bin 0x2F020000
 #else
 
 #ifdef CONFIG_IMX_HAB
diff --git a/board/ge/mx53ppd/Makefile b/board/ge/mx53ppd/Makefile
index 9fae4143998..112bceda3f6 100644
--- a/board/ge/mx53ppd/Makefile
+++ b/board/ge/mx53ppd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright 2017 General Electric Company
 #
-# Based on board/freescale/mx53loco/Makefile:
+# Based on board/nxp/mx53loco/Makefile:
 #
 # (C) Copyright 2011 Freescale Semiconductor, Inc.
 # Jason Liu <r64343@freescale.com>
diff --git a/board/ge/mx53ppd/imximage.cfg b/board/ge/mx53ppd/imximage.cfg
index 1ee81983907..533f18b674b 100644
--- a/board/ge/mx53ppd/imximage.cfg
+++ b/board/ge/mx53ppd/imximage.cfg
@@ -2,7 +2,7 @@
 /*
  * Copyright 2017 General Electric Company
  *
- * Based on board/freescale/mx53loco/imximage.cfg:
+ * Based on board/nxp/mx53loco/imximage.cfg:
  *
  * Copyright (C) 2011 Freescale Semiconductor, Inc.
  * Jason Liu <r64343@freescale.com>
diff --git a/board/ge/mx53ppd/mx53ppd.c b/board/ge/mx53ppd/mx53ppd.c
index 9396d43f8ad..cb9b88a1a58 100644
--- a/board/ge/mx53ppd/mx53ppd.c
+++ b/board/ge/mx53ppd/mx53ppd.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2017 General Electric Company
  *
- * Based on board/freescale/mx53loco/mx53loco.c:
+ * Based on board/nxp/mx53loco/mx53loco.c:
  *
  * Copyright (C) 2011 Freescale Semiconductor, Inc.
  * Jason Liu <r64343@freescale.com>
diff --git a/board/ge/mx53ppd/mx53ppd_video.c b/board/ge/mx53ppd/mx53ppd_video.c
index eb4dd758b3b..32e208aadd1 100644
--- a/board/ge/mx53ppd/mx53ppd_video.c
+++ b/board/ge/mx53ppd/mx53ppd_video.c
@@ -2,7 +2,7 @@
 /*
  * Copyright 2017 General Electric Company
  *
- * Based on board/freescale/mx53loco/mx53loco_video.c:
+ * Based on board/nxp/mx53loco/mx53loco_video.c:
  *
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  * Fabio Estevam <fabio.estevam@freescale.com>
diff --git a/board/k+p/kp_imx53/Kconfig b/board/k+p/kp_imx53/Kconfig
index fb35127696b..ef6696b1160 100644
--- a/board/k+p/kp_imx53/Kconfig
+++ b/board/k+p/kp_imx53/Kconfig
@@ -13,6 +13,6 @@ config SYS_CONFIG_NAME
 	default "kp_imx53"
 
 config IMX_CONFIG
-	default "board/freescale/mx53loco/imximage.cfg"
+	default "board/nxp/mx53loco/imximage.cfg"
 
 endif
diff --git a/board/keymile/pg-wcom-ls102xa/Makefile b/board/keymile/pg-wcom-ls102xa/Makefile
index 229b0c28278..88cb95bb8c3 100644
--- a/board/keymile/pg-wcom-ls102xa/Makefile
+++ b/board/keymile/pg-wcom-ls102xa/Makefile
@@ -6,6 +6,6 @@
 
 obj-y += pg-wcom-ls102xa.o ddr.o
 obj-y += ../common/common.o ../common/ivm.o ../common/qrio.o
-obj-$(CONFIG_LAYERSCAPE_NS_ACCESS) += ../../freescale/common/ns_access.o
-obj-$(CONFIG_LS102XA_STREAM_ID) += ../../freescale/common/ls102xa_stream_id.o
-obj-$(CONFIG_ID_EEPROM) += ../../freescale/common/sys_eeprom.o
+obj-$(CONFIG_LAYERSCAPE_NS_ACCESS) += ../../nxp/common/ns_access.o
+obj-$(CONFIG_LS102XA_STREAM_ID) += ../../nxp/common/ls102xa_stream_id.o
+obj-$(CONFIG_ID_EEPROM) += ../../nxp/common/sys_eeprom.o
diff --git a/board/freescale/common/Makefile b/board/nxp/common/Makefile
similarity index 100%
rename from board/freescale/common/Makefile
rename to board/nxp/common/Makefile
diff --git a/board/freescale/common/arm_sleep.c b/board/nxp/common/arm_sleep.c
similarity index 100%
rename from board/freescale/common/arm_sleep.c
rename to board/nxp/common/arm_sleep.c
diff --git a/board/freescale/common/cadmus.c b/board/nxp/common/cadmus.c
similarity index 100%
rename from board/freescale/common/cadmus.c
rename to board/nxp/common/cadmus.c
diff --git a/board/freescale/common/cadmus.h b/board/nxp/common/cadmus.h
similarity index 100%
rename from board/freescale/common/cadmus.h
rename to board/nxp/common/cadmus.h
diff --git a/board/freescale/common/cds_pci_ft.c b/board/nxp/common/cds_pci_ft.c
similarity index 100%
rename from board/freescale/common/cds_pci_ft.c
rename to board/nxp/common/cds_pci_ft.c
diff --git a/board/freescale/common/cds_via.c b/board/nxp/common/cds_via.c
similarity index 100%
rename from board/freescale/common/cds_via.c
rename to board/nxp/common/cds_via.c
diff --git a/board/freescale/common/cmd_esbc_validate.c b/board/nxp/common/cmd_esbc_validate.c
similarity index 100%
rename from board/freescale/common/cmd_esbc_validate.c
rename to board/nxp/common/cmd_esbc_validate.c
diff --git a/board/freescale/common/eeprom.h b/board/nxp/common/eeprom.h
similarity index 100%
rename from board/freescale/common/eeprom.h
rename to board/nxp/common/eeprom.h
diff --git a/board/freescale/common/emc2305.c b/board/nxp/common/emc2305.c
similarity index 100%
rename from board/freescale/common/emc2305.c
rename to board/nxp/common/emc2305.c
diff --git a/board/freescale/common/emc2305.h b/board/nxp/common/emc2305.h
similarity index 100%
rename from board/freescale/common/emc2305.h
rename to board/nxp/common/emc2305.h
diff --git a/board/freescale/common/fman.c b/board/nxp/common/fman.c
similarity index 100%
rename from board/freescale/common/fman.c
rename to board/nxp/common/fman.c
diff --git a/board/freescale/common/fman.h b/board/nxp/common/fman.h
similarity index 100%
rename from board/freescale/common/fman.h
rename to board/nxp/common/fman.h
diff --git a/board/freescale/common/fsl_chain_of_trust.c b/board/nxp/common/fsl_chain_of_trust.c
similarity index 100%
rename from board/freescale/common/fsl_chain_of_trust.c
rename to board/nxp/common/fsl_chain_of_trust.c
diff --git a/board/freescale/common/fsl_validate.c b/board/nxp/common/fsl_validate.c
similarity index 100%
rename from board/freescale/common/fsl_validate.c
rename to board/nxp/common/fsl_validate.c
diff --git a/board/freescale/common/i2c_common.c b/board/nxp/common/i2c_common.c
similarity index 100%
rename from board/freescale/common/i2c_common.c
rename to board/nxp/common/i2c_common.c
diff --git a/board/freescale/common/i2c_common.h b/board/nxp/common/i2c_common.h
similarity index 100%
rename from board/freescale/common/i2c_common.h
rename to board/nxp/common/i2c_common.h
diff --git a/board/freescale/common/i2c_mux.c b/board/nxp/common/i2c_mux.c
similarity index 100%
rename from board/freescale/common/i2c_mux.c
rename to board/nxp/common/i2c_mux.c
diff --git a/board/freescale/common/i2c_mux.h b/board/nxp/common/i2c_mux.h
similarity index 100%
rename from board/freescale/common/i2c_mux.h
rename to board/nxp/common/i2c_mux.h
diff --git a/board/freescale/common/ics307_clk.c b/board/nxp/common/ics307_clk.c
similarity index 100%
rename from board/freescale/common/ics307_clk.c
rename to board/nxp/common/ics307_clk.c
diff --git a/board/freescale/common/ics307_clk.h b/board/nxp/common/ics307_clk.h
similarity index 100%
rename from board/freescale/common/ics307_clk.h
rename to board/nxp/common/ics307_clk.h
diff --git a/board/freescale/common/ls102xa_stream_id.c b/board/nxp/common/ls102xa_stream_id.c
similarity index 100%
rename from board/freescale/common/ls102xa_stream_id.c
rename to board/nxp/common/ls102xa_stream_id.c
diff --git a/board/freescale/common/mc34vr500.c b/board/nxp/common/mc34vr500.c
similarity index 100%
rename from board/freescale/common/mc34vr500.c
rename to board/nxp/common/mc34vr500.c
diff --git a/board/freescale/common/mmc.c b/board/nxp/common/mmc.c
similarity index 100%
rename from board/freescale/common/mmc.c
rename to board/nxp/common/mmc.c
diff --git a/board/freescale/common/mpc85xx_sleep.c b/board/nxp/common/mpc85xx_sleep.c
similarity index 100%
rename from board/freescale/common/mpc85xx_sleep.c
rename to board/nxp/common/mpc85xx_sleep.c
diff --git a/board/freescale/common/ngpixis.c b/board/nxp/common/ngpixis.c
similarity index 100%
rename from board/freescale/common/ngpixis.c
rename to board/nxp/common/ngpixis.c
diff --git a/board/freescale/common/ngpixis.h b/board/nxp/common/ngpixis.h
similarity index 100%
rename from board/freescale/common/ngpixis.h
rename to board/nxp/common/ngpixis.h
diff --git a/board/freescale/common/ns_access.c b/board/nxp/common/ns_access.c
similarity index 100%
rename from board/freescale/common/ns_access.c
rename to board/nxp/common/ns_access.c
diff --git a/board/freescale/common/p_corenet/Makefile b/board/nxp/common/p_corenet/Makefile
similarity index 100%
rename from board/freescale/common/p_corenet/Makefile
rename to board/nxp/common/p_corenet/Makefile
diff --git a/board/freescale/common/p_corenet/law.c b/board/nxp/common/p_corenet/law.c
similarity index 100%
rename from board/freescale/common/p_corenet/law.c
rename to board/nxp/common/p_corenet/law.c
diff --git a/board/freescale/common/p_corenet/tlb.c b/board/nxp/common/p_corenet/tlb.c
similarity index 100%
rename from board/freescale/common/p_corenet/tlb.c
rename to board/nxp/common/p_corenet/tlb.c
diff --git a/board/freescale/common/pfuze.c b/board/nxp/common/pfuze.c
similarity index 100%
rename from board/freescale/common/pfuze.c
rename to board/nxp/common/pfuze.c
diff --git a/board/freescale/common/pfuze.h b/board/nxp/common/pfuze.h
similarity index 100%
rename from board/freescale/common/pfuze.h
rename to board/nxp/common/pfuze.h
diff --git a/board/freescale/common/qixis.c b/board/nxp/common/qixis.c
similarity index 100%
rename from board/freescale/common/qixis.c
rename to board/nxp/common/qixis.c
diff --git a/board/freescale/common/qixis.h b/board/nxp/common/qixis.h
similarity index 100%
rename from board/freescale/common/qixis.h
rename to board/nxp/common/qixis.h
diff --git a/board/freescale/common/sdhc_boot.c b/board/nxp/common/sdhc_boot.c
similarity index 100%
rename from board/freescale/common/sdhc_boot.c
rename to board/nxp/common/sdhc_boot.c
diff --git a/board/freescale/common/sgmii_riser.h b/board/nxp/common/sgmii_riser.h
similarity index 100%
rename from board/freescale/common/sgmii_riser.h
rename to board/nxp/common/sgmii_riser.h
diff --git a/board/freescale/common/sleep.h b/board/nxp/common/sleep.h
similarity index 100%
rename from board/freescale/common/sleep.h
rename to board/nxp/common/sleep.h
diff --git a/board/freescale/common/spl.h b/board/nxp/common/spl.h
similarity index 100%
rename from board/freescale/common/spl.h
rename to board/nxp/common/spl.h
diff --git a/board/freescale/common/sys_eeprom.c b/board/nxp/common/sys_eeprom.c
similarity index 100%
rename from board/freescale/common/sys_eeprom.c
rename to board/nxp/common/sys_eeprom.c
diff --git a/board/freescale/common/via.h b/board/nxp/common/via.h
similarity index 100%
rename from board/freescale/common/via.h
rename to board/nxp/common/via.h
diff --git a/board/freescale/common/vid.c b/board/nxp/common/vid.c
similarity index 100%
rename from board/freescale/common/vid.c
rename to board/nxp/common/vid.c
diff --git a/board/freescale/common/vid.h b/board/nxp/common/vid.h
similarity index 100%
rename from board/freescale/common/vid.h
rename to board/nxp/common/vid.h
diff --git a/board/freescale/common/vsc3316_3308.h b/board/nxp/common/vsc3316_3308.h
similarity index 100%
rename from board/freescale/common/vsc3316_3308.h
rename to board/nxp/common/vsc3316_3308.h
diff --git a/board/freescale/imx8mm_evk/Kconfig b/board/nxp/imx8mm_evk/Kconfig
similarity index 64%
rename from board/freescale/imx8mm_evk/Kconfig
rename to board/nxp/imx8mm_evk/Kconfig
index 24cc526b0ab..3b7025af053 100644
--- a/board/freescale/imx8mm_evk/Kconfig
+++ b/board/nxp/imx8mm_evk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "imx8mm_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8mm_evk"
 
 config IMX_CONFIG
-	default "board/freescale/imx8mm_evk/imximage-8mm-lpddr4.cfg"
+	default "board/nxp/imx8mm_evk/imximage-8mm-lpddr4.cfg"
 
 endif
diff --git a/board/freescale/imx8mm_evk/MAINTAINERS b/board/nxp/imx8mm_evk/MAINTAINERS
similarity index 84%
rename from board/freescale/imx8mm_evk/MAINTAINERS
rename to board/nxp/imx8mm_evk/MAINTAINERS
index 875adf58ee2..d63202418f9 100644
--- a/board/freescale/imx8mm_evk/MAINTAINERS
+++ b/board/nxp/imx8mm_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX8MM EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx8mm_evk/
+F:	board/nxp/imx8mm_evk/
 F:	include/configs/imx8mm_evk.h
 F:	configs/imx8mm_evk_defconfig
 F:  configs/imx8mm_evk_fspi_defconfig
diff --git a/board/freescale/imx8mm_evk/Makefile b/board/nxp/imx8mm_evk/Makefile
similarity index 100%
rename from board/freescale/imx8mm_evk/Makefile
rename to board/nxp/imx8mm_evk/Makefile
diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.c b/board/nxp/imx8mm_evk/imx8mm_evk.c
similarity index 100%
rename from board/freescale/imx8mm_evk/imx8mm_evk.c
rename to board/nxp/imx8mm_evk/imx8mm_evk.c
diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.env b/board/nxp/imx8mm_evk/imx8mm_evk.env
similarity index 100%
rename from board/freescale/imx8mm_evk/imx8mm_evk.env
rename to board/nxp/imx8mm_evk/imx8mm_evk.env
diff --git a/board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg b/board/nxp/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg
similarity index 100%
rename from board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg
rename to board/nxp/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg
diff --git a/board/freescale/imx8mm_evk/imximage-8mm-lpddr4.cfg b/board/nxp/imx8mm_evk/imximage-8mm-lpddr4.cfg
similarity index 100%
rename from board/freescale/imx8mm_evk/imximage-8mm-lpddr4.cfg
rename to board/nxp/imx8mm_evk/imximage-8mm-lpddr4.cfg
diff --git a/board/freescale/imx8mm_evk/lpddr4_timing.c b/board/nxp/imx8mm_evk/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx8mm_evk/lpddr4_timing.c
rename to board/nxp/imx8mm_evk/lpddr4_timing.c
diff --git a/board/freescale/imx8mm_evk/spl.c b/board/nxp/imx8mm_evk/spl.c
similarity index 100%
rename from board/freescale/imx8mm_evk/spl.c
rename to board/nxp/imx8mm_evk/spl.c
diff --git a/board/freescale/imx8mn_evk/Kconfig b/board/nxp/imx8mn_evk/Kconfig
similarity index 76%
rename from board/freescale/imx8mn_evk/Kconfig
rename to board/nxp/imx8mn_evk/Kconfig
index a148a9b998c..9ae21db6974 100644
--- a/board/freescale/imx8mn_evk/Kconfig
+++ b/board/nxp/imx8mn_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx8mn_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8mn_evk"
@@ -13,6 +13,6 @@ config IMX8MN_LOW_DRIVE_MODE
 	bool "Enable the low drive mode of iMX8MN on EVK board"
 
 config IMX_CONFIG
-	default "board/freescale/imx8mn_evk/imximage-8mn-ddr4.cfg"
+	default "board/nxp/imx8mn_evk/imximage-8mn-ddr4.cfg"
 
 endif
diff --git a/board/freescale/imx8mn_evk/MAINTAINERS b/board/nxp/imx8mn_evk/MAINTAINERS
similarity index 84%
rename from board/freescale/imx8mn_evk/MAINTAINERS
rename to board/nxp/imx8mn_evk/MAINTAINERS
index 6d110ccf22b..19ebfb2b1a1 100644
--- a/board/freescale/imx8mn_evk/MAINTAINERS
+++ b/board/nxp/imx8mn_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX8MN EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx8mn_evk/
+F:	board/nxp/imx8mn_evk/
 F:	include/configs/imx8mn_evk.h
 F:	configs/imx8mn_ddr4_evk_defconfig
 F:	configs/imx8mn_evk_defconfig
diff --git a/board/freescale/imx8mn_evk/Makefile b/board/nxp/imx8mn_evk/Makefile
similarity index 100%
rename from board/freescale/imx8mn_evk/Makefile
rename to board/nxp/imx8mn_evk/Makefile
diff --git a/board/freescale/imx8mn_evk/ddr4_timing.c b/board/nxp/imx8mn_evk/ddr4_timing.c
similarity index 100%
rename from board/freescale/imx8mn_evk/ddr4_timing.c
rename to board/nxp/imx8mn_evk/ddr4_timing.c
diff --git a/board/freescale/imx8mn_evk/ddr4_timing_ld.c b/board/nxp/imx8mn_evk/ddr4_timing_ld.c
similarity index 100%
rename from board/freescale/imx8mn_evk/ddr4_timing_ld.c
rename to board/nxp/imx8mn_evk/ddr4_timing_ld.c
diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/nxp/imx8mn_evk/imx8mn_evk.c
similarity index 100%
rename from board/freescale/imx8mn_evk/imx8mn_evk.c
rename to board/nxp/imx8mn_evk/imx8mn_evk.c
diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.env b/board/nxp/imx8mn_evk/imx8mn_evk.env
similarity index 100%
rename from board/freescale/imx8mn_evk/imx8mn_evk.env
rename to board/nxp/imx8mn_evk/imx8mn_evk.env
diff --git a/board/freescale/imx8mn_evk/imximage-8mn-ddr4.cfg b/board/nxp/imx8mn_evk/imximage-8mn-ddr4.cfg
similarity index 100%
rename from board/freescale/imx8mn_evk/imximage-8mn-ddr4.cfg
rename to board/nxp/imx8mn_evk/imximage-8mn-ddr4.cfg
diff --git a/board/freescale/imx8mn_evk/lpddr4_timing.c b/board/nxp/imx8mn_evk/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx8mn_evk/lpddr4_timing.c
rename to board/nxp/imx8mn_evk/lpddr4_timing.c
diff --git a/board/freescale/imx8mn_evk/lpddr4_timing_ld.c b/board/nxp/imx8mn_evk/lpddr4_timing_ld.c
similarity index 100%
rename from board/freescale/imx8mn_evk/lpddr4_timing_ld.c
rename to board/nxp/imx8mn_evk/lpddr4_timing_ld.c
diff --git a/board/freescale/imx8mn_evk/spl.c b/board/nxp/imx8mn_evk/spl.c
similarity index 100%
rename from board/freescale/imx8mn_evk/spl.c
rename to board/nxp/imx8mn_evk/spl.c
diff --git a/board/freescale/imx8mp_evk/Kconfig b/board/nxp/imx8mp_evk/Kconfig
similarity index 64%
rename from board/freescale/imx8mp_evk/Kconfig
rename to board/nxp/imx8mp_evk/Kconfig
index cafa6329a40..2dfbc2c6786 100644
--- a/board/freescale/imx8mp_evk/Kconfig
+++ b/board/nxp/imx8mp_evk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "imx8mp_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8mp_evk"
 
 config IMX_CONFIG
-	default "board/freescale/imx8mp_evk/imximage-8mp-lpddr4.cfg"
+	default "board/nxp/imx8mp_evk/imximage-8mp-lpddr4.cfg"
 
 endif
diff --git a/board/freescale/imx8mp_evk/MAINTAINERS b/board/nxp/imx8mp_evk/MAINTAINERS
similarity index 84%
rename from board/freescale/imx8mp_evk/MAINTAINERS
rename to board/nxp/imx8mp_evk/MAINTAINERS
index 4419527b8bc..4d4e8add9ac 100644
--- a/board/freescale/imx8mp_evk/MAINTAINERS
+++ b/board/nxp/imx8mp_evk/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8MP EVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx8mp_evk/
+F:	board/nxp/imx8mp_evk/
 F:	include/configs/imx8mp_evk.h
 F:	configs/imx8mp_evk_defconfig
diff --git a/board/freescale/imx8mp_evk/Makefile b/board/nxp/imx8mp_evk/Makefile
similarity index 100%
rename from board/freescale/imx8mp_evk/Makefile
rename to board/nxp/imx8mp_evk/Makefile
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/nxp/imx8mp_evk/imx8mp_evk.c
similarity index 100%
rename from board/freescale/imx8mp_evk/imx8mp_evk.c
rename to board/nxp/imx8mp_evk/imx8mp_evk.c
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.env b/board/nxp/imx8mp_evk/imx8mp_evk.env
similarity index 100%
rename from board/freescale/imx8mp_evk/imx8mp_evk.env
rename to board/nxp/imx8mp_evk/imx8mp_evk.env
diff --git a/board/freescale/imx8mp_evk/imximage-8mp-lpddr4.cfg b/board/nxp/imx8mp_evk/imximage-8mp-lpddr4.cfg
similarity index 100%
rename from board/freescale/imx8mp_evk/imximage-8mp-lpddr4.cfg
rename to board/nxp/imx8mp_evk/imximage-8mp-lpddr4.cfg
diff --git a/board/freescale/imx8mp_evk/lpddr4_timing.c b/board/nxp/imx8mp_evk/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx8mp_evk/lpddr4_timing.c
rename to board/nxp/imx8mp_evk/lpddr4_timing.c
diff --git a/board/freescale/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
similarity index 100%
rename from board/freescale/imx8mp_evk/spl.c
rename to board/nxp/imx8mp_evk/spl.c
diff --git a/board/freescale/imx8mq_evk/Kconfig b/board/nxp/imx8mq_evk/Kconfig
similarity index 90%
rename from board/freescale/imx8mq_evk/Kconfig
rename to board/nxp/imx8mq_evk/Kconfig
index c4d20ad7c7d..dd5c58a9d0f 100644
--- a/board/freescale/imx8mq_evk/Kconfig
+++ b/board/nxp/imx8mq_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx8mq_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8mq_evk"
diff --git a/board/freescale/imx8mq_evk/MAINTAINERS b/board/nxp/imx8mq_evk/MAINTAINERS
similarity index 84%
rename from board/freescale/imx8mq_evk/MAINTAINERS
rename to board/nxp/imx8mq_evk/MAINTAINERS
index a00bb4ef786..2fd584ea97c 100644
--- a/board/freescale/imx8mq_evk/MAINTAINERS
+++ b/board/nxp/imx8mq_evk/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8MQ EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/imx8mq_evk/
+F:	board/nxp/imx8mq_evk/
 F:	include/configs/imx8mq_evk.h
 F:	configs/imx8mq_evk_defconfig
diff --git a/board/freescale/imx8mq_evk/Makefile b/board/nxp/imx8mq_evk/Makefile
similarity index 100%
rename from board/freescale/imx8mq_evk/Makefile
rename to board/nxp/imx8mq_evk/Makefile
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/nxp/imx8mq_evk/imx8mq_evk.c
similarity index 100%
rename from board/freescale/imx8mq_evk/imx8mq_evk.c
rename to board/nxp/imx8mq_evk/imx8mq_evk.c
diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.env b/board/nxp/imx8mq_evk/imx8mq_evk.env
similarity index 100%
rename from board/freescale/imx8mq_evk/imx8mq_evk.env
rename to board/nxp/imx8mq_evk/imx8mq_evk.env
diff --git a/board/freescale/imx8mq_evk/lpddr4_timing.c b/board/nxp/imx8mq_evk/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx8mq_evk/lpddr4_timing.c
rename to board/nxp/imx8mq_evk/lpddr4_timing.c
diff --git a/board/freescale/imx8mq_evk/lpddr4_timing_b0.c b/board/nxp/imx8mq_evk/lpddr4_timing_b0.c
similarity index 100%
rename from board/freescale/imx8mq_evk/lpddr4_timing_b0.c
rename to board/nxp/imx8mq_evk/lpddr4_timing_b0.c
diff --git a/board/freescale/imx8mq_evk/spl.c b/board/nxp/imx8mq_evk/spl.c
similarity index 100%
rename from board/freescale/imx8mq_evk/spl.c
rename to board/nxp/imx8mq_evk/spl.c
diff --git a/board/freescale/imx8qm_mek/Kconfig b/board/nxp/imx8qm_mek/Kconfig
similarity index 67%
rename from board/freescale/imx8qm_mek/Kconfig
rename to board/nxp/imx8qm_mek/Kconfig
index 5f2413f8dbf..789de0f1a07 100644
--- a/board/freescale/imx8qm_mek/Kconfig
+++ b/board/nxp/imx8qm_mek/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "imx8qm_mek"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8qm_mek"
 
 config IMX_CONFIG
-	default "board/freescale/imx8qm_mek/imximage.cfg"
+	default "board/nxp/imx8qm_mek/imximage.cfg"
 
 endif
diff --git a/board/freescale/imx8qm_mek/MAINTAINERS b/board/nxp/imx8qm_mek/MAINTAINERS
similarity index 80%
rename from board/freescale/imx8qm_mek/MAINTAINERS
rename to board/nxp/imx8qm_mek/MAINTAINERS
index 115830df19b..b3b4f9b9c23 100644
--- a/board/freescale/imx8qm_mek/MAINTAINERS
+++ b/board/nxp/imx8qm_mek/MAINTAINERS
@@ -1,6 +1,6 @@
 i.MX8QM MEK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx8qm_mek/
+F:	board/nxp/imx8qm_mek/
 F:	include/configs/imx8qm_mek.h
 F:	configs/imx8qm_mek_defconfig
diff --git a/board/freescale/imx8qm_mek/Makefile b/board/nxp/imx8qm_mek/Makefile
similarity index 100%
rename from board/freescale/imx8qm_mek/Makefile
rename to board/nxp/imx8qm_mek/Makefile
diff --git a/board/freescale/imx8qm_mek/README b/board/nxp/imx8qm_mek/README
similarity index 100%
rename from board/freescale/imx8qm_mek/README
rename to board/nxp/imx8qm_mek/README
diff --git a/board/freescale/imx8qm_mek/imx8qm_mek.c b/board/nxp/imx8qm_mek/imx8qm_mek.c
similarity index 100%
rename from board/freescale/imx8qm_mek/imx8qm_mek.c
rename to board/nxp/imx8qm_mek/imx8qm_mek.c
diff --git a/board/freescale/imx8qm_mek/imximage.cfg b/board/nxp/imx8qm_mek/imximage.cfg
similarity index 100%
rename from board/freescale/imx8qm_mek/imximage.cfg
rename to board/nxp/imx8qm_mek/imximage.cfg
diff --git a/board/freescale/imx8qm_mek/spl.c b/board/nxp/imx8qm_mek/spl.c
similarity index 100%
rename from board/freescale/imx8qm_mek/spl.c
rename to board/nxp/imx8qm_mek/spl.c
diff --git a/board/freescale/imx8qm_mek/uboot-container.cfg b/board/nxp/imx8qm_mek/uboot-container.cfg
similarity index 100%
rename from board/freescale/imx8qm_mek/uboot-container.cfg
rename to board/nxp/imx8qm_mek/uboot-container.cfg
diff --git a/board/freescale/imx8qxp_mek/Kconfig b/board/nxp/imx8qxp_mek/Kconfig
similarity index 67%
rename from board/freescale/imx8qxp_mek/Kconfig
rename to board/nxp/imx8qxp_mek/Kconfig
index 6533b4d9535..3d0b13061e0 100644
--- a/board/freescale/imx8qxp_mek/Kconfig
+++ b/board/nxp/imx8qxp_mek/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "imx8qxp_mek"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8qxp_mek"
 
 config IMX_CONFIG
-	default "board/freescale/imx8qxp_mek/imximage.cfg"
+	default "board/nxp/imx8qxp_mek/imximage.cfg"
 
 endif
diff --git a/board/freescale/imx8qxp_mek/MAINTAINERS b/board/nxp/imx8qxp_mek/MAINTAINERS
similarity index 84%
rename from board/freescale/imx8qxp_mek/MAINTAINERS
rename to board/nxp/imx8qxp_mek/MAINTAINERS
index 3a21f5521d8..4e8fbd15876 100644
--- a/board/freescale/imx8qxp_mek/MAINTAINERS
+++ b/board/nxp/imx8qxp_mek/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8QXP MEK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/imx8qxp_mek/
+F:	board/nxp/imx8qxp_mek/
 F:	include/configs/imx8qxp_mek.h
 F:	configs/imx8qxp_mek_defconfig
diff --git a/board/freescale/imx8qxp_mek/Makefile b/board/nxp/imx8qxp_mek/Makefile
similarity index 100%
rename from board/freescale/imx8qxp_mek/Makefile
rename to board/nxp/imx8qxp_mek/Makefile
diff --git a/board/freescale/imx8qxp_mek/imx8qxp_mek.c b/board/nxp/imx8qxp_mek/imx8qxp_mek.c
similarity index 100%
rename from board/freescale/imx8qxp_mek/imx8qxp_mek.c
rename to board/nxp/imx8qxp_mek/imx8qxp_mek.c
diff --git a/board/freescale/imx8qxp_mek/imximage.cfg b/board/nxp/imx8qxp_mek/imximage.cfg
similarity index 100%
rename from board/freescale/imx8qxp_mek/imximage.cfg
rename to board/nxp/imx8qxp_mek/imximage.cfg
diff --git a/board/freescale/imx8qxp_mek/spl.c b/board/nxp/imx8qxp_mek/spl.c
similarity index 100%
rename from board/freescale/imx8qxp_mek/spl.c
rename to board/nxp/imx8qxp_mek/spl.c
diff --git a/board/freescale/imx8qxp_mek/uboot-container.cfg b/board/nxp/imx8qxp_mek/uboot-container.cfg
similarity index 100%
rename from board/freescale/imx8qxp_mek/uboot-container.cfg
rename to board/nxp/imx8qxp_mek/uboot-container.cfg
diff --git a/board/freescale/imx8ulp_evk/Kconfig b/board/nxp/imx8ulp_evk/Kconfig
similarity index 86%
rename from board/freescale/imx8ulp_evk/Kconfig
rename to board/nxp/imx8ulp_evk/Kconfig
index 4637b969be6..c6c48a30f09 100644
--- a/board/freescale/imx8ulp_evk/Kconfig
+++ b/board/nxp/imx8ulp_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx8ulp_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx8ulp_evk"
diff --git a/board/freescale/imx8ulp_evk/MAINTAINERS b/board/nxp/imx8ulp_evk/MAINTAINERS
similarity index 80%
rename from board/freescale/imx8ulp_evk/MAINTAINERS
rename to board/nxp/imx8ulp_evk/MAINTAINERS
index 267b7b0caa5..67f725b5c54 100644
--- a/board/freescale/imx8ulp_evk/MAINTAINERS
+++ b/board/nxp/imx8ulp_evk/MAINTAINERS
@@ -1,6 +1,6 @@
 i.MX8ULP EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx8ulp_evk/
+F:	board/nxp/imx8ulp_evk/
 F:	include/configs/imx8ulp_evk.h
 F:	configs/imx8ulp_evk_defconfig
diff --git a/board/freescale/imx8ulp_evk/Makefile b/board/nxp/imx8ulp_evk/Makefile
similarity index 100%
rename from board/freescale/imx8ulp_evk/Makefile
rename to board/nxp/imx8ulp_evk/Makefile
diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
similarity index 100%
rename from board/freescale/imx8ulp_evk/imx8ulp_evk.c
rename to board/nxp/imx8ulp_evk/imx8ulp_evk.c
diff --git a/board/freescale/imx8ulp_evk/lpddr4_timing.c b/board/nxp/imx8ulp_evk/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx8ulp_evk/lpddr4_timing.c
rename to board/nxp/imx8ulp_evk/lpddr4_timing.c
diff --git a/board/freescale/imx8ulp_evk/lpddr4_timing_266.c b/board/nxp/imx8ulp_evk/lpddr4_timing_266.c
similarity index 100%
rename from board/freescale/imx8ulp_evk/lpddr4_timing_266.c
rename to board/nxp/imx8ulp_evk/lpddr4_timing_266.c
diff --git a/board/freescale/imx8ulp_evk/spl.c b/board/nxp/imx8ulp_evk/spl.c
similarity index 100%
rename from board/freescale/imx8ulp_evk/spl.c
rename to board/nxp/imx8ulp_evk/spl.c
diff --git a/board/freescale/imx91_evk/Kconfig b/board/nxp/imx91_evk/Kconfig
similarity index 93%
rename from board/freescale/imx91_evk/Kconfig
rename to board/nxp/imx91_evk/Kconfig
index caaa82b4af8..07baf63932c 100644
--- a/board/freescale/imx91_evk/Kconfig
+++ b/board/nxp/imx91_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx91_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx91_evk"
diff --git a/board/freescale/imx91_evk/MAINTAINERS b/board/nxp/imx91_evk/MAINTAINERS
similarity index 85%
rename from board/freescale/imx91_evk/MAINTAINERS
rename to board/nxp/imx91_evk/MAINTAINERS
index f7d39bfb0a3..ed701dd6838 100644
--- a/board/freescale/imx91_evk/MAINTAINERS
+++ b/board/nxp/imx91_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX91 11x11 EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx91_evk/
+F:	board/nxp/imx91_evk/
 F:	include/configs/imx91_evk.h
 F:	configs/imx91_11x11_evk_defconfig
 F:	configs/imx91_11x11_evk_inline_ecc_defconfig
diff --git a/board/freescale/imx91_evk/Makefile b/board/nxp/imx91_evk/Makefile
similarity index 100%
rename from board/freescale/imx91_evk/Makefile
rename to board/nxp/imx91_evk/Makefile
diff --git a/board/freescale/imx91_evk/imx91_evk.c b/board/nxp/imx91_evk/imx91_evk.c
similarity index 100%
rename from board/freescale/imx91_evk/imx91_evk.c
rename to board/nxp/imx91_evk/imx91_evk.c
diff --git a/board/freescale/imx91_evk/imx91_evk.env b/board/nxp/imx91_evk/imx91_evk.env
similarity index 100%
rename from board/freescale/imx91_evk/imx91_evk.env
rename to board/nxp/imx91_evk/imx91_evk.env
diff --git a/board/freescale/imx91_evk/lpddr4_timing_1600mts.c b/board/nxp/imx91_evk/lpddr4_timing_1600mts.c
similarity index 100%
rename from board/freescale/imx91_evk/lpddr4_timing_1600mts.c
rename to board/nxp/imx91_evk/lpddr4_timing_1600mts.c
diff --git a/board/freescale/imx91_evk/lpddr4_timing_1600mts_ecc.c b/board/nxp/imx91_evk/lpddr4_timing_1600mts_ecc.c
similarity index 100%
rename from board/freescale/imx91_evk/lpddr4_timing_1600mts_ecc.c
rename to board/nxp/imx91_evk/lpddr4_timing_1600mts_ecc.c
diff --git a/board/freescale/imx91_evk/lpddr4_timing_2400mts.c b/board/nxp/imx91_evk/lpddr4_timing_2400mts.c
similarity index 100%
rename from board/freescale/imx91_evk/lpddr4_timing_2400mts.c
rename to board/nxp/imx91_evk/lpddr4_timing_2400mts.c
diff --git a/board/freescale/imx91_evk/lpddr4_timing_2400mts_ecc.c b/board/nxp/imx91_evk/lpddr4_timing_2400mts_ecc.c
similarity index 100%
rename from board/freescale/imx91_evk/lpddr4_timing_2400mts_ecc.c
rename to board/nxp/imx91_evk/lpddr4_timing_2400mts_ecc.c
diff --git a/board/freescale/imx91_evk/spl.c b/board/nxp/imx91_evk/spl.c
similarity index 100%
rename from board/freescale/imx91_evk/spl.c
rename to board/nxp/imx91_evk/spl.c
diff --git a/board/freescale/imx93_evk/Kconfig b/board/nxp/imx93_evk/Kconfig
similarity index 93%
rename from board/freescale/imx93_evk/Kconfig
rename to board/nxp/imx93_evk/Kconfig
index 821144c9382..305c3963f06 100644
--- a/board/freescale/imx93_evk/Kconfig
+++ b/board/nxp/imx93_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx93_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx93_evk"
diff --git a/board/freescale/imx93_evk/MAINTAINERS b/board/nxp/imx93_evk/MAINTAINERS
similarity index 85%
rename from board/freescale/imx93_evk/MAINTAINERS
rename to board/nxp/imx93_evk/MAINTAINERS
index eb6e669bd17..da0540307c6 100644
--- a/board/freescale/imx93_evk/MAINTAINERS
+++ b/board/nxp/imx93_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX93 EVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx93_evk/
+F:	board/nxp/imx93_evk/
 F:	include/configs/imx93_evk.h
 F:	configs/imx93_11x11_evk_defconfig
 F:	configs/imx93_11x11_evk_ld_defconfig
diff --git a/board/freescale/imx93_evk/Makefile b/board/nxp/imx93_evk/Makefile
similarity index 100%
rename from board/freescale/imx93_evk/Makefile
rename to board/nxp/imx93_evk/Makefile
diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/nxp/imx93_evk/imx93_evk.c
similarity index 100%
rename from board/freescale/imx93_evk/imx93_evk.c
rename to board/nxp/imx93_evk/imx93_evk.c
diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/nxp/imx93_evk/imx93_evk.env
similarity index 100%
rename from board/freescale/imx93_evk/imx93_evk.env
rename to board/nxp/imx93_evk/imx93_evk.env
diff --git a/board/freescale/imx93_evk/lpddr4x_timing.c b/board/nxp/imx93_evk/lpddr4x_timing.c
similarity index 100%
rename from board/freescale/imx93_evk/lpddr4x_timing.c
rename to board/nxp/imx93_evk/lpddr4x_timing.c
diff --git a/board/freescale/imx93_evk/lpddr4x_timing_1866mts.c b/board/nxp/imx93_evk/lpddr4x_timing_1866mts.c
similarity index 100%
rename from board/freescale/imx93_evk/lpddr4x_timing_1866mts.c
rename to board/nxp/imx93_evk/lpddr4x_timing_1866mts.c
diff --git a/board/freescale/imx93_evk/spl.c b/board/nxp/imx93_evk/spl.c
similarity index 100%
rename from board/freescale/imx93_evk/spl.c
rename to board/nxp/imx93_evk/spl.c
diff --git a/board/freescale/imx93_frdm/Kconfig b/board/nxp/imx93_frdm/Kconfig
similarity index 86%
rename from board/freescale/imx93_frdm/Kconfig
rename to board/nxp/imx93_frdm/Kconfig
index 5f5ac7f8f04..d0610bce77e 100644
--- a/board/freescale/imx93_frdm/Kconfig
+++ b/board/nxp/imx93_frdm/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx93_frdm"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx93_frdm"
diff --git a/board/freescale/imx93_frdm/MAINTAINERS b/board/nxp/imx93_frdm/MAINTAINERS
similarity index 81%
rename from board/freescale/imx93_frdm/MAINTAINERS
rename to board/nxp/imx93_frdm/MAINTAINERS
index 59595bb2118..72b5daffb39 100644
--- a/board/freescale/imx93_frdm/MAINTAINERS
+++ b/board/nxp/imx93_frdm/MAINTAINERS
@@ -1,6 +1,6 @@
 i.MX93 FRDM BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/imx93_frdm/
+F:	board/nxp/imx93_frdm/
 F:	include/configs/imx93_frdm.h
 F:	configs/imx93_frdm_defconfig
diff --git a/board/freescale/imx93_frdm/Makefile b/board/nxp/imx93_frdm/Makefile
similarity index 100%
rename from board/freescale/imx93_frdm/Makefile
rename to board/nxp/imx93_frdm/Makefile
diff --git a/board/freescale/imx93_frdm/imx93_frdm.c b/board/nxp/imx93_frdm/imx93_frdm.c
similarity index 100%
rename from board/freescale/imx93_frdm/imx93_frdm.c
rename to board/nxp/imx93_frdm/imx93_frdm.c
diff --git a/board/freescale/imx93_frdm/imx93_frdm.env b/board/nxp/imx93_frdm/imx93_frdm.env
similarity index 100%
rename from board/freescale/imx93_frdm/imx93_frdm.env
rename to board/nxp/imx93_frdm/imx93_frdm.env
diff --git a/board/freescale/imx93_frdm/lpddr4_timing.h b/board/nxp/imx93_frdm/lpddr4_timing.h
similarity index 100%
rename from board/freescale/imx93_frdm/lpddr4_timing.h
rename to board/nxp/imx93_frdm/lpddr4_timing.h
diff --git a/board/freescale/imx93_frdm/lpddr4x_1gb_timing.c b/board/nxp/imx93_frdm/lpddr4x_1gb_timing.c
similarity index 100%
rename from board/freescale/imx93_frdm/lpddr4x_1gb_timing.c
rename to board/nxp/imx93_frdm/lpddr4x_1gb_timing.c
diff --git a/board/freescale/imx93_frdm/lpddr4x_2gb_timing.c b/board/nxp/imx93_frdm/lpddr4x_2gb_timing.c
similarity index 100%
rename from board/freescale/imx93_frdm/lpddr4x_2gb_timing.c
rename to board/nxp/imx93_frdm/lpddr4x_2gb_timing.c
diff --git a/board/freescale/imx93_frdm/spl.c b/board/nxp/imx93_frdm/spl.c
similarity index 100%
rename from board/freescale/imx93_frdm/spl.c
rename to board/nxp/imx93_frdm/spl.c
diff --git a/board/freescale/imx93_qsb/Kconfig b/board/nxp/imx93_qsb/Kconfig
similarity index 86%
rename from board/freescale/imx93_qsb/Kconfig
rename to board/nxp/imx93_qsb/Kconfig
index fea69c85870..e619014a741 100644
--- a/board/freescale/imx93_qsb/Kconfig
+++ b/board/nxp/imx93_qsb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx93_qsb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx93_qsb"
diff --git a/board/freescale/imx93_qsb/MAINTAINERS b/board/nxp/imx93_qsb/MAINTAINERS
similarity index 85%
rename from board/freescale/imx93_qsb/MAINTAINERS
rename to board/nxp/imx93_qsb/MAINTAINERS
index a3247d17e7c..11226c7ef8b 100644
--- a/board/freescale/imx93_qsb/MAINTAINERS
+++ b/board/nxp/imx93_qsb/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX93 QSB BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/imx93_qsb/
+F:	board/nxp/imx93_qsb/
 F:	include/configs/imx93_qsb.h
 F:	configs/imx93_9x9_qsb_defconfig
 F:	configs/imx93_9x9_qsb_inline_ecc_defconfig
diff --git a/board/freescale/imx93_qsb/Makefile b/board/nxp/imx93_qsb/Makefile
similarity index 100%
rename from board/freescale/imx93_qsb/Makefile
rename to board/nxp/imx93_qsb/Makefile
diff --git a/board/freescale/imx93_qsb/imx93_qsb.c b/board/nxp/imx93_qsb/imx93_qsb.c
similarity index 100%
rename from board/freescale/imx93_qsb/imx93_qsb.c
rename to board/nxp/imx93_qsb/imx93_qsb.c
diff --git a/board/freescale/imx93_qsb/imx93_qsb.env b/board/nxp/imx93_qsb/imx93_qsb.env
similarity index 100%
rename from board/freescale/imx93_qsb/imx93_qsb.env
rename to board/nxp/imx93_qsb/imx93_qsb.env
diff --git a/board/freescale/imx93_qsb/lpddr4_timing.c b/board/nxp/imx93_qsb/lpddr4_timing.c
similarity index 100%
rename from board/freescale/imx93_qsb/lpddr4_timing.c
rename to board/nxp/imx93_qsb/lpddr4_timing.c
diff --git a/board/freescale/imx93_qsb/lpddr4_timing_ecc.c b/board/nxp/imx93_qsb/lpddr4_timing_ecc.c
similarity index 100%
rename from board/freescale/imx93_qsb/lpddr4_timing_ecc.c
rename to board/nxp/imx93_qsb/lpddr4_timing_ecc.c
diff --git a/board/freescale/imx93_qsb/spl.c b/board/nxp/imx93_qsb/spl.c
similarity index 100%
rename from board/freescale/imx93_qsb/spl.c
rename to board/nxp/imx93_qsb/spl.c
diff --git a/board/freescale/imx94_evk/Kconfig b/board/nxp/imx94_evk/Kconfig
similarity index 86%
rename from board/freescale/imx94_evk/Kconfig
rename to board/nxp/imx94_evk/Kconfig
index a4237244ace..377b732c3e7 100644
--- a/board/freescale/imx94_evk/Kconfig
+++ b/board/nxp/imx94_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx94_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx94_evk"
diff --git a/board/freescale/imx94_evk/MAINTAINERS b/board/nxp/imx94_evk/MAINTAINERS
similarity index 80%
rename from board/freescale/imx94_evk/MAINTAINERS
rename to board/nxp/imx94_evk/MAINTAINERS
index 95309430734..a7aab5f3905 100644
--- a/board/freescale/imx94_evk/MAINTAINERS
+++ b/board/nxp/imx94_evk/MAINTAINERS
@@ -1,6 +1,6 @@
 i.MX94 EVK BOARD
 M:	Alice Guo <alice.guo@nxp.com>
 S:	Maintained
-F:	board/freescale/imx94_evk/
+F:	board/nxp/imx94_evk/
 F:	include/configs/imx94_evk.h
 F:	configs/imx943_evk_defconfig
diff --git a/board/freescale/imx94_evk/Makefile b/board/nxp/imx94_evk/Makefile
similarity index 100%
rename from board/freescale/imx94_evk/Makefile
rename to board/nxp/imx94_evk/Makefile
diff --git a/board/freescale/imx94_evk/imx94_evk.c b/board/nxp/imx94_evk/imx94_evk.c
similarity index 100%
rename from board/freescale/imx94_evk/imx94_evk.c
rename to board/nxp/imx94_evk/imx94_evk.c
diff --git a/board/freescale/imx94_evk/imx94_evk.env b/board/nxp/imx94_evk/imx94_evk.env
similarity index 100%
rename from board/freescale/imx94_evk/imx94_evk.env
rename to board/nxp/imx94_evk/imx94_evk.env
diff --git a/board/freescale/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
similarity index 100%
rename from board/freescale/imx94_evk/spl.c
rename to board/nxp/imx94_evk/spl.c
diff --git a/board/freescale/imx95_evk/Kconfig b/board/nxp/imx95_evk/Kconfig
similarity index 88%
rename from board/freescale/imx95_evk/Kconfig
rename to board/nxp/imx95_evk/Kconfig
index bf746e091de..fb255eda731 100644
--- a/board/freescale/imx95_evk/Kconfig
+++ b/board/nxp/imx95_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imx95_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "imx95_evk"
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/nxp/imx95_evk/MAINTAINERS
similarity index 87%
rename from board/freescale/imx95_evk/MAINTAINERS
rename to board/nxp/imx95_evk/MAINTAINERS
index bc27786f70d..e228b04d918 100644
--- a/board/freescale/imx95_evk/MAINTAINERS
+++ b/board/nxp/imx95_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 i.MX95 EVK BOARD
 M:	Alice Guo <alice.guo@nxp.com>
 S:	Maintained
-F:	board/freescale/imx95_evk/
+F:	board/nxp/imx95_evk/
 F:	include/configs/imx95_evk.h
 F:	configs/imx95_a0_19x19_evk_defconfig
 F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/nxp/imx95_evk/Makefile
similarity index 100%
rename from board/freescale/imx95_evk/Makefile
rename to board/nxp/imx95_evk/Makefile
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
similarity index 100%
rename from board/freescale/imx95_evk/imx95_evk.c
rename to board/nxp/imx95_evk/imx95_evk.c
diff --git a/board/freescale/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
similarity index 100%
rename from board/freescale/imx95_evk/spl.c
rename to board/nxp/imx95_evk/spl.c
diff --git a/board/freescale/imxrt1020-evk/Kconfig b/board/nxp/imxrt1020-evk/Kconfig
similarity index 72%
rename from board/freescale/imxrt1020-evk/Kconfig
rename to board/nxp/imxrt1020-evk/Kconfig
index 6618a9b3b57..d5b7702b686 100644
--- a/board/freescale/imxrt1020-evk/Kconfig
+++ b/board/nxp/imxrt1020-evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imxrt1020-evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "imxrt1020"
@@ -13,6 +13,6 @@ config SYS_CONFIG_NAME
 	default "imxrt1020-evk"
 
 config IMX_CONFIG
-	default "board/freescale/imxrt1020-evk/imximage.cfg"
+	default "board/nxp/imxrt1020-evk/imximage.cfg"
 
 endif
diff --git a/board/freescale/imxrt1020-evk/MAINTAINERS b/board/nxp/imxrt1020-evk/MAINTAINERS
similarity index 83%
rename from board/freescale/imxrt1020-evk/MAINTAINERS
rename to board/nxp/imxrt1020-evk/MAINTAINERS
index 05f017b2bab..a587e5d0f68 100644
--- a/board/freescale/imxrt1020-evk/MAINTAINERS
+++ b/board/nxp/imxrt1020-evk/MAINTAINERS
@@ -1,6 +1,6 @@
 IMXRT1020 EVALUATION KIT
 M:	Giulio Benetti <giulio.benetti@benettiengineering.com>
 S:	Maintained
-F:	board/freescale/imxrt1020-evk
+F:	board/nxp/imxrt1020-evk
 F:	include/configs/imxrt1020-evk.h
 F:	configs/imxrt1020-evk_defconfig
diff --git a/board/freescale/imxrt1020-evk/Makefile b/board/nxp/imxrt1020-evk/Makefile
similarity index 100%
rename from board/freescale/imxrt1020-evk/Makefile
rename to board/nxp/imxrt1020-evk/Makefile
diff --git a/board/freescale/imxrt1020-evk/imximage.cfg b/board/nxp/imxrt1020-evk/imximage.cfg
similarity index 100%
rename from board/freescale/imxrt1020-evk/imximage.cfg
rename to board/nxp/imxrt1020-evk/imximage.cfg
diff --git a/board/freescale/imxrt1020-evk/imxrt1020-evk.c b/board/nxp/imxrt1020-evk/imxrt1020-evk.c
similarity index 100%
rename from board/freescale/imxrt1020-evk/imxrt1020-evk.c
rename to board/nxp/imxrt1020-evk/imxrt1020-evk.c
diff --git a/board/freescale/imxrt1050-evk/Kconfig b/board/nxp/imxrt1050-evk/Kconfig
similarity index 72%
rename from board/freescale/imxrt1050-evk/Kconfig
rename to board/nxp/imxrt1050-evk/Kconfig
index 04ade6ec900..8dd7511c0c8 100644
--- a/board/freescale/imxrt1050-evk/Kconfig
+++ b/board/nxp/imxrt1050-evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imxrt1050-evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "imxrt1050"
@@ -13,6 +13,6 @@ config SYS_CONFIG_NAME
 	default "imxrt1050-evk"
 
 config IMX_CONFIG
-	default "board/freescale/imxrt1050-evk/imximage.cfg"
+	default "board/nxp/imxrt1050-evk/imximage.cfg"
 
 endif
diff --git a/board/freescale/imxrt1050-evk/MAINTAINERS b/board/nxp/imxrt1050-evk/MAINTAINERS
similarity index 86%
rename from board/freescale/imxrt1050-evk/MAINTAINERS
rename to board/nxp/imxrt1050-evk/MAINTAINERS
index 890825b39ae..9c0e6cfb3bb 100644
--- a/board/freescale/imxrt1050-evk/MAINTAINERS
+++ b/board/nxp/imxrt1050-evk/MAINTAINERS
@@ -1,7 +1,7 @@
 IMXRT1050 EVALUATION KIT
 M:	Giulio Benetti <giulio.benetti@benettiengineering.com>
 S:	Maintained
-F:	board/freescale/imxrt1050-evk
+F:	board/nxp/imxrt1050-evk
 F:	include/configs/imxrt1050-evk.h
 F:	configs/imxrt1050-evk_defconfig
 F:	configs/imxrt1050-evk_fspi_defconfig
diff --git a/board/freescale/imxrt1050-evk/Makefile b/board/nxp/imxrt1050-evk/Makefile
similarity index 100%
rename from board/freescale/imxrt1050-evk/Makefile
rename to board/nxp/imxrt1050-evk/Makefile
diff --git a/board/freescale/imxrt1050-evk/imximage-nor.cfg b/board/nxp/imxrt1050-evk/imximage-nor.cfg
similarity index 100%
rename from board/freescale/imxrt1050-evk/imximage-nor.cfg
rename to board/nxp/imxrt1050-evk/imximage-nor.cfg
diff --git a/board/freescale/imxrt1050-evk/imximage.cfg b/board/nxp/imxrt1050-evk/imximage.cfg
similarity index 100%
rename from board/freescale/imxrt1050-evk/imximage.cfg
rename to board/nxp/imxrt1050-evk/imximage.cfg
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env b/board/nxp/imxrt1050-evk/imxrt1050-evk-nor.env
similarity index 100%
rename from board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env
rename to board/nxp/imxrt1050-evk/imxrt1050-evk-nor.env
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c b/board/nxp/imxrt1050-evk/imxrt1050-evk.c
similarity index 100%
rename from board/freescale/imxrt1050-evk/imxrt1050-evk.c
rename to board/nxp/imxrt1050-evk/imxrt1050-evk.c
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.env b/board/nxp/imxrt1050-evk/imxrt1050-evk.env
similarity index 100%
rename from board/freescale/imxrt1050-evk/imxrt1050-evk.env
rename to board/nxp/imxrt1050-evk/imxrt1050-evk.env
diff --git a/board/freescale/imxrt1170-evk/Kconfig b/board/nxp/imxrt1170-evk/Kconfig
similarity index 72%
rename from board/freescale/imxrt1170-evk/Kconfig
rename to board/nxp/imxrt1170-evk/Kconfig
index ad7cd4aeb9c..6f804c10893 100644
--- a/board/freescale/imxrt1170-evk/Kconfig
+++ b/board/nxp/imxrt1170-evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "imxrt1170-evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "imxrt1170"
@@ -13,6 +13,6 @@ config SYS_CONFIG_NAME
 	default "imxrt1170-evk"
 
 config IMX_CONFIG
-	default "board/freescale/imxrt1170-evk/imximage.cfg"
+	default "board/nxp/imxrt1170-evk/imximage.cfg"
 
 endif
diff --git a/board/freescale/imxrt1170-evk/MAINTAINERS b/board/nxp/imxrt1170-evk/MAINTAINERS
similarity index 86%
rename from board/freescale/imxrt1170-evk/MAINTAINERS
rename to board/nxp/imxrt1170-evk/MAINTAINERS
index 1fc3179c005..239cda84b74 100644
--- a/board/freescale/imxrt1170-evk/MAINTAINERS
+++ b/board/nxp/imxrt1170-evk/MAINTAINERS
@@ -2,6 +2,6 @@ IMXRT1170 EVALUATION KIT
 M:	Giulio Benetti <giulio.benetti@benettiengineering.com>
 M:	Jesse Taube <Mr.Bossman075@gmail.com>
 S:	Maintained
-F:	board/freescale/imxrt1170-evk
+F:	board/nxp/imxrt1170-evk
 F:	include/configs/imxrt1170-evk.h
 F:	configs/imxrt1170-evk_defconfig
diff --git a/board/freescale/imxrt1170-evk/Makefile b/board/nxp/imxrt1170-evk/Makefile
similarity index 100%
rename from board/freescale/imxrt1170-evk/Makefile
rename to board/nxp/imxrt1170-evk/Makefile
diff --git a/board/freescale/imxrt1170-evk/imximage.cfg b/board/nxp/imxrt1170-evk/imximage.cfg
similarity index 100%
rename from board/freescale/imxrt1170-evk/imximage.cfg
rename to board/nxp/imxrt1170-evk/imximage.cfg
diff --git a/board/freescale/imxrt1170-evk/imxrt1170-evk.c b/board/nxp/imxrt1170-evk/imxrt1170-evk.c
similarity index 100%
rename from board/freescale/imxrt1170-evk/imxrt1170-evk.c
rename to board/nxp/imxrt1170-evk/imxrt1170-evk.c
diff --git a/board/freescale/ls1012afrdm/Kconfig b/board/nxp/ls1012afrdm/Kconfig
similarity index 96%
rename from board/freescale/ls1012afrdm/Kconfig
rename to board/nxp/ls1012afrdm/Kconfig
index a7e59e62656..26856f2d4e4 100644
--- a/board/freescale/ls1012afrdm/Kconfig
+++ b/board/nxp/ls1012afrdm/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1012afrdm"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -54,7 +54,7 @@ config SYS_BOARD
 	default "ls1012afrdm"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1012afrdm/MAINTAINERS b/board/nxp/ls1012afrdm/MAINTAINERS
similarity index 87%
rename from board/freescale/ls1012afrdm/MAINTAINERS
rename to board/nxp/ls1012afrdm/MAINTAINERS
index 89d1085b00b..a69c268e53b 100644
--- a/board/freescale/ls1012afrdm/MAINTAINERS
+++ b/board/nxp/ls1012afrdm/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1012AFRDM BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1012afrdm/
+F:	board/nxp/ls1012afrdm/
 F:	include/configs/ls1012afrdm.h
 F:	configs/ls1012afrdm_qspi_defconfig
 F:	configs/ls1012afrdm_tfa_defconfig
@@ -11,7 +11,7 @@ F:	configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
 LS1012AFRWY BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:      Maintained
-F:      board/freescale/ls1012afrwy/
+F:      board/nxp/ls1012afrwy/
 F:      include/configs/ls1012afrwy.h
 F:      configs/ls1012afrwy_qspi_defconfig
 F:	configs/ls1012afrwy_qspi_SECURE_BOOT_defconfig
diff --git a/board/freescale/ls1012afrdm/Makefile b/board/nxp/ls1012afrdm/Makefile
similarity index 100%
rename from board/freescale/ls1012afrdm/Makefile
rename to board/nxp/ls1012afrdm/Makefile
diff --git a/board/freescale/ls1012afrdm/README b/board/nxp/ls1012afrdm/README
similarity index 100%
rename from board/freescale/ls1012afrdm/README
rename to board/nxp/ls1012afrdm/README
diff --git a/board/freescale/ls1012afrdm/eth.c b/board/nxp/ls1012afrdm/eth.c
similarity index 100%
rename from board/freescale/ls1012afrdm/eth.c
rename to board/nxp/ls1012afrdm/eth.c
diff --git a/board/freescale/ls1012afrdm/ls1012afrdm.c b/board/nxp/ls1012afrdm/ls1012afrdm.c
similarity index 100%
rename from board/freescale/ls1012afrdm/ls1012afrdm.c
rename to board/nxp/ls1012afrdm/ls1012afrdm.c
diff --git a/board/freescale/ls1012aqds/Kconfig b/board/nxp/ls1012aqds/Kconfig
similarity index 98%
rename from board/freescale/ls1012aqds/Kconfig
rename to board/nxp/ls1012aqds/Kconfig
index d333069898f..51751fc96fc 100644
--- a/board/freescale/ls1012aqds/Kconfig
+++ b/board/nxp/ls1012aqds/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1012aqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1012aqds/MAINTAINERS b/board/nxp/ls1012aqds/MAINTAINERS
similarity index 87%
rename from board/freescale/ls1012aqds/MAINTAINERS
rename to board/nxp/ls1012aqds/MAINTAINERS
index eabf5805765..2178df90992 100644
--- a/board/freescale/ls1012aqds/MAINTAINERS
+++ b/board/nxp/ls1012aqds/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1012AQDS BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1012aqds/
+F:	board/nxp/ls1012aqds/
 F:	include/configs/ls1012aqds.h
 F:	configs/ls1012aqds_qspi_defconfig
 F:	configs/ls1012aqds_tfa_defconfig
diff --git a/board/freescale/ls1012aqds/Makefile b/board/nxp/ls1012aqds/Makefile
similarity index 100%
rename from board/freescale/ls1012aqds/Makefile
rename to board/nxp/ls1012aqds/Makefile
diff --git a/board/freescale/ls1012aqds/README b/board/nxp/ls1012aqds/README
similarity index 100%
rename from board/freescale/ls1012aqds/README
rename to board/nxp/ls1012aqds/README
diff --git a/board/freescale/ls1012aqds/eth.c b/board/nxp/ls1012aqds/eth.c
similarity index 100%
rename from board/freescale/ls1012aqds/eth.c
rename to board/nxp/ls1012aqds/eth.c
diff --git a/board/freescale/ls1012aqds/ls1012aqds.c b/board/nxp/ls1012aqds/ls1012aqds.c
similarity index 100%
rename from board/freescale/ls1012aqds/ls1012aqds.c
rename to board/nxp/ls1012aqds/ls1012aqds.c
diff --git a/board/freescale/ls1012aqds/ls1012aqds_pfe.h b/board/nxp/ls1012aqds/ls1012aqds_pfe.h
similarity index 100%
rename from board/freescale/ls1012aqds/ls1012aqds_pfe.h
rename to board/nxp/ls1012aqds/ls1012aqds_pfe.h
diff --git a/board/freescale/ls1012aqds/ls1012aqds_qixis.h b/board/nxp/ls1012aqds/ls1012aqds_qixis.h
similarity index 100%
rename from board/freescale/ls1012aqds/ls1012aqds_qixis.h
rename to board/nxp/ls1012aqds/ls1012aqds_qixis.h
diff --git a/board/freescale/ls1012ardb/Kconfig b/board/nxp/ls1012ardb/Kconfig
similarity index 97%
rename from board/freescale/ls1012ardb/Kconfig
rename to board/nxp/ls1012ardb/Kconfig
index b55660d485f..bbe5ce21109 100644
--- a/board/freescale/ls1012ardb/Kconfig
+++ b/board/nxp/ls1012ardb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1012ardb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -63,7 +63,7 @@ config SYS_BOARD
         default "ls1012ardb"
 
 config SYS_VENDOR
-        default "freescale"
+        default "nxp"
 
 config SYS_SOC
         default "fsl-layerscape"
diff --git a/board/freescale/ls1012ardb/MAINTAINERS b/board/nxp/ls1012ardb/MAINTAINERS
similarity index 87%
rename from board/freescale/ls1012ardb/MAINTAINERS
rename to board/nxp/ls1012ardb/MAINTAINERS
index ce2f9a16cc7..5dd2858a86c 100644
--- a/board/freescale/ls1012ardb/MAINTAINERS
+++ b/board/nxp/ls1012ardb/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1012ARDB BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1012ardb/
+F:	board/nxp/ls1012ardb/
 F:	include/configs/ls1012ardb.h
 F:	configs/ls1012ardb_qspi_defconfig
 F:	configs/ls1012ardb_tfa_defconfig
@@ -12,6 +12,6 @@ F:	configs/ls1012ardb_qspi_SECURE_BOOT_defconfig
 LS1012A2G5RDB BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:      Maintained
-F:      board/freescale/ls1012ardb/
+F:      board/nxp/ls1012ardb/
 F:      include/configs/ls1012a2g5rdb.h
 F:      configs/ls1012a2g5rdb_qspi_defconfig
diff --git a/board/freescale/ls1012ardb/Makefile b/board/nxp/ls1012ardb/Makefile
similarity index 100%
rename from board/freescale/ls1012ardb/Makefile
rename to board/nxp/ls1012ardb/Makefile
diff --git a/board/freescale/ls1012ardb/README b/board/nxp/ls1012ardb/README
similarity index 100%
rename from board/freescale/ls1012ardb/README
rename to board/nxp/ls1012ardb/README
diff --git a/board/freescale/ls1012ardb/eth.c b/board/nxp/ls1012ardb/eth.c
similarity index 100%
rename from board/freescale/ls1012ardb/eth.c
rename to board/nxp/ls1012ardb/eth.c
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/nxp/ls1012ardb/ls1012ardb.c
similarity index 100%
rename from board/freescale/ls1012ardb/ls1012ardb.c
rename to board/nxp/ls1012ardb/ls1012ardb.c
diff --git a/board/freescale/ls1021aiot/Kconfig b/board/nxp/ls1021aiot/Kconfig
similarity index 88%
rename from board/freescale/ls1021aiot/Kconfig
rename to board/nxp/ls1021aiot/Kconfig
index 4a12c1687fc..52e6e73f3b6 100644
--- a/board/freescale/ls1021aiot/Kconfig
+++ b/board/nxp/ls1021aiot/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1021aiot"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "ls102xa"
diff --git a/board/freescale/ls1021aiot/MAINTAINERS b/board/nxp/ls1021aiot/MAINTAINERS
similarity index 85%
rename from board/freescale/ls1021aiot/MAINTAINERS
rename to board/nxp/ls1021aiot/MAINTAINERS
index 65f21bee344..db7a90b07e9 100644
--- a/board/freescale/ls1021aiot/MAINTAINERS
+++ b/board/nxp/ls1021aiot/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1021AIOT BOARD
 M:	Alison Wang <alison.wang@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1021aiot/
+F:	board/nxp/ls1021aiot/
 F:	include/configs/ls1021aiot.h
 F:	configs/ls1021aiot_sdcard_defconfig
 F:	configs/ls1021aiot_qspi_defconfig
diff --git a/board/freescale/ls1021aiot/Makefile b/board/nxp/ls1021aiot/Makefile
similarity index 100%
rename from board/freescale/ls1021aiot/Makefile
rename to board/nxp/ls1021aiot/Makefile
diff --git a/board/freescale/ls1021aiot/README b/board/nxp/ls1021aiot/README
similarity index 100%
rename from board/freescale/ls1021aiot/README
rename to board/nxp/ls1021aiot/README
diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/nxp/ls1021aiot/ls1021aiot.c
similarity index 100%
rename from board/freescale/ls1021aiot/ls1021aiot.c
rename to board/nxp/ls1021aiot/ls1021aiot.c
diff --git a/board/freescale/ls1021aiot/ls102xa_pbi.cfg b/board/nxp/ls1021aiot/ls102xa_pbi.cfg
similarity index 100%
rename from board/freescale/ls1021aiot/ls102xa_pbi.cfg
rename to board/nxp/ls1021aiot/ls102xa_pbi.cfg
diff --git a/board/freescale/ls1021aiot/ls102xa_rcw_sd.cfg b/board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg
similarity index 100%
rename from board/freescale/ls1021aiot/ls102xa_rcw_sd.cfg
rename to board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg
diff --git a/board/freescale/ls1021aiot/psci.S b/board/nxp/ls1021aiot/psci.S
similarity index 100%
rename from board/freescale/ls1021aiot/psci.S
rename to board/nxp/ls1021aiot/psci.S
diff --git a/board/freescale/ls1021aqds/Kconfig b/board/nxp/ls1021aqds/Kconfig
similarity index 88%
rename from board/freescale/ls1021aqds/Kconfig
rename to board/nxp/ls1021aqds/Kconfig
index 119b9550410..e14140aee33 100644
--- a/board/freescale/ls1021aqds/Kconfig
+++ b/board/nxp/ls1021aqds/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1021aqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "ls102xa"
diff --git a/board/freescale/ls1021aqds/MAINTAINERS b/board/nxp/ls1021aqds/MAINTAINERS
similarity index 93%
rename from board/freescale/ls1021aqds/MAINTAINERS
rename to board/nxp/ls1021aqds/MAINTAINERS
index 913d251eeb7..4575dbd0ef2 100644
--- a/board/freescale/ls1021aqds/MAINTAINERS
+++ b/board/nxp/ls1021aqds/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1021AQDS BOARD
 M:	Alison Wang <alison.wang@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1021aqds/
+F:	board/nxp/ls1021aqds/
 F:	include/configs/ls1021aqds.h
 F:	configs/ls1021aqds_nor_defconfig
 F:	configs/ls1021aqds_ddr4_nor_defconfig
diff --git a/board/freescale/ls1021aqds/Makefile b/board/nxp/ls1021aqds/Makefile
similarity index 100%
rename from board/freescale/ls1021aqds/Makefile
rename to board/nxp/ls1021aqds/Makefile
diff --git a/board/freescale/ls1021aqds/README b/board/nxp/ls1021aqds/README
similarity index 100%
rename from board/freescale/ls1021aqds/README
rename to board/nxp/ls1021aqds/README
diff --git a/board/freescale/ls1021aqds/ddr.c b/board/nxp/ls1021aqds/ddr.c
similarity index 100%
rename from board/freescale/ls1021aqds/ddr.c
rename to board/nxp/ls1021aqds/ddr.c
diff --git a/board/freescale/ls1021aqds/ddr.h b/board/nxp/ls1021aqds/ddr.h
similarity index 100%
rename from board/freescale/ls1021aqds/ddr.h
rename to board/nxp/ls1021aqds/ddr.h
diff --git a/board/freescale/ls1021aqds/ls1021aqds.c b/board/nxp/ls1021aqds/ls1021aqds.c
similarity index 100%
rename from board/freescale/ls1021aqds/ls1021aqds.c
rename to board/nxp/ls1021aqds/ls1021aqds.c
diff --git a/board/freescale/ls1021aqds/ls1021aqds_qixis.h b/board/nxp/ls1021aqds/ls1021aqds_qixis.h
similarity index 100%
rename from board/freescale/ls1021aqds/ls1021aqds_qixis.h
rename to board/nxp/ls1021aqds/ls1021aqds_qixis.h
diff --git a/board/freescale/ls1021aqds/ls102xa_pbi.cfg b/board/nxp/ls1021aqds/ls102xa_pbi.cfg
similarity index 100%
rename from board/freescale/ls1021aqds/ls102xa_pbi.cfg
rename to board/nxp/ls1021aqds/ls102xa_pbi.cfg
diff --git a/board/freescale/ls1021aqds/ls102xa_rcw_nand.cfg b/board/nxp/ls1021aqds/ls102xa_rcw_nand.cfg
similarity index 100%
rename from board/freescale/ls1021aqds/ls102xa_rcw_nand.cfg
rename to board/nxp/ls1021aqds/ls102xa_rcw_nand.cfg
diff --git a/board/freescale/ls1021aqds/ls102xa_rcw_sd_ifc.cfg b/board/nxp/ls1021aqds/ls102xa_rcw_sd_ifc.cfg
similarity index 100%
rename from board/freescale/ls1021aqds/ls102xa_rcw_sd_ifc.cfg
rename to board/nxp/ls1021aqds/ls102xa_rcw_sd_ifc.cfg
diff --git a/board/freescale/ls1021aqds/ls102xa_rcw_sd_qspi.cfg b/board/nxp/ls1021aqds/ls102xa_rcw_sd_qspi.cfg
similarity index 100%
rename from board/freescale/ls1021aqds/ls102xa_rcw_sd_qspi.cfg
rename to board/nxp/ls1021aqds/ls102xa_rcw_sd_qspi.cfg
diff --git a/board/freescale/ls1021aqds/psci.S b/board/nxp/ls1021aqds/psci.S
similarity index 100%
rename from board/freescale/ls1021aqds/psci.S
rename to board/nxp/ls1021aqds/psci.S
diff --git a/board/freescale/ls1021atsn/Kconfig b/board/nxp/ls1021atsn/Kconfig
similarity index 90%
rename from board/freescale/ls1021atsn/Kconfig
rename to board/nxp/ls1021atsn/Kconfig
index aa42a06c663..1b20c643a6d 100644
--- a/board/freescale/ls1021atsn/Kconfig
+++ b/board/nxp/ls1021atsn/Kconfig
@@ -5,7 +5,7 @@ config SYS_BOARD
 	default "ls1021atsn"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "ls102xa"
diff --git a/board/freescale/ls1021atsn/MAINTAINERS b/board/nxp/ls1021atsn/MAINTAINERS
similarity index 87%
rename from board/freescale/ls1021atsn/MAINTAINERS
rename to board/nxp/ls1021atsn/MAINTAINERS
index 560bb615d2f..eda36823ddc 100644
--- a/board/freescale/ls1021atsn/MAINTAINERS
+++ b/board/nxp/ls1021atsn/MAINTAINERS
@@ -2,7 +2,7 @@ NXP LS1021A-TSN Board
 M:	Vladimir Oltean <olteanv@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/ls1021a-tsn.dts
-F:	board/freescale/ls1021atsn/
+F:	board/nxp/ls1021atsn/
 F:	include/configs/ls1021atsn.h
 F:	configs/ls1021atsn_qspi_defconfig
 F:	configs/ls1021atsn_sdcard_defconfig
diff --git a/board/freescale/ls1021atsn/Makefile b/board/nxp/ls1021atsn/Makefile
similarity index 100%
rename from board/freescale/ls1021atsn/Makefile
rename to board/nxp/ls1021atsn/Makefile
diff --git a/board/freescale/ls1021atsn/README.rst b/board/nxp/ls1021atsn/README.rst
similarity index 100%
rename from board/freescale/ls1021atsn/README.rst
rename to board/nxp/ls1021atsn/README.rst
diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/nxp/ls1021atsn/ls1021atsn.c
similarity index 100%
rename from board/freescale/ls1021atsn/ls1021atsn.c
rename to board/nxp/ls1021atsn/ls1021atsn.c
diff --git a/board/freescale/ls1021atsn/ls102xa_pbi.cfg b/board/nxp/ls1021atsn/ls102xa_pbi.cfg
similarity index 100%
rename from board/freescale/ls1021atsn/ls102xa_pbi.cfg
rename to board/nxp/ls1021atsn/ls102xa_pbi.cfg
diff --git a/board/freescale/ls1021atsn/ls102xa_rcw_sd.cfg b/board/nxp/ls1021atsn/ls102xa_rcw_sd.cfg
similarity index 100%
rename from board/freescale/ls1021atsn/ls102xa_rcw_sd.cfg
rename to board/nxp/ls1021atsn/ls102xa_rcw_sd.cfg
diff --git a/board/freescale/ls1021atwr/Kconfig b/board/nxp/ls1021atwr/Kconfig
similarity index 88%
rename from board/freescale/ls1021atwr/Kconfig
rename to board/nxp/ls1021atwr/Kconfig
index bc50b8d9668..4c99d999d99 100644
--- a/board/freescale/ls1021atwr/Kconfig
+++ b/board/nxp/ls1021atwr/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1021atwr"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "ls102xa"
diff --git a/board/freescale/ls1021atwr/MAINTAINERS b/board/nxp/ls1021atwr/MAINTAINERS
similarity index 92%
rename from board/freescale/ls1021atwr/MAINTAINERS
rename to board/nxp/ls1021atwr/MAINTAINERS
index 7ab8347e9ed..f70b06da5df 100644
--- a/board/freescale/ls1021atwr/MAINTAINERS
+++ b/board/nxp/ls1021atwr/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1021ATWR BOARD
 M:	Alison Wang <alison.wang@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1021atwr/
+F:	board/nxp/ls1021atwr/
 F:	include/configs/ls1021atwr.h
 F:	configs/ls1021atwr_nor_defconfig
 F:	configs/ls1021atwr_nor_SECURE_BOOT_defconfig
diff --git a/board/freescale/ls1021atwr/Makefile b/board/nxp/ls1021atwr/Makefile
similarity index 100%
rename from board/freescale/ls1021atwr/Makefile
rename to board/nxp/ls1021atwr/Makefile
diff --git a/board/freescale/ls1021atwr/README b/board/nxp/ls1021atwr/README
similarity index 100%
rename from board/freescale/ls1021atwr/README
rename to board/nxp/ls1021atwr/README
diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/nxp/ls1021atwr/ls1021atwr.c
similarity index 100%
rename from board/freescale/ls1021atwr/ls1021atwr.c
rename to board/nxp/ls1021atwr/ls1021atwr.c
diff --git a/board/freescale/ls1021atwr/ls102xa_pbi.cfg b/board/nxp/ls1021atwr/ls102xa_pbi.cfg
similarity index 100%
rename from board/freescale/ls1021atwr/ls102xa_pbi.cfg
rename to board/nxp/ls1021atwr/ls102xa_pbi.cfg
diff --git a/board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg b/board/nxp/ls1021atwr/ls102xa_rcw_sd_ifc.cfg
similarity index 100%
rename from board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg
rename to board/nxp/ls1021atwr/ls102xa_rcw_sd_ifc.cfg
diff --git a/board/freescale/ls1021atwr/ls102xa_rcw_sd_qspi.cfg b/board/nxp/ls1021atwr/ls102xa_rcw_sd_qspi.cfg
similarity index 100%
rename from board/freescale/ls1021atwr/ls102xa_rcw_sd_qspi.cfg
rename to board/nxp/ls1021atwr/ls102xa_rcw_sd_qspi.cfg
diff --git a/board/freescale/ls1021atwr/psci.S b/board/nxp/ls1021atwr/psci.S
similarity index 100%
rename from board/freescale/ls1021atwr/psci.S
rename to board/nxp/ls1021atwr/psci.S
diff --git a/board/freescale/ls1028a/Kconfig b/board/nxp/ls1028a/Kconfig
similarity index 94%
rename from board/freescale/ls1028a/Kconfig
rename to board/nxp/ls1028a/Kconfig
index fb6ee17ce89..d14eac2720e 100644
--- a/board/freescale/ls1028a/Kconfig
+++ b/board/nxp/ls1028a/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1028a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -28,7 +28,7 @@ config SYS_BOARD
 	default "ls1028a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1028a/MAINTAINERS b/board/nxp/ls1028a/MAINTAINERS
similarity index 92%
rename from board/freescale/ls1028a/MAINTAINERS
rename to board/nxp/ls1028a/MAINTAINERS
index 551f6a08651..fcaf7eddc51 100644
--- a/board/freescale/ls1028a/MAINTAINERS
+++ b/board/nxp/ls1028a/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1028AQDS BOARD
 M:	Tang Yuantian <andy.tang@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1028a/
+F:	board/nxp/ls1028a/
 F:	include/configs/ls1028a_common.h
 F:	include/configs/ls1028aqds.h
 F:	configs/ls1028aqds_tfa_defconfig
@@ -10,7 +10,7 @@ F:	configs/ls1028aqds_tfa_lpuart_defconfig
 LS1028ARDB BOARD
 M:	Tang Yuantian <andy.tang@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1028a/
+F:	board/nxp/ls1028a/
 F:	include/configs/ls1028a_common.h
 F:	include/configs/ls1028ardb.h
 F:	configs/ls1028ardb_tfa_defconfig
diff --git a/board/freescale/ls1028a/Makefile b/board/nxp/ls1028a/Makefile
similarity index 100%
rename from board/freescale/ls1028a/Makefile
rename to board/nxp/ls1028a/Makefile
diff --git a/board/freescale/ls1028a/README b/board/nxp/ls1028a/README
similarity index 100%
rename from board/freescale/ls1028a/README
rename to board/nxp/ls1028a/README
diff --git a/board/freescale/ls1028a/ddr.c b/board/nxp/ls1028a/ddr.c
similarity index 100%
rename from board/freescale/ls1028a/ddr.c
rename to board/nxp/ls1028a/ddr.c
diff --git a/board/freescale/ls1028a/ls1028a.c b/board/nxp/ls1028a/ls1028a.c
similarity index 100%
rename from board/freescale/ls1028a/ls1028a.c
rename to board/nxp/ls1028a/ls1028a.c
diff --git a/board/freescale/ls1043aqds/Kconfig b/board/nxp/ls1043aqds/Kconfig
similarity index 89%
rename from board/freescale/ls1043aqds/Kconfig
rename to board/nxp/ls1043aqds/Kconfig
index 7e27f8f5b13..7261a270f9a 100644
--- a/board/freescale/ls1043aqds/Kconfig
+++ b/board/nxp/ls1043aqds/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1043aqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1043aqds/MAINTAINERS b/board/nxp/ls1043aqds/MAINTAINERS
similarity index 93%
rename from board/freescale/ls1043aqds/MAINTAINERS
rename to board/nxp/ls1043aqds/MAINTAINERS
index f7420ecd303..daea64483d2 100644
--- a/board/freescale/ls1043aqds/MAINTAINERS
+++ b/board/nxp/ls1043aqds/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1043AQDS BOARD
 M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1043aqds/
+F:	board/nxp/ls1043aqds/
 F:	include/configs/ls1043aqds.h
 F:	configs/ls1043aqds_defconfig
 F:	configs/ls1043aqds_nor_ddr3_defconfig
diff --git a/board/freescale/ls1043aqds/Makefile b/board/nxp/ls1043aqds/Makefile
similarity index 100%
rename from board/freescale/ls1043aqds/Makefile
rename to board/nxp/ls1043aqds/Makefile
diff --git a/board/freescale/ls1043aqds/README b/board/nxp/ls1043aqds/README
similarity index 100%
rename from board/freescale/ls1043aqds/README
rename to board/nxp/ls1043aqds/README
diff --git a/board/freescale/ls1043aqds/ddr.c b/board/nxp/ls1043aqds/ddr.c
similarity index 100%
rename from board/freescale/ls1043aqds/ddr.c
rename to board/nxp/ls1043aqds/ddr.c
diff --git a/board/freescale/ls1043aqds/ddr.h b/board/nxp/ls1043aqds/ddr.h
similarity index 100%
rename from board/freescale/ls1043aqds/ddr.h
rename to board/nxp/ls1043aqds/ddr.h
diff --git a/board/freescale/ls1043aqds/eth.c b/board/nxp/ls1043aqds/eth.c
similarity index 100%
rename from board/freescale/ls1043aqds/eth.c
rename to board/nxp/ls1043aqds/eth.c
diff --git a/board/freescale/ls1043aqds/ls1043aqds.c b/board/nxp/ls1043aqds/ls1043aqds.c
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds.c
rename to board/nxp/ls1043aqds/ls1043aqds.c
diff --git a/board/freescale/ls1043aqds/ls1043aqds_pbi.cfg b/board/nxp/ls1043aqds/ls1043aqds_pbi.cfg
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds_pbi.cfg
rename to board/nxp/ls1043aqds/ls1043aqds_pbi.cfg
diff --git a/board/freescale/ls1043aqds/ls1043aqds_qixis.h b/board/nxp/ls1043aqds/ls1043aqds_qixis.h
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds_qixis.h
rename to board/nxp/ls1043aqds/ls1043aqds_qixis.h
diff --git a/board/freescale/ls1043aqds/ls1043aqds_rcw_nand.cfg b/board/nxp/ls1043aqds/ls1043aqds_rcw_nand.cfg
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds_rcw_nand.cfg
rename to board/nxp/ls1043aqds/ls1043aqds_rcw_nand.cfg
diff --git a/board/freescale/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg b/board/nxp/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg
rename to board/nxp/ls1043aqds/ls1043aqds_rcw_sd_ifc.cfg
diff --git a/board/freescale/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg b/board/nxp/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg
similarity index 100%
rename from board/freescale/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg
rename to board/nxp/ls1043aqds/ls1043aqds_rcw_sd_qspi.cfg
diff --git a/board/freescale/ls1043ardb/Kconfig b/board/nxp/ls1043ardb/Kconfig
similarity index 89%
rename from board/freescale/ls1043ardb/Kconfig
rename to board/nxp/ls1043ardb/Kconfig
index 51818ec5801..92b55496c62 100644
--- a/board/freescale/ls1043ardb/Kconfig
+++ b/board/nxp/ls1043ardb/Kconfig
@@ -5,7 +5,7 @@ config SYS_BOARD
 	default "ls1043ardb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1043ardb/MAINTAINERS b/board/nxp/ls1043ardb/MAINTAINERS
similarity index 93%
rename from board/freescale/ls1043ardb/MAINTAINERS
rename to board/nxp/ls1043ardb/MAINTAINERS
index 06b23889f6d..4df5940ab71 100644
--- a/board/freescale/ls1043ardb/MAINTAINERS
+++ b/board/nxp/ls1043ardb/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1043A BOARD
 M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1043ardb/
+F:	board/nxp/ls1043ardb/
 F:	include/configs/ls1043ardb.h
 F:	configs/ls1043ardb_defconfig
 F:	configs/ls1043ardb_nand_defconfig
diff --git a/board/freescale/ls1043ardb/Makefile b/board/nxp/ls1043ardb/Makefile
similarity index 100%
rename from board/freescale/ls1043ardb/Makefile
rename to board/nxp/ls1043ardb/Makefile
diff --git a/board/freescale/ls1043ardb/README b/board/nxp/ls1043ardb/README
similarity index 100%
rename from board/freescale/ls1043ardb/README
rename to board/nxp/ls1043ardb/README
diff --git a/board/freescale/ls1043ardb/cpld.c b/board/nxp/ls1043ardb/cpld.c
similarity index 100%
rename from board/freescale/ls1043ardb/cpld.c
rename to board/nxp/ls1043ardb/cpld.c
diff --git a/board/freescale/ls1043ardb/cpld.h b/board/nxp/ls1043ardb/cpld.h
similarity index 100%
rename from board/freescale/ls1043ardb/cpld.h
rename to board/nxp/ls1043ardb/cpld.h
diff --git a/board/freescale/ls1043ardb/ddr.c b/board/nxp/ls1043ardb/ddr.c
similarity index 100%
rename from board/freescale/ls1043ardb/ddr.c
rename to board/nxp/ls1043ardb/ddr.c
diff --git a/board/freescale/ls1043ardb/ddr.h b/board/nxp/ls1043ardb/ddr.h
similarity index 100%
rename from board/freescale/ls1043ardb/ddr.h
rename to board/nxp/ls1043ardb/ddr.h
diff --git a/board/freescale/ls1043ardb/eth.c b/board/nxp/ls1043ardb/eth.c
similarity index 100%
rename from board/freescale/ls1043ardb/eth.c
rename to board/nxp/ls1043ardb/eth.c
diff --git a/board/freescale/ls1043ardb/ls1043ardb.c b/board/nxp/ls1043ardb/ls1043ardb.c
similarity index 100%
rename from board/freescale/ls1043ardb/ls1043ardb.c
rename to board/nxp/ls1043ardb/ls1043ardb.c
diff --git a/board/freescale/ls1043ardb/ls1043ardb_pbi.cfg b/board/nxp/ls1043ardb/ls1043ardb_pbi.cfg
similarity index 100%
rename from board/freescale/ls1043ardb/ls1043ardb_pbi.cfg
rename to board/nxp/ls1043ardb/ls1043ardb_pbi.cfg
diff --git a/board/freescale/ls1043ardb/ls1043ardb_rcw_nand.cfg b/board/nxp/ls1043ardb/ls1043ardb_rcw_nand.cfg
similarity index 100%
rename from board/freescale/ls1043ardb/ls1043ardb_rcw_nand.cfg
rename to board/nxp/ls1043ardb/ls1043ardb_rcw_nand.cfg
diff --git a/board/freescale/ls1043ardb/ls1043ardb_rcw_sd.cfg b/board/nxp/ls1043ardb/ls1043ardb_rcw_sd.cfg
similarity index 100%
rename from board/freescale/ls1043ardb/ls1043ardb_rcw_sd.cfg
rename to board/nxp/ls1043ardb/ls1043ardb_rcw_sd.cfg
diff --git a/board/freescale/ls1046afrwy/Kconfig b/board/nxp/ls1046afrwy/Kconfig
similarity index 89%
rename from board/freescale/ls1046afrwy/Kconfig
rename to board/nxp/ls1046afrwy/Kconfig
index 68329d78caf..0f73485af7e 100644
--- a/board/freescale/ls1046afrwy/Kconfig
+++ b/board/nxp/ls1046afrwy/Kconfig
@@ -5,7 +5,7 @@ config SYS_BOARD
 	default "ls1046afrwy"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1046afrwy/MAINTAINERS b/board/nxp/ls1046afrwy/MAINTAINERS
similarity index 71%
rename from board/freescale/ls1046afrwy/MAINTAINERS
rename to board/nxp/ls1046afrwy/MAINTAINERS
index 8f360e1820f..abfd3e937b5 100644
--- a/board/freescale/ls1046afrwy/MAINTAINERS
+++ b/board/nxp/ls1046afrwy/MAINTAINERS
@@ -1,8 +1,8 @@
 LS1046AFRWY BOARD
 M:	Pramod Kumar <pramod.kumar_1@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1046afrwy/
-F:	board/freescale/ls1046afrwy/ls1046afrwy.c
+F:	board/nxp/ls1046afrwy/
+F:	board/nxp/ls1046afrwy/ls1046afrwy.c
 F:	include/configs/ls1046afrwy.h
 F:	configs/ls1046afrwy_tfa_defconfig
 F:	configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
diff --git a/board/freescale/ls1046afrwy/Makefile b/board/nxp/ls1046afrwy/Makefile
similarity index 100%
rename from board/freescale/ls1046afrwy/Makefile
rename to board/nxp/ls1046afrwy/Makefile
diff --git a/board/freescale/ls1046afrwy/README b/board/nxp/ls1046afrwy/README
similarity index 100%
rename from board/freescale/ls1046afrwy/README
rename to board/nxp/ls1046afrwy/README
diff --git a/board/freescale/ls1046afrwy/ddr.c b/board/nxp/ls1046afrwy/ddr.c
similarity index 100%
rename from board/freescale/ls1046afrwy/ddr.c
rename to board/nxp/ls1046afrwy/ddr.c
diff --git a/board/freescale/ls1046afrwy/eth.c b/board/nxp/ls1046afrwy/eth.c
similarity index 100%
rename from board/freescale/ls1046afrwy/eth.c
rename to board/nxp/ls1046afrwy/eth.c
diff --git a/board/freescale/ls1046afrwy/ls1046afrwy.c b/board/nxp/ls1046afrwy/ls1046afrwy.c
similarity index 100%
rename from board/freescale/ls1046afrwy/ls1046afrwy.c
rename to board/nxp/ls1046afrwy/ls1046afrwy.c
diff --git a/board/freescale/ls1046aqds/Kconfig b/board/nxp/ls1046aqds/Kconfig
similarity index 89%
rename from board/freescale/ls1046aqds/Kconfig
rename to board/nxp/ls1046aqds/Kconfig
index 723f4ba90a0..b886c55576a 100644
--- a/board/freescale/ls1046aqds/Kconfig
+++ b/board/nxp/ls1046aqds/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1046aqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1046aqds/MAINTAINERS b/board/nxp/ls1046aqds/MAINTAINERS
similarity index 93%
rename from board/freescale/ls1046aqds/MAINTAINERS
rename to board/nxp/ls1046aqds/MAINTAINERS
index e1db2aaa8e4..792531f7f3a 100644
--- a/board/freescale/ls1046aqds/MAINTAINERS
+++ b/board/nxp/ls1046aqds/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1046AQDS BOARD
 M:	Mingkai Hu <Mingkai.Hu@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1046aqds/
+F:	board/nxp/ls1046aqds/
 F:	include/configs/ls1046aqds.h
 F:	configs/ls1046aqds_defconfig
 F:	configs/ls1046aqds_nand_defconfig
diff --git a/board/freescale/ls1046aqds/Makefile b/board/nxp/ls1046aqds/Makefile
similarity index 100%
rename from board/freescale/ls1046aqds/Makefile
rename to board/nxp/ls1046aqds/Makefile
diff --git a/board/freescale/ls1046aqds/README b/board/nxp/ls1046aqds/README
similarity index 100%
rename from board/freescale/ls1046aqds/README
rename to board/nxp/ls1046aqds/README
diff --git a/board/freescale/ls1046aqds/ddr.c b/board/nxp/ls1046aqds/ddr.c
similarity index 100%
rename from board/freescale/ls1046aqds/ddr.c
rename to board/nxp/ls1046aqds/ddr.c
diff --git a/board/freescale/ls1046aqds/ddr.h b/board/nxp/ls1046aqds/ddr.h
similarity index 100%
rename from board/freescale/ls1046aqds/ddr.h
rename to board/nxp/ls1046aqds/ddr.h
diff --git a/board/freescale/ls1046aqds/eth.c b/board/nxp/ls1046aqds/eth.c
similarity index 100%
rename from board/freescale/ls1046aqds/eth.c
rename to board/nxp/ls1046aqds/eth.c
diff --git a/board/freescale/ls1046aqds/ls1046aqds.c b/board/nxp/ls1046aqds/ls1046aqds.c
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds.c
rename to board/nxp/ls1046aqds/ls1046aqds.c
diff --git a/board/freescale/ls1046aqds/ls1046aqds_pbi.cfg b/board/nxp/ls1046aqds/ls1046aqds_pbi.cfg
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds_pbi.cfg
rename to board/nxp/ls1046aqds/ls1046aqds_pbi.cfg
diff --git a/board/freescale/ls1046aqds/ls1046aqds_qixis.h b/board/nxp/ls1046aqds/ls1046aqds_qixis.h
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds_qixis.h
rename to board/nxp/ls1046aqds/ls1046aqds_qixis.h
diff --git a/board/freescale/ls1046aqds/ls1046aqds_rcw_nand.cfg b/board/nxp/ls1046aqds/ls1046aqds_rcw_nand.cfg
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds_rcw_nand.cfg
rename to board/nxp/ls1046aqds/ls1046aqds_rcw_nand.cfg
diff --git a/board/freescale/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg b/board/nxp/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg
rename to board/nxp/ls1046aqds/ls1046aqds_rcw_sd_ifc.cfg
diff --git a/board/freescale/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg b/board/nxp/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg
similarity index 100%
rename from board/freescale/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg
rename to board/nxp/ls1046aqds/ls1046aqds_rcw_sd_qspi.cfg
diff --git a/board/freescale/ls1046ardb/Kconfig b/board/nxp/ls1046ardb/Kconfig
similarity index 89%
rename from board/freescale/ls1046ardb/Kconfig
rename to board/nxp/ls1046ardb/Kconfig
index a62255c78db..7cb7e0eb01e 100644
--- a/board/freescale/ls1046ardb/Kconfig
+++ b/board/nxp/ls1046ardb/Kconfig
@@ -5,7 +5,7 @@ config SYS_BOARD
 	default "ls1046ardb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1046ardb/MAINTAINERS b/board/nxp/ls1046ardb/MAINTAINERS
similarity index 87%
rename from board/freescale/ls1046ardb/MAINTAINERS
rename to board/nxp/ls1046ardb/MAINTAINERS
index d5a6b261519..bb5f6a64d7b 100644
--- a/board/freescale/ls1046ardb/MAINTAINERS
+++ b/board/nxp/ls1046ardb/MAINTAINERS
@@ -1,8 +1,8 @@
 LS1046A BOARD
 M:	Mingkai Hu <mingkai.hu@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1046ardb/
-F:	board/freescale/ls1046ardb/ls1046ardb.c
+F:	board/nxp/ls1046ardb/
+F:	board/nxp/ls1046ardb/ls1046ardb.c
 F:	include/configs/ls1046ardb.h
 F:	configs/ls1046ardb_qspi_defconfig
 F:	configs/ls1046ardb_qspi_spl_defconfig
diff --git a/board/freescale/ls1046ardb/Makefile b/board/nxp/ls1046ardb/Makefile
similarity index 100%
rename from board/freescale/ls1046ardb/Makefile
rename to board/nxp/ls1046ardb/Makefile
diff --git a/board/freescale/ls1046ardb/cpld.c b/board/nxp/ls1046ardb/cpld.c
similarity index 100%
rename from board/freescale/ls1046ardb/cpld.c
rename to board/nxp/ls1046ardb/cpld.c
diff --git a/board/freescale/ls1046ardb/cpld.h b/board/nxp/ls1046ardb/cpld.h
similarity index 100%
rename from board/freescale/ls1046ardb/cpld.h
rename to board/nxp/ls1046ardb/cpld.h
diff --git a/board/freescale/ls1046ardb/ddr.c b/board/nxp/ls1046ardb/ddr.c
similarity index 100%
rename from board/freescale/ls1046ardb/ddr.c
rename to board/nxp/ls1046ardb/ddr.c
diff --git a/board/freescale/ls1046ardb/ddr.h b/board/nxp/ls1046ardb/ddr.h
similarity index 100%
rename from board/freescale/ls1046ardb/ddr.h
rename to board/nxp/ls1046ardb/ddr.h
diff --git a/board/freescale/ls1046ardb/eth.c b/board/nxp/ls1046ardb/eth.c
similarity index 100%
rename from board/freescale/ls1046ardb/eth.c
rename to board/nxp/ls1046ardb/eth.c
diff --git a/board/freescale/ls1046ardb/ls1046ardb.c b/board/nxp/ls1046ardb/ls1046ardb.c
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb.c
rename to board/nxp/ls1046ardb/ls1046ardb.c
diff --git a/board/freescale/ls1046ardb/ls1046ardb_pbi.cfg b/board/nxp/ls1046ardb/ls1046ardb_pbi.cfg
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb_pbi.cfg
rename to board/nxp/ls1046ardb/ls1046ardb_pbi.cfg
diff --git a/board/freescale/ls1046ardb/ls1046ardb_qspi_pbi.cfg b/board/nxp/ls1046ardb/ls1046ardb_qspi_pbi.cfg
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb_qspi_pbi.cfg
rename to board/nxp/ls1046ardb/ls1046ardb_qspi_pbi.cfg
diff --git a/board/freescale/ls1046ardb/ls1046ardb_rcw_emmc.cfg b/board/nxp/ls1046ardb/ls1046ardb_rcw_emmc.cfg
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb_rcw_emmc.cfg
rename to board/nxp/ls1046ardb/ls1046ardb_rcw_emmc.cfg
diff --git a/board/freescale/ls1046ardb/ls1046ardb_rcw_qspi.cfg b/board/nxp/ls1046ardb/ls1046ardb_rcw_qspi.cfg
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb_rcw_qspi.cfg
rename to board/nxp/ls1046ardb/ls1046ardb_rcw_qspi.cfg
diff --git a/board/freescale/ls1046ardb/ls1046ardb_rcw_sd.cfg b/board/nxp/ls1046ardb/ls1046ardb_rcw_sd.cfg
similarity index 100%
rename from board/freescale/ls1046ardb/ls1046ardb_rcw_sd.cfg
rename to board/nxp/ls1046ardb/ls1046ardb_rcw_sd.cfg
diff --git a/board/freescale/ls1088a/Kconfig b/board/nxp/ls1088a/Kconfig
similarity index 89%
rename from board/freescale/ls1088a/Kconfig
rename to board/nxp/ls1088a/Kconfig
index 1ada661743e..976fd3ae748 100644
--- a/board/freescale/ls1088a/Kconfig
+++ b/board/nxp/ls1088a/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls1088a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -20,7 +20,7 @@ config SYS_BOARD
 	default "ls1088a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls1088a/MAINTAINERS b/board/nxp/ls1088a/MAINTAINERS
similarity index 94%
rename from board/freescale/ls1088a/MAINTAINERS
rename to board/nxp/ls1088a/MAINTAINERS
index 95a14149e4f..85f38fcf0c7 100644
--- a/board/freescale/ls1088a/MAINTAINERS
+++ b/board/nxp/ls1088a/MAINTAINERS
@@ -1,7 +1,7 @@
 LS1088ARDB BOARD
 M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1088a/
+F:	board/nxp/ls1088a/
 F:	include/configs/ls1088ardb.h
 F:	configs/ls1088ardb_qspi_defconfig
 F:	configs/ls1088ardb_sdcard_qspi_defconfig
@@ -11,7 +11,7 @@ F:	configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
 LS1088AQDS BOARD
 M:	Ashish Kumar <Ashish.Kumar@nxp.com>
 S:	Maintained
-F:	board/freescale/ls1088a/
+F:	board/nxp/ls1088a/
 F:	include/configs/ls1088aqds.h
 F:	configs/ls1088aqds_qspi_defconfig
 F:	configs/ls1088aqds_sdcard_qspi_defconfig
diff --git a/board/freescale/ls1088a/Makefile b/board/nxp/ls1088a/Makefile
similarity index 100%
rename from board/freescale/ls1088a/Makefile
rename to board/nxp/ls1088a/Makefile
diff --git a/board/freescale/ls1088a/README b/board/nxp/ls1088a/README
similarity index 100%
rename from board/freescale/ls1088a/README
rename to board/nxp/ls1088a/README
diff --git a/board/freescale/ls1088a/ddr.c b/board/nxp/ls1088a/ddr.c
similarity index 100%
rename from board/freescale/ls1088a/ddr.c
rename to board/nxp/ls1088a/ddr.c
diff --git a/board/freescale/ls1088a/ddr.h b/board/nxp/ls1088a/ddr.h
similarity index 100%
rename from board/freescale/ls1088a/ddr.h
rename to board/nxp/ls1088a/ddr.h
diff --git a/board/freescale/ls1088a/eth_ls1088aqds.c b/board/nxp/ls1088a/eth_ls1088aqds.c
similarity index 100%
rename from board/freescale/ls1088a/eth_ls1088aqds.c
rename to board/nxp/ls1088a/eth_ls1088aqds.c
diff --git a/board/freescale/ls1088a/eth_ls1088ardb.c b/board/nxp/ls1088a/eth_ls1088ardb.c
similarity index 100%
rename from board/freescale/ls1088a/eth_ls1088ardb.c
rename to board/nxp/ls1088a/eth_ls1088ardb.c
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/nxp/ls1088a/ls1088a.c
similarity index 100%
rename from board/freescale/ls1088a/ls1088a.c
rename to board/nxp/ls1088a/ls1088a.c
diff --git a/board/freescale/ls1088a/ls1088a_qixis.h b/board/nxp/ls1088a/ls1088a_qixis.h
similarity index 100%
rename from board/freescale/ls1088a/ls1088a_qixis.h
rename to board/nxp/ls1088a/ls1088a_qixis.h
diff --git a/board/freescale/ls2080aqds/Kconfig b/board/nxp/ls2080aqds/Kconfig
similarity index 89%
rename from board/freescale/ls2080aqds/Kconfig
rename to board/nxp/ls2080aqds/Kconfig
index 2f997e9de1a..dc2a5f83134 100644
--- a/board/freescale/ls2080aqds/Kconfig
+++ b/board/nxp/ls2080aqds/Kconfig
@@ -5,7 +5,7 @@ config SYS_BOARD
 	default "ls2080aqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls2080aqds/MAINTAINERS b/board/nxp/ls2080aqds/MAINTAINERS
similarity index 83%
rename from board/freescale/ls2080aqds/MAINTAINERS
rename to board/nxp/ls2080aqds/MAINTAINERS
index fdad199ec25..3659cec4cd8 100644
--- a/board/freescale/ls2080aqds/MAINTAINERS
+++ b/board/nxp/ls2080aqds/MAINTAINERS
@@ -2,8 +2,8 @@ LS2080A BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/freescale/ls2080aqds/
-F:	board/freescale/ls2080a/ls2080aqds.c
+F:	board/nxp/ls2080aqds/
+F:	board/nxp/ls2080a/ls2080aqds.c
 F:	include/configs/ls2080aqds.h
 F:	configs/ls2080aqds_defconfig
 F:	configs/ls2080aqds_nand_defconfig
diff --git a/board/freescale/ls2080aqds/Makefile b/board/nxp/ls2080aqds/Makefile
similarity index 100%
rename from board/freescale/ls2080aqds/Makefile
rename to board/nxp/ls2080aqds/Makefile
diff --git a/board/freescale/ls2080aqds/README b/board/nxp/ls2080aqds/README
similarity index 100%
rename from board/freescale/ls2080aqds/README
rename to board/nxp/ls2080aqds/README
diff --git a/board/freescale/ls2080aqds/ddr.c b/board/nxp/ls2080aqds/ddr.c
similarity index 100%
rename from board/freescale/ls2080aqds/ddr.c
rename to board/nxp/ls2080aqds/ddr.c
diff --git a/board/freescale/ls2080aqds/ddr.h b/board/nxp/ls2080aqds/ddr.h
similarity index 100%
rename from board/freescale/ls2080aqds/ddr.h
rename to board/nxp/ls2080aqds/ddr.h
diff --git a/board/freescale/ls2080aqds/eth.c b/board/nxp/ls2080aqds/eth.c
similarity index 100%
rename from board/freescale/ls2080aqds/eth.c
rename to board/nxp/ls2080aqds/eth.c
diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/nxp/ls2080aqds/ls2080aqds.c
similarity index 100%
rename from board/freescale/ls2080aqds/ls2080aqds.c
rename to board/nxp/ls2080aqds/ls2080aqds.c
diff --git a/board/freescale/ls2080aqds/ls2080aqds_qixis.h b/board/nxp/ls2080aqds/ls2080aqds_qixis.h
similarity index 100%
rename from board/freescale/ls2080aqds/ls2080aqds_qixis.h
rename to board/nxp/ls2080aqds/ls2080aqds_qixis.h
diff --git a/board/freescale/ls2080ardb/Kconfig b/board/nxp/ls2080ardb/Kconfig
similarity index 90%
rename from board/freescale/ls2080ardb/Kconfig
rename to board/nxp/ls2080ardb/Kconfig
index 671eead5f7f..1f057a7690b 100644
--- a/board/freescale/ls2080ardb/Kconfig
+++ b/board/nxp/ls2080ardb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "ls2080ardb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/ls2080ardb/MAINTAINERS b/board/nxp/ls2080ardb/MAINTAINERS
similarity index 91%
rename from board/freescale/ls2080ardb/MAINTAINERS
rename to board/nxp/ls2080ardb/MAINTAINERS
index f2f834ffbd9..867ebe99cac 100644
--- a/board/freescale/ls2080ardb/MAINTAINERS
+++ b/board/nxp/ls2080ardb/MAINTAINERS
@@ -2,8 +2,8 @@ LS2080A BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/freescale/ls2080ardb/
-F:	board/freescale/ls2080a/ls2080ardb.c
+F:	board/nxp/ls2080ardb/
+F:	board/nxp/ls2080a/ls2080ardb.c
 F:	include/configs/ls2080ardb.h
 F:	configs/ls2080ardb_defconfig
 F:	configs/ls2080ardb_nand_defconfig
diff --git a/board/freescale/ls2080ardb/Makefile b/board/nxp/ls2080ardb/Makefile
similarity index 100%
rename from board/freescale/ls2080ardb/Makefile
rename to board/nxp/ls2080ardb/Makefile
diff --git a/board/freescale/ls2080ardb/README b/board/nxp/ls2080ardb/README
similarity index 100%
rename from board/freescale/ls2080ardb/README
rename to board/nxp/ls2080ardb/README
diff --git a/board/freescale/ls2080ardb/ddr.c b/board/nxp/ls2080ardb/ddr.c
similarity index 100%
rename from board/freescale/ls2080ardb/ddr.c
rename to board/nxp/ls2080ardb/ddr.c
diff --git a/board/freescale/ls2080ardb/ddr.h b/board/nxp/ls2080ardb/ddr.h
similarity index 100%
rename from board/freescale/ls2080ardb/ddr.h
rename to board/nxp/ls2080ardb/ddr.h
diff --git a/board/freescale/ls2080ardb/eth_ls2080rdb.c b/board/nxp/ls2080ardb/eth_ls2080rdb.c
similarity index 100%
rename from board/freescale/ls2080ardb/eth_ls2080rdb.c
rename to board/nxp/ls2080ardb/eth_ls2080rdb.c
diff --git a/board/freescale/ls2080ardb/ls2080ardb.c b/board/nxp/ls2080ardb/ls2080ardb.c
similarity index 100%
rename from board/freescale/ls2080ardb/ls2080ardb.c
rename to board/nxp/ls2080ardb/ls2080ardb.c
diff --git a/board/freescale/ls2080ardb/ls2080ardb_qixis.h b/board/nxp/ls2080ardb/ls2080ardb_qixis.h
similarity index 100%
rename from board/freescale/ls2080ardb/ls2080ardb_qixis.h
rename to board/nxp/ls2080ardb/ls2080ardb_qixis.h
diff --git a/board/freescale/lx2160a/Kconfig b/board/nxp/lx2160a/Kconfig
similarity index 89%
rename from board/freescale/lx2160a/Kconfig
rename to board/nxp/lx2160a/Kconfig
index 0e4b4158a7f..5764c83ab08 100644
--- a/board/freescale/lx2160a/Kconfig
+++ b/board/nxp/lx2160a/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "lx2160a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -20,7 +20,7 @@ config SYS_BOARD
 	default "lx2160a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
@@ -36,7 +36,7 @@ config SYS_BOARD
 	default "lx2160a"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "fsl-layerscape"
diff --git a/board/freescale/lx2160a/MAINTAINERS b/board/nxp/lx2160a/MAINTAINERS
similarity index 93%
rename from board/freescale/lx2160a/MAINTAINERS
rename to board/nxp/lx2160a/MAINTAINERS
index c60b2af6e42..abdac1372d2 100644
--- a/board/freescale/lx2160a/MAINTAINERS
+++ b/board/nxp/lx2160a/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/freescale/lx2160a/
+F:	board/nxp/lx2160a/
 F:	include/configs/lx2160a_common.h
 F:	include/configs/lx2160ardb.h
 F:	configs/lx2160ardb_tfa_defconfig
@@ -19,7 +19,7 @@ LX2160AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/freescale/lx2160a/eth_lx2160aqds.h
+F:	board/nxp/lx2160a/eth_lx2160aqds.h
 F:	include/configs/lx2160aqds.h
 F:	configs/lx2160aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2160a-qds.dts
@@ -33,7 +33,7 @@ LX2162AQDS BOARD
 M:	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
 M:	Wasim Khan <wasim.khan@nxp.com>
 S:	Maintained
-F:	board/freescale/lx2160a/eth_lx2162aqds.h
+F:	board/nxp/lx2160a/eth_lx2162aqds.h
 F:	include/configs/lx2162aqds.h
 F:	configs/lx2162aqds_tfa_defconfig
 F:	arch/arm/dts/fsl-lx2162a-qds.dts
diff --git a/board/freescale/lx2160a/Makefile b/board/nxp/lx2160a/Makefile
similarity index 100%
rename from board/freescale/lx2160a/Makefile
rename to board/nxp/lx2160a/Makefile
diff --git a/board/freescale/lx2160a/README b/board/nxp/lx2160a/README
similarity index 100%
rename from board/freescale/lx2160a/README
rename to board/nxp/lx2160a/README
diff --git a/board/freescale/lx2160a/ddr.c b/board/nxp/lx2160a/ddr.c
similarity index 100%
rename from board/freescale/lx2160a/ddr.c
rename to board/nxp/lx2160a/ddr.c
diff --git a/board/freescale/lx2160a/eth_lx2160aqds.c b/board/nxp/lx2160a/eth_lx2160aqds.c
similarity index 100%
rename from board/freescale/lx2160a/eth_lx2160aqds.c
rename to board/nxp/lx2160a/eth_lx2160aqds.c
diff --git a/board/freescale/lx2160a/eth_lx2160ardb.c b/board/nxp/lx2160a/eth_lx2160ardb.c
similarity index 100%
rename from board/freescale/lx2160a/eth_lx2160ardb.c
rename to board/nxp/lx2160a/eth_lx2160ardb.c
diff --git a/board/freescale/lx2160a/eth_lx2162aqds.c b/board/nxp/lx2160a/eth_lx2162aqds.c
similarity index 100%
rename from board/freescale/lx2160a/eth_lx2162aqds.c
rename to board/nxp/lx2160a/eth_lx2162aqds.c
diff --git a/board/freescale/lx2160a/lx2160a.c b/board/nxp/lx2160a/lx2160a.c
similarity index 100%
rename from board/freescale/lx2160a/lx2160a.c
rename to board/nxp/lx2160a/lx2160a.c
diff --git a/board/freescale/lx2160a/lx2160a.h b/board/nxp/lx2160a/lx2160a.h
similarity index 100%
rename from board/freescale/lx2160a/lx2160a.h
rename to board/nxp/lx2160a/lx2160a.h
diff --git a/board/freescale/m5208evbe/Kconfig b/board/nxp/m5208evbe/Kconfig
similarity index 88%
rename from board/freescale/m5208evbe/Kconfig
rename to board/nxp/m5208evbe/Kconfig
index 9b416afbdc7..a87b57222df 100644
--- a/board/freescale/m5208evbe/Kconfig
+++ b/board/nxp/m5208evbe/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5208evbe"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5208EVBE"
diff --git a/board/freescale/m5208evbe/MAINTAINERS b/board/nxp/m5208evbe/MAINTAINERS
similarity index 82%
rename from board/freescale/m5208evbe/MAINTAINERS
rename to board/nxp/m5208evbe/MAINTAINERS
index ff153034a4f..77fd91fe126 100644
--- a/board/freescale/m5208evbe/MAINTAINERS
+++ b/board/nxp/m5208evbe/MAINTAINERS
@@ -1,6 +1,6 @@
 M5208EVBE BOARD
 M:      Angelo Dureghello <angelo@kernel-space.org>
 S:	Maintained
-F:	board/freescale/m5208evbe/
+F:	board/nxp/m5208evbe/
 F:	include/configs/M5208EVBE.h
 F:	configs/M5208EVBE_defconfig
diff --git a/board/freescale/m5208evbe/Makefile b/board/nxp/m5208evbe/Makefile
similarity index 100%
rename from board/freescale/m5208evbe/Makefile
rename to board/nxp/m5208evbe/Makefile
diff --git a/board/freescale/m5208evbe/m5208evbe.c b/board/nxp/m5208evbe/m5208evbe.c
similarity index 100%
rename from board/freescale/m5208evbe/m5208evbe.c
rename to board/nxp/m5208evbe/m5208evbe.c
diff --git a/board/freescale/m5235evb/Kconfig b/board/nxp/m5235evb/Kconfig
similarity index 91%
rename from board/freescale/m5235evb/Kconfig
rename to board/nxp/m5235evb/Kconfig
index f0d4c8c7964..dd1bbea92eb 100644
--- a/board/freescale/m5235evb/Kconfig
+++ b/board/nxp/m5235evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5235evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5235EVB"
diff --git a/board/freescale/m5235evb/MAINTAINERS b/board/nxp/m5235evb/MAINTAINERS
similarity index 85%
rename from board/freescale/m5235evb/MAINTAINERS
rename to board/nxp/m5235evb/MAINTAINERS
index b15ac5f14ab..9716b78c36d 100644
--- a/board/freescale/m5235evb/MAINTAINERS
+++ b/board/nxp/m5235evb/MAINTAINERS
@@ -1,7 +1,7 @@
 M5235EVB BOARD
 M:	TsiChung Liew <Tsi-Chung.Liew@nxp.com>
 S:	Maintained
-F:	board/freescale/m5235evb/
+F:	board/nxp/m5235evb/
 F:	include/configs/M5235EVB.h
 F:	configs/M5235EVB_defconfig
 F:	configs/M5235EVB_Flash32_defconfig
diff --git a/board/freescale/m5235evb/Makefile b/board/nxp/m5235evb/Makefile
similarity index 100%
rename from board/freescale/m5235evb/Makefile
rename to board/nxp/m5235evb/Makefile
diff --git a/board/freescale/m5235evb/m5235evb.c b/board/nxp/m5235evb/m5235evb.c
similarity index 100%
rename from board/freescale/m5235evb/m5235evb.c
rename to board/nxp/m5235evb/m5235evb.c
diff --git a/board/freescale/m5249evb/Kconfig b/board/nxp/m5249evb/Kconfig
similarity index 88%
rename from board/freescale/m5249evb/Kconfig
rename to board/nxp/m5249evb/Kconfig
index 0f624776b55..2757e411936 100644
--- a/board/freescale/m5249evb/Kconfig
+++ b/board/nxp/m5249evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5249evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5249EVB"
diff --git a/board/freescale/m5249evb/MAINTAINERS b/board/nxp/m5249evb/MAINTAINERS
similarity index 82%
rename from board/freescale/m5249evb/MAINTAINERS
rename to board/nxp/m5249evb/MAINTAINERS
index 619e0cd20da..126fb27a848 100644
--- a/board/freescale/m5249evb/MAINTAINERS
+++ b/board/nxp/m5249evb/MAINTAINERS
@@ -1,6 +1,6 @@
 M5249EVB BOARD
 M:      Angelo Dureghello <angelo@kernel-space.org>
 S:	Maintained
-F:	board/freescale/m5249evb/
+F:	board/nxp/m5249evb/
 F:	include/configs/M5249EVB.h
 F:	configs/M5249EVB_defconfig
diff --git a/board/freescale/m5249evb/Makefile b/board/nxp/m5249evb/Makefile
similarity index 100%
rename from board/freescale/m5249evb/Makefile
rename to board/nxp/m5249evb/Makefile
diff --git a/board/freescale/m5249evb/m5249evb.c b/board/nxp/m5249evb/m5249evb.c
similarity index 100%
rename from board/freescale/m5249evb/m5249evb.c
rename to board/nxp/m5249evb/m5249evb.c
diff --git a/board/freescale/m5253demo/Kconfig b/board/nxp/m5253demo/Kconfig
similarity index 91%
rename from board/freescale/m5253demo/Kconfig
rename to board/nxp/m5253demo/Kconfig
index 0ecce875d14..987bcf9f3b0 100644
--- a/board/freescale/m5253demo/Kconfig
+++ b/board/nxp/m5253demo/Kconfig
@@ -11,7 +11,7 @@ config SYS_BOARD
 	default "m5253demo"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5253DEMO"
diff --git a/board/freescale/m5253demo/MAINTAINERS b/board/nxp/m5253demo/MAINTAINERS
similarity index 81%
rename from board/freescale/m5253demo/MAINTAINERS
rename to board/nxp/m5253demo/MAINTAINERS
index 9b27f4382ea..dfc12012e79 100644
--- a/board/freescale/m5253demo/MAINTAINERS
+++ b/board/nxp/m5253demo/MAINTAINERS
@@ -1,6 +1,6 @@
 M5253DEMO BOARD
 M:	TsiChung Liew <Tsi-Chung.Liew@nxp.com>
 S:	Maintained
-F:	board/freescale/m5253demo/
+F:	board/nxp/m5253demo/
 F:	include/configs/M5253DEMO.h
 F:	configs/M5253DEMO_defconfig
diff --git a/board/freescale/m5253demo/Makefile b/board/nxp/m5253demo/Makefile
similarity index 100%
rename from board/freescale/m5253demo/Makefile
rename to board/nxp/m5253demo/Makefile
diff --git a/board/freescale/m5253demo/flash.c b/board/nxp/m5253demo/flash.c
similarity index 100%
rename from board/freescale/m5253demo/flash.c
rename to board/nxp/m5253demo/flash.c
diff --git a/board/freescale/m5253demo/m5253demo.c b/board/nxp/m5253demo/m5253demo.c
similarity index 100%
rename from board/freescale/m5253demo/m5253demo.c
rename to board/nxp/m5253demo/m5253demo.c
diff --git a/board/freescale/m5272c3/Kconfig b/board/nxp/m5272c3/Kconfig
similarity index 88%
rename from board/freescale/m5272c3/Kconfig
rename to board/nxp/m5272c3/Kconfig
index aee0b239b3b..7a5a0f29085 100644
--- a/board/freescale/m5272c3/Kconfig
+++ b/board/nxp/m5272c3/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5272c3"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5272C3"
diff --git a/board/freescale/m5272c3/MAINTAINERS b/board/nxp/m5272c3/MAINTAINERS
similarity index 83%
rename from board/freescale/m5272c3/MAINTAINERS
rename to board/nxp/m5272c3/MAINTAINERS
index 692ab5b5829..723f6db1716 100644
--- a/board/freescale/m5272c3/MAINTAINERS
+++ b/board/nxp/m5272c3/MAINTAINERS
@@ -1,6 +1,6 @@
 M5272C3 BOARD
 M:      Angelo Dureghello <angelo@kernel-space.org>
 S:	Maintained
-F:	board/freescale/m5272c3/
+F:	board/nxp/m5272c3/
 F:	include/configs/M5272C3.h
 F:	configs/M5272C3_defconfig
diff --git a/board/freescale/m5272c3/Makefile b/board/nxp/m5272c3/Makefile
similarity index 100%
rename from board/freescale/m5272c3/Makefile
rename to board/nxp/m5272c3/Makefile
diff --git a/board/freescale/m5272c3/m5272c3.c b/board/nxp/m5272c3/m5272c3.c
similarity index 100%
rename from board/freescale/m5272c3/m5272c3.c
rename to board/nxp/m5272c3/m5272c3.c
diff --git a/board/freescale/m5275evb/Kconfig b/board/nxp/m5275evb/Kconfig
similarity index 88%
rename from board/freescale/m5275evb/Kconfig
rename to board/nxp/m5275evb/Kconfig
index 5a6de9c1c9e..99c9f192769 100644
--- a/board/freescale/m5275evb/Kconfig
+++ b/board/nxp/m5275evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5275evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5275EVB"
diff --git a/board/freescale/m5275evb/MAINTAINERS b/board/nxp/m5275evb/MAINTAINERS
similarity index 82%
rename from board/freescale/m5275evb/MAINTAINERS
rename to board/nxp/m5275evb/MAINTAINERS
index 065ae7bb1df..61a4cf3e324 100644
--- a/board/freescale/m5275evb/MAINTAINERS
+++ b/board/nxp/m5275evb/MAINTAINERS
@@ -1,6 +1,6 @@
 M5275EVB BOARD
 M:      Angelo Dureghello <angelo@kernel-space.org>
 S:	Maintained
-F:	board/freescale/m5275evb/
+F:	board/nxp/m5275evb/
 F:	include/configs/M5275EVB.h
 F:	configs/M5275EVB_defconfig
diff --git a/board/freescale/m5275evb/Makefile b/board/nxp/m5275evb/Makefile
similarity index 100%
rename from board/freescale/m5275evb/Makefile
rename to board/nxp/m5275evb/Makefile
diff --git a/board/freescale/m5275evb/m5275evb.c b/board/nxp/m5275evb/m5275evb.c
similarity index 100%
rename from board/freescale/m5275evb/m5275evb.c
rename to board/nxp/m5275evb/m5275evb.c
diff --git a/board/freescale/m5282evb/Kconfig b/board/nxp/m5282evb/Kconfig
similarity index 88%
rename from board/freescale/m5282evb/Kconfig
rename to board/nxp/m5282evb/Kconfig
index 2ffdd528f63..06e43400ac4 100644
--- a/board/freescale/m5282evb/Kconfig
+++ b/board/nxp/m5282evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5282evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5282EVB"
diff --git a/board/freescale/m5282evb/MAINTAINERS b/board/nxp/m5282evb/MAINTAINERS
similarity index 82%
rename from board/freescale/m5282evb/MAINTAINERS
rename to board/nxp/m5282evb/MAINTAINERS
index f141c89c3a5..8306581d3f0 100644
--- a/board/freescale/m5282evb/MAINTAINERS
+++ b/board/nxp/m5282evb/MAINTAINERS
@@ -1,6 +1,6 @@
 M5282EVB BOARD
 M:      Angelo Dureghello <angelo@kernel-space.org>
 S:	Maintained
-F:	board/freescale/m5282evb/
+F:	board/nxp/m5282evb/
 F:	include/configs/M5282EVB.h
 F:	configs/M5282EVB_defconfig
diff --git a/board/freescale/m5282evb/Makefile b/board/nxp/m5282evb/Makefile
similarity index 100%
rename from board/freescale/m5282evb/Makefile
rename to board/nxp/m5282evb/Makefile
diff --git a/board/freescale/m5282evb/m5282evb.c b/board/nxp/m5282evb/m5282evb.c
similarity index 100%
rename from board/freescale/m5282evb/m5282evb.c
rename to board/nxp/m5282evb/m5282evb.c
diff --git a/board/freescale/m53017evb/Kconfig b/board/nxp/m53017evb/Kconfig
similarity index 88%
rename from board/freescale/m53017evb/Kconfig
rename to board/nxp/m53017evb/Kconfig
index 8ab89e52b2e..3650134e742 100644
--- a/board/freescale/m53017evb/Kconfig
+++ b/board/nxp/m53017evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m53017evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M53017EVB"
diff --git a/board/freescale/m53017evb/MAINTAINERS b/board/nxp/m53017evb/MAINTAINERS
similarity index 81%
rename from board/freescale/m53017evb/MAINTAINERS
rename to board/nxp/m53017evb/MAINTAINERS
index ad5f0cea664..d07c409bc49 100644
--- a/board/freescale/m53017evb/MAINTAINERS
+++ b/board/nxp/m53017evb/MAINTAINERS
@@ -1,6 +1,6 @@
 M53017EVB BOARD
 M:	TsiChung Liew <Tsi-Chung.Liew@nxp.com>
 S:	Maintained
-F:	board/freescale/m53017evb/
+F:	board/nxp/m53017evb/
 F:	include/configs/M53017EVB.h
 F:	configs/M53017EVB_defconfig
diff --git a/board/freescale/m53017evb/Makefile b/board/nxp/m53017evb/Makefile
similarity index 100%
rename from board/freescale/m53017evb/Makefile
rename to board/nxp/m53017evb/Makefile
diff --git a/board/freescale/m53017evb/README b/board/nxp/m53017evb/README
similarity index 95%
rename from board/freescale/m53017evb/README
rename to board/nxp/m53017evb/README
index 34f05f3fdc7..25831629266 100644
--- a/board/freescale/m53017evb/README
+++ b/board/nxp/m53017evb/README
@@ -9,11 +9,11 @@ Created 10/22/08
 Changed files:
 ==============
 
-- board/freescale/m53017evb/m53017evb.c	Dram setup
-- board/freescale/m53017evb/mii.c	Mii access
-- board/freescale/m53017evb/Makefile	Makefile
-- board/freescale/m53017evb/config.mk	config make
-- board/freescale/m53017evb/u-boot.lds	Linker description
+- board/nxp/m53017evb/m53017evb.c	Dram setup
+- board/nxp/m53017evb/mii.c	Mii access
+- board/nxp/m53017evb/Makefile	Makefile
+- board/nxp/m53017evb/config.mk	config make
+- board/nxp/m53017evb/u-boot.lds	Linker description
 
 - arch/m68k/cpu/mcf532x/cpu.c			cpu specific code
 - arch/m68k/cpu/mcf532x/cpu_init.c		FBCS, Mux pins, icache and RTC extra regs
@@ -23,7 +23,7 @@ Changed files:
 - arch/m68k/cpu/mcf532x/config.mk			config make
 - arch/m68k/cpu/mcf532x/start.S			start up assembly code
 
-- board/freescale/m53017evb/README	his readme file
+- board/nxp/m53017evb/README	his readme file
 
 - drivers/net/mcffec.c			ColdFire common FEC driver
 - drivers/net/mcfmii.c			ColdFire common Mii driver
diff --git a/board/freescale/m53017evb/m53017evb.c b/board/nxp/m53017evb/m53017evb.c
similarity index 100%
rename from board/freescale/m53017evb/m53017evb.c
rename to board/nxp/m53017evb/m53017evb.c
diff --git a/board/freescale/m5329evb/Kconfig b/board/nxp/m5329evb/Kconfig
similarity index 88%
rename from board/freescale/m5329evb/Kconfig
rename to board/nxp/m5329evb/Kconfig
index 930fbba246d..73e4b42b201 100644
--- a/board/freescale/m5329evb/Kconfig
+++ b/board/nxp/m5329evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5329evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5329EVB"
diff --git a/board/freescale/m5329evb/MAINTAINERS b/board/nxp/m5329evb/MAINTAINERS
similarity index 84%
rename from board/freescale/m5329evb/MAINTAINERS
rename to board/nxp/m5329evb/MAINTAINERS
index 2f7dd2d4560..b9b07545156 100644
--- a/board/freescale/m5329evb/MAINTAINERS
+++ b/board/nxp/m5329evb/MAINTAINERS
@@ -1,7 +1,7 @@
 M5329EVB BOARD
 M:	TsiChung Liew <Tsi-Chung.Liew@nxp.com>
 S:	Maintained
-F:	board/freescale/m5329evb/
+F:	board/nxp/m5329evb/
 F:	include/configs/M5329EVB.h
 F:	configs/M5329AFEE_defconfig
 F:	configs/M5329BFEE_defconfig
diff --git a/board/freescale/m5329evb/Makefile b/board/nxp/m5329evb/Makefile
similarity index 100%
rename from board/freescale/m5329evb/Makefile
rename to board/nxp/m5329evb/Makefile
diff --git a/board/freescale/m5329evb/m5329evb.c b/board/nxp/m5329evb/m5329evb.c
similarity index 100%
rename from board/freescale/m5329evb/m5329evb.c
rename to board/nxp/m5329evb/m5329evb.c
diff --git a/board/freescale/m5329evb/nand.c b/board/nxp/m5329evb/nand.c
similarity index 100%
rename from board/freescale/m5329evb/nand.c
rename to board/nxp/m5329evb/nand.c
diff --git a/board/freescale/m5373evb/Kconfig b/board/nxp/m5373evb/Kconfig
similarity index 88%
rename from board/freescale/m5373evb/Kconfig
rename to board/nxp/m5373evb/Kconfig
index 67d049d79eb..5ac013771f1 100644
--- a/board/freescale/m5373evb/Kconfig
+++ b/board/nxp/m5373evb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "m5373evb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "M5373EVB"
diff --git a/board/freescale/m5373evb/MAINTAINERS b/board/nxp/m5373evb/MAINTAINERS
similarity index 81%
rename from board/freescale/m5373evb/MAINTAINERS
rename to board/nxp/m5373evb/MAINTAINERS
index acb7a43ed64..5a185d1220a 100644
--- a/board/freescale/m5373evb/MAINTAINERS
+++ b/board/nxp/m5373evb/MAINTAINERS
@@ -1,6 +1,6 @@
 M5373EVB BOARD
 M:	TsiChung Liew <Tsi-Chung.Liew@nxp.com>
 S:	Maintained
-F:	board/freescale/m5373evb/
+F:	board/nxp/m5373evb/
 F:	include/configs/M5373EVB.h
 F:	configs/M5373EVB_defconfig
diff --git a/board/freescale/m5373evb/Makefile b/board/nxp/m5373evb/Makefile
similarity index 100%
rename from board/freescale/m5373evb/Makefile
rename to board/nxp/m5373evb/Makefile
diff --git a/board/freescale/m5373evb/README b/board/nxp/m5373evb/README
similarity index 97%
rename from board/freescale/m5373evb/README
rename to board/nxp/m5373evb/README
index 7240648796b..c7130b32251 100644
--- a/board/freescale/m5373evb/README
+++ b/board/nxp/m5373evb/README
@@ -9,11 +9,11 @@ Created 11/08/07
 Changed files:
 ==============
 
-- board/freescale/m5373evb/m5373evb.c	Dram setup
-- board/freescale/m5373evb/mii.c	Mii access
-- board/freescale/m5373evb/Makefile	Makefile
-- board/freescale/m5373evb/config.mk	config make
-- board/freescale/m5373evb/u-boot.lds	Linker description
+- board/nxp/m5373evb/m5373evb.c	Dram setup
+- board/nxp/m5373evb/mii.c	Mii access
+- board/nxp/m5373evb/Makefile	Makefile
+- board/nxp/m5373evb/config.mk	config make
+- board/nxp/m5373evb/u-boot.lds	Linker description
 
 - arch/m68k/cpu/mcf532x/cpu.c		cpu specific code
 - arch/m68k/cpu/mcf532x/cpu_init.c	FBCS, Mux pins, icache and RTC extra regs
@@ -23,7 +23,7 @@ Changed files:
 - arch/m68k/cpu/mcf532x/config.mk		config make
 - arch/m68k/cpu/mcf532x/start.S		start up assembly code
 
-- board/freescale/m5373evb/README	This readme file
+- board/nxp/m5373evb/README	This readme file
 
 - drivers/net/mcffec.c		ColdFire common FEC driver
 - drivers/serial/mcfuart.c	ColdFire common UART driver
diff --git a/board/freescale/m5373evb/m5373evb.c b/board/nxp/m5373evb/m5373evb.c
similarity index 100%
rename from board/freescale/m5373evb/m5373evb.c
rename to board/nxp/m5373evb/m5373evb.c
diff --git a/board/freescale/m5373evb/nand.c b/board/nxp/m5373evb/nand.c
similarity index 100%
rename from board/freescale/m5373evb/nand.c
rename to board/nxp/m5373evb/nand.c
diff --git a/board/freescale/mpc837xerdb/Kconfig b/board/nxp/mpc837xerdb/Kconfig
similarity index 88%
rename from board/freescale/mpc837xerdb/Kconfig
rename to board/nxp/mpc837xerdb/Kconfig
index 3779625edd5..f11f6f5bfea 100644
--- a/board/freescale/mpc837xerdb/Kconfig
+++ b/board/nxp/mpc837xerdb/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "mpc837xerdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "MPC837XERDB"
diff --git a/board/freescale/mpc837xerdb/MAINTAINERS b/board/nxp/mpc837xerdb/MAINTAINERS
similarity index 84%
rename from board/freescale/mpc837xerdb/MAINTAINERS
rename to board/nxp/mpc837xerdb/MAINTAINERS
index 9f44a37a0d9..9b05a6ad421 100644
--- a/board/freescale/mpc837xerdb/MAINTAINERS
+++ b/board/nxp/mpc837xerdb/MAINTAINERS
@@ -1,7 +1,7 @@
 MPC837XERDB BOARD
 M:	Sinan Akman <sinan@writeme.com>
 S:	Maintained
-F:	board/freescale/mpc837xerdb/
+F:	board/nxp/mpc837xerdb/
 F:	include/configs/MPC837XERDB.h
 F:	configs/MPC837XERDB_defconfig
 F:	configs/MPC837XERDB_SLAVE_defconfig
diff --git a/board/freescale/mpc837xerdb/Makefile b/board/nxp/mpc837xerdb/Makefile
similarity index 100%
rename from board/freescale/mpc837xerdb/Makefile
rename to board/nxp/mpc837xerdb/Makefile
diff --git a/board/freescale/mpc837xerdb/README b/board/nxp/mpc837xerdb/README
similarity index 100%
rename from board/freescale/mpc837xerdb/README
rename to board/nxp/mpc837xerdb/README
diff --git a/board/freescale/mpc837xerdb/mpc837xerdb.c b/board/nxp/mpc837xerdb/mpc837xerdb.c
similarity index 100%
rename from board/freescale/mpc837xerdb/mpc837xerdb.c
rename to board/nxp/mpc837xerdb/mpc837xerdb.c
diff --git a/board/freescale/mpc8548cds/Kconfig b/board/nxp/mpc8548cds/Kconfig
similarity index 93%
rename from board/freescale/mpc8548cds/Kconfig
rename to board/nxp/mpc8548cds/Kconfig
index bb0a0758964..e43c2030e00 100644
--- a/board/freescale/mpc8548cds/Kconfig
+++ b/board/nxp/mpc8548cds/Kconfig
@@ -13,7 +13,7 @@ config SYS_BOARD
 	default "mpc8548cds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "MPC8548CDS"
diff --git a/board/freescale/mpc8548cds/MAINTAINERS b/board/nxp/mpc8548cds/MAINTAINERS
similarity index 87%
rename from board/freescale/mpc8548cds/MAINTAINERS
rename to board/nxp/mpc8548cds/MAINTAINERS
index fbbedb1d1d1..51e62a34365 100644
--- a/board/freescale/mpc8548cds/MAINTAINERS
+++ b/board/nxp/mpc8548cds/MAINTAINERS
@@ -1,7 +1,7 @@
 MPC8548CDS BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/mpc8548cds/
+F:	board/nxp/mpc8548cds/
 F:	include/configs/MPC8548CDS.h
 F:	configs/MPC8548CDS_defconfig
 F:	configs/MPC8548CDS_36BIT_defconfig
diff --git a/board/freescale/mpc8548cds/Makefile b/board/nxp/mpc8548cds/Makefile
similarity index 100%
rename from board/freescale/mpc8548cds/Makefile
rename to board/nxp/mpc8548cds/Makefile
diff --git a/board/freescale/mpc8548cds/ddr.c b/board/nxp/mpc8548cds/ddr.c
similarity index 100%
rename from board/freescale/mpc8548cds/ddr.c
rename to board/nxp/mpc8548cds/ddr.c
diff --git a/board/freescale/mpc8548cds/law.c b/board/nxp/mpc8548cds/law.c
similarity index 100%
rename from board/freescale/mpc8548cds/law.c
rename to board/nxp/mpc8548cds/law.c
diff --git a/board/freescale/mpc8548cds/mpc8548cds.c b/board/nxp/mpc8548cds/mpc8548cds.c
similarity index 100%
rename from board/freescale/mpc8548cds/mpc8548cds.c
rename to board/nxp/mpc8548cds/mpc8548cds.c
diff --git a/board/freescale/mpc8548cds/tlb.c b/board/nxp/mpc8548cds/tlb.c
similarity index 100%
rename from board/freescale/mpc8548cds/tlb.c
rename to board/nxp/mpc8548cds/tlb.c
diff --git a/board/freescale/mx23evk/Kconfig b/board/nxp/mx23evk/Kconfig
similarity index 88%
rename from board/freescale/mx23evk/Kconfig
rename to board/nxp/mx23evk/Kconfig
index 51a8f9f773c..9f57590386b 100644
--- a/board/freescale/mx23evk/Kconfig
+++ b/board/nxp/mx23evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx23evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "mxs"
diff --git a/board/freescale/mx23evk/MAINTAINERS b/board/nxp/mx23evk/MAINTAINERS
similarity index 87%
rename from board/freescale/mx23evk/MAINTAINERS
rename to board/nxp/mx23evk/MAINTAINERS
index 122b70cd719..5ac8c3e8a86 100644
--- a/board/freescale/mx23evk/MAINTAINERS
+++ b/board/nxp/mx23evk/MAINTAINERS
@@ -2,7 +2,7 @@ MX23EVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Otavio Salvador <otavio@ossystems.com.br>
 S:	Maintained
-F:	board/freescale/mx23evk/
+F:	board/nxp/mx23evk/
 F:	arch/arm/dts/imx23-evk.dts
 F:	include/configs/mx23evk.h
 F:	configs/mx23evk_defconfig
diff --git a/board/freescale/mx23evk/Makefile b/board/nxp/mx23evk/Makefile
similarity index 100%
rename from board/freescale/mx23evk/Makefile
rename to board/nxp/mx23evk/Makefile
diff --git a/board/freescale/mx23evk/mx23evk.c b/board/nxp/mx23evk/mx23evk.c
similarity index 100%
rename from board/freescale/mx23evk/mx23evk.c
rename to board/nxp/mx23evk/mx23evk.c
diff --git a/board/freescale/mx23evk/spl_boot.c b/board/nxp/mx23evk/spl_boot.c
similarity index 100%
rename from board/freescale/mx23evk/spl_boot.c
rename to board/nxp/mx23evk/spl_boot.c
diff --git a/board/freescale/mx28evk/Kconfig b/board/nxp/mx28evk/Kconfig
similarity index 88%
rename from board/freescale/mx28evk/Kconfig
rename to board/nxp/mx28evk/Kconfig
index 39777bd70fa..1643196af86 100644
--- a/board/freescale/mx28evk/Kconfig
+++ b/board/nxp/mx28evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx28evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "mxs"
diff --git a/board/freescale/mx28evk/MAINTAINERS b/board/nxp/mx28evk/MAINTAINERS
similarity index 84%
rename from board/freescale/mx28evk/MAINTAINERS
rename to board/nxp/mx28evk/MAINTAINERS
index f20baa91c67..4e6441a8bf5 100644
--- a/board/freescale/mx28evk/MAINTAINERS
+++ b/board/nxp/mx28evk/MAINTAINERS
@@ -1,7 +1,7 @@
 MX28EVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/mx28evk/
+F:	board/nxp/mx28evk/
 F:	arch/arm/dts/imx28-evk.dts
 F:	include/configs/mx28evk.h
 F:	configs/mx28evk_defconfig
diff --git a/board/freescale/mx28evk/Makefile b/board/nxp/mx28evk/Makefile
similarity index 100%
rename from board/freescale/mx28evk/Makefile
rename to board/nxp/mx28evk/Makefile
diff --git a/board/freescale/mx28evk/README b/board/nxp/mx28evk/README
similarity index 97%
rename from board/freescale/mx28evk/README
rename to board/nxp/mx28evk/README
index d32f0efb332..dfe83b7a7a7 100644
--- a/board/freescale/mx28evk/README
+++ b/board/nxp/mx28evk/README
@@ -8,7 +8,7 @@ Files of the MX28EVK port
 
 arch/arm/cpu/arm926ejs/mxs/	- The CPU support code for the Freescale i.MX28
 arch/arm/include/asm/arch-mxs/	- Header files for the Freescale i.MX28
-board/freescale/mx28evk/	- MX28EVK board specific files
+board/nxp/mx28evk/	- MX28EVK board specific files
 include/configs/mx28evk.h	- MX28EVK configuration file
 
 Jumper configuration
diff --git a/board/freescale/mx28evk/iomux.c b/board/nxp/mx28evk/iomux.c
similarity index 100%
rename from board/freescale/mx28evk/iomux.c
rename to board/nxp/mx28evk/iomux.c
diff --git a/board/freescale/mx28evk/mx28evk.c b/board/nxp/mx28evk/mx28evk.c
similarity index 100%
rename from board/freescale/mx28evk/mx28evk.c
rename to board/nxp/mx28evk/mx28evk.c
diff --git a/board/freescale/mx51evk/Kconfig b/board/nxp/mx51evk/Kconfig
similarity index 71%
rename from board/freescale/mx51evk/Kconfig
rename to board/nxp/mx51evk/Kconfig
index a26b539536e..58f22cf77b0 100644
--- a/board/freescale/mx51evk/Kconfig
+++ b/board/nxp/mx51evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx51evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "mx5"
@@ -13,6 +13,6 @@ config SYS_CONFIG_NAME
 	default "mx51evk"
 
 config IMX_CONFIG
-	default "board/freescale/mx51evk/imximage.cfg"
+	default "board/nxp/mx51evk/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx51evk/MAINTAINERS b/board/nxp/mx51evk/MAINTAINERS
similarity index 81%
rename from board/freescale/mx51evk/MAINTAINERS
rename to board/nxp/mx51evk/MAINTAINERS
index 025a5f8b582..1b44fc419dd 100644
--- a/board/freescale/mx51evk/MAINTAINERS
+++ b/board/nxp/mx51evk/MAINTAINERS
@@ -1,6 +1,6 @@
 MX51EVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/mx51evk/
+F:	board/nxp/mx51evk/
 F:	include/configs/mx51evk.h
 F:	configs/mx51evk_defconfig
diff --git a/board/freescale/mx51evk/Makefile b/board/nxp/mx51evk/Makefile
similarity index 100%
rename from board/freescale/mx51evk/Makefile
rename to board/nxp/mx51evk/Makefile
diff --git a/board/freescale/mx51evk/imximage.cfg b/board/nxp/mx51evk/imximage.cfg
similarity index 100%
rename from board/freescale/mx51evk/imximage.cfg
rename to board/nxp/mx51evk/imximage.cfg
diff --git a/board/freescale/mx51evk/mx51evk.c b/board/nxp/mx51evk/mx51evk.c
similarity index 100%
rename from board/freescale/mx51evk/mx51evk.c
rename to board/nxp/mx51evk/mx51evk.c
diff --git a/board/freescale/mx53loco/Kconfig b/board/nxp/mx53loco/Kconfig
similarity index 75%
rename from board/freescale/mx53loco/Kconfig
rename to board/nxp/mx53loco/Kconfig
index 5dcdcd9f725..e9f56cdc76a 100644
--- a/board/freescale/mx53loco/Kconfig
+++ b/board/nxp/mx53loco/Kconfig
@@ -7,7 +7,7 @@ config SYS_BOARD
 	default "mx53loco"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_SOC
 	default "mx5"
@@ -16,6 +16,6 @@ config SYS_CONFIG_NAME
 	default "mx53loco"
 
 config IMX_CONFIG
-	default "board/freescale/mx53loco/imximage.cfg"
+	default "board/nxp/mx53loco/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx53loco/MAINTAINERS b/board/nxp/mx53loco/MAINTAINERS
similarity index 84%
rename from board/freescale/mx53loco/MAINTAINERS
rename to board/nxp/mx53loco/MAINTAINERS
index 6c237518773..dbc85045a1c 100644
--- a/board/freescale/mx53loco/MAINTAINERS
+++ b/board/nxp/mx53loco/MAINTAINERS
@@ -2,6 +2,6 @@ MX53LOCO BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Jason Liu <jason.hui.liu@nxp.com>
 S:	Maintained
-F:	board/freescale/mx53loco/
+F:	board/nxp/mx53loco/
 F:	include/configs/mx53loco.h
 F:	configs/mx53loco_defconfig
diff --git a/board/freescale/mx53loco/Makefile b/board/nxp/mx53loco/Makefile
similarity index 100%
rename from board/freescale/mx53loco/Makefile
rename to board/nxp/mx53loco/Makefile
diff --git a/board/freescale/mx53loco/imximage.cfg b/board/nxp/mx53loco/imximage.cfg
similarity index 100%
rename from board/freescale/mx53loco/imximage.cfg
rename to board/nxp/mx53loco/imximage.cfg
diff --git a/board/freescale/mx53loco/mx53loco.c b/board/nxp/mx53loco/mx53loco.c
similarity index 100%
rename from board/freescale/mx53loco/mx53loco.c
rename to board/nxp/mx53loco/mx53loco.c
diff --git a/board/freescale/mx6memcal/Kconfig b/board/nxp/mx6memcal/Kconfig
similarity index 99%
rename from board/freescale/mx6memcal/Kconfig
rename to board/nxp/mx6memcal/Kconfig
index 2d5c206ae45..a6c39d5e4d1 100644
--- a/board/freescale/mx6memcal/Kconfig
+++ b/board/nxp/mx6memcal/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx6memcal"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6memcal"
diff --git a/board/freescale/mx6memcal/MAINTAINERS b/board/nxp/mx6memcal/MAINTAINERS
similarity index 80%
rename from board/freescale/mx6memcal/MAINTAINERS
rename to board/nxp/mx6memcal/MAINTAINERS
index 5da38f7109b..a5fbe62bb39 100644
--- a/board/freescale/mx6memcal/MAINTAINERS
+++ b/board/nxp/mx6memcal/MAINTAINERS
@@ -1,7 +1,7 @@
 MX6MEMCAL BOARD
 M:	Eric Nelson <eric@nelint.com>
 S:	Maintained
-F:	board/freescale/mx6memcal/
+F:	board/nxp/mx6memcal/
 F:	include/configs/mx6memcal.h
 F:	configs/mx6memcal_defconfig
 
diff --git a/board/freescale/mx6memcal/Makefile b/board/nxp/mx6memcal/Makefile
similarity index 100%
rename from board/freescale/mx6memcal/Makefile
rename to board/nxp/mx6memcal/Makefile
diff --git a/board/freescale/mx6memcal/README b/board/nxp/mx6memcal/README
similarity index 100%
rename from board/freescale/mx6memcal/README
rename to board/nxp/mx6memcal/README
diff --git a/board/freescale/mx6memcal/mx6memcal.c b/board/nxp/mx6memcal/mx6memcal.c
similarity index 100%
rename from board/freescale/mx6memcal/mx6memcal.c
rename to board/nxp/mx6memcal/mx6memcal.c
diff --git a/board/freescale/mx6memcal/spl.c b/board/nxp/mx6memcal/spl.c
similarity index 100%
rename from board/freescale/mx6memcal/spl.c
rename to board/nxp/mx6memcal/spl.c
diff --git a/board/freescale/mx6sabreauto/Kconfig b/board/nxp/mx6sabreauto/Kconfig
similarity index 86%
rename from board/freescale/mx6sabreauto/Kconfig
rename to board/nxp/mx6sabreauto/Kconfig
index 5b4faf6d5fd..145ed6e2958 100644
--- a/board/freescale/mx6sabreauto/Kconfig
+++ b/board/nxp/mx6sabreauto/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx6sabreauto"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6sabreauto"
diff --git a/board/freescale/mx6sabreauto/MAINTAINERS b/board/nxp/mx6sabreauto/MAINTAINERS
similarity index 83%
rename from board/freescale/mx6sabreauto/MAINTAINERS
rename to board/nxp/mx6sabreauto/MAINTAINERS
index 6179d672c39..4942e4d5bca 100644
--- a/board/freescale/mx6sabreauto/MAINTAINERS
+++ b/board/nxp/mx6sabreauto/MAINTAINERS
@@ -2,6 +2,6 @@ MX6SABREAUTO BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6sabreauto/
+F:	board/nxp/mx6sabreauto/
 F:	include/configs/mx6sabreauto.h
 F:	configs/mx6sabreauto_defconfig
diff --git a/board/freescale/mx6sabreauto/Makefile b/board/nxp/mx6sabreauto/Makefile
similarity index 100%
rename from board/freescale/mx6sabreauto/Makefile
rename to board/nxp/mx6sabreauto/Makefile
diff --git a/board/freescale/mx6sabreauto/mx6sabreauto.c b/board/nxp/mx6sabreauto/mx6sabreauto.c
similarity index 100%
rename from board/freescale/mx6sabreauto/mx6sabreauto.c
rename to board/nxp/mx6sabreauto/mx6sabreauto.c
diff --git a/board/freescale/mx6sabresd/Kconfig b/board/nxp/mx6sabresd/Kconfig
similarity index 86%
rename from board/freescale/mx6sabresd/Kconfig
rename to board/nxp/mx6sabresd/Kconfig
index e87dea0d7a2..f657401c37e 100644
--- a/board/freescale/mx6sabresd/Kconfig
+++ b/board/nxp/mx6sabresd/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx6sabresd"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6sabresd"
diff --git a/board/freescale/mx6sabresd/MAINTAINERS b/board/nxp/mx6sabresd/MAINTAINERS
similarity index 81%
rename from board/freescale/mx6sabresd/MAINTAINERS
rename to board/nxp/mx6sabresd/MAINTAINERS
index 5e256ef163e..3839dee1a17 100644
--- a/board/freescale/mx6sabresd/MAINTAINERS
+++ b/board/nxp/mx6sabresd/MAINTAINERS
@@ -1,6 +1,6 @@
 MX6SABRESD BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/mx6sabresd/
+F:	board/nxp/mx6sabresd/
 F:	include/configs/mx6sabresd.h
 F:	configs/mx6sabresd_defconfig
diff --git a/board/freescale/mx6sabresd/Makefile b/board/nxp/mx6sabresd/Makefile
similarity index 100%
rename from board/freescale/mx6sabresd/Makefile
rename to board/nxp/mx6sabresd/Makefile
diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/nxp/mx6sabresd/mx6sabresd.c
similarity index 100%
rename from board/freescale/mx6sabresd/mx6sabresd.c
rename to board/nxp/mx6sabresd/mx6sabresd.c
diff --git a/board/freescale/mx6slevk/Kconfig b/board/nxp/mx6slevk/Kconfig
similarity index 67%
rename from board/freescale/mx6slevk/Kconfig
rename to board/nxp/mx6slevk/Kconfig
index e6bbb4194f4..862bc8396cd 100644
--- a/board/freescale/mx6slevk/Kconfig
+++ b/board/nxp/mx6slevk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx6slevk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6slevk"
 
 config IMX_CONFIG
-	default "board/freescale/mx6slevk/imximage.cfg"
+	default "board/nxp/mx6slevk/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx6slevk/MAINTAINERS b/board/nxp/mx6slevk/MAINTAINERS
similarity index 88%
rename from board/freescale/mx6slevk/MAINTAINERS
rename to board/nxp/mx6slevk/MAINTAINERS
index ae87fe472bc..4410358ea08 100644
--- a/board/freescale/mx6slevk/MAINTAINERS
+++ b/board/nxp/mx6slevk/MAINTAINERS
@@ -2,7 +2,7 @@ MX6SLEVK BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6slevk/
+F:	board/nxp/mx6slevk/
 F:	include/configs/mx6slevk.h
 F:	configs/mx6slevk_defconfig
 F:	configs/mx6slevk_spl_defconfig
diff --git a/board/freescale/mx6slevk/Makefile b/board/nxp/mx6slevk/Makefile
similarity index 100%
rename from board/freescale/mx6slevk/Makefile
rename to board/nxp/mx6slevk/Makefile
diff --git a/board/freescale/mx6slevk/imximage.cfg b/board/nxp/mx6slevk/imximage.cfg
similarity index 100%
rename from board/freescale/mx6slevk/imximage.cfg
rename to board/nxp/mx6slevk/imximage.cfg
diff --git a/board/freescale/mx6slevk/mx6slevk.c b/board/nxp/mx6slevk/mx6slevk.c
similarity index 100%
rename from board/freescale/mx6slevk/mx6slevk.c
rename to board/nxp/mx6slevk/mx6slevk.c
diff --git a/board/freescale/mx6sllevk/Kconfig b/board/nxp/mx6sllevk/Kconfig
similarity index 67%
rename from board/freescale/mx6sllevk/Kconfig
rename to board/nxp/mx6sllevk/Kconfig
index d47f1fa9096..a2bfaca9c29 100644
--- a/board/freescale/mx6sllevk/Kconfig
+++ b/board/nxp/mx6sllevk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx6sllevk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6sllevk"
 
 config IMX_CONFIG
-	default "board/freescale/mx6sllevk/imximage.cfg"
+	default "board/nxp/mx6sllevk/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx6sllevk/MAINTAINERS b/board/nxp/mx6sllevk/MAINTAINERS
similarity index 84%
rename from board/freescale/mx6sllevk/MAINTAINERS
rename to board/nxp/mx6sllevk/MAINTAINERS
index b82273c0162..a11a5a6653e 100644
--- a/board/freescale/mx6sllevk/MAINTAINERS
+++ b/board/nxp/mx6sllevk/MAINTAINERS
@@ -1,7 +1,7 @@
 MX6SLLEVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6sllevk/
+F:	board/nxp/mx6sllevk/
 F:	include/configs/mx6sllevk.h
 F:	configs/mx6sllevk_defconfig
 F:	configs/mx6sllevk_plugin_defconfig
diff --git a/board/freescale/mx6sllevk/Makefile b/board/nxp/mx6sllevk/Makefile
similarity index 100%
rename from board/freescale/mx6sllevk/Makefile
rename to board/nxp/mx6sllevk/Makefile
diff --git a/board/freescale/mx6sllevk/imximage.cfg b/board/nxp/mx6sllevk/imximage.cfg
similarity index 98%
rename from board/freescale/mx6sllevk/imximage.cfg
rename to board/nxp/mx6sllevk/imximage.cfg
index 550be3f6c12..7bb91015688 100644
--- a/board/freescale/mx6sllevk/imximage.cfg
+++ b/board/nxp/mx6sllevk/imximage.cfg
@@ -23,7 +23,7 @@ BOOT_FROM	sd
 
 #ifdef CONFIG_USE_IMXIMG_PLUGIN
 /*PLUGIN    plugin-binary-file    IRAM_FREE_START_ADDR*/
-PLUGIN	board/freescale/mx6sllevk/plugin.bin 0x00907000
+PLUGIN	board/nxp/mx6sllevk/plugin.bin 0x00907000
 #else
 
 #ifdef CONFIG_IMX_HAB
diff --git a/board/freescale/mx6sllevk/mx6sllevk.c b/board/nxp/mx6sllevk/mx6sllevk.c
similarity index 100%
rename from board/freescale/mx6sllevk/mx6sllevk.c
rename to board/nxp/mx6sllevk/mx6sllevk.c
diff --git a/board/freescale/mx6sllevk/plugin.S b/board/nxp/mx6sllevk/plugin.S
similarity index 100%
rename from board/freescale/mx6sllevk/plugin.S
rename to board/nxp/mx6sllevk/plugin.S
diff --git a/board/freescale/mx6sxsabreauto/Kconfig b/board/nxp/mx6sxsabreauto/Kconfig
similarity index 68%
rename from board/freescale/mx6sxsabreauto/Kconfig
rename to board/nxp/mx6sxsabreauto/Kconfig
index e6da7b38f91..6d1ae40adb7 100644
--- a/board/freescale/mx6sxsabreauto/Kconfig
+++ b/board/nxp/mx6sxsabreauto/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx6sxsabreauto"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6sxsabreauto"
 
 config IMX_CONFIG
-	default "board/freescale/mx6sxsabreauto/imximage.cfg"
+	default "board/nxp/mx6sxsabreauto/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx6sxsabreauto/MAINTAINERS b/board/nxp/mx6sxsabreauto/MAINTAINERS
similarity index 79%
rename from board/freescale/mx6sxsabreauto/MAINTAINERS
rename to board/nxp/mx6sxsabreauto/MAINTAINERS
index 8dc62e5e3e5..70036f8e3d6 100644
--- a/board/freescale/mx6sxsabreauto/MAINTAINERS
+++ b/board/nxp/mx6sxsabreauto/MAINTAINERS
@@ -1,6 +1,6 @@
 MX6SXSABREAUTO BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6sxsabreauto/
+F:	board/nxp/mx6sxsabreauto/
 F:	include/configs/mx6sxsabreauto.h
 F:	configs/mx6sxsabreauto_defconfig
diff --git a/board/freescale/mx6sxsabreauto/Makefile b/board/nxp/mx6sxsabreauto/Makefile
similarity index 100%
rename from board/freescale/mx6sxsabreauto/Makefile
rename to board/nxp/mx6sxsabreauto/Makefile
diff --git a/board/freescale/mx6sxsabreauto/imximage.cfg b/board/nxp/mx6sxsabreauto/imximage.cfg
similarity index 100%
rename from board/freescale/mx6sxsabreauto/imximage.cfg
rename to board/nxp/mx6sxsabreauto/imximage.cfg
diff --git a/board/freescale/mx6sxsabreauto/mx6sxsabreauto.c b/board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
similarity index 100%
rename from board/freescale/mx6sxsabreauto/mx6sxsabreauto.c
rename to board/nxp/mx6sxsabreauto/mx6sxsabreauto.c
diff --git a/board/freescale/mx6sxsabresd/Kconfig b/board/nxp/mx6sxsabresd/Kconfig
similarity index 68%
rename from board/freescale/mx6sxsabresd/Kconfig
rename to board/nxp/mx6sxsabresd/Kconfig
index 88ac7ee8050..90f4978d24c 100644
--- a/board/freescale/mx6sxsabresd/Kconfig
+++ b/board/nxp/mx6sxsabresd/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx6sxsabresd"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6sxsabresd"
 
 config IMX_CONFIG
-	default "board/freescale/mx6sxsabresd/imximage.cfg"
+	default "board/nxp/mx6sxsabresd/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx6sxsabresd/MAINTAINERS b/board/nxp/mx6sxsabresd/MAINTAINERS
similarity index 80%
rename from board/freescale/mx6sxsabresd/MAINTAINERS
rename to board/nxp/mx6sxsabresd/MAINTAINERS
index b3c8b56f1f1..1dd21fc3c69 100644
--- a/board/freescale/mx6sxsabresd/MAINTAINERS
+++ b/board/nxp/mx6sxsabresd/MAINTAINERS
@@ -1,6 +1,6 @@
 MX6SXSABRESD BOARD
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/mx6sxsabresd/
+F:	board/nxp/mx6sxsabresd/
 F:	include/configs/mx6sxsabresd.h
 F:	configs/mx6sxsabresd_defconfig
diff --git a/board/freescale/mx6sxsabresd/Makefile b/board/nxp/mx6sxsabresd/Makefile
similarity index 100%
rename from board/freescale/mx6sxsabresd/Makefile
rename to board/nxp/mx6sxsabresd/Makefile
diff --git a/board/freescale/mx6sxsabresd/imximage.cfg b/board/nxp/mx6sxsabresd/imximage.cfg
similarity index 100%
rename from board/freescale/mx6sxsabresd/imximage.cfg
rename to board/nxp/mx6sxsabresd/imximage.cfg
diff --git a/board/freescale/mx6sxsabresd/mx6sxsabresd.c b/board/nxp/mx6sxsabresd/mx6sxsabresd.c
similarity index 100%
rename from board/freescale/mx6sxsabresd/mx6sxsabresd.c
rename to board/nxp/mx6sxsabresd/mx6sxsabresd.c
diff --git a/board/freescale/mx6ul_14x14_evk/Kconfig b/board/nxp/mx6ul_14x14_evk/Kconfig
similarity index 89%
rename from board/freescale/mx6ul_14x14_evk/Kconfig
rename to board/nxp/mx6ul_14x14_evk/Kconfig
index 8210cd3cb88..03b5318d5da 100644
--- a/board/freescale/mx6ul_14x14_evk/Kconfig
+++ b/board/nxp/mx6ul_14x14_evk/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "mx6ul_14x14_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6ul_14x14_evk"
diff --git a/board/freescale/mx6ul_14x14_evk/MAINTAINERS b/board/nxp/mx6ul_14x14_evk/MAINTAINERS
similarity index 82%
rename from board/freescale/mx6ul_14x14_evk/MAINTAINERS
rename to board/nxp/mx6ul_14x14_evk/MAINTAINERS
index 7c7a196d22c..4aa5e8e4702 100644
--- a/board/freescale/mx6ul_14x14_evk/MAINTAINERS
+++ b/board/nxp/mx6ul_14x14_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 MX6ULEVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6ul_14x14_evk/
+F:	board/nxp/mx6ul_14x14_evk/
 F:	include/configs/mx6ul_14x14_evk.h
 F:	configs/mx6ul_14x14_evk_defconfig
 F:	configs/mx6ul_9x9_evk_defconfig
diff --git a/board/freescale/mx6ul_14x14_evk/Makefile b/board/nxp/mx6ul_14x14_evk/Makefile
similarity index 100%
rename from board/freescale/mx6ul_14x14_evk/Makefile
rename to board/nxp/mx6ul_14x14_evk/Makefile
diff --git a/board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c b/board/nxp/mx6ul_14x14_evk/mx6ul_14x14_evk.c
similarity index 100%
rename from board/freescale/mx6ul_14x14_evk/mx6ul_14x14_evk.c
rename to board/nxp/mx6ul_14x14_evk/mx6ul_14x14_evk.c
diff --git a/board/freescale/mx6ullevk/Kconfig b/board/nxp/mx6ullevk/Kconfig
similarity index 68%
rename from board/freescale/mx6ullevk/Kconfig
rename to board/nxp/mx6ullevk/Kconfig
index 49aa302553e..33b24577df5 100644
--- a/board/freescale/mx6ullevk/Kconfig
+++ b/board/nxp/mx6ullevk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx6ullevk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx6ullevk"
 
 config IMX_CONFIG
-	default "board/freescale/mx6ullevk/imximage.cfg"
+	default "board/nxp/mx6ullevk/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx6ullevk/MAINTAINERS b/board/nxp/mx6ullevk/MAINTAINERS
similarity index 87%
rename from board/freescale/mx6ullevk/MAINTAINERS
rename to board/nxp/mx6ullevk/MAINTAINERS
index 3d1b2560363..c210c6f41e6 100644
--- a/board/freescale/mx6ullevk/MAINTAINERS
+++ b/board/nxp/mx6ullevk/MAINTAINERS
@@ -1,7 +1,7 @@
 MX6ULLEVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx6ullevk/
+F:	board/nxp/mx6ullevk/
 F:	include/configs/mx6ullevk.h
 F:	configs/mx6ull_14x14_evk_defconfig
 F:	configs/mx6ull_14x14_evk_plugin_defconfig
diff --git a/board/freescale/mx6ullevk/Makefile b/board/nxp/mx6ullevk/Makefile
similarity index 100%
rename from board/freescale/mx6ullevk/Makefile
rename to board/nxp/mx6ullevk/Makefile
diff --git a/board/freescale/mx6ullevk/imximage.cfg b/board/nxp/mx6ullevk/imximage.cfg
similarity index 98%
rename from board/freescale/mx6ullevk/imximage.cfg
rename to board/nxp/mx6ullevk/imximage.cfg
index 0c6f444a7a3..f1d532bcc55 100644
--- a/board/freescale/mx6ullevk/imximage.cfg
+++ b/board/nxp/mx6ullevk/imximage.cfg
@@ -29,7 +29,7 @@ BOOT_FROM	sd
 
 #ifdef CONFIG_USE_IMXIMG_PLUGIN
 /*PLUGIN    plugin-binary-file    IRAM_FREE_START_ADDR*/
-PLUGIN	board/freescale/mx6ullevk/plugin.bin 0x00907000
+PLUGIN	board/nxp/mx6ullevk/plugin.bin 0x00907000
 #else
 
 #ifdef CONFIG_IMX_HAB
diff --git a/board/freescale/mx6ullevk/mx6ullevk.c b/board/nxp/mx6ullevk/mx6ullevk.c
similarity index 100%
rename from board/freescale/mx6ullevk/mx6ullevk.c
rename to board/nxp/mx6ullevk/mx6ullevk.c
diff --git a/board/freescale/mx6ullevk/plugin.S b/board/nxp/mx6ullevk/plugin.S
similarity index 100%
rename from board/freescale/mx6ullevk/plugin.S
rename to board/nxp/mx6ullevk/plugin.S
diff --git a/board/freescale/mx7dsabresd/Kconfig b/board/nxp/mx7dsabresd/Kconfig
similarity index 67%
rename from board/freescale/mx7dsabresd/Kconfig
rename to board/nxp/mx7dsabresd/Kconfig
index bf3ceafe2b4..dcebe4cdb62 100644
--- a/board/freescale/mx7dsabresd/Kconfig
+++ b/board/nxp/mx7dsabresd/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx7dsabresd"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx7dsabresd"
 
 config IMX_CONFIG
-	default "board/freescale/mx7dsabresd/imximage.cfg"
+	default "board/nxp/mx7dsabresd/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx7dsabresd/MAINTAINERS b/board/nxp/mx7dsabresd/MAINTAINERS
similarity index 87%
rename from board/freescale/mx7dsabresd/MAINTAINERS
rename to board/nxp/mx7dsabresd/MAINTAINERS
index 721321c9cca..5dea074f940 100644
--- a/board/freescale/mx7dsabresd/MAINTAINERS
+++ b/board/nxp/mx7dsabresd/MAINTAINERS
@@ -2,7 +2,7 @@ MX7DSABRESD BOARD
 M:	Adrian Alonso <adrian.alonso@nxp.com>
 M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
-F:	board/freescale/mx7dsabresd
+F:	board/nxp/mx7dsabresd
 F:	include/configs/mx7dsabresd.h
 F:	configs/mx7dsabresd_defconfig
 F:	configs/mx7dsabresd_qspi_defconfig
diff --git a/board/freescale/mx7dsabresd/Makefile b/board/nxp/mx7dsabresd/Makefile
similarity index 100%
rename from board/freescale/mx7dsabresd/Makefile
rename to board/nxp/mx7dsabresd/Makefile
diff --git a/board/freescale/mx7dsabresd/imximage.cfg b/board/nxp/mx7dsabresd/imximage.cfg
similarity index 100%
rename from board/freescale/mx7dsabresd/imximage.cfg
rename to board/nxp/mx7dsabresd/imximage.cfg
diff --git a/board/freescale/mx7dsabresd/mx7dsabresd.c b/board/nxp/mx7dsabresd/mx7dsabresd.c
similarity index 100%
rename from board/freescale/mx7dsabresd/mx7dsabresd.c
rename to board/nxp/mx7dsabresd/mx7dsabresd.c
diff --git a/board/freescale/mx7ulp_evk/Kconfig b/board/nxp/mx7ulp_evk/Kconfig
similarity index 67%
rename from board/freescale/mx7ulp_evk/Kconfig
rename to board/nxp/mx7ulp_evk/Kconfig
index 591697041dd..a2b3ad0e5b8 100644
--- a/board/freescale/mx7ulp_evk/Kconfig
+++ b/board/nxp/mx7ulp_evk/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "mx7ulp_evk"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "mx7ulp_evk"
 
 config IMX_CONFIG
-	default "board/freescale/mx7ulp_evk/imximage.cfg"
+	default "board/nxp/mx7ulp_evk/imximage.cfg"
 
 endif
diff --git a/board/freescale/mx7ulp_evk/MAINTAINERS b/board/nxp/mx7ulp_evk/MAINTAINERS
similarity index 84%
rename from board/freescale/mx7ulp_evk/MAINTAINERS
rename to board/nxp/mx7ulp_evk/MAINTAINERS
index 1aa26445632..37944d43d50 100644
--- a/board/freescale/mx7ulp_evk/MAINTAINERS
+++ b/board/nxp/mx7ulp_evk/MAINTAINERS
@@ -1,7 +1,7 @@
 MX7ULPEVK BOARD
 M:	Peng Fan <peng.fan@nxp.com>
 S:	Maintained
-F:	board/freescale/mx7ulp_evk/
+F:	board/nxp/mx7ulp_evk/
 F:	include/configs/mx7ulp_evk.h
 F:	configs/mx7ulp_evk_defconfig
 F:	configs/mx7ulp_evk_plugin_defconfig
diff --git a/board/freescale/mx7ulp_evk/Makefile b/board/nxp/mx7ulp_evk/Makefile
similarity index 100%
rename from board/freescale/mx7ulp_evk/Makefile
rename to board/nxp/mx7ulp_evk/Makefile
diff --git a/board/freescale/mx7ulp_evk/imximage.cfg b/board/nxp/mx7ulp_evk/imximage.cfg
similarity index 98%
rename from board/freescale/mx7ulp_evk/imximage.cfg
rename to board/nxp/mx7ulp_evk/imximage.cfg
index 62fd79afd6c..116e71c279a 100644
--- a/board/freescale/mx7ulp_evk/imximage.cfg
+++ b/board/nxp/mx7ulp_evk/imximage.cfg
@@ -23,7 +23,7 @@ BOOT_FROM	sd
 
 #ifdef CONFIG_USE_IMXIMG_PLUGIN
 /*PLUGIN    plugin-binary-file    IRAM_FREE_START_ADDR*/
-PLUGIN	board/freescale/mx7ulp_evk/plugin.bin 0x2F020000
+PLUGIN	board/nxp/mx7ulp_evk/plugin.bin 0x2F020000
 #else
 
 #ifdef CONFIG_IMX_HAB
diff --git a/board/freescale/mx7ulp_evk/mx7ulp_evk.c b/board/nxp/mx7ulp_evk/mx7ulp_evk.c
similarity index 100%
rename from board/freescale/mx7ulp_evk/mx7ulp_evk.c
rename to board/nxp/mx7ulp_evk/mx7ulp_evk.c
diff --git a/board/freescale/mx7ulp_evk/plugin.S b/board/nxp/mx7ulp_evk/plugin.S
similarity index 100%
rename from board/freescale/mx7ulp_evk/plugin.S
rename to board/nxp/mx7ulp_evk/plugin.S
diff --git a/board/freescale/p1010rdb/Kconfig b/board/nxp/p1010rdb/Kconfig
similarity index 87%
rename from board/freescale/p1010rdb/Kconfig
rename to board/nxp/p1010rdb/Kconfig
index 159bcc4f54d..fa376fc058c 100644
--- a/board/freescale/p1010rdb/Kconfig
+++ b/board/nxp/p1010rdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "p1010rdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "P1010RDB"
diff --git a/board/freescale/p1010rdb/MAINTAINERS b/board/nxp/p1010rdb/MAINTAINERS
similarity index 96%
rename from board/freescale/p1010rdb/MAINTAINERS
rename to board/nxp/p1010rdb/MAINTAINERS
index 6e940dd8759..f7543942754 100644
--- a/board/freescale/p1010rdb/MAINTAINERS
+++ b/board/nxp/p1010rdb/MAINTAINERS
@@ -1,7 +1,7 @@
 P1010RDB BOARD
 M:	Qiang Zhao <qiang.zhao@nxp.com>
 S:	Maintained
-F:	board/freescale/p1010rdb/
+F:	board/nxp/p1010rdb/
 F:	include/configs/P1010RDB.h
 F:	configs/P1010RDB-PA_36BIT_NAND_defconfig
 F:	configs/P1010RDB-PA_36BIT_NOR_defconfig
diff --git a/board/freescale/p1010rdb/Makefile b/board/nxp/p1010rdb/Makefile
similarity index 100%
rename from board/freescale/p1010rdb/Makefile
rename to board/nxp/p1010rdb/Makefile
diff --git a/board/freescale/p1010rdb/README.P1010RDB-PA b/board/nxp/p1010rdb/README.P1010RDB-PA
similarity index 100%
rename from board/freescale/p1010rdb/README.P1010RDB-PA
rename to board/nxp/p1010rdb/README.P1010RDB-PA
diff --git a/board/freescale/p1010rdb/README.P1010RDB-PB b/board/nxp/p1010rdb/README.P1010RDB-PB
similarity index 100%
rename from board/freescale/p1010rdb/README.P1010RDB-PB
rename to board/nxp/p1010rdb/README.P1010RDB-PB
diff --git a/board/freescale/p1010rdb/ddr.c b/board/nxp/p1010rdb/ddr.c
similarity index 100%
rename from board/freescale/p1010rdb/ddr.c
rename to board/nxp/p1010rdb/ddr.c
diff --git a/board/freescale/p1010rdb/law.c b/board/nxp/p1010rdb/law.c
similarity index 100%
rename from board/freescale/p1010rdb/law.c
rename to board/nxp/p1010rdb/law.c
diff --git a/board/freescale/p1010rdb/p1010rdb.c b/board/nxp/p1010rdb/p1010rdb.c
similarity index 100%
rename from board/freescale/p1010rdb/p1010rdb.c
rename to board/nxp/p1010rdb/p1010rdb.c
diff --git a/board/freescale/p1010rdb/spl.c b/board/nxp/p1010rdb/spl.c
similarity index 100%
rename from board/freescale/p1010rdb/spl.c
rename to board/nxp/p1010rdb/spl.c
diff --git a/board/freescale/p1010rdb/spl_minimal.c b/board/nxp/p1010rdb/spl_minimal.c
similarity index 100%
rename from board/freescale/p1010rdb/spl_minimal.c
rename to board/nxp/p1010rdb/spl_minimal.c
diff --git a/board/freescale/p1010rdb/tlb.c b/board/nxp/p1010rdb/tlb.c
similarity index 100%
rename from board/freescale/p1010rdb/tlb.c
rename to board/nxp/p1010rdb/tlb.c
diff --git a/board/freescale/p1_p2_rdb_pc/Kconfig b/board/nxp/p1_p2_rdb_pc/Kconfig
similarity index 89%
rename from board/freescale/p1_p2_rdb_pc/Kconfig
rename to board/nxp/p1_p2_rdb_pc/Kconfig
index cd36150f637..2ab46d99434 100644
--- a/board/freescale/p1_p2_rdb_pc/Kconfig
+++ b/board/nxp/p1_p2_rdb_pc/Kconfig
@@ -6,7 +6,7 @@ config SYS_BOARD
 	default "p1_p2_rdb_pc"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "p1_p2_rdb_pc"
diff --git a/board/freescale/p1_p2_rdb_pc/MAINTAINERS b/board/nxp/p1_p2_rdb_pc/MAINTAINERS
similarity index 96%
rename from board/freescale/p1_p2_rdb_pc/MAINTAINERS
rename to board/nxp/p1_p2_rdb_pc/MAINTAINERS
index 0004d717d1d..1ce3501f379 100644
--- a/board/freescale/p1_p2_rdb_pc/MAINTAINERS
+++ b/board/nxp/p1_p2_rdb_pc/MAINTAINERS
@@ -1,7 +1,7 @@
 P1_P2_RDB_PC BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/p1_p2_rdb_pc/
+F:	board/nxp/p1_p2_rdb_pc/
 F:	include/configs/p1_p2_rdb_pc.h
 F:	configs/P1020RDB-PC_defconfig
 F:	configs/P1020RDB-PC_36BIT_defconfig
diff --git a/board/freescale/p1_p2_rdb_pc/Makefile b/board/nxp/p1_p2_rdb_pc/Makefile
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/Makefile
rename to board/nxp/p1_p2_rdb_pc/Makefile
diff --git a/board/freescale/p1_p2_rdb_pc/README b/board/nxp/p1_p2_rdb_pc/README
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/README
rename to board/nxp/p1_p2_rdb_pc/README
diff --git a/board/freescale/p1_p2_rdb_pc/ddr.c b/board/nxp/p1_p2_rdb_pc/ddr.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/ddr.c
rename to board/nxp/p1_p2_rdb_pc/ddr.c
diff --git a/board/freescale/p1_p2_rdb_pc/law.c b/board/nxp/p1_p2_rdb_pc/law.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/law.c
rename to board/nxp/p1_p2_rdb_pc/law.c
diff --git a/board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/p1_p2_rdb_pc.c
rename to board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
diff --git a/board/freescale/p1_p2_rdb_pc/spl.c b/board/nxp/p1_p2_rdb_pc/spl.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/spl.c
rename to board/nxp/p1_p2_rdb_pc/spl.c
diff --git a/board/freescale/p1_p2_rdb_pc/spl_minimal.c b/board/nxp/p1_p2_rdb_pc/spl_minimal.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/spl_minimal.c
rename to board/nxp/p1_p2_rdb_pc/spl_minimal.c
diff --git a/board/freescale/p1_p2_rdb_pc/tlb.c b/board/nxp/p1_p2_rdb_pc/tlb.c
similarity index 100%
rename from board/freescale/p1_p2_rdb_pc/tlb.c
rename to board/nxp/p1_p2_rdb_pc/tlb.c
diff --git a/board/freescale/p2041rdb/Kconfig b/board/nxp/p2041rdb/Kconfig
similarity index 85%
rename from board/freescale/p2041rdb/Kconfig
rename to board/nxp/p2041rdb/Kconfig
index 78e11214a5b..47c93b6eb55 100644
--- a/board/freescale/p2041rdb/Kconfig
+++ b/board/nxp/p2041rdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "p2041rdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "P2041RDB"
diff --git a/board/freescale/p2041rdb/MAINTAINERS b/board/nxp/p2041rdb/MAINTAINERS
similarity index 91%
rename from board/freescale/p2041rdb/MAINTAINERS
rename to board/nxp/p2041rdb/MAINTAINERS
index 2121243e148..f0d5c1192ac 100644
--- a/board/freescale/p2041rdb/MAINTAINERS
+++ b/board/nxp/p2041rdb/MAINTAINERS
@@ -1,7 +1,7 @@
 P2041RDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/p2041rdb/
+F:	board/nxp/p2041rdb/
 F:	include/configs/P2041RDB.h
 F:	configs/P2041RDB_defconfig
 F:	configs/P2041RDB_NAND_defconfig
diff --git a/board/freescale/p2041rdb/Makefile b/board/nxp/p2041rdb/Makefile
similarity index 100%
rename from board/freescale/p2041rdb/Makefile
rename to board/nxp/p2041rdb/Makefile
diff --git a/board/freescale/p2041rdb/README b/board/nxp/p2041rdb/README
similarity index 100%
rename from board/freescale/p2041rdb/README
rename to board/nxp/p2041rdb/README
diff --git a/board/freescale/p2041rdb/cpld.c b/board/nxp/p2041rdb/cpld.c
similarity index 100%
rename from board/freescale/p2041rdb/cpld.c
rename to board/nxp/p2041rdb/cpld.c
diff --git a/board/freescale/p2041rdb/cpld.h b/board/nxp/p2041rdb/cpld.h
similarity index 100%
rename from board/freescale/p2041rdb/cpld.h
rename to board/nxp/p2041rdb/cpld.h
diff --git a/board/freescale/p2041rdb/ddr.c b/board/nxp/p2041rdb/ddr.c
similarity index 100%
rename from board/freescale/p2041rdb/ddr.c
rename to board/nxp/p2041rdb/ddr.c
diff --git a/board/freescale/p2041rdb/eth.c b/board/nxp/p2041rdb/eth.c
similarity index 100%
rename from board/freescale/p2041rdb/eth.c
rename to board/nxp/p2041rdb/eth.c
diff --git a/board/freescale/p2041rdb/p2041rdb.c b/board/nxp/p2041rdb/p2041rdb.c
similarity index 100%
rename from board/freescale/p2041rdb/p2041rdb.c
rename to board/nxp/p2041rdb/p2041rdb.c
diff --git a/board/freescale/p2041rdb/pbi.cfg b/board/nxp/p2041rdb/pbi.cfg
similarity index 100%
rename from board/freescale/p2041rdb/pbi.cfg
rename to board/nxp/p2041rdb/pbi.cfg
diff --git a/board/freescale/p2041rdb/rcw_p2041rdb.cfg b/board/nxp/p2041rdb/rcw_p2041rdb.cfg
similarity index 100%
rename from board/freescale/p2041rdb/rcw_p2041rdb.cfg
rename to board/nxp/p2041rdb/rcw_p2041rdb.cfg
diff --git a/board/freescale/t102xrdb/Kconfig b/board/nxp/t102xrdb/Kconfig
similarity index 87%
rename from board/freescale/t102xrdb/Kconfig
rename to board/nxp/t102xrdb/Kconfig
index d538386d434..925a984677e 100644
--- a/board/freescale/t102xrdb/Kconfig
+++ b/board/nxp/t102xrdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "t102xrdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "T102xRDB"
diff --git a/board/freescale/t102xrdb/MAINTAINERS b/board/nxp/t102xrdb/MAINTAINERS
similarity index 89%
rename from board/freescale/t102xrdb/MAINTAINERS
rename to board/nxp/t102xrdb/MAINTAINERS
index df1f0bed939..030dc3f950e 100644
--- a/board/freescale/t102xrdb/MAINTAINERS
+++ b/board/nxp/t102xrdb/MAINTAINERS
@@ -1,7 +1,7 @@
 T102XRDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/t102xrdb/
+F:	board/nxp/t102xrdb/
 F:	include/configs/T102xRDB.h
 F:	configs/T1024RDB_defconfig
 F:	configs/T1024RDB_NAND_defconfig
diff --git a/board/freescale/t102xrdb/Makefile b/board/nxp/t102xrdb/Makefile
similarity index 100%
rename from board/freescale/t102xrdb/Makefile
rename to board/nxp/t102xrdb/Makefile
diff --git a/board/freescale/t102xrdb/README b/board/nxp/t102xrdb/README
similarity index 100%
rename from board/freescale/t102xrdb/README
rename to board/nxp/t102xrdb/README
diff --git a/board/freescale/t102xrdb/cpld.c b/board/nxp/t102xrdb/cpld.c
similarity index 100%
rename from board/freescale/t102xrdb/cpld.c
rename to board/nxp/t102xrdb/cpld.c
diff --git a/board/freescale/t102xrdb/cpld.h b/board/nxp/t102xrdb/cpld.h
similarity index 100%
rename from board/freescale/t102xrdb/cpld.h
rename to board/nxp/t102xrdb/cpld.h
diff --git a/board/freescale/t102xrdb/ddr.c b/board/nxp/t102xrdb/ddr.c
similarity index 100%
rename from board/freescale/t102xrdb/ddr.c
rename to board/nxp/t102xrdb/ddr.c
diff --git a/board/freescale/t102xrdb/eth_t102xrdb.c b/board/nxp/t102xrdb/eth_t102xrdb.c
similarity index 100%
rename from board/freescale/t102xrdb/eth_t102xrdb.c
rename to board/nxp/t102xrdb/eth_t102xrdb.c
diff --git a/board/freescale/t102xrdb/law.c b/board/nxp/t102xrdb/law.c
similarity index 100%
rename from board/freescale/t102xrdb/law.c
rename to board/nxp/t102xrdb/law.c
diff --git a/board/freescale/t102xrdb/spl.c b/board/nxp/t102xrdb/spl.c
similarity index 100%
rename from board/freescale/t102xrdb/spl.c
rename to board/nxp/t102xrdb/spl.c
diff --git a/board/freescale/t102xrdb/t1023_nand_rcw.cfg b/board/nxp/t102xrdb/t1023_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1023_nand_rcw.cfg
rename to board/nxp/t102xrdb/t1023_nand_rcw.cfg
diff --git a/board/freescale/t102xrdb/t1023_sd_rcw.cfg b/board/nxp/t102xrdb/t1023_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1023_sd_rcw.cfg
rename to board/nxp/t102xrdb/t1023_sd_rcw.cfg
diff --git a/board/freescale/t102xrdb/t1023_spi_rcw.cfg b/board/nxp/t102xrdb/t1023_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1023_spi_rcw.cfg
rename to board/nxp/t102xrdb/t1023_spi_rcw.cfg
diff --git a/board/freescale/t102xrdb/t1024_nand_rcw.cfg b/board/nxp/t102xrdb/t1024_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1024_nand_rcw.cfg
rename to board/nxp/t102xrdb/t1024_nand_rcw.cfg
diff --git a/board/freescale/t102xrdb/t1024_pbi.cfg b/board/nxp/t102xrdb/t1024_pbi.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1024_pbi.cfg
rename to board/nxp/t102xrdb/t1024_pbi.cfg
diff --git a/board/freescale/t102xrdb/t1024_sd_rcw.cfg b/board/nxp/t102xrdb/t1024_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1024_sd_rcw.cfg
rename to board/nxp/t102xrdb/t1024_sd_rcw.cfg
diff --git a/board/freescale/t102xrdb/t1024_spi_rcw.cfg b/board/nxp/t102xrdb/t1024_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t102xrdb/t1024_spi_rcw.cfg
rename to board/nxp/t102xrdb/t1024_spi_rcw.cfg
diff --git a/board/freescale/t102xrdb/t102xrdb.c b/board/nxp/t102xrdb/t102xrdb.c
similarity index 100%
rename from board/freescale/t102xrdb/t102xrdb.c
rename to board/nxp/t102xrdb/t102xrdb.c
diff --git a/board/freescale/t102xrdb/t102xrdb.h b/board/nxp/t102xrdb/t102xrdb.h
similarity index 100%
rename from board/freescale/t102xrdb/t102xrdb.h
rename to board/nxp/t102xrdb/t102xrdb.h
diff --git a/board/freescale/t102xrdb/tlb.c b/board/nxp/t102xrdb/tlb.c
similarity index 100%
rename from board/freescale/t102xrdb/tlb.c
rename to board/nxp/t102xrdb/tlb.c
diff --git a/board/freescale/t104xrdb/Kconfig b/board/nxp/t104xrdb/Kconfig
similarity index 86%
rename from board/freescale/t104xrdb/Kconfig
rename to board/nxp/t104xrdb/Kconfig
index e4814915e33..fb26b7c9256 100644
--- a/board/freescale/t104xrdb/Kconfig
+++ b/board/nxp/t104xrdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "t104xrdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "T104xRDB"
diff --git a/board/freescale/t104xrdb/MAINTAINERS b/board/nxp/t104xrdb/MAINTAINERS
similarity index 96%
rename from board/freescale/t104xrdb/MAINTAINERS
rename to board/nxp/t104xrdb/MAINTAINERS
index 55fdb600a16..5542530698d 100644
--- a/board/freescale/t104xrdb/MAINTAINERS
+++ b/board/nxp/t104xrdb/MAINTAINERS
@@ -1,7 +1,7 @@
 T104XRDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/t104xrdb/
+F:	board/nxp/t104xrdb/
 F:	include/configs/T104xRDB.h
 F:	configs/T1040RDB_defconfig
 F:	configs/T1040RDB_NAND_defconfig
diff --git a/board/freescale/t104xrdb/Makefile b/board/nxp/t104xrdb/Makefile
similarity index 100%
rename from board/freescale/t104xrdb/Makefile
rename to board/nxp/t104xrdb/Makefile
diff --git a/board/freescale/t104xrdb/README b/board/nxp/t104xrdb/README
similarity index 99%
rename from board/freescale/t104xrdb/README
rename to board/nxp/t104xrdb/README
index f312e6a3e32..b852f72998d 100644
--- a/board/freescale/t104xrdb/README
+++ b/board/nxp/t104xrdb/README
@@ -339,7 +339,7 @@ For SD-boot
 1. Set RCW[192:195], PBI_SRC bits as 6 in RCW file (t1040d4_rcw.cfg type files)
 
 example:
- RCW file: board/freescale/t104xrdb/t1040d4_rcw.cfg
+ RCW file: board/nxp/t104xrdb/t1040d4_rcw.cfg
 
 Change
 66000002 40000002 ec027000 01000000
@@ -355,7 +355,7 @@ For SPI-boot
 1. Set RCW[192:195], PBI_SRC bits as 5 in RCW file (t1040d4_rcw.cfg type files)
 
 example:
- RCW file: board/freescale/t104xrdb/t1040d4_rcw.cfg
+ RCW file: board/nxp/t104xrdb/t1040d4_rcw.cfg
 
 Change
 66000002 40000002 ec027000 01000000
diff --git a/board/freescale/t104xrdb/cpld.c b/board/nxp/t104xrdb/cpld.c
similarity index 100%
rename from board/freescale/t104xrdb/cpld.c
rename to board/nxp/t104xrdb/cpld.c
diff --git a/board/freescale/t104xrdb/cpld.h b/board/nxp/t104xrdb/cpld.h
similarity index 100%
rename from board/freescale/t104xrdb/cpld.h
rename to board/nxp/t104xrdb/cpld.h
diff --git a/board/freescale/t104xrdb/ddr.c b/board/nxp/t104xrdb/ddr.c
similarity index 100%
rename from board/freescale/t104xrdb/ddr.c
rename to board/nxp/t104xrdb/ddr.c
diff --git a/board/freescale/t104xrdb/ddr.h b/board/nxp/t104xrdb/ddr.h
similarity index 100%
rename from board/freescale/t104xrdb/ddr.h
rename to board/nxp/t104xrdb/ddr.h
diff --git a/board/freescale/t104xrdb/eth.c b/board/nxp/t104xrdb/eth.c
similarity index 100%
rename from board/freescale/t104xrdb/eth.c
rename to board/nxp/t104xrdb/eth.c
diff --git a/board/freescale/t104xrdb/law.c b/board/nxp/t104xrdb/law.c
similarity index 100%
rename from board/freescale/t104xrdb/law.c
rename to board/nxp/t104xrdb/law.c
diff --git a/board/freescale/t104xrdb/spl.c b/board/nxp/t104xrdb/spl.c
similarity index 100%
rename from board/freescale/t104xrdb/spl.c
rename to board/nxp/t104xrdb/spl.c
diff --git a/board/freescale/t104xrdb/t1040_nand_rcw.cfg b/board/nxp/t104xrdb/t1040_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040_nand_rcw.cfg
rename to board/nxp/t104xrdb/t1040_nand_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1040_sd_rcw.cfg b/board/nxp/t104xrdb/t1040_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040_sd_rcw.cfg
rename to board/nxp/t104xrdb/t1040_sd_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1040_spi_rcw.cfg b/board/nxp/t104xrdb/t1040_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040_spi_rcw.cfg
rename to board/nxp/t104xrdb/t1040_spi_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1040d4_nand_rcw.cfg b/board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040d4_nand_rcw.cfg
rename to board/nxp/t104xrdb/t1040d4_nand_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1040d4_sd_rcw.cfg b/board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040d4_sd_rcw.cfg
rename to board/nxp/t104xrdb/t1040d4_sd_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1040d4_spi_rcw.cfg b/board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1040d4_spi_rcw.cfg
rename to board/nxp/t104xrdb/t1040d4_spi_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_nand_rcw.cfg b/board/nxp/t104xrdb/t1042_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_nand_rcw.cfg
rename to board/nxp/t104xrdb/t1042_nand_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_pi_nand_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_pi_nand_rcw.cfg
rename to board/nxp/t104xrdb/t1042_pi_nand_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_pi_sd_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_pi_sd_rcw.cfg
rename to board/nxp/t104xrdb/t1042_pi_sd_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_pi_spi_rcw.cfg b/board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_pi_spi_rcw.cfg
rename to board/nxp/t104xrdb/t1042_pi_spi_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_sd_rcw.cfg b/board/nxp/t104xrdb/t1042_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_sd_rcw.cfg
rename to board/nxp/t104xrdb/t1042_sd_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042_spi_rcw.cfg b/board/nxp/t104xrdb/t1042_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042_spi_rcw.cfg
rename to board/nxp/t104xrdb/t1042_spi_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042d4_nand_rcw.cfg b/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042d4_nand_rcw.cfg
rename to board/nxp/t104xrdb/t1042d4_nand_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042d4_sd_rcw.cfg b/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042d4_sd_rcw.cfg
rename to board/nxp/t104xrdb/t1042d4_sd_rcw.cfg
diff --git a/board/freescale/t104xrdb/t1042d4_spi_rcw.cfg b/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t1042d4_spi_rcw.cfg
rename to board/nxp/t104xrdb/t1042d4_spi_rcw.cfg
diff --git a/board/freescale/t104xrdb/t104x_pbi.cfg b/board/nxp/t104xrdb/t104x_pbi.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t104x_pbi.cfg
rename to board/nxp/t104xrdb/t104x_pbi.cfg
diff --git a/board/freescale/t104xrdb/t104x_pbi_sb.cfg b/board/nxp/t104xrdb/t104x_pbi_sb.cfg
similarity index 100%
rename from board/freescale/t104xrdb/t104x_pbi_sb.cfg
rename to board/nxp/t104xrdb/t104x_pbi_sb.cfg
diff --git a/board/freescale/t104xrdb/t104xrdb.c b/board/nxp/t104xrdb/t104xrdb.c
similarity index 100%
rename from board/freescale/t104xrdb/t104xrdb.c
rename to board/nxp/t104xrdb/t104xrdb.c
diff --git a/board/freescale/t104xrdb/t104xrdb.h b/board/nxp/t104xrdb/t104xrdb.h
similarity index 100%
rename from board/freescale/t104xrdb/t104xrdb.h
rename to board/nxp/t104xrdb/t104xrdb.h
diff --git a/board/freescale/t104xrdb/tlb.c b/board/nxp/t104xrdb/tlb.c
similarity index 100%
rename from board/freescale/t104xrdb/tlb.c
rename to board/nxp/t104xrdb/tlb.c
diff --git a/board/freescale/t208xqds/Kconfig b/board/nxp/t208xqds/Kconfig
similarity index 90%
rename from board/freescale/t208xqds/Kconfig
rename to board/nxp/t208xqds/Kconfig
index c419a59dbb6..a7d1e0a1e30 100644
--- a/board/freescale/t208xqds/Kconfig
+++ b/board/nxp/t208xqds/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "t208xqds"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "T208xQDS"
diff --git a/board/freescale/t208xqds/MAINTAINERS b/board/nxp/t208xqds/MAINTAINERS
similarity index 95%
rename from board/freescale/t208xqds/MAINTAINERS
rename to board/nxp/t208xqds/MAINTAINERS
index 790b009c516..56911e8fd15 100644
--- a/board/freescale/t208xqds/MAINTAINERS
+++ b/board/nxp/t208xqds/MAINTAINERS
@@ -1,7 +1,7 @@
 T208XQDS BOARD
 M:	Shengzhou Liu <Shengzhou.Liu@nxp.com>
 S:	Maintained
-F:	board/freescale/t208xqds/
+F:	board/nxp/t208xqds/
 F:	include/configs/T208xQDS.h
 F:	configs/T2080QDS_defconfig
 F:	configs/T2080QDS_NAND_defconfig
diff --git a/board/freescale/t208xqds/Makefile b/board/nxp/t208xqds/Makefile
similarity index 100%
rename from board/freescale/t208xqds/Makefile
rename to board/nxp/t208xqds/Makefile
diff --git a/board/freescale/t208xqds/README b/board/nxp/t208xqds/README
similarity index 100%
rename from board/freescale/t208xqds/README
rename to board/nxp/t208xqds/README
diff --git a/board/freescale/t208xqds/ddr.c b/board/nxp/t208xqds/ddr.c
similarity index 100%
rename from board/freescale/t208xqds/ddr.c
rename to board/nxp/t208xqds/ddr.c
diff --git a/board/freescale/t208xqds/ddr.h b/board/nxp/t208xqds/ddr.h
similarity index 100%
rename from board/freescale/t208xqds/ddr.h
rename to board/nxp/t208xqds/ddr.h
diff --git a/board/freescale/t208xqds/eth_t208xqds.c b/board/nxp/t208xqds/eth_t208xqds.c
similarity index 100%
rename from board/freescale/t208xqds/eth_t208xqds.c
rename to board/nxp/t208xqds/eth_t208xqds.c
diff --git a/board/freescale/t208xqds/law.c b/board/nxp/t208xqds/law.c
similarity index 100%
rename from board/freescale/t208xqds/law.c
rename to board/nxp/t208xqds/law.c
diff --git a/board/freescale/t208xqds/spl.c b/board/nxp/t208xqds/spl.c
similarity index 100%
rename from board/freescale/t208xqds/spl.c
rename to board/nxp/t208xqds/spl.c
diff --git a/board/freescale/t208xqds/t2080_nand_rcw.cfg b/board/nxp/t208xqds/t2080_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2080_nand_rcw.cfg
rename to board/nxp/t208xqds/t2080_nand_rcw.cfg
diff --git a/board/freescale/t208xqds/t2080_sd_rcw.cfg b/board/nxp/t208xqds/t2080_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2080_sd_rcw.cfg
rename to board/nxp/t208xqds/t2080_sd_rcw.cfg
diff --git a/board/freescale/t208xqds/t2080_spi_rcw.cfg b/board/nxp/t208xqds/t2080_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2080_spi_rcw.cfg
rename to board/nxp/t208xqds/t2080_spi_rcw.cfg
diff --git a/board/freescale/t208xqds/t2081_nand_rcw.cfg b/board/nxp/t208xqds/t2081_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2081_nand_rcw.cfg
rename to board/nxp/t208xqds/t2081_nand_rcw.cfg
diff --git a/board/freescale/t208xqds/t2081_sd_rcw.cfg b/board/nxp/t208xqds/t2081_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2081_sd_rcw.cfg
rename to board/nxp/t208xqds/t2081_sd_rcw.cfg
diff --git a/board/freescale/t208xqds/t2081_spi_rcw.cfg b/board/nxp/t208xqds/t2081_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t208xqds/t2081_spi_rcw.cfg
rename to board/nxp/t208xqds/t2081_spi_rcw.cfg
diff --git a/board/freescale/t208xqds/t208x_pbi.cfg b/board/nxp/t208xqds/t208x_pbi.cfg
similarity index 100%
rename from board/freescale/t208xqds/t208x_pbi.cfg
rename to board/nxp/t208xqds/t208x_pbi.cfg
diff --git a/board/freescale/t208xqds/t208xqds.c b/board/nxp/t208xqds/t208xqds.c
similarity index 100%
rename from board/freescale/t208xqds/t208xqds.c
rename to board/nxp/t208xqds/t208xqds.c
diff --git a/board/freescale/t208xqds/t208xqds.h b/board/nxp/t208xqds/t208xqds.h
similarity index 100%
rename from board/freescale/t208xqds/t208xqds.h
rename to board/nxp/t208xqds/t208xqds.h
diff --git a/board/freescale/t208xqds/t208xqds_qixis.h b/board/nxp/t208xqds/t208xqds_qixis.h
similarity index 100%
rename from board/freescale/t208xqds/t208xqds_qixis.h
rename to board/nxp/t208xqds/t208xqds_qixis.h
diff --git a/board/freescale/t208xqds/tlb.c b/board/nxp/t208xqds/tlb.c
similarity index 100%
rename from board/freescale/t208xqds/tlb.c
rename to board/nxp/t208xqds/tlb.c
diff --git a/board/freescale/t208xrdb/Kconfig b/board/nxp/t208xrdb/Kconfig
similarity index 90%
rename from board/freescale/t208xrdb/Kconfig
rename to board/nxp/t208xrdb/Kconfig
index 35d884e6ccb..cf3c73f9100 100644
--- a/board/freescale/t208xrdb/Kconfig
+++ b/board/nxp/t208xrdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "t208xrdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "T208xRDB"
diff --git a/board/freescale/t208xrdb/MAINTAINERS b/board/nxp/t208xrdb/MAINTAINERS
similarity index 93%
rename from board/freescale/t208xrdb/MAINTAINERS
rename to board/nxp/t208xrdb/MAINTAINERS
index 5be7a25c03b..db58c79c254 100644
--- a/board/freescale/t208xrdb/MAINTAINERS
+++ b/board/nxp/t208xrdb/MAINTAINERS
@@ -1,7 +1,7 @@
 T208XRDB BOARD
 M:	Shengzhou Liu <Shengzhou.Liu@nxp.com>
 S:	Maintained
-F:	board/freescale/t208xrdb/
+F:	board/nxp/t208xrdb/
 F:	include/configs/T208xRDB.h
 F:	configs/T2080RDB_defconfig
 F:	configs/T2080RDB_NAND_defconfig
diff --git a/board/freescale/t208xrdb/Makefile b/board/nxp/t208xrdb/Makefile
similarity index 100%
rename from board/freescale/t208xrdb/Makefile
rename to board/nxp/t208xrdb/Makefile
diff --git a/board/freescale/t208xrdb/README b/board/nxp/t208xrdb/README
similarity index 100%
rename from board/freescale/t208xrdb/README
rename to board/nxp/t208xrdb/README
diff --git a/board/freescale/t208xrdb/cpld.c b/board/nxp/t208xrdb/cpld.c
similarity index 100%
rename from board/freescale/t208xrdb/cpld.c
rename to board/nxp/t208xrdb/cpld.c
diff --git a/board/freescale/t208xrdb/cpld.h b/board/nxp/t208xrdb/cpld.h
similarity index 100%
rename from board/freescale/t208xrdb/cpld.h
rename to board/nxp/t208xrdb/cpld.h
diff --git a/board/freescale/t208xrdb/ddr.c b/board/nxp/t208xrdb/ddr.c
similarity index 100%
rename from board/freescale/t208xrdb/ddr.c
rename to board/nxp/t208xrdb/ddr.c
diff --git a/board/freescale/t208xrdb/ddr.h b/board/nxp/t208xrdb/ddr.h
similarity index 100%
rename from board/freescale/t208xrdb/ddr.h
rename to board/nxp/t208xrdb/ddr.h
diff --git a/board/freescale/t208xrdb/eth_t208xrdb.c b/board/nxp/t208xrdb/eth_t208xrdb.c
similarity index 100%
rename from board/freescale/t208xrdb/eth_t208xrdb.c
rename to board/nxp/t208xrdb/eth_t208xrdb.c
diff --git a/board/freescale/t208xrdb/law.c b/board/nxp/t208xrdb/law.c
similarity index 100%
rename from board/freescale/t208xrdb/law.c
rename to board/nxp/t208xrdb/law.c
diff --git a/board/freescale/t208xrdb/spl.c b/board/nxp/t208xrdb/spl.c
similarity index 100%
rename from board/freescale/t208xrdb/spl.c
rename to board/nxp/t208xrdb/spl.c
diff --git a/board/freescale/t208xrdb/t2080_nand_rcw.cfg b/board/nxp/t208xrdb/t2080_nand_rcw.cfg
similarity index 100%
rename from board/freescale/t208xrdb/t2080_nand_rcw.cfg
rename to board/nxp/t208xrdb/t2080_nand_rcw.cfg
diff --git a/board/freescale/t208xrdb/t2080_pbi.cfg b/board/nxp/t208xrdb/t2080_pbi.cfg
similarity index 100%
rename from board/freescale/t208xrdb/t2080_pbi.cfg
rename to board/nxp/t208xrdb/t2080_pbi.cfg
diff --git a/board/freescale/t208xrdb/t2080_sd_rcw.cfg b/board/nxp/t208xrdb/t2080_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t208xrdb/t2080_sd_rcw.cfg
rename to board/nxp/t208xrdb/t2080_sd_rcw.cfg
diff --git a/board/freescale/t208xrdb/t2080_spi_rcw.cfg b/board/nxp/t208xrdb/t2080_spi_rcw.cfg
similarity index 100%
rename from board/freescale/t208xrdb/t2080_spi_rcw.cfg
rename to board/nxp/t208xrdb/t2080_spi_rcw.cfg
diff --git a/board/freescale/t208xrdb/t208xrdb.c b/board/nxp/t208xrdb/t208xrdb.c
similarity index 100%
rename from board/freescale/t208xrdb/t208xrdb.c
rename to board/nxp/t208xrdb/t208xrdb.c
diff --git a/board/freescale/t208xrdb/t208xrdb.h b/board/nxp/t208xrdb/t208xrdb.h
similarity index 100%
rename from board/freescale/t208xrdb/t208xrdb.h
rename to board/nxp/t208xrdb/t208xrdb.h
diff --git a/board/freescale/t208xrdb/tlb.c b/board/nxp/t208xrdb/tlb.c
similarity index 100%
rename from board/freescale/t208xrdb/tlb.c
rename to board/nxp/t208xrdb/tlb.c
diff --git a/board/freescale/t4rdb/Kconfig b/board/nxp/t4rdb/Kconfig
similarity index 85%
rename from board/freescale/t4rdb/Kconfig
rename to board/nxp/t4rdb/Kconfig
index d93e4532ac4..1a6874ab562 100644
--- a/board/freescale/t4rdb/Kconfig
+++ b/board/nxp/t4rdb/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "t4rdb"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "T4240RDB"
diff --git a/board/freescale/t4rdb/MAINTAINERS b/board/nxp/t4rdb/MAINTAINERS
similarity index 86%
rename from board/freescale/t4rdb/MAINTAINERS
rename to board/nxp/t4rdb/MAINTAINERS
index 844a15259c0..6d328595d39 100644
--- a/board/freescale/t4rdb/MAINTAINERS
+++ b/board/nxp/t4rdb/MAINTAINERS
@@ -1,7 +1,7 @@
 T4RDB BOARD
 M:	Priyanka Jain <priyanka.jain@nxp.com>
 S:	Maintained
-F:	board/freescale/t4rdb/
+F:	board/nxp/t4rdb/
 F:	include/configs/T4240RDB.h
 F:	configs/T4240RDB_defconfig
 F:	configs/T4240RDB_SDCARD_defconfig
diff --git a/board/freescale/t4rdb/Makefile b/board/nxp/t4rdb/Makefile
similarity index 100%
rename from board/freescale/t4rdb/Makefile
rename to board/nxp/t4rdb/Makefile
diff --git a/board/freescale/t4rdb/cpld.c b/board/nxp/t4rdb/cpld.c
similarity index 100%
rename from board/freescale/t4rdb/cpld.c
rename to board/nxp/t4rdb/cpld.c
diff --git a/board/freescale/t4rdb/cpld.h b/board/nxp/t4rdb/cpld.h
similarity index 100%
rename from board/freescale/t4rdb/cpld.h
rename to board/nxp/t4rdb/cpld.h
diff --git a/board/freescale/t4rdb/ddr.c b/board/nxp/t4rdb/ddr.c
similarity index 100%
rename from board/freescale/t4rdb/ddr.c
rename to board/nxp/t4rdb/ddr.c
diff --git a/board/freescale/t4rdb/ddr.h b/board/nxp/t4rdb/ddr.h
similarity index 100%
rename from board/freescale/t4rdb/ddr.h
rename to board/nxp/t4rdb/ddr.h
diff --git a/board/freescale/t4rdb/eth.c b/board/nxp/t4rdb/eth.c
similarity index 100%
rename from board/freescale/t4rdb/eth.c
rename to board/nxp/t4rdb/eth.c
diff --git a/board/freescale/t4rdb/law.c b/board/nxp/t4rdb/law.c
similarity index 100%
rename from board/freescale/t4rdb/law.c
rename to board/nxp/t4rdb/law.c
diff --git a/board/freescale/t4rdb/spl.c b/board/nxp/t4rdb/spl.c
similarity index 100%
rename from board/freescale/t4rdb/spl.c
rename to board/nxp/t4rdb/spl.c
diff --git a/board/freescale/t4rdb/t4240rdb.c b/board/nxp/t4rdb/t4240rdb.c
similarity index 100%
rename from board/freescale/t4rdb/t4240rdb.c
rename to board/nxp/t4rdb/t4240rdb.c
diff --git a/board/freescale/t4rdb/t4_pbi.cfg b/board/nxp/t4rdb/t4_pbi.cfg
similarity index 100%
rename from board/freescale/t4rdb/t4_pbi.cfg
rename to board/nxp/t4rdb/t4_pbi.cfg
diff --git a/board/freescale/t4rdb/t4_sd_rcw.cfg b/board/nxp/t4rdb/t4_sd_rcw.cfg
similarity index 100%
rename from board/freescale/t4rdb/t4_sd_rcw.cfg
rename to board/nxp/t4rdb/t4_sd_rcw.cfg
diff --git a/board/freescale/t4rdb/t4rdb.h b/board/nxp/t4rdb/t4rdb.h
similarity index 100%
rename from board/freescale/t4rdb/t4rdb.h
rename to board/nxp/t4rdb/t4rdb.h
diff --git a/board/freescale/t4rdb/tlb.c b/board/nxp/t4rdb/tlb.c
similarity index 100%
rename from board/freescale/t4rdb/tlb.c
rename to board/nxp/t4rdb/tlb.c
diff --git a/board/freescale/vf610twr/Kconfig b/board/nxp/vf610twr/Kconfig
similarity index 67%
rename from board/freescale/vf610twr/Kconfig
rename to board/nxp/vf610twr/Kconfig
index 208c7ae2f42..4d9433cd929 100644
--- a/board/freescale/vf610twr/Kconfig
+++ b/board/nxp/vf610twr/Kconfig
@@ -4,12 +4,12 @@ config SYS_BOARD
 	default "vf610twr"
 
 config SYS_VENDOR
-	default "freescale"
+	default "nxp"
 
 config SYS_CONFIG_NAME
 	default "vf610twr"
 
 config IMX_CONFIG
-	default "board/freescale/vf610twr/imximage.cfg"
+	default "board/nxp/vf610twr/imximage.cfg"
 
 endif
diff --git a/board/freescale/vf610twr/MAINTAINERS b/board/nxp/vf610twr/MAINTAINERS
similarity index 84%
rename from board/freescale/vf610twr/MAINTAINERS
rename to board/nxp/vf610twr/MAINTAINERS
index b2eef8e24be..b8d4cb9a784 100644
--- a/board/freescale/vf610twr/MAINTAINERS
+++ b/board/nxp/vf610twr/MAINTAINERS
@@ -1,7 +1,7 @@
 VF610TWR BOARD
 M:	Alison Wang <alison.wang@nxp.com>
 S:	Maintained
-F:	board/freescale/vf610twr/
+F:	board/nxp/vf610twr/
 F:	include/configs/vf610twr.h
 F:	configs/vf610twr_defconfig
 F:	configs/vf610twr_nand_defconfig
diff --git a/board/freescale/vf610twr/Makefile b/board/nxp/vf610twr/Makefile
similarity index 100%
rename from board/freescale/vf610twr/Makefile
rename to board/nxp/vf610twr/Makefile
diff --git a/board/freescale/vf610twr/imximage.cfg b/board/nxp/vf610twr/imximage.cfg
similarity index 100%
rename from board/freescale/vf610twr/imximage.cfg
rename to board/nxp/vf610twr/imximage.cfg
diff --git a/board/freescale/vf610twr/vf610twr.c b/board/nxp/vf610twr/vf610twr.c
similarity index 100%
rename from board/freescale/vf610twr/vf610twr.c
rename to board/nxp/vf610twr/vf610twr.c
diff --git a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
index d25c24b08b3..7ad34fe8d20 100644
--- a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
+++ b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2020 SiFive, Inc.
  *
- * Based on board/freescale/common/sys_eeprom.c:
+ * Based on board/nxp/common/sys_eeprom.c:
  * Copyright 2006, 2008-2009, 2011 Freescale Semiconductor
  * York Sun (yorksun@freescale.com)
  * Haiying Wang (haiying.wang@freescale.com)
diff --git a/board/technexion/pico-imx6ul/pico-imx6ul.c b/board/technexion/pico-imx6ul/pico-imx6ul.c
index 10dcf8077e2..57d514853b1 100644
--- a/board/technexion/pico-imx6ul/pico-imx6ul.c
+++ b/board/technexion/pico-imx6ul/pico-imx6ul.c
@@ -23,7 +23,7 @@
 #include <usb.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
-#include "../../freescale/common/pfuze.h"
+#include "../../nxp/common/pfuze.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/technexion/pico-imx7d/Makefile b/board/technexion/pico-imx7d/Makefile
index 61b55fcc55a..cb6e1626a7d 100644
--- a/board/technexion/pico-imx7d/Makefile
+++ b/board/technexion/pico-imx7d/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 # (C) Copyright 2017 NXP Semiconductors
 
-obj-y  := pico-imx7d.o spl.o ../../freescale/common/mmc.o
+obj-y  := pico-imx7d.o spl.o ../../nxp/common/mmc.o
diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index cf6b7fcbd95..63b8b29d097 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -19,7 +19,7 @@
 #include <miiphy.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
-#include "../../freescale/common/pfuze.h"
+#include "../../nxp/common/pfuze.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/warp7/warp7.c b/board/warp7/warp7.c
index 4cd3ff0051b..8b1cff2955b 100644
--- a/board/warp7/warp7.c
+++ b/board/warp7/warp7.c
@@ -20,7 +20,7 @@
 #include <netdev.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
-#include "../freescale/common/pfuze.h"
+#include "../nxp/common/pfuze.h"
 #include <asm/setup.h>
 #include <asm/bootm.h>
 
diff --git a/configs/P2041RDB_NAND_defconfig b/configs/P2041RDB_NAND_defconfig
index 71b02050c56..a23570e84b7 100644
--- a/configs/P2041RDB_NAND_defconfig
+++ b/configs/P2041RDB_NAND_defconfig
@@ -27,8 +27,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index 6b8e8d9de4c..1ed3a8f72fd 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -27,8 +27,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 3f12aca2dc4..3d47b002b5b 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -29,8 +29,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/p2041rdb/rcw_p2041rdb.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1024RDB_NAND_defconfig b/configs/T1024RDB_NAND_defconfig
index d78d89ee07f..ab4c012e274 100644
--- a/configs/T1024RDB_NAND_defconfig
+++ b/configs/T1024RDB_NAND_defconfig
@@ -30,8 +30,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_nand_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t102xrdb/t1024_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t102xrdb/t1024_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1024RDB_SDCARD_defconfig b/configs/T1024RDB_SDCARD_defconfig
index 5e2a8739242..b48bc8d5cc0 100644
--- a/configs/T1024RDB_SDCARD_defconfig
+++ b/configs/T1024RDB_SDCARD_defconfig
@@ -30,8 +30,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t102xrdb/t1024_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t102xrdb/t1024_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1024RDB_SPIFLASH_defconfig b/configs/T1024RDB_SPIFLASH_defconfig
index 86fb67c66c8..03d2f65af48 100644
--- a/configs/T1024RDB_SPIFLASH_defconfig
+++ b/configs/T1024RDB_SPIFLASH_defconfig
@@ -33,8 +33,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t102xrdb/t1024_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t102xrdb/t1024_spi_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t102xrdb/t1024_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t102xrdb/t1024_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1042D4RDB_NAND_defconfig b/configs/T1042D4RDB_NAND_defconfig
index e03fcb63d19..a3b1958340a 100644
--- a/configs/T1042D4RDB_NAND_defconfig
+++ b/configs/T1042D4RDB_NAND_defconfig
@@ -29,8 +29,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_nand_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1042D4RDB_SDCARD_defconfig b/configs/T1042D4RDB_SDCARD_defconfig
index f3f5c27dd0b..3e3ae2c7a44 100644
--- a/configs/T1042D4RDB_SDCARD_defconfig
+++ b/configs/T1042D4RDB_SDCARD_defconfig
@@ -29,8 +29,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T1042D4RDB_SPIFLASH_defconfig b/configs/T1042D4RDB_SPIFLASH_defconfig
index 36d855a1ac9..c1890912515 100644
--- a/configs/T1042D4RDB_SPIFLASH_defconfig
+++ b/configs/T1042D4RDB_SPIFLASH_defconfig
@@ -32,8 +32,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t104xrdb/t104x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t104xrdb/t1042d4_spi_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t104xrdb/t104x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t104xrdb/t1042d4_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080QDS_NAND_defconfig b/configs/T2080QDS_NAND_defconfig
index 67e606548a6..40c1e82a87c 100644
--- a/configs/T2080QDS_NAND_defconfig
+++ b/configs/T2080QDS_NAND_defconfig
@@ -41,8 +41,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_nand_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xqds/t208x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xqds/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080QDS_SDCARD_defconfig b/configs/T2080QDS_SDCARD_defconfig
index b9fd336a35a..7ddf5e0619b 100644
--- a/configs/T2080QDS_SDCARD_defconfig
+++ b/configs/T2080QDS_SDCARD_defconfig
@@ -41,8 +41,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xqds/t208x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xqds/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080QDS_SPIFLASH_defconfig b/configs/T2080QDS_SPIFLASH_defconfig
index 3e66d47a257..1f9ff569d90 100644
--- a/configs/T2080QDS_SPIFLASH_defconfig
+++ b/configs/T2080QDS_SPIFLASH_defconfig
@@ -44,8 +44,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xqds/t208x_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xqds/t2080_spi_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xqds/t208x_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xqds/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_NAND_defconfig b/configs/T2080RDB_NAND_defconfig
index c3589b19a7e..a0e4f8619c1 100644
--- a/configs/T2080RDB_NAND_defconfig
+++ b/configs/T2080RDB_NAND_defconfig
@@ -35,8 +35,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_nand_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_SDCARD_defconfig b/configs/T2080RDB_SDCARD_defconfig
index becc99eff8f..c4f647fd205 100644
--- a/configs/T2080RDB_SDCARD_defconfig
+++ b/configs/T2080RDB_SDCARD_defconfig
@@ -35,8 +35,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_SPIFLASH_defconfig b/configs/T2080RDB_SPIFLASH_defconfig
index 51766dac9c0..04f8ab03af0 100644
--- a/configs/T2080RDB_SPIFLASH_defconfig
+++ b/configs/T2080RDB_SPIFLASH_defconfig
@@ -38,8 +38,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_spi_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_revD_NAND_defconfig b/configs/T2080RDB_revD_NAND_defconfig
index e7f2b02a410..a1a63d9f91f 100644
--- a/configs/T2080RDB_revD_NAND_defconfig
+++ b/configs/T2080RDB_revD_NAND_defconfig
@@ -36,8 +36,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_nand_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_nand_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_revD_SDCARD_defconfig b/configs/T2080RDB_revD_SDCARD_defconfig
index 92defbe55b5..32909cbad2a 100644
--- a/configs/T2080RDB_revD_SDCARD_defconfig
+++ b/configs/T2080RDB_revD_SDCARD_defconfig
@@ -36,8 +36,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T2080RDB_revD_SPIFLASH_defconfig b/configs/T2080RDB_revD_SPIFLASH_defconfig
index f37117d3c9d..3a99374746e 100644
--- a/configs/T2080RDB_revD_SPIFLASH_defconfig
+++ b/configs/T2080RDB_revD_SPIFLASH_defconfig
@@ -39,8 +39,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/t208xrdb/t2080_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/t208xrdb/t2080_spi_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/t208xrdb/t2080_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/t208xrdb/t2080_spi_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/T4240RDB_SDCARD_defconfig b/configs/T4240RDB_SDCARD_defconfig
index cf0b7418fac..d9acf5bfac7 100644
--- a/configs/T4240RDB_SDCARD_defconfig
+++ b/configs/T4240RDB_SDCARD_defconfig
@@ -33,8 +33,8 @@ CONFIG_MP=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/freescale/t4rdb/t4_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/freescale/t4rdb/t4_sd_rcw.cfg"
+CONFIG_SYS_FSL_PBL_PBI="$(SRCTREE)/board/nxp/t4rdb/t4_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="$(SRCTREE)/board/nxp/t4rdb/t4_sd_rcw.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 0cefcadff6a..d25f1f90f22 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xFFFFDE00
-CONFIG_IMX_CONFIG="board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
+CONFIG_IMX_CONFIG="board/nxp/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-beacon-kit"
 CONFIG_TARGET_IMX8MM_BEACON=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index f364e17bab2..71419eb7d37 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
-CONFIG_IMX_CONFIG="board/freescale/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
+CONFIG_IMX_CONFIG="board/nxp/imx8mm_evk/imximage-8mm-lpddr4-fspi.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-evk"
 CONFIG_TARGET_IMX8MM_EVK=y
diff --git a/configs/imx8qm_mek_defconfig b/configs/imx8qm_mek_defconfig
index 113e0e0284a..e97beda2827 100644
--- a/configs/imx8qm_mek_defconfig
+++ b/configs/imx8qm_mek_defconfig
@@ -42,7 +42,7 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="board/freescale/imx8qm_mek/uboot-container.cfg"
+CONFIG_IMX_CONTAINER_CFG="board/nxp/imx8qm_mek/uboot-container.cfg"
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
diff --git a/configs/imx8qxp_mek_defconfig b/configs/imx8qxp_mek_defconfig
index 951d73fefd5..dea5188c2d7 100644
--- a/configs/imx8qxp_mek_defconfig
+++ b/configs/imx8qxp_mek_defconfig
@@ -43,7 +43,7 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="board/freescale/imx8qxp_mek/uboot-container.cfg"
+CONFIG_IMX_CONTAINER_CFG="board/nxp/imx8qxp_mek/uboot-container.cfg"
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
index cc7e8a3e10b..7c87b4972c3 100644
--- a/configs/imxrt1050-evk_fspi_defconfig
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -13,7 +13,7 @@ CONFIG_ENV_SOURCE_FILE="imxrt1050-evk-nor"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
 CONFIG_ENV_OFFSET=0x80000
-CONFIG_IMX_CONFIG="board/freescale/imxrt1050-evk/imximage-nor.cfg"
+CONFIG_IMX_CONFIG="board/nxp/imxrt1050-evk/imximage-nor.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imxrt1050-evk"
 CONFIG_TARGET_IMXRT1050_EVK=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 6b32150e408..4cc1ab8a12e 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -30,8 +30,8 @@ CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aiot/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aiot/ls102xa_rcw_sd.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aiot/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg"
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index 1d90a27c0ac..d606a4ff002 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -40,8 +40,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aqds/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aqds/ls102xa_rcw_nand.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aqds/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aqds/ls102xa_rcw_nand.cfg"
 CONFIG_NAND_BOOT=y
 CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index c1d5ee340e9..098c62db51d 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -41,8 +41,8 @@ CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aqds/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aqds/ls102xa_rcw_sd_ifc.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aqds/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aqds/ls102xa_rcw_sd_ifc.cfg"
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=3
 CONFIG_SYS_CBSIZE=256
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index 9b96676bb69..ce0b190de3c 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -39,8 +39,8 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021aqds/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021aqds/ls102xa_rcw_sd_qspi.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aqds/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aqds/ls102xa_rcw_sd_qspi.cfg"
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/ls1021atsn_sdcard_defconfig b/configs/ls1021atsn_sdcard_defconfig
index 3a927c858b3..70203dc94f9 100644
--- a/configs/ls1021atsn_sdcard_defconfig
+++ b/configs/ls1021atsn_sdcard_defconfig
@@ -31,8 +31,8 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_FIT=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atsn/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atsn/ls102xa_rcw_sd.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021atsn/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021atsn/ls102xa_rcw_sd.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
diff --git a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
index 6c12c35ab96..af4bb562b87 100644
--- a/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_SECURE_BOOT_defconfig
@@ -36,8 +36,8 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021atwr/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=0
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index 8c7126b53f5..a6041337800 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -36,8 +36,8 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021atwr/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021atwr/ls102xa_rcw_sd_ifc.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_BOOTDELAY=3
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index 6f249d7fb1f..d3194ffdbcd 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -36,8 +36,8 @@ CONFIG_SYS_MEMTEST_END=0x9fffffff
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
-CONFIG_SYS_FSL_PBL_PBI="board/freescale/ls1021atwr/ls102xa_pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/freescale/ls1021atwr/ls102xa_rcw_sd_qspi.cfg"
+CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021atwr/ls102xa_pbi.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021atwr/ls102xa_rcw_sd_qspi.cfg"
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SD_BOOT_QSPI=y
diff --git a/doc/README.pblimage b/doc/README.pblimage
index 58202c14a28..e99b010d262 100644
--- a/doc/README.pblimage
+++ b/doc/README.pblimage
@@ -61,7 +61,7 @@ Following steps describe it in detail.
 Board specific configuration file specifications:
 ------------------------------------------------
 1. Configuration files rcw.cfg and pbi.cfg must present in the
-board/freescale/<BOARD>/ directory, rcw.cfg is for RCW, pbi.cfg is for
+board/nxp/<BOARD>/ directory, rcw.cfg is for RCW, pbi.cfg is for
 PBI instructions. File name must not be changed since they are used
 in Makefile.
 2. These files can have empty lines and lines starting with "#" as first
diff --git a/doc/imx/mkimage/imximage.txt b/doc/imx/mkimage/imximage.txt
index fa4e486661c..cb2670562e7 100644
--- a/doc/imx/mkimage/imximage.txt
+++ b/doc/imx/mkimage/imximage.txt
@@ -25,7 +25,7 @@ Command syntax:
 		-e <execution address> -d <u-boot binary>  <output image file>
 
 For example, for the mx51evk board:
-./tools/mkimage -n ./board/freescale/mx51evk/imximage.cfg \
+./tools/mkimage -n ./board/nxp/mx51evk/imximage.cfg \
 		-T imximage -e 0x97800000  \
 		-d u-boot.bin u-boot.imx
 
diff --git a/drivers/mmc/fsl_esdhc.c b/drivers/mmc/fsl_esdhc.c
index 683a7931c98..79296c4b580 100644
--- a/drivers/mmc/fsl_esdhc.c
+++ b/drivers/mmc/fsl_esdhc.c
@@ -29,7 +29,7 @@
 #include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 #include <sdhci.h>
-#include "../../board/freescale/common/qixis.h"
+#include "../../board/nxp/common/qixis.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 

---
base-commit: 928af44314a1a086e946ef3c0901d40bdb3e19a9
change-id: 20251108-nxp-97b896b10209

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

