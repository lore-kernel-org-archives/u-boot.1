Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8502C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 11:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D295682CCE;
	Thu, 19 Jun 2025 13:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0UOl6ZtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8137882CCE; Thu, 19 Jun 2025 13:39:16 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F18582CD5
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 13:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W32bRp0cLn5QDsB16bmabL6HRbz3mkr2oCDzVJE88iBizHM+qUzjR4qjfEbsIZ7i46wiRauXCLv7uCT7AYj3UYsWUAq78ZuKPfA65BJD+Jfa53KYHAFA6wT7xncrO1B4Uxvfx9IwtTxUrejM1WkR7We9hF85fydF3YR9dFDO1vtvfrcqK15N9xh6uK+670Pw+7aygxONOo79J/WU77T5kni9x7yup1rA9tmk3NxaSbC45SPFcm20ScCFKMJO9Pxm0ZLwkZYYvccJDRNh28qoLErAN+NlxrDxOUUzKtozm9WUGR69c/FNiKOKzxCV5IWmqxPy44FhkquZaQ/1ZoMYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oun6RqGh+53p98/qTYmaPm0RyVE4jAOqAdAYAV0pGKE=;
 b=ESwVOByGs/keAuy4HV1h2bNV+o/+qfFb96S1p+SkkdMtyMLelEwZImlkqgjefVF4c9I49h0a5b+r0iNaO/s/UzY84RCbslgcjMo4cEMh8vMJq1iimXHES/0dWa2DORg+7s+0hyaNOSTf24SNztIVekiXaSbhY4aFxj+rf0aaSIizpC6YpbgFxtmY0a+0X+CAaXSRo4f3g5exdnwU8/WQYuFXKFQtfklSBaI/owcjGU4ZoBbkC43JLalm36OO+CoKxCwCmhJGOr1Kv8kh1+g5XBiFNPYgUdB2n/HskcZD5Rm24iZ6JAO2rk7/VRxvMoVr13ZuadLQw+1tRis1so6qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oun6RqGh+53p98/qTYmaPm0RyVE4jAOqAdAYAV0pGKE=;
 b=0UOl6ZtHTp/Qx5hnOcMz0c0ckpRKde4rEThBMSvweW2pNwxK8m1BP3Q4sAruhbYObVtKQhh+/eE50Ki78PQ7T26cJSnT8qJp4kD7ZDHmBgoi9JjVDyImxyDwD/s20Hifipy47fz4K+1+KRpqru9YRRQdvcy9oRRg4ytFuZCWZUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 11:39:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 11:39:09 +0000
