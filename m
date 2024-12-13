Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D046EE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 13:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5716C8012C;
	Fri, 13 Dec 2024 14:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eOqD1HCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D59880137; Fri, 13 Dec 2024 14:45:21 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55FCB80104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:45:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6TiNj+ON0IJ7YCwqp1BzuPjMIQ2pUSd6n2mmcTlpCObzLHo2aH4Tt/CeYkWBOBd93C0GfVFDoglsl1uIAA/4QlmRqeK7u4C/bcLExiLnBAsB2slcOCvNOU1kY9flhmXvLTM2SPZK3+zzHUfeN2oUxvp7mj0z753NUs3IIfWqYFG4DcsnhaEkt9nx4ViG+epSBme0axPPcqo7z8XXq7Yfin03s05cpKk1zflZunYHfkKQQXHtpeEsJhDWzrbQwRlRBic8i1sTkKpglnpqfSFeDSUrW0zO0y9/1pT2gascGZoZMXC/mOFjlSL8Ppo2jBtjC7+LORKXCjZDDa+u0KX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chF1tywUYYivEUWGzplE+VNyoVPxJuyZ/ePgS/K3ueY=;
 b=pgGAdatD65YWydPcmJlMTgXyYlhDo/Lt3kPYB4f+IT92dWiygIsM8MalN9c/R4q223BJwohROQCTgtCrUpPg6ixuzq3lCv1tbQrGUePR/wcbtHTPb9q5VXZJPuTrfnOoUWglB1oHQANJsB/bFGAsWMRYKUX+QtxbdTcVwcFLsgbD8UHAU/0pWCZOY9e8uX4zv324BfExaXmHMSIpxTHZHum2+DFbvjfI9x5o7DSsCQD0MH46rMEvEALcDN2gzuFsU4olUWKv1bhuUS3b5/NEAgxFgZMYxzmKRME8N+eVMPDESzFtUbXgFR3kyWNxOD4HePG/diA20r5WJnVmjtMlJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chF1tywUYYivEUWGzplE+VNyoVPxJuyZ/ePgS/K3ueY=;
 b=eOqD1HCfI9wU+z7RMvc20PrscFosl7yMs6id7lB0dXNALDImneRUY7PjQdbqb2zyoEWxaozvfivJEd7bPEqBY44nto50FosBKCN03zygZc2Fb7LYwihB7wyImjXH1hAgzlQ+pMOkqF8H9p15CLf8m1Mj0nN7X3oGO0eqnuk53Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 13:45:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 13:45:15 +0000
