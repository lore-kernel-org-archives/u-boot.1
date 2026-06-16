Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B216CD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 11:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1C184119;
	Tue, 16 Jun 2026 13:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="eR2ozWJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2116F846A4; Tue, 16 Jun 2026 13:07:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAE884105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 13:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8vNYvVfhpesH2TPyRfeCDHbLTQon48F9PKzVQYZIZKk94vMtPaToIyXdWznb7G+nuFLB8rBs+WHhs1dMbxRT4uAH65IhYPpe7GHjPmurEjnll8S3Ipak/GBAJeojtGp/HA/5+RMatVuVlwzUv/VOgYhdCGHe7LyvfD+lU4v+OGfL01tTYI3UA9phGnkK8fCF34o1QcjvhDOSjFWz0mT2ZYyMy1F7ZyEg9qCbt+2jxynObDPFkyJ3gtSdbwdKyhGkEy/F42OsdiGP3eQUiI6bJrB9qmPPZUSnrDGW7JE374EUE9LhJ+OyZiW5udvtwDO7kBsTpunkEuRItVHd0B4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fae53J4GOUsy1FzXw9U6FAGvbMi5TO6ztrBJCaDkdx0=;
 b=wKzupK81Mir7g1QaR/4+8HnEeLQ65p7o9hoI4Bhv0Oxj1FntysZO9m0ArIX3Jsrc21a3uT58EeYdLLGCrsPDuoC58+OhYsnGFhx8Ut/vR6CE6mf+QfI6jhIrlPA9yjnE/nfJg9m1rST0I2Ww3hPykCvG2qfHhOJLuQe5wowWtgbGyphpPvl7u42DhGcbmdJ9Ufrd25BYBL9WPmERSexsogHR2p+re8/Ye/bgoMz2/Hv79YIgyHOprEE0Us7ONBPEUuHZZjMCEaCsxBdnmWbarMX/Nef5b9URvySyvfKBwKwF6GJABLlwqXRFH/vD5sa9ojeZFhYcNVZUOWdZuHH/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fae53J4GOUsy1FzXw9U6FAGvbMi5TO6ztrBJCaDkdx0=;
 b=eR2ozWJMDVu5GINRVmNlFtN5zdrHuG4XNue/nHmwoSl17kb2Uq92hYvtDTvE0osxV3x/9ocoSkB09soenfJB6mlV0bxZXuzZNitJmC99bOi0D3XUcBJH8bIcXZj+6SeTT8m/V9giGGJ/KgVGLPQGmD4W4qfJWMGfrmv5YCRg9ALD2vK8738d6Q/nt1aShph8NYYGzf5Wejweep4BtT30x8spCcLZoReJF1ktaOpt/Um9IoYugNeaR0bKEuG1kZu9QP5IwTMxkqQSCXY8RLcd1eYqenCpdKx19Y+L5MeZhrHsrNj/TYw1leXn1+wj8JvyYrBNLHnUZM5g0MRNaLHsKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:06:54 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 11:06:54 +0000
