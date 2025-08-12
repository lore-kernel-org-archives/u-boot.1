Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BC3C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 08:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11B9F8311B;
	Tue, 12 Aug 2025 10:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="U0XqrhUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3D38312A; Tue, 12 Aug 2025 10:41:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0EC83118
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7yfLo332ngBW5ZubCNWG35e4IgMUVD1ka2ds2jwKsxmKNzasX17hD/oPGR5WO8yMxwDp93uFDybVu20yx9wTPVm8wBWpQC1LDdZ1/JK+jgZ6cSva6hsadRADQjoDN0AivdfzZZKM/ROx9MTXbqJJ7l/Ixe+D3At16CjR8JQkPx5ht8mRCESvfG51WS6zv7CuUwDm78YBm8mRW7ASxZawzhWqTcpGBKNdQJHON21xzPy/ioqaiYcPWUB2jAZKhXJbV/lu3iLGxFuBX28Bo1OeTClA2K83BOAkVWhh2Ez91T81IcGTjLVM6A8wlODLfYd0RrWQcZiC1YShWGKAkMKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW7Qn0cGdhDTfSqp6XDVhju7sjgjbGCG7ymOuYkNLDY=;
 b=Y7W7W3nkOe/TYQEOkjIRG3phiQPJHM2n7R3SyODKlBm9c6nJ0uSialkkigEtf/DUq3Zkm5VSX/ux2y+Ny3nAIFmopbjpvuzeiGIkS75d8F01xZTJrDRmzRIBb1iwIYCTSSH5qofpN0d3mQ0hmAiU8+F9IHIUwNgNWDsoc2azVCE1c2H7NXT+juaS6ykXaXJ2YmzfAc6f1ZtDXLLStdYpv4zLPTikvwXtAVWFseLhGsbBK7NIjARujD8Itb0aKfuGVMCNIa0fIlM0NEUAnRPUBtsMDRUc5qoLjStelu9MMriJHwzGev3xZU18R+oPPckP2dIJuRDsjNTkSK6KbI41BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW7Qn0cGdhDTfSqp6XDVhju7sjgjbGCG7ymOuYkNLDY=;
 b=U0XqrhUj2IbjFS9uc2ISdqM0mrWhzDbskNXBVAt8MhsJO1CUSct0KOCvxPZd+g92rI9F/UMrYNOYnVc7clWag8k8gl1En2vU6jxpwXjkD43hNjC3AbtXnEVUh5WZPd0fkfwoA9UUo39aUNFXoWhYeoA8Tg/6DI9X7ENbcmFD2ARogsyq51ABi2rCjyOdGP+1gdq3vPu6cdne6Ijnm2A+Au/kN4JE53HyKGHbLkvbi270QqOqOdsBZooktMx+ndbx45TXVpWJrZa8bxBRncUvm1Cj8mw520xANb/uydm7NH5VSYPZWIfPDziyXn1P/YutTImHr1Uy0IlpET/MiNGM5g==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS4P195MB1816.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:51f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 08:40:58 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 08:40:58 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Aristo Chen <jj251510319013@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, "al.kochet@gmail.com"
 <al.kochet@gmail.com>, "paul.henrys_ext@softathome.com"
 <paul.henrys_ext@softathome.com>, "bb@ti.com" <bb@ti.com>, Wadim Egorov
 <W.Egorov@phytec.de>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "afd@ti.com" <afd@ti.com>, Daniel
 Schultz <D.Schultz@phytec.de>, "d-gole@ti.com" <d-gole@ti.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>, "carlos.lopezr4096@gmail.com"
 <carlos.lopezr4096@gmail.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions in
 FIT configurations
Thread-Topic: [PATCH v1 4/5] tools: mkimage: detect overlapping load regions
 in FIT configurations
Thread-Index: AQHcAIeAhTbWTG0M9UOIbWqqIoJXA7RMH5oAgA2EUYCABSSqgA==
Date: Tue, 12 Aug 2025 08:40:58 +0000
Message-ID: <ea3c0c59cb2d0e17e016607ce80c6080c44afbe1.camel@phytec.de>
References: <20250729125022.4220-1-aristo.chen@canonical.com>
 <20250729125022.4220-5-aristo.chen@canonical.com>
 <cec9682a3821dc6d0c95ad0fbe91106e2fde4923.camel@phytec.de>
 <CAJwFiGJSgys8ZTo+A8iOx0W5m790tmpK9vg2ELm7GV5z582EfA@mail.gmail.com>
