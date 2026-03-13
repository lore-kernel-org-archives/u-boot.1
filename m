Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB617106FD97
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 07:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 773978420D;
	Fri, 13 Mar 2026 08:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YzcRBe/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1B084214; Fri, 13 Mar 2026 08:21:31 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B9383952
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6J03gGRH2cDv7vCEaqUb2t6he2GX3/Gz+fZxdGi6MYfbPNSPrRCveZWo9RtgXTOTVZDaolxTowQrfo4bqZVC8YVvdEPQfjGONX+3bMA2DXcio3Q1Lp2UJz1x/7TqWP40/FrIZs9khozlw8OowElaUYSmznzcN2sb1R+1n9vxkhOrSsDa6WI7W8Vwt0pCDhNJhDn3MVg1w7YzOA0USCX5m207h4qQFE4eYs/nap9qu2I2EiojU8ap7ZcIDIo5a1SQ60SioGs1Nrnc9by3ZRUWjPEDASXAzxjTeVBbU++cip5VUCfRGFw2R8SJ8nTN8n41FElt6OmgsHv1EkHauw/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZepm/CIPRunE/Q4qvz3IwD1nQjLw6Kxu+aAyuel+w0=;
 b=jBuyAKWSPfN8JrjL3C1dcPAe6BiX+15fAQEUwdhCg8BiruA2ypSWYZ+1sraooZiFVIL2pOCj1bE2HUeekibG/8w/zbDnS7LvuJ5ndEJUpQbquad1yqpBTVmjDKAm6i8WhftpdHVQR2VocPh9mZLrDvkIVK6j/FABDLZs9Bzw4Oom4rPK0vTlPB5yMrXflJHJot39UeYk/aKFk4fYA4pDwoa/4EuMFlPo4JnMfzKG+5RSgvTtMcSsnYnml+Wj9VUqKPbQ6ARnQWvYl5JzKJ1axfQeJ3cu1gpZubk1CnH6pkrzav1r0Z2Hc0ZuAIQpbc1D8VaXwT31O9bmbJHgnlIoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZepm/CIPRunE/Q4qvz3IwD1nQjLw6Kxu+aAyuel+w0=;
 b=YzcRBe/w7BURCCh7y9glxHaTbcNNqlSpCfmdT58PWM2r/ANSFxr+/kvV4AGZstDkNf3aOccoLfUZNKG7wZH/5+in3Ct9TQTQmFM49nlhDjOU4QB/J+S3rNrVlJdLw2PgCNbcC6QiS2VcJSEDcKqKvBpZzResCeKHCW0bpAMYSWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Fri, 13 Mar
 2026 07:21:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 07:21:26 +0000
