Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA88C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D04982CA6;
	Fri, 13 Jun 2025 14:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c4A42tQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3127182CF5; Fri, 13 Jun 2025 14:56:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF0A807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sP0OSjowlZFoPklU8x4rUVI1FMn6tCEHCbRKxve+w+Z8YhYC8Gq0B/rue/2/mAkxqzaV6YoJk4zfYRuVyZitgcBrZOHvz1w2qPHJvg7oNgT0Rc5ob/fWdGKPSKdQJtZvIA3/rMCJ0otPtCrLGnCSa+RPVNlFueb6qCK3rbQMYFnozVzqskeBILlcGNjmmFKihmSBjtbNujCqhPq05p2Jhaj8zUVlg8e4lrJlOww1VdRBg2V/fL9yetf3n/2rP9EZ+lay3Prg4/6F4X3TByZn1+GMieIbdmZlMNbKmbbaer0AdHaD6h00fhGtWuNN7Hg8TC3w2RnNq8v046cyntuD9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzABSO67cWA8VZqAWiG/XGRBkGkWO6KsZ8eJ3/Za+U0=;
 b=RKHZ6aisrVetbBwzm3Lk+FkhXKLLyLBsGm4036j3RJ7A/V6qJY/4qv+V+kx8FyksmS/+N2nA7UxA78jmZ1gMIQxHi+SvksoQLYyg5cMnwTguptiKfczmdHHWX7rN2bRwixSGoDJfPsf/Igll0Y1cCkhspintMSXjPzt4mzRoucllu23JYjPoNzyduhXTi43vQUSsiorDvJfDqu+6PMfaM3XzBkjUm7+4hhTmQDY3vDgw9kkRPZX01kACY2zaUZ6mReAekJWtf1abfa3cToAWMXQQIq1n57cUzCL/3wqJHC+Lkz/Kv75xC1Tf+7IvjkzSy5SoI9JF5fryJWBwuojsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzABSO67cWA8VZqAWiG/XGRBkGkWO6KsZ8eJ3/Za+U0=;
 b=c4A42tQPY76conRYA3sFqKMJjGy+ytLzyHFtd50rHVcsgGsLbZBj8iSYCJN4mkUp019LyIhHeqaoeZzBJ617Ooq6+pT6eXf7JMZB62Rl9Xz9dJjunaiGMhM+MMgLNGXw+85JCdrcDC5+dF4J2wCz9tlVE8NBRduaJufVb1a7FOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 12:56:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:56:40 +0000
