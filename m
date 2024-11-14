Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227FED65C79
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799F3895CE;
	Thu, 14 Nov 2024 12:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="fx6SViov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 429A0895F5; Thu, 14 Nov 2024 12:32:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E06895AF
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjmC+lDN2KW7oQ1P5pf5fJ2PBXf3xT2AYwTJs3dlv7YDNb+51EvC1mHZh/SzSYDOVcE7qDhxjBylbr3mMZnm1l36Td7tOaLpqVmSE90MUXBpvuNPC8eEQZ4iMa+NetD6RsFMCNy5EcAd3QUbTC3bDvtU8DY8GTRcn7lm5dl6FpC3XzlEb+XmJw2AQLI84JEqK7cYeblASjBtqAYChFaOaaRLU5hev5U8EK1mB4DDhNTVZLjbGD2N2KMvb1E2nQqIgkq2Te3n+kTJYaCJi+7AbcI4Vl0UkHXvAbg4dHNSMU6mwD4tgYH6ObQB584u4+YzQnsQegZkAsrx9XktzHNVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kmr32Kn0/7h+6TEIrPbxp+C6hzudQXmCyo6MDCGaX9I=;
 b=nL7qsjzhIymZnDO8ONjWWXPqolte2w9c2MT8DdstTXSd7oxrL2AskRw0L27ZmISjaDrvzZLon8CB41kY6YAydf7vNEf3hhp1b7gf3bbCOmI5B3bboFJ51v7wbp8NeMsCywMJuIkgrW/HcppZtDWJBwz32KVC9AClQdIM4yXWRLsKxrCZlESy6c8OfDF64ZZvkuQNKfz5qE+4Di/ownZ2Pmy7FTYsOgQe5O/hhzT5jNsDKcisSy6cpCRo3yF9a0Jx7hFYxrvTVbKpn8kv5AU8vL2p4coIX4sBplYPjlluqxFfr9n5ALQb04pXBoDaoCMr53Y/0hQtpPwufXM/OtdXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kmr32Kn0/7h+6TEIrPbxp+C6hzudQXmCyo6MDCGaX9I=;
 b=fx6SVioviar63RUs3Nh0GE1pAjaJbzGkwkxK71W0Eiek/3T8KS8AHL7aoEjQ7CojcuS12g5keG2DCA0oSvJsSiGX6iJw/zx8h9t2OKIwhBSBVv4mhGiDTx+26FlJXjzywAMgyDMYlr/+XlIdJcBXoA13IBTf7uVMPS3VEBqc/eQ=
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by DB9P195MB1755.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:39a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 11:31:53 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::d0) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 11:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 11:31:52 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 14 Nov
 2024 12:31:52 +0100
Received: from Florix.phytec.de ([fe80::a802:84f9:c56c:4c6d]) by
 florix.phytec.de ([fe80::a802:84f9:c56c:4c6d%5]) with mapi id 15.01.2507.006; 
 Thu, 14 Nov 2024 12:31:52 +0100
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: Wadim Egorov <W.Egorov@phytec.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, Yannic Moog <Y.Moog@phytec.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Andrej Picej <andrej.picej@norik.com>, PHYTEC Upstream
 <upstream@lists.phytec.de>, "sbabic@denx.de" <sbabic@denx.de>, Primoz Fiser
 <primoz.fiser@norik.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "m.othacehe@gmail.com" <m.othacehe@gmail.com>
Subject: Re: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Topic: [PATCH v2 2/3] board: phytec: imx93: Add eeprom-based hardware
 introspection
Thread-Index: AQHbNeU4q5bCcuoD+UGXrAKl1foggLK1d3+AgAEdi4A=
Date: Thu, 14 Nov 2024 11:31:52 +0000
Message-ID: <f338e06d6016045788114d3b21b470ae432f0d75.camel@phytec.de>
References: <20241113160037.65679-1-c.stoidner@phytec.de>
 <20241113160037.65679-3-c.stoidner@phytec.de>
 <CAOMZO5App0zamP_zcMLEH2ih9=q25VfGEi6k2agoVDAQ2Kwirw@mail.gmail.com>
