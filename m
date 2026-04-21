Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99004F327D0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D0F843C0;
	Tue, 21 Apr 2026 11:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nifJgvoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D728843D0; Tue, 21 Apr 2026 11:52:51 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D99C8439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBwfzYox01H1NeJmSV4tLie1OXGVblI0nOmFrXBdzL8myfqbcOfoquUCF91XoAYcdpJH/KKzt7OYWMIIgbxIoi1QqJdPjvZymSbr/BelM0e923meeuKRIILv6ZbnDQn4IZYiwtS+RCA+Ce7UgnuC5ftvBsGk4T+AHtF/TJOww3an/7tgWVu3eqJJW0yOwiuvT6AtXmKXw+o9PJFfT6x07Qv8sHtVLmpRHXzshtvBfeAEj1pIopGv349G8Rc81Pr2bk1Mt2qqpT//RB/IC+CCL3zP2b8rTjkLKQ/v3Wa4b6Wcp59CCPiqYUEVIHP6HfSU4RZW3bI4dckanSxTqVOt9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLN/e9976zfiV6vWKFco1PWeY+zH6meJf4aTreOU6no=;
 b=nVyVrxO/uvlEYeLrhurWtcoSqp7j5K58ODgbCHjr8uyzMydQ53Dr9xnll8CyWCLtfwlbX+60U+C8IDj4ER1vzjQfcoAFUZGadTDFUjqM7fqyLQgztqxTcAU5JXQy3addrVcAwmrplliyQLNro9TeT1Fg8loPZdrs9JME6vLo4iia0lR64FvuhOb0NgDtdbNTe+MgeXqzb8dWEKtvdnIbiaTBcQKvTYUhsgFuvxi4YERYXOUzuP5xFD/y91bglm4S6K8FZNLoFIngVGd+eb8msbdKyEgAlJrMzIWLb8Y/OsC8drNRbLyX/x+ETsWepp5dTgIMT1hBU7aNqfz8FldJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLN/e9976zfiV6vWKFco1PWeY+zH6meJf4aTreOU6no=;
 b=nifJgvoXPtTQ4G3chJxMTDq3u+pfPsZJDBhoa1wmZbh5FEEbRTzDzHu8KXdKV1eBJOOV0lB2Vqx/KtuYS0TcOkCjJa9TdXoR46JG2qwdOqUiDWlHNiATHRstS57E8l2ZErA9p1MjOe3CPIQFSxJbq4j0+Ip0alIbh+a2Z8QDb7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB8316.eurprd04.prod.outlook.com (2603:10a6:10:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 09:52:44 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:52:44 +0000
Message-ID: <b01ce6c8-3d73-4c25-b8b5-5f1204265ff5@cherry.de>
Date: Tue, 21 Apr 2026 11:52:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
 <d31d5dd6-6d43-4e61-8963-6474197675ca@cherry.de> <aec1mOCpyTFnONCE@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aec1mOCpyTFnONCE@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::20) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 364c072b-cc9b-4406-9726-08de9f8bbc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: CzN1VQsWf9OCmpCDgdPOH58rtEWcx06HncGtDvwaAMhrOyehG6f5Kkdhpc9E4VP2QU0hQPmcFJAARMTepyB/6ZxHon52STVx+Cra9Wj1ovIpvnvFhTNtERNo7RVcefxig7+ebnN3PI8wQ7NZ70uPtaOp3F/ALFnuz8yjqGuHiJva7FzIytQasTBc/iKziHBCmH0Fnj/qFUrfWGMD4Kye7iKAMUgvLlH3FYzEACfVQ/iNgukiLXmfiYfaG4YYJrZ1LeFzBrb7A3iSP9H5nrM+yt8RGrX3wVmY3HXgzTkDxQj361ohhoSBYICWMzeEDW7kxca6GkPGMg15kV9fhzd9e+S1pkG5SXpBtFHMDNo76PWTxBBWGcRPoHPi9CSfwdQewkQMw35mX2v8f0E8ZrlAQ/2WKufHh5Bum4ALaW6rrNVsdbyIs9LCUJ94IqXiD5Yet9PLpXRrgDnD898newn+l+YkFcVaLxGPGWHOO7ifJRitTd4kEjJWRstLzfc06uHP9bBuA1iSGSCgSX2uOcLchh2Yww+rao257tWhW9B7qPI/8CP9Uk9KF4O5iAzU2A1p0bDBMM7EFhT3gtQ2cLSpn7uIg/HA+Fwq2I+cqMhXmZzUUGR5jslsjuEb58BEeIW8CT8kNW8ENr4Mu3TfiUF6jY7bBMPnuRezfcOv/2NvzJiO7sHrhiOn34UGTjNAbiXLRn/BjygMDbNYidJHFr7HkN2hg2kTlQg2Qc7v7zodRZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhWNlU3SkNadTFMaVRJM0NITm9YV3VhaDM4RDdleHJPT1BoaHFSbmpJRlJj?=
 =?utf-8?B?cytkdlE5VG1mdE5NQTVQVE1aLzB6c3dRclQ0SGViUm00SU5ETGtMZlN0bzJq?=
 =?utf-8?B?LzZjMUFET3BmckYxOTFmU0tPelc4SWFlc3F6bVd0N2JTSHhud3V3T2E0cWsv?=
 =?utf-8?B?YUJCSksxRnVQeFdEaW01ZnhhT1NxL0EzNURXK0YwL3JHV0tXbFN2cFNUcW1K?=
 =?utf-8?B?aDkrL2pySHdaZWlzcVl4cXltNEFXNldVWTdPQTBxUWFDdGQ4T1kxUjhRWDAv?=
 =?utf-8?B?ZjVZM0Y2QUhHcnNVNi9sWlFRTjdkaSs2RVNhL0NRUFFHUUcxRGY5MktCL1Y1?=
 =?utf-8?B?c3A0V3U3R3gwQXIvOVNZL2tjSVgvbGtLL3dVL2NtVlVZcU10VUQ3b1hpM0pu?=
 =?utf-8?B?UGEyelNjNkcwK3R5ZFVMU1VsK1d3SmJwM0dtdktXUzNpNFk4VWdvMHZLZFJ1?=
 =?utf-8?B?aUNuVnZMZUpENGdaZkR2YmJDazhnbFdQRmlYRFNQek1SQVZ6ZzhWMDBMNkxm?=
 =?utf-8?B?b0pJYkhhM2VObXZhWE1jU3djSTdBMGVXMnlVczlXT1lOYU1MZUkrdk5TVGsx?=
 =?utf-8?B?RUltZnVZZm01TlVSTDZPQUNubmVKVUZ2QlJXVUtYdGlONHVmVFU1Nk04cCtH?=
 =?utf-8?B?NElNY2EydEdtbzBPdHBWVjRTNytHTHR1UE0rZXJxK204aDZqVkpQV2lBM25m?=
 =?utf-8?B?WGhjU3Y1MXRHekVYTEd5S2ZRL0lSV1JLelZ6ZkRuWldMWEtybFAycnBjYWtP?=
 =?utf-8?B?K1FPcU9nd3N4bHkyaTQ3VmJhclJDeExCd1JOZUt5VjlDTDk1ZGp4Y2ptYUhh?=
 =?utf-8?B?RGMzWnRrZi9ucy90WWhxZWgrdjdwQXVpVkREZVZIdU1FOS9UaTAybXRDRW1a?=
 =?utf-8?B?UWlVazYxMEhaWHVaVGZSd2oyMnIveDVkdWJZSkVmWGFDNWZFR2F5ZU9Pb2RK?=
 =?utf-8?B?TklBT1oyZWZWTGtKeTUwWXJhYldpQUt4QWhoNmhpT1NoNVFwbWhPZ21Uc3Fx?=
 =?utf-8?B?Y25NU21GNFpqcEk3YUllemFWK096RTQwVlRPNVg4V1hoUk9UTm0zZENiRFRT?=
 =?utf-8?B?ZURjTkxHZVl0MFQ2K0trR0JyeFZQcEZKSXA2UUZncG5IV3kvYkgva2N5eFhB?=
 =?utf-8?B?ZWJNN3NGVnlBd0NTQXltSTdsWVM4MUU0VHhGSUNCTXpHTDlRYVVXajVZaGMx?=
 =?utf-8?B?OFM5aWJ3T2VZT3B5Nk9tY0tOaFEvTzZ1czJzZGlTZVZuMGFJUjY2eTFEZE9U?=
 =?utf-8?B?aFpzWEVucFYzUkYrTzlYNG9vR3p1RHBjblorYjhISUxQQTJueGNjcm0yYmJZ?=
 =?utf-8?B?aTJ0dEhjTlQzSm9Tekdja2Yxb0J1azV1dGcrajJtREFjdXUwdEdXTXRxY3Y2?=
 =?utf-8?B?N3FMb2FSZ09uUGtXZk12Rmk4U3JscWVTdGV1MjA4dzFFRXZRZ09FYmIrYm4z?=
 =?utf-8?B?aGp6alN0cVQ3QUpIQXNzOXBXZ1Y1RmZYKyt4RWFxNkFuY05DZTAvMFczSVZN?=
 =?utf-8?B?WFRSMzVmK1RxdGFRcHFaeCtvZ2JoZ1pyc29HZHBBQkRyTityUVdlVzMvOVMr?=
 =?utf-8?B?dFRLY1dDa2dZUVZzQU95Ym1RWjV1WTFXazNhdlh5TExZL1BDMVViNDJJOHM0?=
 =?utf-8?B?dnpzYlByakFaQkRoQVIrOTVPNENxaGhGbzRiWVVjbFJVdktReTB3MUhHaC9s?=
 =?utf-8?B?ZzA0Zy96OXRBS2paU2h0SGd2VDMwM2RwZUI5MjNmdDFBc3NndlBlRVM4dEth?=
 =?utf-8?B?MHp2MW9NcGdzVUEzM1hkVG9zbFRFODlhUHM4U1RsTzUvSmZXcUxjWDQzcGJD?=
 =?utf-8?B?empUNEhKL0JpdUNicjJFZWpwMEJEYkw0ZWFkaWRFV2RhNnJ3V0p5Q0FxNlpS?=
 =?utf-8?B?K24zdndaZk1mSFYvcjlsVjB3ZDU4bzlKdkVxTGoxUHRxUXNOTGg0ZU1WRXlu?=
 =?utf-8?B?aVM0RUEwSUJHc0xhYlJMU3UwRWNUM0xFYzlIYnJza3Fsa0szM1VOQ2ZqQnBv?=
 =?utf-8?B?cnJ5SHFmUS9RSTVIaE84VjJlYkc1bmZISk51L2RQc2d6RW5uNTEyYkZvTXlC?=
 =?utf-8?B?eTNRK01qdXJpL1VucHlFQi9mK0psbmE1V1VkeWczTmsrQjVKdmtJOWQrUmVR?=
 =?utf-8?B?TEJlc2lLdXFFZmZTOWFQNTRkN1ZPVEs3cHluYjRmVlJHUnhjVEFFR2k5NGgr?=
 =?utf-8?B?Ukd0eTZXakEzRmxhWEtKbGVHcDNpQ0xWd0M3cWpDdHJ3ZnUwd3MrbHl0V3o0?=
 =?utf-8?B?YklNOGhjUWlNU0Q4MmoyZlR6Y1JvTGgxeU1qUXlhQTl0N3ZWWjlNelJKZDZo?=
 =?utf-8?B?NHNHazhReE83RDN2TGlZYTJOdTlxZHRsa0tzVlhwN090R1VOaHd0QTFXOGd0?=
 =?utf-8?Q?IwhbUM1NQtSzuUiH5Xdzq6BmSPoymcjLYzWav?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 364c072b-cc9b-4406-9726-08de9f8bbc7e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:52:44.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VEsXvz8aRIWg5xb1d7AatIuCn1csnXAXrp46tnY/2tCkchDhUhGAXorGzTyyIad2ApPVw4PsClzgdjhqa61tPDetqcaaFGL1lIfLv/JdHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8316
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

