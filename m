Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B586D58D4C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 14:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E0589A21;
	Mon, 25 Nov 2024 15:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NCX4sRSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACB189A2F; Mon, 25 Nov 2024 15:05:31 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECAA89A1E
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 15:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thJ1spjXgIjknL6G2Q7Ack2QomhSkyRgMXvrJH4pTCTNuKFqb1zyvgdctpCakqnHt00GNHq/SFbB1nZZ6hKL5NCk8MWZW7qLlckWmS+7w9mKRvYl2nniIY6aH440MrJnCxllNrGGQssAcdbtmQT43fN/YCE+UDGtNwQBYFO2uKn7+AinO22srnS//9t5Rs+NI0rAppmipx8efoTu5ML1aszlq5XKAQdMzHCI2uR7npDVhSBJ/IFRmBPlqUhpDilQT775/l4NEbaJQQdn5ydnvCuBELhDxkDedGc/ySIBhPgD7DoO7jPN4/BbT6rUm2Rr7J1FAhKy6WxVpwu+63kgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SH4F1jK61mwbQkR+oMCYCWR0sCMY2ZL9hAOWum7GqIU=;
 b=WRZeDCipBpcUhEAbgsst6C1PZLO6r4sP6a2VxNy3VS1HQVOsfGjeL4vn4nkHxvUOaoyyMCLAvjhDLUsqYK2XWSgiL9BPVwf5M6fEuynvMsNWD9wpiM5bXOozkK1Fg07C/GcVA44rWloPI3ShK+xF+Ln2ss3cWsF2qW0lVyIljNJFspLMsV7DD7+gp6XtPH2jiwEBAMVR1YdjoqfZ53zS8P+MyGaJzc82m+E4QyTU1lTV1DpNzQiVAYP9CE5Q+p11TzYONA/vruXIeDVHUMgZEUqXjxdNlf9MfXnrSLC9daREoCahkF7DGbx9CE5EF0x5DqfRM+1Nxv+E7wCB/1vI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SH4F1jK61mwbQkR+oMCYCWR0sCMY2ZL9hAOWum7GqIU=;
 b=NCX4sRSkEcpiJVvirDzkh8AVVsrlKQhJRqlFfRYHWhPEFIF49bCEAvBqy8OO0RRMXvV/SgbPge2OYUZRHDqKFVftYhj8JzFnB0wKEQ1h+JiCcawFZcUzPmktL677mYfciz7ZzylYF7T2odbM5aX58ZUxvbfHZAKttmhiZMMJNks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 14:05:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 14:05:26 +0000
