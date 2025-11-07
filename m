Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEC3CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 15:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3D483D8B;
	Fri,  7 Nov 2025 16:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oKdOugeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD24C83D9C; Fri,  7 Nov 2025 16:24:39 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0509483C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhUo9ZJvPowO/xqwH5sCrkUhgs993gCyKRWgBpsGH2wVJ7t+RtduAEWnR7JjeKbhX+35HNk62HHhCszAA0BoxFsFrJRcFqZ7TnB3UBjV35BArs0cmEC4fcTzRtQ2JyeafF1YmXG7Oe2d31/qaRjS9j62sAWxzXT/4Ai12DfnQgAprMPKhcHPVts21fh+IYWiB4WYbtUhS6b/IbeFRQwJTGd8FktVreQwmLw3txQEaYO6ImbMGUg9gH9uh6onEmkadha5GcBD6m/pMXAnB9/0N44p9OiJJmshU32NyIRAx8gJveY2vdAOBfAJ88VuBoOkCLzhMzE+GMtdkzpbOhlbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3vpVi0YJlLaSMBK0OH1CLMzz4drFwwY6KxqG/AvGMA=;
 b=RfW6zxGGoLb2/vpxP7m4GYqzY2V0iwez+IoPDE2BMWf52Jw+5lSoy/+SQ+wTsYCA7aHJowDLRij+jqZHEL7gU+S0AqrQlb3GNfSnKYPlJjVOz3JSou9VuNxGwmIHfs3x0DVhQubButlbTr1Tonx3ZUao1gyv5GjwoSg08HLPd5Vtw1OB5hcyzsiyjvpgs1F3AcCnGSh5n3kJCS2eLnM3VLLpdzRIgeqiB04e3qDNsFMeq6IKSpddCUYzegT+9Dj+/V9c/0iEncbI71pEv3aP4yE19svaj4rg+bujpBAY0HTUwYTggx9aXdqEqm4kukgyi7PVivxnKj9TtY37fngq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3vpVi0YJlLaSMBK0OH1CLMzz4drFwwY6KxqG/AvGMA=;
 b=oKdOugeKyIYKxjjRjvEP1g5fh+ERtR4YsLu/ir7zd/q7xVetSIqb2tqH+e2cN5gCwHL5uw7irlgmaSze2/e6TqjyJ679QQn9vG53d4kw/CiAyfkNsGBTsxwUHzTKg6no0GBe3V0leB07xNvNCixjwlLbmRYxYb4YYeVJtlXwoec=
Received: from PH7P220CA0099.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::23)
 by SA1PR10MB997655.namprd10.prod.outlook.com (2603:10b6:806:4b4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:24:33 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::c1) by PH7P220CA0099.outlook.office365.com
 (2603:10b6:510:32d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 15:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 15:24:33 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:24:25 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 09:24:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 09:24:25 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A7FOOiM3227449;
 Fri, 7 Nov 2025 09:24:24 -0600
Message-ID: <57ada562-c774-4ef2-8739-b899e5df416e@ti.com>
Date: Fri, 7 Nov 2025 09:24:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] remoteproc: k3-r5: cast size to size_t
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar Padhi
 <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>, Hari Nagalla
 <hnagalla@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20251107130216.3084134-1-dev@pschenker.ch>
 <20251107130216.3084134-3-dev@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251107130216.3084134-3-dev@pschenker.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR10MB997655:EE_
