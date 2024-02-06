Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8893C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E4B87968;
	Tue,  6 Feb 2024 12:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ziHfhi3K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA52887BAE; Tue,  6 Feb 2024 12:27:56 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB0F8753C
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM6GET3C57K+RF6/0M3se+pKDLxCrWIw/x9hMsxLzj875y7rATObYsFw7YDBqZpC+c3MGfAws6k8EVUc6az+6URJhnPij+d34kmhCFF0lH6X1ScjW+x7TyytMTy/yNZr07HFRBn+dN4ERuXYo0YUIw4IXLN2Cx3rxadS85DqdXglVkcE/Dh4STow1IeVH7AONW7pA3jRxAOZAazzcf1Wyt6lgevuzN11gx0mrlu967XfR/lvNmT0G8JlY/Wlp15xJ+CkDlcgTC8uErGw1ybRIEMd+LIaNNAbp2jpw+poB0icPCoa5QENsZMOSbX+N19lB94v4dzRUgR6aGyz2qr77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwLWIbNYbmC1/rF6v7YwqDTIrBKDragTI/ZrbTrSY4U=;
 b=iyWq74F+WlpTVx0riFQMuOTU7PWjDhyh+tQF3eWQECGQ9zG66TSqFLpzzxe6nHqP5mOcdfY9Zfd753zNRQLct18xaJ2veH0qS548mjgq0Z+JDGsHoEJmRf98fc5VR90FHAKvz+/g6/WTRaV6eaHQbwwea3d879NdNHDKOvhiZzcJENO9Q1KI+iyvIpe41bLlG8ejfV/UWggi8KMpUbC7swMsJKmlRJ+N5Ab6kkFE6iAOVzqDXo1KewlsgHpophx9//LbGgxZ3RQdd2kRlxnZ4tyUkp12HZ+Bx3mBQFkId7gHyfDpPdQL7Pcni1HedOKFHZau0FcMWliRYQPHSDYu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwLWIbNYbmC1/rF6v7YwqDTIrBKDragTI/ZrbTrSY4U=;
 b=ziHfhi3KzsVuDLsIOop6A4d+xaSmnLtHOkHnywBVYVN0paaQBaEB/GbE2Qb2oLSyc4tA6gEplRIkdJ0Wm6yKZ7HhYpQ1qFvc1qYe2XeR6NolAD1eD6LSOb/YkiYhL5CnnJCgJHYK6RmFIU8HGjf7IjZyDvF0PoXdkS+FS0Gr2aQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 11:27:51 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:27:51 +0000