Message-ID: <a007795c-49b8-4ee7-835e-cd06255dc234@cherry.de>
Date: Mon, 25 Nov 2024 15:05:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add Khadas Edge2 RK3588 board
To: Jacobe Zang <jacobe.zang@wesion.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241119-edge2-v1-1-b10c5d7626ca@wesion.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119-edge2-v1-1-b10c5d7626ca@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b6ab92-de99-4e9a-3c71-08dd0d5a35dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3IvQlhwaTlhNUw0QytPY2NobDN4ZW4zQ0EydG1IZnoyekJzVXp6R3ZLUHl0?=
 =?utf-8?B?UCtnRW5IR21zYTB6YWVoTDBDbFBOTWhXTUJvVks0aCtycW1jM3JGN0ViSjB6?=
 =?utf-8?B?ckVvOHBpakUyTDBPRkZYZ0ZxVmlOdVl0K0YxTzRyZzdRUzI4WW9SY1RwUWtk?=
 =?utf-8?B?QUVVVG9UbDNRQjBFb1RSa01oOTJiS3FMdTVINEhVekZ1Qmpsc0NuZ2l0MUo0?=
 =?utf-8?B?T1cvbWVuT0NWZDZuTGhySXpZSWJ6L3hjdytDZ0xkcEJMdHJHNWUrbjNHU0Zr?=
 =?utf-8?B?ZklFNXlzcGlaYUxuVVlUUFA4dGM2elhORjNYMkh0cGVaeGdJZE5wR0kvYXMv?=
 =?utf-8?B?S0dsSG12by9tWWpDRnc3ZHRKcWlrTjBINlhmbmRsMTFFNFIvRHd1RGZYMlhH?=
 =?utf-8?B?Nis4WjdSNEozVXNIQ0J0bHQzRDc2d2NEVklmTzhycWhxTUEwSWN0WFJ6SC9l?=
 =?utf-8?B?VUEvdHYyZ21JUlkrVTk4MXdidW9pMjRkNERZdTMrMURRMHk4ODVIYUE0c0do?=
 =?utf-8?B?L0Ntai9BMWVTYmxLZ0djV2MxQldOTldhc3FqeXhUdkJtbkRGeEt5YnBzRXdZ?=
 =?utf-8?B?K2cxYzRlM0xqRWxrNXBYNmpSRW9IZFIrc0xOd0hZdHpNeEo0RzVtcTYyWU1T?=
 =?utf-8?B?M0g0Y1M1TmxVRTFWSmo2NEkyUmdQcE5aWGxlT2tJd0RlRFlRSFZVeUhaUDVL?=
 =?utf-8?B?cHJ2M1VtZ0txOWhZUjN0NlJ4eDN4L01CU25yVUppVEhiZE9icXNyUWw5YmJK?=
 =?utf-8?B?YytmVzNrai8wek0ySERkVjZuRzFDL1pOU3JzWW5ZbEQ1QzZ3cENXMzZpSmZu?=
 =?utf-8?B?U0pmUU1LU3U5aUcrVWY2VU1jbXU3NHV5c1R4Y0Z0bEZmQ25Rd2dUYzhtQ3hi?=
 =?utf-8?B?UUl1cTdxNlRVajNGeHgxYUxxWHVnZlJpVXIrd3RnYXltNkY5Yi9IdU1WUmFU?=
 =?utf-8?B?SytBZ1Y1Ymsrb0dESFljQm9OVWpCS3NGc3ZYSFpwLzFSUjk3eCtkUDdTeE1B?=
 =?utf-8?B?NHlYR2pWRDdQSWNnZnc3eGlvbG92c2lsL1BPSk5zQUNkR0xCMldKWGc0TzRv?=
 =?utf-8?B?dWMxbTdMemdRZmtSbTM3d2NraFBsWEVLS2dIbzJIZW0zb05UOVc4amFPWEg4?=
 =?utf-8?B?OTJNcTZGTEFFOHZOQjVUTm9VRnFoR1lTbWdvN0xsbjdocXovc1krT3JKZHRS?=
 =?utf-8?B?a0lKT3RKT0I1UEtpTHdQd1I1d1BDUk9KRHd6cy9sL01mT3JtNkpib2huUUhT?=
 =?utf-8?B?L04vS2NSMkF0N1k2WE0yeUpYQ2l3ZExmWkIxK2hjM2tsRWErWWZPUVIvdDl5?=
 =?utf-8?B?elNNeWNVSGJraGJEdDhtUXE2TE9OS0wxNHh0cFNha2VkTnEwRGM2d3pwM21Y?=
 =?utf-8?B?RFd2RFA2dG5aUlJSUVJoS2Y5VE1UTHp1cWh0Z3ZtTHJGM0NkUUlSL1JqR1ZP?=
 =?utf-8?B?OE1uMTQ3RXd3WkZ2T0hoeDZaMFZMdUN5aSszcHkxYWltVXF2dFViUGNXbFp1?=
 =?utf-8?B?L2RqODFVT2hUR2hPU2tidDlmVW9QUndGNk5DZW0yV2NkMnl0V1dydTRsQnJY?=
 =?utf-8?B?YXJoU3A5SndTdjdIVjAxNi81VDZYdkNFbnZua2xMYXVtN2svVG5mSHVpWGV2?=
 =?utf-8?B?RGVlNEVmU25tZWF4b3ZPZnN6MkpWMUVLdEd2VzVRN3p4TnpxUkcyR1FxdStX?=
 =?utf-8?B?RWhKZ28zbExCNzMzQ3lSS2xEc2VDM3RjUk9ZZTZEVW9LRTdvKzJ0Wm9zcE5I?=
 =?utf-8?B?SHgyeEsxM24xeHJxR0dCSjNBNElrRitPSDZqVFVRZWxJcHdDNWh1bjNwUnpI?=
 =?utf-8?B?bHdrSEM5TVlrU2trQ09rZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdRb3VhbCtmRjFtSWVGM0hnN3RaeDYxNm03c1dyalo0NFVqdmxDUXlWUzFQ?=
 =?utf-8?B?RW13Z2JYb080Z2EwMHhaMFVlU0JFRlNkaUxuV1ZCdXhOK2hhNmF6QVh0YWRm?=
 =?utf-8?B?dkthTzRtZitqdndEN1ltbDBJNWRlUURPbmszUVhyeVpHUmVGWnJTUDk5K0xp?=
 =?utf-8?B?a2VWT2NRbjF1MXB5aG02WTBEc0RlVmlNWDhSS3dNbEU1SFhMajBBdWlJcjQv?=
 =?utf-8?B?dWVQRmk5cGI4RG1BTUttUktMTS9pdVBKUDMxYlJEdWRMdEd2UXNFWk5oQUty?=
 =?utf-8?B?L0hzRE5WV1pFVGk2U24vVzVCenpTODNwMytSb1RDbks1U0NQNWdQNWJzejZU?=
 =?utf-8?B?eVZWZ1U0bDZxditmazUweXlYMEp0YkQwekU2aUVmMk0yTXNrM0owaXowcTdO?=
 =?utf-8?B?b0RQNklDMms4N25aMzFGRFhSbms4VFJ2VVhTS0p3d1JISzI3UnRoR2JSbDQx?=
 =?utf-8?B?NkRwaWkzYkdiaSt0L3dQTEUzdko1aFFNQ3p3dWFYY1ljNXVHOFY0SDFsZEQx?=
 =?utf-8?B?eEV6eEtXaTJRaUtwVDB0ckJjcDVSMmx6N1ZpQUNBazMzME1vT2I2a2wzd1pl?=
 =?utf-8?B?NTNvYVdhckxmMmp1b0p3RFZNQVZ5NGZGdGNmWGp3UUY2L0ZJdklOMzQ5aUZl?=
 =?utf-8?B?OS9RRVl6ajJkWjdJT1RRSjRLcHpGaS8wYk8zOTEvZGdKdDdBT0Jud1Y2ZFQx?=
 =?utf-8?B?VWpMaUxDbXB6ckt5TVlhVTBBYlFGRm1KcVI3UHFNUHA3MzRwbzlCUDI2Z3RI?=
 =?utf-8?B?TmhqN0hnV1BUNUxKZWhTV05uc2N6cUUwdCtaL1JncVVQMTBraVZTYms5dUNr?=
 =?utf-8?B?NzZ4Y3V4V1JlZGpoUE5NRmNDSDRabnBFMHFMaE5sZ2p4NmxHUVpucXRhZkFK?=
 =?utf-8?B?bTRFbjJITEtGSmtqQmZXYTVKeEFEUVNIckw2RTBhS1VXMHNWVFB1Mys2VzBV?=
 =?utf-8?B?WXlZVDU2TTlUZHZsRy9lbFJFcWxVOUQrNnNURlZRYk01bVJMZStKb1VIaU1Q?=
 =?utf-8?B?SWQreTFQZkE1RnduTTI4UmVrMkxEbEtxeHJua0JVVTlaQ0VqcnNvZUpkVnQy?=
 =?utf-8?B?Qkl3RUZMcWRpTVQzNitSM3dvaUV3UHpQUVNTa2JOVXY0T0JWVjBWS0h0aHFy?=
 =?utf-8?B?ejU2Ukh4ckhyTjRoc3Rua1ZYQmNjOVRzb0lleEIzdTlKVG9ScDE3aWoyMlN4?=
 =?utf-8?B?Mk9IampBdm52QzFuempwa0VCYkZsWDdMeThZZ1BYUHpMSjYvdmhNa0lucXZr?=
 =?utf-8?B?eldIR1c5WjkrMURsaE5Ja2IzYnVvTmxpQTR0eG9Dc1RHeUdlajVOSHF4OGtu?=
 =?utf-8?B?VGlKTy9NWGJvdjk1clRJOGdOcVlMV0RsVkk5L3lLaHlCbmRPZkxheWwrdjNN?=
 =?utf-8?B?bUtiYmpzOE03eVlnUU9IeUlzRS9jRmNBTDY3eElGVWI3amZmUHNxNzJpeEZK?=
 =?utf-8?B?MVZ2RHlCNVFySUNXTkttUTdBeHZsTENQa0cxN2tOQUQxVkMwNnY2ZGlVcXNh?=
 =?utf-8?B?SEVHQlhhY2RFTGpvY0pVTXZnL3RGTE1RTmNJR1NGdE5Hbmt6eDJRQ0RnNnZi?=
 =?utf-8?B?bDhnMXVFMHR4WnpFMm5jd1pvbUJ2dHhIZ3FZZktCWVRuSGgxQVZzYmtGdkFh?=
 =?utf-8?B?K2JYdy9xUXZYTHVnQUt6Q2xoeTNJQ21sRGRyVG1FelpKaS9qZDhIaGlSeHdH?=
 =?utf-8?B?bU5TS1ovZ2pIbS8vWnprZTR1WTY2Q3FqNDI2VU5tUEdycVplSi8rKys5cHEy?=
 =?utf-8?B?bWl5eFQzQ0NzKzgvUmxOdkNFamZaaHNaRFEreUdyeXRZbGR6WHNiM21ZWHB2?=
 =?utf-8?B?WEc4eER6bFc5TGEvcFVuVGlTUUtQdnRtOHpJdnd5Nmt3aVg1TVdFU0JDazZF?=
 =?utf-8?B?TUt3cmRyWEJFS0lJdDBpUTJJMnB6OXdreElmWHNBVmM3QW9xY3k0WHRpQUdJ?=
 =?utf-8?B?eHZ3WStRYXN1d3Zvc0x3V3JtNnJaWlFuMGJoTnI4b0NSeEJzZ1RrTE1IMnlK?=
 =?utf-8?B?L29oMDlBRDFQWGk4STR2K0NKTkVwbHIvVVFyeVN2aUJJZUFld3JhdmZQR0ZS?=
 =?utf-8?B?NUFoWEdkU3EzblMrVzg3K2x1bEp0djU0eDJBeW04TmlWZm5XQ29pZ0E4NU1j?=
 =?utf-8?B?UnR0WnYxNkJEMnc2SE1FNVVXVTMveGwySFRXUFd5N2NHbStxQi9oT1d0cHBI?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b6ab92-de99-4e9a-3c71-08dd0d5a35dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:05:26.0453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXhe8iAd+gCu31IUx4L49Yt3qCYUy6LfovBhzGfFnYCgUV9u/DgjXWMivLm5NvUn03w51FytWd6JmCOpQma5QLWUnNe0tNigkEzvkA4CiIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8409
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

