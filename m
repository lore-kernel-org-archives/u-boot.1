Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03742EEC2B8
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 00:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE1D83642;
	Tue, 24 Feb 2026 01:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vpRsPrsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 791C883935; Tue, 24 Feb 2026 01:40:58 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546688063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 01:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV/5mTF7nLg5k7Kwz3RQqAtOyOfl1tymQSu+KKFK5rWSmX7srgX8dM7ZyeNwgg6W6iiv5dazxzHO4vmCr2oZsTzdeeTZfjT40rllZUqsLJk8uCXsBlWGNzhNTMBxW3+B6tqtrhw9yzmJ+2ftcF/BoQxppeYw9vO1mlqAppJ+lMtLsnja5RJJwaSjePjO4e/GvZHiTWYbggc3UOj/Z740T9SFwLkcmBqiM6pAQ8lTLNIEqOJohVlEE3s3Vws7qzR2ud9/INp009227WTVhNAroE+nvYtLE/VrBX9TFqRIXE0Is62UtpjYY6Fi8QQMQOsGCnWvYSv3oHQDAbCJ0U02/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3eWVcFU7uyt4Kz1/P06CZc7e4ZLU4Bg8FxMXeWHZeg=;
 b=HkRBSWPJTV2W2+S6WyQi2gy4dnnTCyZMvmqkegvmNA8ZC4291QkkTnEBG6hw+PwQkTvHrDzz3L/G/oEq+GGYDIyE+LRD20ITncz5oRSmI5Fm9a2ZUVv9DTC62SJT1B7nQEUjbnLNTvAFPrJnW3XdJF3kVdfOcJzGmhOzMy86KAJWBNNYPRQ6aullGjpko1YEAUMD3Z5zRM7pBXF8j3vzgvGUWoGdzRp/T1svJWSIzPE+8wNx/bZp/iLwL3ghb1UyBzePWi2FO0wlEXRV5VdoJlsDFExQKhnVjEc9a0P0D4FGZEkUV+1C/HqsJcxf3v5xcXWZPbx1H/vZr2UeTRkC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3eWVcFU7uyt4Kz1/P06CZc7e4ZLU4Bg8FxMXeWHZeg=;
 b=vpRsPrsNihC7qCzVIa9+sKfgI4edveVqLceGyO8YRuTibSrvaZREbSU2/TYtTXZ1q0TFTgBgdJPAe8y+xM/gODDjj/TWAX5E4BnPeLMrEdxnRwvL68kyr6kSj1uHRBaMWkEmQjY6Jyb5nnTAl/Z5FSUkgHr4D8OON7X39O7Dw8Ns7F2dcDJTryiyckLovgthvJt3QF6TacbZ3gvjbgsO8GvOh5FGJ4g4fN7zfZMpqrYlo1sW8XKl3Glx1fcjzz2fmSmvuZgQSbO5iU8iBntRyJFzIU0x0I16s/Q5Dw+i6XKXFz7LKUNAlxbIG9Z5f/rCTpIktCb/9nfNAyS0IprAhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8295.eurprd08.prod.outlook.com (2603:10a6:150:c0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 00:40:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 00:40:50 +0000
Message-ID: <5ade655f-b2df-4cb2-89ea-752b2958eca3@iopsys.eu>
Date: Tue, 24 Feb 2026 03:40:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
 <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
 <aZc_f3lrmRdE9c3Z@makrotopia.org>
 <CAFLszTgxMeFvKx8nkVUa_PADiVFnv1UB69SyD+C3OiLY_7ku8w@mail.gmail.com>
 <aZypXx3liLvvB4zr@makrotopia.org>
 <a1d06225-bc17-411a-80ed-f39e0450dc29@iopsys.eu>
 <64a12e61-8e04-472e-8493-90b2e4a41d50@iopsys.eu>
 <aZztAL-RQ1LSf0-j@makrotopia.org>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aZztAL-RQ1LSf0-j@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 224e700a-954b-477e-0cd8-08de733d5c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpZLzd1NVVndVQ0VHNDcXZscjF3eFg1RHBXVWFsQUU2V0hlMVU2dnVMRHZ1?=
 =?utf-8?B?ZXVYKy9SNGk0N29jVzM5SnpNamJVbE5oM1hCMDk2MTVxWWFrakh5QzBEQlg5?=
 =?utf-8?B?RjlLN01SM08zYWhOT0M1dk9KWDBuUWdWVHh5a3ZEN3AraDVBZFBBN0JHNVhk?=
 =?utf-8?B?Q3VZYTI4NXM5S0RwWE5lbXYwb3pPWU4zOG9mbUJ1SW4rUERnNkJ3dXJ5eFpp?=
 =?utf-8?B?ajNUbVI2aUs0TG1xQ0ZrcEppNVVkaGxBUCt0c1VNdHBZVmNLZXc0QU5mTnQ4?=
 =?utf-8?B?N2dNckNZR1RoSW9reFJpaVpQamRieDZQWkJrUmFDT0hTckgwMnR0bzhCanp1?=
 =?utf-8?B?NzBtY1l0MVo1cXhGVTk0NnZUUFRLUTRlK1lMcXFCWDRPVTh6Um1KcGZxZzhz?=
 =?utf-8?B?MUlkZC9VeERRL3lUcVcyLzBpT3RMQmttNUNrWjdOdmJVSlVuZDBwVDNBbFp5?=
 =?utf-8?B?VG5xTi9YQ3BYeTVFdkwzMjlpV2NnL25ZclhLckZ5NGE1N0NxZVVvNmRjUjU1?=
 =?utf-8?B?MDZobG5yL01qYVE2Ri9Bbks3SjM5V0lsTmxPNjh4NERmM1VGWGQxUUpsQkhD?=
 =?utf-8?B?MGJqVUhVUXo4ZDFROTczWWRxZjRkWW1JSW5ucjVUN3Jkd01SSU40NEFRZllC?=
 =?utf-8?B?NGR5cWVzRjA1bWwySGxyVnY4MDh1ck5FQ0VBVVY4U213MVZ3bUw5K0xKK0lU?=
 =?utf-8?B?Z3Zpa0JaR3UzYU5laFhxaUIvdWIwTTI1cjA4WDRmbFFVV1U2QnJUN3RwMk1h?=
 =?utf-8?B?Z1E3NFlRVVVEVWpkdGlIdXNmRVFudktrT1RXczZnUTRqWjFsM1JLeXovdXFo?=
 =?utf-8?B?d0lDNkNkYXkvckJ1cURGeHBheVZISHZod2J2WnVnMmhTVnZRY2JGQWh1YnZi?=
 =?utf-8?B?bUtZRm5TalFOTXdrcnRIRFg0eTJNUFFvVkFLbmc2NzlheElWY2VPNGJZMVFj?=
 =?utf-8?B?MmhFclQ2QlZLeFl3MzErRGxyck9WT2Q2SGlpQTBPUzFPb0NUQTNyUDZjbHZt?=
 =?utf-8?B?Q3luYXl2UE0vK2FMQ0EwYml3OG1oTnZlL2NwaDVVL1RaZVVKbDVDZFpEWnZE?=
 =?utf-8?B?T0hLVmxyc2pVd1R3VUxVU2xEZ2k2TUdacEduK2R0Y3JzQ25hM1lheDJqNnBJ?=
 =?utf-8?B?U1Q5YTZnSDJSenJ3MS9QT2k1c2o1VWg1WHlhRGdqWGg3OVVISUJpTStUSEhF?=
 =?utf-8?B?SXkvSXBQby84TmNUbVViUUw3TDZjSmFkWW9lbXRMMm1qTVF1b2JFdDRJUTE2?=
 =?utf-8?B?UWJWZ3ZpNU1Pbyt6cC9YQW9CVWJ3OWxjVmw0Y2RXZFNvRy9ZOEI1cTE0dmll?=
 =?utf-8?B?R2wrREVzTEdoL0Z5TDM1Z1V6QUlCVFVlMXlMSUJyekFKU2swM2xnLzd5RzQ2?=
 =?utf-8?B?WkJ4M3Y5ZXQ1dUtJbVUyMmVYWkRFdEJlVFFOR3lvc1JWWVQvTG5IK3lOYVJN?=
 =?utf-8?B?VjVNS3VhZFV0dnc2MUluQU1mNjNIL3FGVEVpdmxvL0JBTFAxVDVsa3ZiMTdv?=
 =?utf-8?B?UHBQbm1NQ1FDT2pIblAyTEVrbUE3TjcwWU5SdStkdEVGZVFrcGY3aXI2WkM4?=
 =?utf-8?B?VEZ1akVMY2dhSWt4SmZXanhKQXp2bXk0WkFEdyttdVVNUnZCcERnQXVjN29T?=
 =?utf-8?B?SHcvVXlWS3ZuWS9wdk8xMVN0bW1uZjBNcVYxVkFFcFBGaTJVK2JpUlhxTzZS?=
 =?utf-8?B?ZGNtQlk1dFU1eEQ1emQ3K2xrZThaM29PNkhsNDdZKzRBVTVHa0I1azF5RXho?=
 =?utf-8?B?dzRiaE1RRGQzQlpueVZNRUdJaFBMNWpKOGVLblFaNDZjZndwdEhrKzBpcDdN?=
 =?utf-8?B?azNNZDNPTGV5cEJoZE02azFOdjBKZk0ySEowbUFUMk5VRGE2VmEvWjhid3hj?=
 =?utf-8?B?cGZQRDRDRG1sektNWWkrS1JIY09idWIxNllmVHovVGJkK08rWlJ0bVk0MHNr?=
 =?utf-8?B?UGdpc3dtZ0F0b3BnZEpicVF0VFRML2JtWXZXTE9OcytWY0FGUWN6K1pHbGdD?=
 =?utf-8?B?QU1xdExTMXo3b2JyQmRTVjRJSlE4YldUWS9zdDg5WjBYRzJIcEFrNWtiQ3pX?=
 =?utf-8?B?OUV1ME5WRHFrSkh5RStlUjBBUlZqeVp6QWpJUkdrYWZLRTE3TTNyaXhZc3Bw?=
 =?utf-8?Q?Ji7M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2RQSjdCZjlLamx6UGEvRXhwdGFBVXFmT0xtV1RZSDBHU21TZy9SY2hEbEFY?=
 =?utf-8?B?b2hPUTE1SmVkQTNsV1crMm1NRzl2QjUvT2NlUnk0MGl6Vnc1MFJ6ZUUxWWIy?=
 =?utf-8?B?bXZBcGxjRTZMcTZpR3lWeWg1ZUVIRU05a3hScmRWc0J1aVBUQkFWNlhpVW5u?=
 =?utf-8?B?dnVFYVJxSDcvOXBJK0JVRE8rZWcvYk9WWVBYTm0wTHRCb1FqeFk2UlRvMStG?=
 =?utf-8?B?ZUFtcWxZWDhjWTNmVncvb3BqZVBqUS9FK1dXWlp0NTdybENBVjlhcXNiUEhZ?=
 =?utf-8?B?YVhoNUtYQ2MxUXY2TUQ5b1pDU0ZXN3k2eGdKVFZPMWdNWEZ2L0t5YnVFL1BD?=
 =?utf-8?B?amg2aUZFKzFmcWk1Ykk3SDRScERwRmlUeHcyQjg0bHNvVnM5Y3pkZTB5NWh6?=
 =?utf-8?B?S1loWmo5WDl6Zk5Oek9KTUR1ZDdNakxMaDk4amcyejVsMGxjcE4xSEpNTlRu?=
 =?utf-8?B?YXlvNml4WEo2bHM2dzNjcTRuM1AvNjZnM2dsbGE3clk4ME1PQlQ5OHBqWHhu?=
 =?utf-8?B?WUFZVzJySmtmRTF6YXlmMXdGaDdPbk9YUlBWZ2hwdW9iRndaMVIxd080N3VW?=
 =?utf-8?B?L3pSSDBWeFFOM0xES2gva0JVS0hwSFVHU0owVkZXVkE4M2NDcDIyaHo2S1Rn?=
 =?utf-8?B?dFZ0WW1DSEpNNzQvUldVcjYxOHZ0ZktteERnM0F0Z2JXL3BYZUVTVFZxeHlG?=
 =?utf-8?B?Y3dZWm9oaEZsMTZBaXh2NWhNb0ZvM3hHalVxTnA4eUpPV2VYWnpKbCtvdjhZ?=
 =?utf-8?B?cStFZUE4MlJnblRDQmdOY2VWZXVLcXlnQkowVHgwdE1xQzZ5ektpNnZ0Z0hv?=
 =?utf-8?B?aE1VaXZsUUh3eXlSNTlIL3FlSHpNNWNQYXJUb0twZFc3RW4zdzA4Q20vWkcv?=
 =?utf-8?B?dmMrRldRaEJqNll2b21QbSsvVldGcUxZWE84RFdCYmExejBiZm13UGcvTjVV?=
 =?utf-8?B?eWlCVmNuZldwYjNrL3l3WDhvUFp2Zzlnd2ZFY29sYXJ3RHVUcHNUd3g1c0RR?=
 =?utf-8?B?amVZNEUrTVl0VTFNWlZpTE5vMVp0T0xjaTRTTGdRdUZmVGxLam5ZQmhnUVdZ?=
 =?utf-8?B?cWlRSkhJY2ZkZVpMeXdRdnFSTk9CbzF2SElBSVI3T3RPV2VSTUQzSkdrOVdz?=
 =?utf-8?B?U2RXRHp3MHZ6YXpWWm03d0hpRUhEQ1NQNnF5OGYyYVZwaDVEWFdMYW96dUJh?=
 =?utf-8?B?dmZLdW5qUkFKbVhwZUdVYVZOcXd0aklYT1lHczhtNzdLWUlZUGI1QkpLOFRj?=
 =?utf-8?B?bjAwdUkvcUhBUUk2bXNtelhYZUxsbFFVOW1CeStTNmswbWtub0NaRWdCWU5h?=
 =?utf-8?B?djFKbzFkdXB3dVBKb2J0UTBvV0czc1ZBZW9icFhaTjljNWE2enpUbGhDdGNm?=
 =?utf-8?B?RkhYaUplRE16a2YzcURNbHZQSERqR2RRbUZ5MmRFMGd2T3R6SEQzVVQ1MUU3?=
 =?utf-8?B?S0Qyby9jaVd1NHJPL3hNREJrK1FMRDQ1ZTM3VGM5S29EUFhMMExrM0RXQUxO?=
 =?utf-8?B?VHNHYUtqdSsrQnozcmV0THN6enBNYmRiSHVtYU9la2hhc0VoOStPbHl4R3Mv?=
 =?utf-8?B?REdQM2NYOGVwRjlFMXp0Sm41QnJaNi84OUloYkRHYkFJNUxOY1lZdXhJR0xG?=
 =?utf-8?B?OXRSbW0vaGZZOXJCWTdNQkd0dGFRZ3Z4OHpLMkJkcHBLMDdZdmIyU3hOZzYw?=
 =?utf-8?B?OGxBVVdjU2JZb0NYdHhWdFpvbkhtQjc4VHFuWXp3eWRyU0M0MGgyN2tVV3Rj?=
 =?utf-8?B?Z2d3amlKcWViTkRZa21oOU11a3BDeno4c21zeHMydElnY1BORFh4dnp5NVBD?=
 =?utf-8?B?MnVPT0V6clhhRUowZ2VYMm9wTTBmQWtkWlVueEdXSkVwWFU3UXMwMDc0R2NZ?=
 =?utf-8?B?Nkl3dU96cEdScVltZEtGOFFEOVVjWklUY1NPbGlDRGRaTWNXQTk3RTZDd05Z?=
 =?utf-8?B?VU0wd2NKZHJmTWcrdVp2SmJsbWh1WnoxRFBWMlJCaVh1eEt4Ynd4eXZ3OFJK?=
 =?utf-8?B?eVA3cGRUejh2cnBJL0Fvc3N0ZnJQTm4yajZVMkthb210V1hKNlp6bG9iRWVJ?=
 =?utf-8?B?WjFKVmdqUVlPTHVPQktXWGhaRVYyOWtRT29ENklPa2k5SHNNUDFXTzhheGZK?=
 =?utf-8?B?VWExRXlYWmhxRWIxOXp5cy9zQkJ5ajFNRmZHWEJtUTFTcmI4TE4ydGd5bzRQ?=
 =?utf-8?B?TkhsaGg2Z0RBeFdVK25Vb2xBYjA1ZUVRaDhuQnBSMlJQR1RRbXN4SWh5MC9M?=
 =?utf-8?B?aDlwdmo5dlZjRmVPc3kralhrNGl1ZlZ0UXlOUUtSQ2drbXo2R0dBckdiOERM?=
 =?utf-8?B?Mk9JN2hQSXhUWTg0S2FkSjZhdFpvT0MrUGJudHRUeXcyTWJxc2RGWDJZc09V?=
 =?utf-8?Q?n4E9pGjIkU66vJ84=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 224e700a-954b-477e-0cd8-08de733d5c01
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 00:40:50.8289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRBN9pF0YjIvWE/3DctRikw6bQcZYP3gR0qgT2zot+p0qiuk95t4FKoEv9J2svUglBe+Q1HSKEs7+coOit3JG2N4Tbnw4ZeRUAU/Y/JwdI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8295
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


On 2/24/26 03:12, Daniel Golle wrote:
> On Mon, Feb 23, 2026 at 10:32:32PM +0300, Mikhail Kshevetskiy wrote:
>> On 2/23/26 22:30, Mikhail Kshevetskiy wrote:
>>> There are UBI based block storage emulation, see CONFIG_UBI_BLOCK
>>> commits: 
>>> * 9daad11ad178646c288aca3615a7ba1e6039aed3 ("drivers: introduce UBI
>>> block abstraction")
>>> * aa5b67ce226267440e64fadc57d3a21e5842027c ("disk: support UBI partitions")
>>>
>> There is the block storage abstraction for mtd devices as well.
> During my evening walk outside I thought about this a bit more, and if
> it would be possible to use the ubiblock and mtdblock devices instead of
> introducing dedicated bootdevs and imagemap backends for both of them.
> In the simple case of only a single boot option this would probably
> work: bootmeth_openwrt detects the uImage.FIT on the raw block device
> and may go ahead, load and launch it.
>
> However, there is often more than one of them. And as they are stored in
> directly on MTD partitions or UBI volumes, knowing the name of the
> partition or volume, and which device it sits on is crucial for
> bootmeth_openwrt, which should support also complex multi-slot dual-boot
> arrangement, typically identifying the slots by UBI volume name or MTD
> partition name. When using the mtdblock or ubiblock devices this
> information is hidden, and can only be accessed in a very tricky way,
> especially for ubiblock devices, which lack a device parent. Matching
> the UCLASS type of the device parent of a block device in the bootmeth
> also feels sketchy and inappropriate.

what about querying available partitions using the command 'read' way?

> So while having mtdblock and ubiblock devices is generally nice,
> especially if U-Boot has to access a filesystem (eg. squashfs) stored on
> them, for the case of OpenWrt it would at least be a bit ugly, as the
> metadata of the actual storage backend (MTD or UBI) is crucial. We need
> the UBI volume name or the label of the MTD partition.
>
> In a way you could say that OpenWrt uses block devices (eg. MMC) it
> boots from more like MTD, and not the other way around. And in some way,
> bootmeth_openwrt will do some extra lifting when started on a block
> device (extract the GPT partition name and present it as the bootflow's
> fname), while the imagemap API provides an abstraction to read raw
> images from all three storage backends (blk, mtd, ubi).
>
> That being said, I'm happy we have overcome things like block2mtd or
> gluebi, and do use the appropriate APIs (and filesystem types) on each
> class of storage devices in OpenWrt nowadays. Some of the helpful
> patterns borrowed from our MTD and UBI boot flows (avoiding a boot
> filesystem, identifying storage volumes, ...) remain, however, and are
> applied equally also on block storage (ie. MMC).
>
> tl;dr: We'd rather use block2mtd than using mtdblock ;)
