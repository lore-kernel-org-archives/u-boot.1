Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29026E7AD42
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 10:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E9984355;
	Thu, 25 Dec 2025 11:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UBMC3rrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2330184358; Thu, 25 Dec 2025 11:50:02 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051FC84337
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 11:50:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfO0a3OlZodiuPsXZt4SuBqH/QLulyETZeeJh8bRMrxtIm3I0AFOMr+1XLDFUpFohIPievzcNqQOYaXcaBnR+5VLqsdovpBLY9pCePZeuT1GhxsDo01BG6Vae7pO2wjnksJceg81w2II0hVfUrw5YMjF7u1eDJSdHylgqQcQdzIHyOVe1rZpVsgcO8rYHOagasGmXcIp+ICRX5ffIj6OhspFuV70CqKPFGD5kzcd10tRjw5ThNiWhi7CgGhvhR9kFDxdrTwwfaIs0095JM7rXiJwRskZjBNOweUTTtfzuLh3jqsjIblCqHC0KFeK4/GeZQP0oL+qaWvg0YXqeyY36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDQPgaPkeKuh7SsruM3vGpak+iy15a3vYTqXA6bwm04=;
 b=A6JuYSucz41uUeJSu0Ccj3bzSgVpZqPf0ShRdLcUw1OeOd7H2AFHAI8n6G+MgtEHlhjftdFbKcXTcrc5bKLEdaztJHCcm6GkAMa0ivnOk/CQJAJ/ICOkveOf8cCTHfIiDGpzKkWgTagf6sIOgTsk8baUOOSltZ2GCFw8zj1AxN6mtOFgxr6DjbkvdCFmagtNlDiR9utXUrZtzwtO82ShPAZ7ylsray3Si5tP3jX+8ogjYF4rmRH1mtC180Tq/9axdVRV4mNeWRNrK1DYQTVHkSPsvm7yNkkpSg01n4n4d9O0aXKyufXkhjrCyllVHt6ie/oruud+/7RwFlEFVlUjig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDQPgaPkeKuh7SsruM3vGpak+iy15a3vYTqXA6bwm04=;
 b=UBMC3rrvNpGwFNwjyX4nz5sd3ZFY8nk2dyiIObWpEI7vUjveN6NK7rb4PbdyAC/SYe1Vvg5IS6orL/mlkQV0UsPR8oY5/bZoeIoHryFj/A8uhLILJGDmZsRb2N7LQvN5w1IGmdI9hPiFAR2eona6ATu5WfAw5RY6yl+S4HjS/AKzoNzJrFv4escz1vOHK/ogCt6FWt3O3LTRDTfJImvSiJziOQc+QwJcRP9/z4fg71ZymogtwHlepgNqjIKjqyq/K5AGThsR91I3XSVj2IkFt/UxndOwFrNH7ZlPaLxYXz5xhM77UAnniUlQmXq3lwuGrAITyP4dXKoVNfpFvOFIbQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Thu, 25 Dec
 2025 10:49:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 10:49:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Ye Li
 <ye.li@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Lukasz
 Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, Kever Yang
 <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz
 <quentin.schulz@cherry.de>, George Chan <gchan9527@gmail.com>, Simon Glass
 <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMy83XSB1c2I6IGVoY2ktbXg2OiBFeHRyYWN0?=
 =?utf-8?Q?_PHY_initialization_into_reusable_function?=
Thread-Topic: [PATCH v1 3/7] usb: ehci-mx6: Extract PHY initialization into
 reusable function
Thread-Index: AQHcdYw2aDWO/QIRc060aioY1wEUZQ==
Date: Thu, 25 Dec 2025 10:49:57 +0000
Message-ID: <PAXPR04MB9644C3C179537EF23AE03DF4E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
 <3b1738d4-7163-4f2a-95ec-4f0c6e401948@mailbox.org>
