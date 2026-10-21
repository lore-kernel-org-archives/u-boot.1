Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C361606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y0cx8dBY;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxmxKrlY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF40F80F77;
	Wed, 21 Oct 2026 04:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaIKnTlNXabf; Wed, 21 Oct 2026 04:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6D2A80F88
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792558482;
	b=nolcR/9A82NanngaTddR8PjsavcqAUHCB+HS0zPZJyGXfeBktkBXN2K/ZEmfUztllcSC
	 pCkLaKqv8WlQ+TCykx+hDCf7JOQZhhGmDACpNRXPpfL4EYHqtgPw81O0tjZdUunJLOdh9
	 sPGHtuzIVMn7eIvL3Wh4zgkOJp6sUpl/AZOo0zq3ht9op1gNmte3NHKHpGIA/CUDdnA8E
	 jVbM7prPTs+fHtIRh3Mxkl5HIEneBkJGvfG4pUhSJAVcpuvVQfKpb9XA3OjT3dDdIBLTE
	 7BQc/1rE3RH1Zz0B2h3z3Pk/Kx5xeiVgwl2XAIyq4frRSssoyHfWhSgSAu0K9KzTAnA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792558482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IPeFDBoItIRgAcn1j2z56GOV1XnPbdniZOJ3Vb1rLg8=;
	b=duZ9mmeVlUeQrVOoBG0JKs78DmEzzhyDT2xHEjSBBvhbG9NhMvykUN9rmdvK7wdLEV6v
	 6zkWVyxidkg3fxzOWiaMh4M8gfo3yUwTpdmA65k4fGiWMPftXlMD/BsR8+lUTQm3Zi5aR
	 PvsNqd7uIilsJoX3PnasobC5WTnAd5pS249qceiL2TU3vVqTkfJK8b7FB1JjF8VDRkUd+
	 mxt4pi0D6kLBEsR9TMtZ8P16FLRkzZzwiBSpdBSOU/4f+m8HQQK4jKQzVNwVJomj4hRP2
	 M+Ox+Cv6UcsYHQCUbM4mHKYopq6KJHP650LfUzTETjN2P4neIQKmlk6TRkSN1VN5dnA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxmxKrlY;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792558482;
	bh=IPeFDBoItIRgAcn1j2z56GOV1XnPbdniZOJ3Vb1rLg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0cx8dBYGsJQK+RtzXljWxV0bFgjeZHjPkY2YUtsh40uBsbF70yPwdXHVdq3jEJUS
	 FMOXndRP6yTiZzLfadBjjnAzCilnugzA3or0yChRsUDBr8UMWjIl5Aqdb1+EYiPbCm
	 i40PViEP4IXdZSKf3nGwigjxDqAd7tB6e6C66G9XGQkT+kkP79LL8U6ZIpeKenqubj
	 aoZ1RINq+WhSsHwCMWPQ6N+4y79OSKb3OYEtyYgdqm32xHDCCIt6RtZPorWka6PMJY
	 OdADRkSnxkw+mRccPUdlVnfWB+x39c7R1cK7YH3XsmGumYJ+ZE7GYzqCXIvsCQ0n0a
	 T5LkXXREDG9xQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6D2A80F88;
	Wed, 21 Oct 2026 04:54:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DFEA995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F52080F4F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NUeIuxWemd0j for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 04:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E920E80E9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792558479;
 b=djJbNy1uRN7Z6dnDJzUmV7GNhY5taeMbMgi/vjTjoCxqcVg3vT+f4KrE/SFjNEvmJqGF
 RMHzxY8EheagAADVa00Kg51QXCW0zJUKsD9elojMXDjU/sdsGRp4t6aLlilkl7dXtTrTv
 FyW1zanzPoBgppQrIJXmWY9t9YC6dV9NEdhFg86Vs2eWpgNcbNfyqWsU9RSQISiW+H3Nr
 PuesWb5Ad8h4ELewLnEROrGBeQq7rpFqesBT3TCdPfyCri7jW9mwfSRhZtvGjqNAsLEjr
 1sEDKJrWWL/M2ViQeJuitms+tjx3y9AHaLGj4Z5w88L0EAisAEd8uOFAY2ut/T/Kl4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792558479;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=IPeFDBoItIRgAcn1j2z56GOV1XnPbdniZOJ3Vb1rLg8=;
 b=qmEvHGR2+B/WWetwW6fp0MZqsoEPJtqd8valDlEN+k0dmNAN9d5WKCacLEUp5yoSRUIw
 gNsVde6N8O/6UyxA0CunSr6bJHhe4y3e/Wy3ycS+KEDrE90SUnnwNFiR3l3Q1I1PJSRRY
 f1D8ay3y6z4YGyRsRmLycVoQzUQ7moIDRW1FCv9v5Gg1FTkz/ne9vLup6bEOtfAcN/Ms8
 0ipAWabBgecTx7UOBuksaSbNwN8DXnXGrTi9HzZe0NAeHLXPO4YCX8rJyi7vsZ1ARMMq3
 VNOP7Dd/HoBs/QhxieblcHI3cVu9LMn6o1oSrf7vWw51RUSiNYAUVlMBKxaYXENdBiQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxmxKrlY;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FxmxKrlY
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E920E80E9C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXxPZLcIMc9mUf+xu7a7c9eX2XJ3x4W2qS5OHXGsJcGn6hI/AnQxgXlUBfvxYI9mDFPJlkBpSrNDyZ+0ahlu8WAlZWANmkw465CSOkntRsT5yEd6EOQjD4vqPmhcRa8mHlOqtJxgicsEB4laUlF41Lw4P/ZCXfkijyRZWazcEg8DTxl0CYvhwiNm15Op97Xktp+1JAHu2nMYL8fOpSCBslqGOF5sUtv9eWrZDBG2GiUWoRsbTwrJa8jQmjvoeXv4iErW1Fq/klzXSLKcJKaOt27beY75YCdzo/7ER3eL96Afg8rACdWmPI5ke+lXkvOx2fhkKIdml5y1uWrFqhoeBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPeFDBoItIRgAcn1j2z56GOV1XnPbdniZOJ3Vb1rLg8=;
 b=NfIqsCEhPvRUy4PTrmnkyXtbo9futr5Sxkgrk7XMEAKKIA26KKMAj4EDQgTXCE20mG860mEYXtS0VlyMcX1qIA80At8BW6RcFfGvFfl51EWgwirUHCsHtyMPEFrHetxkdGbBGkr/Kb2DmOPZW4aiDwIoBRNmDMK8YLnNjMyhjWA5KvJ7SkqMC0GIglajJLWAF7qasR69tJ/dogMzlB9CB/88CHCANf8Ko0X/fj9+DQSuKsJoyDRe32HeQnGXqgxDzL9Q13Vl+bZm5rSqnLflzqKRTsH42UBsa/EP0x1yYYF25fjBhEqUAo4P6J48Oh5/S9d5WNQw/J878PUh9Fr2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPeFDBoItIRgAcn1j2z56GOV1XnPbdniZOJ3Vb1rLg8=;
 b=FxmxKrlYbOjFORKIoWpQolOPci4qcyRrp/xnG2GhoV8JWhsFPw2My5FbiaMpzA95h3qoCosHTgGuPhm62OJzXxHjpNlqC/k0ytqr/epsks0sP246ri+dlbPspsVlSNLH2oyJbEW4w5L+yVMxSsWBSzOHBMoD4oyokFqjb2N5ABNgRHKv0Z4k0ur/CTf0TrUX031bIjtH9graFqCj+eMA5seFnXVNPVFZCWKZdO+FmhMTCjnTY3HWUr8g4FEo6rKn6Q1voUR/CZxLwwuu8asmiH61dFHcTg0ZhKjiLj+NxlR9EdLpizcVZtrqkfM27sLnnbgG+qtSXFAMShQ8tLRycg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by MIWPR04MB177538.eurprd04.prod.outlook.com (2603:10a6:290:ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 04:54:33 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 04:54:33 +0000
Date: Wed, 21 Oct 2026 12:51:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Beh??n <kabel@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
Subject: Re: [PATCH v2 00/26] powerpc: drop unmaintained boards and SoCs,
 take over maintenance
Message-ID: <athE5KyKe3No2qz_@nxa18884-linux-1.ap.freescale.net>
References: <20261009221017.20385-1-brads@mainlining.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009221017.20385-1-brads@mainlining.org>
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|MIWPR04MB177538:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fb3dec-fefa-4bf2-69d0-08df2f2f660c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|23010399003|366016|376014|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QTS7vuuF/DPF90YpgtJSqxGwR4v9U8ofy8Y4pOogiVNhJ0zC0pKKSja3Lo7OI5h0LunvznJaLjbuDLpaZCCBiunulJOaZVHYPkVebwuoJEoYWQf/OGkwdwcqiBYM3J52nTft5v9cLAVW/cn2Eg6u4v9bVIeAIIzYgNUkTNUz6Q9ikoeC8izPRnB3Ht7UCcCfdHaPf49O6+uoEiaK2r6In4b/59xJI3BqckdLCPBD8UHuM8pApgY6/lfMy504A897RoX4bIRCoqKGd64Ol7oNMkj2dwdc+XUm+FsbKysyVwKf9MMrLM1RCzZv1SLOKAUA/zxKrM84DzAZPuL+iqa2NsnPQTx3T+u5Vp6UTBKBieAgeke8ghnlAKmVkeS/NKKTQZmoIz9q2gkteUH5jV+BUdY0zgEIvX3dVlEQ4nZWahcruOJlMcFLf4vjfFcy9AMg4dNZlZ94ygZY9r6tiHn50VHx4xgFX5G1p5ED8vx1mxk7duaH/lPuFc5qOatv+3OUy5trZnbxwcv9Ky5sbkgLq/+8YCK7jbEdtyE62x+VGkkCNo5mWOz77P6oplOAz8Xruw3JxjmJarsEaEiNNX80RQ7soHQ2svMdo17lojWmetYO6pA6RR6LtMrD4o6RUaGMgycf4x3tBc1Tfw7Q6brloqXN0ETK2huNsy6chejfTZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(23010399003)(366016)(376014)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IX5bt67cxunYVYKwaAIDK7pE0kA7S36iD4OcIT/03CiWFMm+JYcXY7uIXuM?=
 =?us-ascii?Q?okWJKKTyE+cdwQa308NCEZXjf300Y27MKfPjDxBOM0Bw38AAljPN1+xt2Ngg?=
 =?us-ascii?Q?N3+GznOIathCk64kn9LpMNORC1Dc8IoJeUPJiftfb73BLEXtVPj4IiCuaieB?=
 =?us-ascii?Q?Xk3fIGyXvbH1nYsjSitMNiSwzTGXSfMEr6TvDtKUJ1qH4yg3cvI386kyTNbn?=
 =?us-ascii?Q?2UQn4SiqttY0gDVHFFH4eJn8x4zWSlO+4myt+D5gZZRDYsDcZdDmyAy6Rsz0?=
 =?us-ascii?Q?e7ri2C2bWHvX0QRhjcZjTVxK9dLgO5VzkrslTv7QdgPThB1rJaJZElLPMwBl?=
 =?us-ascii?Q?5pClaWdoIlyt7Ic79UkepIzYi22J9WAzRNzp+shZsuwvsGNoNE5Uhzue58ym?=
 =?us-ascii?Q?ycIJcdo10XMEYil8ua+YsQED7PYb2Dzl0H1W6B+lC5wV6Fef53TCGhs+I7Z5?=
 =?us-ascii?Q?afRjabU2TjTIwO9+50UgIuMa0g2+o6orhGB/nw5FZHxJnNO5M9jh6vF4Swo9?=
 =?us-ascii?Q?OlxNK1kFXd4Sn0cMgsSHDaA6foIqhTRTtuT2PGZuFQSMHi5+pvkp6BKYO6An?=
 =?us-ascii?Q?6R8MaLuk6PedplVL4c1LCmW2BV6oVeP5Nxvs6FyII1jyUZBSvM4uNsMu3lB5?=
 =?us-ascii?Q?i15t2ct6ScSwVR6kJcOlVK+FBGGgtpDEInJst36JHgHauMPzaILgxmxM6p6R?=
 =?us-ascii?Q?GdOdcgsD+Z1LwVz4U/owFqtOp82eKctasFrSm8fsZbCJ9z4xHMZDgRp9a1fs?=
 =?us-ascii?Q?knp6XVFsGydEV2NamaLRjRfZhKl6P6tjVLK4LQxa6C0V4C6NFEktoOJ3BQmq?=
 =?us-ascii?Q?iVZvXLQoDL7wZONDuevzXpcvY9N8QtTrLGQISCuq8BzsFb5mShj4ZoE9SB2z?=
 =?us-ascii?Q?wza5WJqfd6vGpcOzkzcY7LKQymOZkK8WDxgcZTXDs1OgySUNI+yMOuvrbCoo?=
 =?us-ascii?Q?Xy27smMhSrYb6JeAltVo5GWkJsekU1a1XaEvsp0LD3eKVyWE1AWTdK0l/ShN?=
 =?us-ascii?Q?jGtA8bggiDvAGDi++vnRqCb9Uf6pLCs/5tUerEXmCsOGs3xU4gHey4i56IzO?=
 =?us-ascii?Q?aCXEVel04JZiBVeJWWCgFnkNlCOVzf+cGcLA78Du+USaBEEkQmNc0rnsdWqX?=
 =?us-ascii?Q?57Pez+L4yBhhEyuZM2a1tS4RAsabYYFhGTl8rMSGoRoOVPp6UcVDcxNDoClJ?=
 =?us-ascii?Q?ABFdZWHyFz2y274JXUMa/JdQRC/IYGQOODzTSQhluVi6xwjQ4leVR73JWZyu?=
 =?us-ascii?Q?CBS6DbrnAQt2oBeKDeQy01UHUxO93FEVfXYK9b/SboxI439Eo1690c9MB6P5?=
 =?us-ascii?Q?DaQSBi8Zl7aXp2RO1hChCrTjuiqz2f2N7JFu/RH8bh0UznonXKoXKAJ5tfal?=
 =?us-ascii?Q?0KtzEkXwfGhuQcHRvQQ6q39d7VkF1Xy7kCRyDW8tk8ETVQaqDm2S2Tx3/Kgj?=
 =?us-ascii?Q?CLYMpT7vKRPd+YhNdyNtcGB42YVZazWg8VPqVKmUabUyonGPnMl2/6YcYyyM?=
 =?us-ascii?Q?5IxLBTbGDJz4j/8b66IBHg1qenVrbwMNTjH2q5nD9Yyw497lXVZ3HzJXM9uG?=
 =?us-ascii?Q?eBs3oWo5weBQV9tAEH32El23zK7mC1gu5BbOwuc3qNo84Z6Pd9yWlfJL/UHq?=
 =?us-ascii?Q?9+55uaC/2eUBS+U3FIu0CUuXG1hBnjnX7ZuV3dTgTjIb+JgClx7o/yDy+5NU?=
 =?us-ascii?Q?y5upbJlpy4yDdkGPPqO8Tw5uIEYAiw3/vgBNv+NnkdkguQGBSC81uWxH47Wi?=
 =?us-ascii?Q?QjnfRXEZsAb8Zdb7QevZOcyWQoBZqpSwhfLCvOtxBI82WKU1RFnt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fb3dec-fefa-4bf2-69d0-08df2f2f660c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:54:33.3608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORpVkvZRIFK6dR2nL8vrIzznlPRCNniKY3l0qWwT15rNRH8Yg+Y2ianIYb9JemHWknZfOD8F2G5QYx6ZBJTHGdp1c8I+WjZ0JlEja5w+ZtZNAzAZuR5GuMCbjjSkT333
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR04MB177538
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bradley,

There is a build break, would you please give a look?

Building current source for 1 boards (1 thread, 32 jobs per thread)
   powerpc:  +   qemu-ppce500
+In file included from arch/powerpc/include/asm/ppc.h:36,
+                 from arch/powerpc/include/asm/u-boot.h:23,
+                 from arch/powerpc/include/asm/global_data.h:89,
+                 from include/init.h:30,
+                 from arch/powerpc/cpu/mpc8xxx/cpu.c:11:
+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C291' undeclared here (not in a function); did you mean 'SVR_T2081'?
+ 1129 |         { .name = #n, .soc_ver = SVR_##v, .num_cores = (nc), \
+      |                                  ^~~~
+arch/powerpc/cpu/mpc8xxx/cpu.c:79:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
+   79 |         CPU_TYPE_ENTRY(C291, C291, 1),
+      |         ^~~~~~~~~~~~~~
+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C292' undeclared here (not in a function); did you mean 'SVR_9232'?
+arch/powerpc/cpu/mpc8xxx/cpu.c:80:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
+   80 |         CPU_TYPE_ENTRY(C292, C292, 1),
+arch/powerpc/include/asm/processor.h:1129:34: error: 'SVR_C293' undeclared here (not in a function)
+arch/powerpc/cpu/mpc8xxx/cpu.c:81:9: note: in expansion of macro 'CPU_TYPE_ENTRY'
+   81 |         CPU_TYPE_ENTRY(C293, C293, 1),
+make[3]: *** [scripts/Makefile.build:272: arch/powerpc/cpu/mpc8xxx/cpu.o] Error 1
+make[2]: *** [scripts/Makefile.build:497: arch/powerpc/cpu/mpc8xxx] Error 2
+make[1]: *** [Makefile:2228: arch/powerpc/cpu] Error 2
+make: *** [Makefile:189: __sub-make] Error 2
    0    0    1 /1              qemu-ppce500
Completed: 1 total built, 1 newly), duration 0:00:19, rate 0.05

Thanks
Peng
