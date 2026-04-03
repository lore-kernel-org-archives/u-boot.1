Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A92E8537A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 15:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A6883CF5;
	Fri,  3 Apr 2026 17:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Evd0fn9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFD18407E; Fri,  3 Apr 2026 17:41:24 +0200 (CEST)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c206::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAFA883642
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 17:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQVGkl7aPqTBEPPXQRZJPCD8ClK6KCR/P+7CvK/h0QXVXq8HBM4McCdMlzUcpqAE+Zj1O8VSxtrfs2PQbt017E3xtzb3QZkeNxM2RArngrp02Va1zqr0LcyAF1jk34dhSStr0EBhZEwYKxAyRTppVSwhcICLklhRc9nRaU/Brad3C3yHweFQTQGU9NldkZjP1+Oshh22CagZLsFyVyhqL/x/9/9CqODbDxRo+rOOLz+3pmqhMbh0jL0UBkhhkIWC1jPVKOARO7Fu4265uDwl7OOayHOtMj8ZdlBScAMpbArukEGEmS2RWV0xGnit8rJPtz8/4FinA5bCsm4mDCIl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suKmRE5IwctgtbuKKS+lYFJK6n2ZlZkQJ3u0bsfa45o=;
 b=Fcu6EmBI+4KcgCxUvovvoqaQUopg3zYhHqthZjSErU+jIbUe1ifRbb2iE+3TLYa8Oiu/6usAmyqzytYyBOAy0zBBY6QueaxNht7MqUxvoFxmII3qd5ErbfdNx50bkuauZ5Fn/wpVmx6QwOQlq7iZVxuOYvt60IllgTaoBfC0l0vyUMbOZ65EQqW+tD5vN7F2OLFCdzOMhF/utm7cyfGwTB5KSaPO6QxuVrUIjMSnGH9IOpMofb4ZgKMIxyd+TqQtLW2/ZWIIRVSXZugmt+fn5KnCpvGAJ6HCxC9NLmKvuhwRf94q5V5aeWWwiPDpqpu6OySfI5M3magQj79vf0yMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suKmRE5IwctgtbuKKS+lYFJK6n2ZlZkQJ3u0bsfa45o=;
 b=Evd0fn9vbR76IWEAszinvWMcQQubO29LKFQZpPrq/rSfVoULYnz2YbdGCrYMXNlIwKy3tvSHUnhF2TZF2lYA3BQrfNKp+zfLesx5GPlRrsqlqVn3dhJmdK9kWnPR9GyJuD3q83pa24MscKgaQVEZ0LbPCWknLzaG79i/RxDJEz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6357.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 3 Apr
 2026 15:41:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 15:41:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 16:41:19 +0100
Message-Id: <DHJMTRNSOX3S.2LQPF5ATDP78S@garyguo.net>
Cc: "Tom Rini" <trini@konsulko.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "David Zang" <davidzangcs@gmail.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>, "Adriano Cordova" <adrianox@gmail.com>, "Javier Tia"
 <javier.tia@linaro.org>, "Martyn Welch" <martyn.welch@collabora.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
From: "Gary Guo" <gary@garyguo.net>
To: "Simon Glass" <sjg@chromium.org>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260331191853.44549-1-gary@garyguo.net>
 <CAFLszTj-QRQBCZHNCyM6YR7n5M4+myr8ztDo6Xn9CfDb6=ppSA@mail.gmail.com>
