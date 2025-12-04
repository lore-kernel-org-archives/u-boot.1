Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3A8D216A5
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 16:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F287C840D8;
	Thu,  4 Dec 2025 17:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jAsPqt0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3EC684137; Thu,  4 Dec 2025 17:11:16 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC750840D8
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 17:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+8IR3ikzqcei+f0BgpA64Kip2kU87At7j4KvzW85BbTkROILBbkNQMqcflrjr9alWJwG4epFKlYdT/fdgGwSfQBJOObDutX7kc+B8rak9OZGn8GUJ1cVBnAGyAg+Trf61nsaTUN/1GQaNsSEptJHVywSwAtjp4rxm0purbNuT859jJsxGqE9MCxOcjSblaBQD+sLAwGIpbm12QWgiHBx/W12CbguMiAbijwr/lyA97SDpogSrbsjpZBAdzoHWL1cNIAbE6yQNN4usbmATPIeEwW2AI/1gmnUsiqO7vMGp0VzI9hN6YIrffx3O/z7PeV67QJ6BkrRfer4ypiVLAchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tb+lnV58WW912DE1A7pvy4B3l6pz0rQMDEwA0hAPSq0=;
 b=J4Vho7P7a3dZKuqlMwlA0H7pQY5oaMLmltgsobyxrsUbd8iTpnU0qs1JJNABFR4rkvAw3KYhqhRti1+b4rVdVD0vEhbkWRi8WjSXUUYvoLxhouHiGX/TngDQdDnhbwYy9r7dBr5UbGVPQuH8WsYvHFzoU+cVbZcG8Q0YAwuAWny46Xu+2N5TwiCpLVrj3FXIBqWiS/zovTum5WA2Vp7KbFwCDe9EkerWz5Ay1u95p9IjqU8bsLQsFLmRquTqlZc7gbElqK2ZV/yl0zMDDrGpTjIqKxMajU9fFq9lj3XDEGdTzGWOo1XduHNO9y1mTyERKZ1c3pLmFtxrOao9NdPcDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb+lnV58WW912DE1A7pvy4B3l6pz0rQMDEwA0hAPSq0=;
 b=jAsPqt0iZL1T4ZMmjD3Ibn8tHwYRueFebk9zr+LSFvfy28AIMK/cKnr1XmiLK1kmHPzgaRlxawgECDsR8hO48/nyo16SNNAiFtdg1XVrnvuxI53KrQnB6vJmMIjYkB1zFJfiitZcUYOzE70xRAOJZr0yd38L2QqRMhKg8oCitEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 16:11:11 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 16:11:11 +0000
