Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C61BD3900B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 19:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54817835B3;
	Wed, 14 Jan 2026 20:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mnwhvptm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C5D8063E; Wed, 14 Jan 2026 19:24:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE5C80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJME2OuKrB4PTbDp+Q+1WrTD/olRzqOGu3kfUCBz9qqItlYozKa//NEihLATiXu0hKaeoz57sJwDXo5hxtviB+VnJ7FTkkz0VGGAiiZOYSU1AV2k2XX0jsn5azrQ3erKzmoqAgcFGC54Sg9iX/7dnhbfWtSsWG3RIlnpxkDHtssBidxgD/Ni3DgQaXjNI35C6q6B2E57hu/Enm/f89RRVbRXgW+D7Cr1Vl/b+IMVh7N+7gVH6vrBfNtQFyBL1DSlUeigdwHXgzAUU/Sw3pLLrEmUwzPDn9BqRr5kFEhP8FtE2BX5ypEzk+rduSYuIomwpc068/hqTJz8ILtxUJQeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxiVYXgr2jrmMC2LXfSyp3zFpS1WH8ttFMJmE8g8960=;
 b=OVwT09y/kXUfyIY2ydtPbqgmGSNo224VhgFmQH8QdgdjDFOPnrVkvMEgi3ZX9LWfupv5ySZ5jnAk1eIIbndkj8Wd0eDy4QI9czMtRlGalL7m+Ko8T0yeRVvr0brXOaFIQmTo586awgNIfJcfohyDdacClIh+Nr+/Wz8KC5IuOmqHY8mZH0qy5LmW+JwWB5ZvOr/F0ttUGbXKfBstP0VncM+1wMcTmgQtpHDAEei6PvBzQ9o7igMHsHisaVwpjjaYPbsGSrs7UhoWR74b2OIWTIvOZ9XYJg7APgOPMI14iJ3IILixFxKBhFL90JQjw9ETxeUKud0e6xv96VX5ZKwjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxiVYXgr2jrmMC2LXfSyp3zFpS1WH8ttFMJmE8g8960=;
 b=mnwhvptm+z7x1vXn67iaC3GG7sp5+BiV0m9o2ipvm0kCzJL6386s+JWc1ySWyw3PcGt+3tMJpT8Xd+bsElWxpx4WBbICXYUGdiUOCyUED9e3W90I62ScbEVPWyeiZAyNmF0ca/7xqlE5fZWatORm7t1cPtW/nCKwTtUZI3xCCP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 14 Jan
 2026 18:24:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 18:24:16 +0000
