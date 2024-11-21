Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C92D6ED26
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 13:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98F48968F;
	Thu, 21 Nov 2024 14:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="FZ59PH9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8608F89672; Thu, 21 Nov 2024 14:10:02 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBCC89765
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erQCVWrY69M0v2CZK/1paQ8B4zczrxv5zOjOCsXc7t+gpzv9zIrdUeoBIZJQXw0Ps26i3wMzp4s2MBPrlbOo1bpOQd1w38c/391fPpRz5G+OFv6rmEsjUYb1H6phKD7+QKi6SI2qb9Tcex1xYaZiU8+4NvpuXmUBOJuqwsRBqoXCDiECvhCVjzkrDzwQT1mt0JmFUBCjz+zEoFTm9KSQCI5Arsi9SnGk5SD/miMQAlUvjFyJKbvo7xOJI0lGDj861HK4c5Vf1Bg+tG6tvQcChRC1+MAPgYNcW5X/zDjo8/4/4RaEymZ7Z9JArMQAA+Pk7EOKpKlZlZxvfTHTFEXPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qulQ6l1//TOvFDnIyu8MmVxW3i6z19qqezVK/N1KFvA=;
 b=gpibLxls/Kade3n9jOsWSGb2SsNdpJrTFxlsKCpnsIxb7SYQQ+cPLOJTTmcoOG/6Ob6s9qlrS0nRyuJ2AvrvwD00z2XMSqE7LOlIszPb6q5SPDWNL1BAAEd5Kgv+Z5O7rhaVjfjF+htZdA0fSp4JQDPLVwqnYkCvciR17MLVZdYz/Rvcu2DQK1MeZEYwH46eY6xQMidBrq/aBaXhZaE1s71+EyQSeSnUNu9xarbZ7wKG4KLQuIXW5dIxim/SozQTw3/bASv18UNJLPshVfeMpKs1ICvKbBK2uQUzSttgWaoSd5KPC5piazNIklbUVy9TeWhP2dgWDpboNdZfzqB82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qulQ6l1//TOvFDnIyu8MmVxW3i6z19qqezVK/N1KFvA=;
 b=FZ59PH9RY+o+wwH5iXpol/wkRW7xkW2cPHiZYhG8uWzmr89B80V7ya1uyQfvJyGoAS6cfBtq7NP+OcHthJ1h/yyGvYt5wjrNiLVmSopc4rdSGwpRed8ZFWn9UXC9PGNjRRXDYTTg22DYEg6mYluUPdCX5cqOfdytR0Ojt1r/lkAUXNZ3wnpxcCYTPiomN1ihyU/tZZCGbEvUVyByzo2bDhPvtv990frJDIzf+QfH1egKrN7qLqcLdDQG6O4EgKslHastiD2IbbgRo6CPo0D5k5LoUfCM6RUDJ43xtpLW+QHLcHwgjzygBOP+Ws7cgoALEgGHZR6w6jRbh+XkKxHLBA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB7664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:639::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Thu, 21 Nov
 2024 13:09:57 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 13:09:57 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "agust@denx.de" <agust@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v3 07/20] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Thread-Topic: [PATCH v3 07/20] siemens: imx8qxp-capricorn-u-boot.dtsi: fix boot
Thread-Index: AQHbO9Xkkpe4batwkEmSyTvtugc+pbLBtaYA
Date: Thu, 21 Nov 2024 13:09:57 +0000
Message-ID: <02b5793c043c3c64a587aa954adad753edb9db37.camel@siemens.com>
References: <20241121052601.72880-1-hs@denx.de>
 <20241121052601.72880-8-hs@denx.de>
