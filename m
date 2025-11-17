Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD4CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 16:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D14483B99;
	Mon, 17 Nov 2025 17:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H+s6T2BN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BE283BBE; Mon, 17 Nov 2025 17:09:31 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B5A83A8F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 17:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg4cbdCVaLJ8Us4C5OWnhZjzinnBVKHJPvrwTZci6YCZmSULFdO6doYHKXQOVNNG/uwLKPVv1S4Op+AJEqf89d9FHzdy9XkM407j2AOnY3vSwD19LTmOT8pVLpJqGRZkbPIhO0x3sG3leSh0chLBaabP3hnZNH01J0l20084SrOPW6MErRvxCvdncvkASrvlFFjGE8Gxf/oQHR8FI+r1eLTAQ4Z7ZU3+MT2TvNPp6ir6ut3zGD8uyV5EGQ3zFQqhgWKMh6bAj9R3xz7zmWAsj5WZbM/hwjbhFgguuk5k2wY81PYxe88WuMp2DlN4X9Mmi1V62Y354a6vBAuLyLOUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQkOhnGaCs3tdLhgjqemDcRxHKQblzagRn3l0jfG2/Y=;
 b=J8//OC+bsHuKbGLmcv8qCkOz07m1KKjZVQs2xbE4egAbwI7ecvzk7SlvA6W2QV+cIh5VzhWbWmWHqNu2sULA8j9XMuadfE2RhrQvYE09HsRs2wwSdFRYNc6xebVgelau7ykgkD0aB2G0+9OlOurEk37PphLaL87+RS1W7o51nl8Px9ZCqtpItd+F1e+zKncMxr5JYsw5bFfN2T99CMR0uvvAYOezPEZxZge6rILr6i2rn9Wd/aR2GFkwhNF+OyEe3D3Pza8Biw0l5m36mVnUZL15YUZojcW+SPYT2BBSP6LQwbyFQGxbq3tEdYucupi6gSclVImhlB8XpeIV72FRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQkOhnGaCs3tdLhgjqemDcRxHKQblzagRn3l0jfG2/Y=;
 b=H+s6T2BNGG/8FlpqbQ2poVg0rYOVZy9mTkfFZwUsbvErDlFe+6Dl1yonKDvGnL5CMujhQBcKaQUDooYRx+PXN8KeEeG6Y0Y/WxgOXbuTm57bpOsqQcOhN43LTVPz3V+UVKsjDo9As/u31UvwhE7Y9h+paqt0Yaebf9MQwJW3Vwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 16:09:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:09:23 +0000
