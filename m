Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCB1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 12:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F68988B39;
	Fri, 16 Aug 2024 14:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="GFeXppsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8530B88B5D; Fri, 16 Aug 2024 14:42:36 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC2F88AFF
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBoXYbOh3jI2ENyLcK4LL+k//5WVzhO33BNT45A6m7A6wafZR1cU1D8/CN2oMKmvyE3/U1Huwv4WJTFuRnu/2OKkgEJVmQM7ZOTvlhoxFU/Lsc+BEkRndN8eNBFkFsjO7LMntScYBfWYYYY9gQQrZZcKjM6Quxv7UYdRGwLzWeNxKBhF46ViFTLndb8WNWMV6cZoYAsi/BLDy5ANqLUxZFeMIknN8vcmfGrQRaHweASra+127zQGEFZhENIZ8AccDZy+lEqoYBgLJjEJBgK+2yP//QVqywSigJogG7WyUYdL0f3CWFHqW5rDBnxwJL1HDlnCYNY7QEqD6a91g5286g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kvizAgn+9bzjdo9wRUlPWvVn6aQVpT0+9w3apzZK10=;
 b=RQp6r/nsnSLMgpXP4ZhQqurjVKPX9Snh6pH1yDxoYiK0C1UWpCyccTIxVvQpOdlzzbyAx7IQT5rbobhmUTgnHdURy9C4JNNy0S8owZ1raBmIt9XCOJyzZJI6IGW+oOC1ijmWjjWInrGndePZWNVVzCk2HIe3F45cQ/LyKzT0TjUwVVajs6upTJ2LdcEJIZqIUWRoxnWzyY7ByOWlk4/Hzf4nj79icd4BeeeGCYS8ZmlFQIAM56nNQuSXsY/H6THWxF3xti1xkoaVmVIAQ++kktvsRQqXmmpbfT+dPHwbjW9fp+0uMsutNCKwhYiFxZj/g5ggwp4wzyJZFJnUT09pRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kvizAgn+9bzjdo9wRUlPWvVn6aQVpT0+9w3apzZK10=;
 b=GFeXppsWZ64ulHXJ+SMQa62/+WoayGfI4JE4skq4LFLydVV7P3/RE0pNvHxgEA5EPwXKkJWlTv5dUgvGwPlRfAC4WDkywM3haghypfk2E8+QJynrt19olfvXDVpHkAK8Hz+UIHQ4MF43YgC0UtZiVl6sReno1zqxDJSJ1BatV/jv3da+BuNUlCKs9MNbdREirDS175MlFAt/oXLiLmHFh92VX9HUCmgOZHOp5pSEXScGvbt5cEJ/4YidaDo83jdjOs5F77pccSZL312XMtWqtsmZ0R8OwSSmdlC29a+UAFI6fcuqZiAs6ppwq18Tt/mj6Sj5GyEkOI8mEIPoadHnVQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6822.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Fri, 16 Aug
 2024 12:42:30 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7849.021; Fri, 16 Aug 2024
 12:42:30 +0000
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
Subject: Re: [PATCH v3 09/10] arm: dts: k3-am625-r5-sk: Enable DM services for
 main_pktdma
Thread-Topic: [PATCH v3 09/10] arm: dts: k3-am625-r5-sk: Enable DM services
 for main_pktdma
