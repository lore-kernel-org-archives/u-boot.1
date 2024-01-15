Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9B0C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54262807AE;
	Mon, 15 Jan 2024 10:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lbn8GO4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C043807EA; Mon, 15 Jan 2024 10:28:39 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA40D8078B
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSbLk2anrD+iXrzXdjGuhV06R0/r9G9dTyHt6YD5MeqcAKKjDVb9wQ0q98l9UaYxQRvLMhiyR81prwM1WuvVcR7lloLcPrLXKP81lLDGsfXHNugq62kAZg+9ZtEXGQdSGc7uuXqVQ8sMph9+le4RR66sqbOMjipE/XLfG9oBPau0m/ckZPRi1nLqI2u2NHZ8DtWZGGvTzup1Goe2fBbY4alODW6oxcHc28M4N350N+QhZf5c2Sm68KHsk1/FrZdvy1LXEClM1tiZ6FY9RBsUFpqCafc535Y76RColiiEarw/5ORWAROJHO2GDmHnbFazTMS3GE+fVTjsx2n7hykVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEjoOWRPNTJRj4JSlqYzQd2yQWLKK0Rst+8nd+85bYw=;
 b=JGD5eB0iiwFgLEqKbp6BXAoXsjLc45WNseJL/YgVnJbtoXsiZYH3t9rrjN+lwjYRQwhxNpHmvl+3K6O4x7u1p9dmviDoZ2cQQUIYs2786vwXaJN2h2n3ZucNsx5rdTNtH7v47NmAgHA3mwcL5B133dcD6T/C41sEL6cufrvO1aD+Rq7M/IxA9iPQmimh5VA93S+HqQLVUfBNoJEGHfT/xUCMw4+umSByXkE4bDhyJYGWhZPak7DSzJeeY9sDWSEZAh0bozSuXd/Ns0iscv8pSlM1k3IjLVFcrmVPEsgQjN9IAhXfZ2gCljvRfib1MzPChUgn50sYbz8GgTVnNsQ49g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEjoOWRPNTJRj4JSlqYzQd2yQWLKK0Rst+8nd+85bYw=;
 b=lbn8GO4VpIuSCnFQnPQlj+g2XLFvTL2bE4hcIp7BDd4ncWkoA0sMu8++RSBzzMQD+V+yYBJVGhIqbs7PgTi0f203XGBAqcjbSU9NMrkCsobsQmn/SUvxyd82l63oj9juUimghxD/LaDYGVLW/lNI7fq9i/PHBWYXk/lms+l6lYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Mon, 15 Jan
 2024 09:28:33 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:28:33 +0000
