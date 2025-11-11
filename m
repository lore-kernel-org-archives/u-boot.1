Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41802CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 16:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8225A83B95;
	Tue, 11 Nov 2025 17:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IfeEaSAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB9383B96; Tue, 11 Nov 2025 17:12:09 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45BDE83A03
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 17:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eul/Qvlvj14hlOoTppCkk16F95HPGs8ctafEPF/akRW0/EfrIRk6RDWtEeiKpTolJHRw/yFbvbAvEXLWjpTNzf8nw/W7Fu3z281vhct5+cnl0UItwoArOhAC7e+v9I5b/x/i0IAKwwGU34b3oY8aIWhNwrgJ0iEWuTZWy6ERVE1/r+JqMaPfw7PBm4NBJ2E84lEnylWGt4A1AclFbaFfJffksGG/rgt0L04FMUaOL6Cvy+CGBCy+RjdjVcBqJz0rWHrJtV0FeLZjawku2oVlB4Zq9mi7cYCOU08fzKxPXzhAQ99PRwsItrhR5yI4QOM24FngdPlH4S4lwe72urcE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6j59U3vujuB5+JfgBaSt+t63OhIa3Nl9XavfH08kFI=;
 b=I+dKfxh8e2Bdw/LUm8OzJBYnzFUdIAQG3lAA+FMWtODobQbl2fGQNCHnOYqk9mFLchVU/TzLBriD/qIjX94I4KMCayz6Rakcox+2/D2mORlmdbd8TmJQSwETuq1AUr1ZvfbesmGv2G3Anp4TbTwtgc1E+bMEwk4iskeEUEb6NsFU7vO3+JPxUS4rTrYJjK2th9XRtQPDVr6+5hMvdYFmBfoZathCDUK0mznMoVzs/l/9TJ1eCGs5kvn1S51PzciWnV1c3EG4zwYlsdzpUtrIrR4fTiUi3Gy5rd0Xd61kux2Z/H/38we2Pre1NHEzFPGe7lmZs3FtHF/eBqQZ0fwnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6j59U3vujuB5+JfgBaSt+t63OhIa3Nl9XavfH08kFI=;
 b=IfeEaSAw07Cvpbm32vEqir1BwBRadVvOfhbNKK+ZbkQxFA4mzRFV/tpp5vNsv/PgW8/R6h1FmvoZ/vvqASvuIL3/Pp5rkfydx07Uo9gsZSV4c5D+cgUoPiWGHoTK+5krYFxrLuDFR5ClJLnJI52i2NLAA7HegRGKrVQ0TWqBeW4=
