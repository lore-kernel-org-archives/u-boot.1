Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAB8C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 08:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B3687CBC;
	Mon, 29 Jan 2024 09:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ju8lKd2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A73F587CBE; Mon, 29 Jan 2024 09:27:32 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96B6877E2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUNUMJ/Itth0tEawfxgQfumgVbJlM6R0iuR6Xni1dkmiwjRw4tSfmOOLt1LvQh0ipDB6GBTXwwWx1jhTcpObBXiwl4PdKyh2mEsvFek501M0fIkdd6eaEBzqQrDgLent5tyZOggb4QM281O0uDHn3Gs3KJDnijRDsuqH/25MYnpKHUs07tA6IGaKJFVBl+yX9LWZnUidm5vJYHOh0U3zMaVlizeKqI/DFMavqx+40Hr6g+1OhEy5lIevzDONIBCj/syxJ6gYYiYQHb0A8pycjDvB0y6UsrrH83FEe/MS5wp+NnL28SzOtfTAUMYjk0aR/H3PnG1HrheeRWjGyAR0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZFcJl5JWWoO2iEhAAWOMnkmRMp+FU8yOe2zuCaFyN8=;
 b=JrDfZ/PEG555KakApVI9NNGu5nb+EIEetoEbah19q6BEfTSxnECXBOhng7IWnAUU8nA7gePA2OmTjGGdn56h9T+nN577xJQ/4Jmy0tPzDXpfnIlf8MmX0Fw/LV4zHN0etWAIXUgr2lqNViDTd1Yfag4rrXhJvoHhuWCXQV15c+29aGNrwyvqXImisqpoIn80/1zBj/i5zWgFy9OLmi+Wy3yIIcAKLCgVnjGWKEH8baxvhC96/1VnELsN3Q3FqPfA/8DS3xijcH5vMuIsOKHOaWMd9z+S2qjeR5YiM7o58EWNnNCQX1C2FjHP+5QYpWUNUvcAv8U7/+VtIZvOJlMxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZFcJl5JWWoO2iEhAAWOMnkmRMp+FU8yOe2zuCaFyN8=;
 b=ju8lKd2LJ96VjDpGQI2pTStnyTeJ2a2CSwrE7BjTNcfu521FlEe3HEzv5RQBLCzlLbWvwk+PoFwQ5Pp6RSFcJo8Z8SJPKMSG2non5aJvFp1951i7tMpvuDa+9deDg63cwnnvQo19baNK22t+eKRfQYuzumjWArgOgxauYs0bgH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:27:26 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:27:26 +0000
