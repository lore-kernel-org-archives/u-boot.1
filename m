Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA6606A861
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AcCNWcwM;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WMV1UJqp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 014A580A9F;
	Fri, 27 Nov 2026 14:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlTP5JcvOQ4D; Fri, 27 Nov 2026 14:39:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25BB980F0E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795790349;
	b=kH24JunHbNR+3p4VJ8sVA9SjPEJtIdRQ1Ec3BWJ0+gpZVstN/0lPKUA9V+phY+PcvdFr
	 6wV3L2JvMvXEAG+vF5NkYhSGHDG+3zv3iuhf0E6i1EoHBpEOkuyeWrJJ3fmnlGn4qaEcj
	 +0c3zhqSbNaOpIgDP5+FrMXS51Hn+skOj4G399flD3ySYi92YZLyNTrrg9MndrOHQAcnt
	 C8JRUP2b8FJ2y+I6Y4kOAMiuI64aU04k6xFL8DrWNZN3JLNyXJoAqRNSozcBMeXdLsr6p
	 WwZ+9/K4UvxK51ImLVr22KO0QBZqsYncoM3gfBJptt/hN9FUL8bjiX+MrW5GKlo7DTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795790349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
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
	bh=EFVZgtSZGjRRtULoXYo9p/uGNfDxSDOKxfurY0YsBuE=;
	b=O6daf2A6OHATf+wF8Idvd+4YA6Txz2dz/7k8GZv15lXVMZpatf8u8SU49ri/XDkN0RFz
	 7+oa2dvGe5nl6/Rk+sXE4VU+dpfLOKaKGrVPysTUG0K4v8Mhnuharmy0BzQm/Wgluinx4
	 I6NE/5CMC6DKXvfds3iaf+WHH5JRPh/wTLOMcJYS4/5fP2cTrb7zYJ5L8NK/OlHH9d/LB
	 KxdXKrXS8PrCBiQqIQ4i9/scXVbnKW7GzmdEL4kicOEJ+11lHkab85QAx2Ms2FO36G8MO
	 RgxXT43mQ2/xc9bpBkGyYjE86bYIVqsBGgQqSxiuOofBAPiRP8kno7OEAo+stINzkpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795790349;
	bh=EFVZgtSZGjRRtULoXYo9p/uGNfDxSDOKxfurY0YsBuE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcCNWcwMup+DbGYtapm5sWwP5dQOAht8YICjg3WQEJRL/rxwS81DANPxgjjhxYem9
	 6ql/jY9YsqaswpTrTXViGTjCuLu8CcNb8EnfEEcoRsjJt+5uNJumiRyfimuoK1KZIz
	 vT8GmWTdLbyfyJMTwoFRPFZqPUqENVaftgLcNTgPVLsZduT1D5Vhs8btrFZIfHh2ol
	 uO9ZwtmfZVGRmfdTEe8O1zHAAvV5lHJxCZ8fi6jn6mN3cJu3er9oG4isukGvyBwVAd
	 hTHKxP/7nMDZNXZ0n1eLmPqbA7GK/DYT1cnBg2Ew7hmFZBVcL6j4JOvEDZj1RZyDf9
	 wDAPR+OeoAQ7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25BB980F0E;
	Fri, 27 Nov 2026 14:39:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 481F4373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E411404F1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PyljnYni7xgJ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 14:39:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 54E10404EB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alexander.sverdlin@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=WMV1UJqp
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54E10404EB
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFVZgtSZGjRRtULoXYo9p/uGNfDxSDOKxfurY0YsBuE=;
 b=WMV1UJqp7vfuz/S5VLbEBU9sQ23hutMFqYmNbmZIEyrFY+EydvozUeQLY6GjAzxypTdOLY6K5h1b4VXX/bs4+c+wrT+irUbFXrUqO0OhOs3Spp2kI7AQftJZQAskDYnKp++AX8FGwcGHqQu52mAUjAHn0l+O1Nmp8OyLIVtsmt0sbvvZrUYyXPVOVOxoIxIhGGxCN1B1TDTpQhL3KZvI2baCDtTnwPJR7Vymeq2680YBU6/DPL2fLgueZwHWllZMSfDy+5ztYKo/oU6wLx08FxaEaPCWNMGnk1tv35AbRjnbKzEJAMB+o2F+JEXVoKXgePiKuiLaZjTMJRL/dNb++A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA2PR10MB8477.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Fri, 27 Nov
 2026 14:38:58 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 14:38:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "vjardin@free.fr" <vjardin@free.fr>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: "jerome.forissier@arm.com" <jerome.forissier@arm.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "maxime@leroys.fr"
 <maxime@leroys.fr>, "peng.fan@nxp.com" <peng.fan@nxp.com>
