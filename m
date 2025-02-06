Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB199C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4D2807F1;
	Thu,  6 Feb 2025 11:41:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D9o+NqKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB323807FB; Thu,  6 Feb 2025 11:41:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF6E807E4
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 11:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2CK26idsOrJ8aBgM2yDK9Ht6nHi4HKMsUrKx0LjPLXsm9cGYlNxFZEM+1ELdX+3l3wPNpkFHSNGjAjpSKdZSYewYu8pFopj6o6RxMiqKv3hH9+mDYKYZybYm0IK6ka66Mcwik4wMxK1QnxHLVS8XKhW9edJP41cZMhBb1zM3MpsTTk7KnWnql/VvkXX2/RJj3WmhWteNSGKqhalk6zvFmvrjkc6Cw5VjG+ZupYhA3eHqgn9jrtJu+bhfUcPWh0YEnhjWJQxQIB/gnmOOlQRkqtlGYemgwvHytXMetGuHTB6Ru/pYRjnRFYpz+NTMiB52Z49VB20pGT0LYF6evcLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ21JrC0/pPAISZyH6hJChOB2zEyotZeSxO+z3Kh1Uo=;
 b=F+rcQU9rVHXOYljwyxCb2UBmtqeeqV0j2GNZpTvtwxTti5AyK7XfMxlh+bEQOA1pZfxGDjzgzrIYYTsx+slwLo78W5Vydo0AMokZZvre+OzvykwmcmB7mWKZNXuuZtcpWevLoO1CxjyF57C745ZblYY3CCk9Ai7/klm9GqxIO6E3B4XFJr8xA65KbFDNqaRc2Imh6jUxZX8pcX+p8m0anLqh3LAWUNx7CPgwOcTzdpsLVfi/7KbmuUfWmRQ1UOjBYblYV1L5fyqO6PPzdfuFca9p0CpWdmOtsMOPkw0vct7FOoV810f0+Tjwju8CR3hetLfmDULfCG4neMEVJ7qKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ21JrC0/pPAISZyH6hJChOB2zEyotZeSxO+z3Kh1Uo=;
 b=D9o+NqKI3Ls8z9Bm0wHbUF018H69gKfTRKM4pP5PkLmavwnlEHepfugnD5lU7ytAHfCTubi+4zSMUeUYHk6Z6ikWQo7BiUOwAEM5Zy58/xQVZJYJRBE5H/pfhyoAhdOCFZy2E6uDNVV3fECOE8tbJ8NE/fDG/CeJxnMbBpqCwxjlieO1vvDhiluENeSjjcGMUGO+HMBcQKobWOLF05Jv+/Eqd44qygeV/6WG6x+dyT/TEpkpkvn2NiScLYzxeD4m9nEXp4ctr0Xx0x0Semne4LuSf0HAD9BJAziqrfEAHDLhFuUWbs2+xUMM8jh3g4qFSrmx0aRwoe98mH5lJPW6kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by DU0P195MB2174.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 10:41:22 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%3]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 10:41:22 +0000
Message-ID: <4f5235ac-c85d-4183-94c1-17650ccad9c1@phytec.de>
Date: Thu, 6 Feb 2025 11:41:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] phyCORE-AM62x/AM64x: Add RAUC and Secure Boot
To: Tom Rini <trini@konsulko.com>
Cc: w.egorov@phytec.de, ggiordano@phytec.com, joe.hershberger@ni.com,
 u-boot@lists.denx.de, nm@ti.com, d-gole@ti.com, n-francis@ti.com,
 nmorrisson@phytec.com, m.otto@phytec.de, bb@ti.com, upstream@lists.phytec.de
