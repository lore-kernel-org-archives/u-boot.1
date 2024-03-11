Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D57CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2250887E13;
	Mon, 11 Mar 2024 16:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y8k3KBBr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E6A87DD5; Mon, 11 Mar 2024 16:14:21 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD31F87EDB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEA89DbtiKZGwEuI4p8Xh1Of25e8SOHTx8qfYzrO9+JlR9Br3ET9cNP/q8UrlNTTYKGX97AD9U+lVxlxxFNDqAjwGy0Vv8BnZ5Bpamb6350VMU1lpy+NIah+y57Vy/BC/Npcfb/c8jru/UkTo5eS2tZ5Z5mpOHNaoFGmSmsBny90QFZ0COBakIUbCOOiS3l6VcjmOHlKqzFPSYEoMt8ONZdch5s41t+7m8HEWiA0JMAzc2nSleeaKH3T1Yz+jpaUJfJy2V5qPUwDaNAs+UA3l5QmXsqcU+D03mcaHkAeLaY7y4Pr375tzAl6FlZ7oajELereEqcZzIKQlvE3jCWdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+iuW0RDBUTbt0qHeocRLBwsD9QIgt3TeJsDwHyhqEs=;
 b=ngyMSQlIThjtjgFvKb11ukXn407uHvEDoNJ3WSBmTIw/SkHQo/3WH1+XZuoCABKkbM/6CSRVqVEl6zFFi3UnCdB4Vy5xq1bIQ9wz6WLTQDv+/vadz5UJJEKRaJNHD4l4eORWXfyYsy+G0aBjYSOR7f4NoTs53FARx5TcYdUT6euWgaL/L4xxoDGu9y65iaynoB0HcRfQhYJWF9Sm7nM7dZBhpdZTEoYfjy81/FBtQ6bmo742Ky210bObtB6iaCev8qmbl8XcNyNHApyFuqm2vLqOwH1WdG84kzBiIylHjX4dTbeOue1bAgXBRFNo0Mp24BOpjZfSi8EHfpdYK5gCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+iuW0RDBUTbt0qHeocRLBwsD9QIgt3TeJsDwHyhqEs=;
 b=Y8k3KBBrWikpHCsdY8m41y+86N8FX4ZqIfFFInxoPwQgYfHkjCp021DpB1ZYTgWs8WgojFR2NgzS2Ov/0E4zWhBfCOFNeBuCEQFooS6JvpqqX6oAmxwGCSraXtmrrmQAcGZQCTM06iPQ6LaWuG311osRuq0AWB6XTmMOzIH4m1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 15:14:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:14:09 +0000
