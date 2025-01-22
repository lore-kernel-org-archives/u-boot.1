Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7859C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 07:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100E580586;
	Wed, 22 Jan 2025 08:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XR/FXO56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6732F80762; Wed, 22 Jan 2025 08:15:18 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE0080283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4LKOu65h9aCMMrSEffR0BWIZk+92guAIOEGXcM7tlODPrkc8RzfGusKktJcMz/4GPJyVjGhboNSVWpmaw5dd9sGtcUeSymCSi0/YBls4nMY9FRCtyK+7Zhzw9INjTvSLacJ+LLCRsm/U2D54Y+zdsBpdTta2LiRog3zU4gnXVrvHRV/FG/ewrA+R5h9QqLlNgNNtyU0a6tIuLqYkOzY6vko0USCDT9dtpsey5m/c3no1DHY3EtDenigwrkaHugJd12jgJrp+FcRmZD5H2IMAccSFjW/KQts+jNAHqZFcfhxBSuTWnV+gZ5x68ok+JEGUGNZEkY/jZAgU5BAqfXU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H6EIkaTzoXWBmmwOXjUs1HkxDZ598fyBKo/QQFrcRI=;
 b=Ax3UCvx9TVLzE5KvTcQxN11Qcf68/C36mW7cKAlgOuB+MhBeIx3EqIK5lmmrrPZLZcCPUh+rhZENOUVJRgV4Ej1uVoeiVfVsgbAOnYQci90Aartrtjtpz/a7NDg7LnCRHZZ7orjMlIwOKGvhQ1ISzCgZWGjW7rXFwdH65umr0rjAE3hCI+pqAeao8Ij65hWLHdHcSVKEdOPr7Gdgi92tOReiw3A+4kJjpqNwx/D43wMS0Ht2WZ2LStYnN9IVgDLHk2HJt4UNT4K48BxY9l8QdRNlUdqF6B3JnRkQbOnplJl1angWhuHOqYR53JmLxgWEDrweGFmWI24hf6bJpJrjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H6EIkaTzoXWBmmwOXjUs1HkxDZ598fyBKo/QQFrcRI=;
 b=XR/FXO56J+nmOWqz1djqa7thS2+USLrKCe9a6xiSMD/qD05QgkygomEr7y5823ZNhLcfPUT3k0PYDaB3y0aalM3ovCJb5etMMqQqHUzRp3PAlT9LahcIG3cbWjrOAv3V/f55n344N9C0+tGHv3X/x7LnOv01Ug70bt5nl8K8xDEX9OfFJelpONIAxa1KI984PBHTLCP68SafdY+1zeQ0PlI5bC+iFDJXSWv+1pjn14nPsQsQgREbnCRUMPbkISLqQSeChSLL+x/6dwi/m5DkHIdIdwaxRS075MvwE21q94sktwM+H6CJzDbH5Z+VRj4NhLSEwjwpD2fF9PPn7cfqjA==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by AM9P195MB0917.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 07:15:14 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8356.010; Wed, 22 Jan 2025
 07:15:14 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "festevam@denx.de" <festevam@denx.de>,
 "marex@denx.de" <marex@denx.de>
Subject: Re: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
Thread-Topic: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
Thread-Index: AQHbaIMuz2mrP9Y+CEeOUab6MRvuW7MaoYOAgAapj4CAAR6pgA==
Date: Wed, 22 Jan 2025 07:15:14 +0000
Message-ID: <3ca516f8c9d2c96d136b0223c0a37874c8fb605b.camel@phytec.de>
References: <20250117015642.2373824-1-festevam@gmail.com>
 <efbbd217c00ec775fb7c2a7a0da18a4b5ee0e39a.camel@phytec.de>
 <CAOMZO5C0yDQr1QJ3RPOa_=O7=hgtR1_9GQdYCoomjuTUB7SyRA@mail.gmail.com>
