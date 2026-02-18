Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB8E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4C083CE3;
	Wed, 18 Feb 2026 14:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AY0lu0+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7890A83AC5; Wed, 18 Feb 2026 14:27:26 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C35683A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAy+zG0dZIXNlNwiIbhupZRYCff/6TejWmbYZuXrwsuFaLYalo9rNrlHn8hzdln8vF53o1fvRgItRU8c6mdBnhyRrIcyW5PbnwxIjDcciIPEWuLdUQ6oYZpEZLj+jvfG7i0rHLEkhxSF/Sk+FSJTDV4a02N6vx3DiHOMHrSlfC48A6nHxdZeJTTOBsApe8kh5+exPTWfRJ3hf5ZgNpFGHEreirfR5m/qEeF0b2vS+XpdrlVueLLqXQqJKprACFOyuiS1ayvwe5xwMK7bWsfasUWkbdAdfqoJfLly37jWwS5renurzozczKEgxjIcK7Wsr0UjYqn8JTC+QV12igEykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sPIpLf3h0AI5GOfg4cigNOlhzKg6vivmJFHA/Yvjnw=;
 b=K3xAP72dWJ1dAAQXs1l1bfMbqEVyXepbevPIz5Cghwce1No08TJ3PSCpREnw1umENFd5YPCzj3PGbeH9kMAHc0aPmwqVZeKwkWeOOVmEb8xr+TO2B7K4MO2+qDAhVYo+TNjxvd+50wKwC0ym5yuhmEJIDgJdLCnvriiVOdxA1onTUq9ICIOnI8e7XLgXD2zKmGSUQATCs6/5W9hBeycqnLubOpeOCsgXVmgZOS49nm62gosWTu+JxNDy+2MVmZ7tvsM5rGO+Ae5zYsvShf3BGTOFrspsrD/yNvCj7Q9UHsKMEj6v8bfnp/p1JtOlXGJQCzmLAi1ijii/kdQZP5LlsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sPIpLf3h0AI5GOfg4cigNOlhzKg6vivmJFHA/Yvjnw=;
 b=AY0lu0+6KCypNGetEXghzcdrsr/W3TEUhzu0Si2v1pX3X6oFNmExauOdS+y8bp5McFOD1q1p9XNKhwI83FUIErCJOjNJuuEAtDLJut19LUnXvVg7G46veBJAO9Zy3e4kRxMty8l/28+T1W0y/rE/+nY9NBttxo2FnDq9np55DPA=
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by SN7PR10MB6571.namprd10.prod.outlook.com (2603:10b6:806:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 13:27:19 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::1e) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 13:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 13:27:18 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:27:18 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:27:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 07:27:18 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61IDRCCM440597;
 Wed, 18 Feb 2026 07:27:13 -0600
