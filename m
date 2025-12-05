Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F47CD2F7C6
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 09:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5498084198;
	Fri,  5 Dec 2025 10:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gwZjkZQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F3E84199; Fri,  5 Dec 2025 10:41:37 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FF8840FB
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 10:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkzr6ElXMqv1/IihTjb3xdZCjMmaC9MZK1l/0Zj9k8nf24BDqvLSfes7KxKmU51lEzoqWstB4ItYa/XHFGUuPj0hnwyDnwj0Sg+kZrNZ1f5UvPmypUtAv1IGo4XdkrU93j1wkeoHRNMMnjn6tkT/4fjR3hQxYUg1ErIwEzpeZQjXqwi+GF2x9dyttC325HzaCrV/lFit0rOUPayYwtQBbvpRTNkmIJabzq1jDvrrIHlffh2DYs9UVzuLnocRrgRsiofBTK1QbVgH12DHttvLiCZ7m6aiE/kTzN8XCJs19Dp0M3fy6dsBgpJ54OVm8FfM1XDxdTvkvOv2AmrFfmRCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqjXHmOumyI6r1XcQ8EJw8zHgNVCZQqVhg4X2nCaM/s=;
 b=H+Irne0aFJNzAEmMsESWyZLQBbttY8v5m2B0UNF+32aoF4LKqqBwdkK+krmQGnq+dHUX4unRtrm1HJDAcoJQZf33J9b0DIlcE6/8ziqv9To5S1ltEH/Yssn6cGJHy1Inu/gqNzZ4nj2zWp8N2cWNSg6cVxmCtGTfKYDIQsb3U6qocGW71CHPPE8sGQd8NGrKsh1NzE5UkBqyFvDQ3DnrnEm2iqejVu+bW0juHzWcC2pLQKxeSGSaqVUDgYDFgpwCMSx8uILKounnmEP3S38UKSp7LyM8Yb/Vsid7Quzt4yorgl/PnMyFY3JYqjc1grBauAgKM6+/kM2Nce5N2ZrExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqjXHmOumyI6r1XcQ8EJw8zHgNVCZQqVhg4X2nCaM/s=;
 b=gwZjkZQ/ec6bSmIeVMX8nm/NXzheN/nck7DvHsd5XRNNpkKhdL3rTM67bCIpiUTeIruma6A1YU8bRtVt39sLWup+AwSFvCvPGfgtpJdhFc5wrSqeKJjinZrQORmVqFJZEQwtZ7AZ+LBIzKnpcjY1pHyyqNh9r1+KU1Hfk6WY42uy+uJXJ9KggEZFKbdUdnpJt1ZJIKNYUDpfU9eolucc1J9CpyXGSTK9zf1oFagz5SVFw9AOgNRpo/uklCe3ptkBvU7UQvy/0h0ApUYRKwkOP+jvl1c9YuPy7do08IKRvqpfAy6tE2GGvDJQsTNz8W82GFKgcaOD4CWSmIh+Pwe3vQ==
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:588::12)
 by AS8P195MB2045.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:53e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 09:41:29 +0000
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c]) by AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::e2ee:5897:5a51:d40c%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 09:41:29 +0000
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Primoz Fiser <primoz.fiser@norik.com>, Mathieu Othacehe
 <m.othacehe@gmail.com>, Christoph Stoidner <C.Stoidner@phytec.de>, Stefano
 Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/3] board: phytec: phycore-imx93: Switch to standard boot
