Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21110C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95DE782E52;
	Mon, 14 Jul 2025 14:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DW7XpMKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0975682F49; Mon, 14 Jul 2025 14:38:48 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC1B82B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy0mZyOneT/qjCVVcCazo+PZID2ghsAEjFYfPRXKHg8CtUJzbYVAF10tRzv1ntMdNd8RTkQMr8RR/7CMQLnlHiZbrNwbabFyNl1JNLreyV2tCyf8wgQJmLE3+emmbYuOMRVxIIzzOk2ofpmGzmDsRYOgPEU8Z5PvTWWE/B21F5NqCCGd+/JRDJaHOfdjlVSuqBRsNmQp3IFSp+dRzsyLuP3rnBrD+LUYG/sfrEXS2OU7LRbtJW5ueBLN764FURhpz8yb8kvg7204gUqW6qiH9YNYQSgRiz41GvYWiwd9sv8KuKVnOFdJKVR4IEqk8Ri4WskLX0yQugCD8LsUxsYKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODoKjgakMH0YB6fc2hcWEGjpfkCgbyVRuI3U00iRDjs=;
 b=EdraXpEoQImbqPla1LbbTIcKcJa7uvZqKwnkHbUC2WqRD/Jjw3hGZExR9WnHghO9YawLwnlKiDqmdCSX7Ls2Fa2sk2LFaTtkFTTsSLrKQSoV7F2sfS+fHm7YyHrMb6RvsNoQRJc93jb1WPmz6al6aN3XZeImWY8NEBr7eESHEnj7JEvy4sLHoe4goVu3U9OQgMERmryxXkRGDQuPRhOxYlT3F2KVmCYqVT4HH/uAt4VAmYiT9ZJbouz/8qWKFViz3Mtyao7M9T2sRivDn+GWtE9OSC60f+xe/WhhwFaBfmsroqJbJSV6BK2TWw2SdZhpzht6qjvpxOdbG8QEXpmdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODoKjgakMH0YB6fc2hcWEGjpfkCgbyVRuI3U00iRDjs=;
 b=DW7XpMKQRjzpYi4kXO6UgU0FNI+wAWoBrJsKxdEHzeUWRcGVc4nwzT8JF4rnmUUR/tKjFDVDOH990uuPmIUhCLYlBVtzfCaMgFFOwuwVh4XmqZ7gdyjAQmqCZpVS4zDQJAj4jdKbgD5jg9Q/oyFfzy2oA6Gs/jaCq7aJQyMbs/QFDSStTsMT4iVNFXf0i7pF0EPQdDjntD3arQISzUUs3S5yHI3ZkCJy5a6Aw41F2F8uMtcvIRru9Iw54bkBNo7KiUuWxt++wEImiI4CmLL9569StPcOLMub1n0oqLIiIQ3d1QcopgejcV5uCNo+YVZJZJpWIvpX+MnrySgb4oqBzw==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DBAP195MB1003.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Mon, 14 Jul
 2025 12:38:43 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:38:43 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Bryan Brattlof <bb@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tim Harvey
 <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Thread-Topic: [PATCH v2] binman: Fix typing for python >= 3.5
Thread-Index: AQHb9IJntkmqyvKq10uFoFUqymKbzbQxhVEAgAAKIYA=
Date: Mon, 14 Jul 2025 12:38:43 +0000
Message-ID: <86c6b776c425e422290f72830d6a568123f740b5.camel@phytec.de>
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
 <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
