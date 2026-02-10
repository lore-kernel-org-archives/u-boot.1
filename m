Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29024EA811B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 14:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D50A83CBD;
	Tue, 10 Feb 2026 15:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NOVATECHWEB.onmicrosoft.com header.i=@NOVATECHWEB.onmicrosoft.com header.b="XiWIGvRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FDE83CE3; Tue, 10 Feb 2026 15:02:10 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B787183CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 15:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=novatechautomation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.schikschneit@novatechautomation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGAAXA+xgURSICFmf6SOh+FOngPAOnW5ravfCbBHLkhDaBBJrhMoYZ3Bbd8HxIU5/PBO0giLFCloTRkalacqWEwnUnHhcGY9A3pEYoAA1/c8moFYa0pAC6twM6t0Y22cbUbh4i4WsUrwJd3+IaFwfa+AFeFxc/KcRX50NhZE1zm6zmwC3dFbf4Kn1a8VS4lx+REkJyzEj1U75zegwb5Adt4UA/TPvXW02pGlI1RdwVDv4rlEzovkFAnbBrFawBESit/pYnGc3cqU12LXaZHlnrEIlgrPmOk63B9/C0egy9epFDGujs0isXmls/ZBY4JBs7CyII2dzBOb0/pHrauXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJR/cgyseLKZ8en5b6v90hR5lEdo/6JVG5ZOHRu5xQc=;
 b=gcDv27dLQ1I5isbvGZbcZ4dbx/T7pfuWUIykdBiJ4BtMWTrnuSg7hclPX6ww+8zfnax25ssxbBGHEsFQQNh2kCYhH1eiAPHdA2D6tLki2onbv8Y6jK+tRm9O6ybjcEQPmd0iVaUcJRG8wHdezZZ/Jdx1knqMdSJ9fYsL1uCJwN+UNTkj2MPNK2FtbZLNZub81rkBIjJBehZZD0I/4B6I4hPIrqfJN7iJmY8hIw5p+RutTzROhPB1a9bXgxbQEZeujSnOmWhn17RhenU/iJjcrwitbxQn3+thK08i5hVqu23zo37hPrdhe1P//cshLwUU5lDUSZa3ywMvbDrjdPST6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=novatechautomation.com; dmarc=pass action=none
 header.from=novatechautomation.com; dkim=pass
 header.d=novatechautomation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NOVATECHWEB.onmicrosoft.com; s=selector2-NOVATECHWEB-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJR/cgyseLKZ8en5b6v90hR5lEdo/6JVG5ZOHRu5xQc=;
 b=XiWIGvRBUG5YEQBWRwaTsXKJEgdJn9AJ909cVEhYHuviDRhF4Qxswfz0lrmyTRd9On1Tg/DWA8eb+rLdlVxd7n5OyJ7nK/xcyhfN+ermSAEFVyZWU5Z7ed2QKBi3VBEgjpV/IBIlznjsFZ7qgYOt/KvbOAMsWEj1xnqq1ogyYjs=
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com (2603:10b6:a03:4fa::13)
 by LV4PR07MB11555.namprd07.prod.outlook.com (2603:10b6:408:2e4::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 14:01:59 +0000
Received: from SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1]) by SJ2PR07MB9711.namprd07.prod.outlook.com
 ([fe80::12bb:dffa:2e93:aad1%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:01:58 +0000
From: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "bmeng.cn@gmail.com"
 <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] Fix x86 baytrail boot flow.
Thread-Topic: [PATCH 1/2] Fix x86 baytrail boot flow.
Thread-Index: AQHb9QKzESoclQlNu0K5R6uJ5gnFbLVyhFyAgAA5rYCACn0LJQ==
Date: Tue, 10 Feb 2026 14:01:58 +0000
Message-ID: <SJ2PR07MB971124EAFA0B19D31E83D3E18162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20260203180159.GP2603314@bill-the-cat>
 <CAFLszTi3dFNi0e4C3mSJAMJyh_+Ev1+NmhTtyAXXnHG0MK9e_Q@mail.gmail.com>
In-Reply-To: <CAFLszTi3dFNi0e4C3mSJAMJyh_+Ev1+NmhTtyAXXnHG0MK9e_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=novatechautomation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR07MB9711:EE_|LV4PR07MB11555:EE_
x-ms-office365-filtering-correlation-id: 4d2c3db2-b9bf-4da7-b97a-08de68acf4c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VlNIOFgrRnJ4OTNHTnBhV0RSQVFuKzIzSTZ1N29EUUR4aXJrcWxJUUZXa2VO?=
 =?utf-8?B?THl6RDFMMW00R1FuQnNjeEdaMDJNaURDRGpCMnlwM1BULzhhR3FZNlJqcGRM?=
 =?utf-8?B?ZEVkNmQ5dHA5Z1ZqRWk1ZUlTSEdNTTl6NTNCR0ExOE9vbXI4TWFRTjJ3VnMv?=
 =?utf-8?B?blZWTm9XbWE0c1RDOE15UHRtSitZOGZHUVFNdXVCcExGbWtUcXBnd002Q1dY?=
 =?utf-8?B?MjBqU2Z0Q2h4bDJuODl3MXY0VHczUVdzaUdsT0hXRHUySHltMncxVGVkV2JT?=
 =?utf-8?B?cVhqOUozejBXSjg5M0FGTzFZa3prNU0rSXdpUVRidXF4SkVuY2ZRWTh2ZnZh?=
 =?utf-8?B?NHNuNGlWTzFlWkpNTlVKaEJKQ0hKa2ZrNlp1YjJkS1ErR3Z4Wk81YWZRWlVk?=
 =?utf-8?B?U1g5RndWcXJsUE5hL1hXNlpEQmlxZTlyZW8yQTEreDBJZVJuTzFZSXNJL1Fs?=
 =?utf-8?B?d1RTeE5TbW9xYi9aWVIrQjVKUnFINk9QRkdXOGUyb3Mza3M3b3Vwc3hpYjd0?=
 =?utf-8?B?K08wZ1hMRXNsU2VwU05JR3B5N2lZeVFwSTFyVk1laERqQnQ1WmRWWFduRmhh?=
 =?utf-8?B?bEFHL0ViSHdKSlU5M2QvU0RRcDh3YmVTUlYrUmJTYnFRaG9MREIvOFkybUZ5?=
 =?utf-8?B?QXpCaERIcE02SUtnTnp5c21uY0pNeld2TVFuWWFENDJNQTNBNlN1WUVTajln?=
 =?utf-8?B?L2lXNkNMSklPREM3MUpRcmgrcGZLODM0b2gzcmE0dGhyMXFpNVRmd1dTaHA3?=
 =?utf-8?B?cE54dWZnNTZvMW1zY0JNeExWa2JOVzhGdnR3M2JvOTJMR2NJb21NSndyOWJ3?=
 =?utf-8?B?VGpzWXlra3RUaHlVUG5oQ2wxbmErSXIzU1N5Q2J3OWJUNzMxakZSaVVBdmd6?=
 =?utf-8?B?UG1oK2h4dlQwSlU0R1lhRkhWM0gxc21GSTlSMkJzR0lxUFQzR3lZTGllMmpC?=
 =?utf-8?B?MkZkQ21nYXdHclJwc0FTQXpyOU9YYVpwcXhjYVI1ZXAxSzdNK3phWUltTmhE?=
 =?utf-8?B?MkhIZ2hQWGRTM2lHUHJlcWNvZTF4SDZiLytFL29qb0oyU29WV1U4QWcrTCtL?=
 =?utf-8?B?YStNM3kvbDlvWkl2QnVNWENCTWVpb3BFU2E3cGN5LzFUcm1tUWErTDhMZXRF?=
 =?utf-8?B?Q3lwcWV0c1VtbnZpVVJ4MzNaNW5qaU1yV0U2QStiN3BRYytaOGs0MUd0TTFs?=
 =?utf-8?B?Z1kyTjE0UVBwY2pacmdtOXg0V2trcVR4VWVCU1JtNDRXblp3bnVqTmZKcVBh?=
 =?utf-8?B?ZlA1dlZBTzREYmNuTkg4Q0FreGdhdHhhRlhJMW1pVXFoeVpRanF6RENMTkQw?=
 =?utf-8?B?QUJTczFodGszMy84cUJxS3RzamJhK0dmM2VuNy85aTJ4Q3RnQnQzNG4rTUho?=
 =?utf-8?B?aVJMcm1VeURaeFZISHFnNGRVci9Sd2NZK05PaGt5elplRTVVVWwwNmNvVW1E?=
 =?utf-8?B?Vit0Rjk5ZGpxekgxYURXbjV4TGFsQng3SWErcGNRSG1rK1h5bVg3WXIzQ1Rp?=
 =?utf-8?B?aXovaXZqdXV1U3Q1YkgyMDhCSnZ4cVVYbnQxZ2dVdDdxVnZZS3N3eEt0SzlG?=
 =?utf-8?B?d203bEplUGJvL3Y0by81QVpPK1FTZllIV0U3SkNPMndtM2J6blJxdDNldk9a?=
 =?utf-8?B?MHJjZGhmd0kwSm5nbWtrak9EdTBtckYrNVRONDcrcHlCNEJYdlVKVHg5QjZZ?=
 =?utf-8?B?Y28zdFNYMU8zYnZBSEpkL1FTNDltNFRDVGVlQnc3RDViMUhjS290bDhJNEpa?=
 =?utf-8?B?QisrKzBBOXJoa0NnT2lmMjVSWVUzb2VvQXR0c3htZUNzY1ROMGZweFc0YUVD?=
 =?utf-8?B?QlJQc3JmVUM2dmU4RGY4MWY4Y00yZXZ4amlhL09iMHlEOERaK2VjeUJyM0JY?=
 =?utf-8?B?OEVvQnlZMFVuenZyazF5MWNhb1pkOUlaejJKSFF3aXZTYi9la0s4RnAvVFRr?=
 =?utf-8?B?UzNRSkhoNVcyNVZZaHcyaTRndURvamVvV2lrOXVnVGhsUTQ3MDBUS08yUU5X?=
 =?utf-8?B?UjFoRVZJMXR0VElNSFI4S090VVRvRnFLWEp2VWNJTTFkRm56SjhJWURRVUVM?=
 =?utf-8?B?UFFaWFk2N003aTlnNU1kQW9Ea0wveXFYYXNPdGh0RXVlSmpKYkdHUHFSRUNU?=
 =?utf-8?B?ZTNmRTNBTXZpSDFoVHpIZmtSR0wxbWNKR3ZWZjJ1STZvT09JR20xaS9oeVdx?=
 =?utf-8?Q?72Mp4TAV/xSJbiyRHCXLJxM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR07MB9711.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LytjWW84TnFwbndjN0Vsb3ZwUi9EbXVpUTZHdy9Kb1VQMzlPTWtEdjBQdmRh?=
 =?utf-8?B?QncvQVNGeTQxVmdGajF4L1ZoNzVtRlV2ZllqbnBOSHYyaU15Y1VtbnhHL1Fw?=
 =?utf-8?B?c0lDN1NtWk5uRUlNVzNGckJmSnhvYlFZWmhtVzV0R3BiQjR4TnpidEpiRUFK?=
 =?utf-8?B?bEhJbU9Dd0dDL1hNTWx1QUhGSVpXWDZXcHg5UUZwdnpCNmVIbGdJc2swM0Mv?=
 =?utf-8?B?MXZFN2F4WEd0ZFpFZEZZZ0Z2NmJOWUVweEw4bnBvVGRPYnNmS2EweHdlZDVL?=
 =?utf-8?B?S2RQTVgrcFozeFlvcmdwcldtQlNWKy9ISHdhU1VGYm1xMHBsOGlLdWVLRFFK?=
 =?utf-8?B?dTdHeWhZLzEyc3BTMy84Q1ArZWw1dXh2QTRSekNienVWWEJkZEdNaDRhQjUz?=
 =?utf-8?B?amhhT0JqeUhKb0d2Rk0wcW5iWjVsdEoyUVYvcEUrVnFZUmRoWTArK3JjY3lB?=
 =?utf-8?B?eHBwbjBGd3krQmJhdnlzcU9JOExqZ1ZjY1BWLysvUU4rZWxOYXo5ek9kL0Q0?=
 =?utf-8?B?V1ZuTnBjRlZWTFQyTnpsWGJpM290T1Ayc1dsMkV2MFRjZjdUYmN1UW03UVd6?=
 =?utf-8?B?d2hTRHVuditySWpyTmlNa3U3RCtwdWpBVFRnMS9SRG9xUjl1cG5GL1BFSnM5?=
 =?utf-8?B?Y1ZBU3BvZWtBZTFaMFNXZmRidTJzRUVacndpbFpIYUZURTlvZWtZcWpZbFRS?=
 =?utf-8?B?ZUJNWUNzdkNVWGoxSVJrMExsQTZWMDdRSHIvSnNOcFk5Rithb0M4SnVvejUz?=
 =?utf-8?B?Ni9lWDZFd3lIcnowRUpRVXlKOEpFRUQvUXdWbDRMS0tWUHBnc3dXY1cyZnE4?=
 =?utf-8?B?TEpRR3ErbTAyR0ZIZXR0NXZwcHhyNXJCYUU0LytQY2xaSHpTWTlNWERIR2Jk?=
 =?utf-8?B?Q05mWDV4UDlNNUxmRjgwdzkvSGJaSVRsMHV1MWUvVTAyeHZrSTQ4Q3lUSkFF?=
 =?utf-8?B?ZlhtWThDOFNwZ0haaTUybmt1bXhESWJUS0drQ2MvY0VKYmVKT1M5YXBIN2kv?=
 =?utf-8?B?L3BrVFd3QUxUR0ZJb0IzeFZDQ3MvUzkvVEZDSlhLa1Q0cUZOMW0yUkZrTnhy?=
 =?utf-8?B?b3lCZXFYaUVqMnR4YzhYUEJxRTY3Q05tRHhvV3pwTG0wK2VJcldrUndMUk1y?=
 =?utf-8?B?NVdFSzZsV0V5TUxkTEM3cUlGRmJQcW9WVmxxdU9QbG1LRHdGdC8xWWQrZkdP?=
 =?utf-8?B?MWhhbjNxd2ZGbnA0VTArR3NEeTBXdXlYbE5rd2F6RnM3Rk1KN0psWUo4Ym5q?=
 =?utf-8?B?WVFGZFF4eE42dEVsdWlxNGJlZU1sclR5V1ZiM2hjRHFGVjM4bXp6d1F0Y2Na?=
 =?utf-8?B?MHNjRzR2VTdkZDhlcDFuSVhEYnFlK1ZXdmdVTnk0Q0hHZ29jSGRsSDBwVk9u?=
 =?utf-8?B?S1Z4ZTRJNWdXbVJBUlMzOFdoU09UWGhQNkIzSHZRTVBvdDdyRHhmVCtvd0No?=
 =?utf-8?B?Q1Y5bWdDMlVLQ3llQ0dUNmFQYmN6OURBSEk0aWcxamE2OHlzZk13bFhUdU9S?=
 =?utf-8?B?RXhXZHhGODhxWUZvTWs3R1RCQkFnNVdLTUdBVW15TkhLT3ZIUmZzeWlwcFdi?=
 =?utf-8?B?YlhFcUkyZzFEL2U4VnNsZmp5M0tqWDdnamJpaGc3NnY3WVlyN2UyRkNweHRh?=
 =?utf-8?B?YlFhK1RNTDhDVVY1a214SlhwSnNIQnJpQzk1RVlsNk1zZGY1YjZubWt3UG93?=
 =?utf-8?B?SFZjZHJZeDh0NC9rVWFqTXdEZGUwb3NBZjBMUTNnS2lBUEljOTZqMlI0ZUxu?=
 =?utf-8?B?ZlZramhmeUR4SS9Bb3RVdE84bi9EeVVaQ3d1ZHRKYVF5cS94NUliT0tCeG1V?=
 =?utf-8?B?UzdNcklDQmlrNjlHeVFsTWxDY0QrTU1rNzRXMXJ0dEs5RWZZcUdES2RSaWtW?=
 =?utf-8?B?ZEVwMkl6b3JENGNLTXgrTGhabm5oam9xY3lPenAwbEQ3U2hxUTNTTmwyK0dp?=
 =?utf-8?B?cllkcFJPak9WK01CeGJUbkxMYkxJZFVpbWh0eFV3Yy81QWxkWVRBWEtDMHZ5?=
 =?utf-8?B?SmRPQlZIZEdLbTg0eVd4OWxLMHBjRlQ2cVl5NWxjRy9kb0lFYjdPcjU5THJz?=
 =?utf-8?B?VzRreFhTVVowYWJSYnkvalZvYjdVTHppQ0VaZWlNSWk0cUlRZXd1ZnlLY1Uz?=
 =?utf-8?B?VWFBWmwrMFVvUGtxZTdCVFhWN0dHajNnNGFkMHJJSS83MTl4Vm85TDQzYWVR?=
 =?utf-8?B?UmdUVHB1R1RMWFVSVUFBMmIzWGYvbkROTTFkVmNPbzV0SFRDQ3lBUFRxYllw?=
 =?utf-8?B?R21xMkxZMmNscmF4QlF2aTBwSG5sbjdyeXZLdVJrTW1sLzhvQmxIVEdURHcy?=
 =?utf-8?B?V3FZOGJ1TjhnVjV0ZWpCSjNBYmp0cEt6R2lSN1JMY1ZSTE13akRlWXEzRUJm?=
 =?utf-8?Q?EHt7Y5DAvynL+bXx72L+etGjGYRLIMA1XCB+W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: novatechautomation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR07MB9711.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2c3db2-b9bf-4da7-b97a-08de68acf4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:01:58.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb0f6598-d3e5-4ff3-a8b8-fe893d304059
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSCt+pqGILh6ZqkA2Q1KxHNsvIVe9BeXI4Y/8MWpUrH5N0XNPV5pmWqXIP6yEGg3w4AzkzKpttmOSuJHBjfOlBYL+ntggDNgn3Vn5TeW3uom7KMNzwK/EtDDBfYQJ0S2znxiP0fTxdjghN/56gi7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR07MB11555
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

SGVsbG8gU2ltb24sIFRvbSwKCkkgYW0gZ2V0dGluZyBiYWNrIHRvIHRoaXMgYW5kIHdpbGwgdHJ5
IHRvIGFuc3dlciB5b3VyIHF1ZXN0aW9ucyB0aGUgYmVzdCBJIGNhbi4gSXQgaGFzIGJlZW4gcXVp
dGUgc29tZSB0aW1lIHNpbmNlIEkgd2FzIGRlZXAgaW50byB0aGlzIGNvZGUuCgoxLiBUb20gLSAK
PiBEb2luZyBpdCB0aGlzIHdheSB3aWxsIGJyZWFrIG90aGVyIGFyY2hpdGVjdHVyZXMuIENhbiB3
ZSBqdXN0IGNhbGwgdGhlCj4gZnVuY3Rpb24gbmVlZGVkIGluc2lkZSBvZiB4ODYgYXNzZW1ibHk/
Ckkgc3VwcG9zZSB3ZSBjb3VsZCBkbyBzb21ldGhpbmcgbGlrZSB0aGF0LiBXaGF0IGRvIHlvdSBz
dWdnZXN0PyBBIG5ldyAuUyBhc3NlbWJseSBmaWxlPwoKMi4gU2ltb24gLQo+IEFyZSB5b3UgdXNp
bmcgdGhlIGVtYmVkZGVkIHRvb2xjaGFpbiwgb3IganVzdCB0aGUgaG9zdCBjb21waWxlcj8KSSB3
YXMgdXNpbmcgdGhlIGhvc3QgY29tcGlsZXIgcGFja2FnZWQgaW4gVWJ1bnR1IDIyLjA0IHdoaWNo
IGF0IHRoZSB0aW1lIHdhcyBHQ0MgMTEuNC4wLgpJIGhhdmUgbW92ZWQgdG8gVWJ1bnR1IDI0LjA0
LjMgTFRTIHdoaWNoIGhhcyBHQ0MgMTEuNS4wIGN1cnJlbnRseS4gSWYgeW91IHdvdWxkIGxpa2Ug
bWUgdG8KdGVzdCB1c2luZyBhIHNwZWNpZmljIGNvbXBpbGVyIGFuZCAvIG9yIHRvb2xjaGFpbiBw
bGVhc2UgbGV0IG1lIGtub3chIEFsc28gSSBub3RpY2VkIHlvdSBhcmUKdGVzdGluZyBhZ2FpbnN0
OiAiVS1Cb290IDIwMjYuMDEtcmM1IiBhbmQgYWNjb3JkaW5nIHRvIG15IG5vdGVzLCBhbmQgZ2l0
IGhpc3RvcnkgaXQgYXBwZWFycwpJIHdhcyB3b3JraW5nIHdpdGggdjIwMjQuMDQgYXQgdGhlIHRp
bWUuIEFzIHdlIG1vdmUgZm9yd2FyZCB3aXRoIHRoaXMgSSBjYW4gZG8gdGVzdHMgYWdhaW5zdAp0
aGUgbGF0ZXN0IHZlcnNpb24uIERvIHlvdSBoYXZlIGEgc3BlY2lmaWMgY29tbWl0IHlvdSB3b3Vs
ZCBsaWtlIG1lIHRvIHRlc3QgZnJvbSwgb3IganVzdCBtYXN0ZXIKYnJhbmNoIHRpcD8KCgpFcmlj
IFNjaGlrc2NobmVpdApTZW5pb3IgRW1iZWRkZWQgTGludXggRW5naW5lZXIgSUlJwqAg4oCLCsKg
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTogU2ltb24gR2xh
c3MgPHNqZ0BjaHJvbWl1bS5vcmc+ClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDMsIDIwMjYgMzoy
OCBQTQpUbzogVG9tIFJpbmkKQ2M6IEVyaWMgU2NoaWtzY2huZWl0OyB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgYm1lbmcuY25AZ21haWwuY29tClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBGaXggeDg2
IGJheXRyYWlsIGJvb3QgZmxvdy4KCkhpLAoKT24gV2VkLCA0IEZlYiAyMDI2IGF0IDA3OjAyLCBU
b20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPiB3cm90ZToKPgo+IE9uIE1vbiwgSnVsIDE0LCAy
MDI1IGF0IDA0OjAyOjQ4UE0gLTA1MDAsIEVyaWMgU2NoaWtzY2huZWl0IHdyb3RlOgo+Cj4gPiBJ
dCB3YXMgZm91bmQgdGhhdCBvbiBtb2Rlcm4gdmVyc2lvbnMgb2YgR0NDIHRoZSB0cmFuc2l0aW9u
IGZyb20gbG93IGxldmVsCj4gPiBhc3NlbWJseSBpbnRvIHRoZSBDIGZ1bmN0aW9uICdmc3BfZmlu
ZF9oZWFkZXInIHdhcyBubyBsb25nZXIgdmFsaWQuIEEgZGV0YWlsZWQKPiA+IHN0ZXAgYnkgc3Rl
cCBhbmFseXNpcyB3aXRoIEdEQiBzaG93ZWQgdGhhdCB2YXJpb3VzIHJlZ2lzdGVycyB3ZXJlIG5v
dCBiZWluZwo+ID4gaW5pdGlhbGl6ZWQgcHJvcGVybHkgd2hpY2ggd291bGQgcmVzdWx0IGluIHRo
ZSBoYXJkd2FyZSB0byBmYWlsIHRvIHNldHVwIHRoZQo+ID4gQ2FjaGUgQXMgUmFtIChDQVIpIHBv
cnRpb24uIFRoaXMgZmFpbHVyZSBjYXNjYWRlcyBkb3duIGludG8gbGF0ZXIgc3RhZ2VzIG9mCj4g
PiBpbml0aWFsaXphdGlvbiBiZWNhdXNlIHRoZXJlIGlzIG5vIHZhbGlkIHN0YWNrLCBvciBtZW1v
cnkgZm9yIGxhdGVyIGZ1bmN0aW9ucy4KPiA+Cj4gPiBUaGUgZnVuY3Rpb24gJ2ZzcF9maW5kX2hl
YWRlcicgaGFzIGJlZW4gcmV3cml0dGVuIGluIGFzc2VtYmx5LCB3aGljaCBzaG91bGQKPiA+IG5v
IGxvbmdlciBiZSBkZXBlbmRhbnQgb24gYSBzcGVjaWZpYyB2ZXJzaW9uIG9mIEdDQyBpbiBvcmRl
ciB0byBiZSB1c2FibGUgb24KPiA+IGFjdHVhbCBoYXJkd2FyZS4KPiA+Cj4gPiBUZXN0aW5nIHdh
cyBkb25lIHVzaW5nIEdDQyAxMS40LjAgb24gVWJ1bnR1IDIyLjA0Lgo+ID4gSGFyZHdhcmUgdXNl
ZCBmb3IgdmVyaWZpY2F0aW9uOiBJbnRlbCBFMzg0NSBTb0MKPiA+Cj4gPiBQYXRjaCAxIG9mIDIK
PiA+Cj4gPiBVcHN0cmVhbS1TdGF0dXM6IFBlbmRpbmcKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBF
cmljIFNjaGlrc2NobmVpdCA8ZXJpYy5zY2hpa3NjaG5laXRAbm92YXRlY2hhdXRvbWF0aW9uLmNv
bT4KPgo+IFNvcnJ5IGZvciB0aGUgZGVsYXllZCByZXNwb25zZSBoZXJlLgo+Cj4gW3NuaXBdCj4g
PiBkaWZmIC0tZ2l0IGEvY29tbW9uL2JvYXJkX2YuYyBiL2NvbW1vbi9ib2FyZF9mLmMKPiA+IGlu
ZGV4IDQ0MmI4MzQ5ZDA4Li4zYTlhZTc0MWQ5NyAxMDA2NDQKPiA+IC0tLSBhL2NvbW1vbi9ib2Fy
ZF9mLmMKPiA+ICsrKyBiL2NvbW1vbi9ib2FyZF9mLmMKPiA+IEBAIC04NjAsNiArODYwLDcgQEAg
X193ZWFrIGludCBjbGVhcl9ic3Modm9pZCkKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBjb25zdCBp
bml0X2ZuY190IGluaXRfc2VxdWVuY2VfZltdID0gewo+ID4gKyAgICAgYXJjaF9mc3BfaW5pdCwg
ICAgICAgICAgLy8gRlNQIG9uIHBsYXRmb3JtcyBsaWtlIGJheXRyYWlsIE1VU1QgYmUgZG9uZSBi
ZWZvcmUgbWVtb3J5IG9wcwo+ID4gICAgICAgc2V0dXBfbW9uX2xlbiwKPiA+ICAjaWZkZWYgQ09O
RklHX09GX0NPTlRST0wKPiA+ICAgICAgIGZkdGRlY19zZXR1cCwKPiA+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2luaXQuaCBiL2luY2x1ZGUvaW5pdC5oCj4gPiBpbmRleCA5YTE5NTFkMTBhMC4uMjFk
OWNlYTMwZjYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2luaXQuaAo+ID4gKysrIGIvaW5jbHVk
ZS9pbml0LmgKPiA+IEBAIC02OCw2ICs2OCwxNSBAQCBpbnQgbWFjaF9jcHVfaW5pdCh2b2lkKTsK
PiA+ICAgKi8KPiA+ICBpbnQgYXJjaF9mc3BfaW5pdF9yKHZvaWQpOwo+ID4KPiA+ICsvKioKPiA+
ICsgKiBhcmNoX2ZzcF9pbml0KCkgLSBwZXJmb3JtIGZpcm13YXJlIHN1cHBvcnQgcGFja2FnZSBp
bml0Cj4gPiArICoKPiA+ICsgKiBXaGVyZSBVLUJvb3QgcmVsaWVzIG9uIGJpbmFyeSBibG9icyB0
byBoYW5kbGUgcGFydCBvZiB0aGUgc3lzdGVtIGluaXQsIHRoaXMKPiA+ICsgKiBmdW5jdGlvbiBj
YW4gYmUgdXNlZCB0byBzZXQgdXAgdGhlIGJsb2JzLiBUaGlzIGlzIHVzZWQgb24gc29tZSBJbnRl
bAo+ID4gKyAqIHBsYXRmb3Jtcy4KPiA+ICsgKi8KPiA+ICtpbnQgYXJjaF9mc3BfaW5pdCh2b2lk
KTsKPiA+ICsKPiA+ICBpbnQgZHJhbV9pbml0KHZvaWQpOwo+ID4KPiA+ICAvKioKPgo+IERvaW5n
IGl0IHRoaXMgd2F5IHdpbGwgYnJlYWsgb3RoZXIgYXJjaGl0ZWN0dXJlcy4gQ2FuIHdlIGp1c3Qg
Y2FsbCB0aGUKPiBmdW5jdGlvbiBuZWVkZWQgaW5zaWRlIG9mIHg4NiBhc3NlbWJseT8KCkFsc28g
SSB3b25kZXIgd2hhdCBpcyBkaWZmZXJlbnQgaGVyZS4gSXMgaXQgYSBidWcgaW4gZ2NjIG9yIHNv
bWV0aGluZwplbHNlLiBXaGVuIEkgdHJ5IC1uZXh0IG9uIG1pbm5vd21heCBJIHNlZSBzb21lIGVy
cm9ycywgYnV0IGl0IGRvZXMKYm9vdDoKCiQgdWItaW50IG1pbm5vd21heApCdWlsZGluZyBVLUJv
b3QgaW4gc291cmNlZGlyIGZvciBtaW5ub3dtYXgKQm9vdHN0cmFwcGluZyBVLUJvb3QgZnJvbSBk
aXIgL3RtcC9iL21pbm5vd21heApXcml0aW5nIFUtQm9vdCB1c2luZyBtZXRob2QgZW0xMDAKQmxv
Ymxpc3QgYXQgMCBub3QgZm91bmQgKGVycj0tMikKYWxsb2Mgc3BhY2UgZXhoYXVzdGVkIHB0ciA0
MDAgbGltaXQgMApCbG9ibGlzdCBhdCAwIG5vdCBmb3VuZCAoZXJyPS0yKQpCbG9ibGlzdCBhdCAw
IG5vdCBmb3VuZCAoZXJyPS0yKQphbGxvYyBzcGFjZSBleGhhdXN0ZWQgcHRyIDQwMCBsaW1pdCAw
CkJsb2JsaXN0IGF0IDAgbm90IGZvdW5kIChlcnI9LTIpCgoKVS1Cb290IDIwMjYuMDEtcmM1LTAw
NDg4LWc2Y2RkNzU5N2EyZmIgKEZlYiAwMyAyMDI2IC0gMTQ6MjA6MzcgLTA3MDApCgpDUFU6ICAg
SW50ZWwoUikgQXRvbShUTSkgQ1BVICBFMzgyNSAgQCAxLjMzR0h6CkRSQU06ICAyIEdpQiAodG90
YWwgMS45IEdpQikKQ29yZTogIDI1IGRldmljZXMsIDE2IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBz
ZXBhcmF0ZQpNTUM6ICAgcGNpX21tYzogMCwgcGNpX21tYzogMSwgcGNpX21tYzogMgpMb2FkaW5n
IEVudmlyb25tZW50IGZyb20gU1BJRmxhc2guLi4gU0Y6IERldGVjdGVkIHcyNXE2NGR3IHdpdGgg
cGFnZQpzaXplIDI1NiBCeXRlcywgZXJhc2Ugc2l6ZSA0IEtpQiwgdG90YWwgOCBNaUIKKioqIFdh
cm5pbmcgLSBiYWQgQ1JDLCB1c2luZyBkZWZhdWx0IGVudmlyb25tZW50CgpNb2RlbDogSW50ZWwg
TWlubm93Ym9hcmQgTWF4Ck5ldDogICBldGgwOiBldGhfcnRsODE2OQoKSGl0IGFueSBrZXkgdG8g
c3RvcCBhdXRvYm9vdDogMAo9PgoKVGhpcyBpcyB3aXRoIH4vLi5idWlsZG1hbi10b29sY2hhaW5z
L2djYy0xMy4yLjAtbm9saWJjL2kzODYtbGludXgvYmluL2kzODYtbGludXgtCgpidXQgSSBhbHNv
IHRyaWVkIHdpdGgKfi8uYnVpbGRtYW4tdG9vbGNoYWlucy9nY2MtMTEuMS4wLW5vbGliYy9pMzg2
LWxpbnV4L2Jpbi9pMzg2LWxpbnV4LQphbmQgZ290IHRoZSBzYW1lIHJlc3VsdC4KCkkgd29uZGVy
IGlmIHRoaXMgaXMgYSBidWcgaW4gdGhhdCBwYXJ0aWN1bGFyIHZlcnNpb24uIEFyZSB5b3UgdXNp
bmcKdGhlIGVtYmVkZGVkIHRvb2xjaGFpbiwgb3IganVzdCB0aGUgaG9zdCBjb21waWxlcj8gQm90
aCBzaG91bGQKbm9ybWFsbHkgd29yayB0aG91Z2guLi4KClJlZ2FyZHMsClNpbW9uCg==
