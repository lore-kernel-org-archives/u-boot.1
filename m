Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690A5C3ABAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0526482AA8;
	Tue, 29 Apr 2025 19:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ljGCrlnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2CDC82A76; Tue, 29 Apr 2025 19:41:03 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 514FE829A1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 19:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoFnvBJ2fw+trgbAvGpWqUNeK0EGU0Nmxlw3G6UzXKKYOVE0sjWLVRU9NF5+04COsfQhTrQoXUCZn9+9RdybBAQ/WLiPRJ7T2SYI9yJi7VxfbsCKLhO2xhei1HKFeXIf2TVy2aXV816UQKqCkpRdVZgPkeJJChzjtWwZwqok1Vd1jAXZ5+XvUp/vWpb12iKkInyOREkSATaUguB2NjEPZYZvnGbpS7YV0/MgQ0LykdpkdNNuKW1yNo1KAW9V3zw7UBG/HZg9WrrWjLkd6Fim55ACq6Hk2ZDKW+OL16bI4jQN8NKpBXw24H98vHLvr93COvN7TLj+JyaMBuz8a+5gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR0Jn2pdcuOqOcRRaxXbwI0G81bpj47zokSZOYObhQ4=;
 b=bCr6SHX5XWNkP3NavLTpO0qtOIXXNEMQAgxrNefH0LgrlUNKuhFIQe9+uheoXnEHn0Iypf4p9JXchJ91xAG81OQgNKdrPkSrrfNaCqmkf/yQ/gJ5cOkM1oI5pWyXWAWSLXK6kI4mVN4vHnqjtjqC6eawN0u1jp6mEPfN+lMTeGHFEeeEh4VgQLxHmT/4VsCPni3nGcHAKC9fIBlCM2CgnXo6gi5qgJPwSl7CFTUTlYfwY0DUXg21UejAizoHhYsDF7QQv0qQwbDtwlAMGs3mFg0No8utBX3pMB/7yb72JEO/pnL0vvDDcchRGIC87AyCpvYLLAJkCGmYvePLAvBU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR0Jn2pdcuOqOcRRaxXbwI0G81bpj47zokSZOYObhQ4=;
 b=ljGCrlnjUYY3jxrg8RG9mRxtrcVPwpsCi1TLVzr6t0e91ZV/3TyX30eEHXu9hmXShcl4Yz7rv1Ns9GNCwHb1Wmkv+tsfKclafM5128qB5tfDZjZ1q8XCnzCioplqUreQt7ifWh6nVodZtrnSLcZepM82WbYriE3iCl2b2GNktkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VE1PR04MB7341.eurprd04.prod.outlook.com (2603:10a6:800:1a6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 17:40:58 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%6]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 17:40:57 +0000
Message-ID: <94b62760-8a2d-41be-895e-6d3cb10b2dd3@cherry.de>
Date: Tue, 29 Apr 2025 19:40:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: rockchip_dw_mmc: Enable by default for all
 supported SoCs
