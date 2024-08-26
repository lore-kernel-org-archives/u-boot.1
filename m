Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A16BC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 678D0880DB;
	Mon, 26 Aug 2024 08:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="axMtjxFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4814587E9D; Mon, 26 Aug 2024 08:11:23 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42468881C
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvtmSF+VHb9f/x6yNyzH0tRs4DeqVEwYou2FdRR6eB4eyLFhxag2NEwZWaWUHtmC4jUKfzRa7+ZsBS8ti13Us4uLYhKyP/rDdw+BVJ4zLO/IptKFlEtLvPKA+cgcDt5ToncCBaVQ6MMyYsYg3fQXQzyQc150VQajkLuCXFUV9H+YKbOgX2/LY7episq0mhiGxnnw1yPDzbz4BxT1dKOHahp0SvsGPNYdr0S1kjmr/vTaLlaNIORWxzQX+m90oZAyD3PNM6l6ewdwqrw5l52gK4Xv/JQzM90FE/n3MqKZa0L3f9K8O3Gyv+UyLI9p6PZ8AMuZE/ffLAhArb57Bd1e7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pht9dmS0xwlSGl+QNYOXgVRR20R8+a87Mtrp+S4b/g=;
 b=BzyDveiR70+cPtF+14jcZRvJc6c+0uq7Olmkt++BWmFcCi9I5N00bQBmVL08LQjtD42tcVXtYrRO7foOGTMwxeIjUvgYb2Dv58Gg0B0ooUP7/fohIwieUO/34+DboI1Xm2YnBYt/S9UWbm7xgUHYiQUeqVpZCKoAkEV/07NEL9mA3qt4BH9lcyOmqXobv4urY7GBkMLQOJ/uESjzV8tLf49RJcFtq3woMSNgIQ/3hIKX+FjTIVGdIoXQQi01VPKSw0zBWWLhTHY21XkErxoFHomaKz6VxArQCEqA/bvuHBTWVfRo8mBeqz1JiocIgLTYdlr+Oe8jOyDavWblAatZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pht9dmS0xwlSGl+QNYOXgVRR20R8+a87Mtrp+S4b/g=;
 b=axMtjxFuXHCjfduYpCZwe/2qFh4Y5fEO1BNWQZMxDaqpN58Q1T7WSzoHMQ1OWV6dVvRYZqGlSkjrkzddPkFNh4GmkBAK3cO0Ptx73GeSzEb3QbPH3OvpwM11Ch/6uc+h1EYfqs9tus73V2vVdb0VlES1QqYp+VB0bYtEpPz+1aT/4grL9RrzZhUsQQFKDfVhsHIPdA+e1pB4UZ0W/AJtj12e0jzKzNuuRka6FHrZhPTg6RgFjDv4D9XKPABH9CtTBs52Hxay02wDhPOxwMnY1AB7yuvkQ6lOFHjXo+dEZsCABEPM4DB72KBmSrsDkjQlydP9WihwJJgoEQOsnigeNg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 06:11:16 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 06:11:16 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "c-vankar@ti.com" <c-vankar@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, 
 "sjg@chromium.org" <sjg@chromium.org>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>, "n-jain1@ti.com"
 <n-jain1@ti.com>, "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com"
 <afd@ti.com>, "mripard@kernel.org" <mripard@kernel.org>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>, "d-gole@ti.com"
 <d-gole@ti.com>, "danishanwar@ti.com" <danishanwar@ti.com>, "devarsht@ti.com"
 <devarsht@ti.com>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "jonas@kwiboo.se"
 <jonas@kwiboo.se>, "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "bb@ti.com" <bb@ti.com>, "kabel@kernel.org" <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Topic: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Index: AQHazpbuejjhjHLwGkeXHNStsrwvuLIqEmAAgArU6QCAAAs0AIAER44AgAAmSoA=
Date: Mon, 26 Aug 2024 06:11:16 +0000
Message-ID: <1fe417023997ae87da4bbe22ec4c73590df5c7a8.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-5-c-vankar@ti.com>
 <047e9aff7ac10f52cd3afb052da6874eb4ebbdda.camel@siemens.com>
 <d9419b64-a2c7-4f73-b401-4f2e71a6bf40@ti.com>
 <9328c6779d5c4bfecf09708e854aad5adac79861.camel@siemens.com>
 <7524f32d-d420-4a76-85c9-f84f7bb7b5e8@ti.com>
