Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00841CD128D
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA52A88159;
	Tue,  2 Apr 2024 15:08:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="en7S7iPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CC488137; Tue,  2 Apr 2024 15:08:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D79988151
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmlqYorS0McKn3gd0TedtH2ASQrkC02hr5odBbwcUrTrcs+eibUdcGXB9oDI/NcWlRYzas+mFG5nv2hHarSkN/cGqNjVtpZUJcSAMdtNt//yyxIqQWsvx/aiSep4QI9ypu9oJSWkWksW4YD+xEPAxiwtoH1qotyoBJIO11qNEB9hjihGcBMgzR1ImgBWiG0SiBB9j/1qer7XRXxRU/q54L4q9mw5QBJFkPCJo48w2kVh212/O7Q8A3155ncbMJSjSEWbFNuakUOxCbO9ifBbL4mxyqgo5WzGPsZLnwfvLqJQSr1aeru8NnA0pAkZDgHSVp2vuSHGvi21jKz+uC2Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YNuZ5UKHnn5fwFasLo6ceqd5/HifIJwzt+3+Xu6BZo=;
 b=XljGKQqQpCONxR2+zMNWZIKCPhpO8U1Q2WVCxLhgLSdSE7jiOY7X2TaXjPh5yT0N7mkNaFCHXD/WvXEZmEhSglzXwG12RKETgpjjIwhZrAsouOTrAuO1T/xtoc6ZaxwlCTtacYzCiDOQcG6y+AMcpZKJmtRNRbJSG740QmP6ilHaHYwjED4fn37VL5/Z/HpciEgF2QIh2MNP9nv/peniuGn/pWCXhmVUBwI5kNCZ+8qFNRNzcn4Ci+MLmAliJUVSw7H9VImtGxNw+8274W9zxtExlYDWSNY8vfRLSDwH/vLnRG/H0VEkPBgvdCNbikmQlqz7QWwtUG9W57FKUaM11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YNuZ5UKHnn5fwFasLo6ceqd5/HifIJwzt+3+Xu6BZo=;
 b=en7S7iPZ94WvggFvOyUp6lE3yxlzLmKwPVxedVJ2acIZErXLKewI++k0/TWtPCT6JzPfVfNW6cRiojsZwty5t9tXhgCE5fz84sa0ZPdyYTtaLA7HaWv3Cb6NanzC0Us2ECy5EJmabFif4qm6EWm4e9ZLBSDSfgqJjnwFyjjopFQ=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:08:24 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:08:24 +0000
