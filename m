Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E2C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 18:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A67588251;
	Fri,  3 May 2024 20:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="hD8vkv3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3988825A; Fri,  3 May 2024 20:42:26 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4370688249
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 20:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmRv6z31IcDpfzuaIC/IQDmTpcjiRlGQijLP/327vommIonbYldrSGV1UwYVroPUNrUlfZLTSJylVXMX/Zav8bnX0q/0BlkVvEhXMxLqDegujd3wK3NFgD83akyLSBgGdwnE6LYzrcs5Fwc9PacVnD0u/mKPtlskyvJ2o2K9siYKtK3OuMtUmWU4aMrtQDyid/UAYk0+gaWltp43WRhXr3k54/upXvWSx6XnkeoP37sKfd/VswcXd3x6Mj3OMEAUk/mrLz9+XLb+wpihn1RkkbhXgAWsYnixovyHdeaPmwEOu4A6+3nzu3ucJMTd7prae75IaxUayiAjoaZgkUNeAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlkiiQTm7P2yEepjBo4BOM+q5DtsjgNhPfUEchtsBaw=;
 b=YKGgGbC0IaI5mLQl04shcXQWwrf2LKyoAngc4ZpFBbGZ9/81wscO9j2reA38JZngPaal1BNcEgudebx7zfkb6SLAB8EPoP43MHZk6cZko1oJIShZrRLddojfVvfMMP8b9EZo6F30pggtHTWRvwZDjaruZWv6LVw6qGEKwuP3fcocLIKnxGvy1zIGfgiZl8seuhEihxm67fWRvb40Zs1cI6lxDdKYPPoMEtG5MO8fPcr+tJQ2OQfZ+W8HmW6jbMX2rJWX8VgopuPmsaZe4VuFXRp9w9Tptl/RfpoN5Dt7K93WSQvyVhWY5/aQfEz25I6NQLO3r1H5/y/UZsXAkCQexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlkiiQTm7P2yEepjBo4BOM+q5DtsjgNhPfUEchtsBaw=;
 b=hD8vkv3blKq7JNqUJe7w5tQq8d68ANERqtSUsiVng+WPG3M1aOLZtguueiWcqLTlVFt/DeNZYmJkB+l2PR5Xtm23x7MxLY8zfGBWvRXOIti92DFirihXIgLBjnTNp1sLz2m/XIEHMNSXKrxGgMkGd3Qgmd8ZwtnkHhkCgZpqsR4TDSYPyLlEbUZjdAPJcI9KutpL3PIi746zNZGmukDIdLZH9q3bd0JuLriyFMe2xv+IcJZ6lPKKKg7l3t5ntxv0vK51rVW/ZnpABqhmPCinw6cBeOM7ckn71ZMq/sqBfHwtIbmQrZ/fV5ZrsQZP318iPHKQfVHP7SRFk3NuUdwggw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PA1PR10MB8969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:447::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 18:42:21 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 18:42:21 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "j-luthra@ti.com"
 <j-luthra@ti.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "danishanwar@ti.com" <danishanwar@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "nm@ti.com" <nm@ti.com>, "s-anna@ti.com" <s-anna@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH 5/5] dma: ti: k3-udma: invalidate prepared buffers before
 pushing to recv ring
Thread-Topic: [PATCH 5/5] dma: ti: k3-udma: invalidate prepared buffers before
 pushing to recv ring
Thread-Index: AQHal7BJVpakRiXKBEej3IIjEK7zNrGF4+EA
Date: Fri, 3 May 2024 18:42:21 +0000
Message-ID: <e15d883b217e0195425a88a7c1eb931ffb0e98c8.camel@siemens.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
 <d3f36df0833702190ce902033a4c14d5d844d9b6.1714117337.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <d3f36df0833702190ce902033a4c14d5d844d9b6.1714117337.git.matthias.schiffer@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PA1PR10MB8969:EE_
