Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BBCC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D815F87F43;
	Tue, 12 Mar 2024 16:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pzJ0PHD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0117A87F7D; Tue, 12 Mar 2024 16:07:19 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DC0875B9
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlA4fdTEPEuoIib46aNy5GK7LQpQgT3RBjtXxgpm5cDptqA/9g2IKbC5a/R+srLNCcI8Wu2sdkHw77QWTklp+8KuytVLjKKsWknxGp/APd9bAcLtmRL2jg+4gClQyQfNfviwlyZzXgxNLqqwT9q9wHu0ewcJP/69Gt8bPAQ/wWJXJw7pIfieb4c/zMDz7q1Wd/fbv0T3wX2nJgDQ4TRSjJpcLQIfAPZucr0M6vRJgQMo8WU/w5bMBbJt096VuNkyGbFH9Vg9V9x80iJzYCSyGKACT2o0fJkG+QUYwWg4y23hVHPIJVNbuLx8yP/dpbS2avWqBYIeTgIaFOs2dI9Xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeVEjnuShMbQLPqYsVTxVQ0PE1jm0z69k7ExtBv1ixg=;
 b=PNoDQPlOZzJjQiDhcF/VzxWFhbrriNItfJXQKo5iiwlTFwXI5ONIcFmekImu2T8hrdNOZr8N5Xu/LADzuzbV7FzSl/jOW4fQ/KiFmQZxRwc7xr0n2242u6sUSMAukuRa49t3TZ/dNyq65YUXJO/Tbt6sh6L6LNoriEg2nH4XcUI3ca/UPod3YmsWtkNT8IPnTMFSPBs6NdqNUdnpIK3qGHXdzQYr1+BEkWr8bsNySakeEi/OSLguEAO3gYGO1KbPlChLHhx/pVBSsyHbc7S9S/qUJetEUWFJaruGhbqqJbm/wCY5uFYLJtAG/vLTB7MhYSsh3FwK7Qa1ioFUwzgmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeVEjnuShMbQLPqYsVTxVQ0PE1jm0z69k7ExtBv1ixg=;
 b=pzJ0PHD8AK0qt7Gme4uYfMzOm9VY5q5NjlpJ3h3mgmUu68CiTUr7trcYuh5h0Kp/aTMBJH7gP+ZWRvIU81hMzM0SV6RsojNo5xvlEizCBNQQdPwIOJvF6YvxxKz+l84SfY07pEfYUyajra4y1EnGtiQqsjifYrogEGpnlCuikQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:07:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:07:13 +0000
