Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B294FD68B2F
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 15:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD878910E;
	Thu, 14 Nov 2024 16:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FPyh1Q7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8464A8911B; Thu, 14 Nov 2024 16:07:30 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C938910E
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 16:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGXKFD+ba5eM6cMYtXYTh8/hW1zOqKS5vfdEKcIgvtY+q2l4/Fh1mvkoEaGUWNeSMNrYPvxsJP0viayYjfBPgkBGE39KfcvM/n1Vg5NMaN0UXoX7MT33Vtn1pyJRY53u+xnvBnsqfS3h2XsRGW4l8uY9LaJualSXq43nMbl+QjjwUSluXdV0cBe0RyNdIyqVJZvJ9yJDAtsNbalm2TwecG0gFZVnBx7i6S8xY7xZfBubpOAvnxGfzmjlKIJCf08REIrWvSS2TYX588G9DoLwfYjK+F8vViwtXAtivqOIH3A/uP3vRQ3s6bLj9LtySMWuC4bLp6MTXRszAZRc0s4sdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+bsnnq2G8cmMWDEe1QH27m8betxOydp18qKc8f2uvY=;
 b=qF2bqxsNZHEn4Aquz98+f5VCAcSxaGI+opbpULV+GVBOzIOoM3SzUgGgriJrX9OdO6K1AvH3ik6qIytQU5licn1NLKfAFPDgfhTNm8QWQv27vxgYY4tHS7Y0tVMBh0a6wGwhD14b68NlTM8C7jNH2onOI/pkH5wuG0gkST5TOZhTIug9pPaB1AfH9ALA/sbrMTIs0aQcLqqNCZfhnuO84SNjzNGVzZGGFmKBL3ImY6bH+7jxktXiLmC318VDXSbckRSsAQBBjpGV3zi/9BYlH4eYGm+o+dJhfhm5h6jN493d3yUSPX92qTs9TwLEn6st2OWFYTKPhbkvR4vyzefETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+bsnnq2G8cmMWDEe1QH27m8betxOydp18qKc8f2uvY=;
 b=FPyh1Q7WijLQy2NGNgSa008n6qSw90ZxaRoJ9Mu2q6SkbJe1Bb0jlU7icJVNFf5ISnfVaKkU84d3jH4pEREOmP/H3V3ZF+Z3XsGk7F1niBpbzJZtbNW3LJ7/ovb6E1a/YPLxVgzMcauoaXE8Cu9WTlJt3w2y+11/6LcYtwhMhTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 15:07:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 15:07:22 +0000
