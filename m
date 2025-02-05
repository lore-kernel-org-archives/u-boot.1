Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C0C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E501280BAE;
	Wed,  5 Feb 2025 14:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="JlcK3JSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA7F80834; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E052807A8
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXL9Jl9lPRoYa2uXGTC7txOlSlBbJ/Q/goHzBqOH2gWtKM3Gq84AR0isE7RbEZ9NiZ/Zkj3cPz2nqhlaEhqFIiAcb73Og1J5pD4YHlORKZa6FbwkwyMBKk+N8dqoUnOse6ZcUFyO1UO8bW9bWpikF7wO4Uk3SDuMhFv2UEg8Np6ryGjCuBAQIEHr+A4HMOGCKXVuatNZOs84DdPR5gPpgruz1B3MCQzMEhIQn1kXNN8aJC3pCilBoH+AYGwB7P5WFbKnjvRXi8oxiiMIvkFvQOR6ldKiPhcCYixi+SgP5wxAFoV4i24ftbOFpg3nH0cfI/5XQbwOYuSd3FU83rf3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+oPQYrzcw6CKs7ok229ID17TeL0Ecdtn1XrXAufYog=;
 b=oEWjkYz3284SV12XQTFgApf/0Uyf6fLEgKSVWIU2njnKDwrFFL32/dTtZqL5c0wnGU62zfTGR5MjbuW8ED4qsHWXWqRdA5tHEg5d9oJlcJtaatEf15/ahmZNqC7HZnYXtAHK/H5fqnARJ1IkpTW1sGdXF597MCpeBqKEmO9DjzDye3Hci3b0PH6XDMqCyM30ksI5EV5kROdHs7yUGYkulLe6HNBxxw2eZUvrKJFUDG31FUNt7WT+/W4b4rCviDZAM4tnMLQz8lGgY9Xjvdy1txnjbejUsXmzAOh2CvXU5Nsv4/m9aJVSaW9ra4zZAGT6CDjgK6Ww827d95mW4FvuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+oPQYrzcw6CKs7ok229ID17TeL0Ecdtn1XrXAufYog=;
 b=JlcK3JSw2Eg9NbMev418cu1b4T9mUOMpbIzDD49agtEUcLAFI8qR9zbsuMa+8zebyPxROn5uXK0iwRoh9l/TcOhJE+mztMWY+u8uKXozic/xLSTs1acXjkmfegN/eKHn8rgghLXSsayrezW245XTEiTh2/rDh3uGxiB7TnzLVZKpMCFq6PkgdlgYysfeAFHSUz40sssLzjxh8pt37cK/M6d7OMgv46n1kSwwNVzLWcStJIIgXljM4x8pEHrmcWk25A+uLyWk75KcpBmAX9o8d+PK58TzVU/vybdkLZAkDst+zicy/o4w1sx0NlfF7qRMhak6qDId3xBAnZe7DkTVGQ==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:46 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:46 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 07/20] drivers: core: of_addr: fix of_get_dma_range
 translation
Thread-Topic: [RFC PATCH v1 07/20] drivers: core: of_addr: fix
 of_get_dma_range translation
