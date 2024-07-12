Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4FDC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 07:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03924885EB;
	Fri, 12 Jul 2024 09:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PyzqPnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B4C8870D; Fri, 12 Jul 2024 09:59:14 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0B987FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnsTDFdrYDo4FFO6R3VFocsFNtdc4UFb2UdDZYyONh30/BjOJMHW9X2U2frso9BSxQYPi5Sbd2PGY1XggKBgOwkfmGcrYMmAnLI7L3rcItuyzW1d9LGLwH4rtq0NWFmay/boEeTFyP/WX5CONmf353+OAmmPkG0cqIrg2IhG3jrsZQQH5csJp2dcHqwOVWCbaHtmCzo0CAk4Js9Hk/QX9Kkd/N7wGDEsIBa4Ow2tR3ofk7W0KsesalJnqSo9HxhFfF7W26cuoE7yr5cRiobYcisXpXQ4yYSTMEJtkSwnN27xNLcaXWEP9eJzFhIjCRylSVkfHtEulZGi93jxUmmOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ3X4V8doYKUfLzhPsVi05ghti9soX+Zt6Nn61iMtiA=;
 b=y+v2Pv3+vhKxZawcjfYzX9srrp6n29gcVZgU/GzKaxcxlQBkVVZ/g1eWJSdKIHpD/vY7Ov58ilqU1OnS+SVvk9vOe6Tw+Tl7pC71tNpJEKUmyIsu5QPCkysOgrRuPOYk0Suf7sajlJwqNsIs8lvAOC8oEA8EQgC4a21rnElvGU4KdU9wJ+RIgL5u/Rtl+Ip2U4M+CCsLX/DC6PgprGNYQyZaCPkWkq9MKR8/4YL9y0JNHMzZA0tj/hLEZyLs0dspoZ7vXl5AAwPJNCrLjiaA5LR7QRbvGZ//f5WASGalWlMiNLB0AJkSH7TCKrvUvpbu1/QF1yVE2Wb8z86IgXE4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ3X4V8doYKUfLzhPsVi05ghti9soX+Zt6Nn61iMtiA=;
 b=2PyzqPnLA8gYQkzdFb5P5tyJQ04+5cLHJtroPh90WFF1e+KvHVYH+/1dt/qSR6HVxHP4xhyOiKEP83LzQex3arW1lnbwFjHQn4ZWKrlBMtPsfRzQ9JMag+lO1Lt74hOGcLJe8LDBbCyaBB2YWdBECsMF0bM4QuNc39UJN4oKmQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 07:59:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:59:08 +0000
Message-ID: <c10e25ed-5b67-46e1-b5c3-5772a42071fc@amd.com>
Date: Fri, 12 Jul 2024 09:58:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amd: Enable the NFS command for Versal Gen 2
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, git@xilinx.com, jagan@amarulasolutions.com,
 n-francis@ti.com, d-gole@ti.com
