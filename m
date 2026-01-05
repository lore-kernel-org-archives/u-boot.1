Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5349FC2A062
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 02:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7102183A1B;
	Mon,  5 Jan 2026 03:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DZVJWqig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E7683A26; Mon,  5 Jan 2026 03:49:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7339B839F1
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 03:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLeiF9ok9fWSijFKIJhlH5PZw4G4BO9423ygiqSps0J7vP6pcfqSiUw2eZyn/uAO/tQuYFmNgAjH/JmGvpSsU/h09OZ916KLqx9cy1RyrxmG3cisB7fb9dSUTMd/lgOXQ/Ao8GJDSiJnwmcW0KeweGZyYomZIOVYMcM1BOWCWat+Dt2EbmqBZQ+Lc/PCQFkHtFAmrqcvDPu5plctqAe/Uv9ckmTYCy4FZCL+zOSYerFx6Z40Qq5AV2HkVNtr80XwTVkK14r6SyGi2sLs1pzKmw1fJmlDSGPH2RrT94OGdLOVPhZATlz90Qa42ey+pi3eoMPV7UKLtDF6fndEuDj9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0VAE3g3M1AIGv6d8cpCbvsanmfEgjzKAZS7lNpIZyY=;
 b=g4yCLqJdlx3eKPXLZVRcAkuNhDrpp0TQEJGqCzZSAKCHblYGwm8f65bBD1P4tX4LW3qb4R58iGfWmt8v/oQ5PSx6I3yN4J9n74InahWAgl24ldG9AXNzcRj77NFeY2Wy3yehOLB7xInwY/B0o32/g5Y8Zvgl1rHPtEhhF3/dFTQ38m3mF82v2yoG8pNm7PKLLn5T8/miowq6tHHN8xNw+nsgTl8fhX9bYyN/fEde4Iexnx6Dzr1GjN36mmVIuuPE7OeB77VhzcVTn39SP19InEgpC1hQNt8G8nMwCzzSBotYa6+5LKy0hF4A0IAcULn4jkC7kQVdguRbOU6cHrNZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0VAE3g3M1AIGv6d8cpCbvsanmfEgjzKAZS7lNpIZyY=;
 b=DZVJWqigHBJvMpwSy1TfEl1oJPkQ0q2Rf3ayiL+6fAnSodNsTsucqt8Gn2wa3N4bvoZvXT4M4O9hY98Wwffr144MaGkfimiPmNJ+vpwMHmC3B+RrTpyTP380fkOg7uZOs0lDis1YNg0sqXEg6/3XJusM8HwXk3vFEW2ZK7q76+rCXcQ8R2BtYh1zpE/VI8vkKbktpWkTxjWHp8pg0xdVf5uKuJBoPHyRDjwwkh7jfJ8/TGOyYyWMKQrYCCmmYiHk5rKB0ccI9JDK9O9ixaUe+ts944GVLs7mkiukEYJJzagqbyvZEvtvuIdgwW6ioZSu2+jNQjff0zjcT2cM1/OddQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 02:49:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 02:49:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Christoph Stoidner <c.stoidner@phytec.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: RE: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Topic: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Index: AQHcSnca+pX6DLYxQU2JKGBWrFetBLTiNiWggAo7JoCAC4kygIAQOH2AgDsTfXA=
Date: Mon, 5 Jan 2026 02:49:32 +0000
Message-ID: <PAXPR04MB84591E76F968A6E5798B507B8886A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
 <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DB9P195MB1212DC55E27674A4194719C497CEA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
 <aRv8gc0FNwulrsRm@nxa18884-linux>
 <251e74d80063d4a63a48d5c4d8ebacac006da029.camel@phytec.de>
