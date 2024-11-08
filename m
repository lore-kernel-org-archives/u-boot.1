Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891C7D5E159
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 10:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3D38908F;
	Fri,  8 Nov 2024 11:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="k4atXer1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9AB68900E; Fri,  8 Nov 2024 11:52:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B55388D70
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYrGR0njGTJHPLE1K4EQzkLD6ibJJO6V9at+w3S2P1kTq6g+Hr1SUxztuE4S5NYHasyF3NThOzKMX4KDoJfRODmW3EZ4nVvGtj6fAHafWkwpiMZ5ZfIHcoZ1EPh4/ftH/r8qaokkaaeGW+2Lc5KtGqU5OIdnr5Vpl97DoWhOOhgOgOX/C5cLo3FeSlEJyOMrnLG2ih/CYjDjcXAN6I4lEVj4fx9Gloj9E0CqX6zHl+TVM8T+XfwyLZVBTZqrUcmsZV8qOo69RTek/SUarZamgxbOpzFSagP4BLAX5qaQxShaFA/byAZlrh3s3AN+71ElOalXqZrZoT+27jyk0MAq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL7lNJ+yJPIkEIZ5E3A0Tk9whRMEj7BTBZOTM9w8J3c=;
 b=TTfzHTug2rwDkl08+/u5qnUpRHCto3VA5pSpV14h6OsjvEIZzHA0gegiz7maps9gkw+pmyiBqFpYoTS+cB5brZeQxLJXCmsyGfRpNYEhr5vMGKhsYNfMc+dlj2XTy8KwNpLubOuk/28OEBpaGI1mYJop2fqWKIiD8ag/pjn88lvGva1sADq5PHVdlUSVi9jycHpJqAbnglGF+txicadK+aWY9y5bg/iFyOwDy6hDK3kBZimwh5gtZsCusU1GuaJ3Yi0wMTFg9JhHbMB7/N9SQ9ntfVpIuJwXa1AnkKyYTYuIZeMAvSL2Rky6uEDUpAx8xDyaKEcy4iJ+a8On+5PSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL7lNJ+yJPIkEIZ5E3A0Tk9whRMEj7BTBZOTM9w8J3c=;
 b=k4atXer1bhlr+N01+fJv6mqMr3S/QmD6M+P33FPlM1L8zO/OaTzLdY5oDy5fhTv6hgA/cECo1IsKBeeoHGID+xvi41CJ4J9/q+VMQ6+wu2bIXuyaZLuftfA8qC1Qepoa75QfAq2kbugt91Pp+YvP5jfpHMtivzBtSWS5mAjVsy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:52:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:52:44 +0000