In-Reply-To: <CAFLszTj-QRQBCZHNCyM6YR7n5M4+myr8ztDo6Xn9CfDb6=ppSA@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::29) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b70c941-19e3-4a18-93ef-08de919773eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gx/rB3bG+YVTOIT/Ye8iX6QWDr+SVYdx0VKSBdA6af6TzVRnM/PQk/rIwJT5qNafleHEhcR+vQ1V4nb9U0Hw50WRAgRoTza4Wo0EQIuGuQZsJq+SRWrOndp0LlUQAFH+n57TiFxFn9LtQAuN/cHfGSs2reHpD6NlnYQOUwQsRVCs6fYarac/cKQW8KpUUo35PrljUSwUjyXFYXxgATP7ThVhXiHuwFeCRB2xYJsAN7wfavZ0E55iqWTWgwnecfBHY4rwG7cR22UqN9j/piTsJJHTstppg1gWVqfDaK1NLqwU9ktLSkXzFjQcoz4c8rCMBNXMqS2aoPcI0tx7U2tU0ZoN64E1tndrsajfaVFWitUNPyVKJlYokbReSyPrhzcA1+OpRYmK7F+G46uKgVJyxnlEtnsVPyTHbYfv0pj7E4cETT32ZMRnXxmbz7pVjo9nPpAkCcv1PsmRwxJTaFoap2eJEDPCb6vic4lvlO73qeK08eeoYNzStAzpISzDV8ttLwv5HiOhCTnM4pVqfhnYOMs+3j8I2HhuPc7sQggqj8Yyx+xBXkZJFqs2lZ96ZMshqQKffIWneC/JuvlMd4zCPc9VJa5ys5L82/ICDqHhN72ZkBj9S7X0HhEz6rRyQdA/3aCjz/dconoiNnNaVnrbm4avXQK6JX+pRR6EWbkAMfxlOwvzRVkZ0Uyw4/mbzMdCm7+tQtM938FznZsWWDZrHdz2KDMJwVIq44mgfnyPKyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXBINitmSS9oU3lMUC8xak9hZ21tWktob2ViNnZYM1YvdmdlTW9FUkFGa0R3?=
 =?utf-8?B?ZGFMTXNmTlJ6ZFlMTVhzWGpqWEprNjBCUkNWYWNHd2ZIYWdOdVBxWGlHaHZa?=
 =?utf-8?B?U3R0RUQxMU5SZTlnRFNvL2RJcGFXYXlpYm1Mbk1uV0xPakFJdE9BRmI1ejFk?=
 =?utf-8?B?MGJZZFlCbHFDYmZmVXI3NWtTeUtLanNTdmxCVXBYYmhCbXh4M0JlSmtHT3g0?=
 =?utf-8?B?Z0dwMDNLL2E5dkFwcXBMTDNSSVpjRWxMa0NmZ1hkWmNmYlNQeWxIZG1EQjZZ?=
 =?utf-8?B?VjA1RHM1ZHRONmUrOFVyNHFvdjlOandEdlVoV005L3ZKWFQ2TzBtcURQTnk1?=
 =?utf-8?B?a2V3TWhpWE9nU1l4R01TMFRiemJ6M3BFVG5Ha1RmY3pKV3dUM1BzclZGZlVD?=
 =?utf-8?B?S2oxUnZScGRrQnlWRUJiYVBpRlJYenQ5VXZEY3Y4L3RHZitEeUFRWFZndk5y?=
 =?utf-8?B?OXlZekh2Y0RuSTQwRXhXcnV4eTN5QlF6UytUWEg2b1hmZC8vaU1tVlVsZFpW?=
 =?utf-8?B?ZjUzWTVxc1FLOGlwQ1o1d3hhSmcycU9qU2xNeE5xMUdmSkM3MFJ5NmJkclBq?=
 =?utf-8?B?UzFKK1JtcnN6aGl5ZEFKYjZHSjJBOXhjRSttNzdjRnNYQlB3ZUdzeDBYcFRV?=
 =?utf-8?B?anJvSE5XWmNsZDdTK1ovTkxyQ2d4TlVqQkVKb3F5YkV3VzB0SEZzclFlNHpi?=
 =?utf-8?B?SGVyVGZOa2J3ek8yQjFBWUY1R1o2ejcvNWh6UmI5V2xybHRIQUZ3Q3p1RE1q?=
 =?utf-8?B?VzhSRGl0SjZudkVqdHZWS1ZIcEE0K2tucGNnSEFuMUxDWmhTOWRCSWJXT3Vp?=
 =?utf-8?B?aDBNN3pESmhpbDlHZzVHT0VRR1lxWkdSZzVDS1NoVnBoSXVrRkVBK0pzb1dS?=
 =?utf-8?B?QWQwN0lua1RHdURTS21HNTR2QmRvOENqTGtkZUg2RG9NSFFpNWU5ZDBDLzhM?=
 =?utf-8?B?ZENtWmxyL0xoMkFlaDBGbGlHOUFpN1ZQQVgrdWdHV2V4c29DN2xYdmVnK2k2?=
 =?utf-8?B?WW9yUmJuQTczUzRnSkRkSWJ6M1NOeUlnZjVTd1BxVXVIYmFUeUJIcGcyWjhH?=
 =?utf-8?B?TVVpLzBZWURmRWY0VE4rczZJN3VKMnA2MHpKdVRIa21qVktGUHI5dWt5Rytk?=
 =?utf-8?B?M0J3eUxEVitRRkRQN3hja09ITzFUSG1vOXY2K0hDb0QxSVkxSjVUKy9EY0gx?=
 =?utf-8?B?OXdKZlJSdlpySzd0QnpobGw4U0ZpaTY0UWxhS0U4aVROaHVvZWJEMWJQcS9B?=
 =?utf-8?B?YmtnZ1ZUTFAyVEJ1aldaeUd2R3JEbE1QZitUeklrZVJ3V1Z6YVI3N2JteXZW?=
 =?utf-8?B?SlIxQ1NJaGEvNnhxU0pZSzVKZlY3Ui9oOWc2eUdCSEVqUjJ2Tm5Ld2RvU3ZF?=
 =?utf-8?B?eW1WVDBDU3ZVUGhYV0QvUjFkMU44OEZFd0MyNW5ueklVTldHenBjaG9yNnF6?=
 =?utf-8?B?SEhZYUFwQjRybHFVNEJJYUVaeWJLNGdaSDl0V045NFBtakZVM3d1V3FEK21p?=
 =?utf-8?B?VGlJNFN1WEVtMUtCcWFmK2gvTHVlNUtDUGFSeFZzdnhiMXB0cUtQVXlhM1Jn?=
 =?utf-8?B?d09oeTlKOWJWVTVxUXRIZHF4Mm9WMFE4S04ya1VqeEZmNHJzOWlROWlRSnU4?=
 =?utf-8?B?d2xERmJ5Tk1HWUthWCs0R1V6YmQySXhLT2dvamVINnlUMnlKRVh0TW8vcllJ?=
 =?utf-8?B?NEZkaDZCMVNvM0FXVFNMb0t6ZGs0SXdFazc5cXpLV1FvTGdtUXhVdFRnWFp1?=
 =?utf-8?B?RFlRdThHeStPTjJPVVcvWmZhSlB6a0NRNWsxcEtPK01ESDhVZENvVzZTUGc5?=
 =?utf-8?B?M1A4bEVzTmZBVE5mV1R6c0hJWHdYdVgrNjRQS0tKV1NKSWNsNG9rV2hlemFF?=
 =?utf-8?B?cjlVaXFQL3ozZFliUUhOUzNmRFp5RjRDVksrc2JBYm9EeDRqSXNtUXQvbmwr?=
 =?utf-8?B?T1hwSUFwSUtBenNWL2FiM0tiVFYyOEdkYWRyekpobW8zUWoxTzRZRGFSK2Vu?=
 =?utf-8?B?cHNQcG5VWjVoSTQvakZucEdOaXJyRkY1WnlwdXpjeUR0ckhFOUU3MlM3MUJY?=
 =?utf-8?B?cERIMjFhV0UyYTR3UDBMMHlzazZBUUlPeGxJei9BS1d0dXB6anhRc1dsUWgy?=
 =?utf-8?B?NFROYjFCT1dBQklVMVZjWElPWk41d09vTEpNK3NQdytka3R3di9adjJQMm4z?=
 =?utf-8?B?SjcwQ1lWVnFVNk5yV3VOUFRHcGpkQmtPVm0vNCt5bnVVTUt5WVhQcXQ5cFEw?=
 =?utf-8?B?M2c5a3M4dHlSMDdueGtzU3RVckhyQU9NNkEwNUp1TXJ3TmpJYzRJM01EUDlB?=
 =?utf-8?B?NXQyQmVTL1ZxYWNkM2NWQzFQcFh0VzFCR21VdnE2RXlYSytsL0pOdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b70c941-19e3-4a18-93ef-08de919773eb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 15:41:20.5129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4f5KHxkeYWhQERbOUqIF+Y9W2Y+2aB5qmTt9AWbZqZiCBUAtgo+n859aiT8XJcme0leoSZ5eXz6hCZ/qGklWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6357
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

