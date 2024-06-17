Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD7C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 16:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9453D882BB;
	Mon, 17 Jun 2024 18:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuU9MOvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 975A8882BB; Mon, 17 Jun 2024 18:12:22 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37085882A7
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 18:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+nB113Px0GVYvXuvdJbRLZX85EZiZ0IgPmAL2OfS2ak5ar2KlmS/nyjW2hGWMzpMEujMrv5KFg0XXyIg6XTYuZsQJ0NXLzaWct9cMhEOBSHqRW7+VqQwKZw2zMzq0w83CWfLIUpje2EDY12BfJWT3QOXuNzzrxa7Eity/d7SFv8wmLoknkDXIJLJw0y8UjFzadDTHyYi5RfrHQrJyOiTAMyF7OfogUryHtnlMYW6HZ+t8j+suONnXARo74piBim57x9IWXHCl/6PaurNOiOpbcfBA+PBGRnsuuzdnlAEovpOm91UAkFRHzwR7Ut879c/j1KqxzBEG9gJvijYLiJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxnRhRNxDmNs4hxd4xb/NB6QOxqIHAPFS3p8b2nH5CY=;
 b=TxLUZOPAfAAZVKI/KyfBAdSpRgZq0GWDX9uRqKIoavi6wcglYtTGza5FAPPFlna5eFLMsblHmhYbn345q9zi16GYIl4DHW25FAsuEuivILssI1ceLP+S7gCIV0I9RZKheJKw96fgC9IFkas9V2UFC2m7fNGAex7S0zc58JM6HbKElHpSYAmAYjicgce/wYHjYCWKIrfTxa5z14xm19GqA0ZULOniC5pfQy6oL6CTegkO40+QVSWAtZVdzNwnzVRShp8B8ydGY+0p9tn5pP3uheuFOtL3Aq0NvUuw0/9knYHF1nIP8qRgVNLnqVvbZGfZLLdE61/Pjy5K/wA3nE9ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxnRhRNxDmNs4hxd4xb/NB6QOxqIHAPFS3p8b2nH5CY=;
 b=VuU9MOvfosJEs5K8ifFfx81mmwOMJPwXdGh+ka4O7Eu41KvI+wAFL8QOtDUX3B8IH7HJWFDxY/OSh4IcjmM45633hHSyHbA9ChYoCFLaV8cgQT5YFrvk0aZZbtNKtHfpO9tIkuBg0AnLjmD/bDLonT+jk9ODw8jjslYMpd5/Rg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:12:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:12:16 +0000
