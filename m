Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61793CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6DC88139;
	Tue,  2 Apr 2024 15:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHUd/A8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C064A88137; Tue,  2 Apr 2024 15:07:48 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CF788140
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo4qKBz5LsWEYh1is2z9jnGaNlsNVBWir1OMZoIvzHSs7vLo2sdgKhX7OSXDD1WoJEKA0XHeERlCW8stY9jYBizrBOkmU7B5tXK1oTWr84foEouJQK/EsDtu32Kh4HBYMDzmPRRpMe5/8EMwTu67INzJbPOKqzzIPUJQDBDUSZ9MA49W44nYvYmlVGs/2RQHwypRlLswATwKqYJlqsqwoATkD/ukPnU4my3pctrJGHMGr/qqbMEEL+4h6niaWSmoNraMYkI2cnLIU4agwW7RZsT6MwfxOHVS9i3XXx1w9S82nBJW29LaavnAtIwgKGd9yLcT3oTyV4xaoSioc0zYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dApFlXofeU9bGv0uczFkUA7YfnwzZJTNtGjEsGm7XO8=;
 b=RKh29dN9CzflR+yuSAmcS6ZgMbpHs6LYyITB9hOD/JTUBV7NR7WWDJr3Quy9SlcWvsJ0e8QIVKDdgXLIEzM7aLCShcgFTkRpTWWUVtDsWMg4AMV2IiMUoNgsNBaTfZs2uvqTktrXBkXcyeI2iIjrbR1oGoTSXqCOSxLvdkMANoxjbdsPThWD2+8UddTwHe2zhBmZ3aeyYjYz4R5fVvwGkzqfJj64j1Wl2f9P2IQoogyzkdD+zQm6lMu5bsQoHkrC6e5zyVbJmagQryMZbdFmo80FXlsfFr/d0u6vmx8U563UJ7/KJfD67/Hm/NWPYdM/O9oqOqcf17nXy6S0u3xTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dApFlXofeU9bGv0uczFkUA7YfnwzZJTNtGjEsGm7XO8=;
 b=rHUd/A8I/2bjTIvD3QkTRDreg9bXrzbUsM4k8jkeS/2fvGBxBptWnqe2xNsK5gmLfDbUfdJU8wOuXK/Ed2ojwpEkjVNy0P8FMH8fbvNMoFSfmDmqyFUCodREvru7Z+jbSPSQUa/j9u8VQ5AZeQlqZbWSNO4aVfvHJkIYpCqCIzg=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:07:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:07:41 +0000
