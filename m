Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B093ECE8D78
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 12:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E80E89156;
	Thu, 19 Sep 2024 14:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="htJTvNlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA7F8914A; Thu, 19 Sep 2024 14:04:56 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067478915A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCQp/IEgNvgkFVfgDUSJvAAwCXsqhufKKmRD0nxqCG3DZjPZRTwUhLCrTAu2mZwrNZ9hIxuwZJihAX3qAC0aAq0EbBZsj9P9cxkDqP+9vtbEQFNS6lC0tsLiT4aOZbx4cdaOFVOtv1c4VvrbEnoDGYXvyvhSs+mdC8nPi2zj84snf9WR5nHrWREEQjJIcun0CrLXw4PYs1QvIIFg+yA9/a1C7w7Fx8AxKImEfrcoNjaNsQmRwplthQqtA1oGcO1DcujR+AsrEOkWKteSPbCwXaBnnFdGsAiD4Qbk1EePRq7joN23Fn/XcMDe7jEBR+ketTXCip+OlA8CAFXAj6oaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKdzMQziTzjjhtz2rLkmTMdUdqJNpPKddBu0PX/xay4=;
 b=XkonJZHtIt9f53MNvxylD6ydWmXIE03Db4yXEayPimdozdvATTwFTMEu1QGot5hD0B7uDLyzsAOhXW91L/ghJ8ez09s1c07joQkzlSer+zy3I8d0prrEfbC8/eEcMXpXZ9TzVPEhsZFoqCXoSVobctSysomwKjdpch6AuCo4IeYzutsIgd0y0P+pr6CLqYa6EjzCGnQnyHUUIL3q3C86Zl1loRHLoaqN9/CS8+1z1ErRHUWdQ05UGfSn4WmUszUZFPtzvwbqLAyp3VDR2oa02cbv7gh0+jGc0bg+uHPxjA90UYIfNx3aSCDTSPhWM/hlZwG3Y1fdtrsU77tEkHID5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKdzMQziTzjjhtz2rLkmTMdUdqJNpPKddBu0PX/xay4=;
 b=htJTvNlzeaqTIzDn00h8cnK3CXmJZloC4S48YYML9AiXgbRvBOozt5qJXsIcs58ZjHfi4EZuKgawAUgaYqut45unGJLBJpk7Y7CMFgPV2lATRDrXCp0hE0nW1bDhj2J5qUq240qzdKFBmoDaP1IfyQKiwB42VNaf0wTsQ7q8GgbfyJW5QTgN1a18YSppDOm0CjawiumqukWAghBlFFc2QgAir6o2lqXckl312oo/7rVAo4bkw+sSsux6OHQlBtRWSYEPKUSa65yxwULjdxlibc1BJxTI3kEjAypLj07fL7Em3gC52/zqJzVUxRARNlcx47/4z+H7FoexMTqgFG/F9Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7945.eurprd04.prod.outlook.com (2603:10a6:10:1f3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 12:04:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 12:04:50 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Frank
 Li <frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: RE: [PATCH v3 00/21] imx9: various update
Thread-Topic: [PATCH v3 00/21] imx9: various update
Thread-Index: AQHbCj+7We/VTYukhEOYwkmUukigWbJfApKAgAAAR4A=
Date: Thu, 19 Sep 2024 12:04:50 +0000
Message-ID: <PAXPR04MB8459D095C973BE2FBB7F488B88632@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
 <CAOMZO5DRGHjbE0xRpNhYjdRwYnacPghLFspp_9m1K_YGvyeCfA@mail.gmail.com>
In-Reply-To: <CAOMZO5DRGHjbE0xRpNhYjdRwYnacPghLFspp_9m1K_YGvyeCfA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7945:EE_
x-ms-office365-filtering-correlation-id: 734e2915-0ef4-4277-36a0-08dcd8a3436c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cXZmZzUrWWZrZUt3a0JZdTJtODh1YWVxUjZybmdCK3BpNTlkbnF5Y043OVhY?=
 =?utf-8?B?YWdmdlFRbDNHdW1NMG10aGhWRXJpR2xlazJnSmZvVHpGZWR5c0txNDJiSE1Q?=
 =?utf-8?B?WHZ0MzJoTU9wTlVvRncrNUNXaGtIaEE2VTB3QzQySHNBelZyc25BeEhrSTJT?=
 =?utf-8?B?ay9IWUM5QzREdWhLZTRwK1VFbVNiUzI2emd1SjArNWhlMk9KbFdQRGh0dGFF?=
 =?utf-8?B?cW0zRkkza2hnSTFCNnZoUG1lTlJITXZiSUdsZjBVTyt1Mnd0aCsrU01WZS9j?=
 =?utf-8?B?TnZ1NWd4TStSK0ZSRmVaOTE4cGxlZS9STGlFSnVDazEzN3NmWm9lcC9GTmFo?=
 =?utf-8?B?NjcyN2ZDM0NwMlZnQ2ttVUtFV0NMS0M0RWU3VWQzbHJRSXQ3U2VxMlVMUmVY?=
 =?utf-8?B?M3hETUFhOHFHNHdNa09DQjBqYVQ1Q0Y5MDZ1NWZTL2loTE1sdXpTMkwrK3FY?=
 =?utf-8?B?eE9uRytYMmxBb3FUSTY5TkhIeE1qUUJnZDd1QzVTYkNKN3M5ankwZHljTXNS?=
 =?utf-8?B?WlRkWm50TXU4aExYYXY2ZDM3UHBvakZWSWN5dTI0aVFMWmo0eGpuaWZmdEtT?=
 =?utf-8?B?MzQ5U0hCalZHV2d3SU1ubG1VbVFSSm9IZUFLakg0TGs4N3NtUTI2RlZWejRw?=
 =?utf-8?B?Ly9ScjRYc2lIUUw0SUFOWnNzYjJ6MTQwR2NUS3JXWUJtd3hnS1lHSEMzNzhi?=
 =?utf-8?B?TGREL3dLaEF2dW1aUytJczFYR1VURStLWWpQb0tjQkkrL25wT2VQYVhQTHAy?=
 =?utf-8?B?V1ora3pNa0JmMkczV2tWaUx4dGVmYjZBa2dIQ1Y2Tmdna1dlNFNTMzZJTm1l?=
 =?utf-8?B?WmRoYWp3YlpIMGlxb0lTZjUrQ0VtL1lUYjR4bitybDBsUkt4bjdKa0dhZ3Yz?=
 =?utf-8?B?VDdsMFo0RXh0QURxQlUwc2xmenUxVFJXMXZtWWp5bmtvQ1NpenJlaFVYS2Rz?=
 =?utf-8?B?TnZIdU42RXlZUUFNRFpQQW1WWnJYYURjNWlzQ0VqcnZKNEVvZVR3K0w4aUp2?=
 =?utf-8?B?TmVuMVRwVEVOUll6dmppMWtwK01IOEdmTXdHNGZMcDlFNnRjTkM4Slhsb0pz?=
 =?utf-8?B?M1FNQzVvQjhtcVE3bzR6Y1EwTkZyS0pacmF1QUhoai92cGhoUUxPU2xkZ0VU?=
 =?utf-8?B?ckc1V0orVCtTZ1pPeWNUMU53WWZXbXlPVUJmb2xiUzFIMHlxSjlQMGV5c1pT?=
 =?utf-8?B?SExwNUFndzJXSFN3bFlHWCswV2V4bGhPdHlhWEFTL2FGUCtrQkhpUEgyK01V?=
 =?utf-8?B?YUNsUjBUMWg2TDNCUTVkYlhEcVZVcXA4RnF4Z3hnbXBpQk50b3NTb3h5VHdK?=
 =?utf-8?B?b0JVK2NlLzh1NDBSZDdRc2JTUDk2UTQ0U0Q1SkV5cHhHN1p3WjF1NVAxSmph?=
 =?utf-8?B?NHZTNWpIRXFmV0ZxMWhuV3RBanR6NjZjbmx2bHRHSDJ1MjZMWjh1OURJWFVl?=
 =?utf-8?B?N1hKS1pzY3h3bzVaNEtYRmNFT0phZitVNEp0VTF2TGcydURmUzBvOHo2R2pB?=
 =?utf-8?B?WEJxZjE4cTZWRmxyWGN3M3U0U1BlK2VPWlI0UjFLZDhKNmtwNnBWK3paUDdF?=
 =?utf-8?B?MUlkR1UyaUdHRzhoOERMSU1OM1RMUGFXSnRCeUVCam5xVVYyMWV3Ly95WDNp?=
 =?utf-8?B?N09tcFZZZCtFN1pXS0p6V21kRWIzOFU5dE5rZ2N2SmFBNEdBSXcrWkdRM2Fm?=
 =?utf-8?B?REZ3NnZOVGl1NVhMeFY4bUFsSGp6cmJuVkNCQ0p6NXFQTzJwejZmdmJkSmJt?=
 =?utf-8?B?WDFEbDNPRjhiZ3FGTmp0ME8ycTNQck1XeGY0N21rOEI3UjN6aFQ0d3N3elFl?=
 =?utf-8?B?N1U2djV5bEV6OTh2R1FUQUhhczc4TjE2VGdCUU5HeXJJL205OWNObG9oV2N6?=
 =?utf-8?B?Yk9jc0J2dWQwT256dlY1eEVBSEp6T29sOElBSlF0djNMV3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUh3YzJjS05RdDlmZXRib2dGVnRodnd5c1BaRlF1YjFTcE90QzVXYzRUQkJW?=
 =?utf-8?B?ak80czJXS1MvcDdKUTVQdUgwQUc2Q1pid2RURjIzc2h4YUliNE42VG1KdWw1?=
 =?utf-8?B?R0JoQzJkaUllYzAyZVlSUXhOakt3ZDQ3MUI2Yzd6djZnK1Zxa2RFdFQvMmE5?=
 =?utf-8?B?RHdHeE5MWXl0amoxVE4rTXBzSTFxR1JHZHZnWmxSQUlxcVplK0pLNEJOR01m?=
 =?utf-8?B?MC8xQ1o0b1UwZjYxTVgxRnB0R0NuNzFFVk9YdXlYbzRBdjFJclprS1piRFho?=
 =?utf-8?B?am43TzN1T21SS3c5K01CMGw2d2txTGdBdmdTL0VsNVl6SG9DdTdka2c2QkNm?=
 =?utf-8?B?S1Z6OUdjcXF6VHlpSEdOUE9EY3J6YS9DRlU2bTNjeTJRNWFLeHRISUtIaUdT?=
 =?utf-8?B?VUw3K1lsa05ZSWJsTTBLQ1hVcnRreTZKdGJCZEtOQWRySitIaFVjdDNPSllR?=
 =?utf-8?B?L2ZJV3ovOEZqeG52RkJVT3Fwd0lIS1VLUjl0L0Q5Yi9KQlJONkZvTjlOUTYz?=
 =?utf-8?B?TFhnOTlpbGZYNGhiNkYrYUFzb0NPRjFLOE9vZ1ZRTTBFTkRlaHVOM1d4emRM?=
 =?utf-8?B?bTMvZ0h2VitxMURjNGRhcFBsdkNNdStGMERkRlZhVTFIZzhKcm9jRUk4OXow?=
 =?utf-8?B?VzF5c3dKT0RRdUhrRDRqMzh5Q1FiME56VWpOMmQ5Tnd4RTYwSWhZWXRxSXdj?=
 =?utf-8?B?MnRob2dkWDlrVWpDRkFHQ04yaEVKR0dXTGxQYXNoQTJGazdGdG1hZVhsRlZ6?=
 =?utf-8?B?ak15NFpwRUZxRnBsVjBiSEFhUGdBbitBL0IzMGtyUWRzM0pKcThCak1VeGdz?=
 =?utf-8?B?WFkveXpXclpTTkNmdlViNktDbGtTRC8vVi9qNUFCbFFRQ0EvUE1Bdk9DdDgz?=
 =?utf-8?B?WjJXOU0rVTFXT2twdGd2M3Urc09zWmFKYThpUEhHN2VDVHZrbGdodWtycitS?=
 =?utf-8?B?U3UvMnZSQjJmYVVHVWtzNU1Ba250RnBZRnhDRlFIQnRWbGlnOXFMTisrbm1n?=
 =?utf-8?B?b1YvU2ZUTzE0ck1MRUl1d2UvQTcvWlZiZElFOXNEQ3hyQ055YjRTVURCc1da?=
 =?utf-8?B?ZTdGMEg3OEI4bElTL3VZR1pVTCs2Wjg0c1RXNDZJL2FFZXdiWVFoY21iQXRm?=
 =?utf-8?B?TUpuV05EMTQyU2Jxc2VzaFZRZ2VYN202aTl0VExyVDZFRWh2Qm5hNG5TQ0xv?=
 =?utf-8?B?QVl6Y2FEYTYwQlNYRXZRUHNxc25Sbk1QRUVrUkdXbDlib1R6eko5Nm9HZHo3?=
 =?utf-8?B?Mm5UeFJpU043TkVhM3IvMWhzSkhHQURyZlovSTZNZFdTOFp3Sm95K2h1akJJ?=
 =?utf-8?B?MzNkdmd3ZU1KZXlwWHc2YjlqNjJNaEpEZXZLSnRRNXk1TEYrRFdja2wrTldq?=
 =?utf-8?B?ZEZXVjdSYWpZSkh4TUU4SmhVaXVOTkFlZTdqZ1hkVW1TVTJzeHZHM0h5ZjNH?=
 =?utf-8?B?WWl2R25adVROdU9YQnNyRUNBL1ZBYi9LV05MQk4wMHNUem8rWVAxUmYyM3lh?=
 =?utf-8?B?cGpNdnp2dkF3VXoxNEFRNTlESDBKby9ZZGtSc2l6bTFubWd3cXhLWFgvUVhx?=
 =?utf-8?B?K1lQcjZHY1FOVDNTNDcvejF1ZDVXc1VhcGxSd0U1NHVHS3pNM3pIV0ZLeTBw?=
 =?utf-8?B?N0ZWaWF2U3ZZQVdQbGx2TDQ1eUJnK0FGZVgwbkVDRS9mNzh3QzJxK1dWK2Rq?=
 =?utf-8?B?d3ZXUUlmVGtzR0Nzd2ZNemJNeXdCVEQzeUp5WXBLR2dFVU5hNitpL0hFQ0NS?=
 =?utf-8?B?dGl6RGVhVno1TndZZkVWV0JXOVpPUlQ3ZzB4QnhHdzhYTkxpZS95YVhzK0xD?=
 =?utf-8?B?d0R6ckN4UWRNRVAxcXp3WHNqODhuOCtWV3Rmc2xxUWJxZVJsTndTMVNwYTVF?=
 =?utf-8?B?SjZtR210dmJSeTM5Tkk1VWtuN2pLL1BoM2I1UFZxL3lNTjZKSTVqeXNFc2ZK?=
 =?utf-8?B?STVZaXdOeHFpMUNHbGxmOGxhMGZzVzBmZ1ZVZjJGNnhFdUdUdW9GTG12bnZy?=
 =?utf-8?B?ZUx0ZCtrMHFmaVNyR0JibXdVYXlZbXhKQ3RzUnVoS1YxTi9FK2hGUngxNnNk?=
 =?utf-8?B?cUhZSUZIYXZnTmFTVk9zcit0ZU5tTmdkS2NJNGRiM2hINHRDZnp0a3JPMnl3?=
 =?utf-8?Q?I3y0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 734e2915-0ef4-4277-36a0-08dcd8a3436c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 12:04:50.2064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcVNfqDmMN72Xe0+Q8udCFPoAQwsVr34UP7Y5/YKm0M4LJ+shZZ/5cQkrtcz7SWysdwSVleltWmYsimZbdhbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7945
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMC8yMV0gaW14OTogdmFyaW91
cyB1cGRhdGUNCj4gDQo+IE9uIFdlZCwgU2VwIDE4LCAyMDI0IGF0IDExOjU44oCvUE0gUGVuZyBG
YW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFNldmVy
YWwgdXBkYXRlcyB0byBpLk1YOSBTT0MgYW5kIGkuTVg5MyBFVkssIHRoZSByZWxhdGVkIGNvZGUg
aGFzDQo+IGJlZW4NCj4gPiBpbiBOWFAgZG93bnN0cmVhbSBmb3Igc29tZSB0aW1lIGFuZCBnb25l
IHRocm91Z2ggc2V2ZXJhbCBwdWJsaWMNCj4gPiByZWxlYXNlcy4gU29tZSBhcmUgZGlyZWN0bHkg
Y2hlcnJ5LXBpY2tlZCh3aXRoIFItYiBrZXB0KSwgc29tZSBhcmUNCj4gPiBtb2RpZmllZCBmcm9t
IGRvd25zdHJlYW0uDQo+IA0KPiBBcHBsaWVkIGFsbCB0byB1LWJvb3QtaW14L25leHQsIHRoYW5r
cy4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIGFjdGlvbi4NCg0KPiANCj4gTmV4dCB0aW1lLCBw
bGVhc2Ugc2VuZCB0aGUgY29udHJpYnV0aW9ucyBpbiBzbWFsbGVyIGNodW5rcy4gSXQgaXMgZWFz
aWVyDQo+IHRvIHJldmlldyBhbmQgcHJvY2Vzcy4NCg0KSW5kZWVkLiBXZSBoYXZlIGxvdHMgb2Yg
cGF0Y2hlcyBpbiBkb3duc3RyZWFtIHRoYXQgd2Ugd2FubmEgdXBzdHJlYW0sDQp3ZSBjb3VsZCBz
ZXBhcmF0ZSBpbiBzbWFsbCBwYXRjaHNldHMsIGJ1dCB0aGF0IHdpbGwgYWxzbyBiZSBtYW55IHBh
dGNoc2V0cy4NCnN1Y2ggYXMgcGF0Y2hzZXQgMSBpcyB1bmRlciByZXZpZXdpbmcsIHBhdGNoc2V0
IDIgZGVwZW5kcyBvbiBwYXRjaHNldCAxLg0KDQpBbnl3YXksIHdlIHdpbGwgdGFrZSBjYXJlIGlu
IGZ1dHVyZSBwYXRjaGVzLg0KDQpUaGFua3MsDQpQZW5nLg0K