In-Reply-To: <CAJwFiGJSgys8ZTo+A8iOx0W5m790tmpK9vg2ELm7GV5z582EfA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS4P195MB1816:EE_
x-ms-office365-filtering-correlation-id: c49025c1-4731-4808-a278-08ddd97bf5b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dFhDaWZ6bmRGTW5hN3Vwd282bm9vZi9rNTFiVUFPNTN0MUtnT01sNm9RRytD?=
 =?utf-8?B?R21QblEwNkxUa1U1QXFLRjRoU1M2WTgraWxrS2Q2UHovblR4emI5L01GL3Q0?=
 =?utf-8?B?Wks5VEdvK2laUEthakoxTlBmcTVwdWdHUVdJaFM0eXJ5blUwTlh3QXplMExo?=
 =?utf-8?B?U2JqV2lvUEVyMTNpeld4U1dLNENielI4QzRrQW9NU1BmZ0Y5bEQ5dVZnRnJR?=
 =?utf-8?B?YlVuWldUQ2MyN1NRRjhDVXJWdmNWVGVXV2RCQlFjd0M2M2lZMVgxTzVJejdj?=
 =?utf-8?B?Q0JWS0srbHB6enVlaGlVM3JSdzZnN0UrKzh4a3RiUnlOa2FwbXdHaHV5OXZs?=
 =?utf-8?B?U3lvcFJMd01NOGxmcVBUbFZpNUZjN3Y4R3FUTEdXZWxJYWNnblYybWxhQUgx?=
 =?utf-8?B?QU8rRVppTUxvOW0xU3ZqMSswZVk5RWtnSCs1eUxzVGpGcXhlOEdLdUFpRFhz?=
 =?utf-8?B?OGwxK09ud3ZhWkRLdzFtNklZa3hUK0tDcXdGSGNrQnpYRUdwS25vc0pVTHov?=
 =?utf-8?B?cTlKUGtCSVo1eEx6c1BERC9nNUQ5OGZURE9lUzh2SnpCcm5mRjNFRFdVOERL?=
 =?utf-8?B?LzFKY1ROcCtld3pxbWJtdktYTDEzR3d6ZDVqNDl3Z2lKRTUyQm1ack0vUmlG?=
 =?utf-8?B?NlF4QkNrZi81dDEyTEZSdVl5aGo2ZGMwVlJPWE1vajZXQVY3SWY5VzFnMHFJ?=
 =?utf-8?B?dUpOQzdoanZ5cjFVeWxKYUdDZDZWWUh4ZGdWeDVSQ01ZQ3g1WEYrbkRnWWhE?=
 =?utf-8?B?dnQyVHF2cEljd3dDMTR1YjBOVWk3SlR4ZC9wdkhJYm1BeDZmcHdQcjUwdnpa?=
 =?utf-8?B?djVBbkt0c3h2cCtGbnhEb3N4MFI4Vlc1RVpTTnBjckk1UlFTU1BWZ3JhL2xO?=
 =?utf-8?B?WWhHRm1LclpEdW1XbGkxcExYbHUwTGhYWTNCYkJjSkJoZ2dFL3JLZXh1U2NK?=
 =?utf-8?B?RnNHVTRhcHZCZ3NVUFJlUi9ldlk5eFViR0hDUnRwRHJ2TExzSW40VnNLcnBu?=
 =?utf-8?B?MHoybE1hOFE5dlRsYWg4Uk5iU1dpMHFzLzhVOVljckNaVDJIVDZaUElPeWxD?=
 =?utf-8?B?WXJUdFhhSzVCalh4S0RRR1lPSU9Xdnd6VDZYbkE3Z2cxay90VVBrbi9Kb3lG?=
 =?utf-8?B?WVRrTXA5bE1UVnErZGtJMGJGOWJPZGJyaVhYUWtLV29rZ0hhTzFBZ2ZtZlVj?=
 =?utf-8?B?Mjc3RDRsNmllOXRZTVJYTVhSejk1ZEhCZlVvMzF0cjQ1dHRPeFR6S0lQczRF?=
 =?utf-8?B?dEZudlZEc0RtY29tTWYyTmxNQXFVVWlpYWFES25KNWs5NGFTUnJtNkJ2a3lX?=
 =?utf-8?B?d0t2b0Z0M2Nqd3lkc0F1djdhZTNWdXJQWFFzb2NIYnUvcXpoc05MMTA5d0Nj?=
 =?utf-8?B?YjRoTlRIekpyTEJ1b3FmSWt3WTErK0hiRnVRUmZXNUtJTVFZRG1kOTg5azVr?=
 =?utf-8?B?NlJZNHhxRThIZ2o2NkV6Q3RZZXlnNEJERWcxZXhsMnpydkN0OGQ0a0FUZU1m?=
 =?utf-8?B?dXR0cEk4cU5UdTBLdlkzUGFhRHpBbXF0WFhGYmxXcHJkdFdJOVFqNEJmVThy?=
 =?utf-8?B?bUZtNjdwNXBnQkplZ24rSGQramFYYWVMWkV0TTZTMkx1bkpSSzJ6TUd2d1Y5?=
 =?utf-8?B?TVJJNmZ2QWF3OXl3R2ZEbGJKYUR3ajhBK1RPakx6WGN2VVlTTkVaTEsrc01U?=
 =?utf-8?B?NjFmbk9zd3Ira25zamZiMFFzOCtKV2UxUmt4bHpJVjJ1K3VVRTZaN3hSZ1Yw?=
 =?utf-8?B?emVrTGhGK2tkNlhjSlo1NEtVSS9EUHVLWEtlVERFbTFIZXlGNmdkZFA4azlS?=
 =?utf-8?B?aG1KZ1JZNlZ2TlJiVlY4NWtDc08yQWpjdmpEVWtyb25LV01qWm5ldEVHT1Uy?=
 =?utf-8?B?dnREMHpnSzZwRUZoMFNxLzk5bW1kUDNaTUVOYVB0UUpUb21wN2phSXZ1dmFW?=
 =?utf-8?B?L2JJajQ5N1BveVBRa0hXV0tkMm9lWlMyOWZrVHozZ2s5TnVreWc0ZU5qZkdS?=
 =?utf-8?B?eUFuUDVSOWNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBRbHBubS9PRXpJMkVnVEV0NHZXb1BqMU1laXBIK1BFTitXVFh5T1E3M0kx?=
 =?utf-8?B?UU9hQy85anVDZWdlTjRRMkxVZjB6OEU4ckovdFJXdnk1YjY2Z0dDMzBUR3lQ?=
 =?utf-8?B?dTRBTDRwcmZ0Q1JvRDRGdWk3VmJFS0ErNXRlR0VzTkptZS9lSVltS013eHh6?=
 =?utf-8?B?dlZkc1E4TVYrSCs5OUVKdVduNW9uUUFiRWxpaTlKVHZwLzQyb2RsK3BHOFRp?=
 =?utf-8?B?SUt2RmxQS015R2NhMzY4cTVhSTB0aWtRY1VQSmhiVk0vWlR3ZjliczhRbVA3?=
 =?utf-8?B?RGRJd0V3ajhpTVdmNU1Md25BdjBaZlI4U0s4MUFyOVExbHc4K3BVS1FHT2JI?=
 =?utf-8?B?bXBBU1lueG5NVURyOXlUelQ4TjVyeDJ5bDRPc0dKYjdiaWN3RXBvZ0FkT1B0?=
 =?utf-8?B?SUgzOTdwUGJhZ0h3Q0tZbDNQSmNyQnNMbWp6Z212Ty9Fa1BsM1VJWVpjeFlY?=
 =?utf-8?B?UTNCVUFqcm5Gd215YzNNd24vc0daaHBTdXdpU0dhUktLbDdrNVJJWmU1UWt3?=
 =?utf-8?B?Y2p5TUd1M3VvclIrKzlNaU55bkpmM2NoZTZnOXc3ZGN0aENPU0lMM2k0S3o3?=
 =?utf-8?B?a0NHZGIwWkRROFozUUhhajh5MXdaR2ZHb1pTMjNMZ0QreUh3MEdtUjF6MVZh?=
 =?utf-8?B?ZjlrVEVwRXZ6cWhsYzd2bm9OQ2xLY1ZmT2t2NkFDTXlVdWFOWnRBdk9DV1JW?=
 =?utf-8?B?Z3Z5ZmpRWnFxaDVCdms5SlBYTnQ4MzRDcXkwcFFvYS9PS3p0RmxJWnE0ZEM1?=
 =?utf-8?B?clg0YU55cVF0NER1L1ErTmhtQWgyQzBCcUZURGVQWnc0K2U1MDZmT2lnZi9Q?=
 =?utf-8?B?NXRPRVdlbk5nTytaZzYyTVYrMzNwVUptK204UFpVbUp1VDFlMUFtSDMxSGhs?=
 =?utf-8?B?NGFIRXI1VnF3MTRKaFZ5ZTdWV1luSzVUUGtWTlRnaDJZUWVCdWU2NWc5Wk9V?=
 =?utf-8?B?bWhva0xtT1hvL2tQTGJLQkc1bEJwUzM3eUkzd1diVDR3ZHhId2ZncEl2WEtP?=
 =?utf-8?B?amMxdHVKK2g1Vkp0R0YyVjlSYVhWbUNWUS9rM3Fqb3ZYa3dEbWhuWVhZZkNq?=
 =?utf-8?B?V2FkbFFUQXpCK21qeHU1eVRCRkxvRGovVEJjd3VtWVZoZWQvYkMraFBGSVlF?=
 =?utf-8?B?anVLVWt4NGtBNUMxVUtrcEhMNE05NnBjWEROS3pBZ2xEVEdISkx4TVpjbWtz?=
 =?utf-8?B?cXBrRmFKb0NMZmdVRGUrdjBkUkV5cXRZeW9kNlNYeEZNNGJkcUhvZlk0MUVC?=
 =?utf-8?B?bkM5b0JULzJhYW9SamtSaTRZcjhaM3hjb3oxK0FEVnRCa3FTdDlKRkRLMFh1?=
 =?utf-8?B?RDZKK0ZZdGtiaWxobEVPM0FQdUMrN3RVNC9qNEwyS2w4WWhhQk95RlorYUtG?=
 =?utf-8?B?eTgzRTJPR0FISldkRmdTdjNCMHJhVDlWcktVclNzd2l2M2VETDMrYkRlSHEv?=
 =?utf-8?B?akZTdFJ6Ym00NmFSNENySjFmWUNMQ3ZLejBEQzZBamEydERmZ2M3UmQwTGVx?=
 =?utf-8?B?L0NNY2k3THNJM2IzOGpGMFB5dldPclFmSXdQQ3VueDBEZFVBdXcvK1hkdUFs?=
 =?utf-8?B?YVlzek9XM3dUUWs3Y2owOHo5cXB2eTZYaEFMZEF4RjRyY0huV25ndENzb05q?=
 =?utf-8?B?S2lmODM2VkhHdEZUb1RLbUxNRXVXNU9KOHRSOUNxTEV2UlpVMjdMNkJ2YndQ?=
 =?utf-8?B?djY3bmFhSFVXY0IvRnFEV05vMk9aMjl6MU5Oci9VWWFvVFdBengxampMOXVK?=
 =?utf-8?B?SUpWOGhJNzcyZnlrWGVReG1NSU4xRDFQVkhNd3Nod1J0di83dDA0ZTY3bTEv?=
 =?utf-8?B?T3lrdTF0ZGw0RTZkSm53VzFQRFlmcHdEYUFJYkRXVmFhSkFPVENpcUFpSFY0?=
 =?utf-8?B?UzVqbzZ3b200MHlMNDI4aHVwclROR1R3ZmNpMEE2eW5qcnVsYlNRU2ZVYThI?=
 =?utf-8?B?NXFPWkxJSE1rQTlBa3V2U21rQ1lCWlhEczg4S0RiSWdoeEdvUUx3TFNGRmdZ?=
 =?utf-8?B?dElzTGxuN2sxM3RiTElKNE5WeWI0QkVYL2t3Si9hdUpVR0h3akJWRWw1aTFt?=
 =?utf-8?B?Y2NoMjRjdHdvRytUUE5Ubmp5ZGFQZDJVV2RtM0dtNGpqL3haaWFYL1Y4VHV0?=
 =?utf-8?Q?eq9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38E8095D7124494CAD7F05F104FA7790@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c49025c1-4731-4808-a278-08ddd97bf5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 08:40:58.2759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3XjA7hEzkvRQ2rYshtppnGRzUAsWdNlLW+9zopgCaUJ1P7rMty13NRhRGORfIwKzK03rHqaRllRwCFHMyHArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1816
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

