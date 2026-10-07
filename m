Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3736FCA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 08:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADB9F406AB;
	Wed,  7 Oct 2026 08:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwVhC1dvzWkX; Wed,  7 Oct 2026 08:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E91A6406A0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791360285;
	b=inqVrn9WwvV2KvSH+8XKZMhYpVu9bfmqExK50ckncHoMyNQSNzAwvswLzOHvXJpkpi34
	 AoKpkaP9e4f2u/Ek5fEb6zE9WPSXr9UsrVGQ4QLQSQ6sR4+szcuuVQFYppH0kFOF63HNW
	 5Yz0EFfkdKTdiMfr0LpmAoy0qyjjbRMwA7dzp+wMzhYlPvSj9dPtLz9kGet9fayKy4czk
	 AqnEUGR7Xr7IYv17aQe2EFmV4vKsgVefdyjw28CodRxwsvQUeVR+DBdrggdK82tF5KjUY
	 ZsfSvdaDaGsnY3f2uv4XYW6/MxDw2QmuxjpEiSQ75H+VARVSZQDIjqcst6MtjtsIZdA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791360285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=zXHERu+CeYws4jPcAtHT5kvcY5sZy4758E8g/ur+Pmk=;
	b=SBCwdUP0IXHmJ+0jNM5/Ca2YJTkqrvf4tFgBaT2j82N4LVaNrMR2tr+JKrySy+JrrE6t
	 v1WbOquu41WkuNL2fYRNIHX8Hj/SUYMJS5OcSG4613yEKDyit6bbr3qibDjq/XgLMPWTy
	 f9zV2F3uJL6JDd+ca3bd5fDwaaMjup2Slliaax6c0ra0sSZyjuK8kzb2KpRrQ9SHyQWVT
	 9RI0BQFrDN5RtCaLVRPkt9ouq/8iZoHC60l6hmTJvebQjK3/W16iGeXNW3Vwk4m1H4g8Y
	 ry8Ns2ZUT4ql9EkfDc839FSCrjP8Hcy8SdleaNN41dDplvhQo/OcJL+cNhHLZOQB70g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791360285;
	bh=zXHERu+CeYws4jPcAtHT5kvcY5sZy4758E8g/ur+Pmk=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tAMvlsOv+zNsW+icwOVxJDaHCm5oKJ+UXEtBZ3Yu1M9TUKrSUGSCuytZP0NJ+B+Yc
	 PjugNlv94p3/MLnOOEq9cV1vgceXLG/1rqz5YDf9u3+axWUPC+JWzrw3yH38z8LI9L
	 q25Q2ux8eb9W5ekIGHvTtFuRodT4TWtADEIXLIZKul6NAgXFKNogAZmmiVhNkqP7e8
	 PhUasPGn5SUMyHG7Z+8AfZsEKCeVmElbGnKxSs0pr7m64eXmPrMScwhWaNJtezNhsy
	 HeHdsaDuw0jzJCjgCXDNiNNGWUtSe3v4Fw0oD1z0p6wWxCsde9CmL6uV97Wif/mX7Q
	 afnGtm+61L9NQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E91A6406A0;
	Wed,  7 Oct 2026 08:04:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9512A317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AF7C40062
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZ38Ae-o3iag for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 07:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B791E40070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791359694;
 b=a3RCLiIupCd112q6aA0SLS+eF1D8lpRicClI5LAHfsH1KuVGNs26xh0ENiiOpr6ZpDm+
 /dUHyyyg7rvAqZD5VLanZs6Yx3Ovcw6Bma95n4jIp5G0ZIPfN/JsUlrTmvSMQK4rChf31
 1DqQH4+1aaZrEU+qxxsxvj91lckLcWAMyQQP04nYvFCMbus35kH9kdmlV0XnOTZF4SeYd
 vD6TgqUMh5+Mt+AN/KPm69LlEb36QrRYMiPNQCQ9wRNirTOS5ukmHN+1EiPif7gxVusa5
 0qQSLVdiB+779pJDIdM7CUOSNSfoeHidAA9Y6u8r3msJXD3jrTVyvLhRRFNtdTFwUmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791359694;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:From:Subject:To:References:Content-Language:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=zXHERu+CeYws4jPcAtHT5kvcY5sZy4758E8g/ur+Pmk=;
 b=YIjSzsxiAO3dZgP6A6EWyDF0C8a/mpagBQv/dDsuhuHBvbGECS/UrXpYeS6pvYbXc4uG
 FtmmcNZ62q3mvCVF8wn6jNM65P6F9bdR+chKSIIjKFZcMOAFuUBYAm4rrnjiIojIfNcqI
 L3s1ZzlOp4BuQ8sFs9tGvIa2WeuRhnM+BiEmGK7JhhOdNmeSWGtyxHIX3b218JuUu6ejR
 KNL9O017uG12NhC51KSuo23MlXKs9I2raxsJQED7Q/lqFR1n0l2uNqFfILKINlASgU20l
 VAZwFTK017U4CPD0XBJJpJHPhvR99FkWinIpcH0V5JQ07z6/NZF/m0Q63keLQvbjBvQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=kontron.de; 
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=nLxomN5c; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=nLxomN5c
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B791E40070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 07:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MePh7tvhXpuYqELkp/cJSj5WF7lnBz5TGi1Q7Xm02bNnjpOw4oHHdLfF4+3pkqSKfkIsTYt/sx5CkOGQ0YKp9UJXf/s/qa9HS03SOZZWKr5/cuQ6MKFPyV8o3P5s4GscG2QPFOGhAjc50L/Wp1t6f10SHGHXJN0/HL42eNU5BB7x1hdTJQ+85Ia6fIDLppzypIl3uFXe8XsPDauuszGl4/WYCHXh3ZX80mNXQ+3womDZrq6KGpwvdwH4k3cit+vtOhoT4G5s6k5rPBoRoZrkA+tm4s3BErYm0Zcu1MsxgBPBs9MEwbJnx86Z3yYUC5z8+VoIdLY+swbq1UGZoj6USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXHERu+CeYws4jPcAtHT5kvcY5sZy4758E8g/ur+Pmk=;
 b=m48kxfDowAf9N7ZKto+ZWStt8yCX54Iachd8sqgG5lJak4/ya7SRT+WqEDrAXGVQo1+JJCFrTWHDBPOTs9m3KAfUTK8zg5H+AA0OSUPxvmOF5DNVTgZXhOaP6ypFyDtYDIwfmQIG44g3/Uf27/9PVbqvwqRPNrsHF4B90Crxz/nWPUJv6i0s5HGICVoLOPLODP0kMMZpxp7WrAleWWt3eEzZgsMmrNy9qDJUURx0LInJNljppsT6rS8FJAiAjWuz0wRaYBF64gjdvn5FDNYwMxNQqF30pImKFpdaSWGsI4f1T9YGatPbDxqczOV6kFjQAX5qL5R6G/cLmhmT4lV/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXHERu+CeYws4jPcAtHT5kvcY5sZy4758E8g/ur+Pmk=;
 b=nLxomN5cty1nPAQ8+++fpd71y7YjldZ72uaw3U7RqnshrFPJAyKG8bFlXMQIK+Nyf4/Yn75fAoI12KTWNPW79OBev0nFJkgvBk6Krt7ohx/dZRW/VqHiOjSHQifLPjrmjwOM+ZYb3L+0SkPeSxPQHwKlB4mWiI/RdtPYfKT/TZEEFFbY63SEa8dhNYA8QcK1tTEYcR3pv7QH+fnfc9PjuT1B8m1XyDlxD7NuV9ig5bUeQ08Ppa/ysgCSdbyW1RsrPpB9/sGkwOvBLj43XGq2jH381GUHHxXkI4XxCiX82U07MaZN1F/N5ZT0RLkSDQvHzesk6lc9BLRfl5e+gPg15Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e4::18)
 by DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:301::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 07:54:47 +0000