Message-ID: <5d7b97fb-e0a3-4f79-a99d-812a74e8b286@amd.com>
Date: Tue, 2 Apr 2024 15:07:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Do not call private env_get_location() when
 !ENV_IS_NOWHERE
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 "Polak, Leszek" <LPolak@arri.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <830b9c93d30688cfa8a5cbb0388e79deb7731f29.1711107795.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <830b9c93d30688cfa8a5cbb0388e79deb7731f29.1711107795.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDi2LeAszfR5Mr81TiToGDUN/GIPhQ959PuLyQ3o030S5U1rZZMMToEy+M99uu6oW/CNI6xwZ+ub6u7gDa2gIq58iSBuzx9ToAvHttee0+7bUjd7fTJKgPsoWebam/bzQPn8GMWwSUSaA+Gn+aOV9nAa/WjTKAjeiOG77Py90WgGZqsQD/RpXWfdawY84zoM5cciQ+eapkawHbsMpnMbJKWuqerM+hSdVB8x73I6MpgaJbpowwY9dQu4dK5aawwuQrduuis1kGJmWEsdgUIcjpCeh/RhratvjMMhYB9cFPbcBIW0wsajJnwtJGqO0h+u+jTC8iSsAkuxhZw/Z6gwUcZ2Gycr3Hs1cWOZZ3jEihwKfmPdsH0dP62xyReFWYSYoD2+/QGSKMzMgIDuuGxZ12vJd14EygoazalxjsVpDUzfPkMIjIHTh6BvgTprdknHY+otEiu/a+cdqG3pN2tDBDl6mpYq6X7S1hGjZ1/+QlW50enQGOl2NQuPk5dNE5V6Fww7QDKBb3kH3HoboD+8XOHrPsFjin1fqtrhFMXEqLbXtqT4GVdb+j/UcX25/W5oWtkZMUTul6Hy4zOIDvboW0yB5YYw6iI7W6KjAi/NGeDE3aY8QUVPJCYpH1JWwtefOJLzCR5UDTr8/F9aYc1klnIDNQ41OCeQeCeF5LjsoUM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGU2V0ptUTJUa0FLZTB2MkphcnJZTEdKY3NuU3laV2hjR2Y5cTdwbkJnb2VS?=
 =?utf-8?B?Yng3QTFZT2NPUmtQeE1IMGRtL2dXN2hkKzAxMTYrelhYMlJqdWNVWXNrdTVN?=
 =?utf-8?B?bEd0MlZEeEQ5ZnluakF0OEovdlg4YXhxem8xVDVDWjNxMkdZNFN3c1RDaXpo?=
 =?utf-8?B?bWk0UkFvSk95d3Rzd1p2UWNwK21wdWl2elB3T0MzRFFTcWR3SGVKZjBCVHRY?=
 =?utf-8?B?RmlOWHVLTGVIcDFxWHhSRE1NRm1aRHNzaS9lU1F5TzFOM1Y1V1AxMHVtdGRY?=
 =?utf-8?B?WlozR05QYkhIR0FhVWN5OGplV2Y0TXRtZ3d2TDhsWFY5U0hGWkM4MWJ2ZWk5?=
 =?utf-8?B?Vmd4aEpoMW1taFUyL2pZRCsvSzhzdHBhdG1PY1RSUURralhsTHhiVWdsMnF3?=
 =?utf-8?B?MldCcVNIbVF4clpjby9IQnhxTEhjcjZRcmt2ZVBvQkJMMGZIb2pxRDVZWkgv?=
 =?utf-8?B?SUNyYWVHeUtqb2NvRVBSbjVBdTAxeTZsZEs4dUc3OXUxWEZacG1PYjVkWVB5?=
 =?utf-8?B?eU5zZlVWYmg4VDdXOXl4RDlqbStLOVhKdGJjZVRmcnpFNmdlZTJ3dHFaZnpB?=
 =?utf-8?B?a05rZ3lnd2ZFWTBubkRNVzlFWWo0cVNqYVRPM1ZQc0NJZUgwYkFzTHU2My9z?=
 =?utf-8?B?aGJUQitoUi9GbUFvQ1ZDUHl2VThZaWkrSlRyeC9iNy9aMzR3b3JHRTRsa2hW?=
 =?utf-8?B?aDZMOUlnUDNsczduOTloNDBjc0V1bFZ0NjBPV25vdW9xVHl5ZytNcVhXczlq?=
 =?utf-8?B?SFhhaXdRMUk0Qk9ZV1FLV1c1OTF0K0dzSXVST2IxUll1c3Bjb2piTGNOOXVl?=
 =?utf-8?B?MHcwSlVNWmY5bTk5VTh0V2dFVnk4b1V6MWVxYS82V3ZJaFFNYkNXQWdnay84?=
 =?utf-8?B?VHg1aGNKbllJSFlZZDlBUUNtOVBkZTFXMkZ4TFZiSXZad3BQZU5BRFlYQUJ0?=
 =?utf-8?B?WWNYMWZUMk8wejcrczJkMVU0MS90Nnh0UHkzdXp5RWROTTQ3cFRpNER5QzdZ?=
 =?utf-8?B?L0lBbjJ1Zjg4TmREMm5VemNyTHVlVGhvNVRuU3RsbEh1aXY3VHlrQjhlMUtS?=
 =?utf-8?B?TXM1MXVKRTU3RCtIMW9lYWFQN1FsZXhJd3pBdzRjam1IMHErWW5payt5bUdK?=
 =?utf-8?B?dTNEdW4wc05tdHE2bVRrQnhkdGVLREcxRkNKY1JLRk8weHRHTlNtVTZVUmpB?=
 =?utf-8?B?Qjd1ZGp3VTVkcWF6TWNMZGJnaklSbXJPNGVKeXFTYktrZXhZaW5TUlI2MVpm?=
 =?utf-8?B?TnJUMms5R0ppUEUwbGVTaVo2ckpXWERzckNEQWRXYjE2QzMrM0NYc0NwNDh5?=
 =?utf-8?B?emN1SWtQYjFOVi9KVFlBcEdPYklob0ZwRzBXRC9adXJ0OUx5cCtDTlJEK0Zs?=
 =?utf-8?B?WXhpMndvdzBTajZodlpvOHRkR29nd1Q5MGZ6K01XRi9aOGpMNFhzcGxkWVRJ?=
 =?utf-8?B?QmgvdmFRQ2ZIaTk5bHZCS0xqWjJhUWFYL3VFNTBsSjFnSFB6T1JFTldRVzdy?=
 =?utf-8?B?ejUyYzdkdFo1RkZOM0dhZnBHT3BCQURpVmZHZU9QNzZnZFFGMk5zOXFMU283?=
 =?utf-8?B?OGhEMDRCMWEybWEyZTcyQ1UxcFhzOXZBOGRDc0JSWm4vYWtxYU1oNERZU1J0?=
 =?utf-8?B?eVJVRGUyU1I1NUlML1lHbmI1V1pNaTN4Ry9xSHZOZ2k2cUpsWU1OV3lNMTZw?=
 =?utf-8?B?QjB2K0E0cHZwU2luL2RnSXZ6YzBkQjNKUlZ3aWtwY3gxWFVYS0hOQy9vWG5o?=
 =?utf-8?B?UnhFeWhrRVZOTlMrTHlOSkJiWlRTZk5NL2FTQXo5OHdCSWRKSUdBSWVNb1pH?=
 =?utf-8?B?bFE4Y09vNWMyU0krdXQyZHRFTEVYR2t0TG1ZNFNDQ2FFK0syay9JajVzNWJo?=
 =?utf-8?B?eXNGdVQ4eGpSU2E2ZDI3Q3JsZXc4U1R1MmNIc1dkOU5qaEM4U2lRUG83QXo4?=
 =?utf-8?B?S1RzNUppU1NIcktDcFJmcHltSy9KMDhUY0JKN2RYK1BDeEtWeDVUYitPdkM3?=
 =?utf-8?B?d1FRdjZ1MjVyczRtUnZrWmZXYXhqS2x1clByUUNQdFc0NGd4bVBkMzlqekVB?=
 =?utf-8?B?UjdOekoydTNUbXhES2V3STRqa2EydmhTajAzVldTQURTMDdJWG9LQWhnOEhi?=
 =?utf-8?Q?TUWcZh8lTypRY3//GOWi4M/Dl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df64310-46f1-4ee3-d17a-08dc5315e123
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:07:41.9024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqyqVrwYrk1nh7eTuRDBZIMHCz5RM8X4fY6BR5nFH9q63XAt0bIm5JCTVkGEZwJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836
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



