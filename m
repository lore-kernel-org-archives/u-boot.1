Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E18D1038C
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 054AE8418C;
	Wed, 26 Nov 2025 09:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5GU9gqjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819F08419C; Wed, 26 Nov 2025 09:18:56 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BE984142
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDnpQMmYDOf3UtAXAqoQNRQsNNj3HM1ji63tcl5iT6Zg0Ouw1o9GaDDaekbPf1LVHv86xh1mbzIVDMncDheK+H9bXnaafusi1ta/Ltr6X/uKYt5v1NVv/cos4WPfI5bBmG1agNMki1S1EZ5z6GhUh/8mpmkmrNOnVDGGc+E61aCvcQq2FY8Xbil6q/cZJj5x7Ir8DZcdMi98KprvU0eMmct19jtnvjmDe+H26iu/nlvsFnjM2Z6H1/9h9jHSdhGj3VOSPlYfSoK1U62O6Vjo65xaVSAvkN3bum5gl41JU21TBqRgKvsaa6zno4w6zzOlEIqv76jOOin6Fb+HUprDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNuBJa1AApL6VXJc61OYTMN1PUSGqofJJKInqy4GoNo=;
 b=Xo66nWBDzWD2IG+GhTUiI2T/nrx3lH2vfRVmQO9vFBKVpKYcM/+8YaTxMD7iZM984oje6LzfvGv7PZmduwkqJxj5t/p01llcWgwj+qjaZNyRCadpRn5sUzpMB0QzHma5pNkdE7d+hOuOe5QeavOP4JyP7zuAPISECICzhMnfe5t0J4qXqSitIUaky0Yyu7smHv55Oysp5CiLknrdSxf9ExvsG/zkyb9ojg1XPgrr+GMwaHVUTJ8/9hjYzmZPPlXio2leeqri3djKl/EDWmWJkYFrAov9pFcUCnF1SPR1wX+H1bE7FZdhWzKXRTwadC9HmWw/8+dvPz+pgpZPlSC+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNuBJa1AApL6VXJc61OYTMN1PUSGqofJJKInqy4GoNo=;
 b=5GU9gqjdAX4ubQWkoPLly60a/jRw05iFGFDqrvMEG1pRYGIlOc36Adf+4S716jBYoLIE5ZJ2sFQHqnbVFZDinnj8ge+PFfT0nEj1LEFl1+p+yXiVq+yK+CpremfZk2iv2nY6kgl1BKvV5tfWus/z5d5jQ/4mlhxLOfmJPE9NCH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 26 Nov
 2025 08:18:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:18:49 +0000
