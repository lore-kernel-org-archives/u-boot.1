Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22743EB48EA
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 09:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 542848367F;
	Thu, 12 Feb 2026 10:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UXYqU5sC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2024183A47; Thu, 12 Feb 2026 10:03:26 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023074.outbound.protection.outlook.com
 [52.101.83.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A6983015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 10:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNAo0ci+HlDNjiNLCpPM7FDxYg429I5Lu7FmZ+wsQyT8B9GN9XEeKGIDfD7tCQCZ/qKo9NeNcw6k48gHHdu8Ay6sTbammrTU3DCtQRJMsrdP6TDnfd5KrS0ejCCs4VnlAL7BmhkYPJOttbC5FuvBoptayjXdAOU0YGBt8pT4ecrn20TA8mAe8VChNYY/ePrX4AqfD8UOE14U3LF+BcAQg2f9h6Yak1+YYjM7Ap/vjppkA+rOV6FdCCiydOrmhMQIdXj6Yb4PROaIQBCL0ku7JPwPnatwzwk2DQyL5ngczSzuyE7cH3+SrjPZpRvkfHqiA613HpmtG+oBrC8/eVCZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxmwPn7JPyvPePtVriHQqizIczLK8fICgxFsOsRSHOw=;
 b=i64AV3aQqJjhBZ6F6aIhzl4dYDhWG6j2qBn5Tms6QkIvKwExoAOvjNmPcxVVrWmL0NGgJQieBjpD8Xsc1TzuPaNX9NiGUCTIQphzIFXNCh0hkCiFHyvY5ekbJBIBkMhM7BbMg6cvK6CuQyp88PZwGc/5ot3SYL2Q1H72T+JGRvyCbSCHf7TUrC51MGjgIbGrU+xor7y9cP8yk9bLp2aeHRRSTvcnhuFhiF3oo20SQ/y3lDaO3scTwaz+B4LTnqmhZqEnWFxBriczW29mtzOY8Yemwoex8aHJlM3zGHtoHlDM78fbafwFtjRHUHD4/ZNSryy7qkzM8/3G5DGOzyuY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxmwPn7JPyvPePtVriHQqizIczLK8fICgxFsOsRSHOw=;
 b=UXYqU5sCXLap7zrLLbJLBLWDZLD+sch2I6zYcYZc7uL96J4efIy2EstKBaP4Enq2/f9R4663N8Qx/6iB+SqlYmEGvsrrexA1sleGieI16gQ4bZgyIpGMjTbKW8sD5DErXz+2KN3enArwuaKF5odDN/zqP7ZNf3XGcgssr5pZeWle5ElhDnmnSTgotN8ZgASPJTlL407Yfu6Uj33neQ7fiwfnOFRPwDmgc1b+OSvl3HdHmjTWnRkSDPapQZ3hHd//J8U+ZipyzeV30Wy7Mi9mIETZkOxiBulSkkmsSysMRvP64C6PbyAjL+LHDhdmrzQ097oNtCyYUE5UAtQWMOigJg==
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:588::12)
 by GV1P195MB2548.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 09:03:07 +0000
