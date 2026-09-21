Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5BC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CA04809C4;
	Mon, 21 Sep 2026 12:22:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dIZx5sgNAq4i; Mon, 21 Sep 2026 12:22:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 83C748098B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789993343;
	b=FoITdScvPNcD8oNxz5c5mHQMwAYLNL6+zNDT9hy5C571yb/PimXr/OxEgE4kvYMy21oe
	 uuScZ/MlPsCcSssAw1bZbfD8APexJBXxMGg3h/Uo/HfdwPhr7l/RWPrSOGYWU2hjwVX9/
	 dKxBGwhM/Xk4Or1JJkowreXjawOTmf+zcCZPgXOfzJPMemFiD0JEF9gH1jTl++RIP4R4W
	 Uwr86DyaqBkFFPtd/8UINH9rXRTYDOpgSxrfSlH4NgKYXmXplK9xsOCkLhWQ0yITXX4wF
	 +ujEoYKknd+g6hVUbH8M3uf2Hi5//3bkp6t/rJY516IqX2nRC6bWxQRd6+79tRyUF6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789993343;
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
	bh=MPiivB6n3zlQ2mw5aNbhvh/zCpxbp+YSULi1m0mq+YI=;
	b=WJefX26vMIKq3+BScYXTpCTrjyCIjd5mUN8ERbEtoDlJHBuNs5BXUT/lOuxNQkLdtpUq
	 rGS9D/zZhTjqcRii1LhrdlsGQUVo4lMXnOVb9Y/0qVztwVDc7p8VNYJklAeDtHkusK45w
	 JeIFCJ7qWxlW9S4b7eZXXIJrEvsMkpgg9N5VXxAg3CNIoQnQXj2uIl9vvoQfm4OP4yvWY
	 Ub5u+as1XFLdis8ILeS0OeSaG80wlqhXeg/FxVjneZp0xG12n9txZGhbO4QrMH2DqW+D7
	 twLok9ZJV47nN5MD69FYixsywP7qUY5QI3B0byY7r2YhHjA7cOJ2jfi9aqOzDGQoo5A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789993343;
	bh=MPiivB6n3zlQ2mw5aNbhvh/zCpxbp+YSULi1m0mq+YI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TdpKKVywEI2CnHEEfHEaRzhZvnyesGEpJLh4AjxOt38MAz4gu3aCsV9H7d5HQOv5K
	 lxsrItOezwV3XmQU+rDWT/2YBAmNnNu+NRiwIAtL3OvXV7njW7OPVDBejfVTjrexa5
	 GfdBMqPJ5j2bIpAieDg4Qc1qVxghlXVMTvTo3JFiPAEGR2BCVReHKwQJY6qx2DANvI
	 Cbi5SRm/6zSzNCKYGcYW48FxDgwxDSmacKArf1NqXiHCWjKzgcp1WR+ohAkPXAR9A/
	 880se8KkWEiNScF2N69YMATnVb5xr7AZ7idYxYZc57fszvYHiQymvOaA24WlRtlp1p
	 05gsVFBXyfyng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83C748098B;
	Mon, 21 Sep 2026 12:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 15F4913D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06E2940111
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Pd97HsRmZQN for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 12:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A6C7240059
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789993340;
 b=fnFUv/NZJ8iQjBife+4ZciXvsJW0kqIBLnPCdaxvNYT5q6U7k69UuE1cc29J1pI54T2A
 FaYxiiEX576rdwPb/epVxbDuvxFHKXI6jwCtK1mdyGqPw8QyxiVvcIl3mz0kHHD43DnMu
 r4c4GzH7H+5BTal5fom/xa63YwPeJ4oSZtXCxMZFbUwSiTln3+KpM6SjdA0cM28sA37qX
 wP2N3URLKTkiaYZNh8fBSxmA0Wtgq3k9duvae9p4q/zGhC+G8m2UMUxFRpdHyLE1K+pq2
 N4tNdodr4dDI0ey2JpX0P7c/1/dJRXBSRYmobAjMgDWiOujlJvdt+PUQSQfsnxszSxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789993340;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 bh=MPiivB6n3zlQ2mw5aNbhvh/zCpxbp+YSULi1m0mq+YI=;
 b=WIx1gALOgf8ZFiyBLU1pUwvhEjErnvgyqSNOCireVL+P4PxApyUctR8VnTdjSlDAmEmb
 /l0Mf4FoDXUqjyOjP3xXaTeFNTpXMSQErrc24hO0U4EeA5ranibV5S38ZDT03KmmhZNZ2
 v/LY98xMK6p17yd3KOUGxrIu9dkZvYZ+LZK6z6EQ6vq12Z7vc59bLgkxyQufG+1i5jqz2
 +1W/ZojfX1EQNrSAMrWlwWCn4lIzeK6FLUj877Ow+y3y6qr9dAVSTlyjFJC5YTXUzjOKy
 bGRRbxLzDZ9KlHtLvk0dJsZhbHhJWnCa2aXp3isvHQAb4Gcqx+fw8Y5n5PuR2FI+gfw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="eh/PcgXx"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eh/PcgXx
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6C7240059
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OP98tz3OBniHKCoYqIs+NaiwOGdzPn+xc8hNejughEmT2M7pVYgWsWqh5Mi8yfLAqw4jEhQ30IMoX7Kb7YVlLwPXi9OIfAmo8zau86BEc28vJisn1pkdDDKsZdN5b6fmJCOlEhyE0h4ywEMtRf21SnUs+4gTGoABN4FGTd2M1Nugr4j6fqkPFgDP1YE3LvA0VOCt2paO/cLjgPJPqAuuh727Qx6W9FqukLluqqQOyeWqP/+L/unjJ04xW7UcH3M0HYP1XFVd5oDgviZduIiVQIEMEDXupvgk7kdfjL/Wh6PcvRd/lwUpsvDqKUR+T88eFp5nyuwWPcyfcy/8P3x+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPiivB6n3zlQ2mw5aNbhvh/zCpxbp+YSULi1m0mq+YI=;
 b=mC3UKo+E8tjTWR0eA45twi6qxau05LdDESnxGAU5zEEt2GcrUryt7CK9BkHueZQ7chXwC8zzLlLOk6l/WcRn7Norybs2Y8d4AzJNQTMIGWeuMMJkCfgLDL8J0mmnZP38J/l8DvJrIv6noKkjpGxOwjS9boQTzd0sb0TwQJDVoN/z4j5Xx2fqEr5N5BEMePpZG2Rqul6lerCJBYG9B4w6BBFmx8SM3UkuQmeC98c3vhp4sqKnNd5GWP8bTEadzeeUw3aN1vemdH188wbLq/yQYniyHVnZLvDlZErJdtMik0lDD0V0ay9ieqb8cARGRpaVzCI1y71871vXpJKqjnYcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPiivB6n3zlQ2mw5aNbhvh/zCpxbp+YSULi1m0mq+YI=;
 b=eh/PcgXxSc+QElH88RKAIwF6WLLIt66QESstJ/cuOsMVdsU0/LFXYK4gTW8wnFGLsktNxBdstrJUTEa6PFSWxVVvEKZByMrv1ur4ICtEkrx2RL7WnAWS2CZCRgOpswMyBNHc9yICDjlsourPmi1OSL8yZd4f0qgT2ta2I//9IXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB10954.eurprd04.prod.outlook.com (2603:10a6:800:278::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:22:08 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:22:08 +0000
