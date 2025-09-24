Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4DCAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FB08362C;
	Wed, 24 Sep 2025 17:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n4jEYvXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9888833ED; Wed, 24 Sep 2025 17:18:55 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557480819
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 17:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dq5RIHYVLYP3xM068YfVRVl9nKjxAELXeCiNaQr8NxqTqN8tfUguvMc9+kPGmPeQl0UQZwi5PZ23RH6TORrlLYzRHMHp7n+nvP5qgheK6B5/GoyJYNxdf9+Ys9BjwHiznjim1+zXO7MpHxK6O+UzACtTC1bLksbSpFwXplRYAKsprcfkcpo7//MiljA5nqoSyyaoH1L/wVfT2C+pKTn3oA9E2OlmhIzxMCtpyJ/CS1EelK9Zcdxwo0FDHV9y9VldKphF3/urcbf/5sK3CA1iVhTMpevcRXJR1lGlLwHQM/j155AvxyNldJRqZQDS/UZnle4eGlnGMR1WvC6yHgJbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKLDI8pp1/AMpHPJd7cZHWxi/GN7znkBvAgouArpST4=;
 b=nNDSuH79IwEVhaeh4yW9GWy1cuD+RIimdSE2zpay7TuClfeaFBZoGKwsNfj5LxPMFwaSAZP8vEoaqyKkrEco2oqrQyCUUNHFAl/V91yOet0htnoVZMekULjEpYtdXySATciTp6ja4Jrgagj0H/XAWTtH0DFvKAGXk/u/Ls21yhzfCYM8jdWc0Tp/a1J5Uff4pN7kZ6ooBlQ/HuNCGJnVcGp/Ud1yc8qXmiLXxWxBgFkvu27Lt1dk2pAClIkbvFgnNo8pcJ8kdSvy+STU0sfp+CGfsJHdwQgOiWx7wD25huJaN0HQNT+69WFjCDRy9Xzn6iVrWUgPxz3IkOPMUYyPbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKLDI8pp1/AMpHPJd7cZHWxi/GN7znkBvAgouArpST4=;
 b=n4jEYvXE9LSkaV9e1eQbJmwT5rdiOd4Mr0aLJDKXan1gtbOc/SwBoILAGWXVpZJ7wtEpPv4vtTzHHAo2aS3+nTkxIQ56MAzbiuGN4vt29QxPygX8Q0vLSgoS5bRlnQ4hnW8OGMUeYAkOtFT+d+6FKBVJwt3DiKxXzPbmlyIgRoRt9vwI91bhQpZsQM/QTtycTSLIgo9aM4YWUmVSK361pZNlv/h4tgAFyUDBtIw2aIA6E6FxOZiOqXmXMfNKgg503wb9dFNqwih9ERvjD1B81BD6mw6bTVgFLAHVY7iA/Ov7VOFys5Lhkez567x30wM0PP4+RpU2XtakYKAnsQUoOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB5PR04MB11254.eurprd04.prod.outlook.com (2603:10a6:10:5e6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 15:18:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 15:18:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2] power: regulator: Fix incorrect use of binary and
