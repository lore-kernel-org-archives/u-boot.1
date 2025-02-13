Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C677C021A7
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBE4807C0;
	Thu, 13 Feb 2025 08:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZZWsjrx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9E9806FE; Thu, 13 Feb 2025 08:15:09 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E2780C7E
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugb4Dd2tvS25FE9dYNbEGjjyGJhPtHQZl2gnBpvcuGUk9LuadAWGyrT6/Y/LwrYWX6DZgJofO/JT9Dc1s+whRcm11oXyuwBq5qAnyS6hozoaAFajFqFfVlx+y+6T9+ZaNhQ90xxwtIVzgDjLCmlGj1J/Kgv/me2EkdO3KqWZdnZlbGAXqQKEzcXFj5INIc1f1V3P0mUQyZGehV7I8oha1RD20w3KC4n40v7LhNxr+RWs14JHS4N3Dh27eBLX80qD+0B+vEjidRSMt+NNO0c/maUKAQyoRgyTfNTNTjzE8bfgX5/YM9KhxSZ+q/pwD9BCBoz7vAiyQvevg+buMUCN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5RbsrKCZ02KwLzFXyqy7JLCQ2Zpp/bPb2wQEpIatOQ=;
 b=l9/mujVYFa3NUQYMFU4MswKvNp0iq2AleB1L8/VW37FFwM9ORa6BBwc7GfgtCI9Lb8UPf1n/izIZVPROCjmmDNwkiXGpyX7mkbgImCvqjKIQzOCI+rrV1Oxa8zp0u1mXs1ztP2JTSrbmG+I0TIWIJVOrvMoE0nR0X6dWhOF0/oZ95oYqmqKkSMLP9VQScKpzeB3UqVOht4TFTRxQ+4vbAPqc1hZuEI9bn8VOchYIUEWwGyDDlA/pHHmhIq5j1lv2o2rL+TKtMySXst2ygOEg+YqJM6WXmOFBvrdSJyrVB5kB69PWHt7hPqsz5Q7VvuSE6H81qA7rTHE8mvii2WUssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5RbsrKCZ02KwLzFXyqy7JLCQ2Zpp/bPb2wQEpIatOQ=;
 b=ZZWsjrx/OQfhBi/gpFDXa6yiObpct3yVjct/TbAjIaQbCrUAJ0IFP1vo50VqkgsX38Wp0dBibNCmhPB/orwgB6cEBfR3N7M90BufLj3LFoxWd+mb3j8Cn8wpfhUIfEbZeNWg+TUlkJH7+dWI/CImcu+tI5/t8DtKxp909adDvnKjxNvR5WdluVr90ObjojlA0tUnIdBTdJnLxPssEvjMottyGJL0txa1ep3fSlHZgfajRB+N0c/Ukwvh2bnbdSdtdeKoASF++K+MZ/7vGuq3SkGwhlO5wxN7f62wuT4ZHa8x0Z9uQwSh+lL6jSy7VUj0nn6BpOraPuPZyfTfDmMhbQ==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by PR3P195MB0667.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 07:15:05 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:15:05 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Topic: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Index: AQHbcjjJSp861GWIK0W4zSUZ00TyrLNAlNqAgARUtoA=
Date: Thu, 13 Feb 2025 07:15:05 +0000
Message-ID: <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
 <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
