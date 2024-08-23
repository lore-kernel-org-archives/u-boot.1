Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C58C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 10:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FFD288868;
	Fri, 23 Aug 2024 12:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="M9g6wK9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A50C88829; Fri, 23 Aug 2024 12:33:09 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1BBE885C5
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1eRbbBXseFSWPUuS548ChLlqBGW+6NEHxm+hxUlgxteMCwhAh/k2AqCJXOtmdDLgBLATZM/A8hOFI7h9ql/HLUbxl9JFJoFB6PYthvu/HttfPv4s7nS6op5rojw23FrI1oxTW9mqaH0MCyJlj6UiFiKhT135rza/CNrKobP/uPGeAasXR9V1oWinWcqP9uGtt94lsA2s70fI9hDIr20Ao1SuoSdUwMJt16J5sKyNCPVNfiYvirdHR3E6V1KWZg80Ex3g9Dy2ENNentbkDyIObJM+hR+TsVfDqr5YOfbd3ZIXgJez4idjdhVc7f0mr5OH12fvtUKXJ8uKo20dpwpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow40AGZfaB70lhY1ZX6r7RlXybrbUN/BOa+cmkJIelg=;
 b=vU536IP1YWLlCqiCKwCImvI3OqPfnAAsjcUSOtiEEETfdIUMLv460fKJpQDEUOs+IbvEx4c9w2gno0H+4h+l6AmaCoHRcA09u1s3InN17tqEbor2Q+iL4Vz5y9P9vau/cmpakr1isgz7dWnsq+92Aof12JQZNnlUx8Qc41Pr6GQizpD4c8SZ8FZ1VOpVuj3RONVTBZVW0pQgDm6Y2QAZlhIGtr6MmhwriyylYmBp1M2uha1s15aoi9g/DZbsoZKZPfe6JvxuiwtrtA3W521QztBLN3UjWwiyU9+L4bM5hwlM2C6VzdbKPMdKv+tqyrXPEGe8EyqYPfEPnFNPJlNJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow40AGZfaB70lhY1ZX6r7RlXybrbUN/BOa+cmkJIelg=;
 b=M9g6wK9GpxaipUQ6o//pF3RfXLoVOR75mYThPvhsD/dSP484kR94MmUqkx5y8+RrXrcn6pTLKbP3/uu3ZKT9e+p+YIa5pu3H/AtjGakruBEWRacn0wZRsY8oDKxNzS9n92fXVnxnO+dJNNVLAoBg2aF1gYhnJMNzd41FkjT2Qt5rNKld3XVGtHX3clKiHHxj/7c2zBHCl4UbC4RQK4h2fi6sgq6iMWYV0ZCuAyA7YW1PgamzBhzZSVmZs/tAPYHik6GAzfQCf/qAh8wDvat1LsGVxsTaDPHv6hRTSGz3LTKdOv4t/NWxSCDrNlTgsnGNXzfi9letomhifxvYuZ4XUg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB6330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 10:33:04 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 10:33:04 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "c-vankar@ti.com" <c-vankar@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "n-jain1@ti.com" <n-jain1@ti.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "afd@ti.com" <afd@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "d-gole@ti.com" <d-gole@ti.com>, "danishanwar@ti.com"
 <danishanwar@ti.com>, "devarsht@ti.com" <devarsht@ti.com>,
 "w.egorov@phytec.de" <w.egorov@phytec.de>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
 "kishon@ti.com" <kishon@ti.com>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>, "nm@ti.com" <nm@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "bb@ti.com"
 <bb@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, "kabel@kernel.org"
 <kabel@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "srk@ti.com" <srk@ti.com>
Subject: Re: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Topic: [PATCH v3 04/10] soc: ti: k3-navss-ringacc: Fix reset ring API
Thread-Index: AQHazpbuejjhjHLwGkeXHNStsrwvuLIqEmAAgArU6QCAAAs0AA==
Date: Fri, 23 Aug 2024 10:33:04 +0000
Message-ID: <9328c6779d5c4bfecf09708e854aad5adac79861.camel@siemens.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
 <20240705045030.1141934-5-c-vankar@ti.com>
 <047e9aff7ac10f52cd3afb052da6874eb4ebbdda.camel@siemens.com>
 <d9419b64-a2c7-4f73-b401-4f2e71a6bf40@ti.com>
