Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA27BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F4780568;
	Mon,  3 Feb 2025 10:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qj7PQ++5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2D45805E7; Mon,  3 Feb 2025 10:11:17 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A80801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEj2cfcpYFcBMeyc32fb8SWV9xxe5NLfDMNQbAhSOfLCxfgUJsR4XFUIKm/xLQ/TafJxYngnOBvqiPsUo3nE2sDWSiZ+2cQoTa+14b3WoDq0b7uiegacu0HiT25btUHa+Z65c6K1bMI+TaP2UmW0eB6hi1e3ZQE6By82kGkXwjj81sO0Xnax+KcVfzIa6iCxQ7Ho68wmO8hbxcCO4D0Wm0BkdtzQBWnzDgnzm7Bdcvgor016/12JxqGgN5Ykfi2Ij7ptqZALbAPQNdCaZPQH2cqvLVeeOD9B5ZNi2VmBuld97MCB2uWXFvus7pae7UqHjS80Ea47jiOX2KGo5uYr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAQ1rb1Zc9Wobjir4lh88YFvLezPm0XzPpdWVpZDRT4=;
 b=hCj/H2Q8tvvTlGXB3+yvvL8teK82qcGctf5zpR1ha6K3uZKcACAEHQRZJO9Y+TO6oF5LOfJmpEK/CnRb/KQZgDZ7muvdLE+vmQBQpBZWw/TxL7TWq4PKC9jqqf4LXRXHYjmxYLOGG6nA3CV0O3J1d1MkHzGtszBkBFfazpGWv1HZ4rO/21j5/ZllRbhF/3Dzx7PnByMqkQrtewbCcbV6OIf6I4JEC9FslQFIseR83k//ifsGHMkjidDVUUiyuZacZ6m+0MgavvBrjnjYMg6ox6IP4YIB0eJ+1GtfkZ9QjSgOhArIuG4MyEWidZIcNZ4wtKgg00qOZqNkAF+MIjKycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAQ1rb1Zc9Wobjir4lh88YFvLezPm0XzPpdWVpZDRT4=;
 b=Qj7PQ++5/gHX86iWuj9F0hfDB4pA1I4w61DFp1romfbfmY2cw+ld7RHALMUMwCGUgw9YwGdrRUmNwSVcnM2Zjzx1sj+Vlw0jFffhJzZMyr9erRRjYXaVHlcH84rbmk7eUf+M65WifXTbheZ31lUu6480Av08sH2WO17K7szsdbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 09:11:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:11:12 +0000
