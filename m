Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DD3C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 06:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC319881DB;
	Wed, 15 May 2024 08:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="J6zsEDpV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E131583339; Wed, 15 May 2024 08:33:50 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F57881F8
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 08:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGbGgBu/0hAhBYzLjUxvrxsbfo/GvdyC9FCF+f9NZEIFJ3CwceRnBKhCiuVtUJgpcaotVPr7qXJtbTPOyoXYaHMQeImFL11ew/HMNZ63ARu/n0b5EIp3s50fpHAzX2IPKW/eZQb6lKsCUfEatk+1fCy5rUMqvEH70RltwjGAoMPgjHuDIoratOeX3O3UEGgDRc8G8b1oViOOl/edjLATbT+XNnqWnbB6dToihTp8dMdki0nDKutJ8yyEQKnwgg09L42jKIyGMyw3f+sDXVVI/Lo4egHyUy5AKM7Zm7iN8BP1qgRmkMIug0KWtPIluBpdywT0UCwOu2PR14IAeabTJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pq/QTQBYg3eZ1uqXcjmqYtSCh3ODvxpfffD5q2/YcBs=;
 b=AGYehVHs02cD5f7kL+xJ78yrWcX4bIG6SAhTIIOdsbLSPWYokNqUxsEy0HdC1ejC1Jds+QdeaSjCU2vb8f1Lq7cpA/KA00JCs2FM7XctrruiiW5IVbFoEkb7MJqg4L2s/NyAG5E85F0iF3Em9cyXT3gez4zxo1wkhWc4gqHi7jEmb37poX3BX5IeY11OjYjg+mNoYXUUIHfWP+seGJpnPuJACOte0xyMytUExMQzMNvhrdzUfhleqUOJmnvbXw36j0ba+8+tBfO1d8ygaxc7dtFbDxR50VNJjSAla8X2l18cVAOG2f5JnXzhfmD7p7jriq/uyZ1+xuOvu106K2IURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pq/QTQBYg3eZ1uqXcjmqYtSCh3ODvxpfffD5q2/YcBs=;
 b=J6zsEDpVHvUo3mV7N1DUEXvaymEcVTaljFpFpD9KfBZ0UpeqlqxI5IciWYOCfb+SMndYR6DYFmHMesbSQzKnJUHiIlM9xMxhYYkQFYTH7bfm3JJ3AdXzxdsBYkarLN/5wQA5oxZ8Egiai0NnsQPfs44K3X2mkLEW1NELVGK3sFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8497.eurprd08.prod.outlook.com (2603:10a6:150:81::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 06:33:43 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 06:33:43 +0000
Message-ID: <b70f810e-7cf2-4236-b199-b88d8e4c4947@weidmueller.com>
Date: Wed, 15 May 2024 08:33:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drivers: misc: Add driver to access ZynqMP efuses
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
 <20240514140416.156747-4-lukas.funke-oss@weidmueller.com>
 <aef8d0d5-15ff-4c6a-84bb-462675717b5a@denx.de>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <aef8d0d5-15ff-4c6a-84bb-462675717b5a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eac4696-077a-4e3e-aaf5-08dc74a8f71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0kydFlqQkFxNnhUWHRaa0RYNkx3M1d4RitvOUx5c0t4dFg3Y0VkSkhHTEl1?=
 =?utf-8?B?TjNvbEMxT2VEWGtLT1BCMzFFWGZ5cmduK2xoWmlQYjN1UzVVc090SmF3a2Q3?=
 =?utf-8?B?dlRwS2dFU3JZQWltQ1hsM0Y5TzRobks4Q3d4SFNGYlFaSWVoTEtZOG1jVWdU?=
 =?utf-8?B?ZXNXMkNOWi85aUlCMkVuenlTZ0dTbGlWajRhc2p5NTFWRFhjb0RaUWFycWph?=
 =?utf-8?B?di85RWFRS0VoUWlLbzRHMkdVV0VsNVdYNTVnYlQyNW1SSnQwTFlEQ2t2TkUw?=
 =?utf-8?B?WFgrTnRyWWlNUnZaS2FpT0NhTzdBcmhWREtDbkRieTEwamhCM01OQ3FqeUpK?=
 =?utf-8?B?UVRuRFpWNmtvbzcxZE9IQXU5QVB2cnVMeW91Uk00RXByYUZaU1lpTmc4OURt?=
 =?utf-8?B?R2ZUMlRvNjhydVo1cHJVbjArUG5HV2gvSVF2eUYyTUFPMFlGVFdvUXVvTzJw?=
 =?utf-8?B?Q21aaEdFTDZPVmhWaGNJWW5ta2FSbFdwTWRINGtCQnF1SVlRd0loQ0hZQlRX?=
 =?utf-8?B?YmNNbllobFBFSjBRbUhjRjNEV3piWnZtQTZOZy9ka2ZaOGFLaUlyOUlBbWdv?=
 =?utf-8?B?V0hQdDNUUXV6TFU1TEovVU4vMnc3NDlWOFpHQkRpcUVnKzZDYnFHNkpTS2RF?=
 =?utf-8?B?bWg0NWtvUCs5NGdld1N0Y3Jjam9PV2dheFpTdFdyZUZCTkRkQUliKzIrS0xG?=
 =?utf-8?B?TEdyTFZCYXM1dDROa3dGeUtwOE4rNjgyWUkxM08wa01TTSttcnVoejIrNlNm?=
 =?utf-8?B?elkweElNckFwNUlEdVp2djEyWVFMQVVqK0RSTm5Kajc0elZKc20vazNFQ0hD?=
 =?utf-8?B?bGxBS0pkZFRUNkhJZ0lzZEN0SEtiaDBTdWlkOHVEN25WM1JIM0lXNjFpWCtt?=
 =?utf-8?B?Tm9hM3VxWmpIb042U1ptWnp4Z1Y1REZZdmcvNkxUZDNEbW1nS0ZOcXBSZ1Vz?=
 =?utf-8?B?cWh5eW9JRjUyUzZ5emhOYmhHSDE0aU1Ld3FGR1RFWjBvQjVsVllWM1lzOExO?=
 =?utf-8?B?dTJFbE5Sc2NKV3ZaSTZqaGxRZWhzMkJrcUFDd1RSUkIvZGdOQWZNVzAxR2do?=
 =?utf-8?B?NFpGODFvVERybXJsOUxxRDJnUUlWUkpkWFZxL1lDdVI1blFNVFRXQm4rRWN2?=
 =?utf-8?B?bitNeVNvbjQxUFhnUHN4OUdVNm1EcW9JM0FhM0dGdVVYUmo2dDd6Tzd2bzVZ?=
 =?utf-8?B?OUJROVZlUHowS3J0S01jTU9Ed1BZbnBNSGJvMStQeXl0ZDVmUnpFOGwyaE0x?=
 =?utf-8?B?SmtpWFU2T2p2OEYrZDVuSmdzKzZQTHdjV1VnVHZ1WXBpbXhJN2RsTHdiL2pK?=
 =?utf-8?B?Snh1SVE1bE12VUpuYjVXaXZnYlpCL2VRNjFWMXo3WTN0MG9nMWRHY3RnRytR?=
 =?utf-8?B?OStjQ2szTmVJdStRcTlhOG1yeTdZdVpxdlBzck9PRytOVVNhWm5lNHVXbUhF?=
 =?utf-8?B?dm1rS3pTdXBwa3NQdEJqbkVaeFhPbGs1a0dtSldyU2FqWjJEcDZ1RmV6Wmhz?=
 =?utf-8?B?dnhSQmRYSGozT09MWG95RXJDMHlSY1ZzNE9YaXhRbzN3WWJzNEI4bmx5aEJu?=
 =?utf-8?B?dmRRQll4UkRhc1dxUGd6S0s1T1IzV2V1Rk5XWjJ1QnN6cVgyek1EZ09yR0Fm?=
 =?utf-8?Q?7gjBcWs+Qrg90XDpQY2bGmNTrG+kpx14BIjenaR0SI+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dINS9uaE04a3BiMDdSdFozcXdwY2tTZ0c3ZzRIQ1lqR0txTU96RjJuSGZF?=
 =?utf-8?B?Qllma0YyUGhZMFlMVFFCQlFKS1RGVlc3LzF6eFVEa2JXeGUxVFJ2TG1ZNEdJ?=
 =?utf-8?B?TGVEN25MdzhtVEpnNHJkelI0a0YzZFhIVWFLVUhOVmJYOStXVmJqamZCN1Vn?=
 =?utf-8?B?cEk4bjVwR2NiU3plSG9rU0w0dWkzeXNCRmxPTWw0M3pwQ1krNEZCNy9Bek1T?=
 =?utf-8?B?NnZoNmgzbFJZeUFTbzZXL0g3ZGtqN0JTVjU2d3hqZ3pza3ZBS2wvZ0ZncFZ5?=
 =?utf-8?B?blVzcmVRWkZJR21COVpXMGFyQ3l5ZTF2c2E5eFFpODVyR0lWaUN2alBFaHJt?=
 =?utf-8?B?Q0NYT3dBTC84bGlOVlg1MzFGUjBFVWhDV0UzOC8xajhxTnBORGxYNm1BRE56?=
 =?utf-8?B?VkV1dWZLQ0o0SVE4cXBzb2E4dmh2aHN6dElrZGpQQ2pnSHVpWWMrc3pSc2JF?=
 =?utf-8?B?NXlmWnoveUdDQW9YUWdaUFlwcGxOejhPMWlzeGFiNVBDZFZPVUs2WGJxSDJX?=
 =?utf-8?B?WnNQQmU2TFh0RXYyUXlhUXd6aFdyZzhTdm43Vm5rQ3NqMUVkR3pSa20xYUgw?=
 =?utf-8?B?WEpWMmJORnQxWkZ6QW1vOThpVkhpZk9EZVd0YjNvTzhpRTg4QXVIYUJkUkZS?=
 =?utf-8?B?anBJSThGdENTS3hRK2F1ZW1RcDZxTXNlYU5jRzhCekpqSWdsVEN6VDdLM3pV?=
 =?utf-8?B?dmg1ajZHbGp1Q1ZlTFBBT3M1Q2d5SlY3MkMvUElodnd6b0l3RjU4RHFQbzA4?=
 =?utf-8?B?dTlsN3I3TXN6M3FYcEx0OVJQRFdvOFpqWXFtMG9odFRvZWNOOGlTQ3dGK2VD?=
 =?utf-8?B?dlFHazJ5MnVEdm9ueG1RZ25HQVdzbksrLzBlMW9WTHAxcFhKMUR2eEJnMVND?=
 =?utf-8?B?VnR5SElUcnJKa1NNUVEwQnVHeEVRK213eXR0VlM3SVloeGMwUUpEWUovN29r?=
 =?utf-8?B?UUFJdmJGNFF0cXpzUFFYVWt3cXpxL0doSy8xS1JzeXJYNjlTbUhwcnQyNnI3?=
 =?utf-8?B?d1g5REovTXpVZUVPU2hTdFJOMmI4N3ViTm9zY1doK1pCTVd5dytadFZwSFl4?=
 =?utf-8?B?T0JWWkoyRDVUVnBMKzZJNEs1M0UxMmRyZHRkUTJpWEN5YitpSVFRZlVtZjZm?=
 =?utf-8?B?SDBjSXQyM25jV2VSQ0srYS9ndTgveFZIcnlUMitDTXdEYmdXUmRQZkd2Y2VR?=
 =?utf-8?B?aGVIY1EwRi80NkZsTTBHTjh2aGJSRGE3Ymp4aUZ6dFJUNzJzYVF2RlZ1djFM?=
 =?utf-8?B?emJsT0NXVVZKWkNEN2dOYi93cFNFWFp2MlMyVWlnZ0xYMDIvTTdKTWFab0FX?=
 =?utf-8?B?SVE0YS9oVE45VEVUYk5SaGxwd2EzVVkwQjFOMlRwN1RCM2dnZ0xKRHVTWjBj?=
 =?utf-8?B?N0J6MWFrdkpuWVJ2MVRaV1ZTMUdoUGVYNlhlOXFXdUlTSmc3TEptVEdOSDRr?=
 =?utf-8?B?cmw2d2NLVi9rUU5rSDdKWGp4WE1nL09EZmV1R2pmbjJMelpRUzZKNnlGZWdk?=
 =?utf-8?B?WnNvbnB1YTNpM3FxMHNxSTRKdWVDNUtGUTRwcEZnQjVIcTlHekE3WTVUL3dT?=
 =?utf-8?B?K1RUQU1XcVV1RjJkUVZTY0dCMzJWK2xIRU13WU8xZ0VWWUsxR3NkRDN4S2hn?=
 =?utf-8?B?MjdNZjFBSFFuc0MrZ0JsK3NKR2dRczRtVlUwck9JOElFdlI5ZkFuSHM3cURV?=
 =?utf-8?B?VzFMVUxRTTE3T3dWL1gyL2VCWmpqMkd0T1pjQk40YWFnNHlpV3RVb1d4d2FI?=
 =?utf-8?B?QjYraFlPWEhmdnJyUFBkVnJPQU1nOWw3ZXpuTEMwMXFpa3dqZE1jRGhmNXE3?=
 =?utf-8?B?MFI2cXUzcnpTeGoxcUdWa0M2Q2hkZmk0K3g1NGJBdTV2enZoZWVScjhZRkxF?=
 =?utf-8?B?MVZqNGZ2d3FLaFJnNHdTS3F6MXR4aUtNYXRQdW8vVWVOeGNtRWtxOXprSXJX?=
 =?utf-8?B?MU1GS3pSZzlveUJBSS9ySy9VZ25na3ZZNTROY0cyV1R0OUJBc3pIVmFKTGhk?=
 =?utf-8?B?aFd4Si9UYnZrbTdadjNiaWxaa2VzV0lrYytEaDYwMmtzeUhVS05WdTBweERF?=
 =?utf-8?B?WlYvS1NUc1hDbjRSRG1CVTJ5WXp0dkFnZVhIMGFzQVJ6Z2tBZEEzVjJqaHpD?=
 =?utf-8?B?MGJ5Yk9oSU9lU2NUVGtLUmE1cE9NK2x3eWFRTlplM3BXcmNiUTd4bjlRMDRm?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eac4696-077a-4e3e-aaf5-08dc74a8f71f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 06:33:43.0228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XXKtsedB5lHv0Il4VtlLiGsc5a+85NSoTfjqnh8VTchbzFriA0AT/tN2xS30AN78V51PvQkPWF3N8psqhSbSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8497
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

Hi Stefan,

On 15.05.2024 08:12, Stefan Roese wrote:
> Hi Lukas,
> 
> On 5/14/24 16:04, lukas.funke-oss@weidmueller.com wrote:
>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>
>> Add driver to access ZynqMP efuses. This is a u-boot port of [1].
>>
>> [1] 
>> https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/
>>
>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>> ---
>>
>>   drivers/misc/Kconfig        |   8 ++
>>   drivers/misc/Makefile       |   1 +
>>   drivers/misc/zynqmp_efuse.c | 213 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 222 insertions(+)
>>   create mode 100644 drivers/misc/zynqmp_efuse.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 6009d55f400..c07f50c9a76 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -298,6 +298,14 @@ config FSL_SEC_MON
>>         Security Monitor can be transitioned on any security failures,
>>         like software violations or hardware security violations.
>> +config ZYNQMP_EFUSE
>> +    bool "Enable ZynqMP eFUSE Driver"
>> +    depends on ZYNQMP_FIRMWARE
>> +    help
>> +      Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU 
>> firmware
>> +      interface. ZnyqMP has 256 eFUSEs where some of them are 
>> security related
>> +      and cannot be read back (i.e. AES key).
>> +
>>   choice
>>       prompt "Security monitor interaction endianess"
>>       depends on FSL_SEC_MON
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index e53d52c47b3..68ba5648eab 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
>>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
>> +obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
>> diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
>> new file mode 100644
>> index 00000000000..0cfc42a4f39
>> --- /dev/null
>> +++ b/drivers/misc/zynqmp_efuse.c
>> @@ -0,0 +1,213 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * (C) Copyright 2014 - 2015 Xilinx, Inc.
>> + * Michal Simek <michal.simek@amd.com>
>> + *
>> + * (C) Copyright 2024 Weidmueller Interface GmbH
>> + * Lukas Funke <lukas.funke@weidmueller.com>
>> + */
>> +
>> +#include <compiler.h>
>> +#include <linux/types.h>
>> +#include <linux/errno.h>
>> +#include <zynqmp_firmware.h>
>> +#include <asm/dma-mapping.h>
>> +#include <dm.h>
>> +#include <dm/device_compat.h>
>> +#include <misc.h>
>> +
>> +#define SILICON_REVISION_MASK 0xF
>> +#define P_USER_0_64_UPPER_MASK    0x5FFF0000
>> +#define P_USER_127_LOWER_4_BIT_MASK 0xF
>> +#define WORD_INBYTES        (4)
>> +#define SOC_VER_SIZE        (0x4)
>> +#define EFUSE_MEMORY_SIZE    (0x177)
>> +#define UNUSED_SPACE        (0x8)
>> +#define ZYNQMP_NVMEM_SIZE    (SOC_VER_SIZE + UNUSED_SPACE + \
>> +                 EFUSE_MEMORY_SIZE)
>> +#define SOC_VERSION_OFFSET    (0x0)
>> +#define EFUSE_START_OFFSET    (0xC)
>> +#define EFUSE_END_OFFSET    (0xFC)
>> +#define EFUSE_PUF_START_OFFSET    (0x100)
>> +#define EFUSE_PUF_MID_OFFSET    (0x140)
>> +#define EFUSE_PUF_END_OFFSET    (0x17F)
>> +#define EFUSE_NOT_ENABLED    (29)
>> +#define EFUSE_READ        (0)
>> +#define EFUSE_WRITE        (1)
>> +
>> +/**
>> + * struct xilinx_efuse - the basic structure
>> + * @src:    address of the buffer to store the data to be write/read
>> + * @size:    no of words to be read/write
>> + * @offset:    offset to be read/write`
>> + * @flag:    0 - represents efuse read and 1- represents efuse write
>> + * @pufuserfuse:0 - represents non-puf efuses, offset is used for 
>> read/write
>> + *        1 - represents puf user fuse row number.
>> + *
>> + * this structure stores all the required details to
>> + * read/write efuse memory.
>> + */
>> +struct xilinx_efuse {
>> +    u64 src;
>> +    u32 size;
>> +    u32 offset;
>> +    u32 flag;
>> +    u32 pufuserfuse;
>> +};
>> +
>> +static int zynqmp_efuse_access(struct udevice *dev, unsigned int offset,
>> +                   void *val, size_t bytes, unsigned int flag,
>> +                   unsigned int pufflag)
>> +{
>> +    size_t words = bytes / WORD_INBYTES;
>> +    ulong dma_addr, dma_buf;
>> +    struct xilinx_efuse *efuse;
>> +    char *data;
>> +    int ret, value;
>> +
>> +    if (bytes % WORD_INBYTES != 0) {
>> +        dev_err(dev, "Bytes requested should be word aligned\n");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (pufflag == 0 && offset % WORD_INBYTES) {
>> +        dev_err(dev, "Offset requested should be word aligned\n");
>> +        return -EOPNOTSUPP;
>> +    }
>> +
>> +    if (pufflag == 1 && flag == EFUSE_WRITE) {
>> +        memcpy(&value, val, bytes);
>> +        if ((offset == EFUSE_PUF_START_OFFSET ||
>> +             offset == EFUSE_PUF_MID_OFFSET) &&
>> +            value & P_USER_0_64_UPPER_MASK) {
>> +            dev_err(dev, "Only lower 4 bytes are allowed to be 
>> programmed in P_USER_0 & P_USER_64\n");
>> +            return -EOPNOTSUPP;
>> +        }
>> +
>> +        if (offset == EFUSE_PUF_END_OFFSET &&
>> +            (value & P_USER_127_LOWER_4_BIT_MASK)) {
>> +            dev_err(dev, "Only MSB 28 bits are allowed to be 
>> programmed for P_USER_127\n");
>> +            return -EOPNOTSUPP;
>> +        }
>> +    }
>> +
>> +    efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
>> +    if (!efuse)
>> +        return -ENOMEM;
>> +
>> +    data = dma_alloc_coherent(bytes, &dma_buf);
>> +    if (!data) {
>> +        dma_free_coherent(efuse);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (flag == EFUSE_WRITE) {
>> +        memcpy(data, val, bytes);
>> +        efuse->flag = EFUSE_WRITE;
>> +    } else {
>> +        efuse->flag = EFUSE_READ;
>> +    }
>> +
>> +    efuse->src = dma_buf;
>> +    efuse->size = words;
>> +    efuse->offset = offset;
>> +    efuse->pufuserfuse = pufflag;
>> +
>> +    flush_dcache_range((ulong)efuse, (ulong)efuse +
>> +                   roundup(sizeof(struct xilinx_efuse), 
>> ARCH_DMA_MINALIGN));
>> +    flush_dcache_range((ulong)data, (ulong)data +
>> +                   roundup(sizeof(struct xilinx_efuse), 
>> ARCH_DMA_MINALIGN));
> 
> efuse and data are allocated via dma_alloc_coherent(). It should not be
> necessary to use flush the cache here IIUTC.

If I understand correctly dma_alloc_coherent() maps to an aligned 
malloc() which in turn just returns some physical memory without any 
caching attributes (is this correct?). We have to ensure that the data 
written here is *not* cached but written back to memory because the PMU 
is running on a co-processor and data is exchanged via DRAM.

Also: this is the way it was implemented in the other PMU calls as well.

> 
>> +
>> +    zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
>> +    if (ret != 0) {
>> +        if (ret == EFUSE_NOT_ENABLED) {
>> +            dev_err(dev, "efuse access is not enabled\n");
>> +            ret = -EOPNOTSUPP;
>> +            goto END;
>> +        }
>> +        dev_err(dev, "Error in efuse read %x\n", ret);
>> +        ret = -EPERM;
>> +        goto END;
>> +    }
>> +
>> +    if (flag == EFUSE_READ)
>> +        memcpy(val, data, bytes);
>> +END:
> 
> Nitpicking: Upper case label ist pretty uncommon AFAIK.

Since this is a port of the actual Linux driver I wanted to change as 
little as possible. If this is absolutly not acceptable I'm open to 
change this.

BTW: thanks for your review!

> 
>> +
>> +    dma_free_coherent(efuse);
>> +    dma_free_coherent(data);
>> +
>> +    return ret;
>> +}
>> +
>> +static int zynqmp_nvmem_read(struct udevice *dev, int offset,
>> +                 void *val, int bytes)
>> +{
>> +    int ret, pufflag = 0;
>> +    int idcode, version;
>> +
>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>> EFUSE_PUF_END_OFFSET)
>> +        pufflag = 1;
>> +
>> +    dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, bytes);
>> +
>> +    switch (offset) {
>> +    /* Soc version offset is zero */
>> +    case SOC_VERSION_OFFSET:
>> +        if (bytes != SOC_VER_SIZE)
>> +            return -EOPNOTSUPP;
>> +
>> +        ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
>> +        if (ret < 0)
>> +            return ret;
>> +
>> +        *(int *)val = version & SILICON_REVISION_MASK;
>> +        break;
>> +    /* Efuse offset starts from 0xc */
>> +    case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
>> +    case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
>> +        ret = zynqmp_efuse_access(dev, offset, val,
>> +                      bytes, EFUSE_READ, pufflag);
>> +        break;
>> +    default:
>> +        *(u32 *)val = 0xDEADBEEF;
>> +        ret = 0;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int zynqmp_nvmem_write(struct udevice *dev, int offset, const 
>> void *val,
>> +                  int bytes)
>> +{
>> +    int pufflag = 0;
>> +
>> +    dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
>> +
>> +    if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (offset >= EFUSE_PUF_START_OFFSET && offset <= 
>> EFUSE_PUF_END_OFFSET)
>> +        pufflag = 1;
>> +
>> +    return zynqmp_efuse_access(dev, offset,
>> +                   (void *)val, bytes, EFUSE_WRITE, pufflag);
>> +}
>> +
>> +static const struct udevice_id zynqmp_efuse_match[] = {
>> +    { .compatible = "xlnx,zynqmp-nvmem-fw", },
>> +    { /* sentinel */ },
>> +};
>> +
>> +static const struct misc_ops zynqmp_efuse_ops = {
>> +    .read = zynqmp_nvmem_read,
>> +    .write = zynqmp_nvmem_write,
>> +};
>> +
>> +U_BOOT_DRIVER(zynqmp_efuse) = {
>> +    .name = "zynqmp_efuse",
>> +    .id = UCLASS_MISC,
>> +    .of_match = zynqmp_efuse_match,
>> +    .ops = &zynqmp_efuse_ops,
>> +};
> 
> Viele Grüße,
> Stefan Roese
> 

Best regards
  - Lukas