References: <20250205080146.1944928-1-d.schultz@phytec.de>
 <20250205145136.GU1233568@bill-the-cat>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20250205145136.GU1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0437.namprd03.prod.outlook.com
 (2603:10b6:610:10e::17) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|DU0P195MB2174:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bd2b13-f712-4f26-f967-08dd469acbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnk0MVFyaVFuQytsTTFQWTZEc2pwUnRocm52Vm4zYlk4eXhuRzREczZsckhk?=
 =?utf-8?B?K3VYKysxdm0xUlg2N2hXeEowSUJPNVlEMW01TmhWbEZSbmJRVS96UTNqZU9i?=
 =?utf-8?B?c3ZLd1JjMW50T1FmREdqZGU0TmxjeWh2TUY0c0Y4QjFnZnVMK2c4Qk5GNmJw?=
 =?utf-8?B?ckNyWmFoeGh0T090WjIyWERKOUcrcG5TcjdIMjRqRUNtS3oxWE9xMzZtM0x3?=
 =?utf-8?B?Uk0vY0RZZ0g3c3A4ZWdnTWV2dnVPeVJaSXdLNXB2ejBxd05MRWhJSndHTkdU?=
 =?utf-8?B?WjI3ZzNiMElwblNYdEFNZ1BQM2dhVmJoWWpET2dVbVdadm45cS9zbGF3VGJz?=
 =?utf-8?B?S2ZYbVY4WmVlSTZyUUtOaXBMWWROd1dGQTBseVl2djJicDhGTi9TZXJpc0lG?=
 =?utf-8?B?L1ZNZnF6L2hXd0FoTlJMemJpdXRuMEVVMmZHOWpTK2xpTWp2ckJkdWxPcE8y?=
 =?utf-8?B?amhTdlpIZmJ3b1dEOHF5Q3k2VDJjeXlHSWtLNEkrRVh1RHA1QXVFdmthYkRH?=
 =?utf-8?B?clcvS0lVVDRyekZNUUxVSFRIbGZQYjNFQW4xN1NYdHJPeTZKeEdEYXRMWHVF?=
 =?utf-8?B?RlZ0VjRVVXh6SmJHT0lreXVsdzNEODZUWGpxSENnTmNDQk5QRTdSYVlOV1VY?=
 =?utf-8?B?NDhEQnp4UjlqOENDV0tZMXdzaS9ZNEVBaWxtckIxMlJqNmhZRE1Gd2k0aldr?=
 =?utf-8?B?UDYzZHE1NldHZVJ1VVpZd2R1SkZuWW02MytpYWQyUDFEais0S1hCdzFWRTZv?=
 =?utf-8?B?N2p3YmlYSzVGNUpzbnRsREpxTHV1MEp5VHBTV2pHcU4xQ1RGcXE1anVrNFFu?=
 =?utf-8?B?NTd4WnZrTTJUSjdiczhHQm83WGJtQ3F3UzlaZC9uVWJoVGtsMTJxYTRFWG40?=
 =?utf-8?B?K3gzYUIzVEpoWmdwczZPUDNZVHVvdURPRVBjRVRsdG9VYlRlMUlZSnFNcXI3?=
 =?utf-8?B?dm83eHdpNWthTTc3WStLWkorV2RsV2pKYnlZb08vUVlqWS9WUm1KTjJZUzFv?=
 =?utf-8?B?clpPRUtWT0llREpQbVMyVGpTdXhDMEJRTjh5VkIyWS91ZzRpaThKOEdrcjhx?=
 =?utf-8?B?Q1RJV1FDeEt3SGFLQlVDdHVQQk1Ibllwd1QvM2IrdklOVUpiNjdwT3JrcFdv?=
 =?utf-8?B?TG5McU5nbUROa0NPOUxOZENRTDhzRVplR0RpdXZYUnpnV3Jua0dQN2hPTVA4?=
 =?utf-8?B?Vytscnc3ZEtzZ1VDRGltdWp5dXVFbE9yOEtoODBKdk5MMXlFcTlpNkZVVTR5?=
 =?utf-8?B?WXBMcnRpQkUzd1NDZUxLckR6am9uZDEzamVYZlNYM2xaUFp5MUFBNXMySHVh?=
 =?utf-8?B?M2NyYy9ORllMdWhDa2I5Z2hhWG0xRDE2UnNmeE53YmlHWkx5ZEdqZ2txc1Vm?=
 =?utf-8?B?RE1iQkVxT2ZsOXRaT2lUOUM3cTk0L25kVnJiWmpINnRTSE1YM055UjkwWFgx?=
 =?utf-8?B?cldYUlBTMk1ONEZBVXBOZVRpK3BhWDY1am1ZSWh1bFhMMUVjc3VuRkJMY05r?=
 =?utf-8?B?bHVuK284djJYZE8yaDQ2U0Voa2cvRXBCcDcvRkExSm1jaHRYVXFGcmwwKzc5?=
 =?utf-8?B?NDNqMkVQcFczTXdkdkRGYTBuLzc1VmNyeDEwRmZxU2ZsQWh6aW5FQnE1c2dj?=
 =?utf-8?B?dURBcGc5QXd3alFZK0dsbkxHNUIrczgwTldKcHN5YkN4c1lIcEwzZysxWnNE?=
 =?utf-8?B?cXE3ekNkSVpVWDFTQzhtTVVxbnhET0JIbTNDOUZnVURVQ1FObXJ6QWoxLy9N?=
 =?utf-8?B?SEE5bTdIcFBtWUczajNWaU9HM3B2NHFobFRBckVPV3VKZHZoU1BsMkMydVda?=
 =?utf-8?B?V3dFaEZCYUY5RXRiZCsrcGpVREt1R0hTN3I5Q0NwTFVsT0wvODMxOVRDbjFs?=
 =?utf-8?Q?s+pgg88Rop6WU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1cyZTVndHNNOE9ZNVBhaTVlSGlVT0ZQVFNHcXZMUGJ2UU5mdHFlMGhabEhF?=
 =?utf-8?B?MUJXTitubmZtc2ZmM2U0QTdsVDdMNzRycGJyclAvYk9yT2ZxS1p2ZCs0NW9D?=
 =?utf-8?B?OE1vTGpaOTVCWHQrWVpNSy9iR2FsK0R5ckRialgvQ0w2ek1XbTY3M29zNVNi?=
 =?utf-8?B?ZGJENW5tSis0WCs1UEFranZzTFh4SnZ2OW52L0ZXTkNQTDFuMDlnaWo1VmdV?=
 =?utf-8?B?RGtwWTRCdWFaSTRTdy84NVZhYW9HK0s1M1paRFh6R0t0c0tPTXJCZU1nOFhs?=
 =?utf-8?B?Wm1pek1QU2VLKy9IbmdQUHlnZm00T0poaEtiMWJ5VHMvY1RPeUZ3MDFzMkpG?=
 =?utf-8?B?djBBbVBpUUpGaHYrb1g2Z25Ua2k3RGNqZUxMMWxJRVB6bkg2OUQ3eldibUx3?=
 =?utf-8?B?R0g3dFFESEVOK0JNaGhPbHA0UjBZRGhHUjRUVmY0U1hvOWRnZzdsMXFtcVdB?=
 =?utf-8?B?UkRhZm5hTC9kL2hEbmxUODkrU2ZlSGRhOVloMkVidWwydzZQR2txNmh1ajVO?=
 =?utf-8?B?WHJ2OTFVaVFibWxYOHdEMDFIYWxvczdvUHhUdkpudEZZQUdyUGhqUHNYR08v?=
 =?utf-8?B?ejZENW9nTTdZNDNqdzQ4THBxY201by9mMVM1dkN0Z29WM2tXWCtkeEtaUkZR?=
 =?utf-8?B?dmZJSUdFOG83Q0E5dDZKaGZ6ek5iajdMUnJBVUd6enIrYkpENzNEdXBHNXow?=
 =?utf-8?B?aDFnM2tuS092bWhhY3BEd0hLUzNKM3FRWnBYTnBQRlEwQWEzMjh6WExId0Nr?=
 =?utf-8?B?K29MYTdGVW42U0hmdlA2Y3IyOWNGOHJIY1IvbmxUL1dsSlVpQUZ0VXFROGg1?=
 =?utf-8?B?V25YcVoxNllkeDRCNHpsVVFXY3l2ZzdpMlV2aTBGVEo5eG1YNUovc1p6WjJB?=
 =?utf-8?B?TVh0amdCU3V2TGRTSjB4K0k1QkJ5RnhOM1VuaEt1T1N2RFdHeWtuRm0vM3pv?=
 =?utf-8?B?WmZETlphRVJBOUQxdkVwdlJkK3hkcXZMUEpvSEh2bDI2VFVRc2JOUzQrUy8r?=
 =?utf-8?B?TUJ5TkFzZ3V4SVF2R2NlVHdPVXRRSFFROE9LcXRPNjgzaUlKTTBPUjZ4UU1v?=
 =?utf-8?B?TC9uT0doSHFnVXl5TEVXUFEzTzU0aHpPS05wQ2VReDMzbkhqSkdaK2FCakJl?=
 =?utf-8?B?b2E2NFFuTkFFQ2p0bzdWb2JFOUlHMEZoVEJ4c09uYWlSdTROeXFIRHR3SG1I?=
 =?utf-8?B?cmFhMFNCbklaTHhmNHRNQTVnNjl4alRvcHA3dldlbTdVOXJVWUJIR3ZrNnR1?=
 =?utf-8?B?WXlTa05mbUFaUTVlNzY4d05Na0Y2U0VUeHcydHhkOUljSDZkZGQ2ZHI0U2s2?=
 =?utf-8?B?ZklFSFhQTTVEN2VUaXBBZ3FiVm1RSUMvOStlbGpQaXM5c0pJV2VkQkg2c3pF?=
 =?utf-8?B?QkFNVWdsazB2UXVLWEJFNmNNeXhwL0g1UlZaRU5SWW4wUEJMUWlKaVo2OFZM?=
 =?utf-8?B?M2wyZW9KSWpLUzRhckxnaTM1VUxFR3JwS1hkd2RvOGdMZEFLWUxwK0Y4Z0U2?=
 =?utf-8?B?d3JDZUFacXZDaks0YTBpeGpwZnFaSCtWNU81MXQrWUpUYUQxd2FNcnM0Vkwy?=
 =?utf-8?B?UlFTbFcxNDJseDIvS0dacDBMYjJ2R3duMXBYUitGRjBxbVFBMnN0Q3h4MHNL?=
 =?utf-8?B?WE5jRGI5OTNGZlRCclIxNHB2d2JLMEpFYy9EbUhIU1dJUnpScUdLWW9VRS9q?=
 =?utf-8?B?WDNybzFabmJPU2dFOEJLQXgxTXNMZjZXQnp4alVXWFRaenVuVDFRUXRIUVRN?=
 =?utf-8?B?UmRnSS9DMC9DOXQ0MEZGTi93UENMY2VCd1RKS0RuTEVLcDFlcEFYYS9tN1lo?=
 =?utf-8?B?Nm51cFBSaWI3LzRQZXhsUDk4d292NlZDdG9LMDZOaGIxSHR2K01UcEM4ZnFS?=
 =?utf-8?B?blBaRnRVRThkaFdpRXAwZm8veTVGbHcvTWk3eXpPR3R6K2tGTzkzeHF4Ymlr?=
 =?utf-8?B?aS9UYVE1TzcyVFFBc3F4RlpYTElZZDlTWG5melEyVzhxWlYwaS9mamNybzM1?=
 =?utf-8?B?VnIyZkhJcmdyQWdUSjRRbmxTajZKVDBlMHRZb28xVVN3UEtiblRUWXpHWDMr?=
 =?utf-8?B?anlhTG5nc2RvVVpaV0tZdm9oR3BnT3AwaC96V1d5NE5QQzNCWkI4eWNqaU5q?=
 =?utf-8?B?WjNPekljQ1VpU2cvUVVIc2tuVGFaSWRkUUFNamVkNmkxMGl6S0JmMTFCTzV5?=
 =?utf-8?Q?6vtXNQiBM/4AcMN40znWkYYerkSvWSbq4uzNmOeoyQ8m?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bd2b13-f712-4f26-f967-08dd469acbd9
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:41:21.9227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvfSMOShxWNxUTw+d5wxFNu2Rs1GVVC/3SIQ92EHVXpDBqFjymrcF6HGaAjdNLcOZhEglgeqcnw1gX80MG35xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB2174
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

Hi,

On 05.02.25 15:51, Tom Rini wrote:
> On Wed, Feb 05, 2025 at 12:01:36AM -0800, Daniel Schultz wrote:
>
>> This patch series adds support to boot PHYTEC's reference distros for
>> RAUC and Secure Boot.
>>
>> It adds a new Kconfig entry to embed the RAUC boot logic into the K3 MMC
>> boot logic. The boot flow itself got extended to run the raucinit function.
>>
>> It also adds Kconfig entries to pass private keys from an external location
>> to U-Boot to sign bootloader images. An additional config entries allows to
>> enable FIT image, because our Secure Boot implementation uses fitimages
>> instead of normal images.
> First, does CI pass with this series? Second, is this also based on the
> RAUC support to bootstd series? Thanks.

I just ran the CI tests and they pass: 
https://github.com/u-boot/u-boot/pull/739

This is what we have for quite some time to boot RAUC or Secure Boot 
with our downstream U-Boot. It's not really nice but working... Martin 
started to work on bootstd implementation after we implemented that. Our 
plan is get the current boot flow upstream and switch completely to 
bootstd later this year. Afterwards, we would mark the current boot flow 
as legacy.

- Daniel


