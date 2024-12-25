Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E9E7718D
	for <u-boot@archiver.kernel.org>; Wed, 25 Dec 2024 02:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01B8806EB;
	Wed, 25 Dec 2024 03:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BP7Xwg/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69BB806FC; Wed, 25 Dec 2024 03:05:55 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3993E806E5
 for <u-boot@lists.denx.de>; Wed, 25 Dec 2024 03:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm46DuEZp5TqYfnS1KMp3YZ69bgvn06knkR0UUqpf4xU7x7BrAHtb6gY5M1GqKLs62bQlwDFtWuyjkCj0bOOH2sOMNlGEk3HZmDAISyJhBScCbBGwjHacdQTzi6LRbLS4QZrEWFTENjbrN7UaP/nwCHtO3CGPgFKXOihGZABnFgw2Y/Z+sDKmX3fo+2YgdkM0DafM7c6Zvh1GU22aoJkZrPVdK/pjca/GxrOXSk1icvhU63zqnH3p0cMXcEa4VBtBAJc9bopmlV98a6sHPtfjF79m6TpHJcgR8FPPA3ySxUB0YEjASg8BeJVweN1XZnQlZ2s+TOTb3Au9FXF5pznZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ra//ek39nbeLFAuutpKuh6bQlxTYPN3svGFH5oV6wec=;
 b=cXYF21fnYn/BoE+Y/E/A76ET6/HE2m0hjOwUbNUVwOcmXRW4BYCvw/jVDo1kJ/KhWVyJ1kg92OcNz5ivvsT5n8QwigQngIKU78oUYhUWChpwRjQn5WVDntOGegh4NzaM7A/haauRtPq2xk7iKURO6x3uGv0MEyKfo+Y8RwxVRuoZ9ZB1OBbWM53YM1Ctkt9Emh0PQdbptrxQiH0wqemEDUBeIU2c0Idpgvx5cx6rm8fvcdlO7zmI22JSf5PeXFVDQgSjvtNQAVZZ+WRkfWdmk5SRS5yBE6FiT4HXIMGWh4mN8PsHZA3ecEwlyAFpxjmhQW7jftREIS/js+buyjZq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ra//ek39nbeLFAuutpKuh6bQlxTYPN3svGFH5oV6wec=;
 b=BP7Xwg/9y6F4H+RTG2nzyQ5wnR6v9t/mWuxzLFA/cEv16uyj7HzDa003If16S2ZWqB6vjgWSRIO8dnNMFuRggdIKQDko6g8i8/qf0ILix5daR/CZJxQ67TZYcxQ4SYFSOh4Jh6N/Bqi+A1duNuy+UVmmHyQegy/1GfINooWaZmq6Usly5WOuvOFlWBQKs+dWHRBQvLfc0exStj4MunnH6fD/mk2FGCFJ8SUZFPZoyYGFI/ezDeeZHnLXpCV6NqCG98QkNOqaGMeceFIOjNo6yW3K/39VrSfZaRom9QK7Rb2U4nVrSepKI5SQ5hJ5HYKXl2+MYnFbhSmNlGYnCXw2qQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Wed, 25 Dec
 2024 02:05:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 02:05:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio
 Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6?=
 =?utf-8?Q?_add_i.MX95_19x19_EVK_board_basic_support?=