Message-ID: <bf65e7c7-41e3-416f-b9c6-f80893a80d8a@cherry.de>
Date: Thu, 4 Dec 2025 17:11:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] configs: stm32mp15: Enable LED_BOOT for
 stm32mp15_defconfig
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20251114162417.4054006-1-patrice.chotard@foss.st.com>
 <20251114162417.4054006-13-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251114162417.4054006-13-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: d83b015e-4246-4ea6-170e-08de334fbe0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTZuQzN2TVowdXliczhZZFgrMUUwY20wdUwvZ2FhVW9rVkY5OFJBN3VGeFJ6?=
 =?utf-8?B?UnpOclRyblcweWJHbU94Vmk0OHJFUmZZNGtmU0wxY3dPV0tuUWdGakhBREp3?=
 =?utf-8?B?OFRSNHpvbG90LzhuQkxoSVdwaDBndEtuMzdpRXM2Lzk0VEk4ckJmaDlaOVVU?=
 =?utf-8?B?ekxGc1VxNWJuenU1Q1ppQnNkRXViMVl0MVVDbFUvSWR4NGRua3JGT2sybkUy?=
 =?utf-8?B?TkRLakJBN21mZTNLc0NoZzkwTFlHQ0RsSXJiZncwV2J2bTg2ZlIrWHB1MUto?=
 =?utf-8?B?b2UrUW1oMnZoeDRtZmlTSEgvK1I5eFdoYlVKc0kzbEkvSlZZSSs0ME11N0xQ?=
 =?utf-8?B?OTJFMDhsOXpMQ0pLc3hKMTZkaDdRdlpaNEdRMFhDbXRLbVlLRVhsWjBEWmFw?=
 =?utf-8?B?WnBuMWpkaEZneEllTUtRcDRkQTFRZFM3bSt5U29UOVVpeExmR1pCbUlmNjFn?=
 =?utf-8?B?U1NBYTQ5NXVIOEhFNE1jRUNFWnpXblpBdnRRZzZoTFMzcEtoR09YNzJxNFBJ?=
 =?utf-8?B?dUdPMnhMdW9wOGVvSnM0ZW5lMVJtaHFJc2tyZVFoQVB0UzNsQWxFWjIzZkd1?=
 =?utf-8?B?QjkxeXdURTNhVzFSR2JOZTh6Uzd0MVNDMkRRRC80SGRvU3IrVnZDbkxXdWdh?=
 =?utf-8?B?Zkl6R28yalNlakowa2ZDbFpmY2s5ZlJnc1hNY2ZaYmRVTlQ3MGJEUmlIK0g1?=
 =?utf-8?B?Z0Y0OGtCZno0czZObXhJRlo1MWI1aWszRGw1VFA2UjZabEQxRkN2c1cwMnU5?=
 =?utf-8?B?V1IweEdxd0JxRk5jaEt6bmIwaHF2a3FPeWhHbXNFUDNHcDBHRnNBYnhVdmJT?=
 =?utf-8?B?QSs3b3JhcUFJOVpXSndXT1hRTTN0SGljOUxyNFpJcDIvdldnKzA0R3J3TTBF?=
 =?utf-8?B?V0RlWnFFY2JaZ2ZuZXVnN3RLUUFMN1JZRTNPdVBydEp4ZVRyMWY5WWtoTjJz?=
 =?utf-8?B?cSt5U3NWRmYybnZNR2RQVXd5VElwME92blZjL0RsbFRDdGJuVWVPOEExYmdF?=
 =?utf-8?B?MlViS1pEMFlTQ29DRCtXVHloRUlHbzJ3UzlPdHNpbWVBbkRFNGlNelFySk9E?=
 =?utf-8?B?RmxhUDhuc0I4VTJXaU5HK3lBamFDanFEUWg2MDcyNFVTVlRrUmtuUms1SjBk?=
 =?utf-8?B?VFNGMW40UTg0RnZaNEQybDI5Nk1Lc1BveVoweXd5OUFYbFhzbUpBdWg0Z3J1?=
 =?utf-8?B?VFFDem5iVzFKenFodHpWQUtDc1pPd0hGYlRTVjMyeDRScm1BV2M0U3ZBUXMv?=
 =?utf-8?B?dG9sT3J3WS9vRG9JVm5hQUhXK0tiZEFuOVVTb0NnanZmODZjc3gxelE3c1dX?=
 =?utf-8?B?K2pnTnRyaUIwaHhqVko3OVVJSkp1cXM1MjBDOURrOTd2L0lXLzYyR0ZZM0d0?=
 =?utf-8?B?Y1hzY2ovNlkxNFRhSmtNc2s3a2Q1eVRaa2VnVlJieDkrMWpsWDdJbkJBUzhP?=
 =?utf-8?B?YmxxRW1hVWRaM2tYNWhDWDhzckoyUEJRV2l2VWxKTXBoR1BCZGt4Vk50V2M1?=
 =?utf-8?B?alQyblZKa0tQTERjdCt1VTIxVy9kaXo3OEVYVHJnUXAvMnhpRVltSjlUNmo1?=
 =?utf-8?B?WVNnSndpMVBFbndvYlZuRGt1a1R4ZjJZQW5paDZwTWZjWHJXWDhFcHhwUHo3?=
 =?utf-8?B?dFNVMkJ0TlVZRHN4MmpjbVllaXRjQVUxb3Fqc0FJemJ3dVlRa1piV0xpOExP?=
 =?utf-8?B?L0VPT0xpNDJaVUVqRXNEQXI3QzRoc25oRzlKSFEyMFh5d3dUakNnd2hOWDFC?=
 =?utf-8?B?cUo3RUhrdU5INjVDbEhPc2ZLdXNrWVI3UE1xZWNxdmh3alM3VXdaNXpXYi9H?=
 =?utf-8?B?UFpnYVNlR0d6cGRudjdrRjBwVXBKNkZEekUyakp1RGltd2ZPbC9qd0JpRmFB?=
 =?utf-8?B?Z0J1bDRsNDdwSDRMb0ZxTDY2eWlJMXhNY28wOUlCR2VaVCtBdGZmVXpqcVd5?=
 =?utf-8?Q?byeXa6+jUwuyLXQjOojOpyD3s2RiZyiH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpQeEtMYlFRYU5JV3hiYnhNRVoxMklhbVBlVk5EUlpZQWlHc01JR3hzbjA5?=
 =?utf-8?B?RHFaVDJTSnJHYlBXUm42cCtpSE5kaTNRalpzcEVKeVg3cGhhUTRQUDlJQ0dT?=
 =?utf-8?B?dzZ2ekVWNDV0WVUzdTNDZ0d0cFY4YlJnTVc5eE9Qa2hMdnVTOGtZYnFSNHNZ?=
 =?utf-8?B?LzJqcXRsbGRSVFZFTm1XUTNYK2tHTldMeFpxeFhSV0tMb3AzV2Q4ZDcyRy9v?=
 =?utf-8?B?NXNEbStGYlh1Y3ZTQ05IRFJWNDlvWWlpN2FHd1BwekQ5cVFOMTdwbTFWcG5L?=
 =?utf-8?B?WlJYdTVzY2xtY1I0Q3RBYnQ1R00ydkF0L1hBM2hiUFBWT0pNOE1qdzdJV1VB?=
 =?utf-8?B?K3N3Q0YzaXRBMGJ2azhKMWN6UUhTS0VqMHh5YWYvNmN3VXZNYThTTlNYNmxx?=
 =?utf-8?B?dDBCOUtFK3owdEtxQ3FkTDNRVC82aGJUaHVIWko1Y0VJYkdsMGpIUm90UzVV?=
 =?utf-8?B?WHJMZVROcFNGN0ZLdVpYU3hOa3NUejJuYkxPYytKM1RMbytsVHBleWdCOXMr?=
 =?utf-8?B?UkNiQ2huclFrNDViK25XMUYzUzkrbU1VWEZzckt5d0pYTTlUK2RscVFUb3lJ?=
 =?utf-8?B?TjJwL25LWk1JZmx2MzRHZzR2QkFwZXRjZVh1dHRXTE1aVExFaUxoanhRRzJk?=
 =?utf-8?B?VUJzc0ZxVnFxbDFyZy96Y3RGYUVxS0tCa3N5ZmovbGpCQXVrazJjbGtwSFZ4?=
 =?utf-8?B?M2xjODJnTUZqV2NkSGhRcGlkdVU1ZVdtdjNkVWpxWHJpTGtnMFE1TG9tMGlC?=
 =?utf-8?B?YUdhK2M0SVpwdzZmT29WZm56UEFsZFllVlFWRkxEL05iWWNSdUlHSjdpSDlk?=
 =?utf-8?B?cEZmT3pJQ0NmTFh5NVc1Qm1ML1pqN1l3SEd2UWF0UDBVeGx2b0doU1E1RDdk?=
 =?utf-8?B?elBzT0k5Unl3clplQU5TT0lhWmpDUy9OQk16bWJ1TFBndWV4YnZXR3QzM25P?=
 =?utf-8?B?RGdUeWZWaVF2WTBhOTlmYWJuY2xBS1ZuSnYraVo0RE0vTzMvczVzYlZ3dVQy?=
 =?utf-8?B?UEgvRlY4VkFLRE1aemoyY2k0U3ZRZGN0MEJnVVJmclkvSGRnYXRIYWtBcStO?=
 =?utf-8?B?Q0ticFFiZElLZERWNGpwTUZGYmZKZ3ZPVStPQTdoaHQzOERialI2dnhpcDZ6?=
 =?utf-8?B?M3V0SVNMU1RnazRLSEZpdUxvbVVzbkN3bncvVHZCR0M0ZUJWU0tIVU11d3M3?=
 =?utf-8?B?Q2YveE5OeTQrS0M1bWc1b2JidjdmMVYxcTNTV1BvZzJuR0VmTTU3M0hBTHlP?=
 =?utf-8?B?aUttS3lIbE9QcVplbHNuVUpKYkV4NnlzVW5tQWpUYXREZ2toUHdTZ0NYcG5x?=
 =?utf-8?B?RmVrdzhoL2h3ZnhydDkxaXhDaTBDcmUza0ZxcXBVUmlnK2NvR0RCdXVLWUQ0?=
 =?utf-8?B?ZTJrVmVWNEJGc2JoZ2FaOXFmelUxckhtempFaUkyZDN1Y29GZXRRRGd3OUEy?=
 =?utf-8?B?Z0RsaFZEZ2tLc2pZd0g2VERGbE8rTjBhdUZBZlQ0T3oxN2xGZzhnelhtUk1q?=
 =?utf-8?B?b3JGaHhiS2pJKytKY1JwVXhqRzZaSDRzbmRkS2t3Ungxd3ZscW50dGcvL1R1?=
 =?utf-8?B?OHVWbGIzR0lDVHcrS1U5MTZBSkU5aU9NZmdjQmFmMHpUazhBYzRITWlUMUN6?=
 =?utf-8?B?Sk1xTzlKTWNYQkFXbGNFT0pSRFNHSzZleXE0UzZ0a3NWbVV0V2NJdXdCZllV?=
 =?utf-8?B?L1ZMNmRGSDErajBrWWpHUXFQU1V0aDBSOGd4eG5yRVdzMmxRcDFJKzZudkha?=
 =?utf-8?B?YlVyajMwVmp4cHQwQ1dKL0Y0Y3FlOHdVaXBJWTVYbnRGSTc1ZGxmMUVkL0tR?=
 =?utf-8?B?b0pndk9tNGV3WnFraHRwZ3NNdnFPWHZIM0FCR0l0SDBxNCszT0F0alZSS0Vq?=
 =?utf-8?B?ZUNGRVpWRlhUblVpcDBQenk5eEt2SEhrRG94cy9UdTRpdis0bFU5YXVKdWpT?=
 =?utf-8?B?UTJkdy9aZFdWdjNpWDZVMnhOSitLRzFkZ1U0R0RTbTVwMlNxYm50dERXekxW?=
 =?utf-8?B?c1FyT0x0QU1GckdmeEV2OXVOTVdlUytGbm50UnBWZXV6NWd3QkZYenYxeWlC?=
 =?utf-8?B?TVU4RVliMkxuSk1BajZHMEx1SktXMEgvUW9qUlRuNnduWnBRQml1RWVuUnAr?=
 =?utf-8?B?QWx0Q0ZkUitHVmhWSGkxMWhZVEhSdFhuUDhCcU9RTm9uU3lpa1pTTGRSUGpG?=
 =?utf-8?Q?X6G1rYssmI8qFbEaOVTu3Ok=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d83b015e-4246-4ea6-170e-08de334fbe0f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 16:11:11.8706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9s27P79927RlOFomnXp5vO45lSfreDWDnNWF+GRKjNGc27AYV67LWzEBwbDpRsB5htyIcL3Vsi9XnQu614MzVIGsyCtqy2Ns6WffJrJ4kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9665
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

Hi Patrice,

On 11/14/25 5:23 PM, Patrice Chotard wrote:
> Enable LED_BOOT to use led_boot_on/off() API in board file.
> 

Same remark as previous patch. And I also forgot to say, the boot LED 
will be automatically turned on late in U-Boot proper.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
