Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED78107526C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 07:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7000B83BC7;
	Thu, 19 Mar 2026 08:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VyTKZTsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874E983BC8; Thu, 19 Mar 2026 08:12:50 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F332083AAB
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 08:12:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXW1jtVDqZC6H5XErtMJErA4H18Ncx/mLu/tqGu1fTBh9FETJ4bDUAntDNWydOFB80iGKqcUZ0QwPzLetE9w9n8nUzQbOeYYr6ddTxOC6b2HxlHHl8B3CE2sSOxwbK5QYnwXKlBGMjFVSGbMj1CMxkAYX+rmWvZq9c4E8Q/13mf7fh1UHl2x19udAGw66u8nkHh1Mlg/irnKeUtgMETxmTFz98RpT02slROfMmVgu4k23uLKI8z6dzih/Q/ufZnVQ9klK0vG8e4nYqMkngJNaVCw2qqgavEaqmQ5XXrDScREji1+We2wklz1Oy6rC8WGUuEz8xsnQhWn2d2YMnuFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsLlpzqB9jtLrIAjXl+XsgQVttAqFOB/8B0fEyP1uJ4=;
 b=pWslE77HgvtxTaZsJK7m9Cf2XlIzIgD7LKqMzNmHW+rWLv2i3Pu8E64Ucu4YQ5lOk2UlbziPEPBNPJaLW4Otyu/whyTFiIlegQ1BkcBVvM70Gi+6LDvYsLklm6DplMDXUmSRQJMWkDg8ubgH+npPtU5UOcpgnP+TWsFC9y96mIi0SaCqMcZyLh6mt293ciXBwU4Qw1FDvPdgpY+TdKE/xyyfX9kEgqEoqbSGNZJuJeUODbYeJ9p6CWUGeJ3Hv5BFL5NJkXhS6+IzPiJ9T/AeaKPGTdQkJoPxr1UaX5+Hfkw45K+XNrBtEGu8AQdquVMuk5/5eOiFFF+y0JZ9UevWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsLlpzqB9jtLrIAjXl+XsgQVttAqFOB/8B0fEyP1uJ4=;
 b=VyTKZTsRPJV/R0sJiAt6O8rIQk8cAcJvD2Jwo2t2R1n6AF7JlaUinwPXDObcS166424FaqcBHHZWwNQgNly1wakCLf7sSCoeOUB7bngFwrIptpKwwIG39ju/O5zFC4LC2yZcywKH4BTzjurwAAOewx/USgKUiFXjvuwlpQkMCAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 07:12:41 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 07:12:41 +0000
