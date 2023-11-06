Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C326C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A598087017;
	Mon,  6 Nov 2023 13:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akfQ2M4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234B786FE9; Mon,  6 Nov 2023 13:43:52 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9194B86CF2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql2QMxczWbuYBvpROxY+TDIZMUfxzFf+bc2he7/+Q7emRzdpKCiWJOQRwf4wtRAlLcP0AphF4cWFqd4997Io3AVkZ0Xdo4cOKHbWhlF+cMAePp04svyZkMbWXg2AxsUZN8dzdp79rO1+ui2KrlHnAZQ6UbAHoeejDIpuzOF+J7dgTEgGrdnTjHIuenw5cJOUQ2q2CKt4WmphSMmZ9O2E58FbyL8UGHT+Gz8rjLL/FTxdqOZFV2dWcz5gNq/sPPPlERgfoTJy1H+oMbxzGEFDiargEamvcESYCuIIvsEpCsiARJSQftA7QBA3fVXZAWRxjzSkjNY92/jBzytTE52n0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YHex0QW7enh3KFwuXKikozqI6KW+P67hcYrNlpU6IQ=;
 b=K0LAIMlcYgNGRwOj5FaUKnA2LMi+YvjCmUleHEuXAojBFM1bTKjBVjccFbweMQ5YUI3rovU0VIBPEl8/AcoyonmIsdYDL2xVZj793xLD8OL56RyUM6/cbVu/ET8qxKrqa+jONdsUqKlROlxoF3f99r4VI5od5UJD3ZTbvOoXVc8UiTUZIsh/eNncosXQOzZUgAc/5hnIvsGBm4l+rx7FHDXd7A4J6JUlXTI5XnoEnvZQ9407wkETILVCb8gmZFpiQwC2Ex2UtuQx1cs/d++nRvtaQN/YUKHEnkgDxaSAOh5pU/xd7v11lSPmY+rdXax8WDnG5ylqE1xF2zFeyF2K3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YHex0QW7enh3KFwuXKikozqI6KW+P67hcYrNlpU6IQ=;
 b=akfQ2M4p74uHdxcV4jF0NHuxSHMt7p8If7k4CLAjjr90UrupXPXhFIaTXOQZdiyGnXyhO09/tYg3C8iGna+41lZ7I0IpaTbqAwBhQ92eDHLLVyjDZxnLEDNFK3HZ4ySJPTBoDO+X5GjLX6uBudvd5C7xk3NBZZfvsfmFtoLpu70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 12:43:44 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:43:44 +0000
