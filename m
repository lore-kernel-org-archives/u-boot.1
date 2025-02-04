Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449EDC02197
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 11:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36269800C1;
	Tue,  4 Feb 2025 12:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hOvZX7Rf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD63800CF; Tue,  4 Feb 2025 12:22:29 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC173800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 12:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4u4zmaTAgdFrSfHC4Mu1vMyyT0b7JJl4ExZsTjlfo00g6jCJvalXoPpi+bhlyzG+RuhkkIMDDtRmmeN/sR5WMRCFb2bazbfXiZXBu656r3G9VzUQlbqxxoGAQTOJ8qzU1deR1FgWC6OWUmY2SMCcz7zWKWu2SP5kIT/8i44fzQUyiTNr01smVAbL7avi4qXc5wF0C5uK5T/5GC2a339+irGtKua0Z0eMvItTAo6keuRrEjQbLh71CTrkyOxVyLrxc7AJBfI37cuUQPdlVZmo5RwvXnL+fjjL0yZxFR8+XJiXI90iT5GHAfmoPgSCfd37nQqQUdiSBmmOoi4UXLyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sptd1oB7YGmCmmRhyfK0qwdJl84JZs8aI9yk4kFfuRs=;
 b=PnF/LCctIH8uprm4H4AHtekrPme2mp6l4ofKJrSiZU314f6FIOZiJNDEcb82a+SeJFKvAr2Uzvs2CBRsyiFL8Y+P7IqUGVIIFgjj1yXgcz8+L7FOyFHKVU682TbggtWqqBOKQq9J0KE2WjgtE7VAcJiSgCmzuCloZ7onyLQ5G/+2NfDpgfoiJ+5UHQThOBuj0JaBkw0yCyWpbDu+cpDXuLbg1eoL8QoIN+GP8lqe/3XWS+SfI+UqYGteN02N9Bpd0mL+cnB0rsmEUaW4AQVMWGYLG6dB7PVG9u7MffqYC2VEQ6BnQFhtmY9gdxJM4f05Vccgr5uxjLr7PRXFF5ynfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sptd1oB7YGmCmmRhyfK0qwdJl84JZs8aI9yk4kFfuRs=;
 b=hOvZX7RfOWsO5iv72V+HDumBiYDZFhiVrGKvv5ubRioz5edeJt/3NFIvZInyUv/3hLm7HLWtxwaTjHYr2elXEoTLwCCcWaIRYs6/47/oOTPoeWiDYraIOlgh8utrTZIfQBs+XoWZGGLfa7gDXg6z77ClEFBPsBnT3BtGxmLDc9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 11:22:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 11:22:23 +0000
