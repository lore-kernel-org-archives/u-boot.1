Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94DC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED59E810F9;
	Thu, 27 Feb 2025 10:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="MVo870wI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D32D381101; Thu, 27 Feb 2025 10:43:20 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C2D807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOjDmhOIkkEsVYIGvp5FP1TQCDd1zETfnmJzl8G5qhf3bP/otR8y4Xgc339D2bieYEtU5sWBoeXcs+y36GNHhxPnK1RmzpvFYLnoTYpg0rPmdbDcTH+21QRIi6z4rBWYu2zzatiqRxPgLYc84d8ijh43uVwhhRwMPvr3O6AHnoMakrC3Vv0W0M3RjmAlI3oSGy5+k9xQTObXnbCuk69u47+PyCQjVIkgghOlS2eXdufxfWVyVClksOGtm8ZF5PlcSwtKxVSU4XwyWklSPEeACMVybzYFl9ZbasU3Sr44GAZ4+TSzH6PlHoJZi17nrjfN/ibuINry7p8+ptgZ6HSb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL+MVquTyRQ9Iyil7RRhqIBe70FzUaKs58I9tWq7w/s=;
 b=YWmxKgbj4vQMoMRdlwBUH8d12i0H1+bPa98xtRMSiu3VrSO8je9IHvavyhSwu5J4kza/Evc/RBLddK77ii7SFtVn3VLdoRXk9KI6rKNpMcu4u7VTJo9G/zPGjiSnuBiDRhpyEdAQoAaQfNN9KmmWE0/erjfCWHbChjAXCoirpi1n/YXQpI+njNimSx40S2Q40kSLVmb3EH8a270NA3PzsJmCArlppd8BNVN1fsdepNhw9dC8e2ygnv7T91gvPWZmW/RWvl38ku5hmHMV9dK3ru81RnKPjUR8wAd0ekHTbB5X2iBpaS9fN5JWVRbL+CijrzEB9aJbeI5rn1/wfSHrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL+MVquTyRQ9Iyil7RRhqIBe70FzUaKs58I9tWq7w/s=;
 b=MVo870wIwwvXRITtPN/UPpq0CLEwifAud7XuJe4H2aYGdG3fbd2xhETz67M4oDo91LRZ5leFBfw2rrPNX/ymno32+HIKCibLdbcZ1oCUo6VqxMGYWIOy9fPP6STLN+9QTNpjFWC2vovjHOTCBS2Qjhr0E2Dc3TVdWhfHlhAE2dk=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS4PR04MB9549.eurprd04.prod.outlook.com (2603:10a6:20b:4f8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 09:43:16 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 09:43:16 +0000
From: Josua Mayer <josua@solid-run.com>
To: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>, Dennis Gilmore
 <dgilmore@redhat.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] configs: clearfog,helios4: disable sdhci sdma
Thread-Topic: [PATCH v2] configs: clearfog,helios4: disable sdhci sdma
Thread-Index: AQHbeiQtbB6IyFNmuUKcSBhy0hVSdbNa/7UAgAAEDoA=
Date: Thu, 27 Feb 2025 09:43:16 +0000
Message-ID: <e8bbf95a-f5e8-4b90-b092-8574478c8e9a@solid-run.com>
References: <20250208-a388-kerneladdr-v2-1-17c01313eba2@solid-run.com>
 <51dacd62-bb7c-47cf-83ea-cd3b928b968b@denx.de>