Subject: Re: [PATCH] net: ldpaa_eth: track the open state in the driver
Thread-Topic: [PATCH] net: ldpaa_eth: track the open state in the driver
Thread-Index: AQHdfkfGXWHFmMZ/WEKcyCYpd6zySrdB/XyA
Date: Fri, 27 Nov 2026 14:38:53 +0000
Message-ID: <6642ed077e3af23939ae1f15a06368b3e7ef8ce9.camel@siemens.com>
References: <20261127081721.788638-1-vjardin@free.fr>
In-Reply-To: <20261127081721.788638-1-vjardin@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA2PR10MB8477:EE_
x-ms-office365-filtering-correlation-id: 9fa9699b-e7ce-46d3-6882-08df4c942939
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|6133799003|55112099003|18002099003|56012099006|11063799006|261021123027099003|261026121527099003|261009223027099003|261021121427099003|38070700021|261102123227099003|10067099003|15866825006|41080700001;
x-microsoft-antispam-message-info: ku0m30ny9NsbCxWXIq/FuxZeriwtRNB9vMmE6NU+Anrvy17YceSLY0l9irbz4rXplalvE/4rJlBZSnvhKCphSzPRk6elz+pkgR8p9wxNE4ThZEIPDmLadnB7NVnvPG7ugC8uerMctSTZOwfeWSsjQoSYCvHzIfR8ZQ0ftaKQxys8w/Ue37rw/JKJSnaSuQecznBAK5eUi5LOzMKxnRSuIBpmqS6JafK5xwpHWD5B7yuwMBA5UN1AOZYA+AGNvkHcx3qwRhplKczEB/ApNEddcpuaaaXYTskKS7Y3uEWatOpuHV79hiqtufFntVOTR62KHPtHVbsgmxof4Jb/Hxw8mB0TF0UCGiiHB/K2aVBh7Usc+axgnzdwRZDXciQwz2RtU3PF9U18sl4+JZPrkb50K1VApRfwih+QfLKvxjzzSCWpG/AWXNi90a+kjS58FkY+6A5C0UCqMJzcq332iY4h5CN12qiC1UZ+7QOlLfuDCPoi6xQwRKiYtfr7sm63o5r8UEbJO64UovZc/+LXePwIxq6qVZsiNWf3PyYhAhBVWtUyGkomnA8K/Z18cwR0q+xo4iFpB4kUFb+81onM/iN3o3r7Uj/C/C+AoQu4AZkV8fCdEhfUSjwLQdDDqGltl9ZjWub0TV15+RDO+OSYSPrZ1/HZ8oCf9AXRR/3rmxUPooywlI7xncpZibLAQU2kEo5VD8vsXSDPG3GwpoxjO3GGwTJoh+QhGS8XllryadF2n/o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(6133799003)(55112099003)(18002099003)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(261009223027099003)(261021121427099003)(38070700021)(261102123227099003)(10067099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzYwaWxUdzJlQ0RUb2hZR0NFVnhBcXpOZEZsTGtJeWQ2aERBNFNFYkZrcGp0?=
 =?utf-8?B?MjNWUFVuOGFqcFhkNXlIaEdQMmZDdXc4Q3dxNVhhTXRjRjNPQU9GYkRSWk9W?=
 =?utf-8?B?TVE4RFJQdHo0dkJUbnNlcGE0bVRlSndqS3dLMmpxL3ZiOERjZG4zY3pmQUZC?=
 =?utf-8?B?VCt6WjE1dlUwK0xpa3JST0ZVOGRJQ3kycmNQZ2lxOGtoekdvd284T215ZEVv?=
 =?utf-8?B?d21OWXZOSDNPdFVLTlJQdU1oYlF6eVRFa1J6UjhKdDI2NXhmeGIxemlKcHdZ?=
 =?utf-8?B?VW0rdFRLWFNDQlVlYkdLUmZ2ZW9zbWMrcFFQMSt0cUd5Q3VZRUp2OUdUYXNE?=
 =?utf-8?B?VUdPYld3V1dMQzZLMmhQZFpzTkIrZlpmRnpXd2VmVkF0Z3N6TDBVMmF4WHpI?=
 =?utf-8?B?ZVlLR0xzcjFKQTllR1dLMk5KYlBoalNRNjMrTWtiSEtXcTRIWEdhZlRxaEJJ?=
 =?utf-8?B?RE1wUzFnMUMzR0NlUnVzRTBDWkhxdXpqaUduakJNTThHM3lPbWd0NTQxblla?=
 =?utf-8?B?N3U3aXZSSlMydUdUTHZtM2xZSnMyY1RCWDUwUnpRMTM1SDNIQUhNcy9LVlpj?=
 =?utf-8?B?YWcyL3ZEcEtTWDZrczA2VkNMZGVkNThiNTNVdTdickRBYzdsbnBTWTA2N0d3?=
 =?utf-8?B?eFIxMDcrZGR0bXRJS3JtbUpoSnVBWWVDTit2dnRtYklENGE4UG9Gb1lvbUMv?=
 =?utf-8?B?U0hJRW1lQmJsYUVvWDVuZy9VKzZ4Y3RSMVhaMkswblIxMnJDRGk1RGxnNlB3?=
 =?utf-8?B?Z2RvWVUweTFwSm5ERUVSWXhnZ2NaWTd5a016eERVU3JYRFA4NWtIZStFSDdD?=
 =?utf-8?B?SksxcXZMMDBLSGdBTUtkcjJ6eUlSOVBoM093VU94MDFzQUE0c1prVW9WYlBx?=
 =?utf-8?B?TXROcit6TGNyalNzRFRJTEVUV2E0SzdmODZmZktYcXp5THdoMXJ5d3p2TU9N?=
 =?utf-8?B?djg0ZWtoZzFzM0FMTFFtN1VSUmlwM1lVTUw1VThISmprOXRzMldHK3pleHlp?=
 =?utf-8?B?bXBwMWtkTFJ2Wk1zNEllS3pNT256ZFdtQ0lJZjJHTzkxWDdoOU56VU8rbm51?=
 =?utf-8?B?SXA2V09VdE5uMVNJRnIzdE1YdW1wMzFnSTBHZ2VXMzc4QTdUUkx1T1cxQ0xW?=
 =?utf-8?B?eFJ3eCtDazF1K2RvbldHSTMya2ZLeG9zSHpZZ2Z1L2FCOEpiT0xqUU52SWJ0?=
 =?utf-8?B?Ty9qTjZtUGp6SWNDNHhmOFNNSk1icFh3VGRhRWZzOTdJYm9NdVRwU3ZlRGg5?=
 =?utf-8?B?cm1majF5ekZEZjhoVmRKS2JSTFBXemk5MWZSS3AwUExXcGcxaEtpZ0lQV2t6?=
 =?utf-8?B?cTdRdXh0YmRjTVBoN3pvRENwd2hZeE84bU8ybW83M281Q1NhUjhweVZzRHpq?=
 =?utf-8?B?SXhWbDJQUThmS2NxOGNtR0ZIRHM2YUtoMm4wdjBNZWhuVkN0YUt1aE9rQkJM?=
 =?utf-8?B?RUU2Mnl6anJsZUNvZGlDRFlacEhlZTZndHlsWmUwcWJyYS85QW1aZ1dFcGw1?=
 =?utf-8?B?R1RCZHJIUFduUS9TMjhPU0FzUDVnK3ZpeGJmakptejhNZFVTVkxzdDhlb1l2?=
 =?utf-8?B?SXoxYzdRSVFaQVdhSngwdWR1NlJ3NnFRd25ZbDFVK0ZLYkIvZklwUzNwTzFG?=
 =?utf-8?B?bjhObnMrMWxUUE9QTndFeElOOHVFY2Z0S2xpVFdnRHpLZzlYUlVNSWY2ZnlK?=
 =?utf-8?B?cWoyT2x2OVJOMnRLanFFVXpxYWpzbStmRXQ4Z2FDSmdxMnlXTnN5QnZyUll4?=
 =?utf-8?B?TThPVUVpTXc5b3Qvc1VuY0hSNDA3anltVVdJa3FVbUc0U2dIOHNNdmNTOTc2?=
 =?utf-8?B?UFJSWkdSZUl4R1k2YUZWUm8vTlBwS2NVNVFPWkhRcVJ1NWRMYXA4UDZ3c1RG?=
 =?utf-8?B?SXJoMFFDbUZvck9uV1djUnRIWno0aUJZVWZ4Y2RURUFMM2FoaDBmWEtDNXJX?=
 =?utf-8?B?b0tpbFZGZXREMlNtdXJoUWRVbkFqbXplWDVETEYyd3gzNWx6eWVpelloUW15?=
 =?utf-8?B?R2hVRHc2NGk0NEhhMXNHc0Z3RzNYR21zYS8zVWZLT2d5M0ptcS9iNlZpZHBW?=
 =?utf-8?B?QWs4OHJMVEM5QXp4dENEWnFubUdmSDlvL05QUEJDMUY2WmoxN0lDQWNyV3l3?=
 =?utf-8?B?UTRzYXd0a2NSVVg2bjV4dDFKUUFFanlWZnJHVXQzdDZPMUtwL0w0RitrTkNo?=
 =?utf-8?B?MU9ST3AzMmsrYURGb0xxa2QzbDdqeVIxMy9GVG5Ydm5QSExGcHU5K1dHT3Ja?=
 =?utf-8?B?dUl6clljcmpxV2VwWW5ZOFVsUWx1U09xTEVNWWlBakhXcVptVFJXNHpVbjJT?=
 =?utf-8?B?azlGam8wemNHQlpRZ3pyYlZMNUsrNFBCVko3Vk1ZRERaY0pVc2tINmlZZG12?=
 =?utf-8?Q?Y2ZVuMD0iU3WAd0c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC121F0EB74F0046957CC1E1783D3492@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa9699b-e7ce-46d3-6882-08df4c942939
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 14:38:53.9199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KtzFKbed/jp1vdcZaq9vlxICx8cDh3gjcG1XAXWyqkOohMcaklrUCeSUBdJc96Oce2uUgnV4qUXsQW54CAkki7pfYE/GYRLjjV2A4IKURBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8477
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVmluY2VudCENCg0KT24gRnJpLCAyMDI2LTExLTI3IGF0IDA5OjE3ICswMTAwLCBWaW5jZW50
IEphcmRpbiB3cm90ZToNCj4gRnJvbTogTWF4aW1lIExlcm95IDxtYXhpbWVAbGVyb3lzLmZyPg0K
PiANCj4gbGRwYWFfZXRoX29wZW4oKSBhbmQgbGRwYWFfZXRoX3N0b3AoKSB1c2UgZXRoX2lzX2Fj
dGl2ZSgpIHRvIGNoZWNrDQo+IGlmIHRoZSBwb3J0IGlzIG9wZW4uDQo+IEJ1dCBldGhfaXNfYWN0
aXZlKCkgdGVsbHMgd2hldGhlciB0aGUgcG9ydCBpcyBpbiB1c2UsIG5vdCB3aGV0aGVyIGl0DQo+
IGlzIG9wZW4hDQo+IA0KPiBGaXhlczogNDQzNDA0NTY0NzVkICgibmV0OiB0ZnRwOiBkb24ndCBj
YWxsIHN0b3AgY2FsbGJhY2sgZnJvbSBVRFAgaGFuZGxlciIpDQoNCk9uZSBjb3VsZCBhcmd1ZSwg
dGhhdCB0aGUgdW5kZXJseWluZyBidWcgaXMgdGhlIGRyaXZlciB1c2luZyBldGhfaXNfYWN0aXZl
KCkgYXMNCml0cyBzdGFydC9zdG9wIGd1YXJkLiBUaGF0IGNhbWUgaW4gd2l0aCAyNjdjNTE0NmQz
Zg0KKCJkcml2ZXJzOiBuZXQ6IGxkcGFhOiBhZGQgRFRTIGJhc2VkIHByb2Jpbmcgc3VwcG9ydCIs
IHYyMDIwLjA3KSwgYW5kIGl0IGNhbiBiZQ0KdHJpZ2dlcmVkIHdpdGhvdXQgNDQzNDA0NTY0NzVk
Og0KDQpXaXRoIG5ldGNvbnNvbGUgYWN0aXZlOiBuZXRfbG9vcChORVRDT05TKSBzdWNjZWVkcywg
dGhlbiBjYWxscw0KZXRoX2hhbHRfc3RhdGVfb25seSgpLCBsZWF2aW5nIHRoZSBkZXZpY2UgUEFT
U0lWRSBidXQgc3RpbGwgcnVubmluZy4NCg0KYm9vdG0gdGhlbiBjYWxscyBldGhfaGFsdCgpLCB3
aGljaCBleGlzdHMgc3BlY2lmaWNhbGx5IHRvIHN0b3Agd2hhdCBuZXRjb25zb2xlDQpsZWZ0IHVw
IChib290bS5jKS4NCg0KbGRwYWFfZXRoX3N0b3AoKSByZXR1cm5zIGVhcmx5LCBzbyB0aGUgRFBO
SSBhbmQgRFBNQUMgYXJlIHN0aWxsIGVuYWJsZWQgd2hlbg0KTGludXggc3RhcnRzLg0KDQpUaGlz
IGhhcyBiZWVuIHBvc3NpYmxlIHNpbmNlIGZhNzk1ZjQ1MjU0ICh2MjAyMS4wNCkgbWFkZSBldGhf
aGFsdCgpIGNhbGwgLnN0b3ANCmJhc2VkIG9uIHJ1bm5pbmcgaW5zdGVhZCBvZiBzdGF0ZS4NCg0K
SSdkIHNheSwgdGhlIEZpeGVzOiB0YWcgY291bGQgYmUgMjY3YzUxNDZkM2YNCigiZHJpdmVyczog
bmV0OiBsZHBhYTogYWRkIERUUyBiYXNlZCBwcm9iaW5nIHN1cHBvcnQiKSwNCndoaWxlIDQ0MzQw
NDU2NDc1ZCBleHBvc2VkIGFkZGl0aW9uYWwgdG8gbm9uLW5ldGNvbnNvbGUgVEZUUCBlcnJvciBw
YXRoLiANCg0KT3RoZXIgdGhhbiB0aGF0IGFuZCBhIG5pdCBiZWxvdywNClJldmlld2VkLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiBT
aWduZWQtb2ZmLWJ5OiBNYXhpbWUgTGVyb3kgPG1heGltZUBsZXJveXMuZnI+DQo+IFNpZ25lZC1v
ZmYtYnk6IFZpbmNlbnQgSmFyZGluIDx2amFyZGluQGZyZWUuZnI+DQo+IA0KPiAtLS0NCj4gSXQg
aGFzIGJlZW4gdGVzdGVkIG9uIGFuIExYMjE2MEEgYm9hcmQgKE5vZGVib3ggdjMpIG9uIGl0cyBS
R01JSSBwb3J0DQo+IChEUE1BQyAxNyksIGF0IHRoZSBVLUJvb3QgcHJvbXB0OiAzIHJvdW5kcyBv
ZiBhIHRmdHAgb2YgYSBtaXNzaW5nIGZpbGUNCj4gd2l0aCB0aGUgZXJyb3JzOg0KPiDCoCAiVEZU
UCBlcnJvcjogJ0ZpbGUgbm90IGZvdW5kJyAoMSkiDQo+IHRoZW4gYSB0ZnRwIG9mIGFuIGV4aXN0
aW5nIGZpbGUsIGVhY2ggbG9hZCB0cmFuc2ZlcnJpbmcgdGhlIGZpbGUuDQo+IFR3byBsb2FkcyBp
biBhIHJvdyBhbmQgYSBwaW5nLg0KPiANCj4gwqBkcml2ZXJzL25ldC9sZHBhYV9ldGgvbGRwYWFf
ZXRoLmMgfCA3ICsrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2xkcGFhX2V0aC9s
ZHBhYV9ldGguYyBiL2RyaXZlcnMvbmV0L2xkcGFhX2V0aC9sZHBhYV9ldGguYw0KPiBpbmRleCAy
N2FlNjc0NzQ2NC4uMDNkNzA0ZWFiNjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2xkcGFh
X2V0aC9sZHBhYV9ldGguYw0KPiArKysgYi9kcml2ZXJzL25ldC9sZHBhYV9ldGgvbGRwYWFfZXRo
LmMNCj4gQEAgLTM4MCw3ICszODAsNyBAQCBzdGF0aWMgaW50IGxkcGFhX2V0aF9vcGVuKHN0cnVj
dCB1ZGV2aWNlICpkZXYpDQo+IMKgCXN0cnVjdCBkcG5pX3F1ZXVlIGRfcXVldWVfY2ZnID0geyAw
IH07DQo+IMKgCXN0cnVjdCBkcG5pX3F1ZXVlX2lkIGRfcXVldWU7DQo+IMKgDQo+IC0JaWYgKGV0
aF9pc19hY3RpdmUoZGV2KSkNCj4gKwlpZiAocHJpdi0+c3RhcnRlZCkNCj4gwqAJCXJldHVybiAw
Ow0KPiDCoA0KPiDCoAlpZiAoZ2V0X21jX2Jvb3Rfc3RhdHVzKCkgIT0gMCkgew0KPiBAQCAtNDc2
LDYgKzQ3Niw4IEBAIHN0YXRpYyBpbnQgbGRwYWFfZXRoX29wZW4oc3RydWN0IHVkZXZpY2UgKmRl
dikNCj4gwqAJCWdvdG8gZXJyX3FkaWQ7DQo+IMKgCX0NCj4gwqANCj4gKwlwcml2LT5zdGFydGVk
ID0gdHJ1ZTsNCj4gKw0KPiDCoAlyZXR1cm4gZHBtYWNfbGlua19zdGF0ZS51cDsNCj4gwqANCj4g
wqBlcnJfcWRpZDoNCj4gQEAgLTUwMiw4ICs1MDQsOSBAQCBzdGF0aWMgdm9pZCBsZHBhYV9ldGhf
c3RvcChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiDCoAlpbnQgZXJyID0gMDsNCj4gwqAJdTY0ICpk
YXRhOw0KPiDCoA0KPiAtCWlmICghZXRoX2lzX2FjdGl2ZShkZXYpKQ0KPiArCWlmICghcHJpdi0+
c3RhcnRlZCkNCj4gwqAJCXJldHVybjsNCg0KVGhlcmUgY291bGQgYmUgYSBibGFuayBsaW5lIGhl
cmUgaWYgeW91IGV2ZXIgd291bGQgbmVlZCB0byByZS1zcGluLg0KDQo+ICsJcHJpdi0+c3RhcnRl
ZCA9IGZhbHNlOw0KPiDCoA0KPiDCoAlkYXRhID0ga3phbGxvYyhzaXplb2YodTY0KSAqIExEUEFB
X0VUSF9EUE5JX05VTV9TVEFUUywgR0ZQX0tFUk5FTCk7DQo+IMKgCWlmIChkYXRhKSB7DQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
