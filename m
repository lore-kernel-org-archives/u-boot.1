Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7DDC48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B8958704F;
	Wed, 15 Nov 2023 15:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDEOoJ9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8A087197; Wed, 15 Nov 2023 15:10:44 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2794A86FBB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lB6iGqvMsvvBdYM6ZXktl3gLrel7oJ6BQyCZ9pCUKA8+c2cMIxH3rHbETwp5jUDDcMwbJYjacbJZt1rnLHK8luvJq0uc//qnbQNcc4uutsiXgGsgqeGnF8eT6qFeqsV/ze34zPHkMZR8hhH0S/aBgefSVo2LlhKTn0eXxjxMIa9uDF83ICez4f779X9wj7VrPzG4JT8MicpI+HbcuzkqB2aaXYWDgzqlIalTHqjiN1ysQkMDDGF+JJseUZV3cGqqTob12vGJ9nT36SB9uxNTZtpudHMzbgOy+Rfyzv9BbDeWuEAGwaUDm9nwHqRMfFDIiTYRdinSANUB/a9pRS8b9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkyNj3A8Mxcs2vBtXUQl3ysYriA9wSf0N8DXUe+3qj0=;
 b=hbIl7V0pZ58RWl44jNxt1EWAoQBeomLaNUkFl4lFVPicionECY5BK+h/2U4/mnIscvYrqxZsvinqvU/crSEH7ORoTZLD8Qcl8YsNkRWUqHkFP9M3zaHAx8ltyWZ9AWytquM+JnuehAfXhUw2rCTrox2abdHp7tGz+vMCGjwjEDFPGnwbPbVXQalb+Ze44Z2dvyngnY6dE6OMnTVGF9V3rKa6xk4shqVXkMaAJCM0EEo+fmUhg5U6/H/wBAgt2trtZyJXEpd3YYmiZjPpAAiXCHGvMVIt7v0sYV4RZm4Y16LQk78gFke2/CMOG8E01SLMagzT60kaCJ2ZBgK0a6Dk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkyNj3A8Mxcs2vBtXUQl3ysYriA9wSf0N8DXUe+3qj0=;
 b=kDEOoJ9jaLFMbDCNqNnEhI/HiFm/DKNyTaSOS6vVOfTBrgsfFN/S+VfrORlApu1mZyvB44KEMsdt4HFEVx4jcFb63sG8FSqtlVsfV5rvJoQnzORuFY4kY/i9VPPaZp0BRQUea6VhxEFkCkihEOqNy+TA3Y3HGVgZi8/mz2/vsX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 14:10:38 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:10:37 +0000
