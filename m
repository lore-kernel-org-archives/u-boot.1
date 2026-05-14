Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E6CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 18:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFAFC84687;
	Thu, 14 May 2026 20:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sKehrHKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452C4846A4; Thu, 14 May 2026 20:50:27 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773F28465A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR1SIBLBb17YaM9fX1EbfODmHfHhKhW6G6dg54Fjv/LfD5X8GhJmtPDrA5pnUizR6UjWb6oS6ivYxE1vJdrMFsyPzaFk2QdClkslVMcRJymFPXRP6hmkJ8O5L/jXhjP+dRaSy8gxyYBCwSJNIoVGohd2H57C/N/7jziyN6nU1WTvm/mx29G+6zPXgmoQK/Lyb52Sx/5D3SWiOYfs6leHREQmNQNEZivxMEpq8vAfQV5910Z06Xv+rYgf02kBzhB7zz+4kWXXExXhzeko/BrtaqUtBQf1CVyztfbhNhAinwROYiIK1I1O/5GZFT3CjU0d5MwOi1SWsOiJ+RrDnFp39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJI7pQoUvGKLPk/A6vXIidJLaVrGDegag/ddJgDbH5s=;
 b=jgu6R3rJ5tz4MDQxOMaCbAH04O2SZyZQS5aRdBCBKKWmVmkXBtXP7q1YWafWbjzva60m6Rrnu8CN40x45cQRrCyvIsozeJDXjr0v8Tj2cs9/XvVXmkhmFbQS3l3Vbfo4aCSViJl+NbsTLEh9q9FOD8mM/sZqToC/ikf1Mjg69dcOFxzXdbJTiZ3JR6u5NoMYcoS4p3F3513hgT3TOHa1jBYM8iceLmVGy7NC8yde+dIwpr2ZnlVUImHTURZEfCJgBE2G+xqyB3e2w/EuxJyomON8bYIWxMcwvjDDc6RXH5Y0XGqLeyNdZLiy3r+8lpLnKwuBSfbSQZBBvG8cYzCyTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJI7pQoUvGKLPk/A6vXIidJLaVrGDegag/ddJgDbH5s=;
 b=sKehrHKxyFChOyQbGAkz1pdVmNN4VTpsvr/eqsSUX8Tok4Xl5mxTcwdcTSsDx/+5duqR4GRgacWQFR4dauygjKEZjtONKh/hkx9chh6n4TH6BqzbHsoUTso1ykr++S4yyNbVjyVPbV0IoOG5d7EEwE0PW9jTjswRnS/b+2uOs4wFpqEXejL3J7R5Umpf7RenyuGNUF1cz7RJJHguXe/Vyr4/rnDjDfVkaOcfan1qe+xWovTg7LnSBnMUcALRsbgvJqTREIQjX/cN8DgSstClJ/jMnavz0TKA2iW44ipP+EIce6cbVg2RPn8gqrY3jqXS3+Eq+cgDdicrAZMWCWZ/wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB7280.namprd03.prod.outlook.com (2603:10b6:8:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 18:50:17 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 18:50:17 +0000
Message-ID: <190995da-40e1-422d-baec-dd3bdad0b315@altera.com>
Date: Fri, 15 May 2026 00:20:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Judith Mendez <jm@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <52ec8007-ce50-4f12-b796-4b8c2aa1822e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0357.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba55aba-76bc-4011-bce8-08deb1e9a409
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799003|18002099003|22082099003|56012099003|55112099003|4143699003;
X-Microsoft-Antispam-Message-Info: UJTwCkpokSVe6GHYSY+iIxe8Nk2GIHz/tYYOY8WpJyVBv0Nyc/wcF4RQJA3VoGmwlszXJk4Ynymn2pN//jY4C9nCmPrq/xgVvJejR+H26wGbC9Gp5jkrSCnQtY/fCh+qYimgHHOD1TBrZXC0DVPG9OsxdM+GJz/QFqMCT43zEJbOczctpy6XFQYRfUaGktUNfgC/tWJ9wby2TnbvMlKEhqABZy7gjQmYAZkx1R0zaqGZ4u8JDNgcDfUVPJvvosg7oQ741FtzvsqgjVbhXcUTy98FXCMO8iNKAz6DSgBbK1Thq8ED7rtvifRSVtWQOFia7M3ZpdlDycQqKSINf4tlwrwIxsPWkqzX/iYcvvwxbRpmw6vEfUBU3dHCiy7TL/JI01ijtg8Ms2oiRF5HL+d0zSCtUS9B8WX3JD8b0kU77EAyKp+MDcD/L64IIh3PDhQZ9M7770vvWKq4xtjcRZ+/fMfZ0jr1ELzn609+KnQxpqcpb6INx2wO3ZYUxImmaPBB6hvaUeIQLZ2PcmkAMEuBk/lMR+lIRq/tTF7bNt43TKuPWAEV4yCKMe9zc9INcO6FVDu177cy/vMeiOrjXw6CgUPiCtS+DI0Qe/o/7lTB/3cgiAAwXMo3MuIWZgTJkNZdnNsUY2l2ApqV2bhUREndRLVJwZrKceo4rXl5jVzsrdRtak8qSTJxLOi/VZtp+crl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(18002099003)(22082099003)(56012099003)(55112099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEd5blF4cjJrclJDTzlRRC9MQVNsS3FHdXJRVWlzWkdZY1VJa0dEbHR3Ym1i?=
 =?utf-8?B?RmhhKzVQQmYxV3IyTDU0d1BhMDkwbTZ5aTVjSnQxNnoyZmg1QWsxSzVYQmVH?=
 =?utf-8?B?MjFVaHJmMjRSaDM1ck1TYmlRUTk5SXF1M2drWkRjVklJTGVqaXl0VHJBc2xm?=
 =?utf-8?B?Z3pSL2RhVkdDaHVEeU9jRWliRm1SOUJKWDVxdFVCcDBiUytEejhzYU14UjZQ?=
 =?utf-8?B?WnVrOVdKRitzV2ptdjA1ci95bElDSEFIc3RJM0lwcUJTNUtWRWpGOHVTaHBD?=
 =?utf-8?B?UjR2Wi9xZzdrUmxqZTdYSnJwWm9MSFBwRW8rSDA1VGV3Qk1WdUxpbGkwUFlT?=
 =?utf-8?B?b0RnTnQzUDJhTlhQcUZsUmdjZFlmY1lLM0QxVHVDV1E3OWluVDFhRWlBbnRO?=
 =?utf-8?B?THBCQnV1ZWNKOTFqT0xrOTJ0RGxGM2tFQkpkazllMUhYNE1HaGZmZWhXUkRm?=
 =?utf-8?B?SXhIVlVUSUVuZ3JybUt6Z0lYNXNWTmZ1T0tMVnhCZU14OWVWeHRIdnViYktu?=
 =?utf-8?B?U1FsTldBZllIM1hhRDdBOVdKdk04dWx0TmZHRXJYbzcwT2VFVmJXMEUyUS82?=
 =?utf-8?B?UWlvME9KUHkrTUFGMXFURDJCOEVYNWJVdEVtaElUaFBvM2lGcDRBa2VidHdo?=
 =?utf-8?B?TFhWR0RYRzF4eUVyRG5nT2orWGtkYmRlUDZndXFMUGpLOUFNZDhUL2p2ZERa?=
 =?utf-8?B?b3BLbnk0N0wxbXQ2c0J6cFJqd2dtSmNaNnMvVVhkTFl0aFZ3djRuRG0zYnU1?=
 =?utf-8?B?TEZHS1I2VWlySjJJbk5SYnl4K1dKTGtKVjk5dUVReUxKdWhzVVo1NTJPTmU0?=
 =?utf-8?B?d2VUM3pXWTZoUVM0S1A4OU9jakdweFd4TU85dDAwTzg4cmI0MjNkK04rMlAz?=
 =?utf-8?B?SmgveFkxMzZHRXdWT1FWOGtJNndVMnBCZm93S2FMQ1ZKMERZNmMxQlhaZTBT?=
 =?utf-8?B?cHV3TzBPL3NOQ2RpUkluS2M5MnNSTzk4L2Z4clJpRTg1dWN6SzMxVzVpRU1L?=
 =?utf-8?B?VGRKd1pXWTNvOXRXamNOS3NoZHFocTB3ejZWbEFMaG9MM3BXQlMyWDFaaElO?=
 =?utf-8?B?OGxGZzdjK0NLbGtnY1hLcDVKblpEdnJDbTRCMHI5RWdIajRjTHA5Z1dUaHVl?=
 =?utf-8?B?bUlSR3YyZVhVTElqTlJIZmN4U1dNRDZwSHByam05Zi9SNkNrdW5sZnVVMGdI?=
 =?utf-8?B?a0tLcUxJcnJiYVhCY2RuaVNsQks0VkhDdW5hKys2MWJzeXpPeUh1UGVkRkdr?=
 =?utf-8?B?RDJZUzE2N2czU0YweXVMU3AyeHZrN2szb0k1V0IyQXZ0RlQwRlBQRkNaMEpz?=
 =?utf-8?B?bGFvNFBOTURNMzQ1dlVoZEhOcTFlMUNHdFFramZqTnZ6Z0pvRGFyNEd1UHVF?=
 =?utf-8?B?QVorWlQ1YUhOajd0MVMwQldVa016R0tQbk5QeDJUaHYvaHptVERNSkNXbUxk?=
 =?utf-8?B?QzlmbjYwVUlRODg3bTg5dEJaaDhQdjNoeVVuZHZEdHNpNDZPV0RxQStmZHVW?=
 =?utf-8?B?UzRwUndhTlNBZ2dRUjVwQVhULy9ldXlFTncreFhhcmJoNGVDUDJsNWFVUmdT?=
 =?utf-8?B?Z3hEZGk1QXYxNGFkcm5uTGx4bnJmUGdUNW01aVd2Vyt3VEtaZEc1dHBpRjVx?=
 =?utf-8?B?OUFIbExieTZjZElLelhzNVorWWtpbFJuK3Z5Q2NEUjlKa1ZYQ1BPNFNYa1FV?=
 =?utf-8?B?a1RiZmt0amZQUTAwSFFUOEpwY25oN2M1UFNMK0xna3pLUURQZU9ONGJsQ2hG?=
 =?utf-8?B?cXZML0hJWHpQUGVxV2JOcVJQWitUT0d0R3N3WEVnVE9HaVBLV1h0QVFiOFln?=
 =?utf-8?B?eUpxczVRSkFCaW5EMXJhV1JXMlY5Mm12UW1Ma0ZEWHAreEdueEptSTQveGgr?=
 =?utf-8?B?ZjBTRE80SVJBaXBuWUJHU01JditSdDRzR3U0T0oxMDBTS3JDYmx6N1gxL0Nk?=
 =?utf-8?B?c3hOcXk5Vjg5Z3V2N21ybzF3MDB5L1M4M2c1ZXNSTHJ5a1I2c2JMWUErUnNw?=
 =?utf-8?B?M0hMa0swTTRLNGVFbTBESjFtZEIxdnBYalRSdXZpcE13OHFBYUpmUEJoOFNS?=
 =?utf-8?B?T08rb3VPQm1qYytjVzVvWStWWEljVUFqTFR3QlE5bXZEVVNwdlBsL0lvcUoy?=
 =?utf-8?B?bWYvWUF5dkxES05pTUU5N2t3Y3lxSjBCV3dlcHZnblZ5aGNpeGFvOXJOSGM2?=
 =?utf-8?B?ZzBNQ2xhWEpoWXYzMFl5MVc0bU5NYkg5QVVQZmFoNEVmbjZ3V2NMbG41dkRa?=
 =?utf-8?B?eEdaWExTbUhHcC9venpvZUtPSThpWnk0RnhwaytleTF1Y25DeGw4ZE5udVd4?=
 =?utf-8?B?UlpYLzVpVXZ3WFdpdVVybTJaSFVnbTNmbkRpckh6RnI0S3NSWHJSSG1JeDlr?=
 =?utf-8?Q?GseDzVE/Rcc8O6pQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba55aba-76bc-4011-bce8-08deb1e9a409
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 18:50:17.5030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QDb3qbkELzhBy6YXZYmBruEibhrEK9Ihti3fhbmob1D/2PWRqjlv6JvNu9IbZco0bsedEFo0LAVDydhGkocjZftlq6Jigp9dCTR9g2SEek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7280
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


On 5/14/2026 5:09 AM, Judith Mendez wrote:
> Hi Tanmay, all,
>
> On 10/21/25 3:45 PM, Tanmay Kathpalia wrote:
>> Some boards have SD card connectors where the power rail cannot be 
>> switched
>> off by the driver. However there are various circumstances when a card
>> might be re-initialized, such as after system resume, warm re-boot, or
>> error handling. However, a UHS card will continue to use 1.8V signaling
>> unless it is power cycled.
>>
>> If the card has not been power cycled, it may still be using 1.8V
>> signaling. According to the SD spec., the Bus Speed Mode (function 
>> group 1)
>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. 
>> Thus
>> they can be used to determine if the card has already switched to 1.8V
>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>> transfer mode.
>
> This implementation broke am65 IDK board SD card boot, I have still
> to check why this breaks only one board, potentially there might
> be a quirk only for this board... But for now sending the question
> in case anyone might have an idea what is going on & save me some
> time.
>
>

Thanks for reporting this. I had a deeper look at the code and found
an issue that is likely the root cause of the failure on am65 IDK.

During a normal cold boot with a UHS-capable host and UHS card, the
voltage switch to 1.8V is already performed inside sd_send_op_cond()
as part of the ACMD41 handshake, and this is recorded in mmc->ocr via
the S18R bit. By the time mmc_startup() calls sd_get_capabilities(),
the card is already operating at 1.8V and reports UHS bus speed modes,
causing mmc_sd_card_using_v18() to return true. The warm-reboot
recovery path then fires unconditionally and switches the host voltage
a second time, which on boards like am65 IDK can leave the controller
in a bad state.

The fix is to guard the recovery path so it only activates when the
voltage switch was not already performed during the current session:

-        if (mmc_sd_card_using_v18(mmc)) {
+        if (!(mmc->ocr & OCR_S18R) && mmc_sd_card_using_v18(mmc)) {

Could you please try this change and let me know if it resolves the
failure on am65 IDK?

I will send the patch for review on the mailing list.

Regards,
Tanmay
