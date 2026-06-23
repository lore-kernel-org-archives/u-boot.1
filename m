Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F56CDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091AB849BB;
	Tue, 23 Jun 2026 16:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ahxwyMyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BE1849BF; Tue, 23 Jun 2026 16:08:46 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB41848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxzDjPReU/lq+Y2jeXyf8ITkqYRRWCdjYkz91IExzSCGzQROjpy21mwzoVGhA3QSooRlyj470D+iAJGJVUELQ7xHoboU5E3qDVkE0NEAhUw0BpSIyDR7ZCTVAkHVOyxyPfrvsiD7rIKC9YXVb63gmjpn8SrNMIkoKP0oXJSgSs/H2r27V99x3chn8qKIAYajgBU4/HyV+ofi9zNIl+WOLR5uO8jaEwTYd7S900CSJs6Wu160b7wqbEg7CbsNxrOcYx+3HOgthx9eqd99k4g29IC01A6+DLFOH2D1od3prMRou7QRuLI/bGsOWDIvbX6uwzGU9u3xT3jtP1Mej6QYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO9GqLxPOD5k28QmLoW/C5SwMvrhvYjcclbGslN5Rmk=;
 b=gra/bkyT9zH1cOGE3qekLIWOpRojdlwY3xCOw8rO4d7N7CyjZP5x8XDfeIkrAEd51Li3cVB8So0fSiVorI37lSB/GDYXVEvOVhYTr/3BcQSxAesW1SPrOLWt8Ddyy6L8R+9i0VsZQrnvqimYf8V3sMxPuf4DGwvqiwmA93hF1d0+mgFw54sXwzYc7J+cSwa0D3faCCB0ORjTNDBEEDzA12lvl0eShZtjyCQwEBgYNg3qLKAxG4gMs62jSqeNOSEGVJk5ujZ9CPKPIdya6S/rY63rDmzIOTpHv49DdD+L8Anp1AnuWaog2MMeRGcDrMiXcZltZ4xW/+Nb2p4S74LbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO9GqLxPOD5k28QmLoW/C5SwMvrhvYjcclbGslN5Rmk=;
 b=ahxwyMyqaUllHhser8VpjpNoLPG3rjIjbp0vVEbUc9OmPIWAbYeiFhsf2sTXx4sX5gqop4h6KUcDJS7aHhx2vJFW60Rw0Mv9BmZLW1hmBBXY1hAtyiQdWyDIBpN8VoOl9WhP57cbeEM6DbCTmMv38V1evYBvR6r59m2OgqQ8Xjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::991) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 14:08:35 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:08:35 +0000
