Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC2BCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F35A8813C;
	Tue,  2 Apr 2024 15:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+eqMdSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BBE88151; Tue,  2 Apr 2024 15:08:24 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5C788137
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZjKy/vGVur6kpd+4RD8NH/dxvmUbpY5GkEXDFfkM29GtWBf/++Sfoz2FJOhzgI692pyBfJr9vZLhBGMuAZ/KmD8GkPI4DYUS5gPsMXYQ2UdUpN+bOxZhFyF44xAmeTQKJTsiJkgtPsPgQlyO4MjXXUNHyeSdRq082vAaSYXbKVr3aQY3lR8kyw24hcGLUlaBRm0/j/qVQ0k3wfPplVO8iu0Gjy4mqXlkKHKFcmqBMX5MztE8qljgX4B+jLahh0aIw8sM4IVVMfjqOs5G3vVg8AsY7ZkoLdW9PusT0MrR0h5Ga7CrDew0zEIMQmhgYIf7lQZ6At6/ztGY385ZE71Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YZ73TXOnntyzgILffN/OjdP4R0lkA7Qq3PnELI4ntg=;
 b=XnNr25V/vCtEbkli7q8jLodmeheSBpHRfenRNS8LMHam1fxMwQ07knTMNY/J+OZhqIFS8ZHvQOiZnpdm68gb7lWwiygPb/A8mlHTIyT5cQhnJMZhwdWDp/kyPo3P1FoQo65T44dYBg50zY2iI0tvXQK7/ngdfUz1e+FJ9Yub4Kqt/uMyZeMIORXBFVC3KLgcRnu+OAiYlbUi39Vr1fT6CenmqgLajYBiJ9cxD2Q2EZ+2kDl1DcoweM0c9py37RvwAHPBEu6BxWdBX9Ju2vcJ6s+O2YzwLcXsfkPbgveAF3ljugJpEHBibJFtR2yB9tKNueDfG+DCkCE+Ag+8Txi+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YZ73TXOnntyzgILffN/OjdP4R0lkA7Qq3PnELI4ntg=;
 b=h+eqMdSh9gYIRxti3NpCKwaPyaqWOddE3Ji4W6/jvnBheUi4eXZ02jcTNE7pyI9j4Fc5Nz6wVSB9gwlsBGe7kEzj6289d009qG4CzkEl0rwNUKW4/RkZdrLuES9bzHjj5Y/MUr54hOr+maa93HRtZyjmyE7ftvRK/zXXEEXcSe8=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:08:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:08:19 +0000
