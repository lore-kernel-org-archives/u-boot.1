Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B77FC5933
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 11:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A11E683AA9;
	Thu, 26 Feb 2026 12:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i/LU7KBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F37483D1A; Thu, 26 Feb 2026 12:27:32 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C85083642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 12:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hl6Gzv5hSBmt51V4Nz1f2lyNtXi9JgrFpW6KfoMOWyyYfAmTILKKvjnX2KCzYmrP3MPPNkT3TwmwW8NvVa7tQJ6NZBFTFdK6LcajIZGBpxA0CYbjCzBJS6w5h0cfXrq1z8OjA1BpYKbzO3JenJiv5XXLQqj4OhlNxIx8ZVl8mZHuLAe9tRk7vKosimYHeN+K+ViWXR5IgY6k9uFyqjrTB+QJjH2vPJzS6uEfh/ky6IzaT0hY6eG/Wcrpu+0u8gOinfjFIWruxMZLL2lvV5GW0+MGf1FI5pxX8AfmIWowSpvh+2vB/YDtU7sX1PLPECYWcFslVt8ek1ok37n++bJBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMlgQkc6DpYWBO5qoNIwLlyJJI/ZyxjsLrFS7dPW4Xs=;
 b=OyG9tQTlwS7grOC5JbX7RgtKmVI/R1zjU6K2mXMqb08IVhuEyJtnuZlbqatCLngFYw7ZYMECq/gxeYrnt1aGvsnbdlzsGSo3LO3jtx8cTZIKK+ZgPv0lYvIwX/3baWj9LlHZhYG/5GQu9+LWzruN+5b2Ogv7UGk1F8l9k+3pUORyeUKMJEsyZjKZ2I2p+gJ53DldjB/MowTGHxS0Ufbjx4HiDMhwwVIrRE4MyYgn4sZ+5ueOw5CDVA5ot71rcxFQevkD/PaqrqEv5+FzEg+UuwUCxtzyzbj9HxOqV53FrcRslGZenuzd1e5KTGkD6XNBcrEXGCyMkucmpUzrVtV18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMlgQkc6DpYWBO5qoNIwLlyJJI/ZyxjsLrFS7dPW4Xs=;
 b=i/LU7KBdn4Pui4rNxr8VML4cXjiEHTR+jGD97+cxamXmDB+QlYUWN+tkNnohf44vCa3/Ac2sCajHXWMudFMjeazNy7UxdRpCnbnb0QtR7uvAOW5RoRl/0AFr1lQOkDIOR9TliK9MhAkMHShaFuPhA969IJwJ9asJCVnGyrfpcRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB11855.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 11:27:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 11:27:27 +0000
