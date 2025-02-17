Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF82C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F4F809A4;
	Mon, 17 Feb 2025 15:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ut39F30r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1836C80BAD; Mon, 17 Feb 2025 15:34:55 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBE5807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj6jmrj8kvgrHkeXyqQSdd/4GXcxWbcrMZgkF2SAWlwU+Ja8DsbYSUgd0GFk//a8zdbACY6ihp00HcB0u1Hl7emLSuJIaOLSKZgyabBhhiCLFuSIoXAsBc/hMHuMs6aE71aGGR2s/WMhpXnMymoblBB0i7EJjuw3YSm7QjL+9Hpd4AD+JPuXCJpoQR6Le0WBAL/UGXsfEVrqPOiBNCSNAR7Dd2MNBG3WQ5Z8P2DOU0cIOEuXbZdeI1Cdjs/Narc8ca4ZRjkzraOLIyYFxXAfKlDS22SDN91UPrt7dGhPb/BUCzgfTyFqsVUtliu52TLLsruRgwY1roDaiQXAk5OIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsAjFHF//JFTDp7s3KVtojr8GoA3F+5En8X6AyoPJnk=;
 b=VWtY7O5Es9UqFtVa3c7pm3cAufLhebS2lNshmdAXr+XvGIeXPWewj1FUv57BnVVL7/Q+YKmVzV1f3Y+xuYVQMYGGqpv71b0X98pd564y4dgyv9hwwzahIsMBFGTST0ov0nVCWhSQNeDKcd1wFHsgZYto1Oimy8+DDFuZOvz7EyMdVuqsl47PIr1FTjxaVFvmZzNQ3yUJsNbVeHyVbnE0uEehPRpP+Nr8u9/uuCaDBO9ZYUWFv6nLzMtcLsgCTavDRwCZgVk7sh6E7aWz32fEDLZYg94NTeDZqojKUdv0kPkaQd8Jx0UQ0tayW1UlZm4ZY7bLOu1seuGImnBbXn/l3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsAjFHF//JFTDp7s3KVtojr8GoA3F+5En8X6AyoPJnk=;
 b=ut39F30rmUZVMzs86ds100+poc6EZO1AIHsE/Ta99IE+0+Hg0E9gFaht9yOsiL+4f0WR+N0E5E51MPuEz8JrxGbx+fhzzMmT6J4Zx9ubOPx2IRHgMQj4knnTYS8iwZZMNpM9ow36bQP0SLD+YFc53r0RYo9HHDcipylSisVWETc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:34:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:34:48 +0000