Thread-Topic: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
Thread-Index: AQHbUoq3EiCr5MsbS0ytjsh9g3+ir7L1a7aAgADRQiA=
Date: Wed, 25 Dec 2024 02:05:47 +0000
Message-ID: <PAXPR04MB964493C20B682FB67BA31488E20C2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <20241224133321.gzhoc6vzl4zag4qc@joaog-nb>
In-Reply-To: <20241224133321.gzhoc6vzl4zag4qc@joaog-nb>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB7878:EE_
x-ms-office365-filtering-correlation-id: 14d562b6-ce58-4f11-8dc8-08dd2488a5bb
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cnc3NGFMR3Z5SzZod0tmaUI0WTNsTStiL3B3NWpkU3Z1R21WSlFwVE5UOENL?=
 =?utf-8?B?NWtvNkc4RG9meDdIb0JVa2g0Y3EvbUgvWG1pM3BySEVNdnZ5VWNUa0VKbDNV?=
 =?utf-8?B?eUxnMW9hMEJiT3JEc3Bnb2hsNU1uSnU2R3ZpMUVpaXJUT0x4SGpVU2JvZXFO?=
 =?utf-8?B?SnpJbGYwOWx3aDZTdWU3NzZxWmJaMTEyQXVzU3dDZXdmem8xUVd4WHNaendX?=
 =?utf-8?B?V1JGbnJlMmxZamFML0EvVmtNWnIzS1lkaWU0MTlDaGtqUGoxYVFEUWY3OUV0?=
 =?utf-8?B?T3FDU0dlTkw5VGVoWEk1U3F0M2x1QzEweWxjUHZtcWJLdW9KdGVxdkVha1Nh?=
 =?utf-8?B?Ym82OEVxY0tMUFljQ3NzWWFoNEkwU2twTWF6MjR1K3VURktXbnpML1FnZlUx?=
 =?utf-8?B?NXVhS1g0RVY2ekk4aFRuR1JtUzJ3ajhEejdGV3V1NWJLTmVhMlIzRGpsaVRk?=
 =?utf-8?B?Q3dHYVNlMnRUVmpWM1lFRDhNMlVuYVRxUytpMWQzZzNKdEwyOTBabTh4aGlQ?=
 =?utf-8?B?UU1BUjNFaWVmV1VHU3VNTzlLWmEvbjVyODBXSjJNYkJDM1JWK09QdUhKN2dp?=
 =?utf-8?B?eUNGOEVVaVUrbERhSi93NWgrN0RoNFRTdkJBQlVMSXNoUWFPUFpud3JYTSs4?=
 =?utf-8?B?c3B5KzVtQXJXU0lJQUJ2ck1FbmVFcXNyRXEzOUlkVDdpN2ZiVWc1MVdobExI?=
 =?utf-8?B?S25YK3JLbTk4bUxMMTA2ZEcwNzBzZm5KUkhFNldLMnJvSDdFMUpkYXYvKzFx?=
 =?utf-8?B?Q1JCTUxwaVlmWGpCb29mYUdURnc4YU9wMHBHTWhhK1BxaWVjdW8wUHhWb3Vu?=
 =?utf-8?B?ODlib1U1QmpNWWNGaHUyU0tXcnpOc3g0dXppODJkUHRuTm9RQ0RMRVdLeFlI?=
 =?utf-8?B?RWw2alVwYjM5ekM4RVY0YkNoNlFUUy9hcFhwdXVIcXVsZ3NBcDhxZmkzMU1T?=
 =?utf-8?B?UkRXVWJ5cWVnbExkZ0ZoaGRKclVMTDBiSWNRcklkQUlDVWsveFh3VUovamZZ?=
 =?utf-8?B?Y01PZlRXc1NCdEMvNDgzNTJBM1lObEJlQThTSmYxTHVTZzlwOUVaZlVCbkg3?=
 =?utf-8?B?ekN3T0xWSnJiVmd4aThCTE5XZWkzc05ZSndGRkFHbDNlN25vdEI4d3RKbWV2?=
 =?utf-8?B?NG1HdEJVVjdMbWx0UWRBSVNRTEw0RU1iQklLUmxUWGMyRUpLeGdPaGprZGN2?=
 =?utf-8?B?WDkzbUFyVmVPdytvTEYzWGRBOU4zVmwwcHVQK05TUHZoRGVzMkloeEpUbG9Q?=
 =?utf-8?B?anlsYVBtbkpoRHJqTnFRMjNhZFRzL1hDTDBjRDRMeVVLcGdhSHRZdHUrNUlC?=
 =?utf-8?B?RlZ1VW9zampVSFkzdjk3S2ZFQjBQeTRWTXJmbk01by9BNFpSbmYvSVRDZWw0?=
 =?utf-8?B?aGZCQXQ2ZWVSall2V3FaeXFNck1wZUxJc3NKZzF0ZmVMMDh6eHVEUzhtRUla?=
 =?utf-8?B?LzB2M0JJeVZvMStwYTVncTUyUFlINnhrUGMrK1RLTzR0NFl1Q1VvdnNNK3pP?=
 =?utf-8?B?OHpMeVVMUkRXMGhRTzI1R1h0ekI4QVp6cWlkQUl0dkFTa21Xb3JJYWVJakto?=
 =?utf-8?B?blE2ZkZlTEZSdTJXY1IvYklmbDRiNFludy9mY0t4N3RVMmFjNjZPb3lISUpX?=
 =?utf-8?B?OVFDdC9hK0NPOHRLKzY2UEo1SmhKeThlSFMrVjRaQnhsUGRISzc4Vmd5K0gw?=
 =?utf-8?B?R1NLWHR5R3NXbVFBeXJFQjZtTzZDMkVCbnNQbE5oQ29aL3RNbGcrdGhJU0F4?=
 =?utf-8?B?ejRVTENiekZvMHJCZmRXZjNWWEZ0YW5EVnQvbklGbXNkREZ1cllCazRxR3I3?=
 =?utf-8?B?MlFmMFJzRTE3QWNncDJnYUZsNWkxT0pXVnU2cWNjT2FEV2hYUFduUnE0T0lO?=
 =?utf-8?B?b2lUWDZQbnhlbU9BUVNhR0RNMnREV0NJLytsVjhIWFpIby9JMTVOQVFrZE9o?=
 =?utf-8?Q?cv7jvPVTY9CgHJjtx9/Iwc3ov3l/Y9vT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eU1DTmVsdFRhUzJYaGpjSFJFZWNHN3FmcHVuazUvNWZxQndkek0yMjFNeGJY?=
 =?utf-8?B?cG9wUURrTGsyUDlmNzVldzdXWFFvQStHVjV6aWJlYUZDcVc1UXNhSzQ5WVIx?=
 =?utf-8?B?cHRIeUJQSE5nOFlxT2tyZWxlWkl5OExYdTdYSUhkaURFQy9oUUNCZHpUMWpm?=
 =?utf-8?B?UTRJR1pzSlpidytyZlJYbnd1VUJhMEQwWE1LT3YrZktkK0hQZ2w1eDkvWWZz?=
 =?utf-8?B?WFB5dmYvMy9lRy91SXkzTERhMmswL2VQV3hyUFhrUGh5UklDZWppSVBLUnkw?=
 =?utf-8?B?UFpuYWphQjNlSCtGaTYrUWJPZ1ZucjhoTUljajVJdFdHZnZlSFkxTHczejFW?=
 =?utf-8?B?MUQ1MkFmZWtEaFAwZTlGWFRXVlhjTUNsanBmakpEUm8vdHFYRUl3VE1uSUUw?=
 =?utf-8?B?N1pxbUdRamtZblRUaDgzM1ZZSlBza3pCTHcrUDBNb3JxZWNFUUg3dTJkaVIv?=
 =?utf-8?B?VGNPK2t1YzhRMktJcWMvZUQyM0hRWHhDTUdYMm1sLy9zaW9QRXJidTYyN1VH?=
 =?utf-8?B?VlVQV1AzbTNuVU12ZDdZQjJ2RHhUM1pQZisvSlVQZWFYbGV4dGJmMGNYNy9p?=
 =?utf-8?B?Sm1uLzRYU05YMmVIaHl4YXo5d0grc0cxeGlqbS9pNjUvdmExdW92VmFPdm50?=
 =?utf-8?B?M2dmRk1JdStXYkZiYVFPZkUvaWtYV1JmSVRqWFpIZVp2L2p6cWE2ei9oaFJG?=
 =?utf-8?B?MlZ0eEZlbXVVcUF2TEhpQzQxWDZqZ2crUGlKc09oOEdFTzJPeWNvNnFTWW00?=
 =?utf-8?B?Uml6dVZETm1zOXlxOGQ3clA3KzNSMFJzeGhpOFBIeWM5bG9MZDF1L1dXakdk?=
 =?utf-8?B?UzFGeHFGSFVObXNMWEFlNDF6dEhaZ0hVUkMwY1dkS2pFaENWTFhEV3RhSXFN?=
 =?utf-8?B?NWNYVVo4dDgwVEdKUkIwMGlWTTBQbWpkZHRROW5wYk5jNURpTFF3UUl6Z0Jn?=
 =?utf-8?B?WVAzV1F6RHZWQ1JBc2ZudGR0dGdGVmhaa2pBOGdZSFVOMmNocStuakVpVnpp?=
 =?utf-8?B?cWVGdE0zMmphUWM5YnhscjJjdjZxTW83cTJVSGdhZVRERjBhanVyR1l6ODBE?=
 =?utf-8?B?VGo3djYzL0ZCT3dvVHdSNGg4UE5IU2RXam9sTHZsNVhkbHhJc1dsVWNTYWlv?=
 =?utf-8?B?c25oVFIvOEppVWJHV25iU283SENydTJBcFEzTGlqamJMVVBoM2owdXZMUjE3?=
 =?utf-8?B?eUIzbU0rUnBTUVhRZStFam90NEI3eU9kVXVkdm54QXVGazh4aEIzYjJ2Mzlx?=
 =?utf-8?B?bGZ2ajRrVmhCK3Z5T01MMHZvUVA3aXBGRWdFdXhVcDc0NUhkSlAyWEJBZ2dU?=
 =?utf-8?B?dmhBUFhMTmUzL0hnTjl5MjJYenJoVlMyRVRKOTJDQnk2NjZld3lqNEZDOGpS?=
 =?utf-8?B?Q0F0amxsdVVWUHYzSEZHUWlEcVBOclVYU1NkQ0p4eHNmYWErZi8vUFdRMEJV?=
 =?utf-8?B?YTUyMCtFcm5aY2N0V2pad2tiVzQvb2wzRDNybm0vZGpNS0U1aEFYMnZBVmNJ?=
 =?utf-8?B?U0FDaGp6YW9ReXhMVTg0dTE1M1pwcW0zdy9aTFFpdWRoaXNCTW9SY0R0L0E4?=
 =?utf-8?B?TjR4LzNQQTJVV1N4YjNqY0Y2Y3NhSi9sL1YrT0dxeTVXbUlscWRFeWZUT3o4?=
 =?utf-8?B?U0hIZnRIK1QwNFVDWkRqMzlvSE1rL1VlUUZsTTFGNVF0cTNMN0gvNmRnZ3pO?=
 =?utf-8?B?T0FDaGJCd3hhZ2U2WEY3U242bHJ3cm1RcytJaUVJNWFaWU1ycVJPZ2NZRTgz?=
 =?utf-8?B?dkVkK2gwNHpCd0l5VS80bDVQWWthWHV6VUlCMFFWOGpxOTFmS2VFWjJSbmo2?=
 =?utf-8?B?bjRHbzRzTndONjV1amdRWElXYlFNWCswdTNETGF3VzVaRTlNTThMOFVuSisz?=
 =?utf-8?B?LzI5K0NEendyUWZlVktFWnVCQlVJV091bDFWeDFLcUhVZ0txN0VCZEtocFBm?=
 =?utf-8?B?emJPa0trWU14clorcXBuK3A2b1JEUXdJakh5OWVEdExXdWZnT1ZQVGlZVHNy?=
 =?utf-8?B?dityVk56Y2I3Rm5SWmwxWjJ1QVVzeCtubU00THBEY1lpNDBqRGlHVjVlZ2V5?=
 =?utf-8?B?bC9kTFNxY3NraHBOYU1lZHM4ZWFDZWlmSWRJNVArZzVPMTBvWGhPYjRiKy9I?=
 =?utf-8?Q?rYGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d562b6-ce58-4f11-8dc8-08dd2488a5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 02:05:47.0944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBz4/5IffymOf/kHRLu6LtTUbtSC7U0YzYBeZ5/yc3PgKxx0VJdmUm3eTgiy0R/XYC0OXS+tGQ3OIO3tpo68Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogSm/Do28gUGF1bG8gR29uw6dh