In-Reply-To: <CAOMZO5App0zamP_zcMLEH2ih9=q25VfGEi6k2agoVDAQ2Kwirw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1EFB021602C9F4B9294E1E6F86B7A12@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|DB9P195MB1755:EE_
X-MS-Office365-Filtering-Correlation-Id: 80050117-c321-4361-2567-08dd049fefdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STJDSFRQMkkxR0hMd3hpaURsa3M1aDBSbFpHVndDNlpMWEJSZWRxV3czL2Ju?=
 =?utf-8?B?YXdGTUN1S3hmRUQ5dldIb2ZrTzAreHJITHd2TndkbEZzazFWZ2hWTTduZ1JS?=
 =?utf-8?B?bnp4NS9CUkQzeE5KVkViOHQ3SXZHMmxCbXpIamF2K1dHTnpTcG9DWnJqY2pm?=
 =?utf-8?B?UXpzU1dwMXdINGhrd3UvS2VKUzZUQ2M0SkJ1MTFyS3JMWmtWbUxYb285UHRV?=
 =?utf-8?B?S01ZRHpwNUkyeVpkQVRzTU45bmpvak9yTGRPSk1kRngvOWFKc2I4alZwTTRm?=
 =?utf-8?B?N3hTK1ZDWGcvWUZUdU5KelFsVEFFeHg5dzVON0FNRWFPcE5KMUlTQ0hBb054?=
 =?utf-8?B?RXo4Y0FoeU15VU1JeG9xQnV4bk1CSUgrbnovMlZkeUNUSnordGtBTmdVdXo5?=
 =?utf-8?B?ZXhBeWliVlROQzRlR2VMSEg2aHZEM2NaM3lhaG1OOS9UY1hhUWxyRndpYWdX?=
 =?utf-8?B?L0ROV1lUS0pvcDExa0huSXh1d2kyL2pGeUZWQ3YwTVVsUnRpa2E5TXNDMnJZ?=
 =?utf-8?B?bHlmdnowSW9lWWVJVWtyNm9CNXdNR3hUVEYrSmp0ck1NWFptcjBGUXZxZm1s?=
 =?utf-8?B?azlGZVhUbVcrWGRCVWM3TmZ2VDRZRVZhUnhBVmNiNDhranUrV3BLR0tBbWR4?=
 =?utf-8?B?RGdxM0doWUptZmt2WWpab0wvN1pFaDc0c0FidDJDV2QvZlRDdTdaMnhEeEF0?=
 =?utf-8?B?NWRHUW0yN011UVN4SjUxc25WT0dIUE91STArbGpKcXI4ZklMdEV6SXZ0ZXMy?=
 =?utf-8?B?Qmg2Zkx3dlpUVUFuUVg1dDFKOUZtd2RWdDQxS1l4RWZKZnN6MStZQWF6SlpR?=
 =?utf-8?B?ZHlxbWtlUFBlZ05JVWp6Zm9HSlZqeHQrQmJvUUtsL3ArVHBTSWNLZU1Rend0?=
 =?utf-8?B?RmNZcktKcG5XODNWU3VjclZZbDVCczRIK1RHNXZ3VzRRalZIYVNjWEt4ZXM4?=
 =?utf-8?B?MUQzV0k3RGl3d0VtWllxUlc4Y1BoUy92RXJUVGlMN2FoYWFsakxsY2VvMENm?=
 =?utf-8?B?OE1KVC93MlVJVTYxbHBvRlk0d1AzV0Mrd1R3aEMyMytCTVVFVXFsRVVNMDVE?=
 =?utf-8?B?L2FRV1l4bmRSNUJ0WmtCWEJzUUc4T2ZydWxpMm9FN0MraWl2VXBDc0k5aEth?=
 =?utf-8?B?eCtZeUhoYXlXN1FqcEJmVkdtM0t2d1J4eE1MSjVQdnNKcWtHWnRYb3pIY0JG?=
 =?utf-8?B?NGszT0daT3VGc3F6L01RZXdpWUFtVWhTakV5VGVTNVJmUS9oVUh6V1dMVnN5?=
 =?utf-8?B?Y24yMzVDS1NPT2J4eVJQRDlWVmFrcHhZZDA2Qkg5TFpaREJUOWJwRlh0NzdK?=
 =?utf-8?B?V3ZaOWkxSFl0VDZldVdxd2svcmRIK3h2YWJobXhZdEN3YTMrMU4yRkNNclFF?=
 =?utf-8?B?Sk8xZmhzaC94TUlPRjBOUkd3M1I5TXhVTkVLVHZld29ySmZHaS9HUlRZV1Vv?=
 =?utf-8?B?L0Q1VkdWdVpCSk9HMFlOQ21ncC9rWURXNVBuSjVRUVNET0xuOTZiNEx4cXBG?=
 =?utf-8?B?RHE0amJNR04veHZLRUhPUXkxOFZRTk9LaldQV09DS0Z3NExZcFNmQjloZStk?=
 =?utf-8?B?NVJDT3ZVR2g0UG9nMUdGalhON3ZmZVp3V1IzaGVkckhYYmpkQW00T3ZtMEZo?=
 =?utf-8?B?M3FsODk5Qm5YcS9GeDYrakp0MW11OVBFUjZYdDltZ0txN2ZRRS9zaDNZVGRk?=
 =?utf-8?B?NUVVMGlqRXVmVVZ4ekpSL0x3YUE5UU9MWnJXbkR1WTRsVUZMNnovSnlBbkF0?=
 =?utf-8?B?YURudCtxYXlJbnB5dGdzWC9aOWRJR0J1cS9zQ0hmVWdBZitMeURCd0VUTUJP?=
 =?utf-8?B?SVpoSklRay92aDZObWJqMnAyT3JQc2htR3pwZ0xiQWZ1cnhwOU50MDI3cnh6?=
 =?utf-8?B?SENCeG5EbEl4MWo1aXZ6YVowMFhFaXM3RXhqakp5Zm9MYXc9PQ==?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:31:52.6346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80050117-c321-4361-2567-08dd049fefdc
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1755
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