In-Reply-To: <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|PR3P195MB0667:EE_
x-ms-office365-filtering-correlation-id: 3522bbd4-9f8a-4631-dd5c-08dd4bfe2411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmRYWUtHcTRwa3ExTkU1cnZLei95K3B6dzlZOWFMRE83elcwSTh3NWhBV0xt?=
 =?utf-8?B?RzNYdkJWVTVxUGFxYTVVdDlKSmZkZktXNE9GT3RBRWI2S3prTXQ0cHpQbWlS?=
 =?utf-8?B?S05MM3lIajBNeHlFMk95Vmx1dE54aWRsSWdTRWhScVlTa1dYYjJCL2JzVUxw?=
 =?utf-8?B?RE16eFgzT2txVGtjVHphVkdQQnZtS1NqMzdDMzJWTlQ2REMxK0FDOEFvQ0lW?=
 =?utf-8?B?TzlWdUl3L3QrS0hHRmJQMzdrcjVWSlkwenpoanVmUGd1M1RCL1VYRkE1ZVYw?=
 =?utf-8?B?L1ZpYTB2aEk1bWlocVprVHUraEo4RU10Z0FRQkdIeDJYQVpsTlAvekw1eWV4?=
 =?utf-8?B?N3V1WEFPOUp1cnB0SG5DcWVSaVJPanJuMjE5WjR4QStrME9nR2JnVmEyQ2RB?=
 =?utf-8?B?WnhXakM2aUVTYjdMSDFCTXVFNHpsZ0h5bTFjTXJXTXF2Q3A2ZFBMK09JQ3dJ?=
 =?utf-8?B?ZFROSlRnVmpXOUpsOUR2VFlORmYvMkZHeUMySkZPcmZJak5MSXhvT290SHBl?=
 =?utf-8?B?MWloUld6M0orWWQwV3poSXZTc2JKSko1dVRKZWpKUkwyOFRtZGNTb0kvRjFG?=
 =?utf-8?B?cXZScEZxV2phUFlpdkF3WVRrZGlJc3VPbWp4TSsvTTNiVnMrQ01xUzVZazF4?=
 =?utf-8?B?bWtPNmlhbHhmbmkwQXdiazRkNWFRWmpIWmNjZm80QnJ2c0hWZU1Ya1JPWjM0?=
 =?utf-8?B?ajJ2dDZjM0ZtOW1zRGpUbitsbGVIQTNaRXhpMm9NRnNpbVgvSENlaUJVMk5q?=
 =?utf-8?B?YTJtZmJ0ckM5OVA3eDhDTlVVYXludzFlWk5CT3VrTWpKYms3MDJvc2tNVVNu?=
 =?utf-8?B?VnlGcjE0WG4yc2NJcUVMckZSYWxvUzN5cmFSdWlYVVR0VVdBVXVFcTJOUXQr?=
 =?utf-8?B?Z3RJUldpckdLQ0pCc2pnQ2hvV2phdWFUSWowSXZrK3BuendMMkV1WkpDcXAv?=
 =?utf-8?B?QkN0djNncUp5UGhZT0lONDhzNFo5RUxsV1hPeFdYdUM4RjBJTVc3VXdKeS8x?=
 =?utf-8?B?SmhPaWh1WC9mZVRFcGV3d2V3Mko1NW5pSXY3dGluOE83SjJSSFZqSHE1b29t?=
 =?utf-8?B?ZDNsK0ttQ0JvWGJpV3U5dWRlS3ViNFhKbDdCWHJrM3h5NUlDempzL2pKeEJu?=
 =?utf-8?B?aVB3M2h4OHRZdU41RHV5VmRnRFVDRmI0NGM5MEtNUFZ2STh1bEVhWmhmc014?=
 =?utf-8?B?YXEwRVowL3pCRUFHNmVzYWdFRGJhenovUjRZRzdxaEVsUGMreXltOFFDL25P?=
 =?utf-8?B?b2oxUFY0TTZqdmtqQXVIRXpTKzBPM2hSeWpxZVZZanBXSUd5ZCtRaDB2dCtP?=
 =?utf-8?B?dG1GbUk2NUFFUEtxWnRWeGRoSHdEdjh3alZZUUxYbXY5MkQ2cHBrYlp0bE1G?=
 =?utf-8?B?d0tVU0hQUFkrbHYrdHUwVVdoejBXZkcwYmtxaW8wS05aNWpFY0ZBTHNscUpS?=
 =?utf-8?B?b1ljQXpBd3pYT1Y2UnJ0bnplTFM5VHdWWHBRQjM3SUIydjZhVVE1cHFKN2lo?=
 =?utf-8?B?ZDZmT3E4U2ZUcFRQM25lQzFxTXJtOE5UajU4aFk1aWxvWk1wckdFU21qb0xp?=
 =?utf-8?B?ZkkvRjZ0Y3V6TVJTQ0xNa2MxMlFObmdDc3ZzVm05Nitkd2FQUzZSOSt2Qkpl?=
 =?utf-8?B?b1YzbXJXRVlHTUlCNlQ5VzhaeldISFdIa2tvcXdtNWs0ZHVBSFljMmFpVUhp?=
 =?utf-8?B?S0d4c2RaOGp1cEE0OW1xNUhiNUlWVlBHRldOdXF4WUVnZ1A4WEhOWDdVR0tC?=
 =?utf-8?B?Yk9DZ3NWRFJKZTFKT3dHanRSWDFYWXNPaUV4S3BSMHNCdHdnSzFtNGJuRjhp?=
 =?utf-8?B?dm1tVGNTYkRmaG1tSVRtZDZ0ZmYrcDhUbk40ZTloSno2QlRCTy9IUVBNcC9r?=
 =?utf-8?B?U09UT2d3U1NkWmltSGtEVnlIUXcyenQwVCs4QVlyTnhxcWhzclVMYk44dmx4?=
 =?utf-8?Q?XYD4nEZE0GobGLCcmgWNzG5+uphQmxCV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZzL0RyR1R6TXluSVlpbDlQZnZLRWYvQWNCSGw1QVdMYm5yK1ZqSXNRTVJL?=
 =?utf-8?B?UGd4Y1FHR3dzNWVFQ3N0NU5ySENOK3h5YjZrQVJDMlZXeTV2UG5PUVd1bUpo?=
 =?utf-8?B?Z3gyOE1VSTgwOGdpRDZpa1NtSXNPV0VUL2tuTGNyR0NnTnk5Q1VPTGlCYXFz?=
 =?utf-8?B?WENXZzVVZFpISnFkM2trOHJ2ZVM3WWRDWnJWNDJuSExJVkw2TmRRZDlBemtx?=
 =?utf-8?B?c04vMUNHVzk0eGdQeXF6UVIrVmEvRnpBWjk2TjBRVTJHNnNsK2V0MzJtcjZn?=
 =?utf-8?B?YXNUekVHbUp5TUd5YUdFcFI0alIyMy9OK1hOL05OQ3BibllSSnY5SGIwc0o4?=
 =?utf-8?B?TzZjcFQwMXh5Zldrai9aYkNmZnNQVW4xeXVZZTVBWkVVVlBtSTVXNTdDbW9N?=
 =?utf-8?B?eU1hL1J4emVsSVNrOVNmMkxGMnV3eExLa1lJYTQzaWxFS2VOUHBwZm85VlF0?=
 =?utf-8?B?N0JscWZnWDA1ODRueTZ4V3k3UFVyS201OWtWNG9GWU1OUFM4dFJxb1dSTUo2?=
 =?utf-8?B?SUN0WTZoNVpqR3FrS0EzK1Vkc1JkK1E2eXhZSEtZZWtUUWJsQlJmaHhPdXA0?=
 =?utf-8?B?eHJqV29ubitBTmJtUzhOcmtOaTZPUGhhZ0tWaERuWlg5bDBUL2JhYWtDL0Ir?=
 =?utf-8?B?Ykhzbno0ODJrRDYrZU4raGtjUGJibUYybFcrdjdjcEJjbWZrRFNRNmRoZFFH?=
 =?utf-8?B?UDJ1dmFkd1Z4aVBFWkNpL1RQL1laMDk2Sm9kTEVHTkhGWjdVZUUyZkU4U0pk?=
 =?utf-8?B?amNSUnVnei9Gc3F1WUhSbk9xdldwSGtPTnlXS3NTL1FPbEpLbVJwdXVxNVZE?=
 =?utf-8?B?MXRnUlYzMThZZ0hUdkc3ZmdZczh5K2wwTy9OSmVSODhxQ0dhVHF5M0lkZFhM?=
 =?utf-8?B?OWU3WDJ4YytSUkpXMDJUTis4Smo4YVdFamMrUi9kQ1lsc0NNT2UvU3dJbXZB?=
 =?utf-8?B?UkNZcUxzRWl6QiszRFdqUmpaa3RkeWxobEkwUzAxb2V0RkJtUnZtUjF3RGRX?=
 =?utf-8?B?MkswM1NBL05BOElXdTVlM1ltOVN3SFR6a1lyeHJjWmtxWjJkYVNwVnp3Vk42?=
 =?utf-8?B?alJVOFVzVHp2Smg2MExqdHJIVWN6dXdYdUdzWllSSUJJTlZ4ak9CSUJLTk03?=
 =?utf-8?B?cXZyMTVQYmVtL0lSemY4b0ZMYmgwdGhYTXZrZ2oyd084MTZsM3hKQ3BzTjlJ?=
 =?utf-8?B?M2ZqcWxUeU5FUUlSQVdURmRndXBUY2p0RGU5Y0U4UlFodDF6Z25aejU3RnI2?=
 =?utf-8?B?eGRzaWlod2p3dHZuOWhsa1NxdmE0RGJOL05vQ1dvbkhRTEpzZUZWZk9FTEdQ?=
 =?utf-8?B?elVISW1BS0RpdzIvZnUwd0VmdjRmOFhmMU4vbElnZTZ5akUyM21sSW1nREhG?=
 =?utf-8?B?MFhCNjNpYTJzSkIyMHBCSWhDdGM3VVhySi9xYzRJUjlYNXJlM3d6bk1KNUZR?=
 =?utf-8?B?aU44ckMxbVZVWG0vUFZwRW1yM3NHK2VyeHhhb1lmZ0xFMStoZlk4ZWY3U3hM?=
 =?utf-8?B?bHlKWjZsZWFveVQycUpWdlNkR0kwZUIraVBWWE9jVVFaOW11SWJld0VaRHRQ?=
 =?utf-8?B?T0NvUnpBNDNYcUhwM3dVVmhjSWhsRC9yNEtXMDFzcGltKzdlRitZbE81SzJn?=
 =?utf-8?B?OWpyVXJGc2pyakNqRStRQzVPaUU3dHRlVE9BSjJuemZrYlc3L056UGhQVXA4?=
 =?utf-8?B?c2U3bVc5MGFqNGNUTTlVNHpVTGVyWWZUaHBzU3hEOGlXWHh6cHMvemVJQ2Fh?=
 =?utf-8?B?ZzNsM1FSbWxUNnNwMThsd1ZQMkpzYUpIc0dEcFlQOWpjaHgzUi9HSkxPSlVE?=
 =?utf-8?B?MGhib2lxeHB6SmhCa3hFbXpBMWJVTUc5Vndzcnp1UjNhN2lid2ZUamVVN0Fq?=
 =?utf-8?B?YVVtTmpNRnBEZGMxSzVKaklhSDZDZ0l2M1J6UVBPYkdtbzZ0dnJJMUtqWDRB?=
 =?utf-8?B?R3MrYWR4SXhrb1FiOGt5WDB0ZndldEh6UndsT2wvdXYzMHorWEZEQllHQU15?=
 =?utf-8?B?RjZoZ3pUMTRjSElFS09YM3BJUXc4bStZbytqYlJxZFlqM1phUkR5bkhqbEFn?=
 =?utf-8?B?d2FIcURNNkw5blNmeGpTRE9kQ0ovTTJNNG5VeUgxMVpyTXMya0ZORXUzRUJL?=
 =?utf-8?Q?W8ikMOBHnA/wbmaXyEf3gj4Mv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CC88E5BF83E3D4BA0F74D3C14B53496@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3522bbd4-9f8a-4631-dd5c-08dd4bfe2411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:15:05.5309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFD45f25FXkZkbtWY9WsP+gWaBdMvSxMy9sQ83zCjxD2Yzn0+mT+S9ciylttzZtjmHVeQu3/9MQbttx+3idhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0667
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