Message-ID: <8e8eee14-c1c0-499b-9ba0-cbda0410e005@amd.com>
Date: Mon, 15 Jan 2024 10:28:21 +0100
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
References: <578d758ce2af7e307e38ac8b7fa28ba9efba16d4.1704364111.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <578d758ce2af7e307e38ac8b7fa28ba9efba16d4.1704364111.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 189067ae-f0fd-4fae-5fc6-08dc15ac5808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ck00t0XStdpt4mws9Sv6EFAY+aZqN8hkCOnwhqsXFthZ6+dwH+TxvMkX4R4ObO+Grua/8Oa1zScomaDRzocs6ttHVbvSYJZxkcP1nPlT2zXgeQon4NYcSacXZkAKy9nsRaqcPwqvzYYsIPa0wBIRDCs3ZFpszsyykET7DWxSovs8C4vA/aUG39ItZCpovH9O0Ls4jzkRY1dKy9h7Bdse4s98YrBoJvgbjFqJ5iS/Lgvt5X4Q2Kpf0UcEC/1Rb73JTxvcc8UPulEB5T9RmubUiQwnc2Ja39m06GW3bBIhWI4M8yvHC1JccVZogAuA47lksbBwzBzDK2dMNvwW05LPyyt/kkSEF6EUKaQJymu8YMUE82V961Cdc0ufcQ71FngpuhoeIgTbnI2+6tiL9aFZ6tewOuPDLrnkDAwQbnb1E973J5yuN8mFH7y61sLNkkWS9Xh/npQjnnBkCGsKQi9y6IQm2Fnqv8VYObcLe9R4A8yOGO7rxsY1ZxVQre56TuBnStOtq86kM+XAS+olf554flpnvm2AhbpaxapacmZRcHnDmv5qoxLx0GUchmoNiNgQ13RCfy3UcV2eWquB4UGZaCIC14yOnnaV5u3PvRnRwOqE/fZSXCZ8f9mh6wme8os+TnOFw6LsRm6acA9M7qx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(8676002)(5660300002)(4326008)(8936002)(2906002)(83380400001)(26005)(2616005)(38100700002)(31696002)(86362001)(31686004)(53546011)(6506007)(6512007)(316002)(36756003)(6666004)(478600001)(44832011)(66476007)(54906003)(66946007)(66556008)(6486002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJvY1J6SlU4d3Y1K2RSbjB4eWgrcWtmanBSTFRKNWVKSUhzU3NQWUwvL1FH?=
 =?utf-8?B?aEwxWlJrU1RCeFU5aDlKeFhkSkZSbElieGUxNUNlZHVtdVZzZkJWc1VPMG9X?=
 =?utf-8?B?Uzcxbzh6MXpvcWE3bUNpaXRhWUNlei8vWnJZRkdoZnU4eXJKaksyYVRYalJv?=
 =?utf-8?B?SCtMWGlpVEU4NVgwQUJ2SUdFaWVVaWl1d0toeUIwL3U1dHNnMzBqUHFKdHhr?=
 =?utf-8?B?NUFhdkFUb0pYYkFTbisyRjk5YXplVm9GNkIxTTFwSVF5L2J5a2FwbG1SbVVL?=
 =?utf-8?B?Vml2aDlpVTQ2MmorR2ROVDE2YVNCUDJPUmV6NkgyVHpQUVJIRkFYZXhtUjJx?=
 =?utf-8?B?bnFyVk5qbWlUMGhOTFVPeWUrM081TG1Sc0hmQUVDYmlFeEdiVmIrSHpVQ2tp?=
 =?utf-8?B?YitIUU15YnQzaTEyZWZyZzdVczZrZDBzVEZEaTc5VVVzS0R4bGpsNHNvTExJ?=
 =?utf-8?B?cTdwNWYvdW9YV3ZyNkVXZ25yL1kwV1QzREN4V2JZUXh0Z09ZRXpRWTNSK2Fp?=
 =?utf-8?B?ZEdPS3dJb1NGeVlLTTc2QmxvaDdrTE9adkhPWG82WnM2LzVRY3hnQmxBcTNp?=
 =?utf-8?B?MXcvcEEyU0F5SVM1bDEwUjI2VCs5b1RLTVZFWUNLdnQxdzlaYTdjZ0ZIaEM3?=
 =?utf-8?B?NmZ5eWZ3UTlkTVI4RkpWVlJiaUVZNldVRUJvenBRSERhTSsvdUVsQzhEY2I5?=
 =?utf-8?B?L0xEcTd2Nm44am1kT3ZLSVV5RVVqMURLZkJXZ1NLTTB6MXZWZnVKbTlIUHB1?=
 =?utf-8?B?SCtYdmp4MXB0QUN2d3BzN05KSVdST3Qrai9ycDFOY3o2dk5iNDk3Sks0Ymxy?=
 =?utf-8?B?b1ptK3Jlbk0xMnUwcFhmT3YydlpFamdTUFcyRTZEZFZuS2tXVGtSbU1CT2h3?=
 =?utf-8?B?K3F3bG5KUFYxVGFBeWdLazVVYVlLNTNZMjB1cC9FL2VkMGErSno0MGJLdDlz?=
 =?utf-8?B?MXM3akxEVUdrSm52QWkra2QxYVA0WlYxV2hhRFJIdHVSNWtQVEVVWmFWb2U5?=
 =?utf-8?B?U0J3UHQzcDV0THJBdDlubVcybVVhbGRhR20zRkR5N3JMRmhqYytDL29kWWsv?=
 =?utf-8?B?UVBEY1ZqdFVEaXUwZVZucHZTWXpib1pJd1V2TjZ1R0kzVzdpa1ZFUXI2RFVw?=
 =?utf-8?B?dUhnWVUzTG1HMG0xOHhHUUtvSVlPS3B4SExLV296VW01Tmk5aHRnN2l6ang0?=
 =?utf-8?B?MTUwMysxRittOWRQWjZJUXE0K0hoOXYvdldacXJRNW1GcG50M2szSVlYQ2Jk?=
 =?utf-8?B?VVlOQWk1dm5sZFoyb0JiZWZaRzhNcDI0TGlBQkNNV096WnpybTZUNlVrbVJC?=
 =?utf-8?B?cVFJR3pGcEhuZlNTV2pEeGhRamJRdTJ5U3Vub09USUlabm5saW9MMjQrWVRa?=
 =?utf-8?B?VzAyeHBWY29IVHBNVXpRTUpnb3NoRVJNeHdkcDI2MittT1l6d1NlK0xkTnBZ?=
 =?utf-8?B?MDF2WDJWNW9xVjlTZlp3Y1hEcUFqMW9GcUVYL2JlN0lnQ3NFRHEvbU01Wnc3?=
 =?utf-8?B?eXhzVzFjVCt0WnEwZVUvZzBLV1lRTWlrUVlZWHFLeHY5K1R0dXlvUUFHbnBa?=
 =?utf-8?B?dXBuM3NYbXJlTXY5ZW1raUlNamwrSzEzdFB4em5IaFJCaWcxZVlkeUhYUG43?=
 =?utf-8?B?djd2NDd2bFdCZUgrRVFPelJBMmZkc2xOUTBrSG44MUloMzUyd1BGTW82eW9V?=
 =?utf-8?B?TnVJakh5ZDVpeTVISWgrTGIwUE1KM0YxVHJmSml3eGdvZU5GVXpvdzIwTG9P?=
 =?utf-8?B?bE52MU5kUlpRWktCNHlTL050MmdlR3dBb21YeVJ4UkI2WDRlRkhzc3JsaU1u?=
 =?utf-8?B?ZC9xWXNtR3dmbGJkNHB2eExpNHlNaE1uNHRvT2djQU9rakd4cUlXZXcrRDBO?=
 =?utf-8?B?bkJxak8ycURnZzgvQlZFREZ6WHNodWJRaDlobW5vbGV4SlhqblNZYklidmo3?=
 =?utf-8?B?QVhsODBwNVlqMFh1bXNDM2xqWjRsWUVPK25iYzNCZUFzMURNRGZHN1JQazRx?=
 =?utf-8?B?VTBDTityYks5SVc5Vy9FOER3amV5a0VCdDY0aHdZUEdtdXg3YnlHcnF5VXVV?=
 =?utf-8?B?NWxib0ZrRWZoZDdQbWEzVjg0bGQwM01sNHZkanVHR09TbnpoT0k2UW13cEk1?=
 =?utf-8?Q?jvJFuK7WdEXMrkpfkU78DjcyP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189067ae-f0fd-4fae-5fc6-08dc15ac5808
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:28:33.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBLfTBN+IoeRZcgI+zUk24kWLheRW52bYWFjZ7/iyHVE/slsSWtjrz8jUjgY8h6x
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



On 1/4/24 11:28, Michal Simek wrote:
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
> index 2066d5b616d2..30211ca957cd 100644
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

Applied.
M