To: wens@kernel.org
Cc: u-boot@lists.denx.de, Akash Gajjar <gajjar04akash@gmail.com>,
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
 <e4607f73-2d94-41c7-af35-bb94dcc5c336@cherry.de>
 <CAGb2v65WWPSD2Z12uxUCrgPu5C4e9uBfHouB4JDaFw5AB1ed-A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAGb2v65WWPSD2Z12uxUCrgPu5C4e9uBfHouB4JDaFw5AB1ed-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0378.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VE1PR04MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 96f55f12-951a-4595-d3af-08dd8744ffd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Umx2ODZObUVqM1ZHTnE4NmwrOVBraWw3RWN4NjdOZ1VHbDlGZ2tGUDJOZmNi?=
 =?utf-8?B?SmVNNHhyMFgwRTh5eGdPZ2ZuY0RpT0VBb2h1TjRSaVh3N000MnQydGxscVlm?=
 =?utf-8?B?RDJndFNOQWxVR01pRS9JTGN5TkR0bDJrQkVuTTNleFdiYnV4bDA0YXJETk5I?=
 =?utf-8?B?WnB2YXFmMXYvcXRaOUpBMjhhd3NmQktudkp0Y1pFTTBPVGhNT05UMy9jWk92?=
 =?utf-8?B?V0xJWE9MclRzVHFZVkVjZm1hRGxlN1ZTVlhvVlZJYUlGWFA4NVY4NVBvaXJL?=
 =?utf-8?B?RWVNSkVrS0lDNTIrOGZ6czhhRXRKNG1aamNSS3hGb1ltVlcvbmU1dm5odmRU?=
 =?utf-8?B?UUl2VUkrUW1FdWN5Q1Q2SmFpZ01jblQ1Zm52S0lkQ3pld3VoU0w3SFZxQ2JP?=
 =?utf-8?B?VWE3WEpHM2c5U0h0Ujl4VUpER2ZXWjVxbFdYUU9NbVVNeVI5a29VKzZjRE1i?=
 =?utf-8?B?Zjc4cFEyWVYwd2ZyMkRNbE5BYk1hc2R0MzBXc1c2eVg2S0puUTEvRGdzaUZ1?=
 =?utf-8?B?T1NCcG85SmJRbCtqQkl0ZzBPUENaYUVXMS9JeW1Gcndqb3Yvam80ZkMvUFZk?=
 =?utf-8?B?V0ZZTlZnWnNTcnB4Sm8ySlhWSERheFdiVkoxWTUwMXV2U2YvTUlXbVQwS1Ev?=
 =?utf-8?B?dDBkWXQxcytWV29IUmlvajh1T1RnK21FR0lMMVNkcEl6OEJJN2I4c0hjZWVR?=
 =?utf-8?B?UmpRZDVyRTJhZDVLQ2p2c0k0endPY3g2VXNjM1RGcmdNZTdKVmVZa1UwNFRp?=
 =?utf-8?B?cUYzL0tiNnplMlJOK0FMVUZrdW1WV2toWENqcXpXRkliK1puRDZKNklFUHJX?=
 =?utf-8?B?U3FJOU9ab3BZUkw4VFpoSHJaTUpzL04xRzhVcUh2dzBndTh4QWM0QlQ2MS9y?=
 =?utf-8?B?WEtHczlBSnpHY3FLenVySzh2dHRnbmhRQ0ZjWFk2WEZsYXN5Z3c3a0JWK1dB?=
 =?utf-8?B?dzNqUkNRWXhCSlBJUVIvUWk1Z0RFN254SHJnVXEybWRhU0pidlNnQ3ptVjFH?=
 =?utf-8?B?VmxFUUNqZ0FLaVBkZm9weDN0SW1pTlgrM2JVdi95ampOV3pHMFEvWWIvSFF3?=
 =?utf-8?B?NXQ3WjByTjEzbVMxaWMxRVBQa3picjl4ZFlNb3FHNGxNOHV2MXo1b3NqT1M1?=
 =?utf-8?B?bFduV21yZDh2dEI0Y3ZHWFB0QXFmZk9zU1c4ZGIzcXQ5cHE0aFlJMGdhanQ3?=
 =?utf-8?B?TG8wcVJwZ3p6M201a0NIdHVkL20zMlJFUTJKc1Z1eSttNll5R2Y2VHhjak1D?=
 =?utf-8?B?MWcvME5PRVpQbWVZS1k4Rmd5SHpndlNaUmZ1OU1hOGdPQVg0TGZzUnlLUWRC?=
 =?utf-8?B?NXprMW5sNDVrZDlOTkswMkRENkRWaWNVLzMzSHVDelBSMUxDOVRDWjZsemhR?=
 =?utf-8?B?MzZzT3dsWG9sNHA0ZS9Ha1JCeUlyVHhRVWdzU2gwRVhNVUwra3RuSGNCSFRW?=
 =?utf-8?B?bTZQWjMvdGNZMVpwVjJrMzdhazIyZjdIQlg1aktHWnM0dEdqbkkzdkxxcGl2?=
 =?utf-8?B?T2JEQTI3NFp4Mk05cEVmdG1XWjRrQUhvam5YWnZIMVgrWEJjT1E5SE1GS0p6?=
 =?utf-8?B?WHBzMk1lbS9zZjFicnlCUFNUVDZQRDdESEpwdzRCNFhSalRCZDNSWUZuSjlO?=
 =?utf-8?B?NzdGbE9VUHJUZXpJMS9tNFVMWWtQYWhySi9mZmlTN3Arc2xmT3BIbG9haEU4?=
 =?utf-8?B?ZW1WZHdKMEwrdVpBVldUb0hFTkFaSHlRNEltUmw3ZzRsZWRXTk1IWitKVHVM?=
 =?utf-8?B?dG1MUWJOK2RWYmd6Q0ZuL3E0UGV3UUxiWldhMCtNeEVkM21UWVZ5dmk3VVJV?=
 =?utf-8?B?TU80SDVaVWJiSHNzejNmWlI5N2hlbzhYM1ZZWm4zc2czSURvaXZkNncxWFk1?=
 =?utf-8?B?ejdTSmR2cFZraTBhZHVBclNFc1JBOG1yb0xXZmE5SkptYnBQMk0zbDNPa0Y0?=
 =?utf-8?Q?Km6+bYHEhLY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzYwZmtaZDdsZWcrWlRNL1VjbS9rUDNleHcrWU5VbzlFc1RGUHJyUnlOZWlX?=
 =?utf-8?B?UStJdmlvTWxqOGZpcS9XU3U3eUNmbHN1b0UrL0YzRU0yZ1hLT08xbnEvMGhF?=
 =?utf-8?B?eHIrOVM0MUp5VHNKMDkyL1QzM1lybElRN0Q2c2llcTlRaWxTcnRjRCs5bWVn?=
 =?utf-8?B?OHNjYW5MdzZEZFQ0OTlxdWROclV1dDVteGIxa08rVW9rVzFZMlRnbnFKTlFK?=
 =?utf-8?B?bUxOOTkrQWZmNlUxNWlVekVyT1NyQXdOZWV3L2M1VHRGMnJVZE14OW5WN1Rj?=
 =?utf-8?B?Q3Y0VEo3RHVPZ1RmckhpdVp0elZrQlJnZzM0NHBaOHNOQzJmYS9BYlExYys4?=
 =?utf-8?B?WlhJUTVESWVScksrY3NQa0M0QWdVV1VpcjJMNk5jSUZzSmdZaHp3UTN1eENr?=
 =?utf-8?B?a3dBWFRuT2FnVnVjQ2dqa2Y4WGpJbFkyWWg1azZjQVZjUGpMOGRmOFVER1ht?=
 =?utf-8?B?NFYrQ3dBdTNrVVExcTlyNTRUemNLYTJENDQwOEFIa0h4dHhLeE11eHBBNWg1?=
 =?utf-8?B?WHlKN1ZlYU1TNS9lSHFiYlhvS0psdytvZ3pJSi94KzNwZUlocTltbGo0Mmdy?=
 =?utf-8?B?MVEyUGIyOS9BazVvcTFwcWdPbGJrUUNRSXFBc0wweVE5dnlRRjNFTGovbjZJ?=
 =?utf-8?B?eXdWZmZxUUFiUEVvQzVpTTdHU1g3MEpmbVg1bnJEekE5SW94aW51UWZQTk1n?=
 =?utf-8?B?dmY1VGNmZ0xBRUZvbktxRzlNcTU4UXBCSkpnd1NBSzdBQzd3VVVCU3ltQTMy?=
 =?utf-8?B?dHpCdW5QRml6M0xQa1A5ZHhkakpvRHNibThJWThEaGkxNEUvaUFuWGxGSzBV?=
 =?utf-8?B?NWxBVkJ0MXhYcGVGaWpEcS9VM29xWWp2TFZUam00MzhuckhLWHpWQzZYQjlX?=
 =?utf-8?B?NnZ3MjhaSjJUZm83a2p4SEtORC9RWWlxU2paZDhQNkQ5bVlibWJhMEFPOHJy?=
 =?utf-8?B?cTdHekhSU3RhOWcyZDRNb0pjS0IrUVBrQmozSC9CK3FtcndVWTFuQjQ5dFZP?=
 =?utf-8?B?VStSM21teXFXZStxc1VEeENMS1B0RGxwaU83bXZNUHh0OUVWSjBQcVFva2Zk?=
 =?utf-8?B?N3hybE5IVkw0QS9JeXgwMG5BS0dmRGQ3ZERKT1RtTldUbHFGbGZiSExuQVFX?=
 =?utf-8?B?MFBPazdjTTZpUVpxU2ZNQ1Q0Rm9PQWNwYWlJQmVGbkh1cXVYTmFsQ1IxMU9q?=
 =?utf-8?B?L0wrQTRxelJ5MEhUcUlIWXp4Vm0zUHNHQXI2T0dpT1I2ajFBeFh2ZmEvZmww?=
 =?utf-8?B?aEE3MnpoNnJMVUo2WWIzMWtzSVZNSFFoWlRDbm5SQUpYMlpXZkkwbGpZMktO?=
 =?utf-8?B?YnRmeHVMRS9Ub2tlRzdLWVNMbjdKY0R5RXJFQWU4SE56cmdmNCswdkhPU3NE?=
 =?utf-8?B?c1ZnZlB4ek1XUnNvYU1mZDRKVHRxaW9BQ3lKbmI0R1J2M3hXdExJRUZ5TUZs?=
 =?utf-8?B?VTdhOXNRSG0rdURWak1hTDlLejM5VjVmVVFwQjYwQUR2Z1VCbG5KczdRdHZv?=
 =?utf-8?B?bkNLRldKVDg2TWQzUUJwWWQ2VEFON1Y5MVNWWk44MXJ4NGdLTXVvRHRBRjVy?=
 =?utf-8?B?NmlYWGh4aVE0KzhBMnlWa0hhZXJJTXVwMWhsTWRNaGJnWFpQOURBVUg3aFln?=
 =?utf-8?B?bGdUeVl5THJoVWZaTnlTMGdXMitLWUJwRDR3bDM1OUN1cXlVcmZqaUYvU29u?=
 =?utf-8?B?NjZvVHJRQmRJSjJmOVNKaTgzV1JCUkx6OG1iV0RDc0FIenVlM3FOL3gxU3Mz?=
 =?utf-8?B?V20vME1tN1hYaVJINDh4K0IwRlkyalVERWNSYmF5OFpQY2xBc3M2TGQyL3Vv?=
 =?utf-8?B?TnFaOGF3dUg2QVV2b3RncE5UQjdDMFU3Y1UwSmlvK1NvZmMwalNtcE10citO?=
 =?utf-8?B?ejQ3eVZ0Z3gxV2tVeHJTWFNRMlBwaHlDbUQyY0JYamZsdWdnZm5DNzVVeG5C?=
 =?utf-8?B?MjVreGd4L29nR21CemxDYTZSbXJlRmN3Yks2c1FCWURrRE85QStFck9xSWl6?=
 =?utf-8?B?bThzbngrcHlDQld2NmtZSHZBR1VtTExIMytacUQ4eVhUUWpLR1JXTWc1K0JT?=
 =?utf-8?B?NDNzZFlMd2RDV212bjFLb2Z4eDkxaTNnYXd0NkVhajlzYzZSb3BqSHUrN0Q1?=
 =?utf-8?B?cGJqRHdka2tzYk5BUTJsVFZ6QnIvdjc3QUpwT20rbFU3SVhmNnpyTUg0Y3VF?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f55f12-951a-4595-d3af-08dd8744ffd2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 17:40:57.8308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPd/p3lAk/2h+FO08HIrWF89McsOU6gKVr1OvXIGmckGvHCMPanfrNgnnJf4aedWj3Ud1wF8mswXYxsOqHwVtzYbA49QMDCFaTlGnuvH5vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7341
