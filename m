Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F0CE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 06:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15198005B;
	Mon, 16 Dec 2024 07:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wYcyNjOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453E080104; Mon, 16 Dec 2024 07:55:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714D18003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 07:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1dRlJ3obqVnMPJKf0B2dz72iZuZveRi/elYAE+oJK5hyBd8bVx114JkfJhG1azeMJijH1c+GGysXnekCQEKX26j/AjL5OWSbmH3FVk53R5f+RKpEaoWiug0UwkSk8aZtBoIL51H2ZjkYwDPZ15sKEnyll0BdYbCIZuixyPxSy6KZWNB2JacBF2lbYFsONylTxngWeLjAk5kfNXvc48VISnggyWA3t8mUCb/p2nqUok+uaWpLUC9DIDck6IcgGH4iU1hyRJXANsXD3d0FTRrrtceOSgO8lxYI74J9RDKUt86+bU+LvcahxNWgMHo0p/MRoZ24cKkoXeSODpG+bpRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/fL91XotobghlfJzKKpilj7xrQ5tYRe7FVfqZzTCak=;
 b=ecWt3oMdWrxdM1lPkI77mebj9inKsZoMr09eg9tyUvxP1Zh9L4vDcj90Z3vWIdpknIRwGbPNu5Jt+X3LrmMCC8pGlTXoFwi7fTQRtWbw8ErM0i6+9KkWLeqehmYfebWsHQIAeSTj0OMcK5gn0+g4uTLEGAKMx5AcSsBtMgX+DNHxF+4Mo/BKjJ5dxVC2RyTzMydguopzIOEQa8WvH3me+RnhJCIyVJo5fgUr/bmjjj4Ojo9TURAs2NDVzA5xDXT/PA3c42D/nfyIl1KNRbxJyZMF9uC6L3KvRWOTtKnO1cdnq8gpMOSJcna3R3DV805ig56hkp+n/4vZDIZzD/vpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/fL91XotobghlfJzKKpilj7xrQ5tYRe7FVfqZzTCak=;
 b=wYcyNjOO9kZdN0HsgMjGAMLja2RnAJQEza8p1ZAaSDTY/dlD9SzMojmv6wlO+n68gF37g+TKlMsq6hry0NKalEeyOt0xb5DMmh0br4G63ZYJFw8e3M5RxiSDEN7SvmJWBogXcX9+5sqrkDfRcRT3A4CasQVa/bmWi2RDItlvvNmHSRPYzjyiAwZxe34sTkBujmo2vZB1MxU0dowTitym7JA6U6BxDLyPNcMJW+wl/lQ3NkERQZ1zM6Q8o4BOiCRTZeGI8EA1KvU4RXgtclsHlVX2GXuu2wRs7fH97ieqyE4EH96ENf2OF0QnLjxd/zhneZa/OG7vxPn+pKyS92h5iQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB7054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.11; Mon, 16 Dec
 2024 06:55:37 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8272.005; Mon, 16 Dec 2024
 06:55:37 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sr@denx.de" <sr@denx.de>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH] watchdog: rti: support SPL (or re-start)
Thread-Topic: [PATCH] watchdog: rti: support SPL (or re-start)
Thread-Index: AQHbMiN/afepKeXbFkeaxjnEDrAYxrLfnmgAgAZXpwCAArStgA==
Date: Mon, 16 Dec 2024 06:55:37 +0000
Message-ID: <7b80802936c5a6227b3a925509f3bf4592764aee.camel@siemens.com>
References: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
 <8fd078c8cf006ad6af79180e0fbde1c58957374d.camel@siemens.com>
 <df0b9208-c188-4b9e-9e25-1ff296af5422@denx.de>
