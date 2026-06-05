Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B73CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2046848BC;
	Fri,  5 Jun 2026 14:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dRLAz85r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0688E848D8; Fri,  5 Jun 2026 10:55:49 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0A38486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKM6gXgzaH43NwMh0s1ixq32sD3NXCM6W6ENLWApHhP2L8dneZOQqpWRFdrmGhDuBE3vjToayhWDlFi04t7HunhTqjLXTl4NBRdEJX5LarYf8n24cAGV0Hp4i1gNgwVNH4DxN5DUa/XMSDHeOMiphcjBX4ZbRWECfV/MXw2u+s9ml2QGq33WWqHjFoPd9lEw21Aj86W6HULTcHoaQ30M8+LT8TH6T9Fb9gAtkiCsh6iPHGnYpnIdVz8iwD2Z+7m3LQ8zSTlLFZQG5/He6SeB0bsB2L5m6ldpKy4kaL0qBZJWi1YqtkIbELgfB07m1ERZ9O/MVaq733+SeqoVFyeYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UAVENr2zkxu9C1kVtJi3xOUPFZ1g4Zv/t3oH99n1ss=;
 b=qDnnirxjuvTp5ay6c1RD2TcW3+RoG3NtsiPyzRHF6eRQtIEeiOq23cxL+eGMwz3uq5U1pRpREQ6tEqqKPIdvjlgttTdqILILkJT25/tsdsEd9fFPB0F+tTgCYtgssyG6eoQYIAJl80bNSspvtfcOwEUUAzNaDLkBKnDScM6VsLDCnyvcXGkBmKt1ssUtrqlSP05J3cxilaA3lHoO52qBkHN/obmsnCZ3Xd+z6NzqrzcvAonuGEnVT88BrOfgjDD3PV+o/T8OoZWKwW4xeZGe3/79q0/RC7iA3OMlhMcd2v1Z/DZrzbsAufICLXQIBFJsyuL/I1CZku7m4MHRsh8OYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UAVENr2zkxu9C1kVtJi3xOUPFZ1g4Zv/t3oH99n1ss=;
 b=dRLAz85r3Gu8mSMFYEdyaQHGai2se/R+Bg8ZK8N4w40K1kK0GFt4iMQPtwcfpxlUC6BMN3ckP8pByXpVocLwwwDKf+4bBobrUleczsj9Ot/ONIgqgIf9HzMFOykGyldPxjKekRgOEIoOGZd+BluwidkWr17EloTOhQGKuuCB/4qbepLEuO47cJO/uq43BvIpVQGpW7GnptTTWAjefXRM/kedasYIBh5dNs5QmkqioJ8qRs3Aap9mxHvvfMLqY3nslZYxg2s8+xK3ySJGOIKdNonfDp9GF8og7jkHX4UQJIPYxICWu4mKCJpqtoaKlyrPkEAIGi78ZG58Qn3vtdMAlQ==