Message-ID: <3b108860-454c-419b-83b8-f0d2c2349dd6@amd.com>
Date: Tue, 12 Mar 2024 16:07:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mtd: nand: arasan: Print warning for unsupported ecc
 modes
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 dan.carpenter@linaro.org, git@amd.com,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20240306032703.17508-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240306032703.17508-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0034.eurprd09.prod.outlook.com
 (2603:10a6:802:1::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cda4eb-f228-4d9d-f82e-08dc42a618f6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWvO8/rDT4ijpxmioenGYAQt7v6F1499cbMjmgcqqCott9otjtDa6PsRlgPeXuTSG+SmBwKJDqiil5UGNFHMkkabECwLur9IpYG/1743nkyW3BydHR4DZSMcIOTkZw5IiaWfAS+tJ7dBxyTsL2FAbX2YXRbgjortLlmdrqRemcSDQXwTKYLMS+akQd5TIODeAxenu9bzG/Be20ivOhA0Cm9+0K8CWU5+dl5pMKX8Gr1QK3HbDCaoK95FPpKWKo3c6qPqUm/JSuw4hoFpdAEW/YCGivRoI73fB63oBfUWCSSDW1XuUlWXx2BjWu/tJ3vdZl4pCf+7wLyEmfDsMU0GQZ3XLqETxBAO2gCezJGe+ruKU80xzjMVSl8kIhu9deFna5myNCqOeCCJPBwFU/l/6hPOlTh48XkgBMVreThexMjNTvHLZ+BxRQXzcYYvnaE0ff6IuWfjpwElAXH2ah8wfGjVg2ObI238f7pbYUl6kNcxHeLBVCsJHxknaEUukVIwOCB8+UczBylh2k2VSdlqFGLxG/60kynT6QHtjp0spocCpluxV+kNWvE2H2ks2TS4qQgv6hfvXOeGnwD5FXUFTXT7OvQWbxBu7cfOl+0mrURJR2hS1rGuURSlmkXNpYDDcwBvbl3X8wo+KVcfr5P+TTdCWpCMhp66oNvKLHWzXgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a080ZlNUYjNLTU5DTDNsVGpKb0hYcFJvUG9OQ01sMzYwb0NORTY4UGY0QUNx?=
 =?utf-8?B?TlNwcW92VGtNM3RmOEZJLzhKQlNDYzlPTnlsNXVocjFtRFk5OVpZUUNQRkV0?=
 =?utf-8?B?b0ZJSU10WFA4K0RJK042N3Nsa2I5V1NzZzkyV0lPVGNMbm12RlNKT1VEMW5E?=
 =?utf-8?B?alhsdXNiN3d0YmNWSWR1ZzRRREhNK0Evb2dzUCtCVE1CZ0RpbHBvV1A1WDFr?=
 =?utf-8?B?ODJodVVHWEpjS2hFMzFJMlJqVE1vWUs1eVpsL2xKR2FxMy9yMjI3RktDdnBv?=
 =?utf-8?B?TFJmQmVhTGdXM3Q1eDd6QWNPcUxuaEd1MUFIYWwxNlpqNGRPUTBGSGlFVVkz?=
 =?utf-8?B?YkxBTjc1bDNqVHRBRGdBUWNVSFNENm83bkhTZDM3Nm5JMzh0TGYxQVJTNEVm?=
 =?utf-8?B?UXNoUitPSzlWSXNCRVRIVGN4eXlVVHI5eEJKblNmVFp6YlU1WXVVZ2YraURl?=
 =?utf-8?B?K0ZqL21xSnlDdUlRUy9FZWRrdGlLY0hmRlIwRXErYStqQ1B3YURiQWphVHhj?=
 =?utf-8?B?alVwTVlFVU9Nd255WUR3dDB0eFdJTEtjaURNYnE4S2FkMHBSSzNEYnRMSEI0?=
 =?utf-8?B?a0pkTlpxa25XOUFoSFI0YkdRNUNPamxiMUdvd1I4NENVUVJMNTFlRmNsMDAw?=
 =?utf-8?B?eG0yYURUaU1PMTd3NkRBQUR1WG1EZXBVL1RJV2dnWkNwZDdiQm04NXN0UldS?=
 =?utf-8?B?a3RsajlOVjZIUmdMRklCMXFJdTVGZUJoV0J1bjJEblNBc0xieVJMQ2IwUEpi?=
 =?utf-8?B?OU1nWFBEZkpNTDB3RHNteWw1YU1lc2pPaW14Z2JFa1ZHRTBsUjNxZlhlaWZH?=
 =?utf-8?B?Nm9mM1luM0pGTWNEQVdsQUUyRG0zWnZ2NmhvYjBLN3BLOGcvUWdpaFh4M3B0?=
 =?utf-8?B?ZDBFVGcyY20vVjJoWWNZRUp4VmNsMEpQSERhd3NCSlRNTGhNM21FZUwzZjF2?=
 =?utf-8?B?cFhKNUN6K2pvUVJ1VFBaQ0RlWEVpcFJRVDBKQU4yR1V0QmFYYjcwRFljRlVy?=
 =?utf-8?B?K0k4d3pRVFA0ajFtZTlBWEk5dUplOXA4Rkg5ODRaaXc5Qnh6cyt3Sjk4NnFi?=
 =?utf-8?B?Vy9ZZHZqaEwrNUVCR0JPckhMOVZ4a3V3bU1FaTB3ckFPM2tLTGhHQVFuOS9I?=
 =?utf-8?B?M3gzQmQvekdyU3BtMnhzekVXclRJREdDUlRpd01wY2RuOXF5N200MEtJNzht?=
 =?utf-8?B?aHc4SWdCZ0UzR0I0MWV1R1Npa3N3cGQ4Wmh0ckgySFErYnF2bGk5aWdzbkVN?=
 =?utf-8?B?SjFvdHpwRklndzJHL1lPWElzZzZjYUNCMzNQQlRjMW1PWXNkYXI1b3g1b3dz?=
 =?utf-8?B?eWVScnJwM1NlMGNhR0dzRG55ZnJiV1FPMkh0SytjUHVCKzJob1dIY0JCQjB3?=
 =?utf-8?B?UmlxbGUzWnVZN2ZSM1Q5VXMxV2haYjlEbkRoSzlWcTA2aHVsTmpFY0VsR2k4?=
 =?utf-8?B?RkptcnhUZGRySEsyTXFVK2dzVzdUTWZkbUVIcXh3SUZmWjBhamtsZlZ4YU5U?=
 =?utf-8?B?VFBmVjh0N2V2YjhpQW5qYVY5K3R2Z1lVbldKVEdxQnNLVTlDQ3BoZllocmVJ?=
 =?utf-8?B?WFhpamdWSlZIRWY5ckV6VGZnM0V5a0pod09vQi9MM3Uwck1hYWxVSFdsck9W?=
 =?utf-8?B?bTJFTVlCWEtUZXp0cmdYT1BOTzVrNlhaM09oSzlEaVI0UVlmWVBwTGI0Wlo3?=
 =?utf-8?B?aEZSMDc2K2tLdFFxdTZacmtmRVQrNzFPRi9sUXZRUTgvK1hWdE5BL1l3OG0z?=
 =?utf-8?B?UUozWG5LLy9CWXB2RFNRa3cxUlZybEVoMld1UkpDS2wrY0FTMEptKy92TFlW?=
 =?utf-8?B?bXY0QTJjbXU4U2RkRnh6QkFjb1d6Z2ovUVRMSnpoWFRzR2ExQUVZeG1yeGFE?=
 =?utf-8?B?TDJzSURXOVhkTGZ3cmlCM2lXUjBiamV1bkZ3Y3FTMUl6bGd5eUpUS0VPQW92?=
 =?utf-8?B?eldYTDdrOHYwdFNBRjJHaTdqT2RMQ0FidGo4cWl6N1hHcFl3eUtvdzRmdHQx?=
 =?utf-8?B?S2txTVRKc0pob1g3eVVzMWROOUtzVkhyblNTQW4zWVlTVGZoQTFjUEovSFFl?=
 =?utf-8?B?dkJaODEwdld4UWMvL2NGR0hvK0dDTlozTHhDNUtkT2JxQ2dHOU9UaXFkaXBS?=
 =?utf-8?Q?i6WVCl1nPrRt8WZZAWTh7Eu0Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cda4eb-f228-4d9d-f82e-08dc42a618f6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:07:13.3238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdf08gVOlTAPzjtjIxlQACMutw0XncJcOGvU6rtVYzGCfnTUHoTDVsSzpZ90YMYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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



On 3/6/24 04:27, Venkatesh Yadav Abbarapu wrote:
> Currently only hw ecc is supported in U-Boot. If any other ecc mode is
> given in DT, it simply through an error. So better print
> what is being done.
> 
> Revert this patch once soft ecc support is fixed in future.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Added the ecc mode check in the arasan driver itself.
> Changes in v3:
> - Skip the driver probe when sw-ecc mode is present in the device tree.
> Changes in v4:
> - Updated the commit description to through an error if other
> than hw ecc mentioned in the DT.
> - Added the NULL check.
> ---
>   drivers/mtd/nand/raw/arasan_nfc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
> index 14766401bf..0b1b91f771 100644
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
> @@ -1263,6 +1264,12 @@ static int arasan_probe(struct udevice *dev)
>   		goto fail;
>   	}
>   
> +	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
> +	if (!str || strcmp(str, "hw") != 0) {
> +		printf("%s ecc mode is not supported\n", str);
> +		return -EINVAL;
> +	}
> +
>   	nand_chip->ecc.mode = NAND_ECC_HW;
>   	nand_chip->ecc.hwctl = NULL;
>   	nand_chip->ecc.read_page = arasan_nand_read_page_hwecc;

Applied.
M