Message-ID: <8aeb4ed9-bed5-4126-bed9-ab771f26e35b@amd.com>
Date: Mon, 29 Jan 2024 09:27:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader : Suppress error print message
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Bhumkar, Tejas Arvind" <tejas.arvind.bhumkar@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240122191242.2989327-1-tejas.arvind.bhumkar@amd.com>
 <CAC_iWjKEMs_0WHyu7ttfvP30vG=sJnhY5XWY=5hGBTAW_5oxyg@mail.gmail.com>
 <d2b79924-87bc-42a2-9d06-6fcba06ed267@gmx.de>
 <BL3PR12MB64505057156F40CDD884FB90D8742@BL3PR12MB6450.namprd12.prod.outlook.com>
 <d3f3fc7f-b29a-4503-9fe0-97468bbe1f71@gmx.de>
 <BL3PR12MB645027991850D2C0887FA80DD87F2@BL3PR12MB6450.namprd12.prod.outlook.com>
 <5fb62d66-3aad-475b-9175-86e53e06fde6@gmx.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5fb62d66-3aad-475b-9175-86e53e06fde6@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:803:64::35) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a6d5ac-03ec-4ac3-e075-08dc20a42005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUKOF1AVkIImU2DhoB0jX3lwML9VXjrMyodFbkX5AfaT1sGDrxCan5MBFxZBUXjGR/QvYRstHsk1oN1XkOVXgXNRH37sQH13FB8mHAuCYDhITPWEUXt80rijVYNtegeDunJsUFK8BnnLiHKhLrYUUz4fvfROPrfFtZsVhgdIkGGxfp07OeZe/4G+ZQcYgm/k/iauABvH1Nvrm5bXYhg10JHiX5KgR50FEXPsu6NecEXUQjN//W5U4KKbx8cywoC/L5dBEkpzU293uGvPCrPYosn7IS6H1/49gxKmnxUlN9M4osj7Z76L93l6SOEylngoEiIwvgIEGTRrRkvTe+RMdU3NHf0tlvcNHKcLKIHJNjfD/yy3RMXbJfFbSjvsrHHLtScigLVCRJUb0y0eGx0/nytM+lzUkqOSwzjRp3XSQmTiN0xdZl6iW2uBcknYFGwy02Fn/sjokOuF4+WSDOMIwCOoXQPDXo3AlY2cDVXarkWo9uV4NTWg+dnf8zz2rrU1mrUgQnVHQpa8kByOLrhN3IasUj83BBqiQ9yRIpmOsyeR1xzOXEZeN3Wpe6g3uWeqVub0mZgUh743o5KyRC7jKtDw+leprfpLkDYdZVQ6wVyoDNFTdldBnQ0XBL4IcccaIIvF1/rbear27m093Y08rlYvfoDYQmR3puv8ae2hNxa//TdfpF45rf/UnC1W27AV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(6512007)(2616005)(45080400002)(478600001)(53546011)(6506007)(6666004)(83380400001)(26005)(44832011)(4326008)(8676002)(8936002)(5660300002)(2906002)(15650500001)(966005)(6486002)(66556008)(66476007)(6636002)(54906003)(66946007)(316002)(31696002)(110136005)(86362001)(38100700002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEoyVjlzeTBQY0NSSlk0eVhqVitISlFpMHpUdzd4UGxBWXdocUV3bjRMdW5v?=
 =?utf-8?B?dWZ2Q0VGKzM2eEZNemZaV2NDTFN2d2R2STJJcEx3Qkw3dzBoLzVWdjh2OEw4?=
 =?utf-8?B?M1k2anBIMVVYMXFGTjBiVld5V3NKMmJ2ZU90bGFhakxlQmNwMDdBcFpaSi8w?=
 =?utf-8?B?ZmY4UWczY0p6TU5zZXQxZHNQZlZxbWthWml3dmU4NjA2dzBaNFlXdkdlSlJi?=
 =?utf-8?B?UnlITWZLdTJnTEF0RWIxTWRsTUUrd01qTWlEUXN1MnMzNTJuNHRHaFB5MG13?=
 =?utf-8?B?YzZqZ3Nkb2xaMmVxdlp5KzhCNXdtcXpBYkNPbnM5Y3hGajlaOTJYbWcveUhS?=
 =?utf-8?B?S3FjL0NaQUcybXRBNGhyQXh6b2lVUDgxTHJ6M2ZuMW5JcTVIanlpYVZNSHRr?=
 =?utf-8?B?eTVYYkwzc3k5VENmdVM0NUE3OGJqUmduR2xlRzB2M2NQOTc4TzQxelJOczZ2?=
 =?utf-8?B?KzRyNUdIMkJGSjRjeTFwNmE4dk9ha2hZU2c0TWNhaUUrbGpiQnhnRDkrZ0h6?=
 =?utf-8?B?Nis2N2JBYVlxTjEybldlNnEzNHhsL3JqaHVPY1ZXTElzNEFRVnR5eUN2bGdG?=
 =?utf-8?B?Z2pVbkEvazVxYnA3Q2djVEFRNGxRY2dISUc4YWtlOXVNbXB0OEN0Q3ZnUnps?=
 =?utf-8?B?TXJFZkJNaFdnRGtnYmtscHB3OTlNay90WmhaOTV0SEtpNEdtRStRTFU3UFdG?=
 =?utf-8?B?VnpBL0Z4L2t1WmpHM0g2VHljWWNLV3ZzL0l5K3VEY2xDQ29OWWhCQTc2K1dq?=
 =?utf-8?B?WEFQOEl1QlZsTjJQUmoyT0tPS1YzbHY1OGRZekhIK0d4L2Q0ZVBuUkpEUnFt?=
 =?utf-8?B?UjdNZWhzdnJMaUlEWjJsQXg0NXAzMll4YTZsR2RrUThUOUlYUGwzMFZ0L2N6?=
 =?utf-8?B?a0g0OW9BeENkSTlCZGNyWXVTR0VCWDlaK2JhT2JLUmtCWmNGRnVtOUpZemxO?=
 =?utf-8?B?SkVNQkhzeWhVdzJreXBQUDFZN1A5U0d0OHUzWkRzdGVrTVUvTnRnY3dpQXp4?=
 =?utf-8?B?cEs1WVVYS2NLVmdMcXBwMGhsMHdZWXQ4Y2xNKzJ1MENDUlhvc1V1NFVKR1dF?=
 =?utf-8?B?NEhqZ3U4QVJnVTdEbUpNL2ZKTEY2eVN0RkNUWHE5MzlyY1p2RDlXa0hCZGdS?=
 =?utf-8?B?SDJQTEtFRG5hcmtKQUdiMXRwY0tOQmttUldaTDBXSzNRcmoxSFRQbFRsVDFH?=
 =?utf-8?B?K0lxNVpqcEl0bW8rUXRBUnNQY042dVBMMEM2VERhZ0RNY3psNldPcVNzRUM0?=
 =?utf-8?B?ZUNiejBnYUFrWXJXTDFRWkJUQlRaVTNNd2dBUEk1cjRaWGJHU3lpMStIbjJR?=
 =?utf-8?B?M0JZemZVanNrRE9OcnhtK2ErVFgxTUwwT3EyengySldlWVFySmpydTE3N2Zs?=
 =?utf-8?B?VFZxMlRiTDd5YXkyVXh3bkg2M3IyQ0sxcDZiNnY5SHYzL0dPWUppaGlUeEdq?=
 =?utf-8?B?dVBPdzBGUnF4cmU0VTVrQitrZ2Z4Y3YzRXBLS0lzN1hEWnZ3bm1BSXVtY3Fp?=
 =?utf-8?B?M1JaNzd5bk1rZVBXOW5PQllZRG5WYytlYzRXSjdNR1ZQWnBOVkJBVXUzQ1Ax?=
 =?utf-8?B?T3V5aVo5QU5RNEtYYkQ5cVQ0YnQ3Tkp4K01TODI0cGFqYnArVVhEbUIvdzFX?=
 =?utf-8?B?b0Q3U0UyTXVycktJUDcrRDJDcFBlTVp3MXBDNHFDWWpHZ1p3MkVIVEhXY3d4?=
 =?utf-8?B?a01SZGE0eEtQbWMwTVErZjZIaGRRUEgrdlk4Q3VFMzRmWEdGVHVnbGtEay9N?=
 =?utf-8?B?VkE0RGVLVVFkREo1YzI4U21kNmU4VitaYm5oN3ZiVFVjQ2FGdWo4Yml2U2hl?=
 =?utf-8?B?aGZoWk9FQjE5Y0VGSGdZR2J3cWhWaXJycHZtdUdyWThWS2hZY05DVjd4OWxy?=
 =?utf-8?B?SXNZcXZXNnl0ZnlRU2ZKclVjQ1d4QTlqNk9wZHJQcHJ4NkVkQVdNZFRFNE1i?=
 =?utf-8?B?K1FoMFFNL3d5NXlJelp3UDVVU21lNmVMRG13YlNvcXpyWFJzdkdLUWZqcllr?=
 =?utf-8?B?djk2K1BEVjd3Y0NpUldiRGhRRTB3WXYyamZBQ2RnTGxDZWoxbDl1Uzg3QWVu?=
 =?utf-8?B?QVBQQzdUNkZUZTBnU0UwMzZWRm1VN05PSGpTQlV2RHNHalZta1FEVFZXODM0?=
 =?utf-8?Q?IzoZjKH+phwy2+JqNRdWAGeWi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a6d5ac-03ec-4ac3-e075-08dc20a42005
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 08:27:26.6174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKAH/V+kJJtNygALR/+T1GAzF7GBVy1snZKlXa/JQlXUEttXsOTqla3z6F+VxPl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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