Received: from AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::8e78:7eae:6eb7:57a9]) by AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
 ([fe80::8e78:7eae:6eb7:57a9%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 09:03:07 +0000
From: Benjamin Hahn <B.Hahn@phytec.de>
To: Christoph Stoidner <c.stoidner@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] board: phytec: phycore-imx93: Enter fastboot on USB boot
 by default
Thread-Topic: [PATCH] board: phytec: phycore-imx93: Enter fastboot on USB boot
 by default
Thread-Index: AQHcm/pGT2Me3g5w+kigZzw0WuSNQLV+xNgA
Date: Thu, 12 Feb 2026 09:03:06 +0000
Message-ID: <77d67c37b9ba17172b08c2fc91c89c79faba23e0.camel@phytec.de>
References: <20260212083330.3293928-1-primoz.fiser@norik.com>
In-Reply-To: <20260212083330.3293928-1-primoz.fiser@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4P195MB2011:EE_|GV1P195MB2548:EE_
x-ms-office365-filtering-correlation-id: 8a0b7b8f-4271-4245-51dd-08de6a15899d
x-ld-processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzdTcHpQM0FndVdCT0l3cUN5YVc1RDl1Qlo2cHZ4OXp6cHN3NDNseG05emdu?=
 =?utf-8?B?Zitmenk4NkxaeURLTVpMK0pIcy8zN3lPTTFPSjJ3N2l4bytlOWRYbHMraDM4?=
 =?utf-8?B?YTB5MHlMQ0g1YXp6YUMvcVJ1RGQrQmtkS2lyZ0QwczlGYncrbWtqUXNPREFa?=
 =?utf-8?B?MGViRFVBRFZPLzFUekFuNmQ0QndpY3BsOFBsZmhHOTVVZ1FxWVJuQUZZWnRh?=
 =?utf-8?B?dlVzT0ovVUVUTEpSbkVDZk5tQnMzS2hhYXZ0bG8vaGpZUEJOd0JWa3VhQThr?=
 =?utf-8?B?blF4YlREc0F1TDFNZktraEhYQVgzaFp1UElFNk93a0JTbFdpOGFVL3p6NEFo?=
 =?utf-8?B?c01weVJTN2tMWXBqOFo2bFhhUld2d2EwUll6VnZ2WHI4WEgzMkY0bTdFQzl2?=
 =?utf-8?B?b0d4Y2lPV0llbmdZNWFhMi90TzZvT1NTWHFwVS9WU0d3UGFPcGZjSHdVWmE2?=
 =?utf-8?B?aWlvT1Y4TFFEVEtvc21LVDcrSVRPT1pSbnlvUXdOVEZ6TjdvbGRWMGx1SkxH?=
 =?utf-8?B?RW51WGlKSGtOak1lMFNSSEFTQ1FqNzk4RG9sOFkybWppc1graThXd29ya3lN?=
 =?utf-8?B?bUdRSm9HRmdleE5FajQ0UU9HMFdpSW44eFpLWGhZQ3EreUpGVWVROXpLcGlq?=
 =?utf-8?B?YWl4bCtOQ242RTNFaThZWmVvMlBnVVFBdDNTUFVreU9BcWZEUUw4bVJuZm9D?=
 =?utf-8?B?S2VPeFBncTNyYnc0aGRDWm5JeGN3dG5pQjBOTG1WZC9qSkRtazZxZFF6UG5j?=
 =?utf-8?B?RER2N0NqV1NXWU5ZdGJIc1daV2k3dDVJcE1wTnFJQVR1b1FxN3RCaVhJYmZv?=
 =?utf-8?B?M0QyTmFhY2c0d3NrZFpzSzlHSGxIQmdaRXBDNDJPc0xZM2RnL1hqb1hpdzIy?=
 =?utf-8?B?VEpEMDI0Z24rYzc5aGR6T0lyV1g5TWRzMlpXcHdlVnQybkhweXRZS1Q3RlJl?=
 =?utf-8?B?Y2IxeTc3TDM0blY5RjdqTnBncHRWQkdNbklKdGRjVVo4eTJFZFlNcEpaSTdj?=
 =?utf-8?B?ZU9yemNjN3dCbmZydkFKUkdSNjQzTHA5cmJzRytkNU1uRnA2YytsOVA4ZmRI?=
 =?utf-8?B?cjRkVmpPQjNrRGJkd0UwZG5yejBmTUh5TWkvY2FpU0pXMGV6WUVSYVAxNnFD?=
 =?utf-8?B?UGRpL2I5UDZpU3BseE9STjUxd2JxZXZHUmZkYVZyejBTQXk4Rnhuc1RjOWlG?=
 =?utf-8?B?RGdoZU84QlhxNDd2MktRZC80UmRONTBESi9zMStCL0lrclkvR0RXZTdnTStl?=
 =?utf-8?B?UUd4MXl4YnBSQ05mK2NkSVcxUUVjM3VjSGQ5Q2ZGUGJMWWtBTzVsUU16a083?=
 =?utf-8?B?UWJGTm01bFd1RmpSSmRwTnRlT3RHaVhLU2ZtMm1BeDZ6c0JwZGFHZmxDVERO?=
 =?utf-8?B?RkwxUmJQZ3RpVUNsSDQvaXZUZ00xaHM2Y3lySGM1QS9HcTc0NllpSEVkZU5Y?=
 =?utf-8?B?YUlUSUtDVGdJNEdlVGsvNjMwUERTdGJNQWp4UmdtT2hqYUsrWlovN3piWENr?=
 =?utf-8?B?YXhIcFV5S2JzQ09nSXozaUZMMmdsWlk4VzVLYW9QaGhVa0xkR3pMOENlck9k?=
 =?utf-8?B?Y1RVMUtZNy9GcTNvb3hFVktUK1VLUUhTZWZHcTlQRC8rbklGSTlJcnRCcXFi?=
 =?utf-8?B?Y0xvaGNUOUVnc3RHdWYzVzV6TVdmbWk1YUJIQkZjUmFiMFhnYisrSTE4R3ZR?=
 =?utf-8?B?d0FpYzYvdm5WWnJ0QklwTzJhQkJlNGpXM2pkczRBUGQ4Z3VYL3ZWRUNmWWFI?=
 =?utf-8?B?TDRRNGtVZnIvL2JkM280VkhFSk52YnZNZDczQjZ3Z2NzSDNTbi9SSXVoNGhV?=
 =?utf-8?B?Q2x5YSs5S0ExQVFxWDVGTTY1Q2hSKzR5OUN4d0F3dHZpWEtILzRTdEt4RG9M?=
 =?utf-8?B?M0VwdFNQa0ozbmViTnpTTGRCenpjcUVVdng4QVRQakxMbkZPV3doRTh3VzFh?=
 =?utf-8?B?T1h3NWFia3hvVG1JUnRscDhPSDY2MWxJR1M5QllUbUkzM2pJTWZYVk1uY2dv?=
 =?utf-8?B?eXgwRGFyVUUwL0tDdWxFbWIvV0diRExsVklXME1GaSs0ZTE4SUhXOE83RXVN?=
 =?utf-8?B?VTMxL0tMNmNxNW9qSm14R3VBZ1hPY1JxMTMxcnBXSVB2cDRVS2t2eEc2bXMr?=
 =?utf-8?B?T051QW5ac05UcGpOZzdrMnFKUFpmV2VSazZLV2pTOC9ZL0tGTVM4ODNQRHJM?=
 =?utf-8?Q?J8Kib0UQQnVRs73DZh0FVJ8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB2011.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekI1S0hTRVArV0FSNzNnRWdwWUtJZEw0RjZhR1IrN2xKeFdub3ltQVM5UkEy?=
 =?utf-8?B?L2NFQ09DSExNSThNMVlxNjNCZktIM1dieS9FWlV5V1BUOTBQT0EzTUtybm9U?=
 =?utf-8?B?bmtWOXdhMkg5QVRVUE5QS0hEeU81U0V0UndkakZCN2lYMjd5OGF4NWVndHNY?=
 =?utf-8?B?bTYyanNJWm1XWHBxUXBDYTZ6Y0l2SGhLNitILzd6T3U5aDY3cHkrSjhQYnpG?=
 =?utf-8?B?bmpoOTJQekRGcG02cFUvQ1dqby9Na3A2UUVEYmV0TThKVW1tYkhSSHR4aUhy?=
 =?utf-8?B?R2pWZFVUZVl3clI3ejBIcnZiTTdRZk54Z0xNaE5ZSVpSbjlsVEtXTFQya1M3?=
 =?utf-8?B?WktxYUVLdkI1b2xBSXY1dldKRXEwd1FKL1JVbUFrZHhEdVNxN2FMMEdBZ0Z5?=
 =?utf-8?B?ano0ZCtuNXNETlQ4TUxrRVErMWpYbmFUbGIwL2Vid3YzRXZ2aXZsTWR2QmVl?=
 =?utf-8?B?aFhFZi9Nd2tDK0ptUlFPM3UrTjMvOFIvZW1nOHlyZ2E5dlZIdkFDMXJnQmZC?=
 =?utf-8?B?TmNwK24yaHMxclJQOS94NzU2U3VNcjY3TEF5QjVSK2h5R09zR09PdWxKWldz?=
 =?utf-8?B?TnJid0FRaERhWm5rSUJ0SG1mUkFUaUVWY2xOYUdoSVpDd1RpT204MGppNFVU?=
 =?utf-8?B?ZFRGQlVyZ3Blb1FNdjVtUlR6dUR3T3FSZzdSTjl3TU82M016VHZtcVJoeWg1?=
 =?utf-8?B?WGFzWDU4TVNJUzNOb3plQTJNZFNSbStmR2hDK2hmbmRXMzhXWjJaZWZnS2hP?=
 =?utf-8?B?U3FwQndNU1NnVmMyRzdCRHRwVjBQWjhZSmU3ZWcwZ1B5dktSVXNQbm1zTk83?=
 =?utf-8?B?ZHorYldFR0lZY3M1aWNiMnlOTHR4cWpJN3ZxajN3Vk5kaEd4QThsUS9TK05C?=
 =?utf-8?B?NVpqSEZuZTNabkYvWW5UTE5iZk9lVVduZkZ1MUxTa0xaanR1N3NVd0dFVmpz?=
 =?utf-8?B?NUFrV2FHSU5UOXZ1MVMwS1NkN1JEZWt2eXRwa3V3ekRrdlJ3UW1HUzQzbTFZ?=
 =?utf-8?B?eHl5L3NGQ0FGcmJGa1I1SG13WDAwTWZpNzRVQTQxVENqS0JudysweGs5aDIz?=
 =?utf-8?B?Uko3NG9ycURXc1o3cW5QVStQNUNsM0JieDM5ekFObUk4bGx2L2tYaCszUnlh?=
 =?utf-8?B?MkxweCtBY1BJWjUzb2tUeU90QXdQcVJTdDNicXVUdksrQkdjYU9hSTVZOUdo?=
 =?utf-8?B?TjU5eitRL3FlMTY2bmNUdnpIczcyYlk5aTlWQ0o2d3lmQ2hsajlpRXdmbVJn?=
 =?utf-8?B?eW5QZk5pcGtmOFliYndLZUJWT3VwYTV6R1AvL2RmRGVNbVU4a1F4SHhWWThs?=
 =?utf-8?B?c0hvazlSNXlFUThsKzk3QjdwUzFLVm56MGZvZ3pOb3N0VXV2VGxDWUJaSzgw?=
 =?utf-8?B?OEhhY0RySGhrbE1ZWDhaSDF5NDN3ZE1LWTlaV3N0MkdnbEdmZE9xZUFzVzMw?=
 =?utf-8?B?aGl6Z1UrWUo5V0UrNTJjV1V2Slh3eDZjZFpoQmZIYXpXTzl3UlN1NE1xdlBH?=
 =?utf-8?B?SDlHOFMrblcxM2VNTytnY2tYV0R2aHlWOElKNy9OMTV2dTRqS0d6UitEVVlM?=
 =?utf-8?B?VEU3c0Q4Y1Y2TzFoeXg2RVU4Q3JqY2xvWHU2RGJWQnZVMjNzOFArRVYrTTlG?=
 =?utf-8?B?dlNncXFKZmczVGlwYm1HOW1DSWlmQ3c5NXFMSVpsd3ZoQnlEQXJzYU96MUpq?=
 =?utf-8?B?NW9NTzFFcUZmdlV4cytxVnFoWUZPYVRPbjN1cHliaTlUVnRGVnF4VEc2MFFa?=
 =?utf-8?B?Tm5pd2svYkFrK2RyYmJQSUNjemJqMExMNnZXMmpzQlhoSlNxMExsL2JrSm5n?=
 =?utf-8?B?ODYzODZoa1VXSGNlbmpmQlJhdFNiUmpXdnp5RW11WGM0clZkblhLL21oQzBs?=
 =?utf-8?B?blRwSjh4YzNtcGIxRGRPR2R2WlNIelJiZjBVNXBJZDFBOWxjc2NtWG00VjJ6?=
 =?utf-8?B?OHRuMGtjMWhXNCtKTVhnSHk5SEdwcXVpYmh5THFkUmpJL1dtWFUvTDV6SFVv?=
 =?utf-8?B?K2hSb2xDMjBVd1p2WlA2L21IdSt0ZmFNbU5GK0tIbHRYNnBIT0d0K0diMzYz?=
 =?utf-8?B?eUJLR3JLSE5VV2hUNGxCZm1RUEQ4ZTI5ZkxQY0huTEZSREdPc2ZjaDlmTGJW?=
 =?utf-8?B?c0dBbVhOVXhub1hlbEl0L0QzSERCQWl3ZGt4S1hxWStrVEJ0a0U3Ny9XUWdJ?=
 =?utf-8?B?ZXN5WG9hR1B2ZGIwcUVmWlVPWmVNdTIwY21nME80c04rVlByemxYYlJZRmVa?=
 =?utf-8?B?NGtHd2hNRHErUHkvU2RubjlMMnowMHZVRWFGSWw1QjFUcUhmRFc4UU5ieWRF?=
 =?utf-8?B?a3dCU3JpUWVQZ0RWUnFLMVc2eWhHWnV5OFFvTkEzWU5zbDFraGZIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FD43D85BE64964FAF0A17D5AD5DDAB1@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB2011.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b7b8f-4271-4245-51dd-08de6a15899d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 09:03:06.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73Bzm/TlpbOOBB9FmMCz6srLbL2XojX2E67PHfMASJc7kv8xhjTn+pKm9D02rE7JI7saBQQkLjBmh4+e8kp4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2548
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

T24gRG8sIDIwMjYtMDItMTIgYXQgMDk6MzMgKzAxMDAsIFByaW1veiBGaXNlciB3cm90ZToNCj4g
SW4gY2FzZSBib2FyZCBpcyBib290ZWQgZnJvbSBVU0IsIGVudGVyIGZhc3Rib290IGJ5IGRlZmF1
bHQgdG8gZW5hYmxlDQo+IHRoZSBVVVUgZmxhc2hpbmcuIEluIGNhc2Ugb2YgYWJvcnQgY29udGlu
dWUgd2l0aCB0aGUgcmVndWxhciBib290c3RkDQo+IHNjYW4uIFVzZXIgYWxzbyBoYXMgcG9zc2li
aWxpdHkgdG8gb3ZlcnJpZGUgdGhlIGRlZmF1bHQgYm9vdGNtZCBmcm9tDQo+IHRoZSBlbnZpcm9u
bWVudC4gTGFzdCBidXQgbm90IGxlYXN0LCB0aGlzIHN5bmNzIGJlaGF2aW9yIHdpdGggb3RoZXIN
Cj4gUEhZVEVDIGJvYXJkcyBmcm9tIHRoZSBpLk1YIGZhbWlseS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT4NClJldmlld2VkLWJ5OiBC
ZW5qYW1pbiBIYWhuIDxCLkhhaG5AcGh5dGVjLmRlPg0KPiAtLS0NCj4gwqBib2FyZC9waHl0ZWMv
cGh5Y29yZV9pbXg5My9waHljb3JlLWlteDkzLmMgfCA1ICsrKysrDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDkzL3BoeWNvcmUtaW14OTMuYw0KPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkz
L3BoeWNvcmUtaW14OTMuYw0KPiBpbmRleCBjZmM2ZDkxZjIwZjIuLmZlMDAxZjc3ZDRiYSAxMDA2
NDQNCj4gLS0tIGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OTMvcGh5Y29yZS1pbXg5My5jDQo+
ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDkzL3BoeWNvcmUtaW14OTMuYw0KPiBAQCAt
NDQsNiArNDQsMTEgQEAgaW50IGJvYXJkX2xhdGVfaW5pdCh2b2lkKQ0KPiDCoAljYXNlIE1NQzFf
Qk9PVDoNCj4gwqAJCWVudl9zZXRfdWxvbmcoIm1tY2RldiIsIDApOw0KPiDCoAkJYnJlYWs7DQo+
ICsJY2FzZSBVU0JfQk9PVDoNCj4gKwkJcHJpbnRmKCJEZXRlY3QgVVNCIGJvb3QuIFdpbGwgZW50
ZXIgZmFzdGJvb3QNCj4gbW9kZSFcbiIpOw0KPiArCQlpZiAoIXN0cmNtcChlbnZfZ2V0KCJib290
Y21kIiksDQo+IGVudl9nZXRfZGVmYXVsdCgiYm9vdGNtZCIpKSkNCj4gKwkJCWVudl9zZXQoImJv
b3RjbWQiLCAiZmFzdGJvb3QgMDsgYm9vdGZsb3cNCj4gc2NhbiAtbGI7Iik7DQo+ICsJCWJyZWFr
Ow0KPiDCoAlkZWZhdWx0Og0KPiDCoAkJYnJlYWs7DQo+IMKgCX0NCg0K
