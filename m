Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6A1CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 14:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7C184CC3;
	Fri,  8 May 2026 16:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lhqmtV/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FCF84CD5; Fri,  8 May 2026 16:59:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB52E84C55
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhi3HhiU1xP7KTbcaUV2xVvwrCB5cHm2jCTEmW2xeyNxIuvrSBbCe8Vx5vyvZPK0CkBHcUMgti5A0YbHC2OVt5xeqNn7p/Y9n4KBipuCM710xuo7M3Q4qAzTxi0vF6jN4hwUCkHWA88iOAMX0EOWjaYUs9lhZT5MghhaVuipKdMl6IPAt5l/9fQBsgJN/u+8yihoZeYai5mgvPgEXMOrIQWJuzEh9/hnkN2MD33ePuFAlcHakt2DZfFRtTbRXLep5c03Y68fsUsQdz9LyVv3FRfTCIqsepdqQbVvZ+vxJbwjB5aoaU3heEwqNoTZEEb0NvciTd+EgxJafKZuyP/Rqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnD2to+k3UknYDrWTPXoT1l9FUH1bpVqaK0XTIBbWQk=;
 b=lQU+TUFYTpSPVlLLKg0UVBXzVLUHqozgqIUMPBHDl39oFRovUcdA1HmYerhWDhDjKEvV7ExdoMKZY72tzXibteJgSqe3/lHobZYlCnxSLcKo0aba1J/ilVupps3azxs3I4n/SztQpLHTicAfF8z+rZu2fBp88ksMx41PXlEUGObsGqL4Hrh92FpHl6XlF17Vs9H720Q3zhC2kCiNirVSWLB7CuDYKW4Yp5nj527e1S63CZQgcIkUq180UlFf0z/T9UxsSkHxoVhu7bViG4YU8Wkrmy9A20F5xf8e0lY7nFlRoWR2jutnS2sxC3jVe9rS8LK4AYOv1emEqVT+t7tkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnD2to+k3UknYDrWTPXoT1l9FUH1bpVqaK0XTIBbWQk=;
 b=lhqmtV/hcEWLJgPKogJuqAE1x6mS8pDsC28iH7+4AgJdPyeBlyCY261jZ/thk1jlxEaXB6CNKYen821pJfhMEHYe2qhbSN837GcYSfineUDMkHt6Hnec9J/DxjbhCxNxjbBLQRiiGM7nCVqe5q2zcClTdvR5sh8Ifls/fJVscp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11094.eurprd04.prod.outlook.com (2603:10a6:150:279::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:59:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:59:15 +0000
Message-ID: <1e9104cd-2ccf-473d-a510-b1188aca5617@cherry.de>
Date: Fri, 8 May 2026 16:59:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Alexey Charkov <alchark@flipper.net>, Anton Burticica <mouse@ya.ru>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <13650571778172129@c82c52a0-4efd-47b9-b2a9-5a9057476b1d>
 <CAKTNdwG-Keu5Gf9EA5TUw7mG-KGBLumOco54Gm=iRM2Oif-F7w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwG-Keu5Gf9EA5TUw7mG-KGBLumOco54Gm=iRM2Oif-F7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF000001F6.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::90e) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2c228f-79f8-4da1-b09c-08dead125f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|4133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9M8LuoP0M5+nMUU39S7N7YnBN6CEOiZlOjKTn8DYlDU4Q6MwUDv/0NKfosxkjNNdTMN6JtwaflD0Fwv/YxPLOqy57qI/EmI6jR8r0LrcTVD/4PGDPdiJLO0AEJA9Tc1Q0zJak4SRCRp/QUavBeqbAJuwwZJD44f1fEqwgnDDj8fqH2AqRliuZX5wHi//SjXp1SG2CXuXeHXroFSll95A/7SilPNIN9x/Xh9DIFTS+GUgWy45J8jaCi85aBP9hhcECrvE3ay/eS+ex9KBHMWYpAVFVbHGEC9PsdYS9a4AYTJjVuL9VIDfySCAAbH0PiYl4wcKkMsT4afpdQCntC7dSiWqlDM9RVyYJxELYlcYoZntiEGVykIRou0liK7mZwPobCniUOYgGqkOj57lUm7oeLw1uV7Q1eUI8TjQXH0Z8UFu0KJkiWnGniZ2kg/wrLWcIx+lPcnXzbtmZl2CQr19jawX0jxDZWw3TpBo7lukFf82OBSgdKhuzj/CXCj8mrtSjGLOW0ERgOBawr1PV13CfPPxuK1seFftf16Bld0b7dbs0BbqawvfbVjW4w5CoyPjju8jGd9xGaTnHZGe1sBG0gwShH0mXlQlFcJQdAAYKZ2/FX/MXFpYZ8Uoef3NUGt2gC2ugRlwzoFZKsAYi7rfj3t9D1ZRb3RMCEJw03uw76DJi7UGxJkRDv3IdUDxIB+tqpTuvAtwU6o/wTnYsxyJTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(4133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlkyTGtqZC9PcDFscTNqQlkrcHc0Qm51RnRWREdyMnBpeUc0MXBQT0dINlVl?=
 =?utf-8?B?SHRValRyOFIreHlRRVh1eUpuYzdwN1JKNHcycUh1THhpaXVzdDBnN1c4RTIv?=
 =?utf-8?B?VFh5WU9pbFZ0NVJBTndxMGdURE5zQVVPMnFuR0h6MEFYZFltVU1SK010dUJL?=
 =?utf-8?B?UnlJN3FrWUt4RXVWZ1hoVGQ0cG83QnFjSXpIM0QvNnJHQ1BraUdSUlhKbHdT?=
 =?utf-8?B?TXRMaHRTWWo1TDhLL2VISjg4SHRic2xpMHMwTHA5MnFENEpxdkN2ODh2NUFw?=
 =?utf-8?B?Zk9lYzYrTnRERW5YSGZLZUYyc0JrK005OUdnTW1KZnZrMGJmeFNEdU93eEdy?=
 =?utf-8?B?SEo3blJDS2xBaGowRHFzbFdoUlJXY0FCZHp5Rmp4clNVeE9OMnllR1JzTTR3?=
 =?utf-8?B?ejdJYjBMQ0I3SnFsTFRSQVc1emtOeGRUeGtiY0tCZGo3Unk3TTZiWUl1OTNl?=
 =?utf-8?B?RjV4dFBGUmhheHAxenZmSkp6YU9yeU5qVnZtam9ES2NNMHZRaFZyb0dBTnI2?=
 =?utf-8?B?YlhnYU5HdlA5T2M4ZllONHhyZjZGaVRpNDZJSmVoZHJIVENVQWFiUzhQTXZv?=
 =?utf-8?B?anU1SllzSmRieXUzVVdzNE9TdVZOeEJVbGZtYncxQnBNQXlqNU0xRldnUnVz?=
 =?utf-8?B?Y1RjU2cvY3d6MWRYQ2EwUDZlZEk4YjJWS3FLVFNtRU50QStQNmZrRytNS1ZL?=
 =?utf-8?B?SmhMNHREMGRickpabWNSQzhDYTFFb3B2bEhDN1kzT1YraHVXeFhnYzhkUEVL?=
 =?utf-8?B?b2FuODFSYmpBTlEwYXZRMTRMODJWK2lQdmZzbFhzQWxHam1HYU9WNkFBSkZT?=
 =?utf-8?B?cXBxK3FscVlWMkcvQVU0NnE4SXpJT2VDY3VaMnJPZzExS2owTEQxQ1A5U0h1?=
 =?utf-8?B?U2ZubktscUJXRFNpR0NyNFFPM0VYTTZHc2RuNDBoOWpGRzJBWW1oSVEyczFE?=
 =?utf-8?B?TEp0YjhzTkN2Q043eGcxdGxKMmVQMmdhdkp0UkFjSGZzNjFIUXhadWwrbVpl?=
 =?utf-8?B?Z0Z3U0tsMlc0bStlR2N5Z1NaZEtJZm9Uc205Q3NaTWluVGZCeTR6YW1xOHJr?=
 =?utf-8?B?anE5aEZwa3I5cHlVdjJSOEVWbkVKMUE0MG83aElteHQ3a055RnVHdThVVDBQ?=
 =?utf-8?B?ZTNGU2p2Vm1DbHg1UTI1cnZVT2FQNW1DaWI4TFVpRkFuREMxNGYrYmZIWDE4?=
 =?utf-8?B?Umk4RHk1YWZ6aGwzMkE4elM4NzVhVFhKTWJpdy9sTitwZGtmWFNsS0lxR0Zi?=
 =?utf-8?B?NEQ5VjlYNmRCVWt5ZE5NeWJEdTdvR1hFWnYxbkpsdGtRd0VhM1NpMmZmaXV0?=
 =?utf-8?B?UnJWTHVZaVk0dzRWYUdTZU95UG15cndGZjlERE40Uk9WOHlPNnZ5Szh5YVZw?=
 =?utf-8?B?WDBkNVp1VVA1MmVvT2FJM244bkR2OFZhVDY5eWJNOE41UkpLai83L1FJdGNU?=
 =?utf-8?B?K0Zib3U2REhVb0pGMk1KYmszRVJlRUlYUGpqMDFKL2F2Z0hVT3NJQ2dKdTY4?=
 =?utf-8?B?UytSRnIrd1hUMHNXTlg5Y0dWMlJyUmJKNklwbHlQbTBNNitVMXg0eU1FY0Rp?=
 =?utf-8?B?aThoa3VDdFQySnVldXl6MnJqR3luWEV1ZTNhdmVCQTd2Zk56eEc5WFhSQWlK?=
 =?utf-8?B?bGpCeXpMSW8yQi8weGY0Unc1bHNjemFOdFJjZjdEdWh4bXpDbitwV0NCdkZJ?=
 =?utf-8?B?ZHJOckRucmtUcTFVLzNwemE5SWc4VVQvVlVNaG1nL0YrS2Z2dXZ0aWg0Lyt1?=
 =?utf-8?B?Z1l1VXVrNDdLbjdNdHVTcWUraEpaYlFtNkY0dWlsUk9qZ2RJbitkU3VBb3Fy?=
 =?utf-8?B?UGxCR0VrRVdZVGJTYmxhSmRQcTBvdVlNYmJFUytqNGovSGxoZkZYVnlBa25m?=
 =?utf-8?B?QzgxYk5SbFY4QU5CRlo1cEhuMTBPdDI1V1BNTVV0bVorVGZFb2FKNzRBTHdH?=
 =?utf-8?B?S1RaZTVKbkl4K0hSRVJvMjZCU1Nlc09uZWFEdkZSWUI2dE5QZjZ2ZmM5eHlr?=
 =?utf-8?B?RW94MUFKQzNra0Rxem5McFhuVXVjSzNYVHY0VXFWMVBRTlorTWtERjd5WDZP?=
 =?utf-8?B?UHZvczRjR0IrZGVqbG9hT1hDUlBNVGtjc1o3dEpOWnY1c0ZpOVZoZC9CODlU?=
 =?utf-8?B?aDhsVmoxRVVBTUNYbjBwbFh4b0hhUTNXNkc2WmJwdEV6MVNxMzZIRjdvVmdt?=
 =?utf-8?B?ZnpHT3ZWT2EzTzJlYUxsSUZoNXBObU5WeFJGbGkzenFqSjM1SjdRRGVjOU85?=
 =?utf-8?B?Njh2V0dKSVNRMmpKM0wzaC9UMHRNT2hQQm93U3BYTEs0M3dtMWFEQ0hsd21r?=
 =?utf-8?B?TldIdXg4a2pXbkhkOW54dE1zVDJ0WFJjY3Rxa2FoZEhXcjFDYTc4QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2c228f-79f8-4da1-b09c-08dead125f5b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:59:15.5768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5dM2m0f3JZ/exiwOGwPhICXorNLO1qiWqVHMmG8C8qG7vu5JXqO0kXpcblNaX4SoIR18jnzwrJ/KH7e4I2Z4alvzxbLep+PFzALkIQKptk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11094
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

