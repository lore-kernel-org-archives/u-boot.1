Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F6C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B524F800C1;
	Tue,  6 May 2025 09:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="l0rUytBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 398F7800D7; Tue,  6 May 2025 09:05:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C8480050
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJB59zjmXHyuncsr5RhIJTbxW4xoZDYVQVmkDBc6naGaX3J/mrLUHcgOH6wpiZtH7jcq4E5Ae0cFHHkHYM4BsGtpatHeBhZF1NGFSHKA6pOfaLNaE8UF9F4svnY2gs4iK4y8GjdSxsloLD4F34pgdBn0w4LnRrhOun27PSjRZMTT4SZjEHMZdMdLdmNPei1DCJdCLWIurHP4t2tcesOVwdgxFp0R/CTT0CMCYrAUKeL7/R+i3E1NsfTSuSVz998ljRDBV2pKPb5pYmCLey3H0JoJ79UA5wctjGckSOHhJ57jYFQu3lMs0V+YUlH3us1NZKzgps8xf+CLbgvQbhrzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7A4ZjarJCcXYVqXXdZchcXcPtr9628JlcrBX+frtnU=;
 b=JYSdSFymx0HWyXespYkYJ44HskFr7iuQJ4dX/OZ9lMBwfDt8+CXwFed3n8YDQ1Df0/zo1Wyi2pltadmZK4LP0YiFCe1DM1NOfS5IAh3ZYqhRK3ejPUG9myn2Mk5jz/f64H6q87BliW9jdL5d7S5+KPCVVCIpBjOqsWK8Gl6aFRUsNQz3KIaeSUcKgYWvOgGdJMrcO35azBpTHQOQ1Fgu2Ymep7e8QVyOO5NUG056xzjYpPTfr1viFI9C+9P0KfON/SdNRV9bKPDqQ94xeRGAz1U6PhzkQLV9RBJbn6caEvxKUJ+SfLQE1Cda8FisnAq3mvu9Xsqdew2RP8mvHC/Jvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7A4ZjarJCcXYVqXXdZchcXcPtr9628JlcrBX+frtnU=;
 b=l0rUytBGoDzmcOgAW1fBIuh/AefQVDZ5wLYywPg1u8HwlSZee0+DW4uZOYLwj10ejYpLiHZmiLNXZah/fzQzN8WmLVtd0YV1EmGPFxlh5ssWWKc+hch6AauX48Pwu/tqocYneZ9oMoc6UII6wJF1IcRGKyo1v5ugD4OokgpwXIYP5IoML/7ToA5SF4nDZkn2z5mNIxzM1UsM6YkMts82cIzf/y/rPYV7alEkiozhChDvXcOcIm8K1xot3AckT9DfhTXiMAxPlyLzEquu0rwD58EHfE9XV+1e1zY6Kaud+PV1ySYGryQYDnqzFpf5yH+n9vFn6/nPpW23YXC2DPgMhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by DB9P195MB1609.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:37c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 07:05:37 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 07:05:37 +0000
