Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF7CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 14:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56A783CF5;
	Fri,  8 May 2026 16:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gp2fHs4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C038466D; Fri,  8 May 2026 16:02:57 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1058341A
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgPRzJS6bDuNexyoaLBFKsQEIiRLKx3fFRO/a/b7zZ3WoF7aZKkuh1/0M1vOHYw8TI6COHlitF3+vT/uO3UP+aWVLdY70pznWnpm5F9GeAE3EOBqKRWdn00OHvcIktcwTh/fi28+Crog2SF22xmbDKzIrKgAqrfyZUnxlnWiN9nDex/QFUWhu6iGGwRo0MzYk1JQsd8+4eyW9/0TrScJw87GpS8oPfENjMR5BcLnlLviyt+CAguPhd+kxZzbwRC9fjFFrc6escRvQlhcRmzMjqyJAVQsdG3CGHCdftpR2pLncN4Cad0/8bcE53yUI++olkUahx7/U+a/tIKw/oJDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK7KAl1hWxy6BHTEi4TMz50btz6393lpuWMZvuafHPs=;
 b=fTpKYSrKggEIFKJuoeRfhaoQtcWbT7NAV0ttOZae61oCTPrtWZ0purrcW5R11HEKEQ+ua0QJwxJjg/bX0mVuROvidNl4OfRsD+gE3jK+Yi8y17mwjGP5iHHrgxtnuxVXWKuszd+Z/knnOy1Yms0238IM6/kRlGhrGfbghaKGoLV/YsucIewTbVLWCbwzjgnMGyOhRCmZW+VjN/Xj1EWKKoV12pgPGGauJawiaNzicROE/O7nMPuQTmGv3uk/0b7XnCBbXprdiY85gCxAGnhCtYvcSJbUxvitUB800qI3ftWv0Y6FEy/AaQ91Be9kzrmA9j3SajAno2Rz6mi3Ffgd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK7KAl1hWxy6BHTEi4TMz50btz6393lpuWMZvuafHPs=;
 b=gp2fHs4XlEMY0S8AivX4Pv1qhZXMziibBaWWtGD005OpulXYZ2Qo/KZjT1iBn3j79S08eIV18uNklwWHRkwVyrPe1NcJGVW+vRdGRjWSvoHhkOmZihGMHLBKVuzAm+qhsYFVH/vBRDcHa14J+axp5XZrNKGGoo9q11t2mtTjl6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAWPR04MB11621.eurprd04.prod.outlook.com (2603:10a6:102:50e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:02:53 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:02:52 +0000
Message-ID: <2cf115f3-c889-4b57-b20c-3eb2b7bbde03@cherry.de>
Date: Fri, 8 May 2026 16:02:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] sunxi: extend binman FIT description for signed
 SPL images
To: Simon Glass <sjg@chromium.org>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-6-lukas.schmid@netcube.li>
 <553ba73c-8a90-44e3-9809-185b0fdfd2ce@cherry.de>
 <CAFLszTjwdY_+17qWouSMq9Bh2N1UJ6_Sq-JP7huwA5Y-YKb9zQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjwdY_+17qWouSMq9Bh2N1UJ6_Sq-JP7huwA5Y-YKb9zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAWPR04MB11621:EE_
