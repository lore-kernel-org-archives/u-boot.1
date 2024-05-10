Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450AC25B74
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F1787EAC;
	Fri, 10 May 2024 21:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ducdkuey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADAA87FC6; Fri, 10 May 2024 21:40:57 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C6087E0B
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9/2GzHCnKERIuSsptQQJ01SW4/Wq3siRSO5e8PTliqXzxNxKE1JGWrM7jtqHDe4xOx373Yk2aKQNeRnxI7thyQsrhE0wAw003XBtRDUDCi9WMk2eUPl+cO/IaIoBunDmnXt9Gc7VSBPaJsGqiyWCefKGgVrPWGqexAfajdVsSd8Xmig/uvB6kFyJe+jnTsTyH/jcXDZZ36lcU0He4mA/7Hx0C0MNVBog9XUKOd9mWMmgRS454C6oehMM2/oxZHWLgSl0b/klDUCgofIv4U+w8G1FkYY6Ytyz2/bmmTSD5iDGA4vNS1bqr9+tstFUoVh3dUzxRCKUpsl4IYatF7GVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SJhH/RWKuJKCDSA1rrJgCxlzSgkkZLU7mhg8J9b25Q=;
 b=bVg0Yr1LNFz6bn4OIIVFR2LMPVOmTCTpvOzlZOFYmZiSe4Xx7jNH7RPzQcP4aGayv20fW469ORWdsmSU5+LNfLuGmDCiB/Fui0jWnUKq2MlZfYtbRzhbuZqBNyzgFNcT6tXoWBdFdKq/WbnUeMWduKkwQh3zakDr7GPhxU8TrzoucpCEhO0Ni98dO7fmDzV23SkGUJ7zv8+u7n8Y9glgFuTxyvqTC68R8SruWvD33BskwihA4q2Kkv4MmaeM1Nphp5WECw/EN+upK1Y3dsDP8CvYUAPxj9bMv8KSfWysnNIcXBzK5GjL7SrrRSlZu3eu589veOHkhEFxYwl3LQVgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SJhH/RWKuJKCDSA1rrJgCxlzSgkkZLU7mhg8J9b25Q=;
 b=ducdkueycm2eqQ2WDBYC4DHQexP2ozVBMON6vVL1AOAFEVVk9OsNeIl9dQ+CFrTqy2OUUBlLZ5UdiZctcoyrbfIbAZD+OfiEC7JFlhwPL9aYmcYZY5YdYOx6D2cEfYU2Cm6tz7boGbT8qHPcpeq4pTD+axigFiLe4fzpD84Gd5R2MKYCcWDbId+at9/13KqD43ni+kHEUm1fwlZR0Qasxu1q30hIom3B2+asGOf+rOB8hnBMbPcsb+qnaJihoYNMty4YuPhKM5Rim4txgZYJq6zY8s9mpz9/00uo/Zik7/31zkhKKs9dBvflwFJ7JOUWPDbsygZkq6dGRIGHVpBX+A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 19:40:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 19:40:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "j-keerthy@ti.com" <j-keerthy@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, "nm@ti.com"
 <nm@ti.com>, "s-anna@ti.com" <s-anna@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: don't touch DMA after stop
Thread-Topic: [PATCH] net: ti: am65-cpsw-nuss: don't touch DMA after stop
Thread-Index: AQHaoXascx4VWXX+EUStmUSjMzvKF7GQMRgAgACv6oA=
Date: Fri, 10 May 2024 19:40:54 +0000
Message-ID: <49bff29281250c0063300b8042dce43d471d9509.camel@siemens.com>
References: <20240508183605.955341-1-alexander.sverdlin@siemens.com>
 <98ffe161-33d0-479b-972e-92f9e8b8c2ff@kernel.org>