Message-ID: <1be36c15-8987-4857-b5cd-dcfeb495d440@cherry.de>
Date: Mon, 21 Sep 2026 14:22:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] rockchip: Choose FIT payload compression via
 Kconfig
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-11-28e946f57357@flipper.net>
 <77f7c2c3-f038-4558-a1d9-8a69529c372e@cherry.de>
 <CAKTNdwGRuKgrt3pcYWcAuy-OB0GqOkqVFC1i0HF_+e5Zmi+Bhg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAKTNdwGRuKgrt3pcYWcAuy-OB0GqOkqVFC1i0HF_+e5Zmi+Bhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0102.eurprd09.prod.outlook.com
 (2603:10a6:803:78::25) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB10954:EE_
X-MS-Office365-Filtering-Correlation-Id: b24093e2-0fc3-4b1d-8726-08df17daf44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|10067099003|3023799007|6133799003|11063799006|22082099003|18002099003|56012099006|4143699003|41080700001;
X-Microsoft-Antispam-Message-Info: Fu3aM9txjK60usnFOtVatrqNcHJ+UY71f9gDbnt0M4tpA8wKo3MdlGTMTS/87VJPyjZhI8zB5IB8d+2p4i3+TKLOWpciGSdczQbUKoKxka7qxuTmrUYxxijwmueMQWG6Roo+ukMHpNpQGjZbuZ1Dx2IuvmD9F7BD97wduI33w3/wNwYLLCXDot+JhMIN6ORjq0XJzTh7PH1rVEdwTfhooh3BYSbnemOO5CDZfAdXKS2PMoXKX2p1ZP8VuVv1BYPfQ/Av6bD3bTS6yie+QLr41clsLYycHbirA9glEM5EnEFJuDVX2OlQ+msOQhWyIh3G1QqlhhECjVBmRpIlnGZBb8iKzhqn3xJkNL2A++BWbhfTwtuXfQxz/U+KOYul+27slhaTiHVBFi8PF0jlSLL6m95uT3u4PtifGraovOgHi3bx/MZPDekR4CWyFM7yHcE1Yd7FurOpnwzH0+Q6c0PDVq65TFQKGo5kFJVeN3ajSajkn7yJVwmt8ghloLco6IdalZixUdP54fQQG5ZZtnHOy7f6Qez027yb9tNu1zaj/mw+4Z6dcao5blCgQ11WWDjD7Dd04kIoPtN7p1IdxUm12DfYfvIJRPeBkPbU4y+lpzTRFIJFz3wem8W5GgKT7YKjJYQue0mkCA67M99wf6E27tDcsfBI/BKGjlE4uwl/Mh7xNNiIRgrAVxy82vAI/LVy33CIVUPACzSkmifl8Zt15w9EoxlJAJcQU0RPeTdiLC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(10067099003)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REh5MDVubVBldmxlNlFYZTNLcFZoNXpBS0F3Ty9CSnVuTEZPVUJ3NmJWWHNv?=
 =?utf-8?B?UjFnMk1nZXcxUUVhM2ZIeHRwdmFHSE9Uc0N5N2xjTHZ1RVZOQ3J5NzZ5UXBU?=
 =?utf-8?B?NlhzbXgySmlja3ZqQ1p3UjFhOGw4dmMvWFVVYkhoUmJJeVRPSDBrREh6RUZx?=
 =?utf-8?B?R1dDZVFrajlQV2VOaE96YzVGOXk2VXhVZkYwT1JzWGRKV0pET2tOWjltRHh6?=
 =?utf-8?B?ZGJWaVR4OXVYU0RZdHExVERuR21vd1Z6emZkUTV1QUNhWVdNaURnUmt5NGhS?=
 =?utf-8?B?WTBiSGVxUTluc0JLTFNMY2FINTR1OFkwWVJRdndMQ2JuOVMrY1Nhc05WRnZS?=
 =?utf-8?B?U1MyVFhlK2tpeW1tTEJiSkdnYVMyR2ZqNldnT1dwcW1HYlUxdUc2dko0eWx4?=
 =?utf-8?B?aEMvdi9xV2Nra3NwY3VmSVZaSnpWY0EwdDJBb3piZUdFRGpZM3BoMjZlMkRv?=
 =?utf-8?B?Vmw5SzdlUU9HSmJLMEVjNzNKbUQvYi9tQSsyRitUYk5ndG54ZXFjTkR5VjQ4?=
 =?utf-8?B?ZkVqQzZIaXV6c1hqRXVVRzNDa0t5S1Q3RWlpYS9FdU93SUphTzV6RjZxWDJk?=
 =?utf-8?B?RjF0cExRZXlBdjdHZ3FIREJyR1NBdVd0TWRSSFdGc2FJSDRURjc3SzlIM3pp?=
 =?utf-8?B?UUl6QjMxVFVVTXY3Qk9VeDVkbUNWZmUwY3FKVHhDYTVpbjdNVXJUTnN1cktv?=
 =?utf-8?B?Mm94cEF5NlUvNCtsc3VKWXlNaWRaTEFQc3lsUUgrdXAyaHhJcjBHUG5ZN3pj?=
 =?utf-8?B?OWJiMytZQVR1ZmdDUjVGRS8wVUxHNG9hVnlKV0RjdXlKWVVUemtHMmRFUllG?=
 =?utf-8?B?b2R1L2hLNHovY3FPL2N1dm5GWXVSdXZST0lwRk1ydzlLMC9yZVppMmdFOUhw?=
 =?utf-8?B?RTI5QTAxd2pEZDhTWHlwdzBzTCtLeDZvRkNKc3Bkc2NmL2xWeDBtcTVZNElD?=
 =?utf-8?B?Y1ZKcGcxbHRmcUFTNUhLdlJNMXNKTDd5UEhyV05LdnpZUlkwNkJLbFIyLzFu?=
 =?utf-8?B?eDYyVmpGL1R5bWtoRUtwV0pvNjE3QkEvaEd3Mk85M01nQkh2VW8rcnIrNDJm?=
 =?utf-8?B?OXVTZ256bE1LeFBrUHBLL0N4ekEwTTdiNjIzd1ZXd2VKc2k0KzJibGIxSjNC?=
 =?utf-8?B?YXpUNjhWdUxLSWhVc3JLa3YrZ1ROYlhKTlNNNjNnUDQvZWlsZHQ3bm1hK2py?=
 =?utf-8?B?enJLSU5HY0lFb1FIdVZXQzFkMnBPdHNMSGpNVUtzQVBvVDF4b1BzQ09hcGZT?=
 =?utf-8?B?T25Vem9oNDdBdW82M1JMK0plSVpsdlZBNi8rSzVraHRUVmZYVS9YSVA0TUo0?=
 =?utf-8?B?VlRlOURZb2NRbkw3dDVhbGRhdUIrQ2N5V2FFam9zWFVGMUNuN2RTQ1lPN2Nz?=
 =?utf-8?B?WlZHdnRtWG1aSkhNanZha1RjYlhvRDdBNldTS2dDNVJIMmg4U2h0a1BhQXBQ?=
 =?utf-8?B?aVBrbldBM1hSQU5wWTNBR29VRDNYc0pZT3JGWUJ1LzYwTDFrSzVyNWQyZmNW?=
 =?utf-8?B?ZlVnUFNaUndmUm1nbU9Kbk1ZeG02RUYxSmNsZUF6R3FEUTdqZVpvODJPZFVJ?=
 =?utf-8?B?dTFrMjFKUTBSbkRqOGN0SWhHTmFTelNud3RRNDB4dklYbjI4WnNQTEhzMmdt?=
 =?utf-8?B?aXBjaS8wRVM4dXJEdVlTbk1SYUVacURJVXM0bUR6Nm12cnd0UUtUc0hpV0lP?=
 =?utf-8?B?UEVqeDBYOWw1VHZUTFpnT3dBRFdHd0FjQ1crdm9BWGVmOGV3U2N4SDJGNERl?=
 =?utf-8?B?cFZDMHlsYmkyQVg5S1VBRUFOVURIVGczZmlIWDJuOUd6TzdyY1llcW9iMnE3?=
 =?utf-8?B?ZHBqcHFaM2FkV2lDbkduaHNsVnc4ZTVacTBLRjZkTy91MTdHQ1c2MCt4eDlm?=
 =?utf-8?B?QXErNFNMS25nNThvMk11VHlsbFJGeDduQ2JCckM2ZTBjUGEvTURaTkhKVkxt?=
 =?utf-8?B?Zy9tUy9nckdtdjVKU2prWDZ3NFNBRkcwTmZqVnJZYTMvdjBhRmIxUFRVRVFk?=
 =?utf-8?B?bzhLeHdGSWRaRFFMNWN6TldHcTZqa3Nza3NaSVdURmluL3l4d1dvdE8vVEVV?=
 =?utf-8?B?dVhMbGY1Y3dhSTM1Y3RtVlJkWE1Rdno0N0ZJZXBXYWN3bS9Qb3V5MTVQa2FT?=
 =?utf-8?B?dkNnaFhYSjBYVUNNRXJLVGZ1QWxPMDcyWlp2ci8vZXEwd1drM3dJZXdkQWxp?=
 =?utf-8?B?V2ZwTnBkL1hVcElMM25JUUoxRjdZb0o2T0Rkd3pZUVovZzFGMnRjWVRCRHN0?=
 =?utf-8?B?aGl5YUx0R2FLbXdhMGNQbnpIWDdTNW1CbnNBaFRTbUs3cWhTVE1OQUhENlVJ?=
 =?utf-8?B?d0lLenFRbUZmSEpIcWc2YnJxYTl0REZhNnhkbmx6UmpPSStUaDNGdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b24093e2-0fc3-4b1d-8726-08df17daf44b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:22:08.1000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlG7rx+VSJ1jYsPSweqcrTIzORhxIBN7D905D11xwUP6PYaAIIhYeUUL9E/mH2TXqy5S4yy82UHfnU1sN1Kj/ALQnpYYM0R3uVV1tWyvz5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10954
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