Message-ID: <a5b6da7d-9724-47d5-a299-1f2ab7ba48ea@amd.com>
Date: Tue, 6 Feb 2024 12:27:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: zynqmp: Add the IDcode for dr_SE and eg_SE variants
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240123045715.893652-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240123045715.893652-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0223.eurprd07.prod.outlook.com
 (2603:10a6:802:58::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: e61e4455-2550-4e29-70a7-08dc2706a727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQRdrEpe7wOP8qC+P7iKF86lw76aQV2C7Wftxt7414uWBkLHkiggVc3GXwcMqsz/hiS/3WGEQuqwxB3uMrCezKic/oHFCApN7274lf2k/PTe/vLa0Khq5Xs3J7hmN1tdf66K41qkAGkbho+6HON5SYyB0g2l6U5RfSxCniaEy4c5rwO8KQzEK0mdtFypRGaRY5C4nPXmZRGAWA5I3K/N6q9ZsodxC0WSsLBWQp6jygF5Fh2RZtm3Odu7COkVzkKHNTGHwe+lYspMYEGELhB0dn390afR6XRUyTTOVp8I4V1lVD6km/4OMGooMor6Ag1nehCWTBlFvj/Em7M+XVg/6cGUx9BKneiSkFJDmHcrJDFqStv26usXaMq+ZNlL7Z3lD96GvzSzfcyDRFtmHT4ZC3nztIYbhrB7cxHHgp/NDaPrQZzWQkpfQgIGSJjXVfk/eHXsqx+jPbQ7VCnF7LKrh5Tknr7n+iNlJfmeIwpB71t47UlxF9FvMjrk+p+Kl6r10YfOj3D8BWPbHQ2KjWuMoP5xs17/w+ypl3e0TRYfu6bDTl82BchCRAgCxBkekntTAHDI+5wnZlFh7rCWf+A875CnhqcymdX6V45t05miZCSDlNJq0/4zLUyunqjw1dT80S4wKLKZl65kJ2XzWLpmgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(44832011)(8676002)(5660300002)(66476007)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(83380400001)(6512007)(6666004)(31696002)(478600001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRqUGFzNGNMTDhxWTNWSm9xazZYVnp4UVdBK2hBT1kxNXZGVW5Yb01mTUpY?=
 =?utf-8?B?K0xWbHAySUVRTGl0dWxEOFdvWGwwWExHTUZuTlkyOXRqL3RWdmV5YTN6Um8v?=
 =?utf-8?B?QU1vc0lpblF5Z0dKOTU5Q0RPT2pCaVJjaU85aWxBdE42RU12L1dIQUtMU1A0?=
 =?utf-8?B?RXdRNDVDRlZleVkvRVVoVlVFN3VmSUtpcThxeXBqSzFpdFdNS0J2UUhLVmw4?=
 =?utf-8?B?Z0Fod2doUUE0eWU2NEw5QWlpUUVuUmRuc3RoZllMaDNsK1hXMTZ1azR0N2NP?=
 =?utf-8?B?UHZ5bHpvbTZvOWZMOEl2R1pVNEpGZHk2UU55MC80ZEhUazRaSm94cllsMzVw?=
 =?utf-8?B?bXZRclJFaksyMXJQdUVGRlJaNXh2aG83WmJ1M3haUkdxN0lwbGllb1BDOEJp?=
 =?utf-8?B?WXJvQ3RSWFpoTHkyK0FLZVQ0dkJGZDU4WEJQNmxRdnBqbTl4Tk9ZR1pBNTZE?=
 =?utf-8?B?ZmI3YkJIWWEzem9sclNWVkh0SE9TM2VyQ0FRT29DNUxYZ3dXRmpwb2tjYkVn?=
 =?utf-8?B?T1ZrYktyTFZzRUpmU05PdXZjTm5xaDNjNWRORDhST0NZdWVSUzRCczAxTDZI?=
 =?utf-8?B?OHM4WmE2OTdTdm0vb0ZwV0p0dnVFNVFXWkhUYjVlNnhGMElMWU0ydWowREx2?=
 =?utf-8?B?KzBTVnV6dy95SnlQY0ttSUtxQk55RlFzekVwc3VCTHRLZE5YN1lLaTZJNk1N?=
 =?utf-8?B?K0NaZHVLMExWRWF0ay84VTFQa3FNb1pEa3l3RGtqNkhXTzlMMEM0RlhYUVVK?=
 =?utf-8?B?WkRHbHhGVkFuUWZvTnppaTlCNGN5TnpQYlhseFNzMGhJUVdVYm9lbFlRek1j?=
 =?utf-8?B?Z201bytRdU1QUkorWDZnVk1UNlZxSFlYbks3ZTlWeUFyS1hXVjNoQnBwYnM2?=
 =?utf-8?B?cXR4VGpMdWlaajZ4MmFwcGFxcmdMYXhubVZpQXNUeE1jZ3FTd2sza0RTa25k?=
 =?utf-8?B?bk55VGNldUtXdDV2SklXSjVOdzlobUlkeWZ2SlYzT0NhS3FqWG45QUxseWxr?=
 =?utf-8?B?OU9CcnBVcExxSGk3cjMyQkMrcnRvd1QweUtuclFKNmtjV2VBS2hKaSt4Y1hy?=
 =?utf-8?B?bFVtYUk4VUZrVWRkZUV1MWVGVXNIeTZ3bUlpWVp2enQyTlZnbWtyM0NuSXNu?=
 =?utf-8?B?N2ZHYjl3dmhkUlRXa0dKRmxFTFRsbHRLNWJXTWdzcWpJeGFKcXo0NUduQytq?=
 =?utf-8?B?TlNsODZlbFVqZVpQWTVkSHpmb3JPdlNvdit5NVZYNzRsSnRpbEEvbGNxb0lx?=
 =?utf-8?B?eFIvUFFXRnF2V3FWaWYyMGtmREMwMy9nWmhIYkJwd3hKVmxtd09OeXBhMUpJ?=
 =?utf-8?B?eEN4YjQzb2c3NmVJOWVYR1FLUHhjY2hGRVlRdHFwb0FJdjIwMm00TWY1OHNy?=
 =?utf-8?B?VTB0ajJHNnNTMVRYWXFML21ycWtsVXdWa1hwWkw4ZXkwRForVktlTmloZ0Fi?=
 =?utf-8?B?QldPbzJoRmtDY3Bnek9pWXBPNGl5cm95TVhsR2FYeE1RUDQwSmIwbFM0VmNv?=
 =?utf-8?B?ajlxNjV3ZVpNY0pyWUdyS0QybjRLK2Nid1RlaTNBOThON3RWVUJKczcwdWdJ?=
 =?utf-8?B?b2x1N1pQb01mbWw0QWJGckZ2OG5QRGpjV2M0OC9XdFAzUmRQN3htKzlyTGtV?=
 =?utf-8?B?T2VQVytkdmpEWCtXNXJEUExpSithMjZnakZzalNISDVRaHhmeWRyWlU2YjBN?=
 =?utf-8?B?RVJMdjZ6WVNNazBDWlB5T0pKT2M3WlIrQ09TRGdYVU5wcld1cWlyMDdZU0JM?=
 =?utf-8?B?UjhMNCtkNm9vV0tWS25selZ1WTV2NmxKSG9yckF5bzZJUk1oa01tU1RhZGJK?=
 =?utf-8?B?VUFMai92T1RvbWVYNEpzU3o1QjQ3bEFQQTNtUTJWNnlVU1N5NmRRTGhlZUdZ?=
 =?utf-8?B?RWc0cjJNSWpib0NvdXprZHRxa2VNOHdzbjhLREpDS2pCcGxTZE5VL1Z0ZzNh?=
 =?utf-8?B?bDV0bFM4WTh4b1RsR1Z0S0lCVnlFL1ZjNjl6RFRpRXBBeFYySDByYXJZMy9h?=
 =?utf-8?B?U0xESFJybWVtZm5QZWJxTEFOSVQyQXVzbDNiUWMzVHI4YlY4anNKUlpxMmR5?=
 =?utf-8?B?NzVmUWg5VzFwczI1a0p2UkRJVVdjZ2s3a0dVdjdJckF2VG8zc2h0aVVVbzJj?=
 =?utf-8?Q?vUCjq9NO5wJ0IvUJ2m8df1LRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61e4455-2550-4e29-70a7-08dc2706a727
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:27:50.9492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8RY5ta1++y14q2893jnjJ3meshQFnhPYh4fGZUUyERnikpF3LfVatL3TU0Si9ux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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



On 1/23/24 05:57, Venkatesh Yadav Abbarapu wrote:
> ID code is added for zu67dr_SE, zu11eg_SE, zu19eg_SE and zu47dr_SE
> variants. SE is the select edition of restricted devices with the
> capabilities.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/soc/soc_xilinx_zynqmp.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index d9a5944965..786825d920 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -35,13 +35,15 @@ static const char zynqmp_family[] = "ZynqMP";
>   #define IDCODE2_PL_INIT_SHIFT	9
>   #define IDCODE2_PL_INIT_MASK	BIT(IDCODE2_PL_INIT_SHIFT)
>   
> -#define ZYNQMP_VERSION_SIZE	7
> +#define ZYNQMP_VERSION_SIZE	10
>   
>   enum {
>   	ZYNQMP_VARIANT_EG = BIT(0),
>   	ZYNQMP_VARIANT_EV = BIT(1),
>   	ZYNQMP_VARIANT_CG = BIT(2),
>   	ZYNQMP_VARIANT_DR = BIT(3),
> +	ZYNQMP_VARIANT_DR_SE = BIT(4),
> +	ZYNQMP_VARIANT_EG_SE = BIT(5),
>   };
>   
>   struct zynqmp_device {
> @@ -105,6 +107,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 11,
>   		.variants = ZYNQMP_VARIANT_EG,
>   	},
> +	{
> +		.id = 0x04741093,
> +		.device = 11,
> +		.variants = ZYNQMP_VARIANT_EG_SE,
> +	},
>   	{
>   		.id = 0x04750093,
>   		.device = 15,
> @@ -120,6 +127,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 19,
>   		.variants = ZYNQMP_VARIANT_EG,
>   	},
> +	{
> +		.id = 0x0475C093,
> +		.device = 19,
> +		.variants = ZYNQMP_VARIANT_EG_SE,
> +	},
>   	{
>   		.id = 0x047E1093,
>   		.device = 21,
> @@ -170,6 +182,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 47,
>   		.variants = ZYNQMP_VARIANT_DR,
>   	},
> +	{
> +		.id = 0x047FA093,
> +		.device = 47,
> +		.variants = ZYNQMP_VARIANT_DR_SE,
> +	},
>   	{
>   		.id = 0x047FB093,
>   		.device = 48,
> @@ -185,6 +202,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 67,
>   		.variants = ZYNQMP_VARIANT_DR,
>   	},
> +	{
> +		.id = 0x046d7093,
> +		.device = 67,
> +		.variants = ZYNQMP_VARIANT_DR_SE,
> +	},
>   	{
>   		.id = 0x04712093,
>   		.device = 24,
> @@ -271,8 +293,12 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
>   			"cg" : "eg", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_EG) {
>   		strlcat(priv->machine, "eg", sizeof(priv->machine));
> +	} else if (device->variants & ZYNQMP_VARIANT_EG_SE) {
> +		strlcat(priv->machine, "eg_SE", sizeof(priv->machine));
>   	} else if (device->variants & ZYNQMP_VARIANT_DR) {
>   		strlcat(priv->machine, "dr", sizeof(priv->machine));
> +	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
> +		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
>   	}
>   
>   	return 0;

Applied.
M
