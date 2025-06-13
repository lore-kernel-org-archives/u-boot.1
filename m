Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55DAC71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 11:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE46580C93;
	Fri, 13 Jun 2025 13:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="S+l1jV7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEC382C84; Fri, 13 Jun 2025 13:20:30 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F02807B1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 13:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGQypC/KrWyflb7f3fsUKqfqT27rImg5f4oOaQxXmxgDF8ohS6EeyLpGugjo6ajU/C2UIHl8Lrdgp7xlbpblKSSbpRUtQ0dCBFRvJfXgjyHZDayWkSSM67JcjD1+C8Wex+mmJ+s4z2PwByFdA2LKjDkh/K2qbyk7INpUmIn/00/DrV3s2t8Xq152HeDwq7HR42wMePgX0ZhnMBukKezc7eDOlQzd6JEWmzutjI+fqQ6lW8wAged9e6whkyPKExWzPRE0/sG337to5C1ptioYfN1RthuBzZdsxngoqBywrWNLzVVk1by13cOvSr1yDDvpHl3+m6gBvpxe3ZudGkx6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AgpXz8eL+xYrgmPdJBpp7uCM5cfJq6wPNZKeopT1Ss=;
 b=GGFAg2L7lvGU5kcHOQypABwDtE7hEtAsSad7wsfGUP7xvFrZiT0A5y3Wi1b8Z8EO47sgl9h8UvBFCfegvcYdL9DRyDYfcZ1OBG8ujnCB57YXtUooWVO9XD8PrZ8gkc6ouyf4QxbVm3ZtEd2oUOurSGd1LjwTGnnvaHo+pO0+1rDfp8rn0AFOQfQFFIt2Ylfj0tOSRGsBLVbC1/40EPGN8ROwPc1Ii/lvqzBHNuhrjXPoznKRSCzzEtQrTIqhwYY9G9ZcmscN/GwnXkBY3oaSVUpnxJr+JpFHe0PLvcmA/MGNvh/UOlnRn0i12dzYiCsJCAqByWVfjkZoZybEESzkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AgpXz8eL+xYrgmPdJBpp7uCM5cfJq6wPNZKeopT1Ss=;
 b=S+l1jV7ohyy8d5+Bxmg6yh0uSUswssBSTKDnyKXhbeBp93FrO9uP9EfazL0LR2wf8zRCoBKlPnWfE1WbMN/An2+Rlu5d3TAUv4yGJ5vUm1u4dYDJyXM5dmjp2remAbnbZj3nB+7BatmmNI3oBK5QjEyhhjukZopWTxTWXSr5Am07ATiak1eDjgjhhlFeyLGBHMECyaEa5JKSX/xqdvQmaV0bcwxzi9uWOOB+kfFE7CeOlQQT7eB9/5DkPH4IhJDz6Ud6dELYwMde21CACt3zRv2jVVn11S8tEDE2bdt3bXXlU3349NsonOqXPeUrk7yRoTaPWiKwHZ3ibry4176NlQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PA1P195MB2582.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:449::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Fri, 13 Jun
 2025 11:20:27 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8792.040; Fri, 13 Jun 2025
 11:20:27 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH RFC v2 7/8] tools: binman: ftest: fix tests that require
 non-faked ext blobs
Thread-Topic: [PATCH RFC v2 7/8] tools: binman: ftest: fix tests that require
 non-faked ext blobs
Thread-Index: AQHbzwqy9D8VvVZ18Eq3MQkWPph3O7PrCxYAgBYBKIA=
Date: Fri, 13 Jun 2025 11:20:27 +0000
Message-ID: <ab4537d6c4f10bd1b8e24a89851bf6b81dab8139.camel@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-7-3362ab897581@phytec.de>
 <CAFLszThr2Qmyt3gkS6r_tC_Gwp8Bydf2zSx298r80k5iSk2vWQ@mail.gmail.com>
