Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307B5C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 10:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692DB801CF;
	Wed, 26 Feb 2025 11:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uD67+8Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876D9801DE; Wed, 26 Feb 2025 11:23:38 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FB38006D
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 11:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVlWe8V3jdJkZh1sO1qrEQg5mtTOngkUQqJ+C02//51nT1I1V1hhfFdcu7NR8oWNIfywBz82OeMSgkQYlGoXxNjVWqHbKxK74YnrbiCDekRRY1T23ANu2DvG73rroXkqGAou51x/1Ao6olEZWtJCvCczqXAgHgHrS/ofJTgvHZisiXJavcpO63XbeofeNJXEnnbiDhzVVSwNbid8fJws5JSa+zHJTQbQuEqiICu6minCTYdALGPKvHu8Rkjoxh6eO0rq2ozD2xjGFLy0LWUq6JcP4nVuW768TN1c5dV3NwqL/c32/PrSpoIfNIFwJPSwPOk8FOpbFvEyU4BV+/BrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y34jiwqA2MB8U0nxbQjm8JfGRhgXLae7jwcpuEBPPgA=;
 b=IHuiN8Ha2OquAk/qSbm5Elh0oCP7CTlz8m+IOYD6mPmYGO+KR4mOmxvQg1NJrqAzJ+OMWronWXOzJ1hRzOprm2krOzXjLlW359HZi8f0z5wYMB1Um8oRk+HJxOapdn4lYR01eaFmY6CuKr5RoMQlQ4PStng7Z7sbwR3r8aD+VFbjpk+CXPLRp5chVPWCMeQMJ2LwAOwCgvel/p3EAyNoCWZKvogsvy4tEEsJe60/iOUuEUy3T5N+NGbOuf1w5JdMojLOTSPF8BeoTpZiOG8Zg0oIIhpjG8oXhmTrF93lNO26xDvP0VfTTiQrrkPtnG270stfynGVdODShIcfalLL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y34jiwqA2MB8U0nxbQjm8JfGRhgXLae7jwcpuEBPPgA=;
 b=uD67+8Uclx0n1oTq8YpyJJaqJptw3G8CFoadlsOPQVjhZYEjl4hCS5UFClkWKRbVCCbBc3b+ajpwHfQizt19Wcg2t684N8SCTc+TQkXNeFZTXTCb3CCMfDAVjJ2JsXAXMQaYDyrB3/v7quPswk64fGrsYWIdHzQcGwHmtPstgd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 10:23:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 10:23:32 +0000
