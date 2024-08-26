Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0803C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BA088155;
	Mon, 26 Aug 2024 12:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="cRHAA/yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64EF1881A5; Mon, 26 Aug 2024 12:51:19 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D468811A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrdUsdtSuSAWUyABnjnpU+2CmuKH1++R+Zxyqs6SXOr3AGkspZqsCd4AJOR6b8g1VpzYexKOfyMamv4MvRQ3ZMU7MlJVL85Vfr7mb8YB4teVOcnQJ7eKkBmchgQljVnRzCYQhQXzpmlhz9rhSRaGZhwTtOEPrg14kQjru40ec0O0EG2is9DTekHC+PusXcfNulDxL1Rkeq5RYc3JCZpD6lpObhlg8ciKdhZ2BPW+kW/KnKTuJXEYHdrRto1RPxZZcpZBAsHtxjkbQX8DlBqbDqygUeXx9FScTUY/INOpmETUKupU1whXz/KHKGEzlTEIUEsdeRr0bg32eplrODqIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+xSYNYOKF3kR18hyo7dGWtddXKI/SEaNUn42fQYESc=;
 b=ilGNwNejH8S+UhLHRSAYIUR5SuJYWKR93Fd3bH+bbDuLEu0VviG/rxE83f6SXY3bZpgCxkFhjDOLlsJP/j7EKu2D3UKq1Cr1UAjbAvkWQtgANLeReKJwGNJdfvopHqfBrErXVkIBqk1/Crm+bxP3T9yG7Vs2x9wR+P05jHBeuY5lg0A2bXlITrnb1f+KRqXs4z7SjdCoYwymK4BdQT7PzvGbJSO25KHwfB2WemzM0dFlBTwMRvqbHJVA30j21xSeZ6ayWa6alIlVg6yPDwzH5GoIbN3VCBKIFLObKVBKtsR8hEWG4mJOXJ46ZCsmBI6ZMRzyeDqnnRFowQaZEab8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+xSYNYOKF3kR18hyo7dGWtddXKI/SEaNUn42fQYESc=;
 b=cRHAA/yomvaa+KtpkBtg3xKhxDwabg348gC0t7EzId1wMtwI/OH/tBmTRGFO7HSe7MUVlCN1lNkphIZIMFHeHPMHHCELmpPlvpK77lN1OlxMYvzYL+/a6v69i0jGoCZtjaSK1UUNW0RWNBS44Q9hSsly02aeIPwobkbhOXXqpwRS8epYohqfZK3UCvJ+Haj+LOyvMjl+vx4kFGPAvPH39IbAxZ52mSR/51rzZtDuXdkbc7LZCVecHSonBKUJeMuHiAUmP0a4zwtU5gavn2gtsDic0HNcz/2TwFO6Gur/lWNcslOnu/BHdEK1ON5MGvuVyf8GjDu6CEizWtesXjRlpQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAXPR10MB7928.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 10:51:15 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 10:51:15 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "francesco.dolcini@toradex.com"
 <francesco.dolcini@toradex.com>, "nm@ti.com" <nm@ti.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com" <afd@ti.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "michal.simek@amd.com" <michal.simek@amd.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "d-gole@ti.com"
 <d-gole@ti.com>, "danishanwar@ti.com" <danishanwar@ti.com>, "devarsht@ti.com"
 <devarsht@ti.com>, "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "kishon@ti.com" <kishon@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "matthias.schiffer@ew.tq-group.com"
 <matthias.schiffer@ew.tq-group.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 04/11] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Topic: [PATCH v6 04/11] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Index: AQHa96JVfGvF+05r9EmcrUPsllJsr7I5XHgA
Date: Mon, 26 Aug 2024 10:51:15 +0000
Message-ID: <1e8e078a1def1e9d6cf60f29bcabb95d459325ef.camel@siemens.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
 <20240826102515.2774296-5-c-vankar@ti.com>