In-Reply-To: <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DBAP195MB1003:EE_
x-ms-office365-filtering-correlation-id: 2b53edf1-2003-4936-04ca-08ddc2d35e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkFBRHpDTzkxdzRjcVMyUEFBZjA4KzRISkwvUEc4eUh6Q2tjeDV0eU5WWUdq?=
 =?utf-8?B?TVd4U2RDQkpwcmQyZCs5Y3lMU1k2eEF6YU4xWXZybkJoeFVsRkVTanQ2dFlS?=
 =?utf-8?B?anU2UTljWEdvVXh1MjdSbkdZSVR4MXBsOUcvbXJIWUVuQm12UVIwVmxRM2lQ?=
 =?utf-8?B?RDJwL0ROMC9OM3d0T0FTeHFNUGdlK09qLzJYTTFrb1R4bjIvQ01rTklYQ0FE?=
 =?utf-8?B?WFRVM3FFWVlqWHF6OTRaL0lGOS9NdnVYUUEwWHlYOG1uK3E3cVJCM0J1MDUz?=
 =?utf-8?B?alVleEVFNUcvVWtIZ0tFd2RYa2d1S3NpRzNUMnlkMFliK3Bxek5TM1B6MzYz?=
 =?utf-8?B?L2ZySzJBVDVNR1p1WDZ0bEN3U3plTnl6aDIvdTNYQWRjckp5K2hHQmZ5ME0x?=
 =?utf-8?B?dnMraXUvSDdnZ3l2aTF1NjJTRVBQTlZxODZlMmpHRjFZV3dsaVhwZFYyclhp?=
 =?utf-8?B?aGRESFNSTXc1cUlDeXg0MVRScEwzRmxEV011WXZUR1lXV2h2NFJwd1VDaSt5?=
 =?utf-8?B?VXNlRTh4ZjYwL1NWeEZUNkUza2ZocUhmNERjSENHa0UwTjdCYWdoSS9xRzJC?=
 =?utf-8?B?OXRHQzhHeXVxTXA4MlNHSXkxT0E4S2E2Y2VrN1ZaT0N4TXpLd2xiWTNidEpL?=
 =?utf-8?B?dlN1T0w1WVRNaEFUMGozZ1UyaHJrTnBOZ05qL3dzZmRoUUtKL1EvYnVFUDlu?=
 =?utf-8?B?SXo5ZW9XblgvSmZXUVdwRGJVN3ZuRnBjeU9DSTRueUlGakhXUzlIR3VDZ3ln?=
 =?utf-8?B?VHNzSGN5VzBwWm1nRUI0bUJkM2dEOFpjRGQ2MHJpWDN0N2hRRXY1WWtIRXBs?=
 =?utf-8?B?OHFHaHhMcGR5Tm5ZM05RRXllWU54WHRQUDJXYmZURTFmbHZ3OWxLWHAzSllY?=
 =?utf-8?B?QXNwMWpnTGVPK1VnNWF2QkJZSjlGakd0bitxY041bWJZRHFsTVBSSVRieElI?=
 =?utf-8?B?dGRsenVxU21FdWtpZlptVUdycUxXWUlxNW5RdFN4V1R5Q203RU1hY1B6ZTIx?=
 =?utf-8?B?L1pVbUZZdkxZdHRCSTNUOFlSRDhPTXFrcmJJVC83MUVkTU9iT1FLbEh3N3Rk?=
 =?utf-8?B?RDA5VmlLY1M4dk5zZk5HMVBCWkEzS1oybWcxcGxZcXFsdnkxdlhQMXBNeE5r?=
 =?utf-8?B?d2hLYzd5Q2x6VW91aTZEL0tFZVhtSk1XMS9OeHVkRTJidmVMWmdHd2FsQjhN?=
 =?utf-8?B?KzlrS1hkSVhYYXExRy92ZXZNTjNKY2ZXdDRSS0JOY3phTlJkM3I3SzcxRElX?=
 =?utf-8?B?K0NJdDNRM3NnbUtEMFVWWnR6UVRaWi96YVRpZ2p4NGJMeDFhQmYwL1lXZEkz?=
 =?utf-8?B?d2NPMnBsZllJb29QOEZDTko5WnFrZ1FEck5xNHlzdTR0a242WVdCQjZFUFZM?=
 =?utf-8?B?Mzd1OXhxbkhhWndRWU4wN1orZlpJUE1ENWJEeGRyQmJZTVJmWW9EOUp3eEs1?=
 =?utf-8?B?dmo2dFF2Q0IvNWpKRzJqdWxRSllXYjNuUVg4UERBd3NKY1dONXdpUDFvWjdB?=
 =?utf-8?B?bmdjSmlFWWNFdEtWdW5vKzhJbXRHa2lpMUdjSTM5VU5DVVhoaXIxTC9PSWY4?=
 =?utf-8?B?bzhkRnhxN3FJWWxXRlg0WS83THlmbk84WnBDZktQZ3VIRnFLVmtTaSt0UjYv?=
 =?utf-8?B?TFRxMkZWRTdoUXN0VXpLNE9nQzFzQmlET0xtakhsVHFHYzJsUkFxUFo0c1Rv?=
 =?utf-8?B?MExXRFBIbnVKb2h2L05MNkJyOURob28wR3BmYlZTUFNUT2xZNXo0UUFYRDRh?=
 =?utf-8?B?Z2VIUEtiSmovbE1CZy9aNjNYS0w5U2F4Z1pzb0kvTkY2Z2dQVEJlV04zWGp4?=
 =?utf-8?B?YlFMQzRsUFVoY3FHV1dKYUk3RGlreDBzdmlkR1NkKzBuRmFOcFB4aVVvQTJ1?=
 =?utf-8?B?cXBNUVZNTjNzN2RtUmp2R1Z2MUtXT1RhSTRlMFVSWThrbW04YWNDZGJBS2VK?=
 =?utf-8?Q?PbxdkuWiZWE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjZQN2plQ3FQcHdXV0R1VFRFOFNKUHI5SmttSUg1cUxISlozeVRMaEtCNzNi?=
 =?utf-8?B?aGcxOWtjSS80UDlubFh4ZlFXb3cwaUw5K3BSS3ZuNVJxZGR4SFRDUjZJaHJN?=
 =?utf-8?B?VmNaaHR2S3l4SWExR3FMU2JYYVpMTXRjcXdJbk5XcXVTOEhORlJTWkh0WnR2?=
 =?utf-8?B?REpFMnVZZkdSbnI1Q05hVG1qbXdrdTZhVU1SM3BEejdOenZGZGszN0RJQ2NP?=
 =?utf-8?B?QlE3TWxiZkcyWmJSL0RuVmRtR3ZzOFIwZjRJa1lSa3Y4ZVB2VGRJa0lab25U?=
 =?utf-8?B?d3p3alpQeGxYNlRLMWZoNy9wcU5vazRzM0dab0d2aGFnUXByZSsvZ3doTGw0?=
 =?utf-8?B?QUIwY05KL3dHUDVqbUtYcVozTHB4K2k4VnNBYWZIRDBacUp0TldreDRqSHFn?=
 =?utf-8?B?M1VhbDRzZ2JMdmFpRWllbGF0U2FPZmp0eExvRGtoTEIvdnAvRFVJOFRNQmUv?=
 =?utf-8?B?SVZDVEVacG90RUpVb0twZ2NhUE9nWTN1YkJFa3J4cnFtdWJLOUN6aGlUTXg1?=
 =?utf-8?B?ZkdQckZqMzRLdmF1S25EWWNhSjFCYkZESzBqOHFFVUwwQ2U5TVl5Y2FzWE82?=
 =?utf-8?B?Ky9VUVhzdEFKQTVDa3lLd1NFUXZBTlVjRGE5bms1Nzc3ZU53a2VGM2xvOHlB?=
 =?utf-8?B?WEo3dkZKYitWYnk4SVZUalhnWVdzWDBtcGVxZGhRR0VRaUNBT2tLWUdsQlh4?=
 =?utf-8?B?VERaWjJTMzFsN21TczFnK2ordWF0UGJFMDJ0ditUUnlhRk9Ka0ROUTZLNnIv?=
 =?utf-8?B?czBGYVpsUzFrWk1xL1VJT0xSUFhaRjRJVUJvNkxpQ2ZSV3NuOTEzZ1ZDVHcx?=
 =?utf-8?B?Qld0R204NGdRSGRaQUtGSDhwK3B1YSszanZTejRVNWVBY1BzNG9hTDM4c25q?=
 =?utf-8?B?WWxrT3BSVlZRc2Q3eVllWlFxaGRFdDlFU2NROWJLbVJoK0NCajBZNWc4aEox?=
 =?utf-8?B?NVJ5QkFnR2RuWVl1UGszOW9xUENCVkxXUWlhSXlrTURDOUk4NUVOL1EzUkFS?=
 =?utf-8?B?OWkrRXNHbkJ3QVIwcDErcmMrUXFNUFlkV0ZQK0wrdkJYVHhLUXJjaFFpOGpt?=
 =?utf-8?B?T2liczZkb3J1ZWViZ1hvRHdtdElWQXhTdmRjYklwbS9xeTZLTG8xRitvV09t?=
 =?utf-8?B?TUs0blY5eEZzUnlscFA4TnRKeUJVNFNWODVBdjAwVStFNW5QaHp5eTlzaTZI?=
 =?utf-8?B?Mmo3eUdNdTBxemwwSWRsVXpOSG4vN0F5U3VwTDcvd2NkZ0lIREN6NHJ3emQz?=
 =?utf-8?B?V1J6Y2xmbXJoRm5sYkgyUTFmWExxR3U2RTZyVHkwZlNudEhNMUJXVDJQdjk1?=
 =?utf-8?B?MXFiTmlkU1Vzc2poRXcrNjJPZW1wMkE3a3VMeEh5K0RZREgrRkpOUWxERzRG?=
 =?utf-8?B?dXZ6M1ZwanpFQy9KdnpDK3laL0FRYlljSlBTVHdWU2gwNkFWSEtLa3RHU0lL?=
 =?utf-8?B?YkZkelJnRDltdWYxYWRYVFJ5QW1qeXlTalZ6Y3Blb2dFK2E0bGcxbjJKOHY5?=
 =?utf-8?B?aldYM09lRWM5NUt2R1lSSnBUSllNbVB6ek02bzZuOVZ3UHZmVllEWFBCazZF?=
 =?utf-8?B?c0JqZmdERU5jY1kyYVZTSzVtOU5pK0VETDVNOEp3emVKRlhLTzFaRWFMUHh6?=
 =?utf-8?B?UEhWV1VLUFdycGV1cGRicE1rdDRYMnllaW9tcmpBUDFsSllrSlE0bW1GUjA3?=
 =?utf-8?B?QjVCeWx5WW1FM0NnZnkxa1RwVjZmelBBeWdCQ21BbVJMdDNhcThQeXVrbzE5?=
 =?utf-8?B?Ty9QWURmLzZoSFZkeGtDWW5Ra2w3dTBxbWo2TjdVMjk1THEySWw5c2I4Qys2?=
 =?utf-8?B?RkhiN1VsajVyK3pYYVRSSWpmZ21tRDVucExRWVNjQllYUVA0Y1FxOVpySUZt?=
 =?utf-8?B?VEwwVmdxN2VjNUlIWjROZFc0bXNnbWdTUU5YOFFzclV6cTRBRUdzUldtbnl6?=
 =?utf-8?B?RVgxY0lRNDFoa1Z1bmY1UE03cFR4VkphTlUrbExOQStJckZLMXUvZGp4Mm1F?=
 =?utf-8?B?djhZS1owSE0vcDFWTG1lZTNKVkRPcFZHSVhkR0h0Q3N2d2NSS3pGNEc1Q0p3?=
 =?utf-8?B?ZEJpQ25VTExzVmpQZFRxUC95aEVOS3h3M1B2NlkvNEVRaG12cEhjbDZRSjVG?=
 =?utf-8?Q?jtds=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C522278764B084A9A637AF5771950F0@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b53edf1-2003-4936-04ca-08ddc2d35e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 12:38:43.6359 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+GPx1qbgH2tMtEMjpcBi2H8z7q20NzFTFCs4tbATvl4iSK57xVyXMXjO2/D4s6hdUoj3Ud5Yi5gW2Gk8LBE4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1003
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

