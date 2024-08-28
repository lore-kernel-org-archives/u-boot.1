Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B3EC54E71
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 10:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE0488381;
	Wed, 28 Aug 2024 12:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FuIsNFI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A621288580; Wed, 28 Aug 2024 12:58:31 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3226788363
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 12:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAHIHRMBQAgDX0aYzxBKPUoByLe1bJFWOxMY7qtuvhE8C1k+0Wup8wUYCtKsI1cEANsxpMgRZ5O9viCLvwWNSabtrrhUHDMCrwP7FIPKcV7Udq2iNRvSbY0eo6A86Ke5l2kosPtXJHYjjzX6NPdfhW+WtdWVytl6KiS5Y6qv842plSWlebGYgcrwJTXg7gA9vmYz0Vjnc1waUPRG9BpWE2HLE84xP+NcCjjOmGGMDdwRRZgGjG/wqqnhFtrA+MWY8x2WcDj0OJLPjyQvBy7X1L3I3iiocDLJtlMN6T2KejuJiwhHWBdmmVUoE8/QjQWW15fBlEAhzbKs9iz+Vm2+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKUtedVv/f2DWDADFNDIrC7wgYST5gFGm4UM0Cl2xNQ=;
 b=g2zrwP6LuF3rW1b8eN5n2B65KSl7/iPzn1dXtrde2rA6SN//O1Y0uTIL0IZWJQ4Lx1+zFxq4ze2bUF9kcKYH7m+o8DVPHUDVvzo5WvVdawjoK4f0viy0gR38bAb3kN0DzJT2idn1XJuwz2KQASqxELHQM4BcfzpieKL3x9jmtWkkRKqYIHtxTHKXvwo1WaPseLKUDqRDbyxXKcHGrisxaoYNLZziuLHB6lD70gmqu4GK6wFq72uNCDqD38MY6ivIcCf+6ijPKFKEnaGTvV4JH510oai7NNYZ+TKFiho+XpCkxGSAfb2R3tntSBzgCl9p5CVSkDggX4jzrnMXt2inIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKUtedVv/f2DWDADFNDIrC7wgYST5gFGm4UM0Cl2xNQ=;
 b=FuIsNFI1ynQ/g3GBrkXLHzMf5OBS871L0SDyxXrnstMiD3YJzGY61MXEnOUmUf6j+0SvlmAtcw4EWHo+w9cYxUAGgppCnocIDYVDZPYqWEVsau46tukuz//LAde3tiESB3vWNSqAxT5abAqlFMclNkAt6ID1U2H0Y14u3Hqww94=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DS0PR12MB9447.namprd12.prod.outlook.com (2603:10b6:8:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 10:58:26 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 10:58:25 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Michal Simek <monstr@monstr.eu>, Tom Rini <trini@konsulko.com>,
 =?utf-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, "fabrice.gasnier@foss.st.com"
 <fabrice.gasnier@foss.st.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek, Michal"
 <michal.simek@amd.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 0/7] Add the USB5744 hub driver as per new DT binding
