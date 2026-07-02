Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA8AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E41847C3;
	Thu,  2 Jul 2026 11:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FbAUKd4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7851784C5F; Thu,  2 Jul 2026 07:58:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E60E84C86
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJSRjFr+RROvs8OJKksMHQvWzAx+dooXmXTVxUWhzZwOXmTiyQOuCdDFKRq/ybtqQ6LOY5r7eVNtGz1ogWCPUMESS5XubcfT5kAarSHuFrKa++zVMalXNiXvPLNQ+hXMIt6gNJhKVYCSecMhpeG3kyXL0wpM/pb7i895NdCCY4CaO3MBfU1+/uuwzHF/bdmHve527+iDtGkS2L1pEEf5i8WVCTmavqEegL+CYg5coNUmpRB2wqPyGqtK7E0qgtbbX08hFjUCVWjsfShK90g1jpwrhEj2+Uck2Sv6JV6iUFrPnSeMeduxkRtDsLxaaeZ9lkmu1fgJtWqZatK10DhRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=RzHF8bpxK/LhYODWxthfcuYivqIPxGxBV0RTiA9Y86DFTPFYN1ShkZvFnJxtySlx13wB7HTu2P4m7RwrmFBk63A2trr+cQ2j8H3ZS8YLymPVpjarLmV/Qr3mGiT6G51U7Y0g9EfRwq4Qb4+JSqcxHRCTaDWIHlm8wNMu2tP79fqUr3Fohr7gksn170EEgVujcT+Y2vVleMhlf8+paBFsbqphhnzixLFXI2qYdcoll7ukBg6rwPT48P82OqyBHQROGJ8n3e8QJKjjDVVc1yTBHEZ05TV+pahlQYn1DXwyReYSEl8wI3cGweBMRfSeZXvoLlVrM/s0GS1/wxHMBetEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJInxmyMSuCkonBZ6AQdN0mn8aGtR41Pn7XTtLtoBU8=;
 b=FbAUKd4sjAhq5ZM/2GActBjo+Vi/gKGydTN0GO9eQylRMHLyB9qebtQeP6c/0qIqstu8HQmumCl2B8AUhoipcl+IgqBe4J5W0gAMwgX97tScU66wpa3l0hDxsgwuL5A9p/HpCtpnbkKCjfEh9/LpOgIBTNxyrjHPvekIgLz7kpsfQOUQSjn3m9k3htpWKC0noekruOaSe6MSFzqSegN2AHt8afIg/17bOLUndTLfLl87Zx07AdPKC63YgE3OWIhZixTb4EpBiVY5K+yZgF9la/koTDNv+uaVPUcfwxrmEd9NdxKPdbKwuhlTWdMwjuJybJ98kmlYl/gG/MO+DZ8wkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:02 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:02 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>
Subject: [PATCH v14 03/18] bitfield: Add non-constant field_{prep,
 get}() helpers
