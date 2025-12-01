Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375EBD111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 10:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ABD83A24;
	Mon,  1 Dec 2025 11:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="P1c9ItoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A804683AA4; Mon,  1 Dec 2025 11:42:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201FE839D7
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 11:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VA4uJyPFizxKnPEgmxTJzasSxmsM2VrnXEoC8rZqw4BaVQOBPZLUkGzKaf2p3fkyX8qc+2Ip6dR932iTXzB551FkHMJPFWk3yf03b9YhzK69lcLphmJHJdwdC4AOvvdtMPWtgx499KLjpBsRTGCCs9UQgu9K/vOqMVJCJl1U1Adu6KYVF8Ka9b3o8ZVkcMI3KlzJ3iDt1ZxtSRqimoemcxILh6dFMu9MvczfSnrLF+JHEAz+1EQgfrzeH+eDXQnJCt3/K6B4Pui66ngz2DTPH53YVnYL8CkEYLGz7oLrb7BMhpo3MG7ANztnNE/eVR6bc0AmBgXmMGLYrm9WZk4Biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9BPXnhHSWDxw98U8zpGizeDvDBr34Rkc/QTkEG9cso=;
 b=ihj0t77yN8MeP95KGKGQqUs+wWkj7aPpnQS/Q4zZyM7exk+WXSK7jtONHQiOHLvs7CuDROB8LeulVcmWQQmveru4yHzMvC+cwIkXeqG2YyZhrIIV6e4fEsgE+ZYXssehMZSFV2+GN871s1aXvRkQ4grDlltQZBKrxZ7irpOYoHlHjCNhaI+KNg581q4aUWQo8mt7tEZ2Hzxp/qKInmcenUCY44XDzES5JGkyINw6/hqrjpXDK54uAKmD3bNsgob8VcqGA/TJZykDzdVlr1FmpW6KJXsfpSi+wLg0bXf9uv2Es5bTPCkKYDv3IJIvz4C0zn/tnvwjQvndBfG6Y7BGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9BPXnhHSWDxw98U8zpGizeDvDBr34Rkc/QTkEG9cso=;
 b=P1c9ItoIDCi0Ha8srZCwsyrwqi0hfkQgEWVY/yn/K7oGVZfn+dQC3imgARfC9hsSVf+Vqm4b6xsXvQnWETlobc3yg5NcXb62WNUJQZrxn9epdE3kF1A2JbAaeaXo9iT6TVnAS+ZnmYK7LYNafQf1oWnwCQs0A2qLrS7vmgbSM50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:42:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 10:42:12 +0000