X-Mailman-Approved-At: Tue, 29 Apr 2025 19:44:02 +0200
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

On 4/29/25 7:34 PM, Chen-Yu Tsai wrote:
> On Wed, Apr 30, 2025 at 12:30 AM Quentin Schulz
> <quentin.schulz@cherry.de> wrote:
>>
>> Hi Chen-Yu,
>>
>> On 4/29/25 5:44 PM, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> The rockchip_dw_mmc driver supports the MMC controller found in Rockchip
>>> SoCs. This controller is used for the SD card on all SoCs and eMMC on
>>> older SoCs. Almost all defconfigs for Rockchip platforms have this
>>> enabled.
>>>
>>> Enable it by default for all supported Rockchip SoCs. Disable it
>>> explicitly in defconfigs that previously didn't have it enabled.
>>>
>>
>> I'll let Tom confirm (or not), but I think it'd make sense to make this
>> patch lighter by not including the defconfig changes that would be
>> simply done automatically when doing a defconfig sync, e.g. like
>> bdf41fb7b386bdf60303b7a92431467c12779c86 did? This would be nice because
>> it would make your patch much easier to apply if they take long to be
>> applied (e.g. someone else changes the defconfig and now we have
>> conflicts all over the place). This also would remove unrelated changes
>> from the diff, specifically the ones for the PX30 boards which are just
>> noise at this point.
>>
>> [...]
>>
>>> diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
>>> index 3eb5dc968af6..92676ebb984a 100644
>>> --- a/configs/coolpi-cm5-genbook-rk3588_defconfig
>>> +++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
>>> @@ -65,6 +65,7 @@ CONFIG_MMC_HS400_ES_SUPPORT=y
>>>    CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
>>>    CONFIG_MMC_HS400_SUPPORT=y
>>>    CONFIG_SPL_MMC_HS400_SUPPORT=y
>>> +# CONFIG_MMC_DW is not set
>>>    CONFIG_MMC_SDHCI=y
>>>    CONFIG_MMC_SDHCI_SDMA=y
>>>    CONFIG_MMC_SDHCI_ROCKCHIP=y
>>
>> Checked that and sdmmc and sio both seems to be disabled in the DTS, so
>> makes sense to have the driver disabled too.
>>
>> [...]
>>
>>> diff --git a/configs/evb-rv1108_defconfig b/configs/evb-rv1108_defconfig
>>> index 46b949531017..d23f90a6a606 100644
>>> --- a/configs/evb-rv1108_defconfig
>>> +++ b/configs/evb-rv1108_defconfig
>>> @@ -31,6 +31,7 @@ CONFIG_FASTBOOT_BUF_SIZE=0x08000000
>>>    CONFIG_FASTBOOT_FLASH_MMC_DEV=1
>>>    CONFIG_ROCKCHIP_GPIO=y
>>>    CONFIG_SYS_I2C_ROCKCHIP=y
>>> +# CONFIG_MMC_DW is not set
>>>    CONFIG_SPI_FLASH_GIGADEVICE=y
>>>    CONFIG_SPI_FLASH_WINBOND=y
>>>    CONFIG_SPI_FLASH_MTD=y
>>
>> This one seems to be a mistake, sdmmc is enabled and is supported by
>> this driver as far as I know. A separate patch to enable it
>> (before/after this one, would be nice).
> 
> After the patch it would be enabled by default, so nothing actually
> has to be done? I can mention in the commit message that this one
> and the Geekbox are intentionally enabled by default after the
> patch since the DTS have them enabled.
> 