In-Reply-To: <3b1738d4-7163-4f2a-95ec-4f0c6e401948@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM9PR04MB8538:EE_
x-ms-office365-filtering-correlation-id: 989e808c-23ff-45a6-8d34-08de43a358a7
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eGpxYXFkWGRrbXNURWxyZHJOcm9CelZzVm5wZ2tZVHNnZzJRc0s1MU1LODc5?=
 =?utf-8?B?T0JqOXhYZ2dHMEpEZnFKYzZKY0RXYm96TGVTQjRmQjlkbTAxcktuUFZIdUp1?=
 =?utf-8?B?UStMVWhxMDVLd0d2QUNkM3JnYU9VK3lHYjBZc2U4VG5oNmRoVTlGVjNzVFJN?=
 =?utf-8?B?V3lndkZUaVhqQmVuWENaVnBVR09Wbjl6ZlJGK1JzbjUrOGVhVEJObVoycU1l?=
 =?utf-8?B?dnJXSWplUVpiQzRkazJvSG5TdG94OEp5b2ppQklYSUliamQ4WmRRZ1QvWVBQ?=
 =?utf-8?B?QXYvTTh5VERQbGJpMXYyQnQ1bXhJZDBST1BJSmx0K3U4eXJpb1hvZkdmMWZX?=
 =?utf-8?B?MnZkUHh1dDlLaFUva0NYS3loUG5xMytSMEQ2K0kyYnZzcUlHKzF1OUozZ2RN?=
 =?utf-8?B?b3Q2aHRQT3k2MFg0UnJmMVE1c1BRa1QxamdpUWZlcmFNaDlrVStPeGI1SFBp?=
 =?utf-8?B?eXE2YzR1Rzl1K0g4cEsrMDc0Uk44V29EckhQaVBFcmd4VEhUQXVtbTFaanhQ?=
 =?utf-8?B?SXY3VFpLYWdMaUd3WDNqS2FSQkEzSGI4bmlUZzhJL2JhTFpNNjB5UzU3U0NN?=
 =?utf-8?B?YUF0TEZ3L2w0SkJ3WDhYd0l1Q0JRck0wYTZ4REJUYXNpbGJQQWlNVkhIam1B?=
 =?utf-8?B?ZXRBSWYvbm52ZmJJYVg1dGozc1BJVGNzMVZnNjg4Z0c0ZWtzSTVTelBsaUZK?=
 =?utf-8?B?OVc5dFFTVTUvNUxXUDk5bVVUV2Y1eGNiSDJlUHc3dE1qYnZOUXp5Z1VhS1py?=
 =?utf-8?B?RU9NbTJ2S3Frd0RFUERDaWxRR0Ewa1R4T211MGd2WGNzMG93amUwNGZqWWFB?=
 =?utf-8?B?TjBXMElnTERId3FXbzJ4Z2g3NjMvWFB0L1FBV0U1SFJmQ1BlZzhIZDAxWVp6?=
 =?utf-8?B?T2dkc1lUcDZyd2FEY0lFcG1Vd3dPbXNVVGZhWmg2MVg0NHYreFVyMGY1V0pF?=
 =?utf-8?B?OFR0Zlg0Z2d5djJ4MnozMkN4TmtocU5TMFQyVFhKN3laaXlJTUlkc0p1OXUx?=
 =?utf-8?B?amlUMEJ6NllGNDB0REtkOXNOK0NMQ3pSaUZNdDFJZTlrOVdNZHJtSXlibDRL?=
 =?utf-8?B?d2h2VkNJSlljUGVFR2VOQXJYWm9OdFh3ZTlnT0ppZ3o2ZGJzMXdDb1VoWVhD?=
 =?utf-8?B?VW16YzU1KzhwQkNSdklVQ2ZkYUt2SlpPV3YrZlN2anB0RU1LNG5sTTd1dGpo?=
 =?utf-8?B?Y0t2V2FqdGdPWUJjVSt4OUU2bG9lSGl0Ui9CaThIdHRkY3pIbTRtYWN4WVFa?=
 =?utf-8?B?cjJGdzl0bXk3dUs5TmMxNkVHbE4yZ1d4NGNSaTkybHAzeTRDREFNREhZK08w?=
 =?utf-8?B?ZE93MEVLemxvZmJibzBzeTZlbnEwU1A0aEFjc1M5U040U3FJeDc4MTNyN0xm?=
 =?utf-8?B?Y1NjVkxDbnBXclhIWDRJTEpCTmdQeGdDdFVuUVAzL1dvWEd5K1VVa1dtTmxa?=
 =?utf-8?B?Z054a2MxVmdzTVJZOGhUN2s0ZDlzMnphYnJZc0prZ2dXYVozK1FZcVZ5dVo2?=
 =?utf-8?B?SUIxQU1oKytXNXJXS2ZieW5oR2RENEEyUHJKclZROVdseE1VaHphcXcvdGpZ?=
 =?utf-8?B?azNETDd5UG9weERJM3h5Vmdtd3EvU01SZEEzeWdqOWMxQjlEcjAwUTM0WDNa?=
 =?utf-8?B?NmY4UmorTzNzbTAyOWVsMVA4dG1sMEo1U1c2bzFTdi90aEk5bis2YWtZczF6?=
 =?utf-8?B?TlZvVEZiM0xxazVHalBqa3hjTjJWZGtpVnpIb05KeVhaM1M5dCtldVRrUXpj?=
 =?utf-8?B?Njh6SSs4eG0wcjEvTmF5VVVJNFVGRmU2YlVrV3Noa0E5dnU1WjR3aXYxdHBu?=
 =?utf-8?B?U25sempJUEVab202RkJsbmVFTm9UNGo5VWE4MWxsVDBjcjE5MXBjTXV1RUNh?=
 =?utf-8?B?VjMrZ3dMUTd2eEo1QnBBWE9QM25UaVh1SkZjblFpZVNsbjFKMDFtVy9rZ3lB?=
 =?utf-8?B?UFJQT0tKWUgzbHpBTVIyQWNhcytQOUVQdXAxZnQ5cGVOZmk1a3IzSHRJZXJ4?=
 =?utf-8?B?S1phL2l1TVdrVFkwemg5amVOVm8vZ3cya0Y1QlRhK2d4TWtvZ01RdXhhVlRS?=
 =?utf-8?Q?6uZgE3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmRyaEUyc2dINGpicUxHR20ySGxaRjRUZ3NCL0lDOGN2eEtHOUxVTEVrK0kw?=
 =?utf-8?B?cVpUTlVPYXZKVjErSEVYeC84WGdHc3o0bjBtemNGelNZRVRkQzRsSDdSZ2dQ?=
 =?utf-8?B?WlJmSlBpQ3dRNCs5eW9qVUtUOVdvTTJlY0pTWEttTmROQlIrS0FuVEFnREEv?=
 =?utf-8?B?amZJTk85ZUV5OWliRllDeFBtRzhtdkJTd3BxVWQxdTVxczRHTCtDWng0ekpY?=
 =?utf-8?B?MURPVEZ2ZFd5MElBa3BWNzQxTG5Xa1hSRmhUOGh6QkNZdm8xcDNacDNhdUto?=
 =?utf-8?B?cUVEK09aK2xxUjJwaXVSTHFjQlk0eDMxbnU3SThlY3lYbmREbVlDbVV2ZGw3?=
 =?utf-8?B?WkM0RHBBeFFRL3hqR05lNEhDTW9PZ0p0a2EvcGRVS040V1JGOGdTbCtFOXNQ?=
 =?utf-8?B?K2JuS2NBRjUwME9kZjdmQmNSYk54cDJSTWVlbTAyNHB2VnR3MFVBa3Q2WGZJ?=
 =?utf-8?B?OEN1MkFzTXI4dGV0d0NBa0tEUi9JUlB6Z3Y1WkRkemZPbllRR2pPLytEbmpK?=
 =?utf-8?B?SUg2R3RGOExzZG8zZzVPMFdjQ3loYzRqcHNkbTNDbkJ1VC9VT1Fpb3ZLRnpn?=
 =?utf-8?B?TXdtZkFWM3F3elhRc0dQdFJSTTU4WnZoNWdRcVZTdEpJNWloS2J4R2FhZnBH?=
 =?utf-8?B?d2FCUlRGTkVJQlRNa3EzN0NsVWVYZ01kQlBXN2xiVDhUbnp1L1dRUWh4SWRk?=
 =?utf-8?B?dWNkSkhYVGlOa1VxK3lIM2I3Sm51cFZDaSsweHFVT0xYbTJ6ZEdkQzZRTkRL?=
 =?utf-8?B?aTlhYm9tNWNrZzFrSlgzN0RaZmFkdTBQV0I3b3Y3eG1UQldXa2x5ckRsSFd0?=
 =?utf-8?B?Sk5UYTJoK01kdmlBK2o0c1NiUHZwajFybEsyYkFISnpQYTA0aEpYT1hWbEJl?=
 =?utf-8?B?SEUvdEc3OVlRRmJhbTQ1bUUvL2Z1bVUrbk4yQUhXMC9XR2lzSkZ0K0c3NGVT?=
 =?utf-8?B?ZHNza1R6UTZwbHZnNjBQa2kxcmx1UTlzeFhxYjBFdnBQTXg0azBIOUdlU1BR?=
 =?utf-8?B?clVPMXFjZ2pGNWo3bXp3Zm5Jbm10eUV0Y3J3S1l5cVR3MWg1cEhqVTJRUHVO?=
 =?utf-8?B?eHhsUEhGYXFCTDlvSFp5MkcvbEp2bXNPbHl0SVhVeVUvSWsxbEVWYy9kSVRT?=
 =?utf-8?B?SysxdVBnM2x6Z0lnbWovOUdlQ1dtbXhTOEpsRVNYTEJScGtDaDdzbWtvQ2J2?=
 =?utf-8?B?cnBtUE5QVk1Db0h6VU16Q3B4bThtOUIwZ3kvZkE3RDd3TXdCRDFSYkw5WUx0?=
 =?utf-8?B?c044WGRmdjkzaWd6clMxNlRsbW56Rm1BZDZDRzU5ZUVLcUJ0YmRMVmxaZno2?=
 =?utf-8?B?YW54eXBIN3l0ZU1saFgvamZYZSt6YXl1aWh3YzNzLzRhTWtaT1NMcjNYd1Jq?=
 =?utf-8?B?WTNicStpQ1BDR0hTblFvdDA1N3lwY25UZ2x1cVcxVHJ6MmRwczV3Y0lpeXM0?=
 =?utf-8?B?akJKc294aVRSSkVtc20wOEhHMDBwZmkyTkNVVmRBNnBQc0p3bW1pSkxVQnNV?=
 =?utf-8?B?bkRPWHVRN2h0TS94SDJpeG1SaDdONS9rUmVMdHlOMDRWUjJIUFE4R29SZzFM?=
 =?utf-8?B?eWh5M3F3RHpNZXhqVCtzM3NjVGJua2FwRGRnbWpmWW1Gc2V4UGhSTmtYTlZR?=
 =?utf-8?B?SjlaUk9ES2J3VW0rRVpoek1NRjUzMHV0UXliaHIzMVFiYnpZUCtPY20zWkZT?=
 =?utf-8?B?aENFaENZNlo2KzBTbng2Vi9vbEE4VEdING41TzROcndRTVdHdXRkdmhPWTNL?=
 =?utf-8?B?NkRNUTAyd0tXNk50WHZlaHRCNWhzRWxxL3BZNUFrUHNtOTZ0bGlrL3VJN1Jt?=
 =?utf-8?B?NjZPZFBaQTVlZEJmRDJNWkh4ZWMwQUQvYWhpTU1VWC8vQmh6S25hd2MwMlJN?=
 =?utf-8?B?bE1yYllFTFZ1ejVNMGxmbHp2L21lcjc3Z2NDenhHNkgrQWtPSUlKY2RQRFVQ?=
 =?utf-8?B?ZTh5RmFpb2d1REZkSkNNWTFHbmJNLyt6Y0JwVW9JSHZFR2RaVHExUGpGQmNE?=
 =?utf-8?B?djhjT3RENG9hNEU0VEdyb3Y5clhoYXp0ZEg2VXRtUmNVQ0wrejBNS2huZzY4?=
 =?utf-8?B?YVh5OFhhWE56WDdCREowSFRqTUd5YlV4aVUvMTgvY3pDQTFVYkJrcFZXNzRo?=
 =?utf-8?B?Ty85c242bVhwaTI4RnhCNGZ0MlRwdmRvUytjajZpOXF3cHptRnFRSnIxUXdZ?=
 =?utf-8?B?bW85VGRlZmxxWG5hOEIwRzRDZmNML05OdVF6MGh6azZEa29paDlpQVlsTms1?=
 =?utf-8?B?TVRQa3JJYXd3TWwrZjl4aUtEdm1jMjdQdm1EOUdpSC9zNTdtaStHc3dVQ1dE?=
 =?utf-8?Q?m5YU+8FZsvYlvGhzHT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989e808c-23ff-45a6-8d34-08de43a358a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 10:49:57.8891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEr/OSDJa8W+sjyAXwD8pRfKe7cFacciJqcTMf3h6ZNFuK/1rjnCTeu7fFGhrLaZxNZ9lIhIR5bznTvvzlLx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMuaciDE25pelIDE5