x-ms-office365-filtering-correlation-id: 2c257f6e-f2de-42de-b800-08dc6ba0c4a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|7416005|376005|1800799015|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?b0h2anRpelRNRWxQN3BYZUxtc0t1b2ZMcjE2NFhQc253RHBpeDV3RHdFYVRr?=
 =?utf-8?B?N0Q0RHZlWGlQSFRXSlFwNDJuYkthb25SMHRxaUw2RUoxMExaWDJXT3o1NG9k?=
 =?utf-8?B?SDI5WG43YmRjblNPcDZRczZPdGFFc1RTbFNmdHorYmtyek5qcXZPM1hDZGtF?=
 =?utf-8?B?Q2REaklwZHFJTkJFemN1SEdRQkRDOGgySVMzVHhhbnFPQjd4eEFmTERTQTVI?=
 =?utf-8?B?TWoxb1N0YURPVU82cUtFdmN1Mkl0Rk5QeXJIVmh2RDIrb2ZWT3R2a3ZNMWM3?=
 =?utf-8?B?c1A2SlNoSnM5d1JVK0VDTlR0Vjk0b3BFR2kzYXF5WG54VUdwc1pCSUtmT0JG?=
 =?utf-8?B?RU9yTlRRV1kyUXVqWEdJUEE1MFdNQThsbitkMWRDQno1UGxTMkwrak45UzU1?=
 =?utf-8?B?UW9nb0FkZ1JEZ1NDM1FPN3p0dHhueWNOQVY4RzBVQ2g0aGpsYnkydnk2K2Q5?=
 =?utf-8?B?dmRyWEYxM25sSzhady9QZWc2aWJXeHZBMnhDaElTRWlteWRncnBwS0ZtUU9x?=
 =?utf-8?B?Q3RXVklGakRld3I0UXplcjU2L0JGRzkza3U4emZxVnBiRXRMb2hieU0zMEFC?=
 =?utf-8?B?Z1craWIzVEpiQkRVY3d5aExhUWFydXI3WkRIQlhnaDFOR0FmS0lnS2o0Szg5?=
 =?utf-8?B?TXY1bkphOTJVWFlzK1VLZURReHFjWjVwRk96d1lndWl4MjNkbDF0N3BqKzFn?=
 =?utf-8?B?Skt0Z2NKaHQrSno3WHIyZDRBcHhKRnIyeXJiU0RoNHVYbnpVRlQrWTRNb3FM?=
 =?utf-8?B?R1htQlFNWkpFNXIvVEgwSngyZmtvZWZjcjNrc0lWSGtjbGNUR3kxMkJ1WHBT?=
 =?utf-8?B?ZkZOZk1Ca2pRL2RjV2dQQ1lwbTJsWGEvRDdyWGRNZHhWT2M2WTM2ZmxwS1pw?=
 =?utf-8?B?eDRPSmpRaDhXZlpPT0RGRm01LytOb05rVitpVlpSRjhZSEE3VkFCQ01xa2lu?=
 =?utf-8?B?NS9Qa1JRUzBVaVR5Zk8zL0d6WDlUN0RrZHh0SStIRW9ndE94MTRyTUM4MkE5?=
 =?utf-8?B?QmpYL2NrREFnRWxsdzRZdXBPdmVmTUd0VS9sdENkbnRJczE5ajh3Y0x6emVK?=
 =?utf-8?B?c3doQi9XdisvR2U1WUZHbWNwQmJHNlFVVFUrSHcxei9Pb2c4NUdtdXl1QVU4?=
 =?utf-8?B?T0hDWHdnNFk5eHBoKzBVRFVxVlYrbzA5M3ZPSEg4WEdaaTJaRWlhOHRTS3l1?=
 =?utf-8?B?VlVObElQNlBMbG1PVEtsUHNkMEZNTjgwZzEyMTcyZkpUMGIvWENtZHBudEx6?=
 =?utf-8?B?MmhmVWhCWnJPQzNtbWxpcHBuYW82MlllS3czUmZzTUpESDVaZ1RqZnVmQlpD?=
 =?utf-8?B?SlJ3ZWJDN1dpZmtPdisxU25MOVk0bE0xRHlpYytPRnVqVFZGVXhMdkx0aWxH?=
 =?utf-8?B?cnVtR3RYbU5nbWc5UWRFV1JkOTl0Z2p2RzQ2WWJBRHEveHpzOVZuUEYrNlZS?=
 =?utf-8?B?UlhPTFB6bnkyQlNBWDdCY2Nla3lKZWVFQ2Qyck1JZW54cGtaL2hmU0xIcU5n?=
 =?utf-8?B?RG55VE9uTmlJaWw2MDF5R3hWUSs2S3NEcUFXZzIxa0JvOTA3Tk9hQk1peEwx?=
 =?utf-8?B?b2xBYy9OM3RyYmZOUjRCU0VkN2JnTXg1K0ZzTEI4ekVRaVNpYldob2hybGJK?=
 =?utf-8?B?ZkFob1FVNVJYcnY4eE5yRVVWbVlkN1djNTZUVzZucmVJdHJjY1lmS3FLYlIy?=
 =?utf-8?B?cFgvSmRGWStzTkFYUWhzOXdMNGs3c0dXeDVJQkxyTWhSeEVpTU5mcmlRQThy?=
 =?utf-8?Q?XFRIXPLiPa2Oz/xO1k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009)(921011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBCR29zc1pMbDUxZjB3dEFGbVBTeWtXZytXdzZPbm9zVlBKQnF0Z0ZoWUds?=
 =?utf-8?B?SWUvQTB4YWVPc0tLeks4U2I4Qjd1aSt3aC9NZXpvK0oxV0xCVWNoUnoxcmhl?=
 =?utf-8?B?dGtBVjlJa0JuRWhXTVVBdG9wK2h1ZzRvU0EreEFUb041Q2NPRkJnUEVJcHJk?=
 =?utf-8?B?Ym5YalcvWEwxaWFydUg3TDF6cXhiVTMrcnR5SVAvTDdDTWZIVTVidlZ3NUpU?=
 =?utf-8?B?Tm1FdU9KaDFUemwrclUwUmE0QWtZN0orUWJtTzRGcnIzaHRlZ0greW00Qyta?=
 =?utf-8?B?NXZqU01Yc1l6dFFIYTRUbDZjNXI0T2Z3NDRPci8rK3YzSXNtOHhabms5NytP?=
 =?utf-8?B?cUlLUE9tVWQ1SXNBaktvMlJMS25lQmFQZ2RKSlNLRy9vTk9UdC92YklNVElQ?=
 =?utf-8?B?WExMYy9pTHhNNWxwbWd3djlFeHRKdXA0UDhQSXdCdnRraXFnSHpwTE9TMjJt?=
 =?utf-8?B?c0JGdUFoRXV0QVdoQzN3VUplQ3NwRHFucjAyTXRKRFZiWHRzdDVENDArM3J2?=
 =?utf-8?B?TUpvOHdBaFFTUFpMYmZFR2xUL0pjd29zdVhwc1dNSEVvdWttcTRPOWJubnFn?=
 =?utf-8?B?NU9oVVJvNERoNERRSlorRnpITkYzcVFsWjFUM2piR1EvMFh0Z3FiekFQclJn?=
 =?utf-8?B?ZkJpT1VkOU5UYUpUck5oZzBDKzJNUDJZWGEwNGREcmNGK2xrVW1wSDF5VllR?=
 =?utf-8?B?Y0RqN0REY21neVdnTTR6SzdZUW1aUnVGQ0pnMmpudVUwclMxZkdnNFk4VFZu?=
 =?utf-8?B?cUs1dzlJT1p5S2RGemZkQjRDNldxSVcrbjUwN3RZL0VMdThKOUtkd0NnWnJy?=
 =?utf-8?B?QXloR1VsZFl3TnVPUHBaNVptYlBjSGxCc21tT1laWEc0ajE1WTFjVW8zS0Fz?=
 =?utf-8?B?R2VRc21HcmVFNTlxdU9jNklqdmVncWpRUUlRSUZYa1Z5a3RpME8vd21xdHhL?=
 =?utf-8?B?aGl4ZDZFOXRsRy9zQU03YmpMdGt3VzJzM1U0YzJoa2daMmxNK01oMTBCcE1I?=
 =?utf-8?B?RnQrNnR4ZGFCN01Ydk1vL0VPWmhYeDNYc1E3dTRjaGlWS2xSVXZtbGxocFBk?=
 =?utf-8?B?Q0dCOXoxTkhsaTYyZzg0Uzkralp6dVdEellwdkh3WUVQZ2cyVzJocXh1RS9D?=
 =?utf-8?B?Z1AwYkIxZ1AzN1JaQ215VmhCYlFhUDk1WU41WUluMmtFckNtSktocGdsTUd2?=
 =?utf-8?B?d0ZtbjRENWJPZ0YzY1RvRlJoZzN0QzRPZEtpZWNUbWFabVl6RVlFNE92RWJR?=
 =?utf-8?B?cjk3VnI0ODBUUnVOdEJvRXdPaVhpdDErYTBGV1c4SHgvRmZUc2ZwcG9sRzlX?=
 =?utf-8?B?YlJ5NzRFMXdpZ01DaGVnYStXaXh6SzVUNjFlb2VCRE1KclF0d0p2L3diRmdQ?=
 =?utf-8?B?Qzh6enRYSW0xaU51NVlPN2xseW1tVUpqQjJHR0tqaHE3NnVCdWN2UXg0NWJX?=
 =?utf-8?B?TkhUcGFBc21qM1ZFdHhpdlFEcjZ0eHBjMEFnZ04zL0d5bEFNK1RqS1ZvWkxW?=
 =?utf-8?B?RHhRYjlBZkZCK2RMblU5MDlrTGZKdTlqdHRzR09DWDYzMXkrSytweGZJRzh1?=
 =?utf-8?B?K29aeUNhbGlobDZqRG9uYldCQXJFKzRKNi9Vai9ZVHRCNG8rQTlZT3R4cHFP?=
 =?utf-8?B?QWowNmRvRGRXUDBZOVZHTWJqbHVWcWFrWFp6RFVEQnhISTJreHBwR1ZmV2d5?=
 =?utf-8?B?d0pmS1NVMEZjWEZ2WE8yWXdLNlVNZS9obXFKSkNrREpWR2lsdkc1b2FkRWp6?=
 =?utf-8?B?aVhGYzBLMEhtVjdiN1RDV1pOZEc5VTd5L0J2U2pLN09TZTc0ckFUU0dsQXk4?=
 =?utf-8?B?OE5jR09DaVdXekxOVTRSRksxYXJKai96WG4vb2JFTUlQdWo0VVpoRXIrTzdL?=
 =?utf-8?B?WDlFUHM1T0JQRUlFMjk0bjNLYjIwSUZFdjdXSGFWbjlBSkluMzg5T0lzYnNn?=
 =?utf-8?B?Z3drRWYwRUhnTktXc25uVTROVVhrSUErc0hFZ0NvK2V1bjNOTFRVMFRoZ3h3?=
 =?utf-8?B?dG9yS00vUmlGa0RSVnZmWXBuaGVRUkEyWWVlblMzZENPeUk4cHcweVpHSHJY?=
 =?utf-8?B?N2hBa0lDQ2FaZW5Kb1VSWXI3VVlCcXVBdHphVFlSR0RVTnNWWWh5cUloZE9k?=
 =?utf-8?B?T1ZVdVBwcFBRYnZkd3pXWVRZd1pyRkc0aDN2a2VnOXBXMEt6d0ZFVmdHa3Fh?=
 =?utf-8?B?Sk5RdE0zRWd1dUZ0QXZVZjRCRExTQ3ZJR2tuQ29nNXhheDhCU3RUSE5jREZ1?=
 =?utf-8?Q?f0HFX6uZCDAes/+JHMDFaEpq76bSWqMs4cO4Jk4P7Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3B7565D6840FF44A053370F5E4A1A76@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c257f6e-f2de-42de-b800-08dc6ba0c4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 18:42:21.7593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNs8z4AfM9qVjMSwrhaC2omnOmgmSS5ojKpJT4RX8gaGblutv7Azuf8nLb4qqfQYWbW4hz96v+lRxG31LCPrw0xS3KECb2d3ZFrnRFLDLWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8969
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

SGVsbG8gTWF0dGhpYXMsDQoNCk9uIEZyaSwgMjAyNC0wNC0yNiBhdCAxMDowMiArMDIwMCwgTWF0
dGhpYXMgU2NoaWZmZXIgd3JvdGU6DQo+IEJ1ZmZlcnMgbXVzdCBub3QgaGF2ZSBhbiB1bmNsZWFu
IGNhY2hlIGJlZm9yZSBiZWluZyB1c2VkIGZvciBETUEgLSBhDQo+IHBlbmRpbmcgd3JpdGUtYmFj
ayBtYXkgY29ycnVwdCB0aGUgbmV4dCBkZXYtdG8tbWVtIHRyYW5zZmVyIG90aGVyd2lzZS4NCj4g
DQo+IFRoaXMgd2FzIGNvbnNpc3RlbnRseSBub3RpY2VhYmxlIGR1cmluZyBsb25nIFRGVFAgdHJh
bnNmZXJzLCB3aGVuIGFuIEFSUA0KPiByZXF1ZXN0IGlzIGFuc3dlcmVkIGJ5IFUtQm9vdCBpbiB0
aGUgbWlkZGxlIG9mIHRoZSB0cmFuc2ZlcjoNCj4gDQo+IEFzIFUtQm9vdCdzIGFycF9yZWNlaXZl
KCkgcmV1c2VzIHRoZSByZWNlaXZlIGJ1ZmZlciB0byBwcmVwYXJlIGl0cw0KPiByZXBseSBwYWNr
ZXQsIHRoZSBiZWdpbm5pbmcgb2Ygb25lIG9mIHRoZSBuZXh0IGluY29taW5nIFRGVFAgcGFja2V0
cw0KPiBpcyBvdmVyd3JpdHRlbiBieSB0aGUgQVJQIHJlcGx5LiBUaGUgY29ycnVwdGVkIHBhY2tl
dCBpcyBpZ25vcmVkLCBidXQNCj4gdGhlIFRGVFAgdHJhbnNmZXIgc3RhbGxzIGZvciBhIGZldyBz
ZWNvbmRzIHVudGlsIGEgdGltZW91dCBpcyBkZXRlY3RlZA0KPiBhbmQgYSByZXRyYW5zbWl0IGlz
IHRyaWdnZXJlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIFNjaGlmZmVyIDxtYXR0
aGlhcy5zY2hpZmZlckBldy50cS1ncm91cC5jb20+DQoNCnRoYW5rcyBmb3IgdGhlIHNlcmllcyEg
SSd2ZSB0ZXN0ZWQgaXQgb24gYSBjdXN0b20gQU02MjUtYmFzZWQgYm9hcmQNCmlzc3VpbmcgYSBh
IGNvdXBsZSBvZiBwaW5nczoNCg0KYW02NV9jcHN3X251c3MgZXRoZXJuZXRAODAwMDAwMDogSzMg
Q1BTVzogbnVzc192ZXI6IDB4NkJBMDExMDMgY3Bzd192ZXI6IDB4NkJBODExMDMgYWxlX3Zlcjog
MHgwMDI5MDEwNSBQb3J0czoyDQpOZXQ6ICAgZXRoMDogZXRoZXJuZXRAODAwMDAwMHBvcnRAMQ0K
QXV0b2Jvb3RpbmcgaW4gMyBzZWNvbmRzLCBwcmVzcyAiPEVzYz48RXNjPiIgdG8gc3RvcA0KVS1C
b290IyBwaW5nIDE5Mi4xNjguMjUxLjEwDQp0aS11ZG1hIGRtYS1jb250cm9sbGVyQDQ4NWMwMDAw
OiBrM19kbWFyaW5nIFJpbmcgcHJvYmVkIHJpbmdzOjE1MCwgc2NpLWRldi1pZDozMA0KdGktdWRt
YSBkbWEtY29udHJvbGxlckA0ODVjMDAwMDogZG1hLXJpbmctcmVzZXQtcXVpcms6IGRpc2FibGVk
DQphbTY1X2Nwc3dfbnVzc19wb3J0IGV0aGVybmV0QDgwMDAwMDBwb3J0QDE6IEszIENQU1c6IHJm
bG93X2lkX2Jhc2U6IDE5DQpsaW5rIHVwIG9uIHBvcnQgMSwgc3BlZWQgMTAwLCBmdWxsIGR1cGxl
eA0KVXNpbmcgZXRoZXJuZXRAODAwMDAwMHBvcnRAMSBkZXZpY2UNCmhvc3QgMTkyLjE2OC4yNTEu
MTAgaXMgYWxpdmUNClUtQm9vdCMgcGluZyAxOTIuMTY4LjI1MS4xMA0KYW02NV9jcHN3X251c3Nf
cG9ydCBldGhlcm5ldEA4MDAwMDAwcG9ydEAxOiBLMyBDUFNXOiByZmxvd19pZF9iYXNlOiAxOQ0K
bGluayB1cCBvbiBwb3J0IDEsIHNwZWVkIDEwMCwgZnVsbCBkdXBsZXgNClVzaW5nIGV0aGVybmV0
QDgwMDAwMDBwb3J0QDEgZGV2aWNlDQpob3N0IDE5Mi4xNjguMjUxLjEwIGlzIGFsaXZlDQoNClRo
aXMgc2VxdWVuY2UgbG9va3MgZXhhY3RseSB0aGUgc2FtZSB3aXRoIHlvdXIgcGF0Y2hlcyBhbmQg
d2l0aG91dC4NClRoZXJlZm9yZSBmb3IgdGhlIHdob2xlIHNlcmllczoNCg0KVGVzdGVkLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAt
LS0NCj4gwqBkcml2ZXJzL2RtYS90aS9rMy11ZG1hLmMgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS90aS9r
My11ZG1hLmMgYi9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLmMNCj4gaW5kZXggNGU2ZjdmNTcwYzUu
LjhmNmQzOTY2NTNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS90aS9rMy11ZG1hLmMNCj4g
KysrIGIvZHJpdmVycy9kbWEvdGkvazMtdWRtYS5jDQo+IEBAIC0yNjc4LDYgKzI2NzgsOSBAQCBp
bnQgdWRtYV9wcmVwYXJlX3Jjdl9idWYoc3RydWN0IGRtYSAqZG1hLCB2b2lkICpkc3QsIHNpemVf
dCBzaXplKQ0KPiDCoMKgwqDCoMKgwqDCoMKgY3BwaTVfaGRlc2Nfc2V0X3BrdGxlbihkZXNjX3J4
LCBzaXplKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGNwcGk1X2hkZXNjX2F0dGFjaF9idWYoZGVzY19y
eCwgZG1hX2RzdCwgc2l6ZSwgZG1hX2RzdCwgc2l6ZSk7DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDC
oGludmFsaWRhdGVfZGNhY2hlX3JhbmdlKCh1bnNpZ25lZCBsb25nKWRtYV9kc3QsDQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCh1bnNpZ25lZCBsb25nKShkbWFfZHN0ICsgc2l6ZSkpOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKg
wqBmbHVzaF9kY2FjaGVfcmFuZ2UoKHVuc2lnbmVkIGxvbmcpZGVzY19yeCwNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTElHTigodW5zaWdu
ZWQgbG9uZylkZXNjX3J4ICsgdWMtPmNvbmZpZy5oZGVzY19zaXplLA0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFSQ0hf
RE1BX01JTkFMSUdOKSk7DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3
d3cuc2llbWVucy5jb20NCg==
