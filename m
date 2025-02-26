Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF683C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B0E80F3F;
	Wed, 26 Feb 2025 10:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MBZEfnH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEB48004F; Wed, 26 Feb 2025 10:52:41 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF1380977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnXoPYavdtwW7dgmeyJf4yBmuZtQRxLJoPHOjhkFf010vpp2pu1qcfitDSjvk1EA9FPsT9a1n63prp15u7fG92A6frnbxjhXppb+rinf777AkuNyUZ2CdWJLjBYLrmVnIUahl8HZPeVA9sh5uEmq4em1FYtfhx6oB0nPJ976LbndC3qoe8XrDjjTnLb+Yu+qfnva7uNWZ22mK4Qb4Of9eS/3QKLRcQ46vuzrEcvP01JKLVyIvPThPn553kkj6wYQ56an3BLmfPLSar2M0eO56HdBxtkjaa3DEfd7Nb1VujXmpBwnltIAZXJlHoeb+HPlfDlCto9O8b9UC1axyp+PSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEyjcPQWmBruMRQULbqJT+9Lx8LiEBySNoMmXg5JBYQ=;
 b=MxhZet9I6DasN9e7n8SR2YA8e0+qcL0iBB5B+sMWs8TsDq4jLmUzCVqiTrzRmh94vcr1UJEDvv0Zaq60Ei8mWyrCyLyKlYJwhU1Jr6UIS2GX6fJtRn68EwrxOv1j85iuMjXtkcPLmG/IxqVJZpHdITw75d4ETCixUEoRfpqCY1YwrYqIJsKWoHLoYW23uNF5kXhEGtIlRRn5fehRfrio+CY091L8XjHYxU0SbbKxEaOOFqr+zeza6A4cdtYIHr1Z+IrF3E6BNLewmt4H4ldVcIxowE08JECHWsSVlhsrzeylRqIK0IrzZAiZfwVPiOou4dHv+QoSJjPZE08kyQvS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEyjcPQWmBruMRQULbqJT+9Lx8LiEBySNoMmXg5JBYQ=;
 b=MBZEfnH5SFgmqwG45lR6MsdSiKJim7ywgntaLDi6Y4jFqhFWtp3+4aQg4xOKQtOe9phoD0uQGXHrLYlf7ajzaRx9rotPHLqn3Am7dypzoswtwk9bqw8RwnoDAdrF2/EYNYmYGi4UMEMKrSxm9GQuwtahePtkN9GP3PyIrzvK2uM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:52:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:52:34 +0000
