Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E48FC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 08:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CA8878B1;
	Wed, 10 Jan 2024 09:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pxmWwWq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DCD878C8; Wed, 10 Jan 2024 09:17:44 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB93878B1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 09:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgrr0xxWRTXyE8PjKXqT2z+xrSkRlLw5qw+s//Q/JdOJguZ3NFYvYzGrxaZ2LJE6J++9JKfwYqp8xhTpVEHEYpYjx+V5eDYzln1cxc3NaAArRxvoo9ewf4odc3tK1Dd4tJTE5HYNS+qifYKGG/yDC9KwjC+BJ0BB2rJhoPVxnV3+1zUXnXrFw7rUQhLzpYYOgX9cLk60Q0Km7oj1Z77WTOHP/f3NaUeRk0kY6hb8wTLhLdgdVrKOfl8aI1jmGMGdkjjZeNsA7Ww2Nbr+T34Lg7ilXxjFwJUhCs9sJnVN3aoaE0ucXaxTB3U+KvjM4Gax7QLxv7yMD/L5euKqq7dj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8qTqd3l2iVhCnuxXaIpDdw4CX5H6pZgYYUPjePbzB4=;
 b=YSFedyKIfUS1jdn7N0ZDmjsoEwSETHN7HlELzrxLzNAhKE15uAbUDvy8gxmEpl/W1PFYmSyXq/6EI0lr8Ikrah8H6W8BQOvnr8gHHytK7i11lDjjNjZLkmnAInP/uW6YuTTGzySXYOhHIYAcsL5aR6VTqYtT9O0dokUhKrnKJOjnsSIckbG5D2RXWYsIJD6ko2np9Y0Zn5v2M0K836ER1gPwv7ojMQykYxRMLkO5eC7tJZAjUjsSUC6j5CvDXKXCgBckgpBsnjXu2DKiMDK5oJ38Rmpi4IovpgDwAleRdCrCn5MuLoWYJIdlJkwR4tUc/dqdJl9YvFUj/4rC3kDkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8qTqd3l2iVhCnuxXaIpDdw4CX5H6pZgYYUPjePbzB4=;
 b=pxmWwWq9RLGvWIeFdDdDwGgLozl4l5Hpt0C3P7dvaZ9RCWHcJcoksGvm9sZFLwLXlOTj2a2GUuHyrZ69xxKh/L/hjUld8tt9FeVR6zeOUPNLMIfTnMxN4MgXEnUfKXLG3qXJp5TyisXZPB/h9u9aPlVxNURIFT0RRUM4uov8daI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:17:38 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 08:17:38 +0000
