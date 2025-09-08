Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBE0CA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 09:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 003AA82AE9;
	Mon,  8 Sep 2025 11:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="VOp6R5/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB14382C84; Mon,  8 Sep 2025 11:36:13 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3718E809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 11:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMB5Gcm4ojvUPlhddXUIT3navtsMlKS4AvuyUK6Ze9R+tvFin5goTxBE6qvWUn31oLD71ezeWAVCIItlM8VCzy9MlZlPxZ3L0Yfq31k18ABevpBbCcdkum84wvwG1RMJ+oBER3dOrcQy9VLkrSvNIH07J1d/kNHQF7z8/wEZ32IT5DLpyKUjfQM5rllDItdJhK/itGOyzw6/Kc+UfetMTpK21HpF4wlFSsodftjSQB5+TaqpER8hxP6yFZd73KC6RMGW3k9QBmMvnwEsmSGL8fh7+v4AQucod9btDVr2zCXZhtcebgr+cVCKL5i2MKrykag1mqsSng/8P1EMdaZaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msCQoq/piOhahRuzQQ7n8n+PMbtrzU5P2pCFeH7ilDQ=;
 b=nkvCUzBanqibsRSd4WTQY9NjxhfgxPQYZfqJjgaR3IrllvBTROqY2hms5OdFkVkNtfH1yNDJ/+AVkm24S08HsqFJ+2qy7Iu/UJ9Hg6vQmEY5dlP0Azbabm6YS5As7l1gFlPGP6JALi6yyPXRWxTUU98vBCbhrb/6XyOJ1nEvoi13kOkvzhJPmpONIMRXusDHh9jscdlldkDxEolGCQS/u9ZbdyeRLVQquAJlYSg2naNJg0/kvwOqTIFOe9ZOd0gdhpiNAMT4iJMQsZ/g9w1Rwj8TBnGlhq502jHZKvvdTGSxhuSSC4J/jr66HX82J26zw3ybPHCW2Ny2qRmfxyFvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msCQoq/piOhahRuzQQ7n8n+PMbtrzU5P2pCFeH7ilDQ=;
 b=VOp6R5/5NfAikndsBGevBzMqzQ7Z+b/ES4Qc6bg6HIWNtNq2R6Id1nS+IUWr2cAlKqALq1zqvHJkDUR63OHAmmC8kA6xTjJNF868Des+IEqd6I1lWAplGUghb+8psZqA22IJ1uupo9Yoi4JQrbY3ni5neOku4y7frY+l6nQBxY7RazoxrIsksQyuSBDMaxlf7vTUAr8wxWa4v9gUBF0mevNeFoDOTIyVGgIZXrg0JuvAEwSurtZWlpvp2AnjJER7+9Bp5XLHfvzy8ZHk8XQVFCplzMkh0UBWA9dmrTd3GQMRtbB6yS2qOu732b80xzGbpSX+PWEGMV6kumoVmTqEaw==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU2PR03MB7877.eurprd03.prod.outlook.com (2603:10a6:10:2d4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 09:36:09 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.9094.016; Mon, 8 Sep 2025
 09:36:09 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Jonas Kvinge <jonaski@opensuse.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLSGhZUAgAPS5IA=
Date: Mon, 8 Sep 2025 09:36:08 +0000
Message-ID: <0eea5c3a-de37-420e-accb-5476be4a515c@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
In-Reply-To: <f12fccf0f6d6b36fa58a7ef971ee9d06b566b03a.camel@opensuse.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU2PR03MB7877:EE_
x-ms-office365-filtering-correlation-id: 8e7eec0e-3fb5-4445-2824-08ddeebb2441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?V3VRR3l5elpGWmwrTUpDN3lsZG1XMDlxZDlsdGE2TFhralc1UUlma084ZStI?=
 =?utf-8?B?VmtWa0lmaXpqVWprVVI0MitOUEhVYmFzRzExTjdLS2d3NVdvWFE1eUcwNnRr?=
 =?utf-8?B?NTF6czdYRit0b1g5REFwandqaFE4QmlJcHE2d2t3ZmVnUmRVVmxFbU5uVC9x?=
 =?utf-8?B?SE0rdm82b0ptSG00alpSazdEdTFESFdUNmc4V0VBaENKT2NDR0c3bmNtTzQ4?=
 =?utf-8?B?Y0xhWEdSWW9yaVVxMGdCYmFSckx2V2s1UUhqODB3eWs4M3k5YkYrVFczVXZi?=
 =?utf-8?B?ZStsTXltRGxyOXJzTklTWHptMjFHcnF5bUgwUEYvcWgzc3BHd0ZrakRXaDdo?=
 =?utf-8?B?OUZObnBTc05EN0VmZFQ5MG5UMWg0S3VmbG83TFQ3VTdaRHhNQ21HU05iVjZB?=
 =?utf-8?B?bXlzeEVjejQrdWlwNjZ0cFA5blBabGFFU2Zlbkd5U0Yxd3ZQWUQ0WTA3YmdQ?=
 =?utf-8?B?dm5WYmFwNXJSSVFsMzNaRVd1cmdYU3JjZkJHeFBVZXp1UFp1djNpaDltWEox?=
 =?utf-8?B?S3lyS2RmNWxnQUk5aEdrclFvYkQ1TTk2bi8xb3V5TDdJc3hsRkw2TzlVWGtG?=
 =?utf-8?B?OEJsMy9KWDNMampCVzlvaWtMRzhBVVlSZTBLV0RVbEdsVUpVQWd1cDBVNk9X?=
 =?utf-8?B?VVZSOHJHT1pBZXZrUGdzZ3VOUGxKOXNLSDJrRmFTYU5ncGNMN2oxb3BtZDJZ?=
 =?utf-8?B?dXBZZzMzWGVGeWtNbWtGdkRSTk1BWGZQYVJIOVlONmxnOVJwaHQyM0JnOW44?=
 =?utf-8?B?c0NLYnZPTEtYUEdpUjZTWC82cy9MTTZubkpVb0w0SkFJN25NVHdob0RtbHFn?=
 =?utf-8?B?TUdLc1M1eWRBMnZ1NjFIR3phQitmdDd5V3hxb0JnS28vNTZMM3YvZlluTkRC?=
 =?utf-8?B?ZTZjZUN1K3lLY2RMSTZMTmd0L3o2RTZ4VzNGY1IzQ2twUjVFbHhhdDllL3lC?=
 =?utf-8?B?NXNQK21uWDhVeUlqSWRMMDg5SlF3b051RjFVTzlxQ2E5Y1drd2FqVkR0OFAr?=
 =?utf-8?B?RlBuQjd2NS9jOU45ZnRyYnNpRjg4QVJ5RGJoalFXNkZBSEE1Y2JKOFJKSkNw?=
 =?utf-8?B?cUJCUVZDMG9TYXRYcjhFdDZzVHVQditrUzltSkZTNFVCaGFCRzZUM2VSMFVp?=
 =?utf-8?B?cGR6L3kyOUJManJ6Q1dieWtHWE53QWpVdEZ5a2FpZUJHMk9jM1pnQlRieFVK?=
 =?utf-8?B?dWNWUkk1YkNvU0R2anBjMENJM0FyS1RPT1ZXSUYvNVVjQ0w1V09YbXlNZER0?=
 =?utf-8?B?MWtsamd6TVdrUlVqOTlqMHg2RDdGazRaeHV0RlFYL3d5Qk9ldE4wa3RBNUFH?=
 =?utf-8?B?bzhXKzhZQTZ3c1NXNnVkRTZXRloxbUMvem43KzNLUjRxR3ZEQU1XR0UxUHFB?=
 =?utf-8?B?UWVRVnc3ZzViSStGWjFZVndqUTUyeGlzdFc4dEMzUFo0N21DY2xZaGFjOXFH?=
 =?utf-8?B?RFZpNXRDUE5pMXA2TjI5cU5NUVVkdUNXb2sxbWJQK0tSM1F2ZlA0TlVEVVMv?=
 =?utf-8?B?TXZsNkpoSXQxWmpSL3ZQUEdsVlNUOEFnbmVxRk9DZVNha21RTHdibFpKc3M4?=
 =?utf-8?B?bVdXcDZKMkJ6K3NVR21jSGpLdnBMR0YxSUFiWnB5dTFJUnBWWmYzMlJHZ0tS?=
 =?utf-8?B?RENZZDA2enRpeElHVFdpR3BydkZwL1VING80STZaMlZQZ29INFN4U1NwUE9B?=
 =?utf-8?B?S1hyYTRqYkFXTzBvOHhjRVFuWXdlTC9FRjdBYjM4TFJIWHFYQkpDdDdkVDky?=
 =?utf-8?B?Y2FqdVpuZ2JDbnQyMEkyL3Q4cEVGalFzU2FMdVZQeWdhbnk0ZW5NbVUydk9n?=
 =?utf-8?B?RjhZcHp6ODRzenpKeVNsNU1IcDVTOFJ5c0lQWVhXMmJZZXUxOUQrdVl5RWpQ?=
 =?utf-8?B?SUgrOWF5Yk1yOUw3VWZmdDFQTzNFamZEWTdGUUdxblNWS1FtbldCenQ1TmZO?=
 =?utf-8?B?WjhmUXpUNGVudTcxZHhpOVA5RmVvSVByNHRpdlhnK3NrK3cyUWwyNHpNUmc3?=
 =?utf-8?B?NGNVV0dHcE93PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXYybFdpZEpRYk1XNzYrM0xlMmViTjhtWWp4OHJXQUd0RWlkSUtPU2lNbXBM?=
 =?utf-8?B?K215ZHUvcGZHSnRUcnpXZGIwUTVuUnZkaDNYQTZuVDJham9zQmVUc2twS2xz?=
 =?utf-8?B?R3ZXQ29YVkpXTjVxSkVpQW1RUkdnckI2UFcyd0w2Q2lZWE5FK1c4M1dpdi9k?=
 =?utf-8?B?SGNSb2lmWjhJa3lTcDVVNEFSS2N1ZE5BMXpKalZ0dGEwdE1mb3BrY25nUXli?=
 =?utf-8?B?aGpJT1creFBWZ3dRSHJRdEFONVM5V0dsUWpLUkNHbmEvZDIwOHU3ODdqRmZF?=
 =?utf-8?B?NElCSmdmaXBvU1h1M0xLVzhna3dLbXNhT3pIUkNkRVJrNEdLcDc1aFN6bFox?=
 =?utf-8?B?Z3c1ZTJ5clJiMGlVWkJSdjdPRDdwSTFxK1h6V3p0dUlHZXNtV2pRZ3NzSnAy?=
 =?utf-8?B?Y1M1NEtBWGViZStyaGJldmNJL3IvNE9SaTFwa2Q4clhINHc5bEg3b3RpMjRr?=
 =?utf-8?B?VkJQZHVmanl6WmJ0am5qZC9qRDZ3VDBlR2JIZm0xS0hwUmZUWkVrRi9NVEpt?=
 =?utf-8?B?WTNURW53Q1RUMGVSbUhBYk51NDMzTnVBWDcra254VHFLRHI5QnV5S0ZuV0lp?=
 =?utf-8?B?cUsvRzhRWUo0RlZscWpiL2hCWmlVbTZia2pLMndaOVdCRjMxUXdHekx1ZzZj?=
 =?utf-8?B?SnU4K2kwU2VGWHNZQ1pRYVZ2Y2JKY3Rpd1psRnRkVno5RjNpc1dwYm9zTXdk?=
 =?utf-8?B?RXBMeTF5a2JHeXU1Z21aT1ZuU2p1My9OTEM4N292YkwvZ2I0aDc2MzBWMmEy?=
 =?utf-8?B?VWVKZTkvVnRSMDNGbkVGUEN4UjBvZWhSMlk3SE41eWJndG5HU2NNSThzNVht?=
 =?utf-8?B?TDFHUlVJY2ZVTUlLM0pGb2tUb2s4ZFhjMkNUZVpqcjZDb050YTNqZURjU05r?=
 =?utf-8?B?WHFHTjBUZkZnalpDOWd6VHlRbmtRREdQMThIZUt3bzdoekVGb0p5clVtWjBK?=
 =?utf-8?B?TEQvTURhUmorQW9VY09DbHI5ZzIyV3JLRXp6WjhRaDM3S0FpOXhZQWk1R0JW?=
 =?utf-8?B?cE15T3hNbm5qUS9zdTJWdm1vc2NwVklBeDV5bE0yY3ZoNE9idzkvWmdEWkxn?=
 =?utf-8?B?dGtYOW4wcTFVWnk4MHA3c3JtdUhTMVlXYWlqblpUYlRQZFF1b3dFUFBOZENq?=
 =?utf-8?B?ek5Ub0w2UkdrRXMveEF5WDNxVHdIajVlU3FidEhWcTBMQ1BESmV4azNWWk9Z?=
 =?utf-8?B?QnNZTStvUzRURlhlT2tyTWpQS3NKWFpuSHJPOVJtZnh3b0RucGJBNUNVTjF2?=
 =?utf-8?B?U2lXZ1VTK054aUhIa3Z5VTBhbS84enQxQVU3azVKKzF4LzZSTjVQYTNaV2U5?=
 =?utf-8?B?b01YZ2tpRHRDaTM5aDN6LzlLcGVVZHNLOGRMNkhzQ3Q1T3dUWkpWVkh3ZWNY?=
 =?utf-8?B?RU9SNUNGSlBScDN1SkNOSFpYRUdOSWYrTEszQVd0b2ZKT2tRcGN1a1RCeE9H?=
 =?utf-8?B?VWRxSEhidm9ReU1wREgxTjZqaFQycllSSDVkU29WK1lsWmhUaGFydE11dVZC?=
 =?utf-8?B?b1RaZE1EWE9WdmgvaGpOWHZyWmRMdnFvVmpRcG9IYXJKMmwwSUlTOU5kMkpa?=
 =?utf-8?B?cEVTZGk4T0FjVjUyenZaQUcwdnlXcktqdDFMZnhvYzNySHBvNkt6anRLTFVK?=
 =?utf-8?B?TzZvWVh1K1licm5sSVlERGhjbFpzYmQ2TkRraVNyMWpLS21ySlp0MWF5Uk1M?=
 =?utf-8?B?YnNtR1d0dUpuN0IyeUthbUJJUXVpUWFQa0ROeVBNT0RJUHZoSWNHSkVMK1Q1?=
 =?utf-8?B?Slo0ZVRiYlFWNXBwbmJVWnQ4VlVXalZwaWpnVjBjVjBqeHVyeHM1NC9UNE5U?=
 =?utf-8?B?eGt5ZDI5SUhEQTk3dGlMd2tkenduMXc1ZUpuOW8yU0xYd3lzVTBFNkFucWIx?=
 =?utf-8?B?ZzVXeExTQ0RTMk14a2crOHh1VHNYWXg1M1dJWVQwVXhlSHZ4UVVqYVoyVmY0?=
 =?utf-8?B?dnhCekpBYjhXR1FsaEpTUGdROXh6THIzem93MEpmeXErWG9tRzlaNnFaU3Js?=
 =?utf-8?B?WjhwazBvZDA3NWdmYjhaUHRXVFNTbXk5aWJ6TE1QeVBuR1NqYnloQmJBQ0lK?=
 =?utf-8?B?anAzUjduaCtHdXRyUTlBZ2VOcy9ob1Z6aXg4b1RXN2wrRklkU0FtZFVqNTh1?=
 =?utf-8?B?N2xWeXVTMmdrOEJzNlU0TGtnanBtK3drTEVRc0p0SFZ3ZTF5MzhTVjFUQXh5?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <441878DF4035474E89B3C71327A82834@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7eec0e-3fb5-4445-2824-08ddeebb2441
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 09:36:09.0451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TZd0ndJ/i0H9XCV6VH+EDEgFV4RCGap1Jc1cckJ+OnXbP32BbXPZKsO92RDh/Iepov1pYRkCn3gHc2mV45PZzYOau3WPoYiqg0qc/4iB2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7877
X-Mailman-Approved-At: Mon, 08 Sep 2025 11:37:56 +0200
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

SGkgSm9uYXMsDQoNCkkgaGF2ZW4ndCB1cGRhdGVkIHRoZSBVLUJvb3QgcGF0Y2hlcyB5ZXQuIEN1
cnJlbnRseSB3YWl0aW5nIGZvciBSUDEgDQpiaW5kaW5ncyB0byBjb21lIGludG8gdGhlIExpbnV4
IEtlcm5lbC4NCg0KSSBzZWUgdGhhdCB0aGUgYnJjbS1wY2kgZHJpdmVyIHdhcyB1cGRhdGVkIGlu
IHRoZSBsYXRlc3QgcmV2aXNpb25zLCBzbyANCml0IHNob3VsZCBiZSBjYXJlZnVsbHkgcmViYXNl
ZC4NCg0KT3RoZXIgcGF0Y2hlcywgaW5jbHVkaW5nIGJvYXJkX2xhdGVfaW5pdCwgc2VlbSBub3Qg
dG8gYmUgYSBwcm9ibGVtLg0KDQpJIHdpbGwgdHJ5IHRvIGRvIHRoZSByZWJhc2Ugb24gbWFzdGVy
IHdoZW4gSSBoYXZlIHRpbWUuDQoNCkJSLA0KT2xla3NpaS4NCg0KT24gMDYvMDkvMjAyNSAwMjox
MiwgSm9uYXMgS3ZpbmdlIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IGpvbmFza2lAb3BlbnN1c2Uub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0
cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gT24gV2Vk
LCAyMDI1LTAyLTA1IGF0IDEwOjE1ICswMDAwLCBPbGVrc2lpIE1vaXNpZWlldiB3cm90ZToNCj4+
IFRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGdlbmVyaWMgc3VwcG9ydCBmb3IgUmFzcGJlcnJ5
IFBJIDUgaW4NCj4+IFUtQm9vdCB3aXRoIGFkZGl0aW9uYWwgaGFyZHdhcmUgZHJpdmVycy4NCj4+
IFRoZSBmb2xsb3dpbmcgZmVhdHVyZXMgd2VyZSBpbXBsZW1lbnRlZDoNCj4+IDEpIGFkZCBnZW5l
cmljIGJvYXJkIGNvbmZpZyBmb3IgUmFzcGJlcnJ5IFBJNSBpbmNsdWRpbmcgZGV2aWNlLXRyZWUN
Cj4+IGZpbGVzOw0KPj4gMikgYWRkIHN1cHBvcnQgZm9yIFJQMSBjaGlwIHdpdGggYWRkaXRpb25h
bCBoYXJkd2FyZTsNCj4+IDMpIGFkZCBzdXBwb3J0IGZvciBycDEtY2xvY2sgZHJpdmVyIHdpdGgg
ZHQtYmluZGluZ3MgdXBkYXRlOw0KPj4gNCkgUENJRSBCUkNNU1RCIGRyaXZlciBzdXBwb3J0IGZv
ciBSYXNwYmVycnkgUEkgNTsNCj4+IDUpIGFkZCBjbG9jay9yZXNldC9ncGlvIGRyaXZlcnM7DQo+
PiA2KSBhZGQgZXRoZXJuZXQgc3VwcG9ydCBpbiB1LWJvb3QuDQo+Pg0KPiBJcyBpdCBwb3NzaWJs
ZSB0byBnZXQgdGhlc2UgcGF0Y2hlcyB1cGRhdGVkIGZvciB0aGUgbGF0ZXN0IG1hc3Rlcg0KPiBi
cmFuY2g/IEknbSBoYXZpbmcgdHJvdWJsZSB3aXRoIGF0IGxlYXN0IHBhdGNoIDkgYW5kIDExLg0K
Pg0KPiBKb25hcw0K
