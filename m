Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6282CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 06:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A6A846CB;
	Mon, 11 May 2026 08:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z/YmKUCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A314284715; Mon, 11 May 2026 08:35:26 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411F1846B0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbStCoxibe/ovhnJ/VFhQprsjNEQ6i11GBEQ95VosI33rWC6ccimrKGY3jYBlKCitByKELulaMBYWt67r3c/BRY3GHL8JVe5LpmDbwr5ILABdBIzLyo7NqJDFpkKPvEj4fU3p5gbSU7W/n7vJYkowRtZXgvv58xlmPn5kjz6eA3/o4s07pQqThz1JY4WRSUIbIm95F1Tf87pqhVLm7yM83t9eo+k/vcUDgfFioXrbf4tZJvEEbE7GT6d9aTJwWhqT4I3m4Xv/EgRcvCK2U+KrmWzJGoYdKjr4Ult/4DSIPQz/0rPfSEFx74g7sBjg8yh8LYKaXq7msJpH2olOKVZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O78npFaeHapzKV/0TGIqQcMnuiQ1et/H1G26Ve690kY=;
 b=LzFoCi0EInbD0zs4oQCrNo1qQ2swDgxNQvMjHcUwGIDsJBZ2r9SJYxzIE9+xR0ym/lpipVSFIWH3TwSMNUtsIshWRySNqHbRwSFsUElGH9TJ44nIZEb9qSV5ahBlasja0pGumKA9BKBTSHlAXou53SoFZ+XIpfguOnpVG0b+LHoFhebHJzuS/bWgbiXLgG31mekyKPhKmC0NX4x5/YFgL0YIAN8sNWHSaudZgJQMaRahAydUKZa8FrKqlPjb+BvA0/PX85w4fIOIlQGgDh9oxLPkqMe81SZ1N1NLGZCQOrS60QPJttUUNfRFctqIHyJY1MRCnaGnhQEkWaSvPDpPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O78npFaeHapzKV/0TGIqQcMnuiQ1et/H1G26Ve690kY=;
 b=Z/YmKUCfnhfTMrORxCmPlRTqs+gKk1VDY/X9YKyv6S7SsHRnm+nAzMUz0zMuVq12/kBz6VWWmh0d1z/WVoVU0fIThMbjx66y7nWg/racS+Iaj6QHCwp0jRgoBcBYbqQW6RFP3bj80Y25gGJ/Hh+XRv12+/xEnD1fCnv2QW17K38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 06:35:19 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 06:35:18 +0000