In-Reply-To: <20240826102515.2774296-5-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAXPR10MB7928:EE_
x-ms-office365-filtering-correlation-id: d72b1282-6382-49af-0005-08dcc5bd01e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eG5DYlo5Q3MzSWlNMGR6djhrTlJGMXE5SjUzSTdXcjc2Y3ZPenkxa0FMMm01?=
 =?utf-8?B?cWFGN082cDJGaEtpUjI4dzlrOGQ5c250bGdWU3I0M0lEaXhuM0tQeW4rQ0d0?=
 =?utf-8?B?WXRJeUtFbTJuL3RoKzFnSC80OVowc0NYQ1J3VE4zVE16VWprN0w1K0swZ1kv?=
 =?utf-8?B?UUdUS205TWZ2MzNLbmh5V01VS0hpVk1jVThSWHBrVmtaZ2JYelo0czU1R1hG?=
 =?utf-8?B?bkpMTm1jYnpEbzRGc0RUNFdBR3MveUhUR2tuYzVhZWc4TnY1bmh3VkNyS3RY?=
 =?utf-8?B?UUdzakFyeTFvWE04OFpqcUJXb2dzemNtT3h6WENzZU9kcm9nT1VIYSsvYml3?=
 =?utf-8?B?RVd1NzFQVi9GcTJYZEZla0NvRmJ0TFEvMmJleUQ4T3RqeTJHekF0MTNXOXlQ?=
 =?utf-8?B?dWlpNGp1VnVDMFdTQWI5SnBMelpocXB1QXYrbnY4TWlZVGxmUk1oS3ZYSWxx?=
 =?utf-8?B?TDZrVG5HWmJHdFBaK2dscHYrOUt0ckg0c0xrM1hsN0xMeHdOcUV1K2VSeEVt?=
 =?utf-8?B?QlArRm5vMUN0eENMLzM3N0xIRi9DUVJsNUZRSjAwNlpmbzJ3b2ZlSVlOZ1Bt?=
 =?utf-8?B?S0pWdmVXdWYwK09wV1VEeWc0YUxNbzlKM21BdFVJNWZBVllKQmppNmN6Z0Yy?=
 =?utf-8?B?ckw5UTRROUtLWlpscUY2VFBDeS9iTmx1cWltWVdiRUxkRVQvRVBZLzZlYnlB?=
 =?utf-8?B?KytQK0FEbmhNNnU4YkZhMkZoMkpiRFZKSktQZ25zMm12QkZhbVRhN3M2ci9P?=
 =?utf-8?B?eHBXMTRDVkFuZFdCMkd3NVdKcWNjck5vdGczc3piY0JWMXFrbzYxaU1jdTRz?=
 =?utf-8?B?eUVwZW1XUHZGVFQvY014S1FTbHh3bTZVaTgxSzhudW9LMW4rVHZxRGdyck1n?=
 =?utf-8?B?bmVTYkw3WWxTaW5mMmIrV2NMcmhZaHhNZkRYVmh1VWZQaGpxU2JnM08rMUxK?=
 =?utf-8?B?TFc3STl0NHhsbVppaUFnOG14VmtiYW5LU0l2c0s3K0RzV21yTGJZSUpvMjNM?=
 =?utf-8?B?SVZ0dHpQV002eS9MMElveDBjdUEwOEVWOFZBUlY4Z0ZIT0NPWlI5SmFob1hH?=
 =?utf-8?B?eStxZEdBc25SZW1OQXZKVWpZaW5sS0p6dHN0VW9raWc3b2dMc0pYbEt6Vjlk?=
 =?utf-8?B?UUUxZXNtM3dFQ3phTXJ3MFVpYVRNTVlmYVBnQ1BsdE9ZR1Z2S3JVZHliZ21W?=
 =?utf-8?B?T1VWcVVnRC9xaC8yejBFQm1BL3BYVnJKSTR3aXdWejgxQkV3N2Uya1FmSDhy?=
 =?utf-8?B?dHVIZVNaQXRjWFJZL3lBSGNkWTFibVMxN2hsZXFKc09SZTA5MEpRQXpCdURV?=
 =?utf-8?B?aFVBaU9KUm5uRzR1RHRYWXpmdGFPaU11WXlmY3JjTHVsZFUvT0tDb2lKWEU1?=
 =?utf-8?B?QmVxUVBIYmpPdGlhenJuZmFoRitoaWRRWk5DTzEza2lsSW9GVWpMM1BxcFpB?=
 =?utf-8?B?N1dxT01UY1duRGNaVkEwMmpMV2Zic051TExaN0xKNmFaaVNsTzF1N3ZzUjRj?=
 =?utf-8?B?QWFVQ0hKZ3BKQm85THZEV3JiNGRwQWtHOW5kczVpTHpaeGxSdk01T2U5MnlF?=
 =?utf-8?B?ZVRFclEvVW4rTUY3MGYyQ3JRTGdyd1dlT2FGOUhrVS93OEdmMThib05xQ0xY?=
 =?utf-8?B?cDJWa2Eyekc2cWlTa3pTWmpNWmp0RVYrQ2tNWXJnWWZJaVhhT09hVWhoUzhQ?=
 =?utf-8?B?YnVnL2oyM3JHSGtJTlBRaHA3UEhqY0hpajk2K3FTaHppaE12Tll5MUoyaHFm?=
 =?utf-8?B?ZUo0VnR5UU9jZU13ZUlvRklxMzNSTEw0SXZWYmZvbEVMb2ZDT3FndW9ibSts?=
 =?utf-8?B?YXRHUVh2M1BEOHBzK1A3Mmw3VkdQdWdmWm93dFI0aHFWMTdsd2ZxRDVoRHdV?=
 =?utf-8?Q?imvy98BTgWbAq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Q3V3puYTFJUVJtamQ4bWplbUdCNXNkajM0aHg5VFROMDBiMEtwZjA5Zzc0?=
 =?utf-8?B?RVlGRXRpWUxnSCtiYlJjckJwQ3ppZmtBTFBpRkVPeUlreHVMcXQ2anFjZXlm?=
 =?utf-8?B?MVF2NXdnUFZZVFRENFFmUkxlSGRjZkNNby9NVDZyOTN1c1dTTE5ranZjUDJp?=
 =?utf-8?B?MjIwWDAwSE80VEZJcS9vazdhRHF5U2JUTTRtaGIrRTNQSTFmUFZOelJibXEx?=
 =?utf-8?B?NlZ6M2pOYlBiaWFWa2c5SEUvN3p0YVIxNFo5OWpkZE5zNWt1UWk0Rll2LzE2?=
 =?utf-8?B?d2FNTUFMZGZ2MHFTS3hnQ2IxQ3FxUGhzK0lBdUFUeUM1Sk1iWFAvV2dOejhL?=
 =?utf-8?B?YUZJOE9xMWhUYlJUYS8zMWZDeGw2dlZJQ3l5OExOeFh4TGZCZGVPZjNpRG5O?=
 =?utf-8?B?SUppL3VnOXpUOW43NjlnR3BHQTlROGN0eWpWSFRpdWZVQXhpNG45ZUJFTDZK?=
 =?utf-8?B?ZVBVMmxNQThHUkhZOFBkT0RMUXBSclcvUkRXb0IzeUs0T2syWlF5OFJ6K0ty?=
 =?utf-8?B?TFlOS3V2QXpTR0hTMUs2cnlJWnpVM1hUU2tydllWeDRxYnNCWjVSR0VFSG9n?=
 =?utf-8?B?amwzZ1kvbHpoSW1ydnQ2endpTEpsRUtjKzByd1FGMFk4TGgySTBFbko3SGNt?=
 =?utf-8?B?ak5NVU1ZWTJMWXBtbEk4QVhodngzemhKcVRmSklsMk1ESklqVnpjd096WnRE?=
 =?utf-8?B?RGdFT3FnNi9TNll0aXlHZkI2RmFCd2hFeE8rNXNDaEdld1ZsWENYdUNuOFE5?=
 =?utf-8?B?WTd1b2VvK2RYSlpCbWFJTi91RjI3NTFla1JCb2Vpd2VxSTNhczJGTzN4bGM5?=
 =?utf-8?B?QnBKd0pjdm04ZjRjdlMxZ20xVTA3MkloeklDL1BtaXJjc2hDVEFqalhmQzlX?=
 =?utf-8?B?ZFJNV0dPNXgwVEI4VjNKWjNvZzREM2dGcXhxUHlBNFYvVHRjNGsyV3dCNUNv?=
 =?utf-8?B?L0NFWFQ2Rm9WSnJSYXFiZXk1MzY2VjljdzNMaFk1NWh1dE9DZ1pqQ0VIWUMv?=
 =?utf-8?B?Y3NNUUM2a0liMGFuMEwvcVV5ZHR4YUExNE1wbU9mK1pDNVQxRXdGeVUzN0NG?=
 =?utf-8?B?akp0RDhaUUZFRDhBT05HcnpoR0tVTjhmS0MxbXJRWWp1RUNSVHdUWHVudWRQ?=
 =?utf-8?B?aThFOWs3VVJWaE1rK0hOSmtUZ1JsYmM0Ym94Wk4rdkFRVVN2eEF3UGpGTVp2?=
 =?utf-8?B?WlNPT042U2tKVjhiSnBzazhienVUdTVzRjZlb1dJeHNrUXMwQzhuZ2RhVEJK?=
 =?utf-8?B?Z244N0JVaXBKbmFIYXVHVUp4ME5IK1FxRWduK0dyZFFsczU1ZSs3cUxnTVlp?=
 =?utf-8?B?WnFRVFJnQk0zNVpjSGlHVWkwc1dlUzVqQUU0MkN1K2ZiUVdnM2JHS1U2ckhI?=
 =?utf-8?B?ekhsdmtRNjI4djNBRDJZUjFTanJwWENvMVlETUlmQ0t3ZTdpUGp4ekgxS2Y4?=
 =?utf-8?B?eGhmYWFoWWZHTEFZVjJldmZqbnAzaXNxRWd0K3E3ZHlydnlyOTI1MHhQT3Fk?=
 =?utf-8?B?d0pkcVI2UkllSkZZRmQ5TkhFWWJWMElNMTVnM2liNllJRlUwR0JPUUJPcTMx?=
 =?utf-8?B?WDF4OU5kdWFKbklNa3J2WGNhcmkvaTJHd0JXdkpzZ2MvYVZ3Wm1Xelg0VVpu?=
 =?utf-8?B?QjVWSDBCb3M4UDlJQWp0Q2ZTUVR3QklhWjFrcFI5clQrbyt4YmtRcEhaMFo0?=
 =?utf-8?B?N3lmOGdadkM1SFJRVlNybTMyWUk4TEdGZTRrOFNXcUw3aEo5QUxyRUVqeHJ2?=
 =?utf-8?B?U2l0S0RoR3d1TWZzOGtib0pici9nU2hBMlhsV1piL09rWVkxTk9YVFlsMEky?=
 =?utf-8?B?TURoWi9FU1JGd09Vb2VZa2M0SmdoLzJHWFJ5b1VEazJNK3lSeVhtd2VFcEQ3?=
 =?utf-8?B?eUkwOHMvSm56YkNXUGV3SFFHV2loKy9jZGhhU0V4Q05RQ1RSaEZXaWhkT3Yz?=
 =?utf-8?B?NGgzZkQxaEJKK1F5SHdqRzZmSnM3ZE9BdjVXME5ZT0RyanZhbi9pWFlQVzIz?=
 =?utf-8?B?TDNkT1Q1NXN0cHgrM0x5cFB2NVRFSzBVRGpDcEdUQjE3eWtuSUdFU285alQ0?=
 =?utf-8?B?ZnlTUjdxTWlPM2JGQTUxRDNIUmFDZ3dRK2lEK0Z3Z3R1TFRPU0UyVEJHOEZS?=
 =?utf-8?B?Ri8wN2ZTYmJtSWozdGhjUDZMTlRndzRGTXNSV0xBWjQvcC9aek1ob0gzLzQy?=
 =?utf-8?Q?uFmwdemiyYIg63J0U/6w49I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E182E86741986B469E0DB1FFB9DAC434@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d72b1282-6382-49af-0005-08dcc5bd01e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 10:51:15.1051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YeG26EP3pw2eSMcjQePVaB/DDczafJbCTiP4sFaFoe1zrAzmpV3ix9Fe/kG6gw1tz1UvAlcvCauOAZqABCTw436QvNH9PsUFXn78U3XuLxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7928
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