Message-ID: <485b47c8-33a6-444f-844b-6bd2f6af00f8@amd.com>
Date: Thu, 19 Mar 2026 08:12:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: efi_var_sf: Do not fail on blank SPI Flash
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, git@amd.com
Cc: John Toomey <john.toomey@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shantur Rathore <i@shantur.com>, Tom Rini <trini@konsulko.com>
References: <5309d3fda1bd6b8151358c3889525795f9e3aecd.1773852472.git.michal.simek@amd.com>
 <6A18CBEF-84A1-4021-91E2-B9BCE5AF13D6@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6A18CBEF-84A1-4021-91E2-B9BCE5AF13D6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: f83e1f74-f1e6-4527-4b21-08de8586e906
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: BbVU1mWIHZ3H4ANEEqnmKSXuRBncXELJm5zcns8z83QzdGiEDVlcOweufCTPLjEFCQL+gSGWntpBm/WYovReOeRghJdLgTY1HsXQL+LHL5zZ1z4kR35hI/aDxNx0Gkm2eZh+kpvdS7w7MmQBYKqMV4BzgOsErEEo9Jk5ajlNbFrjW1c4SrgJRv/Xrpy2/4Re5i29IgsVioNrsHRpe/j2FkP4Jgz6S8wBwnm+YAtgTC0mYuqT0Pxn0Z5QROK9nbS6GNGT3yKz59VGG1QsLxn2YNt/dJpcCszO8ZOJ/61sQSDOKTPmU30oW1Xvnfi9vIOciGM9A7V5+AsdRY46b06t46B2Bis+Qskh+G5Nyqtq9BPiFyIAaFxKzgEM0bJWlRr5XQQrIdHk239Tb9GPZnLzaEYobCBhm5HWRBRQd3kPIJFtusOgiDg99b1iaNrYr7WzUHbksi6ZollUQaLcu1fefX3cqAcPCaU0u1msajoz5QyrG+UAli68UFh60G8pzicMbaWPzUCVqxJJg5DR+gFb8qwkq6bGouN1PCtx5iAaKGKtA/IXCAu+5PAdz/Glaf2csnVMHbn1vuoO7IbncH0fqVDeah1bH992/Ry4Nga4ca26eCB/n06zj0UWLnT3n9t9fbOWV6U4y37TxMlGEEH83rJKAF/tNoio4QoWBrd1IVQWWZ8IzZ8e+LmYYKy7gl2Ei4ZZyFKT1bdVfTlR/hE3ltpUC3EbfLI20bjctzsuLZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHl0MTVHK2tsWktwYm0rMFZzM2dvK2ErWm9UTEppOXNiTlpyb3phL0pydThQ?=
 =?utf-8?B?akY5MU1WTVVWWVFZQytQeWhtWUNjRk9WZnR5SUhDaEJ1Wmd0ODlLblludWM5?=
 =?utf-8?B?b0dBQU1yTkFuSHVENHYxcnN6eVF0TEJIUmp5emFPNkp6NDdNZWtsaEFNUlph?=
 =?utf-8?B?bFZpOGVBNlluUzNhNUs2cGpVK284M0h3Z1ROamQ1MTBtQjZsa1JXeFhUSzNV?=
 =?utf-8?B?Ui94Nkh3NjRRSjNYZzllUzdzL2g2OE9lK0p0cTRMak1Cb0hIZjJ2SDllUW5V?=
 =?utf-8?B?dUMzYklsalplVkhUYmY3Uld3QU5FR2MzVkpYV0RUYm13VEtJOE1kYlJkTDR0?=
 =?utf-8?B?SjZ3RjFkVEp4NHZscDN3MDVEVWVKRGh3NlpEWlozSkE4c0g3MWI5T0ZrT2NO?=
 =?utf-8?B?Q0ltWHd4LzFnR09PMHNNbjJBS2NWdjFMdDl5eC9lUVBFdVZrUmdURWg5V3lB?=
 =?utf-8?B?OFFoeXg5b2NRZWppS1l6R1hkZVFIQk9TbGY2MDl0WStMenYxbjJtdmlEVlJ3?=
 =?utf-8?B?QkxKRFRqY3EyN3p4UnU2bkQ5ekNYWGhRWFhEUUpudEJIWEUvYm9qeFpOVzV4?=
 =?utf-8?B?TDBaUVE2OVZNLzhnUmdzelR2Vng5RGtZYzNvdklES1lJUXRSa2MzZEpHRFd6?=
 =?utf-8?B?clovT1RwdjJDTS9JVG9md1B0NHh4cWNXRi80THJtU24rNTRrQjJXdWJvUE9W?=
 =?utf-8?B?eHoxNDcwb0phQ2s1cm81WFhmdVowRVlYamlaZGVvRG1GeVUzbE92S2xxMkFE?=
 =?utf-8?B?VTllZVBYNzZ2eGVPNDMvL1EvaktHRlFlT1BaaVVQMSswUi9reWZPbmkzYkdx?=
 =?utf-8?B?TmVHQzNuNStCbWd1UHczaUZUaGNrYi9Tb3NiRjZlY0JvbWtjTEgzNDJ6Qlhk?=
 =?utf-8?B?ZUJGb2JVSVAxVC9JUEI4MGNKR2FuQWRkTWxrSlRBMjV2ZTJpcDd1WUUvaWFH?=
 =?utf-8?B?RjlrTit6UG01aU1OcmJDVFFOQi9jMGRsMXh3MFQyNG1YNnJuM1lIQk5iYXRz?=
 =?utf-8?B?MWlscTNJWXNXSzlsRGN5NG1pV2pXS0RVei9Ha1ZSTFpLMlNOMUZIT1dUclJE?=
 =?utf-8?B?N0VWU2h5cFo0SlV1NzQrRWQ2cmU2OHVWeEhKdk50MU5NWWlZT3ZPWFRneTZq?=
 =?utf-8?B?SXU1WHNUYlcySmhHRzF0NXkwMkQ0dEZnNU9FcEZ3cWRnT0Flbld5WncrZHFj?=
 =?utf-8?B?UmZzQ2dOdFl2NE45V2ZWelI0bnpPM2lVOFJrNnRrTWFyelFOSUxrR2VuZlNF?=
 =?utf-8?B?OUR6UCt0M09RanR6VnFBdExTWEErWTJ0eGZ3Tlg1L2JzdEVMb2NMbjZPckpR?=
 =?utf-8?B?citJSDBjVmtGN1hPZHdrWTVpS3RTS1VLVEtHNXJjQmtVMEV0c25UejJGYkhl?=
 =?utf-8?B?RThES21LTkJjZWt3WG5CbzBHbXFycG0vcUZLS1VKRmY0NmpBTjFoOW5tRzlS?=
 =?utf-8?B?NGhLTkNHWEN4VTA3V2FRMmw5OVZZbVhqaWhTMUZmVHNLNXVzK0U4MldLZVRL?=
 =?utf-8?B?QkZBTHN5MXp4R01EWEpKMHhRYUlCWDZ4RVIvY1AvRVB3WUcrMjZYZG5vd0h6?=
 =?utf-8?B?Yysyby9GWlJMdmtqbkJ1Zk9TZ29QaWJ5UEVLeDE5VDNaVUVKUWhENm9OZHZT?=
 =?utf-8?B?T3RjR1VtVHhuKzVYMVB0RDJ6RzlSYm9qdXk4WnEyclNpd2RFbzNKYXFPMjBo?=
 =?utf-8?B?K08weVQ4b1R2UFVlaEZxZjM1WHhXZDVZT0tLTjdXZ2FuWTFtME5CRFZmNTBT?=
 =?utf-8?B?SVpDUDY1T01hVElEYzZwRFZlaEFaay9iZmdYeXZjUDhOVTN0MUZOQ1Nub1dq?=
 =?utf-8?B?YjlnWjd1RmJZbGJJNnJLd1FnMTd5WDBOblpCK3l1Z1drMjlsNTBNQjdLZElO?=
 =?utf-8?B?c3QwQnh3MXdJLzVGS1Bka1YwUTFOcTlFcTRCSERHbC9JVjFVdjFzR1NBSnRV?=
 =?utf-8?B?UU9aazJPNmNRcUg1R2xHNjFuaDVWbDlUenN0WFhidTNocWhBV3lCaWIwbDFv?=
 =?utf-8?B?T3dHUHBhV0JBWm9vMlh4NmZ2N1NyNEFNcUE0akVNSDlGcjB5ZE43ZnEzZ0JT?=
 =?utf-8?B?SGpuVFB2cTVhZk1VZk0vSDVRM0NjZ3Uycjhsa0hmRE5JeVlobUpKRVNlelhV?=
 =?utf-8?B?VmxhUVVjQTBhSmdBRFZFengyY2pQUWtNZk1lNTZuN2ZJUk4zczJlUjd3SXk1?=
 =?utf-8?B?ZFpGdmlBQStzckxYMStjbnN3eEdlVVN2NjJ0MkdNWk1CVHNkSi9OWGhGTVo5?=
 =?utf-8?B?cUNDNytlb0x6bXQ1dXRXQ3Mzazd4TncrOEFKTDBTcVFBKytFYWdVanR5dWE2?=
 =?utf-8?B?Mk5sclkwZEhORXlackJRZFdaN0VUd3RUZytHRytBcWJIZkVORTBLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83e1f74-f1e6-4527-4b21-08de8586e906
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:12:41.5751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0v1qJAaVnbtCLv92A3evUQiOmUXxZu3lUbNbqOTrbkI+M9rRsdSQINDQTuduMTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628
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



