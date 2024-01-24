Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A7C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 18:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCAFC876A9;
	Wed, 24 Jan 2024 19:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=variscite.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=variscite.com header.i=@variscite.com header.b="h9/ruzJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFCE8778A; Wed, 24 Jan 2024 18:12:22 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1162287613
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 18:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=variscite.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ken.s@variscite.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw6pRqBK5N+WZwhUyOi8fZQkhHD5U25XOre3u3ZFxLd7vWQ7qQkQyuq4wLJoleu+oqvExxLnc8n+ZrCfCX0Fd4FQmBOgU1rI2siG8Fx68fSw3G2jEtqIbQWlcNL+LGs/n2YGg9SElPRdJMp03h8Enhqdhcb2eWnkxw3ml7Sy8dP7ZyT+ImsY7R/CzeZaleRkKUwjX0bIQ3ZSERpyYuTwpJyvcug0Pr0ZyokONQ4isq2Ygbo214SBWGGo8Hj/yZ6TKc2hzMT+rpwNBurkMGCJvkvLIHQfxWWGaqOlnq3u9KFBLiQBGnCo3yOqn5nGsjz/PHcepJD0QCmYLbW6sR1nyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybj2q77i8gCSTwDpguKntXrQyJDVOVU0od7wZTG+lKQ=;
 b=XwSuALv6BlmfVai2lwyYc0nFzPKxfusrsFqJb1lirq3d6PBuX11QxCwWHp7Qmu0UF+uBVkf48ImBwvClYMUG7bB4eBLpqHBjE4t0+C0NqYYaWE8hcoS+RQFGcyVzVsC/wC2MpnF7ImkqfdmbXpMo32AGSDsHbxn/+1vm7iNibgEfoEpiUka/hOi76T78zikHX6QQF1SInvmDX85eccCqBTHaEYbXw+1mJU6KZFnRq0DzXNRzsN6814LPbYLtNYTu9355pKvqG/8qmPOqzcSsUJcLYLw+2jL7FV2rtEV4eTd6rY7cWZShDjxjz6F1tFwSVYPzPuTaJQDKvFqXHBTzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybj2q77i8gCSTwDpguKntXrQyJDVOVU0od7wZTG+lKQ=;
 b=h9/ruzJBzeBBFDtDwOUUfYGD3kfVb/lKxcUwoxtQ3V7kU/PWfLKnQpcRYVXJmuflFUoy50AfiRuqOpcJMyYFuldbxqXFLzdodGQVtRJI1MA/g6l/11sft+7y+EIBSaRNCUE51iIEsjf1FfKv664uAdTEPr3qzsnu8vj6W5wr1ORuZUQKeZwcld+DvODS8YAab24Vz83vjZukzerTkavZ9ZoPg+RF44nLGIvDL0qPq48d7AhosY/k5TBpH1Crmnbif7O2UU2cnEnghV5bTLY8mvrJXQ3uBdpm6Eyzq6Il0R2q0WKoF7qlCXA2hYfOx3rm40sKzk9behPPq0GqqxBxnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com (2603:10a6:20b:570::15)
 by PR3PR08MB5785.eurprd08.prod.outlook.com (2603:10a6:102:89::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 17:12:18 +0000
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::b2bf:19a4:2606:e0a4]) by AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::b2bf:19a4:2606:e0a4%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 17:12:18 +0000
Message-ID: <dbc26ba4-1cf6-4d09-8023-1fa03cde5097@variscite.com>
Date: Wed, 24 Jan 2024 12:11:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net: ti: am65-cpsw-nuss: Remove incorrect RGMII_ID
 bit functionality
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>
Cc: Nate Drude <Nate.D@variscite.com>, Eran Matityahu <eran.m@variscite.com>, 
 ken.s@variscite.com
References: <AS8PR08MB7991CFB38C65A76484AD971CEC732@AS8PR08MB7991.eurprd08.prod.outlook.com>
 <bd06e456-643f-4a49-a342-00a008045b41@kernel.org>
