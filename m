Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3370D39413
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 11:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161AC83CF5;
	Thu,  2 Apr 2026 13:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="W1Q6Cq/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAC283D8A; Thu,  2 Apr 2026 13:18:45 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF4480212
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 13:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Liv503DNwojLp98/QxNQkHIxkZV24AmMYD7+Za4kMH5hDkjAZeJfs5Yo3BZ1hk7bHIl/H/+DsY1Khj1yxreh2D/OHxTh7NJuVzroGQlb5VWs1t9OgfarFIzNbUAMiZaGZ5VTJFGwJYpmMeZ2iLUHvQKWjnmLd9YJSCnVXiMaWbyYPWXjMxIwpWz+9RztjESPh884gTuhsKb20hBMxvMYKFMUojBQLb5qbKlkagFh5eafcMJL/4JloHZ+C1Ek+B794gXpasGwiTHbcBYAEbTn+nzFQ8CmIh1EJ6M/d1feENuMspvH5xREkuBFXI4RdkeKfn/R/9YX+nr8cxueJS5oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw4/W0K+SSZEpxB+JnRP348bi/U17iIwBx3vjPTAlT0=;
 b=Zs+3ZwOyc2YYg/YPEoBM5Zz0z7EA4ArrxHHks924cqKmnF0cRalnnI2jRj44/P2l0gco/xwn8bOhUhuVkvBTjwcHTBybwJUEnRaxluQH530MqyMscielqqifReazfLTBLlYdxmeN4OqX0Eri4htPuJWYj7g6uNBAnYema7xKjEBApesWbDWIc4QWoaRAtSER9JacuVYm6MnrsVTiDOgeTRXnCJVM2gEEtJ3EnA6yLFSq6FQSmjZRJ8GbgHl1ggeQmPcZlhY31kbkZ1gSzqWgHEH7ZaZ3mFPkBf/3fKhm0OLezt5uDo1zI0C3O6Ad7Xdw5ClH7LP9BUbxXsH6CuYw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw4/W0K+SSZEpxB+JnRP348bi/U17iIwBx3vjPTAlT0=;
 b=W1Q6Cq/sIfix7VkoI7MCxGaLP5YzZDgs0gkUzwycVrmyRTN8HxouEwvt20hTV9RBhxeD13hRP1IHWCcPVl3PFQXLPLIaaP0ROVFCkEGJueT828K6zh/azNXop3mW5bULheqvvt0+h5VR1jCwFY2IzzB0sXFEFN2L6dP7YP7LW1of/C/vyA3zDOj+UtaeBbFWBDvSHujXhLaODf/AnA2Q5AaBN2uGnOWd/8Rr0uSJt31xFCufQn/5bc1xl1G3WQF8gbWQkO2x/SPd0LvDlJLJzinqod26p6AZ31HjnO/2wfwR/USQK+i7jG4RYU/3h4VCsB5lCuYOwwWA0rsN+VrL1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PAUP264MB6669.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:52e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:18:42 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32%4]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 11:18:41 +0000
Message-ID: <4b5c46ff-aa4a-47a2-a4d7-60539a93ee37@softathome.com>
Date: Thu, 2 Apr 2026 13:18:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [2/3] binman: Generate the preload header and sign the data only
 once