Received: from CH4PR03MB8019.namprd03.prod.outlook.com (2603:10b6:610:242::16)
 by LV3PR03MB7755.namprd03.prod.outlook.com (2603:10b6:408:288::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 08:55:43 +0000
Received: from CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585]) by CH4PR03MB8019.namprd03.prod.outlook.com
 ([fe80::adac:cf9b:26f0:6585%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:55:42 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v2 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL
 SDRAM support
Thread-Topic: [PATCH v2 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL
 SDRAM support
Thread-Index: AQHc1ty6IBzYI9AavUazMdHi3Np2GrYM7esAgCL0cy8=
Date: Fri, 5 Jun 2026 08:55:42 +0000
Message-ID: <CH4PR03MB801994FFCDFA1624D4982AC3C3112@CH4PR03MB8019.namprd03.prod.outlook.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
 <20260428070017.16807-4-chen.huei.lok@altera.com>
 <807f736d-bd47-4c57-84f8-98b509f27a34@altera.com>
In-Reply-To: <807f736d-bd47-4c57-84f8-98b509f27a34@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR03MB8019:EE_|LV3PR03MB7755:EE_
x-ms-office365-filtering-correlation-id: e6c24d65-9102-40f6-a380-08dec2e039a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|31052699007|39142699007|4143699003|56012099006|11063799006|18002099003|22082099003|8096899003|55112099003|38070700021;
x-microsoft-antispam-message-info: pL2TrSP3iUxEn93KSnshl1gFTwXCRy8GLpRiSGOGqe1LFGWmbiIocR0S3GXcTncJPhSQJuzDrpfizpeN7MhsLXoeJktWm8/DjJk3Fll1pcLOaDmfCl8/YJSf8Ttplfcop5MkkjWMccbY4ldETJ440qw+1VR1CawH1ojtBQma61nPTBVkpBZlIEfJW/RPGVWIG7NZI8VYWtbSMSBAwJLnBsnlxFpiOff5N/s5/D466C9N6ZFJTp2neKhPUqZXzCcNNlCzXOF+B3JKjSq7LO4D03RNXq/zUhZMJwIqRKroFWQGjo2bZSEenDl7DHmtyHKgVBXLg24tYpd2U70CSX2L6WWHJb2iEixaSkmGnupk3DJAvPysSbqYV9jG6YnwsI6EaXjZdqYRmtHM0rmnvna8WCMV7ddY5ln1Vna7JveDd0kPtt8wNn3lXXSJh+AObFl95Fr6goojETlnCjUh8fE4edlktiWYd8RL7kHFZCJGLIcAUbt1Kn0cUnURlSfLum9fWAc9UfEGKvSOwTVJNV0Yd+hBSKtpIBCGMDR3S+Z6XxN/cwMQIQEVgWzIw07ODmT0B8heGogh1aNxvuxzXEKAXousw50WFVvBWKSuwuBR8HKUraoLnHScV0ZTBsS+aA+Ku2iPGU6tAaWdi3PZOBFjA74mjzFi5pK5LzbaJSoAa2FWsp7Lmy9T2D9+DXC5fHYCuV8470Zck5w5FcCRdHe2QSjFKiT4pVdV5uqlu3K373UFOdXqcAZQqlQEAw7cr6Yj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH4PR03MB8019.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(31052699007)(39142699007)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(8096899003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?7Sy5v201YtUGisrJacGq0Po7ZxyCf6xsrE1wVbED1QhWotr1fTP9nCOW?=
 =?Windows-1252?Q?DNX/+rlyMZXfKSIbt8iJYYz2X003CeJXry303FXK6cfjLcLoBZFxElQL?=
 =?Windows-1252?Q?6mw7DzgwKuVvY0IjF1zXnbmHt0XHY+aMHOOgXWxL73v1UYKmgHJAG4Uy?=
 =?Windows-1252?Q?UeRUKdxb7VIT/C1JjWdFNwEcn1zV088gaqEfbL8YoI4F60e385EHb8fU?=
 =?Windows-1252?Q?Uil5vdHAATXpIXWa6ogGF0b1qKWMLda0lCM2jQpFG+z5C+qjt7zxLf8c?=
 =?Windows-1252?Q?7eW6ZcYMdM5DRiYlldfhzRu+LFB4Eyd+wz5ebJifzWE2eABp8CpnnymU?=
 =?Windows-1252?Q?hIm1IDVV0VxoUT1KeSW0UtVjyw7VSkCEH/2KrI0avYcDCNTWrKzFPYse?=
 =?Windows-1252?Q?1Fv7ngOb5Vx7rOiwbrAhC577rhlHMMtgSXd2lGC7IjC03mZ2Etzp6R5V?=
 =?Windows-1252?Q?yIjSGKjfSGxA/U7PUQtira5f6bK3N8z0TCujzwpHGpk6/H8tnfoiAmov?=
 =?Windows-1252?Q?1zV2De1VdagHe31h1DvtKtaLs4o8tN/CjLfqwIp3C6GYAZELdpVE9vqu?=
 =?Windows-1252?Q?16NCOmgyBHYJ9PEkd08wcbVjYQuWwa/vU2BRE548T1f9xSo5/GnJHpqh?=
 =?Windows-1252?Q?hIKcMcxDlumH+9MIiqeNd1VwhA6OcwSV/8GLHSeJAy4NBG76dOpsdCWL?=
 =?Windows-1252?Q?XrCP0nMuvNhVT44ETYr9jhxPLs8eGTuEa1+9ZEXncAhLHJjf7NDMNIGU?=
 =?Windows-1252?Q?Ikw18FYC7IE7QWzLJ8FKp9/BTp2SOqMXQyCPNgI+U/3mp5r4QGgemINX?=
 =?Windows-1252?Q?6tD7dDjYQDyuRBmaEp65JMwMkiOUJwth56/oXbndJq0g8ufiz0jq3Ztg?=
 =?Windows-1252?Q?iOPCZ3gVOReIPt5a1FWQq8rSdGaoq0jUEaR0XcfQbdbsi97aWD89yAy8?=
 =?Windows-1252?Q?6quoEp9oWd+ms4lYWsu14/X5RTNSfVmdJRc/0fM9erKQX/UjY4i5D+dN?=
 =?Windows-1252?Q?KgDXNTnLgAeTOcbyLpDguFEtz74/zZmqP97reVWtGdXm27z0VxBEisBH?=
 =?Windows-1252?Q?7C/aaXSW2enbEsTxG2MKwI08mJmASrgT2FZi3Uvxm5ObJQVrHVWzQ8G/?=
 =?Windows-1252?Q?lMHC1/AeOQbYyN7GMREmdtK70y43JWFgdXFRNgr/X/rFsDGBFgk6vE0L?=
 =?Windows-1252?Q?LXgVS8GT9SiuQlzrRDanTuNbCxYJ1obTg7jX1wWDoXU+5QZTTrwoFvhx?=
 =?Windows-1252?Q?+E9f2oioYwYAxUJ01LnqDWK4GC/5JYiLujLuN2iSx2ZyB9p0jimnQ6WT?=
 =?Windows-1252?Q?ZPt9whHLnUkP9QvOEUR3K7m0SLlUAPzvO3kVzGj8OBL2u3kF5IVwRNiT?=
 =?Windows-1252?Q?7B058Pm9JN+xE1o/wXh8SNg2A56YFCi0/fl2Jdv5bkQMPwtrL5OXhF2e?=
 =?Windows-1252?Q?kd8DNeaNzRkDSoQcosudAQF7d7TwwYe05o+fJBudMWSL7akgthfcU6kL?=
 =?Windows-1252?Q?3dcZUrKaUY2qhqiu9bKvtEvqe9CA+zb+JvDV6LcamukJC+Q/TCRHTMQR?=
 =?Windows-1252?Q?lf6v8mpiiSkK9CBcEe17wv+SN1dcJ3O3e/2pLk4+4L+rZy6vjBXq9Wdx?=
 =?Windows-1252?Q?s4QTZmHWMIYnng5JBNVLr6TUkTNxF7LoKcf2SsUmv/Tv8OECaoPvb/ny?=
 =?Windows-1252?Q?rPkF75tUDFesCOb5F98zOI0DZ9c48O3OgJf0Ds3R/DPveQ/13NNyObTr?=
 =?Windows-1252?Q?JZMDa/twlaKwK61kH826pNFNLXq+LDSfWKwES3JjtgDIYHQOhu9SEP4d?=
 =?Windows-1252?Q?nimzWBIyOa0JhzWcM80JVlTCnOmOgym+NXFaKGGR/lASZtjp9JZCLf4F?=
 =?Windows-1252?Q?wCD7+dH8hmfO6w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR03MB8019.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c24d65-9102-40f6-a380-08dec2e039a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 08:55:42.8202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGRp4nISFJODjssmkmDxtDS62U6SuHqiB10BkHOPSuTl17RRgy33/luyN0NJcpgCteVrI5SM/JD5dTSntuHSfDDRBj6iXnpBrxcv9THy8to=
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
> I suspect the sequence may not correct.
>
> Did you run `make socfpga_n5x_vab_defconfig && make savedefconfig && cp
> defconfig configs/socfpga_n5x_vab_defconfig ?

Good catch. Addressed in v3 =97 regenerated via savedefconfig so
CONFIG_CMD_MTD now follows the canonical Kconfig ordering (between
CONFIG_CMD_MMC and CONFIG_CMD_SPI).

Also dropped CONFIG_SPL_ALTERA_SDRAM from this patch as Kconfig
auto-selects it for N5X.

Best regards,
Lok

