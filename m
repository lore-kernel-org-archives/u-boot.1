Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C3BC3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 09:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB808839A;
	Sun, 14 Jul 2024 11:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Vl/g94ER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E8F88418; Sun, 14 Jul 2024 11:23:53 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F95883C3
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 11:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkPFiswhQ8w+0YkUtgjjmK8lY1PTTkeLdkoaHi8dVaWN6PnN6kmH85SSwkjR5vvgckGYBM0p8nL0lgJ74FDFLRqGTahEwfYAOUTp+egblVE2sldMo6fdsgnnmzwTVqAiPt8RSH+Pl5V6+C5Y9svdbIBfyFWUx4f3gK/62jSIGX9cjxHf3aZ5bpeQ94Po6cZbrljPwINZtY62Ypa/yAxslTRycj4jiMufKLM1TRvh9+daP/EQLIPOxb866F2hkRM4vj8757ir2HEilcUR2/G0Vgfwq0tq+6gkd2dLf52QQYpEkPCOXEsRCkGb62b6PtSuxO6jxqmHcnu71jePICegDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe3l2NA5fkwN6wS4DbRcdJIX8QDWmLl5Ix/tjotQo3g=;
 b=C6lr8O3pdsK9yeUNfN9bgGqHiNBAXkcPcPULbPakZRbSRZ5mMr1rxVF+MaTZNyEWBiIKCP/gFuiB+8Q5ZjcRaBwVQ3KE1W8/11jPAVW2lNJdsH+HHPjMMJscHokQCFeXCn8QsZU+B3TTz+cWuwqVp8rPRHyCxCBcVDeotEh2h0LwWEkM6klnYRg5WpkGftK6OI5T6+xK/Oi5G3V5Q03kgdmmmR2Tjgc83EznWv4fNUqD6WItuj1IXBHm/ve8VYv9QikuM/jlXFecfK4eq3DAtd0lX0pjbokHfY3XTwffHsQun4ljbvqnBeWpZE5bEnr840BtIvbGI1hewMg5P5GMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe3l2NA5fkwN6wS4DbRcdJIX8QDWmLl5Ix/tjotQo3g=;
 b=Vl/g94ERpbQD8/IVHNVhSDkzeNyY2bu7/DlukNJDNmDX+PFWPNqhD0ER32jOwnNgmOyk6KkjrkP1gOlXCnuDbLGmNS01qCW0fZK6dbByFh99DxkYdmye2a7uetiRJuKIPbFTGSuma2BTv8hII0QfWGmK+vOByEZdz+T7Y72+yvc=
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13)
 by DB9PR04MB9497.eurprd04.prod.outlook.com (2603:10a6:10:373::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Sun, 14 Jul
 2024 09:23:49 +0000
Received: from AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f]) by AM7PR04MB6968.eurprd04.prod.outlook.com
 ([fe80::31a7:17e5:a4e8:ef5f%6]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 09:23:49 +0000
From: Elena Popa <elena.popa@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>
Subject: RE: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Topic: [EXT] Re: [RFC] usb: xhci: Some USB devices fail to initialize
Thread-Index: AdqwWVW3P9w5ugCBRoKUpk8i6qFE+AADGHsAABx7kSAAmuvoAAA6tSAQBvZ3SwABcZJlkA==
Date: Sun, 14 Jul 2024 09:23:49 +0000
Message-ID: <AM7PR04MB6968C4EFE4B8BF3B523E0A0A90A02@AM7PR04MB6968.eurprd04.prod.outlook.com>
References: <AM7PR04MB69685A41537BA13AB3D32C7590F02@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <a00e3b3f-2248-48a6-ba48-544ac09f2dc1@denx.de>
 <AM7PR04MB6968BB208B38C3DA9F11B9D890F12@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <9ef2b0f0-13b7-4caf-8f99-7803dffc2afb@denx.de>
 <AM7PR04MB6968EB78F957243D25BDD80890FD2@AM7PR04MB6968.eurprd04.prod.outlook.com>
 <e534b055-eb45-47e1-94d4-6e840a4e7d20@denx.de>
In-Reply-To: <e534b055-eb45-47e1-94d4-6e840a4e7d20@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6968:EE_|DB9PR04MB9497:EE_
x-ms-office365-filtering-correlation-id: 3b6ad0ce-8a67-4590-33af-08dca3e6ab75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z01aQ1Z5OXdFSHhrTHhmUmNueW5VbEl1NEZ0ZE5iVTZyNEdhZDBoNEZZeStV?=
 =?utf-8?B?ZlQvVmlWVythb3BUblpkRTNSQVltVHFYSU5yRFp4eE5xc05PRTZPWWlzV0l0?=
 =?utf-8?B?ZlIwa1d2bHhGUTM3SXdBQlBrN3U1NURYcWRXVXV5RE5UKzVyN1g4bDJHR25x?=
 =?utf-8?B?VzI3a2puYnczUTdoRVZXRFF3czNwT01pd2JkYWhNSC9Pb0UrUnFtREpYbDA1?=
 =?utf-8?B?Z0haaXo0bThlR3RteHVHa2ptZVdPN2MvVC9jWURJRmM2YmxhUGZCY0FrZFpt?=
 =?utf-8?B?djlXV1ZBVzNXeGhXNENPWHVKdEI3NVUxeVdvT0YvUFRyeTdmaGFCTXJqcHQ4?=
 =?utf-8?B?RldIN3B5Uy9iVlVuQ2RNbzY2R3l1T3JEWG9HNjNaajMyVjAxMjRickJQQnJZ?=
 =?utf-8?B?Y2YvQ2dqNFpRMGh4UzJJeWVZMjVwVGM4bDBxclRhaG05UHBmRkJZcW9WRXlT?=
 =?utf-8?B?UzRNajZiZDBCQzhaTzlFNlEvMzBlci90QjJOay92dzl1MTZWTVRKUzkxQUtH?=
 =?utf-8?B?aEhkZlNkeG91cjJUSGFnR1dBRkNic0VvRkVJdTFpU2lHZXpDbDBXbVJ5UjY2?=
 =?utf-8?B?cjdKT1VqRlJPTjFRU1J0SkJUN0NGV01xZGdRN1ZxNVduaThFdGZ1Qlhqb3Vk?=
 =?utf-8?B?NDkyK0ZDQWxLSUpKeWs0b0M0MTM4ekk3OVFCZS9ORWp6bUpFRUlLdFRZRmNP?=
 =?utf-8?B?L2tvZDhNUjg4V0xabU43Y3ZUa1FuNmhTNXJGd0V4cUI0VzBEWDBqdFdDZzF4?=
 =?utf-8?B?NGtNRXlHN2lZZ29JaDZXTCsyakZYVTJQa2RxUmNlVVZzV1kraWliOFNzaWFW?=
 =?utf-8?B?NjhOdVZwcjBlUDJTNzRqajFqVTdMbkgzU3FuNFA3TUJsV1k0UHM5UTVYaVdo?=
 =?utf-8?B?b2tjWlZxamcxa25td3hRbnJsd3hvU2pYbWNPWTJMbjBnWE52L3dNbmlmdFU0?=
 =?utf-8?B?NlNCWVdSYXFVell2dTBsWUdnT3RsUW0wWG16Y0U2dUNiTzVBbUd3V09ieGF6?=
 =?utf-8?B?dWNYNG05U1VUaHcxVUhWN3RjQVBRaU0ydTdkbC9oTVVjNEdFMnU3SW4yRWo3?=
 =?utf-8?B?NlBWREFIaEhpSXBwYkdGRjZoUDJTVitnRU9kRGJyMlJVWjhuYnRMNXE5TUZl?=
 =?utf-8?B?dHFvMVJJRGE4bTM2Sk1qWnhvbmZiYSszdzNJT3hISzZlTXlMZ3R6dzRpR1BJ?=
 =?utf-8?B?cHBiQVppUU9zSzkrVEFuR1ljSmpGZ1FibU9Sc1dvN255emZJSmw0SFVKMDdk?=
 =?utf-8?B?K1oycW45QVptb1NVODh3bXZtampSRmUrdUtMa2ZzRVNqNHR2MWJadFpUQm9G?=
 =?utf-8?B?N0lvWjBKMmZZY0N5THhQUVZqdk9icmpUOVNVd2IrODNGS3UyYmdaa0JhWFl4?=
 =?utf-8?B?ZU8rcVQ0SHF0YTJ3bXRsY290cjNRT0tVQXRKeUFRekVaL2ZpeW5HQmkvWlVV?=
 =?utf-8?B?RFAvTkNWalVZc0JEN3JEeDBtSEtsU054VkI5YnhVd2xOaXlXZ1JhQXNCdUhF?=
 =?utf-8?B?VDBjQkMxYWNBSkZaTEoxNWF4Qld5b3VTYy9saVFWL1E4V3VEYml0dGJhdXpR?=
 =?utf-8?B?WEpTTDZLeXFGWEYwVXJkYXZnRmpiZmFpK0lzVWdUditlWkNOdmFRTkZyWjBS?=
 =?utf-8?B?elNCV3lwKzdiL09KMWlsZTBrd2N5V2ZxUTBVczBKaXVXNXBsaVJZL3kreUM5?=
 =?utf-8?B?R3NNbEd5S2RRbHUwTnMyOWczdTk0eXpyWXZXZ3N0R0dPNDN0ZTVtOE1DUmpU?=
 =?utf-8?B?b2QrQlhydVVzdjJKZFNWckhaazFCR3A4NjVZRnlHM0E2KzNFSFdvaExRaXBy?=
 =?utf-8?B?dEkyL2NQVnRHMzBHdHR3VTBKaFp3NXI2UUk4OFprRG5vVyticWE5MFJrZWJJ?=
 =?utf-8?B?TEJmV1ZoVzFVaEpBVC9wZ0FjWGRoeGZlSDNNaEtzVkxIOVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6968.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE4zV2FjYnBJRXhkN01HTUFWbE44ZTV4WTU5V01UcGpwd0RSU1JWLyt5SGpl?=
 =?utf-8?B?ZUtBVVliVU9kZUpZL2dkSDlZQVZWTmZSVnlOL2hGdlRqUGZyN1daN014QXYy?=
 =?utf-8?B?RnFHYm56ME41Z0Z2eVBLY3dMMS9IRnA1dDd1UGFudnNlc2ZQajR5N2VHY0NJ?=
 =?utf-8?B?V2E0OW5Hb215NVhVZlF5VjdNQTFFK3RQMTlTcE4ydnhTdXlEU0F5Y0RLbFgy?=
 =?utf-8?B?bWxaRVNoOC9ETzBGdzhGWm5Xd1hIc1Q1RUlidjEvUmViUFk0MENiT2Npa0tN?=
 =?utf-8?B?SDk2VEhNNHAwNTR1cGFqcmNYMzc5ZUsxOEhJdG9JMWVoTTFNSnJxSEcxSFo4?=
 =?utf-8?B?UEhXTWtlMjRaOFVENjB3MGdRWHdURDNZSUlLdWtuRzQ2cjU1ZVFjMFpraitG?=
 =?utf-8?B?bXNEUE4rdlBvbWVOTmpXRGJZRTRoNjUyWkQybW91VFZIdC91KzkrRlFpKzN0?=
 =?utf-8?B?bm1wMGdBS3dHUHRCdXVIeWl6cVc1bkRJZ0w4UmJEeDN6dFgwTm80c0ZWM09h?=
 =?utf-8?B?YjQ5VDV2M1pDeHhyWHdPU2x6eGRvblg4UE1RNTduZTZWeFl5bXZudTYyRVp1?=
 =?utf-8?B?SXZ1c2JudmY2TnpqZW5VbmFwQ0ZFT051eUJNMDBtcldUWkJIeXk1OGhtSzNC?=
 =?utf-8?B?ZXR4T2I0d2QxdE0xdGJhTEFoUHVaSm1oSmk0RkJHaUYwQ01kOXB5TUFrZDhx?=
 =?utf-8?B?dTRYYXBoRXNRQXVIMEFzNTB5dGJ5N1N4U2VVUklBbDJ4cmhRS2lUOVdCR2d3?=
 =?utf-8?B?bzQrRzRyazgvaENLMDdVd0FhU0NlcmQ5cU1rMkVMR0QrQ3poaTFxMVQwWDY3?=
 =?utf-8?B?dDcrU3dLVmFxYkl4UG5PMWg4UjRhYjFzVWY4akxCeHRWcWQvQUczZzdYbXFK?=
 =?utf-8?B?QzRTYk1UdW1xd0tiRVJ3dlZXcFFCZ1hjMHlac1lCME1rakZUelI3QkcrSnk1?=
 =?utf-8?B?em9tRGV6Tml4ZHV0QUFhdS9YWUFWemdBbFNMZWIwT08zOHNwSzliRjlOVEFI?=
 =?utf-8?B?eWE2OTVUdXhCY0VjU25oRmF5ZHV2UGJrYVZlbjg2L2xxd1IxTUFvd2NiVmVY?=
 =?utf-8?B?QmIyRkZXK0YwSHhNcWFhVzcvL1QxU3hZQ2NsWDdlN29kZmdyY3hycXlOcG5E?=
 =?utf-8?B?aG1saTBhN0pxZmFMTnZhUFFHY1Z6ZFIyNXhaK1BsZ1I1NmlQZE9ZV2dGRlpC?=
 =?utf-8?B?RXg4NjNuVjIxbC9OOWVsU1Y4ZURCdDI0T1BtbzFkZU14UWZtTk9FcHNEZ2Nj?=
 =?utf-8?B?RzNDY3hvZHROVlBDdzdNMlpnQURXWExqUEN5SWM1di9PZGQvZlFkSkdodC81?=
 =?utf-8?B?cHdDNFFheEFMaGZ3cE5lMGp5eElBekt6SjdYcGNWY2F0ZXdjMG5vT0h3VG1R?=
 =?utf-8?B?L3huZVFZZVptaGFwQnNieW5BMERLTHhIdW90U1plNm5lV05DdkhQeTd5a2V4?=
 =?utf-8?B?TUZmaXRXRzJhSHpNdFlPd2lROTc2eHpXaWpWQmZqaTA4djN0eU1SMWphVVVS?=
 =?utf-8?B?dGFyK0pjRFJ2TDZhQm1KWTVRWXZYMldlVXd0Q2tURFlRdk1pV1orVlhPcFdU?=
 =?utf-8?B?SjBKcC9jUzNHTkhPMkQwSzkzMTNZdHlaS0UvanMzVmFPdkJKbmVvRTVhZmh2?=
 =?utf-8?B?Qk9FYk1vd08zeFJlOUxBY2xJL001VmNQRHIyRFgyOGdnSXY0YUF1TE9FZWxh?=
 =?utf-8?B?MVk4Rzg5YzBpb1lGbXc0VkhUMkh2YUhQNitLNUNDeWJUendEWk1EdjVZS001?=
 =?utf-8?B?Rkd5aU5PZkFpWFhoODBSOTJkTEhLVXp0Szl3dFJhN1ovVUxWUnFvbGxuYTRj?=
 =?utf-8?B?TEVTMHEwOUtPMjB4YzlKUzhkbkE4Ym5KcmN4SitqNG96bDFMa1NFeVh6NWJL?=
 =?utf-8?B?MDl0NlhFMXJncXl1NlFNUkw1eXZrSk5aWkcvZkdUUVpXSW1YUTJFb1Q0aW5Y?=
 =?utf-8?B?SGVEVFl1b1E2bE9saG54Y2lDQ203ZWo3QlpBNHA0VjlNZld4VXRXaEJXSWNY?=
 =?utf-8?B?NUlSMm9YZmpIMnA4c2ZadHhzamlPRENHdE93TmI4Y0RUSkRNbHQ0cTVsUHJL?=
 =?utf-8?B?emlLeVBpVG1Rb2Zpa2lHNUxXWitubGw4RmlSalFpc0c1Y3d1VXd1SGl0WUZl?=
 =?utf-8?Q?ql6Lrt3r818Lpdtb2lnm9/+fq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6968.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ad0ce-8a67-4590-33af-08dca3e6ab75
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2024 09:23:49.3644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ysQpIJ8ngJ6Nfi+DivN1KyR/vLhgBbQh5tdXc4UpWvPON8Me9SLTuJDDyp5nd3zjSsDZ5aGBSk1Qkmj6ASi3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9497
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

PiA+IEhpIE1hcmVrLA0KPiANCj4gSGksDQo+IA0KPiBzb3JyeSBmb3IgdGhlIHJlYWxseSBsYXRl
IHJlcGx5Lg0KPiANCj4gPj4gRG9lcyBpdCBhbHNvIHdvcmsgaWYgeW91ICdzZXRlbnYgdXNiX3Bn
b29kX2RlbGF5IDIwMDAnID8NCj4gPj4NCj4gPiBObywgdGhlIFVTQiBzdGljayBpcyBzdGlsbCBu
b3QgaW5pdGlhbGl6ZWQuDQo+ID4NCj4gPj4gQ2FuIHlvdSBpbmNsdWRlIHRoZSA1bXMgcGF0Y2gg
Pw0KPiA+DQo+ID4gSSd2ZSBhdHRhY2hlZCB0aGUgcGF0Y2ggd2hpY2ggbWFrZXMgaXQgd29yay4g
T2YgY291cnNlLCBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcw0KPiB0aGUgY29ycmVjdCB3YXkgdG8g
Zml4IHRoZSBwcm9ibGVtLiBZb3UgY2FuIGFwcGx5IHRoZSBwYXRjaCBvbiB0aGUgbWFzdGVyDQo+
IGJyYW5jaC4NCj4gDQo+IERvZXMgdGhpcyBkZWxheSBoYXZlIHRvIGJlIGFkZGVkIHRvIGV2ZXJ5
IGNvbnRyb2wgbWVzc2FnZSAodW5saWtlbHkpIG9yIHRvDQo+IHNvbWUgc3BlY2lmaWMgY29udHJv
bCBtZXNzYWdlIChsaWtlbHkpID8NCg0KVGhlIGRlbGF5IGlzIG5lY2Vzc2FyeSwgYXQgbGVhc3Qg
Zm9yIHRoZSByZXF1ZXN0cyBvZiB0eXBlOiANCi0gVVNCX1JFUV9HRVRfU1RBVFVTIChmb3IgdGhl
IGNvbW11bmljYXRpb24gd2l0aCB0aGUgcm9vdCkNCi0gVVNCX1JFUV9HRVRfREVTQ1JJUFRPUiAo
Zm9yIHRoZSBjb21tdW5pY2F0aW9uIHdpdGggdGhlIGRldmljZSkNCg0KSSBhZGRlZCB0aGUgZGVs
YXkgb25lIGJ5IG9uZSB0byBlYWNoIG1lc3NhZ2UgdHlwZSBhbmQgd2l0aG91dCB0aGUgZGVsYXkg
Zm9yIHRoZXNlIHR3bywgaXQgZmFpbHMgYXMgSSBkZXNjcmliZWQuIEkgY3JlYXRlZCB0aGUgcGF0
Y2ggd2hpY2ggYWRkcyBkZWxheSBmb3IgYWxsIHRoZSBtZXNzYWdlcyBzaW5jZSBpdHMgc2ltcGxl
ciBhbmQgaXQgZG9lc27igJl0IHNlZW0gdG8gYWZmZWN0IHRoZSBwZXJmb3JtYW5jZS4gDQoNCj4g
DQo+IENvdWxkIHlvdSB0cnkgYW5kIHVzZSB0aGUgZGVidWcoKSBzdGF0ZW1lbnQgaW4geGhjaV9z
dWJtaXRfY29udHJvbF9tc2coKSAsDQo+IGFzIHdlbGwgYXMgbW92ZSB0aGUgbWRlbGF5KDUpIHRo
ZXJlICwgdG8gZmluZCBvdXQgd2hpY2ggZXhhY3QgY29udHJvbCBtZXNzYWdlDQo+IHJlcXVpcmVz
IHRoaXMgZXh0cmEgZGVsYXkgPyBJIGFsc28gc3VzcGVjdCB0aGlzIG1heSBub3QgcmVhbGx5IGJl
IHJlbGF0ZWQgdG8gYQ0KPiBzcGVjaWZpYyBjb250cm9sIG1lc3NhZ2UsIGJ1dCBpbnN0ZWFkIHNv
bWUgZWFybHkgcGFydCBvZiBpbml0aWFsaXphdGlvbiAuDQo=