To: sjg+nodisclaimer@chromium.org
Cc: trini+nodisclaimer@konsulko.com, alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de
References: <20260401153525.1541415-1-yan.wang@softathome.com>
 <20260401153525.1541415-2-yan.wang@softathome.com>
 <CAFLszTie01tay5W0FfeP-fn_ZGN4D+fQXe7P6UxLAdNLHG27sA@mail.gmail.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <CAFLszTie01tay5W0FfeP-fn_ZGN4D+fQXe7P6UxLAdNLHG27sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::13) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|PAUP264MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8490df-9d53-4758-03d5-08de90a99866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: aE6orQ/Tz8z1ZDWY6l8rKcoqO/TXpIwOJ3n4WmbHHXZyQI+AuQzKJ67bENb5Zn1XfVAYL4Z5i/vEWBvZiq+QBzwfFTxbLkuf/emd3mLeR+0mZlZfuGU6LOFG1w6G3z2hWJ6pmGpaTA+pQwYAqekby+3706TvUBif8oU2r/iiaEDue3vSqRw/EoiXj4JuRSGyy2uXMGP1ZYOvQsi26TfTmRZmd8SR/8Y6vQUKFapzjVY8o0fT12TkbWqFNmKTe9b9/4pFL7xLgz+GEUxrRWsxbkW2cFjmQo3Ajm4V28Aj7Xpua8kDvqpFiStpUylkvWA1v1QxfUPact6tbjb/i6+d7sdtB4vj4XO6d2EIJoKXsjjUjauGqZQO8vMI0664s/TJC+LxVbWD3wB1fZ/hkJkOpLxfWhXNCCvscQgAIsl+8x+qLNSh7qAkD8IhXDanVVgURXti+vyiob1Jszu1JoNW2Tul5nXSJvbYnSZN9k1vomC2cfunBLbMzyloTMKtNn+P0mdKDCJT7lHl8rokuCipZqbyemj35n/H7AYsKHZ/GukbE+VWFcqeP37K9+u7s3/CFguofvqmpbsacvxkpnF1FqMeG5V9bkhmjzUlkiQjG7HIPT2Zs6J3ykzqXR6EpN9c2dpLeGxktAvPjmVPHK29/taAr20uHlzIomK0pO/FozhjBDbFwEiMPCNfgJcsct+8gRCGweJOPnmr8LuHEHEAD9rWStBqMK+Nz6jnsm6y5/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBJOTBoWXFNQTQyWlJQeWhoL0dOME1lNFJFS1lxK2QxczRQVWdCM3JlSHpw?=
 =?utf-8?B?ODQ5dkRMOUFnSEtiWkhaalpCamdTbEgwT1lDMDhIaCtRTlMyU3RqU1BvcjRh?=
 =?utf-8?B?YmtlZEpMNVpoTDQwVkJSZFB4T25IeVd0b1puYnk1WVFtWFJOUmhUbVFCRldT?=
 =?utf-8?B?QitxRWRIQnBjTnJBUU9yZVpVMTZ1bmlmOVVvemp4Mk1OcUtNL3d3b0JsZnU1?=
 =?utf-8?B?V0RRWFdZUFRsQTdEcmZyTWxmRjdVUm02T0ZQRmMxU1ZncXhpNzFSTnhScGFp?=
 =?utf-8?B?NEI3RlpzbmFFNnk1QjU2SEtpNEc0TlhrT3FHWjNFRWd6SjB1cEJCQjArYXpj?=
 =?utf-8?B?bS9OWmVpZ05RSkM0b1U3MjhxN2hhaE5ZcFJPN1Q2QXFWV011SWY2anRvS2Iw?=
 =?utf-8?B?ZDlRejNRTTd2bVhmaDlYK0FFN0Z6UGE2cGQybWp2UUlsQ3JtUndYMTlQYURN?=
 =?utf-8?B?MlVhc08rUVFHWkRuL25UUlJFQ1FDV1J1bEh4cG5LQjllR0duYkxGNmVQa0FL?=
 =?utf-8?B?a0lUOHB2NFdhdlZQem4vSURIY1JDSjlJdnI2cHVlcno0N0Yxd1luOTd0eGRr?=
 =?utf-8?B?Mk1mbFAwUFl3RHNwbmRqL1ltbEQ5RTBBVldSMWxZdGltby9HRUEyRmRUK3VH?=
 =?utf-8?B?cGZWU3ZyOFRmTVp2WmZPdjV3eGNmT2FhaG8vZjJSeUhJUFF2aEUwa1ROVlJZ?=
 =?utf-8?B?L01nbk5CQXAzdkwwQkZwSFBaTHlxZGdSU1J1dDNSZEt6ZS9xQStYYVBtNk9h?=
 =?utf-8?B?SXQ1MUFvRGN2UGUvTlNDZlU4L21iRVVudE8wdU9FZmJCRjRaUEhHaFowYXd4?=
 =?utf-8?B?dGZob1NZL0Y4OUFPUlYzS241OUYrYndpUWtSbk5jT1Vwd29NbFo2Y1A3eVNn?=
 =?utf-8?B?WmpOaVorR3NFdEx5K2k1SUIwamtONkxVZmZwWnN1dkRSKzBIR1pOYkU2RzNz?=
 =?utf-8?B?cW9QN0tOZlZZK3JKWU1YTjN2Z0p3MHprdmZONkNCYzdoTEU5cm1DQmFLNXZX?=
 =?utf-8?B?YjcrQTBpMlRSci8vNFpnVk4veTQ1NW5DZTBSZXU4U005T216V3FVVDBiV1Br?=
 =?utf-8?B?cEdGRWZvZERQVW9lL3Q5WUc4NndnNEFTWlJCS1czQlB0eGZVT0c4OUxJbUsz?=
 =?utf-8?B?WXF4dmxvV2Z6VGFJb0hFazVodFdKb0dKOU05a2xvekdHRklVRWh2K0YwWjlO?=
 =?utf-8?B?VmFDR29EZWVubjdYcHlnN09NMjRRaFIzWThYaFlCK3ZTb21OTDFqVE53WTdX?=
 =?utf-8?B?amo4MnRzY3IwRVZOV2U5V3lTanEvTGlwWXhyektjZmZaL2dMTmhnTFdlVXVK?=
 =?utf-8?B?akNtUVlQNzQ2aEtuTEpmZFkwKzZQSGYvZEtHaFhrdzJrMFhtcVRrSFc5NCt0?=
 =?utf-8?B?K3F0TEtlUVN0SGtyQm43OUZRQWpDaGJxNm9ESGZtZENWNTAzZ01UZGg4VTFs?=
 =?utf-8?B?TjZxVkQ3RVo4amVZTmdOeHdWWFpkVXpBVzg5elBlR0FTVHNXNTRwMWw2YzRI?=
 =?utf-8?B?aVZhdFllVlJGbUVsSFhhWHM0ZEQ2cDZYK3VZR2pKV1ZlSnhYSWRxYS9mREI4?=
 =?utf-8?B?Tlo0T2VXdWNXVy9XZVZqQW5qNHVGZEdTWDFuT1BuQzVvMUhRNzk3d3FESFNE?=
 =?utf-8?B?TExpVFlYakhERE1PbE9ZcC9DZnRPMjBnZ0NKWnA4aHk0Zk1WVzMvbyt3dzEv?=
 =?utf-8?B?Mmh2TDlpUWc3NmFBUDk3aTkwRGZHd0hpRU13UXpGeUNkOUYzNDVLRTRCNGhM?=
 =?utf-8?B?RUc4ZFU2aWNQSXhRV3cwQUx4dUFsQ3hYWlN4U1BXS09qZnhUTjVRWGZPL2lZ?=
 =?utf-8?B?V3ZpNDMwbG53Qmlxamp0cUpHWkVZWFdxNjYycFUrRFdyTE5rdkZxSnA2Q2tw?=
 =?utf-8?B?dmRuMzJNajJ1RXR2TUJVa0lwMW9DS09qV1h6QUlSMlg1R0RENThPL2NGRmZB?=
 =?utf-8?B?VzcxVlEvQS93QTFtRXJhMkhnZlh3REE0MHdCY09HTklRMm44N3Iwbk5ibGp0?=
 =?utf-8?B?WlNnT2tmZ1ZTZ2xSY0xjSjlWaFpFU2lUNzRzSDJvRlhUQjd2RU5XRnhsazcr?=
 =?utf-8?B?QzM0QUIvVmpHQ05YWFhtQ0RDMnhDU1AyZGtpRXMyUXdrc0dNWmtXWkdvNVhB?=
 =?utf-8?B?enRRYUZoU3JSZUhtUW5JcmRKaXJCbWZkMlg4MDNma1hEam9LL1VGVVJISDNh?=
 =?utf-8?B?aHJjZldYTzA0U1V6cmdZVVQzelluMzRwRGNxMUNMZ3kwNWp3TWYwSHdGS1V2?=
 =?utf-8?B?UTU5WGJwSGkwdFVnVUg2Q3RuY05hMUh2QnYyRHBickZQdkN2Rkd2ZWloUEZl?=
 =?utf-8?B?eFlBTGJOTGpaY0RweHBUUzlEYW5tbTQ0WXdZWnpNcGV6aFdrU2U4bkx2a0to?=
 =?utf-8?Q?oaorOdBFLwcB3drI=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8490df-9d53-4758-03d5-08de90a99866
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:18:41.7036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpanMxzDiQ79wThbEMdICfWdFILvy1gTmtYBdQbOsVGJyGJgndVbMB9CNEu9WOWMwPNs+Z+EpYRjwl5N7R5YNfTZnLFvATl1q5g90qX0Q0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAUP264MB6669
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

