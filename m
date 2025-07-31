Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87723C83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1459183824;
	Thu, 31 Jul 2025 13:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D9mBlEaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940CD83844; Thu, 31 Jul 2025 13:30:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECD883816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcyYVbIqUmPConqVX3vWSxgpZILvIdMtcAMykLxIpc8KXudRR50HvVcpUCCgAlSjz2Uo/9L288nR0I0ArmP944CCyaqREh/Vik6YX0qfOlqtABKc4v/hZ3ysdTDljEXpxnv5Bex2aYxG64wJcRsActMcv28gm61VVcqmOkA6T/HnOmkecWOIhsMrUhX18g3FPAeu4Tx8xLKKPJuv48V9vTKBKar2BQNT4lm1DlUXpXEIpETkAT/furUorsX1dCdUGEYlwDsFS6fdnBk9WzbHVKt526rTDW8hnTLYZABBaRXYWAkBouKZWDrVf8kHhL7NH9QGIjlSNgJES2JRhj5xiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6EMTQM0FZz1L/dBe2kvzgq18EsIFbnYfeoRwU0nYvU=;
 b=JnPvIMHcj8Y2rNLWTT//UpSTneNuEsFy7ZHfAZuN9XBtvUp9+5V9kNhCe87LJKaYg3BShZ02xNSfprye+ha7AUvgjmJEW1X3rC7J9RW5xusu7YW3fdegtnv0AzUwxZFGKyw7yUsrJpchJ/XrpFaHSNOqrDh4nNlsLKtPu/qJ8cRnIIpkDkSDKr8VpT5e/5HFTRLhDzNa56SaiJbJRXcQ8QarG+IQ+/QLqbSog00LbArAP2kKcqMmxc/hbY+rq1DhuA8NTffMR33a5cP/G7yVbNbyt6X0Bv+/9CMhTxjhoWpCGqZ4u5o/0I2gEtmWV8k4nNb8lgcTzzMz8aeKH/Kt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6EMTQM0FZz1L/dBe2kvzgq18EsIFbnYfeoRwU0nYvU=;
 b=D9mBlEaKkdyd63Qiq3jVV8wYEZIaPlk7RAAiD4xcAiZSp6AuisSZOCsa6GXED+mKkJL+qQAWC2BfW6NxqZYB8yhZPNUdvZdNnI0Ai63fqxO9vbZTwYQjiOO6O05lv3ppbK2qdLmyBS4UPCGVerQujZR3ea6QFApuywGkbTDA6OHa9M0JeDrnQbhyqxHPx3LA3pZlrgOjct17eKup9vx2LFiBkCAOwrC1unwFOKb7EJOWme6oCMdEBIIQxjyy5UP2K2QbknwYBjDXtuGgSH69VIc8k7zwDom4e71kT+Q7mfULyyvsxJwsOA8zd4xAz+DJGfEt962i4NC1P3HKfZFobw==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DB8P195MB0725.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:144::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Thu, 31 Jul
 2025 11:30:42 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8964.029; Thu, 31 Jul 2025
 11:30:42 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
 "al.kochet@gmail.com" <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 2/5] binman: Fix FIT image overlap issues for
 testFitSplitElf
Thread-Topic: [PATCH v1 2/5] binman: Fix FIT image overlap issues for
 testFitSplitElf
