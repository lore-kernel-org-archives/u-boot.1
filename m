Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ACECD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 12:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE00F84C5D;
	Fri,  8 May 2026 14:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s7q01dkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8528184C60; Fri,  8 May 2026 14:15:33 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD1584B1E
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 14:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNZ5d3TK+wUI+llG+4dQjVBQqTzVX2amu95eLRSsTJD1/iyO8Vy/cSBSFHcaxrJ4DpaKdjLGrxLHqGi3nhb/h0zn1VOHRK+yrsiL7NIH6t/qXRcoVVSLUeQ+Cswe73iHSGyrrYWwaVTokW41s+T45GNfHkYYbkoBx+Iy+G2PEipWz0FD7df7V4TgdbfXtYQw34NdTrhVst8D0t04CEmLuB9fc/11KGWMnI0IyvE+wtpXVjR+RZkYN06dfkpPw2ijCGZSS4WDPuBIUHwxnQeVccUlgvsKa2xr0mJXI99EfZ22ODkV1/84+QY5dllG1R1e4A/+i30X4JunuNkEM0s5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyElMm5vKFyDvFkpUB3WXwHEnrvLAVU4ZqO3gufs8yc=;
 b=Dr/po9VyV4XPFQ3NlmVnKs3Aa3C62OFyMSwEAHo9z11Okz/I/Zo361rYYc6GtHIvcYTdr1Qkd6+DCLs5PVcKKrTO3wEEJLVdYqMqcNryVEAZHjJYbMtzG2nsJNC9zgHF70EVjnjYUZIw6eTs1HP928vwXVgnho3m9Kph7v7oEaaGnox17m2xglnhqk209sgIqcnrEQCDTL1/sXdzCV2M65Seww41WwEnhgywaZQhDImHRJJGyzHlueKuuA3ST2qB7+apQxWMxeNDe4FRAZdqDACE8QZBNnEAnse707QJLdwgkRaSRxxoDITIshF4vaB4r0SraAOim/l2aPw8nwMKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyElMm5vKFyDvFkpUB3WXwHEnrvLAVU4ZqO3gufs8yc=;
 b=s7q01dkWyaf9CLOw77sNwH6uhZDZfRpS9/5gMlb4bJuRolEyYbuqoOlDu/qj6nVKtYtXbSFutEUy5/pIb4mK/WF4nBu2WuNupUXcii8Ig+63RW/q1ayJ9wUZQ9X9cFgsI59jByIxBzntafk39Y33GluOxNcR9lRvC7NjKB/mQp2BThr9X/3Oo44QDno6Kl5uO3QrX/rlG2tLkJI967gL496veZPtPvz3A8NbcJQMnNAqGCtUjJtk9I4cXW6A+hDu/oT8qbPNATAljft0G+5PaY9dEFEWnh58s7CNCVCct/jkYcRKrPzuvidjMx+klDz7vPjNbgbe2sTFXEPMsFPSgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6545.namprd03.prod.outlook.com (2603:10b6:806:1c4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 12:15:23 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 12:15:23 +0000
Message-ID: <ad7da714-020f-4cca-b320-db47d95c100d@altera.com>
Date: Fri, 8 May 2026 20:15:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: agilex5_emmc: Remove kernel node from binman
 for non-VAB flow
To: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260505015712.4266-1-alif.zakuan.yuslaimi@altera.com>
 <b3638642-cfa7-4d70-b646-c2841260b4d3@cherry.de>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <b3638642-cfa7-4d70-b646-c2841260b4d3@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA1PR03MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1375e6-24dd-4e58-a6ed-08deacfb7a23
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: O85osfDFZWGojEeEZ92cEHzBr0+R0AHOtPxVMRCN4KxZIvPoNWRQofr3Mm5khxNf8WZtDoMmLI0OdZT+73QCeYHD/y3iwjV5hr/17+hy9CPMtp5DAgbJtlgr3m2Ikh4b0yD0Pn4QL75OkA2zkvbiW7jtvfE+DPfV3erpeKyz5khQ9TuCs8fF6qyYtTN+MkV5yA0wm1tk2kzWIIYsKREfO4LkGJU6Y5y33qlDuyfbhU8GNIPjRGtqp4UTze2VZxhCM39+1n8RIwluOIAonzYNAEDnPn3sgqvvONF/rkSWRx/uRCoFMp+c0fHFu458Qb+QumgftPvH/UvoWPywkMzBI7fukTo9bcC7VoQFQTc36kqF6GZb/Ek+QGobuca16lSK+rqNYDnkABSeUtyuIezRbe0mmKJvbVyXJWzutMit3n/Np6rROv1ByAu48pAHljls7CAsBzZMyLGvIUD5i/+oXAymkd0tq+VLEsiRFQk3cUTzGd/1kg/5Scd/zA2vowSdUwIaShCdtb36vpQ7HQNA1bODrSif/UtML8nRo9Ya+R2S5rLg6P8IRiZdkC93k9lZ5nEQdqGG9LY/IloMoJ4WGPbdZR/tbAPOAmpRm15JTO2ofx/+5ZteJPmew19xOPx7akvv8/12mpQLvFlrbV6IBd2RI41sLecnqdENjshRYxD1XYGifN3IZs1lzhHGsAwU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czh4OWtncTIrRWNQczNncUZNdFJEUWlCazdpUjlJc1hoL3FWUno4RUdGTEJl?=
 =?utf-8?B?cTl4ZE8vRDlucExCVTg3Nk1RRllYVmw3Q2dmS3puSlMzZktTNFphVThkVEZk?=
 =?utf-8?B?eUQyOWtQajU0YWxHcEVPQ1ptYlBqT2tLTjZid3lyTGVaMzd6N0grSEpONUpp?=
 =?utf-8?B?VkdGVFNNQjVTWGtrdCtaNERGaFpacEx3NHRQbWpHcld2RWxIOEdwbEc5Y2RS?=
 =?utf-8?B?MStiVTUwZmRFbVBSWGQwY1ZtcEkzSFJsQ01rbVBRbHdrbGtqUFlVT3UxRG5L?=
 =?utf-8?B?U0Q0Y1ZYUFJHT21Vd3ZpV0gvbDB1VWhWa1Evb3kyVVVGUWl3M2NUUjhldEU0?=
 =?utf-8?B?YkJVcFAyeWRMWkVhS2swaUg0TThFdGtDVFE5Tmt6M3Z6YjJ4T2VwSGdEbXhm?=
 =?utf-8?B?OFpYYmNzRzFwNVhIV1Z0MVZuRjBINjZaY1lEM2F1cG13TEt5R1V4eGFybHFo?=
 =?utf-8?B?dTlobktmTkZnRlZsK2laMWgvNDRWNHYwVHB5MXVGdnJ2dHN2UXhpN29WbU5Z?=
 =?utf-8?B?YVVBNVZFMEZPdFdIclBFSGVqOFUySVFqRlFtc3kxdmxNZzkrRzY4MDU4SFNM?=
 =?utf-8?B?OGJuSnBUeTIwbjhnSU11bUROb2hrNDVURU56K1NZcFQ2YUhYd1JIVEY0aGRJ?=
 =?utf-8?B?WHZkM1ZwMkM2MzdzWUw5WG5HYUZHU0lROWdCNGx3b3pVbk5JdEpScndWZko2?=
 =?utf-8?B?dFNEcWU4WW8xempZaWJBUU5BYlNhSjFISC94UkxjNkNSZ2lnWTRzVnVGa2Zv?=
 =?utf-8?B?MzhkWDhmc05WdGw2SXJNZjFOaElKQXlWay9Mdm1kRXlSWTdvWVQyOTFBVnFV?=
 =?utf-8?B?SUtlSU9YZHVUYUZBQ3FWb2hqbVE0b2V4VkM0S2dZWmNNbTlHM0NGdnFYcmsv?=
 =?utf-8?B?Y1JrV25wZXhLbFB3NmozTnk0N0tab3l1SEJxUVpFV0VJeGJmQUF2K1FLM3Yw?=
 =?utf-8?B?SCtrSTg4dDVZRXRKemp4U1dBZ0hoK3NSUWF5L1MwYjR5S0xIbFdhc1BhQlpl?=
 =?utf-8?B?ekJnWC9ucGdOcUUwZEt2WE1KeWxjaUhTSTAzZlVKOGdWQWlaMDZrc1VIbWk1?=
 =?utf-8?B?V0RyQ2NvNmR0NFY3elNGRUQ1NVNHcUlSL0RDTm5ndVYycmZhcURGVmJZU2Z3?=
 =?utf-8?B?UEdIVS9CRC9idHRCRTBTOVFuSXV0N3NGcGFlUXdPTmJhS3hEbkxmY1hNdFdw?=
 =?utf-8?B?VWtYTmtwVzJzT081dnhpNCttQnV2M0pLNUJiSGRHb0tSYk5MRUJkc3NrOFRZ?=
 =?utf-8?B?VWhudlNySEhwQXFYZnRSK0UzRmd0cHR0d09tZ2gyS0FoeSsyNUxOS2UyenZG?=
 =?utf-8?B?S1BZSVA3ZlVabndaUnVNay9uNk5KZDdHU0RBUlhZZ0JReDJaZFJzNCtjVVU0?=
 =?utf-8?B?d1FIU2czTXEzeXBTMk1BVTFrMmZhaWlXUHM4dnNGakZYVkJ3RFpPTkVkMGlB?=
 =?utf-8?B?NC9Cb2Q5Uno5VXh2R2FMcm8xTnhoeFBZM05FYUIwTXBhNmd2ckYwQktGYW5R?=
 =?utf-8?B?WU8wWTNPRmxiTmN5N2hGeEkzRW1sSDBLaXNZVnYwUThLSE5VZnUxWC9iSlF6?=
 =?utf-8?B?c09kaFAzZitFcm5ZcVhRMlNRLzdLTFN6Z081V3NHYm1QTHpybVdiZE9Ia3ho?=
 =?utf-8?B?MkJ1S2VIV2hzM2xpK0NMcjJOcFdpTDUrVVU3b2FLOWNQdjZNRHFESzRYeGFZ?=
 =?utf-8?B?bGZ2ZnFDVzRWcStOYUFnTjZ0MzM1VFJHdVlWNmpRZUM0NDYxSlU4OEpxeXZa?=
 =?utf-8?B?eUcyZzNydzFqRnViZGw2SlJFWVZTblBtamtIbXF5ODNpM0pzSXJXZHlWeEdW?=
 =?utf-8?B?RS9MNjdxTzlPNm15OHgvcDk1anZiQmZuMElJbDlENFZsOHMyeEVmY0cvUGVt?=
 =?utf-8?B?QlJjOUYvUy84RzBCWFQxVUhQNnF2UUU0YzAwKzhWWTRzTURqelAySXBFc24z?=
 =?utf-8?B?L1RZTWhQaWRVWlZjTEpwUTdneXB4T3Vxcmg0ajVWRVNLTm5teERKb1hLR04x?=
 =?utf-8?B?UFpZSHpqRXhSallYMUp6aVNPRi9nK2xneHJrZU5YNU9udWcrTzMveFpSVFEw?=
 =?utf-8?B?VUphN2RLRHZCaDdUMGJxT3VYMEplQ3JCK05ZOE02Qit3UjdoR1d2eEc0SkRt?=
 =?utf-8?B?bmZPRmtzd2tPREo3SHJNWVBzUjJPTVJKdkxleEw4bG5veFVuM21PN1VHK25H?=
 =?utf-8?B?cmdpUVdHM2Z2c3BaTmw1OUZxYnJPMnB2elpzNHZwREdWcVNkVEZoaFRrK2RC?=
 =?utf-8?B?M3pxNGM2T1B1UVByVVVLUHArdDNWMXpNdkYyZnZVdXZrSGRjVWNaV3NoK3Zx?=
 =?utf-8?B?ZXhuUElFL0FGQWxKMTlkblZMOW0rM3Nuem8xK0hJRzFTTVFOa1JTeFpkMWNY?=
 =?utf-8?Q?ffbaToQslnNysfKaRa2LZxQKfJmgUIC2+vt4i?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1375e6-24dd-4e58-a6ed-08deacfb7a23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 12:15:22.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXMZlYD7djzjqJ6UYmmkYRG4HHdya3KefXnMJLSuZ/rET0g7BfgkvYBedu2LGc5Bjyn1FWRxOqpGsA9XW3l6+OuqclZz6fd4ekyzroGJ6Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6545
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

Hi Quentin,

On 8/5/2026 12:24 am, Quentin Schulz wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Alif,
> 
> On 5/5/26 3:57 AM, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Binman will attempt to package kernel.itb during U-Boot build, expecting
>> Image and linux.dtb files that are not available in standard U-Boot-only
>> builds. This would cause build warnings with missing blob errors.
>>
>> Add conditional deletion of the kernel node from binman when FIT is enabled
>> CONFIG_SOCFPGA_SECURE_VAB_AUTH is not defined.
>>
> 
> Why is this specific to socfpga_agilex5_socdk_emmc?
> 
> Should we rather guard the definition of &binman/kernel with
> defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH) in
> arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi instead?
> 
> Also, please use CONFIG_IS_ENABLED/IS_ENABLED macros instead of defined()
> 
> Cheers,
> Quentin

We have been doing this for several of our devices in our downstream, 
and for arch/arm/dts/socfpga_agilex-u-boot.dtsi as well as 
arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi in which we have 
upstreamed recently.

Thank you for your suggestion. I will proceed with the next submission 
with guarding the "kernel" subnode under the binman node in 
arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi as well as cleaning up the 
mentioned Agilex U-Boot .dts files for v2.

Best regards,
Alif