Date: Thu, 25 Sep 2025 00:30:12 +0800
Message-Id: <175873139553.3222.3482387473099940414.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250703-regulator_uclass_fix-v2-1-5ce6f258f5f9@linaro.org>
References: <20250703-regulator_uclass_fix-v2-1-5ce6f258f5f9@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB5PR04MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: fabb6e21-ce7e-4133-0a96-08ddfb7da90a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|19092799006|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUN0T0s1cjRmVUtJenhnREcvQmJCcWx4Zlc5cS9Ed0FvR3pvTTBYUmluL0Jo?=
 =?utf-8?B?ZTRxZWhQcW5BUFRUemVUZDc0L0I2WktiUFlDS3pMcWMwWDVKZTB6MFk2NUpw?=
 =?utf-8?B?VlZ4LzdGVnY4Zm4vaDg3SHlzWkxEVmpVKzlCY0haNzhINW00cEZ0VUZJWXhk?=
 =?utf-8?B?RnkveHRyaFRoTlZVaWRLWUM1V1oxNlEveXFSaURnankrdWQvRlgwT2RPR2c1?=
 =?utf-8?B?cjZmbEdKUkpZU3g3eXd2Tm5JL0wyWThQREVYZWpibFZ6MTQ1M2xtMER3eHVp?=
 =?utf-8?B?L3d3bENyYlVoYm5xQUJpckY0RGU4dmFEdmovTG1nOEpEQ3ZvZ3VYWnVObXR0?=
 =?utf-8?B?Z1d3dHIvR1BKRDBZSGNmYlROV0NCTEpkdVhQekVuSFpNeWdWdUlTQ20wWmVY?=
 =?utf-8?B?bE1iUUh0Nmd2UzNFQ25vWkZROFZZaE1FYnB5UEpqR2lkREZERmgweUYyNjFu?=
 =?utf-8?B?UTVPdmRnaVQ5S2RwRi9sK2h2WStNTXk4eU5EbUd3ckRyQ0JGTHFiaCt4R0t1?=
 =?utf-8?B?N1MwWkdSb2UwR3hqYWNUT3Mzbi9WRE1uOURxand1ck50N1hsc3FOcTAwZVRK?=
 =?utf-8?B?L25BZ29QbGJZVHloaVhoN2ZOZjMrTDlieWhlbVRDTExIMEd0dk1WaUloVDBr?=
 =?utf-8?B?cW1kclJZbXlXaVk0dmRKR2ozNEFTNWRYNktBdHRRaDhGUVhlRFU0MUhZR2Zr?=
 =?utf-8?B?Ky8xOEc1V05oaWpvb1o2cWZQUW12bUN6STBLMTh0MGRDaklZUE9ZVkhDNXBH?=
 =?utf-8?B?RUtxeUVHaGZma2lXMFBVOFcyWFhhdG50YkFFOTVuVTdUY2Eya1hiSGY0SkhQ?=
 =?utf-8?B?K1dDTFdqQURHS01qZ1pFaWljb0JzVVZHdlBseFYvRVB5bkIvdENwenhmOWJy?=
 =?utf-8?B?NDBMLzNEUHZRSEhsalhGWU53OWJUWklSVHBETWJKWU50NEZNM05qYlBHWlha?=
 =?utf-8?B?OXVyb094amRwbzZ3NDczV3cxRlN3SUxvcFg1UW9FbkNZUVBQVG90NWw4SHhP?=
 =?utf-8?B?bmwzVndIWTlGdTl1VUZuQ2Y0ZmpXTE9rVU1uLzBuYUlBSDNWYVNyODlWOHgy?=
 =?utf-8?B?TVp0R2xIZytLY2J0Um5zWW51OWUzR2FrSGlNcVllUUZYbHh6YmdST29RU0pW?=
 =?utf-8?B?bkJxSlFBR3JPVXF0ZlQ0a21jTno1YlR3SGpaQ2toYjd0WGZNSG1hTjkyNzJI?=
 =?utf-8?B?cUsxcWl5bStwSk1jQi82NkJ5MnIvc2NkY3FjaldYU3R6bkhFRUdqMWo1NFBz?=
 =?utf-8?B?WUQyMU1TL0ZxcVF4cjhiR1JlR29YYWRVRXVGYWoxVTdLdURXZ0xTYnhMM3Jn?=
 =?utf-8?B?b0hDRm5JZzQrU29aNHdML2RvVjNjazQ5b0xKZ0QrTlBGeWx3RDd2VFVUQnF5?=
 =?utf-8?B?NmNpYmZnR0FtSmlNT3NaMHA3SlRxMlJBd1VGWitHc00zYm53UDZmUTR1TjhU?=
 =?utf-8?B?RHFVRE5yajlxeWE3MlRtbUNCaGd1MHdhUDI1eU83dG9kNmdWVkIwNlEzNzUw?=
 =?utf-8?B?UjZybWdSUTViRm1ZTTBMOWFTVkp1VHBMVUF5VEx4NDJ4SjFhRUxnZTdaVjR2?=
 =?utf-8?B?MFFUQ0VRQXpmdXVTVlJCdzBvSUtSRm5zY0pKam5mZGlRNDEvSFVJUjJWcHh2?=
 =?utf-8?B?aHhZb2NsRkNBcEpUdFlnaEZZdE0xRWhiRHYvTVF4TFJMWUJubEZ1V1Zyay9z?=
 =?utf-8?B?ajJtMyt4dVRaWERWaGM1Q1lHd0k5SkZIb25WbUxoc0V5WThCRE84eWtUQVd3?=
 =?utf-8?B?YUlhT0lqanY4N1ZQZ05Qc1JMQ2NDUitzUGtmNS9ZTG9WUVlCSWt4MlVod1RT?=
 =?utf-8?B?TnRqajRFMldqc1c5cGt1TkgyQmZERG9TNU10YzhZbEozRWI4V25ydWFDOXVU?=
 =?utf-8?B?ditSTzZ1c1p0cTduekpkTlM2L0RPZVRaUFl1bi9keWp1UDcwMnRIRGljNUdz?=
 =?utf-8?B?ZjFJYlhwcWJlaHUzUU5JL0hkYk9ZczkrWjJ6eFFsaDZRbDBKaStiNFBBWWh2?=
 =?utf-8?Q?odfro8CSeBJV4Lxhf1IetqMcTObmeg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNiM1F6NUczVk1uaFc3d1hBUFU3azVVRERNWG1YVXpOMWNvQVB6U0ZKRXRn?=
 =?utf-8?B?Rk9YbjVFeER4ZlVnOTI1bVBjWnZKRzJNdWViL1I1TXh3dzlnOXZqcWtmVEZp?=
 =?utf-8?B?UFV0Yi9wdkZ6dEtJR3ZOWjlObktUM2k5Uk9pYVRPRWdsc3dOaVR6bzNNVkxX?=
 =?utf-8?B?L3ltVkdtdHdtd3J5cDRDNzBOT0g1b1NlMmNIaXBGbkoyaDcyRnFwYWV5ZVRK?=
 =?utf-8?B?OFVTWXhrNmc3cHpyODNFa1dPc1hXNDdNSE53NzFNVTVPbG01eU1ocDBIb2Zu?=
 =?utf-8?B?anA5NDlBTVpsZ0FZNVFEc2tidmdFME5GbVE2TXpYdjkzbWNGQzQ5VGRtbEdr?=
 =?utf-8?B?QklkRkRqMk03emxiaWRMQUlqZ01KaXQyUFhkTHZ3RE15NENpSjJXcWpFZXo1?=
 =?utf-8?B?MytjVFNyNEFRNzZ3Mk9ISTVNUVA0dVlsTkVwRnBvd3JYQkhzVHVVUDJIQmJR?=
 =?utf-8?B?WFFhc0JBQkQ3ek5yZ3J1RmExdGZSS3QrNXl1Tm0wQnc2R2lIMXpMUENUa2NM?=
 =?utf-8?B?bDM2eWV0SElUS0UzYW1hTk1jV25acTNrNE1OR1UxUGpXc2d2THNZU2xSaEJ3?=
 =?utf-8?B?YU1EcG5GdDBEeTNQcmJCeDBSQ0ZMUlJTOTZRd1BURnMrZnVzMFQxTExhMGhC?=
 =?utf-8?B?elNYZnlMdFRubzdldFVWN0VBcGN3cDY5UW9sdzZZT24xeGRlYjhsK2V6RTNY?=
 =?utf-8?B?d25QNXY0a2kvUTViWnFCK2dhQTNIVlF1dHp6K3VPelk1a044anM5MkVBdVFY?=
 =?utf-8?B?UjZ2eXZLTGJORE5aMmV5L3AyekhLckxlK2FaSnJvb3ErOHpBUTFYVWw1d0dY?=
 =?utf-8?B?V0p4VTJhd1pLMElBVitmMDNVbmpZK0hvd0kyeXk5R3Y5OWwwQ3pTak9YL2Q2?=
 =?utf-8?B?TVZqdmU4SUlTc3hVZ2RnNFZFSTFXRUU2OGFSckZHTytSVHp0Y1VxdHNla0tv?=
 =?utf-8?B?VCtsZjlhTDVReVJZQXJXbVdwSGJIc0o5d2hVejNYTEFjMDV4MXV2N05yUlFZ?=
 =?utf-8?B?Yy9FK2MzMzh1eDl3SjdMdlJzbUJzM0VUQ1BMTWFDZ2dsb2YzNk9GYzlYS1JO?=
 =?utf-8?B?WGJwWlRRQ3JFZmVZVXBPQVJteW5OS001TjlUcSsxMVVNQzYrN2xXTG1taDdQ?=
 =?utf-8?B?S2lRUVJVM2FCVmtucmFxQjRKNHdJUG5uTncyek50SUU5TlRaS1lKdm5qV1Aw?=
 =?utf-8?B?RTFmdjlvenl4WjRoWGJ1SXl1NS92R0lza05nYisyM3NwMGUwcHd5RVd2cWNv?=
 =?utf-8?B?Z1VhZFo2TWN3Y3RaRWxRaUlnQ0FjYjlTSmdRV3IzQmNoMEljQ2s3QjlDcDFx?=
 =?utf-8?B?VG9JNFRzVUhBWEJ4L1AwNGlIR1ZYM1RrTzFFOEw2ZlpUbi9vcVdvNjZVdWVW?=
 =?utf-8?B?cjVzVzFGclpQQ0p1K1BsajBKYTV5dm9wbG9YUmtHN1dIeXNWVE5KRDNjalZP?=
 =?utf-8?B?S2RHK05NSU9ETGF5djlHeUpQQzhxK3JEdXZXYWFUSjdjUkpJU0V6M0hhdjBV?=
 =?utf-8?B?SW0yQWRUU2FQY1JnaEI0cnN4VTVyV1dXdStGSmUyNkpETWYxUnc5bElJSXpE?=
 =?utf-8?B?OVlvUytFaVRkWjVYblJQVWk1bmRtME1YRHltUzQ4SXhzalR5R0Z4V0EzV1R5?=
 =?utf-8?B?My95UVBUQnIyY2kxVzdkcnErR3hpUjVsQjVHYjlUeEJNYkIxdWpHZXpzanZF?=
 =?utf-8?B?WUtBS0dYQW5kU3Y5Z3lQcWdPejRrRlorcWRDb0FTcnk2eFRGc25uQURSTXFo?=
 =?utf-8?B?dDBTUkRpY3ZiZE4yOVRhU1NEZ3dkRDVhV1lQUlcrY0pkZjE0ZzJ6cWlkd2Q3?=
 =?utf-8?B?Y3YvOGthZmxheGsyQzg4VldiUllRczNIV1M5VjlueUxTMGkzVzg5dEhJVnNF?=
 =?utf-8?B?TmtybUwrOGN6VEQ4OVJkSURDZ1hFS0RnV01HNytpWWdjNVRIQ1RZUnRIQ2Ro?=
 =?utf-8?B?UXhoeTNRL1VxcW9zNmQ4cXp2YVhJRTlMekhKbGdvSjU1cFNjRk9wbWhKcVBB?=
 =?utf-8?B?QkV6MXE1N1NSSUExREd2MTh0SFc0YTczTTg0SmZYbUJuc2NTMzd2V2IvS0Jh?=
 =?utf-8?B?VzZ0cGI4S3UxWGNaK3JsSzhqWi85dkVRNG1NcERKb2l0bkZrRHNRTDJPeDVP?=
 =?utf-8?Q?4DAUV+lidwFiq409dKKBK41Qk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabb6e21-ce7e-4133-0a96-08ddfb7da90a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 15:18:49.1609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnO7x/CF58f0b2GgH5dk563hXFLtG3x6ZBAaFWQEgMPMhGw2GoTJ1jCl0NfJEWck/LwGmY94NLF7yYrd90wDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB11254
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:56 +0200
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 01 Sep 2025 16:00:46 +0100, Andrew Goodbody wrote:
> In regulator_list_autoset there is a test for ret being non-zero and
> error being zero but it uses the binary '&' instead of the logical '&&'
> which could well lead to unexpected results. Correct this to use the
> logical '&&' instead.
> 
> This issue found by Smatch.
> 
> [...]

Applied, thanks!

[1/1] power: regulator: Fix incorrect use of binary and
      commit: 6c98e6014b3a36933860d02cb757565ec2fc80a4

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