In-Reply-To: <251e74d80063d4a63a48d5c4d8ebacac006da029.camel@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: 47e3229a-6a23-4152-05a5-08de4c050dc6
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QU9RbE95VHY2d0ZnTHlBV3JyWGtmS3RHcWxFakhpd28rbVUvUjJZa1BVK3J6?=
 =?utf-8?B?Q1dIdVBwMWFGd2N3VmJYMDl5a0RGcjVXbFhRL3B1OTVqUlhLMGhQWDl5eFlj?=
 =?utf-8?B?WUhrblQ3TFJLT1lGTzJKY0xoaXB0aDhwTWQySnl4RjJiRDBWUTUwdmlGT2sv?=
 =?utf-8?B?b090WXBwN3h2dTJJTG13cmJYZnRwdFpubTVPSGxvb2k0MkdwSlh6UWRIeFVi?=
 =?utf-8?B?ZktKSkZISzByMTdlNCtYWXd6RnBnSFhFd083RWdOOFNvUWRmMnhRU3o2Ynk2?=
 =?utf-8?B?ZVBDU3E4cm5id1FScWx2SGZXbm53ODkrR21WOGRQRDQwVHprdk52a1ZOZFRO?=
 =?utf-8?B?R2x4d0FVVG1ZWVROdENVT3ZqL293OVY2cWs2dEFRYzdrNWFOUTlrbVg0NTdT?=
 =?utf-8?B?MDRvL2hsdDArOWlvcUFvQk9iakZPQXFyQXRic3Z4cnZQaUUxU1hnajE1Q0k4?=
 =?utf-8?B?WktEVDNZR0l6Z3hyeGJYRHlSQ2cvbUpJZDJzQ25jdDN2QkxuUUs3aHBsSUY4?=
 =?utf-8?B?Mk9NQWNzUWV4V2t1Y3ZrSkswYVJmQlFsUlQ0b2tTVGh5YmxxcWxBa0xBSElj?=
 =?utf-8?B?ODdnR0ltRWhXQXVNcGsyVXIxQTlZdllHdFpNZ3VMQURhUEpSb3NLRktWK0dQ?=
 =?utf-8?B?blM1VEFGR1ZCanFQcmJYcGZjVmJjR2grVFNSVnlKeXNGQm8xS2lFbUNDK25k?=
 =?utf-8?B?OWM1V2tSbHgyRDBCOGIvWXlqOWNnL2xuVXRmcEpDUjRZbnIrVTZsb0JxYk0z?=
 =?utf-8?B?a1AxNnJuZEdlMXkxV1VnV2l4UFdFSWdIMEFYakVHeWxIZ1hGY2NIVTRCSjZS?=
 =?utf-8?B?SDY2c2VZbVBoZXhsQlRCbC9qT29FNnpJakRiUGRlR01QQ3R2Y2I0SXkvamRz?=
 =?utf-8?B?Y2YrWXBJWXRFYXpRRFB1N0RHMURWMjRBRmJBWk5CSHdvN2RxNXVYR202TTFT?=
 =?utf-8?B?cVU5ZzRaNGwxZjBDQWZQMVI5RDJPR29OWm94VWlSeW1tVm5QQWN4NG5TK2ls?=
 =?utf-8?B?SVBBWlYrZ0dWcUJxVG5tT2M3VENaT1dQQ2l2VS83L1NQNGE5NkxQTm5Yc0VM?=
 =?utf-8?B?SXJFUG0yR0Y1T3RjcUJqZVM3MjlLeUVlbmlWVGxKYWh0UjVVOFRMWlZhMGtX?=
 =?utf-8?B?aEsxaTNZaGpFVkx2dDJJTlNYaE0xcEU1WFFqaWNSWml2VkJONW40WFZwT1Jr?=
 =?utf-8?B?MHFDQnlkc2tORTlqTGJyWkJQU0xMM0phclFpRjFpL3Q1R09DNWs3Q0JySVFI?=
 =?utf-8?B?MVZUeHNpeldaRm5CdXg5QlhGTzFybXJWYkVFb3F2TFdkemVkYnQ1YUFUNkU5?=
 =?utf-8?B?L044UnFvSWlMZHRNUE1VK29QZXJaVjd0UHJ1N3o3b0RFdjVub3BsbzRNQkFC?=
 =?utf-8?B?d2Q4RllSVjNXck1KSHVlcG4rYlF5RjRvZ2pnYUZxc0RnUkM5bVBGb0hoSHN0?=
 =?utf-8?B?UHFvRitxeEhiQ2IrVWJXNUwzV09lckNsU0RuK240a2t3UWxPcGRQVHFINnpW?=
 =?utf-8?B?akpsY215Vk9MSXFhb3RYSmZTVXkwb0hDYVQzUTgvSnNCV2YvWVRCbEN4SEhi?=
 =?utf-8?B?WDdOTkVoZk1rV3ZBUEtZMnJ0bnZTRkd6c0NiU2JXSkJVNVFDUzIwWU1DaDZv?=
 =?utf-8?B?czNDdzQzTkx5c1hUK2tqZU0wWm9KdmdtYyticmVhL2NaTUM3Qm1RdDFpOElp?=
 =?utf-8?B?eTFPNXZsaXFzRHZYQTN0VStlN3U1ZzhPd2FBQkFDR2VrRnNBVXB0RG1OMi91?=
 =?utf-8?B?N1JXWHF0THNzaFRGcVYyaDRSRDJOWFpkMHZkcHI5T1hlMnBrZVFPa21ucGxt?=
 =?utf-8?B?NU1vZm1wQ0RMdzdZbVJWWEJzR3JqRE1ZN1pIbDh5NFJRRzNRVU83R3hURjVj?=
 =?utf-8?B?Y3lKNjJzb2d5MDRUakY4S1loRmViUmlZa3Nqak4xYmtyaDY4bDFmSEkzTzI5?=
 =?utf-8?B?ODBaMW91S2ljWVFjQ3VDakhIMWF0bkJvRGFHQm5XQnNrQ1p3blJnT3p6aDJP?=
 =?utf-8?B?RUFGSkFEbWFyNXBLUnUwTktldjJHSEdXbS9IZDUzd2FBK3hreDVVK0lXNFI2?=
 =?utf-8?Q?jClqPW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXJQVEZlR3NwYUhpdnhIQW9tVUJTK2ZoWmNseWJRTTZzZmkyN0ZrV2xjcGRa?=
 =?utf-8?B?YXhtZ09nazlFQ0I2djl5VnRlNkxiTGc3YXRyb1hPMC81MHpLZzJ4d2RuR2Fm?=
 =?utf-8?B?S3lDczFQdUtQeXNCVHBoc09MZnN6eUNETlBnM2hWSEJOczJYU25TTFNWZEd1?=
 =?utf-8?B?amxzMVgyc05Ba2kxT3pDclN1alRaUmorckRVY0xndXhPRndKZWl4bGVzQm9r?=
 =?utf-8?B?c0ZOWVEyZFR0bUNXQXE0U2tpcm5aVEVRSXE3OVc5RzQ4cTk2bFdieW9ZeW1H?=
 =?utf-8?B?TkpmN0k1UG1UaXdxMUJpR3REMllsZlFPaXMwUDFOcWsyVnU4aWtuMWJKKzNT?=
 =?utf-8?B?Y1ZWRUh2WmMvWUJRVDByOGdjeEJkVVgzSjIvaDVTY2VuV2JKbGFjeGFPUjZC?=
 =?utf-8?B?eHltZm1zR2RhMktpQWhIMStjWURzaExRd0VaYXNhRGpFSllSdVVTWjRWM0lN?=
 =?utf-8?B?S0FjMUI3RVBqVkZwVzBuWVVvU1lvdWJzRVk0Nk5JYkNsS1RTRGlZa3R2dFBR?=
 =?utf-8?B?bytwdUY1a2xCa3ZIRTZDa210WksyUEtybXBqVFhyeUlkWWR0RmlrV2I0TFYr?=
 =?utf-8?B?UDBrc2hHTXU1a09kYjhpR0EyaXRBMW9KbVg0cFQ3MlMxYTJjdjVOeExXVS95?=
 =?utf-8?B?Zk0yUUFpbnVhdFRZcm9mVjRmOGJkak55T01Gb3ptd0pKT2I5VzF4K0xHSFZu?=
 =?utf-8?B?ZEVwN0FQUUs0T0RhVkR4Si9NMFA2ZEsyS21ScjRKL0MveVU1anJKelhIcTYy?=
 =?utf-8?B?ZmoyN1NEdFM0bDBIVXJ6eUJzei9rUXJKNFRKRWNkVXpkdDBLOUhRL3ZFd0xL?=
 =?utf-8?B?d0IyQUxna3FMakpUejZsNk43QWR3cTdEWldaN3VTcnBXYmJLM1dCbDVFUXZM?=
 =?utf-8?B?Sng5M1dNdUZTdkVubVVxNVltV1p5STFRM0p4eUY4NWNhdkNlWHlhRVYzRStD?=
 =?utf-8?B?TFhENHNKSlRKc0lBS1FHRzZ4NTBENDNaN05LM0JzTWtxamhkSjNzWHZuU0oz?=
 =?utf-8?B?bE9lb0VFakJVVVhxVDhDVHJ0ZUNzUkhRK3dncmgxZjdBUmdmMU5YL3JaVmxB?=
 =?utf-8?B?TmN5Z1ZVYWJlVGF5MVk5WGk5blI0bGQvTTlVeFk4cm5xd3FFWXZYRnVZVUJS?=
 =?utf-8?B?Z1IyMm52UnlBeUVlYmNoNU9IVUNhbzlpSWFHOThBRm96ekxvZnRzOURhOGJa?=
 =?utf-8?B?YkZMSjVoY2lXY1c4bTVrWENYbFdORFFLanFYR252WHJLbDZlbHV1Y0pGMnlZ?=
 =?utf-8?B?ZWEzQkRYdEZvRWV4cUxQT2JUYU1QYU5QUFF1NjdyS1J2RkVNNUxiSUpCaUJV?=
 =?utf-8?B?Z1BQeGFKQ3k3Vi9SdkdhbWRvdnVIZXNJWFhQUjJvNGt6V2Z6L0M3QllNb3FR?=
 =?utf-8?B?bVIvUFhBdThEZHQzNm9lb0FxT1JaNXZ6M2pzb2xXVlo0UUJBNzAwK0JmRHlI?=
 =?utf-8?B?Q2M1WUlsQk1Ha2hEQ3FUV2VoVmNJK2Rxb21CSFNvbzJoWVFhU0hCM3E1TWMw?=
 =?utf-8?B?NHNCWmYxcUlEUkVRbEtKbnE4WjJLalJDRGNuVFVvN2VBZmN1MlVwZVpIZWoz?=
 =?utf-8?B?VUxNa0ZtZ01GeVA5YVVELzhOOWlmd0xsMEFUUlNjdUwxNThqS2pCVCtTRUdU?=
 =?utf-8?B?VGpyNG5TTHZZM1JUVHU3TTBCVnUwSkZOQk0rWmNoUEJVcUl3SFdSTmtUR0Ny?=
 =?utf-8?B?OGQwMFNXK0V6OEs5YmliMXRrdU5tODVmaFBheU93N3NFS2hqQVlBMmNGZGJK?=
 =?utf-8?B?eTBvWTVPY3ZSL0lnZGFpMW0rM0NpYW4vMERaMTlCaVpET0VRQWg0alZXb2Ur?=
 =?utf-8?B?RldTNGFNc01leDZQNHNFdnJuSHUzMk9oNy9XbHVTM3RmMG9ZL2QvRmoxRjFR?=
 =?utf-8?B?azVVSGsrMU9mMlExMHQ5czJLRHc1a2FpRTVpdVFPbHJHQkF5aHFIOFk0bUFm?=
 =?utf-8?B?Q0Z1MWFkZjdSSnJEby9EM1FVVmxqWVBrOWpCMTNSM1ZQMFFKRS9aRzhKU3Bw?=
 =?utf-8?B?cnR6NDV6R0h5ZU1sRG1oajNMTkxMZVo5ei9renoxc1J1RDNZZjNaYm0zUVdm?=
 =?utf-8?B?Zmw4VnJjdUZ3Qm92ZXVORTBmNHA3bm1nRE5hK29OdStXcFBJd3Y5dEFwcHM4?=
 =?utf-8?B?Nkl5cWZHVlBEVjd5eGU4dWRzRjdZaW5QZWMvZU1peEwwY2pITGh5aUxNTWJ5?=
 =?utf-8?B?R1A3R05RaXNRZlhmQllGNWtpSTI0anViZUxwbkl3UmE5V2ZhSkdMUHVlbFFz?=
 =?utf-8?B?QW1sZHZ4ajhWOUd3VlNiRWFjYkVqSldJWWprN2RLNkdYOW5COHg4d3BIL2lQ?=
 =?utf-8?Q?aMyOhOI86n5VSmdhS+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3229a-6a23-4152-05a5-08de4c050dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 02:49:32.2775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8t5NhH5KDoe7r3p0b1pf8k8jdIX0nhdrZMdKQbHgce+4oYXxxHnEfK+LW0MKYIa418ZI1bxg+ozeU6ecZ6pyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
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

