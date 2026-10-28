Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SWEH5Vyd;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=q2ZS2TUH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EAA980E22;
	Wed, 28 Oct 2026 13:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxCRi_JZQr8L; Wed, 28 Oct 2026 13:36:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4409280E33
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793194586;
	b=cVLQ5tXdpkVfHufzJGJ7weS4jlhS4hpqvqyoJH91eso6TtJby6f5h/rvZlzdfeB5pjiS
	 edha4xSeJFinZw7gagBSwiLYuIUOZsE55Jw4q4Km/Y+2PyI+d9FUNvLLlh0DJnR7Z9QPk
	 T78S9armtSDyBwgO7hOcPMNqs2MdVtVXw8pPinadVHUHpGIAjwd8E0NBlEbxxP20FWpsm
	 QDTy1OF+xkhujMwqT/qPob4Y3aefA1iEzOsaz7BpoHgxZ6lWWNWdcYWs/wIltz+W/NZOn
	 EF0fh6/VNq1H6LKzgbbpu//5KvgL2QgUmNtT2O4nnYzAPrJo/IBkZ22mn44ooaWArhg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793194586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
	b=rm/F7Z5+5tuIzV2JHvag7/D987lU+Y18xuz3TwURnLkDmQ4GLrxZDUKY5TMaf9/kZjpC
	 ttZYEJx+fLnfBIrw9gvAsubzPbtjUFndCOIl/j2pO6WO4JKM1NNzU69fE6Q1ylV7LVDZ1
	 u4LlE3neEEVY0E8HhGYfZNAxosHObBhZoL1nk3QkhBES4uj8zQvwC8ngSApaOL01Zm0Mc
	 2bPeWp7QNSN34snmP+WimKEqruCurqcLOJ6WvhirZwiusI3zVvuuwjw7HzRB8QKabMvxC
	 Kr2BEpSYp+kERbMCjrMYZisToxgTMk5OOz1KyB7nUYom0ZmYERjspq7J9zHG/NBy2bg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793194586;
	bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SWEH5VydPLcXSK89fy9X6u+2DYCp2gueJmdLDiXVV3kUJulfIvDoP/803tpBAQQeb
	 xdmTb2tmSsM9lr4SJ/jhmBETsikpK/UWceNhTlUxAcFeC4O+NwDxFoZguXb1Q+SOv1
	 hI3G/y8rMz9mGKcit0IDnUXfXtSieAFjhUchSxIq/n+pSSmBa6ZmqbYeyLmJrOFL8v
	 uBpCNQuhwPN/Eyo7VLtWpJa7PGrvF8Em2mt+v1S3dAC+fYH0Pgg9cqab5mnAq4vEXy
	 6T7/TYM08PzCVSxSGh+K4dQBtEAyI83+L5Dyg3J+fU9k9zlos0CLzmEN1iNwWn7tSj
	 vuscy2xeU/VZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4409280E33;
	Wed, 28 Oct 2026 13:36:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C37C44D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C11C540567
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFxlkuUhB7w6 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:42:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54A8F40568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166130;
 b=euuiFa6rfIqad82FI4H1ygpu9lEi8rT8DDhZvM5ep8Rhe3kkcsCQfQJGmNYcUIPAvK5y
 qJSdGd0xRB2//dBKNTP72y4uqvZWd4Wjjil4Z5r760fQ3X+zf/OmiNFdPpfAbGFXE5W41
 MQvD9HYCl/p+9U4dmJUrXx3Ygzq8jbZPuQdju5xcC4FbKh6QYalfCvWzpWmCuozRAAP8a
 rDq2lpGJdaa+wv7I/CjZCm/xYr3Z2hmjoj1UZfk/sYTHBAxeGY6DeJ6vzmcki04YirHJ5
 9q1GrIvYf/1UaJ0wGCrtp3um4QY1U3kuEvY84PaovuXFmZ0bTcnyhh1rUd6735J/ghA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166130;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
 b=Xj+KvMw3bUvfEMLJyUOZ8AE31UYkPGW1v6Prsn6a/BTt1V6ZwoqOmbeQSet26Q8rNh0X
 gVOO4ixhqG5T6q79t8HGrcI3+zIj1mkUKU1BxCtiibDY/XZlajWo/fpVEecWKYogi+eMC
 EN1v5sGM8i+fuP/kSyGCepgyNpG+CvUJ59MsKwkWSSKCIvmZGe1xcqjDvbmqdP1z5GOBu
 elaADLuTKCv8j42k5dhiLot6bmABZ5xmzuVAVO791qukRF11wROMoUN5KRwh0f2f3K8cX
 aS++17Qv+MpshKNH0GpEGxZqZNw76bufzMwmQFmd9VFkbTcsiKiOXa6AMbzq3+Bw4hA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=q2ZS2TUH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=q2ZS2TUH
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54A8F40568
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLHRX2leewTMhXRz1UMZmLptyuybKpB5YKwoNvk3HU9CDUcMlUqLry/k3f7lYmZ7YXf+yhFtP0H8NQBHxLCtfOCTSdkTQDRlhhSqkOGyhqLsvfPg5hjWsek8nlOkWfE5YAYzcLnrgHGEknRpUjijSQgonczHiW56k/W7BeDJ6uY4AOSat00koglF+54OCQwdTZ1aazVl/BVkW8YikNHh6w4NgcJPOesU20TuMoukGpwSZ1uNpc1dcvpAG2HgLIOncLbIvPQNtHxpEB6r6yOHzmaVF3u5gnkmmOYWKN7mdsOSB1HoGITu3ewLhcj021ggpraRAIC0qRgDe8NPlKqs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
 b=Z/RofeOrdNhaVmle/0FbZ3oAPxyoIrpsFehA2/I64GLvPGFYMcyTouqSkXTUQoXti/IXcUT33G1jf5LKNg1ePpaI9e03ndF0eYteUjiOY8rIRdWAwMTjgJz403UO3kI9i5pvsV3nZH18Dhf4y0WcnhBSTygpSjVPmFlaFjbHiZEyioG+rV5BkpUXhT2jiX8jiu/gAvBKtWfu2VcqtxA51lLylAnDUze+Gsvaq1zc8sTGRL4q5p4shqpBGQBjcIb6wouGH+oIeFzFzOHZbLq6MedoYJRbVsMeYeOiGEhimLSmIQ+2vpomLJCeDPrYevO2Ik9+6fNdBtqAEHgY5l8+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2RwOL+HRZ0hMpcloOnnnJAKN2kxcJMULPMuvdUuCto=;
 b=q2ZS2TUHmW0oq0+/9Ebmk5uV0CePzEjmL0oWK38+0KRCljageWn1Bkw/LaAFBZXaOX3rexnkocnBJRdiBqg/b0U4rEKstf54+4CsGVVrFnOemWOpkm1fHe8wZs8HE2iA1Szl9DQrwBY8E81n5OmZ0Be7xk7Wi2sL/mH1hDzy40/BwcoLFfemjCt+cKdB1jnTorlUUl6yMdbdEwrqq5dSEKAwwIgW+yZvbMCpFgmsXkPTi2coMORDU7hEriff++R5Wyg3tcy4jlZVbEHQEy2+liY4+WoQj6jtMX0dquceizandNYvdVyKakCEEE6Q651xCO4LyQpNHGgqiIJDzfzhNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB7950.apcprd02.prod.outlook.com (2603:1096:405:b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:42:04 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:42:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 QEMU <qemu-devel@nongnu.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 2/2] qemu: arm: sbsa: Rename sbsa defconfig to arm64