In-Reply-To: <CAOMZO5C0yDQr1QJ3RPOa_=O7=hgtR1_9GQdYCoomjuTUB7SyRA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|AM9P195MB0917:EE_
x-ms-office365-filtering-correlation-id: c170bf91-b9c8-4c7e-a42d-08dd3ab48440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVZYYjRhaU0vZGczdHZZUXphN2VYUmZjdnRYaW9CU2ZoMUp5d3d5Y1J5TmhJ?=
 =?utf-8?B?R3c0eEVYUW5jaDUza3V6SFltVDRjbk50YS92M2cwenpCQkZJekpTR3E0eTZy?=
 =?utf-8?B?Unh3VzFENm0rTGpRK002WXFuMGcrSkt0bFR0YTlsSm1oOHVYejhva1o4eFdN?=
 =?utf-8?B?NTU3WjE0YW5pVm10b1R6bUVXRTRoeTZoTWluY3RVV25mM2JFUnhqYmlTSU1L?=
 =?utf-8?B?OFVsU0x3bU5qYnMrT2tMWU1iZkFmMjFkQm1HbXVLbytJcHJEMk1MeUdUSWlY?=
 =?utf-8?B?b1JyRlZhT1BwNU5mU0dtYjBVeGV6bHp4bzNsSEZCL3lmN281UGN3N0xCeCtS?=
 =?utf-8?B?UGczUUZpTk53dnkwS0QzWW5lK2NCd01SWXJmM2pEd1JPdmFlVXBYWXZhY09m?=
 =?utf-8?B?VldUSWlpYkp4VmZsckluTjNNTkZzeXpSK0l1TFZQRU94OEswZUV3eEdicDQv?=
 =?utf-8?B?bmlkY2RnZTZ5UnNKRDJtUG1SMExwU1liV2x5N3hFOUlVOEVwL3M1VVUzb0lv?=
 =?utf-8?B?MERVb1NlcDVsd1paK3FJRlRhWkg5WlAvUWxUQi9qeThKQ3NTaXBWL1M4ZGpI?=
 =?utf-8?B?MlBNSnplVHkwVUNhSDlRbG5tbFFyT3Rvb0paT0Zqa2ZJU2dBOHVIZUk0bmZq?=
 =?utf-8?B?WDdBUTIvbEhzcURZMHFnUW5pRzVwRVpuMU1hQjJIenpuU1AvcE9IV2V1QTJ3?=
 =?utf-8?B?ZHRnZ2hGKyt4ZGVVTmlXZzdXaWxSSVZ6SXlUa2RwdjJ5NG8zVmZDSDNMRTIx?=
 =?utf-8?B?WUJVbWlldjltMkgzODZDM3ZTa2FiMHROa0ZFYzNQSmJKU1ZWVkdhMlRvdnJJ?=
 =?utf-8?B?clliM1c0QytIRGlFTnNYYTVZQmlGR21NM0dNbGVjNFNyOEdzZmtZZlh5dmxL?=
 =?utf-8?B?UVA5OHQzUTRwQlRIUHFYOE5CU3FOdU9YTkh0WExHVUNieWJvUlg1QWhkdWIv?=
 =?utf-8?B?ME5nR1EzYmhPemNEN3NTODRtUllIdjRKUUhORkRmQWZLN3VZQ1lEUnJvbWts?=
 =?utf-8?B?bEpBTVcrMW9LV1Y3YTZoRzZGTzluV0xWRHljUUpvOFJJY2xSOThaWm9BOGZr?=
 =?utf-8?B?cE1jK2JBQTFLdVVwSjBrK3RZUUIyTEY0Q1FLdXRFMngrR081eEFqYWdDQkd0?=
 =?utf-8?B?Z0FxVzFVeUtFYnFmTFUvaTQ3MXAxeUEwU05wREdsRU8vakpONm5WVkJKZ3lI?=
 =?utf-8?B?RXJjTzVyRy8weVBRUEZaTHZlTTRIU0NZbkVDMERaMnVIUk53RnFYeWJlTmU4?=
 =?utf-8?B?WGNzQXgzbk5YQzV1cXcxbG1KSGxrdkIyNnhGYkdPbnhuV1lxcXUzTTAxT0h5?=
 =?utf-8?B?QWw1cnJEeTNUbzhSNHRhYk81Z2pVcFhROHVHbmdFUEZSVWhsekhWTVlzdGc3?=
 =?utf-8?B?eUZBYVYrNDQwRXVnYjFlQ3JjT3hIOStlK3lRazdQUzAxNHVwR0c4MWxZQVpY?=
 =?utf-8?B?RXJ6M3poelpEYm1td2VtclZRMFhXa045S1kxcHRpTytNZ0Q1cFVuQVp2UEt5?=
 =?utf-8?B?RlVwSzlpdVF0TmhNSVdRZ29ybVBIeldQUXE3aFlaQ1IvVm03NUVNM1NmS1BQ?=
 =?utf-8?B?R1FOUWxFVnlrVlYwNm50cUJlT2ZKcFhxaElxeUEvOVZod2VpVnl2UDBSK2Rx?=
 =?utf-8?B?bGJZWWVOKzhQd2U5UzNjKzVhVjAzaG04RmR5emNTM003LzdrT0NmeFptbWdR?=
 =?utf-8?B?ajdDTVJ0aUJyVWVNN3p5RHVQMHFlS3FaY2lJV3cwbUhkUTFHanI4c1VNYWxD?=
 =?utf-8?B?TVZyVVpoMkdYOURqR0tTS2wyb0lLckh3aWxIUHVZRDVOQ2lUQmdlS003VEJZ?=
 =?utf-8?B?czBESFRjeGFiK0szMWM3SHBXbzRVbERwZFkxb1JpS050NFQ4Y3VyR0lyMjZK?=
 =?utf-8?B?M3F3ZU8zOGF6TGFGT1B1eDBRODFLazZLMGNiVjFvSFloVVZYNWgxU2p5N2wx?=
 =?utf-8?Q?aYenJlstFMWehDvDy0LA9G4XVMoD0yue?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aklJVUhjbVZOQjY4ck5IMnFGaEtybE95MzZoOEpGdXByR3ViT1pVN1RqcGZx?=
 =?utf-8?B?U0hYVW1YNUlQb2FJaDVKa2c4R1pOWVFkM2NVV2RQVzJoNmpEK0ZCN0EzT3Zs?=
 =?utf-8?B?aTYraW1NYUcvbWpXcnhqNzBVZCtabnJXOENOY1RkVkswdmUxRFJtaDFFZzgr?=
 =?utf-8?B?d1BYRHh4b0FtVDZKMHI4Ti9HcWdKbmF3UkZmRDR6WmdZcUhvUllQRzIvK1Fn?=
 =?utf-8?B?S2t0ald0Zlh4amF4eVBYMGMyZGhIM0pVUHExZVlYczgyc2NTaGFvbmRDNXp4?=
 =?utf-8?B?dS9RbmtKWlJoMWtTV2pQWTFQc296V21ZWGpKQ21FQ0JzQ2hWRXhzRGQ4M3dC?=
 =?utf-8?B?UHptbG1vSGlRSmQzU1V0dWRHYkl6dGs4S0dqWGxGaDJvWVZPTXJ3anlJWEQ1?=
 =?utf-8?B?NFZJYzBjOUZIRVd0Smh3UU5MV3Z2RnZtRGZEVkU4dTNhRzhTT1kzcS9KYTJ3?=
 =?utf-8?B?NFVsYTFYZUwxVStiMk5aUzNBa3JQTEs1VkNqbHhON2hNZFppL045cUxJa2JH?=
 =?utf-8?B?ODZCc2I3aVM2SHBsWjhUd283dUFPT1YrZ3RFdm5URS9ibEVxTDNEWWw1d1Fw?=
 =?utf-8?B?d3ZDbFpkWWlMQUZjUTU3ZjFPSCtpbzVlejRSbEl3Y1Q4RkEwZVptUFRHcS9j?=
 =?utf-8?B?YVp1dUFhTWFQTlBGYmpuL2IzTzhKN0J5ZjJUWE94ZFQ3NkdvU3dIYXVRa1FQ?=
 =?utf-8?B?dVZIN2wzWWFLVnpZWlZ2T2haNTFxQjdLUDN3em9maXh5ODUwV3QrbVBDeXhp?=
 =?utf-8?B?SDJzNkppM2VwK3d2bklUSmV1a0FncC9Ea1dHUGVIeGZwOUEzbSt3ZmMvMW0w?=
 =?utf-8?B?RVFheWVSaDE2dEFkaFZiSjJMa00weXFBM3lrUFhVVVJLcHRydUs3QTJMeDNO?=
 =?utf-8?B?RXRoT011a2FjY1lhUkFLMFZmWmh1bXZQb3JjZk5mSmR1aWoxaWdYQm1uK3U4?=
 =?utf-8?B?N2RaRXoxelJXWjJXaWpUaVlVbXowZjVlN1dBUTFORjE1VytSdXhDRkNBVWZD?=
 =?utf-8?B?QXhIcFYyZHJDY2c0eHZIT1hERFQrUGI3RWhMT1ZuNlB1bEQzNUdXQ0JxaXBJ?=
 =?utf-8?B?TDFGektTLzJpRHBTc2thdUh2ZEd1T21weGtkS09BejlhUC9xeVEraWdqUzZn?=
 =?utf-8?B?OVpxYS9ZN2w3ajBnRktpZ244QnRSdUNRYlZUYWcwbUxzRytXYjY3UWJlbVFU?=
 =?utf-8?B?dWVEOHdiQVY0eUNMdWd2UEU1ajJCWFd3a2dkYWpydkoxYjdwSG96bTdSNHhh?=
 =?utf-8?B?RHE4dk84R291bVFFOFo4ejlWajVTZ00vNlIvVUlqREwwK1RrU1EycmN3NUVU?=
 =?utf-8?B?eXJndC92ZkxCS1ZMTGlaT0VNaUUwVUQ5Nk1VYk1mNGNHMlkycmVVU1JaQnA3?=
 =?utf-8?B?RXlDQUJadXMrMERiQUdVL1VWOERkbDlNLzNzakVsMjIyL0xOTmp3bUdqdjFW?=
 =?utf-8?B?SEVEWWNJREw5ekJoSml4eFFocjFCYUFrTHZQeGQ3UEdoMzlZdEtwK3BkcExp?=
 =?utf-8?B?RUZERlhncHZMOTRQWVpzdW1qa3ozL3lNTmtFc1A4TlBoU2E5RUEwOGNaOXVj?=
 =?utf-8?B?WFZVaEx0cG5PeEZHbjNVcnBRMzJJOU4zc01PNi9sajhSUTlNKzNaMHgvNDQx?=
 =?utf-8?B?RFYyYmhOTE5xQmtZSExyY3htM3pGN2VWREV5QzNLZnVyWGZHdHFNSForQUlV?=
 =?utf-8?B?M0JYSXBiK2dPZmd0NzM3RGFJRDIxR2p6MTQ0UlJuU1pVZVVDNE5TdEVEcmF5?=
 =?utf-8?B?QmxUaE02UGNORHU3V1ZNaDdJekFhdjRYTDFPYnpLd0R4U2JETjBZV001SHQ5?=
 =?utf-8?B?ZVpHR2d5UlFLVFp0ODl0OFVtTGc5TnZaeDdqSnBwcXNQMUpacTViQTVnaFlT?=
 =?utf-8?B?QzZOWk12UEIxMlJabk9YOW42VlhuYlNkd2UyeEZJa0FDa2xFNHB3M1pnMGR4?=
 =?utf-8?B?RVJiSDVhYmdjc2xXNytRcmFsaSt6Y1IxVnNRbTBvM0ZoZGVUNTF3b2JxNGYy?=
 =?utf-8?B?OFhNaDdiK21KazhTWmRoOXRkV3g3ZnlEdDRDcnVacHhjNjRRaitZNE5LOGdW?=
 =?utf-8?B?VUtCZlk5cFhLZnBkZkp5d0JvamhlQXhGcjRDNi8rNzdyczFPcGhZbWw0Sno1?=
 =?utf-8?Q?wERuhVuwofx5pPCjS+fEPqCHV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FAFFD5B1E462342BFAC99A0D19BA63F@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c170bf91-b9c8-4c7e-a42d-08dd3ab48440
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2025 07:15:14.3528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CvibP1cU8PQFQDwqoXLvu3enxaLz0y3jIsDVBw1s7x7gUx6Z49z6xL512C+9SXX170sgVy54lxmdq0f4RXgMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0917
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