In-Reply-To: <7524f32d-d420-4a76-85c9-f84f7bb7b5e8@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAVPR10MB7035:EE_
x-ms-office365-filtering-correlation-id: d220f8a0-9e0a-4b19-8317-08dcc595e559
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RzZYNW9JZ3pPWWpwSVJ3VGVNdjZqSWdtU0c1VFgreXJoUC9keXo3WEJ2cU9I?=
 =?utf-8?B?TWdDcUJlcTBMMTg1T3F4eUl5SnBPbDlIOGlXcFZaZXNackkwWnVmdlFLaHQ4?=
 =?utf-8?B?WUZjTEhBTXUxZnYyRDN2L2s3anVWQjF1YW5lVnZYNHVFb0pJcnhGdTlxaVVO?=
 =?utf-8?B?dndKZElrbkx1eVYxeXl4SGVudElieUpnRlBDU3NQRXZjeTJ1K2R4MFVzYjRo?=
 =?utf-8?B?VWczMi9xN2VVNlBKUFFIWklFNHNqWC9seDYxV1ZFUlM4bjRKV1RNdWVYZUZR?=
 =?utf-8?B?L3lDVk9tTlM5ZElrWUhJcWZYeThoN1N1NFQwSGU0RFBhRXhlOGRRWjdmNEFK?=
 =?utf-8?B?YkJGWndRMzAwck9SK0hnak1BZUJnVHlHbTdmYm8yY1pMdXFVblN3WXk1THdw?=
 =?utf-8?B?d09QMzdMckRyZ293UG5EaVl3T3M5b0Z5U3RBNUF5ZGZZc1oxT0U3ampkVC9J?=
 =?utf-8?B?bWo1MmRmb0VyTWtPTzEyNFBYa21wNXI0bHdSYlB3ZmorSlcva05oNzFLbXBE?=
 =?utf-8?B?cEI2WnN3SVNLVWVYVGpPYlhhZ0pTdENJTHJ1akhQL2l1VklUb1BNdnB3N2tG?=
 =?utf-8?B?aklvcTBRTG1lOC90TllMV2J2c01VbXJDWEZ1dWZ5MVFZTUJBQ0ttZ1pWbHZi?=
 =?utf-8?B?RStObWp2QU01VFlrTk1nRWhVKzNTaURnWm4vb214dXMrV3pFeldzNmpGUkIw?=
 =?utf-8?B?T1g4dHVtYnphTTJ4MFJPcFdLRVBKSXhtOS9CVmo0YmppaS81c0MyNzV5WnBt?=
 =?utf-8?B?SzJGblpjZlJmdVBhQUpPeFhVRk5TQmlUWjROajRpK0h5czZ2R0JoTXpNTVJD?=
 =?utf-8?B?ODc1T3gxMEdtNG9zQUVjUm1wWTBJTWdKZTlac21CUm1ENkE3amF2Q1hXNWV4?=
 =?utf-8?B?bzhUem1Ka05HVm50R2lvdllNZHRFT1Y4TUJ0UnlxNVNod2x2QnNIU0hrVTBO?=
 =?utf-8?B?VzB5RTdIcWRINXBsOWdGZlh0cFVqa29kelZ5bnZrNUpwRm9zTU1nd2ZBL3A5?=
 =?utf-8?B?clAzbGk0aTgrNC9nVGN6Yk9hV3gxNWpYb2JQUWl4Vy83N28wbW5xOXBUR1hR?=
 =?utf-8?B?TWViUmtoN2pKYlBrcThJc2dpczRobjE1NkovVEV6SUJnVDh2UldvUzhFR0JB?=
 =?utf-8?B?Wnp4T1pOMkdSU0RYc3l0UXNrN2xGQTRYWWxtUDcvSkc0MGFFclV3dFNobm9W?=
 =?utf-8?B?QlRjU29tTlJtOWY2Tm9FU25kbUpDWjhENktIcDlldnZLd1VKd0M2L0hXUmwy?=
 =?utf-8?B?ZGcwNDI4VkdWeXpOUzlPVXUvb0p5R2pvKzJuZVc4bGovekIzeG1FWEtsQjda?=
 =?utf-8?B?aGtiK3ljNU9UUFZMN1p4ZExJT2RxTUpqS2Jxb0luMUR3S0RtNkV6YmNQOFZk?=
 =?utf-8?B?bm81WGhaaCtVQVVBLzlBeXZwaDZMSGdGdzA5UThWOWNnQTVHK2NoT2w1d2V0?=
 =?utf-8?B?VVh2aXAvcUJZbHNVd01NZHFMd1lQRkZCWDlDU3hCczBXU2pPWTFPZ0VqMHlp?=
 =?utf-8?B?aXhkSEhqTnZWcEo1UXN0T3NqTnFZbEE1dVR6aG5TR0JhWUN1Uk8rdGhMb2hZ?=
 =?utf-8?B?Q2NTQVdaN0VUUGpETzBlNitxTmg2bG4wMThHdmN3OVJZdDNCUzlNT1JjbjBS?=
 =?utf-8?B?TDM4cGFaZkNkdllwWk41UU4wdDRzeEQ3Rm9MMHE4SXY0ZVI3TXdhSmdkcjVL?=
 =?utf-8?B?ZlBSWlVJcmZHUXd2Q0h5VjRKTnBXRmZTYUcyeEVoYXcwdy9UUEp5ZVNIKysz?=
 =?utf-8?B?d3MweEVtOU1lWXFpQ2I1c05pUnB1Y0dDRGtMaDkzcmJmZFhJSFVQNEhmQ3Ry?=
 =?utf-8?B?Smh3U0tiMXRFM0pyWDcwTnpVU2ZQQkFjMVdoekYycit2aEpaK0w4S05SMlE2?=
 =?utf-8?Q?+1KQ1yeSXqx7r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3lPd2NoL2tPeUgrbUtEQ21RUGtNdzgza1ZwUGxwbmRPbWxjd3dpekI1dVZS?=
 =?utf-8?B?cG0xQVpVUktKZXRQbG5vTHhnbjJCZnBtbnYzWVJBWm5hcktnVHBtNzNXeHV2?=
 =?utf-8?B?dFNveVRkNG4ra2V2YW05dmErdHlzTTd6SnlQYkticVowdllobFo5Q20zMklK?=
 =?utf-8?B?Q0orcUV1YUExWnVxRHZPZGxCSjk5TTZycXhHdGoxQWpiUC8yczJnRjRzVm53?=
 =?utf-8?B?bDBJeE1kQmxyUVRqSDRFVEEzc2RxTzg2RSt0TWNyVnpJdlFrcXNONFJUdTZL?=
 =?utf-8?B?Y3BSWE4wOW5hSFFYMkVjRHpmMk1yaFJFdDk5TGFqamU4aEl2SWlJaWpRNnlM?=
 =?utf-8?B?UXhjN1ZkZFl4WnlJWUdDZjY4aVR4RklRNHRnd2srZzFHeHVtVzlEVnhoOWVx?=
 =?utf-8?B?WFFabU54MVlTai9mK3M4NTZvb2hIZUV1cm9WY215MUIvS2hQZ3M5aVB3SGY4?=
 =?utf-8?B?SlhTL2pxR1B6SEUrUVpxMU5NamN0Z1JHQVVHN3ZnOHZmNWEwRWIxeGFwRndT?=
 =?utf-8?B?bVR2d1o4QTZBR0tnUlRxVVkwTCt1dkVEc1ArRjlqZXNBK0VvcW9KNnZkN0dQ?=
 =?utf-8?B?T1pqRDhpcU9LdzZ6ZjJWWlR2UXlsbmV3QVVUUjliL2FoUUFQTiswUStSWXNU?=
 =?utf-8?B?Tkxqa3pRdmEyR3NoU2E5V3hKdEhoNTkyR0h4RHNDWUlKYmdxWCt4M0xpdGFp?=
 =?utf-8?B?dXlWWnRGcXVBQVJpSXE3blRiUW9iT1RMZk92T1pBNWQraHEwemFTWjZyYjdt?=
 =?utf-8?B?VjBRZldTUFprVDJLY0M2UFFvc09xcVY3dmJ5UzhWSjExMVhqZCttdmMvZHNU?=
 =?utf-8?B?SzkxOEluOWN1bFJvTDVBc1pXS1RoNkwxS21vNHU5T3lTZStnK2FVT0wyNU5r?=
 =?utf-8?B?R0h1RHJ2b0g3dmxNbWF6bDZHc1c0UmNXQ0U3WnlwN2diNlFzWG9UbDhIS285?=
 =?utf-8?B?WHVNNmU0WHVCQnJFQ0dNa2NPQWFUbzYxLzNjazU1UjVUL2hGNGNzdGZ6ZFlo?=
 =?utf-8?B?RnY5N2tOWXRZc3R2djlQR1pqVEJvUm9LcUFqbkJHSjd5c1pjVTNyRjFQUHRX?=
 =?utf-8?B?R0J2Z3hQbGduSmRUaU14ZGNwWHhjbEVKMlhhMWQ1SmRxQ3FaSVl2Yno2KzlS?=
 =?utf-8?B?ZTlGL2lsMktzTzIwT2gyVHNwMjNJaGFLTk1QUEhCMHZqeVI3MDk2R2g4WEhh?=
 =?utf-8?B?K1JLN0ZzYVBCckxFWmJxUW80R0p3bWEzdmhkOUVOZ0ZPMEd3eGxrUTVjTjZt?=
 =?utf-8?B?MG5jT0NDbVdPUEdSd3NOY3k2T2VydnJuOXdUV3JHaERid3NuVTQ0aVRwVFNs?=
 =?utf-8?B?YWt5ZGNmdnoyWmY3aHdLVEtJS1ZCY0JRMVJDTWpEaGQxTTVGU3VBZlpyV3Vn?=
 =?utf-8?B?VHpnOGJ1OWFDSDBlenpjUTJVUk1UdDBFZndNdG1aUkMzRnhGdVpTdkJJVnVh?=
 =?utf-8?B?ZHhhZTRQWUo2RCt3QWtDUmJveTdtSzFCaFUwTFV6M3BSSEx0OXl5Zkc5YXF3?=
 =?utf-8?B?STN4WGUrdW5PRWhrMHJXeEV2VVBXb3BPK0s5b3h5ak42dmx5ZGtLVUlUTEVq?=
 =?utf-8?B?Mm1YRGJISGNNdjBoNnJpa3lLc3g4K2xENkE2b1E0ZzRwQjNJdW5UTFY5QVpk?=
 =?utf-8?B?T3o1RlR1bHZYeVBCeUE2bXJWbFB0VjQ4T1NROXg4ZDF3WDNJVjJtQ2w2Tmxk?=
 =?utf-8?B?bURmUGhGZ2JrQXpmazhkSnBBcVNvNzltQ0hWT2pYc2NnYUNQSzVYcEkrbmZI?=
 =?utf-8?B?bmYrQzVDUWdYZ0JjMlpmU1hMZ3FhL3hzUkRrQkw4L1l5dThCMG5CdkNJMTRa?=
 =?utf-8?B?WERDSFo0clhoVUtCSTd3N0pnbitQNm9BTXE3YUt0UVdxMmhWS2Z1N3BkaHBL?=
 =?utf-8?B?TjdFd3VrczJJVDB2anBEUW4yUW9NNmlzR2J4T1RYVmpIRnFra2NVV2xNeDg0?=
 =?utf-8?B?TjZvZnZaMHdOOUZTTVQxMTB5YTRnelBERDNnUGtGclBEZXFlZVoyTWFYZGpy?=
 =?utf-8?B?dkx2bndIeEM4dEx6Tmt2TjFKU0g5dWRqUE1WTVFIbEtJNmwvMStDUTBIRkVq?=
 =?utf-8?B?NWFkK3dxRldKNlJrUlhSK0hzYlJYUlBzVXBwR1ZxMGVjaTVHemZsVElkakxW?=
 =?utf-8?B?UmQ3YWowcXViVDV4bWxLTjZJZExjekRoRTE5dmNpTXZmUHU2cDJ3U0lpaDVr?=
 =?utf-8?Q?yKYXS+fdJ95VU6aHsUsTbz0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <626CFA0F08A56146B7D55952FC852211@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d220f8a0-9e0a-4b19-8317-08dcc595e559
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 06:11:16.8366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n4ElEVkdntuqSt9nfnFFZ9KxVrdqPrSeHamrpLBI34XQg3lDgTSmzUl8scZChkTyKbesGGSBwXaknd2U817bhsADgTTyOBDeVOHdfhfVsik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7035
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

