Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B5606A567
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gFdVi0NJ;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=T1GRhfg2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 322CB40764;
	Thu, 29 Oct 2026 09:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hMDjdzPvU8u3; Thu, 29 Oct 2026 09:56:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3505540713
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793267802;
	b=briYRl9MnKFcn9UVuHEtyS/zrwFsbQLmWxda5bnT/tfK8nMTunhEc+RYbFrzZnyqJElT
	 K2GCC/1E1d6PpO4niHg5cB6nCkyfkchwUgslDY3+4RWwXKT8IC3ENvTRjtDhi90toV6wk
	 WtEtgfD0DF990oseIHpPyf2kZQitlJS0tCeojuBDEg0A0JQNsBLI+Ifrihl96kflXrGpU
	 fGg5mzsE5LQ2hot2l/qWRcaGBQJB4/iF93jYya6s20dupocwP9mpw/lKKBpqgCtyQ8yDV
	 oMiYzqdid9ACpfl+4NbzuDWu/hJYQQPghkChKotm3rTLLtUzSTvLaS2oGxpuDFEzlHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793267802;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aUZRVIbcdMSqw8Jvkia9z+DQYpZa5GZucL7g0WWx/lw=;
	b=Gl6rnokQMMd21grgvj8Oi2B7zkCFSnBw6Io2ZwVQA9IBmD7+IWeUYgkt5Wgu+W4JyTZl
	 bcFlbiZnTFAMdRDmJUwr4zYmZ6Kac2x5XHy0rZCMCQRqEQg1y384XZW4gx01C93Yxrkus
	 /ggT3YXBjee57Ph4F2jI4Z5tbYpHovIG/qlOUbAGDgXnBW1u34x9hSQrIGOF+CauR7OOR
	 cPo70taQ7K/9FhzkXV4o3yzouy5BGjGyLdW5QLuiiDKt/yOCfl2KGdt+1d6bfhhhFF5a3
	 lAYKTFlL6UPDrHleQmNBDR5LFOAh3KlYc1kijeSbFyrRgWiOrGAhvO414I0NVctXReg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=T1GRhfg2;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793267802;
	bh=aUZRVIbcdMSqw8Jvkia9z+DQYpZa5GZucL7g0WWx/lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFdVi0NJP72ED4KstrHHti2E7N/zq5u+YD1FBr2izP3nQ0bAy4JGYyxcKXH7Txp09
	 amhrRvXJa7SC27Mu7YS9TPlL19ltigBay4FNRwopP9mN2ElshvTGkUnTSf5Jl6gRI2
	 qICWhRcpvFWLs5jxI4KF638l/66/8Kr9qdNaHvbpAVujb509ccCpeC7RxJtGH2fuZ5
	 DZjY4ONRpe58VWyWZWJh/mJl6dMvVy9B2sZhOf4+e8vb6Li/q6pfocU3sy/gVc/jvZ
	 OaKnpz4WhQmCsqdsaE6rRoOl5juQwR+iB3tKgbjlMGAjXT4RhmVdCd8r8y7rpuXqm8
	 4yDKVoxa2sk6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3505540713;
	Thu, 29 Oct 2026 09:56:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC478D22
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91FC140713
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iwj3lBU17tjG for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:56:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0416640664
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793267799;
 b=ei0TN4e5/Ph11oURD7TspMx7/J+Fk4EgPF7oKxRKxReceFnvuhhWsvZOkKxTK8f5RFFx
 SSVwS8poWvGEiTKu2OS8W1cV3RjKNzpGOzFTFfauDMlQ+nKcQMQXxJgAL/LJIDVykCIUp
 26HkZbDIJqE7pwl9wRSwEaO75WMRS5xaomGci+buJC1/rEUpiCb5r+0Kee/i4FDYPDHp4
 T1Bp8hfux8z1qiidO/HhwcnoEM50tdT5F/qLdJP1cFdv7IqVluZ19MfF5k+b6W8hSrleE
 g9eewkh4ruwtQ+KKRONS554Sf8rz73wZR3tnyQ7gucIMflnaJvrqX3E1ThQULtyZSPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793267799;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=aUZRVIbcdMSqw8Jvkia9z+DQYpZa5GZucL7g0WWx/lw=;
 b=J2f6QPospnJo1QKiJVQwuLIQ2mzrED3Iy6rl/WFUJUcNrTqp5LlOivYcRQBrqFQz2F9X
 SeFgE5je8fxcKkhCeo+TNltV1Op9Mmg7JBFvK9KgVfZWZ7/z9kOvs1wVliqcGo7bxHV/0
 icVCIdzwdq0t84J+BIogjr0IreTOjDIosQK/v54UTzGUSolctPTsIJ0XcNistE2SCEUWW
 r4aT48JlDerPTPkk5L/edhfvf7086qTd7CWubWakSSBcbQvEj4beeJE91h+i8DcNbQ7Gs
 B2z8joFbo7gz93pM9a7rN3S68E7CpDY3nNiuCuK/J2bWQ+W+sJD1rOMoAkfAIJlQdEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=T1GRhfg2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=T1GRhfg2
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0416640664
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKhs/vTTzVCIsuhB72FKbilp36Yr6icWJapeOBYUqrHRk9cYvC5KePkST9MSWl80fWokpwKEuTP7W+nRXrEdyaYOc4vdg1PQ1p8pijgIaMj+vOvo0OGGD9fskpSYZNdObDdI6VT+22YrG27ReDH/iTMFu0Is4x7KQe5JxVvB3HJ1Hi7DbKMpQNuuf89G/ThEwFaTCMQ6f6i1+B1n14jKjSiG50AeekqUKTS2PzLdJbSLXTaIguIhBH0N6V4/v6CF+Z1vj1WEvXiH5Kp4KhdBZ9jI2mYOYNDlVjdUpcnBmeCgou6hZCNEQip9o5qmVqwB74mYTWjiGvQZIhhrTpeX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUZRVIbcdMSqw8Jvkia9z+DQYpZa5GZucL7g0WWx/lw=;
 b=np4+ahn2oI1cvkEAKMb9dZPNIza9BqdTOotG1pYMUCBhJiPWDoK25ai1BtHi2ZF49k3f5zMFtSRH/GBQ5feJhkiXNh2VHSmN4hUS6Z6EBQZN/+ywGywGH8dg/UxRh5nG/Cr/0SK0mP2v0lQ+iIF0nPTjoxBUT3Hv/Cz3+iYoOHMIzhl01Qb7vzvF12cOM/KmW6z7zMu3TIr1SeOouio2e/TlynGx/RC1D34qC2NRAf1bQMXQ50e9CpEb6pGF8Jujz9cZEzJUbWaSsJj+FIUK9NVdrdgqBgtFbIEJMEHT8i9k+bI6aKunASZI8Iq8dZQutjCKUnk6wsqPRR5i/HMvQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUZRVIbcdMSqw8Jvkia9z+DQYpZa5GZucL7g0WWx/lw=;
 b=T1GRhfg2bK96+uufGdBSwystrJ5ECOxdoRdMfPvBLikHAgL0sXxW868iWBtqGjgAQo7Cz0BnM8XRlJW78sZAx7OAm0JDx91QJWD51zQxZX7gqDDGE2KQbJrFMTgn0+xG/YNcAbqdCO8R+/DTOOjVTjCH74w9c0o1Rch6+rntIxA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB8121.eurprd04.prod.outlook.com (2603:10a6:10:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 09:56:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 09:56:30 +0000
Message-ID: <3d2465d1-276a-4a59-9980-b62c626c8785@cherry.de>
Date: Thu, 29 Oct 2026 10:56:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add support for Graperain G3568 v2
To: Coia Prant <coiaprant@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Liangbin Lian <jjm2473@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <20261023135614.2376931-1-coiaprant@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261023135614.2376931-1-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: f999bcd3-7806-40b0-5030-08df35a2e7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|261028144727099003|11063799006|56012099006|261009223027099003|261022115727099003|261021121427099003|261026140227099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2V0D+anW8G+v8zzn+RTCKVfsxH+GV85spDBt0aHhOlEj8Kk8OrwnjgRshyBcZu7wDTQ81IUdqISfDZ9AsoP4tDYEJ1peWp+xM0LFVSc/bQyqEIQ3vnWsE9Y+CmpuLIR9IZpHNpP5noy5bBd/InFkfayh7lwZjRC3rAyiXfQkVzhJieC1qGxV1CIqdrRotgH9ZPdaQ5C0HSomjId6Ergw1j+NO3TIFmDCst249nyTfCKQTP5Kj2ydKZQUXyaWvIDOIopWd4Xm9RySbl/G0DGDF4IjLnH1+94oJsiQvAIt1OImanT10pNC9EpVCLTQmpySlzEEuD52TVHn58PBJmjZnJnSRwVKYMFSkasYMpl4CMMWBUXltvgq4ceTp4sf6iEkeX3Yb+Wk6x22y0zJVkLTlL3OQ2GWgUdiZdqwGX+q7V1BAcfk4U1z3gQUsGl0gPHvENrcKKtRPgtrYXFnycu4xJ1bMIbXY+NXD1G28Gqf4JFwBReU3Yfz4h3GlTtHcRVdNBTEuG0cLsnwovrCPtgc4xKYTcY/b5obuLH2xON7mu96d38rCawXuR4B/O9TB+dT6l+OVHWnogB40EfZoOHQ3B21ZKsAhFiAgF/aw/ySmxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBpc2hWMUNZMm04cnErK2dOK2JIOTI2cUlMOEluK0NQL1hIcW5HbXQ1bmN3?=
 =?utf-8?B?NERiY1ZIM2p6ZGxiVWVvVG5aOFBXVlFDR1NRMEdYNTJsanovOCtYNjQ1ZUJv?=
 =?utf-8?B?VWpyaU16cFB0cmE0U1hKanJ4cXlTc3p6cVUwMS9KRWpKcWdSYm1XM1o1QmhH?=
 =?utf-8?B?dFpvNFhkeStzWE1JeWo0Z1N5d1Fmc2R2T3NDb0p5NHg5L3UzUEhLRWxsbzl0?=
 =?utf-8?B?Ny9YdWhPYkhlU0ZtdE1IcDFibHhDK2U3M0xtdGVxci9yU3VZUjBKdDlZWlVs?=
 =?utf-8?B?SkhDZyt3V2FjWHQzclFnU0ZWMTZlNFZ3SkdLYkRZak5vT0JwVGZEaWY0aUFW?=
 =?utf-8?B?cW9BUjRCRGNjdzBUbWJycDNoMjVsWmlQcDJQNXpkeFR1bUczNW9IcXZnN1Fy?=
 =?utf-8?B?RTV1SVpJeWhRV0JpcVREVGdXS1VVblo0aWNldDFvbHIxbHc3c1luNEpiUjUy?=
 =?utf-8?B?NGY4R1BMc01nM2RKWHZ6NjdrTWJWa1BKVzI1aVJ6NUE5N0pRNXF4YmZkV3N2?=
 =?utf-8?B?N0ZEVzdLRG53Z05ERE9GL2N3blpWUC95SmROVGxOd1hZYnNubUFpZzRyZCtm?=
 =?utf-8?B?ZGFzek1vcGo0U0dmWXBrSkR3ZSt2R0RPek1TNGk0ZnRqYW8wTHlzY0FCMjNU?=
 =?utf-8?B?Rk1lUDFZMUhLTHAwc1JYb1RPY2dSdEwwVWZ3aTRmZzFlck9HaW1nL2FHVXYy?=
 =?utf-8?B?WkpKT0JSTzRDcXY5THIwaUtnTE4rSHJYRU83OG8rUVVpQ043RHpQaVM1M2xa?=
 =?utf-8?B?U2N1RHdEdUZVaEwremptR1dxdDZzeHFjSG9XSS9Dcm8yQXNPb2VobUZ0Unh6?=
 =?utf-8?B?Y1NhMWt4OHN5cjMxWWxUNERKdkJaM3NzcVVYdE1kdmIvL094RU9CdFNoMEJt?=
 =?utf-8?B?VWVNcGgrOTZ4V1hGaDhwNXBMQTdDMllkVGFTUkI0c2Iyd1grNXdBV0hiZkdM?=
 =?utf-8?B?cm0rQ04wUEdPUnplU0xwVmdYbmhKVjVXR2svb01TeExtdEswWVZkMVRDcEgw?=
 =?utf-8?B?SjQ1c0pLd290eFR4U0lKcjVuZVY1RDBYdWM4b2NaK0dJdWc0b3JhZE5RcTVC?=
 =?utf-8?B?N0krR2RDUVlMU1U3S3krc0Y3ZnpNTEpkNlpEWkZVV1YwQVE2NXpWeEtHd1Iw?=
 =?utf-8?B?YzdXQ1libGdXMUFwNzdjYlRzSDBwRGJUVHZLc0pmeTdmVTh6VHJvczduUXlW?=
 =?utf-8?B?N01iRysxQmFwZW15MmhiNStkS0hUY1o2N1FsQ1pWNEtNMDc4ckMrNmtnczJQ?=
 =?utf-8?B?WEprbzJyUVk0LzI4elNPVkdRVFdyVzU1cTJIWEk4UXc5MDVwRndMNEpvN0ZY?=
 =?utf-8?B?VkNXL2ZSUDY5M2pRdG9rZFJnRTlwWjFGd2pvVmtpeTJ0S3lMYkJxTk1uRzQy?=
 =?utf-8?B?bWNyc0czZHBhcDVOblpiY2hNZ0JTMkM3UnAycFYrVWlHOHdsZ0NIb0ZTNWZx?=
 =?utf-8?B?K1RJeEhsUkRmbFVoeEtDNUt3M3RNY1YreXhVNWEyNUNXN1pyVndHaXh4eWMr?=
 =?utf-8?B?WWF6ZDhRZVlxNUU5N293TFhtdkF2TzFsYUZtb2VpZmptTWxaVGM0MHNsd1pS?=
 =?utf-8?B?KzZrTUZLTzZmampXaDNicEQ1d2ZKRmJNbk9LNTIwRlBXbWJPSHMrMUs5VjJu?=
 =?utf-8?B?SElQRnJydnZlVFlaUjFhWExkbkdQQnZmR1BjbmE4VUFKQW1QaVo3UCtvTS8z?=
 =?utf-8?B?allzRHd4eTNWdWk0VUNTeGcyT3N0a3NJc0ZuSkwyTkdEb2YvYUcrL2o5Vm83?=
 =?utf-8?B?MlVXWUFOUi9yeFhmWWZvK0dicEpxL0VsL1pRKzZVNkIxbnBxRHl2RW9iMHR4?=
 =?utf-8?B?dG9aL3BHSTRLTGFwWWhRVEtSdFBQWjRWbnJKL2RXQ1Fmb3VjOG83c2M5R2VW?=
 =?utf-8?B?MXdYQ3R0VnNZWHhvbmw3UDdxUWIyY1VlR2ZFR2lDU0Z6M25YVWZ6b0ltUi95?=
 =?utf-8?B?eTVhd3FxOXNUR1N1b1NLT3gzSnRwbk8wSWc2Z3F1aVUxeklNc1h4UytoOXNi?=
 =?utf-8?B?eFpINnBYN2ZHZWF1cC9hUU8rUk1zR0t0NENCd3VlVWY5M0RMNkQzUFM3RGZU?=
 =?utf-8?B?aUxkTkNFUStjNnNaaGtJbG5KNFVMd2xUcno3YWU2dXNHOVkvbTRNMGRxaTZx?=
 =?utf-8?B?bkRvSTB6cGYxWFZ6MU9seXY0TGhCNjhKcjhHTDJDeDMxaWV3eW9oSWU1c3l6?=
 =?utf-8?B?RUpzM0cvL3hqTG41RDhBTitWSXVxWjFmcmszZ21rcUcrS1pGVHdwV2s5cnhR?=
 =?utf-8?B?VVMzNy90WkhWYjdzRllVa0xIQlJnMFRha3FBVER4MGxaL3ZydTZhdXhwL3M4?=
 =?utf-8?B?WVRwRy9jZlFWZkR3dzFyTUhjS3dFZU5QOGJ6MHowQ1Y0K01ZZmpUN3o1OFJy?=
 =?utf-8?Q?6BtSWXl4Pz0X5VlRYnin4yXhw0F7zoLSPAFt1HCteRvGa?=
X-MS-Exchange-AntiSpam-MessageData-1: 5t49SLDIeqeowbvrKpZqXuJQANhQFgKFX/U=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f999bcd3-7806-40b0-5030-08df35a2e7c4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:56:30.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2IF3p+qob5s+IiEJB5r1w468XxJHAgx4gSwGgRr8/L5tzEwYfZsXNI+w014jo+RyznjnF8EYPOQGUTeMb+hcfU+wEEVGdWyaea+k6SOFDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Coia,

On 10/23/26 3:56 PM, Coia Prant wrote:
> The Graperain G3568 v2 is an RK3568-based development board, just like the RK3568-EVB.
> It always uses soldered connections between the GR3568CV2 core board and the
> RK3568BV2/GR3568BV2 I/O board.
> 
> The G3568 board has multiple hardware revisions, and we currently support v2 (I/O board).
> 
> Specification:
> - SoC: RockChip RK3568 ARM64 (4 cores)
> - eMMC: 16-128 GB
> - RAM: 2-16 GB
> - Power: DC 12V 2A
> - Ethernet: 2x RTL8211F RGMII (10/100/1000 Mbps)
> - Wireless radio: 802.11b/g/n/ac dual-band
> - LED:
>    Power: AlwaysOn
>    User: GPIO
> - Button:
>    ESC: SARADC/0 <1100k µV>
>    MENU: SARADC/0 <1400k µV>
>    VOL-: SARADC/0 <430k µV>
>    VOL+: SARADC/0 <50k µV>
>    Power/Reset: PMIC RK809
> - CAN
>    CAN/1: 4-pin (PH 2.0)
> - PWM
>    PWM/4: Backlight
>    PWM/5: Backlight
>    PWM/7: IR Receiver
> - UART:
>    UART/2: Debug TTL - 1500000 8N1 (1.25mm)
>    UART/3: TTL (PH 2.0)
>    UART/4: TTL (PH 2.0)
>    UART/8: AP6356S Bluetooth
>    UART/9: TTL (PH 2.0)
> - I2C:
>    I2C/0: PMIC RK809
>    I2C/1: Touchscreen
>    I2C/4: Camera
>    I2C/5: RTC@51 PCF8563
> - I2S:
>    I2S/0: HDMI Sound
>    I2S/1: RK809 Audio Codec
>    I2S/3: AP6356S Bluetooth Sound
> - SDMMC:
>    SDMMC/0: microSD (TF) slot
>    SDMMC/2: AP6356S SDIO WiFi card
> - Camera: 1x CSI
> - Video: HDMI / DSI0 (MIPI/LVDS) / DSI1 (MIPI/EDP)
> - Audio: HDMI / MIC / Speaker / SPDIF / 3.5mm Headphones / AP6356S Bluetooth
> - USB:
>    USB 2.0 HOST x2
>    USB 2.0 OTG x1 (shared with USB 3.0 OTG/HOST)
>    USB 3.0 HOST x1
>    USB 3.0 OTG/HOST x1
> - SATA: 1x SATA 3.0 with Power/4-pin
> - PCIe: 1x PCIe 3.0 x2 (x4 connector)
> 
> Link:
> - https://image.chukouplus.com/upload/C_153/product_file/20211022/6daddec9e400458816dd4c57ba807fc3.pdf
> - https://blog.gov.cooking/archives/research-graperain-g3568-v2-and-flash.html
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