Message-ID: <d3feebb3-3a56-47d3-ad32-ca95d48eecc4@amd.com>
Date: Wed, 26 Feb 2025 10:52:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: versal: Store driver data in data section
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20250218052419.1141139-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250218052419.1141139-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e29131-dc16-4bda-92ca-08dd564b4b7f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGxQaU1RSWxReGxrN0J1NXNvVkxJcGttZllhelZYVzNaWHc1c3M1WVVWd2dY?=
 =?utf-8?B?TDhDaE80ZUZTT005R3dqME9aVXR2TEVWOUtnT0YvandsTWJpRFJlUWdtVndB?=
 =?utf-8?B?bE5GL1N6bEVsa1Npc1g4VE5hbUw5ai9qMUt4VEdzRFJ5bnd4ZTBPTkcyNU1z?=
 =?utf-8?B?cGExZElKT3dMSXZWMFgzZTFzZG40eFlxQUV5VDJTb3Boa0RVN2ZqampCNDV6?=
 =?utf-8?B?bERjUUVTVXhBd3g0RWQwVGYxMGtWSnUrUnEweCtQbkU1aklWU2RPQWNBNkhO?=
 =?utf-8?B?bkRmczN1QjFtUmRVWUdBL0o1OHA4VkV3b0RxVmdzS3dsbFBKWWdERnpoekxP?=
 =?utf-8?B?czgwemxVSTU0azliZkhVa252UVE3VXNCa2ZCMFFrQXZoV2VmWDJDR0lFZU44?=
 =?utf-8?B?ZDFYeHFlTnhQQ3dMWll3dmFHR3ZvTHJNMUhocU1pZC8vMHM5VVlUK1ZnYVJw?=
 =?utf-8?B?ZktlM3lyVEVrdzdWUy90MDlJUWljY0N0Nm1jS2lIU3U2WWVJUVVIQ3lCVHNV?=
 =?utf-8?B?Zmg0RkVqS1BLZ2VBSmMxTWhEdlppZnZ3bjhUTU1GTGdSc203b1FKby9rTE43?=
 =?utf-8?B?cFkrK3BhZGRSYVBzN3ozMnp3ZlpXNjFabFdlZEJkUWxzSW1yZXhXZW5PTlVv?=
 =?utf-8?B?b1MyR05EKzZNb3oxT1JZTDJEME1ZWlR0VDlsZ00ybUNQOFlLV1J3dTkrTmJ1?=
 =?utf-8?B?a0d6blVYTWdGWURicy82SzZucWhNMVY5angrYkM2alFqU3RpU1RtMlBjSDZo?=
 =?utf-8?B?QkJUdVVKMDU5UTFnVk5nRHlScm5HbFdMYmNodlY5bEZUenFQam1peWlRNHZo?=
 =?utf-8?B?MHNMRUc4aDRyZC9yZ1krbktUU2M5dHVvVkpiNFVybnNrajh2NDZhSm1Ua3J0?=
 =?utf-8?B?ZmpzRHF1Smk2cE03UXA5OG1uZmVwTkRQb3Q2eE9hc1V6YWlUc1ZDT2hUT1I0?=
 =?utf-8?B?QWp4NHpjVTNwOEFMVldTb0VXRURnSlM3cUlZWVc3RnM0WDNuREhpMjVmN084?=
 =?utf-8?B?TnltWHcvQVg0TUJyRXFFS2NLa1NLSWlKc3R2VTFCVEg1Q2hYdTlqbHZqK05a?=
 =?utf-8?B?ckFNcFg5aGhpQllmMVR5cHNHT0ZLR1RoQ3dBa3FxNTU3V1JYTWRIMHo3djJ1?=
 =?utf-8?B?QStZTFlwSnZoSjRsTGt1dEJSd3FFQnlEWTRuNk1QbUtERVNhbFB0cHZ1ZTVp?=
 =?utf-8?B?YldQajlOOXdSNFlDeTNFRkVWQzFwa1Jjc3dORjZXQUhuQm5wYS9TY2MxUkh1?=
 =?utf-8?B?aDZMTWtZaDdVVjNQUmorNmpmQ0owdFNDSFN5ZGJIWXNwaXAvOWN0TW5kVEds?=
 =?utf-8?B?RUV3UnhxRTA4cFIxTnRoRy9naWJwTFNRQWJOSFpwT3dFaStCYkxLdkVYNXdN?=
 =?utf-8?B?eXg0MlBmL0Y2ZUV4TDFTdE51K2J5SGdlc0FmMkpKMGxSc3RQVUtzckpQNW5t?=
 =?utf-8?B?MS9JYlA1cWpjMDFncVQ2b2VYOXFUN3V5T0ptaHd5NjRDRDdWWHdheURzMnd4?=
 =?utf-8?B?cTRBNW5QUTQxNXFSaVNyUXppR3NKRDlmcCtvVnhpV3ZkVHIrdUp1NGpWVzE0?=
 =?utf-8?B?ZTRUT3RmdlRyZnNwNVI4cGZFZXM5azZCM0RSb3NqSWpHQTBpNnZOMXk1OHdq?=
 =?utf-8?B?V2hMdFFmZGFwc1ZWbHlwSjZya0pEVTlPWnFidWp4TUNKNDR4dkd5ZzlucDlY?=
 =?utf-8?B?R1FpT2F1LzMwbm5rQTVNTDVJQk5ERlFZQmhZY3o3WnBlK2FmSFl3czVRTEVB?=
 =?utf-8?B?ZWlOL2FrRllCU3ZLMkdmZithV3RDL0VNRllmY080VGQ1aFdqZ3hBTVUwdXdu?=
 =?utf-8?B?TUJkT29yeWhkMi8yUUhtd0NuL3BYZ25OcXoxWXI2ZzlkQzJWWTI3ZVlaRHd4?=
 =?utf-8?Q?mdnN0HWV1w9/X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBMZ0dna2hLazRodVRaMGpkbjlmeEk5L3J5OU5ZSG5TYzdRZHRCeVQzQ21N?=
 =?utf-8?B?dmFpd0lSUk53bTdSUkt6T3FUU0JVUGZmSjRxWExTUXlOcVh4OWNlZnd4OGhJ?=
 =?utf-8?B?WUlZbDlUWTQ4N3V6amE4QkMwdTg1MlVtbCtDRU5TMk9kSFdGS3JQaThJeHFl?=
 =?utf-8?B?YnpHZm5VUEgzSW9UOVBRcWpiV0NSU0VDam5uZ3RQM28zSjkwc0Y1YVNLeG5x?=
 =?utf-8?B?V0hqUmZseHp5aWRLR0l6K2l2VDlUN2VBVTNKeVdDbzE4YjJkcEtqcUNjM3pV?=
 =?utf-8?B?QTJOcUVUMjlpd20rclVhcGJGYzduOVpDUXU0VmFpS0I4dmRJNE8ydW0zWkwx?=
 =?utf-8?B?anNETHV2cmZ0aVVvc2IweEJBYkdjd1FycVp4amkrQmJCM0xXV0dCaW9CWVhQ?=
 =?utf-8?B?a0dMWUxCdk5yaDBTaGtoMHR0Q0VKWkFpU2hzaFo0L3BRN3pVZmJTb1I3ZTY5?=
 =?utf-8?B?M1pTTzg1UnNpM0hPSHEranNUYXNEYXUzeWMrVldGb3pYVS9QaGRqWC9KZnJ5?=
 =?utf-8?B?Vys0aVB3NTd1WEI5eTY3Qkw3cURoY0FVa2pHK2FnRjVqVjEzeUI4d2haOWdU?=
 =?utf-8?B?dk9aQWk1aERHWW1NeUZVU1QxdFRLSjVIODF4MkhRRVlyMTNLRkoxRUl5Mlk5?=
 =?utf-8?B?TEhRMjNOWHgrT01QMTkxeVRxMFNGVE9oV1RLdVlBOGxqYVlicmJ3Z0s0RCt3?=
 =?utf-8?B?Uk5JK1lwb0lJOTFUWVVYVENiQ1V5d2R0WThha2wreXhYV1NKSlRlaGhkbTl3?=
 =?utf-8?B?bzRvWGp6T0dQNHNKUmxyM29ya0syb203RmNSb3M0YkFob2l5aHlYSmtQc0g1?=
 =?utf-8?B?NTgvS2dFdEo5WlYyMis1TGxGeUQ2Q2d6cWxqdVZqMGliQmQ3VlVsMjQ2b2tB?=
 =?utf-8?B?cC9SV1AxbmN3Q1hXS3N2SVZrR0V2cFhMQTNpdURhVm1sU1JGejZJbEZwOGg5?=
 =?utf-8?B?dHlZQythRGVHUVdsWCt4SDJZTy9ibnZnbG9QUGp0SnVsYzRFRjFmTlAwbkZ3?=
 =?utf-8?B?bkRmWWQ1S1FVRXN6MW05eU5YYmJlUVRPci81Y2I1VjlrMXpJWkJEMUxrZXJH?=
 =?utf-8?B?ZGFSbG85bHJiTndkeWg0N0QyQUk1K3ViTlJCSno5N0FsZTdidTRQYkI1SG9s?=
 =?utf-8?B?Um95TGxvdDlKeHl3dGZOV1U2cmNjL2xXWGt5ZkJIdW0xcDZ2dy9qYktCRWhV?=
 =?utf-8?B?eUEwMlc1ODc1YUE1cEJWNk44V0ZOMkkxTGdSN1NLQThTU1V3aTRhUFFPelkv?=
 =?utf-8?B?cE1pMzZIZjh2UlhmZmJpRFR2UE5HeE0zdnpmb0E1YnhPV09OOVdieHhDVHBy?=
 =?utf-8?B?Zlh2SWlUSEh6YUxjeEhsMnJvM0UvSm1GRTFWZC9KZkEyR0VlZzRUL0FPZWZZ?=
 =?utf-8?B?YU1MMzd2aEhwUUVCNnFTWFUreUhURUw2Q05vME9iajhjWXRwTnJjZzdCLzNW?=
 =?utf-8?B?RlMxcktyOTRSM0RlNjBCTThDbHFSTnhoNXN1NXdSUUYvUmdEVUgxcUtyNEs3?=
 =?utf-8?B?V3JibHdNeE5lektVRnpheElEWnFjYk5ienNVelR5RWJqUldKQVdaV0RpQnF4?=
 =?utf-8?B?L29Jd2FZVnpFT2xzc09KbStFZGhHU0YvQVdYc0FmY2g0OTJCbUc1cnNwSHZy?=
 =?utf-8?B?OUI3WktlNGZSRkM5cEUwMnVUNTFia010U2lNRStsV29Pa3oxMEljM2Q1bVJG?=
 =?utf-8?B?MSs2UEhrWXNFVnNpdXZyTGpBbU80VDNjZjNoR2QvZjZhMG4ydmNkVWhQSEhO?=
 =?utf-8?B?UVhIa3RNT29ya09DU2lOKzREZUY4YmZTTklTdkNGcm50R1UrVWRNL1cwaXRU?=
 =?utf-8?B?MGxTalVBMmRqQzZZejNMOHNsNWhBU1RMVThEYURQaC9EMWtEUjZDUzA4ME9F?=
 =?utf-8?B?U1l0cnZlaDR5VHJibnNnY21jeFV5TkliR3FYL21HbnVKYU14WXJoZHl1ZXRB?=
 =?utf-8?B?MzRZUTRzdE5PbElTRTNOL3pCQ0Fkc3N1elFGTVRaejdLQ015bFJMWTQyWVF1?=
 =?utf-8?B?NWloWTVnaXg4N3lsbnNaVzdYUHB1VUcySWNSclA2a2x5dEtUK2hwdWV3bFM2?=
 =?utf-8?B?SXNaOEtmcDRhdWJwNDhRWGZBWTBaQThFRmcvenBXbFNMY0dJMDhhQ0Q4MWdW?=
 =?utf-8?Q?/C9d1NbJHtj4b6Tqcq8OPMtTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e29131-dc16-4bda-92ca-08dd564b4b7f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:52:34.7978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01fGH8QpBo7EOOFxjzvjGGuJfjlcyIp8y8trL6vxQZD4VZRSGXu7FI6V6bjx8Krb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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



