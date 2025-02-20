Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355B4C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836FF801DE;
	Thu, 20 Feb 2025 16:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ony/O1bx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B507B806FE; Thu, 20 Feb 2025 16:04:32 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42240801BE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO77z7d6FIRa/mgsnRIsh9sqkhORLaErNyCY45Ikza2GOz8dXsOqEfDEZm/PnNP9kozAeWYg8KifprIXod9Gvy/pWouGIDzLI//eTv088mwaA0XmXl2MsmBfo0NN3eis4b4iKYegfiLwk3ZJ2qOwWIjLQDkwxPbQbxoAmyuVCFpg79I47Et2wUgZvq1Nf3QrNkmhLE1mE71svkkzBRaUAazCwNo1esgF/r5qZzVBweNg1h4vByOs1urDfSXpZdaEuec85Au74tDKnEQ2cRZbiHfhXJ1L+QPEOAMJMaUtakPyTzosK67Sk6m5ZnI8X5UxMAnDBeihpLrq++K3kwggJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0LbI9gpD5k2AgSAifj80rltx7wM1Rb7/cPrsgT6OtM=;
 b=P8usorGVqu4fu9WEEAVpnfrg1/J5jazXxNA8y1nOCbgYGnVoAHvQroU+wVefULQj5PyUbuiqjmlbLFEUdZdb6LcK1RNw3VXg7Jt8DafEZtXMRPjvfimStW0o440AcYnXQBHvZt0FhxQBx9DaCOQ3IMoqorSag6tYgsb+qPBny4suvtNsjmDf4Ikhuxr7oRSiEyXCAUfhfsU3ypPVQKtGjGz5QGnoCBPoafC25USb+xYsiLtKlUQ8xmFq6uZ+M19ZsJvYAU0nzquOhTxPliQZ03Tz69SoQJvNsD1qQ3wc5it9pKhhc/mxKNDReSbeL9SDWfS3zpoqS21IZW/tUgbzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0LbI9gpD5k2AgSAifj80rltx7wM1Rb7/cPrsgT6OtM=;
 b=Ony/O1bxTRxDl0yKvvWupnxQ7TKP8eZTpT2WnnjnUCvoyU4npuum6LrXXkeYWQSJ8yilfQ3l7O58hqAhXHnvwtzJsbYKKp7OnsjTxWBPtW+b7Gc82CvdyyzrLzSCYquKc92OhOEpAHCxwMQSzQu2RRddXZKgwqq9cnWosqG/eyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7331.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 15:04:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 15:04:28 +0000