Message-ID: <ecda7b5f-4016-44aa-a5c1-73c8947d25cf@amd.com>
Date: Mon, 11 May 2026 08:35:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] power: domain: zynqmp: Staticize and constify
 driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-14-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260508122247.512862-14-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 20253c44-b11b-4733-6b74-08deaf2777d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: J7Ckhy0t/S2gQT7wJkp6FoDohEwVkdLr6Q5Jz3Bzrv/ItrSJoLZNqvPfR2cjWV0WUT11WpVxHjnV5IuMzmJevahgskKXTqksTmv51EQsCUwput8VfrUDSKFc2ZKAuCf99CVfRzVThSuDp52a3SIXKl6U/kBdu1Ig7m1A/8S45uefdI/0avtwedoCyxnl7gUXtpgSjw7+aaqEokl05ISBuKRxy61mzXjpLEyk9jMCKSOKt9A9UVRfz3srpNtrJCdVVIkZukwjRkcsuXm+lAbj5jqHigAMXeojWngoz0uYfpnKNSu8CvfJPbDviHcFTGUgxjIvu11mAcb9OVLkzXCS4w/Zhj67xnHZtakFU2pNkDLc86gcP1Um7DBGLpuAH/88h4LBedrUuEZeuoQmulDbv31YGJ9MOWrf9IjtFZ6n74WNNIHtQ1fk6EE/dZYlCPYHEk9iGjVTlUkH9E8kXSZgk1Qyv+Gl+BVg87fyZ8Q3uENtt7tLMQrHdzfVl4fb8iLcCXVuFXlSETs9LSY7erpsbpHlTG1LeFBuvZT9xiRkZ97++mf9wBX2iy0t7AaPb81V17+ysOnoxdcwRZJlf6NWmItuMMEpA3qIqO+F7CBqEamC9+dqmPwmZ+DwKyf91yYAcvrtzs/2qwoKuG9jnErb/rqbe0HYPgrzAeVS9u1iI1dbY7QRlLzWf5II6oJNEWyL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnEwakRHL1I1VUdFYWVlT2Q3Qld0TWtIRDRLT0xxUTVicUxwV05mOWpHOGJw?=
 =?utf-8?B?Wnl6Y2M1dmhMNmpTdkwxRXNFWkJMMGd4dHd0MDlOa3ZJMDUrQjByR3luY3Vp?=
 =?utf-8?B?NDFjNXJxR2t4c3cyUE91RzR1U1BNWk1ERS9TMzF2K0lyYmhsNVNCUDR4Rldx?=
 =?utf-8?B?MjlROWwwUzdLTmdSaFhYZGZQbEQ3cjd0ek5TSDBIMWoxczNmajYzYnR3RElR?=
 =?utf-8?B?eW5XZGtnYTNWbkhqLyswSElYTDh1dzZhSmZQVG8vcHI3WGcza0pWSTJzcFNo?=
 =?utf-8?B?MWJXdDFKTFJ1eXNwQ1dDRk9Va0wzMENMa29idjdEZS9VYmVxUWhneXlxbU5B?=
 =?utf-8?B?bmg4NWtscW5zTFlFdWN0YVl3V1pXc0w2UnVGMC8yakpMUzgxWTdIUmpnV08r?=
 =?utf-8?B?SCtZclRPa1ova3RGVDVOcS95ZFZzUjY0Zm5uTlpWclZya0hEc05wYnRhMmV4?=
 =?utf-8?B?dUkvZUtkRmJrQ2Y3YkNGaVAxYW1JLzR0ZFNldW94WVUzSjYzZVhGQVlZMEE0?=
 =?utf-8?B?aDRmQW5XRnJtV0d2dTJyNEx4ZWsyNGhpbEF4OTZEcURLOEtoSHNUVUp1U2pE?=
 =?utf-8?B?aWVhQU5KN3dBU05DbGVvNVVCKzh3b0VhZElwNGdGZjNRM0N5Wnp6aFlkclhi?=
 =?utf-8?B?Ym45c1UyNFJmWDYrdG50Y21oSXFHRTZ3NkJ2UGxkUnIvU1NkeWpwell6WWZT?=
 =?utf-8?B?NzM4cVI3enRpRTV5MXBiS1ZLdE9Yd1FpRmtJWmp2R1FLM0pldGYzSTJBS29z?=
 =?utf-8?B?Zk11SmtUdXU3SERFWTQxSStIZ0p5U0hPM3hTd291akZ5TjN4WHJnbU1ia0s1?=
 =?utf-8?B?cjNiSm0zMEk5UzJZZkYzZ0ljZ1hDVjdIQ1Zob2ptYlM0L2VXVTNrNWRaRzRh?=
 =?utf-8?B?US9ybStiTmZZeC8wY1RXN1Q1cTRGbExhN3pGcmMrcllUbEg0TVZ5ZWVrT0Iv?=
 =?utf-8?B?K3dRNmY2TExXZndRZ2htRUtZbEQvYlVqZ2JyVmFWUHY5TkhtVkRyVEdzeThn?=
 =?utf-8?B?a2xQMmhHOExNdnBxQjAvR1lTeUJBeEhGTVZZRi9uRTRScklTYTZZa2tvWEFq?=
 =?utf-8?B?ZFFxVzZOcXNBSTdTMjNpcDVrN3RGcTRaM3RnNVM0czhmaFZ0c1pnK2JyTzZa?=
 =?utf-8?B?bE1jWEU3ZXlZU1h3WDF6RU1LY01iYURxUjFjYVVpMWJGQllQaFgzVkcrdG5H?=
 =?utf-8?B?cEZMSUtMU2p5QVoyVWZBbmMwU3ROOTNLQWtlaEJFSmtvVHJpcU5NbEtXQVJT?=
 =?utf-8?B?bmZ2K3VDbmNwbkErTTFUdXFuV3B0SnBnai93YldVdmRxZDd3cXVERGhiN0pT?=
 =?utf-8?B?NmZQeXRNT3ozUkl6OHdEYTVqTFZPdldPSTVtR25VR2lMTExRZ0VBbitlb2ov?=
 =?utf-8?B?M3F4a0Uwdk1JczVIblZGUGM0Vzc2VEtDT01DcSt5T0I5WTNGSGdhcUNBbmFx?=
 =?utf-8?B?T0l2NzNJc3U3MU1sOWxsbG13bnA1a09OclJScHNlVk5jRnRnUFBFR0FvTlh2?=
 =?utf-8?B?ZDM4RDhOQ1A5NEl5cFRscTgwVzF1eWRsdlcyandya2s0eGVwTkVzRlFkZklo?=
 =?utf-8?B?aGJlMHNRSUtPR01IaEpPN3lyK2FycTREMTBla3pCL2V3N2JUT3NUSDBPWlpK?=
 =?utf-8?B?dGFFU29xNDRWaGpmcGR6MVB3eVVHVFg3U0ZmeWVQYzl0YTlObmw2RVkyRS83?=
 =?utf-8?B?Rnh1S1dnempiN0xpN3Q1Z0drWVNjZlpKci90VjBSSjNYYWtuQ0haT1o5NThQ?=
 =?utf-8?B?YkpZMXFIbnp6TVltMkw5OGtCTitwR2UwVk1hZ0FRNSsyQXo2UmJJNFJhY2xL?=
 =?utf-8?B?K05oU29jenZwN012K2dLVU5aV2pVRHlQeFptMG1RdnpKK1FRQkg2SUV6ZGRQ?=
 =?utf-8?B?TUFsVW1GTWVsb0laR2xFdDFJRUh4V1JFQmRubHVZWWxOVUd1d202aFRDRkFO?=
 =?utf-8?B?NkhLckxYQzZyVDFpUGNWQlZRQ1VyTEdvcEp3K3RzSDNtcmorNDVFcTNTU3I1?=
 =?utf-8?B?UHVkNUZ1MmoxUGUwQmMwdkFjd3dhSmpudGM3WG1ZbWlKU2xlWE5DemdYM2pL?=
 =?utf-8?B?bTcxbzZQRzFVYWU5VDNobG1raG5HelVwekVqQ3RYbUhRRjBsTFcrK202dUtz?=
 =?utf-8?B?d3ZNMDhwWHRoWk1ONktVMVRTQ1JOblRIUDVZMlBPRjZWbmRSVGZia25sLzJw?=
 =?utf-8?B?aDZEMjRLYVFpakRtdHBPVVFiRS82K3VUUDMxOGxjY1BwQytkL3VqVjUxOHBX?=
 =?utf-8?B?QVByMnVsZXRIb0daUlRWaDkrM2JtcDBYQ0tLNkZWQmNCajE1NUpDTnQvMHZa?=
 =?utf-8?B?djZJV2RvRStQRWFnRGVLdlNROUh0bVNIaUZjZ1M1UDdHY2Q1RktYZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20253c44-b11b-4733-6b74-08deaf2777d6
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 06:35:18.4870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOJZv9DIDp71cc5fKG+VyfU7HiOMNYhW8a7or2YXkrZFEk8y1bsVlIdfDJMj0nzC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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



On 5/8/26 14:22, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/power/domain/zynqmp-power-domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/domain/zynqmp-power-domain.c b/drivers/power/domain/zynqmp-power-domain.c
> index a54de5c1439..0acfc54e787 100644
> --- a/drivers/power/domain/zynqmp-power-domain.c
> +++ b/drivers/power/domain/zynqmp-power-domain.c
> @@ -57,7 +57,7 @@ static int zynqmp_power_domain_off(struct power_domain *power_domain)
>   	return 0;
>   }
>   
> -struct power_domain_ops zynqmp_power_domain_ops = {
> +static const struct power_domain_ops zynqmp_power_domain_ops = {
>   	.request = zynqmp_power_domain_request,
>   	.rfree = zynqmp_power_domain_free,
>   	.on = zynqmp_power_domain_on,

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
