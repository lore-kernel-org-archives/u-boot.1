Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6CD606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h01qf/AM;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iPSqZnRc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8579D40840;
	Wed, 25 Nov 2026 17:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N1BPAwfBpJDY; Wed, 25 Nov 2026 17:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C6E64082B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795626842;
	b=d9l+0EcZzIEf4fdNkadgijy31RQT8hDJvxnxPPAKvVpWASD350x3G0PHj0rOGy6HR+ke
	 a5ZikhyBDLTdINbDhv+VKe1JJvxIZvIc4Q/efySUzOUqFlfg5tfne/IQxjvDXUP023vPD
	 7MD/mAdiOtuhuEBZBCxDKa+N1Jmkn8m1Nw+EfrwHFukPr4OhezZZ5Dv4MGkH/lQ+rFFyO
	 0G24y6YtudOCuVdpzW3wLxnpTzkHZpviNtKIM6Ai65PO7cdYzuEiDV4zod1kFFrGgrOmI
	 UUgw+urx9cyfNwn7SQtLo+qIatHlxv510sHwhHxhKa1VzSWQlg8T7SPduZ3/B4ICaUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795626842;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-exchange-messagesentrepresentingtype:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-sharedmailbox-routingagent-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1kITVKC2YDbePSsP6D2pk+PF0zYwGJA1bGyykK61dDY=;
	b=UnCKKa8C5nQxdRYFtbB1g8J6WQrkBRfyiRs36ya9WBFDrLxq9ErISAu7ZKEP89IXWagU
	 0mcZv5zs20dQsR8JPdeKl41cVcNizHUjMoO1c2gEwlYveUYg0lqySMGt9L+hFCQJtXpbn
	 Qkg0Qs8tpHaJDjnnEpyvnWtaOF2Pl9YNAMGuhSa56pnI7iSlYVOsO2vrvKASm23ZGjVc8
	 qPrk5cHzQh8xzVFWUIpXZa9IRnBwE+01d7glxQXvJRVji6H0E9/VlH6Fjl3immxubJGXk
	 zm0TuV9CS1y4GVwBRmPFABR47V8Xy0CgfYelOTFLVbxuWWJOC4FoHwUPO6KOgtPSBxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795626842;
	bh=1kITVKC2YDbePSsP6D2pk+PF0zYwGJA1bGyykK61dDY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h01qf/AM7adSJpG855uN3R4iRv1ltTXBiydqAlbrln2DVYA9jrcjX0UeAQ/eAxpuU
	 umdcJvDJ+pthUH9L4IdMJjG21HgpxJ+G9a+9YJPISv8Z4fRuIrUX17CkZXeKTxnBn3
	 3wx7vk5mS7j1mL9jp5FYI57EhfNMkYvGSRliW0jFHYfYYhyjpfeUzs94Km2jolSFr9
	 vxofAg1hULwrk9I0uzjhoFw4+LRrIqRu2VxyAicHSMrXqvhpC3CIQ7DVCmyvtIXFXr
	 Ir3hWb5JS3JWsV5Nudb8Apyma/+zT8cktIKlv9N8yknE64pmxl3sSasM3S5MCY7wpl
	 6QNP78OKSMF7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C6E64082B;
	Wed, 25 Nov 2026 17:14:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C1F43
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B48F80CE8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YfDKhzATnrEy for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D350580CD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iPSqZnRc
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D350580CD8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kITVKC2YDbePSsP6D2pk+PF0zYwGJA1bGyykK61dDY=;
 b=iPSqZnRcZeYM3oypRBLug78wABkTXk1aD1Lp/S9VxLgI7WA2tFUmkBQthAKcOuANO4RFXMhAi46WbOvXsC2zh+oMJbmh5fKKGtzaIwgGaIUmsvUUHJuDV+bjScSErPwHin+FK5jN6pXPV5PmU4IJiJUwJjSp29cJau0KjYojnUvFWHgFxKfk7LbrNhOplSMRh0sV8UkzNDJp7NVLbjTtEbn5CJp05spOyBtW9XhdGb8aBfoNtuwMr4bj9sSJLELvZYE7vHXWXgzyHHkKKmmaymrVs0WLN7adKf8c7dE0n3kJ3vTqoVAmFt1qc7VN3LrNJpC+5daoiCfB884VLb0tBg==
