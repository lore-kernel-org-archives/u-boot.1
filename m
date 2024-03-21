Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535EDC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 09:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA11387BE0;
	Thu, 21 Mar 2024 10:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wwqzHP1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375E487D59; Thu, 21 Mar 2024 10:35:41 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B0B879CC
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3653gQK8bplQyCj6lAYOk3lOxm+QpHO7ew+Zqi4NfAwQ0ONIMAk+za6S5x7Bl4fR1vm4WiiEjfP3GpeU9eOulbzVpgrH7ZV3UfXDe6NyOQ4G1y/OMNfCWInYf0r//n7nwR2UfRaBirqy+Y5iTc8yywhLwpA6wb/Sxne2dr9JmfI/jOMzeekCQNBU/EnQsQD1lAxw2vgR3mUIBiz5QDEu79w5rMC2iKEJLkQlN6c+EsjaXL0iztjut2Sx0s2EVKyfQ7gpZVgPDD2EHZitHrv5dUeWvDLMQ4cCn3wKp0+KZuqkJa2YVjCHXp4Huj3zx6JMTFhLnkqb//pVgUYckaGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fJzAscQlPwDUpKQyHWuZEpaVhXGZgpJzNIulopSgVI=;
 b=QKiHxMs0c1RNv91VDsiyMhnFhfLOqSjRrCOrab8/0TGidY1+4Fi180bSOfxNP8KpEcEj5yPJlhNz/v4R6bn+aWVr6oWZjnHZMTNpA8s/oxkY4BXRiptT123oV93pBCocv6HMQ52tgkfNAMEVYgXuKyvoB1nE43kxrehEMGWFfHvjevVrCHU7VaV7mnYTO0LQaAMqx5mtHga2G7YnEn8tNDABjUxWXLdiRLRl95VLXjeoppqAay6UGc20WQzZVxi+LfXUF7Shxh+5YaWHqel09ZMArK2pVXnnECOEeoUHppDu0Lao5QUIBdk6Dn9s/0YAEMfnGCN3WEY5D5u84lBB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fJzAscQlPwDUpKQyHWuZEpaVhXGZgpJzNIulopSgVI=;
 b=wwqzHP1eXMDbO1u1bg6pgg8Kca+B3v1niINqReytztzZPsUOJBqm6vy44DQL3yWL/ksmYl15ciiJS5Ra1rZPDNQ2mCR9pYqJIu2E2pA3QmH76r/JnrhBVrT8nG2tjDTks15IQOtPaTO8Rm3TuSntdk4irX5G8MtTdSEcHriPZLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Thu, 21 Mar
 2024 09:35:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 09:35:31 +0000