Message-ID: <5211c2b6-9eb6-4a1f-bc2e-8d03e1bd1fb3@amd.com>
Date: Tue, 2 Apr 2024 15:08:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: zynqmp: Generate desc when
 SPL_FS_LOAD_PAYLOAD_NAME is valid
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, ilias.apalodimas@linaro.org
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcEfZFF8rLlGbUivw3QGceuALIhNLlpvJodwq3uYYXA6Z5AKv+eDnIpvBEMleZZoAZs2kzq1PAmN2Ax0hgmJ4y9pOscq94oeGbxZTCbjwbldCVhfSk3VX1XcRYGs2aVkmuwD+uXvMbt8YeJjzhKGdFStYvnFlJr5UAyXevzjMn184WPb/lCyA9/+lG6VMZM0N5BhlAMdyKW6mxvYllwM7C9Ha3hBuT1jTG2Li0PrMk+Zx40ueVUIDWr3styoUVbxXOaeqHrzTblGOCiwnUepylkG1X3RQrLIr/uyn8cObB4Y9jTAPYUXCUn7gWJVWLu2ooKP7LWWDfg7z/9/lPIJvb360WfuqS7JxW6rCdOkxisZfcM2CEO2KmrdjkQQO+Hc6c5XUAn9NjK7onw5aPLiDm4c3483Db8qW9RnTd22l0JcM34N0yATy2CyXy/4AYjMzwxh1R1KDPU82CNSLjduRzvhFiBEbOuErQNBULMEmFVWDjaU9du/YaS7kNlL5iRqrC+k1H1QPcJqJMieFMudCdKWiW1feIL9BVyIfUyIJ+O+WaauL7P2ryzOvQgbKwsecDZVANdp/9QfDIauOAHqO/77mbU4whFN1vSkhgN1tjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNKSkIvd2VvZUhadm0zM3Y5eGllL0FCbVArNE9NR21od1FuaXZ1NFM4dTdN?=
 =?utf-8?B?Nk9zdXNjN3N6aTNPT2hXOFNVbWQ2dzgvSEdlTUp2Zlljd2xhSThxNTNtNUth?=
 =?utf-8?B?SnJBTjlYcVhsekh4QVQvQkZYRUd0S3pFRUo1WGlsRksxRkliSGRCSTl2dHE2?=
 =?utf-8?B?TjhjUkNSR1dQTnJYcEJxeE9FRmZIcFkvTnlCRUVyd1dMTHQzRWdvcVR5TDRi?=
 =?utf-8?B?R1Z2V1F3ZFBWSnNWS25aSlE1dmNrM3F3cDl5eFd0ajlObTBNZmZHS1FUaHpr?=
 =?utf-8?B?NDNEeDFmZWk2YUFMMUtzZmZvQm5nejhMRC9HUG5zRjVTR0g5K0s1dkFNMjln?=
 =?utf-8?B?bEFFalkvMDd6RHhHSDN6NTVwUTFWR3QzRFAybEdVQ1lDdEFDZThleGt0RlJZ?=
 =?utf-8?B?WitHN1JMUmkxOVBVem54MjFwSW9Edm1sNmJCQVJVWENLSTNVZFVDc01jRDdz?=
 =?utf-8?B?aDVmc09KdnZZcVpoRWM2MGlLL0RyTGVPRzZHQkNEcnJ4VWRINEVpNzY3U2hN?=
 =?utf-8?B?U3BOV2R1aGJxN0FiZGhXSEVSL1NqUExxM1ZXbzFxd3Z4cXI2cGJOeGNkdGFu?=
 =?utf-8?B?c0ZVaExsNTVkR3R6LzNCSjRNMERkREZqY096QXcyUjEvcUQ3ZEh3bjZWU2xZ?=
 =?utf-8?B?RjhnYnloZllmMFh3SXBSemlOaE50aDZQajhFR1J2SzdDSUVuTGRCMUNQZmtQ?=
 =?utf-8?B?MHErYXRmYkxhM2pPT0REeWxhT0dKZkw5T1RsM3dJbFdjVCt3YWFsRVg0K3dj?=
 =?utf-8?B?QllUVmV3UlhNSGc4Qjhua29xeXVvelB3TWJzWUhmQVptSVJITjJqSXY2V0FC?=
 =?utf-8?B?RS81bDFCbFkwOXJ3bk5qUzJYTks1eWJ5andrNEtSZDZIdlp6UktlcVNIb01v?=
 =?utf-8?B?U3JaeVZycjRZT3JyeWFlbWlFNVZGbWRWcGkzVC9pTjdzWGtrZjk3L3NsMlY1?=
 =?utf-8?B?MWFXTHdnUVRaZGxTenZuRlJEOTlvTE1uUml1N2lvVWlNSVBqR09wQ1V4VTM3?=
 =?utf-8?B?ckJwN3NES3BTbE16anllRHZUYVhJTGhTMFlQbjlZUzlUQU5KKzZWNGVoUVZp?=
 =?utf-8?B?WHVOd0NlWFFyREdaUUtqbU1IL1ZwVlhCdkF6S29TbUR1b3doUy80aGkrT25i?=
 =?utf-8?B?LzZ1VkhpcVFoYmdSbU4wcG1nTXJtQldPc0loT3NwZ0phZmhrcEwrWjE2Nmpz?=
 =?utf-8?B?Q0xDaWt3aWxJYlJ4YmljTjZ6REJkWHZaK1RuQ0M5eDNSczF1dFJnRDAwTlNY?=
 =?utf-8?B?K1JkNHJoVHJiVytLTnhKYXpYWE9JT294bnF5UExZY3lBWFBTN3I0Z25qRXQ2?=
 =?utf-8?B?TFQ5YnJVamQyRXM0VFgzOFI2aHRYQ3ZuODB4TDJ4STlvenVVVVBTa3dVQnFn?=
 =?utf-8?B?WWFHblA5S0ZHa2VOOCtoWlZxRHRBdDIrLzNCQ2lPZHlmYXJYSnYrSWdHRXVG?=
 =?utf-8?B?UEMrRFJ5VG1GY1RHUjNPZGc4SUZzWlptaVJsa2x3MER2Vk1FL3RMM3dtbTVI?=
 =?utf-8?B?aEwzRWFqbTFJKzF4MTVDc3pQSVFranlHVTFlalJpNUhvUnBaVk5BVUV0MGpG?=
 =?utf-8?B?YTdUbDU5VDl6d3I4bkFnNnMxRUdvNXc2SmVSRlhkaUdLNTlmeFduaktrWUxB?=
 =?utf-8?B?ejJKeC9BQVg5OGJBdGt1VGFCUzNhN2NmRmJhUUZuRG5xOHZHL1RBbTEyVnlo?=
 =?utf-8?B?R1Nza0xZakdyTVh1SVJydElyYjVPQUk3U2VnYjVzK1R2VFRNVS9kOXpVaWVQ?=
 =?utf-8?B?WWhLNUt0bVczWHBmM2U3ODZFdU9xOVdLQnBSRWp5V2hCWWh5SUM2SWZnb1hk?=
 =?utf-8?B?ZDF0M3hGRnpKRGJLTll1YmF0eXAvSGhhNkRPN2hJVmdPMS9YYXJ1RlNUOWI5?=
 =?utf-8?B?Q1BadzFVNTBlWUZVTm8zTU4yRi9xWHE2dkdWMzRUV3hUaGpWOUVQUkVEYjFv?=
 =?utf-8?B?WDRRd1hlcGpHQ090T1ludEpubjgxdVhIb09iM2x1b1NlYkh1czFkbWtvaTNM?=
 =?utf-8?B?dExVVmZjb2UzUHlJRk9VZVhCeWFnUWF2NHRTSGtuRldsTC9KcHF4L3M1d1Fp?=
 =?utf-8?B?L0VSL253OE41cSttKytvdFBudEM3cWhybXZlMGpnWHNTK25RK3VCSGxMeVF4?=
 =?utf-8?Q?Z3GgsEoGwBgQGixq2GOh+4lzn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a17e0f-72fd-410d-adce-08dc5315f7b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:08:19.7619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XezGVAfpdcR8jcLwwMS1fSrXl6MhOmjIHOMC9/DKxedmxTe7Jcu4rnF59evBze+b
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



On 3/22/24 13:09, Michal Simek wrote:
> Generate description only when CONFIG_SPL_FS_LOAD_PAYLOAD_NAME is not
> empty. When name is empty there is no reason to generate description for
> it because it is not aligned with dfu rules.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - New patch is series coming from discussion at
> https://lore.kernel.org/all/561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com/
> 
>   board/xilinx/zynqmp/zynqmp.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index ba49eb7be229..3844a9c9a8ff 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -661,8 +661,11 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
>   			       bootseq);
>   #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ";%s fat %d 1",
> -			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME, bootseq);
> +		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +					";%s fat %d 1",
> +					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> +					bootseq);
>   #endif
>   		break;
>   	case QSPI_MODE_24BIT:
> @@ -671,10 +674,12 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   			       "sf 0:0=boot.bin raw %x 0x1500000",
>   			       multiboot * SZ_32K);
>   #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> -			       ";%s raw 0x%x 0x500000",
> -			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> -			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
> +		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +					";%s raw 0x%x 0x500000",
> +					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> +					multiboot * SZ_32K +
> +					CONFIG_SYS_SPI_U_BOOT_OFFS);
>   #endif
>   		break;
>   	default:

Applied.
M
