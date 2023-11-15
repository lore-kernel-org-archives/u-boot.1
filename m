Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B96C48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 14:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A49D8721C;
	Wed, 15 Nov 2023 15:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGv4vlj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7E28721D; Wed, 15 Nov 2023 15:11:07 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E9C87203
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 15:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpQEfmrJ2hFyJ/WNSeUHsuwXiK8EBxOzvOZscTEoSvKpIy0N+ZG413E5OEc97gYIP/6UxFdUXjQmD4EHRrbxm3zq82gsThLUyB0/km553oOsFXSYPwLLuIW0Uug4YB17V8PDflfe2kGaQ3z8TBVcFZDrtXT2bVH8278SZvjYqDnplQQo2Vzj3PhmXAk9Sifw4G6KsygfIpsvAlY61TwVX9jV4GlUFYZZJ8j44APTAkJ6/Vox/d2XVTs0xvsYQzEjdD6Yo5AmvdlVJupLyvLsWc5oKS4AP857Ja//tOK+O1QZKa3R1tdm7fahmdfnjZkMil5zfuZmrppVLJLaEs8v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/sdKZ57ZtBcJJ0A3Fl8905uKwy9FrSc2GBqp7U1XGo=;
 b=m00334aplyxYVR/u9KDSpw1V7nVKMOTg0pkiXDs1/32cPj/QHg9u7oJPLeLF3oCvjtTEPUW8RIg47xIw7Kqz2/4xnT+ansIXEo0TQ7xQdhsiFRSrAIKM84UT3tnOOdMGgBBwyK2atG7WUx0oRS/Cj62ZDJMcCBVVFuohxU2Ep3a5cS4g8VhUdgU/HVTXRVgvSJrwJQOuoWhfprDMeczwt6/xe9X7NDYuWQFZjRZ0SqQVS4TJRoQn+9syh8KSXKnRgGaTlLE0yYySs6jSH5bZSo0dB0QVEa9hltaaKch9TPfgj3bwdRs5OLXG3OuCcn3HmQFpDujp75gqMaiGo10+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/sdKZ57ZtBcJJ0A3Fl8905uKwy9FrSc2GBqp7U1XGo=;
 b=vGv4vlj2EIyHTDvcNoQEmEMWtvvtXmUD9qdDvknqC46og6bbCFKJeZoYsnLA/um/qtJxIdVYOJQaB2gAH+sUI2J/hiQzBt4SHtAI+eZCIj4UpI/nfgPy0U/G/wi2tp3LCwd2EDk9YoI5I2H20Onr35V95HfAndSNT4FDl5d31X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 14:10:59 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:10:59 +0000