Message-ID: <de79214c-088e-4554-9e40-b8fce677bf3a@amd.com>
Date: Wed, 26 Feb 2025 11:23:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board/BuR/zynq: initial commit
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Fabio Estevam
 <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250211124957.104907-1-bernhard.messerklinger@br-automation.com>
 <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250211124957.104907-5-bernhard.messerklinger@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8769a6fe-7400-411e-587b-08dd564f9e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUJUTlFEcmgwQWFoWUNnT09MbnlMNkM2R29NSTdEN284TGRNcTNQRUFFZzlX?=
 =?utf-8?B?N2pDWVp3YmM2L2o5c0ZRYkdZbHdiQ1NPM3YyZ1JNbWlkTFlvSWVyN1Vpcnls?=
 =?utf-8?B?d1U3anRUWEVNdWtsem9wNFV0amdJcVlVNkJLUFdJK2RjNU0rdDFtbDZrZjVD?=
 =?utf-8?B?S3lBc09WNmpDTG10eStOdStaRjBSMzZ1TzhMWHQzMFc1MGI3Ym1Uc0F1RzVl?=
 =?utf-8?B?RVR4ZklqckRGenVnd2ZVaklSaWZKZ1BsVERxbG9TV0x6V014bXpSQ3k3NVZs?=
 =?utf-8?B?SmlHVVhoUVVTOTltWmhGKzJmcER0bXVIQ3lORzZYL0loYllsaGVlOTNyTURO?=
 =?utf-8?B?OVBGa3BxZmJPS2F0OXljTmNURHFFWDVFaUZoQ3RiY2xDSWY0R2R5U3JpOVBO?=
 =?utf-8?B?M3Q2MnRNY3B0SWJJbkFrQjFDNnVRZERuZWs2bFRvSGZSS2FDZmtEYTBQVWZO?=
 =?utf-8?B?VDJWWGpQM0xTQ0NHcEYzRFVvem9zTS9NNDFJTWVVeVIyeXY5OXFWZUZ3dTVh?=
 =?utf-8?B?R1RYUzlCSkJjdXhmQkpXOUp0K1F1SVNWUUg1QVJGem9heWVEMG9qV001TzdG?=
 =?utf-8?B?akZFUGw5RmZadzg5STJXRzVoMW05Q1JTR2FaazN3dEVRbVR4YmdjenpjTito?=
 =?utf-8?B?ZmFNbVEyb2lPWGdDV1lFMStkdjM2U0NVNThtd3VuZ0JNN3N4RTA2OWt0Rk5D?=
 =?utf-8?B?M0I1LzM5NWR1RXpZcm1GcCtSTTlHdDhYMllIaGY0UU1lWDZhVTh0VHY5VGt3?=
 =?utf-8?B?c3p5VWQySXU4dVdkYXVIQzRoVkdCRWk3aEEvTFB2MHBkblAyNDI1WnpiZmgx?=
 =?utf-8?B?R0JHQlBFVEpBSlFtZjdaNkJXNExWQXN6Y1NwMW5tTGpYeXFhRkp4bVc1K3I1?=
 =?utf-8?B?TGtuazBuNllNVTdORVVDN2x6b1dmODRTRktuQzF6eGxKZmlQVGZMM2Uyck0w?=
 =?utf-8?B?YUpnY24wSDVvdzd5S3FtMTB5T0NLdVowbjV6SWRiVm90RFRxSHlCK3FXd3RT?=
 =?utf-8?B?ZThBQnE3MnNKb3I5eGEwNk13VnhGQlRvYWt1Tmgxd0d6Q0xwRFJ4ZWN4bkdh?=
 =?utf-8?B?SXZxRE0yWlV1dTY2WGIvdklUaWd5Sk9WdWhNQm9Ld21TY3JWQ3puejdKdVNX?=
 =?utf-8?B?dW5HdEVWekhIQWpzWDU1OUJISW5wSXJwRFFSSVZ0dWI1d2lSU01vdmd3V2J1?=
 =?utf-8?B?Ynl5aVl0Y0VVYUx2M3FrbjhsUmFvckY1NUJ3N1dMNlFWaC83MnlkNTRsaUJi?=
 =?utf-8?B?T21FYWJzYjIwOHo3L1BIZUEzUkV3N0RRellXVDdOcWlIS3BHZGI0dkNZWTBH?=
 =?utf-8?B?aW5ReHZneEVaV1RCRUIvZkNzQ1IyRXlsdVJTOC8zYkczbjhSM05NUG9nRGhh?=
 =?utf-8?B?bGRmQzFHbkFSMFFWbEpsbmkyS0xNOE1kRUkybDM5SFYrOW1vc3lLcEVrS3Ju?=
 =?utf-8?B?TlRaKzJUMTdNWXdhTGRVL2NWck9STEZ6bEJGMGt1cWpEM2dGdmdHSnYxaE03?=
 =?utf-8?B?cDVUU25vTVJZbGR6TEN2N0F3TGEvL1VPQ1REWkd5NnpwR0xLdXVIU2dveG9O?=
 =?utf-8?B?THNqNXVTcXowa1hqSzNDWldjcE1OTmJPcGlVQXliMHZGSDVwNEFPZWRXWHds?=
 =?utf-8?B?TTJFRmprYUR1TXJjL21DNWxtYzcxMXhVWlBaSXRBU3Z6dTM2U1VtL2l2MDBM?=
 =?utf-8?B?dmkyT1lwaDRVTjJWNmNCUVNMRGs5dUpjcXBTZlJGcU5UcE5SMEpuQzN4aDdZ?=
 =?utf-8?B?T1JnM013VXhuQTNiVXVFbnpjVytCVjdCYXB5Qk1rRWZRRVIzOUhiZVFsQzZv?=
 =?utf-8?B?YmRaR0ZORnhSRENSZk41RlB2OTlSakRoOXlvQ0h0ZVFKOVpaQWtNQ2lFUE9i?=
 =?utf-8?Q?lDl4oJw498lIQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NieG13Ti9IMmFqQ3R4VWhkNVVtUG9pRGlJQjcvK0NaaFZPa21MbTlROUZS?=
 =?utf-8?B?SjJ2MkZBYjd5OUxLZ3RVY2NHZlhLRFA0ZVVFMU1wS0EvYm5iUmZEM05CUVEz?=
 =?utf-8?B?TGxvK0Y1REFoQ1FpYVJFVzEwckQ0cTRtak82dC9rT0lraWpLdXp0emJoOWlw?=
 =?utf-8?B?U3BjS2NyWko2cGw4d1VNeEwwQjhqeUJDQ2ppZklIelFpS2xacTl1NU00V2ZI?=
 =?utf-8?B?TW8wVGkvOUtkU1BSMVo1TXNiVmdHYmtQejJham9vN2R1bXRROCsxT1hxd2VC?=
 =?utf-8?B?RmZzNWJsWE9WeTkxQ3h0Q2MzSys3Q3lyUGdtWkFlRmIwRW12Q1p2dHdOd3dU?=
 =?utf-8?B?ZFdqeVFzYlIvanFwZnhrSXR0YjF5N0NrN3VRVUFCUWhFb05jRTREbVZCR245?=
 =?utf-8?B?R3R5dmhUWG94NmF0OVFJVytoOTFNaG9xaEwxd0NBd2J4d1N1YlJnWFh0eDVS?=
 =?utf-8?B?R3NzZjJOanZ0UDFJSlRtejNDdVYwZDRrdFlHc1lHd2xaOGZjMnBqQ2trR1pr?=
 =?utf-8?B?dnV0c1VkbTJOUnQ0TFJzQjB4RXI4R0RTbGkwaWNZMklrRmgySkQ5a3J3UDRn?=
 =?utf-8?B?RTdMSEpmOHpWSXdCcjlmYThpdWphZ09PM2dUR05nMDdSUlcvcGtrb1NKMjYr?=
 =?utf-8?B?eHN0cWdQd0IvQjRaZDV2ZjBqUGMwZ2RKbGhmVUQrWmN6SW4yRmpQNDAzaVBK?=
 =?utf-8?B?NHRIRE4xM3l1Rm1XekFWQnBjZVl4VCt5Um9pYllyWk5UUnRSZlV1YVZVYklv?=
 =?utf-8?B?NWZteDlZVXR1Y00vczR2U0RxUyszekZZS0pnTjRxVXVINE9tVm9YMjVjaWpW?=
 =?utf-8?B?MGVMSVY2L0dQZUFwNjBnMWl0OS81OE9IaTh1OHlPL25UTW11N0RKaGw0YzE1?=
 =?utf-8?B?VnU0aDAxUTMwU3cyaHp3aGhxTER1VHhKZlE0aGd3UFNWYThtWUQ4cnJYaU9O?=
 =?utf-8?B?SVYwSHFXckljbU04TXEyM0h0MkRWRVpFRnoxSFdNWHZhWmQ2MGZySEJ0L3ZT?=
 =?utf-8?B?c0QzM2oxU2ZucHdoUVl5UDgyVlNmWm5sUEx5MUhYT3JrWTVSQTBEVkphZWpK?=
 =?utf-8?B?N1lyUnVWOGFEYVR5eXRKS3VMdzZDaThPUGdNcXR6SHFyODA5aDZBM2Q1bVJI?=
 =?utf-8?B?RnB0OVNJTUdGZUdhTVBPbEcvYUJsUUpXdXNtTHBYMFZEcTlINnlHUXNsRk9E?=
 =?utf-8?B?ZFRTRDdjcExaQ2hJaWczcjVHWlNkNXMyZUpGSHRFMzZHb2Z4aDdvbSsrdmZw?=
 =?utf-8?B?QUQ4YlFEcWIxcVhHUXhXdW1oUS9WampzY3hvMG9Zc1JscHZyRXZXT2R3OWc2?=
 =?utf-8?B?NU94QnZod2MrNWRZc3FJaytNSm9acEtTZGZidFNOb1ZuNXV2UXZGSDcyRUdX?=
 =?utf-8?B?ZmNLT0Z1RE9YWFRLaEJYREF5Ymp4SDNoZmpycjErNXk4bjB4OVZPckdsTGFi?=
 =?utf-8?B?U2pheC90VWV2dVNxTHBTbGExSGdrUHhvUVNEaXBkN0dwbTBuaktwajhHTmJC?=
 =?utf-8?B?ZkxZeWdkVnRsdEtrVUdua0ZKdDJvWmZsd3QyelBZODArbXBWTlNWMzZmcjZ0?=
 =?utf-8?B?VVdMOEZRWm1UdEovVWhQVHlkQUM0WUUvWVZ4SmphZ3JSWXhNRzNKUk1ZWkUw?=
 =?utf-8?B?c2M2Q0duKzd1VHE1cDl6WURpOXJNdTNGc3hCeVZUdmx0SGlVK3Nqc1MwVm9p?=
 =?utf-8?B?cDErajh5MjdXSTFPRmxrQy9kSjNNWFRseDJvOExZZUFIbTFoTjVkZFNXNVFw?=
 =?utf-8?B?RmJlbnI1cXpyNDBVYnJpbVBmaVFwL0dJeUhwQU12VU5KMVRLa2dPRGFKY0p4?=
 =?utf-8?B?dVdtVTZ4WGxRbEJmVXVURWYydWw4TmZCQ2xVMUZFUjhscHFiaFpXbHBYa0lU?=
 =?utf-8?B?b0wrNmo3dEQySnJUWVVBOTErZ1A1czBteVFYU2x1Z2hXWWpXcC9ybzJUV2VG?=
 =?utf-8?B?NUZVUGdUVnR1a05PN052Yi84RFRUaEgwOW1aWEZkQ3FGb1QxWHpOVlBLTHBi?=
 =?utf-8?B?Ty8vWE9QcmcvL3VFdHEvWUJNVGYvS1hxbmZwbHhYdExYT0RhWWYxUCt5bjNE?=
 =?utf-8?B?MUJqR09pdktrclFob3BseFd0Q0FxdGt5VklMRDdaOElnaFhDVkM4emJMU2k3?=
 =?utf-8?Q?armphVINUAxzJjQvPp9610j+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8769a6fe-7400-411e-587b-08dd564f9e66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:23:31.9266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmuKJFE7Z2e/Wighes/JS7vDx/IyfruC6cgYZKnRICQillvtGm8c/AyxYCxYMak8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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



