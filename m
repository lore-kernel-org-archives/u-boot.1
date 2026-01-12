Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3306CD2503B
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 06:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF16839A8;
	Mon, 12 Jan 2026 07:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UaPWyke1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74BD839AC; Mon, 12 Jan 2026 07:50:15 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A048398D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 07:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9p6hxNznfxFTYjO5aFa4irAS1G8gVVnuO4qzkbAPdhKCJhwMaUv6/s2xB9/gyO6+hYH7RCP3TNUV2GhmJHGVFa3N6sVyWhLVbXD7VBkHVPlqcGEMRSuxy1nH36aNTNDednVvvxoqjiibbrq7/GRUKGKIRJfRx/RQen8ucG8xZql0otK7IT9bphVdY7T5n2fu2vL2Q2JO2wbWp5amsLoYo06DOQZx3+obBZB6Kn2z49tDyhBZp6pgUvHkbcAatByA/LBkGfTIt2pCaQzcsWJMGRXPmwFmFSUplcIhnGF5TC/7oocuIfeApNarRv5fwfy7EVqqQF/jim4aSwGeqIzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzQwTa6Wcqts9jxeiNvMtpEcZDpixsE9ngWsUixAzJE=;
 b=WOuZgurOUNyM6YXzkfYFW7HArfaSwnZdqpsTGXVy9f35VWmU1KDWzDP2R+n1S9okC5/9X5qeU87qVW4Ou21h3Ou1XLhtjM0r1WZhmBJLt6FisMR5x58mpt30Ke4lwSpLLu+/Lzf2TYygfOPX38fHfwV22HNuYfNVGMPB1RRtbjy22WraDXcKLyJHZrqxqHaRyDA0+XRUDvHOQAF5ueoZVJAq9F5fdkKAZse1GbIneB5hk3n7PnHj4UytxiTDV+DP3j7km8jFns9v5DktiiiDUM6suKr/frVkdbcJKKbzePvHrlqBTDWBJCICSvlOSDn4welqLir62fWntNVWTBKu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzQwTa6Wcqts9jxeiNvMtpEcZDpixsE9ngWsUixAzJE=;
 b=UaPWyke1xRhF6UjiOAEj/tKb46jdj4j2O7rNlO7SUo65qbaG+gMF1pyqJYsHMunsJ21/IE/UD61ufGnhPbgRO2utUVux5oNZCZyGW3xWY31cMKvROhTsjDHQEPx4009WF/Sjjy5kjdfmkkfKdnFzhvym9ps+FCu1OxYoukNWOe6SZRoHuv/9AS/1PZ7CwGCep7BcLHL1hsnrtqAopSeKqYke0GzHr4G/LmTJmiAwHig2NFP0RkJrlF20xjkLjS1ZSCtaySQ/j8ZrLNKz1vL6wwwkoSrKdbfpxAJpSmc9A0AILlG7MV2pLOZoi1rM2NHGpKEFfkWCKwbM7+rb/fuLyw==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PAWP195MB2177.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:332::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 06:50:11 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::2031:4eaf:9669:3714%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 06:50:11 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Francois Berder <fberder@outlook.fr>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: rauc: Free memory during error handling