QW0gU2Ftc3RhZywgZGVtIDA5LjA4LjIwMjUgdW0gMTA6MDggKzA4MDAgc2NocmllYiBBcmlzdG8g
Q2hlbjoKPiBZYW5uaWMgTW9vZyA8WS5Nb29nQHBoeXRlYy5kZT4g5pa8IDIwMjXlubQ35pyIMzHm
l6Ug6YCx5ZubIOS4i+WNiDc6NDPlr6vpgZPvvJoKPiA+IAo+ID4gQW0gRGllbnN0YWcsIGRlbSAy
OS4wNy4yMDI1IHVtIDEyOjQ4ICswMDAwIHNjaHJpZWIgQXJpc3RvIENoZW46Cj4gPiA+IFRoaXMg
cGF0Y2ggYWRkcyBhIHZhbGlkYXRpb24gc3RlcCBpbiBta2ltYWdlIHRvIGRldGVjdCBtZW1vcnkg
cmVnaW9uCj4gPiA+IG92ZXJsYXBzIGJldHdlZW4gaW1hZ2VzIHNwZWNpZmllZCBpbiB0aGUgc2Ft
ZSBjb25maWd1cmF0aW9uIG9mIGEKPiA+ID4gRklUIGltYWdlLiBJZiBhbnkgb3ZlcmxhcHMgYXJl
IGZvdW5kLCB0aGUgdG9vbCBwcmludHMgYW4gZXJyb3IgYW5kCj4gPiA+IGFib3J0cyB0aGUgYnVp
bGQuCj4gPiA+IAo+ID4gPiBUaGlzIGhlbHBzIHByZXZlbnQgcnVudGltZSBtZW1vcnkgY29ycnVw
dGlvbiBjYXVzZWQgYnkgY29uZmxpY3RpbmcKPiA+ID4gbG9hZCBhZGRyZXNzZXMgYmV0d2VlbiBp
bWFnZXMuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBcmlzdG8gQ2hlbiA8YXJpc3RvLmNo
ZW5AY2Fub25pY2FsLmNvbT4KPiA+ID4gLS0tCj4gPiA+IMKgdG9vbHMvZml0X2ltYWdlLmMgfCA3
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gPiDC
oHRvb2xzL21raW1hZ2UuY8KgwqAgfMKgIDMgKy0KPiA+ID4gwqAyIGZpbGVzIGNoYW5nZWQsIDgw
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS90
b29scy9maXRfaW1hZ2UuYyBiL3Rvb2xzL2ZpdF9pbWFnZS5jCj4gPiA+IGluZGV4IDMzMWJlNWFl
NzFkLi5kMDA2MWFkZjA1MSAxMDA2NDQKPiA+ID4gLS0tIGEvdG9vbHMvZml0X2ltYWdlLmMKPiA+
ID4gKysrIGIvdG9vbHMvZml0X2ltYWdlLmMKPiA+ID4gQEAgLTIyLDYgKzIyLDIyIEBACj4gPiA+
IMKgI2luY2x1ZGUgPHZlcnNpb24uaD4KPiA+ID4gwqAjaW5jbHVkZSA8dS1ib290L2NyYy5oPgo+
ID4gPiAKPiA+ID4gKyNkZWZpbmUgTUFYX0lNQUdFU19QRVJfQ09ORklHIDE2Cj4gPiAKPiA+IEhv
dyBkaWQgeW91IGdldCB0aGlzIG51bWJlcj8KPiA+IAo+ID4gSWYgdGhpcyBpcyBhcmJpdHJhcnks
IGFkZCB0byB0aGUgZXJyb3IgbWVzc2FnZSBiZWxvdyB0aGF0IGlmIHNvbWVvbmUgbmVlZHMKPiA+
IG1vcmUKPiA+IGltYWdlcywgdGhleSBjYW4gaW5jcmVhc2UgdGhlIHNpemUuCj4gWWVzLCBpdCBp
cyBhbiBhcmJpdHJhcnkgbnVtYmVyLCBJIGFtIHBsYW5uaW5nIHRvIGR5bmFtaWNhbGx5IGFsbG9j
YXRlCj4gdGhlIG1lbW9yeSB0byBzb2x2ZSB0aGlzIGNvbmNlcm4uIE90aGVyd2lzZSwKPiB3ZSBt
YXkgbmVlZCB0byBhZGQgYSBuZXcgdmFyaWFibGUgdG8gYWxsb3cgdGhlIHVzZXIgdG8gbW9kaWZ5
IHRoZQo+IHZhbHVlIG9mIHRoZSB2YXJpYWJsZT8KPiAKCkR5bmFtaWMgYWxsb2NhdGlvbiBzb3Vu
ZHMgZmluZSwgdGhlbi4K