On 2/11/25 13:49, Bernhard Messerklinger wrote:
> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
> boards. This boards are based on the Xilinx Zynq SoC.
> 
> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
> ---
> 
> Changes in v2:
> - Remove all unnecessary device-tree entries
> - Reviewed led names (no pattern restriction found)
> - Fix maintainers file
> - Cleanup of code
> - Move preboot variable to env file
> 
>   arch/arm/dts/Makefile                         |   8 +-
>   arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++
>   arch/arm/dts/zynq-brcp1.dtsi                  | 133 +++++++++
>   arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++
>   arch/arm/dts/zynq-brcp150.dts                 | 174 +++++++++++
>   arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++
>   arch/arm/dts/zynq-brcp170.dts                 | 140 +++++++++
>   arch/arm/dts/zynq-brcp1_1r.dts                |  29 ++
>   arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>   arch/arm/dts/zynq-brcp1_2r.dts                |  22 ++
>   arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++
>   arch/arm/dts/zynq-brsmarc2.dts                | 158 ++++++++++
>   arch/arm/mach-zynq/Kconfig                    |   1 +
>   board/BuR/zynq/Kconfig                        |  14 +
>   board/BuR/zynq/MAINTAINERS                    |  11 +
>   board/BuR/zynq/Makefile                       |  15 +
>   board/BuR/zynq/brcp150/board.c                |   4 +
>   board/BuR/zynq/brcp150/ps7_init_gpl.c         | 278 ++++++++++++++++++
>   board/BuR/zynq/brcp170/board.c                |   4 +
>   board/BuR/zynq/brcp170/ps7_init_gpl.c         | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r/board.c               |   4 +
>   board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 274 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r_switch/board.c        |   4 +
>   board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 270 +++++++++++++++++
>   board/BuR/zynq/brcp1_2r/board.c               |   4 +
>   board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 277 +++++++++++++++++
>   board/BuR/zynq/brsmarc2/board.c               |  30 ++
>   board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 276 +++++++++++++++++
>   board/BuR/zynq/common/board.c                 | 231 +++++++++++++++
>   board/BuR/zynq/env/brcp1.env                  | 109 +++++++
>   board/BuR/zynq/env/brcp150.env                | 119 ++++++++
>   configs/brcp150_defconfig                     | 123 ++++++++
>   configs/brcp170_defconfig                     | 122 ++++++++
>   configs/brcp1_1r_defconfig                    | 122 ++++++++
>   configs/brcp1_1r_switch_defconfig             | 123 ++++++++
>   configs/brcp1_2r_defconfig                    | 122 ++++++++
>   configs/brsmarc2_defconfig                    | 122 ++++++++
>   include/configs/brzynq.h                      |  21 ++
>   38 files changed, 4109 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150.dts
>   create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp170.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>   create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>   create mode 100644 board/BuR/zynq/Kconfig
>   create mode 100644 board/BuR/zynq/MAINTAINERS
>   create mode 100644 board/BuR/zynq/Makefile
>   create mode 100644 board/BuR/zynq/brcp150/board.c
>   create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp170/board.c
>   create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brsmarc2/board.c
>   create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/common/board.c
>   create mode 100644 board/BuR/zynq/env/brcp1.env
>   create mode 100644 board/BuR/zynq/env/brcp150.env
>   create mode 100644 configs/brcp150_defconfig
>   create mode 100644 configs/brcp170_defconfig
>   create mode 100644 configs/brcp1_1r_defconfig
>   create mode 100644 configs/brcp1_1r_switch_defconfig
>   create mode 100644 configs/brcp1_2r_defconfig
>   create mode 100644 configs/brsmarc2_defconfig
>   create mode 100644 include/configs/brzynq.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 0bf3697bdbe..35eb169a853 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -241,7 +241,13 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>   	zynq-zturn.dtb \
>   	zynq-zturn-v5.dtb \
>   	zynq-zybo.dtb \
> -	zynq-zybo-z7.dtb
> +	zynq-zybo-z7.dtb \

