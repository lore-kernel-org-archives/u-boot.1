Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2D7C3DA49
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 01:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 004318811C;
	Wed, 24 Jul 2024 03:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Xk6L0mtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6353A88600; Wed, 24 Jul 2024 03:01:31 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C39787E9F
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9lMaJapRxx1WuVSYFFxNCQXNxUUyczYzcRkrUdHt2l6oDQ9gyO7iCZZH+/TyoHlFtgILy6QcbzplEk5Bv3UyNKCF55I78znVErBt3fzJMkf5Z4Hh5ZBeJhAxZYr6CrTKrNntclQl0fUyD6UPMMjExoRd39ITcF6qChrW01VHVwams19zuWAAs5qC9SKgRfk1RcP8wYkJugg1zLC4k2bjHuUe1MDUZAPOjbjQJ4lDhIpHeyTPwJEXqTuqJsDlFGlGNOsBRbI1zzOGly7NeCteA+EeLiC6j7ozZe6EgMBMvP/q4yYnLvQcVYJ5E5cqmnZOIFe0fJDkG7aqRZVvbkcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX2ZvdKlYhjOZ2P3AWxKlBI+rFZWmfJ9bkN1D4JASrU=;
 b=i/H6d2PQ17QYYMeLVUi44gu9RCbAiv3WCKamJHoArVSLUiA9N4r5WL/6tQ7vs5RP6pEY4vqCcsdHXsoh9ITAj3+MJvet5HoLw4t3G+kyJwHlxkCRProR+L+FZw4+uxHorBK9WbzViY/xtdNenTmN5NxK8r7Pkm3q2ivQo9E/x8sCWqm59iBN14L4z+MpVNQzcevd+z8NVjp2gJ4FGVU/zABTHdH48wuA9h3fLVMN+7x7OrXU+7a4nK136gKymy1KWwLX85LIex8WN3N5r/nwn04fS1VP9wb6mqVyFPiJ58DiOeKq/zKcBA3sHx3JkELEWEvF6VHWqsdC1lMs+Yjtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX2ZvdKlYhjOZ2P3AWxKlBI+rFZWmfJ9bkN1D4JASrU=;
 b=Xk6L0mtEH9GkSPAE6mWF1K0cHZ/Oq+JiuYSwQm6mOkQhnukN2LmShk1CFcMaGlymzQX5w+mkFSfZVNzCIxJiwJhRbR7m0oI5lS8N3dzkjDjrMz46HKPSJoSocBJhKMUbbBv8Dq0GtnPJKY3nDL0pLJGCVVxYWouj/cANRF7BwhI=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by DU4PR04MB11054.eurprd04.prod.outlook.com (2603:10a6:10:581::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Wed, 24 Jul
 2024 01:01:24 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 01:01:24 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org"
 <sjg@chromium.org>
Subject: RE: [PATCHv1 3/5] cmd: cpu: add release subcommand
Thread-Topic: [PATCHv1 3/5] cmd: cpu: add release subcommand
Thread-Index: AQHa3Q6skebeC/7OrEGxYubJjn9uTrIEZTuAgACmUEA=
Date: Wed, 24 Jul 2024 01:01:24 +0000
Message-ID: <DB9PR04MB9236608870B7A84AAB4E486084AA2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240723150400.16650-1-Zhiqiang.Hou@nxp.com>
 <20240723150400.16650-4-Zhiqiang.Hou@nxp.com>
 <CAOMZO5BUguY8vbw9gUux=jfZ312q5pAr3FA0YKq_wAQiCvfEfw@mail.gmail.com>
In-Reply-To: <CAOMZO5BUguY8vbw9gUux=jfZ312q5pAr3FA0YKq_wAQiCvfEfw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|DU4PR04MB11054:EE_
x-ms-office365-filtering-correlation-id: ab0e20b8-09c0-4776-973e-08dcab7c23ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0ZONXFSaG9PdUVQZStFQkZrcTVRL3lmVWFCWjlkSWdKTkdac3FKU2cwUXRj?=
 =?utf-8?B?ZGFnN1VieCtPdVRrZlhFUWk0WXpqZWxzVFdsNzFvQjllMm10dzhjcGFjeThS?=
 =?utf-8?B?Zmhrc3NUZnI5a01SbnZoM1dzN2N4bG1oTTYvRm14WkVRajZoay9BTEdQa2pK?=
 =?utf-8?B?b2hSYUFka0lMNnZqN3N0eTA4VWhhazVBNnZKdmJoMWc2b2RHOG03b0Q0MGxz?=
 =?utf-8?B?S3JnVEh2L2YzSk9XYXpUOWxtZk9OVVA4SlE3cVRQeUhvYmZuZEVYKzkrREhK?=
 =?utf-8?B?RndDWVhkVXpsakR4Q3lFaU00b3dXNDlnbWtlNlZ0L1ZPL2d4bHZILzh4Vzlw?=
 =?utf-8?B?MmhqaFdHUWdmY3hlKzNVdERJMkZuUmw3TkE5WTFLaTZpTjRqUVVFZ3VlaGxQ?=
 =?utf-8?B?aldFeldvNnpOaGtIMk5USUphV2RRZ3RTMkYzRGpMOXJwVnRQdXBuRFRnRUt2?=
 =?utf-8?B?NzVFR1FOWUZHQUpWYThuNHVZVTUyemp2MFVEdjNnRy9HWmJIRGl6WnlVbnlF?=
 =?utf-8?B?RzVqa2hncXRxQlN3a1BIWnBiSXVTZVVNSVNweUFDYTR3S2E2ZlBGNHA4eDBl?=
 =?utf-8?B?OGtPRXNXLzRhVTlsQ1c5cGVhUWowS1NDUk9EVlRpRkNndDdaVmljVlV6VUJx?=
 =?utf-8?B?U05YMTRMUk50WE1nK0FTVmk1cVdkZXNzSW5CdEFQRXFnZFBDRVJZbHZIaUZx?=
 =?utf-8?B?QmV2Mm5QdDBLR2llanlHS3RaSjZDbUhqTlVVcVczSmhJUUYxU0lDdy90aXZo?=
 =?utf-8?B?emcweGU3Q0tHUWVtbi9Zd0FkSUJBNi8wdnpPb2NWRzRzWTVjekpKdGhySFlC?=
 =?utf-8?B?bXRaWHZDSW5FZ0NjMlcyaU40dHVmUzBpb2EzS3lPVmpUc1ZYZm5mazRjbmwx?=
 =?utf-8?B?TUk0Y0l4V2oyZmwwbE1nanBFbG9kbFBiYkZYQ1loZEtzNFR2SmgxWGVHSldq?=
 =?utf-8?B?Qk1RdGpaZmZETHpDbVVPcENycStqZGlPWXV1bmovTEcyOUhWMUU4TDliMys2?=
 =?utf-8?B?OWFhMzJVNHlaTFVYTXBRT0ZYQjNzUk50Vy9ZcGxtaTlab2RkTmNxMzFVTklW?=
 =?utf-8?B?cEtacm04aGFjaEdoZzZzUmFOVG42SDdpQkxPLzA1ck9pdFVBL2JtaCtXWE1X?=
 =?utf-8?B?ekdMSld0dVhQeU5SdW1BbVBobVR1bnIrS1Z4TEZqZFJjUHlScWtEUlJqRlIx?=
 =?utf-8?B?Zmc0cG5KaWhSL0ZhSXcxTnVqNVhLV0h4ZkQ3YW5xWllIU29YWE1MTnJGWktW?=
 =?utf-8?B?UG9EWGdrWWFUb2p3UUFYQXJNbTEzeDBHUFJaYnpNdDZRaHJsQTRFNEVHT04z?=
 =?utf-8?B?N004ZkNHbUZmTW45VFBkSlp2Z2hOR0ErbkZkSVJEMHc4T1ozSG5HbmQ3dWtT?=
 =?utf-8?B?K2FTanNQQkZrM3FlUS85YUF5ZFBGTXdDemNPODdNcGxBK2REUDZlZXAyMU1H?=
 =?utf-8?B?Ym1kNHd5VWllVWF2T0RRZHB4MHNzZmhBOWh1czI4eHlKMjhSQnVqZTJmbEFP?=
 =?utf-8?B?dFpnTkdlaDhENzNQd2FmZTJvekU2YytuMTJ2NlZZN0szQ1JPUTBvMFZqc2hE?=
 =?utf-8?B?UDZMTkFpWW9QbWdwbW5HNEo1ei9rSjB4WThCQ016b2x4aytCeWJGRWZveHcx?=
 =?utf-8?B?eW5NK2N5VjIzaHhwNjM2bjR6bjRUejBGeUZrVjcxWVlRYnRBenp3cmRFU01C?=
 =?utf-8?B?QUQ4V0t2Y1RhMDFyT2xyRWxKRXV5cS9QcmpoNCszaWZ5ZVVWR0pZSVpGZHBm?=
 =?utf-8?B?UjVleDVkWlcxbW5zRGNSQVdrVHcvcTdFTGlTMkJJUHhLTkJTSHI2VUtjUC92?=
 =?utf-8?B?VXE0YWpGdHZWR1FYaVNGN2VEcWdNazhJNm04OHF1VXIzSEdLeGVTeUc5YjJl?=
 =?utf-8?B?OWJJd3N1TERBR1BEQWNGQ1p4L3I5cmprVW9kclNxekp2NVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2QwNjNvckJRVVhEUXNpajBzOG4yK1J5alYvcFBYbVZobFFvNUlEQVVtYWI4?=
 =?utf-8?B?SXBVdTd5c2xBbEhYYThZcmlHODN3K1d0RGVzNyt6Mmt2Z1YzSHJZYW51b2gw?=
 =?utf-8?B?Z05Oc3c3QklnbE1LMU9hMVlqN29rUUZQY3lYMlpYc09ES2JjRjZtQytPbzRU?=
 =?utf-8?B?ZFFnNnJwSC9Ed2NGeS9nQTJYdE5LQkJPRU9mU21sRWlZNXFNYnVIMTQ4ODlJ?=
 =?utf-8?B?WUwxT054dkxSR0xvQjVWWjdxWFZzd1I0Zk5KU1JFUWtTTnlnRENaZkkwaGEv?=
 =?utf-8?B?RjJXaDJHNEhRWWw0MUN3TjNGNG9XRTgvcEQzQVNtL25lQnltYzlZMjBrby9N?=
 =?utf-8?B?bmxUN0NGa0EyelJxYXN1ZVhCMGFoVFA4OEorNm9haTl5RWprcnNkVW5TcmFB?=
 =?utf-8?B?NzFmNjJaNkJjL2VSYk1aR2Z2b1gyaElHVVBIdE9QWHpnNzh2a25adW50UVRE?=
 =?utf-8?B?SFNGMDI1TU1uL3FnZWxGUlloVHdIRy9yL0hLTTUyblBoaU1Ec3RuYlpzbENT?=
 =?utf-8?B?U2R4MlVYVDRNYzI5M25QaXBQbWhBTzFmbHFRUlorRzUvbEt0UG85QU9xdUNT?=
 =?utf-8?B?aXF0RDhyQ3FYc3lTdmMzMFhWQkxpdFdKT05XSGFFN01KbTRZb0JieFpGbmhF?=
 =?utf-8?B?MGViT0ZHWmpVTFRDR0VrN2g1UGVGa0tTenNvb2E0OHN0SUJab0VrVXdSSStk?=
 =?utf-8?B?eU1Ia0pwdWNVYkRLNEUwSVlqbXNXZTZvcXN0RU1DMGQwdGxhU2ZhRUdkYmNn?=
 =?utf-8?B?TzUyZzhKRDlrTFd1K3I3allEL1UwMS9FMVpsaTJNQjllS2lZQUZ4UjNPUE1G?=
 =?utf-8?B?amJLZUd3eTNCaWppNUorbFJ1Z2JQNC9JNUoraEl0RkpPa05VMWtXSEtweHpW?=
 =?utf-8?B?VFUwOTR1Y0RsY1Nxa2Z2SFB0OWR6b3FvdEl1MmFRMVp1ZTNyc3NEdGNSM1l0?=
 =?utf-8?B?VjFBS1RNZmwwYWFhemNQaTU0MVlPRkNmMVgrZ1ZwazlBY0RaSHY3SmhNbGU2?=
 =?utf-8?B?VkViS0Vyd1dLSDVIKys5UFIvS2Y5ZksxVkVXQWdieWh4S0RKdkNQVmdDVFg5?=
 =?utf-8?B?NUxzYXUxTEs4ZE5tZ1BwMFkvL3NuY1hiK2pMN0dsdGF5OFJCQ3VSQ2FXcGNO?=
 =?utf-8?B?aDNFT3h4anUwei9pTFV6cnEvMWttKzlHTmZqc094SG9LRWx6WjZRL3pOR3JZ?=
 =?utf-8?B?eTc1M05YdjRqOWhTRE1Za3hubEhBV0syaVlmVC9uMW1ZMmxHY3pUN2o5TEtw?=
 =?utf-8?B?bDhnMHZUM0VTbE5JRERZa2lTVVNmVkU4WEhIUm50RVlvYU5JWVg2N0RhR3dZ?=
 =?utf-8?B?RUV5UkV5cUVYMnlmTUtJNnZVT3A5OWpOT1gxL2h4bHAwLzY2eVBQUm1SWkcx?=
 =?utf-8?B?UXkxbkVDS3pCb3F3OVpMOW41NlNNa2pXZnBydXVYMU9NRUY1VGRsNEFjZlN6?=
 =?utf-8?B?YjFRMCtVZk9ndkhMaVBmZ2ZUZEpXSCtzeGFmSXFvQlhtbGk2Z3RhRHpzMGpH?=
 =?utf-8?B?T0lVbDVkdjBuNkpsRkRTT3lNUFVzWHVub3A3eithRFVFYmdnNzZIYUs4TWVw?=
 =?utf-8?B?ZWM5WDVsQndwdUtCeUFmTGVjU3N3OFRoRTFBZ2FXa0lQcmNoc2UwZ3lldlkw?=
 =?utf-8?B?bXJhS2lSVGwzL3d2dEd1SVdwRFFlZWt2VEFOOVI0eVA3ZlBybjNLUm1iV3BE?=
 =?utf-8?B?OWJUUThWMFdBbjQxVE5CNjcycjVzdzZLVTl3MU8yZ2loZ2Q0aGhTQTV0UkdE?=
 =?utf-8?B?NTFBYVRUak1tZkdFeThmc0o2ZFdxWmtsQTVzM2d4c01ZMG1QZDEzMnYxRC95?=
 =?utf-8?B?bDdudGxHanNIZC96WGMrUVY2cFA2YUlDOExvTGUxY3JFQldGa3pIaitHbmt6?=
 =?utf-8?B?NWRpWElxOWVNRHNWTXNnR2lONzRGdzZzblBocG56VWY2WEFlMUNvTHptQnVF?=
 =?utf-8?B?RVJ4N3pldFVsb3QwMXRhUXRXUHJucnY0enR2TWxRYlZJS2ZERXIzSzJ3bFZX?=
 =?utf-8?B?YlN1eWc1MjVHSlh0di9KMUZjcTRhSXlVbVBZNURUSzlQOGhEcmlTOUdvUDFH?=
 =?utf-8?B?S1BjaUpDQW1nZFVMMlhYRzVaSGtwS2pibUlodlErRVdheTZPTk13UE9jeHJa?=
 =?utf-8?Q?r1HtOUpR7a/IdT3Kj8E+1q5Bg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0e20b8-09c0-4776-973e-08dcab7c23ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 01:01:24.5796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CCeWiF6axQwSoJZYEQvfm+4HBosTxBUJ//gSmdueSp6DO3k27sCsQx+5YtTjExC+TDD60Z2+1fbh/Zfn4nrPTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11054
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

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIzLCAy
MDI0IDEwOjUxIFBNDQo+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENj
OiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgdHJpbmlAa29uc3Vsa28uY29tOyBQZW5nIEZhbg0KPiA8
cGVuZy5mYW5AbnhwLmNvbT47IHNqZ0BjaHJvbWl1bS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SHYxIDMvNV0gY21kOiBjcHU6IGFkZCByZWxlYXNlIHN1YmNvbW1hbmQNCj4gDQo+IE9uIFR1ZSwg
SnVsIDIzLCAyMDI0IGF0IDExOjQz4oCvQU0gWmhpcWlhbmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGEgbmV3IHN1YmNvbW1hbmQgJ3JlbGVhc2UnIHRvIGJy
aW5nIHVwIGEgY29yZSB0byBydW4gYmFyZW1ldGFsIGFuZA0KPiA+IFJUT1MgYXBwbGljYXRpb25z
Lg0KPiA+DQo+ID4gRm9yIGV4YW1wbGUgb24gaS5NWDhNIFBsdXMgRVZLLCByZWxlYXNlIHRoZSBM
QVNUIGNvcmUgdG8gcnVuIGEgUlRPUw0KPiA+IGFwcGxpY2F0aW9uLCBwYXNzaW5nIHRoZSBzZXF1
ZW5jZSBudW1iZXIgb2YgdGhlIENQVSBjb3JlIHRvIHJlbGVhc2UsDQo+ID4gaGVyZSBpdCBpcyAz
Og0KPiA+ICAgICB1LWJvb3Q9PiBjcHUgbGlzdA0KPiA+ICAgICAgIDA6IGNwdUAwICAgICAgTlhQ
IGkuTVg/PyBSZXYxLjEgQTUzIGF0IDQxNTQ1MDQ2ODUgTUh6IGF0DQo+IDMxQw0KPiANCj4gV2hh
dCBpcyB0aGlzID8/IGFuZCB0aGlzIHN1cGVyIGhpZ2ggZnJlcXVlbmN5Pw0KDQpUaGUgaS5NWDhN
IFBsdXMgbmFtZSBpc24ndCBhZGRlZCB0byB0aGUgaW14OF9jcHUuYywgd2lsbCBhZGQgdGhlIGku
TVg4TSBzZXJpZXMgbmFtZXMuDQoNClRoYW5rcywNClpoaXFpYW5nDQo=