Message-ID: <6ae23071-0749-4015-969a-036dbd3277b4@cherry.de>
Date: Mon, 17 Nov 2025 17:09:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
To: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Quentin Schulz <foss+uboot@0leil.net>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
 <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
 <DB9PR06MB85123A4CF4B3A698386F9EE9CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
 <CALeDE9PswgDAG=1Ouy5W02FKZRFskqc3tx967SVms+MTL8Z1Ng@mail.gmail.com>
 <20251117153834.GJ2125796@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251117153834.GJ2125796@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c36cdfa-a823-45ab-273e-08de25f3ac68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG10ZEFIYlVBSnExNWVmMGZma0sySWVzK1d2N0tqVUJaUzdnWkhxOHpqQUlr?=
 =?utf-8?B?U3ljMnY2cTBHcGYvQ0gwMURSYmtjemNmUmMrQ0NuSkQ3NEFsZVJZTFViT0d5?=
 =?utf-8?B?aXZ0b1VSU3BHVFBDTmdxY0dwMUh0Z3JOclpZbGw1V2pBM1lNcnI2eWp1UFp4?=
 =?utf-8?B?WVNWTUF2MU1rK2NTY2RPaTJrdXNaNEtvNjVwNHUwcFBHUGI4RXFkUll2c3c3?=
 =?utf-8?B?K0xTcVJvWGp1WTFNQlBNY0tsNUZ4OXg1SjJEbytzVFlxdXZ5RnNDVEE3azFu?=
 =?utf-8?B?NVI5L2FIQUthUHlwUHFZdElYRzR1MitZMjRTVjFmM0NvVEdjZU00QUpSTm1J?=
 =?utf-8?B?Q2JYM3ljSFk0UVJGNHNjcmgzNGxlZVU3a2N2V2lJNlZ2aTJzNmhGaUxyUjhl?=
 =?utf-8?B?Ny8wN2NnUzFRTk1qck1PVi80c2RsSytNZ2JJclVDTm5ZYmxLL1M4NUw4UkRx?=
 =?utf-8?B?OWpVRGtDMzVNSXIwM0g3TlVTOHI2bWdTUmNFME51OGFOQ0VXV1orNnNpSGdm?=
 =?utf-8?B?RUgrSzh5T1k0ZFduNUFIbU9idlN4cUkxbmFoZ0N5cUdxdzZ2RWFhejRCTFhX?=
 =?utf-8?B?OHNZbFdhZTQvdXNEc2daUnVZM05aRUpxNUo2LzhCNEhMazlXRWkzOW14ZnQ4?=
 =?utf-8?B?eDdHdVdSOTRFdzI0ajI4RG1VZ2lVRU50Q1E2bk5peWN1RUlGUXU4bHNvQjVE?=
 =?utf-8?B?T3R0cEpGMEtTS01MVlUyM1RLcWI1cjhWWU5nTzVXeHFjMFpQdFdycmRhS3cz?=
 =?utf-8?B?YndqNjQzc09nc1Q0dDk5aUlpKzFnUjFqbm9PeTBpL3dqZWZyWE5xb0pST2t2?=
 =?utf-8?B?d2M2d2lEODB0YlNVaURQZytheVlXeXdNRkdNZlhXQkNFbDNmZE55cmdyTkRy?=
 =?utf-8?B?cmRDTWgyL3FCNXRXUzl0Q1ltdWlSSVc1ZE5XM1VWZU5xTXdBT05NNnNjTU01?=
 =?utf-8?B?ZS8zc3ZMenVpcFgySUEyamRkaXM5TG9lcS8rRWZ0S3daRlM1QWZvUWtjQjVk?=
 =?utf-8?B?NC9aNWVVZjNTV2QvSXc4KzVFV1lyc2RsaDNjTzlaZDFyd2QvTnVrZHlDSFBZ?=
 =?utf-8?B?YWJmMkhqSGtXalJlNklQSFdJSDNJQWdmVm05N2ZrNlM3WnV4T3RsQ0UyUmlk?=
 =?utf-8?B?NHVWWDFSZGdSODR3dnNvTm5zNU1nYS94eDZtWEgwOEg1c3Q4YXJkU1oreFpP?=
 =?utf-8?B?bForc2tsYWhwVDRxQTR4SnRCbjJqclNZMUxVM0M1L1lucUdkMDNtVE5NMnh3?=
 =?utf-8?B?dVhkV1A3alVFeXBjdVgvUm8yU2lYam0wTUZzT2dMRXl1cUxvVm9jeU4weTdZ?=
 =?utf-8?B?T2VtN3gvaW1ObzBVU3cyK2RNUTgvclI5RzBBUEFFL0FuVGlyV041dWZtMFp6?=
 =?utf-8?B?ZytEZ2hGVkk4RWpPSDhMZ2s2U3FmK3F2UGtsdUl2dHlqNWYxNXdDVzdiRTlw?=
 =?utf-8?B?RGo1UHZEa0dLYzJrZ1BuaDJVT1hFOEM5MWRJV1p2UjZDVDdnMFJBekIvNEQ1?=
 =?utf-8?B?anZoVXIxZzJ6bExyTkljaWQ1MXpHUngyV2dRcVZwN3hoQWoxbEQwM2txWHJn?=
 =?utf-8?B?aHg1WG95eUVNUkErcUpIQ0V5WEp3d1cxWHNjeTUzOExEVzNkZFdZR09pTkFi?=
 =?utf-8?B?aDgvNi91ODNCQUV6d1p6MXpTTW5LOHlXRlhTdFNGYnBQb1lrZVN3OW1MdFlm?=
 =?utf-8?B?dlpaQmkrN0RVdW8wTlFVTFQ2bklYS1Axd0I4c0kyY0w2c3lhVDJtV0c2NzJN?=
 =?utf-8?B?dHZja1MySHhaVnRZZytjNi8xeTR3bjhLZU9LODU5cXNzalV2V2I2UlVzY2ZW?=
 =?utf-8?B?alNEbGZOa3BFYVBjR2tqZ3ZKWXE4Tk82d05PcVRYVGc2MEZoSllHNitsd0tn?=
 =?utf-8?B?SVh4QTBzZUhkTHdtdE8ra1FYSGErS3RMNFdqd3MrNXczdHNjdlp3VHpIdVha?=
 =?utf-8?B?YXVYQVlrbFdRNER5VHFxUWdnd0grak5vZGcwRUVueldlK282RC9zL1c2bGE4?=
 =?utf-8?B?dm5hRWVUTzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdVQkNiMkhCT3FhWnNWajYxbm5reC9GTlJ5Ymd2QnZoSHM5eDJCbU13Y1hJ?=
 =?utf-8?B?NHlLK3dqK2Y4U2wyM3llUWJnQjN6dWRxRzNRM1VWc3lWNUVRWlhIRnNOSnNK?=
 =?utf-8?B?a0NESFhUbHRjc0N5UUhYRHU5M3A4blhsajRQRUIreWZMZFVNWldNaXQ4ekpu?=
 =?utf-8?B?aEEwbzJhb0srQ0x4cDg1aWd3akVsRERmL3BKdTI4dWxzeEJLR2RVWnJ0NklR?=
 =?utf-8?B?OHczejRhYTFnSFJ4QTZaUG9ON0xmSDZZUHd2RWk0ZFl0d2pUMFdlMzJXZDV3?=
 =?utf-8?B?cXRRdlVIUFBsOUYwL0l6YWZOMmJqSlcrMEYrWFhvcVB4SUsxWFptalBzNE40?=
 =?utf-8?B?bVovcHVjUlAyaU91TGIvQ3lna3V6aXdCdnh2TFg2OUV3TkFyVkZoaTlxVE5i?=
 =?utf-8?B?cFl0b2pZdlczaVJoZTA4TW9vcUE1UHJteC9iMkZxSEc5bVRZOExXNzZENVJu?=
 =?utf-8?B?QTNoTFgrcE4wWWtZQUJoaVI5ZzMxZElLb3k5Mm4rTDU3NzA1bkNVM2Racysr?=
 =?utf-8?B?ZlF5NmR3UVdTOEo3RGErOEJEWkx0aUVTeTQzdzZJSmdxWGoxbWtKK1NYUFhk?=
 =?utf-8?B?dUlxN0tyNG1lSmI2RGpLMVNKQzB1bEg1WHlSSjZuL2ExZDJjbzFpa0FvS1V3?=
 =?utf-8?B?N2ZsYkQ5TTZOZk9RT1hMYWE1KzlxZ2EzSWdjLy8xRnhhOEs4SXc3eFFqQ0pi?=
 =?utf-8?B?NVdEalkrWVpYZFp3bEMraEJOb0c2SjZWWDlpTEYzSXFlN3Q4blRJT3hZMEhr?=
 =?utf-8?B?ak5HZ0I1OHdQN2h0SVNkOUlObzRkQkk5WnplM05KZmpkakFRc29HQ2I5Mnhj?=
 =?utf-8?B?Tlk4VWRHTmZaOUUweEpaSG9uTlM3M200RTRYRXJFbVFIL3RvSklZa3cyRVdX?=
 =?utf-8?B?a3liWlRIanVMekpYQ1gzSEFlMWZReVlUamhwSEx0MGpCOWZHemJXeVdVUzN6?=
 =?utf-8?B?NUh0RGRhMG5weFZKb1BnamhFNmZFZkxldWdoaVhDbWozRGJkMlFFUkduYWRt?=
 =?utf-8?B?aGpCc3Q3cDdYVHc1U0Z5Z0dWQklaK0JCOFNpay9pNFljL2lrZ3pJK2tZaE05?=
 =?utf-8?B?eEZYbitQcURjbXZhZ1BjVVdmdzgwYVJXd3dUMDEwMmVyNVQ3YnNWUWY3UCtD?=
 =?utf-8?B?all1WTVHTVZ2cVlwUU5aMzUrOUUyNmgzM3dnK3FsSDRzRFhBT09mSDVPb01J?=
 =?utf-8?B?WnVVUjZ3WDA1MFBzT3doVERjSnNmMTd0ZzZ6SS9yNlJqazEyZUwrUHhWdm9M?=
 =?utf-8?B?R0tETW16ZjFLaktsYkkraERGVm9SRjN3L2c4T1d2cUpPV0hhRkQ4ZEpQbkJm?=
 =?utf-8?B?clVHUm1hK2lPbHMvUHV3RXVxdmt1bW41WlpWVy9HMy8weDlOZUpCUzZWSXgr?=
 =?utf-8?B?ek5tV0tYTjZvUUNYT1pmQzY3TnVFOGwydGhSOUlxZFlpOU1YaU01TVpLRDRz?=
 =?utf-8?B?MVJaSkE1TGhqZjhCek11dmNTNUd1QnRTcWUyOEdSWGw0NTVlVDF2R3pOWVBF?=
 =?utf-8?B?SG1aSDNPejUvTWI3dWdzTUhVSGVDTjV3cjA1TVQzZUVyZkNGUVJVak81UnNy?=
 =?utf-8?B?WGlhWkEyNnJXL1psTUwyWFcrT0xCTGR1RjJld05jN1dIelFoV2FsY05HVW43?=
 =?utf-8?B?MEg4S3J0b1oyenVFTWJYcnNyckYvS3VRa0dZM21Yb1hFcEhPMEwzYlZ0Y2R0?=
 =?utf-8?B?ZmJMQTZseWk0QUNzbWI1d0RPK2I5alNieDd1NTBXZ055cUU4ZHlkdlhPeG4x?=
 =?utf-8?B?M1RBR3A3MVRpdmlrTytuYUVXeVhqaEpzVXBxRzFMOHRtM0J4dStnMDhpSXNK?=
 =?utf-8?B?UWtxZ2lDRWdNYTJib2pXRkliN1EyT0RnT1VhTHZubWtFR3djR1VCYVU2cVox?=
 =?utf-8?B?eWpQckdYN05pOSt0SW9xZSthYTVIeWMwdzg0NlJNRldsRGdEaHFnVTl4SVRv?=
 =?utf-8?B?TStZTWhCVTBhMlU4Y253S3FSZmtEZXF6V3NBR2pBYnZHVlZZNmlhQ0NSd0Ir?=
 =?utf-8?B?ckZueDVBMkd6U3VRUUZvR0JOMHdSNWlQVWtZdUNOVFJBRWZHZnhpaXpoMzdL?=
 =?utf-8?B?VTlMbFRUeThLUDJVd2wyTm95T0loaHZ1NDRRbk41VGFKd09yRjNYTVBGUmtM?=
 =?utf-8?B?YTQ2d0t4dXdlNTVsaXpWL2REdXZsTEc1ekhpaGZOQ0NzRXY3VVd3TXoxb1VJ?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c36cdfa-a823-45ab-273e-08de25f3ac68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:09:23.5880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxP8PdF7qQ6rErdP/UYLukB9wsjJgeTem5rnD144KRBuaJ80uaZuPdvTt8nKISRrE8+4Tv6k4ZIM874pBhwS8rMmNsuPKk73PLtiQJKVVV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378
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