X-MS-Office365-Filtering-Correlation-Id: 216756f0-74d4-4388-2c19-08de1e11c0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW1mZGpNQ1hmQVRzYjlNWURJTHNKNzJrdWZadWcwTllRTDY4a24rY0krYnRo?=
 =?utf-8?B?YnhmQzU1ajhINW9oOFd3SkpKK3RVbWR3VU5vRmQzQVBnNktlWHpLb0NDcG42?=
 =?utf-8?B?eGtDMFhNWXR1bjYveGNtRWE5QUhBWkRXeWppVzgxcVVUOCtwTmdoaWhrdXhr?=
 =?utf-8?B?R3ArNUZ4RlNBNVhGcFFWa0FybWhKWXppYjdydWRScUJCOFltTUE3aEpOckla?=
 =?utf-8?B?elJtU003V0Z3NUgzNm1ZTWh0RGlaSXQ5TklZZWZzdzJ1OXJHOWozWGg0amI5?=
 =?utf-8?B?VUxzeVJZeGpXazJ0Y2tXYkd4WEgvK2JDMGpzSjFqQnhEdUJrdmVSRHlsb3VR?=
 =?utf-8?B?RTArLzkzdjRteTI0cmxpaTBJNm4rZEFFbUVYMWZDSXB4bTN1cHZXeTFLcFJn?=
 =?utf-8?B?OUFubndKUDNyWnlXUGs5RUI3UUdZS0FhK1BMRUtMQ2xqZnM2MStLWStlQ0Za?=
 =?utf-8?B?ZFFROGcrbDJWdlpHOEdIRWl2OFpWVzc0OEtxQ0FiMkFSSnNUZFFSb0VVNFNz?=
 =?utf-8?B?cnIyL0VQeC9WZUpiTWlTQWo0M2JIbzZxT1ZyUlpLazg2dDhwdXc1dGZOcm1U?=
 =?utf-8?B?NEJHeTVqcnB5UVRsNys3WFRHWEs3TlM2N1V1NjQyMEVsSTU1MDFwNjUvM3Vp?=
 =?utf-8?B?QXFjZ2U5L0djNmNoZDZFSm5BSGpLTjNWYkFaN29EdUZ3US9kdHQvVDN5cHVz?=
 =?utf-8?B?QkNFOUs3SytpRlFJSWgxZHRHRnVhcndwQjUvSkJFMTRxaVJVelRmUGhoMWN0?=
 =?utf-8?B?SEhoaFZKZkhNWGljdDlSelVvbDE2UWpHZWtEZW5vQzFBOGFROVRzbGo4cit2?=
 =?utf-8?B?aFg5NVdPQ2R3RnBKMkxqV3NOVnJqclZiZGYwT0tWZXpIODlvVm9nWDJxZGp1?=
 =?utf-8?B?ajJGZlZlYkdCLzdRRjRPcDRsWVI2RFEzSnlsamNvRUsxdHQrcW83RVBsSStt?=
 =?utf-8?B?NlNjTW5vd3NMb0ZWUlVORitySTRWR1R6cU9XZWl1MHNlRUluUlMyNXQ2cHZZ?=
 =?utf-8?B?eUFHYlVQU25XdEhWWVhiWlpxVHpSbS8xdGpCTFN2LzZIblN6OWZaK2lvamtG?=
 =?utf-8?B?cHRkYmI3Sml0QkFRODAvblpUeFVGMWpyRnN2d2RVQ1lERVRUS1E3SVdnTXUw?=
 =?utf-8?B?TmxOb2I5UTNaUG9CeXptcWdoQm5TRUxXbFZBeGxvSWVPdnc4UFpHYUVtcEZO?=
 =?utf-8?B?VWRVYVltY2V2UFFnYzVWSURSQk1lZXI3N3U3ZzNmRm11K29TeXJNYm1oVVU5?=
 =?utf-8?B?YXNIYnRaTVpxclZmRk1DOFpjWDgveGxWamhPNk51MWFvTFlURnJhZFZDMVYz?=
 =?utf-8?B?K0ovTGxPT0FjMndXdjU2S3BGeEQ5djJ6U1BCb3YyYUF2WXVEeHFhR1lmcFVC?=
 =?utf-8?B?RlN6V0RZb1hUaVVIQmVWRmFVY205OXJKUjhNRjZYVGkyaU16S2tRWmZidTVs?=
 =?utf-8?B?ZWlKeUJsUHUxZmU4MWJObU5OdmJpb2ZCR2pmbkF6VE9VeUp5M3RFUmljMHM3?=
 =?utf-8?B?RnAyeEFQRWNsS3h3bVNXdENCN3Ayc21BWkRKUWt3Zmdpd1JRWXkxRXltdS9v?=
 =?utf-8?B?QmorcXgvclArYitTRUJQMGp5NFRRTld1L05RNUY3K2N1M1JCNXBCV3ZXeHBP?=
 =?utf-8?B?K1dtbVNpaTJrUmRpMExkZTBQSHVRV0loeEdxTmtTbUVnanM2ciswNlREN25K?=
 =?utf-8?B?emkreFpBYVF2RjkwZTN0MFYrdVJBOHk1YTVNQ1lTU2RORFJpWnoyRUQwUzBM?=
 =?utf-8?B?L1RWM2JqSVBGTWV2UW5tckl2d2QrZTRVNDBsQlFJT2dibFVRR0FrcUx1Zk5x?=
 =?utf-8?B?S3pXMTEyZ25ad3NwdnFQejJXa0lBZGVLT1ZwVHplL2JINkdRUXk4ZnVETFFB?=
 =?utf-8?B?YjVjcVF5NUswSk4xZk1vNFdwVW9LWGhINGxnNHZnUk05SDVEaDZzT0J3VnFm?=
 =?utf-8?B?RXFmNytveWdweXkwUFpaS2Z4TE1WMVQ4OS8rSmtmOXU3K09Wc2tpQy82UTZu?=
 =?utf-8?B?YmhWYU12UjVtc3dhdGhlbjVoQmJxaVZWU25TZk9JaXBiU2l5eTNHa2xpVW54?=
 =?utf-8?B?TkREYkUxQzBncFRsQVBnTCtRM2xsQ09LcnUwL2hLYjVGbEFjTU45UVpGaXFr?=
 =?utf-8?Q?HaNI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:24:33.1836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 216756f0-74d4-4388-2c19-08de1e11c0e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997655
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

On 11/7/25 7:01 AM, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
> passing 'size' (ulong) to ti_secure_image_post_process() caused
> a type mismatch compiler error.
> 
> Cast 'size' to (size_t *) to fix it.

If the size of `size_t` and `ulong` are not the same this doesn't
really fix the issue, just silence the compiler warning. If ulong
is smaller than size_t on some platform we will read data outside
the variable address when de-referencing.

Might be more correct to assign size to a variable of the correct
size first, then pass a pointer to that.

Andrew

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> Acked-by: Andrew Davis <afd@ti.com>
> 
> ---
> 
> Changes in v2:
> - Added Andrew's Acked-by
> 
>   drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index c738607c1092..e7bd97a9088b 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
>   
>   	k3_r5f_init_tcm_memories(core, mem_auto_init);
>   
> -	ti_secure_image_post_process(&image_addr, &size);
> +	ti_secure_image_post_process(&image_addr, (size_t *)&size);
>   
>   	ret = rproc_elf_load_image(dev, addr, size);
>   	if (ret < 0) {