Message-ID: <362cb14a-5f41-4d9c-ba98-121b7f3d893a@cherry.de>
Date: Fri, 13 Dec 2024 14:45:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588-generic: Enable support for RK3582
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241210222341.3537543-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa432f4-ea2c-4c99-aff7-08dd1b7c5fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFp4TXdiblVBcHVPT0g1WTZnS2tZZjdENWN2dmQzUHNTZG5XRFA1ZTcyMFhh?=
 =?utf-8?B?dTNNa2I1Q1paYmR5cnRUdE9SZFN3RjB0UTB0WnlFSHpCakE5ZkYxOWRxdk1z?=
 =?utf-8?B?Q2ViblpSRTRBTXJmaWJIMDZhM3RlcXk1YUUzNjNLMzczQUJnakdjVnBUWWwx?=
 =?utf-8?B?SFdVbm9lQStid0xyOE9oby9qRVk2eFFQS0xtV0FVWXpRUXlWME55TUV1Tjhq?=
 =?utf-8?B?UlZOUDRXM2Z0bDJtODBzcVFLU0NqdnBoQ3c0NW04azh3aXZEZUV5bDJNR1Fu?=
 =?utf-8?B?d3V2MGxIMUJLRlNmeDIvcGhZbVludG1zeXk5ZWNtSkplOEpsNDJDNnZzNWp0?=
 =?utf-8?B?N09sMjVWUmt0Ky9FSlkyUVRFM2VGUU1IekxySTZ6UmNhS1A5d2FTTUZXT0Qw?=
 =?utf-8?B?aGZaQWoweGxmYXNmb2xscTJSaVNmalFGcDBXREtObElrVlY5V1lYZ2dURnNQ?=
 =?utf-8?B?Mm5nRFhYQ2Y4WENCSStXZzRYVTJyWER6Ui92Z01TVkpuQXV3THVaRkJ3M3dX?=
 =?utf-8?B?MjhBMGt5alJXYldYQVk2SitwTTVnZEV5SW45bGhVazFKdCtoL2t6UXZ5dmlN?=
 =?utf-8?B?Ynd1ZVp3cjlPWFlYUlhwK2FvMFFFVStLRXlmQktLdUFzMTBMT2tIejIraVhL?=
 =?utf-8?B?Z2pueE54Rk5MczlPWHBkcXRhRjVGWnlvdkUrM2FDUzNqK0I4TUJXZUJKeThS?=
 =?utf-8?B?dWltaitrTi9DTlQ3a0dWUVZhT3JBWXpSTythTitjVFJBeDE5ZjU1bTh3N0Zy?=
 =?utf-8?B?cmZsZmNnQUpHeFpTMFpVRFJUODlqWVZUNnRwZkxaWVlRa3JCOGNlUlpTY3R5?=
 =?utf-8?B?aWdXU0g5U204UFlCL25yQjBaWUtYazBRZVJuTVk1bzBKVmhRV2xiZzRqNDBD?=
 =?utf-8?B?dTNYc0VLbnJrWXhScGJJb3UyWFZOeU0xMTJoSFZoYkluYUJwNjdPaFVqTXNm?=
 =?utf-8?B?bnI1Z0ZNcld0Q0g0NmRvU1Zod3FpSHFzcnVZMWhYUkJUZmtTdGMxM3ZtL0Vq?=
 =?utf-8?B?QmRWalRMTUw4bXhJcUJFRDV1UktXWGZCYU5DMlhhdXdYKzZLRkM3dklPbEQ1?=
 =?utf-8?B?SHhvLzN0YmRkd3hrVG8yenVPVW5DZW5tOVI0ZzZlODRDbStpOGN3VTFZZ1BY?=
 =?utf-8?B?bTBIYldvOFg3ekd5ekpJRXhDMldGem92K01XbmJ5NHo0MmkrbEorWnp4aW51?=
 =?utf-8?B?NDhEUTVVd0J0MXFHcWRnLzFlTjIxVVlOYjYvZXlmQ3lCYTZyWXQ4QXJvdXAz?=
 =?utf-8?B?cklmT3NxQlk4UHRyVnRZWWZQUzBwcDRwbjFkOTc5UmpEcGE0V05sVThhQmZw?=
 =?utf-8?B?VzBNYWJtemc2WGlmQTVON3ljOGMyc0xDUFJ6UmZFbXloYUlza1dEcFZkTzJu?=
 =?utf-8?B?V0tuREZSdUg4UHplMzRwdGp0dlBKQVhucjlGS3NIQjhLZHptNnM2b005U2Rm?=
 =?utf-8?B?TkgxeElWM2diQ3d0QlVOdXpPSUhNY3g2N2FLV3ZEUWtrUDBUYjEvbDhabFZ5?=
 =?utf-8?B?SDh3MWI1cDQvYnJkTUlZWVVUOVMycVBRQmRBeXRBNHAyMEZGTUgxbTk5RzVB?=
 =?utf-8?B?SFdHcy9nU0w4ZEp5OStGdXVHMWV5L3FnOXEyWEdpMHRqRE1ReEwvS0M1TU81?=
 =?utf-8?B?VkhWSy96T1FYNzNVWGd6a25ESDlELzZsZWI5Q1hFNmoySHNoSW85NGpRRFdy?=
 =?utf-8?B?YkN2dndxbklyaG44eFY0ZEtucHBWM1RRZHNzSVBwVlpBWC9BMUg2T3JlQTFS?=
 =?utf-8?B?RjE3YXJLc0I4QmdIdVV1ZnpMbTcxS1piZWlwY3lCVEozMDR2NVQ0WnNMMzFl?=
 =?utf-8?B?QkQxYmxhTWJnNGErdU5vQ0pJS012SnliNnhZczNiNVlwYnhLOEpoUUk1RVV3?=
 =?utf-8?Q?usWehoXDRV6k4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFN6TG1SYURZZE5BcjZicFo0K0phWWs3Vyt1VEVDTlpER1hIL1Z0aTlpQmxV?=
 =?utf-8?B?U0dUcW5uWEFsQTRCaDd2TjZxb2MzYVRQaEtMNENBaVF4WG1USHl6R3cwZ1ZV?=
 =?utf-8?B?aHJKUFU4OW03UDJpc3l1cnpxbWFwUGw4SENvVk1jSWRLWUVUMVRCTXk1aXRS?=
 =?utf-8?B?TlZPc2hURjBjVHZlQ0JDdURSdC81WEhJeFYvUmNvcDJ0QXdzQy9XMm0rM0Fz?=
 =?utf-8?B?R1ZyMnc3NExDWDZVQnBncXluUmtmbnM4TUdJVGo3bm5kU1NPeXVlM2I4MGhl?=
 =?utf-8?B?R2tCa1NSNDlzMU5wUjRlWmdJUmYxNDhkNWpWRVcyQ2NXd2FWMVo4eFpVNDIr?=
 =?utf-8?B?Z1k2NFJCWjZubjU2ckE1dTlBSnAzbmY3aUE2WnVTWWJ4cFhWNzFBY1BkZW44?=
 =?utf-8?B?MzBqMlIxRUtGMXVRRDNiSTYva1d4MXhQRENSMWp4Ym5IQVJ2cGRPc3VsZzZ0?=
 =?utf-8?B?WS9XYjZaajYxaThnd2o3N2I5OVg3Q2VJK2VBMEhMdzREREpVeUxFWisveWJC?=
 =?utf-8?B?cEhqSXpyZXFNN1pkeEo5anJKVkhlbEw0aVhNbW92YlFZeVE5ZEhxTlZFSlJh?=
 =?utf-8?B?R2o3SnRDd0pWRmFXN1pqa2hPUTFMaWtKQ0J4OWRLS3BXSFViWHdJT1lldnNw?=
 =?utf-8?B?T3g2Q3RxUTdibjdDUHJtNmkyaGFUMjBXcWVvY1VlZjBUUkNXWmZjNWY3RUpH?=
 =?utf-8?B?ZWNmT3Z5UUpqbWg5TUpESEs5OG9NLy8vMmZsaFNqakFBUEkxdmxuN3IyYkFy?=
 =?utf-8?B?cGJ4dkF1Nnp4VWZOMnhaRm91ZDMrTWd6TmJ0VVU1c0VNaFNEdFp0SWZGU3Nm?=
 =?utf-8?B?Y1ZURWZ0b3IzZWtoRUZvQzVGYTZyMzA5S2loVmxnM3kyckI4T0xjVHBLUTU0?=
 =?utf-8?B?ajU5SXlYakM5UWtwSG5rOUlxRVlFYlMyWEtmMlVEamRQMlg3M08xeGVaRDFt?=
 =?utf-8?B?NmIrQnpITzdUSnpWck9EdGVNUkVWYmNDRVZBTjhSZ3hGeFFobWZwUTdGTENJ?=
 =?utf-8?B?WVJxc2lERFF6WjYvOEZVWE5BRk9HRXMyS2dtZ3hORVZsT2hYRW83aUZ6UWJl?=
 =?utf-8?B?N3VVSG9yZmw3Q21pS0ExRTFSakloaTJnL280clVJcm1PbDFXd0VxR2ZTV2Mv?=
 =?utf-8?B?ZUc3MlFpcEZpYUJJUDNLZmZMY2RiRWUzMjl2MEZBQVJaeG82WkxFYlRZZVBO?=
 =?utf-8?B?UEVMdUduZ296UHoxUFBxcHpjTjN5d3l4c0g4WnN2dkh3OWJyYWdnT25nQzF1?=
 =?utf-8?B?eHRINEF1Tk1ZeTcyTnArWFNTRXdCdTJ0U0pOb0lNbFJManBZR2pZQkJyVWwx?=
 =?utf-8?B?T2YrQ3lIODh0VVpxMUNnaXNyZldlRHlkYnZkOHU2UWxTa1JXN3ZTd0UxaW8v?=
 =?utf-8?B?ZzZPR2pnSGkra0VHaWdnMmIyU3hiWHVrZmdGY0U1Mk8rVkRYNFpYaFExRlly?=
 =?utf-8?B?a0NIaHlER3oySlNoTDhKWTFRWERpeFZ6WjNsa056WldoWnVnNjNrc0lEanpU?=
 =?utf-8?B?Vk9uelR0TUEySVV4TUFZL3ZQYUppeVBtUWRiRHNsTHV2OTF4bEU5bnJUMkVx?=
 =?utf-8?B?c25KWkxpSVZQWStoaUpBTHNMYzljZnN3T1A2UlRCaEc5YUhWZHpvaHJETEJK?=
 =?utf-8?B?TW9WYXJjaENTMTkyMlY3ckJUM0xBK3VHOW5xZDltK3dNcHc0YmhuZStDek05?=
 =?utf-8?B?ODJMRWxHWmhMRFJubnJoWVc1bmF3ajlJcGxodzFUWk5yU1oraTRQYUZ5ampT?=
 =?utf-8?B?M1FzWXFneUU4K1FqUTdrU3crbXpqdm8wakpIUngwNWwvUHVlZEMrSnk3T2Zp?=
 =?utf-8?B?a0M0MXlDeVZPYU9qNkpOdTNoWnFmWU1HZmFTSTRZRWFLTWs4aVZ5algyeUJO?=
 =?utf-8?B?dVEvNCt0V2I4TWRXbm9oSm9ZOGJOMmFsNWdCV1MvOXJDRnY4RFdYVktwTDA2?=
 =?utf-8?B?dXJldEw4RFVzV1dKdy8vbWpWZnd6QnpBVWJ5NnB3blh0S0VpVzBTNndwcnc5?=
 =?utf-8?B?Ym8zY2g0eEFVdnZDbGk5K1hVMlEyRXRSTFJRaXJ1QjdUOUlvV1VWdFhIQVhr?=
 =?utf-8?B?eis4MjRUUS9tWGtaejQ5aWlKa0g2ci9nR2FNVkd0Wlp5bzBkV2ZoY2tNeWhF?=
 =?utf-8?B?KzIxQTAvQVBsRjZFcEhrR2cyYTEzZm9SM1BMU3FYZHRqR0sraE5DNnUzZlB1?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa432f4-ea2c-4c99-aff7-08dd1b7c5fa2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 13:45:15.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wquy5YNNSD8F1nO+3keD+3pFQDaOFBoX5utsGUFJRow0wkRWoIMBOXS07zQXYjfz9ypR5Ekg4fteK4JkRSexENTcB/BEbCI1Uj/8mqM3Ppg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958
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

Hi Jonas,

On 12/10/24 11:23 PM, Jonas Karlman wrote:
> Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
> RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.
> 
> Tested on a ROCK 5C Lite v1.1:
> 
>    cpu-code: 35 82
>    ip-state: 10 00 00
>    fail gpu
>    fail cpu cpu@400
>    fail cpu cpu@500
> 
> and on a Radxa E52C:
> 
>    cpu-code: 35 82
>    ip-state: 00 04 00
>    fail gpu
>    fail cpu cpu@600
>    fail cpu cpu@700
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Can we add RK3582 somewhere in Kconfig, documentation and all?

The idea being to show that we actually support this SoC with the RK3588 
code. Not everyone would be aware of that.

Cheers,
Quentin
