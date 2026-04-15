Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69ADF9D0CE
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 02:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FC983C2B;
	Wed, 15 Apr 2026 04:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BDdnJ05o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B84483EC6; Wed, 15 Apr 2026 04:50:39 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487A183BC4
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLGzm/s0G7VZ5gEZ9I80u3dpYm0iCFRxfAdmBcpyVIsg8P5UFPmQzyCRaDJdoSc/SyekApLaaQd4QC/n8IcxpxPj/o0FLxzRyEdEU3ZThR4kZ7o5/IFzYa7Yw2wJnOK4NOQVBLBTcwdxkEyrtNBX1XP9HyECOxZl1t60nNIhsJY4M2s+QUBvHRL4kmrUO4AZdRCOjK3kve2rF8ra7WHezF5PDGCEnf8JgzZNRcNMbihuOIlv38/py1QgpS6BXwgptricUPozXPpTm22Y+3rwHvcp+9v6CfPz4XHGQ7EcarKefP9Vv1j6BzN29+XJ6ysWRS89DpNRuvzp7ymDxq36QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bFW4XMro3RoJpnm+YVcyQCJRSM81MsIy+ILaZa5zUg=;
 b=TF8nXRmF+GVJEjHMOmI4WTROuBgp5CafSNDSMgpOj46U8z2rb+cC2gq+Yq0V5aK4rpC4ZCNFn21gjEoE52c/0wliDpu/6Z/Jp5x+P9DbU99VHxX/JefFGO22JliIRy8bc1vpA1rXudgjJVRjrd/UN9R0SqJo8mcFh0rHbiukQ9v3ADfZcQIBGrmWQjCEKyVHEqG6Dj43IrrLKK4R7ormLBZUh10USmzJ4B6nANV73tLeLdkPWpICI9KQMIZ4Y6H1P4+lqLSKPvQazSzMMTaNM4ASo/re+3q/f0Hl3cdj7IJc6RBtWR8SwUHwijRJC5nKL+GI4D206812oOp25S0r9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bFW4XMro3RoJpnm+YVcyQCJRSM81MsIy+ILaZa5zUg=;
 b=BDdnJ05oQLGwdaHiGU8lP58AsgYi7CAGDBKlyPtCryC0W6l7slCU0h3VaHgq7Ke2DDJicpNYTCODWsdbcsero8uqB/wge4yG0EH0WhMtHgfB0ByAGx+x/iC1nlO1BQmbKR4Y0KnJaHjPAOI2q79JrAFjppjyMOh1kbIqAUPAVfwe7O8MnqYvJ+6mtOednWsPCbAIUcMkQBBQ+2jcALkhLPYbTR/rpA3Q8AyqPjKavral0b5c/qgXtdvzkm+812dJ6LjalYN+JNPddpJ1TIL34fvCDGE9q/Mlb4wqcOqGDdpPxwtyIiUa2DdzTHN/W+5TlXuhBwj0vUe/q6j2+xCykQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB4949.namprd03.prod.outlook.com (2603:10b6:a03:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:50:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:50:33 +0000
Message-ID: <46f015a6-6418-4420-a16f-5cce8a8a8f4e@altera.com>
Date: Wed, 15 Apr 2026 10:50:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: fpga: arria10: Clean up dead code
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>
References: <20260225044257.31225-1-dinesh.maniyam@altera.com>
 <LV8PR03MB813790629F927F0CC7F17BD0A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <LV8PR03MB813790629F927F0CC7F17BD0A7242@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: ab26f9e7-da2f-40f9-b111-08de9a99c30a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: oSn+aP2E+uIqekPWa6MDoQSSdKC2JL7T3/+Gc9LWE8HGKuLbVim6ceNNstqcMG127vzAkIPlhNW5aDoAwmLQy7nEa4DoKxmpNKm29putRSBvVLFziEgDOHq/mV/i9JBXXLrY4QegvuldsZtrZYTEjlJrR0DsYJ0I0YzN9rVZPzfb/O6z/Gjc+dqMSUgjPcciBRk2+SPPic7+OewVdXGba/+aZ45WT+4/PAomcPBVnym4WM8xp1eMLo/NTF2OeOGLIsGUb+sVTC8nz213bptDdiPfvfuh5mVxH9Y6LMSz2/laU1EHQkOVrIfemNJnlrHXwi3Z0gU3sU10XK0Mr6vzehBTwkhwOd6qf94HLE7Y4pcGIeL6F9uVoFlSJKpHo563QOy+0/b+f+8nR/MPpDaX7iFdOVkFPrv0xQG75Jz8Htm+ONCMkGya9pHav9YUjXE52SgJ4jw8pbNL1+rVt8WjntL78mjQFpRdWzIxtIdIjOrdNtCQgB3A1tvn70AChw4UnQoDBJbhoY0vI2jBiqpJ/cHG8331bL+ZXckL+80wLHjYJHJrV5iqY2t/Yl2uACOUPEoSHQ3HMKrEJ3+hhdY5oQHkM1VKgyz+Kp9QgsnuZMSuSptJStfVUOPJosuTqaTwq1eqhMKyS9xrsIG6I248LEPt7kKkmbMPvL37yrMDMMLGV0+oxKttYc2JRuXhO58s6xHCcMhSFMJiuKeigQD01rW9bnQItui5Yt3pYHLl+do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkN6Q2RzdEtoT1JZUmJlNURQS1NzRy9kb0ZFUmd6eUlRUHJVejhXaGtNaStL?=
 =?utf-8?B?V2ZNZFYzUW9uT2I2dTdjeXdwaEVhYkQrbWRINDhzQkt2Y2IyNlBqRjJwZldR?=
 =?utf-8?B?S25XUkY1MCtBckIyMzN6UnJRT011SmhMZ0w5YTBXVFYwZ2M5ZmJUOTNhZkdN?=
 =?utf-8?B?czZxZDI3Y0kzZ25TZjBwb2U2VUx5aTJRd2pGYTE5ZVhEQ0xLL0ZqOFZ0Nkh5?=
 =?utf-8?B?TkNIekFQeDgvRWU5ZFZ2cldSMWEyQzdiQjdickQ4VmJkYnI3TS9uOTFzeGpQ?=
 =?utf-8?B?M1JvSWg3WFJqaGM5V0hUajhlS1lDeWxPMi9TSnlsV0ZMWFJuSkdyRTZwNXhY?=
 =?utf-8?B?V2srdngvSWVoMGk5Um9GNDZMK3Z6cjQ2VWNjUGk4SW1rZVJXL1h1VDVpQ3Bi?=
 =?utf-8?B?cTV4bmIwa3JIUVUzTWh2WnhHdnVheUYyN252QS9aclhJWlJxbnp5QkNEaXNG?=
 =?utf-8?B?TFFscXp6a0dZVmgxNDY2dnRDVmVyTDIwZUJVU3pzdmt2S1p2RHNQU1RKK3BV?=
 =?utf-8?B?cXl1WVVTRW1IeE1ycXVLa2NiZnNHVFA0Y1lPNE42cG5RTnowQm02REQxU0Y1?=
 =?utf-8?B?cDhtQzhaM01DMmh6VW5zc0ZvUzNrZzRIWFdaNWIrZUZrRk1xSk5jMmtoU0JN?=
 =?utf-8?B?Y1BZcDhXcUVQeU9ZWmQ1OWwwWFJLVUc0N0NadGFteitNQXFLY21Ga2R5Uzl4?=
 =?utf-8?B?Ly9vK3Ryek8wNDdrcW5jYVIwbkFUN0RrOThMazFiV1FidTFRUVZEK3NMU1Vw?=
 =?utf-8?B?ZmlGL2R4bnZtY0xXdXNlekQ5RkdXUXhMTm5jUWRNZi9lK2lLUGlLQ1VKSHl4?=
 =?utf-8?B?TDJmYVZ5bEM5TndZWTY5VEVFaFBzSnpEVU96b1QxYW5tUUpZZ0EvRVR0OVlo?=
 =?utf-8?B?c3A5ZXJ3d285RlpNLzgxSUtIU3czOXhqSXFjNnAwWjVrVmRuekc4QTdNM0Nr?=
 =?utf-8?B?bkUvUkRZU1BHVkVMM1ZmdWZYc2NVM3VkdjFxWHN6em5yK1RrRXVjNTdienJM?=
 =?utf-8?B?WFVZVU9Cc2w3NE83WVNyVFBoWlQ0LzdMVFRxZ0x0RE5GS0ora2p2SWwwbWVO?=
 =?utf-8?B?bllhR2Y4dm5nSVY1aXpGUTNldVhKYjNmeXBZV1JYUk82bnFrVFR4V1dIOE9U?=
 =?utf-8?B?NmptUm0wOHV6SERZL1RyMVBZSml3SkYrdVg1Z0xGMzZNT0I3aW1uQ0doVHUz?=
 =?utf-8?B?VGt0MUdNdmxjR3RadDMwc1NsemNGckFLVS9LOVBkdHhPNlNyYUFoZk5seWpj?=
 =?utf-8?B?QnVIbE91eUg1YldQckk2REYvMDVWRGtYdm1yWU10dm1hNkM2M29OckVrWGdT?=
 =?utf-8?B?Q21RWWJ5enQvejY4WmR4djg5aUl4Q3FnMGlsN01xK2MyL3BWaVp3WGMyaGIx?=
 =?utf-8?B?bVZmQmhCN2Jwa3Bad1R5RjFta1RpbzZoMXU4dTJrQlk1MWVXdENHa1VKSjYr?=
 =?utf-8?B?MzRnWkJ2b2tTZWlRQUhiMSszQ3FCVk40cDNaeUJVcmh3K1lLbUtKcFBZNktI?=
 =?utf-8?B?NVZaZTBnaGJmaVQwSnVpSC9RdHpDSG5NU1ptT3pUVElXbStVV2lTYUVOMjQ0?=
 =?utf-8?B?V0EyUEM2eStGUjF4U2lZQ3VlRTRtdm5NeFA4c0dRcVJITlFFZHdhYk92V2hm?=
 =?utf-8?B?Y2dxZUhmUUpJbUVKYmo2aDFOQXc5eWZvWEZTYktLeFFiVmJnMWZSQnlSb3J4?=
 =?utf-8?B?UVJ1QU1Rb20yYURTSEUzUXFSS1dKQS84Tnh6SDJPQXgvSDF5WTRIVHlsWW01?=
 =?utf-8?B?ZURNZXA2Nm9oQS9POHpEcTJPNUdQYWY2SEVOUEp5b1ZuR1g3MjhsTENua3Qz?=
 =?utf-8?B?dVJ5ZU9NTm45TFNVVThoV0tINldGOWxBZXZlakVmRTRIWHNaSlF2b2VmU3Ar?=
 =?utf-8?B?Z0RoSUVSS2JRdnlyaExrVWVQaUN3SG5xZjNWMEVrV2M1Q0JsRklBNldZazJT?=
 =?utf-8?B?UGhrQ3FrT0F1WmdYSWZRSCtaOWtRZGxrL0J2d3dIaC9xRWwrc0J3M1VzSUJR?=
 =?utf-8?B?RjMyY0h3NFJ3SHJMN09JR0o0T2ZGR2RCWE8vZXRETDBBc0wzNmhtU3VQSWR2?=
 =?utf-8?B?VGpzUGlNbzlkUGhQZjZYbFptQVdEblZTTjlQWWU2VUpESyt4c2JFS0NPUHQ1?=
 =?utf-8?B?QUxOZ01odktmekVnRjduVnVZR1pKQ0hDWmgwV0V0bW5sMkpaT2tjRk4xVTdv?=
 =?utf-8?B?T0lGMmRENVJpS0h1UTU1UE9uR3gwcVQrMXZ2RDY4Tkk5MlB5dGNNb0RGWjZH?=
 =?utf-8?B?UitDSFFmR0tEeVhmM0hrSlBqNk5JRU5JWmFiY21KZWVvaTJqcUtlUWFFWm5C?=
 =?utf-8?B?b3psdUdnSFJWcEl0WmJhNFNwUFlPM2RCM0FXSEdPSmdDY3JGWlRaTXpsdXhN?=
 =?utf-8?Q?/D9mZtAN57z55ERo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab26f9e7-da2f-40f9-b111-08de9a99c30a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 02:50:33.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGYoJ3wnETOeVVx536LXBVMTkxfCy5bUIwOv/TMHNbvq7CPiI7ohN5sUUP4FQ5RihmTk0tOoxXE9aA1Srl4mTuWVTafm4qM8sJF61R3c/8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4949
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

Hi TF,

On 13/4/2026 5:52 pm, Chee, Tien Fong wrote:
> Hi Dinesh,
>
>> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
>> Sent: Wednesday, February 25, 2026 12:42 PM
>> To: u-boot@lists.denx.de <u-boot@lists.denx.de>
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>; Michal Simek
>> <michal.simek@amd.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Hea, Kok
>> Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh <dinesh.maniyam@altera.com>;
>> Ng, Boon Khai <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@altera.com>; Teik Heng Chong <teik.heng.chong@intel.com>
>> Subject: [PATCH] drivers: fpga: arria10: Clean up dead code
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> Remove the dead schedule() code.
> Please improve the commit message:
>   “Remove the dead schedule() code.” is accurate but could be improved:
> Mention it is unreachable after break.
> Optionally mention no functional change.
>
> Best regards,
> Tien Fong
>
> Let me improve the commit in v2.
>
> Dinesh