Received: from AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536]) by AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fec3:eb34:f163:4536%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:54:47 +0000
Message-ID: <8ffb90d8-4717-45ff-87d8-145f9271811d@kontron.de>
Date: Wed, 7 Oct 2026 09:54:45 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 1/5] spi: spi-mem: add spi-mem caps support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20260927235716.1872707-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1e4::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR10MB4273:EE_|DB9PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0b9e29-0939-492b-d686-08df244841b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|6133799003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: wgRKgknMg6eoKvNBS2J1/XdfRsquH2INjWtzsxZbN/bNgOql5hD1lLXCZ6AVysJ15O8HelxcNZ9OsJND/9845NxJaKxwoMBGT+pjFp3hmbqyv1uxt1GvxcsOaH++T4cFvPYIOPRkVkN9tE7Fd8JssmsAaLmxLDQoWXZLDW3LqWKJ1dVng3ssJ6/WgliJCZX5+kOJZ2+Ml5rrJ74hKXbbJbXN9th4DAAfz+VkTpSV9LyH3hBMaiRdyx3LRrJlXGSq38JDgMIvWJ1QEd4OoGV1KW+Ky+Q+5WgkWpXQpkD/S/5ZhuJRTO/t7WYXZmOVFn0Tep2HeKMri6N5974cwOyGY7Eqypdt+d450NGwdX02/tjGRtSB3AXWG8kw+OHQ5Yq3ndsUZpTIxOAXhxZkwhylHYhgyaKa5yFwaWaY3pFHGe/R5e0EVmoNUpz5vOiNTtSJUNIa5TO19A+YwVKOIzWGW9bX+zp78wSdXZ6dsf/OXKDwNyC4cOpHXsSawvHnrAjbzNwQrAktg1Ips/ZoaZWBHCqw8l+E8/e3Jfmed5Y2obtWELTK7Bu9wLwBDP4rO0pllqfWyOuNLoYBD66ceyc43x4TAh+sgSFVRTW9AcnXe8WBzRHL7/q43V6qk1Rg0sWJHVEde/5waqlDmO7Uraj4JGoIDo/nkTQPt2AfQtOPU/rc4IIpMuwYn3KaSGG+/RFDuWqGwJAxhLjtftRZFq89Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5HTWVCbUJRMHBNYzVwWDAzMExtSXF3Z0RUUVdMZ2VCRzlHSG5xWmFIQ3NF?=
 =?utf-8?B?Vm1mQUxLeUlFczUvK1pjZVZHQjNFNGllc25VQi9xY01CclpkTnAzN2VJdHVN?=
 =?utf-8?B?MFFuQkt3M0plbUE5aDRlYXpoWlh6RmZISllXWENPVnVjSmNoVlg5aFJrSXVY?=
 =?utf-8?B?UVBPN1E4bEd0NnlHbURtRWgyTlFzWVJ1ejBHSzAzbWRXQzFONnJ5UW1mbmpR?=
 =?utf-8?B?RUtxTVZOa1pFSHBGTkN1MHFPV3VDWHJVRERyb2RHeForV0hUdHBiYkR5T1cy?=
 =?utf-8?B?aWxyeG8xWmlkWEw0RmNQQzM4akg5ZEM0bE9admdKbFVRSzlyWFRaU1M0TVJu?=
 =?utf-8?B?UkNRUEZLUjI4dWRLWmh0Z1ZXam5SVHZTK1g4QmcvY2tCWnhaU3JJRkdydUdH?=
 =?utf-8?B?NzJ3MHBNUXhMRWlsM0JUNFd4KzJscEUyUFVqQTBFSmNhaGM0a1FNMmhYOGNL?=
 =?utf-8?B?Q0NLUTlrb2MycVNFMTJjcDJGS3RsWDVKWlRyMDRQRjQ3Ui9kbG5ob1N1WkN1?=
 =?utf-8?B?OVlOSUQ5aEhDcDAvMGJYdEhvdDJLWHozUU9heE9TYUxPUUFmVmMvVFZBWkhk?=
 =?utf-8?B?VFRlQ01BQXRQTGNkNFdDdWFqVlVjNTE1T1NZaU8wZ1FtNXlmV3dGTE9PZkZN?=
 =?utf-8?B?ZG1ld0E5Szk3N1NNL3lCZUh6cGJhMkQzYkRBUWd3OVU3bjNMUGMvbUNhNGJV?=
 =?utf-8?B?cEJaUU4vNzloUGdUNTZxSUQwZlR6cWlvdzJrd21JQjRMR1IxQ3ltV2tVcHFM?=
 =?utf-8?B?UVk1S01nU3RmcTNUNzRNSzdVUzZtczFQakMvU3ZYRFFlVGw0dlZPYWt2dmIw?=
 =?utf-8?B?eWNkb3hpSGdLR2hwWTZoOU1JYVhtbXI0b0xSODMrMUpNY2c1RFpoMDAzRHVH?=
 =?utf-8?B?SWc4djhFTmp2OFVteHJUcjlTWG5WY3hCajdzbVVCbDVhcU4xelpjeWhxWTIy?=
 =?utf-8?B?aVAyZDNJMGd3dkh4SitqRk1ENDFoQ0dmZDVSQXFZenR6TDRpY2tYcHdMMm4r?=
 =?utf-8?B?QXhUVWo1MUU3WU1qd05kZ3NnM1d5YW03REt2NnFsb0pqQnpYN3pUeHJ0bVhK?=
 =?utf-8?B?allkMTZVQ20rby9Td3ppL2JMN0c5VHRQZjhiV1pFVG94clUxOUVhZjE1RVpi?=
 =?utf-8?B?T2xSSmNMcFRYcDdYb0g4eWZ6TEZ4ZXFXSllpYTFxY3VjUTcxVjBBayt5YmR6?=
 =?utf-8?B?R0NWM09OZFFGcUIvampvVFhDMW1XNDQ1LzlkTHFJMFZJZEhGNW1PWVo0Q25Y?=
 =?utf-8?B?ZmZTRE56Y1NHYVB0dm1HN1lCNWZNNWFMWFR3ZjZNTmlFV3ZoMHNKVU1aVk9i?=
 =?utf-8?B?VThUOU44bzlXbmcxQzZoT2pVZWdXcFI4R2NNekROY1NUaW14YWQ5UTJuRlQz?=
 =?utf-8?B?UUtkaFhVT3Bac3oyRGg2RlZFQ1NJMmJBRWNaR29SaGF5Z0JISVhUUThNcyty?=
 =?utf-8?B?dWdYNXFHSEN4WG9kWHNlUlo5RTZURy9KY3haVEExMXAvQmtWSEhndUhKbHZ2?=
 =?utf-8?B?TlV3UlQ5V1h6STFEcmVQQTZCekFFMWxiL1V6S2pnVVFxQ2NCdDFVUlFPV3c1?=
 =?utf-8?B?aEpqelBHbHNXRVMyRlkzWXF1a0Nqbm9meDZkNUNQb2s4RXNsbFdNOEVoV1RC?=
 =?utf-8?B?dW1ycDhHazhFS2M3N3pscGd3VHpGVGNPeGhHK3NGL0VtNFJuUnZTZUFmcFFD?=
 =?utf-8?B?a09QRHFqWCtZY00yenUyY1dGNDNGbW0zTHpDOWFDOEp2MVRqNS96WHF6RlI2?=
 =?utf-8?B?SDlPUnl6ZDZIaUFlclp6Tm1tWGFNelRMS2JOeTlLc1lGTlZTbDJWMGVBZE9o?=
 =?utf-8?B?cGJTWWRxWlBYbXJmR21oblNleVhHK0Y3bEtNODFYYzN1cFhFVE5YbnRBNlVj?=
 =?utf-8?B?azRENW9SRXFHZTVXNXAxWTNrcTNwQWFPd1RWcWcrU0R3WFdpS0U1YjlQOFlw?=
 =?utf-8?B?UkZoQXdoaWZlcmRNK1hTbjBlcStXbC91N2NKQnhNQitLdTl3ci9teHhZVnht?=
 =?utf-8?B?aXdZbXBFSU5EeHd3MzdLWjRHOGhQVVUyOWdoejFCMHVjUjk5YTh6MG1Qd0NN?=
 =?utf-8?B?TFEyNGV1VTgzQmR6c05iTkRaN3cwQ1FjS0pSMjA1QWRkME1JYWNySzR0L2FW?=
 =?utf-8?B?NVB6U0o3SS90SHFlUmUwZjd5dGM4YU8wVkxzb1RWYXQrbHJGNDlBKzF0cStN?=
 =?utf-8?B?S0JyUlo5MFlDYU1HR3hLalRwSmdPcjdIWHNVd2RiUWhkdnpHYmtFOWFwN0pD?=
 =?utf-8?B?bkRKOUVuWEVoUWhNMFhJeVA3eUI1cjM3RkZSR244RURtTDFIanhZLzlpV04v?=
 =?utf-8?B?bytDY0lDYVo3WDY4aEhUL1NEK3F3WTg0aGpVVjZRbVRLdithK3haL1ErRHNW?=
 =?utf-8?Q?aE8aVbYQQHdfsa7M=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0b9e29-0939-492b-d686-08df244841b8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4273.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:54:47.0534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDRA+qhgZrSprwHiyuvXJy7mfzwxJqqtYkzS1CcybtMwX7f7uMdhYr919lQ6Clqq389UTLwJCsG1cWjrz4lmvHQ32D/LWl9poxyuI1fvNj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7930
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
> This makes code more generic. Also it allows check for DTR support
> and emit DTR operations only if it supported by the spi controller.
> 
> This is necessary for spinand DTR support.

