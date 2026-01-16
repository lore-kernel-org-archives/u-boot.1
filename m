Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB6AC79FBD
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A03088309A;
	Fri, 16 Jan 2026 15:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mjnYJV4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6208367F; Fri, 16 Jan 2026 15:50:27 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68EF8003E
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 15:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=damIlFiSyLUMQIJu8V3UIUYlXUYBIrUCvPPuItZ241BL2iPhl2PELHOlg0ToUo6M62u20mlAGBf8NFy4YS1xZrW+wlTh+7blWocAJXXo2tf/1NuAjmfxoun2ORorNWSvSXKhp/Qz+DID3nCZKfPzZO4HA4ueO32yXm001uK91RapL2XNxvvuZ7ZX+aAyGQzIBUoMByglHfiMOiwT8mHLwi9Fw4Qek1tH/d2McpFnWyW0bpvclQ5TuNDVu0zb2z0w7YEe9IOkNx/L/+LPIAOE/R8/C7oVvxXWqL+n+ntzVe8o99GNYsKp5duJ/aoshwBA142XHZPmcue7378IR6yAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjbT7wFOIaFVKe0kBuyE2tP38xWRPV+DlOyIfvws+uo=;
 b=g6jb2jlqbKwFIAlZjoBDYW3zIXlJj5kdl1lqDvd0tTm7IwQDEJlXpTsjxB4IOj3PkMwhIHZtcL8igoC3upqla0IPI73WDX5Uw+MBhysrn7ECvv/AsBbLfFutMppbAn3s16D1LbjsgibOiFyt5frCNGi4+NZ7Ugz2jo+lu8K5Hj13lUjqLP3zETQzVjWtZ356DB7smWGSW0vtYTtMUKd7AhSJhPjx6AGpnDwqL9NQ3CQjuLLDlnDjqg5hyi2iQ7ubLXQNCjuMCRTnont/xD74Swl36+4/wVbV2GxE7F0pV5/6tLU2qQRdH0WhUvC493EoZtZ8O2PXkH6L6nRfVBL9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjbT7wFOIaFVKe0kBuyE2tP38xWRPV+DlOyIfvws+uo=;
 b=mjnYJV4T+SPYJGubE2jFOtymV6G1srSpMBpb3vu2cRNkyC56qapcJBtPxv3Li2QTw2/lnOOWJ17sRxyrbNGXlR5LNNR4xdiue/FIBXjWt+2m77EranOlBs5ZUIfkA61r9XR8CWMed8Jio1pruWdt91uTUMpWr9n45plYKu/EWd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB10354.eurprd04.prod.outlook.com (2603:10a6:150:1e4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 14:50:20 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:50:20 +0000
Message-ID: <259fc358-f72b-4a24-9a71-ad90f2081335@cherry.de>
Date: Fri, 16 Jan 2026 15:50:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] rockchip: spl: Add support for booting from UFS
To: Alexey Charkov <alchark@gmail.com>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
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
 <f6e97d23-4f92-43d1-a3b9-beeef3211145@cherry.de>
 <CABjd4Yzf-y05Qp3+5LVFrHeN_MMZu9TOXozrkjnXVU2MJU_WoQ@mail.gmail.com>
 <3b1184ab-f995-4b86-a2f0-65a5163be9c1@cherry.de>
 <CABjd4YxGYd6TVJEE3Nh9Qd6DQ+aKN09BP2u5+OBPcc8tNwpTJA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YxGYd6TVJEE3Nh9Qd6DQ+aKN09BP2u5+OBPcc8tNwpTJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB10354:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bc5f21-2600-4a8d-8f27-08de550e91d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3lvenZPbXZrd3Y0dVhKb0tFL1kyUjVOYmlsajZJdEZLcVhURXk5T1RhRm5M?=
 =?utf-8?B?dFdqbjR0dUFIVWc0cC84MGhtZDZ5UTJVL1lGV3g3WWxwTTV6U1RSRDNGR29X?=
 =?utf-8?B?RmNIZ3dqZ3J6cG5jQ3VSbUpENnEvdzJrU3RMemRRcjhEQ2VWb2ZPQmVXTVQv?=
 =?utf-8?B?QTV4WUtnZ3RmTHRwR3EydDFKVk9kWGhNMDMxenFXRWhCaDdVbTNaQUxsS1BD?=
 =?utf-8?B?dXZQNGJocitteVZCT3k5aE04QzRnSktwZGpJeEtwdUNEVVBmTGdCUUIxb3My?=
 =?utf-8?B?RnIwTXNPbjBZUWJxN3pxUkJEK25tK0ZKQVVYR2R5S1RWUE80YkczemV4QTM4?=
 =?utf-8?B?ZzdxcG91V1I0c2RlR3AwRnNqeThOeUFVb05zYzlLWTlvTDY4WktPbERxd2lN?=
 =?utf-8?B?Wng0bmhIOE1hY0ZOd0xnNWl0SE51R3BzYTBTN0k4ZlJ5aCtGMXVHVHN1d3hx?=
 =?utf-8?B?WmMyejBIMFJ4VzI2a1B6UVY5d1lLNHZ4cXBiMXh1ZzVLVzMyTEdpVXhWRWVO?=
 =?utf-8?B?cmtjRUROSmFoV0QzNUE5aWJKQlk3dDFZcFRmVm9NeFVYYzlVQWg1MFJSbXR0?=
 =?utf-8?B?b0Rtcnd3NjhCTkpWVVhJMlJja1VOUmRVZ3dlOTUrRzRCOUhjUEdNU1YzQ0Ra?=
 =?utf-8?B?V2pxaHlrbHNIYlh1a05STnRPYXNlYytaV1Y1M1ZVdTdESDhZVmlJQVBuR3Iv?=
 =?utf-8?B?RFpnZElNdkk2VDVQRVFLT0VFdy91TjFpbUk5aTJiQWpRUDllclF0Rzc0VlM4?=
 =?utf-8?B?MDFaR1c0VGs4bFhhcEtpdk1iY2Zwa2lKOVA0eWFjdi85YjR4Q1JUc1RRMnls?=
 =?utf-8?B?TDFZNVZzWDM0S3c0bm1KQlg2SldBVmhFL1g5ZVR1SDJnSmE4czI1TGk3MU9q?=
 =?utf-8?B?ZTdmZDJLMm5tZmhXdm5jRFJDVk80MUxnMldnWWY2czIzdGtUdjBtczVLR1Q5?=
 =?utf-8?B?QnIyRHoxbzlPN0ZlUThHTFBxMWhCUXNyR0NqbFg2SHdZVnR6K1RYeVdUbnUy?=
 =?utf-8?B?MU90Q1ZWemxhT245TWJSenQvTmJkTll2NElGMlRtTzIvNTd2azltc1JKYStB?=
 =?utf-8?B?QjQ1Z1dtdmNyMXBkbUJMZU9iUE9qTVMwZEdjN0tIbjF5bUQzQkdkQmd0VURJ?=
 =?utf-8?B?K3B6cktFYnMzek5qalVkdUZFTmN4SG1RenF4SDV0Zk5QblBydzJ6VUJXQWty?=
 =?utf-8?B?c3I2T1pnVGlLV0s3b0ppU2lFNUFVMHh4UEtZeHV2ZEFVcjhsYmd6NkNqV0lO?=
 =?utf-8?B?OC9ac3MwOTJKcXZYWUN2TEVZRjh5Y2NxejR0Y3d5M0Y1Tk5EbjBXOWFFL051?=
 =?utf-8?B?OHFaaXpkTTJhUzlDakt4eVRtODQ2aHlaemJDbzRTMXF3blBBN2JNenk2aUp0?=
 =?utf-8?B?QnZDWDROVVFRQWtOck9pQVJKVDBUck9wRXJ6eUo4ZkFKZGx0UFlYRGc1QmVC?=
 =?utf-8?B?YjFlVzlDVmpkcjdjcklHWGdWSHJIaDBYT2FEK0dkMm1kQXQrTkZMeWNVQ1Jk?=
 =?utf-8?B?Yzc2Q2ppQ0Fqek5rV0NoUVcyY1F0SEhNcUU5K1NlbXNJZ1p0Rkx3Z2x4Tm95?=
 =?utf-8?B?V3l1ZWw0bjZqQ1VWVmRzQzhWYUJhcXl2VjBNQjdKTVpvWW9pQmJzQmNVNkdL?=
 =?utf-8?B?azUyYUJCdy9RTVhuaGRGZWZKc3l2dWJUZEZQdVFlY2dKcS9YajVmTEF6aG9L?=
 =?utf-8?B?cEljN01jRjVRMmlONWp5TFpGUmVTSVkwTjRIUjRTbUNRaDVrZjlSRmx6YWdW?=
 =?utf-8?B?ajJ4Tmp2T3habGp3QmUwYU5oYlNXbnl2bEEvcVNiemFYdHQ2cGdJTlEyaGp0?=
 =?utf-8?B?aERCVFNHKzM1a2wzN3Qvako5bUpTOFo3Z3BpaDF2NldlVi95SE1qZjBNa3M3?=
 =?utf-8?B?bDdOWGtsWmZlMjQ2UU5yWXNDaFUyODVYT1J4MWY5S1gyMTBpbzltc0xtbDVa?=
 =?utf-8?B?RzJkOWNzMnc5Ung5VU03b3VhV0lJSFlteFZwUzM3d043RU9zL3hPRS9HV3VG?=
 =?utf-8?B?aWF5VDBXUGtKc1lrdW1EVXY5UjU2VlgwckhVaUc5NGR3cXdCcFBDZlFMRzk4?=
 =?utf-8?B?OEVNS2ZoeGdpLy8yVTQzdFpGZVVZZ284VjNFRWRsM3EzN2xKZ2E4NEZzVU5Q?=
 =?utf-8?Q?/xw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFA5SktSOGQzbXlYVkNQcDNLbCtZYjlZTG1DVW54M3A1Rm5qeW5zL3pBSkpH?=
 =?utf-8?B?S2c2dXFJTS9VZ1NoQUc0SnE1WkpqVG1MN05mL3RqaXRtTW9LSXFtalprQmlY?=
 =?utf-8?B?VXNDaWFUcVhzQytacUFyTk91R29tOXp6cFZkdmVxakxOSzZSSEV1RjBuNEhN?=
 =?utf-8?B?QXF3RERROGdzTGh3Z0pyckJmRVEwZDFOQ0doellmT1dEd3V1cGtpdFNLQVVa?=
 =?utf-8?B?S3JuN0kvVk43MUlVZzZvNjcxaUpDYVBISEttaWg4TEVvWFNWSk1yTUtVNFNv?=
 =?utf-8?B?SERWMGd2NjF3QWJSN1FwaU5hQXFCNEtiVU5NL0JBcEVtbmVRQ2xSbDUydEs3?=
 =?utf-8?B?SmhqWTYyUTRIbW1YOFE2K2xpeEt3VTJadHZlMGhNWGtQVmhSYnBEZU52Z0Fr?=
 =?utf-8?B?UDM1dTFVblZoSkd4MEhqZzhYZy9GTnhRemJaM0p4Tnc4Y29EdFBjaG5FYURN?=
 =?utf-8?B?Qk04b0xLUzFZeHZCUnJXa2VUOHZBdmFjTTdqR1BxcU9VZ3NwK2o1TTVlT2kx?=
 =?utf-8?B?YVVkSHhiTFM4b2pVOFA4dWJ3dDNGMnVCOTgvOS9lQmJYNDNJSmdkaElER0pz?=
 =?utf-8?B?QU84UGF4d1Boa2ZPRTdIemkwUWhsZGwrSlV2M25xNlVHMG8yQk8xeTFqTHZO?=
 =?utf-8?B?aTNUb3BXaUgraGlqcmtqU1dtTkR3QXB3cDB5SkRTdHhpN0NYY3dmUUU1QU9S?=
 =?utf-8?B?cGxSY3hvU1pGZzhScGhYSjIzQ1ZnK1l5b3gzbFJ3QWtiZlBOTzdMNWV6MG9F?=
 =?utf-8?B?WFFUVlhkR0hkbS9tYlpLNEJWSkVtTFpmNTlYRzArMDNBV01OTXpSWGFmUldq?=
 =?utf-8?B?WllGWC9vN3F3ekY2RXAvYUc3TVJBcFZ3VS9URFI3NDhEbjFNVVlyWlVxbmRB?=
 =?utf-8?B?eGRwQklIZXJhN01DdHZTdlg5bklBNWhpRnB0Y3drWnB5SnRxMzBlUEs2RWdX?=
 =?utf-8?B?dzdGblJNNzVRWThwUnc1QUZ1YjEyMkovMFl4cXk3d2hmcUhMbmRiRmk5ZURU?=
 =?utf-8?B?RW5qam1kbzNEcXlaRFltWnVyRFZKQnRCNVZnWEsyemVmaG5zcWc4VVlNcnB6?=
 =?utf-8?B?VG1WQWkwV3diUThwSHpuekVtUDJCMG14eFhPdXBzM0IySWlNREIzSTg4a0Qw?=
 =?utf-8?B?M2NGUW5jc2ZyYW9ReFJIbEpPZ1d1UDU0MTdRK1RnVUk1M2JDcjFaV2pkOVBy?=
 =?utf-8?B?b0VXL2N1U0FuempVckhtaFNiUHUxK2xGVmNYOXkvbW5td3BBMjhIOUswcVU2?=
 =?utf-8?B?eE9LVDJxSDlwUDV4NjY1bkRFUktuSXYzb25SaEk5U3ZIZElZbnBkZGs3WlpJ?=
 =?utf-8?B?MWJYRFNoUCt2TG84R29QQmhZbUd6RnQ4VkdrekR5SEVtQjNDYS9TYmhneHJS?=
 =?utf-8?B?K1ExQmp1VjlyTUkraEh6VVNYbkwrK00xRURmbFdRdjBWbWx2NTlWRmxXN0hR?=
 =?utf-8?B?dWkzRkJpb25QT2xaTkgyWm5DVDV5bG1IMHJ6QkJBWlJ2K2luN1hJYit3MVUw?=
 =?utf-8?B?a3c3NlhJRkM1NGZlNGdaR2RPMHZQUytKUmk1Q3A3Nkt1RitvMngrSStOWWF4?=
 =?utf-8?B?aEtSSVY2aURUL2FRRWkwbE5tYXgzQnpNemw3bzZ2a3Jlc2VVZjEyU1lrVE1K?=
 =?utf-8?B?L3k4VWZOS2xjbUM3aTBialNyTXdNd0s5NHgzTUhsRWNtQXd2UDV1UERab29h?=
 =?utf-8?B?WFcwZ1dKMXpsNGM2Z093UFJwTFo0RG9UY2RmLzVvZVYrZlpWU1k3M3ZUbUhO?=
 =?utf-8?B?RmhtS09qdlBxbXVzSUZGc05xMmRyU0RnVDBYVkk0NENBRlIvS2hsdGlZL1BT?=
 =?utf-8?B?Yng2V29WRm13Q2ZYcEQyYXlNK0JRSFJpUlVVOUlBUFpyWjZqUlRpOU1MY0JL?=
 =?utf-8?B?TnIrWG5FZEVYSHFRZDhlQTVBNXRJamJiSEJZU0hodGxmL3hvaHhFSEVXV3BZ?=
 =?utf-8?B?ZW9XU3lMclUrMGhrTUpiNFZ6S3c1YWd6cUJXRldsSVl4d2ZVdWFKRnVaZEVX?=
 =?utf-8?B?Q25iakVEVGZQWndNeVhHMmxPSDM4YVAvSGh2QXlodkQ1VkNoRkMreEx0NEZ5?=
 =?utf-8?B?azBzYXVGNzJSckFhaHdvWW9HY2hRMkZjNFdWdWkvZzlCby9QZFNLT0xhN2xX?=
 =?utf-8?B?MkxCTDFkaWhpZmdSWlVzZy84dndKOTQ0VnBMUWNXd1FuYnpBMUp3TjBMNWN0?=
 =?utf-8?B?VGY2Y0NKTmUyQWZIckYzeDBmeElVblJWVGxqbDV3ODJjU20vdVZVc0ZqY2Fj?=
 =?utf-8?B?aVVGbStKTE9yMTRXVE1JTkVQSjdET2w4bHFraXBqdS8vakZLYlgzMVE2Q2R3?=
 =?utf-8?B?MFBlU2M2UnRVckR6Umk0eFlxbW82Sm83eGtINXUxN0VNOEc0SHh4NHduRTJV?=
 =?utf-8?Q?YpDf+Cn9Yh9L0Ba/FEey/PXNH17iuHOh2qUhN?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc5f21-2600-4a8d-8f27-08de550e91d1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:50:19.8436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUHghKDtZ1wiUUK3BDpVz9vagt0sqaBn8ejOdIPex/CM/Afe3C4OP1JwD6Tjbpr5gqbnApTij0d8rlKm21DoG1fnJvaFWnucEl2W4fzzjnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10354