Message-ID: <3c44793c-a557-40e5-b367-15619e9d03f2@amd.com>
Date: Mon, 11 Mar 2024 16:14:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] test/py: reset: Add a test for reset command
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>
References: <c11e1809-b5d1-46cd-a5c8-a5276b83f26f@amd.com>
 <c523aabd-93a4-f9db-2726-7f912a85aef0@kernel-space.org>
 <20240307001053.GE1523872@bill-the-cat>
 <c05a25ca-d4b7-1179-cf46-645bc4cdba89@kernel-space.org>
 <c0bbe63d-adee-456f-bcf8-44579aa2593a@amd.com>
 <20240307125525.GF1523872@bill-the-cat>
 <553992bb-c159-d9b9-6e9d-b762ea55da79@kernel-space.org>
 <cf96e2a6-9e49-4058-8bfc-f31b3d028190@amd.com>
 <20240311143938.GV1523872@bill-the-cat>
 <9e3f916a-7e5b-4ec8-abe4-c2cead1df557@amd.com>
 <20240311150908.GX1523872@bill-the-cat>
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
In-Reply-To: <20240311150908.GX1523872@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f4d6b9-c2db-4147-e249-08dc41dde6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUv6as5gJdwHvi1aa/F4zyDzQd2W/WJ68aBE6LNsyTJV65oM8OUGL/wwnfTs1ymukefI87bZ92sVdiUnxK+m0rLz3VUpY0ZQcp+S9uOmGDiIj2zOx0BRNIB2k8sCBr7HoCJVafw++DFXDlIewi3+JfVvpomm1gfC0M1g36DuMSDfuNPCBqrJBvobpCtRuAAa6uRg2iSQCi1S9i12GldKQNWeMnyX71P1yTTRh4vg76WqWGu+i2r3mR+wq1+UjO8gH/BKLibWdEHWLW6iZceyGL1BX9TXZqmyxYHYcaZStZvVOre0DoUEBieNbxsyYcKpJ1Ydkc2JD61RzNmJ6bZ6att1MvFdmQ1dxc7siz9AWoLiSybeMFpyqT4yKJOXrb11L8cvRxxsDrUALoWTpeEoHtF4BUjYQWFzS6pb50xFcjoiWJixNUXV/bUt6GAtmV8lGz830wWAqsgAVv+RWRzHVYpTU89VR433ZKfduXNNR0FY9/R0YKGK3pwSxDGsp+F5MDOEMESxfLXUxbwypg0zAzmFW6lURiZbXggaf2vqcj2WebcE1amfiu3wAo+bKnN3a4x0XQCG8h9SVKwsSIWJt2rVnYWt85RAMvNXQ4A6+vFI5hbAN0CuJVEQc81aK42sDSG4/OXQhINMv0mZlqX3n3sEjDoxJ/+aKkW1oIdgXkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hQQVhFbG4zV1IzU2FrVkVjQVFPejZwRWVTdVJMMXFrdDNTd2xmTHJpUTVX?=
 =?utf-8?B?a0xIWkhJYUg0Sk1OWXcxeWFRMHo5QWZoZEozNHR1cVlqR2hXeCs2VHcrQjVD?=
 =?utf-8?B?eVJhY1VuNDNrbWk4dndVT3drRm9ocEExZmh2ZFAxbUUydERyZXpYbG8xVkJ5?=
 =?utf-8?B?WGtGVFdJNVI3M2JyUFgvQ0p4Ync4V3hCc2xZTVZKTzZwYVQ3ek5GWjQrVmdT?=
 =?utf-8?B?WDdxajFwOEF4UldoeVdreE1WbEl6S2p4N1hZU3YySnNybHlPeExBS0puQjho?=
 =?utf-8?B?Unl5SjlNV1FnWmIweTlMaVNDWHZiY2lHTXRWd0JTcDV6Rk5TMWM3WmIxV0NB?=
 =?utf-8?B?QTdQTU5KS29GcEgwbUt6TFRCaGtvaFJzbnZnQ3RqREJHUkI1WDYzcjVnVTdy?=
 =?utf-8?B?VnRoVzk2M1dsNXZESWtLR3FFd1dTdlR3bk52YTFUdkgyZ2w3YU9DaGRqZk5D?=
 =?utf-8?B?VDFxNndlMndKcExUenlnTzZ2bWtBN01BOWxYT2F2ODNZVTNWUHZNWXZqTGth?=
 =?utf-8?B?eURZRmdPTkJSVDJnUnczYmhMTlZrd1hubHhqblJqT1h3RXBJa0VWK0dWS0l2?=
 =?utf-8?B?YXZrY1dqZWlTMTBaTjhGUVdVV211N3QxS0FGbDhYWHUwV2E5UWJ1ZG5BT2xK?=
 =?utf-8?B?anVDWk10cXJUOWd5U3V6M1E5cExwQlJtanphSTUwR3ppYUxGRGs1SUJ0SVBH?=
 =?utf-8?B?eWFSZ3BLQnNIQ1NDYjdDOXdXd3B1NTY2N29Ick5Qbk1GRmRQclFURWZjOXla?=
 =?utf-8?B?aU1LNThJTW1QZDNJcmVqMU4xNVEzV3hmWnVBaTc4QnFQcVFCVEZFQ28xbWR1?=
 =?utf-8?B?Q2V3djFwZGdIWVJObFFwbjg1OG1kRk9XcjVSTTJvUEpPVmtmT1VBYWN5eVZL?=
 =?utf-8?B?TWl6VFJWZUErWXNBUzZyNTZoZmxMdWN4V3NUblpjaVIzWHBnbGJzeXBzbFdt?=
 =?utf-8?B?dGd1TzBUMnVUaXY2UkdSbU1HaGttTGdyQi9kZlpRQVpRdDBBdTFvcGpFUzJB?=
 =?utf-8?B?d1JFalZTN0Q3UUtsUDM0OGN1VkpkcU5TTDZFTkpnWGVZV0FEU2s1SERidmlC?=
 =?utf-8?B?R292WC9zTWgwc1FpWDZxTnd0SEpuQ0pRazdOTC9Benp3b0IzOENjaWZiMFRH?=
 =?utf-8?B?QkRzdmt3U1NtOHgrNWdLY3lzd3BlNyttK3JNK1VlVklhcE9NRzQ5aERhbDVs?=
 =?utf-8?B?aDR1UncwM1NWZmJGeHpib2ZCd1lqNDBQMDlkNGtwUldXaVpKTmx4elhsMHlC?=
 =?utf-8?B?Q0VwVHovUlhGRzFOb0RpUDc4LzJhOFJHNVBtRkdZK0IzK3ZRYXBCUTcrcUpo?=
 =?utf-8?B?MXlJT21uTlpvK0tjL2lmQnQ0cXlsSGxLcENBUDB2SHFBTDFFeGFkYXhxZzU2?=
 =?utf-8?B?VXdDaVpqcHljd3Z1OEZqVElEUURWcWF4emYxRXJmK003RytXZkRHZWZlOE5h?=
 =?utf-8?B?WXo0KzNUWXY1ancrVXI0aXIwM295c3o0ZnJTNUlOQnhNU3hmTUFJN0ZheDVM?=
 =?utf-8?B?OWNwWFZPNWo1Mk5yVEhHN2tPWVpyQUNtN0UyN29QQk9HMXhLeHNxY05TUEVs?=
 =?utf-8?B?TWV4bDV2czRmRVNpTkFuSktsd2srWUFqeVllSThpVG5mZ3NLeThNVjdXOFJX?=
 =?utf-8?B?ajRCQm1ISC9pZ29LMWtkOEc3TytyTFFDYmV3KytVdXU5R3g3MGJVZDM4ZlZO?=
 =?utf-8?B?eERZVWNxV3Mwc052OHBvZURUY3lsRlF1cElrckZScmR0MDY0S1MzSlFYUWZo?=
 =?utf-8?B?aE5qT0NyRUE4NXg4TWlHa2VoVkhLRHRLZ0dsSHRxNlZzVVp4WlY2SGZyNEo3?=
 =?utf-8?B?U1ZlN1ZkRG5BaHBvRUtpdXl2aXFJWkpkREZNZHExRWtlNVExd2hlVHIwNk0r?=
 =?utf-8?B?WnJ3dWV3K2pBVkFoZTMyVUJmeElpQWl5OVRCUG93Ynk2aDg4alNldmV0N2Jw?=
 =?utf-8?B?MDFoSGhFZGJlbDZ0enJjME41ZTFsRFdqaXJGdXdyd055VERtQlZUYVJPWHBN?=
 =?utf-8?B?V3lVc2ZDanlRZDhrTEhSaFZKL05qUTNYUnVGNDgyb1NsNjkxUkJiRWdCenpp?=
 =?utf-8?B?eUtrbDVtTTF0ZnBuME9paW9EVnJCREtnSVhwYndBeVJuaDl3cm1ycjVadENE?=
 =?utf-8?Q?G+QCHeDBmdHqNFbbFdLmDoBmj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4d6b9-c2db-4147-e249-08dc41dde6cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:14:09.6356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXVGGgLDGALptUGhRkgSxvRHylURfG3PcVA7W/gU1Dngax/X846TepbB9Bbpt0p6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
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