Message-ID: <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
Date: Tue, 16 Jun 2026 13:06:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0334.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::24) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|AS2PR10MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: e21aa18a-d7cd-4551-53c1-08decb97600a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|55112099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HdXvskTectHRpuo3jxhyA+vKV2BeVoOo9kc2qJXCUW0SIYztF/GGi8uQ5rHrYOsqcXy7R+VI3Yu2V8N2QAz4/QNspKmzgdE7if+QvaHMOZyXB7Fgq2WF74JW0dyCdTngFH8kuj7eVDkrP1L3S4Ddlvm0yZtciCqRszhUP9CVe8H7P08DjGb+89oCe4f4acwGd8xgtSW1ViS9DbWu//uu2nEDXGuqg1XMW8hV7e7QftLL3Af8i89TYos5Ah4qrebR2N/M1174WUapDh3btjk1JnYg5svu/Uwh2ycp4LhgoKL2GoYATNA+MG7FFg/kHqIvco3zLYNMIN33eAXksczeKCsJt48BKPNEhMZtH+vmQrMACxxnWEbSXZLOh7V4FPpYfvLGpnRu5lhw08EdgLa7x0qXFTjVSYZ/oy1G76DhiOlDLO05pUgAz26Gh1x9UXLqjxemCkkRjFjlPmUqL9McRrPXvxLXCd2oBHHylVwWRREeBXj7GnIJaH3tqiw1B7OEI0iAYFwnDEhtCGRfyHVS/Sw2E1ftS6LmA248Cd2mVnicbESq+L7Vt9SMJGpAgs+8Dgglrpg12sext13VHK/6URxUFMVbeFG/tkOw1QuWmXpuiPQKUhaOZwTKpS3JkgcNdHO3gD9qubnFHsla54TCjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(55112099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjQySk5wYWlYd0ZvQWJJYjVJZjFvZ0g4c00yK1cvY1Uxd3cweFlCRWRDUWJy?=
 =?utf-8?B?cGlXMlQ5aEdibEtrc0orY1FDQTlWdGN5Z05mNlVxOXFsYnQwT09wVGJzSTZs?=
 =?utf-8?B?TzA1eEhnWSsxT3pXam1IeG9iZ2dOdy9OU0lrb3hjS1JtU2F1K3ZZbFc3VWIz?=
 =?utf-8?B?NjBXdWxSamE2eGxWcmNKd1IvZmlsNWkrQjFJYWYwWDVoVkpqK1dmdTM3SHZT?=
 =?utf-8?B?ZEJ0UWthcGUxN3IzMW44R0lQZjIxbXhoMXJvMTZpbFp1LzFRUEF1bDhvRHZT?=
 =?utf-8?B?T29wWFM1Y0FkTHRabEVHb3pxTmpCTjd3Q3hXdkVUbFEySHc1Z1B4S29XWWg4?=
 =?utf-8?B?TDV4MlNkM1l3SWxZczBMOXlDNVYrbTVUeDJVYWYvWHRZWjA0dWtyR2pqRVNj?=
 =?utf-8?B?SUlWdXg4RG5sOURjUit4SGt0ZzBVUW82RFZyQk4vZWUremhuRWpVT1JXV0k3?=
 =?utf-8?B?YVdXcWVlZUc0UGw5MTVxUm1pOFMzTXlVRjgwNVhzN1BTTlRNTythRlE1QUhB?=
 =?utf-8?B?dEM4MHBkdkRBQnczMUh1RlNkb25SWkt3WWZNb2ZXWGtmbDE4VmpuMXI2YlNp?=
 =?utf-8?B?cWRBSjVqakdBR09FTnY2c1h6M2ZNSFVBNVk4bEcwKy96YWUrWkFZMkxnYzli?=
 =?utf-8?B?VHoxNldrdDhBSmp6ejN1bHFWYlRhSGpUNW0rMElxS2FOYVhOUnBjNEtBK21I?=
 =?utf-8?B?N3k5dHFjQkY2aU13Rm4raE41RXdFZ09JckZLdCtYL0ZHTmRVazJlVkxvVzBo?=
 =?utf-8?B?dTVZY01ERnBlZWJHL1p2QmJYSWNwNkJLd2dlanc4ZUJ6aUlpTGVrNzhONUJ3?=
 =?utf-8?B?a2dHL3RjS1RNTHVrNVRLMzY1V3hWTW1GQmtiTE1ZNHNFTlVzQmxHUnlWYlF3?=
 =?utf-8?B?b0NHU1MvYmt6a3dYaU9xOS9JY3Q2Q0lQV1hnQzR2aUhCeGZvTkkwNzBDemY0?=
 =?utf-8?B?LzE2cHQ3MGJtTFB3UmV5djVOZlhZNEI2Vnk1ZVZxVXRkMW9DTXdPVm5VK3pF?=
 =?utf-8?B?VGgrb3duZVdwakpPK2hqK01MRlh0OTBheXQ2c3MxclQ4dmhvTmRzN3hLT1lW?=
 =?utf-8?B?OStSbFhmbDhWd0pHN2U3QllMdlN2Ui9TdlQxdXplZzVmdGtkTjFCV05tcVZU?=
 =?utf-8?B?R21FSGFTUWhvUHkvVmRqSm15SEovWitwSy81dUxXR0Z0U3haSVZDZTh6OFNt?=
 =?utf-8?B?VjVnbG9QcjdMRlRZWkEveG1hK2tiU0twRzVPSHhGTXdySXd1RXZpSDVRcUgx?=
 =?utf-8?B?aTRSU2lrQnZXckdjekNLOXpCSThCNWZOVkZmNzdDVlJROEpRU3ZVU3Z2cll3?=
 =?utf-8?B?QS91ajBreUdlVm9yQTVUTEg0cm5ndThNeTR5SWZFSHlDT3V0WWJNZWlKVU9Y?=
 =?utf-8?B?eDVabEJwMnlOTjJjZk9zdnc2Yk9DSVdhTzVuK2NGcGdubnpXOVhPT1IwS3pn?=
 =?utf-8?B?N3JqQ1dYdnJmRTRZSFJCUks0T0VaM2FFWHRXSFVIdklsMHpWaHZLK0lXQ1lz?=
 =?utf-8?B?bGpQY1U1U0JsM0svcWs5QU1JMGJOZ3FnOFpZNkdweDZQN1ZkNmFVTTBCKzhi?=
 =?utf-8?B?cExIdFpVOVVZbHo0NHdXS05tSEVHdU5IcmM3T3RRcGtQd1ZwaDZ5WGZqUVRK?=
 =?utf-8?B?aFhPcHZ3NHN5V09jQklVTG85Tk41ODdVa0hESzdBQTBPOExScktOdHRJanpK?=
 =?utf-8?B?ZzVaRElYVEVYUERIczhrdFB2ei9mbEFLdmN4Q05jQ2NvVTV2am9WckRvQ2pH?=
 =?utf-8?B?VUNweDdoZHFyTENiRFBHeVo1QmV3WWlXelhEeWloaGs2SCtIQUlUbklxUTg0?=
 =?utf-8?B?Z2g1ekxqWVY3TzZlWU1rRW4ybGdTL3RhL2d6SDBYMUJ4NWsvajF5MVBlaW5o?=
 =?utf-8?B?Q2EyMm13TG5iaUVXRE9VdlM2REd4c2JadlY1cWZIMlhXYlRHbUR4UzNiSCt3?=
 =?utf-8?B?dEhNTFFHSU1nK2VzUHV4QWJmWG1aWXNTanZSdXEwb0tLOEJVYTQrY0todjVx?=
 =?utf-8?B?N2hTMWkzZ1EyQUdCYkdKL2c1QXc3NUhkcHJoQ1RyNDN2MitGMGh6TUFGTmZT?=
 =?utf-8?B?VnRsdTNkQnYyTzVjajZGSkNFY3lRK3ROSlU2Qm1IcU1vVjlQYXd4R1Nad1Rl?=
 =?utf-8?B?b0ZXSnFnNUNTYmgvNG5PSGxmbmw5anhHcElLTFJoYWFpZkFTdktRM05mdTNh?=
 =?utf-8?B?NTkwWU5xeEZOQnJ1bXBReTV5ODdleDNtTHZwSmh4TldJditnZnVTbHQwcko1?=
 =?utf-8?B?aElmdm00cWNkdmY2ZkxRendMamk4dkR0K2J1ZkFXK0tudWhvclJXeEQ3V0dI?=
 =?utf-8?B?QmVOSnRuVEJETHRFQWtndkhCREprekwzRkMrSFNDSTU5c2FQZXFkTHBkT3R5?=
 =?utf-8?Q?azukWf4MCXaedXMk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21aa18a-d7cd-4551-53c1-08decb97600a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:06:54.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZL0ZnbFKazsFhUD6jZ5cBGfukeFZZhxKqIs/VxG/jUGQG0yc7XO3UL9Kk0MS5Z4jtvdB0wRnDu0iX04A5SSUCCkxcjmrpe/b0qyL/E3Q9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6711
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

