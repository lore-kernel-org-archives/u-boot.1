Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18014CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863DA83957;
	Fri, 31 Oct 2025 11:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="DI82Todw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DB283885; Fri, 31 Oct 2025 10:07:14 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB6983642
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=hans.gfirtner@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBbg5yYSnlDT+3OXZymS0ywdv/O4cc+QDtbF1yconJPiYrUm+H9IxOONQBK37TJHToUwkXC5cI83RXyQ/l+5Gp36SzZLpGduMD+10nkXzSUV8cSMoJClrmUoTXYgH8GVpoAUUsb/TBIvACROGC3CZjzT7AWqwwI8UlsaiUWFO4XV+51I803i7zanGcGcIOciu37BHtT8SeQ/5OiJxWGIkvSnsSP+r/WBoPgFc2kLGslQGZwpZriPg1GncyDIDvdsDNABrafkG9NWOdcotu8g2hkzjNaEITC99V1yXFHko0ENjivfTlAUVcPMZV/ZPHkdYpGJZNSo2S5Pr2igwNivsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60uM/gN+ea5GLDAcrHmdcJPihOhNZlV4GNIdd13Zy8U=;
 b=U5PBQiHTHtKCymZ7vNalhGPN2T1RCByXjep5qlh8Ioy9kqsdoQ2sqO9WtQaK6XSmODraOZo7qP6+2H+AYTrFNKnOLZBKpRnbUq33Z+cJERANnYLE/TFmbGuHFrnmig3O4ge0zFVPGakQgS8k7WIcSpGdGtZW7ol5LmsJGFnfnRa6is4lfQkH5fLfCtB2CAWhVGFpTFkl6/L6FTeF9cNUvjSOY43hJSPlcM7Us3onmBuwiHqSPWkFRt8OSfo7Oht+CDx8qUY0Xkt6C+xgyCp61NZb+r6vLr+zksKfSGeImOiDWTt+d4trRuMQtyAE5bHlO7nPIvo1N0thiAin1cX4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60uM/gN+ea5GLDAcrHmdcJPihOhNZlV4GNIdd13Zy8U=;
 b=DI82TodwmPNEHEoegg4U5JWp0wSg80ZWBzb6BAaV9RfGVQl9pcchmZMmoLDXdVZTQp+KYM80ozkGgMgSAoiuSl2ZqJSZazrcI+soOVA/UfWM0nZEYSAZ7BxAhW0NRwJZ/ScxnFUbvVgFEnazpPTTHUKRzj5UOoprkQjWsR9oPdZn04L3R1gbhEfIBCyPA5DKF+xFo/KufEnl1JAcHTBCBU8gpFnHm87B5ZU+iczvlBeqRCirIvQ7SSj/NJUOtu16IkcWbtK+DywIYdPfUEy4YvAm0U/1/JRkPhN5e90xX1aAsKu02tWtEfH+uq/wrAOvzIWV+dIId7YdbM6VCrHjug==
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com (2603:10a6:20b:651::16)
 by AS5PR07MB10032.eurprd07.prod.outlook.com (2603:10a6:20b:651::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:07:10 +0000
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b]) by AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:07:10 +0000
From: "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: small Issue with u-boot/tools/key2dtsi.py
Thread-Topic: small Issue with u-boot/tools/key2dtsi.py
Thread-Index: AQHcSkW9u6VgAHkS70uYJk+xx/PWlw==
Date: Fri, 31 Oct 2025 09:07:10 +0000
Message-ID: <AS5PR07MB97996638E48C9C5BC79EDFF8FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
References: <AS5PR07MB9799CED5D37A580FD862C1B5FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
 <efd72055-b96d-40e5-beb5-e6af08664180@siemens.com>
 <AS5PR07MB979928242B521581C1C07153FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