Message-ID: <e3b65173-6dcc-4756-8c0c-36c48b6a7972@amd.com>
Date: Tue, 2 Apr 2024 15:08:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: zynqmp: Add MTD partition handling for
 dfu_alt_info generation
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, ilias.apalodimas@linaro.org
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <4cec866f5fffa742258c65796371d7bfc6068915.1711109356.git.michal.simek@amd.com>
 <db58d9f3fc142004d833bb115bfba0e26d660b66.1711109356.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <db58d9f3fc142004d833bb115bfba0e26d660b66.1711109356.git.michal.simek@amd.com>
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
X-Microsoft-Antispam-Message-Info: ZYBBjLgp3NzrixCgoO3YMZS1tm7lBXbgbxFGLSn5OBfNdheaBxQG/d79WVvXuGtiB3eJjuYnVhhVFlXavn7UoDgq3XnTPCk6nSH8uAf8hxZHpACqifVS48gZYnF+OLxE6dGv7wCIPfSRr/BRa9jpiPl3MzitB9pX5fJDwLDzOnfxlcx6e099jNujbwtokXkD/P/6VmfeUtk09Q6AOobK1VG3IH8Eo0VHE4zdbo3eN2sAoSFcTvjV/vYST2kiQDrv9LZn/GXQBxeFuig7ae92ACzoUwpU0yPzVclP14v+xtYKMSfwlpVOHeO912kQvb5/nImaxX1XqHoixTywZITNx9oCxHHpTe2FgCzkN3I0tgEhlaXiqGcMcKVOmXc50fBb+wEwCvgCgQ9ZnQHD/L+kU9NbeeymkSx7zMXx38k5oiJQwA3u6EmNjHCNLTiL9ufLvtS0hq2yIg6aJpryzC6QoaOzjufp4rIkpEYL0wy6PWUuZtkg23rNvYxeqzIvGom//eTb8hUtOsAodw7Z8+iJKgtDLrTOKJEwSAS4oIu+6gGmJFKcYZ5bG+5eFNvNNnbUi8gIzjnGyRE7u4U2XuVej1Q7CR6iLy7GvOKcS80IFLe7UBcnPfGtx21SX+bPliRU1pHwJH87RIYVtCpVIZjlK8VYQNvCy7G+5i9iSmmnzZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWVZeFRmU0VYSWxxYUVxb0k1K2dFSS9PRU5GN0tTY1dWYWp2WUZSb2M5TWpC?=
 =?utf-8?B?TnJJSVFCV2ZsNHF6R1VUcUEwT0VpNTB3bFpGZGkxVXBmeFRTeUUwUEFIamRG?=
 =?utf-8?B?TFc0bm5yVnZGL2pmZ1NadjVTOHh6YUFHV1d6WFFIUE1FL09UeVhzZ3cxdkZ4?=
 =?utf-8?B?a1FqQStPdWFnbXR6RGY5ZEYvbHR0akpaQnV2SlcwRkZPVUx3VkRsZDNVdXJi?=
 =?utf-8?B?TC80d2swTlhWQXovVHAxNmtrbENBV0dpdHFkTDM2VFZKZmY3cjEwSldDdGZD?=
 =?utf-8?B?dDRJMFVmNElkdElvNWpicnFhWFJQYVVRTml4bnRLelUvdDRlMW85aVpVTUV0?=
 =?utf-8?B?R2szZVRjdCtkRDZTdTRGVGZlbzBUak9keWxvb2dVU29VemhhMFVHNE1yZlho?=
 =?utf-8?B?eVBuZS9mM3JCdHQxS0tNWjFGczd4SWF4SW41QUhybjdycUJHRTgzdWtlUmF6?=
 =?utf-8?B?djdIRW9RS09zTkFXNHcvZmNhR1VCU2wxTDdTdFdjSmVVMGJXaEhCSmxJV3p3?=
 =?utf-8?B?SWUxc2dOa1FQWHMzekg2L3RvbW9Rc0dtUFFtY1N3Z3dLVGZpU3p1Z2pjMEtS?=
 =?utf-8?B?cTB0YXZoaE5lRjRzTVV6MlNQMDNSYXBwbnRBNVlqczc4NHl3UWFGNVN4M0Y3?=
 =?utf-8?B?czBsNklqd0hITDNxS3NHeVpYT0lvRXlOaGRPL1cyRUgwUzNyS0k2OFR6L3dj?=
 =?utf-8?B?NG9PWWtzbENxUEg0YStFUmVXZWM1UGxmV3RaV3RKRVNTeEcrQzM1MXAyMGZk?=
 =?utf-8?B?MWpXVGVnaWhIY2RQMFJma1VJdUZYUHVrUXNCQ2JJTnNhcGJQYjZSd3lzZUFM?=
 =?utf-8?B?S2lFaTVxcDA1cUpHNDVVUkdGRU5rK1Q0eFUvRktXeDc3cnBMWmxTMUNiZUxG?=
 =?utf-8?B?Y0IwWitNOVZTYTQrSUdNRHFtSlMvOWRjM3NUSkMydDlNck82SDBKMUhPaFpn?=
 =?utf-8?B?WjRqUjYvcHUzV3JBeVR3eTQ0c0pSenpnU2creUlIM2FSREU2SHozQVJ5OWln?=
 =?utf-8?B?R1pMVlVzV1dFZ09xMGlFZ2R3djRGWitNMW0yRU9IaGNFOUZnNDQydnlSRDIr?=
 =?utf-8?B?Uy9HS0gzS00yb25zLzlhLzhtS29OSjdxRnhPTktSZEs0UEVnMzV0RTczd3Zx?=
 =?utf-8?B?QnpzM0VrM2w2MmJQd1hpdURPRi9GQklsdXg2b0srWk1iRjBFejFFTWNhN2U1?=
 =?utf-8?B?dFYreFM4QlZzcUp2RkZMeFVDbWs5TU56TlBQVzk4ZzVtcGhzWW9IODFLMDlq?=
 =?utf-8?B?QWxkY1JLNURUR0UreUdWSFRRb2Z5TmQ5TG80bmU5aEtaM2pvVFh0Z0xmdTZv?=
 =?utf-8?B?SE1TZHRBekpHR0piT25wUlBrTHJ1dGd2K2lrZGhVVTRhdE9SOVBzTzBGRTJh?=
 =?utf-8?B?UXBUVmx0cWoyNFFoZzNaVFVwYmxpZTlsSjFXZE1CRWdmSEFNK0lWZnZXN1hp?=
 =?utf-8?B?VzMwTW5qY1M4d1hWbUxrZDdEM001NDZ0cmY0RmI1TGJ2RU1HOVhtMlR4VVJi?=
 =?utf-8?B?dG5SdkJnVFhHYzlGR25LZWQwcDB5ZW1xVG05Rm9Mb0VzZVpiM2JpWFl0WEVx?=
 =?utf-8?B?ak1MZ2J1S2tHbWJGMkRiOHhBclpVbHpiNmRWaXExUFhSSCtWZ3JrSmkxcnR3?=
 =?utf-8?B?dUwzWGQrUXh1R3hWZmJudzBhYWZMRHJZbURIbDAxSC9TamN5blJ6VmhDaDlQ?=
 =?utf-8?B?N3R6TytwdGFYK1hlZ3hTZmlCVUp5SlJvUlBBVFJMR3h1Y0dpd01vSndIZVNF?=
 =?utf-8?B?dVNQWVJjZldIdWM4MWdPN0RILzZUVUYwVEJ3L1BvR1lVVGhHRHovVUlPY05h?=
 =?utf-8?B?a0NWYnBWdnBQTjNCaTl2WmRQV1BTNVRjSDZ6RlFhcGtRd2xKS21tNU1nR013?=
 =?utf-8?B?YU0wSUZ3Q2JnSHIvSm5MUG5BR0tpUDNZWjcyK1R0emZjTE1lclNXeEloeXg3?=
 =?utf-8?B?Y2NEM1dCL2JoZjIzWjM5NHRlT0JiTjUxTG5UczkzbE1YSmVTVWw1MDFrK2lh?=
 =?utf-8?B?WGcxejJQVzU2OWJYZ3lQMmRCZkxFNGIycFFtam1vamx5aFp4QTRSeEpxTXk1?=
 =?utf-8?B?L25CQVRpMTFKTnYyOFlVL0QxRE0zVldPdUVWa2h5QkpsVS80eU9QM1k0MG5Z?=
 =?utf-8?Q?5Rl8K0KamCRWvJIS9CyTgODje?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a76b20-c1e9-4655-e782-08dc5315fa5b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:08:24.2189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Al/1ROz0BIO8yV33+woZ9Q9arbIa2XUl/6VT5z/BbWpGRMKvt7weqhtLgxeqiX4w
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
> Generate dfu_alt_info generation based on information from MTD partitions.
> mtd_found_part() is trying to identify MTD partition which code is running
> from. If partitions are not defined and location is not found it is going
> to previous behavior.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Update logic based on 1/2 patch
> 
>   board/xilinx/zynqmp/zynqmp.c | 55 ++++++++++++++++++++++++++++++------
>   1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 3844a9c9a8ff..2522024b4082 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -626,6 +626,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> +static void mtd_found_part(u32 *base, u32 *size)
> +{
> +	struct mtd_info *part, *mtd;
> +
> +	mtd_probe_devices();
> +
> +	mtd = get_mtd_device_nm("nor0");
> +	if (!IS_ERR_OR_NULL(mtd)) {
> +		list_for_each_entry(part, &mtd->partitions, node) {
> +			debug("0x%012llx-0x%012llx : \"%s\"\n",
> +			      part->offset, part->offset + part->size,
> +			      part->name);
> +
> +			if (*base >= part->offset &&
> +			    *base < part->offset + part->size) {
> +				debug("Found my partition: %d/%s\n",
> +				      part->index, part->name);
> +				*base = part->offset;
> +				*size = part->size;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>   void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	int multiboot, bootseq = 0, len = 0;
> @@ -670,17 +695,29 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		break;
>   	case QSPI_MODE_24BIT:
>   	case QSPI_MODE_32BIT:
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> -			       "sf 0:0=boot.bin raw %x 0x1500000",
> -			       multiboot * SZ_32K);
> -#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> -		if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
> +		{
> +			u32 base = multiboot * SZ_32K;
> +			u32 size = 0x1500000;
> +			u32 limit = size;
> +
> +			mtd_found_part(&base, &limit);
> +
> +#if defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> +			size = limit;
> +			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
> +#endif
> +
>   			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> -					";%s raw 0x%x 0x500000",
> -					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> -					multiboot * SZ_32K +
> -					CONFIG_SYS_SPI_U_BOOT_OFFS);
> +					"sf 0:0=boot.bin raw 0x%x 0x%x",
> +					base, limit);
> +#if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> +			if (strlen(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME))
> +				len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +						";%s raw 0x%x 0x%x",
> +						CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> +						base + limit, size - limit);
>   #endif
> +		}
>   		break;
>   	default:
>   		return;

Applied.
M
