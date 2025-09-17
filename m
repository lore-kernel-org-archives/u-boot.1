Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCB2CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 20:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E21B6800C1;
	Wed, 17 Sep 2025 22:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="SccsTxMs";
	dkim=pass (1024-bit key; unprotected) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="iDZvtd8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC610832AD; Wed, 17 Sep 2025 19:18:11 +0200 (CEST)
Received: from mail-edgeBI204.fraunhofer.de (mail-edgebi204.fraunhofer.de
 [192.102.163.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8268309A
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 19:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aisec.fraunhofer.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.auer@aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
 q=dns/txt; s=emailbd1; t=1758129489; x=1789665489;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kzN1j2L1Tb/AjpPFhOJGlcT+le9zEn9J66oVT5ugozo=;
 b=SccsTxMsn+YxC6AkpkPbWaKrvgJXB0K6HdHz12L5DPySeIZjS3xSVe+y
 X+poq2CCWpb34zp1akGvFY968a/vwme3YacqbOeiCeSDNAnSZ3jjeENEx
 sPh+TFCyBOkgOPGiyVQWLZZM7ZAp9cXb4CmazNmPhsQfWFrQK/6dO3uHS
 jZU4C/IShZIycH7HOa4wZK+HRdxdztMkrAk9/7Y11Hp2EHVTUsXZOWZhy
 Xem5iKxuIGilm75mj49vxw0CxevK50AktAUqhJxQbwz5o8xjGNWCgzE3g
 B03weiGRrwAYx8lusgoaB+djKGrHBF3IxAiEHbNqKBiPczTtYSLLKcSbt g==;
X-CSE-ConnectionGUID: tvP5pSS6Sd24HCsqNUsf9w==
X-CSE-MsgGUID: dWYpRxRKQcu22CEcDegliQ==
Authentication-Results: mail-edgeBI204.fraunhofer.de;
 dkim=pass (signature verified)
 header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2E2BABc7Mpo/26aZsBaDg8BAQEBCQESAQUFAUCBU4JAQ?=
 =?us-ascii?q?AFBgWWEVZFxA5xvglADVw8BAQEBAQEBAQEIAUQNBAEBAwSFAAIWjCEnOBMBA?=
 =?us-ascii?q?QEBAwEBAQEBAgUBAQEBAQEBAQEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CW4Esg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg0oVgEFIxEMAQE3AQ8CAQgYAgImAgICLxUQAgQBD?=
 =?us-ascii?q?QWDA4IkBBIDNRQGv0mBMoEBggwBAQbbKhiCRwMGCQGBES6DEGyBBoNOAYFui?=
 =?us-ascii?q?HWCDEOBFAE1gnU+hApOg0aCaYImgRaQMYwjCUl4HANZLAFVExcLBwVeQhAzA?=
 =?us-ascii?q?yAKNBUcAhQNEBIPBBYFLR1zDCgSZYQUhB4rT4IccoEADwFkPhlBAoNRHgZrD?=
 =?us-ascii?q?waBFRlJAgICBQIsFz6BawUBHAYfEgIDAQICOlcQgXwCAgSCFkADC209NwYOG?=
 =?us-ascii?q?0OWWYI/coEEChwQgX0Xl0SaP5UXAwQDgjWBZ4welVMzg3GTb5MLLphYIotsg?=
 =?us-ascii?q?XqbDgIEAgQFAhAIgX+Bf3GDNlIZD44hhACFE4ohsnx4AjoCBwsBAQMJkWo0g?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 8A=
X-Talos-CUID: =?us-ascii?q?9a23=3AUhwI12lpz1UKV8qsg7W4qc5fRJrXOWHD9CrIGHT?=
 =?us-ascii?q?mMmozFJ2+Uka2xbhqwtU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A37NZ+A/5Q9PmKZJPNxR8JkOQf8tX0ryUGHouqJ4?=
 =?us-ascii?q?b4ZOvGCdcNjiZjQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; d="scan'208";a="12803200"
Received: from mail-mtamuc110.fraunhofer.de ([192.102.154.110])
 by mail-edgeBI204.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Sep 2025 19:18:08 +0200
X-CSE-ConnectionGUID: GP3/KDipSySYKrdJmLSL4w==
X-CSE-MsgGUID: OXeRbT2FT0SMbk4j9xz0Xg==
IronPort-SDR: 68caed4f_L6gSwU8VheFDLpusop1ZH2oDCRlgWp6I1Q2IHbNoA1YgwAb
 KUeoSl1GsSKRt/yUBE/NT2zr+FkJQ67epCoMbxQ==
X-IPAS-Result: =?us-ascii?q?A0BkAABT7aZo/3+zYZlaDg4BAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?CWBHAUBAQsBgW1SQAFAXIEJhFSDTAOFLIh2A5xvgSuBJQNXDwEDAQEBAQEIA?=
 =?us-ascii?q?UQNBAEBhQcCFowPJzYHDgECAQECAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBAQYFgQ4Thk8NhlsBAQEDEhERDAEBNwEPAgEIGAICJgICAi8VEAIEAQ0FI?=
 =?us-ascii?q?oJhgiQEEgM1AgICDganFAGBQAKLJYEygQGCDAEBBgQE2yEYgkcDBgkBgREuA?=
 =?us-ascii?q?YMPbIEGg04BgW6IdYIMQ4EUATWCdT6ECoQUgmmCJoEWkF6JcglJeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFXkIQMwMgCjQVHAIUDRASDwQWBS0dcwwoEmuEGYQmK0+CInWBAQ8BZ?=
 =?us-ascii?q?kEZPwKDUR4Gaw8GgRUZHS4CAgIFAiwXPoFcFwUBHgYfEgIDAQICgRwaQAMLb?=
 =?us-ascii?q?T03Bg4bQ5RLgjlygQQKHBCBfReXRJo/lRcDBAOCNYFnjB6VUzODcZNvkwsum?=
 =?us-ascii?q?FgijWabDgIEAgQFAhABAQaBbwQxgVlxgzZPAxkPjiGEAIUTiiGoBkUzAjoCB?=
 =?us-ascii?q?wsBAQMJkWqBfQEB?=
IronPort-PHdr: A9a23:7fcA+RMDLDfiUYzk9rAl6nZUDBdPi9zP1nM99M9+2PpHJ7649tH5P
 EWFuKs+xFScR4jf4uJJh63MvqTpSWEMsvPj+HxXfoZFShkFjssbhUonBsuEAlf8N/nkc2oxG
 8ERHEQw5Hy/PENJH9ykIlPIq2C07TkcFw+6MgxwJ+/vHZXVgdjy3Oe3qPixKwUdqiC6ZOFeJ
 Qm7/z7MvMsbipcwD6sq0RLGrz5pV7Z9wmV0KFSP2irt/sri2b9G3mFutug69slGA5W/Wp99Y
 KxTDD0gPG1w38DtuRTZZCek5nYXUTZz8FJCA13G/jejXM3V6xfw8cN/wBG0PerUYrQ/ZXem4
 vZ5ZRm5qnlZMAAFrXzYjd532fE+wlqr8h1T8ZDIbNGfc9ZkZ5r5IdIaf3Reft0BCy5eQYXja
 tQSMfczD7thrM7j+nQMvxqFJACpWcb1+B1BjWOtgLQQgssAPhvIjBMJBvYCvS7eo9//bplPY
 O+Q3pfr1jzpU/VwxhPCspnRahUc+raVVuNdcuqP50UvGD/F11S6qK2+DRiYz/o1tze45etgd
 uD1mnI/uQYogDOA4vUS0a6Rho8IjU/u1mZD8JwKLIejQxsoKc7hEYFXsTmdLZczWM45XmV07
 T4z0aZV0XbaVC0DyZBiwgLWTsGsKtHQpBz5XfuXITB2iWgjdL/szxqx8E310uTnTYH0y1dFq
 CNZj8PB/m4AzR3d68WLC7N9806t1CzJ1lX75PtNPEY0kqTWMdgmxLsxnYAUqkPNAmn9n0Ces
 Q==
IronPort-Data: A9a23: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
 UXhjp5CPDyDQFhkX3fo381bPqI=
IronPort-HdrOrdr: A9a23:MSPbda19EIejF9OEtcodGQqjBMIkLtp133Aq2lEZdPU7SKClfq
 yV9sjzvCWc4F0ssRob9uxoVpPsfU/h
X-Talos-CUID: 9a23:G4ROmW8TvjBzp6hfPw2Vv2EsQYcGXnzF92brEmyiBURsbIaxFUDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AyYK81Q08F+G1+4G0H9v+j9Jr6TUjxJSjMkoxy7s?=
 =?us-ascii?q?64/KhPy8sOWaNnmyHTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,306,1747692000"; d="scan'208";a="31238423"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de)
 ([153.97.179.127])
 by mail-mtaMUC110.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 19:18:07 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Wed, 17 Sep 2025 19:18:07 +0200
Received: from BEUP281CU002.outbound.protection.outlook.com (40.93.77.4) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33 via Frontend Transport; Wed, 17 Sep 2025 19:18:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrcRJngE2TeLAnJ7hRfc1CCrMDMb342tfZeDtYXeh4ei39YwqB6RSzY48FkObDj+OP/l93/zi8ttei2YPnXTLCdbevyg+/MkZ44JeFA+CxEsnef/2K6gnwlY2SoE/a1/KqLKA1F/G6EuDMUo6l/GLB1VlLOexP9O8nvdPaxQZN/AkoousivfglnfRjCPKuFnnLu4eTJS+52pSe/Vc6Wd6bDyKbADZAaxMUVOc3WpG6GrH/njY7vkM4PikMlwTHW+ucSllgmROVUazSe9OkiCDpGVX7dcWs7PZkDCUnq1Xdqs10y8PpbFhXUlcz0wJ0dIvlNAdr5CeltIEgkTEgTNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzN1j2L1Tb/AjpPFhOJGlcT+le9zEn9J66oVT5ugozo=;
 b=hR5zu+/GGWLI7cpQEgBK0PrC/Gqu8+seLtE63MheJYzNvwzdTqmF5rCOrXwL5PCIvCDYRvodey092zxak3CpZTxrtBQVBDtSuhw2kWy+E96ztoA2R7l5qeTPSBFFqieQKaizXZ0aRBzy5woSJJixhcCr1BnZG1B/cU29kHqF3jmdpVpvpI4AibaISPD+9k3mCFNs4Fnlsw4y24RHmyHzWXoIlhnTLNvWWHVr0tISBUmh/KnexGkSaa8Z+D/a0u/bB6XWevBvL4R6hucyq7588pWnL/FDy+FbyKTYu3Z40wzJZlcifGLNQ13EMVHKH5yz/nF4A7aJS1cWGjpGDt6Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzN1j2L1Tb/AjpPFhOJGlcT+le9zEn9J66oVT5ugozo=;
 b=iDZvtd8b/DrqQL4ihRvwHs84jw+n7m7uVuZZ5Qk/v5GjziSIam5MrZJact35qB9GIGrf8wAqLde2bgbb2V5YgMzVKsaBTnNwLW2yqpmU3/qc9EkH6FdhgTh1iBiI3ZCeqvPl7KbihKj2ytpzo1JcGLZV3O0heu/wBK+RXrWa2sc=
Received: from BEZP281MB2759.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5e::11)
 by BEXP281MB0117.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.14; Wed, 17 Sep 2025 17:18:05 +0000
Received: from BEZP281MB2759.DEUP281.PROD.OUTLOOK.COM
 ([fe80::41b1:1bb8:2dc0:666e]) by BEZP281MB2759.DEUP281.PROD.OUTLOOK.COM
 ([fe80::41b1:1bb8:2dc0:666e%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 17:18:05 +0000
From: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
To: "wangruikang@iscas.ac.cn" <wangruikang@iscas.ac.cn>, "trini@konsulko.com"
 <trini@konsulko.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>
Subject: Re: [PATCH] riscv: qemu: Remove fdt_high default
Thread-Topic: [PATCH] riscv: qemu: Remove fdt_high default
Thread-Index: AQHcJdG+IIj4ZoWnnEqSrPlmc1fxprSXomoA
Date: Wed, 17 Sep 2025 17:18:04 +0000
Message-ID: <d04356b6476b1030aa1a059d33fe4dbbd41de435.camel@aisec.fraunhofer.de>
References: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
In-Reply-To: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2 (3.56.2-1.fc42) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2759:EE_|BEXP281MB0117:EE_
x-ms-office365-filtering-correlation-id: ab4da769-57cb-4027-55cc-08ddf60e2a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WlBMeXEzbGVNekdPYlQyMkdFRjBLREw4WWw5N3MyRmFTa2Z1S0QvS003WFdu?=
 =?utf-8?B?ekdmQ3ZXRU4rKzRRQ2l2QlB2NS9RQVFVSi95Q1pTVjBqV0kzYUZyYjZtZWRy?=
 =?utf-8?B?UXVocDE2RlBtYjBiYnRBTnRRNkVueFk4MWFucUkxdVhMcmp6KzlKbUhYR3oy?=
 =?utf-8?B?RE01bjV6U3pJZGRaNW9IcDcrQTlkdmdNSlFmMHJpRXVna3h0Z3hBVDNiWUtn?=
 =?utf-8?B?SUlpTDFtQWs4ajU4a251T05zYmZ4UmFxV1FrcVhOL0tYYnU0Vnhxb2laTGUy?=
 =?utf-8?B?NEJxVnMvbUo1Y0NmVlVDMVFNbVFKUGJGVzJtWEIwTUZ3aWlEaUN5L2xEcDFD?=
 =?utf-8?B?OGhOcEpaSjJmVnVwSmd2V2I0Z1V4S3ZhaHRWdzJrSjlvdjVDckYvSjFKY2ZC?=
 =?utf-8?B?OWlIaVUxU0xxNUlGN0FVaDJGQzRUK3B6VTh0aktiWkY3Z3dtMTN1MHlieXV1?=
 =?utf-8?B?UTBiTnBUUUExRE4zVEJoalZjRWdXRGMrd0Ryb3FVRGg2ekp5UmI2ajNFQkIx?=
 =?utf-8?B?bmdTaDZ3RmlRUDJPZ0NLdmV1UU1jRE5DTFZ0MXh2cFlqMGhKR0hCcERFdngv?=
 =?utf-8?B?V2dwS3M1cW9US1h0OUhuU2YxVi9ESEEwNmV2ekVwVEJhZC9HL21GQkx5eHo3?=
 =?utf-8?B?VURwQWxHa0UvRHRoc3JWWnV2Y2J5ZVAxWlZkM1V4RHlwS1pJTzNoYW5BY2dx?=
 =?utf-8?B?emh5TWg2QUxpVnl6MmhoeXhqYlBCUURseHNYMnhDc3hnQ1Z6WmI1YUxQSkVl?=
 =?utf-8?B?dXBPWC9nUUdOdHJ6TnBEajdHYWUyN2JGRzRqQ3FkTW1WZll1elJBaWdibjdP?=
 =?utf-8?B?MnloU1JVSnZ3UzBYc1pKUE5uMUU3Vm9FZllUbXd3UzZjYVN3VmphdlJJTDFt?=
 =?utf-8?B?MWw1UmtGTXlOQzEzN21uSUVWNU0vb1JwY1Y3M1J4Nk93NnRpSVptamxUNGRp?=
 =?utf-8?B?aXRxZDNMR0E3Slp1bFA4cDFNckpoWmRFNzlXZDdjYTc4TUFXallxTDBuMjVC?=
 =?utf-8?B?WmpqWVVIRUV3Rlk2c0ZWc2hvSCtZeDVFaFI3NVZsUFNZVmJuUVZNUzg4bUxs?=
 =?utf-8?B?NGc0aXBwYUJ3SjlRUmpUN09kclJVYjJQMjYvc2NTU0tURVBHYXowNnhIWENx?=
 =?utf-8?B?OUZMOUcwQlVvbVlNYkRpYlFhdnVxYm1odmc5K1N1cEFxUFB5eEFkWk5wV2Zs?=
 =?utf-8?B?aHFKSDhvVXRPMkkxN2h3S0dtalhGWVBNcSs2U2w0NU1sem91cENUVWdXd1Bh?=
 =?utf-8?B?aVh2R0JvTW9sSDNDdkJYaE43cXg0WWcweTY0Z3MvR1oyYU9wSHRFc1pHa0Yv?=
 =?utf-8?B?MTdVUE8vcktobGx2UENIK044VGl0anFHeEk2dUJNdXp1RGl6bXhtRUpjQzhY?=
 =?utf-8?B?ek9aejBab210ekVydnB3NmhHMjVHck9RaHlRc0xoWE1RbnhsSlJsT21oc2VP?=
 =?utf-8?B?cTNuUXduNWdGQVZ5TGY3VTlmZHZsSTl3WEZNbkI3QStucGgreWZibjg4Vkd6?=
 =?utf-8?B?aHJuZEtMdmg1THhGYWRPekFFMFkxbm12d0pGM1F1cndBcUtaa2ZtSGw4T1pH?=
 =?utf-8?B?MGhtRS96K1NMaGlnNTBvbVp5VGZLMmd0YXJQNk5SempDL3I5NjRIa3F0LzJh?=
 =?utf-8?B?NlZZYlkzczlCakxjQ1ZFU0F5Q3RyUXlzL1JVdHlSeU9PRENiK0tFZU1BYTFr?=
 =?utf-8?B?bnRPVmoyOHFqNml3UUQrbTZER1pEa0hXcGNMQ0R4a0lSWFE0eW5IZlZMT2hC?=
 =?utf-8?B?KzdEakNlam1xK2trVXE4dHpBWEgwZEk2VzRNN0I5YUVRTkJnODQ3K1RrK2Zs?=
 =?utf-8?B?ZXJnN2IxcGMvL2RxSTA4TDcrUkFXOTZ4dWxrRzFQTk1wTlFEOEd6UnpiUEs4?=
 =?utf-8?B?dUdiZU15YjljdGxBSG5VSkpKZnhhZ2JSMTFyY0luNWh5YllwNkUvWGR2TFMx?=
 =?utf-8?B?ejV6Ull6VmFjdTgyYU1xU0Y5WXlNc1BvZDZxUklFb29FNUQvZC94RGRrUlB6?=
 =?utf-8?Q?QpTeyZt/xx68zrrY+ZfOfCiyfJg4Fw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BEZP281MB2759.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cktZcWJrY1hpdmQzcUdkRjBDcWlMbDVXUmtLV0dGR243N2dNcGJjZlEwU2M1?=
 =?utf-8?B?SVNIWG13U3J5eUYwd1R0cHNzSjRtTDFTOGk5M2hPcXpZMHhubU9ZeUg2L1dS?=
 =?utf-8?B?UGN3NFFnM1dJSnI5eWl5dGlrUDMzZHNhOTVvNlBXb2xycVgzSk9OTkVQdzFH?=
 =?utf-8?B?bE03aEFHbkloZmFYdlErckl0UC80amo2YTg4YnJEWlpsMVFCRXNyOXppanlD?=
 =?utf-8?B?MEdSUVhaeU1zaDA5TkxJNXlUNkJqSW1pRlg4YWdpVkJzUGxnZ0ZXWXpKV3Vx?=
 =?utf-8?B?Z2dDenhVWlA0Qk85NUZFQXVNR3hzbVVheGkxY0p5S0dBNktWdkFBUTdERnVv?=
 =?utf-8?B?SjRwZHZmUkdzMFRQR0NtbVJsOU9hRVRYSzNoVTZpd3lHcUhyYkhUTkdYWnZy?=
 =?utf-8?B?RDRiaEQxay9UV0xuZXhTeFlScEI0S1ZhWnBXRm9xTUlXM3lDZys4dHpCY2ph?=
 =?utf-8?B?dHFsT2N2QlEzZHkwamloQXlhaWVlY0MxYS9zVmw0Z3p1OGVwLytEWmdNRlpY?=
 =?utf-8?B?QzFCSUh2dmRjbUMyV1BVYVA1YkRRdEhMRjQyb0pYL2VUM0NiRjdGQVdvNkl5?=
 =?utf-8?B?eUlLOGg0b0hhcmFSSVE1a0lYOW5WQkswZ0cxSlNpM0dJUEVRMi8vMlNsNjI1?=
 =?utf-8?B?QU0wNE1mYUF0cm0ranNpQW9HdnhndGRiOFM0SzZXazg5N1k2eHJyQ0pUTUZu?=
 =?utf-8?B?QVFDQWlDM3FPZUMwQXJ2VnJTenNTQjdwbk16MFVqKzcrZE9XUEQxTnlnS3Uz?=
 =?utf-8?B?ZjJZYVpxUzh5VWo0QVRIdm10di90ZGZRaDAzRU5nUUp2MDNlK1YxSitWQnlk?=
 =?utf-8?B?ZGM4dDN5UlN4cWxWM0NhM3puMGVXNlhjaS9jeUE4M091RDdkVm1udnRoS2ZI?=
 =?utf-8?B?TDQrc2tSN0xLQ0w1NjFMd1dSN2I3SDhxQmhmN0pSbGxMalVuc2hndDhNY2Nm?=
 =?utf-8?B?eHpqRG05d2grdExybWFsdXpwQUhBRUovNlNTYkdmSXpIYXlIc1JDOEdSWG9O?=
 =?utf-8?B?ZXhxQ0ZzZ0k4bE9EV3RoQThCNStvcGxDaHVOTE5UeFAwdWlVWDFmMC9DdGpj?=
 =?utf-8?B?WmFOcW9wSWlXU2FnSjg1OHBxcVQxUThNWVhVc1pVNGNUeGRjOXR1OUo2SWZE?=
 =?utf-8?B?bVNVRURmSjJDOWRHWkJKK2x5Q3JyTXlPWmd6YjdSS05NRkQ1SnJGWWsyNGhr?=
 =?utf-8?B?cExXSEVya3NIdHE1Zk5rQi9Od3ZiVmd6NklTWGhJZUZudmp1Sy9VZ2VWa3dZ?=
 =?utf-8?B?NGtRZWVCUTNKcFJkM2hzMmRqd2VFeWE4RGhaUTBLOEM0MHEybmwzUzJpNU8y?=
 =?utf-8?B?OFRFa1YwRjhMVTN0b2NzVGFjMHBWUmtSL1J4RHkzRWtFdlNVdG4wV1NZanRl?=
 =?utf-8?B?Ym5IOURIaDl0dG0xMU1tZkJJMWV0bndJYTJ6NW11VHdtaWlSTVRSRXJqSEoz?=
 =?utf-8?B?WWhmcXZmajZFMUx0allHd3BXME8yK0poN2RLeUdFNXRveTFPbjhiNVFoblYy?=
 =?utf-8?B?Z0tyUmpWS2UwODBEUzQweWNQdWVOY04rTVBSQWxhU3pNMXZ4L2J0L2FucVRM?=
 =?utf-8?B?WndFazBld2N1SEtBcG5kUEhjOVhGRHdRbHllcGFiU3RpckZtUXFnYVB5OURG?=
 =?utf-8?B?RzI5V24yVmRFVkQ0WHVBOUs2dnFiRjFlZDRJZ1BMNWdkTFk2ekdJWTFac3Ft?=
 =?utf-8?B?YjllZmF3YllJQ3pIeVROelQ1K1lsYXhOZW83c0JIMWR5c3F2M3VERHZWOEVU?=
 =?utf-8?B?eEUxK2UwVTRxRWVZMUdqTG5PcW16QVRrZThtSlhKbnlOL3hoUVlicHo0SXZo?=
 =?utf-8?B?RE1KaU9DdGpzejZ2dkJXWTh4ay9VRTdZMlE2ZDJmQStyNXJnT3JYc1F0eno3?=
 =?utf-8?B?Y2FYd1M1bzBrK2krMU9nSmM5Z2tvTXVUUXRXSm9HU3IxUWlYV1VjaWV3NmxY?=
 =?utf-8?B?b0FnZG5CNVBNVDVscUdRMkhlMFd3NjkxMHR2dkhDWnFYZnJoeC9pWU1tSHFy?=
 =?utf-8?B?MXdZOVQrRk9zQ2dZL2hnRmxPYzlPL2tRWTViZXVSWXpUN3pHVERoVlVxWW05?=
 =?utf-8?B?eHA1cVM5YitadXpNejEyNkxyT3VGSGdTNWdLZHhrMW4xVGRCb21MZ2VKYXJT?=
 =?utf-8?B?VHExNFlSSnBlZFhqazVmM3dVUXo4RDFXa2srWlpNcHROMVZibThyZkh3QzV6?=
 =?utf-8?Q?Sz40NaEj9a8EabvojpTOlPK4nCEJgOWDGHrRxnAYh4dm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C35016DDEEDB894E8C60FF911E0640D9@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2759.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4da769-57cb-4027-55cc-08ddf60e2a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 17:18:05.1114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/xiWOAv0RbyOQJ58N4XIvkNubJpRHLhEhyp2IE207zCwpaff+obAWa61NxBTOBPZNmYeVqD0UN/gpwAMMtk9di6fxOVry6zLPLwwXftlY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB0117
X-OriginatorOrg: aisec.fraunhofer.de
X-Mailman-Approved-At: Wed, 17 Sep 2025 22:46:56 +0200
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

T24gTW9uLCAyMDI1LTA5LTE1IGF0IDA3OjQ1ICswODAwLCBWaXZpYW4gV2FuZyB3cm90ZToNCj4g
U2V0dGluZyBmZHRfaGlnaCB0byBhbGwgb25lcyBpcyBkaXNjb3VyYWdlZCBhbmQgZG9lcyBub3Qg
YXBwZWFyIHRvIGJlDQo+IHVzZWZ1bCBmb3IgUklTQy1WIFFFTVUuIE1vcmVvdmVyLCBpdCBjYXVz
ZXMgYSBib290IGZhaWx1cmUgd2hlbiB0aGUgRkRUDQo+IGdlbmVyYXRlZCBpbnRlcm5hbGx5IGJ5
IFFFTVUgaXMgdXNlZCB3aGlsZSBib290aW5nLiBSZW1vdmUgaXQgdG8gYWxsb3cNCj4gVS1Cb290
IHRvIHBpY2sgYSBzdWl0YWJsZSBhZGRyZXNzIGFuZCByZWxvY2F0ZSB0aGUgRkRULg0KPiANCj4g
Q2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvODM5NzM2OWEtOWIwYi00Nzk4
LTljMzAtM2E4MTE2NTY1N2Q2QGlzY2FzLmFjLmNuDQo+IFNpZ25lZC1vZmYtYnk6IFZpdmlhbiBX
YW5nIDx3YW5ncnVpa2FuZ0Bpc2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBpbmNsdWRlL2NvbmZpZ3Mv
cWVtdS1yaXNjdi5oIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KDQpM
b29rcyBnb29kIQ0KDQpSZXZpZXdlZC1ieTogTHVrYXMgQXVlciA8bHVrYXMuYXVlckBhaXNlYy5m
cmF1bmhvZmVyLmRlPg0K