Message-ID: <9fc99975-58a3-44f9-8811-409eb20775f0@amd.com>
Date: Wed, 10 Jan 2024 09:17:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Match dwc3 interrupts description with
 values
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <caecc1fcf26951a4c0297a4764dfb797795c7bc6.1704725272.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <caecc1fcf26951a4c0297a4764dfb797795c7bc6.1704725272.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0070.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::23) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ce8714-f066-4266-180a-08dc11b49b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4HDaCaGwk6oKZ8Yole0EzqVUPdL+7USmfS++xQ9jrDaAZiS5CMI52PecmUZZHIy5FfUWIcjJmK0G3LJVnl6IALA8r6LD9VYYX2g19O53YQ7LiYtTVarKzeoyMZkYPIhou3oP0brk3eiQWo+ovhtjoLniqkLoVTgx3VA2vR2MClD2OBEBE0V/e3Hq+Utg3v/KRObaE34tkG2eKXvqjbbVVjtucbBGpGbb2+KaXu9a74bPw/7Qxt1350vIsFuMz91d2zk8FZDgLu8mXfiWskJA16uw54aemi+81/LDJAS8hdbPBV0JRJfF6KSPGFsopFm/IhDOt4h9JvYShjW8eRRK3CT1UJtMDQRklhsD5QfQlKQUwzj3D75wwLOUl96Q5v8+oquq8F5afOkI5cYfBodR2MKNPdkZnNOspJ0bZ1A/sD67L1rvGVgZKGiDmMRmVjJh4XqazYuDx4Kdrim8twWZSOpYvUpqaiau+fEbF/GXQ6Jc8sBoJx+I55W3EbGYCrCPuLEpZf5HxuGXV7sXGtxSgMBdY5K8VCm/i2M3RWEHk0oMT7Ap7BRA30+KPpdOYsquVJflUz9W8wJSuP/KJxBcctOukrASOqMFuiHmeP5cn+/LaoBObxk9KLozS1EQ7Oeu3PrL+bvXJX0dC2ughLLmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(53546011)(26005)(2616005)(38100700002)(4326008)(8676002)(5660300002)(8936002)(44832011)(41300700001)(2906002)(478600001)(966005)(6486002)(6506007)(6512007)(6666004)(54906003)(66476007)(66556008)(66946007)(316002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVEdHFBL0YrUVF6blVzTkZxZnVpQjAvVkc3VGpGL2pleU9hQTZheHJBT2lT?=
 =?utf-8?B?TUlOd09EY3JkU2pMa1g3cGVGR1BCZjZoYkI5dTRpejBXOFhoMFcyQktydVRQ?=
 =?utf-8?B?aUt2dXNaK2h4UnVrb2NhOENmL1ZFd3ZtSlRQZ0VzL1dKbTYrK1dyYUcxNm1J?=
 =?utf-8?B?by9aOHlOeHhWQmhlKzZVK0I4UDI5MFdZZ085amdlZUVwemVIQnVaV2ppRS9v?=
 =?utf-8?B?bys2M2JFRTNKQnRPZGN3QTFQR3lWRmVzaXhjRGh0NVNIVDRUeC9HbHlrWEwr?=
 =?utf-8?B?Qlczam9uZENvSVdiVDlBZHVyTTRzTGhRSkd2ZG9OMHhGSWRVOVZuUHV1TW5I?=
 =?utf-8?B?TnZ4Rk9ZVlU1a2kvV3ozZDNwT1JFdFVvK2ZpNHZWaGhqMzc1Mnp1K3pVN3cr?=
 =?utf-8?B?KzJqZS9DMW9NVnZMNTI4RmNEem5ubHczN2Q0OU4vL2NVSHNDOHdBeXZleWo2?=
 =?utf-8?B?em5vdytUaDlMeVo2c1FvNUR3UUhsZHU2Mm5la3ZBb2JzSlJpc0ZZdGQ0WWR6?=
 =?utf-8?B?WTRYWWY1eDR3U2JvR1Q0KzlicHFjWGEyYkRiRkdnbWZaanlHQ1BzQSszOUdS?=
 =?utf-8?B?anVlOFE4VmhHL2c3ZEhreFVicGZOdWVuOTliSWhaK293WE1ZK3VXeGtyeVlh?=
 =?utf-8?B?dmt1amNzdW9OaGFtdzJrN0Y1MjNFb0tKWW5talBPVzQ3dTV2S05BYW9tdmps?=
 =?utf-8?B?RzNNcEJYNStoUXF0SzZDMzZNR1VpRTNZWm9Zb1Y1ZWRyWW9qR0JONnVQYlE0?=
 =?utf-8?B?WndhZ01BdHVyQUROY3Ywai9jdkU5bFovS1VYT0c3ZTVFZjhvQ0J1TS9hbHZU?=
 =?utf-8?B?eENCVVJ2SjdKZnVESVh2cXJCOThSRUpXNEdIQnd0V29Sak4xcjVwMDhVTDQ0?=
 =?utf-8?B?UGJoeElKWUdrcWhsclAvUE1mRTErSlFFN1BiMm1PVHZxZklRMzZmbFdRRzlD?=
 =?utf-8?B?VnJqV0pCc2IzSHRiNkZPbmZmT2NYREFuYk5vNmdkSWJ5aHpZcXloNnNjV1BD?=
 =?utf-8?B?VzRzZksvT1hqMHdWRVIwekl5WFhvbiswNGhjT0tYdVd3UjdNZHNiUkIrSnoz?=
 =?utf-8?B?ZEdRNkdqcGpaT3NPeVg4eVdINVZqejVmRjB5Uy9pWXl4akFiNXltbmlSYVph?=
 =?utf-8?B?ZWhhUDd4d3NoR3YwR0c4WFB4am1oZ3ZkclV2S3B1M3hyd1pGd2pBSlVaMDhX?=
 =?utf-8?B?d2Rkak00L1N2b3R4UjF4QUt4YzdMK1k4ZEVGNHJGUk9TNkNPSWRlc3FKS0pu?=
 =?utf-8?B?MEViT3p6WUttQ1lPZGg5Q01nSW5KKzF1azloQ2F6RUZJQkZyakxGK2JFOUZa?=
 =?utf-8?B?QjY4RGdXNkNOT1doWDE4TTBtc3FjMzc2YlF6UzJadXdtaURoQVJ0VDhmQzZU?=
 =?utf-8?B?UFhKM3pGa0ZaZVNiMzArVFp2djdYSTgrUzRjZURUUktLemEvN09ITmVFNDVU?=
 =?utf-8?B?NTJNWitqOWRONXJDL0VDYjFMMFRFbDEzb2xYc1ZBeWhTcWlwR1BRMUZ2SnY4?=
 =?utf-8?B?SnFaUENjUVFYTys5NkY3MExVUzFsQWtuOE9nbnJPUFR1VlR4RGEwbS8wWldI?=
 =?utf-8?B?N0ZlVEVwSWg3LzdGMURDQWJLTkRGdkgzZ2R1SjBkc3VsQWlJYnJqSXp3a0RQ?=
 =?utf-8?B?bk5rZEpMRnNyM1pmL3hWNk9jbTRneUUwSW11K0puMWRsblZ0SmF1MDZZcnFN?=
 =?utf-8?B?SVozbjltdVdUK0kzSFRQSzUyVGZvZlYyR1l5dktmZDJnSXVkV1EwSUM1a1RW?=
 =?utf-8?B?bHJqWVVjRkNMNU0wNTBnMnRscFcvZ2hpK1h1VHU2RjJlSlFXN2EwM3pWTXA1?=
 =?utf-8?B?WHNhYVlYaEcxL3dwLzkvRTR0cDdrNmlyY1ROZUUwTWZVR1lBNkVCQ0t1dGNt?=
 =?utf-8?B?djloZHFKUHluVXVrcWJwOVFNVXB4bmtYSmF2TUx2dmVwZ1FPNDZrQXJiVms0?=
 =?utf-8?B?Ty95b0I3R1htajgyS2FrVkJOTnNiaDdOeWwvZmEzMTFwbGwwcVFKeFlDUkU5?=
 =?utf-8?B?WGwrVjlacWYwNkJGZyt0YU1Pa3BLeURuOXFTMnpLUUJnZW5SbE1saU1QQjlt?=
 =?utf-8?B?NUFsTVVJblZ6WDdUSW9MOVRLb3BCcjZ2WndVR00vMnh4YU9FY1lubkZqclNV?=
 =?utf-8?Q?F9sbF4QOeIlZHLI0dbALO+blL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ce8714-f066-4266-180a-08dc11b49b83
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:17:38.3113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E4Irk2VRMH5CPLCVuRXqtKp62w3kyUZ6PqpxaEduoyeinzPJunmT5YosAk2gE9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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



On 1/8/24 15:47, Michal Simek wrote:
> Correct IRQ values don't match IRQ line description.
> There is one more IRQ (hiber) but it is not described in DT binding spec
> that's why value is not described. Just for completeness dwc3_0 has hiber
> IRQ at 75 and dwc3_1 at 76.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 21be909b1abe..7c7cbfb287fb 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -996,7 +996,7 @@
>   				status = "disabled";
>   				reg = <0x0 0xfe200000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg", "hiber";
> +				interrupt-names = "host", "peripheral", "otg";
>   				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1028,7 +1028,7 @@
>   				status = "disabled";
>   				reg = <0x0 0xfe300000 0x0 0x40000>;
>   				interrupt-parent = <&gic>;
> -				interrupt-names = "dwc_usb3", "otg", "hiber";
> +				interrupt-names = "host", "peripheral", "otg";
>   				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;

Please ignore this.
It has been sent already here
https://lore.kernel.org/all/578d758ce2af7e307e38ac8b7fa28ba9efba16d4.1704364111.git.michal.simek@amd.com/

Thanks,
Michal