Message-ID: <8a2e058d-5424-46de-bcf7-87ff574d25b2@amd.com>
Date: Mon, 17 Jun 2024 18:12:06 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] xilinx patches for v2024.10-rc1
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:802:1::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: c0986e3d-9106-4555-204b-08dc8ee84183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aThXUHFBdTVVbmtXQkp1Zlp1VHFrbXFKc05ubHY2aEtHVWhnT253SndZbzJL?=
 =?utf-8?B?Tmd1azdERmZmN1Z5QVJnSlRDWDZYNlBvRCtDZlVzd2NibVFkV250cUZ1WUdG?=
 =?utf-8?B?SGhXaUlvOUxDMzk5V2NWekdMWmxNelo0UmNkQjZudGcram5NUjY5KzN6ZlFi?=
 =?utf-8?B?Z21yNXkvN0o4ZklhalBaN1c1S1ozWThjQ1RjaVZlc05KMlJyMUhEaHlXay85?=
 =?utf-8?B?T2hjNlQwbnFDYm1OTk1BZkl2QlNqbmVyMTNoRWtlS1hPYWFSZFMwejFGeXRj?=
 =?utf-8?B?L2VKbWlMSTROa0FtQXYyQkFUWTIwQVhCNnY3ZnhwenlGOW5qWmgrTVJnM2t1?=
 =?utf-8?B?dzdyMVB1OWJiNXdtMXFrWnU2RjRkbTVENWtjQzJMN3RnZWtIYStWMFNDRDdr?=
 =?utf-8?B?dmI5bTRBeE5VMHNhUld6ZkNIaXVoMzRDZm1IcnZJalRvcHVuV2VHbUxZUzE2?=
 =?utf-8?B?YlhWNGZ2U3hnS0ZkWWJrbFA5RUgvVUxzdklSV0t6UTZOTXpFQXNzVXJwWkd2?=
 =?utf-8?B?VVM4VEFLZys2enBQN3A4cXhBdjlKQlZHa0FtT2JJU0RKYmZvbVRkZS9KRW1R?=
 =?utf-8?B?cXRvbDN3VDJhMmlKME52dXI0OERGWFh2aGoxdDJVcCt0TFVQb2FpUk5ScmY5?=
 =?utf-8?B?dVhNQnY4dU9QUzNrSXdNd3BmT0x4L2NuTXI5Y0NidENadTl3MGc4a0dMejdp?=
 =?utf-8?B?b2thVkQ1RXVKMjZkNkVIamFqUUthbUc0Y2Q3YlE1Z3dzQVMvWmVLSUIwK2tn?=
 =?utf-8?B?ZWtIeVhNdHRKc1lVcXB1VnVEd2VUNEFlT0VJajVrenVpTWVPT0hVMHFlNi9Z?=
 =?utf-8?B?aFdzMWMrYjE0ZE1SUUJldnBKQkZsRW4yRFEyZWRPVThTT3BISmxybGhjQ1Zx?=
 =?utf-8?B?b0tBVTJTeE95c2IrWFBGSkxYZXFuWnFJUG5DOCs2UzNzQUFDQ2ZreEw1ZDFS?=
 =?utf-8?B?M2JlekZJK3VzbWdvWmlQZG1YQ21LaU5BS3RMNlpXT0pEM0cxQTk5NERneXNX?=
 =?utf-8?B?dElJSnlxSUhjK2dRTHNTeWx5WG90ZFFLNnR6OURKWGZtMGhUZVNjbVA3OFVG?=
 =?utf-8?B?WllhTWxMNHRzaWJBbHVMekRjUkUrV3hQNXF3NExJK0k4MEIvczNLUmNIS2JR?=
 =?utf-8?B?d29xRDFrSW15L0g3Y2JySFNqaUNhTUdzaVlPeVpsaXhpSTNjRXRwY0hidlBa?=
 =?utf-8?B?cUpZcmxPbGVwSmFVL29vUklEK3ZyNXk2THFvSjJYNE9KdWlPdzdiQzZmVW05?=
 =?utf-8?B?c21GdmdObWhpUVM1WHBjbldWUXo2OTREb2NZSWttQ0o5TzBBS05HK3c5VU1r?=
 =?utf-8?B?M3NBb3lqd3g5OWRvWkxDQ0V2Z0JOa1NwTGt6dHE5aFpXa3krM1hkREh5UU1V?=
 =?utf-8?B?ZStiWWd1ajd1Qk9Ub2ZLZnp0ZmNZSU1KdDRHdGkrK013Y081VnJHVHVOS0cr?=
 =?utf-8?B?TENXRGFoS1FHZ1V4M1RpVTlRRmIxYWoxMEtkb0M3UmhZRGN2a3FOS05Eakw2?=
 =?utf-8?B?N2cyRVBWT0ZjMm5XK25ZSEJiVXArcnVYVHFwQlMwMWNXMXdoSmw2VnQxUGN1?=
 =?utf-8?B?Ykt0YnpiOWtmOXJjV1kyTnFNRWY0aW05ZEtmbHI5MDEwck8yQUVHb0NXaWhR?=
 =?utf-8?B?clB1aCtpdDNSUklvOEh4Z2RVZ2pIMW5pc3lzUDAyV3VLZWQvUDkzOUVDd3hS?=
 =?utf-8?B?K25yWXJRelFLcGFrblMyY2ZjcWJDTkJYZGRDUlJjRFV1RnRvV3MzdzFDWmNH?=
 =?utf-8?Q?pcCLvjsp3ZI6xRF9xtet6JV5U/cTxD2LXa30Bq1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNnbXBQR01TN0Q0eDkxaVJUdUxOQnJoZmxPSTk0V3JSaHJRMWFGclNLQnh1?=
 =?utf-8?B?N1pIdFo4Q2ZPWmNDL2hTU0VYaWVJSUF0MllBZGZOV0ZGUXJiL0VaTlRhcHQ3?=
 =?utf-8?B?Tnd0aTdVL0MxNk4zQmMrQ2lBc2RPb3JoaTE3ZlpGMEIySkx3d2lMVkNSR3lU?=
 =?utf-8?B?ZUw2WTd1bW5hNXRUUGNWalRNcVhRb1JrN290OWZZVE1GUmpEaHJTck94ckVt?=
 =?utf-8?B?OVcyWEljR3BlMnZWa3NRYlhUMEdvNm12R3VWTVZKSmF3Z1NJcHFVY1lOTlpu?=
 =?utf-8?B?R1BEeVI4TW5qMkNGQk5mbFk4R0dmV1l4aW1lSUg4d3BUZWZaYjFNSVpENFYy?=
 =?utf-8?B?SXM3bE12a1BxYkhsUVBzbjJidHhSMG85SG9neDJEN1c0S0tBRUx3SGRTaTNI?=
 =?utf-8?B?VEl2aUpZR09raWpXcmd4dXFGZ2RsYWxmOXdnbFkwM2FXTkRoa25UWFBXeDhV?=
 =?utf-8?B?VFpnNTk1THJuVC9IMFA3THE1bmtNelVWcis4d3NuQVBsZnB1WDFXOWgwSENZ?=
 =?utf-8?B?dUhiVUhJNkZuMzBzOStaS0htZ01jMlB2QWlJei9JZzZrWXJLcmFVRXcyUkw2?=
 =?utf-8?B?WFg1M0p0WHp3c1pETm5mUUNRVzMzK0dJMVcvUmdXaTY2d21Tb0xvaHR5anB1?=
 =?utf-8?B?Z01SZFdVTDFWK3ZFcWx0bzNwb0NUOHFmMXE3TXNodXVtazNqTXVaNGNkdUpF?=
 =?utf-8?B?QVJCdGtUWTVkRUtzUC9CYlFpTTVMQmVFekdER3Y3VWZmWnJYVUJjaTNxZnFW?=
 =?utf-8?B?bTFURDJ4eWszQVpydFVmR0lPL1FJd1NZWDIvdjFwK1lmSkJiQjlab1haalRP?=
 =?utf-8?B?N0NkbnJNbHIwb082K2wvYkU3RVo0NUNoU1FDeWMzWlJqbTViV2l2LzF2M3Fj?=
 =?utf-8?B?Q3UyZzBwTU1Ca0tVWTJSWEtoZVVueEpMOGtFNk5KZVV3WmFzczhLZk56NFJu?=
 =?utf-8?B?d2NVbERPNWQvTkV0MVMyRk5TenlYeFFoYTNMaUR0TDhUOENPM0FHOUgxS2Za?=
 =?utf-8?B?N3dBa2hvMkQ1bUZQd1Nabkh0VnhXV3VXbUdoRzM0Vi94NSt5amFjM1lJc0pD?=
 =?utf-8?B?aVZuaEdIMTU3VUNxU2d1Q1RLcU9WbkczYnVjYTBvSFpDRjVpS0FGRUkxeTJC?=
 =?utf-8?B?dVBrNS9iMEovbDBPSUtOajFnZ09YKzlweXBKVGhubHJrTExDUEU1QmZjYkNG?=
 =?utf-8?B?MUJtZlNtME82aEZoc0dMR21tMHB6am5STFR0L1lmOXgwMnZzQTFmcFljdmM5?=
 =?utf-8?B?MjZhZWlvMVNCdzZoRGw5dWVtb0hZeVE2L1pDams3UTZodGpPUzFZaHdtcFFp?=
 =?utf-8?B?Q3VadGRCbWNtVnE0aGFUYUYzZEk2Z00vam9wYkxsM2tXdUZVT2wrSGR3enhF?=
 =?utf-8?B?SFdTdWI0TjNQaDJrWXBtdE1jL0ZMd2ZNblM5U2dvYjdLQ0YyWmZ3bjhFcFpG?=
 =?utf-8?B?aGo5UVBCREdqOGRFZUdDY25BOEVOVFJxSDZrT0xWMFFnN0pRZWFpeERtUGl5?=
 =?utf-8?B?amJlc3VrOHpJa0ZVRllxM3BFbGkzYlJkTHFEK3JIYVJZZTZvZkZwSU1pZ291?=
 =?utf-8?B?eDdkSnJ2YXdRbjE1S1B1RU1LUWEzeGMxaFc0b3A0c051cCtYQzFyREJTbWhz?=
 =?utf-8?B?WmdSSnBjOXYwMzAyeEFYcmV4YmsvVXpUTmdMS1JZRmdVc2xsY3BjMGdENDgy?=
 =?utf-8?B?MW00U2hpRXZ5ZXdBZkNXMHB5QlpJT2pOci9ITmg4bTlya3h1bW5jUnpxZURL?=
 =?utf-8?B?SmZVSkVmMHlDcU5sdXNlUTRybDRxMXNGM2svMEpZdnI3Uk40TVFMS0FWaUs1?=
 =?utf-8?B?cGVYT1QwUmpQb25vT2NCV0hvODdpTG5ZRzZCUFpRMHlERS9XVVcxbWlUc0pU?=
 =?utf-8?B?YmhNZEgrQ2lFc3laSTl2a1ZxNEYrWURwdkY5bTIwTU85ZE9pMHE0UmdpendM?=
 =?utf-8?B?N2czaElCWVk3clVPQVQ4VVhsL3hVSUdXMDJtZDVRNngydUc4Sk1tWkREYkgx?=
 =?utf-8?B?ME5yTUVCcC9Xc3BTRFh1c3NJQmxIUE5tbGpnVXFwTDFGeU9DNXg0Q0pPaS9Q?=
 =?utf-8?B?UVFWVmN6NFkzT1J5aEdOVVJtOTJlZFVDVVdpRGNnNS9CaUF2Vm1NeW5SMkw0?=
 =?utf-8?Q?W/KGXJOWpzEDBa9IV6OvL5PL5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0986e3d-9106-4555-204b-08dc8ee84183
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:12:16.6442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkU6n2HTgpHFmXC7Gn/7NBIDS8TMRel+0mZ/H31HwDVR9tr5FLDzpXRp78xByqe4
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