SGkgU2ltb24sDQoNCk9uIE1vbiwgMjAyNS0wMi0xMCBhdCAwNjowNiAtMDcwMCwgU2ltb24gR2xh
c3Mgd3JvdGU6DQo+IEhpIFlhbm5pYywNCj4gDQo+IE9uIFdlZCwgMjkgSmFuIDIwMjUgYXQgMDM6
MzAsIFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPiB3cm90ZToNCj4gPiANCj4gPiBUaGUg
dG9wIGxldmVsIE1ha2VmaWxlIGNhbGxzIGJpbm1hbiB3aXRoIGZha2UtZXh0LWJsb2JzLg0KPiA+
IFRoZSB0ZXN0IHNldHVwIHNob3VsZCByZWZsZWN0IHRoaXMgdG8gc3BvdCBwb3RlbnRpYWwgYnVn
cyBiZWZvcmUNCj4gPiByZWFjaGluZyB1c2Vycy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
YW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4NCj4gPiAtLS0NCj4gPiDCoHRvb2xzL2Jpbm1h
bi9mdGVzdC5weSB8IDIgKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vZnRlc3Qu
cHkgYi90b29scy9iaW5tYW4vZnRlc3QucHkNCj4gPiBpbmRleCBhNTUzY2E5ZTU2NC4uMWYxOTRm
OWVjYWUgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvYmlubWFuL2Z0ZXN0LnB5DQo+ID4gKysrIGIv
dG9vbHMvYmlubWFuL2Z0ZXN0LnB5DQo+ID4gQEAgLTM3Miw3ICszNzIsNyBAQCBjbGFzcyBUZXN0
RnVuY3Rpb25hbCh1bml0dGVzdC5UZXN0Q2FzZSk6DQo+ID4gwqDCoMKgwqAgZGVmIF9Eb1Rlc3RG
aWxlKHNlbGYsIGZuYW1lLCBkZWJ1Zz1GYWxzZSwgbWFwPUZhbHNlLCB1cGRhdGVfZHRiPUZhbHNl
LA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50cnlfYXJn
cz1Ob25lLCBpbWFnZXM9Tm9uZSwgdXNlX3JlYWxfZHRiPUZhbHNlLA0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNlX2V4cGFuZGVkPUZhbHNlLCB2ZXJib3Np
dHk9Tm9uZSwgYWxsb3dfbWlzc2luZz1GYWxzZSwNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWxsb3dfZmFrZV9ibG9icz1GYWxzZSwgZXh0cmFfaW5kaXJzPU5v
bmUsIHRocmVhZHM9Tm9uZSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYWxsb3dfZmFrZV9ibG9icz1UcnVlLCBleHRyYV9pbmRpcnM9Tm9uZSwgdGhyZWFkcz1O
b25lLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdF9z
ZWN0aW9uX3RpbWVvdXQ9RmFsc2UsIHVwZGF0ZV9mZHRfaW5fZWxmPU5vbmUsDQo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3JjZV9taXNzaW5nX2JpbnRvb2xz
PScnLCBpZ25vcmVfbWlzc2luZz1GYWxzZSwgb3V0cHV0X2Rpcj1Ob25lKToNCj4gPiDCoMKgwqDC
oMKgwqDCoMKgICIiIlJ1biBiaW5tYW4gd2l0aCBhIGdpdmVuIHRlc3QgZmlsZQ0KPiA+IA0KPiA+
IC0tDQo+ID4gMi40My4wDQo+ID4gDQo+IA0KPiBJIHdvdWxkIGxpa2UgdGhpcyBkZWZhdWx0IHRv
IHN0YXkgdGhlIHNhbWUgKEZhbHNlKSBiZWNhdXNlIHRoYXQgaXMgdGhlDQo+IG5vcm1hbCBjYXNl
IGZvciBCaW5tYW4uIFdlIHNob3VsZCBleHBhbmQgdGhlIHRlc3QtY292ZXJhZ2UgYXMgbmVlZGVk
Lg0KDQpDYW4geW91IGhlbHAgbWUgdW5kZXJzdGFuZCB3aHkgd2UgZmFrZSBibG9icyBpbiB0aGUg
Y2FsbCB0byBiaW5tYW4gd2hlbiBidWlsZGluZyBVLUJvb3Q/DQpZb3Ugc2F5IHRoYXQgbm90IGZh
a2luZyBpcyB0aGUgbm9ybWFsIGNhc2Ugc28gd2h5IGFyZSB3ZSBkb2luZyBzb21ldGhpbmcgYWJu
b3JtYWwgaW4gdGhlIHRvcC1sZXZlbA0KTWFrZWZpbGU/DQoNCkkgdGhpbmsgdGhhdCB0aGlzIGlu
Y29uc2lzdGVuY3kgaXMgYSBwb3RlbnRpYWwgZm9yIGJ1Z3MgZ29pbmcgdW5ub3RpY2VkIHNvIHdo
YXRldmVyIHdlIGRlY2lkZSB0byBkbw0KSSB3b3VsZCB2ZXJ5IG11Y2ggbGlrZSB0byBiZSBjb25z
aXN0ZW50IHdpdGggdGVzdGluZyBhbmQgIm5vcm1hbCIgYnVpbGRzLg0KDQpZYW5uaWMNCg0KPiAN
Cj4gUmVnYXJkcywNCj4gU2ltb24NCg0K
