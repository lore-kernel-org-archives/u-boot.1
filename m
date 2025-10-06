Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D2CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 05:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E18807B1;
	Mon,  6 Oct 2025 07:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ags/948g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE6D808AF; Mon,  6 Oct 2025 07:55:03 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A91800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 07:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjKeaIrQKFO8StEEGlk0KreUZ9MANAWkq9QImBHGsgHbOZBXvUNl1TcTizr7BhqfKITY9Z3LL4ka2UHgxflTrc97ucVSRg5RBDygemyBNZCXGedUUMGyY62GUl4QbRhWqt7hLoIUCYBiKQxzfytbGaZFSU7u4LFZkvvYvQzrx0qOF2l0M0ZN7x7ECuajsOhUAe1MAeyaiA5hQYdRchf3sP/odedxSyhiyfH64RKY2GQd26mIYxOlaSfZkSP94AsHhToMob1x5ys1rM8h9s7cTR89S2dQXXW6zU8smivP4DDfjkTOQ6f0ZGupgsGyiN/WRU5tzCoXy4377fmNxI2+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmgt0VPC1J4DqRYMzwvDRlmGGQ6yqY8Yz0OO26b+p5Y=;
 b=TO5Yl4fRc5ZVC/Dz576W/t87l6UKC2LNwuWKSv6z/mC/2SquWE6+erpGH6IMboQ9O7ABf9857rCYqDn9lgqwqecZtkqsc0OqSGeTNasdx0mTvhkF24aTBEEuUeZV0HeGsA+6M0cm+h2VTPwK521VCd6ZFCh8xDlpYDvG5Qd0WaFBmoO9OtilpvZJL3hrVd30n2XBA5Lre7yMKtsbvygx2e9Txxju1GjqTc/ZxRZEXNuO1CDRhxpnS7beM56eYc2QBjHfPolrpdejqcm4soPqyD2ALoFFqKcEesIUrxyYzdsDsZFZAIHBErbLOWsZZy3r1kSEzqwpaywyHtMxFJ40Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmgt0VPC1J4DqRYMzwvDRlmGGQ6yqY8Yz0OO26b+p5Y=;
 b=Ags/948gzy+CvwVejPxQVgs9MyVirI+dQ4EykD1eNUaZ+5vLSZjjizVYIIR9+2h9awvE/XIGSbiANUygUCYXdtwFnTDpmwHVE4VEfztcKhMJVXzAeGpsCKHmgLSbJD42maQoFgH37zP3qedCBg8px6HW4CpbXRo6hHGAYttrzuyWDPbxnhJlsV+faRosKiv5ng0k14cv7m4lbIeVkEg6aItNJJSENVGvSx93YkPLeZAXK/mJOpMR11mGS2l6Trrv3Y1H4Sgi0S5Odhgg62Itjg6+EINvoBoISnCi9OK8O67CVqE/8ZLCkRDuUIx+5VHvHeIkrC1KX9rChixjRtXNug==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by AM0P195MB0467.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:162::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 05:54:55 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 05:54:55 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Andreas Pretzsch <apr@cn-eng.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 2/2] bootstd: rauc: extend and fix doc to reflect real
 flow
Thread-Topic: [PATCH v2 2/2] bootstd: rauc: extend and fix doc to reflect real
 flow
Thread-Index: AQHcM7kh7fdso/yha0maEafZBG2zI7S0pAcA
Date: Mon, 6 Oct 2025 05:54:55 +0000
Message-ID: <5a04bcd44ea1e797cc69b1bd93b7813a3bb96509.camel@phytec.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
 <20251002162506.3908711-1-apr@cn-eng.de>
 <20251002162506.3908711-3-apr@cn-eng.de>