T24gVHVlLCAyMDI1LTAxLTIxIGF0IDExOjA5IC0wMzAwLCBGYWJpbyBFc3RldmFtIHdyb3RlOg0K
PiBIaSBZYW5uaWMsDQo+IA0KPiBPbiBGcmksIEphbiAxNywgMjAyNSBhdCA1OjI04oCvQU0gWWFu
bmljIE1vb2cgPFkuTW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiANCj4gPiBJIGhhdmUgYSBxdWVz
dGlvbjoNCj4gPiBTaW5jZSB0ZWUuYmluIGlzIG1hcmtlZCBhcyBvcHRpb25hbCwgd2Ugc3RpbGwg
Z2V0IHRoZSBzYW1lIGJlaGF2aW91ciB3aGVuIE9QVEVFIGlzIHNldCBidXQgbm8NCj4gPiB0ZWUu
YmluIGlzIHN1cHBsaWVkLg0KPiA+IFdoYXQgZG8geW91IHN1Z2dlc3QgdG8gZG8gdG8gcmVtZWR5
IHRoaXM/DQo+ID4gDQo+ID4gV2UgY291bGQgcmVtb3ZlIHRoZSBvcHRpb25hbC4gR2l2ZW4gdGhh
dCB3ZSBndWFyZCBpdCB3aXRoIENPTkZJR19PUFRFRSBpdCBtYWtlcyBzZW5zZSB0aGF0IHRoZQ0K
PiA+IHRlZQ0KPiA+IGJpbmFyeSBtdXN0IHRoZW4gYmUgc3VwcGxpZWQgYW5kIHNob3VsZCBubyBs
b25nZXIgYmUgY29uc2lkZXJlZCBvcHRpb25hbC4NCj4gDQo+IFllcywgdGhpcyBtYWtlcyBzZW5z
ZS4NCj4gDQo+IFdvdWxkIHlvdSBtaW5kIHNlbmRpbmcgYSBwYXRjaD8NCg0KV2lsbCBkbw0KDQpZ
YW5uaWMNCg0KPiANCj4gVGhhbmtzDQoNCg==
