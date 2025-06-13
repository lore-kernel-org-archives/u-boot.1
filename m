Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47BEC71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 11:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB7F807B1;
	Fri, 13 Jun 2025 13:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SnTnq5mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F1F80C93; Fri, 13 Jun 2025 13:16:05 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73357800C1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 13:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHqJ2E/X4QAokPX5qQ06WhZ3AA7gTqQZcvtSGZQoNhqW9Dj8oe+2TtZSjhM8X+IORlOMw4fi/Gpo8+FedGEcSacnebNaEYa9OfQYIPC2ZlxJxp0qRxHp8KSxzwiYU8OauLcnjRmxLGb2VSpYT/Zr5G4dAn7pSuwfk52qE5MgsgYDJL6EbL+VK1SCq+EFqrQ3+joW9BK86S4EYwbCN2sUa13y3Eo5OVjJSdsPX/np6E1Te2Apc9t8mBhgEtv+F1myqxSZX5C3daeDP1rTE/GJGjdesb4ZVQLxtaSQSMJ4yfoeku/mwF+araesv16KVTq2dDAlY6TclOX2xypxhGR81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bvEt3U8wTftvVZt1MnbqFmfu6Q0vJuvHG6EXYhcJd8=;
 b=BNPNJ9vwbCDNBCS8bhOKlEc/YuBt5Kf2CIF8BAo/AQvjZBhpAc/pqVWH1pEy1IRN9d2RAz03dZf+j2/9MWK7GZrGzrJ2WOv8c7haiCs95H/Em30iBqzD+znDA4mkAh5msGCA612t4a0kXbVrIOIX54vOpEaNEDiaHW/fLc4zOLlkis7yUjtw9iAGMqQASncvX8yhTsSY7MTShW9/GWfMVjdzbYj9Me8DjekTprYfH2wByAzsnUq6JelALulTHQCGUQuOdIfF6lOSldvLjGSbzgxeF22JZNHlra3HKAOstaTAiaCNsx2odd6/Kj8FRUxtS25p6o1vUR4m2233xBxJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bvEt3U8wTftvVZt1MnbqFmfu6Q0vJuvHG6EXYhcJd8=;
 b=SnTnq5mX5a7EXaNVRaWX0yNuwwWY+SHEGy+qNg3BslpI5sdZRa2/6TXwV4K1W0cnF80osMWuwGkp1CrgP1kf7iJmEgxnOqMdNtusgm91+MYV+G5qHJWkzPDnwl/PH+eTKrnEBo805djw8eGGI7Grl9daL0M2ppqgSF4leCh+0qSBYg17QBeADV0GRlefUlYK+oD4YmsX0R0rXq85buJZUEWuViivi9Bk8lFhydaLqXRtNgQylAjHCVk8BQSzMcxDgqzjf1vKiBtcIwLtXYnqTDy7nNLjBns8vfXrEfNMU3wZsbJNHeBlqK45fCl2XGPH53OcpZQW1AGHcOvsD1US0Q==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AS2P195MB2456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:644::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Fri, 13 Jun
 2025 11:16:00 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8792.040; Fri, 13 Jun 2025
 11:16:00 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH RFC v2 0/8] Fix handling of optional blobs in binman