Message-ID: <ad431bd8-7c0e-41d3-b079-14ab5c82b7a7@cherry.de>
Date: Wed, 14 Jan 2026 19:23:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] ufs: rockchip: Add device reset support
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
 <20260108-rk3576-ufs-v4-2-e8e67649f3f8@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-rk3576-ufs-v4-2-e8e67649f3f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 65126d3b-ac14-45e0-1f59-08de539a200b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHBTZVVlVlVSdkJBWUd3VEJWUWZIbGpETlF2MERXa1pkUzgxVHJhRURjT1cz?=
 =?utf-8?B?L0hSNWZEb2VLcThkREFnZmJIVjhJR1BWak80Y3NUQ3VJOGZzMzUvV2hoUjNx?=
 =?utf-8?B?M2xjczdpdkJOYm9EYXlHbHRkc05TUUFhZ2t1KzZ1ZzRUQW5HOWV4VUlMVnkv?=
 =?utf-8?B?TERmRm9ud2V2cUpaQloyMC9oYVNFTXdld0F5OFBRR2FmS0tyQjNxbWMrTGtw?=
 =?utf-8?B?OGJvbzFxM0tGV1FvU1pqYXZQWHhQRG9YbkszMkNKKzhBc0dNQU1HWjNHYmhs?=
 =?utf-8?B?eDl6WkFTVVQzK1hKSno3b2Jma1QyVlliVTlyS0VSazJPYWlSZFdlS3MrWTU0?=
 =?utf-8?B?L3hXOUk5R293WlpYejJ4OHJqd2M0bkFSdTc2dld2RkNWMHVyK3lxQnZKcFRH?=
 =?utf-8?B?M3QrUStJd1djNDRTNlR5VjNuR3haa3prYnYwbEVZU2RsVjMxMzJ6dmp0NDJr?=
 =?utf-8?B?Ykt2YmwyelJkQTVodkxGNERxeVpuUytTWFVrVzEwMkpEWE55ZUhlSVRLSVRR?=
 =?utf-8?B?akNHNDlXUSt3U0xYMlY1bVNjZ3RaVG9BVFRpWGxJWDlmaHFZZHZWYjFCYy9Y?=
 =?utf-8?B?V0tLMVVwem5ueER1Y1poOXlIc1dWaGFJU1VLaGdyd0h0Ky96TEx6WmhpdUhH?=
 =?utf-8?B?ZzRURVcrZyt4N01XRnBEOVdYM1ExTTRJVjR0bVZlQ3RmSHRUTVVKdnR5U01V?=
 =?utf-8?B?WmlCVlQ3NmFIN2NOS3g5U0ozTFVpR1k0dUg5WWNyQXNIYU4yWWF2SGZTcEo4?=
 =?utf-8?B?a1piMWlZZGVIbmVCankwVEhaS2VKSXR2R2cwKzR0UnA0QWxuakZCdDhNQXdO?=
 =?utf-8?B?b2RBZ3FEbjZtYm5iZjRBLzBuVnE1L0RadUtaRm9tUEhmT0V2TGEvd0xMa1Jm?=
 =?utf-8?B?enNUZUpkZlF0T2RqZDErNFV5OXc1M3JZeHlxV0ZCbEdoaTZHZmYvdVlTU05I?=
 =?utf-8?B?eGxzYkczNk1ZUUJrRzZMVUFtSllpYi9HS3dxNWdQS0EvbWVNZkY3RFlPTW5V?=
 =?utf-8?B?RHVxenh0ZnRmYWdLc2JLRG9OZkdQNjRTc2kxUXNQa2RRM3p5VDVrenRyRFJY?=
 =?utf-8?B?M0MxNGZpbjVTdVNMdVR3T3hZNTg5QWhsaVFPTS9UTDNjaFZpek04UTN1OVhP?=
 =?utf-8?B?ZFdTWms2cHJrWlZIaDJjY094MGRrY1dXa3k2ZlBpSWFQVjM3UmRSTVZoS3U2?=
 =?utf-8?B?Q1JJQlF4TXhSbldVam1uR0dZZ0lhcHl0Q3IxZ1BqenJMYWsyOFlCUExURTl5?=
 =?utf-8?B?SXJ2bURBQTRkRnlkb0hGVUFLRkxzUG05T21VUnN6d0hKQ0RGeXNsQTc3SE9L?=
 =?utf-8?B?L09LYUp0cFpTNE5xN2hvQ0JEbFNxMnd1ME54aVMrOEJudXlHZ0djWUtaMjBr?=
 =?utf-8?B?RWdOamJXbkl0Um1PUE1lY0ptbk9XdUhXSzJyUUVLTDRyb0ZFckJlM0JLblhk?=
 =?utf-8?B?Y0xQaDhhZHpwMUMwSTdoT25hdUpxNmFlT2IvS0dOMGw2SGNEMXNXSm5VOXRW?=
 =?utf-8?B?eUxtZ0FlNmRqdXR0ZFJ4YmJEeDkzM3hsTldiRWQzVHhNNTlaaW1ZQWJiQTBj?=
 =?utf-8?B?WXhXbzgxK3poQ3U1MWhabHhCanpzUU9VeHdmTzNHUHl3cHVUTzFyQ01WeDhX?=
 =?utf-8?B?cmxBcUdqTGdlS002a0xkN2FKdUNPTGNHRVhDbUdrUjEvanI3eGVjMTRsV2dQ?=
 =?utf-8?B?WUptUkJ1OHZWNjUycmo1WjFzVkNZYTJHbHlsSzgwUW01UjRaZ2NQQUkwMEY3?=
 =?utf-8?B?Ly91ZFpteVRNVzMvcGQyWkZQMUhHS1lzeEI5RVgzYmtQcjEzOGFadDcvaWhi?=
 =?utf-8?B?Z2lrZFpobmF4RDhpN1YxS2IwUlFQVFdBd0Y0bjE1ek80RTFIN3BoMkI4dXBO?=
 =?utf-8?B?cGxNWnAvcC81UUViNkxCQkxUaWJhQlA0NUZacGV0UXhGelcraFMvV3oxSWNu?=
 =?utf-8?B?eFZTanp2RlRTd2lWbHFqZlIxVDBaczRPOU1FSDk0eVBnVmN4c25ibTVOaVdL?=
 =?utf-8?B?VlpyZnFQSHIwK0V4SXFCQkdQb3RzbG9uQ1k2N0xUMVhhWkpCTUFmMVJ2aWpw?=
 =?utf-8?B?OXRKL1U5UDRGK05pN0pnUmFlQ1hWQU0vS1M5clBHejhwWXJIS2YyMlRTUEdx?=
 =?utf-8?Q?YRx4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJQclpUdVdYZGltNmExT0Vqb2RrTnN0cnVwUWlWWGdhTXhTYk16cVNIbEJp?=
 =?utf-8?B?SzR6Nm5ScElVWEdNYUFDcmZYa1dobXVPajdxQ3ZBME9KMXhqZlQrcVF4RUkr?=
 =?utf-8?B?ekFwaEVOdjE2T1pTN0Q5eVNuajJ1ZW93U3V1Vk9TTWh6WXk1NTYzUHZ4Sko4?=
 =?utf-8?B?d0ticm1meTVNNk5JbTFzN3A1c05vUnNoTG5FRkQwZFF2ZXd5TkZZVnp1dDVv?=
 =?utf-8?B?UDBrc1FPZ3VDc3JUSDJUT0dSYXl5dm0yYjd3eWdBalRqa1EvYUIzVTl1dHFs?=
 =?utf-8?B?N2VmV1pvR3MxaU8yWVRyRGFEL1BXTFVSRUVQdkczWXpnK1RMdUUvZUppdmR1?=
 =?utf-8?B?VEJESFJWMGdHNjhuUGt6ckdXeGZwMTZOdlVOV2Y4cUF5bVJoV2IwakFrL3hn?=
 =?utf-8?B?L0RWMGw0dGMvT2NDWWY4d0FNOTJjRnREcUd0MmppKy9xakFzM1o0VjJ2UGZE?=
 =?utf-8?B?QUZyTzU2eVA4WCtBeDh2YkI5UHBXUy9FQ0xVeGZlRFlwMnpiU1ZIdWR5WFh3?=
 =?utf-8?B?dDg3V1BmT1MweUlMTEdET1Mramg0Uk9qZG16eWJOcUdTZnR2aWVlNFduelVx?=
 =?utf-8?B?bEphVjZQWWRSdHdIWGVpaEY4SDY0Tks4MmtxY3A5ZlpqbWFJSVBodXhsSHli?=
 =?utf-8?B?ZHU0dGFLRUx4MHkyaHQwa3NsYVc2U0dXb2VONUt5OFY0UW5qVVE0S0NKczc0?=
 =?utf-8?B?VHhUNmlKSStIRytEUm9VeHg4YzNPb1R3TEt4VmhRSTBaOFdVNzJLWm0xVy9Y?=
 =?utf-8?B?UDhXemxVbjdXRit3MkxjVVN5UlUxY1lzdTJUN000WGdmcEdVelJWVDk2c3ls?=
 =?utf-8?B?eHFkVDNIbmJ0UTgvbWZYVWZ2dWdOWmFBQkhKN1V2NUhyaFhHTGZtNi9FRFl4?=
 =?utf-8?B?bU8yOHpGNG9FOXVMdlVodXF0RUhSemE2bWNCTnduY0g2TnpCZ1g3OVlFVmlh?=
 =?utf-8?B?cmxncFlLUjUzTElIand4bHhQSkxtMUNiM1o0TlN1bmtrVGNId1JINUczbWRR?=
 =?utf-8?B?N0Z6OUNqZGZnVCtZTFlnSFlNdXFydWxiREpLak9VclJZWWhVMTkvVnNMOUVI?=
 =?utf-8?B?eE5iZFVyUnB5UVI2WEl4R0I4UEpYZWVVSk9kek9hN2ZJYmVlMTR6TVBzUjk5?=
 =?utf-8?B?QldiU1NsQXdXVmdGam8xdEZKeGxnU25NUG43UEVnVG9vcStxMkExY09lay9o?=
 =?utf-8?B?R3FseDdscjR1bWJ1bC9xcUhjZzUwVWoxd2FTZGpmUWxML08rRWNuNDVvUjRy?=
 =?utf-8?B?NDloN2xXNGJWZVlDUWpOQjVCNTRYZUFRMjMyaGlCVE9zMGFwZTdqSzJjR3lV?=
 =?utf-8?B?aTE5RXRyMjNEWXZGUCs0QTFtUWh2dEdBcTdpQzg5MUZTSTljVXJUclRUcndJ?=
 =?utf-8?B?aUd1RkRxTmh5SzBBaUlzalJYbmN4SVdaT2U4aE1QMVNxK0RUTWxyWjIyUjU0?=
 =?utf-8?B?MjdsS1Y5TTRGbUtiQll3ZC9wbzNHamQ2TVRyZEFYV0pzVG9tendqMnhyYUYz?=
 =?utf-8?B?VFJHdGI1RXBTSGpvVXlaRm14TkhmdlJ0Y1RFYlVOTi9oSmVWQVNYNjRsSkRp?=
 =?utf-8?B?WkpONFhRQ0JLN2xTOTBWRzdmb1VyYytnQlZOS05TUjV1Zm1iZmpJbEpwUnR6?=
 =?utf-8?B?NXBxandoZzY4eWQ1MGlOS3EyMlFMbFdIdXlLQkxISUl1QTlMd2hWUHZ4SVoz?=
 =?utf-8?B?R3RYbnJuR0tWZ0FNdmVkYm9sSS9ZSjJDa0dtWENOa1lwbzNITlpsejMzcUhh?=
 =?utf-8?B?UEpwa3gxclAyQThqUko3dmRRNnBkQVJmb0RwNW44dHRjaDVoU2RWamNqWlQ0?=
 =?utf-8?B?M3k0d3Ayanl4OGkrVE1QZk9OSlhXZDA0aXhQVy9RdUcvZXJPM0gxcGpYWlVZ?=
 =?utf-8?B?ZzJEMWRwNGhEK1RkQmJIRHM4OURsaWp0UnZ3ZjlEUzd5ZHdUWlNBMnpIQ0tq?=
 =?utf-8?B?Sy8vUWhwNTM4MDRySk53ZlRsaUhyMHdRWER1OE45NGMxT0FrNVd1TC9FQmpB?=
 =?utf-8?B?TzNHTnY0d2dhS291ZXB0bTJNNG94SzBpaWduWTJJZ0YyQWlMZG9HY3BqS1RV?=
 =?utf-8?B?VTRCcGwraUtLVCtKeGg5dm4rakxLdWl5SlNzR0hRcW5QRGd3cEQ2TXFJNFNQ?=
 =?utf-8?B?UDdpRGhWd1EyODVyT1ZQaHBmMGZqeFRyOExqT3hpZXdHZnZaU3FZVnRMQjNP?=
 =?utf-8?B?MEdZM3RkTHdlWWFMQ0YvV1JscmVuN3Q1MGhPYllPOG5DMHhHcnUyS2pNbnNo?=
 =?utf-8?B?VHBYM1Y3UHcrV3ozUHNFUklCZWhzcmZBRjRFNGQ5dHlMZm5IQ3VkQkYyVnNP?=
 =?utf-8?B?SDEwWjA4cFQ2NjhlWWtSRmdOUG9rQmlRb2t3R3VpMXV6RE1WU1VyQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65126d3b-ac14-45e0-1f59-08de539a200b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:24:16.1744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1d5J6ETUjQGwt0oi8dFicqUd0+1kdz11EZuTF8IWMVubtNQTVpDfXl6mTj+hgfyQwTaA03XcODmGTLecF0UeZ2abqr9Fr5Ti6SYJ0JUCPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435
