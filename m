Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A1C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 08:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C990782A25;
	Tue, 27 May 2025 10:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZR6MjqVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FD282ADA; Tue, 27 May 2025 10:12:10 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A06681E25
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ou4RCjb1W5QanFZOZyIWSBpXdpR7p1NtW2FexXUKTH+qUO5zslNcPJ5jSC1hF8MddHK0qlnEyJ2LzUDxp8cQa0bWAOjtUWGub/FrO+watfcIe3EbZfnOuaf0U+RyBPgKL9TrwPtNEvocY1Sg/Fo1xiRWeuJx/R+AMT1MSNL0Aeuh6NuWwLjoR8etWeToOMgzYYAdFWApTDHU0s3yzaabTdbdjM7bI0pyJgJCTVkpRv7pZR+mOMQXXchsVNjba+Xh0tGNMiZw9NnVXZ6MrPuHsjizK+40DbKxMN/Xudv5zeAK3tqpJAFU+/PrrcVbSlm54MIgYCHGroEZgKaqgm905w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zDHx7Y1qe62Km6uPfxeJQPtE4wR3T2LdQeaXc5GT1E=;
 b=LcqBxbv9pz3KrUMlocSAyaaKyxk0dg9Ws+48BkXOtdp4+vEM23NcumKs1j+citweferlR6vMdWUFxbjq2/9rWZEmzQKR29Xo/0uQdc0h0qNGo1T1dDAITvFhTkoDD2nm2RSNzkIU4BsFO+jaNW1D/S2eTZL2qS+6n3HNh46+k2xu94d29YMUWP7IhY5q6+xiPPvW4Ko9LqSLJgchAgwKFdmhUeXoXrwSwvDiFXhZ5fRf2vYy9cxdvrNkXpDmOfh0gp/zsBckdCmcTrgMu4Kp8Na3F/7TDCm8VGsog6X53tQnGoqY/tOpJ7WpbgNz3/WQfUCHIu0VhhBtdE/c01wMzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zDHx7Y1qe62Km6uPfxeJQPtE4wR3T2LdQeaXc5GT1E=;
 b=ZR6MjqVFZGjZiYsbbLO2DUpTJ8tnt6+F8xfC1ZRMpimAxchIzaNIAgzZy+GmrwqGI3iMuf29kM+a8Ql1JOt1mi68QVl87fVQ+7eyVaSvjZi6u/7TR4i9SHyrnDJ0NYdPj2qsGGZlzijdIWEDyUlJNZMehE5Dvfjw+AIlbOsppgbHpHYYKgGfNEp1xr4crjFl3RkiqoqmQtvt/YJnM4AsGBUtVc5JAMImRFELiSd4Bmy3vem9nYmmTMep2YaU6NSh/fDRIG/owxw/dCILiu+NFW1+U3MhUZVRGQx6mDZpWVUQ2sk45P/aak/Hxcg0UOQ7d7bVkZ9NnyTnuRZGTmoa7A==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GVXP195MB1662.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Tue, 27 May
 2025 08:12:03 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 08:12:03 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Topic: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Index: AQHbcjjLfXNkb9lhtEeZVLV5ci3/5bNAlVuAgARWDACAAG+WgIABHk4AgABwngCABEqqgIAAYmsAgAGS0QCAALS9gICY8IyAgAAKhIA=
Date: Tue, 27 May 2025 08:12:03 +0000
Message-ID: <e9cb52aa883c5f2372084fcf4c1c06ea23fe47de.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
 <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
 <CAFLszTjhYPkaQdtxrNNkLnfg=YkJ6f7JRtg=jPjDR2h_DD8Wkg@mail.gmail.com>
 <8efb1beb7dc94f16919b00fa88fc8048eec80905.camel@phytec.de>
 <CAFLszTg0UXfcsy8-A9QMq5CSsAvAXHLKRBpHyzdNuwdj17VwKQ@mail.gmail.com>
 <150cc82d61583d092aed27ce043c6316b093a13a.camel@phytec.de>
 <CAFLszTinxMvBiz8sWC8+qEiHUHXX6LFgw1FnC8kNY1DMG8AF9g@mail.gmail.com>
 <CAFLszThotL8ufW-qkc2Eo3ooyf7MMHFfr_OB-H6u7kV3BTt4Jw@mail.gmail.com>