Message-ID: <1b905e12-569c-4a4f-aeb6-0c97df250731@cherry.de>
Date: Fri, 8 Nov 2024 11:52:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jagan Teki <jagan@edgeble.ai>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
 <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
 <cef9b291-5c27-454c-a24a-565d4510add5@kwiboo.se>
 <88812888-4583-44e1-a36f-13239b0aa4d6@rock-chips.com>
 <CA+VMnFxQXL3qgtQqqqhtRVeG-sj0Xgitr0VMBxNuN0qHcYFZJQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CA+VMnFxQXL3qgtQqqqhtRVeG-sj0Xgitr0VMBxNuN0qHcYFZJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: fd11868e-45d3-4eac-b74d-08dcffe37609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0NraVM2RGRiekl1OCt6dkJiOWJIS0E5ZUgwTmEvT2h4VERLOHNYSUE5SDlC?=
 =?utf-8?B?ZEVEaGhzUSsvMW83YStYcUNGeDdRVG5uMGhMN1ZLWGhUdyt6aXlpWnROd3Ux?=
 =?utf-8?B?UVgyOFRiNVVzcmQzUE5QeFEzYVMyUUhqVUJ6TUhzYnQ2bVVqR2g4NEZlYzFs?=
 =?utf-8?B?UWpYUTZVRmZSVnUvV1d1Z3N5Lzk2b2FSaTVqZXRUTUhDRkMwTFU4QVVlOHRk?=
 =?utf-8?B?WTBmMWJjcUt3UVh4YVEyZGt2T09jekVCT253ZHB5anNVUVZZeWhtQVE1TEw3?=
 =?utf-8?B?clo5NUZJbFJ2a1JBZThBTmxwZ3M0Qm45SHNtcHl3Q0lzdkZid0tURnhWWEhS?=
 =?utf-8?B?THFGMXV3K1Qrck1nUHB2Y3o3K1RBYlRhS25lMkl2L0RGOTUvbmNCSGgvZkRi?=
 =?utf-8?B?UnV4K2RYUEJwWVhJRldQZUdsYk96L25ReElsWkV0OEE2RDZRUldCaXllK09E?=
 =?utf-8?B?VmVhSkhJTTB4T3ZUQUR3QjVTTmk2MlBxR3lJQjBpdHYzKzVLVjFyaUNrRFhu?=
 =?utf-8?B?azJNN2tYZ3V5V1FzekZpZ3JQMzhwOHZ4UXlqYmd4VnRlcWVya1lkOUlBUUtM?=
 =?utf-8?B?bjhpQVMzZFdHMTJQdGNYQmx3ZEVCVURMSnZKNlNGb2xqZzFDdHgrdTJxRHJm?=
 =?utf-8?B?dldpcE5UV2xaZTRyeHVZbWpHOHRTRHN2MXJWVy9RdDltVFhpSXJOMk5rcjRT?=
 =?utf-8?B?eFZsVUg3MEZQOUJ1S3l6aWRzay9Rc1VuSVNFNzBSLytMUVg4YmJiQmQyNmFj?=
 =?utf-8?B?RDllVnNPN211aWs2RHZaaHZzWktYY1Npd0xoTTFPSlhaZzRweXdia0hjYXUz?=
 =?utf-8?B?UEhoVjFVS3c5K2F2RklVTC83NnJJa2xYSDFIb0pqYUpydFRUZDFFNWdPZzh3?=
 =?utf-8?B?Rld4bnREK0Fzd21UYUZxb1FKVnhVd3JiVUs1RjRBejFDNytld1JnZ3RNdHdG?=
 =?utf-8?B?cktHSTV2cGs0THlCL0RtditMcnFzOWtEV0s1MEl3YnR5WG15NEJSQVVINVQ4?=
 =?utf-8?B?bnlNOVNXWE1CUHcxRDJvMEpQMmRIS1B3OGhhL3ppanBFdlFhQ1AvVmxZNkU0?=
 =?utf-8?B?b2R3Z0xRN25RT2ZneWtyejQza2gyaldiZFdRaVM1aENteHNDU0xsTFJKL1dY?=
 =?utf-8?B?UHJJV3FnU09VYVhHUHVHZG12WkpRQVhsTkpSQXZrZVNaWTU3aEttbENNSG12?=
 =?utf-8?B?TmpXREV0cUU1VitJZ3VObVNHTi9EUmNHWDFmMnVzTndiZ1ArR1l6VGJlY2tL?=
 =?utf-8?B?SUhtNmQ3Q0xaRkphMHJwYzRWVnlXQktyNEFGMjJhK2VHVFN3Sit5bko0TktJ?=
 =?utf-8?B?eVYyUHpFZ0lLMFY4RHpTVTlzd1F3MDVKTGNUa3JQd3g1NkEvY0ttYzg5dVM5?=
 =?utf-8?B?UDRGZHozSkZGV2NGL20yMWZteUdmb1AybWVJV0JNdzVqMmpGMk5WSm9WWk1Y?=
 =?utf-8?B?SnZwU1hSZU5SdGpndEUzUWFjMm15VStvVHNiOURhQnJUbDJ1dEtQY1hZV09J?=
 =?utf-8?B?T3JEWGZheHdzL2VzbWM0QU51NjNGZ2N5NnZXb2RZbDd3elZRanZ5MEVwQ3ZT?=
 =?utf-8?B?YU53VGdsa000K0R4WXg2d0lZRC8yc3lLejJwdnlFenZXbHV0dDJORmg3bUg3?=
 =?utf-8?B?TnR6eTFtVGNObStoSXdjNFdBcXpOV0RzZW1lbG1YTTNENzNvMFdkQzJQcGNi?=
 =?utf-8?B?THBndnpHYUtXdFlLUjk3ZGtYK21mZmdYUHY0T243SXVpWG5OWUU0N1lwa2gy?=
 =?utf-8?Q?i5CylS+jqfjJntY++yEfd+Uxg0x2Tg8L/7S4Q5U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTlmd1hHaFpzS0cxQUNSZkwrazRMN0RyODB5Z3hySkhQSldETExDZWpvVkNh?=
 =?utf-8?B?L0RnVklaRWVmS1JpTE5SV3pJQnlBMFFWZUJkZ0puZDdWbHh4SmV5RGFCTDVy?=
 =?utf-8?B?S2dJeWZuMG54RWhuZGU3cGwvNWdhb0F6aWxLZXd0KysxSnd2TEk0Qjk3TElJ?=
 =?utf-8?B?U0xrcTVGOGJGOHFRVmlhTWplUkl6L2szVFlhNHFNWS9ZVll3Nld3RS9KWktu?=
 =?utf-8?B?c2hGSVFvTmRLNkhhY3phNkI5UGdZekE4d0ZlbndnaE1INlQxVDdqRTJta1l3?=
 =?utf-8?B?M1JpSTBZMG12ay8wSVY0Z1kwaVRTcjRXUzhWK3BPcVNxTnJxR24xWERpWXNy?=
 =?utf-8?B?c040U3B4dXRjTXhKamp4WlR1L2ZvdXdBaCtGNlRaWUs5U29wN0R2dUtPRE5a?=
 =?utf-8?B?WEZSaStndTFKbWU3S0xlYThkVDkxV2phZS9iaFRsaXpwbEpUeHNiYzU3OVFC?=
 =?utf-8?B?WHorRTByb2xDeXZyRTZoSENnbG1JSVU3REZwbGc2ZnpyQ2dCcy9LQjNZQ2xF?=
 =?utf-8?B?RFJpWHg4OTZMbHpJNlBRTmR4VkpySE4zTDdkd1gyb2N5Nkpqb1Erc1dZN1pB?=
 =?utf-8?B?TjhTVXZhbEUyWmNWbjRHaWNmRFZheGhQL1NGdDdhbXhrc0JoUkNURXZxTUtt?=
 =?utf-8?B?TW93UUdTUldxd2ovbTVNYXZGSmRjYmtGRzJ4ajJ2SzBtTnQ3c2JSWmVhSFE0?=
 =?utf-8?B?MkFxcWpUYjBwWkpvNG90M3BMbXd2MXlvNE5QUzdkOU1OTzVPbDA3MWh4bU5R?=
 =?utf-8?B?cDl1S1NLVGxpd2crWUhibzlmUk5vc3pwVW8xZlkrQWJYUDFjMFlPOEhHQThZ?=
 =?utf-8?B?S1pxYWlqNUxxTG51WG9NdGJUNlU2WHRsUkdqTi90dkxvQ2hSMGFZSmQ4SEFP?=
 =?utf-8?B?UWc4S05TUFVoZUh2Mm5va01SZUx6OGRQdm1vcEgzbG9mNVFFT3U5RVBxMkwy?=
 =?utf-8?B?NTNuK0ZnK0RPMUU4K29kWS9yVWtveTd4djRmTFlNanA4SmdXTTk3WWhKQSsv?=
 =?utf-8?B?WHBKZ3dYb3ZMandteVQ4ckphbm5jR2s1c01sMTdNYkdsK1AxZGIreEFZeWNx?=
 =?utf-8?B?dkQ5SkFoN3E0a3MrUnlZQU1sRExQTGVOUSszdzNmOVB4ZXF3RWhUeUQ2QmM3?=
 =?utf-8?B?Y2dKQjE2anlCNUNiSkpnRWp4azhyQXY0Y1V4dDZ3RXhQM2p1MU80ZmZ0dmZh?=
 =?utf-8?B?Tzc4c2ppQkhxQ1BYUkt4cWtzNHFnaGxzY0xpcmZhZ2VNYXZHZ2FPOEFvallP?=
 =?utf-8?B?QnhjRUJyWWtSNkVwa1BSaDIxcU1qb0l4UkpEbXRkRGNRTmFwc2hBMVhjM05x?=
 =?utf-8?B?Q05jTzVsVE9RckNQNHFOOWpLaWlFbVN1VUNFTHNZMTZNY0tWeHRybytjb0or?=
 =?utf-8?B?Y3BySDdmWmtKb2hIcFJSNzZtdmxqWm93cWhwaWJlcjIvSjhOSVRTSTVDa0Jx?=
 =?utf-8?B?NUN5RS9SQnk5aTlUdENXam9CY2ZxM21TMmNGY1h5aiszbmR1SitwZEJJbFJT?=
 =?utf-8?B?RkFkZUM1QzhjOXZwYUJiUWp6azB0bjRnUC9LblhRTkNBUE9Vclc5RlBmaWF1?=
 =?utf-8?B?d2RDUjB4ZWRSZVhsNzRJUmFBVDRWMGN4cVl0dFlGOHo3THhEUEdYV2FVV1VK?=
 =?utf-8?B?QUJERjd4cGxFUkVyeUFyWEtxS2Z2QTRkVkhvbzZ5bUtqQkZIa0tEL0taT2JL?=
 =?utf-8?B?RHRIUW5mbVJVc2ZJeEtZUm15dGI4Um8wQ01OaElBb1d1Yko0MGYwSnhKcmFo?=
 =?utf-8?B?bFhjZm1DU0JXeXJYOUlTcW1UOC9RdVVRWWx5bVJ4ZVBWR1pVNEp6MFk0eURP?=
 =?utf-8?B?a1pjbTRVaEFSTlhieks4UXdHTy9NVTZ4OHBTU05JNXJSaUNzZFdlalR1bmIx?=
 =?utf-8?B?ekhPNXFNcTdhUTUrWk1HeGtRWFM1Si9Ua1Y0KzZuY1h1ajBOVmI0cFQ1QU9x?=
 =?utf-8?B?d3lSQ0VEZXNIOUtOdmxuTmQrai9hcWwrUFVJbXRndHRBSGxOY3NXdW9wOVpW?=
 =?utf-8?B?Kzh1OG91emdNc2cyOGVad3FWdnpIM3lMRzZwZjFaV1Z5K0hJZ2Nwcy94bmJK?=
 =?utf-8?B?Z0RyUFVucnJYOWduWDdTUjJVbSt5cDU0eFQ0ajVUNDg0VDJseWthUHRUMjlF?=
 =?utf-8?B?UlFPWlJmbUc2czEzbEZER0hBVEd1Q0hrZlJ6QVYwMnNDeEN0MS92ZENtbVNw?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd11868e-45d3-4eac-b74d-08dcffe37609
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:52:44.3127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zfCn1GjxtWwU3g3a9WsBZFlmGBDv3VqJlVzMMO3j8wxw0/CCJ12fehAcx6ECgkjtfxUMxvKQup0O4Nxzt4lc2YWYyT8buz2YiVBa+h4bLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661
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

