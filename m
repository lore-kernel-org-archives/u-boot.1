Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FD606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mp9bZ0ak;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=oVPxq43o
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15B6640639;
	Mon,  2 Nov 2026 09:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWyg3LpgupSN; Mon,  2 Nov 2026 09:09:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2E88406AE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793610587;
	b=QanEokTZ8LQ4wHZna42ZLNajG6EqPk5xLgOodMyhtRplS8XfGigyqU3rHm+h27Mde/ua
	 oR1JpFy+L7+BLyVy+KD0gxgasMmLF8nw36Cc7JhHjX6l7ZJDg/3F3sLfd08D5ugokw+wq
	 PflV9Y9f/2cgZTGAbqsS5jMpf+fekSXzBgjVbJkvcoBY6d1b5nqs2jtvTS9zd/rt+0RMJ
	 Hz/D6pLH35bxisid1F0yP7lt3/jd4nwaVDGPKJwPnaMUcEkNDRSESVnTk7EkZOVdLRuRz
	 6pV8+nsmJRACxRuUedmjAVq8nBld0n+DHrg9jkQ96SvcFWqKAIWzL+65XhWte8GGrBA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610587;
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
	bh=+l9Vq5PHR10Lffqrb6f/NAUtOf6IBRZ62g30lCvPRbE=;
	b=VmDKHI45VOQHIpL3UyW/PUPJkVYQx3osR5DACB0oa/vnS+h8UP5NOkoRvCtxWLwkRoOu
	 9QLnOxrXoFKHovpg1jqAau/a1Wp5Gn5xuiEQeRBARlizSVk/g0S7ARrMzJQaAeDnYt30m
	 v0vYejSE8oD2OqnH7rKmXjWo6GMzBgQJ77e4inbJSaNz40j0pNOn/22pJ2ijG2CL+Q54g
	 iij7wCB4/gMN/5Zn15pVJStNMLH//QsPHwzj42XnP16eL1mk1oDrS220XSTDMBb/uVtSm
	 iCTQZ0v0ZnF6LywIJQgHIlJCYkRoTAxvqb8lwLOeRT2kIHyvNAzMWTGEJ0F1HEBVrnw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610587;
	bh=+l9Vq5PHR10Lffqrb6f/NAUtOf6IBRZ62g30lCvPRbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mp9bZ0ak/Rh0gkzFCs3lzCj31YeDGMhtuEH76lrWxPquvRKBqax5TnaPLs2i9nTyf
	 PlsBikQlrp+sBHGGl6ESsJtFDEES+zAKmef3cCC/ak7Q3QMImLFZMI5Z2At2txzmaM
	 VxTZZ1DNMQc8lX/JdPmhHMB0l+0mmNBQbc4Nzp9GWjdrL6xRpFScdxVGiOa3bCOZev
	 HO5v7XNmj6ngLA0HHxQlBj3yiUkF3CV9Mqe+yfFPGpYX1k91Ycq+SvZ5VClw0h7LfL
	 4dgyk2i0KHXLKmuzcTLEuAalYa0BzFIrJfr7eU+P7H4e7VK1km6HvZIE3tX/YQXWbN
	 Vllqrm3HMF2Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2E88406AE;
	Mon,  2 Nov 2026 09:09:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B51C6323
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6AB5400C8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ryIQH-bVo0Vx for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6C16F400A8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610584;
 b=ld8ImXgoaWENKwk1LHJfmOU9ul2E0FrSdHZOY5pkUVTyHkXOJC17Vd4ItvSGPIQcoEml
 YlpYFXFZWCyohAhqdyyO8z0BkUdx34lfkGgPdqMh4iVXkvm84l7Ji25rWVOpdPuZ4ti12
 AVw3l+Onws35BDrEZk5kk5/QYcgImdLDsXmxX3wDnRbc1y03ok3p4K8jKtRIxS22qm5DZ
 4gx2rnEbA6BvZeblICqRaznwOI/stkM+ermCUMVZ9MU2+D8lWrhyr9eDlUguo0CRGz7EC
 vbpUCI3erCq5B+SakZKzetHBK7xfKEHPisZG3P6xZuO/M3DNnF346upOudNhamB6Zlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610584;
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
 bh=+l9Vq5PHR10Lffqrb6f/NAUtOf6IBRZ62g30lCvPRbE=;
 b=RhjHpCu6vYeJ4hzRLBbDaKr2UsksIwZl7kqFU7pchIQ3mP5LxEVSERLTw0y9b4xI+Ylw
 6ZtVrXM+Cgf8MDZ9BpGgIaK/0zah0LElDUriDXdUi56Obg9HBcHbKbmZxbFjSjXIap58h
 KlTpXgl0kpSPvSHML9og2rX9tsEJVMB7PC8dLKvMNnUUTgpovIFghmS2aRcAQCrYWQzqJ
 onfG6um9llkIqrcBIqTH2FCGIzJO4TDn+YwckFDN1vqHlFAa8td/nGoTlEMGeoEpfeWYz
 h+qEE2Suq0fTEwLcmBCwCGFAteNKZBFW5FK5j22LN+oZN1p3kCkQyT1JrpUY5hN/PAw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=oVPxq43o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=oVPxq43o
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C16F400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhZPpbj0eIj5SQ3TQcnGrX5LhH8gEf2eLMoPUMcCELb3YlMkuydaODVIpnUGOVFUmRgB8uOlN+kq9u08eSjwvbwQ5zA7O3MIa1NC5k10W25INVx3Xp14RRUQwTh1Po9Q51ojE1X8inYTWm5SASn4Pk6uEfoMVgegllCs7wsqeANN6yXHkHAK6Ua0KaEG18I7mqTRpLFVmtZvUks4DbDRI3DSRfxvTSxG/l/jdID0bmm5JGfrl5CKvj8wHYjy5zSrheoL0JByrICop3afbSVoDvLRiTglLyDqiahwHgpi2de9g8lijLtjBl29QPHs8/Tn8B17it+ik42k3uyKfwM5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+l9Vq5PHR10Lffqrb6f/NAUtOf6IBRZ62g30lCvPRbE=;
 b=T3Qotm95F5ujOqynB+V8Wm2mv4VI2e1F9HKur9ZQ8RPeSZtJn6z6AIHMvjIaWvrw6k/i03AqXihOodbb0SCOPCWSf9i/FIlmq9ohv3C5GeZNdE84GGC1K9s/ZtzaG7QYG2fgjHiHZeOxm+b9oc7UbJqbSPjQAheKiCJIxFJfU9wod1sWzL28CV582pOMDprblN78h9x0RMZrbjZ9pICjsTZW3zj8FKidCgQpSDGgMY4PEwso18WFhPJ9JkHCi3yR+5z//NkBLgjgF/dGcNl8OMwWitTygCDLbm8cGzDY4fCHRPlX+J3t+tbEQ7gDbSvPSaA+6lhgR4v8aiVoC5XIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+l9Vq5PHR10Lffqrb6f/NAUtOf6IBRZ62g30lCvPRbE=;
 b=oVPxq43oU7JCiuvEmtXz9Jb86rRyjXIaAkz0VTnbwKWXfyDuvPQ8DosgnEnaGdnrnExpt7EZ9dtXjujrRynvAzUCrHpQqMzEq33b1oOyLKMBCT7necnqdbzNAqhhIhyruPpSGrk/tBrh4hB42tQZZX5cMVC4dn1DkZEHXpMePVq8Aalh9zUHyMiJj0fhhR8Ire2ZGQPkYOOQuBFT5j58888hOiyS+46k732MOWior78+8isAwvS8nx5F430xuSA3gnp6dqMqodeSHC9P6h3/zIqp+9bfd56CYCNx9CUBJTjB0kdinnx55LVN99liR3fVR7cFomshXAICySRSDzBOug==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DB8PR10MB3692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:09:38 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:09:38 +0000