Message-ID: <f6ac3655-c6da-4daf-b6f4-73fe41ed4c01@amd.com>
Date: Tue, 23 Jun 2026 16:08:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Alexander Dahl <ada@thorsis.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260428053030.19532-1-chen.huei.lok@altera.com>
 <20260608094547.3026-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260608094547.3026-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5b74e1-fb3e-412a-c3bb-08ded130e9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: awKJw7TrTNZQl2txPrwDd4MPihjqJ1OV9grOyb38z+E3RkdmoXLpdVi3XiDgDh3uJzXNR+uk43N660wQ8h7FO/ZqbFi9bsiZnPPn4yS/Non2WJsujnEeG/Js0EdszkfBwswDiz3lbLTUGAkKv9QWxrCscjdZe/XEDZCNSK+IpTyuOBdKcPWX/X/OkzzPhzYANqK3zf+uxUwXzbDBsOr+LS4c6dzetEXfSv+w2s2P04NEXr8nfTAqbnoxw/6w7PMzXi+u9wIFStxAX4lJhzhf0deCsDA9mB3+wAp4LyM6Lg65biUDipeZi2nA32WFosSpcgj7WOP4y9T1+zOTae/4KvRoLWcubafuNm2QylCcJ335lflk5WJqJ0b6fI0gBlmfkhwpdvU9GTZwwIZ+0iSucoecIMP8sdOcLmcmGUp+6Xs+WJh0u5zbDQAl274G2Zgj3yA6eE+XGBNp/MLk8sSKb7gU8XiwUMbjZbpAgTdqgN3ERSvZAsx+7X+1AHRTsyPEuxqs2R04ZRYXuCiVPPj3wDgl3rILAvHKby3VKhCfRgMlRE+ZdArfl66NxszP+EguMV007WouiUvrF9O7DjdEWoMVy8uTN0NDmUv3l1wP5lEdqP5Kh5057NNllKOb301YWfwAqXc8SEBbH45Em+iOKyQmWCpug7zzXCbJ24kMiGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURlRjVPdTc1SERoNFAwZkpwM3lmeHBYMzlTd2hTNi9TM1lJUEE4NzQvZXNQ?=
 =?utf-8?B?Qk1vSkpMbjIxSU5QU0dKUWRINDVTM0tNUGo0VCt3RzNsRWRLWlYvWmVTem1G?=
 =?utf-8?B?TlJZQWZ2dWNWb2RDbGkyUmRPY01HdTQxdTNvdVo5NWVXVTh1bTdoLzJ4c2RR?=
 =?utf-8?B?eEJ3YnZhNGZuZWlPanRhUzZ4TVNqajM4aVUrdlkxMnppQU1tWXYrbnAyRy9h?=
 =?utf-8?B?aHFzRUVjRzJnTE9zbEN0bXAyYk1qRnZ3MEhBdCtDVzhqWnEvQThLbUV3b24y?=
 =?utf-8?B?RnpXU1lmT2RDSnlIeHg5eXJRRlBrYTdZWlhvcjBOdXVwZ0o3eU9HeG56bTN6?=
 =?utf-8?B?b2E4aFZMZUF3dTN3cUJlYmVFaWRUYTl3eXN1RTdRMzRnU1dJemtURWFrZUo0?=
 =?utf-8?B?dVhFYWdKU3BxRDNHVXdoY05hQ0VGb2ZFb3l5d256NWFtMk5IVlh6QWRNNGZh?=
 =?utf-8?B?THJQd3AxV1M1TXdaSkV4S21vc1RZTDZwYUMrR0tqQ2F2NDhucjIrTFI1dXlR?=
 =?utf-8?B?S01KTGpsVTlubnZMd3JDSG4zc0tYWmhmR0F4TWNkMC85QTcwd0lHK1lDdkVH?=
 =?utf-8?B?d25kd29XSWVrQzVHZk1yMEZaWHF4c05saGJKZmdWSVhCM3NXK3grcUtWbFhT?=
 =?utf-8?B?S3dySW5CU1llUTZmYUg0VjZGNTV4UzhhOHh6eGlxSXhIaHRxQ00xR1JGb1Bj?=
 =?utf-8?B?VkloZUFmRzEremVmNm93azgvU0ZlREJ1eExjc3hkdWZjdU9HTS9mVWpodDJP?=
 =?utf-8?B?QUMvY3NxSVpDTU85aEYzSzVlU3NWSytNcWtPT3crOFR0cTFEcUdjQ1U0a1hl?=
 =?utf-8?B?Z0dtcS9XRzRUVUUycXFrS1lUVFdTc3RHa0RPWHFmZXlIdFFtM3lpd3h4eUdU?=
 =?utf-8?B?bW8vcFVXOUQ3SzVJeUgvWGFZL3NSU09OVTJwY1ZKbCtReHFTVi9VTVorZmRq?=
 =?utf-8?B?b0EwN004VGU3RjVLNlpBTXVpdG5vbCtTWU4yL1NidzE0dnZoUWRvektIVXlS?=
 =?utf-8?B?ZHVtUk1BaG5CKzFSR242T3EyaldqdVlLeEJLbFpCdElKcFcrLzRXSzRRUzN4?=
 =?utf-8?B?Q0R3SnNYOG0rYkd6c3FJRUJWSjVuTTYwTlNIam1raEltbU45cEVnanpQMlpW?=
 =?utf-8?B?dVdsWWNSOGhFODhMbDZPdmlkK29LZUJNY20zMTZzZmg2QVBQanAxcFkvUEdU?=
 =?utf-8?B?U3l4aEZOQk9tWXREOHplNkZyZzFVSUZ2RDdrZ3JYMWxQNmV5OEpvK01XQkFv?=
 =?utf-8?B?OU8yaHVqNHZKUS9jeHltOU9QN3p6UVpXc3VzUkZlRmQ0YllpNHdhekxQL3VO?=
 =?utf-8?B?QVpVTkxuTnplME9KcWJsQWVJNGxwYlNqdldTeVJkNlFFejJZQXJWZThsOVMz?=
 =?utf-8?B?Sm80ZHZkbDhYZkxOckdXbW8rMGIrL3FBajltYk5yRm1VTUpkQkViYTEyZzVw?=
 =?utf-8?B?N1ZBRURYNkl6a0FUWjBTZ3hoOHpjSzJWOGJ2OGphcDQwOWlmUXVOVi9zZ25Y?=
 =?utf-8?B?Z2hLbFpYaUhzL1ZHT2w2dzdsY0lucE9iUGJQY2QreEp2V3c3aEViRGZ4eW9C?=
 =?utf-8?B?R1ZYM0JTQXpDdFpvaURMa0V5OFNpUXBsQkZ5cnJySGRJMGp6UGtBY1N6NWpE?=
 =?utf-8?B?SEhwYVJFZXNDLzJWaEh2S3hmZ0RRVkt6YkZtMUlucS9yZUdmdEdxT2ZEMkFa?=
 =?utf-8?B?WlVPTDgvQlF6dkMyT3RRV1RBSEdydHhCY0ZDTmlpaTdlcU9QM1hvYy90cE9Z?=
 =?utf-8?B?M05xYm9YdlBpSVJWeUpyYlhubjZxQTVMblFRUXBSN3pMb0R2QitKa0RpUlhm?=
 =?utf-8?B?bmZUQVNGMmhuQ0JYV2hyTEp6cW95NkNRR21uaS9wSDRtamhWT1hkRjNaUHZ1?=
 =?utf-8?B?NmJwejBUaU45MDlRalBXc1IyMXE2Y1NwM1ZFaFVvU2dZY3NWV2JHdzREZWJs?=
 =?utf-8?B?MW0zcG1MWkNTVE83SHBaWWd3aEtPTEFQTUxPTElTdUdEOFIvQjQyRkN2TnU0?=
 =?utf-8?B?K2s2b1pnQzd4VTZ5UEYzL2hZRDc5aFdaTDd4RTZiRHFSRGxxUWxiczdGQWlt?=
 =?utf-8?B?VG9QVyt5Mk9VS01xQm5ENXJrMkJtYkhwWmtNVkJwZUdqcVVIUnI5Y2lsak5y?=
 =?utf-8?B?dS92TkVEc2lVdVRRc0xUTjNvNjYwRk9VWURxWUVpZGRrUy9TbkpFb3p4bDBL?=
 =?utf-8?B?NkdqNjlhWlBSSzRCWWxLTkFiTTFmcVo0V25yMWM4Vlc3MXNJb1lXQzlONlVy?=
 =?utf-8?B?bC9GWnpJeDVTZWRqbU5XSzJ1SEFwUlg4S2lURGl3ZEpYNFMxd29XNUxYdDdT?=
 =?utf-8?B?aVdRLzFnUGFrOEI1WW5mVThPQ2k0Rk85Z0JDYXhEOGdxcm9EVFQvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5b74e1-fb3e-412a-c3bb-08ded130e9ff
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:08:34.9164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVYcjCj4J1BwfQ4abhs2hBI52NtsdzrKTtYDDiVR02Y2xdCdR9mYDPVt1vInCvvy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
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