X-Mailman-Approved-At: Fri, 16 Jan 2026 15:56:30 +0100
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

On 1/16/26 3:29 PM, Alexey Charkov wrote:
> On Fri, Jan 16, 2026 at 2:50 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 1/16/26 11:08 AM, Alexey Charkov wrote:
>>> Hi Quentin,
>>>
>>> On Wed, Jan 14, 2026 at 10:05 PM Quentin Schulz
>>> <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Alexey,
>>>>
>>>> On 1/8/26 6:50 PM, Alexey Charkov wrote:
[...]
>>>>> +&gpio4 {
>>>>> +     /* Used for resetting the UFS device during initialization */
>>>>> +     bootph-pre-ram;
>>>>> +     bootph-some-ram;
>>>>> +};
>>>>> +
>>>>
>>>> Is it always GPIO4 for the reset GPIO for UFS? Seems like something that
>>>> should probably be put in a board -u-boot.dtsi instead?
>>>
>>> It is in fact always GPIO4 pin D0. It's multiplexed to a
>>
>> This is probably the typical Rockchip BS :) It is the "same" for SD CD
>> or WP pins. They have a hardware-controlled mode for pin A which is
>> usually a black box for SW (nothing to do, it "works"). But nothing
>> prevents you from using another GPIO for that (just have to be careful
>> about the voltage level I guess, here it seems to be 1.2V for the
>> domain, which isn't that usual I guess.
> 
> I bet that the boot ROM might get picky there, and only work with
> GPIO4_D0. But if the UFS chip is not meant to be used as the primary
> boot device - sure, can't see why not. On the other hand, there's not
> much direct gain for board designers from using a different pin, and
> people tend to just stick with Rockchip reference schematics unless
> something different is explicitly required for their design, so my
> money is on "it will be GPIO4 for all RK3576 boards".
> 
> Extra consideration in the same stream: the pin itself is defined in
> rk3576.dtsi upstream, not in board-specific .dts files.
> 

OK, I see that rk3576.dtsi specifies the reset-gpios here. I guess it 
should be seen as a default value, like we have for pinmuxes. Also, this 
is lacking a pinmux for the GPIO, so there's no guarantee the pin will 
be muxed into the GPIO function before you control it.

[...]

>>> controlled mode would also deviate from the upstream DT binding, as it
>>> stipulates a GPIO for device resets [3].
>>>
>>
>> Not asking for this, rather wondering if we should really have this at
>> the SoC level rather than the board level. If it can be any GPIO why
>> forcing all boards to have GPIO4 bank "enabled" in SPL + U-Boot proper
>> before reloc. It isn't the first SoC to have that (also see all SoC
>> u-boot.dtsi having the UART controller from the reference design
>> "enabled"), and I don't think it's planned for us to have a product on
>> it, so... not a blocker from my side :)
> 
> I believe that the boards which don't use UFS for early boot will just
> compile it out, together with the respective GPIO code. Then the only
> downside for them is a marginally larger SPL DTB - but not on a scale
> that matters for RK3576. And those that use UFS for early boot will
> likely want it to be on the pin expected by the boot ROM, then having
> the prerequisites already defined makes life easier for them (and it's
> not much different from having e.g. FSPI0/1 and eMMC enabled by
> default even for boards that don't use them).
> 

My hunch is the BootROM may not even attempt to reset the UFS chip and 
rely on it having lost power (see different ways for the PMIC to reset 
its regulators when it's itself reset in SW). But I have nothing to 
prove this :)

>>> [1] https://github.com/torvalds/linux/blob/master/drivers/ufs/host/ufs-rockchip.c#L220-L231
>>> [2] https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/ufs/ufs-rockchip.c#L222
>>> [3] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/ufs/rockchip%2Crk3576-ufshc.yaml#L53-L58
>>>
>>>>>     &ioc_grf {
>>>>>         bootph-all;
>>>>>     };
>>>>> @@ -176,6 +182,11 @@
>>>>>         bootph-pre-ram;
>>>>>     };
>>>>>
>>>>> +&ufshc {
>>>>> +     bootph-pre-ram;
>>>>> +     bootph-some-ram;
>>>>> +};
>>>>> +
>>>>>     &xin24m {
>>>>>         bootph-all;
>>>>>     };
>>>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>> index b15938c021d6..f9ecb6858f04 100644
>>>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>>> @@ -51,6 +51,7 @@ enum {
>>>>>         BROM_BOOTSOURCE_SPINOR = 3,
>>>>>         BROM_BOOTSOURCE_SPINAND = 4,
>>>>>         BROM_BOOTSOURCE_SD = 5,
>>>>> +     BROM_BOOTSOURCE_UFS = 7,
>>>>
>>>> Hopefully this will be the same value for all upcoming SoCs with UFS
>>>> (and not used for something else :) ).
>>>
>>> Well it's hard to guarantee (otherwise Jonas wouldn't have had to add
>>> a translation function [4] for the IDs that changed in RK3576). Maybe
>>> at some point we'll have to switch to a lookup table per each SoC
>>> variant if these keep changing, but thankfully that point is not today
>>> :)
>>>
>>
>> See
>> https://lore.kernel.org/devicetree-spec/ebc08400-c16d-4ed0-b487-9aabe13bbf0f@pengutronix.de/
> 
> Ooooh that sounds like a discussion that can potentially stretch out
> for a long time. I'd much rather use a value that works for the only