Message-ID: <f2df65db-5f53-408b-8b10-b8431f8504d3@amd.com>
Date: Wed, 15 Nov 2023 15:10:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove description for 8T49N240
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <52aec21f121713160d5953b0a41a10cb196482b3.1699428990.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <52aec21f121713160d5953b0a41a10cb196482b3.1699428990.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 0052f5d1-a045-4f73-832c-08dbe5e4b141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: La/quZQxqwWixceFkjgslnvr54pLYZ6WuuYrqI5Lnhu+m+dtCZokBtc9oOSlAVxYG6GMPzdYaeFTSksqRwLBTjgb/OE3BWl+ysgUf7R2F1v1iM/7dnswkIbfpEACDp0+/2ritGB9ceBYGa03f0vigCcgIZm2V8qtBgR+fgEdteT7rSdv/ZAM+FgdYNGapoA2H9tKT+oSnImIFecDzsZsrC9DCDn5elH3m3isjN4C28uQRjBlTIz+RdY9CWeObzYMJ3jMrWmFeL2fS4lch7lKtbD3CshuMjKwpcjy7NrVO9CELV3FLX3fHSIBC97m8fFIDShe8vDEwL/7tanltfNO/YGwzUETRoqi1NXb0RUkXE4AZLycIumqQT9xclFU2J6ToMndnRx6WwSfKGvy85a7hpssV02qSPGDAaLhT3Izi1aEsVpxUa678IdnOj83hrC0zXZ7ASeeV5V8SDN1c0VtwXYNJDs/6nt2aUIanlG0OJltxYmfeQo79GV/dJ3YmbUFrM1sJxx96WG0dWA+A7X6JdNFBafwxWp8hgKZZjvNuF2A//3qt6aQsrM71UynV53WcojYrhxyu8d/Lgkr1AfU+CkKyBhA8y0lEl3BYl3Igo4ri9mLdqJAh6e3nwAP5l44n805555G2TjGpvZIHMzRrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(83380400001)(66946007)(8936002)(4326008)(8676002)(66476007)(66556008)(31686004)(36756003)(41300700001)(26005)(31696002)(6512007)(2616005)(6506007)(53546011)(6666004)(478600001)(6486002)(2906002)(44832011)(316002)(5660300002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdKRW4xd2Y0a2JkVmNyL1dqampLMm1iR1FVdzlxak81MFQ2Y3FnQlowdFh0?=
 =?utf-8?B?REs1NEVpWGJPdkJIM3ZNMGpIWEFVeVdHNDl2YzZ0THRJSm9CL1pXNW0weWhm?=
 =?utf-8?B?Z2p3V3UwSVV2OHA5eVU1L0k3a3RCcW05b1lJWXNWYkF6R3piZEZuekoyTDZi?=
 =?utf-8?B?R0xCTzVyMlNtbzZlWlBMUWFyU3czd08xYkYxUURTNnRQdXloUDdMZkl1WnBD?=
 =?utf-8?B?NjcyR1hlOVkzTVAwWTR0RytKL0p5U2dUM1lOcS9nVDBuMEVaN2kzdkdSbS92?=
 =?utf-8?B?MnhkS0hSYklFQWhXN1lQZlpaWFVkSUk0eGtxREFSV0J1Y0dZRkkyUzdKVWtw?=
 =?utf-8?B?NjVmM1AwWDk0WTdFNEg0R3NRaWk3SmdhK2hKTHFzcXhTWlFGZ2RwQWRqcnZI?=
 =?utf-8?B?VG05bC9zK3BTSDh6UTVvY0FLVGlOcUk4czlad3hMS2lQVk9wLzdhYk4rMFlr?=
 =?utf-8?B?bW1SVTQrSW4wN05vOVFnaTYvMlRSdDh2VWo3eVFEbGxFTDU1Z2pGZm5Pempm?=
 =?utf-8?B?SndQR3hLTm9lbFg2VGNmem5NRDZPTGFGejRyUXhYaUt0YmM0cVRQWXgwVTE5?=
 =?utf-8?B?dytCZzJLNFpmWjByVTNpci91VkxDTldHaCtLNDRMZTRnU3V2UmViaTJtK0s3?=
 =?utf-8?B?VWFjMmdYU0J6NkR4ck1PMnB2bER1Z01BNlFDdENEWVJiRlhTTzFHSXJObVNo?=
 =?utf-8?B?WHZ4R3JsaWhyMytDb0lsQVBRTzZFNlpzQzc1dWwvbUZUNTRHN1JIVU5yM3ZH?=
 =?utf-8?B?WkRaRmlmeGhiQ1dRei9sRWU0WVBFREhDVWl0cGJuRnJmQ0hxT1NRbUROTnJB?=
 =?utf-8?B?VytNTlNZNWNZVzAvcnljcEQ1Z1pzaXBwNnIzRjVzV3owSlVRSi9aVTVCczJM?=
 =?utf-8?B?NWRVN2dmbEkyRWRnVEV1a3pGZVBUeFlYTVhsaUNpRHB0c2pQemVjWk5PcUt0?=
 =?utf-8?B?TnpNRUxUZEVucHNpODY3Q3NWMG0vMGoreURzM3FZeDB3WndUSEVEd1FpSlZZ?=
 =?utf-8?B?cCt6MFUyYkFRYUd5UE9IWUFMZlVQTEJpUUpXQit5anYxU29STGZtK1BHNm9W?=
 =?utf-8?B?WnQrSkJyZkk4VDA0bFFQSWxxZDNEZVo0Q25LN0VvVjZLU3V5VUN6MVZTTG9a?=
 =?utf-8?B?bDJVcW4zS2xIS1p3OUhHQmQ1RUN3a3ppS2tQUE1mblNCZXE4TDQ5MzdWcExQ?=
 =?utf-8?B?czNuaGJjMjdKWHlzRmo5MDdmTGNEQXF5bDFhTFo1TmFKUFIrQ0MwMHJuTlNW?=
 =?utf-8?B?bUErTXhmdXlsZDVVSStJV1pxcHMya29PT1NvckRBNWFGajV1NDFVN1Jubk5a?=
 =?utf-8?B?aGlEbGw2VUJPdmVwckErNENwQW1GMXhhS0RBV2ZnSWd4RjZHdGRoQW4xV1B4?=
 =?utf-8?B?QnE2c0pJWXlNOU9jcGhGejVjUE5VMnVwTXl2RnBxcWl5NTVxYXk1K1o4bWZ4?=
 =?utf-8?B?cldDeDU2cVZvMFJ6dCs5bDlJZEZld0pRbkYzN0JReitndk1qUkpRTk5yWmpw?=
 =?utf-8?B?aENYbVd0eVlnTzFSSjM4dWZzK0lpdUNCWGUrWUpVaDFXMklTYWZ5Tm01d3Vm?=
 =?utf-8?B?QUJpWktHUDRZYWQxUzFuY3c2Uy9sakdVUVI1T3ZVY0N1NVN2RXlrNkxRNmwz?=
 =?utf-8?B?a3JQYUpyQ0VnclRIL2NJUFByYjFpazU5c0JJSjZhQWpyeTBsb0poTU96eURC?=
 =?utf-8?B?RG1Uc3ZON0ZJd1JaRzlmaW1tazNGcUorT0RwTFVIWjh6OURhL2YyQ1hLb21R?=
 =?utf-8?B?SXJkZ29JaUVkS0h6OTNhT0VTa1ZwcGlGOE5tRUR3NWJLekJrVUx2NzAxV0th?=
 =?utf-8?B?MU9OemYzaTc5VUx4L3ZUL0JmYlBJSnBJcGtIRU52eXhLVmNhajdSSVpZbURv?=
 =?utf-8?B?N1lzeldMUG5zdjVzZkh6YnRFOVNSRkVkdnBLMHp3RnhNR2ZlN3RWTEMrcSsz?=
 =?utf-8?B?R09MYzFkUndQMFdnY3EvYS9lZkdhUzdMaGs5bEN5OTMzd2NXRCtCREREZXZO?=
 =?utf-8?B?TUF3dDY3SXpnWStQak5ZbTUxaW56UzVVMWhtM3lvOVdIVnQ5YXpzaFdwOURt?=
 =?utf-8?B?NS8xUTdveENYQmdIYngvd3VibTlROWhiY1pxR1B0RElYNElMYTUwaFh6SUhW?=
 =?utf-8?Q?Sx2saTZNBtLhmu3J8KLJzVVdP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0052f5d1-a045-4f73-832c-08dbe5e4b141
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:10:59.5097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u82iUPWgFRnPW87ibxfupiOlB2sEnUwThvlNfqBYJhoMQWvCJeE6LtNC6QCdBE54
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



