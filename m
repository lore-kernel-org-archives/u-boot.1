Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E798AC282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 15:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59393811E0;
	Mon,  3 Mar 2025 16:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TiUWcSbJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6198120C; Mon,  3 Mar 2025 16:16:18 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CACB811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 16:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPdElEhTnGoP5SuQx2icuRA3/6W9ShhdqqdSwobfvP85VODIWLXx3S7bYNpaZ2lbWZjqPkdnAX4GG4Qr/PECHat5hMWbwYljznzjV7CIK9XJpJZq1SBcURzMGYY1WOMm2Fy9rv2w4WFHFdw03ek7bCLLs+XFKER5F64NjVEV2M7L2z9PoSuZu4dKEs0hZZ9WFhqBNwHLbIQPUB4OCctMKWmOh6wD8OFh8mFGUNUkp45eaZC0mhUjdBXKGimzwsrxZ9aqAdPK4VmCH4Z+vDQpb2+jcdkEgfIRv5n1lSWhRm3ofJ17oUOAVDPzUNOne793lLUAZKtpizuN3QkwUdE9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/084W13xiCA7YeshekZdTURlO7xIkmlbtU8NAquEvE=;
 b=rmZDj/jEwXKxFR0QzFtYjdp9bY4m9ll2L2n3QPQ1wXf2SDKGPN3iIJekyxtuVIAcDXm4IIGLUF2lIu6rthzLlaxyXNH6BHmfvUNPXrKXaNv5cIeVu14eAimrGrR9LEzzNBRqJTLRYRow53Sq3Vkmlbj+b+Zbko+VoQw0Di9lN0ajh0Qqw1rwSVRgNJke0tBwMpRhdIW1XYJZlFqUHnWvThJhehJBaiduVgH966wq+Kvfz9vcoYvz9VRy9M4LblVaVkVLfFGrXRI/n7ZR4RHn664vXyAvd4IVAO79f1oi8twiCCI4H4GX128/qGoj6C728ElImu6pyYesagOMFb16qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/084W13xiCA7YeshekZdTURlO7xIkmlbtU8NAquEvE=;
 b=TiUWcSbJK+eSV4ns59MjcQnS4HgB6XRqmEnumjImS90jJ7O0MgyTGVab6zDYJjLsnju2Xg3FqDzds6F9o1fZXZF5K48a5h8GjRuzMIUWH8w/MJfrTB4ojn9Ccn88+sY+EFmkHJUw4iLwJMuqJNZLoE/JGlVn0edtsvsNEtL3rCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SJ0PR12MB6965.namprd12.prod.outlook.com (2603:10b6:a03:448::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 15:16:11 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8466.016; Mon, 3 Mar 2025
 15:16:11 +0000
Message-ID: <a2210d8f-585f-44a0-a728-064b3246ad1a@amd.com>
Date: Mon, 3 Mar 2025 16:16:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Remove tftp block size 4096
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250303132816.2327057-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250303132816.2327057-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::28) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SJ0PR12MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: a25b13cd-9f25-4fc9-5730-08dd5a6654c8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXRHVWFIU0V4cnNrMy9FNDRIRzNJamtLTjZMVkxvTWVUVE10cCs2cERvTVhm?=
 =?utf-8?B?OEJPc2JRalU1cEhVaFF6YVhlWlNPME1uY3pDdC9lOG5vazV2cUN5V2cxUU5T?=
 =?utf-8?B?MUN0UFFlK1JkRHBwckN6ZGxuT0R0YlVBTm85NTl5cHladUQraDkzQ3FPdUc1?=
 =?utf-8?B?NThXa3hKSGFIR2FKcDB4UlRzNlhreU96NmlxS1JtZ1g3aTF1RGV3WDNwMEpN?=
 =?utf-8?B?aHh4bjUzUVIxdEdDbG9KUVNPRTRHVy9mTUZ4WlZzdEdMcW9waGUwZzl2L2NS?=
 =?utf-8?B?Y0JZUGdZRWdMbmNKU1NaRitVR2JlOU96QnR3SGhxOXhBdDcyNkJ3NlAxWWll?=
 =?utf-8?B?d3ZuNUdOYVdiKzF3bzd2OHFwWlliak84d3hJZXg3akNKYldtQlFEU0o2eUdU?=
 =?utf-8?B?THQ0dnViMStMdHIwbEgvODl5WEVKMWU3UjBYMGRFSE1MZ2hNNW9WUjl5OEN6?=
 =?utf-8?B?cm5UNThjN0VwdkR3WWFXSnJyVFFJUXVmNitmclEzQnVKbjc3WDgyZkxGZkhk?=
 =?utf-8?B?cnZuTUpnRWpYMk1JbkZiMmwxSStsWkpjaUJCTVcwTjB3S0JFUkpRUE5QODBu?=
 =?utf-8?B?WnJNSUp1dG5XdGtidHBXVmt5c1NiM3lmM0ZMVFFIK05PMDNrRjhxRXlmWjNk?=
 =?utf-8?B?S3pncTB2bVRTM21yNVc2RTNKaUNCWkJWRE54UW9tZ3FKUTUyeHppakF5aTBz?=
 =?utf-8?B?dE9lNTdvVkdYblNObGQrbjRlc1kxSzlKTUtiKzJXaFJuemFFY2svZzJCWVM4?=
 =?utf-8?B?a0VxSWZWOVFuTndkOEhXTWtTUS8vNVJrM0x2M1ZzZkZ5cmF1UzBrRmlPTWNu?=
 =?utf-8?B?Ty83UDRZVEh3QmszT051ckx5YTBDcGg5MlYzbXlrV0RtMkZEMlkxYW5YT2dC?=
 =?utf-8?B?REF2aFo2QkN5cFliMmRWK3NiVndkbnhSMktqeTRMYzBSRDRMaWlxOCtWSGZT?=
 =?utf-8?B?TkFCNXpMRzJyNUxVbXFQS21WNzJJUHdDZjlKdmtjdUdKdTE5dUc1U0N0dXo0?=
 =?utf-8?B?d3BhZU9HZTF5dHhzWVVxTVJUVjZubkh5V0QxRzNhYm5LYzlVdXQvZkhOYVBy?=
 =?utf-8?B?VWhrK3lONXpReDQ0Z3cxTUE5TktWYzNxRzJEWUNxQ2lGU3c5N0l0L2xZb24r?=
 =?utf-8?B?SElySlpyM0wvS3dFU0dLdmhVVkdGbXNKQXdvT2syQ1dUcjJsaGI2Uno1VGxk?=
 =?utf-8?B?Y0Yxa3ZFdjQvMk1wNURiRUYxekVIeno0RGVvUktqcmFWK3JPcENDOGErWi9L?=
 =?utf-8?B?anB5WHdCc1EvZmo4cC9ERG9POUZZeGdoUm5SdDNwWjFucFVYbCtjMHMrN000?=
 =?utf-8?B?NXJwWkFlME45QVZYdmM3d2wrS0xtdW4rRTRBNk9ZOTZEUHdMVTRFN29zSXJy?=
 =?utf-8?B?UG5KcVRCMjROYkpEL2UzaUFUaGxYNUVBNldoZ2J5S1V5ejJ1c2pmZ25lZHVQ?=
 =?utf-8?B?VThoVXRMcWNxMDZpam5HMVRlYTk3bkR6WndKdFdqQU9TWGZYQUROT3liTEZI?=
 =?utf-8?B?S2xjeEZqanV6KzVHRENTdVVrWWwrMm1acHJ4UGsySXd4Ulh2ZFJxN2RYbzE1?=
 =?utf-8?B?Q3FSRjd1WW1OdUVyS1ljUWJRTDdzRVpucVYxQjRjSnpGeXNLYXNOWFVvSWcx?=
 =?utf-8?B?dHFqOEtsVkVWU0NYWi8rY2toTkRmQ3Bod1lDNm5yS1hkNUhpa0NRZ3RtOVhG?=
 =?utf-8?B?dDFUb2U0WXVHU1phMi9oWEd0UHphSmJ6b2xFM2Q0UmFCa05lVFN4aXc5cmVI?=
 =?utf-8?B?U1VxcnBPREc3dmFuN0lIOGNuUE1TVHZlSVM0TXdOSklFSVhrSmkzSDZSNGFo?=
 =?utf-8?B?Z0E0UGhvOEY3azl6VFp2a0VwRlFsZW4wMER3SjFUQzlDd2dlaWovaE10RkJU?=
 =?utf-8?Q?dzV5w9Ens0gAe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9QR3RDYTdGaDdwSm9rYjBxSjNHSGlSZGxUb09HNTZmSVNYcGRVaWVNMWZW?=
 =?utf-8?B?WHdUdlpaekt1OVZCTEEwcWg5dlZiSWtwQmZmcXcwYUJtNTFSN3BiYktXYmln?=
 =?utf-8?B?ZE5QN3RndVVIejdkN0s1RVFPL25BSHdXNzBvS2libTNoUWdmQU4zRmltZG0x?=
 =?utf-8?B?bGhwTXFuTmZYQmtoMEdWZ0E3aFZUemRLUUlCbkNFY1YzTkp4ZmVFbDFtWUlw?=
 =?utf-8?B?WDhPOG1sc0NuK1NBUjErbFEzWHVlRDhldEt2TC9pUjVBWmcrVzFmUTc2SnBI?=
 =?utf-8?B?OEorUG5wdHUzNlFiS2V2MDdwREk4dDdvekpJdXVrUncxNnUwTUNXWDhVY2dO?=
 =?utf-8?B?N25EeDB2allXVFp2R3ZIOEpaSnNlV1NsenNPWk10TVFHMitWZ0JpSDdvV05N?=
 =?utf-8?B?cHJHaE5wcER5djFlTnN0SklLT1BMSS85dHQzVWRPMStvdHIwRzJNWFp2Wkwv?=
 =?utf-8?B?amFQcVlGNUhlWkx6dnJQdHoxTTdseDBVemNTb1RFOGMvQy9UaWVyUXV5UEs3?=
 =?utf-8?B?TnRnQVcxWFlvTGxIZWlPWkIwdmk4OXZXOFRYNy95SEdSbEgyVW1CZTBNaHo4?=
 =?utf-8?B?NTRHTElUcFpyVEgxaHJSZFlYQk42YWYrZnpsa00zSkRrK01DTlgvaitHZnZP?=
 =?utf-8?B?VXRCOWtCMlEyRGJNSGpXSWNzT1lxZGZmbUdVdDFVM0tXTGFtWVp1Zk5RWmpj?=
 =?utf-8?B?ZjA3THlKV2p6dnRpRksya25wa1RSWmxUT1BWcWRGMEZGMXJaL2piQ2F0Yzd4?=
 =?utf-8?B?VFZ2WGpTdU1LemNuTFl2dy95cktmWkNPTnVQelZDOHN2TDlnQnJGYWVILzlO?=
 =?utf-8?B?QUwvazAzcWJaRUg3RmwwcHVSN2xqeUovY2piNjk0Uy9wbkVhUGVaaWQxZGRE?=
 =?utf-8?B?Ui83dnlpVXQwOCtPM1p2ekVXN1pMQ21yY1pxaFJuaXlzWWhUMXNMaUlvRURv?=
 =?utf-8?B?M2Q4WmVJSDdORzBUd25VUDkrdmlpcTNZMVRqdE1OZ0FxN0JscGVOcjVMR2RK?=
 =?utf-8?B?VDYyVEdSQktzakZrRmZnbkg5U2xrQVI4bEpRUk5vYWJlb3VLN1NZS3VGQmls?=
 =?utf-8?B?Z3MxTjJqNFFKcVBYKzVocXFTVXBUMjBydWJONkFCaFdBTmR0bDN1Z3NGZ0Vt?=
 =?utf-8?B?SXgrYXI2azNoTjI5bytGcXI0bmRicEtTSHBHcm9mN3UrbUJXbUhIVUF3UmZC?=
 =?utf-8?B?TjVYSVN6TGZxMDFxU2FUMUhnZmhtMDhuY1QwRGRCaW9HUEZmZjE1YThDc09Q?=
 =?utf-8?B?NW1CdkxrZnhWbGN3SDhoWEFneFUrUGFUa2JLRWY3VFV4U0dhNjd0VThNRmNy?=
 =?utf-8?B?QzlGOE1UUVNOS3lQMnkrbndnVGl3alJJVHViTFpBTnRqc3ltUHBwRkp4RXdl?=
 =?utf-8?B?SGdJRkZ2ZnRnZUswS2pMZ2FaVWQ3YWZoWEQveGFjQ1hlRVk2M2FXMk8zYUhL?=
 =?utf-8?B?bXpUdWl1Mm9xTGxCY0UyeVdqSzYwcjBkM3RZc0x4dEFvT2F3aEhqOFlncDJK?=
 =?utf-8?B?WHpTSC85b3drVHJJN3VDeGc0ZnlaMGVPWEViOTdKeGsvQWRuUzZtOGJCNm5C?=
 =?utf-8?B?YWxtU2RKSzUwQ0pIaWtNUjVRYXg4MHZaQ0JJb1gyd21FOFZzdFRvSEdPK0ZS?=
 =?utf-8?B?b2ZsUitQWk11R0h6eUZ1MnhWSnpzTTFMQjVYdVNGcktxSll2TG8vbkw1K1Zy?=
 =?utf-8?B?U1ZhQlF1NlZDZUZMTXBiS21qVUNPUUR4L2lBM2JQRFBEekhCZDNLM2lkczRU?=
 =?utf-8?B?ZmFhZ1dXNVR1cGdITkYvMGx0QWZiWVFYZjh4VHNoUWRFUG1kSnlGZzhzSy9u?=
 =?utf-8?B?bFFlUUM1d0ZCOFExM2FqZDNtRDRKRkZMRDBhQTZoR1pJTTNwUzZiSnV3ck9r?=
 =?utf-8?B?dFM5djZBbGJIWEc4UTZTQ1Fyd0hJUzQxYU8vSk4rVnJwS0tGR2IxTGdpWjM1?=
 =?utf-8?B?NVk0WmMyU1BWRzBHVUwySldPNmlERVV2RlpOeGZrSEp4cU9zTzM2dWxQWDNS?=
 =?utf-8?B?Z01HQ1dNcm5zaHFHQ2c4L2VpTWNYbWs0Q3BZcm9RaFRoRzNjeS9kdEJnY3hy?=
 =?utf-8?B?dUhyQjdrN3BMcDMyMkFuSW00Yk1DaTRrektsR01ONmhQblBQTUx3eEkvakhB?=
 =?utf-8?Q?OdKvtdmS940dIoH0s/LYc4IVf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25b13cd-9f25-4fc9-5730-08dd5a6654c8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 15:16:11.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Fk6LpTgOni8+hlfJqAs5u69L0qDzOpKZFc5hkGK7P2C8QjHjwq3r/65p+A+tKz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6965
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



On 3/3/25 14:28, Padmarao Begari wrote:
> The zynqmp gem driver support max MTU size 1536, so remove tftp
> block size 4096 from defconfig and use default tftp block size.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   configs/xilinx_versal_net_virt_defconfig | 1 -
>   configs/xilinx_versal_virt_defconfig     | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 5ef5fd44fd..1604b5915d 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index f228eef7c9..baa4b8e412 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -74,7 +74,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_TIMEOUT=y

Fixes: a33b4b96b3cf ("xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS")

And you need to also remove this setting from Versal Gen 2.

Thanks,
Michal