Message-ID: <a9a4deea-4f53-4103-97f9-32d96177c6e1@cherry.de>
Date: Mon, 1 Dec 2025 11:40:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
 <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
 <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
 <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: f6649d75-094e-4513-b2d0-08de30c64934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk0zRDRWT2hSbUczQjQ4bklEUzNYdXhRZmJVWUpJUHYxT1hyU3VaNzE3OFdi?=
 =?utf-8?B?MnVuT0YveVp5U25xbkpnVTlmU1BCYURFaWlHQlZPWjlyLzdxc2hPZ0VodjBi?=
 =?utf-8?B?WXNDV3lUTkN3OXJnOTZwQ3ZlT2RkbWp0VGlOR1AzOXlMNzJLaEFkRzVyaG1V?=
 =?utf-8?B?R2tWc2FiVVNQcTVBeFg5bzFSOUR4Yi9EdmdUYktXMEpqQWhlR21WdVhoNFd1?=
 =?utf-8?B?Um5CK2Q3M1pjeWVYZE16NEVER1ZvMkwwbDUySThnQ0RlRzdZKzhDRXFIMDdt?=
 =?utf-8?B?RTMyaDZ2S09pMWZ6U2RpeXowdFIxdTBBZE52VlFvSzc3QnhicmZUeUM4NStn?=
 =?utf-8?B?NmZDQmhlT1RaaVVlVUdtV1dKYkZESjYwQUFHaGJkSi9HY1VlYk1DUVZubGQx?=
 =?utf-8?B?SzV0aTJoNkdENzFIQmhFQzZBTUJCcWVxWGlHNWV2bkg2ZHM1RXk3UDJWWUU3?=
 =?utf-8?B?S3dnU1Y3RGxyRUVRbVV2dTdiT1kzOFlwTTRrcTAzbnE5OTJRYUNUYUtKdlNr?=
 =?utf-8?B?amx0Z2craFRqd1hiTXRPc09WdmNadTk5ejhmVFlpbVZkOEE5NDZyUjBYdG5C?=
 =?utf-8?B?UExjRlloS3QzcGt6UXR3bFNnZHhQckcyOWovRHkzVWhNUEF4WHpJOWczT1A0?=
 =?utf-8?B?VzNTZWdhUUEvMVAzV2lNL250OWdtMzBGemVURUE5bUtDZVRSUG5BejNzS3RQ?=
 =?utf-8?B?Z3h2VkRoYnpKNHhNWEZIMVRDMzJGelVkM0s1QjN2L1diZ3ZPS1pvQTc0VEVV?=
 =?utf-8?B?QkxHQnNzdWgwbmpTbW5YemtXZ0RyemM5NENKZngyU1U3YWh2MU9NU0IwUHg1?=
 =?utf-8?B?ZXpSb1d1QlN3RjB0SlViajZmS3k5dFlNU3FoN0UxWWRCK2JBRHFZY0plZCt0?=
 =?utf-8?B?T281VUJ6MUp5WkZuNzFKWHc0cVJvNS9iYTJac2NZZlBvM3NKVnY1cW5qd3lF?=
 =?utf-8?B?VlF1eSs0N2ZkcmJtdEpRMjkrOVpqTlBHUEprUDJIbFcxbUFWNTE3S3hRajhK?=
 =?utf-8?B?SHd3VStsVUVQZFQ3UmV3Q2R1dFF4RDZYTlo2cXVOc2J0RDFvczQxaDI3QW0y?=
 =?utf-8?B?KzVxVldUUk1rd3I5Nndmc2F0bjhKRkpOTGNLYnQ4TWRTN1daSkNWY1pPcStR?=
 =?utf-8?B?emhjRFUreHRwQjlyRHY1VzFyblM5bmtLRVA0NUVsM2lYSjA5cTVEdWZPWHBs?=
 =?utf-8?B?MkVoM3k2WFExeGhQT2NoRFlRYk9Gc2tob1ZWWjVrN0dUdlVjUmp5VUZqM1hV?=
 =?utf-8?B?WnJlR2QwQ3cyREJWcHI4SUdNNUlxRGt4SWhBc0ZmcGdVakZWOWJLaCt2bHNY?=
 =?utf-8?B?dUcvTUlUZVFHbzNrVVJtVFMxemtOR2swQ1hiRjdMS1VlaWRDdUFLbG1Hc0w3?=
 =?utf-8?B?MHYvUlFvNXRVelU0Mk5DanhEcWZoWDhQaFdjb0VWU2F6MEN4aDBWWTgyTStH?=
 =?utf-8?B?UE1oQzBQWTdpSjd5TURqZFRZMU82cWIxSFF6NDMvVDIrMkJ2QnZvT3diNTdV?=
 =?utf-8?B?WHEvS1IvWDliU3FSN0F4RGlJd2tVMkVNUkFsNExIR0tvc21aUHZuQjRSZUNn?=
 =?utf-8?B?MVpaQmpEWVUvT1pNRDdzU2QrNXZtUlFxako0dkoydnZHQXJqaHoyTEtjNlZD?=
 =?utf-8?B?VExVVHFvakZJYTRHY1B5WjVxbUZiTFJFdTBXdEIyMjF5SHhpSXJObG1DL2pC?=
 =?utf-8?B?RkswT1Qrazd0dVNRRkwwWGhRUE1OMks3d3VzMk9ORGZsOTFsYWErT2w4NkFZ?=
 =?utf-8?B?c2VNMkZ2SlNhemZvaWRaL1JtWkg5T0ZWcGV3Y3VseUhoU01LL253azJnRExY?=
 =?utf-8?B?MFB4U0owdmpzRlRWN1ZYbHFMZ29uVitYd3M3SktlQ0QwcWpsSzV4T1JScWVQ?=
 =?utf-8?B?dHNwL1pZTTdOUXg2ZHAxclpjNERFamE2OXVESFRPT2RnTmxLc1ZIRlF3TTJT?=
 =?utf-8?Q?YWCfiqvRQSPNY9sqCiuHaLikFYkj5ETh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtKVDYydW9OcThHRTNpQmlWaXZsaC9HVURxaEVtNGNBQXk4cmhlVGNWTUll?=
 =?utf-8?B?dHJSdi9vYWR0VVhybjVnZmVtTXowYldleElqVDRJYUk1WnpTVlNoaWI0bDlH?=
 =?utf-8?B?bXExaURaSUZITUtPa0t5dDFQWGNLNHU3eHY0YWErWUlSd3hqem05dFhpM3Z6?=
 =?utf-8?B?WGpGeW0rWkc1bkREUEdDdWZYOW81dFVRYW9uelM5VkJveStxU2NMN3ZPbUhG?=
 =?utf-8?B?NWY1b3NmQmZ3T3ZBbVZBQ3k0Q3l4MHN2bXJkcHN3alF6VVVwakxVVG9JODBp?=
 =?utf-8?B?clVmc25HdkNWRUxZaGE2RUYzVzVoTjh3L3oyR3l1ejMwTjN2bkFSeDU3ckRa?=
 =?utf-8?B?MFJoMHEzdjRJamZUSG5UMUc5TkN3UjUxV0l3bm00M0xORmdUbm1pVXk0akNj?=
 =?utf-8?B?LzQ0K05JcWdRbGtCbmFDeUNMYXlwQXp3Tm5pQjRhL2NRRitwWnlLTjExcy9U?=
 =?utf-8?B?cjdFaE9NcmdqSUFxOERlL2dNVWVPbkttMTMvMlB2RWtiaTZLeHNmMVhzQlAr?=
 =?utf-8?B?L0JmWDd5dW1UUkFUUEZoYmVkVjBuNlVYM3VKOHpkMlNUT3ZqVHJkZFJrRG9E?=
 =?utf-8?B?bmtWeUpYeDZUNkJFSDN0dGYwbGhuRXh0bklLek1UNmg4UExIRkc1NUYrWnMr?=
 =?utf-8?B?WkU0ZXZwOUJxRzZqa2RSbFBVVDNZbHM1QUEvK2lmb1h5aytwcUMrb3hJUlJH?=
 =?utf-8?B?NDlmOVRaeU5TWmx6dGJ4a0dBUEtIS0xYWDBiNnZHdFdPNVgwNXQvME9yQWt5?=
 =?utf-8?B?QTgwZTZ6R1ZpZFFtTmZ1OHBUWStCU09PRm5GL3g3VDk2aVo3T1hLemlHK1ZZ?=
 =?utf-8?B?VEljZytncjdPclZqNXRMbHJEUWZQTUhSL1NkcEhvMzhzQmNaS3hkUlBPQnd6?=
 =?utf-8?B?SGVrNzNxcVhzNnVVdjBCdTUvenZMWkpkMkdjQWZLQ094TlB2VE9QWTFQSnFK?=
 =?utf-8?B?Y3dxQjBBODJ2M3AzN0hadTR5VnFuQkE0Y3ZNc1UzNVRFVk1tSEFqdDZoVHBn?=
 =?utf-8?B?OWdGT1FrcXIyREJUaFM4Zlhia284OVpLQTRnWHplQm1henpXT3RQRHFNUyta?=
 =?utf-8?B?OXBIZkhOSjhFWnFheGVHQS9SNk1LUDRjaklrZEs3MnorT285Z2IyRlVqVG9P?=
 =?utf-8?B?Z1VEVTZYdldxTVBkYXJkWUpUZVZ2eElPTStoS1FQWEx0R0sxa0hLbkFIWi9W?=
 =?utf-8?B?TmRXRGVyT245MUlWWGVxSjR5WGRGWW1yNjF2cktNY2dEZjlyRE05dm5lMmR5?=
 =?utf-8?B?b09mWHAzV1FtVWhtTlhYM2YvaWQ5ZXdPQzNDMDIyY3VoT0pWeHk2YnF4M0dQ?=
 =?utf-8?B?NWszYWNMTHBVNk9MaTd3VmVJUWdTbHlGRFhIcXlHa05LQmEyUmlaZ2VaanVp?=
 =?utf-8?B?QVc5dkhvWXFaN1g0Y0E1VXBzNHl5ZS9WcHo0a2tsaTk4Q3RvREdJdmt0Wm01?=
 =?utf-8?B?TWdYb0pMY0NtOGdMVHMzNmFTaVF6TWpnR1IxWEU0bE1hWmdIZm54WWl6WlRs?=
 =?utf-8?B?bzVxTVZUZW91cUcvVXIycU9FRzFzaWpaRkoyQTFOcG5TN0dRUWYyTVJZVTIz?=
 =?utf-8?B?QUwvUFRZd3d1ZXdCNXFOZks4UjZDQ0g3UVk3ZVlhNGdoR2g2SUE1SVprSnY0?=
 =?utf-8?B?TndSSnNiYkdxd1pxcFlCUTk2eGMvaTNlTTBkUkVob0h4RnpISEEveWppcHRD?=
 =?utf-8?B?c0k2ODA3Q3A1WFpkNEQxRHRaakFpeHlNNmVpSGp4dlpBMElaOVBvc1RaZEJ1?=
 =?utf-8?B?VVVOc21WbFpvU0FVc09DdGZMbVpoQlNNQUlOSVhqS3EzWDhLRUpKL2tpbEhH?=
 =?utf-8?B?aVQvYldmTDE2QW0vZ1gwU25YMU0wN1M2d1V0YVMvaDhTK2NUSEo5L3Y2UVBS?=
 =?utf-8?B?UWFaTWNzdlNhYzRVa0d2a2JXZkpXdGIrYzVVVHVVVTBWb0xOOURmYmVaaWdR?=
 =?utf-8?B?WXlqdFJQNXdtbXpPYzlwSDBOSnhWdW5yWUo2eXRueVdpZkl3Q0Q4cDMrMkoy?=
 =?utf-8?B?TFhNK1ZxOWdXeTV0a1B0cUxvbS9HcHVoQ2xBK1RicFloVzBGNXNRVEhIN1oy?=
 =?utf-8?B?TlpOblVkdGFxZTNwMG1tVW9FNzhweEQ4cWVBQS9Jbkpmb01OR253MGlYajlU?=
 =?utf-8?B?R2tleGowNGI4dnFJNnpqc21nbjBSZlhFOXdGRGl6Z1VHN2hJdzZycDVka2cz?=
 =?utf-8?Q?iAFlEg7IarL+zTwQEXOzopA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f6649d75-094e-4513-b2d0-08de30c64934
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:42:12.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+i4SkYd2anvhcaEVZuQuu+AsVUrdFcAuJpH8O7qnAbR34WlQD2sSkDD8Oa0lNSVOPAsbbrlrLSnwukl/VDQv5fpjcDDUKJlIQuSAvL7mw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898
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

