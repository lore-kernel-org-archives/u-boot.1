Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1CFD376A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5396D840CC;
	Wed, 25 Feb 2026 17:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="TeuGB7ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F578407E; Wed, 25 Feb 2026 16:14:06 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C188406D
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY4gg5yrreHUWr9BkE1HEKdkpNBOLOSmyQdUxzgYf0KGzFdI6rB1WX9GEL8Azvu1Oc2dktAuJZAsBJKaTeHI+pO2rZc2zlTIxQEyHJ8pmGCtXyOAfCK0Zg4a15ca9z9lDTIfA7Aas2CEL86O55R1BsxrTghle5+vUWtaDeXPrQ+/wMVlK+q9fAnQadiRxk+rOJ2vM0HzuMhVBlHbuWw5I0QnEHZeXFT0b7DQ6JXOC4lenxrvnaPu8p8DeTzVjjhjeNLnAjKl9c636qt7z+qxs3GrM3qKRj7t4HypY/CBCCk8fgnwfpf+nyklfwXDmLxGrYMfgXlr6ajw2TGENB3X9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfJN3bNtIG53V/TG2xC78/Gik6O0SmSDjpU8+MsmJBY=;
 b=nlNgTSiY8QBGPShmuWe+JQFvusgP9MmCSgoViS6VdkoxVc/jQMJ5Yxmfr9gAd2Ouoq27HsZ8w6JzEE+8ocGmzP+VdXhU/3GTmw2s68zjBFKeQOkzvS4qTqeVwUhEPHCk4shf7QHSaM62O0tZUJpnEst6d04vbBqhcGvateXXu4HpZQjhndcIQq0WZtyFCBWwTu22l7jL4lKN1VJzln/N7SdusIe1bgFfzt16JMiol7JUF7xGSgF0I1fzH4RSZWAiKCl3M8N4OjPy+c0hc78EUzuhVd38VWlZoe55w/6XO04IzRIXXnir3B4wl3eS2hhgXQq/DTtZQhzqsjhBcVTZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfJN3bNtIG53V/TG2xC78/Gik6O0SmSDjpU8+MsmJBY=;
 b=TeuGB7exVSdtLJi64AoIFMHjCuj7RSX2BmulWTyeyKf6BvefG63Sx9AmkYN9RVud+hrxQzIhPQHhsZDJNRP6NjT1ocPQ2ByCF+C4HJGw/VsTP7ri5t86YFYhl/g1uCAKHXPzOESSA77wxtBruF3qlgv/GvWrr8uLpD1hcwQEqyZKgXjofH3+TAt4deosJnvrp0/bLyq2RkvRyzGrQMEzIk3PZmU47JZ27pArBlWc0vnxxF0RfvHP8rJakuPB78BK1KwwOHsPNOm9cACJoXzCzq6NKpoR65gekGqMZDJMjgv2AH+q5JA+bHocxJVQWhehXzS1nftvVMZGMQMkIXecCg==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AM7PR09MB3784.eurprd09.prod.outlook.com (2603:10a6:20b:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 15:13:14 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 15:13:13 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "ycliang@andestech.com" <ycliang@andestech.com>, "rick@andestech.com"
 <rick@andestech.com>
Subject: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v5 00/08] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcpmlCiAymLWRmJEemi0BqvIAyyA==
Date: Wed, 25 Feb 2026 15:13:13 +0000
Message-ID: <073d22d7-86c1-462e-8bda-c3e14c209376@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AM7PR09MB3784:EE_
x-ms-office365-filtering-correlation-id: 96d1d806-3c47-490a-eb96-08de7480654f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: HyuUu6VeYjkq2+KOm5jdKIeYcGQsH8XrakbZ9yUHZjpuF3zvTghQf40EeqhCfUP2agFo+K+uKowf/KBASRcasw3EWfkQVMWhnSJbtw4ZXLIia/eklxMi/WQDsDQ4N9zQnTwFCU8KnyABsVbHvCSe53yYSpJRDi7UudWU13h3w5RTmWjbXjqKHJpsAe6gk/EyK/uSMW/OPH37j9sRYx6xtE/bLX5knHPlXHlP4zGo4Yq+05r5wvWp/uo9sWQgROX6aWh5J6VRNmK3dMmA0zAMLjMSdNavp9mWLli+fdCNIlbGZN8XHKj1fYub6qAxPUUILK2jZ+kzYlxmROTJqFlXw4uv8l+ItfmCvtKSCLzH7Cs/xjcymRbJZcYBaY1PPI598voYaPLfKonmpwQGAFfr0HybDM65WDnQP03OlwQLrEkJA1NbVrOJKxIpvibboGqMGdEt79AqRH22AyuyP0wA7HZG75pcMuxeF25mDY4gylvV/bEZMWzscQ/4eWO+r1omZ57cJDImcwhSTos8iuGlHFQLhtFO5C6bDmhENTm5EGxMCUGbC6VUgtDs58sloYcOTwS7AHFYPUfZanNHG0HnDgmcbp4YEom3F6iuxdn2m8/assLm+0C1J3ufQmFrxuyXJVaQ+xL2LqDfF9Lf/kF7TYK/26cQhH1zPtGCATpfKFdI8HOIdZsXAFg5ao5AScnQloeYDhsc41GEQTIab5BrBmWA7Wut5qrGMPanMh7DQ6pbBiquOFQFptzCx2gYcrPQtudXspB8agmi8MQbkjoyxmXDadRSLXwPr5Qxm4I0iaA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czl3ZHFJUDhCNjY2eW85c0dQL2NLZGVUQ3BvcVhaNWJhQ3ZNZ21IU3lwYmZS?=
 =?utf-8?B?NGpXeXlVcnVhUitlWUFWbXdnYWVpbi9CdUZGWU9iSWE0OWtsUE9wTHFaVUxC?=
 =?utf-8?B?UnJPaldSZkhoZzJ4c3hJQ29vTWFBcXlsSkh0Q3JJaVVJSFg2SzhvY1Jxbkgy?=
 =?utf-8?B?SC9VeDBlQ0ZSanpiRllBbWJaSHIvNzlNNm5Wd0tETmZQTDlLQ1JQVE1uRVdW?=
 =?utf-8?B?dkJ6enl4RVFFTXFXMkRXb0RVZG8yNm5UK1ZJNmtPMVpIeFNqSy9DeUFlaFZj?=
 =?utf-8?B?UlVWK2RzeUw2ZW54OXhSZ3djenh1SDhJT29ZTkZpblRwRmJwY1VFdVd3dnBm?=
 =?utf-8?B?RHdEQlM2NHVSWUNWZHJzUVVpcm5hVThRSGpma1FHL3k2MHJCdi9rN0Vmd2R5?=
 =?utf-8?B?b2YwTU9mcW5Zd0V4UjNsM1BxVHR1Y0o2ZGpjUExnNEFweExob0lRNGFzWkd6?=
 =?utf-8?B?dDZZTWlhR2NOaFRMK2hjVzFtTmlIVzVvUFc0OEJEZkNxNzcrSGRESUxoQ3Fq?=
 =?utf-8?B?WTlWMFpuMUxsNVMrWTR5RFJRa1dieFdnU01NV3JHU0t0UHJBclI3ejgwa2Np?=
 =?utf-8?B?NUhLVXIvVmsvQzNrbC9HMnVGNU5ISVpqWjN2RjEwWnhvN2FrL3ZCQ1hJaHQ2?=
 =?utf-8?B?VHJyZ29JRGx6ajEwa3cyQWhZeW9vU3hJOHpBdHdYazV0YS95cWUyNDgrSFJJ?=
 =?utf-8?B?MnBjRTdBZkxFd09KRkRZR3VDbHdGVTBoUDVSd2YxcUhKc1JoeTNDaVZYL1BX?=
 =?utf-8?B?QUY5a1p0aTdEeU9CSXM2eXJ6N3l3WSt4ZGhQNjJFenZZSjd6ek0wTklOZkNR?=
 =?utf-8?B?cWlwSDNhRDg3bkFodjE1Z1VMWWpRSjYzU0cvRHNzelM3ZEdPNXVOZC9tSFdR?=
 =?utf-8?B?SXBrSUdSVVV5RmRYRElUOTN5MDZ1Ymw5b2N1NC9yNzlZUE4yblg3ZndOaUlX?=
 =?utf-8?B?bWNkWW1yaXB2azA5bk5Rd29sbU1uR3JmOWMxMnpJMjZKRzR1dzNhTE1LMEZa?=
 =?utf-8?B?QldDSmtsd2xvRkI2QitlcjQ3dCtLWXE3VTQ5N2pTcUNrelJYMXlDdXlRZTlN?=
 =?utf-8?B?c2FlSy9JdUpHbkloU0tpL0dlRnFPU2tHNUprVWt5OVJZTlVDWDVlcUpyNGRW?=
 =?utf-8?B?MkVyRDdXbkd0ZG5BRDY3aUp1NXZ1bm5USjlWazU1TkdRSEZ4N0xxMy9uVElD?=
 =?utf-8?B?cGRhMWhJbUZKenlqRDU1QWVHR1p6bmc4VkhoaWhCTWd2VnphT1RGbjRzczBT?=
 =?utf-8?B?UU5RbEtuazc5WEFnRE1tQlJyQks4V0w5Q3ZacS9ZdEtyMWRFL1RWZHkvbkto?=
 =?utf-8?B?T0IvckJFZUN5NFNybGxZbWhNNlB4VGdndnNIdXFicUw1Rmx3Q1NoL1VENUhJ?=
 =?utf-8?B?a2dxQ0Exa01iLy95U1ZCSUVTWmg4RXhpS051TEZqK00rcHdnZHdCbVE1eDRp?=
 =?utf-8?B?YTA1UnZxUnltYTlJVm1Ebm1RQ0xVbE9oc3BBWGZlUkIzUTErblRHVlhkd00z?=
 =?utf-8?B?MXlyRVZuODRwZWozcXFTbURlc2x3MXdBWnIrMlVjSGkrNkk3ZEEvZzlkcGJO?=
 =?utf-8?B?WW9aNWxIMVpxUUMyMFdTTUNqZUwrYUQxNUsrczJXVzA3Vzg5Z01wVlFyTkFE?=
 =?utf-8?B?U3RqZWdiei9TQ1d5Nlc5eWN3cE44dGpIYlplbXQ0eHVHZjJwcDJ4MmVwTlFk?=
 =?utf-8?B?WitVd2ZBQm9zeXR3aEw5WlVLWEJjNjZLekFqKzBEMFJpRUNQVHJ1ZjB6VlN0?=
 =?utf-8?B?bXJ2RW11SjIvWEVTL002ekxMUEZ0YjJVWDdsbjdNZFE4bGpuN0Y5M0JwYTRw?=
 =?utf-8?B?UU9pVlpwQWdqU2hpeFJEY2JnbWxveTk3MDM3UnFySk8yczl4cXMxeEVTaXFh?=
 =?utf-8?B?TVVCNHloNk9TL1BNcEpWMCtYcnFOQzBFUUpIa1RtTkhqVmJ4WGFwdkVJTk9E?=
 =?utf-8?B?bWU2bUJ1SDhTSit0djZ5bGdzczZnMDB6b3hZOGRLems5MXAzakxJdFJHOGxr?=
 =?utf-8?B?NVc3dG1JTXBDMlJkMGY3dlE1T0Z4dkxCZFZ5ZUd5Q010cFFXNkhvTUo5ZWdR?=
 =?utf-8?B?ZXNhSGg4b2x2WXdjM05WODd6b3dJYXg2U0Vvb2RoQ2h1VDFrRmcvNHMydjhj?=
 =?utf-8?B?dHFOU2NzeWxLclB1N0dPQmkyd1hJMTVUUTNIUjhkais3SVB1a0ZKRTNiMENP?=
 =?utf-8?B?RmRPVXBONDJlc2hkaldsSStDcG9paGc3LzZjWHJlb1R3djJDVTViOVhFSC94?=
 =?utf-8?B?RmQ0bEJHS3hLU0VsMDl6ZWpickRBaitQYUJBY2lpUUtsZVo5amNaYmlOQklu?=
 =?utf-8?B?bEpiV2ZSbFU3NlRyR1hRaFVwMk12TE5rNjZ1SnFOKzZnRlRXVWZCZGdaT3hC?=
 =?utf-8?Q?ph7CJG+qzRyW6bS4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D16F4C0420382E4787DC4EB2FFA9C733@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d1d806-3c47-490a-eb96-08de7480654f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 15:13:13.7395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i28BhX5bwkYwJoSOlI4AXZrHHFa0GEqhmMe1b3/D4NeN4xNPDakU980oxoAIb1CCmEHB64+JGPOdlV/SQsfiQpQpm4sWfkcQgINmcqrFzSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3784
X-Mailman-Approved-At: Wed, 25 Feb 2026 17:11:33 +0100
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

SGVsbG8sDQoNCkkgd2FudGVkIHRvIGZvbGxvdyB1cCBvbiB0aGUgcGF0Y2ggc2VyaWVzIGxpbmtl
ZCBiZWxvdyBhbmQgY2hlY2sNCndoZXRoZXIgdGhlcmUgaXMgYW55IGZlZWRiYWNrIGZvciB0aGUg
cmVtYWluaW5nIHBhdGNoZXMuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVj
dC91Ym9vdC9saXN0Lz9zZXJpZXM9NDg2NDE4DQoNClRoYW5rcyBpbiBhZHZhbmNlIGZvciB5b3Vy
IHRpbWUhDQoNCkJlc3QgcmVnYXJkcywNClVyb3M=