Hi Tom, Peter, Wolfgang,

On 11/17/25 4:38 PM, Tom Rini wrote:
> On Mon, Nov 17, 2025 at 03:18:08PM +0000, Peter Robinson wrote:
>> On Tue, 11 Nov 2025 at 10:14, Wolfgang Wallner
>> <wolfgang.wallner@br-automation.com> wrote:
>>>
>>> Hi Peter,
>>>
>>>>> This adds support for using an OpenSSL engine for signing a FIT image.
>>>>> To use it, one should set the fit,sign-engine property at the FIT node
>>>>> level with the engine to use. This will in turn call mkimage with the -N
>>>>> option.
>>>>
>>>> Just to be aware this should likely be a OpenSSL provider, engines in
>>>> OpenSSL are deprecated and due to be removed in 4.0. A lot of distros
>>>> are already dropping support for engines. There's a patch [1] adding
>>>> support for Providers support to U-Boot, I suspect we shouldn't be
>>>> adding more deps on the Engine support. OpenSSL 4 is due in March.
>>>
>>> I'm aware that the engine API is deprecated in OpenSSL, and that the provider
>>> API is the way to go forward.
>>>
>>> But the PKI provider of my employer currently only provides a PKCS#11 library
>>> with an engine API, and I'm not aware of any plans yet if/when they will
>>> be supporting the provider API.
>>>
>>> So for the transition period it would be nice to keep the engine API around as
>>> such use cases still depend on it.
>>
>> my comment wasn't so much about removing engine support but rather
>> having parity with the newer version so that when users upgrade they
>> don't end up being stuck with broken functionality.
> 
> Yes and I think an unfortunate part of the problem here is that it seems
> like the hardware signing vendors haven't committed to a strategy yet as
> it's multiple reports of "my vendor has no plans yet". So we'll need to
> have plans to support both for some time is all.
> 