Message-ID: <8f91ccb6-dccc-4f09-ab78-6e92d407f3d8@ti.com>
Date: Wed, 18 Feb 2026 18:57:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-11-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260216102858.2745657-11-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SN7PR10MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 860acab5-67dc-4793-2602-08de6ef170a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXlTMmx2VG04U2U0RkkrcGlKR0c2bjlKcEVVQk8yOW9ZZ3pneEJHRWJNMG9i?=
 =?utf-8?B?bVFHblh0cjlscWFsSHlHSUhLVmtualhNSDRWbUx3M1RoWlh0N28yQ3dVZk9R?=
 =?utf-8?B?R1JJTWZkZ1VwM2tqbWx0dmNJR08xMTdvUWF3NW5zSVpDMXV5czNiemlxeGp4?=
 =?utf-8?B?cE1hQmkybkxMYW5sb1BKdTNLYVFXMVdmWUJrU2dxV25qTWplTHNPc3RNVnA2?=
 =?utf-8?B?NGxFYTVFNzRKVkE4OEFLU2hXdFZ4L2FabEkyYVNwYXd3TExiY1kwVVdUOXgy?=
 =?utf-8?B?WkJsZUpkWWhvNWhrbjdGcjI1NmJLK1BrUWl3Vkl6c1ZuUk1HU1pOZXpZSzV0?=
 =?utf-8?B?Z2U0RDB5QlFwMlpHaUI3V0NJakNlb3JGd0RYenJVQU9OeHpTOXBUTWV0VVJE?=
 =?utf-8?B?U0ZudlV3dTBhMU5FUWRrS3NhZVpXeEcwTStacmJYcUd5d1E5aG45cDkvTWZ0?=
 =?utf-8?B?VzU5ZWx2OXhWRFdpcTA2dzRTOENyNG0rZThJaGZRQVh6Y0drVENMaHloWXBO?=
 =?utf-8?B?NUcxRWJTTytoa0s5cTIyTFdPREtuZUdEdE5IT2s0WE1NNkdkL0F2QXZObU5I?=
 =?utf-8?B?endiT0dWSjNjQ0V2aVl3K3NqeC9UVlU4L0x0eGJyZ3dONzNidk1OKytrOTBQ?=
 =?utf-8?B?ems2NDdaRGd4eTg1Nys5akZ5NHA4Tys0aEd2RENzc3lyQ29DYmJKMW5tOHpy?=
 =?utf-8?B?Wmd5dWs5eGtIVGJDb0VvN1RmQWs4RTdnOEl1RndldUtTZUwrM0N1Zld0Q1NP?=
 =?utf-8?B?K0sxbU9INGs2ZEQ3LzlMV3VOcENLY0puVzdpZi9VQ0x6VG5EMVJlUlpPMTB5?=
 =?utf-8?B?ck1NWGEyckhIaG1sZEpBbkxtOFpWNG5LSU51Znl3WVdqVm9FaTFWS1BUY1V1?=
 =?utf-8?B?T3o2UzNXamFLOUdrZHFBTUxzN1hwdUpKV3hIYjVLVVIwTWpLcHU1K29oa0Fh?=
 =?utf-8?B?MENjMC94NjhHK1l5U2ptOXUzVlRBVm1XUTBXQlYydW1yS2IvNWRzYXZXbUtL?=
 =?utf-8?B?YkRxemczSjJsRDBsLzlFcXVOWG4zZjdmNDR4RUxXeSt6Q1lxM3IwZEd6SFN6?=
 =?utf-8?B?eUNzbEhad1VCUzkwRTJzNHFZM2tKZlVBcVBYOWhhS0o3Y0V6N0hoSzNZM0tY?=
 =?utf-8?B?cXI1YTlwem1zL1ZqV2VQOXdpNC9FdGtrODVlei96ZzBWbXBxZlpGT1Z5STdp?=
 =?utf-8?B?MG5FdDlIeXluY3lmVDArblJKZlFhZmpnaXd1K2M0alpFMGwvMmExamkzVXY1?=
 =?utf-8?B?aTk4bERHZllFTlFTbStaalJ6K2lPVWZBbXRuYWZhSnN4bkdRejVPNm9zajV6?=
 =?utf-8?B?UmR2WmVUKzUzdjkxUHlDTE9NYlQ2bmhsaFQwMXZhZC85TDY3TXZ3YXhMR240?=
 =?utf-8?B?Z1l2QkFQTXd1UDJGS21IU29MQlZVSkVVYUZ5MjBtNGRVaG1JSTEzNS9RUUZN?=
 =?utf-8?B?TFp0R25Mbmx6eXpBazk0a0pDdWlQZVJpMzF5c1M3R0dKa0lmZE5RS3pFaFZy?=
 =?utf-8?B?REk1SC9ybUk3akpaNVhKdWVVYk5xbm1nd2tXVlV3cGQvUGZSTjlQcko2c25L?=
 =?utf-8?B?UW5oKzBxc1pHZlhEQU92bTZIR3ZhSDRiTzh2ZmpNYlpMM21CN1A0V0ZKaEE4?=
 =?utf-8?B?Q01Ld05WS2dxbnQzRkpsUUN5NnZrSUJxWnA5cTMrenpoUUY4WTBGb3VsVnhl?=
 =?utf-8?B?TFEveVFHelgrZkRlaXlUMENvcU1VU1B5K1V5dmF4RVZWdmM1Rm9LYmRKOGk5?=
 =?utf-8?B?MVlVNUxBR0REZmZqaHc3SEdPVlVHdFlxdnZzSmVzT1pnbnl6TUxqWVc5cUN5?=
 =?utf-8?B?bFN4ZHN6bGJjNmIzemVHK1pNZE1FTEM3dTJzQU1PZGR4VStJaStFVkxxOWFR?=
 =?utf-8?B?TGxkZHZIWloxekJhT2l1R3Jma0xMUE0xM2xaK3NYT3o1WGw0ajZQV2VkazhI?=
 =?utf-8?B?ZTZ0eWdSWkRpa2tkbUorVmNGTjRHZkl6NktXOU1IYU1TYWZmVDZCZlE1SnlM?=
 =?utf-8?B?SlJSekpkOUVMdS9EM25SNEVMbUo0VjdvS283Ni9pa1YrQzBtZ0hKTmlGSERu?=
 =?utf-8?B?Yms4VUJLUWkrSDBtWWU4ODdWaVFFd0NzMWFpRmk5NzBSbW1qbTc1ZmIrdzAx?=
 =?utf-8?B?RTd4Y1hHZkxxS0ZZZ00yWlFHTTJRY1oweHZ1N0VvdW0zMmhKekp5YXM1WTY0?=
 =?utf-8?B?NnFiZW9VU3ppRVBMSDc5SlkzMUpmTEsvK1NlOUxRSzBGcGlkZFlrMDFpdzAw?=
 =?utf-8?Q?NZCnm2diXA7WgryfXvtbI28wuWUSTx46cNKUPGKVNo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qvP6l4oR8OTRLeFSjx1hcq24TykdNlPlhtAq9vpHbEY9mm1dKAbNyG90FaU5ursxEMBb0YW5mFqt3C1dfQ2EfeHorIGwOHwcbG0WN4vLp8eTZOycD/Z96PCfGBQuBxuGojpnuRtgazEPyhgLE65zKYK4SispyTpUXow3PUZqo68Df3gfQIetOUI50PYfQScMn2+k+05OpVrleeT1DCarTsfnR4Z+RvWzXyytXTDykklXTV7BOaQRVxooMDr1EZ7b5luLk5wB0JTjAhiEnBcGatUcDZbFIuBefCdnlM9BacjCxs5ObK04pifxxsZj4qH6PJrqRzT7aJGdBC2EjlUAwmEJ716cn5De2k40e7ikthp0tnyeqLglkwu3AJjya8rhHuiPTIZMvRUbO2pyJQwA3NIhyrqUfvORhTZOLgDHzBkc2+5l++emJz2kiTnRDTY9
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 13:27:18.8118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860acab5-67dc-4793-2602-08de6ef170a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6571
X-Mailman-Approved-At: Wed, 18 Feb 2026 14:32:16 +0100
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