Message-ID: <589a9471-b47c-4d41-a12b-16e9d9ba84c3@amd.com>
Date: Mon, 3 Feb 2025 10:11:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe ethernet controllers via aliases
 on SOM
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vishal Sagar <vishal.sagar@amd.com>
References: <6d360e71a0530d201578e27a6997dbd472772e39.1737466907.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6d360e71a0530d201578e27a6997dbd472772e39.1737466907.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::10) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bcc9aa-bf5d-4123-a7e7-08dd4432b423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mm8zamJiVWQxOGRHanZYWUlBdTZsWm5LK21IdzJlZ2N1ZS9KVDNvMEdJTVlK?=
 =?utf-8?B?TjBqSU5kWGpZRWlYSENpS2l5ckF4czlqOVpLWFBFVW1FcTFaNWJUdkZ2SWVQ?=
 =?utf-8?B?VElTbjV6cDJBbkE4aWMxOWQ1cXBDM29pdkxWMDhpMjUwZnVjaEcrWXlHZmtN?=
 =?utf-8?B?Tk45U0VuZ0FEbEdPNkJWNldBd2hBWUZSSGI0WEp6RzcxdURuV1E0UnFmaUtz?=
 =?utf-8?B?a3FBN3JSckZaczVhdkF6UzcxNmpFV3I0ZXFyQzVZU2RNRS9xRjN3V0pVbnRw?=
 =?utf-8?B?dWd6WUxMWGw4QXEzY0FoUTJwS3Y0cVJtK1p5QVJRVk5XTXJpeVZ6VG1QMHM2?=
 =?utf-8?B?UHdqUXFTbVRtRG9qR2hLSUU2SlQwWmxJdG8waUZlTnFVVnJVSDhWWGxkNXJH?=
 =?utf-8?B?WTQ0SGh6V3JKaGpIck10b0Nmemc0cEtrL00rTFhSL3c5NGNyeGR6Y0tUNFda?=
 =?utf-8?B?S2xHdStIbWt3cDdtM2VBRW5IQi9oZWMvZ3A2eXp5T1U3ay9yYUFvM0hUQm8y?=
 =?utf-8?B?ZEZ6UCtkR0VGam1yUTByeE01YnplL1NwOXhKclRadnZsRlhJK1RhMEUzNXdm?=
 =?utf-8?B?OVdaNTFuc1dGaUhWTFQ4TWFTRVZJazlOWi80dDNlZkdIZzNyWDhnWjR5Tmsz?=
 =?utf-8?B?YVFZSnlEWnNjTFFTSThFdWRIbVc5TFd1VU5UTzFiT3hJdkM5QU9hLzhKbmRu?=
 =?utf-8?B?RWVtYi9LTnhlNkxVbkgrNU9FTGRBcnNQYkdSVTdvaXFFbGJHVWk0VWdZcDRN?=
 =?utf-8?B?c09Kc25vcWdkYmVSLzlLS0c0eDJuOW5wYXN5K2ZOV25BQzZJTUpTbmpQbmNK?=
 =?utf-8?B?Y0cwS2xkeUFlM0hBOE02Y1V0ZmdZdE1lVWJsbWlIcEJNZnZNc3ZpSnZzRnRh?=
 =?utf-8?B?WmVwQ1Bzc2kvaUFTL0x5TWJYM2xmWHlpUW5zTkE5Ymg4RHZma1VPRWpIVVk2?=
 =?utf-8?B?NEZuUXVINUVMNHUrMGNzUnhkelJRTFVVbFhhTHdtczFjSHU4UnY3UVR3bTMr?=
 =?utf-8?B?SWgrL3RaZFM3SWhtNzNJbG5URzN6ZFJwNGxZd2FrTXJqSEtGUWI3amZMWVBI?=
 =?utf-8?B?TEl0RFo5bm5CWmdJcUt2cy9mUlJzWkhKUE8vd3BLUy9RZ25UclFaVDFBNWoy?=
 =?utf-8?B?K0JWenE4RTlpUWhXWXdBNkp6bVpLMUZnOU5KV1poUVlPcGRoMG1oZTg3eS9t?=
 =?utf-8?B?R2x2YjNjLzFjMFd3WTJodjlEWldwaGhSVVpJb0dtaC82SWpPWFpkNDdoUXM1?=
 =?utf-8?B?OWMzQk1IY0JCdXdsTERnMHI4M0lLZWhlMkNOS1lZOWhqUXd2MHJYQ3QxRUE3?=
 =?utf-8?B?UnBINnFxZFNJTHBJM2xKc25rN2NyaDdqaFc4aGxyUkh2RStwZjM1VVFuREZk?=
 =?utf-8?B?SUpSOVd2ZFJpai9UMVZ3Y0lONWtGZm1GMHBIN0ozcisvR05DQ0ltRCtidGxv?=
 =?utf-8?B?MlQzN0MyYVRidnhsUlZnU1YzMnUrTkRCZVJaZ0FoZEYwTm9OdENUVnNiOE5S?=
 =?utf-8?B?Wit6VGR5YjNUek94T3BMeEtRVk10ditqYUpoNGpzMWM5NEY4Wk1RT3JSSVpj?=
 =?utf-8?B?OUpXci9vbUx4djFZaC9hWXJxV3laYVYyV3RKY3N5UHM3Zm0xUlJleUE4VnVv?=
 =?utf-8?B?UTN3aW0rYm9ESTZ6QVd6YitVRTYxWHJOSXRJaWdGNk5PdVQzSnR2R1FrZDcw?=
 =?utf-8?B?c3B0RlBPL25kMkZyRm5yRFVweS9RNlNpYm1mMlpJRGFNZXZMc0ljOVpRV1lQ?=
 =?utf-8?B?dFZMUjRVY1JVZkxPbC9Sa3FybnNYRzNaUWNTMEFPR0piekY3MjJpTWxUeE1B?=
 =?utf-8?B?UmFOK0haQnpNOUpWWUJSMTFJYm1jaFJMUG81Y0Y1NTFjKzQ3czcvamFBa1pT?=
 =?utf-8?Q?JClpfmCKhgQhX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlSY3krQXFnWUsxT2pYaE5rd3ArcVgzcjJDSzE1R3lVc2R4elVVV0JWTktp?=
 =?utf-8?B?bGw0dmFEV1R5N1ZLUGsxNm9sTGVjWnF2MXlEbWQ5QUxrSWh2RmdMRFkzdkkr?=
 =?utf-8?B?cGsxRGlrWFl4OFZYc1hVMHlPZnUySFhoT2FYNCtiMHhiNmZnMWtRN2dRR1hZ?=
 =?utf-8?B?T2NiUVF2Mi94bTFucFlybnZ4L0JlaUpZeVNGYktlejhFWG85U2FkN21UbFY0?=
 =?utf-8?B?SkkrUmNpN0h5eklmaFVhZXErUi92NWd5V1NoUUp6OUVFUk5RZVMyN3BobUV6?=
 =?utf-8?B?TUlWeDdSaWhQd1VNeWE3a2ZXaEQ2aFJzMmVKSXFQSEFvdVRISm8vMzE2MTF6?=
 =?utf-8?B?M3E0UGxQK2gyU3NQeVozelJjbnJKZzAxdlhIVHpNbm82RTZTQklKRTZ5Snpn?=
 =?utf-8?B?a2NUMWcvK01qYm1MQWV4SlduaEpnaDUyTmZWUHlydGVJdkdwbW9sMXhVUFlE?=
 =?utf-8?B?ZTdCNHhraW4xc0ZTQnFqSVA0RmlqSmpTR3VSazBLVWVzQmZHZFBkNHZBZDEz?=
 =?utf-8?B?REdvSDc1R2FqZWNkMHdMRit1NS9URXJFNkJnaDYramxvUG1XdXQzTFVhb2JF?=
 =?utf-8?B?bkZZYnNyUkJkVWNrSWZPRFdwVFBNT3FJWVNsWGdxdFppWS9PQkw0YXN5ZTd2?=
 =?utf-8?B?RU9hWUNRWm1YK1FZc0VjS092WURSMXZzTE5hUUVDQ2l3N05BRkg0eGE0RHI0?=
 =?utf-8?B?eDV1cGRFTkMzdXJIN3M0QWQ1dUc2TGNmdXZOQnFQM2VBUVFLb1NkQkpvb2VL?=
 =?utf-8?B?N0xRajlSLzVXWW40OEdzVE1XUnZuVVQ5aXY1RGJNVjZrbjJpOTkxbFRabXYw?=
 =?utf-8?B?S0Zaanl2RlU1MElyck1PNkxIZHozOStlVmtsRmc0QTM1ZWZFWnJtK1lvSEtr?=
 =?utf-8?B?bzA4c3lDb25BeW5IRTlzd1M4VXVJYXRDQzNBdFJFQ3BMUGhnV3dPVzNMM1k1?=
 =?utf-8?B?c3J1akU1T05GbXczeGc1bmloSGUrN1J2NUZFbUFTS0thaHRscnoxTG1pN3JQ?=
 =?utf-8?B?Vnh5cmo3ZHFQamh6bkNKYzdhc0JCc1FBRUFjbDYvVWxMdlFlV3hQMThUNmhr?=
 =?utf-8?B?aHNFcDVNaVdiMmlNZFdZQ2VuaHg3THdCOW1sY1hXcmJlZnY1YVZaWUpwSkVq?=
 =?utf-8?B?cEJRWi92anZhWm44TnpzbWoxVEljZzFPVDVrdDg4bWFYV3ZVZ2FBWHdpS2JZ?=
 =?utf-8?B?MGl2dGxUTzFBdGNQM2FMWEJIOUQ3a29DeWNwQnVGNmlRR2MrSnRLY041UE4x?=
 =?utf-8?B?cGd6cWkzMTdyL0RTL2VHOFFKWDE1ZFdjSTl2Wmhubnd3VnYzVlM0Tm5pZVNi?=
 =?utf-8?B?dlh3bXh0eHpHYkRqUFBFM3NJN3JTelMxQXJ2L25ocFMyRG1UNXJXRjNBcHMz?=
 =?utf-8?B?MHQwL2RJL0VvNGE5Wkt6eW0xeDd1cDRuaENaWStvNzMwS2I0Y3AvdEZLbEQ2?=
 =?utf-8?B?VGZadmRQRUQ0a3NUN05tUlk4UVkzZFhudXUweUpzTlVia1k5c0Uxa0JudFJJ?=
 =?utf-8?B?NXJJaUVhUmVEWnVtZEdVbW9IS2Y1eUxXU3gvWkVrWkJyczFwcTdTOEZVUzBq?=
 =?utf-8?B?UHA4bjR5MXlRYVRpOUNWRUk3NUFRQ2JhUlQrWnd6V3REYjA2UGFpelFVTElr?=
 =?utf-8?B?d1hJVERQeUsyUnlZQnRPdVRVbXZNWjZueGNYY1hlV29NbWxGNzBjOGJCU1N5?=
 =?utf-8?B?ZnZCNFdNdTJwNW8yeVFscXdxTGZzY0pZTTcxZkVEMmZDYkFDNURYOHdaVUk2?=
 =?utf-8?B?Si8yZ3FiZk5MSjdEeG1mWEFveHVjbWZCRHhXRm8wNHc3QWkzSTB0a2FZWVVK?=
 =?utf-8?B?V3NhUmpsSFBQaUlIR1Z3bHhFczNMOFBjU0IzUWpvUzhJU21KcjlpQ2MvNDJp?=
 =?utf-8?B?QjZBTHJ6TlU4WXNRaXlxTGNGNnBIZlExV09kb3RvMGx6KzZlVlFtUHVpZ2Yw?=
 =?utf-8?B?ZGxWK0Y1dGxiUmZRSjhVWWFZQ0dWTDJTL0JZVzRYTXZhTHcxQ3dNcFpZQXpC?=
 =?utf-8?B?emRRSnFpK1NpNnhBVTZsTVBxMW9VcDEzTXZGTW93MFhBTkhOTEFISUNYV2lk?=
 =?utf-8?B?WVNtVWcwZHdrVXk1OGJHb29LNUFHdEhIOFBBbU1yRkx2ZTZkSkkzbzBDRkxF?=
 =?utf-8?Q?e/swrlj4BZNe1gOW1AWFSTtMt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bcc9aa-bf5d-4123-a7e7-08dd4432b423
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:11:12.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w99oY5gpq5ru8qnz7Ab4GUF1nfJthVRG9nozL7cp6z3JBx9wDWg9C1dKl9APClya
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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