SGkgQ2hpbnRhbiwNCg0KT24gTW9uLCAyMDI0LTA4LTI2IGF0IDA5OjI0ICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWdu
ZXNockB0aS5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRXhwZWN0YXRpb24gb2YgazNfcmlu
Z2FjY19yaW5nX3Jlc2V0X3JhdygpIGlzIHRvIHJlc2V0IHRoZSByaW5nIHRvDQo+ID4gPiA+ID4g
cmVxdWVzdGVkIHNpemUgYW5kIG5vdCB0byAwLiBGaXggdGhpcy4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBWaWduZXNoIFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+
DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2lkZGhhcnRoIFZhZGFwYWxsaSA8cy12YWRhcGFs
bGlAdGkuY29tPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gVmFua2FyIDxjLXZh
bmthckB0aS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTGluayB0
byB2MjoNCj4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwNDI1MTIwODIy
LjIwNDgwMTItNS1jLXZhbmthckB0aS5jb20vDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ2hhbmdl
cyBmcm9tIHYyIHRvIHYzOg0KPiA+ID4gPiA+IC0gTm8gY2hhbmdlcy4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiDCoCDCoCDCoGRyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdhY2MtdS1ib290LmMg
fCA5ICsrKysrKysrLQ0KPiA+ID4gPiA+IMKgIMKgIMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jIGIvZHJpdmVycy9zb2Mv
dGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYw0KPiA+ID4gPiA+IGluZGV4IGY5NTgyMzljMmEu
LjVkNjUwYjlkZTcgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9zb2MvdGkvazMtbmF2
c3MtcmluZ2FjYy11LWJvb3QuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvc29jL3RpL2szLW5h
dnNzLXJpbmdhY2MtdS1ib290LmMNCj4gPiA+ID4gPiBAQCAtMjUsOSArMjUsMTYgQEAgc3RydWN0
IGszX25hdl9yaW5nX2NmZ19yZWdzIHsNCj4gPiA+ID4gPiDCoCDCoCDCoCNkZWZpbmUgS05BVl9S
SU5HQUNDX0NGR19SSU5HX1NJWkVfRUxTSVpFX01BU0sJCUdFTk1BU0soMjYsIDI0KQ0KPiA+ID4g
PiA+IMKgIMKgIMKgI2RlZmluZSBLTkFWX1JJTkdBQ0NfQ0ZHX1JJTkdfU0laRV9FTFNJWkVfU0hJ
RlQJCSgyNCkNCj4gPiA+ID4gPiDCoMKgwqDCoCANCj4gPiA+ID4gPiArI2RlZmluZSBLTkFWX1JJ
TkdBQ0NfQ0ZHX1JJTkdfU0laRV9NQVNLCQkJR0VOTUFTSygxNSwgMCkNCj4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gwqAgwqAgwqBzdGF0aWMgdm9pZCBrM19yaW5nYWNjX3JpbmdfcmVzZXRfcmF3KHN0
cnVjdCBrM19uYXZfcmluZyAqcmluZykNCj4gPiA+ID4gPiDCoCDCoCDCoHsNCj4gPiA+ID4gPiAt
CXdyaXRlbCgwLCAmcmluZy0+Y2ZnLT5zaXplKTsNCj4gPiA+ID4gPiArCXUzMiByZWc7DQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICsJcmVnID0gcmVhZGwoJnJpbmctPmNmZy0+c2l6ZSk7DQo+ID4g
PiA+ID4gKwlyZWcgJj0gS05BVl9SSU5HQUNDX0NGR19SSU5HX1NJWkVfTUFTSzsNCj4gPiA+ID4g
DQo+ID4gPiA+IHNob3VsZCBpdCBhY3R1YWxseSBiZSAicmVnICY9IH5LTkFWX1JJTkdBQ0NfQ0ZH
X1JJTkdfU0laRV9NQVNLOyI/DQo+ID4gPiA+IE90aGVyd2lzZSB5b3UgY291bGQgcG90ZW50aWFs
bHkgYnVtcCB0aGUgc2l6ZSB0byBzb21lIG51bWJlciBoaWdoZXIgdGhhbiByaW5nLT5zaXplDQo+
ID4gPiA+IGlmIHlvdSAiT1IiIHJpbmctPnNpemUgd2l0aCBzb21ldGhpbmcgbG93ZXIgdGhhbiBy
aW5nLT5zaXplIGFuZCByaW5nLT5zaXplIGlzIG5vdA0KPiA+ID4gPiBOXjItMT8NCj4gPiA+ID4g
DQo+ID4gPiANCj4gPiA+IEhlbGxvIEFsZXhhbmRlciwgSSBkaWRuJ3QgZ2V0IHlvdXIgY29tbWVu
dCwgY2FuIHlvdSBleHBsYWluIGluIG1vcmUNCj4gPiA+IGRldGFpbD8NCj4gPiANCj4gPiBXaGF0
IGlzIHRoZSBleGFjdCBwdXJwb3NlIG9mICJyZWcgJj0gS05BVl9SSU5HQUNDX0NGR19SSU5HX1NJ
WkVfTUFTSzsiPw0KPiA+IFdoaWNoIGNvcm5lciBjYXNlIGlzIGhhbmRsZWQgYnkgaXQ/DQo+ID4g
DQo+ID4gV2hhdCBoYXBwZW5zIGlmIHJpbmctPmNmZy0+c2l6ZSBjb250YWlucyAiMSIgYW5kIHJp
bmctPnNpemUgY29udGFpbnMgIjIiPw0KPiA+IFdoYXQgd2lsbCBiZSB3cml0dGVuIGludG8gcmlu
Zy0+Y2ZnLT5zaXplPw0KPiA+IA0KPiANCj4gSGVsbG8gQWxleGFuZGVyLCBUaGFuayB5b3UgZm9y
IGFza2luZyBhYm92ZSBxdWVzdGlvbnMsIEkgZ290IHlvdXIgcG9pbnQuDQo+IFlvdSBhcmUgY29y
cmVjdCB0aGF0IHdlIG5lZWQgdG8gIkFORCIgbmVnYXRpb24gb2YNCj4gS05BVl9SSU5HQUNDX0NG
R19SSU5HX1NJWkVfTUFTSyB3aXRoIHJlZy4NCj4gDQo+IEJ5IGRvaW5nIHNvIHdlIGNhbiBhdm9p
ZCBjbGVhcmluZyBvdXQgZmllbGRzIG90aGVyIHRoYW4gc2l6ZSwgYW5kIGFsc28NCj4gYXQgdGhl
IHNhbWUgdGltZSBpdCB3aWxsIG1ha2Ugc3VyZSB0byBjbGVhciBzaXplIGZpZWxkIGluDQo+IHJp
bmctPmNmZy0+c2l6ZSBhbmQgbGF0ZXIgd2UgY2FuICJPUiIgaXQgd2l0aCByZXF1ZXN0ZWQgc2l6
ZSB0byBub3QNCj4gY2hhbmdlIG90aGVyIGZpZWxkIGluIHRoZSByZWcgYW5kIG9ubHkgdXBkYXRl
IHRoZSBzaXplIGZpZWxkLg0KPiANCj4gSSBob3BlIHRoaXMgaXMgd2hhdCB5b3Ugd2FudGVkIHRv
IHNheSBhdCB5b3VyIHZlcnkgZmlyc3QgY29tbWVudC4NCg0KWWVzLCBJIHRoaW5rIG5vdyB3ZSBo
YXZlIGNvbW1vbiB1bmRlcnN0YW5kaW5nIQ0KVGhhbmtzIGZvciBsb29raW5nIGludG8gdGhpcyEN
Cg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
