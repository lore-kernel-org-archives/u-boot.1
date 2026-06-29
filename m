Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8006C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7177B84A4A;
	Mon, 29 Jun 2026 11:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkpMqFp/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8489784A4B; Mon, 29 Jun 2026 11:01:12 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D8884A35
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDYiDjlWtAmgh/Tyq01b1cG7B6Zp95+sO0FHGGULagNwDrW9rz6uCeQUwInCGYLOmh6Aa4DRzke73sQ9FoVI/Tj2ysP0redFQk5y+vrOKeOckfww85LltvZno8hhDh6py+4yo+kgyLUkabh9nNn75BZvl6CM2Z4gzyPwlQsshYP7lvALX/2d0GEwJc8Ht5fJ++lPGK3qOWX/PWW/THI6XM4A4KWkvN1x2qyrRE0Sjh6gEyYYmy1AELjRyLHrl20G4A2RSzpS7AcYW1zYBMrMwojiF7Q+hkHLeEjQR3GwQgkFmh8sIq9e+0BkuHS9I4QMZhou4+5r9YvTeKRySZ+7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MBIjv7+9s89Tk3/Yz7ac/apBYNxXwhrQYwlLHeWvcw=;
 b=zIkeSK4OABrOWznFJ3LgJFpo6x4aKfQvMHXuwTcDhfVbU4OTrYGUWVb2NXe4P8I6psqOMPKZiAWIme17ToeM2PU77+2T5w4qCjKp41vfkJBU70DDAlCgn1RcMVJ6sYAu+IW9bVEq6wKbCEGc2G6AciwBpNamTCAIEYZx2+9JEB0o77vGibKUqMuQvjbfpXh+a78Ni5swUqjvQDL3SsQaDg63FPTZQ71WwMK25o3rbXCeVfv5mVTVnJ8TmtpQpTnlN8YVFt2YkBG2wAf42CE68W3D89gRCckqRAgUvRjJwgl6DpE8KrolA4xQ0Z/DxMq9H3/+jViwCT5LOi/DLmVZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MBIjv7+9s89Tk3/Yz7ac/apBYNxXwhrQYwlLHeWvcw=;
 b=xkpMqFp/AjLMx3TnAYCjO+4YDVIGCK8gQFYNGCnyU7F9UxmDGDTAMYf8wfeqeUlvWRS6nw2GqIstoS0164i8A/U/iD5Zr1+tJnisfomw0h4+3N0YkBAt1SIZxcW/wr4197wC2pWnIQD6SW/iHE9DU3DAWyu8KInMlO7SB2kzsRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:01:02 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:01:02 +0000