On 6/16/26 12:32, Ilias Apalodimas wrote:
> On Tue, 16 Jun 2026 at 12:39, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 6/15/26 15:25, Ilias Apalodimas wrote:
>>> On Mon, 15 Jun 2026 at 16:09, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Ludwig,
>>>>
>>>> [...]
>>>>
>>>>>>>>
>>>>>>>> I'd like the eventlog to be initialized before calling this (look below).
>>>>>>>
>>>>>>> What if I removed the log parameter from those tcg2_* functions instead?
>>>>>>> The event log belongs to the tpm device IMO, so should be initialized
>>>>>>> with the device.
>>>>>>
>>>>>> Measured boot EventLogs etc are primarily described by the TCG specs &
>>>>>> EFI and we only have a specification for it there. The DT describes on
>>>>>> how to pass it over to linux with sml-base etc.
>>>>>> However, in the EFI case the Eventlog is allocated as ACPI memory. So
>>>>>> you cannot allocate the EventLog a priori, until you figure out what
>>>>>> method you are using to boot. We also have use cases people using it
>>>>>> only for RNG, due to limited memory, so we can't just allocate it on
>>>>>> the device bringup. And lastly... Some first stage bootloaders do not
>>>>>> initialize the TPM & drivers. What they do is prepare an EventLog and
>>>>>> expect U-Boot to replay it once the TPM is up and running. In that
>>>>>> case we obviously need to preserve what we have instead of starting
>>>>>> from scratch.
>>>>>
>>>>> Ack, we are on the same page here.
>>>>>
>>>>>> My main concern is that I *don't* want the EFI and non-EFI code to
>>>>>> deviate. I have some patches that I am playing around for quite some
>>>>>> time and rebased them last week for this reason [1]. If you think
>>>>>> those help your use case or make your life easier feel free to include
>>>>>> them.
>>>>>
>>>>> Good idea and orthogonal to what I am doing I think. This duplication in
>>>>> EFI stressed my brain too but I can't care about EFI right now :-)
>>>>
>>>> It is, but the deviation in EFI is pretty minimal atm.
>>>> - EFI calls tcg2_log_prepare_buffer instead of tcg2_measurement_init()
>>>> -- That's what my patches fix
>>>> - EFI has it's own version of tcg2_measure_event() -- That's easy to
>>>> fix as well,.
>>>>
>>>>>
>>>>> IIUC you are centering the change around calling
>>>>> tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think
>>>>> about aiming for tcg2_measurement_init() as central starting point
>>>>> instead?
>>>>> That would allow to remove even more duplicated code.
>>>>> It should be sufficient to have tcg2_measurement_init() accept an
>>>>> optional pointer to pre-allocated log buffer memory. Attached patch
>>>>> maybe explains the idea better (just as idea, won't compile).
>>>>
>>>> I agree. In fact I mistyped the functions names on my previous
>>>> email.... I really meant tcg2_measurement_init(). The patchset I
>>>> pointed you to already converts tcg2_log_prepare_buffer() to static.
>>>
>>> Replying to myself here, but.. In order to do that you do need the
>>> unification patches. tcg2_measurement_init() will need to allocate the
>>> appropriate buffer depending on EFI or not.
>>
>> So this is how it would look like with your patches on top:
>> [...]
>>
>> IMO the untangle patch is not needed. Does that look sensible?
> 
> You can skip the untangle patch the way you've changed efi_tcg2.c, that's fine.
> 
> However, there's a few issues I tested for
> - A u32 err; that's not needed in EFI anymore
> - tcg2_measurement_init() calls tcg2_log_prepare_buffer, with NULL. I
> suspect you meant to call with elog, since the EFI booting is now
> broken and the kernel complains about an incomplete EventLog

Oops. Yes, that was a mistake.

> [...] But
> since we've gone through that effort, wouldn't it make more sense to
> have tcg2_measurement_init() set the priv->log if the pointer is valid
> and provided?

Yes, the series paves the way for further refactoring :-) The efi path 
shouldn't have the 'static struct tcg2_event_log event_log' anymore IMO. 
Should be sufficient to hand the allocated buffer to 
tcg2_measurement_init() and access the log structure in functions that 
need it though 'dev'. Refactoring (and testing) the EFI path is out of 
scope for me at the moment though.

Anyway, do you want me to submit your two patches as part of the series 
or you want to follow up yourself?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