Date: Wed, 28 Oct 2026 13:41:39 +0800
Message-ID: <20261028054141.2933271-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028054141.2933271-1-bin.meng@processmission.com>
References: <20261028054141.2933271-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cc7732a-58e0-4fc0-5477-08df34b63167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|261022075727099003|261009223027099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261021121427099003|10067099003|261021123027099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: GiX3YXbx1VHHWHr7soZlhCiiiyP/jsbNx4ZaWbR3t4sajm8PSON7Lpxw1QPaAbHNgmLlcWz8OjbIUTquXWDw230/6EXljHQYhVW5hNZZ4b1NXqhpAXv25CkwgAIofNAYcIQQUxrFlXTwgneY0rYZE8wGKl8hBva9ulfe6rpqBhz5z9zq4hf5c8iGZbYYcvvs/vBY54w6Kv01OO2mlkokiqkwLJSV5nj0ibL7lJ+ErRhXujSWMji0mV5qIvDoGm3FWvbcYhGnAXz6rCt9BKSZq0X7iindFTbwfZW3MJKs9ccWvoDkeZyIGIydn1C7f6RdBgKCyxfPsrPf5mT/nU9uF35OuU3QIXYJ6Qmux03ninyShcGOUfaAL1jnHzLmvnTon6jxusYHgVL1kGkarjoalakw0/u2T3lj72YC0HJywtf4tjdE9MvPmL3xxQP3CdwkZjBElwhvk58K9AsjdjeppASmDWKI2+ROB/fzEPWJYmKA4NDgAGbSrw3eEKXyZWQ8+lw7xW8wJPKY+zO4Q0n1GVGU5CehIlc9wcQpESRR/kfz2es4suMj5JEyDJo/VNq1nMSxX2ktMdHEUZsm0g1PmIOa+IU1ZKMzAqoKXGB9D5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(261022075727099003)(261009223027099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(22082099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EokDJajVRZt0vQEbR6LGcgr+il7bX7Fdi/hGKxZDVcI6yqq0h9X5KOBkrfVb?=
 =?us-ascii?Q?Ba1uS5YFw2pk8DxYp54PsQYVkYRmtKxxQCh2vcKFewLL6ElZQ8eoJdsd2PlF?=
 =?us-ascii?Q?tAu0H/pS4+uEuldapC8xtHK7W1nmPSJaxHiR8xGJLugum/MrUjH4BgyZXyFP?=
 =?us-ascii?Q?BEQOvRzVhZoD2xZoJ5OaJp7T5YXfoDYdxquNvePrudcCZipEbrMowLQHqO5Q?=
 =?us-ascii?Q?HuT4Iobb/2HD2BTGRLs+Zz6GBm69Rvhs6M25p222YyHPB3e2e902btzLtXwv?=
 =?us-ascii?Q?yT1lQM8GD9wvnwPbMkCIZoQE+t7CI0eAT0JwDZLtdD20UUe1ioZT96UF+qzh?=
 =?us-ascii?Q?pmqm01E7sE3b54qFqcafKfAb1wc2zVveXsOZgXg28JuGB4zx6MzGczojitSG?=
 =?us-ascii?Q?JB0DPExVzYChzuxfXqQH4fFcLsPSN4Pqd52oTxM+tD+NvEc0LjDkN8dB2lJ0?=
 =?us-ascii?Q?PYLdfZsyuDov3iYikqvWrN349ZXvbOdeEVkoqNkZ1OH6DuyyE7ZPZadfVjQ9?=
 =?us-ascii?Q?2TkgZZYQpuztevpyVrZAyIp0yTnMm8nG4pq1y0Falib1+GARXS/nvhYTheXx?=
 =?us-ascii?Q?bDEhGYTF3pFeXFLlgL1ElPFqEBHnqSpic6ecOQ0/nV0KSNlO9r1YPuz79RIv?=
 =?us-ascii?Q?BElX9o2nOF1+gFVLOutBDXV+f16Otfp7KYtcNGJiI91cmkpr1kGLx+gx1rYk?=
 =?us-ascii?Q?IN+ayZzgrbSnA1a24eNpRGx35tN92c5SXnFL+vNkqJvMLoF/gBx54tnhAadm?=
 =?us-ascii?Q?xmzNFNuF/Hwa3cjyAlyibiO4IalMrK0ceoNV/1BZ5Ok2Spc2lmMLbEPPmEAw?=
 =?us-ascii?Q?GnOYWgVMPmgO5AQs1Ai0gRxgBJa1tqVgDS0EbIinNuiqN2mL8J8TZoSRVIZ+?=
 =?us-ascii?Q?ND5wmiqxtQIpo4//Ou4SB8kNtMg4Gmw5iMxDkk6UwmlnGRSeM5f7Z2M2d2UZ?=
 =?us-ascii?Q?5n1kt5lKWkkyChTlJrfCdaAvKLaPE6qWWCQ6WP/V/+pbDd15WMku95dxJH2t?=
 =?us-ascii?Q?HGUlJqubB1K/qOOIzIwReO7iKN0/bVZJ3Va9RMcgmpmx/0xAOOZhWIUDqslH?=
 =?us-ascii?Q?pR0CjCuxoI/KqWbt++MyQt9oC4kci6yl1txCS3xuf3aF9WR3KPkiE4BzI1Bj?=
 =?us-ascii?Q?59JxwSt3jezSAT9J58JwLLzhJkqbbedtti0mNuOUjARsihS7X9kx1/jjX1Pz?=
 =?us-ascii?Q?uivSly14kwbIAzO5yvB8Ldz2VdBNAPeFdVeETn2O9n8bn19yQs2JFZa+Z8MG?=
 =?us-ascii?Q?oY4w2UJ1kkw7be68fZ94pdGZmkjOBQWeY9NDR2Gx0/xZidWWN81LJuYGfltV?=
 =?us-ascii?Q?BhNwo/e52wphbK3F+yHVbuRNLh/dQZ4qxpSKWhsFGWPWjkgdOkMZSMGzVhpW?=
 =?us-ascii?Q?8u3W6SPzc6ml23amsofN3oqozaa9XML0unHS50MAvPEnwPSs/oXqZt2VJIdv?=
 =?us-ascii?Q?nYtdVgypx5XGfi8K0GFCaC7e6kWPX+1ccHhHlLIXiP6C9PqEHOv2ERQyOaVr?=
 =?us-ascii?Q?sjG0cGMd69dqBt5vp35j9q0v61cr+4UFoDrvVDb0NIXF7n9CjoKwwnCj5D4r?=
 =?us-ascii?Q?woC7awlryfL8fuFg4A0YPOEa0irceP2OlLug1e9XlsBLWspy0LotsgG3+Jjw?=
 =?us-ascii?Q?rxYPYNyKgY+VZLVfg35jh24S83dv6fAdgl3KuVHajkHWNynAIBxpIY6Utoc4?=
 =?us-ascii?Q?XG/nSwmdprpInXMQTsG9UIzR1/lFaOwdczWjBa8PmKh/1m8JoUvUyI2JQ2k+?=
 =?us-ascii?Q?tiHS7pcaE8LEFgYPR0YOrsdyF4iONDU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc7732a-58e0-4fc0-5477-08df34b63167
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 05:42:02.9017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D10HUnyFjX1l+9gFD35Kdr7YnRT47pjBAE46Fn5Vcq/8JtvCHPL7BcpehtYtKavHwe2xQQymUkgbwSnz0RSKq6B1UQBbG5rbP9Vt4x/Ihv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7950
X-Mailman-Approved-At: Wed, 28 Oct 2026 13:36:21 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

The QEMU ARM SBSA virtual platform is 64-bit, so rename its defconfig
to include 'arm64' for clarity.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---
CI requires the matching u-boot-test-hooks renames from series 530221:
https://patchwork.ozlabs.org/project/uboot/list/?series=530221

The CI runner image must also be rebuilt from this series so that TF-A
is available in /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee.

Changes in v3:
- Rebase on current mainline
- Update the SBSA build instructions

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                                        | 6 +++---
 .gitlab-ci.yml                                              | 6 +++---
 board/emulation/qemu-arm/MAINTAINERS                        | 2 +-
 .../{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig}  | 0
 doc/board/emulation/qemu-sbsa.rst                           | 2 +-
 doc/develop/driver-model/virtio.rst                         | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)
 rename configs/{qemu-arm-sbsa_defconfig => qemu-arm64-sbsa_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 071fcae104f..9a8743e9ae7 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -267,7 +267,7 @@ stages:
               wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
               export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
           fi
-          if [[ "\${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+          if [[ "\${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
               wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
               wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
               export BINMAN_INDIRS=/tmp
@@ -488,8 +488,8 @@ stages:
           TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu-arm_sbsa_ref:
-          TEST_PY_BD: "qemu-arm-sbsa"
+        qemu-arm64-sbsa_ref:
+          TEST_PY_BD: "qemu-arm64-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
           TEST_PY_BD: "M5208EVBE"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 905523e3e27..683f92fc9f5 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -51,7 +51,7 @@ stages:
         wget -O - https://github.com/riscv-software-src/opensbi/releases/download/v1.3.1/opensbi-1.3.1-rv-bin.tar.xz | tar -C /tmp -xJ;
         export OPENSBI=/tmp/opensbi-1.3.1-rv-bin/share/opensbi/lp64/generic/firmware/fw_dynamic.bin;
       fi
-    - if [[ "${TEST_PY_BD}" == "qemu-arm-sbsa" ]]; then
+    - if [[ "${TEST_PY_BD}" == "qemu-arm64-sbsa" ]]; then
         wget -O /tmp/bl1.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/bl1.bin;
         wget -O /tmp/fip.bin https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/latest/tf-a/fip.bin;
         export BINMAN_INDIRS=/tmp;
@@ -412,9 +412,9 @@ qemu-arm64_tfa_fw_handoff test.py:
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu-arm_sbsa test.py:
+qemu-arm64-sbsa test.py:
   variables:
-    TEST_PY_BD: "qemu-arm-sbsa"
+    TEST_PY_BD: "qemu-arm64-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index b2b1fce75cf..fea9e97f868 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
 F:	configs/qemu-arm*
-F:	configs/qemu-arm-sbsa_defconfig
+F:	configs/qemu-arm64-sbsa_defconfig
diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm64-sbsa_defconfig
similarity index 100%
rename from configs/qemu-arm-sbsa_defconfig
rename to configs/qemu-arm64-sbsa_defconfig
diff --git a/doc/board/emulation/qemu-sbsa.rst b/doc/board/emulation/qemu-sbsa.rst
index fe1dc3249e4..ab98dcfb1b0 100644
--- a/doc/board/emulation/qemu-sbsa.rst
+++ b/doc/board/emulation/qemu-sbsa.rst
@@ -50,7 +50,7 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 .. code-block:: bash
 
-    make qemu-arm-sbsa_defconfig
+    make qemu-arm64-sbsa_defconfig
     make
 
 Running U-Boot
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 90a12fb3003..22544f0ecc1 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -34,7 +34,7 @@ The following QEMU targets are supported.
 
   - qemu-arm_defconfig
   - qemu-arm64_defconfig
-  - qemu-arm-sbsa_defconfig
+  - qemu-arm64-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
   - qemu-x86_defconfig
---
base-commit: c267fa81d42b5a5bd1055d3858f74496faa6082f
branch: qemu-arm

-- 
2.53.0

