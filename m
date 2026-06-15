Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8584DCD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 12:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E122C846A4;
	Mon, 15 Jun 2026 14:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="XpO7/WTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDCAA84105; Mon, 15 Jun 2026 14:58:19 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2D184105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CADsBWwWy1esNg7uMj60KAvxRgahLQtBtX+5BwtcUfMmg7YO48SffzT8a966Zu7z6HkgsrvFgEXKi7v2JUq0/pmdthVzPL/lTfy/Xa25YrFktIm3UisrJPavGvpI1u/Lyjk1ND4wNO6v8hH4S8KFcwDhWU6iHdHMWCsqf66IpjSdPgaCD5D8e9tILCKmQKvJoRNvTb6nEmyleQRKGfLQZ8/zYeXb1dNMFuActzNNvFeWCrQGfXN6p/PTtmKiUdPYmxOVb7binPBTDcivjctYBhZiw1NMPn7O6qu594IPyGBwUGVO26+jS9HEtibKeSPGXdi0nfPizQU018ZDopletw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BDRHSc6BKrlkXHRL5np0EYv9fpgAlEYSqtCwVmnz7s=;
 b=eBa0LZcz0Ha8c7GLQpktfuBdVXkLsPv19TmgrxbTvZOX3fCR7MdUxrwvSyOdORQT9ZKBzl1IO8R8fpGJKc/5XKggQSTGzLTKtZjLr0UU9Rd42RUvHadZpSuQoXN8JC1acPaoMhSaDD2FkbowlAFvlNjmVQRFZaQbNssn5Jm7S6ThoCxbSg6byI9yIXHuI0i4g7rQYAPuqZSptli4haRq4AlUoC0AriaauWWLo122oloWaojT0mu7Gqod1INamU1+Q1hqCo+tCowgS5NY1NBWEkRnqgQ7i6cBYvt8LyxiM13vSjcYRrKpn2ge9qASZ0Ya83eEzLiZmx8BW9kuGzgpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BDRHSc6BKrlkXHRL5np0EYv9fpgAlEYSqtCwVmnz7s=;
 b=XpO7/WTad6x9LUkdFa/EdUEgRNN2GjQCtNFdYyXE7fx8Guyy58l/oqmEBa1WOQNw27sn7m2XzUX5QOICaMvap6OiD6FZtDjsWI/QvGfdrO/RyhF5BA/cNLfpgN7mEjD44TGb0xLiedxCbggocBv6TKZfszmcU/kLiM0tBy4ZddJGASnj90W6uJN24GEiqtkhGF7lhgl1fXGA08iTdK/kHAs0fgSY4oiMLSc4/kE3hqTED41SGwbTLU09bLiMS8ts5vo+r2XgmXB4N3mWAFdgiYlH9N5kPlIG/hBFn49t0gVeOqBfUOKTRfMZPhydawfBLz/gyXRgZ1e2Wja6uevaoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:58:12 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:58:12 +0000
