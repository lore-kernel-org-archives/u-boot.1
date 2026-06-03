Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F385CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 06:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3BED84857;
	Wed,  3 Jun 2026 08:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z7DWDOrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0426484874; Wed,  3 Jun 2026 08:08:56 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E338056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 08:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/ZQ4SALu+rFCZ3i08dG9+rwx7iND5q0oIIrXWJfYOvx7Fek1Cr2M+bcBilO/44PZRfMpzvAb7cPZky+5Oto3ow14fYbku4QxfR43X9Eespqs5B+ZPYvjXVbhmQwA+eJHL7yjD1LEGrad6sWQjNBMLvIWwCeuL0HR3vqNnbweDRXivzNTllEyol1yY6HhzRdJpJ+Xt8+MHt/6g/FXPdJW3E0owjd6MX/AsB7x0ZxceG7ykmkHVnuC/ZIE60nA0thcdVmav7dHk/uzsTPlFhG0GVMlhZNq8jtbM+2TdFq962E26yfC819zoIbvdQg4lgJZ/ExnV0CNgoH6J7mczS2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFTQt6L3+02bdiW3hu4yc5Sd+pw7sqYLefAkXRSB66g=;
 b=Jvi5QZXFUTKgMns3JC2VgUjXo5wguIVVlxcEg4/C6aeTDNzlN0ccjhz4MrEwv29skw+fLFKcXWiGDvqH3CdJy0XLb3LzaUK6FPFJxVqbZmGWmZumqZXDw/Ukw9935LPjU1c24867G8XnxcAUz0fg66EaVelOOi7EKjPCFZvr1gCb3iFWvjtPR+Iz+OlFS42aWGCvb8SjGQGE4NpX4VL67ZohTfYpzvcb/n+vuFg8vxdjbEk8D7x9XGOIU3NMNarJxJraEuAdBepDnEhOrhjl8/SEFdUYegTkKSlUdpUyCowfjehLg1/bgKS1X0ImhPlxrFIYF5nwQcC9Mih3L6bPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFTQt6L3+02bdiW3hu4yc5Sd+pw7sqYLefAkXRSB66g=;
 b=Z7DWDOrclL56+WuIMQOrsDvMorb7VBZXJa/g6G5R8CLoOU7FgtI/VcDfuFfslHjY/iBg6etxJOqMYCQnx6yoqtQppPIAkHpDX73LQOjMhHBMO1TkwDgeEteBumJHH600xvdmUwOfMwRnfEzLPT1YWqZ97U+XJ+GKClhGDstgtzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:08:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 06:08:49 +0000
