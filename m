Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE8ACA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 12:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF7C8318E;
	Wed, 10 Sep 2025 14:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Y40c4jqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1BA8319C; Wed, 10 Sep 2025 14:27:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D708C830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 14:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJEZ5YXDCZp+rmSTG0lkkbe2ZhZSC6sciso7Jih1sirB6b3vMqpHTb1ZJSSX9n8+UgdPhlWuLIC7xm8wO3OlGUvGcpM3U+rzBKNh+V93PGFL7pXBopbtMgo3yM6NM9hVyCyJ5bqUzLkQ4LjNwDms047aL1T+PoK76N2L9SChqTgFqfVDEm2dPFzJoNUX4FclCLYFvJHmDzPyjLeKiagSs1n4U1ZdqKlnAh2HIdLB85KYMNzQsHGyAjo+Oj7KjFyb9wGB+kap+DxJ1r4SP3veXxsvmlSxpD6pe8KaSSADpv9M/nv4M7P+ONF1pH+bI7ttd+ZcDivAbdm9JLmecXiAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkowQ56iHseS1lLT4ttjysk+a71QraWMgjquoFhlVW0=;
 b=C6LzrWPDeh309BSC8DwpgBcleJURb5DIFJ0Fb6VVy4jnGpcxUgXL7QUjEuoZ4640Mb2tXkJ1BOCWb7dlUqOcvfrVTmKaFbq5KDL/wBUelXL9sGfm7XEG7agvFavZ4t68cjZwpC+xtRgs5JzNawx1MPurPNTwOve8tmUoBtnR8xhGeXj/7ljAHAAqnlAKj+X/kWWf50ff/RmR51t89VEDs6KLm9napAcu/lOcvYKYP80Tem0gX8oWd8QlTyRVQdtDJ6PyVRGUR+GdS2lC0eb9Gm00NF1rtM+VaVUI/QK13wybXGEOS5dVORJZEZGvydE7bVRb1rGgyJ2wW7NcGoNzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkowQ56iHseS1lLT4ttjysk+a71QraWMgjquoFhlVW0=;
 b=Y40c4jqWhUKRv1+zCgoM3JyuMGOSU5Q9snK2EaC3HZtDV5+gNczuZvVkbztnEdpal9RjTqkFOaS4f7OIfJbW0M1q4RF5hOHmVoWphMwgqUXF8ztn5li8bsWcmtIw30JrH/cntPBvQEPJOfCGCqn9xkD0BSl2OpvYTNQd/uKAXwmkb5jNx1ia4J7lHioib68d49ZO+yvJhWMVNQDjl2f+MBNq0PB5L2S3G043YmrvHjakGv/NuIB6nYMahdWdz/fsF3VKvlvZ9dcedHC2FInxetpUqbaX9gohSZAMiXgS2am69l/42rQX0Od7PCH2Ypw+RlTNvWlWWZAEJHnA8+5S5w==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB8239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:38a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:27:31 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:27:29 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "bb@ti.com" <bb@ti.com>, "d.schultz@phytec.de" <d.schultz@phytec.de>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "kishon@ti.com" <kishon@ti.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Topic: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
