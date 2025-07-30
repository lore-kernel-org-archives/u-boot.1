Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B411C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 14:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7914E801DD;
	Wed, 30 Jul 2025 16:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LihHWxIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F609803CC; Wed, 30 Jul 2025 16:32:07 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59720801BE
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 16:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD9ZUxPj0IDILDxydoXFHZbOluvllX6vpfyVZknkkYU1K+Nd8UxBt1dogeCk5jOn49LmXjBTbNC3ArGP4yhVaHYMxAkUfpRSvg8++WxFx8TYzFIxRZg9HqNmUgyPYmLNWiBBHIybljyncGSahCHi+XO5r29KxMDVhGHUtYnxgeTO8bgki+9seEoRckV32+Mx/KRdesHGRKLAAyCdFDxHOGfC3opXCJpfwKCrjvyjuH0iQL0cLtX6Q/yIY6YmbUPLW+Gw5dJHLJlLsr0lZydR5a+8W9Z4pmBsd1c/l+FDijI+nMA4CDgRgOXaStzic4EH91bbTM+47bFPsSDs7z426w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h6PMBto+OXIeibgc0NjI7WFC28QsqdJXbjgFpWsZvE=;
 b=OCnuYgIRi6KHXwY5TJI3D5U4kHNstOZ2/eR080X2KTU8GqTxgiMLWD1whjKoOt0j4oqicT9QODC9LWS3XOvoZytV5DFPHbs3m5UxRPPZ/s4Rv7QfT768qkwKkLJJARafyZWVlMPgo/6A+q6tGxdrJB+fXWyUG48QQMl97Ir1jDOnejUlkGDMCPRY4uZkdy+d0K1VYF2IyQNPP9wbZXybb2Yx2onROo7JEGsxV+s37pO+SoLWT5gGDCuGA7idhSuZcHyxJS4kPMOBf7SsbQdTA/XAT8l4QTEZM0qeQPTuDZb7rjFcZ3Gl7UfjJmeUHi7PbHMaGG78Xr5HL5+jPUJFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h6PMBto+OXIeibgc0NjI7WFC28QsqdJXbjgFpWsZvE=;
 b=LihHWxIuaO/oLttlPtzLgWU9OPoJS9NgdfaR4z2xGlvOP9pP+uGfzzFY1fA3coKnbRvGVFTnlJx48aFVFuZWeW8fHCiLZohba79Q1RqwhtsuzomwMnm/f0Tw3sTRQD7+NQLACzl8mYcMvKvNNjCSAVi/UaxrF6LLJoyFKOFTQ1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 14:32:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 14:32:02 +0000