Message-ID: <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
Date: Thu, 19 Jun 2025 13:38:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: venkatesh.abbarapu@amd.com, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250618145930.2652304-7-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:803:104::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ff66bb-e67f-4603-88aa-08ddaf25e7ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VURKT1cyK3NrL21FZEN0bzU3Y3E2R2FGS3cwYTRnbUMwVmQrbzREL1hGVWZt?=
 =?utf-8?B?dWdFTnIzaE12SEJvQjJzV3N0Z2ZlVWRDTVlKekYrWk1vZHVYMktuM3dIb21R?=
 =?utf-8?B?UFdjUmRobXE4VmFuVGxUbzJ0NmhxeGh2VWpMRmJ3cjlQem1IWnJlK0RqS3hq?=
 =?utf-8?B?SjRnQWFod2tyRGFhMjRTOGQ5aDQzM09Wa1h2ckR3MkFkK1kxaDZIRWwzVC9o?=
 =?utf-8?B?NTB4Wkp0L2F0SmxOaldmcnJ1ZkttYllTMzcrcmg0aDhtY0dmaUdiVlFmVkto?=
 =?utf-8?B?Q0s4M1h3c3RuZTljNHpjSCt0Z0dCTDJ5aDVBNHZpMURzdlFqaWhneHZmdFhh?=
 =?utf-8?B?dUJGZnN2WjA1c1gxeS9ETXEzQjlsMUR1L3prVHBNbGNiY1lValBYU1lsakdR?=
 =?utf-8?B?ckt3QXV1VnVnY2VNdlFSOThvd0ZYellZZ1laQVhGMlBjRGNiSkRCRnEvZmNZ?=
 =?utf-8?B?anBqTERmVWQ5Z21JQWJmUmc5VGVHNHhzdU9vczZ2b2lXTlp0T3ZlTkg0cDFo?=
 =?utf-8?B?RHBLQlNhdFNJQlI4V3ltT1RLZ2thcmZTbkowU1RnWWIra3E1TnZmbTZUMWQx?=
 =?utf-8?B?VXo3Slh3QzRGY2pBRWl3OXRiZzFtQVB6SDR4YkZYVytpQlpONi9Nb0NqVURZ?=
 =?utf-8?B?ekhaMFFBd21sQ1ZFSmxMdnoxZEpFc0Z6NlRGYUF5bkRvM3hZR1lJY3VLQzBD?=
 =?utf-8?B?V2U2eGJOVW8rU2x1QkkyL09YMHVtd0dRaUtNQUFQWFhveTIrY2k2THdVS1RO?=
 =?utf-8?B?YjFVVlpablBtZXVIT1hDcHIzbVVnZ2d4OVh6ZmlJRDlOZ3BJSUZvZ1l1YzJw?=
 =?utf-8?B?NUxSOVcyMDBEZzNiRVV2ekJJbmRVbEVXU2J6YXpXbkhvenhwLzZTeENpNXdu?=
 =?utf-8?B?cWwvbEZjSk41cGVKRm41OGRqRjBYdElpdEkwa2lIaXllZHhDbE51UUpFNE1U?=
 =?utf-8?B?dmtyV3Q1VnlMWGVjbE5ublJJejJrRGp6RytSSWVHS25NdnZ4YklaNkVBKzFF?=
 =?utf-8?B?RDMycEtnMlcyMXNPQkluZG5uSGp2QThKYVNDUkIxL2E5M0pOZVErT3ZrdU5j?=
 =?utf-8?B?K000V2RTOW5ValJBYU5JcldpdDNNREV4ZXphbVgzL3AyMHMxN2YyS0lJdXhw?=
 =?utf-8?B?Ynk4ZVRhYldFWnRucVpmenNpRHljVVB0MzFsNk5uR1Z1ZndTRGNOTW9jQUs2?=
 =?utf-8?B?Qk9sVXFRZG5IUjFRSVB3YW9idFZqekZtbEIzWDYxRTkrOUk2QU1zQWxtWjVu?=
 =?utf-8?B?YVVLcWl0Mi9YSnZ4UkU2dFFJQkhyMUFPRFMrR2hOUEltWVhBT1VUYjNjMlNl?=
 =?utf-8?B?VThEeWFMaXVGSjlNL3ZaUkd4RlpOKzM0cnV1UU9WR05JSE81aGdJb1kvR1A3?=
 =?utf-8?B?SXE1Znl2NFAybXZiNEVHZ3kxTHFCQzQ1L1JKRFB2VnZmSy94cnVMd1hmVDZ0?=
 =?utf-8?B?MURBRXZJZGw2TXFlKzVHUC9hdlMzOXRMLzJIc0gvWlhOWHl0Z01hR3lEOE1Q?=
 =?utf-8?B?bWdwMmt5eWJGYkY1V3Z5S2FBRzYxdFBoZEdEZkllSlZOblIwRkJva2lQTXRG?=
 =?utf-8?B?eGcvR1dSd3BYVHpMM1N4YzRGYng1U0djL2ZmdWJJOG43Q0JJSXVscGRwRGNG?=
 =?utf-8?B?UmQvOFNYR1JSd2E1TlFYdjdObWYzNlJtc0JuQlgrYk80QnhRYUoyY3c4RFZO?=
 =?utf-8?B?cUdYZ1Jza3FtS3lkZXA1aWdtZ1Rib1l1S1E3aG9lVlJzT2ZIbzJJaXIrRmNC?=
 =?utf-8?B?NjdZSnVJdFJLbGF0MEx4QWV0a0NhMmpzUEhJYUd0V3FQQ28xV3lEM1ZWcmhn?=
 =?utf-8?B?Q1VGdzBCNitmb0RpeUdzME5hS2V5RFBXaWx0OUdaUkVWZThJa1drQ1JaOEUy?=
 =?utf-8?B?MUlXRWFONVhyd2Q5RFhERWpCQ1dLZmhCTzl1NWFqUVJHa09VMXQ2YVU5d3FC?=
 =?utf-8?Q?X74sdioqb10=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNhV0xrVjhNc0NFTisrRHV2aHNuTExlTjhOd1dFaXE5ZHo5SGVmZ1hJc3B1?=
 =?utf-8?B?WXNlL05oQm9JRGF5VEhLcnBKMXNUcHdLNU5vNkIxbGpYNnFvZnVXN3Nod1BR?=
 =?utf-8?B?WGVHejNBRTF1dkFoVFBHQ3BvNml4b01WcXp0UnJRVGdHNnZubC9Ld0J3Qmsy?=
 =?utf-8?B?anZaVWlhRUtMS3FOdnVReVd4aGxvQmQ0RVFDSmxxR1FyLzE2ejBQckR4bE45?=
 =?utf-8?B?TWVkWG16SnI3VWdzQVZQUGIzbkQ2K2R0MjFuUmIxT29ybDFMbDBxcHZheDNs?=
 =?utf-8?B?K1g1VDNvS3BDenJRUXdZOTNkaUFoZmFJQXJnQms0MWowY20yUkdaT2U1UHlS?=
 =?utf-8?B?dlFNTEY3bmdCUjlrNW9LdW5hbkRmcndLOTQvOVc0WHF0cE05dHQ1TU9QL1FC?=
 =?utf-8?B?d3dwbG5tODh1UHBIRVJra0gzV2xGNWZadEw4WkVIbFREaTdJbWZkbjU3ZG5H?=
 =?utf-8?B?ZTFRcEpGQkxHQ3RZV3Z0SGhOTmVodEZrTURXV1NoVTBKZEtMTDhHNDRLaFU3?=
 =?utf-8?B?aXhDSndGeWRoRjVEZW9YYWgvKzUyVk9lUFh4Q09ZdEdZVlhqcUdoT1F4S2sv?=
 =?utf-8?B?czhackNMYVBUUXA5cU9kMFB0T3hOdjdHZ0VBc2FEQmJKVEZ5eW16SFpwczht?=
 =?utf-8?B?cTJONzk2YUV2dGZJaGJndGVNQTNna1hteEI4MDVZMnVTbGJLWkt2NDFkTzRw?=
 =?utf-8?B?KzcvVEZnc1dtNlRVYTMzQndDOXZzVEV3ZTR1WnhOZkR0Rmw5QTZOTjlVUVJw?=
 =?utf-8?B?d09WUFdxTklVOUxQVEEyOXRkK0dsemNBdCtVbEMwSE1Kc29UcmF5eVhsa2hq?=
 =?utf-8?B?OStoN0xkbXpaT0hEbVQvU05aZ1JpMENaQmJjaStTWXR0dUFVT0wrdTM4T0FL?=
 =?utf-8?B?aUJBZWtRQW5oVE1TNW1NcVNWRnlwRVNQVjFrOEI1Qnh0N3ZJUUcxaUVzMWVk?=
 =?utf-8?B?WW90SlE5RzZWNzV4N0p3VXdPcEtwMTFuRjdKOHMyT2gwWnFma3MrZ1pOb3kr?=
 =?utf-8?B?Q1hGRWthRFlOK1cyVGJLZW1hSGt6OWJxcDRoM2tnVm85dVFoYk03MS9aQzRT?=
 =?utf-8?B?V3hkOGdzaStmQ2JFN2d2Ty9rMFBqRkZrSUhHVk0rWDRCOCt4aXVNck1DOUZp?=
 =?utf-8?B?aE9Rd3p6ZndXcjVPNGdEWGZwcys2N25PUDlSN0dYQ1FKQnBkMDhkYzdwakxE?=
 =?utf-8?B?L1k3TUJoTTZ4V2FUdkw1cVVuZmxDdk8vcnQyS1V4Wlg2K2FWUUl0MjJqWWE1?=
 =?utf-8?B?SVkyY1pYS2RtYSs2RmZLUU9DL1M4ZVR4TEJ3V3Nndnk3K2VZdEtidzVPazY4?=
 =?utf-8?B?RU1mdVdnc1lwZnc0U3krL0h2R1FKaXpEZGRIbTZoWGtVNWMvQzU3MkE2Vkhm?=
 =?utf-8?B?RWdjcUlqZ0NjdW54eENoSHFqK280aHYzSklSZUtUTURDYytMVFR3NitRREh0?=
 =?utf-8?B?a0RGUlhRMWYzTFdpVnlWMnVXN3hwWDZXYTdZbFRrUFpwbVgybk43dHJvdkw0?=
 =?utf-8?B?QXVuM2hxWjBhK0R2cUY5ampYR1F5cHFCWTB6MjZQM0ozZ0FSSUpqaFZhL0gx?=
 =?utf-8?B?QTJtd3Z0YnVua0FKWFNPcnJMcFlYUlc2dDVsQjExdXVQYUFMSHI5VXI4S1pj?=
 =?utf-8?B?YXcrbGoxK0FPMFBQNXVJZEcwZU4xdEFxbDk4cWMwdGdmL1ZCcG1JR29DaWVj?=
 =?utf-8?B?TCtrWlIxZVQrSDliTXU1Vi9kNmJuOEVzOVVZa2ZXUnpBZEZyVEhHMmwrbDA0?=
 =?utf-8?B?aDVxbFBTU3oxZDVTK3Nnai9YWGxieEhBYWxoVEl2QlRZSnNKcUI2RmxMMFFz?=
 =?utf-8?B?UUFqUnpObzBnTlZSV3YvMEdhMjZCVjRGc3pjTWJhdy9acW9OMU5sYm4rSGRo?=
 =?utf-8?B?d0paRk9PU2ZraEZHaDVQTUprYlVqVmY1dXdkUm9USERBM2lQR2Z3ZDFaT005?=
 =?utf-8?B?dG5KcVZ2SEhLeStDQXcwdVJjdkdNdVI2cmJYREVZZlZaWDNQVmZ4NnZTd2tR?=
 =?utf-8?B?bFVHczN6aXMrSW56c3FscjJRVmRaeG9taTN5WDVrTFl2eXA3clRUbmdFVE5u?=
 =?utf-8?B?ZHpGaEhIUENrWFZPYjFDNmtRMVlCVGVTSmZFNy8rTWZTcitqR3c2VnJ0NFY4?=
 =?utf-8?Q?bF1rnU/hY9jyAZjNYCTkt2h3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ff66bb-e67f-4603-88aa-08ddaf25e7ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:39:09.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2IFUjHPQfVIIzoAlkSzqIzB/UMxSm7MC/1n0SvevfabiCvrVckSKeodr5XqY37x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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