SGkgQ2hpbnRhbiENCg0KT24gTW9uLCAyMDI0LTA4LTI2IGF0IDE1OjU1ICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gRnJvbTogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGku
Y29tPg0KPiANCj4gRXhwZWN0YXRpb24gb2YgazNfcmluZ2FjY19yaW5nX3Jlc2V0X3JhdygpIGlz
IHRvIHJlc2V0IHRoZSByaW5nIHRvDQo+IHJlcXVlc3RlZCBzaXplIGFuZCBub3QgdG8gMC4gRml4
IHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNo
ckB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBh
bGxpQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpbnRhbiBWYW5rYXIgPGMtdmFua2FyQHRp
LmNvbT4NCg0KVGhhbmtzIGZvciBxdWljayByZXdvcmshDQpSZXZpZXdlZC1ieTogQWxleGFuZGVy
IFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0K
PiBMaW5rIHRvIHY1Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwODEzMTA1NDAw
LjQwNTQ2NTctNS1jLXZhbmthckB0aS5jb20vDQo+IA0KPiBDaGFuZ2VzIGZyb20gdjUgdG8gdjY6
DQo+IC0gVXBkYXRlZCBmdW5jdGlvbiAiazNfcmluZ2FjY19yaW5nX3Jlc2V0X3JhdyIgdG8gcmVz
ZXQgb25seSByaW5nDQo+IMKgIHNpemUgZmllbGQgaW4gcmluZyBjb25maWd1cmF0aW9uIHJlZ2lz
dGVyIGFzIHBvaW50ZWQgb3V0IGJ5IEFsZXhhbmRlcg0KPiDCoCBTdmVyZGxpbi4NCj4gDQo+IMKg
ZHJpdmVycy9zb2MvdGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYyB8IDkgKysrKysrKystDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdhY2MtdS1ib290LmMgYi9k
cml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jDQo+IGluZGV4IGY5NTgyMzlj
MmFmLi4yNzk5ZjIxNGM3NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvdGkvazMtbmF2c3Mt
cmluZ2FjYy11LWJvb3QuYw0KPiArKysgYi9kcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNj
LXUtYm9vdC5jDQo+IEBAIC0yNSw5ICsyNSwxNiBAQCBzdHJ1Y3QgazNfbmF2X3JpbmdfY2ZnX3Jl
Z3Mgew0KPiDCoCNkZWZpbmUgS05BVl9SSU5HQUNDX0NGR19SSU5HX1NJWkVfRUxTSVpFX01BU0sJ
CUdFTk1BU0soMjYsIDI0KQ0KPiDCoCNkZWZpbmUgS05BVl9SSU5HQUNDX0NGR19SSU5HX1NJWkVf
RUxTSVpFX1NISUZUCQkoMjQpDQo+IMKgDQo+ICsjZGVmaW5lIEtOQVZfUklOR0FDQ19DRkdfUklO
R19TSVpFX01BU0sJCQlHRU5NQVNLKDE5LCAwKQ0KPiArDQo+IMKgc3RhdGljIHZvaWQgazNfcmlu
Z2FjY19yaW5nX3Jlc2V0X3JhdyhzdHJ1Y3QgazNfbmF2X3JpbmcgKnJpbmcpDQo+IMKgew0KPiAt
CXdyaXRlbCgwLCAmcmluZy0+Y2ZnLT5zaXplKTsNCj4gKwl1MzIgcmVnOw0KPiArDQo+ICsJcmVn
ID0gcmVhZGwoJnJpbmctPmNmZy0+c2l6ZSk7DQo+ICsJcmVnICY9IH5LTkFWX1JJTkdBQ0NfQ0ZH
X1JJTkdfU0laRV9NQVNLOw0KPiArCXJlZyB8PSByaW5nLT5zaXplOw0KPiArCXdyaXRlbChyZWcs
ICZyaW5nLT5jZmctPnNpemUpOw0KPiDCoH0NCj4gwqANCj4gwqBzdGF0aWMgdm9pZCBrM19yaW5n
YWNjX3JpbmdfcmVjb25maWdfcW1vZGVfcmF3KHN0cnVjdCBrM19uYXZfcmluZyAqcmluZywgZW51
bSBrM19uYXZfcmluZ19tb2RlIG1vZGUpDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
