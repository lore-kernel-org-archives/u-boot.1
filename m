Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99680606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RLygQMMb;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hGDhpdju
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEAB980CA6;
	Wed, 25 Nov 2026 21:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AU5-AMTN-9Um; Wed, 25 Nov 2026 21:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21E3A80BD6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795642530;
	b=hXP6C92eLIAbJGBqAzfdLMt5+b9CJmT/g8UVsrkXZHoi/eprpjF6x8MXmL+XpUiGsVLe
	 K7oxekOjGDWDe1v7VPp/QPRwWGiO2OMe5By39Rb7KYHA2GU0iGSnSOnNcddVdKivsN6Cs
	 +bokTU2WOA5imy0HlxtxhZVfkWtnX8sV6aBEH24H979/NEHJ/ePhWXAKIr10e8cxrq8jJ
	 CHD0DaQrLxkHApRE0EXRlUWsf92dBBcqC7rjGsv0qSy17mpu0sU5844bmNAnTzMMBMLSE
	 SacvZsI9r2jtjyCvJ1n1MVoOmqyaXfGYLkMibubT4x47q0SAwtvool76l59Sj1ZTv8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795642530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9/L4vz6VYn0sRh3pDkwqeXIbQgbJyYdRNgRQKH+LT8U=;
	b=b7dhstfnDHB3NgKvScz7UiRYNlSui0JsdYWOf7mryzo85hfpv14Jf/LeSvBtmm9/jXmS
	 4lHUgsqFg3Sgm2X2Nrr5/WHpIyVPs3aXv25b2VIt6ARxKKHyeLYbZclLfJpGzRAr0Lfbp
	 3NCW37JT/9Pzr8Ssyl7WqIYDQ340EBOxPesBRSIy5zfFKU4RcZ86YGowI1P041rg1KI1E
	 xUtIi+SY4tvMRtTPzIgG8/KBTkeR6Q8auILhdmlLjPx7NL+EXja502U7TR5g49w1iC4Uo
	 u17L5wnOf3SHBMn1HoHR6kQCsggmrbFrReJFJYAXVGkppQBZrOmutL5fb55OK1QAAQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hGDhpdju;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795642530;
	bh=9/L4vz6VYn0sRh3pDkwqeXIbQgbJyYdRNgRQKH+LT8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLygQMMbw0E36DLLF9O88mYnQGvARcTAvZR8A43Lg6+PfcYXgEcBqPcJdzQdMySTL
	 mdPFhGxJll7yegUyjdkToktRAN4hDZk1V219NDBItEhzw9XW66ZPcDimIlbqiFjB2T
	 0ZjRtXi8ib3XyFApnOpRSLMMc1O+AigCuNHptrvPAlfHG0osKyddTncMzdBCrGPNIj
	 J/Xf28M9m7yztTP0z6X9bA5uYI3FKiAxqDAXqlwX7o8mb5IHbsRHvSjGxHtidfX0XH
	 FMZSnLj0XVE2qDA4k0Tuofx4Xm8tT/5gTElIO8BJL15KvEVRi/r4UUrpaXlE7zwzlE
	 xSq2zTdTRaB7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21E3A80BD6;
	Wed, 25 Nov 2026 21:35:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 986D932D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9545580F66
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC3UeAr6XBwJ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AB5880C94
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hGDhpdju
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AB5880C94
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/L4vz6VYn0sRh3pDkwqeXIbQgbJyYdRNgRQKH+LT8U=;
 b=hGDhpdjugCklV4/JWXKMsexJYUgpMnuSidords6xorhe40emyP5GcMfRkNwvAFSfXAhcCGSz/gUdHbAUQ8wuxU5fsG+iu/AQN/h0orc5zwNl8NM6QARUn3PmGPP+ds+JUaleFY1OYZ7Wudq7IhAWKtjK4UrqXkFq2JQZHSMN7V0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 18:19:51 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 18:19:50 +0000