On 6/18/25 16:59, Raymond Mao wrote:
> During FDT setup, apply all existing DT overlays from the bloblist
> to the base FDT if bloblist is being used for handoff from previous
> boot stage.

More technical details would be good to have here.
Especially that the way what you are using is to expand DT

> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   lib/fdtdec.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c38738b48c7..3a218d8c94a 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1687,6 +1687,60 @@ void fdtdec_setup_embed(void)
>   	gd->fdt_src = FDTSRC_EMBED;
>   }
>   
> +static int fdtdec_apply_dto_from_blob(void **blob)
> +{
> +	int ret;
> +	struct fdt_header *live_fdt;
> +	size_t new_fdt_size, blob_size;
> +	int expand_by;
> +
> +	if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
> +	    !CONFIG_IS_ENABLED(BLOBLIST))
> +		return -EPERM;
> +
> +	live_fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +	ret = fdt_check_header(live_fdt);
> +	if (ret)
> +		return ret;


Why is this needed? You already have gd->fdt_blob which has been checked.


> +
> +	ret = fdt_check_header(*blob);
> +	if (ret)
> +		return ret;
> +
> +	blob_size = fdt_totalsize(*blob);
> +
> +	/* Expand the FDT for spare spaces to apply the overlay */
> +	new_fdt_size = fdt_totalsize(live_fdt) + blob_size + 0x400;