On 11/30/25 1:12 PM, Anand Moon wrote:
> Hi FUKAUMI,
> 
> On Sun, 30 Nov 2025 at 13:24, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>
>> Hi Anand,
>>
>> On 11/30/25 16:27, Anand Moon wrote:
>>> Hi FUKAUMI
>>>
>>> On Sat, 29 Nov 2025 at 15:22, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>>>
>>>> Hi Anand,
>>>>
>>>> On 11/29/25 16:25, Anand Moon wrote:
>>>>> Hi FUKAUMI,
>>>>>
>>>>> On Sat, 29 Nov 2025 at 10:09, FUKAUMI Naoki <naoki@radxa.com> wrote:
>>>>>>
>>>>>> Hi Anand,
>>>>>>
>>>>>> On 11/28/25 14:50, Anand Moon wrote:
>>>>>>> Hi Heinrich,
>>>>>>>
>>>>>>>>> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
>>>>>>>>>
>>>>>>>>> But I am booting from SPI flash, so I cannot stop this board in the
>>>>>>>>> U-Boot prompt.
>>>>>>>>>
>>>>>>>>> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin image
>>>>>>>>> in the user space to spi flash? using dd coammnd
>>>>>>>>>
>>>>>>>>>      From the schematics, it has W25Q64FWZPIG
>>>>>>>>>
>>>>>>>>> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf
>>>>>>>>>
>>>>>>>>> I have tried to enable SPI flash, but it is not getting detected on
>>>>>>>>> the board in userspace.
>>>>>>>>
>>>>>>>>
>>>>>>>> https://wiki2.radxa.com/Rockpi4/dev/usb-install
>>>>>>>> has some guidance how to avoid booting from SPI NOR flash.
>>>>>>>>
>>>>>>> Thanks for your tip.
>>>>>>>
>>>>>>> I've attempted this method, but it hasn't worked for me.
>>>>>>> Could you provide the SPI details for this board so I can map it in driver code
>>>>>>> and from userspace and then attempt to erase or reflash the image?
>>>>>>>
>>>>>>> on my board
>>>>>>> [    1.282609] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
>>>>>>> [    1.285862] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
>>>>>>
>>>>>> Are you using dts with "audio-supply = <&vcc_3v0>;"? It should fix SPI too.
>>>>>>
>>>>> Thanks for your tip.
>>>>>
>>>>> I have applied the patch from FUKAUMI, and now my console output has
>>>>> started working
>>
>> How did you use patched dts? And what does "my console output has
>> started working" mean?
>>
>>>>>> 1. Make u-boot-rockchip.bin with "audio-supply = <&vcc_3v0>;"
>>>>>> 2. Write it to microSD card
>>>>>> 3. Insert it
>>>>>> 4. Kill SPI flash
>>>>>> 5. Boot U-Boot from SD card
>>>>>> 6. Revert 4.
>>>>>> 7. Try "sf probe" "sf erase"
>>>>>>
>>>>> Yes, I have tried these steps (4 Kill SPI flash) ->
>>>>> I have shortened the SPI1_CLK and GNG in the GPIO header
>>>>> But this board first boots from SPI flash, I don't know the reason.
>>>>>
>>>>> I noticed your patch references the W25Q128.
>>>>> Did you get this device detection in userspace?
>>>>>
>>>>> This output is from your patch.
>>>>> => led blue:status off
>>>>> => sf probe
>>>>> SF: Detected w25q128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
>>>>> => led blue:status on
>>>>> => sf probe
>>>>> jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
>>>>> Failed to initialize SPI flash at 1:0 (error -2)
>>>>>
>>>>> Could this explain why I’m unable to detect the device from userspace?
>>>>
>>>> What happens if you lower the SPI clock?
>>>> e.g.
>>>>     spi-max-frequency = <10000000>;
>>>>
>>> Thanks for your input, but I have a bad old U-Boot in my SPI chip,
>>> which blocks the UART. I need to erase the SPI chip externally
>>> or erase the chip from user space.
>>
>> If you can use patched dts on Linux, please try lower frequency and see
>> spi-nor found or not on Linux. W25Q64FW max frequency is 104MHz, not 108MHz.
>>
> Thanks,  I have tried all the things you suggested
> 
> alarm@rockpi4b:~$ dmesg | grep spi
> [    0.000000] Kernel command line: console=ttyS2,1500000
> root=LABEL=ROOT_MNJRO rw rootwait audit=0 splash
> plymouth.ignore-serial-consoles dyndbg="file
> drivers/mtd/spi-nor/spi-nor.c +p"
> [    0.000000] Unknown kernel command line parameters "splash
> dyndbg=file drivers/mtd/spi-nor/spi-nor.c +p", will be passed to user
> space.
> [    1.293692] spi-nor spi1.0: unrecognized JEDEC id bytes: ff ff ff ff ff ff
> [    1.435572]     dyndbg=file drivers/mtd/spi-nor/spi-nor.c +p
> alarm@rockpi4b:~$ cat /proc/mtd
> dev:    size   erasesize  name
> alarm@rockpi4b:~$
> 
> Yes, I have applied your suggestion and built the kernel
> Still, I am not able to detect the SPI flash in user space.
> 
> Here is the bootlogs [1] https://pastebin.com/25fCqwRT
> My console works after I apply your patch to the kernel.
> 
> U-Boot TPL 2025.10-1 (Oct 31 2025 - 11:12:15)
> lpddr4_set_rate: change freq to 400MHz 0, 1
> Channel 0: LPDDR4, 400MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> Channel 1: LPDDR4, 400MHz
> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
> 256B stride
> lpddr4_set_rate: change freq to 800MHz 1, 0
> Trying to boot from BOOTROM
> Returning to boot ROM...
> 
> U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> Trying to boot from MMC1