In-Reply-To: <98ffe161-33d0-479b-972e-92f9e8b8c2ff@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5977:EE_
x-ms-office365-filtering-correlation-id: eb0e39fc-2fc1-4c13-8379-08dc71291b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?b3U2Um9QdTZydVJ1bmo2Y0hpd3pLb2F4UytWeXdMMG9NNno0dWUxSFd2OFUw?=
 =?utf-8?B?S1ZabTRGZnk0V3FxKzU0LzRkZDZmQzdHZTFJZmxWeDhkNmJLbW1Gd1VKWHZk?=
 =?utf-8?B?ZWVsbWJWUVpHbFRHSzhJaWVwRjJiOXU2UzMwbkVtdURNMG9LRlNoMUFHWWpM?=
 =?utf-8?B?bnVJd29ScFplQnpOYkRsTHd3TWhtWTg1L2srSnV3OW92cm94N0RCTDFwY1hV?=
 =?utf-8?B?VHdkMHV0QlRsQmdRbm05QzhCdm5FY0lVTnNRTjZjZU1YMkFZVXpNNVV4Q2ZB?=
 =?utf-8?B?K2xBQWdRM1R2dmxMREtvYkZIblR6cFlvcmg4azFXS3BtRWcyV0c1MUV2Smd5?=
 =?utf-8?B?TWE5SmY0ckE2SVhvOG10VEgwWllReURYVEhwTkNUNmlmb3o4UEhDTzdhcGlM?=
 =?utf-8?B?M1RJUjQwY3FIRm9iZHhGQjVsVStXemZHVWNNZVIyRE9UOFpsWHdWU29xTzZE?=
 =?utf-8?B?SnZ5SWJIYTBaNHFsaUhkRzVvVkFyTDNtcUdsVHNqamR1OFVUSGQ3WjlXMWV5?=
 =?utf-8?B?YnJqeTJhd0hMb0crWFZXVnMrSUlpMXZ2ckZhMWlvSmhFcFNsem5Na21LTmhI?=
 =?utf-8?B?bmxaWldpbEZSU2ZJZ0lBdGx3WXRCa1BDdkhtVUw5NXg0UkYyNytvc05Wa3BR?=
 =?utf-8?B?b2w2T3UrS0s3S0lBMGpUMC9vL3RBNk42QnlBNmxtUFRpUDVzUnhRaWFxWU9S?=
 =?utf-8?B?cmoyY29SeE5ldWhWWjEvTUlPQmdKUXdQK25pL3NNaExKbVg1clhjcjcxWXdS?=
 =?utf-8?B?RHpFTEdYWGZHM01PazdYbUtuTEVoQUtLU3hicVZHN3I4OERwbW1kTVNmcEdS?=
 =?utf-8?B?MTRGdVp4UCtXUU1ZeEZ4NVd2SGF5SnRWSThFd09rMU4zOFlub050VVVzRVBx?=
 =?utf-8?B?VGcxdFE2aEhQc0hCUXNnWTdaTzM3L2IzUnM4MXZSSXpyOE5jYzRsWEhMd09s?=
 =?utf-8?B?elhpUW16Q0FYWXVNRTRjOTZjdU1HMmhaS01jdEZlOCtpbmE5MjI2ejkxeWlU?=
 =?utf-8?B?Y1FLVEl6cGd3UlN5eS9PU2NJRTB3dk9kUmN6RjlRWUJvcU50MkNuODBsTDRE?=
 =?utf-8?B?ZjhUVFI0dzUyUEM3Z2kvYUU4bXJjT3p2TktURGR1eFNyTjJmNk9BK0YydUpt?=
 =?utf-8?B?MXFObzRpR005V2E5c3pCWWlxcWV2RjBacEhjN293UHhvejlWRTFxY2NGR0lt?=
 =?utf-8?B?aTRCRC82c3JzZHp5aExmOWZkbmhwRUpFSkt1VGZnTVpSZ0RlRDl1U0Z4VCta?=
 =?utf-8?B?R2tqT3g2ZWlTWjNTVVIza0pkUTI3d04xMnRIMkpuQ1NYazAvUmU3YTJrNDJY?=
 =?utf-8?B?WDFPY1VDaVpLUzZYaURMdUw1TVZHem9oWnFOeDQ1MlZJZEwzeUVnaWJOOG51?=
 =?utf-8?B?a1BMQ3Z5TWVERjJla2NId1NjZ3pROWFkSUwwYzlHcjVDQjhGbFJZZDQycXFI?=
 =?utf-8?B?cXNlRDUydSt6bHAvcHM1Q3M5Q0h6QW5PVDJmalBTVGh1UXp6ajQyMGo2UnJn?=
 =?utf-8?B?a1czeGI2Z3VmNzAxMW9ZUFlsaFhlMWFORTBmRC9iMWQ0WlByN0YxRCtjemE2?=
 =?utf-8?B?QnlUWVZCNnBSN29tbGtTWTJVYkhEYmNSWmVaK1dDcU03OXBOMTNKeld1TWxV?=
 =?utf-8?B?dHFWd2taL25tWnVCS0ZvbU9rN0hJUHA3NnJWdkFldzdObkkyOGhmWC9CSDl4?=
 =?utf-8?B?cG9MM2o5QytKWExoS1k5NXlRVWxoYUw3OWN0MUlyZEE0YkphLy9kdWx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmFDczJrcFFldW9EK0ZVZ0tpZldDWnhjUDM4UDB4ODYwRW9haWRVWklmL0hC?=
 =?utf-8?B?VWhFNm90QUFIOExWQlhVaTlrSzM0emNBZTJRb0lscktMWG5oUmNuRStXOE5x?=
 =?utf-8?B?YXBQUmJrS2VvdVpoTG5jSnRvV3dSTkE3S0NJUXl4bEpLWTBiSnVZVFRHS2ls?=
 =?utf-8?B?bno3RWNOL05zMnAvRzQwdGl2NE5TQ3pGNGdodzBRcit6VmUySjQ4M3UvUk5H?=
 =?utf-8?B?SHlqUjc0Nnk2dnpKZlg4dWFVU3A4M3FTSUFHQjBYWExlRkc3aHhxTGFHUWRZ?=
 =?utf-8?B?VlNwMkltVHcwVFFPa1Fzdkdidm9MaVNOR2NWV1ZXUm40b1FSY2hUcnlFeUxh?=
 =?utf-8?B?azQrMzZOZ2pZSDBKRERDSnEvY1pNVmtEd3o5a21uNFdyeEpPL2xJYXViemto?=
 =?utf-8?B?bTdwS1ZtclIwb2NhdmpLa0RLcitYMU9QeXQyK2FsaHFQbk5IbWdrSnRvaFlJ?=
 =?utf-8?B?WHpoRGRLVm1GWGFSRWFNL2Z0T2lSdGdidk1aNVRhN2E1YnFBK1lMSzdEOWlW?=
 =?utf-8?B?RTBMV2xCUEwrSTd4NE1CekpxVEtNcDdtZ3N0blhMRGtWWlZZTmRtMWFjNUx2?=
 =?utf-8?B?SUlYSnBNZlcyMGpBTFNXMUpjc1pnUklHNGl2WVhCNWJBQnlUWDlsam5ra0ht?=
 =?utf-8?B?VS9tUS9yYW91RkdQMlNJTVRkVkVBcDQ1UXRpNWhod1NIYkN6WkV3elFZb3NI?=
 =?utf-8?B?SEFHcHlZYkpoZ2Z0eEdWbDdrZm9FM25DWTNrS0pGWDdZdU5CSWRVU3hRVVB4?=
 =?utf-8?B?K2pPVVVnd1ZEbjFpWDg0eGc3dndHbXkvUFM4NWNWcTV6RE0zdmlEd0RRVTZr?=
 =?utf-8?B?OVpTS0IvNkpPRWY1Ym1YMHlTZWMzWTBMM0NhRmVMRjVXYXBLUFYrbG9ETE5Y?=
 =?utf-8?B?bUl5bVRLSC8ySDM5clF0eW8ycktCVjJKWGdlS3c4SDlnUGJUb3dKOGVQcVJL?=
 =?utf-8?B?YlVoWGZsdWtheHRHMFFJVFVMVlNZQzNVeVY3U3NyRUx3OUZxZ09iUmFCTkhI?=
 =?utf-8?B?amRaSjl3WWUvRTkzY21kYXBxKzRVOWxad0JiSWdJUzdjOFdmK28xTDNiVERp?=
 =?utf-8?B?T045Tm0xaG1oOVdXMkRaZ1RTdnN1WmFqV3FWUGRRVTVUb1N6S0ZjUWJaNzFC?=
 =?utf-8?B?SnNjZEpZTkhQeENWVXFSd3hnaTRYMW55emNGSmVlY2w2UmJBaWNONWc5VlYx?=
 =?utf-8?B?UWVKR3pUbFkwSUpZK1RZRTBUWUtsQlZiRXluVHM1UUFiSG1GeHFMZlV0OHJ3?=
 =?utf-8?B?WXRHd2hzcDZpTGxXQ2xBVzhkOHlqMUZzdnJoampWTkNiZG02djZLV2Njbnhp?=
 =?utf-8?B?bUxmMDA3WWRIMEI2K04yR0JVcVIyUytKdElhT2cyaGtXcTlnb2V6TWZsWXY4?=
 =?utf-8?B?NTBxcUI3Q0RZNk9VSmZmaC9pMndqQVFoSzIwK1dTbWc4TGNlMnY4VWRwSkQz?=
 =?utf-8?B?dWE1SHZ0TFlJblV4di8yUmlBdXFUMTY0KzhFZTBBUWpKVHlkL2R3MXpuOHhV?=
 =?utf-8?B?SmJ3eHYwSVI0T2cwTmMxVTVqVHNHanNHTTlsVHFjODNqeXVOakVwMElTbmdt?=
 =?utf-8?B?SXlKSXovM0NOaS8zVHByVkQrUHRJV1lOL2xFTFlwVU5vb2VFQkEzY29mUkdl?=
 =?utf-8?B?dmZ0ZnNac1RJTGlHY2N3ZXJyOS85OUhRdnN4c3luajQyTmhqY1AvSzU4bFJK?=
 =?utf-8?B?TzRiamRpVDd0aWhIRFlzNHNDdmZPd1l4Sjg1VE9hYm4rRVJUSVk4aUp4RGdo?=
 =?utf-8?B?VW0yei9YN2lLQlZtcE9PWlgwSTRuT3hvdUlYYjZQN2lvQ1lOMjlyVUlUc3hL?=
 =?utf-8?B?UEQ5WWtudWtTMjFPelViMG01dU05bHlxZ0dyT0tMV0JhOFdCa2Q4NlhMZFVP?=
 =?utf-8?B?N1ZZSVpxRVR0S1dYd1J3Z1FnL0Jyd1NVQlJqbW01WTBHbTd5d3pTMjIwdmlV?=
 =?utf-8?B?MDFyQ0J6Q1ZyUC93cWJkVVlYb0VGazJWNDJkaWZsa2pSMXRweitBSnBFOU80?=
 =?utf-8?B?QWRNRE4zam1rZ043YnhDN2Nrd29veHFmQU1JM09TQTE3Zy9qQVE1bGVqallF?=
 =?utf-8?B?TC9FRE1MRmpnVjRnajJ5RUp4ZnRmRzJuRm1DZ3ZlOU10MzU5QVhNVVZCWkEx?=
 =?utf-8?B?N1dVeWY4WHlRQjJ2eSt6R3ZMRUF2dDFvYmowWUwxaFpwVVFkdEFLZjVLejgw?=
 =?utf-8?B?bHJMNWZuWkUybmFTUFhoamx4MUt1dDBVTlZKbU04akM4dTFQbHhiQk5IS0l2?=
 =?utf-8?Q?3eyNyhHyDDeRyFLfAC3OEI2zi75XzHUdOj+bXwypYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3F3D2D181065F4FA85FBC350CF45E3E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e39fc-2fc1-4c13-8379-08dc71291b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 19:40:54.2631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN2apro2UL9fd3R0XgylPiU7Pw75pWkQ6HMFAfXKKgzDwi0B94clwEtlcw7kafsBej6AlPrhqOp+HQ2apJb4wk6ZKU4tzL+R+nIY+sa0//0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5977
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