Message-ID: <6da03510-5f56-4897-843f-fdf89f846be2@amd.com>
Date: Mon, 17 Feb 2025 15:34:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Enable reset and power domain drivers
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250206110152.1532673-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
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
In-Reply-To: <20250206110152.1532673-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 63560b13-d266-490c-9162-08dd4f603af5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0J5bjFQeHJzSy9ob2FzYjdWVjVETXg4Y2J2aG9OMzRoWGJPN3EybFBCVlFK?=
 =?utf-8?B?d0luNTBrL0NyRlFNVTdFbDh1bEthRTg1RXVhZTlpelRVUElzSUx2T0VxQXc3?=
 =?utf-8?B?WEJlU1lRbDJLTlUxNGlDK3lDdmRDUmwvUFpJQU9hOSs5TjZGMENCM25FR0dF?=
 =?utf-8?B?QXQ5Vmo3ZnkxRHJVNk5qK1RQa2ZWeFA3VkpQTVZDMkZRWFFRdVo3VVNCd0hk?=
 =?utf-8?B?UWJ0bFlmRGt6ait4TThKVVlrZVFzV3RKekJxSytYdXQzVUNpeHdIdit5MTlJ?=
 =?utf-8?B?MHpKNmJsSU95eWthbW1PRE10STZHUGovMXM1OUM0NE5LQVFBSkE1QXJHdVlK?=
 =?utf-8?B?V0tITWkxMHVjbWw4UC9lbFFmTWdlREFmN2Y3RWE3MExscDh5VGszemV1RmZV?=
 =?utf-8?B?NlRtb3BaZGtuQllJWlBKanVTVDFDQWhUMDdMZmkvdDlVTzlLSHlXYXAzcVUy?=
 =?utf-8?B?R0lKcVZJbzJBNjlYY3pXdGJJS2lzSG5Gb3VTMmgzNEtJai9kcHBQeFdKdEhP?=
 =?utf-8?B?SGpXQ0VNWUl5MmFBZXpvMmJsc3JodVZSdy9adXUyWGJOVmRCT0hiQnpCVVBE?=
 =?utf-8?B?U0sxbkVYeDNLSTRNYjJ6QTFVdExkVlVkdzFGdndJcnQyakpBR3R5MkNPTDBD?=
 =?utf-8?B?V2dRM0RURTZXUVh2Q05UVGRpL2NVSWl0S2lFQ1ZrWUtLYUEzVFlPbG5vUW9Z?=
 =?utf-8?B?cjlyaDZ3a1VyTmFqVFRvMzUyZW41Z2hoYUFkc3Yyd3ZVU055bDAvWi9mejFo?=
 =?utf-8?B?bXhUUm5yYUI4TlBJVTlneGZGUjkyclFmeThiaVBpUkJiQjBIdUZjZHZUWkNB?=
 =?utf-8?B?cHNxM01pK2lXYldYSDk1UlZ4cjB4dGVuQlZybzdJWTVaNlFTVGI4a0NPbk96?=
 =?utf-8?B?L3lCekE3NFZOWFBPUnBxUHBtV1BtdjFMZWkyRTNBaVpvUzRWc1lSRnZnTWpk?=
 =?utf-8?B?SStxR2liVGRUeEp1bWlhNFVYOFZqRXl0cVVrSERWcnM5eFpVRUc5Y2lJbmxu?=
 =?utf-8?B?a0tjSHNTVHNicDV1SFd6OVp4U1IrQWE3SjVOUVBIWXN5TCtobXR4VmJBZzlU?=
 =?utf-8?B?QUVVUm1Jb0NmTDdOTE91QXY2cTJsOUE4QnFlR1dhOGgzSkF2bm9aNnZhUURK?=
 =?utf-8?B?VXl3NDdWeTlhV29QNVA0OEk3QkxFMU1zdFhsZkJ5eGNOQmhIdzQwUUNlQmlo?=
 =?utf-8?B?KzhBa0Z5bGZSY0phTWtHWCtlQVV5ajd3cmdmTlA2eS9rMUcrKytHSTdVVzBB?=
 =?utf-8?B?Nm5ybGRiT2JFbExBMG9YWDY5Y1dNVFVVOGxFczBsRGNZMTUyd3RZTGJWYzdH?=
 =?utf-8?B?YmtpZWI0SGNlbjJ3WDBKNXdNS0J0MGZFdU1sQVdlV0lPWG1QcUJvZWdRVjQ1?=
 =?utf-8?B?NW1iRGNja1Vwb1NiZDVWUFpsQlBOd1lJQ21aSjVvdHpnM1JnVDArVTVhOEdQ?=
 =?utf-8?B?YkpQc2RSYjdRSFdGRzRDdHc2d3ZpVFZmWEFCME9qeVJiNXdta3EvUWxzL1k2?=
 =?utf-8?B?ZFhjT0hrb29ESGMyRGJBeHNtNktmdlNSN3RqRzRnV2tTQkNWVDM3VVgzWDVm?=
 =?utf-8?B?dlVRQm1QR3FoNE1rYmxxMnBDUEFqWVVOMlpZMHFTWFhiVHlzRUl3Q04xZjEx?=
 =?utf-8?B?MnBjeHMzc25FWlpwOVNpWXNJckxhaDZuMGtETGpkWjVaZVU2VUQvOXI4Mlhl?=
 =?utf-8?B?cUpqMEp1Mno1cmpKRkJmaU40WTJDc2xCeEtWWVYvRXpJRkRObXQ2THFRZi9p?=
 =?utf-8?B?L2twOE50eVBuYUdGbmNNYTBzb1Vva200WHgvNEZ0R3crd1Z5U1ppSlVROU8x?=
 =?utf-8?B?U3JkWDRUN3lZVEJpeWN1ZG0rTkNOaUtxU09QWkIrRHZKYjF4Y2diMGlZV3BH?=
 =?utf-8?Q?bkvY2hqZK3mPH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0xkcGV1UUNqUWV3dWhHS1ByTkdYb1o3bUJaSzY5aWliNkZsenE4WkxtY3Fy?=
 =?utf-8?B?TGFMZVBtc254cy9pOWNuM3Y5c1oyVWF3cCthSlQ3SUo1cHZqNm1hd2tqZ0Fv?=
 =?utf-8?B?UkhyRW50eEU1czllY2tLa0hRVkVVU01SSk4xQ3VmcFNTenl0Z2Zyb2NqSWNB?=
 =?utf-8?B?aDQ2MHlQWU1KTU5SN3dMdXhoUWxzdVE4VWkvU0pYRzJ0bXpVdG5XN1N6d2Ny?=
 =?utf-8?B?ZkhpMG1HazJ2bGZiYi9IL3AxY09QNDNRc25aR09hY2hzdXlFd2JTd1Vta1Jj?=
 =?utf-8?B?cTlQSU9XWGRNUlhwSjl2MGNnUTVTSW83eWE0ejE4NFBhald1VkFlVTRQZFFH?=
 =?utf-8?B?ZGRDT0ZSdjhSTmdRTGJQY1FaNlJRYmc1N1JNeG5zODFEL3lxY0g2U056Smhn?=
 =?utf-8?B?clliWVc4WHJBT3hLVVdkOG82dk9NWEVvVVpId1o5SlRTc3AxYTFhaEJDV1Zt?=
 =?utf-8?B?NHhUM0J5WGdzV2FwdHBtOHN5NTUxV1I4Nk5lRUNrMGxITEZPWDNMbTQxNks0?=
 =?utf-8?B?S3AveHg3NHZudlA1ZlhKS2lmbCtBVzlmUjk5cEc1OFFaZlFrdUZzOWJUZlhh?=
 =?utf-8?B?SC8xdGhkU0d3ZjNQRkRBa2FFM1F3dWpFNE5SdHJLNEJ2MjM1aEJyQmVVcEMr?=
 =?utf-8?B?eUVwU3VpdTU1cS93c1gvL09WdmZycWxiRS9GejdLOWQwdHd1OEVIc29nQ29Y?=
 =?utf-8?B?VnplYjNBclBmMEFlZ09XcHIwQVQ1RkhTNnUySjNxMHphYUk3NytLcDl5cldo?=
 =?utf-8?B?YWk1Y3ppMTBBUkUyOHN4ajlHZHNmanFFNkVsSWphT1NGK0ZpZlFOUUpIcmND?=
 =?utf-8?B?bGdvdFJyTzh6dG1zeGNEWWZLR1dBNE9jSS9rczBrQWduSUc1Rjd4NVQzZ3dZ?=
 =?utf-8?B?Nm5TbUROZDQ1cDM0cUU3Y3ZxVmczZGVaeGNMM0ltazZjVGpkS2lUUzhjZ3lB?=
 =?utf-8?B?YzlnTHhCeGZLUVd0N1JwMmVzU0k0VDV3VGtNRXpkYzc5emx0aWpIaUc3RlpB?=
 =?utf-8?B?TVZob3NaU2cxdjBiV2QyZU51S2Q5L3AySERLMjZyUXM0ZWJqV3lmdkVnQ0Vv?=
 =?utf-8?B?czdBcFJpdXBUcHNvWS94N2txVk5UQlN1dTVQd2N4QVRqdm1BVUxONkF3QmEw?=
 =?utf-8?B?Zm9lYmxubmkvRUg3bmlvV0EwaGMxSkI5NzNCSkgyOTdpZVVFU0Z4enhENUhU?=
 =?utf-8?B?R01qdytwVFZHUFgzSHkrK0xMeFZHVkZ5aXc1a2tYY3MvMFdvbXpYWVh6d2dY?=
 =?utf-8?B?NjFoYXhWZkF2bk1qdmcxbU1PUEJZZXBvcnhlbjBDc09SUk9jWDZyQytjNTMx?=
 =?utf-8?B?eFVZWW9GNXY3bFpWSUpZbEJoUm5EcXFnaWVYN2tZN3kvMHgySDhnQWZidVph?=
 =?utf-8?B?Sm1KQVdmYUE2UEwyOHVjUTdoenJUMEdrN2dXcjJ2NXEwUGVMdVhVRTZHYkhj?=
 =?utf-8?B?b3lBdENuUjdzWTVIV2I5S2VuTFZYSDhYUFE5a2dXaU1zSzl4L0hmeXpJMEhC?=
 =?utf-8?B?dDRWSmtyZlQvOHJpOTFZamlUU3RMc0YyZmtlckVrOGQ2UnVRemJJMzhSQTNO?=
 =?utf-8?B?VDh1RTBaZWU5L2pWUE1CRG05R0xaTGRKdjA2UHg3N0lCc0wxR3RWbmVlajBG?=
 =?utf-8?B?OTB5TjB4ampnUjU1R1kxSVFjYmxwRkJZd2YvbzF4UHdkRU4zQUxxWHNzelZp?=
 =?utf-8?B?V3BwMW5Bd2xzN3ptUHp3Y2trYXdnL203bE0waUhjYVIvS3dlVkRqUWNMSGpl?=
 =?utf-8?B?cUYzU0dxSjZoQTNiUzVOdHRZdllKeiszYUtFQVNPNVRWdTBNekovcE01Tmgy?=
 =?utf-8?B?V211dzN3VWNnVXR3ZzZsRGJTZVg3ak5nVzFqVlJRMUFUV0k2ZGNiNWRrZkN1?=
 =?utf-8?B?QUVMVkJrRm9EUk1ubVhTUFA5U3JJcGYzNXZZTXprQWIxd2RUNDRIU3dMQ2tv?=
 =?utf-8?B?cEZGUFRPQ0h2dkUva1BmVG95T25nSzB4QWhnYVNyRVhmUUwyNFRxcFN1N3FU?=
 =?utf-8?B?YjBPS05jbUN3dGo1MXhFN1Jid0Q3Nkg4WXlTeHd2WmNpK3krcWRBbHB2M0Ez?=
 =?utf-8?B?M1hHYy9pVS90d1VRdzRrMTlWaHlLQ2k0ZWJJM2VhT2Z6TTk0dmhuTGFIZ3NP?=
 =?utf-8?Q?V1B6waAKCh7eO71j6Br2CoGE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63560b13-d266-490c-9162-08dd4f603af5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:34:48.1999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFX6Vg6r3UoH7L0t0FHe2vjjE+wtO9xb2vbwsBsrz/Q2kT1tEYtUgGSKUiObyG/u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 2/6/25 12:01, Venkatesh Yadav Abbarapu wrote:
> Enable power domain driver to request node for all the IP's that are
> enabled in DT. Add CONFIG_RESET_ZYNQMP config in versal2 default
> configuration to enable support for reset driver for versal2
> platform.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index b4aebf3e9fb..b907ed02615 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -115,7 +115,9 @@ CONFIG_PHY_GIGE=y
>   CONFIG_XILINX_AXIEMAC=y
>   CONFIG_ZYNQ_GEM=y
>   CONFIG_POWER_DOMAIN=y
> +CONFIG_ZYNQMP_POWER_DOMAIN=y
>   CONFIG_RESET_SCMI=y
> +CONFIG_RESET_ZYNQMP=y
>   CONFIG_SCSI=y
>   CONFIG_DEBUG_UART_PL011=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y

Applied.
M
