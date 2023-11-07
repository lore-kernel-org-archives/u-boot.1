Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B59C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F1986D3F;
	Tue,  7 Nov 2023 08:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eeF2Lrmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F1887016; Tue,  7 Nov 2023 08:30:21 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED1786590
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRNjF4nKtP3ApaJABGhOcU5hMzFij5+I5i3Q9Qbt5KHgRB/TJMpXyRsPIUwpbv91Ezt0moPFZQeL+/GFY2jnNAx25+p+vJiKZd5FXh5lmYMkZg8wl8rfA2f9vw+1S90W4gBDOqfF+Pejk0wXkNpEjfFGg8UOaGQ5oA6vWNfvZwT6c4m/1fho4Caki+fZmwLPJdV7XVZBJmXuZTl+R5Zw8i6+CG3wjfUS9NRTtBaHyWcAuT9ga1q3jXGzhpRsvWQIqoEuxlzII+E32i9Pi9FVSYDhHIxVMWj/9T0v+QGT1jG5hVUpDhvwyTV4RpJy0o5VidHIsfzyIyA0FKc5/nhndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKRF00b18gh+5PrsXU/9Q0rWt22E5YitXrllw886aB8=;
 b=LdZC/pbFBJmlZAFCzq8Dbmp/NRaJhhYMsjLWiMi0xLxqVD4sbDS92gms5u4gS2asewpsqO5d1xsUj6XcsxKjr59LaBM0BdJXRslbrymnyN6kfDHf00KmwPrTy9pS3O35NcSV2yItsCCt8mST1PAesfi+O+tjA20QHGYAXOv6Xp1IIiMa/p+zmRX/T6UAx+ZoworuPDGNmzF3JebXnx2/JzJEqWmaMdrlgq4REIX7fUCHxH8AAUGOI8K0B2qtaW/3F1Q5ELi/AhfvL31KqklI12yXuj+6bd5m7WN/HuRkZ0FgiExk8vqDO/W5TCTxfTM7EFMtTx42OybiYckqpD+1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKRF00b18gh+5PrsXU/9Q0rWt22E5YitXrllw886aB8=;
 b=eeF2LrmdHalkEwzfo+Ls6CNgYTMTVsNlH+Iny6Sza+T7McHII1MJIXWm9cF3n1WxZO2+zgn3uBAuFroI9WCHVOaZm1iWnrpZrRPCch/pbnIUNvzZHAzlIOx0KInb+y9dvBeeU4A1o88EVGcY7Gbkq/tPfXxxvzrHOYzl2/c14Es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB6394.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 07:30:16 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d76:c11a:5c3f:3245%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 07:30:15 +0000