Hi Jagan,

On 11/8/24 9:55 AM, Jagan Teki wrote:
> On Fri, 8 Nov 2024 at 09:10, Kever Yang <kever.yang@rock-chips.com> wrote:
>>
>> Hi Jonas,
>>
>> On 2024/11/7 22:29, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 2024-11-07 13:01, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 11/2/24 9:37 PM, Jonas Karlman wrote:
>>>>> Implement checkboard() to print current SoC model used by a board,
>>>>> e.g. one of:
>>>>>
>>>>>      SoC:   RK3582 v1
>>>>>      SoC:   RK3588 v0
>>>>>      SoC:   RK3588 v1
>>>>>      SoC:   RK3588S v0
>>>>>      SoC:   RK3588S v1
>>>>>      SoC:   RK3588S2 v1
>>>>>
>>>>> when U-Boot proper is running.
>>>>>
>>>>>      U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
>>>>>
>>>>>      Model: Generic RK3588S/RK3588
>>>>>      SoC:   RK3588S2 v1
>>>>>      DRAM:  8 GiB
>>>>>
>>>>> Information about the SoC model, variant and version is read from OTP.
>>>>>
>>>>> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
>>>>> where checkboard() is called.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>> v2:
>>>>> - Update commit message
>>>>> - Update code comments
>>>>> - Drop generic-rk3588_defconfig change
>>>>> ---
>>>>>     arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>>>>>     arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
>>>>>     2 files changed, 62 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
>>>>> index 09d8b311cec5..8880d162b11c 100644
>>>>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>>>>> @@ -69,6 +69,10 @@
>>>>>      bootph-all;
>>>>>     };
>>>>>
>>>>> +&otp {
>>>>> +   bootph-some-ram;
>>>>> +};
>>>>> +
>>>>>     &pcfg_pull_down {
>>>>>      bootph-all;
>>>>>     };
>>>>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>>> index e2dac2a5b806..f9da7a6f1477 100644
>>>>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>>>> @@ -4,6 +4,8 @@
>>>>>      * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>>>>>      */
>>>>>
>>>>> +#include <dm.h>
>>>>> +#include <misc.h>
>>>>>     #include <spl.h>
>>>>>     #include <asm/armv8/mmu.h>
>>>>>     #include <asm/arch-rockchip/bootrom.h>
>>>>> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
>>>>>      return 0;
>>>>>     }
>>>>>     #endif
>>>>> +
>>>>> +#define RK3588_OTP_CPU_CODE_OFFSET         0x02
>>>>> +#define RK3588_OTP_SPECIFICATION_OFFSET            0x06
>>>>> +#define RK3588_OTP_CPU_VERSION_OFFSET              0x1c
>>>>> +
>>>>> +int checkboard(void)
>>>>> +{
>>>>> +   u8 cpu_code[2], specification, package, cpu_version;
>>>>> +   struct udevice *dev;
>>>>> +   char suffix[3];
>>>>> +   int ret;
>>>>> +
>>>>> +   ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>>> +                                     DM_DRIVER_GET(rockchip_otp), &dev);
>>>>> +   if (ret) {
>>>>> +           debug("%s: could not find otp device, ret=%d\n", __func__, ret);
>>>> We should probably start using log_debug instead?
>>> I guess we should?, not sure why there is two different and what the
>>> difference is. Have typically only ever used debug() or printf(), so I
>>> just went with what was used in the code copied from board.c.
>>>
>>>> I guess with #define LOG_CATEGORY LOGC_ARCH
>>>>
>>>> at the top?
>>> I can give it a try, what/how is the log category used for?
>>>
>>> My simple debug workflow is just to add a '#define LOG_DEBUG' at top of
>>> a file when I want some more debug info.
>>>
>>>>> +           return 0;
>>>>> +   }
>>>>> +
>>>>> +   /* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
>>>>> +   ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
>>>> This will fail if CONFIG_MISC=n which is neither selected nor implied
>>>> for RK3588.
>>> Good catch, did not test that scenario, will fix in a v3.
>>>
>>>> I tested on multiple RK3588 Jaguar, and the commercial (RK3588) grade
>>>> ones all showed RK3588 v0.
>>>>
>>>> The one industrial grade (RK3588J) showed RK3588J v1.
>>> Thanks for confirming this works on a J-variant.
>>>
>>>> I'm really not sure what this version number is for. If even Kever
>>>> doesn't know what it means, I am not sure it makes sense to print it?
>>> For rk356x there is some special handling for cpu-version <> 0 in vendor
>>> code, and DT describe a cpu-version nvmem cell, so thought it could be
>>> useful debug information. However it may just cause more confusion since
>>> there is no clear information on what the different cpu-version mean.
>>>
>>> Will drop the cpu-version information in a v3.
>>
>> Yes, this cpu-version does not help users, I think it may be one of the
>> silicon version(
>>
>> The process may change in foundry), package version(change in package
>> factory),
> 
> Apart from package number chip versions like RK3588, RK3588J and
> RK3588M would be much beneficial when we boot multi-dtb from SPL and
> load the respective silicon dtb in u-boot proper. So, chip numbers,
> temperature (if possible) are useful like imx chips supported so far.
> 

I mean... can't we just derive the operating temperature from the 
variant? It's pretty public what the operating range is for each SoC and 
its variants, so not sure what exactly you're after?

I think we agreed on keeping the printing of the variant in there, so 
that should be enough to derive the operating range?

We would probably need another mechanism to expose the variant to the 
rest of the code so it can be used by the SPL to load a multi-dtb proper 
(or at the very least have proper select the appropriate DTB from a 
multi-dtb kernel fitimage).

Cheers,
Quentin
