Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2441CEBF8A
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 09:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E528907D;
	Fri, 27 Sep 2024 11:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cYThHN3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7231C89092; Fri, 27 Sep 2024 11:25:29 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC8489071
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 11:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxuZbWRhARf8GGdO8jI9ytt87wvlcBPWAYZlPyda4PpeEpVknNiMkFO+zD/dyFhOddSmaXwIbyjGAJKPK6ceU7jKM91V8GTUx/X8pOQp8p0CnwEx0FfJAK9/vv1Q6Mk+5JhztQgb+M+cSDpcvKF0Sgxcsqdgj8HEspX4Ee4e3edCnTiUrHsekOb6x/gpNpg7C7OOohOUpiIzboB6rqWzc1Lp3BoM4x6C9yJH9Nzh0UhJPJiwMeOfKzLjO4yDv306di5ckfc6MdawYf5ahyPWL86yisd9g0ajILNS7hX0FFB7ahZapFe0TPnM+fJSFk0JMRPBzM4wo0+Gc+DKkPkM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp/jVetmynG/BVAXFZKyiEYZgGyvjuzcDvbQknCkv9Q=;
 b=PHKjbz/KnfsCbZ02ACHw1fUxT2UhxO/tmWI2rN03uHPnoWgV/JkOZnJNuBt+HaZi1ti9bQ3hTHV0k0gOIdBfTApeuwuw3jItT6m3mry7rsmc+EzY2mfH2n/sA2Y5gu6xCBh1Tu48xpGracMphxFJApan7qcQNVDICogKjKe1pQCxqHmHWwDtxbc8WNEwujPEQs1BXJGty2IFUBnyjBP9U9ia9FLz4nDzL2uL8ewH42LR08K5WPHC4z1h93G+X41ZklzxHkykl+ii+GdC0GA/WFBTgpt6Wyax/Fn/YCMdj20Aw5qGka2WNR22MaI1XJ0OPG6zZcPl43jXfmO43VATcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp/jVetmynG/BVAXFZKyiEYZgGyvjuzcDvbQknCkv9Q=;
 b=cYThHN3AhX22aBJ8ZlcvqjdiKH1lOYjgaFdA9EUFRZsB0VA3+tBBzIq3Od5pz+DC47UrxtAbtNWjSDMLPSTP+YnExG63FAia8a6Z5VuARyKoeTUER3OmtU+vwO/Pg4x7w7a3//xcWSwMb9JCUpmZFCDCV5RpaHn5dj0d6aqyjcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PR3PR04MB7308.eurprd04.prod.outlook.com (2603:10a6:102:80::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 27 Sep
 2024 09:25:25 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Fri, 27 Sep 2024
 09:25:25 +0000
Message-ID: <4304848f-9af5-4991-bfc8-836ccf2abb43@cherry.de>
Date: Fri, 27 Sep 2024 11:25:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] rockchip: rk3399-roc-pc: Hook sysreset gpio to enable
 full reset