X-MS-Office365-Filtering-Correlation-Id: 604fa718-84be-4467-ad1c-08dead0a7f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|3023799003|22082099003;
X-Microsoft-Antispam-Message-Info: pZolCXSopt2YpXSftV7gPqUcHI1ZY78H7WqGlb/gCtS7Z+vmCpnAz8DmBfPDGrEY9YajTOTh0Zbk2P5iWAuHsPBySwiGal/CZom9VtrsWxRaLDuNCgjfImDIn1faqjrw310mxJcSgWZ857+v2N0GW/1X+r00vBTWyF653WyKbkdP0cIVM0pWaseXsOdnmdjxSYqZTp4ELSCAD12orO6RT+CMKrJqk/lGXTZ0OXC/+POhaaleTWmvpa9Z73BvfSKeZkBVnA6aYseG4PeF2MPONJFTFU1XfDhMMdUWpqhK6lWUoomqbbr+aTD1yq2lHKzO6HwvUWVFcS6Cwz3SSv+e/9+PlcClDBOmXfIqcLGAmzbQJLnvog3r7Nduf/5Jcu5jW6zNiUYJcM38zGf4pXjTvVaXSWV/KVe1oKONqdKD3MzctpHrxCU46nuN3HHFMA6eEFRR9VIRrZGh7EhbDltG0rN7CZpkbUWLUlMyqhfNWMA8OzlJDh69SB47UJjYkAndHrszztDB1UKBeh+8wW6g87eG2RvSUbG1SVsNoo3j3knBJG1SmAH7uYwbt2wvf+bTsoekSlDNNkDKxmIxmZzBFz8i0HCK0YGwa78Al1Uni7ETgYFam7CcitD5lX2TyE4H2HDHQKZ3z9Ujh6xPALuvpmB95ptP6RN9WH2pggA+g9qSC5VgEbjHCZNkqDt81g54
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(3023799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkp3WGVkcHJsd0pWV0lQc1p0RE5kTzRIN2M5c256d1Y1MnEvWFBLRmc0alA0?=
 =?utf-8?B?M1NlbVd2UVR6TUVRazhiamVqV0JaUjAwVDEycFpnMHZEVEswTkNMRG5FR2xp?=
 =?utf-8?B?NTdIWSszeGtOWm1ockludnArZ3lITThzYy9vNUY0ZkxrNUJYN1piZlNzYlB2?=
 =?utf-8?B?bEdZMkFRY2JUUC9tSE1nRTVHbG9uS1NEYkdUYkJ5eWZGVmVXYk15RjBHbVBz?=
 =?utf-8?B?UktDYWkxU0VvTHFwYzQyMEtrOEg1d1FhUEpyT2lkOVBpMkRWWnVvaXNrOUZv?=
 =?utf-8?B?ZnBFOFRYNTRiT0M2UUpJRG9rYjdTK1cyVmZrbFQ4ZXI1UGpsWmF2eHRsWGdy?=
 =?utf-8?B?YUt3T0ZXRUFETFo0MDB3Z2crTmw4WS9OaGVlem5lb2dNYmJlZjl0U3o5OFlR?=
 =?utf-8?B?Sis5UENDSzNJMFJtcUFLS2lMaFllQTYrYTUvaEZHN3dLRVprY1dpLzVmNElG?=
 =?utf-8?B?NHZCVHZnM045N3hMUzhIY2loVmlGc3lIMlFQckwwVEcrT3B0eFBWeUs2ZWM2?=
 =?utf-8?B?Q2xmUlhkNFp4c0lLQmIzN0hoZ3J1Y04xWlVQV1c1MUNZa0JoVWVaWG9aY0E4?=
 =?utf-8?B?eDh6YTY1TjluVzRYQW1FUmtuL2xqLzEwT2MrZmlnb1V1Q2NiM0pCbzNTYWwx?=
 =?utf-8?B?NXFSZW9MaWpHTXNvblRUSWhCZTBLUWFvL0RsbWV3TDNQWjVOaXBxREg1Qllz?=
 =?utf-8?B?cnJRMFAzZXRjeTQwdlFyRjFqTEhRM0tKczRoQ2VsWFFveVlNZWJ1U2xqckly?=
 =?utf-8?B?N3Y2N2ZtRGN6dXRmYjZFcFRic1Zwc2F0cUE2bTMxT1Fkd0VPSVZNUm8xTnNQ?=
 =?utf-8?B?SVhEN1FmVUxQR1loMmtHazJGRW9iY2NaTUh5Z0ZWeklQQWtkZVZHbmN6QTE2?=
 =?utf-8?B?OWRQT2lsTWJuV3dKWndnZ21uVEtuS2swdzU3MWdBY1UvWVc2b1AyNVB3M1k1?=
 =?utf-8?B?WCtIVUx1RjFmNHlmNVZETEpRN3grSExtcWFZREhaak1TSzd2NnRwNjV1VmFC?=
 =?utf-8?B?V2lLZHQ5bFJJdVpoUHI5ZkMzT2pZTGtZQzJ4TmlMcFJUblFGY0xzN0xjdjNj?=
 =?utf-8?B?NzArcVU3eHBWYW51NFA2UDZlM29RN0g4UVNaUVZWUDlJVXVHWEdZWkZZcnhQ?=
 =?utf-8?B?WUJJMTBadW5VZ1JNZW02UWFYcHFLQ0FqVmhCNWtuSVRSYXBiTkVkdHlpL3c2?=
 =?utf-8?B?S1F1enlBRHZKK2hyUDdxUFZrNVZyL0Zqcm5CZ2Zsc0xPVSs4eHV4VU41MFE2?=
 =?utf-8?B?RmJGemxudmpzLzVNSlB0VENIQVV1ZURKWEUrK3hYU3VwLzFTa1QzbnBidnMx?=
 =?utf-8?B?TGo2QlptQ3h2TFUyV05uV1dQT08rM2wvTHgyQW5tQzJTd3VHT3gyTTZVSjl5?=
 =?utf-8?B?NldZaWNmTnI3am5qWUF1dHp6dlpZeUg5TmRWYWVmcjNpZHRwd2w3TzhBeDVI?=
 =?utf-8?B?ZlFvL1pMcm1Td1M1MXUzUkhCak42N1hkOWFseCtJSlpwMlhZMjZhdm0vTFN2?=
 =?utf-8?B?dm1ZSjJvK1RqdXhxU21vNm1pbU1ieWJnanNERTh3WStiZXRlT21DQ2dqcHZz?=
 =?utf-8?B?OU52T0wvTlVQRWhIM1ByTEZ1emZ2bExHRnp5U1NJWFJIbnloRU1NR3cxRDFR?=
 =?utf-8?B?YUhwY2dvaWIvUmQzeWRJcng4NjFQWnVPZ1lTdmoyYTJtNWJNU25oMkxjKzdz?=
 =?utf-8?B?UWt0eGlxM3FuUDd6WXJTTm9mSHF3WGJKYmVxOVh2NFhrUjRORjNWVlY0UXJx?=
 =?utf-8?B?dkowcU4xUytnQ2hCc1RFYkc4d1JHSFhGK1lyTGlQTkw0M2Mxcm5wWE9UeEc0?=
 =?utf-8?B?YzF0R1BPeEUyYmsyOTBTUFdDbTdMV0xPVGdCUXhvUTcrSitWZFVWVGtiMXpB?=
 =?utf-8?B?elQ0THE4Ly93ckFmdUk4Ykk3SFlpTVlCR2toai93MElJYTJ4bjI1VXB6RkVs?=
 =?utf-8?B?cmVIWjI3Q1NwQUZLUWhVKzZxNFV2UGNyRkZGWFQ0YU9jSGIvYjNHMnpLVVBZ?=
 =?utf-8?B?a0xKc2hvSWhCMTVFRlVsVm5ZOC9VV3VodWdKYUl2ZW4vcFVPWEh6ampQSHZw?=
 =?utf-8?B?eTBVaTlNQ0JzdmVnK0JRUStyNnIza1N0MmhoUWk4TDZHUHg4M2xlaFRncmNy?=
 =?utf-8?B?QXNNRGNFTTZNZjJwMDB0NVF6enh2eUdLRnFaN05nM1ppM1BJSyttOEo2VjR2?=
 =?utf-8?B?RHp0ejYzRGQxSGNZYXRjdzR5REZTQnl0TU5IanFwa0ZueWpES29HVzRyOEVi?=
 =?utf-8?B?YzRJZzNTMUhtNWlhcEs2RDUxQVFETkpER3hDUmZhRTVEbUpoYTJrZVNhclpu?=
 =?utf-8?B?K3hLdGtuTlNTNW55Rzc2M2piQ0pkY3lzanBza2UzVi8wT2lhc0JtQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 604fa718-84be-4467-ad1c-08dead0a7f25
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:02:52.9173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCh2DTYwTYYwaF643tqHKEyXrveR3ZwLIcwXKHG8Oou4N1j8cpkH3jDTZqPx7J+pLjqI4Xl9b1Y4IdmOWImeQ+XgpRd7uvbnixNcvb4+ysU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB11621
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

On 5/7/26 6:49 PM, Simon Glass wrote:
> Hi Lukas, Quentin,
> 
> On Thu, 7 May 2026 at 05:30, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Lukas,
>>
>> On 5/1/26 12:33 AM, Lukas Schmid wrote:
>>> Extend the sunxi binman/FIT description to support signed SPL FIT
>>> images. Add an SPL public-key DTB image, per-image hash nodes,
>>> fit,sign support, and a configuration signature that covers
>>> firmware, loadables and the selected FDT.
>>>
>>> Handle TOC0 SPL output as well by adding the required filename and
>>> mkimage wrapping so the generated sunxi image remains verifiable.
>>>
>>
>> I sympathize with the effort as I'd like something similar on Rockchip
>> but I don't think this is right.
>>
>>> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
>>> ---
>>>    arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++++--
>>>    1 file changed, 64 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-boot.dtsi
>>> index e1a9a7f5d4c..313fcad3922 100644
>>> --- a/arch/arm/dts/sunxi-u-boot.dtsi
>>> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
>>> @@ -27,6 +27,38 @@
>>>    #endif
>>>
>>>    &binman {
>>> +#ifdef CONFIG_SPL_FIT_SIGNATURE
>>> +     spl {
>>> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
>>> +             filename = "spl/u-boot-spl.bin";
>>> +#else
>>> +             filename = "spl/sunxi-spl.bin";
>>> +#endif
>>> +
>>> +             u-boot-spl-nodtb {
>>> +             };
>>> +
>>
>> You're missing
>>
>> #if !IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)
>>                           u-boot-spl-bss-pad {
>>                           };
>> #endif /* !CONFIG_SPL_SEPARATE_BSS */
>>
>> here.
>>
>>
>>> +             u-boot-spl-pubkey-dtb {
>>> +                     algo = "sha256,rsa2048";
>>> +                     required = "conf";
>>> +                     key-name-hint = "dev";
>>> +             };
>>
>> You're forcing the use of an RSA2048 key which is not recommended
>> nowadays anymore as far as I know. RSA4096 is "better" when using RSA.
>>
>> This also forces the user to have a dev.crt certificate to be able to
>> build the image. It's not a secret or sensitive info so I guess that's fine.
>>
>>> +     };
>>> +
>>> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
>>> +     image {
>>> +             filename = "spl/sunxi-spl.bin";
>>> +
>>> +             mkimage {
>>> +                     args = "-a 0x20060 -T sunxi_toc0";
>>> +                     data-to-imagename;
>>> +
>>> +                     u-boot-spl {
>>> +                     };
>>> +             };
>>> +     };
>>> +#endif
>>> +#endif
>>>        u-boot-sunxi-with-spl {
>>>                filename = "u-boot-sunxi-with-spl.bin";
>>>                pad-byte = <0xff>;
>>> @@ -45,6 +77,9 @@
>>>                        description = "Configuration to load U-Boot and firmware";
>>>                        #address-cells = <1>;
>>>                        fit,fdt-list = "of-list";
>>> +#ifdef CONFIG_SPL_FIT_SIGNATURE
>>> +                     fit,sign;
>>> +#endif
>>>
>>
>> This requires the user to sign as part of building U-Boot and therefore
>> have access to the private key. Some users may want to sign separately
>> from their U-Boot building step such that building can be done anywhere
>> but signing is only done on specific infrastructure.
> 
> I wonder if binman could help here, perhaps by providing an option
> (for CI) to skip signing if the file is missing?
> 

If fit,sign is there, we should sign and not give an option to silence 
fails. The fact we can have SPL_FIT_SIGNATURE enabled and not include 
the pubkey in the SPL DTB is already big enough of a footgun, we 
shouldn't add more 🙂

The thought I had a while ago was that we could simply have the whole 
setup without fit,sign property during typical build workflow and then 
sign with yet-unused info in the FIT Device Tree. Meaning the hash nodes 
are added, in images/confs/both, with the expected key-name-hint and 
all, but not signed (the pubkey can be inserted already if we have 
access to it, but maybe it's stored in an HSM also, not always easy to 
think about every possible scenario). So you generate an image with 
pubkey in SPL DTB, and unsigned FIT as u-boot.itb. Then have mkimage or 
binman run outside of the normal build workflow to sign required 
artifacts in u-boot.itb. All the info for that is hopefully still in the 
FIT Device Tree such that we can sign properly.

Cheers,
Quentin
