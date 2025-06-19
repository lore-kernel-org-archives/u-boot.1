Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C0C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 09:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635C682CD5;
	Thu, 19 Jun 2025 11:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BQCrFZXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055D582B18; Thu, 19 Jun 2025 11:13:33 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182EB82DA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 11:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHoldg46gucoWWHpWoKkKjrgf6TayGqTTejjYsvLE9ROmmqiOFf7qH9n9p4v40ghoULodr8OR+gp+edagIx6u6OyYIXzB5rv9+e3FyAtedL5BNHdqExehAxXAkNwZY50lxx8kFvjvQ3+RfgvR2BSgg95iSNJy6adllZTMoMr2OR/Zy3flVN00FQnYnUk+W2O7sXhvGWQoUL9tkB5vedEfQJ+sF/kPQK5u9wE7K0g83EdA4xYyaNQI3X8bbNOfblQFY32XYwmYqnHGFKnd5JYtUOKg5J9iyaygnefmvqMuBJL22sHgstMiar3xlvXb6K5h+2+EKrri20LbEDu97Lrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRe1WFk6zALeup9AdFK2ZvbyEYUi4evy9p0+ls1Boec=;
 b=Oy25klAD/N7H9UO+KO5IF0fpyBdO1u1KeduX1kj5d5i6abnYPeY7XcPZvs+ezE1ksRiZM3+qdCK3o4kNHqmii2Z8GnPftlEJ8AqYgreOdVSTaICbgYBi0yqAFzmdgM32rsYS5d2IjOwk3md8VuwoigK3H2uWa2CEF105pa0glgl0VH1HolUXwXfUTiBm6myP1LLBVKuN2jUxCHWnzkVS76+jL1YcCBq06SMvH7FFI18XJr/fqZ7HnJrdxWyRPhu7vNuMEEf9/DDBB4TJhqOA0k55Qrpoq6WJSjxYDwnQLHQKBEE4aOyycHR9iXuPmzrqSNpY6SEgJVILdsUPb+uxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRe1WFk6zALeup9AdFK2ZvbyEYUi4evy9p0+ls1Boec=;
 b=BQCrFZXXIJWK8xHd4uB/GOfgSC2UzChLGcJCLdiBcOdn8OTe71eI4hwzlf8Uz5FTbI4mwNxeU1oCNfVGhgjM01mBmnIqqmZ3ocG0eHG7s1u8gXHHCbOBSIC0F46XWeDfUdRIiuiRS+yUEgOfzqg8M0NmpY4vU2hHE035X28g4gYPuUg+nIYrZvXEVA9Eb0TEBR3PwixoK98YPYE/Dfy7HjFHiCJ+7d9NwyeSKrBw2qpkAec4l/S++5tEFAGYcqMdJ3Kl47Nv18UzXmv69Uu4eaV60DiXe3wVpIg97TqskSf4VlO1KG+pZLw6vq8i9YeFXmT3enCb87rvr6+89qg5hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10888.eurprd04.prod.outlook.com (2603:10a6:10:585::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 09:13:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 09:13:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Jun 2025 18:23:39 +0800
Subject: [PATCH 5/5] imx8mq: evk: Add support for capsule update
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-sr-v1-5-631100a113a5@nxp.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
In-Reply-To: <20250619-sr-v1-0-631100a113a5@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10888:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e688940-7794-4043-3893-08ddaf118c71
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MllldzJRWUFNOHJQdmFDMTdOSXZhVENhdHBKclVQQ25DVjdPbjR1cWpCVEZD?=
 =?utf-8?B?TWc0SHhIRklnaXR3SlpFVlFYZFpCVjBTYXFLMk9ZbjBEQUhJTkRMSW1uVW1h?=
 =?utf-8?B?U2UyaWQwdnlTbERudDJWc1MzOTFDVzhOL0pLdkI4alh3am1mbWNDd21PUEdW?=
 =?utf-8?B?RnNwNkgxblNTamFhZjZoN1JpMU5NUHBwWjNRWUZ2N1JvaThHZy96WkVPeVNr?=
 =?utf-8?B?YXBuSkxPVlhWM3JsL3V3eVU4dW1IVFRKdFRZVUwrbThkeXN6QThiZ1VCK29C?=
 =?utf-8?B?VHgrSDZTSHRvQ3VabTc3Q0NRNVp3dkowMnBuZGx6cmlHL0RMVW9tVVVLdFNp?=
 =?utf-8?B?RkFCVkVCazlzQUxHOHZkZUlHNkJ4ZGpWdzVTM1E1QkpvdUhKd2pzR2phTWtR?=
 =?utf-8?B?UHg1S1V0ODVCZ0x2bFZFcFgrNnBnMFc1ZjVwczd2S2pFRkQwN09YSXljcmpm?=
 =?utf-8?B?YmZuNGRYeFNqd3FQWG96RDl1a09lL3FVb0ZObllPZk94RFFhUEdyTS9SdHlJ?=
 =?utf-8?B?c29tYnVFczRFK0EzbXZlUmZrbi80amphYXQ5OCtuVjVkYzQ2SzNkbHR5eDlM?=
 =?utf-8?B?dFlmK2pqbEdrMmg4VUFOUkdLQ05KeUo0R1BDOFFIcVdOc3NSbGlvalNkQWU4?=
 =?utf-8?B?ZVFUQ1dYSVJpbkRtZzdQdGRkWU54c00zN3dibi8rSzBiOGphZzlicitxZCs3?=
 =?utf-8?B?T1Mxay9EWTlvTU5hU2k1TEwrY3BQT1JjQzBNS3pnYXl4cGVaSXZ2NEJLd1Jh?=
 =?utf-8?B?dDlTWUxQTWFpOGVKTnRha0l3bXB2T254eGZOeThmcG1zdWVvVEt5ajcyYUNJ?=
 =?utf-8?B?ME5rSjFVWFZhYU14QUZpL2tmYVVEaUJVbElCNXJvcTFaUHZrVm9CdE5QVGtP?=
 =?utf-8?B?SnpQVkdJYXdueklJTEgwbEpFOUJZUk94ckV2UktuTWRJckJkYWRnVW8yTEVR?=
 =?utf-8?B?cGZqbTcyUFk4NWdIVTFTS0JFYVcyZmxtY21jeTdxREZSQVoyTEQ2ZkExZi9s?=
 =?utf-8?B?Ulhrc3lGSWl6ZnVrNDJzQjJhYzQxTXdTMm8zRU5IbDNaNEJOZnY5UVBIVTJW?=
 =?utf-8?B?MlFtdlo3VUMxV0IrbGZrNTRZaFoxMWpsaWdlRHBQMkliSnVYbDRCbUZkUldP?=
 =?utf-8?B?SUlpNUFoS0p5QklOc3UrTUJBbG1SdElZOTNvcGdRbnZhbisyd0dWYW5QU1FQ?=
 =?utf-8?B?MG1TTUlaaHd6Q09VbC9IaXNCL0FoS0ZZSDRpZHlTbDdjUnJxakdIRjFhWERX?=
 =?utf-8?B?NVhJTVk2MWVjenExMk9SVGN4dU5ycFlrM3BVZFdmQm42TTl0aXJEdXhRNHUz?=
 =?utf-8?B?bGIvaW5FTDFvZnRub1AwMTVyaEdQMEhHcjdBQ1BKRkRsTXhIbFl1VEdvT0lp?=
 =?utf-8?B?aWtwbnUzWVV0N1V6eXFUWEVJQzRkUHd3a3lzT09aZGJ2YzM3L1c1ejlMc2pP?=
 =?utf-8?B?YVB6QU9KOTFWWXl0M2NFQ2pKMVBHN3oyZE1uVkdiUUtScVBEK0ljaWdQOXhU?=
 =?utf-8?B?OE1DOXB2VzZYVkhmaXF4cEphVy9CV0d6Q083eDFwY1hKL3VGKyt2Sm5peGMz?=
 =?utf-8?B?eEVqMWhPdmxkYjlhMjlhOUNyeEk5cHRNdDBiK2ZWNWFGMmk3ZmpRMkNOWWVC?=
 =?utf-8?B?ZFQyOXI4UVNRWTEyNHRlM0J4RFVkVmNGZVRnUzFoRWpCZEEzbnhjcUIxUUVO?=
 =?utf-8?B?bkg0aE4wL204NExhUVhMWHpFcWlWVndnSGhxcnhkSTViS0pZalpIM3Jrb2Ri?=
 =?utf-8?B?YXBFY29QOC9SdUE2ZjB4aXlYTXFJdkNOekhmS2JxWkFwNEFDV1k3RG1TamY4?=
 =?utf-8?B?MG9vbVJUWjY0ck16Q092WmNCNmRUb2x3Zm1lcWtzMGwwRkI1Sy82c3hGbGhq?=
 =?utf-8?B?bCs0b2RScVZkRXVVQnRtSWdHZDlxdGtTWCtRUjl5eFM3VEZIRlBNTnp0K3Nm?=
 =?utf-8?B?aGprZWo0ZlE3NGl2VDhPZGdEakNlL0w2T3pFbFA1ckVwMDRZajRHdkVkZnMz?=
 =?utf-8?B?aTdKSHVDc1hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FObjVMS2EzWmNsdk9TWGx0ZTFNWERUL1dNUGFmcEtRbmdMM0lmWmRiMmU4?=
 =?utf-8?B?KyttbnBUNDRVbkpQdG01QmdyaDUrby9JQWVyZitJMUI3b3cyTGlBVTVsaHJS?=
 =?utf-8?B?ZHZlWHpkMUlYTmNMbzNMbDc0Z3ZCUTFobCtqMHBPWTFoUHpMRmlnNTdsM05l?=
 =?utf-8?B?Nk5QdWhuaCtkUGZPMU84SVE3RHlscG9IdktkRWM3SEdKanF4N1Q1K3RnZWp4?=
 =?utf-8?B?MXpJa29RaW9NWkJXemo3bTlDbHhGdHBnSkUxQ3E4T2NJaHlJMEJjQ04ybjI2?=
 =?utf-8?B?MEliWHdMelhaM1o5ZzdrcnFVL3R2Nk44WENLTzVYTVhVYTJ1WFhheXFSRHVX?=
 =?utf-8?B?c2dYZjI5Y25jZjFLYmIyRmJQRWlJK1l5alVMczRWL3hhUXMxR0YvOGV1VzMx?=
 =?utf-8?B?M3Y2TXBlYjU4WDk1YzNOKzQrZkh6TU1KRW43M1YreTRaRHcrSkZFRVB0cWl6?=
 =?utf-8?B?cm1LaWxOTUpLU1ZrRkQ3cTZuY2VFdEo0Zk9BMUNTeEtUSzFDRlV6YU9rc3Nu?=
 =?utf-8?B?aFZZV2RGVWw4QW1YbFJvUlV0VkVnNGJjVWJqNDMvL1NFeFlWWHJsWndmOW43?=
 =?utf-8?B?c2V5Q1Q4bVV0RzFmcjN6bWUxVW4yc3E2ZGxYQ1ZDT2NtOHhWeEE2cVlzV0c4?=
 =?utf-8?B?WlpaVUZKa21YSHhOOVFpZVh4NHltc3E3NzdKUU9QL2F0U21vS3M5RUo2aXJI?=
 =?utf-8?B?VVU0UzVLUGszRHFWQTJMM3dDZUNhaERjMm1DcG0yS1VqUlVKQjNpR1hDWVRn?=
 =?utf-8?B?WmVFUlovNGhVSFJnR3RwcUsvSStuU0lJNFE4Um1nVW5SOS9FUThtSjNYOGE4?=
 =?utf-8?B?cUE1ckp0bGQ3ZHFCTWt1NWh4T1YzTjhySEtnMUpHYWtoYUtmK21zWkxnalFy?=
 =?utf-8?B?RnUwNVZBcmdhWG1QbW8xMklJMWswVnNtK2o4NkpNVFJwS2V5ekVzM202T3VE?=
 =?utf-8?B?bjBEdC8vc0VpQTNPZGw5K3RFWFBKbWI3WDYrNkRhOFdFWXdVSHhST1lBUHNX?=
 =?utf-8?B?K29WSUVQTEIrd3J2QkJDaDNZUjR5VWZFYkJkVXpseFZTanFpdUJXd1JqUTJF?=
 =?utf-8?B?M1U2eHh6d1FZaDNiNXlhaWtmZnJRclZaWTAvRnlwb0FsNzBrdnYwbkRZRTRz?=
 =?utf-8?B?SjRUc1J6Y1lzcVVYWDVndzNqV25UWVZ1NjBqYjVIQWpEWkNCeFlIRENQZ2RX?=
 =?utf-8?B?YldpclhMZWFJNEQ3bHhkekhDV2VLc0xoYk45elhnOFViZ0hZOTBwcVMvTmpv?=
 =?utf-8?B?QzN0NWJVV2hnYUprcDNVaUdKdkxmTlhWb1hLSWV4ZUtXeW5Ka2p6WEp4RGtC?=
 =?utf-8?B?VXBlbmZsWGJlSjB4d29TREVPMnlreExoU3RZK1AxVWI3RHQ1WjZESWxHdmI4?=
 =?utf-8?B?cFZibU5oeXhLdS9xVE4wNDM5SGljc21DV3BPdXk2Nmk0Ylo5T2gzdnkrL3ZP?=
 =?utf-8?B?aXhFTUI0YWJXZnM5K1hURGp4OVV2Y2JlQXh5WTlQandQa3VseXdaOXBvWDFI?=
 =?utf-8?B?K3NpRW5YZ2ZSaVhwcE5wMjZSRCtlRzFDYmIvWWlnT0djYlYzR1JvRlVtM09n?=
 =?utf-8?B?d1RjQnZqVlBma1pXQ0M1NHE5dXUrL0RwSXBaVFF6T2QydzVvOEhFMytRcUdL?=
 =?utf-8?B?ZUYrWEViakFOSzJEOEd0YjgzcU5qWU0ySUhadkd6Rlg1dGU4cllkUnovb0c3?=
 =?utf-8?B?SnpIenlEb3BpdkI0V3huZDZiVzlweng1K29PcDQ3QkV5ZTBmN1lJSlpic1ov?=
 =?utf-8?B?cnpaSnF5Rzg0SUJESVBvMnlPSmdGbEUrV0NYZDJTV2o0b0pMbWQyZDhNRVVr?=
 =?utf-8?B?d3VtbkI1MVl5TUNzL3BWS0wyQ2xWVS9IZ2lWdmtTZFBaZTVoZmVHenVVOXMz?=
 =?utf-8?B?SXVkb2dCVHpiUjE3VVJrTzN6c2d1Rkt1ZXRmZGFqZFhCNWFTb2FGaUt5dDd6?=
 =?utf-8?B?VG93bUhDVmVJUE84QUxWVnpyanJIaWhqcGc1RkhiTW1wc3lPVzBMVXhlVzMz?=
 =?utf-8?B?VEVDejRHVjVvZjVhS2dhZWQ0RnF4RWdZQXBlUFdpajJ0T1k0U044THpBZndj?=
 =?utf-8?B?NzZzRnY3WmVoR3hXdVp6djNCeEpFekdKZVBwWjQ4Z3NXTXJzQXZ4eXQ3Q0ZD?=
 =?utf-8?Q?2++FjwBRlEFJRz6UVa89CeliA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e688940-7794-4043-3893-08ddaf118c71
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:13:26.3417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftAIGcdRGJu58ek+ctFO/PZI3b5E6htHpKmAsWIMdcWPcrcfvOxphsAHeE0xAXol3pNqQhSExl+/UrpIiFYIHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10888
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

From: Peng Fan <peng.fan@nxp.com>

Define image array and GUID
Select configs for EFI Capsule update

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 21 +++++++++++++++++++++
 configs/imx8mq_evk_defconfig            | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index 18e83d90a08d653dd629bb773ffd11f50532f4b9..e90c56c33ffd4764b3408df7a154436f05949e19 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -7,6 +7,7 @@
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/iomux-v3.h>
+#include <efi_loader.h>
 #include <env.h>
 
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
@@ -22,6 +23,26 @@ static iomux_v3_cfg_t const uart_pads[] = {
 	IMX8MQ_PAD_UART1_TXD__UART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
 };
 
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0x296119cf, 0xdd70, 0x43de, 0x8a, 0xc8, \
+		 0xa7, 0x05, 0x1f, 0x31, 0x25, 0x77)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX8MQ-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=flash-bin raw 0x42 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 int board_early_init_f(void)
 {
 	struct wdog_regs *wdog = (struct wdog_regs *)WDOG1_BASE_ADDR;
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index a2a6991bee28d2e6747a5461093a7c034a88e95a..61ff01c09093cff418d556d8ed4789b1659769f2 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -27,6 +27,10 @@ CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SPL=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_REMAKE_ELF=y
+CONFIG_EFI_MM_COMM_TEE=y
+CONFIG_EFI_VAR_BUF_SIZE=139264
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -53,15 +57,19 @@ CONFIG_SYS_PROMPT="u-boot=> "
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_CMD_EXPORTENV is not set
 # CONFIG_CMD_IMPORTENV is not set
+CONFIG_CMD_NVEDIT_EFI=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_MDIO is not set
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
@@ -72,9 +80,11 @@ CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
+CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -96,8 +106,11 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
+CONFIG_SHA384=y

-- 
2.35.3

