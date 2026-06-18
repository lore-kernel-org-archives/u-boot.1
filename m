Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC330CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B558056B;
	Thu, 18 Jun 2026 13:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="cxKQW2qR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B104E8460E; Thu, 18 Jun 2026 13:02:37 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD50280287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aquPf4DkJaSkHPeA3KtpNukJTUZ20WEDmOtjjP1YHlXMyF5s8UyEOLsajipQRB+tunLIOxs2ulOk8bR8ruAbcAkhyPe7n1c4mhYOf2DqtGLnN2sqH5XHIgrBDx6P3mg7llWs78m4y+TANrdpDsymkGv03zNON2VJZ3qL06GsKRN7q3M6FgNicog+//eM0orBeYrCcvTI83LW74puf6bLkjLgRVp+axKY97n1RfvQPDBzbJXi/VX76ccne5NDysyemg/C20Ha/wnh48A0tH6Bz+XHPx52yWgrjkNXVaAcCCJzxKsw1OwfTGLM8MEYKCHjlliKS9Tx5cgLk4XObPFDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjjMGWz00H0OG4IN9opAojd3WeORw6TGcb9gIx5Gte8=;
 b=zMh2CI30jHhzXsJao0YfqxSzfef/RJ4f4D2zsPpjJ+tFcSW2tRcLUaj3nJRXp0q6gT88RSuA4oTyRgiGRFYzBX6Acpuz5+yFah2tY9bPvBAlDQ/iEpxl1GhYeV0USZpQ4RGYNL7wVcnAcNeaoyBXSgY8yBwz89nULjHzAYUS60WyW9BWfPBzqsHTw4V4bl7b2fgUVlMFEergPGR4AdDZV/M8CytcIgm8J4iwjRwsF99gh0SA3xyFdRZpjeb31v63JUnf+nMOYY5AZ/Bw0O2LAOLLkK+X/Obee8AFJAD1mzizWz3f1Iq+pKfa7bpBTgXxn+XB8oyziLjNtGd9pjzzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjjMGWz00H0OG4IN9opAojd3WeORw6TGcb9gIx5Gte8=;
 b=cxKQW2qRAeuGO5MH8I5MjwZUdAlG/zJ0PqC/C7PRzfsyFruK5aaeeEEcxZC+t9L+v5NhgfUqH8Q6vHkmFGXF9T0qtdcMpjnWWuhuys9jOlXxdK0vY/DdhXVFKm6nDbl62SnZMET0Pcqo6TQl83t4BCxggB0K2cn6fQHX89ipBan39L1L+drZW+VhHJjMhVMWFm4ZFibMUhbjMB5nx7xHPq16J+E4pElkL/qkq6+CiVGp08qfsyIvKZkrMVd0Liewrcllm3zc1akBzrU2NAnRdozlf9tAeOGlYgUppwVN4cRYEilO9gL1480oRfOSGN/P9kuyJcUnVuuXW2oKf/45xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR0P264MB4970.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 11:02:31 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%3]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 11:02:31 +0000