Message-ID: <07eb10ff-2791-420d-a302-a2e8c308b468@cherry.de>
Date: Thu, 20 Feb 2025 16:04:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
 devicetree-spec@vger.kernel.org
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
 <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba8796c-5cbc-4507-34f5-08dd51bfdf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ykt3WHladVVldDdHdzdkOUsyNjFlTDdQMnV3ZTNaVTBxY3JGNWhQUmpDWm1U?=
 =?utf-8?B?ZUhnNkNKMGVJakN1K21wT08ra3VWdlhyZGdJVGZaaFBaa3VsVEEraUgrTkpG?=
 =?utf-8?B?dldjR1hlTi95ZmNXVG9aTmFIL0pqVldIQ0hpek9BbWFHaU93WmNwSHdOTHFq?=
 =?utf-8?B?Z0JwclhhVWRXdDBqVTJKQkk3RVNaMVFZNW9sRWR4YXNaZ0xnNHpnQkhaN0d6?=
 =?utf-8?B?TzFaUkJ1cExKemxqWnVqZ0k5OE5NVGllaDVtVDQ1OHhlN2grUjlEaklESVBK?=
 =?utf-8?B?UmlwK2k4VlR5SW1KanFhcGNWZys3d1JtR2RCK0h1VldPb0ZmNDkzWmpqU3BZ?=
 =?utf-8?B?RVFUcXJDREFqelBsMm1MVW9PaHlQSWdSMmJaN25ZVFFFRzRqR3VpZmdOaG94?=
 =?utf-8?B?WkJPMmJJR0pFeEErUkhrWUFlWjd1bE9BTndZaUNMdVhjeS94YXVHbjNOcG8v?=
 =?utf-8?B?YmZTK1ZDdEtTMitFSHgvZTZNRFMrb3g0SXltaS9obWdDaE9SL0ZjbmEraTJi?=
 =?utf-8?B?S0h1L2VZM3VVODQ2NFJlMXlYaXNJZUpaazRTRnM5b3ZFMGpFRmlXSFRhL3Ir?=
 =?utf-8?B?WGRoU3YyTjB5bDFRT285Z01LeWFqTEdlanhYOVYrNFU0OVQvc3F4aDkvbHA0?=
 =?utf-8?B?NVphWTE5Y3E2ZExkTGk5NU9iZXVxcVpLbWcxM2U1MS9IbUQ4dEdsMC9ZekZR?=
 =?utf-8?B?d01oYnByTlhaZS9XRjBIVDA5UWNUaHAwWjRaTDBYZ1NkaTVqQVpKV0tKMVI3?=
 =?utf-8?B?OEZHSFhVb2w0UTRBUmdFUW9SSDdUNHRKSVpoQlBxSXF0cXV6M09Rem1MQjdB?=
 =?utf-8?B?Zm1wdXJ5TnQ4V0JUTE9vUzN4RUQ1bXZBWDEzZGNOMFY2RkorNkpwbE0zWDlF?=
 =?utf-8?B?QytaYWVtMllnT0NGYkxmMG5GdS8rdldLT3NIZGd1NkhId2JuclRNZW5Pa3g3?=
 =?utf-8?B?Z2JwZ2RiSC94NVo0SHlPZDYxT2lsL2JkamhNVW4rd1dYT1dlc3lGdXRTemRL?=
 =?utf-8?B?TWgyMjcvdS9TYTVYcllIS0FMQk1WVkFNZkFPaTlRcGJRYnNnUTdnVytSRHJ4?=
 =?utf-8?B?bWpMRDZYYkV5U0VJOFkyVTJRTHViYy9IbmgvMVFPaEdSc2tiZ0FLOEUybytO?=
 =?utf-8?B?TDJHbTJDZGUrTk5KSmYwa2dpNmFOSTZDWWp0Zmxrd09tNkQvUWk5VFlLTGxM?=
 =?utf-8?B?aXl6eE9EeTIwcDR2UTBSV0tJMUpLYWlzbTZXRGtUeTg1S1YrOFBKTHlBT2xO?=
 =?utf-8?B?VGZBbDBvMW5KSU4ySEZkbGR4Z21NWTBsUW5uVVM3dG1BT0wxRGdodU9xL3NL?=
 =?utf-8?B?cy81a0Z0emE5TklwM1NDeFV2c3F3VXBMdGFqS2tZUnF3bGdKQ2gydCs0UnpU?=
 =?utf-8?B?VmVSN1o2Zlg2N1c5dTc2YW9MK1h2RWo0a2xpU3kxODFtSGpJRHNVZWFjbzRF?=
 =?utf-8?B?R1hxQ01yUzk4Q25JVHJ0U3loc2NNeWhXMlU4Y0NZRHdjWXpHWkE3ZGFHOExS?=
 =?utf-8?B?U0ZVbFJFbnRWejB3U2xGcTZsRGREWHV1MkVzS0RKTXMrdVNKcWsyN3hmR1Ru?=
 =?utf-8?B?WExZRVZoeU1Rc2I2cmI0UDFBNFpwSnhtc0VFOXpKUHY0TkFVQkFrTWlKK01o?=
 =?utf-8?B?NUJicFkxaXBoZmU1NUluTXJKbnpleWYzNzllZm9qTmhiZ1dIRTdZdmNiYjht?=
 =?utf-8?B?ZkFnbzVJdXFHWVVxK1ZtL3ZHTzJSZDBGTTFIRGdTblUvNlZpcG5ZaWpZa2RM?=
 =?utf-8?B?K25KTzFlT2ltemNtdHVRTWhyR0tjcWs4SFJsRTA3OHN3WE9hTk9YMzJ3VmRK?=
 =?utf-8?B?akwxbGdtVTJQcFlSWDZTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVpXS0ZldmxrS0Z6VzdIdFlKemY5QVJ6b2c3ZEVxSldhM0VUS28vMmpJS29M?=
 =?utf-8?B?UXNZaHBjKzZ4TUZMQWFaZGRQTERBc1FBYVV2bEFsa2h0VS9QK084cVNrM0pQ?=
 =?utf-8?B?SWVLS1lENXd5cERLbk1xcWhNdHpiN2REamIvSm5jUkxqMjRNRTNkVEU1bmxX?=
 =?utf-8?B?Rm9PcDA5L01OUk8zQnFpOVlqSG1meWRrYStvMlZwMFBxTnZtcURzbExLa2lY?=
 =?utf-8?B?d0NoZWtCWHZ6TStGUHZlNXp0UWlMUGsvMmdudzQ4bWU4aTMzNDlVSGZKTzFx?=
 =?utf-8?B?K2tHWFFkWjdBYWtyNHNPdWdlRm1GWE9RT0N3MGNpSTR3ZnhPUDBOUUFRK1Zt?=
 =?utf-8?B?dUFHcEZXTlJQNzJTZVN6S3FvMk93VVJWam16OE5pTGtKUUVSelF5bW00Sm1T?=
 =?utf-8?B?bnZKTG9yNlJUUk1pVGpYS0JnMjh2WDljMHdTdTN1MHBOS2pNejNXWFVXdWF6?=
 =?utf-8?B?S1l1WlpXYWJrZy9vUHFSb2lzeUZwcHlLcDRoUVVacUorR1NwYWdPajdRVkZ5?=
 =?utf-8?B?aDZNcFUxd0hqNFJ3bUtzVUhBaGFmeXdjUHBFM28rTy9WVkR5a2ZsajVjTU5Y?=
 =?utf-8?B?Y1R1K2lGSDF0SnZSb1VhdzJlemJGZE4vaTdiN3dYNUYwZVcrK2NaUFZweXkw?=
 =?utf-8?B?SEZHUzJGZnB4cDJzUUZIUzhrVmV6V2JtVUY4Vld2bFBubUVhczNxd3k1T0U0?=
 =?utf-8?B?NzNqeDlza09vcDRUS1dJempwNGVoWk80QlVCTUtTYlVXVFFyeHBFVURBMmMx?=
 =?utf-8?B?M3NxZ3RuNkQ3MXlVSE5hZWxLR3A5Um5vUXpQVC9NYldHSmhjZ0FmdENoRncv?=
 =?utf-8?B?YklXWFlpd3NLdlBWZWI3ZUxTQTRMRkMrQnA2b0o2NmJ5d05RN3VJTFdwVlZy?=
 =?utf-8?B?VFlFQVpiL055b2NhVWVoRGYrNFA0NHBmOG1qNHFHakZ1dm9CMEREaDRUMWpE?=
 =?utf-8?B?TlBTWlA5Ymk2ZFdnTFdoV3V6bkZyRFk0N3ovMERVcDdMV3N4SmFvM1Rwdm1R?=
 =?utf-8?B?c3lKSExpVHFjeWtvU0Z3dDcvN1BLK0NmK25tMVVoZ0k4K3I4WFRSM09JT3g4?=
 =?utf-8?B?NFFIQ04zRUlndUhuT3NJclpPOUJad05qc0o4dXdHYzR3NERMbHpuaG53SWxu?=
 =?utf-8?B?VG1NWXBGUnJuTC91VUgwTm9ONmY1T3JYVFpodWt6V0RndGZzLy91MTdoOG1a?=
 =?utf-8?B?YmRYYW5tLzYyTU9zNWFIR1M0Z1IvSFMrQmpGNktJd2xVL1RUaFZCVkpxK25I?=
 =?utf-8?B?SGRtUUYreFlnL0VTcUhubFZYRW1ld0w2bE41QWlPNTVwQzhVcU1rWU9HTHF5?=
 =?utf-8?B?WUk2b2hLY3JTL0RETFlpZE8xZkpqQVozbkU0SDJueGpwNmV2c2ZDU1ZCN1FE?=
 =?utf-8?B?QmRGM0NManZrbFdkK3ZrTkdRdDhiL0V4dlIyb0JFaXR4bER5T1Z2OVhqUXdq?=
 =?utf-8?B?dDFHZ2Fza1NlS0VJRzBoU0gySTYxUHJjeCtyWTJyd3h3YzJ6YkN6Wi9NRjFG?=
 =?utf-8?B?cEd3cm9Ed28wRTNYVFdzNmRiN0pzWHhxYXpJcnpOVTlxNll0bCtwcER6bWts?=
 =?utf-8?B?MVNUZlVoT3dhaFh4eFFJZXJBbElzZm1ZN0xsTFFDWXN6VmwrMDZDUWNnWk5s?=
 =?utf-8?B?cnA1eXA0VG1OZzNiT25SbVlWWm1pVDhOQ1VTK2xQaG9yY054Ti9nUGlIVzVj?=
 =?utf-8?B?Q00zUm9DL2pQQUZBQnBKcS9mVzFVNk1iNnVrQXN0RkFMYzBMWXZ6enRjSFhv?=
 =?utf-8?B?L3gxTG1VcTNGTDVwVTV6NE9vNmg1aU9wL1FTMVltcmxJNXlXVEswMTBJdEpl?=
 =?utf-8?B?aE9XT1VIcHdIVEI2d1l2R2MzOWhGRmFmQVJDYkRJWnVMOEx5dUxaOEVhanZ1?=
 =?utf-8?B?U3dsY3FLYWZpNDJNZ3lXdWlWaklyemtmYXY4UDBBaUJrTmlVdFlUanNjWW14?=
 =?utf-8?B?TzVCYmFHT0NEMjdFckJHSUN6OVRnWVpLbkZ3US96dmZyOXgySDJnZmUzWDlx?=
 =?utf-8?B?a3N6aFVjTzZOUlpvd0ROMWRObTdUYTB5c3E5TXpNQ1lLMkVVYVZyREVudlhS?=
 =?utf-8?B?N1YrVFUrL2dZZnErZ3RTZjhPSjFyQjlaejlDZkpFWDRFZDEydUEzRXFmUm9W?=
 =?utf-8?B?dFNETGxYZG0wdmFlU3dPSDJHVnlZdHltdUV3a0pGd244TjN0Ni9ZR2gyVjZp?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba8796c-5cbc-4507-34f5-08dd51bfdf33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:04:28.3205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jfgk2vZ5lz822D/sbLYoOjOsljuHZaJxsps508sdUnevZZA0ag61ND28mBT3aGRvt9OEPfUyRuv3ML+o6B9U+u8XzHUDeeYVafIdK9ElEAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7331
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

