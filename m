Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F42CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC154830E4;
	Sun, 19 Oct 2025 17:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="IxXWloTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F084831D6; Sun, 19 Oct 2025 17:02:49 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C62398309A
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGl1Ajwn5EAs8hx6ghQ20VoJQXVRDwGNBggjTC8OTEQBR+ZchfOQ7nb6HfWwiI4dmn30I4MUbjzdq5K6a5vdGkdpOPDJGdu00jB1WIYazasD95jMe5GTAxrVQDAZrCRsTWrjP1OEFr1GSkaY13zHg5iQA/HE/em8USnLck/aSFOH6+6r1pHgl21+/BTfnxaOftGyq289Fo61C5LNUHyeVHfbl4eiqRXtdZ6eN+a6FTE43/VMFbJgacXennxDxHUHzzJ63o0ViaLXUEC+S6Ym5pMozo2B9b60EIh1UIdEdDynHlV06vEi/EBHUsDNFFpREp2jUjqQunaj+FAPaibGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hStNBwlUH+ZMfxOIwrFdQjyN92/q28uHmYm9alqwqF8=;
 b=JT3+omYTmxRZmjN8EwjsZrcOD1cDAtitUhyq+6p1KAiNf3+fMw9UAzcAtHNqbRKT6W6wZt30SWJ0e7dnn0QR5bcCpdWx1TCS0fhID4E/LEk7WYt63alHBeGIdfmHmN6SDT2B6mQSZK8tyZRJM+K7ruR4Kp/UmhUb/NwVIREbVjyxJIZY9DGbtbw+mHGRGmKR2cbwLg/tX5E2sTVpBH8xNvD0SJ6uPQVQjHQyhb4UCgDt/vggG/7HlU4XsvCDbMEOVjDynkYcS7wnpUqfkPIms7f+UJ+sPSPNccek6HMgQ0z+LM4xWm2diwE3Vc7w5/2NLIC3jcEgrouKx+O0q/Wjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hStNBwlUH+ZMfxOIwrFdQjyN92/q28uHmYm9alqwqF8=;
 b=IxXWloTYbdOKjES3W1lmArbWW40FgoYC24uqIw4UajtCCZUdJOU9/oZq7Lcl0oAZQGjdcbmHXiKx4Peq7nePjNv9WXnT40yHzsehzybGdhOJdE29U0HVhiRQC7tYqJMOMEq0GaNCa3EF2jMPICV4emK4uwOg1KcZryTzkptjfi9b/iDIyHHnL89Vxepkoucrh0feEW0wVM9kq27l770SphHtzF3QUGxRNPFQkPNlrP2VRKu5QntC8cp8i1Tz9lOtQTuY+QJy7xU0n8SBFC4FPYCzUnrNe/izn+/u3w5qTecq0825MVnyDCsSxPnCLtNM9d9oB6JeHT+/0byBQvFaIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 15:02:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 15:02:44 +0000
