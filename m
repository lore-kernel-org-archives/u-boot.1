Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2103FC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 12:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D3888590;
	Thu, 27 Jun 2024 14:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gSj4UcUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09AFE88591; Thu, 27 Jun 2024 14:27:50 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5F2884FC
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 14:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRG/2nhrRWtEUBtjK/enabn0oiLdsoSOAQtDYHRxIUBxUI7V5kWie+Lsa6i8vT8u7VtiMU6QQ8FxPLKy8EqEeDNhARhMXv8j7Ly80YVwrBbkS/dcrudpNyxpIWhRaGSYRXoIRTe2bfLGuhf1Fp9TMSf4zxEGTAGboMC3EKN/ogHdpfRMFtFh/YMnoAx0BN7xhF8P73IZROhPSphG85Lt4vH0vXJ4LSbM9LZBOc84WabekDlMDoXmGpP1khRYWzwHyzqgPeYdhvSjy2Nwjmx6yFCJptjulkTMn3oCUVaBcI04ARZm2wpvmFlyfmv5kiMo60hAHFk3XhOnuKgXQJ+zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snyy9M57reU8F4kiyZTh4n5iesYKFsnzSabhyuuj400=;
 b=gNLJGdhdnNw9M37v30tySeKbw2ab3RqbWCBJFuY2wVG9ES1JlqDJGOWwZaf64WvtYRYSJCGO9SJ0mIBhf7LW1/N7qWM4sJI7VDYVSMaw2HZ37qspZa/blEmihjE81akrsE4+202O60PJ/nC3hPY6QFgLoy0Y/KPN0ixBqDOLiDWraoRamO9ZvI657xLctkfGaAEfp29BdMN6sIzEW0H562yVmeSntq7jDrphrhrkkoQLWkUzx7/kqdsXqLDrR/Y17NJq9EOT+KhUMaWQlecwIx8tVM6K9UXavtOci2kUlCM9YF7b2dOARdoGr3dM0VdWuHOI+ZMZ7l1j1HnRXdpCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snyy9M57reU8F4kiyZTh4n5iesYKFsnzSabhyuuj400=;
 b=gSj4UcUsl5vF07phrLd99JAa0dqUQlBVbtdl0Fqj0exaWeLiDrawZji7DUOoRXcRrmwTJlU7TPTuCP5KoRXa2P/aDXzmmUyNFDRiaB2p59CC35fhPWWlHHaUbyLcfiixXYQeHMtNjnqFfftAOGr55tm9AZsUbj1Re2aQXUYiq/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM9PR04MB8939.eurprd04.prod.outlook.com (2603:10a6:20b:40a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 12:27:45 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 12:27:45 +0000
Message-ID: <0487e16e-9a4f-4a1d-be80-312a2969d258@cherry.de>
Date: Thu, 27 Jun 2024 14:27:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: give a different name to rtl8169 interfaces
To: =?UTF-8?Q?Etienne_Dubl=C3=A9?= <etienne.duble@imag.fr>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 joe hershberger <joe.hershberger@ni.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@lists.denx.de>
References: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
 <888498a7-0d65-4dd0-907e-0f8eb8a92695@cherry.de>
 <6472908d-548f-483a-8199-6c7233fc0eb9@imag.fr>
 <f8be5725-e8a5-454c-82db-4aaeb293673c@cherry.de>
 <a7dbf00b11304f80cacd5821a5e19127@manjaro.org>
 <273b4022-4192-4df8-ab69-db8d05b091ea@imag.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <273b4022-4192-4df8-ab69-db8d05b091ea@imag.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM9PR04MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: f24e9a1b-14f6-45a6-68fc-08dc96a48c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmMxM2twQWlPRmdZU2hLRzJ3dUtvR2VJT0w1K1BlNVlsSHM2cURKeVpVMUU4?=
 =?utf-8?B?cVZhc2J2UzNTbjZYK1NtQjJwZDBtWmk3ZDFrMmZNSUY3bkxpcWlYUFJkVjkr?=
 =?utf-8?B?VFFaV3FVUE92QzRsOGxmR2FJRUdOak1ybXhhMXVraEVHbDRRSlgwUVZOOEpI?=
 =?utf-8?B?Mkh3YzB0QmRsUVkwVTlVNUErbUxManZmSHVwMjBzdGJqMVBESisyYzhGa2cy?=
 =?utf-8?B?MEp3YmVrV1lEV0d6eWVId1daTVlSazhzZUc0VUplVDIwckg3NTQ5bk9BV2xu?=
 =?utf-8?B?ZURXSnlqSzFxcU9UTzNla0Rna2ExRWN5elpXOEpiUVBBdjJkQnRDTTlCZWdz?=
 =?utf-8?B?UVlVRTJBVWo0UFRNUU9zeDVGUGEvZjAyUHBMWVBLbnpTZy9BTDdBTTFLdHBz?=
 =?utf-8?B?TWdzZEdtV2lVL0YvTnBlUUVyRGVXc0pseGllWXJnNEN0NVJ2N2t3UmFYMWF5?=
 =?utf-8?B?K3BKK2k3S2NrT3BLZ0FwTnlSVjJ6ZjRwN3oxL29vamtjSlJIWGVBUGtsUGZB?=
 =?utf-8?B?Nnk5cHM0U0k4SjBITnhQWmRPeHJoeFVzc3lSODU1YjE5cTZodTFCanQrNVFm?=
 =?utf-8?B?TnBxTnhuTlljbzZrTHNIK0x1ejB0NjF4WkR4b1ZvMnN5ZStmMWsveU82WmNx?=
 =?utf-8?B?MVFCTit5TVlmU0lFYnpRejlBRjFIcVBxVkV5NEpDMmJOTCtJaFdQSC8xak9i?=
 =?utf-8?B?aXF5bEN4dzJBMmM4ZTZnOFdHTlpzOE1UTUFvdTJNSEExTFdpWWZzeFlraEdG?=
 =?utf-8?B?S2xZVmtuQXlLZXVQcFhYNnZUWEEyZFBBQzVoRjI0ajF5dlMybGFHSTBjL2Mv?=
 =?utf-8?B?azNyUE04QldudHVvQTZUS3kweS92NGtta2o5ZTJ1WnpQNlNSOVdDQ29ZNUdi?=
 =?utf-8?B?TlB3ZVpoY1NTR0lNUGxoLzhRak1FU0J1eEs1Ti9md2R3MkN5QjNuY09vcVRK?=
 =?utf-8?B?c0lvcXhHcEl6ZG9zWnh3Z1A0ZGZ4QjlZSmZJUjBVYlBGSEh6Ym9RUlh3SUcy?=
 =?utf-8?B?Y0ZwU2ZZWWhXczN4MmFSWHhQNlZjc2x6anY5aVJ6QXdwUjd1djk4WWRkbUlZ?=
 =?utf-8?B?aUZIZGoxS0R4Wll6WnZkcTJOeFdXemFsaDBmNXY2dVR6dG5NV016Nmd5SEh1?=
 =?utf-8?B?Rkk5UXgvMjJYRy9KUndITG5QQjFVQkRUNXVndGdldUtOT21WYkZodktiQmcr?=
 =?utf-8?B?YlA1RExiWXJ2aFBvMkhvcGxOTVYwYU5sck0rT2hQeDhrKzN3V0oyZGJMUzNt?=
 =?utf-8?B?T3QzbzRIRHVYMFVGek05a2pBZ1VFS3VuQlNxMjBwQzY4N2RXQTF0aFFWRWJ3?=
 =?utf-8?B?Q1h5ZW5pcVFDeUNmMDU4R2hHWWtDYlRzcGRYQnB6L1ppa1VFcG5xSHJxRXBH?=
 =?utf-8?B?WHFPWGM1ejhuVDFLaXlINTlUYStoTlFxWFc0aXkvTzl5UzFjcUZhVnFjWTlE?=
 =?utf-8?B?OGpKNTVFbnY5Y1dESk1ISWFrbHRMTzlhd2JLQTZEV2lrR1pPeEJJQXE0RzFG?=
 =?utf-8?B?VjVmSjhzcHJSc3FLeDhjQVNaL2RTUFQ4VGJYTC8zLy9lNk5VTzRrc0hkL0kx?=
 =?utf-8?B?aVA1SzlNVHNTN0hmbDVnNy9KTVVYaDlrVk1LcjhFU0h2QmxmajVtUXg4MXhG?=
 =?utf-8?B?a2FhM05jbmlCZHRQOUxBK3h6Y0g1TW5ITE5DWEg4K1N3VUMxRWRIU3ZvaEtj?=
 =?utf-8?B?S2dLcXI2UXB5Zk8zenA0VWlSZkZSbEpaMEFkSUhmekNyd1l4NVZtWjF1Zk9O?=
 =?utf-8?B?dWgwMTF0WHZXRFlsRVpYMjFpaHN3V1ltdU1pRHB6ZWVscHN2dHRjeVUvMUVT?=
 =?utf-8?B?eWRUTGh4dXAwZDRqbmZyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dJbWVMaDViSThZK3hEQ2QrOUM0NE5OSXZzeU1KTGpoZlVUVGVSWTJGRldD?=
 =?utf-8?B?Sk92RU53UGYxTXUwOE1zMDBTeHN1TkxxS09RTTJzMmp3djJORitDWGJ5RW5a?=
 =?utf-8?B?b3NHd09uQ2dlNWIrMkFyWU1JU2k1WHhiUjRrNGJIempJM2RGd0dyVmhheGdp?=
 =?utf-8?B?SWZLYTU0RUZKZHNiSEFaVUNaa2JuYXk5aTdGSzRBc0JYLzNabEcyYVlQbnZN?=
 =?utf-8?B?VCtrcnRTT29NYXRPeVBzcUNicjRya1Nyc0tBeUhmakZ0UmlvbzZGL2l1Rk1B?=
 =?utf-8?B?cHJ5TXNzUHVESFVDcnczclhVMjZVazhhaGY4L0xxZzVxSDhYNlZUNnoxN0dR?=
 =?utf-8?B?VGxDR2ZsQTRlREVKNkRKREVlaWNwcW95NnBmV2hUY2lDQXI2VWVKQVRLM3dX?=
 =?utf-8?B?eFZJMjJlQkFlQTVWVU9UTnBXdFRqYzFGTWpCc2xOeS8yZFFYelU4V04ybjBm?=
 =?utf-8?B?RjFIelVRd3NjUjdKd1pNeHlERy9NU1NjN1BGZk9xbVhicHc5cmVtWllrVVZy?=
 =?utf-8?B?amlPSnByTzBCZXhIOGp1dWxOQTRRbUszU1J4MGlxYUh0dmF4YWYzTVM5aVhN?=
 =?utf-8?B?M3RDbUl6eDY3bGZuNmdhSHBuS0l3MUZOQlE4RmR4bUMwWEZHUXdtVTFCRkdq?=
 =?utf-8?B?TjRQc3NXUnF6eDlJNlhzNVU0R0ZSanFlY1Q0S0FqMXJpSGNNbTYyUFZkQkNa?=
 =?utf-8?B?bWxxakxVcUxlTC94cEhZWmovcG9OVWVUTHdBeEorK1g1MnRhSkZRMzN3bS8x?=
 =?utf-8?B?ZXBZZ0I3NmtLaVRGYkNiS0lLSTFzMTltYVdrUjRBZjdEYWNsTDk2MWRXa1kr?=
 =?utf-8?B?bWtFVEFoOVdwbjhXNlY5bTdEZXRyMUl2TjZCc0JXNDV3dFhHUnU4WTBWVXJi?=
 =?utf-8?B?eXVqZ0s1amphQ0xyMlU4bm9YSE9Mc1psTk00WlhDUmtHa1NhSTFHbGRNTXhy?=
 =?utf-8?B?V3VOVThnd3dlcm9RTkdsaisvNWVOaUw1SVRRcm85L1BUbWNTbXZ1Vkg1Y2s0?=
 =?utf-8?B?aHc5T3R0L1JBVUQxUDdRcEZ2QjBPNWRiVnpkWXovc3dNdis2Umg1Rk5TWTdn?=
 =?utf-8?B?STUvcVZrakhLSUluekpQY1N4SXdCRTlsYzV6QURsY2ZCbFZaRjRFZFgzODJO?=
 =?utf-8?B?MlBueCtkRUtkL1VJQ1BBS2xwZFVlMGZQTG00TnpPU0tqOTZKazFhMkpGdlRR?=
 =?utf-8?B?aGs0MUYydFlZc2tQY2Exb3ZYVlFNQkloZTJUK0NtYUJZcXF3eWpKSVp6U2s2?=
 =?utf-8?B?VmNFRWZKaFA1b1lhZk5kS1VUMTZEWVFOWS9tNWl5aVJBajI4MzMydzlKWkxo?=
 =?utf-8?B?YVJjV0pwd1Z2R0ZZMHVzeVhZNm1nT3lDVXFZbTE0TU5QaGFFcVFvaXJEdm0v?=
 =?utf-8?B?MG9vYzVZWW1PSVhxMm9rT1dRNjlUUnpSK0ttZE0vQmRlVWVkUjdiRWlzbFRP?=
 =?utf-8?B?Wk9vMXh3b0J4RXN3SnQraUZJSTRRMTVaMi9aeHpBUXllcDlDZlF5ajhRKzRQ?=
 =?utf-8?B?cHppNS91bzFHV2xZYVN5emdUcndTUjJTeWxheHBjZ1o4NlNJczF1NmcxVEhr?=
 =?utf-8?B?YlVyMkwrSmVzdzN4YnV4QjltaWl5Um96TGtyM2dVa2NxVjE5clpYejd1ZkRS?=
 =?utf-8?B?SEE3VjM5VE96elVQb2Y4MmFvZ0RsYzkybEszV0xiSDhTU0g0ZnlPUjBDdmJZ?=
 =?utf-8?B?bllSdGJtVnp4NzJRU01wdmZVam15bXJyRVAvWW9CWnU2STNhTnMxMVhtZ1FR?=
 =?utf-8?B?MEFOem5HbVNvdWFicUtoQU45dnFDS2R5cGxTdW5TUmlHcFNoL3BVa0haeDQ2?=
 =?utf-8?B?blBFdlI2MkRkQk4xWjFKNEg4Tks1SVg4bit5ZkdxZFlxTDd4TUdlK3Mvdmkr?=
 =?utf-8?B?alpVZDBrQkU2TWd1T3FTMzl3YzZ4b2cramxBSUk5SnNhWHdiS29pSjVPM2k2?=
 =?utf-8?B?UXVqMC84NmFsVGpLSFRSSjhGV25yUXlldDNxcDJWL20xaHBZK2xIbE4yNldQ?=
 =?utf-8?B?WlZsdUVGbHZOcTJXNmtxRUVQUThyenBjNnVWcWdoaGpsNUhBNkt4SVJDcXpN?=
 =?utf-8?B?Q2Vpd1ArNGNHcFR5UzlOZEwzL3NkYkVkN2E4RkVzcVgvRUhnemcrTzI3TFNG?=
 =?utf-8?B?VllwVXdWUkhkVTBUeDlReWdON2NFUUVwTzVtbHJHZ2ZhNlJDWGR5djFoeGRL?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f24e9a1b-14f6-45a6-68fc-08dc96a48c8f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:27:45.8263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKX5VOXTv40hm0P5WLII+fVbUXH6BaSIi7fkuXRtGMeQFVwCRXwRGx3MCZCnxijvbduPWVd/sy8Nh1XDhK1Z4RZE3nHYHCS5w/RnmAOWNT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8939
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

Hi Etienne,

On 6/25/24 1:42 PM, Etienne Dublé wrote:
> 
> Hello,
> 
> Le 25/06/2024 à 12:25, Dragan Simic a écrit :
>>>> Another option may be to name them "rtl8169@<hexa>", with "<hexa>" 
>>>> reflecting the PCI region address (so it is unique and stable). What 
>>>> do you think?
>>>
>>> I guess that's one way, I'm also wondering how systemd renames those
>>> to be unique but stable on the same machine, maybe we could take some
>>> inspiration from them for that?
>>
>> Systemd also allows renaming of network interfaces using some rules
>> predefined by the user, so there's also the possibility to rename the
>> interfaces in U-Boot to ethernet0 and ethernet1, using fixed rules
>> that would be based on the PCI region address.
> 
> OK but the renaming occurs in the rtl8169 driver, that is used by 
> several boards, whereas the PCI region addresses come from the 
> device-tree, so they differ from board to board.
> 

I'm of the opinion that we only care about stability for the same 
product, not for different products with the same Ethernet PHY on 
different SoCs/products.

Cheers,
Quentin