On 2/16/2026 3:58 PM, Siddharth Vadapalli wrote:
> From: Hrushikesh Salunke <h-salunke@ti.com>
>
> Add PCIe boot documentation for J784S4-EVM including boot mode switch
> settings, hardware setup requirements, endpoint configuration details
> and step-by-step boot procedure.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> [s-vadapalli@ti.com: simplified and documented the pcie_boot_util program]
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   doc/board/ti/j784s4_evm.rst | 305 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 305 insertions(+)
>
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index d858dc7cdbb..fb767bedbf6 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -299,6 +299,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
>        - 00000000
>        - 01110000
>   
> +   * - PCIe
> +     - 10001000
> +     - 01010000
> +
>   For SW7 and SW11, the switch state in the "ON" position = 1.
>   
>   Boot Mode Pins for AM69-SK
> @@ -330,6 +334,307 @@ section.
>   
>   For SW2, the switch state in the "ON" position = 1.
>   
> [..]
> +
> +PCIe Boot Procedure
> +^^^^^^^^^^^^^^^^^^^
> +

overall series looks ok.

One suggestion, if you can move generic document into some common file 
and include here.

then you may not need to update repeat text for each platform.

> +The following steps describe the process of booting J784S4-EVM over PCIe:
> +
> +1. Compile the sample host program (provided after this section):
> +
> +   .. prompt:: bash
> +
> +      gcc -o pcie_boot_util pcie_boot_util.c
> +
> +2. Power on the J784S4-EVM (endpoint) after configuring boot mode switches
> +   for PCIe Boot.
> +
> +3. Copy the compiled sample host program (pcie_boot_util) and the bootloader
> +   images to the Root Complex. Check PCIe enumeration on Root Complex to ensure
> +   that the J784S4 EVM shows up as the PCIe Endpoint:
> +
> +   .. prompt:: bash
> +
> +      lspci
> +
> +   The endpoint will appear as a RAM device or with multiple functions:
> +
> +   .. code-block:: text
> +
> +      0000:00:00.0 PCI bridge: Texas Instruments Device b012
> +      0000:01:00.0 RAM memory: Texas Instruments Device b012
> +      0000:01:00.1 Non-VGA unclassified device: Texas Instruments Device 0100
> +      0000:01:00.2 Non-VGA unclassified device: Texas Instruments Device 0100
> +
> +4. Copy ``tiboot3.bin`` to the endpoint. Use ``lspci -vv`` to identify the BAR
> +   address:
> +
> +   .. prompt:: bash
> +
> +      sudo ./pcie_boot_util 0x4007100000 tiboot3.bin
> +
> +   The sample program automatically writes the image start address to
> +   ``0x41CF3FE0`` and the magic word ``0xB17CEAD9`` to ``0x41CF3FE4``.
> +
> [..]