Message-ID: <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
Date: Fri, 13 Jun 2025 14:56:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: MichaIng <micha@dietpi.com>, u-boot@lists.denx.de
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: dc28db8d-c5f4-412d-ce29-08ddaa79bd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpLVWZEVWhuR0pKQk40N0k3Rm1FK01ZYWY1ZEFwVkZIb1J5MXYwT2VyaUtt?=
 =?utf-8?B?NDBKNER1YlFndStYK2pTR3RLR0YrNFFyNHd0RWNkQXRwbWJCNHpRcy9ySldS?=
 =?utf-8?B?TXVWaDF3TUNDSzJrWFFDaFRiQnVOZHRwZzNrL0M1N2JzY1czelZYNDQ2ZFpw?=
 =?utf-8?B?Z3N1THFwUXZGaVV0bGYvaUwxQ3Q3T2NraHV1ZnZ5bllhWHdEWS95a0ZNSWQx?=
 =?utf-8?B?aGQwTlk4TFlGNEdMbjBCUmJsSDcvUjJXejVwSklQMGlFb0M5L1VEaXB1MDRD?=
 =?utf-8?B?NkkvVVZaMEplY0Vkbk1XYzIxRTFnQXFoNy9pdTRDcmRRSnpMcDdQcnVXM29R?=
 =?utf-8?B?dmFqYkw5NlREZ2JETnc1Vk9pbENRMHdLWjJqc2hadktmU0FsaUhDWnh4WmNs?=
 =?utf-8?B?MFhlc2J5WWVobVRJWm11UU4yeTJIUzQzOXlka0hRODRMbFlpcDVpb0xxalZk?=
 =?utf-8?B?bENEZDdiWVJMOTN3Q1Fxb2xvTzFRVHN0dzZ5d3N6QjVQMURQMGdZZ1VBWWxi?=
 =?utf-8?B?VVlmRGQ4MXk0WWVHbFZ3c1VDVmJvOG1VOTBJK3paMElTNFVPTnVjZFhnT1Mx?=
 =?utf-8?B?bGtMRWRmUWJ2UW1BUkRVcWRPNlBGQlJrUjJId3JNVzZTVllzU3NtU2JJajJq?=
 =?utf-8?B?U29jK1E3aTkzRUxQT1RzdGRVSTRmZkdLckpISUNEc0djcHZCTkhpYlVXVGlJ?=
 =?utf-8?B?cEdTL0RuSDdqeG82cGxVN0RrOWwvTDF3bUFSZmJhWTk0N0Nka005ZHJxM3BR?=
 =?utf-8?B?SVo2N0FucXpwclE1TktsUVhueGtJc0cxSFo5NDU5UUpOREdOMnBPUjdzUnJM?=
 =?utf-8?B?dlF1b0xjdnV3cHV1ZFhwWDU0aWZjU0dMOHFtU0VmdVFpa2UxQklJQlByUDlV?=
 =?utf-8?B?VVMvWmxHZ0ZLSUlnNmIzZ1hhMktMMXlCazQzUitmdFZ1ZHNZczlmQXIxckJB?=
 =?utf-8?B?eFRTQVkyc0pmZjZDNXZxMEdYTmwvQ01oc0M2UU0yZk9UQzAveGpucEtKUDN4?=
 =?utf-8?B?Q1RBV3pFTTBGVEtLOUs3NFRUbWtjek40eEd3OHNVNDVLeVRyTkhnaDBSaVBP?=
 =?utf-8?B?QXYyWU1vclpyRjVaNmF6Z3pBalVMM3dQTVpRaU1UYURpcXhLdXNJTDYveWpI?=
 =?utf-8?B?a2gra3FPRzN0MkNYSHFJaVNxOHQ0VWlLMjZiMFFOZDN4emdZK2Y4SmFTVlk0?=
 =?utf-8?B?SFdGanc2bzdWbitOOUZFQ2pqNjB4RkJ6L2htTnU1Q09lelEwZkJWdGpTUzlP?=
 =?utf-8?B?a2QvRTJYWEhSSzkwc1dnbDhVVGxtdkx4VlFjRHJXRDl6bzV4ZXgyN2ptaWIz?=
 =?utf-8?B?TXNuOFNYUFFBWkFqV1orOHhkQXFrR3BzQWFiMnJkcU4rRUUza0NmcGtFSHU2?=
 =?utf-8?B?Z2E3N0pkYndnaGJrQmlxVmFSQW9KbXR5VDlaMlh5K3lxNmlIY3lENFlHMGFX?=
 =?utf-8?B?NXN6L0U3WHRUSm5WaWNyZytkTlgzOEczRFFXbkZiYXYzK3JCSXI0UWg2aTF2?=
 =?utf-8?B?YXZEMkdjdTBMUUpxOWVJSTJRYitrYkZ3M0NwL0w2RmYzL0dHU1dWU1cvdzNp?=
 =?utf-8?B?UHVOV0VTOHl0VUI4V01ZNHFRMnZHOVFHNmFRS0ZGcTRXS093SU9pekZZWjFM?=
 =?utf-8?B?aWJOWmpzdk41TGc1OWprdWd6ZE9zTWZPSVN0QUJhYXZrc2IxNCtoR0I5R2xN?=
 =?utf-8?B?cXBWdDBDZ1dCTEZRSGhkbWJ0M25QSUJENEJ1U09zMjFsbm5KdkFkLysxdHBz?=
 =?utf-8?B?bGdoRml0djlsZjVCenFma29nQVZ1YlpVa3BqOGtOc25VcUVTY1ArNkU5SHZr?=
 =?utf-8?B?dGQ0dlBRNWpqc1UvS1BFTnFvazZqbnk5bjlXd0E1b3JBSUNGV1o1ZDNXZW9G?=
 =?utf-8?B?RHM4TERJMTRuSW95SERKV280cGFGZkFxNENMei9hblNSU3RsaFBGUk5UZ3Zi?=
 =?utf-8?Q?bLOBDSUHjW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aURQcUZkQmRjQmJRaktxY3NqK2JtaWpXRlc5dlgxcStkaDRlSFhWbXZZNDA1?=
 =?utf-8?B?eHVNWGZhTGc2VlJ6MVlRdGJGcXk2WHFrdGR5eHIyUUx5eWtON1hHV3R2WEpX?=
 =?utf-8?B?bUVnTUY5c1dhaTBzVENPZUtHa3Y1SFY4UmVFVS9ISzBoajRaSi9pTWJud0ZV?=
 =?utf-8?B?aGg1YnloaFBhR1E5TGxhbFF6czg1bldNQmhxdklBcHN2NVp4UDhPSXVRcjVq?=
 =?utf-8?B?ZVZET25LNFBRMVhGV1ljNkJoM0hobVlBTGxpVUR3ZndIMTZTT1hWVjlSQzdQ?=
 =?utf-8?B?UUFEaEhMZzNWM3ArVGdVU0w2WloyWmVLemJRU1dIaFVXSU9zRGRyMm9PYmNh?=
 =?utf-8?B?UzBmTU9xZjBhUU04cUEzRFliOTF5Y2JzczRhNHNBK3ZjanRDYU1QaHJZRU1K?=
 =?utf-8?B?NEJKdlExZmo4RG1xbHFYa0N5cVNXMFhtOFZqUzlJM1l3bXQ2MnBkWDh1WHRy?=
 =?utf-8?B?cWtzVjhiNm5GK2RESTZpRjlERTV0dlYyR0o3N29uSFFzWFVaZFRGcEFJc0dX?=
 =?utf-8?B?RjRxYkhHQU1wZ2x6MnhTcXJwdXJWOXRPUkovZGNIdWF3MGYxQkZ3dXZlTnF5?=
 =?utf-8?B?WnkwUTdOVUhCcU1RUkFaQ1pXdHpXQWFSV1J2WXZwQkd1U1lHUHlEZzd1dzg5?=
 =?utf-8?B?aUI0UVljMWEyTC9OZCt2dEl3eUVJNk5CRWVzRUw4cGtOMU44YlhJVmZFTXdl?=
 =?utf-8?B?c2pTdjRSS0t1aHVmeDRjY1ZSQ01hclluOEpBTjdmeUZTNThtcmxRQlY4N0Z6?=
 =?utf-8?B?aXpNcTNtb05sVDVXU3RRL3NPK0dweVFGc0JHa3NxVGl6Q09xZkl0RlBTQ0NF?=
 =?utf-8?B?cnlMdVY4V2x6S2UvZWxlMTdvamNrVDRlejVaN1EybFB5d3Q4ZHBjcEhWUjRP?=
 =?utf-8?B?dGF1WjVhQjdZUUhjZmV2TWFNYW0zV1hyS3JOU3Fydlk3cFFjWC9FOEZIbXJS?=
 =?utf-8?B?Vzh5SU1sY0pQOS82R1BkYk5IZm9VbS9ZVHVleS9hSytFWFREOHE3U2pKa0hl?=
 =?utf-8?B?WHV2KzNnUk5MRFVrcjZxU1pNSHN1Nm1vYzlFM0x6a0VvMDA0eGRkSVI4eU1r?=
 =?utf-8?B?QlhvbkZYMWJZSmVnVHJVYTA2elA1QitnWFpub3B0eWxRNWYyOVV4SzZscHFi?=
 =?utf-8?B?NWh4eTU1WC9za1VxVnpaa3Z2L09SNGxYenZxZ0djVDIrQjkrclVJQjEzR0JE?=
 =?utf-8?B?c0c2K1d2MjNGY3h6WTdDZzdNbWUvdmtzTW1BRWxyOEZxaFFKYTliK0NoZjVh?=
 =?utf-8?B?MC93VTFpT0M0N0JKYXJyK29vcSt2KzNOODhCRzQxQU5vOGljdTQxN3E3R0N4?=
 =?utf-8?B?TFBYQWdxNGFPY0t6eUszOW5TMkhSdmxWQ3JQV1piaG9BL0dKYzVaRjh6RGM5?=
 =?utf-8?B?amdBeGU2THJTK2JDVVNNQTM3T002R1lybFVnLzlnazRMWGtMLzhFWnNIUUZn?=
 =?utf-8?B?K0NzNGVpcjFNSmZ3TW9xRFpPQk5nL2NVWFA2SlZtZ3FINWRNTkVOVHB5eGEy?=
 =?utf-8?B?RzZoR3FMMjNqSXgwMW5uRmlHd1J6a0tjR2wva1BlMVNjV2lmSG0wL010eGdp?=
 =?utf-8?B?U1JZdjdCbGhWaS9IMkRRem1sTm9Ic3BSTkJQMjZRSzl1RHBxTHNlenFiU3Yy?=
 =?utf-8?B?aUdLNy9pNzQ0bkpwdzlNb20wSTh6ZlQwbEJ4TDdEOThRb2k2TVNSd3h1MWli?=
 =?utf-8?B?NE5JSWsyQlVoL1JySE85djNOTEZjNHBBdHl0OUV5RzFORjRESmMxZ0w2bVcv?=
 =?utf-8?B?RTNYUWNPREkxTEQrazJmUks3ZXorc1pqQ2ZSdUJmRFh3dXRyK1ByY0kyb3dX?=
 =?utf-8?B?bVdIZTdqT1BhcVlDdTVCTUliNU9RY1hNQXZNQTBGUUJtYmRwb0Q4QWRSQmUy?=
 =?utf-8?B?RkFIQjUwdlBLeTdVMStSWE5PYXF5SzEzUmt4MXZYZ2hZVzNVT1NPTzdOMEN2?=
 =?utf-8?B?RzEvT0pWK29sT3JsZkxmS0tBUHhoVTA1VS9PUXhETTBWMHBGckM3U1NaS1Ni?=
 =?utf-8?B?cDdqTXB6cmNta1UxdUVjcGN3dGhXSUxqZEtwYUJ0WWhDTS93dWpnR01QQlov?=
 =?utf-8?B?V0RoVEE5UEVlaVhtbGM0TS95RE5lbWc3MkJZZDRFNWN4ZTgxSmcyZ3hXU1h1?=
 =?utf-8?B?cWkzYkRqamxlNU5UUWp2d3JRTzB1MGFjdzNqK3FwUHFvdHRiQlRYTDQvK1dJ?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc28db8d-c5f4-412d-ce29-08ddaa79bd2d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:56:39.9625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkq95YcYZX40EzEU9DAIJw28bztcTPugtwBRqD0TP4mgMyxnxA2sqIXamvA6hRYguG6N5TPKuzkaXV+u+yc/chM54CbWCXyJQWROc7PcPM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022
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