On 1/21/25 14:41, Michal Simek wrote:
> Add ethernet aliases to CC (Carrier card) description to create a
> connection which is used by fdt_fixup_ethernet() for updating
> local-mac-address in DT.
> On Kria SOM MAC address is read from i2c eeprom at start and based on it
> environment variables are created. Without creating aliases U-Boot is not
> able to inject local-mac-address DT property and OS won't get the same MAC
> address unless another i2c read is happening in OS.
> Also aliases are using string not phandle that's why full path has to be
> provided but that shouldn't be a big issue because location of ethernet
> controller is fixed.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 4 ++++
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 5 +++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 4 ++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 4 ++++
>   4 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index d56e863ce1c5..02be5e1e8686 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -22,6 +22,10 @@
>   		     "xlnx,zynqmp-sk-kd240", "xlnx,zynqmp";
>   	model = "ZynqMP KD240 revA/B/1";
>   
> +	aliases {
> +		ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
> +	};
> +
>   	ina260-u3 {
>   		compatible = "iio-hwmon";
>   		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 9d0c0c2885df..fbacfa984d76 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -20,6 +20,11 @@
>   		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
>   	model = "ZynqMP KR260 revA";
>   
> +	aliases {
> +		ethernet0 = "/axi/ethernet@ff0b0000"; /* &gem0 */
> +		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
> +	};
> +
>   	ina260-u14 {
>   		compatible = "iio-hwmon";
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index a98a888d1385..3c36eb52e968 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -28,6 +28,10 @@
>   		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
>   	model = "ZynqMP KV260 revA";
>   
> +	aliases {
> +		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
> +	};
> +
>   	ina260-u14 {
>   		compatible = "iio-hwmon";
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 7490efea98bd..078d98e8ff34 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -23,6 +23,10 @@
>   		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
>   	model = "ZynqMP KV260 revB";
>   
> +	aliases {
> +		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
> +	};
> +
>   	ina260-u14 {
>   		compatible = "iio-hwmon";
>   		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;

Applied.
M