To: Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
References: <20240926183111.1324284-1-paulk@sys-base.io>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240926183111.1324284-1-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PR3PR04MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 5699df85-ab22-4a1c-3f4e-08dcded65163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnQ5Z3ZrODFLR0FPQ2tndzVpek0zUktoSmJHbHpiMXZNbGZtMC9HVG1GSXdw?=
 =?utf-8?B?UXJ1dkpWTitDS0pNc0M2YWI1bWxmbjVCdkVhV2FnaDVBazE0STZsc1BGMFlo?=
 =?utf-8?B?SGZ1YUpTWmNQZHp2L2pIVU5WMXYzSXhBK21Pb0FvQWtmVUp5QTdBOVpFRC9a?=
 =?utf-8?B?NzdNOWVUUW5mZWpPVE5xbW5IZmZHNUs1ak1lTng3OXdFN3BIcy9OU2huZTBQ?=
 =?utf-8?B?b2hMOTUwVDhod2xnV1N6ekRQWEg2dTRkcExKa3hpdTdTUHROV0ZPeVJLU1F5?=
 =?utf-8?B?Z2pLY1B0RXlmVW04cXdjRXFmU3BPNXRlQnBITjFtWXJjWmRtaTNMejRsS1hv?=
 =?utf-8?B?VjF4WlYyRGkvY2YzRm14b0MvSTZyZWFKNkNIUmtyNHN5TVM3aGo4bFdJWkk1?=
 =?utf-8?B?S29kemtkd3ozd0ltT1p3VjNDdkxwS3g3Zm1iT2gwT3BlMnMzTFNPakxCSjRN?=
 =?utf-8?B?dDVBRUJyTzh0Tk5WSjJMZmd4RUQvZEdsakl2akVMamVKMkJBVURlNDAvcEl5?=
 =?utf-8?B?Z3FpTUliSWIzTnhxdThpdHZ5KzN4OHMyNWhCbE1leVRRcFcwNkptdnZlZEJh?=
 =?utf-8?B?RE05ekxVak00eDgvZWRpV2luMzhvTkJnZ3k2a3VwQTdXbFJ4WFEzV1l4UzYw?=
 =?utf-8?B?eWkyclN0OUVPb2pQODN1dzVLYUNTdU5mVHlrRlZEQjlzd0tleG04NjZGWFVj?=
 =?utf-8?B?Y3BDajVHSDBQZGNMc2lIWkJwKy9zT3Iwb1I0ZUV0c1hNNUpVaXBnWlBldGg0?=
 =?utf-8?B?V0poMTk1UFlLc1A3N1NCQTZ2Ulc0RE1HY0x5bERzdy8xWXQ0anAvVEh0N2xa?=
 =?utf-8?B?ZXJKR0N5STl4WFRKalpqUE9xTjlhTmVWTEN6K0llWG5DU2xaTVpmYnVUTlpr?=
 =?utf-8?B?d1ZxdC9ZN3gwd2VrZzdPWDdNZTVTenA2MUNYT2hlYllOSHZzUHdJc09IOHdF?=
 =?utf-8?B?VUhFbzNWSFVWeTJpdjEyL1ljWG0weG9rNyt3Y0dJWmtWWWJKM0dtRVErem9y?=
 =?utf-8?B?dVpwQnZQeTVBWFVON01YSU00elRPTEhOejA1dUdGQjBzU0ZNVEJqTWRXcnZq?=
 =?utf-8?B?S1Q4Q1RpT2dpck1ZbEJ3R0pkQS9MOUcyckhnOFRkN0pTdDhVUnJUVnV1MFVm?=
 =?utf-8?B?QnU2dXJCSUkwc20veEdQbFhrTjVLNEFIK1NyZWxEdUZMRmtJOHM1ZGt5MlRI?=
 =?utf-8?B?eVJjYkJMa2pDakxFMS9GYys4RWpVTEVsRzhHRW5lTnZUQk4zTWdwTURidVdR?=
 =?utf-8?B?OGRuSmtMb25RMVRaWTc0R2VhWjJWR2JiSUpWMnUyNlIxdkZhZnBvcktjMkJU?=
 =?utf-8?B?RnllK3EwNE84Uld3cWltTGV6ZFlWQ2FpNkRxK0V5TEw1YkhWUzhFNnIrRmxr?=
 =?utf-8?B?bkd5akk4WEl2VnFRdm84OW5hQ0JZQkdsQk9naG1UYTVka0hjUjU3d2w1UjY1?=
 =?utf-8?B?WWhZMWdSbTkrNE9JNUp5RnVOV1NzbXdPbWxMWWRWeTlSRjk1TTE0bCttNnhk?=
 =?utf-8?B?ajE5SnVhUm5NWlhBS2RHemYrMG02TkFBOWhUY0JTWkZtZkxPcXBvdWw0VUFK?=
 =?utf-8?B?L3FOT1U1YTFDV0hkZWQyMDRSYW1kYTRmR3U2aVZpQlhFZVZYb0FZekVZNG1k?=
 =?utf-8?B?b05CeGxnZ2lFQ0M0bk54T0crRUpXSVhPYmZFSUd0dG1UVm00NzNmbXh4V2tv?=
 =?utf-8?B?VCtuRFZWclk3NnNEWXcxMGk4cFVxV1I0K245Vmk4bUlEd05OQ2lEMzRCcjZm?=
 =?utf-8?B?TEhnK1FBMjQ3SEQ2MVNUN0c4MTZGNGhybllsQUJIMm8wUHdzZGt1cXI0MFFj?=
 =?utf-8?B?OWF5NFBrcVY2VDNjeFMyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pUUTNLNHNHS1R6K0tsTGlXTmVZS3hPeklWUDRSNDVkU2VzRDgxOW9Bc0tH?=
 =?utf-8?B?MWpvTXRjK0EvZVZjanhUYWU2UUZJZlZNOE9IdFJVREhQZEQwaXAxcVAra1Yr?=
 =?utf-8?B?RnptL1RmZ2VLeVpURU10YWk4R2taWjBlT2lNQXFIQ1l6cDl5MnJiakZHZzlk?=
 =?utf-8?B?NWFabDMwbktWYzhMSTFUcTZwRDBZNG13eGhKVjB0a1JMNTduaTNHa0pWMXBI?=
 =?utf-8?B?TTUxdUFOOHhJNFBZUnZlZXpMTXNQcG5QNStVY2hUZndrNFlMeGFwTm1UVExY?=
 =?utf-8?B?SkRkRzB5OEQ5cFl2RzRRQ0dXZEpJUVFwVnQ0Vi96K0lOdU1sVnRLMVFNUjhU?=
 =?utf-8?B?cUxWa0s0Zi9BSkYzK1JuZndKbjVHdHdaS09CTHdEN1hZaEVIUUthd2pETGgz?=
 =?utf-8?B?NkRlMkR3VlhWTEcxemtpSXBWV2NBczNBWkRWYURJN2NYcXFLc1cvUldJckVG?=
 =?utf-8?B?Qk9ZVWJ5RVZtMkdTQXN5YURkZTdJV1lRMkhpeDBWcFQyRm5zMGtzNmY2Q0VB?=
 =?utf-8?B?b0poek5XaXd2MnNoRDlVTXMvRnlHRU9Rc29NZFkwZXlVUVFkbUhrOWNzTEdE?=
 =?utf-8?B?MGJ2VUt4UWQveThBbDR4cVU4REw5REwrZ0w1akJQTFlPVU1ZWUZvTzhMem9S?=
 =?utf-8?B?Q2VrRXNDQ3BzRW1pRjNGVGc5NVFCdHdKSmRQdldYNEh2eG1CY2dpM3IwQ2RF?=
 =?utf-8?B?YnlUb1BScTJ0Z1VwajRXU0YrZTBaYUhhbmhKcWZTNTh6WXY0ZVRvYm5vaGcv?=
 =?utf-8?B?Vy9hRStoUDliTlFWUDZpNGlJK3hwVFdmK2NOa2l6c1krTUpXMlVyZktIT3lq?=
 =?utf-8?B?dDRNTnFOVlVMcTFnQ2wyWG16b0x1bUg1eU9rMVNKQnZlb1JDbGNyblpsSjZK?=
 =?utf-8?B?Wmw2eERJRnh3alI2Si9lSkU5cWFld3E2NnJSWm53SHBKdzN0MEszTWR4RDlm?=
 =?utf-8?B?WlNUYXhGMWgwYkUwdTY1Wm5HQlk5UWtGZWJHOVY1Q1cyTmMveHg5M2ZIVVV4?=
 =?utf-8?B?Vy82M2tHU05jRExld0dvWmpYczdYeHhUK2QvRUdnMEdWZnBrcCtUb2EvYjg1?=
 =?utf-8?B?Y3NIelc3VlF1dXZNcXJZV0pHK0dreVEwR1NGemJRdDUyMlJLL0cvN2N4RDY1?=
 =?utf-8?B?UEtYd0p2R0lNZGRlNGhuQVJaM0hSZ1FJNE5LUU1WU0w5aWhsUUlHZFVJVTFt?=
 =?utf-8?B?Z0lIT1EwMHUvQ0tGMDFxTW00MXpRUnhWN2hTKzdWMklNN1ltbXF2TkVTM1Z0?=
 =?utf-8?B?dDVUdmZWd01EdlJmVFdWQjkzVENrSGU5OXZKbWhqWnhuUCt3YWdIeFBxYlZt?=
 =?utf-8?B?b29oYy83ajV1ekxOaWl0V3k3ckQxUDFmWmN0WXRVYzhJZXd5amh0K0JrTnpa?=
 =?utf-8?B?bTkybHovUDhoS0F2b2xsMTB3UFdLTkhRVkVtbmU3WVd5QkVaT3VCMnpSbW0w?=
 =?utf-8?B?dm5meUhXU0xmbWtDTHhmMzVZd0hxMGtSNXZRS2wzNHhQQ2xZM3dGN2dpMEVa?=
 =?utf-8?B?SDVHV25TQmxvTWNQQnF6UE5WT3JFT3hKbk16NzZpdGQ0MFRCazFKSXQzc1dt?=
 =?utf-8?B?ZDY0NzlMRTV3RUNyUjlETVpCT1cxc2djVUwzczlxYTZUdUJVd0hGU0p1UHhI?=
 =?utf-8?B?TmRXc2twK3E1S0JwK2F1UW96eEt5N2xISTR2NUVnVlVYN2JBR2dKSUF5TWZZ?=
 =?utf-8?B?clFoVzA5Wk9CNFB1V0ZESU1OenEwOUZzZHhMblFuVUp0V0dsaHg2bE0rdmJ1?=
 =?utf-8?B?dStlU0dHRmYrTXVINk1odDhocGY5KzdmRUErWkIxdldaNGJ0dU15S01rSUhK?=
 =?utf-8?B?cXI0MGxUT09Fb051M0ZHWlRFMnU2SHowNlFzbjNIRitodFRXa0t1WU5vNTA3?=
 =?utf-8?B?L2ZvRHdzUG9KbUZIOVFaVmYxdVNlVDV2S0xJTVRsQjhNWDZLVmJwTlM2T0lv?=
 =?utf-8?B?THU0b3NLYjVUY285SW5aVXpOald3ZHVXdnJkS2VKbW1ZUVdGVnBwTWVIUVlj?=
 =?utf-8?B?RHZpTisrZitVa2NkTk15bDVjNCtIMWZ6aTdHK1FuUTlRSUxENHVtQ3l5K2hF?=
 =?utf-8?B?bHJuRHA1b2Ftc1NjTytnMnhJZWo0OW0wOXRWUGxKNzFPbjMvTjU2Y1plOWgz?=
 =?utf-8?B?M1Jab2xSWjMyb1drN3U3VytqZjlVNUUwK21KVHQzelltN3pJdjJ0N3QyOHdL?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5699df85-ab22-4a1c-3f4e-08dcded65163
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:25:25.1051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phnDIbp9jtpomQOhGne2JJqaH6HHQY+6+nw4vx5KytTG3EhK7wuyc0vD9md93HmHzJgpy/pgl5TZuz/NlgDBgVs6pe8VkYrq4aSsxEfcKbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7308
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