Message-ID: <cab1c990-a44a-4b2f-b50f-1481dd00b16a@amd.com>
Date: Wed, 3 Jun 2026 08:08:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: mkimage: allow zynqmp to use a register initialization file
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260602210141.62966-1-erich.e.hoover@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4fb0ec-4d00-4748-dc24-08dec1369462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|3023799007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: yXoEntDzr+BAbmMirbB0MMnvn9DcssuAiR4OmPf6969iqVim2PX2OtIiQumyGoVLB4Wi1mGcchoLIo4U0ScQ98+o4bT9DuAIYaAf8sFxlr2/veASrWGJlGWZ4iP+LC/YI7cai/WOb6Xh2QdhEnmz/LsaUvMByEUuk1XoECfElTBbcTiBuwiI3ZM2JKd/ckqYf0Ggu8KQ6qSLNU50E1WTWkLhyzZfOVdsHlINyVPWIHIGCj7pwr76hDuVowTBpuVp3wVp7W+0rqnDGiNHeQVcvfgd/6ZaR8h+a/dG/fImL2UMKDusf27E9+P1b6cE2xXxEFXHcJxbca9cxX5sCno2BIP/UP9TjAvrv96AWNN+65frlnSH0i4BtUjPM0BrCRcsUGt/EzZXa4RTScWpShF14ZabSwpk2z/mxZXm4skU21eh/+GxE5xpeu5qY+nCCVsd3BF0J805n8vLzyjnPGmm3OoyUFRMsRmdR4VWKm1z+HUIbdLSRzphGOaBJnN7o3bpZLiwrvNBuFBLUFmN1nYNOQm0iWzP031Szuf7IVVYKTKSfGC1oYerisdU6C0OMIvIwDeE0X9cnpdTuQOoYW8Knl4BCpOjfPCjyE8hJ0gcbdvYQQvCXbN/Mg/KOTjlBxDXuUn4RyFWn+Hs1f+6oxVet5FdXh8SvrkZgCKL0IfsfIg/JekMcDHk2I4ADZKNv/fd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2hobDJTbllIT2Q2YkJtaklHdnN3YjNlTlhCVTZGM2NNaklEREhGV2dkbncr?=
 =?utf-8?B?MmF3TGxuNVB4eC8ydWYybXExV3ZPR2V3VFk2emt5eFQ2bDdvSGg2YkphRGVM?=
 =?utf-8?B?WlNydk5zUTNMOVZYMmlBeFBaU0phcjMwMURzMjNjZTU3bklNdGp4dU5UbDNk?=
 =?utf-8?B?NWdEcnZBYnZzcExmQ3pVd2hvUnNZbjFiYmVUdFNSM1dodjIzTUtNNTlDaU5w?=
 =?utf-8?B?QytTSU5IVzRndU5VeDQ4S1NJeVBNSC8yYWxiZmRJWDRWaVNYVmZwOXAvMnFh?=
 =?utf-8?B?dkhEd3hUZHdlNGdWSXFFUjd6b2VUM1JRa1RmMmZvb24xUFhzWENuN1NHRk84?=
 =?utf-8?B?bnVvanJ6QWYrSkxQdVBDZEJRaFdFaE5Ga3J5VGFVSC9xcjRleC9sM2l2dXVw?=
 =?utf-8?B?MHB5a05ieCsveS9YcjI1SXFHbFVnN3hxc3gvT2pTOUp3Ym8xWXo5TSszSTU0?=
 =?utf-8?B?bldwM1RSTzJ5UHExU28xbHdXMTEyOUNxNTYxYXNkSlQ0Q1B0WTFHT1g0SVdO?=
 =?utf-8?B?UHlWWVR3ZTdtYXZ2d0RjVXl3SDRMV3FqaGJYSTdJQWJWQU9lZ1hWbDgwRHB1?=
 =?utf-8?B?dUR2MjVFNEJCRkhTSVV1RkgwVzI0aWoyNmk4M2d0OUZGb0hxTTc2aGNNZkVY?=
 =?utf-8?B?bTd6ZUJwaU55anhCTUF4c1AyMHhkWWladWNhN3NmN3BSdzNORlE4dkVOMmVD?=
 =?utf-8?B?Zk5jOGQ2UHo1Z2wvbUFpalczbUgvWTloNGF5a1NUUXlsWjk0SnpMZzNvVXV3?=
 =?utf-8?B?bFZ5b2hGZGJ3ZmQvZEcxdEx5VDB4bjFvZXJveVNOcUJNTGQ4WGQ2aFRvSUVq?=
 =?utf-8?B?d0tzQWRDSTRld0VYUmt2b0RsVDNmM0lEa3loaE44cTdUM3ZhMVVuOEZvOUxX?=
 =?utf-8?B?b2toSTE1TW5wWG9vS09OREFpd1A4bUMrRXIzL2ZkT293bmNwVFcySGQvWWI4?=
 =?utf-8?B?YjMzTUNoaUJzcE02S0plODhURzJOOHk5aXlsQVQvOXVlL3dlQ2w4dnRnKzNz?=
 =?utf-8?B?aDZaVi9OeSt3WmRFOXJuUXB1NGVHdWpvdEFLYkYySUZMb0tZRnRvSURTckdM?=
 =?utf-8?B?MGZZckdVWDVPNWMwYWJJWEdxakQrZFBFMHRoNWtKMTluY1hXNStVYXk5N3Rl?=
 =?utf-8?B?K3VLNGRXbkVHZlhTTXdaYmNiSGIyVXpqaGE1VjVOTzE1dDRNQW9CcnNiaFZU?=
 =?utf-8?B?ODBsdWpSODZMSWxEaFhCR1ZVM0FweXVGdm55TEJIZEpyM3dmcGw4QjNMYlJ4?=
 =?utf-8?B?UUE0WGorZ1g5UFh3cFNPVC9WT01GN1dzandjNkd5RGxxWEFUekVjLzc2WUwz?=
 =?utf-8?B?aTVsOFVIQnRJUk5XMzNnZmVPOEk5NXkvaWEwRFFGT2VDcU5LMjArYjgvUWs5?=
 =?utf-8?B?L1FodmJyVkUzVG45V3RvcnFWTGdmcjViaW5oc0VEYU93ZDkyekVMaENNQ3VT?=
 =?utf-8?B?MjBKbG43QmV5WXc4bDdqQjFaaStzeDNlbzdjd05qdDBaVDFjaS9pMVpXWUJT?=
 =?utf-8?B?dWp6RUdKY0thZURCNEQ1c3plOFBOeHNMcUNTSE9ubSt1elA0SVBFV1A0aVpx?=
 =?utf-8?B?eEFuMzVPd01STmZ6ZkJPOUtUWXRtNjJGbnQ4Q2ZUTXBTSlIvUlhVZTR0R2JC?=
 =?utf-8?B?WEtLdG9kaER5c2dTOXRia0dKRWY2RjFlZUhZTWtJMElIYnZ3QkZlTjBxODVr?=
 =?utf-8?B?TDBZWTJIUDNwK3Y3QmdiWHpyQXpBalNtR3pBMTc2Tm9INmRuaHUvZnhtTEU0?=
 =?utf-8?B?MmRlQ1BMQmVEVUhmOEpUM3liUFJNSHlabjcwVnNhd2F0aVA4OTdiUmpuamVI?=
 =?utf-8?B?Z1BIVkN2OE9QY01oK3B6a3docGNGOWtFbVhadUNac3h6cFNseVpIdmZudEhU?=
 =?utf-8?B?b3FwNkprTWprZ0l3bEpUSk9VbEdzKzVuVVdlS3M3QUEvUUFEck8vWDE1S1Bi?=
 =?utf-8?B?TlBOYmQ1VXRUYnFTVEZPSCsyUW40UEV1ci9lU1VwQTQ0L3gwRE4ySksrTXdQ?=
 =?utf-8?B?WE5IRkRSdCtaNzgxN1puMTBQaEtXUklpLzJzZVYwamFsTGx1OTdXLzErYk1L?=
 =?utf-8?B?dHh3MkVncjIzUzNwUE1scGowcFdQajQzSHhTVFBYNWhOUUQ2a3QySUJFazlj?=
 =?utf-8?B?UEgrMnVQNitxWGdCNFoxOEJqOTFkM0dzc3VZZ3FHbERkRjhHTnZOMjBlNm9l?=
 =?utf-8?B?ZzZERjVXNHRDVU53SzZMbVJvUUpwajQ0anZQeS9GV1k3NE5kWURhQjFlV1pF?=
 =?utf-8?B?K3VNMmNHUjMxdWEzckRsMWZMbG9ZTllqSWx1czkyRXZsRndzSmhhcEwyR29z?=
 =?utf-8?Q?Z3z7Ntu2H7cUn4+Ue3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4fb0ec-4d00-4748-dc24-08dec1369462
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:08:49.6823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m8q/b/pEQrXw6TX6X2JfJRjFmxIwIZgQkAf0njhR/whb7QuM9H7BHnwc9VCQ5u/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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