bHZlcyA8anBhdWxvLnNpbHZhZ29uY2FsdmVzQGdtYWlsLmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAy
MDI05bm0MTLmnIgyNOaXpSAyMTozMw0KPiDmlLbku7bkuro6IEFsaWNlIEd1byAoT1NTKSA8YWxp
Y2UuZ3VvQG9zcy5ueHAuY29tPg0KPiDmioTpgIE6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5j
b20+OyBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVueC5kZT47IEZhYmlvDQo+IEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT47IGRsLXVib290LWlteCA8dWJvb3QtaW14QG54cC5jb20+OyBMdWth
c3oNCj4gTWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdt
YWlsLmNvbT47IFNpbW9uDQo+IEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPjsgQWxwZXIgTmViaSBZ
YXNhayA8YWxwZXJuZWJpeWFzYWtAZ21haWwuY29tPjsNCj4gdS1ib290QGxpc3RzLmRlbnguZGU7
IG1hcmV4QGRlbnguZGU7IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+OyBZZSBMaQ0KPiA8
eWUubGlAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgRnJhbmNlc2NvIERv
bGNpbmkNCj4gPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pjsgam9hby5nb25jYWx2ZXNAdG9yYWRleC5j
b20NCj4g5Li76aKYOiBbRVhUXSBSZTogW1BBVENIIHYyIDE2LzE3XSBpbXg5NV9ldms6IGFkZCBp
Lk1YOTUgMTl4MTkgRVZLIGJvYXJkDQo+IGJhc2ljIHN1cHBvcnQNCj4gDQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiAN
Cj4gT24gRnJpLCBEZWMgMjAsIDIwMjQgYXQgMTA6NTU6MTRBTSArMDgwMCwgQWxpY2UgR3VvIHdy
b3RlOg0KPiA+IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRj
aCBhZGRzIGkuTVg5NSAxOXgxOSBFVksgYm9hcmQgYmFzaWMgc3VwcG9ydC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFs
aWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9kdHMvaW14OTUtMTl4MTkt
ZXZrLXUtYm9vdC5kdHNpICAgICAgfCAyMjQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9LY29uZmlnICAgICAgICAgICAgICAgIHwgICA2
ICsNCj4gPiAgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL2NvbnRhaW5lci5jZmcgICAgIHwg
IDEwICsrDQo+ID4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkvc2NtaS9pbXhpbWFnZS5jZmcgICAg
ICB8ICAxNSArKw0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg5L3NjbWkvc29jLmMgICAgICAg
ICAgICAgfCAgIDEgKw0KPiA+ICBib2FyZC9mcmVlc2NhbGUvaW14OTVfZXZrL0tjb25maWcgICAg
ICAgICAgICAgfCAgMTIgKysNCj4gPiAgYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9NQUlOVEFJ
TkVSUyAgICAgICAgIHwgICA2ICsNCj4gPiAgYm9hcmQvZnJlZXNjYWxlL2lteDk1X2V2ay9NYWtl
ZmlsZSAgICAgICAgICAgIHwgIDExICsrDQo+ID4gIGJvYXJkL2ZyZWVzY2FsZS9pbXg5NV9ldmsv
aW14OTVfMTl4MTlfZXZrLmVudiB8ICA5NSArKysrKysrKysrKw0KPiA+ICBib2FyZC9mcmVlc2Nh
bGUvaW14OTVfZXZrL2lteDk1X2V2ay5jICAgICAgICAgfCAgNTQgKysrKysrKw0KPiA+ICBib2Fy
ZC9mcmVlc2NhbGUvaW14OTVfZXZrL3NwbC5jICAgICAgICAgICAgICAgfCAxMTcgKysrKysrKysr
KysrKysNCj4gPiAgY29uZmlncy9pbXg5NV8xOXgxOV9ldmtfZGVmY29uZmlnICAgICAgICAgICAg
IHwgMTc4DQo+ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRvYy9ib2FyZC9ueHAvaW14OTVf
ZXZrLnJzdCAgICAgICAgICAgICAgICAgICB8IDEwOSArKysrKysrKysrKysrDQo+ID4gIGRvYy9i
b2FyZC9ueHAvaW5kZXgucnN0ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGlu
Y2x1ZGUvY29uZmlncy9pbXg5NV9ldmsuaCAgICAgICAgICAgICAgICAgICB8ICAzNiArKysrKw0K
PiA+ICAxNSBmaWxlcyBjaGFuZ2VkLCA4NzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg5NS0xOXgxOS1ldmstdS1ib290LmR0c2kNCj4gPiBiL2Fy
Y2gvYXJtL2R0cy9pbXg5NS0xOXgxOS1ldmstdS1ib290LmR0c2kNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4DQo+ID4NCj4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMC4uNWM4OTE1MTg0NDhkMjQyMDRmNWNhDQo+IDJhMDA5NTcNCj4gPiBiNDdhMGEy
NGJkNzANCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDk1LTE5
eDE5LWV2ay11LWJvb3QuZHRzaQ0KPiA+IEBAIC0wLDAgKzEsMjI0IEBADQo+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQg
MjAyNCBOWFANCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZkZWYgQ09ORklHX0JJTk1BTg0KPiA+
ICsvIHsNCj4gPiArICAgICBiaW5tYW4gew0KPiA+ICsgICAgICAgICAgICAgbXVsdGlwbGUtaW1h
Z2VzOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIG0zMy1vZWktZGRyZncgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBmaWxlbmFtZSA9ICJtMzMtb2VpLWRkcmZ3LmJpbiI7DQo+ID4gKw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBueHAtYXBwZW5kLWRkcmZ3IHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBvZWlfbTMzX2Rkcl9pbWFnZSA9ICJvZWktbTMzLWRkci5i
aW4iOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxwZGRyX2ltZW0gPQ0KPiAi
bHBkZHI1X2ltZW1fdjIwMjMxMS5iaW4iOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGxwZGRyX2RtZW0gPQ0KPiAibHBkZHI1X2RtZW1fdjIwMjMxMS5iaW4iOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGxwZGRyX2ltZW1fcWIgPQ0KPiAibHBkZHI1X2ltZW1f
cWJfdjIwMjMxMS5iaW4iOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxwZGRy
X2RtZW1fcWIgPQ0KPiAibHBkZHI1X2RtZW1fcWJfdjIwMjMxMS5iaW4iOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgICBzcGwgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBmaWxlbmFtZSA9ICJzcGwu
YmluIjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIG1raW1hZ2Ugew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFyZ3MgPSAiLW4gc3BsL3UtYm9vdC1zcGwuY2Zn
b3V0IC1UDQo+IGlteDhpbWFnZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4g
KyAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHUtYm9vdCB7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIGZpbGVuYW1lID0gInVib290LmJpbiI7DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBta2ltYWdlIHsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhcmdzID0gIi1uIHUtYm9vdC1jb250YWluZXIuY2Znb3V0IC1UDQo+IGlteDhp
bWFnZSI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICB9
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIGlteC1ib290IHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZmlsZW5hbWUgPSAiaW14LWJvb3QtaW14OTUuYmluIjsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgcGFkLWJ5dGUgPSA8MHgwMD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBibG9iLWV4dEAxIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
bGlnbiA9IDwweDQwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxpZ24t
c2l6ZSA9IDwweDQwMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0
ID0gPDB4MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWUgPSAi
c3BsLmJpbiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBibG9iLWV4dEAyIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBmaWxlbmFtZSA9ICJ1Ym9vdC5iaW4iOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICB9Ow0KPiA+ICsgICAgICAgICAgICAgfTsNCj4gPiArICAgICB9Ow0KPiA+ICt9Ow0KPiA+ICsj
ZW5kaWYNCj4gPiArDQo+ID4gKyZ7L3NvY30gew0KPiA+ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4g
KyAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmYWlwczEgew0KPiA+
ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gK307DQo+
ID4gKw0KPiA+ICsmYWlwczIgew0KPiA+ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4gKyAgICAgYm9v
dHBoLXByZS1yYW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmYWlwczMgew0KPiA+ICsgICAgIGJv
b3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmdwaW8xIHsNCj4gPiArICAgICBy
ZWcgPSA8MCAweDQ3NDAwMDAwIDAgMHgxMDAwPiwgPDAgMHg0NzQwMDA0MCAwIDB4NDA+OyB9Ow0K
PiA+ICsNCj4gPiArJmdwaW8yIHsNCj4gPiArICAgICByZWcgPSA8MCAweDQzODEwMDAwIDAgMHgx
MDAwPiwgPDAgMHg0MzgxMDA0MCAwIDB4NDA+Ow0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0K
PiA+ICt9Ow0KPiA+ICsNCj4gPiArJmdwaW8zIHsNCj4gPiArICAgICByZWcgPSA8MCAweDQzODIw
MDAwIDAgMHgxMDAwPiwgPDAgMHg0MzgyMDA0MCAwIDB4NDA+Ow0KPiA+ICsgICAgIGJvb3RwaC1w
cmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmdwaW80IHsNCj4gPiArICAgICByZWcgPSA8
MCAweDQzODQwMDAwIDAgMHgxMDAwPiwgPDAgMHg0Mzg0MDA0MCAwIDB4NDA+Ow0KPiA+ICsgICAg
IGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmdwaW81IHsNCj4gPiArICAg
ICByZWcgPSA8MCAweDQzODUwMDAwIDAgMHgxMDAwPiwgPDAgMHg0Mzg1MDA0MCAwIDB4NDA+Ow0K
PiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmxwdWFydDEg
ew0KPiA+ICsgICAgIGNsb2NrcyA9IDwmc2NtaV9jbGsgSU1YOTVfQ0xLX0xQVUFSVDE+LCA8JnNj
bWlfY2xrDQo+IElNWDk1X0NMS19MUFVBUlQxPjsNCj4gPiArICAgICBjbG9jay1uYW1lcyA9ICJp
cGciLCAicGVyIjsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+
ID4gKyZtdTIgew0KPiA+ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1y
YW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmb3NjXzI0bSB7DQo+ID4gKyAgICAgYm9vdHBoLWFs
bDsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZjbGtf
ZXh0MSB7DQo+ID4gKyAgICAgYm9vdHBoLWFsbDsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyZzcmFtMCB7DQo+ID4gKyAgICAgYm9vdHBoLWFsbDsNCj4g
PiArICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZzY21pX2J1ZjAg
ew0KPiA+ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4g
K307DQo+ID4gKw0KPiA+ICsmc2NtaV9idWYxIHsNCj4gPiArICAgICBib290cGgtYWxsOw0KPiA+
ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnsvZmlybXdhcmV9
IHsNCj4gPiArICAgICBib290cGgtYWxsOw0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArJnsvZmlybXdhcmUvc2NtaX0gew0KPiA+ICsgICAgIGJvb3RwaC1h
bGw7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmey9m
aXJtd2FyZS9zY21pL3Byb3RvY29sQDExfSB7DQo+ID4gKyAgICAgYm9vdHBoLWFsbDsNCj4gPiAr
ICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ7L2Zpcm13YXJlL3Nj
bWkvcHJvdG9jb2xAMTN9IHsNCj4gPiArICAgICBib290cGgtYWxsOw0KPiA+ICsgICAgIGJvb3Rw
aC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnsvZmlybXdhcmUvc2NtaS9wcm90b2Nv
bEAxNH0gew0KPiA+ICsgICAgIGJvb3RwaC1hbGw7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmey9maXJtd2FyZS9zY21pL3Byb3RvY29sQDE5fSB7DQo+
ID4gKyAgICAgYm9vdHBoLWFsbDsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gKyZwaW5jdHJsX3VhcnQxIHsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gKyZ1c2RoYzEgew0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFt
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnBpbmN0cmxfdXNkaGMxIHsNCj4gPiArICAgICBib290
cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwaW5jdHJsX3VzZGhjMV8xMDBtaHog
ew0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJnBpbmN0
cmxfdXNkaGMxXzIwMG1oeiB7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07DQo+ID4gK307DQo+
ID4gKw0KPiA+ICsmdXNkaGMyIHsNCj4gPiArICAgICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gKyZwaW5jdHJsX3VzZGhjMiB7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1yYW07
DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcGluY3RybF91c2RoYzJfMTAwbWh6IHsNCj4gPiArICAg
ICBib290cGgtcHJlLXJhbTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZwaW5jdHJsX3VzZGhjMl8y
MDBtaHogew0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
JnBpbmN0cmxfdXNkaGMyX2dwaW8gew0KPiA+ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArJnJlZ191c2RoYzJfdm1tYyB7DQo+ID4gKyAgICAgYm9vdHBoLXByZS1y
YW07DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcGluY3RybF9yZWdfdXNkaGMyX3ZtbWMgew0KPiA+
ICsgICAgIGJvb3RwaC1wcmUtcmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmVsZW11MyB7DQo+
ID4gKyAgICAgY29tcGF0aWJsZSA9ICJmc2wsaW14OTMtbXUtczQiOw0KPiA+ICsgICAgIHN0YXR1
cyA9ICJva2F5IjsNCj4gPiArICAgICBib290cGgtYWxsOw0KPiA+ICsgICAgIGJvb3RwaC1wcmUt
cmFtOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJndkb2czIHsNCj4gPiArICAgICBzdGF0dXMgPSAi
ZGlzYWJsZWQiOw0KPiA+ICt9Ow0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiBXb3VsZCBpdCBiZSBw
b3NzaWJsZSB0byBmYWN0b3Igb3V0IHRoZSBjb21tb24gcGFydHMgb2YgdGhlIFUtQm9vdA0KPiBT
UEwvUHJlLXJlbG9jYXRpb24gZGV2aWNlIHRyZWUgaW50byBhbiBpbXg5NS11LWJvb3QuZHRzaSBm
aWxlLCBsaWtlIFUtQm9vdA0KPiBhbHJlYWR5IGhhcyBmb3IgaW14OG1wL2lteDhtbT8gRnJvbSB3
aGF0IEkgdW5kZXJzdGFuZCwgdGhlIGJpbm1hbg0KPiBjb25maWd1cmF0aW9uIGFuZCBzb21lIERU
IG5vZGVzIChlLmcuIHNvYywgYWlwcyosIHNjbWkqLCBlbGVtdSosDQo+IGdwaW8yLTUpIGFyZSBy
ZXF1aXJlZCBvbiBhbGwgYm9hcmRzLCBhcyB0aGV5IGFyZSBidXMgcGFyZW50IG5vZGVzIG9yIG5l
ZWRlZCBieQ0KPiB0aGUgU29DIGltcGxlbWVudGF0aW9uLg0KPiANCj4gSW4gdGhlIGRvd25zdHJl
YW0ga2VybmVsLCB0aGVyZSBhcmUgYWxyZWFkeSBvdGhlciBib2FyZHMgYXBhcnQgZnJvbSB0aGUg
RVZLDQo+IChlLmcuLCBWZXJkaW4tRVZLKSwgYW5kIHdl4oCZcmUgYWxzbyB3b3JraW5nIG9uIGEg
bmV3IFNvTSBmYW1pbHkgKFRvcmFkZXgNCj4gU01BUkMgaU1YOTUpLiBIYXZpbmcgdGhlIGNvbW1v
biBwYXJ0cyBmYWN0b3JlZCBvdXQgd291bGQgbWFrZSB0aGluZ3MNCj4gbW9yZSBvcmdhbml6ZWQg
YW5kIGVhc2llciB0byB1cHN0cmVhbS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gSm/Do28gUGF1
bG8NCg0KSGkgSm/Do28gUGF1bG8sDQoNCldpbGwgbW92ZSB0aGVzZSBjb21tb24gcGFydHMgdG8g
YW4gaW14OTUtdS1ib290LmR0c2kgZmlsZSBpbiBuZXh0IHZlcnNpb24uDQoNCkJlc3QgUmVnYXJk
cywNCkFsaWNlIEd1bw0K