Thread-Index: AQHbd7bqedGTJgUEtkmE323GIj3JzQ==
Date: Wed, 5 Feb 2025 10:15:44 +0000
Message-ID: <01e25a1ae3bee800a953945961a16816425f9295.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 4555482a-77dd-472a-e8db-08dd45ce0e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2FJdVh2NUhPZXpDMlc3VzNnMGd1bTBsbklWVStUSUVKNExiM2Q3eXRSN1kx?=
 =?utf-8?B?OHJwUG9OQkpnZ3U3MVFaTkYydVpmT21OOVVYRTJ4Q1lyUzdlQ2N6Y3hKWXor?=
 =?utf-8?B?NlRQSDlOSWhvcUdRdHFEaWd0TU1tQTF4ZmkwSVVlRU1Fb2E4S3ZOVitkRXVj?=
 =?utf-8?B?MkUzY2tNUkNDb0NFc1JOaFVZdDc1bEtwaXRNTU8vaWRxc3RWUElwczZZalZS?=
 =?utf-8?B?ZkRiL1VYSkJnMkNabHRJZzZ2eElodFFBSVozY2dsSFhmaG9Ubk5SdkVMZzRo?=
 =?utf-8?B?dW1oOHpwMnJZMWk2ODkvcUFlQXdoVEVISm9SeFBLdWV6Ni9zUk11RHJ5OGVJ?=
 =?utf-8?B?Y2pFcll0NkVrSVhzM0ZsR2p5NnNYTUV2ZmJaWG9JT0tXWXdDbEU0QUJuMy9B?=
 =?utf-8?B?UitqZzNxUnVSckVneUJqb1R3WE5ZdVlSYlVzMnhYVVJVZWJzTjNKNXhlUVZW?=
 =?utf-8?B?c3BpdFZWMXRqNElsTDN3aDZkVjg4NUEvQVhEdkgxWlQ0N1dIQ2ZpbnBJbHRZ?=
 =?utf-8?B?Q01mUjdyM2VXSUwwdUFWOERrTk90VEhaTXlYQ2ZBMFJpNlpFMTN6ekVzVml6?=
 =?utf-8?B?aWQxOHlHU1dack1MemE5SkdnSDJlRzM2UUpLMmNuMnBqYXo4YmdJd0p0YUMy?=
 =?utf-8?B?cEcveEd3bFo5QTBYZ0tFQkxvUlVIQWkzdnBTOFdyYzRUWU1KMk1QL0xkT3ha?=
 =?utf-8?B?K25sYi92ZmhhVTBQNloyampmeEZLM084eitlWjgrVU5XZ3F1aFhjdEM2ZFU2?=
 =?utf-8?B?NFZPWVUwZThXMjc2OWJqd2FnTDQvVGt5a3VOejV6YWpMa2VHMjdXZTM4alZk?=
 =?utf-8?B?cjdibHh0UGJZRGJkUmdCZCtia3BJb000alU0UXdYOTlSaTc1ZTFIUGIxaUJX?=
 =?utf-8?B?a1Z1MlNSbm1DRDc2QlhHU3k2LzVyWmx2ZkRvb2VKbHFuU0RlUXpKUnN6MU12?=
 =?utf-8?B?dzA1dXNGWmJtS3ZkTEN0Z0JKa1U3TDkwSDJRZ3JJOEVuTkVGRmt6WFZobWx1?=
 =?utf-8?B?WkM0R3czbm5jVUhVQlM3cWlJZCtRRGY3STFtNGJSV1FMT3FGdEdpUGJUcmxK?=
 =?utf-8?B?L1FxNC9nSytnZGwwZ2g0dmw1aXhBdlJqblZJNXNFb09QazZNZTgwclR2anIz?=
 =?utf-8?B?UzlGZ1NoSVdNcHRyTm43cDNPS1FWeEkvS2lraUM0OXF5cGxzR3JpTVFzZnBp?=
 =?utf-8?B?SEFMY2RKb1VLL0p4Y20rRnBoV1RwUUdnQjdETVhHbk5BV0ZKcS8rMUJJNnU3?=
 =?utf-8?B?aE92SXRVYkwwdm0xdFhKM01KalZibFJwRldjTHBFK0EwcDh4NHV3OTdXdEdq?=
 =?utf-8?B?d2hJaTZBVDBVZjVUMHNaS0x5OVF1Q1BCY1JTckJCdGEwYnBFU21OQi9BTmY1?=
 =?utf-8?B?dThvczZuNEVpYi9CTFpvQS9rMFFpRTNtcGN5UmtJT2FYK2tDSlpxNTgyVGh1?=
 =?utf-8?B?UlY4Z3M3TFJGS1E0SVozQ3VtZm9NVEVQRnIvUHNzWnlpNUZEamUvSGRFTHpZ?=
 =?utf-8?B?dkxTdFFxV1BBK1dBd1RiUUF1NVFaYWhSeTM1dm1FRTdwSUppck9aTHdkOHBI?=
 =?utf-8?B?Q25Ob2U1SDJXQlVFc2VMSlRqTjljWlhzdkpYM1N0UEdvSkdLdGk0c0hRREx3?=
 =?utf-8?B?UklCT3lYWHlhRFB1Tmwyc2o5QVhubHVhakhtQ2c2TXNKSzVxNHZtUkNTLzls?=
 =?utf-8?B?cm44SlFKMUZOVG01YlIvRnkvRDMwSXZTRlZFRHd5S0M3K1NPRDZwQWZHQmVN?=
 =?utf-8?B?cDFuTWVSdjVNRFJRc1pRYVJxRFVVckZNeEd3Qmw4czhLMEtkdVF3VEV6UGdt?=
 =?utf-8?B?cGN5Vmxtbk5rbTFJUGN1Q1lwZXI3MVpndWZZVmpydmRxdzBjdk52aVQrdnJP?=
 =?utf-8?Q?zWT9KrmPz5hl1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWZUTjdwblh5R29BQmhxRktxYm5xcWEyM1BmZlRGQXZGQ2p1ZlkvQ1BKMER0?=
 =?utf-8?B?MGdGQ0lYa3BZTEZPYk02Snk1dlUvQmhoYnBaTmxTdll3Wk01dWZzUEhiZWdW?=
 =?utf-8?B?SFhlKytibmUzd0ZmZjBIL09qeFM1bTg5VW5EZGZKd1F6bHdPNFNod3I5TmZj?=
 =?utf-8?B?V295NTZQcm1QUG1VWWRyU3g1amp3MzJ3ZVhicFhMbUF5ck1MNHVjVXBmVUFY?=
 =?utf-8?B?RGNwRXhMQmpZMWM5Uk44d1dhaWxtWVJNN3NKRkJrN0ExNU84YXl3Y2JTNVhU?=
 =?utf-8?B?M2l3eWtaeEIzTGtSZiszSitBajRaVkFUTzhRaFJJUEJQM3pCTHdISGFEOUZs?=
 =?utf-8?B?b1FRUVVVYXlWM2orcmFBeW1ySXZUS0cvb003NDRkZ3hCYWxQdmk3WkNVNFQ2?=
 =?utf-8?B?b0o0d3A1Z2NhbUoyL1hoSGgzL3NXT0ZUdjV0cEo2NVNNWi8zZnNhSTRLL0t4?=
 =?utf-8?B?bERVbXVDTzgrQmRIbDhScGJ3OTRBTHByNHNQZlRndzU3aG8xVzRsbWVsVlJQ?=
 =?utf-8?B?eFY3cEJNcnowTGJxQXZnVkNFOU9ucVZyZm9GU0NZUFFmQUp5U011eTZqa2RD?=
 =?utf-8?B?bjFNT0NqSUZuNFZac3FpMElRZndETHVBQlpoWjBYSSsrTGtyVnVnZkU3dnRx?=
 =?utf-8?B?MzNnS09KSmpIeTI3QTlrSnhRaTY2QUNMNmc2azd0bUhOL3N5QmM3YVpaSGNk?=
 =?utf-8?B?SWZqMnI4d0hxakFlRlpKd0ozS2FwY2E3NHRGMzYrUmQ5cUgzMHFseXFBZkd6?=
 =?utf-8?B?OVJBaVpTR2I2NEhMQTRhaEZNdSt6MzN0L2d0TE1OditKZFZJOHE4UHIreGJG?=
 =?utf-8?B?c0hRdVQyZWRkRERrc1BNdkQ4c3h3NlpkcGZPWC94WUdEMmpwM1hUTFpad0Rx?=
 =?utf-8?B?OFN1ZWY0NzUzNk5qUnJhR0FvVko3dkdZUWdEVmxScWpmSU9FMGtPakZ5dVhT?=
 =?utf-8?B?eUVKdkV5cmZnd2t0ZUNpLzk2VmtHTjg0eGxEN2ZOUGhIaHN3TG8yb2Jzd2cy?=
 =?utf-8?B?MUFMTkpSVEFVUk5TakMxRkZrK2FtMm9sOGdaMDROY0c3WkdUa04yWXpiMUd2?=
 =?utf-8?B?TXY3R2x0djBJaFVOUmZ4N1BFSFBYeVlpMXpPeGd5STl5NTk1V2xUYjhGdXB0?=
 =?utf-8?B?Wkc2NGFPdndSdlp6VWpNeUp5UmVMWDdZOS91aEg3VGpMeVFic0NZU1NNYUZC?=
 =?utf-8?B?TjdwdWJZbU5HLzBabUxwTk5yamFJTW5mQnowdDhaMU8zeEY2cmNYdnZSZGtU?=
 =?utf-8?B?YjAxN3p0ZmhLb0MxQXhmT0hiVElyT0RCYnl5SGNRdzRnNlhqck5OTms1ajVl?=
 =?utf-8?B?akhFaDIxZlo3ejVYWFBOV0FrUWR6eS9WVE5HNVdXemFrYitBdktzR2VMRkI2?=
 =?utf-8?B?YXlLTTZNOE5peG1TNDRQblNGN1h2SzZxZDZUNEhUNzZvRGVMTy9ZaTkrUWVE?=
 =?utf-8?B?SFJVdzVHRStiUEYrWXFmOS82ZkpFdDJ1eU1wVWJyc2ZYNVpNTVg1OWhwcWZD?=
 =?utf-8?B?YVFUUUtLNFU1R3lrK01YY042TFJ6bVBVY1NlZVcrWXd0UHV6aERWeE8rdjJj?=
 =?utf-8?B?OGZHa3dJRXdadldPajFsT2Z3Y2c1VXd4dTNWNmZqNm0zOCtYN2lWRXlpWTFO?=
 =?utf-8?B?VFhBbWVPVkNaSHo3UDliMmNFS0NDaEQrM1JKR1BEYjMyRVpCeS9JcUxMSGlW?=
 =?utf-8?B?ekxDOXl1U09WRllvcTlteTdqSlUwY3JiNE1Id1NWVUFka3VGb0wxY1M4T3NV?=
 =?utf-8?B?N1JMZ1Z0UlhlSkV1M0lTYW8vY01xM2ZPaXFqMzc1RW1SUDUvcERKZlNCODdt?=
 =?utf-8?B?U1I4b2dqY3FndWFjSGwwTVNIWVFjZXlrck5pTGI5ZlZ5cUxaNG5VcFppOS9j?=
 =?utf-8?B?QTJjUTBkdkF6RHdqTDBCL1U3WWIxYmo0ZmRwaWRoSE53YkVUeVRONlVneW45?=
 =?utf-8?B?THRnOUJoQ3laTGxBTzVRRnJsT2hONXFoV1RGcmtBdEFVZFpRZW95ckxFVEg2?=
 =?utf-8?B?QXFBandDUldaYmF0TmJnRlEwYTZ0SkthMmswN3hscVhCSzY2clBiSFZ3aVNy?=
 =?utf-8?B?NGJac1RHU2xOREltMmhUa09Ec2FPN0JSeGU2YjVrUFB1UGZOdzhkbFVnT0ov?=
 =?utf-8?B?d3pVUU96dHFkU2RsSXMwMFUxNUExRkYyYVNIQVAyaTJ1TVFnS1R0NW1zMzN4?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F82A20E2526D4399B23FE73A74928D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4555482a-77dd-472a-e8db-08dd45ce0e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:44.0870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAcLIX/vH2TjUuSVK/1Ylu9Y0U2joWUdydlAzgNR9TSqMH+W79MwshawnE+VPqWR8qxcKM6Fvkw1y8GDxT0d7eZE6vlbG6a52ZojKvLxyHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