Message-ID: <ea2c1a57-be87-42b7-be72-04599949b445@prevas.dk>
Date: Tue, 7 Nov 2023 08:30:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
Content-Language: en-US, da
To: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <15b9b0dc-ed38-5b15-f9a4-411e412f3c25@gmail.com>
 <7b7878a9-c0dd-4d3b-b888-2a6a190109f2@prevas.dk>
 <3c84d65a-fe72-8fe1-6f64-7065889641ea@gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <3c84d65a-fe72-8fe1-6f64-7065889641ea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:208:14::15) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 69505a40-7e2a-4198-0db1-08dbdf6362de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSFE0zlL8VSmBh7eEpEjdDFAWt2iYzLzHLQRgIOtV20Oq3XBhK5T+yCU4ikQIaOI2gq6nDGWfXqDFBWzuMH2qia1rSMM+JTV4Eqlmka/wZbVDy62g88DxaKTmRB4BONLnye/kNxhKTvJomoHC4UHwl3mdNgSGH/7U4SPBf3nN0nEX5gzZJ40Cocf80ocCEaLwJjZA/xhU9drHMIsc5tGypf0FPUbf2uJkp2kHOacPbZCeovJbmLsJ2p5GvBlAstZke+i3tDu5GZjQ+wOpvJuEiRY4ra+NIGgA/swvv2s1EzlBvnl0vcCLLan669OUsp1RR2Za3KdauSxq19N3QVBcZjD262cJtOF2FrOIDpFD9TqoybpLvAJJ3tv3Mzxs5nT7zKLlxmY51RcQiiQPyts5JVt26dhFQSSXcycvEyj3/iHFXx6UrP4pU/jCC5DluT+S4UriG8BkMI/AxLpYp2diIAelo8p0qgbfALYCW5rGkVyvGZ4ZnlV/QycAknQ6SU0XynZMjnG+49+X2LVcmpal0oQGFEg/7s+eXm/hXiFGtpnvn+bJEhBlKPI+VQDQeXQMqFJwYDQftjGL0sO6O9EVjoK6eTcGDwOrVL2hDLGB3vHFH+OK2M+AEichhwmnWXGGVVpkFK3drk02AKoZg/7UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(6512007)(110136005)(66946007)(31686004)(316002)(4326008)(8676002)(8936002)(6486002)(26005)(8976002)(36756003)(41300700001)(44832011)(5660300002)(4744005)(2906002)(38100700002)(2616005)(66899024)(478600001)(6506007)(53546011)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TllTTkp4YnM0MVZpMVFObzUxZllIVW5IZng4L3BhU05DaTcwZ1psSUF0K2xi?=
 =?utf-8?B?RVd3dWxYUkhISm1yREFMbldNdEZuN2VBVzZ4Z3JSWThmTnNVTENYK1dxYlN3?=
 =?utf-8?B?WlFIeS82NXJMb1NXZU9hZDArZml5ZTVXajRjK3VqWGtBL2daek5QREY5dFoy?=
 =?utf-8?B?SHFBTjVobGVBRzhFV0hBSXl0QzJHNnlrdmhYblYvRWlHWThNWEVGZUVoZGJy?=
 =?utf-8?B?cW5zVGNWSzRjZDNTU2ZxOGRpcWRTcnhhWnI4eUNHZFMzMnVwWDNSZ25remV0?=
 =?utf-8?B?aHdrQlFjOVdJTWtnUzE5VFFiOEJ3VHo0ejM4Q2Z0dUNnbnVOK01lbGZsUEpU?=
 =?utf-8?B?TVEwb3pQaGtFczJqbzZyUHhHQlJuTUdXYTYzekdGYm1yTlBpSkZaZnZBa0NQ?=
 =?utf-8?B?SGJoWVJ5VUdjS3VOcS9UdTRMenpVWXVrT0ZrUlRLQS9Eenhhc0FwRWFuMTVz?=
 =?utf-8?B?cVlDUTZNU1VVZGI3WHowemdFVEQ3a1BCSnF4UXBneWpvYTY2YkxPZ05pOG5X?=
 =?utf-8?B?NGRVRktHdWtaNmNyNWE1dFFyZG83QUsyUVR4eCszRmNhY1N0cjg0WTlEV3Qr?=
 =?utf-8?B?OXZqSDJqdUVrbnRuaWVETk9naFNHZlQrQk1QQWpkaG5VWi9INHU5U3JSUVlB?=
 =?utf-8?B?Ny9iZ1NRQzd3T2x4WThLV2NOcWtZdzdYV3l4dEZjNEdINHBJQTRXdkhiOTZh?=
 =?utf-8?B?dkJSc3R1TkNGRGVyYjB4SVc3ejZFOUg0ZkFid3prREFHemlqbE9RNlRsK3pI?=
 =?utf-8?B?ZGZvSEhYTEcvT2VDaXoyUVFSZ2M5Ny9neWh5QXQ0eVlhRGQ1Z21UOE51V3BL?=
 =?utf-8?B?cU1iU1JwbDFUVHRobHVmRndJUk9kVUR4T3pwVDlJNW9mN0lMNXRzMklJN0hQ?=
 =?utf-8?B?d2FyVnZBRnhTTm9aSVR6T3N0QzcwTkJocGJNa016UitPWXdqNGlYa0ZQQnZU?=
 =?utf-8?B?VWxZbWZWSWZwSFVFZi9SdEtSRklMTDhIUysyRmplZjAvalBLUVVFS0xvcnkx?=
 =?utf-8?B?T2ZUeFlFMm5BOWxsalJ1dkRWTkU0ekd3dFNodTFMaEhZS0hwZGlNdzVxWTBq?=
 =?utf-8?B?QzR6aFBuaW1HOW02SmlTaUVVMEhqY2hBcU4ydUg4RDBsV2ZQYlZiNzF5NVZC?=
 =?utf-8?B?Ylo0RkFBZkNwd0dEMEJTQ0IvK0lLTTBIWVBZSE15Y29YZHp4Z24wd3BQTGVV?=
 =?utf-8?B?OEF2T1hpZFVuMGhrNFE3SDMzbExCajJEbXNNUjc1YXBSTG5aNlNIc3JheWVy?=
 =?utf-8?B?RVJjQkN6RUxZTFYyUkQzSVN2ck5mMEYzYjJNdWR1c2hWL2ZSa0RyVmxLY3Ba?=
 =?utf-8?B?OHlwRWFReFNDRmRLVnFnbmtJYSsvaWgrM1hPRWVROGRoVDVNcng3VWM2YkFF?=
 =?utf-8?B?SHdYZU5kT09XaUJMeU8wcEFhUmZXT3pSQ0FWVEZZVTB6aTJNc1J5aVJXT2hn?=
 =?utf-8?B?OGlvRDJyNU5aRkVlT3VmanAvNEh1ZGdYY0cxNW9XcitFOXY4b3Z6cXQxMzI3?=
 =?utf-8?B?Q2xiK24rV05ycUQ3OHp4bjhJa3kxdXNJdVJaV0haZWxKb1luRzVpRk9hRXFv?=
 =?utf-8?B?TzlYejh6RExJZHBnVmk0TXl0Q3cyaXgvSXFjZHBiQ1NveERKdGZ3S0FId1Nw?=
 =?utf-8?B?amk5ZjhUdFNWV1crRWJ1d096Y09GU1RhQ1c3NUZCYjV1UllBTWxkK2VWRW1S?=
 =?utf-8?B?d2NZU0E5WHErT3g3U0J0K3ZudG5JSlBLOExaQlFkeHZJNW9KelFSTm9OVlhT?=
 =?utf-8?B?QVllMElON3g2bzY4N1RGY1FIaUdlczRiUHNIa0ZMYzZYSG5JRWpFWm9uV0lQ?=
 =?utf-8?B?QXRVMFZOR01zaUdXRmg0MDBTUGUwcm53T3B5VUFabml0NkY4SytlWXR5eEVB?=
 =?utf-8?B?YkVkTytsaGtwVlJDRnNTa2JoQTJocDByRSs0a2ljaERXUzM2SS9rTWlsTnZT?=
 =?utf-8?B?N3IwM0UwOEFtK1RJQzRlSi9aeGpzc0RBcThtVDdDR01qWXMrS3lpUkVvdDVi?=
 =?utf-8?B?c2tJT2dpeVY5Y1lsV2NqODNSbXNTSmJSY3V6WHF1SlA1V1dRaFhyNHZET3Ft?=
 =?utf-8?B?UW5VWG55dng0TWQvRURQWnZWMTkrMmpLNWFrMWdIRzRIa0t1VkxnZUdmbFg2?=
 =?utf-8?B?SFB6K1d6VEdzRmpiUGY3dUtyMDRoaFFXY21hMUwrZUlrV1ZQUXJpK05Bd1dj?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 69505a40-7e2a-4198-0db1-08dbdf6362de
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 07:30:15.7902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izC5wP2yZd6zV9gwWF23Z7Ji8Eec8w8vM2PslX2kAk8mzqCGsa5fbJeb/CVoLpOmL+uD+Yf2bobqXScaWAc9BsjPG9HSl7+v4ldEXQYHskY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6394
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

On 07/11/2023 01.46, Sean Anderson wrote:
> On 10/13/23 14:30, Rasmus Villemoes wrote:
>> On 12/10/2023 04.17, Sean Anderson wrote:
>>
>>> I was hoping you would respond to my most-recent email regarding this
>>> series.
>>> In particular:
>>>
>>> | Why does mkimage have to do this? Can't you just use truncate or, in a
>>> | binman context, align-size?
>>
>> In both cases, that just affects the size of the file, but does not
>> affect the totalsize field in the fdt header.
> 
> Use `dtc -a` then.

Not possible, when the generator is binman which calls mkimage which
calls dtc. If I was using dtc directly, sure.

Anyway, I currently have more important things to deal with than this.
Simon, please drop the series. I'll send a revert to Tom for the
prematurely applied fixup.

Rasmus

