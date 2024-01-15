Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18C6C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4EB86E88;
	Mon, 15 Jan 2024 10:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KYnM+Dyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4CF86308; Mon, 15 Jan 2024 10:29:08 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35AF784694
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii4rGavVoq5vZlR0mSGFhRccp2Os2nekSbErIrd8jIUOvG97h6yPaP+SiaXR4cUUQnqnsOli2TAXo3D2TrSiskR8h5u0EIfNnVwmXiyko2D01nkWWv1wHcJqns0r0oac/q3yc8Z1qNmQf80SGB54gXG0OiSsjPOu1xmFYLHygqAmOr2pPDZzL0OG5v0ANALz6r40s/VzDx55BXjC7eaW7ilOew2wcb5vXuE3MfdvnR5LSe173+b4nl/59kuw2MePhAZRxB5S7LOQELG0wZP7DDHGWLDzxLINuu291Dho4bTJ3fFFpOcHkTe6XSgWUXcbPXMPlyQ42oqy06G7NKafFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBnvNRyD99rcaiJfLXE1AiNMIVCbTRCRsHAjZLlrVWs=;
 b=D43KSmPeSzI8zcJLY43pkmoeW0e54KFx38PpiaUYLqdLi4PcRD3i7sOKIOCY8zpzQuQlagmH+XPvb2BDVao85DQZF9L+P15r6TlaIMJru5omvYvw5D4w0G2D2mCNG8xFsULLmveKdZWHsXS2RkEeL6ivm6/kmmzS7A3eQeSH8LI9fP2MWtejut6oN26hjbN3kdRIbUGfFTchv3HgYHpSizEmE2Xdkh91GbeVwr0RyJE6vYkW0DAp6KV1pu0gucl+ecME6cKXuPitlZf/yi0YKJSUfSDJW4UI2quiUk+CozzRcPL7KjLJhyJM1tdxwFGiy1p6zhp5TPrVI0jR0hImEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBnvNRyD99rcaiJfLXE1AiNMIVCbTRCRsHAjZLlrVWs=;
 b=KYnM+Dyj3ljV5fH43PKF8nMwH4Fd+4/9fcw+XJvp2Im91gm9Vec5QK1ezPwYyZnDkcSu8D3VDQAFonnbhIuMzyw5hfz3sy+HH7CvtPsY3IhWYMN/iPTfS+dyVDjPygk5mWdVeWttvHW4xafcsTVSH0UenqZc4bOylAIh8fxqKYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:29:00 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:29:00 +0000