Hi Tom,

please pull these patches to your tree. Gitlab CI is not showing any issue.
There are some alignments and improvements but overall nothing significant. The 
biggest patchset is add support for new AMD Versal Gen 2 SoC.

Thanks,
Michal


The following changes since commit 0786dd573d0793417852e009dee3148ebdd163f3:

   test/py: net_boot: Add test cases for net boot (2024-06-13 16:31:24 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2024.10-rc1

for you to fetch changes up to e4a11e984d11cf4bbe55385cbae03c08f27ecd02:

   xilinx: Enable FF-A for all our arm64 SoCs (2024-06-17 16:02:30 +0200)

----------------------------------------------------------------
AMD/Xilinx changes for v2024.10-rc1

common:
- spl: Introduce SoC specific init function

xilinx:
- Enable FF-A and NVMEM
- Rename spl_board_init() to spl_soc_init()

zynqmp:
- DT alignments
- Enable reset from SPL
- Enable USB3 for KD240
- Align multiboot register on Kria for proper reboot
- Allow multiboot environment write even in saved environment
- Move zynqmp commands from board/ to arch/
- Clean up xilinx_zynqmp.h

versal:
- Do not prioritize boot device if driver is not enabled

versal-net:
- Setup location for redundant variables in SPI

versal2:
- Add support for new SOC

mmc:
- Fix tap delay for SD on Versal NET

spi:
- Add SPI_NOR_OCTAL_READ flag for mx66uw2g345gx0 flash part

gpio:
- Cover MODEPIN firmware dependency

----------------------------------------------------------------
Charlie Johnston (1):
       board: zynqmp: Move zynqmp commands from board/ to arch/

Kory Maincent (1):
       xilinx: zynqmp: Allow multiboot environment write even in saved environment

Lukas Funke (3):
       spl: Introduce SoC specific init function
       arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()
       xilinx: zynqmp: Enable reset_cpu() in SPL

Michal Simek (11):
       xilinx: zynqmp: Clean up xilinx_zynqmp.h
       xilinx: Enable NVMEM framework for all platforms
       arm64: zynqmp: Update rproc node
       arm64: versal2: Add support for AMD Versal Gen 2
       soc: versal2: Add SoC driver for AMD Versal Gen 2
       mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
       spi: versal2: Enable spi drivers for Versal Gen 2
       arm64: zynqmp: Setup multiboot register to 0
       arm64: zynqmp: Align #address/size-cells with node
       gpio: Add proper dependency on ZYNQMP_FIRMWARE
       xilinx: Enable FF-A for all our arm64 SoCs

Neal Frager (1):
       arm64: zynqmp: Enable usb3 for k24 som

Prasad Kummari (1):
       mtd: spi-nor: Add SPI_NOR_OCTAL_READ flag for mx66uw2g345gx0 flash part

Simek, Michal (1):
       sdhci: zynq: Fix tap delay for SD on Versal NET

Venkatesh Yadav Abbarapu (2):
       xilinx: versal: Do not prioritize boot device if driver is not enabled
       xilinx: versal-net: Add env redund offset

  arch/arm/Kconfig                                            |  18 +-
  arch/arm/Makefile                                           |   1 +
  arch/arm/dts/Makefile                                       |   2 +
  arch/arm/dts/amd-versal2-virt.dts                           |  11 +
  arch/arm/dts/zynqmp-mini-nand.dts                           |   4 +-
  arch/arm/dts/zynqmp.dtsi                                    |  67 +++-
  arch/arm/mach-versal2/Kconfig                               |  55 ++++
  arch/arm/mach-versal2/Makefile                              |  10 +
  arch/arm/mach-versal2/clk.c                                 |  34 ++
  arch/arm/mach-versal2/cpu.c                                 |  93 ++++++
  arch/arm/mach-versal2/include/mach/hardware.h               |  97 ++++++
  arch/arm/mach-versal2/include/mach/sys_proto.h              |   9 +
  arch/arm/mach-zynq/spl.c                                    |   4 +-
  arch/arm/mach-zynqmp/Kconfig                                |  13 +-
  arch/arm/mach-zynqmp/Makefile                               |   4 +
  arch/arm/mach-zynqmp/spl.c                                  |   4 +-
  board/xilinx/zynqmp/cmds.c => arch/arm/mach-zynqmp/zynqmp.c |   0
  board/amd/common                                            |   1 +
  board/amd/versal2/Kconfig                                   |  16 +
  board/amd/versal2/MAINTAINERS                               |   7 +
  board/amd/versal2/Makefile                                  |  11 +
  board/amd/versal2/board.c                                   | 343 
++++++++++++++++++++
  board/amd/versal2/cmds.c                                    |  81 +++++
  board/xilinx/Kconfig                                        |   6 +-
  board/xilinx/versal/board.c                                 |  15 +
  board/xilinx/zynqmp/Kconfig                                 |  19 --
  board/xilinx/zynqmp/Makefile                                |   4 -
  board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c       |  23 +-
  board/xilinx/zynqmp/zynqmp.c                                |  20 +-
  board/xilinx/zynqmp/zynqmp_kria.env                         |   1 +
  common/spl/Kconfig                                          |   7 +
  common/spl/spl.c                                            |   3 +
  configs/amd_versal2_virt_defconfig                          | 151 +++++++++
  configs/xilinx_versal_net_virt_defconfig                    |   3 +
  configs/xilinx_versal_virt_defconfig                        |   2 +
  configs/xilinx_zynq_virt_defconfig                          |   1 +
  configs/xilinx_zynqmp_kria_defconfig                        |   1 +
  configs/xilinx_zynqmp_virt_defconfig                        |   2 +
  drivers/gpio/Kconfig                                        |   4 +-
  drivers/mailbox/Kconfig                                     |   2 +-
  drivers/mmc/zynq_sdhci.c                                    |  24 +-
  drivers/mtd/spi/spi-nor-ids.c                               |   2 +-
  drivers/soc/Kconfig                                         |   8 +
  drivers/soc/Makefile                                        |   1 +
  drivers/soc/soc_amd_versal2.c                               |  77 +++++
  drivers/spi/Kconfig                                         |   2 +-
  drivers/spi/cadence_qspi.c                                  |   3 +-
  drivers/spi/zynqmp_gqspi.c                                  |   6 +-
  env/Kconfig                                                 |   6 +-
  include/configs/amd_versal2.h                               | 143 ++++++++
  include/configs/xilinx_zynqmp.h                             |   6 -
  include/dt-bindings/power/xlnx-zynqmp-power.h               |  17 +-
  include/spl.h                                               |   8 +
  53 files changed, 1359 insertions(+), 93 deletions(-)
  create mode 100644 arch/arm/dts/amd-versal2-virt.dts
  create mode 100644 arch/arm/mach-versal2/Kconfig
  create mode 100644 arch/arm/mach-versal2/Makefile
  create mode 100644 arch/arm/mach-versal2/clk.c
  create mode 100644 arch/arm/mach-versal2/cpu.c
  create mode 100644 arch/arm/mach-versal2/include/mach/hardware.h
  create mode 100644 arch/arm/mach-versal2/include/mach/sys_proto.h
  rename board/xilinx/zynqmp/cmds.c => arch/arm/mach-zynqmp/zynqmp.c (100%)
  create mode 120000 board/amd/common
  create mode 100644 board/amd/versal2/Kconfig
  create mode 100644 board/amd/versal2/MAINTAINERS
  create mode 100644 board/amd/versal2/Makefile
  create mode 100644 board/amd/versal2/board.c
  create mode 100644 board/amd/versal2/cmds.c
  delete mode 100644 board/xilinx/zynqmp/Kconfig
  create mode 100644 configs/amd_versal2_virt_defconfig
  create mode 100644 drivers/soc/soc_amd_versal2.c
  create mode 100644 include/configs/amd_versal2.h