Hi Wojciech,

On 4/21/26 10:30 AM, Wojciech Dubowik wrote:
> On Mon, Apr 20, 2026 at 12:16:38PM +0200, Quentin Schulz wrote:
[...]
>> On 4/20/26 10:38 AM, Wojciech Dubowik wrote:
[...]
>>> +#endif
>>>    	int ret;
>>>    	bool pkcs11_cert = false;
>>>    	bool pkcs11_key = false;
>>> @@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
>>>    	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
>>>    		pkcs11_key = true;
>>> +#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
>>>    	if (pkcs11_cert || pkcs11_key) {
>>>    		lib = getenv("PKCS11_MODULE_PATH");
>>>    		if (!lib) {
>>> @@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
>>>    			return -1;
>>>    		}
>>>    	}
>>> +#endif
>>
>> This is getting kinda ugly. I'm wondering if it wouldn't be more readable to
>> move the pkcs11-specific code into specific functions. You call the function
>> from create_auth_data() and you have two definitions of the function, one
>> when CONFIG_MKEFICAPSULE_DISABLE_PKCS11 is enabled, one for when it's not.
>>
> 
> Well. The idea behind was that you can have mixed pkcs11/cert files when creating
> capsule. This is real use case as some HSM are too expensive to store public stuff.
> Rearranging it would go well behind solving the current problem of OE not being able
> to compile. I can have a look into it but probably not before we solve the current
> problem.
> 