Thread-Topic: [PATCH 1/3] board: phytec: phycore-imx93: Switch to standard boot
Thread-Index: AQHcZPUVrqFIep+bhUS6pJC8xgPbarUSzL+A
Date: Fri, 5 Dec 2025 09:41:29 +0000
Message-ID: <4b0bf7cf-db2d-48e8-93cc-854b0e7aa802@phytec.de>
References: <20251204080744.3868067-1-primoz.fiser@norik.com>
In-Reply-To: <20251204080744.3868067-1-primoz.fiser@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB2011:EE_|AS8P195MB2045:EE_
x-ms-office365-filtering-correlation-id: e9a1e0e1-6d93-4153-2fa5-08de33e277a9
x-ld-processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bHk0VkxCdk5pRlR5M1hsOGRGY3VmcXlWbjdObTl5eVl4WHR5Zk5Sa0RROEp6?=
 =?utf-8?B?VmtwUkVQMHF4d3BJOW55WWh1R0tmM3owek5OVXBia3BTZHUwQ3RRTEVvTVYx?=
 =?utf-8?B?SUtsQ3hLb3ZtRGNDRGQ2WjJHZHl1S0FBTUZCRXNpNDJiVk90emlzRTNpeEJa?=
 =?utf-8?B?c1Vuc2pkbnBvaGRjQjg5YnN3bWt6YW5VSmtjaFo4WWJHbS9Vakw2SmJLQzQx?=
 =?utf-8?B?V1d1Sk1iZnFCV1NxbFJjM0V1VE9ZdG1pV3JBeDJuaFRyeFpBUG9ERFBiT3lS?=
 =?utf-8?B?cDZWQlloQ1ZrbDZDZExEWThwbUk0RmtZMXFJaGlzVGp3Vkl5MDJDL1pWV3p5?=
 =?utf-8?B?WTBmZjNKYWpNTGdwM0ZubXBDVWM1ZWlDb1hPNk9TZ0hWMUNnb1drTXhDOFlC?=
 =?utf-8?B?TGd5WWRsbFZGakNveVlSR0crZWdpRyszdm8vSnd3MkRCbWhvbnJSMTRNWExT?=
 =?utf-8?B?bTVVQTFXamxTUkhvWG9jNGU0Unk5a0hMM21Bd1IyY0F5UCtnMExwQUhFL2Jz?=
 =?utf-8?B?cFFTMmY1MVYrMS9jN29mR3ZhdHNPUC8wVFV6SENZQ21VRkN1NzQxWStzSHZp?=
 =?utf-8?B?WWRHcmp3T08rRm0vMktzZGp4V1JWRnl4QjNPdzVJUnQxVWdHNVE1RnZETHRY?=
 =?utf-8?B?RktSNUVpSFJ6YnBXY1prcG9wVVREczBXalpaTE1NWjZpK01pSVNIYU0vM2ZT?=
 =?utf-8?B?eTZvUUw1dEpGV05aeldac3owT0RGOUQyV3B0MGpHWGsvUnVDdE5MVG9Ya3pD?=
 =?utf-8?B?M0k3dVVkeFJ0SW8xckVKZVVaZUE2T1J2azdqeU5PZjd6MHN5di9DajV6RlE1?=
 =?utf-8?B?YXdXRDI2RVM2NTFSWnBTSWxQWW16RFJGMGRndUlDa2Y0TXBETTVvWUhhcHFL?=
 =?utf-8?B?RWU2YitydlovTFdmbDRUdmIxRE1kM3JDNWVXbVJnUVo1MjFFUWFPTUhEVGU5?=
 =?utf-8?B?bXluSDFzZm1acG8yYXNaVkxtdGwyb1ZSaU5sOWE1cVM1WTZUdlBVRGNGajNx?=
 =?utf-8?B?dUxpeExlYnF1M1JacThnWXEwc3ZnWkpXamgwMTAvNXpiaHNhY1psbGJ6UlBK?=
 =?utf-8?B?SUFjQTJpcjlmWlZBdnFmdFowdk1ocGtVTlhJdVNzNlZ6S2dQTlg3LytMV0Rq?=
 =?utf-8?B?TkxzeFRZU0ltR3daRG5Jd3gzOEJ5WVR1aFVpaWsxUEhQd1hGdTltUmtHTCt5?=
 =?utf-8?B?WEhUay9TaEJuSHZxd2QvMDhubkJvNXVXTml6a1EyMEF4aVZmS0FZYjFiM3g3?=
 =?utf-8?B?YjhzV2JTaGEvbERUc1VBWjJuSStYeU1QRFRENFNlRjF4aHh6UDZNNGE5N0lB?=
 =?utf-8?B?WHN2VXZsZ2tPU0FBZG5zZmIzVXdMQjFNYUZpMjd6azNzemxvYk0wSXZkMWZ3?=
 =?utf-8?B?T3QvMmhCcXJVUXpRL3ZJb0F1MXNSN0ZhbHlCbzIvY3dMb1JZWnRJaU5HSnYx?=
 =?utf-8?B?WkdPYlpCNVpPcW5Kdm1TNDluNXROU1RWSHdBeDI0NmI3Q2xjaXY0MmlxTnB0?=
 =?utf-8?B?cGZPbk1FVXBvb214cXM1a2wzNFJQVm0rd0YrQW1uTXVHem5XNFF1WnpQc0ZL?=
 =?utf-8?B?NUFJdm93bnBrSzRtWlFUZXdYMzhJc1FjS2ZrNGllazdrZHJxNnM5OWd0SXBY?=
 =?utf-8?B?S1dURjE2Z1NEcmpGVlZEeHErU2NLenVEWDhnVmhCelJxVGM1dGFYWERHSlRp?=
 =?utf-8?B?TEt4akxqa2xsNVlCUnNyMkkvanNTRzVud1R5aG1CZDJZdXo4SGE3VlJqTE9a?=
 =?utf-8?B?cnQ5VDhmenM4QVVITi9Qc0Q5Y20xR0VnTG5aMy9MY3VtYllQek5lcFE2NHB6?=
 =?utf-8?B?S2dzMkk4RXBkaVJsVFNKbXljTGE5MlQ2ZWxtbG1HTWF5QmFhR3VYcWZwbzBG?=
 =?utf-8?B?cWlwS1kvSkNFZDViWHV4bUlnVVN6NjZLUmR0YmdDRXNRZXMxVElXbllkcm9x?=
 =?utf-8?B?NWVhQmY5YmFxWUdQdzdXQU81aTFmUWljK3Q1MmhkWk91WFRFSko0REh5YjBR?=
 =?utf-8?B?dVYwWDNRdDNHNXg4Q2NVZ21ZYnJhbWMxTXVNbjN5TWNXd1ZyaEswektzNW9Z?=
 =?utf-8?Q?2pxm2r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB2011.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU5RZU5BOU9QWHNTdExNazU4UHNENjhnZEZSNzh6TTFEYmV3NENvZnFGcHBq?=
 =?utf-8?B?OEJ4K2wrWjM5OElCWG5yZzZaeTIzRVd0d3ROaG1uK3lkN3lqSXpWekRTc0Rj?=
 =?utf-8?B?ZXIvOEhRbFhLbGsxb3d2dW1UME1vazg2WGFyNWVJdW1tWXM1TTl3bktjekdy?=
 =?utf-8?B?ZEZGYldsaXZ1elV3YVUwZUxsU1dSOXhPVkRyK3dseU5nR1JVMys3dFVuN1cw?=
 =?utf-8?B?bFNma3Y0N0t0WXVFVUZZeTdFUHBDcTJDQm5LQU90RU1mSzhLbFJQcllTNDBN?=
 =?utf-8?B?bmhaVy9aZk51QysyV0hxMmNqTjVPRHdFOEgzUkFYUFp0RysxL2VNbXB0b1Rh?=
 =?utf-8?B?UEF0UUtyWEwyVTBldWo5emlNNnlibWdyZlFxT3hMZ0N2ZHBUSFVRZEJMNGFz?=
 =?utf-8?B?cVdoTnRjRnQ3R0lBWWJzd29ZVjRFeGhITURZajVzUFp2dUZieDAreUVmY2RY?=
 =?utf-8?B?Q2o4bmFNQWF3b0tBbUpkV3ZsS0RuNWlheGFxSitGTlR4Vm9vSEtjWXE2ZXJ3?=
 =?utf-8?B?dUVucTdMcEpOa2UrN2xWcTczTlM5WUxTWkNRVTU3U3ExbVZ0QkZzTXJrbWFV?=
 =?utf-8?B?R3pXNHh3Y0MvN1F3YTBaR1M4cGxRZjZUZ2FtR1dzM0pWZ0JSbUc4VWdCV0pk?=
 =?utf-8?B?RlJXa0FGWndEeG55and4Sk4ybk9CeXh5SHducklEMWlrZGdVVjFsQ0hVdHls?=
 =?utf-8?B?R29Qdkd4eUlHQUdYbEtWUVZpb2xNbGtMVFo2Y20vKytpSFlrMEdsZVlhakVK?=
 =?utf-8?B?dU1yb1NNZU5WRGcxSzgvVk1zS0VZTkJOVVh0NW9nZmxUQUErQTlYMzVPY0RO?=
 =?utf-8?B?Q3ExSXg0aTUwQ3Jpdm05T0ZRaXJ0MlpmTEFnMXZ3Sjlib2hQUnZXVDJiYlpo?=
 =?utf-8?B?aDF3ZzcrdDVwSE11d08wSk1PUHVXTWdudkFmR1gxU0pJc0FXRGxENDhPa1Yy?=
 =?utf-8?B?amxrR3BDcGZEOTIyZkVUR3VXZEZjKzFueVFYd1QwUytSM0JieDlTcXM2UlNE?=
 =?utf-8?B?TDJhOXk0RTY1QWZmTkROQVdreXhNcmExODhWbWdOcGlZVkdyNzFpV1lLcEly?=
 =?utf-8?B?VW9ORU13dENuMVU0eithZXI5d1BLZjNCQUM0K1lXTUdhLzIzMUxPOExEL1VC?=
 =?utf-8?B?RGNoa0l6d2twMTE0ZVRBTm4yaGJIei9KSXR0U1dhRjdua0gwNTFqeUM0TnRp?=
 =?utf-8?B?R1h3ZEtsK3c5NmMwR3l6TXRFZWxPU1VEdnN1WjExaFNQbkNWRlQ0dUd0ZUF0?=
 =?utf-8?B?RStIM0p5SnhGU0NRZkJzTHM0MlFQSkoxWVMyd3RrcWxuRURFTEgvSUlBa1Nq?=
 =?utf-8?B?ekxZclh3eVlSdlFmbUJYbGNpbmlKRjlFZHo5bU5EZkFWZGgrSUVucGcvZ1c2?=
 =?utf-8?B?TVR0QkVTNFJmdVA4VkZvdnBhWmVsMVBlYVh3NE5xY01MaVVCajdNelU2VSth?=
 =?utf-8?B?RHFaZjl6TXQ1YklSajh3Q2grNU9UTkZUaW1jWkd4WUkrbzlTUnUrcys0SEFt?=
 =?utf-8?B?ODMwREx2alJrU3VSTjA2K3h5a09weHN4cFVaTEk5KzZpd2xNQUJjMHpoNlpG?=
 =?utf-8?B?dlFsUEpIWTR6ajVKd0EyWldrcHNXdThWMWEyRzFPWnBmQS9EdHZjWXN1SU95?=
 =?utf-8?B?NmxnbHQ4N0VFSTRJMHp1ZGlGNW1ldmc1ekZvcUMrS20zaTY3SDRwSFgzV2FM?=
 =?utf-8?B?Q0lyQW01MHVUTWF2WUJrODlvMDd0Zk1qNWxuTEZScDM5QU1IT3h3KzNuMEo5?=
 =?utf-8?B?akhMdVVlcEljNDFiREpXNnpBMDgyL1IrRlUzc0ZZbVpFSWptNk9paTV1K3lI?=
 =?utf-8?B?T3VwRzFJcDZJN0Z0OWJVWWZiS3JHYXcwdkZYaWwzWWlheE5mNUNHM0d6ZnV0?=
 =?utf-8?B?bDJaOE5odFUzYTY2bGpxTmRVU1ROUUx5alY1SkE2QVJXRExBNy91b2x6MnYx?=
 =?utf-8?B?aDM2OXJBZ1pRUmlrNU1ia2NWNCtQYzRHaUU4aFBDYmJaRGFqeThqUnY4WExW?=
 =?utf-8?B?SWhGVW5TeXhTY1hPLzF1Z2VpNGJMRHVySUF2QzI5RG9Daitad1VhZTZ6Snhy?=
 =?utf-8?B?V0RuSmpvemlFbWROTTRWcHUvVFNpelFsMnRzWTZBeUlLcHdwV2N1Rk94SElj?=
 =?utf-8?Q?MpU4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A858BA12DC2C24680893E2C0BDE73E1@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a1e0e1-6d93-4153-2fa5-08de33e277a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 09:41:29.6293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: auF/QahY62nFJ490i8wnB3y0L9mnGVvVUO39QS2VESEQibqA5eEY7ZfLdolTlNjTQ29Jyr3lQBFyDg3V3kbrog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2045
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