Message-ID: <51ed7038-1069-40ed-b572-21e179e650d8@cherry.de>
Date: Wed, 30 Jul 2025 16:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] rockchip: Fix misc USB PHY related issues
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250721220734.1617117-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa05b59-4273-4d47-ad2d-08ddcf75d93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akxxZlIxK2R5T3FoL0pDVko3MllDRWorQnp3WlZtKzIwdUZKL085RW5ZYVRH?=
 =?utf-8?B?dk5ERG9uanBFcDNLVmo1N2dRVVpXaFZhNE1KdlVmdlFOWjgyeThsaXJ4SjJv?=
 =?utf-8?B?WEh6Zlp1QTd1OE5wR2VzY3pNQ2JtQUxWcnNnNjdTUjNObXczWUxmNGJ2NVBN?=
 =?utf-8?B?OEtNTDRQOXNDN2pLNklqNWk0R0ZmdmZrdVoydENhTmc4Uld4ejZGYU02R1k3?=
 =?utf-8?B?U1o3MXkvelcvblZTUkxLRTdWaUxBdkNkSjErWjNTY2N1YVRtYksvc0dQV1Qx?=
 =?utf-8?B?TXZsS0E0aWJJYTV1VEczbFFkK1E1eitTMjRVRGY3UU11WjgrTFV5K3ZNckNo?=
 =?utf-8?B?WDJWMmhYa2RlUWtXQy82emZzZnpHZ1N1bXorOENIR1BQazRtcVNHZXZXTTZU?=
 =?utf-8?B?aEZFVFpjMzFhM0g1c1JOL1FWSTVLQTA1djB1QVBMamZid21QdndTZDlmL05j?=
 =?utf-8?B?VG9WbU41NTlyTklaVk05QzlIWFNEUDE3bTFrMnFKUWt0ZXBFSUN3NXRseUt0?=
 =?utf-8?B?K0dnL25CU2tsWkxMSG52aEt2b1J4YVA5azNLaGhJaGo5ejBGbWppNUZCT2I4?=
 =?utf-8?B?TmlXbnZxRU1HYzJRY2IvZnRhaHZuTkJYR0Rmb2d1c3ZndmpCdmozR2RyZFRY?=
 =?utf-8?B?MmttMko2WHhyanBtVDhNaUJDc3FLOWNLUytSTVUzRk5odi9DSzJFRXJXR0JP?=
 =?utf-8?B?T2lHZUFYRHVNc25rTm45Z3U5U2xvVUVGdTNQbDBZbkxtRENrclVUK2lUVTk3?=
 =?utf-8?B?NUM2OVg1ekk2YlNoVU9yb2Y5NVczQ01ZTXcxZFcyWTNQdkN3NEExQ3YzcDdl?=
 =?utf-8?B?bzBBT00rcE40RlhITmloTC9MY0NnYkdDNmlZcFRHR0RuOFkxVGttdEZROUk0?=
 =?utf-8?B?UWl4cGxnWHIwRU4va1F4OU1uWVJ5VmlFelkvUzgyZDgzM1lwZWJvYWpoQUlh?=
 =?utf-8?B?ZnNUZDBudzhrQzl4UHAyMFlIMEhSOVRUVStqZEphYXprZmFsOGdGRFRjQXBo?=
 =?utf-8?B?YWVhQUd6QmVhVmQ1Vmc2aU8rRlZXSFcrc1UzcVBGcnBZT201T1NEaWl1ZlpW?=
 =?utf-8?B?dWJaWmhLRDV4RXhzWkVOVFhQR0dlNGI2UGRMZ1ZqLzBVOHd5QzNLWDkxbEJZ?=
 =?utf-8?B?aWxTVTMrOU9wcURLc0YxSi9LZTJXd1R2ell4VlZkcWlSSVFFalR2OGY5WTlE?=
 =?utf-8?B?aFY1MHFVbnoybEoyL3VWOGkzTy9aMTg5SVUrenNERlVqK1BhZ09Jcnc3L0JM?=
 =?utf-8?B?OENPSHpCWHNISUVtelNieXZUYkNKM1NlWVJ3eGpVSzlWSkZqV1AyK2VlMEhV?=
 =?utf-8?B?eFR6enM5TFloZ01PeGhZQ0IrcG9sZkdwcTV0Z25tV1hwUVBnOWFQdTFvTUxE?=
 =?utf-8?B?M3h6SzU1elM2OWplZ3lTVnZBUXQyV3BnK1VxTVhvZWZjQjRXTm9udHdMWW9n?=
 =?utf-8?B?QzhvbndtbEpOZjdCalJHZ3MvTXN6NHBIR2JVN2FCYTFsQXB6QWJadHEwZk16?=
 =?utf-8?B?T3lHTnlrOUJIdzF5NEVHQXpySWduSUcxMUhGSlJqNHRHZWpNMDhzOTFaKzZB?=
 =?utf-8?B?YnorOW9HZTY2RnJKM2FVZ1pyakNNNXIyTDBnbmZOOURsTWZHVUMrNThyaFRt?=
 =?utf-8?B?M0xUV3d1KzlkVE01Z3hrdkh1ZFhTcVRrK2U4RzgzOTc4bGZITDhOZXNMcnRM?=
 =?utf-8?B?ZmptK2VlT2FpamVMVTI4eGRmeXFtYThKVzBWVlVkY0xETHpJc0NXUGZlVDhs?=
 =?utf-8?B?SjJDaUgydE1COEdUMDRYNkJSOXE1bEdScEtSSEdWT2dzL3Y3SlUvTk1vR2pv?=
 =?utf-8?B?eE56Q2lmbVhYMDcxQkcxVGpveWpHSmk1OW1lbEg0aXZtUjFHbzcrNjM0NHF1?=
 =?utf-8?B?UDc3bW9KQ0FERzBFVWxHdnRGS0JCOU1wNWVXWVNpUnVNQnJscWtBMGtPNXFk?=
 =?utf-8?Q?rI0QJmKRUAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtpNjdxN0F1eVNPcUx2WFUvT0FQbWdmRENCaXY5WE9ZK2dDYXVGVEZuWW5S?=
 =?utf-8?B?OERoYTBRL09SZjVYQVNBcndNcTBDZjlUbjNHQ005eVBGMkNRM3VraEpzaURn?=
 =?utf-8?B?OEYxb21obXBkUW1nS3FBc2VhTmNNaHE5NGkvTVZmQlBrMXFmcmt0OHNNTmRR?=
 =?utf-8?B?STFYdW9JVGZVVDV2OTBVcktsNE1DSzcyUlI5WFZvNGtlTnJmS3pvQVp2WkJx?=
 =?utf-8?B?ek4yNU5BOGc1c1R1cnQ0dXF3UjZEOEVIaE1JZndVZ1Z2SDdzL24rdG00N3hY?=
 =?utf-8?B?MHgxM2NJZEwwR1JjWThFelRtaGZLcWU0OVo2dWNnR0txRWVYN3R3Ujh1ZnhG?=
 =?utf-8?B?Kzh3VkUxQW1xdnloZGVXbHZaTlA1SThXSEV0ODVqdkttb1VQMEtGMU9zdFZq?=
 =?utf-8?B?aC8vQm1NVm5leHNDeWYvYWx5S1M5a0RzMzJyYWJoUG5ROFIzb3lBMDRKKzdv?=
 =?utf-8?B?M2tCWS95ckZGZWVEV3VNV1RQZjYvc2xrY3JsWitmdGI0Yitkd0hqbkVZL3Z4?=
 =?utf-8?B?a1czcEFIeHlPU05wZXdjN2I3ejQ3THhFTWxhN0ZUSTBnWE9TOURiYmFWeGFa?=
 =?utf-8?B?d0oxVlduWG5MMDNLdUR5NDlzNXVxZUR5VDZhZ2lHQy93OUsvYjFaOC9rTVlk?=
 =?utf-8?B?Q2xjQTBpc3B1UjNsblk3VmJEdnp6WTZIYjMzcjlkcFczZDN5MmMrYURBekhz?=
 =?utf-8?B?bHVvM2FLcWJTRXFWOEdKRlp2Rk1ta3NFQ1JKNVQ3ZHpNNDQ4QjE3UklqalRG?=
 =?utf-8?B?MkE2UVREelBGb1crWWFPNUd0WkpOT0tvRE9IcXpJelVQOTNVaFE4aU9OZE8v?=
 =?utf-8?B?dXVHM1FmNm9MbytJeEdSY2tkdUdCOTNnQjlnUDJxbXdweWVZRENNWlZheDBl?=
 =?utf-8?B?MUpoMjByTzRsVUQwNzhWU3VCRCtkL01UYlRUWTZtend3dmpSbTVVU0FpOUV1?=
 =?utf-8?B?VnFRcW9VbVlpTjZSNW5NSS90YndCUE5NeStOY1phSFRYaFpVUVFSelV4bzkz?=
 =?utf-8?B?SkZOZ29zd0dOMHFRNFlTZTJqc0hQUDFURlJVdTBOK0lWNVVnRERsOEZUZGo5?=
 =?utf-8?B?ZWowcCs1bUY3eXZQcVhNSmpEdVUzZVRHK3h0ZGVSc1lKMXFQSHV4S3RTb3JB?=
 =?utf-8?B?MXNCRVNISXNMSjUwSXBVNHJHM0JTVnpXZFhmQXVPb3FIQ0R3WXp2OFpyekJt?=
 =?utf-8?B?TFU3bjlCTmJxZndyWllTdDhSZ2lzV1ZaM2MreFlSRTFnRWduclc3UVpQdzh0?=
 =?utf-8?B?d3RKR3JYZGZvR2VUS2RPeTJBY0dDL1kremM3d0dpdENBWmk4YUxFY2VpM1NR?=
 =?utf-8?B?aDVuTXlnK2gzMTFtVHhsUmhiSGVhWE42b3JiMFZuVkUvQ2JsMkpLdzJNRkhz?=
 =?utf-8?B?eDFCZy9McExhUkJCdEN2UWd6TlZDRy9pSS9xM3pSZGVwMUp2ZEJ1blJpM2tl?=
 =?utf-8?B?YWViU3h3Wis2cHJXL0xVSGp3VmQ2MExKQmw5RTdBbUJIdzlEYTM2R3VnWjFp?=
 =?utf-8?B?WHdXZVNIRU9PRVVPMjlCd1pQNHpBbFc2bVl4ditCTTlLSWlwcWhCaEdiUjY4?=
 =?utf-8?B?N3FURnhSMkEvaGFiWmVmekt6K0EyQVZFMWRjVnJkRVdZc2pLcmRYMWxJWm90?=
 =?utf-8?B?Smx4NDg3WlRNVWg4emJwYWMwc2dPS3R0Q24vY0pVVzg2cWRyeFNLMG1xTElz?=
 =?utf-8?B?MGZTRVA2RnVUUzZyaGxzanZVR2c5NzlJSXM4WTNhb092MldtdnJldGcvbTRP?=
 =?utf-8?B?c2Q3SEM2UUNrOGYwb2tSNUJORXYyOThVVXVCRW1lR3B1R0l2eDVOcWFqeGp3?=
 =?utf-8?B?MlUwTEZsYmlhSldUeUR2eWNXOWhzNnF6YkFxSm5OcW5CRzY3OHhFTVk2QW1Q?=
 =?utf-8?B?WUR6QTJmMDZ2L3BXZlFCN08yd094bWlHOGlHT2lFNFo0VmN1TVZHMVhzMFlZ?=
 =?utf-8?B?TnFlK3lBMlNvZmM4cUlILzROZmFibjA5QWQ0RDNaQlg3aFU4TzdXLy90VUVO?=
 =?utf-8?B?cUsrV2tJOGZodzFCRVBvMkxiSVVTYUMyY0oxaXNnNjdPczE2K0x1ZUNrZW4x?=
 =?utf-8?B?WFVwU2dGWHp6Y2NIMXFxa1M5dndMSkt5dG1mZmxFRkdwZVNQTmZnM2hHRTlo?=
 =?utf-8?B?V2RkQktERmxRS1RIMjd0V2dxVmxFUER3cWlvN3FES3NGRlFWWFFuQlhlSzJ0?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa05b59-4273-4d47-ad2d-08ddcf75d93b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:32:02.1936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tL8uGeYVfhviL4+kt+ciVOdplZ6VN+xVswuMH5AGjUZ0U4P+fCLaOKOx7X7UtXdnqcdJ5YkDoJKiXbpIcFC+r9XDzSAkGtTJ1xRqzBTqCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615
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

