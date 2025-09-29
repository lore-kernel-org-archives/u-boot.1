Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C10CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D146C8319C;
	Mon, 29 Sep 2025 08:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ozFv62SN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5833831D6; Mon, 29 Sep 2025 08:53:31 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 040788317B
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THvRDdBdu9Y14UyJvTN+hJFsY8dmQzizgbUL+gYZn+AhY6xjhL3AL2XBFhAhwWrcZQzsvOevoxaXQperBzjzeo90ov7dKujoQttHk0j2YxnbthfLuZfQXVNi3OAhG8fGHsHOellEUhJfrPwYp/09uy6Z+uRtBYPoHSpuyT4ih7OPrUwlAlAX8Rt5UypqNadvzRGkY/3jaLhvkzZ/oP9XtaBYmlRRnQAmsn6z/2nq9zyjO5jfSIfQWE5aUELLoSRUdZyRAdKAMcWoJvEh53eOrCICIHVJxNweU3iQ3jEfzAtGFqdL66sckNYy491fUIXtfzHv2a4Gep+4Wnol9Lj36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl8zuxWieSA6uhIWBVvpViMsdUyvkRx+/ensmaI/pjA=;
 b=UjtznsXYHK6WAxjpsBG8SIgJ7MugNhkQTvZYDYN6CRTlSWj7jsNbGFzpuOAlbvufZjTgIUy2yRy16oIGgDtLJbcyNL2Bw4kiH6GaEPSDRPqGMbux1vtbJvYYPxBNLW3TpGv/SWplPZ7SzvGWBTtOKVZ6MKssbarFau5bst2OlzTRAh343fsMr8x+aMTsxmec5Z3cgY0MgnuaLM2E4IC/8EEJ8bk9dZzq5DGpN4QOxBG+rPGomO+jOH9COs+yLNQJMRroKcuxagVeUftwVa9U5SZ1w99xaDrn+zv/O71MB/ll1Uh+E10yYZvXtQNypwbognBiZA5xtIRSPLDiMOnMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl8zuxWieSA6uhIWBVvpViMsdUyvkRx+/ensmaI/pjA=;
 b=ozFv62SNiJ1g2CBsoYiP8sD19ABp17B8Tix0s3SCpzHY9HbDY1Lit6/9up2K4vz2chP+FFbz1kvLrlXdymUrKvSbMvHbLhUWNU1uoXeKYCX8zTJhVcNLAB6d0hScyqUxNgTuOrHH8mCvimnTUKrmZw52nHbnDiRR0jyLlQEvxdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 06:53:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 06:53:22 +0000