Hi Simon,

On 02/04/2026 02:17, Simon Glass wrote:
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Paul,
>
> On 2026-04-01T15:35:23, yan wang <yan.wang@softathome.com> wrote:
>> binman: Generate the preload header and sign the data only once
>> binman: Generate the preload header and sign the data only once
>>
>> To optimize the preload generation, the header and signatures are
>> only generated once all data have been collected. This avoids to
>> sign multiple times.
>>
>> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
>> @@ -152,14 +152,12 @@ class Entry_pre_load(Entry_collection):
>> +    def ObtainContents(self):
>> +        """Do nothing here.
>> +        The data will be obtained and handled in ProcessContents
>> +        """
>> +        return True
> Since ObtainContents() no longer calls SetContents(), contents_size
> remains 0 during Pack(). This forces an extra packing pass when
> ProcessContentsUpdate() detects the size change from 0 to header_size.
>
> Since header_size is known upfront (from __init__), you could set
> contents_size here to avoid the re-pack:
>
>      def ObtainContents(self):
>          self.contents_size = self.header_size
>          return True
>
> This would allow Pack() to reserve the correct space immediately.
Good idea. Thx.
>
>> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
>> @@ -152,14 +152,12 @@ class Entry_pre_load(Entry_collection):
>> +    def ProcessContents(self):
>> +        self.image = self.GetContents(True)
>> +        data = self._CreateHeader()
>> +        return self.ProcessContentsUpdate(data)
> Looking at the series as a whole, patch 3/3 adds the build_done
> marking in GetContents() which prevents referenced entries from being
> rebuilt. However, this patch calls GetContents() unconditionally with
> required=True. If the referenced entry's data somehow becomes
> unavailable between passes, this would raise an exception rather than
> returning gracefully.
>
> I suspect this is fine since ProcessContents() runs after
> ObtainContents() has succeeded for all entries, but please confirm
> this is the intended behaviour.
Actually, the default implementation of `ProcessContents()` in the 
`collection` class calls `GetContents(required=True)`.
The patch restores this call before header generation because the data 
are no longer retrieved and the header is no longer generated in 
`ObtainContents()`.

In addition, the `GetContents()` implementation in the `collection` 
class would not raise an exception if the data were `None`; instead, no 
data would be added for that entry, if my understanding is correct.

This series of patches aims to generate the preload header only once in 
`ProcessContents()` as an optimization and to prevent the data from 
changing after signing the entry contents with the preload header, the 
`build_done` property is set to `True` for every entry referenced by the 
preload.
>
> Regards,
> Simon

We will push a v2 of the initial patches taking into account the remarks 
you made. Thx.

Regards,
Paul
