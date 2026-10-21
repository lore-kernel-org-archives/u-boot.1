Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D487606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=C9Y5avUt;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=wi/N7WoM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EF95407B2;
	Wed, 21 Oct 2026 02:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjuqgoqMx2eU; Wed, 21 Oct 2026 02:14:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F0B840761
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792548866;
	b=LLlMxUh9sm/XgcBJA9Vhju7iTgHO1frteI83kqx+DEo3Kb1r9ZABdxrpS379IGRKGAut
	 GGftvVnobpTQG03P7o3OPT7DtZLqYdlNgnzL8zbBYaRyHhI8FSUwzyXS1UVooQ7mNHZ4E
	 YJl13ZR8BedKkbGPEkLtlVdPiOE6dg/8XIg7jPlVih4l24TnovT3BD0dcaHam28D3abz9
	 Kz8SmhweZdONd7XqewvYbunFW732x/0AMtHqNc5tCqE6i8NDhPHG4Ymggm8x6ubG5dMaZ
	 UCe3Manfygd20x5SgYeRTT69FyxBOBqe5ZPG9jolcRmBL81eT2D0uyJYC5spdM+kAaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792548866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L4WUdn2ovoSk6pyk9ga3zxKbCu+QmXPPnUimJi83AmA=;
	b=eMmFhbPitcj8XuGu23gEU2FAwkSiK3ydYXoBmhHodpLMr30jVQDHNzQ4yQr+3ZaFL0ck
	 tqEU8fABSEPcPet/BfXNizbHDdUyQkkYG2EpftPT5faTdmR4KnSWtFrxJCZ1LkOhwJGt+
	 QOjW5iogJfyro/ZaaxLcNnaFyHdzIDXNkQdM4/u1PnhLQlvvo7q0Ve+ZVANuWNo/6Lagc
	 HWpy5OVuZG+N7wrxL43zW/c4zVTxRk0IEnGTUbNvYp7t5MqpNPaMQvju2QqzP99wfwsJe
	 2dLc0IhF+gDM+3/RTTZk5mqKw3LYpFyuXleOJnRuR4ZHYX0qlng9WvZnLryaDmCDydw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792548866;
	bh=L4WUdn2ovoSk6pyk9ga3zxKbCu+QmXPPnUimJi83AmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C9Y5avUtcNse3ZYXAvqh5s/TQpvlDrnMHUSJW7W6yKvXsU4M+C7Y2dw1KOChmoBXN
	 BhqmU+y3M67+ljdELXaEBsPYU+54Jb/MhQdt9rMUs491EdJv2CLnodIyq3gfa5C1ZY
	 SF+DeC5ILBALAqawjOeQ+9OegwN9iMnQeTc0tjHFhJY7iGtZZ3spBW5ejinuTWfm9Y
	 1oRHzQSq9WW7ZdOR2TVrxPIUMEl+qZ9u88wpZTNJj5EoLsAozXwR1ontMYkxTbS+mf
	 r3LPc6hLBdVs4wnZzldIfnwlvpQL5unrSnjlJdoGMZW5u1mKVRPCV+S6CUcrY9PhvZ
	 iCb/ouTlBexFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0B840761;
	Wed, 21 Oct 2026 02:14:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B867995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D9B780CB6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HY8S17hCL4dQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 02:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F31F80C2A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792548863;
 b=O9wGFvG/IsPHIxCcZfbfNXV7rvE5JEEnZJ7PokgNEQCzB2IBtQ6XDr3h5IVxeqRBYPIo
 Oa0Nn4fZg3w/Yu4m/7/4usxEcrEUwUmAQeyQ6uvrEgzek7VKtZKHOu83CkOkugDCDdfAv
 6Ahx0GuP9Egp9YIMulkJNq+eLUDlfnYZoy5ZZm8G4rpvqm83EOTEbIUZ4NUgWTLJhir8Q
 ojd1MjT5dcjfeqgFqp+cZ8qAQE1IJ/QdKI1TWzUtkcXwx3TCyKRA691dFjs/4Uh1y49pz
 hWMEkb54eqWKUGlIzKedxMXmXaTJ/DKdsT2vTNFP08DqLko3jahKRs/KKl6p7tQBQtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792548863;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=L4WUdn2ovoSk6pyk9ga3zxKbCu+QmXPPnUimJi83AmA=;
 b=YO83jFPuTCs+Fx9EQEKklQ+mr1kl+/fmofmGAEtzvTUIxMFFZ7ByDqliI6jNn3GJEmee
 BxrLUgXx7dx6xgW68OOJbISCNjFs4D4evOQztKIvS4xenrl4a1+8x/J94iL32FdJq8W93
 04lbEVAcMUbO8KSbDSWa6BYBHa2AkKQv+BzCU2tGxsH/OrR1fumUCM5xaCsANljPv1/lI
 RNNuO1j3e22+dX1P9jBh9Rmv7Rk1+SoUOSauBX6ZLzcLDtKmm8VIp4tmyfkV/LbU+sRjM
 g4n6KAm2MoRoCGQQClcvFrbwmGPN5Vitokv5b+4rgnOecgexTSImrKobs4EuLFNnz7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="wi/N7WoM"; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wi/N7WoM
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F31F80C2A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 02:14:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA6D844F6; Wed, 21 Oct 2026 04:14:17 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90188056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 04:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhVHD5tMc6BOggABCD0uzWGacGVkfVwZinCPu9g6avP5rL9bBFoWl39WqaRIGq1YNpy8qJLn9c2c3BDTn2sLUoBvWbf86UFKhmwjxUVwV/8YQGhsio+ZFEHepvtRkaRoVcdxBfmBHe58sywM4JCKiruQHX1JpOZ3MqK891YuDHfziik72rUbl3RrxQOVFsdlpk3+KuYQRFHHvOUfqWqI3slotjRd13CS/XsP3KXI+l4i67+ZlXl5BlkHsGi3tglIBAOQqTQKZwO7JuC674L6yFNqsG7hGSnv/0TX3D+JEiCq0Fid7MgBWD8zTrF83BrwF01keoUHtFdabt7rU3zhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4WUdn2ovoSk6pyk9ga3zxKbCu+QmXPPnUimJi83AmA=;
 b=LDqNrQzNUHkO0lZYPi4lpq0y7Ihp2qdz5ehH9IF21z84oMFhtUmpgxX0LLIKeoCQodIv12ENs/Tw0C27JesFjvinF6QngixZ1qC5diOeFqbbiT+X/lxYqxoMjSR8M9mRM9/ny85lKIfz1QJcdo2Ka+tJ9m8ozhk/VZWUWn+A+mPeJST4ZPCd4AD9vgt4D7Z5m+izM7W4GYGe0TQjaSDWnUx/Hjyo7q3maQ9IaVVs0JPLkcXDbW/t/KbGhR5sIvUkBj39yPV31YMbYo0GBwgk0vQzkCMWCwE1RzNB1jBdPuximyN4Ckrd7A7UFYMt+AU1ahMyCSiTY/Ks/25JbV7yOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4WUdn2ovoSk6pyk9ga3zxKbCu+QmXPPnUimJi83AmA=;
 b=wi/N7WoMmEsQNYbBJye4gGHsGHSTLic+XZAUK34h7DfBGQd+1pd4U0lECbdMODTMb4VRs2D1pfJEU74IuVd0y6h/K+s3IMRpxvCF4ap4BtYJQUv5pKvGHPzsacwnOSlb5gZz6bK+w/dREzTMYEUqRyIHWFbI8LtWoBRQO1e39U52/BoRw7GphjKnBObDGkVIeJlk8euuajTCA2SZpFlFXDpTCD8pG9pIn+runaEyrd4GjcjlNdKCwcqIyriqq5kRHMU+LJkhKt/Cn3FhsvdWPhhxb6B6YE1HkrwLqxxlvRS09gUEuQhzUs/X/gvyNDiL5JK5Y1Gd0zznJuly5havQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by LV4PR03MB8257.namprd03.prod.outlook.com
 (2603:10b6:408:2e1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:14:08 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:14:08 +0000
Message-ID: <c3261678-f7ba-4567-8ad2-21a91e56070e@altera.com>
Date: Wed, 21 Oct 2026 10:14:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] ddr: altera: n5x: Add self-refresh support in
 DDR4
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20261016044047.21496-1-chen.huei.lok@altera.com>
 <20261016044047.21496-5-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20261016044047.21496-5-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::15) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|LV4PR03MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: b082c3b1-2a50-45fc-4417-08df2f18fccd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|55112099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: VN6KJ7nUy5Dy8SQMG8CFQdT1Do3wEsfspeJPWhCWCkyO7O7drgLJlAmmJWdDYyu5lGlyauPS0Vs2S+CcI2GnsBcpj8H76LTKiVQOcmVYkkl0ruYMRSzXzwMtJkKfTUFtaqVf60QOhuLlOliEwX8L3VJnfFhdO4ibAZ9Vm2XL1lrSQ/p6anSTExxW7rcX/Hd/unRNxInbEDblXFJVE6x+1J1OQdkGo0QRkuqcoVX7TuDc7zc5ci8vXN8WRYGNcTjkieLirzOOXPU4SBnHDaAOa93biaefs7K26aB2ktl8E6hkcv5lMFjwOLKurEM0FV6hvLLzwg43pEyONHc14q8G7FscJc90tBo4BhyzuvczBOBK8G9TIjuWUnw2MFENaEBFFS8XlJ3QG8vtIdNrMEucLkNQ7PSEbshh4BAIKK0Dq9JRNwiAXp7KgZpaWuqcJKLi1T/j0crIdwQzkqV9GZg6e10tFcEBKCnik+akisDpOcexHpFhkeqTSrNjBFjAP5qX1VcAtOO85ggGZojED/rTMv8UBFZO7ld0wrM3YeCbS7kxjmMDb7o/yTp1Phc+CG4Aoe0i5BusBhemGYgkiPsw0KLL39MJxrZYLrjIDa5O5HK9JL3GuSsZXiJNBSOBObGDhJx/FkhE9+hB1jSbLwsBzI8f9VLTnd3YF6jKcD2V1us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(55112099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJISzJwZS9YZ2g2VmVEQTNjTURBNzQzRFdkTnRMNlNTMkw2RGQvaG1OTGNW?=
 =?utf-8?B?MGV0OUcxb3FSbExIRUlqd3VzdFNOeEY3bzZFckY2RHI0VGVsMkd5eW1XYW1k?=
 =?utf-8?B?ai92WlVITEdzSjNQWWd0VFgxNWY2SnROR3A5di96SEJ6NXpSNFNKcVdiQldE?=
 =?utf-8?B?NXY3VDdja2lLUVhwMUdiaS9QOFkvM05QcERsYWdKRHJEWmtldHQrK0dXSmE4?=
 =?utf-8?B?enlkR1VHeWhoa2dqNG9ZYXRXZHFPWEIrdTFnNEQyUWEvOS9sM3VJMXRSN2Fh?=
 =?utf-8?B?dDhtdDNzWjMvMUxXRXhDaUJqc3BkUDN0bDhyZG5kLzJJUHVBK2ZjSXNqOStm?=
 =?utf-8?B?OHhGNWMwSTMvZWxHUUJYaXRSVXh4ejVmNjZuOUsxRDByUHpUY2VsRnVkZEJ0?=
 =?utf-8?B?T3psYTNHRE9hUEsxTE93RFhhRHVIWVRSMDRRUmdmcTlHM0t5dWRrRDVGcGZs?=
 =?utf-8?B?MGVTdUFiY1BXWkkyTXdSdkRaSnFWS1doOW5lWDRMUUNRWkZRVERRVGVETzQr?=
 =?utf-8?B?OHpEUzhJamJLK2F3NVlMV3c1cko2ZDlqWUhHTlZIMjAzWjd1bUpzMmlnN3Bq?=
 =?utf-8?B?T1dhdDNNS2VpS3ExWkpBekVwMHdoLzcrWHFqWThMcHFaVlRxNE9rZmo5Vi9E?=
 =?utf-8?B?UkNsKzZPUDRiN1BNVzRvUVgycTV4anhNZEE5UGZsWGRNQWJTZEJxd3V6aTFC?=
 =?utf-8?B?ckJmTkgwOTgvRVpLQ0RkRWlaWEpZSlRIUHBPem1VMkR5aUoyYWdHaWQvUWFN?=
 =?utf-8?B?eGQ5RW1TZTNHUHoraEtvWDVURDA3NHlvbkJLZGZhOGxDcGppTTZBR2tCeWpm?=
 =?utf-8?B?OEl3clN5bEljT1Q1MVBxTUIxUmR0OEh3MWRUbSsvMkV2VEs0QkFYUnJicklm?=
 =?utf-8?B?d1RxdUFDUHdqRTFFeUN2U0kwbUJVaHRNcXcrTGFIb0NmL2lzSVhXNmRyS0hW?=
 =?utf-8?B?bHYvZDM4V1ViRFJSdUE0ZG9DakZHeDEwOTVPS2tmanM0MHVPdzVWSEIza21J?=
 =?utf-8?B?MExGY3A1TW1aNG5kb0NwSGRJT1RWcG9VUFIyMGpZaktSN2VpV1ZyWWZhZlFC?=
 =?utf-8?B?dmVzN3JHbzJwWWlNU2Jib3VTNjRjUm1xRGZJQWVmcnlaQTJGU2RKREtwTTE1?=
 =?utf-8?B?VkN0dHRjMUk3aG9LejE2aEZsSGRvazMxUkp0Zml1QkN2d2RucC9tc2RiVmlQ?=
 =?utf-8?B?THVwRml2VEU2YzdwUFYxWE0rWE1TL1c5Mk1TQUZsT2FLRkxNeDB0d2Jxc084?=
 =?utf-8?B?Y29PY3A5cGlxTnA2U3ZTdDJHeG9tZlQrRDVPajVpVHNhZERkWFlnODFIL1Jk?=
 =?utf-8?B?M1RIMVBVTFRQR3JjRTZ2ODN5N21jRm9FMTdFZHJ0RlYxSlhKaGdNRnZPazFJ?=
 =?utf-8?B?ekhnRCtwOFUvVk50RGZ2K0tRcHRucG9DZnBjL05BdURUNGFRQXdXRk1YMHl5?=
 =?utf-8?B?cmdnaER2aThrY1pDSFM2OWpsSDZzSjErQjZXZFpzcCtzNkhTdnRTSjFMd2pP?=
 =?utf-8?B?TGVFeWZoaEhJaDd3STlweHZrZFNyRzV6RlZ4eUhOSlJpK0ZJKyt4bk9TSlJU?=
 =?utf-8?B?a1RpQ2RJY0F2VTBZd1pwZnR4cUR3MVc1b3EzbnpISURPTVB6VkVtZEM4bTZk?=
 =?utf-8?B?cVJMZWwvVXlJTXE1dzVodURKUThDMGZWREFySTY5WEcyWnJUZVJUTUk5L0Fp?=
 =?utf-8?B?WFZxM3J6RjBQemNuZmh0enlIaFlQOWdIVUxJRWtUUUdwVVBmV2dWbnVWRDFn?=
 =?utf-8?B?TzRpSmpKRy9LNTlRcHlKZmtqY0RudUZyeHBQRnlZTDB2VTA2MXdUT0cxbk1q?=
 =?utf-8?B?cnFyUlVzb2YwRWx0eXdpSkVYUzZXa0ZNRCsxRERreVg5dGVCMG0wNm40UVZE?=
 =?utf-8?B?UEFSK1UrbUQ4cHcyQStCdTdUdkRJbkpQT2YrNzNDQlRUZUlzci83dVdIbzFY?=
 =?utf-8?B?SVcwUlprTkJBWTN2UVZ4K1Y5bEdLSUk3OFFlUDg0R1k2WHRzdHQ4QlljREJQ?=
 =?utf-8?B?K3NwbzhsOXJTK2VSdnJoQ09QTjNlbStWZWYwVW5vOVF2b1BQNkVpOGo0NTYz?=
 =?utf-8?B?MjNiRnBya0FpK1lTY1NRNk1Rb3FWVEd0Y0t4SzhCZGZ4bGdWc3lRMmhWTWRq?=
 =?utf-8?B?SWdtdFNnNkExOERkLzdOZTRGVzYwRk53Y1UySXBhM0RudG83bWxZNnFmY0xp?=
 =?utf-8?B?UjhPdk12QkNnM1cxWXpUR3B3OWhBandXL1FYQ2dqZTZETUtuMmpoMkIvd25I?=
 =?utf-8?B?K0kzalM0WnI2eEFJV1JPUEV3T3NTVTNQR0kxRHZORmZUOERlQ3dDektKV2tJ?=
 =?utf-8?B?MmxUVUZoK2NSbDB3eTBUOVZnS2FrbVhBbSttY3VyN3NUNGl5TUxzUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b082c3b1-2a50-45fc-4417-08df2f18fccd
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:14:07.9549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQrlmafarMEPNrGXCxfcV1s/8RGJbI5rNMvPjx2pRKVSqbPiqf46+R72xDPHq43WXESP7eCKKYdT2cBYxQ6s8MgYla5O+I0vUJIRLydM31w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8257
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 16/10/2026 12:40 pm, Chen Huei Lok wrote:
> From: Tien Fong Chee <tien.fong.chee@altera.com>
>
> Enable self-refresh support in DDR4 for retaining DDR4 content with
> minimal power when reset is triggered. On a configuration reset with
> retention enabled, the trained PHY calibration data is restored from a
> backup instead of running a full calibration, so the DDR contents are
> preserved across the reset.
>
> The same INIT0.skip_dram_init / PWRCTL self-refresh entry settings that
> LPDDR4 requires are also applied to DDR4, as some DDR4 chips need them to
> enter and exit retention correctly.
>
> The backup calibration data is copied to DDR only when DDR retention is
> enabled, and the backup header length ('cal->header.data_len') is
> validated against the HPS handoff region so a corrupted or oversized
> value cannot overflow into the handoff data before it is consumed.
>
> Look up the DDR controller node using the "intel,sdr-ctl-n5x" compatible
> string so it matches the node defined in the device tree.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   .../include/mach/system_manager_soc64.h       |   3 +-
>   drivers/ddr/altera/sdram_n5x.c                | 869 ++++++++++++++++--
>   2 files changed, 790 insertions(+), 82 deletions(-)

[...]

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


