Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C93BC982F1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6119F8367F;
	Fri, 16 Jan 2026 19:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bQypgQzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38537838A5; Fri, 16 Jan 2026 19:33:52 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7DC83015
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKLEDu57z4cBxP/w2LKf4CeLnvjiJ1DsC0ZsHimZkzWd65YWKL+HfLL6SPstCaAf1BnSaIiqhZ1GNqBWjPpZI+8KIZTUuUGMx63cHanhPfaMgbYXS1njSuNt5swFCRuHTHEGlu8R1mnRo+zipsoLlOCcEtw7Q7R+/YvfglXni6easulRoy5Jze2yHgnMj2tdP497Fl5oFCCLOILEhRVE7zsa0dwYqQDrjXgROm6hsaZ65oyZgdXqRAEVjJhWquJbeRvU7VkZ4ZenE4Nj9J4t/QE7xIdYJZH4gIxbjJkOFtlY5++u96TlpQs1bybNVvpPXTY3LX5EYSRV/ZG7ttUwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF055A3MxvEDSLS+W9zVZ2EHWj5KFvEstXHsq1xpegU=;
 b=gScCILWTIb+mdpBwOu3+gMOQaLuhOz0qU+xrSK6lPXB8+LOAvNz1SCyj+8dUaDoSvRoZSed6p6Dd4gbAA85HH7+letc8MMu1IoKTTQmEcQm2ONF4Ml7ZwXxV7L3c1MIjKLl5/EcsRNk/xXXWjaAC741zzViJnEEKG04HthMpTCnuPYS5q/RP1wRvJ4N09addjdEsRMK7rOpZ7NQjxKM/StlbGm6qNz1GrtMqVKP3eS0TOZTVqBR9KxqKIRMKFrst/HrOk/gS116g53JaKDRIje0fXrmx7ynNjzVCQPLG/MEzbYh5ZLuR+wwd5DO/VKDF9fNfuhW+JwjUhGqXWYJz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF055A3MxvEDSLS+W9zVZ2EHWj5KFvEstXHsq1xpegU=;
 b=bQypgQzmK1rr6w+uEZqlBJJ5nBqdxdFvV6uBrLuD4X/7WUhm5jfqAtiIvH+5i3qTM9/sRz7ef/VMhfqtqGyw3CSDv1OgPXrzua/P61f4mKjqrspjPZQHBQdMLTr4fKjyS2JVKJuLpE5W8FT/9b7LIy3v8vNCEWD39JDBEpcLnRc=