Content-Type: multipart/mixed; boundary="------------xqTAJSwuEDILIc12Fb4Lotlc"
Message-ID: <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
Date: Mon, 15 Jun 2026 14:58:11 +0200
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
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
X-ClientProxiedBy: DU2P251CA0007.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::9) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df6964c-cf5f-46ff-d407-08decaddc206
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|6049299003|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007|6133799003|55112099003|4053099003;
X-Microsoft-Antispam-Message-Info: 3mJgx0lgd3mFX9m1ovQHIttIzEOVFsRgih0C/rPKWBBQKPz3hEjplzJ2cQFrF+RG6o3goxUA/mhQOSdXC9HvFzAjKrSYo0o8NJMGa4k4BI44YuApDHr/9nDh1o4kVafn203r4l1ybB+Ja23uXjPNwrmeq0dEShx8eT82+T7vzPIe1BGANrs+NK0SlRE3e+dWf8gxkJ9I4VoQ+SGRsK1j7QABNOGvS8gH5lwaAi7m7cxEyRHMVsQ0OOv+mI3B8ef8CoLpxYcUQNDxDLiBVq1DEv7IKd0vJok7+E3AtMpVKQgA11ZPAhrqeC8CnbYYdgPZlJavfHRQA3XzjIsnIb/C/pi/OWNbr1ev22KBVL7xtbWPX4VjVLKXlrC97nVl5Vcz3RYbULX0lWS0vY9+Y+ixwe66DkVYD1wWxTosc4hyEGDIGXmyBA5PuFTehmfE7iIduWO7okr9aYw5h2EfnhwkHKJjWG800VcfcUNLFXguJ2jlTtS3/CXvh4dEYZGeYGoCc9MGU5bkXNGiMM1IMHe1vFxRlkm0UoTk9GJ0H85sjCxAgH/gK0qNzHTMpEx/6PxEFntZp6WVNxVlfXQEn3y1/5EV3RAQSkorbBQv8dblTmqS6P3pRNqJ78DZEGocO/fqPF+196yGG15gVSN0hDRqRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(6049299003)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007)(6133799003)(55112099003)(4053099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWN3N0JQd1NXbUt3SldrcjF6VmtIY1RjUnhkOTVCZlcyOVk3aU9CUWRpSDJ5?=
 =?utf-8?B?VTEydUc5OTVpcnI0S0J5Y1ZPZmNFdWEzUm9xL0dESmxYcGNNSzhTc2kyQXRN?=
 =?utf-8?B?eW1MeU5GVWxwWG1kU3VoUlpad2tuZVhaMkFYR2hoSi95MkhsV3VPL2Z3R1A4?=
 =?utf-8?B?ekFka1FjZU5WU1VVRE1oeXRwdjRHd0svRC9rMTZENXNTVVcwOUYzdHVvZ0pD?=
 =?utf-8?B?MnhiTzRQZWgrWElCbmU3T1ZwbGwvVitCREtBU25SelNsQ0RLZlpNYUJobTA0?=
 =?utf-8?B?dWwyUHFkVEZ2eGZxU0RGOStWc0pQWk41bFFGRS9UQzFzczFtOHAwSXdZZnFu?=
 =?utf-8?B?N0xyWlNsdmRNRUVoWHlzbzZqZ3ZwZDVZMWJNQkRtM09rZkJ6OGxFRGpTVlpP?=
 =?utf-8?B?RUg5b1g4TmkwVGdUUzBINmlDaHROY0RYSVY3ZzNhelA0ZERkdFRvdnVoUklR?=
 =?utf-8?B?OXN1OEszak04ek01V29jMmRwNzhkQ0cyVHpGZnZ1eVQ5YVlnYjd3a2owTDE1?=
 =?utf-8?B?TWhwVmovNDZJTmdVV1VhYkU2OFBCeCtPaDJGOXZIRHNFU3hVOW5oaGdzYjRN?=
 =?utf-8?B?Z3FvdEhnMGkra0h4Nm1uSU95SzhjcmJCL2FKSEFEbmduOFYyYnJEMkJoWm5n?=
 =?utf-8?B?NitESUJPWTFMODA2NUlkQ29aOFduemlaNVVPa1ZoY1d3QWdkdEE4OG50NkRh?=
 =?utf-8?B?eW1EcFF3cmFtZy9UU3NIQjRjak5lZWNlKzRZUHRFSEZBSDNNblE2dS9keFhv?=
 =?utf-8?B?UzZDV3h1ZU9wR0VKb3RON0Z2Mi90b2hMV3hsTjVuUHF2ZjM2UU91bFVrdThF?=
 =?utf-8?B?QkJlOGZuQ2RPNHp0eXBLQ0oydmJKTGNjMytsdUpsQ1Z1blcvMXNaZ0NwbnVZ?=
 =?utf-8?B?Mjl2b01ha0hZdDFKT1FReEVaNmdrTVJPYmtMUWg5dVp6OHViY2ExZ0JWaE5B?=
 =?utf-8?B?bXpOZGNuUWdMb1FsYUJLcU9jZ2g3eER5TWtOcWZxOFhZbmxMZDgyTjV4bUVG?=
 =?utf-8?B?c0pyM1c1M0gxT1ZBZW1zeXRGUDgxUnlXUWNRY2ZzYnpMRllZYmFpWnFFc0ho?=
 =?utf-8?B?ZnI3OXB1Um5OM25Pa3RTanovRzBXWHJlODZFQVU3TGl2cVhQT2JxRjZyb1RD?=
 =?utf-8?B?N0NWblRxY042Q3BBcy9vaFVFTjZSb2RoU29FQTRoODVIZFlUbEFhY05CcWNM?=
 =?utf-8?B?WW5VN2M4M1RiSVYxMk5FQVJ5NTZDZExXbHJjSzMzSkIzUFg4RC9neVlVY04v?=
 =?utf-8?B?RFhBZkhKTzVNUkRxTWxPRTBYcy9KdUFOWmFUdW9YckFVZ3V6N0Q2dXY1U0x2?=
 =?utf-8?B?dk9sMlV0cUZwNDl2VHJTWklhT2tOYkdMUEdzVzFEUlV2cERhbzVwZlRwQVpp?=
 =?utf-8?B?QXg2RnY2UXlKaEhrMHFjMkhtOTRhMGpxc3RxZEtHZkVSVzdPcnl0SC9qei9t?=
 =?utf-8?B?SW5pa3gzc3N1a1lHQk9JWGdWQm5OdVNiY1lzMmNsK2tVeTc4WkdxYkFHUE5X?=
 =?utf-8?B?MmFHM0czaHNrVlBZVklqRjcxTVlVOHFGSVhtREtUS1F3bytaTVJqRTRzZ21J?=
 =?utf-8?B?NU1VRGZLWmlYeEdUY2xpdEFCaUoxNVVCdlY3cFdMcDc1dnI4SEIrQ0xZbG1C?=
 =?utf-8?B?dUdpSG1LUVh1REhDQ0RZU2FKMldKUCtLSTg4VCtETHJiRDlXMUloaEgxcEpG?=
 =?utf-8?B?T1Y3N0RrQXBxS0NGd3BQanNmbFhkTWk1T0wzQzdjbTk4ZVFWelZpMThQa05Y?=
 =?utf-8?B?NmFRSndwdmpLaWF1d05mSE9SU2dpUTZ3cTRXbWl2NVdvVDkyNEc5N09Ydzlq?=
 =?utf-8?B?NkV6Yzg2Vyt2ZzkwQ2dpMkNONDVpd1pPM2QxMWFudHc5ZU5WV1JZTVU2R051?=
 =?utf-8?B?MzNNUjc2bXJ6MXQvVE5wUVBrUXErclNqblB1eXEzejMwT1pPOElETUNFYjA0?=
 =?utf-8?B?bzVPNmdsbGlaU2JjbDV1U1ltN2prR2NGdU1OSkpwcjRZdGxwSWJwd0psOXpS?=
 =?utf-8?B?NGVMdjFpNzZ1OEEwd3ZpdFFJRm0waU95TmZjOGh3R1ROcFd2eGtaaC9SS3pk?=
 =?utf-8?B?d2YveHVjeGkrV2xQbm1TS25zR0xGZERuWUpYeEpFdk1oWE5ZM1B6czNCMExN?=
 =?utf-8?B?b3NoLzU2ZkNpRXI1V2l4aTZ2TFM1clI2N29NTkMwdkZjVjEzelBUOUJKZFZp?=
 =?utf-8?B?UzdFbjVuRFdJUktXczgyQmNwTUoxQ0hIVXlXUEcvV3pzSDVtN1cyZnVoZlRQ?=
 =?utf-8?B?MlRuSmZRZmhuVG1JSFBTVWJNTXFva3poM0JPamx0OWZiTFI3cXZlWnB0WEtv?=
 =?utf-8?B?WGhwYTc5UDc1N2hJNXhzY0hUeUZpMVZNUzFIdWpxZkhuWFVuMUQ2K1ArNEdt?=
 =?utf-8?Q?Lez5fV+JK/61wEv0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df6964c-cf5f-46ff-d407-08decaddc206
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:58:12.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtU+sUHc2rv2sQo+6ZWuPRVIWJb+PURJLfG5nKZR2NJOQp+TcFXd0XSrVcMvnXkTsBQvn63/2Q+lBdlcMQMGVouxErNIB/b0Th0mJPUB5pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520
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

--------------xqTAJSwuEDILIc12Fb4Lotlc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 13:38, Ilias Apalodimas wrote:
> Hi Ludwig,
> 
> On Mon, 15 Jun 2026 at 13:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 6/11/26 11:57, Ilias Apalodimas wrote:
>>> [...]
>>> On Wed, 10 Jun 2026 at 13:52, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>> [...]
>>>>           if (IS_ENABLED(CONFIG_MEASURED_BOOT)) {
>>>> -               struct tcg2_event_log elog;
>>>>                   struct udevice *dev;
>>>>                   void *initrd_buf;
>>>>                   void *image_buf;
>>>>                   const char *s;
>>>>                   u32 rd_len;
>>>> -               bool ign;
>>>>
>>>> -               elog.log_size = 0;
>>>> -               ign = IS_ENABLED(CONFIG_MEASURE_IGNORE_LOG);
>>>> -               ret = tcg2_measurement_init(&dev, &elog, ign);
>>>> -               if (ret)
>>>> +               ret = tcg2_measurement_init(&dev, NULL);
>>>
>>> I'd like the eventlog to be initialized before calling this (look below).
>>
>> What if I removed the log parameter from those tcg2_* functions instead?
>> The event log belongs to the tpm device IMO, so should be initialized
>> with the device.
> 
> Measured boot EventLogs etc are primarily described by the TCG specs &
> EFI and we only have a specification for it there. The DT describes on
> how to pass it over to linux with sml-base etc.
> However, in the EFI case the Eventlog is allocated as ACPI memory. So
> you cannot allocate the EventLog a priori, until you figure out what
> method you are using to boot. We also have use cases people using it
> only for RNG, due to limited memory, so we can't just allocate it on
> the device bringup. And lastly... Some first stage bootloaders do not
> initialize the TPM & drivers. What they do is prepare an EventLog and
> expect U-Boot to replay it once the TPM is up and running. In that
> case we obviously need to preserve what we have instead of starting
> from scratch.

Ack, we are on the same page here.

> My main concern is that I *don't* want the EFI and non-EFI code to
> deviate. I have some patches that I am playing around for quite some
> time and rebased them last week for this reason [1]. If you think
> those help your use case or make your life easier feel free to include
> them.

Good idea and orthogonal to what I am doing I think. This duplication in 
EFI stressed my brain too but I can't care about EFI right now :-)

IIUC you are centering the change around calling 
tcg2_log_prepare_buffer() in efi_init_event_log(). What do you think 
about aiming for tcg2_measurement_init() as central starting point 
instead? That would allow to remove even more duplicated code.
It should be sufficient to have tcg2_measurement_init() accept an 
optional pointer to pre-allocated log buffer memory. Attached patch 
maybe explains the idea better (just as idea, won't compile).

>> I am not sure what the intention of the current api is tbh. The event
>> log basically documents when and how PCR registers were extended. We
>> have to build that log ourselves as the TPM doesn't do it for us. The
>> api weirdly allows to have partial local logs even though there's only
>> one set of PCR registers.
> 
> Where?

The elog parameters of tcg2_log_prepare_buffer() and tcg2_measure_data() 
are not related to the dev parameter. So it looks like the intention is 
to be able to call it on the same tpm but with different event logs.

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
--------------xqTAJSwuEDILIc12Fb4Lotlc
Content-Type: text/x-patch; charset=UTF-8;
 name="efi-use-tcg2_measurement_init.diff"
Content-Disposition: attachment; filename="efi-use-tcg2_measurement_init.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9lZmlfbG9hZGVyL2VmaV90Y2cyLmMgYi9saWIvZWZpX2xvYWRlci9l
ZmlfdGNnMi5jCmluZGV4IDE4NjBkYzUwMjM4Li43NjMxOTlhNmU4YSAxMDA2NDQKLS0tIGEvbGli
L2VmaV9sb2FkZXIvZWZpX3RjZzIuYworKysgYi9saWIvZWZpX2xvYWRlci9lZmlfdGNnMi5jCkBA
IC04ODIsNDUgKzg4MiwyNCBAQCBvdXQ6CiB9CiAKIC8qKgotICogZWZpX2FwcGVuZF9zY3J0bV92
ZXJzaW9uIC0gQXBwZW5kIGFuIFMtQ1JUTSBFVl9TX0NSVE1fVkVSU0lPTiBldmVudCBvbiB0aGUK
LSAqCQkJICAgICAgZXZlbnRsb2cgYW5kIGV4dGVuZCB0aGUgUENScwotICoKLSAqIEBkZXY6CVRQ
TSBkZXZpY2UKLSAqCi0gKiBAUmV0dXJuOglzdGF0dXMgY29kZQotICovCi1zdGF0aWMgZWZpX3N0
YXR1c190IGVmaV9hcHBlbmRfc2NydG1fdmVyc2lvbihzdHJ1Y3QgdWRldmljZSAqZGV2KQotewot
CWVmaV9zdGF0dXNfdCByZXQ7Ci0KLQlyZXQgPSBtZWFzdXJlX2V2ZW50KGRldiwgMCwgRVZfU19D
UlRNX1ZFUlNJT04sCi0JCQkgICAgc3RybGVuKHZlcnNpb25fc3RyaW5nKSArIDEsICh1OCAqKXZl
cnNpb25fc3RyaW5nKTsKLQotCXJldHVybiByZXQ7Ci19Ci0KLS8qKgotICogZWZpX2luaXRfZXZl
bnRfbG9nKCkgLSBpbml0aWFsaXplIGFuIGV2ZW50bG9nCisgKiBlZmlfaW5pdF90cG0oKSAtIGlu
aXRpYWxpemUgdHBtIGFuZCBldmVudGxvZwogICoKICAqIFJldHVybjoJCXN0YXR1cyBjb2RlCiAg
Ki8KLXN0YXRpYyBlZmlfc3RhdHVzX3QgZWZpX2luaXRfZXZlbnRfbG9nKHZvaWQpCitzdGF0aWMg
ZWZpX3N0YXR1c190IGVmaV9pbml0X3RwbSh2b2lkKQogewogCS8qCiAJICogdmVuZG9yX2luZm9f
c2l6ZSBpcyBjdXJyZW50bHkgc2V0IHRvIDAsIHdlIG5lZWQgdG8gY2hhbmdlIHRoZSBsZW5ndGgK
IAkgKiBhbmQgYWxsb2NhdGUgdGhlIGZsZXhpYmxlIGFycmF5IG1lbWJlciBpZiB0aGlzIGNoYW5n
ZXMKIAkgKi8KLQlzdHJ1Y3QgdGNnMl9ldmVudF9sb2cgZWxvZzsKIAlzdHJ1Y3QgdWRldmljZSAq
ZGV2OworCWNoYXIgKmJ1ZmZlcjsKIAllZmlfc3RhdHVzX3QgcmV0OwogCWludCByYzsKIAotCWlm
ICh0Y2cyX3BsYXRmb3JtX2dldF90cG0yKCZkZXYpKQotCQlyZXR1cm4gRUZJX0RFVklDRV9FUlJP
UjsKLQogCXJldCA9IGVmaV9hbGxvY2F0ZV9wb29sKEVGSV9CT09UX1NFUlZJQ0VTX0RBVEEsCiAJ
CQkJQ09ORklHX1RQTTJfRVZFTlRfTE9HX1NJWkUsCi0JCQkJKHZvaWQgKiopJmV2ZW50X2xvZy5i
dWZmZXIpOworCQkJCSh2b2lkICoqKSZidWZmZXIpOwogCWlmIChyZXQgIT0gRUZJX1NVQ0NFU1Mp
CiAJCXJldHVybiByZXQ7CiAKQEAgLTkyOCw0MiArOTA3LDE0IEBAIHN0YXRpYyBlZmlfc3RhdHVz
X3QgZWZpX2luaXRfZXZlbnRfbG9nKHZvaWQpCiAJICogaW5pdGlhbGl6ZSBsb2cgYXJlYSBhcyAw
eGZmIHNvIHRoZSBPUyBjYW4gZWFzaWx5IGZpZ3VyZSBvdXQgdGhlCiAJICogbGFzdCBsb2cgZW50
cnkKIAkgKi8KLQltZW1zZXQoZXZlbnRfbG9nLmJ1ZmZlciwgMHhmZiwgQ09ORklHX1RQTTJfRVZF
TlRfTE9HX1NJWkUpOwotCi0JLyoKLQkgKiBUaGUgbG9nIGhlYWRlciBpcyBkZWZpbmVkIHRvIGJl
IGluIFNIQTEgZXZlbnQgbG9nIGVudHJ5IGZvcm1hdC4KLQkgKiBTZXR1cCBldmVudCBoZWFkZXIK
LQkgKi8KLQlldmVudF9sb2cucG9zID0gMDsKLQlldmVudF9sb2cubGFzdF9ldmVudF9zaXplID0g
MDsKLQlldmVudF9sb2cuZ2V0X2V2ZW50X2NhbGxlZCA9IGZhbHNlOwotCWV2ZW50X2xvZy5lYnNf
Y2FsbGVkID0gZmFsc2U7Ci0JZXZlbnRfbG9nLnRydW5jYXRlZCA9IGZhbHNlOworCW1lbXNldChi
dWZmZXIsIDB4ZmYsIENPTkZJR19UUE0yX0VWRU5UX0xPR19TSVpFKTsKIAotCS8qCi0JICogQ2hl
Y2sgaWYgZWFybGllciBmaXJtd2FyZSBoYXZlIHBhc3NlZCBhbnkgZXZlbnRsb2cuIERpZmZlcmVu
dAotCSAqIHBsYXRmb3JtcyBjYW4gdXNlIGRpZmZlcmVudCB3YXlzIHRvIGRvIHNvLgotCSAqLwot
CWVsb2cubG9nID0gZXZlbnRfbG9nLmJ1ZmZlcjsKLQllbG9nLmxvZ19zaXplID0gQ09ORklHX1RQ
TTJfRVZFTlRfTE9HX1NJWkU7Ci0JcmMgPSB0Y2cyX2xvZ19wcmVwYXJlX2J1ZmZlcihkZXYsICZl
bG9nLCBmYWxzZSk7CisJcmMgPSB0Y2cyX21lYXN1cmVtZW50X2luaXQoJmRldiwgYnVmZmVyLCBD
T05GSUdfVFBNMl9FVkVOVF9MT0dfU0laRSk7CiAJaWYgKHJjKSB7CiAJCXJldCA9IChyYyA9PSAt
RU5PQlVGUykgPyBFRklfQlVGRkVSX1RPT19TTUFMTCA6IEVGSV9ERVZJQ0VfRVJST1I7CiAJCWdv
dG8gZnJlZV9wb29sOwogCX0KIAotCWV2ZW50X2xvZy5wb3MgPSBlbG9nLmxvZ19wb3NpdGlvbjsK
LQotCS8qCi0JICogQWRkIFNDUlRNIHZlcnNpb24gdG8gdGhlIGxvZyBpZiBwcmV2aW91cyBmaXJt
bXdhcmUKLQkgKiBkb2Vzbid0IHBhc3MgYW4gZXZlbnRsb2cuCi0JICovCi0JaWYgKCFlbG9nLmZv
dW5kKSB7Ci0JCXJldCA9IGVmaV9hcHBlbmRfc2NydG1fdmVyc2lvbihkZXYpOwotCQlpZiAocmV0
ICE9IEVGSV9TVUNDRVNTKQotCQkJZ290byBmcmVlX3Bvb2w7Ci0JfQotCiAJcmV0ID0gY3JlYXRl
X2ZpbmFsX2V2ZW50KCk7CiAJaWYgKHJldCAhPSBFRklfU1VDQ0VTUykKIAkJZ290byBmcmVlX3Bv
b2w7CkBAIC0xNTg3LDI0ICsxNTM4LDEwIEBAIG91dDoKIGVmaV9zdGF0dXNfdCBlZmlfdGNnMl9y
ZWdpc3Rlcih2b2lkKQogewogCWVmaV9zdGF0dXNfdCByZXQgPSBFRklfU1VDQ0VTUzsKLQlzdHJ1
Y3QgdWRldmljZSAqZGV2OwogCXN0cnVjdCBlZmlfZXZlbnQgKmV2ZW50OwogCXUzMiBlcnI7CiAK
LQlpZiAodGNnMl9wbGF0Zm9ybV9nZXRfdHBtMigmZGV2KSkgewotCQlsb2dfd2FybmluZygiTWlz
c2luZyBUUE12MiBkZXZpY2UgZm9yIEVGSV9UQ0dfUFJPVE9DT0xcbiIpOwotCQlyZXR1cm4gRUZJ
X1NVQ0NFU1M7Ci0JfQotCi0JLyogaW5pdGlhbGl6ZSB0aGUgVFBNIGFzIGVhcmx5IGFzIHBvc3Np
YmxlLiAqLwotCWVyciA9IHRwbV9hdXRvX3N0YXJ0KGRldik7Ci0JaWYgKGVycikgewotCQlyZXQg
PSBFRklfREVWSUNFX0VSUk9SOwotCQlsb2dfZXJyKCJUUE0gc3RhcnR1cCBmYWlsZWRcbiIpOwot
CQlnb3RvIGZhaWw7Ci0JfQotCi0JcmV0ID0gZWZpX2luaXRfZXZlbnRfbG9nKCk7CisJcmV0ID0g
ZWZpX2luaXRfdHBtKCk7CiAJaWYgKHJldCAhPSBFRklfU1VDQ0VTUykgewogCQl0Y2cyX3VuaW5p
dCgpOwogCQlnb3RvIGZhaWw7Cg==

--------------xqTAJSwuEDILIc12Fb4Lotlc--