On 6/8/26 11:45, Chen Huei Lok wrote:
> From: Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>
> 
> Replace the conditional compilation checks for
> CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with
> CONFIG_FPGA_INTEL_SDM_MAILBOX.
> 
> Signed-off-by: Danish Ahmad Rosdi <danish.ahmad.rosdi@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
> v4->v5:
> --------
> Fix Signed-off-by to use real full name.
> 
> v3->v4:
> --------
> Replace conditional check with CONFIG_FPGA_INTEL_SDM_MAILBOX.
> 
> History:
> --------
> https://patchwork.ozlabs.org/project/uboot/patch/20260428053030.19532-1-chen.huei.lok@altera.com/
> 
>   drivers/fpga/altera.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
> index 822183c5785..xxxxxxx 100644
> --- a/drivers/fpga/altera.c
> +++ b/drivers/fpga/altera.c
> @@ -12,8 +12,7 @@
>   /*
>    *  Altera FPGA support
>    */
> -#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> -	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
>   #include <asm/arch/misc.h>
>   #endif
>   #include <errno.h>
> @@ -48,8 +47,7 @@ static const struct altera_fpga {
>   #endif
>   };
>   
> -#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
> -	IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
> +#if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
>   int fpga_is_partial_data(int devnum, size_t img_len)
>   {
>   	/*
> --
> 2.43.7

Applied.
M