Hi Jonas,

On 7/22/25 12:07 AM, Jonas Karlman wrote:
> This series tries to fix a few USB PHY related issues found while
> working on RK3528/RK3576 USB OTG support.
> 
> The first issue is related to Generic PHY reference counting that is not
> working correctly for the usbdp or naneng-combphy drivers. Both drivers
> xlate ops never initialized phy->id so it could initialize with an old
> value from stack when the dwc3-generic driver was probed, causing two
> struct phy to be initialized and ending up not sharing same phy->id,
> resulting in reference counting for init/exit and power on/off not
> working properly.
> 
> The second issue is related to the two inno-usb2 and typec drivers
> improperly used UCLASS_PHY for their glue/wrapper driver. This could
> cause a crash in very specific scenarios, e.g. missing to enable the
> otg/host-port node and only leaving the usb2phy node enabled.
> 
> The last issue is related to supporting using only USB2 PHY for USB OTG
> purpose without having the USB3 PHY initialized, in such scenario the U3
> port needs to be disable, more precisely the usb3otg clock source must
> change to use UTMI clk instead of the default PIPE clk.
> 
> Prior to this series it was the usb3-phy related driver that would
> disable the U3 port in special circumstances, e.g. for DP only mode or
> when limiting to use high-speed as maximum-speed.
> 
> With this series the U3 port instead is disabled early, the USBDP PHY
> driver in both U-Boot and Linux will already enable the U3 port when
> needed so no changes in behavior is really expected for boards.
> 
> Finally, this series also moves usb otg related device tree nodes for
> the Generic RK3588 board from the board u-boot.dtsi to the main board
> dts.
> 

I recently tested 2025.07 on RK3588 Tiger and realized that one of the 
three USB ports isn't actually working.

I get:

"""
=> usb reset
resetting USB...
USB EHCI 1.00
USB OHCI 1.0
USB EHCI 1.00
USB OHCI 1.0
Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
rockchip_udphy phy@fed90000: cmn ana lcpll lock timeout
rockchip_udphy phy@fed90000: failed to init usbdp combophy
rockchip_udphy phy@fed90000: PHY: Failed to init phy@fed90000: -110.
Can't init PHY1
Bus usb@fc400000: probe failed, error -110
Bus usb@fc800000: 2 USB Device(s) found
Bus usb@fc840000: 1 USB Device(s) found
Bus usb@fc880000: 2 USB Device(s) found
Bus usb@fc8c0000: 1 USB Device(s) found
Bus usb@fcd00000: 1 USB Device(s) found
        scanning usb for storage devices... 2 Storage Device(s) found
=>
"""

The port that doesn't work is the one that has USB3 over the usbdp_phy1 
and the USB2 part through u2phy1_otg, both going through usb_host1_xhci 
DWC3 USB controller.

Applying the whole series fixes that, so I guess I can say:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger Haikou

Thanks!
Quentin