Message-ID: <c5d54ec1-7284-42da-a34a-6f85cdcca9de@cherry.de>
Date: Thu, 26 Feb 2026 12:27:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] doc: pstore: fix typo
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20260220031841.15708-1-aristo.chen@canonical.com>
 <20260226022550.2155-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226022550.2155-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB11855:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf38cc0-4289-49dd-a88d-08de752a05a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: UA3INH/pVRuuMf6J3Vq7c4AEdhnGm/WqEvkoK39bjbv/q8p3ziIr/KPrFgZOyQ6vNulWnXjgBfeLHBCBoT5qmwB+2i8KL3+cGTm3FJeIDbWuwbUh9c3DWBsgAGgJdOsCYfutHNZsoJInfEFBBojerEBmRMkzB/xJpXve14su6nyhAcgu+Gp0FvoIMd67DhUlr9AO6uctpYwxPONKA4gQsipC+7jqLzikD62DtxB1iPZd71QbRz0C0bZX2ZCSSmE+NCrP3aJjwB5DMxzYzMJauL89uGZSkv58ltzFy5kNECzM4hNduAlWCRNxBC10CM6AUqKv58CnZs7lTH+IWy2z2chv9iZpkpJoMaoLW6neXn82Q1NYOA66wwP3ZTOezvUzJTYDOc3pQ4F63qoj8WkftNmAKCAoMx8CffqiaiiQvBOCswhgG0ulGo5bY7U+m0bHlT9ravCXAutOgqEr1iI0kUZbxj+CAOIJg5S0tQ7+KdPQ80kQBBi8+gNIJDVdEkS2yUHB/zsy9rm3PA7a3sTFf4pGj8EM+Jv6TX/LjHEzNKuQZyIH68lidxle1S2+PtA8EiXMwOILE88RC5iOBrYDsejtpYp0gU254Bbv609FZ2GGhvUGRv6XI80cQcnb3sXpR9SOrUxvCwzACaCB5saKV25jxo6AdB/o74hNgkcpthpG35SKiG/uPuhw45AO29hrt2E3bpJBg1OPDfapAI/9uEBSSnaIMnFFCRWMWxBBkp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRNWXdTSkZHNHJjOStFUWo5bk9JMlJsZzhvMzRzVEpiWXdaTldsR1JMQzJ0?=
 =?utf-8?B?elY3ZCtvZ3FFMGYvN01rWTlUSGlBejV2U2hpYXorKzV6RG5iaFFvaXJwNk13?=
 =?utf-8?B?dXBIUVZrcWNVSU1oZzN4SDRKK29abzVQd1hCMFd6TDNxUjZLM0o2cy9RdjB0?=
 =?utf-8?B?Qkp4WEdyZ1U2cDhVUkUwbXNDVnVnbzI2bDI3eUFoc3BjdERqVXIyVmplS2Yy?=
 =?utf-8?B?UGdtWGRKanNSTGlsU3EvejRPU2hDQVUwd29TemhMNVNFczVYM2FVKzRSMXhQ?=
 =?utf-8?B?Nzl6QmNlY0V6TUhkSEFDeGdWeVo5WlE0ZXVnZktEOTBicHVwK2ovN0ptdWEz?=
 =?utf-8?B?M1VqV1c4S0lmaEVWeHh1ejJ4QjJCVUY5VmxhWUxJQ3pwd25YWGE4RnA0a1pJ?=
 =?utf-8?B?QXdCdGlJZjB0L3h3cnJWUWZwOGt3dCtaWEdvYzZwYkM5dFNoRTMzMFdoN0Rx?=
 =?utf-8?B?b25HZmd4NXRIVWUvZjFGeHBtdHhUNnNEczgwdndkWnlrdnRQeTVIK09zUi9t?=
 =?utf-8?B?aVVseExpb1B6amRqU3ovaDJwbmsvdDFrQTVFRVpJWE9nRk4xSXdUNDZ0R1BU?=
 =?utf-8?B?SWlyTHBMK0R2c2c4ekMxMm50eG0yY1V6cTB0TmpyQXp4d1M1NW45QzYwa2k5?=
 =?utf-8?B?ektxRCtnbDV1YkRZNXJZM05hSkI5VS9ZN0lwUW5IRjdNNVEvUFBLVmZCYTB6?=
 =?utf-8?B?TmJtSUZLN1g1ZitXOVU4WkdlSWdQK1VDbXA2RGVBTFRFY3c5eXgyMDA5NGlt?=
 =?utf-8?B?S0pvWlFFcTJXRXlHYjN4ZkVFeTRaN1Z6VlMvM2RyNnFVYmFJbk05dXZtUDFU?=
 =?utf-8?B?VG9TRHREcVFlMWRhczdWSlJraXhLQSsxcG5mbGFuYUR4ekw5Yjh6bENDbEw0?=
 =?utf-8?B?ajBCMWhla2p5RVFUV3dFRUtacnA0R21HcTgybmlBRXdqVXAzWDNQRTJoZjEx?=
 =?utf-8?B?WXh4UlMwaGNCcS84aFdtUlN0cXhBdXVSaEEzUkRwZ096WTJPYkQvb3E0elJE?=
 =?utf-8?B?emw5RjJieGtTemVlcHVSUEdIczZ5Q0ZHV2x0cDVKNzNVTnVaU3l3K0FNMkQv?=
 =?utf-8?B?TFpuSWhtbVhFZXNKb1ZCTzlUdHBvdGlmRFNJV3FXSXNIdFdEYkFOL01wazZN?=
 =?utf-8?B?NmhqZG9sS1kwcy9lQ3VjTFZUN0VpSFUzV1JvVWU0UDlPaXlTek00cDV6RnBP?=
 =?utf-8?B?QXBLMXlib0xQM3NqdEZxdWprSFZhQVV4N0JaMUhNcGsyd2c5alNTbkI1ZFlX?=
 =?utf-8?B?eis5UTJucURTdktsdFYrYTRpL00xTWxSR25uUmc0bW1oNmdkTkE5ZXZ3TjVm?=
 =?utf-8?B?bzFmd2pXQkhITFdSZWdzSURaTHBCUjJxVjJuK1VlMFlMZTFMV3J5ejQxbnBK?=
 =?utf-8?B?TU5UWUg0NEJ0YmFNTE5NWmpoOVFoUkNHZUN4NzljWnk4ay80MlphbkcrM1Vw?=
 =?utf-8?B?eTFzSlhUSGRmbkkwdmpubUJqUkdpQUNYY2JrSmpmN04vVkIzVUpTMWQvL1F2?=
 =?utf-8?B?YkFyaUlIRk5ZTEFuWEpHVTd0WEN5eStoRzdhbnZ1MWV2L1pOaGhZT0U0RCts?=
 =?utf-8?B?cW9oblBocWRVbjhuMFA5WWxjanI3MzFzZzYyN3JmQUM2QmhCQzQvM3BsZU9M?=
 =?utf-8?B?TVE2S255c2NIbGRGQjUwZ1c1bUt4TmlxSXdaODVBR2lrOTByL3RRcmp3QTZE?=
 =?utf-8?B?dm5weFdpVnpwRUVON2xGQjI4amFDNVJRNC9pd0hidzlEOCthYW9IVGJXUFZI?=
 =?utf-8?B?aGtaZldPaVhDMHJ1NU4zK0FGSXJ2dlNKSGN6ekdPcCtvMElEd1JwWkhqaWc4?=
 =?utf-8?B?a1dCcHlvcWNCZzVnVGNXRmFTckl2U25hZ3FDdzg2ZlR0RzhyNzg1Nm8yZDFP?=
 =?utf-8?B?Ynd3VVFINEZjenpzeXV3VW9YckQ5akxETDIrbEZxUzUzZFpJV0pKL0lMaWF3?=
 =?utf-8?B?dHJLSkZucElPNVR4RE1sTk9mUEU1TE00Vk5rQVZTY0QwbDl5WS9TUWE0SlJB?=
 =?utf-8?B?WEtINnJYWEY5T1NXZGliK0lmT3VjQnJDT0FoTGxBQ214c2puVzFYZnFiK2Z3?=
 =?utf-8?B?eUd5OUdGaUFQYndodUZIZUthSGJ5VjkwR1k4L2FWcmxrUU9yVTVLU1dKMXNV?=
 =?utf-8?B?SDlWMVluV04zaU80V2FWL1N3Rjh2bHRSaEZCWmdOaVlYclY4SUFXM2V4LzlU?=
 =?utf-8?B?Z2lBOFNRNzVPVGNyU1hNK1ErbFdjaFduemVvcTZsdVM4djBsYjNFMjBwU1dw?=
 =?utf-8?B?MFVIWTFpZVdPM29NZzBwQzZMb0FyZThsQVBjQWY0TThmNmJrZTFFaC9GVEpm?=
 =?utf-8?B?R2ozdFdkVzJ2ZGxtaXJIeHdNYzVYS3NGSjFoRnNXcnRGUW1qMlRPdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf38cc0-4289-49dd-a88d-08de752a05a5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:27:27.8761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlcpGoXqNuvpSjK6MUUfXhD1jSeBHNrWBf0wksV7greK52fxQlkldLFPdmdsbcs49NG+1sOCv2cF7GrXw0fk0PYGf3Rui1F1uoq7fnmC2sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11855
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

Hi Aristo,

On 2/26/26 3:25 AM, Aristo Chen wrote:
> Use "parameters have been set" for correct grammar in the pstore
> documentation.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
