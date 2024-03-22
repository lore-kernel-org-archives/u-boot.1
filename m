Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6DCC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867FA881EA;
	Fri, 22 Mar 2024 12:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qN48lh7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA87881EA; Fri, 22 Mar 2024 12:57:27 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1144F881E9
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZV2vwCKCkrplfYG60UE0ZVxlYjD7YsO5B7A1a3YvKiYMCbU8j92CKmQIljl2XQl17wNMI+BLdrjdtfTGx098uQGWMr3BGNWpZgI4eEdgs99T1UFtyXFk6fCM3UzfE1jTqzFgWGPW9YOMs52jRD3/1bKezdqMirreALrHpKYtgFBbTuSpRxf6Aquc3tEooGPsWLFY4gaVnp0T3iJMdH4UbvrTNDqYZkJTNRNzUybD+YLdbT1gvkYDZkRhHC8qEx5WYBI0pN+GphKLYNknGQOrCD5pWNIo0eQYxYrZ+jOmrfaB2/palpavZ2Ph0poU/dqnt5KPHTSmjIYYUk5kPnxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENnMeXxMxZ0zrXGOAnSx1vzy/HrsgsPjGxRIvZlOgNI=;
 b=DDebprqwEJnb7g8z5lRmMqsrLE4Xyzs0zg8GcZx8aY0IhLldiM1V8FNH7Ds7gc9+J8J96E3OCFW5Jdvs0EUK9fUDznmJ3h14nekd5Pb9Ln7d+1Zy8m5colMjsgr2XgH46VjqfAlyqbtpKySul1A0DF9fmo/yB5oqE9D8EmnQYy9/4PqSVshZ1mTRtprEDKLiTNIkYTEhbLM9NCSn+PWncXorLy5VbPoPQ9ijF/XViBC+EF9HUDnwr1naJ908NFNe8HWoMRMyWMkawwF7KTgbPpc1zfTIN2xXkYmMzB2XxygArhhV26rDaURGhcoWbl6y6z/6Lve+7KIlc8cd7JRqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENnMeXxMxZ0zrXGOAnSx1vzy/HrsgsPjGxRIvZlOgNI=;
 b=qN48lh7NLTzjDXFKnWLp5s9rEMX8RYTZFOcgvovm3/5xXATI5+Uk+piI3N+5fiUKKZoKGVBLuzhwDcwttcrz0c7ri04KzZm0dH2rRJIj3sl9gbkdHERXD0oZ2AvZrSBjW2nK9eaTavFrXOX7qfgMEZL5gHHqW54Zp/COXJiAjdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:57:21 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f%7]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 11:57:21 +0000