I prefer if you can build it only for your target
TARGET_ZYNQ_BR

> +	zynq-brcp1_2r.dtb \
> +	zynq-brcp1_1r.dtb \
> +	zynq-brcp1_1r_switch.dtb \
> +	zynq-brsmarc2.dtb \
> +	zynq-brcp150.dtb \
> +	zynq-brcp170.dtb
>   dtb-$(CONFIG_ARCH_ZYNQMP) += \
>   	avnet-ultra96-rev1.dtb			\
>   	zynqmp-a2197-revA.dtb			\
> diff --git a/arch/arm/dts/zynq-brcp1-u-boot.dtsi b/arch/arm/dts/zynq-brcp1-u-boot.dtsi
> new file mode 100644
> index 00000000000..3e1d157abc1
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1-u-boot.dtsi
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;


I would use

&spi_flash {
	bootph-all;
};

this will avoid duplication of node name.
Also it can avoid creating new node name if origin is chagned.

> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;


I compared these 3
arch/arm/dts/zynq-brcp150-u-boot.dtsi
arch/arm/dts/zynq-brcp1-u-boot.dtsi
arch/arm/dts/zynq-brcp170-u-boot.dtsi

and binman description is pretty much the same. Difference is only in blob-ext 
nodes which are optional anyway.

