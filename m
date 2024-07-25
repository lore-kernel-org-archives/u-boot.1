Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA3CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF48586FB1;
	Thu, 25 Jul 2024 11:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="bQ+x2wrr";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="vg70UoT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F8D86FB1; Thu, 25 Jul 2024 11:36:41 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81FCF86D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=929517236=Balamanikandan.Gunasundar@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1721900199; x=1753436199;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=EjrgIruMhDCWLvsSau9hRTbFqrTokVxnMOdairhMuus=;
 b=bQ+x2wrrO1JcQZ/705Ga7OlB6qUUfckx9mju+X4SqogsOq1wJN3jRz/e
 jkCfQgEoBxT1MYMD3niRSp+iTdtOFRzwxAQmku93SpiuJH3D9SEkNxcEa
 4bZ9wVT4LGoxifoxoK7RCyjSM20/2+cgLeOIiXPm9XwMg9Fa4dzCfbbDS
 RSnb9lkdsJxf7E1inGMh7oUiIyMqRBVvDzxwbktIoqGGZvLbv7W7y8kp4
 EdUuWdJiKZvkuyj9dyJOgwrLCQyRDanapAWHUZP9ILG2tjbeSI8fY4/9E
 IYu9o8YJbWqHRujeNGxIu7z6jVciGjUt3pSRC8EPcKQ2RBwBWVZ+j+PWA g==;
X-CSE-ConnectionGUID: DjgMm0mgR8mfWNwHp7iz7A==
X-CSE-MsgGUID: ixQSFVj6Qv2GJTLgO8/5AA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="260570617"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Jul 2024 02:36:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 02:36:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 02:36:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwzWiU1MTF7qXZW55d3pMmT5N2NSUJSEdm7pUGZHN2+h8qrcJWq7R1+Hn6gMk1q4oaVTMXCYj6ns+LjJDrcoCfll5+6Dq22e39O0IVqdIupBQyanxgGAfP/kJx5r9vis02zmC7dVd+cXx6ITdbe7v4NdhjwfwB8LSuiJnUXkYugsTOAi/IKZTYn8ccgfisvcwoYKey23cGZrmRA7EHP93mGh+JHNux0OD1c4VkhAd9GL39qA2jQnGZ4Gk0TTTteJfLiaHvycz+5d4k8OC3YtuiYIOeFID69xoOIdV6fIWMYq9qcidaIPqVzceN6/+ybFhnIdIZ+V9x15eoJTeQXylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjrgIruMhDCWLvsSau9hRTbFqrTokVxnMOdairhMuus=;
 b=RfriQn8bb4oBh7wmoBd1crjnRh2oxSHNUGo8tN4862Hjwc0X5f2RjrECjFBm3zbH0MEyOh7HcH7r5QZiZu1dUihvksgcV9H4+bZoGx4+JtUnYLP1wz76Rf27WNN27bkyYa/rbX3BrlKNUgxRC3ixL5pyRGyjzenZqGrpkNDo9OtelNcp7WHdVK/fYHkULLiQw0chybGayHLSuQ6OfhV7Urp3T/2DTmRHia61em1mOq7KU7FhiQEXnjnweJ0o1osbOTIrKjQPCSfzi8ezWFG3vJ4sjBLwIzD590nLT583N5wlDujf2cDpZdD9WI/rLCHEd4+62hBi2H+R+UkDh5QkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjrgIruMhDCWLvsSau9hRTbFqrTokVxnMOdairhMuus=;
 b=vg70UoT78iXhQMNgAb+LYaK4nEVTduADX9V512pwQ+kj0wX/c+Tyux+oFhhhkBuiEq242pGn/Ae8o78K538Syk7nItu2HMgwFM9mbxfWOX3jBI7TnRjYGvI1knAsKf9T+2xnKZAYpDebzaR2moqu+dy33l2YU63ucl4knirudKcW93Z7JQlu/DkHOc17XgFg1kaqi4Vz0qT8CKfTz7BDhzm8v1Yc+wSnakgBd5ybc8Zu/gSczCfassoJmnV9+ZSd4YddZuQ4uF4FYF63hcxVjCTdiCFo7V6B62cHZYwVxtUdx3DGFZCKYHuaZDRZcZ0TsqYHp1FSTF8AEW9PKBWzRg==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 09:36:20 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%7]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 09:36:20 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
Thread-Topic: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if
 available
