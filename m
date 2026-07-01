Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB20C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D012784B92;
	Wed,  1 Jul 2026 14:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="OOIDvtvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21C684B92; Wed,  1 Jul 2026 14:52:12 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C2284BDB
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjwtpWn3VrPJ8lTK1Rmn6oOxJEIZyWzSZNeoWg0XrE3+rSuJkjJ+EmdXwquCqNLGxWULGU5/9/a45nfuXPFu71jePNg+tbJm6ES/0uj1pIPrch1fcW3fyjp1Se0oR55vhYHXYY9Dmbzbzw+RsFMZDuRq6b9Sp/E3UOI04+oR7V31N5gdC7qOKj86+KEtuHgu7+2Xur0ifBohvr8k43d16RQS8LJkAurG13qZJZfsHn9w9DX0Inke/0udtEt5xetgDFgpT92OcfRDqxXZZ15XhqxeEv61I/sPxCj9eOGXRwErbDti3IJPTh0iKeWhs8XUwnPnb5uetZ4jeBGlXroB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52ATPN/uwCQbEZdNAm4bVoEvGgCbh0rFxSrzA/6OzNA=;
 b=hciVtt3U/H6MRdBNAS0JQVUq+VG2yo3EPO1r/fU6FQnPXQSYdtvIUbaQaqTBEKWSet+fh08ErvXpqaq2/iGTui6R/ar/MwSiAKOKJmHO4i8Bld1N90vI4OA3n0BTse5gx8VSz7aeVyVIvmEypDuNBNTMSv0mzoatGhkABfOILzzqV68PHpLimZeN2mEKxHiIpLKcqPcZiAI56eek6+DLcJYgzd35LT/r+J6jOqrw+B5qkhBPQigtMyD9sHHxhDdkxdgzZqg2RAa6tjJ3JsWnQJv3YPYuhN0NYyCYT2/tKuLq4AKk5WowMlNTlXa0no+ImS5TcILr8U0peK6/XnbqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52ATPN/uwCQbEZdNAm4bVoEvGgCbh0rFxSrzA/6OzNA=;
 b=OOIDvtvoMw5jJ7JXXwpnreHs87q/93hH1p9se8GxjN37bCB6UaGBP3J/8bCnnn1vuD1+Gnxg1jHtHkPGyMlnUWzKNIfM4CdPMIXTPhph+Spla4MBKm5Clb+JVAntt+Oe2CLc7F6hW/9x6OvBzybJFFcrTh708O2Wf4mlR9mMVdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB7547.eurprd04.prod.outlook.com (2603:10a6:10:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 12:52:06 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 12:52:06 +0000
Message-ID: <e3e81b3e-02ec-4438-a834-4cadf1ed4bb6@cherry.de>
Date: Wed, 1 Jul 2026 14:52:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
 <20260626215804.GB382693@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260626215804.GB382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B96.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::633) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: f59ee401-1c12-4061-c4f7-08ded76f8e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: /c8R1335QAmrGRjA/76jbkUPyGMMDAtDet67EibK7Qwww4IEDCGkmnHc8EDZGZpELYSQwr0Xcbfr05ImnwVlqoOJlF+J2DZUzCkJAWg6NYZo83uI+F9W/SPeWMqUjBHz3gn1R66aybKA8QLSKT5sRWFI8OveA3ItuCtVJCPiLTeRhgtQVaE+JQLN8Jp0n8I7MUN8/uWMir9uE680be8FfWbWZZmPQz+yHLtvg0oYuLCkq/tRJDowMvqfSCiS9ZTk54I6d+cik7HCMCGH3Wj3FVD3ggBdXtl/aR71q2EyH6EtvvUh+ggGqBnjhEarCDUD/6CUmDlK+nGYC9Rzh4HyZm7vbmsbhTZCHGVyv4qCPlCkqsVVcw7VcbAV1uguKn10U5rP/eMgIIlZujIP6at6ldX+j+Ljh/0gM5SuTt2HuaJVR8jxluQodF3qyMSVTVmNA7kp6FxnsivbHr8Yi6fIe9RW4SOvMq7urbVnSGS1NkfFhNDarRlaxL9qo3ZgI3JNqV2ffzmBettqGYRIQqq9yZPu7ZtI6Gqg16gaCGNeAwYAX/CuLH6ymMO6PjMrpov3PKykyu0YPZHTGV5UsPIgUxtzTQ0v1XUY0Tx1InLclNC2jDNZSW7/GgmhbHFxBBKeTI4dpjDWKs5wVT7K6bMZiZEG6Qv4d+AbEkBmR4LSx2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1U5TmtjQ0lpOWJjZnpFemtoQmoza1lBK045b01tMkxDTVhMMXJzU3NzRmIx?=
 =?utf-8?B?c0hQTVR4eG5kME45SmEwSVNmc281VlEvRXU3YnJsSE1VVjRNWStYbzNSWXd3?=
 =?utf-8?B?aHVXaDdLZ1JIbmFaQmJNNHkxeDRFQ1RkNjNpRWZWMTVCSmQvcnRKWlJmZTBO?=
 =?utf-8?B?MFUreUpVRzAvS2luQzNEdWtvWGNyem1sWVVIQ25BaU9wL0pQZEZXOUNDa0hx?=
 =?utf-8?B?R2RwUzRPbElKaFdiQnVyZ3crakZmSlZobkpIblMwRXdpTkxKMjljK2FCSTBl?=
 =?utf-8?B?b0RKYlAxMUhzbWxVbHpmUUdRdnNxeGExTkZYQUo4akl4bkhsekEwamlLd1pE?=
 =?utf-8?B?YitsbDFVUmZaNDhJUzFDd0NoeEw0eGhMQW9iQWwzR3cvRWttQzhGZjJlSVBJ?=
 =?utf-8?B?L2VsbURqNjVnam1vYTFGeC9qeGFWRGVYVUpmQUE5cnJpQzBVbjMyQkhDYTMz?=
 =?utf-8?B?cHJINmJoTDNiVDVsZnlWbCs3ZWI1VThQSCtXM2lqeTZaaC9HaFFycGN5VXkz?=
 =?utf-8?B?cmhYdFJCOS9nSVRrWEx2VDRKQXJEMklLSVpXNEc2YVc2Q3lGL3RxMVVVQWUw?=
 =?utf-8?B?UGlJZWducmkvOXVuQmlmNUtteDFibXVsYS9pSGFDYTlpVXRVaURxMDcvT2pR?=
 =?utf-8?B?dlNhMndJOVFuUXJhK2tBamMzOUE2K2NhZHZuKytqcUMrdWpINEtmdEhvZ2lq?=
 =?utf-8?B?WHNiSHZCVnNISXpJN3JkcVRzZVB2MFNaelRqVDhMTU50bDVTWUZGUHRPTkVa?=
 =?utf-8?B?aFQ4MFBGL3dOZld3VktKelZ6VHJ1U1FCamdUY3g2VENqQmxwSmorZ1VVWEYr?=
 =?utf-8?B?UVFnT0svMDRHNU9UcEhaZUMvOVF4dFR3ZVJRRnhJRGJkZGJxVituOFh3Y09D?=
 =?utf-8?B?Zm11dmVDbG1mbUlBYjEyN0hzbW9NQWd4YktucGd4SXlPZ2hWd3B0SWFqaE9n?=
 =?utf-8?B?YTllRmdEMFZHNGdLQzBsVFNpUjBpdGE5UEtkdmJ5WU9oQjc5aTE3SHhLYmd3?=
 =?utf-8?B?aFoxMFYxOUpzU0ViWm1IOG9wUWlZYjhQR3B5ZDYwMk1Na1A5YU1CcjNSaUZH?=
 =?utf-8?B?dFdMTGg4SjZBRFZ5cE9PenBLdk9SeWpSd2FqMjQ3cHNhUEExVjZpcnE3enEr?=
 =?utf-8?B?bTJqUWdsdUZFQkNxYkFoT2FRTTN2cVBWbXNrTWFJV2tUWk12dFVicmRwNGxm?=
 =?utf-8?B?UE9UR1Z3UFIzRmJ2UG93UmxlcmNBbHN1ekJxNmxtaFVOU2kvdlcreEVQMGpy?=
 =?utf-8?B?cTRZVTNaZDFKbEZpTUk0QmtzTTZZOU5EOTVxTkJnbnlabW4yOVEwc010Q2hP?=
 =?utf-8?B?dUhGallFZVhScDhHMG05NlNWazQraDVPR1hzcmFOVlFKQnptbDYrZG9BYW5U?=
 =?utf-8?B?VHJVZ245aHpuMmtZNVhKaTFLdEpCV05hQ3ZpRWpicHpaTGtaaGxTanJmUkli?=
 =?utf-8?B?WGc0ei9LbllMeFpYWFRXdmNKdFJzdEhONTMzZU1BYnJJdVZFSTMzelJlcVJ1?=
 =?utf-8?B?blJYcTJZNmlFL0VOMklkZVlqaGJZbDkvbU5tOUtVd0J4ck9CSFhRSWdvWCta?=
 =?utf-8?B?OVEzZmRVVTIvNWQ3a2dXUithYjJDT0FWQWp3Q0t1M1E5all2eW1zSFJBQUQ5?=
 =?utf-8?B?M2FHWVVQa0ZPQkFzSmIrRXV6RjZKc1hWTlBWN0VCS21DM0pxWTU2RW1sMHBU?=
 =?utf-8?B?MkU0YUE0NDVFMzRMYi9iTVlxR1g2dWV3QVVtN3M3SDkxWExGMTNiRGc3WUU4?=
 =?utf-8?B?VlphbEZsRi83VmZmVWJNZzhlcWpodVdNbUp4TzBMdTltUU5FV2JzWU1abWNr?=
 =?utf-8?B?L2tTSlBPOFFiOHdXRkg2UFlLVWkvR2ZmZS9GQjVQclliTXJTanNzZVp4YXpN?=
 =?utf-8?B?ZVZrb0tzblNGZTB2bjcxcFY2WEZyT1J6aVBTc1p0cXVZbE9mU2VpQ0FPSjJy?=
 =?utf-8?B?U3drZ2lwRTQzM1J5eVlKbnlKQVVRNEdiTFBLKzJRVUUvTTVtdjZOMHFxNTA4?=
 =?utf-8?B?Nkhwa3Y2UUVEaVh3V2ZYT0doMHdjSUdzZE0xQ25ZRU9ZcGhFVXFTN2ZSS1Fp?=
 =?utf-8?B?YUI0dUwyMEk4NG1rYU5tTWMxL0krL1QvbEVlcHRKaGRhWkdaWHNNb2FnRWpZ?=
 =?utf-8?B?TW1xSEZyNyttZUhZMmtTRWxKUVNCOGpUNXg5eWFVelNwcDJyQjZLMGs0bmdz?=
 =?utf-8?B?TmlvVjVJdHBXNlZXZzZKbU1CaXdoa0xnMXdGN0JvMHRIN3JaQzJWa1FUUUhI?=
 =?utf-8?B?VkdNdVBTcUhkOHZGWVhzNmE2TFNqOEVBZE9xaWJHL3J6RTcycFp0ZGtEVjA5?=
 =?utf-8?B?OFFQQytVYlBybDRJanJLcU5KQ3daRmRaU2tsU3BJNlM1eUVyMlRPZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f59ee401-1c12-4061-c4f7-08ded76f8e8c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:52:06.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ffd3pV/eCNMdXiMV09QqhmANr9Z44xzMXHFe7Z80VloLRyUHFCnoOroZttbSbTwc+j+qK7x+TCbsmTsNp4MaOxbhOgSLC4IfmwGPDeN5L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7547
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

Hi Tom,

On 6/26/26 11:58 PM, Tom Rini wrote:
> On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
>> Hi Dario,
>>
>> On 6/26/26 8:33 PM, Dario Binacchi wrote:
>>> Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() compares
>>> an unsigned int (mmc_dev_num) with ret, which can hold a negative error
>>> code.
>>>
>>
>> The trick here is that ut_asserteq() takes two arguments and casts both as
>> unsigned int, hence why it complains.
>>
>> If Coverity is happy, I'm happy :)
>>
>> This looks fine to me, so:
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Yes, were you able to push this through coverity on your own?
> 

I understand this could be misunderstood as I ran Coverity on it, but no 
I didn't. Read as "If this makes Coverity happy, then I'm happy".

Sorry for the confusion.

Cheers,
Quentin