Thread-Topic: [PATCH 0/7] Add the USB5744 hub driver as per new DT binding
Thread-Index: AQHaty+CrPuLKWh4VUujl8FyiUWS2LH37QIAgEUWsGA=
Date: Wed, 28 Aug 2024 10:58:25 +0000
Message-ID: <SA1PR12MB869736B5EC2F0B58B02C75A398952@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <CAHTX3d+fpBhnTmqoGQCaC33rKCAcBsDk5JtdNrd-nXfG1kq0wg@mail.gmail.com>
In-Reply-To: <CAHTX3d+fpBhnTmqoGQCaC33rKCAcBsDk5JtdNrd-nXfG1kq0wg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DS0PR12MB9447:EE_
x-ms-office365-filtering-correlation-id: be747a83-797b-4aef-4d39-08dcc750571f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aTRGdGNrNk5qSm5XM0N3cW9UdHhiSTVqckYrLzlmTzBIS3Bqd2Nkc3o5TlA2?=
 =?utf-8?B?K1RENDh1UXpsUit0UVJZS3c3Zi9PTHpCVlM0cG9HS0dQZUZwVTU5a0VFTDho?=
 =?utf-8?B?UFNLZXU0MS9uempUS3o1eGFXYUhKRXZNaytxdDZiUm02OStpN0Y5ZXc2S2ta?=
 =?utf-8?B?b0ZYcFJpQ2ZOUk8xSWpiYWZxaGVWUXJiM0tHN3RQMlFhWnNnQitjWVk1Qnov?=
 =?utf-8?B?WlIydEFwaWlCS2NyUGp4NWh2VW1jdXhUQ3J3U1dUZVVoSGNHbDBsM1kzaEhU?=
 =?utf-8?B?bTNQWXJnRWx2TUpRRkk3QTBxbGlJZDhrU21oVjFIMytSTnJOVHRUVDhsdXFn?=
 =?utf-8?B?b1ZOSlFaeXBtWk5sUTBFb3BIMFFTM3VVUmVPOWhacm5EbEdqYW4zbkZYbmF0?=
 =?utf-8?B?R1JMbHhFclpsRkE5Y3lKeElkZDBrdmlzRXR5V1Y0NlJkUWhFbERDWDdjSjQ2?=
 =?utf-8?B?QWJHOXVNcjViNGkrSUZxQTBncmRaWGN3RU0waE90bExacWxIeStSenU1ZkN4?=
 =?utf-8?B?SEROVFdudDFobkNNSjQ3WjlXcFpzNXovQ1BOZEdOd0Vsclp1b3JvUG5ReEE2?=
 =?utf-8?B?TmxkMFpSNjlZZm9DL2JIL0ZZMDZFN3Z0U2V6R3dabWZiTmQrSE5raklCZjNi?=
 =?utf-8?B?V3VObDhPbENUN1dOS3pNY2pEOW1QK0JFcG9zWTBxeFRIZFZXNFR1NXhIdWFE?=
 =?utf-8?B?UkNSTmd6UGpVOWw5eEhZU2RYWmhWbHdFZmlhSWM1c2R5T2xPOWZhY3Y2MHJa?=
 =?utf-8?B?akEyN0NtZHZPUHJDa0pPQnFKZUJnUnlGU0p6U05YK09vY2dDaDlnUmsxZG5F?=
 =?utf-8?B?V3BzeklVSHBIdDhJdzJ6SmQvajdWZDBhUWJJRTN0UGRmbEJRc1NtRlZNTkIv?=
 =?utf-8?B?emZjZ2hrUWlVOWxWd0dsTXRwSEpiWS9xNFVoRlVHL2NoRkJxVUFSMDdvb2tk?=
 =?utf-8?B?NWZLMFA0VmE5d0x2ZmFqdHRHMkMzd2FNY2JuMUVERGkrSC9lamdxN0hreDBK?=
 =?utf-8?B?QmNNL0w3NnhlRDRZVEwwZjFTN1JLd1pyLzhDSXY5OUVMNEl3bzREMXg4UWc2?=
 =?utf-8?B?bU1KSE5JWlI0blpjQk42WEVkVnVhczVRRG45TExNOVVyMWZoQWVqbXdQeHhV?=
 =?utf-8?B?MEU1QjlQcUhISEtYLzFkbEFXRXZObnBRSXdPbWY4QXpmUkRNSndjSlRWVkVy?=
 =?utf-8?B?QlFmRUE2R1RucUpGT0FObFZ5c2o4Ym9hR0V4MmtqeE1CWEV4citJaWhuclMx?=
 =?utf-8?B?TWw5aUxWUWI1d0pwUmU3bW1VcGpXamZtUXZyTTBDRUNDZzZQdlVVWUVscFBM?=
 =?utf-8?B?T3hiUmZkTXdxS0NrUkhOZWJmV3JONVZzRDl0U01pR2dNMmd5OE5jMVY4SzBM?=
 =?utf-8?B?em1lbk4ybXNRZEgvdXdIMEYxOVFMZGlnempUQnJYcVU5ZGVrNVp1UzFxOXdR?=
 =?utf-8?B?c0dIWHI3S3NJR0oweTF5RGlaT3dJckY0UWk1cjZ4Tmt6aCs0TXB0enFqREVT?=
 =?utf-8?B?WHB1eFhpREtCSEU3SWJ0ZUhqVlFlZk8vUjVJTEE3QnovZFFna2dYT1JQU0Jt?=
 =?utf-8?B?OWc0aWYzSGZxdFVJeWZFZllRVkwvWmo2T213MFZ2WTgrNkZneE5hVU9GdTUv?=
 =?utf-8?B?OHhJYnd2UmFqUVJ4cmdzYlhoSlQycVoxV0RScWgrRzB3RElBWEx0U2NyT0oy?=
 =?utf-8?B?R0NlNmdlSmNSTDJVL253SHp5UXhIcHlGcTgwTmh3YmF6Q044aml4a2hKOVpu?=
 =?utf-8?B?c1VWSE9YVzdCY3cxL2VyMlFDcmk5WStwSWdDWnRMTUk1QWJmcEY1RVp4RFFt?=
 =?utf-8?B?VFpQVmkzNExJSnp5anNBQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnFUbXRnblFFK1NKdXFwMjZCUW1nYTlweEtaY3YzQ1IwekNUUVlSSTV1R2Vj?=
 =?utf-8?B?cm94NWdyS3hXdkZPRzhKTG0wdkM2TC8rK0xLTHg2TWR6a1Z0QWxnT0NrZXQx?=
 =?utf-8?B?ekUyVU44VDNXSVR6UkZYbXZab2pac2RCMUxlekNHMGJydlR0cnQyMXFHZHh2?=
 =?utf-8?B?VE9wTXJuVGNOTTJVR1N2WHRIZnVjU3J6Z1ZoL25YSW5aeTVaUjRRU29nMFNi?=
 =?utf-8?B?V21oWXBkRUpSVTZuVmcyUnNYcHpML3lQYVVYWU85WXBKb29DOGhjU0RnRE52?=
 =?utf-8?B?L3pUN3RjNFpRaVlYMXVBYi9zcVE1cjZYdVEwd0VHYjJYVUltWWZkQTVnZlgx?=
 =?utf-8?B?WUs1OVl2YjhBL210Rm1FN2EyVkpibE9DVVo4WVBIeU5mN0w0Sks5amluaFg5?=
 =?utf-8?B?NWpWMHl5Q2syZzIvWHY5aDJhazNua3BLM2ExQmdxdkpGYlROWW5hZDBTb05U?=
 =?utf-8?B?aS8yQktjTHdCM0p6dGVHNWIyNnV5aTFhTUFoTjV3SVpscFh1eVpTbkdxWlJX?=
 =?utf-8?B?Y3R6MmpYUzF0RnNwcGpRNG5sMWFIWWo5KzZ4UmYxM0pqSWJSbG8xcVlVMjlt?=
 =?utf-8?B?SXBEb1JYNmlGTWp1d2ZZb0V1OVhqdWY3SEQxS00veTZMeEFhYk55elFQSnlY?=
 =?utf-8?B?TnppY1YvOFhTTW5Xem9yUnQ3V3kxR3dGZU5HaHgwL1ZMNlR0QTNMMTBPblN2?=
 =?utf-8?B?TnV2VmhpWHVlZTN1NHJaLzBNNEtPZGtiMWF5VisvMU02cEtQTld0bU1iRUEw?=
 =?utf-8?B?V3QyaXl1VEhVOTRSM0U5V21lUHAxMDJMY2NSU0cveVgyM25Nd2NwY3NCQTZr?=
 =?utf-8?B?VTBEM3ZVYUtzUEVNcFJab2h0RmM0dTBKc2RxQzVVSUF3YVMxTEtuQ1RDb2V6?=
 =?utf-8?B?cThEUWpRUlZySlYydjIyOTBZMnVVYUNJVWlOSHlpTENrZHY1c3llY3Exd3l3?=
 =?utf-8?B?UU01ak5kMU5HMU4vTlBsWlRKS0JZOG1UL2d2aUx3UWUxTVhoQzZ2UzF6NE1M?=
 =?utf-8?B?REsvWlA0MHNGM0k0MXNiWG55OFlvWnRQQnV1ZW44dmNUZVl0M1RvRVFpcGNO?=
 =?utf-8?B?M1FiM0tmTWxETStzTExsZWhzTnRyNFBrOCtYdlQzUHZNYVlneTVjYWdTNDcx?=
 =?utf-8?B?TktZN2o3TFhBaTQ5NllRczdZS25ZaGFudGh1elRWMTMyUHIzMFF2djZUT0ZW?=
 =?utf-8?B?WGNBaWxhb2grVGt4c0dUV0Q1ZEtyb3ZjL3RTQ1RBV2JoR1RLcHN2SkxnMTNK?=
 =?utf-8?B?ckM1a3YwMG9EcDF0bjlXM082Z3kwMUhCMTBKLzQrMWd4eDBQbk9za1JUT0Yy?=
 =?utf-8?B?emxwZ1FDSzJzbVkwbjA1bHQ0NXh4MWQ4bXJYWElOV2FqeGNKU1dnRGMvTGVD?=
 =?utf-8?B?bnNyKyttZGRmRVN1RnUwM3k2N0NQcjYzR3M4Q09sRWM0R2N4RW9mVEZscHd1?=
 =?utf-8?B?VWJ5a2p4TnZKNmk2OFZ3Qk1VYVNFUERyemp0TURsNFRKQU5NbXgwNDhrZ0U1?=
 =?utf-8?B?RUczdjY3R2R3cHNncmZlV1dRb2VwaGFwY1hBS3hvdSt2eFF6MkRUWUxKT0ZS?=
 =?utf-8?B?Vkx0OFVZM0xsSklaSUViMDc4dzFTUUZyZGRGbGROWUtGSXIyb3pRQWxKdE9Y?=
 =?utf-8?B?YTR0U3VyT1ZPckhYQXdoaXNMRENHTCtUdkYvM1k2eG9UTzV0ZWNqcGRKVmgx?=
 =?utf-8?B?azBQVWZCT3p3eEhpY1NXUWcvOUthVjRMV0JyMDhVWkFzYUpZbE91L1A0K2NZ?=
 =?utf-8?B?N20wN1RFK0pvcUxhVkticWl1R3oxcFkvMVFRKzlyVFB6RFIrcXNmOWhDdnBF?=
 =?utf-8?B?Wmg4ME1XM3pBN0Fpa3N3L3QwbFhXejNOUUVtaXQ4bmx4cEgvTDlCeDFhL2w3?=
 =?utf-8?B?NW01SmV5SkxRTVh1eW80TkMzL1duTXpkUkxwMS9UamM1L3hYc1QrWm53Wlp6?=
 =?utf-8?B?bkpzalNtUS9xZkdPbXp5VHAwNUtLaEtRam4xRU9UUVd6SDRvUTRLWC9JNndx?=
 =?utf-8?B?UDJZSytuTGJyRWVwdnlrRHA1SWVidm0xVXVJM0xkQWxLSnlJLy9ZK0NaMGoy?=
 =?utf-8?B?aWF0b3ZhWmdXK0RqSFdIVVZkbWNlYjJXendQZVBQU0ZBMzc3ak9PUU84SWR4?=
 =?utf-8?Q?BnnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be747a83-797b-4aef-4d39-08dcc750571f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 10:58:25.2293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPMItqwlKSOVsWoMQ0xkdXq/K/bmFjTDhzj0CsYwA/wQ+Rj3TSSw69NZ4+oXXvw940pR3gjOlSOEv31rv9AfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9447
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

