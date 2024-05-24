Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740F8C25B7D
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52E28854B;
	Fri, 24 May 2024 11:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OIMPcLzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C190A88568; Fri, 24 May 2024 11:45:16 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891D088546
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jx0YpF8fQ7sIntt1RrhEx8K/+Hx0WdP92Qi2ZdJgVMcCqCTU5oikXA028sDgWbTFedbWlwMoQa0PyqtCRqflEwYeZRYQVeUX+RACHg1uYBVUzviublPWXBj8zMekZUv65ddtB1KqeJnwmfIs9kWxga8M1XTQ+QK2NwcEUDrvmnI211ZIREbnKL4FNaW/A0CCzkKLAcB/zfn1+LAJxpWyydhVPIsZfwUSeEdY9cOeFws5pGFoJpd2WHoFy9CysV3JXNWnsVjgEWUsZSUHD6Jhta1nq9D2C3v9M9gGs2JtvseIKpZ+vEqXCfUdgOWUQe9SxNJJZd8mLAVEPuK8E5K8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1skcQt5Qq1ZxkPDjMuNLTD96N/4dRrQHsYp+RAagcaU=;
 b=IalQ0qrxmdjrHFT6fyfaInRIWzJ+ZSBLnSRMQam2hHY8KrHocwjVVvwNM+BUJhVyxwxNVw3WeXGxd4vkzJT9I+uog5ZQE337ikSIxsBR9hm+sIpzQ8ro+4Kroyw0ePgV31BN6Noqr8YQRPqiOPdrBijI+BaaDQxUCPQhWGpZt2mtVDT/qHt3RgQZc3p2Xb0v/40YRk/t8BPvt+qdLVohFsOvdWKgF89AxmFBR3wDSAD31p3qocuZqo3IjoY2LjGwWR2XS7fq3N8RMshqUTcjmu3EDj1IN6LoI+Q80FyQBy/4BCLM3PqjB+4gYg1yTHzshIIepi6duki7XZb81x4R8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1skcQt5Qq1ZxkPDjMuNLTD96N/4dRrQHsYp+RAagcaU=;
 b=OIMPcLzgsmYf+2yZ2PvsBtkflkj3OBvQQjZtFESDg1qUBsaMAXua0PnZ3uCK5ZYoFLiZt7e4nZ5hbcD+hZz+ANa+32DuIwa8acWieRudjM/LQrzqBq+c/wqtMKPqEpV0fpSBkc2O8twGFmuIQ3D+DvXGs8Aqb0pJvgbWAujeAU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 24 May
 2024 09:45:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:45:12 +0000
