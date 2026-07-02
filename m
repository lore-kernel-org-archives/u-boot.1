Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94E5C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649BE84D22;
	Thu,  2 Jul 2026 07:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Jnrdl5AO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0579B84D20; Thu,  2 Jul 2026 07:58:49 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800E784CB1
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrZAxOwx9MYlYeHeJnVtnpvt4HYMu9iIT5PBJnBQomI2+0t+iGotcx9G5dB5Nva6IEUscZKvaZgSrMMZRV2yb423g446DOKmWwddSVQMo8B6QGwr7vWop/T79Hw7pU+u6wZK1BcFqoa7gcUTqTiLsFtj+SqzV8y9pStJDyMJjg85GLHWGZOhimbbMlBjzs6nNiOmQBTyIjUigLkuX+CNZV45PZGdltxQPTM1mdneVE0CuGp1oqeWbUxbZwQEhQhLZlmnyV1v8le2k6zkWG4pQJ3qUsO8065CXDQeSZkfIN0lS2QRFyHsm3Me4LtxbUpd2PsuZWQcV7TB9wra8cjJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=wVd4xbFXsnonrh62yp5mhVewzJ5JesZEnVtxsR2mMrnZSYW8J/Plqft7HRftOagnQ01ky1cWsEhD7RQtXlUK9wx17UngTfsffriDkY99Y9M5mFgCt5UNUJIB58zWEbdhd5oux/kGvk2Qd59/Q+u7p53cojXqy9oSOKGk3RG7q1NwNyIteTYitBwspfX0nHUMDL61MHphg79m1OrQ1ay/fAGHQNWm+pNp6dxa2wBqXmGLB/zvrHgGeFARo1T4q9TISAsMSealCuhyt1XSwDoFmKrDF9heHDTds6mWNf4yFhVcmRrlaxzqE/80g0sGYE0bJCS6Vk9s5ul3dRU12bF/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhkuVJn7eNfdBvuTDw4y0ODN2lOxGOBn6eOlGj9yYk=;
 b=Jnrdl5AOy7M73vshOWNmQJH2os+ZXb9Fp00odkMuucG3/Ui88bdl07l+vPWV1HtEmWh81nbVFiY3PdDuLEuWT7t/R75AhpKA/xO5hzer2mHJFoODMCWVQ9Y8FARVIePNzfYOU1SCeTahdG5nzEHs7yvtT1Kmj0dGaT0WLwa24h6aVy0ffubKUysH8IUD9mOtjYjsTnZrIs0509NnQwmBimOuxfBx/NQ/o2VktKpuFSAiJGn4F62uAte2D+b3ooJ2xbfbm0YMP2olfVHT7CHbBcDbNYSyzyrKAadigH/eWFddapyXaDZaQWyCfQTEpXh4p5NRueNR/bHQ8SrPDjdZ1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9543.eurprd08.prod.outlook.com (2603:10a6:102:2f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 05:58:37 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 17/18] configs: airoha: en7523: enable pinctrl/gpio support