In-Reply-To: <CAFLszThotL8ufW-qkc2Eo3ooyf7MMHFfr_OB-H6u7kV3BTt4Jw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GVXP195MB1662:EE_
x-ms-office365-filtering-correlation-id: eee78915-7c2c-494f-b6f9-08dd9cf629ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHBhRythTVRhSTk5SWRFdmZuVUlmeEpWRnp4dzAzdjJXQVIwZHAxNGo5WFM1?=
 =?utf-8?B?YUVJU08wK0dIVEpxMHJTSVNkYUJZK3c5dTJlVEpNOWJUbnVIeldZZFY2NzRH?=
 =?utf-8?B?c29aSUwzaHVVb2pMTmRScU9qN3hiNmsrY0doZ0tqS1hGbGZWUCtEQTZIY3Fz?=
 =?utf-8?B?Z3MrblJWS01NVXBuMjB0c0R5bEVNcmJTaEVnbDRMVGpFOHZRRVRKdUFxcEFm?=
 =?utf-8?B?K2lCbWdiamdOaEk2dHdQaVRNVmRCSUtMUjJkVVpjZXRXekhMRVZjVnk2c242?=
 =?utf-8?B?cWdNaHVaODFDbzYxSzZ0YmkyTXVtNktsSjRiK1FkVUlBdW05NG5seVdPeXdU?=
 =?utf-8?B?dVhyT2ExcGl0RXFVNDV4eU45c0xQTDd3eEtjNzAzd0doYk9HbTZ2YmVSZmNR?=
 =?utf-8?B?VjVuZFlDdjRoUEtydVp5NGVpTUJDSXd3dngyazBpNmc2b0lFcDRFbjBMdlJN?=
 =?utf-8?B?ZWtqQ05IQUg1OTUwTDdnZG9kTGUxOHBkdHBpY29uM2h4YW13cGkzSjRhWTdI?=
 =?utf-8?B?R0VwWm5yZEhUZU9CVlhhaU44bWZkbGptYXIrZ3RIaWd1L093WjZsWUhzVXZ3?=
 =?utf-8?B?T21LUDZkYTZvU3h1Z2pQdERLWU1XMHNpUGFFVmhXMW15NEM4UE5aWEhxV1dM?=
 =?utf-8?B?N1hiLzd1NTRwYTRPWUhBYzlRcVV2WGVnZ0ZlQVY1MlFoTUoycXFjcDFabEZz?=
 =?utf-8?B?VWdZeW1EUmhnc2JobUtOOHMwTVBvbzBmUWEyTjJDWlBPWWUwQzIrWEJIOUx4?=
 =?utf-8?B?M1ZxRytBblNGdVdYSmJoYVRBRU80WUg3OW5rd0t0NmhxM1Z0R2JYYzhTTWhE?=
 =?utf-8?B?T2NSRnl5VllUbFFPZ1l3NFpUa0RxcG1hZjZxVTVsZHBrLzA2WW9ham9iMjVk?=
 =?utf-8?B?YmF0NjVrelY4SGtRZ2pGRjNEZWwreDN4YmFKd3BpYk1PY3pQZWhFekdYcnJY?=
 =?utf-8?B?cldsaC9XWVZxaUw1VTJCTThJOWYxeTJQbEhnNjdWdldFamdmSkFuTmgvbkFq?=
 =?utf-8?B?SlFOb1dPWXgzTmprVGRnU0J6UmlMQk9NOUZNVjltVEI0K25OTGVaTUpmK0JQ?=
 =?utf-8?B?eWhXODd4UDhDRVgrRi80REpINmttMmxsS1hBV2F6NG1wbXQrdXR5ZHJ2UVZD?=
 =?utf-8?B?MmN5VWZPWktPYm1naVk2OStEemVEUURQbFh0VE93SGk2SFg5RTQ5Nk5JWGkw?=
 =?utf-8?B?d1RYcVB1UnluYkV0VnBDSDgvZFFLOWVPcTgxVXlDN1JxeVV5Umpadm1KbWFh?=
 =?utf-8?B?Z01uMHpTdnl4MmU0SFZlMDdwb203Rm8zWFVML3NlVC9TUHQ3M2NVR29OSUw4?=
 =?utf-8?B?ZW11MGwzV0hCVWhLYWE0UVdvVUMrZzh0eG9scnpDYmdZT2FPeWRJLzFLaE5s?=
 =?utf-8?B?bnZXQVV3Yzh2S2lIWEVkeW1CSlpLblZlcFRGUFhCQVdrTVREYUtMalErR1VX?=
 =?utf-8?B?bUk2VWlmYlF4bFV3Vmd5RVFCTWUzendhd3B3WGE5b1pSeU5FWlRCZFZmTG8x?=
 =?utf-8?B?Tm55N0VtUW5GdkljemVPQXZrQnhERUlNNzhNSDkvaVBqOXRmM2pZZFdPSVkr?=
 =?utf-8?B?UzcvRWNmc2REcloyemlLYnRpbnRQT3R6NWVtOW1reDAxczZDSjR5cWtVL1lB?=
 =?utf-8?B?MHR0Tm9uRERtODJyNGRlR2ZYaytrOWNlc1hhai9kdVlRbGZlU2kvODdYR0pi?=
 =?utf-8?B?UXl0dlQ1c0hBTC9meHFuRjBuUnF4Q3RBVDZRZERSbkZESHFRK2tMbDJaTlNo?=
 =?utf-8?B?WXM1ckV3bVNuOWsxejZIdWQ3NlNQd0poMDd3c1h2K2dQNDF1RkFEZlhSRFhH?=
 =?utf-8?B?TUtNVUdJeUJRWWl0dkthRy8zVjJrNEh5QVg1WG43RjE3dmkvaVhjMDRTc3M0?=
 =?utf-8?B?V3gySzd4WFFmR0krRHQ4VGNmb0VzM00vRm1BWjVBOUFjenJaSWVzNnM1WFFi?=
 =?utf-8?B?ZHB3OE5jL0VZbHJiMGJRbTJHUHpwSTJZcEUzZXNxdGozQng1bzMrK2dYdEoz?=
 =?utf-8?Q?sst13imtcVAlZs9oRx/y3arVmzF8NM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFSV2lZc2s5ajkveUdDUnVVZm9rYlhBNzdGMGRvWWhJeXVSb2dpWW5ZaUk0?=
 =?utf-8?B?cmRYNlNlamowNFI5d3lJOUs2UWNYOWlVTWhGLytIWjUySEVaZHdaRElKNEt2?=
 =?utf-8?B?Y09zMTIxWE1QZU5mNGlsbGlLNDBGQlhwZ3l0bXFCTnNLbExxUFgwSldrNENk?=
 =?utf-8?B?U0dtbTFGb3hUTDF0RHc1M3p5aGtJY0ticlVxNTNlMG56WGNvQXRXRTR4RVNo?=
 =?utf-8?B?WXY5ZldBcGdOV054REFkZ3NiNHplejAyK3FOUkthQWZqcE5ZUG9rK2JEME0z?=
 =?utf-8?B?dGVWeDZ1aFFBVTBEbVFVdjNmckNzcW5LTllLWlBxYkpkaGo3MXdMNnNldERr?=
 =?utf-8?B?ZUNIamZoWjFIdi9wSGphSmJkQ3F0RnI1Z2JEU3N1eGx1elZCakhmQm5WYUNs?=
 =?utf-8?B?NjdlcVlrTStOK3pUTHdLNXMrWXFyZyt4VUMzazRiS2xLemVzN25yQVhaUldu?=
 =?utf-8?B?ckZDcGd0RlhzNWl6bklid0IxQUwrV3ZQZWwwdmtvVkRTY0RGd09nSTVzeVNa?=
 =?utf-8?B?OGJzd3RKTGU3Yi9GclZjV3FGU1ZHeXFQNDhlN0F5NkVQZnM2SkovY29zaTdV?=
 =?utf-8?B?bnRxZ0ppR01VNnBkbGY0QXZxdFd1ZzJiUjdpQzVZcUtSSDc5SzUydHUxN3cz?=
 =?utf-8?B?Vy9ZVWsyMEhIRjhDeUhybU5hRjV4aG83YnRnaUJUSVZNNERKOVRGZm1GS3VO?=
 =?utf-8?B?ZzJLSE1Xa1ZPUWl4cVBCNmhCVHBhdnMwYkxubVVEQzhpTHY5QWFLSmY2djlz?=
 =?utf-8?B?dlgraEhablZRTFJURHF2eEg2VjJzUk1lcCtGYUdLUmlzM2sxUmc0MHhYa01T?=
 =?utf-8?B?MW5yL0tlM3ZxTzRJc3N4VkFCK1pOWVdNNjFiSUR4ZFFEclNaTU9vZDdXdkJG?=
 =?utf-8?B?aU52djNJSDBRVzdwVWo1K1ZpaXNkS2F5NDNwVkkrMVFuT1dCZXJ4azZpNVYv?=
 =?utf-8?B?bXl6RWc5RkhXV1BlSTd5K2c5NVFQTTBtQlhVWjZOaERmWWo1a1dhcThMY3li?=
 =?utf-8?B?c0ppcFMvekk2QUgzWUtMTG16cE94OWdoazMxOGt0bGJDNVF2N0hJYUxXTWlh?=
 =?utf-8?B?Y2VKdTJhV1M4OHFHRDg2MzhvaEpVL1RRazNkMk5NbU5DbzlPUnJObXAzQ2tp?=
 =?utf-8?B?aGgyR0xvQkNEaVE0d3IzNWlycjBjTW1xZjJSZ053aytPNGpOQm94anczV2tv?=
 =?utf-8?B?RVpGZ1YrMXhaREkvZkhQdnl4cFYwaTNRMm05bFJEWUVXKzJYWmc4dnE2cnJt?=
 =?utf-8?B?MVNya2ZoSjBpU2xGQS9ycnFicXFqQ1hNMWZaNngyMTFFdUFsMTczYWptdVRC?=
 =?utf-8?B?TVNVQW54MW1qakZicjhYS3VnSm4vN3FPRFl1Nm1ZVllmSWFtd1k4RTlOcWs4?=
 =?utf-8?B?Qkl4alZjUFU4dEVwR0w4VWt2T010bWhENnVHMi9hejNDZzFiZkk4TUl2Sm5R?=
 =?utf-8?B?ck8yZmNqcVVjLytxYnJ5REZFQ09JeGJNSy9pSm5vK3gxdHcrWGJORG1JZGhF?=
 =?utf-8?B?RFZ2RERMR0wreWNodWZEdE92ajlaNWMwT1NiNUZhWUxqSXBLeTZYdTFuNFhO?=
 =?utf-8?B?eXJRTjhYUzhkRVRkd1VuWHlJOWpSTFZEc0F5cTk2N0dvb0cxemlrMlphZ2x6?=
 =?utf-8?B?eGQ1ZVpxM0hjbjE3OWVDR0ovYmlrNENHY1JvcVRrc0JXWFJLWW50VGNVYnhK?=
 =?utf-8?B?cDNTSVovVW1ibEhQbStxTWxrTkd4WlExdHZwYk1kMUJPbW1uazBOR3FMcXBs?=
 =?utf-8?B?RTdKeWlyRW1YbUR1UnNqUXpjV1RCTVR4S0E1YjV5d3B3NE1QZk54MkV5bFl1?=
 =?utf-8?B?ZXVTSkVrOXgvdEFveEhXdGV2K2ZXZURiMTNvVzhoUVlOTzczaWx2OEhYcnl4?=
 =?utf-8?B?emFjd1FlVTFCQVovZXNtcUhObmhFeGJwQ2NNS2JCU1dvTG5RNkhNb0tzMGdw?=
 =?utf-8?B?eWtyc21uaHA4YngzNmpqZ3JSYStyc0dpemVyRlVCenVGTVczbHA5aGFCZzFi?=
 =?utf-8?B?R3J3NWc2Q1hHUEhBV0VHZFp4dEZVLzhxZTBXa05CaXc1MjNGVER3MFRVVXhN?=
 =?utf-8?B?U2trZE9DazFuM0ZQK1N3d2tsbjBzSWVRdk1OQ2FYK2xPWUFDNVN2a3lFSzNi?=
 =?utf-8?Q?kj5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BD158961D981942BB2A58B4632B2F09@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eee78915-7c2c-494f-b6f9-08dd9cf629ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 08:12:03.5543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUVoLpBoFDUmmXDrImMN4+/KVrXHxHuxHiJR0q0fRWY9H/gba5ZhgQHwOXQgjFcRLwiWeWsxUlmJJ2aF98OW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB1662
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