Received: from CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::7)
 by IA3PR10MB8442.namprd10.prod.outlook.com (2603:10b6:208:57d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:12:03 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::6) by CH3P220CA0005.outlook.office365.com
 (2603:10b6:610:1e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Tue,
 11 Nov 2025 16:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:12:03 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:11:56 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:11:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:11:56 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGBt141215321;
 Tue, 11 Nov 2025 10:11:55 -0600
Message-ID: <03940bba-e496-4078-9804-1b9daf6f43ab@ti.com>
Date: Tue, 11 Nov 2025 10:11:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] remoteproc: k3-r5: Implement is_running operation
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar Padhi
 <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251111071756.1257488-1-dev@pschenker.ch>
 <20251111071756.1257488-7-dev@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251111071756.1257488-7-dev@pschenker.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|IA3PR10MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6c01d0-d913-45bc-6fe7-08de213d0d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTdEZVhndXRIWVgzRm96V3o5dlZyRWsrZzk1aEZvOHRaa1BlcjRDbVhZQ25s?=
 =?utf-8?B?RVZWVzhYZitMeXV4eUtmZm85WUxxcmFLMDluK0h0MGdkUGdaSmxhU1RQWTRh?=
 =?utf-8?B?TVpCVURSNEFwbTFkRnJsclNENDBzY09NTTBqdTJMc3V2SkpZS0dXaFpobzVv?=
 =?utf-8?B?aWl4MHZ0c2tNL0UzcHJ1eVVTc3dFMHdkWXBMU2FGbVBEOElIZGpmam1WU3Iv?=
 =?utf-8?B?ZHdESTVUNG9aTlFCZ1dzUHYwRTdIcXNvTFNKbDhWYXRUM3lGU3dkOWdjdTZn?=
 =?utf-8?B?Zm5iMkpDcUowTXVBTFRORTI3Q2tVR1pDNTVmTVhNK2wyRmdwRFJ6M2JYVXdY?=
 =?utf-8?B?b2NJcDJXMjZ2Q1BLUktpYjd2VnY3c2Eyc0hBU2lzWnJkblNVa1BXazZiUXVB?=
 =?utf-8?B?SFhNcUZRMHRaOHlvOGVOcktqOFlqQnRWcURkajdMeEZSbm5XTWR5MFVBbVBk?=
 =?utf-8?B?elFEWUcvZXB3R1FpVEJLbWhqS1ZBMWdPQXpNeE5JWE9YV05Qa3dvMCt0cTZS?=
 =?utf-8?B?Ukh2M0gvRm5xQldtTyt2RWdCR3JDOHhpQi9nU1lrZ3FNTmg1dTQ4SWtaVHl1?=
 =?utf-8?B?MjhXbTFCVnZzRm5DWWZVcW9iSHJHL3RadTFibWRiOXhneEFlRUJneUlxL2h6?=
 =?utf-8?B?aHhOcEFiSkZkR0cvdmluUWdWanFVZDhYYXFUYXJSRDhGc29HdVJNN2R0dkJs?=
 =?utf-8?B?RGZCMmJscEtDWlFHWHA5ekJzWk1MdGdZeXhQV3pxbDRYbE9rN2Y3SVljS3k0?=
 =?utf-8?B?TGVnckZJNnlXVStJRjZ5TllLZzh3WmpNMk5sd1RSTVlIYWZ0c2ZaWFRTUU53?=
 =?utf-8?B?L09PLzZkOS8xQ3E3TzFNTjRreGxpWjd0bVBiS1FENWJTVUpWZEZtSmlHcWIr?=
 =?utf-8?B?ZXZtUjRkM3loK0dqTHZrclJteXRpNk54cEpRUXhBbXVXVnN6Mld2YWFTd0hz?=
 =?utf-8?B?VFY0QXkwNUZhQWhXRzExenRnNFAxQlpmZ0ZTOGpRYWdtV2poRmd5RWovaWFW?=
 =?utf-8?B?b0tBbEhtM1VaVzFUaUMxUk1DdW1LbGgrUUcvUkZLTXFKU3NuVmRqMTdIU3ZC?=
 =?utf-8?B?SnJPTmFrVVBQSUJGWGcvdDk0VHUvbFRWalc1V3FxUkZ0dWxUNU5zTS8vNFpN?=
 =?utf-8?B?cnBGZ1lpWG1yTzNWRXNLbzM2SktDckE0am5kYmRDOGJud29MVUJaRXAzQ3dn?=
 =?utf-8?B?M3pNQ2VSVWQzTnpKZXlVSkJIUFZqUUtsc0hENmg4K2RraWo5Sll4ZzMyaDdD?=
 =?utf-8?B?alM5d3phTUc5cFBUby9FdlFCMHZHOG9iTnZqbWRjSWI4b0lFUlZuOWxiQ2lC?=
 =?utf-8?B?ZUxmY2RlYjhIY3VzNUZ0WlAzMzNHdW10NVovUnQ0eHpsMkhvNnJ3VU5mWDdG?=
 =?utf-8?B?aFphZ0w2R1hobW9ZTlV5eVNQY1UxbmVQbTJBMlVjaGRsVC8xVVBwWEhJelNN?=
 =?utf-8?B?LytvS2sxSUJYRTM4dnM1QXE1OTVDRFdyM3djL2VBUFFpN29UUDJPUDZ3WHp6?=
 =?utf-8?B?VVdlS2I1Q3JiRkVsZGM4am5YSXczb2x1YU1NRE1CWWdSTHJyMldpS0VhYVox?=
 =?utf-8?B?K0hNaWtDL1VaUmd6RktQT0VYbkQ4L0lDeUxiSGtkY0QrTVlOL1B0VldVOXpm?=
 =?utf-8?B?MTNGdGwxZHVOTnd2SFVuQTJRVmpGUURVU29lYjJTaWFPc3VUNWdOZ0NqTjc0?=
 =?utf-8?B?bEsyREx3cFRKSTMvbWE3Vk9kT1FyTnY4ZTRYeG1LNDBpL1BLRy9UL1F2N25i?=
 =?utf-8?B?UjhzZjZ0QlZYSGw0bGN5MFNWcER5YmthdUJIZ3l5WkphbDNsUUNRNy9VQTVY?=
 =?utf-8?B?dVlKTW1QVndkcGFFOFR6dnVUSVNYUGphTUF0N01zNStYdkpxUjJyTTBPeDRK?=
 =?utf-8?B?WkN2MENHZ1k3NUozNmE2bjRNa0Z0cHkxK0FoeWo5cXNmSDNtNzd1QzZLRk1O?=
 =?utf-8?B?ZHoxOEVUV2tZbWVwYWcwVHh4S2kyNFFkSFYvV0NkTG1VRVhYeENJTllvRlZx?=
 =?utf-8?B?elN2bVJ3dm5wRTRTMU4wTFdRZFFWT0RDaVNESW96NStXVlFQRXRlU3dQQ2F0?=
 =?utf-8?B?TVdFUllteFJ2SVBkVDV5eGNYa3BNSlZiemRMTWI2L2NhYTIyUmgyUHFmZFJu?=
 =?utf-8?Q?h0Qo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:12:03.0566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6c01d0-d913-45bc-6fe7-08de213d0d31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8442
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