please fill description here. Then I can look at changes below.

M


On 6/2/26 23:01, Erich E. Hoover wrote:
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
> ---
>   tools/zynqmpbif.c   | 16 ++++++++++++++--
>   tools/zynqmpimage.c |  4 ++--
>   tools/zynqmpimage.h |  2 ++
>   3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
> index 82ce0ac1a52..546b9e4fd9d 100644
> --- a/tools/zynqmpbif.c
> +++ b/tools/zynqmpbif.c
> @@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line, struct bif_entry *bf)
>   }
>   
>   static const struct bif_flags bif_flags[] = {
> +	{ "init", BIF_FLAG_INIT },
>   	{ "fsbl_config", BIF_FLAG_FSBL_CONFIG },
>   	{ "trustzone", BIF_FLAG_TZ },
>   	{ "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
> @@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t len, size_t *offset)
>   	return 0;
>   }
>   
> -static int bif_init(void)
> +static int bif_initialize(void)
>   {
>   	struct zynqmp_header header = { { 0 } };
>   	int r;
> @@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf, const char *data, size_t len)
>   	return 0;
>   }
>   
> +static int bif_init(struct bif_entry *init)
> +{
> +	/* User can pass in text file with init list */
> +	if (strlen(init->filename))
> +		zynqmpimage_parse_initparams(bif_output.header, init->filename);
> +
> +	return 0;
> +}
> +
>   static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
>   {
>   	size_t parthdr_offset = 0;
> @@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
>   
>   	if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
>   		return bif_add_pmufw(bf, data, len);
> +	else if (bf->flags & (1ULL << BIF_FLAG_INIT))
> +		return bif_init(bf);
>   
>   	r = bif_add_blob(data, len, &bf->offset);
>   	if (r)
> @@ -837,7 +849,7 @@ int zynqmpbif_copy_image(int outfd, struct image_tool_params *mparams)
>   	uint32_t csum;
>   	int bldr = -1;
>   
> -	bif_init();
> +	bif_initialize();
>   
>   	/* Read .bif input file */
>   	bif = read_full_file(mparams->datafile, NULL);
> diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
> index 4db9877127e..eb79c0696cc 100644
> --- a/tools/zynqmpimage.c
> +++ b/tools/zynqmpimage.c
> @@ -400,8 +400,8 @@ static void zynqmpimage_pmufw(struct zynqmp_header *zynqhdr,
>   	fclose(fpmu);
>   }
>   
> -static void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> -	const char *filename)
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +				  const char *filename)
>   {
>   	FILE *fp;
>   	struct zynqmp_reginit reginit;
> diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
> index 7c47dc0763b..867fc5294a3 100644
> --- a/tools/zynqmpimage.h
> +++ b/tools/zynqmpimage.h
> @@ -142,6 +142,8 @@ struct zynqmp_header {
>   
>   void zynqmpimage_default_header(struct zynqmp_header *ptr);
>   void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params);
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +				  const char *filename);
>   
>   static inline struct image_header_table *
>   zynqmp_get_iht(const struct zynqmp_header *zynqhdr)