In-Reply-To: <d9419b64-a2c7-4f73-b401-4f2e71a6bf40@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB6330:EE_
x-ms-office365-filtering-correlation-id: f5294a5c-b8e8-4a78-d705-08dcc35ef89c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?elZhekNzWUJycmVTa2M5Q2xrb1hWUUU1TkNIZDR5T3ZCTU1kY3NYZDZoMjdC?=
 =?utf-8?B?UVlJZ3NOU0FNNVlVcnBJR25iMHVFS2RPejJsN1FDYVhKSXVVMGFwTVFldzBo?=
 =?utf-8?B?L0hERzZEMUlUakY5dUE2LzkrcnlWc29YWVN6Y3BzSkt4Y01lVnBmVFFnNXJ6?=
 =?utf-8?B?UEJUT0lzdXdiNytxcVhFVVZmZUtreXpwbzNXaW9rL0tYaVhUQnZJTkRYSklu?=
 =?utf-8?B?ZDhGdDJKTTFCYnduNCthbXYvNEh5d05KemRXR0krY0hMTmFuR3pKbk1sUjV0?=
 =?utf-8?B?eDhRM0hkWFVadnBNTHIzazk0Rzc0VktDTGI5TFVJWlZNQk5xL0J5V2htcG5O?=
 =?utf-8?B?a2pGNnRRdW5pRkpIZXJ5UENNZjM1d1laWDNMYkYyRFFjS3dHRUhGQXNNbGxL?=
 =?utf-8?B?dlpQY3Y5V2MyN3YvV1YyRjFiUWVPeFlEUE1tdFZWWG9ZRm5mMjJSbzZKclRU?=
 =?utf-8?B?dEdDOU9DWHIzVHFPdmVwVDdBQit3UWZ6RlJNMzhxaExmbDVITDg4OGtFaWhJ?=
 =?utf-8?B?NU1sUHAwVTlrTUdjM2lTOUZ4SUlPaU1telZQTjB6L015S0czQTk5RlIxOXFR?=
 =?utf-8?B?emMzT2M1RW5nU3NDOTl6QzJ4b2d3anlqU3ZFTXdJbnBUMm53b2RSVzhnL2Qv?=
 =?utf-8?B?Wk9QMUJRdHFEbFZJdFUvejdWdytEZU9wU203WWZuYjlDZVFEd1daQ1BEKy9K?=
 =?utf-8?B?WG9TcnVDRnJhS29YOFZ5THFjVlhsam94Rnk5U3RJbVBJUEtYcHBpSkgxZ0Vh?=
 =?utf-8?B?dXFreGowUGgwNDlZc1ptR3FKWEJyU0o3R090S1hqL1pDVm0xSW9HV1lRZjVx?=
 =?utf-8?B?cTJjQ3Z4eVlXWHJaMEdvRFpmTmxoZTR6YVkwRkpTT3k0ZEpOcDhOdmtOOElj?=
 =?utf-8?B?OE1kc3M4bzhQUStubGZJdkJjU0NLQllaTHlaNTVLRE80Q1E2ZDBUdWFja1Ev?=
 =?utf-8?B?NFExejRUem12Q29CVERSK1JSaEhHUW1PS0N2cmpueTRZV2NGTTBIMmcvTUxa?=
 =?utf-8?B?SEZZS3FkR3dWSy9lbXhuZGR6cGd2SGMxdi95YjNGWjBQakxXTVgvbzhhaThj?=
 =?utf-8?B?bFBFY2tsVDVFTlB4ZTZOaDhiUjduUmFhSkFieWkvSzFSdlBXWUw0dDA5aXFZ?=
 =?utf-8?B?YWgvcUZjRlR3UUNmSEI2NE5YQ0R1MHJGYWovSStuZXVsb3Z1eFU4cEFkZFkx?=
 =?utf-8?B?aXV3K25JK3dKT1pnektCZXNoZ1E3ektqWWFub2xKcndmSkxlaVN3UlVBbmdQ?=
 =?utf-8?B?Y0w2TnVVaVh2U242U01OT09Nb1pHNVFhNEpvci9HcE5VRWU4NzRjWFZsbnoy?=
 =?utf-8?B?MnlpcU1NOWRHVVNua2MxcjlXbGE3WTlOazYwZnllVGFoSUZwZEw3QmptdTFP?=
 =?utf-8?B?K3ZoWTJQeTk0U2dTWFFlMGZhc3dxWnV3UDcrVDR4YU9QRGNXMjNJaE5oU0Ru?=
 =?utf-8?B?eXkyZ0JEMzRBNVlYZUl2RWUrYnlWVFJhQXhBS00yZ0YydVdWdmljcTJUaEJ2?=
 =?utf-8?B?RXgyTFFrYTFuZFg2RkF1L2VQbml6NXBYc1FTeFZlNnkrWVRSRzRPK1FvTEFY?=
 =?utf-8?B?L2N2S3pzOWNuSTRkUUd4SFRXbjlyQVFYN21JdENOTXlPdFZFbU1TWjQzaUxQ?=
 =?utf-8?B?VGNsUmVLYU9kRDE4eXU0TXl1eGxMU0w3WE03OStQTEg4WkM4NUlPQXQzb3B5?=
 =?utf-8?B?OVk2YjI3THpNRXZFL0dHWmhMWVJjVDcxT2IzY0FjVU8vbVhFYmVoc3F6S05y?=
 =?utf-8?B?K1VHSzNsR2FDM0g4ZTdqUVdudWIxOVpWeW9nNkt0c3BVa0NvRXVwU2RJbzdQ?=
 =?utf-8?B?WnlaQ2lweXEzY3JWc3JPQWFkTmdPOG9qczd5SlhKMnliTG4xQ0lSNjNEbW8v?=
 =?utf-8?Q?5Tb+ZS4c8bxWR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkFYekp2TUFJc1JRL2hmOGVUT0ovbFF1ZXdIYjd2djQwbmdQZ1RTYS9kZ3RO?=
 =?utf-8?B?d0dLUnVvWHpEemVScXNDYzhxYlRLNC92Y3FxdW1FTmViUGw4WGVRSGdrdzVo?=
 =?utf-8?B?WThOS2thaWo3bWxRRTdIR3R6bHU1U05acVh5TjduYXgyYlRXSitkYUF1dUlQ?=
 =?utf-8?B?UXdkaDlxZzUzOE1mYU42YWI0clhEYVFnZXhvL2g0aUpVbGk5T0VMWmQzZ3Ix?=
 =?utf-8?B?aXlvSks4ejhyVDdGdmJvVnpQODlwUzFpOFR6cEQ2bkFBRGQzbVhXdU11U0U5?=
 =?utf-8?B?QmczNDVKeHV4UTBocEV3RlVvQUhJK3BpNVp5ckRmaHM4cFdFSkc2b0t5T0Jv?=
 =?utf-8?B?ZFkwbzg4RXZ0djNJYmkvVDlsRitFTFRYQkx3QWY5VUVka0tHV0d5TTlmY3RC?=
 =?utf-8?B?QkVOeGt0L1VHYWpYdHkzS0ZmYlAvbnY2TG1qaGVNaWhlZFhuK0dnMTA1MXVB?=
 =?utf-8?B?bEJxWDdKVTNvSnR1QXRvWW1lZkZ2aGhNRzlyc09XYi9Jd0l5azdZUFdzczR2?=
 =?utf-8?B?YWw1RkYvTE5CeFdyMXhQS2dQL092MVJuSEZOYit6dzh3ZERkaHZ5czJDVDA1?=
 =?utf-8?B?TEszbmNBOCtoYTJRS1V6UzJZMmpHaHE1RWV1cmN5QlJPZDZlNHlldjVxT3VI?=
 =?utf-8?B?UGxicTBlRW1SRjBLdUFzWTk4NGt6MmJ2alhPSkF1Ymh1QUd1Z3l3QlJ2elBu?=
 =?utf-8?B?dFdIc3lwL0FHb2dEWUVodWFJU2d6Y2tEUzFmUDhkQ3ZaMjNHbW50R1crczRi?=
 =?utf-8?B?Tk9ndzJWWkZWaVlZRU1oYk1zUjg4QStUSXphWW81M1hpQTRucDEyMzZoUjR2?=
 =?utf-8?B?OHNEOW8xdHZuQzVyZDVXTS8yOG9kWUZuMVN3bGxvRTNUSDZ3OUxJc3hPSHhM?=
 =?utf-8?B?eWlGRVE3Q3lxZFZoVURFeTQxVFRsVlBXUnRiZEdmZGwzdjcramZKdTM5Z3NS?=
 =?utf-8?B?dHV3blNCMW9ibDM5L25CVnJzZ3poTE1sNERvbTFRekYvYjhjQzN5SWRmVnk3?=
 =?utf-8?B?aTRVV1ZGQnlZTXl6RFFpL3dWVHRCVmNCSEhmSU5SMFhaNzZZeTNUSjFkZHdY?=
 =?utf-8?B?dGo3SUNnQkhqTjlVQVhSc1VMTkpQclIvN1JHMnY5WkJ5TnNiTDlSY1pXMDlB?=
 =?utf-8?B?QWtCR1FYSXVLWnY4U3ZJck9oN1NpYVpya1V3THlqOTgyMERTQjF4TEZSbWxj?=
 =?utf-8?B?V1Q5aVljV0hJZ2Nsam5iZ1B5VnNEV0w3WmxsU2JObVRmb0pNazF2d203NWVZ?=
 =?utf-8?B?RTcrTm1XODc2N3RkNW45M1YrVXo0MnNGK1F4aUVXdVhUVWZhaFZrSUx0K2J5?=
 =?utf-8?B?cWJSSXd1VHBnZXBRTVdCSHd6N05ReHVJVG55TVM0aWdDUG5vZnRobTBMRG1B?=
 =?utf-8?B?bzl0UTVLOTlMWjR6U3pLeGVNK1dOMHhJTWc4a2Z5bHNRQlZuNTF4a3d2ZmRY?=
 =?utf-8?B?TlI2ekZsZ1JJQ0cyemtralJLai9oY3diYUdyRVhQbDJSdFRITUE1MTh6eWFW?=
 =?utf-8?B?VEJnWGcycVdoS3gyYVoxRVprNW1SN0w2QVcvNmhYSUNyeWpuL3JHczFxdnJX?=
 =?utf-8?B?WFUwQ2YrQm1aMHFRYlRlSFp4OEJad3FITU5MSDJhZEw5QUFEQzZKQ1pUaWFr?=
 =?utf-8?B?OTFhZ25oZTlYdzgrdnJhWmJMcXE2L292WjFTVFg4anlFSzN1R20zelB2R0c0?=
 =?utf-8?B?eUpqSDU3ZVhYRjlPVm5PaUl1cUxSeUNOaWJOK0ozYWJXblRBY0tVK2JwdnZM?=
 =?utf-8?B?TVdvSDlvZ2lIVFE0ZHlHL0RFR2twYkE3dlA0bGdQOFdNVVpsblJ2SUlEYURv?=
 =?utf-8?B?ZUo4dFkvOFNRSU9KcU1XTHlWUlJNeWwyVjhPazRvYzhxZldTTWltTjAwYjZx?=
 =?utf-8?B?QUVYMmJDNzF5VVhQNm1YYng0MzlOWGE1QkxZVSs1NjNFdXFOaDZ2bGhjVDg3?=
 =?utf-8?B?Rk9vallMUGZhNGpLYmhOVjZUL3hyOGw1d05uc090VUZpaU15QVdjWTR4Y0l6?=
 =?utf-8?B?WUpUb0xBOEYxK2JYOCsydU5tb25sdzRxZkoyR3lYUisvRlZuMDBkSjJZRU9C?=
 =?utf-8?B?RU12dFBHT0h3WVdWYmw0MVZHbkZieHl0Sm03UnNLUWo1RDFjNUNrU3lEV3dU?=
 =?utf-8?B?Z1B1bkN2Ymd2YUNoMUxaYmkwamgycytNbU5xMnlJWGZKYjFPSWtuTGVCalpx?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49B4A04A03C7D94DAC8F89193F2B3454@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5294a5c-b8e8-4a78-d705-08dcc35ef89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 10:33:04.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjnWyZHH7zOOtNI6ch5hYBzZ7wJOv5zNKylmh5LRmis0QZQqSwK87uOv5Cnimub4qtJGRdUIENJwOCu2+M9sT0gur8dbJQM5opdue+oEA4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6330
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

