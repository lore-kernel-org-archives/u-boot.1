Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9951C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA7882BCD;
	Wed, 18 Jun 2025 09:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GFHYDTmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1315D82BF6; Wed, 18 Jun 2025 09:16:05 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BDD82B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIY2Gf2LuyNMlMy8jhwH0D1tXYr5LBLvKqAVFixbq5zYvQsP95+t2aiZWJ6fzgDtMcR1GL2V6J+kJy9rCa1A2X/kC9JfLhMC2ihbganx5o0dn5rxow/1FuZWwgFu3X6Uk8RIiXs+CTLDskuneCitBOcPP/laQmLgw9Vzing/NUvRm/vEJDSxqHoLgDWIkoqyiDHuabLc4FG5af18uVvJDRLDbdED2QqWeOeCe6685GE+xV5+nUyakRFrFILEpbHIHZ9yQKGrBMmxK1CKKNaLIvBdHLMTgrd5hlO7nky0gs4irv1s3Uquoro0Aa+HDq5ZEqc0egEzjYwBz0uXihFTHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMkSLD/KdPs1n33404Qb60/iXjtunrcc0sP8R96KffI=;
 b=NudUsanQNUXCc9NBqycMcsCyuBlVZK3A9o1Kj1Z+jQG4284m7ocXq5ja1M09GxJQ+M/rfSB5yM4Kxs7V+Difg+452c3uHYkmcXDaRDKxVw/SAocsS0TvG2oqKaug9eWSOJdIFXOoZROH4N+asqOEBfKXjI1+wh9xL2IypmMy2qPIAV3h1Qv4lyAQZtZ2xW2Mwfk14TXVu0cdKSWoXLvDHJpdPQGXv4U4ThQiJr7LzbQiBKGyTWreUIYYPARMADMSMfBFm3lfAHS6cLqsfxlKJyk/m3p2+o+NUCloDAyZ07pjR9xbLafVlO74B/kX3v4CqgVFyPq+Yh9e4amJUpAA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMkSLD/KdPs1n33404Qb60/iXjtunrcc0sP8R96KffI=;
 b=GFHYDTmwCHgtQuU2nl5IxYKBkgcUgLudULC+VLnjDqjq9M6+ZInLy7wk5n/ca3fI3lpJuGE3TNUxUHYaa4PX/g5gtXyV8nRwWZlfVOHLgnDqaZ+717MYMBMMYVC9ZuDukZNfZJr8aOJ/LcxsTmcYm4+NQFAuOlP9HhgWPYL4wdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ5PPF7B9E98CB6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 07:15:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:15:58 +0000
Message-ID: <eb9be150-5298-4929-94e2-ace2f095eb84@amd.com>
Date: Wed, 18 Jun 2025 09:15:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Improve user feedback in case of FPGA bitstream load
 failure
