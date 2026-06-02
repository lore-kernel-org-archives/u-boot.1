Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C7FCD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 14:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F7E84855;
	Tue,  2 Jun 2026 16:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q6k2oynv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA208485F; Tue,  2 Jun 2026 16:34:24 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA43801A9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 16:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tn70mD4rhoNOsYHyyYJieQbbE7yjVPw6SnFCBQdX7VddMnTQd0rkm8m7diisvvqOiclgl6rKoDZC/XsaP3+Hc8KVJU0tjqkoWCGLc+WquE5yr1qor1QLC+EaT5b4CHGODlNYFThPvoOHW4jj2POsbsCZ3DEkH+w33kOz8VTO0RQ04e7/0LyXVZ27kVPOYj+zD3dl83k79lVM5f4yQxCGNCmTSnvOGJfurc8/CJegi2NVmCMFsznBMFiH3grmilcrxpmnOzvDhqqyLKep5YbIL/hLLAjcs0VFUDjgXebfUrwckfc/iQOZpIIr3e8QI7Q/3tgmNJKOo+rf1GTM525NAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn3yml5qTDjwKDnrtJlTUxXKE1P2ekPE+R87cgXH6/A=;
 b=iPBlfS0Ft2X8dCE8Eo2K7nPFUVdeALb4mXKxfFmDzXMYnpe71LWsj+p7TOxJs4BdoxgJmOzutE/K4nuM7fOi/KR7dZamA2OI/DviWFJjmaIQME1vC5RHfnMkvvTkfPZOVWGcdpaKf/TaZU+fwyJvM3L4ox1bXxw28rMiJfedUrIFPCQn0Jtuhtc77xZMVmqbYTb/IzOPD3xmuNXZaU3w20K2U9jBfN4M+1xX0MRLeiBcEgthaHeGSalARPVdz89MDKx+TJ2NS8ps2BopUJnCOftCqD4RAnghIU1mFHBmDQEZAQsv2HDu4fEtogbA4X+QHarKleJCPdFX2zZM7XzB8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cn3yml5qTDjwKDnrtJlTUxXKE1P2ekPE+R87cgXH6/A=;
 b=q6k2oynv0LLU/qqMBV/2e7GLfY+7GQ4ROdlsWShF8DQQWIBhkafnJ/EuDIpT3rOJD75rkqyNYIFt3kiqbb+J7/78G5PDRrDt/mXqK+PUAJFO1gSutlWPgTt9I6zmrl9g/OPNO7qpdSB9XTg6h6YVCEi1M/ANzsaWo/LtGPi62Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:34:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 14:34:18 +0000