On 3/18/26 20:59, Heinrich Schuchardt wrote:
> Am 18. März 2026 17:47:54 MEZ schrieb Michal Simek <michal.simek@amd.com>:
>> When SPI Flash is blank (first boot or erased), efi_var_from_storage()
>> returns EFI_DEVICE_ERROR because efi_var_restore() fails on invalid
>> magic/CRC. This prevents the EFI subsystem from initializing.
>>
>> Check the magic value before attempting to restore variables. If
>> the magic does not match EFI_VAR_FILE_MAGIC, treat it as an empty
>> store and return EFI_SUCCESS, matching the behavior of the file-based
>> efi_var_file.c which deliberately returns EFI_SUCCESS on missing or
>> corrupted variable files to avoid blocking the boot process.
>>
>> Similarly, if the magic matches but efi_var_restore() fails (e.g.
>> corrupted CRC), log the error but still return EFI_SUCCESS.
>>
>> Suggested-by: John Toomey <john.toomey@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> lib/efi_loader/efi_var_sf.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
>> index 6eae8d464645..a1dc81e17434 100644
>> --- a/lib/efi_loader/efi_var_sf.c
>> +++ b/lib/efi_loader/efi_var_sf.c
>> @@ -98,12 +98,15 @@ efi_status_t efi_var_from_storage(void)
>> 		goto error;
>> 	}
>>
>> -	if (efi_var_restore(buf, false) != EFI_SUCCESS) {
>> -		log_err("No valid EFI variables in SPI Flash\n");
>> -		ret = EFI_DEVICE_ERROR;
>> +	if (buf->magic != EFI_VAR_FILE_MAGIC) {
>> +		log_info("No EFI variables in SPI Flash\n")
> 
> If the SPI flash is erased, I would expect magic == 0. A incorrect non-zero magic is similar to an incorrect crc32.
> 
> If magic == 0 is an expected state, why write a non-debug message?

Erased flash is 0xffffffff. Log below.

And yes I can remove that above check completely because it is the part of 
efi_var_restore() anyway.

> 
>> +		ret = EFI_SUCCESS;
>> 		goto error;
>> 	}
>>
>> +	if (efi_var_restore(buf, false) != EFI_SUCCESS)
> 
> Yes, we must always return EFI_SUCESS.

M


ZynqMP> mtd list
List of MTD devices:
* nor0
   - device: flash@0
   - parent: spi@ff0f0000
   - driver: jedec_spi_nor
   - path: /axi/spi@ff0f0000/flash@0
   - type: NOR flash
   - block size: 0x10000 bytes
   - min I/O: 0x1 bytes
   - 0x000000000000-0x000004000000 : "nor0"
	  - 0x000000000000-0x000000080000 : "Image Selector"
	  - 0x000000080000-0x000000100000 : "Image Selector Golden"
	  - 0x000000100000-0x000000120000 : "Persistent Register"
	  - 0x000000120000-0x000000140000 : "Persistent Register Backup"
	  - 0x000000140000-0x000000200000 : "Open_1"
	  - 0x000000200000-0x000000f00000 : "Image A (FSBL, PMU, ATF, U-Boot)"
	  - 0x000000f00000-0x000000f80000 : "ImgSel Image A Catch"
	  - 0x000000f80000-0x000001c80000 : "Image B (FSBL, PMU, ATF, U-Boot)"
	  - 0x000001c80000-0x000001d00000 : "ImgSel Image B Catch"
	  - 0x000001d00000-0x000001e00000 : "Open_2"
	  - 0x000001e00000-0x000002000000 : "Recovery Image"
	  - 0x000002000000-0x000002200000 : "Recovery Image Backup"
	  - 0x000002200000-0x000002220000 : "U-Boot storage variables"
	  - 0x000002220000-0x000002240000 : "U-Boot storage variables backup"
	  - 0x000002240000-0x000002280000 : "SHA256"
	  - 0x000002280000-0x0000022a0000 : "Secure OS Storage"
	  - 0x0000022a0000-0x000004000000 : "User"
ZynqMP> mtd erase User
Erasing 0x00000000 ... 0x01d5ffff (470 eraseblock(s))
ZynqMP> mtd read User 10000000 0 1000
Reading 4096 byte(s) at offset 0x00000000
ZynqMP> md 10000000
10000000: ffffffff ffffffff ffffffff ffffffff  ................
10000010: ffffffff ffffffff ffffffff ffffffff  ................
10000020: ffffffff ffffffff ffffffff ffffffff  ................
10000030: ffffffff ffffffff ffffffff ffffffff  ................
10000040: ffffffff ffffffff ffffffff ffffffff  ................
10000050: ffffffff ffffffff ffffffff ffffffff  ................
10000060: ffffffff ffffffff ffffffff ffffffff  ................

ZynqMP> pri -e
No EFI variables in SPI Flash
SecureBoot:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x1
     00000000: 00                                               .
SetupMode:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x1
     00000000: 01                                               .
AuditMode:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x1
     00000000: 00                                               .
DeployedMode:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x1
     00000000: 00                                               .
VendorKeys:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x1
     00000000: 00                                               .
Boot0000:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     NV|BS|RT, DataSize = 0xb0
     00000000: 01 00 00 00 8e 00 75 00 73 00 62 00 20 00 30 00  ......u.s.b. .0.
     00000010: 00 00 01 04 1c 00 b9 73 1d e6 84 a3 cc 4a ae ab  .......s.....J..
     00000020: 82 e8 28 f3 62 8b 00 00 00 00 00 00 00 00 01 04  ..(.b...........
     00000030: 1c 00 b9 73 1d e6 84 a3 cc 4a ae ab 82 e8 28 f3  ...s.....J....(.
     00000040: 62 8b 72 00 00 00 00 00 00 00 01 04 1c 00 b9 73  b.r............s
     00000050: 1d e6 84 a3 cc 4a ae ab 82 e8 28 f3 62 8b 51 00  .....J....(.b.Q.
     00000060: 00 00 01 00 00 00 01 04 1c 00 b9 73 1d e6 84 a3  ...........s....
     00000070: cc 4a ae ab 82 e8 28 f3 62 8b 83 00 00 00 02 00  .J....(.b.......
     00000080: 00 00 03 05 06 00 00 00 03 05 06 00 01 00 03 05  ................
     00000090: 06 00 01 00 01 05 08 00 00 00 00 00 7f ff 04 00  ................
     000000a0: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2  N.....YM....R,Y.
BootOrder:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     NV|BS|RT, DataSize = 0x2
     00000000: 00 00                                            ..
PlatformLangCodes:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x6
     00000000: 65 6e 2d 55 53 00                                en-US.
PlatformLang:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     NV|BS|RT, DataSize = 0x6
     00000000: 65 6e 2d 55 53 00                                en-US.
OsIndicationsSupported:
     8be4df61-93ca-11d2-aa0d-00e098032b8c (EFI_GLOBAL_VARIABLE_GUID)
     BS|RT|RO, DataSize = 0x8
     00000000: 1c 00 00 00 00 00 00 00                          ........
CapsuleMax:
     39b68c46-f7fb-441b-b6ec-16b0f69821f3 (39b68c46-f7fb-441b-b6ec-16b0f69821f3)
     BS|RT|RO, DataSize = 0x16
     00000000: 43 00 61 00 70 00 73 00 75 00 6c 00 65 00 30 00  C.a.p.s.u.l.e.0.
     00000010: 30 00 30 00 46 00                                0.0.F.
ZynqMP> mtd read User 10000000 0 1000
Reading 4096 byte(s) at offset 0x00000000
ZynqMP> md 10000000
10000000: 00000000 00000000 66456255 01615669  ........UbEfiVa.
10000010: 00000178 dc88842b 000000b0 00000007  x...+...........
10000020: 00000000 00000000 8be4df61 11d293ca  ........a.......
10000030: e0000daa 8c2b0398 006f0042 0074006f  ......+.B.o.o.t.
10000040: 00300030 00300030 00010000 008e0000  0.0.0.0.........
10000050: 00730075 00200062 00000030 001c0401  u.s.b. .0.......
10000060: e61d73b9 4acca384 e882abae 8b62f328  .s.....J....(.b.
10000070: 00000000 00000000 001c0401 e61d73b9  .............s..
10000080: 4acca384 e882abae 8b62f328 00000072  ...J....(.b.r...
10000090: 00000000 001c0401 e61d73b9 4acca384  .........s.....J
100000a0: e882abae 8b62f328 00000051 00000001  ....(.b.Q.......
100000b0: 001c0401 e61d73b9 4acca384 e882abae  .....s.....J....



