Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D30EDA693
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 16:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9106F839DF;
	Tue,  3 Mar 2026 17:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VcvaaE/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73A5083F2D; Tue,  3 Mar 2026 17:15:32 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDCA838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 17:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zINoUSfJw7gFVPUsu6BJiOr0fLAG1BVuzMUxz56KSw+jcmWWAIbanzNHSCh8CpEgEjVXrYkHi5hs1T+UyCidHq1nIFnQsMDNuxLsKfzQ51tYbAgihayS3SYP2CS6nD/PCP/oDN3cghZr3WuCsYaixd1iwtHxJy5jfD6rI4zD6geE3YWagMEQdWxqanZ4E5vzCHR4qBOORbjICYcDiqQqu8Y69SUaJiAkVG5p98+dduoXxPalFByLVGunvCO0I/BW9bVSeFCCqLl6Glt9C1nJK9m/ovb0bGB8l6tdK1KCOdL08LCOh3rAW3clMSS2XrrW5rZijMkMR0MLkwEX0S4uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1ZcCobJw/fSjO2z5LGpUknoi6dRV32LtmbkKCZV3tU=;
 b=cGBRLd9LzaM4kzBnzhJctYd9u/yRuxFVMrJCDgSf448wXkqRn7HO+mhrseDyDmlF+/E3YsTldCL6jv9aohB571WX55wdsTtZSq4SfEseuQZd9WW/F0KeIbSUAhOa8yOAw+OrLvTXUU15/wySndw38X1b2WIAOjbrRShNxPHxiFQf7hWCBDqNBp3JiU5TuGEtFGrofEqnYI2sM+X3I4v3Hb8xtu1dT5aYWGGGDHTVyLJ88TkVYyy1NiW+I+O3QXcl1vW5s6t+tvKt5aJAkfxZS5jxubF3eGN1KoTHaM3pIEoeNlNKfb+MgGDm+XyP8AQZCKgLPYxAz3bZwB+Ch8NEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1ZcCobJw/fSjO2z5LGpUknoi6dRV32LtmbkKCZV3tU=;
 b=VcvaaE/N562oFy4JN4wA7BMt6mGlwhPud0piFmaeD29xa1IXjZeqCua4XibWgyZHx1ZK33uxCZujCMu8cS8FaU5kcxlcODDcm7iUOidjNKaeTPUaAciafi911KJzTczUdctd9RRErZzEIQF1j6fzckQZn7OHt2biFCgzn4gCtEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB11993.eurprd04.prod.outlook.com (2603:10a6:20b:701::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 16:15:26 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 16:15:26 +0000
Message-ID: <fabec198-7034-4fdc-bc02-5658477c7591@cherry.de>
Date: Tue, 3 Mar 2026 17:15:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] binman: test: Organise test files into
 subdirectories
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Moteen Shah <m-shah@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB11993:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b7beb8-4628-4d6c-31e2-08de794014ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: 8/FwifVoOiVW0frmfcmpdcZJ5vmnGilB/BfBlIbnRxT6f2qOd7ukKWwciH1X+t0Xf0AKvr/x0EA91qLCkZ2DjIwth7SzDsKoq8ZhzndjNMN7CPu7nHn5JUpdW1f3GLWSZn1T9v1r46z0WJToXuabh7nps8XmJjYmTcm3WzrPI0bvhVCoXn9sDHVO6XkzyYjjcKJSyEcIGCHiDzGhz1r8u1A6t8gD7aLEHiMxLPrkaQdaxsxlUJdOatVQV3tt36tP9RSfPiqYg17buIa9AL1c28KgW+fbgG97bB4l0UH7QfGXMGKcqBg4FmY78cssIDqRSDlDUGXdtovEKmT0xrx2BuzqlFiqkIBBEOJZXe/cnfqxy3OK4vx+J5nKZXX6ozwtcPejKipQZ8Z1ZOgROHFNjRUo5WspeTmWuwliiyll7KUj6ShSeblsKIcQ9md9zKr9ZVsKLzcFYKWXTuQDJZnKyg40WMuaTBDHe3gqpRWj+ZmomJC9iPa8l94plJwRnp62N/olrTd+ZCUhBJ8YkxvS12DixU8waI1r5NWjlSyN38nCs729jaWqZbR7jtQDyVpXpAJyrPj+Qzu4qRs9Nn1jnYPD/aePk56NbVAlCJCIRVN/VGsGvZyXQKJCnS9Gyq2uiQrUP5RWL1X2KmcmBOR5u0Q695JMT11WALLPm2+qUOB/ooHiE6b2ap8n7IE+Ci1IOpIobk7fwLfJcrz4XBl0XstEsBkLwAjr47V/QaHmPwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBJb2t5TnFma1RMV21CWmg1TEJhUzU2WjdPN1Q4NWNrZmhzQnVvS3BmN1ds?=
 =?utf-8?B?a0M0OXczMXByU1E2eHNMVzhJaHRQbjBJdE1JYmRoR25BREtORjFUa0QwVWpW?=
 =?utf-8?B?Qnd3U2M3OEJyOXBBZ25MRUxxVXVMVTUyakUwOUwvVTNZNWhudmRpQnNoM2tE?=
 =?utf-8?B?Q3hsNU9SZHRKck5jengzNWdJdmpUemY0Z2ZVNUVrZU8vRG9JZlZYYktYTGpx?=
 =?utf-8?B?WmxIMlNjQ3N3RHgxZzNlNWI0VXl3dENrWllVeUh3VDh2bnVCTmFGdEFic1V5?=
 =?utf-8?B?VmlpWm9Kalcra2VIMURiN1hQTFdGbHZYbmw0eHZzSjlkUmVmdlpaL0ZEcmU4?=
 =?utf-8?B?d09GVFRwazFzYlpCT3llY0Q2a2tQMi9GbTNVMmtvWjNCMk8rUUo4UnpIcEJp?=
 =?utf-8?B?bVdBWnJ0Y0JzVlJSejRtOUdGU3AzRm0rdkRPRWFoNXAzSWpVU2xwaS9CUEFI?=
 =?utf-8?B?dHJldEY4bHFBTGpNaEc0TkpuZzlCY3I1M0pFODhjMWRoS2lVTU1ab2ZJSDVM?=
 =?utf-8?B?TWJCM1djS3Z0ckRFYm9RdGdiVDhoN0gvSW9zbm83UkI5V1lpMEl1S01WUkk4?=
 =?utf-8?B?azc2cUVhUmc3YVhqZXF1ek1LWWIyWWhUd21TT0FLTzdJNUpMb2VlUzc3cEhp?=
 =?utf-8?B?ck9nbUZDYmZIRm53T2NmN2JXYzZGTThRbUxlcTVvV1Z0Y2xlQm90SE0wV2RZ?=
 =?utf-8?B?SU1NT2EvMG0xVXVZRzYrZ3pNZkZGQ0JnMFlGcEdtNkxVdmNVeGI1ZHpSSEZX?=
 =?utf-8?B?aENnc1JGM2VVaXFJbG5oNGJBYjdvOWZCREI2VHlTOHBVb0VtcElmWjd6OHh2?=
 =?utf-8?B?cHNIU0xlRGNyZlg0YlMyNGlkeHZjZVA1alQrWEdJVmdBY2xaUWtaK0RwR3A5?=
 =?utf-8?B?V1p0aTdSbzliemVLMTl5MXBvM09YU0g3d0lWZEU4Mm8xcUluRG9hYytVZFZ6?=
 =?utf-8?B?bzl1RkY2dE5hWDllbGFQMlFXRGVZSmdrVEsrTjdOa0tGUGFzNnNQdEhBdUYr?=
 =?utf-8?B?Ym9IME5pR1BFdnVMUUxXSk1qTGRVZzFZa3NKRTJmRXdFU1ZFVVFxS2drWUFD?=
 =?utf-8?B?WitJQVlsNmtyRjdnNk1sSzNSQm00RjlncUpscVgrT2JZb3dJTGIwNXgxTk81?=
 =?utf-8?B?d1VtTWc0RFNZSks0cUxFTzNIaFJCR3JmelVEYldaQ0RHZnVEUjVqN29rdit1?=
 =?utf-8?B?U2ZFNitXTjhvNjZNTFBMWW9ueVlPaExDL05wcEhsV0trOGNaSEprNVd3dUZX?=
 =?utf-8?B?a011K2lVdjVzd0NLbm43aC84OW91eTUyQ0xkM0RsTFU3NUZ3dzV1VEVnTGRQ?=
 =?utf-8?B?cDk5K2x5VzlteXdWeWJzb1FPSXpQcTlDWk9hazV3T3JnS3daQUJZOUxGNUVF?=
 =?utf-8?B?NDhYbmMrVjVZYnJhTElRbHlqQ3NpN09sdGZPOGdBVnpwK2ZJb3dSdnpBb3hr?=
 =?utf-8?B?aFJrckNhQTRIak9xQUFVODNqMldUSkptaEhWT292UXNpUG5SdEkzcmRPYjEv?=
 =?utf-8?B?NWVCZVBnaUhRUlFhZ3RRV3MveHdHeEpJNjQ1RGJnS0RwQmhmcUJiMEJ1WXBw?=
 =?utf-8?B?bEVGazRrbjd5b1FFbnh1djYxbm5SOVhZVHJER1Uyamo3RFdCdEtFTCtHTjR1?=
 =?utf-8?B?dW92WUI3bTZzc3YrMTUvT0IvWVFjNGdtVHIxSk5TOE9nVFpyaENya20vV2Yz?=
 =?utf-8?B?U2J0YStvVzN3NExGOXNPNHFtUksvSVpKL01yZ09DS0QwMk9tZW9rRStrTEZ0?=
 =?utf-8?B?Ri95WHZ6a25pOXpKTCtUNm92STVWQklEOHRlNUlPWnJWeDhOYkoxNmx1Ly9M?=
 =?utf-8?B?TGJkNXM5bmVkRVNOYjhsLy9OdFY5OXU3RDhNdXNMcW9VbWtPcDg2YmRnRHBZ?=
 =?utf-8?B?ZnpaSDg0VWxyYTNGSitBUTdNZVQydVo0Y2ZXa0Z4Z1U1dnZwVFY2d3M1WCtv?=
 =?utf-8?B?a1l3bkpQU05jVEZ6T2Q4Z2hzOFkzMFBlUFFuZWt0UC91Z09XRWttSTFkVHhh?=
 =?utf-8?B?RG9UMkZ5ZmFGWHNaUG1CODBlbU1kNjN4aDNIWlI4NnUxL2JpMW1Fb2dUUncr?=
 =?utf-8?B?ek9EUnpReFRIZE5PQzlHUmxab3hjd05kUEt1M1BXeWZvTS9UWHpEYUR4amdq?=
 =?utf-8?B?ZmlVa2FnZkhDdXVHWmNQbWx4bVFNMjVKazF4M3FINnZ2aktYZzREYm83ZVV1?=
 =?utf-8?B?cHd0MFZOQzZySDdidUFJT0FsN1RxbzExSTd0c3RXWlZSQVRvQ1BGaFk3Znc1?=
 =?utf-8?B?WjJ0U2xwMExrRmhGSERueFU5WEY4dTgxUzNDT2p3WDZ2SUEvaXVmWW5MQ2pa?=
 =?utf-8?B?UTJ3STJTWDIzVjFiOFJpcE5nZ0hSRG16eTVaaHBPa29hemNaREZHUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b7beb8-4628-4d6c-31e2-08de794014ad
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:15:26.6139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY+p1+HWT+rKZEV0ZkODD44nYGxBE2ULWlA/p5QjSaaoyX8gMxJBhoCiocb72tfTBAmOvsZR+JQoHq+8KASmbP/bMPlbN4TthKbm/vg6qTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11993
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

Hi Simon,

Thanks for doing that :)

As a general remark, I would suggest to remove the dependency from this 
series on 
https://lore.kernel.org/u-boot/20260225225040.2568118-1-sjg@chromium.org/.

That is:

- remove patch 1 and 2 from the linked series,
- squash changes made in this series to tests added in the linked series 
(patch 4),
- maybe something else I missed,

If the series cannot be applied independently even with this done, I 
would suggest to invert the dependencies such that this is the base.

I'm assuming this series here doesn't need too many eyes, but the 
imx8/cst changes should be thoroughly checked and there's no need to 
postpone merging this series here I believe, especially since we're 
about to have tests for UEFI capsule and may receive other tests in the 
future.

Cheers,
Quentin