Thread-Topic: [PATCH RFC v2 0/8] Fix handling of optional blobs in binman
Thread-Index: AQHbzwqv/YjirlZr4EmhG1Iedcb2ebPrCxqAgBX/5IA=
Date: Fri, 13 Jun 2025 11:16:00 +0000
Message-ID: <b0fdf28bc4cd58677736b5911aaa8998ac8d632c.camel@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <CAFLszTjEBdvSPiGCMSxSjMCnQWx2B9qpFZtPObaY-FncNYsLWA@mail.gmail.com>
In-Reply-To: <CAFLszTjEBdvSPiGCMSxSjMCnQWx2B9qpFZtPObaY-FncNYsLWA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AS2P195MB2456:EE_
x-ms-office365-filtering-correlation-id: 21321977-1226-42fe-8c6f-08ddaa6bad5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aXVGNk8vSE9rWnRYaXRaK0k3aUw0ZktsTkIyc1NmQ1FMUlM0MUxUczZyNUtr?=
 =?utf-8?B?aGR3ZUkrSlV3OG4zeFR6L3BzdEp5eENpRkw0ZUNyL0o5Skk4QldKbEQ1SnI2?=
 =?utf-8?B?eWo4c3dmVW0rd0dZYm5Bcy9oTjk1cGNFM2tMTkkrekwvUG5vczhvRTJtSHZk?=
 =?utf-8?B?N2ovUkp5bFhUdVB1MDEvWHU5Y2c4cEJRb0d6a0lrbWc3QVc0L2JoNnplY1Jl?=
 =?utf-8?B?UGhLcTlEeFA0YWM1SEdYS0NpL3B0aTBDTEZGZ3N0WitmU1c1Z3lKVWxXY3VK?=
 =?utf-8?B?TW11RVFxM0NVbTAxbFkvTGNVNDl5eHQ0Mi9LYXd0b2dSNldXWFZBUGdUZ3l0?=
 =?utf-8?B?UDJXamp6a1pSWGN6cUNxcy84aVE4dEh4ZzFOY2NxQUowbUFjcitJaU9EMmsz?=
 =?utf-8?B?bjhNTVcxenRmakNGMFpZSGZiN1czQ3ZMQUJ0Y2gwYnZzWUI1ditnbUpKMnkz?=
 =?utf-8?B?QlpsZGpPWVMyZm1EVHBOeXAvQkpWMU1HY2pna3VUVFptN0Yrd1NlWkJVcGFy?=
 =?utf-8?B?dDc0SmFPaTdMTzR5czdEVmpyOGV5S3U0bU5vZ1NZZ0U0ZEtJMmIwVGxQMU9p?=
 =?utf-8?B?cHRPTmNlZXF2SUlTQ1BMZVR1UUdPTDh0N1pKVUNubVhzVi9xZUxnTm5la2la?=
 =?utf-8?B?YlFGK3hKSERScUlyajlMOGZqSlliaGx0OEFjelBpZlYrV083SzZJcG5WdDl4?=
 =?utf-8?B?T0JCQVhkSndRRkVYRk9mU3V0cHJlY3lnUEpjNnJRc2J3NEtPanovU3kxdGFz?=
 =?utf-8?B?dmlyd1BvSGN4ZkZmTGk4Z1FZTmkrT28wNU9RcERqaC9WRytiMllTS25vcTFa?=
 =?utf-8?B?Y2h3Yk9ZYlRpVy9wQW5CZXk1SzZlcXNNZGduazF0QXR1OEI0QUU4UWZhZkZo?=
 =?utf-8?B?Uk95TWduQkNabVd2Syt2VVFRdVdVRmJhL243blRXSHR0V1hzS1YvQkJaNmhI?=
 =?utf-8?B?ZklkZytuUmNweHY4QUF5cnk0TmJURy9KRzNNamVjRGFPYzBXRlZuelNyTkdI?=
 =?utf-8?B?TmhNL284eDRoUUNYNVAzOGxGS25xU3hWaXJmbXZMelRpVVlLZUpHRS9ZbGNp?=
 =?utf-8?B?aWoveDdzK2t1WmhPK3JFVWtOa3dwM2p0NW5vemRId240NmlwMjByRlVJa3Fh?=
 =?utf-8?B?VWN3cXVIZGNwQ2NVNHB2aWI4OXJPTFUrUU9LdHV1eFBUMDBZVnBSdCsrVy8y?=
 =?utf-8?B?SFR0NkVJOXpMeHc4OHptNm9Sdisza041R0xsb3ZkUmlua3RUK1A0YS9PelNs?=
 =?utf-8?B?bDcwb2t0ZE43TWhXNExDZmJFQzhqRi9ReGFyRmYySkUwL3F1N2V0T1dOREZi?=
 =?utf-8?B?UFNpTmhlbFJvVVVLcnI5Y1dKaUlrejFOa1FmTTRZeTVsUmVOeUg0WlNWSXA5?=
 =?utf-8?B?M0x5LzRJQVlLMXdUUFpzSWNJMVlHY1B4VW52U3BIbXRkeEt4UmVrSkFscjNn?=
 =?utf-8?B?TTMrYXFMN1duMHhXbWZwemt6Q1RYYnJseTN0eGJHSENJeGRMSGdhZXVKUFRr?=
 =?utf-8?B?WGdDL0ZoVWN0YmgzekRXcWdpYlhQZnlkRzYzazNTM296VWZGa0k5b3BVZXhj?=
 =?utf-8?B?Q1BnWDYvanlaMHdVRlp3Z2YyQkVDdUVjNVJ5TmVsTFp3VTVvQ3htYytHMy9J?=
 =?utf-8?B?S3FDWmwyK0tWOEt1WERRbU55QkpoYUVNa251OG5OMmdkS1pqOFJ4d2tOVFph?=
 =?utf-8?B?YkVxM2JBR1UwZmljVWZ0RDQ4MWF4RVFJZy9JbTl5WjBXeGkxSjVuZkdoVjhn?=
 =?utf-8?B?b1pJMjVRUEhMb2xPZ0x6OTZmd0xKcDgxS0FUaW1sdVdpVnkwSmpYRjZSMzZO?=
 =?utf-8?B?NjhKQ1dSY0FwL2REU2VQcVA1blJBME01Ui9SOEpjMVAyL0laUDAwR3hPYWJV?=
 =?utf-8?B?cVJhYVdNT1h3SVBxYmlpTTVSUG1vRG5PcVEwa2tmT3NOUUhpT2VZaTNNRTNK?=
 =?utf-8?B?cVlUN29rWGdkN0VCenVpNmtHblVvTk9ZRG9KemcyUHRPMnRLaS9jaUtYbytR?=
 =?utf-8?Q?X+DEEXdAt3qzA2v4GvV7hYj1Q6b5aw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzBYQ0dtRUlhVGlrZDU3TDF3N0xsVVlvTjV4YzRyblc5WjBLdFdpakhBU1p3?=
 =?utf-8?B?OGptOFZtRU5ueVN6TlV4aEQzbkVEclRKbVBJWmtpcEIvcllSQ2xzcVVqSDky?=
 =?utf-8?B?cHpXcmx4MVhwVDVoM0lyRFpCR25YKy9RaDJBdnJxWEhWd2U5amFOc2o1SUtU?=
 =?utf-8?B?dXlGVmFtUmkrSXlUL2d2L2NUWWd6dVdKQ2JEeUNsS1VJc2ptS043cTRnUmEr?=
 =?utf-8?B?S2VSb0JPdzB3Nk11YmRiWmhXQmoxRGVIVkRBdmo4WENoSFQwZmRhOGR0Ykx1?=
 =?utf-8?B?RENiMWp2RjdyaDg5QjBpT3BYVGhEcHNXVnhVYThCQWpvRVdYT0pFWkR5bEZ0?=
 =?utf-8?B?TU5vMHFUMXB4NXRrNG9YTzkrdWV2TzJZeVNEV1lHL2FBMWtlVE9tQnV6Mms2?=
 =?utf-8?B?ZDZvZU96bllxbjBKRGF3dDJHZXdrYTlnRmhYL3c2UVZhNndnaWVPZmE1Kzcv?=
 =?utf-8?B?ZHdRRHlzZGhQWW1XMlBSKzFodmZ1RWpNbVdTaDl0S0RqK1VxbVFFL1FsOW8w?=
 =?utf-8?B?algzK3J0T3ZEcEptN245OUVGZW5IaWl0bC94SnMxVGtqSVR1bXQ5aUJhT1hL?=
 =?utf-8?B?bXdSK2hGbEQ5K1YxMEMvRHpjWTZrc2R1enh5cHZXT0l1Q0gwclE5ajdXUWpH?=
 =?utf-8?B?WWZOSmgvVnppUlNPdnFaVTUzV2hHVzduTVZvMUdmeUphY2ZHblNpenR1U2xY?=
 =?utf-8?B?QWNMTEFZN0JITCsyWHF2Q0lRcks2enYraWFteUx0djRFdnlJYU1QbDJ3N0tE?=
 =?utf-8?B?OVU4d1J5WWVzNVYrdEVXVWhwRHlhNFVFdGtkb0U2UnlqWkpGclF0aytnTE1y?=
 =?utf-8?B?Z2R5WmJrRDdHMk5ZQThaUzVkQ0hEaDRTWUdQWkFaNWQ2TmsyN3M5MnhzdUo3?=
 =?utf-8?B?bkZjYlJZSXR1VzByOTBqUWZkdXd0NS9FUUtadGJhUEN6aUhGczJ4UHRxYit5?=
 =?utf-8?B?Z2VnMDJ2SWRIdVBiWUt0VVNMNjhUUUNSVUNsNktNa3V1T0IwRHJUQTNwTlJo?=
 =?utf-8?B?cmZWUVFucmVqOEpmTlpxcmJJZ2ppZDdqclhYRUVud3BhazBFYVcvQ3Vpckd1?=
 =?utf-8?B?SDdCM3g4NzVxcmNPUDFrVmZRMkszdnkxRENTNmNkRVU0UElRTXR3Z2RLelg3?=
 =?utf-8?B?SzFUQlBlQmcyZklSY0FmTWVEcnhtUzBVUmliNllQUXIvSmUzR28vai9FanQz?=
 =?utf-8?B?QUVpUGJSVlBpUkttbzNZRXpZYVZFY1VielZsNVJrZGg1TzhVaS9VSjgwYjcx?=
 =?utf-8?B?Y0ozbVN0Q3h2cWEvRlQ3Wm5WNWVBZHdaM2VpZlZEUTBVNW5oMUdzdXUxRXg0?=
 =?utf-8?B?WmZEeW4xc3h1Qzd1c2hHZk1GczVCbzNHaHE0Y3NkRWZPMUlyT0l0TVpEdHFB?=
 =?utf-8?B?dUExVUZ3dXJ6bmpWQmU5TG9ucnBHSTBDUkt2aE9DUWJRYW9pSmRjL1J4Z1cx?=
 =?utf-8?B?VVN2U1IvMTdyWkEvVkc4T052WnJwZjRuUjJZVzhXZDRoaHFMaHI4RU1WS0Qr?=
 =?utf-8?B?WWh3bVpWY256allYNXV1VXQ3VE52UXdLQWFQVDdBeVRmU21ENm55NlhIK1Fr?=
 =?utf-8?B?OEhQQzgzblRwY3hxTW5QeVIzaWpGYnZvWUxld3hzQnMyQ0NyRmdvem1xUFV2?=
 =?utf-8?B?dlVqd1RldU1EWmZ0Y2NQTGlzUWJnWWpST3JHQUx6MHAxeFY2anVub1FrcFM3?=
 =?utf-8?B?S1pwOElBTEZtckVkVWc0R2k2S2xiajRBSFlvKzhBRTE1K3ozTVcxYUdRM3JJ?=
 =?utf-8?B?V2FDbW16K0dTWHBOMUJ0a09ta1pleFhzVTVrenlnVXdWdlFVWnliSWtORUx1?=
 =?utf-8?B?QjlzWmVIam0vckh1YTBoRDZWQkVzWHFMeWJnQnpPa1N5WVJEVi9nVFdzeDhI?=
 =?utf-8?B?M21IdjdNQWpXT1ZTd1RTTWR4NkNYWUhBU3ZBbWhDekw3NmdmQUp5Mks2MkZ4?=
 =?utf-8?B?VWJxR1pHN0F4bEdsdGYwTjE1U24zUzJ2V2Fubm1VN2VGcTZVazcycTFTZHBM?=
 =?utf-8?B?VzZDQ0lYdVg3UmlhRWFLTnFaa05Od3JTK3pIeU5VZnB5NW52M3JHZXFZTEZD?=
 =?utf-8?B?VEV1ODVodktDTFpxTU54eDA2bjZ0Z2FUbzdQMEJEbWVOcGk5a3g3MGIxMkdt?=
 =?utf-8?Q?dni4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78DA548C8C26284095A6CD7B0BB0B301@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21321977-1226-42fe-8c6f-08ddaa6bad5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 11:16:00.2880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPFMat7quIReFtqh1rXHHKuG7RqOfd3fgSao8WFEuJZ2wCADp3vHDDg1JMAehLNIwnj6Z2nABlolZh4Znc1xSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2456
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