Message-ID: <ef49a049-f9fe-4292-b0e1-f6ca5d0cf22d@amd.com>
Date: Tue, 2 Jun 2026 16:34:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Fix snprintf invalid size argument
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB2805724A10F29A279E1F4A36DA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <BESP194MB2805724A10F29A279E1F4A36DA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: b6df2a5b-711c-49d3-b56c-08dec0b4077c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ourkoJaLQPwjTyBPxV2h84CnS48Kb9eQKFwq6H8bEj0Z0OgilhvgNQXQjGK8N7Bup3QhHT6NQFaH/VpfXCttpmD4kWaCapUsMA+7AFwIqeyloPbArgNKNrZumgYirW/WMhCll2AUzz/AiJGM9VrQb0ix50UdSM6WuSzFquI+2fSkXtuH8z+NCYyKPX8vtplNpWmrql0Cb5ZJ4PnHMpSan1YyxcYgGtlZJjGM8RzeT9x2Jzft+J4wYBLKk/QY/Gbd60loD4CkhZL4Ub4fJwFQ+a9kDLd2UcNRBqZdjNsqwH4GYVp0BH3HkgMnAEwfiFD8xxROcMZEYENaE6DjWmFHkuNFTx9hHjKvJMd+zHhK9Scq1KNEfTxSCyeDzczIq0F7n9cjqa0ZikvJDyTNdr1Gp/cS4Q3V5OmOJdStJ/5RaZTTZqyryyTichOCR+jsksYtv2F3PygmetidAwiA1Q4RabGKKvUMcwU//dyVbumlph8E9HLyHJGytWXg+a9cLyKxIJd+hJFqr4odonsZiccLT7RBcp3CCMXTqeivC5KpoaQpQvDR+/d6WMR/Hu27cuA7b6lLGlkN5fEVu8dJhoBt1DRpG/NRxhmtOllXT5A5K0n00Nh4wLQ6b6fg3o0+WJ1VzPrW955HWFp/VKRF06nVOOOwB14WM4uk5+815f7bi2XmoavJGqN0Z1U2b1+RnqFe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hybUYzK09pTytNR0l0dzdFV1JxdTNNTkR0TmJqM2VrRVhWL201UFcyQkJq?=
 =?utf-8?B?aGtpUDNqRjArU1N5MllNYWp1b3E2ZTdjdXZLbk54UUtrNE9CRGZSN01Bckhj?=
 =?utf-8?B?UjZLQzM1dXlEemhDUlZUYVppeDFTN0lRK1AxK01yVUswK3NIaG5YUVk5aGlZ?=
 =?utf-8?B?RUMwNytwYy8zZ0ZIZll5QjhiZDU3RUY2T2tBOTQ1Z2QzVFVJMjRrUTQreERv?=
 =?utf-8?B?YnVlSGJwcGRZRVpHYTNYV1NhR1o1TUI3WG8yMmVBRDIwZ3ZaNzE5UlZrWUtF?=
 =?utf-8?B?WFptYzRFVkl5Ujh3VnRyYTdIYnFiSWlEd2VRcm5BQ1p6ZGk0MXdkL1ZYa2E2?=
 =?utf-8?B?WDZkWm1nYTFCa1FNbDdYTEJyVDg5allTQlpINDFzakdGaEIzS1NCZWlFWUs3?=
 =?utf-8?B?SjFPbmFtaHNtUG9rMEc3N1M2K1JWZXJFdFZ5L0pMUU1iY0Q1WnV3eDBsUTk3?=
 =?utf-8?B?VTNadW5XREZnOElKbGJRSDk0MGw1MjZ2WDc1cjBidkR1Q1lkbU4wNEl2Y3Zh?=
 =?utf-8?B?WGttMm9TcXplK1pLN0lkZ01vYS82MCtoSVp1WTRmOFR3aVA5NCtGc25sSlpU?=
 =?utf-8?B?UFE5d2J2Z1NzaXZjSzdnS2RYYXg1OWwyaVdESmI5VDFIemFoZGlyNFRBdDl6?=
 =?utf-8?B?ajJjZTA4VWV0RjlnZG5GTlZaV2pBTm1ZbFdLbGNhWk1CLzVlZEVoWjFXQUJO?=
 =?utf-8?B?MStsRG4zdUFheC9LQlpobHpjWUlFNVFKZ3NibEd4akZMV2FaZ0w3eUM4NGRB?=
 =?utf-8?B?M3UySW9FTUFXTmhVdkt6MjY4U3F4UjQwTU5vRFdyS2dDNUo5bVJKeW9CcVdw?=
 =?utf-8?B?MENPWi9KWTR6Z0tGY0NOUXZhTnMvZmNVZ2t2S3ZleEVqUXJCSk1pdWlwdkJi?=
 =?utf-8?B?bGtrbUhSZDlIMFVtY0Uvc3hYTWpQSHZZYXQ4SmJTeG1jL3F3MkZEejNPQ2pZ?=
 =?utf-8?B?cjkrTzdELzZzSHBWWVQ3ZzJhblZ5Q2JkODhoNDB4VWhhQUVlM1QxYXI5cWor?=
 =?utf-8?B?Qk1IbWxKb2ZyTkJhMVBSQThFQmUrNkNKenF5NmVCY1J5SEVpYXVSa3g2bmhK?=
 =?utf-8?B?Zjh2RjNPODhIdnlTREJrWk56Z0gxZFd0T1l1elJBN3k3N2U3TU5YVUxrZVIx?=
 =?utf-8?B?Z2hkWGxXUXp3QWdvSmhpOUxjZXByZjJ2NS94bW8xVzUrV2VZVnMzMC9IUC9w?=
 =?utf-8?B?WUZmQWcyMURDM29uQU0vcjFzdXNCdFdPR08rZys2VnRjN3h1U0RHSGJGcmFK?=
 =?utf-8?B?RG03OGY2UlBHbzhjSmF2VFhnTkpUMnBEN016YytxZUR5cUpOcXF3aktTeVVZ?=
 =?utf-8?B?Sm5XUURaZThEdzFXZFNjU0pLcVU5NzArY1FtUzdKMGRYL0ZsRlVQMGlCSkQx?=
 =?utf-8?B?dUVDRGJnUW1rckNUUjRUS25ab3RnRUkrSTYvaVdXMDV1VEl5VGVaZU9ybmF1?=
 =?utf-8?B?SUhpMHNkbkI1Qm9aZDlyQUgrcE1XMTZTcmpFNS9OT0JIMDVZZ09hWDFERE9L?=
 =?utf-8?B?NVFaSjNIY01xZDZsSHNMeTJyTHFsdzNoR2dBRkQzNVhJM2JoNlhNZkhuVllK?=
 =?utf-8?B?QzI1dTBFTC9NUmlUcmZ0TmJSSnluU0VZck5oWU9VMWRISUVGRmRDUTVPSUdF?=
 =?utf-8?B?amJicEJ1THBEdWRrdzJYQ051b2lRbnU5Ri9IZEtPcVRaSFpPWjh6bFo4ZEJY?=
 =?utf-8?B?QjFwaDBEVUpERGg0UktCemtSUlllMkwxSlZ2b2ZYbUJ4OEx1VDdQRG1ES3lD?=
 =?utf-8?B?cGhhNkNpb1ZZMlBTWmxKVExJTm8wNld4VVBOYVoxS0gyZ3p6SWRNRE1mRlVW?=
 =?utf-8?B?SlhNQWFrWU1WbTJSd3RlMHZKRmc4VzdiUjFvMCtrSW5zNkZ6SWZ1MFV1WGtr?=
 =?utf-8?B?SFZtK05nWWdvMU4wVEJBWnBrdzE1S1RIc21nNHlBekh3eWswakNNVUsyRWNK?=
 =?utf-8?B?Z3ozUmN6UkdMcXJJNHozMUYrYktVUTgzMFZwTlh4OU1CR1J0Q3NGYmMxcTMy?=
 =?utf-8?B?WThtN25TaitLVTVmT2N3RzdjNERLVlhESDFmU3cvZHd2cUttQ1VWZDc5ZCtT?=
 =?utf-8?B?VTFZTCtxbGpWR0lSb09seGdWU2Jpb005bVdqUkhpYXp0ZlFadlFkQ0hTdWtn?=
 =?utf-8?B?bnJPU2E2Z09wY2Q4UnhCMittMStwUDlkejZHdENQNndhYlVVT1kwUDN4N1Yy?=
 =?utf-8?B?WVl6Vk5NQ1lRbFpsd1lUdG4yejZCM2x3NHdIM2tqbEJUaVpuUFVtVDJnSXpY?=
 =?utf-8?B?eDh6MFZEeE1WalBPK0hWZENab3J0VXFwT0JjMWtpZDBXd3V6LzEyR3lUUmEv?=
 =?utf-8?B?WlFIUE5aekpNdmd6NE95UzNXcDBveEUwRVcvZEdvcG5qbEJUV1FkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6df2a5b-711c-49d3-b56c-08dec0b4077c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:34:18.6874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL2+1lmUSPCfrIpIzX6E7W7ajoxy37DzyT16PJvB4L2n8EEH2VOc/RdQwvltHHHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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