Received: from AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24)
 by MI7PR04MB593597.eurprd04.prod.outlook.com (2603:10a6:290:104::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:13:52 +0000
Received: from AS8PR04MB7590.eurprd04.prod.outlook.com
 ([fe80::3470:a76d:78f7:317f]) by AS8PR04MB7590.eurprd04.prod.outlook.com
 ([fe80::3470:a76d:78f7:317f%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 17:13:51 +0000
From: "Marouene Boubakri (OSS)" <marouene.boubakri@oss.nxp.com>
To: "Marouene Boubakri (OSS)" <marouene.boubakri@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, Yao
 Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Guodong Xu <guodong@riscstar.com>, Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>, Michal
 Simek <michal.simek@amd.com>, Chris Packham <judge.packham@gmail.com>, Adam
 Ford <aford173@gmail.com>
Subject: RE: [PATCH 0/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys 2
Thread-Topic: [PATCH 0/2] riscv: add OpenHW Group CVA6 APU on Digilent Genesys
 2
Thread-Index: AQHdatBLa4vQ0rtyrUCfx/YZUW9eTbc/KnYg
Date: Wed, 25 Nov 2026 17:13:51 +0000
Message-ID: <AS8PR04MB75902DF483414F9F90F45EF9FC432@AS8PR04MB7590.eurprd04.prod.outlook.com>
References: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
In-Reply-To: <20261102135820.640652-1-marouene.boubakri@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-25T17:11:44.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB7590:EE_|MI7PR04MB593597:EE_
x-ms-office365-filtering-correlation-id: c27fb318-d61f-4106-3f3c-08df4b177a59
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|19092799006|23010399003|261022105027099003|38070700021|56012099006|10067099003|11063799006|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|6133799003|22082099003|18002099003|261009223027099003;
x-microsoft-antispam-message-info: RcSROUHxE+B+EBdjLKwFkbOCsEsFDw5wg4sMIlabhWmppEVgmYfZh3NCxxtlRcfXPOExGgXv9J3WBypslD+gM8/hn8qCNErEY3CQOuo9KssAnLGP7plPY70PQVUB0fADlyZAgrZWNtczf5/Jnd2nAuq2MzDxpNQyj9nCURKgXNf7MxNjSk+P9MkX7zDDHk/9t0dwasv9HmzE2bzhyNhOBPDcSylrK3+X2is3IpqBBc0xfU0izFDCcNH4K1zl3hznyKr+vMJONa3nEjAXDfLQ/8bG9WtA89lDiGFPLBsrV4jvYh2yAO7cc9EPpTixCDp1E934C6c9h9OX4JB9LPSjx6pd/azighmTL14C+oahOgLnfK6P6YktkRJrClidTYAGuLOytIIyKGA5d6ew9x+EHNl8ErGYkP7OKzy2SN9MJjurPu3qVzfwwfo/+SOIEdIjdN2yPKjseosWtueOgPva8tcotfsHxImUBdrNmBDXh6iW/9+WI4glhav7c9Cab56wkeDRDA3ZSsppAVzL6rV/BQx4EGYtGLbEUaONpykilLkvKl093JjA24mW6Q745+J4kk7QrSI2riEFmhPyDpEBXsfGHfZYtTvuj521lQQi7WuuXkIpkkTenmwgXOxhXb9WvDgXgkBeLABfZjNQyfsjjj6us4AqTT5hgSwmHxbp3J6li5Idqzw1u0s/fhe06npS7F0O0BoJ6T99md/0ejoMrPtB+1jSRdJ2Yk5H/55BT+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB7590.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(23010399003)(261022105027099003)(38070700021)(56012099006)(10067099003)(11063799006)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(6133799003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFZiR0R2Z1FObTFLK2RlNFNWVHVjcFMwc1ZLamEyeVQzSG1rbWZmMVVmK3dt?=
 =?utf-8?B?dXA5OUxXYTFFQWg2Q1dUSVl4MURYQUhMci9wRVM4NGZqMm9FNjdsK2xRdk4y?=
 =?utf-8?B?YVFSdStEZzZYem5vWEpuRW1yYk9SQXRFVXNRSjg1b0JTUDdua2o1Szl2VjQv?=
 =?utf-8?B?WGFWVDAxei9TNEwzSFFVS21Eayt6ZEJYeXgzcU11alpBNmJ1ZkVSY1RsNEk5?=
 =?utf-8?B?VUNzb284RTdrelhaVVNkZVg1NW4rcERGVTdXTXJqM3BJTlhSdno3dldsMmVO?=
 =?utf-8?B?YXlZU2hZV2gzQXNSN1pXWE8vVGJZQzBpdjNlbkdRejRtMnVRS2crNVNoNjRp?=
 =?utf-8?B?T2NxN2hYM05zT01CRGNHTDMrQW41ZCtleEpEdU82ZjlqVHlJV2dpbThoS3Ey?=
 =?utf-8?B?WW83LzFGSFAyWHlFdU9CaUIweW1Oc3MwcCt3SzJxYStWTmhhbXF6L1g0WTFC?=
 =?utf-8?B?bnVSV1lQTW1hSzNsSGRWa0k5dXozV09maldVZXB1ODl3cWloVk1ndE1VeXI2?=
 =?utf-8?B?bE1OUkFiWFNSbkdWazB5SXZMOUx2eS9OU2hoTW5XNU5leDRqQlVXdVBSTm11?=
 =?utf-8?B?WktOYVpacnpIVXlJY0dSTXJ1ZTZnY2t2V01SWFN5MFNBWGIvKzdjeHNsZzNz?=
 =?utf-8?B?Q2RCRU5pMm9Pd0c2THkvbE1tdUZZellsc09hdG5KUkdjck9rUWJPK3RXWm9t?=
 =?utf-8?B?RUdjWExHWFFSOVViK2JKK0pMVk1JUk9BaGhOVVNiNTI1Tnl2T2V3U1VtMCtB?=
 =?utf-8?B?U0JlSjkyUWVhUVYzclZHMGRuVUlBV0c1Y2ExL3krUGp6aTI0U2pxSVBvS2RD?=
 =?utf-8?B?T0R3VzZkcWNmNFJvL3BaSk93QThmcFZrUkNyeFphZVRzSGZ6UkVBWVNJR3BU?=
 =?utf-8?B?U2kxbXdhV1J0S3RvVXRjS1R0TFMwa2cxMGVkVWpLdXhFNEV5VVB0Ung4VGY5?=
 =?utf-8?B?TWNSYlkvckZibGc5R1RkVVIvdmVRcHZNeHJOeTc0Wm80UjhPK3VXK1NZVGgw?=
 =?utf-8?B?cmhKajh6ZTBHRlhDdUJ3eWlwR3hlR2wrVUdxZ29WWlNXelFlVk5RV04zM2pq?=
 =?utf-8?B?TkczcmlrZmNPV3VUcUVFbHR1bFM4ZEpVeGJKaHdtNnI1SFk5eFNibTNmY0Fh?=
 =?utf-8?B?WFZxSjNhaHJIUmdCUzloZmZ1d0NUMGkzcmxVMkdGWEVydyt2OEVZWmRmTG4x?=
 =?utf-8?B?ZTV3YWRsMnNDZnNGVi9RRGZNcHVJNjhpeTNGbzhYU0pRbVdXRFlkd3kvcXFa?=
 =?utf-8?B?eEpXTldUL2J6dnBKWFk0dkN5OFA2dlVUR1Juc090VC85dWZYdW5HUGtyU0Zr?=
 =?utf-8?B?ckkyOFBsbHFyeGR3V1pSWitBVW4wMTNGbHIwb2N2S2wwQm1McVR1TVlLYm1j?=
 =?utf-8?B?VXhkNUs5dVJqZGhzNHdOMFBqa1Vjc0s2b2tTS0prbkEzbnIzN3B4ZW4xZE9s?=
 =?utf-8?B?cXpPZkhIS25KUXE4R01GMXBjcFhKZUxlTUJEdHlYNHZmMDJkNGJQMFN2MkV6?=
 =?utf-8?B?cHphTmRUVjdQeTl2OS93ZTZrUTBNaWNJK2dvbTA0Q1M1eVdkemdOWGxtaGVt?=
 =?utf-8?B?MmprdkxDREp6RFVNQngvWHdlcndoT3ZseURyNkJHSExhbU4yaTRBNW81OVVV?=
 =?utf-8?B?VTNVNUxZTHJEUFJzdkljOHZSdDZyY0NtbndrZE1DRjgxS1JVUU9HMlRPbDdp?=
 =?utf-8?B?dmZ1VlFTQ1VrZCtlTGlERC9rSkJqZkNVS3U4eGtOd3JEQkFCOERubS93RFR2?=
 =?utf-8?B?c2ExTUpheEpicWFGN2VVcERmeTF4TDJhWWRiQlEyb1FWTFJuTldwTTg5TFVY?=
 =?utf-8?B?ZGNhVUpoclhaUENaMHdRSHYwUG5CNmk5cDY0Yk83ZHNGSndZd1VURVVsSjQ4?=
 =?utf-8?B?U1lNNXJkcGlVWnVkcEk0K0lqUmlEZTA0S3I3a01zb05tK0xlSldmZC8ybWVj?=
 =?utf-8?B?M29TVHdubzkwN0RXa3VXRkVySjZoSExkLzlndzZqT3RJYmhvMjFnSHdJbFBt?=
 =?utf-8?B?cVRUazRyeXcwNkRwdThBMFd1RGlUU3BxdjlSRnIvTVpMRHpxSGtNMGQ5U3d0?=
 =?utf-8?B?U0l1alRERW1wTlBGYVVkbHpTOGRadElTRkdyREx0THJXdlk2L0NKalVBbVJP?=
 =?utf-8?B?UCtjN0NkUm5iR0pyc3pJY1FDKzZZSmVVK1p5akc4bVlla2RSZkt2TldFcnJa?=
 =?utf-8?B?T0hacXZhR0VNdWNVRngvZzdWTjhKckwzOWdOMStEcnB6UiszbTZTM05JcmhV?=
 =?utf-8?B?KzBBNTJXVlViWFAySTJLU25XdDJWdWFWUytocGFRUW9lbk1GSUNTbDN1Q1A1?=
 =?utf-8?B?U0xhZ2d3S0c2K0t1ZzNKZVRDL0h2OEcvQmlydmt3R2hIdDhlRVc1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27fb318-d61f-4106-3f3c-08df4b177a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 17:13:51.8529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CpEAsCUdjOCfnR7y091uIA9NGS7bCfxGkl1uFSm/Psq1hy4zllGV/1UhIJ/Ml2y3mZZktlw6S1B5dkTgKkZjXVf8NSY+XXq6Fd11fHl3jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB593597
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTGVvLCBSaWNrLA0KDQpHZW50bGUgcGluZyBvbiB0aGlzIHNlcmllcy4NCg0KSXMgYW55dGhp
bmcgYmxvY2tpbmcgcmV2aWV3ID8NCg0KVGhhbmtzDQpNYXJvDQoNCg0KTlhQIENvbmZpZGVudGlh
bA0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hcm91ZW5lIEJvdWJha3JpIChP
U1MpDQpTZW50OiBNb25kYXksIE5vdmVtYmVyIDIsIDIwMjYgMjo0NSBQTQ0KVG86IHUtYm9vdEBs
aXN0cy51LWJvb3QtcHJvamVjdC5vcmcNCkNjOiBUaW0gT3V5YW5nIDx0aW02MDlAYW5kZXN0ZWNo
LmNvbT47IExlbyBMaWFuZyA8bGVvLmxpYW5nQHNpZml2ZS5jb20+OyBZYW8gWmkgPG1lQHppeWFv
LmNjPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IEUgU2hhdHRvdyA8ZUBmcmVlc2hl
bGwuZGU+OyBHdW9kb25nIFh1IDxndW9kb25nQHJpc2NzdGFyLmNvbT47IEhpYWdvIERlIEZyYW5j
byA8aGZyYW5jb0BiYXlsaWJyZS5jb20+OyBSYXltb25kIE1hbyA8cmF5bW9uZC5tYW9AcmlzY3N0
YXIuY29tPjsgWWl4dW4gTGFuIDxkbGFuQGtlcm5lbC5vcmc+OyBNaWNoYWwgU2ltZWsgPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgQ2hyaXMgUGFja2hhbSA8anVkZ2UucGFja2hhbUBnbWFpbC5jb20+
OyBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT47IE1hcm91ZW5lIEJvdWJha3JpIChPU1Mp
IDxtYXJvdWVuZS5ib3ViYWtyaUBvc3MubnhwLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAwLzJdIHJp
c2N2OiBhZGQgT3BlbkhXIEdyb3VwIENWQTYgQVBVIG9uIERpZ2lsZW50IEdlbmVzeXMgMg0KDQpG
cm9tOiBNYXJvdWVuZSBCb3ViYWtyaSA8bWFyb3VlbmUuYm91YmFrcmlAb3NzLm54cC5jb20+DQoN
ClRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIE9wZW5IVyBHcm91cCBDVkE2IEFQVSwg
dGhlIEZQR0EgU29DIGJ1aWx0IGFyb3VuZCB0aGUgQ1ZBNiBjb3JlIChodHRwczovL2dpdGh1Yi5j
b20vb3Blbmh3Z3JvdXAvY3ZhNiwNCmNvcmV2X2FwdS9mcGdhLCByZWxlYXNlIHY1LjMuMCksIHJ1
bm5pbmcgb24gdGhlIERpZ2lsZW50IEdlbmVzeXMgMi4NCg0KQm90aCBjb25maWd1cmF0aW9ucyBv
ZiB0aGUgY29yZSBidWlsdCBmb3IgdGhpcyBib2FyZCBhcmUgY292ZXJlZDogdGhlIDY0LWJpdCBj
djY0YTYgKHJ2NjRpbWFmZGMsIFN2MzksIDEgR2lCKSBhbmQgdGhlIDMyLWJpdCBjdjMyYTYgKHJ2
MzJpbWEsIFN2MzIsIDEyOCBNaUIpLiBUaGUgU29DIGRlc2NyaXB0aW9uIGlzIHNoYXJlZCBpbiBh
IGR0c2kgYW5kIHRoZSB0d28gYm9hcmQgLmR0cyBmaWxlcyBvbmx5IGNhcnJ5IHRoZSBjb3JlIHNw
ZWNpZmljIHByb3BlcnRpZXMuDQoNCkFzIGZvciB0aGUgUUVNVSBhbmQgT3BlblBpdG9uIGJvYXJk
cywgZWFjaCBjb3JlIGdldHMgdHdvIGRlZmNvbmZpZ3MuIFRoZSAqX3NwbF9kZWZjb25maWcgdmFy
aWFudHMgdXNlIHRoZSBzdGFuZGFyZCBSSVNDLVYgYm9vdCBmbG93OiB0aGUgQ1ZBNiBib290IFJP
TSBjb3BpZXMgdGhlIGZpcnN0IFNEIGNhcmQgcGFydGl0aW9uIHRvIERSQU0gYW5kIGp1bXBzIHRv
IHRoZSBVLUJvb3QgU1BMLCB3aGljaCBydW5zIGluIE0tbW9kZSwgbG9hZHMgdS1ib290Lml0YiBm
cm9tIGEgRkFUIHBhcnRpdGlvbiBhbmQgaGFuZHMgb3ZlciB0byBPcGVuU0JJIGZ3X2R5bmFtaWMg
Y2FycmllZCBpbiB0aGUgRklULCB3aGljaCBzdGFydHMgVS1Cb290IHByb3BlciBpbiBTLW1vZGUu
IFRoZSBwbGFpbiAqX2RlZmNvbmZpZyB2YXJpYW50cyBidWlsZCBVLUJvb3QgcHJvcGVyIGFsb25l
LCB0byBiZSBlbWJlZGRlZCBpbiBPcGVuU0JJIGZ3X3BheWxvYWQgcGxhY2VkIGluIHRoZSBmaXJz
dCBwYXJ0aXRpb24sIHdoaWNoIGlzIGhvdyB0aGUgT3BlbkhXIEdyb3VwIENWQTYgU0RLIGJvb3Rz
IHRoZSBib2FyZCB0b2RheS4NCk5vIGNoYW5nZSB0byB0aGUgZ2VuZXJpYyBSSVNDLVYgY29kZSBp
cyBuZWVkZWQuDQoNClBhdGNoIDEgYWRkcyB0aGUgZGV2aWNlIHRyZWVzLCB0aGUgYm9hcmQgc3Vw
cG9ydCBhbmQgdGhlIGRlZmNvbmZpZ3MsIHBhdGNoIDIgdGhlIGRvY3VtZW50YXRpb24uDQoNClRo
ZSBjdjY0YTYgU1BMIGNvbmZpZ3VyYXRpb24gaGFzIGJlZW4gdGVzdGVkIG9uIHRoZSBHZW5lc3lz
IDIgd2l0aCB0aGlzIHNlcmllcyBvbiBVLUJvb3QgMjAyNi4xMDogdGhlIFNQTCBsb2FkcyB1LWJv
b3QuaXRiIGZyb20gdGhlIFNEIGNhcmQsIE9wZW5TQkkgc3RhcnRzIFUtQm9vdCBwcm9wZXIgYW5k
IFUtQm9vdCBib290cyBMaW51eCB0aHJvdWdoIGV4dGxpbnV4Lg0KVGhlIGN2MzJhNiBjb25maWd1
cmF0aW9uIGlzIGJ1aWxkIHRlc3RlZC4NCg0KTWFyb3VlbmUgQm91YmFrcmkgKDIpOg0KICByaXNj
djogYWRkIE9wZW5IVyBHcm91cCBDVkE2IEFQVSBvbiBEaWdpbGVudCBHZW5lc3lzIDIgYm9hcmQg
c3VwcG9ydA0KICBkb2M6IGJvYXJkOiBhZGQgT3BlbkhXIEdyb3VwIENWQTYgQVBVIG9uIERpZ2ls
ZW50IEdlbmVzeXMgMg0KDQogYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA1ICsNCiBhcmNoL3Jpc2N2L2NwdS9jdmE2L0tjb25maWcgICAgICAgICAgICAg
ICAgICAgfCAgMjEgKysrDQogYXJjaC9yaXNjdi9jcHUvY3ZhNi9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgIHwgICA1ICsNCiBhcmNoL3Jpc2N2L2NwdS9jdmE2L2RyYW0uYyAgICAgICAgICAgICAg
ICAgICAgfCAgMjAgKysrDQogYXJjaC9yaXNjdi9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAxICsNCiBhcmNoL3Jpc2N2L2R0cy9jdjMyYTYtZ2VuZXN5czItdS1ib290LmR0
c2kgICAgfCAgIDYgKw0KIGFyY2gvcmlzY3YvZHRzL2N2MzJhNi1nZW5lc3lzMi5kdHMgICAgICAg
ICAgICB8ICAyOSArKysrDQogYXJjaC9yaXNjdi9kdHMvY3Y2NGE2LWdlbmVzeXMyLXUtYm9vdC5k
dHNpICAgIHwgICA2ICsNCiBhcmNoL3Jpc2N2L2R0cy9jdjY0YTYtZ2VuZXN5czIuZHRzICAgICAg
ICAgICAgfCAgMzAgKysrKw0KIGFyY2gvcmlzY3YvZHRzL2N2YTYtZ2VuZXN5czItdS1ib290LmR0
c2kgICAgICB8ICA0NyArKysrKysNCiBhcmNoL3Jpc2N2L2R0cy9jdmE2LWdlbmVzeXMyLmR0c2kg
ICAgICAgICAgICAgfCAxNTYgKysrKysrKysrKysrKysrKysNCiBib2FyZC9vcGVuaHdncm91cC9j
dmE2X2dlbmVzeXMyL0tjb25maWcgICAgICAgfCAgNjAgKysrKysrKw0KIGJvYXJkL29wZW5od2dy
b3VwL2N2YTZfZ2VuZXN5czIvTUFJTlRBSU5FUlMgICB8ICAxMiArKw0KIGJvYXJkL29wZW5od2dy
b3VwL2N2YTZfZ2VuZXN5czIvTWFrZWZpbGUgICAgICB8ICAgNSArDQogLi4uL29wZW5od2dyb3Vw
L2N2YTZfZ2VuZXN5czIvY3ZhNl9nZW5lc3lzMi5jIHwgIDI0ICsrKyAgY29uZmlncy9vcGVuaHdn
cm91cF9jdjMyYTZfZ2VuZXN5czJfZGVmY29uZmlnIHwgIDE4ICsrICAuLi4vb3Blbmh3Z3JvdXBf
Y3YzMmE2X2dlbmVzeXMyX3NwbF9kZWZjb25maWcgfCAgMjQgKysrICBjb25maWdzL29wZW5od2dy
b3VwX2N2NjRhNl9nZW5lc3lzMl9kZWZjb25maWcgfCAgMTYgKysgIC4uLi9vcGVuaHdncm91cF9j
djY0YTZfZ2VuZXN5czJfc3BsX2RlZmNvbmZpZyB8ICAyMiArKysNCiBkb2MvYm9hcmQvaW5kZXgu
cnN0ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRvYy9ib2FyZC9vcGVuaHdn
cm91cC9jdmE2X2dlbmVzeXMyLnJzdCAgICAgICB8IDE1NyArKysrKysrKysrKysrKysrKysNCiBk
b2MvYm9hcmQvb3Blbmh3Z3JvdXAvaW5kZXgucnN0ICAgICAgICAgICAgICAgfCAgIDkgKw0KIGlu
Y2x1ZGUvY29uZmlncy9vcGVuaHdncm91cF9jdmE2X2dlbmVzeXMyLmggICB8ICAyNSArKysNCiAy
MyBmaWxlcyBjaGFuZ2VkLCA2OTkgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBh
cmNoL3Jpc2N2L2NwdS9jdmE2L0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2
L2NwdS9jdmE2L01ha2VmaWxlICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9jcHUvY3Zh
Ni9kcmFtLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2R0cy9jdjMyYTYtZ2VuZXN5
czItdS1ib290LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9kdHMvY3YzMmE2
LWdlbmVzeXMyLmR0cw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2R0cy9jdjY0YTYt
Z2VuZXN5czItdS1ib290LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9kdHMv
Y3Y2NGE2LWdlbmVzeXMyLmR0cw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2R0cy9j
dmE2LWdlbmVzeXMyLXUtYm9vdC5kdHNpDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
ZHRzL2N2YTYtZ2VuZXN5czIuZHRzaSAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJvYXJkL29wZW5od2dy
b3VwL2N2YTZfZ2VuZXN5czIvS2NvbmZpZw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9vcGVu
aHdncm91cC9jdmE2X2dlbmVzeXMyL01BSU5UQUlORVJTDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGJv
YXJkL29wZW5od2dyb3VwL2N2YTZfZ2VuZXN5czIvTWFrZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgYm9hcmQvb3Blbmh3Z3JvdXAvY3ZhNl9nZW5lc3lzMi9jdmE2X2dlbmVzeXMyLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgY29uZmlncy9vcGVuaHdncm91cF9jdjMyYTZfZ2VuZXN5czJfZGVmY29u
ZmlnDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3Mvb3Blbmh3Z3JvdXBfY3YzMmE2X2dlbmVz
eXMyX3NwbF9kZWZjb25maWcNCiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy9vcGVuaHdncm91
cF9jdjY0YTZfZ2VuZXN5czJfZGVmY29uZmlnDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3Mv
b3Blbmh3Z3JvdXBfY3Y2NGE2X2dlbmVzeXMyX3NwbF9kZWZjb25maWcNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgZG9jL2JvYXJkL29wZW5od2dyb3VwL2N2YTZfZ2VuZXN5czIucnN0DQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRvYy9ib2FyZC9vcGVuaHdncm91cC9pbmRleC5yc3QgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2NvbmZpZ3Mvb3Blbmh3Z3JvdXBfY3ZhNl9nZW5lc3lzMi5oDQoNCi0tDQoy
LjQzLjANCg0K
