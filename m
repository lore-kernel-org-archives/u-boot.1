Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73A8C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CF388AFF;
	Fri, 16 Aug 2024 14:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="rcTMQT8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE0A88B3C; Fri, 16 Aug 2024 14:28:34 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF12889F8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUanJmEzDJIcCpimgSzHanDoRAwTeVUKbueCsaYaPthG5DBA7wO39Y044gYzD6bEWzCV2rtsQZJjgUjoCRb4Lxa3CT8vihcXVqHI28XhXYkTD6sL+xKRvbweVnbmeSN48g90kBpFWr2GX56eggFvdMxLATRIdpCTw0OORkrCoBuLWVNCqvSUNhQfvYIQL0EYfSWETfqFr/5EOym2itg0jdf1fYaPjdm+Fht+Kgy2lxdkxxwaq/u6CLSClsRzasjZTj6h52VTAl3VhoykfcyK+oY2bXE4gg9qXOBRn2jG0hCTd6kQXIy1CKl8UA8ePpEwzqAWXMQpekxvptMkBN/wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rX/Pq6QH7Uc+FKqSxkm+W4qF1WMpJU24VTy41WR82c=;
 b=Hi5qbVbBLJXc+dip5l6KqaSCjgSllHVXi5kJlk8ha2bcFzjRTNPJ2tk3y8xqWwR6k5ajooZv1qDh/h9mHQQWCBKB/Y4QKFgi4m+tRcaYDI6TgKxzOR2dG/XH5zNavxBHrRqgOktBPpU5Bk/cONSFFogeDIBOAqVGLovzPYO4CTGDCMVklsnO+c5uCypkkPpi0h3FHcvmDnuRUTQJtGmrv6iqytgLvptpFSdjefI5PpstJ2dfgzu886hg7/xf+VRKA9gMyQgXF1GpHP+ycgiyXQb4hA8p8xTmEwjnTgQtbaiAZCIq3z3ted+MLrl9bebRDyt0yz8yIWps/4OOTo+6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rX/Pq6QH7Uc+FKqSxkm+W4qF1WMpJU24VTy41WR82c=;
 b=rcTMQT8+JYjpzrpgs6thhUHOQ418ANkA4mvB3K+UmKPczNFGTiKwtXzv02Mc8qlM5K3JxRQRVHYtxxTH0NIK8g5UsQN9HvW22BW4rG9yB0YsNl7A6DOjv3xsGx6AEP/Hc+WQRcOTsPMw5RjFYAHGyMiGkqLA7fLl4k4K3FjrWqby3GDMze76BoOIuXQtKXZrbVXLxu6dO1GR06jrRuGnj02KRA+it3y9cKBhLMXfpxsJlIXg5OmwzstFirrHeIyjKeQePheQibkcOah0SThTKsx8x3GMx+7bwEgi+VDaNDfM4BFYRtMuoAd37a+JAw4n9xrbt/i8jvfIDDDcI9IllQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB7630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Fri, 16 Aug
 2024 12:28:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:28:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "joao.goncalves@toradex.com"
 <joao.goncalves@toradex.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 02/10] firmware: ti_sci: Add No-OP for "RX_FL_CFG"