Message-ID: <efdc2b18-6403-446b-ab95-aca115371ab9@amd.com>
Date: Thu, 21 Mar 2024 10:35:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: zynqmp_kria: Deactivate CONFIG_SPI_FLASH_BAR
Content-Language: en-US
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, venkatesh.abbarapu@amd.com, git@amd.com
References: <20240321092557.2939231-1-tejas.arvind.bhumkar@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20240321092557.2939231-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 94548611-072a-4cce-9f1b-08dc498a3fe7
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUv+ByqEa6gwxkFjgF9JkuJwamb2Rqs4pYyfvJOlwSHjKPL9fZYvwSVSab0zczi4Q0HzcahYq8L+uKlfPDS8koGcO6PZmglrTeX5xqMT4EeLcnwknWFhAO2BeuZXRmu2xW50VSzm/SVeJVE5d4Krx4p9PFGNQY3PXpiNR+eD8Eovif+RmfOjkAP7qKgm5n889W2Xl3PUj1OjpEEp08lAGdDTeghzQc2GPZxPsHDcR7+sZ53ENBpV61x3Mf53r7eX/KObgdGpBE2HoY52jt2P7tHrb0PX4tfFPaXnfRzQ0jxXJytKf7AAW21zU59rzMlRw9APECjasara9pdNzKqduLUEbDU3n3a8LO7bhPtunQf1UgkjUnpty32zP9OwRgCBmGZDbvD8ZA6wkwgR9Rpzp3kp0i1BzPphlPiBRUSL7oqMC4AblWA9X1+XPpmM4B/4eg7Bhsgo6MAiwBM0r5tQX3L9PYhj2q+MrajrskhWO5DDdmp3jY2CjJeNUR7apZ2jDFgklHgmtmSWDBcgBbiv/siP5teNUViyzgtkttAdS9vpMBw2XZH+Yd1og73CS4lR12kqpRo3DW8vmxfLAp/p6hsHHHkDUYDWJiB5WMLwu2YjjgrePoe6n6QeWdDPMdjnQ9BWgEOu403gs7su4KXwl31JHlL7yaP1KrmZEzpYxwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW9aZzd6V3NsL0VjckY0NHJvZUVzTjNqMjQ4RkNHVFBPS2k2UldMc0RKK2Nj?=
 =?utf-8?B?WXdlQnE3c3YwZXBac0dnaGxnZC9qeHNWcDArR3F3WHFlN2IvaWd5Zi83VFR4?=
 =?utf-8?B?bys1Zi9IL1BKSTA0VkQ1SC80clNCVWgxRUdQdU15U1ZGd1pFOGxIRmdRTDNN?=
 =?utf-8?B?ZGFaRk9HUzAzRnNRUEpnTkpnbUtBVi95U3A3TmFaTlRKRExQNU56VGN3aDJN?=
 =?utf-8?B?VXN6SVBKdWFWblNtckFtT0lxMzBxNVd5dHluVWFvYWlyTFBwK2FTaWxHOWZm?=
 =?utf-8?B?Y1Z4QzhZR1dpMVY2WTQ4d1FrdTVMOG9RbkRJY2dBN2tqbVhpRmRPK3FSeExP?=
 =?utf-8?B?c29kN1g4VGptVkxFSittc0U0UlhtdzljVDNaYzNBVks4SC84MmlDRUFTTXhV?=
 =?utf-8?B?Q2R2b1pZVk9YUld4MGp6cGVBbjVDdHA4bjB0VHd2UEprZ3ZjYUh2Skh3dzRF?=
 =?utf-8?B?Z3VJVXQ5SGgrb0pQcDYwQVlVUjMrbE93NVgxcWhCUGl0ZTFUd0k4YmsxU1li?=
 =?utf-8?B?dnpLVnJ4b1pZR05EWDJYeWFWdUVBV200ZWpKMUUydmJ1V1VRZHAxVEo1cEFM?=
 =?utf-8?B?TXJTZWd1WkFvUDJLTW0yd1BUOVNPS0tDR3RKNTVMN0RhOWJMb05ncXpnQ081?=
 =?utf-8?B?bzBRaWdoSHNGWmQ0NW41RjR1cnljYkNZQ3lNWUZNaTF0OVR4WjVTOVJTZUNi?=
 =?utf-8?B?elhTQ0NHRHQ4ZExhY1hIREFNKzIwbHpkaU10WlgrRVF5U1FnZ1Y5WGRBdDlQ?=
 =?utf-8?B?N3VOODZ1Vld4ai90b0NlbUNTV1pwOEF3Q00rWDNRWWlndE1EQ3N3Y094ZzJL?=
 =?utf-8?B?S05vaFNod2hVbEszSzFzM1h0SGhuUUE2Rm5pMmw3aWhIcTA3RlVDRjFYYjlG?=
 =?utf-8?B?cFluSnluTmptVVZlaHAybHlJZUV5V1pRdU0xd2t0VHBkbkJuWWF6QklsNzM2?=
 =?utf-8?B?azh1MUkzbERFMXNOZitVc25CcnByL3hjVkQ4Z1MxWVE5ODhKdmd2aDYzbjFv?=
 =?utf-8?B?cWs3OWNyRDJxNmRlejZhdk53NkcwYXlURnpPYXFpQlhiaHBxOWgxQmJ5TVN1?=
 =?utf-8?B?MzB0THoyZlhabTc4U0hrR2d5dS9ITTdVZ093RElJN00yeGNZSGxsUjM5dkNQ?=
 =?utf-8?B?MTBqYTVxMWE4TzcxREw0MVkvaGZITHNzWk90a3kraHN2WjA2VEczMnM0Y1F4?=
 =?utf-8?B?ckt1ZHJPb1I4QnZCdGtPK2IrRlBoVTBuUTNhRml5NElKWlZRT2RXOWNiWE85?=
 =?utf-8?B?aC9peXNsRGFySUpIVGhUdWxuR3RWZitqazVzNXFRaitPZDNZQU55YVk3VXVh?=
 =?utf-8?B?VlBYdWhaMjZ3aHFrMVVmTXFMc09paWFpQ0hoQU1RN0I3UDJmTUYrTnVuR1No?=
 =?utf-8?B?RkRLSE1rajdOTHYrTCtabldPSmNoMDEvQmplRUZhYTczY0xnU3BXM04xc05x?=
 =?utf-8?B?Y1ZJa3o4T1FDbXQyZ0RFSVpub3JZZThZdU9xVXJZZXY1dTJZWm5UdlVqQUNP?=
 =?utf-8?B?RWgrVHQ3WHJZVmZVbytDV2xJN1k3VXhnaVhXL0l5QkRPbGpCclczTjZ1Um9u?=
 =?utf-8?B?ak1SZmp6YjZEYzhleGpuK09FeXUyTVpZczhxOGltMWc3OEtOYXA0T0NBQ3N6?=
 =?utf-8?B?RmNtUmx6ZENnNGZsSmZ6K05LYjZDYVphd1BXV2tiU2lYT0x6U0tUSS9aN3h2?=
 =?utf-8?B?UkZ3RG9pbzZ0cFhKL3NSdHY5Y1NoWG41WmhHUDU5OW1rR0s2dS9RbTNqKzlZ?=
 =?utf-8?B?YWtadnFpMnFCcjFkQmhqNnJ4Lzh1NXhmTmwyODdVWGVMMkVRc3NDd2szdHJE?=
 =?utf-8?B?VkdGTmYxTERsODBzem9UcU9zcDdOZVNSdDNMR2tpZEpGV3BpZkNPazFzd1Ex?=
 =?utf-8?B?ZzhnQ3FUQUl3VS9jNXUxVHREYXpNRmhCcXUvOUF6VzhqNHFERk8wUEVOcXZy?=
 =?utf-8?B?Y05DNlVmNmhMSFBNMzJFVGtBS09JaHNiTHNTM3l1ZDlQcGlBWUIxVGNTaTln?=
 =?utf-8?B?azJuRys1SUVQL2JiWmp2Y0wrVnB3L0FiVElNZXNraDhUU2xUNENtVVRMajlO?=
 =?utf-8?B?TTVQM082S3phWnp4NjFGN0Ztc3RzU2gxRmdqTUtFVkFJZVpqYmJoWVNyQ1hG?=
 =?utf-8?Q?KaZuTyuLk8QY+cvDMtfk+xFah?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94548611-072a-4cce-9f1b-08dc498a3fe7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 09:35:30.8681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3A8MEbhAX8qFhPcLFSCOU/H4jtQFg7+ojH0QcfYflBjvGsURCJ0FDLLVEyfvUlM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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



On 3/21/24 10:25, Tejas Bhumkar wrote:
> Disable CONFIG_SPI_FLASH_BAR, which activates 4-byte opcodes.

Can you please be more specific?
There is a bigger story behind which should be also described.

The issue which this patch is addressing is that when image recovery application 
is running U-Boot SPL or FSBL with upstream u-boot is not able to work with the 
flash unless board is power off/on again.
It suggest that baremetal application is using flash in certain mode and U-Boot 
is another. That's why I want to know that this change actually does.
If that means that it uses the same mode as baremetal application or so.

M
