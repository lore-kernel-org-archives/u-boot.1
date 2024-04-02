Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E76EC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 14:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B64DF8837F;
	Tue,  2 Apr 2024 16:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Dk3gK45m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3898837F; Tue,  2 Apr 2024 16:02:19 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBA987D5F
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 16:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib8aycKISbYb6iQjWHFVBVJOaZtzA6bKsjVmXFioSWdCqMUu0hZUxQzRfVPwInpap3YW6E9GBWDStSwzG4P1iDSO/jEbZHAyyq0Hnfpv8W7uCXNRNyfCMewr9jhipJmkBDxHvgB+icrKe3ohxDtYmIwmSDbwTyMSIlYmbjc4L4woARiHYy31HAloS7aG1vcPLi352kSYBkiYlQyvt2Qazbyz2Ym4Ju0LpF3oGYeiqQ92caEAwT5SAQsTvD4r8/hyQ4kmy7BpRKAVmFlFhm5XxqgQNL2HJl7aoMMwLcaQDqNtp7t87Y27rLbu7aQzK/+XohuooIL+Lpps8GcDv0xjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEl2TZ62gyn+94HBTWoQBygYO7e8aq74GtjXLuTT9w4=;
 b=BmPjX/hKBzYMlLqW11cKWva9jeggZo2QvxR3AvozAsJwGbPgdvGmHEdiVFYswh4bc45W8oIPqDK77XtYDqdVuEkhBQ1eM6eucYb9s4RM0aXETqKO/5SZ3lbOeGi8m9Ds002qGgVUTCH4n3NY7Jf9yL+O4x8dtHTxEvypgUSNkBsBFRDtYdJPk2n+FUzGIjpO1CKlc0G6z3ky/r/P6f6uJgeA63sWrtr95znm9+GaE4JMP3+9hMXynk8prNYWdGgCK9S/WRU+WYVPHj0YVGBqVBiBXhE/haod9L/FhK2+aKpdp2hptc2kM0C8mMZQGJWoNATLS/+jf6ILgCTYDlXXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEl2TZ62gyn+94HBTWoQBygYO7e8aq74GtjXLuTT9w4=;
 b=Dk3gK45mYpJgmPpWwVwqXT4/Rvr7VFdBFrRHAVLDY+eWsdim8KFqO9zZDJmFshH+4lA0MxIULKQrmKzTUuieBcjsssR3FqPku+GzjoN1E4ztJ0eL/9PdCfMsNZ7hEFUoDg8MImEnBzPz9p4WLG3v2/XPXeooF3NKBoEsIm6mGUOhsaHBlfVHBQpLBXkAFwUxIZy15HEfZ6zUUYZfM9TMlNpdOMFWWDJmXTeMSKluZGkT/2LUNuQlnvUuoa/foSJd2qYXQYYhEqZ445GKXS2MI8zGlsQXMBitfOl7xagtznfix+vInmQLPLbr9jIzoEuO+BpvlDig7c9eXj3N9F4hcg==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:02:15 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:02:15 +0000
