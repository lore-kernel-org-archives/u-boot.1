Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB07D39000
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 18:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2713F803F5;
	Wed, 14 Jan 2026 19:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TMsIflEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9980B808AF; Wed, 14 Jan 2026 19:05:06 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BAB80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrJAK0dn3/O/8GaYNXBZp5FI2PfOptPaVjyx9mSR4SEV0ykfLYbEX01sQJg7eVXkQCtvoEmt44RwtsoS8GrAQm7oIlipiCLjHccauZug9rjqpCg6hx/NWLUWQs1QtwAxGaog9BHgMLioymtqWTV20/LidEGNe8js1RPwC4KHRbV/QoJhby5LBydA0l5nkpyKs0I2CpxgreX2KPoDubdmJF8mF2wjkmMOQfNWsgwEPTfbUHp5Ipn1sfmogiLIcX0V2jAdS/HIRgZOfsgpX3MAKP5Ntxib1cilLQdIk8y/7/nNS5+wYnPMB9eKCS3caBv35dpyvp3MXnGfIeuwF5Oztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPi7VgNtgWKduUV3obUGmx0mUsIhPskoyBIk5BczD9A=;
 b=MhrcR25G6dkshBHdTuMoj24HZAroJ+nvvl4MQqO3XoyRQGVJqO+AfiZSMJB1jAxRmqRZIc2o3uHroFAQ9Yt4qZ4PfipenIzoxVTERHL/dLvrEcSB4JgTALK/amV7nUTCfGHptofv/c9OjEFYEfgJ2vXLDVfukICAiI315RXQWIV42yYLxHg9ChLymMpQFeTMIghJoexfv/asuL71OKSdTvaniK/S9tp9anCIw5I8K/wrDpDb4/vInEz0SSwPAPQduSkuG1IVBD/gH4NQOz9hfXMDJNUOFcXDG2A0YY4AJd4ykiDQ1WiGVUH0uNxzIT4dxTaUCXxzilwat+0aQL0YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPi7VgNtgWKduUV3obUGmx0mUsIhPskoyBIk5BczD9A=;
 b=TMsIflEdyBLnOy9TaA2ejKqcEy+55V/M498ejnEFKmOxIK4w33s8EqauZAE13bGJ4GZke9IZE9EngltubC4Q+0ShF6Pc08jSqylULGkMcjBpHxWTOHqy/qwI3iHp+8zUhH6cLNYAwVcNEI/7ehPEwVoJNL7YuqN9RCPpOzOpapQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11829.eurprd04.prod.outlook.com (2603:10a6:102:523::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:05:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 18:05:01 +0000
Message-ID: <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
Date: Wed, 14 Jan 2026 19:04:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: spl: Add support for booting from UFS
To: Alexey Charkov <alchark@gmail.com>, u-boot@lists.denx.de,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin
 <xuhui.lin@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Dhruva Gole <d-gole@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, Joseph Chen <chenjh@rock-chips.com>
References: <20260108-rk3576-ufs-v4-0-e8e67649f3f8@gmail.com>
 <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-rk3576-ufs-v4-3-e8e67649f3f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11829:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fcfbee-f340-4bdb-e5b5-08de53976fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFlsQjA2S3BXYW9Qb1o4aWxZOEpGSHpnd3kvaEk0Tm5pWXc2dWZhRWRoMFla?=
 =?utf-8?B?MUxNZnIzaEtlYTE0M201ZGJtMVlrWi9IY0ZCcXErVTh5VTFuVm1oMnhnS2Rk?=
 =?utf-8?B?RlMrZnd5Y05DaTRXcklHZk5hdEJScEpqRzZUTFp0NWtKQ2JtbHBwTUxoRFo4?=
 =?utf-8?B?bEFuL3B1bUhvTkVKayt5TUlPTzFmWFZYVmVsSlRjM0xxeTRQQUdzcW5BL25v?=
 =?utf-8?B?M2VybWFkTDlpSm9YSDNRS1VFdC95RjdPWTg5eVNydWNtaURKRm04cTNwNi9n?=
 =?utf-8?B?YUJEczRmRnlERTFmQUNCR0dhaHVWWkV2WmRoTWFvRVVJUysrZVF1S3R5N0pZ?=
 =?utf-8?B?QmcwbE9MUlZYUi9Ob3h6S3ZaY2pweWVPN1luOTRiaDR3YWJnUTlmZ2h5ZGVK?=
 =?utf-8?B?RXpOOHRCeFpTNFg1VXpYbGQvRXN0VFVMUkc5VFF0M2hIVzUySVB0Z0c3N1lv?=
 =?utf-8?B?OUw2SUhEMFFaamRLV2FUZTl6OFIvYU9ySGdsa3NmcnlKb1hwWFI1aVZHVjhH?=
 =?utf-8?B?SHlWT2xiYUxIRE9RNXJSSWJpL0ZNaGh5L2lEbDM3T3g2eWtiZThYRldtdHRE?=
 =?utf-8?B?Sk5RT2dMZzBlR3hVd1F3dy9LeDNWTEtGZWxVMUI0ZXhVRndVS3hPSWJTMWZa?=
 =?utf-8?B?UzJZS1ViZHJGdXVWYWUwZ0JxN3lMTkhCUU9KY0haQ0Znd0JYeEFQb3Vnejlr?=
 =?utf-8?B?VW4zdE9vRDRwaitnTlBWWjdSbEQzMHBzeDFFcmswUUdERC9NT2swWDlqWTdG?=
 =?utf-8?B?N0NhUDZma01taHp6VWxYNU9QZjNaKzI3R1RFZlNDZmxsSUpDSkczaGs5MXFv?=
 =?utf-8?B?SlBoU3cwQ2M3U2hXemg3RzM5STlTcVBLOVJyckp2N2RZa2NzS24vaU5zRkY4?=
 =?utf-8?B?Y09BL3VWeStoYWlhZU5sVkw2VGgxN1RKQzhzeU05cWk3a2VRbjl2ZDJSU3Nu?=
 =?utf-8?B?RjZNZmZTWUp3YlU4WjgrSE1WSnNQbjhRNEQxLzJJck1wYVB3WkJkVzgyNnFu?=
 =?utf-8?B?YlpNTUNqcFBmMUlqQnVWZnMxRTV1SGtFVEN4cTBZNUt0WUpiK3dpSkVuYWt1?=
 =?utf-8?B?ZXRMOTZQVHBUZ05teFVCRFQydTE0VUJ2UWZnVjhKbmJrWUZidktsNWhiVHI4?=
 =?utf-8?B?V1ZGd25WVzdWWnQ2K0tCMnlrRTI2NWxSdWJUMXRZYStmOURhVE1hQVQyRXRa?=
 =?utf-8?B?dXRXeGtGdTMxS0RnaUNxR0trZFlEYXplUUZYM1NPVS9OV2xDdTMyZ1dPWnVa?=
 =?utf-8?B?LzZzbHN5cVd6Q2RiNkduWnMwUjZpa0svNzVPSVBWUzlnV3hBUHc2YmNIUmlK?=
 =?utf-8?B?NUV0ZWQzRnZZZCtBWWNtZkdWRDNWWWhHT3ozMHlITFdxWDVRdnVtNUl0U29w?=
 =?utf-8?B?NmVOMWplS2VHMzhSdTRrVjBVSTdFS3p4Y1lSNmZSUUNlUnRwKzNnWFhyakxu?=
 =?utf-8?B?dGQ5Q2dqeU1PR3RRZUlIUXVGRVpyNUppQUo1NWpjTUU3QWZoaGladVppVU1P?=
 =?utf-8?B?NXZQa1o4U21BenpoTDlyL2hBbFpTc1h0VUs4aFJTTEVIcGZWQ1NsN3laY0N6?=
 =?utf-8?B?bkw5WmVNUVRZekcrVXZjR2hOaVppSHM4OUR6VG1tL1JqazdKUEVXK3E2NlJi?=
 =?utf-8?B?R1J1bSt5cDRGT3hVWTdsTHA2aFp4cTNad1hGRWZyaDJ0OHZ4MFFjVm1TelZw?=
 =?utf-8?B?bHZDMnBkN0xVM3U5Sm5tTGhoMldtZFBmQytBYmNGRkNLM3I2WFZjM1d1K2k5?=
 =?utf-8?B?V0JTTDJTMnpKcWNXRWpDNDJGK0dDOXlaRkxKK0ljeGZBbmdCYlBZQkZOS2pi?=
 =?utf-8?B?R3Rta3BIaFk4em03TGw4ZVMrSU9TdWtsWEVEYmdTQ3NrUUZvc2FmbU9PQWZP?=
 =?utf-8?B?QTI0YWFwRzFzalZERzNZTUhiYnhvK211cVgveGoxTnBpZWowdzd4ZlRid205?=
 =?utf-8?B?NWtURjlLMTM2U24wdGRWOEdaN3NaaDQ2SXhWMjBCUlVlQXBaVE5zNFplN2xT?=
 =?utf-8?B?a0xKOWZKSzQ1R1I4czdwWUNhOWhlNmNIUTlIa3JFanlpL1hwM1l3R1Q3RjJJ?=
 =?utf-8?B?VTJkVW5vUTY0ak9oQ1MrQWJmRjN2OVlUR0R5Vm9tRmFkMVRlSDgveXdwWmJw?=
 =?utf-8?Q?c/mg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNqdWQ1Tnl1eVhyaU9GLzlkRjB1ZjlXV3VoTUlBVmZubnE5b2MwYng4ZWdv?=
 =?utf-8?B?VXh1VFlwSmlrUkZ5Y2IzRjR1Ym4xTUlXVVp6NFZ6Y2lBT0lUeVhRRUFhVG5N?=
 =?utf-8?B?RHRhcmRhTlVhQ29BNERiOXd3N0NDTjdaWU9HVFpHcDNoQnNrRVZRUUs0NEd5?=
 =?utf-8?B?SWY3WUpyeUhtZk1Bd081TnhWcXlwU0htbVZva01pRmpRZVBtME5BTnZTTmlv?=
 =?utf-8?B?YmlXYndRK1ZlNXBUTzVxUGNSNXlwTEZJL1BEbjJEbG8rYTFkWjNxY0JNK2dW?=
 =?utf-8?B?bU5SVy9xL2RnSzZvY1ZpZmF2bHJrcFNJMlQvT2ZBMlpUTHk0UVBlbjI3aXpU?=
 =?utf-8?B?N2JjSnhNM3V4L3J2anZwd3NGQXY3ZXVxQmlOM1RQVTdHajZzcm9jQW5PLzF5?=
 =?utf-8?B?YTZSTDQzc0tpYjhXd0JMVkZEMnJwYVhSWWVCWkNBRVZLQ0hraWoxUGVzZmVa?=
 =?utf-8?B?dGc0MWFWSnVQZDNDSG8yK25iek1VUmZnT0lFRkJTMWZOMkJ3WE9KL3Vzc2l3?=
 =?utf-8?B?R3NjTmNXVml0c1VHRVF2WTRXeFdZanRQUmFYdVF4cm03c1FtZnRDaW1IN3p4?=
 =?utf-8?B?V2Y5cmpQaE83SFRHc3RuY29tNklhbzRDL1BWK1F4SFkrYlBzd2tFWXlwUEtX?=
 =?utf-8?B?b1VCRmI2L3M0QVRyOTlxVEVPK2tYbVo5eXFQZTFTeUVmRFFoNUlKZFBVc01p?=
 =?utf-8?B?aHlwaEFtb1hVczF5RlBrSER1T2laR3V5WUxibHRtaGYyTXFzTGZaMmxOaUMx?=
 =?utf-8?B?V1RrUnJxbk8vS0pEUFEvNE56d0xYUVVWZmVWSGNzamNCYzgzaGRjbXNlSStJ?=
 =?utf-8?B?MXQ3YWVXZTBUenZhUEVEei91TzZHditCMDVnMXBBbzhYeXY0Ly9xOUxMNFdr?=
 =?utf-8?B?dGxYTEJ0TWx1YVZUTEZ1U3pqbm1VTjdiaU1JajZZd1FPTFB5M0p5OWxUMHl6?=
 =?utf-8?B?ZER4SXh2QVQ4VVRlVTlqRUloOXhqK3hENEFpUjFCcG5pK1NMRTd5bSs0RWJF?=
 =?utf-8?B?UE9ZcW9EemxuZXdacEE1bU1BcUdUU285SVJLazREQmJkRVMzRGlDN04wTjZl?=
 =?utf-8?B?SnJxQ1hGZWRoaGtNRHdtektEOCsyMTJBMTVGTkVHSmh3MXB6SDVOZmdZUUdh?=
 =?utf-8?B?eTQ2U2RqVGtkOFZuRU55ZjhiVDl6MzdRa3NnYVBWSVdDVGx4NjluYlZySmNT?=
 =?utf-8?B?NWdHSlVaS3Niby9ma2t4R3ZKOWxjK3U2Sm5FWFhFUWdhMGR1bjNwdVVjdmZt?=
 =?utf-8?B?UTFJMHVUdURBOUUyNzBUUEdHakNJZjVkd2RpQVYzUlozcHFrd3R1T3lIQi9q?=
 =?utf-8?B?QklQZlk3eldLQmtkVWV0R1NCWGcwUE5KZUxEbVMxVDYrdnFLejFSa2lwWHZj?=
 =?utf-8?B?WU53MVJMbHlabis2VnpEK084NzJQYkJpV2xFQVZWbm94M3FnU01wcFJkSmFi?=
 =?utf-8?B?bURkWEQ0dnFWTU4wTnd0b3V4L1BBbXJNK0ZhbktZaGxpbWFld1VxbjZHOXk1?=
 =?utf-8?B?cUczT2Vqb3N1bEliTnF2bjZRbXFhcFBMeVpVd0VDT2gvaHFTR1NQeHdySGpQ?=
 =?utf-8?B?aURscmpvcVlvbE9CdVRoZklCcVRwWU5YYzlZd3RXTlAzZlJSMm9ud210T0FV?=
 =?utf-8?B?cWdMYW9lRGZacVo0aVpRc0ZJRmtYd3pTOWJPMGlYR3hGSEtmdHhnZTd6U2tJ?=
 =?utf-8?B?TDE2VDl5Wjl5UTU3anNSNmN3RHdtZHpuVXdBNVdNMlRPeHBzd1JaMmZLWkJj?=
 =?utf-8?B?cFlNbTBOSWtKblk4elRPVTd3Vmx1dmdqSWJYa2lNaWhUYVVMTjlBNHRMMU5D?=
 =?utf-8?B?aGd0eENLRzZPYXp4TGNMODl3bmkyTEhoeWFKUDdaaEMvTGwyL1YvYStvWVB6?=
 =?utf-8?B?djFzSllqd2VsUFlUTzBVZ2tqZ0VTeHJJMzVjVisxTitlM1dlMWVrZjBzbnQw?=
 =?utf-8?B?Mm0xRHByZ0hOTTNUZTZYVTFPczZETExLZzVmam9qL2hyTkZpRUVGSDJXRHI0?=
 =?utf-8?B?enNxWklSdHhUNjBtUktuY3Jhb21vcGNVdGpLU3lWZ01GN3FIdkRFUFNkRFVE?=
 =?utf-8?B?aFJKOHREV1pvVEF6UE1HVTFwNUVPNFphcHlqV01TK2xGcUQyRFlhajhyb3pM?=
 =?utf-8?B?akZGUEhSUGx3N2hBdFNteDJjeUtqNmErK0FEZHZ3czZwa0IxQkV1b2Q5U21G?=
 =?utf-8?B?T3FTTFBvMHNZanlPTWRwbllKMGVXdkxjYmhpSG1JYmRPeUs1dDRVWkt4cTk4?=
 =?utf-8?B?a2tQMGt5RGJXc1h0UFhEb1FXME1xU0U2Unp6Vm92dzY4dzlncTRJUDEzRTFh?=
 =?utf-8?B?VzdERjZXeVJXQW11NWErNkdHYkZwZFJBd1dYYkNiT0tuRURvOGZoZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fcfbee-f340-4bdb-e5b5-08de53976fb3
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:05:01.3243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gE4HxevESAGVOy/t7VWmmCSTG6GqjfJi0Q9muTOiyJJYroVuVJbD1o5ox/Yh4umFck7lHxLiwZkgCvm7DP0L4QXxhKQb9iP0gcfNbHT36Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11829
X-Mailman-Approved-At: Wed, 14 Jan 2026 19:08:00 +0100
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

Hi Alexey,

On 1/8/26 6:50 PM, Alexey Charkov wrote:
> Add the required architecture-specific lookups to enable U-boot SPL to
> load images from UFS storage devices on Rockchip RK3576, which has a
> boot ROM capable of loading the SPL image from UFS.
> 
> This also requires the DM_RESET framework to be available in SPL, as
> the UFS driver uses it.

If it is a hard dependency, why is it not specified as such in the 
symbol directly instead of relying on imply's at the ARCH level? This 
will also be "painful" once a new Rockchip SoC has UFS support as we'll 
need to forget not to add those imply.

> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi              | 13 ++++++++++++-
>   arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
>   arch/arm/mach-rockchip/Kconfig               |  3 +++
>   arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
>   arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++++++++
>   drivers/reset/Kconfig                        |  9 +++++++++
>   drivers/reset/Makefile                       |  2 +-
>   7 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index dc3771b556a3..84d9f39fd407 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -12,7 +12,7 @@
>   	};
>   
>   	chosen {
> -		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci, &ufshc;
>   	};
>   
>   	dmc {
> @@ -81,6 +81,12 @@
>   	bootph-some-ram;
>   };
>   
> +&gpio4 {
> +	/* Used for resetting the UFS device during initialization */
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +

Is it always GPIO4 for the reset GPIO for UFS? Seems like something that 
should probably be put in a board -u-boot.dtsi instead?

>   &ioc_grf {
>   	bootph-all;
>   };
> @@ -176,6 +182,11 @@
>   	bootph-pre-ram;
>   };
>   
> +&ufshc {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &xin24m {
>   	bootph-all;
>   };
> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
> index b15938c021d6..f9ecb6858f04 100644
> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
> @@ -51,6 +51,7 @@ enum {
>   	BROM_BOOTSOURCE_SPINOR = 3,
>   	BROM_BOOTSOURCE_SPINAND = 4,
>   	BROM_BOOTSOURCE_SD = 5,
> +	BROM_BOOTSOURCE_UFS = 7,

Hopefully this will be the same value for all upcoming SoCs with UFS 
(and not used for something else :) ).

>   	BROM_BOOTSOURCE_I2C = 8,
>   	BROM_BOOTSOURCE_SPI = 9,
>   	BROM_BOOTSOURCE_USB = 10,
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 92bb4aa62f11..483a2f7c4ab2 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -436,6 +436,9 @@ config ROCKCHIP_RK3576
>   	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>   	imply SPL_CLK
>   	imply SPL_DM_SEQ_ALIAS
> +	imply SPL_DM_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
> +	imply SPL_DM_RESET if UFS_ROCKCHIP && SPL_UFS_SUPPORT
> +	imply SPL_GPIO if UFS_ROCKCHIP && SPL_UFS_SUPPORT
>   	imply SPL_FIT_SIGNATURE
>   	imply SPL_LOAD_FIT
>   	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a1e8a7572fa4..46cf60dc77c7 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -46,6 +46,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
>   	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
> +	[BROM_BOOTSOURCE_UFS] = "/soc/ufshc@2a2d0000",
>   };
>   
>   static struct mm_region rk3576_mem_map[] = {
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> index 6572dde29f65..d2dd5e10935f 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
>   	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
>   		return BOOT_DEVICE_SPI;
>   
> +	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
> +		return BOOT_DEVICE_UFS;
> +
>   	return -1;
>   }
>   
> @@ -231,6 +234,17 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
>   		return -ENODEV;
>   	}
>   
> +	if (boot_device == BOOT_DEVICE_UFS) {
> +		ret = uclass_find_device(UCLASS_UFS, 0, &dev);
> +		if (ret) {
> +			debug("%s: could not find device for UFS: %d\n",
> +			      __func__, ret);
> +			return ret;
> +		}
> +
> +		return ofnode_get_path(dev_ofnode(dev), buf, buflen);
> +	}
> +
>   #if CONFIG_IS_ENABLED(BLK)
>   	dev_num = (boot_device == BOOT_DEVICE_MMC1) ? 0 : 1;
>   
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 74c267dfc4e5..d35f3904e404 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,6 +99,15 @@ config RESET_ROCKCHIP
>   	  though is that some reset signals, like I2C or MISC reset multiple
>   	  devices.
>   
> +config SPL_RESET_ROCKCHIP
> +	bool "SPL reset controller driver for Rockchip SoCs"
> +	depends on SPL_DM_RESET && ARCH_ROCKCHIP && CLK
> +	default y
> +	help
> +	  Support for the reset controller on Rockchip SoCs in SPL. Select this
> +	  if you observe any reset-related warnings or errors when booting SPL,
> +	  such as when using UFS storage
> +

Separate patch for this please.

>   config RESET_HSDK
>   	bool "Synopsys HSDK Reset Driver"
>   	depends on DM_RESET && TARGET_HSDK
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index ee5b009d1341..dc7d3b610e6e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_RESET_BCM6345) += reset-bcm6345.o
>   obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>   obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
>   obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
> -obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o
> +obj-$(CONFIG_$(PHASE_)RESET_ROCKCHIP) += reset-rockchip.o rst-rk3528.o rst-rk3576.o rst-rk3588.o

Separate patch for this please.

Cheers,
Quentin