Could you mention the corresponding Linux commits here, or if possible
pick them directly with U-Boot-specific changes included?

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/atmel-quadspi.c |  5 +++
>  drivers/spi/cadence_qspi.c  | 10 +++---
>  drivers/spi/nxp_xspi.c      | 12 +++++---
>  drivers/spi/spi-mem.c       | 61 ++++++++++++++++++++-----------------
>  include/spi-mem.h           | 19 ++++++++++--
>  include/spi.h               |  1 +
>  6 files changed, 68 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index b2b96e1c4b9..37d97c094f8 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -1286,11 +1286,16 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
>  	.exec_op = atmel_qspi_exec_op,
>  };
>  
> +static const struct spi_controller_mem_ops atmel_qspi_mem_caps = {

This should be struct spi_controller_mem_caps instead of
spi_controller_mem_ops, I guess.

> +	.dtr = true,

Anyway, the Linux driver doesn't set mem_caps and doesn't enable DTR. I
think it should stay disable here, too.

> +};
> +
>  static const struct dm_spi_ops atmel_qspi_ops = {
>  	.claim_bus = atmel_qspi_claim_bus,
>  	.release_bus = atmel_qspi_release_bus,
>  	.xfer = atmel_qspi_xfer,
>  	.mem_ops = &atmel_qspi_mem_ops,
> +	.mem_caps = &atmel_qspi_mem_caps,
>  	.set_speed = atmel_qspi_set_speed,
>  	.set_mode = atmel_qspi_set_mode,
>  };

[...]