Thread-Index: AQHcAId2kUIqhqg4AEW4yiCzqo9fFrRMHAiA
Date: Thu, 31 Jul 2025 11:30:41 +0000
Message-ID: <919650cef967cb30859bf804ffbf6b826206fdc3.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-3-aristo.chen@canonical.com>
In-Reply-To: <20250729125022.4220-3-aristo.chen@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DB8P195MB0725:EE_
x-ms-office365-filtering-correlation-id: abc4a3e5-3933-4309-57be-08ddd025aeb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aE9aOGxza281RFVRMmlDQ3hGS2NMMytlSWg1bi9MUERFQ2tJSmZpYTBQWUh5?=
 =?utf-8?B?ZGIrZlJYTzIvbzcvZGs1UGVWRFZ2N05pVmJpYWJRZVVKdWs0cFB0SFQ4eG5x?=
 =?utf-8?B?NDFvUVlPV0VIQUc0MVBYZHZCS3p2MjBoUjhsNlV3TTNIRndORnJIeFhMWTM3?=
 =?utf-8?B?WGd4Ym4yM1pPR1dLalVHUEI3azlxUUxNeENLQWtlWEJuUThhWXY1a0ZiWTZK?=
 =?utf-8?B?SDNCMzNVYWQrSVFGdzNXZVJGZi8xNVo0dkV4V1RRcWNWRThRdzlWdWtXTGdH?=
 =?utf-8?B?YkZDWWpickdEN2pOclV6RGVwR2ErWTBzNzJ3Mm91a0M1dGV4SEJlc2k3OUVR?=
 =?utf-8?B?VjNFMUxJVW9hRmtNNG9CdFdTQ1MweFliZmJpZ2dxeGFIUjA4VCtsekRuNytz?=
 =?utf-8?B?dmJ1OExhM0YyME9Vb0Y4U1NFL0t2ZEthdGJyN2ttWGtzQlljSkJrMjQweUVR?=
 =?utf-8?B?OVdLNC9qcDhtc2F1L0dKUmYyaURFMzJqZ0RuTG9GcHRob1RocHduYkJIMkYw?=
 =?utf-8?B?dUxveW50K0RXR1lvTFZaNlJld0d1NStoNHlIL0VROTJ5ZnRTWGhZRGhQSHJm?=
 =?utf-8?B?QmdMUHNmZzRJME1uK0pQbG5xZUJKRlpCa2paYk5VcFhQbmxJRHNTUm5meTdh?=
 =?utf-8?B?NUJNMWFpdzE1cTBvYWV5cktaOUZFa08ySTAzbzFGOUFSMW5xVlN6WXFTZndV?=
 =?utf-8?B?L1RWaUQ4VUlBNjRDMTI2N0VuKzNTTk5JOCtzaW8xcUtyY2tJa1EyTy9lM1V2?=
 =?utf-8?B?Z2FmMTVyUkQxQStRNUNJMmg1RWJMbnU0SkhQK1cwY05FVTJld2xHcjBOR3cz?=
 =?utf-8?B?aU1kVnpQcE1QNVZ5dTZienNEaE5TdW1PY01RMXM4eDMzZ2NHcWc1VTB1Q01h?=
 =?utf-8?B?cHY0UHNqcG1Jbkg5NGp6enl6QktzSWJmcTdEWTJGbWFhN2pMeVlDdTFxeDhY?=
 =?utf-8?B?S0NWQi9ObjkxSElCd0RBaTVKTm5wVXQ5K1FOTHBKZnpaZ1ZmaWh4L2xHMFNz?=
 =?utf-8?B?ZUpKOXpCMDk0RndGeUk4emdENkVxYy9nOFV1Wjc5OWJzS1R4N0xvRTZpaFVF?=
 =?utf-8?B?bjV1cWhiUHJUb3RUQmxUeTNaNFg2UWtxWWdTOVVDZm56cTl0NmFZRkZKMjhx?=
 =?utf-8?B?Y2lTcDExblZ2RCtVRmZSUzhzYWhnQkNUYmhudHM2eXRDeExBbUY0a2Q0UHYw?=
 =?utf-8?B?OHZwcS93OUZES3MvTVN6VEU1eVFES1IvRGVGMGZrdnJYV04zM0lJUjViZFB4?=
 =?utf-8?B?M25GbU1XM3o3Y1RWYTJZZzNFWklWRzlFR3o1M0NSVHU1b1dSRExYM2p1TmRR?=
 =?utf-8?B?dk96cDJyQVh0SmR5TTV6S3E0RHJvbm1pekxSSndjRlVZUUIwYUFpMXlXZU5T?=
 =?utf-8?B?bGdteVUwNTgya0RKWVBWZjBFTURXanByb3NuR1FUWFgvSVdIYlRCSGNuTno5?=
 =?utf-8?B?R0FKWjM0MWFnSklsRFBVdXkwajJOeklJcTY4TWVmZENXeXd2Z3h6bk5qbzBh?=
 =?utf-8?B?dUJ4TWJwckxndWhJTmFkbWpZSDFtbHpDWEo4WXVoRjAwYWdsRXpxalZRTFQx?=
 =?utf-8?B?L2d6M2VBS09EdHk0TjBSUTdFc2ZzYVhwdTJsUmV1MU1SY2ZPb2owVVR5K1M4?=
 =?utf-8?B?SEc0ZVRJZWhOZGlRNkZ1MzFDeEgxZWprZERFdDdiN2JQWVhYV2htYWdmZWc3?=
 =?utf-8?B?UlRNMUVXZDFIVnh1eEdPbUNQR042N2dONTBhV3hDS0lLeEtQT2pyNkMvL3hG?=
 =?utf-8?B?UmJTOG04dFBSY2I2MHcreVQrZnNTTkZITFdGM1JIQWFCenpGeWlQTWJWb1Na?=
 =?utf-8?B?b09xWXVHRmZ1NEI4SjFsb1ExTVQ3VVBocWtCeXBFZlViaTNtL29rUkhKSUll?=
 =?utf-8?B?eHp4MDhjWS9sd1RUampnbXJmbk1haVEzLzRlbHYzK0Fid0F2alNmOTNCcTRa?=
 =?utf-8?B?dHdMb3dyYUROYzkvUUFYZnA0bDNodXcxVU9xdkUxTkNadjVrdzdLVkNMbmZ2?=
 =?utf-8?B?b0Ryd3l6aUhBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JidkxkNzJIZ0ZwQW1nYjZLQTltZXZXYVRwY2JvaHRDelo1QzA3cG5aN2Zx?=
 =?utf-8?B?SC81b0wxNUg5Q0lwSEF4NDlCUTUvMmdEWTBsODQ1K3cxbTh2azNHTEhac0c0?=
 =?utf-8?B?VlVzU2gvNERkUFRTWFV4Vk0xTTR1Yks5ZTFUWkFoOVpDcDRERDRLclU1cFZt?=
 =?utf-8?B?UWNzbXk3WTVlQnlLNmRqWGhscFh1SWZaRS8rZnEwUHR2NDlCaDR2cHBrR2xx?=
 =?utf-8?B?NWQ1eHNaUUUra3NWODJPUkVodGluQUV6UmU2K1lZWWVwNnVma0M2SXRBTUNj?=
 =?utf-8?B?OXpuQTZnb2UvOVg3bUl4alpsRDBzQnVDcCtwZ1ZVV0N3U1NZUm43ZzlUVXNv?=
 =?utf-8?B?MjRmakFyeFczYmt0TVoxRzlBczlaYXVXSDVnWE45OHVJR0Q0aCtEaXRqenhn?=
 =?utf-8?B?elNtUUZ4aHJLT1hYbGhFcDZNdGplbUd4Sjc3RHd3SkpxMzJNRnNoYm5rNVN2?=
 =?utf-8?B?Nnd2N1J2WWZxeEtlRlZBWU9tc1FHVWl3dThBRTMveG95eHl2Kys2N0pqMnNY?=
 =?utf-8?B?MmNqZlRXZmROOVFrWWkrOC84blBTR3RoZmwxTVV3b1pOY2taT0grZTV2eDg2?=
 =?utf-8?B?OGh2eGRMR1BJSG9HN1crZ2U4bWY5Sm1hZ29aWXpXQVlRYXpjTkZ4N2JoY0pD?=
 =?utf-8?B?WHkwMTJTdTNyL2lqdlBFalJRM0dWaWw5Y3BpWlZlK0JmRWtuM0NEVmo2bjZ0?=
 =?utf-8?B?STU2RXN4ZlAzeWNNb0JNdmdWYzlaa25yT2I5SVhZU3JnTGhVZHhOVC9oeHk0?=
 =?utf-8?B?NENERXBsY0QzL2s2SC85YU1ERDdmSEh4Vnk4WndUY0U0TUxDT3crZkFraUNB?=
 =?utf-8?B?RTBDQ3NUUmd3cjlKMmc0Zml6QW4vTnhrR25GekJwRVNzOWVBS1N5WHpneHFn?=
 =?utf-8?B?SkpGM3JmcnROMmEwdjdLMlIwOXlETWtKNHBpVHlQblhIT0l1UEpCd2lYN3E5?=
 =?utf-8?B?YlFJSko0S25LV1gyazZuMGVRM0ZMUFRaVWtnc2R3T0EzN3lpQ2VRQkFLZHEy?=
 =?utf-8?B?VERldmphQ2ZDUnl1VTF1WmlyZHJSTzFWYVhXaDU5ZUZuVEQ4SlRXS3BiTDBX?=
 =?utf-8?B?S292eERoU2pWam92QkpjNTBRRG1vSUtoUVBTRC9mRFY3SXRXRUhTaFFGT3hG?=
 =?utf-8?B?d2RNWkFOOXNuczRkNFRGelRna0thdUZkK1BzZEpqcFdqTE1CdVhMS3lRWkp1?=
 =?utf-8?B?YURRVEdiaFdzSkJvMjgzQm1KZzdrL285Q0FKQ3NvbDJoSHZKOEN6S2tXNTlL?=
 =?utf-8?B?VGwwYy9kQ29CNUZjNHp1OVU2SUJnQk80Y0thNElpcHZUMm9UZ1NKWlowYkRD?=
 =?utf-8?B?YWl2c1NRSEd3Y3hXMS9tYStaNS9CbGZnNG12Wm4rSzNkclNmZGVseklYUXAx?=
 =?utf-8?B?VjRqK21XV2N3enpRS2xTVUczeUVSaEJYTmxkeGFXdUs5d1FFOHRPTk9ML09L?=
 =?utf-8?B?SEhqNkY4enRSQ1E4Y0xaTGIxZ1RaTDc3U1l1VG54eVA3endEak4yZ3FmQUJG?=
 =?utf-8?B?Y3Z3ZG9xSHBub3FmSWR0VG5zUnBCMUZvYXJ3Slc4L1gwVDNhaUtodXdBdGhr?=
 =?utf-8?B?aml2b1o3VG1Mc0g4aklidFo5U2VEdkpaMVlqZzk2Q3o2YUFTUzJxbkdoZWth?=
 =?utf-8?B?ckN6NituT2IvVTQ2aUVFM1VGTDZUNVZ1YXp2NEdoU1ZMeWlhREp5bFo1Z3NN?=
 =?utf-8?B?UWI3c0VGTlUzVmpsaXg2Z3JPQ05WUWZscHB5VlVwVjZtczJSUFBVbEdTNjZu?=
 =?utf-8?B?RWN0Yjl2dDhkV2JQSHVMbUJOQXVKV3Y2cFhzS1FvTmlVcVBPS0FLcTVZdzZX?=
 =?utf-8?B?YUdzS2x2Skp5L2c3Wm9NOTJhalpzYnZuajJMQ3orT2UrNkYrUHVBY25VRVYz?=
 =?utf-8?B?TUptRVNXM2YxQWdaWitZUDBZMkhCYVBFd1VxYUN4YkVHRVlxVTRQYXJYcnBk?=
 =?utf-8?B?QjNFYXIrRU5DSXB2SUlIR1c1Y24vY21MbDQvWjF5WTA3dE1YZUV3OHJxNGJw?=
 =?utf-8?B?SGJCS3FtM2FFUnd3UDhzSXpYbTVrby9DUVBiZ0lNSU8yRlZTaEJ2TWVobWpX?=
 =?utf-8?B?b1A2SmdPdFh0VGVmbnVFZzdJRE01OHErSGJNcERORnhRZC9Tb2tVQ0xOdGpy?=
 =?utf-8?Q?4S1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBE7CE44914CA647A4A044791DF396E6@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: abc4a3e5-3933-4309-57be-08ddd025aeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 11:30:41.9408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3B5kbMpNih1xPplXZHpKoJCX29x5631tb1KfqlynpsLdXY9218yQXbLdEQB0CY+KUVmEyZrQXHWrA6Aevv5n8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0725
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