SGkgUm9nZXIhDQoNCk9uIEZyaSwgMjAyNC0wNS0xMCBhdCAxMjoxMSArMDMwMCwgUm9nZXIgUXVh
ZHJvcyB3cm90ZToNCj4gPiBDb250cmFyeSB0byBkb2MvZGV2ZWxvcC9kcml2ZXItbW9kZWwvZXRo
ZXJuZXQucnN0IGNvbnRyYWN0LCBldGhfb3BzDQo+ID4gLmZyZWVfcGt0IGNhbiBiZSBjYWxsZWQg
YWZ0ZXIgLnN0b3AsIHRoZXJlIGFyZSBzZXZlcmFsIGVycm9yIHBhdGhzIGluIFRGVFAsDQo+ID4g
Zm9yIGluc3RhbmNlOg0KPiANCj4gRG9lc24ndCB0aGlzIG1lYW4gd2UgbmVlZCB0byBmaXggVEZU
UCBpbnN0ZWFkIG9mIHBhdGNoaW5nIHRoZSBFdGhlcm5ldA0KPiBkcml2ZXI/IEknbSBzdXJlIHRo
ZSBpc3N1ZSBpcyBwcmVzZW50IGZvciBhbGwgRXRoZXJuZXQgZHJpdmVycyBhcyBub25lDQo+IG9m
IHRoZW0gYXJlIGNoZWNraW5nIGlmIEV0aGVybmV0IGlzIHN0b3BwZWQuIEp1c3QgdGhhdCBtb3N0
IG9mIHRoZW0NCj4gZG9uJ3QgcHJpbnQgYW55IGVycm9yIG1lc3NhZ2Ugc28gaXQgZ29lcyB1bm5v
dGljZWQuDQoNClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMsIHlvdXIgcHJvcG9zYWwgbWFr
ZXMgc2Vuc2UgdG8gbWUhDQpJJ2xsIHJld29yayENCg0KQmVzdCByZWdhcmRzLA0KLS0gDQpBbGV4
YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