Message-ID: <b095bcfa-0b33-4aed-b787-9d81950605ff@kontron.de>
Date: Mon, 2 Nov 2026 10:09:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk: Unbind partition devices when removing a block
 device
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>
References: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
 <20261027-blk-part-unbind-v1-1-e44d2b48ced0@kontron.de>
 <CAFLszTiMidJ5usDh=F4Cdg_NTKSdAd8zrZUreGcdW=SCG0vEZQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszTiMidJ5usDh=F4Cdg_NTKSdAd8zrZUreGcdW=SCG0vEZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DB8PR10MB3692:EE_
X-MS-Office365-Filtering-Correlation-Id: c5bae829-7a51-457c-274c-08df38c10545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|4143699003|5023799004|11063799006|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: RPg0WuhRIwAslOdntt6T5nO05NQp/TY/QV9ZLAQ02S0NgY0FbxnYiSzjk+F+3CcMaRVpXOQTMq8pV9rGl4O7P3XO/xDZd30tQwvPGn6aGvKq3aZZ6Gs0LPeUBqFk+iUkYDvpLlmJ9+xnkVGnOndYvpEsKy7LYZfhzC5ks5tS4g14J80Y+u0eF7sanBCvLUDVoE4tozy4bWcuKwptitA1kmC5P4pJe6A+dxSnR/zn6cAyEjQCWa2ejzrucCigjVICzOXfUwRu0FHA2VhhLmY0LTlSAZwIW68TNCVJhFQh9o5mEZI1JfDU/3v92JTqGIMFJF21C4VdXgENssrmMCIkkaX1BKgZ2k5FUWSQUAxzR9rB3Y4QQ98FNegV0azB5M6dscMmjgas+oi6n5Sd48rs4IfxcKdBRnS9dX42Pa2XVVOM06Y3vkND2JdMdQ1dXzOHv9pd1TpQP+qvFWt3uHmlIvaZwFGMEpX27sKGxRYh2pOgSjNvylkxsJ/jA7bIM15ByR6T/jUhF64GA8+MvXir3i6U2UzVSKedxK9JMs1LxtiPSeuMlARmMcgTliTrk3lcadsKJ0OIkcM2vfQg8oJdzXjH+ntRE52IKz548W9wAKKNcXXZbzX2vjsCOn9xEPEzqqza0qB2qm5M/H4qeswRV+dFYRUisTipenl9xEBUK7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VyUGlnL3J2VDJpaVk2SU90RVEzeW40UzRZbFBrS0tpODJwSytYOU1Xbndv?=
 =?utf-8?B?MFd6bzdYeDN4anJPYnlkM1llSnRsNm9nc0tUS2laVWowZmFRa1J5S3hlbEhL?=
 =?utf-8?B?WTJaRE4xQi9LQ2l6TStPaEt2SURKclJ1TWZlZHBtbGlacGpBbXVSb2d6OXhi?=
 =?utf-8?B?ZW5Bcm9iUXpYL2FvQXZKQk1WT0ZmT21pVlJmODFqWXJoR2lMT3BPOGl0YW9s?=
 =?utf-8?B?dHg4eTFVQTZURHhLWVQ1WE4rMzZJVTRmdmdhdUtsQy96S0V3QXcrRTZZU1N6?=
 =?utf-8?B?M2pFdlp5ZnpFM3M1TUxheDZBMmV0RGJnOUtrd3dGZmVmaTF5bCtOWW1pLy8y?=
 =?utf-8?B?K3VJYWw1NGxnQmNGZmROSDBFMFA1MElDNDdCbVNaOGlxSmJiWG01TVBRT3g0?=
 =?utf-8?B?aFJZTGpuTys4djhZZE1DMS9FREFtdFpmcXZQaWVNWUlyMGlETlpWa21iZ0Jy?=
 =?utf-8?B?V0pzVXVOODloUGd0VW5pSkttY29mQXJkclc0THBGcXVCbFg3d3N4QjY5NEhH?=
 =?utf-8?B?c29kYW9qS3M2OENQejBnRjBDbFVTSmRUWnFjNEtZUkdGcFFpZmc4WHlZTUlx?=
 =?utf-8?B?eEFIUGlPTTM3c0dyYlpxMUhXTW9DT2xUMy9PcmovYkE5ZFFmY05Xb1dlRnBK?=
 =?utf-8?B?RDBGSXlrcWVtYlVnNlNQRC9sQ0JGVkI4MXF0d3E4MWptdVR4d01ycnNLQnhm?=
 =?utf-8?B?a3pZZ2krNWViKzFncUJ6QjJrQ2sxdFBLTnlJYkNTR0NrVHF3SW1rS1B6djBH?=
 =?utf-8?B?SktVTTZYZHV5YnZrcGFYQkdQc0gxMkNSU2ZPQ1RtTGNPUnNydTZLYkdwQnlu?=
 =?utf-8?B?RXdxWTlmcjB3cHY4RVpHRHpVYkdWa3hvSjhMamJyOU4rQ1ZLbkN1dnBZVVN0?=
 =?utf-8?B?RU5OenhYb0dVTllKK3FXc0dxbnROa3NDZW1ZRms0dXlMWWZOZ2hSdzdqWXlU?=
 =?utf-8?B?NmtCeCtTTkNQOVZJR3NUcVl1Vi9HRVF4eUI1RGMwa3FlVkx6WlVBOXpJSlQ3?=
 =?utf-8?B?ZmxRMVJSZ1h0N1l2bks4ODI3S0MzUUMyT21GNEFpMHUxYTRuMDYrQnV5UExY?=
 =?utf-8?B?SEt3SU9zdzdvQkxQNjlwVk84SFQ0eUlyNG1Md1BjRXZmdk9tSU53QWlJdDVl?=
 =?utf-8?B?N3F0OUpwQ1hVN0tMVUVVc0k1cDlwZDBhYzJ6aFJoUjZQMGtPWXZlZW5SWklm?=
 =?utf-8?B?ZFBHdXpHU2FzdTEvUjZNeEpSRHBVUUhIb0owMDVHZXl0V3htd3hlbUVkeUdT?=
 =?utf-8?B?UkhkcUZJUDBWZGw5NlVEUWo2eFZBMERzQ2hhdWxqWlBZZGxzQytDR3o4SDBT?=
 =?utf-8?B?STRoZFI0UzQvcUpCRXpVYjN1bjIvTHExTThwMVRScHMwU1VUdVhoYTVmU3ZL?=
 =?utf-8?B?WmlNVDRKZGp4dFQyRjdPY1hUNThzZU5tSjB0eWgxbnZxRGxERE1zOWZyWWVL?=
 =?utf-8?B?TGtNUm44TytmK1hSaDhzdjRSdG44RUtGbnhiQ2dJUnhGZ2pKZ200d0tJWmtF?=
 =?utf-8?B?N3d2YUwxUUNZUUdQMDB5ZWRuQXR6VGpneDkyeFNZYitBTnVRWEdEKzZINmhn?=
 =?utf-8?B?ZWVIbFZRNlphdzgvazZLUFNubkRUaGhNcnRaZCticHdSQW11Zk9NUkRYa0lW?=
 =?utf-8?B?S3RPQzRJdERQa3NWOW9VWUxuTDN5Z2hrZkd4NXRUZGNIcEFMMGFvTGN4cWVo?=
 =?utf-8?B?WFc4ZzExYWZoZWFCK1k2YjVteDJiT3A4U3FJS0lESXZVeGV2UGxON3U5WDNJ?=
 =?utf-8?B?MWkzN1dGdldkQ0oxbndkb2dqbEJqZGxOOXhwN3lvWnVUSmJZbVlrb3RSalpB?=
 =?utf-8?B?S0xiMm5LR0lKTXdTeXdIUGtUREQxcy9ubWdIL29ZNy92ai9EWXc1U1ZLY3do?=
 =?utf-8?B?SzEyVkh1Z3k4U1pvbm8xRDYyQmYxZUYyRDN2ZGtReC9xK1RtN21wTGJGVkpj?=
 =?utf-8?B?cDhFL2loVG8xdStDdVpodWhCMjdCc3FnWjZlY0NKckFXOU13YnRKVDhLLy9Z?=
 =?utf-8?B?VHFCTUVmanpRamxKeUVHNGlzMVQ4YmZGemEvdDlIbUNnb2MzbEFzaXVXWXp5?=
 =?utf-8?B?dS9YRGw2TjU5akh3b3RqZmZPTHlXV1puTTRUS0pLVkM4cUpYY1RDWE9uUDlV?=
 =?utf-8?B?OWd5SnozZlplV3BEclBzaGRFYVFmanhIKytQSExGcjZ3VFJCenNNSk9pelp2?=
 =?utf-8?B?NXVldlpQb2FTOGtYUER1aTcxZ2FjQ2E2K2hOTkw3WVFSSURvVWVHOUZCcDBo?=
 =?utf-8?B?S0lFVTJyd21xdDFRYUxMV2FsalZybi9uRHNNUW5XaG1XMUpRUHVKTVRLdEJX?=
 =?utf-8?B?UWYvYVgydU9nYUVraitOWENLQVlma2RscVZNMkxCaEZSbzFUdVU1TW5HWjJ6?=
 =?utf-8?Q?bVUnPasGBo3mbuxU=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bae829-7a51-457c-274c-08df38c10545
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 09:09:38.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imI1ETvGjVOOEcKnrap+7QIg8X0qj8M+r/02FcGste72SHK5V8cKDeAX5w7Mvf9FCGND8Iz52LYgEa7i81oFRfZEJ+I8RKYhjsELU4OqEDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3692
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

