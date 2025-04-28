Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2725BC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC5B82935;
	Mon, 28 Apr 2025 12:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KAQsAE8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B7182935; Mon, 28 Apr 2025 12:39:08 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ACD08214B
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRT622m6H8NF6vmrkVdVm4Vurn20cJsNc9H8sOyWLVUYXbqmPFXETODbfzCQVr9oL3D6xGc/Ngw3gRS3MlXcfIt3afhRAHIIxPPqhzHBzUnheuWFzdPzwRvoG/FZsgaLLVRUBWDY+Omoxj6/LzAyNq3cKJj5zHJ/FaRd1feFjihUtZOrCc1H4zJMHQ7Z/Zejj44Vezd6xd4C7Jd/Or6uk4UpibpIoWwlZubtvmutQojd2tDLOkIMaFSZClCid/TjqZsQHkXCxpLYzRkZv3Y9Ybcz7ZdXHaX/+BRq6mPA2lgIvE2LG3c8oics5+RcVt+1W+WLOszWEPf/NqOx9XjI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrNMcOdptZ5Nuu1ifypOWmMmnNMbSm+EviEjxYdTmzM=;
 b=oMeiQ1pcIfWa9LmQonK7AR48Hs7oU6cGe91uZmhIVfDn2FtRJqb1+HftkfCBSx95kAMUYD/A5hxM9xpu6NXLG/DBGBD8si1nYbzEJDYrRcfU2QgmRkMOLnAzqX6S3t5TQQwRhe0fbR1OT3EGTwTkvvNdCpGIgV4mNFeJhRabGMY4B0VevC6lo9Wlcg8rl/WOoIcpSc7OYkvn0AcDK1Y7CAp7n4gmx+cunTeFf5WEt/y+9kbErIudUvcHGQK1xvA4MN01gOT93q6iR9S9mH8CbUcMeiHRm72RSqzVLO0wXgpIm2QbE3V/i4YkbNXm+f1sTSlz7KLpBMQhWE9rZUCdgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrNMcOdptZ5Nuu1ifypOWmMmnNMbSm+EviEjxYdTmzM=;
 b=KAQsAE8x78IktSmIIJ92/zeMpEb4Uh4almGseSx2S5UpKJ8E3qYz+PFQgWIxtKkac3uYRyQXvcSYwN2TRnnme75o4xQxusou3btPM9ctHPWo/gLeCgpWNahm/+M2QXd2lE4sWiLHM9QGuK+iXBGEFvLXaAE4l2Wqe4tE1Zv7q+aHBP5Z3W3X86okjuu12KpiQbcKjmDEdpIHoMvp+LYPLI+h/3iIUby1Kg+hiTIz9R3wauNNeYp6UJtdvcDl9u8Vf5gs+lElQoBhzEjucsyexvmoBXX5dnrc6FtRpW/eZQq1tMft9qI2oXTtEY4NSsmjeX/H5U8yQBlYPvrfh5gWgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:04 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:33 +0800
