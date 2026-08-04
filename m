Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FDDC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 15:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2819880C7C;
	Tue,  4 Aug 2026 15:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R29nMg8lODKB; Tue,  4 Aug 2026 15:13:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AFEB80C6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785856436;
	bh=FMIhwm0HGK0GP4lW4X0zBGzQB63NyK51RyTy+v3M9CU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PoK8l/Nk8YL0j3EbggKzbFjwFX+88ov1r4L/3DXN5KogOoF2BsUlNAtxc2CkrVjvn
	 BpjJhq62/rdJQHVYPHuYz/bXqyNVrvvLqperuvDVXki0ObohUjoWDEx+tmbPAlLe9G
	 3SvAXJv3imWKuSzqWXmGW3Ahb1Z0VxhKgIVkDFOwc4LZCLA4qgRWFcMvrlcXKPlWK3
	 QOoYiI/GesvstHapw9GfdrqqZ7d758B7N5KgS3bBIqf5E0m+eWqXJ/Iz/WXS/1kMG+
	 7BTz96TCQjamyA9xcTnDTP/q/rsNaMZRMVGZzcX5SVFqR24I2gA+juFE2n+zp8kl7h
	 alvwcXJ67FgPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AFEB80C6E;
	Tue,  4 Aug 2026 15:13:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 160BE218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07F85405A9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GykvrgIKAh-J for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 15:13:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8BCB740515
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BCB740515
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BCB740515
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDJVYWZyllN/nhrD3zJ2rhXZzgKSbOo94ZTiC90tU1VJaa4wL+WhOrLV88EMF0ZZLnhP/WDuk1U5LUODzJcJRHEm8d4vsrovh0ph1C1jrYid44fg1Ma0UCfKHJVotAT0ZnOHKmk/YITA0aCN+KAJfgKcyp8XEpsrK+7NU+qDGnxUft9ljeoDeroRFNprBHqgi1/By6gGY4AdyPpxsnONmi4vrSbQGmSW4YT/Grqp45WqG9BIZdzc2r6Oe0FjNjwzJPQxlq5rXsC4395Vh4faSAqFHuNAeDnayL0N68Fo3kJsZKdz96lXWoXcvFOMki9bHz+kmrrmB8pjE9YaVQUMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMIhwm0HGK0GP4lW4X0zBGzQB63NyK51RyTy+v3M9CU=;
 b=XZZygtS6eE4PiGdqsTnYsuZiJkk/5cHfmE1mNsnxwVbHMYkUQXLqAogdqgchrbjWEKdnOOY8zlGLtD5yLojPAQGvoZ96DsyJ9E+hEJwB+oZL2QG6XKPT4xzUUcPUk+q7bqw+z4tTF0UF/PdDteRM6DVmhp8dcFVpsmVJ5zHXNBxOtJX8+BRzghL7sypwpZEPh+C81gK92gUxeDuyLpOS7zvHMFYmKvuGU4x2HWUCK/RRsGfVChO21dJxQIBt10XBjIeSYBf7ORgxlwQ2p4gwkliwlkoKvNmAwCmWU3JA4zaJixxloG+m8HubRMKEtT6sQbjwGCtw5yz50qOZVP+qKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 15:13:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 15:13:42 +0000