I don't like hidden changes like those, even if documented. Makes 
bisecting/reverting harder in my opinion. I would rather have a separate 
commit(s) fixing this honestly.

[...]

>>> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>>> index 6740591a6533..f2f0e7dbe601 100644
>>> --- a/drivers/mmc/Kconfig
>>> +++ b/drivers/mmc/Kconfig
>>> @@ -251,6 +251,7 @@ config MMC_DAVINCI
>>>    config MMC_DW
>>>        bool "Synopsys DesignWare Memory Card Interface"
>>>        select BOUNCE_BUFFER
>>> +     default y if ARCH_ROCKCHIP
>>>        help
>>>          This selects support for the Synopsys DesignWare Mobile Storage IP
>>>          block, this provides host support for SD and MMC interfaces, in both
>>> @@ -286,6 +287,7 @@ config MMC_DW_ROCKCHIP
>>>        bool "Rockchip SD/MMC controller support"
>>>        depends on OF_CONTROL
>>>        depends on MMC_DW
>>> +     default y
>>
>> default y if ARCH_ROCKCHIP
>>
>> maybe? To avoid boards from other vendors to have to disable it?
> 
> Oops, I missed this.
> 
> I think
> 
>      depends on ARCH_ROCKCHIP
>      default y
> 
> would make more sense, and also match the platform-specific options
> for the other platforms.
> 
> What do you think?
> 

Makes sense to me, to align with MMC_SDHCI_ROCKCHIP. A separate commit 
for the "depends on" addition would be welcome though, I believe?

Cheers,
Quentin