Message-ID: <460f7845-d70d-4315-9c17-c35cfc14613a@amd.com>
Date: Mon, 29 Sep 2025 08:53:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] env: spi: Fix gd->env_valid for the first write
To: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, git@amd.com, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
 <e05c9282-1736-4056-97b7-939b913dbfd4@mailbox.org>
 <acc7b448-f459-437d-a231-8bbf689f2195@freeshell.de>
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
In-Reply-To: <acc7b448-f459-437d-a231-8bbf689f2195@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:1::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8213255b-f149-45b3-2b05-08ddff24e157
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2VNZUVzTUY1U2JFcDVPSE0vU0VQTG5vY1ZFUnQ0eWxKWnlmODk3ZFVkQkRQ?=
 =?utf-8?B?ZWNORGl5OEN1VWR1QXYrN2dIcHgrWFA5YnVkK3NOZGloUXVNRys3bHFORUVu?=
 =?utf-8?B?WS9pOTY4cWJlZGpwTlQwaEpqWFRMYTR3TVMxRFlJbXJCUVRCcWVaVWNOWUFP?=
 =?utf-8?B?NzE2dU0xQ2Y5b29odGI5b1k0aHR1Ni9HMjlVOGZtbHhLYWlSaVlCK3V1Rndl?=
 =?utf-8?B?ZmlWMnBabnJ3UW40Tnl5dDNKWnFTSGptL1Vhd1cyOGRUbC9XUGgxVExKT09l?=
 =?utf-8?B?NzNTTXJOa3puR0ZUbWJmeTVDRDdHaWdoczMyZzlVVUMxK2JYekVEZHYzRTla?=
 =?utf-8?B?SmFkWjM4ZDlta1lEYUpybjlSemJHNmdkb1hvbGF2L2thbHdwS0FUMDluTXVK?=
 =?utf-8?B?c2ZQK0x2L3RxL0pjamlwSkdsWjhJT05vT3FIQWpkQStlazFBaXdrdFZSNWw3?=
 =?utf-8?B?QlQ2aTJGbWZWbmZDSUJQY05Sb2lSOVR3THNnVDdzNW45czRzTkVTWGZ1WUFM?=
 =?utf-8?B?SWZoUW5Ud1hiMzN4Q0NBdXpGaisxblBVNGJoV3ZGUUNlUzc2RzlBUTNyWEdT?=
 =?utf-8?B?bk9zMjNtUmtwbVRKc1RSRkkvL21YZmZPM05UeDgwUzhVamQ5ZzNiYTc3dGNE?=
 =?utf-8?B?M2NRV2Yza1RIdFJPbUo5ei9ZVVlpeGZIeW1RNm9sUWZmYVBra2lWWkZCTmla?=
 =?utf-8?B?UHYvR2Y0NVVsSUlBbTRsdUxkaWI2Q3RQaDRjWVdiNi8xWEFmeXBVZE9NSHBp?=
 =?utf-8?B?R0g1eXpOelhBd1hDMjlUem9PYUZhbzdjSWplbnNTRlhXSVpOWDVzRHplVXVp?=
 =?utf-8?B?NXF5bzdvTFVjTFovYlMxaENHY3VueGUyd2JYdXJnbnpTQ3JCeEdPVGlQV2Q2?=
 =?utf-8?B?MGROcUhuQ0doMDNpL1ZPTlE3OGtyUXk5a21RZEh3MnNUNmdxZXliSi9uTU5T?=
 =?utf-8?B?dE0xSlFoTjZkMEZIY1dQRkZvQmFHdEszU1dyeWNwOEtVZkUwZ2ZxYWgvRUpH?=
 =?utf-8?B?bnhsbi90WGpOT1BHNTB3Y0kvb1ZJc2Y4NEpydmZCSTNUVks1d0NYVXJWc2ZF?=
 =?utf-8?B?YkZCZGdHWi90SERnVmhqSXdDUitmR1lzK1FtbVpYUXdSRGpqOUwvQ0I4QytJ?=
 =?utf-8?B?NDI5OEJCdkxOK0lJaWN6MXlXekUvQXZnbytjdEc5OEdSNi8xZUNMSmxNcTlH?=
 =?utf-8?B?eGoxKzEvNkZVWklkekRHVVZ3U1c2cE80Y0xXM1JRN1hKWG9HS3gvMklVTFhL?=
 =?utf-8?B?cnBxbmlOZ1NkTmlhMU5vMFpIQmtrYVFCRzRaR0pmNnlJa09ITXpIMXlXcjFR?=
 =?utf-8?B?YWRPcS9UTWprRzNNQjdOTDBDdlhoS21GVVdmKzdHKzgrNUx0QWJVNTNabFJU?=
 =?utf-8?B?dWE3Rks5YmF3V0hRREVIeWpVMStNbXp2aC9UY0tVWk1nNVZkMzk0ZkgwU0hl?=
 =?utf-8?B?VzBtMkVsWVF6a003WENWQUQ0OFVQWnZmT0lXbkZoZEs4bnEvWmI3QUwzbWhF?=
 =?utf-8?B?T09SVXhRWVE3UjhWZWQ4VlVaNlRLcG5OcFNLOFZ2ZjFvRXMwQ2RNWHNpbXdC?=
 =?utf-8?B?ZkRjT3B1QjNSZXpiK0dyeVpQa0ZiemkxL0VVMTBLSk5lN0RZbWVMTU5BcFBG?=
 =?utf-8?B?WHRlY3NrVWlhMk9qUmo5VUNNZjNkWjQ5MTl0NHhVS1Z2TlRTMUtUNzFXQjlB?=
 =?utf-8?B?SVJLUFNaNW5vLzRGekJtd1BhQzNXdHRoK3BVbGVRLzVhUzdrOFdtaGFRdy9y?=
 =?utf-8?B?WmwvcWdXOWM3Sk5FQmtCMlJJNWl3N2pHQVJYV2haNnZaNlJBa0l6Z1lpdHRl?=
 =?utf-8?B?RGdQei91M1NtOGZpUk51dXFqbjY2ZjVJV3RHL21HTHlUTDA1L2tKQnpIaGlt?=
 =?utf-8?B?VGFJbUNBZTQ4U0N2OE5RRlMrTXpxb284S2RKTjBZd2pYOFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxKVUowNFR5YU11Vmt2clowb3E2eHZwaDNySlpqQmR6RHJPYzhtMkJMR1dF?=
 =?utf-8?B?ZnI5RyswK3hJeHVqdWpmODJ4R21JUytqdmZ0SVNtREhWOElCY3E1dU1icFp4?=
 =?utf-8?B?M1Rsd0xRQWowN1V5L3VlRDNWeS94TythYTYxbDRWdS93QUFVMjJoclhtZ0Zw?=
 =?utf-8?B?cnB5MWNNZUVJa2lzaVQzUWtjam1xK25KaVRRNGtFdTZKdzVVaXdoTFdqUEdH?=
 =?utf-8?B?RzRPZm85QVMyaFJPU3Rjb3VBZ0pTVkVhU1RnZVMzejNBb2hBSkNsaGJTRWlO?=
 =?utf-8?B?UmNnMUtOSDRjQlZaU1lTZElZZTZxeWJ4OVIrYXZTaEFkVFNoOVMrcDBXQlFn?=
 =?utf-8?B?T2JZYitkOGVuNDBvSjZXOXYxcWNjNlRZUjN4aVdsNEFWZ0hCdzREWmc4bmNu?=
 =?utf-8?B?TUNkVG5KYjhVT0ROc2RrZzhoaG9yUy9jWGxjQmJNb3RramVqb2NjNFZxZnEr?=
 =?utf-8?B?WnhCRHhic21CZjJkeTRleEpGWWovek9abWNOL1JRUC9vRzBBWXZKakVSeEdz?=
 =?utf-8?B?NjBZQjAxcGQwVEZVRDJJUmVrZFBqcThnR05xTWJ5ckw3QU5yNkpVVTJOZ0dD?=
 =?utf-8?B?VVBBMmJneERsZHN3NDJpSXhHK0RYV282MHAxOWVoa3NPaXcxaHMrK0hhVXdI?=
 =?utf-8?B?eWp3eHVONGJDenRQajJxYTBxdVdzWThYeHM1dzJ4ZnRVUmRkbHFxQ1FOa3BB?=
 =?utf-8?B?ZEg2TlkweHpLZDVEWFljVWErTGZzbmdzdkdua0oyWTdxOTBSamY4TFR6UzlK?=
 =?utf-8?B?eHc2Z0ZtWjBuSCtjeDd6QWFyRWxhQXc1UW5YTGtsazVxVm55ZU5wVlFuMVVW?=
 =?utf-8?B?cTV4aUNlN3JUcmw1bHY0Q1MydUkyTjBCMmdIQzdVd2d2akdiLzEvRXZJYWRn?=
 =?utf-8?B?VkZQS3RBWlRvOVhiWFl1VWVqbWpoV3JaR01YaDNadDVsT3Q5TXVFSjhJQnEw?=
 =?utf-8?B?U3ZWcSsxVXZubDlXYmpMUWs1VTdFK3VRMTI2VXhoMUVwdnBOQ3pGdFRhaDhF?=
 =?utf-8?B?M00wTllQZHgwcWxENFEvdnhsTU1sUHJwNCt2MHM5UTQzMlRvSFBNa3Yzcmdq?=
 =?utf-8?B?WVFDYWlFRnpha1d1cFdwV1lObVZRb3M2Sy9UZUlpNzl0ZlpqbnNMb1FKOW14?=
 =?utf-8?B?SUpUek90QW1aNjNHY0N0eFNZYjJKc21TK3RBZnRtZFAzUmZla3VkT2UyWGtN?=
 =?utf-8?B?YlUyZlB2V0JQV3lwZk9TVlVUSWIxd1lBVFdJREcvNW9vSWZKcUduTUplODFv?=
 =?utf-8?B?cnZIRnViWHhneU9XdzF0TjZ1aFhFbkJFUnlicnlSY2FDbEdETFhQWElUQVps?=
 =?utf-8?B?eVZYZG9DNUJ6bGNHbTBONFY1Vncyd04vTEVpMVJpRUlFTWtRcEVFVzZGSm1v?=
 =?utf-8?B?VnBhRnRyYjRmQVJkRDE3czdQaUZ6eHhuc2VQVnJlS1NETmpqNU5oZFdIMGFR?=
 =?utf-8?B?TnJjWFRGNDZKb3czV2RTbnhUaTJZYzhTaHVyWHdxQ3VPREE2RmFFR2RNaGF1?=
 =?utf-8?B?Wld2STVPZmNrYnpqcWJOWGY1ODB2TkNMazRDU0hZejNoRERyeklqSEJpck9y?=
 =?utf-8?B?ZDNhODZBUnlrWkZ2WXQ4cElnUVFXZGdwbHFYZDFETDhnRjhEdHhjcTBQREhN?=
 =?utf-8?B?TlpvUXV5enk4UWZjZ0tEd3dOWnhMT08rQWFoT0RTN2RrbE80bitjbmhaSzlL?=
 =?utf-8?B?ZHpmeGpNd2hNSDRWd1lGUjlla1czazF5VGx2WFNVdml6eVlmaEtzcXhubm1l?=
 =?utf-8?B?NFE4UTlNbGs3L2xTYnN1TWI5VlFWeis5bDMwVE5tYU92Vi9zYTZmWmhyRG5E?=
 =?utf-8?B?TDBDL2MzdW9LVHExbkZFc0pnZ3pYRFVIcXBJbjJaOW5UbWZhQ0o2ak5HUk5s?=
 =?utf-8?B?V1R1SkJ1b3NYUHpUcHlVYytlb1g0RVFqNnhVSGl0MTlSWEp3OE9iS3hxYUdQ?=
 =?utf-8?B?aWFHY1UwUUZVWk05ZFBOMFlWU2VDTVpDWjRkSVZoRmJwcFNrTGQ5VUZlOWth?=
 =?utf-8?B?ZXBmWWpBL2pzR3JNZ0h2TFF2NW1KbFZGZVU0MGc2NnQ3VkN0dk4vbHpjTGtH?=
 =?utf-8?B?dHUyZU0rUE1RS1p1aHYxTTI4cE5lY3MrZlBKQ3o5L0pZVDk4MTQ4c3hiWHRo?=
 =?utf-8?Q?H/tBvURDpiWeMf8t/OImtr7Y2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8213255b-f149-45b3-2b05-08ddff24e157
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:53:22.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8k1ZFOmBB4jcbBtrFGLjE1ixEINcISbTtRGEaToNfb4xmOmJfxOub7pHNjxaBhM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
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