In-Reply-To: <51dacd62-bb7c-47cf-83ea-cd3b928b968b@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS4PR04MB9549:EE_
x-ms-office365-filtering-correlation-id: 73676fde-88d6-4b50-d2ef-08dd57132912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TDlRRXJIdnJlMHJMbjZmbngvbUplZ1BrZGZRTllsRUJGK3d3RlpPdWM1cTlU?=
 =?utf-8?B?NFM1Zi9GRjR3T25hUCtaQkVxRTF0dXROcTQzL3dyWUZJZmdxZTc0N3pPZGc3?=
 =?utf-8?B?TVpOMk0rcVdOOEk5RmJ5Y3dNc09RMUZWWTVpbkluU21vejJtR1k4NzFuamVm?=
 =?utf-8?B?aWY0Qmlpc0FqaEowNm40NU8wRWlYMHYxU3A2Wms4SklER2FpQnhHR0dBQ3NV?=
 =?utf-8?B?WWs3YzcxSi82VzhWWVFvclF1VmdraVIrV0VSR3gwQWR1czZZdkJyL0VnOFJO?=
 =?utf-8?B?dWtod3dZbmozWlcvbFYwOXA1aWpIWmNCS0lRT0RWL3owQTF2Y2xVV0x1VXpR?=
 =?utf-8?B?VkhkMTFMVENFZFhUQ2xZZWozbVR6a3hxeFAvU1VZQU1XY082MGZnazRRU1lI?=
 =?utf-8?B?TmRZTWVBU09wQWJ1N2JJRWdPSFNJeklYeGVZbWhySDdRVGUxakRuOC9YVEhm?=
 =?utf-8?B?TjMrR1BuV3ZaZ3J2TjVKdU9XL0RBeFgxa2xhOCtSRXFrcmRnblFiRmMrUFNQ?=
 =?utf-8?B?Z1pXUWZKN0pLZXM3MG1wYU13M0dRQ1pqaEVnTDEyNXVrVm4rUXM2UkJER01M?=
 =?utf-8?B?SkFoUU41VmU3U2tjZlNBWklHUUp0MnEvbUJUU0NHVDRTRC9wSkhiNHZkb2dX?=
 =?utf-8?B?SjdwM3AwZytUMG8zbjNMUlhqK2d1WU9QVjJWMXB2ODg1bTBLVU9TbnZhV25t?=
 =?utf-8?B?a0NlTzJ5bUR5dE5WVTBzZmpOVXFXb2RtanVFanFsSllhUVNTc2hYRFdzZDc0?=
 =?utf-8?B?bDhVem5vK0hXbGNQNFMyK3gzT0ZEaTlMaHZnYUtFVUV1Um1zdmh5cUZnQmpm?=
 =?utf-8?B?cnN0RE1KOVNBLzdka0drcE5qeW9EcUdhQWxTaUlFUGdBNzRiZkpGSnhETjBz?=
 =?utf-8?B?dUJQM3F6NGVFeEdHaWF6T0NPejNLTE93WEliaHVST3NJbWpyaXhENnFCeGZp?=
 =?utf-8?B?ZlVobkpmT0dqa3puZ0VUV09zTUhKa2trTWc2RkxSRDZ6VjhSakVPMXlScTBY?=
 =?utf-8?B?Q0w5VDE0V1ZHeUYzTHlZY2ZVWG9URVBUeFNyKzQrT1IwTUsxTDFYWEx0VXdZ?=
 =?utf-8?B?TVRPd2l2UjIzcjZyLytoUkwrNVNPSEdyeFhnSHhkbHQ2TlRxUHIzSHBydnhZ?=
 =?utf-8?B?Y2pUMDl3bGN1UmJGSEJENUViM1I5VmVxRmx2OXRYTHllamhmYTVoMlN6UXFw?=
 =?utf-8?B?UG8vT0FTRmx3dkdWdWoyemFBcHNSRTlNOGwzTGNwaHpPQy8wOWFQdVpzc0kx?=
 =?utf-8?B?WHhYdk4xSG9yRExUMytsUDN4eDA5bzNIRzVmU25jTG9IM2hXZ3I1QzBSb250?=
 =?utf-8?B?dmwxei95TGRMd2hjU3Jwa3FDa2ZBYlVRRVRtc3hiOEpxZUtUR29WRW1iSXdM?=
 =?utf-8?B?M3hVY1Z4TDEvSjB1VDhWRWk5TDJ0S1poOTFzbUVHWUtuYkJNOVloYzlaZWpZ?=
 =?utf-8?B?QlNEQjE2VU94Wis5VEtHeUIyR2tSTUZ0VUNEK01sVVhYVHA0OFcwRlVjdE9U?=
 =?utf-8?B?bjhmNjVYUUZZVlF5ci9NY094VVlDMHNwM0hDb1hVT3BJcXQ4djA4SklkTytp?=
 =?utf-8?B?LzZOaTUvQTZvd2JsSkxuSGxIb3BLSUx4TUFOZFcvZFZkaG1zb0VkWjlhSFI4?=
 =?utf-8?B?ZHQxK0R0WDRqVGl4Wkx0NjVvT091UnNYYUtaNjh0L0xsL09aZ2NqV2QwMHpX?=
 =?utf-8?B?UjEreFVkSXowbUp2U2FjWkl5SzI0Rjh4U2tOQ0kvSWdMNVBxZ2c1QUZiMGtG?=
 =?utf-8?B?MTdnUkdjNTJYZHNNcGFpUlJmRG1wODNsQ2JsMVgyaGM2Mng5M2E1TEV0eHA2?=
 =?utf-8?B?RjhyaTI4K1F2Z1ZUSWd0SnlpeGdxN1lBUVl2TU5aQkJyaENwYVJndGk2L2t6?=
 =?utf-8?B?dm9CZW1rOTVPYzZkRit5ZXhkK3F5Q0dlSDNnMElqUzBHbzB2L0htMENVOVhZ?=
 =?utf-8?Q?5K+pySpCGJoZGA8YmXmm2pHHekG8XW/e?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXRiTWQweXRhRHBNUmNzWmppUlhxQVpRYU1ocXM0cnZXN3FuVFdJK1lkSUk1?=
 =?utf-8?B?STV1UFppWHhUbHlxWUFITmNoTVB6dGJqMWExNm9XTHlFdjFvKzNxVmxjVlZl?=
 =?utf-8?B?dWsxdGwrbHNyclkwK240cWdaTXhtbDRrTHVtLzhhMGVkUFdrQjRmcmkzZmdu?=
 =?utf-8?B?Yi8xZ0YvVkhjZXg5TVU1OWhYcnZRU1JqL3U5Um44ZnMzS21jVUt6cDd2MXBZ?=
 =?utf-8?B?SzdxaWlDakgwSFBlVTBBOTh3VkRaSElkYjF4ckppZjBTVmZrZE9UTTAxQndZ?=
 =?utf-8?B?R3Zib3FhL0ovbU1STUVjYVRpRVJFSnNqR3pPMkpnaDhlZ0dFS05weGFMUmNi?=
 =?utf-8?B?eDRoQWJDUnZNQzk3YTNIUTh2T0hqNVBLZnBuZ3kzcEZuUXRqQXk5WFpSanBH?=
 =?utf-8?B?c0xxWTZOWE9hTWFtb1ZOaFVPTWkyMFJUU290b1FkTGczczhZVUdvOXJiUFVV?=
 =?utf-8?B?Q0Z6eGliVUtlQmtibkMyanNwU29HYk1VaTA0Q3FNRktqQkxzME1IdUo2RHBh?=
 =?utf-8?B?RVdZcE5UQWdZOStlamVqM0EyVVZzb0JqQzg5VzdPbG1wcW5CSnRlRjlsTWZB?=
 =?utf-8?B?eC9wQ1NnenR2YU5BWnU1dG5ibU5Db1ZBdmZ1Qmg1S0JqLzFsWUJnSFM5QjQw?=
 =?utf-8?B?YnhJU2lKTXArVHdJZUV3NVRXSy9QbEVmS2pWaHdYelVQZUpHbjMvMGZVblBm?=
 =?utf-8?B?dHJuN1A0eHFIU2FGdzFGL0JkRjFWT3pyUGNYSkZ6aFJHQlZKQ1ZKbER5OXhY?=
 =?utf-8?B?L3RTc1RmZmZldEw3RG9ZQ3JiZmpkUFZYUWNUcWNDUjVZVmJ5T01TL0dxSzJl?=
 =?utf-8?B?VVIzRnVTWjJSblVMN3VFODdFUTNCa2FpdWQzcGR2eG9VVG0yeTJpQ3N4aWZi?=
 =?utf-8?B?UTZEMUhwNFlRWjhOUEhEMG5EZkE2OXArcm9iQWJ3ZzJLbGRJdVlCQ05SbURk?=
 =?utf-8?B?V0ZYVnp1NkFLZGRXeCtJR2lSeDRSZmcyZ2FKZDQwbHo5cm11VHgvbWFpSm9s?=
 =?utf-8?B?Z2RiR29jbVFNYXQybGRmQlhpZTNCUnR4aEUrZFlKRU1OV3hYdHdWclFVZUFS?=
 =?utf-8?B?QlFYek52TTVsZkNFOTJTNUJmaVlEYytuVVFPd2xpTGV1ZG1Lc2NYNWUyZGlV?=
 =?utf-8?B?T2RYZEhmUVQ3QmZuNnQzREVTc1NmU3BOUUtRWHhiT285KzQydm9GRkt1UGE4?=
 =?utf-8?B?SU9VaVVvQTlyYXVUSFdHandsQ2ZqVGU4UFFCQWk0SU5DejZadkZmNjFTdFNx?=
 =?utf-8?B?MUpSTFByaWp3cE9QNmt0KzZUdFpuMVBYK1Z0eGpiRjlpVWpzSW4vSnUydHc4?=
 =?utf-8?B?aDNoVG10RWYvb01OVGsxMU45RXNJaXZwTnhFa3M0M2FDN0RBS2IrZ1ZVZ0NK?=
 =?utf-8?B?VlNTcm0reDdLZ3h0SFRuNko2K3ptUWg2YnBxL2tjRXJ5RGphK2VGVk9QNXZZ?=
 =?utf-8?B?SHZWOWduUXdGU1FZWkxZR2xieXZuT1lGeFpDMHNialAyS0VOVVZFalZ2UlRH?=
 =?utf-8?B?WUZqQ1VOR3o3dCtIZ3AxTFFDSXZVQ05VZjRCUDBLRVI1VmZDeSs4WG5BaUlE?=
 =?utf-8?B?dXlpNFptd0FrQkYxeEdjQjIrY0JLcms4L1FkVUlnQnB3UnI1V1hOYSs0OGhU?=
 =?utf-8?B?SWhPMituU0ovOXNRdWdlQTdIZ1NuU0VrSGVtemoxTGtnSmJUTGJ0Ly9QbDhO?=
 =?utf-8?B?cjJycVpXczEvUnVEY3NGZXFtdUtOTUtpNjNBQ1dFQnNTMW0zYk5KTkRsRW84?=
 =?utf-8?B?MEVOZnhzb0dHanpJZDNWRlBYQWphcEhTMi9lMWhURmxubFNWQ1VGWEswaHVa?=
 =?utf-8?B?a1lMV2Ixclp0MG9uekZuRXhpbzFYTisrck5VakYwYUYwaFpac2ZPZjhNREEx?=
 =?utf-8?B?UGNaeUdjdzU3elJKaUpuMzFBZEVCOElDMXRha0ZsRTY0ZUpXOVJsSjVwQWtR?=
 =?utf-8?B?TlVJTmY0bVMweGZaNVFnejJGeVRKSUUvNXNHdWdxcWVVNFUvZEtDcmtMUHBU?=
 =?utf-8?B?Q1REbnl4a09hdml2Um1tbDdYZ2dWOVhjeFVoWWNkaEhZVHBpQ1NaYWZVSXl1?=
 =?utf-8?B?UGRLTW5GbnBWakZlSE9wZ2xqKzFRTENscys5Z0pyamltQ3NYYUZZMHRheE56?=
 =?utf-8?Q?ZHvnEX++KWxT7cFBiqK/EwVgv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CCE62C0BC86824DB94D278BF459A0DD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73676fde-88d6-4b50-d2ef-08dd57132912
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 09:43:16.1031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Jf0tPI6/6X6JZzsfXesKJdK+ugGofCs3sXaWx1/LatvpExhXpFhJobnVceoRZ39DNbeRJ/kxzlk2dAoeaNGLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9549
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