In-Reply-To: <20241121052601.72880-8-hs@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB7664:EE_
x-ms-office365-filtering-correlation-id: 392f7362-1b59-445c-8198-08dd0a2dcc5e
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SmQyMXhaaks2VGlzUi9PVEpXVlYxOVJkdUIxbk5keEMxSmp0WnVycEhTOUVV?=
 =?utf-8?B?eVB5cWoydlRRZFVweGY3eW5YYXpIMWZJQkxvT1dnVnNQN0xZU1ZMUURNMHEv?=
 =?utf-8?B?UHFaOHV4NjYraDdBaGE3aGhORStSU0paUjhrQUhkbE5leTU2QlNzRGIvS3Fz?=
 =?utf-8?B?YVRHV0hoRnpzMCtieFdXckp4U1U4U2FHdzFwVUF4NnhoSDF6dnI1M3lkWGpr?=
 =?utf-8?B?N1M5NTdFSmxBS3lSNjJHcHc0SWJzc3ExWmxxQ0d4S1ZZYXB4Y29LRDh6b21V?=
 =?utf-8?B?TXF3bm55dHNHUVdTTUd1MEFWa3Y4bWpnZWJMZUZicFozOHRHalY4WWxlZWpz?=
 =?utf-8?B?cll0ZWhwajF0b2kwY0R4cXNEbTROM3huczNSdSs4azdWczRMd0ZYYnUzRFFN?=
 =?utf-8?B?bWt1cFE2RVlVTUNoNlJvUE9Db3lqV2dVRldVTXpBQkVndXhQVk1PdUp1MmhR?=
 =?utf-8?B?dnZpVFFLMHRWSFIzYUo5by9DN3dPNTBqWHBKb285OW9CaXFkZHdOdUxseW85?=
 =?utf-8?B?cTNIRWwrQzcrYVRnbnN4UWZDK1ZtaTZaUmpTOTdybmJ2bWJCdjZNS1JQcnk1?=
 =?utf-8?B?ZXlUbTAzZmFyWU5aSGo2QWo1RFY2cmJaREFRT0sxWmVWbklaTnlDMzR4K2NK?=
 =?utf-8?B?QlRyR1hkSngvRnVBeXdRalV6bkNKZ3FKQytabVA2UjRyV2E5ajJDVzV5aEtv?=
 =?utf-8?B?S3RUREIwNmdpZ0lxOTlpNnQ1VjJ1NTdxdlN4czBNelZtSlozQnJwT1pBY3o3?=
 =?utf-8?B?RFpBSTcyRHFHOTN2emRFQTBpV2U4ZUZDa0xjR1BOdExIa20zc29wb0tsT3pB?=
 =?utf-8?B?ZjNsMTR1T21Xd3VHMnRDOTRtbjZidkg5NTZYWXhWYi9OUThBbDB3akliKzhW?=
 =?utf-8?B?d3gxZU44Y1BjZXlpODU4K3Vha3FZYitoSU9QOU1ET29KZEo4ZmVZS3BkcU5H?=
 =?utf-8?B?Q1lIRXpYNHI1S29BejQxWG55c3NDUFIvQzRtUjYvOHJzdkJoM1dMQlpBcmVB?=
 =?utf-8?B?UXFZdkdjTHVYTmk0b25UR0xTRGEvTGprK2V4SXRsbktGQTd4bzY5NTh4M1FN?=
 =?utf-8?B?aXptWGNzYmxIRDZlUlREVlF6eHVubDFVVVFxcHZJN2c4SjZnZkFtQm5CRHlM?=
 =?utf-8?B?OXpyM29vSEtEWlc2ZkFzRjBUaWhZcHVud2FnNWsrVWlYc0pLM1NDdmI2VG4z?=
 =?utf-8?B?M1JsZEIyVDJibGlyUTU2MmUvcTlVNS8zNE1GQnV3c3VQWW5OSmhPd3VwcXNq?=
 =?utf-8?B?UUJ5NWVyTmlLbzQ3bFFZRCtzRHpyYWJHMzZTUmU2VGVVcjJVWGtNMXdHRHcx?=
 =?utf-8?B?NFVWWTl5dFlZV3FNalZSOUxZWVVUN3dnbktoQW5qTG9jWERsMjBXUkZjaXU5?=
 =?utf-8?B?eG9BeVhtNHVyRERZMTBaWGp6TSs5bjM5YzZKYlVValRtNWtFaFlvYnVyemJi?=
 =?utf-8?B?c2pZeW1mWm4zQWFDeDJCbURtc1QrSXdwR0YzK09QWDBJWjIxTVFaM2JudVA4?=
 =?utf-8?B?c0FuVE5LK2ZMaE1ZMjZVTW1Bd3JKMlkvUWZpUVFTVzg0YzRPS04xS2dEZlNj?=
 =?utf-8?B?bG5GTGlZc1RlS0srdzlNWWF2cjFmajdBbmF0TTA3UHY4NlJObnpIdm15Q3Ux?=
 =?utf-8?B?dlhPZXJzdVhmd0FZcjhJakJzYW9CUVd3ZHpTMSt0blBnSHliS0ZVTmwyQXdl?=
 =?utf-8?B?aGRMOXR6aDQxYjY3V3RYeUZXcnRrZllOMFcrejNaSnRFSFJHenNJY1dBTERn?=
 =?utf-8?Q?ncYzi0uTcK6PG1/uK7JrP05S466GPK/nFvsQHsI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZuL0E4OHljdWxaTlBrL1E0S1ZFNnArclE3MTkxbHNDYlRiUnFub2wvMnQz?=
 =?utf-8?B?Zm5BU21UTUFOQ0lQOENxRS9LMnVhdFkyYXpvY2ZIQWdkcXd6dTNBSjN3cFlh?=
 =?utf-8?B?dUVLaEVWeEY4T1dTOEdQTGk5STNPc3NQMWMzZk9RZDltN3lqMnBiQ0RkRHla?=
 =?utf-8?B?c1p6N1NtTm9sV3l0VFcvNHZHQndaWDJzUkcvZE5vSXMxUkVQbU9pd0h6QTRs?=
 =?utf-8?B?NHRqbFR6WlZaeUhMRFZTNld2MXEyNkY1VUNLemtKcHAwWlZReWQ1TTluNFRS?=
 =?utf-8?B?ZzR6cFlGaXlUNWRiZDZmUWhjM3k3aXQ5bHA4UlJrMzVWbWNLYStBN285Nzdq?=
 =?utf-8?B?cFZMa3orMVFVY0dsUE9wMzlBaDMwdTVmMGl4Vk5xS0dUUzhvdmJYRyszeGEx?=
 =?utf-8?B?K3IxWTZKTkdza3ExdE1JZG4vMTJKeDlQMUhyY1p2c05PaXh1MmU4RWVCMFAr?=
 =?utf-8?B?dEV2SVFsYkwwbkpQSXNONWMxOVZqcWJsTTQrSVRhUkh0RWNpcW1SKzR0MU81?=
 =?utf-8?B?VXEzYUFUby9aT0l3Zjd1STV2b2hkNFAxTWg5cTliTEJZc3BILzFxMit5R2U2?=
 =?utf-8?B?bnBUL0xHQWIyOEsyVkN6ZFdaTFZvM3Vjd3NBaElBVWZIU0ZrWldlT3hSZnZX?=
 =?utf-8?B?eHUxcVlDMmlpL242OXRYVUZBRHVoM3BsWmgxeDNhV2k1TDhGdWgzR1F0eEEx?=
 =?utf-8?B?L0cvRlg3MS9xSytMMlNwb1JFTEYxNG02bWhrSXM5ZDh1dFFFdm0zK3NQLzF6?=
 =?utf-8?B?NGVVQUo0NzZ5eVRON2R2SHhrT0NPTzlWa0dycGdKUmtmaG5qdkZHV0ZIblBB?=
 =?utf-8?B?VEZTSlJlTzFrSlBudHd4UGloS3BXemVMV3B1TWxhdHNzRHNsaVV3M0wwZFo4?=
 =?utf-8?B?OFl1clVJcXJSQ1VtejI2aTBiajJGOXp4a1d5VEorQjJYcThCdWphaklKMHFh?=
 =?utf-8?B?NjUzT2l5OFJCUmNYNjFNSHh0Qk1tTHYyZEZMODNucjZaL2JDZjJmMlRkSFVU?=
 =?utf-8?B?aG5WUk5walFZRDdkcHpJMlhmUEFMeVJLZ1R0VnBXTSsreTBVYnZ2UzE2L0R3?=
 =?utf-8?B?NEJVL3ZzejlUam11S28yV3BQSmNTd25zL3kya2FiVFdMMkY0MS9mL0VZajRy?=
 =?utf-8?B?U2xxK2lYWW9sSjY5Q3VIcExFTkdCaHREWFVOSGY4NmdpanN5UHFmSmlGWDNv?=
 =?utf-8?B?MnJCWVVlOGorZVJ4OHUwY2dXUThrWTlCZFVVdDQrSE9xOTdpbWxHbnp0aksr?=
 =?utf-8?B?OVUzV0RjWDh3UjFzTXBjMkdJUHltT1VqZG1Gdkw3aGhhbnJoZThRU0E4WEpy?=
 =?utf-8?B?YXBjT2t3d1A0M0I1RGxzdS9RWG1DSFo4SUNyTjY2VFdCaWYxeGdyKzJRcnln?=
 =?utf-8?B?YkJrMnNBWHZQUG5YaEU2aVZXM21IZkYrS1F3LyswYmZnalpYODJZYlN5dUV6?=
 =?utf-8?B?ZHN1Zm5TYndqdlNEbzEvUHNQekM1bVluRXduelIyNDBSM0NnZkFZSThkNHQz?=
 =?utf-8?B?OHJJUWdFNGdMMW9mUThQTU9mMzV0Nlh3MkVzV2hkN2JwcXBCMHVGMkJXUDlx?=
 =?utf-8?B?eHlCaTlMSFRWOGwwZklPQi9oL1dWTll2aXdQTUs0LzA4YjhtRk0ya0JhRVpD?=
 =?utf-8?B?UlVDSjZZZ0FoaWR0WHdwMEpFbG4rMkxGaHk2ZGo3azB6YWlBKzZSQ3NMQVM3?=
 =?utf-8?B?YlF2Q3ZKSUlYUjBSZ0ZMTUgwZUIyaE1Oc0Mvc09kWCs3Vm9oRWRGbE1zWFM2?=
 =?utf-8?B?RUsyaG80WVNSV0VINXpLcjVTOVhFOHJXa0JnaEk3bnYxdllQTW9DeUg0bWMv?=
 =?utf-8?B?amgvM1cyeHhCVDNKNmluT2lrN2NYMDVOeTFJVUpRZHhqV3RXUGpzeWFtNkNt?=
 =?utf-8?B?bHVYTUFRaW5zWGdXMVNzSURJUjNKcXNJLzYwSmdyTDVZNmNUYVN0WVdmVFND?=
 =?utf-8?B?VEZLbGMrU0tCbDVvc28wQ3h2SjlkN0FXL2tYNkdyMnZPeDBXdTU1RDRieHFY?=
 =?utf-8?B?bVNOdUhZZHBMWTZnS21nY3dtSHZxYlpOYWwzc0hyUUxpMm9MZHZqZ1BJSVhK?=
 =?utf-8?B?dXZidkIyYUVlR0lZUlBpdkhIWHFyVUt0LzVTYlVJNktmM0FVS2IrUjc1KzVv?=
 =?utf-8?B?MnN1Wmk1T0pwRVFIelpBdHdMaWNBaDVsQ2tWcFJYS2xiR3BaYlkxUjltRXZ3?=
 =?utf-8?Q?eV9WteNK52O1hWDJksmhP6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AC1A77DA0272840A87F4351940F3952@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f7362-1b59-445c-8198-08dd0a2dcc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 13:09:57.4630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nxxZPsxYxBushOiWafr6BYunygzJol73Iol/1Cs6Yu5cutYSOUd+NVd2V+4BYMtfZcB4omsy0Ziq9iNhhZPKW27fO231ovBuZDP7Kd5MXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7664
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