Message-ID: <66a52861-6203-4b6f-940e-52e21abfbb1a@amd.com>
Date: Fri, 24 May 2024 11:44:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: de355de0-15b8-4449-3805-08dc7bd634cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUcwUjJTMFdiV0wyQmUvWE9sbHl4OEY0MWJpVVhEb3ljK3QzQ1BMQ0JmMEVh?=
 =?utf-8?B?dWd2aS8vcGo3dWVXT2ZsTXFGb2U4M2JHdnZ0ajQ5NzlGWXo5YUxNYmppbXhO?=
 =?utf-8?B?d1VjNitHUk1GNU1UTG5RTmQ0YWJYdlFYYnZiQ2pkZ0dYemkzQVpCZWJ0L1Br?=
 =?utf-8?B?bWMzTk9RSDg0QXFaSm5ESEhOY0VuUW1SUmdYa2ZWKzJLMmNpZ3BVNnZ5MS82?=
 =?utf-8?B?c2VpYVRZblRBWUlyOFR4elNKYkpBejEwOVRzbHFYSlpwWFRKdUZIM0lXZXc3?=
 =?utf-8?B?YlBDbEJRZFl2SFZlYk9vdXcwSEFmOFNmSUpiTUJuTW5OM0lVY1VuY1d3eURE?=
 =?utf-8?B?cm9DaTlvcXl0SHUvYXBwQnFYTjQ5RXdFMlpERzhUczhCWXI4UVBuLzV5bWV6?=
 =?utf-8?B?WXlOd0FUcXZtL0FmKzcwcW40NG1SdkROQ3JicHpnTG40cUgxT3ppV3R6NURO?=
 =?utf-8?B?dmN1V1lybnQzaGxzMUU0U2JOR25FN0NlcVVkcUtaQnIvQTd5MHFRaDB6dDBK?=
 =?utf-8?B?NTFzbzFuMThpbnFiK2N1RTZpcXZnVDdtcFVkb1V6bXQxR1FNeSt5UDhPRXNw?=
 =?utf-8?B?OWhRT0pvcFozRGFEd3RCRkpKTTR5OVhRUWdXczZhQXhxNHNSQnkrenhiNVBQ?=
 =?utf-8?B?SjZlN1A1Sm9zK1RJQXphL0V0YVJiSHYyNkkxZG1KMDk2SS9kclhtb3I2a3FQ?=
 =?utf-8?B?MzJSVjhPVndtaWdFNUtVb0I1STJnRk5QY0FkUUhlRFh0T0ZtSjVGalZkbWNE?=
 =?utf-8?B?ZnBvT3hWQ1J0ZDNlQUF3Njhwem1OamZGMlFON1BUWUNTTzJkOXlmdEp4c3p4?=
 =?utf-8?B?OEpOTUtBYVRTOVlXNDFuVDczbHU2d1NCUFRGbERhWDFqM3llNXM2NUcvOEFS?=
 =?utf-8?B?MURPNG5SV2RvMG4zRjByanIwMEJ1djYxaXlpK2NVTkNaNEFaMUlIaFI4TUZ1?=
 =?utf-8?B?dktKZG9CZ3hhRVdGRXZ0MFFJcTFSbjFPNUhvZ0lWMk52L2xudm5FZk1SVlRD?=
 =?utf-8?B?UWpnci9CZ05hdXJCeWZUeXlVSjFIWVdxOVFQSU80UnpaNGhlRXdYTHFlS0pX?=
 =?utf-8?B?VHUyQWNXUnpLOEJRc0pxY0x6QXBCcFdDenZrejduOVJoUzJYOTM5emh2Z01o?=
 =?utf-8?B?WnJVd003MG1SWXkyNEtvdGx0YW1nR0tYdHFmQTdmQWE0N0U5MFhjQ1VXQnZo?=
 =?utf-8?B?QU5JemZxVHVEd1JJbnVQMFQ0YmFCTm83S1dWNzYwZGhIT3dFa1Q0VkhmUHc3?=
 =?utf-8?B?blBFME5wZzVxZlJxTkwybHZqaXN0ZTliMzdoYXhTWWxoSlBpcnRrcFA4MmFx?=
 =?utf-8?B?QllMbFE3SkNKeHJXdDdFNWdBNlNpWHdhQ1hMWG1lcXJmK0pkemcreGpnRXox?=
 =?utf-8?B?aG9TY0lCajQ2eWE4bGtQUm5hNlJFM29QcTJZY0NrM2xDQUVkQjg5ZTBMWXNm?=
 =?utf-8?B?ZG9IRm5JYXAwa0paRTVjaEFBREhtZ2NTM0dlOCtOeitYY1p0Z3RhMCtsek1x?=
 =?utf-8?B?a2JXdHBBdUkrQjIyYUl6WDllM2t5RSthUXNXQkJHMUVaVHB0UVg5d2l3RS9T?=
 =?utf-8?B?V0duNExUVndKbFg3QTlZQzl1UDZTUnVkR3ZtYjFaaWdON21Gd2tQMjc5bXpz?=
 =?utf-8?B?aS9ZNEwxbU4zQnc2Tm5wN3NKaXJLZkxyV05SNUwwSnIySlJWYTZxNWpPdUlK?=
 =?utf-8?B?ejRhTzk3eFQ0bEtqckhIUU5KMkwzb3NrZGlIZG5TbjY2YlFWT2g0L213PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZ3UjY1Q0tVNXhkSjV3cjNHMnQrQkR1VnB1cGxoMFJkWisyZjJvYmlraUlO?=
 =?utf-8?B?ZUlWbXZ6TzRiUDFYaHpLWjJhUStmcVNSdDdBcHM1dkZNbUJ1Z0VhYkg2ZThi?=
 =?utf-8?B?RDRpNWNJYW43djB0UHJpVVRraHNTc1JEUms3dEYwUVVwUlN4OEV6T3V3Wnlt?=
 =?utf-8?B?Zk1HRWVHUGFqQzVSRGo3YTBSLzErdDlKU3pPSk9Cb3lKaWhPR1JycHFIOElU?=
 =?utf-8?B?TVllZ0JUS05mY0h6Yk1MdjRiWDJCZi80RHBGM2pMSmJUbWZQOHZyVUdlOStE?=
 =?utf-8?B?RDRnNDd3RWNuSzByRHI4T1VSOE9CQmEzMWc1UHJPVWZ1V081TjEzV0puRHZI?=
 =?utf-8?B?Z2VaZEJkVkNTbkRvVEMwdk9aeG9EVVFta2pzY2lDQ0F5V0x2QmRteTFWZ1VU?=
 =?utf-8?B?anNSQUZZQi9NZUJmZDY5Y2I1Wk9wc1ZqcjZ1U0hjeThiUXZycVBaOHlGZS9i?=
 =?utf-8?B?MDVSRVlWNHhoVkJKS0tqL0VvSjJGQzJYeVFOME5QMktNa3pLOE41OW43dkN0?=
 =?utf-8?B?QS9SMHE4UzVzOWVpcmVlQmttcy9EWUU4S0JsczZ3NGZvNkFLSFVTZTJvMFJO?=
 =?utf-8?B?VGhnR3dIekdzOWhSUUxCMmF2azZPbHp5SE5NQ0dYdzhSL3lUSVVBN1o1d05n?=
 =?utf-8?B?R21KekZQSUs0eXR1Sy9tSGZUdHczNVFzRDN5RGJhNzBBQmZjYS9NOUpCc2Fv?=
 =?utf-8?B?aDFRMlRUZWdWREljdnZNeGlnSUwrSVhUbjFZR3ovQjE0ZHZnRGNJWlZyRmx6?=
 =?utf-8?B?TU1jMzl1T3h6YnJDTFRjeFBhYzQxY2syVHdxbmU5TjloOHpoY21kTWl0TkZa?=
 =?utf-8?B?em5ZdXRacm1VaktGbnZaVXhIYS81WDNYQkg5S2poSW5kZUFpSmdBSVpsLzBx?=
 =?utf-8?B?OHplTzNPT28xYnQvY0xSdXdnMU9OQUhLRElOUlpnRHhuMEhDTVlNaDNJdEdT?=
 =?utf-8?B?WGpmeTBNZ3lGdEh1SzN5RFdQYm83MmtCRFE4alFydERPNW4rVktPL2x2d1Zr?=
 =?utf-8?B?NVEyRFR6VGxBWUtFYUtZMjFuZ0ZFL09HRDRtWU1XbTZIay9iZWFkYS8wblhW?=
 =?utf-8?B?ZnlVdXZVK1I4bzgzMXB0U2ZJU3ZQN1BTdHozSTI5VTlUYnZoczZyMjh6a2M1?=
 =?utf-8?B?M1IxeEx5bHdUUVV3NXJxZkpiS1ZVYUlBWFdFdDdXZ0tJeS9VSnd3NExXZTlV?=
 =?utf-8?B?dW9WYlRLL3VQSytzQlRiSmlnM2hueEVPODhXZ2Zwc3EzNkplcmNleHVqMkht?=
 =?utf-8?B?dVYxZ01CckNCNUhJMGtqMEJ0eXUzU2JLRXYxRVdXWFN0bFBoR1VnSjZocDFV?=
 =?utf-8?B?WUhZK0d4OEpFcXZQRUZKSWY4NGV5a1ZtOGJsdWdyNmlEeE02c3NwQzNGQzdF?=
 =?utf-8?B?WWV6Vm5RSEhlQjFuTmZvY292Q1pVNm5CcUx1Mm5TYUpMWmRBdEx2NG5YN04v?=
 =?utf-8?B?QU5rNExkUE1oTkNlSUQ4ZVpNRFhHRU5mdGpPMXRnS3p2OVlrbzlZUnVXOFNX?=
 =?utf-8?B?SWZvSHBvaVJaclNMbmdtOVhRNDNSQkNYU24rM0tET3JtYUIwY1ZLMXBUQ1lL?=
 =?utf-8?B?UHNVWENCMmZrUlQ2MWdoSmdHRUNKKzkyZjdrMFp0RXAxd3p5TUh3b0VIRE1U?=
 =?utf-8?B?djhvZCtkeTAxbFB5S0I1cG9oSSs2M0drbDZMYnVSSHQ5ZGdleDVuUkJrQlY4?=
 =?utf-8?B?OU5HUVA5RXF0aGZHSmIvSUU1WnJIOW5zaEZMSU4rZUhYN0VLeGpnSWpEQlVP?=
 =?utf-8?B?NDNicFc5MTZ6V2RpVUtpMW5DeFNwMzZoTGd0QmV1N3pENTF6OWVVeFB0VmxD?=
 =?utf-8?B?WncwcE5UeEtrYTFLakhiZStLN1AzYU5jZzBRSUhReHJuZ2piWmNHUU94U3Jv?=
 =?utf-8?B?NCtGZis5ekZYU2JTZnR3TER6Q2d2ZHVReGE2YmdrZWVYclR2RmxLOGRoOHU3?=
 =?utf-8?B?VkMwRkpSdldOTFFJY09PWkI4cWJ0RjlFNUsvSjZWK0hsaTMvK2dWdXpKQmFO?=
 =?utf-8?B?OEx5dWlnTldOOEZoR3cwalJVOXBIRDlHdWJVVGJZVWZtTnJESGtSUjFqUUlB?=
 =?utf-8?B?TFlOY2J2eWZoUEh5WjkwMjRrcU9LSXlDU0YvTisrTUdmUXoxdGVmMklBK3Rr?=
 =?utf-8?Q?A1ywHQM+QPJiA57Cncey3tLCD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de355de0-15b8-4449-3805-08dc7bd634cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 09:45:12.1199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhEeazhh9cil50d4cKO2JfjY6I2ESUCvQdrT/o50CQAlQ9ACZ8/3jJI+0dnu37ij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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

Hi Ilias,

On 4/26/24 15:38, Michal Simek wrote:
> Hi,
> 
> currently only DT way is supported and it is added directly to lib/smbios.c
> but I think DT and env is only one way how information can be found that's
> why this series is improving handling with using sysinfo driver which can
> be platform specific.
> At the end of day DT should be taken from smbios.c and put to sysinfo DT
> driver instead of implementing it directly in this generic file.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>    xilinx: Enable SMBIOS command
>    lib: smbios: Let detect the system via sysinfo
>    lib: smbios: Detect system properties via SYSINFO IDs
> 
>   configs/xilinx_versal_net_virt_defconfig |  1 +
>   configs/xilinx_versal_virt_defconfig     |  1 +
>   configs/xilinx_zynqmp_kria_defconfig     |  1 +
>   configs/xilinx_zynqmp_virt_defconfig     |  1 +
>   include/sysinfo.h                        |  9 +++++
>   lib/smbios.c                             | 42 +++++++++++++++++++-----
>   6 files changed, 46 insertions(+), 9 deletions(-)
> 


Any comment on this series?

Thanks,
Michal
