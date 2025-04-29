Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF20EC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C2A82AAE;
	Tue, 29 Apr 2025 19:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZT6yjUxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DBF82A39; Tue, 29 Apr 2025 18:30:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB6B82958
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 18:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1BqaGeSG5qbCd4E1Tm8+yOWGsPMGzVMiooJnGSGXwdkY70RgCYPcZtoiEogikJI0ij5Gxwa2VEXP1dlhDL7HoH4aXJnPyCXsbi3QBRoQdEPRWeHDozsTzQt8zsBdJNs0W8qtJicMtRR+eIdGNjc+LwHzFTRpz4bwIP6l+uLg9u9V4enHpPDsAHm3UKL1BSlMkwCv+BQCrm0nJIIGY7hVuv4+xcsNTbaPDFk1wvJDqx2PUQZ+NGfRmnlvMkx+husynjnDzTMRuvBTWOR3Ht4ToEetUKZl2xAluylP7ozj0ZGe4Z27i/uoeOOElQhSsuKTdEwFolLqRoxtaHGjst9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N3OiV7Tr4kVHmD7sCX17bF5wmnQ+gRr1f8F14e6oeQ=;
 b=GriwX2dp5Rke9eh/eGRjWSE83ZfMkuzquU8m7CGPxpetDZD8tVB+rsYPxpVGNRoqD1nTTqaLfvIj8bQXjak5viEXNr05y6Zdd6RWMFDlbuV94urUxzNrfQSEW5ndBtJszkoFhRdX58bY9g5LtWUhYtnZGLXuc4pF1DQf54JUkHFo1uIoJM4wMu48Mq/FvQNHBXrUEY4gxlMqMcreSPyasJNbpfF7ErTUPxE9EQSLwY2y9lg4xWqyX3NNXwYRlTMUf9tKZqcvvLesGZqdh8xUd8rl72QMmdXp5fm5wPwCRGlA635EuXOLW5AfhaFIUZfgWrgoZV4LZVl4Xm/Uc5qFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N3OiV7Tr4kVHmD7sCX17bF5wmnQ+gRr1f8F14e6oeQ=;
 b=ZT6yjUxCSq6nFWWMQT4HmnyX4aEh/wjL0OlPJBY27pfIB7dFd9nCJDvKRYMZD/kzzq/pZ7hFiuvjtW/agcWEqfu38qdcdh/b1BjMRAN6WTC0+hWwa/bkOZpOGo7GBNcH7yeH7Wgfq5vEGl0TH73ywDa6bJb+FT0W4Rx+kZbeAjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10323.eurprd04.prod.outlook.com (2603:10a6:102:44e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Tue, 29 Apr
 2025 16:30:46 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 16:30:46 +0000
Message-ID: <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
Date: Tue, 29 Apr 2025 18:30:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all
 supported SoCs
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Andy Yan <andyshrk@163.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 David Bauer <mail@david-bauer.net>, Deepak Das <deepakdas.linux@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Fabio Estevam <festevam@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jacobe Zang <jacobe.zang@wesion.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Levin Du <djw@t-chip.com.cn>, Loic Devulder <ldevulder@suse.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nick Xie <nick@khadas.com>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Otavio Salvador <otavio@ossystems.com.br>,
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Ricardo Pardini <ricardo@pardini.net>, Sam Edwards <cfsworks@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tianling Shen
 <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Wadim Egorov <w.egorov@phytec.de>, Xiaobo Tian <peterwillcn@gmail.com>,
 huang lin <hl@rock-chips.com>
References: <20250429154453.2155923-1-wens@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250429154453.2155923-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::17) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10323:EE_
X-MS-Office365-Filtering-Correlation-Id: d597b966-dd07-4633-b1fc-08dd873b3164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnFCL0RJTU14NWhiUDMyeWFPTW9xZHc5QjFISUk1a0M3Z2pVYWZ0OEdXOURQ?=
 =?utf-8?B?bkdZM1pPRjZLb1pJTUtsbTdSNE9WWUMxVU93MnpYaS92UkZlMlpsd0N4MHhh?=
 =?utf-8?B?Wk93WTNGV3lqYmhsL0hYVzNKd2Roa2Q2K2cybEdBMGo2c1Y5QlFFVWZNL2ht?=
 =?utf-8?B?ZUhYd24wNzZDZmNXcTBNNmZnQ3RJb3JvRkFVQ2Y4b3RFWXU1VXM3QVdkWGx4?=
 =?utf-8?B?TzU1WFlUNTJJa21RbERFd2dLUnk4QlYrekhKT3Ezb3FqV01qS1Z1eDY4dnpv?=
 =?utf-8?B?TXFjU0FVUytvaUZLRDc5c1E5N0E1blJiQ240STFoY2ttZCthSk5vTVloTGNN?=
 =?utf-8?B?Q21lc1NIeXZ1em1Pa0FHMXh3SnJIanhxL3VDeXpGY25yZ1FaaVgwTEtqUVMz?=
 =?utf-8?B?cVZJeHZ4WCszQVgySDFTWEN4M1lFaEdxMXNqSkVySVdNbCs1N2d1VVpJdzc3?=
 =?utf-8?B?alpNMVVvUHlteXhsdWNSc3A1b3BLdUhhVW9ndkZ0K01hTUlHR25ucjJBa3lG?=
 =?utf-8?B?UTBuNkZpU1MvTmlwbFhMNDlVSW5hSXlvNTg1QlNzQnhNbXB5UnRDMzZpM1FH?=
 =?utf-8?B?Mlg5aGlVaVNwVHhDRGVmYTJYQ3pYU1ExTHRqV2pRT3ZPclg0UHhyQk1VUlJn?=
 =?utf-8?B?c29jMGcrcjhCa1JhdlV3cEl3SFh0d3RldWhtSEprRS85U0s4N1liaGJJeEFy?=
 =?utf-8?B?VTN0UVJlV3FNOSthTzhBYnc5K3d3aW5uRU85dUlOd3J4eTJjZkJubUJPRTJl?=
 =?utf-8?B?SnBBNmN5MWExZ3lobzZPcmI3SnVNTnhIS3Q5amdxeXUzNW92VnJWNGNWTWFu?=
 =?utf-8?B?bUtIQWYvNlNwenlrbTYwV2JQbENrYWJCbXNaQzNBdENaNFJUYUVBRzNpdmVZ?=
 =?utf-8?B?QnNrV3JDQ253NlNOOWpheDJ2S2p2TmpXSHdYNmtNd0hTWkRqeVJQQlM1NXFS?=
 =?utf-8?B?bDIxbE1ZSUVUbDJGdjFaamhCMG9Uak1YbDZBYWV1ZGdITnhnOEp0bi9aWk5y?=
 =?utf-8?B?eWJ0ODNQLzVNcjVMZFA1NXZrZEJFVmlwQVR2MTUyRk42MVF2NEZCcDdZR1Vk?=
 =?utf-8?B?UTM0NnRSQ0dwWVZHQlN2YmZvc2k1Wmhvam5TVjhGNXI1eVlyMGgraHlpalls?=
 =?utf-8?B?NmdHNkFtM0tKdWJBM2R1c1hqZWE0d3BqVkl5SjBnbmY1QkhCS2tSUUt1UUV6?=
 =?utf-8?B?aUp0L3VuUlhMUGNFRm51L3QrNUZvMWJYbTdTbEd5a2g0RGg5eVVsdFFvRkR1?=
 =?utf-8?B?c2h1YXZVamNjOXR5V1BIaFFOYXhlNGtPcFdFR1M4bzc5N1o4MnliMDZnU3Bn?=
 =?utf-8?B?M0MvS1UwZTNMd2FpaGptSHVJV2lNcUwvdGE2NHRLa3pPak9sM1VLQnhXL2c3?=
 =?utf-8?B?WXJtWjBEanpDbytSa2VxN3VWbFpMVExQNVU0OFVkRjA5WmhLdHVaV1R2dFVl?=
 =?utf-8?B?VkZITHBrSzA2WUpJRTRKSXlYSFFkZFVCNk9Bb1hGR24rMkVoL3cxRUVoQ0hl?=
 =?utf-8?B?MDRMbGVTdkdFZlRtTWpDQy9sNEJNejNFK3o4MkZkN1hBRmZtUkNpL2M0akRv?=
 =?utf-8?B?eGhHVFJZYWRVdDNmK3BjTCtzM3J6UXkyeDFmMkd2UW02SWdsWGhyUEVZSHpV?=
 =?utf-8?B?ODdtOXZqbjQzdnNWcTNHd2pHd2lRQzFpNUVqK3NaNEFDS1hlUDFza2Y1TWo1?=
 =?utf-8?B?c21TUy8waWNFR2hGMzRqa3J5Tm1tRGV5TnlPUHo2TURNS0gzK1dNWnU0d3RO?=
 =?utf-8?B?Z3YzamJuVzRFblZpbmd6cXpXY2JONTh4ODd1Q01aNVNDWGVyOHRvTEF4TWxJ?=
 =?utf-8?B?V1FKNXlrR0xlVGpRSlkzelFLRzA5aGtpei9BWUwxR2pJQ3JNMWgvclpDM1I3?=
 =?utf-8?B?OEJnN0J2aEpoWXFyTXdjWWNFMDEyZ1BGdVZNbW5VSmlXK2xObUVrM3NDTWI0?=
 =?utf-8?Q?wHS3VEYH+Cs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nytva3cwc1ZHVG4wcFZZaldTL0M4SEpEbnpOVkx3N1FHU2JGNXZ3SFpqZ0xm?=
 =?utf-8?B?Zzl2WUJlc2EzQ0ZEZEk0VXlUVUZzWDg3NEFTbGhZWUZzUTBobkNtSEhaNmNq?=
 =?utf-8?B?QjNRaVYyamZ2Y0xLQnRWVk5FaHZiTElGc3N4eWw4WHVIZDdOVzRaeW9CdmND?=
 =?utf-8?B?eUdCWTBWSmdZUGpHemZ1WXc2SW9oZWxjSytRSTQ4NWZYK1puZzZ1cmh0ZTgy?=
 =?utf-8?B?ZXI4dHduOXhFVC9CTEhpdEU1OEEwNjk3MlBwdFRtL2RDZ0hpNGYyNUo5R04v?=
 =?utf-8?B?UTYvTGxwOVJxSHJpRFN5K3BDN0Q1TXV5VjJqYkFxZUw1OTJnZTRnS3hwU2M3?=
 =?utf-8?B?QmdTdGJDeFZieHVNTEtPNTZHbm9ObWxNaFR0blhaWlZ5S2tVNUNzem1LQlRa?=
 =?utf-8?B?UU4zWDlvelI0TkIxc3ZRQndQK2dNeGVHZWFKd0ZCR0lNZ0o0UDJWY3FkODN5?=
 =?utf-8?B?NzRTbGF0QWNDZGFjOFJwakwrc2hya2xyV0hLekRFL0kvZkFlVkx5Y2JEY1gz?=
 =?utf-8?B?QkFyTGg1OUdncnB3YVJJNUFVVDVsU24yKy9pZjd3TjZxS1Zma1hiNmlUenNN?=
 =?utf-8?B?cFFwS0pQckZQajhHb1l4d2VycENKYnV2S1MwWVY2Q2RzczFsVHpSQVdFTnRI?=
 =?utf-8?B?L2lhWVJPRng0MXY0TTVWbFYyQk5sS1RYbUJNTS9YNmF5TFVlVlIxYlAybUxT?=
 =?utf-8?B?WmkveVkzU1U3RUp2d210T3lIZ2gyOUIraGZiUS9ndWcza0g2empQK3VVRTBB?=
 =?utf-8?B?QXFZcW03QVNLd003V1hOSTJ4U29BZEJWRWxxTlhVMlVqZ1BkRFMyL3o2cE1J?=
 =?utf-8?B?S3lvQ21UbmU1K2tkQm9hVWs1b2dJamRIYnpVc3o1dG94ZFdIVE0xWUE2di83?=
 =?utf-8?B?RHRpaElEeW9hcVUyME54UTBST25WTUMxM2MvWGpOMjdyZTRhdnNvb09wN1RK?=
 =?utf-8?B?OTllMTlyREh1V2syMFdoOXl3bGpCeGFQN3FpSVJVMVJBN2kxSm5KMkVxK21n?=
 =?utf-8?B?cjhWUUlWbHNQQkxyUzJMWlhYYytnNCtQZVk5eTB2SjVpMFFwd1g2ZVoxQTdl?=
 =?utf-8?B?VTFGVjdBUGNqc3J1V2ZjTnlYbzBPTFdoTHVzUTFuQVhrSWpYb2NPSHF1dDAw?=
 =?utf-8?B?aDJQelJPQ251QjcraUJROHR5Wlh0WDF2SzNvV1J5RERtNGRmdWZlM2JiS0Zh?=
 =?utf-8?B?NUpMczFZRVdObWNhbG5hUXhMb3V4ZnBnTUVSbGQxNmpKaldYVGxPV25QZWdS?=
 =?utf-8?B?QkZUUWRXOURQbXBjOExkVFlQZ1hUODJpenozUWNiRUlNZ2hmODArbWRHWjBH?=
 =?utf-8?B?UUM5TVp2MkJNOVcyK1RPZGNuNi9mUVl0WnA1YlZwUUt0dEdHRWV4M3c5OVg0?=
 =?utf-8?B?L0dtREtISW04dUd0aGFFdjNlUnZxZXZsS0dSZk55SXBrL2pRNWVIWTdXcEhS?=
 =?utf-8?B?d1k2Q0F1T3FhK2lLUmg3MS9aangwWFNrZFkrcFk1VTRuRmswdnFaRzJyVG1N?=
 =?utf-8?B?cDVQTmU4WFdLdVNPSGl5cld6VmtRcFk0VWgxdDZtUW00aG42NjdVSzl2cG51?=
 =?utf-8?B?bGtKWWpqU3ZSWDhGTW9UZDdETDZoUFBPTmgzQTB0K1AyMXRwb3dxUm5xYlU5?=
 =?utf-8?B?THM2WGRnMW9uOWpGMUs4anhOUFZRV3dVRlBFcW5OTDJSNzJMRUVIclhlWlpQ?=
 =?utf-8?B?TlJYMFdZRFZLNVU0Y3lidWpKSXVDdERsN3VzbjBLMUladVh2T3BobnYxRmgx?=
 =?utf-8?B?RFE3TG93WUJ6dVVhQlQzOFF3ZTJnYmpEZS9DaUtERjVWS01zQm80bDlaMzdk?=
 =?utf-8?B?RVRuOGtUSTRMVkNIeVdhRVVUcXlrRDByVjVTR0RHdkV1dStPSFZaVlQ3NnNE?=
 =?utf-8?B?T0l0NXo0MDRhcTV0bDFjWFU1WmtlYlpScU1GZThHN0t0SkxZRFlWeXZIdndk?=
 =?utf-8?B?UVgzNm8rN1FWK1ZxWVkvdk9WaVE3ZkFteC9NZkQ0V0RWdVZIL3JnZDRaaTZM?=
 =?utf-8?B?UXU0OGYyU2x1Y3pUVTFnOVhudGRyVHVUQ3NSR2oySWFNalJqOTg4Y0JMcUZD?=
 =?utf-8?B?UlJadVBicmxyakYxQXd4My8yRFByN25uYTRpbFVNbjhUN0pmc2hHdmRVdEFI?=
 =?utf-8?B?cVNFZkZUc3lmbllTM2FKWlhqc0NsRWtUNUxUK2k3YllnSHM5bzZFM05TakZl?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d597b966-dd07-4633-b1fc-08dd873b3164
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:30:45.9928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM8sl4uUlSVkOJBdWWIW0U0+ZcKAmt9uXme9CJJqydyoxcyB5W4yIITVBeQ6+k3BABUJtIDqG7pU602w3v3CgKKCVIv1HXek47+9bdw9rbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10323
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:00:22 +0200
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