SGkgSGVpa28hDQoNCk9uIFRodSwgMjAyNC0xMS0yMSBhdCAwNjoyNSArMDEwMCwgSGVpa28gU2No
b2NoZXIgd3JvdGU6DQo+IGN1cnJlbnQgZ2VuZXJhdGVkIGZsYXNoLmJpbiBpbWFnZSBkb2VzIG5v
dCBsb25nZXINCj4gYm9vdCBvbiBjeGczIGJvYXJkLg0KPiANCj4gUmVuYW1lIGJvb3RwaC1wcmUt
cmFtIHRvIGJvb3RwaC1hbGwgc28gZmxhc2guYmluDQo+IGJvb3RzIGFnYWluIQ0KPiANCj4gQWRk
IHUtYm9vdCBzcGVjaWZpYyBjaGFuZ2UgKGFkZCBib290cGgtYWxsIHByb3BlcnR5KQ0KPiBpbiBB
MzVfMCBub2RlIHRvIGlteDhxeHAtY2Fwcmljb3JuLXUtYm9vdC5kdHNpDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBIZWlrbyBTY2hvY2hlciA8aHNAZGVueC5kZT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhh
bmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0K
PiANCj4gKG5vIGNoYW5nZXMgc2luY2UgdjIpDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIGFk
ZCAiYm9vdHBoLWFsbCIgaW4gQTM1XzAgbm9kZSB0byB1LWJvb3QuZHRzaSBub3QNCj4gwqAgaW4g
ZHRzIGZvciB0aGUgYm9hcmQhDQo+IA0KPiDCoGFyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi11
LWJvb3QuZHRzaSB8IDY3ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vZHRzL2lteDgtY2Fwcmljb3JuLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRz
L2lteDgtY2Fwcmljb3JuLXUtYm9vdC5kdHNpDQo+IGluZGV4IGNiYTU2MTg4Zjg2Li5hZDUzMDli
ZDk2OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDgtY2Fwcmljb3JuLXUtYm9vdC5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4LWNhcHJpY29ybi11LWJvb3QuZHRzaQ0KPiBA
QCAtNiwxMzAgKzYsMTMzIEBADQo+IMKgI2luY2x1ZGUgImlteDhxeHAtdS1ib290LmR0c2kiDQo+
IMKgDQo+IMKgJnsvaW14OHF4LXBtfSB7DQo+ICsJYm9vdHBoLWFsbDsNCj4gK307DQo+IMKgDQo+
IC0JYm9vdHBoLXByZS1yYW07DQo+ICsmQTM1XzAgew0KPiArwqDCoMKgwqDCoMKgwqAgYm9vdHBo
LWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZtdSB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJ
Ym9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZjbGsgew0KPiAtCWJvb3RwaC1wcmUtcmFt
Ow0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmaW9tdXhjIHsNCj4gLQlib290
cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2xzaW8g
ew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4g
wqAmcGRfbHNpb19ncGlvMCB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsN
Cj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9sc2lvX2dwaW8xIHsNCj4gLQlib290cGgtcHJlLXJhbTsN
Cj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2xzaW9fZ3BpbzIgew0KPiAt
CWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRf
bHNpb19ncGlvMyB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9
Ow0KPiDCoA0KPiDCoCZwZF9sc2lvX2dwaW80IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwli
b290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2xzaW9fZ3BpbzUgew0KPiAtCWJvb3Rw
aC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRfbHNpb19n
cGlvNiB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDC
oA0KPiDCoCZwZF9sc2lvX2dwaW83IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgt
YWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2RtYSB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+
ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9kbWFfbHB1YXJ0MCB7DQo+IC0J
Ym9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZwZF9k
bWFfbHB1YXJ0MiB7DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9
Ow0KPiDCoA0KPiDCoCZwZF9jb25uIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgt
YWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJnBkX2Nvbm5fc2RjaDAgew0KPiAtCWJvb3RwaC1wcmUt
cmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmcGRfY29ubl9zZGNoMSB7
DQo+IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDC
oCZwZF9jb25uX3NkY2gyIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0K
PiDCoH07DQo+IMKgDQo+IMKgJmdwaW8wIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290
cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW8xIHsNCj4gLQlib290cGgtcHJlLXJhbTsN
Cj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW8yIHsNCj4gLQlib290cGgt
cHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW8zIHsNCj4g
LQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdw
aW80IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKg
DQo+IMKgJmdwaW81IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0KPiDC
oH07DQo+IMKgDQo+IMKgJmdwaW82IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgt
YWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmdwaW83IHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4g
Kwlib290cGgtYWxsOw0KPiDCoH07DQo+IMKgDQo+IMKgJmxwdWFydDAgew0KPiAtCWJvb3RwaC1w
cmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4gwqANCj4gwqAmbHB1YXJ0MiB7DQo+
IC0JYm9vdHBoLXByZS1yYW07DQo+ICsJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiDCoCZ1
c2RoYzEgew0KPiAtCWJvb3RwaC1wcmUtcmFtOw0KPiArCWJvb3RwaC1hbGw7DQo+IMKgfTsNCj4g
wqANCj4gwqAmdXNkaGMyIHsNCj4gLQlib290cGgtcHJlLXJhbTsNCj4gKwlib290cGgtYWxsOw0K
PiDCoH07DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVu
cy5jb20NCg==