Hi Alexey,

On 9/18/26 9:12 PM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Fri, Sep 18, 2026 at 9:57 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 9/18/26 12:52 PM, Alexey Charkov wrote:
>>> The dtsi infers how to compress from whichever SPL decompressor happens
>>> to be enabled, so there is no way to ask for one in particular, turning
>>> a decompressor on for something else silently changes the image, and the
>>> conditional has to be updated with every new algorithm.
>>>
>>
>> Thanks, this was something of an eye-sore to me for a while already :)
>>
>>> Move the selection to Kconfig instead, with proper help texts and support
>>> for all available compression algorithms. Each choice enables the
>>> decompressor that provides it, and carries the compression level.
>>>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    arch/arm/dts/rockchip-u-boot.dtsi | 16 +++-----
>>>    arch/arm/mach-rockchip/Kconfig    | 78 +++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 84 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>>> index 4ba6a87e78ab..a72b55cec05a 100644
>>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>>> @@ -11,14 +11,6 @@
>>>    #define FIT_ARCH            "arm"
>>>    #endif
>>>
>>> -#if defined(CONFIG_SPL_GZIP)
>>> -#define FIT_UBOOT_COMP               "gzip"
>>> -#elif defined(CONFIG_SPL_LZMA)
>>> -#define FIT_UBOOT_COMP               "lzma"
>>> -#else
>>> -#define FIT_UBOOT_COMP               "none"
>>> -#endif
>>> -
>>>    /*
>>>     * SHA256 should be enabled in SPL when signature validation is involved,
>>>     * CRC32 should only be used for basic checksum validation of FIT images.
>>> @@ -61,11 +53,15 @@
>>>                                type = "standalone";
>>>                                os = "u-boot";
>>>                                arch = FIT_ARCH;
>>> -                             compression = FIT_UBOOT_COMP;
>>> +                             compression = CONFIG_ROCKCHIP_UBOOT_COMP;
>>>                                load = <CONFIG_TEXT_BASE>;
>>>                                entry = <CONFIG_TEXT_BASE>;
>>>                                u-boot-nodtb {
>>> -                                     compress = FIT_UBOOT_COMP;
>>> +                                     compress = CONFIG_ROCKCHIP_UBOOT_COMP;
>>> +#if CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL != 0
>>> +                                     compress-level =
>>> +                                             <CONFIG_ROCKCHIP_UBOOT_COMP_LEVEL>;
>>> +#endif
>>
>> OK so the obvious question here is "why Rockchip-specific?". I
>> appreciate you're mostly working with the RK3576 but I don't see why
>> this (the kconfig symbol definition that happens later in this patch in
>> arch/arm/mach-rockchip/Kconfig) needs to be Rockchip-specific, we have
>> other architectures that are also building a FIT image with U-Boot
>> proper in it, so I think it'd be nice to have this setting apply to all
>> of them so that it's a more generic approach.
> 
> The Kconfig selection itself is surely arch-agnostic, but I have no
> idea if the handling of the resulting images will work out fine on
> other architectures or what their constraints are, beyond what the
> build system can tell me. Rockchip is the only one I can test, so I'd
> rather start here :)
> 

If it's the same architecture(s) as Rockchip, I would assume that if the 
SPL loads a FIT image, it can load compressed images too and uncompress 
them on the fly as I don't see why anything would be different here (but 
maybe I'm wrong :) ).

I understand getting cold feet on enabling this U-Boot-wide but it would 
be nice to notify other architectures that this is now (well, will be) 
available and they can add support for it/test it. I'm thinking we (you) 
could do an RFC series that depend on this series here, that enables 
compression = CONFIG_FIT_UBOOT_COMP and compress-level = 
CONFIG_FIT_UBOOT_COMP_LEVEL for other architectures that use binman and 
generate a U-Boot FIT. Then you let the maintainers figure out the rest 
whether they want to take it or not (after testing themselves). This RFC 
series wouldn't be a blocker for this series, but I really think we 
should implement this in a generic way at least on the Kconfig-side so 
that other vendors can implement it similarly.

>> I'm wondering whether a
>> direct argument to binman would be more appropriate here instead of
>> requiring all binman nodes to not forget to add these compression
>> properties for the setting to actually apply. Of course this would still
>> need some logic handling a binman argument and the compression
>> properties both being set, and likely remove the properties from
>> existing DTS.
> 
> Not sure that's a universally good idea: the FIT needs the compression
> attribute anyway, and it comes via the DTS. Passing the compression
> argument to binman via the same DTS reduces the chance of the two
> going out of sync. The alternative is passing the compression to
> binman via a separate back-channel and having it insert the FIT
> attributes based on that. To me, that sounds strictly worse than the
> current arrangement because it turns explicit settings visible in a
> textual config into automagic.
> 

Yes, but at the same time, you get a truly generic solution without 
requiring architecture/vendor/board maintainers to implement the same 
details in their DTS (reducing boilerplate in essence). I'm not sold on 
my own idea anyway so not a blocker for me (and we can anyway decide to 
go this route later on).

[...]

>>> +     default ROCKCHIP_UBOOT_COMP_NONE
>>
>> This diverges from the current state, instead do:
>>
>> default ROCKCHIP_UBOOT_COMP_GZIP if SPL_GZIP
>> default ROCKCHIP_UBOOT_COMP_LZMA if SPL_LZMA
>> default ROCKCHIP_UBOOT_COMP_NONE
>>
>> to keep the same behavior (not tested but I believe this should work).
> 
> That was my first attempt, but it introduced a circular dependency.

Do you still have the dependency loop by any chance? I'm assuming this 
is something maybe some architecture/board maintainers will hit when 
wanting to default to something else than COMP_NONE?

> I've checked the current defconfigs, and none of them enable
> compression. Worse, LZMA had been broken and couldn't link for some

confirmed with:

./tools/qconfig.py -b
./tools/qconfig.py -f ARCH_ROCKCHIP SPL_GZIP
./tools/qconfig.py -f ARCH_ROCKCHIP SPL_LZMA

> time until I fixed it separately (it's merged now), so I'm reasonably
> sure there have been no active users of these settings lately.
> 

We would "break" (change behavior for) existing users which use a 
non-upstreamed defconfig, but we generally don't care too much about 
those usecases.
Fine with me, but this needs to be documented in the commit log as from 
the diff itself one could think this was not done on purpose (and we're 
technically changing the behavior even if it doesn't apply to any of the 
upstreamed defconfigs).

[...]

>>> +config ROCKCHIP_UBOOT_COMP_LZMA
>>> +     bool "lzma"
>>> +     select SPL_LZMA
>>> +     help
>>> +       Compress with LZMA, run from the host 'lzma_alone' binary. The best
>>
>> I'm not sure we need to specify the implementation detail of the tool
>> used to generate the compressed binary? lzma_alone is also only
>> available on Debian-based systems (e.g. Fedora doesn't have it), so I'm
>> not entirely sure whether it'll stay this way forever (maybe we should
>> switch to another implementation that is available on more/most
>> distros?). I understand you probably did this because it's somewhat an
>> important piece of information to then decide which level to use.
> 
> The peculiar host binary which nobody ships these days is precisely
> why I decided to mention it by the name. On my main Gentoo system the
> legacy lzma container is only provided by the
> not-so-easy-to-figure-out lzmacon package, which then requires
> symlinking under a different name for the U-Boot build system to pick
> it up. With this help text, a user at least knows what weird binary to
> google for, or what substitutes might be available on their distro.
> 

Can always be improved later on, so fine with me.

[...]

>>> +
>>> +endchoice
>>> +
>>> +config ROCKCHIP_UBOOT_COMP
>>> +     string
>>> +     default "gzip" if ROCKCHIP_UBOOT_COMP_GZIP
>>> +     default "lzma" if ROCKCHIP_UBOOT_COMP_LZMA
>>> +     default "lzo" if ROCKCHIP_UBOOT_COMP_LZO
>>> +     default "lz4" if ROCKCHIP_UBOOT_COMP_LZ4
>>> +     default "zstd" if ROCKCHIP_UBOOT_COMP_ZSTD
>>> +     default "none"
>>> +
>>
>> I'm tempted to say this is not the place for this and rather should be
>> in rockchip-u-boot.dtsi for example as a series of #ifdef (but if we go
>> for a generic implementation that applies to other architectures, then
>> maybe it's fine like this).
> 
> Noooo - do you really like #ifdefs? :) Having this here means one file
> to update when another algorithm gets added, as opposed to multiple,
> which I believe is a worthy quality in itself.
> 

People have various different opinions on what can be part of Kconfig 
and the above will likely not make some happy. I don't like it, but I 
also don't have a strong opinion. Also, if we're going for a more 
generic approach, then this might become an issue rather quickly as all 
base DTS defining a U-Boot FIT to generate with binman would have to 
declare those strings again. Can always be changed later on in any case.

Cheers,
Quentin