Message-ID: <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
Date: Sun, 19 Oct 2025 17:02:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>
References: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dd8dc6-1a73-4ed3-7b70-08de0f208efd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzUwWEpGTkZDcjRZS0RjampZNUtNRnVPVVdGMHpKcHlrY2ZzbHd5cGFJYmdO?=
 =?utf-8?B?bnNIUzI4cUZiQlR2WDUyS0c4SzFuYm0rdVdFMHFoL0RHbmU1UTdxVHVGOVhS?=
 =?utf-8?B?NC83NmRmblV6WjVlMkJ3aWUzdEFwRWhvUkdnSTZFUFN4UUVLc1dEamZSQ0Yy?=
 =?utf-8?B?OURNQjhVdzgzZFY0VEZWRUh1UFRXNVJLejM1VFVWLzVQQlgxdkZiYkhxQW9W?=
 =?utf-8?B?V3JkZGRCT3pua2YyL215aXk5azlZTHpUVHVEUUt4ZUo1VFo1aExhRHpWbEVG?=
 =?utf-8?B?RTNnSDAxNUdLN2draUtLY1NhRXp5WVFPcDlmMWJscm05K0Q5a0x6c1hYc0ha?=
 =?utf-8?B?b0t2eElaNTRwR3cyU3ZFaFhmTmJMc01LZk13Z1NPa3JUQUkxbGpmWHB3TTcv?=
 =?utf-8?B?cHRlNXNIdW9renFSWEFnMnJvc0lXYjZZSU14c2pabXg1WWU2UU1TWWNUSGl3?=
 =?utf-8?B?Mk41V1NSZzFnMExqM3FSSW9IOU1UWld3aldYb3MrS2J6U3cwZVBWbCtRdTZF?=
 =?utf-8?B?VmhYSVZ1VTY1THdkRjZZZkNJeUtReGNmbzVnenRnd2k2Nk8wdWtzM2hjSmw4?=
 =?utf-8?B?WG9ldCtscU9JYTNrZUh6ZE91ZFFDZ3pEMk44NnBRV0RsdU9zVHpUR1Vyd3Z2?=
 =?utf-8?B?bURrWjhBdXFZZTRmK21FdDdndmJpS1F5MVNNeDdZa1B3QmNxNVlEaWF5L0hP?=
 =?utf-8?B?TlBFeWVNRGliaC9TaHM1MUNBYkRmVmhQQUtzVXNjZWsvT0hGYmxpQjNuR25I?=
 =?utf-8?B?bk00MjI4ZW9YMThlaHhHb2RSZnFnc0QyM3lSc0JZczV2NGhBYThHVXpmQVUy?=
 =?utf-8?B?RzBaTzdWY2ltSE8wNTJVN1dQVnBmMVA1UHVvWkcwaW56VGFHaXdpdk9YN1hK?=
 =?utf-8?B?UGI1VTNqTjNPZVlKdmovUXNYVmhqbTJBemxXSm9UdXVuZzNMTkNuOHZ1cXYx?=
 =?utf-8?B?Ykw4aVhTdSsrNkpDMlorTnBTUmNoaytueUFUSHBZam5FTVAwaS82ZkVBajlO?=
 =?utf-8?B?bmcyWkNMbHBidFo1aENGV1BBWmYvY3NkZVQ3VGNuWko1S29KbVFackdjNFBM?=
 =?utf-8?B?cXYwZ2NXc0dhcE4rQUcyMzF3anpDWStRS1hSSHVwaUN5U1BBeG41czlobjhM?=
 =?utf-8?B?OStTQnBLbjNGay9XV2hVSzE1M2JGay9uc1QwZDlvUWxLU29lMDJHUlhMSXhH?=
 =?utf-8?B?QmlYbStxYjJZdjl6SVVldW4yTHhuZ1U3UXl2eGRkaXhGbjlqMytWelpYNjlr?=
 =?utf-8?B?cEoxNmdLV213R2VJeHAwVnRnazVGR21oZWJFMUxlRWc3TFpIYzE2TWlva05w?=
 =?utf-8?B?SFBVUG4vZnJPUkswOGE0d3d4RUxoVWxIZTgzVERGZkhocWVxcmNOR0NLckdJ?=
 =?utf-8?B?WE5rcXAxUlo4WTFRVzZzaUltcnJTblp6T0dSWjBFN0NsbmxaS3o1QlNQMTdr?=
 =?utf-8?B?RHFSc0ZRSVM3a1IzZVNIUU1SbnBoQ3JycVZSTHpidFRXUDdtL0JpWUlQc0Vs?=
 =?utf-8?B?eHJNTzFFUUYwV3BpWDRkcDMyaSttdzZhVjliOUtMNG93cVlRVjJNaFZmcnR0?=
 =?utf-8?B?anplZUcxcE5SNmF1ajRnWVV1UkhTaEc3Qk1IN2JqbXRsWDVOcFVtdUMwUmZU?=
 =?utf-8?B?NzNLQWlkc25LRkpWM09qZk1sdjhQaEhucXlRRFVXKzlPOG50U01NektCWFpx?=
 =?utf-8?B?aDRvb0xBV3FSdE84NjlCcVdOOTkySkpMSUxyeDMzWDFob0R4QzRiOTQxRE9t?=
 =?utf-8?B?Ukpnc3pZNUxjMitsZ3gvOERvVTlYVnhMYVNMS2RTdGM4MVhsVTMzN2x1OGx4?=
 =?utf-8?B?cFc1TWhGc0JXZHdpbzd5SjRCV1g2RmtEZFF4Vm4xbE14NVA3bnlVSit3eUhS?=
 =?utf-8?B?V1FSVllncDMyQlJmamVHUi82WmU0VVFvbW0yQS9ZMFlQbUhjTHRPS0FnNG9Q?=
 =?utf-8?B?ZkZQS09yRkkwQ3Rzb2VDanFoblZpUW5oTUNJTitvT3U2M0xjK0JsSWpGNEFW?=
 =?utf-8?B?cXlOM1hYa25nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJWRzRXMEhCYlNLSWxkejEyWU5sOTNwTzRwS2JCQ3VZRU1acjB0T0x5bFR2?=
 =?utf-8?B?dktlQktUWVhhS0tVUzBtOGp2aFo0Vk5DSlZOeTl5aGV0NTFQUDh3NW1BWFFM?=
 =?utf-8?B?bGZJWXVWaTlQSTR5K2RPSHdSWVpPTk40SFZUa2ZjQzNSWGhFcVBWYlZ1Zmd1?=
 =?utf-8?B?RTV2N2ZjbFJVRXVwZWlCM2lNL1hNR3ovOHJzY1hWVVlpSzVrdWNzTFBNRFN1?=
 =?utf-8?B?aVlmb3FtSk40a0V1Y3JabGYxcnRkWFQ4STFLUlZOSVpVZktweVVjaU1NVmJL?=
 =?utf-8?B?WDg0NUx2c2paZEM0dkIwbWFpS0N1QXBFUVBkRnlpWW03N3J2bUxISWVoeTRX?=
 =?utf-8?B?NDdMaWlabVppRlNyL0luaFEzNkRGS0ZYRzlFYmZjaGhPcTBrN2tqeVJEVWkv?=
 =?utf-8?B?dFJHNGJoQWJGSXQ5N01uc09vRXo0ZWplY2M0SGd3ZnJwUU5WbzVzUGJ0QUlq?=
 =?utf-8?B?SWl3NkJYYmU4a1NHTjZCeWNWeGJ3R0s0R2wxYis5cEd3dWhzbFV1dmpwK2dT?=
 =?utf-8?B?bmNOV3NoWHExckhoOW1Rd2ZlZUczdGRUQmNtcWdITlEyMGtOK1dsazYrb2tU?=
 =?utf-8?B?UXhQWk16NXdvaGdrVjhYTkhLVHdpVlNIbkx1UURONTdwdXYvS3BlMjdpcjVl?=
 =?utf-8?B?VlNRL2lteC8wNFBqcy90MFhvWHhpRHRmSko3ZWFGUHpwSUUvZzRPYWVYWVFi?=
 =?utf-8?B?aW4zSVZnM0xUM25HYzZPZ2lrSnNZSU1VOFRhY2RqeHdpM1dEcDVObEpxeHZS?=
 =?utf-8?B?azlQWi9Tek9GTmhJaDJ6NlB1cDBRb1ltTnRYdFhKVWdrNEtPeEtXMk94dEY5?=
 =?utf-8?B?LzF0T2hDc052NHFBOGI5aFQ3VjBlUEdoWUU3Z0Q4aVA5NXZZWmRMNFlQSjlw?=
 =?utf-8?B?aWNnMXV6TWs1Mkp6M2RtRkp1bUdFS3dwK3RqUUpNcHNKczBYbURKWnUwek0y?=
 =?utf-8?B?bHh2b1Qzb1Z5N0Y2TFY3NHY0NE9NYkNoVmhiODZlaXlsanlDSFhncFVURXd3?=
 =?utf-8?B?ZkRTc3FxTExtd3Y2cERzREJQa2g2TmJmbU5NbGxJK1B6WWg3RXVOMEZSNWxP?=
 =?utf-8?B?b3puMDFEbHJzTk9Jb2Nsd3RJTExpRVVLdFJINVhmU0VuOEE2QXNocCthVjhn?=
 =?utf-8?B?YUZUV2JuMGhONVRkRG9zSU9LcnVhSkhzb1NsV21ldm1NV3NwQjBldTUxQWla?=
 =?utf-8?B?R3lTMU1JZVg4VXh2QzkvcTFGbVkrcG5mZEJKVHZ3cEJxL0RER09lcFVRSmZs?=
 =?utf-8?B?ZSsveDZDOWFPR1VwdWFWY1BIZEZ0Z0xLVkNCczFLb0xmbzVXYVo3MGlkbXdN?=
 =?utf-8?B?RmRPTnFkeTQxYTMxQkozbzdSRDJLVjdWNnhvdlBxTzFnNE4rYTA2dmZFWjVV?=
 =?utf-8?B?MXFHV3hqaEMwc2d2VFUya0M4UmR0d1dTNjExU3YrNlp4RmEwZVVraDNjY0x6?=
 =?utf-8?B?b0UvYS9rc3hrVXE3OVhuR1NhYjMwcGZvT2dFWmxLaHZUSXVnYzR3M1V6RHU4?=
 =?utf-8?B?WTlrSlZaVTEwOXBoYzE4VHZiV2pBZkFQaHNTc3JHM0hTWGM5M25GYndLMXlZ?=
 =?utf-8?B?ZHI5VVlLRVF0aU1Qa3lJbE8xektYTkFBSmJnZjlQaDUxR2xJQ2lWd21oR3cy?=
 =?utf-8?B?UitWY0lSYmpqdnB3UGNiaW9VQXN4Z1RCelg1RHgwdXBPQUxWQXBkUHlEeFVF?=
 =?utf-8?B?RWZmc2hTWkZnemNXc2M2T0N0cTlGRElXdCtXdG9OV0lkdkgxQ3dmMnRyVG5w?=
 =?utf-8?B?ZVBQWDNoWmxnMklvL2JsOHZkU2lOUVB5MmZVcTJ4VStNc0JmKyttWWk0WXN2?=
 =?utf-8?B?WVNyT0hFWVphbzIyQ2llM1V6Qkg2eXJJY0RaS0tsREM2VFlpeXBvZnAzZFZl?=
 =?utf-8?B?OFEvK2Q4Nm9WcVhKQncwby80L0dya1lOVWphR2lzaTFaZysrVVZwR2MyY0cw?=
 =?utf-8?B?KzFjbFpwK0ZVZWNFRGNwcS9sWXh5c2NtQklFQVQyN1NPT1AyQVBjY0czZHNk?=
 =?utf-8?B?WC9WUVNaMlVTb0VUWmtFKzF3VUFkMWRwbFBiNW83SjdKVVh3ZDVPV2h3S2pl?=
 =?utf-8?B?c0U0bkZPeXA4K3B0eHZlYXcya1pDeldxVHh6K0VWMTMrSGdIVG1kL2EwS2Mx?=
 =?utf-8?Q?zS8oR7gi43V7KY6/ItBuVC9wF?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dd8dc6-1a73-4ed3-7b70-08de0f208efd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 15:02:44.8518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81qDuxdku2xu4C3rp72WSjLCepaPhd7y7UUkpw6UwgilcSr9bhnMtbtPX3XHyp5UlTbYW8f6RRq+spDCA4Y/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8943
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

On 20.08.25 07:50, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> There are needed because distro_efi_read_bootflow_net depend on symbols
> provided by those commands when networking is in use. Imply is too weak.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This obsoletes https://patchwork.ozlabs.org/project/uboot/patch/fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com/.
> 
>  boot/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 54ef7052c5c..2813a39b102 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
>  config BOOTMETH_EFILOADER
>  	bool "Bootdev support for EFI boot"
>  	depends on EFI_BINARY_EXEC
> -	imply CMD_TFTPBOOT if CMD_NET
> +	select CMD_TFTPBOOT if CMD_NET
> +	select CMD_DHCP if CMD_NET
>  	default y
>  	help
>  	  Enables support for EFI boot using bootdevs. This makes the

Ping.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