Message-ID: <8af65ee4-7f59-44ef-9e7f-eca12e4d4cff@phytec.de>
Date: Tue, 6 May 2025 10:05:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 1/2] bootstd: Add implementation for bootmeth
 rauc
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:803:104::26) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|DB9P195MB1609:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e7b786-1069-4314-cfda-08dd8c6c6745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEtMT3kwaVBKN3ZhbEJUTG82K0xLaldBT2FoMGtEZXZzVGJHeEFDaGtJL3oz?=
 =?utf-8?B?TEYwL2lWS3RMMWpYdmlRaDAzOU80WUZYRE5yTEhDb2hqSDMyeGp1SEx5L3la?=
 =?utf-8?B?Nk1Ra2Nqa1lvOGVGS3o4Q2RYZVFsdXkzcFdXMDZuS2tMekN6UGp6N0VORXll?=
 =?utf-8?B?bXRzVElxMzlJL3FXVWdIQVdSQ1VOcENsNXJLcmxudDJSeUV2dzBqUzZ0OGc3?=
 =?utf-8?B?VWdieklkTnNNOUtmSnJueXhhL3hxSWNEOWowdWhDdVVDcThPdUcvMC9RRUg2?=
 =?utf-8?B?Sk56dG1GVVorSzZxMDVSSmJhRHVONnZzT1NTSnNVdmlYaWdmQ2N2WmkrSmV2?=
 =?utf-8?B?ZDJzQlpuU2xGNWdrN1VnUlhUTVFIWFUzc1RoVVlCVitIcnFRMHVvb0ZSb0wz?=
 =?utf-8?B?N1FSOW43NDNVNkZIQnF0L25jSWJwR09NYkFWZzB5QUl0Sm81RGY3cFdzTWww?=
 =?utf-8?B?MVAvMGJnZ2xmTUtpTjhQb3RmNGpJZTZWQ3VEK1pleWJhMVVxMWRiQjdoT091?=
 =?utf-8?B?b1FmZEVNZ3QwVE85eEdtUzZXVm5mSVRUWEFOYk02S3JjK1ZTQVAza2FQcnZC?=
 =?utf-8?B?YmtoMENBNTJ6a2FIdWhYSzlieEhCNUlYcTZ6ajJVYWR4cnBPci9nK3FjZXA5?=
 =?utf-8?B?YWx4QkZNUjhyMnFNalcyN2l4MFJENUM1NG9NWll3WDhjVzlQNUIvUmJmUjNK?=
 =?utf-8?B?b25kTHpaSHQrd2VuTTEvTVNSKzhMUmJWUDYrU25XWS82UmN6SUg4Q3Z6OG9M?=
 =?utf-8?B?cTd3c2k2YkU0bzM4Zzdkb084TmZSdzdKVzRmWWt3a3EvT2l5K09kWmJqOW9J?=
 =?utf-8?B?WTNqYmVNNm5FSC91V1lGaXp3TlZJSEZTS0pqc2V6YmdDTmhYdEIwWUJGc1BM?=
 =?utf-8?B?cU9ZNC9nTktZcmtyUWl3L0hnV3ZEKzFiTnNYdmdFTXZHMmtxdENIMFgvSnNP?=
 =?utf-8?B?RGpqUWpHODBQNDBhU3kwb3d5K05pczVtdXA5bU5COENFZUpBZnJJNnhmaTQ5?=
 =?utf-8?B?M2VQQzl5RUlma010czJHZjh0R1ZFb1dUSFY0cjNVNVhNUUd4aW9KdW1xUWF0?=
 =?utf-8?B?RUw5S3ZnWHA5M1Fwa05naHVkRTAvUG9LVVFVME5nUGY0bElObXliZDQ5WWRH?=
 =?utf-8?B?L3hpU25EWjQ5WWdIbjVSS215eitPSVhRNkpuMk9lbi9VOTd1VVNsellWN0E1?=
 =?utf-8?B?b25xSFE2bkhmVlZ0SmJJTlNWWlVoVnBhZlJQcVN5Z204WFhBeTNlMFFDNlNK?=
 =?utf-8?B?TWZiTXowanNlSzJ1VUJtUGV5MC9qN2tFY1FDMjhFTUl0dTRPUHNLSXIzdTM5?=
 =?utf-8?B?L0VUV0hvNVdNakY4QzhyYWVuVnQ0SUNTa0xRWnVUUXJnR2RxV09nOHQ3MWwx?=
 =?utf-8?B?Mmp2R0d0VHJFSUp6NENwTlpKM0M2VXdmV3dDNWQ5R3crNk5GYVdSTzVhZjZi?=
 =?utf-8?B?M0ZUVnYrSVcrSEVxNEdLMUxqTE1lenlsaFFTSE1ocHdxdVNvTnYxbnF2bWov?=
 =?utf-8?B?bjJrWk4rM0E1UEVkenMxbWdHYWcxVUd4VE54SWNzWHdjZkZvc09TcHJCYVVT?=
 =?utf-8?B?cG5KZ3hOcUlmRFA2TUhVZUFaNG4vU1BJbmg4THNqMlRsQzEyMk9nWjJQMHFk?=
 =?utf-8?B?Sjg5YlZOa242WHpqc1k4eldITHQyTUhVc3EzUm9zU0J6OUZaR2krVEpxTUZN?=
 =?utf-8?B?QjUvdk8xdHQ2RDlLcGQvbFRGV3RaTE45QlZpeENTWVJXcUNQYS9IZEh6SjBB?=
 =?utf-8?B?SFRDRmJhRVczVDhIZGVacWpIUk5mZ1hFQnZSaU1aSjRRN0hTUFhmaU5yV0Ev?=
 =?utf-8?B?VFRhZDNiWEhwSitjVFpmeGRqWXBkemRLV0xsZi9Wdm1sUUpkV09TSjFRV0FG?=
 =?utf-8?B?bklLZmdqWHdldWREYkVPUy9rVXlTZlk2TlFNcktMVEMwb1UrVzEwc3ZuNjU0?=
 =?utf-8?Q?YXV5cPt4mMI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTN5WVlSMmRqZGFJMkJlb2xQd2xqclFRbGNHY2dqcFJCRjRSMTMxTnZmcHc1?=
 =?utf-8?B?SzlXdW5jQlZpbFA1b29yREc2WkNXL3hvMkN5SVh4dzA1WnhYOWNvS1lMdU1X?=
 =?utf-8?B?cDhKQkpKTk1BOVNUbXM4ZThVYWhDSThZaUZpdDVvSGNCRHdJNml6WVg3WTRV?=
 =?utf-8?B?VEhQZEF6WlNhSEM4SUZvZG9VVHRYclloME9OUk1WZ3paNEx5SS9Qa3pMMUh3?=
 =?utf-8?B?M3o3LzdlNWY5YUc0bWlObFNXenRmT25QZzRvQy9icmpNeFNhekJLd2JrTHJw?=
 =?utf-8?B?a3BNcmdvSmNFUVJSdkVEQ3Bxb1VXbEkxQUxKWTgwUVloc3R0WUJHTHZYNzhw?=
 =?utf-8?B?WFdPVHlteVBWbzB4cEdzbzZlaVNEVDRUcnJYdVBZK3kybnFrVll2Nzhna2No?=
 =?utf-8?B?MFRLZXB4M2huMTFDb3c0Y0IrMzZlZmlSRGM2bVV1RTV2QjlQOUpxQ2ladCs1?=
 =?utf-8?B?enIzSTYrbmFCRHdtV3dkNG9mZzFwVFZabzBQWHUzL25VSE1BdFNxalRTWGM3?=
 =?utf-8?B?Q1A4M29aOEljMkNiamVQdzR4bEhOSTlaQjI2S1Y3RkNjZ2N4RHRvZFBhZGZY?=
 =?utf-8?B?Um1BeVNSakFvVEtQblJZWm15eVFlOXNDQ05DamNsbU5ESHhLVzczbTZZNnNK?=
 =?utf-8?B?SE94cWx4NkRsQjJOTTR5TVFncTcrTDBxTlJrZjZtbjA0aUZ2cnVyYU05YnFV?=
 =?utf-8?B?R2k4bFhoN3cwU1M0dEF0Ukt1TGIrLzhBcnFiVFlHVWo2ei9aUVJVeEFSTjM5?=
 =?utf-8?B?ZGFTNFJhSVpDVmlFMFJBaUhmeWxZSnorQTdaRC9wRTArUWFaU0ZkWUs2anB2?=
 =?utf-8?B?Qm80Yk5OSmtheFN2K0kwNGxVbVpmaW5STzZObUxmTzVQeWNyanJsaE5UdHBp?=
 =?utf-8?B?OUw4dkt0dkk5WTVsUTcyV0pCQTRqYkdFbHliaDFRZitFVGpWLyt2WURZTVAy?=
 =?utf-8?B?VXQ0bkVYbExHc3k4RmtnNy9TYktSWlcyNlNuVXVRNUwxcngrQTRBRmNDeHNN?=
 =?utf-8?B?VFFZKzQ0akh4YnlycmI0VUFzUEVldHZnV2R5bjFXVE81elNUNDQ4eVNDWTdk?=
 =?utf-8?B?dHB0YXlpZnkvanlWQWlyQ1NUbUdjSEVqWThRdmcvUFpoT3pnSktyVWRxaHNV?=
 =?utf-8?B?YitjVk5JUEtFdzJzZjBtTmtUeWRlakhKOVp5L29CK0YzV2JaVHdLdFIzK1oy?=
 =?utf-8?B?VmVzcEhJeVZrME0rN3lYOE54QTFlQnhvWWMvSTE5SjcwZ1VOVjM5akFSNmdG?=
 =?utf-8?B?bVpNd1FqY2E0bVlLRkpINEt0SVM4dHZQNFM1U3FCbjBDNGkwSE10MEwwSEJy?=
 =?utf-8?B?VFRzMkI3bXV6eXgwVWhIQi9KNGI4b29kN2w4VW9IeENkUDF2VUd4Z1dTenVi?=
 =?utf-8?B?QThwVml0cHA5S2NLYXM5MjJncTNiQWdzblZoZzM0OGVYMVYrb1FWMmhKZGIv?=
 =?utf-8?B?Ukh4QzBpeUtyMThBV1lSQzFOK3dkV0FMYjFyejZPWG9nZEFTN3FBbnlrMnlr?=
 =?utf-8?B?RVpBeFpsL1N1YVd6RURzKzhJWHRlREx1Z0pRTjg5YjdteENrbkc3Uy9sVnpx?=
 =?utf-8?B?NituRkZWc0VzTG5FZ1g5OURPVStiOUlsSVRLa2w2MjV0TTVWUEFrSjYxMDRs?=
 =?utf-8?B?aUIwaGdHSFBPWFRWN0JMdzBsTkUxYUhtRlo1TUxUY29HZTNYSHcrc2RWT3Bj?=
 =?utf-8?B?Z1RzRUFUY1NTMEpjUjZwVFR5UkZyUytCS0tjQTViRmQ5V1V0eTBGUUsydnh4?=
 =?utf-8?B?ZjBRUDVXeW1aRk5Za2NOR0J5WTlId1o2aGhUMTRjb3VNTUJCREhxWWsvKzYv?=
 =?utf-8?B?ZE5sVzhSSDFpc3gzT1pZakpFZy9DN05oZWlHUmtMQWJoZSt4TWYyNmtvWTUv?=
 =?utf-8?B?anAxWGg5YXhYYTBDZS8wT2VGcWg3UGhLWWZzaVRRQks0OXk2TUI5T1FKS0tv?=
 =?utf-8?B?YjJSa2FaOUVRNHlEWk5aRmtOTTZPVXhnYW9JVTFtYXluK2ZySnFHbzhVYW5J?=
 =?utf-8?B?Q0ZPQUZLTHRUckpHaFBCblR3THFpVitLeVBISUpoOXMvRFhOSXBpaHVUWW40?=
 =?utf-8?B?SXk4dVhGNDRxQkJRWTZiVmJIYWZ6K1BYdlgwQTl6ZDhiN01TQjIzYS8rbXRZ?=
 =?utf-8?Q?ZBfMjCSF/9lwpf7FSDa2XIsbg?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e7b786-1069-4314-cfda-08dd8c6c6745
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 07:05:37.4718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehmbZuOcLln5d7cemm+nNJIm5C5EUzUiHMUZ//NxttP7weXxPIHD2nQucnncD6k94uITvhJH6j6+FpTsig7zDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1609
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