OjE4DQo+IOaUtuS7tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+
OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxpc3RzLmRlbngu
ZGUNCj4g5oqE6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFibGFkZXYuY29tPjsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtv
LmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJleEBkZW54LmRlPjsgTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0QG1haWxib3gub3JnPjsgWWUgTGkNCj4gPHllLmxpQG54cC5jb20+OyB0aGFydmV5QGdh
dGV3b3Jrcy5jb207IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsNCj4gTWF0dGlqcyBLb3Jw
ZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBMdWthc3ogTWFqZXdza2kNCj4gPGx1
a21hQGRlbnguZGU+OyBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+OyBLZXZlciBZYW5n
DQo+IDxrZXZlci55YW5nQHJvY2stY2hpcHMuY29tPjsgSm9uYXMgS2FybG1hbiA8am9uYXNAa3dp
Ym9vLnNlPjsgUXVlbnRpbg0KPiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZT47IEdl
b3JnZSBDaGFuIDxnY2hhbjk1MjdAZ21haWwuY29tPjsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJv
bWl1bS5vcmc+OyBEYXZpZCBaYW5nIDxkYXZpZHphbmdjc0BnbWFpbC5jb20+OyBBbGljZQ0KPiBH
dW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjEgMy83XSB1c2I6
IGVoY2ktbXg2OiBFeHRyYWN0IFBIWSBpbml0aWFsaXphdGlvbiBpbnRvIHJldXNhYmxlDQo+IGZ1
bmN0aW9uDQo+IA0KPiBPbiAxMi8xNi8yNSA3OjM4IEFNLCBhbGljZS5ndW9Ab3NzLm54cC5jb20g
d3JvdGU6DQo+ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPg0KPiA+
IEV4dHJhY3QgVVNCIFBIWSBpbml0aWFsaXphdGlvbiBjb2RlIGZyb20gZWhjaS1teDYuYyBpbnRv
IGEgbmV3DQo+ID4gZnVuY3Rpb24NCj4gPiBlaGNpX214Nl9waHlfaW5pdCgpIHRoYXQgY2FuIGJl
IHNoYXJlZCB3aXRoIHRoZSBDaGlwSWRlYSBVREMgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvdXNiL2hvc3QvZWhjaS1teDYuYyB8IDczDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiA+ICAgaW5jbHVkZS91c2IvY2lfdWRjLmggICAgICAgIHwg
IDkgKysrKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2
LmMgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktbXg2LmMNCj4gPiBpbmRleCAwM2ZmNGNlMTBkNS4u
NTJmMTRlNmVjYTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9laGNpLW14Ni5j
DQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLW14Ni5jDQo+ID4gQEAgLTEyLDYgKzEy
LDcgQEANCj4gPiAgICNpbmNsdWRlIDxhc20vZ2xvYmFsX2RhdGEuaD4NCj4gPiAgICNpbmNsdWRl
IDxsaW51eC9jb21waWxlci5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ID4g
KyNpbmNsdWRlIDx1c2IvY2lfdWRjLmg+DQo+ID4gICAjaW5jbHVkZSA8dXNiL2VoY2ktY2kuaD4N
Cj4gPiAgICNpbmNsdWRlIDxhc20vaW8uaD4NCj4gPiAgICNpbmNsdWRlIDxhc20vYXJjaC9pbXgt
cmVncy5oPg0KPiA+IEBAIC0xNjgsNiArMTY5LDU0IEBAIHN0YXRpYyB2b2lkIF9fbWF5YmVfdW51
c2VkDQo+ID4gICB1c2JfcG93ZXJfY29uZmlnX214N3VscCh2b2lkICp1c2JwaHkpIHsgfQ0KPiA+
ICAgI2VuZGlmDQo+ID4NCj4gPiArI2lmIGRlZmluZWQoQ09ORklHX0lNWDgpDQo+IA0KPiBDYW4g
d2UgYXZvaWQgbW9yZSBpZmRlZmZlcnkgPw0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2suIEkg
d2lsbCByZW1vdmUgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzLA0KQWxp
Y2UgR3VvDQoNCg==