SGkgQ2hpbnRhbiwNCg0KT24gRnJpLCAyMDI0LTA4LTIzIGF0IDE1OjIyICswNTMwLCBDaGludGFu
IFZhbmthciB3cm90ZToNCj4gT24gMTYvMDgvMjQgMTc6NTgsIFN2ZXJkbGluLCBBbGV4YW5kZXIg
d3JvdGU6DQo+ID4gSGkgQ2hpbnRhbiwgVmlnbmVzaCwNCj4gPiANCj4gPiBPbiBGcmksIDIwMjQt
MDctMDUgYXQgMTA6MjAgKzA1MzAsIENoaW50YW4gVmFua2FyIHdyb3RlOg0KPiA+ID4gRnJvbTog
VmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KPiA+ID4gDQo+ID4gPiBFeHBl
Y3RhdGlvbiBvZiBrM19yaW5nYWNjX3JpbmdfcmVzZXRfcmF3KCkgaXMgdG8gcmVzZXQgdGhlIHJp
bmcgdG8NCj4gPiA+IHJlcXVlc3RlZCBzaXplIGFuZCBub3QgdG8gMC4gRml4IHRoaXMuDQo+ID4g
PiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpZ25lc2ggUmFnaGF2ZW5kcmEgPHZpZ25lc2hyQHRp
LmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBh
bGxpQHRpLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gVmFua2FyIDxjLXZhbmth
ckB0aS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IA0KPiA+ID4gTGluayB0byB2MjoNCj4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA0MjUxMjA4MjIuMjA0ODAxMi01LWMtdmFua2Fy
QHRpLmNvbS8NCj4gPiA+IA0KPiA+ID4gQ2hhbmdlcyBmcm9tIHYyIHRvIHYzOg0KPiA+ID4gLSBO
byBjaGFuZ2VzLg0KPiA+ID4gDQo+ID4gPiDCoCDCoGRyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJp
bmdhY2MtdS1ib290LmMgfCA5ICsrKysrKysrLQ0KPiA+ID4gwqAgwqAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3NvYy90aS9rMy1uYXZzcy1yaW5nYWNjLXUtYm9vdC5jIGIvZHJpdmVycy9zb2Mv
dGkvazMtbmF2c3MtcmluZ2FjYy11LWJvb3QuYw0KPiA+ID4gaW5kZXggZjk1ODIzOWMyYS4uNWQ2
NTBiOWRlNyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdh
Y2MtdS1ib290LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvc29jL3RpL2szLW5hdnNzLXJpbmdhY2Mt
dS1ib290LmMNCj4gPiA+IEBAIC0yNSw5ICsyNSwxNiBAQCBzdHJ1Y3QgazNfbmF2X3JpbmdfY2Zn
X3JlZ3Mgew0KPiA+ID4gwqAgwqAjZGVmaW5lIEtOQVZfUklOR0FDQ19DRkdfUklOR19TSVpFX0VM
U0laRV9NQVNLCQlHRU5NQVNLKDI2LCAyNCkNCj4gPiA+IMKgIMKgI2RlZmluZSBLTkFWX1JJTkdB
Q0NfQ0ZHX1JJTkdfU0laRV9FTFNJWkVfU0hJRlQJCSgyNCkNCj4gPiA+IMKgwqAgDQo+ID4gPiAr
I2RlZmluZSBLTkFWX1JJTkdBQ0NfQ0ZHX1JJTkdfU0laRV9NQVNLCQkJR0VOTUFTSygxNSwgMCkN
Cj4gPiA+ICsNCj4gPiA+IMKgIMKgc3RhdGljIHZvaWQgazNfcmluZ2FjY19yaW5nX3Jlc2V0X3Jh
dyhzdHJ1Y3QgazNfbmF2X3JpbmcgKnJpbmcpDQo+ID4gPiDCoCDCoHsNCj4gPiA+IC0Jd3JpdGVs
KDAsICZyaW5nLT5jZmctPnNpemUpOw0KPiA+ID4gKwl1MzIgcmVnOw0KPiA+ID4gKw0KPiA+ID4g
KwlyZWcgPSByZWFkbCgmcmluZy0+Y2ZnLT5zaXplKTsNCj4gPiA+ICsJcmVnICY9IEtOQVZfUklO
R0FDQ19DRkdfUklOR19TSVpFX01BU0s7DQo+ID4gDQo+ID4gc2hvdWxkIGl0IGFjdHVhbGx5IGJl
ICJyZWcgJj0gfktOQVZfUklOR0FDQ19DRkdfUklOR19TSVpFX01BU0s7Ij8NCj4gPiBPdGhlcndp
c2UgeW91IGNvdWxkIHBvdGVudGlhbGx5IGJ1bXAgdGhlIHNpemUgdG8gc29tZSBudW1iZXIgaGln
aGVyIHRoYW4gcmluZy0+c2l6ZQ0KPiA+IGlmIHlvdSAiT1IiIHJpbmctPnNpemUgd2l0aCBzb21l
dGhpbmcgbG93ZXIgdGhhbiByaW5nLT5zaXplIGFuZCByaW5nLT5zaXplIGlzIG5vdA0KPiA+IE5e
Mi0xPw0KPiA+IA0KPiANCj4gSGVsbG8gQWxleGFuZGVyLCBJIGRpZG4ndCBnZXQgeW91ciBjb21t
ZW50LCBjYW4geW91IGV4cGxhaW4gaW4gbW9yZQ0KPiBkZXRhaWw/DQoNCldoYXQgaXMgdGhlIGV4
YWN0IHB1cnBvc2Ugb2YgInJlZyAmPSBLTkFWX1JJTkdBQ0NfQ0ZHX1JJTkdfU0laRV9NQVNLOyI/
DQpXaGljaCBjb3JuZXIgY2FzZSBpcyBoYW5kbGVkIGJ5IGl0Pw0KDQpXaGF0IGhhcHBlbnMgaWYg
cmluZy0+Y2ZnLT5zaXplIGNvbnRhaW5zICIxIiBhbmQgcmluZy0+c2l6ZSBjb250YWlucyAiMiI/
DQpXaGF0IHdpbGwgYmUgd3JpdHRlbiBpbnRvIHJpbmctPmNmZy0+c2l6ZT8NCg0KPiA+ID4gKwly
ZWcgfD0gcmluZy0+c2l6ZTsNCj4gPiA+ICsJd3JpdGVsKHJlZywgJnJpbmctPmNmZy0+c2l6ZSk7
DQo+ID4gPiDCoCDCoH0NCj4gPiA+IMKgwqAgDQo+ID4gPiDCoCDCoHN0YXRpYyB2b2lkIGszX3Jp
bmdhY2NfcmluZ19yZWNvbmZpZ19xbW9kZV9yYXcoc3RydWN0IGszX25hdl9yaW5nICpyaW5nLCBl
bnVtIGszX25hdl9yaW5nX21vZGUgbW9kZSkNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