X-Mailman-Approved-At: Wed, 14 Jan 2026 20:34:42 +0100
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

On 1/8/26 6:49 PM, Alexey Charkov wrote:
> Wire up the GPIO line which Rockchip RK3576 UFS controller uses to reset
> the connected UFS device.
> 

It'd be nice to say that reset-gpios is required as per the Device Tree 
binding, c.f. 
https://elixir.bootlin.com/linux/v6.18.5/source/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml#L70

> This seems necessary at least for some UFS modules and fixes the following
> error while enumerating UFS storage:
> 
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_link_startup: Device not present
> ufshcd-rockchip ufshc@2a2d0000: link startup failed -6
> ufshcd-rockchip ufshc@2a2d0000: ufshcd_pltfrm_init() failed -6
> 
> Fixes: 76465ce21ee4 ("ufs: rockchip: Add initial support")
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
>   drivers/ufs/Kconfig        |  1 +
>   drivers/ufs/ufs-rockchip.c | 25 +++++++++++++++++++++++++
>   drivers/ufs/ufs-rockchip.h |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 6c75bb2a0790..30b0c87798e1 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
>   config UFS_ROCKCHIP
>   	bool "Rockchip specific hooks to UFS controller platform driver"
>   	depends on UFS
> +	select DM_GPIO
>   	help
>   	  This selects the Rockchip specific additions to UFSHCD platform driver.
>   
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387da..48444705fb29 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2025 Rockchip Electronics Co.Ltd.
>    */
>   
> +#include <asm/gpio.h>
>   #include <asm/io.h>
>   #include <clk.h>
>   #include <dm.h>
> @@ -153,11 +154,34 @@ static int ufs_rockchip_common_init(struct ufs_hba *hba)
>   		return err;
>   	}
>   
> +	err = gpio_request_by_name(dev, "reset-gpios", 0, &host->device_reset,
> +				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +	if (err) {
> +		dev_err(dev, "Warning: cannot get reset GPIO\n");

No need for "Warning: " as it is an actual error.

> +	if (!dm_gpio_is_valid(&host->device_reset))

How could it be invalid if we managed to request it in probe?

Cheers,
Quentin
