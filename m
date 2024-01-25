Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8627C47422
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 09:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D635F8642A;
	Thu, 25 Jan 2024 10:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTQ03MH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A2F986FC9; Thu, 25 Jan 2024 10:08:05 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A34B83CF3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 10:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMGhV8or5EjuhxJOJvYPXxtJwaHf6Rpv2Q37mjnLK8kD9Z8zZG08FAhHZXSmbP42xe5wTtqBvahjKlSSMMlJx/umAQr4Shc+aHiLbHSHR12j7geokzoPe9k3N3YSMgui4LcScjC+b3JM5QdkNqNE49ipp6YW/NF3H1lxd/BAyvoca7TpH01V6OZ31WPoE6L20gWIBnpdiYrOKQX7iJZaZ8FtH8ZsChvqGtxfVsKaE7xw2s8Cwuw9a6PHPhjchHe8lUdDfEDw0WSSpdr627sxUi0EUpPTRiITmUScbkziaaoGRXV59bJhSO+7EDtPWQFo9nYSPXO2xInw8s4maYrmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7ROzQhZsAzO+ci2QvuTyEN5nMn5ajOfLD3ZzsWYC78=;
 b=VW5nSFVGVkFSFtb/GjFzkP7Lt4DD7UUu70acdGJvs/P+qCgXxk69wkyqkN82zwrzmCVBp7fWZfsnC9K1qFwuor/cyKnKcpZyWtVPS7j66t7SgVpjpblTGrg/xr5JmkgCrJ7UizTix+/CfXYut6E7vvvaoV9KBUNhEnRijocTAUHUu1vkS6v3cMxkdXjRxsK2WJa1ZgGAqi2EtiLjI5OmX4ADxspFfAji8Cvt3V08jQUqqDM7im1FsD59e9/hM6RxbN7VStAZI27OBMih3nLTqp8jU8AFwJP+uCUxLYcrW6ZsDetmi3+2y9V/23YVudvSxkftWKQEChX8zUV6vMqO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7ROzQhZsAzO+ci2QvuTyEN5nMn5ajOfLD3ZzsWYC78=;
 b=yTQ03MH2XXwm/0o32oIiLxIY3DAWNhFlVW/RnMwbbfwI1Y4nvT+c2fr7uXv4DDbdAuo9BrLsAVWfS8bST5xzBolMtTJh2MB6Nrdu2pnHdcQzW6TnVdvZeGbeJAEGdu/cZ/qFQHaHggyZW5GntSY1hUlAtgy1IL/1FY8rii8ru24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:07:58 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 09:07:58 +0000