In-Reply-To: <df0b9208-c188-4b9e-9e25-1ff296af5422@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB7054:EE_
x-ms-office365-filtering-correlation-id: 93acf67d-faa9-401d-ae04-08dd1d9ea591
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dzNIVWhTL1ErK1h4K2NKOEk0Zm1HWGtQbW5oNjBUVWtEN1JRK08wTktsd2dS?=
 =?utf-8?B?ZTUyM0c3bFl5WVErTXkvcjJHemgvVUFSa3ZiZDRuQkxBVWJTeXRmNFQzQ2lt?=
 =?utf-8?B?azFTekVpK2JTVi9ERXJJMEM2ZXhrcy9Db2ZsaFI1Tm9OOURqTm9TeUhyUnZp?=
 =?utf-8?B?RjlaS0FMK05LYXBvY3VJS3FNTWo0Y1J2UGhHNStldGZVTDZkeGorNXIrcWwy?=
 =?utf-8?B?N1NGcW9NSFIrZ2RSYWZTUFhqVFB1bVUzOXdycG4rRVpFdlBRQW1WYmJEUnlU?=
 =?utf-8?B?NzFkMEZFeEdlcHpyNDQwbjk1MUg0dGtYVkU5cVFJbFJsSVQ1aCsvcXZxR0xx?=
 =?utf-8?B?U0REL2dWcjVlTWFYd3RmYTk5UGVPdEZ3ZVAwRmt2NXBHSUlMaEZhd1lkR3Z1?=
 =?utf-8?B?aFJwVXBGTEIvKzJJTHlmdVVxUHZCbUJBM242cHZxcjczdjZ6QUp3SXhJUkJu?=
 =?utf-8?B?UWozcjRCTDlXYXpZZzY0YkdXSmc3NE44bjZGQTIwTnZham9CSmM0MDFOZmVV?=
 =?utf-8?B?SUpEQXZZR0d3R3oxaXdsWlB6bFpuVDJLeW9XaTFrQld3YmVhay9uN3NZbzdw?=
 =?utf-8?B?alplUmx1N1loNmFTT2lmMWs1QUZOTVE2SDA0ZDI4QW1ZQmtIR1NDalFUeE5D?=
 =?utf-8?B?Q0NIREVUYjNIVHhzTGdDZUU3VlUyNWVLZ0hHamMvSzBtK3llZktqb3lUdWp1?=
 =?utf-8?B?bG5LZ2dPcFdQOXN4YWFFWUQrUklERGxPYkpNSW9aWUxuMlJsK215cFE4MnNK?=
 =?utf-8?B?SHNWdmFmcjdVVWpia2hQWGsrdkVxTWJQSEpxOVFvY1BRZFUweGR3SEMvV0F4?=
 =?utf-8?B?RXZJazhZTkYyQUt3N3J0OUFiNW9kZTFGR3dzYkU5U1F5a09pN2N0U3E0dGZO?=
 =?utf-8?B?dldKVndoTTUwUVVjRkhUcHhER2FpcGpJeG1QcVNWOGx6U2QzQ25pN3R4R2dP?=
 =?utf-8?B?ZTBmc01IL1p1Wi95UlMwVzMvTGJCZFN1dEp1ZEVoZU5lYVJhd3doUEZZOTUv?=
 =?utf-8?B?OFRhQ2tIKzdVTUhhdTdhSnkwWnNYRldlOTZJRDRESXpUSm9udmlPL3EyVUZG?=
 =?utf-8?B?ZTRtczYwSVFYanFYZ3oxMmhlNjFxeWpEYWZxSU5GWklBZ1Y1WGNJZlFvbDB5?=
 =?utf-8?B?MTRDK0l4T0xRUnlwd0FvY2t1UTVBL1RHT29CMlBzdUxOZ2NTTVVybDhWWWZv?=
 =?utf-8?B?YldBZnpIN3liOTlkL204Z1g0QWx1MmRMTk5OQXgwNWE2U2I3QjA1eEpRVDlC?=
 =?utf-8?B?WC8wR2hkdHlobm13VWtmYzB2Tm5NTnhkT3hKazhNNXRnVm94RUpRYjJGRGp2?=
 =?utf-8?B?OGZlNkt2elUrYWhleTNTUUNtREIrSUc1VlVzeVI4SjRhcmd2bGtQRDZIU1JQ?=
 =?utf-8?B?Zmd5eHAyN0lMOGd3SVpCcXVjT2JOallwZXZWb1RKRmw3QllOeHBXOUt4dUNY?=
 =?utf-8?B?NWJuR2R2Q2dmdDVmdEFwSnlyUDVtMGJpb3duWko2N0VIRHRzL0wrMFJTcjJ0?=
 =?utf-8?B?ak15MzFqVTNXWURnNnlBUlA1RkMxTDYvVVRqWUt3SXVIbjV2M0doWFp0eWRi?=
 =?utf-8?B?WXUyaWxlcU1LQVN5L0JNOGVlTEU0cEVVTit1VlNaUWRnVHY3T2Ixb0hpektZ?=
 =?utf-8?B?b0oyRHpudG9ZRkhaZ2xIbUNlY1doVFpxcmg3U3BMdUh1MTA2OHlNMWhoTmZN?=
 =?utf-8?B?OFQzc2VpZUE1N0NjWnZpK1A1bWZTNElqRVh3M2dLdHE2VERaOVVGbFRTcXZO?=
 =?utf-8?B?QXY4OStGU1VCTUgvMThhRFhJSThHdU4yNGlLV0twS3VXSnQwVGtjK1R0NjRz?=
 =?utf-8?B?SThPWlUzUHBPSkc2eG5vK1FyQVhrMDJRNVl4QTZxQVB1eWVIUkdWSDVCYjRH?=
 =?utf-8?Q?osg1EehFn24wn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGxtOTJWZ1J2VGNjKzBUKytsbEdHSzdORG9mN0h4V3lpWmN6UXdiR1h2dTJ6?=
 =?utf-8?B?RGZpcXFNYW92SURlVk95ZjhNanpqQWg2MUFjVzA4OVJjRE1DRWQ2MTVzWkhX?=
 =?utf-8?B?QjJGWGdPdkR0bTgrTXZGY0oyUXBVM1J3ckhhQmdVRHVlT2pYRG9aeXhibHVo?=
 =?utf-8?B?cUJVNjh1bHVRQldZOUU5TWdZaFhkQm1rTk52TEdzQnRyQzc3dHVBeE9uM3lx?=
 =?utf-8?B?OE1Zd1Azbzk1ZlRxYVJBQjdRR1kzM3pZTnprcEJ2c0xpdHBzTEFKMXBSUEYx?=
 =?utf-8?B?eUhnZHh2NjBjdkZIcnlrdmloN3pYQVZQc3VaczVVSUxlNXU3L0VKWjFvL0JU?=
 =?utf-8?B?cUt5QkQ2ci8raDJPVGp6MTVYUnlic0tCSnk1cDVtUjF2dmpxYlAwSGJyQ1lh?=
 =?utf-8?B?RHl0SXdveWRacDY5WFVuWk9yZnd3RGpWU2cwS3p1b0tuNGFCbU9Tekk4UUpn?=
 =?utf-8?B?LzBWbXdmWFdQaFR3WTI2RUkvRERxamNadUo5eUxYeDVDVmpGQWh1SDdKQzVN?=
 =?utf-8?B?SFRjVUFoMG5MZWVFZmlGczRJUG5xT0pDSnA1RHJJM00vbkJKdUhicVlVRWRw?=
 =?utf-8?B?RGlVNUpqZFVsMWRiUURZYnFYNDhqSmV3dDlvYXZLdjJsVmYyYVNBT2NwUnRk?=
 =?utf-8?B?cnJ0N3dTbnFTL1BsREsvTUQ5c0hJRGlBcjRLUjBiL1gxVEV0dm1qMUl0dFN3?=
 =?utf-8?B?NnFYcXBkdUZ2eEYybGwxRmlubUh6cGpRV1E3U0N4TlVuS0dFVkJOTm8yQjkr?=
 =?utf-8?B?dFphYnIrdC9ZMnRHSjVrckg1NzFkUWIvV3hxTGxYYXBUUXBQN2RKdjUwOVM2?=
 =?utf-8?B?VnJSRlpndjdlZDBxVWpKSmhwdy9qdjNQZlhhSzhsSFJ3UWpFK0xwRWh6d3pz?=
 =?utf-8?B?cjVEOGE5dFpBejhaYSsrbFUybFdXRU5mcmxkMWlvd0k1SnJDUVdGSTY0QWxv?=
 =?utf-8?B?cEJPYlN2QnlQTlNyRUNZdFdvZjZYK250MWJiSUk1Q1p5K1N4WW9lRGY0REtx?=
 =?utf-8?B?bHUwMnQ0U2tBNzVwRTVDV2MzMjVTSWxnRVJHeno4Z1c4K1E5T2wweGNESWJI?=
 =?utf-8?B?VlVBRnBlYTcycGdYVkpJbGp3UlJGd0dDWTFnSjI3UWQ3T0FvVnBDRVJ6RTRM?=
 =?utf-8?B?cHQvL2FJRGhtSXB2anN2a0Z6NkFoc3NpNzNVS0Y2clRvd0RRc1o3NW9IenlR?=
 =?utf-8?B?SlVmT3c5c2ZnZXBoQUdXd2hJTDNkVFJQdEFsUVVjSWw0Wk5pMUduUU5UNEVM?=
 =?utf-8?B?TmNtZVk4T2ZxSUJZQUtsRkxRYzdKVGNqTmR0YkVBWUhlSklKcktRaXhMbXBX?=
 =?utf-8?B?MU05YksrdE1OYkJOdVlmVi9YY3hBNlJBb2pTamJOdlFpZDdEdjhYYW5UVnRC?=
 =?utf-8?B?cmlnNmhBUFI2RG5jT3lRODI1bEd1OEVBUlhmcmRlWnF3QkE0WXJ2Vy9XVEds?=
 =?utf-8?B?NXgxVHFXWHdTUGxyRnRQaUhHdHEwSlpIUGZDTGZUMndTN1lEMXg0NWd2alV3?=
 =?utf-8?B?L1ozbUhsY3lIZzlCbGhMQVp0SWVoanVqYTFxaE84Y2x5SDVpYVhsanpibXQy?=
 =?utf-8?B?V041dS9lZ0tPenA4QnV5WlJJL0RNZnEyd2xRclgyYWtWdTM5Q1FxS3p6QWJI?=
 =?utf-8?B?NHFlWFZCcmxGV0lWT1NVQWxDSVJZMXFFc3ZpRlJEZDJvUFFkT2RZM1dKYTBi?=
 =?utf-8?B?endQOFRMVW5yenVVem9CMFBBVHVkQ3F3aTZOcUZ4eEVQakpGKzg4ZkJyWG80?=
 =?utf-8?B?SktBVldvdkhFaDc0VUlYRGtoc1RCWEp3andZVFJ2d0YvVUFOQTNySk8vZTBU?=
 =?utf-8?B?dFFtUWN1RWNvZGVYU2RtVW9oZ29YR2xhY2NzQlhqMGtvMzd1STF0Rjl3OEFo?=
 =?utf-8?B?VDhYeGlFS0lIKzFGdVUrbWwwK2Y4NUlkdlM5UllEa2wyRHpwZmgwMHhySDVX?=
 =?utf-8?B?VHVmMCs5NlV5U1Z4M21YeVd0d2s2VUtyU2N3ZUNVaEE1K2tkNHVkbFZSbEM2?=
 =?utf-8?B?TktYN1UxRGEvejh3bmhDZElhWS9LOXpvSWdyRXlvWXBJd0VmdWltelVGM0Vq?=
 =?utf-8?B?U0lxK1FDNlllaUw3akZoMWRVVzFFUjBma3lmTWp3Z1ZjbThPdm5MR1lXMDZP?=
 =?utf-8?B?MGdHRXJtaDRxMXlSUnVZd3BMMVRWSEQ0ellWb1VKVGJZTFlHNEJLNUV5aHdQ?=
 =?utf-8?Q?ZBNJouyiviuvfimgyHXabsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C09BC776AEBDF34FB33B74DFF3889BF9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93acf67d-faa9-401d-ae04-08dd1d9ea591
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 06:55:37.6069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7eeP8AI271X7JVBdCH0sU1WjuFCpnGzNahd+8peSkRcWVNLgkeu30Bcs3WvtZfA8KcCzPA0fWHkYw1fQW+ku067ZYre9LaEQh4cn6kNMk5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7054
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