Message-ID: <17f1d2c9-5e2d-4d28-af76-30f6f3ab3610@amd.com>
Date: Mon, 29 Jun 2026 11:00:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] riscv: Make RISCV_ACLINT visible
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Yao Zi <me@ziyao.cc>
References: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f5c30c9faeba9e0f519fdf89c10e04c768c5f92b.1778849270.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: f588023a-aa67-4043-9ff9-08ded5bcf235
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rpTKXiIiP9V6unPp2GddqxEi0DJF02e3TsFhVmORFBqtqrukSAcCwZFksNSZQraLRX8qm9s+4QIXeXA85eSFDatn4mJbpQpMOmx2r1BkzmM+assyN9JCRVXQjKKVxGtdkMrVTsizCeIYnr2AHe7uO2KkTxx+WPtRnkATjc9WUhKireLLzQgy0xJ4uJtwjKkXaqN/JDb1EatTBe4+sFWApSkcxjpAJT3ply7BzvawayMtb/HN/SVNuVKkCBqvzC9DQdmRPwIpt+Ca8K5HqCj8yGYUI3pmMxeYAUCbw9lsm7UuIN8OhFCMfcAqy4ce3bQiVNFC+I64uUBf8gTzwLn7gL7bZisN4bT8YCxNvnimLK+Q5ofAkaGGIR4/kkhSYtbFN+jmatSovkIVANUgtzX+MwSx+UPhZ6325mWlscR45IwE/bXpOZqZzFAWSrnJF/9HvI65mqQ5kX85Hd8S2Iw9XccWENF3lzM98PDKTg0ggVSEqz5b0WTvCjyhXZ2CYup+YOgyCtZspYcHu8c9l+I7uyqJhh3uiDQi0SrPAXsF1MfAkA4plV0olOA3dWlOVEWGClOOFByHIEZNy1/oUDQeEelm6cxB5tg1qflDaUxB4krpPoMW6csN/dKY5nmyD+3GDYdeOFWi6oGWlnt+4sJmK7fHKEE1TTn7YEjxDoV1WfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTV3bkUxL1lHMjdIR0FsMm9sVk5EQVIvazdPdnBjUHVzNVJycHJVZFJuUDNn?=
 =?utf-8?B?VVRRbHdaNWY3ZWFYaldQcnNVTGNNUWwxUVppaTVPVUdUcFZ6OVU0WnFXUWhw?=
 =?utf-8?B?ZkhyRkZZbGM1M3dvVy9GU2IrenpDZ0IyK1J6V2ZuejZqMHVEK2RlUndDUmRs?=
 =?utf-8?B?TVpXNTRuMWFsWUUvaFFLa0U2c1c3aURtdjE2V2hSNnBnQ3o0N0hxcC9YUnc3?=
 =?utf-8?B?VGtDYzhDb0NJYzhSYkJITnZWVVBUL1Nhb05razhaNzcwZ2dFYXI5RG9qUGd6?=
 =?utf-8?B?b0d0U0R0NVRJc2FDdHlIY053eXBqZmM4TjVxSDdBV2ZNdUhsdHlYaDJ4T3E1?=
 =?utf-8?B?YWwrNzVrcHBBUHZsUEVoSTBnZTdMZlZxSXE4a05CQWtZR2RJSHpTTzc0Y0lD?=
 =?utf-8?B?N0pRYll0Z2pLb09tVGFaWk5JemQwUmdXRzhTUG9tdis1NXd2Z0xZZFZuMVB4?=
 =?utf-8?B?dVRDendNdnBXM1pEb1JHdWUwSThTZkh1RmdlMUhuNDZmNTdiRzExZStvcENN?=
 =?utf-8?B?TXpyQzB0WkNDQ0ptdkwwK0QzNjE5M09Jc0h6YkZoTlVhZkF2eXM5SlY1NDRB?=
 =?utf-8?B?NUVwTVJqQjVkeFFhdUhDVTVGVkJpckk2NGRESUY4U1BTTzg1eDNOdVJIbUUz?=
 =?utf-8?B?S3hHNDltN24xaml4NDZ1UUJFZ3R3alUwQjQzbVVpNGtZTldaWkRoZDVlWXVM?=
 =?utf-8?B?eXhvU1JOS3J2RGthSEFXaWxIZE9iNk1WVVZZaFB1cjhjWkhTRmFFT0cyRExi?=
 =?utf-8?B?WExTTU4vcVJwMWQvQk5vLzFhRGlQcXBsK0dKMHQ4dWUrbGU0WHkwN0U2VTVE?=
 =?utf-8?B?YzhITTNzdVRqUmlJaW5neUFBalpjSEpMekl2dXNhNXJTZ2U3cmhmYjBEazB0?=
 =?utf-8?B?SjBzUEdkZjZVeExqOU1JT1BDMnQrQmRhcEFUUkpxaGtRNFB3aTlrSmovd0Vj?=
 =?utf-8?B?UERWWTRvSG96MjhPd0orWVB6VnQ3Wmt0S05rcWdBWkZUdDRzWGdHeGdIU0Rq?=
 =?utf-8?B?RlVwN1NkVE1rRnBGN0Q2VG9tV0w4Y29IUGRnMVVxQStHTDNVRXljNmpHQTRB?=
 =?utf-8?B?NmFUQkxtdlZUcnhIUWc5R3B0NC9PMlJXTE9UdjAzZWp4RGZ4REtlamsxakoy?=
 =?utf-8?B?aEtYRWIvU3UzQUlpQXU5aXRBai85c0FZWlJ2MzdVZ1o3SXZjODNKNVN6dTNh?=
 =?utf-8?B?OEtGMFpRL2ZuUW01dDhueVJMKzMxZmpZeDB6bnFsUGFXck1YVnZ1UDY5cnVQ?=
 =?utf-8?B?YTkwRERTS0gyS3VIMEJDSHhyRHhJT2lScW93Zk4wUlVja2k0UWxWbmRtc3lj?=
 =?utf-8?B?cHA5TFhkTWo3eEtjM3p1RG9FVVBxSTBDOGNvWnV1cTIyNTFDd001UklXNUt3?=
 =?utf-8?B?djE0Q3p3OVdmRVRKTDRDUFZjRjY0SWVsbWNuaktrR2hnQnEybVI3OGJqZDlI?=
 =?utf-8?B?b09kd3p1MWt1aHJNZFg2MUdQWDJhMWdoV2pkN0RXVExuZlUwejJmYkIxUnFL?=
 =?utf-8?B?ZVhvOVNqa1Y0R250U0F6SHIra08xNkw1OFMyUmVNQkxEUmVsaWhtV2tZUlJN?=
 =?utf-8?B?dDFESDVOeHlkeDNobUFMTUdFS0FTY09wQTlEYlcrakhua0xOVnNLVWR1bjVV?=
 =?utf-8?B?cFlKbk5rNnFHWVIvNE1EOStpVGVDK3p4NWVvdVUzR0Zzd3BZWFJvZWc2OHlS?=
 =?utf-8?B?STNTaEZuQkh1NURIK2JCcFUwaXA1Sit1K2xUOWpudzZDOGdhMjY0WUlQNzAw?=
 =?utf-8?B?QkkweHFjY0liUkxQYmF0R3ZQd1dOMFdmSHkwRU8wRnRKTUtUaFBYMlE4ekxZ?=
 =?utf-8?B?WDVIVTZnVU9HVUF3WjY1NnNsbDA0U0dRaWNuREF4bGlKN0pzV1RqVCtkS3JV?=
 =?utf-8?B?OC9QTHZ4eHBTZ3NEamxQVzJZbnY4WTJ2b0JLZFNKbEN4YXd5S3h2cmFLb09z?=
 =?utf-8?B?cjE0NDljcmZhdWFPRVVaM3hhVUxMVUNjbUpBS09uNmltMCt0bk4vQXBJVnFP?=
 =?utf-8?B?Ni9RdWRHTHl6STBSTHFpazI1WU1XQ0NZM1l6Ky9JV29VRXNBa0ZuaVNodW1l?=
 =?utf-8?B?ZU1WUVU4SHFLZWtoV2ZnSmpWTnovbVE2UEg0dmdHWjRoTzFHVEVybGRGblpx?=
 =?utf-8?B?TzN0Y2xVcXZYRm5yVklEckpTQTZSUWRjZW1JOHgxY3VPNDZoWEI0NkNkUXdo?=
 =?utf-8?B?SXlSVkNCVmpIb1hvMy9SbnNnWGNJNnV3WVNROGdyT3RCVVFFM3VQZVlYMGcx?=
 =?utf-8?B?QkcrS0VMNEVTRnlhNTJ5dDFDZFpvTEJSSEVISUppWGVSaUFJZ1FtVHRVQ3c0?=
 =?utf-8?Q?BYfsS21FsDBfWwh86G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f588023a-aa67-4043-9ff9-08ded5bcf235
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:01:02.8490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrHv4PAXqSIbioq0ZNq7Kugaoo42j0G1ilFLFYTUwyC4OcmMlvIMYMznq2QvQL+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

On 5/15/26 14:47, Michal Simek wrote:
> A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block.
> 
> Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
> prompts.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - don't enable it default because it is breaking some boards
> 
> Changes in v2:
> - Make symbols visible and disable them per platform basis
> 
>   arch/riscv/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ad7589123c6c..e3adc48f6f52 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -378,7 +378,7 @@ config DMA_ADDR_T_64BIT
>   	default y if 64BIT
>   
>   config RISCV_ACLINT
> -	bool
> +	bool "RISC-V ACLINT support"
>   	depends on RISCV_MMODE
>   	select REGMAP
>   	select SYSCON
> @@ -387,7 +387,7 @@ config RISCV_ACLINT
>   	  associated with software and timer interrupts.
>   
>   config SPL_RISCV_ACLINT
> -	bool
> +	bool "RISC-V ACLINT support in SPL"
>   	depends on SPL_RISCV_MMODE
>   	select SPL_REGMAP
>   	select SPL_SYSCON

Can you please take it directly to next branch?

Thanks,
Michal