SGkgU2ltb24sCgpBbSBEaWVuc3RhZywgZGVtIDI3LjA1LjIwMjUgdW0gMDg6MzQgKzAxMDAgc2No
cmllYiBTaW1vbiBHbGFzczoKPiBIaSBZYW5uaWMsCj4gCj4gT24gV2VkLCAxOSBGZWIgMjAyNSBh
dCAwMDowMSwgU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+IHdyb3RlOgo+ID4gCj4gPiBI
aSBZYW5uaWMsCj4gPiAKPiA+IE9uIFR1ZSwgMTggRmViIDIwMjUgYXQgMDY6MTUsIFlhbm5pYyBN
b29nIDxZLk1vb2dAcGh5dGVjLmRlPiB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIE1vbiwgMjAyNS0w
Mi0xNyBhdCAwNjoxMyAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6Cj4gPiA+ID4gSGkgWWFubmlj
LAo+ID4gPiA+IAo+ID4gPiA+IE9uIE1vbiwgMTcgRmViIDIwMjUgYXQgMDA6MjEsIFlhbm5pYyBN
b29nIDxZLk1vb2dAcGh5dGVjLmRlPiB3cm90ZToKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSGkgU2lt
b24sCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIEZyaSwgMjAyNS0wMi0xNCBhdCAwNjo0OCAtMDcw
MCwgU2ltb24gR2xhc3Mgd3JvdGU6Cj4gPiA+ID4gPiA+IEhpIFlhbm5pYywKPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+IE9uIEZyaSwgMTQgRmViIDIwMjUgYXQgMDA6MDUsIFlhbm5pYyBNb29nIDxZ
Lk1vb2dAcGh5dGVjLmRlPgo+ID4gPiA+ID4gPiB3cm90ZToKPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiBPbiBUaHUsIDIwMjUtMDItMTMgYXQgMDc6MDEgLTA3MDAsIFNpbW9uIEdsYXNzIHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gSGkgWWFubmljLAo+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4g
PiA+ID4gPiBPbiBUaHUsIDEzIEZlYiAyMDI1IGF0IDAwOjIxLCBZYW5uaWMgTW9vZyA8WS5Nb29n
QHBoeXRlYy5kZT4KPiA+ID4gPiA+ID4gPiA+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gT24gTW9uLCAyMDI1LTAyLTEwIGF0IDA2OjA4IC0wNzAwLCBTaW1vbiBH
bGFzcyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBXZWQsIDI5IEphbiAyMDI1IGF0IDAz
OjMwLCBZYW5uaWMgTW9vZwo+ID4gPiA+ID4gPiA+ID4gPiA+IDx5Lm1vb2dAcGh5dGVjLmRlPiB3
cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhlIGJp
bm1hbiBkb2N1bWVudGF0aW9uIG9mIE9wdGlvbmFsIGVudHJpZXMgaXMgbm90Cj4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBhY2N1cmF0ZSBpbiB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHNlbnNlIHRo
YXQgaXQgZG9lcyBub3QgY292ZXIgYmxvYnMgZW50cnkgdHlwZS4gQXMgdGhpcwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gaXMgYWxzbyB0aGUgbW9zdAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gd2lkZWx5
IHVzZWQgdHlwZSB0byBoYXZlIHRoZSBvcHRpb25hbCBlbnRyeSwgZG9jdW1lbnQKPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IHRoZSBpbnRlcmFjdGlvbgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gd2l0aCBm
YWtpbmcgYmxvYnMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoHRvb2xzL2Jpbm1hbi9iaW5t
YW4ucnN0IHwgOSArKysrKysrKy0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlubWFuL2Jpbm1hbi5y
c3QKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGIvdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGluZGV4IDk5MGZjMjk1NzcwLi4yYmFmYTZjYTQwOCAxMDA2NDQKPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IC0tLSBhL3Rvb2xzL2Jpbm1hbi9iaW5tYW4ucnN0Cj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiArKysgYi90b29scy9iaW5tYW4vYmlubWFuLnJzdAo+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gQEAgLTExNDUsNyArMTE0NSwxNCBAQCBjYWxsZWQgb24gYWxsIGVudHJpZXMuCj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiDCoEl0IGlzIG5vdCBwb3NzaWJsZSBmb3IgYW4gZW50cnkgdG8g
bWFyayBpdHNlbGYgYWJzZW50Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBhdCBhbnkgb3RoZXIgcG9p
bnQgaW4gdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoHByb2Nlc3NpbmcuIEl0IG11c3QgaGFw
cGVuIGluIHRoZSBPYnRhaW5Db250ZW50cygpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBtZXRob2Qu
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC1UaGUgZWZmZWN0
IGlzIGFzIGlmIHRoZSBlbnRyeSBoYWQgbmV2ZXIgYmVlbiBwcmVzZW50Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiBhdCBhbGwsIHNpbmNlIHRoZSBpbWFnZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK1Ro
ZSBlZmZlY3QgZGVwZW5kcyBvbiB0aGUgdHlwZSBvZiBlbnRyeS4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ICsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICtCbG9icwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
K35+fn5+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArRm9yIGJsb2JzLCB0aGUgZWZmZWN0IGRlcGVu
ZHMgb24gd2hldGhlciAtLWZha2UtZXh0LQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gYmxvYnMgaXMg
cGFzc2VkCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArdG8gYmlubWFuLiAoVGhpcyBpcyB0aGUgY2Fz
ZSBieSBkZWZhdWx0KQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gK0luIGNhc2UgLS1mYWtlLWV4dC1i
bG9icyBpcyBzZXQsIGFueSBtaXNzaW5nIGVudHJpZXMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdp
bGwgYmUgZmFrZWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiArSWYgbm90IHNldCwgaXQgaXMgYXMg
aWYgdGhlIGVudHJ5IGhhZCBuZXZlciBiZWVuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBwcmVzZW50
IGF0IGFsbCwgc2luY2UgdGhlIGltYWdlCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiDCoGlzIHBhY2tl
ZCB3aXRob3V0IGl0IGFuZCBpdCBkaXNhcHBlYXJzIGZyb20gdGhlIGxpc3QKPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IG9mIGVudHJpZXMuCj4gPiA+ID4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4g
PiA+ID4gSSdtIG5vdCBxdWl0ZSBmb2xsb3dpbmcgdGhpcy4gVGhlIHRleHQgc2VlbXMgT0sgYnV0
IHlvdXIKPiA+ID4gPiA+ID4gPiA+ID4gPiBoZWFkaW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4gaW1w
bGllcyB0aGF0IHRoaW5ncyBvdGhlciB0aGFuIGJsb2JzIGNhbiBiZSBmYWtlZC4gQWxsIG9mCj4g
PiA+ID4gPiA+ID4gPiA+ID4gdGhpcwo+ID4gPiA+ID4gPiA+ID4gPiA+IGZ1bmN0aW9uYWxpdHkg
aXMgb25seSBmb3IgYmxvYnMuCj4gPiA+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gPiBU
aGUgaGVhZGluZyBpcyBhIHN1YnNlY3Rpb24gb2YgIk9wdGlvbmFsIGVudHJpZXMiLiBUbyBteQo+
ID4gPiA+ID4gPiA+ID4gPiBrbm93bGVkZ2UgdGhlICJvcHRpb25hbCIgcHJvcGVydHkKPiA+ID4g
PiA+ID4gPiA+ID4gaXMKPiA+ID4gPiA+ID4gPiA+ID4gbm90Cj4gPiA+ID4gPiA+ID4gPiA+IGxp
bWl0ZWQgdG8gYmxvYnMuIEJ1dCBibG9icyBnZXQgc3BlY2lhbCB0cmVhdG1lbnQgaW4KPiA+ID4g
PiA+ID4gPiA+ID4gcmVnYXJkcyB0byAib3B0aW9uYWwiIGR1ZSB0byB0aGUgLS0KPiA+ID4gPiA+
ID4gPiA+ID4gZmFrZS0KPiA+ID4gPiA+ID4gPiA+ID4gZXh0LQo+ID4gPiA+ID4gPiA+ID4gPiBi
bG9icyBvcHRpb24uIEhlbmNlIHRoZSBzdWJzZWN0aW9uLgo+ID4gPiA+ID4gPiA+ID4gPiAKPiA+
ID4gPiA+ID4gPiA+ID4gV2hhdCB3b3VsZCB5b3UgbGlrZSBtZSB0byBjaGFuZ2UgdG8gbWFrZSB0
aGlzIGNsZWFyZXI/Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IE9oIEkgc2VlLiBB
cmUgeW91IHNheWluZyB0aGF0IG9wdGlvbmFsIGVudHJpZXMgZW5kIHVwIGluIHRoZQo+ID4gPiA+
ID4gPiA+ID4gaW1hZ2UKPiA+ID4gPiA+ID4gPiA+IHdoZW4gdGhleSBhcmUgZmFrZWQsIGV4dGVy
bmFsIGJsb2JzPyBJZiBzbywgdGhhdCBzZWVtcyBsaWtlIGEKPiA+ID4gPiA+ID4gPiA+IGJ1ZyB0
bwo+ID4gPiA+ID4gPiA+ID4gbWUuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gVG8gY2xh
cmlmeSwgb3B0aW9uYWwgaW1hZ2VzIGFyZSBmYWtlZCBvbmx5IHdoZW4gdGhleSBhcmUKPiA+ID4g
PiA+ID4gPiBtaXNzaW5nLiBTbyBpbiBjYXNlIHRoZSBpbWFnZSBpcwo+ID4gPiA+ID4gPiA+IG1p
c3NpbmcsIGEKPiA+ID4gPiA+ID4gPiBmYWtlZCBpbWFnZSBpcyBpbmRlZWQgcGFja2FnZWQgaW50
byB0aGUgaW1hZ2UuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBPSywg
YnV0IEkgc3RpbGwgdGhpbmsgaXQgaXMgYSBidWcuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEkgZGlk
bid0IHF1ZXN0aW9uIHlvdXIganVkZ2VtZW50LCBJIHNpbXBseSBkb24ndCBoYXZlIHRoZSBicm9h
ZGVyCj4gPiA+ID4gPiBnb2FsIG9mIGJpbm1hbiBpbiBtaW5kIHRvIGJlIGFibGUKPiA+ID4gPiA+
IHRvIGp1ZGdlIGlmIHRoaXMgYmVoYXZpb3VyIGlzIHVuaW50ZW5kZWQuCj4gPiA+ID4gPiBXaGF0
IHNob3VsZCBoYXBwZW4gaW5zdGVhZD8gU2hvdWxkIHRoZSBpbWFnZSBzaW1wbHkgYmUgYWJzZW50
IGluCj4gPiA+ID4gPiB0aGUgZmluYWwgaW1hZ2U/Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gV2h5
IGFkZCBhbiBvcHRpb25hbCB0aGluZyBpbiB0aGlzIHdheT8KPiA+ID4gPiA+IAo+ID4gPiA+ID4g
QmVjYXVzZSBpdCBzZWVtcyBsaWtlIGEgc2ltcGxlLCBlbGVnYW50IHNvbHV0aW9uLgo+ID4gPiA+
ID4gVG8gZWxhYm9yYXRlOgo+ID4gPiA+ID4gVGhlIGdvYWwgKGluIGNhc2Ugb2YgT1AtVEVFKSBp
cyB0byBoYXZlIHRoZSBiaW5hcnkgcGFja2FnZWQgd2hlbgo+ID4gPiA+ID4gaXRzIHRoZXJlIGFu
ZCBub3QgcGFja2FnZWQgd2hlbiBpdAo+ID4gPiA+ID4gaXMgbm90IHByZXNlbnQuCj4gPiA+ID4g
PiBQcmVjaXNlbHkgYmVjYXVzZSBpdCBpcyBub3QgcmVxdWlyZWQgZm9yIGEgYm9vdGFibGUgaW1h
Z2UsIGJ1dCBtYXkKPiA+ID4gPiA+IGJlIGFkZGVkIHRvIGVuaGFuY2UgZnVuY3Rpb25hbGl0eQo+
ID4gPiA+ID4gLiBJLmUuIGl0IGlzIG9wdGlvbmFsLgo+ID4gPiA+ID4gSSBmb3VuZCB0aGUgVS1C
b290IGRvYyB0byBleHBsYWluIG9wdGlvbmFsIGVudHJpZXMgYW5kIHRob3VnaHQgaXQKPiA+ID4g
PiA+IHRvIGJlIGEgcGVyZmVjdCBmaXQuCj4gPiA+ID4gPiBXaGF0IGRvIHlvdSBoYXZlIGluIG1p
bmQgdG8gYWNoaWV2ZSB0aGlzIGdvYWw/Cj4gPiA+ID4gCj4gPiA+ID4gSSB0aGluayB3ZSBhcmUg
dGFsa2luZyBhYm91dCBzbGlnaHRseSBkaWZmZXJlbnQgdGhpbmdzLgo+ID4gPiA+IAo+ID4gPiA+
IElmIGEgYmluYXJ5IGlzIG9wdGlvbmFsIHRoZW4gSSBkb24ndCBzZWUgbXVjaCBwb2ludCBpbiBp
bmNsdWRpbmcgYW4KPiA+ID4gPiBlbXB0eSAob3IgZmFrZWQpIGJpbmFyeS4gSWYgaXQgaXMgdGhl
IG9ubHkgdGhpbmcgbWlzc2luZywgdGhlIGltYWdlCj4gPiA+ID4gc2hvdWxkIHN0aWxsIGJvb3Qg
T0sgaWYgaXQganVzdCBkb2Vzbid0IGFwcGVhciBpbiB0aGUgaW1hZ2UuCj4gPiA+ID4gCj4gPiA+
ID4gVGhlIGlkZWEgd2l0aCBCaW5tYW4gaXMgdG8gcHJvZHVjZSBhIGZ1bmN0aW9uYWwgaW1hZ2Us
IHdoZXJlCj4gPiA+ID4gcG9zc2libGUuCj4gPiA+ID4gQW4gaW1hZ2Ugd2l0aG91dCBhbiBvcHRp
b25hbCBibG9iIGlzIGZ1bmN0aW9uYWwsIHNvIHdlIHNob3VsZCBub3QKPiA+ID4gPiBuZWVkCj4g
PiA+ID4gdG8gYWRkIGl0Lgo+ID4gPiA+IAo+ID4gPiA+IEknbSBub3Qgc2F5aW5nIHRoaXMgaXMg
YSBiaWcgcHJvYmxlbSwganVzdCB0aGF0IGl0IHNlZW1zIHN1cnByaXNpbmcKPiA+ID4gPiBhbmQg
bm90IHdoYXQgSSBpbnRlbmRlZC4KPiA+ID4gCj4gPiA+IEkgYW0gd2l0aCB5b3Ugb24gdGhpcy4g
SXQgd2FzIHN1cHJpc2luZyB0byBtZSwgdG9vLiBBbmQgSSBhZ3JlZSB0aGVyZQo+ID4gPiBpcyBu
byBwb2ludCAoYXQgbGVhc3QgdG8gbWUpIGluIGluY2x1ZGluZyBpdCBpbiB0aGUgZmluYWwgaW1h
Z2UuCj4gPiA+IFNvIHdlIHdlcmUgdGFsa2luZyBhYm91dCB0aGUgc2FtZSB0aGluZywgSSBzaW1w
bHkgd2FudCB0byBtYWtlIHN1cmUgd2UKPiA+ID4gYXJlIG9uIHRoZSBzYW1lIHBhZ2UuCj4gPiA+
IAo+ID4gPiA+IAo+ID4gPiA+IFBlcmhhcHMgd2UgZG8gbmVlZCB0byBmYWtlIHRoZSBibG9iIGlu
IGNhc2UgaXQgaXMgdXNlZCBieSBzb21lIG90aGVyCj4gPiA+ID4gdG9vbC4gQnV0IEkgd29uZGVy
IGlmIHdlIGNhbiBzdG9wIEJpbm1hbiBhZGRpbmcgdGhlIGZha2VkIGJsb2IgaW50bwo+ID4gPiA+
IHRoZSBpbWFnZSwgaWYgaXQgaXMgb3B0aW9uYWw/Cj4gPiA+IAo+ID4gPiBGcm9tIG15IHBvaW50
IG9mIHZpZXcsIEl0IHdvdWxkIGJlIGJldHRlciB0byBzdG9wIGJpbm1hbiBmcm9tIGFkZGluZwo+
ID4gPiBmYWtlZCBibG9icyB0aGFuIHdoYXQgSSBwcm9wb3NlZCBpbiB0aGVzZSBSRkMgcGF0Y2hl
cy4gSSBkaWRuJ3Qga25vdywKPiA+ID4gaG93ZXZlciwgaWYgdGhlcmUgd2FzIGEgdXNlIGNhc2Ug
Zm9yIGFkZGluZyB0aGVtIHRvIHRoZSBpbWFnZXMgdGhhdCBJCj4gPiA+IGFtIG5vdCBhd2FyZSBv
Zi4KPiA+ID4gU2luY2UgeW91IG5vdyBjb25maXJtIHRoYXQgaXQgd2FzIG5ldmVyIHlvdXIgaW50
ZW50aW9uIHRvIGhhdmUgdGhlbQo+ID4gPiBpbmNsdWRlZCBpbiB0aGUgZmlyc3QgcGxhY2UgSSB0
aGluayB3ZSBjYW4gZ28gYWhlYWQgaW4gcHJldmVudGluZwo+ID4gPiBiaW5tYW4gZnJvbSBhZGRp
bmcgZmFrZWQgYmxvYnMgdG8gaW1hZ2VzLgo+ID4gPiBJJ2xsIHdvcmsgb24gaXQgZm9yIHRoZSBu
ZXh0IHZlcnNpb24uCj4gPiAKPiA+IFRoYW5rcywgYW5kIGFsc28gZm9yIHNwb3R0aW5nIHRoaXMu
Cj4gCj4gRGlkIHlvdSBldmVyIGdldCBiYWNrIHRvIHRoaXMgc2VyaWVzPyBJJ2QgbGlrZSB0byBn
ZXQgaXQgaW4gaWYgd2UgY2FuLgoKWWVzLCBob3dldmVyIEkgdG9vayBhIGJyZWFrIGR1ZSB0byBv
dGhlciB3b3JrLsKgCkFueXdheSwgSSBoYWQgdGFrZW4gYSBsb29rIGF0IGl0IHRoZSBvdGhlciBk
YXkgYW5kIGZvdW5kIGl0IHZlcnkgZGlmZmljdWx0IHRvCmdldCB0aGUgR2V0RW50cmllcyhvbWl0
X29wdGlvbmFsPVRydWUpIHJvdXRlIHdvcmtpbmcgYXMgaXQgb25seSBnb2VzIDEgbGV2ZWwKZGVl
cCBpbiB0aGUgImVudHJpZXMiIHRyZWUgYW5kIHdlIHBhY2sgYW5kIHdyaXRlIHRoZSBpbWFnZSBp
biBtdWx0aXBsZSBzdGVwcy4KRXNzZW50aWFsbHksIHdlIHdvdWxkIGhhdmUgdG8gbWFrZSBhIGNv
cHkgb2YgdGhlIHdob2xlIHRyZWUgYXMgZmFyIGFzIEkKdW5kZXJzdGFuZCAob25lIGNvcHkgaW5j
bHVkaW5nIGFic2VudCBpbWFnZXMgYW5kIG9uZSBleGNsdWRpbmcgYWJzZW50IGltYWdlcykuCgo+
IAo+IFBlcmhhcHMgd2UgZG8gbmVlZCB0byBmYWtlIHRoZSBibG9iIGluIGNhc2UgaXQgaXMgdXNl
ZCBieSBzb21lIG90aGVyCj4gdG9vbC4gQnV0IEkgd29uZGVyIGlmIHdlIGNhbiBzdG9wIEJpbm1h
biBhZGRpbmcgdGhlIGZha2VkIGJsb2IgaW50bwo+IHRoZSBpbWFnZSwgaWYgaXQgaXMgb3B0aW9u
YWw/Cj4gCgpJbW8ga2VlcGluZyB0aGUgZHJvcF9hYnNlbnQgZnVuY3Rpb24gYW5kIGFkanVzdGlu
ZyB0aGUgdGVzdHMgaXMgYSBtb3JlIHByb21pc2luZwpzb2x1dGlvbjsgbGVzcyBjb21wbGV4LiBX
ZSBjb3VsZCBvbmx5IGRyb3Agb3B0aW9uYWwgaW1hZ2VzIGJ1dCB0aGVuIHN0aWxsIGhhdmUKZmFr
ZWQgYmxvYnMgaW4gdGhlIGZpbmFsIGJpbm1hbiBpbWFnZSBhZmFpazsgcmVuYW1lIGRyb3BfYWJz
ZW50IHRvCmRyb3Bfb3B0aW9uYWxfYWJzZW50PwoKWWFubmljCgo+IAo+IFJlZ2FyZHMsCj4gU2lt
b24K