Some notes about this 0x400 would be good. Do you see issue if you don't use 
this value? Is file DTB after expansion actually bigger then origin+overlay that 
you need to add 0x400 magic value here?


> +	ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> +	if (ret)
> +		return ret;

You do resize inside tl list.. That should be described in commit message 
because my exception was that this location can be read only from NS world.

I didn't run this on HW and likely I should do it to understand this better
but isn't this moving CONTROL_FDT entry to different location which will have 
bigger space for applying overlay?

Isn't it also worth to check if existing CONTROL_FDT has enough space inside 
that new overlay can fit there before resizing it?


> +
> +	/* The blob is shifted if it was following the FDT */
> +	if (*blob > (void *)live_fdt)
> +		*blob += expand_by;
> +
> +	ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
> +	if (ret)
> +		return ret;
> +
> +	ret = fdt_overlay_apply_verbose(live_fdt, *blob);
> +	if (ret)
> +		return ret;
> +
> +	/* Shrink the excessive spaces */
> +	fdt_pack(live_fdt);
> +	new_fdt_size = fdt_totalsize(live_fdt);
> +	ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
> +	if (ret)
> +		return ret;

I didn't try to run on HW but don't you need to also adjust gd->fdt_blob to 
point to current location where fdt is?

Thanks,
Michal


