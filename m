Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FD2CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29DF484911;
	Fri,  5 Jun 2026 14:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="G/2agO3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB247848D8; Fri,  5 Jun 2026 10:56:31 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CE98486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vruh87vPd6W1ftZ2o/1KpCyA9H/EwWfP3gr/6KvmMvlO3FMO5JELw5lKjBBQhUheZ0jRsRfLkAHVppSNJxanFCV4BuBZy0IzJYK1SDO3tzMUSfLb47BEMas6LFenHbMyRR7YoMx1vzYXG5ZvxYvmhR16jBYFJ66YLhXnGXUpRnRCVZq2o3sEbwmR6AHeg77pC7HJOSNuqCM2jHjTSeYdZW0+5YksPBNJqCdH/4WUVudB/J1Lk+AUv4tIKu0DoUUjvv2uphzXrfUeV2flKH0Nkv0ZH3zMh5hch/mbEnbkVVRfl5ftKmKsvyh2SL+d56HACnbgwZ/f1Dj6oJN1p/UbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGVE5jNABRgDuyCC2uDCjBwWR0nfZrcwhO40G65XEdI=;
 b=bzz60I4juST7AWPpN6z2Y71QFkw56p86XGqIlwlPKZFi9SYSM79O3sDbketVoSLUCsang5sOpItbICWTIutza6l5DyM0CSQ3yvvJFAlUzBRqcomdv65S9CnLaNvENCigqNq51+81YbCM2P0AVoR4QdkXf8Hmye93DdB1XSzO9VePKkvjgjZEKvmHg0I2xFEUiVJ84FE3VYQqToWwB+qg8cOWNNMsckM8kWMbqahVYdeRqCfgJ/OUCWDvfpKBf5u6AxWSuHLaRMCIsrtxHNXV67QjPctIJrDA17OZEDxdz7yn9vM8bmrrR+eTOS8Lfvtjlbfer/jEgrDsdQbS6otv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGVE5jNABRgDuyCC2uDCjBwWR0nfZrcwhO40G65XEdI=;
 b=G/2agO3Mc9cIk0To/l3plEDuIP0Kg8sy544D2K2EkITZ0alKXF1w8lKPno5qorSGdVejitbvY3HUxqr9J4QDxlNT20faVk3+IqvwHh0J7cPwivAPe2YP4IFf3/CRq6IyHOs/k9CHI9AnRWY38sr2qbCmlExe6vO9qefNuzGLSi9fGw3mfQ/e9qZZLbFq8pG6eurO5/b9CEEOoOYoCsJITZ7a2tKcXycEHsDyCnmkR5S6RKc4MK2oPM9Xoypqd1cEBGXldB398c+B4ZipsQfqX0iG9wJK79GOk4q3UxlU9Y0tzmxl3ORol2ctnqobBvlusm//PMWN2GOmjC9fhZoTMA==
Received: from CH4PR03MB8019.namprd03.prod.outlook.com (2603:10b6:610:242::16)
 by LV3PR03MB7755.namprd03.prod.outlook.com (2603:10b6:408:288::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 08:56:27 +0000
Received: from CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585]) by CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:56:27 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v2 4/8] configs: socfpga: n5x: enable required configs for
 DDR retention
Thread-Topic: [PATCH v2 4/8] configs: socfpga: n5x: enable required configs
 for DDR retention
Thread-Index: AQHc1ty8hMF18yNHA0yNs6CoOS3RGLYM8/OAgCLuw+4=
Date: Fri, 5 Jun 2026 08:56:27 +0000
Message-ID: <CH4PR03MB80197A29DF609F16D56F8EB0C3112@CH4PR03MB8019.namprd03.prod.outlook.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-5-chen.huei.lok@altera.com>
 <310fffa8-8196-497f-a292-96c9a70dd672@altera.com>
