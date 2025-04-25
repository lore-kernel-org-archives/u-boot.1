Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3CBC369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 03:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA838059A;
	Fri, 25 Apr 2025 05:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="RnJYCnNQ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HgFPwg9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE8A8082A; Fri, 25 Apr 2025 05:32:14 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D208056A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 05:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: da43b6e2218511f0980a8d1746092496-20250425
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Msq+xzNcyq/B+2wlZw8P7ZycNT+E6YyFNegjJkWYHMA=; 
 b=RnJYCnNQzre903FWM6K/RKetxvin2ZqVTvhXwBoGqKiljeG0s1mYbNXsEB3O+r9+4IK0v/4x6dL7CpJIhMW2GzPoBbQ6EH5EXIdBhigp03sKdj55JLppyvpchduh/oJmC95JP3ObF4zP/AUnuEqwmD+HVIbggHkOtMCpR/S/H/Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1, REQID:e1df82ae-22c6-4721-8a3c-bbbe08f1cabc, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:0ef645f, CLOUDID:b762c776-5fec-4b3e-b8cb-933843551e81,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
 nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da43b6e2218511f0980a8d1746092496-20250425
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 918397421; Fri, 25 Apr 2025 11:32:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 25 Apr 2025 11:32:01 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 25 Apr 2025 11:32:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mv3f9OzhXq/Idy7lGIGDdxmwbb6KlwPfomQK8vgIn/4CKPJCK6B1bw4NMpxsq03tPb8YMg5OaZix/WCkA9+EKtnSFKpCf/WTukslnPNFHfi5Qsp0/joz1lM5vLCfLkO2BoGe/9tYABw1J2JxClipWwQooM0zzVVDa5KY0V+rZvLvXmdotxDYkpYoLT48ctfM8o9UboTjjHAZATC80nbSwc/9e8RpRg93Yiq/Zr3TFZw8LJpMGyLvOAXJYIMcNDIjLuR81GukGd1S1YQzEBI09IcBTi394/g8G/n4Qa5wxzjp8Gu7+m4/ui1r/W/nWG1st1fL5+x59VxZwZx1hy6HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujQXUmD4cIvbxGuhD769YQ8Z9GA3UZsJNquCjpcFy3I=;
 b=xOk5rq2GuHk/8aphG+2Xtt0mYtlLTJPit4QGyEsExZrEHGj31MO5v9nNjXNMi3VJ+K9KeoJD100ugjWcVrR5a2kHRlrTB1wnZiLwCxkJ+ZkgpnkbC5xprTKmukDoIlTP9kwZ7bW818aTzo+UlZ8k43jlFHlNUu/q2yJu/4V+lbg3qH5RP2xA+uLZ50OSIsqHfTLHcgz9KOl7poX0XGxKvPZ/rjRTxmcWc524Sx75AmwK3WwaM4b0CdsQBxpWcGCbXUdyrgE7JoDheO4Kv2ghLJWUID7wNyvnOIjIiwE/yso4eIcnS2C8NEcVyPIwMsxaYEXIRCjOs3eN+GuXjdJAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujQXUmD4cIvbxGuhD769YQ8Z9GA3UZsJNquCjpcFy3I=;
 b=HgFPwg9GjxQARwq8AOdUPjY5uqUqKVfLpWvXyRshiEj72xRDV1GD4hUP8c0DnwABSBefw167d/7D2VthPXg/Qb0uZhSoxcXA3znGnY0bv9p2QGYepXu+CbpntDewz6HNrdA7V+IIA9MntwQngVBnRtGJP3xfA8ZSnpDvKU/u+AM=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by PS1PPFE0A534B0F.apcprd03.prod.outlook.com (2603:1096:308::2ed) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 03:31:58 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%4]) with mapi id 15.20.8655.029; Fri, 25 Apr 2025
 03:31:58 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>,
 "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [REGRESSION] [PATCH 1/1] mtd: mtdpart: Support MTD_SIZE_REMAINING
 with unallocated memory area
Thread-Topic: [REGRESSION] [PATCH 1/1] mtd: mtdpart: Support
 MTD_SIZE_REMAINING with unallocated memory area