Message-ID: <4648f4a9-c327-417f-bf4f-5dd09d61bf48@amd.com>
Date: Mon, 15 Jan 2024 10:28:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add support for new power-management node
 name
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <967aa76f9f72604c874b580476aa85f5260ccd65.1704448544.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <967aa76f9f72604c874b580476aa85f5260ccd65.1704448544.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 244f3d69-439b-429c-4cf8-08dc15ac680d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwxXX/E4dBQXlUCHrqPmufcnRzBAPVTy+3auIcNdlb9sXTvxnKLBIasIlZkPtqgR2qUVtNLIDA2JPPpd+qp3nDsC1RRU8jscPr1oQoZnPppVP7fFXu875x4mTOpxjuRiCMQRxlrQKSKr4BaI0Fkj2th6niX4ndO/uORXuQirFys0ChzXpcA0ocXH876WmcxS9UjjN8+Pi5+h8yTbOHmBG2Z4z26Ittp3d3H5cCLnTqiCuYdBZOvut/cGYdw6E+PjX0bIJof0rWuKr581AVb8Tt++VcFTBPV6eeqxww01LgCEfgB4ueIkvUCzVM2atpyerYCMAt2u4OioAFHVmkffcyNCFs+meLHZoSs3tRSgfCpPppg2dNMCPCLxtM5UA4Epi0g12zAlvG0dJHKqOfhajPO6O9k5n4gg0xMsjs+a586+HHPP1R94xc3j+H+LEnYy4YYPNa8qCphWbOliSZhNS+z/g7FoV4BSbQtfSfBFWQl+a6wtH+FkgLw6eBC4X0ELeT8QCrbZ9StdJ5NJ3YzqZbX2FoXtrAxEgzvLSayWL8JRhKpJQB7NSbfWJQf3K0fDwUKYGtPc4d4lQ1F53IRLXEYkGy1nuIRtMbXSMU1RJ+GiFXRHmdxDeuCeUl/uo7pQiQJzaBfUnbZSpAew5fPXqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(66476007)(54906003)(66946007)(66556008)(6486002)(966005)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXVPSUxud3FDQ2hpWVduS2kxRkxUSG9YSlhRRk41MXdrdWhFZnlTMTdYMHgx?=
 =?utf-8?B?aU9YeW1CSjVBSUwzMjV3cTlrL0RqOGxTcFZ2NG9JZERSbndqOHM0WE9wZSt2?=
 =?utf-8?B?WkhzdFFNVTdxUXowUTFjK1NLUFZ5MGRnaEZuVGxIbDNWTmVjT2I0WEtWUDhJ?=
 =?utf-8?B?dU1TNFZpV0NYTHQvM0YrSkF5NU5ZMzlpT3pldzFBTHM0c3N0WEVxRWRsdkR1?=
 =?utf-8?B?VDd6R2o4RzA0TkVYenRaSC9sK2Y2NDNENHlrRVFkZTVKS0Vpc3IwRDI0UWs1?=
 =?utf-8?B?MnViNTdvUnZFTHlLdEFYR3AzZXJobk9yYmlpUk1lRFRjWTJSTnpEOXUzZVNi?=
 =?utf-8?B?Nk1lV3g2Unl3d2RUZTRnRThTRWhqeUJpck1ZeGJRZXI5RjRCbzdkRzFjbC9h?=
 =?utf-8?B?K09TTE5kTzhSbnVoMDUwT1BFL3FhdG5oMGFBMHRHMWxIVTl3Ump0dWMxOTZO?=
 =?utf-8?B?SlBpWWVzbXg4aFVubXlmemxidXY0Q0swVFdIVDBiZDdCalMxY0l0bmxmZW9k?=
 =?utf-8?B?OCtsRko4Z2hkWlRJUEtQSGdJa2g5NVU0T0ZsVmlYeWdUclJESEQ5MytjS0JP?=
 =?utf-8?B?RUYwcXRsMFZhTDlHdHp0K2FoeXpseFIzeVRKWTZrMlovYjJQemVLVmFFai9x?=
 =?utf-8?B?VXpkRFVVK0hXSXg2QXdhWWcxcm5GSWpwUjhobFhkMmcrNW0wNlgxK1NuNTBq?=
 =?utf-8?B?Z0dvWmtVNjJxU2t3MGt6OHdRcjFNUTB0ZFBzU2FiVjluMVhucE11MlQyVUNm?=
 =?utf-8?B?Z3Nic29RSzQ2eUhMLzBPdHhpa01Ed2xYclM5SUZpcDZ2ejloR3JDNDcvcSsr?=
 =?utf-8?B?RnJ5VmtyZ2ZnZmJiZ3FkSSt1eHZTT2VRQzl5TitwZ2JORE1vdE1KSXZlMlBx?=
 =?utf-8?B?RnFwTGhsZmFwOEVlR0FKZXo0eU5VQyt1ekIrdEpHWWNqR0pNZ3p6Z1pnUVVk?=
 =?utf-8?B?a2Z2cUI4V3VGWnNBY1QrUEY0SXA2MVZ0R2dDOTdPL1RhQnpMN2cyVjJUcVE2?=
 =?utf-8?B?TGpualV5ZG93TXhDTmJsM3lGTDIrcVFGQmVsNlBtWWxzYzR1dzVhSmZTWjJT?=
 =?utf-8?B?NUJWMDNUcU9rNS9mb0tILzhPUHRscG9pWHBWSERNVDdFTGtVUVBCODhaSUVM?=
 =?utf-8?B?RlJua2ZzVndITml1MzNJV3EvUlBGMHB1M1NGY1AySnA5QVlNd2ZtUUR1NzRo?=
 =?utf-8?B?RmtkbFUwcmZZUlRRdVcwS1llRkZ1ay9GVGFoTndRYXY1SGtQU2pVNmIxN0w0?=
 =?utf-8?B?VUQwb1ZudGFGTmJZTmV6KzNjZEdYRFp1VFQ5SVA5cy8ya3MxV0dsb25pdGsw?=
 =?utf-8?B?ZDEweWtCdTRYelUvdDBWS1JqTWZuMXhOS3RJMEozdGtPN001UnZhaXdyaW82?=
 =?utf-8?B?RTV2dlB2L2hmL3dzb3NXL2ZacndXaGgvZGR6QzdCSjMwRlJPSy91bG10eStK?=
 =?utf-8?B?YUNVMUtSMlNYbGRWMEU3WHExbmh4SnA5T2ZsK2lFT0l0aVR3QkJvUWc2YTUy?=
 =?utf-8?B?ZlhiMEdTL2NSckM4MFFEWGR0VXFzV0ord25KLzNxRkFCbk52azJlK3JJNm9O?=
 =?utf-8?B?UG1pTVcvRjF0VGVnblI3b2hNaTZ6MFRuQm5oWkF1ZmtHMUhkeWc0TEp4ampG?=
 =?utf-8?B?SGNSSTAwaC9CWDY0eVpyTFYwTmFqZVB1QUh3SUtVRWdwZmIrdXNiMk9kbHk4?=
 =?utf-8?B?NVRLeHI5VnRnbDBBbStXL2Z5ZFAwakRqTG5QK1Zrc3IvY2E5WlpLMnJpdlFM?=
 =?utf-8?B?cVBJNjNuaFEybnI3OHR6V0dJU05ZZFFSbEIxTFY3aXhLZFFTU0I4Ry95MG1K?=
 =?utf-8?B?MiswVHJNRVVndkJscUYrNHJGNG9peTlOUXE2aDIrdkNYWi94aXVMN2pqYzVs?=
 =?utf-8?B?OGJFYUZsQjBGTGFnUUNzakVQQXhWWGNXNEV6NUtDaHdrMWNvb0pMMXN2eHF5?=
 =?utf-8?B?OGtmaVRlcUVhci9tNk5pMmdHdlBQWEJWT0FTem5vN21UakUrcFkrSXJIU0pa?=
 =?utf-8?B?bHBpY1V3elp5Y1dQUEp0dkl5OHZtRURXMFNaZGlhZllKVnlOWHVENHNjN2pU?=
 =?utf-8?B?MHdKQXFOTG5vZWhMbUFKdTFscjVQYW5VanYrdmgvTE83aWNEb290VEUxengx?=
 =?utf-8?Q?e/r3VsIoRmNq2udiMs/C4YjOB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244f3d69-439b-429c-4cf8-08dc15ac680d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:29:00.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je1MZzBUCq6UVyQjsr3C2ttUNUXssfvvPkI0IL5q/r5As4Mk+vzf1t1T3LE7PPb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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



On 1/5/24 10:55, Michal Simek wrote:
> zynqmp-power node is going to be renamed to power-management which should
> be generic enough. New name came from dt-binding review that's why there is
> no way around. Add support new name but also at the same time check old
> name just in case older dt binding is used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> DT patch is available here:
> https://lore.kernel.org/all/a2f7fe30e3630c262c2773a595b7a0c8918573a0.1704359569.git.michal.simek@amd.com/
> ---
>   board/xilinx/zynqmp/zynqmp.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index e3700f076bc1..9f5009072025 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -156,9 +156,12 @@ int board_init(void)
>   #if defined(CONFIG_ZYNQMP_FIRMWARE)
>   	struct udevice *dev;
>   
> -	uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
> -	if (!dev)
> -		panic("PMU Firmware device not found - Enable it");
> +	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
> +	if (!dev) {
> +		uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
> +		if (!dev)
> +			panic("PMU Firmware device not found - Enable it");
> +	}
>   #endif
>   
>   #if defined(CONFIG_SPL_BUILD)


Applied.
M
