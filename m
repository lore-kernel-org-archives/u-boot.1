Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1ACE7B1B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1623284127;
	Fri, 14 Nov 2025 15:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mcdZqfbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74958412C; Fri, 14 Nov 2025 15:53:52 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE9184105
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljUF4OpTTHsL//RDd8qDGPnkKnsp0Lla/uClpKZJFE7RyJa4BawPvOVciwEjVH2DRzGT4rh7VT6Rd4sCS+8hRJ3KTsdJbTMkcr3CfG5JdePPoO3v2jXSKBePUlP3Kr5KUzCEbyeok7jjaGoTRO4GWXOZ7n0DPcDkEbdq3t3NBp0LSOtVA5IX1EFPrgvVG1Us2/VDEL5E2Yz/D8YyxZy5XjLGE57ZldyTUeKyqdgFn8zwfSjIFxec9Dz5EEXqLHHJchEC5s60Xa5d7sOnItoT7dVRpVTqV/6EL8E2SecXPRIpsFcF0fwE7RewPSBzXianujIxPS6R31kK3qoM+N7ZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thPCHmtKXYKCoNXLmRMN5gk9+Tiv+zwk6X6/yDePigM=;
 b=hdlhknapFu5qGv4xB53t/GAhUb7V/CTO1kn9+mOe7qQUyrN6/A73kXzA39CMzAplcg3wcQROwPrptaEzkJxtpTP78SWoINgiNxUwm3G4ezveZP9VDcgj9v/Tb6zz3co3NounkVMKiF0ZB8aSFQrbn9F5Q3o+WZnnfWSs6f0t4fNjaGIn+fqxkZTYBoEKlb9Pt5CZT30EztUgZ/BrH/fVTxFhZrXg7LQThF6bpLUpa6U0lcnQOeKmKIQmmmpXG+jmRBzktuWWOsc8iZsOZzoXi7LX4+XpVUmvDJPys1inu9HHxfYyubBKcPr99lM26O4ZPrGrX8xLxksRmFOEJq60YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thPCHmtKXYKCoNXLmRMN5gk9+Tiv+zwk6X6/yDePigM=;
 b=mcdZqfbxbjRJ6jeVpfhOrM0xKinCbllH/TZaJFa1G0BoEz0lh0ayn2YGcYvrnYJM8WyLTZp1uwBeImI6jnMd8F/rxr5EwsgzX0Dd375AHorglVg/7JHn0r819MiC5Z3BPM7Cxr2lMU571Tz5dISgOKDbJQEcxTj2etvqJCxGmTk=
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by CHAPR10MB997723.namprd10.prod.outlook.com (2603:10b6:610:2f6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 14:53:46 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::30) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 14:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 14:53:45 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 08:53:40 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 08:53:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 08:53:38 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AEErYXp2152095;
 Fri, 14 Nov 2025 08:53:35 -0600
Message-ID: <2136a803-617f-4dcf-9dac-3459d6b132e3@ti.com>
Date: Fri, 14 Nov 2025 20:23:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>,
 <afd@ti.com>, <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <t-kristo@ti.com>
CC: <h-salunke@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>,
 <s-vadapalli@ti.com>
