Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD9606A33F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j+LjIvco;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=QfPtGeja
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4A5B607B8;
	Tue, 27 Oct 2026 15:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPrwfH5puhEb; Tue, 27 Oct 2026 15:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00311607A5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793113479;
	b=hTYh+bjpFPtAtKLd8oTkFoUs2qZ4By9ge1ayo9l9FNcgV5Tmp+bfy5qavPa9c0UnaLWB
	 zhS9JacEp99mD5Nqdvbt23lt8RCVBKojrylJVM7+qM2eYvNZhAnp2PXwOTxZRzm5mKxxr
	 myi73SjijGzIeble+XVj9mnLV3m5zcY53/37v1guDzLpMUeJWeWumqaxtOmKOJJbZoyLl
	 iZ/hy6LYgqM6dYqQw07b43K9zIGpCiuL9maNKQ6XyqsXpupCsBY9mpznj7YlTeuRcVKIP
	 cOUNHPcHgr2pSYK5NOhMiZHqo0oW4wBrRQ9d3+fQTqBlN/++BoLgWS0u67uWJnJtUoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793113479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
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
	bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
	b=QriY1UigM4FAuVodnxlE11Y0ZbmuoKwkXF+TUIDP3Y1kNKyLPUxNhOU4RqTOh4x4aMPy
	 NNOO93GLhBsu26kP4X3mRog5rVwGmN1tXSp4pGOUbxmIRWZT6g3gWDvtDL3nw9mI8axnr
	 OrhCVzjO67aN5cGGxKEbOwmcDAgiT6xMBjHR2AmA+EE7utG7LbpnnCHIQQDrae2JpXH4O
	 ceyxxUR8YQjlXyWSU2AgBrnPGfLi6DnUpd5E4rCxKKaJ02dMtoBRhVQI6Hxe7SPCs5p17
	 aJg4ntxcfBv4en5AXhOQGuluhSFTc7Iv6VQHBQl3XGrMLZ3vgAmk5MS5TQgIecGLfEQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793113479;
	bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+LjIvcogXHmmuQ18o4Q9y/2rZvjxYAbdmPveI0F1zMN3gWNgV8qLUxQhXiVWvG2+
	 B3/SH7vg2HGL9O/mLYdAuxAVc20FQk3x/0cLP6J2zOIUp6RTLN66oAVJh6gzLCKFcz
	 67yHzztHJwCY9bTmJ1MLvjqsoMqc25D5aTOdQhiRPZoNsiPu6lWo3PFj/OQ80ftVmG
	 LIHY3kHwdQPa/fsdQvwGNFVgpxUSV6QtsnSv65P59StH6IfFFi1xyGYcvOVAWZBEbN
	 Y1Dgvmk0b2DsGmqJtCJhFH1h6+rhkLhSEMCxNzB7AZxN37mkX8r6YQOAAeWt8HNN9f
	 TpU+SYU5mp47Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00311607A5;
	Tue, 27 Oct 2026 15:04:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B44B272
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 998A880A86
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3iJv4fi2htx7 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 15:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D935D80A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793113476;
 b=H/v3TaYZQO6gFhwIhvO+GwLign7fUMQh5dIse9F4GF4KXLV9bl945mw4H+PxG0oW85hE
 tQPt5yBbInTIEsMtCSGszB6OlgEtJx5DRcG1vPgKmfiTEqmnt/k0iQ7VuwQrBcYMHP/HS
 Gsq2Wg5WFjMy92pPhwRbrHZKuyMvKzBPK3OZ3CC1yXCtGiNs/6Ioqv9EthoS8OpJ79Dy9
 dAXbYqifxssdsvMM8JZA7REeukk4K2ec6QicFIGjHPDIczqYLe3fwKJ3o17gz3+zxEAe8
 IDpaDvVDpHJC6gEugS9qaay783zZkdAdq4t89cHrInVLAhqkg1kKVYFiotO04v8Tmxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793113476;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
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
 bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
 b=jZp9Zpw7DzKh7nqXsGyB5Gi5tHh1Qf8WRrYVf2xs5jhqUqFhxCgu87hFV2UODHQ1v9mw
 WcKbIEJ4abSndHoF59cw/OS88yg6kX8EX5KWtesiIqHhBBxbersO7FX9TplxyEHkWqWUq
 wbYaCKOTfV7O00HfmpoEzjEvi3c6rWc6uG6GoVGDBjJxlhNyK+CYx/VQI2V1n6puLz3/b
 6JUhyOHoy8rfVGHkC9rfJNeHACSjv+EW7TJ5cRVGJ1w0CdLgkBtxNm/0tXLyLuRjEZejh
 ha5mfvlFECUZlywE9svnJdo4LkOmgEDMKKTM41nDs/L8YmTlQiQsy0nyHmy66nenuqg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QfPtGeja; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QfPtGeja
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D935D80A87
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 15:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoijYACEZtudPJpo3FCNWcwz3Nudlq/V9XqFZnN8DGp5XPJ8nrSmD6f3Satv6soq2ggP4fvaYjMywwzRqz54elSWEfj73O2QdFm8w79EWdAzt7rend71iKEM9Ihfh90+9A/PfKBCjKZHI0fOZL7lUmBy14xsGh7DNkeXSOzyBmMlVDsegpnBEZlO1JixeoAZmMkr0n7enbKmXRSoeZtgpWuhtKo2+8aDFkwCfK3l1NaFpCaocb+9lFUlyQ37tRaVBgAAQvGRyTsJ0bbpBBf+hiFraqc1ZtD0t0Y8VqtRy9Xg0qEaUmyIXufpVh5BqpH8deJYTqCGe+pValLaWESrdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
 b=rSdZ6A+v6yoq6X/lwhEOO6B+7V5WAikIQ8ZQ/43gCJPAIlOIzR/89CDZVaepld+uL9WtZHVHafjxkLR0NtmlR+nCzmDsOh02RtRfl60VQeBaixlSSUz+ZiZd9ejE07DlF34qT+HpHVwYWYsNp07jiJmlDiIpIyMEjgAFzGpd8WDYFf/gSrk9OzD+MhuDJSNwiiU1EgDWzoedD4y9wM7G3KbGvDeZOhmJxfxJbj2s5O1dP7KN0hX0ev2lMM+Zi634LIc26FJ/Oj3x5QGs0bNCtFydqn/UHIHlzh2i8F0yO3noyD3/Vgwzu6PvEmmCQSucBJEFs/B1Azdcb6CDjdPT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSfbXMum/hL3rjNUxklomLNu7agipoMTSSQqjArinM8=;
 b=QfPtGejaj1ZahswQ6wPuYNBZYo0o+Y+ONOm4OpuVoOl+z+5ROjsNK6S+yJMD7sGhRtBETKCBwD4UpYfMGhvkns78EbMdkeuMAFDbpg+zFb8HY+OgGwlqLAneauZWWdlLZrm5y8SMoUOFCoUk6kG+iWEq9eNMQO4xZe7J35yjbeU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI1PR04MB6782.eurprd04.prod.outlook.com (2603:10a6:803:139::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:04:28 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:04:27 +0000
Message-ID: <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
Date: Tue, 27 Oct 2026 16:04:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
 <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Content-Language: en-US
In-Reply-To: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0076.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI1PR04MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: c8609c02-52f9-41fd-b4a8-08df343b986e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hDM2seZi7Mj8R4c7n/GnqiW1ycmGcP3BhU2sh/nMcVxVnkRz6xUdksFXUORnmR4lmRAylq/yDd3HfEzcVJwAxCqRueK1kifdTJ6YAwnojXSWaBFCBmb79YWI+aZ6KF+aR8exGWQ0N6uUg2f5f8wAasO6WNnmQ0KJlRDuqW3GeKJVDxuyDGbQ4olK2eFkmPm0teWTbBpsQdg2NcZI5N/Nf5bXEjR86CHMfK0F7cdmiMpffXgF2r2cp5dM6/p3obiXG/Z3Jm+jWtRv0HcXPBtf+6Viu+yE/ZmIzlcoyAqOA3wvw51ltDpB0mx55A41rsPDM/PyQiJlGsM22CZAm5BprUEj7/FSzI0epxIJIXuvkGtxiuEhvXlzVnbENs5qX2A/lmwKTJ6ovarb1lvBJLlKNLqZk3lVDwC0Yvwlb0ELe5qHgOdM/bkydcTbQy/b/ftu2EagOskGm0skL3Uw/5smAwXCGKTTFrIIi5g8qpoUBb3kbouZYVm9mrL3o6jhi18WS/XSZzJXYr9gG7mf8G1Vfl64CbLUIpbtmSnKdfvmb/Lip7m1uTEwdVbIWKKv3xklkSpWuuvsTf5eDm1T1yVbM6sJZGsUzfA9di/BmbMcf3MTYJLpFa6WdrHT6kpsuniL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU1kcGxLQXJuVzNHMzFtUGJsRnd1L016Zit3aHZLdjhxNzZzL1Z3eitrNUp5?=
 =?utf-8?B?elQxc0cxVGpnR3RkU1NldEZoaGxuZVBKZG0yRm9nVlh4SVg2djI1TDJUTDBm?=
 =?utf-8?B?VlBqNWhyTjg1Y2p4UjVwR3E4YjlNd1JMSFUxczA5YnNBUVVaSWt2QytZRFE0?=
 =?utf-8?B?ZTJWQ3NpYUthMTExL2hnTlVGTjkxSmRzVGR6WkhIbVQ3RzJ6VzBKeWQ2RCtZ?=
 =?utf-8?B?eko0cW9BWk5tQUZzQk1rMWFGbnROQkhLeVZBMy9MQXB0dHVJYm9NL2F1RGhj?=
 =?utf-8?B?ZGEyaDk0K3d4MHY0elA4VVFoYklLQVRUYk5tUXA1SUVJOEUzV1ZBMDJUOW5k?=
 =?utf-8?B?UE9XY1ozR1NhV1dzVkU5QVQ2NERiOVZ5RC9lSGJoRjg3ckhnRzZZRjV2c0tK?=
 =?utf-8?B?elRRSU5qNjJxTUhhNVhra1NqaE4wVlc4OHBGTWtGZmo4bm0xVVVtM093VmVh?=
 =?utf-8?B?SlRDaTh1UWdnckxRS1VoNldMeHgySXNMRjJ5alVvNzFxUHBiK3RIMHVxVHhX?=
 =?utf-8?B?bVROanRMTWdqdFhObTl5Qm9LZUVoRExTcUtIVURjUkNsT3pZd2NtL0IwWkpu?=
 =?utf-8?B?MEg3Qzg3aFRGRE1RRW42U29iNkcweEllZGxEQzIzUHR1YmhBQXFtUUoyTjNx?=
 =?utf-8?B?ZTNscjVpTWtySTlFNFZhRCtFbDdnSGNsWnZ2Y0tVc205Y0hBNkxienluQ1Iw?=
 =?utf-8?B?TFA1V3k2Y1YyZGVsOGNsQktWTGpteDNaeXc3bTAvdnJGZzU5dGZ2cnRNU3pl?=
 =?utf-8?B?ZWZzRCtjK2ExWDZJZEFRcWVCQXdLK0YvV25MSlV3eEF4dzVWcldwOWtYbTB2?=
 =?utf-8?B?eThSN3dvSXhvV01sdFhmWEpha1pZSkhCN1Q3ZlNDdzV1ZUdtekxwUXMxblZy?=
 =?utf-8?B?cXlnNE84QVIyMi9rTjI2K3Fnc09rdzdnNElIWkhDcnB4K08zZnYrWWxjWlhl?=
 =?utf-8?B?NXpmWHo4NFVTeVBPUm54VTJBK3E2UG1nL1ZtSmtmNkl6QXNRcTNuSHNVdTJk?=
 =?utf-8?B?U21ZeVhGdENMM29tWGFjamE3NVhQRXJXcDNsTk9LaktnY1BueVVjNW9JMWtF?=
 =?utf-8?B?V2VkZHpKMWJDdi9mMC9yR25qWXczQzVOZ0E4WDNRL0xMakZhSTlWVEUzMXNx?=
 =?utf-8?B?QzIzSG51RklqVlJFdVFOK05HMzJGSmE4L3JhR01EU0ZyWTRyL3lybUFmblg0?=
 =?utf-8?B?K3hpNGZGd0h1SGZvYWU2SnA0UWU1UXdkNHVzVFdUZXd5SmJqVFBTOFFRaE90?=
 =?utf-8?B?c3hsdFBHSFVocnpYUXdlSTVWZXFReU1rekdOYmc2VVhxb3dLZ1ArVWJTWSty?=
 =?utf-8?B?a2x1U004QStCamZlWkFVTVUrM1d2d3VpOTlRSkk5SndQeUZXNnlVbE9YbVdv?=
 =?utf-8?B?S0hoeGhIQ3QwWHk4Y0NuVjhVK1d1amlVcE5SSjBsQzQ1ZWZSWEJwTkpPZ0po?=
 =?utf-8?B?NEVOR3R1ZEE3cTY5MXh4dGRncTg4ZFVXUHcyYjBZR0NMVXlrdmhzZjRnY0tY?=
 =?utf-8?B?cVRUREtrNVR3NDU0SHVYNEZ2MTZaWGExV2JBcFgvLzFkR2hSdERVaHF4ekZS?=
 =?utf-8?B?UGdlUjIxZmJ1UHZNRGwrMkZGemdnUEF4YnR5a1dVYUJqZEliNDdNUWRJbnlI?=
 =?utf-8?B?bXp3YTFkOGUzVEhKSFEwMHFnb1VJd3RRTlhRMThQYjBkNmorUkZHYVMxcGRs?=
 =?utf-8?B?TWpkamIyTjJlTGtMRFROdG1McHd0azNFNTdmeUtsT1MzTXBiV1M1Ykkxcm5v?=
 =?utf-8?B?alFCMjAvWTFWWW1wcWJSRUs2QTFRdmVmNEJaUXJqYXR0bVh6Y25PeWpNcjJD?=
 =?utf-8?B?bEswdHZzaGpRb0RSaSs3d0c0T0RRTU9EcWtsYmwxSHNkN0xMeEhEYTU3akVy?=
 =?utf-8?B?cWtKOTl1dDdKdFhGTjV5a1Z4OTJpZVpUek1OYy9UbXI1T0NMUGp6Wi90cVha?=
 =?utf-8?B?UC91cXl3dzlVMTNlekI2Rkx6eHgvL2ZEbytkeFdNMEl4OHpjRXJ6YnlBWlN1?=
 =?utf-8?B?RnhvRGh0MVVRMWtTMHFhSnovc0JpYnk5WGJsRXo2VTgzWnRYTkFCZ1JKQW5v?=
 =?utf-8?B?RWxJWkkwd3N2OEdFRFlGREdsMGIyQ0RCNFNsSjduMEthMVJBNGtDU3UrOHBx?=
 =?utf-8?B?Zm9LU1JhTU9wci9DbFU4R3JEWDI4VVZjekFtWW1UbkFPYzU3VjJWeXl6ZTNj?=
 =?utf-8?B?ZWRSVVNCOWgyNkxySEFFWk1nUE81M0QyeXJQUWhLYW5KbVdQTmRuWXc5aTJK?=
 =?utf-8?B?SHdMbUEwTG1WNVEvM1NsTDFRZzQ5aXpPMWtSQ09udXhqV3VXY0dBUGQvN2JK?=
 =?utf-8?B?QzVpenJGV3hYbUR6eUZKOTFDeTNOZWxCWithS253c0h0ekVNZld0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8609c02-52f9-41fd-b4a8-08df343b986e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:04:27.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Di3dtVvWGUMk66r0SL9ELU4NKYpO9cF9aibIwlwmFcdcaIYnhas32cnttuwjhknzePcqGXc8KsHL4+yHC3yeFBQu9Et0jdAz3/BPQGZTow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6782
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shigeaki Asai,

On 10/16/26 3:05 PM, Quentin Schulz wrote:
> Hi Shigeaki Asai,
> 
> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
>> LDO_REG9 indexes past the end of the table. Its voltage reads back as
>> garbage and it cannot be enabled or set.
>>
>> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
>> registers (bit 5), and its voltage selector lives in
>> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
>>
>> Add the table entry and handle LDO9 in the enable and suspend enable
>> helpers.
>>
>> This patch was written with the help of Claude (claude-opus-5-5).
>>
>> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>

The patch never made it to the mailing list, c.f. 
https://lore.kernel.org/u-boot/ or 
https://lists.u-boot-project.org/pipermail/u-boot/2026-October/thread.html, 
can you please fix the consistency issue and send a v2 and make sure it 
hits the mailing list? This is fixing a real issue, even though you 
don't have a need for it anymore, so I would like to merge this but I 
cannot if it's not on the mailing list.

Thank you in advance!
Cheers,
Quentin

>> ---
>>   drivers/power/regulator/rk8xx.c | 46 ++++++++++++++++++++++++++-------
>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/ 
>> regulator/rk8xx.c
>> index 88453bb7bdb..cb402c96ec8 100644
>> --- a/drivers/power/regulator/rk8xx.c
>> +++ b/drivers/power/regulator/rk8xx.c
>> @@ -60,6 +60,8 @@
>>   #define RK818_BUCK4_VSEL_MASK        0x1f
>>   #define RK818_LDO_VSEL_MASK        0x1f
>>   #define RK818_LDO3_ON_VSEL_MASK    0xf
>> +/* LDO9 is switched from REG_DCDC_EN and REG_SLEEP_SET_OFF1 */
>> +#define RK818_LDO9_EN_MASK        BIT(5)
>>   #define RK818_BOOST_ON_VSEL_MASK    0xe0
>>   #define RK818_USB_ILIM_SEL_MASK        0x0f
>>   #define RK818_USB_CHG_SD_VSEL_MASK    0x70
>> @@ -297,6 +299,8 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
>>       {  800000, 100000, REG_LDO6_ON_VSEL, REG_LDO6_SLP_VSEL, NA, 
>> RK818_LDO_VSEL_MASK, },
>>       {  800000, 100000, REG_LDO7_ON_VSEL, REG_LDO7_SLP_VSEL, NA, 
>> RK818_LDO_VSEL_MASK, },
>>       { 1800000, 100000, REG_LDO8_ON_VSEL, REG_LDO8_SLP_VSEL, NA, 
>> RK818_LDO_VSEL_MASK, },
>> +    { 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, 
>> REG_BOOST_LDO9_SLP_VSEL, NA,
>> +      RK818_LDO_VSEL_MASK, },
> 
> Please stay consistent with the rest of the file where we have 
> everything on the same line.
> 