Thread-Index: AQHa3DF2Z0JmXlNAZUif07tJpn6GG7IHM9AA
Date: Thu, 25 Jul 2024 09:36:19 +0000
Message-ID: <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
References: <20240721214552.63965-2-zli@ogga.fr>
In-Reply-To: <20240721214552.63965-2-zli@ogga.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|SA1PR11MB7085:EE_
x-ms-office365-filtering-correlation-id: 57fd1fe4-f2e1-4174-b1f6-08dcac8d3d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkZuVmpsdnNLWjdwZ3BUMVlPV3ltam1rT1IvM0FzcnlONXZkZFM4NUpZd21y?=
 =?utf-8?B?cXpwUjhCRExIdVp4cXRCd052WHAvTy82eXRoU3hxRmJoa1Vhd09aUFVaVjdC?=
 =?utf-8?B?RkpaN25wbEFLVUZ0UCtXSUUwU3E0cjlIN0o3ZkJHaTJRMVRxZEx6enY3cWs4?=
 =?utf-8?B?N2ViR3JYMnRoRCtabkdEMWhtYi9LSEZsd3lnUGRkSWZsdlR0dHVaWDR4RkF1?=
 =?utf-8?B?d3ZHeThKNDAyb0FUQys4K3lHWVZZSEhKdnRvUlg5RU5ERDFxTFR6alBsRjBT?=
 =?utf-8?B?T3MzZ1ZMNm5HdGZLeGFyWUV5TmdrT3BQVWF6VjI0U3VwM1lMS3NEMHBMaUNW?=
 =?utf-8?B?M3lEUytzTEVHOEZyeWRYTHMyenllQ2dQQVVERG9OZGhNc2hBOVNsa0I0d0E4?=
 =?utf-8?B?R2FLNUlYS1ZCQXNmWTEra09yNnoxZFByakFvaHBDbEVubEVDcmtmQWluVzN1?=
 =?utf-8?B?VFdzdml3Mk1pc1NtRW5KNFVzcDdzMFJVZFFjVDJ6b1FPaUJSdGNuR0lySk9J?=
 =?utf-8?B?NElwK1laMGM1U3ZrZ3lFaHZmb09sZUNFV1ZKTDZsL2FhV1VXR1Z0UUhSeDBX?=
 =?utf-8?B?ZEpqb2xrc0N2NzZFUy9EdEZZbVRPTlNocm43SWM3MURZOXZIVVAyMWR1R08x?=
 =?utf-8?B?cStJNG1wS2pKWFhMeTJLbUVBaXFzN20wd3NkTUMzMXlKSnlUUXlvK3ByZjlE?=
 =?utf-8?B?NnZINGhGZnNnK1NFZTFpM2RQcWN6L2lxRkJkVmdjOVNWRTcyTCtJcU5CandF?=
 =?utf-8?B?cEQwOFdyMlNNT2k0MXgwUE14OWE2NWthSHJ2NE1DK2tlMU9DZlQwOTVjTHZH?=
 =?utf-8?B?b1pndnp3dUxIdHF2Ung1SEVrV0F3YmVOb0gvbXo5UzFWMW1ZR2lma3pRN3J1?=
 =?utf-8?B?R3NDZ0NBSC9TRUVGZ2VvQkxOMnlVelJoMDE0WUZpOW1WMStpSTRlNHhPYklv?=
 =?utf-8?B?Vm11OVREMml1Rng2TlBheFI4Q2F3TnplWDdYUS9UQmVZUjRMRXc5SmE4K2R5?=
 =?utf-8?B?MVZsTEthdnRzb25tQ1NNQUo5WU5VZ0pzUndXYlc3SHdGTnQydkcvRHdBWVhI?=
 =?utf-8?B?OWhvRHRSVld5L0tXaWZOK01EWjV2b3VzMXl2U3NhWHFRMkxMTEk2NkpLSU5a?=
 =?utf-8?B?bEdzZUJMczdIZ1ZMU2hWc1lIazIwemd5U2ZvZUVnYlpSMlAxK0FSY0dzR2J2?=
 =?utf-8?B?bmVESWFZTlFMZTNpeHBra1VWVUNaYW85enB2V3MzckVJai9neS85VnJVWXhG?=
 =?utf-8?B?ZldjcENOeUllbEY0WEVKcUdNeWxnN2ZlYVRSZzU1U3RGamJxMEsxNGQ3SVpD?=
 =?utf-8?B?ZzR1enNUUUVBaGlGVTYrWTdsVDQ0UlFZei9LVVR4QklMNUpoTFNBR0d0SGVQ?=
 =?utf-8?B?UjZoVWNmckRoVVN3VCtLeUpIR2hCeGQ2RDMyekJhSVJhWHVEZFFKQ24rbmwv?=
 =?utf-8?B?Vm5BUUhNUHFrL2c5QWhPU1RBdGV4UjVMUG5SZDhjQ1NUY2xOSTNlQjJxS1h4?=
 =?utf-8?B?SERpV0ZpeWQ5TC9oR1dtZWlXSmN6QjVGbnp0cUFGSDM2WjUzTjYxbm1rR29l?=
 =?utf-8?B?bGFsK3JINkNTRG1uZkI1MGNzbkJpVzV1T0ZxZHNFMlFYOE9XbEpsSGgzVzNh?=
 =?utf-8?B?OXhaVDNObTBPOElnZ0xXSndFSHJkdDlkSXRTSGgvbHp6dzlYd2tqdmM4d3A0?=
 =?utf-8?B?YmdHZ0Vmb2JSRGVmRmZWNWRDc0tndU1JMlZOMHFMaXE0UEdISjNyQWJRa1pv?=
 =?utf-8?B?QVh2R2grSWRqK1AwNVZRa2pQWTI3VXlySnJ5MWwyQmwwOUYzSGlpRXhsOXFp?=
 =?utf-8?B?R29PQjBicUVXZGVZVGNkMnpkS25KMEJBbEVhM0RCVWw3NFNCZzBWTkljeU5q?=
 =?utf-8?B?blAwaExCOVNNOWI5enR6bEtBSURER2JmTHVCUVR1ekN1N3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6231.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHlmZ2l0Q3JqYnZjcTk2VFVNZExqODJKL1RGZVlLTFpmZTBWYnd1NG1ST3BZ?=
 =?utf-8?B?MTVIMTc0b05xZWhCT0xYNi82a3ptbHdULzAwaitBUUw0WmVsanQ4Q0tQWmt2?=
 =?utf-8?B?ZHQ0c2hKYUxFb3BzaWhSalRkTm5aRlU0TVdYZnRRWVBZUVpRYWY5b1NZQ1Mw?=
 =?utf-8?B?N1ZhalBieWdKaDIwNXMxck1GVzFpeEkwTW1PS3lHdXVMclNidUhjanJwaDVZ?=
 =?utf-8?B?WmlpRFVHbVdWeUxmQWdjSmVqQWc0MDFFZGNNbm5yNDNCR1dhcElnT0ZHeHNE?=
 =?utf-8?B?MkRrRkh4LzlxNVJrbFhHZmVMTE5aUk53MWhFK00xcnBXMFZ5QlIzV0JTSktq?=
 =?utf-8?B?RGtRNjUrU1FqelRjTFNhRk5TMGFYejFNRUhVVDVxWGU0VGtkdGtGSEtwTjNB?=
 =?utf-8?B?QUpoQmhrT0Y1dS8zcmYwMnA1ZTROTzdGRllTUWMvUWM1am5wblNZWkRKMUJR?=
 =?utf-8?B?QlU1WU5LemVZSXZ5Skp5aG56QXVEVy9nVXZBYTRaRmNIb2UzNFA0eFpJMnVt?=
 =?utf-8?B?UnU4dGw5b29XUmpTaWIxRW9GV1NFTU84QnFtY3NTUzc5SmFZemRPOXJBclNS?=
 =?utf-8?B?OXRmeXUzMzVoeDhReC9EZ3QzbE15Z2xBR1VkVDNQQzlIcUlrbjBuS2ZCaUdj?=
 =?utf-8?B?aURBc05acHAzQWFNcmVUUjBXMWhzcytadkZvcTRwZVNEa1VYbkpBWWFmaEdu?=
 =?utf-8?B?ZDRzWlJoaVNjaE5GYXp2dEZDbjJsYzhaUzh5cWQwTFpmZXFHSGhOWXJnVGVv?=
 =?utf-8?B?UjYzQ0c3TVp3akxWSGlFMWVWTDYrNUdrclNDTm8wd2NsOGs5a3BRV2dlOVRa?=
 =?utf-8?B?OUNaWFhXQUk4aUZqbEgrbFg1anZEOHJ0eVgzem5USDJmV0ZieW9Kb09Zc3RZ?=
 =?utf-8?B?NEFuQ2ppcnI0OFlxVndHK3pwQ3FROTJGcEYyV0g1QkdOaUNpUnRNMGVuUjQz?=
 =?utf-8?B?SzROWjJiTkMrdzRpQUlVVkIxWHVQRXovZFh5VXBTeXhlc29MNWpHQy9FWTRH?=
 =?utf-8?B?UDRjSFhVNFAvNWpqN1NMcGpJR2srM0lkNkxlNEFRd3dLUjBQWlJ3ZUtHdW5x?=
 =?utf-8?B?M3dtL1JyamorSTBhNis4RVlZN09wMGRvOGFuaWI4V2gyZC9zc3lBVWJmYW9q?=
 =?utf-8?B?Mk9DdGVhbFlvN3paNTFOY2hRYi9pREl2Z3hZeTdBVDF2L0p6d2pzWHRsRG9o?=
 =?utf-8?B?dDhta1RLSjl1YVNxbzJ6K1p2OVBOdWZmOWVjRnNBQjRuNHdUWWF3ZUt4NFpr?=
 =?utf-8?B?cmMxNFIzcTJOMEJMQjVmajdoQWs4WXhiVUloZ2toa2xmcjdnT3V3c0RBbHha?=
 =?utf-8?B?eURIUjJ1ZzZOY1dCNVI3L1ZGdDVhcXNOMCsveHFMZEowTU15Wksxcy9aNTJz?=
 =?utf-8?B?MGVleUN5TjBqOFI3QjMyYVVVUFloSDE5SEZqVUl3NHVGY3Zpa016ejNiNVUv?=
 =?utf-8?B?cjY1TGh4eE12UVp4M3JLZDZYWDN0Q3FPTXV0VWxxME5aSTVONFc5WlNhOHEx?=
 =?utf-8?B?VzlqcTJmU3JtRFMzL1NaekFuYTVWNGl6Z3BNUWgxNVBGRkhtL080WFI2NENM?=
 =?utf-8?B?YW12TTZMSkl5TXc5MDg3aWN4aWhyRTMyLzVxL3lxcExVRlBoRGJkbVp3WHc5?=
 =?utf-8?B?Zk9tWS85U1ZXUE0yMjFSWFVORzFkS3J1ak1jdHczWDVSOGJ4R3c1L1dUaVVY?=
 =?utf-8?B?eFQ2WkFpbWJIbUlNc2JWR0V0ZnJlM1lTbVAzUnFYa0UyVm5PVGF2SFdMTlRN?=
 =?utf-8?B?MlRQN090MjZqS0h5d2x4V2FhenJEcFlKWVdianRNaTBNcEpXRG50SWdnbThz?=
 =?utf-8?B?UzFFcWR6TG5sNGJ1VGpMUHg4RUhpNzZqTGlrdlcyRjY5YVI5TW9ReHdpai9t?=
 =?utf-8?B?VDQ4bUlPRTZuVWYrRktYdmN1M3dESDBnZVlPbGFlUVNZVUtSUEJzMUppZ2Rh?=
 =?utf-8?B?aW96NE5CeC91MjFtWFFnMlphZU0zTVZzdEhKdk9BRzdIbXBIY2Rqdjg3akVR?=
 =?utf-8?B?SHlleHpDMExtaEVwdEd4STkvc2tNOEZ2OEpyS2VPQlBDUE5jUldzWlpZK05C?=
 =?utf-8?B?Slk2RDFFTVV5Uk9HZ3BkV1EzNHRSeFNXUTZHTEVYTkFVM3BTV3NFRGFac1o1?=
 =?utf-8?B?YmkwWmZMMENwTHFUN1QxZXgvU1UzeHNTNVdBNUZZWWdGUGFpQkVkUlRESXFB?=
 =?utf-8?Q?38JXpy4nF0YUwnDyQ1HdVH8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C9EFFBD59FA9E4FA9F6B1C8C0B80377@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fd1fe4-f2e1-4174-b1f6-08dcac8d3d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 09:36:19.8918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HV9l5wbVjUqOAhe5g4h9JSKmSDs2nugx2lqMxrNa5JxWnOBZ0xwjaaNumiN569yPNsPQ/HQuwNzB9h+lnAynp12qj+Ef9fZDTl2aq6ET6+T0UsFOGgNwVJgT6MRV5z85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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

