Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220DDE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 12:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FDC88E26;
	Tue, 10 Dec 2024 13:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="bMF1Xhjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6617988E26; Tue, 10 Dec 2024 13:45:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C9B88CA0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 13:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJ2akoUVTPdQZe8Vqc8yAZdY/yni1DlZ0qfn2P/voojVl7yCYQgtnTSTxrlh9fAqAo41y1Mc+vcU9XuLHrB2uG6DK92KxLFpo74KJ0oruxEy8bjY0Zryv1WRjVsa/zMMQz9PKz3gf5ZXkX5YHZeCBwOwypsHODDmBI91XcvPO2ficyJ2OxAepreURPRNaGT+vX9xRc1R/HuLRJAmIIhI8ILS78f71UhfTbuLYXaCFuxOxqTdDRUI+Tki5Za3wsh2luFaD0CfU+Lk7Ur1voxGcf4gw5ICphJGEw8ZLvs6/hJDiVJzO96l2TazT6w8p3je/MKgOyznf5PUZhLOHE/fFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLrY7zf2TlO0LBrALTFgYn/AXQPIPUTmN82JBq72YfA=;
 b=SYmxADNQLOd5rOy9VH8hGyusmTrOC6YUKS+IcTc6o6nySnZhzE2LVn7o3eWpSBwjTqljn1xbEi0q3d8Fm58vLvz0UCvHYbGgDfwM2o/xskZGopZYx4yZkIJWi24nBPrxIFsdiCKWAGjNXNCOUpOb2nsCC/5302a6PPj0r2NlnI8xKapfnxLOhkhsMbA9jX4lGrvyTZZdHdU/JOFmwkjbMJPLpcxUm5lkjcGl+/Lg2h6ztff3lc/kw/EEdCPOqpQHs3qhaIAVxQLrcOXfReoVhZxrPH+mTPO18L7pq4jOm6HY1UkBeaHEAPXZuLCVnfil2V9pIYROYMoQ2IYI6tDzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLrY7zf2TlO0LBrALTFgYn/AXQPIPUTmN82JBq72YfA=;
 b=bMF1XhjpPu8PWdXZpw6PIEfuvb2NVhr6uKIjxs5JvgC/Dsvh3Z9zZzh2BfwcxPTpsB3nCyzwfhXDjIYAl+kw3YaCdGFFDvlw0M1nO57SchiyuFvVb7rd2C3N5KsB0uY8d5pxRPehj9ehKSXEjPwKbJ/d4I5i0Q1azwCgtpjUSOz/YxTCesJe8lo1poTTMfQvBNrm47O4PsMI58KDpZ7X4NZL0TkKjeT/OUs2Y360+ivlH21ZJliRA0hp6UM1W2Cnr7g87naUDx+IX8cr3v2ivKSJoEHNfd65eND7ORRXUqYfy264zka7qkNv8VnfjmY87Bnt6taTCTu2maSiTKKyjw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI1PR10MB8183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Tue, 10 Dec
 2024 12:45:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 12:45:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH] watchdog: rti: support SPL (or re-start)