Hi Chen-Yu,

On 4/29/25 5:44 PM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
> SoCs. This controller is used for the SD card on all SoCs and eMMC on
> older SoCs. Almost all defconfigs for Rockchip platforms have this
> enabled.
> 
> Enable it by default for all supported Rockchip SoCs. Disable it
> explicitly in defconfigs that previously didn't have it enabled.
> 

I'll let Tom confirm (or not), but I think it'd make sense to make this 
patch lighter by not including the defconfig changes that would be 
simply done automatically when doing a defconfig sync, e.g. like 
bdf41fb7b386bdf60303b7a92431467c12779c86 did? This would be nice because 
it would make your patch much easier to apply if they take long to be 
applied (e.g. someone else changes the defconfig and now we have 
conflicts all over the place). This also would remove unrelated changes 
from the diff, specifically the ones for the PX30 boards which are just 
noise at this point.

[...]

> diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
> index 3eb5dc968af6..92676ebb984a 100644
> --- a/configs/coolpi-cm5-genbook-rk3588_defconfig
> +++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
> @@ -65,6 +65,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
>   CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
>   CONFIG_MMC_HS400_SUPPORT=y
>   CONFIG_SPL_MMC_HS400_SUPPORT=y
> +# CONFIG_MMC_DW is not set
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_ROCKCHIP=y