On 31.10.26 09:47, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-27T14:16:39+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> blk: Unbind partition devices when removing a block device
>>
>> blk_post_probe() binds a UCLASS_PARTITION child for each partition
>> found on the device. Removing the block device removes these children,
>> but does not unbind them. When the block device is probed again, a
>> second set of partition devices is bound next to the first one.
>>
>> This happens for example when the probe of a block device fails in the
>> EVT_DM_POST_PROBE event and is retried later. The EFI disk code then
>> iterates over all children and tries to install a second EFI handle
>> with the same device path for the stale partition device, which fails
>> with EFI_ALREADY_STARTED:
>>
>>   Adding partition for mmc@42860000.blk:1 failed
>>   switch to partitions #0, ERROR
>>
>> As every further probe adds another set of partition devices, the
>> block device can't be used anymore until the next reset. This was seen
>> on an i.MX93 board where a single failed read during the first probe
>> of the SD card made it unusable for the rest of the boot.
>>
>> Unbind the partition devices in the pre_remove hook of the block
>> uclass, so that they are bound and unbound together with the probe and
>> remove of the block device. When only some devices are removed, like
>> before booting an OS, the partition devices don't match the remove
>> flags and are still active at this point, so remove them first.
> 
> I don't think this is true any more. Since commit 3632b5d63c8 ("dm:
> Remove children when parent is removed by flags"), when the parent
> matches the flags, device_remove() removes the children with
> DM_REMOVE_ACTIVE_ALL masked out, before uclass_pre_remove_device() is
> called. The partition driver is not vital, so by the time
> blk_pre_remove() runs the partition devices are always inactive.
> Please can you drop this sentence?
> 
>> [...]
>>
>>  drivers/block/blk-uclass.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
> 
>> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
>> @@ -841,9 +841,31 @@ static int blk_post_probe(struct udevice *dev)
>> +	/*
>> +	 * The partition devices are bound in blk_post_probe(), so unbind them
>> +	 * here. Otherwise the next probe adds a second set of them. They are
>> +	 * still active if the remove flags don't match their driver, so
>> +	 * remove them first.
>> +	 */
>> +	ret = device_chld_remove(dev, drv, DM_REMOVE_NORMAL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return device_chld_unbind(dev, drv);
> 
> For the same reason, the device_chld_remove() call does nothing, since
> device_remove() has already removed all the children by this point.
> You could just call device_chld_unbind() and trim the last sentence of
> the comment. If you want to keep the call as a safety net, please
> change the comment so it doesn't say the partitions can still be
> active here. If they ever were, device_unbind() would fail with
> -EINVAL rather than leave things in a bad state.

Thanks for pointing that out. I was forward porting this from an older
version and missed the upstream 3632b5d63c8. I addressed this in v2.

Best regards
Frieder