Hi Micha,

On 6/12/25 5:59 PM, MichaIng wrote:
> [You don't often get email from micha@dietpi.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Quentin,
> 
> thanks for the review!
> 
>  > You could set the eth2addr in your board file if you wanted instead of
>  > setting it for everybody.
> 
> We provide OS images for everyone, and our users complained about the
> changing MAC addresses. I agree with them that generally the exception
> is that MAC addresses are static by default, and randomising them being
> an optional privacy feature when connecting to untrusted networks, like
> a WiFi hotspot with a mobile phone. Setting eth2addr in boot
> script/environment would require a random MAC address generation our end
> on first boot or so on each system, to rule out collisions. Since U-Boot

I didn't mean to suggest to have this as part of the boot script. Board 
file (for me) is any file in the board/ directory which applies to a 
board. See board/theobroma-systems/ringneck_px30 for example.

There you could replace misc_init_r entirely, or define your own 
rockchip_early_misc_init_r (like I do in 
board/theobroma-systems/ringneck_px30/ringneck-px30.c for example) or 
add a rockchip_late_misc_init_r callback after the ethernet addresses if 
you want?

That's what I was suggesting essentially.

> has the feature implemented already, it just makes sense to make use of
> it and extend it for the affected Rockchip builds, also to have the
> somewhat nicely aligned with the last digit deferring only. So we
> currently patch our sources.
> 

That's fair. The point is I'm not sure it makes sense to have X ethXaddr 
variables with X being the highest possible amount of Ethernet devices 
one can find on a Rockchip device.

>  > What's the number when we'll decide this is too many? I have a board
>  > with 5 Ethernet ports for example :)
> 
> Good question. In Germany we say "Aller guten Dinge sind drei" (All good
> things come in threes). Jokes aside: not sure whether there are Rockchip
> SoC boards which provide more Ethernet NICs, but I have 3 with 3 ones
> (in one case provided by an official expansion board), all RK3588 with
> two onboard PCIe adapters. There is another PCIe bus, but commonly used
> for an M.2 socket, not sure whether it could theoretically provide a 4th
> Ethernet adapter. I don't know the background about why the Ethernet
> driver/firmware is not able to read/assign the hardware MAC, or why
> there is no hardware MAC, as I understand that this is an IEEE
> requirement. So what U-Boot does seems a workaround, and I agree that,
> if there is no generic approach, it has limits.
> 
>  > I don't know how far we want to go to avoid defining unused ethXaddr
>  > variables in the environment? We could use of_alias_get_highest_id for
>  > example and generate enough environment variables based on that info?
> 
> This sounds reasonable. But are ethXaddr variables not generated before
> boot scripts are called, when the number of alias IDs cannot be known
> yet, and MAC addresses assigned afterwards, when the OS device tree was
> loaded? When generating the variables afterwards, all good, but then

I assume you should have a Device Tree in U-Boot, on Rockchip it's 
typically available in U-Boot SPL already (except on some TPL-less or 
SPL-extremly-size-limited configurations) so you can do that based on 
the aliases found in the U-Boot device tree.

Then you can also do additional fdt fixups  on the kernel DT before 
booting the kernel if that is something you're worried about (U-Boot DT 
being different from kernel DT for example). There you could read the 
aliases node and generate a mac address for all controllers that do not 
already have one in the environment for example.

You likely need both, first one for consistent network support (MAC 
address) in U-Boot and the second one in case the kernel DT differs from 
the U-Boot DT (in terms of amount of Ethernet controllers for example). 
E.g. you could have an overlay for an adapter board that has multiple 
Ethernet ports each with their own MAC address. You don't necessarily 
need those enabled in U-Boot so the base DTB would be enough, but you 
for sure want all of them enabled in the kernel).

Cheers,
Quentin