Message-ID: <e1dddae3-d44d-4b76-a1a1-a30e19e6c3ed@amd.com>
Date: Tue, 4 Feb 2025 12:22:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Adriano Cordova <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0206.eurprd08.prod.outlook.com
 (2603:10a6:802:15::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH0PR12MB8464:EE_
X-MS-Office365-Filtering-Correlation-Id: f462246c-cc50-4d31-4302-08dd450e3204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm5wcm02ZzRvNFRUdFErU2t0ejVVV1RVbUpWOTJlckFwWVp4NHh3NlNSVkFz?=
 =?utf-8?B?WGpIZjVFYzk2aE9pQ1krQVNBaFVoWmJmR3U5Zk51cFlrQU9pakpwTDc5WkNy?=
 =?utf-8?B?Yis0dW5JU1ZobnFHUEE1TDc4aFMwSEhqS2xRSTRiQ3FjY1JRa3V6NWU0enlu?=
 =?utf-8?B?T2ZmWEZrYXdiUTlUSThhZ2lqNThNUVhwcExkR3dFUnNlTDU1aUtaYXlzeWl0?=
 =?utf-8?B?RVNCSXgxVTNZWWt1cmlYTWExY3Q3UnlQd2M5bUkwQ3cxSHRFMzNRc3JvYXZa?=
 =?utf-8?B?dkdqaFBaMkpUeVRhaVVKZEplZU9POFJ3SUoyREZhU1F6TTVoSWs3eDduNHZV?=
 =?utf-8?B?clVkS0R5NUppcUhzWE0vVUZyTkJmNGFjN3N2b1YvdVd2R3oyKytPQmhSQ0ZJ?=
 =?utf-8?B?ZXBWMnRQcUhaU3p5YWFSaDRkMWhoZzJweDI3bFpBUjk1TWUreHUxNExORVhn?=
 =?utf-8?B?SE9tSlJ3ZlV6VTU3bkx6eTlyOFhDWUdlVWF0SHNjQUZBbHF0dTF0b1BsTVVL?=
 =?utf-8?B?U3ZrbUdORm1VY0x4QTc0d3o3aWFHQ2RJZHJ2dnhuWUF2OTZHRVNudEFxV0pD?=
 =?utf-8?B?ZDcwUTZ3NWhvQnpaeFNINFc5NEFVeG40b0pEN3YycVN1cVVFaEN4dGk4YzlK?=
 =?utf-8?B?aW9HRTZPc2hCY1FWZzNMbTcwZG1QSndFOWd2dHJ0TzdBY1h6V0VzeGxOcUlm?=
 =?utf-8?B?dE9KbnJha1diK3BicXYvZFZGRTdKVC8ycytFMy9KUnc2VHhxcS8yOXFzYnEr?=
 =?utf-8?B?S1RKTTM5Mk4xYndmMG1DWW5HTkRFZnlrMWU3cUV3OXpHQjFBbktNTHNDUm9n?=
 =?utf-8?B?QzBCbDB0MlZpMHFrN2crSmJqWEJPTDJHUnFuYTV4NmgzVERhQXBQWCtVRW1O?=
 =?utf-8?B?R3pVK2kvc0M0Z1gycGgwbENESGQyYnlhRGFSZkFnK2pqQitZNmU4NWxBZnZS?=
 =?utf-8?B?WVdxOVI1RFdwdlZZNDR2MmFITEFLSU8xQldicEN3d0VZOFVXM2pIc2JuNVFQ?=
 =?utf-8?B?Q0wzaWRKOFRFaW42TFRsakVqVFNtQjYyMk9DdWpsRS9yZXhxT1VzdTJEdlR1?=
 =?utf-8?B?UlBkejVLaHFnTGxrKzZVaFJrU2ZZL1JBTjNQc0RjMkcycXZaSVZRaTZaeHJ6?=
 =?utf-8?B?N0daZFRVdWsyK3JmTnR3R1pNemdkOXhOaTNhbFJ4TC8zSWUxT3NyYVI5Nldu?=
 =?utf-8?B?dnpRYkxhYTJIWmN5SWl6VmU2Tm8vVkpKQTRqeWVDV0ptallQZmNRWlN6TnVa?=
 =?utf-8?B?VlJIYW1wRGR1Nk56bWVlaWtMQUhuZnFJVHZDaUpyeGFIUms2c0N0UkE5eGV1?=
 =?utf-8?B?N2tFNXFaQ0xZSHZKcENKWExkQUhpaU5QNVlsODczMGtaK3R3UzZyS0p0VG5D?=
 =?utf-8?B?dnhweHlRSDJrQmE1Tjg5ZzVLelRvQTdrWDYwbi8zdlVCbmVUUUhneG5KODdi?=
 =?utf-8?B?UlpMNVAxQktWRzl1aHR2RjlrZTBaNzdiSzlWZVRpS3hWS0tkZDFmZ3RDZXkv?=
 =?utf-8?B?cThSY2UrMS9PTUlNa0RVWEJDZGpVMEptN2szZ3QzdFpUR0JWWngxMGNoSkpD?=
 =?utf-8?B?K0tleC9oUWFqTmdleHp0YWlmL2IxK1IvOVhBbWhLa2RNUGREcDFzb09jaWVC?=
 =?utf-8?B?dVppclVkTUJnS0NNTGJ5SWpqUzFrQXpRQjlzb0gxcDMvZ0hrakIyRDEyUDIv?=
 =?utf-8?B?QlNyMW5ZZ0tYZGk2ckdFWE0vT3JWK3RIV2hndlU4c3pCVFNiRGpvb3dia0hp?=
 =?utf-8?B?d1lOSEF4WVFDSXBjdEFYN1k1ajlDT3o2R01TUHRyZ3ZkcXJEUkExNzNtclNN?=
 =?utf-8?B?eHhSRS9OV3BEOXJtVmhEaTBGYmdYTndPVExVL3o1REwvNUtFbUs0KytVa3ZS?=
 =?utf-8?Q?6h8H3fSZ+wPw4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZVRmdVbU9zZmRrQ3p2Z1IzUDFKd1dUWE1pU3g1U0ZkU1FFWE5UYmVGMTNv?=
 =?utf-8?B?NnpsME9CWHMzRkhmdnA2NUIyeDlkUSthUCtRWXZqN0FqUWF0VXhCSzJISFMw?=
 =?utf-8?B?TDhaanJZNFRjUEowS1VRSXNVbnRHTUJrSE5pT25POCtTZkQ1bjVIY2tXS09H?=
 =?utf-8?B?ZGl1MTNuQlZNTjhEQnkrd1RibkFrT092R2RQZEVpdVAzQk1jeUMxUGZaSGdU?=
 =?utf-8?B?eCtwM0dCWlhZUWROaXY4Rm9tNU11SWkyUEIyQ3JWVVdoZmpVWFAwM2EvOTN2?=
 =?utf-8?B?OGVaWmVYclRRSWFkMzVTYWRQNXdPRU1KcjRZTUdxYUQwT0N3YmJCWkdxYzln?=
 =?utf-8?B?dXNxVVpYWVAvUlBsdGdWK3VySVJRZ3VSc2lJOU1KQmM4ZUlWSFEreVR0YW1C?=
 =?utf-8?B?Ny9EQURuU1ByRUlvSW5uODZkY3ZCTG5xVm50R1hZZjllemNWR0NTRHFGSXR0?=
 =?utf-8?B?TmJ2OWVxcGwyUjFXR0d6aUlDWG9VbEFRZUJzZjJrbXpMa2QvUHRmelFFRFp3?=
 =?utf-8?B?UXU3eVhDb043eHhuaVdVbUlFanJWUHZ5MjRYY25FZVREbUl0THduOU9JcS8z?=
 =?utf-8?B?b3VNakRYczZlNEEvWFkrNkNjNGhOd0NZUVNFNVJpYXRXV1NNVUszYzNOY09v?=
 =?utf-8?B?VklOV0VoeDhkRVVvZmIwVno4cjljZURVUVg5cHRkT3lPQTdlQW1FYmFMN2F3?=
 =?utf-8?B?TXhyVnZpU0VNbTZwMW94WFJIU0ViTzlkankyT1FTTHdqSm9ZbXRPOTFENHBG?=
 =?utf-8?B?TXpIaFFvNFd5SmpKWU9rSHBoSVhNZnplTURZY0ErbEdxUUFoRTc0bmVpeTdR?=
 =?utf-8?B?M0pXeDNiYS81Wi90a1J1NVRtVkFGQnV6dkZJeUViVlVzeXFwYkZLcm5Xcm5m?=
 =?utf-8?B?Vk9wZnZuVHE3dmVib0Q2RTY5dlpvYytrUVJubnppK3pPazVhN1gzWStWNHlZ?=
 =?utf-8?B?aG9VbC9OTkdEWHBlMjUrMTFqUVVrOEs1dXZDUE5aOWxqUFR0NFFSM0ZycHB3?=
 =?utf-8?B?aDVtVkkyWFdkb1A1UUs3cWF1THJWc2RxNXZtRVlhc200bmlsQkduUzZoNGV6?=
 =?utf-8?B?T2xmV0h6MmN2Y2R4NmFra3RIL3RFeW5BRWpjR25oK1NkY21RSFJrNnBjVjdN?=
 =?utf-8?B?cm5WWUNNeFoxVSt6SU84UVdJcnhwVjBiK1FiL3pxRFFUQ2lUWVl1UjhlRFlT?=
 =?utf-8?B?NGxRc1N0ZG1hUmZxWmYyM0c1L3dWTHlQMVEvYUxPa0RtME5vajZKN29LZk1z?=
 =?utf-8?B?dFdtQkZOWWk5UkdnOUY3SU83RVNhcU1FSzZib2g2dklxdlJpT29OdHNNRWJr?=
 =?utf-8?B?ZUtURUtJMFExeWhHOFR5WU0wWS9BVVUwMlY1allobjdTUndYdUpkU1R0Mk5t?=
 =?utf-8?B?Wk9EOE5BSFRnOG5pU3VqUUNxdnkwUGd2Qkd0L2l6citud3B2T0p6NXp4VTlW?=
 =?utf-8?B?QlBIS3RydWpXNU56VEdXc2p3QmN2OW5BNjJJdUhXcW9IR0lNY0xPZk44YTA5?=
 =?utf-8?B?ZHp6ZCsyRU1nWXBmYmZhZ3hMaktvamh0VVNFbzl1akVGUFlQT2VDN3JlRVNQ?=
 =?utf-8?B?bjVEV21GUlBrL01YN3QwSm5PK3IzMVo0bGJRS2pna1N3cTk0c09qQ2dURXR5?=
 =?utf-8?B?b0YwZTIxbktES1lMc2dDalA1VUM0UllaVXlNT3RqejNGektOazF5RHpUeUto?=
 =?utf-8?B?OWxzQ1hxSXdDb0pLdkVwVkc5MnNoWVFBYmZ1U1M4YVJmRVI3K3dxeTY0Nkxz?=
 =?utf-8?B?a0VINDZ3QlhLdDBxMktkTnBHckc3cUpFajk3L09WKzVFZXU2S2RtVkRucUc2?=
 =?utf-8?B?YzBqeHRhNjk4dVhtVmpNVHlHQXNRaVRvYXZkQkt2ZytqV3dBdmFaMW04VDNv?=
 =?utf-8?B?SzJNc0J5cXMvSkczdWdNN3Blek94ZHByMXIydDExN0xLRUlVbDJYdEtsSW5z?=
 =?utf-8?B?bjRHelRXYnNvWmx6UVFVRlE3aTIzT09uSnVieW44TUZQWGg1S2hMcnB0Y3VS?=
 =?utf-8?B?Rk9hRDFhQ2x1Z0pRSXdPT0t3QzJIQ0IycUVlQktsS2lHUTZaeUZWTUhvSTVT?=
 =?utf-8?B?TjhvYXhCSFRiOGR4aVZJNHprdjN0L2wzaUp6bHZieXB2ZE9BenBTVzdjTWhF?=
 =?utf-8?Q?SZP0bHaicNDacIZO24fD2NoFj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f462246c-cc50-4d31-4302-08dd450e3204
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:22:22.9918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqyGWUzkh6W44uk+WiOGapQ+6tN6XDzufdQuj+L9uUf//rMsKg2ajUyJgcboPIdR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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



On 2/3/25 16:03, Michal Simek wrote:
> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   net/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/Kconfig b/net/Kconfig
> index 24508026200d..6c684624fd6f 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -249,6 +249,7 @@ config WGET
>   	select PROT_TCP if NET
>   	select PROT_TCP_LWIP if NET_LWIP
>   	select PROT_DNS_LWIP if NET_LWIP
> +	select DM_RNG if NET_LWIP
>   	help
>   	  Selecting this will enable wget, an interface to send HTTP requests
>   	  via the network stack.

Just a summary. Jerome and Ilias will look at solving this dependency in C file 
not to have this dependency listed. WGET will work without RNG device but HTTPS 
won't work. There is also connection to MBEDTLS which will be handled.

Thanks,
Michal