Thread-Index: AQHcDf4Tk1i6NjlF406dY4By04l0srRtU3IAgB8i2wCAAATjgIAABV4A
Date: Wed, 10 Sep 2025 12:27:29 +0000
Message-ID: <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
In-Reply-To: <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-1.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB8239:EE_
x-ms-office365-filtering-correlation-id: e2a9ba5d-8b86-4a54-60a3-08ddf06568e3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?T3c2Q245ZDM5SFN6eTZCQU95R3lGNDc4U0d4MVZkci85cWM4WU4xR3RpYjJo?=
 =?utf-8?B?cTlFZGhjRTJnVmRxZjl6OUUxOW9xTlNaaDRLTlNmdWp1TndzZUhGSklIK0NX?=
 =?utf-8?B?M3BZVFJQb0g3RzNVUHNvNS9MVk9wYWxjWVcwUVpGTzJPem9JTUFTbVBOcDFn?=
 =?utf-8?B?QmNLcjltNEV6amk2Q0hoVjJkR21MSnJtMzhTQzdtM203eld1WDFTSHJ2aVEx?=
 =?utf-8?B?RHRMZ1lRL3RIRjJlWXFnK1dIUlpYRzB4TlQ0STYyRGxGTFhNejZtVEx3L3VD?=
 =?utf-8?B?UE15Z04wYkRoRmsySmJuZURCZmx2VWszTFNyaXV6UE1IZVVHQ2R2YTBuTktP?=
 =?utf-8?B?Rm9ucnM3bkdUSXJtcnhWNGpCUDAwUGROTTJYVXIrY0dxWVNlSEhEK0gybGNT?=
 =?utf-8?B?a2JDU2k2cGhYZ3hOZlFZQzA0ajVQVUJ4Vllvbi91VXRhUHZZTzhGWXBNK0lX?=
 =?utf-8?B?c3ZmWWwvRUhhdllWVGZYMWtwakluR3F4Tlh1NnFIYzVjMjhSNEpsSGFGMU5O?=
 =?utf-8?B?cWNKQ0l0a1E4NDlDUFVFZ21UMzhmdlBDMjlpS3lJZjlaR2R2UDl2SmpBYjVj?=
 =?utf-8?B?a3E0UTNkMU40bnNDeWl3U3p0NFR1cnlKMVczOCs4ZGIrY2pqMjJubXlzVmt6?=
 =?utf-8?B?NEpPR0xTSnJyUnNZSXhmUWUvbDZ0TkFZN2hmN0dScXQyNHQrL0hRMFZBMHBt?=
 =?utf-8?B?SFdNWUdPQ2U5UXJ2K1lGSk9PRWtOcmx5MmVORnJBTGFQSFBTNE5zRitiODZn?=
 =?utf-8?B?bCtDZmlBb21vVW8rUThBWWNmU21idUVORy9aYjRpNUxhWUxxZzZ5SCs3Rmsw?=
 =?utf-8?B?ZzFuU0laZE01bUVQTWJ4MWE4RVpoNWtoYUVja05ORlA3dFdNRW1PVmY2MUY4?=
 =?utf-8?B?TGozMmZ6V1ZUS244M3pYem5YOEZpODFJOEFmbEpxcjBLK3pSM1NqREZSV08r?=
 =?utf-8?B?MUo5RjBjM3lkUXdLSXlIYTF3c1lSVXozKzhlRDVJUmtsQ0ZPTmUwNlZxVVVj?=
 =?utf-8?B?L2xndlpkRmJGTWg1Wi9WbkRieFkyejJ5UTQwT1FWaDVzNjZvSW1aTGtmbGRG?=
 =?utf-8?B?UFJDTjJMeGFhUEU5TCtyQTUxRXlEcnByWEd5QmxFTWJ2TWpnZDI5a2tLUTFj?=
 =?utf-8?B?TU4yUk9pMzQ2VVM2UnFRTTh4N1gxeElKU3ZsejFqWmk4SjJaVWpSbXNSeExy?=
 =?utf-8?B?aXhVRGo1azNmOU5KK054VlJEeU9CWUV5TFVDd2JHeXc1WThMYjhGVmtpeVZa?=
 =?utf-8?B?VmJMeEcyODNpVFlvcXU2T2xqdmNseTdISEZ4TDcweTVjYldIYTJUODhuN0JB?=
 =?utf-8?B?WFp6dC91VWN1d01ldGlYSmlrRHhaeGNZMmJ2LzlSZVBtM3hwTmRpQ0s0b0VV?=
 =?utf-8?B?bWNBYmJ4K0xiUVRXdmFPT3Y2NXBrL3JMc29FSFBCN0xTc3B0YW9YUDlEY0VW?=
 =?utf-8?B?ZVdEY0sydmE3RUVZOWRBYUorZ2NZTkdpOTM5Z0VnY0JqeGNzemY1aFBvTjMy?=
 =?utf-8?B?NllhaG96K1pET3lqWlZMYmJ5eEJ3bHRCVGNiV0RGaUhEYis0eWtkbGRaTEFD?=
 =?utf-8?B?K3RzYXhCc2hCWHhpTEovMEFicUlUdzFXZTdrcUlvNDVFODNEWkNqYkZld2NF?=
 =?utf-8?B?bndCa1hoUFFFZ1MvblJiY05tU2JOZWhHN1MrQjhTSDIxeVdJOXJGTkNXQUgr?=
 =?utf-8?B?K1EzckkwaG0zK3NnM3p4MDE3dnNRcTQyb2YvVFMvWEk2T2NyK2p3a3A2QTkr?=
 =?utf-8?B?ckpqdDhlWDNVeGl4UUtmYnVJQjRudERobStwb29uVlBsaFAzcVlxRU1Kd3d3?=
 =?utf-8?B?ZGJVT2lYNEsxdmtpRnBlbEFxWXVycnhBUzFNNkE0ZXgvQnNIOUpQR01kV0x3?=
 =?utf-8?B?VHk5eHI2TWUyQkphd2RrV3hxUTJrcElnYjFZaUo0SFNxam1VZ3pQdHBWM0Ex?=
 =?utf-8?Q?LxsQAy2XpUY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmhVNEtMTWc4d0JoM3RDTi9PMHJ4T3M3ck5SYktUdURSQktOWGErZlZhWkQ0?=
 =?utf-8?B?cDlXOXdMRE9ORWhKTGs4VHNYZ3F0cFliSkdzaWorR0txZ25ZYm52bDlKaE1m?=
 =?utf-8?B?dGdZL05qRVNTNi85MmZuMWRGZGw4WUtFamdKMUhHNW51bTE0SFdFR0FmLzZk?=
 =?utf-8?B?WlBNc0l5em81LzRpRTBKa1FPemRMZlowMi9zaXlJQXlFUGx4S1ZTeHdHdmlI?=
 =?utf-8?B?YzUvWUNGaDdpeWV4T3FpRTNsYlE4S2pFU2dLVmpNMDlXdVhJUjI3b0Q4bFpB?=
 =?utf-8?B?YXNNK1BSR0dPMXhxSk8rZmpjTEw5NXNkaTFIWmk2VzhyVEZPWjNnUU5WRisv?=
 =?utf-8?B?SGc4YXUrU29CdHpoZDRzYmgzbWNSVHMyVVhTRmZYd01RQjl0d2YvSVI3Mml6?=
 =?utf-8?B?UVpYNHJnKzVIcDZaaFBKTGdoWHliZ0dGcXc0NGZISnpJdTlHdzZ5azIySXl4?=
 =?utf-8?B?ZHFpVVpQOFZiNTZRL2R4djRJS3c0cFdJaEMvRkROZ2JZRFdHa01lTTk2d1ZL?=
 =?utf-8?B?aEx6V2QyODdmM0Nqb2w1ZEJKbS8rcWNqUFNtSHlzdXROZ2lsRDRQM2tHUlEy?=
 =?utf-8?B?VklBQXluYWlWM3JKQW9XcFFQRWNCZnFWRXc5aFJ1elB3ZDZIOXRZR2pJU0h5?=
 =?utf-8?B?cUhKY0JvYXJ3Q2cycWdGM2RSakhlWHVYTkhHUU1iRnNkOERxaUs4elphNVBi?=
 =?utf-8?B?NWlRNmFyczlKekpxQi9uZGx2UjR3Ti8vTWtXQVNSYk4rY2dXTUI5dEVncTNM?=
 =?utf-8?B?S3RlQW9tU0d1ajlJaFNNMnkxRFk5R3JpdlNyLzJXOGhvLzVQQnlFTFlkOUNE?=
 =?utf-8?B?MW9rNyt4QzNHZWtQMTBtTmRJcys1akdwZkJMaXArRHFvUTJOZ0hmT2pIcFZj?=
 =?utf-8?B?ZGlKNWFCOEZGSmVBdGovOEhKdm5RUlNlWDNweXREZ2NJNWJGWnh4TWZLZitL?=
 =?utf-8?B?RTJnQUY1bnZrYlE0SjlJNWNDZjAvUUdtOWxzeUpqU3pZbnFJSHF5ajduVytu?=
 =?utf-8?B?Nzk1RWtjMUNGU2ppVkVvejdQaTlEVXVtM2x0ZlNacXBWN0Ria1pMSXR5eFRt?=
 =?utf-8?B?ejJQdHEyeGU0dkYvYWduYTNITkl1YnhRZ3dnS2NlcG8yTWNxY2RTbkp6QjZB?=
 =?utf-8?B?WWVPRUlPMTUweGFKSXJ1TE1nWncxNzk5OGVqMGNJQys0RTdRN1VKejlJY3pI?=
 =?utf-8?B?VTlFNlZFeklMRzNkdzhEdy94Smg4RDI3bE1mMTNHRnhXMGNXWEZOMitIdDhx?=
 =?utf-8?B?OXlOdEw1cE1WNVBrcWkxeGNHSFVpdnkrU0M4ck0wU09LbEh5ZmJkSEhxUlIz?=
 =?utf-8?B?Uk5xOG9lOUU0cGVibTNNUTBJbWluQlFEY2J3V0ZSLzFTdjAvL1p5WUtHTHdr?=
 =?utf-8?B?ZlQza1ozYS80QjEraERSbkptZ3plUmlHcTliS1F5RFRUL2lTQ3Rhc1B0MVNm?=
 =?utf-8?B?bXVqQjBma1FmTDNQUE5YV010RlM3d3h0QjhuLzBFdUUwL25TeXY5d3ROL0lI?=
 =?utf-8?B?a2Z0U1grTTV2ckc0d0phRVNSRUVBTTFjakc1QjV1KzUzSVlRZWZISTNNcmoz?=
 =?utf-8?B?VWR5eEh0NUVNd0k3RXZmVjJ2V2FUUWRNVHNKQjgzclRXWHFFMEVhdStqNTRV?=
 =?utf-8?B?Q216U2FjM3JhQ3hsOHNxT3lrT1FNMDNSYVMzWWszcEJuRlhtUms4YmczNTdv?=
 =?utf-8?B?Nk0zNDVQMWoxUm1wcCtLcStOcVhwOWVMR2tFTHdxYWZmRVQwdUxmNFJBaDRS?=
 =?utf-8?B?c1lRalZZSkVpYnZScXF5dDZrUHMvN0RjWUZtRWtHQXZVNEtDdEgvbWNISWdM?=
 =?utf-8?B?OXQ5VVdwbGtiVTVvU0l0RE5CRE1vTHZqaUN1QzlaWmNMZE1UNmJDRHZWNG5l?=
 =?utf-8?B?czlCaGQrWm5MckFJVTRvQkVyVnVEbEJsY0NRVndsWjVZM2FSNUwvSWIyZHVB?=
 =?utf-8?B?TG1Qb2pWNlorNklHWXJDRzdWNzRZNTRxUlRxNisyUnNVUmtCaFZFdXptY2F2?=
 =?utf-8?B?ZGozZVBBelFmZEVVOW03bldESnFEbjArWmIrME45cnM4czhPR0NvODRwUnN5?=
 =?utf-8?B?cWw2eURJVUplZkNpbXpYMFpId1lmK3JXd3B5d2pqSFVDZ1RrUkRyMW84MGd5?=
 =?utf-8?B?ajhhSE1hN0dqZXFuU1Nsc0tsVVZuUHRTcVFrWG5iWmZUYVF2WjdoeVl5SEk4?=
 =?utf-8?Q?KGdljoR+JQR90ch34iQpW5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC1DE9135478B141A14896E233E1E061@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a9ba5d-8b86-4a54-60a3-08ddf06568e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:27:29.7766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMe6MmNAyEHYszsgSN5cN0cGCHCx0SSNqXhNqjWsMrxEDiLHCHbYfsEpHnmoSeinuuVP01+Y4vm6hrrl3CAGo/mqRKcO/sGgJoa2qKFdOCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8239
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