Message-ID: <c5272690-d55b-48ec-b63b-dee8edd761e5@amd.com>
Date: Mon, 6 Nov 2023 13:43:35 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] arm64: zynqmp: Disable Tri-state for MIO38 Pin
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, git@xilinx.com
References: <20231020050622.972750-1-tejas.arvind.bhumkar@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231020050622.972750-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: a7490d85-34d2-47cd-93eb-08dbdec60372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pK3Qk+1xsowDlNn76IoLH048hnk3KWaQF54Sw2dM2GGbJ6OlAZLhljwunsdvBMR6Jf6s392CVJg2w2s3Ulb/5rjgug2GPqpuTfp0un9e7BfpXGKg52hWzXz6k6lwQvazxRj+JhEt2yxsM8rgxlX5QIuTJVU6a7IXEcWKTZ2Q21+LvTlfdmS3Crywo7LI590mwnKMniRNhoMnoJ5s1b31zmKe6RkSJEvzGFUafznP5Tdc5OAiI+OMPrPk59ZQXY+ip0Inb/N18jogbgUWS9bIruUeZj5e/nHVhplQMhVjUB09zUMmxP3ToYCC79gAanldux9wWOVYcqv4IPeKpoHD34Jh+ztu2oSAuMJzoug55ajmnlIfr+2FICLHv134QNxOjspkYhwLm8hgwCVIMBS5w9l89osAXgRAnog6t9jtcvdbFkNo+wQqIDJp8n4C0pgU2y2sdqia46lkdGxylloPSC5P53YN0J4kZ2UsRQ/qvvKp/xURDAD87PzpbmlpRE7KN6lHPUnHiIq49fS/UmLI2vqM0OBqyzx311NDr8hv0HcoEn2BcUVN1/p2YIaF41RJvGXLembEtiF1koltW1ADU65u75ERCogRXISQC2HXGEWMWuGAAd45505dave/CDgSUNDIZbQbQ9vdlYPdnBRGZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(53546011)(6506007)(6666004)(83380400001)(6512007)(44832011)(4326008)(8676002)(6486002)(2906002)(26005)(478600001)(41300700001)(5660300002)(8936002)(66946007)(66556008)(66476007)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFQ4bUpteEtzZTFGT0tReVZvN0N5SkFROGw5RUd0d1R4aDJwT0JUWU1tcmJE?=
 =?utf-8?B?ck0wREdyUXNwS0hpdnpHbGwxZGREcUlyTnFXTFZxN2IvaXpERkMwV2pNTWJl?=
 =?utf-8?B?VHpqZ0toNzRCaEJoK0RKa1VKN3BTa1dJc1NzN00yUllXT1V2dklWZW1DU2lL?=
 =?utf-8?B?T3lNem1sQnpzZTZQTkM3ZDBKaEk1Tm9WaFYrOUV6SHNoRWpGL3pKcjdVRXVW?=
 =?utf-8?B?bGpQUmlYaGg1bEZuWmpsQWlXUkxoVng3VWlNeVVqZG9BZVhNZ2ZuYmw0ekhl?=
 =?utf-8?B?K1d3RTdEVHZyblFjYjlqTjcwZ0xNOWRsS001eHpmKzU3eW9xbkwyRzN5MTdp?=
 =?utf-8?B?ZjViZSt1MExhUHIwUC9HSjBHNjhEc0NFMVBlQnRndVhveW01ZkxVaW5SWHVK?=
 =?utf-8?B?OXVqWmlOR1B0RC9sK3lBeEowYkluVjBhN3Z5MHJHOFhpYVhtMlp6SW9ObjlK?=
 =?utf-8?B?Q281VEN5eWtZTjF2NFN2VFVLWTR5VGswSnBhVWJFVWxBZk4zeVdWdWUwMVNV?=
 =?utf-8?B?c0RIQWxuNXl4TTBRL21NNmtCMFdNNTRRbExPYnkxeDJ3RSsyNk1OVWNPQzBj?=
 =?utf-8?B?dGlrcW55ZFpKbVBleDFZVUJjeGlwdDkxKzlVd3JoMkhLT2FrNklJcGFKbWVn?=
 =?utf-8?B?dXhzVGgrUSt2Y3Z3NVc4blZWYTNncndaTFkwbUhFTndSU1JaM0wxTGFRLzVv?=
 =?utf-8?B?eXRLaHZsMVZaVTFrWm1DbGtoZzBHOG5zZ1lPdmhVOW1jL0VJSUpmYVBJcXF2?=
 =?utf-8?B?T1JtdkFLQkx4MHFvSUVENHMzbGZrZFMrUkNidXBCVXNUNmpOcURTWVpBTSta?=
 =?utf-8?B?dUVBcGVjTFBMWjJaS2lYMFovcXBhNS9wMERzQkFDMVZhMGlCZ3BSc0pmYUNx?=
 =?utf-8?B?U3NwTzYxWDlrS3hoUmNhOEprcCt2WUh1WGV6SmRrRllxeXRGK2hDOHR2Zk1F?=
 =?utf-8?B?aTFvcm5ZamRtQ0xld2hRSXpPcWMyNGZkd0RYekJKeEVoU2g4OG12ZENKYTR6?=
 =?utf-8?B?dXlHVkw5b0lDbjBuVmVwYWhJaUl2UFpUbzZhMGVVWFEzcFUvQWdUdzhnMVZS?=
 =?utf-8?B?SmlxZXpoZ0dISVlNK2ZBeWZTSVM3UDNRM29LQ09vR0lKdTZyR1RNemNtZGdo?=
 =?utf-8?B?VmNKQjIzaWlnWWluY1dJdXh2cGIyVytRTVFsYWhUYnVQMkNGS3I4aFNud0Vy?=
 =?utf-8?B?ZHJqWGtlKzRwdk9UK3h3QS93SXN2RkZJMGx4cjhQa0Nic2JuNmxDK1l2VnJp?=
 =?utf-8?B?VlBDS3VVMEtoREdqcGlvanNUemdVd0M4dVNLdlhzZDVGMmw0cXJnM2Q4NkM0?=
 =?utf-8?B?c0NNMXpMZzluOW9VaWNIRHo2YTZUck53Ly9wYW54QWlFMFAxRUtUVVU4N2c5?=
 =?utf-8?B?Y1EwclRqVTRuaFBwUmJlOERvOExDd2ROYlhhYlgxbjU2a0dESGJBZWFxcmxl?=
 =?utf-8?B?S3NwS2EvTnJONEtxemtRM1dJTithaTV4V3dFTFZPZVVrdnRvUDh6SG5tYW5Z?=
 =?utf-8?B?QzdyY2plQ1NzSHFxTFQ1QUFSd0hhOGkwQkp3d1Z4eUFwZVpSc2pjbHE2YVYz?=
 =?utf-8?B?N3VnQ2V0cFc3cnpsNXVyVlNPL3BNR2tRRlR3Ylo3b2JYOGNCREVLSUlRVFpo?=
 =?utf-8?B?aGM2MWtGSms2RjlDMUR3SUJBQlZjNytsZjdpeHd2eGRLbXJQdEkrdUJtL1Yw?=
 =?utf-8?B?cGVhWUxibDRKOHl2V0Z0S3k4QnIybUVSaDFJT01xWkx5czZDM013aFhTd2tF?=
 =?utf-8?B?eVRpS0ppN1JDSlFPMHEva01YeXVtVWorWXlKUnYwSS9XdjExc09PVm5GeGRQ?=
 =?utf-8?B?cjVqeGNieEdJQXFLV1dETTJva2dENncvVGJraXh5cGx1aTB5WEVLTGkwQkVT?=
 =?utf-8?B?VGRkdnM2SlY1MDQ0L1Jsd3BVR21FNzA4SDVvQjRqRGJ0ZHNFMzhtNGVmTG1v?=
 =?utf-8?B?TG56UGVSRHV1MEt4TDNwMUQ5V1NRanRraXFLK1dZczFEVmY1YXZSamdWQlBN?=
 =?utf-8?B?TmNLNDRsRnRqQzMxMDl5NFFjYVFKc0JPTitFQjFPVVhZTE5zMXYybkEwdEhU?=
 =?utf-8?B?WEpnSzJQUlpwa0R3dnBndm9wZTRvQUdTTlE2QU9qckMxQzg3MXVJQit1aXM1?=
 =?utf-8?Q?ENfdVU5j0XLksKmVWzWzAmvm6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7490d85-34d2-47cd-93eb-08dbdec60372
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:43:44.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsEwZ9b8rPmIh29sYuR7FNgcjpdESqji60NI2bNJKfG66RYAD8e4G+hSnNcq7eXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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