Message-ID: <01441137-deb3-4322-b5b3-b27ebc63f351@softathome.com>
Date: Thu, 18 Jun 2026 13:02:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
To: Simon Glass <sjg@chromium.org>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-7-philippe.reynes@softathome.com>
 <CAFLszTjx=CJxjp-ji+n2MF2znfeN5zPQhTO1TnBhLE3J_WMRpw@mail.gmail.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <CAFLszTjx=CJxjp-ji+n2MF2znfeN5zPQhTO1TnBhLE3J_WMRpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0184.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::12) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR0P264MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 0432aecf-c34f-4ca4-1dc3-08decd2917e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Dx8IEEFLFjrGtSiQipSabCPiapcE/9ixbfZemHahLbxqmn5iCVZFBh49KX/Qy0j6jkS99j+7S/cOpRIlEV20JTLsFBTpWUC0SeTOmtq1eT9J7RYriwT54KoIxMRBp+fhXE4ql51b+aFVOOZVT2Ar7T2hNoZk5wQvYGZArXvsLI7I5Qfnf0s8YGXtGe+2C+dllTQKOGXgxvEnPebMJQVb/qP4jhcFjaGKWck6ce7YWtiIBdMJBIdqhRtFHntRY7qr4L7Sbc0GlEOB7oXQ6kepISQfzQMtU+1lZL4IVgBkjBmdrYK4FXQ8JtJVw9LrVnWhSJahMC5MCdjaTlcWKcQOLoLbHgQqpmLpDwgbBNKlWWsIkWmw+8K4vgPV8SA4O9d3dQFJoAv7EwS/IuDFWvyWHQJV+x1O4AmU869tyHqi6Un58j+JeytEBGWjvQljcT4Vog5q0838veuG11rjDFgw8PLRluglsqYVBpHkCF3X/FsfMbbGsgKsaN5MONFgyay7ZGCMppmhQlLg9wyniWUmccAIK9jIeYgMbZQnFlA37KZfsO3ugTuyF2FYi4CpOGjZNu3/sBxFrXkrYjqNsIs/oKM1Ntj5B/xdMkEyAhxH5I1o7YfmcnvZcxlOcWr1F6c7EpeCpZXe+KPYLfUgDSpucsTYAZrXU0eNY/bt9Qbkr0Ym4HdMb/vo+iUVDq+AuLms
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnp3N3VIRUdTMkgyWmpkTmlIZmdOUVprbXFoYmZJanI1Mk1kaEZXOUlWUUln?=
 =?utf-8?B?Y1p5SDhQMVgzTWh4K3p6Q1V5bGV6NVZ1MWJieFNIc2o5VkJFcnpGQjNNM0pO?=
 =?utf-8?B?eHFxd3o3eHdYbCtwNE9vOTRrT3MvRDUzNk1ySWlpcW9DMjgvMjl6M2tRVmZi?=
 =?utf-8?B?TWsrQVBJaVpTZ0wyTTZOUmdxNG1XMzZSL0JNUmhWL2hzVlN0bHlJQnNva0ds?=
 =?utf-8?B?RGZFUWFhZnJKUGpTMngxSEQ2b0lNY01YK09vWDZ5NEx3L2h1TFN6WW5WYmxY?=
 =?utf-8?B?dzJRYURXSnFDejlWNUJFdlZpWjZjK21SQkQybEpEUlRreFFjd0VHMHpxVktM?=
 =?utf-8?B?WnREMWIyVmpHSElFTEZMb05lb3JPQWlkMHhtaVMrcDg4L0doY3BOdVJSa2Iw?=
 =?utf-8?B?WDlOY3F2NDZjdmhmQXhBNG1LRFdwLzJpMU9HL0gyamNyZWVIOW11cWN4UzBC?=
 =?utf-8?B?aW0yZEQ4dnUzcy9vUm90RXRXNDRXR0E5dEVzdC9XRkRVM29QTEhpTmFUNkFQ?=
 =?utf-8?B?OFNTQmVXSWd4RCt5OHlVb3NzN0FVNk0yRW15NElsbzZ4VDZsQTM5bTVuQ0pi?=
 =?utf-8?B?bWtFQ0c5dDhHVTR2UW8wMWdZaFhJY0NtbytKZHlzZGVSNGN2QytUVmhublZs?=
 =?utf-8?B?dkNQUU5vNytDWlkrY2grK0EwZTZsYmRUblBmanZFQVBQdkMycE5LQmlWU2E0?=
 =?utf-8?B?K2JrdjFZUjlQdkFFRDFNUVNVK1JpaUx3cmV3dUV2MHJKWktodENSRFZvYWFy?=
 =?utf-8?B?TWZudWFOLzVFN1hrcTBEdjZqZVZWQktiaDlJNldQOGtDdzdLbTc1bDBFcnF5?=
 =?utf-8?B?cXI5ZnZ3anR2ekMyR3FKd3QxNHltTENmUnA2Qys4RlVTb0pEYVBwSVZ1UGRz?=
 =?utf-8?B?akJiY0hKNmlmMnY3TnVrRmZEaXdwV2Y4WTBpNk1OOTFMRCtsZjJBV1VvWit6?=
 =?utf-8?B?bTBvMmUwU1R0Qy9KeUZOS3BtSzZtQUpsUUh3Z29RSm12c2JoQitwbk1mbjAv?=
 =?utf-8?B?UC9DS2NjU0tNL24rRHZOaHdYbGtOcGxXU0dtZlBEYjV5VnlqeDE2VkU2cUhN?=
 =?utf-8?B?bkc5ZFdWV0hOeDIzVEZLVHNzWWMvbVpNU09UQVRrazVqVWV5Ulg4TndoNnpF?=
 =?utf-8?B?cjlLazM1U1BiUnpvVjZLM0dKOThYNTA3UERVUmJyRUtHVktUUGo0eStLaHZC?=
 =?utf-8?B?bGpNY2dhRGpWTjlPKysybFlLdHhyOWdCa2ZRcXJMZE1KY1NkS05zQmhURERz?=
 =?utf-8?B?bG5rWENTMHZCTGVoT25vVEkzSlZkSU15OHJ1YTdRVFE0eHJ2WXQ1NFZsWWZ3?=
 =?utf-8?B?Mnk2UzRQRWtBWlFiLzJ6M1RTWSs4TkRuVmdqRExReVUrOFR3dk1BSGtBTW1X?=
 =?utf-8?B?enRsSmZkcEVWVk1KeG44UlR1MEYzMXU4QzNHbVJGcENIdXQ3em45Yk56clZh?=
 =?utf-8?B?OTBVVTVrbkFFeVVNWmZpaXdYbkdDZzJraGlwaG9XcWZuM3AydWFVWHQ2WUph?=
 =?utf-8?B?YndtUlVDOEhUQnA1SDJLbG03L3RGZkc1eWN3ZXFNTjB5VTlIZkJpcTdjdndv?=
 =?utf-8?B?MUVHV2FnTmNTZFgrR0Jld3hYYUZ0KzVvS0sxbjJDNTFCc3BIZXJjM0VIRjJz?=
 =?utf-8?B?bGY5cE9WTjRKaDF6TmEwSlp3VXdyZ2VCUERhQmVESkkzekpUNVlyT0ZzK2Vm?=
 =?utf-8?B?NUNtajZxSGx0MUtDRTBUYzdGR2NKL2x6VnF6SkZ1MHAzdUhBek1mcnlFWXM3?=
 =?utf-8?B?WGU5QUdzTjQ5cE1IVDY5VThoOHV2Z1dHVTJ1TWszbGgzRWhHOEdFd1lKbzZ1?=
 =?utf-8?B?R0pvdTJJS0NpTWg4WW91Q2hxK0kvcFBSNzRqcE9YelUvMnZrb1ArZzFrMGpu?=
 =?utf-8?B?NFBod0NDVHI0ZmpKS2FCQnBjV2JoWC90U3dJVVdUV3BISGNpZ08zcU1IRGpu?=
 =?utf-8?B?cnl6ZWRyeDlVK3ZIeFdrZGVDVXpvbm9ETnRpS3EzZlMxZWJsZmwvNkIwNnp4?=
 =?utf-8?B?RUtDb2lvaEl6TklLZGJWVVN5a1hiNHYwOWwvbitFS2pzU294V1hCN0UzaGNu?=
 =?utf-8?B?R25JaHM5d1ppT0FQWHhqWnpiTzlubGVwTWpzYnd2VzdtY2xzRmRiVnY0Y08w?=
 =?utf-8?B?NnNHNEFEdStZZk9meEgyYnU5M094ZzJrZjE4aHMrQmxNZmJXZmxKeEwvSXdC?=
 =?utf-8?B?R0JhRnNHZE96S0J0TmlYYUFzbmt0cDhXNUZiQktkVUZ6SnF4a2x4TEpLdTRp?=
 =?utf-8?B?T2lEaTRMeVdYbmhHanB2Q0txbjRnT0dLVVUwakFNTWZIeXpSRW43S2JoTmhq?=
 =?utf-8?B?Z2YxWFZLQTdHem9nVzdsQ1IvUVpsSlEwaTczOXhMVWcyRlQwYXBQenBOV0Qy?=
 =?utf-8?Q?2ZU9WNaak1oQB5Kk=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0432aecf-c34f-4ca4-1dc3-08decd2917e6
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 11:02:31.8194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGnzpCJ39vY6M1kD1x4uasbTYGIc8RQ9mMAuq3LyFCZtHWPpfXlH7n2Vj9VrDKq1rVJuHRhI3E1KVcaXZ5y8YKmenM0nXpQiitRMA40p2ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4970
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