On 9/23/25 23:23, E Shattow wrote:
> 
> On 9/22/25 11:47, Marek Vasut wrote:
>> On 9/22/25 6:03 PM, Michal Simek wrote:
>>> When both SPI environment locations are invalid (gd->env_valid ==
>>> ENV_INVALID), the first call to saveenv writes to the primary location
>>> and
>>> sets the active flag. However, the logic for updating gd->env_valid
>>> incorrectly sets it to ENV_REDUND, which does not match the actual
>>> location
>>> written. This causes the first two writes to target the same location,
>>> and
>>> alternation only begins after the second write.
>>>
>>> Update the logic to alternate gd->env_valid based on whether the last
>>> write
>>> was to the primary or redundant location, ensuring the first write sets
>>> ENV_VALID and subsequent writes alternate as expected. This aligns
>>> env_valid with the actual storage location and fixes the alternation
>>> sequence from the first write.
>>>
>>> With this change, the "Valid environment" printout correctly reflects the
>>> active location after each save, and the alternation between primary and
>>> redundant locations works as intended from the start.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>
>> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
> 
> Comments from
> https://lore.kernel.org/u-boot/e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de/T/#m114473aa0a28a08b150aef2dbed028200472fdf2
> linked here.  Nits about the grammar overloading of "alternation" which
> could be improved.

Obviously I am not native speaker that's why any suggestion will be great.
And let me comment v2.

M