From: Ken Sloat <ken.s@variscite.com>
In-Reply-To: <bd06e456-643f-4a49-a342-00a008045b41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:610:77::17) To AS8PR08MB7991.eurprd08.prod.outlook.com
 (2603:10a6:20b:570::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7991:EE_|PR3PR08MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 607f9763-a8a8-4f8d-4307-08dc1cff9e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91EUkPJ7RdJDDP8NfSdUfORz9FCUlR5HGqVTALEaBSPg4n+moipnYBuwGlf+PMw3vuKJFypNh95gspgOSJnWUxNTklzCR/3ImFRgPbq9fqnbQPyNi9MYgHMU5VPQapr6TWkS6tesemVJxSODhRRH45nbLIOohXsB9y4uPf/fB16A+lX2YDrjcVmaaPq7Ed1etqHXsg7GKzeA7yD8nVRXJWkyEV3wmFxlJxtwptoxiSUyJiO3pU72pqM+5g74+CpoENk4V0vpXxP0Ri3GMMW0UJinlT/640N6HApL9BpEC+BIZI7zV7gpgxyEn2NBu0tNn5k2gXdPdbAFy1/Fb41oPN7r8rGHxcYFyxxcluPEnPL8y0JRhuQxyR5x3yYaoIzyOftftn0I1cH3QCy71xiM440LywDRW0iSw3iXQV0Ol0xChROoGHUJx04xZoQROppKhx3MrSgjP7+t4aR2CelHUDslZNMVWhKM2tL945TL97xrqmY4ENYxrYSTcckbK60qw8FAGNUdYc/U3HvpvwEhqoals/TbwIF5h9WaX994vIuE0VQ8JUCf0F6BjBOsob81CzLnf6VFjkMA9CS503O9RDPm+ZJiA5yWyJUaLRywl2IVQksUXSUlUsYdx4zhnmjeyeQ8icYF1LwxMOw/KCcHgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7991.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(83380400001)(41300700001)(31696002)(36756003)(86362001)(38100700002)(26005)(2616005)(6512007)(6486002)(107886003)(966005)(66476007)(6506007)(2906002)(478600001)(53546011)(110136005)(6666004)(66946007)(316002)(54906003)(8676002)(66556008)(4326008)(8936002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNOK2JEeWlSOEhVVlZRSGRydFpjcXJrU2I1YTNsU3FheU83L09oNzluckVq?=
 =?utf-8?B?M3ZDbHpabTd1UGdBdzlmNEkxWThCbER3S3dIOGFGTWZ6cmgzOXlNUVNEUGc0?=
 =?utf-8?B?SU0vajA0Tlo0KzFOMTZZUlFGNWUvK1p2MHdGQjBqdTFZKzJDOVVweTBOQ1BH?=
 =?utf-8?B?NjlYbDdldkNzNktlL3Znb2FnQ1Axa01UTEVHSUd3cndDNE1hRjg5MGRHOHdN?=
 =?utf-8?B?Nkh0Q0taNFQrenZiVHA4WkNDcmtsUm5YZWZ1OEI0RnRYTUJaWVFjbW9aWFhx?=
 =?utf-8?B?MmI1Z2VCQ09NZHlIcS95N1FtMVAvYW1iS0hoV0d6RHQ2NGJGdnRBdGM3OVBX?=
 =?utf-8?B?TE1CK3g2K1luVWhKcldOWDZqVlk0Q25qcnR6ZC8vQ25yVitFVTUyY0FqdVk0?=
 =?utf-8?B?Q3RtQ3FRMjNXTEszR1JScUgzN05JdTY1MTJWellZWUFxa2ZJamFHa3RBR3Bz?=
 =?utf-8?B?K2F3TWFzZFNZamZtdDJ2dHhpZy9xVFp0cG9ISlVkektCTDVQU3g1RU5TUzZO?=
 =?utf-8?B?dVJldzdYcFpsRDZTaHJ4cWtpaHROZUNCQmtVLzRsUDNRVFNseFU3a3dlWUdV?=
 =?utf-8?B?OEVXWkNYT0RwRmlyajFyZEhSek9DbnJPNDZDV2MySDJXMWM5YUhnRDg3bnl4?=
 =?utf-8?B?bWFHaHBMVnYxdlAweVZpeC9sa0gzTno1T3dNMFNWNGFPNzF2MUlTTFdxcmhh?=
 =?utf-8?B?T2EwYnU2enB2d0VlWFFXbnN0RU43dDNkaHpyRUZaR3c4K3lTQkxjVWh4YzQw?=
 =?utf-8?B?VWJ2U3R2dGVvYmF6RmJyN2czVVpIVHBuZjh3OHY1K2MxakYxdmlZaW4vNjdp?=
 =?utf-8?B?N0owcEVmL3pLTmE4YTNwSGxldGt2NzMxTTlmM0VjaHkyRit3YlBodHZuRmpZ?=
 =?utf-8?B?T2p4cjBRYUZuaHJQQWtJeUY3ck5ia3BrdW9VV1cyVlZDMGJTaFlVRjdrQXJP?=
 =?utf-8?B?b3lPVXZZVzJOaWlKWmsrRjY3d0VPeGtReWhtQUVOVmNzYm9od2ZuM2FBY0lr?=
 =?utf-8?B?WUw1UGFUK0h1eng2UzJjZkIxMEdBb3VTaVVWR0JNSmxHWWlDdTRFUUtKNE53?=
 =?utf-8?B?aEJEQ1VsaUVVVWgzWGV5WTlCUFJHTGN6TWVGdlpLNkFWOFp4dHpmMkorQnJq?=
 =?utf-8?B?bVMyOGNJOUVzVHZoVUxDemg5TEw5Mm1VSzRkS3FRdExUaFNXMHlMNzczcHFS?=
 =?utf-8?B?OG1VeFhUVlY4UHdxVWNndkZ3RjBBblRURkY0dGZ2Wk13cmdxUnJHMWFIUmxQ?=
 =?utf-8?B?RkZHQ2NsbElrRVhoUDAvcFlrVllFcDdBanFQeG0vZUZiaGMxb2MrRjhvOFpM?=
 =?utf-8?B?QmFTMm5sbGZPK0swRlFrdEt0SVF2NkpZYm8zNDFYY1dYVVdIWGphbEw1aVpJ?=
 =?utf-8?B?SW9xU2Y2L2QxbVF6eER0Sldmem84RUlYUE1ZQVJBTWp6Syt5bHVqNEt2cXNk?=
 =?utf-8?B?cGEvZ1lseUFDVEh5TnRWem00M1AwWXhid0k1Z2pQWWQ0MS9rRlBhTi9MT1pm?=
 =?utf-8?B?aGdNMVVyYlhtSTJwMXVRSVR6Y1FvNm1KbW9sRmFhUWEwdkFnYTJnbWppRm5r?=
 =?utf-8?B?NnpicGxzeGxKOUdCUW1UNGc1bDNXekVEaWxkbGZadnlWRFl5NGN5MUpTdi9y?=
 =?utf-8?B?SDdrMWRaQ0FaR3JyeHZITnBzZ3FQMmpaRnc5bjRSdXdOSEV6QVozdURPck14?=
 =?utf-8?B?NDN1dEtGMzQxT2t0WUtlZmlTQ2VzNlMrVllPWDNLeXRHTm9LN0luQlp5Sldo?=
 =?utf-8?B?a0I1NXpobktYbzRFd2NmVU1xN3pLcGZKTG8zaU01bkpuZlM2VWxjZWRFZ0NF?=
 =?utf-8?B?NlhOUU80TVpTRFBNclFEemlJRmpCUTFLVGZQMGhSNFRhbytRa2Y5blJpWFA5?=
 =?utf-8?B?UnZ1Q2VybmRjeWhYb3Z6T0Fab2ZRQkI2RXV0ZmN2dmdMWGdSUmpvZlBHWEVG?=
 =?utf-8?B?eGkrYklMclp5Rmp0RFJEb1NzSUk2bWU3dXRacjFFQ1JyZzQ0OUpTSEt1dHl3?=
 =?utf-8?B?OGdoS2RpUUpWTFY2WjduSGtJSmVPTEdaMHAzQWR5dFlUQ1FNSXRzMDNYekNT?=
 =?utf-8?B?b1hRNUF2U0xXVnJmdHZtU1FsME8vRnlSekpYYlF3OWxDVnFlb25ubkY5V2Zi?=
 =?utf-8?Q?BdahPCJaOg/N7alUul6KalETl?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607f9763-a8a8-4f8d-4307-08dc1cff9e49
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7991.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:12:17.9427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JAhi2/o/E5rIgGWky0CgnhcUXkzWsh0xpJ2vnFNIII7t7wotlUQkKZBpI+BOSnphMJDgSjR3nCXFON7JDerqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5785
X-Mailman-Approved-At: Wed, 24 Jan 2024 19:32:47 +0100
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

Hi Roger,

Thanks for your review.

> Hi Ken,
>
> On 16/01/2024 22:01, Ken Sloat wrote:
>> The CPSW implementations on the AM6x platforms do not support the
>> selectable RGMII TX clk delay functionality via the RGMII_ID_MODE bit as
>> the earlier platforms did. According to various TI datasheets, reference
>> manuals, hardware design guides and TI forum posts from TI, this bit is
>> "not timed, tested, or characterized. RGMII_ID is enabled by default and
>> the register bit reserved."
>>
>> The driver implementation today however, will incorrectly set this bit
>> whenever the interface mode is in RGMII_ID or RGMII_TXID.
>>
>> To fix this, remove any statement setting this bit, and moreover, mask
>> bits 31:4 as these are all reserved.
>>
>> See:
>> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1211306/am625-enet1_ctrl_rgmii_id-_mode
>> https://www.ti.com/lit/pdf/spruiv7 (Rev. B Figure 14-1717> https://www.ti.com/lit/gpn/am625 (Rev. B Figure 7-31 Note A)
>> https://www.ti.com/lit/an/sprad05b/sprad05b.pdf (Rev. B Section 7.4)
>>
> Thanks for the patch. Some comments below.
>
>> Signed-off-by: Ken Sloat <ken.s@variscite.com>
>> ---
>>   drivers/net/ti/am65-cpsw-nuss.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
>> index 18a33c4c0e..51c432408f 100644
>> --- a/drivers/net/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ti/am65-cpsw-nuss.c
>> @@ -256,7 +256,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>>   {
>>        struct udevice *dev = priv->dev;
>>        u32 offset, reg, phandle;
>> -     bool rgmii_id = false;
>>        fdt_addr_t gmii_sel;
>>        u32 mode = 0;
>>        ofnode node;
>> @@ -296,7 +295,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>>        case PHY_INTERFACE_MODE_RGMII_ID:
>>        case PHY_INTERFACE_MODE_RGMII_TXID:
>>                mode = AM65_GMII_SEL_MODE_RGMII;
>> -             rgmii_id = true;
>>                break;
>>
>>        case PHY_INTERFACE_MODE_SGMII:
>> @@ -313,15 +311,13 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>>                break;
>>        };
>>
>> -     if (rgmii_id)
>> -             mode |= AM65_GMII_SEL_RGMII_IDMODE;
>> -
>> -     reg = mode;
>> +     /* bits 31:4 are reserved */
> Updated documentation is still wrong. Reserved bits should be Read only and should
> always read 0. In updated TRM it doesn't show reserved bits as read-only and states
> read value is 1.
>
> Bit 4 is clearly read/write so it cannot be treated as reserved. But setting it
> to 1 is not supported.
> If bootROM or some other software set it to 1 then it will remain 1 and we cannot
> rely on it to be always 0. That's why it shouldn't be treated as reserved.
>
> On AM65 bits 31:5 and 3:2 are reserved (read only 0).
> Bit 4 is still r/w but setting 1 is not supported.
>
>> +     reg = (GENMASK(31, 4) & reg) | mode;
> As reserved bits will always read 0 this mask is not required.
> What we do need to do is always clear bit 4.
>
> So
>          #define AM6X_GMII_SEL_MODE_SEL_MASK     GENMASK(2:0)
>
>          /* RGMII_ID_MODE = 1 is not supported */
>          reg &= ~AM65_GMII_SEL_RGMII_IDMODE;
>          reg &= ~AM6X_GMII_SEL_MODE_SEL_MASK;
>          reg |= mode;

I like this first approach, as it is clear what is happening and could 
account for future use of other currently reserved bits in this register.


>
> Or simply this would have worked as we don't really set bit 4 in mode.
>
>          reg = mode;
>
>
>>        dev_dbg(dev, "gmii_sel PHY mode: %u, new gmii_sel: %08x\n",
>>                phy_mode, reg);
>>        writel(reg, gmii_sel);
>>
>> -     reg = readl(gmii_sel);
>> +     reg = GENMASK(3, 0) & readl(gmii_sel);
> should be GENMASK(2, 0);

You are right thanks


>
> but now we can use AM6X_GMII_SEL_MODE_SEL_MASK here instead.
>
>>        if (reg != mode) {
>>                dev_err(dev,
>>                        "gmii_sel PHY mode NOT SET!: requested: %08x, gmii_sel: %08x\n",
> --
> cheers,
> -roger

I will work on a v2, thanks again.


Sincerely,
Ken Sloat