In-Reply-To: <AS5PR07MB979928242B521581C1C07153FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR07MB9799:EE_|AS5PR07MB10032:EE_
x-ms-office365-filtering-correlation-id: 5bcabd48-0283-478e-cac7-08de185cdf9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bVJVcnBOeVFRV3NlNkdEbE1VZDROQSt0TkRGK25KYmtLYTRpQzVFWXdNaUZS?=
 =?utf-8?B?bWJEN1VEZHR5UjI2NWRpMXBrNElxSTNQeUhQcUlxZnJabmdGNUhOMGNLK1NL?=
 =?utf-8?B?Nk0yK0dCZ3BuQVdXSGFmZUxrdUtZOEY3ajhHSkUrcVVsVGFCRWVLbDVPYkFH?=
 =?utf-8?B?QUxFR3N6U2V2N2M4QmUxZk54NzAxQitYSkcxdjhpSjJ1SGFpS2ZwdGpzaGIr?=
 =?utf-8?B?NjJRZExBVkpUbDE3OU54d2tJdmJaZFljamNYLzNrNXFETnFMYmlBK21YU3NV?=
 =?utf-8?B?eUlLN1NQb2JNejVBc0VWTit6VGdjMVkvTE5HcjBJOWFubmUwcUtzWmNhZGh2?=
 =?utf-8?B?eVE1WDNHcEliV0dQMjE1WWVsY0daQUlYb3NaSDI3cVY5R2dpbXU2YXZhc1Zx?=
 =?utf-8?B?VTcwa2dRZE1mOVdFWXcvY1JXMkFIaVRZUjZKblp4VWFReUtHWlQ5dVF2NEQz?=
 =?utf-8?B?MXZaakxPS2RUQlgwa2J3a1A2RnQxclFLWFNZNFhFZzA2bk0ybzlhU1JiVE5m?=
 =?utf-8?B?T3paRG9sakVqRWpZYkZJbUJKYk9ROEpDVVUzdkZDaHpKM3FBaW5YOE5LaFNk?=
 =?utf-8?B?QXhjeW9zMnJZN3pUQ2xleVFoRWs3dGJCZEZ0OFpnYXYxalhLVEd0RDMxSlJp?=
 =?utf-8?B?akU5dzQzbEpuaXRWYUZBSG1ncU12aFlkeFJJakNRdXRhVHcvTyt1SkhVRUNF?=
 =?utf-8?B?SUNJVVM4U1hFb0tTd3lteC9QaG5ERHo1aFVEVmxneFh0OTltVDVwQTRjMFhU?=
 =?utf-8?B?cmN6bVNjOXFndU42YWZnVURySG9tTWx6TXltK0hEV1owdXZzYmRESkdSRC8w?=
 =?utf-8?B?aWxVTXhXeXZjVmhmZ3F6Z1hIYzY2Y3dpdzBQWnQ5WDdSV0N1eEEzMStMWTRW?=
 =?utf-8?B?MDdBVGZ2cE4rdFZIVjArNUREeEpoVHRJYUJLSGg4Mzk4UUUyb1BPSERlbHRz?=
 =?utf-8?B?MDk5M0VSeERrTjU2S1lSTGZsWGRNQkcxV0tTUnJrZ3dLaWpFTUdjY0t0RWNO?=
 =?utf-8?B?dFpRdW9BSXdGOEx0Y09QTUEzTkxqdklTYm5jcm5aNEJwZWJObTFWbXl4RDAz?=
 =?utf-8?B?K1czZ0I2bTZ5Q25DZG0valdxUTJwUHJHVlYyQWZDUDIrbUxtS3JVNHVVSVJL?=
 =?utf-8?B?SmxnOUR4M1lqR29zNHpzMmVtWXhGaTNqVVByN2RFaHdrb0JXK1hLcWZSaGRE?=
 =?utf-8?B?ODFqQWVyWUhSc1pJSCtZakIzeHhpQ0YzaEF1Y1REUFNoR002TDltM25EVnJE?=
 =?utf-8?B?cURObEdPaWtVKzJqOHVBRVpET2VmREdDT1BqTlFLR2VJN2s0cUZPdC9sa0x6?=
 =?utf-8?B?em1KdmYzMkFOMHdrMm8xd2Q2NW81YnpTZFJHV3QrUGdsQWxRN2pwdW14dHRq?=
 =?utf-8?B?YkdzdHhLUWpKVHA2QmVLdEkvMHpsYWVERXc0cjlKK1dTMXhiTnk0eUpwS2NP?=
 =?utf-8?B?MU9DN0t2QnhTRTJOVGxCTFd4eC9vZjdHTHFoTFd5WGorQ3FTNmFGVDIvRG1X?=
 =?utf-8?B?MVVwUm9mWFRsSlhVNHZYb0F1UHZoQ0hMYU8wcEVVZUJYUFRxVUFFTDI0TnNI?=
 =?utf-8?B?d0xycHBRUWx0eGV0TzgwSlFQWUZ1Q1JXTllhK09ta3dGMmFicWkwYTRZczZE?=
 =?utf-8?B?SGJsYUFxNkNab01qWjk2V0hXeGtidXFueVZDNVIwOTVRMzFJR3FPT0ZlK0dY?=
 =?utf-8?B?MFh0VW5sV0JrUm4xcTNtZnBJRW9reTdFTDlMdCtkYzZqbk41ZVVtSVpiRzRE?=
 =?utf-8?B?WEhTdG1PeUJtdEpuK201VmRQVkw5RS9PN1kzMnRIeVJBWXhsTkFQcW1ndUFl?=
 =?utf-8?B?aVhNY1JBUFVaaytzNzV6VXNuTGRydmtHUDB5Mm5HWXlWUGh3MFBoODQxVFA3?=
 =?utf-8?B?czJzeEJ0bCtBdkkxTGxwcVhqdk5TOG11NXF4TFU5by9sQU9vV2JCQWtmVmQ0?=
 =?utf-8?B?V0pxd2lUSE1ob3BleUlPTkpYdkVUek4zV1VmdFc2YlRUQTZSdjhXcVR5Zi9j?=
 =?utf-8?B?SUlOeU5hM3BJNUVyeFdxY21iQnhSVDlxTHF3YVBPYkNWTEZXUEcrSlJNOGxi?=
 =?utf-8?Q?JN+SY3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR07MB9799.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEQyTytpdlVVNUFvZDdrSS9zNkFvYUxYbTZCYTN3cGxLWXIxRGovSkRHVmdO?=
 =?utf-8?B?NUhMTEcwV0swRmVTKzFIV1d4bE1VdVpRYXBMbjZZVWJWMVA2WU84TE5DYi9q?=
 =?utf-8?B?aFZIU1VwOGFWdDJOeXpSdnpDTmFIRjc1aTFoYlpGU2d4eGdmd0Qvbmcvb0g5?=
 =?utf-8?B?UDVBcmM5U1U2NllVQ3Q3SUZ6bkRzU3cvL2JsMXJkSHd4RlB6eVpabXJ3UzNU?=
 =?utf-8?B?UE10ZnBTOWNUUGw3TWFZOXZDZVlOaVN1SmVmUkZ1ZzlLN3NRTGxQY3RJMEQy?=
 =?utf-8?B?Q3VURll5T1BseGQvc3FCNEhVK1djQlF6RndzMWloVnorbjl6c2REUUdmOVJ4?=
 =?utf-8?B?OWtabTRCMmRuRjNNR29TV1hRWGRPbHl3WHlwUVlnN0k4cUV1MzJQYzgxZW16?=
 =?utf-8?B?aS9ldCtIOW9BTkRLTVdGU1RyMjUyZ0lDd0R1NytjNlR2YjkvWWNXTmFkdi9t?=
 =?utf-8?B?RHpSbVlSTkQ1cVFpNmRVWmFySTlkOEMzNDZESWdRVjlrSVNJWFVvZll0Tmw1?=
 =?utf-8?B?MkxXT3docnp6QlB0N20zZ01GWmkwTzVEcGo5eTBNZm9XQzFGaHZidWZZQkxS?=
 =?utf-8?B?dE1UeWJuMXAzYlE1QjRab2JYamRjM1c0NDNpT2FhODh4eVU5dnh4Um9saDhy?=
 =?utf-8?B?MThzd1Q1SUdWZHN1R0I3YmROMnpWcFNhUndYcDIwRk92MWxEZlY2Sk5yWFZt?=
 =?utf-8?B?QTQ5US90ZHJEQWFEN05IdlZ5RXdDOGltTS90RERPYk44MXRLZVFYb056WlVS?=
 =?utf-8?B?WmY1bC9yaVNxSVVYK05wMmpYSmprM2t4U0tUM3JsblgzbU5KUXZuRDBKV2w0?=
 =?utf-8?B?bC9COWoxdXFIN1ovbU1zN2l2bmF0Sm9ib2dRc2RpWi9KSVRVWWtQRVEvNnlG?=
 =?utf-8?B?VzlGMVJRcDVYWXFHYTBzSkc4S2s1M251WGUySUFxaHBrNVkzTGd2MVlSOGpq?=
 =?utf-8?B?blRpdk9yYzZiWUNWeUJ3VjltQVg0WTFGNVprbmtTQ1ZBTkRQWEs3ZEdhM0FN?=
 =?utf-8?B?R2xxbWhIdjEvQ0ZKck5hTDZEMkFXMFAweGQ1Wm5UWU9HM2txRjFXNUxBTHZR?=
 =?utf-8?B?dEI0ZHNIUlpIZnM1UmRsVXdaa3lSRkJhaHJxbUVmQllDVGtqQWlIZWlwZ29S?=
 =?utf-8?B?M1IxcGJIOXhqNHpQZjFYSHdXcnZ6WHdpL09ycVBocUhRWnMwTGltSU40d2sr?=
 =?utf-8?B?UFdtNGRycndRZHQ0UzhNbElGdmo1N0xtaC9hTFZYU25LZkN4NHZzdEl1UFpM?=
 =?utf-8?B?b1NBeGlXL3RVdlpqejlKZ1ByaG9UTHpRRWNpNTJka3dhSnpwNnVGZHJrNHBk?=
 =?utf-8?B?YlpQMC9BNjdPRWpJMklyNGw3dFE0U2t2bWZCRXFaeWUrdHNGT1UwbndGaHYy?=
 =?utf-8?B?c3ZqRTJ4aHJBNXpCdmN3SjRIeENDdzZ6bEEzK3RzeEw5VjUwcjF2TEhPOG5J?=
 =?utf-8?B?NmhlMlNua011VUc2NStFODVYUlhldndEUll6eVpVZ0J2Z1VCV3g1Z21XWWtq?=
 =?utf-8?B?c0x6UzVhTitRUUZVUUhxZGRNcWxMWU1pU2dkSHpmZEdYVDBTaUhQQmNZeVpk?=
 =?utf-8?B?bUFSK2FlRks5MkNkbk9TZEdIa2RZRVFrYUgya3kzMWU4N1pZTnVXU1VzeDNJ?=
 =?utf-8?B?aXFSRmNVNTc5dDhWc1orVkZaVGRjQ1NOMExtYkEyYWxYRm5YQjA2TmdrZWJr?=
 =?utf-8?B?dW5OR2VZWG4xd1RDa2hRSXB5UU1UZGVnd0lyK1NxSi91QW9Bd011c2gwY0xF?=
 =?utf-8?B?dXBlcHkzS200RklMbm5ObU9XZmFRM21kNHpzckZNZ3d3cS85WnQ4SGZ1ekJ3?=
 =?utf-8?B?MGhYQ2NEZHMxTmdiV2RzeHFZNkFTSXAvZDV4Z1Q2N0ZwT2ZWL2VCemFSZDkz?=
 =?utf-8?B?S0xZVUZ1K2E1c3ErL2ttTHZzb3BRUkVMVlh6K1dLdXhlY1dmMkRZRFl3OEVK?=
 =?utf-8?B?YmQybzJJUEhFU3ZUMzRUSjZFR2hPMFJ3M0N1MTUxYkZjVUs2Sm9TcHZVM3Vs?=
 =?utf-8?B?U2lpclQxNGhncnh0NGpSVVZNZkp6ZjlwRlNIeUYwSlY5T09wTzd5N3JQNGZQ?=
 =?utf-8?B?dFYwcGR5djFWbW5PMlkxdURQaGJDUnVhUHVYV3Y4eHNkSjBEbnRwYzRHTnlq?=
 =?utf-8?Q?w8tnxYWAJy9TJ4B2khCuzgNAI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR07MB9799.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcabd48-0283-478e-cac7-08de185cdf9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 09:07:10.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YNINfWpZudOVnfEbMWuq0NUjjf1KqVLXwYdy+ipZ7+rxNjEUSuSwCzVHYmjsAZ9RBYvZX9EbXydMdnAcBYnbfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10032