Thread-Index: AQHazpb2zuIlszWTrkaEBHUzxbwphLIqFlMA
Date: Fri, 16 Aug 2024 12:42:30 +0000
Message-ID: <b137fd601dd37ee0ebdb9e31129c4c8bae19ee2a.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-10-c-vankar@ti.com>
In-Reply-To: <20240705045030.1141934-10-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6822:EE_
x-ms-office365-filtering-correlation-id: 07e284d0-f116-4d9c-7e1d-08dcbdf0e484
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?bkZpYTJsUkxTTzE0SjBITlhpOFl2WTk5M202S2FBY2p6aGcwdTdCVEtkc2w0?=
 =?utf-8?B?MUtZbE80RjIwODM4U2VHd20wQVVoVExVMFhrV1E2VXBXTlJGSVNtOHh4c2Fq?=
 =?utf-8?B?dTRwNUpGbnB3Ny93Ky9DTm9jcUZ0M2t2cENDVnhoTElnd1ptSFRGUDdJN1Jr?=
 =?utf-8?B?ek9oc0l5Qk1rU0ZTVnVGTzRFNUpqVmJCUjZYSVBHcnlYcXNWdHZQdGtoNXJj?=
 =?utf-8?B?eU80UUhjbStlVmNkV05KdXpJZDdiTUZLb2lKd05VWnV6cDcwa3dGblF5YVdE?=
 =?utf-8?B?Y2x0SEhpa3JuTGV1VGhuYllXZ0NXME1oTGQyblU2bWxaaVZ4cU5hUElna2NL?=
 =?utf-8?B?cmFhQXJORDczSHZORGFVR3VtYjFtdnZhMnFhU1ptR1QzaHFiUU5SNjBuci9u?=
 =?utf-8?B?TTdVejJKZS9oWlpUQXg3ckkvbEk0U2VlVjhMc3FwN0RzdGVJa2FTYWZydStJ?=
 =?utf-8?B?MytVaWgyRGczV1Zua1VEMm14ajlXRXQ2UkNuQUcwM0V1OEFxQ1p3QVg0YjlZ?=
 =?utf-8?B?RWdaclRmMDhPaVo4dmpneUd3QzRUS09NLzdVR0pMU2o1RG1kbW9hcklMZ3Vt?=
 =?utf-8?B?cFc4V1Y4R1dEL0ZIZUp4L0xraTBzZTMzNEFoaGV2TUM2ODdwYUdCcnZ4SVNN?=
 =?utf-8?B?NG9uTTk5UjZxSnFWTWJKbXV1ZjBCbmJFenYzWFA4N3VQYlltcisvT2VVSDYy?=
 =?utf-8?B?L2JlU3Joa2RsMUdjY0tobGN6bHRiMXRlNUk3b1ljd2owNEttREQ0c3hvaU1x?=
 =?utf-8?B?azZMTnYwalFmaHVRMHZaaG8vRlJzakFIWlJUemQ2WEkydFFJQ0x1TTluNWpW?=
 =?utf-8?B?NXhIZ1U3a2NFb29NeXBuZndUNjBuWXF4ZDRXVjhWd0NEQW1LSitQSzlOK3NE?=
 =?utf-8?B?c1hLTEdrc1l0TlJ6WDIzSkdzS1M5d2QxenY1ZGZZL1F6amczLy82ZXRUVHRI?=
 =?utf-8?B?S2RtNXZOckRHTHRVRjhpbVNUZDdHcWNRczlMQWJtODNjYkVQUHBYL2sycFk5?=
 =?utf-8?B?dmlXOTFGWE5HUXh0d1NqL3NOK1ZRaEFhajk1ZkZ3bXBLNHc3ZGtOeDVLdHpr?=
 =?utf-8?B?TGNTZ0M2OHdpd2dZSEgycktsRVJ3RUVyWHIycEl4VTdnbVdNWDVxK01Pa1NP?=
 =?utf-8?B?QjdPaTM2QXU3alpxNXNhVVZXeldGZ0l0cHdqMytncWo1VktGc0liRlkxc2hQ?=
 =?utf-8?B?bzhEZnk2Z09JdlE2R3M0MzNVb2MzTmRuNWhHUGhETUFPancyY1diUm4ybkN6?=
 =?utf-8?B?L3RtVlJxTHBmWnRGN04vRE5ZUUpwc1Z3a05HNTVsQjcrUEVVQmlKa214U2Jr?=
 =?utf-8?B?UFJmb0NVRVNCMmZQVzlBSndhalpNdTExTDNKalVPaEhxdlpoSDVaNE93ZzNO?=
 =?utf-8?B?RWRBaEVYaXI2dGYzUE1FSzIrNlE2NjRBTjdIMkhWKzZuZ0w0bUJnODJJVUpO?=
 =?utf-8?B?K1JCNXpIKzREaVdUWklGVStDZjVmQVY3SDdJRElxYVNydmEyK3VCWmIrVjZi?=
 =?utf-8?B?Z3hNc25TRnNMUHJLNVVyMTh3VUVYWGtIbmxQaG9iZ1hwRDZDVFQ4OTFnWmR0?=
 =?utf-8?B?NzFxOHhNUDRiMTd5YnFDdU05eFlPV1dXRVp1Rm1nMFFYS1VHcGRXK055b2pu?=
 =?utf-8?B?eEllcVJDcVY2dk01KzhoY0dQNDJucU9RMzc5Wlg1elBRaEsxL0FrVTkwUk1m?=
 =?utf-8?B?a2QyKzFyNG5iVitvUytwcFJsU0hXdmRmQzg4aFJkcGNXOHRNWFhYcjVzRU5v?=
 =?utf-8?B?c2xEQUZzRUMwTFNqRGI3UEtjUmJYMmJKR3pZMk9MVWdoTEVhQ0ZCdm5jZmRr?=
 =?utf-8?B?cXgxekN4RWcwYkUzSzJLVE9wSTZBcDlEMEp1c1kyc216N2YwaU0xaTVsNzdu?=
 =?utf-8?Q?RwFdZJHKfTSZx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzRvYzNucHJ4L1MwdXpzemYwTC83WkFLNDZmeVJ1Rmh2SDloa0xUTHRTeDNw?=
 =?utf-8?B?a1BYa2l3d0hzQzNFMlRSTnFZY0kxMW1KMjNIZDltNCt5c2tVeFk2bzY1d2p2?=
 =?utf-8?B?NXVVVCtMR2M0K3dJdmF4bHVlQ0wvZkhKVTFRSjVlRWZsdnY0WU9vU2hvTEsx?=
 =?utf-8?B?bEYzc2d4RkM5WW53ZU9VM0NXaXhtbVE4WG93dWV0aldKTVFFSXhDc2s5ZUtW?=
 =?utf-8?B?SWNQR1NNUFBieXZXTEo5UDBjd2wzMkhvVnRXR3BIeDRiU3l2S2EzRTRZTEtN?=
 =?utf-8?B?NUc3eVdQazRzbUNKN3g0a01ueUdsVjBtZVJHMFVPZnhCOXFiMmlYM3gzNWFt?=
 =?utf-8?B?b0J0WGRjVURVVlRYaTNmaW9wdWVkVko5MTMzQTNIZnIzMlJNc0F4NzhHdDhX?=
 =?utf-8?B?Rk5iMFJmN3F4Z1NkVEpSS1lNWjVFalpyL1NkOUhkck16dWhuNDlEN21PWmtD?=
 =?utf-8?B?NmRVM3lPTUlQR2lGS2FoQk1LTEtEQkFZRmJMWHVlYTJqa2V3SVl1UkxmMVo2?=
 =?utf-8?B?WllRL1BuYmVFRDhOU1lldEpQYWdaRDhrQ2FvakJ5M0RHcFZYOXNiRlM2OHpw?=
 =?utf-8?B?VDNMOVp3eHRNVnJGRllJWG1SWm9YR3VTU3lVQkV0UlJ2dzUyYXdsQ3RZKzdk?=
 =?utf-8?B?ZXdvUlkrWFBxUHM0ZXhENk5CN245RVRqSStocHMyWGx2UGVDbS9MaGlIYklj?=
 =?utf-8?B?NmQ4eC9wY1VCRWlPRzNDTVpzQXRxSlJSUnB2V0R1M0pHcGJTMkZzUkNKRDdh?=
 =?utf-8?B?VTdMRUtkRzM3UmNYa2dCY2RvZ25Zbk1nYjVXKzByZ2tJMlZOR0ExV0Fya1Fi?=
 =?utf-8?B?NHQ4RHhscXc3K0NseW42M3VxSlgvZjVYeWpxNjZKU1NBSzNrOWVoUGY1bXRM?=
 =?utf-8?B?MDN5Q1MvRUFUbFdGRVljallGbnp2YW1tUXZRZGU3YzZ0UlRSVXd3RFBsbzZD?=
 =?utf-8?B?ek5OSFRFQ2JoVGsvQUdoNkNrcVhCQ3NBWlZBWUFOOEJ3b2NINkVsYkpHL1BY?=
 =?utf-8?B?TE9WNXRKem5ZTFNUZGNMVlJNa2ZlLzFpeVdsNVAzbXg0RTBWR3FiOE91cm8y?=
 =?utf-8?B?MjZoVGhEREZWV1BWcHVnL0dDK0hNdXVNeTN3dXVCM2M5RFY3YjkvUTlBR2dt?=
 =?utf-8?B?dm4rUlhCL1JFMkxFaXNWZStSMVBHeFcxeTRZSndvanRYK0xLZ0lBRFpsOEg3?=
 =?utf-8?B?cm1xMENvQk1XZUhJejRzVDROTVRVUHJvQnArRTRWbm5yMDRxOEhtdGwrSDln?=
 =?utf-8?B?RXVqY1J3dk1JeWxPcHFwSkdWMjdzckhidHJ0YzExS2pvazg4bkVsTWxrYy9O?=
 =?utf-8?B?bkNLOGlwb3lZN1dyb1l3QjRKVE41YWo2VFJnV2t4OFkydVcydTJraXdHMUpZ?=
 =?utf-8?B?Z1FsOGVoSkppVmZtWDB5Z003ZVJiMnk2eCt2enNaSnhZWTVXQzVWekxTV3B0?=
 =?utf-8?B?Y3V5eUxURXlFdEpmN1EwMS9MTjNyWEZwWXM0LzZoRnE2R1BFb2hNNUdOa2dI?=
 =?utf-8?B?M05iTVQyYjN4WjJvRDR1NllJc2RjWUpyNno3K2NsWnhHRXc4cVJGRDVBYWpS?=
 =?utf-8?B?bXVwUmowdDhXM3hmUFcybUNkTllTSjZhcFNWK25BWUlpYXRRMXVYdXFQczhv?=
 =?utf-8?B?L1NBSFprZDdLWXg1aDNYNVFUdkhYbDJzMEpiRzVOQUxVQXEzQ0g2UVVFNzhL?=
 =?utf-8?B?bDdPUWNZRUpXSFExRmV6c0QrSWU2cTVjUmhKV3dOM0wxQ0k5TmM4UGhmRlow?=
 =?utf-8?B?VEtST0lJcUVCUFo3ZDFLV3o0bWltTy9FbnNTWkZoWHBzTjVxaHVkNWJrcTJm?=
 =?utf-8?B?NHZwU2UyeXFINnN0MDQrUUp1dDJGTG9RMTdoeUFkQjNWeXZTR2xneENrOEJm?=
 =?utf-8?B?dGtScE85dVEyNGkwb21WZ1ZjUHRwUTB3ek9QUUk0RFFlSmFyeDN5djJIQjdi?=
 =?utf-8?B?ODdySVp2UmxnV1VZNnE0M1AwdE1wOHEyTWJMckdyQk56bHFxOGFUVVdESHlY?=
 =?utf-8?B?blZzQ1NOcndQUE1xRGZxTjBldEl3bmxud2FzR0ZWcFNMeVJnUkQ0TDc5d1RG?=
 =?utf-8?B?NDFITTZOVmhHRXQzM1pqU3N4ZlE5WmlBbnNLSkFySzNQOE1VUXhFY2RSckY0?=
 =?utf-8?B?VG5LSjAvUWtTT0h2Z1JaQzJVcm9XL1NoVGg3SVJJeGQvNjlYV3dWMDdyU1lu?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0A13F2B7E8BE74598EBC503A2B582DB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e284d0-f116-4d9c-7e1d-08dcbdf0e484
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 12:42:30.2901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPsC+ybsk6pQ95EPobdm/fsTfIFDM76cIzv/1vCo6rGOHeIm1EPv8qNKPF75+rB8KTy22Sq0F5I68yY/g6Q0eoMa1uIdvzhy5D9hi796V9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6822
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