SGkgUHJpbW96LA0KT24gMDQuMTIuMjUgMDk6MDcsIFByaW1veiBGaXNlciB3cm90ZToNCj4gRW5h
YmxlIHN0YW5kYXJkIGJvb3QgZm9yIHRoZSBwaHlDT1JFLWkuTVg5MyBib2FyZCBhbmQgdXNlIGl0
IGFzIGEgbmV3DQo+IGRlZmF1bHQuIEFkZCByZXF1aXJlZCBzdGFuZGFyZCBib290IHZhcmlhYmxl
cyB0byB0aGUgZW52aXJvbm1lbnQsIHdoaWxlDQo+IHJlbW92aW5nIG9sZCBib290IHNjcmlwdHMg
YW5kIG5vdyB1bm5lY2Vzc2FyeSBlbnZpcm9ubWVudCB2YXJpYWJsZXMuDQo+IEFkanVzdCB2YXJp
YWJsZXMgYWNjb3JkaW5nIHRvIHRoZSByZXF1aXJlbWVudHMgb2YgUEhZVEVDIGFtcGxpcGh5LWJv
b3QNCj4gZGlzdHJvLWJvb3QuIExhc3QgYnV0IG5vdCBsZWFzdCwgb3JkZXIgZW52aXJvbm1lbnQg
dmFycyBieSBhbHBoYWJldCBhbmQNCj4gcnVuICdtYWtlIHNhdmVkZWZjb25maWcnIHRvIHJlc3lu
YyBkZWZjb25maWcuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFByaW1veiBGaXNlciA8cHJpbW96LmZp
c2VyQG5vcmlrLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9hcm0vZHRzL2lteDkzLXBoeWJvYXJkLXNl
Z2luLXUtYm9vdC5kdHNpIHwgMTYgKysrKysNCj4gICBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg5
My9waHljb3JlX2lteDkzLmVudiAgfCA2OSArKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgY29uZmln
cy9pbXg5My1waHljb3JlX2RlZmNvbmZpZyAgICAgICAgICAgICAgIHwgMTIgKysrLQ0KPiAgIDMg
ZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kg
Yi9hcmNoL2FybS9kdHMvaW14OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gaW5kZXgg
MGM4ZDBiYTk2OTNmLi42NDZiNjE3OTQ5ZDYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2R0cy9p
bXg5My1waHlib2FyZC1zZWdpbi11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvaW14
OTMtcGh5Ym9hcmQtc2VnaW4tdS1ib290LmR0c2kNCj4gQEAgLTMwLDYgKzMwLDIyIEBADQo+ICAg
CQlldGhlcm5ldDEgPSAmZXFvczsNCj4gICAJfTsNCj4gICANCj4gKwlib290c3RkIHsNCj4gKwkJ
Ym9vdHBoLXZlcmlmeTsNCj4gKwkJY29tcGF0aWJsZSA9ICJ1LWJvb3QsYm9vdC1zdGQiOw0KPiAr
DQo+ICsJCWZpbGVuYW1lLXByZWZpeGVzID0gIi8iLCAiL2Jvb3QvIjsNCj4gKwkJYm9vdGRldi1v
cmRlciA9ICJtbWMwIiwgIm1tYzEiLCAiZXRoZXJuZXQiOw0KPiArDQo+ICsJCXJhdWMgew0KPiAr
CQkJY29tcGF0aWJsZSA9ICJ1LWJvb3QsZGlzdHJvLXJhdWMiOw0KPiArCQl9Ow0KPiArDQo+ICsJ
CXNjcmlwdCB7DQo+ICsJCQljb21wYXRpYmxlID0gInUtYm9vdCxzY3JpcHQiOw0KPiArCQl9Ow0K
PiArCX07DQo+ICsNCj4gICAJZmlybXdhcmUgew0KPiAgIAkJb3B0ZWUgew0KPiAgIAkJCWNvbXBh
dGlibGUgPSAibGluYXJvLG9wdGVlLXR6IjsNCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9w
aHljb3JlX2lteDkzL3BoeWNvcmVfaW14OTMuZW52IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14
OTMvcGh5Y29yZV9pbXg5My5lbnYNCj4gaW5kZXggN2IwYTkwZTY0NDcyLi44YTIxNjFlNGFiZGYg
MTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL3BoeWNvcmVfaW14OTMu
ZW52DQo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL3BoeWNvcmVfaW14OTMuZW52
DQo+IEBAIC0xLDcwICsxLDEzIEBADQo+ICAgLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wKyBPUiBNSVQpICovDQo+ICAgDQo+IC0jaW5jbHVkZSA8ZW52L3BoeXRlYy9yYXVjLmVu
dj4NCj4gLSNpbmNsdWRlIDxlbnYvcGh5dGVjL292ZXJsYXlzLmVudj4NCj4gLQ0KPiAtYm9vdGNt
ZD0NCj4gLQltbWMgZGV2ICR7bW1jZGV2fTsNCj4gLQlpZiBtbWMgcmVzY2FuOyB0aGVuDQo+IC0J
CWlmIHRlc3QgJHtkb3JhdWNib290fSA9IDE7IHRoZW4NCj4gLQkJCXJ1biByYXVjaW5pdDsNCj4g
LQkJZmk7DQo+IC0JCWlmIHJ1biBsb2FkaW1hZ2U7IHRoZW4NCj4gLQkJCXJ1biBtbWNib290Ow0K
PiAtCQllbHNlDQo+IC0JCQlydW4gbmV0Ym9vdDsNCj4gLQkJZmk7DQo+IC0JZmk7DQo+IC1pbWFn
ZT1JbWFnZQ0KPiArYm9vdF9zY3JpcHRfZGhjcD1uZXRfYm9vdF9maXQuc2NyLnVpbWcNCj4gK2Jv
b3RjbWQ9Ym9vdGZsb3cgc2NhbiAtbGI7DQoNCklmIHlvdSBsZWF2ZSBDT05GSUdfVVNFX0JPT1RD
T01NQU5EIGFuZCBDT05GSUdfQk9PVFNURF9ERUZBVUxUUyANCmFjdGl2YXRlZCwgeW91IGNhbiBy
ZW1vdmUgdGggYm9vdGNtZCBlbnYgdmFyaWFibGUsIGFzIHN0YW5kYXJkYm9vdCB3aWxsIA0Kc2V0
IGl0IGZvciB5b3UgYXV0b21hdGljYWxseS4NCg0KQmVuamFtaW4NCg0KPiAgIGNvbnNvbGU9dHR5
TFAwDQo+ICAgZmR0X2FkZHJfcj0weDkwMDAwMDAwDQo+IC1mZHRvdmVybGF5X2FkZHJfcj0weDkw
MGMwMDAwDQo+IC1ib290ZW52X2FkZHJfcj0weDkwNTAwMDAwDQo+ICAgZmR0ZmlsZT1DT05GSUdf
REVGQVVMVF9GRFRfRklMRQ0KPiArZmR0b3ZlcmxheV9hZGRyX3I9MHg5MDBjMDAwMA0KPiAgIGlw
X2R5bj15ZXMNCj4gK2tlcm5lbF9hZGRyX3I9MHg4ODAwMDAwMA0KPiArbmZzcm9vdD0vc3J2L25m
cw0KPiAgIHByZXBhcmVfbWNvcmU9c2V0ZW52IG9wdGFyZ3MgIiR7b3B0YXJnc30gY2xrLWlteDkz
Lm1jb3JlX2Jvb3RlZCINCj4gLW1tY2Rldj1DT05GSUdfRU5WX01NQ19ERVZJQ0VfSU5ERVgNCj4g
LW1tY3BhcnQ9MQ0KPiAtbW1jcm9vdD0yDQo+IC1tbWNhdXRvZGV0ZWN0PXllcw0KPiAtbW1jYXJn
cz1zZXRlbnYgYm9vdGFyZ3MgY29uc29sZT0ke2NvbnNvbGV9LCR7YmF1ZHJhdGV9IGVhcmx5Y29u
DQo+IC0Jcm9vdD0vZGV2L21tY2JsayR7bW1jZGV2fXAke21tY3Jvb3R9ICR7cmF1Y2FyZ3N9IHJv
b3R3YWl0IHJ3ICR7b3B0YXJnc30NCj4gLWxvYWRpbWFnZT1mYXRsb2FkIG1tYyAke21tY2Rldn06
JHttbWNwYXJ0fSAke2xvYWRhZGRyfSAke2ltYWdlfQ0KPiAtbG9hZGZkdD1mYXRsb2FkIG1tYyAk
e21tY2Rldn06JHttbWNwYXJ0fSAke2ZkdF9hZGRyX3J9ICR7ZmR0ZmlsZX0NCj4gLW1tY2Jvb3Q9
DQo+IC0JZWNobyBCb290aW5nIGZyb20gbW1jIC4uLjsNCj4gLQlpZiB0ZXN0ICR7bm9fYm9vdGVu
dn0gPSAwOyB0aGVuDQo+IC0JCWlmIHJ1biBtbWNfbG9hZF9ib290ZW52OyB0aGVuDQo+IC0JCQll
bnYgaW1wb3J0IC10ICR7Ym9vdGVudl9hZGRyX3J9ICR7ZmlsZXNpemV9Ow0KPiAtCQlmaTsNCj4g
LQlmaTsNCj4gLQlydW4gbW1jYXJnczsNCj4gLQlpZiBydW4gbG9hZGZkdDsgdGhlbg0KPiAtCQly
dW4gbW1jX2FwcGx5X292ZXJsYXlzOw0KPiAtCQlib290aSAke2xvYWRhZGRyfSAtICR7ZmR0X2Fk
ZHJfcn07DQo+IC0JZWxzZQ0KPiAtCQllY2hvIFdBUk46IENhbm5vdCBsb2FkIHRoZSBEVDsNCj4g
LQlmaTsNCj4gLW5mc3Jvb3Q9L25mcw0KPiAtbmV0YXJncz1zZXRlbnYgYm9vdGFyZ3MgY29uc29s
ZT0ke2NvbnNvbGV9LCR7YmF1ZHJhdGV9IGVhcmx5Y29uDQo+IC0Jcm9vdD0vZGV2L25mcyBpcD1k
aGNwIG5mc3Jvb3Q9JHtzZXJ2ZXJpcH06JHtuZnNyb290fSx2Myx0Y3AgJHtvcHRhcmdzfQ0KPiAt
bmV0Ym9vdD0NCj4gLQllY2hvIEJvb3RpbmcgZnJvbSBuZXQgLi4uOw0KPiAtCXJ1biBuZXRhcmdz
Ow0KPiAtCWlmIHRlc3QgJHtpcF9keW59ID0geWVzOyB0aGVuDQo+IC0JCXNldGVudiBnZXRfY21k
IGRoY3A7DQo+IC0JZWxzZQ0KPiAtCQlzZXRlbnYgZ2V0X2NtZCB0ZnRwOw0KPiAtCWZpOw0KPiAt
CWlmIHRlc3QgJHtub19ib290ZW52fSA9IDA7IHRoZW4NCj4gLQkJaWYgcnVuIG5ldF9sb2FkX2Jv
b3RlbnY7IHRoZW4NCj4gLQkJCWVudiBpbXBvcnQgLXQgJHtib290ZW52X2FkZHJfcn0gJHtmaWxl
c2l6ZX07DQo+IC0JCWZpOw0KPiAtCWZpOw0KPiAtCSR7Z2V0X2NtZH0gJHtsb2FkYWRkcn0gJHtp
bWFnZX07DQo+IC0JaWYgJHtnZXRfY21kfSAke2ZkdF9hZGRyX3J9ICR7ZmR0ZmlsZX07IHRoZW4N
Cj4gLQkJcnVuIG5ldF9hcHBseV9vdmVybGF5czsNCj4gLQkJYm9vdGkgJHtsb2FkYWRkcn0gLSAk
e2ZkdF9hZGRyX3J9Ow0KPiAtCWVsc2UNCj4gLQkJZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0aGUg
RFQ7DQo+IC0JZmk7DQo+ICtzY3JpcHRhZGRyPTB4ODM1MDAwMDANCj4gZGlmZiAtLWdpdCBhL2Nv
bmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcgYi9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVm
Y29uZmlnDQo+IGluZGV4IDRjOTUyZTk2NmQxYS4uOWU4ZmY5YjZjYTkwIDEwMDY0NA0KPiAtLS0g
YS9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvaW14OTMt
cGh5Y29yZV9kZWZjb25maWcNCj4gQEAgLTUsMTAgKzUsMTAgQEAgQ09ORklHX1NZU19NQUxMT0Nf
TEVOPTB4MjAwMDAwMA0KPiAgIENPTkZJR19TWVNfTUFMTE9DX0ZfTEVOPTB4MjAwMDANCj4gICBD
T05GSUdfU1BMX0xJQkNPTU1PTl9TVVBQT1JUPXkNCj4gICBDT05GSUdfU1BMX0xJQkdFTkVSSUNf
U1VQUE9SVD15DQo+ICtDT05GSUdfRU5WX1NPVVJDRV9GSUxFPSJwaHljb3JlX2lteDkzIg0KPiAg
IENPTkZJR19OUl9EUkFNX0JBTktTPTINCj4gICBDT05GSUdfUEhZVEVDX1NPTV9ERVRFQ1RJT049
eQ0KPiAgIENPTkZJR19QSFlURUNfRUVQUk9NX0JVUz0yDQo+IC1DT05GSUdfRU5WX1NPVVJDRV9G
SUxFPSJwaHljb3JlX2lteDkzIg0KPiAgIENPTkZJR19FTlZfU0laRT0weDEwMDAwDQo+ICAgQ09O
RklHX0VOVl9PRkZTRVQ9MHg3MDAwMDANCj4gICBDT05GSUdfSU1YX0NPTkZJRz0iYXJjaC9hcm0v
bWFjaC1pbXgvaW14OS9pbXhpbWFnZS5jZmciDQo+IEBAIC0zMyw4ICszMywxMyBAQCBDT05GSUdf
U1lTX01FTVRFU1RfU1RBUlQ9MHg4MDAwMDAwMA0KPiAgIENPTkZJR19TWVNfTUVNVEVTVF9FTkQ9
MHg5MDAwMDAwMA0KPiAgIENPTkZJR19SRU1BS0VfRUxGPXkNCj4gICAjIENPTkZJR19BTkRST0lE
X0JPT1RfSU1BR0UgaXMgbm90IHNldA0KPiArQ09ORklHX0ZJVD15DQo+ICtDT05GSUdfRklUX1NJ
R05BVFVSRT15DQo+ICtDT05GSUdfQk9PVFNURF9GVUxMPXkNCj4gKyMgQ09ORklHX0JPT1RTVERf
REVGQVVMVFMgaXMgbm90IHNldA0KPiAgIENPTkZJR19ESVNUUk9fREVGQVVMVFM9eQ0KPiAgIENP
TkZJR19PRl9TWVNURU1fU0VUVVA9eQ0KPiArIyBDT05GSUdfVVNFX0JPT1RDT01NQU5EIGlzIG5v
dCBzZXQNCj4gICBDT05GSUdfREVGQVVMVF9GRFRfRklMRT0ib2Z0cmVlIg0KPiAgIENPTkZJR19T
WVNfQ0JTSVpFPTIwNDgNCj4gICBDT05GSUdfU1lTX1BCU0laRT0yMDc0DQo+IEBAIC01Miw2ICs1
Nyw5IEBAIENPTkZJR19TUExfSTJDPXkNCj4gICBDT05GSUdfU1BMX1BPV0VSPXkNCj4gICBDT05G
SUdfU1BMX1dBVENIRE9HPXkNCj4gICBDT05GSUdfU1lTX1BST01QVD0idS1ib290PT4gIg0KPiAr
IyBDT05GSUdfQ01EX0JPT1RERVYgaXMgbm90IHNldA0KPiArIyBDT05GSUdfQ01EX0JPT1RNRVRI
IGlzIG5vdCBzZXQNCj4gKyMgQ09ORklHX0NNRF9CT09UU1REIGlzIG5vdCBzZXQNCj4gICBDT05G
SUdfQ01EX0VSQVNFRU5WPXkNCj4gICBDT05GSUdfQ01EX05WRURJVF9FRkk9eQ0KPiAgIENPTkZJ
R19DUkMzMl9WRVJJRlk9eQ0KPiBAQCAtMTQ5LDUgKzE1Nyw3IEBAIENPTkZJR19VU0JfR0FER0VU
X1ZFTkRPUl9OVU09MHgxZmM5DQo+ICAgQ09ORklHX1VTQl9HQURHRVRfUFJPRFVDVF9OVU09MHgw
MTUyDQo+ICAgQ09ORklHX0NJX1VEQz15DQo+ICAgQ09ORklHX1VMUF9XQVRDSERPRz15DQo+ICsj
IENPTkZJR19SU0EgaXMgbm90IHNldA0KPiArIyBDT05GSUdfU1BMX1NIQTI1NiBpcyBub3Qgc2V0
DQo+ICAgQ09ORklHX0xaTz15DQo+ICAgQ09ORklHX0JaSVAyPXkNCg0KDQo=