On 11/8/23 08:36, Michal Simek wrote:
> 8T49N240 driver was never upstreamed by IDT and there is no user of this
> driver that's why remove description for this chip with also remove this
> driver.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts |  8 +-------
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts | 10 +---------
>   2 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> index bf7569c6dda5..cc57c2a1b0be 100644
> --- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> @@ -311,13 +311,7 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <2>;
> -			clock_8t49n287: clock-generator@6c { /* u39 8T49N240 */
> -				#clock-cells = <1>; /* author David Cater <david.cater@idt.com>*/
> -				compatible = "idt,8t49n240", "idt,8t49n241"; /* FIXME no driver for 240 */
> -				reg = <0x6c>;
> -				/* Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt */
> -				/* FIXME there input via J241 Samtec CLK1 and CLK0 from U38 - selection PIN */
> -			};
> +			/* u39 8T49N240 */
>   		};
>   		i2c@3 { /* PMBUS2_INA226 */
>   			#address-cells = <1>;
> diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> index c456c375ac80..9acccad40e77 100644
> --- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> @@ -532,15 +532,7 @@
>   			/* u36 0xd8 or 0xde - pcie clk buf - 9ZML1241EKILF PCIe GEN 4 CLOCK BUFFER FIXME - no driver */
>   			/* u37 0xd0 DNP - pcie clocking 1 - 9FGV1006BQ505LTGI - PCIe GEN 4 CLOCK GENERATOR FIXME - no linux driver */
>   			/* u38 0xca - pcie clocking 2 - 9ZML1241EKILF PCIe GEN 4 CLOCK BUFFER FIXME - no driver */
> -			clock_8t49n287: clock-generator@60 { /* u39 8T49N240 - pcie clocking 3 */
> -				#clock-cells = <1>; /* author David Cater <david.cater@idt.com>*/
> -				compatible = "idt,8t49n240", "idt,8t49n241"; /* FIXME no driver for 240 */
> -				reg = <0x60>;
> -				/* Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt */
> -				/* FIXME there input via J241 Samtec CLK1 and CLK0 from U38 - selection PIN */
> -
> -			};
> -
> +			/* u39 8T49N240 - pcie clocking 3 */
>   		};
>   	};
>   };

Applied.
M