Received: from BN0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:141::28)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 18:33:44 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:141:cafe::eb) by BN0PR07CA0025.outlook.office365.com
 (2603:10b6:408:141::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.9 via Frontend Transport; Fri,
 16 Jan 2026 18:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 18:33:44 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 12:33:28 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 12:33:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 12:33:27 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GIXRcr3709218;
 Fri, 16 Jan 2026 12:33:27 -0600
Message-ID: <65dd25b7-f4fa-4ede-8da7-39c963bcaa6a@ti.com>
Date: Fri, 16 Jan 2026 12:33:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: dts: k3-am62d-evm-binman: Override tiboot3
 filenames for AM62D
To: Paresh Bhagat <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <khasim@ti.com>,
 <m-chawdhry@ti.com>, <t-pratham@ti.com>, <nm@ti.com>, <v-singh1@ti.com>
References: <20260116103010.3947922-1-p-bhagat@ti.com>
 <20260116103010.3947922-4-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260116103010.3947922-4-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: a89de0a0-8f29-4b41-6dce-08de552dc77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkFyejBudU13RmhDdDNta1FLaUZNeCttQkQ4THdRZGw5ODhqbmtKMUJwcklh?=
 =?utf-8?B?bUVYRDRVVm1kSjIyZUM0WUJBc2hremdPUGtjb3MxL0svN3pYUmZtZnFuaWpP?=
 =?utf-8?B?cVQ4ZkNwVTdTQ0FKZ3BYUWJtZHo5VThPU0kwUjJCUTUwcVJ2RGhESE11WkFU?=
 =?utf-8?B?RmFvejZVR1AyVmIrdDBlWXMwdmhLMVpVZW5VTUhPSWdnR2pLL29za1hvTUxs?=
 =?utf-8?B?M2YrbVNsR2grZllBVDk0M3czdHhseVVpR1dvTGNJZ3lFdE9WcDkxdGhhb2tj?=
 =?utf-8?B?YytTOWFML1l2STdsRHN3bk5naUxKL2Z3ZEtvMlgzWnFLMGE1Nm0vVzNZMzMx?=
 =?utf-8?B?b0dEK0dhME9KOCszRzZoTU9kZUtEUlRKZWFhMWozeVZHeXgzdlRkL2VNYzhS?=
 =?utf-8?B?TURlSXZQT3RlZTgyY3BzaUplWjBMY0RlUzhmQ2pJSU9NeVRIZnJ6MjVqZkF6?=
 =?utf-8?B?ZzNNSk0vRmRCajBIYnJPMnJ0S2k4amM4dHJ2YlI5ZjRGMTFRRGJZa2xWalR3?=
 =?utf-8?B?SEgwemVVc1lYWGkwZVBGSHRSOTR6a256RDdGUG4wZHdrTE9yZTlMbDAyN01Y?=
 =?utf-8?B?UHFJSzJhV0Q2OE90QlFnN1A4NUE3cGFYZ2FDTDRiaGJLUUcyUWV0UG5hUTlH?=
 =?utf-8?B?Z1BQckFBS0dXc3dLWnU2OUZCQUowSUQ0NUdlRWF3VnI0OURCRXVITXljeTNP?=
 =?utf-8?B?SjFUajlEN1RNc2tYVUNHS2JLVnJzTTVBNEE2ZkNiWlN0RGY1RmJERit0bUZt?=
 =?utf-8?B?bDJlVlBZaVNqdzVoV0NZemY5ZlJIUXM2OWRRZ01nTUtxNkdLZlU5THJUUDZQ?=
 =?utf-8?B?SG12WmRHemRTOFg0dTlaaEZwNGs1SE83RDdmaEh0eGRYZFVyeWZ1MzFUdGQ2?=
 =?utf-8?B?T0NDcGF2VUljTGpqWi9UMjJkTTBJam92WlNkbGV5L3A2YU13eVBvamQzR24v?=
 =?utf-8?B?YVJmOGljUHNCMUpNZ3lZSGRMSlNzcnJ6ZGxsdy9lNUtRRFY4eXphbEFPclRs?=
 =?utf-8?B?a3kzZmZib2dPV3Nydmk2ak40SGpXV1JiT3d2dTNvR1JSRGpEdmF3NktLMHVQ?=
 =?utf-8?B?WnlKZlc3eHV0U2I2cnpBNzIyRkd4QTU0SERpanBESE5rL0ZqdVVMV2Y5MTRL?=
 =?utf-8?B?ZTdFazIyUHEyWlJRcE8yemx3cjlDT29UQytuajRWODdicCthUVhIb09FdGEw?=
 =?utf-8?B?bTU0TFo4U0dlT1NTWU5jQ2h3eTh0ZzJ1bVE1WmIwNU9GYWdEaEIyZ3NRMU5Y?=
 =?utf-8?B?ODMrRG41OUJ4QzlsVTA3K0xOSGVYQ09wcC9mWi8yU1lKSGNQczdFT2tvcHFY?=
 =?utf-8?B?QzJWd1BXcHhhcHBTQWFuVEFHQlNlVGMrSDQzQnU4NWNDVWtGU3ZQeWdVWVpq?=
 =?utf-8?B?TkE2YTBCTWpsbEozaTBIdUkxZ0lqbXNaZ25rTmxhMVpiU0NZMFF5UGhGWFQx?=
 =?utf-8?B?SjZEaE5XbzN0VzZXZEhQUC9SK3hFUUZXMXdXVit3a1N6Q2FOdDZBVnc0VWhK?=
 =?utf-8?B?TmZjcE5IT296RnpnT1I2QzBkc0lhTVEwZERJVDluZTFLK25ENmxDdnllejRD?=
 =?utf-8?B?eEtBemxKc2lLTGI4Q2FtNTNtZkhKUXJHZXBVMS81bm4yYjBHd2h4WUE5ei9n?=
 =?utf-8?B?dmFQQUpsQ2R5Y0ozNE1jOUt5azQ4RURzY1dEeGdKekFGVTV1enBiUjBCY21X?=
 =?utf-8?B?S2pUTHZ5S0E4SFdpYWFpMlNEaHNjL0I0UDFWSWxiY2J1NkFhNTVGTk5seENY?=
 =?utf-8?B?UFVQOGNBamppWHJjOFk1MzQ1RklLeUJ1R21KOHFSZHRUTFJ4dWN4NW95UTNF?=
 =?utf-8?B?Vk5QV2IxWmVuR0lwR21ZU2JEZlgvRXdCeGtWTFVCVjJwMlhRb0NCeWJkRW8w?=
 =?utf-8?B?MGtNTVZwQ1UwQmdkSmVWT1hRWkxqZy9iUVQ1NDE4ekxuN0FUUVkwZWZBWkw1?=
 =?utf-8?B?ZmFDaUVtb04zOGdpU1V2WUt4UlBYVHdkcUppTysvRjhXamFEejV1TGkyY0Z1?=
 =?utf-8?B?Z3R1UUQydFlKeWx3OURzTEdtOXl0VDA3QldqUjAvTzZseHM1UXFldDN0UEdh?=
 =?utf-8?B?d0RrNWNQQTJLZlZORWhjMmVLTXd2Q09uYXFMWDdaeG03NDFiTE9ySitURFJh?=
 =?utf-8?B?amVBWmY4WGFXS1VSL3JQYUxSY0JUSWNLYUUzNlF6UytUMUUrYmh5ZXBldTdy?=
 =?utf-8?B?MjF4Wit2UlQwVnk3N2xIQTIzMjZXcS9DeTBpZDV0SDBpR0Y2YXMrbmw1UjZL?=
 =?utf-8?B?NG5WbUhUeXpUR092MlIwRVNJbkR3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(34020700016)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 18:33:44.0620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89de0a0-8f29-4b41-6dce-08de552dc77a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
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

On 1/16/26 4:30 AM, Paresh Bhagat wrote:
> Reference the tiboot3 binary labels from k3-am62a-sk-binman.dtsi and
> override their filenames to use AM62D-specific names:
> - tiboot3-am62dx-hs-evm.bin
> - tiboot3-am62dx-hs-fs-evm.bin
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/dts/k3-am62d-evm-binman.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> index 41c8746cf08..430bf8ccb79 100644
> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> @@ -63,6 +63,14 @@
>   	config = "board/ti/am62ax/rm-cfg.yaml";
>   };
>   
> +&tiboot3_am62ax_hs_evm {
> +	filename = "tiboot3-am62dx-hs-evm.bin";
> +};

NAK

We have discussed this before, the name of the file is based on the TIFS
binary used. This file uses "ti-fs-firmware-am62ax-hs-enc.bin" so its
name must match. The name has nothing to do with which board or SoC the
SPL was built for, we have *never* named the SPL image after the board or
SoC, if you believe otherwise then tell me what specific board or SoC the
file "tiboot3.bin" or "MLO" is for?

You also give no "why" you need to change the name in your commit message
nor cover-letter, simply stating it is the "correct" name. I do know the
reason, and it isn't a good one, go fix your yocto/test scripts.

Andrew

> +
> +&tiboot3_am62ax_hs_fs_evm {
> +	filename = "tiboot3-am62dx-hs-fs-evm.bin";
> +};
> +
>   #endif
>   
>   #ifdef CONFIG_TARGET_AM62D2_A53_EVM