In-Reply-To: <CAFLszThr2Qmyt3gkS6r_tC_Gwp8Bydf2zSx298r80k5iSk2vWQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PA1P195MB2582:EE_
x-ms-office365-filtering-correlation-id: 46dd7e11-492a-4ae9-6fad-08ddaa6c4cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c2c4b2xlOGc0bzhuMjNuT0gxWG9pcENiZDVVRndZSUZuc3ZrU2d6SEZ1OTc3?=
 =?utf-8?B?Nnk3aVZZN2xWVjRzM3Fkdkg2S2JueE9pd3JvUWtMQ2wzK0xoS3dhdHVvaVY0?=
 =?utf-8?B?OEpPRUdkanpRdmZZN1RaZ0NDQXJYZi94a1o1eG5sZlU5YjRlTEFPT04wczRS?=
 =?utf-8?B?V0U4dWEzVTIrc05hTkNUc2dNZDJ1NEtWRWVyVDJlYkZPTWJZL01LWlMwVXg1?=
 =?utf-8?B?K2RrLzRLRTVscXYzK2JvQWUrZjQ4c3cxQ1Q1T2xsbmZIRHozYnRsVUtPWnFS?=
 =?utf-8?B?YTBHcy9nYlJ2L0FuNkVLNFgrRTN5dTkyeDJrSjV3MkdvbzVINmpsd3VFZkZp?=
 =?utf-8?B?OHk0VjI3S1NpVVoyYkd6RG5tU0hHRkQvQzA0K3gveHhHaGxXNW5tR3ZIMnd6?=
 =?utf-8?B?WmlGZDQrY1JEN3dEZmFIS2lIUkd6UzN6ZUIwR3Y4OEMvS29GVkl4VXF0b2dN?=
 =?utf-8?B?ZElveDhJT0t6S0JtT3M1WXJVeXFMSFRSZkxxNVhVNmtCMnBrcXZUM21JejZ5?=
 =?utf-8?B?WU9CQmQ1Q2loNUdZM3dwaWdJQzFWbjNXcC84a2tJWlV2bTFKWHloSnNSTjdo?=
 =?utf-8?B?MzdVZW5tNXpKanhLZ3Y0K3RESFpBUWlMVlJQQVliQ2kybHVhY1JMSFNWLzYy?=
 =?utf-8?B?L3RhT3BISllYN2hkVTBzbG0yK0lYaldKK1dpR25lTTVwTElTZWphem9mZkE3?=
 =?utf-8?B?NGJzMEhxMkxIckhtUU4wb0F0Y3NQY0c4MlFCWFlYSzExcDh5NjFJcXZKdWhr?=
 =?utf-8?B?cHN0c0M0eWJmdC9jMmlPUWVwaENpTTZwaWRPRWNUMjRIQUo4c1lHTlpyaVRC?=
 =?utf-8?B?Y2VLWXdsL1dCK0VTUzNUdndjZng3S1l6akFzQ0I2aGRrelUwUmVKMjFlYzU3?=
 =?utf-8?B?dXd1Wis4bFhIVTVDUE41RmlCdnFsa1NRM1JVWExCbktSdU1taVVYQ005Zk5J?=
 =?utf-8?B?RTZyWkNUeFdEeGQ4UldmRnlKTjFtUGN0TTdqQ3c2Y054cjBxdWdzS2RwT1Ny?=
 =?utf-8?B?NW94UkxUbHNWWlF3SUJUakVjZFhpc3FhKzJOQlNPV2daeG9KZ0RYeGxzL050?=
 =?utf-8?B?Rnc4YS9LcU1KVmRmL2R6Nm9FY3pLcU1YZ1FEOFVTTVZrMDc3NTNHSzRiZlVj?=
 =?utf-8?B?c0g1V1l2MGtYRXVodEo0UG9PbGlCNEhmYmQxa1pHejlLUnZsYWFhU2JHK0lP?=
 =?utf-8?B?cGNaaEJ5UGVpaHVtODdFU0hNTGN5UThIYjViSUZhcjdEUVZNOVNacWI0alBs?=
 =?utf-8?B?d3FKRzN3eFVWY01WTHRHMXJzeTRLTkRIVlFVM0dZcHNyc1d3VWp2WUVGTG13?=
 =?utf-8?B?N29oYjZsRGxvQjBaeVVrd3hIWjRUSHo5TE4rSUNBTEtHWkF2Q3M4MDVMZk4v?=
 =?utf-8?B?c3F3RFZrVDRNSSthbU9hY0F3RGhQTmhBeXZhcWdEMkxSSU5xVHV4andMaGd5?=
 =?utf-8?B?bmV0bGI4RVk4Q2xiOVdQNG1xbHNxWXN5WGFoRkpqUGtsbkhiWTN3bld3MlM2?=
 =?utf-8?B?M0RiY1IzMzR5aHBNMVRaMDd4OGpWc2ljY0psL3JvZWs1NENnTEtkYjBVNHZi?=
 =?utf-8?B?YzdmR0pKQ1lLODA4L2dpeW1DaTk0VTE5OVVrWEo3Y2JIbWRJaTcwOFpzU0li?=
 =?utf-8?B?aXVyRzZ1K2FOZEl3YWd6a3Uxa1BBOFlDL1l5RHc2WU8rNGFCQVg2czlwekVM?=
 =?utf-8?B?T3JheDRjNnVwUWRzOXBubUU1cnM2V1ROM2M4T296VytrTHNBUnpURkVGZlpZ?=
 =?utf-8?B?eURlRGJqYXIvL0k3TVVjelVja0Vxd09PRjY2UnZlbm5VWExRSDc3RjQ5aUJi?=
 =?utf-8?B?Uk9RcnRBbUM5TXE4bjl1VXE2YW45N2N4L3VRSjZsbEs1a3N1L2IyYzRjLysx?=
 =?utf-8?B?T1JmVnR4UE5veW5oWWp3TGoxRjhpZ3RqS0dCa1VNbW1sQms3NWpmM0VpTGZ1?=
 =?utf-8?B?WktUVlRCWGRUZHBXb0FRc3hRSWViN3JZNXNEMW9DZ05ZZXdueDRac2kyK1pD?=
 =?utf-8?B?bXNCTkhMNmVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0g4NzdXRU9MWmI3UER3SUtMbkZ3VDNKQld0MSs1N3RlRU9ZaFlrVjBLYmIv?=
 =?utf-8?B?RllHYlJqbW1qcEdtM2IxWEtmd09JOVJCNlpxcERMemI1SThpRC9lVlZUR2dU?=
 =?utf-8?B?YUxRWVgraFQrTjErd2lvdTAvWmY5VVYwaHZxRG1RdndmK1NWWGVva3lFc1k0?=
 =?utf-8?B?TkJHTTRsV1NKVVFwZms2ZTQ0ZCtiTk5OR2ZOUFhlRFhIVjhxUXNGYkRiYVAv?=
 =?utf-8?B?cHB4TzB5SjZ1Y3dWclh1SnlvcFd1b21GeER2clJRN3RWdHRMUjl4N3F3Mjk2?=
 =?utf-8?B?dEJkL2p5K1VCS1pka3hPU1ZBeVNQNHRCazdobmQ5REFiRnpiVTA2MWcwWDlD?=
 =?utf-8?B?U1ArN3VlN2dZRUdsNlRZSktXVGxYazNzNmVTUmpLcjNEbGQzbXhFcmlXYlll?=
 =?utf-8?B?MVd4MlhMaHo1d1N0MlprSTY4VHNHQTlXQzZPRFFyS2QxQXR6YWU2SSt2cHZ3?=
 =?utf-8?B?cFBGR09rcTV1cUlRRUs4cTZ4N2M1cG12WlEzUzFJNHhpMEp0c0QwcURUcDRI?=
 =?utf-8?B?L0N0dnlaZnd0WUE4Sm5NNG1waFZ6N0ZqdjNIS0xUSTdqbXZTN2wyTER6V21E?=
 =?utf-8?B?WTZZWDJnMlMvYllldkRkNElKZmZ2aThrRHVQQjQxRDVSZFZKRklOMnJYeGI2?=
 =?utf-8?B?cGRGUm5Ea2s1NXQ0UEJXYlg2Rjl2QWdnbmVWK1VPYit6c0VkTVJJVWlZQkdw?=
 =?utf-8?B?Qmd5akZqQURjbnd0MmhFakY4a1RpU2lRR3h3bktxa2tKSmNrZVpsbGVENWFT?=
 =?utf-8?B?cGUzSFFTQXhHQmJKeEY1ZVpvRWUxVWJhZEZ4dzdQRU1MQWFROTJOMUpRNHFh?=
 =?utf-8?B?NnVVTG9adTVjRUNqb3NsaDVuc0dKUVhKb3pyT1ducHdYNXM5MFQxWnI1RWlC?=
 =?utf-8?B?b2FHWUwyN0I2dXV1M1FHbCtXNVRnQ3ZtVnNHRVFLeFJDS2pyaXR2bnZWWFpN?=
 =?utf-8?B?S1BVbHQwTlBsaFFneEJkZHF5T25sbjdnS2VQTnkxd3VzTHlGbHBlSWpCZmFz?=
 =?utf-8?B?WUYxN0JSME9MVk1oblFiMHN4NkZmVnc5akExclJoTGc2UnFMNlBkdXFMcitB?=
 =?utf-8?B?MUwwcEJBOTJaWlJ3RkVzN2JUc245US93cTRQSWhnR2h0b2FCZXFuNGo0cUdu?=
 =?utf-8?B?c2JUVnhvcUtEVlY1YVpyVnVKeUY4UjZNRTZKb0k3SnNUUXpzTGdMUnlGMHQy?=
 =?utf-8?B?TDE0enVncm5zUmFXRzRHUFBLYmlKRk5FeUlhc1A3TTJ0dmg1L3RxR3RBc1hu?=
 =?utf-8?B?bGxBMVBmai9tTHFWQlJXNjhTbVBGUmJTVyttRTJpVXJMQ0VaSXFiWFB0VENK?=
 =?utf-8?B?eUx4NXRtY0oyMmJSdUFqMjZIazFLSDM5NEd6aVJ0emNldDZ1UkZ3cmFxYjg2?=
 =?utf-8?B?blM2SXBWMy91V00wM0dHQlFTaTdZdDNTSWpHVEdTSElIUXhNWVlNRWY2T0Yv?=
 =?utf-8?B?NmdBWFI2MUltU0hpankvV1lUYVBmOWNycWxTdHhpYjFlVjFLQnJUdXE1cjg1?=
 =?utf-8?B?WnZ6SXZub2Z6MEJYUm0xcFZ0ejdVa0IwNUFXRVBkNXJIWkZHY2lYR1dLSUcy?=
 =?utf-8?B?SWYwZzU4VzVGQW5GK3Y0Q3JEUS8wdEhPQ0hUOXFsc1JaZko0cUp6dm5GQ3Iv?=
 =?utf-8?B?bWh6S2YzTnhQS2FzcXBmdG00RHUwZkhuaGhTOW9wZXVKMVRMTE9HTnRUQVYr?=
 =?utf-8?B?WUtuaWtUYzQvRG84RklqL0RQenVScEYvYk5LZnBVSFIxMlFRRmo1K2tQd21Q?=
 =?utf-8?B?a0lQMGxaRU5PUWd3czlnSm1QMG1NT2lZcVU0ellPVW00V3ZDWWthdzVhc05K?=
 =?utf-8?B?ejNBRllqMGNUR09aVXplWVRXZDlOZ3J6c0NSWUZsRS8weGtJRTFta3gwUmNQ?=
 =?utf-8?B?UmF1aStjN2RHWWpGWnVkY29nNStoOWpyRm1SMUN1czVIdmFTYUVjbFczL3F6?=
 =?utf-8?B?bndGRXl3OE0xY2dQcW12QUIvQVBUaVlSUE1wM0V3UkZmY00vYm9lVnFEcFBG?=
 =?utf-8?B?emRDNU85Rmo2Vm1HY3A4dHZ0cVdaRUsrTi9hak0wV2dQNndubVJwWVpUem9Q?=
 =?utf-8?B?L2phQndweklBTURYUEJrakFmSHBxYkdkdG8zR1IxajMyWTh6VmZFVmdleVdz?=
 =?utf-8?Q?dgVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D281597A54E9B44489D45C3559323E2B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd7e11-492a-4ae9-6fad-08ddaa6c4cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 11:20:27.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JM6WByc0XXLQqX7d2CjkjLZkKvGik1msdjK+N/aNH8S4BbLWtDDuOQZcSZRM/mG+REw4xLudUz7CvdaCHYB2Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P195MB2582
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