QW0gRGllbnN0YWcsIGRlbSAyOS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3Rv
IENoZW46Cj4gRml4IG9uZSBiaW5tYW4gdGVzdCB0aGF0IGhhcyBtZW1vcnkgcmVnaW9uIG92ZXJs
YXAgaXNzdWUsIHRoZSB0ZXN0IGNhc2UKPiBuZWVkZWQgdG8gYmUgdXBkYXRlZCB0byB1c2Ugbm9u
LW92ZXJsYXBwaW5nIG1lbW9yeSBsYXlvdXRzLgo+IAo+ICogVGVzdHMgZml4ZWQ6Cj4gwqAgLSB0
ZXN0Rml0U3BsaXRFbGYKPiAKPiAqIENoYW5nZXMgbWFkZToKPiDCoCAxLiBFTEYgc2VjdGlvbiBs
YXlvdXRzOiBhZGRlZCBlbGZfc2VjdGlvbnNfdGVlLmxkcyB3aXRoIGRpZmZlcmVudAo+IMKgwqDC
oMKgIGFkZHJlc3MgZm9yIFRFRSB0byBhdm9pZCBvdmVybGFwIHdpdGggQVRGIGFkZHJlc3MgZGVm
aW5lZCBpbgo+IMKgwqDCoMKgIGVsZl9zZWN0aW9ucy5sZHMKPiDCoCAyLiBNYWtlZmlsZSB0byBw
cm9wZXJseSBidWlsZCBlbGZfc2VjdGlvbnNfdGVlIGJpbmFyeQo+IMKgIDMuIFVwZGF0IGZ0ZXN0
LnB5IHRvIHVzZSBzZXBhcmF0ZSBFTEYgZmlsZXMgZm9yIFRFRSB2cyBBVEYgY29tcG9uZW50cwo+
IMKgwqDCoMKgIGluIHNwbGl0LWVsZiBvcGVyYXRpb25zLgo+IAo+IEFuIHVwY29taW5nIGNvbW1p
dCB3aWxsIHZhbGlkYXRlIGlmIHRoZSBtZW1vcnkgcmVnaW9uIGlzIG92ZXJsYXBwZWQKPiAKPiBT
aWduZWQtb2ZmLWJ5OiBBcmlzdG8gQ2hlbiA8YXJpc3RvLmNoZW5AY2Fub25pY2FsLmNvbT4KUmV2
aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgoKPiAtLS0KPiDCoHRvb2xz
L2Jpbm1hbi9mdGVzdC5wecKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Ky0KPiDCoHRvb2xzL2Jpbm1hbi90ZXN0L01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCA2ICsrKystCj4gwqB0b29scy9iaW5tYW4vdGVzdC9lbGZfc2VjdGlvbnNfdGVlLmPCoMKg
IHzCoCAxICsKPiDCoHRvb2xzL2Jpbm1hbi90ZXN0L2VsZl9zZWN0aW9uc190ZWUubGRzIHwgMzEg
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoDQgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiDCoGNyZWF0ZSBtb2RlIDEyMDAwMCB0b29scy9iaW5t
YW4vdGVzdC9lbGZfc2VjdGlvbnNfdGVlLmMKPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9i
aW5tYW4vdGVzdC9lbGZfc2VjdGlvbnNfdGVlLmxkcwo+IAo+IGRpZmYgLS1naXQgYS90b29scy9i
aW5tYW4vZnRlc3QucHkgYi90b29scy9iaW5tYW4vZnRlc3QucHkKPiBpbmRleCBhOTBkYjNjOTM1
MS4uZjBjMDQ4NzMwMGQgMTAwNjQ0Cj4gLS0tIGEvdG9vbHMvYmlubWFuL2Z0ZXN0LnB5Cj4gKysr
IGIvdG9vbHMvYmlubWFuL2Z0ZXN0LnB5Cj4gQEAgLTI1Miw3ICsyNTIsNyBAQCBjbGFzcyBUZXN0
RnVuY3Rpb25hbCh1bml0dGVzdC5UZXN0Q2FzZSk6Cj4gwqDCoMKgwqDCoMKgwqDCoCBUZXN0RnVu
Y3Rpb25hbC5fTWFrZUlucHV0RmlsZSgnYmwzMS5lbGYnLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0b29scy5yZWFkX2ZpbGUoY2xzLkVsZlRlc3RGaWxlKCdlbGZfc2VjdGlvbnMnKSkpCj4g
wqDCoMKgwqDCoMKgwqDCoCBUZXN0RnVuY3Rpb25hbC50ZWVfZWxmX3BhdGggPQo+IFRlc3RGdW5j
dGlvbmFsLl9NYWtlSW5wdXRGaWxlKCd0ZWUuZWxmJywKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0b29scy5yZWFkX2ZpbGUoY2xzLkVsZlRlc3RGaWxlKCdlbGZfc2VjdGlvbnMnKSkpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9vbHMucmVhZF9maWxlKGNscy5FbGZUZXN0RmlsZSgnZWxm
X3NlY3Rpb25zX3RlZScpKSkKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgIyBOZXdlciBPUF9URUUg
ZmlsZSBpbiB2MSBiaW5hcnkgZm9ybWF0Cj4gwqDCoMKgwqDCoMKgwqDCoCBjbHMubWFrZV90ZWVf
YmluKCd0ZWUuYmluJykKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFuL3Rlc3QvTWFrZWZpbGUg
Yi90b29scy9iaW5tYW4vdGVzdC9NYWtlZmlsZQo+IGluZGV4IDRkMTUyZWVlOWMwLi42NjI3OWUw
ZTIwNyAxMDA2NDQKPiAtLS0gYS90b29scy9iaW5tYW4vdGVzdC9NYWtlZmlsZQo+ICsrKyBiL3Rv
b2xzL2Jpbm1hbi90ZXN0L01ha2VmaWxlCj4gQEAgLTMwLDEyICszMCwxMyBAQCBMRFNfQklOTUFO
X0JBRCA6PSAtVCAkKFNSQyl1X2Jvb3RfYmlubWFuX3N5bXNfYmFkLmxkcwo+IMKgTERTX0JJTk1B
Tl9YODYgOj0gLVQgJChTUkMpdV9ib290X2Jpbm1hbl9zeW1zX3g4Ni5sZHMKPiDCoExEU19CSU5N
QU5fRU1CRUQgOj0gLVQgJChTUkMpdV9ib290X2Jpbm1hbl9lbWJlZC5sZHMKPiDCoExEU19FRkxf
U0VDVElPTlMgOj0gLVQgJChTUkMpZWxmX3NlY3Rpb25zLmxkcwo+ICtMRFNfRUZMX1NFQ1RJT05T
X1RFRSA6PSAtVCAkKFNSQyllbGZfc2VjdGlvbnNfdGVlLmxkcwo+IMKgTERTX0JMT0IgOj0gLVQg
JChTUkMpYmxvYl9zeW1zLmxkcwo+IMKgCj4gwqBUQVJHRVRTID0gdV9ib290X3Vjb2RlX3B0ciB1
X2Jvb3Rfbm9fdWNvZGVfcHRyIGJzc19kYXRhIGJzc19kYXRhX3plcm8gXAo+IMKgCXVfYm9vdF9i
aW5tYW5fc3ltcyB1X2Jvb3RfYmlubWFuX3N5bXMuYmluIHVfYm9vdF9iaW5tYW5fc3ltc19iYWQg
XAo+IMKgCXVfYm9vdF9iaW5tYW5fc3ltc19zaXplIHVfYm9vdF9iaW5tYW5fc3ltc194ODYgZW1i
ZWRfZGF0YSBcCj4gLQl1X2Jvb3RfYmlubWFuX2VtYmVkIHVfYm9vdF9iaW5tYW5fZW1iZWRfc20g
ZWxmX3NlY3Rpb25zIGJsb2Jfc3ltcy5iaW4KPiArCXVfYm9vdF9iaW5tYW5fZW1iZWQgdV9ib290
X2Jpbm1hbl9lbWJlZF9zbSBlbGZfc2VjdGlvbnMKPiBlbGZfc2VjdGlvbnNfdGVlIGJsb2Jfc3lt
cy5iaW4KPiDCoAo+IMKgYWxsOiAkKFRBUkdFVFMpCj4gwqAKPiBAQCAtODQsNiArODUsOSBAQCBi
bG9iX3N5bXM6IGJsb2Jfc3ltcy5jCj4gwqBlbGZfc2VjdGlvbnM6IENGTEFHUyArPSAkKExEU19F
RkxfU0VDVElPTlMpCj4gwqBlbGZfc2VjdGlvbnM6IGVsZl9zZWN0aW9ucy5jCj4gwqAKPiArZWxm
X3NlY3Rpb25zX3RlZTogQ0ZMQUdTICs9ICQoTERTX0VGTF9TRUNUSU9OU19URUUpCj4gK2VsZl9z
ZWN0aW9uc190ZWU6IGVsZl9zZWN0aW9uc190ZWUuYwo+ICsKPiDCoGNsZWFuOgo+IMKgCXJtIC1m
ICQoVEFSR0VUUykKPiDCoAo+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vdGVzdC9lbGZfc2Vj
dGlvbnNfdGVlLmMKPiBiL3Rvb2xzL2Jpbm1hbi90ZXN0L2VsZl9zZWN0aW9uc190ZWUuYwo+IG5l
dyBmaWxlIG1vZGUgMTIwMDAwCj4gaW5kZXggMDAwMDAwMDAwMDAuLjAxYjIwMGEzNjVlCj4gLS0t
IC9kZXYvbnVsbAo+ICsrKyBiL3Rvb2xzL2Jpbm1hbi90ZXN0L2VsZl9zZWN0aW9uc190ZWUuYwo+
IEBAIC0wLDAgKzEgQEAKPiArZWxmX3NlY3Rpb25zLmMKPiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9m
IGZpbGUKPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFuL3Rlc3QvZWxmX3NlY3Rpb25zX3RlZS5s
ZHMKPiBiL3Rvb2xzL2Jpbm1hbi90ZXN0L2VsZl9zZWN0aW9uc190ZWUubGRzCj4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAwMC4uNTAxZDg1YTFmNjgKPiAtLS0gL2Rldi9u
dWxsCj4gKysrIGIvdG9vbHMvYmlubWFuL3Rlc3QvZWxmX3NlY3Rpb25zX3RlZS5sZHMKPiBAQCAt
MCwwICsxLDMxIEBACj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLwo+
ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTYgR29vZ2xlLCBJbmMKPiArICovCj4gKwo+ICtP
VVRQVVRfRk9STUFUKCJlbGYzMi1pMzg2IiwgImVsZjMyLWkzODYiLCAiZWxmMzItaTM4NiIpCj4g
K09VVFBVVF9BUkNIKGkzODYpCj4gK0VOVFJZKF9zdGFydCkKPiArCj4gK1NFQ1RJT05TCj4gK3sK
PiArCS4gPSAweDAwMTAwMDEwOwo+ICsJX3N0YXJ0ID0gLjsKPiArCj4gKwkuID0gQUxJR04oNCk7
Cj4gKwkudGV4dCA6Cj4gKwl7Cj4gKwkJKigudGV4dCopCj4gKwl9Cj4gKwo+ICsJLiA9IDB4MDAx
MDEwMDA7Cj4gKwkuc3JhbSA6Cj4gKwl7Cj4gKwkJKiguc3JhbSopCj4gKwl9Cj4gKwo+ICsJL0RJ
U0NBUkQvIDogewo+ICsJCSooLmNvbW1lbnQpCj4gKwkJKiguZHluKikKPiArCX0KPiArfQo=
