Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF9EC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2BE82F91;
	Wed, 21 May 2025 16:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OuDkSVIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1606D82FA8; Wed, 21 May 2025 16:24:31 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC89F82F8C
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpNiHhYDZjN8RDckUVAhRCZhjti1lbJnuvLGJ+JWBL9H/Bwuli+WX5rTjqLo+Pjwm5ZvbF8VXYFpSHsQANnuH9p10D06M52wJdNIKkcI4MXxJHkRQbzQNFiUC7Y1bUzUK4FmaZQuQ8kg8L1DMCdPZEQkVtNmuQxKhQL7tp6v7cYDO5XDHPL5h3UeAvu7vjAH/SPSK7bjOriulhzFBLQcoGPh8XVu9IcpZxGixFSl3gQXzuWOyFJDaAn74WJ8mi2uqHv6GAC9vTmSpVZQueq0bmIg8tDBfzYNMU0YmeYTSNt9Srbxx+0HHc1gZy6M2VtBCgZXSI5NQK/1+WQExK3S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cWT846SkFIziMGaRJmwayyK+DgqjHk5XwWNHbY7OGM=;
 b=cbn/o9EnLSl8eSpdkCU7UHkZ7tzlRQmzWtNCat0m3ICnhSmDW/7BiyoqPkLd56S84Vm39PSadK1bjI4KapM+jGnbHMufO15pXTMhf/rXlhkl8r59vmBN7u7Q3WFc7qp1Ds68mBWDYuTRuenRru4LG/zyjeRYc1WQ9rK85UX+gUfab0lk5yI92SarGrb5cFzYmPfgXMteiTbQwG0mNX9CIuHOKbpWOy1SuLHZlcKWZPDKHX8J94W7UARmQuatK68JR+4jLdjwn9bCLwogRCW0KLOVOQZ6HB3Ll0Kka8fMrvOy0CCLjPh9hxWMD5TZ7hOBGBCzAJq5eRq6JI97D46xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cWT846SkFIziMGaRJmwayyK+DgqjHk5XwWNHbY7OGM=;
 b=OuDkSVIZa/dR7unTkywOEDctVd8v901Kvz3YUPdxD5M463jDp52GX7bpRLXvlkHwa1ui2P6o6a6AMeX33SUw5xyzR6OyJzk+WTEKsYKKmosZMY6IfDqqz7/XWxl37lBE+0DDSZmxFIUyrTh0V+Pfj5d5EMkQ14uco2HIpkHW1sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 14:24:24 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:24:24 +0000