Checked that and sdmmc and sio both seems to be disabled in the DTS, so 
makes sense to have the driver disabled too.

[...]

> diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
> index 46b949531017..d23f90a6a606 100644
> --- a/configs/evb-rv1108_defconfig
> +++ b/configs/evb-rv1108_defconfig
> @@ -31,6 +31,7 @@ CONFIG_FASTBOOT_BUF_SIZE=0x08000000
>   CONFIG_FASTBOOT_FLASH_MMC_DEV=1
>   CONFIG_ROCKCHIP_GPIO=y
>   CONFIG_SYS_I2C_ROCKCHIP=y
> +# CONFIG_MMC_DW is not set
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y

This one seems to be a mistake, sdmmc is enabled and is supported by 
this driver as far as I know. A separate patch to enable it 
(before/after this one, would be nice).

[...]

> diff --git a/configs/geekbox_defconfig b/configs/geekbox_defconfig
> index 80f91de7a11d..9dc642dc4ad9 100644
> --- a/configs/geekbox_defconfig
> +++ b/configs/geekbox_defconfig
> @@ -22,6 +22,7 @@ CONFIG_REGMAP=y
>   CONFIG_SYSCON=y
>   CONFIG_BOUNCE_BUFFER=y
>   CONFIG_CLK=y
> +# CONFIG_MMC_DW is not set
>   CONFIG_PINCTRL=y
>   CONFIG_RAM=y
>   CONFIG_DEBUG_UART_SHIFT=2

This one seems to be a mistake, emmc is enabled and is supported by this 
driver as far as I know. A separate patch to enable it (before/after 
this one, would be nice).

[...]

> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 6740591a6533..f2f0e7dbe601 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -251,6 +251,7 @@ config MMC_DAVINCI
>   config MMC_DW
>   	bool "Synopsys DesignWare Memory Card Interface"
>   	select BOUNCE_BUFFER
> +	default y if ARCH_ROCKCHIP
>   	help
>   	  This selects support for the Synopsys DesignWare Mobile Storage IP
>   	  block, this provides host support for SD and MMC interfaces, in both
> @@ -286,6 +287,7 @@ config MMC_DW_ROCKCHIP
>   	bool "Rockchip SD/MMC controller support"
>   	depends on OF_CONTROL
>   	depends on MMC_DW
> +	default y

default y if ARCH_ROCKCHIP

maybe? To avoid boards from other vendors to have to disable it?

Cheers,
Quentin
