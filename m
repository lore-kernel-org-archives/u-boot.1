Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455E7CD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E56584687;
	Tue, 12 May 2026 06:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eEh9tadn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4D58464D; Tue, 12 May 2026 05:09:20 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF6883CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PezGsgSoAQDoOgsIBYhNPM5ECoZ7BEHwrIq1G8ptHnCmhbEa61R/gdiqU5f3Moxso/A5AE9cpTuUhe36DLqeGNYVDe6zU8Uz8zfVXAlSsYJ16bJHRiDbZ+R8qFCPQspDeyw+zHoKH68nonWz9AdKa6gqytp3iS4dHiby8B3GDh1QeecC9Bc2yjWGoC4JAX6FN5vR6bqTf6pC5bNM+nCRZpboH4wxnnR2B4+qK6+q99TSV6OCbVxcPVcKxTSPDIaTQakeC7hl8o4MCh6YkbWo24aU41Z23GoHnGlGEMO2B2lxKhxIq0iGTDSAIiGe4RjIr7D93ursUQLrPsOvydXTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJkttQ9OcJ8Guh8DO5cwD3fs9qE0b5S8pYBF9EGQN0o=;
 b=DBPhYOlH2P3MgOCQlalOkmI1/iNqZdToDW3+QiYcSNlTToGObXJqmmW8kguBCsirzB38Vc/HuI3V1eSCCUE/J/ZH9CQWjXnFjTeCGUgjUuUv07+jiX5rtRgJZQDoI0T7Zay0NGbDDQcEJmINtwS2Aph0k1rTE1QnRP3hQMyrikhIw3FsG+UwteXsDLEh3cC+DDjyEODQbteqBWhYZwSnpzOU9cXDsrZatx8GMcCrOMvXZDwXEL5ym+6qvWhK4vbN/Qn0TJ9gP1bMIw/EAWeJnjn4iLLVupfDCKRt+I8nKpDCryCjqiwhxnKprkWWhho/e2XbvjTqt6VHd+jthu75XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJkttQ9OcJ8Guh8DO5cwD3fs9qE0b5S8pYBF9EGQN0o=;
 b=eEh9tadnD530oz/DdoeLuYOdjCyeZkISnsVUJ8cSOd8PXEXxF3Sqz8nVDpGHX4ETLhdzkQNYUOj0oiqvJtAkSggz2mVZHrhd1ZFJFnA4lNAnC7qoN2IpApXvYhpQ5q4G1KbzhRwoufGNJEaizfwEoI31WqLor6hrliyycnrfQT4KAiHoB9TJl5CVI9/2MDA82mEd0czwjfgDbSbzD7shr8vEOVxbbC0tcPnr1s70PBBWdo6MjigRcw72GFHyi5CwBAGbivwc8t2ADFLuS/Q8it/7uOvgj+kjJcygYSUD1l/KV1Pat4RkMqZLd42QR6jyaOmOhCmE9kNXtLCfwjTNTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:09:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:09:14 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:14 +0800
Subject: [PATCH v3 7/9] watchdog: ulp_wdog: Use driver model for
 reset_cpu()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-7-0b9e1993557b@nxp.com>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