On 11/11/25 1:16 AM, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> Add is_running callback to query the R5F core halt status via the
> TI-SCI processor control API. This allows the remoteproc framework
> to determine whether the R5F core is currently runnin.
> 
> The core is considered running when the PROC_BOOT_CTRL_FLAG_R5_CORE_HALT
> bit is not set in the control flags.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> ---
> 
> Changes in v3:
> - Implemented Andrew's suggestion to assign size before casting for
>    memory safety.
> - Added Anshul's Reviewed-by, thanks!
> 
> Changes in v2:
> - Made sure there are no build-warnings caused by this series.
> 
>   drivers/remoteproc/ti_k3_r5f_rproc.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index c6356729e9db..7326f5a4b30b 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -573,6 +573,22 @@ static void *k3_r5f_da_to_va(struct udevice *dev, ulong da, ulong size, bool *is
>   	return map_physmem(da, size, MAP_NOCACHE);
>   }
>   
> +static int k3_r5f_is_running(struct udevice *dev)
> +{
> +	struct k3_r5f_core *core = dev_get_priv(dev);
> +	u32 cfg, ctrl, sts;
> +	u64 boot_vec;
> +	int ret;
> +
> +	dev_dbg(dev, "%s\n", __func__);

This debug statement doesn't do much other than note when the
function is called, which can be done with other tracing methods.
Either drop it or have it also print something useful like the
status of the core (running / not running).

Other than that LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

BTW this function would be the same for all the ti_k3_* rproc
drivers, in Linux all these were factored out to common K3 helpers,
might be a good refactor for here in U-Boot also..

> +
> +	ret = ti_sci_proc_get_status(&core->tsp, &boot_vec, &cfg, &ctrl, &sts);
> +	if (ret)
> +		return -1;
> +
> +	return !!(ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT);
> +}
> +
>   static int k3_r5f_init(struct udevice *dev)
>   {
>   	return 0;
> @@ -590,6 +606,7 @@ static const struct dm_rproc_ops k3_r5f_rproc_ops = {
>   	.stop = k3_r5f_stop,
>   	.load = k3_r5f_load,
>   	.device_to_virt = k3_r5f_da_to_va,
> +	.is_running = k3_r5f_is_running,
>   };
>   
>   static int k3_r5f_rproc_configure(struct k3_r5f_core *core)