In-Reply-To: <20251002162506.3908711-3-apr@cn-eng.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|AM0P195MB0467:EE_
x-ms-office365-filtering-correlation-id: 6563b928-1f21-4926-be04-08de049cdfe7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OEg4RWJKVGdtcFRrVDRMYmYrbmNRTDlWTTY2aThSbkNyVVYxbWZOQWpaRXpH?=
 =?utf-8?B?Mm8yV3FmaWM3SGM5Y1V4ZjVKUzdnL2s4TGFwNFRYSndoYUlnMDZGR05BNTJy?=
 =?utf-8?B?Sks2N1ZGaXVNaytFMGZVY1d6dDc1ejU3bkl6MGN0M09PWWF2d1ZJMUphU0xx?=
 =?utf-8?B?SmQ4ZmNZc0NFeTZxaHNGRzNzNjRteDZUeGhvQzZyZEFueFBLZTNpNkNBQldP?=
 =?utf-8?B?RE5wU1E3Zm1Nb0NCMkZIYnRadWZQMFlIS2pTVE5vTVplWVZGQlVGNUF0UmxG?=
 =?utf-8?B?K2I0RU4zWVAvbGpiT21iM3QzSlVYYlI2bEc3YTdoRnYza01QZDJNYXMrUU1O?=
 =?utf-8?B?QWZTbXhiQUt0V1RvMStBbUxiTnppaTdiUDkremtYRDNvaUswNmhPR1NaSjNW?=
 =?utf-8?B?SVkwbEhqTjI3SEo4b3lSWjViQjFUc3BXbWtzZEY5YmpDcGhucC9BaHZXS3RG?=
 =?utf-8?B?OHdaK0FET3FsdGRRQWFiWk42V1JvcW8xdTliMFdVZEE0THVyQXR1L3RGaTBT?=
 =?utf-8?B?dW1NcFZPREtEOVhpYlE2b3Z6dTB1a1JndXNhVEI4N1JxanY0VERWMUc3TFh0?=
 =?utf-8?B?aS9aQVd4TnZTM09RNWY0S1FXRjl0MmhpVUxQTEE3RWM5ZzU3NnZta3Q3Uk90?=
 =?utf-8?B?MmRNZDIwRG44RFZwTUdDanhnd1ZOalRaT1h1VU9WMXdudTBNaS9pemxMdVo1?=
 =?utf-8?B?M1ZkdmtvOG1nb3lwSmc1eW9wdDVKUzZJU2dNR3llK0sveUsxcDBUcnlhQ1Rm?=
 =?utf-8?B?cUJhREtzTDNzTGMxbzY1MFZXckplUmREa2c4ZHMvWVZ1SEwweVJ3SnRIKzFl?=
 =?utf-8?B?c0w4dS9VOTk2RXMyR3JFZHhDelNiaWZMNlpzUUoxYmFHNk5YMFhORCtjME0w?=
 =?utf-8?B?T1Q5b3RJODNjV0N4dWl3Z1ZSYW5hUU9XdE5rUmYrS3RUeDIrRmVyQUVYdVVr?=
 =?utf-8?B?eGdXVGpVQjhaSGJBQUlHWkZhaEIvcy8vM1MvYUFYb21Ha3IvdHZzVVdhalBx?=
 =?utf-8?B?V29DT0RqTFBCbWRuRzhWd3dWWUp4bStyNmdacGR1dlhPMUV5cUNPWHNuRjBs?=
 =?utf-8?B?S1NFSGpEbU9QYm00amU3a2xyMWNoSVpzUkd5dlhWdC9Id2c1dGJCOERCSkR3?=
 =?utf-8?B?d0dDVWM0L0YvUUdYQWttem5DS2NUa00zRkRiaTVWK2Z4ZUJkMUd6QTI1T2x6?=
 =?utf-8?B?S3R1N011bHhNck9Za3BudmovdnZUblRJeXJwa1YzVUR4eWxzWG4yc2tqTnpo?=
 =?utf-8?B?c3FFZFJDUjlxTERkNVNwdzlRMU95eWQ2eC94SmZRSlNDMVJRZmp5SlYvV0Zv?=
 =?utf-8?B?M2dBZTUzVFNjRXZBV3NwaGlraG1KeTR1Rlp5dWxHY2JWL3hpenREbUhYR01C?=
 =?utf-8?B?SldrVGlhY05BU2JZWlNheGZJK3ZVUURtbWE0MGQwU1hKdFlXSzZXMVFtMDdv?=
 =?utf-8?B?V3BRRHA5T0ZXOEhxbk1JUDQ0VUlaUUFKck5TaGFwQ3EzNUZKTnllSXE4V2Iy?=
 =?utf-8?B?TG9Tclp3cGF0L3g1UkloRmdKME1DQnFDdU9mK2cyYkkvVEtBRldwOXhmVnFC?=
 =?utf-8?B?b2E4MlBGSTFsb2diR25JWDFJVit6STRETjZuaytRaXdZZVVwRnB5c05sVWNv?=
 =?utf-8?B?ZFFxYW1TbjR1alF5c3ZJamRlWkNrLzhOMkRPZjFnWnFEQWRTVW05TThaS2Jr?=
 =?utf-8?B?dXVNK2dEc242VCtiRCtpODJGbGhvWnBUcGpSZ21rek5tZVRnVDM0NStUOHY0?=
 =?utf-8?B?ekxQZ1BUTWZ3cm4vNmZTNHFUZ3IyYW56a1UycDRmWFVLVlRGdmFWUHlpTzVy?=
 =?utf-8?B?a0hDY0FnZ0RDQ29VTzdYQ2VlUDdIUHoxampsODMzbVNPWUxkN2JTSTZDbzVh?=
 =?utf-8?B?UjJhQXk3TVcvYlgwaGtRMWtiY3p1ei9OOWdsT3ZaN212U1RNZ1Z1T1p6d29S?=
 =?utf-8?B?QmZVb3VOMnlnMVlFWGdYZW1ORTc0Z0o4bElPRFFMdFJScFkrS0tsREpiWnFv?=
 =?utf-8?B?cXovR25sN3NVQkhXd2VEUXZaMGROZktSY1g0NEVUZzZTZ1NtbUZzWlU5Z0Qz?=
 =?utf-8?Q?Hr78Dd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b05rdW1Ddmd6cWJOUHFpcHh5VkY5WjJzMjU4RlIvNER6dTJVem9lZmNmTm8x?=
 =?utf-8?B?NlN1Z2hGWnpRRXl3ck1WcUtwbTF1N0FHa0tOaG0yTWsvNGF3VWMvbDFpSGV6?=
 =?utf-8?B?SlJMWmFrK0YzeGRLV0s3bno3eU5KcDJ2YVpQTFNtaGNRWVVjamdlR0g0am1h?=
 =?utf-8?B?R2tkTm1KcldEWHhvZy9UWGwvbjdleDI2UnhRY3FacXR3eXdaRHB4YzhzYTZ5?=
 =?utf-8?B?SjVyd3BWcEk4ZFlnL1FLams2bWdtNVVLaTdNVWJPeTlzMFZlZ2JBbEx0R1k3?=
 =?utf-8?B?VkI0ZVBmT2NDTGlUSGZleDN4bjN3UkVpZEYrYzlLVnAvTndmZ1hFSUYwOE5u?=
 =?utf-8?B?aHVFTjI0SFRUZzZHTGlvTk9qREJzVHJwTHRqaU8zQTZ1alRiNXZVcXA0YnEr?=
 =?utf-8?B?KzFzZ1hJUDhjT3pSYzA2VFcvN2JVZnRqMjk2MVc3dDhseGthMDJ0dTlKc2RH?=
 =?utf-8?B?QnF2aTNGdjgwaTNpUDZJL1BRTjVldXBXNDdPejBnUmpITWY0amJrajRPTXBz?=
 =?utf-8?B?L241cngyUmhTQXhLcmttam52dHh6WUIwVE5CYTRscWlPMlBqdDJ0bENRTjFx?=
 =?utf-8?B?SnovSDZqeGpMSG5LYUordWJTMFpLUUlGQVc3aVJIRVJGQllSOUhqVEZwQTNM?=
 =?utf-8?B?WTg5MDRPalNaOWZ5NVlncEtacW5vRC9IRTFoV08vbTN1b0VGejQ0bXVzaTE3?=
 =?utf-8?B?NmJwOUJiOVBBZWNxZUJLa09qMnVYbkRRV0w2V1NqZW1IYW9NTTV6QVN0cml1?=
 =?utf-8?B?bXF1bDNQeTJ6bTk0aDdUR1F4VjZZa3J1VWRCc0RzSXN0Yko4Y2g2NTl6bEpi?=
 =?utf-8?B?cVlPU3RNT2FlVnpmckxneW1wVXNWVE82YXhRa2JrL3NSZG9Jd3NKTHJTVkRz?=
 =?utf-8?B?ejZnTURDaVAxRkR6M2k3eHpLNGVlRit2SkxRd2syTExQKzh3TVkyL1ZHRVZL?=
 =?utf-8?B?YW4rc0NsNFJZaHloVGVPaUpVbnV2UDUxU21jRHV5YlhxbjhNb3htMmt6bFFs?=
 =?utf-8?B?ZTAwWGVVZlBua25hN0x3eTI1UEllMFZtUU1WSnMzdWxGYjBkM1kweEE2bjZP?=
 =?utf-8?B?TFllM3JiUlhnSHpGUGlpRFg2NXc1dndxOWhETXNBVE01TnppMGxkaDJHWlda?=
 =?utf-8?B?aHVwUDBLS2paZnFqeFptNnU3ZWs1eE1aVTVPckJRY2FnZmowRDl1NVhMZGlq?=
 =?utf-8?B?dHozSldHZ3F2aWh1WG9yZmY1WGZveCtZNFllWng1c3VsTFZ1aEZ1Mi96ZHZ0?=
 =?utf-8?B?RHVKN3ZJajNud01JekR1N0NDcnI3NjZROUppOE5telRIUXY1STlUOUNTTEZO?=
 =?utf-8?B?QXVRVG4zV3ZlSjhUUXA1UGxqL01jbnNXb2ltcjNKbmVmUTlpamNGbVNnS2Fy?=
 =?utf-8?B?RXFRRDhHb2RhUE1GVk11Q0ROM2xqdURMMmRWZVVOTWFzOThPbVVJSUZpWE9S?=
 =?utf-8?B?d3JjSnJCVTFadUVMa3VNUm03Z1pHZnRYbE5zRWJWdnlHWE5sMlFRYlVUZkpo?=
 =?utf-8?B?bURVOTRMOFV3QzhRTDkzME02djFSTmJLd29wS1RCN3gvZkpOYlJCcVdSUU01?=
 =?utf-8?B?WncrL2hFdlRNM2h4V3dwZ0tnZzBtZ2JZZXVBNUpPZ2svUzQ2eEZybTlleDNn?=
 =?utf-8?B?eHJOZWk1VHVoQ2N0ZklrcUlrRHJCV2s4ZXcxemRoODVnRm1hQXZZU0t4MUdE?=
 =?utf-8?B?ZjIrV216cXNyOTlUSExYYkNkWk55bDZBS2hVK3hRME94ZkZaTExneFU3cS90?=
 =?utf-8?B?bkg3dzZFaDdQQzduNTIweERxUnpqMEh0M2orQlMxMGhmMlFVY3lQYlNkODFV?=
 =?utf-8?B?bWJGNnNDeDZOcTZEVitaUzg1elU5aE9rcDFGeWsrTG1SRzlCQzBSNXc4VHdM?=
 =?utf-8?B?RTQ3dnF2QkpGemo0c3Y0RmZVVjY2azZ4eTBzODd0RlhHd2I3TUx6N0luekRl?=
 =?utf-8?B?TmZacUU3RDFWM0ZGVHdJWWNJR1Vzc0tHNVNnbXAya3JFNzkwb29odC84RzZV?=
 =?utf-8?B?bHhNWk5NWlBTTmlVUXVTM1BJQlNZNzNJY0xkMEdxVzBiMGg3ZlJkZHVyekNY?=
 =?utf-8?B?Y3lxWFhBaXpuT2FOUWZTbVR6V25qSVhkQUs3MWpyM29QZkJBcWRNdXZNWjBs?=
 =?utf-8?Q?8BhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A57F3F3B4E49844B8BE3616ABB3BCAE@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6563b928-1f21-4926-be04-08de049cdfe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 05:54:55.0535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAAhe/Kn9FrXpo9UeD3QOh8KVzeJrw06xemob3B8eShFEgECKIIQdHma2Vow/QEG8nngsq6aA23iXvlRoEe7AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0467
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