Subject: [PATCH v11 10/21] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-10-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea2257b-6792-4a02-c812-08dd8640e575
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDUyWEpBanY1bDhpd05RenFNTDlwMHZibkF4Q2htMkFaSFRkRnFJZkt1ZWZn?=
 =?utf-8?B?WktkWjV5bllyc3dYZTFrbHZsQmQxSS95U2NaeTcyK3ptbnE5YkdWUE8zYUpp?=
 =?utf-8?B?UitHV3hNVkI2SEU1VnJKNHl4bkVJWVJvOWloR1lHREVDSTRkVFRvWDJMVXEr?=
 =?utf-8?B?L29XQnJwSk40a3JucXJGaXpCb0tndG92eGJEQUhaWVRsZHJsSWl0NG83c2wv?=
 =?utf-8?B?L3BHNk1GNE1XcVVwRnpNVTVLU3oxc0V6dTc0RFFENmgvMjQySVQ0WVFUUERk?=
 =?utf-8?B?bWEvSTNaU01VdFFQQnYxek5paUlYVzJ0UDU5bmtEUlErZVJUZWZmNFdrSEhN?=
 =?utf-8?B?ZllaQk1zRVFFVThKYjlRUzBJekFHVTc5RjVoOFdZM2JkT0xNOWVtdUlIakdS?=
 =?utf-8?B?S2VjQ2tVZXo3TndzMjgxSno5bVFSNVo0cGsvc1RXcUdmbVMyTTMreHBlRk82?=
 =?utf-8?B?YzJvb0p5WThML1RYMzJUZ05SVjJrSkoxN3d2Z09WWkZ4OGsvZXlIZEcxVlo2?=
 =?utf-8?B?WGIxbkdmaU9VUjFHM0lzK2xHaWM4V0hiVitDL1lZZnBZVjhUYVptV0xubFFZ?=
 =?utf-8?B?WW12dG1oSVhNNWtma0JVNDJ2eDdVeGVockR4R3YwSDRtMFBGOW1aVmFPMU1W?=
 =?utf-8?B?eDNiU2QvL05mOTlreXNGemZmNkxHUHpNN0p5ZkFvQ1FiWnVvTDJpdGZiZjVa?=
 =?utf-8?B?MDRmR2JoaXB4UkVsaXJEZlQ5NkNCMGNyZ05zZFJ1aHlsbkRPYVE5cGR1N1pr?=
 =?utf-8?B?d3pFaDlSV3hJVTY1NmN0OGtoOGlMYVZVZkd2dFFJaHNIMmlHdmtoVVZkcDV5?=
 =?utf-8?B?UU5STWkydDFrV2pILy9LQlovNzA4SUpFSzc5dm1QLzF0LzFDZllTY2JXbmlz?=
 =?utf-8?B?dE9KaHFzci9QQnN6aUpFa3dwZDY5ejd4aXJ6dVBtaVJqTkI0Y0sxOVh2SXVW?=
 =?utf-8?B?SU43cjEyckNqelYvWnFPNG05UjdoNUJaMUs3S04xSXpiQm5xMGY2QUVXcExi?=
 =?utf-8?B?dVg4VDVUa0IxdmhxVGJWMFFFWTdPc29uN2pCTHFpdVVFbUhyTzBUczdlSDZV?=
 =?utf-8?B?QUdCOFdtOXB1UFdweGgxejJGbG9iZzI4ajhRMGkrM1pFVHhvZ3ZEbFF6ejQx?=
 =?utf-8?B?Vy9BTk5WejdDRkNtKzM1Mk1MQjUyOTd2SW9sNUdqalZvb1FyQURDTkVHL0dR?=
 =?utf-8?B?aHI3TWtqOWRBWWFuaFpjOWxwc2JLK2srZzNIMzRBNmQ3T0FqTHJnR2Q4ZzNB?=
 =?utf-8?B?U0pmVzN5ZGlXNE1MY3YwVllKa2EvTVZnaHdSMkJFNUVFRWFjZHhxUlowZEwy?=
 =?utf-8?B?NStwcUgrR0lld2xkKytYbUVzL1NoVlB6Ti9qVjJXai9QRjlFaytrbTNqUVRR?=
 =?utf-8?B?VitUbG00eWg4aW5CaG1LMG9nVnVYc2ZtTnB3bkl2UG1UcFhFQUw0cnpzMDda?=
 =?utf-8?B?Y3p4WWxFc2pLcGVOVXJWcXE5U3dkc2tpN1hoTlh3bEJCWEl6c3EyWC9ZeHNW?=
 =?utf-8?B?aUtibFZocWpNL2JyRVRrK3FLckRJLzFpdXlOU2RhVnE1NnJqaDRyNktXMXdr?=
 =?utf-8?B?cDdxQzdZZXdJaWFOamFWZWRGZXBzMmtCTktpa25xWkdJZmxUWVY2b0hyNnJa?=
 =?utf-8?B?c0p0WnB4RXVZTGQvSVEveXdGY3JtV0tBRzVWVEZPdC9HNTREVEFHTGhqbEpI?=
 =?utf-8?B?U0NnTW5nRWdPNlZDMXFXc3JzUkVpa2VyUGZqVElUVkx4SVdpY0lLb3ArQ2cy?=
 =?utf-8?B?dHFEWGg1ZEJMMGw0U0ttcVJmQ3d0RWIxTkd0VUxwQ0F2a3VKOWtJMEdlSXh2?=
 =?utf-8?B?aUFpU2RsNEVZU1FMdS9xUGVySFJMdXhDQS84T2VQMXQ3OVEzcmpWT09JNTZ0?=
 =?utf-8?B?SkFrTkZDTW5uYTB3SFpvQ2FWRHh6SmpmMVVPZnFwdlZFWWhJbE1QK1NrUEMx?=
 =?utf-8?B?a0xPeld6MklLZGdDbWtKZVA1Sko4S1drazFhWDU0L2F3OGw2WTVsK05ZcVdF?=
 =?utf-8?B?RitSdEJVYm9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmZnZWV3V3gxekNaSnhoSS9aSk5vSWpiLzFjZlZxRmJnTHNMRFg3bkFFK3F1?=
 =?utf-8?B?UkVhUm9Dbll6U3FVUGFacmtQdGZLencveW9mTUM3VDI1UlYyRXdnSlBwLzZV?=
 =?utf-8?B?UXZ2QmEvNjB1aXRkanFWczgyS1E0ZmJvRzVZUTJ4a2N4V1hVOFBLK3E4cVQw?=
 =?utf-8?B?amx2ZVBBNk9sdWNuY2cyYUU5WDVNZGphcE4zN1pFb2xkMXM1RXQ5M05uanNU?=
 =?utf-8?B?L1NLa3FsdzN0eXZFREhKTkN6VHArNU5ocjU0S0drRktLYnJIdmVBOTYrNWhK?=
 =?utf-8?B?dDg2Q2hhS2RLejZITzBFMC9YeS9RSmViTkJCTm5KZXFrZWlNOEpaMkxkaHdv?=
 =?utf-8?B?SmZON3FEeW5zaFhrODh3OVo2MG1pZUpnNHBxQkNzK0FDUzl4dDVBVmMzVFAv?=
 =?utf-8?B?S0x5NlZHOU1naUdJTmRjeE1FZldLWjJ4M2cyVm9KZEdIeURRNUFpdU50akxQ?=
 =?utf-8?B?MHlZWVdML1BqY3pCQWlDSzkzQ0xNTHcrR1VndGo2T0RtY0wvUTVyVlNuaXl3?=
 =?utf-8?B?OE5jcTloOHdHYnljb2JkQUlBMzhDbG8rUUtGQms3TlZLK1ZXUHFCSWVXeHlT?=
 =?utf-8?B?eUhibHI0U2ZKbUFVci9oemV0ZGJOUEZoUFY4YzZUVzhTcmpvaVkzRW03dGRS?=
 =?utf-8?B?d05kYWdSSHVDVklKSEhTci81SG1oeWErL2ZmYlBMNitVeFMvcGJ0TTRuYWZi?=
 =?utf-8?B?clpweHMydlFxN1VkQ0hMdVlxNnFSN1YrenIwUEwyTzlOcDZ2VEgzS2dxb3RR?=
 =?utf-8?B?aWxwSkRlTVRaVGNHeEUydDBHcXgxUXVENFlsRGNyYmN3bVRLcmVHWWJIWG9n?=
 =?utf-8?B?b2JqSEZJbEVQK0laSm9pSkEzMTFheU0xVU96T2IzU2tVaC9oMlU2YnBueG9X?=
 =?utf-8?B?Sy8zU0xXeE1kWE5mV3F1d0lNVGNqa0ZqSDFBdVBpeW02U2xlRE9xMGxDdnlD?=
 =?utf-8?B?TjdVMUNwdEtxMFRqNXJreUVSaGRSTGNtdHc1dDR3bTFGQ0hGQW1DOG0rZVZt?=
 =?utf-8?B?Tm1KSEJHWUNIRVpIYm12Q2FlbWpySHcyRG9wbVZLbFRYeGFMbHJXa0Q1Ukkr?=
 =?utf-8?B?OHZzR0s0cDcwcWZab3YzNDRFWDlYdURPOW8yZmdRbWpQNjE5R2RSMTMySFdl?=
 =?utf-8?B?ZUxEdXlHbXZSRnBqRXZUbHI3UTBSRmVXTXYxWEpQcjVOVkl6dHRDdlVQSEYw?=
 =?utf-8?B?WlZkWjlzcllPK1hiQndRV2tYaEZ1dGpzNldUTk1MUVFyUlNRNXpVb04rTGZE?=
 =?utf-8?B?ekNSVTA5OUFRNHpzSkVRSUoxSjVrRUF0QWhOb0lJWXhZVjhDd2l0OFlQdzRs?=
 =?utf-8?B?NTJpVGo4SEpVOUNxQldzTHNkUytnd0FlT0kwSnlZS1VqdHRpSk1qbVk3NVhF?=
 =?utf-8?B?WGNaSmVUR1lHdGxYMVAvRzVDWXB5TGdxSE1KdkQxaDBhZmhqbCtBbTJJMXYr?=
 =?utf-8?B?Q3F1SWp1NjJaSFNEZ0dkTDZsZmRKSDY0Ymh4QnRabWFWV1dKRk1jTWV2VXpE?=
 =?utf-8?B?dWJ4Qy9uVlJSWHZaR2hRYlEyVHdaT3FsVEVQTnozaDVxNDZINU5JcHp0QXV0?=
 =?utf-8?B?RFJHWlN4Z3lRQWtQekdSTisyeGg2UzZ3azhhU0NFL2t4dUsrdUc0OGtEc3hG?=
 =?utf-8?B?T0E0V1BjN2YybFRMN0E4Y3dYTkJtNHdNM01JNDRTK09tdllMb1V6bUpSRGRl?=
 =?utf-8?B?bm1LNnRhaU1NRlhqN1ZsRS94SlMzOS9FSzM2ZFNrMVVHQmhobnIrZ2c3bjhZ?=
 =?utf-8?B?eWNuNjNld3RSR09XdVl1bGgyZVhYQW9VTVVSU3Buc3JGN3JqRGNCdmlWcHUy?=
 =?utf-8?B?TWROSmYvSWQzNHZ1dXoyUktlQjlZUjVySW5haEZ6ZFN2M0ZaT0ZmNWJlaDN5?=
 =?utf-8?B?b1ZyRjZCMlQwWjBkQ2J3dGFvK0hBd2ZiWmhKRTh2Wk80c082bEk3QWZvVlpT?=
 =?utf-8?B?TnFjMVAxVTZFaWRkTWVjQUVlTnloSUdWaVNjOW5WSkt6aDRUdm8zcG9OV0RF?=
 =?utf-8?B?aXhIbktjRVlKdU5hZHFUdjZUK3ZobWJNMlJjSlczOUtob3l6ckN4T2hwV1dk?=
 =?utf-8?B?eElnaEdWV1JoZWF3MGZqRC80ek11MWUzRERkdTBLNitVV2NxVlNSb3M4OVAr?=
 =?utf-8?Q?WJFYGWiB494JjfLMUdOEjiIi4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2257b-6792-4a02-c812-08dd8640e575
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:04.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rdFJkOjcsekIYb1peMQ0dEhvlQYdj9aIetwF5oUcPMrhd1DGra+5+OLAyEMY+82OvqX/LobdbmPakZumB9nEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. Four protocol identifiers are packed into
each array element. The number of elements of @protocols is specified by
callee-side.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/base.c | 24 +++++++++++++++++-------
 include/scmi_protocols.h     |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5b..78ee2ffd2da 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,7 +258,7 @@ static int scmi_base_discover_impl_version_int(struct udevice *dev,
 static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 						 u8 **protocols)
 {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
 	int cur;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_BASE,
@@ -268,7 +268,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	u32 num_agents, num_protocols;
+	u32 num_agents, num_protocols, out_size;
 	u8 *buf;
 	int i, ret;
 
@@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	out_size = sizeof(*out) + sizeof(u32) * (1 + num_protocols / 4);
+	out = calloc(1, out_size);
+	if (!out)
+		return -ENOMEM;
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_size;
+
 	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	if (!buf) {
+		free(out);
 		return -ENOMEM;
+	}
 
 	cur = 0;
 	do {
 		ret = devm_scmi_process_msg(dev, &msg);
 		if (ret)
 			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
 			goto err;
 		}
 
-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
 	} while (cur < num_protocols);
 
 	*protocols = buf;
@@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	return num_protocols;
 err:
 	free(buf);
+	free(out);
 
 	return ret;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 519b906b4ce..9046de7e3e7 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[];
 };
 
 /**

-- 
2.43.0