PiBTdWJqZWN0OiBSZTogQVc6IFtQQVRDSF0gbW1jOiBGaXggbWlzc2luZyAxIG1zIGRlbGF5IGFm
dGVyIG1tYw0KPiBwb3dlciB1cA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIERpLCAyMDI1LTEx
LTE4IGF0IDEyOjU2ICswODAwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiBPbiBNb24sIE5vdiAxMCwg
MjAyNSBhdCAwODo0NjozOVBNICswMDAwLCBDaHJpc3RvcGggU3RvaWRuZXINCj4gd3JvdGU6DQo+
ID4gPiBIaSBQZW5nLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQo+ID4gPg0KPiA+ID4gPiBI
aSBDaHJpc3RvcGgNCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KPiA+
ID4gPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBGaXggbWlzc2luZyAxIG1zIGRl
bGF5IGFmdGVyIG1tYyBwb3dlcg0KPiB1cA0KPiA+ID4gLi4uDQo+ID4gPiA+ID4gK8KgwqDCoMKg
IHVkZWxheSgyMDAwKTsNCj4gPiA+ID4NCj4gPiA+ID4gUGVyIHNwZWMsDQo+ID4gPiA+IEZyb20g
RmlndXJlIDYtNDogUG93ZXItdXAgRGlhZ3JhbSBvZiBDYXJkIHRoZSAxbXMgaXMNCj4gdm9sdGFn
ZVN1cHBseQ0KPiA+ID4gPiByYW1wIHVwIHRpbWUsIHNvIEkgYW0gdGhpbmtpbmcgdGhlIGZpeCBz
aG91bGQgYmUgaW4geW91ciByZWd1bGF0b3INCj4gPiA+ID4gc2lkZSwgc2F5aW5nIHN0YXJ0dXAt
ZGVsYXktdXMgcHJvcGVydHkgaW4geW91ciByZWd1bGF0b3Igbm9kZS4NCj4gPiA+DQo+ID4gPiBU
cnVlLCB0aGlzIGNvdWxkIGFsc28gYmUgaGFuZGxlZCB2aWEgdGhlIHJlZ3VsYXRvcj9zIERUUyBw
cm9wZXJ0aWVzLA0KPiA+ID4gYW5kIHNvbWUgYm9hcmRzIGFscmVhZHkgZG8gdGhhdC4gSG93ZXZl
ciwgZnJvbSBteSBwb2ludCBvZiB2aWV3LA0KPiA+ID4gdGhhdD9zIG5vdCB0aGUgcmlnaHQgcGxh
Y2UgZm9yIHRoaXMgcGFydGljdWxhciBkZWxheS4NCj4gPiA+DQo+ID4gPiBUaGUgU0Qgc3BlY2lm
aWNhdGlvbiBkaXN0aW5ndWlzaGVzIGJldHdlZW4gdHdvIGRpZmZlcmVudCBkZWxheXMgKHNlZQ0K
PiA+ID4gRmlndXJlIDYtNSA/UG93ZXItVXAgRGlhZ3JhbSAoSG9zdCk/IGluIFNEIFNwZWMgNi4w
MCwgPzYuNC4xKToNCj4gPiA+DQo+ID4gPiDCoCAxKSAiUG93ZXIgcmFtcCB1cCINCj4gPiA+IMKg
IDIpICJTdGFibGUgdm9sdGFnZSBkZWxheSINCj4gPiA+DQo+ID4gPiBUaGUgZmlyc3Qgb25lIChw
b3dlciByYW1wIHVwKSBpcyByZWd1bGF0b3Itc3BlY2lmaWMgYW5kIHNob3VsZA0KPiA+ID4gaW5k
ZWVkIGJlIGNvdmVyZWQgYnkgdGhlIHJlZ3VsYXRvcj9zIHN0YXJ0dXAtZGVsYXktdXMgcHJvcGVy
dHkgaW4NCj4gPiA+IHRoZSBkZXZpY2UgdHJlZS4NCj4gPiA+IEJ1dCB0aGlzIHBhdGNoIGlzIGFi
b3V0IHRoZSBzZWNvbmQgb25lIC0gdGhlICJzdGFibGUgdm9sdGFnZSBkZWxheSIuDQo+ID4gPg0K
PiA+ID4gVGhhdCBkZWxheSBpcyBjb21wbGV0ZWx5IGluZGVwZW5kZW50IG9mIGFueSByZWd1bGF0
b3Ivdm9sdGFnZS0NCj4gPiA+IHN1cHBseSBvciBib2FyZCBjaGFyYWN0ZXJpc3RpY3M7IGl0IGlz
IGEgY29uc3RhbnQgMW1zIGRlbGF5IGJ5IHRoZQ0KPiA+ID4gU0QgaW50ZXJmYWNlIGl0c2VsZiB0
byBlbnN1cmUgY29ycmVjdCBjYXJkIGluaXRpYWxpemF0aW9uIHRpbWluZy4NCj4gPiA+IERlY291
cGxpbmcgaXQgZnJvbSB0aGUgcmVndWxhdG9ycyB3b3VsZCBtYWtlIGJvYXJkLWNvZGUNCj4gZGV2
ZWxvcGVycw0KPiA+ID4gbGl2ZSBlYXNpZXIsIGFuZCBjYW4gbWFrZSBVLUJvb3Q/cyBNTUMgaW5p
dGlhbGl6YXRpb24gbW9yZSByb2J1c3QNCj4gPiA+IGFjcm9zcyBhbGwgYm9hcmRzLg0KPiA+ID4N
Cj4gPiA+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoYXQ/DQo+ID4NCj4gPiBTb3JyeSBmb3Ig
bGF0ZS4NCj4gPiBUaGFua3MgZm9yIGV4cGxhaW5pbmcgdGhpcywgdGhpcyBpcyByZWFzb25hYmxl
LiBJIGFtIHRoaW5raW5nIGl0IG1pZ2h0DQo+ID4gYmUgYmV0dGVyIGlmIHdlIGFkZCBpb3MucG9z
dF9wb3dlcl9kZWxheV9tcyBmb3IgeW91ciBwbGF0Zm9ybS4NCj4gDQo+IHlvdSBtZWFuIHdlIHNo
b3VsZCBpbnRyb2R1Y2UgdGhlIERUUyBwcm9wZXJ0eQ0KPiBwb3N0X3Bvd2VyX2RlbGF5X21zIGZv
ciBtbWMgYW5kIHRoZW4gdXNlIGl0IGluIG91ciBwbGF0Zm9ybSdzIERUUz8NCj4gDQo+IEJ1dCBh
IERUUyBwcm9wZXJ0eSBpcyBhY3R1YWxseSB3aGF0IEkgd2FudCB0byBhdm9pZCwgYmVjYXVzZSB0
aGF0IGRlbGF5DQo+IGlzIG5vdGhpbmcgcGxhdGZvcm0tc3BlY2lmaWMgYW5kIHNob3VsZCBiZSBz
b2x2ZWQgYWxsIGZvciBvbmUgaW4gdGhlDQo+IG1tYyBzdWJzeXN0ZW0gZHJpdmVycy9tbWMvbW1j
LmMgaXRzZWxmLg0KPiANCj4gV2hhdCdzIHRoZSByZWFzb24gd2h5IHlvdSBwcmVmZXIgYSBEVFMg
cHJvcGVydHk/DQoNCllvdSBtZXNzYWdlIHNlZW1zIGJyZWFrcyB0aGUgbWFpbCB0aHJlYWQuIFNv
IG15IHNjcmlwdCBub3QNCmFibGUgdG8gcmV0cmlldmUgdGhlIG1lc3NhZ2UgdGhyZWFkIGZyb20g
cGF0Y2h3b3JrLg0KDQpJIGp1c3QgZG9uJ3QgbGlrZSB0byBhZGQgZGVsYXlzLiBSZWFkaW5nIHRo
ZSBzcGVjIGFnYWluLA0KSSBhbSBmaW5lIHdpdGggeW91ciBjaGFuZ2VzLiANCg0KVGhhbmtzLA0K
UGVuZy4NCg0KPiANCj4gUmVnYXJkcywNCj4gQ2hyaXN0b3BoDQo+IA0KPiA+DQo+ID4gUmVnYXJk
cw0KPiA+IFBlbmcNCj4gPg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDaHJpc3RvcGgN
Cj4gPiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gUGVuZy4NCj4gPiA+ID4NCj4gPiA+ID4g
PiArwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gPiA+IC4uLg0KDQo=
