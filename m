Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90ED29FB8
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3345388FE5;
	Wed,  6 Nov 2024 09:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1VNFz2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C4388FE5; Wed,  6 Nov 2024 09:02:35 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BABC88C4A
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1afZtXduKOaB5KUR3Z4ZLDicTTzQWLU4OvQnP2s3e8IZYWWCVcdYoJXcgRjDUh6zUuSIClAjQ3/fBx+7JvAeyHZclYjJnPjMpXFAKoAL/sSMnVkqu+2MJckjz0IzmXLLvly27lxj8OUJEBY9e1FMVXJe0U46eMH7OCUnhHRy4+KP36oVyZ8Hxa1xRRNxSRpaXCPLcMJo+p8FZ2H6TlGNQiDPzdHlAWI5uY1DnfRFJKoxyJcsOsNktuT2YmYRO08a7V/r1TwCyjfe5p/R0KWyDdXxo6q7TRu9QCiUK2FuaY9c486iifGdKXaJMoiT3hXqqG75RA4Oj5kS1fGiDL7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7Y/JEzTwkOybvnoi4z4IWMYgxnkP+owq3aHDGdHpiM=;
 b=bHYahoV8JfqtIGWIKRvK7GRkHhZ+2ytPwslic+rkQJzBsNUw/WRnXPE1z3MPL4sByahfR3LQ7SfKiW8vXLyPPRYMs9rKYYnxxzqxd/2qDh9pKxIpK6K9XN0x0Ff+UqR3n5c+rD3ey1hGCkcEnPwd93MbC3SwLTnRfbGUIP7tidNKoruF8+7gCaHT4aixs1BpjzG8CzibjVFrvtebAMvzxWRcEdrk+snQ2MO+oLbcqujRPHejS7Rb4y6qBywj03FxvVoCZKM77vEWjRVwCeVd8yae+enV9jnncxDLHOhAd5l2sX1nqL1UgbZ9kG4bIwpm+x/gCQWG5ONmb1fhQj7QrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Y/JEzTwkOybvnoi4z4IWMYgxnkP+owq3aHDGdHpiM=;
 b=x1VNFz2aGkOuY0+eI180USFqs5DqhRpvOuWqAvbatKE26S2XC+l1G2PUKR854EvfzwvtzxknPbRpDieDs9R07XmI1Mz4lYe7Z35mInwQEXjLGxxuZC/Ib8nm/WjgqbQcsF5fdfDOzt1XIzX25jDTG4rtMy3vwPed8HHnO8Hf0LY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 08:02:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:02:30 +0000
Message-ID: <31cc9f1c-1ad7-45ef-b593-c938b2079590@amd.com>
Date: Wed, 6 Nov 2024 09:02:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix pwm-fan polarity
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Saeed Nowshadi <saeed.nowshadi@amd.com>, Paul Alvin
 <alvin.paulp@amd.com>, Tom Rini <trini@konsulko.com>