Anything to be added to the dt spec is taking months if not year, even 
when agreed upon.

> chip where it matters now (RK3576), then solve the problem whenever it
> arises (if it does). After all, bootrom.h is not ABI, and DT is, so it
> is much easier to fix up bootrom.h without stepping on too many toes.
> 

I'm saying this will solve the problem, not that we have to rely on it 
now :)

> Furthermore, I'm not even sure that /chosen/bootsource can address the

It's not /chosen/bootsource, this has merged already in the spec and 
won't be usable for this mapping (lots to read but it's explained 
somewhere in the thread).

> issue here, because boot ROM's won't magically start passing DT
> phandles to the bootloader, so there will still be an ID->node lookup
> table somewhere in early code (with potentially per-SoC overrides).

No, that's the point of the thread I linked. The idea is to provide in 
DTS the mapping between the value in the register set by the BootROM to 
a controller/flash node somehow (via phandle or something else) so that 
we don't have to have this table in code at all. After all, this is 
hardware description (albeit based on BootROM "API" but that cannot 
change anyway, it's silicon (if it does, good luck all may the odds be 
in your favor)) so there's no reason for all bootloaders to have to 
reinvent their own sauce (see barebox doing something different than 
U-Boot there).

I read the BootROM register value, I read the DT property with the 
mapping, then I know which device it is. Bonus point, you don't need to 
keep the DT node path in sync in your table, because the mapping is in 
the same DT as what it refers to.

This is not for now (and I should probably revive the topic), just 
wanted to tell you there's another way to do that and we should probably 
aim at doing that in the mid/long term (and then all this in-code 
mapping won't need to maintained anymore, and there won't be conflicts 
between SoCs having the same value for different meanings, or differnet 
values for the same meaning).

Cheers,
Quentin