Hi Paul,

I'm not entirely sure on whose side the issue is, but I didn't receive 
your mails, either from the U-Boot mailing list or directly from the Cc 
field. I however could find the patch on lore.kernel.org... and I also 
received yours and Dragan's exchange on patch 4 (but not the patch 
itself). Any chance you received something from my mail server? Does 
anyone in Cc of this mail actually received the mail?

On 9/26/24 8:31 PM, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
> 
> The reset mechanism used by Linux to reset the SoC is known to only
> partially reset the logic. A mechanism is implemented in
> rk3399_force_power_on_reset to use a GPIO connected to the PMIC's
> over-temperature (OTP) reset pin, which fully resets all logic.
> 
> Hook the associated GPIO where the function expects it to enable this
> reset mechanism and avoid any possible side-effect of partially-reset
> units.
> 
> Without this patch, reading from the micro sd slot fails after a reset.
> With this mechanism, U-Boot is able to boot from it reliably.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index aecf7dbe383c..883d399a06a3 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -7,6 +7,10 @@
>   #include "rk3399-sdram-lpddr4-100.dtsi"
>   
>   / {
> +	config {
> +		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;

I think this is the wrong pin to use.

The routing of GPIO1_A6 is similar on RK3399 Puma and Pine64 RockPro64, 
but it differs massively for the Firefly Roc PC.

However, a similar routing is done for GPIO1_A5 on the Firefly, I 
believe that one is more appropriate. What do you think?

Cheers,
Quentin