Message-ID: <550bc059-5d5a-4d62-8602-fefdcdd267a4@amd.com>
Date: Wed, 15 Nov 2023 15:10:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not expose usbhub nodes
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <537c91a7ac0843358c4e33aa10d9e035d8e92faf.1699286139.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <537c91a7ac0843358c4e33aa10d9e035d8e92faf.1699286139.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: f77589a6-169f-45f6-33d9-08dbe5e4a460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/j5it36z/7z0L081V29LhOYZ7eAs7v7DGybNhKfcZUMa6w8yIOIadnmVoxco+W9BPQDkou66nFvp7lVgfCrJX6zYA1KH5+J5sSNXwbZ7rgcOcxfFeIN9iA4l26HLwSA2NdCGhrgWCvgBhiuwBhLBPGexp6sA7P7HqzkIwsBomnAZEFUMn2iemRQRAWB6Pg0OwRjBO/f3lDA4m50G4ms/tMkldqGv8i6JNnqiCFH1lbEyqtW+Zh2zOfDnBad0tefCJAj0sy8AZxsQfMK2bt70Fo8Y7JemsfxaodVQ/efKV7LmDkTvYOvtVVKTmC6MCo51urUtAKns8zofvQLIgwmGPPlavrJPcr2eQHmsqxWSKrRoS6wIsBh+VwSkQKaDwoxSYz7zbhi6G6fpop4dkNJo1+lAuNSZYFxKw/CPRDACt69UTljdLD02Mb5VqKEyXWDdS191OWyKpTQLlQiG4W7MT7GY7PjcrGyn7VnbW7QABf4kP9yGbvXus7oKxVe+++kXnh9dzJLDB1WB7k5PyFOxY4a7Kg64ySiK9iYDK3GX/EehYu1OWmGLeiBS3aEE99WcE+YbU5dQ1PJavVcnTfpiyan/SfU6BUS6FCG0k+SRWJ854tuA1ziYUfuJRnFiQ2p2EKvr9qFKrJWt+grd+2T0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(83380400001)(66946007)(8936002)(8676002)(66476007)(66556008)(31686004)(36756003)(41300700001)(26005)(31696002)(6512007)(2616005)(6506007)(53546011)(6666004)(478600001)(6486002)(2906002)(44832011)(316002)(5660300002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUNxdVZZK2pSWDQzN1ZORUNnOVpJTkwwMUhjU1E0OFREVkxmSlVTRXgzMmJK?=
 =?utf-8?B?ZCtLc2ZCY1FGdHZSeXZWRXVWWXJCNGxNMlVxcXpQSWl5UzM5V0JRK3FFa2F0?=
 =?utf-8?B?MklMbzdmb25XbHdYL1AvV0kwUzFuSE0yejRsS1hEdjZzQTNra00rcTRKcUI5?=
 =?utf-8?B?OUJZeGlkTmpRUXVjRTJjemp4RkNnOGdZNUFDTFIzZGdZS3NHTnFqa0h4UTFL?=
 =?utf-8?B?QUxqSmF4SUNBcUJhOEV5UVh3MjlzRHp3Mjg3U1Q1QlNJRm9PRklIMzBYQ3dl?=
 =?utf-8?B?REk3eE5sS0RORVBCdktrWlFSN0FNSnVVSjRoMFh2YzhqYjQwWXRrOStFQjZl?=
 =?utf-8?B?RFNhdjA1M3FSZkdmbEFXa0FTMENyYklGc3gvL2I1SldFOWF4a3JtaHIwRnpY?=
 =?utf-8?B?clhFZ0RVQkJkVnk1T1A0WHJnZE5MelBkY0tnL3laZXR3VTRqS0RpZUh6Szhy?=
 =?utf-8?B?OUx6RWt1dVdtZkcreEwyMVhwb2Z5WkVFOG5mU2hKa2t1VTd3c2FIc1hKc1FM?=
 =?utf-8?B?OGFRTUFwUURIOFlGR0ZJMC9oZ3AyUTQwUzFtaXpkVm85QkN2MVJIYndodStC?=
 =?utf-8?B?V3c4d1hkSHZuYk15aEZaWUZ6SXRHcFhIekdhdWFuWnIzNEtoeFFIVUl6NEFH?=
 =?utf-8?B?K2NVQU40UXMvSlBSQUxDU093TEFDNitzSjF6M2xFVi8rcklBSkNER2ErVUov?=
 =?utf-8?B?TzM0SmlYc1ZEUlpETUF5Yk4yWFBxR083MXVmZXVvODBpdFNzWHdKNEFrYS9Y?=
 =?utf-8?B?ZVFnemNoZ3h0R3RJSFFpMXNSemZrWnpqZEs0YXRyWlVrcTI2TXNEZEhzbHZN?=
 =?utf-8?B?bXJKOFpRc3ladUR6QnpXaHJBWjVPOFVpVzlnNjgwdS9WSjlqMWxrekQ2MG1V?=
 =?utf-8?B?MXdiRjBvN3dQNFp3Znl2SHZrd0E0UnFMWlRRRnNSdHBZRG9HVnlucVFMVjhG?=
 =?utf-8?B?TkVJc1dQVnpzSm5jSi9vUWdOSkxINU90SGNIbFVreWpZZTJacm01bm1qK1pX?=
 =?utf-8?B?MWd5M0ZiNDVvMkJmbVFiOWQ4ZXVWVnhCeW43R2xZMWpyTDUzUHMxMUJ5bkxt?=
 =?utf-8?B?d3pPTm5LTjFUVm1sbjkzL1RxTDJJN2svK0VBemRVMFhSSkY4TzU0M3Vnd3lX?=
 =?utf-8?B?cjV6aUxzck84c0V2eDRTclZJdFpvcUZvQ2ZQaXh0bEM1OUFYK2d2WFJMaTIw?=
 =?utf-8?B?SGlFcnNUWElpNHd0VFQ0cEF0S2tvQnRZc2RZOG05QWRkZlNaaVBlNGdQQVZO?=
 =?utf-8?B?S2ZuZHV6ZlVtdkdCYVB5ci9NY0ZVZkpjbWFYaVphK0hZZXBKUmtrWjcrbk10?=
 =?utf-8?B?Ly9jc0JTclYxbWpLSXYvR3dhOHQ0ZWllRVpYLzljcmg4cCtwejBhTGtaLzU3?=
 =?utf-8?B?S0x0SXJ4UkZUZFlXaFMvelpOTWJpYjhyM1JNK2xIKzFSZ2VSVTVPTUhrMERK?=
 =?utf-8?B?MlJURllmWmNkM29DQ0puZUlwbURtdUpvc2RIdUdYbERsdWU1S1R5UkFkVjJ4?=
 =?utf-8?B?dVdsOWlpK1BVYmVHZEo5am5NdE1FQjBVSVJ6Q3BnQlU5TjhMZCthVmtLelJE?=
 =?utf-8?B?c1pzTGRRMDRJd0h5VzFnK2txa016UWt2VTRkSFdwVlBjZzJ0dEtIYStkN004?=
 =?utf-8?B?QVkyNHlKalZpVkRRT0xkeTZobEw5UTBoZk1FQjNRa0RpYmJaRTN3OGxmTUxX?=
 =?utf-8?B?RVJ6QkVXVXM3R085ZlRMdUZadlBHUHE2WTl6SkRhcWNpMGZjQkZ1Zk5HcXpy?=
 =?utf-8?B?cmhxdWtoY1UxaXNvUGh1d2pjL0tmNUplUWJPcFplNmpveUVQT2lBUEpTM0w0?=
 =?utf-8?B?SWNuNTZJdGlnNXFtK3craWNnUUtCdXZBVWhFbkJQdHhoWTFTMzU0djAzRnJ3?=
 =?utf-8?B?V2lkZDJ6YjIxZUphS1dOR3Z6cmd5azNmNUlyYnp1TlBKZFl0Um1JM3hlbDVC?=
 =?utf-8?B?QW0xbnQ2ZVNvamkrVTY3SmdlZ0g5UmUvZHM5M0ZIZU1kZ1JhaXA0cmdOeXZu?=
 =?utf-8?B?cU5lQm02VllOK0J6L0l4bkkrckJLN1daZXM0aEFCV2JkOC9QVWM4U2xjbURJ?=
 =?utf-8?B?ZU50WVZ6bDQzOWkyWVlYbHJ3VXgzQnk0WEUyNWYzQlJsMnlYajNTREx5NHAz?=
 =?utf-8?Q?UYygdJFw/nyAIdJJpnxa+5UH2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77589a6-169f-45f6-33d9-08dbe5e4a460
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:10:37.8798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iKYOzEdlNvws+i2doap2hbA0U0eAiA5IAXH4A44yOW7L3xoGpKSOARgPLavMkQG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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



On 11/6/23 16:55, Michal Simek wrote:
> Upstream dwc3 U-Boot driver is not able to handle child nodes properly
> that's why comment them in DT for now. This patch should be reverted when
> dwc3 driver handles it properly.
> DT node itself is aligned with dt schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 3 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 3 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 3 ++-
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 2 ++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 3 ++-
>   5 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 5a5c1efd6b96..8d0ddecdc14c 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -87,7 +87,7 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -
> +#if 0
>   	usbhub0: usb-hub { /* u36 */
>   		i2c-bus = <&i2c1>;
>   		compatible = "microchip,usb5744";
> @@ -98,6 +98,7 @@
>   		compatible = "microchip,usb2244";
>   		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
>   	};
> +#endif
>   };
>   
>   &dwc3_0 {
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 30a0230d4767..95b1dc5aa571 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -139,7 +139,7 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -
> +#if 0
>   	usbhub0: usb-hub { /* u43 */
>   		i2c-bus = <&usbhub_i2c0>;
>   		compatible = "microchip,usb5744";
> @@ -150,6 +150,7 @@
>   		compatible = "microchip,usb2244";
>   		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
>   	};
> +#endif
>   };
>   
>   &dwc3_0 {
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 8f4c52d6d643..e2387a2abb8f 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -139,7 +139,7 @@
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>   	reset-gpios = <&slg7xl45106 0 GPIO_ACTIVE_LOW>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -
> +#if 0
>   	usbhub0: usb-hub { /* u43 */
>   		i2c-bus = <&usbhub_i2c0>;
>   		compatible = "microchip,usb5744";
> @@ -150,6 +150,7 @@
>   		compatible = "microchip,usb2244";
>   		reset-gpios = <&slg7xl45106 2 GPIO_ACTIVE_LOW>;
>   	};
> +#endif
>   };
>   
>   &dwc3_0 {
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index c4f1da92186f..f43c159cdca9 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -131,10 +131,12 @@
>   	pinctrl-0 = <&pinctrl_usb0_default>;
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
> +#if 0
>   	usbhub: usb5744 { /* u43 */
>   		compatible = "microchip,usb5744";
>   		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
>   	};
> +#endif
>   };
>   
>   &dwc3_0 {
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 6c5e0e566061..3643569cc7c8 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -113,13 +113,14 @@
>   	phy-names = "usb3-phy";
>   	phys = <&psgtr 2 PHY_TYPE_USB3 0 1>;
>   	assigned-clock-rates = <250000000>, <20000000>;
> -
> +#if 0
>   	usb5744: usb-hub { /* u43 */
>   		status = "okay";
>   		compatible = "microchip,usb5744";
>   		i2c-bus = <&i2c1>;
>   		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
>   	};
> +#endif
>   };
>   
>   &dwc3_0 {

Applied.
M