X-Mailman-Approved-At: Fri, 31 Oct 2025 11:57:12 +0100
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

SGkgamFuLCBhbGwNCg0KSSBleHBlcmllbmNlZCBhbiBpc3N1ZSB3aXRoIHNvbWUgcHVibGljIGtl
eXMgKHByb2JhYmlsaXR5IH4wLDUlKSB1LWJvb3QgZmFpbHMgdG8gbG9hZCBzZWN1cmUga2VybmVs
IGltYWdlOg0KDQpUaGVyZSBpcyBhIHNtYWxsIGZsYXcgaW4gdGhlIHNjcmlwdCwgaW1hZ2luZSB5
b3UgY2FsY3VsYXRlZCBhIOKAnHJzYSwgci1zcXVhcmVk4oCdIHZhbHVlIHdpdGggbGVhZGluZyB6
ZXJvLCB0aGVuIHRoaXMgc2NyaXB0IG91dHB1dHMganVzdCAyNTUgdmFsdWVzIGZvciBpdCwgd2l0
aG91dCB0aGUgbGVhZGluZyAwMC4NCkkgdGVzdGVkIHRoaXMgd2l0aCBhIHNjcmlwdCBnZW5lcmF0
aW5nIGh1bmRyZWRzIG9mIGtleXMgYW5kIG9ic2VydmVkIHRoaXMgZXJyb3Igd2l0aCBhcHByb3hp
bWF0ZWx5IDAuNSUgY2hhbmNlIChtYXRjaGluZyB0byB0aGUgcHJvYmFiaWxpdHkgb2YgaGF2aW5n
IDAwIGluIGZpcnN0IHBsYWNlKS4NCkkgZml4ZWQgdGhpcyBsb2NhbGx5IGluIG91ciB1LWJvb3Qg
YnkgYWRkaW5nICIsIDI1NiIgdG8gbWFrZSBzdXJlIGxlYWRpbmcgemVyb3Mgd2lsbCBhbHNvIGJl
IGdlbmVyYXRlZDoNCg0Kb3V0LndyaXRlKCdcdFx0XHRyc2Esci1zcXVhcmVkID0gW3t9XTtcbicu
Zm9ybWF0KGludF90b19ieXRlc3RyKHJfc3F1YXJlZCwgMjU2KSkpDQoNCkFuIGV4YW1wbGUgZm9y
IGEgcHJvYmxlbWF0aWMgcHVibGljIGtleSAoZ2VuZXJhdGVkIHdpdGggb3BlbnNzbCkgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSB3b3VsZCBiZToNCi0tLS0tQkVHSU4gUFVCTElDIEtFWS0tLS0tDQpN
SUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTVGZVpLcUJQcm5HdzNQ
Z3ZmSjdhDQphakZVTXQ5NE1JQnNXNW1vdmhqS2ZkQ3FISnQwb1MvYlFXQWVPRXpXN2VhQVU5Um5R
ZXY4dWQrV2d5VnVLeXJ6DQpBYVVaNmdwUUM0Vi9MbDNaMWswNkpYR0luQ3hUVmFPUWgvQTNmQ2du
dHFRbXlvdEs2VWVFL1hlOXV2UTdPbHc3DQpuK2QxbnlHV1dUcld0NXdxUTJIUkN5aUR0RDlrU01Z
b005cktsVTMwMW9KT0NCS1psdkhKeit6UDNqTno1MlpCDQpTRmUzZGFhWW1iSUd6NG1EVGlnSmpH
RWgyQkE4TStyVCsvSmtBVXFVQkMwN3dDK0RzdU5wci9BOFFTVFdzMUxrDQpZd3BVdXpUYURpai9V
TjFnSi9YdzJOTUVrUU1BYno2RjRVNFRiQmV6Ni96RGE1MmkvTG1SbjRBMW54eTdhZ1k4DQprd0lE
QVFBQg0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tDQoNCkJSDQpIYW5zDQoNCg==