CgpPbiBNaSwgMjAyNC0xMS0xMyBhdCAxNToyOSAtMDMwMCwgRmFiaW8gRXN0ZXZhbSB3cm90ZToK
PiBPbiBXZWQsIE5vdiAxMywgMjAyNCBhdCAxOjE24oCvUE0gQ2hyaXN0b3BoIFN0b2lkbmVyCj4g
PGMuc3RvaWRuZXJAcGh5dGVjLmRlPiB3cm90ZToKPiAKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
ZWVwcm9tQDUwIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb3RwaC1wcmUt
cmFtOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vdHBoLXNvbWUtcmFtOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhdG1lbCwyNGMz
MiI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHg1MD47Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYWdlc2l6ZSA9IDwzMj47Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2Y2Mtc3VwcGx5ID0gPCZidWNrND47Cj4gPiArwqDCoMKg
wqDCoMKgIH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGVlcHJvbWlkQDU4IHsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb3RwaC1wcmUtcmFtOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYm9vdHBoLXNvbWUtcmFtOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhdG1lbCwyNGMzMiI7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwYWdlc2l6ZSA9IDwzMj47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZWcgPSA8MHg1OD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaXplID0gPDMyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZjYy1zdXBw
bHkgPSA8JmJ1Y2s0PjsKPiA+ICvCoMKgwqDCoMKgwqAgfTsKPiAKPiBJdCBpcyBPSyB0byBwbGFj
ZSB0aGlzIGluIGlteDkzLXBoeWJvYXJkLXNlZ2luLXUtYm9vdC5kdHNpIGZvciBub3csCj4gYnV0
IEkgYXNzdW1lIHRoaXMgd2lsbCBhbHNvIGJlIHNlbnQgdXBzdHJlYW0uCj4gCj4gUGxlYXNlIGNv
bmZpcm0uCgpUaGF0cyB0cnVlLiBJIHdpbGwgdXBzdHJlYW0gdGhhdCBpbnRvIHRoZSBsaW51eCBk
ZXZpY2UgdHJlZS4gQW5kIHdoZW4KdGhlIGR0cyBpcyBzeW5jZWQgYmFjayBoZXJlLCBJIHdpbGwg
cmVtb3ZlIGl0IGZyb20gdGhlIC11LWJvb3QuZHRzaS4KCg==