References: <3e8e38b77101335f86bca0f05b3988877bb12993.1729766551.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <3e8e38b77101335f86bca0f05b3988877bb12993.1729766551.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0162.eurprd09.prod.outlook.com
 (2603:10a6:800:120::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: e11e9210-993d-4236-8321-08dcfe395ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDh1c2o4bHZHS1dQOUR0MkJHeWtZYzhyQ2owN2dQMkZEZDhBdUlONDJQRDFx?=
 =?utf-8?B?Sy9BN09YZGo4aTlwYTQwajNva2N6ZlAzK0RNbHpNaUNRTzQzYzExVDF2WlNI?=
 =?utf-8?B?VzJpVHVZZEpZUWZWcHArU1A2bUVrWkNFcEo0YTlxVFUrYmJWeU1GQ1F5VGt1?=
 =?utf-8?B?MVNaUWZrNkJLMXF0ZGhpdHplSXA5aHFSdzd6bGhrZmpkclA0SXQvcXVtd2tN?=
 =?utf-8?B?R3JyTWdEWU54ODNOOWN1WHVQMzFxVWVzUGNpVmo0RTNXeHdmc2tEOGNNOUpY?=
 =?utf-8?B?RkM3N255OE1sZFRiM0pqWU9QZzZEcDZGNDJYOHRRdTBDMzdkcHRkZVBMUWdx?=
 =?utf-8?B?T1dLYTFmY1Bma285ZTU0cklrSHR6YlBvZVk2TTRqdHlJUW1QbjlUVWswcnVC?=
 =?utf-8?B?c2IvQ2VtalhCZW00UyswVnN4dXdUdGh4b2lHZHZLRTlKc0NsVGR0TE40eVZB?=
 =?utf-8?B?VVJ5Y3F6enVwcW5yQ3JEN2pnVkg5MUl4VGZEWG9mcDh2bzBkVFIrMjRYc1hL?=
 =?utf-8?B?dDlTL1ljUGhrbWVocmxxbDNhNjVDTzlpaHVHaS8zeHowakk5SzhGQ29OK014?=
 =?utf-8?B?N1dRQ2pCQzQzYWVKWFlqem04U250Zk1lbTdLTHQ3allmcVloUEZCNTRxb3Nl?=
 =?utf-8?B?SXVVT25UUkw0UEUwTE83ai9uWElJanJoNUZqS3hTSDIzbFFEcTdOUzBGcU1F?=
 =?utf-8?B?dG1DalBYOWQ3NHlKblBBOTVCd0ZZMXlFOG5NbkF0YkhYd1hJamR4NEt6N1NL?=
 =?utf-8?B?alNsYm5jaHRkdG5IWGRHeHBBRk5ZRE94WFNwVVlwVVM3U01QL2paWjRxajBC?=
 =?utf-8?B?RGdkQVRTcjJIS1lqSEx2d05SZGVLMlNtbU0vWkZtTzNQU2dMOWJ2cXhRYS9y?=
 =?utf-8?B?SlJBTmVpVnh3akxHTUs4RlNHaVg2cVFPak5SUkl5YW1PL041cFp0aTdKVVpR?=
 =?utf-8?B?ZXEyTG1WZ3E0SG9RM05zWStTRDV0MTF5ZFd5UHFLY0pTd0dpK3ZCUHdyK0Nu?=
 =?utf-8?B?OVREdU5mTXM0aXdlL1EvWnIwU3pqN3J5djh1RWhzMXZLYmhpTnJ4NGV6UEFx?=
 =?utf-8?B?cjduem5mVUYyVWRzaVkxdEVET1g5Qkd3S2NUWlg0dEl5ZzZmTjV0UXVRVWZh?=
 =?utf-8?B?eWtBdDVjS3lxWk9LRm0wVHQ4OFp2QkFvZEZJN2ZYNG9xa25vSFlNT3RmL0V2?=
 =?utf-8?B?MkhOUEZZcHlXenBsdGpHcklEcndxeDRabEpqSGxkYUtzVTZyc3VUZWxRKzVv?=
 =?utf-8?B?QUx5MThoc2N5bDJSTXkrR0FQWkpVU0hvd3RYS1g2T2hMWXoxbGRwSi9WWldh?=
 =?utf-8?B?MGxnbnhBcFdQaTRUa2lxZDBZSGVkdjYzUks3VG1iTzc5MTRXR3U1a2Y4WlpO?=
 =?utf-8?B?OUNnYTJ3a0RTL2FNbFRnT0s3bExEQml0RUd3eWJSS3YvVkRLRHBvVEpoWTA2?=
 =?utf-8?B?SHFleWFBTHY1U1Z1N29IcURaRFBwcjBBS3BrdzM2bEY2UDZ3YlA5cE1wU3NF?=
 =?utf-8?B?YUpMQUZxbXhPTU9Vc3NaL2k5SVV1bnZTUDlRNDVwaVM1b2ZXNW5ZTEdtOVZ5?=
 =?utf-8?B?ZVQ3b1NFekVlSTNXSDQ3bmc0RzduUTdBSWxCN2UycFhxUUVSMnFicDM5ZmJC?=
 =?utf-8?B?ZVNxK0liYkltM2lSL293b25Md1hLTFZNSUFLL1dVMFN6akNTQUVOUDFOdnNI?=
 =?utf-8?B?VDhWMDhFSnBxR0VtbFAyZlFxQmF5UWJVZ1V1ZVJQa2g2MlNxcHBVN3Z1QURo?=
 =?utf-8?Q?flsSMASuo4V0FHxUDMLeoSpvSeZTGEFpS8+jQ9q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVoT3BDQUY0Zyt3OUNVdW05WnFpQ2lzYWJLS1kxK1RLVnREVUF6cDNtclV3?=
 =?utf-8?B?N2J0U0plUnhWYTNlekJqYUQyRXNqQXowazRkbng2aWlKa1dDcWwxOGFocUZv?=
 =?utf-8?B?UE10bVF2TXlXVkZpUWx1TEg5emhZaytndFdJOHNoUWVHcndzbFk4dUFOZ3A4?=
 =?utf-8?B?NWlFYjlpUE9mMUJ5SmQySmpXcjIvV3VvLy9lWFZIQUNkcnYzOCtva29Db2pT?=
 =?utf-8?B?ZEx5ZDdXMXlvVmVVTmpJUXE1bEpVa3B3dFQvZ0x0UGc4a2JOYlFmU1ZHdXVj?=
 =?utf-8?B?bmNDdGRHcGFkNzFuMlA3emtkbnJSYWFsUFZQNHk4bHlUVFlBRldMMU5WcG40?=
 =?utf-8?B?aHRRbDl1ZldOMHBGM1cxd3BkNUp0eW45czVMVk5ySzlPYkcwZndHQ2EvUWNL?=
 =?utf-8?B?S1pOUGJsdTdsOU90SWRWYnkxUmVGejk1K1YxVzgwWEpiTW0xNnNQTDZ1dmVt?=
 =?utf-8?B?Y0s3NXZ2d2xrek9Td2QxcWl3dkZ4WEQ3NDk4TGpGbU9DZTBIa2hHQVRrRzBu?=
 =?utf-8?B?YW1Va2hyNkxnL05sMm85Zi9KZDJWcVcvL1RlRnFUM1lvR0grVHRSWnpnMDBE?=
 =?utf-8?B?ekZiOVpGYU91YndOSldiZjBTaTVyTG00YVJHZjMzQTNJQ1l0S2RIdWl0S25S?=
 =?utf-8?B?YktRb1BnQVNybHBZMjdqczN4OFRHcDFmSDZ5b2I4aWpXenVrcEl0RUljMEVl?=
 =?utf-8?B?MW9MMGFhUEFhU1ZzVTBCV0ptTVBETkpKUGRkL1NGU0loby8rdXVWQ29LS1Ra?=
 =?utf-8?B?RzlwQ2xPR2RVSWRDZlBVNnRuSk5vbjByNTdSTGoyUllPQmRNMFI4YTVCUVV0?=
 =?utf-8?B?cmNCa2t5YVRYZHhVK3lRbE14L3ZzNk9LZGFjQmh5dHBqR2E3TEdXa1FtSnVu?=
 =?utf-8?B?cVRES1NJdWdpZUl6VlpUMDJncHQ3SjlHbkpMaFdPWlp4bnU5N2plc1lMRCtq?=
 =?utf-8?B?TEpXVFBhYjMvL2lYazZvcmY3dGZnRnNmajVEZzFkejJEVXZDcE1UZ0JYSjJH?=
 =?utf-8?B?TzlzbVpvd1RuRzVMVzdaWi81amVSSSs3WnVqd3VCY21TWVFORjhFSmtqL0hL?=
 =?utf-8?B?Vk5oREhMaVdBNWhEa3BOVkQ5bVFTUkdzSXV5Z3R6MzE3Y2ZrWVhoTGNPSU9O?=
 =?utf-8?B?bVpVcmRweHdMUDBnOVNES1h2bkZrVWc3amh0ZTAxbUF0ZThZK1RaenMvdGNS?=
 =?utf-8?B?d2E5bGt3d0Zkb0xRYVc4K29TblpuUHloaFFDMVhMeTlOcWovRlU4RFIvZEZo?=
 =?utf-8?B?bVpnaWNBUGNqdS9NbnZoekk5Rlo1QWh6YkFDQTMydUdsSllld1hPMGhEaVFh?=
 =?utf-8?B?K3VUMFIyL2FiSWdCamhqY3g5RjFjOXRzNW5CcUwrR1BmOFZTTzgzcnIxblNz?=
 =?utf-8?B?YkFLaytjSUlhNzIyWDI3ZVY0V21iYURxZFVrUDRBdzUwQmZkMHA5N05aWU0y?=
 =?utf-8?B?SlQ1anNJSlVHR2RJMkZydlEzMUU2Qmt3RllNZFN0R0p0SkVsSkdTUDNsUzJH?=
 =?utf-8?B?ME1NSUw5T3VYZ2NDc1ozVzJzaVpVOU9VaFRHbVNFYVhKekVDTGhwN2ozSklV?=
 =?utf-8?B?VUtnWUpPSzlaWUgybmlMbnVvMXYxd0ZUNXo0ZDlDZUN6SGd5ZE1ZWjJEYkFM?=
 =?utf-8?B?M1Vqcm5IaHVyWUkySTNhOXkwRm1GaGxFK0J2ZjhGR0hDeTFLYTFKTXJ6NDR6?=
 =?utf-8?B?MkxFNjdFMUtDbVFsZHF0KzlPUFl1R1pVeDQ1ekxyc0hSeTBhSmhmdUxtRXpN?=
 =?utf-8?B?UE5Gc0l2VDJvWmZiNFdrSDEzVWt1OHB2bm1xcnZQbVBIUVRycVRYdG5GbjFT?=
 =?utf-8?B?N08wR1BtSms2a1NNdmJwOTlBSmxSMHpvRk16QnF6Tis3SWRHVU9QMWJvaTZV?=
 =?utf-8?B?WEZKUkMxUThBQlJyVjdmNUdNRDlHaE1FLzFHWlVram9UTzBCb0xIWVo2OGcz?=
 =?utf-8?B?RlJiSUZzYzFKNVhMQk82MWNiZHdrcytKMlNCR051aUxULzhDZEk0RUgrZlgw?=
 =?utf-8?B?Y2hUVGRIYnZxMXppL240NXB4YTlkM1NQdjluQkZMeit2clJPdEV3WHdoWFo2?=
 =?utf-8?B?RkhHKzhxcWM1b0MrNU1Qc2VDQm1reG9Nc2hCN2V3TlltN0lSc1VUaE0zZFEz?=
 =?utf-8?Q?tfTqb7v7gYsVc/CI0nGh/uigd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11e9210-993d-4236-8321-08dcfe395ccc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:02:30.5674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v93K6W1asClFBo9Ck/zGoJlSB6UAadlampMJoiu1Rwu7km2FXquRxTxTWafWeRnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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



On 10/24/24 12:42, Michal Simek wrote:
> From: Saeed Nowshadi <saeed.nowshadi@amd.com>
> 
> In previous version of pwm driver, the polarity of pwm were implemented
> in reverse.  In recent release, that issue in the driver is fixed,
> therefore, correctly set the polarity in the device tree.
> 
> Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sc-revB.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
> index 1af3f643567e..c4f70581695d 100644
> --- a/arch/arm/dts/zynqmp-sc-revB.dts
> +++ b/arch/arm/dts/zynqmp-sc-revB.dts
> @@ -3,7 +3,7 @@
>    * dts file for Xilinx ZynqMP Generic System Controller
>    *
>    * (C) Copyright 2021 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2024, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -80,7 +80,7 @@
>   	pwm-fan {
>   		compatible = "pwm-fan";
>   		status = "okay";
> -		pwms = <&ttc0 2 40000 1>;
> +		pwms = <&ttc0 2 40000 0>;
>   	};
>   };
>   

Applied.
M