I believe this means you booted from eMMC. (MMC2 should be SD card as 
far as I remember)

When you boot from SPI flash, you should see "Trying to boot from SPI" 
first, if it fails then it'll try to boot from eMMC and then SD card. 
This is due to

u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;

in arch/arm/dts/rk3399-u-boot.dtsi + SPL_SPI* symbols in your .config.

> ## Checking hash(es) for config config-1 ... OK
> ## Checking hash(es) for Image atf-1 ... sha256+ OK
> ## Checking hash(es) for Image u-boot ... sha256+ OK
> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
> ## Checking hash(es) for Image atf-2 ... sha256+ OK
> ## Checking hash(es) for Image atf-3 ... sha256+ OK
> ## Checking hash(es) for Image atf-4 ... sha256+ OK
> load_simple_fit: Skip load 'atf-5': image size is 0!
> 
> 
> U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
> 
> SoC: Rockchip rk3399
> Reset cause: POR
> Model: Radxa ROCK Pi 4A
> DRAM:  4 GiB (total 3.9 GiB)
> PMIC:  RK808
> 
> You see, I could not control the UART with the key pressed.

Because you don't have the audio-supply patch for this U-Boot maybe? Or 
you didn't actually flash your newly compiled U-Boot on the device this 
U-Boot loads from.

Cheers,
Quentin