In-Reply-To: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Brian Sune <briansune@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, David Zang <davidzangcs@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRWPR04MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c48229-8c0d-485e-3e92-08deafd3d8ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|22082099003|18002099003|56012099003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: cPyMtAaOGYH5LE8/vu45uMiPWLJTRUxCEHr4j7ZpUr+//KDz2v2m/dDu0ho2CZ/PPwdyuX/4fGe9nQ5DFiHceKQF7NnEQIYygyubx/LJltGpSO7aBxaQF1qRycQgyLJSuZ2jO03gVIF3jLg+MS6UxuilrgpUp3SOyFO3adzNxTP5r2HWcSkvfYIiAz6LUb0cE57V5ZhcIE5pyiKIzsS5org7kpno0vMtn79tp3Dq9TRnDNxhoeqGpU0hSicc7OqxyWkiXnmRPUkdhA7ArLQozZakeisXJrzAiR9r+Bon2bXfQfNVP+tGXDr8SSCgsSLljpBoMwSAmpGqpdNHrufIQcW7xtWjj1X+4tKtG7gY2QJwrui99Z/5CD5OX8U/hMdD6YSfO6YOGcIK8f4ngTXaJZJq6jeITZrftqqz9WmQNT7OOzjMSgnpztGBl32Fou/PXoOIxEff1uQ3FnqFTfVB9r4+bRbgT/qf88jsGdJzmEv35c4Qc97YwmFme54qvQQs33uS1wUOLRwAc4cOJEzjYpLBX7Yf36kajHGJ6bkidNjFglQ59AmwUrlkOyswIQYf6ZFcfCn7667KgkBGeU0qVnygQxcIw+bNbHrFxD+rnaMwZ7IkW2pTNjyWGqquJHIwRToOqIWqs/0ftlkAd8oXDgxVRvZeVRxVvJmpX2VLvKoo9xDyodov8m5Cj+Vqq2OuvERwXR6Di9bo9MV+S79Mlti9Qb1f2578Da0frKjdcJtAd4al2lxE7oinx82VteCj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhCOWlha3hkZnBxeldONmQzbnBnWUdrWWk3TGVQSEZ5WmlIcHBncytSYmlP?=
 =?utf-8?B?SnN5ZmxpNG1ScVJPZ01TbFN3WWtIQVBPU1RiNFpYcnhNT0dPZVFObUlFcHV4?=
 =?utf-8?B?VnF2N25zSWJ5Zkx0TzdRTE9jWFNxN0FwWldZZ2tQWERuUkFUcFBuZHk3Y2VB?=
 =?utf-8?B?OFcvM0FqM2txdTg5ajUyM2xCbUNvaXNGS0o2cG1yaCs0UlBEdlRvd3lGbjdK?=
 =?utf-8?B?bXVGTjZ6bzZCSEpIcVZVdVU0YUduV1MrNm0vQkdiZHhLTDlxWVZ4SEJtYW9G?=
 =?utf-8?B?THpRUTdKWXV2V25SUE5XdDUrdmEzaGVZM3RqdGQzcWhnUW5EQXduTkZ5V1ZM?=
 =?utf-8?B?UFZwTXFjMUJ2VjhNUGN1VEIvZTVEU0JGQTh6V0dENHFjbXI0K3B6OUdYaC9v?=
 =?utf-8?B?ejRKdmVqczVZSVE1ZjdUVkZDZHFKWjdCVmxMSC9BMkZLWUN6cFhad3pxR010?=
 =?utf-8?B?RExUYkwrTjd5V3BPR2xyN3F3aTFuc1pHSC9GUDFHZ2pnRlNSUTFZTHBDQXpX?=
 =?utf-8?B?a094SGhCQU93NG04VDM0MnN4OUxEUWkzOVlaaUpMemRQSmFOclcxWm9qclp3?=
 =?utf-8?B?WkZwd2NmU2lJVnZpbUtRdmJWTnd4b3NhLzZTQlBZT1JmMWZ2U0ZuUytyOFRl?=
 =?utf-8?B?ZVltbkx3UElyeERrT0hqNzIzKzhzdFdJeDVBU0dlcXFGUTZNNjg0Wk9oN2xl?=
 =?utf-8?B?MTBtcUMzeHFmb1lnNUJNOUlhQnhHcUxWNE1JRkNleENjZFpoZ2lnK0FJR2J5?=
 =?utf-8?B?YXJ1QVVSeHB5RGtzakZBVVg2SWxYZ3Z2SU5XWWxzWHBsc05vb2JwV3pIbi9W?=
 =?utf-8?B?dHNUbVZINHVCUTRLZHlGVVRPNkN2aXhFUEVWVVg5YVVjcDNOMk9CUm1SVisv?=
 =?utf-8?B?Sks3bjBLeHNTM1k0WTc4Z2dUbVpRTmRLT2F4QSs2SndqZlZjMHJsaXJhd25I?=
 =?utf-8?B?WjJ4Ykg0WFRuTlZ1eTlBTkxkNzdadzRQOE04N3JjbTZWNkxiYnBlYm1ycGhp?=
 =?utf-8?B?VVp4TjZFNzUyeTU2TlpuM29pclZ0VUliQndoOTVsMHdESXJlUkVMNFUvMXUr?=
 =?utf-8?B?YXJoM0wrNUxibFdEbTJaeFZqSVlUU3o5bTlUQVgxOWhBZ0dMWVZmTzJCSmw5?=
 =?utf-8?B?TTlwMU10ZDJMOVc0SGJabnRxdzhUWnQxbjg4M2R1M2dIRWhiK2lIQmlxMGFQ?=
 =?utf-8?B?VnJ0eDJLR0lrN2VHWW1pVFVOVVlEaVZkRkFMZDhvYXhiMGdyM3NnNUZ1ZDBp?=
 =?utf-8?B?VXFuMWhGVGhzQ1pwWG5YU29Kd2w4TThKSzZSYnlkQWthbUJOa2tZbjErSGpG?=
 =?utf-8?B?QzlDMmJyWG5JUFNDOGttRFNQQU5JcG8rbW9iWDluRlpHUy9rMG8zak12c20r?=
 =?utf-8?B?eUpZZm9jdVJVYlF6RzdUL0FHNEtjMjF6YzBrakxZbmsxeW5ETHEvRWloUTgv?=
 =?utf-8?B?SlhHY2xKdk5qTS9GQ1Jyc05waVNFN0JiRXRQSmV3TFF2TWRKbmdRbUJybXVt?=
 =?utf-8?B?dEliRFVwZnVaR2R5R041T29JK3Y0aFc1am90WTBQOVo1Qk1XR1NDYTBRN1A0?=
 =?utf-8?B?OWNFUmFpTFE0Vll6QTJwY1VZQncxMXkyMFFYbG9PSXA1VDVqZXYwWmx2L3Nz?=
 =?utf-8?B?WnlGSnRsaVlkUmlQZm5XUGdjS1dKbDRXUzEzMm1kWDcvMFQrTjBkcnVWVEtv?=
 =?utf-8?B?QXdVNDc4Vkt4bHZqY2RmekZyYTFhRmN2TlQ5emp6aGVuV3lUcm1BOGNpSURN?=
 =?utf-8?B?eVJNMzNBdXlrbzU3L09OL1hGU2dtS3BYK2FIRkdRZFdmS1VyQzV6VERBcy9p?=
 =?utf-8?B?NzBadXd6TkVPTUpEMTh4SUloa20yUDZlZW9ZODZlZTlCQjdsTTdKTUpHYlIv?=
 =?utf-8?B?WlZSbzRkRFNzdzFJQVMxcWJOSTFlc1JaTm9wQUtoV250Z1cvRjVsUVhrWW40?=
 =?utf-8?B?ck9aSDhLVEtKcWJMOGF5Q1RkdCs3eTU5NXNTRDkwdURmd3pFanhpcGVvcnBp?=
 =?utf-8?B?MEdoNzUrRW5VYk5icnhNem1TRmpKRityMTliaHRiTVdlYmFWcjJ5cWNubFVM?=
 =?utf-8?B?eE5rby94WU5SN2JhTGlFNnpQL28waFZlSFc1c3o0d21hTXFwRjQyVHFqWTQv?=
 =?utf-8?B?VUhZYWxKTE91S0hrRUlJNm4zVzV1V1loa3VZNGJ5QnJNL1g4YnlhRnNMQ2J1?=
 =?utf-8?B?b3B0MnFBOU51NUl2dWNsdkxWamtNRzUyWndiNHpXaFl3djhEWjV6bHlKa0cv?=
 =?utf-8?B?S3dDbVcrSjdTVytOWjdKd2NQYldjanRFTGVSaXk2Z3hZWS9oRUlxTjdSSU5O?=
 =?utf-8?B?VVVGbURrekJUWTZCQnlUY25PNStnV0tXa09QS1B0ZHp0eWtTZjc2Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c48229-8c0d-485e-3e92-08deafd3d8ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:09:14.7104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J87SxVahy/GH8LHapz4ooeovsSzwximqmuO4IkSLRvXpVlQF0EE0g5xguJ8LWMB6RmSTfnnnwYzKLdxZXHOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