Hi Jacobe,

On 11/19/24 8:46 AM, Jacobe Zang wrote:
> [You don't often get email from jacobe.zang@wesion.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> by Khadas.
> 
> There are tree variants depending on the DRAM size : 8G and 16G.
> 
> Specification:
> 
>      Rockchip RK3588S SoC
>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>      8/16GB memory LPDDR4x
>      Mali G610MP4 GPU
>      3x MIPI CSI 4x lanes
>      2x MIPI-DSI DPHY 4x lanes
>      32/64GB eMMC
>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>      1x HDMI 2.1 output, 1x DP 1.4 output
>      USB PD over USB Type-C
> 
> Kernel commit:
> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> Add support for Khadas Edge2
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 +++
>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 ++
>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 +
>   configs/khadas-edge2-rk3588s_defconfig        | 215 ++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   include/configs/khadas-edge2-rk3588s.h        |  15 ++
>   6 files changed, 272 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a53..7d817e7f1bd 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
>                - fan controller (AMC6821 emulation)
>              * 80-pin Mezzanine connector
> 
> +config TARGET_KHADAS_EDGE2_RK3588
> +       bool "Khadas Edge2 RK3588 board"
> +       select BOARD_LATE_INIT
> +       help
> +         Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> +         by Khadas.
> +
> +         There are tree variants depending on the DRAM size : 8G and 16G.
> +
> +         Specification:
> +
> +         Rockchip RK3588S SoC
> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
> +         8/16GB memory LPDDR4x
> +         Mali G610MP4 GPU
> +         3x MIPI CSI 4x lanes
> +         2x MIPI-DSI DPHY 4x lanes
> +         32/64GB eMMC
> +         1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
> +         1x HDMI 2.1 output, 1x DP 1.4 output
> +         USB PD over USB Type-C
> +
>   config TARGET_NANOPCT6_RK3588
>          bool "FriendlyElec NanoPC-T6 RK3588 board"
>          select BOARD_LATE_INIT
> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>   source "board/hardkernel/odroid_m2/Kconfig"
>   source "board/indiedroid/nova/Kconfig"
> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/khadas-edge2-rk3588s/Kconfig
> new file mode 100644
> index 00000000000..dd7b6cd8054
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_KHADAS_EDGE2_RK3588
> +
> +config SYS_BOARD
> +       default "khadas-edge2-rk3588s"
> +
> +config SYS_VENDOR
> +       default "khadas"
> +
> +config SYS_CONFIG_NAME
> +       default "khadas-edge2-rk3588s"
> +
> +endif
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> new file mode 100644
> index 00000000000..3f16923b0f2
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +KHADAS-EDGE2-RK3588S
> +M:     Jacobe Zang <jacobe.zang@wesion.com>
> +S:     Maintained
> +F:     configs/khadas-edge2-rk3588s_defconfig
> +F:     include/configs/khadas-edge2-rk3588s.h
> +F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
> new file mode 100644
> index 00000000000..208c72ca425
> --- /dev/null
> +++ b/configs/khadas-edge2-rk3588s_defconfig
> @@ -0,0 +1,215 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
> +CONFIG_SPL_GPIO_SUPPORT=y
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SYS_MALLOC_F_LEN=0x80000
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_FIT_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_AB=y
> +CONFIG_SYS_PROMPT="kedge2# "
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_DTIMG=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_SPI=y
> +CONFIG_SPL_SPI_SUPPORT=y
> +CONFIG_DM=y
> +CONFIG_DM_SPI=y
> +CONFIG_DM_MMC=y
> +# CONFIG_DM_SPI_FLASH=y
> +CONFIG_MMC=y
> +# CONFIG_MMC_SPI=y
> +CONFIG_CMD_SF=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_TFTP_BOOTM=y
> +CONFIG_CMD_TFTP_FLASH=y
> +CONFIG_CMD_MTD_BLK=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_SPL_DTB_MINIMUM=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_OF_U_BOOT_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"

This config option doesn't exist upstream.

> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SARADC_ROCKCHIP_V2=y

This config option doesn't exist upstream.

> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
> +CONFIG_FASTBOOT_BUF_ADDR=0xc00800
> +CONFIG_FASTBOOT_BUF_SIZE=0x07000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_ROCKCHIP_GPIO_V2=y

This config option doesn't exist upstream.

> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_I2C_MUX=y
> +CONFIG_DM_KEY=y
> +CONFIG_RK8XX_PWRKEY=y
> +CONFIG_ADC_KEY=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SPL_MISC=y
> +CONFIG_MISC_DECOMPRESS=y
> +CONFIG_SPL_MISC_DECOMPRESS=y
> +CONFIG_ROCKCHIP_OTP=y
> +CONFIG_ROCKCHIP_HW_DECOMPRESS=y
> +CONFIG_SPL_ROCKCHIP_HW_DECOMPRESS=y
> +CONFIG_SPL_ROCKCHIP_SECURE_OTP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_MTD=y
> +CONFIG_MTD_BLK=y
> +CONFIG_MTD_DEVICE=y
> +# CONFIG_NAND=y
> +# CONFIG_MTD_SPI_NAND=y
> +CONFIG_SPI_FLASH=y
> +CONFIG_SF_DEFAULT_SPEED=80000000
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_DM_ETH=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_FUEL_GAUGE=y
> +CONFIG_POWER_FG_CW201X=y
> +CONFIG_POWER_FG_CW221X=y

The above options do not exist upstream.

etc..

Please generate a defconfig that is actually made for upstream and 
enables what's needed.

Cheers,
Quentin