Please read the example provided below. The logic is kept intact, it's 
just that the code within if-blocks is moved to a separate function 
instead of having it entirely ifdef'ed within the caller. There's also 
added benefit that if it turns out there are more callers in the future, 
we don't need to duplicate this ifdefery in each caller.

Fixing a bug is not a reason for doing things hastily or not as nice as 
we could do it. I'm not the maintainer though, so this is just me 
sharing some opinion.

>> Something like
>>
>> #if CONFIG_IS_ENABLED(MKEFICAPSULE_DISABLE_PKCS11)
>> static int mkeficapsule_import_pkcs11_crt(...)
>> {
>>      fprintf(stdout, "Pkcs11 support is disabled\n");
>>      return -1;
>> }
>> #else
>> static int mkeficapsule_import_pkcs11_crt(...)
>> {
>> [...]
>> }
>> #endif
>>
>> [...]
>>
>> static int create_auth_data(struct auth_context *ctx)
>> {
>> [...]
>>
>>      if (pkcs11_cert) {
>>          ret = mkeficapsule_import_pkcs11_crt(...);
>>          if (ret < 0) {
>>              fprintf(stdout, "Failed to import crt: %d\n", ret);
>>              return ret;
>>          }
>>      }
>> [...]
>> }

Cheers,
Quentin