QW0gRnJlaXRhZywgZGVtIDMwLjA1LjIwMjUgdW0gMTI6MTggKzAxMDAgc2NocmllYiBTaW1vbiBH
bGFzczoKPiBIaSBZYW5uaWMsCj4gCj4gT24gVHVlLCAyNyBNYXkgMjAyNSBhdCAxNDoyNCwgWWFu
bmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOgo+ID4gCj4gPiBCeSBkZWZhdWx0LCBl
eHRlcm5hbCBibG9icyBhcmUgZmFrZWQuIFNvbWUgdGVzdHMgY2FyZSBvbmx5IGFib3V0IG1vcmUK
PiA+IGJhc2ljIGZ1bmN0aW9uYWxpdHkuIEluIHRob3NlIGNhc2VzIG5vIGV4dGVybmFsIGJsb2Jz
IHNob3VsZCBiZSBmYWtlZC4KPiA+IFRoYXQgd291bGQgdHJpZ2dlciBhIGRpZmZlcmVudCAoYmlu
bWFuKSBjYXNlIHdoaWNoIGlzIG5vdCBpbiBzY29wZSBmb3IKPiA+IHRob3NlIHBhcnRpY3VsYXIg
dGVzdHMuCj4gPiBUaHVzLCBkaXNhYmxlIGZha2VkIGJsb2JzIGZvciB0aG9zZSB0ZXN0IGNhc2Vz
Lgo+IAo+IEkgc3RpbGwgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgd2h5IHRoZSBkZWZhdWx0IGZv
ciB0ZXN0cyBuZWVkcyB0byBiZQo+IHRvIGZha2UgdGhlIGJsb2JzLCBpLmUuIHRoZSBkZWZhdWx0
IGZvciBhbGxvd19mYWtlX2Jsb2JzIGJlY29tZXMgVHJ1ZQo+IGluc3RlYWQgb2YgRmFsc2UgaW4g
dGVzdHMuIEZvciBtb3N0IHRlc3RzLCB0aGVyZSBpcyBubyBleHRlcm5hbCBibG9iCj4gYW55d2F5
LAo+IAo+IEJ1dCBsZXQncyB0cnkgaXQgZm9yIG5vdy4KPiAKPiBDYW4geW91IHB1c2ggdGhlc2Ug
Y2hhbmdlcyBpbnRvIHRoZSBvdGhlciBjb21taXRzIHNvIHRoYXQgdGhlIHNlcmllcwo+IGlzIGJp
c2VjdGFibGUgd2l0aCAnYmlubWFuIHRlc3QnID8KCkFsdGhvdWdoIEkgdGhpbmsgdGhpcyBjb21w
bGljYXRlcyByZXZpZXdpbmcsIEknbGwgZ2l2ZSBpdCBhIHNob3QuIENvbW1pdApkZXNjcmlwdGlv
biB3aWxsIGJlIGxlbmd0aHksIHRoZW4uCgpZYW5uaWMKCj4gCj4gPiAKPiA+IFNpZ25lZC1vZmYt
Ynk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgo+ID4gLS0tCj4gPiDCoHRvb2xzL2Jp
bm1hbi9mdGVzdC5weSB8IDE4ICsrKysrKysrKysrLS0tLS0tLQo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiA+IAo+IAo+IFJlZ2FyZHMsCj4g
U2ltb24K