SGkgU3RlZmFuIQ0KDQpPbiBTYXQsIDIwMjQtMTItMTQgYXQgMTQ6MzYgKzAxMDAsIFN0ZWZhbiBS
b2VzZSB3cm90ZToNCj4gPiA+IElmIHRoZSBSVEkgd2F0Y2hkb2cgaGFzIGJlZW4gZW5hYmxlZCBp
biBTUEwsIGVuYWJsaW5nIGl0IGluIFUtQm9vdCBwcm9wZXINCj4gPiA+IGZhaWxzIGJlY2F1c2Ug
aXQgY2FuIG9ubHkgYmUgZW5hYmxlZCBvbmNlIGluIEhXIGFuZCBuZXZlciBzdG9wcGVkLiBUaGlz
DQo+ID4gPiBob3dldmVyIGxlYWRzIHRvIGEgc2l0dWF0aW9uIHRoYXQgd2R0X2N5Y2xpYygpIHdh
dGNoZG9nIHRyaWdnZXIgaXMgbm90DQo+ID4gPiBiZWluZyBzdGFydGVkIGFueSBsb25nZXIgYW5k
IHRoZSBXRFQgZmlyZXMgYXQgc29tZSBwb2ludC4NCj4gPiA+IA0KPiA+ID4gQWxsb3cgZm9yIFdE
VCByZS1zdGFydCBieSBub3QgYmFpbGluZyBvdXQgaWYgdGhlIFtwcmV2aW91c2x5XSBjb25maWd1
cmVkDQo+ID4gPiBwZXJpb2QgbWF0Y2hlcyB0aGUgb25lIHRvIGJlIGNvbmZpZ3VyZWQuDQo+ID4g
PiANCj4gPiA+IEVuYWJsaW5nIGluIFtBNTNdIFNQTCBoYXMgYmVlbiB0ZXN0ZWQgb24gQU02Mngt
YmFzZWQgSFcgKHdoZXJlIFtBNTNdIFNQTCBpcw0KPiA+ID4gcmVzcG9uc2libGUgZm9yIGxvYWRp
bmcgUjUgRE0gZmlybXdhcmUgYW5kIG5vdCB0aGlzIGRyaXZlcikuDQo+ID4gPiANCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1l
bnMuY29tPg0KPiA+IA0KPiA+IEkgc2F3IHRoYXQgdGhpcyBwYXRjaCBoYXMgYmVlbiBzZXQgdG8g
IlN1cGVyc2VkZWQiIGluIHRoZSBwYXRjaHdvcmsgWzFdLA0KPiA+IGJ1dCBJJ20gbm90IHN1cmUg
Ynkgd2hpY2ggcGF0Y2guIENvdWxkIGl0IGJlIHRoYXQgaXQgaGFwcGVuZWQgYnkgbWlzdGFrZT8N
Cj4gDQo+IE1pZ2h0IGJlLiBJIG5lZWQgdG8gdGFrZSBhIGxvb2suLi4NCj4gDQo+ID4gTXkgb3Ro
ZXIgcGF0Y2ggZm9yIHRoZSBydGkgd2F0Y2hkb2cgWzJdIGlzIGFkZHJlc3Npbmcgc29tZSB1bnJl
bGF0ZWQgaXNzdWUuLi4NCj4gPiANCj4gPiAxLg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI0MTEwODIxMTUwNi4xMzQ4NTI4LTEtYWxleGFu
ZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tLw0KPiA+IA0KPiA+IDIuDQo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjQxMTIwMjIyNDEyLjE4NzMz
ODEtMS1hbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20vDQo+ID4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjQxMTIxMDgwMzI2LjE5MTMwNjct
MS1hbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20vDQo+IA0KPiBTb3JyeSwgSSBtaXNzZWQg
aGFuZGxpbmcgdGhlIHdhdGNoZG9nIHBhdGNoZXMgaW4gdGhpcyByZWxlYXNlIGN5Y2xlLg0KPiBB
bmQgbm93IHdlIGFyZSBwcmV0dHkgbGF0ZSBpbiB0aGUgcmVsZWFzZSBjeWNsZSBhbmQgSSB3b3Vs
ZCBwcmVmZXINCj4gdG8gZGVmZXIgcHVsbGluZyB0aGVzZSBwYXRjaGVzIGFmdGVyIHRoZSB1cGNv
bWluZyByZWxlYXNlIGJlZ2lubmluZw0KPiBvZiBKYW51YXJ5LiBQbGVhc2UgZXhjdXNlIHRoZSBp
bmNvbnZlbmllbmNlLg0KDQpUaGFua3MgZm9yIHRoZSBxdWljayByZXBseSENCk5vIHByb2JsZW0s
IHRoYW5rIHlvdSBmb3IgeW91ciBlZmZvcnRzIQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0K
U2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