Thread-Index: AQHbg9rjQUqyQvq8PU2BecgFqZXL+LOv3WUAgAAqRp+ABBXQgA==
Date: Fri, 25 Apr 2025 03:31:58 +0000
Message-ID: <2239469aa60936ceb1d980baf36949927e175a44.camel@mediatek.com>
References: <20250220145808.1911832-1-alexander.stein@ew.tq-group.com>
 <20250422103732.GA117260@francesco-nb> <6153415.lOV4Wx5bFT@steina-w>
 <20250422130745.GB238494@francesco-nb>
In-Reply-To: <20250422130745.GB238494@francesco-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|PS1PPFE0A534B0F:EE_
x-ms-office365-filtering-correlation-id: 40e9a091-1c23-448f-0b0a-08dd83a9bbf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WG1qSCtwallWeU9wQUlGb0dJeUxqdmUzU3RjL0tDZ09UdTBpVmplNUNJL2Vs?=
 =?utf-8?B?Y1h4SzVkdG9ZT3kwWUJNa0xVLzhyd1B5YU5sY3NRQ0NsQlJnSG0xcXJ1dTFs?=
 =?utf-8?B?VFJQRnNSTWNZYW1kNzJKdzMwbTJ5T3JKV2xBNkU1UUNZTUNDaVBMTHAyYXpk?=
 =?utf-8?B?Q1hUQStyUnFyVEtVbjRySmFzUUNZSTFTOG1qZ3RuN09GWWIyMlU4NGphckVT?=
 =?utf-8?B?cTJZaGNWdUcwd3AyaUgwQTh6Y0dNTi9JdjBXK0FiOXB6WWhaWjBobFYzdmVG?=
 =?utf-8?B?L21laU5jTEpiTlpEWU92Y0Zma1FybzJyZExiaVdkdUpwcU1uUG8wZWZsYUxU?=
 =?utf-8?B?dXowTXlIajAyUW9leGF6T1FSUXIzVWtmc0srWmJpREJvZmYyRGNBUUNROTlw?=
 =?utf-8?B?RHNpTDE4RUJZOWxGaU1taTZwUnlnampkV0tNS2tlTGJPVkFNSGZMaHBtczdw?=
 =?utf-8?B?ZmZNSUQyYUxub3JmM2t3aVhBRHFrazdSa1YrZVR1QVlUbGM2dnBBaFlNL1BE?=
 =?utf-8?B?U2Z3d3NWRjVZRnd4VDJWNkNiei9XY2lJRUJldEFDS0JQWFJqUzBjREgwbjdM?=
 =?utf-8?B?bSthOW1RbnJSblBIb3JSUFhDcFlKa21kai9MeDIwb2x5NUNZQmJ0RC94Zi83?=
 =?utf-8?B?c3NLMmwrZW91dCtsOGt6UjdtWll6ZkY5bGFlcVpDYnRpTnU5OUVHVjJ4M1k2?=
 =?utf-8?B?SXBMWGpBMzl2aTNWZ1V1MHNDSU83NkJ3dW1JbmJ5YnI0S1N6S0hhcHdjd1Zo?=
 =?utf-8?B?eGN6R0ZmL24vREhUc3dRcVdOT3hsdWpLTEtJRTVseUVNYWtoYWlWcGtyT3Mz?=
 =?utf-8?B?UGtwbVdrZlcwc1hLcWtTTnJKWFBYMTFKeERNU0w3cmFTUitrT1pFRWdjYllj?=
 =?utf-8?B?ODcyYzZHRi9kSVRZL0U3ck5JZldzM0lCL21WOEhkTVZqa3ZFUDR3ODQrSWVU?=
 =?utf-8?B?QkQyK0VYTEZqNEFGNy9YSTBHNXBDTHhyVXJ1YVB1Wmg2aVJ4d3hmVTdxcFR3?=
 =?utf-8?B?Z0xoN3lkclR4U1ZqOTU2QmJpemY5MU5KZ0hqNm1VYis1bHp2QldRQnhpRVY4?=
 =?utf-8?B?OXczZm1remlBNzc2RVQ0YkYya0k4S204aFMreEkyNHZqdTh1MjkrYVFYQVBx?=
 =?utf-8?B?NnJmdXp2WUlNSVk4a0JKRFBmeG1XSTlWQ1dkMEpHY2pQSmZjWWgvS20yczdB?=
 =?utf-8?B?RGZRTjRucTVhTzhDNUNJcHJoNU54WnU0WUR5bHRzcW1QUnVLZ3cvaEFwV1F6?=
 =?utf-8?B?MnpSa1FBM1ZtMHIxekM1WExEWW0yTk8ydE5naVRkMEp0dzZ4eE1lTWV0SWEz?=
 =?utf-8?B?TXBMREovdTFmUlk3aldFOHZJTlowSk14MlRuYllKOXdaUzE3MmZkcVNUTGJx?=
 =?utf-8?B?SnYrNUQwSi9ydGsrZUlMd2t1TWFmb0d2NElldzZ2KzNRazlTeS93MTZ2K3Rn?=
 =?utf-8?B?NE9iL1p4R0JpczdKRlRBQ3YxclErTzlZN2JheU9lYlZXUW5mdkJPSHVkUzkw?=
 =?utf-8?B?MU1mNUNlZFhtREE4KzYwbnhYaXdYeUtReHlTcUJ1U1F0T0xjdGt2NVE3SC9Z?=
 =?utf-8?B?cUhTRVNKM1V5alo2WlB2dUFRaVR5azRSdVlPNGdLelZUanFKU1lKR21DZ3dM?=
 =?utf-8?B?MUgyQndSTjlTREJ5bXAzZkJoajYrejIwUVZwWTVSWXFHUzdZT1h5U3dLNExj?=
 =?utf-8?B?WHk2VmZzS2U2dWJWWk5wWDFnR3VPaVh4WEVDV0NZY1RkeFBXSVJYRXN4YVg2?=
 =?utf-8?B?Yy9lWFRKU1E1VHhCK2JEeG8zN2lTN24wcmtMVnlWMnNSNE5DM213ODd3NGJV?=
 =?utf-8?B?SXJCSllaNmYwS0FLU0NPQXYxSEhuTm9kdUlhZDN0SDZuWms5RXdzOHhla3Q5?=
 =?utf-8?B?b1RwU29DYXA4M3pmT202UTVsL0JDekhXaFV6V0pBTkRtS08zM25JcmlUeTc4?=
 =?utf-8?B?dm1MMFNDTFNsQVlkbVVrelEzZFBEYSs1dm9idDVteXQzblBpNnR0a1dvZVQw?=
 =?utf-8?B?V1NFQUhHblVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dERqNWV0MlBiejdQcGVDcU5PckhFNFFkZ2NGeGpNc0dUaldXb05WMThMSmlL?=
 =?utf-8?B?SmtMZ2MxN0U5WFMwYzRITGdERDhOanhDNzEwUkdOeXZXc2pqSzhnQ0dKaDBy?=
 =?utf-8?B?WXpYUGhTZnNVZWRrQ0s1b0xEODIxSGlqdE9xUkZQSXFVOTBuc0FBYkJBdnFH?=
 =?utf-8?B?cjhuZll5d2pidlYrNTcybGJEOWwwLy9Sc3FrMFBRdUpqN0dLNGpYcGtEQ0tP?=
 =?utf-8?B?cnEzMTJHMGc3TjRrM2RaM1pKSTV2WWsrbWxJbnJ3N1QvK0ZwQmRoZndLbHFP?=
 =?utf-8?B?TmhmcW03eVlYYnJaUTVGNmZ3NU5hUHdabG9GajJCSXRnUGcyMGdCd041Y2tC?=
 =?utf-8?B?b1FSek1wNzduQTN1ak9Ya1JsY2FLcmtvT2llTWUxb0w5VURDRVhEcjFJVlIw?=
 =?utf-8?B?N2NydEdrclBwVmxrRmpaRmZ2NjVpSi8ydmxyUHpNeDQ0RXVyUXdpWWZDekU3?=
 =?utf-8?B?dm5Hek1VNDd5bjRqTjBYdmcyeE9RU2VhbGtYMUd2cklTbzhnZy9wUmw1R05B?=
 =?utf-8?B?RFcwNnNTdUpybG43VWJybWgxWHpkRkdScTZNS2VsTytYSlVuTFloWHFpOHhx?=
 =?utf-8?B?QThXQi9KbFI4Z2pWaUovY2g2WDRjSzYrd0w5N1F1RFpzWm5rV1RkNHdhZ3FS?=
 =?utf-8?B?TWF2dllZN093SWcvR2QxRmk2YzlXMFZnUFVaQ1pJUFZtZkZqVzV4enArYUVG?=
 =?utf-8?B?Z1pxdzVIMUJJRENRWE1hREF5M3VhVDNYUEtoMHNOd0NzN0c4dENKVFZVK2Ix?=
 =?utf-8?B?SkQ1aHRmTEhmcEhsMDczTjI1bnN6S0FNenVTTklFVHR3WHFOYUNWTE9FQVln?=
 =?utf-8?B?YlJEZWtLVVB2S0VFM0hGTGJoRGdqdUhMMStubnp6V0ttR1JWVE5zYnFwNFVp?=
 =?utf-8?B?WnNGdER3TGxOYTNHYmlIMU9HUXczV2pvVlRPK2M4WEFwTVI5SldJdk5CMFF6?=
 =?utf-8?B?aWpSaDA5Zkc3TDNncUdNMno0SklsbSs3L2J3RWxIQXB6U1VxTVg1SEZoNjlm?=
 =?utf-8?B?elFJa29CbWtpN0VEOTY1QkJIM25Yay9pTTdmblhVTE0wSGxNOFJnenFOS1ky?=
 =?utf-8?B?ZXhRdk9ITVN3RTUrUWp4OE9uMGRZK3poZ1RhbFJZandwQlBIZmtway9ySHg4?=
 =?utf-8?B?ekxMdHhWK3NETEtKanlPYzdhMStkUG83Sk1ucjNuc1VFVmVDd3p2TXNnekdk?=
 =?utf-8?B?a0tXQkhiWjRGSyt3MFk5ZEFVMlR3KzZUcHNhNnEvZ0F1NHFQNVltUklUdDRk?=
 =?utf-8?B?QnZ0TXJ3OHNGcHZlR2txZmlvaUdtTDFaR3ltL2dXbDAxQkkyd203cnhJTkcy?=
 =?utf-8?B?em80ckJWcUtva2Qrb25sLzNxQ08ycU9hYmVSZjJ0Slovb003UnppQlFwQ3BM?=
 =?utf-8?B?dk9UREFWTGV5Rk1VQy9GZTFEdDA4bzRJUzVlWjdUbzllMGJsREpXa0hnTWtw?=
 =?utf-8?B?RlI4QTZmelExZHd4ekNMNGp1QXU3VWtLWkZFdWZVbERTSkV3dWIyeW9jV1BY?=
 =?utf-8?B?Q3J0V1RmWjRVYkM5QUZ0ekw5bXBCREw1by9mVzFUZHpFWUFldmEvaFBoSzlJ?=
 =?utf-8?B?eFF4QnJNSXdtNVUzVUxTSGJrZEJaQjV1eFF4RTVKTTY3NlB2T1JTWk45NWVw?=
 =?utf-8?B?NUNMQ2JQSk4yWUhpR2doRnpDOG9zSmlvYW5GZk92UDBCdEM2OHY1TzZXMmk0?=
 =?utf-8?B?UWlFdE5wc3JBR1FhTEV3U0tMdGpXTWRtTU5SeUxuMlRLcGVjSStQNEdNeGNv?=
 =?utf-8?B?QjJzU0dXbTVwbS9JT2lzTGo1eXZCbFIvWmxVdDhxV1ljUnVFb3Y4OWVWNWJh?=
 =?utf-8?B?NmV1L1NhU0ZkNHBvUER4T24zVngvaXRtVFdNczRTTldXODNuTitFejV4T0tN?=
 =?utf-8?B?dllRZ25WWGdPRnpuT1NscWdneS9jQ0tvZTJPT1VyMnR1MmF2dGZ1MEZSOHhx?=
 =?utf-8?B?Z0FUdGlETnh2MmU1cjd2ZEg4ZjhPMitncVR0dTVwU2IwNWVNWXdHK3lueEpp?=
 =?utf-8?B?d3kxczNxZnVRMU0yZ1RtU1NWbnNXUExLcjV0QWFmSWRGdzdsb2N1QlRSM3g1?=
 =?utf-8?B?WWZGZTJyZmw0UE9QYXVLRHhMaHpNVlFjU3pQV0w3M2pwWEtUelplMXZyQmVL?=
 =?utf-8?B?SXlHcTJtNmF1SUZZbW9TNGdVd0lyemw0Z1NhQWpDMkJxby9zOTE3U09EMFNC?=
 =?utf-8?B?NUE9PQ==?=