On 5/8/26 10:21 AM, Alexey Charkov wrote:
> On Thu, May 7, 2026 at 8:48 PM Anton Burticica <mouse@ya.ru> wrote:
>>
>> The original idea was to _not_ disable USB3 OTG port when booted from USB:
>>
>> https://github.com/flipperdevices/u-boot/pull/20/changes
> 
> Hi Anton, thanks for the context!
> 
> It seems, however, that the minimal change out of your original pull
> request which fixes the observed initialization issue is just the
> assertion of the reset line. The rest may be helpful but is apparently
> not directly relevant to what I'm trying to fix here - thus the
> significantly trimmed down patch body compared to your original
> version (one change at a time).
> 
>> There is a possibility that with already running analogue blocks, disabling the port will leave the controller in some weird state and it's not possible to fully reset it via exposed reset lanes without full SoC reset.
> 
> Could be. However, having a different initial hardware state by the
> time the driver loads, depending on the original bootsource, sounds
> like future pain.
> 
> The Linux driver(s) also seem to be able to properly reinitialize the
> relevant hardware blocks regardless of where the boot ROM and U-boot
> left them, so I don't think we are dealing with a case of
> "unrecoverable weird state requiring full SoC reset". We just need to
> figure out what we are missing here, out of the substantial difference
> between the two codebases.
> 

There's an attempt at synchronizing the codebase with Linux v6.16-rc7, 
see 
https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/. 
Maybe this is something you could give a try and see if it makes things 
behave any different?

Cheers,
Quentin