And considering 3.5 release that still supports engines is LTS until 
2030, there's sadly still time before the end of the world for those 
vendors :)

I also checked LibreSSL and they got rid of engines and do not support 
providers as far as I could tell (which is extrapolated from a grep 
through the code base). I do not know the reason. The API still exists 
but does nothing (or errors out). c.f. 
https://github.com/libressl/portable/blob/000396d2014eb8e961b674000365f0d4e1385022/ChangeLog#L527-L529

Newer OpenSSL (>=3.0.0 as far as I could tell) allow to use engines via 
the provider API (at least through CLI) by prefixing the engine with 
org.openssl.engine: when passed as "provider" to OpenSSL.

Ideally, what I'm trying to add could be reused verbatim with providers 
as well. But I'll need help here because I don't have any actual 
provider I could test my code against (except softhsm2 for pkcs11 I 
guess, which provides both provider and engines), as opposed to engines 
which we use in prod.

I've managed to develop what I believe to be a simple RSA engine to test 
FIT signing with it, as well as PKCS11 with SoftHSMv2. I have no 
security or crypto background so I have no idea if what I'm doing is 
proper or not except that it signs properly. I'm finalizing the patches 
for the v2 and will Cc the person who posted patches for supporting 
OpenSSL providers.

Cheers,
Quentin