In-Reply-To: <310fffa8-8196-497f-a292-96c9a70dd672@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR03MB8019:EE_|LV3PR03MB7755:EE_
x-ms-office365-filtering-correlation-id: 2d7b40e6-61dd-4d05-7a9a-08dec2e0542f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|31052699007|39142699007|4143699003|56012099006|11063799006|18002099003|22082099003|8096899003|55112099003|38070700021;
x-microsoft-antispam-message-info: octcv0/9P7nED/hrtdF+I6IAg5PSWCIS5Z9EN4IH4QsR52xqY6Nz6KNjumxTIDkqxiu4D2hPdkjLmCIC/gmm6DAVTGA1v2NvaQWLFC4uMudjsaInOxLzcUZ3G0jjowTfEE6oThs9aWQgvHibpVlCUzfwPC9g0fvyeNhif/vl60IFReDEEmLJyKefxeK1zOl4yxlZAEAQBaap4PwYDLfUxAhHDsA3xY43qZMr3VXBT7u34dXBCQHZDLV+eBdWKYa6MvVZlXmxZFos+oDT94m+ntV2fCOAVEMQqatF10lskt9K1FTTgMYwa2Nc5ZhW/Rc3Bxv1acq94UjEzmMmJGHBxAzgBYxmTGAg4D3NdO/7pGYdgvW2+v+e9hNu36P5teENCmDZ0dFLz6Kv/2xb5Fb5hGveeY75+UDuhiJyirdGb0F2DdwYYziaBjIJiDLwmo/gg29lPQ1MMllMak7XDH1idv3ccR6oXiWREQo9IyswEjBuuIE+TKFTflP6Wi41a2Wkf7Fs1RWA5wya1FnwP6h042NXVsm0eA5VjVK3gjZFfPEWQiSjYhdKaSA4njwaXiZGsbfqYoDGRIdctueTkPhK3Kprb/Be0IZKYEPEdqSnBGSremgmG0ZrFWhtlRFGZYhAoV0T4JdHEkd4jjpDEJAmS1cbkkKm2AQ6Agy+zT6oVGSmCz8GTCTkM3pR4m8JLsX4a+kmJ6+0faA/4BE3SsBWiH4wgnMVXWZbkf2bqLVG4mlm6cmxmJYSaHTLTHgu6mLP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH4PR03MB8019.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(31052699007)(39142699007)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(8096899003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?43MkjUj2oGn4MunctkqIcm3upS4w3G2cAOA7p2swPntY8I1EiCjHo3B1?=
 =?Windows-1252?Q?LFk5oCqyfAGN6TQYVgeG4IPqlGH76ZX5R9hsE3bO59fFODvhItwcTC4z?=
 =?Windows-1252?Q?CJKiBG7lCTzrG13jF7b2nygv7zd+593ovXA4rWItoT8i149euL4q1pDQ?=
 =?Windows-1252?Q?i6QQoM/Wh/iPZTH0foXOVK2p8OiGRIdzqNRIOQp3pH37T21RmUO8Fj8J?=
 =?Windows-1252?Q?P1nTfQRXULPwQx3S9ChHY1fSFRBWTBdLC9vECRaULlA6ISaBrLtfz8eA?=
 =?Windows-1252?Q?0ECHLRYV8VUN1R9uhi6d3y9PeD4mUgLF/sHCtsAXQeyomTBcVRe8QbEM?=
 =?Windows-1252?Q?P4notlzjY2DDF477yFGgaIdcbvEemcuAp5WpT4jQvfg7eBldUW2Oupt6?=
 =?Windows-1252?Q?MXnlb0r9qJaqQ3qPrWOUwSLuSmGG1pmlnKLKjxkze4I2irO4+2VmuTN5?=
 =?Windows-1252?Q?yB2POoql/+xwMboEQr8cI+/+kJmxkSO9LH8yaY5zeCfvCszK2Ex1Zbus?=
 =?Windows-1252?Q?S7YHhDuDWUDaIAiNujgoAZJJk+nkr9HxEs/kTmi1NWsJw/zEBW+TpSfl?=
 =?Windows-1252?Q?bobieR6tayN6J+6kduTTDE8UDUSH3aNI3PDE0Es12Q7GZWD29PxiGApH?=
 =?Windows-1252?Q?lEjqzhmt0uYe2i3axWO7+0E7HtzEywP4liPKKZsGCUSK49Vne7DkpdQm?=
 =?Windows-1252?Q?tbxR/DGvFKKG+kV5AGeXE1/Ya2HY8CpigP9iik79uguy7P/SPwO5IJ0c?=
 =?Windows-1252?Q?5AWHJjkboa7hzdnmCItEeEk3kcMLLDP1W/JmwYa9bVoAHH6fHP5fyh8J?=
 =?Windows-1252?Q?7UAaotiDdNpJGtdPOusDLr/WSznshBpmu05XSIAZ7CFcTNJW8gOKo3EP?=
 =?Windows-1252?Q?+vGSKiKyScytbK+aEUOKyUZuoBp1PF4tEnXf2tf+hidRj81Mjqytfv1u?=
 =?Windows-1252?Q?xaAlaB974SxaAGV9nKOIyizBzx4SrFtRpgveZKrGy7aS7BMFruRROJMr?=
 =?Windows-1252?Q?DSUV4+QsM1pNRS03m4kOUgmnfTl3YUv7s2we5KJQ0emOapCmujETg2Uq?=
 =?Windows-1252?Q?kUmE82FsK+gagHm1z4vr/tLG53FtqqRRDfH09hhAQLlINH+y7ChkI+sf?=
 =?Windows-1252?Q?P3T+IwUXM+4J1BIGEH3ViNZwiiWseC83Ie1OHVKBSQ2atypYzbuQwQis?=
 =?Windows-1252?Q?Q2KwooO2hxpDNrn8gVnHC0bPyWi4JyRkmSOIF0fgv7Xt8u0d5+EatGZ5?=
 =?Windows-1252?Q?GOViVQzmQOiVfsjJDyIpI6hPIg3w3+BrhKfIYqScNGEFTYk3jHsjpXK4?=
 =?Windows-1252?Q?e9t3GGYPpFbjmGOqSKoAwURMwjGdzw4ByGY6AikkmObNCFYvJX2Fbqno?=
 =?Windows-1252?Q?dgWvuceAQtx1TDrRvRnc6riq/kWaPVWNjIr7wNd1qc9tuZ/lLhtfgiub?=
 =?Windows-1252?Q?5n14WVtD67PGmNA61FUx1tGmaAgK2VIHtVvZq13H8vWo9jzwAHBUm2nC?=
 =?Windows-1252?Q?3kUzWQoE+tX3CfjHm6loJ/JiUjkaItabgpLkyOVf/jS+s8JVYFsk6uST?=
 =?Windows-1252?Q?c5VSuwEvukOvvNiNbtEhHbaNfjYFrwwuNzgsbXze7Ub56Cx59pAzXEXf?=
 =?Windows-1252?Q?zeT9TdxvbNXUad1oC7Cl3CIfF2kqEAhTWGAbp10YoGyhZau8eB84TLBC?=
 =?Windows-1252?Q?h8qmKHB31BI4SAP4NN9b3rldlDQNFi6ruS9sOi3upCd6WnxWH89vfrBj?=
 =?Windows-1252?Q?vMkBI4e+YZCMKeKUxxbVqvIB1PWz/8GzuJea0TxZjPEvW6DqmpAqDdaZ?=
 =?Windows-1252?Q?9aS/wpXMZ0Lw9EEJQyLQgT4tH6Kc7a5sN4ieH94hrw8utfQuIyOqwvHj?=
 =?Windows-1252?Q?czHEhTjsrAvwig=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR03MB8019.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7b40e6-61dd-4d05-7a9a-08dec2e0542f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 08:56:27.3672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DU1RxnyFjnzo1Cvuhk8EYh2DFQeKTezbPkIHP/leh4dN68c8OJz2p0DrmyZWswK9tVcy9YsPGC2mgZRGRvNIHOoHjxV6laDxjUeESRAV4iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7755
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tien Fong,

On 28/4/2026 3:00 pm, Tien Fong Chee wrote:
> Consider restructuring this as a series that first enables DDR retention
> for N5X, then adds the required support in FS_LOADER and SPL env
> handling in follow-up patches.

Agree. Dropped this patch from v3 =97 will submit DDR retention
enablement as a separate patch series.

Best regards,
Lok