On Fri Apr 3, 2026 at 2:22 PM BST, Simon Glass wrote:
> Hi Gary,
>
> On 2026-03-31T19:18:51, Gary Guo <gary@garyguo.net> wrote:
>> efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
>>
>> EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
>> indicating that the OS (or next stage bootloader) requests booting into
>> firmware UI instead of continuing autoboot process.
>>
>> Support it by having autoboot.c asking EFI bootmgr if boot should contin=
ue,
>> which checks and clear the bit (so the next boot continue as normal).
>>
>> With this change, systemd-boot will show a "Reboot Into Firmware Interfa=
ce"
>> option which will be able to drop back to u-boot. This can be useful if
>> bootdelay is configured to be -2.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
>> @@ -1290,6 +1290,51 @@ out:
>> +bool efi_should_abort_autoboot(void)
>> +{
>> +     efi_status_t ret;
>> +     u64 os_indications =3D 0x0;
>> +     efi_uintn_t size;
>> +     efi_status_t r;
>
> (I'm leaving the proper review to Ilias & Heinrich, this is just a few
> nits and a though)
>
> Please can you use a single variable name for both efi_status_t variables=
.

Ah, I think I copied the init part from somewhere else and forget to merge =
the
variable names.

I'll adjust the variable name in the next version after receiving more revi=
ews.

>
>> +     ret =3D efi_init_obj_list();
>> +     if (ret !=3D EFI_SUCCESS) {
>> +             log_err("Error: Cannot initialize UEFI sub-system, r =3D %=
lu\n",
>> +                     ret & ~EFI_ERROR_MASK);
>
> The log message says "r =3D " but prints ret. The similar message in
> efi_bootmgr_run() just prints the value without a prefix.

Sorry, what do you mean by "without a prefix"? I think the code is identica=
l to
the one in `efi_bootmgr_run`?

>
> I would also like to see the code which adjusts the variable placed in
> a function.

You mean the bit clearing part? What benefit does that provide, considering=
 that
this is just a single function call?

Thanks,
Gary
