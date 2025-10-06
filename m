Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8E3CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B95483631;
	Mon,  6 Oct 2025 12:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Zty/QLS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6AE83655; Mon,  6 Oct 2025 12:44:28 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDD9835D0
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq9+Joq5tVSS9+Tkf0D9ELpXH5pBUlJXh4fNZMntVwfc60wwLJFFT6ba8hG49wJsr2aFuAuqdksFeJjz+ooKEHZJjb8zpm2clMHV8yXXHMTxZQ1x6Lfuv03+kxyRR0V3aUO6YQnO8UFEq5u50N2GgL39O0YMz4dTsnIjiU15nOBB5AXc97xKpHXkoRW5vwFdQof/iZzlbOo/z9UCWQMVdXfPmIrwCOSgtWuOUg6FEPPU6FlyiY+lb6EjHrRlkAEtob9a2f0l4PBVgmnilxJOzl6flCN7HPoSC4r0EVUEpDL0OW5JSj4VM/wUCIB+fE1GqZM1tOJotYQO67mPU1O/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgMpPpVdtjR9OPlc0rRm4uE6oHq+iAvVr3yVu0Nowck=;
 b=kk1U4L9SZvP7lFIp1P6m/3RhAYMFYKYFbQm6syqsi9WYwQl4JQ17dNz/siGla8+bIcmNokHw0+S9nvDBynEQFS8S2ygnJCbKX7R1yIrOj7wlcRoeMxMp1Xb9JO6ngAVKR/pViJaWLj/n+auQyESUIqics4/wbTPzfchHmoKZO4QKeDr4B1pz2jF4FJxYNlzEXAh13stlW7vHtD8o1cYMmMW496w8mn3nfuKJTQeVJCP7OgNlfyocFLWunFQuaYnl/Qtod7ABmqewGqCvggSn36OEwOGCentOnrladgNVNiv9/HRRtqxLsuV1E9CHUedtIP3K4pvSypB+Suu5ySYgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgMpPpVdtjR9OPlc0rRm4uE6oHq+iAvVr3yVu0Nowck=;
 b=Zty/QLS0/gPD7Jm2MPHRWCHaNUHJjGl6yricKLtlgA02oMzttDTiqbqif8cveVlucPSqo+DzajMQE1nzLRv9J4SzMrqwUiHrKhO253KdAd8e+VSdu5M1k+gtykp1HvsmCik020mJv9AaHW2JgqdVYILqtw/xXVIliB0JITihIiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8697.eurprd04.prod.outlook.com (2603:10a6:20b:43c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:44:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:44:20 +0000
Message-ID: <0e5ce080-183d-4518-822c-1c5a59340f21@cherry.de>
Date: Mon, 6 Oct 2025 12:44:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250630102524.127970-1-pbrobinson@gmail.com>
 <a9587b7f-95fa-472c-af5a-8f45d606666d@cherry.de>
 <CALeDE9NhX9yKEJEXbEW=JdpBdQXE529SNAJTWeU98E9QA4o=Fg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9NhX9yKEJEXbEW=JdpBdQXE529SNAJTWeU98E9QA4o=Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e8dffa-47fc-4b37-93f5-08de04c54e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zzl3SlFFN0ljSmhvaGNiemJsdmhXcXUyU0xGVnoyME9NeS9kR3c5Qi9ZRkNM?=
 =?utf-8?B?dXJ5UE9PRzA4WkRFZW12RXJiOWIxZ2lsUGdTeFpiSDlFK2hsZnBoMFdjRThQ?=
 =?utf-8?B?OXZ0Uk4yREtWcmVDMTI3TmRXNmU3TE9YK1J4Vm1GMk5wT3NZL1FhZ1Bkc01q?=
 =?utf-8?B?WGtsbEVIb3ZINGl2OFJ3dVVhNGhocUw1eHhqN0RlMXpnMTFiY2xPVkdvSW5u?=
 =?utf-8?B?dEFaNHROQnRQUFRmNkpub1ViVFlPZWt5SDlSTUJMVmJpeStFcm5FSzZZSzVw?=
 =?utf-8?B?akhYY2lCQ3R3MUEzbXgyNngzcmhTdHVyY0ltMlNBUVpjeGtEcGpRemlBWVpT?=
 =?utf-8?B?VUU3eW8xaE52UDVPYUlMYW1vdEc2NTRmWFFiT3N1Q0xGTUROUTZXeks0SjQr?=
 =?utf-8?B?Si84T29pRGFIZiszUUFENkh0b1FyamJUQ3EwU2xJYWROWVN3dlgwRVFMRmdy?=
 =?utf-8?B?QkZzaHpmN2tPakdRVHMyaDMyTUk3bzNZNE5CMExJblgwdGlhaGo5K09sc1Y5?=
 =?utf-8?B?d1MyWE45emt1MGh5YXNUNFpZWnh4MTVockFnMTJtWDhTeThsMUQzN29xRm9s?=
 =?utf-8?B?b202VTNQR242SklSQlhnbEoydjdvb3hFSjN2M093Q0RwdlBiQ0xqSW9Bc09r?=
 =?utf-8?B?Z2JheGRmM2FNalh6NzRpT3pzMmJrcm1OaVZoQXZ3S3hvMTBrY2hkb0V0UCs1?=
 =?utf-8?B?T1B3eDhnNXJHS0IvRnpva0F5b0MxMS90dENkTWtUYkZYMGk1Z2pudkFhSjNI?=
 =?utf-8?B?TXp3d2FVMU93TXVjeHVQM1dNYUt3SDNoUndPMjdwMmR5VWM0ZTFwOGQ5Mmgw?=
 =?utf-8?B?cUZIeWVmdk1YQlhaVEpMOTNqUzRIZ1MyOVRJVEd1TTJoaER6ejM0RDBUMlQz?=
 =?utf-8?B?V2JiS0R1R3V4WkdsODBvVmNCYzNGVDVsSXNGeDgvN2lHRjVabS9hMTQwK3lh?=
 =?utf-8?B?cFFELzN0Z2h1UGxRV2lVeVBLWE9tRG9OdVhUYUtCVWQrTEVhZUxqTWJQNnp5?=
 =?utf-8?B?ZUtJbXVVMlZnMllLRFoxVFE0NkkzdW1PUXc5ZTNwZVBCSFZrS1RnTWtNcDZC?=
 =?utf-8?B?eVJnL1hWR1JSN254c1Q1UFM3UStUWldHYXJYZmJDd3hTbDh0RERPRmNYNlBD?=
 =?utf-8?B?MG9zeFhCenRydXgrcE1ldThzLzZIV1Y2TWU2UFFuRXVTYVB0TVV6cDBDR1Az?=
 =?utf-8?B?NUFvOU1ISzRpNjlkM0hpVFJLcEZFcEZxeHBqRU5MUlM2QjdkK1RNUFB1SEFu?=
 =?utf-8?B?Q01OT1ZMdWtRcXovNGEzUlpiYzZlNGtSWWpMNjgxV3luQW81ZDR0bDc3ZE5I?=
 =?utf-8?B?eVU2R0llaEltSmlrdUlxbVZvdmpSSWRXUE5Nd01tWTlEekNHazJKdnJkSWVn?=
 =?utf-8?B?SUp6czRIQjJlYUVNanJ2Q0MwV3Fnam9tNW4rTTZoSzZhS2JKb2RoeERzZUo0?=
 =?utf-8?B?NG1pWVMzNFh3UEhJYkRHNmJtZm5QdVpOTi9pTGpxbDVUWlFMYXp4SG44R2hw?=
 =?utf-8?B?amFnRWh1c0VWM1Jac3RaYzlSb2hyMHVvNW9oRHFSeEgvbDNiRjJTMVJwbFNP?=
 =?utf-8?B?R2w4NlBzRnAzSk9QSXNhZzRaY3lJMkQ0RjRNYkxPV0lkbjA2TGxIYXB3M3ZO?=
 =?utf-8?B?UExmelVub0Q5Mmw1RVR2a05KK2VjM0IveXFzamRZY0N6VnM0RldQa2w5ZHc5?=
 =?utf-8?B?d25nTFVQWWZ6blVCZzVYc2hSQlZVMm9BOVRxSnZ1dVVNNGVabGZQREp1dEVr?=
 =?utf-8?B?N0RyWC9NWW5oWHBUZ2VtRlcwZGMrdmk1WE5ZVTVSWnlJbGhSbHYrbFk5bUxt?=
 =?utf-8?B?OGt3QWNPUU8yb0JaKzNpbDJqZnlpUDlsekVIS1o4TTJJVmJPM3dDbEpKVlZQ?=
 =?utf-8?B?dVBNeHNadSt5VDY1ZCtCYWUxbEhscDVFVklsb3RKZmtxU2lpZjFYVWd1a3R1?=
 =?utf-8?Q?qMaCoHt9jatq504LBITJdYeBZgGiPQ28?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytkcmFyWjc3aGVza1FDZEREN0dpWjdpeGU5d3NnSituWEFBWHlXOStyWCtn?=
 =?utf-8?B?aWh3SUZVSEhYTGxKazJaTmw4UE5WWjh0SjlzN1FWZ2dxalJnWmVEckZKNXJP?=
 =?utf-8?B?RmNiK0tNd09CYmltZ0tUczdlTlZpUDlHWThsSzJYNmUzUHBtM0YrSXo0VE1F?=
 =?utf-8?B?Z2hXL1BGdUJrZFQ3SWYrdWJyZ21oOUYrUVJYalpjbmZwckdZckc1VjNLbVZH?=
 =?utf-8?B?M05IT1UwYWhOVFUvV25KbVNFV3VzQkZiLzlvTnJCK2tmK0pEcElCelV0dTZD?=
 =?utf-8?B?UVZ2eHYvdVYvNU5LS29ycERTZlhLTDVQYUI4VFFCWnZLZndRN2hndmZlY3Y3?=
 =?utf-8?B?UDBjYnNkRXVkVUVpTHpsbXhtaGNQdnFROHpiSWo0V3hNRzdTN1R3Q2pITSsw?=
 =?utf-8?B?b0pSOWhDN05ubEhQWCsxNUx0akcxSlFHVlhDYUEvclRHaTRHSXU5UElmSnk3?=
 =?utf-8?B?T0ZuUUxLSjk4RmN1bkFFai9nUk9qaEpBSk9rNlNrNkswaS8wRDVFU2Vtb0hP?=
 =?utf-8?B?QXcrbjlmMm9ZelAzL0NhK3ZqTGpCVzF2TkNhYVRxVkYyalZJTDZ3dGdUUXBE?=
 =?utf-8?B?NzF1RHlVRkpGYmVwVUQ5NExkWCtGVktsa0RMQnpkYnRac2lKZzE2ODBXV0pM?=
 =?utf-8?B?YkZTMExSM0ViK3RQZ2dJdVdUSmFNd3NuQnVYMmU2NGZ6d044NnBrcXNTdFJa?=
 =?utf-8?B?b290dERvV3A1UjRmUk5QWW9BYm1qN3JjNFJ6OFoybHJmVG9rSERNVW5JN1JJ?=
 =?utf-8?B?YXJPZHIyUk83RWpuSkF0WURzWTBuWXg4UEJmQ0VMZEdKRGo0d1ZxdWpoOTFW?=
 =?utf-8?B?NG5Mb1hQcXBPWkZKblNkVUhXNUNYaHVkS1dHWlhzc244akpwMWtJVmJiVW9w?=
 =?utf-8?B?dmNFOU5GNStmTi9mZDhtYWd4Y003alhvSW9NSjBCSytUQnc2SkNsbmhhMEVK?=
 =?utf-8?B?Y1VWRjZINmk5c0F1NS9IYU85dHp6TjdnTUJuWmIvdkZyMFpZdkxHT3FsY1lo?=
 =?utf-8?B?enFZZGNHTjVhUXN6TnRYYWJpaGZicG14ZzFUdFBPcU5IaHRmazI5ZnVoQzc0?=
 =?utf-8?B?REo3dUNGZDVYbXhBQnFuaW5Sa1lHaWk4eXBSdXpBc1RqUlNJaktmQXd2QVoz?=
 =?utf-8?B?aGRUT3lTSm1JbVgzTDJsYmlMYUlacFJ4ZlpUTitabEZsYUxYbmIxQ2tUZkdD?=
 =?utf-8?B?N3RPMU5KZTF2WkJSZndCY0p4UU5uL05RVWhRSVhFekkzRTVlUnlvK1FWTURl?=
 =?utf-8?B?YnF2WjdGRC82aTFURDNaRFU4d1Bvdjg3UFpKOEFSdVJ2SDFwampXcWtJNll1?=
 =?utf-8?B?eWkxTldsUEovMWwxN3NmdDJnekdlSWtNdW05dlhybTZXWGhoeFhDY1BzS0ll?=
 =?utf-8?B?VHJLWlY5RGxMZUFsTkp6WXlZa2RXOWY0SnVwSmlVa3c3eVFWZmJ3OThFT0NC?=
 =?utf-8?B?OGZ0aXpLaGw4N0JHcWhVazlRZHdZek4zWllKOFZvc2paNFRJNGlBc3A2SVUr?=
 =?utf-8?B?aGV3ZHRPcDNJOHFkdkxzWUd5UloxY3ZLUExVcXAzcUNCdjQwZk9SalpHbUxM?=
 =?utf-8?B?dkRaa3J3eUJPZFd0blJvZExRbmQyL0h4cUd2ZWFXaGlvNXJwR2ZETTBNem0r?=
 =?utf-8?B?c0NYaExIOTUyTUYzTWNrbUJHZUVvZ3VRUDhhcUpPVU9xVVJtLzlReC9vYTRr?=
 =?utf-8?B?R0NIUUcxc3VyOWYxazFnZGZiemtPTWFzZWF0c0xzWTNYQy8xY0VFODdHelJs?=
 =?utf-8?B?T2d5N1BKZHBkbEdRbytiUGFiS0lESjd3WVFxWStNMUoyTFl5Y0RNY0FISGJV?=
 =?utf-8?B?S3NLSFBEYkc1VmJkblZuMEQxS3JmekdtaHBGbEExajBSc3JXWUlzc0YwMmZx?=
 =?utf-8?B?Qk5JSnY3SGV2YVRBUW9kYXViSXE5V2oxVDNHUHVhY0tGTFlKSjdlSUtJNURB?=
 =?utf-8?B?ZG5MRmIzYkNxQjhPQ21nY0ZLWXFXVXFxbUlMcG02bC9QeERpUHhwTGtqQmUr?=
 =?utf-8?B?UGU4emtLNjVMaXZQdFJNZXRBSllIZ1ppQll0NmxzY0kvdGlpcHN3QmZWaG8w?=
 =?utf-8?B?RjF4eEJWWFJmQkxzMko0WjJrMU9EZmhGdUppZFNVaUJ6RllGREM4ZWtSa2VC?=
 =?utf-8?Q?Q8sMgqddUCOSWhZ/hgvoMfwnp?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e8dffa-47fc-4b37-93f5-08de04c54e42
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:44:20.3184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfOwMseLzfAwqVg6/CGBsCXyhd7R9Hly5T9Lef+u/nQYGWW6Mz3eThXpsMK7AKw2gdztsnqUt8X1wi7jqSpCbW1yFssariat3gIMUgW5en4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8697
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

Hi Peter,

On 9/26/25 6:26 PM, Peter Robinson wrote:
> Hi Quentin,
> 
>> On 6/30/25 12:25 PM, Peter Robinson wrote:
[...]
>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-mnt-reform2"
>>
>> Shouldn't that end with .dtb?
> 
> Nope.

Interestingly we have a mix of some adding .dtb and some not:

$ git grep CONFIG_DEFAULT_FDT_FILE configs/ | grep -v dtb | wc -l
44
$ git grep CONFIG_DEFAULT_FDT_FILE configs/ | grep dtb | wc -l
244

Most notably, all Rockchip defconfigs add .dtb at the end.

The value of this Kconfig symbol is the content of the fdtfile 
environment variable, which seems to be expecting a .dtb-suffixed file?

See doc/develop/bootstd/overview.rst:

"""
fdtfile
     Name of the flattened device tree (FDT) file to load, e.g.
     "rockchip/rk3399-rockpro64.dtb"
"""

and doc/develop/distro.rst:

"""
fdtfile:
   Mandatory. the name of the DTB file for the specific board for instance
   the espressobin v5 board the value is 
"marvell/armada-3720-espressobin.dtb"
   while on a clearfog pro it is "armada-388-clearfog-pro.dtb" in the 
case of
   a board providing its firmware based DTB this value can be used to 
override
   the DTB with a different DTB. fdtfile will automatically be set for 
you if
   it matches the format ${soc}-${board}.dtb which covers most 32 bit 
use cases.
   AArch64 generally does not match as the Linux kernel put the dtb 
files under
   SoC vendor directories.
"""

so it seems like we are indeed expecting a .dtb-suffixed file.

boot/pxe_utils.c seems to be reconstructing fdtfile with a forced .dtb 
suffix (c.f. f4 variable when label->fdt isn't set in label_boot().

What am I missing?

Cheers,
Quentin