Le 12/06/2026 à 20:32, Simon Glass a écrit :
> This Mail comes from Outside of SoftAtHome: Do not answer, click links or open attachments unless you recognize the sender and know the content is safe.
>
> Hi Philippe,
>
> On 2026-06-01T13:42:58, Philippe Reynes <philippe.reynes@softathome.com> wrote:
>> test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
>>
>> The test ecdsa was done when ecdsa was only supported by hardware.
>> So it wasn't possible to test ecdsa on sandbox, and there is a test
>> to check that ecdsa is not supported on sandbox.
>> Now, there is a software implementation of ecdsa. So we add a test
>> to verify that ecdsa_verify may be used on sandbox.
>>
>> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
>>
>> test/dm/ecdsa.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 97 insertions(+), 10 deletions(-)
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> with nits below

Thanks a lot for this feedback.
Do you prefer that I send a v9 or is this v8 acceptable please ?

Regards,
Philippe


>> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
>> @@ -3,36 +3,123 @@
>> +     ret = fdt_property(fdt, name, value, len);
>> +     if (ret)
>> +             goto out;
>> +
>> +out:
>> +     free(value);
>> +     return ret;
> The 'if (ret) goto out' jumps to the very next statement, so it does
> nothing - please drop it and fall through to the label. Also, since
> this is test code and all callers pass valid pointers, the NULL checks
> on fdt, name and data at the top of this helper are not really needed.
>
>> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
>> @@ -3,36 +3,123 @@
>> +     /* prepare the signature */
>> +     ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
>> +     ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));
> The 32 here hard-codes the size of r, while you already compute
> strlen(r) / 2 on the same line - please use that (or a named constant)
> for the offset, so the two cannot get out of sync.
>
>> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
>> @@ -3,36 +3,123 @@
>>        ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
>>        ut_assertnonnull(ucp);
>> -     ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
>> +     ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
> Can you drop ucp now?
>
> Also, the subject says 'clean this test' but the patch actually
> extends it to do a real verification against an RFC 6979 vector.
> Please can you reword it to describe that, and use 'test: dm: ecdsa:'
> rather than 'ecdsa.c:' as the tag, matching the usual style?
>
> Regards,
> Simon