X-Mailman-Approved-At: Tue, 12 May 2026 06:40:14 +0200
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

Replace hardcoded WDOG_BASE_ADDR with driver model based dynamic address
lookup from device tree.

- Remove hardcoded WDOG_BASE_ADDR from hw_watchdog_* functions
- Reimplement reset_cpu() using UCLASS_WDT device iteration
- Add ulp_wdt_expire_now() callback for standard WDT interface
- Pass wdog register pointer to hw_watchdog_set_timeout()

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/watchdog/ulp_wdog.c | 79 ++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 83f19dc0e86..e3a89031c44 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -7,6 +7,7 @@
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
 #include <dm.h>
+#include <linux/delay.h>
 #include <wdt.h>
 
 /*
@@ -51,11 +52,9 @@ struct ulp_wdt_priv {
 #define CLK_RATE_1KHZ			1000
 #define CLK_RATE_32KHZ			125
 
-void hw_watchdog_set_timeout(u16 val)
+void hw_watchdog_set_timeout(struct wdog_regs *wdog, u16 val)
 {
 	/* setting timeout value */
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
 	writel(val, &wdog->toval);
 }
 
@@ -89,7 +88,7 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	while (!(readl(&wdog->cs) & WDGCS_ULK))
 		;
 
-	hw_watchdog_set_timeout(timeout);
+	hw_watchdog_set_timeout(wdog, timeout);
 	writel(0, &wdog->win);
 
 	/* setting 1-kHz clock source, enable counter running, and clear interrupt */