Message-ID: <69149980-e9f5-42e6-b21d-d8f9bede1dd8@amd.com>
Date: Fri, 13 Mar 2026 08:21:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: avoid buffer overrun in efi_var_restore()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
References: <20260311173033.10002-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLtu-WJsNgWA_GDECzo+VHP9jFjDLXo-1bR7AnbRSV3XQ@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWjLtu-WJsNgWA_GDECzo+VHP9jFjDLXo-1bR7AnbRSV3XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0005.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: 574abf1d-e687-481a-84ff-08de80d12334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|7053199007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u3zYbp4M2DicW0tOhTIgCOqGUXdR6ROqvwwcgpqrtZNwLNVuCgW8PTdPTT/EBB2bZy5yPJhLAMFKGulabl7btVX6f5ZyrPxyXhfhljHcbE0RSE1jAYtoMtJuC/V99RA8JRk7uadw6TEXbSDzBc8oko5u+VJ/lY6KyCynbcKs4pVJoSjk7EfNAKsQYkMufYD3ZBmD4AZTGriehc9/S78r4PWjrcWrppIL0jSRkA6X2UYtYGPK6LAgMH6E4VB/RQ/0H1Dn5uSb4kZZZtSRwFxT+4dZSWOzVTPu2tdBaw9W3E3WqAzbLQGoAS0OPfIq7CijfwmTSBrxyQ0L64TU2z1t4xfKEFQ4Iib4RFw7fBmIlo3nljCrOIe9g5AwmRqNJvM+QT+HR2KeFk41tRRnFT3jVanolXhMTXs5XbG0LP+1G/QpGDJ3J8gmKeG4JCoZbRIwQjqlzujPRDiA8dnVpdyzZToNW/rra+60KWJZnSpUVYyFLNS45l1+Tf6i4bNu0KTc0g0MD2vrgS2Ub+U07XBrQJFYcSk5g9zacRgvwt3URnsoi5T5wK6ZEelQD3RXIY10a1P93ioVkS7oVtZoeGOa/XK4NlMQPEwa5Ly8i3tQRR4mYh9us2IeVEwJZcGWgFljvmaB4bo0bxvGFqB80C7EAJckF47NavnnaNns3E400TkbcpEUS2hIzCRDHR3oDtpzQMe1FjNkkvMZ05CbDIMYBWQHbbENKlFMuYdbIXSH/DE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(7053199007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXBtMlVIb1k3VVU2UGpLVmtlT3FUMjZXUEdObVhFM3RaeVpLOVd1RmJ4RTZt?=
 =?utf-8?B?d2xaN0xYOGNteTNDZ3RXVmZuNWtpRXc0eWtleVN1SURVZ2pLNFZ4TzNtMitF?=
 =?utf-8?B?bGZuaTVFczlyUVVpR3pFYy9DOHE4MWhqREJEcVlyRnczV1R0aWpNSTZ6c0wy?=
 =?utf-8?B?dVp1bjU1bldFN2lOeUQxOE15eHZTNFdBb3pFRG92aE9LYWM2c0lkRXpURmo4?=
 =?utf-8?B?M0hFOXNvdUpJcXBlUEQwc0NzbnVjTGxRbGVQU3ppUzNOdGxhY1ZnNE5yQUlt?=
 =?utf-8?B?aGZ0Q1R2M2xjTmtTbXp4OU5rNzNnN2ZHUDhJMXFKVlNIVU1RTU5FcXk0NUNO?=
 =?utf-8?B?ZFVQNGU0VGZaT2RKNkVpbURxZHk5bVVpS0FzMGM4Rlk0aUlvU3JDa0l3eVhR?=
 =?utf-8?B?eUJOTTV6L2JtNEdTd0hIZ3c4YTAxUDdIWnNsNW4vV0NhVlZsQWFwYlI4QVIx?=
 =?utf-8?B?U2lWZlVGL2s3TldSeVE0blhoL3NJSXFVTVZtSWtSdmVLa292NEk5enIzdEpG?=
 =?utf-8?B?T1pIZ1p4cGo1N1lJR20wYXRTbzZWZnNBVXQzVys2UFFEeGNqTmNhbDVpU0p6?=
 =?utf-8?B?YmNoOS9LdjNUcTRyY1V4bVZtaitsRDlBSUtYTmN4T0VaM3BlOTRFaHBsSGhs?=
 =?utf-8?B?NWxOZXVFV1czV0Z2MjBEUTQ0OFUxQlYrbGZIRVVCZlUzTkN3dGYvQlpWdW8w?=
 =?utf-8?B?cVZXNWlVZHhicHlsUEpqSTY0UFJGK0dqb2g3aXorRmIxd2Y3VWgvalZCTnVu?=
 =?utf-8?B?czRLcFhOZjlielI4NlM0bTYrWGlObExvdXBzWVB3SmNBUDlCKzZNUjBkUCs0?=
 =?utf-8?B?Z3M4SnRDWEtqNUQybStIMG1zN0l5dUE2dzB6NWorZ0E1OFN5ME1KNnF1WVVD?=
 =?utf-8?B?RzFEK0pLUFFvSXFya2NJaDZjN2ZhM2ZRRHllVGtnYUtWTVR2eUkwMThZQkRn?=
 =?utf-8?B?d0tVRkNlWFJML1ZDSlNwTGVYY09YUWJvZTBWOHJmVXBXa1VvdEVJWUJscytZ?=
 =?utf-8?B?UzYyNWIxMmpGVSthRUl4eHc4QXJobTB5aFdGMVJYZzBQQXRZQUJnejNuY0FQ?=
 =?utf-8?B?OVd1WisyUkRiSWoxRFNtZDJ2aExmemhvVEpHTTFwdXNRbWM2eUpzK1ZHQzZP?=
 =?utf-8?B?L1JRaUozYk1ad3BFMng4UGw2THgxUUZTYUZvM0o5c2VieEZ0N1lZMnU5SEhk?=
 =?utf-8?B?eGtyVnBZVjg0aGRISUZEclVBVnRRQ2tOTlMvbldjYm9OM0JKSjlEWWJaa0g0?=
 =?utf-8?B?cnJRV0FZYXgzcDdnWVF1RzlGZ2JWSUNaelF4YldRQjVpV3NzdmVsTC9ZWFpZ?=
 =?utf-8?B?Tnoya1NNRTdGVmdLRjFaaEtVMlY0NDdySC9RSEk2cVM4byszZkFjQkVsbTd0?=
 =?utf-8?B?TVAxcitUZzIrdlorSGRoaEwvbUViOXdrTk9FNVA3YkV2ZUsxbHpiTy9RVXhC?=
 =?utf-8?B?eWk1eWZRTDBnaU5OZmZuaDRTdy9mK0Q2NlFiQlBaSjVheFcvR28zYW9Qc1l1?=
 =?utf-8?B?VlhnaFpTK1lGNFhHa1JMMkNtTEs4ajhjZStaK2cyZTJGNzBJM1MrdkcvVkN3?=
 =?utf-8?B?YThHSjNIWlJwT1YwVjFTREpYYXcwTnIveE5aa1ZaQjNEM0l6TmVhQ1Y3enNn?=
 =?utf-8?B?NHFpOEtsSDlkL0p2WWk5eFl1eUZVc2JTOGNJMVM2WDBiajVmWUtmV2N5a3hM?=
 =?utf-8?B?RW1kUnBuNXl3OFR1NjE4T1dhSVRva1ZsbytQZWFDZmE5b0I5SUU3OWx2VEtU?=
 =?utf-8?B?WjNyVTRaUE1pNEc2OFFtSHJEMWR2Yk5uNnM3aHYyOGcrRFFaRUUxbTMzRUtr?=
 =?utf-8?B?NnZycjAvRDdTM0F0UGJIbkZMN0xmRHd6ZmFGTlRWR0Rvd1VGMnd6SktBd0lQ?=
 =?utf-8?B?aThQcXpCM2tZaG5VTC92dUNBL0NMU1d3NjVaenFLZ1psMHlqOEd2MUYwWGh3?=
 =?utf-8?B?cVgzZElMc1Vtb0VZL2E2NDdhSE9CN0pQRnIxN0J2c2E0TC8yZmtzUGdqb0hE?=
 =?utf-8?B?Wk55MHZzeGVLSHVUZnBlQTd0WnFvK0xNM2dDdnFGY0xyejJwdXkxUUlPbk5T?=
 =?utf-8?B?K2k4TWhST3EvWWNvNklsOXhEZTJZTUMyN2VuMzNDNkdjZWw5b0dtYUhJcWdr?=
 =?utf-8?B?OFVsRzN5L1NXckZ1eEdrdE9sWUIybzVwZFIrV0dudmtnSnVrTExYeHNpN3Zj?=
 =?utf-8?B?OGVpRC9vSm5NM0JNenVwNGZNV0tjbDVLRDFhS21EK216cDJ4c2R3TmI3cmJm?=
 =?utf-8?B?Nk1GOFVFYytZQkk1NHZrL24vTHJxcGRXZHRFMU0zUjNFSWhyeXJwdUZ2Szl2?=
 =?utf-8?B?b2VVdUFaZStXR1JZSFdjUE8zazBOc29RUHl3UnFBdUhHeE9RMDJFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574abf1d-e687-481a-84ff-08de80d12334
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 07:21:26.1163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCrB7SJtw8gsUC6jvFJdHjg6D1cV00eqK2uAoz3+gJEykomZPd/TzPEz8iCK3Llq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819
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



On 3/13/26 08:14, Ilias Apalodimas wrote:
> On Wed, 11 Mar 2026 at 19:30, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The value of buf->length comes from outside U-Boot and may be incorrect.
>> We must avoid to overrun our internal buffer for excessive values.
>>
>> If buf->length is shorter than the variable file header, the variable
>> file is invalid.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