Thread-Topic: [PATCH] bootstd: rauc: Free memory during error handling
Thread-Index: AQHcfohvPN1jfAEN/066/ZU9BihTB7VOIlIA
Date: Mon, 12 Jan 2026 06:50:11 +0000
Message-ID: <8bb066181436b2b6061da2a51b651a0fe252542e.camel@phytec.de>
References: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB28050FDFC3929BDBF71ED475DA86A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PAWP195MB2177:EE_
x-ms-office365-filtering-correlation-id: c43b3fca-0cf1-4047-0ebc-08de51a6d51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V0JJQnJsODE0Rm5hQ0xVV1hWVlFKcFRTZlRSZ1NNZFZpU2R1WG96c3dwb2o4?=
 =?utf-8?B?amZuUC9YV1pWd2JmUktUbXpNeit3SnVPa2p1aUFSKzRrNE1OOHJjUktOZlUv?=
 =?utf-8?B?TTNRZytFK2Fya3lhZHlBYVRUVytFWE90SzZxK2VzaHJxajlJNWhuQ2FzWXhi?=
 =?utf-8?B?SGpxblZpeGRMOXpXK2xsTjZGcDU5TnpLZ0dtWUw5bmNPdGxETzNCVjFBVFU4?=
 =?utf-8?B?dktPdStBaWU5ZS9ZY2NTUkFiY29YZTBRZ0hhMmk1V0tDajhnWlVqWGRZM0pm?=
 =?utf-8?B?Z1A1dGFZMHpaZzk3Nkl1WmxpazFaWSttbG5uUzJpTElnMXowYXhjT1hyWThn?=
 =?utf-8?B?Q1c5azVmK1o5SlZJKzBaU3NDTkJHR1YycVV0Y0hFcUJ4aHQ3bkNMOStyTHVK?=
 =?utf-8?B?UnBkOVFodkppbUdjRVBYRXJXVm83SlZmMnNOUU5yQllaL0JUT2ZZWEpzUjFK?=
 =?utf-8?B?c0NSZzAxMVdhSmpUSXpDbnF5MkFGL1d2SldDQmJDSmltcUsrQ1BrN0Z0RU1o?=
 =?utf-8?B?MXMveE85emNoY3Joei9Ca0Nua3J0UWgyS3VXalhOQkJpYklpM1VWZlNORDV0?=
 =?utf-8?B?SWk3YjJ1cUVZMUJEaUZ1UVBvb25UYnNOalc1RWVuNFBxN1Zpalg5S0ZwcHE0?=
 =?utf-8?B?VjNUTkIyN0FZd0ptZlA3TnYvS1VVWWhvUFJ1Z3BKV1VRQkIyK21MOUcvSWtN?=
 =?utf-8?B?dmVuM0Rub1VjWk5KSUhOY0NtVGlYY2pvNUJrQ1dkaUVoTVovZEk2aG04cUNu?=
 =?utf-8?B?TFBLdmk1WWFyalVJTjkxdFd5TFNPVFdobVJPdExhTUh2S0VHWEhTdWxIY2ZZ?=
 =?utf-8?B?Nnh2bEdjdW8zbFZMb2pDN3Q1UDNPb1lFSi9XVy9OV2tiNFZONGh4N0hpWSt4?=
 =?utf-8?B?b3Y2T1BTUWNVRnJjNGhzRzBWYVNpcFh1eGlXZXpvMENzZ1EwcjNHVGhRRC9R?=
 =?utf-8?B?VkZ3aDBTZk5pV2hrVmZ2SUlOVEZTY0RFZUpSUWpVcDE3angrdVFobnRVcVpo?=
 =?utf-8?B?NnhJRC82SEtVVjFoWjI2cjJKUjY1akhjY1RPd01qUGU0aE9mK3RaNDZtVC9M?=
 =?utf-8?B?UWpNWWRIYTZDam56cGIrL05FdTNsNEVOeDJqNGR5Q01EQmhhalVNa05TR0Ft?=
 =?utf-8?B?alM2alNpZmhGK3IrYjZQVGpmSXF0aU9NMEgyTmdCMmdzSytQYWtQdVhUUU5Z?=
 =?utf-8?B?WGE3YStHWkF4VEgyU0hHRjI2bjNCTEI0ZWFScWsvMGlOM0I3blJuMHFYdXhs?=
 =?utf-8?B?dTZZNUxOSzFCV1JJdUptME1jNVkxNGVwc1pQMGE3S05DcFliYkE5OVdZTFdD?=
 =?utf-8?B?MDJGdFlVc1hNNDRENTQ5SG9MQkFMcG13MWhSZmgraWdnMEt5eTE2K0J2TXRa?=
 =?utf-8?B?MU5oV2xzMlNtaWtaUDR4NWJaNkFiZm5EUWFuYlN0cS8zSHJpR1FVTFhaMUFZ?=
 =?utf-8?B?UlVROTUwaEVUREpQcU5wYnpRVmErR1BXdURuRjBUeStYNDZFdWhFUm4xR08z?=
 =?utf-8?B?V1ZxRDFQei9KSGNxaWhSZlE2M3JtN1JKWFB5eGYxODZScTdEQzFBT1lFd25F?=
 =?utf-8?B?UGpJS0hYUW5kRG5sbmlHU2QrT1UrY3Jua3dBckUxWTlWaVpUMHY3SHhXOUdV?=
 =?utf-8?B?SXltckp2MkEvYnNsM3pKc0NUcjE2UzJjQkh1TnFVQitHbVJsbHZ1cDg5QUp6?=
 =?utf-8?B?Y3NOUFlXNE5aSTFxZnR4S2Q4WWg5VGhSdk5wQ3VLM1V6aE9nN2I1d0ZxS3BX?=
 =?utf-8?B?TlkrNC9oRnpEdStXLzR4b3NkZnI1Q285R2RCWktxSElaN3dFZEF4eUlZTDZ0?=
 =?utf-8?B?Wmx3STV5clNwYUxXZkZEMThUUVE5bUJWMzJnMEJlL2JMZkhEWEdkdFVUUFpO?=
 =?utf-8?B?ZjQ5WkdwY0pueDJUSUk3eVMxeHBDWmRzcllpUDV5SmtXSHNPNkpOR2hSK1dQ?=
 =?utf-8?B?VGN1V2tSNFFjekwyUEZ2b1RReVRMbGowRHZsenVDck5wM0hQQ29uMkVnTFYx?=
 =?utf-8?B?cm5ZR2VrczZ1QnhoQXV3T1E1VXA2djF3c3hTdWtSR3BDbU0rQnIxQ0N2R3lt?=
 =?utf-8?Q?0g7JiH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEw3Nlh4citjOUc5ZVdCQTgyWGoxV2FZbnRmcUw3a0RmQVQ4Wm9pazdmWUFM?=
 =?utf-8?B?VStPaUxiNVhRMVNmcm5uODkwaUpTLzFCempSVFlmSkhsR2VJNTN4RnYwdDIr?=
 =?utf-8?B?ZUcydFZTRlp5bUFjdTVNb056UWlDS1RVWkdiRG50OHliTEhXOXp4dlczZkwz?=
 =?utf-8?B?VVJHbDZsQitsMUN3QS9wSUtHcWNaVGt1MXhPdnRaSWtqbWVwY2R1RDQ2SGtw?=
 =?utf-8?B?anJoM1NOOTc0UElDUGk0aVhqQUpaU2haL0daRzJSNnE3M3A2ajJTYmhUWXBx?=
 =?utf-8?B?eXc0MVVabGptamh1U1ZiNkJ3aVBWUGxsWmc4aTBwdUZHM2djRTBzUHJHM0Zj?=
 =?utf-8?B?QjRGNkFpa3UxRGg5Y2llNUZhMHpENncxWHdpZkI1RkZVUUtSQ2tuY0J5R3hp?=
 =?utf-8?B?b1ZHTEwrUjVoa3hMcUVSd2Nla1gxaTRLY1dwUWN6TTVJZjJxb2I3WE13VUJt?=
 =?utf-8?B?OGphNFBBbkUzL3lOdVdjZ0RnQVRYckNzbUY2cUY5dFJTSjF5bVNpYW94SUJD?=
 =?utf-8?B?OW0xMXJ5T252SjVmTTVNNml4WlJ3RXEvRUpsWTEzNGsyNXY4cGlXdE9sVWY3?=
 =?utf-8?B?dTQ1eUNPOXBMVmJHaGJLWmhnc25YREk3cFExMERKc2lzVnJYbVFKR0Exai9F?=
 =?utf-8?B?ZU05cUxsa0dVOVZVU2FVbXMrY1ZkRUhIMTYvNjZWdjJKRnhBTXo5M1ZacVlM?=
 =?utf-8?B?NmtBSTJWM3pJWEh0R0c3ckFCOEh1R1c0QWhNZWdoVzMvNGxCenRoSVUvM1g0?=
 =?utf-8?B?T3BvWGk2K21HdjVEampmcVc0NmVUazJTS0FlQTd4clJCZFFBdzdEQ1B1ZWl1?=
 =?utf-8?B?dEh3Y1FTdFNWQU5McldEaS80MXd5OWlsOW00M2ZNUGxtTWVnM0FjRXpDVVFK?=
 =?utf-8?B?Yys3RWJHV1BPMGlWUmU1OUxWMTZlVCtDYWwvN2FncnBLTkZQcnpHNVhBTDRT?=
 =?utf-8?B?MWp4MTVsUmhUUjJZY0Y1OEZuenl3RkJXaW8wRzBvOUVKN3U4R0dmOUNXaGs5?=
 =?utf-8?B?VGYvN3Y4NnNIQmdLRFNqMkozeGUvUFRsakZRQ2VRTGh1TzFMcFBId1RhMkdx?=
 =?utf-8?B?OWFCWG91NTVXKzVnMUhYaEJpMm4zU0srT01RcHJ5enFlbE5zU3VURmZaZmd0?=
 =?utf-8?B?dlNOT0VQdVh2aGtEODMzY1p3YmozOEtSaWNHNXFCYitqSEsycmZwT0ZKOThE?=
 =?utf-8?B?QVNUR0hKWERrME80OVlJR1cwUFF1bEtINDJSWngzWmhlNGhsYkM1Y3BtMXI1?=
 =?utf-8?B?cU1Bc2k0Q3Z2NDBkTGY4YldJbmRsYWpiNC94YytGNkhuVDUrYmQwRzl5bEkr?=
 =?utf-8?B?eXlBdjA5SzVlcTRXWldGNVUzTFcwUU56V3hnSzhicDdPaFlReUlSTWhtb0sr?=
 =?utf-8?B?b21QcFdxdndWY3Zhd3hNTFBXRUx2d0Y0UWNCUTkweFRRRnowUHhtT0VrLzdT?=
 =?utf-8?B?eHE2RnA2cTZ3L2lXNElSZHBLTUljZEp0OEtMdUtOQ1NNbFNWYWxkV3FzYnI1?=
 =?utf-8?B?bDc5RVhta3hyZXdKVU5Kc21iZHhlYVk1SzA1aWlHc3FmZ1FKdVFING9KTmh0?=
 =?utf-8?B?TnRDVm1TU0NGdEtoQVl5UG1LMVRxZUlZQmZObHVKZEZSQkkyOGJ2UisrYzZP?=
 =?utf-8?B?TG1icExaODBXUWRudlNTRTU2QVQ0bHJ4Z280eUJ6YzBiMUhJS0U4TzJSYjZz?=
 =?utf-8?B?M3Q4ZUgxNjNnTG1PUEU0eVQzZmg4TDVFM29rVVRNRWJpVVpHNE1jTTQxcGNz?=
 =?utf-8?B?ZmdtTU1KUWtnOUdNWWFzS1c3ODE0TzNrZWFPZ055eEFPejFsaWNEeHJVVlVt?=
 =?utf-8?B?TGdieitWRDYxOVZULzBIMFJibGpzelcwVC8xa0lXQ0ZjQk42TGVUMFlHdG5G?=
 =?utf-8?B?blE2S05UOGtsZW5ibXhqNkVYZFpiTFBlMVRKTU1wQVpKU3h4ZEhWV0F2OG1L?=
 =?utf-8?B?ckwxUDdnWTNrenVmcjBrMmtuT3Fzb3VuV0lXa1F5MWpWZ2k1SEIxSFloRlZS?=
 =?utf-8?B?eEtqWjc0Uk9QMGZyY2ZZamRTWFIzMm1LeUs4d2Qzc1o0VGFFSElvbTlyQkJm?=
 =?utf-8?B?aENPT3pCZFprNlo3N3V6TEJNS05CTlhZbUtjRTJObUQzU2Z6RllzZEFDcVZi?=
 =?utf-8?B?WUFvRmVERmsvaXA2UXBaTXJKRU1jVTNaMnB2OFNiTzlid0EwOHA0d0Q2a0s2?=
 =?utf-8?B?VTlYbFRLNnNqaFNsRGxRNTMwLzViLytiSG81Z2p0YU84RXZVejNUVHNTdVZQ?=
 =?utf-8?B?b0c2RTVLVy9FUGozVndVM1hvaWZwZTZCb21GZXl4RU82R29tMUZJUmQ2VnN4?=
 =?utf-8?Q?quAfFzLp4Gl3BYwZ+u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63A87DA02B04984C9C8D9A4B7508B391@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c43b3fca-0cf1-4047-0ebc-08de51a6d51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 06:50:11.4875 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ+g3525cTJDMZPzx3grbVMQk4kqrIny1WVcg7+Ymh8CsmPGjj7q4gNx0Bdi91e24ASVK6R6vT/6OvjbBLWZfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2177
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