To: vtpieter@gmail.com, Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>, u-boot@lists.denx.de
References: <20250617092333.335908-1-vtpieter@gmail.com>
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
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
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
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20250617092333.335908-1-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0105.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ5PPF7B9E98CB6:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5a7ff2-ad52-4d21-8750-08ddae37f913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3JwSkgyMnF5dXFScnZTa2tJbEJkK2t6N3RVREQ2RGFCdFNFSVh2T3Y5Njkw?=
 =?utf-8?B?cytkeE1RNllGbW9yaS9pOURrY0t4cDBrZEMxdUEyUVNGOEFPRWxzTXYzeS93?=
 =?utf-8?B?L09MODZKVWczemRBaDYyVHVjR1N3Y1lhTTRUeGhCaXdjTVk5UWkwVTBzOUdV?=
 =?utf-8?B?TnBGMlRyanYwQ3NRN2NSWkJCNEg1QktBRnhXVWErS1R5a1c3enNGU3dVMGYw?=
 =?utf-8?B?VkE0ZlFRTCtBQnN2NlhBY1g4elh4cEJLOEg2a3JYUlk1SjBSMVdreFNhVGZp?=
 =?utf-8?B?Z2hYQ3JYTDd1dDMyMzJXSHRMNkNBcStZTCtJdmJDRGhUNW1xQkFsei9nbFlu?=
 =?utf-8?B?U3ZXSzUxRkVNOW1GUkFRYXU3UU9Ub1JiTnpLTmVrMGNoYkx0MGFsdVhYVE90?=
 =?utf-8?B?NkdsNmVQdDRMVlIyRjBsbzJ3am1GRTJZS05KMWE0TTVjRjBMNkdJL1NqWTl3?=
 =?utf-8?B?ZklHSCt3dmRYVjdRRTFudDRXRjhBUGtqamdVUVZUODJLTURYWGx3cTRiVDJY?=
 =?utf-8?B?L3VTZWU3bTRzbVcyb3haWjhMM2ZpbVgxUnZVODYzOTMxS2hTVkVWMHpaYlRQ?=
 =?utf-8?B?eE9wS0dqZ1FKTENWK1l3ZmZpd2hrK0E1WEpLaXM1WWhUMkprdUhmV2FUVnZx?=
 =?utf-8?B?Q0pIc0l1ZWN3aUd4c2tUbkl3QlAxaWZva0cvY1BlZnJCRkt4QzdsSDNrQUhH?=
 =?utf-8?B?a3ZaRHpsL1cxSW9UNkc1TXluUVhkWTZLd3I3bThKS01vWnpTZTZCcVZhNXFC?=
 =?utf-8?B?SjkyZ1pxM09MQ0lUdElyNmYxODBNSlVpU3A0L1l0MDgraEVUbnY1N2JyY0RI?=
 =?utf-8?B?cHBJTklha1R3YjNFWGhObENsYSs5N2FVeEpoQ1NJQkZ1VjJmVEgzY0EvSzYx?=
 =?utf-8?B?RGFRZlg5WWJnUXRrZitQNS8rR1M1UVZNYnhCSzN3c21EcmJVYzFvNytweWZ3?=
 =?utf-8?B?RkJWV29tOVhhMS9abFlJa3lYcGgwYldzdysvUVhBb0JoSFBzRkduTFdwZ0FJ?=
 =?utf-8?B?N0VkYjczcXdEdmZTcmJSZktudlVuVU9ReFVDRkVJZ0VTOTI3Uml6R3ZhTEZS?=
 =?utf-8?B?VDNxVlJqeXFUNWsyNGNLeTdxSHlJOGdnR05MQXZoQy96SVNxcGFZdzA0NHFY?=
 =?utf-8?B?dTVJZU14Q1U1dGJ5M0lFY004R0d3dTdRYlBFRTlNbG5TWUFHUFFKcHdvSGpv?=
 =?utf-8?B?QVhMaW1MVXYvcjdLekVzaTVYbXJydVc0ZUNoanRScW81WWxWUnFGOU0rZHpL?=
 =?utf-8?B?MmN6NUpXTEQ4UWEvb1RGVXRSalpOVXZ0OERzc0R0aDFPaWJYYUNkVEphOFhT?=
 =?utf-8?B?dDVMaDN3L21ZUWhEeGwzajVGVVZJaUZQd01YMm00eE9Ld1hickllVEFqREJM?=
 =?utf-8?B?a1FMRkM5eDhKTStSVTBDaXAxM0YvRURVT0NvMVAwRU5ib0kvMFQyOExyTnhH?=
 =?utf-8?B?REJmRHJTNG4wS0t3N1N0VGZQVStGNE1lb3Q1eGdnN3VCSzVOZ0J2ZVZjYnJE?=
 =?utf-8?B?K0ZvSE11cDFBTWNPci9HdnhVTnQrbTQ4Vi9SUEkzWWlYY05aaG9lQmZwbVIw?=
 =?utf-8?B?Q1RmOXVNTHRUWitFY2p2WnN2Tkx1WURxOUo0N3QxL05kWE4rckloZkR4YnZO?=
 =?utf-8?B?bE1sVTNHVG81clZKS1IyU3lmQXpCbVlRbkNEQmhURHdIcTRBWW9MMFM3aXU2?=
 =?utf-8?B?QUdJbStPK0gxdERaRjZnNWpKanJqbTExbFQ1UkZrT2dROEd4dXBCcjFBZjYr?=
 =?utf-8?B?cmUrREl4cVZnVGR2SDBEbUxZYjlSVEZjWnJFR0h3SkRpUkhDVlRzNUhsREFC?=
 =?utf-8?B?M291WnA5WHVaMmFBbHdnNEE0eDZYbXlhaHg2VjFuR2hNNVJKWlc0MEZwbjI5?=
 =?utf-8?B?Y1ZBSjA2eWJtTHUzRGtJTHNmRWlpWDhGTnczQmI4MDBkajB3SnZDR0FxQWM3?=
 =?utf-8?Q?7tihljPldQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVKWHBuR2lkL3pGemxHUFEvWE1GY3g5UEw4Q1ZiRi91dmZJb2dxMXNSL05Q?=
 =?utf-8?B?ZldlclJyT0RVeEdUUG83WnYyUnBnZDJSK0NYSTErOVlHai80YzBNR1F3Mm1t?=
 =?utf-8?B?Z2tZU2pIWVRrMGhpbkhCSDl5Sm1uOC9OeElYK1hJQm9ML3RuNk5IRSs1TVJE?=
 =?utf-8?B?ZVJ1cEg5bUdpQ2swWlZsMk1QREFuNkVtMGFmNGxpMXNGaE5VQ3ZKdys2TmE5?=
 =?utf-8?B?N3NlSFRHN3VQRkxhbVRGNmo3UlBXWGk5OHhBRENhZ296ZHBzL0NtUzVDSEtM?=
 =?utf-8?B?ck1wd2lCblhaS1gyUVQvVXVBN3hMejluamNSdFA1NnlXeG1Cc2VleVZ3UXh3?=
 =?utf-8?B?dmNFYlpranQzOXdiT1hnQkZ2dnRhdXZtSDFob1pwS0lJbnpReVVwVHg1WCtt?=
 =?utf-8?B?WStRVU13OUo5Mlprb3VzbmEydW5XbHNLb2Q1bFJ6T2NPdVlUM1VPYmZ1ajFO?=
 =?utf-8?B?R28vRWJHTjg4RkMyRXpBRGc3Ni9NckQ2NUt4N0NSaytEZzFhcUNPNkxsVFlm?=
 =?utf-8?B?YXhNVEFZeFh0ZEJJU3J0NHhQSVQwekNtMFc0dkxNUENjRURWNzJUQStxWkEz?=
 =?utf-8?B?ek1NYVBuV0xWTnZZa0IrQXpkcmZsZ1RFdnZVTVZEMVZxSHVaUkMzRHFlenZV?=
 =?utf-8?B?a1FaTjdPUnFJYUkyZkpXTitSR25JQ2dlTU5Yb0ZFRUpoUEU5VkN6UDQvUk1a?=
 =?utf-8?B?U3NsTmprbWpZNjRNeDdwa1FvWSt4MVoyR2g3WXFCeEJ6TU9MOXFucjR4NUwz?=
 =?utf-8?B?U3I5QVJxN3ZxdUNPMjFveWpPTldzVWsrYzJCME0zR0VTbkh0UlkrVkp5blVF?=
 =?utf-8?B?anZ5bTdWRVh4eDBBdnBxZ3NDMXhWT2o3ZTdjaG9iQzA5MWZGMThrc2R6OTlm?=
 =?utf-8?B?SVdFYk1XQmZSdnA2RWF2OHh4R3B2N25SUzkxbVBsd1lkQXFxZkpRWkp4Yko0?=
 =?utf-8?B?bjYxY0NIVW5ldE1VRTYwcDBNN0F5OUU5RDFPSUtoaFR4OGZnREZ3V0ZKUVpT?=
 =?utf-8?B?VTgrR2haR1VQWUN5ZENRdGhYeEdIVnRIMDRNOWwrd2lscFMzWkUxS1J5UEVt?=
 =?utf-8?B?cER2Q3NzV1R4Z3djdG01MzI3ZDBnYlRjY09mbW1pVWJjUFNPQk02SHJ3Q0ll?=
 =?utf-8?B?STJvd3JMOG5Wd2FRcjBkTnNkUTI5QVZtOVd4NzBzV3JUZGdUNzN6RFhOZE5T?=
 =?utf-8?B?di9XYU90RUZmNU5zT0xNbDBzUUk0eXpRSXV1elNJY2ZBOUFFVmdoZHNrTWQ1?=
 =?utf-8?B?MEo0YitOQUs0SkZRM05kNDEwMGttR2w0MXJXRWdlOHl1cVFaRG5idHRnYVYy?=
 =?utf-8?B?QndSSTZoc2JOaTByUGZua1pLbkxEK1c3YTZwa0Jha041NzdTbXlqRjJDdU8v?=
 =?utf-8?B?OHRERXNrcU8rd0szZ1d6RkZMd0VTM3Q0eGI5dnkxbmxpYjA2T2Q2ZmZXbTB0?=
 =?utf-8?B?U05jRGZBZGQ4WWsxYUFXRkwxTGx6aXdRQ1ZDckpsRFV2eEZKbEEva3JmZ2h0?=
 =?utf-8?B?bHVNeGFIRFRyMjdvN0o1ekZIeXNDalV2UmNZdWh0b0U0K0IxK1dCc3RDTUtl?=
 =?utf-8?B?OEdzMk4rYVFIbkhuRXJLd2plS0pJWC82MUI2Szc0Z1M0Z0ZNWDd0cFp0TEhV?=
 =?utf-8?B?UzFqb3FLMjBaS3doTnRhRXRpUmVWeEVNcHVwOXdZREF0Mng3NWVpOHhzUXZ5?=
 =?utf-8?B?ZEZoWmhMV1UxSW1uejBTOUFvRHZ4dm1QTTd4NFJLV1hDajg1OUtRSWR3ekVm?=
 =?utf-8?B?UWZId1dNRnhEcHJ1Zm9ON2JGOWJVRDlzeGRsSHBHOUZIUEdUOWlYY3B5eDN3?=
 =?utf-8?B?T21oM2o3Z0hyTXRYUVQ3c0NuSmJzcUdvMmExQ1pPSkFiWmwzN2RTSFJVSHVz?=
 =?utf-8?B?clRIOHBaV1RkWWFjSFFlQXg3R0drNUtmU1MveTYwa3lKNDdpVTJQaUQwU0FX?=
 =?utf-8?B?N0U1WjQvYVJodS81Y2l2OCtCTUdqWVlLV2o4czNDVDA0U0hHb2ZOZ3NHdkt5?=
 =?utf-8?B?aGlPbDB5R0h3S282MnRMYVRueHNEUnNqQUl0MFRLOUlPc0JxNDlTZ3laeHpo?=
 =?utf-8?B?c1BuQ3Z2OFFJamp0dzJFQ0gyM3pFR3BjSlVpYUROZHJzeUdLUTNPTFBTQXk3?=
 =?utf-8?Q?H1VQxcyzeTltAVSxPm5Pk8PXO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5a7ff2-ad52-4d21-8750-08ddae37f913
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:15:58.3397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amcC7Olaaf/PXrDJiyF1Stk0hJp24q6vA/9ZKyjZcqMdMyqZUz/Mp/YyLriG91S2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7B9E98CB6
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



On 6/17/25 11:23, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> In fpga.c, change debug() calls to puts() for important user
> feedback. In zynqpl.c, change 'up to' to 'above' which corrects this
> confusing or wrong statement.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>   cmd/fpga.c            | 20 ++++++++++----------
>   drivers/fpga/zynqpl.c |  2 +-
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index 9dc7b63db5d..2c2a63524de 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -43,7 +43,7 @@ static int do_fpga_check_params(long *dev, long *fpga_data, size_t *data_size,
>   	debug("%s %d, %d\n", __func__, argc, cmdtp->maxargs);
>   
>   	if (argc != cmdtp->maxargs) {
> -		debug("fpga: incorrect parameters passed\n");
> +		puts("fpga: incorrect parameters passed\n");

I think all of these should be moved to log_err that you should be able to 
control verbosity.

Tom: I think this is where you want to go right?

Thanks,
Michal
