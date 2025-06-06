Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB22CC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CB7B81FEE;
	Fri,  6 Jun 2025 08:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Q8F6Fe0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9A8828A2; Fri,  6 Jun 2025 08:59:09 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C90807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg0ju2qMFgWKuvZsojjDv2O5TMvGYK5ymNRsqUvLOcvUx0eRCxkHSQE/EvY5nn9Bj8Iyras0GRqyKvQHEekGFMdSokva0WIKJ66dg/IV+YE2+sMX4CKgF+F4Tj6Q0rPMbsov9kMMJGquZhUjxJbUj+2uv7XenaDOJTyuUIzQj7qeJcCRYg+/Rw8WwzyoliOfQvvXADxX9sJMa2VvIr77VLuzKJ0oMvl8KetmpUDKgC+fiJj+qM2ZQ1vdGPkxj+QJWZ4twovDhP0goLx5DVRGWjmvWxcWztOpPn3/5grcRpvy35vAOg/Vabo2zDwu+AbmoybH6v1tsszQwjNLSumgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVA7DONaUoE3R/ROo6nd67MmFEj7q7Yi8LtC7g/kbK0=;
 b=Bki6kfmD43pQ+Q7mTZJbLAjrFPWGPC68JSswcMhzHKquJTDHcpjmnNLOYs1K8EP/ryx4vlVQ7CTIh+XXhlFwQJ/3aEbm2tpmNU9Fwk4KWEo3LT6a1F/NWdofIknHbKx9g0JmW+/CGD5aEhrRY7ect0sffupwW9jY69vD59Tk0A6ifznROK+sX4vE7TqDY0Ebx0fG9DC7xV2xzlLDQJVL0Re7fKmI8Th778ltK3Ka8plJDlydyIOTFhMRvsQDK1/HIjcdWJO4rCfEiS530WKeCkPx4KQB2pXpWgRui+wBLUMRzHG9a9Avh9olfzIOgEz1HM/tt4g9Jy95M0inoYVAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVA7DONaUoE3R/ROo6nd67MmFEj7q7Yi8LtC7g/kbK0=;
 b=Q8F6Fe0kDhsca1qxH1SrCwoFjLQAX7eKXNMbNcwpiNxTLoZ0hERPnvnh49yMB9SHsT2eCnRf4KQOjojRHgJiL2k3JqZWcmIkiHHEJz/dN/OOhnW9q9hNiZwDGqdzTt3alDv5Xyfna815aZCnqXjAUnBF6r8PhpjOMXUoiHqBy3r58XxSvf4zOd8QyLvw3FAsx6/fc8XDREhLWHvWOp5OW23EIcuAK2plTHklo9eBL4v2U+68cBxDO3ZcFqHxcloV8jROrUzDjaBJIuqwUbV1w6q23So8kp3LOVU+DuT13HTGTH1RNZNqx7aSr0wJ8OrtAFLuWaSS0eAJT5OcG5TQdg==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by AM8P195MB1060.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 6 Jun
 2025 06:59:05 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%6]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 06:59:05 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Wadim Egorov <W.Egorov@phytec.de>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Topic: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Thread-Index: AQHb1UqJu7bU4cfQfUG48IKL6GPmkrP01BUAgADiT4A=