QW0gMjcuMDIuMjUgdW0gMTA6Mjggc2NocmllYiBTdGVmYW4gUm9lc2U6DQo+IE9uIDA4LjAyLjI1
IDEzOjIyLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IFRlc3RpbmcgaGFzIHNob3duIHRoYXQgbG9h
ZGluZyBsYXJnZSBpbml0cmFtZnMgY2F1c2VzIGRhdGEgY29ycnVwdGlvbg0KPj4gd2hlcmUgdGhl
IGtlcm5lbCBpbWFnZSBoYWQgYmVlbiBsb2FkZWQgdG8uDQo+PiBEZWJpYW4gMTIgaW5zdGFsbGF0
aW9uIHVzaW5nIGEgMTdNIGluaXRyYW1mcyBib290cyBmaW5lLCBidXQgdGhlIGZpbmFsDQo+PiBz
eXN0ZW0gd2l0aCBhbiBpbml0cmFtZnMgb2YgMjdNIG9ic2N1cmVseSBmYWlscyB0byBib290IHdp
dGggYm9vdHoNCj4+IHJlcG9ydGluZyAiQmFkIG1hZ2ljISIuDQo+PiBJbnNwZWN0aW5nIGtlcm5l
bF9hZGRyX3IgYWZ0ZXIgdGhpcyBmYWlsZWQgYm9vdCBhdHRlbXB0IGRvZXMgc2hvdw0KPj4gZ2Fy
YmFnZSBpbiBwbGFjZSBvZiB0aGUgZXhwZWN0ZWQgemltYWdlIGhlYWRlci4NCj4+DQo+PiBUaGUg
cHJvYmxlbSBzZWVtcyB0byBvY2N1ciBvbiBhcm1hZGEgMzg4IG9ubHkgd2hlbiBzZGhjaSBzZG1h
IGlzIGVuYWJsZWQNCj4+IGluIGRlZmNvbmZpZy4gT3RoZXIgYXJtYWRhIGJvYXJkcyBzdWNoIGFz
IHR1cnJpcyBvbW5pYSBkaWQgbm90IGVuYWJsZQ0KPj4gdGhlIG9wdGlvbi4NCj4+DQo+PiBSZW1v
dmUgc2RoY2kgc2RtYSBmcm9tIGRlZmNvbmZpZyBmb3Igbm93IGFzIGEgd29ya2Fyb3VuZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+
IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gY2hhbmdlZCAqYWxsKiBhMzg4IGNsZWFyZm9n
XyogZGVmY29uZmlnIGZpbGVzDQo+PiAtIExpbmsgdG8gdjE6IA0KPj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI1MDIwOC1hMzg4LWtlcm5lbGFkZHItdjEtMS0xZWQ5MWY2NDJjMmRAc29s
aWQtcnVuLmNvbQ0KPg0KPiBKb3N1YSwgZG8geW91IHBsYW4gdG8gbG9vayBpbnRvIHRoaXMgaXNz
dWUgdG8gcGVyaGFwcyBmaXggdGhlDQo+IHJvb3QgY2F1c2UgYXQgc29tZSBwb2ludD8NClVuZm9y
dHVuYXRlbHkgSSB3b24ndCBoYXZlIHRpbWUgdG8gZm9jdXMgb24gdGhpcyBwbGF0Zm9ybSBpbiBk
ZXB0aCwNCndpdGggdGhlIEFybWFkYSAzODggc29vbiByZWFjaGluZyBpdHMgZW5kIG9mIGxpZmUg
cGVyIE1hcnZlbGwuDQoNClNhbGVzIGFuZCBtYW5hZ2VtZW50IHdhbnQgdG8gZm9jdXMgb24gbmV3
IG9wcG9ydHVuaXRpZXMuDQoNCk15IG9ubHkgZ3Vlc3Mgc28gZmFyIGlzIHRoZSBvYnNlcnZhdGlv
biB0aGF0IGVudmlyb25tZW50DQoibG9hZGFkZHIiIHdhcyBlcXVhbCB0byB0aGUgbWVtb3J5IGJ1
ZmZlciBhZGRyZXNzIHVzZWQgYnkNCkNPTkZJR19NTUNfU0RIQ0lfU0RNQQ0KDQpDaGFuZ2luZyBp
dCBob3dldmVyIGRpZG4ndCBzZWVtIHRvIHJlc29sdmUgdGhlIGlzc3VlLg0KDQpJIGFtIGFsc28g
d29uZGVyaW5nIGlmIFNQTCBtYXkgaGF2ZSB0aGUgc2FtZSBpc3N1ZSwNCnRob3VnaCBpdCBuZXZl
ciBsb2FkcyBhbnl0aGluZyBhcyBiaWcgYXMga2VybmVsIG9yIHJhbWRpc2suDQoNCkFueW9uZSBp
bnRlcmVzdGVkIGluIHdvcmtpbmcgb24gdGhpcyBieSB0aGVtc2VsdmVzIG1heQ0KcmVhY2ggb3V0
IHRvIG1lIHdpdGggcXVlc3Rpb25zLg0KDQo+DQo+IEZvciBub3c6DQo+DQo+IFJldmlld2VkLWJ5
OiBTdGVmYW4gUm9lc2UgPHNyQGRlbnguZGU+DQpUaGFua3MhDQo+DQo+IFRoYW5rcywNCj4gU3Rl
ZmFuDQo+DQo+PiAtLS0NCj4+IMKgIGNvbmZpZ3MvY2xlYXJmb2dfZGVmY29uZmlnwqDCoMKgwqDC
oCB8IDEgLQ0KPj4gwqAgY29uZmlncy9jbGVhcmZvZ19zYXRhX2RlZmNvbmZpZyB8IDEgLQ0KPj4g
wqAgY29uZmlncy9jbGVhcmZvZ19zcGlfZGVmY29uZmlnwqAgfCAxIC0NCj4+IMKgIGNvbmZpZ3Mv
aGVsaW9zNF9kZWZjb25maWfCoMKgwqDCoMKgwqAgfCAxIC0NCj4+IMKgIDQgZmlsZXMgY2hhbmdl
ZCwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29uZmlncy9jbGVhcmZvZ19k
ZWZjb25maWcgYi9jb25maWdzL2NsZWFyZm9nX2RlZmNvbmZpZw0KPj4gaW5kZXggDQo+PiA2ZjY1
OTdjNTMzMWY0YWFkZjgyN2I0MGE4ZjI4NjQ3MjI1ODVmZGE5Li5hMTM5ZDdjYjQ2MzE2N2Y1OTkz
MWZkNGExNTFhMzA5YzI5YmEzYTQ0IA0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9jb25maWdzL2NsZWFy
Zm9nX2RlZmNvbmZpZw0KPj4gKysrIGIvY29uZmlncy9jbGVhcmZvZ19kZWZjb25maWcNCj4+IEBA
IC02MCw3ICs2MCw2IEBAIENPTkZJR19TWVNfSTJDX01WVFdTST15DQo+PiDCoCBDT05GSUdfSTJD
X0VFUFJPTT15DQo+PiDCoCBDT05GSUdfU1BMX0kyQ19FRVBST009eQ0KPj4gwqAgQ09ORklHX01N
Q19TREhDST15DQo+PiAtQ09ORklHX01NQ19TREhDSV9TRE1BPXkNCj4+IMKgIENPTkZJR19NTUNf
U0RIQ0lfTVY9eQ0KPj4gwqAgQ09ORklHX1NQSV9GTEFTSF9XSU5CT05EPXkNCj4+IMKgIENPTkZJ
R19TUElfRkxBU0hfTVREPXkNCj4+IGRpZmYgLS1naXQgYS9jb25maWdzL2NsZWFyZm9nX3NhdGFf
ZGVmY29uZmlnIA0KPj4gYi9jb25maWdzL2NsZWFyZm9nX3NhdGFfZGVmY29uZmlnDQo+PiBpbmRl
eCANCj4+IDQ5MWEyNzMyMWY5YzUyYWYzYmQyOGRhNTQ2YjcwNjViMGFhZjM4ZTAuLmI5Mjc1MzJh
OGM3ZTk5NjMyYWE3YzQ1Y2I4MDkxMTViZTk1MjRlMDQgDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2Nv
bmZpZ3MvY2xlYXJmb2dfc2F0YV9kZWZjb25maWcNCj4+ICsrKyBiL2NvbmZpZ3MvY2xlYXJmb2df
c2F0YV9kZWZjb25maWcNCj4+IEBAIC02MSw3ICs2MSw2IEBAIENPTkZJR19JMkNfRUVQUk9NPXkN
Cj4+IMKgIENPTkZJR19TUExfSTJDX0VFUFJPTT15DQo+PiDCoCBDT05GSUdfU1VQUE9SVF9FTU1D
X0JPT1Q9eQ0KPj4gwqAgQ09ORklHX01NQ19TREhDST15DQo+PiAtQ09ORklHX01NQ19TREhDSV9T
RE1BPXkNCj4+IMKgIENPTkZJR19NTUNfU0RIQ0lfTVY9eQ0KPj4gwqAgQ09ORklHX1NQSV9GTEFT
SF9XSU5CT05EPXkNCj4+IMKgIENPTkZJR19TUElfRkxBU0hfTVREPXkNCj4+IGRpZmYgLS1naXQg
YS9jb25maWdzL2NsZWFyZm9nX3NwaV9kZWZjb25maWcgDQo+PiBiL2NvbmZpZ3MvY2xlYXJmb2df
c3BpX2RlZmNvbmZpZw0KPj4gaW5kZXggDQo+PiBkM2RlMTY1N2MwOWFjOGFmYjc2NTUwOTRkODhi
NjQ5ZjcxMWUzNmI3Li44NWJlNDBkYjQ4NTM2Y2ExNTNkMGRhZThlZGE2OTUzMjc0NWI1NTI2IA0K
Pj4gMTAwNjQ0DQo+PiAtLS0gYS9jb25maWdzL2NsZWFyZm9nX3NwaV9kZWZjb25maWcNCj4+ICsr
KyBiL2NvbmZpZ3MvY2xlYXJmb2dfc3BpX2RlZmNvbmZpZw0KPj4gQEAgLTYxLDcgKzYxLDYgQEAg
Q09ORklHX0kyQ19FRVBST009eQ0KPj4gwqAgQ09ORklHX1NQTF9JMkNfRUVQUk9NPXkNCj4+IMKg
IENPTkZJR19TVVBQT1JUX0VNTUNfQk9PVD15DQo+PiDCoCBDT05GSUdfTU1DX1NESENJPXkNCj4+
IC1DT05GSUdfTU1DX1NESENJX1NETUE9eQ0KPj4gwqAgQ09ORklHX01NQ19TREhDSV9NVj15DQo+
PiDCoCBDT05GSUdfU1BJX0ZMQVNIX1dJTkJPTkQ9eQ0KPj4gwqAgQ09ORklHX1NQSV9GTEFTSF9N
VEQ9eQ0KPj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaGVsaW9zNF9kZWZjb25maWcgYi9jb25maWdz
L2hlbGlvczRfZGVmY29uZmlnDQo+PiBpbmRleCANCj4+IDI3NzhjYjdkYzg2ODAxOTExNTU1ODJk
YTE0YTIxYjZhNTIxZmRlZjEuLmJhZjdjOTM5NjM2MmZkOWY2YThlNTI3ZTI3ZThhZDc1YTFmZTY0
M2UgDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2NvbmZpZ3MvaGVsaW9zNF9kZWZjb25maWcNCj4+ICsr
KyBiL2NvbmZpZ3MvaGVsaW9zNF9kZWZjb25maWcNCj4+IEBAIC02MCw3ICs2MCw2IEBAIENPTkZJ
R19TWVNfSTJDX01WVFdTST15DQo+PiDCoCBDT05GSUdfSTJDX0VFUFJPTT15DQo+PiDCoCBDT05G
SUdfU1BMX0kyQ19FRVBST009eQ0KPj4gwqAgQ09ORklHX01NQ19TREhDST15DQo+PiAtQ09ORklH
X01NQ19TREhDSV9TRE1BPXkNCj4+IMKgIENPTkZJR19NTUNfU0RIQ0lfTVY9eQ0KPj4gwqAgQ09O
RklHX1NQSV9GTEFTSF9XSU5CT05EPXkNCj4+IMKgIENPTkZJR19TUElfRkxBU0hfTVREPXkNCj4+
DQo+PiAtLS0NCj4+IGJhc2UtY29tbWl0OiBhYzNkY2IwYzI3MTBjNDkxN2Q5M2Q2ZDJlYjM0ZGJm
YjAwNTE2YmMyDQo+PiBjaGFuZ2UtaWQ6IDIwMjUwMjA3LWEzODgta2VybmVsYWRkci0yMzQzOGJi
MzQyMTUNCj4+DQo+PiBCZXN0IHJlZ2FyZHMsDQo+DQo+IFZpZWxlIEdyw7zDn2UsDQo+IFN0ZWZh
biBSb2VzZQ0KPg0KDQo=