Isn't easier for you instead of maintaining 3 copies of the same description 
just to use only one?
If yes you can look at how I did wire Kria like this
CONFIG_BINMAN_DTB="./arch/arm/dts/zynqmp-binman-som.dtb"

you can keep binman node separated out of your regular DT.
And if you don't want to have it separated you can still put it to own file and 
source it from here.


> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
> new file mode 100644
> index 00000000000..f1cf75f1277
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1.dtsi
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP1 CPU";
> +	compatible = "br,cp1",
> +		     "xlnx,zynq-7000";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +#include "zynq-brcp1-u-boot.dtsi"


Why? It should be added automatically when you run build.

> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +
> +	pmic0: da9062@58 {
> +		compatible = "dlg,da9062";
> +		reg = <0x58>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	max-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/zynq-brcp150-u-boot.dtsi b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> new file mode 100644
> index 00000000000..f2771dd9bda
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +&rs232_en {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@5 {
> +			filename = "blobs/cfg_opt.img";
> +			offset = <0xD0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@4 {
> +			bootph-all;
> +			filename = "blobs/bitstream_update.bit";
> +			offset = <0x400000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp150.dts b/arch/arm/dts/zynq-brcp150.dts
> new file mode 100644
> index 00000000000..bf2facb10c7
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp150.dts
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP150 CPU";
> +	compatible = "br,cp150",
> +		     "xlnx,zynq-7000";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x20000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* Put this pin active high to enable RS232 debug serial */
> +	rs232_en: rs232_enable {
> +		compatible = "br,rs232-en";
> +		pin = <&gpio0 52 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_red {
> +			label = "RDY_F_RED";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 7 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user1_green {
> +			label = "USER1_GREEN";
> +			gpios = <&ledgpio 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user1_red {
> +			label = "USER1_RED";
> +			gpios = <&ledgpio 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user2_green {
> +			label = "USER2_GREEN";
> +			gpios = <&ledgpio 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user2_red {
> +			label = "USER2_RED";
> +			gpios = <&ledgpio 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "mii";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];

Empty mac? Likely you can just remove it.

> +
> +	ethernet_phy: emio-phy@2 {
> +		reg = <2>;
> +		max-speed = <100>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <16>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +/* Since the gem0 clock is configured EMIO this dummy entry is needed */
> +&clkc {
> +	clocks = <&clkc 16>;
> +	clock-names = "gem0_emio_clk";
> +};
> diff --git a/arch/arm/dts/zynq-brcp170-u-boot.dtsi b/arch/arm/dts/zynq-brcp170-u-boot.dtsi
> new file mode 100644
> index 00000000000..73c49a7c54c
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp170-u-boot.dtsi
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@5 {
> +			filename = "blobs/cfg_opt.img";
> +			offset = <0xD0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp170.dts b/arch/arm/dts/zynq-brcp170.dts
> new file mode 100644
> index 00000000000..c2856e0d41c
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp170.dts
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP170 CPU";
> +	compatible = "br,cp170",
> +		     "xlnx,zynq-7000";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x20000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_red {
> +			label = "RDY_F_RED";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 7 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		max-speed = <100>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@58 {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x58>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_1r.dts b/arch/arm/dts/zynq-brcp1_1r.dts
> new file mode 100644
> index 00000000000..c78d5b9cfe7
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_1r.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x8000000>;
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +		max-speed = <1000>;
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_1r_switch.dts b/arch/arm/dts/zynq-brcp1_1r_switch.dts
> new file mode 100644
> index 00000000000..5006a9333dc
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_1r_switch.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x8000000>;
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "gmii";
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +};
> +
> +/* Since the gem0 clock is configured EMIO this dummy entry is needed */
> +&clkc {
> +	clocks = <&clkc 16>;
> +	clock-names = "gem0_emio_clk";
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_2r.dts b/arch/arm/dts/zynq-brcp1_2r.dts
> new file mode 100644
> index 00000000000..80e43ff93c6
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_2r.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +		max-speed = <1000>;
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi b/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
> new file mode 100644
> index 00000000000..3e1d157abc1
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brsmarc2.dts b/arch/arm/dts/zynq-brsmarc2.dts
> new file mode 100644
> index 00000000000..071785c091c
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brsmarc2.dts
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRSMARC2 CPU";
> +	compatible = "br,smarc2",
> +		     "xlnx,zynq-7000";
> +
> +	aliases {
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +		mmc0 = &sdhci0;
> +		can0 = &can0;
> +		can1 = &can1;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x10000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		plk_se_red {
> +			label = "PLK_S_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy0>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy0: ethernet-phy@1 {
> +		ti,ledcr = <0x0480>;
> +		ti,rgmii-rxclk-shift;
> +		reg = <1>;
> +	};
> +};
> +
> +&gem1 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy1>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy1: ethernet-phy@3{
> +		ti,ledcr = <0x0480>;
> +		reg = <3>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	resetc: rststm@60 {	/* reset controller */
> +		compatible = "bur,rststm";
> +		reg = <0x60>;
> +		hit-gpios = <&gpio0 84 GPIO_ACTIVE_HIGH>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <1>;	/* reset gets fired */
> +		#cooling-cells = <2>;		/* min followed by max */
> +	};
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	max-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index 265e9ce588a..db20f113232 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -61,5 +61,6 @@ config ZYNQ_SDHCI_MAX_FREQ
>   
>   source "board/xilinx/Kconfig"
>   source "board/xilinx/zynq/Kconfig"
> +source "board/BuR/zynq/Kconfig"

I am fine with this way. My part is pretty much only that wiring and this file 
and separation in Makefile works for me.

Thanks,
Michal