Date: Thu,  2 Jul 2026 08:57:43 +0300
Message-ID: <20260702055744.2164975-18-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 571b4808-a308-48dd-9953-08ded7fef5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|1800799024|366016|18002099003|56012099006|11063799006|921020|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: +fTi+I1KI4WKk2gTykXps/Dirtupt5wjYpd2ALOthxpN5s8FVA7iQ0Rf9FJ109UA45yxHSIqLJgg0K4iIi8SS3jhPItE/7OpfimHzrIIwBgyXp6PGzfcYbSSHfTSkNFQW0k2knp2CvvZMnXCeJJR0GMl35at4CLnahcV1AEXoa3rgWMzPz7LYsR+q4NACskqyF7sCH5u7h11ln9T4iFA17IN9FrLjlPqOylSARndPHNkT1rIt871q+2k1RhvxrlLG6jBTi58DsC14+0AA4FRbUZbDOuaNJM8+v3WrOToY/D5m2ZAurtGDTPe7JGu2qvIesQN2LKvBPN308+GYOr8sM1R+DNZy6Phx5RW5QVUuaQdVte4eVJD3EUrBqoAc5Q1pWFsn4Y0xvwiWgXwajaTMAhG7Xa42OblH8D+LFitTM3NRXCHKkG83WKH3yFp7T6QVqvBgd5/zpzmhXntFjrBV52bupDqJkzr0I2X9XOnKzgXVB49TL5IdBbU9sQN4Xg2PAnRpsipg4UsRHRWVIA+VrjZ1qzJCJqtDUDvJQa6c3IujfszBcCDCn1VnrkfTzVBN+pjKKip08uOjKvtA+vPkQXyq8j8C0gCKO6s/LMxZhNqzMQZnoHKbRuCSPLCOlAQ6EA76b3MwAxu4SuEaEe4LU56TlEFE1CMS+Gc2St7aO4x3laPmRxO34f/Q1DDa1+wO0E3VvCX2uibFlbbSQ/kUULIRVaVP8PDD4OsUSHvtxrYduyoCvv2xqhlDLqU08D4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(921020)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pr6dE/FiiPIVle5Cbtxo2tBgZW434yu1vSfY3c60OiyNREOzhHJrh9rtz7RH?=
 =?us-ascii?Q?KwBVt/z/p8OzBo1Z5U0PzCQrgyRyYYPGbahaj0xGICgeYMdks06BoWW4vicW?=
 =?us-ascii?Q?fTMaTKliquYahlK6WuIb1qINMhfoqK0+Q4raWIePlFL4ViuTaSBeBzdIWi1e?=
 =?us-ascii?Q?AfEoRsGLnGTXhRS4t/z3f6MF528yjXiCdMbKx7urxbEZlThIe6wYnSlrD6gY?=
 =?us-ascii?Q?waNJ//BpyyqTS2wIq3WvryNrxwD9rhDUkE7NLe0nxCEbGIJDfdMZGvA+fXxz?=
 =?us-ascii?Q?eB/VOXCC15GG5nQnYP26o20aCXW7hAQsvGykAm2jfgRqEaPrBmnSwbVvzkfX?=
 =?us-ascii?Q?NYYT2SQbEAHu8wALxjyu1ZMc9EKgZoDRTSE81Tduq0FE2IefwTmzDkN4Y1X7?=
 =?us-ascii?Q?rmvcr0gnchX3twkdSM4nEgskNxHjToeIzI/iA6i20CGG4IILQrHS+u7jbnp/?=
 =?us-ascii?Q?z4YyYoRYS7s6Z9QTPqI0w6jci0Z//wymGvDCnjuwChHVY28eGJ1jrtWsATj2?=
 =?us-ascii?Q?S4MThDzx0X2AKNdJxUdQrnBEnyG1+64XBzR9H8mjfuWL+d9Rm45p/Re6TyJY?=
 =?us-ascii?Q?M1eHjtHapKa/kcQhPgXmpOhHPSN2IDtuJZhV2/O+yTL9xPyC/Sqj8P9rWhVm?=
 =?us-ascii?Q?NZEsbhlA3PswrKTBn2XDRDlCcoVy8znCMn4YFjayB/UTS5MFyPzPVyjnIkIp?=
 =?us-ascii?Q?tDZrt6e58d4YMUqB5jgtQ+j32+wpwiaguCXqnqaMBs2phsFLoh7jKmfjGYKz?=
 =?us-ascii?Q?Ltvv1wptVlPsB06LnqTJ3QBU9+J6Q8G622TaeaaA6CvmSs8phjYFYWWn42df?=
 =?us-ascii?Q?XoodOotS7oWovWCYXkY8RPk5nG930GHRZVuJiGDFGURAxHkOMYD64uEvqSfy?=
 =?us-ascii?Q?vxjtQTU1U1tWBHj9sgVcFU9Y1TQhjG/sAArQ6kAVWnSBT9jfGRrXhX//4TB5?=
 =?us-ascii?Q?12F0ixZtIkEEtb7u4gA+xxBWBDZizWwNkWiKFWRoT57oEq1Tt8+ZflMBW4mP?=
 =?us-ascii?Q?7s9hcDBYjVFi6bqmaBJVBzecJ3LJt0TzDrLzLyy64TeOR7Kl/EW/M8lfJzee?=
 =?us-ascii?Q?lecg8I7bV0DsFsykOPf5ieLFbNMAo4BNdCKVL3o4voYPlGHd7psBb3qlBXis?=
 =?us-ascii?Q?2Nfu6c9bs3HT1Tfiifl6gaGcvM+JkvwLtDDmK8O2HzXmncycbwKa+/YSrLSM?=
 =?us-ascii?Q?fBTaWTxcqLvhC/0SnNcu2htMUgHLOMBFZFWOajkjpFyQDH3/cSjL458FScbD?=
 =?us-ascii?Q?dzNZDuYhd1STERnCpoVL2RD0rbMfZPcwVi0F78FLoTvuvr9QiuIdh9h82FNB?=
 =?us-ascii?Q?sUDcj0sJhWJscScwHY5tNnzV+7+GAta82x/S2ZWWTn5f5r8bwRydfCpJahEM?=
 =?us-ascii?Q?v3sEru4FOP8+tUao7Wfjl1Tj710Ko4CKd/32nnW6l+h1+KFTHDLbzGrEjwxI?=
 =?us-ascii?Q?8JjsEv6Fzuatav2BTjsiQda3iT+tAy0OdcqyVElbfzSOCg6CO9DVuFXO7sZV?=
 =?us-ascii?Q?kFx57FHgEKxtH6llUes1TIY6E8VmmamEEC1gNZdilhdTR9JoRDLVA/qoKW1q?=
 =?us-ascii?Q?+410gEeZRmrA3/TeBQkT2sH8WhqzavZeamPGUq5DcmqasP+mKafmc9P3XWEC?=
 =?us-ascii?Q?3yKERhMpNA9bbL3b5QptYUrXuql3el4LNPDLT5tm6tzpORCo+VA4RN03wvjH?=
 =?us-ascii?Q?ydGV9RP8dmj4KkAlwh499837lplnGiol+KpjpuRXBTuWzztPtl4r2LmBjwaw?=
 =?us-ascii?Q?6yQO6WjcQ5rFOPRgrCWdWhfvTkPzBYM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 571b4808-a308-48dd-9953-08ded7fef5b7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:37.8617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7LFHvSOvOw+SxFZBAXxx072t5wWOKgtkRPDGru7IUsclr788Kt0z6bde7nfLgl4RkSDBnnlqwr1AabkwCfzapPoIVHGM0NQZdQ9tkPEl6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9543
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

This enables EN7523 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/en7523_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index d3137a0ae44..8b1f3c71e9b 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -54,7 +54,7 @@ CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_EN7523=y
 CONFIG_RAM=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.53.0