Message-ID: <8eac027a-6bda-4a44-8e80-48cba4465ce7@amd.com>
Date: Wed, 21 May 2025 16:24:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: fpga: intel_sdm_mb: Flush cache before FPGA
 configuration
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Tom Rini <trini@konsulko.com>
References: <20250506012851.30039-1-nareshkumar.ravulapalli@altera.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250506012851.30039-1-nareshkumar.ravulapalli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:803:64::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 83981f6f-4a51-4622-5295-08dd98732f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkZqMGROZnBJSE9SOFZzWVMzcnhkeGRINjZubVFwK2RzQXdQWTBsdG1uVzRD?=
 =?utf-8?B?cFhLOVBaTWZ2eEJWNWZQME1qRmNmeFJ0RC9ubFZCZnNDY0VvaFFmOUEvb3dO?=
 =?utf-8?B?SnBVQUhFbHpOTjU5MlJJT1NmNmxCMkF4RW1zSEJLWmF0ZFVHVW9OaUtZN3Vr?=
 =?utf-8?B?ZTZlTG9Fa0pmNmJ0cE4xT1U1QUpkRVQ0TE1zWUgrU0o1M0VIMTRxa1MxYmhR?=
 =?utf-8?B?RXk0UkUyQm44amJLTEkvL3lDdjZwd2x1WGZiR00xQ3VRYmRpOHp2L2tsKy9I?=
 =?utf-8?B?UncydzZlM2lkT2ZyUENTVkdQSDBNRG9yT2NoMFlseXhZSk5pQjN4RWxiQ2VP?=
 =?utf-8?B?NVNrVVkwbHRSUFovSGtGc0tPeEdqRml0Tm53cUwyem1ZWUorYWlkMkpzdUZl?=
 =?utf-8?B?S3ZtazBOT3pPVHVmb0JEbEZIU1VKR0ZDbHJRNEd4WEVVbCtXcFZEeDVHYlNH?=
 =?utf-8?B?Y3diMDB1emVERVhTaVhuYjdEajAxNGg1bjZZRVVvRXpmdkpQNGd6bmJKTENS?=
 =?utf-8?B?eFBhak1Kb0lNc1FwV1RUNFdzcmR6L09HZ0IzVHdNQmZFb3hscTBueUdITCtT?=
 =?utf-8?B?dHhpcW8rUU5LRjd3dWNYd1EyVnVDV2d1WXdYU2VNQURMelhpRWxUYkx3bEtE?=
 =?utf-8?B?SEE1RVBrcnJqS3pGNk00YWdZV2ZxZnZpOHRSdFlOTkdGYnNsL053UXdOSG1G?=
 =?utf-8?B?amQrUkJpWHFaNVhtcG1uaG5nays5K1FhK1pBOElORWVYYVFXdzdkR25ERFA2?=
 =?utf-8?B?VFhMN2sxOTFjZ1ZqbFk2NGlqaHlaYWt0c21vUFRhVW11QjJqRHFsdUVIWWEw?=
 =?utf-8?B?ZEhJTDBmZ2p0NThEVnowTElHdzB4V2EzaVpubDBYNCt6OUx6V2FLWG1aZHBh?=
 =?utf-8?B?dDdXSktQQVZSOVVUYnFqdG1JNzVhL1ZzTUZrbDNza0FhYlBCcDc1cysxZzRU?=
 =?utf-8?B?Z25xWm10T3FzYUI4aHlGeEU3bkVkRGRmd0hENk9OdUF3bFNFbzZkUVh4bnZ3?=
 =?utf-8?B?KzA3d0x6SjZ1aWlEaEZ6ajNTc2dHS3N6WXBMdHJsT1Nsb0NtcGVwUjkwWlFK?=
 =?utf-8?B?aStpMFFucUNtZnZoUFhYanhqYUFtY3lVZFlRRU9odS8rKzcwV3l4NGpPT1Yy?=
 =?utf-8?B?L1V6TUFETW1oQ1lCczI5K2twYXBIbU5lUFVzOWJkcGs0R1g3dGZsVTBsOVNG?=
 =?utf-8?B?Y3ExTTR2NTVNU2pJZjd1S1owRjg3bkZnRE5GdFV2Q2JmaU45SG9RNjhuVUpi?=
 =?utf-8?B?dVFOUk41dW9KVVdIc0xXdGR4TmgxRi9ldkVyNXhoejk1RzhpN01CQnNUTkxw?=
 =?utf-8?B?K1V2dTNSZ1hyTEhzQ3haYXNGbjY0c0kxT1g1cmZBY2JxV2ZUQzMvbFVhcFBj?=
 =?utf-8?B?Q051VFR0RHN2SVowTXR6d3ZpZ1hJcko5S0FoUnNLSUhmZTNzMnYwNjgrV1Zz?=
 =?utf-8?B?RWRHUHh2R2JLZUc2Umc0YWFJMEFMUE9rRVhGN0JKekppOEU3RWlwNTNWZDZp?=
 =?utf-8?B?ak9yYnMvak5qME1UcDN6dThEeU43dG1UdEFLOFplTGpjZ1RmT282cWRGcUgx?=
 =?utf-8?B?NVFGWnJtMytvN1hLZjVpLy9uU2M0bi9wdzlpdlBhVUtPYk1Gd2huS2trU3N3?=
 =?utf-8?B?Zmd5N2ZrNjZacnR3ZzlCU3o3djFxK2FkcE5UTkljMGtralByUFhBYzZMbXBh?=
 =?utf-8?B?UGJpWVIrYUZTZG1vSUw4dVFQR2lRemJQSTdyS0wyQ2g1UVAwKzQ4eC9lTW42?=
 =?utf-8?B?N0lVbFpVandhTFBSRkU4aUd4SytQN2tXYlYrSTgvUkcrOUwybVR2c3BEVk04?=
 =?utf-8?Q?LE2JO6reLJVTuSfDUwuLwvRSmzmCxluu835Hw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZLL2RoaWhQelgrbWNIeWIyc0lPSzZnTjJIU3NUVndEcTQxalNUVlNNUCs0?=
 =?utf-8?B?SCtEMEY2dWZOUDVXRTZMZWFObDlvNWFOYmQyajNVajUvdXFLcEZvQ05qcjc5?=
 =?utf-8?B?VGVoYTFOd1Z3dUsrZ2FkYU0rRExLWWlKZGZGR054UkZ3L3lYOE5CSkZienhv?=
 =?utf-8?B?N2VqaW9CdGRtYllYZmJBQ2dGU0pZVkNvVldkMzUrVENpNGRoZlZiYzQrR0hs?=
 =?utf-8?B?Vkhzck1QODZEbDRWV0VTbzRvcmR2cWc0VDZ5cy9aVEZxdER0bzVVWlVJYktB?=
 =?utf-8?B?dXpLdm9QRVFENi9tQ0s3VXpsRXpyUWFzVVpyTDNnbDZFUnZWQ3EwVUJqNW83?=
 =?utf-8?B?QjlFVnhXY3JJWk12TGNnU3NnS01MMWd1Y2Rodlo0bjkyN29Ib2t2WVkxUXo5?=
 =?utf-8?B?eHpkSHMxYnJFZVZWMGF1eEpGNVRuVUlYd09jLzJ6SmxVS2ZwZXNMVTRqV0tm?=
 =?utf-8?B?UTc0TnlVa0tVWTZ4d2dlTUIxbFlqTHZSV25QcVNJVWs1Wi9VMEZpYUY2UkRN?=
 =?utf-8?B?MnVQNFgzblpDc295dENoRWxHKytCcm1WVGRLOHoxdUhsREM3SkhOMkVldnV5?=
 =?utf-8?B?RmltVEhhYkhQZ05iMDlpa2p3YVR2dzk3VTZJN2s3Q1lmVFEvaUJsalVmdGpD?=
 =?utf-8?B?Wk9aYnpET1kvemdCR0lkc2pQbXRVcWdXV25qcFd3MWJxdEpLeGZ2K1JiVkN0?=
 =?utf-8?B?MndTUlhYa2xkWUF2MiswV3dKcjRaaDdGQmkrV2RCSHB1TVVzY0V6U0NFemlX?=
 =?utf-8?B?eWMzQkxjTEFpeUJYeHV4WTVnc2RvYjlkRXhSaU9KcHhKbTFZY0JBclRjeUxK?=
 =?utf-8?B?dnJPSTh3eTZlTllJZ1o5b3hza1FjdnZSTWlGMTJhYUJra3d2UVU4dktQTGNz?=
 =?utf-8?B?YzdkZkFDM0pIbE9TNkdsMi9PUGhVbE9CaGtDYjEyT0FjVzNZV3ZUVksxU05E?=
 =?utf-8?B?U0dwTmpsQkJld1Y5TVNCRSs4MGhYOTlOUFJjZyt0T0VXeitodjdjN01vQzZo?=
 =?utf-8?B?dlJnZUFsQ3JtZURPZTJUQWtPbUV4b0NMWWxJQWNic1BhM0VFZndKWG5RMm5y?=
 =?utf-8?B?YTlsN1ZZd3dheW9aTy9LSCt2b3ViTGZ0S3k2MGI1dU9Md3lvSmJydXdvb2Yw?=
 =?utf-8?B?cTU0VFpROUhnODNwQlNmSWZwbjBzdUFaOGc1eEQ4ZS9XTXBVVWxiOGJxbFk4?=
 =?utf-8?B?b2RGNEt3c1pkeFBPQ3ZvSTZqSUNlNGNGWkt0VGRQVjcxQlpremZSa01jTFJ4?=
 =?utf-8?B?SnAvRFNLV0tRZHVSdDJhWDVvMVE5UWxmc0JlVjNCNWRBOC9GYzRSTTRVS3Bu?=
 =?utf-8?B?cmV1UjE5cENoWDYxaGFhVE1UeHN5WGhwRGN1ZTB0bFF2OEtpTnpsdE5Jdm5N?=
 =?utf-8?B?WTdDOFRzK01rUzl4R09iaEFGZFNueVJEeUdzWlNHNnZmY2MwcW1VbU8yN051?=
 =?utf-8?B?cmgrVWRQV2N4M2Z2N0pveUpOT1lWQ0FydlpyTHhmTWpaTW4vMWo5K0QzVjlE?=
 =?utf-8?B?OFdtbFRhc0loNmpTcmRGWHV6N1dFQTVyRGJJRGdTYVZVaE5tZzVnWStXY25S?=
 =?utf-8?B?QzhFSE5TTklrcVNRWTdEV2s2SW1WMHZnT0VWN2FtOEkrYVdhOENqeXVValo1?=
 =?utf-8?B?ZVlyRWU3UHljQjVFTC9mTWErWWhpVEgwSzBYclVadUMzNFRxTTEvVmhGTWhu?=
 =?utf-8?B?UkhmZml0S0dtREVUbmtMcGNJYUFZbDNSL3Jmc2NVVzBXYWFmOEZSZzhqVFZ2?=
 =?utf-8?B?T0YwWFNEeTIxd3drdVV3TE5VZnlKSmJIYUwySW9ZRjk3NkZ6SDJxV1B2T2ln?=
 =?utf-8?B?dExUMmxxMkxXRXVXNEVrOTl4LzZYMEN2cFpDSEhMMVZSYisybjl0VFI1a2h2?=
 =?utf-8?B?VEE1U0VMZWNyUUg1c0JDYlgzdXRSVVVZdGF5dzMzR2dnQ2pTTGFyRW5LV05V?=
 =?utf-8?B?dmhHSjhWWmgwMWpTbGJ1QVhrMXFHT0N3YWdLUEZDSHR1OU5FMmNxVjRtY2RU?=
 =?utf-8?B?RmQwbGdrVVBkOWU1NU5aczIyWFMxOGF4QTRaVHZrVVlSRytucEV5UUJYN1F6?=
 =?utf-8?B?ek8wUFIycCtwWndlSHFoVlFVNkU5TVNlcVYxd1dFSFQxNHJTeFBOR3pYcHZk?=
 =?utf-8?Q?KKs+jtzWACMPMaFRrKG1NpzVJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83981f6f-4a51-4622-5295-08dd98732f3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:24:24.0255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7djk6Cqp3vCFGtccWy/hwHjioCQLFzctEt2wiZTO9hGrie4WsNllEz/EYyFXenbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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



