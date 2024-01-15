Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E86C47258
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8842984694;
	Mon, 15 Jan 2024 10:32:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pr6rSclL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA12869F7; Mon, 15 Jan 2024 10:32:57 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEC0C807AE
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cb33KKcHXwkF9FuCnEOT+C31pSdYxnSqWAPaaRSf0DU+cHWSG6iKUiwQ4OF3DK0BRx88UQgUE0ubckkO6mjxwMVprWqLVxJ8dYitW7bBnt93WBR41H0E9rpasnZUhnsvAc7KzXB/cs6IQhRMVPsnOxpU6IjPKUsMjvkIRnJc2Z2nCl6Iik9F7WfIefGSdmbbn604bfwwMD7SncNnqG2xRZ80oR0gUmwG67NUrdrqeme2cghfDLdROhtjKEwX6rz2pefAvl29OhSE3d3C2+kBUFjPCwkHs5l9Li5IPx3UZPUOFjrEwc45Rpiq6qNluO1CPgWcwBmAhREEBCX08yu5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwV9nnWLlgF2tXaGnjCPw2ng6kB86idYzV4e4fYz06g=;
 b=XgL5A6HT4GMmz90DmBcP3igblR/7tf498t+H0YTUcZ63qhPP1qYqVU55S2nUN9/CjxvcJFH0iwYd3N7JFidbZfzqUpOrO8dQ9cNhUDgGWBNMDIL7FonxO+HdpsjLPCAM6xpMqOudN28SjtZUQOZK/jNsdUusR+cn/wvpihBm9Ih5ujHEaIZMtHXvheBPBXqKWRC1oElp/r+7FSFNyBTpOSu+ZPp2i6Vjhoy1Fiy/JM6cMQTpPB6mpNFDGgRBUWsurQ3GA94u0+0dzQjjDtgOv8uapCqnu7zkLbUDs3ahEFJTvG1epbsDd19+mXqxaCwZVcdrbMYBZ7X836g3fGcrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwV9nnWLlgF2tXaGnjCPw2ng6kB86idYzV4e4fYz06g=;
 b=Pr6rSclL6OQIc0949tZ6hs2Gm5f+qMD7epdd5AF5FQmkFfJcihYMd/LTDo+2eiVydRMcyMnyIXijqijWxlt/ZXzS1NbB6oqzO9pgFOUamYh73irUUwsuU9w92JJ7zlpBoC2SeKJ4YX8ypPmUwsD32IxqFRJRoB2EpQ5tGaNgOfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 09:32:51 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:32:51 +0000