QWNjb3JkaW5nIHRvIHRoZSBTZWN0aW9uIDIuMy45IG9mIHRoZSBEZXZpY2UgVHJlZSBzcGVjaWZp
Y2F0aW9uIFswXQ0KdGhlIGZvcm1hdCBvZiB0aGUgdmFsdWUgb2YgdGhlIGRtYS1yYW5nZXMgcHJv
cGVydHkgaXMgYW4gYXJiaXRyYXJ5DQpudW1iZXIgb2YgdHJpcGxldHMgb2YgKGNoaWxkLWJ1cy1h
ZGRyZXNzLA0KcGFyZW50LWJ1cy1hZGRyZXNzLCBsZW5ndGgpLg0KV2hlcmU6DQoqIFRoZSBjaGls
ZC1idXMtYWRkcmVzcyBpcyBhIHBoeXNpY2FsIGFkZHJlc3Mgd2l0aGluIHRoZSBjaGlsZCBidXPi
gJkNCiAgYWRkcmVzcyBzcGFjZS4gVGhlIG51bWJlciBvZiBjZWxscyB0byByZXByZXNlbnQgdGhl
IGFkZHJlc3MgZGVwZW5kcyBvbg0KICB0aGUgYnVzIGFuZCBjYW4gYmUgZGV0ZXJtaW5lZCBmcm9t
IHRoZSAjYWRkcmVzcy1jZWxscyBvZiB0aGlzIG5vZGUNCiAgKHRoZSBub2RlIGluIHdoaWNoIHRo
ZSBkbWEtcmFuZ2VzIHByb3BlcnR5IGFwcGVhcnMpLg0KKiBUaGUgcGFyZW50LWJ1cy1hZGRyZXNz
IGlzIGEgcGh5c2ljYWwgYWRkcmVzcyB3aXRoaW4gdGhlIHBhcmVudCBidXPigJkNCiAgYWRkcmVz
cyBzcGFjZS4gVGhlIG51bWJlciBvZiBjZWxscyB0byByZXByZXNlbnQgdGhlIHBhcmVudCBhZGRy
ZXNzDQogIGlzIGJ1cyBkZXBlbmRlbnQgYW5kIGNhbiBiZSBkZXRlcm1pbmVkIGZyb20gdGhlICNh
ZGRyZXNzLWNlbGxzDQogIHByb3BlcnR5IG9mIHRoZSBub2RlIHRoYXQgZGVmaW5lcyB0aGUgcGFy
ZW504oCZcyBhZGRyZXNzIHNwYWNlLg0KKiBUaGUgbGVuZ3RoIHNwZWNpZmllcyB0aGUgc2l6ZSBv
ZiB0aGUgcmFuZ2UgaW4gdGhlIGNoaWxk4oCZcyBhZGRyZXNzDQogIHNwYWNlLiBUaGUgbnVtYmVy
IG9mIGNlbGxzIHRvIHJlcHJlc2VudCB0aGUgc2l6ZSBjYW4gYmUgZGV0ZXJtaW5lZA0KICBmcm9t
IHRoZSAjc2l6ZS1jZWxscyBvZiB0aGlzIG5vZGUgKHRoZSBub2RlIGluIHdoaWNoIHRoZSBkbWEt
cmFuZ2VzDQogIHByb3BlcnR5IGFwcGVhcnMpDQoNClRoaXMgZGVzY3JpcHRpb24gbWF0Y2hlcyBj
b21tZW50cyBpbiB0aGUgb2ZfYWRkciBzb3VyY2UgY29kZS4gQnV0DQphY3R1YWwgaW1wbGVtZW50
YXRpb24gZG8gbm90IG1hdGNoIHRoZSBzcGVjaWZpY2F0aW9uLg0KJ29mX21hdGNoX2J1cycgY2Fs
bCByZXR1cm5zIGFkZHJlc3MtY2VsbHMgYW5kIHNpemUtY2VsbHMgb2YgdGhlIHBhcmVudA0KZGV2
aWNlLiBUaGF0J3Mgd2h5IHRoZSBmb2xsb3dpbmcgY2FsbHMgd2VyZSB1c2VkIHRvIHJlY2VpdmUg
YWRkcl9jZWxscw0KYW5kIHNpemVfY2VsbHMgb2YgdGhlIGN1cnJlbnQgZGV2aWNlOg0KLSBvZl9z
aW1wbGVfYWRkcl9jZWxscw0KLSBvZl9zaW1wbGVfc2l6ZV9jZWxscw0KDQpUaGlzIGZpeCB3YXMg
dGVzdGVkIG9uIFJQSTUgYm9hcmQgd2l0aCBib3RoIGRldmljZSB0eXBlczogZGlyZWN0bHkNCmNv
bm5lY3RlZCAoZS5nIFNlcmlhbCkgYW5kIGNvbm5lY3RlZCBvdmVyIFBDSWUgKGUuZyBldGhlcm5l
dCkuDQoNCkZvciBleGFtcGxlIHdoZW4gZG1hX3JhbmdlcyBhcmUgcGFyc2luZyB0aGUgZm9sbG93
aW5nIGRldmljZSB0cmVlDQpzdHJ1Y3R1cmU6DQovIHsNCglwY2llMjogew0KCQkjYWRkcmVzcy1j
ZWxscyA9IDwzPjsNCgkJI3NpemUtY2VsbHMgPSA8Mj47DQoJCS8vIDY0R0Igc3lzdGVtIFJBTSBz
cGFjZSBhdCBQQ0llIDEwXzAwMDAwMDAwDQoJCWRtYS1yYW5nZXMgPQ0KCQkJICAgPDB4MDIwMDAw
MDAgMHgwMCAweDAwMDAwMDAwDQoJCQkgICAgMHgxZiAweDAwMDAwMDAwDQoJCQkgICAgMHgwMCAw
eDAwNDAwMDAwPiwNCgkJCSAgIDwweDQzMDAwMDAwIDB4MTAgMHgwMDAwMDAwMA0KCQkJICAgIDB4
MDAgMHgwMDAwMDAwMA0KCQkJICAgIDB4MTAgMHgwMDAwMDAwMD47DQoJCXJwMTogew0KCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8Mj47DQoJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCgkJCWRtYS1yYW5nZXMg
PQ0KCQkJLy8gaW5ib3VuZCBSUDEgMXhfeHh4eHh4eHggLT4gUENJZSAxeF94eHh4eHh4eA0KCQkJ
ICA8MHgxMCAweDAwMDAwMDAwDQoJCQkgIDB4NDMwMDAwMDAgMHgxMCAweDAwMDAwMDAwDQoJCQkg
IDB4MTAgMHgwMDAwMDAwMD4sDQoNCgkJCS8vIGluYm91bmQgUlAxIGMwXzQweHh4eHh4IC0+IFBD
SWUgMDBfMDB4eHh4eHgNCgkJCSAgPDB4YzAgMHg0MDAwMDAwMA0KCQkJICAweDAyMDAwMDAwIDB4
MCAweDAwMDAwMDAwDQoJCQkgIDB4MCAweDAwNDAwMDAwPiwNCg0KCQkJLy8gaW5ib3VuZCBSUDEg
MHhfeHh4eHh4eHggLT4gUENJZSAxeF94eHh4eHh4eA0KCQkJICA8MHgwMCAweDAwMDAwMDAwDQoJ
CQkgIDB4MDIwMDAwMDAgMHgxMCAweDAwMDAwMDAwDQoJCQkgIDB4MTAgMHgwMDAwMDAwMD47DQoJ
CX07DQoJfTsNCn07DQoNClNvIHdoZW4gd2UgcGFyc2UgcmFuZ2VzIG9uIHJwMSAtICNhZGRyZXNz
LWNlbGxzIG9mIHRoZSBycDEgbm9kZSBzaG91bGQNCmJlIHRha2VuIGludG8gYWNjb3VudC4NCklu
IHRoZSBwcm92aWRlZCBleGFtcGxlIHdlIGhhdmUgdGhlIGZvbGxvd2luZyBmb3JtYXQ6DQpwY2ll
MjoNCiAgICNhZGRyZXMtY2VsbHMgPSA8MHgzPjsNCiAgICNzaXplLWNlbGxzID0gPDB4Mj47DQog
ICBkbWEtcmFuZ2VzID0gPCBhZGRyX2hpIGFkZHJfbWlkIGFkZHJfbG8NCiAgICAgICAgICAgICAg
ICAgIHRyYW5zX2FkZHJfaGkgdHJhbnNfYWRkcl9sbw0KCQkgIHNpemVfaGkgc2l6ZV9sbz47DQoN
CnJwMToNCiAgICNhZGRyZXMtY2VsbHMgPSA8MHgyPjsNCiAgICNzaXplLWNlbGxzID0gPDB4Mj47
DQogICBkbWEtcmFuZ2VzID0gPCBhZGRyX2hpIGFkZHJfbG8NCiAgICAgICAgICAgICAgICAgIHRy
YW5zX2FkZHJfaGkgdHJhbnNfYWRkcl9taWQgdHJhbnNfYWRkcl9sbw0KCQkgIHNpemVfaGkgc2l6
ZV9sbz47DQoNCm9mX2dldF9kbWFfcmFuZ2Ugc2VhcmNoZXMgZm9yIHRoZSBmaXJzdCBkZXYgd2l0
aCBkbWFfcmFuZ2VzDQphbmQgdGhlbiBleGVjdXRlcyBvZl9tYXRjaF9idXMgd2hpY2ggZm9sbG93
cyBieSBjb3VudF9jZWxscyBjYWxsDQpmb3IgYm90aCBkZXZpY2UgYW5kIHBhcmVudC4NCg0KY291
bnRfY2VsbHMgY2FsbGJhY2sgcmV0dXJucyAjYWRkcmVzcy1jZWxscyBmb3IgdGhlIHBhcmVudCBk
ZXZpY2UgdG8NCnRoZSBjYWxsZXIuDQpTbyBpbiB0aGUgcHJvdmlkZWQgZXhhbXBsZSBhZGRyZXNz
IGNlbGxzIHNob3VsZCBiZSByZXR1cm5lZCAyIGZvciBycDEsDQpidXQgd2UgZ2V0IDMgd2hlbiB1
c2luZyBjb3VudF9jZWxscyBjYWxsYmFjay4NClRoaXMgYnJlYWtzIGFkZHJlc3MgdHJhbnNsYXRp
b24gYW5kIHdhcyBmaXhlZCBpbiB0aGUgcHJvdmlkZWQgcGF0Y2gNCmJ5IHVzaW5nIG9mX3NpbXBs
ZV9hZGRyX2NlbGxzIGNhbGwuIFdoaWNoIHdpbGwgcmV0dXJuIGNvcnJlY3QNCmFkZHJlc3MtY2Vs
bHMgZm9yIHRoZSBub2RlLiBUaGlzIG1hdGNoZXMgdGhlIHJlcXVpcmVtZW50cyBvZiB0aGUNCmRl
dmljZS10cmVlIHNwZWNpZmljYXRpb24uDQoNClswXSBodHRwczovL3JlYWR0aGVkb2NzLm9yZy9w
cm9qZWN0cy9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24vZG93bmxvYWRzL3BkZi9sYXRlc3QvDQoN
ClNpZ25lZC1vZmYtYnk6IE9sZWtzaWkgTW9pc2llaWV2IDxvbGVrc2lpX21vaXNpZWlldkBlcGFt
LmNvbT4NClJldmlld2VkLWJ5OiBWb2xvZHlteXIgQmFiY2h1ayA8dm9sb2R5bXlyX2JhYmNodWtA
ZXBhbS5jb20+DQotLS0NCg0KIGRyaXZlcnMvY29yZS9vZl9hZGRyLmMgfCA4ICsrKystLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY29yZS9vZl9hZGRyLmMgYi9kcml2ZXJzL2NvcmUvb2ZfYWRkci5jDQpp
bmRleCBiM2IzZDdjY2RkLi40YTMyMWE4MjYzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jb3JlL29m
X2FkZHIuYw0KKysrIGIvZHJpdmVycy9jb3JlL29mX2FkZHIuYw0KQEAgLTM3NCwxNiArMzc0LDE2
IEBAIGludCBvZl9nZXRfZG1hX3JhbmdlKGNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqZGV2LCBw
aHlzX2FkZHJfdCAqY3B1LA0KIAl9DQogDQogCS8qIEdldCB0aGUgYWRkcmVzcyBzaXplcyBib3Ro
IGZvciB0aGUgYnVzIGFuZCBpdHMgcGFyZW50ICovDQotCWJ1c19ub2RlID0gb2ZfbWF0Y2hfYnVz
KChzdHJ1Y3QgZGV2aWNlX25vZGUqKWRldik7DQotCWJ1c19ub2RlLT5jb3VudF9jZWxscyhkZXYs
ICZuYSwgJm5zKTsNCisJbmEgPSBvZl9zaW1wbGVfYWRkcl9jZWxscyhkZXYpOw0KKwlucyA9IG9m
X3NpbXBsZV9zaXplX2NlbGxzKGRldik7DQogCWlmICghT0ZfQ0hFQ0tfQ09VTlRTKG5hLCBucykp
IHsNCiAJCXByaW50ZigiQmFkIGNlbGwgY291bnQgZm9yICVzXG4iLCBvZl9ub2RlX2Z1bGxfbmFt
ZShkZXYpKTsNCiAJCXJldCA9IC1FSU5WQUw7DQogCQlnb3RvIG91dF9wYXJlbnQ7DQogCX0NCiAN
Ci0JYnVzX25vZGUgPSBvZl9tYXRjaF9idXMocGFyZW50KTsNCi0JYnVzX25vZGUtPmNvdW50X2Nl
bGxzKHBhcmVudCwgJnBuYSwgJnBucyk7DQorCWJ1c19ub2RlID0gb2ZfbWF0Y2hfYnVzKChzdHJ1
Y3QgZGV2aWNlX25vZGUgKilkZXYpOw0KKwlidXNfbm9kZS0+Y291bnRfY2VsbHMoZGV2LCAmcG5h
LCAmcG5zKTsNCiAJaWYgKCFPRl9DSEVDS19DT1VOVFMocG5hLCBwbnMpKSB7DQogCQlwcmludGYo
IkJhZCBjZWxsIGNvdW50IGZvciAlc1xuIiwgb2Zfbm9kZV9mdWxsX25hbWUocGFyZW50KSk7DQog
CQlyZXQgPSAtRUlOVkFMOw0KLS0gDQoyLjM0LjENCg==