On 6/1/26 15:05, Francois Berder wrote:
> buf is an array of size DFU_ALT_BUF_LEN bytes.
> It is gradually filled with data using snprintf but the
> size argument to snprintf is kept at DFU_ALT_BUF_LEN,
> making it possible to overflow the buffer.
> Fix this bug using the correct buffer size:
> DFU_ALT_BUF_LEN - len.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index a1d8ae26673..272e92d8465 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -706,18 +706,18 @@ void configure_capsule_updates(void)
>   	case SD_MODE1:
>   		bootseq = mmc_get_env_dev();
>   
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
> +		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
>   			       bootseq);

There are two issues here.
1. line alignment - checkpatch should report it.

2. when you are on this one and run small example in u-boot

         char buf[10];

         len += snprintf(buf + len, 10, "1234567890ab");
         printf("Len %d, %s\n", len, buf);
         len += snprintf(buf + len, 10 - len, "cdefgh");
         printf("Len %d, %s\n", len, buf);


you get.
Len 12, 123456789
Len 18, 123456789

It means when buffer is full you are writing even behind it which is also wrong.

but when you change it to

         char buf[10];

         len += scnprintf(buf + len, 10, "1234567890ab");
         printf("Len %d, %s\n", len, buf);
         len += scnprintf(buf + len, 10 - len, "cdefgh");
         printf("Len %d, %s\n", len, buf);

you get
Len 9, 123456789
Len 9, 123456789

It means please use scnprintf instead.

Thanks,
Michal