Message-ID: <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
Date: Thu, 14 Nov 2024 16:07:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: ZDI-CAN-24679: New Vulnerability Report
To: Tom Rini <trini@konsulko.com>,
 "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241114145636.GF3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0213.eurprd07.prod.outlook.com
 (2603:10a6:802:58::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: accb5623-ca50-40b4-7fe5-08dd04be0aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UncwWlVNQi9kekNkMXFNZ29LR2V2VkNpWkcrL2lpQzJHZUZnQ1ZJZy9tYzRI?=
 =?utf-8?B?ZHZYbW1jMTR3VllnbTVZK3hoSHY0RVkranRPdHArK05IcEJwRFRWb293QTZI?=
 =?utf-8?B?a3hFVmVoQTZ6OFZrSTY5RzYzczZRaWZxK3pHM2gyMWNxdFkvbTRZQzkyR1I1?=
 =?utf-8?B?eWo4Nk4zU3hFSmRJa2V1SXhaVTFOL3V3Z210dlJoWG9kTDZYODRuNVNGR1Jp?=
 =?utf-8?B?dWs2TVRwMDRmZ3o2MEx4SEY5OTdXZkFrYmNBSkwvUFQ2T0tpNi9uZmRYTWds?=
 =?utf-8?B?bUVNTXQwS241eWxLd3NqYUExYmxRcjZRdGFyblA0ZzlyQ2tYWklScnk5d1ZT?=
 =?utf-8?B?bDRFTUlETk9USWx1d1F1MW1yNUd2bGgzSTFzQW1iYmZhSU02c0RMMHZwWHRO?=
 =?utf-8?B?SVpENmd6cDZTYTNuUFdiSG9YT05jOGpDajZ1R0pSd005ZS8vQ1JzRXhWUlMv?=
 =?utf-8?B?WDJPQ0ZGT1ZnbDVrR09IU1F6aUNRTW5VTS9iakNFL1UxczhiOENtMXAxS2pQ?=
 =?utf-8?B?QTRBOHlqSGowWXJaMnk1OG1JckhacG5vZkt1SWlPSmszeStGQWwrS2tXd1VP?=
 =?utf-8?B?KzR1eTFqdXY5N1hzZXJ5YVlDR2RyeGdlRUZYSTNpZzl6bWFMd2E2Rm5LdHpl?=
 =?utf-8?B?UldONUpiQ1V1ZUJDb3hYNlliTXZpcGdMMW05WHR1R3Q3NW4yTFlpQVlud0dn?=
 =?utf-8?B?RkxRemxac2NNTjMzQ3FsRk9IOFJXQ3hMTWxEbmNNN24zSVNhMjI2eTdKOHV1?=
 =?utf-8?B?UjV2VEx4QzVtbzVFYnZEay9jQmMyUUQvZHg2bTUyMVdFaUErMmZWSWFiMmk1?=
 =?utf-8?B?KzQ2ekcxd2FuVDJMQzFYZFBVTEMxYXRSTzF2WDhTbVczMWlXSXUyUHhkb0VW?=
 =?utf-8?B?ZDJWZ1lUQzEvdjQvcktSL2hXQ3IwcWhicnU1ejRXSFUwWVh3ajBBNU1XOU50?=
 =?utf-8?B?cGhiWXJFanJFUXpvUm5MY3BHS1FtbmFiQXhjSFIrbnQ5K25DYnBUWDhxaGhv?=
 =?utf-8?B?eW5TMUpiRkhuSDZGTjgvQVZLbldzMzdFUmpPak9TTEFQVXpIRTRBOU1PYnB6?=
 =?utf-8?B?aEM5eWUxSm5RVzdmVThraUtDRFRSZzZEZGEvM25Ka0gvSldkUVViZy9xSjhr?=
 =?utf-8?B?WGhnTnJkMEZOZGwrVHFMRkVuVHJqaTBaMVVBUFdSSlNJaTA0MEg0R1l5dUU1?=
 =?utf-8?B?TnQ1MC9EdmRNOHJnUGlVSGxVUFlEL3JvZksrV2VIY1lEa2pPbkdiU2huQnZH?=
 =?utf-8?B?RGFHNGFGVk1XYngvaXM4MkFlMGVTWDRZT1BnSndhOWF2UDF5Ymd5UjE1QXpT?=
 =?utf-8?B?YkpReDQyT2hlMm1SeFFVTjZES2ZMTTAxRGVJTG94Wk5kOTVGL3JzUkthNGxv?=
 =?utf-8?B?clJXYU1Qbk1aTDhPV2l4TE80VjlmRHdLa3hlb2VQeUtzbXhrbzg2Ly9oZkt3?=
 =?utf-8?B?dGs2L1BnOWVEZzFlVUt3VytkNWkzdnNwMTd4N0ptcUVGSk9oZ2JaNXBqMFJH?=
 =?utf-8?B?MnY4dVN2aVhPdUFsZVhQTlM5VDR4LzhZNkI0azJWbXBtaVBmZE9NdmkzVG94?=
 =?utf-8?B?b1ZTdDBzNDFOVktkSmxhTVlyLzNFSzZHZS9WcjZFeUxwR0JZZXcwWEl3SjVQ?=
 =?utf-8?B?MlBueUd6Z0c4R2xjTHlkTnF1WVJlNVlIOUw0NEJsUGhYWjhTdjlhTE9YbXIv?=
 =?utf-8?B?a1VLbVVlSGxEM2JremZPN29DOTJNMnltN3YyNHkydmJnN1ZNY1RBVUVpRzlj?=
 =?utf-8?Q?Y/XIT8bphWaHTIPCUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBGdTJoYzVZS1ZwQ3IvQVAxSy85aXhmaFlZTHJzZTJTajVZb25ZUE5XMitu?=
 =?utf-8?B?MjV2MFNEanRQMUE1d0o2S20za3FGbzhSY2ZyaFZLc2VubSt1cmU1YjZOb1FK?=
 =?utf-8?B?S0VGMUlVQkx5YjI5TUZrVmpXT3E5elZ2VWN5Z0o4Z1M3OWdtUUxhcTZxL0xv?=
 =?utf-8?B?SHkvZnZRSVY1WjRJMHQwVFJtd1p0S2JVYXYvUjBiQUg0ZzZIaVVEckVLMDZl?=
 =?utf-8?B?N3liU0JPR09HMjkyUUNzNGlhV293UDlzMXVhTFlsS1BhOEowSjdiNHlBZFQ0?=
 =?utf-8?B?UFI2dCtQQVZHZkFSaHlOSkhicmlnQzlHb3dVWGl0VkE3OEJRMjRvQnVtNEVM?=
 =?utf-8?B?Rm5aSTNOK1FzaXQrcjlwaG5kd2diLzMvT1h5UjI2ZkQ4QW9yVEpkcTBNUW41?=
 =?utf-8?B?SmxMRFdjcXRhb1hwMXhXTE9zSVZkR1ZJdkkrY0pxQ3Z6NVZUQzZpcVEyVnha?=
 =?utf-8?B?enkrRnZEZ21HekgyTDRIWmFaV21MeTVhMGtiQ2xXZWZHSlNXY20zSWJEUjlx?=
 =?utf-8?B?QVlUL3JLblVYOXlSSzZvVWtnTDJueVc3SmNMU2g2dDBzRzNuMU0vOUgxZDNa?=
 =?utf-8?B?SHZpbXN2VngwZ3o1UnIva281d3V0TjZqaXEzaXovSjFyT1hsUnhZZHdUbllJ?=
 =?utf-8?B?WmdpTWZpNWtmRklyczFNNGlJRENWNU93enlYNjJXWHlVMUpCZFNyQkpNc0ZL?=
 =?utf-8?B?ZENoVzRONWtvUysxQVpYMk5jaHd2dlltM0tYUGorOHlQY1ZoNXlrajUzS3lZ?=
 =?utf-8?B?T25KNmNINmpOM04vV0lKaUd1WGF6czg0N2U1eElhNFhVSW9VUitPSkpRb3Rl?=
 =?utf-8?B?YVFIQUtFc3AxblFOa29Ba3hhUDJKTDliUFZlaDFydUZoa0hlb2JYU2w3NTdM?=
 =?utf-8?B?WkFSL1VRNnRpbEJoUUh4L3pIeE14Y1ZKMVVaeVFDdlNWM2VtOCswMzMrMGNN?=
 =?utf-8?B?NXF2dVdrY3M5bWJBWGRtS1NEK0NMZUlua1VQeTBmTXNKYjM0a0hxV1dxdndN?=
 =?utf-8?B?VHo4ZXRISGY1THJoRzdlQjJ4RkVnbUxBaWpoaitzZVJJNEhRcnpZcGdTNm1h?=
 =?utf-8?B?T0p6ejN0MCtkWVJWczc5SjA5V2lzZ3dtblEvMmNkQnNhK1BnZWRYcUcvWG5W?=
 =?utf-8?B?VWF5SW1WcG8vcFE0WFBxb1lxbktVODNneDkvTktoQnkrZVVEekxLd0Z4cFo4?=
 =?utf-8?B?TzhYbDVNbEhxRXYxRUx2L3ZqV2hsTTBsRDJJZUhkbTk3dEhYVTFvTjZBVzlN?=
 =?utf-8?B?YmQrUlkvRnpKZTBHRWVPZXFXZGFJLzZNQVpWTmVWdEdZOXpvN0RLWW80anFY?=
 =?utf-8?B?MG9aWEk0K3N4MEQ3ajRncFU5L2JKdWFWdzI1VjJQeldXeW9nRDgwNEZNT1JS?=
 =?utf-8?B?ZzNGVjdzM2NxeUhwNHRWQUFKaEkraFFSWHIwemRLdnJhQklOQ0VxNGRhdmpW?=
 =?utf-8?B?MTdOMjU3d3lHY3ZPMUplQTBqMXFHNFFHanRFSmJkZGRXRXlPREg5NTdrU1BH?=
 =?utf-8?B?YThvejFEMk43WEhHZFgvNUV2NjFLdkVDQTRjNzR2MThxeithUmxCSThLRW80?=
 =?utf-8?B?NkdBM2hkWUtQdVFJSGhobzE1L3liWHlwZlpTNk1zWVZ6QUp6SXQ5VUN3M2tF?=
 =?utf-8?B?VVI0dFpqc3ovU3pFUWlUL3pTWnFXeDFDQmgvQjlxVVBHc0VUcEpvUHIrQjlO?=
 =?utf-8?B?MjlFQTBGYlhUQlRFSk00dlhwb2JZWWcvV1J4WC9KeVh3RE1zdmNNYnBLSmpn?=
 =?utf-8?B?dGVnQjRaUkJUK2p1VnluMzFyRjdNS1dRdU05cHkzcW81OEpwRjRqQWc3WTYy?=
 =?utf-8?B?cDRiMHMxVVN6KzZabGJsbWNraDVjblg1QUlBYVYzQ2p2R0RjUkp3Y0ZSckQr?=
 =?utf-8?B?bm1XMG1SajVaMTFZdFZpMksrc056WU56T3dRN2g2ZDlSNlhVMk0zc2pTSXdr?=
 =?utf-8?B?T2R0WmdnN3dIdGUrWWljd0FmM2NNNVJGRzZ6NSsrS3J1THVYYVBqZHhPK0I2?=
 =?utf-8?B?NUZzZVVDUUJ5bFJURXpJWVk0ZXRNSndoL3dLN0ZtSFRTb1BXQ1puMjg0b0g4?=
 =?utf-8?B?b1d3ZHhxNkNzd0ZFN2M1czBIM2F1ZkFiZU1RVHFpWiswM2ZZSjBmRDVRNk8v?=
 =?utf-8?Q?m7FukCiT6bD41vdE8+StlJPoF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accb5623-ca50-40b4-7fe5-08dd04be0aaf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:07:22.8753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoHyzLGGPqO8ervymDTeEWW4S5qRULMlYlK8GwUwcVq07y7V8DMNavgl46nukM0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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

Hi,

On 11/14/24 15:56, Tom Rini wrote:
> On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicro.com wrote:
> 
>> Hi,
>> Do you have any updates to share regarding this vulnerability report?
> 
> Michal, microblaze-generic is the most active platform that enables
> FS_JFFS2 by default and so vulnerable here. Can you find some resources
> to look in to fixing this please? Thanks.

We have actually discussed this recently and we have other issues with jffs2 and 
not going to fix it or recommend to use it.
JFFS2 should be removed from our configs and it is also not under our regression.

Thanks,
Michal
