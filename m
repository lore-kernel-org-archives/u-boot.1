Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63863F8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86B0C8436C;
	Tue, 21 Apr 2026 14:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IC/tEsc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B7E84476; Tue, 21 Apr 2026 12:17:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914E484476
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/D9rilkCfSCReosNzFhqJlUE/xYt3iqh63L9JBtHCllqCeP5lcoiiRcxaozIZkeF50r7emm/LJed4mdD7wB25QroFvtRn/V1Yzue4o7BLHhDPUBiYUkIzzjd0JvkfyL5lmEz53RTM2KWAJTlRVaG0Y176Okst8ahySRDAx1VyMKqKLK1N3wHfgtkI4qimjWzGmniQQqMdbDlJQzWLK5yTqzpHcVy4Szjw2rScP8He6Kpgaq1chiHw++IPO6gCx2G65RgnhMWoczBlGbSeyqMwnpA2L/bxEksZaIwNM/rT7ZbvtMcJtZzDiPcp0P0XUu9lG2nlxPC1amA5icBQmzwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDiOS5S4ZRhddB/ZfL1P8hSDSMyJfVMnyu0qYuxhnag=;
 b=l5HCfMUeikfp7Xj2lCnJUVScDTveu4WmL47s5ksKTUKrZJJw8B80zi94ACFUsYVZl/39OPH5vfpMt//g9UJREDCzvsauChjZjmH8TOwKip6NaLtIElCqlOCj6b4A8gKWnBMyh5q6fggkfInYg06bcVaLdQpCc7u0G6t6a/7hpyKnD0pAJwiEkB5czedTgGKCxrkSiqUNZ15CRdJiHOaRpdYKER1l370Ni/GQ7Jxabfu3pZ/fynXBfR8cJ97Gp6itmDpKGHli3ixe2FbcS27ts/85qEj5963HgCjcYI6kqT6RMBN+MZ3uuGoiCPPdChnf2wa8gf6WfBNWnQcoXrEcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDiOS5S4ZRhddB/ZfL1P8hSDSMyJfVMnyu0qYuxhnag=;
 b=IC/tEsc534RlLLC4FS2Oy3rK2g2rkyS8wOYJ0A06uo/6E3GzRyQ6ZKPXvRsnJvKkLvdvit4Tw7eLlrF1euNMqQDqdFETIuiBjA9cSplr+c5ftjU8qssi+yELbHiHWR1/WNhZhuuHMVr/239J6ZjlPFmrbmi8kmiDPyxW02525mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV4PR04MB11428.eurprd04.prod.outlook.com (2603:10a6:150:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:16:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 10:16:52 +0000
Message-ID: <9ced2644-d3ff-49d5-a524-5439f9ca4831@cherry.de>
Date: Tue, 21 Apr 2026 12:16:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rename NET to NET_LEGACY
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alvin@pqrs.dk>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Adam Ford
 <aford173@gmail.com>, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 David Lechner <dlechner@baylibre.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>, Max Merchel
 <Max.Merchel@ew.tq-group.com>, Sean Edmond <seanedmond@microsoft.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-2-9900002d8e72@cherry.de>
 <CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0082.eurprd04.prod.outlook.com
 (2603:10a6:803:64::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV4PR04MB11428:EE_
X-MS-Office365-Filtering-Correlation-Id: 270fded4-c208-458e-d509-08de9f8f1b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +rxuVgqlpZQm3jbUrkZB/WyRY/p96Y1ZQtdxSnoVzWinKVnsm6VTi3z4XNLIguN/pt3AFAJWgyr6+WvsH4nFDqrOUD5pULbfib8WB+4IjXXqeQ2LZnnTep+xN3BZYaPHwZC2KjUzNy5GPtxdscYxKW3N1737v3mM3ENaGdA0ZKSS2HKJzjlIcQR7RapWrxJyBRYb37icGMLMBEH013eVOvHZHTA8wKZXnR3lEvatWKZl55sRWXhKhcdhv1w0lxiH+wF4T/XFgWr9SgR+PUO+DLX2D57awIoq2xEQn4mEdNXui2BP3WmsilfL69nJGXouO54fCVFEJ/U6GzH6VWWzM2yt57HYz9DtIlbu/i4TuK4+RdvoFv5SwPEc+2xk1bfqH8dXYQLxqNOvDk+1jz6R9l/kXxZ3W880SxkojU8mE7+EgXWRvyPtjqZMULNL0GgvchYg/BgfD2NwN5xS+IkvBwyFrwsacBHvyRzLCWG/jbUaAerhxrznp0iUqekpKU1vuYlBU3SRFIi/lcDfWYQlp8fTfEyjFefNeNLOX6zDa+ohmvpN6UNvsw5LL2ae8omenwl/YS07DK1Qndt0pOMwlRZ7fTTWwvbKE2MFoCM8eKKZy2lfTkUSnG9qSztM/D+NRPix7SKbYpddZz6/69HTIBimr1HlopOZmmp4AF3YKbeD5hL/PCV42M+oojw08zibtJQe087zqbaf9eGuTWWYELsGg12joPSacRIr5JbaNpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhOTTBTZU00Q1hMQndrT2RueEd6WWVIQ3dpd05zQmhISERra1JGamlEL2w1?=
 =?utf-8?B?a1J1U1Y5NnFyakE4UnN6RlBteXlkelFXd3loMVlXTUpqSG5VYlVvdjNFU0Jr?=
 =?utf-8?B?OEo4TXZhNmlLRzJxWVVUcEdqNWlvcmlrbnZ4dXNJdGp5Q2V6YTFXOFBXNUox?=
 =?utf-8?B?T29RUERHd3Y1dXEvNzkvcWhicHpoRkpMRFlScGtjSEUvQXNDNFFjRmJMdGVT?=
 =?utf-8?B?NHpLUm40WFNKUFcvQjV3WGIvdEJmSUpaZFZwbFZlMWI3eDBnUzhsbnZBSnhw?=
 =?utf-8?B?dkEvT1Q2SVRHdVdvZGdlU1FhZHhkYUlFekN2ZmJvcnAxYTdVaVh1OUFjUEJR?=
 =?utf-8?B?VFBRSVo5akRWMkU2U1FraVZFZXk3QlJ2TUdQSXAvV1dlVzlWRE13MWQvSkVD?=
 =?utf-8?B?NE9qQ0pDTisrNndCRzdpa1BrTUdjYllJdGM0UjZtK1NuQk1uSmVHS21QbXBH?=
 =?utf-8?B?R2llRDBHOXNMUjNUWGkvVWxLdUZ4MXFRcDlzM2MwWkozamhBS252elFZcHUy?=
 =?utf-8?B?eGRjVVdwT0FDbWkwS0g2cU5FOVdEaUNSSmFnNzgvU1E3aGk4Rmp2cWdDVmpR?=
 =?utf-8?B?UkRwa3BmTkFLaitHbVh1T2IrU0N5TVFjKytCNXFmQWNaQVFoMnZVajFZZU9D?=
 =?utf-8?B?Z2ZhbHAxRS9nVENSdGY5dkJGNWl0UHl4cjhaSll3ZGRENFhyc0JROE9CRjQ5?=
 =?utf-8?B?TUV0L2k3Rm1YajFFWXNvZzRVL1BycWlGV1hGNlFUeVlQNVBnR1hVU3N5VHJI?=
 =?utf-8?B?UHBnVWNBVnlrQ1VaUUlzSmN6UHJDenhvZnJtOGY2eEVZR3hibGdLVGlDYXBT?=
 =?utf-8?B?Q1REL0lJU245a2UzdnhTYnZnM3hVS2t1T29xVTY0MElNcXNUaUloYUZFVll6?=
 =?utf-8?B?NGxmNHdYbzJqd21nQS9HOCtRQWdyTEFRUUpvZ3ZxRWNmWWRHMG1zWCs4aWp3?=
 =?utf-8?B?UjQ3ajJnUDFaOENUMUZJQWQvclQ1M1BmeHRQYkZNZy8wdVRUSkYwN1NuUEta?=
 =?utf-8?B?ZmFHSXE0bm9wM0tSVkl1RzIwVk52blQ3RjJZb3YzRnFWM0JqK0Y0UUxvcUda?=
 =?utf-8?B?T08rdVVoVVliZXg3NUtuWDh5bGpXUU5NNmM5VW5TTU1mcGd2Nnd2bjJ5NmF3?=
 =?utf-8?B?dk52d0xDZDlYYkN1aEU3Z1BrdExMV01kMXhlaWZLQXpVbFBYUjErVkMwV1NT?=
 =?utf-8?B?OHE4eEFkMmxPZEczLzR5elN4bHNxK3ZQb3BiSzNDK1RxVWNxakJuaTZzWWl3?=
 =?utf-8?B?RlRYYmdVS1ZMQytjQlQ3b2pIUVYyNDhUbkVMelZKZXcyZUZjTklOd2xLWGlw?=
 =?utf-8?B?d2ZWc2Y5V1NxVFplWHFlcVFtcHJzZW01RFFrSzhiMW4xSVJtdXNKbW5xNHFP?=
 =?utf-8?B?VDRHamZwK3VrcnZqUTY4OGlWbUF3ZEZFK1VqSHBvTWwyZzRCUTNreWJoN1Qw?=
 =?utf-8?B?TWUyNlU4c3JTTmVTR1ltT1lrRFI1S3YrVExycDNOMmc4bzVYakZPR3BUVGdW?=
 =?utf-8?B?eGhNUHYwa2p1Nll2QW9NS3ZSMDJjaG4xaTlPSDhrTUlCd0l2NEREbUxSLzRj?=
 =?utf-8?B?ZDRtQnlKV0JjR2NPWTJiTCtSdVI5MnAzdkpFYmswaVlia1ZxZDhsRmpacE1k?=
 =?utf-8?B?YkZlVDQyYVN2eWptclh1WjJzZFltdXlaRHZSR1pBZGR4eG03bVVSQzBsQ2NS?=
 =?utf-8?B?emR5Zkx0UGt0UFpERmFjN3cvcGJIUmZWTjdGU3dxMFppWjhSd2ZUQUtFaGsr?=
 =?utf-8?B?cmNDMUlkR0xQQUliZFFrcm12ampCcXpwTjFmenZwa21oZ3FqSWNtMzcrQUQx?=
 =?utf-8?B?ZGZkTW9zbzVXaUw2RmRBbm9LbWcrdEc3K0s2c2R1czA4Z2RiNzNONE5oOGJa?=
 =?utf-8?B?ODRzczZOWEt4aTlhZ0dQbGdvT3RlSG5UbmVyYzVNMGd6eWhqMlEzRG5aRUhJ?=
 =?utf-8?B?eUswa1ZCUHBFQysxeklVMGx6Ym83WmVDZUVOYUhucDBObitOUTA4UC9DenNW?=
 =?utf-8?B?cEF0S2Z0d1FtK2pBRDNuVXVhZlM0anZRYUY3RmZnbXB3U1FOdSt6aHB6V25h?=
 =?utf-8?B?MGlzUjhWZUFxLzN0VmdTOEkyMDJTcUNzM2YvV1ZjMENSZ2xPaEE5QmlOVXFh?=
 =?utf-8?B?bi9PRWhHMmhrY1VCdHJuRy82dTFwbnVIWHNsdkxkOGM3c0F5S042azhaWHRX?=
 =?utf-8?B?ODdPN3F4NDA0MXNuYlpQeVBhTlhMeWZNUG85Umw0K3BsY2IxQlpiMk00UEdK?=
 =?utf-8?B?ZnhETWRFVWN5MWtBbytsOVFnNnZPc2poa1VmM3hzQ3doS01WaGxtS2xqVGVB?=
 =?utf-8?B?TTlNNnZ5VUVNcUhLU05ScjBuQ0tTbWh0ZUc2aE5kR2V4a1g4aEs1WFZJaWV5?=
 =?utf-8?Q?SaTOOIIJ/L6iaKnzoJM51dNRrn3eLAeILoAnP?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 270fded4-c208-458e-d509-08de9f8f1b4b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:16:52.1372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qft9dmfAX56J+MpbtrwKB7xLV9qZ0i/3WnUIavfPwUc/t9dO4DkwD2GehkAyRp10zLrQXTpH3ob9FL5p2Yt/J0Y9qicXuCM/W+5kpEL+lKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11428
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

Hi Simon,

On 4/20/26 9:42 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-04-20T11:36:06, Quentin Schulz <foss+uboot@0leil.net> wrote:
>> rename NET to NET_LEGACY
>>
>> Highlight that NET really is the legacy networking stack by renaming the
>> option to NET_LEGACY.
>>
>> This requires us to add an SPL_NET_LEGACY alias to SPL_NET as otherwise
>> CONFIG_IS_ENABLED(NET_LEGACY) will not work for SPL.
>>
>> The "depends on !NET_LWIP" for SPL_NET clearly highlights that it is
>> using the legacy networking app so this seems fine to do.
>>
>> This also has the benefit of removing potential confusion on NET being a
>> specific networking stack instead of 'any' network stack.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
>> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
>> @@ -422,7 +422,7 @@ includes the full set of commands, more error messages when things go wrong and
>> -several filesystem and network features (if CONFIG_NET is enabled) so that
>> +several filesystem and network features (if CONFIG_NET_LEGACY is enabled) so that
> 
> Shouldn't this be left alone? Or perhaps restored in patch 4?
> 
> BOOTSTD_DEFAULTS selects BOOT_DEFAULTS which enables network commands
> conditionally on !NO_NET, meaning any network stack.
> 
This patch series is about renaming stuff, not fixing stuff (though you 
can see some trivial "fixes" in patch 5 and 6).

I agree with you that this needs to be switched to (new) CONFIG_NET. 
I'll try to not forget adding it to a v2 (as a separate patch) if 
there's a need for one, or send a follow-up patch.

>> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
>> @@ -159,7 +159,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
>> -                     if (IS_ENABLED(CONFIG_NET))
>> +                     if (IS_ENABLED(CONFIG_NET_LEGACY))
>>                                printf('Net');
> 
> Similar question here.
> 

See above.

>> diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
>> @@ -232,7 +232,7 @@ void set_board_info_env(void)
>> -     if (IS_ENABLED(CONFIG_NET)) {
>> +     if (IS_ENABLED(CONFIG_NET_LEGACY)) {
> 
> and here
> 

See above. This one seems ok, but I am not really planning to modify 
individual boards that I cannot test. This change would mean in a way 
that CONFIG_NET_LWIP has been tested with that board, which possibly 
isn't the case and I cannot guarantee that either.

Cheers,
Quentin