SGkgTWFyZWssDQpEaWQgeW91IGdldCBhIGNoYW5jZSB0byByZXZpZXcgdGhpcz8NCg0KVGhhbmtz
DQpWZW5rYXRlc2gNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFs
IFNpbWVrIDxtb25zdHJAbW9uc3RyLmV1Pg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTUsIDIwMjQg
NToyNCBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFt
ZC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28uY29tPjsgTWFyZWsgVmHFoXV0IDxt
YXJleEBkZW54LmRlPjsNCj4gZmFicmljZS5nYXNuaWVyQGZvc3Muc3QuY29tDQo+IENjOiB1LWJv
b3RAbGlzdHMuZGVueC5kZTsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBn
aXQNCj4gKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAw
LzddIEFkZCB0aGUgVVNCNTc0NCBodWIgZHJpdmVyIGFzIHBlciBuZXcgRFQgYmluZGluZw0KPiAN
Cj4gSGkgVG9tLCBNYXJlayBhbmQgRmFicmljZSwNCj4gDQo+IHN0IDUuIDYuIDIwMjQgdiAxMjow
MiBvZGVzw61sYXRlbCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUNCj4gPHZlbmthdGVzaC5hYmJh
cmFwdUBhbWQuY29tPiBuYXBzYWw6DQo+ID4NCj4gPiBBZGQgdGhlIHVzYjU3NDQvdXNiMjc0NCBo
dWIgZHJpdmVyIHdoaWNoIGRvZXMgdGhlIHJlc2V0IGdwaW8gdG9nZ2xpbmcNCj4gPiBhbmQgdGhl
IGkyYyBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZS4NCj4gPg0KPiA+IFRlc3RlZCB0aGUgVVNCNTc0
NC9VU0IyNzQ0IHVzYiBodWIgZm9yIHVzYjAsIHVzYjEgd2l0aCB0aGUgRFQgbm9kZXMgb24NCj4g
PiBLUjI2MCBib2FyZC4NCj4gPg0KPiA+IFZlbmthdGVzaCBZYWRhdiBBYmJhcmFwdSAoNyk6DQo+
ID4gICB1c2I6IG9uYm9hcmQtaHViOiBBZGQgcmVzZXQtZ3BpbyBzdXBwb3J0DQo+ID4gICB1c2I6
IG9uYm9hcmQtaHViOiBGaXggdGhlIHJldHVybiB2YWx1ZXMgb2YgcmVndWxhdG9yIEFQSXMNCj4g
PiAgIHVzYjogb25ib2FyZC1odWI6IGFkZCBzdXBwb3J0IGZvciBNaWNyb2NoaXAgVVNCNTc0NA0K
PiA+ICAgdXNiOiBvbmJvYXJkLWh1YjogQWRkIGkyYyBpbml0aWFsaXphdGlvbiBmb3IgdXNiNTc0
NCBodWINCj4gPiAgIHVzYjogb25ib2FyZC1odWI6IEJhaWwgb3V0IGlmIHBlZXIgaHViIGlzIGFs
cmVhZHkgcHJvYmVkDQo+ID4gICBjb25maWdzOiB6eW5xbXBfa3JpYTogRW5hYmxlIHRoZSBVU0Ig
b25ib2FyZCBodWINCj4gPiAgIGFybTY0OiB6eW5xbXA6IFVwZGF0ZSB0aGUgdXNiNTc0NCBodWIg
bm9kZSBhcyBwZXIgYmluZGluZw0KPiA+DQo+ID4gIGFyY2gvYXJtL2R0cy96eW5xbXAtc2NrLWty
LWctcmV2QS5kdHNvIHwgIDQ4ICsrKysrKysNCj4gPiBhcmNoL2FybS9kdHMvenlucW1wLXNjay1r
ci1nLXJldkIuZHRzbyB8ICA0OCArKysrKysrDQo+ID4gYXJjaC9hcm0vZHRzL3p5bnFtcC1zY2st
a3YtZy1yZXZBLmR0c28gfCAgMTggKysrDQo+ID4gYXJjaC9hcm0vZHRzL3p5bnFtcC1zY2sta3Yt
Zy1yZXZCLmR0c28gfCAgMjUgKysrLQ0KPiA+ICBjb21tb24vdXNiX29uYm9hcmRfaHViLmMgICAg
ICAgICAgICAgICB8IDE3NiArKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIGNvbmZpZ3Mv
eGlsaW54X3p5bnFtcF9rcmlhX2RlZmNvbmZpZyAgIHwgICAxICsNCj4gPiAgNiBmaWxlcyBjaGFu
Z2VkLCAzMDQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+
IDIuMTcuMQ0KPiA+DQo+IA0KPiBDYW4gc29tZW9uZSBwbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhp
cyBwYXRjaHNldD8NCj4gDQo+IEkgYW0gZmluZSB3aXRoIDYvNyBhbmQgNy83Lg0KPiBBY2tlZC1i
eTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4g
TWljaGFsDQo+IA0KPiANCj4gLS0NCj4gTWljaGFsIFNpbWVrLCBJbmcuIChNLkVuZyksIE9wZW5Q
R1AgLT4gS2V5SUQ6IEZFM0QxRjkxDQo+IHc6IHd3dy5tb25zdHIuZXUgcDogKzQyLTAtNzIxODQy
ODU0DQo+IE1haW50YWluZXIgb2YgTGludXgga2VybmVsIC0gWGlsaW54IE1pY3JvYmxhemUgTWFp
bnRhaW5lciBvZiBMaW51eCBrZXJuZWwgLQ0KPiBYaWxpbnggWnlucSBBUk0gYW5kIFp5bnFNUCBB
Uk02NCBTb0NzIFUtQm9vdCBjdXN0b2RpYW4gLSBYaWxpbngNCj4gTWljcm9ibGF6ZS9aeW5xL1p5
bnFNUC9WZXJzYWwgU29Dcw0K