SGkgU2ltb24sCgpBbSBGcmVpdGFnLCBkZW0gMzAuMDUuMjAyNSB1bSAxMjoxOCArMDEwMCBzY2hy
aWViIFNpbW9uIEdsYXNzOgo+IEhpIFlhbm5pYywKPiAKPiBPbiBUdWUsIDI3IE1heSAyMDI1IGF0
IDE0OjI0LCBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4gd3JvdGU6Cj4gPiAKPiA+IFRo
aXMgc2VyaWVzIHNvbHZlcyBhIGNvbnRyYWRpY3Rpb24gcmVnYXJkaW5nIGV4dCBibG9icyBwYWNr
YWdlZCBpbgo+ID4gYmlubWFuLiBXaGVuIHRoZXkgYXJlIG1hcmtlZCBhcyBvcHRpb25hbCwgYnkg
ZGVmYXVsdCB0aGV5IGFyZSBmYWtlZCwgdHdvCj4gPiBtZXNzYWdlcyBhcmUgZW1pdHRlZC4gT25l
IHNheXMgdGhlIGltYWdlIGlzIG5vdCBmdW5jdGlvbmFsIHRoZSBvdGhlcgo+ID4gc2F5cyB0aGUg
aW1hZ2UgaXMgc3RpbGwgZnVuY3Rpb25hbC4gQm90aCBjb25jZXJuIHRoZSBzYW1lIGJpbm1hbgo+
ID4gZW50cnkvYmxvYi4KPiA+IAo+ID4gQmlubWFuIGlzIHNldCB1cCB0byBoYXZlIGZha2UgZXh0
ZXJuYWwgYmxvYnMgaW4gY2FzZSB0aGV5IGFyZSBtaXNzaW5nLgo+ID4gVGhpcyBpcyByZWdhcmRs
ZXNzIG9uIHdoZXRoZXIgdGhleSBhcmUgb3B0aW9uYWwgb3Igbm90Lgo+ID4gVGhlIGltcGxlbWVu
dGF0aW9uIGRvZXMgbm90IGFsbG93IGRpZmZlcmVudCB0eXBlcyBvZiBlbnRyaWVzIHRvIG92ZXJy
aWRlCj4gPiB0aGUgZmFraW5nIGRlY2lzaW9uOyBhdCBsZWFzdCB0aGVyZSB3b3VsZG4ndCBiZSBt
dWNoIHNlbnNlIGluIGRvaW5nIHNvLgo+ID4gCj4gPiBIZXJlIGlzIGFuIGV4YW1wbGUgYnVpbGQg
b3V0cHV0IG9mIGEgcGh5Y29yZS1pbXg4bXA6Cj4gPiAKPiA+IMKgIEJJTk1BTsKgIC5iaW5tYW5f
c3RhbXAKPiA+IEltYWdlICdpbWFnZScgaXMgbWlzc2luZyBvcHRpb25hbCBleHRlcm5hbCBibG9i
cyBidXQgaXMgc3RpbGwgZnVuY3Rpb25hbDoKPiA+IHRlZS1vcwo+ID4gCj4gPiAvYmlubWFuL3Nl
Y3Rpb24vZml0L2ltYWdlcy90ZWUvdGVlLW9zICh0ZWUuYmluKToKPiA+IMKgwqAgU2VlIHRoZSBk
b2N1bWVudGF0aW9uIGZvciB5b3VyIGJvYXJkLiBZb3UgbWF5IG5lZWQgdG8gYnVpbGQgT3BlbiBQ
b3J0YWJsZQo+ID4gwqDCoCBUcnVzdGVkIEV4ZWN1dGlvbiBFbnZpcm9ubWVudCAoT1AtVEVFKSBh
bmQgYnVpbGQgd2l0aAo+ID4gVEVFPS9wYXRoL3RvL3RlZS5iaW4KPiA+IAo+ID4gSW1hZ2UgJ2lt
YWdlJyBoYXMgZmFrZWQgb3B0aW9uYWwgZXh0ZXJuYWwgYmxvYnMgYW5kIGlzIHN0aWxsIGZ1bmN0
aW9uYWw6Cj4gPiB0ZWUuYmluCj4gPiAKPiA+IMKgIE9GQ0hLwqDCoCAuY29uZmlnCj4gPiAKPiA+
IFRoZSBvdXRwdXQgd2lsbCBzdGF5IHRvIGluZm9ybS93YXJuIHRoZSB1c2VyLCBidXQgaW4gdGhp
cyBjYXNlIHRoZQo+IAo+IHMvd2lsbCBzdGF5L3N0YXlzLwo+IAo+IFdlIHNob3VsZCB1c2UgcHJl
c2VudCAvIGltcGVyYXRpdmUgdGVuc2UuCgpXaWxsIGNoYW5nZSwgdGhhbmtzLgoKPiAKPiA+IHRl
ZS1vcyBlbnRyeSB3aWxsIG5vdCBiZSBwcmVzZW50IGluIHRoZSBmaW5hbCBpbWFnZS4KPiA+IAo+
ID4gVGhlIGZpcnN0IHBhdGNoIG1ha2VzIGJpbm1hbiB0ZXN0IHdpdGggLS1mYWtlX2V4dF9ibG9i
cyBieSBkZWZhdWx0IHRvIGJlCj4gPiBjb25zaXN0ZW50IHdpdGggdGhlIGRlZmF1bHQgbWFrZSB0
YXJnZXQgd2hlbiBidWlsZGluZyBVLUJvb3QuIFRoaXMKPiA+IGV4cG9zZXMgYW4gZXJyb3IgYXMg
b25lIHRlc3QgaXMgZmFpbGluZyB3aGVyZSBpdCBzaG91bGQgbm90IChsb2FkYWJsZXMpLgo+ID4g
VGhlbiwgZml4IHNvbWUgdGVzdHMgdGhhdCBtdXN0IG5vdCBmYWtlIGV4dCBibG9icyBhbmQgdGh1
cyBmYWlsZWQgZHVlIHRvCj4gPiB0aGUgY2hhbmdlLgo+IAo+IEFnYWluIEknbSBzdGlsbCBub3Qg
c3VyZSB3aHkgd2UgbmVlZCB0byBjaGFuZ2UgdGhlIGRlZmF1bHQsIGJ1dCBvbmNlCj4gd2UgaGF2
ZSBhIGJpc2VjdGFibGUgc2VyaWVzIEkgd2lsbCBwcm9iYWJseSB1bmRlcnN0YW5kIGl0IGJldHRl
ci4KPiAKPiBQbGVhc2UgYWxzbyByZWJhc2Ugb24gLW5leHQKCldpbGwgZG8uCj4gCj4gCg==