Date: Thu,  2 Jul 2026 08:57:29 +0300
Message-ID: <20260702055744.2164975-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f221f52-f941-4988-6118-08ded7fee0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006|9063799003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: Syo4FGiRbnkdd6/dHjxzYZL1fnZ/rYqY7wtyiPL2e7ArLx/mhjj5uPAjVAC561pm9eY14hhd9i6jkO2zDdgzC5T0eXO3id7pn9uO2EsqVkybFsay6SMpiUTdKZBBtWqnB3lfNlHJCC+oTEgWjdITg1nUNwH2K0Zu/jjJBCH3af+uX9vY13zdjkAtNEkuE/aj+kl5ju/GT0hOtPIZU6XauCBhTJPJNHq/3SfH3t2Wjahzn6Y9MaTC1nANFPLk1hL9Oc1cLLRj2DUzZzB8a1OnbW4IjZuWQNtDpr6+zHstVeROxtuCOU+gLHJJKus57DDhBQK5imaM0/CayBEHaxC1p+J5UqdRP73B0s5mBeUVGuDo9PVYOz9CZXzLTpCujw7yxYmwRl9E1XU9wLkAA2eA77SoEBzZVVPA2n6+89fmzhkQvMWXU3+wlVfh2hZwov0kEhgLY3q16f+hm1kdYnkUV8iZ169rt/xVXxhdL9Vp6HtS4gmJWQVOe10eCLaJYV/Gef5akidJdqDARWa/71QFJuw+tgrEidCSimgWTkPFJhuitea3A4w8I3tK5Yoo4mlxxGcLbPGV8v2WN9BseJQiumQYYydJCMBjCHoClAMQ0l6nYvKpZStmW9eBmHo8PoxWkxV9pwbuBn/WP+G689+N36fYHFFtDkGYxlw1a6rPlKdwZNyoJTJvpRgHO1nWEpVxgKtFQ8J47rpopsSf8p2c+68ifQOyM/6eYoCSfInY2WkQIhkyiJUPnH6ktzgc8SXi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006)(9063799003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlRdk00cjFIZnV0QkFVL0ZCQUdNMi9nWTFsbmVtSWdCdjI4VWl3QkxGbHhi?=
 =?utf-8?B?SHJFWU9YUm5lRk9WR0Z1dkQ1d3N5eVl4ZjdLQTMzTWN6Q2h5cklVeFVqdy9m?=
 =?utf-8?B?a1I5TDlzeDhqM3lOU1E4SHZnbTFEd0VkeEhBRHY1OHBFM0w1SWYrRlVoVzZ1?=
 =?utf-8?B?TlZjU0FGQTBVQXpOaWlNb1lIMTRCbUx1aTIxMWpXUHBjNUtaMU1hYnNpNFBx?=
 =?utf-8?B?VUtSWVVWdTEwcllFQzRnWlFXRVRjOTc0c1JxNTRDazhtQkNUTytPdmVOcTJB?=
 =?utf-8?B?SmVQano0RHpTNTZQcms5T3l0V09nNkNybWE4M2tMLzZWYlp4Wm1kRHRuVVlY?=
 =?utf-8?B?NG02WGpudzZNeTdMZ1Zjb1BmUnRSVmg4djBJS1NreFl4SllmNjVtSldpMnNJ?=
 =?utf-8?B?UksvMjlnVG1YVEk2bjBwMDZ1LzNqSGJzTHF2b0hjWFNDM05HemszMlk4OUdz?=
 =?utf-8?B?L1ZGbGJLRW1mdis2NVJQZmRQT3lXWXR1U3g0VkpoWXBkSGxHU05hNm5MVUYz?=
 =?utf-8?B?dExuNzc3KzN4QWx5UE9KZzhUZ2t1aWQwNG9va2FEZlBKZmFnZHBGMThkL1Fi?=
 =?utf-8?B?UUU5M1FQVVJZUG5wN1JSaWh2Vmo5dWcvVjV1VEJrT2tlYTEzQUZiaW5BWng0?=
 =?utf-8?B?MlFPUzMrNjZZbERQLzVIemM3VHV0Y2wwR01MZkhZM29yMmd2Z3NZQmRmalFn?=
 =?utf-8?B?d0ZJYnRjZDFEVVdrZGdidTUxUWdXUTBRK0hQTk5ybkQyVVVGL2Q2WCtlVGRt?=
 =?utf-8?B?MlFVRkl2eitYL1hKcUJDbzIxditwUzI1bjBObEVIL05wcWF2RlAwU05QcTR1?=
 =?utf-8?B?UTIveUlURkFrbEtiMEdxTTR5R2o1SmJreVJYK1gwZ3RyTmo5UFBYRXUrOW5U?=
 =?utf-8?B?T1RwS01GT3IxRjBIaEJOWURtNVQ0ZE5xMGJ2ZmlxKzhhcUtoS2xlQkJ6Z3kx?=
 =?utf-8?B?SUdRMEVrb3lGeFlNNU5HRG50Zkh2ZnRocnM0ZWg0WXROWmxzODgycjhFNEhF?=
 =?utf-8?B?OU5OUXRWSmtqMDR5WC9SbStpMkpycHF1NSsrWXJ6U0xBNVRtTkIrUWdDTkpV?=
 =?utf-8?B?dUNRVVVJdW1Na0JCdFZMMkE2TDR2bFRxYkxjbitmU3hPemtRdDVhYTJSVCtT?=
 =?utf-8?B?WWZXcjVZZW9MNVZIVm5ZUmdNbkYvN09MN3dUVXpTYmQvcGlnY1N5bThKR084?=
 =?utf-8?B?R1J1V0hxcWhlODlTU2YxVU0zeTRRWmU1R201TnB6TE9hS3d1REpsR2NGSHBj?=
 =?utf-8?B?NndCWU5rOU4xbFZsdGszWXFaYXFSdXpwQzFZcFp5eC9FbEFteTRUU1l2ZTRx?=
 =?utf-8?B?bFNTT0JwcDJlR3lVNUFBUUtnM0k2Q2RxbXZ0NUJRZmdVd21IM09DZ3ZLT2dh?=
 =?utf-8?B?STRqNGFla1NIWkczTjkwenRIckhTUXE0RjVZUHk0aFJ6eWpOSHBYaXY0akJ1?=
 =?utf-8?B?ems5cG5yZmFXWmplZ3N4MytMWUgyUGo2M0VwT2ZDcytpL2dKM2gycXVUNDhu?=
 =?utf-8?B?UmhNTWlwRnB0cGgzY21WOVJ1ajBsZi9OSDZCQVh0UThzY3Y5VmJGdjFFVDNP?=
 =?utf-8?B?WklSZGRTblQzRDA3V1FYR2lZZEdxSGFEOUoreXFObnh3QkYvWm05R0VsOWVB?=
 =?utf-8?B?a3UxdXpSTFpRUVFZT3A1VWJLNG5FUlhmLzJTQm5jck5la0EzbCtRd1RoWnVZ?=
 =?utf-8?B?Y2o0RmR3TVR6RVZIbFpZeG93U29CQTI1aVNUaEwwclFlTFFWYjRGVS8reHdx?=
 =?utf-8?B?Wll5U29vcXhxWVBrTC92NHBjMFlVdzhrMWNrZEx2akNudC9UeXNxNDlINHo5?=
 =?utf-8?B?SUl2SGFhcktnaUhnYWlPMWNKMVpXL1lGVGNvM0E1OHg2blBhMTR4TVcwSmVO?=
 =?utf-8?B?RUpvNWJ3cVp0dVl4OU14VjJRZHlDWHdiQXhLamw4Z3NZYlZFd2VjaDVnTHph?=
 =?utf-8?B?M3RZendpMTIvbUEwV3NLbzlrRUhsSjRkNWIrWXZqMldkN3lXM0doamplclVy?=
 =?utf-8?B?RnBEUUFwT2l0S0R5bGJhK0RWYjVUUGVJY3V6RzlhK1pOSGxNNnBGSzF4dGpS?=
 =?utf-8?B?d0JGblRHcXNUTEVyTUU3ak5hSTZ1aFFrNmFDdlNHZFJDbWt2Ny9scWdvVXc0?=
 =?utf-8?B?SFR2YWtRQUxqdHM0L1ZIM1FMMktjcDBmNzhFcms3OTVmOVVTbnd5NjFxaDYx?=
 =?utf-8?B?aUVTMEhlUW1BWE9UNk12MHFUSmczaUI0VWI2cU0vNk1kaDRwN0Y3RkpLWXhK?=
 =?utf-8?B?L1hqNkgzMFR1a05yWlU2WURKc1NvMTVINmxJZFNHSytpTFlUU2lRV05zTkQw?=
 =?utf-8?B?Y1hVb3JYSEJQUkQ0T0pnbjVoWmxKQ0FudGFhU1NjUTdEc3R2Q0p6bjB5U2wr?=
 =?utf-8?Q?9ZTl5mKPtusLyQg0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f221f52-f941-4988-6118-08ded7fee0bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:02.7134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHDWyK4HyTDLAWXjhGrQRAZ4q/b7ERVP9hnGMwWlL3tfzPtJn5xQSxXpwwxz2c3lVEKDUdQLV5TMqwhJDA8G7hl0UPVeZEgVpcdF5Zggq2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by adding them to
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures,
  4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
     actually constant.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Yury: use __mask within new macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Crt Mori <cmo@melexis.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitfield.h | 59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index ef81901bc41..18cf57aeb2c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -16,6 +16,7 @@
  * FIELD_{GET,PREP} macros take as first parameter shifted mask
  * from which they extract the base mask and shift amount.
  * Mask must be a compilation time constant.
+ * field_{get,prep} are variants that take a non-const mask.
  *
  * Example:
  *
@@ -223,4 +224,62 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+#define __field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __val = (val);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define __field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(__mask) __reg =  (reg);				\
+		unsigned int __shift = BITS_PER_TYPE(__mask) <= 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @val:  value to put in the field
+ *
+ * Return: field value masked and shifted to its final destination
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_PREP() directly instead.
+ */
+#define field_prep(mask, val)						\
+	(__builtin_constant_p(mask) ? __FIELD_PREP(mask, val, "field_prep: ") \
+				    : __field_prep(mask, val))
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position, must be
+ *        non-zero
+ * @reg:  value of entire bitfield
+ *
+ * Return: extracted field value
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ * Typical usage patterns are a value stored in a table, or calculated by
+ * shifting a constant by a variable number of bits.
+ * If you want to ensure that @mask is a compile-time constant, please use
+ * FIELD_GET() directly instead.
+ */
+#define field_get(mask, reg)						\
+	(__builtin_constant_p(mask) ? __FIELD_GET(mask, reg, "field_get: ") \
+				    : __field_get(mask, reg))
+
 #endif
-- 
2.53.0