SGkgQnJ5YW4hDQoNCk9uIFdlZCwgMjAyNS0wOS0xMCBhdCAwNzowOCAtMDUwMCwgYmJAdGkuY29t
IHdyb3RlOg0KPiBPbiBTZXB0ZW1iZXIgMTAsIDIwMjUgdGh1cyBzYXlldGggRGFuaWVsIFNjaHVs
dHo6DQo+ID4gSGkgQWxleGFuZGVyLA0KPiA+IA0KPiA+IE9uIDgvMjEvMjUgMTg6MjEsIFN2ZXJk
bGluLCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gPiBEZWFyIERhbmllbCwgVEkgdGVhbSwNCj4gPiA+
IA0KPiA+ID4gT24gRnJpLCAyMDI1LTA4LTE1IGF0IDA5OjAyIC0wNzAwLCBEYW5pZWwgU2NodWx0
eiB3cm90ZToNCj4gPiA+ID4gVGhlIHdhdGNoZG9nIHJlcXVpcmVzIHRvIGhhdmUgdGhlIE1DVSBF
U00gZXJyb3Igc291cmNlIGVuYWJsZWQgdG8NCj4gPiA+ID4gdHJpZ2dlciBhIHN5c3RlbSByZWJv
b3QuIFdoZW4gYm9vdGluZyBIUy1TRSAoc2VjdXJpdHkgZW5mb3JjZWQpDQo+ID4gPiA+IGRldmlj
ZXMsIHRoZSBNTVIgcmVnaXN0ZXJzIGFyZSBsb2NrZWQgYWdhaW4gYW5kIGFsbCB3cml0ZSBjb21t
YW5kcw0KPiA+ID4gPiBhcmUgc2ltcGx5IGlnbm9yZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBVbmxv
Y2sgdGhlIE1NUiByZWdpc3RlcnMgYWdhaW4gdG8gc3VjY2Vzc2Z1bGx5IGVuYWJsZSB0aGUgTUNV
IEVTTQ0KPiA+ID4gPiBzb3VyY2UuDQo+ID4gPiBJJ20ganVzdCBjdXJpb3VzLCBjb3VsZCB5b3Ug
cGxlYXNlIGVsYWJvcmF0ZSBhIGJpdCwgd2hlcmUgdGhlIHJlZ2lzdGVycw0KPiA+ID4gYXJlIGJl
aW5nIGxvY2tlZCBhZ2FpbiBpZiB0aGV5IGFyZSBiZWluZyB1bmxvY2tlZCBieSBjdHJsX21tcl91
bmxvY2soKQ0KPiA+ID4gaW4gYm9hcmRfaW5pdF9mKCkgYmVmb3JlIGVuYWJsZV9tY3VfZXNtX3Jl
c2V0KCk/DQo+ID4gPiANCj4gPiA+IElzIGl0IFRJRlMgZmlybXdhcmU/DQo+ID4gPiBXaGF0IGVs
c2UgY291bGQgYmUgYWZmZWN0ZWQ/DQo+ID4gPiBEbyB3ZSBleHBlY3QgdG8gbGVhdmUgR2VuZXJh
bCBQdXJwb3NlIENvbnRyb2wgUmVnaXN0ZXJzIHVubG9ja2VkDQo+ID4gPiB3aGVuIHdlIHJldHVy
biBmcm9tIGJvYXJkX2luaXRfZigpPw0KPiA+ID4gRG9lcyBpdCBtZWFuIHRoYXQgdGhlIHdob2xl
IGN0cmxfbW1yX3VubG9jaygpIGhhcyB0byBiZSByZS1kb25lDQo+ID4gPiBhZnRlciBrM19zeXNm
d19sb2FkZXIoKSBjYWxsPw0KPiA+IA0KPiA+IEkgcmVhbGx5IGNhbid0IHRlbGwgd2h5IHRob3Nl
IHJlZ2lzdGVycyBhcmUgbG9ja2VkIGFnYWluLiBJIGZpZ3VyZWQgb3V0DQo+ID4gdGhleSdyZSBv
bmx5IGxvY2tlZCBhZ2FpbiBhZnRlciBsb2FkaW5nIHRoZSBUSUZTIGZpcm13YXJlIG9uIEhTLVNF
IGRldmljZXMuDQo+ID4gU28sIEkgYWxzbyBhc3N1bWUgdGhlIGZpcm13YXJlIGl0c2VsZiBsb2Nr
cyB0aG9zZSByZWdpc3RlcnMgYWdhaW4gYXMgcGFydCBvZg0KPiA+IGEgc2VjdXJlL3NlY3VyaXR5
IGZlYXR1cmUuDQo+IA0KPiBIbW0geWVhaCB0aGlzIGlzIGxpa2VseSBhIGJ1ZyBvciBhIGNvbmZp
ZyBpc3N1ZS4gSWRlYWxseSB3ZSANCj4gKFUtQm9vdC9MaW51eCkgc2hvdWxkIGJlIGluIGNvbXBs
ZXRlIGNvbnRyb2wgb2Ygd2hlbiB0aGVzZSBhcmUgbG9ja2VkIG9yIA0KPiB1bmxvY2tlZC4gVElG
UyBvciBETSBzaG91bGRuJ3QgYmUgYW55d2hlcmUgbmVhciB0aGVzZSBNTVJzLg0KPiANCj4gPiAN
Cj4gPiBUaGUgQTUzIFNQTCB3aWxsIHVubG9jayB0aG9zZSByZWdpc3RlcnMgYWdhaW4sIHdoaWNo
IHdpbGwgYmUgcGVybWFuZW50LiBPbmx5DQo+ID4gdGhlIHdhdGNoZG9nIGlzIHByb2JsZW1hdGlj
IGJlY2F1c2UgZW5hYmxlX21jdV9lc21fcmVzZXQgaXMgY3VycmVudGx5IG9ubHkNCj4gPiBjYWxs
ZWQgaW4gdGhlIFI1IFNQTCAoY29uZmlnIG9ubHkgZW5hYmxlZCBpbiB0aGUgUjUgU1BMIGRlZmNv
bmZpZykuDQo+ID4gDQo+ID4gQlRXOiBXZSBoYXZlIHNlZW4gdGhlIHNhbWUgYmVoYXZpb3Igd2l0
aCB0aGUgQU02OEEvSjcyMVMyLg0KPiANCj4gSG1tIHRoaXMgaXMgc3RyYW5nZS4NCg0KVGhhbmtz
IGZvciB5b3VyIGFzc2Vzc21lbnQhDQpEbyB5b3Uga25vdyB3aG8gY2FuIGJlIGNvbnRhY3RlZCBh
dCBUSSByZWdhcmRpbmcgdGhpcyBwb3NzaWJsZSBwcm9ibGVtIGluDQpUSUZTIGZpcm13YXJlPyBN
YXliZSB0aGlzIGhhcyB0byBiZSBmaXhlZCBpbiBUSUZTIGZpcm13YXJlIGluZGVlZD8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