SGF2ZW4ndCBoYWQgYSBjaGFuY2UgdG8gdGVzdCB0aGlzIHlldCwgYnV0IExHVE0uCgpBY2tlZC1i
eTogTWFydGluIFNjaHdhbiA8bS5zY2h3YW5AcGh5dGVjLmRlPgoKT24gTW9uLCAyMDI2LTAxLTA1
IGF0IDIxOjI2ICswMTAwLCBGcmFuY29pcyBCZXJkZXIgd3JvdGU6Cj4gV2hpbGUgcmVhZGluZyBi
b290ZmxvdywgbWVtb3J5IHdhcyBub3QgcmVsZWFzZWQgaWYgYW4KPiBlcnJvciBvY2N1cnJlZC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBGcmFuY29pcyBCZXJkZXIgPGZiZXJkZXJAb3V0bG9vay5mcj4K
PiAtLS0KPiDCoGJvb3QvYm9vdG1ldGhfcmF1Yy5jIHwgNTEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tCj4gLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYm9vdC9ib290bWV0aF9y
YXVjLmMgYi9ib290L2Jvb3RtZXRoX3JhdWMuYwo+IGluZGV4IDgzMzcxNWUxMzk1Li40MzJkMTcw
ZTAwNiAxMDA2NDQKPiAtLS0gYS9ib290L2Jvb3RtZXRoX3JhdWMuYwo+ICsrKyBiL2Jvb3QvYm9v
dG1ldGhfcmF1Yy5jCj4gQEAgLTEzOSwxMiArMTM5LDEyIEBAIHN0YXRpYyBpbnQgZGlzdHJvX3Jh
dWNfc2Nhbl9wYXJ0cyhzdHJ1Y3QKPiBib290ZmxvdyAqYmZsb3cpCj4gwqAKPiDCoHN0YXRpYyBp
bnQgZGlzdHJvX3JhdWNfcmVhZF9ib290ZmxvdyhzdHJ1Y3QgdWRldmljZSAqZGV2LCBzdHJ1Y3QK
PiBib290ZmxvdyAqYmZsb3cpCj4gwqB7Cj4gLQlzdHJ1Y3QgZGlzdHJvX3JhdWNfcHJpdiAqcHJp
djsKPiAtCWludCByZXQ7Cj4gKwlzdHJ1Y3QgZGlzdHJvX3JhdWNfcHJpdiAqcHJpdiA9IE5VTEw7
Cj4gKwlpbnQgcmV0ID0gMDsKPiDCoAljaGFyICpzbG90Owo+IMKgCWludCBpOwo+IC0JY2hhciAq
cGFydGl0aW9uczsKPiAtCWNoYXIgKmJvb3Rfb3JkZXI7Cj4gKwljaGFyICpwYXJ0aXRpb25zID0g
TlVMTDsKPiArCWNoYXIgKmJvb3Rfb3JkZXIgPSBOVUxMOwo+IMKgCWNvbnN0IGNoYXIgKmRlZmF1
bHRfYm9vdF9vcmRlcjsKPiDCoAljb25zdCBjaGFyICoqZGVmYXVsdF9ib290X29yZGVyX2xpc3Q7
Cj4gwqAJY2hhciAqYm9vdF9vcmRlcl9jb3B5Owo+IEBAIC0xNzYsMTAgKzE3NiwyMiBAQCBzdGF0
aWMgaW50IGRpc3Ryb19yYXVjX3JlYWRfYm9vdGZsb3coc3RydWN0Cj4gdWRldmljZSAqZGV2LCBz
dHJ1Y3QgYm9vdGZsb3cgKmJmbG93Cj4gwqAJaWYgKCFwcml2KQo+IMKgCQlyZXR1cm4gbG9nX21z
Z19yZXQoImJ1ZiIsIC1FTk9NRU0pOwo+IMKgCXByaXYtPnNsb3RzID0gY2FsbG9jKDEsIHNpemVv
ZihzdHJ1Y3QgZGlzdHJvX3JhdWNfc2xvdCkpOwo+ICsJaWYgKCFwcml2LT5zbG90cykgewo+ICsJ
CWZyZWUocHJpdik7Cj4gKwkJcmV0dXJuIGxvZ19tc2dfcmV0KCJidWYiLCAtRU5PTUVNKTsKPiAr
CX0KPiDCoAo+IMKgCS8qIENvcHkgZGVmYXVsdCBib290X29yZGVyLCBzbyB3ZSBjYW4gbGVhdmUg
dGhlIG9yaWdpbmFsCj4gdW5tb2RpZmllZCAqLwo+IMKgCWJvb3Rfb3JkZXJfY29weSA9IHN0cmR1
cChkZWZhdWx0X2Jvb3Rfb3JkZXIpOwo+ICsJaWYgKCFib290X29yZGVyX2NvcHkpIHsKPiArCQly
ZXQgPSBsb2dfbXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gKwkJZ290byByYXVjX3JlYWRfYm9v
dGZsb3dfZXJyOwo+ICsJfQo+IMKgCXBhcnRpdGlvbnMgPSBzdHJkdXAoQ09ORklHX0JPT1RNRVRI
X1JBVUNfUEFSVElUSU9OUyk7Cj4gKwlpZiAoIXBhcnRpdGlvbnMpIHsKPiArCQlyZXQgPSBsb2df
bXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gKwkJZ290byByYXVjX3JlYWRfYm9vdGZsb3dfZXJy
Owo+ICsJfQo+IMKgCj4gwqAJZm9yIChpID0gMTsKPiDCoAnCoMKgwqDCoCAocGFydHMgPSBzdHJz
ZXAoJnBhcnRpdGlvbnMsICIgIikpICYmCj4gQEAgLTE4OSwxMyArMjAxLDI2IEBAIHN0YXRpYyBp
bnQgZGlzdHJvX3JhdWNfcmVhZF9ib290ZmxvdyhzdHJ1Y3QKPiB1ZGV2aWNlICpkZXYsIHN0cnVj
dCBib290ZmxvdyAqYmZsb3cKPiDCoAkJc3RydWN0IGRpc3Ryb19yYXVjX3Nsb3QgKipuZXdfc2xv
dHM7Cj4gwqAKPiDCoAkJcyA9IGNhbGxvYygxLCBzaXplb2Yoc3RydWN0IGRpc3Ryb19yYXVjX3Ns
b3QpKTsKPiArCQlpZiAoIXMpIHsKPiArCQkJcmV0ID0gbG9nX21zZ19yZXQoImJ1ZiIsIC1FTk9N
RU0pOwo+ICsJCQlnb3RvIHJhdWNfcmVhZF9ib290Zmxvd19lcnI7Cj4gKwkJfQo+IMKgCQlzLT5u
YW1lID0gc3RyZHVwKHNsb3QpOwo+ICsJCWlmICghcy0+bmFtZSkgewo+ICsJCQlmcmVlKHMpOwo+
ICsJCQlyZXQgPSBsb2dfbXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gKwkJCWdvdG8gcmF1Y19y
ZWFkX2Jvb3RmbG93X2VycjsKPiArCQl9Cj4gwqAJCXMtPmJvb3RfcGFydCA9IHNpbXBsZV9zdHJ0
b3VsKHN0cnNlcCgmcGFydHMsICIsIiksCj4gTlVMTCwgMTApOwo+IMKgCQlzLT5yb290X3BhcnQg
PSBzaW1wbGVfc3RydG91bChzdHJzZXAoJnBhcnRzLCAiLCIpLAo+IE5VTEwsIDEwKTsKPiDCoAkJ
bmV3X3Nsb3RzID0gcmVhbGxvYyhwcml2LT5zbG90cywgKGkgKyAxKSAqCj4gwqAJCQkJwqDCoMKg
IHNpemVvZihzdHJ1Y3QKPiBkaXN0cm9fcmF1Y19zbG90KSk7Cj4gLQkJaWYgKCFuZXdfc2xvdHMp
Cj4gLQkJCXJldHVybiBsb2dfbXNnX3JldCgiYnVmIiwgLUVOT01FTSk7Cj4gKwkJaWYgKCFuZXdf
c2xvdHMpIHsKPiArCQkJZnJlZShzLT5uYW1lKTsKPiArCQkJZnJlZShzKTsKPiArCQkJcmV0ID0g
bG9nX21zZ19yZXQoImJ1ZiIsIC1FTk9NRU0pOwo+ICsJCQlnb3RvIHJhdWNfcmVhZF9ib290Zmxv
d19lcnI7Cj4gKwkJfQo+IMKgCQlwcml2LT5zbG90cyA9IG5ld19zbG90czsKPiDCoAkJcHJpdi0+
c2xvdHNbaSAtIDFdID0gczsKPiDCoAkJcHJpdi0+c2xvdHNbaV0gPSBOVUxMOwo+IEBAIC0yMDQs
MTUgKzIyOSwxOSBAQCBzdGF0aWMgaW50IGRpc3Ryb19yYXVjX3JlYWRfYm9vdGZsb3coc3RydWN0
Cj4gdWRldmljZSAqZGV2LCBzdHJ1Y3QgYm9vdGZsb3cgKmJmbG93Cj4gwqAJYmZsb3ctPmJvb3Rt
ZXRoX3ByaXYgPSBwcml2Owo+IMKgCj4gwqAJcmV0ID0gZGlzdHJvX3JhdWNfc2Nhbl9wYXJ0cyhi
Zmxvdyk7Cj4gLQlpZiAocmV0IDwgMCkgewo+IC0JCWRpc3Ryb19yYXVjX3ByaXZfZnJlZShwcml2
KTsKPiAtCQlmcmVlKGJvb3Rfb3JkZXJfY29weSk7Cj4gLQkJcmV0dXJuIHJldDsKPiAtCX0KPiAr
CWlmIChyZXQgPCAwKQo+ICsJCWdvdG8gcmF1Y19yZWFkX2Jvb3RmbG93X2VycjsKPiDCoAo+IMKg
CWJmbG93LT5zdGF0ZSA9IEJPT1RGTE9XU1RfUkVBRFk7Cj4gwqAKPiDCoAlyZXR1cm4gMDsKPiAr
Cj4gK3JhdWNfcmVhZF9ib290Zmxvd19lcnI6Cj4gKwlkaXN0cm9fcmF1Y19wcml2X2ZyZWUocHJp
dik7Cj4gKwlmcmVlKGJvb3Rfb3JkZXJfY29weSk7Cj4gKwlmcmVlKHBhcnRpdGlvbnMpOwo+ICsK
PiArCXJldHVybiByZXQ7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyBpbnQgZGlzdHJvX3JhdWNfcmVh
ZF9maWxlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHN0cnVjdAo+IGJvb3RmbG93ICpiZmxvdywK