Content-ID: <D507755BE4C9974F95991DB4B8A0C08C@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e9a091-1c23-448f-0b0a-08dd83a9bbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 03:31:58.1985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0aBeSkwFhZXM3tYe7GMP2ZbodPjIujZxLJXgj78SUcYTgF4VvkdmSoWXf/ysctDlcPMjF/6DER8UNcdH6XEMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFE0A534B0F
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDE1OjA3ICswMjAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiBUdWUsIEFwciAyMiwgMjAyNSBhdCAwMzowNTo1OFBNICsw
MjAwLCBBbGV4YW5kZXIgU3RlaW4gd3JvdGU6DQo+ID4gQW0gRGllbnN0YWcsIDIyLiBBcHJpbCAy
MDI1LCAxMjozNzozMiBDRVNUIHNjaHJpZWIgRnJhbmNlc2NvDQo+ID4gRG9sY2luaToNCj4gPiA+
IE9uIFRodSwgRmViIDIwLCAyMDI1IGF0IDAzOjU4OjA3UE0gKzAxMDAsIEFsZXhhbmRlciBTdGVp
biB3cm90ZToNCj4gPiA+ID4gSWYgdGhlcmUgaXMgYW4gdW5hbGxvY2F0ZWQgbWVtb3J5IGFyZWEg
YmVmb3JlIHRoZSBsYXN0LCBmaWxsaW5nDQo+ID4gPiA+IHBhcnRpbmcNCj4gPiA+ID4gdGhlIHNp
emUgY2FsY3VsYXRpb24gZm9yIE1URF9TSVpFX1JFTUFJTklORyBkb2VzIG5vdCB0YWtlIHRoaXMN
Cj4gPiA+ID4gaG9sZQ0KPiA+ID4gPiBpbnRvIGFjY291bnQuDQo+ID4gPiA+IEZpeCB0aGlzIGJ5
IGNhbGN1bGF0aW5nIHRoZSByZW1haW5pbmcgc2l6ZSBqdXN0IGJhc2VkIG9uIHRvdGFsDQo+ID4g
PiA+IHNpemUNCj4gPiA+ID4gYW5kIHBhcnRpdGlvbiBvZmZzZXQuDQo+ID4gPiA+IA0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1n
cm91cC5jb20NCj4gPiA+ID4gPg0KPiA+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZSBpbnRyb2R1Y2Vk
IGEgcmVncmVzc2lvbiBvbiBjb2xpYnJpIGlteDcgYW5kIGlteDZ1bGwuDQo+ID4gPiANCj4gPiA+
IGBgYA0KPiA+ID4gQm9vdGluZyBmcm9tIE5BTkQuLi4NCj4gPiA+IFBhcnRpdGlvbiBzaXplIG11
c3QgYmUgYSBtdWx0aXBsZSBvZiAyMDQ4DQo+ID4gPiBDb3VsZCBub3QgcGFyc2UgZGV2aWNlIG5h
bmQwDQo+ID4gPiBGYWlsZWQgcGFyc2luZyBNVEQgcGFydGl0aW9ucyBmcm9tIG10ZHBhcnRzIQ0K
PiA+ID4gUGFydGl0aW9uIHViaSBub3QgZm91bmQhDQo+ID4gPiBgYGANCj4gPiA+IA0KPiA+ID4g
UmV2ZXJ0aW5nIGNvbW1pdCAxY2E5N2VlOTAzOTIgKCJtdGQ6IG10ZHBhcnQ6IFN1cHBvcnQNCj4g
PiA+IE1URF9TSVpFX1JFTUFJTklORw0KPiA+ID4gd2l0aCB1bmFsbG9jYXRlZCBtZW1vcnkgYXJl
YSIpIG9uIHRvcCBvZiBjdXJyZW50IG1hc3RlciBmaXhlcyB0aGUNCj4gPiA+IGlzc3VlLg0KPiA+
ID4gDQo+ID4gPiBBbnkgc3VnZ2VzdGlvbj8gSSBoYXZlIG5vdCBsb29rZWQgYXQgdGhlIGNvZGUs
IEkganVzdCBkaWQgYSBnaXQNCj4gPiA+IGJpc2VjdC4NCj4gPiANCj4gPiBIb3cgZG9lcyB5b3Vy
IG10ZHBhcnRzIGxvb2sgbGlrZT8NCj4gDQo+ICQgZ3JlcCBtdGRwYXJ0cyBjb25maWdzL2NvbGli
cmlfaW14N19kZWZjb25maWcNCj4gQ09ORklHX01URFBBUlRTX0RFRkFVTFQ9Im10ZHBhcnRzPWdw
bWktbmFuZDo1MTJrKG14Ny1iY2IpLDE1MzZrKHUtDQo+IGJvb3QxKXJvLDE1MzZrKHUtYm9vdDIp
cm8sNTEyayh1LWJvb3QtZW52KSwtKHViaSkiDQo+IA0KDQpJIGp1c3QgcmVwcm9kdWNlZCB0aGlz
IGlzc3VlIHdpdGggYSByYXRoZXIgc2ltcGxlIG10ZHBhcnRzOg0KbXRkcGFydHM9MjA0OGsoYmwy
KSwtKHViaSkNCg0KQWZ0ZXIgcHJpbnRpbmcgc29tZSBsb2csIEkgYmVsaWVidmUgdGhpcyBpcyBj
YXVzZWQgYnkgdGhlIG10ZCBwYXJ0aXRpb24NCm9mZnNldCB2YWx1ZToNCmBgYA0Kc3BpLW5hbmQ6
IHNwaV9uYW5kIHNwaV9uYW5kQDA6IDEyOCBNaUIsIGJsb2NrIHNpemU6IDEyOCBLaUIsIHBhZ2Ug
c2l6ZToNCjIwNDgsIE9PQiBzaXplOiA2NA0KcGFyZW50LT53cml0ZXNpemUgPSAweDgwMA0KcGFy
ZW50LT5zaXplID0gMHg4MDAwMDAwDQpwYXJ0c1swXTogbmFtZSA9IGJsMiwgb2Zmc2V0ID0gMHhm
ZmZmZmZmZmZmZmZmZmZmLCBzaXplID0gMHgyMDAwMDANCnBhcnRzWzFdOiBuYW1lID0gdWJpLCBv
ZmZzZXQgPSAweGZmZmZmZmZmZmZmZmZmZmYsIHNpemUgPSAweDgwMDAwMDENClBhcnRpdGlvbiBz
aXplIG11c3QgYmUgYSBtdWx0aXBsZSBvZiAyMDQ4DQpDb3VsZCBub3QgcGFyc2UgZGV2aWNlIHNw
aS1uYW5kMA0KRmFpbGVkIHBhcnNpbmcgTVREIHBhcnRpdGlvbnMgZnJvbSBtdGRwYXJ0cyENClBh
cnRpdGlvbiB1Ymkgbm90IGZvdW5kIQ0KYGBgDQoNClRoZSBtdGQgcGFydGl0aW9uIG9mZnNldCBo
YXMgbm90IGJlZW4gdXBkYXRlZCB3aGVuIGNhbGN1bGF0aW5nIHRoZSBtdGQNCnBhcnRpdGlvbiBz
aXplOg0KYGBgDQoJCWlmIChwYXJ0c1tpZHhdLnNpemUgPT0gTVREX1NJWkVfUkVNQUlOSU5HKQ0K
CQkJcGFydHNbaWR4XS5zaXplID0gcGFyZW50LT5zaXplIC0NCnBhcnRzW2lkeF0ub2Zmc2V0Ow0K
YGBgDQoNCkl0J3MgYWxzbyBlYXN5IHRvIHNvbHZlOiBjYWxjdWxhdGUgdGhlIG9mZnNldCBiZWZv
cmUgY2FsY3VsYXRpbmcgdGhlDQpzaXplDQo=