QW0gTW9udGFnLCBkZW0gMTQuMDcuMjAyNSB1bSAwNzowMiAtMDUwMCBzY2hyaWViIEJyeWFuIEJy
YXR0bG9mOgo+IE9uIEp1bHkgMTQsIDIwMjUgdGh1cyBzYXlldGggWWFubmljIE1vb2c6Cj4gPiBU
byBtYWtlIGl0IHdvcmsgd2l0aCBweXRob24gMy41IGFuZCAzLjYsIG5lZWQgdHlwZSBoaW50cyBm
cm9tIHRoZQo+ID4gdHlwaW5nIG1vZHVsZS4KPiA+IAo+ID4gUmVwb3J0ZWQtYnk6IFRpbSBIYXJ2
ZXkgPHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbT4KPiA+IEZpeGVzOiAyMWJjMzQzM2E0M2QgKCJiaW5t
YW46IHJld29yayBkcm9wcGluZyBhYnNlbnQgZW50cmllcyBmcm9tIHBhY2thZ2VkCj4gPiBpbWFn
ZSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4KPiA+
IC0tLQo+ID4gQ2hhbmdlcyBpbiB2MjoKPiA+IC0gZHJvcCBuZXdsaW5lIGNoYW5nZXMKPiA+IC0g
TGluayB0byB2MToKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA3MTEtYmlubWFu
LXR5cGluZy1maXgtdjEtMS02NmFiMDc1MDE1YWNAcGh5dGVjLmRlCj4gPiAtLS0KPiA+IMKgdG9v
bHMvYmlubWFuL2V0eXBlL2NiZnMucHnCoMKgwqAgfCAzICsrLQo+ID4gwqB0b29scy9iaW5tYW4v
ZXR5cGUvbWtpbWFnZS5weSB8IDMgKystCj4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9zZWN0aW9u
LnB5IHwgMyArKy0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS90b29scy9iaW5tYW4vZXR5cGUvY2Jmcy5w
eSBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9jYmZzLnB5Cj4gPiBpbmRleAo+ID4gNTg3OWYzNzcyMzFi
Zjk0Njk3YmVhOTdjM2NmYzNhMjUxNTY2NWI4Zi4uYzVlNzdmM2EwZGYyMmZmNzY4YWE3MjU0ZTRk
ZDllY2JlNgo+ID4gZjgxNjg0IDEwMDY0NAo+ID4gLS0tIGEvdG9vbHMvYmlubWFuL2V0eXBlL2Ni
ZnMucHkKPiA+ICsrKyBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9jYmZzLnB5Cj4gPiBAQCAtNiw2ICs2
LDcgQEAKPiA+IMKgIwo+ID4gwqAKPiA+IMKgZnJvbSBjb2xsZWN0aW9ucyBpbXBvcnQgT3JkZXJl
ZERpY3QKPiA+ICtmcm9tIHR5cGluZyBpbXBvcnQgRGljdAo+IAo+IEl0J3MgYmVlbiBhIHdoaWxl
IGZyb20gbXkgUHl0aG9uIGRheXMgc28gSSdtIHN0aWxsIHRyeWluZyB0byB1bmRlcnN0YW5kIAo+
IHdoYXQncyBnb2luZyBvbiwgYnV0IG15IHVuZGVyc3RhbmRpbmcgaXMgdGhlICd0eXBpbmcnIG1v
ZHVsZSBpcyAKPiBjb25zaWRlcmVkIGRlcHJlY2F0ZWQgYWZ0ZXIgUHl0aG9uIDMuOSB3aXRoIFBF
UCA1ODlbMF0KClRoYXQgaXMgY29ycmVjdC4gQWZhaWsgaXQgaXMgc3VwcG9zZWQgdG8gYmUgcmVt
b3ZlZCB3aXRoIDMuMTQuIChTb3VyY2U6IEZsdWVudApQeXRob24gMm5kIEVkaXRpb24pLgpQeXRo
b24gMy42IChhbmQgMy41KSBkb2VzIG5vdCBoYXZlIGFjY2VzcyB0byBfX2Z1dHVyZXNfXy5hbm5v
dGF0aW9ucywgdGhhdCBpcwp3aHkgSSBhc2tlZCBpZiB3ZSBzdHJpdmUgZm9yIHB5dGhvbiA+PSAz
LjUgc3VwcG9ydCBvciA+PSAzLjcuCgpTbyBpdCBzZWVtcyB0byBtZSB0aGVyZSBhcmUgdHdvIHBh
dGhzOgoKLSByZW1vdmUgdHlwZSBhbm5vdGF0aW9ucyBhZ2Fpbi4KLSB3aGVuIHRoaXMgdHlwaW5n
IG1vZHVsZSBnZXRzIHJlbW92ZWQsIG1pZ3JhdGUgYW5kIHJlcXVpcmUgcHl0aG9uID49IDMuNwoK
V2hhdCBkbyB5b3UgdGhpbmsgaXMgdGhlIGJlc3QgY291cnNlIG9mIGFjdGlvbj8KCllhbm5pYwoK
PiAKPiBJdCBzZWVtcyBsaWtlIHdlJ3JlIGFza2VkIHRvIHVzZToKPiAKPiDCoMKgwqAgZnJvbSBf
X2Z1dHVyZV9fIGltcG9ydCBhbm5vdGF0aW9ucwo+IAo+IH5Ccnlhbgo+IAo+IFswXSBodHRwczov
L3BlcHMucHl0aG9uLm9yZy9wZXAtMDU4NS8K