On 10/20/23 07:06, Tejas Bhumkar wrote:
> gpio38 is used in SOM's kv260 to reset the Ethernet PHY.
> At present, HW reset is not working properly as Tri-state
> is enabled for MIO38, causing inappropriate PHY register reads.
> 
> Disabled Tri-state for MIO38 to make HW reset work.
> 
> Tri-state disable :
> ZynqMP> md 0xFF180208 2
> ff180208: 00bfe7a3 00000540
> 
> Tri-state enable :
> ZynqMP> md 0xFF180208 2
> ff180208: 00bfe7e3 00000540
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 25 +++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 22e7d68d02..c4f1da9218 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -190,6 +190,25 @@
>   &pinctrl0 {
>   	status = "okay";
>   
> +	pinctrl_gpio0_default: gpio0-default {
> +                conf {
> +                        groups = "gpio0_38_grp";
> +                        bias-pull-up;
> +                        power-source = <IO_STANDARD_LVCMOS18>;
> +                };
> +
> +                mux {
> +                        groups = "gpio0_38_grp";
> +                        function = "gpio0";
> +                };
> +
> +                conf-tx {
> +                        pins = "MIO38";
> +                        bias-disable;
> +                        output-enable;
> +                };
> +        };
> +
>   	pinctrl_uart1_default: uart1-default {
>   		conf {
>   			groups = "uart1_9_grp";
> @@ -345,6 +364,12 @@
>   	};
>   };
>   
> +&gpio {
> +        status = "okay";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pinctrl_gpio0_default>;
> +};
> +
>   &uart1 {
>   	status = "okay";
>   	pinctrl-names = "default";
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index eadc256306..6c5e0e5660 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -178,6 +178,25 @@
>   &pinctrl0 {
>   	status = "okay";
>   
> +	pinctrl_gpio0_default: gpio0-default {
> +		conf {
> +			groups = "gpio0_38_grp";
> +			bias-pull-up;
> +			power-source = <IO_STANDARD_LVCMOS18>;
> +		};
> +
> +		mux {
> +			groups = "gpio0_38_grp";
> +			function = "gpio0";
> +		};
> +
> +		conf-tx {
> +			pins = "MIO38";
> +			bias-disable;
> +			output-enable;
> +		};
> +	};
> +
>   	pinctrl_uart1_default: uart1-default {
>   		conf {
>   			groups = "uart1_9_grp";
> @@ -333,6 +352,12 @@
>   	};
>   };
>   
> +&gpio {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio0_default>;
> +};
> +
>   &uart1 {
>   	status = "okay";
>   	pinctrl-names = "default";

Applied.
M