Message-ID: <0436de60-d0ea-4c54-bc44-55a188747456@amd.com>
Date: Mon, 15 Jan 2024 10:32:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Start TPM automatically via preboot on Kria
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, ilias.apalodimas@linaro.org
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <dffd2ee4cf2844832ebbdabefca0099cd2629ccc.1704980933.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <dffd2ee4cf2844832ebbdabefca0099cd2629ccc.1704980933.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0188.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::45) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 937df108-045e-4704-3706-08dc15acf1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qwbvyRXiXm4RQWLqxN5bsLY5m7HDGdHW4w5VG+Q3cLd/aWQbhwG801dw5lyCq6VvU/dAcUUkGNlLxDiLgkPIFKxzC55l+lDtkFFbWE89YwxkVsWXhh5PIBduXCU+mrg5KPktT/8NdrFWfwySXfx4wZ9L983fCZ9gf5p4VN6N7nomVQHtaQhp4amL/+AHHRtocYd1C1Mxx/fPPDQwO3jwOpChfWNQqGDEVJYZEms/8hN7S0o9HvjwkA2zs8xLzpqcsThzzNUgQn+L9LF8C+jqSiW1do5GyI5hI1BcVUqxQrUOqyB+jl221qTwfMFW+LcJhuWaQxrR1mZv79IJ/N9QIw/sfoyCtWkszYGQx3UAjbvYs2DfBqEwpO2xCPSfcsUiYdc5Uc1RNdjx4XdMyblDufNn6BFC2L1OURC02uarWqZfd/IBvyGrpArNyklNKX5eT05uNANDvSj8bi7WMeoDQDYL4EGL1kWy+rFHItpQ2mer1+vPQlnt0L9MT7MhdaHw32YhwseZmtqCpEa1sMq4E/RhqEzuE8lTHhHx4+4ObnZX2ZbP1zfE5wNZgk5ca6yB5mX+EJIdYGD2hzNq4fNBsXbg533rdia4fe8SFjTJiVvv5kIH6Ttaehm28V0vhMcgiijDxtuv7c0PhjYWVed+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(26005)(53546011)(31696002)(6506007)(6512007)(83380400001)(8676002)(41300700001)(86362001)(44832011)(4326008)(316002)(5660300002)(2906002)(8936002)(6486002)(66556008)(36756003)(66946007)(66476007)(478600001)(6666004)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9tWEF0Rk85N2JXK21BenVYcGdGRlRDMjRpVkx5TlVFRXMyUmtRS2FybGp4?=
 =?utf-8?B?VGxuWDdwb3BESExKQ29SWHBzN0lrQms0M3hyQ0RyeFNDYXI4ZDd3b1loTE8z?=
 =?utf-8?B?SklNSUR2N1pBVmVyTDZXNDdpUTZKTks0ODFKQVhFb0p6NWlmd3lYYU11T2VH?=
 =?utf-8?B?a0hTRXVCYlUyR05zOG1FYzlEVzMxOVg0QXEzbFZha0FRQzgxQ3owV3loY3FD?=
 =?utf-8?B?c3lXb3JTZWhMK05FZmVuSVp5bDFoVEFpOHVGeFJUWkpBeVNzWGZmNThPY2t4?=
 =?utf-8?B?aDRsOEl3bmxCNEo0NWhHd2xTQjNpNFEvTG95bWVKOGcva3FEbm9YdlV3ZHlx?=
 =?utf-8?B?YmdLeUtYRmEyelptUFBRczUzOFNNRGVPYWRtNm5qcUwwNTZ4cXBlRXJwbnVN?=
 =?utf-8?B?OGxaM01uVllmVHk1SXBiUDl0NnVweXp1ZUtKYjQ4K1VwVmU4TmQ1VmdtNEk5?=
 =?utf-8?B?bzMxeDlHTlpFMWIzVWVLcU5SNkQvY3gxL013eDRUVElJVVNQM05LVG95WmJL?=
 =?utf-8?B?eithRGJYbkFPVmtVSFFnUzZ0bHZPSVY1Qmt6UDlXdTBFV204YkpPdDV6Rkoy?=
 =?utf-8?B?VnRDN0grN1BNdWtwVVdMUW8vajFlZlJxWEpUTHhYVk1BRHk1RjRjNDFzdTNI?=
 =?utf-8?B?bEgrRFhQdXVKbE56emF0eEt3R3IvWTVJY1VEVmxrM2h0bjRYUDRFK013VytB?=
 =?utf-8?B?Nk1vamZtSjh4eUFIeHdBK0I3QmtnNHdKRk96ZzVtTGpWRjZPbjViKyt5bTNG?=
 =?utf-8?B?a283aU95RnFBcWpFYnM1elc4MFJmUng3NEdDK1ZEeVhPQUlMYWlMZWR4NmpZ?=
 =?utf-8?B?ZVl0NkxEU3p6eTJySnlQWjJqSzVGQ0thYWdPcG1Ec2dpcFRmMnpHdk90Q3J0?=
 =?utf-8?B?cGZvYjJkNGJ2a0VtaitzY1ZZbnhyNHpuUVRaU2lDUGpiTkVPMXhiOWh0OWtJ?=
 =?utf-8?B?RTI3L0JIN01TMjE1UzZLVEZKTXVERkFmN3ZNdXBZVW92dFhHVFg3QURjTFVi?=
 =?utf-8?B?QXNBSzdSL01vTzJQWE1jeGJNU3U3SXUyYmZWOTZTQnNhWXpxemNiWXNkOHJk?=
 =?utf-8?B?UWVxRHpYNEVZMWpWU2p3WU5heGk2Q2IwUG9ycENycmJnMnFPaC9zSGdLL3hR?=
 =?utf-8?B?enNlZ2svampzb0ppSzI5VG5PdmdLMUxhR0hNc0hiS29Vd3V3TEVjd0NKTE5q?=
 =?utf-8?B?R1pQaDBjNXVZYzM4UEl5M0daTmUzdXN0Z0xMYklTYjEvdm52Y3ZPRTgzODFo?=
 =?utf-8?B?aE8vWTU4eldIcXcxZm0zYlFvWEtFZEd0cGJpdDF3MENiMWplVWJxQkdMNzR6?=
 =?utf-8?B?V1h5OGJsVTFYdU1tT3dqOXdBdmE1NnFVK0tzUkl2ZGtJbVY5dVRJTGViNHoz?=
 =?utf-8?B?SDVDWmdxckdKbTBNSks5TnVrdUlXWFk4OXFIa0ZaVjN2NGZoVUlkWk1wR3px?=
 =?utf-8?B?cHFnRXltb0FHb2tYUkV4ZmhiYXY0ZUV1OTI3UHUwNDRTZFg5Ykw0VFVWME9X?=
 =?utf-8?B?WE5KMmlDOU1Ic3pqd0VEU3pqc2h0dlNpQmwzNXM0V3ZkbUljM2dCU1kwYmVD?=
 =?utf-8?B?R244RklPTWhIWHQyeElMYkwvTTdXdUErUm9MbEt6VGRKT1hrMDdreVVneHhU?=
 =?utf-8?B?RW1oZjNDWEpaRFFRZWkzYWVvNHMrNFREYmlVWjI1N3kwTE5Ncis3QkpoYW9U?=
 =?utf-8?B?TFdXRFdHMk9iZFBrWXlRRjJ3YXMzUzV6bFgySzFjVlJlZ1kxZmtDWmYyQUxH?=
 =?utf-8?B?QTNlbkhqcDdPcWR4aHUyeTM4dFJMT0s5VlRoS0JsYktLSDhDTjhyejhFTTdp?=
 =?utf-8?B?Tmp6NWdvOFVRbjB6bFl5QktYYXpBWkg0UzBSdzBoTDJFS3ovVzNDdUFIclpr?=
 =?utf-8?B?VVdEZmpPcDM4My9JYlNJNExLY3dBUmxZN04vVURldENYZWVtQldOcTg0aGZZ?=
 =?utf-8?B?bG1hVms0MllWdHVOREdER3pIa2hKMDJYdzdIUnlEWDhDb2ZBWFk3SlYrelE0?=
 =?utf-8?B?V3RjMWpFeEROQWNBa0RiTkR4OUI0VERGSHR6RG9qSEpsU3VBVXNMMFZPZG01?=
 =?utf-8?B?WE1RUzlibDhWd0N6N3pjNUk5cEV0NVQrS3RhbHMxQjNFVWMwMVVCbk9TaDlE?=
 =?utf-8?Q?WoICuVEk9pl8MFIbJ/+qLt4d6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937df108-045e-4704-3706-08dc15acf1dd
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:32:51.8063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WW8blf6a+E4ZRZQXpV0ZHxfAeLvRmNUIczVlosbmucog0PvyDCFsad38Hc7ie3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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



On 1/11/24 14:49, Michal Simek wrote:
> SOMs have HW tpm but previous stages won't start it that's why start it at
> U-Boot which will also provide access to random generator and it's usage
> with KASLR.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 36182f1b0d85..0f940bd68f89 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -60,7 +60,10 @@ kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
>   # usb hub init with enabling PM nodes for ...
>   kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
>   
> +tpm_setup=tpm autostart;
> +
>   board_setup=\
>   if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
>   if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
> -if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
> +run tpm_setup

Applied.
M
