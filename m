Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C65DC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 09:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85526835C1;
	Wed,  9 Apr 2025 11:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kyIU389F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BC6835CD; Wed,  9 Apr 2025 11:32:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E0D183577
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 11:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqctTp9kqz/5l3L4RoosXkfWw6sIrecOVL8ceDR+v8dcWfSoeScC2kpwpb/3JsUesyzPfx8TdW03HqtcLBD4aUsO2jekgLuvxAnbYle6k3gI/jjszhmfzdnzpE/bW9G84s7/yAuwgv7/gK8zivqeh+Di46yFgFTGo7Js3/caaC0wqMA+5FWVSQqqrsdzELGHBOkNSN+ID+puaJVJFk5P5IBM+7QjmhEjtuuOO3VgqRrdCj8iEBxLkwgzxOLRQohM5NCNZnUR0kdILFvBUNip/Cs5PyYuPkqE4bq/T6Ebr3ZupMdVZ11gqt+FrdvwHBzTuMs8uBT4i3kRm8witGrVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJofgZV0GzSo+2AbHhANbyIeCeE3XY1mPunv7D0OZoE=;
 b=wK3Eb+qafjoUjajmlxghuq/iUs1We8wSkc6xVg+WK9oYtVEduysCpBCwFicUcC/TFdSxneFFFHZKLDIrJ1iPHOg9HJwOnH42Ga1iqRdKnN9lxtxdhL4XFCbItt0FBzlbME0blOSiRvY9o8lOWuBWESHCS5hPhpRytBnS8zM+rsS0WCYM8dcPUPtHV1WTrQw4FEl1ItYxSVb6sNEaTWhVDAKco2Q/mqKEq6y1MRBnwSBFsQd+iitm+4QVvyELEoHpiNgLnuuWLbtwc1rKFAnLEmaro7+/j1vQCUTlw0i7lmFtjUB1JYv/Z5WaawWxC+1y9Eh632CS+3dcOaRCgdPRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJofgZV0GzSo+2AbHhANbyIeCeE3XY1mPunv7D0OZoE=;
 b=kyIU389FJLe+KdMtBoyhEaEs4KJ5QKY+SSOY3v0KCzU+13k7Su1GUB7Z9BOTCfmHk95wst9/j83k8oI5CAGRWNSbwzuo7yN3HF/TcVmnQUlFkoVFjs2colQJEpptWMMqR+zxagI1/vK0/Jb9ayX6VAaD3fGtuNG0ijCen4wD6zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB8089.eurprd04.prod.outlook.com (2603:10a6:10:247::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 09:32:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 09:32:13 +0000
Message-ID: <4c5a2d7f-44ec-4818-81fe-cfe60b4fb0f9@cherry.de>
Date: Wed, 9 Apr 2025 11:32:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] rockchip: binman: Add an fdtmap
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-4-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d418e2-dcb2-4b31-abb7-08dd774968ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3V6OEFBRUd0ODlmL2N1Z0VYWVBBMjlYUW9iMjI5SmVzV2JUSE1ZQUhZdnNC?=
 =?utf-8?B?Mmcxb1pXdGFRWm9LeFhCZVZmcFJhYjRvT2FsTFdkWExMOGNUdmtRQmJLUjdj?=
 =?utf-8?B?VlhJQmtoVUM2UzlNMHgvZ1BjVEUxcE4wRzArOXpWRlpPYUNYTG9wMlRBZFMr?=
 =?utf-8?B?NDVKNkk5d3pydWMzQk01ekNMdEE1MVRRWXo0bE9XcEFMNGswZGlNMmFrMmcr?=
 =?utf-8?B?TUdhTlhWakYwUTkxclN4WVhHK2YreDB0a29iZUZPRkxDRC9XNXVEUFh2NVU0?=
 =?utf-8?B?bmhSMUVpa250MEFTdzhIcEdGTThodGp3YUpGQlJxT0Y0RUhvNThtem1yVjgv?=
 =?utf-8?B?enFWYkFGaks4eTRyeUdBM1FCUVVnazQwNk9uRTVDRjV3clorSnl0QnQzaXVS?=
 =?utf-8?B?TDcxdzhmL01pTzB6ZWVuYWtxL1E0dUEvY003QkhXWTNsTlhGM200WmFnN2dU?=
 =?utf-8?B?cVk1WHhDTXZSZGZoTXQyd2doMGhZZFk5aXpWaHE1aWtjSWlNZzZmYnRIcHlD?=
 =?utf-8?B?c0huOFZCZDY0eXh1MXRUOWQzcXg2TG0wYkVkZ3U4Z3hBQVRKKzRxMU9aSlFT?=
 =?utf-8?B?RGk3M1M1ZWplbGpRREZIYkthSWJGNytKNElhemRlR09ZYVZHTEdyR3JQZm83?=
 =?utf-8?B?TTJJckdhWHNJeUp3R3F4em5TYTlUaWEvcDRZVmdNNlVhVHpxMHNHTWhTZkRG?=
 =?utf-8?B?Nnhqd29POStjWm1zT3JNL0E4TERTbWdqOVZTb1FIMmJWdE1leDgwR1Bva1h6?=
 =?utf-8?B?bUdLYkNxdW8yMzd2MVV6clREci9scnFidkdaRXVMV2YvbEJ4L1pEaFRHa1lY?=
 =?utf-8?B?aE45dWRVS3grZzllWHVad0ZyTzdya252YUtpbWVrZEs4cFFnaFVmL2JVN1h3?=
 =?utf-8?B?VG56MU1hK05DVjRWWTZvV1RyeG9kb0VEQzNHc2lpVlgvaGtMZlY2dm1KZmxY?=
 =?utf-8?B?TWdtU2NHRVZTLytHYmRWOHpYc3R4MkFOS3FqWjdZWXhGd1VweTJnVzFzTnBQ?=
 =?utf-8?B?WnZML3hNN2lVRHAvTDlySnV5ODhDa2M0Z0J4VDE4TnY0cWJRbEZxbmJmQ3Bu?=
 =?utf-8?B?R2k4V3pzeWxGekFSRG5rMkFQdnk0d2NpdnU5UHF0WWlCRml6VVV4TXBwZExy?=
 =?utf-8?B?azJjbXZlRHlUTmlwVmcyWURFN0Q0Z0tYOHVYbnZLSHFzY0FXbEtqalZLN0Qw?=
 =?utf-8?B?YXk1R2ZwcG5IcjhqUm1SRk4ySHdGbXYzT0hXcEllWGVBaHhmajRMY1N4ekNw?=
 =?utf-8?B?b3lhdEFrbXlCZzBBb2VlRTFGemlJeFJvaEkweFQ2MjY2VEgwNDN5dEZ2WlBm?=
 =?utf-8?B?dE1Ic0xZVnBSdmpMSi84VmxkMUh3ZWlQZDdRSWVQWHlIZUtqUjZORVQ4N2E0?=
 =?utf-8?B?TnQ2ODNGWGlsQVhVeUJZN2lOajNoWnphTitoVExKeGRIUGxFbmZqblhndXA0?=
 =?utf-8?B?WS9vMGZmM1FGTVByamhhbkV1bUFIQnhiMGNvbzE4aGljVFVPMjRBSlVXVWRa?=
 =?utf-8?B?VWE1NmcrVEs0Z3RvcS9pdnE5NEYxR1Zxb0lpS1F2VTNEckc2VEgwdEx3alhT?=
 =?utf-8?B?MlVXR0pQZFU5VXZJcHpoVlFYdGZRRVJLK3kzUXl1TGt0Q0xISzl6aEllVVFP?=
 =?utf-8?B?NEhRNzlBTUpWU1hjaTdpaXFFZ21SaWJtWEd6NkN6YkltNHY1RWp4MmNnMXRB?=
 =?utf-8?B?SVBvdUg3czE1UDB5S2RHVXNjWTBrbWk2T3pYQnJYQkgwNXI2SVpHNHBMUlBq?=
 =?utf-8?B?Wk5CVjN2bVlSdkk2anpSVkcrTDB1QmxnTjY0VE80R1VWVHl0UXJFZ3VjaTlq?=
 =?utf-8?B?dlh0dXpvRkVVMW9pZlhqM0hldlhlaGkzdUNocUlXTDJzV0M0NGhCMGhMbXRW?=
 =?utf-8?B?cDIxZmE0OExKZWdRSDhpNFBDSm50UDJUck95OGgzUFo5ZEhOckVvbzBrOWV3?=
 =?utf-8?Q?8V1rezvCA/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRHZHZzYlNxUVEvck80V2huSENUQVFLbkRUVzdmSGJUKzJhY1lRTkpIbFJ6?=
 =?utf-8?B?WjBtNEIxSUJUd0wrZVJFT0RReVJtSTRCRUx2T1BXWjhjaHBWaGlsaC9NZEFY?=
 =?utf-8?B?NW16bWk3WlVyYTVXWGxlTkE1cU9Ia2RWbkdTb1A5M01tSHQra242OFJuWGpY?=
 =?utf-8?B?RDVtZXc4a0ZodnBZblZSb09LVG4xemFacVU3eVVqN0ROMUwyalh3VHhSSnJW?=
 =?utf-8?B?VTZ6QWlhY1cvZGZCMlA1RzhndmVSNzJtMTVEYnZhN2RmTEpJcEJGUm1vRlpT?=
 =?utf-8?B?SnBmSytnOWNPMURXSFllL2dVK1l5bm4xUHp6cnN3eEc4eVBoSlQyRG41bm9u?=
 =?utf-8?B?M0NPbG9JZEVndm40YmdFbHM0VTlMQkswVEZqd25oUnRMR0JnQno2TkNNMCtm?=
 =?utf-8?B?OG05TjZEa3hmeGVRNnJ1ZDBPcVkwb1FINVV0NFR6N0VzU2xtaHFJZ1lOc1oz?=
 =?utf-8?B?Y0c0YU41RTFEdzBQeGhaYkRkdVV5KytIdTZsT1FySm1OVytqalFTa1dZNzRC?=
 =?utf-8?B?WTVLRkg0ZHNnT000OXp1WmFrdy8xdXloeW0xTnl3Yld5SDhaZXpxbGFTSitF?=
 =?utf-8?B?cWJ4S0NFRHlvVzd2RUFjSFZyQVVlLzZqMlhIeXZoTURZL3IxTWJQUGIvK3lt?=
 =?utf-8?B?aTdYVFdIQTE4cCtvVWswWktVTURyK0lycGpwZkJlc0FrSlJHVDVOdmYvMFJw?=
 =?utf-8?B?ODdtNUExTmNkTWRjS0FjcDFKbGl5YmNnazloTWVac2pKemRER1YvVmJQL2Yx?=
 =?utf-8?B?T3hyZlZmL20zbXF1dGIwR05lVWFHOW9HMTFXTXdRR202SGpRT1BMa1AvR0ZU?=
 =?utf-8?B?Qko3ZnhrQ2pTUFoydDVueHZ6eUNBMkJ1UVdaYUN4UUZJcXgvYUllMnhVRGxG?=
 =?utf-8?B?RG0ySHZucUVLcDJteXIxN0VwalBzeGhBRVlYcW9uVzMxOXpXR00zcDdBVGF3?=
 =?utf-8?B?TzhNbFIzeDgwWGhoNTRIU3ZTdHpzd0ZKMnUraU9Ibkd0UXNyMzRJRk1yVWc2?=
 =?utf-8?B?TmpUckVCVmQvQ1hWRkxYRm42VTVxRVJoMEpoU3ZpckJqek11Qjh0eXBDRnhh?=
 =?utf-8?B?L3hBY3JkQm1JQklwcmdJK2Q4OThIc3ROWXNaRW94cGxyckdSYUQzVVdZR3NT?=
 =?utf-8?B?eWxGdi9JaERJSWVsSTFTNHp1RmZ3WWdyQ3dCd2RpTm5tVzA2TGx5K0Y0SW1S?=
 =?utf-8?B?RzNnM2dKNXVod2pGQms5Mm12a3dSQ0RMUURGYUFlZGpKcWtoRVo2MGFZMmo3?=
 =?utf-8?B?ZzNZZW81czlwV21mVWtObzZuaEJYSUhtZGRzR2NETThHRFZmQXVtVmNCcTNX?=
 =?utf-8?B?TG1qTjRmMUoxVEExUnNYSEw0b3l3Zm5SMWhLTWlEUTgwcmpuV3prT2dielg4?=
 =?utf-8?B?ZGFhb3lmWUNsTzRyaUF3NWRoT2lKZnd0SXJIbTdxTHJzSERmSVIyckJhYnNq?=
 =?utf-8?B?M1ZRWlhZVm1Nb0xwNnZnU0ZEZGZiQUljU2d6SktjZVRSYzRhNjlKNzRMR3p4?=
 =?utf-8?B?cldpVTRHa1NOZENSSTI4RjlQN1hWQ3d5ZS9uaXJMUmU5YnpsZjVPVzh3bXBm?=
 =?utf-8?B?dTBudnVEQk15U09ObnpLSWwvTFR6d1djbEUxV0MyOVROTkkrS3l2Z0M2eGRt?=
 =?utf-8?B?MVovS0tDWFdNaHBob2Q5ZHZiNWdZaEVhR3owQnl3aThPUEp0VnJNcGtid0JL?=
 =?utf-8?B?ZXNORHI0TTk2aUlIb3dQWUdnenlMVHFoVlFBVVFPM1ZxZnJaQjVzREJqOFlh?=
 =?utf-8?B?aHRtd1RaV2tZS3FveFlNaWR6NGwzaDRGdUJtZFUxdWE0L216RFI3MmNzdnE2?=
 =?utf-8?B?L0ZYOUFKRHQ3Nkx5WktLVHhaOUdZWVRqNllyYi9pMUduMEpqRnBrUDU2eVgr?=
 =?utf-8?B?amdZRnBPQUorVTI2MlNRWTdwUlVlS1lYTTBGcERFR0NyOXROaDhVU1dNcXdO?=
 =?utf-8?B?VmFYaE13VXB1VEpJeHBHcTEyZit3aThuZjVEMS9uTUpyYUdHcjVTUjY1ODBM?=
 =?utf-8?B?QXlxYmxBYzE0SDU5WWp4cEU3MldwUHFxWnBVS3FlbzlJOENpTEJoVmdsc2pq?=
 =?utf-8?B?ZElsY1BZbVpWVFdsK0pqU2orYVNwbUFvM25mRXpqSW12ZWlnSkxCME1DVFZ5?=
 =?utf-8?B?ajl1SitSL3I1Zm5PME1YM2VzRVdsSUZ6SUZDOUV2ODRBK3pJUi82OUZlOGdX?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d418e2-dcb2-4b31-abb7-08dd774968ba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 09:32:13.1357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAKz5mm6Hi4c27hol798yzODFBbCZv1zZ6LLwHHLHpY51sjZE/zwblUxjq+NEKUI2rahPeQVlzbDD6WAZJTPKVBdnzeCDRKE7jxrUswf1pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8089
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

Hi Jonas, Simon,

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> Add an fdtmap so it is possible to look at the image with 'binman ls'.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