Message-ID: <b1a43941-c9e7-491a-970b-dc730156fb98@amd.com>
Date: Fri, 22 Mar 2024 12:57:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, ilias.apalodimas@linaro.org
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:802:14::46) To PH7PR12MB8108.namprd12.prod.outlook.com
 (2603:10b6:510:2bc::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 50951a89-d17f-40d9-a316-08dc4a673ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNj8iGcHcIFpqP59W1oWO1fCPXn0tEqLZ+nYU/+ROG2dvni0wmqD+xctmcxmBiFAyf0Enav0L+EpOrWiDEe3bpzrAK65FawJ312SmWULCYhMuboZODUPwz6MqbL/fb5moeTlZLNDooomneP/XK/QrB85p38cDGJVMEbBjoA2RQEpDyEkb9qbqD6JwJ/gfCH1lb1vM7X3Up7eztwUYWIogdNA76P6ABnvWOVcwKrbrMDnWj4RUuxhWNZIEnCR1s+Emcm6fHzMAtgcHCEB5Xv7vcavC3Z69gxiIQB3JplXQPb4s9iGdkhlvf+hfRBIRt/JGa+79/14ExDKfyzyl7bdk5NoOULJWFWjCmny/6MT8zHaVb77ZdSWWvCqCvbpjc7q+npddjPkVhdMRh5mh/wz2iuUF5482uaNmAZN0AX81zZrykJSiMtUCAisxJhDssV9jUxOQgt/uHHavnZBW6gbcnKwOGNp80FpRvUKmuX5jlRS0bioc17adx9xZqpQDmWMeck2eXqqbtPDXMGgvs0JoawTYogXG1P8elVq1Ep3EJu2ns8ah5jO75pxwsyntGMVSIQgEgxofKvIRZyzuH0+CrSeQta5A28wRKAnABfhsps6l8GNqroEoEEdHtH7GeGClvzHUQyEzQhle6GLBm8q56TUygiTYDv1n1KNsqNGrHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUF5VVRCOXRRQlpIcDlmZ29RWjNvcnRlYi9sSmdsbzU1U1NOMFhMcHdBSnRu?=
 =?utf-8?B?Y2ZHMVVxVW5obUlZSTdCWHFRbGNSVTJUWUdSSktkRm1yaFdnVU16VDIyV2lQ?=
 =?utf-8?B?Uk9mbHB5bVExQWJNZ0RvVnBxblVEOXRmeGZsRDVFRFlmRzlXZmlRL0NvdlUy?=
 =?utf-8?B?SWd3YlpGYS9EZ2R4MDBLQXdjbGdVZVMzOE1IV0gvV2MyQklocDZJWkdwR1dQ?=
 =?utf-8?B?bCswWE1rMUd6MmdDNGVkUXZ4bDZvS0RQMm9NSUk0VGZpN2h6anIyMXdTWGZE?=
 =?utf-8?B?WmVxU1ZtY3hmSlhINnN2UzAybjJ6RDR2aUVLbFJnd3c3OVkrcVdrdnJKZmor?=
 =?utf-8?B?NDlVVU5LaWlrV1VtQU5MMm5DaXVlSGJyVjRjT2EyditqNU9uWVBpa3ZENDNP?=
 =?utf-8?B?RzE0N0NKR0ZlSy9WSHpZVjhCQ2lTZyszT091WFZrdjN3blFtQWhWWjUvZGVu?=
 =?utf-8?B?bm5FWXAyV3c4TTlkSHhxL1JXS3VkU0ZlMFNITGovN29JYW9MZ2pMSU52UFoy?=
 =?utf-8?B?UHJuWnVTbVQ2MEdQa0hIcXNUN01jY0NHaUdVbTV1UnBoVllZL3VPWmFxdzFk?=
 =?utf-8?B?eDVNUGgwTlpoNXd4bDhaRjZ3TmJQRXAyTXpMRFRWZHpkZWkwZDkyZDg0ZVI2?=
 =?utf-8?B?K2tRUG5JV0hYenJnOWdZeEpiR1VIL05Qcnd6RTJyVVMwRFJNYUE1SHhpTEpV?=
 =?utf-8?B?a1d0dzBCSEJnSGt1d2xhUHJjOWJ0anU4Tm5sYXFyTTJIZWJGUEFiRkVJTGlT?=
 =?utf-8?B?TGtFQUc4UHVIc2hlRnEybmpqb1pBRG5RY09UNlFoR0VoRlVOREtDd2V0UDBG?=
 =?utf-8?B?ZXBIWGo2YnZudm9hYXJFZ3lYNUIvSDBqcWIvRDFGdlhtV01PMHVGSFFzUlB6?=
 =?utf-8?B?bXZSWmFYaEtxdGxGb0JLVTZEajB2NjZoZncrOXlVQUJEbk0xMTJnOGxUU2Iv?=
 =?utf-8?B?SkdVNERpQURLRE5VRldRT3lxcmkzK2xVNWdmYUJkVnBWTUgzeDdmOUV2enJD?=
 =?utf-8?B?dEpUYVhBVzNTd25oUEg2OU1hV2hQdU9LZDF0YzVZcEkzeGpITUlrK2Z5R3Zm?=
 =?utf-8?B?ZHE1MEs5RlN6NEg0MFQrYTdpN1lTS2doZGljSWlwN0pOUUYzT081cnRkakJN?=
 =?utf-8?B?QlNHa2l4RmxJeVR2Y3FoK1JXaHNueHgyWDM3SUFuNm9jTnVkU3NiMjYvaE1G?=
 =?utf-8?B?N1k1cGVoeFdCNGNXOUFkalg2dHoxQjRnNWlXK0tSNzM0OURUeWFZSkJNUWg1?=
 =?utf-8?B?VTVtV0RqRjJ0N2ZDWWVGZGNKQnhjWVNENlNLWmFJcmhrc0lTcGhkcXpPUGp4?=
 =?utf-8?B?RlgyYk9mREZOYU01ejVYL2xsSkRFNjdIT0xNdFJLM0dHZHhvZ2UvY2lXSFF1?=
 =?utf-8?B?VWFBRmZUMGJxSmkyd205WmdyOEVmbWNoSDBXY2I2QlVBcWhQOHlPeGwyanZT?=
 =?utf-8?B?NGEyTFZKTGxqdm9mVU9mektNZ1B2WFpyaFVCTlk1a0xuSWlIUFZUd3lJSExL?=
 =?utf-8?B?VWlCVW93c0tZUXFwL1Rxb3luVko2SXliMkdQNVVmMTAxTkFIMHRVWGFFYmYx?=
 =?utf-8?B?TGNrcS9kbHdzNnE5SElkanUwZ2NpYjRSRHYrL0sxTmVhZHRmTTgza01MNEcx?=
 =?utf-8?B?Rmhsb3FuRWNSREVzUTd3ZFlXQUxzQXlxM3dHQnFYZnRBM0dYVzh4ZG5lS3RQ?=
 =?utf-8?B?NDVobDB2RGE5VHBFejduRnVqU3J2VDhNV3V4bXAzQWhOMHNZV0lqUjdFa0RV?=
 =?utf-8?B?RXhkazRXTzdMbWFzY24xS0NLVUpSdU9rMjNDWEliZjdNdTlTWGxuY0dGb0cw?=
 =?utf-8?B?dkxEM0hqemdaaGhlRzU1TkVmd1VsTkVyNzFmSThLTzdwbVFwM3ZxQy84T3JY?=
 =?utf-8?B?M3VZYjR2ckdabXhKemhObFBONjhVVmxzQ2NBWnBtREpCS1pKWmRjZ3FvV3Q0?=
 =?utf-8?B?Q1paNWFUYXIyTFYrRlJHcDl5QnNzWlEvT2RWcEE5NElSWXBLVEEyQmpaN2xs?=
 =?utf-8?B?SmVhdktwZVpIN3ZlL0UyUXF4WTN3TnE5MUxLdFlEMzlFS2UzUjk3OTZJT2NW?=
 =?utf-8?B?QjFvclBkcHIvQnZvTkFkY2l3ZFM3Q1pSUFlhMkZhWlRGUFJ0UFVhczFyay9J?=
 =?utf-8?Q?MpjxxgBAqH5hU/SXArAnIxQmp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50951a89-d17f-40d9-a316-08dc4a673ab8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:57:21.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iHXhx/1qn5oCUMbKr7CUEsTcyRFQFYnHI1fHFp0ZB52TiJoisoirNsWlMpSp0i9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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



On 2/23/24 17:18, Michal Simek wrote:
> There is no reason to describe u-boot.itb on system without SPL. Pretty
> much this is cover all systems which are using only boot.bin which contains
> all images inside.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/common/board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 9641ed307b75..4f38b7d27684 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>   		.image_index = 1,
>   	},
>   #endif
> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
>   	{
>   		.image_type_id = XILINX_UBOOT_IMAGE_GUID,
>   		.fw_name = u"XILINX-UBOOT",

Applied.
M