On 5/6/25 03:28, Naresh Kumar Ravulapalli wrote:
> FPGA configuration encounters failure when the cache is not flushed.
> Add cache flushing to the memory region that holds the FPGA
> configuration bitstream.
> 
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
> ---
>   drivers/fpga/intel_sdm_mb.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
> index 5fe4dbdfd32..a2f3b160a73 100644
> --- a/drivers/fpga/intel_sdm_mb.c
> +++ b/drivers/fpga/intel_sdm_mb.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Copyright (C) 2018 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>    */
>   
>   #include <altera.h>
> @@ -9,6 +10,8 @@
>   #include <watchdog.h>
>   #include <asm/arch/mailbox_s10.h>
>   #include <asm/arch/smc_api.h>
> +#include <asm/cache.h>
> +#include <cpu_func.h>
>   #include <linux/delay.h>
>   #include <linux/errno.h>
>   #include <linux/intel-smc.h>
> @@ -738,6 +741,8 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
>   
>   	debug("Invoking FPGA_CONFIG_START...\n");
>   
> +	flush_dcache_range((unsigned long)rbf_data, (unsigned long)(rbf_data + rbf_size));
> +
>   	ret = invoke_smc(INTEL_SIP_SMC_FPGA_CONFIG_START, &arg, 1, NULL, 0);
>   
>   	if (ret) {
> @@ -1023,6 +1028,8 @@ int intel_sdm_mb_load(Altera_desc *desc, const void *rbf_data, size_t rbf_size)
>   	u32 resp_len = 2;
>   	u32 resp_buf[2];
>   
> +	flush_dcache_range((unsigned long)rbf_data, (unsigned long)(rbf_data + rbf_size));
> +
>   	debug("Sending MBOX_RECONFIG...\n");
>   	ret = mbox_send_cmd(MBOX_ID_UBOOT, MBOX_RECONFIG, MBOX_CMD_DIRECT, 0,
>   			    NULL, 0, &resp_len, resp_buf);

Applied.
M