Message-ID: <9d381972-3b86-4f3c-a0cc-23e6c1ae5157@amd.com>
Date: Thu, 25 Jan 2024 10:07:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: nand: arasan: Print warning for unsupported ecc
 modes
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 git@xilinx.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20240119053332.3145351-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240119053332.3145351-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0071.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::24) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: c32b2331-bfb6-4240-0d4c-08dc1d85200c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oG2J3WSUOuM4JnKO/3qP3hZ3S03amY+R84dTSWJaDFsNdn0ZZNPkhjI22YHEfck9RTcsk9j7YNswtCsBZQCyBvzsgndI8JbTwkBmgq/CD+2HexZpMIswCHr84O/v818GtW65ZbREEy3A75rKO3gqeAp1jVGhDN3gExbW08QY0MhqkHHO1+4fkikakXQ2kXgVAC7lKbryfm0hGvn5gKPe3bm+PyYaYTB/Mg8L+OJOUGzNSCApRE7ZkcHx+hKyTlPILM3/Xr9LL6AH0+RLPVIVkRm7jzGSJuwPM8YF5Ax3T9xlk3KsLK2810BBHbJGSED37FbGW0Gd42Jmt69LsqLfroV5upTHBo2LflVf3qsYiR9STeU/g1T2YPZGAcRoj3PLbx4trFOOUb4cJESq1+HEONZa9bNlBZ1p11i26nyK9l8y15MQMu0AafVfZndQ8akum0lP9n4Ct0Ru3cd4Wd2PiVz58qFCcmeEySGBF8Nvj1PppwD+F/ypG+yWiJkPFsHfk0gregstwQuGpKzHv+Dmd5PLgAfanbcFkdskyQrttUCOP5KO9BTnZQo57NrzeAX/TAm+QEyH/GcJWOW/9TzcqgixAtgeGrGN/sFjjKdy5BkdLWK96ecPWA48Jd3A4RZKLs0azV4WqSvqO/2s9HOTTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(8676002)(66946007)(66556008)(5660300002)(66476007)(316002)(6666004)(2616005)(8936002)(4326008)(44832011)(2906002)(6512007)(86362001)(6486002)(478600001)(6506007)(53546011)(36756003)(31696002)(38100700002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBNYVEvTytCTEsxM2RrR25XTzN5Y1d6SlhNV2xPcW4wVDRTTElOVmJnQzNh?=
 =?utf-8?B?bjJlR1lXMElBbi9wQ3kvUU5GQzc5U2loNUNtNysxbENSYUdFUi9UOEZrUklj?=
 =?utf-8?B?Y0JleldCeUJxeWpIV2ozYk5LcUdlcFp6Uk5rS2NUOUZCdjR3Mk94dVRlTHB3?=
 =?utf-8?B?WG1rZlBvbHE4UUI0UHo5VEswSmY1S2VaMEdIZVJSK2NZa21Xd21SMUVSb0RB?=
 =?utf-8?B?S3Y2Z1I2a0lBejdrOTUxeVY2ZFNMMGN4ZmpLS1BabFlUL0l3a1doa3FLWXZ5?=
 =?utf-8?B?c2xaRWpyc3RENDZjRTRCQVkwN1l1di8rakxTRGQvZ2Nma21YR0xsM014QXdO?=
 =?utf-8?B?V0EzZk5pdWlpZjFjaWw5SGNVU0hrNUV3Tk9JZ3ZUdHdrcHpDOUNQUHV2bHE4?=
 =?utf-8?B?ZlZ4YzNEOC85TW0yQ3l1TGtOU1AvM3Q1UGRldGJCbTVha0FFNkpDV1pXTjNC?=
 =?utf-8?B?NkJMMGg5ZWpYUTZVTjRPTlQ2QXpINkZTUkpXSkwxOCtjY1k3WCs0SFEwL1hC?=
 =?utf-8?B?MnpHTm1sZTdMUTZTK3RkK1o5QmRKMUhlMFNPT1JlWEhZYUhNcjcwczhKZWtp?=
 =?utf-8?B?Mkw0eFp4d0xGS3VoV2VSK0g1TUUrN09Sc2FSMlZkeXJSMG1PdkFUb2xZUU4y?=
 =?utf-8?B?cU54dGdYaGV3bHZVYkl3R2JhNENJb21wY0RTWUN1VUtSanh1cUx2YjVuZUEw?=
 =?utf-8?B?akFDdGtMaUJtaitCbzk3RXNxV0RJV3ZIRGxoelVxWGdzdWlJRnk2M2V4c2FN?=
 =?utf-8?B?a2ZzOUFCeWd2MVZPYlJpa2UzZS9xU0ozQnJsYlJtRjhJRDZuT1hkM0NFMHlx?=
 =?utf-8?B?UGMreEVxT011NlVWOVJWM1RMbmNlUFlOb3NpK2djQkZ0Y0FCdUozNHpOclJ6?=
 =?utf-8?B?dSt6LzEvRit3eTBtTWZ5NFd3TEhxR3ZOK1BKRUpoWWdaZnl4UzdTalFkMTU1?=
 =?utf-8?B?OHpPTDFsaGlKWlJob0NvZWJRNjNVbWhqZlY2SFYwcE92U0cybUZEVzRQUlhj?=
 =?utf-8?B?VHRvbGxZZ1FoaDlNWStudjdsUTJHaWtBeDdxN2pORHV3ckxOQXI2QWRPeXdn?=
 =?utf-8?B?bnZHclNBOWhtc1FscW1sN01hTEZsOG1LZEFTQUxidkRDa2dhUUlybGw0Tnk1?=
 =?utf-8?B?YVZ3M3p3REk4eVFvRTIwVTFjemVIejExVm1YNXY3ZU54eGZYR2lxZXdDNXVl?=
 =?utf-8?B?ZGdIalh0N3YxTm1YbkswdXBBZ2lDdk5HMm5kUzhuemcvb3pFRUNKSUdaL05y?=
 =?utf-8?B?SWdGUEkrM2gxeVp4WWJmZjEvMEFrUmlBQ2h1ZHFYK2srOVNSTnJpbXR6d3U3?=
 =?utf-8?B?YklSa3RicDc5QTR6SWNPdGJuWUoyMDcyZTZobDFvRHg1Ky84MW1ld0dVMExX?=
 =?utf-8?B?enJJOHJSY2F4VEdCQVduNVp0a2lJY3VLL0tSYyt0eS9yeDhtUUwxTXg4V0xE?=
 =?utf-8?B?WU8xN2JuWkNXUEtDRGlvRHNXd1l0cE1ldmo0bzdwQnFnd3lPSURnbDFTQnB6?=
 =?utf-8?B?QXc5SXlDUUljWjN1c09YVG9BbUpNWmFla1N6bEFpRFJZN3Z5RjU5WThrWW1K?=
 =?utf-8?B?ajRCaTcrL1dvZ0tuZzR5UmE5bFBKK3RMbjNZTlFVQ0k4SC9vZ3VhM0V6U2Vv?=
 =?utf-8?B?cnowTEZLaVE0dStSbDNuWkRCaEVFemFVS3NBTGRjN0pFazVKME5UcWRjOE9s?=
 =?utf-8?B?NW1OanZpR080c2hZbGlmVmJqQm52R1hFeElQMmd0YUtXZlloZDJodnNhdEhm?=
 =?utf-8?B?NmRaV04rbW5pUDJ2ZXFqMXBHbzdYa2ExbFUwSEZHNXV5Zk1IbDNOYXFXUGgv?=
 =?utf-8?B?R3Erb2R6MmRJYmZvL1JGYno3NFArYy93MDQ5WW1GNGtENHVGWkR2SFY4Tnpr?=
 =?utf-8?B?TFlHY2ZIdlpkVGd5eGtuejB2WTJ3ZTJDQ1dvczE5ckJhUndMZlk2Q0NobDFT?=
 =?utf-8?B?UzZLbzk2ZWlMRk1UY2xxYmtQcmVERXptVlNYSnlIMzJIdThOalJRMVBMbmp0?=
 =?utf-8?B?bkhYcXEzdXJqU1VRZ3pveTc3YXVPZjRVMlNjaWNiSElOTGdQd3UvMHRaSEpI?=
 =?utf-8?B?dTk4eEM5RlFCdVY1ZkxSRElRazI3di94NUk5bUEzWVQwUTBrTFRLeGxsUHhk?=
 =?utf-8?Q?dy04TbnyCzXhvGcwPrF1RHGF9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b2331-bfb6-4240-0d4c-08dc1d85200c
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:07:58.7138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZGaf8RzR/mHTjfeLgz0NpzCsmWYK5MedatZGK767XZun4sowefdmztK5s/7BIYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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



On 1/19/24 06:33, Venkatesh Yadav Abbarapu wrote:
> Currently only hw ecc is supported in U-Boot. If any other ecc mode is
> given in DT, it simply ignores and switches to hw ecc. So better print
> what is being done.
> 
> Revert this patch once soft ecc support is fixed in future.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Added the ecc mode check in the arasan driver itself.
> ---
>   drivers/mtd/nand/raw/arasan_nfc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
> index 14766401bf..8e5eef0881 100644
> --- a/drivers/mtd/nand/raw/arasan_nfc.c
> +++ b/drivers/mtd/nand/raw/arasan_nfc.c
> @@ -1233,6 +1233,7 @@ static int arasan_probe(struct udevice *dev)
>   	struct mtd_info *mtd;
>   	ofnode child;
>   	int err = -1;
> +	const char *str;
>   
>   	info->reg = dev_read_addr_ptr(dev);
>   	mtd = nand_to_mtd(nand_chip);
> @@ -1263,6 +1264,10 @@ static int arasan_probe(struct udevice *dev)
>   		goto fail;
>   	}
>   
> +	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
> +	if (strcmp(str, "hw"))
> +		printf("%s ecc is not supported, switch to hw ecc\n", str);
> +

Better to simply not continue if sw ecc is asked. DT can be for Linux itself and 
U-Boot shouldn't really break data inside it.
Printing information about it is IMHO good approach. Pretty much SW ECC is not 
available - skip driver probe or something like that is nice way how to describe it.

Thanks,
Michal