On 3/22/24 12:43, Michal Simek wrote:
> Private function for finding out location of environment is not working
> when ENV_IS_NOWHERE is disabled.
> The reason is that current fallback is ENVL_UNKNOWN when
> CONFIG_ENV_IS_NOWHERE is not enabled. The code could be updated like this
> 
> -               return ENVL_NOWHERE;
> +               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> +                       return ENVL_NOWHERE;
> +               return ENVL_UNKNOWN;
> 
> But then boot is still not working because ENVL_UNKNOWN has no driver and
> env_init() returns -ENODEV. That's why it is better not to define board
> specific env_get_location() because then weak env_get_location() is used
> which is going over env_locations[] and returning locations which are
> actually enabled in u-boot instance.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/versal-net/board.c | 2 ++
>   board/xilinx/versal/board.c     | 2 ++
>   board/xilinx/zynqmp/zynqmp.c    | 2 ++
>   3 files changed, 6 insertions(+)
> 
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index aecaeb657453..da03024e162f 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -372,6 +372,7 @@ void reset_cpu(void)
>   {
>   }
>   
> +#if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u8 bootmode = versal_net_get_bootmode();
> @@ -401,3 +402,4 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   		return ENVL_NOWHERE;
>   	}
>   }
> +#endif
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 8c2e614ad8a0..4f6d56119db1 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -291,6 +291,7 @@ void reset_cpu(void)
>   {
>   }
>   
> +#if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u32 bootmode = versal_get_bootmode();
> @@ -320,3 +321,4 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   		return ENVL_NOWHERE;
>   	}
>   }
> +#endif
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index ba49eb7be229..79daaf8723ac 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -588,6 +588,7 @@ int mmc_get_env_dev(void)
>   	return bootseq;
>   }
>   
> +#if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u32 bootmode = zynqmp_get_bootmode();
> @@ -621,6 +622,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   		return ENVL_NOWHERE;
>   	}
>   }
> +#endif
>   
>   #if defined(CONFIG_SET_DFU_ALT_INFO)
>   

Applied.
M