Thread-Topic: [PATCH v3 02/10] firmware: ti_sci: Add No-OP for "RX_FL_CFG"
Thread-Index: AQHazpbvUkV78R/kDUec8oFaj2q+BLIqEmcA
Date: Fri, 16 Aug 2024 12:28:28 +0000
Message-ID: <164f60214205aec69269df3029c88e5e7b3f5873.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-3-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-3-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB7630:EE_
x-ms-office365-filtering-correlation-id: 2d1e139e-f11e-43dd-c190-08dcbdeeeef7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Zmt5NGl5RWsyeUxBM2FSWXVVbWgzcUZ2NVlvQVJlOXBmOHdibENDaTBqeGx1?=
 =?utf-8?B?ZDQwKzdVN2pvdnRhKzdpV25ROEgwQ2RGV3VuTEV0cWZQNUFhYklDTmM2SE1m?=
 =?utf-8?B?bHBjNGlPa05vNnF1ckhxZENRU25GYS8zeU9SQmJZNXBiOWNmTmNvTzRpZnU3?=
 =?utf-8?B?R1VwUHlmUXBteFBrNytlS0ZKVVh1TkRRS1dPdVdtOVcvMFpBZVJFR2F4ZXJ1?=
 =?utf-8?B?bWFwcDVZY29rSWM1TVc5N0VDZk5CUktkam9CL29lWlA0OHo4cnV0SGRoQUF3?=
 =?utf-8?B?TmZDYlVObEl2QlFWRk9kYWdidm80WHdMWStJSm1YTzZWU2pUZkNSc3NadDY2?=
 =?utf-8?B?VndNeTNrNWJremxINVFabjRhR203Vm94WU9ZdU9Tc3k5VmVDcjFva2xCMnUx?=
 =?utf-8?B?bE9EUXdUdkRXT0c2Zm1RVTViNi9peU1nTnJSb2J6ZnAxVmhwTzBYWitFcTB1?=
 =?utf-8?B?UW14a2N3aDY4Zmx0TlQxWE1KSStYWTFpQjErb3U5cHZEeWRRSWJvRUdmMmtv?=
 =?utf-8?B?bS9mbXVwMEU5UWRMS25MUjFUQjJNZGpEbks3ajU1SEVtRG5oRG5kdTVOekVk?=
 =?utf-8?B?VzNuRkRIUDNHaGc0cXZ3bk0rUU5OUVI0R09qekY1UU40cFdSV0dGbEQ0MXZE?=
 =?utf-8?B?TWREajdPYTlNSjdMc0I4NlVvWEZ3U09qN0Q5T0pLRUc4NWZONVhNclRpWDU1?=
 =?utf-8?B?V1FPTTRmN01BTmVWemExNmlBOFI0T1dhVnR1RzVBQzExcTRGbk1lNUdrVWhB?=
 =?utf-8?B?dElKNWdwMUlMWXY0MEZGRjN3TE9KVG82S1gvaFFtRnZLcUZQS0VPSjhBOFZs?=
 =?utf-8?B?R1ZjcCtZNmZxUGUzQ1pVU2Q1UExYcmVwKy9wNEdMalR4bVE2TUw4eENnRUtu?=
 =?utf-8?B?WTRsZDRaVXJVcUx6WVI4UjJOc2lCRk1uMk1yQTRyaTBpVEQ0S1pxSzg5Zmkx?=
 =?utf-8?B?Vkg0ek1sYVg3WTNMT0gwOEUrTmhvUFJhRDIzS0F3SjRqQkdpRlA3ZGkwd1lW?=
 =?utf-8?B?YUNSY2hEWVNua0pXejVyTTlBMWtDUUF2U0tkOG9ZazZwSGkrSy9DQitRY2Vk?=
 =?utf-8?B?djVuaWV6RUZvUnRUSDNqVWtnNlBFOVp0S0hvZVRDZkNFeG10UmZhVEtmUW1T?=
 =?utf-8?B?RzFhV3dHbHhYbGtXNlEwQ0FKNVkzNTlnNkIxb3hjSFVwQStHM3dXWCs4Rm9R?=
 =?utf-8?B?UE5zaHpMU0dCQWUyQTlMbG8zemdBMUFSVmUrL3ZiQU5wYUhjaVhDcWtJdjQr?=
 =?utf-8?B?TXF1NldrTjFoelA4amN3Rmg1MzhmcDNBb09Xa0VLdFhBVktSdkxWaFQxbTlw?=
 =?utf-8?B?L09oYkMySytmQzBaUjU4T09CUWVFaDZyMWRYb1VWTTFxclVQd3YwYm9wb1BN?=
 =?utf-8?B?WjdhYmRNSTlJNDg1anBQaFV4M016Rmw4dXZLNFhlaFN3ckpPQ1lIYU1TQlVF?=
 =?utf-8?B?VGUrNUlSOUZXeEdPc0dYV09UT215bnVNVkhKN0Y4aWp2N2R0dXRCNDdFV2xz?=
 =?utf-8?B?Q3QvSGQwTFFxR3h0UjI4MUgxMGFSeTFaSnBSL05pdXJDZjlrb1UrUS81YXdB?=
 =?utf-8?B?ZFBhTGF0UDRaN1FBQXl0d3pWczB0VlFOV2Nzd1BRRkNXbmwyVmdqU01NeTds?=
 =?utf-8?B?dEQ4Rms1SmlUYzhMSG1yY0xlRTZJQ1YyQ0MvVFNYTHBIY0ZlUGNhVERtNElH?=
 =?utf-8?B?VE1rR09zT2JjVVYxbHlTMCtLREpzc2JqYWUyQ3VnNzNGYmNLdTZlc3VnbXZ3?=
 =?utf-8?B?a1hBZk1Ccmx2VEVBZktwdFlBZksreWZGSkJ2b0VwZXQwUnpjM0RLeDkwc0w0?=
 =?utf-8?B?S1h2cWdZc3hHUXhISHVkMVBSdTVmeGRKQVFHdnVuU0JBOFVMNlhMOXFkVFR6?=
 =?utf-8?Q?+3olddzZxYKiQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azdjQm4wS01aWDhTMzJnd3RiUU12Q1kyZkNOZjRSMUxmMEszTmtSYWNZU2wx?=
 =?utf-8?B?TWZtZk9KQ0Iyd2p2bjVvYjBBTS9kWmIveXhFUnFPSWFGQWxocHZJekhmN2J2?=
 =?utf-8?B?MnVlcG5OQVZQNEJURWgraDNkMUNuT2RSYkwrdEphK2lBNmJjUGlnK2ZGc3JH?=
 =?utf-8?B?bUdaN3ZGeEVtYXVTSGR2SXUyZzVCaWN6WGx3RkgvU1Zad3VEVUpvODRvN050?=
 =?utf-8?B?S2d2TWl5RDU1UDVtVDg5Wk1tY2VJOXphVWVHRWk5eXkvYjZYTlNHVXZyRzIy?=
 =?utf-8?B?cFlCSno0VmtSTFJrV29FMEJ5emlXWXI4WmhxUUx3MHNKVDFhMDh5Vk9rMUgz?=
 =?utf-8?B?MnltUEttS2s4Q0ZUb3NYaEFhbVNHbXowN1lRTTMzODRsbGxvNzJPR2c0NktB?=
 =?utf-8?B?YS83VUxHbVdCTXdtZnpvYXJ1TWNjUWkvbzFjNG5TeHJiZVd2L2NhQy9BUXVE?=
 =?utf-8?B?NDRVdktOT0NPUTFGQTZsclplZklCUHZJNkVHY2hqVzZiTUFDQU40Vndta043?=
 =?utf-8?B?bXZnMWd2OG9jNHd0RjhhL3NNNmREZHBmZm1QWFIzYmMzMG00TTlhNFRHcnpO?=
 =?utf-8?B?b3JiMDhUbTV6bkJnRERZYzBWWDI3aWJhZlRQSytjWUJYc216MloyZ2JRcTFj?=
 =?utf-8?B?VDZURzhDSDJKdGZVNkQyaXQ2eS9mVnU2M2hHTkM2c29iTUN2SWNmTlpZNGlH?=
 =?utf-8?B?dm1LYmFuVSs4NmJUeEtoeTd4c3JiVUtPdGlYdmJaNW9ZcVhXMHphYXJVYXFn?=
 =?utf-8?B?aWU0Z29lRFhwSlcyRDZoL1M3S2ZkQ01kTGNyQ1FFWlgvalBCUWg4cEVmeVhl?=
 =?utf-8?B?aGtJK0NZU1ZKdGFTSVNWUC9lcVRVRENOdW5qODlYWnVKZVB6NzNFRWRJQUxX?=
 =?utf-8?B?bGJSR2JCNnpubEhQSkluRmwxd2xwUVpaQ3B6NGI2TDZ3WlU3WTlqSmx2V0tr?=
 =?utf-8?B?aitRUnIvTUNBUHB1M2lVUVcxWStRN09yR2Q0SGkzZS9YdVhiSmhTR1VqdlRr?=
 =?utf-8?B?N3BJVGNZRjBqdjZFVDZsc2FYUFpNWnRXOE5adXFuRGFBWVVtSGdsaDRFWkZk?=
 =?utf-8?B?K0VqdzlpUjh5ZWQ2b3lLd0pjNU5tbkVkaElxeE0zR2tLY0JzY1d4bVQzeWl6?=
 =?utf-8?B?cHJOM215S1lXSW84UEg1dGdWNitiZjIvMjllWDRyekQxNld5RXJvTGYrZVcz?=
 =?utf-8?B?MHZwZEkwMEdLR1FtZHp5QTZrOXZIbkZhcENmWFcvdTZBQnBBSEdWZTdld09Z?=
 =?utf-8?B?eXc1UHI4Tm9rYVptOEtNc1Q4dmxNdkpiUUNEbnpCRjJ2eU1MSlBhMHVGVnRa?=
 =?utf-8?B?cUpFK1ZBYW41VHlTL2QrTVllbzcxNktiSHVGZUw3ai85SnJBOHpacWphUmRv?=
 =?utf-8?B?MEZlcjljRzJaY25vVFpiUDdacHVoU2hTSUxBUTVrT2VUN1lPNjgrUWdlWGJa?=
 =?utf-8?B?dDZSQ0xVRzMyRWhTc01MZU1Uc0U1Mjgwc0JwVGZGc053dzJsUUg5MkNsSXpB?=
 =?utf-8?B?R2JKS0Jkc01xa1dUbDYvYWFQOXdrOGVnUlNjL3YvVkFzSFFmZ1UyVUc5V3Rl?=
 =?utf-8?B?S1lSc29NSjIwS1Juc3dXWm5zL01aZjM4OXo2ek14MnM1VUgrZEhqQVQvWUVs?=
 =?utf-8?B?cVE5N1J6UUsxc1NNTms3NGZYZmZxRGovYUptS1RnUmRQY1FaZGY4VjV1OWdE?=
 =?utf-8?B?MTJuWVhLRk10NjVFeTcwL2JOdzZtaTdsa00rV1B6elRVM0QwVW1kVWF6MDF6?=
 =?utf-8?B?U3ltYXZaWVU4QncxWGtiTFMwTVRaclByZ0l0QU1EVlVTdGxzNTd1dmdXdGd5?=
 =?utf-8?B?SnJPMVo3SmsrZzZ5N0JXT0VYclIxV2xrWDN6KzFkcWFDUFdzUFh1NGo0cDd5?=
 =?utf-8?B?enhac3ZlUktHcUtIdVF3MlRYdFF2clR2a0xMTEdvSDAxRTlGMXN1amRNQjFn?=
 =?utf-8?B?RHF5OUxTSUZxclMwYU0yYTV6b256VVhJR0ZQa1hwc0RGZkZ6WGFQN2VMNkRJ?=
 =?utf-8?B?MlZFZnBjd2lsb3JwKzV0L21MTFpqQmdtN1daa3NlWEtycEdjRzZ1cUljK2Nz?=
 =?utf-8?B?SEpHb1BpaGR1MUFQbjc4blVoYVhlNXliNnVLd0padjhVdzJOWXJ3WU5aVjdL?=
 =?utf-8?B?YzhiWStUVW1ZaFhxOUJ4YWZTR3FqYlMwK2JDTlk5S21jYWpBL3Ivdk13eXFB?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1397014845784D40BA54F578FED0313B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1e139e-f11e-43dd-c190-08dcbdeeeef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:28:28.8719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBBchgoE4pBxWOOcyi2nCVAOXiHc/zbNjFtRfpm+N9ENzTrnCheCmFy2liq3Mo18cyE61CL4owY96MeQwCKuWlJH6uCQqHONH1V3keySPnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7630
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