Thread-Topic: [PATCH] watchdog: rti: support SPL (or re-start)
Thread-Index: AQHbMiN/afepKeXbFkeaxjnEDrAYxrLfnmgA
Date: Tue, 10 Dec 2024 12:45:09 +0000
Message-ID: <8fd078c8cf006ad6af79180e0fbde1c58957374d.camel@siemens.com>
References: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20241108211506.1348528-1-alexander.sverdlin@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI1PR10MB8183:EE_
x-ms-office365-filtering-correlation-id: 1c0affdf-9486-4651-f88f-08dd19187b27
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0doQklDdU4rYjloSExYUHNkSmxjL1ZLdlB3QnR6eXhzbGx1VVJkMXAzOHBE?=
 =?utf-8?B?cUZxSXVoMGk1QVM2blozT2p6R2NCNDJKOGNXN1kwVDVCUGVSZThJM1Q5L2ta?=
 =?utf-8?B?OFFwdlhtaUZqb243RHY3RGVXOXZ2SFNDVkgrb2ZiL3J6Mi9ud2syZVNZZGtQ?=
 =?utf-8?B?a3NBZVdSUWJ0NDYzUzlWbkprN2RNMUltWk1mSkphSEVCZW9OM0lNK0pxaWRa?=
 =?utf-8?B?T0piNkI2QTh6TEhzKzhKTXJtRzZoVWR4VW81cWhudDFDS2xBK2hJOXhNVUlY?=
 =?utf-8?B?d2tMS3NBaHMxamFiL3lHL1FoV0hxQmRyOXJYMFc5R2lOYVVTVGRRU0x5K0lj?=
 =?utf-8?B?VTZuY1kyT0ZuS2l5T0JDNXIxNFp3U25nT1dFVk5ndVEra3FPK1N4NzE4c1Yw?=
 =?utf-8?B?Z3llZVZHY0lmVnNlaHJyaWVtaDdzczdHSHVQYVk4ZlRFeGs5YjdKOS9VYVRr?=
 =?utf-8?B?SWdTN2EwbmFwZ1huOVNmeEJMem9QRWVHbkV0SnI2bDA3cmNLQkJERHRyV3du?=
 =?utf-8?B?cWkrTnJLOXJDOHB3Z1B1bFJOWExYdWRmV1d6UHRCcTNES1V6MitER1dLdnJO?=
 =?utf-8?B?ZU9neCt5czVSRzZFWDFBcEgrNGFNb0FPc0VGMkYxRFY5YnI2S1VnQkZuTXEx?=
 =?utf-8?B?ejlLODZYT2VrbCt0bG5aQUFpNzZJKzN3VGxKekNIUlcxT3ZQSWltUjhyRkZ2?=
 =?utf-8?B?bUt3bFFqWFpKdW5pTXJ0clNtM3N6SjBXeDh5TWRLOW9DMW5HZGYwZTN0bGJW?=
 =?utf-8?B?d0Y4U0NSQWVRQ3hCNkxCSGQyYWJUU054MmhJNlRxQjY3eWJDYVRTOGdZY1py?=
 =?utf-8?B?Z1VWNHBhVlFZYmxlV05zVkloLy9hWDc0NE5hdWZYVlVQS2RCV1NrY1lQaGR0?=
 =?utf-8?B?TjhXY3BGQzFWZ2s1TlpLSnk0NDFuOEpvbllGSEFTa1dWNm5jM0xiSlg1QlVF?=
 =?utf-8?B?YmRtM0E3aHk5ZUJlZTJuTkd0TmoreXBBbHpLaEJEejZXMVlqVWZpYVYraXA1?=
 =?utf-8?B?MVVYTVZjdjh1WlFGQzdWQVZBYm9vU3ByS0hNRlRtci84WDcyNk05TmRncElQ?=
 =?utf-8?B?dGFRNkc0TjNlcHZSRzFkYUdpQnk4L3VrZUROTzBBUzV5dXhMb29QMW96NVll?=
 =?utf-8?B?ajVGOEZ1YTF6emtXVm12bllKR01MWE5aZnFvS2J1YW5ERm1nNW9qM2xpVVZK?=
 =?utf-8?B?OGhwdmFqcE11Sk16bmZpRGYzSkU0MFZRQWNXUXZSTjVuSVhxaW41cnVhZ2Fr?=
 =?utf-8?B?bXgyelZHWW5XR0xzcVBWTkhVdjRuei9GY3M1cGVXK1JIaWVFRnFxZEZxMjJn?=
 =?utf-8?B?d1NGVzhReDFZbWxqZFYwRndMSEliQ2xhUzVOL0tRbGkwZlZ1SU91NUlSeWh4?=
 =?utf-8?B?OGo1Nk1FWFllemlidVV2TXdmb3IrYnVhZ05JUjBmdnh1WGFYczdkNlNuRGxT?=
 =?utf-8?B?OHpySVp6cFR4UnpsendqU3kyWDEzN0UvWEFYRjY4MU9SSWlzU3FOUUJPaHRr?=
 =?utf-8?B?VFZhZEVYbUNCUDdCaC9jV0RPQXBzT0FibnlNd2llWXJ4S25qTWNKRWdqcUhY?=
 =?utf-8?B?UFgzbVFGS2JxVm9MQWdOeUV5alB3ejkwOVd0dHBkcnB5dzVFR1JLN0NuS1BK?=
 =?utf-8?B?ZWFLNllaeU1qaWRzZWduTmY5bG5qMHdLYkJ5QkVCREVnUlJIRExMaDhNMHEv?=
 =?utf-8?B?U00zMnllWGcxSkJ5ejhYSGIxVHQrVkV4VE1PVk8yRUwvZWp5Wk9lN1pZRGN3?=
 =?utf-8?B?amk4THhzTGY4Z2ozcUFKSmxqT1VFSkkwTjVIRWg2YW95Z2VzamRHTFBkaFVx?=
 =?utf-8?Q?MKGCx5Htws09wbG3fLqAj6QwQfm3r2a79wGHw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTN5RUlHV25sY0NnMlpqa3dmNUx1LzZjSjZ1Yk9KZG1nVC9ndms5TE1lNUhi?=
 =?utf-8?B?L2t2N1UwcDhHMmlwWUZEQ2dJVlV6dHdMemNMelJuUWdNUi93VlY3QUZGcGwy?=
 =?utf-8?B?K2ZZUlBIUXB1VnZXeXRHYVEwSDR1WVg4OExzdnNFSmFWbHVHVEtQK0xOTk1T?=
 =?utf-8?B?Ykk4RzhBRG1FMWR4TDJLSC84MzNhRjVIMkhIVWczS3hBSGZZS1Jzcys2NjRR?=
 =?utf-8?B?cXdoY0RmRGhOOUJPMGxLeGZTS0MvdXhqMTZzZ3RzQkRuZFRPWW95aW5HNng1?=
 =?utf-8?B?OXJ6UnQ1ZVdRNFlmNisycXRKV2l1UDRVcDU2bkV2cXNSQUhRZ3g2a0lqSnBr?=
 =?utf-8?B?N2JuZTV6NzEwR3l1YjByL0hmV3gzUUdMbE52eFp6eHZYZkwrMG9jMDRzaFZv?=
 =?utf-8?B?YWdsdys3UzZjb2haZU5zeGh1REpQb0JxOTVwZ2ZZTGZzOW1KOUFTbi9NOGhO?=
 =?utf-8?B?bXNLS0VxL24rcTRoSmhJL2wxZEtMQ0lLUmlIRVlLUDlhMVlrWmpOcUl2aVBZ?=
 =?utf-8?B?Z1B2TkZLeGNoUjBLM0wzUGxpRitJVnRnM2w1V3pHa01Ea1UxbUlPVHl2bk44?=
 =?utf-8?B?Z0Q2Umpwc2VHeFlNNURCd0QraXBwblR0UVVrQVVCZHl2MDl0Z2VyYmtKMnZG?=
 =?utf-8?B?cHFnQ0JSZUV3WVdQM0Rxbnk3WUNlMFA4MlluY0trZlMvVUR4OW5JUHdGMlFw?=
 =?utf-8?B?RmJKSVBXaWQ2NUxxeVVTN2k2dXFpQjMwdFpWWVZ1TWRTQ040TWM5S0lyQkhl?=
 =?utf-8?B?TVgzWVJJRGtSbERmTmpiUjNwYzVKVGV1ZEx2YUNTcG1MeFZyUmVYcW9McUFB?=
 =?utf-8?B?Z3ducnBINWlya2FmUmo3YnVJc0poRzRVNXpLb0p3K3RmQW9oOHZIR0F1VWRY?=
 =?utf-8?B?cjJhZnphZXdyVzhXamdjV1lXVTQwTjRLNmVuSnJGVWxZVUN4OHQyS1pzTTJX?=
 =?utf-8?B?NjFubWFVWnFaaDJiNGZINHlHbXpCQmZjZktGbkJwdVk4M1JZNGIxcG50OERZ?=
 =?utf-8?B?dkpzaVBqN0NYMW82TnJPZmxwNURhelBhTmkyNkZkQUNWM1hMckh2bG9BN05l?=
 =?utf-8?B?VmtpTUliNVRxV2hoQnczRFZjRWVRQVpLYklyQVpOb1Fpbk5FOG1adXZjWDhh?=
 =?utf-8?B?NWd0MStYbXFyQ3RQSEkvM00rRm40QWNDamNNcERIL2IwS3Z6UEtjVUFNMDdF?=
 =?utf-8?B?Q1lkNmRyTy9Ibkd5NUZxRmtTOHRobi8rUWk3OGwxL2NIZlB3clJ1QzFLNXd0?=
 =?utf-8?B?N2Z4aG1EeW5ZdkNIRGNLQ0tFaXdJcjNEWjFhKzcvb3I2Y0pjR29GMXEvUnN6?=
 =?utf-8?B?OFJQalh2ZUoxa2NIa2hyQmxNTm0yRFJ1Q0tZQlZCcVp4L1pFYnNzZXhCb1Ju?=
 =?utf-8?B?dlFwTHVKam9SMFlVK0tCdUN1a3cyRkUwSVJ1eXpRQzRmM0JYT0RSNU1lMy9k?=
 =?utf-8?B?NkVSYmlLa1ZOMlBBR2h6Y2ZvK1dmSC96LzdiWU1qM0xoM21pYUN3a0h5TElK?=
 =?utf-8?B?V1R3STRBdGNGNXk0My9ocTRuLzVkM2pDVlZDN0dqOUV3eUJlZ0N0dWpOd1Vj?=
 =?utf-8?B?N0RSVWFDdUVOc0IyWU1aY0s0bG03UmZJYlI3ZHNMYVdrYm8rSnBXeDNQYnF3?=
 =?utf-8?B?ekNlcG5UU08wRy8vb2w2OW93UzBoZ1BrR2Y3OHJnU1ljK3Z1ODVGVHdWQzFv?=
 =?utf-8?B?azdGenovZzNNNUh3SU9iS1I1WEN2blE1elh5V1c2QjRRRkNxMThDLzErUXBt?=
 =?utf-8?B?MTJGL0RCazN6N0swMVR6dm5XYWMxNGFKVDUwdkkwZmF4M3Rwb1ptTmRETjM4?=
 =?utf-8?B?UUdoNlJyYnNhb3NuSEs1TGxYZERDamx6eU13dWMzNHZtSUcwcExFSjRFcDd1?=
 =?utf-8?B?ZXRqMnZTZis4TEVzMDAzMmtEeWV3cm5tTVdtQTdiRkRXQzk0enNPZHBPWjF0?=
 =?utf-8?B?OFFpQ0NRNEVreVJaZEEzWXg3d0hLdVA4elRlUW43T0xVTEJWYjN3d0pWWjlS?=
 =?utf-8?B?dE1WT3RmV3FycmxhU2pBSmlkeXJETC9yc3RTQjNDcWxLTlNOaGZRcGR4T2FW?=
 =?utf-8?B?UEh3bUx5QmZLdW9DRC9GV3BMVlhpdTk5RUNSQTJsbEQ5aWJvU0oyYllBNk9D?=
 =?utf-8?B?bmJxc2xuYUdIengva1F5YUpZQ2drS2VOamFxMmtBSUlYZFo0M2J3RkFEYmla?=
 =?utf-8?Q?a3nfW3t3XXWk4h662DsWesc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9513A24EEE94BD47A14ED711B7769602@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0affdf-9486-4651-f88f-08dd19187b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 12:45:09.2381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpGiI8tiAsva47rh09nZBozkoPcoT0pdI/AggsvzX0aYKyzDLg4NfJ8A328bFHLI6BCmddbRaGX64LQmi/Ve8wd1MaP/vAkaK/lkUE0a0nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8183
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