On 2/18/25 06:24, Padmarao Begari wrote:
> Line 171 in README is describing that before relocation
> no code should use global variable because global variables
> are placed to BSS section which is initialized to 0 after
> relocation.
> 
> On Versal platforms clock driver is initialized before
> relocation (via using dm,bootph-all flag in DT) and global
> variables are initialized which works if this is used only
> before relocation. But the variables are used after
> relocation too but values are zeroed which is ending up
> incorrect behavior.
> 
> That's why place variables to data section to ensure that
> values are not cleared which is for now the quickest
> temporary solution. The correct way to do it is to move
> all global variables to private data to avoid it.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/clk/clk_versal.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 35ee56d0693..675bdb7ac0e 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -106,8 +106,8 @@ struct versal_clk_priv {
>   	struct versal_clock *clk;
>   };
>   
> -static ulong pl_alt_ref_clk;
> -static ulong ref_clk;
> +static ulong pl_alt_ref_clk __section(".data");
> +static ulong ref_clk __section(".data");
>   
>   struct versal_pm_query_data {
>   	u32 qid;
> @@ -116,8 +116,8 @@ struct versal_pm_query_data {
>   	u32 arg3;
>   };
>   
> -static struct versal_clock *clock;
> -static unsigned int clock_max_idx;
> +static struct versal_clock *clock __section(".data");
> +static unsigned int clock_max_idx __section(".data");
>   
>   #define PM_QUERY_DATA	35
>   

Applied.
M