Message-ID: <6beacd03-f376-4aa3-a29c-d6befafd614f@amd.com>
Date: Tue, 4 Aug 2026 17:13:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xilinx: zynqmp: Setup BOARD_SIZE_LIMIT for mini
 configurations
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Tom Rini <trini@konsulko.com>
References: <6d91337d971fa9e22f6f57371f8bc656ea6bb4a3.1784722595.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6d91337d971fa9e22f6f57371f8bc656ea6bb4a3.1784722595.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c16627-7352-4cb0-f526-08def23af86e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: E/kRIPcCxp0JHVoAISbpQkvzb0X6LQsu8MHIhAWrQ8Q52hkDziPoI67d0wDetld7Qk8rOo2O3Cla27CfcuLAaaVli9+o7ggVPx0hssxfPH+rpHAspCU4ynSqLaKF7PdoJz8Q0dOSzD20WjZiNKVX6huwy6+WsdFotswv0OLQIvkF+qS1vxWlikA138NfVeAP5ekHcbxJEi24sf674JOI9PVF+fxzYK1Kewh6sclQYI9U8zaNXXayD7EpgCTkA7mZSrq7E/tYqGI0QamA2jt0Xk8Bv/KJc18TFjFbTEmPgMC4giNQsaXavkpGhdEoYjBP7A79haK7RSaMrL/JOKxW0fk8iB8wayOmOhO8wK/9AvDSixUf1jZfrrFKZ9Gxo5GrN0SyuZxCLhxcQBRpQ+LoiMb9pwDTaIY8lvuvd6WPXZ6BL5fM5A5J8J/C9lEx9v0Tcdyy7zz/dHC2FO9oM3QabXSQ+ds/v7L0GJvVHF5okbwN7tV8wyab1ljI1aCR5X1hb57+aS6t1Kn2LGE/0Y0LVRf8UppXNQP8dOha13ipDDA6ywG3cXC1G+XzVAsFpDmBYAOhV6se+1qslvvO127VFn5OgALXRQTuoL2QffnQWJwxGtTRrusvF7+YvPUCn46Z3Gxszfkc3BPedyyQLt8GDmdJPiwpUOybOwd/PNh12rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVGNzU1UVFEbXRBMGhBUkpFcWRHNnZIUnJmWnBuYzlnWnd6NSt4ZW1LV3No?=
 =?utf-8?B?T1NvWVd6MEpoOEZsNisvRVA1Z24ra0NJYU40NEhYamZJeVNYS2tZUlJhbXY4?=
 =?utf-8?B?SW11c2tONG9xSHJkYlFvT3dqWWVQMHFOS1ZPZG1xTHd4YTZWN2NUaTNoYzdG?=
 =?utf-8?B?MlVwbUJrcGFlTExocFpYRGgyRkl2V1pBcjc3Q3hmWDN2QnZrblBGR3prZTUy?=
 =?utf-8?B?eHVxTGl2dWpkdEo5QkMwVHUyQmMwamp5WXJLLzFkcTZ6TExiWnFhMHBlT0My?=
 =?utf-8?B?NWxUMVNFYWpJTEN0a0g5Mk5GdEkxaUM0Q2dySFdjaENZM3pLc083Y0hYdnVx?=
 =?utf-8?B?aVB1MHNZVlJUcXJKSW5iRks4U0NlRWJaeUtPdmtaNnZIbjFaSkpqUGwyenZM?=
 =?utf-8?B?eE5HOTg3WjMrMHFtYzdPcGE3YXYwY2t0ZFN1aVJJQWxYQk1hYlduM0xZT0lV?=
 =?utf-8?B?aWtJalJXSGhPV285NmRPMXVBNGp6dGpXKzFLeUxGTCtzQnFObmswU2lUcG1s?=
 =?utf-8?B?TjhQcU0xK3pPUFVZM1o3V0tRcWFXM3lMa2FpT0NGeHBnZjVGQnpFZEEwcktR?=
 =?utf-8?B?eEQraU8xY21IcXd2R292eCtvemRlVXVCZmI3RERNL0VzTE8zTWtQSUE3VEpR?=
 =?utf-8?B?NWxyUkw2c296UU5ja0xJR0FESjNmNmlsdVZjckFOVjdBcTJUZHdDTTlBMFI1?=
 =?utf-8?B?Y2hkNEt2N1RjV1lYTWtIa1gzMlpDQjVraFIvaVlzdVVkUlh1Z3NybklxS25a?=
 =?utf-8?B?YmtOdmQwREVWNzUwS0ZuKzZSNzEva3pJbFloQ0dwWXR4Y0dxcjdRS2d1aXlt?=
 =?utf-8?B?WURzek1IWGw3MGxvVDNsK0g2WWJNTmp5Zm5WL3VHSlhkVytkZVllQVkvaUo5?=
 =?utf-8?B?ZFNmWW5Lcjgrc1N1b3ZnVHNmUmY4dlNMemozcjRoRGtDWkFaUkNTeWR6VXJB?=
 =?utf-8?B?b3lrMWI5dTMxMldhcnZwR0lvMHRvMGdVTDlZYlpOWXhoVFcyc0FFK3gzbzN3?=
 =?utf-8?B?cEE0OFl5aTFZajB0TkNhdTJ3WmxHVDR6WS9MYTFmUFRPY1RaaEhGZy96RW9N?=
 =?utf-8?B?RndIR0kraWVMaWtjSDZCbXozYk0rMS9qT0Q1aFhnbHc0YnNtTWVkQlp6cUor?=
 =?utf-8?B?dVJ4YlU0RlFuT3FWYVFwM1Fiak1iczVwYkg1emRYTXcyb2N4V3pXajc4T1Y2?=
 =?utf-8?B?c0wwOXZyMzlsRlIxRUtCclExYlcwMERvVXBRd21ocGdlUDVCZmJ3NjFHZVZi?=
 =?utf-8?B?bVZrVkNRcWJaYTFwdmtwVWJlSkdSQWNKNThCdWcycnJ0bkJLcEJsOHRYd0VY?=
 =?utf-8?B?YW94STVmenc2ZldCaXY1WktxQ2g1VDhSNDQvcU5WM1NIK05KQmVNU3dhYjR6?=
 =?utf-8?B?MTM5SkJjckpIVFRYY1k4RGJUMUhGRWJaQzJ3dUxtQ1hVeTc0OUptaGZhWW9P?=
 =?utf-8?B?Q2phZFFWTXNzTWE4MjErdGlWMzZLeU5CaUZpQnd3Q29hSHNyWVZXTEk3WG13?=
 =?utf-8?B?SWs5UmNzR2VXdTArL3N2NnBoMnk4OUdiT1pTVkxJUkVJdWJGREpwSW0vS2F6?=
 =?utf-8?B?Zjk1MXhWT0xDTG5EemxXa0g3NTMwSGVxcnlnSlFFcHhDTzZsQlBWYzJkUUxi?=
 =?utf-8?B?QmdaUmRJUmsvemNCeUMyZ3pKUXU5ZmIvQ2loTGJ6d0R6QUJuR0t5YTJWRXE0?=
 =?utf-8?B?S1kxbXl2TmxYK1dNdTJENGxYOThaYnNIcG9hVk1remZKZGl5bEc0ckRRaC9j?=
 =?utf-8?B?Y0ZvOWpMdC9TOHFCZGZhTkQrNVpHdUJDRjMvV3dSNXFNSm1wWVp1ZU5OYVlN?=
 =?utf-8?B?SDZ2T2hhcDRDVTNBaUFNZEYvTU9iQmNFenVlNXdhK3BhTmF5enF6c1hYb0VZ?=
 =?utf-8?B?WktiSVZWbVU5VEVaQms1SmMzSnhYazJUSG90dWcwSHRxM2x1cWxZbGxxV3Fl?=
 =?utf-8?B?MldwekpuYWUzK2M1RmRNWVNJdDU3dUZ3dE1wUnE2Nk50cjM2U3A2bWh2MHNr?=
 =?utf-8?B?aWFOOEUxM0pkdFQ4QzdYQVYxVEQ3S0JSMXcyV3g3a2RlTVp3U3ozTm1neDNm?=
 =?utf-8?B?cytKTldPOFpxZFhGeHBxTGNkNXF0Q0xNblMvUE8vemVqaDZTRWhkUHhxVDdT?=
 =?utf-8?B?d0U2UjlLVlR0RjV3aUFmZjAydmF2TkNDRGd2QUY5bmh5T2piRHFoa2kvaWFJ?=
 =?utf-8?B?VjlUc2N5M3ZpL3BVVnBTa3duYlpoUEw2UG1MU2phQjBzWnVTYXgybk8vTTRS?=
 =?utf-8?B?NkI1WjlOOVZ3TFlHbTIvRWdYQmo3WnFzOUR4Wm96Y1B4SHJZVG10K0xILzZK?=
 =?utf-8?B?K3RWaTF4MThnZ0RKTnBRdGhoZy81bEoxOXhZTkZoZ3BWbHppZy9mUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c16627-7352-4cb0-f526-08def23af86e
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:13:42.4887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpRIBYj5wSbzYws2Bx3bfbYTHKlTTEHyURVfLf1JMuOpgHEyPAYi43N6PEybxZma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMIhwm0HGK0GP4lW4X0zBGzQB63NyK51RyTy+v3M9CU=;
 b=x/FQFFU/yj9sT0xv+s+gPRh+N/w+llL3sbO17GSAgOGkJucoA6+Frl23Y6kUj7cUChx/kOiBblZ1bU+qypUk5IZuAce5e7UypxYjfqP74175hwuobBhR9vJ3JPRZiUomTFzrOr6zGErYgfBwVCWmRuXUKG2V9khJr/Zi5EehJmI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=x/FQFFU/
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/22/26 14:16, Michal Simek wrote:
> Setup BOARD_SIZE_LIMIT to 128KB (131072 bytes) for ZynqMP mini/qspi
> configurations and enable CONFIG_SKIP_RELOCATE as there is no need
> for relocation.
> 
> For configurations running from OCM (xilinx_zynqmp_mini_defconfig and
> xilinx_zynqmp_mini_qspi_defconfig), move TEXT_BASE from 0xFFFC0000 to
> 0xFFFE0000. The initial 128KB of OCM (0xFFFC0000-0xFFFDFFFF) is used
> for data buffer.
> 
> Memory layout in OCM (256KB total):
> - 0xFFFC0000 - 0xFFFDFFFF: Data buffer (128KB)
> - 0xFFFE0000 - 0xFFFFFFFF: U-Boot code + stack (128KB)
>    - TEXT_BASE at 0xFFFE0000 (code grows up)
>    - EARLY SP at 0xFFFE0000 (stack grows down)
> 
> EARLY SP is released when new stack location is calculated before U-Boot
> prompt that's why no conflict with Data buffer location.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_mini_defconfig      | 5 ++++-
>   configs/xilinx_zynqmp_mini_qspi_defconfig | 6 ++++--
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/xilinx_zynqmp_mini_defconfig b/configs/xilinx_zynqmp_mini_defconfig
> index 20e2ae0f0030..8b1d8cc0439d 100644
> --- a/configs/xilinx_zynqmp_mini_defconfig
> +++ b/configs/xilinx_zynqmp_mini_defconfig
> @@ -2,7 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SYS_CONFIG_NAME="xilinx_zynqmp_mini"
>   CONFIG_SYS_ICACHE_OFF=y
>   CONFIG_ARCH_ZYNQMP=y
> -CONFIG_TEXT_BASE=0xFFFC0000
> +CONFIG_TEXT_BASE=0xFFFE0000
>   CONFIG_SYS_MALLOC_LEN=0x1a00
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe0000
> @@ -14,7 +14,10 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   # CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
> +CONFIG_SKIP_RELOCATE=y
>   CONFIG_REMAKE_ELF=y
> +CONFIG_HAS_BOARD_SIZE_LIMIT=y
> +CONFIG_BOARD_SIZE_LIMIT=131072
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_SYS_CBSIZE=1024
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index 03366a3b05a4..9457dd0a6723 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -2,7 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SYS_CONFIG_NAME="xilinx_zynqmp_mini"
>   CONFIG_SYS_ICACHE_OFF=y
>   CONFIG_ARCH_ZYNQMP=y
> -CONFIG_TEXT_BASE=0xFFFC0000
> +CONFIG_TEXT_BASE=0xFFFE0000
>   CONFIG_SYS_MALLOC_LEN=0x1b00
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> @@ -19,8 +19,10 @@ CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   CONFIG_ZYNQMP_NO_DDR=y
>   # CONFIG_PSCI_RESET is not set
> -# CONFIG_EXPERT is not set
> +CONFIG_SKIP_RELOCATE=y
>   CONFIG_REMAKE_ELF=y
> +CONFIG_HAS_BOARD_SIZE_LIMIT=y
> +CONFIG_BOARD_SIZE_LIMIT=131072
>   # CONFIG_LEGACY_IMAGE_FORMAT is not set
>   # CONFIG_AUTOBOOT is not set
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
> ---
> base-commit: 5da0b87566c20b6f429f05cad027027f4b1edc3c
> branch: debian-sent3
> 

Applied.
M