Hi Martin,

Am 29.01.25 um 16:25 schrieb Martin Schwan:
> Add a bootmeth driver which supports booting A/B system with RAUC as
> their update client.
> 
> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
> ---
>   boot/Kconfig         |  11 ++
>   boot/Makefile        |   1 +
>   boot/bootmeth_rauc.c | 408 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 420 insertions(+)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 20935a269c60dad53ce11ac7e58247dc23cf617e..966573d8eb7675d36f299c8c2fa6509bac147cae 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -782,6 +782,17 @@ config EXPO
>   	  The expo can be presented in graphics form using a vidconsole, or in
>   	  text form on a serial console.
>   
> +config BOOTMETH_RAUC
> +	bool "Bootdev support for RAUC A/B systems"
> +	default y if BOOTSTD_FULL
> +	depends on CMDLINE
> +	select BOOTMETH_GLOBAL
> +	select HUSH_PARSER
> +	help
> +	  Enables support for booting RAUC A/B systems from MMC devices. This
> +	  makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
> +	  respective boot partitions, describing how to boot the distro.
> +
>   config BOOTMETH_SANDBOX
>   	def_bool y
>   	depends on SANDBOX
> diff --git a/boot/Makefile b/boot/Makefile
> index c2753de8163cf59b1abdc01149a856e2847960e6..427898449a8727747137ab1c7c571c473148c8c3 100644
> --- a/boot/Makefile
> +++ b/boot/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
> +obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>   obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..fcb7e8df4556710b160349f1dcc54cdda9b59c9d
> --- /dev/null
> +++ b/boot/bootmeth_rauc.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Bootmethod for distro boot with RAUC
> + *
> + * Copyright 2025 PHYTEC Messtechnik GmbH
> + * Written by Martin Schwan <m.schwan@phytec.de>
> + */
> +
> +#define LOG_CATEGORY UCLASS_BOOTSTD
> +#define LOG_DEBUG
> +
> +#include <asm/cache.h>
> +#include <blk.h>
> +#include <bootflow.h>
> +#include <bootmeth.h>
> +#include <bootstd.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <fs.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <string.h>
> +
> +static const char * const script_names[] = { "boot.scr.uimg", "boot.scr", NULL };
> +static const char * const rauc_files[] = { "/usr/bin/rauc", "/etc/rauc/system.conf", NULL };
> +
> +/**
> + * struct distro_rauc_slot - Slot information
> + *
> + * @name	The slot name
> + * @left	The number of boot tries left
> + * @boot_part	The boot partition number on disk
> + * @root_part	The boot partition number on disk
> + */
> +struct distro_rauc_slot {
> +	char *name;
> +	ulong left;
> +	int boot_part;
> +	int root_part;
> +};
> +
> +/**
> + * struct distro_rauc_priv - Private data
> + *
> + * @slots	All slots of the device in default order
> + * @boot_order	The current boot order string containing the active slot names
> + */
> +struct distro_rauc_priv {
> +	struct distro_rauc_slot *slots;
> +	char *boot_order;
> +};
> +
> +static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
> +{
> +	/* This distro only works on whole MMC devices, as multiple partitions
> +	 * are needed for an A/B system. */
> +	if (bootflow_iter_check_mmc(iter))
> +		return log_msg_ret("mmc", -EOPNOTSUPP);
> +	if (iter->part != 0)
> +		return log_msg_ret("part", -EOPNOTSUPP);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_scan_boot_part(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	int exists;
> +	int i;
> +	int j;
> +	int ret;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (!desc)
> +		return log_msg_ret("desc", -ENOMEM);
> +
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots || !priv->boot_order)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	for (i = 0; priv->slots[i].name != NULL; i++) {
> +		exists = 0;
> +		for (j = 0; script_names[j] != NULL; j++) {
> +			ret = fs_set_blk_dev_with_part(desc, priv->slots[i].boot_part);
> +			if (ret)
> +				return log_msg_ret("blk", ret);
> +			exists |= fs_exists(script_names[j]);
> +		}
> +		if (!exists)
> +			return log_msg_ret("fs", -ENOENT);
> +	}
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_scan_root_part(struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	int exists;
> +	int i;
> +	int j;
> +	int ret;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (!desc)
> +		return log_msg_ret("desc", -ENOMEM);
> +
> +	priv = bflow->bootmeth_priv;
> +	if (!priv || !priv->slots || !priv->boot_order)
> +		return log_msg_ret("priv", -EINVAL);
> +
> +	for (i = 0; priv->slots[i].name != NULL; i++) {
> +		exists = 0;
> +		for (j = 0; rauc_files[j] != NULL; j++) {
> +			ret = fs_set_blk_dev_with_part(desc,
> +					priv->slots[i].root_part);
> +			if (ret)
> +				return log_msg_ret("set", ret);
> +			if (!fs_exists(rauc_files[j]))
> +				return log_msg_ret("fs", -ENOENT);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct distro_rauc_priv *priv;
> +	int ret;
> +	char *slot;
> +	int i;
> +	char *boot_order;
> +	char *partitions;
> +	const char **partitions_list;
> +	char *slots;
> +	const char **slots_list;
> +	char boot_left[32];
> +	char *parts;
> +	ulong default_tries;
> +
> +	bflow->state = BOOTFLOWST_MEDIA;
> +
> +	priv = malloc(sizeof(struct distro_rauc_priv));
> +	if (!priv)
> +		return log_msg_ret("buf", -ENOMEM);
> +
> +
> +	partitions = env_get("rauc_partitions");
> +	if (!partitions)
> +		return log_msg_ret("env", -ENOENT);
> +	partitions_list = str_to_list(partitions);
> +
> +	slots = env_get("rauc_slots");
> +	if (!slots)
> +		return log_msg_ret("env", -ENOENT);
> +	slots_list = str_to_list(slots);
> +
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order) {
> +		if (env_set("BOOT_ORDER", slots))
> +			return log_msg_ret("env", -EPERM);
> +	}
> +	priv->boot_order = strdup(boot_order);
> +
> +	default_tries = env_get_ulong("rauc_slot_default_tries", 10, 3);
> +	for (i = 0; slots_list[i] != NULL; i++) {
> +		sprintf(boot_left, "BOOT_%s_LEFT", slots_list[i]);
> +		if (!env_get(boot_left))
> +			env_set_ulong(boot_left, default_tries);
> +	}
> +
> +	for (i = 0; slots_list[i] != NULL && partitions_list[i] != NULL; i++);
> +	priv->slots = malloc((i + 1) * sizeof(struct distro_rauc_slot));
> +	if (!priv->slots)
> +		return log_msg_ret("priv", -ENOMEM);
> +	for (i = 0; slots_list[i] != NULL && partitions_list[i] != NULL; i++) {
> +		priv->slots[i].name = strdup(slots_list[i]);
> +		sprintf(boot_left, "BOOT_%s_LEFT", slot);
> +		priv->slots[i].left = env_get_ulong(boot_left, 10, default_tries);
> +		parts = strdup(partitions_list[i]);
> +		priv->slots[i].boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		priv->slots[i].root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
> +		free(parts);
> +		parts = NULL;
> +	}
> +	priv->slots[i].name = NULL;
> +	priv->slots[i].left = 0;
> +	priv->slots[i].boot_part = 0;
> +	priv->slots[i].root_part = 0;
> +
> +	bflow->bootmeth_priv = priv;
> +	bflow->state = BOOTFLOWST_FS;
> +
> +	ret = distro_rauc_scan_boot_part(bflow);
> +	if (ret < 0)
> +		goto free_priv;
> +	ret = distro_rauc_scan_root_part(bflow);
> +	if (ret < 0)
> +		goto free_priv;
> +
> +	bflow->state = BOOTFLOWST_READY;
> +
> +	return 0;
> +
> +free_priv:
> +	for (i = 0; priv->slots[i].name != NULL; i++)
> +		free(priv->slots[i].name);
> +	free(priv->slots);
> +	free(priv);
> +	bflow->bootmeth_priv = NULL;
> +	return ret;
> +}
> +
> +static int distro_rauc_read_file(struct udevice *dev, struct bootflow *bflow,
> +				 const char *file_path, ulong addr,
> +				 enum bootflow_img_t type, ulong *sizep)
> +{
> +	/* Reading individual files is not supported since we only operate on
> +	 * whole MMC devices (because we require multiple partitions)
> +	 */
> +	return log_msg_ret("Unsupported", -ENOSYS);
> +}
> +
> +static int distro_rauc_load_boot_script(struct bootflow *bflow, const char *slot)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	const char *prefix = "/";
> +	int ret;
> +	int i;
> +
> +	if (!slot)
> +		return log_msg_ret("slot", -EINVAL);
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	priv = bflow->bootmeth_priv;
> +
> +	bflow->part = 0;
> +	for (i = 0; priv->slots[i].name != NULL; i++) {
> +		if (strcmp(priv->slots[i].name, slot) == 0) {
> +			bflow->part = priv->slots[i].boot_part;
> +			break;
> +		}
> +	}
> +	if (!bflow->part)
> +		return log_msg_ret("part", -ENOENT);
> +
> +	ret = bootmeth_setup_fs(bflow, desc);
> +	if (ret)
> +		return log_msg_ret("set", ret);
> +
> +	for (i = 0; script_names[i] != NULL; i++) {
> +		if (!bootmeth_try_file(bflow, desc, prefix, script_names[i]))
> +			break;
> +	}
> +	if (bflow->state != BOOTFLOWST_FILE)
> +		return log_msg_ret("file", -ENOENT);
> +
> +	bflow->subdir = strdup(prefix);
> +
> +	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
> +				  (enum bootflow_img_t)IH_TYPE_SCRIPT);
> +	if (ret)
> +		return log_msg_ret("read", ret);
> +
> +	return 0;
> +}
> +
> +static int decrement_slot_tries(const char *slot)
> +{
> +	ulong tries;
> +	char boot_left[32];
> +
> +	sprintf(boot_left, "BOOT_%s_LEFT", slot);
> +	tries = env_get_ulong(boot_left, 10, ULONG_MAX);
> +	if (tries == ULONG_MAX)
> +		return log_msg_ret("env", -ENOENT);
> +	if (tries <= 0)
> +		return 0;
> +
> +	return env_set_ulong(boot_left, tries - 1);
> +}
> +
> +static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
> +{
> +	struct blk_desc *desc;
> +	struct distro_rauc_priv *priv;
> +	char *boot_order;
> +	const char **boot_order_list;
> +	const char *active_slot;
> +	char raucargs[32];
> +	ulong addr;
> +	int ret = 0;
> +	int i;
> +
> +	desc = dev_get_uclass_plat(bflow->blk);
> +	if (desc->uclass_id != UCLASS_MMC)
> +		return log_msg_ret("blk", -EINVAL);
> +	priv = bflow->bootmeth_priv;
> +
> +	/* RAUC variables */
> +	boot_order = env_get("BOOT_ORDER");
> +	if (!boot_order)
> +		return log_msg_ret("env", -ENOENT);
> +	boot_order_list = str_to_list(boot_order);
> +
> +	/* Device info variables */
> +	ret = env_set("devtype", blk_get_devtype(bflow->blk));
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	ret = env_set_hex("devnum", desc->devnum);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* Kernel command line arguments */
> +	active_slot = strdup(boot_order_list[0]);
> +	if (!active_slot)
> +		return log_msg_ret("env", -ENOENT);
> +	sprintf(raucargs, "rauc.slot=%s", active_slot);
> +	ret = env_set("raucargs", raucargs);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	/* TODO: If active_slot is in boot_order, but has 0 tries left, remove
> +	 * it from boot_order. Then, set active_slot to other, if available.
> +	 */
> +
> +	/* Partition info variables */
> +	for (i = 0; priv->slots[i].name != NULL; i++) {
> +		if (strcmp(priv->slots[i].name, active_slot) == 0) {
> +			ret = env_set_hex("mmcroot", priv->slots[i].root_part);

The 'mmcroot' description is missing in your docs patch. You might also 
consider renaming it to something more descriptive, like mmc_root_part.

Do we really want to use env_set_hex for it?

Regards,
Wadim

> +			if (ret)
> +				return log_msg_ret("env", ret);
> +			break;
> +		}
> +	}
> +
> +	/* Load distro boot script */
> +	ret = distro_rauc_load_boot_script(bflow, active_slot);
> +	if (ret)
> +		return log_msg_ret("load", ret);
> +	ret = env_set_hex("distro_bootpart", bflow->part);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	ret = decrement_slot_tries(active_slot);
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +	ret = env_save();
> +	if (ret)
> +		return log_msg_ret("env", ret);
> +
> +	log_debug("devtype: %s\n", env_get("devtype"));
> +	log_debug("devnum: %s\n", env_get("devnum"));
> +	log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
> +	log_debug("mmcroot: %s\n", env_get("mmcroot"));
> +	log_debug("raucargs: %s\n", env_get("raucargs"));
> +	log_debug("rauc_slots: %s\n", env_get("rauc_slots"));
> +	log_debug("rauc_partitions: %s\n", env_get("rauc_partitions"));
> +	log_debug("rauc_slot_default_tries: %s\n", env_get("rauc_slot_default_tries"));
> +	log_debug("BOOT_ORDER: %s\n", env_get("BOOT_ORDER"));
> +	for (i = 0; priv->slots[i].name != NULL; i++) {
> +		log_debug("BOOT_%s_LEFT: %ld\n", priv->slots[i].name,
> +			  priv->slots[i].left);
> +	}
> +
> +	/* Run distro boot script */
> +	addr = map_to_sysmem(bflow->buf);
> +	ret = cmd_source_script(addr, NULL, NULL);
> +	if (ret)
> +		return log_msg_ret("boot", ret);
> +
> +	return 0;
> +}
> +
> +static int distro_rauc_bootmeth_bind(struct udevice *dev)
> +{
> +	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
> +
> +	plat->desc = "RAUC distro boot from MMC";
> +	plat->flags = BOOTMETHF_ANY_PART;
> +
> +	return 0;
> +}
> +
> +static struct bootmeth_ops distro_rauc_bootmeth_ops = {
> +	.check		= distro_rauc_check,
> +	.read_bootflow	= distro_rauc_read_bootflow,
> +	.read_file	= distro_rauc_read_file,
> +	.boot		= distro_rauc_boot,
> +};
> +
> +static const struct udevice_id distro_rauc_bootmeth_ids[] = {
> +	{ .compatible = "u-boot,distro-rauc" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(bootmeth_rauc) = {
> +	.name		= "bootmeth_rauc",
> +	.id		= UCLASS_BOOTMETH,
> +	.of_match	= distro_rauc_bootmeth_ids,
> +	.ops		= &distro_rauc_bootmeth_ops,
> +	.bind		= distro_rauc_bootmeth_bind,
> +};
> 