On 3/11/24 16:09, Tom Rini wrote:
> On Mon, Mar 11, 2024 at 03:52:57PM +0100, Michal Simek wrote:
>>
>>
>> On 3/11/24 15:39, Tom Rini wrote:
>>> On Mon, Mar 11, 2024 at 02:40:59PM +0530, Love Kumar wrote:
>>>> Hi,
>>>>
>>>> On 11/03/24 2:11 pm, Angelo Dureghello wrote:
>>>>> Hi,
>>>>>
>>>>> jfyi,
>>>>>
>>>>> reset support added in qemu
>>>>> merged as commit d3c79c3974.
>>>>>
>>>>> Regards,
>>>>> angelo
>>>>>
>>>> The other issue was with echo commands:
>>>> => echo $modeboot
>>>> $modeboot
>>>>
>>>> => echo $?
>>>> $?
>>>>
>>>> Does HUSH shell is enabled by default for this?
>>>
>>> It is not, so at least the saveenv test needs to depend on HUSH_PARSER
>>> too.
>>
>> Based on logs on this platform echo $? doesn't return any value.
>> There is any config for it which is not enabled for this platform.
>> Do you know which Kconfig symbol it is?
>>
>> Depending on HUSH is likely big hammer but I was not able to find that exact
>> Kconfig symbol just for $?
> 
> Well, if we don't have the hush parser we have a much more limited
> parser enabled and I bet that's why (I think there's no variable
> expansion).

ok. Then this test should be limited to HUSH too based on how it is written.
I think it should be okish limitation and if someone wants to test it on systems 
without HUSH enabled it should just update it. If is fine for you?

Thanks,
Michal