Hi Daniel,

On 2/15/25 4:13 PM, Daniel Golle wrote:
> Hi Quentin,
> 
> On 10 February 2025 16:25:23 UTC, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>> [...]
>> What I can say from glancing at the code is that for Rockchip they do the following:
>>
>> Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a bootsource instance of that type (e.g. MMC0, SPI3, I2C7, ...). The mapping between what the ROM says the device is vs what it is in the DT is done in their Barebox-specific DT via this custom prop in /chosen:
>>
>> barebox,bootsource-<bootsourcetype><bootsourceinstance> = &label;  # à-la /aliases
>>
>> This gets read and resolved and then inserted as
>>
>> /chosen/bootsource = "/some/path"
>>
>> into the kernel DT.
> 
> We are doing something quite similar downsream at openwrt.org for MediaTek router SoCs, see for example:
> 
> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-mediatek/patches/310-mt7988-select-rootdisk.patch
> 
> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi#L32
> 
> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso#L60
> 
> 
> Of course we could use the standard "bootsource" property instead, but having a way to reference the volume or partition used as rootfs instead of just passing a referencd to a physical device is advantagous...
> 

If I understood correctly, your prebuilt DT would have

/ {
     chosen {
         rootdisk-emmc = <&rootfs_in_emmc>;
         rootdisk-nor = <&rootfs_in_nor>;
         rootdisk-sd = <&rootfs_in_sd>;
         rootdisk-spim-nand = <&rootfs_in_ubi>;
     };
};

and then at runtime you would populate /chosen/rootdisk property with 
the "rootdisk-<medium>" string with <medium> matching whatever the 
BootROM reports. I assume the goal is to somehow make sure that the 
rootfs is loaded from the same storage medium as the one used by the 
BootROM to load the first stage bootloader?

Can you confirm I did get that right?

I was specifically NOT aiming /chosen/bootsource to represent the 
storage medium used to load the kernel or rootfs, but rather the medium 
that was used by the BootROM to load the first stage of the bootloader 
that is user-flashable/uploadable.

You could very well decide to load/mount your rootfs from SD even if the 
BootROM loaded the first stage bootloader from SPI-NOR. This property is 
about representing the latter, not the former and not merging the 
meaning of both into one.

However, I could see a BootROM being able to report from which partition 
and controller it loaded the first stage bootloader, and then it'd make 
sense to have that in /chosen, either as part of /chosen/bootsource or 
an additional property like /chosen/bootsource-partition.

Cheers,
Quentin
