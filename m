Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7810ACDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF5584894;
	Thu, 25 Jun 2026 16:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IyBWkA38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C78484949; Thu, 25 Jun 2026 16:17:34 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347E2846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5UcI8/gUx0hp1yaQ7fyZKocy3bVQar7MNQXIpxHoXEdb+YjeLmNi04BKWhE+AjiRWo1iKHZjXdpw7gK52/azAifkxYbDMveOXXvezASLcOBMxmXi7WNU7d9GvBBHEudODWrSFrkvljxyl+y0vciekrS9rppGDv53oTVaSbLwhAU8AAUnOagLpCRz/kBJ8TkxQo+wxfVj9UQdY+u02ypWzND4FPX5CxMAELxDEK0QrAwGJbzUTtMREcL9btDSHVPaUnS/AmfFZZpws83tu0qpOIILS6F/n3oro52kHCfMYE2gILu/isPk7/rhKiI/WCA9tNcFEMqpPMs/wNYTYQR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8/UHoI4St0qYbi1BsrUNLYl0ELBL3eyEpn2+HXQlUg=;
 b=H/o++dzb4UUvX50T/hMxdDls06Sr2wMQiy74rFfoDLRbLaOi2HEtz7HxhZtt7o/Z7kcQdLpB0HqQYzT7uV2RAIq97MdMRplDstE6BIi2FLlco0z1okYZ8GK1pZv1Vqxbs7IRYG4k4ZIAS717b0xK1bToB+0E0lwalaB/Mcc8kjptqF+nW/LahIdOAgyxbbQtBj/EiQM+/hHpXE3QH2I1O1lKaz9oKlLZBnsGsVv6AZbqe+41jXhtqyxy0j0HUwRXhunf3O05QUVTR4eDVKOhTR94zV4TifymWlY0NaaiOpEBQ/r6CAspvikIWLmT+bLp6pC86vut5ujeS3qoTdDqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8/UHoI4St0qYbi1BsrUNLYl0ELBL3eyEpn2+HXQlUg=;
 b=IyBWkA38teLtIm0ScbRZU8IsFNdxRjzAW+z3k3RQz29DZ51uhrjmS7B06dwy4DMw2h/I/6X4pToSfUXNrDBf/CmBJ13k/vQo8Jze491TEqoXz/TQ/of3RR7KrtOJV12w4mXnQlr2UQTou54xXA35DqYtRclmw3jBwuAlQ6zBGnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA1PR04MB10444.eurprd04.prod.outlook.com (2603:10a6:102:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 14:17:30 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:17:30 +0000
Message-ID: <49d0d974-86fe-4761-9fc6-e35a662e9fb9@cherry.de>
Date: Thu, 25 Jun 2026 16:17:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: usb_onboard_hub: add support for USB2517 hub
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
 <20260601082717.239518-2-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260601082717.239518-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0113.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA1PR04MB10444:EE_
X-MS-Office365-Filtering-Correlation-Id: 30a34ef4-23af-428e-757b-08ded2c47dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: v5Q99KJprnohzGyEoUHfxhg+g7j8Mx8+werWjdOAm8Oca0o0bMFPsFXcW81BDnriXVsixBBxbjG2cCVoS3hKLAm3icGBR3HPVUupPtKJTAfGP7xRR+dyvtITJeafu/R0hlz/6iL6bWV1EjuJuLDkxZY0rPcV+xnc1XYB0s5xLgIhM/UBrR31FIfGa1dAG8pI8w/p1saNdIcoqCu4DgPhXdc819F4k+Lb/dmq29fImxmP4NpQeQpbLg3SI0enELTSmRcVfIfpYDUsru76Yp6qfg8BeLHNUsBSyrR9exChTM7efbMzSuaiRMe1whB9AbdFK11d/fw1cZ4uz/5jbLJvqgfkQ01DfyLqLjdpARKKC/pqIM+iuGBuzqlsGpSRQTmzG+wJuuwBMum/FDYXAt+TijY8i3skj2VJnsTVkrqzzvyPM7oGLT/rGjGtRBePP289iGv5HlQ+LkiIkd4p1gyscXH51FPukNABkDqfa/7ttD/Ul+Ldj/omuaU/4mVIEG9Ugq2ZCu++MrQofyqC3FypWD80UhLFomcmDoQN8hcGhwQCSxGkCNjxpJBkGIsx/MMI0TOUT+DNrDfofYIQoLJTAexb2JfFXImRkC3jFd2YNZXyXlnZTmwFKToJDQe9T9nMpKuAjnq5j7WQIUYyXUVfkFs25Oq23P3sP/p2jZo3wcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTZEOE1nR2IxT0RkOEhGb0JDdUdjbmR4M01CN0Y2RWdhcW5pY0l4M3QraTdG?=
 =?utf-8?B?RSsxNEIxNVorbHZ1WEI2U1RPYVFkTXN5YnBPWm9kVUlkUzlFNHBEK0dRN2hj?=
 =?utf-8?B?N3ZlWnhQT05paUFjN0JhRDdwdm1CclZIbENGM2Y2ZWpvTU1TWmJWQ0ZaRll5?=
 =?utf-8?B?YzVMc1RGdWgrS3Y3bHM5MGtYc0V6d2NZb0RnZ2pyVDZ4d094VFA5Rk1UK0JM?=
 =?utf-8?B?T0E5MnVQM0NEVXFVaXo0aUFhdWNEN1c5bGNoeHBMNGdmNmhYUHNxVjNic3dL?=
 =?utf-8?B?Y2ZUVWxjOW1YVU1nUDNPTHhjWnM3RzJJY0xRcnJiS3BHanBiZkdIUEIzTXhj?=
 =?utf-8?B?Y0pic2F2NWRYREN3QW1PTmdNSVc5Y2VjTzVEdndxQncyeGgwN2RFTm13ankr?=
 =?utf-8?B?aDBmSG90Z1ZKNEsySHBuT2h4RDV3eWMzTE5WQ05makQzejJNUnhMVE5UMG5U?=
 =?utf-8?B?UThkODJrU2JTQ09iaFRkNi84eU03NTh4amFmWVlmajVkYytXTzhVUnVYSlBN?=
 =?utf-8?B?NFBhSTZLeWs3UzQvcExIVlJHOEFnQnh4Y2F4c1JZSWVMbXJ5dVlLUmZjUXlY?=
 =?utf-8?B?eTNzWERwS08zTjBvV1NjK2JvRVNyWUx0RXJCN1JqSXIxL3lGOU9obllUMnZG?=
 =?utf-8?B?ZEFTWXpSTVRnZEZ6R1B6VFVpYjFydlZ5WDduYWdDQ3pVVGc0OERyUEs0bVht?=
 =?utf-8?B?a05BZXRNbi9hUHo1V2xzRGdqRTBhMWg2a3FHOFNLRFFzNFRLY1RMcnZWR09Z?=
 =?utf-8?B?SmVXRzQrcTJwSjZZMmdOUTZLaEM3RjFFTUpZZDZrS2JPVUpMQXFReWVZNzk4?=
 =?utf-8?B?ZGg4dlpyK2lpUVQxVyswYVJYMU4ybTNzOHZEckJRUUlCQU4wSFJWMTlqUDUz?=
 =?utf-8?B?S0t0eG9ZelZHd052RU9EMit6NUFtTXNhcWgvZGJNZytEQ2F6UVJPUERRQjZo?=
 =?utf-8?B?TnNxWk9JWVZPMXJkSjk0cFhtdXRUd1A3dHdhR0tRK0lmU1dNQ1REQmFiOFVD?=
 =?utf-8?B?eEpMYmQyR25sVVFVUXFaVjJtZDdoWmlJaTd0UnlCVWxCZlRmWWdMcEhqZ3F6?=
 =?utf-8?B?Q1BwbFRtOXB4SDFrVlpWS1RBUVVSWjk4cjJFa01iWlZTQW9KNFJrWG14V2Q5?=
 =?utf-8?B?a1FFNXZhOVFJN1RKTEVnc05NQ0ZTbDdTbi94QmxrUHJsNTF4S0UrRkJ5VytU?=
 =?utf-8?B?MDgyY1BGcTlwR2JJcXRsNzFxMVhsa1FKelFnRGUrZll2SGFrQ1p4TUVSMk11?=
 =?utf-8?B?dlVYWmNqU3B6WlgyUU14dE5zZGNBQkgyRUQwcWFtQTRRNVg2M3NNU2pDVkNT?=
 =?utf-8?B?RjZ4NXlqT3NpaXUxYnhsN2dkN0x4OU0rRTZaWTVIN1FKbHpqd0pSMFREWkp3?=
 =?utf-8?B?ZlZlR0tzc0pMYlJrZ3p4b3hTWVBhWEFNRnczU2ZOLzY3ZVRvWE1XTG1STURO?=
 =?utf-8?B?NURFejVoMGI5UUd2VTNoM1VGRWc5SkppVmtGV2NyL3NsaWY1M2ZiUFdXMXps?=
 =?utf-8?B?OW9lZ3RzekdwMGM0eFQwalVaUXZvY3lpVG9hR3dBbXovckNmQnNXaUU1MGdC?=
 =?utf-8?B?MWRnNnVqRUs2VEdON3JHWTZoV3FpRE52eXdzS0NOR05UUi9icDBOUzRUS3F1?=
 =?utf-8?B?ZXFYYm05b0tlOURvQ0R4MkdITkJzdDkrZzJxTTNxNkVKZGJrc01HcC9EV2tU?=
 =?utf-8?B?eDFzYjZxUG5zaUJSUXhkYnd6MTZGTXZyS0FvL3lIdmtZclhYVFZVWjFKWHhW?=
 =?utf-8?B?YncyVnMybXcyRXBtSTVNS2hYN2NVWkpDYjI2YWlPQzIyRkdocnhGQ0djUzUz?=
 =?utf-8?B?V0V0eXVPM29Xak00bGNPYkgrRFlWZW1LaHJCQXN4ZnRLZHJxZVVnMnpFcFdi?=
 =?utf-8?B?bWFpb2I5Nk0vcmtPWEF6MGdldURqbFZPZldWZmpqOHhyeDlkaGl3d29pa2Er?=
 =?utf-8?B?cGpKVUZhR2Y5TTBrQTdPbXlWc0ZUWnRTbkNBbDIwNXhSdzVmb1BqRmNoNjE5?=
 =?utf-8?B?SGV4akRBMnQ0b09VWWdZMGlGc2wxRG1UOW1SbE4zVGVRWU1yR3o1QUJpWEtn?=
 =?utf-8?B?MkhFNmJ4dHFyWWJqcE1OUnk3VWplenR6SjZESkpaVlhXdHRRL0c5U1F0Qnkz?=
 =?utf-8?B?YVVlamZFSm5TdjJaNmNVOGpDZEZuVjNlUXo4ak9aYjhJWnEzY20yNEl0cWU4?=
 =?utf-8?B?SEdkWm9BVklLRzZVL3RRcGN1OGFaOHBWcUZkWm5KT0VuWkVSZHFFT3BOKzEw?=
 =?utf-8?B?MWtxYVdrT1NIQkVUbmRjVnU2VDI0UDJyU1dmSktDSWFlY21rMGtMSlUwYVo2?=
 =?utf-8?B?U0E4UEpvT09HZGZsVlNwR0JydEMzYS81VW9wZDJ5Y2xYNm5CNGJYdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a34ef4-23af-428e-757b-08ded2c47dbe
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:17:30.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvP92aMIY+1RZO86x8cMnOghXzD4PvdbXzuVjrGMWLKHqK+MhLK81cjycGUcnYEhu6L7W4R5JKweUXgc6u0yWVpSeE8VmkDzwhS65VcvXUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10444
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

Hi Alexander,

+Marek in Cc as maintainer.

On 6/1/26 10:27 AM, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> This hub is compatible to the already supported USB2514.
> Add its USB PID/VID.
> 

The kernel driver disagrees. The USB2514 has two (vdd, vdda) supplies 
while 2517 has only one (vdd). See commit 673655f7944f ("usb: misc: 
onboard_dev: add vdda support for Microchip USB2514") in the Linux kernel.

Now, it seems like the U-Boot driver only requests vdd for the 2514 so 
maybe we should fix that.

So this patch is "fine" as it'll do what it's supposed to, but I feel in 
the wrong way and potentially opens the door to an issue when someone 
will figure out 2514 isn't requesting all supplies and will patch it but 
then 2517 will now also request two supplies instead of one.

At the very least, have a separate struct for 2517 matching the name 
used in the Linux kernel. I'm sure we'd also accept patches for 2514 to 
request all the supplies it needs (at least according to the Linux 
kernel driver).

Cheers,
Quentin

> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   common/usb_onboard_hub.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index e7bd0b9ccdd..9eea18a3066 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -293,6 +293,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
>   		.data = (ulong)&usb2514_data,
> +	}, {
> +		.compatible = "usb424,2517",	/* USB2517B USB 2.0 */
> +		.data = (ulong)&usb2514_data,
>   	}, {
>   		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */
>   		.data = (ulong)&usb5744_data,