SGkgQ2hpbnRhbiwNCg0KT24gRnJpLCAyMDI0LTA3LTA1IGF0IDEwOjIwICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gRnJvbTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFsbGlA
dGkuY29tPg0KPiANCj4gRW5hYmxlIERNIHNlcnZpY2VzIGZvciBtYWluX3BrdGRtYSBkdXJpbmcg
UjUgU1BMIHN0YWdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8
cy12YWRhcGFsbGlAdGkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGludGFuIFZhbmthciA8Yy12
YW5rYXJAdGkuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiBMaW5rIHRvIHYyOg0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwNDI1MTIwODIyLjIwNDgwMTItMTAtYy12YW5r
YXJAdGkuY29tLw0KPiANCj4gQ2hhbmdlcyBmcm9tIHYyIHRvIHYzOg0KPiAtIE5vIGNoYW5nZXMu
DQo+IA0KPiDCoGFyY2gvYXJtL2R0cy9rMy1hbTYyNS1yNS1zay5kdHMgfCA1ICsrKysrDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2R0cy9rMy1hbTYyNS1yNS1zay5kdHMgYi9hcmNoL2FybS9kdHMvazMtYW02MjUtcjUtc2su
ZHRzDQo+IGluZGV4IDZiOWY0MGU1NTUuLjA5MTJiOTUzZGIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2R0cy9rMy1hbTYyNS1yNS1zay5kdHMNCj4gKysrIGIvYXJjaC9hcm0vZHRzL2szLWFtNjI1
LXI1LXNrLmR0cw0KPiBAQCAtODMsMyArODMsOCBAQA0KPiDCoAlyZWcgPSA8MHgwMCAweDBmYzQw
MDAwIDB4MDAgMHgxMDA+LA0KPiDCoAnCoMKgwqDCoMKgIDwweDAwIDB4NjAwMDAwMDAgMHgwMCAw
eDA4MDAwMDAwPjsNCj4gwqB9Ow0KPiArDQo+ICsmbWFpbl9wa3RkbWEgew0KPiArCXRpLHNjaSA9
IDwmZG1fdGlmcz47DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQoNCi0tIA0KQWxleGFuZGVyIFN2
ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