References: <20251114114611.57032-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20251114114611.57032-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CHAPR10MB997723:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3b8b44-3d28-48a4-4039-08de238d9c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmlHRThnSDU4L2k0MFFXNUx4eTM2WkhhQXd0b2I3eFlEYnhSNVhvdnJyVTBQ?=
 =?utf-8?B?YW1manFHU2lFaVowNUNsMFdJYU8zWEYwNVRpZVYvbitJRFBwa21JV3JOYTdZ?=
 =?utf-8?B?Q3FBb0I2T0VsTjVGL2RLQjRiN2FSN3lkTGVtemFiZkltVWJ3VU9rMWdwWXZh?=
 =?utf-8?B?N0wzRjJkSzJkNk9kbzVsR2lSTi9jVVBzbFZuSnNDcXlMY2NEa2dsTnVSUVJX?=
 =?utf-8?B?N3VsdzYvelpBVlhYZ01iYk1GQld5Z1ZiMVlibjdZMUgyMlZ3WlU4djFSWWJF?=
 =?utf-8?B?dW85Ny9rZTkvRjh4MHpxLzZSb3hZSVcvZVBRSFVaZUtDUGhzTkgzSU13STQ5?=
 =?utf-8?B?OTJZOTFpL1NDMmwzYlRiYTNnSjNWWnFhZjlZNVJCM084ZHoySERwWFMzR1RD?=
 =?utf-8?B?aENHbkx0RWVtN211TnhqL0JsZ01scWhyQmk0ei8vWHcycGFHYWRsdWlCRk4r?=
 =?utf-8?B?cWpwQVBPK1YvenhiOExBSTlMRDlJeDU4ZnFocEh6MFNhR1J4YVpDTzlHc3lw?=
 =?utf-8?B?V21SOElscWdNR0tWMXVXb3NXMmlVZTdYMVdzSmYxUzhzYVA5aUdUYjVOUkhF?=
 =?utf-8?B?UXAxbStuZzlSRld4dDBJZ1FMU0Y1bnZBU0ZtMC9ROThXaDgyeENBYzgxMytC?=
 =?utf-8?B?TmVnby85RFNBc3Q0ZmIzbTNzQXFMWmdMdGJ2b255QTV5L2xDSzhZWU1wYm1n?=
 =?utf-8?B?eXNvalA3dVcwWVhjMCtTdkgvaDY2WmJvV3g4ekxHYlVzOEV1a0xiQkFkcXQ3?=
 =?utf-8?B?SzNFZGZnanNnbVdKVXo1WVBhMmYrVkNiUWdYL3N2cjhSRFNaTVVPWnFVVnJm?=
 =?utf-8?B?eWJyUTYrWTBicU1iOHJ4QWlPWDNhbm04eVl0NW1Bd0xnc2ZjcFpYT3lUclJS?=
 =?utf-8?B?aDdUK014T3JWemdLRVl0byt4QnRnYkNoV1BTdmo1R2xCWGYvV2RHNGQzNXVY?=
 =?utf-8?B?MmtiZkQrczZsVmZONlRTWjFGNWNOdXFLamdrOWlldFZsRmVISTIwSW0xQXYw?=
 =?utf-8?B?cDYyQU96UnVUMWducXdtbEpCZ0gzZzRRY0NmSExzRTJZU3EzbkFlQU9lajVV?=
 =?utf-8?B?bWZ6NWJaeHk4TEQxcEUwY2MrVGdMVnFLSGR6SVRXZVFzSnM1aW1zSjdJRVhT?=
 =?utf-8?B?Y05wZTV1WkZ5cWFUSmlvajM1TzBqQ1R4ZWdtVzZxQkpzZjZsRnFFY0o5a0hY?=
 =?utf-8?B?VVM5d20vd211bXZFcGJ0dUJPbHgvZlFPaUFvcjZsbS9WZTlyVHRJR1dTM3FD?=
 =?utf-8?B?NmpwdkxvWDgxWElHRXM0cHJ3dHRzb0k1NEVWM0ZYemdIWkNCbitmRklBb2Vh?=
 =?utf-8?B?UnIxTU1LVWM5ZldaUGNwN2xrQUtDSWsyVi96em95ZkRiRHNVUld1ZkJwbjZr?=
 =?utf-8?B?NDVWVFRYaW9mWVBYb1R5MEQzbGRZZVZWaVNwTVMvc2tYZFVmcWY4YnlIY3Zo?=
 =?utf-8?B?T2oxVTFtWUNnQUhuMDJnNmMrd21CSUFNbHRwQ2ZvbHZjai9IVE1rNGVaQk1s?=
 =?utf-8?B?NDJMaVlZMHdOaGhRU1BvMGxnN3ZhRy8wRDJjbU9oUXBzMjNXalBmOWhyajFU?=
 =?utf-8?B?bzFubFhBZkxDRHByMzdmdWVrUHMraGhKU2hXWXhtMU12aHJLRis1V2pndXpx?=
 =?utf-8?B?UTMwZ21YQzBBQzhpaWVqT2c1Um43SnlLUkEvTEVmRmtXUjRNcU5yanVtajhW?=
 =?utf-8?B?bzRPOForNmFyZyszMThYSGd6NTZrQnRiQW1seHhNMVpuZjlKZ2p0YXpVTDFT?=
 =?utf-8?B?VnVEUFlKVmwrYVpyakxvZWM2U2JBYnB6VDNIekxvdkMwSFV1VzJyY2V0ZDNM?=
 =?utf-8?B?NVpCK3lFb040b0o4R0ZTYllDbUpPTkt4T2g1c2pMNGpxR2NwdUNZVUl4QUZG?=
 =?utf-8?B?VXQ2aUlWUU5XNEgyMmxjMnhSTHJxM1lDRTVnVFFPMnFUdnlKMHZJQ2tvUmE4?=
 =?utf-8?B?RlVmazlMcUlFaUt5cVZ1SHRHTkJmZGRPREw0V0s1eDg1QXFuand6SzlMM2Vv?=
 =?utf-8?B?WUhxMWdDcmdZMm1vMDhZUUhXeXFIdmFnNVdWcTUxV015Q2FaZDJsTlRVMXQ5?=
 =?utf-8?B?SnlJUHhiK1dVOUd4RlI4R3NmMm9XY1ZFMTAwZDRyS05xQXhvOGZ2ZVhObnlZ?=
 =?utf-8?Q?cjKA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 14:53:45.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3b8b44-3d28-48a4-4039-08de238d9c33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997723
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

On 14/11/25 5:16 PM, Siddharth Vadapalli wrote:
> The helper function "ti_pd_get()" is responsible for powering on a
> domain if it is powered off. In the current implementation, if a power
> domain is determined to be powered off - no prior users and the PDCTL
> register indicates that the user desired state is OFF, then powering on
> the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
> register.
> 
> While the current implementation indeed requests the power domain to be
> transition to the ON state, the helper function "ti_pd_get()" doesn't
> verify that the power domain has 'transitioned' to the ON state before
> returning to its caller. As a result, it is possible that the device(s)
> belonging to the power domain may be accessed before it is truly powered
> on, leading to a bus abort.
> 
> Fix this by waiting for the power domain to transition to the ON state
> before returning from "ti_pd_get()".
> 
> Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 6c2f2d9aa63 Merge branch 'master' of git://source.denx.de/u-boot-usb
> of the master branch of Mainline U-Boot.
> 
> Regards,
> Siddharth.
> 
>   drivers/power/domain/ti-power-domain.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
> index c3519307340..8f43d0fed30 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -227,6 +227,10 @@ static int ti_pd_get(struct ti_pd *pd)
>   
>   	pd_write(pdctl, pd, PSC_PDCTL);
>   
> +	ret = ti_pd_wait(psc_pd);
> +	if (ret)
> +		return ret;
> +
>   	return 0;

The above section could be replaced by:
	return ti_pd_wait(psc_pd);

I will post the v2 patch implementing this.

Regards,
Siddharth.