QWNrZWQtYnk6IEJhbGFtYW5pa2FuZGFuIEd1bmFzdW5kYXIgDQo8YmFsYW1hbmlrYW5kYW4uZ3Vu
YXN1bmRhckBtaWNyb2NoaXAuY29tPg0KDQpPbiAyMi8wNy8yNCAzOjE1IGFtLCBaaXh1biBMSSB3
cm90ZToNCj4gW1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0
ZW4gZ2V0IGVtYWlsIGZyb20gYWRtaW5AaGlmaXBoaWxlLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMg
aW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlv
biBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFdoZW4g
RUNDIHBhcmFtZXRlcnMgYXJlIG5vdCBzcGVjaWZpZWQgaW4gRFQsIGZpcnN0IHRyeSBPTkZJIEVD
QyBwYXJhbWV0ZXJzDQo+IGJlZm9yZSBmYWxsYmFjayB0byBtYXhpbXVtIHN0cmVuZ3RoLg0KPiAN
Cj4gSXQncyB0aGUgTGludXggZHJpdmVyIGJlaGF2aW9yIHNpbmNlIHRoZSBkcml2ZXIgcmV3cml0
aW5nIGluIGY4OGZjMTIuDQo+IA0KPiAgRnJvbSB0aGVuIDIgbmFuZCBzeXN0ZW0gcmVmYWN0b3Jz
IGhhdmUgYmVlbiBkb25lIGluIDZhMWI2NmQ2IGFuZCA1MzU3NmM3YiwNCj4gY2hpcC0+ZWNjX3N0
cmVuZ3RoX2RzIGFuZCBjaGlwLT5lY2Nfc3RlcF9kcyBiZWNhbWUNCj4gbmFuZGRldl9nZXRfZWNj
X3JlcXVpcmVtZW50cygpLiBVLUJvb3QgZGlkbid0IGZvbGxvdyB0aGUgcmVmYWN0b3IgYW5kDQo+
IGFsd2F5cyB1c2UgdGhlc2UgMiBmaWVsZHMuDQo+IA0KPiB2MjogRml4IGZvcm1hdHRpbmcsIGFk
ZCB1cHN0cmVhbSBjb21taXQgaGFzaC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFppeHVuIExJIDx6
bGlAb2dnYS5mcj4NCj4gLS0tDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1j
b250cm9sbGVyLmMgfCA0ICsrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250
cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0K
PiBpbmRleCBlZTRlYzZkYTU4Li44MTdmYWI0Y2EzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210
ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KPiArKysgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9hdG1lbC9uYW5kLWNvbnRyb2xsZXIuYw0KPiBAQCAtMTAyOSwxMSArMTAyOSwxNSBA
QCBzdGF0aWMgaW50IGF0bWVsX25hbmRfcG1lY2NfaW5pdChzdHJ1Y3QgbmFuZF9jaGlwICpjaGlw
KQ0KPiAgICAgICAgICAgICAgICAgIHJlcS5lY2Muc3RyZW5ndGggPSBBVE1FTF9QTUVDQ19NQVhJ
TUlaRV9FQ0NfU1RSRU5HVEg7DQo+ICAgICAgICAgIGVsc2UgaWYgKGNoaXAtPmVjYy5zdHJlbmd0
aCkNCj4gICAgICAgICAgICAgICAgICByZXEuZWNjLnN0cmVuZ3RoID0gY2hpcC0+ZWNjLnN0cmVu
Z3RoOw0KPiArICAgICAgIGVsc2UgaWYgKGNoaXAtPmVjY19zdHJlbmd0aF9kcykNCj4gKyAgICAg
ICAgICAgICAgIHJlcS5lY2Muc3RyZW5ndGggPSBjaGlwLT5lY2Nfc3RyZW5ndGhfZHM7DQo+ICAg
ICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICByZXEuZWNjLnN0cmVuZ3RoID0gQVRNRUxf
UE1FQ0NfTUFYSU1JWkVfRUNDX1NUUkVOR1RIOw0KPiANCj4gICAgICAgICAgaWYgKGNoaXAtPmVj
Yy5zaXplKQ0KPiAgICAgICAgICAgICAgICAgIHJlcS5lY2Muc2VjdG9yc2l6ZSA9IGNoaXAtPmVj
Yy5zaXplOw0KPiArICAgICAgIGVsc2UgaWYgKGNoaXAtPmVjY19zdGVwX2RzKQ0KPiArICAgICAg
ICAgICAgICAgcmVxLmVjYy5zZWN0b3JzaXplID0gY2hpcC0+ZWNjX3N0ZXBfZHM7DQo+ICAgICAg
ICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICByZXEuZWNjLnNlY3RvcnNpemUgPSBBVE1FTF9Q
TUVDQ19TRUNUT1JfU0laRV9BVVRPOw0KPiANCj4gLS0NCj4gMi40NS4yDQo+IA0KDQo=