Message-ID: <eab26662-eef6-47b2-9de8-9f13d280da16@theobroma-systems.com>
Date: Tue, 2 Apr 2024 16:02:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/31] rockchip: rk3399: Add a default spl-boot-order prop
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Peter Robinson <pbrobinson@gmail.com>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-10-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-10-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0167.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::24) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU0PR04MB9227:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgvF0oHoM73OKM8dl0S/SzoVV5lPxEk/df8aO06BTpyEon9NetkXTB7v+SJaACmNxSfe+1cQIva2bi7kTq+do8bv/OIijVmVDc/pAhLOP2hDWe33u8EAosZ61Q+AAvNtcUu64f2z/1bnamBan4zdvTuzcA33RSnAgDAakI+Vwb3JadmUKNTdcFjRCM6Wy0hSLcLbQNXyhydz+erhYyFKonJx3Z+Ud4g6IZXO+wCgvZiP99NS1XSoin/Ha5YycqJ9Vqco0B5SyTC17hWQxXshO55WKwIK2t+a178pHNBH8mOKsH9xOaOegipcg4vgtBqcfztxVGga+aQ4aHh5xQd04HotqRCYij/Zzd46b5bH1KQNSLaIuF35it1h2cyv+EEjqr85Bnk4IoF/w5xrWkme0Krljkic9sbN///F48HMc9nNaBEswFaWjDA2ZLh26gkdUUpeKrjR/hz6SHVcJqCenKGfumeMxRk0N+CQMYuQ1yOWh6ENjBYilSwIHcunxgBxKgAZNyiqrLEAtWtTymbo1qBAqUHJ8dzmOMnQSFVHax8Ssc6ah3Fz6w2YrJM+do/sufTjmpaBRHTvH72vDB4WnORguMQPmJxA8aynq6OCd4JjfPtnZmOtNYNanG+1Jef4OGTq0JmsPomE+SF0QE1f/Si9hts4b453JCITwMUYbrWaw9446r7AVIb58ikSARHwszomumC4nCSVBEj7sWWX3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNrbm14N3ZEU25EQzZ5L29FTTdjZHA1QlF6amFhVFNLRGFIbWVxV2hRSjBC?=
 =?utf-8?B?OVZDdUJtUGRlUm82MDREUTFPbE9wdVcrNWlmNys2ZU1kN3JscTBWMHdON3pW?=
 =?utf-8?B?UEF4S2tlbVQ3cXJlSHp0UnZUQ1pXR2ppakx6U0wzVm45WjVqSlZkbms0ejZW?=
 =?utf-8?B?czIzWG1KSmtlcUNYNFhDdDBvMVlWUlM1SjJPMzY3ZnNZTzRDcXExTDRGQTNk?=
 =?utf-8?B?Y2diNGhsUzJkbXRGcExxWGJsbU1ETkZOV253RllxNXNjYUlSVjVUbTFTWWNq?=
 =?utf-8?B?MUFnUDhPVjBWRFRjS1VFK0NzSlRxRHNydnVXMzRjZ2ZxdXUrUlB2OTJPT2dS?=
 =?utf-8?B?K2JIZmt3S09UcTFnb1c0TkFtZy94QWI1QUdSczNSeVJhU0VLaWdnUXBNY2V6?=
 =?utf-8?B?SFpwVDByNDdWWlVCRE1kNTFTMlhSQkFjRE5ueE9JemhNc0JyczBNNkJrb1pB?=
 =?utf-8?B?eW93b1lORTkvYnRCZzlJUkpRa2JrWFY0Z1NWMEYrcWxQeEQzRkdRZkkvTCt2?=
 =?utf-8?B?SHh1SGJsNmw1WFByaDlBVnVhNHM5cTRBejlJY1cyZGQwd0hwRDMxRVVacVRB?=
 =?utf-8?B?cnFZdkdrYTQyY1FqREVUc0srVHl1ZjBjczdmUXJRZnVNSEFLdURTTEd5NEVX?=
 =?utf-8?B?TXVYbmN4SkRpbFZvQkR2VU9RcWgyQXVSbks0THRFV2NSRXc4bWVKYnBqRldG?=
 =?utf-8?B?RER0SVVPMHpFVzkybENKNkJCd1hFcWluSmVyN3FQbkhJZkw0Tng0bU4wTmN1?=
 =?utf-8?B?UnJaTldKSTJKL0g3S3cxbi8ybFBCbjZRRkFONjgzeUpjUjBERDMzTW13dXZ3?=
 =?utf-8?B?a2s3WU4vWllnYk5KOXJLQXlYbW1VNWpHZlFDcFIxL3V1TlUzN2ZmZU1nd1hu?=
 =?utf-8?B?dFZvVE9hNlEzenFDdkdxdVFTYUFsdjNoV3lqSzcrQ3VWSHJFZDZBRHd3VHlB?=
 =?utf-8?B?RCs2T0dxYlpUMGNGRTRmSzNPYkttUTlvUXZlaGpEdFN3M1FFQWtkeXR4Nyta?=
 =?utf-8?B?U0tYMEZYbEtkOTlzaDJIck9uYXljM0ZzekphMHRGTkJzblp6akxYbW55Z0E5?=
 =?utf-8?B?c3pqS0h5eng0UjJRVEhzQ0EzQnpiU0lpdHUzYk9Oa0tmNnAvKy83VldMMDNm?=
 =?utf-8?B?TXdkdmtRRkR3MTNLbGV2WGRUVTIvMmJPTnUzSXo0Yi85ODlScSsyZ2JOYmRM?=
 =?utf-8?B?aVpZNDZxZ1JzVXFlUnlLR2dXb0RTczZsUVFaeVRxK1d0UmdJQlpHOE9xNjNW?=
 =?utf-8?B?QkRSMHNEQmNKdjNTdERyTkFBMWdUc3lhSktKSnFjaFc4UVZZaGZ0L2FEZVAw?=
 =?utf-8?B?eWpsbEFpRWp0bytlK29tcW5UcWtTSXQwMCtzSzZZcDZxdlFoZHdxQktrUm5i?=
 =?utf-8?B?cnNMRmhYNXdxLzRyd2pKSVAzZUhmVGllaVBQa2svSXhYVFAxQ21iV2JOTVlW?=
 =?utf-8?B?Z1ZBVCsyT0RWSFJBc2REL3JmZmV6UEEvVnBMSHlodFlzNy9TVmI4M1l6Y24v?=
 =?utf-8?B?N1VVNTJzamdYSk5HdExuSy90ZGM0QkxESzRzeVI1NkgyaFZqQUpid3I0TE5X?=
 =?utf-8?B?UGRaekh1dGYydXBUSUN0ZnAwRVZOTE9lWlJQNmN1KzVYeFFMdjlGN0ZFNGRU?=
 =?utf-8?B?MTd0OXQ0TGZ2ejhsRUZENjl5RTdVT0wxU2g3Wm04enFNZWtCQ24yQUMzdDJH?=
 =?utf-8?B?T01pbEdaZ20xanUrM0cyV1hGZENLY3Y3a09NdklwNmxnYlZWUm15V0RLVTFi?=
 =?utf-8?B?MVNEQTNQTDVNREVuZ3ZTVjRGb3ZBVUxzMEZWdmRjV09pU2FHdHpSU01xRnl6?=
 =?utf-8?B?dlg0Q0QwSy9BejJra2VyTUIvRnQyTExYYkVxUHczUzZmNGFiQmpZRXQ3cXZH?=
 =?utf-8?B?WnBZSnRhbWZldDFYVytZZzFLUkZieW03MGpMVkFUVmVabTJob0pNRnp0U2Ev?=
 =?utf-8?B?K201UHk2UnM5citoVlg1Q3J2RnVVdVR2Y2dWZC9XeWlWb3VMNTEzOXpqTnpz?=
 =?utf-8?B?ZTdlTHlSUkJ2aGFaYjFiNCtjbFNPeXVlbGdDdVVSbGk0Y0tlQlVLOTRKT0JW?=
 =?utf-8?B?VkZwYnF6R3lRMmdlV2dwcWp0SjFXZWxWdWZEUnYxTDVLcVZETDFEak5jWjFu?=
 =?utf-8?B?dkx1WW1JS1RUcGRIZFd2ajBYSjdGZlBZa2JHWDFiVDY3ajN5R0V3azJRVFF6?=
 =?utf-8?Q?O80b1UhSGG7A+kNIvt/kgwM=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6defe2c9-0a68-4dfd-7329-08dc531d7ffe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:02:15.0677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfuW/oNHMLoTPs+xxcclw4TivuK0zE2J1/iQV2QTMB3vFde0R53I9pmk3Ocgv7VRLpSo1djA8Rr99N0+As3tfZnXDK7hGedvm+M1WlcNjacndjzxf7BlvDI3t2JifkjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227
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

Hi Jonas,

On 3/31/24 22:28, Jonas Karlman wrote:
> A lot of RK3399 boards use a u-boot,spl-boot-order of "same-as-spl",
> &sdhci and &sdmmc.
> 
> Move this to rk3399-u-boot.dtsi and make this default for boards
> currently missing a u-boot,spl-boot-order prop.
> 
> The &spi_flash reference has been dropped from spl-boot-order now that
> boot source id is cached and "same-as-spl" can be resolved into the SPI
> flash node.
> 

This is not really the same thing.

This prevents from having U-Boot proper in SPI and TPL+SPL on eMMC/SD 
card. Is this a real usecase? I don't know, we do support it on Puma 
(though I know you haven't changed it in this commit). I guess we could 
still have the devices with SPI flashes have their own 
u-boot,spl-boot-order if they want.

So, in short, I would at the very least document this new limitation in 
the commit log but have nothing against the change (my board not being 
impacted by it :) ).

Cheers,
Quentin