On 1/28/24 10:20, Heinrich Schuchardt wrote:
> On 1/28/24 06:20, Bhumkar, Tejas Arvind wrote:
>> [AMD Official Use Only - General]
>>
>> Hi Heinrich,
>>
>>> -----Original Message-----
>>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Sent: Wednesday, January 24, 2024 2:09 AM
>>> To: Bhumkar, Tejas Arvind <tejas.arvind.bhumkar@amd.com>
>>> Cc: u-boot@lists.denx.de; trini@konsulko.com; sjg@chromium.org; Simek, Michal
>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com; Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org>
>>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>>
>>> Caution: This message originated from an External Source. Use proper caution
>>> when opening attachments, clicking links, or responding.
>>>
>>>
>>> On 1/23/24 19:53, Bhumkar, Tejas Arvind wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>> Hi Ilias & Heinrich,
>>>>
>>>>> -----Original Message-----
>>>>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>> Sent: Tuesday, January 23, 2024 3:30 PM
>>>>> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>; Bhumkar, Tejas
>>>>> Arvind <tejas.arvind.bhumkar@amd.com>
>>>>> Cc: u-boot@lists.denx.de; xypron.glpk@gmx.de; trini@konsulko.com;
>>>>> sjg@chromium.org; Simek, Michal <michal.simek@amd.com>; Abbarapu,
>>>>> Venkatesh <venkatesh.abbarapu@amd.com>; git@xilinx.com
>>>>> Subject: Re: [PATCH] efi_loader : Suppress error print message
>>>>>
>>>>> Caution: This message originated from an External Source. Use proper
>>>>> caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> On 1/23/24 09:33, Ilias Apalodimas wrote:
>>>>>> Hi Tejas,
>>>>>>
>>>>>> On Mon, 22 Jan 2024 at 21:12, Tejas Bhumkar
>>>>>> <tejas.arvind.bhumkar@amd.com> wrote:
>>>>>>>
>>>>>>> Currently, on certain Xilinx platforms, an issue has been
>>>>>>> identified, manifesting as follows:
>>>>>
>>>>> Hello Tejas,
>>>>>
>>>>> thank you for bringing forward this issue.
>>>>>
>>>>> Which defconfig are you relating to?
>>>>
>>>> [Tejas]:
>>>> Checking with xilinx_zynqmp_virt_defconfig
>>>>
>>>>>
>>>>>>>
>>>>>>> Starting kernel ...
>>>>>>>
>>>>>>> efi_free_pool: illegal free 0x0000000077830040
>>>>>>> efi_free_pool: illegal free 0x000000007782d040
>>>>>>> efi_free_pool: illegal free 0x000000007782c040
>>>>>>>
>>>>>>> The issue arises when the ramdisk image is relocated, placing it
>>>>>>> within the previously allocated EFI memory region( as EFI is
>>>>>>> established quite early in U-Boot).
>>>>>
>>>>> Which version of U-Boot are you on? Commit 06d514d77c37 ("lmb:
>>>>> consider EFI memory map") was meant to avoid such a situation.
>>>>
>>>> [Tejas] :
>>>> I'm verifying against the latest changes in the master branch. The
>>>> introduction of commit 06d514d77c37 ("lmb: consider EFI memory map")
>>>> has resolved the occurrence of the "efi_free_pool: illegal free"
>>>> error. but, it leads to a new error, as detailed in the following
>>>> patch:
>>>> https://lore.kernel.org/all/20230212150706.2967007-1-sjoerd@collabora.
>>>> com/
>>>
>>> Could you, please, try to reproduce your issues with origin/master as of 
>>> today and
>>> provide the full boot log. Please, also provide the output of the bdinfo and the
>>> printenv command as well as the sizes of the kernel and the RAM disk.
>>
>> [Tejas]: I've provided two logs: one obtained from the latest u-boot 
>> origin/master, resulting in the "ERROR: reserving fdt memory region failed" 
>> error, and the other from reverting commit 06d514d77c37 ("lmb: consider EFI 
>> memory map"), which leads to the "efi_free_pool: illegal free" error.
>>
>> Thank You,
>> Tejas.
> 
> Where can I find these logs?

They were attached but you can see them for example here.
https://lore.kernel.org/all/BL3PR12MB645027991850D2C0887FA80DD87F2@BL3PR12MB6450.namprd12.prod.outlook.com/

Thanks,
Michal