Message-ID: <c684b685-47d9-4e87-9176-21610754e533@amd.com>
Date: Wed, 26 Nov 2025 09:18:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Remove unnecessary #address/size-cells
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Tom Rini <trini@konsulko.com>
References: <7612a3817480f4089aea3e14cca07d585f8fddb5.1763551956.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <7612a3817480f4089aea3e14cca07d585f8fddb5.1763551956.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: f31db90e-3308-4900-0be9-08de2cc46d23
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnpPMDB5MGFVYjkreFNoUFF1cnh3WmdrMXZKN01RY0gzRW92U2FCWXoyU3Rt?=
 =?utf-8?B?c0xHZCtpVGwwYnNRZ1NMRk44K1JxdmJDNlJGb0pVdnY2Q0lxL3pMU0MyK0pl?=
 =?utf-8?B?VUxXVWdrRCtlUy9iYm9DNWxBRHMrOUM5OTlVcldxb1AxUm5YODhwTGQ1OXJG?=
 =?utf-8?B?ZjRFY3IrcjRlQ0JlV3VKMWRQVVdaQWRwMTZsc1o3bUxzTVNYR0ljTW55SW1O?=
 =?utf-8?B?WlBOQmNzV2J5Y2MydGFmRThSOFZteHpHdXVSNlU1OHZ5N2JLQVk4dm9DdS9M?=
 =?utf-8?B?TmRNcm5EMGpZYW93b1p3bG5uaUZ3ZTdQRVo3SzNMMkdqVGJweW5HazBqUUNl?=
 =?utf-8?B?MVZpQlB4RW9tb2MwTDFWdzkxaVI3RVIwWVVBY2FuaTBKSlU3NU81SUJ1eTMw?=
 =?utf-8?B?ZWUzNlR3cllJTzNjeGViUHpPcnlYZGVRSS9QMERHYUl0aXl5WWwvRnZSSmdm?=
 =?utf-8?B?ZSs1K25Jc1EvMStWdE1scUhNWHk4cXdENWdqM0tiSUxncjh3NDdzeldnVkV5?=
 =?utf-8?B?WXNrdWExcWVsaGFXSCtDbFg2a3JHZGFIZ0lUNW1CNjNPZGRYM2FqUUxHMXJp?=
 =?utf-8?B?SENmYnM3OXhKaEx3YUJYbTFrODZCa2V5ZURYSmlTNkNzWE5kbjRpV0pwRjFZ?=
 =?utf-8?B?Yk9TZFpaVmpJV3RxVjhZMEt3aHprQ0pseU9WM2NGZHNrcWlJVU8xU1FHMDdh?=
 =?utf-8?B?MU5IMDZPY1JEb2x6bWpFZ3hRbmptUmtSMVRnaE85a3FaNEp5TTBrd1VMQ2k3?=
 =?utf-8?B?RkJOVFZkaTNINFRhb2ZWcXd0YnkwczZPdEU0RGp5Z3lxdUNsUjJCZjkvajZC?=
 =?utf-8?B?MjlZUHlYeElQSmFmZ0hGalNTcmV2RVp2a0oxMi9KM2xRSTZaT2dqRmNLMGZE?=
 =?utf-8?B?UG0zY2dIbElaTE1Fd3NCUmtMNXBMRE5hWFlsUW9YbktJakkxdnhFWkZkdm10?=
 =?utf-8?B?L3pud2hKRTBGK3hjSkgzUXlKTlhWZnN0S1JzN2M2NjVQVnRSdTdoQzdtdnRF?=
 =?utf-8?B?UHFCYVI1eWlwSDlOMS9qYXFVRitsckJLbm1kdEtIL0lnNFNqci9MWlc3NERs?=
 =?utf-8?B?eFlrVXBrenBiM21YVy9kMGlYa2NrMDVNK0NycS9BRVVhNU82YTNTRHVrMUFx?=
 =?utf-8?B?eTR1KzdaSVhJOVFuZHRvQ2ZnZnpFRTV4bkpDbHY4blh1Ym8ySDcybmcxeVNM?=
 =?utf-8?B?WkxOTU1ULzNCVklZdW5ZQVVkaVBsbTY2ZmdsUU5GZUNFaXNXYm1LZzNkZFh1?=
 =?utf-8?B?V1ptK1VZcUlSRGduWHlPUkJuaFA4K3l2WnQ0VHNlWXkyTVdzQUdSQ3hPNkds?=
 =?utf-8?B?R2xQcmNPWGZwbXBBMXJVd2ZacTMxZmgzeWhDcnAzRlZkL2c0Wk9GZXh4cHh3?=
 =?utf-8?B?ejV5cnMyck8yUnZFMy9WNnNqMllnNXZLeDlGakhaZWlJWVROZXNydFMyb05v?=
 =?utf-8?B?R255QlVyMGVQVG5TN0FZdGRHamFpSU1VZ3RsUUJHUjJ5ckdQY2hlY0Ztc2M0?=
 =?utf-8?B?R2EyanNDd1M0d1hXSE0yNTl6S3Y4Smpvb1poWVZ2VjZMNlVkTmhncDdsV3hP?=
 =?utf-8?B?NCt6alF5NDZLTlkyMy81YmJzRWozQll0Y3F3L09VeHFGMlhyU283UzhJRmZZ?=
 =?utf-8?B?OWNwakd1UG5JMjlnbjVjNWRrK1A3R1dtQSs1WHc5TEZmdEdxb3ZNaXRsdzRw?=
 =?utf-8?B?S0hWc3F4SGdLalJvRjVySmFuTjRoME1RcUM4TU9jc2FyR25ZWjJjWHNudTk0?=
 =?utf-8?B?MXhYbDd0SVFCcGlEMVh2aUM4cytjNW93cC9TcVdmQmFVUG1rSkxKM2FuMVMw?=
 =?utf-8?B?b3ZvUzlLTEhDaDZhN0ZSeSs2elhYemdjdVMvczZIalVUQVc2V3BXY3pTMHl3?=
 =?utf-8?B?NHZPZXRQWjJUWThzd3E3MGJoZC9FdkNkTWFjMC9SLzFESTNBekM5RUZjRmVK?=
 =?utf-8?Q?wvPXnKjj7WdUSU44oMzU+zCvmgNzhAR+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2dOVUx6dEZIWUtaUUJaYmZTVzF3Z3NsaStGMC8rMmQvYjl5aFM3NndxdXk5?=
 =?utf-8?B?Q0lCM2xkSDYwR0hSNDJBVVhTNEx0ZENZdVR4NTFzR2ZGcFNVUXU0WVpQdE94?=
 =?utf-8?B?NGlLUFZkaWsyU1NTeXQ3d25RWkhTSUx6c1pJeEJFTTN3M3luUjJ1UHBuc3Ez?=
 =?utf-8?B?Q3U1RzZLdTYzcjg0WVMvRzZDUGdFL2RDTHpXdFdCb2VPV2s4SHhEcnpNNjJ5?=
 =?utf-8?B?dnRJWnRucUkvNk9STFZ6Mk1NYnpDWS9hUmlsTENyWHVVVzB6N2ZJOS9qWnZv?=
 =?utf-8?B?LzJWR3pqYThsSCt5WEpWOFBsdnpoMmRGNU1ITnFsS28rOUx1czEwTnF1dlVj?=
 =?utf-8?B?YnZ1Nmw3aWtPTjVzcVVkdEZsVkM1dWdaUDRIUXFvWSthdnQyVHZRZWNPRUgx?=
 =?utf-8?B?VGFCT0hpQXdpS1NOU3VhbXdsVUZqMDdXNFBMMGl0T3c0em1PVVB2NVpqdFNT?=
 =?utf-8?B?ZUw1UjFGSkFQbkdGUU03NTlmNUpIOVE3bStsanpQRVVVUjZQWGR0Q3A3TTdU?=
 =?utf-8?B?dVZiY2pxY04wWjZLWjZic1UwWUZjOVdNbC8vZFhWYmJJWVpZRGpyaDhCYUhO?=
 =?utf-8?B?cENENWczWGNBZW5SZ3Joa0xlZjFBYnBHUEtSZHQ5WHVYc1paZ2xnSzFvWDJN?=
 =?utf-8?B?dVI3ZWE2ZjFFd0FiUWFGUmovWTZ1TGEzdTNtRTRnSENLNFp0M0RDNzZBUys2?=
 =?utf-8?B?ajJzTVUvZ2p3bFpNZXdQaEtJQ2k0eHJZd0ZMcTdQSzhyLzY1UEg3MjhINEZX?=
 =?utf-8?B?MjRxZ2lRbkh5VS8wdGh6VnhjVkxMQWFJUmFwKzR3eEVzS3RXc2VYeGovaDl3?=
 =?utf-8?B?aTZYV2RzcHZyNm80S1BpaWJwczVQUUN6alB0VktrczlXVnJPb05LYUd5SUlm?=
 =?utf-8?B?MjBGM1FnaWxrM0pORktTRHV3N01wWnN2QXd1b3M0dTJvVG1kMHZscjViN0hm?=
 =?utf-8?B?RUIrZERCbFdvd3diNFVsUlhjQUZpRlRNbnlzTzVIVEJLMXRMQmhuYVEzU2ZH?=
 =?utf-8?B?bitiQnArSU0vUVlKaVY2Sno5OWV2QTdiRWxoM09DYzhwbnovWXBPK0x6ZHFP?=
 =?utf-8?B?WFEyNW9aZVVodVRPWUs4L1ZKZDNwT2J5NGN3cHh2aWFhcTZSZ2FlS2IrOTM2?=
 =?utf-8?B?cHJvVzR0UFkrRU1SMHlxSElSb3pYSjJJeVZ0WlRNcUZhU2pyMHBOTDdMNEJs?=
 =?utf-8?B?eEQ0bURaOFBhTDRUU1U2ajJOZXVkcDhQZkpEcjF1UDNTSTVnZnNzUmJYYVEz?=
 =?utf-8?B?SkZiaWdPSEo5eXNVbFRFWXY4T2JGeGpDWHVaMTdGT1BOeHB1QTJ0Zk51RXd0?=
 =?utf-8?B?RUs5UzIvZ2ZnVGlyMzdMYjE0NmQ3WTR5dFlpQVE2b3UxS2FFTHpCaFdtbmVw?=
 =?utf-8?B?ZXBkUTRmSVBiSEJra1RhNVFlYU5WQnNmcTNsUnYvc3hiR1FpNzF4VGNnR1M0?=
 =?utf-8?B?bXhuYjZVOFZtbkllNVF2NkpvNzl0K0sxY2NxNjQ3SEczRXdSUUlWU0lpbzJo?=
 =?utf-8?B?azk3bzg1WjlGamQ0SldhRU9rdnRkRDFoY3FFVURkbmRLWlBuVFJxS3hWUk4w?=
 =?utf-8?B?MEhkWHlXOU5ac2ZRVTArTjltNUFhbjdaOXhyenlGa1dKUHRaSFdwMGlCTmlx?=
 =?utf-8?B?Mk1EdXFRTlhPRTdsZ2lYSnhpdUxKckhyRmRzNVRscXNaeU1zSmFtb1BMWDJT?=
 =?utf-8?B?ZWlhTzF2cTJZNHFNOG0wbDdCUDFvZzgzZ052MU1IUG1MM2MrSUIwbm0rL0do?=
 =?utf-8?B?M0hpckJDNkNEZjdOd2FUUk5NMDFzZXFuYjhkRzdkcFdYNElTTldmUGpnNUtq?=
 =?utf-8?B?NnI1c3ZYcWhHUlZ0MXNuTk1MbEhrN0JtaFNPOWJua2FrTUtzWVVPMW15MWNy?=
 =?utf-8?B?bmFGY1k1c2VtZWFEUlJveUpnZDNla0ZrR2NYY1ZoUE1HMUJCdVZ1eEkvN3BZ?=
 =?utf-8?B?dHJKcjRreXN3M1VYQVY2aTU5UnlwdTdMQ3FNTzBYSG9kWXZmWXFDMURuWnlE?=
 =?utf-8?B?ZlNqcDMzMS8wZGRDc2ZDYVkrQ2F3SVVVSjN0R0RhaGhoNlB2bVRzVUpQRjl4?=
 =?utf-8?B?MERhZXhRdWQvWnRYQ2ZHMWpkeVlRMUhGZzhVdjhxeTFjY0pHQWJrY0lmRGhG?=
 =?utf-8?Q?FShZSyz+iYcbu/VxXu2TL50L/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31db90e-3308-4900-0be9-08de2cc46d23
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:18:49.0829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k1j6Aka6Xw0S/pTBvr/JvMKReKq2FtLMTA/xKaRtJf/EsPed9Oz9bxJkt+E7MHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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



On 11/19/25 12:32, Michal Simek wrote:
> GEMs are using mdio node that's why don't need cells description in the
> node.
> SPIs should be using partitions subnode that's why don't need to have
> cells description in the node
> Also no need to specify cells in DT overlay root node when there is no
> child which needs it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
> index c1945ea6f8d1..5a4e5f092506 100644
> --- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
> @@ -13,9 +13,6 @@
>   /plugin/;
>   
>   &{/} {
> -	#address-cells = <2>;
> -	#size-cells = <2>;
> -
>   	compatible = "xlnx,zynqmp-sc-vn-p-b2197-revA",
>   		     "xlnx,zynqmp-sc-vn-p-b2197", "xlnx,zynqmp";
>   

Applied.
M