T24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gDQo+IFJY
X0ZMX0NGRyBtZXNzYWdlIHNob3VsZCBub3QgYmUgZm9yd2FyZGVkIHRvIFRJRlMgYW5kIHNob3Vs
ZCBiZQ0KPiBoYW5kbGVkIHdpdGhpbiBSNSBTUEwgKHdoZW4gRE0gc2VydmljZXMgYXJlIG5vdCBh
dmFpbGFibGUpLiBBZGQNCj4gYSBuby1vcCBmdW5jdGlvbiB0byBub3QgaGFuZGxlIFJYX0ZMX0NG
RyBtZXNzYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkg
PGtpc2hvbkB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMt
dmFkYXBhbGxpQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpbnRhbiBWYW5rYXIgPGMtdmFu
a2FyQHRpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVy
LnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gTGluayB0byB2MjoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDQyNTEyMDgyMi4yMDQ4MDEyLTMtYy12YW5rYXJA
dGkuY29tLw0KPiANCj4gQ2hhbmdlcyBmcm9tIHYyIHRvIHYzOg0KPiAtIE5vIGNoYW5nZXMuDQo+
IA0KPiDCoGRyaXZlcnMvZmlybXdhcmUvdGlfc2NpLmMgfCA4ICsrKysrKystDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZmlybXdhcmUvdGlfc2NpLmMgYi9kcml2ZXJzL2Zpcm13YXJlL3RpX3NjaS5j
DQo+IGluZGV4IDhjZTBmNDZlNzAuLjM0NjY1NmMwMjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
ZmlybXdhcmUvdGlfc2NpLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS90aV9zY2kuYw0KPiBA
QCAtMjQ1MSw2ICsyNDUxLDEyIEBAIGZhaWw6DQo+IMKgCXJldHVybiByZXQ7DQo+IMKgfQ0KPiDC
oA0KPiArc3RhdGljIGludCB0aV9zY2lfY21kX3JtX3VkbWFwX3J4X2Zsb3dfY2ZnX25vb3AoY29u
c3Qgc3RydWN0IHRpX3NjaV9oYW5kbGUgKmhhbmRsZSwNCj4gKwkJCQkJCWNvbnN0IHN0cnVjdCB0
aV9zY2lfbXNnX3JtX3VkbWFwX2Zsb3dfY2ZnICpwYXJhbXMpDQo+ICt7DQo+ICsJcmV0dXJuIDA7
DQo+ICt9DQo+ICsNCj4gwqAvKioNCj4gwqAgKiB0aV9zY2lfY21kX3NldF9md2xfcmVnaW9uKCkg
LSBSZXF1ZXN0IGZvciBjb25maWd1cmluZyBhIGZpcmV3YWxsIHJlZ2lvbg0KPiDCoCAqIEBoYW5k
bGU6wqDCoMKgIHBvaW50ZXIgdG8gVEkgU0NJIGhhbmRsZQ0KPiBAQCAtMjg5Niw3ICsyOTAyLDcg
QEAgc3RhdGljIF9fbWF5YmVfdW51c2VkIGludCB0aV9zY2lfZG1fcHJvYmUoc3RydWN0IHVkZXZp
Y2UgKmRldikNCj4gwqAJdWRtYXBfb3BzID0gJm9wcy0+cm1fdWRtYXBfb3BzOw0KPiDCoAl1ZG1h
cF9vcHMtPnR4X2NoX2NmZyA9IHRpX3NjaV9jbWRfcm1fdWRtYXBfdHhfY2hfY2ZnOw0KPiDCoAl1
ZG1hcF9vcHMtPnJ4X2NoX2NmZyA9IHRpX3NjaV9jbWRfcm1fdWRtYXBfcnhfY2hfY2ZnOw0KPiAt
CXVkbWFwX29wcy0+cnhfZmxvd19jZmcgPSB0aV9zY2lfY21kX3JtX3VkbWFwX3J4X2Zsb3dfY2Zn
Ow0KPiArCXVkbWFwX29wcy0+cnhfZmxvd19jZmcgPSB0aV9zY2lfY21kX3JtX3VkbWFwX3J4X2Zs
b3dfY2ZnX25vb3A7DQo+IMKgDQo+IMKgCXJldHVybiByZXQ7DQo+IMKgfQ0KDQotLSANCkFsZXhh
bmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