SGkgU3RlZmFuIQ0KDQpPbiBGcmksIDIwMjQtMTEtMDggYXQgMjI6MTUgKzAxMDAsIEEuIFN2ZXJk
bGluIHdyb3RlOg0KPiBGcm9tOiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxp
bkBzaWVtZW5zLmNvbT4NCj4gDQo+IElmIHRoZSBSVEkgd2F0Y2hkb2cgaGFzIGJlZW4gZW5hYmxl
ZCBpbiBTUEwsIGVuYWJsaW5nIGl0IGluIFUtQm9vdCBwcm9wZXINCj4gZmFpbHMgYmVjYXVzZSBp
dCBjYW4gb25seSBiZSBlbmFibGVkIG9uY2UgaW4gSFcgYW5kIG5ldmVyIHN0b3BwZWQuIFRoaXMN
Cj4gaG93ZXZlciBsZWFkcyB0byBhIHNpdHVhdGlvbiB0aGF0IHdkdF9jeWNsaWMoKSB3YXRjaGRv
ZyB0cmlnZ2VyIGlzIG5vdA0KPiBiZWluZyBzdGFydGVkIGFueSBsb25nZXIgYW5kIHRoZSBXRFQg
ZmlyZXMgYXQgc29tZSBwb2ludC4NCj4gDQo+IEFsbG93IGZvciBXRFQgcmUtc3RhcnQgYnkgbm90
IGJhaWxpbmcgb3V0IGlmIHRoZSBbcHJldmlvdXNseV0gY29uZmlndXJlZA0KPiBwZXJpb2QgbWF0
Y2hlcyB0aGUgb25lIHRvIGJlIGNvbmZpZ3VyZWQuDQo+IA0KPiBFbmFibGluZyBpbiBbQTUzXSBT
UEwgaGFzIGJlZW4gdGVzdGVkIG9uIEFNNjJ4LWJhc2VkIEhXICh3aGVyZSBbQTUzXSBTUEwgaXMN
Cj4gcmVzcG9uc2libGUgZm9yIGxvYWRpbmcgUjUgRE0gZmlybXdhcmUgYW5kIG5vdCB0aGlzIGRy
aXZlcikuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRl
ci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KSSBzYXcgdGhhdCB0aGlzIHBhdGNoIGhhcyBiZWVu
IHNldCB0byAiU3VwZXJzZWRlZCIgaW4gdGhlIHBhdGNod29yayBbMV0sDQpidXQgSSdtIG5vdCBz
dXJlIGJ5IHdoaWNoIHBhdGNoLiBDb3VsZCBpdCBiZSB0aGF0IGl0IGhhcHBlbmVkIGJ5IG1pc3Rh
a2U/DQoNCk15IG90aGVyIHBhdGNoIGZvciB0aGUgcnRpIHdhdGNoZG9nIFsyXSBpcyBhZGRyZXNz
aW5nIHNvbWUgdW5yZWxhdGVkIGlzc3VlLi4uDQoNCjEuDQpodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvdWJvb3QvcGF0Y2gvMjAyNDExMDgyMTE1MDYuMTM0ODUyOC0xLWFsZXhh
bmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbS8NCg0KMi4NCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI0MTEyMDIyMjQxMi4xODczMzgxLTEtYWxleGFu
ZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tLw0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L3Vib290L3BhdGNoLzIwMjQxMTIxMDgwMzI2LjE5MTMwNjctMS1hbGV4YW5kZXIuc3Zl
cmRsaW5Ac2llbWVucy5jb20vDQoNCj4gLS0tDQo+IMKgZHJpdmVycy93YXRjaGRvZy9ydGlfd2R0
LmMgfCAxMyArKysrKysrLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL3J0
aV93ZHQuYyBiL2RyaXZlcnMvd2F0Y2hkb2cvcnRpX3dkdC5jDQo+IGluZGV4IDk5MTY4ZDBjYWQw
My4uMzIwYzVjYTE5ZTBhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3dhdGNoZG9nL3J0aV93ZHQu
Yw0KPiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J0aV93ZHQuYw0KPiBAQCAtMTMxLDE4ICsxMzEs
MTkgQEAgc3RhdGljIGludCBydGlfd2R0X3N0YXJ0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHU2NCB0
aW1lb3V0X21zLCB1bG9uZyBmbGFncykNCj4gwqAJdTMyIHRpbWVyX21hcmdpbjsNCj4gwqAJaW50
IHJldDsNCj4gwqANCj4gLQlpZiAocmVhZGwocHJpdi0+cmVncyArIFJUSURXRENUUkwpID09IFdE
RU5BQkxFX0tFWSkNCj4gKwl0aW1lcl9tYXJnaW4gPSB0aW1lb3V0X21zICogcHJpdi0+Y2xrX2h6
IC8gMTAwMDsNCj4gKwl0aW1lcl9tYXJnaW4gPj49IFdEVF9QUkVMT0FEX1NISUZUOw0KPiArCWlm
ICh0aW1lcl9tYXJnaW4gPiBXRFRfUFJFTE9BRF9NQVgpDQo+ICsJCXRpbWVyX21hcmdpbiA9IFdE
VF9QUkVMT0FEX01BWDsNCj4gKw0KPiArCWlmIChyZWFkbChwcml2LT5yZWdzICsgUlRJRFdEQ1RS
TCkgPT0gV0RFTkFCTEVfS0VZICYmDQo+ICsJwqDCoMKgIHJlYWRsKHByaXYtPnJlZ3MgKyBSVElE
V0RQUkxEKSAhPSB0aW1lcl9tYXJnaW4pDQo+IMKgCQlyZXR1cm4gLUVCVVNZOw0KPiDCoA0KPiDC
oAlyZXQgPSBydGlfd2R0X2xvYWRfZncoZGV2KTsNCj4gwqAJaWYgKHJldCA8IDApDQo+IMKgCQly
ZXR1cm4gcmV0Ow0KPiDCoA0KPiAtCXRpbWVyX21hcmdpbiA9IHRpbWVvdXRfbXMgKiBwcml2LT5j
bGtfaHogLyAxMDAwOw0KPiAtCXRpbWVyX21hcmdpbiA+Pj0gV0RUX1BSRUxPQURfU0hJRlQ7DQo+
IC0JaWYgKHRpbWVyX21hcmdpbiA+IFdEVF9QUkVMT0FEX01BWCkNCj4gLQkJdGltZXJfbWFyZ2lu
ID0gV0RUX1BSRUxPQURfTUFYOw0KPiAtDQo+IMKgCXdyaXRlbCh0aW1lcl9tYXJnaW4sIHByaXYt
PnJlZ3MgKyBSVElEV0RQUkxEKTsNCj4gwqAJd3JpdGVsKFJUSVdXRFJYX05NSSwgcHJpdi0+cmVn
cyArIFJUSVdXRFJYQ1RSTCk7DQo+IMKgCXdyaXRlbChSVElXV0RTSVpFXzUwUCwgcHJpdi0+cmVn
cyArIFJUSVdXRFNJWkVDVFJMKTsNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMg
QUcNCnd3dy5zaWVtZW5zLmNvbQ0K