Date: Fri, 6 Jun 2025 06:59:05 +0000
Message-ID: <421b73636b30472302e5751e9c001ffd4e6b4eb4.camel@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <CAFLszTjWqhg1baNSF5rLqjYdoDNyjmy=5hXXq5AzwNF_QSfAQg@mail.gmail.com>
In-Reply-To: <CAFLszTjWqhg1baNSF5rLqjYdoDNyjmy=5hXXq5AzwNF_QSfAQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|AM8P195MB1060:EE_
x-ms-office365-filtering-correlation-id: dd3b89e3-9095-4786-6f4b-08dda4c7a051
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZlRZSks0MHNOTUwvT243VE9uQkNRRTJXUzErNWkwTTZUZVAzZTlWVXNpdkZZ?=
 =?utf-8?B?VkpMK05MdjBham5jZjNzdWN1MzVzMHd5d0s1c010Y25TeWg1dkNPKyttcCt5?=
 =?utf-8?B?Y0FwdWl5VTI1N1Z3RnZwUGY5OUhRbHdRV3djcnVOOGhRdHpFVmJqSW9LVnFE?=
 =?utf-8?B?enhEcmN3VVpjeHlBaS9tUURJU1ZTVm9yUHJkMjB2c1Q5SUpWaWdic2hwOXJN?=
 =?utf-8?B?UTRsZU5xZ3Fqd1hFQklrRDU0d2F2aGM1QjdDdUErWk1FQTYzVnV5Rk53Tnk4?=
 =?utf-8?B?OFZ0dWYyRzhsUUVDbnNEVkpSbXpzY1g2NDRRY0RHVjVIV21yc0x1anhVUFd1?=
 =?utf-8?B?U2pTUTh1UmtZSWExcnoyT01vU1A5Nm1FL1Z5czl3NFNjVGV4RGxvREFCUTI1?=
 =?utf-8?B?cWJHQWwvQk9sY2RYMVhvYlJYSUh6WDVmaVB4UENJNGgvbDF1b0loa0w0VmdZ?=
 =?utf-8?B?dGhWcjZ5UlRwNlVxM3F2cEx4Q2lNakM4c1BKKzAvQkVjUE1MVW51SFpjRjcy?=
 =?utf-8?B?MUFiZytITDg4ajBlSjRiSmttMnR6Mk5SbjE3K3pBbnEyd0h0ZVFaK1J2OC9Q?=
 =?utf-8?B?cDVXWjh4d3Awa1MvcnN6cVUxWU1FVGVUQktFS2lvb3Y2a0FCS1lPZ1I1Nmd5?=
 =?utf-8?B?dTIxVzJmWmppbjJjOC91bGg0MDZEWFBCVE8vL2h1NFcwSDNSY0FFU3BQdGcx?=
 =?utf-8?B?aytqckdzL1pyaVVLVTVLMU51SzBKazVCbG9wS0xMUXdZMjR3eDhhd2kxYUFY?=
 =?utf-8?B?V3JVVXdObldYRWJrOGg1ZWlLZDJUMEtZRGNPdmc4L0hIVERTaStRWUVwME5B?=
 =?utf-8?B?ck95ZklHV1VqK0hJeDNLb3hmV2d2OXhrM0grQjdHSnRQRVZmMVNuZFNNbmV2?=
 =?utf-8?B?MVFrSVJTYUNVbndIK08zYjIzM1VoUEg5RzJRcU5lR1dQZjNyNkdBOFBzM1Nk?=
 =?utf-8?B?Y3BlTFNBYVBjeGRMVkRUMm9OZy9lSVFaL21wbDBTeUNGaytPcDNCbHNYSnMz?=
 =?utf-8?B?MzBSa2hSNTNDQVNNZFlxblUvaVlMNUczNVF3RmlhdW9md1UrdnV6K09oQk0w?=
 =?utf-8?B?R1RLMmhvdDJQb2wyWkVaM25kMTV1NTdXRlM3VzFMS2tocmNUREtTS3JQVDBM?=
 =?utf-8?B?Qnh2UTFOd3gzQVlpYzg5RVVsYSsxeXRKTmsxSTZ0b3I2NEl2TDVaZ3hMTG01?=
 =?utf-8?B?eTl2VjJHbSt6eWRPSlZJbVIxNFNpbnZpNmphL25sVThOQkNVRW8yai9DOHNO?=
 =?utf-8?B?WnM5cG4wYjl6U1VZRFVkRkJuSjFBTDZRNzc4UG1aNzVhTXpERzdneHFkOHYx?=
 =?utf-8?B?R0JQbnFiTlpMYy9SMFZoS2IyaWdxTmJsYWtqNXFlVEpuWFpCVEZlQ2hBelN6?=
 =?utf-8?B?UkVqVXhUcE8rNU5pUHAxUksrTldLMkhDdlVzaTVKMlJnZ1BaMkczSUhPOWx6?=
 =?utf-8?B?WmZaTFA5NEtiWHBnQkZoNE91VEF6WWVmYVlpVTRDM3NuREV0RWxNbXhlT0FS?=
 =?utf-8?B?SHg5WDBkcGtWVXdIMHkyRXBENkxSWnhPeFNqOTFQWC9KWE9jVW94V3Z4TVg2?=
 =?utf-8?B?QzdXM3ErZXorYTdyeTU0a2FjSk5BVWdNODlpZlBJMDFZNW41TEhMM2t3MDZx?=
 =?utf-8?B?NEtRazNLSGV0SFR1bzlXYkRIaUJQd0c0WDY0TTlZU3B1bVZOc2hyTUlYTkZz?=
 =?utf-8?B?ZHZBUVQ4a20xUUwySHM2bG9iQVRXTGdjSW1tTzhrZSsvNWJLaWtFY3lTR2o2?=
 =?utf-8?B?YXg3WHVJYWVJbHdEai9veFlqNFEwV1Q1VVZGek1PYWRhczZaTzZibVlaS3Jj?=
 =?utf-8?B?WGZEV3FNTHhRUWNic0tDdVRMTDFWNEZ1VWpBQ3NpdnRjUVJ2ZklEQ25lc1N0?=
 =?utf-8?B?aGJrY0dDTU9kM3hoaFZnZXdsVlhYL3BlWlEyTzM0a0FLb0ZLMHNHa2NzRXdN?=
 =?utf-8?Q?zcVy1XJ3MUM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3FVZkZWYkhBUjk3YzJWajB3MG1NWnh1emY4cXBZZzI2VXU4MWtlZlpMSzJr?=
 =?utf-8?B?Qk9YYlNEejA1aXZ4WDFzK1BzYmk1ZkV3OVhyMjN1Q0FpbTVoWGtWOEk3RVdG?=
 =?utf-8?B?NDI4TDA3QkVtWGExalA3Qzc5NHV3NzFyZ3hjUk9JVWQ2Qks5K1d1VlpVVVhs?=
 =?utf-8?B?dXc2d0VjelRSY09GZGFhN0psTTJYVUtLWVNSMVFlRFlXekQ4ZVZkVG96dWxr?=
 =?utf-8?B?elpMVEFJc1RaekZ4c1dURXdKZ1hzcDhjczNmNWRvUVhOb21zWm10QXR5Zk5W?=
 =?utf-8?B?TjdKc2p4Rkd5Y0JuL0pkTjNaLzRwa3Q1UjhEY1NpV0RpeG11UVpQVWVEUVBG?=
 =?utf-8?B?NTZreHR3MXdoV2JWRmhzTmNIR2crcXpxTFRjcXBVK1BPZDQ5S1FncVlPUmFS?=
 =?utf-8?B?RGhxMml6KytRMDdYdFNiN2IwUGgrQ2g1ek1KQ1locUpXOG0zRjZya2hGQnJJ?=
 =?utf-8?B?L0gwRVoyTTEvV2NSTmprb2o5L3ZpVlpHVkw1MTdwTzZtZnZlak1NZlUvS1A0?=
 =?utf-8?B?bTZMbjBYM3U2QjVPV1VyMmV1c2dud2ZUc3UxemRySjFHVm1Eb2k5TU1OY3pX?=
 =?utf-8?B?U0pDNU9ja2hOc3pQRU1xL3dlWjBQZjJKdlVsWE9HZVFPRzhackpKU3J4c2JL?=
 =?utf-8?B?cE5zYjFnMXpFTldoYzRHQ0tzNEdGdjU0aXk5SWVuUDc1WCtWV0NGVEh2MXoz?=
 =?utf-8?B?YnJha0FNRVdxVTdZaGZ4VVdWZWxDbk1QWGs5TmVZL2JGTTNDdEpiRkdYMERv?=
 =?utf-8?B?b1RCblQ2M0k1NGx4NFN6U201amZ1c0YyK1YvOUtYK29RdzF4UlNMcTNad05U?=
 =?utf-8?B?MXk1NmVGQ0s0UjIvWDJRaTduVTJmTW9Scll0Nmg1WFZhTjhPTTJwTklMd1Nh?=
 =?utf-8?B?NHVkZGtnVzZEUHIwM1BjSlVSOWc3S3Z3SWZCa0gvMXY2TWlxbXZiRkFjb0J3?=
 =?utf-8?B?SkNqbU42bjlRS0FPeTFyeUlNYUFRQXBibXg2aWVtYjVaVjc4NU5ZbDZkTVlU?=
 =?utf-8?B?MGZISnBERVczVFBlRlU3eStYRVk0d05ORFFnNEF1OWNvWWlITHhudzVQUHpG?=
 =?utf-8?B?NWZ4RFVtcUhPdHA5c3hmUTMwN3g5cjZIU3N1VDRtVFgrR0piRzVUOGR5RmZD?=
 =?utf-8?B?MFpYRGEyVHRNb1hxMGJQemk4NExzblVDR2pSQnlnRTF5dmh4dUpRNWpNaXZm?=
 =?utf-8?B?YSs4YXJtSGZ1UElTY0JZWWlVK1p5K2RhVnFURXVjaEU1UDlhdk1NTWYyQ2U3?=
 =?utf-8?B?aGhLbE41RkR1VjRtNjFrZURkWlBLbi9tdjdqSkdhM2lJOHZBL3ZOdjcyWC9i?=
 =?utf-8?B?Q0tNY21CaTFaQUsxeGhnR1pMeWVTTnNSYkdBNGZISk4rU1dwVi9ldWQvMjlS?=
 =?utf-8?B?V2xGR2l3cUVBMWpGNk5rOFZKT0pBU1NJN3RMKzZzdzU3b1ZRQU1wSnFRaEVV?=
 =?utf-8?B?bXB1NU8zK1lPTmhhb0JUUW1xQVNYakVvT2VmL29lUjNJTCtiS1o0d0kyYlM2?=
 =?utf-8?B?cHhYSEdjWUZ4Rm9JTDA5YllIby9PVTJqVWcvN0RYelFLSzBVcXYvVWl6VXR6?=
 =?utf-8?B?bEJJaklxZUY1TlZKY3pZZzFaQXYyNitHQUd4THRiZ0x2Y1ZEdkkzSmt1VnNw?=
 =?utf-8?B?Y3Nid2NPeUVocHJMTHE4RmpsZjBxRVluTTFBejQ4Y2c4OFJueW1xSG5HVXBw?=
 =?utf-8?B?SHdJRHEwSy94L01LeTZpc3R4a3U1NXpIck9rK0VTZE0xQTdQQWZiWUhWajUx?=
 =?utf-8?B?M1lZcTZBNFYveUM5d2hBVXNvMlRDWjJBUmhUV3diNy9vcHNycXNUZlNEUTlr?=
 =?utf-8?B?RSs5a2VQdUhhclErdkpsd2J6RTNCdEEyZ2lJYkdiNEhHNEpmc0Mwc0tDVERU?=
 =?utf-8?B?SGJaVzh0REIralZMQXRaM0lFS2JQMEU0ZHM4KzhoODNLaHB1aU9BNXNJd2Fm?=
 =?utf-8?B?NTlPakF4M0lwSVVSYkJNUVlSUWNlam5Rbm54SkRVNlViNCswczFxbTMvSzZm?=
 =?utf-8?B?RzhVQTZtTWxxOHAwTFplcS91TlB4TWMzYlhSTG8zWTJvOGZYWCtzWDA5VTMr?=
 =?utf-8?B?enphZUNJOUFzd3E1bkxpTGZqaUlQSTJtdmE5SmhyWHdmemRXbWxXQlpXdXND?=
 =?utf-8?B?bUxPK1MydkM5dC9ua2ZoSEM2UHkvdDVEdjNBN0l0Q3lwRGtzdjlMMjJ2c2hZ?=
 =?utf-8?Q?Iagl0n7naXkY9/zu1uyLF7faiv+fX+gp7IjeFX4YEEfH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA7DD6D6EA3E4448B595F86E8BFC7146@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b89e3-9095-4786-6f4b-08dda4c7a051
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:59:05.1298 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlriLMuVh/W6mUUr/XaEgwkddEanNhaa1jgnyv3wZajooxlsbRE6xiU2w8qReztn+8DcShTfluLIREn5qByXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB1060
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBNTEyDQoNCkhpIFNp
bW9uLA0KDQpPbiBUaHUsIDIwMjUtMDYtMDUgYXQgMTE6MjkgLTA2MDAsIFNpbW9uIEdsYXNzIHdy
b3RlOg0KPiBIaSBNYXJ0aW4sDQo+IA0KPiBPbiBXZWQsIDQgSnVuIDIwMjUgYXQgMDY6MTYsIE1h
cnRpbiBTY2h3YW4gPG0uc2Nod2FuQHBoeXRlYy5kZT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gVGhp
cyBzZXJpZXMgaW1wbGVtZW50cyBhIG5ldyBib290bWV0aCBmb3IgUkFVQyBBL0Igc3lzdGVtcy4g
UkFVQw0KPiA+IChSb2J1c3QNCj4gPiBBdXRvIFVwZGF0ZSBDb250cm9sbGVyKSBpcyBhIGxpZ2h0
d2VpZ2h0IHVwZGF0ZSBjbGllbnQsIHByb3ZpZGluZw0KPiA+ICJTYWZlDQo+ID4gYW5kIFNlY3Vy
ZSBPVEEgVXBkYXRlcyBmb3IgRW1iZWRkZWQgTGludXgiLiBTZWUgdGhlIGZvbGxvd2luZyBsaW5r
cw0KPiA+IGZvcg0KPiA+IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgUkFVQzoNCj4gPiANCj4gPiDC
oCBodHRwczovL3JhdWMuaW8vDQo+ID4gwqAgaHR0cHM6Ly9yYXVjLnJlYWR0aGVkb2NzLmlvL2Vu
L2xhdGVzdC8NCj4gPiANCj4gPiBQSFlURUMgdXNlcyBSQVVDIGluIGl0cyBZb2N0byBiYXNlZCBk
aXN0cmlidXRpb24gIkFtcGxpcGh5IiBhcyB0aGUNCj4gPiBkZWZhdWx0IHdheSBvZiB1cGRhdGlu
ZyBlbWJlZGRlZCBkZXZpY2VzIGJhc2VkIG9uIFBIWVRFQyBoYXJkd2FyZS4NCj4gPiBTbw0KPiA+
IGZhciwgdGhlIGxvZ2ljIHNlbGVjdGluZyB0aGUgY29ycmVjdCBwYXJ0aXRpb25zIGFuZCBmaWxl
cyB0byBib290DQo+ID4gd2FzDQo+ID4gYmVpbmcgaW1wbGVtZW50ZWQgaW4gdGhlIFUtQm9vdCBl
bnZpcm9ubWVudC4gV2hpbGUgdGhpcyBpcyBhDQo+ID4gc3RyYWlnaHRmb3J3YXJkIHdheSB0byBk
byBpdCwgYWRkaW5nIGFuZCBzdXBwb3J0aW5nIG5ldyBwbGF0Zm9ybXMNCj4gPiBiZWNhbWUNCj4g
PiBzb21ld2hhdCB0ZWRpb3VzIGFuZCBpcyBwbGF0Zm9ybS1zcGVjaWZpYy4gVGhlIGludHJvZHVj
dGlvbiBvZiBVLQ0KPiA+IEJvb3Qncw0KPiA+ICJTdGFuZGFyZCBCb290IiBwcm92aWRlZCBhIGNv
bnZpbmNpbmcgYWx0ZXJuYXRpdmUsIHByb21pc2luZyBhDQo+ID4gc2ltcGxlcg0KPiA+IGFuZCBt
b3JlIHBvcnRhYmxlIHdheSBvZiBib290aW5nLCBldmVuIGZvciBSQVVDIHN5c3RlbXMuIFRoaXMg
bGVkDQo+ID4gbWUgdG8NCj4gPiBpbXBsZW1lbnQgYSBuZXcgYm9vdG1ldGggc3VwcG9ydGluZyBS
QVVDIEEvQiBzeXN0ZW1zLiBOb3RlLCB0aGF0DQo+ID4gdGhpcw0KPiA+IG5ldyBib290bWV0aCBp
cyBub3QgcHJvcHJpZXRhcnkgdG8gUEhZVEVDIHByb2R1Y3RzIGFuZCBpcyBkZXNpZ25lZA0KPiA+
IHRvDQo+ID4gd29yayBvbiBvdGhlciBoYXJkd2FyZSB3aXRoIGEgUkFVQyBBL0Igc3lzdGVtLCB0
b28uDQo+ID4gDQo+ID4gVGhlIGJvb3RtZXRoIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRzIHN5bW1l
dHJpYyBBL0IgcGFydGl0aW9uaW5nDQo+ID4gbGF5b3V0cy4NCj4gPiBFLmcuIEEvcmVzY3VlIGlz
IG5vdCAoeWV0KSBzdXBwb3J0ZWQuIFRoZSBwYXJ0aXRpb24gaW5kZXhlcyBhbmQNCj4gPiBkZWZh
dWx0DQo+ID4gc2xvdCB0cmllcyBjYW4gYmUgc3BlY2lmaWVkIHZpYSBjb25maWd1cmF0aW9uIG9w
dGlvbnMuDQo+ID4gDQo+ID4gRm9yIG5vdywgdGhlIGJvb3RtZXRoX3JhdWMgdXNlcyBhIHNpbWls
YXIgYXBwcm9hY2ggZm9yIGxvYWRpbmcgdGhlDQo+ID4gS2VybmVsIGFuZCBkZXZpY2UgdHJlZSBh
cyB0aGUgYm9vdG1ldGhfc2NyaXB0LCBpbiB0aGF0IGl0IHJlcXVpcmVzDQo+ID4gYSBGSVQNCj4g
PiBjb250YWluaW5nIGEgVS1Cb290IHNjcmlwdCBsb2FkaW5nIHRoZSBkZXNpcmVkIGRpc3Ryby4g
SXQgY291bGQgYmUNCj4gPiBwb3NzaWJsZSB0byBzdXBwb3J0IGJvb3Rpbmcgd2l0aG91dCBhIHNj
cmlwdCBhbmQgbG9hZCB0aGUgS2VybmVsDQo+ID4gYW5kIERUDQo+ID4gZGlyZWN0bHkgd2l0aCB0
aGlzIGJvb3RtZXRoLCBidXQgSSBmb3VuZCB0aGUgc2NyaXB0IG1ldGhvZCB0byBiZQ0KPiA+IHZl
cnkNCj4gPiBmbGV4aWJsZSBmb3Igbm93LCBpbiBsZXR0aW5nIHRoZSBkaXN0cm8gZGVjaWRlIHdo
YXQgdG8gbG9hZC4NCj4gPiANCj4gPiBUaGUgYm9vdG1ldGhfcmF1YyB3YXMgdGVzdGVkIG9uIGEg
cGh5Qk9BUkQtUG9sbHV4IGkuTVg4TSBQbHVzIFsxXQ0KPiA+IHdpdGgNCj4gPiBCU1AtWW9jdG8t
QW1wbGlwaHktaS5NWDhNUC1QRDI0LjEuMiBbMl0uDQo+ID4gDQo+ID4gU3VwcG9ydGVkIGJvb3Qg
ZGV2aWNlcyBhcmUgY3VycmVudGx5IG9ubHkgTU1DIGRldmljZXMsIGJ1dCBpdA0KPiA+IHNob3Vs
ZCBiZQ0KPiA+IHBvc3NpYmxlIHRvIGFkZCBTUEkgZmxhc2hlcyBpbiB0aGUgZnV0dXJlLg0KPiA+
IA0KPiA+IFRvIHRlc3QgdGhpcyBwYXRjaCBzdGFjayB3aXRoIFBIWVRFQydzIHBoeUJPQVJELVBv
bGx1eCBpLk1YOE0gUGx1cw0KPiA+IGJvYXJkLCB5b3UgbmVlZCB0byBhZGp1c3QgdGhlIGJvb3Qg
ZmlsZXMgdG8gaW5jbHVkZSB0aGUNCj4gPiBib290LnNjci51aW1nDQo+ID4gY29udGFpbmluZyB0
aGUgZGlzdHJvJ3MgYm9vdCBzY3JpcHQgYW5kIHNldCAib3B0YXJncyIgdG8NCj4gPiAiJHtyYXVj
YXJnc30iDQo+ID4gaW4gaXQuIEFsc28gZGlzYWJsZSBhbnkgbGVnYWN5Ym9vdCBpbiB0aGUgVS1C
b290IGVudmlyb25tZW50IGFuZA0KPiA+IHNpbXBseQ0KPiA+IGJvb3Qgd2l0aCBTdGFuZGFyZCBC
b290Og0KPiA+IA0KPiA+IMKgIGJvb3RtZXRoIG9yZGVyIHJhdWMNCj4gPiDCoCBib290ZmxvdyBz
Y2FuIC1sYg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gTWFydGluDQo+ID4gDQo+ID4gWzFdOg0K
PiA+IGh0dHBzOi8vd3d3LnBoeXRlYy5ldS9lbi9wcm9kdWt0ZS9zaW5nbGUtYm9hcmQtY29tcHV0
ZXIvcGh5Ym9hcmQtcG9sbHV4Lw0KPiA+IFsyXToNCj4gPiBodHRwczovL2Rvd25sb2FkLnBoeXRl
Yy5kZS9Tb2Z0d2FyZS9MaW51eC9CU1AtWW9jdG8taS5NWDhNUC9CU1AtWW9jdG8tQW1wbGlwaHkt
aS5NWDhNUC1QRDI0LjEuMi8NCj4gPiANCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+
IC0gSW52ZXJ0IGlmLXN0YXRlbWVudCBjaGVjayBmb3Igc2V0dGluZyBkZWZhdWx0IHZhbHVlIG9m
DQo+ID4gQk9PVF8qX0xFRlQgZW52DQo+ID4gwqAgdmFyaWFibGVzLiBUaGlzIHdvdWxkIGZhbHNl
bHkgdHJpZ2dlciBhbiBlcnJvciBtZXNzYWdlIGJlZm9yZS4NCj4gPiAtIExpbmsgdG8gdjI6DQo+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDYwMi13aXAtYm9vdG1ldGgtcmF1Yy12
Mi0wLTlkMjM4NDEzMTQ4NkBwaHl0ZWMuZGUNCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+
IC0gUmVtb3ZlIExPR19ERUJVRyBmcm9tIGJvb3QvYm9vdG1ldGhfcmF1Yy5jDQo+ID4gLSBSZW9y
ZGVyIGFzbS9jYWNoZS5oIGluY2x1ZGUgdG8gYmUgbGFzdA0KPiA+IC0gRG8gbm90IGNoZWNrIGZv
ciBSQVVDLXNwZWNpZmljIGZpbGVzIGluIHRoZSByb290ZnMgYW55bW9yZS4gVGhpcw0KPiA+IGRv
ZXMNCj4gPiDCoCBub3Qgd29yayBvbiBlbmNyeXB0ZWQgcm9vdCBmaWxlc3lzdGVtcyBhbmQgaXMg
bm90IGEgc3RhYmxlDQo+ID4gaW5kaWNhdG9yDQo+ID4gwqAgZm9yIGEgZnVuY3Rpb25pbmcgUkFV
QyBzeXN0ZW0uDQo+ID4gLSBBZGQgYSBkZXNjcmlwdGlvbiBvZiB0aGUgdGVybSAic2xvdCIgaW4g
dGhlIGNvcnJlc3BvbmRpbmcgcHJpdmF0ZQ0KPiA+IMKgIHN0cnVjdC4NCj4gPiAtIFJlbW92ZSBi
b290IHRyaWVzIGxlZnQgZnJvbSBzdHJ1Y3QgZGlzdHJvX3JhdWNfc2xvdC4gVGhlIGJvb3QNCj4g
PiB0cmllcw0KPiA+IMKgIGFyZSByZWFkIGRpcmVjdGx5IGZyb20gdGhlIGVudmlyb25tZW50LCBh
cyB0aGF0J3MgdGhlIG9ubHkNCj4gPiBjb3JyZWN0DQo+ID4gwqAgc291cmNlIFJBVUMgaXMgcmVs
eWluZyBvbi4NCj4gPiAtIFJlbW92ZSB0aGUgY3VycmVudCBib290X29yZGVyIGZyb20gc3RydWN0
IGRpc3Ryb19yYXVjX3ByaXYsIGZvcg0KPiA+IHRoZQ0KPiA+IMKgIHNhbWUgcmVhc29uIGFzIGFi
b3ZlIChlbnYgaXMgY29ycmVjdCBzb3VyY2UpLg0KPiA+IC0gQWRkIGZ1bmN0aW9uIGZvciByZXRy
aWV2aW5nIGEgc2xvdCBzdHJ1Y3QsIHRvIGVhc2UgZmluZGluZyB0aGUNCj4gPiByaWdodA0KPiA+
IMKgIG9uZSB3aGVuIGUuZy4gaXRlcmF0aW5nIG9yIGdldHRpbmcgYnkgbmFtZS4NCj4gPiAtIEZp
eCBtdWx0aWxpbmUgY29tbWVudHMuDQo+ID4gLSBGaXggdmFyaW91cyBpZi1zdGF0ZW1lbnRzIHdo
aWNoIHdlcmUgZXhwbGljaXRseSBjb21wYXJpbmcgdG8gMCBvcg0KPiA+IMKgIE5VTEwuDQo+ID4g
LSBGcmVlIHZhcmlvdXMsIHRlbXBvcmFyeSBpbnN0YW5jZXMgb2YgYWxsb2NhdGVkIHN0cmluZyBs
aXN0cy4NCj4gPiAtIFNldCBkZWZhdWx0IGVudiB2YWx1ZXMgZm9yIEJPT1RfT1JERVIgYW5kIGFz
c29jaWF0ZWQgQk9PVF8qX0xFRlQNCj4gPiDCoCB2YXJpYWJsZXMuIFRoZXNlIHZhcmlhYmxlcyBh
cmUgbWFuZGF0b3J5IGZvciBSQVVDIHRvIHdvcmsuDQo+ID4gLSBVc2UgY2FsbG9jKCkgaW5zdGVh
ZCBvZiBtYWxsb2MoKSBmb3IgYWxsb2NhdGluZyB0aGUgcHJpdmF0ZQ0KPiA+IHNsb3RzLg0KPiA+
IC0gVXNlIGNvbmZpZyBvcHRpb25zIGZvciBjb25maWd1cmluZyB0aGUgcGFydGl0aW9ucyBhbmQg
ZGVmYXVsdA0KPiA+IGJvb3QNCj4gPiDCoCBvcmRlciwgaW5zdGVhZCBvZiBzZXR0aW5nIHRoZW0g
dmlhIHRoZSBVLUJvb3QgZW52Lg0KPiA+IC0gVXNlIGJvb3RzdGRfZ2V0X3ByZWZpeGVzKCkncyBy
ZXR1cm4gdmFsdWUgYW5kIGNoZWNrIGFsbCBhdmFpbGFibGUNCj4gPiDCoCBwcmVmaXhlcyBmb3Ig
dGhlIGJvb3Qgc2NyaXB0Lg0KPiA+IC0gQWRkIGEgcHJvcGVyIGJvb3Qgb3JkZXIgc2VsZWN0aW9u
IGxvZ2ljIGZvciB0aGUgcmF1YyBib290bWV0aCwNCj4gPiBzaW1pbGFyDQo+ID4gwqAgdG8gdGhl
IHByZXZpb3VzIGVudmlyb25tZW50IHNjcmlwdGluZywgd2l0aCBmYWxsYmFja3MgYW5kIHNsb3QN
Cj4gPiB0cnkNCj4gPiDCoCBjaGVja3MuDQo+ID4gLSBJbnRyb2R1Y2UgY29uZmlnIG9wdGlvbiBm
b3IgcmVzZXR0aW5nIGFsbCBzbG90IHRyaWVzIGluIGNhc2UgdGhleQ0KPiA+IGFyZQ0KPiA+IMKg
IGFsbCB6ZXJvLiBUaGlzIG1heSBwcmV2ZW50IGEgc3lzdGVtIGZyb20gbG9ja2luZyB1cCBpbiB0
aGUNCj4gPiBib290bG9hZGVyLg0KPiA+IC0gUmVuYW1lIGVudiB2YXJpYWJsZSAibW1jcm9vdCIg
dG8gImRpc3Ryb19yb290cGFydCIsIHRvIGJlIGluIGxpbmUNCj4gPiB3aXRoDQo+ID4gwqAgImRp
c3Ryb19ib290cGFydCIuDQo+ID4gLSBDaGFuZ2UgdGhlIGJvb3RtZXRoIGZsYWcgdG8gImdsb2Jh
bCIsIGFzIHRoZSByYXVjIGJvb3RtZXRoIGRvZXMNCj4gPiBub3QNCj4gPiDCoCB3b3JrIGZvciBp
bmRpdmlkdWFsIHBhcnRpdGlvbnMuDQo+ID4gLSBVcGRhdGUgZG9jdW1lbnRhdGlvbiBhY2NvcmRp
bmdseS4NCj4gPiAtIExpbmsgdG8gdjE6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI1MDEyOS13aXAtYm9vdG1ldGgtcmF1Yy12MS0wLTYzMDhlNzMyZjMxNEBwaHl0ZWMuZGUNCj4g
PiANCj4gPiAtLS0NCj4gPiBNYXJ0aW4gU2Nod2FuICgyKToNCj4gPiDCoMKgwqDCoMKgIGJvb3Rz
dGQ6IEFkZCBpbXBsZW1lbnRhdGlvbiBmb3IgYm9vdG1ldGggcmF1Yw0KPiA+IMKgwqDCoMKgwqAg
ZG9jOiBBZGQgZGVzY3JpcHRpb24gZm9yIGJvb3RtZXRoIHJhdWMNCj4gPiANCj4gPiDCoGJvb3Qv
S2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUxICsr
KysrDQo+ID4gwqBib290L01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgwqAgMSArDQo+ID4gwqBib290L2Jvb3RtZXRoX3JhdWMuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDQzMg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+IMKgZG9jL2RldmVsb3AvYm9vdHN0ZC9pbmRleC5yc3TCoMKgwqAgfMKgwqAgMSAr
DQo+ID4gwqBkb2MvZGV2ZWxvcC9ib290c3RkL292ZXJ2aWV3LnJzdCB8wqDCoCAxICsNCj4gPiDC
oGRvYy9kZXZlbG9wL2Jvb3RzdGQvcmF1Yy5yc3TCoMKgwqDCoCB8wqAgNTYgKysrKysNCj4gPiDC
oDYgZmlsZXMgY2hhbmdlZCwgNTQyIGluc2VydGlvbnMoKykNCj4gPiAtLS0NCj4gPiBiYXNlLWNv
bW1pdDogYjIyYTI3NmYwMzlmODE4ZDU1NjRiZWM2NjM3MDcxY2ZjOGE3ZTQzMg0KPiA+IGNoYW5n
ZS1pZDogMjAyNTAxMjktd2lwLWJvb3RtZXRoLXJhdWMtMDNiNWUyZGQ4OGY0DQo+ID4gDQo+ID4g
QmVzdCByZWdhcmRzLA0KPiA+IC0tDQo+ID4gTWFydGluIFNjaHdhbiA8bS5zY2h3YW5AcGh5dGVj
LmRlPg0KPiA+IA0KPiANCj4gR3JlYXQgdG8gc2VlIHRoaXMuIENvdWxkIHlvdSBwbGVhc2UgYWRk
IGEgdGVzdCwgZS5nLiB0bw0KPiB0ZXN0L2Jvb3QvYm9vdGZsb3cuYyA/IExldCBtZSBrbm93IGlm
IHlvdSBuZWVkIGhlbHAuDQoNClRoYW5rIHlvdSEgOikNCg0KSSB3aWxsIGhhdmUgYSBsb29rIGlu
dG8gYWRkaW5nIGEgdGVzdCBmb3IgaXQuIFNvcnJ5LCB0aGF0IEkgZGlkbid0IG1ha2UNCml0IGZv
ciB0aGUgZmlyc3QgaXRlcmF0aW9uLCBhcyB5b3UgbWVudGlvbmVkIGl0IHByZXZpb3VzbHkuIFdp
bGwgaXQgYmUNCm9rYXksIGlmIEkgYWRkIHRoaXMgaW4gYSBzZXBhcmF0ZSBwYXRjaD8NCg0KSSds
bCBwcm9iYWJseSBub3QgaGF2ZSB0aW1lIGZvciB0aGlzIHVudGlsIGVuZCBvZiBKdW5lLCBhcyBJ
J20gb24NCnZhY2F0aW9uIHRoZSBuZXh0IHR3byB3ZWVrcy4gQnV0IEkgZGVmaW5pdGVseSBoYXZl
IGl0IG9uIG15IGFnZW5kYS4NCg0KUmVnYXJkcywNCk1hcnRpbg0KDQo+IA0KPiBSZWdhcmRzLA0K
PiBTaW1vbg0KDQotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQ0KDQppSFVFQVJZS0FCMFdJ
UVRoOWpjOE5CVkttTUc5Z3hOUjNZVTQ1MmVUQVFVQ2FFS1J0d0FLQ1JCUjNZVTQ1MmVUDQpBZEdL
QVAwVVpKVmFYYlVvbDBLWHIwekg3TEFsdk1Qc3grYVdRMVpZMVoxTk9qTCthd0VBbVRFWmNNM3Jn
aTh3DQpIZTdrTkdscUtLdlNiZ1pDQzRqbHpjcE1tcnVBMVFRPQ0KPXRjTXQNCi0tLS0tRU5EIFBH
UCBTSUdOQVRVUkUtLS0tLQ0K