@@ -107,57 +106,20 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	ulp_watchdog_reset(wdog);
 }
 
-void hw_watchdog_reset(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_reset(wdog);
-}
-
-void hw_watchdog_init(void)
-{
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
-	ulp_watchdog_init(wdog, CONFIG_WATCHDOG_TIMEOUT_MSECS);
-}
-
-#if !CONFIG_IS_ENABLED(SYSRESET)
+#if !CONFIG_IS_ENABLED(SYSRESET) && CONFIG_IS_ENABLED(WDT)
 void reset_cpu(void)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-	u32 cmd32 = 0;
-
-	if (readl(&wdog->cs) & WDGCS_CMD32EN) {
-		writel(UNLOCK_WORD, &wdog->cnt);
-		cmd32 = WDGCS_CMD32EN;
-	} else {
-		dmb();
-		__raw_writel(UNLOCK_WORD0, &wdog->cnt);
-		__raw_writel(UNLOCK_WORD1, &wdog->cnt);
-		dmb();
-	}
+	struct udevice *wdt;
 
-	/* Wait WDOG Unlock */
-	while (!(readl(&wdog->cs) & WDGCS_ULK))
-		;
+	for (uclass_first_device(UCLASS_WDT, &wdt);
+	     wdt;
+	     uclass_next_device(&wdt)) {
+		if (!dev_read_enabled(wdt))
+			continue;
 
-	hw_watchdog_set_timeout(5); /* 5ms timeout for general; 40ms timeout for imx93 */
-	writel(0, &wdog->win);
-
-	/* enable counter running */
-	if (IS_ENABLED(CONFIG_ARCH_IMX9))
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8) | WDOG_CS_PRES |
-		       WDGCS_INT), &wdog->cs);
-	else
-		writel((cmd32 | WDGCS_WDGE | (WDG_LPO_CLK << 8)), &wdog->cs);
-
-	/* Wait WDOG reconfiguration */
-	while (!(readl(&wdog->cs) & WDGCS_RCS))
-		;
-
-	hw_watchdog_reset();
-
-	while (1);
+		wdt_expire_now(wdt, 0);
+		break;
+	}
 }
 #endif
 
@@ -184,6 +146,20 @@ static int ulp_wdt_reset(struct udevice *dev)
 	return 0;
 }
 
+static int ulp_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	int ret;
+
+	/* 5ms timeout for all others; 40ms timeout for "fsl,imx93-wdt" */
+	ret = ulp_wdt_start(dev, 5, flags);
+	if (ret)
+		return ret;
+
+	mdelay(50);
+
+	return 0;
+}
+
 static int ulp_wdt_probe(struct udevice *dev)
 {
 	struct ulp_wdt_priv *priv = dev_get_priv(dev);
@@ -202,6 +178,7 @@ static int ulp_wdt_probe(struct udevice *dev)
 static const struct wdt_ops ulp_wdt_ops = {
 	.start = ulp_wdt_start,
 	.reset = ulp_wdt_reset,
+	.expire_now = ulp_wdt_expire_now,
 };
 
 static const struct udevice_id ulp_wdt_ids[] = {

-- 
2.34.1