References: <20240711165734.1561933-1-prasad.kummari@amd.com>
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
In-Reply-To: <20240711165734.1561933-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 42736cf9-7938-46e2-269e-08dca24881c6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXZxam1rOURJRHVzd2UxWFVlcERVRmdaTFlkTUFmdC9yRDByMkRzZDBzeFRi?=
 =?utf-8?B?UDZzWTdvYnl0dTdDVFUvSit6ZzAwU2hhTHhvTmVxdUorL3ZOQmx4c2docHhO?=
 =?utf-8?B?SXovR01iZ2tFTVhYZ1ZqUm55bTdlT2pXZVlJenlaVWcrcmpienh3OE1zb1lW?=
 =?utf-8?B?V1BMamFPT0lha1NUaGE2M3ZudjFaSFdITXpVNzRwVnFoWlp3U05tYXZxQXpk?=
 =?utf-8?B?L05ObHBRYURGYkcyRE95MldSSTlRNUZvRFF2M1lOdXpBcUtPTk1wRTdDcGRE?=
 =?utf-8?B?VXVTRnMzSGlQbWtMTnZOc2lDeTBJSGZGRjRhV0oremNhU1N2RHEzWDBPWElq?=
 =?utf-8?B?dUo3RndpUU81dXRjQnBSMFNTa3hIYjRJcTZJYTdUekRocWJpd1Y1Vmk0eVVD?=
 =?utf-8?B?V3A5RTkrdVVzNlVNTFpoZlR0L09ac1VDeHFYZkc2R3NnSExCY2FUQkhHKzd0?=
 =?utf-8?B?WDVabEFqTERteWJjK3ZHbTBCQ3FiWUhmcVpOdzZ6VXpjS1pldVh2OVNVbUtY?=
 =?utf-8?B?VGg5elh4cHp0eW5oZjB5OHg5NGRkdFEvTHZLNzluY0xQZkM0RDVmek1TZ0tQ?=
 =?utf-8?B?R2UrRVBiTjBkTHQ1MnJLME83RlE4SFFtZm96K0liSmt3QTYzbFpGanQ2K2pq?=
 =?utf-8?B?cXZEOGI3WU5ESTg0UnRXR1JNZFhRdG5pa0N2VitDMlhpbmdqWHZsTXB6SHNW?=
 =?utf-8?B?Q2RIZGdaaTlOV0NQUURMMlhZSXZaM3dLT3g3UndIWVlENWpjd25ZZTFBTGxy?=
 =?utf-8?B?a0JXbUVnVEJFYUw5bFhjRnNKQ2NLbTF5OEo4NFFjdVRIMmQ0MEJwbDJwUEQ5?=
 =?utf-8?B?Z3U2WVpucE5yMlNKRVk2UjNuaFFWVThjVFVGYnZnTEg4UFVlQi9OWkFYa29R?=
 =?utf-8?B?enhuSXp3NGx1aG1hNllSWko0K0sxUmJGOE9LbXIzeGc3VXRqUmVocis3MElt?=
 =?utf-8?B?MnJuQll2cDRBRlB1cnhzZFluZnRWb29KNk1SYVNWd1JqTEFZdUhYMlFpK0dw?=
 =?utf-8?B?ckUxVlF5QzhobFlsM0VzWDZweDJ1ektPR0ZuZVlYQWFsSVZ3UWVja0lrc1F1?=
 =?utf-8?B?S0xjaHdlWWI0WUMxYm5TalR3VmRLZWl3eHp5YlVXUHpBRnhjMTQwQ2NjcFlT?=
 =?utf-8?B?WURFTHJ0d3NHdGRuUEdLTjZBVmJ4aG9WRUtUMUIyajYvTHRDRE9hUDNpbG5D?=
 =?utf-8?B?WGRXL0x4QTFMUFZnb0ZtK296WU56T2p5amlUWFQ3cWdOVjBqeVorSWVWK1E4?=
 =?utf-8?B?RmV3TWdlQnArV1AxTDB5NVhLeS9oZ2EwWFZrRC9FQ1AyVUNkY3RPekY3MnE4?=
 =?utf-8?B?eEgxakZBbjZYZm9hUVFUWVpxamhNaTNBUHliN2JvZ3ZjM1J0bWdKQ1BxOUVx?=
 =?utf-8?B?b1U4Q0FHTzIvT3VDUC8wZTVNYmJsR2RMTHhtZUZTbDVMakEwUnVEMlRQcDJB?=
 =?utf-8?B?cW1QOHpGQXF3V0tBSko5Y1ZxMzdsWDdwa3l1eVVOR2FYeDl1V2RDQ3FWNGc4?=
 =?utf-8?B?bWFhLzJHL011dnVuQXZsWXppaGJnZ3cyM29RQlBnU1RmU0lWUXhzVkEwQTYw?=
 =?utf-8?B?V1VubkFHSjlKaTlJY0hzS2VuRE51YVRCNDl5WFhGM3l2V1BJRlFEUXZ1NXY4?=
 =?utf-8?B?RmpQSVJCb2lSR0plWEk0d3Rid01DSGxnemNGcTAyOXdWRmhDbUttYXpHUEUr?=
 =?utf-8?B?NTZjNUR0eVpkelZZUTZmdk5ZVWlPTFhYQWE0MEt1MExMbzZVNExyYy9jUUF5?=
 =?utf-8?B?RDc1K3NrNjhqVW5pb2h4cjdNYjRzUFlJYWpmQnNxMEtwUFEvY1ZVdUtSeGx4?=
 =?utf-8?B?T3dXalBxd1ZZWjVpZFlndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmhUL3M2WTJ1VWRMcWl1MVFmanNSdExoam1HSkoxN09TQU8xN2RCWjB4dG85?=
 =?utf-8?B?d1Zwd0VSWmRKdlJyUnlQeHFSZzRpQWNSYVdqeDhmZVBiblFoYXA3RngwRWtX?=
 =?utf-8?B?NlljakdGNk54aWd4VENDRGZQK2NZd3lyN1FNT3lOZXdkNVVzckJmOHo5RjJK?=
 =?utf-8?B?OHpVOWFRWElWZ1pySU54ZzF4NkZNNk5FSkltOFJpYUczMXQvMlF3RUErWHRo?=
 =?utf-8?B?MjhyUWpscm01cExxZkIwelNyelR0Z0tCOUpLbk90N2Nlb0JvQk9paGw5am1O?=
 =?utf-8?B?OEdCUjRrTDhyZjZiRDBBM1o0VUEzSVlSZUdDYmdicXVJUExYbVRwSEx4N0Fy?=
 =?utf-8?B?N1pQQ3FJa0c4UHRUcXdxRzFramVzcUxXdGRKam9Mc0t6QXc4UDZ1NlFSNTIy?=
 =?utf-8?B?dHRNNGVleFQwekN3dUxGM0RtdXhRaTVsMitkL3JzbEJEeTNha2FZN2l1YUwz?=
 =?utf-8?B?a3lsUGZ3bW9zZzlIVFluK242c1hTaVF2YzJteVFhVEJzQkVuSGpDTm5jekNI?=
 =?utf-8?B?dmZxQTdTc3RXQzc3SUowQ2lSSDJ1V1JFUUdEOUxqellEckxpMXRxaWF2WWZC?=
 =?utf-8?B?YUgrRzErU0d1ZkdwMTkrTE5FWXdUVGdDRy9zaHl3WDhnMHZEYUp6SXVMeGlD?=
 =?utf-8?B?dlIrM2lzbmRyaFlXN0pYcnVBTFpKcTh6NVIvR1ZsemxoZ0Y0R1RyNGI3alZT?=
 =?utf-8?B?NkxkdUg0c1lETG5mbnBiUHR0MXM1ZnhvQmFHR3paWUpwWUs4aDFrVUtWZkJC?=
 =?utf-8?B?VE4yQ2drMlpzcDRBOVBaZHhzWU5kcUpyeHhIT2o0TTduU3pjelNvN1hqQUpU?=
 =?utf-8?B?MFQ2NWhnNm9SaFhCVWJ3VGo5WTR0V1JiVTVDVDNkK21IaHprRklKN2pNdXBU?=
 =?utf-8?B?U1p5U1dULzB6a0VZUFpFaEkzZnNnbWlCRkx2amN1VnFtZy9WT2pmbXFCdTNE?=
 =?utf-8?B?Nzl4UUtFdVFlZUtiNkJWZE43Vk5HR0htY2IrTGo4WE1OWHVCdkF2RFdvRU1v?=
 =?utf-8?B?WFBDcmkxNnJEYkw2eHdBQnJaSlVBejBYOVd3bmlhY3g2RjZVWVRueVhkUVI3?=
 =?utf-8?B?RWZnbFZ3U3lMMzRVcGNRM2xYSUpMMWo5Vms4RnRWSStRUUZ5R29UWGhzSjBh?=
 =?utf-8?B?RStZOXZjQ01oTXhGMU5RV0tyMmR2SVkzUGlVYUhtRlUxTkViVFl1UTU3Y3c1?=
 =?utf-8?B?THJqbGROR0Z6NkcrWnladjF5VFZxVmlNVjR2NUhyTzlTRE95VW9pZjBqTjdZ?=
 =?utf-8?B?aEFXRTdUdStic1F0OVlxN2dlUWJ2Z1hKb1I0VlRKMEtoRU5ldkUzd0lVQytS?=
 =?utf-8?B?ZklKbXBQdDZHRjF1bEJOOHBUZE9Sb0Z3Uk1jTWVOOUpkYjJhVW14RStjU1dv?=
 =?utf-8?B?dmthVzFzZmFVdTRtMjRna3lNd2JjNDhWQ0drVWdrbDFOc0lxUE40Nm5HQTNr?=
 =?utf-8?B?SjMwaFVvRXhWcFM5REpLSS9JTWVtSkkvaWYwbFozSGRGU25IaUpJZm1odzE2?=
 =?utf-8?B?TU5JMVNxYWo2RlNHVmZtelZ1TGRReU0wMFlXRzhLQWRydVRvZ0V6ZlRYZFZF?=
 =?utf-8?B?cUhhdDhCZEpveGw3N1FKdDQ5SDVYdlUwS1ExOEc2ZWY0Y2VGeVI2SnNvRHRt?=
 =?utf-8?B?WVgwZmo4cHprOWV1enJ0c094ejB4YzZLSTdPbnRBL3hFMFRmMXgyWHJLWHR5?=
 =?utf-8?B?SWVYY3NlblkrRUFKdDM4SWwxbzRVeGg3RkRJMVhhOUM2MS9KR280KytLZEc2?=
 =?utf-8?B?bVJHN2pCcWJLdmVFNXRNc3JyRlFqdW01MkRVMlI1RThXWnl2SG5xbkZWTXVs?=
 =?utf-8?B?UDRaTFFYdU1YSzNzb0NvN3NJUkN2SXdxYWZ5clBSS2xPNDlTR3NyT3FNSXFS?=
 =?utf-8?B?ZzJZSU80RHhzM2h0V1hudms1UENlVkZWcDVMNXp5ZTJvcFNZdUpSUzVyRmkz?=
 =?utf-8?B?ZjViT1N2RnZnMHJxSUtUbmZzODNVYXlUZlFpWGcwRGpPTHpkaTd0ZWtNSHBQ?=
 =?utf-8?B?KzF0VHdZMWJvTzlVVWg1dkt4bE9scFp1MEtkK2dMbUJJeHJzRjllak9vYUUx?=
 =?utf-8?B?MFBBaXJ6a21rRENycWZrUzJTY2UvR0h0Q1BqSk85Z0I1WVR0ajYrSHRzRjJP?=
 =?utf-8?Q?tBKNRSA8TveqIHbz5lOm+OLMQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42736cf9-7938-46e2-269e-08dca24881c6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:59:08.0784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vc2FYRjyHmztpXDcJlNM6amlkEN/6NXs7YhoFSBVBX9dBNKolreukDVlRAevOwfv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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



On 7/11/24 18:57, Prasad Kummari wrote:
> Enabled the default utilization of the NFS command on Versal Gen 2
> platform to facilitate booting images through the network using
> the NFS protocol
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
> Changes in v2:
> - corrected commit description.
> 
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 2d611f84cd..bbe7db4fb3 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -46,6 +46,7 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_MAY_FAIL=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_TFTPPUT=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y

Applied.
M
