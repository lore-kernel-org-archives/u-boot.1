Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B33EC1127
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 19:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C7D883DCB;
	Mon, 23 Feb 2026 20:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Or85B6v+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C965583E1E; Mon, 23 Feb 2026 20:32:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C34883DCB
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 20:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCMxbmTc1hWndDt5LcGTYaU3JM4bwCtURAul/m17eM7Cia+2aTkCZN9xSBX+M9T7WxRCxMxNbouEPccjJ199Wff0iXmiNEE56jfZYp32l3/9jdTjAFO/6zS1r6EUxpEvESk+yfBftgTu0OmDd5qLWtHYxh38acAJDLIjPbIgcz8Stn9eSGiAMyUByeRbuC/R92oKI9lVRvjiJh17b94OmJ1UG9NNvt1tzqoAyR4sRfZ9K6MVEBtbYtHYNRHbQkoBo78cTcw+ydkP5N6CgG+/8oS6YIiiK2rh7kq4kIbDpawzBscVt8QeQrQYnsSATNbyTI+qNglnJpD5eKf0eNryZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxa/V/p2uVw3Vw1km9te6am1UXanwuixs+ojjVVsyYw=;
 b=erQeB36vsHmCPkYYz3wpKQWAoZAMzJqBYggjd6R/IHLLpqPbGblmSdkDY9AK1/X4Ih5UwjJK/TeYyylM01H6umw/Yy+MTeDusakOeuxbZZy8hClLljJa0itcwQEJ1n7GT9HIFLjrXLluBzAdYqw36SKeZxJYojmEuBJbDEOnayhwV3R20rLFDkyoV4DTdr3Pha6jUCFzqsbfmURka7XYepkU7IBED0CtFMtrZ6QlOXAiJQBUk/snC9laWBo1VFwKgIgOQYDoHmZVa9jDCXr9Ahf5HP9pKjkSiLSoc7AKfzWn6wwNxM+JDxWrg7BhsIjBXUK5+OKjnYlcCdHqQ4OPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxa/V/p2uVw3Vw1km9te6am1UXanwuixs+ojjVVsyYw=;
 b=Or85B6v+DJ5uFbXhQT4Rc8XAGt/UCQ3i9t+fxW+BMYVkCc1huq82EFzQn6i/0S0Hn4b4gmLyGZ8iCsPXcIlJN1cnhVHExTnsdlwPoaV4STrKHnxqL+4kkSKjwaNkzAmBVGOzRJi9HFwUR/j4rB+YsYAikMXoCQPZOOqYcTmgBZSd+v17B43I5hMQ6qzxMmXb9GErXZc+uhG394BoNFoo9YT5e9SPReLRN/rl0RfOXLNRB+aLb4HMh5ycytcmtva6pDWICTGz4xaDB6aMYYwKM/YV1/iUlcs1Dz/xqPUq2UrGBE7itonMwq0tMNbuTZFp4sNHhoLrPyEYpG3Gden6vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB7446.eurprd08.prod.outlook.com (2603:10a6:10:36e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 23 Feb
 2026 19:32:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:32:40 +0000
Message-ID: <64a12e61-8e04-472e-8493-90b2e4a41d50@iopsys.eu>
Date: Mon, 23 Feb 2026 22:32:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
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
Content-Language: en-US, ru-RU
In-Reply-To: <a1d06225-bc17-411a-80ed-f39e0450dc29@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ca64d-888c-4b44-104b-08de73124f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGxURE1kQVdoTS9BTGc5ZmpsbjdIaEE5bWNiNFNwUmhYd1dBWUcyakNDbjlN?=
 =?utf-8?B?VmNBbmNZWmFuZVA4eWhQUFZhZHV6MENNaHJwKzZQSkpQU0EwQTVWUFFnc0Yw?=
 =?utf-8?B?M3JjTjFpcWtycFY1SnFicTlHaFJ6S25aVURrSEZnSE1CVDQ1ZUZDVlhxNXZK?=
 =?utf-8?B?NFljSW9zNGZ0NkhTenhNOTRiQVFSUjZBOFFQZkE5cTd5RjVXUFFzdjgvK2Vj?=
 =?utf-8?B?SWVMMlEvcHVEVGVzYWtRK0E1NDZIVFg0RWtNa1Uxa3pmbVNQbFZ2NXRWSW05?=
 =?utf-8?B?NUpJaGN3RUNKMTQ5QnRYTEVPZnQ5WkFxYXBIY3c5REFReXlQYlhXVTlqUnVs?=
 =?utf-8?B?WGRlbmVtV3JLMFFKUnZZOVMwU0pVb1NOZEZqS1JuUnRHbyt0a3NkQ2wwVXdz?=
 =?utf-8?B?VjJpUGdySUNDM0E1emFPUDBhSFVPOWJQQ210S0hLbTA4M3pzNlp5dWs4ZS8v?=
 =?utf-8?B?OUgxSHRWY0VCRmVEQWxKcGJraVRrcWIya0NXNFVJc3dXWEEzS3RhczhueHZl?=
 =?utf-8?B?RlJxT1FPMVF3UEZUTWMrOUVkUXFCRFcvTE8vakVRV2I3Wms1b21BZzlkMHc3?=
 =?utf-8?B?MnBzOTFuMDV4RDh2dWdKaXJhYzV6SGEvemhXTy9mczBnOXpoYUZJZC9vUkNV?=
 =?utf-8?B?Sk5vOFNiQXlLbGw0WDFSeTFqQVRpQnp1cVlsQkhTeEZ2YVhEZE81eXFwV2xp?=
 =?utf-8?B?VTRGR1ZXbm92TlVLWXpiK0lFTWZVOG5YeDd3Z0EwSStQWENjK0NPOEZPWGVY?=
 =?utf-8?B?TUp1Qm9VaFVxYVlvcFBkSGhabEpqUnNJVzNUTm5mVWo0SU5yemhVblNndG8r?=
 =?utf-8?B?bXh1N2VqRjdkTStFMGJWcDkwSjYvZ0p3QmphVVIxcUgyZEN5N1ovZTJybHZn?=
 =?utf-8?B?N2hhSlM4dkhkbzlrdGptTjFCWjFCMlpHcEJLSUo3aUV5L1I3T1B1ZVZDQTR1?=
 =?utf-8?B?Ky93cXo3ZnJHK1ZwQWlDUlg3NjlFNHhJTEs0eHUzeW92Q1hEeFVrdTlkVlVx?=
 =?utf-8?B?YW9idVNITGZmZ09VMkhCZ1EzRStGdEkwRitVbmtHUUJ4NUtWRWFieUNDOWd4?=
 =?utf-8?B?TWVUWWFDSVF0Vy9rRWJXMWJEdW5USDNLRS9idVFPRjBCTWk3RzBLamUvQmE3?=
 =?utf-8?B?NWRQZzdZR2tzZmdFR0VCNW9aYjFvbERHMWJxNGJ4eHY1ZmtLdVdXWDFFd0or?=
 =?utf-8?B?dXE1cmdTeGZMYkN2VWJWckorenpoT0hoZWFNVGlXZ1IwbHAxM24rRThvV09H?=
 =?utf-8?B?Qy9lcE9uV0NHK0k0dUNvMHF5L0hpS2R6UmNVbWl0dWRZc1ZNMzBoM1A1L3Y3?=
 =?utf-8?B?K2ZkdzUvb2ExTzE1SmRyQ2lraXJzcEptMmMwVzJkTFEwRFl4dzduUGNkZzZK?=
 =?utf-8?B?a3lLVnB0WjRNL2txTEZTQUhhdVI2ZVB0ejBsc0h0TjhOVDk4Ryt4UzEwYytm?=
 =?utf-8?B?bDVvZVk5blJNQmtUOWRGT29GeGdJdUZ2dmRPanczVERMMG9LSGRuRUNZZ2Q2?=
 =?utf-8?B?VW9QZ0EzbUU2QVVKcjNNUFE1bW9QeWlldXFYeVphMkZZV3JqNzA4ZURNeWlz?=
 =?utf-8?B?Sm9qWVpFUmcrZFJ6TGxrc2ExUXAwK2dPODJYbUpDZGhMMkNqNFNRQ0wrODFC?=
 =?utf-8?B?cyt6cDVUS0JsOXJ0RGd0NWoydGlGdFQwUmlieldSUnYvWWEwekJXSlBzZ29Z?=
 =?utf-8?B?dDY3WHdHZFhRVDRhbW5hOU9YZlpvZEJseVVLakk2SERoQS9Fb1EzQ3lzNFdI?=
 =?utf-8?B?cjRveElpZks0NkFxL2dQSi9BRm1rK0tNemJaL21zRk10Z3FwNWxTZjJ5cW9m?=
 =?utf-8?B?TmJHcUVPQ3duT3I4b1ArS3JZNk1CWjlzUlVGVWcrRHlQZkY3cW93RHNRQkJH?=
 =?utf-8?B?NGpPWlAvMERHd3labkRKZXR6SU9qeTg2Tk5VbFBqRHdkUkVPT3Z5dVI2OXYw?=
 =?utf-8?B?TDNzOUpweVFkTVVBbXRuUjVmSGlVa3B4UGh0N2pTcHpBcmhpaUFJbWphc2ZW?=
 =?utf-8?B?bXh6T1dZY016R3NoZlJscEpYTTl0bGt0ZHRQb3NrRXJoVHlJNHBlbEhsZksx?=
 =?utf-8?B?ekNvdE11S0lvalZjWk1YcENSMDBYRU9vU1AydjZ6aFFHTGoyZ1hhdUJIWmda?=
 =?utf-8?Q?HIb8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZHWWo1ZFNvaTNzMGxiazZQa1RpaDFENnR1bzA1Ukh6U3hWcGc1d256bmhN?=
 =?utf-8?B?NXNvVzRUWktMZXhueFFydzZhQzA4ZTNFUlFtdFcvd25RRkdpYUdaMC9NRWRK?=
 =?utf-8?B?V1FES1V1cURSbG5xMjlsb1B1R1VkQjRWNVo5NlpEQVhhL2psNGgzS28xRjY2?=
 =?utf-8?B?Nm9qSFRyMlhkckJLRmk5VUxxanFkK0phUWFOTHpZSWNkc2xKKzAxQVlqc2xZ?=
 =?utf-8?B?Q2NNbGhTeGFrUjJ3VGxqci9RU1BzYVhkSFo2OTJ2UHRUZzc1SldMTmZkMVAy?=
 =?utf-8?B?SW9FM0VsTWh5dDUzVHdtWDk0dlVMaGxtM3hTTHgzQytDZXBUM094T3NyelBO?=
 =?utf-8?B?dnU5eHE3RGNlSDkyK1dOeEtrcW5RUGc5c2VFdE52ZjhHVFhScUd6ajgyaUF0?=
 =?utf-8?B?dlcrSlgvVDlid1ZxMDBnWTVhRFoyekp4dklKMVZINDA0djRHMnZGQ1ZqdnBx?=
 =?utf-8?B?bVAxT3V4bWJHWGRiOEhXS242SUFzTFR6Y1Z0aEZXeDEwVlFheEFxOTdncFJG?=
 =?utf-8?B?ZmM3Q0RwV29OVEF5ZWlwZjFBdkZnVkdCa291NWFodmprdTU3aXZaOUtlOVp0?=
 =?utf-8?B?d1UxM1BFd2V4RGNnVjdabTJlMGl4Q1BiUGNZMlhUQ3hneGh5cFIzN3JNM1VU?=
 =?utf-8?B?aWRtNFh3dVlsYTBtWlJtNWkrMGUvN2tJcWU1VGN3RFFxNGRwbitnQVBmU1Zx?=
 =?utf-8?B?ZnJzZFd2R2t2U2o4cUtLeDlCSUgxSkIrb0hzQVBMNmRwMVZ1cGliZlF5dWpJ?=
 =?utf-8?B?UVVmSUIrcWhRNW1jSFI3UWFHd2JhOWJTTlJnNVVnLzEzQnRuWU5NOFlTQWRI?=
 =?utf-8?B?MVJhamJ6bzdSVnRTWkhYcXhnbzIvdmU1RTB6SWNCS1EyMW5kUUtUU0hlZFZD?=
 =?utf-8?B?eGl3ekpDVngxUFBqeGljWWNQd2kwcmNiN040NXJZeU5FUDVHWUFXalQ2UWQ0?=
 =?utf-8?B?bktWamlPS1hTNTBZZUVSVUN6VTNHbGdxdHRqd1Y4cWlUWnZ2R05Dc2hNSEpF?=
 =?utf-8?B?SlBHWFlrSkZmR1RJUC8zTm1XMUlYTnZyK2JEdktMZmtJeDVhRDc4K0J4bkNB?=
 =?utf-8?B?Y2VQd1pGUHJvRXFDV0JWMnBZMCtwS2J0cTMrWllvbWV0NlFNWGZQc2Eydi9y?=
 =?utf-8?B?RXBncHgrcEZ0S1hlSDhHZnI2cFpGamdVcmd3aFhDRGZZcktCMkwvcENwa2pK?=
 =?utf-8?B?WGxkRndCNThXdk55M0oyR29ndGUxZEdjUE4zUFFXRFM0ZlB2c2Q3RkhLSEEw?=
 =?utf-8?B?amwyeHQvRjByRXE4LzB1KzJFa2FzZm9sVGxMM09TV0NBdVpmM3M5WW45U29j?=
 =?utf-8?B?UEFzWjdoTXFLUFJvWUNDRmtRRkNOcHU5ZGpkeHVybHRzejR0cVRmTkxhVnlG?=
 =?utf-8?B?QzJPQnVEYmxjaUV2bnNsN1NBc01ISitHWTBLYldGbjNXK3VkZHZoaEEzZFdD?=
 =?utf-8?B?d3dITWxPUHBhUlNVS3JtUTdhUktrWVAxQ2o0UVF2RXh3THBSL1lZZ1lDVHlN?=
 =?utf-8?B?R3FGVWRnMHpGcFdnNVlqOHVKc3gzYXZQUDhyZUVEUjJ3YWN2dWFVekRYZk9G?=
 =?utf-8?B?WkFJckpvM0cwUE5URFBzMHUxbXNGRFNvZzNpQStrYWxkY1lzQzlvWjNFY2VU?=
 =?utf-8?B?c0tyZHVTRnQrL05zYjl6YXNJL0kwZzRhNVFTVHFPSktQNUtmdVRjNTFDdmpK?=
 =?utf-8?B?OS9HTUdLREFKZk4rYkNBWUp2Q2I4RVJTcysvc0tQODc1a2duNThMUTE3SU5M?=
 =?utf-8?B?bDR5dHlIUXY5TWRBOEdzTTBqUnp5SzIvemlUZVZac0llUHl3VUpaM21Ub3Ev?=
 =?utf-8?B?Nk1mazB6b29EZ05yMmRaRTUreXdtNExjVTBBQzd4V25PM3hrYmR5dmdUWUZF?=
 =?utf-8?B?OGlNZDk4SU9VTGFhYTc5MFhPWFRRdzNkd1pUTTBoZlJYMFVoVDZjUVVwR3Aw?=
 =?utf-8?B?WXNEN01JaWc3Rm5DWmVjNmFJZ2RNdW00VlBSOThhNitvdE1BM2VxZVE2TzAv?=
 =?utf-8?B?QlExbzNCZXI0Zys1dkhsMThqZDJrSW5jNlNjRndVTlRoV3VLazNsbVdCYjBk?=
 =?utf-8?B?a1BsN1lMQXBiZkVPQ29HSTZWWGluSE9jdEJBMFQvdjNPeWVCS3o1ZGQxSDFS?=
 =?utf-8?B?dkxPRzFudTlVL3IvalQ3N0NyZkdvTURFYmV2VjJBUnVGUkZIdTEvWldGNkZE?=
 =?utf-8?B?aFFEYmpnZXhrb0puU21HNVFpTEtUd1ExQWd2S1hVRlB2V3ZmWGJ4MUhVUWFP?=
 =?utf-8?B?RkJ5N3ZXVjhoUTd6ekdXWGFPODNVMHIvVTQxaW1vQVVlTkpVWTlTSDZKMkUz?=
 =?utf-8?B?Vk4vdHpOVTQvZGVDaHVzSjhCY0EvZlF0VndVRkRxaWFtR3hSaGttNW5tdjdK?=
 =?utf-8?Q?CKUj7LefScgMLXRc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ca64d-888c-4b44-104b-08de73124f1b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:32:40.7917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSqfXjC0RBlu7ssLpfPtCRNUXNduTzIz1Jq68qcTyvDq+041KnMfRLWYwC+zrt0LWuiA6WIWwC52of+y1KFY9Wj7NKzbIMWWUwNtK+RV/I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7446
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


On 2/23/26 22:30, Mikhail Kshevetskiy wrote:
> On 2/23/26 22:24, Daniel Golle wrote:
>> On Mon, Feb 23, 2026 at 10:51:09AM -0700, Simon Glass wrote:
>>> Hi Daniel,
>>>
>>> On Thu, 19 Feb 2026 at 09:51, Daniel Golle <daniel@makrotopia.org> wrote:
>>>> On Thu, Feb 19, 2026 at 06:09:27AM -0700, Simon Glass wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> On Mon, 16 Feb 2026 at 14:22, Daniel Golle <daniel@makrotopia.org> wrote:
>>>>>> Add a UBI volume storage backend for the image_loader framework.
>>>>>>
>>>>>> image_loader_init_ubi() takes a volume name, ensures the UBI device
>>>>>> is attached (auto-attaching if needed), and installs a .read() callback
>>>>>> wrapping ubi_volume_read().
>>>>>>
>>>>>> Auto-attach works by scanning the device tree for the first MTD
>>>>>> partition with compatible = "linux,ubi", then calling ubi_part() on
>>>>>> that partition. The partition name is resolved using the same
>>>>>> precedence as the MTD partition parser: the "label" property first,
>>>>>> then "name", then the node name. Since U-Boot only supports a single
>>>>>> attached UBI device at a time, only the first matching partition is
>>>>>> used. If a UBI device is already attached, the auto-attach step is
>>>>>> skipped.
>>>>>>
>>>>>> UBI handles bad-block management and wear leveling internally, so the
>>>>>> read callback is a straightforward passthrough. Note that
>>>>>> ubi_volume_read() returns positive errno values; the wrapper negates
>>>>>> them for the image_loader convention.
>>>>>>
>>>>>> Gated by CONFIG_IMAGE_LOADER_UBI (depends on CMD_UBI && IMAGE_LOADER).
>>>>>>
>>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>>> ---
>>>>>>  boot/Kconfig            |   8 +++
>>>>>>  boot/Makefile           |   1 +
>>>>>>  boot/image-loader-ubi.c | 112 ++++++++++++++++++++++++++++++++++++++++
>>>>>>  include/image-loader.h  |  13 +++++
>>>>>>  4 files changed, 134 insertions(+)
>>>>>>  create mode 100644 boot/image-loader-ubi.c
>>>>>>
>>>>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>>>>> index 23848a0f57e..89832014af6 100644
>>>>>> --- a/boot/Kconfig
>>>>>> +++ b/boot/Kconfig
>>>>>> @@ -1203,6 +1203,14 @@ config IMAGE_LOADER_MTD
>>>>>>           parallel NAND, etc.) using the image_loader framework.
>>>>>>           NAND bad blocks are skipped transparently.
>>>>>>
>>>>>> +config IMAGE_LOADER_UBI
>>>>>> +       bool "UBI volume backend for image loader"
>>>>>> +       depends on IMAGE_LOADER && CMD_UBI
>>>>>> +       help
>>>>>> +         Allows loading images from UBI volumes using the image_loader
>>>>>> +         framework. Auto-attaches the UBI device from the device tree
>>>>>> +         if not already attached.
>>>>>> +
>>>>>>  config DISTRO_DEFAULTS
>>>>>>         bool "(deprecated) Script-based booting of Linux distributions"
>>>>>>         select CMDLINE
>>>>>> diff --git a/boot/Makefile b/boot/Makefile
>>>>>> index 1dde16db694..7d1d4a28106 100644
>>>>>> --- a/boot/Makefile
>>>>>> +++ b/boot/Makefile
>>>>>> @@ -76,6 +76,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
>>>>>>  obj-$(CONFIG_IMAGE_LOADER) += image-loader.o
>>>>>>  obj-$(CONFIG_IMAGE_LOADER_BLK) += image-loader-blk.o
>>>>>>  obj-$(CONFIG_IMAGE_LOADER_MTD) += image-loader-mtd.o
>>>>>> +obj-$(CONFIG_IMAGE_LOADER_UBI) += image-loader-ubi.o
>>>>>>
>>>>>>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC) += vbe_abrec.o vbe_common.o
>>>>>>  obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_ABREC_FW) += vbe_abrec_fw.o
>>>>>> diff --git a/boot/image-loader-ubi.c b/boot/image-loader-ubi.c
>>>>>> new file mode 100644
>>>>>> index 00000000000..64901a13378
>>>>>> --- /dev/null
>>>>>> +++ b/boot/image-loader-ubi.c
>>>>>> @@ -0,0 +1,112 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>>> +/*
>>>>>> + * UBI volume backend for image_loader
>>>>>> + *
>>>>>> + * Copyright (C) 2026 Daniel Golle <daniel@makrotopia.org>
>>>>>> + */
>>>>>> +
>>>>>> +#include <dm/ofnode.h>
>>>>>> +#include <image-loader.h>
>>>>>> +#include <log.h>
>>>>>> +#include <malloc.h>
>>>>>> +#include <mtd.h>
>>>>>> +#include <ubi_uboot.h>
>>>>>> +
>>>>>> +struct image_loader_ubi_priv {
>>>>>> +       char *vol_name;
>>>>>> +};
>>>>>> +
>>>>>> +/**
>>>>>> + * ubi_auto_attach() - attach UBI if not already attached
>>>>>> + *
>>>>>> + * If no UBI device is currently attached, walk the device tree for the
>>>>>> + * first MTD partition node with compatible = "linux,ubi", find the
>>>>>> + * corresponding MTD device by matching flash_node, and attach UBI to
>>>>>> + * it via ubi_part_from_mtd().
>>>>>> + *
>>>>>> + * Since U-Boot only supports a single attached UBI device at a time,
>>>>>> + * only the first matching partition is used.
>>>>>> + *
>>>>>> + * Return: 0 on success or if already attached, negative errno on failure
>>>>>> + */
>>>>>> +static int ubi_auto_attach(void)
>>>>>> +{
>>>>>> +       struct mtd_info *mtd;
>>>>>> +       ofnode node;
>>>>>> +
>>>>>> +       /* Already attached? */
>>>>>> +       if (ubi_devices[0])
>>>>>> +               return 0;
>>>>>> +
>>>>>> +       mtd_probe_devices();
>>>>> This should be handled by your new ubi driver for your uclass.
>>>>>
>>>>>> +
>>>>>> +       ofnode_for_each_compatible_node(node, "linux,ubi") {
>>>>>> +               mtd_for_each_device(mtd) {
>>>>>> +                       if (ofnode_equal(mtd->flash_node, node))
>>>>>> +                               goto found;
>>>>>> +               }
>>>>>> +       }
>>>>> Eek this is really strange. There should be a device so you can use
>>>>> uclass_first_device(UCLASS_...).
>>>> I carefully considered turning UBI devices into a UCLASS, but it would
>>>> be a huge major rewrite of how UBI works in U-Boot, and while that would
>>>> be a good thing to do, I consider far beyond the scope of supporting a
>>>> boot method for OpenWrt.
>>> Oh, I just assumed it supports driver model. But surely it must have a
>>> UCLASS_BLK device?
>> Sadly no. Neither UBI devices nor UBI volumes are block storage devices.
>>
>> Every UBI device does have a UCLASS_MTD parent device, but that
>> obviously also doesn't uniquely identify the partition on the flash chip
>> which is used as UBI device -- there can be (and sometimes are, for
>> dual-boot/redundancy reasons) multiple UBI devices in different
>> partitions on the same flash.
>>
>> What I ended up doing now is to move more of the UBI detection and
>> enumeration logic into ubi_bootdev.c and have imagemap-ubi.c rely
>> on getting the MTD device and partition index from there.
> There are UBI based block storage emulation, see CONFIG_UBI_BLOCK
> commits: 
> * 9daad11ad178646c288aca3615a7ba1e6039aed3 ("drivers: introduce UBI
> block abstraction")
> * aa5b67ce226267440e64fadc57d3a21e5842027c ("disk: support UBI partitions")
>
There is the block storage abstraction for mtd devices as well.

>
>>>> Or did you mean the to-be-create UCLASS_IMAGE_MAPPER?
>>> No I was talking about ubi.
>>>
>>> Regards,
>>> Simon