Message-ID: <661b8e78-e4d7-4c1e-a514-cc3ee6172de3@cherry.de>
Date: Wed, 25 Nov 2026 19:19:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/23] spl: fit: Look up the compression without the
 table in a tiny FIT
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-5-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF0000020C.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8da) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: a68f5cdd-2b78-47f2-2bd2-08df4b20b1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|56012099006|11063799006|5023799004|261022075727099003|261028144727099003|261022115727099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|18002099003|4143699003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: GZpKEygn1zhww9FnHWllvfRZNpuYMmzWuo90wJY341RZAmhDepnEEWoL+y9Zu/ipLqVDsaVtE51AldTgN4PGgBOoORkKZhMJR0nuKgcbPoZstuaiRq6r4VOzCS8lxIFGPVTB7uKCyOhFiOurkO6E1jcNN6Skb/r4QyVDg7i473BK1Ln6xuCtEDjBEbFmZyJhHOnwogTM+kWAmJqb9oli+9KW+lmaNDWUPaetvFtPhC4QJY2b5H3oPfduiBoVVNcQWWdW8lW/MdmDPsM+ZEDBJmyFFvOnMTgiHJH13TVImao5Na+IfKpjuc2qsn6ytfuRO5jif8J72B1DAVjtTWVXaUCJzXO1Vjao7VyleSd8NZ76Cw/r571S+rbV84+hIDHAzpLHvkiScG7CJACFZkUuggUTEgqQTRzRa4SlBQeEbYU6d81m0tpXqsy2x+WgSjsdUwrhb9aN9GtEZs6EsbP5s1Jc7FTF03H7EScCCzcBRhvYzSm+VTkhGa/D9axiKB2uyTxjqrWX34/wmav45JUEUZxjcxchCw/FWcCFjJ3Tm1wt4uymF3QKWUZRGMLt49W+votsInLZVqJLpAQ9LZeNkwkSoO8j2uF8HVMEqGvFplx6L3n0FZryL+TJP4PpZGK4lxtTwsU96oA74HAgB5/g4G9IVVS4m8zuYboQK/UbSVn0pxKLIkRAoa0AafGSPvMpZfXp5aDe12AUOwBmf5XoF7Us7EnYMVUjIL1/K4TV1k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(56012099006)(11063799006)(5023799004)(261022075727099003)(261028144727099003)(261022115727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(4143699003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGIvMnBON1JvWkZJdEtxeHlEN3JSeVgwZUZHdkl5UThTcVpXd1FPVXVRNDhi?=
 =?utf-8?B?OGVBd1lKeXZjZXdnZDBMM1RsVDhRM0dhSmlaY0c3QlNMSm4zSWIxSzdHQThs?=
 =?utf-8?B?TU9peUdRV3JGdDBjaytWYVRENUR0Q2hPcWtrQW16L1ZWUHlyVVgyM1ZYV29p?=
 =?utf-8?B?ZFMrQmphZ1B0RVliVk1EYUVoZ2QyWXRSUTcvTHp3K04yR0dRSkV0VS8raU0w?=
 =?utf-8?B?RWs1cXNyb2NWWVFwbi8yZjNRVkxZSzYxM2dGV2czTTZ5eTdGRVdZUEVYeVky?=
 =?utf-8?B?amR6YzhQY2Z1cVZmNWpvalNjQ0IraFRsL2lkc1FzUDRhYm1tdWVDZHV3S1g1?=
 =?utf-8?B?bzdJYnJHcCt0Q0xLdSs3cElpcjJ4MkZRZ2dwTjZlSEt6SEczZTFCVi9uTm1z?=
 =?utf-8?B?SVRGbVZzeHJqdnYvWnpZanNqa3VJUStOR1BZZElReWc3b01aQ2trSFl2RlU0?=
 =?utf-8?B?eGsrOCtJRmdXblAzZHZ1V2kvNzlvcjFHOTZUR1hTb1l6YmI2VjFoQ01hZEpU?=
 =?utf-8?B?TWkxUDhJRHRDczk2cHFrWmZFR1M5Z1BmTzdUVFJVeWdjQi9KUGhEUmozb3k2?=
 =?utf-8?B?Y0t3RTA1Ty8zMm04MlNBN2crSkg2SnhSaEN5U1ZieWdwRFpnTnF2c21VazYv?=
 =?utf-8?B?NlNWK0RiZWRFbkw4dmdjZTVIaFUwL1JaeFFHdldEZm1OMTViakFnVUprYXJH?=
 =?utf-8?B?ODhyUW5Vek1ySGRRMmRaSXphbzRReWdzb2RSa0gyY1ZkeE51OWY1RE51VkZ1?=
 =?utf-8?B?RjdRVWFqOTdybkY5QWVCVWExUy9uSDNiME0wdnZaRHhhY0hxOGdHcEpkMmZB?=
 =?utf-8?B?WnBGRk8zZ0kyT0FmNkVMNUR2MVFWZVhIdmdDV2N0bm1qL1phOVVZSWt5WUkw?=
 =?utf-8?B?aEZJU1VpdDN0NWptaUw0Ti9VZFNLVEYwcGFNbTVTa3JKbTJpdHR6bkc4N1dt?=
 =?utf-8?B?ejNnY2hzWXBTZG13cU5xTWhheEhvc2s1VDkyTlMwTkMya3pTU0JsdlFyZFYr?=
 =?utf-8?B?R3hwUnhsTDdkaGJOM3JxcTR3WmtESllLbHdZN28yT1hZaWF5NGFuZHQvWVlq?=
 =?utf-8?B?RjlUQ25LeS9sTUZ6OS9qTk1UTEQwMGx2N1J2Ymc5eDJBdTdZZUJDajRyeUFS?=
 =?utf-8?B?RmVmRXc5eHlpM2tRUmZSZVNmMmZpbTkwZlNBN24xU2UveWRxa2tING5Nbk9v?=
 =?utf-8?B?eTlCb2JWR0lRNHZlRENCL3oxNEFnNS9LbzBkMWpPSFovQVo0WjVmY3l1TnIr?=
 =?utf-8?B?ekdqdzcybUN5cElLclFRQVBuT2VaaFhZMDJwbWhGSzcrdUZ1YmVmaWNJN2NB?=
 =?utf-8?B?R2tQcWRGM1FMVkRqalhUM3pDbExmVm9sNzk2M2toeG8veWl3cHJHWG40ZjdP?=
 =?utf-8?B?TlREQ3kvR05DeUttd3Z4dUMxSHdiUjlLL1JyUjlxbCtXREtEeWJtMG9La2Nz?=
 =?utf-8?B?MXFhTGRyaWxoOXF0eU1hN2ZOVXFCcjYybGs0REx3MFpMUDd3RjgwRXJ0VUlE?=
 =?utf-8?B?RzZPZ2FYWnhPR2tYNDJwbmJhbHMzd0ZJWnFoSGlyMlhiSlFKd0xwMDFXU1p2?=
 =?utf-8?B?amxyYXR4alZTSGU5NGpJeEQrRXFqMkF2OTdxSGVvbklHL1JmVUl4RE9zbDdS?=
 =?utf-8?B?V0ZxZUVkN0xmNEdVSFN6L1R5VWU5aXdEQ2JtWlJPUDJPVzh5M0tQVnNYTSs1?=
 =?utf-8?B?djJJTUw4Wkw5Z3hmVnZmWXpPYkJMUFBHSkRxUHBOd2MxdGVIemZhbmZOV3E0?=
 =?utf-8?B?VnY2elpuZFVKZ3JxL1E2a1JSREZsZjJpQmNjVFJGaGJ2L24wNkkzS2lKUUMr?=
 =?utf-8?B?S2VEZ0FmZklrL2pnWlozQTg3NFhXckRvZ3cvVzNFN1FLS3ZJby94L2dFQkxO?=
 =?utf-8?B?WlY3R2cyZHEwWlUrSjY3NVB6UkRETll5ZXRRZGEzVlFHbDk2Y2RrL2w3R2RI?=
 =?utf-8?B?YnFLcXFwTmxMN29QaWF2K0xaVnRzaFRtS3UzemVVMmVOaE4wVzB1ZUtBUzV6?=
 =?utf-8?B?Z2tSNG1LeVlrUVRDamd2UmFzUnFLSzFNdEwybFI4Vzl4TW1OSnpIcHBaVE9M?=
 =?utf-8?B?OWNVTGdlc2Fab21aUyttNGo3YmJqN3RaMCtyd0QyWEUyT0wvak9NaUFhVVIv?=
 =?utf-8?B?dFZia1R3TlI4TkFqeXoxaGdGLzV1VnBTTWRKbmFkelNuMTQxT1ZyN25iRnJm?=
 =?utf-8?B?MDVmZmNXR3I4Sjgvc2E0RTZlaGo5UkZKNGZyc2ZsMFZGZFcwVFBnc21yd1dw?=
 =?utf-8?B?aXVPaU03cDBncDR5cUhQbWNiRXI4Q3lqbjBpOGszZGhUNC8vK04xY2hwWlh5?=
 =?utf-8?B?MDFpdWl3RFVDNGhGWFpScEFZS0ZrajI1MFFmbDRBbHVFYWZ4dldzQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a68f5cdd-2b78-47f2-2bd2-08df4b20b1e9
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:19:50.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc6fEAmAcgF7O+hgXEr+Cfup84oIgfjKZEi81R2f60qfo3CKAnU9w2QcysM99iZoddwCekYQ/YBoQiC1OMt6rlBgXPTV8ug37WC6aUvliPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
X-Mailman-Approved-At: Wed, 25 Nov 2026 21:35:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> SPL_FIT_IMAGE_TINY keeps image.c's tables out of SPL: the OS of an image
> is looked up by comparing its name against "u-boot" rather than through
> uimage_os[]. Reading an image's compression, which SPL is about to do for
> any decompressor it has, still goes through uimage_comp[] though, and
> brings back the strings of every table in image.c: around 2.5KB on
> tqma6ulx_mba6ul_mmc, which has SPL_LZO for its multi-DTB FIT.
> 
> Do the same for the compression, and only tell apart the algorithms the
> phase can decompress, by name.
> 
> Return the compression rather than fill it in, and count an image without
> the property as uncompressed, as SPL always has, so that the caller needs
> no default to fall back on.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/spl/spl_fit.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index bbf156f204b6..a07c9a86d7d5 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -230,6 +230,47 @@ static void fit_fill_image_info(const void *fit, int node,
>   		image_info->entry_point = FDT_ERROR;
>   }
>   
> +/**
> + * spl_fit_image_get_comp() - Get the compression of an image in a FIT
> + * @fit:	FIT to read from
> + * @noffset:	Offset of the image node
> + *
> + * With SPL_FIT_IMAGE_TINY, only tell apart the algorithms this phase can
> + * decompress, as spl_fit_image_get_os() does for OS types. This saves the
> + * table of every algorithm, and the strings which come with it.
> + *
> + * Return: the compression (IH_COMP_...). An image without the property
> + * counts as uncompressed, as it always has in SPL. A name not recognised
> + * gives a value which image_decomp() rejects.
> + */
> +static u8 spl_fit_image_get_comp(const void *fit, int noffset)
> +{
> +	const char *name;
> +	u8 comp;
> +
> +	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {

question (non-blocking): what about SPL_BOOT_OS?

Seems like spl_fit_image_get_os() also has a check on that. I know the 
answer will be "I'm falcon booting and I don't want to bring in the big 
table", but then what's the rule for including or not a given table 
since we'll now have spl_fit_image_get_os() which includes it, but not 
spl_fit_image_get_comp().

> +		if (fit_image_get_comp(fit, noffset, &comp))
> +			return IH_COMP_NONE;
> +		return comp;
> +	}
> +
> +	name = fdt_getprop(fit, noffset, FIT_COMP_PROP, NULL);
> +	if (!name || !strcmp(name, "none"))
> +		return IH_COMP_NONE;
> +	if (CONFIG_IS_ENABLED(GZIP) && !strcmp(name, "gzip"))
> +		return IH_COMP_GZIP;
> +	if (CONFIG_IS_ENABLED(LZ4) && !strcmp(name, "lz4"))
> +		return IH_COMP_LZ4;
> +	if (CONFIG_IS_ENABLED(LZMA) && !strcmp(name, "lzma"))
> +		return IH_COMP_LZMA;
> +	if (CONFIG_IS_ENABLED(LZO) && !strcmp(name, "lzo"))
> +		return IH_COMP_LZO;
> +	if (CONFIG_IS_ENABLED(ZSTD) && !strcmp(name, "zstd"))
> +		return IH_COMP_ZSTD;
> +
> +	return -1;
> +}
> +

thought: is this really going the right direction

I cannot help but think this is unnecessarily duplicating code. I'm 
**sure** we will forget to update this part once we add support for a 
new compression algorithm.

It seems we want to bypass all of boot/image.c that is using one of the 
arrays defined at the top of the file, maybe the answer is simply that 
this is ill-suited for anything but the proper phase. Or maybe the 
format is simply non-optimal.

I'm wondering if we couldn't split each array into two separate arrays, 
one for the long name, one for the short name. Then, in xPL, just don't 
use anything requesting the long name and the compiler hopefully 
compiles out the unused array with the long name.

What do you think?

Cheers,
Quentin