UmV2aWV3ZWQtYnk6IE1hcnRpbiBTY2h3YW4gPG0uc2Nod2FuQHBoeXRlYy5kZT4KCk9uIFRodSwg
MjAyNS0xMC0wMiBhdCAxODoyNCArMDIwMCwgQW5kcmVhcyBQcmV0enNjaCB3cm90ZToKPiBUaGUg
ZG9jdW1lbnRhdGlvbiBvZiBib290bWV0aCByYXVjIGluIHNvbWUgYXNwZWN0cyBkb2VzIG5vdCBy
ZWZsZWN0Cj4gdGhlCj4gcmVhbCBwcm9ncmFtIGZsb3cuIFNwZWNpZmljYWxseSB0aGUgcmVzZXQg
b2YgYm9vdCB0cmllcyBpbiBjYXNlIG9mCj4gIm5vCj4gbW9yZSBzbG90cyBmb3VuZCIgaXMgaW5j
b3JyZWN0IChpdCB3b24ndCBjaGFuZ2UgQk9PVF9PUkRFUikuCj4gQWxzbyB0aGUgc2VhcmNoIHNl
cXVlbmNlIGZvciBib290IHNjcmlwdHMgd2FzIG1peGVkIGFuZCBpbmNvbXBsZXRlLgo+IEZpeCB0
aGVzZSBwb2ludHMgaW4gdGhlIGRvY3VtZW50YXRpb24uCj4gCj4gRXhwbGFpbiB0aGUgaW5pdGlh
bCBzZXR1cCBvZiBhbnkgbWlzc2luZyBCT09UX09SREVSIGFuZCBCT09UX3hfTEVGVAo+IGVudmly
b25tZW50IHZhcmlhYmxlcywgYW5kIGluZm9ybSBhYm91dCBCT09UX3hfTEVGVCBkZWNyZW1lbnRp
bmcuCj4gCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBQcmV0enNjaCA8YXByQGNuLWVuZy5kZT4K
PiAtLS0KPiBDaGFuZ2VzIGZvciB2MjoKPiDCoCAtIHJlcGhyYXNlIGFuZCBmaXggZm9ybWF0dGlu
ZyBiYXNlZCBvbiBmZWVkYmFjayBmcm9tIE1hcnRpbiBTY2h3YW4KPiAKPiDCoGRvYy9kZXZlbG9w
L2Jvb3RzdGQvcmF1Yy5yc3QgfCAxOSArKysrKysrKysrKysrLS0tLS0tCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
ZG9jL2RldmVsb3AvYm9vdHN0ZC9yYXVjLnJzdAo+IGIvZG9jL2RldmVsb3AvYm9vdHN0ZC9yYXVj
LnJzdAo+IGluZGV4IGIyNjYxZDE4ZGE0Li41YWZkNzA1ZGNiMSAxMDA2NDQKPiAtLS0gYS9kb2Mv
ZGV2ZWxvcC9ib290c3RkL3JhdWMucnN0Cj4gKysrIGIvZG9jL2RldmVsb3AvYm9vdHN0ZC9yYXVj
LnJzdAo+IEBAIC0yMSwxNCArMjEsMjEgQEAgd2l0aCB0aGUgbGVmdCBvbmUgdHJpZWQgZmlyc3Qu
Cj4gwqBUaGUgZGVmYXVsdCBudW1iZXIgb2YgYm9vdCB0cmllcyBvZiBlYWNoIHNsb3QgaXMgc2V0
IGJ5Cj4gwqBgYENPTkZJR19CT09UTUVUSF9SQVVDX0RFRkFVTFRfVFJJRVNgYC4KPiDCoAo+IC1J
biBjYXNlIG5vIHZhbGlkIHNsb3QgY2FuIGJlIGZvdW5kIGFuZC9vciBhbGwgc2xvdHMgaGF2ZSB6
ZXJvIHRyaWVzCj4gbGVmdCwgdGhlCj4gLWJvb3Qgb3JkZXIgYW5kIHNsb3QgdHJpZXMgYXJlIHJl
c2V0IHRvIHRoZWlyIGRlZmF1bHQgdmFsdWVzLCBpZgo+IC1gYENPTkZJR19CT09UTUVUSF9SQVVD
X1JFU0VUX0FMTF9aRVJPX1RSSUVTYGAgaXMgZW5hYmxlZC4gVGhpcwo+IHByZXZlbnRzIGEgc3lz
dGVtCj4gLWZyb20gbG9ja2luZyB1cCBpbiB0aGUgYm9vdGxvYWRlciBhbmQgdHJpZXMgYm9vdGlu
ZyBhZ2FpbiBhZnRlciBhCj4gc3BlY2lmaWVkCj4gLW51bWJlciBvZiB0cmllcy4KPiArSWYgYGBC
T09UX09SREVSYGAgZG9lcyBub3QgZXhpc3QgaW4gZW52aXJvbm1lbnQsIGl0IHdpbGwgYmUgY3Jl
YXRlZAo+IGFuZCBzZXQgdG8KPiArYGBDT05GSUdfQk9PVE1FVEhfUkFVQ19CT09UX09SREVSYGAu
wqAgSWYgYW55IGBgQk9PVF94X0xFRlRgYCAoZm9yCj4gZXhhbXBsZQo+ICtgYEJPT1RfQV9MRUZU
YGAgYW5kL29yIGBgQk9PVF9CX0xFRlRgYCkgZG9lcyBub3QgZXhpc3QgaW4KPiBlbnZpcm9ubWVu
dCwgaXQgd2lsbAo+ICtiZSBjcmVhdGVkIGFuZCBzZXQgdG8gYGBDT05GSUdfQk9PVE1FVEhfUkFV
Q19ERUZBVUxUX1RSSUVTYGAuCj4gKwo+ICtJZiBgYENPTkZJR19CT09UTUVUSF9SQVVDX1JFU0VU
X0FMTF9aRVJPX1RSSUVTYGAgaXMgZW5hYmxlZCwgYW5kIG5vCj4gdmFsaWQgc2xvdAo+ICtpcyBm
b3VuZCAoYWxsIHNsb3RzIGluIGBgQk9PVF9PUkRFUmBgIGhhdmUgYGBCT09UX3hfTEVGVGBgIHNl
dCB0bwo+IDApLCAqYWxsKiBzbG90Cj4gK3RyaWVzIGFyZSByZXNldCB0byB0aGVpciBkZWZhdWx0
IHZhbHVlcy7CoCBUaGlzIHByZXZlbnRzIGEgc3lzdGVtCj4gZnJvbSBsb2NraW5nIHVwCj4gK2lu
IHRoZSBib290bG9hZGVyIGFuZCB0cmllcyBib290aW5nIGFnYWluIGFmdGVyIGEgc3BlY2lmaWVk
IG51bWJlcgo+IG9mIHRyaWVzLgo+ICsKPiArSWYgYSB2YWxpZCBzbG90IGlzIGZvdW5kLCBpdHMg
TEVGVCB2YWx1ZSBpbiBlbnZpcm9ubWVudCBpcwo+IGRlY3JlbWVudGVkIGJ5IDEuCj4gwqAKPiDC
oFRoZSBib290IHNjcmlwdCBtdXN0IGJlIGxvY2F0ZWQgaW4gZWFjaCBib290IHBhcnRpdGlvbi4g
VGhlIGJvb3RtZXRoCj4gc2VhcmNoZXMKPiAtZm9yICJib290LnNjci51aW1nIiBmaXJzdCwgdGhl
biAiYm9vdC5zY3IiIGlmIG5vdCBmb3VuZC4KPiArZm9yIGBgYm9vdC5zY3JgYCBmaXJzdCwgdGhl
biBgYGJvb3Quc2NyLnVpbWdgYCBpZiBub3QgZm91bmQuIEl0IHdpbGwKPiBzZWFyY2ggaW4KPiAr
YWxsIGRpcmVjdG9yaWVzIG9mIHRoZSBib290c3RkIGxpc3Qgb2YgcHJlZml4ZXMgKGBgIi8iLCAi
L2Jvb3QiYGAgYnkKPiBkZWZhdWx0KS4KPiDCoAo+IMKgV2hlbiB0aGUgYm9vdGZsb3cgaXMgYm9v
dGVkLCB0aGUgYm9vdG1ldGggc2V0cyB0aGVzZSBlbnZpcm9ubWVudAo+IHZhcmlhYmxlczoKPiDC
oAo=
