Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BEC624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5779A80BCF;
	Tue,  1 Sep 2026 13:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OIugNT7zvLmv; Tue,  1 Sep 2026 13:18:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788268691;
	bh=plf3XvgBrtAMl6lrHApAM/Mhp66CpdBfjysFvSe8I8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/1VXvXuMZs0gs7KUrL+q/K+aoaKr829AV6uCePEv6P5WSWZeYU69tWfMTY02+/8+
	 8qpQvazYqghlMtCg+fJ2s+ICVcPOHefIQESZz+LJdeJGqE5BmuNt0PcKCu3qtBvlei
	 q63hubP3OhFEZ1IenZGSnyKpTVtNpT7SNyO8UKEuiK+Je5zPblsiYiXEZ/nvWNwY+c
	 rbxYVeE3nMF7G3SRshIRUCzwdhNPOeII0Xiz3A57eOLmKeettSx5OgUDgpO8g27oZN
	 n5omOSPXEvNpBBDPGcPDMdb3YHVb3j3vYagMtkdNUjU2Vgsf2XKb0R8Ic0Fc1ew9DO
	 0veL2X7iqUcLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E67B680BE5;
	Tue,  1 Sep 2026 13:18:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC2B9105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C677C4046C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6lK_rprMlsy for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:42:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=B2ttNUrq; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=B2ttNUrq
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A11E840448
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:42:18 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qJZyoo+KzU5F+ypZzs3WTZK1ZjLhpCychABCbH9f2w2f8PDFbMSmuiaYUMbe0kYXMyD6FComzz5dQh1JhnSwwXPun5R8wPvCv163OxlLHDIJdqb+wF9xSBcfnhhqHlgP4KqdyBqkZ+TLZOe2lpXyHZlq3EooLPueSEEeI/scB5neuI8XuYZlakbeAWsUpEUMzspnLPIiMqLN2lnHXiJ/PtQzmRzLwbuWx3fPUehUNi4N3LRoJGiZ2G0fjRYnrbsjc771/jKQOyP1KVIKJ4O+xz7ujnjyU56ix+ZjfsiZ0aUl4iyU1jwk1F2v+fz7UeX1k9cGnG/8epCplTlT3R7CVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plf3XvgBrtAMl6lrHApAM/Mhp66CpdBfjysFvSe8I8o=;
 b=p0LJ8hGcmg6oHXb52758fwF5DJF30FDxHKPnpKPrSGCXkz0N9zqpgH6oR8FhZUWUQj30TA1zp4VcvrhwvJ2Bp+jBdtyd1Gi4AlTgEbEjX6Jt13cZHl2C1ItDfuJHS2VoM4ziU4dKk8QFMvCnM7E10mREb0yZ+tRMHlFXfJCuJw9Z8BVfMkPij4VvWT89llIvhrK3p4QR0zHPBFtE5eeY1kk9iWraUUzMNtWs8q6DSZBInja/UM9Azv9gAzROjCFfImLzI7mhbWuqQm4bVXi2wx9y1ZnyySBf3Wm4rldZziD2r9tDa0uws3y0ZRVCDFci5wBGKSvP883riFDKh/D7OA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plf3XvgBrtAMl6lrHApAM/Mhp66CpdBfjysFvSe8I8o=;
 b=B2ttNUrqs9eV8yt/Odp309bflbBNLZlGGYQzkseNWOgYSub8MtQwtuzLkRSGJv7SHl4wPj6ZokXxbehjtSFXLgGQbvTPMTO1TeuTWmeyrbzORm+qO0eg8ALJQUqSqM3sxYgTjhnVlt61Bp7UHOYcua6Mdprrrvb68yX1U2JxXR8=
Received: from PAZP264CA0217.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::26)
 by AM8PR08MB5617.eurprd08.prod.outlook.com (2603:10a6:20b:1dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 09:42:11 +0000
Received: from MI3PEPF00008558.eurprd05.prod.outlook.com
 (2603:10a6:102:237:cafe::7f) by PAZP264CA0217.outlook.office365.com
 (2603:10a6:102:237::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008558.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Tue, 1 Sep 2026 09:42:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ+OZU6xSCkjGJ2iWhfmaV9RjBtsJQokDQLcg0lz48JscKhmNj0OpvVQFolraK1hOuRXe12Yuz1mdr/PkVz9firUFQi1xi1vnNlA5w9RGDQt+6P1eVX7kt+XDgXgiuqVqN8iQQFzhXyMPtZiI+UBcmZAgpXYim0iTIMsQLNVqxfvBU/BofeVEh0wpLuXsmBW0wsEckuq2VcWU2sfFxml7+Y/J8jWHD5CNP8hUih9xEHudtUB6z7Y706TdQ/rurBIESKE4MRL4jCPxkOg/qrgr11JI3ehO6Ov5mhfzc6yU5SdAukXdDja3WekuV36ONkJJxbmwrWbsDH9x4CyNrZxLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plf3XvgBrtAMl6lrHApAM/Mhp66CpdBfjysFvSe8I8o=;
 b=PwYOLq35yM4phHnjBV8vJbozPSJu3pMUWHbusiSKRGkHwAyapUhdhkB+W4Sx8Ilqja1Mpwht8l+DqDleChx7F8AeJ36yUw1ppEwyqqc/6q+qWg1dqftfZJi3XWiGpCywYqu7vFDsV4fPR9tkIvzMshRHg2VzIawH2zEWLaHwGDg9n6mKlBMKKVzsafEICnd2jlV+H2Bp6R14VpR/zZ0AQ6br8DSJVdVyoL8suf3E/6jIDNiSJva9iNIVPaLPhyz321sWlS3GC4uIH/YfyoxFd+N28DbEGbnraIlPu80S793yG+/Id0i+utl7STuW1OE0uij4dtSTz0eiWXZ/x5j4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plf3XvgBrtAMl6lrHApAM/Mhp66CpdBfjysFvSe8I8o=;
 b=B2ttNUrqs9eV8yt/Odp309bflbBNLZlGGYQzkseNWOgYSub8MtQwtuzLkRSGJv7SHl4wPj6ZokXxbehjtSFXLgGQbvTPMTO1TeuTWmeyrbzORm+qO0eg8ALJQUqSqM3sxYgTjhnVlt61Bp7UHOYcua6Mdprrrvb68yX1U2JxXR8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by AS1PR08MB7537.eurprd08.prod.outlook.com (2603:10a6:20b:481::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 09:41:33 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 09:41:33 +0000
Message-ID: <4dadf23a-91fe-423b-9e73-e31d7da5c9e1@arm.com>
Date: Tue, 1 Sep 2026 10:41:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/22] arm64: FF-A runtime transport for EFI variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 u-boot@lists.u-boot-project.org
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
 <CAC_iWjL48ub3bD-3iKbCrKnZ_Oc3zQALDZrg14arMwq2pyvf+w@mail.gmail.com>
 <CALeDE9NCJhrX3kNMhWD_UYZ+Sh0=0A_xSYyrfwTSW6=H-HHYVg@mail.gmail.com>
 <CAC_iWj+z1G5bALcGoZob_RbuEvXsqvG0vsxgyz47ZMJnT4kd7Q@mail.gmail.com>
 <b4f8d148-ae3d-43e9-88b7-1362608985d3@arm.com>
 <CAC_iWj+35n7J2D6EvHr7LZB7L1t2+kNmxY7mBP+w7xgr6=A2jQ@mail.gmail.com>
Content-Language: en-US
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWj+35n7J2D6EvHr7LZB7L1t2+kNmxY7mBP+w7xgr6=A2jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::11) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|AS1PR08MB7537:EE_|MI3PEPF00008558:EE_|AM8PR08MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca237d0-480a-4c6d-1a77-08df080d4c0a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|3023799007|56012099006|4143699003|5023799004|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: k1KWM40+u5Ycvug8JsTg/NIZhBM0wNDr17EovI8NxrLTLOy3uKWr7Mpz6skQ02lUarPBUTFx56FeL/eSbW1757s6cPgQIBMTeWZlB8sfKw6CvEE5hEfVAhtW8RDVJfLotE29Zz+CMhFaVwSrtd0LatLgUzL8vL9l4ZMvwTRH6meiUj6pYhE/rJKUDGcGqy+GE3LpFB62P5EME2eLiTOlr0Adt5BEii5N+AAvb+jgGRyPJ+He3DaxbdOx5QnDB2NqcO/9zPMrSqYaaJVoxzPEXpLmSP4aRwXvXGK+JJFOVSw7xOrDTUXy3/q5Sj0wwmpX2xxwYA2aXeA/NqC86oiqaoU1JCZoI4tX53Sk8pylu1oBfHeJrkDuGt/AC1AEhwHRXPRQS9imKC2pY9kZemPOX3Voq7nRs9tYMEe1uo7oUT5WCc/MT8wgMVhXVuMHNRtCIzOI7PrrZ0L8Wb/E8C8kKO/DX5nUxbuDVSvr61jLtBeNzm3xI462nDdIdLAlNd1RdF1uJ/e8/Auqzt294TBkFdRYZD52+9BjdLKX3XFT8+5a/+FYI1CuNLjJMIyrj67guLVLfIK17nqM61r7H++d/+zDgyBFknbrlI8q+9SUa7CdCc0+SHs/LDJACCfFRftXU5BlhfU30E3Yeny9fsAeQlJBnu/sRA8oyqYGe/QrkMo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(5023799004)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: xMwwg8Wj4chPVuYY+h7GAkq6Y2vRYMf3mSFWyu8t0CCHxNmDpdiKPxH8C+vUUG8k/Jb4cQ/qGJeXD/4/17wiyygSaqsc7qZNT1Zde/GnH9GJECaPgNI9Gy+/Mr5yTDOeI2sUI8h6cjCZhHgtOQbBXaMZ0GtxEOcYjAfE+FcESrEa/2s7UUMn2QQWZPp1M84NPFQc8UJA7VECyC3QLgrLOclJGeQ2wxAaW+YHbEWfz2YZIvxUaAHa+dx+4JskpiUUpKFwWPKUmFVvpApGp3f1bNPNYD6+pXIHV9syO+Bm5azo2x9J/nPYNF9XOhelsWEjjRoRgEdYXG6sq5MXcsn/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7537
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4fc33a46-91d7-4bf7-4615-08df080d350f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|35042699022|376014|36860700016|14060799003|18002099003|22082099003|3023799007|56012099006|6133799003|4143699003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: SOPYLoGSxkNU+wX+9n1hhqOF3TpXlyL0ffBMJxwy7j21AUBpRYUuVVajwiauBjREd8h0k2zxQf6weBFPeOq+p8jm9nheXpCFRPLNMiWOKH2MrY9W6CWu/Vx8Vf6BUbWIXT2NxA9csjOaGA3lFebJGiDEQHhYo6G8HfWUQldbcv1cVkwbRM1rVydGIeWbHS/2McdOxBlqz8Gs4ErrcKo5k3tm2WomfmZ2kcpBLJgbfCh+qaumF9N7F67JBxrbQ/bfi/p2UJssiFbFT+ire72jtnCIhFwrkySQOyT7zci4zjh0te9KCJ55NW6WaCtVHbgiHq879wJNn4XSjggxaIUpU+YL6AUWFYjSqgq9bDoBaWo6gMpbcVOUMtZvQzKW6uyECnoIpZmY7CAeHrKkmdzG4uuxGxJCK//SJxi0dQKPU8KlqAhbuYaEKaZ87acB7hxre13N807q11PcWj7Nx6IxioZu0Opvq3zc8R8eIXIculEh7JjMQpPLM4irGfd6wjSvA7PwjlVifz8aSYj2i/tmbYUlCckUENntK7sXK0BK/fs0EwqTIvsrduImbO+LEZpPN7V2QzRFa+GqC75E0l6U/CFHQUMqWTbDSvxK6opdkgmksk6QvAn7Sc9VwUiC+7w76WyJhoyhiUnRIju+DCVZvHmpEXzShBgUf9YPvaMmS933eZoPg1rja458FQkugwl9gifN5jtazP6kLkWD9g5fWw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(35042699022)(376014)(36860700016)(14060799003)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003)(4143699003)(10067099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cdzen29g8yfR6Pm2QaZousKCJdff5WCWhhKeKXTPjYQXWiMPtuuP/lyRfh9bbJFko95PTTtnibYD9W2Bz+TGpS9re1k28T9YoUzfvR5vkZ+EogO2VHTABQyVU3nR7euAM5WmOLlVA1PMWwpLh8RlSY2wudgyndHy9kF+zDCU0Nax2x28I+0jZA0btGAxTjBACWLfQh8DrctAxwGpcgRxyBcM9lP8X0QOV0Qmsx/wJdZ6Fkmyra+As85jkQ5xza2uQbFmEsjePkYTD8zB4h/Lp0qR32NQkjuagYsrb18AG5tBqG9TntQBA0EXamWDdLKuYiPD6UsZ9pdSEprpHkMmBTOI8EoqUeh3HTqE+3xuy866iQuyyFypk4g3XqoICxFbwn1noG/aTl3bEJzZ/pdEzeyh5hi1AqNIMiS2xZTelJ+vRPWR3fsqguvY/m0up+l7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:42:11.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca237d0-480a-4c6d-1a77-08df080d4c0a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008558.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5617
X-Mailman-Approved-At: Tue, 01 Sep 2026 13:18:09 +0000
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

On 7/31/26 15:43, Ilias Apalodimas wrote:
> Hi Harsimran
>
> On Fri, 31 Jul 2026 at 17:17, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
>>
>> On 7/30/26 13:12, Ilias Apalodimas wrote:
>>> Hi Peter,
>>>
>>>>
>>>> Hi Ilias,
>>>>
>>>>> I'll be off next week so this is going to take some time for a wider =
review.
>>>>> Since this is quite a lot of code to review, I'd prefer being able to
>>>>> test all of the cases to make sure nothing breaks and add more
>>>>> selftests in the future. I don't have access to a Corstone-1000.  The
>>>>
>>>> You can get the Corstone-1K FVP here:
>>>> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/index.html
>>>>
>>>
>>> Ok thanks. I'd still prefer to have this on QEMU since we can
>>> reproduce all the cases there (variables in RPMB as of today + the
>>> FF-A variant). Even if we do use the FVP, I'd like to have information
>>> of how to build & test this as part of the cover letter, since Tom
>>> includes that in pull requests.
>>>
>>> Cheers
>>> /Ilias
>>
>> Hi Ilias,
>>
>> The instructions to build the Corstone-1000 FVP can be found here:
>> https://corstone1000.docs.arm.com/en/corstone1000-2026.05/user-guide.htm=
l.
>>
>
> Thanks
>
>> For the QEMU/RPMB/OP-TEE question: QEMU RPMB would cover the storage
>> backend, but the FF-A runtime transport also needs the secure world to
>> expose the MM variable service through an FF-A secure partition. OP-TEE
>> alone would exercise the existing CONFIG_EFI_MM_COMM_TEE transport, not
>> the FF-A runtime transport, unless OP-TEE/SPMC is hosting an FF-A SP
>> that implements the same MM variable communication protocol.
>
> OP-TEE can also be configured to run in SPMC mode and load SPs. The
> question is what is the backing storage of your SP
>
>>
>> For Corstone-1000 we are already using the Trusted Services SMM Gateway
>> SP. That SP implements the MM variable service and exposes the MM
>> Communicate endpoint over FF-A direct messages, which is the path used
>> by this series.
>>
>> I agree that QEMU would be better for wider review and CI. I will have
>> to investigate the QEMU setup using the same SMM Gateway SP along with
>> OP-TEE/SPMC and RPMB, so we can reproduce the FF-A runtime variable path
>> without access to Corstone-1000.
>
> I can help, I just need a bit more info on that SP. I'll have a look
> at the public docs as well
>
>>
>> Do you suggest that I investigate this QEMU setup for the
>> next revision?
>
> I'd like to at least see the gap, but I suspect it's going to be small
> if it even exists.
>

Thanks Ilias.

The SP we use on Corstone-1000 is the Trusted Services SMM Gateway SP.
It is built from the Trusted Services smm-gateway deployment and exposes
the MM Communicate endpoint over FF-A direct messages. The generated SP
manifest uses the SMM Gateway UUID.

The main gap I found so far is on the QEMU/TF-A side. Trusted Services
already provides the SMM Gateway SP, and QEMU has RPMB support, but I
could not find a QEMU-specific OP-TEE SPMC manifest in TF-A. The FVP
platform has fvp_spmc_el1_optee_manifest.dts, but there does not appear
to be an equivalent QEMU manifest in the TF-A tree.

So I think the QEMU work is likely to be:
- add a QEMU OP-TEE SPMC manifest for TF-A
- package the SMM Gateway SP with OP-TEE SPMC
- wire QEMU RPMB into the secure storage backend

Do you suggest that I continue investigating this QEMU setup for the
next revision?

Regards
Harsimran Singh Tungal

>>
>> The setup I am currently testing is Corstone-1000 FVP with the MM
>> variable service exposed through FF-A. The FF-A runtime path is tested
>> in two phases as follows:
>>
>> The first phase (setup phase) creates the non-volatile runtime variable
>> before reset. On U-Boot prompt:
>>
>> corstone1000# setenv efi_selftest 'variables at runtime setup'
>> corstone1000# bootefi selftest
>>
>>
>> Then reset the Corstone-1000 FVP and run the second phase.
>> The second phase verifies that the variable is available after reset,
>> then exercises runtime get/set/append/delete paths.
>> On U-Boot prompt after reset, execute the following commands:
>>
>> corstone1000# setenv efi_selftest 'variables at runtime verify'
>> corstone1000# bootefi selftest
>>
>> The testing steps are documented in the bootefi documentation commit:
>> doc: bootefi: note two-phase runtime variables selftest
>>
>> For v5, I can add these tested steps to the cover letter.
>
> There's no need for a v5 yet, I'll take some time and reprod with the
> FVP. Just keep in mind I'll be off for the next ~20 days so this is
> going to take a while, apologies.
>
> Cheers
> /Ilias
>>
>> Thanks
>> Harsimran Singh Tungal
>>
>>>>> latest version of QEMU do support emulating an RPMB device. Would the
>>>>> changes above work with with an SP, QEMU RPMB and OP-TEE?
>>>>>
>>>>> Thanks
>>>>> /Ilias
>>>>>
>>>>> On Wed, 29 Jul 2026 at 11:51, Harsimran Singh Tungal
>>>>> <harsimransingh.tungal@arm.com> wrote:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> This series adds FF-A runtime transport support so EFI variable runt=
ime
>>>>>> services can communicate with the secure world after ExitBootService=
s().
>>>>>> It also extends tests, documentation, and Corstone-1000 configuratio=
n to
>>>>>> validate the runtime path and keep boot-time behavior aligned with t=
he
>>>>>> runtime flow.
>>>>>>
>>>>>> Changes in this series:
>>>>>> - Add EFI runtime-safe memset helper and FF-A runtime transport supp=
ort.
>>>>>> - Add runtime-safe FF-A direct-message handling and ExitBootServices=
 setup.
>>>>>> - Implement FF-A runtime communication in the EFI variable TEE backe=
nd.
>>>>>> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableNa=
me(),
>>>>>>    and QueryVariableInfo() over the FF-A transport.
>>>>>> - Add sandbox FF-A runtime transport tests.
>>>>>> - Extend EFI selftests for runtime variables and enable bootefi self=
test
>>>>>>    on Corstone-1000.
>>>>>> - Document the FF-A runtime transport and runtime-variable selftest =
flow.
>>>>>>
>>>>>> Changes in v4:
>>>>>>
>>>>>> Address Ilias Apalodimas's review comments:
>>>>>> - Split FF-A bus runtime support into smaller patches covering runti=
me
>>>>>>    private data, SMC invocation, direct-message helpers, boot-time r=
euse,
>>>>>>    and ExitBootServices setup.
>>>>>> - Split the ARMv8 cache range-maintenance runtime annotations into a
>>>>>>    separate patch.
>>>>>> - Split the EFI variable TEE runtime SetVariable(), GetVariable(),
>>>>>>    GetNextVariableName(), and QueryVariableInfo() support into separ=
ate
>>>>>>    patches.
>>>>>> - Replace MM SP status macros with an enum.
>>>>>> - Keep OP-TEE as the runtime fallback when FF-A runtime mode is not
>>>>>>    enabled.
>>>>>>
>>>>>> Other changes:
>>>>>> - Rebased the series onto current U-Boot master.
>>>>>>
>>>>>> Changes in v3:
>>>>>>
>>>>>> Address Simon Glass's review comments:
>>>>>> - Move FF-A ExitBootServices event registration to the end of probe =
and
>>>>>>    clean up RX/TX buffer handling on failure.
>>>>>> - Rename FF-A runtime-context helpers to the ffa_runtime_context_* f=
orm.
>>>>>> - Rework FF-A/MM cache maintenance to cover only rounded request and
>>>>>>    response ranges.
>>>>>> - Add SetVirtualAddressMap handling for the FF-A shared buffer.
>>>>>> - Document FF-A shared-buffer ownership and alignment assumptions.
>>>>>> - Add EFIAPI to the TEE runtime GetVariable and GetNextVariableName
>>>>>>    entry points.
>>>>>> - Tighten sandbox FF-A runtime tests and reset runtime state between
>>>>>>    test cases.
>>>>>> - Update FF-A and bootefi documentation for the runtime transport an=
d
>>>>>>    split runtime-variable selftests.
>>>>>> - Rework commit messages to drop redundant information.
>>>>>>
>>>>>> Address Ilias Apalodimas's review comments:
>>>>>> - Keep efi_var_common.c unchanged and drop commit 6 from v2 patchset=
.
>>>>>> - Rename the TEE/FF-A runtime handlers to the *_int_runtime form.
>>>>>> - Remove log_*() calls from __efi_runtime FF-A/MM communication path=
s.
>>>>>>
>>>>>> Other:
>>>>>> - Fix FF-A memory-share sender_id to use the runtime private endpoin=
t
>>>>>>    ID after rebasing.
>>>>>> - Fix the expected QueryVariableInfo() return status for the
>>>>>>    TEE-backed runtime selftest path.
>>>>>>
>>>>>>
>>>>>> Changes in v2:
>>>>>>
>>>>>> Address Simon Glass's review comments:
>>>>>> - Fix efi_memset_runtime() style, declaration, and byte cast
>>>>>> - Tighten the FF-A runtime context failure path, clean up arm-ffa-ru=
ntime.c
>>>>>>    style issues, and move ExitBootServices event registration earlie=
r in probe
>>>>>> - Add shared-buffer bounds/alignment checks, and tightening comments=
/kernel-doc
>>>>>> - Document the FF-A shared buffer cacheline-alignment requirement an=
d add
>>>>>>    BUILD_BUG_ON() checks for the address
>>>>>> - Cache attributes before the shared buffer is reused, moving the re=
ad-only
>>>>>>    check earlier, and split the u16_strsize() related change in sepa=
rate patch
>>>>>> - Reword commit messages for the runtime helper relocation
>>>>>> - Rework the non-volatile runtime variable selftest into setup/verif=
y phases
>>>>>> - Extend the sandbox FF-A runtime tests with no-context coverage,
>>>>>>    runtime-context reset, and separate errno-mapping coverage
>>>>>> - Refresh the FF-A runtime transport and bootefi documentation
>>>>>> - Drop patch 12 in v1, as ffa_mm_communicate handles both runtime an=
d
>>>>>>    boottime capabilities in v2
>>>>>> - Squash patch 8 and patch 9 from v1
>>>>>>
>>>>>> Address Ilias Apalodimas's review comments:
>>>>>> - Reuse common MM SP error mapping for boot and runtime paths
>>>>>> - Rename runtime-phase tracking to reflect the ExitBootServices tran=
sition
>>>>>> - Collapse duplicated boot-time and runtime MM communication helpers=
 into common
>>>>>>    implementations
>>>>>> - Keep the arm64 cache-maintenance path runtime-safe
>>>>>> - Move FF-A shared-buffer runtime memory-map registration to the end=
 of
>>>>>>    variable-service initialization
>>>>>>
>>>>>> Link to v3: https://lore.kernel.org/u-boot/20260627144421.2067410-1-=
harsimransingh.tungal@arm.com/
>>>>>> Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-=
harsimransingh.tungal@arm.com/
>>>>>> Link to v1: https://lore.kernel.org/u-boot/20260424173151.371134-1-h=
arsimransingh.tungal@arm.com/
>>>>>>
>>>>>> Harsimran Singh Tungal (22):
>>>>>>    efi_loader: add runtime memset helper
>>>>>>    arm-ffa: store boot-discovered runtime data separately
>>>>>>    arm-ffa: add runtime-safe FF-A SMC wrapper
>>>>>>    arm-ffa: add runtime direct-message support
>>>>>>    arm-ffa: reuse direct-message helper at boot time
>>>>>>    arm-ffa: enable runtime context at ExitBootServices
>>>>>>    arm: cache: keep range maintenance available at EFI runtime
>>>>>>    efi_loader: add MM SP status mapping for FF-A variables
>>>>>>    efi_loader: make MM transport selection runtime-safe
>>>>>>    efi_loader: make FF-A MM SP notification runtime-safe
>>>>>>    efi_loader: make FF-A MM communication runtime-safe
>>>>>>    efi_loader: reserve FF-A shared buffer for runtime variables
>>>>>>    efi_loader: enable TEE runtime SetVariable() over FF-A
>>>>>>    efi_loader: enable TEE runtime GetVariable() over FF-A
>>>>>>    efi_loader: enable TEE runtime GetNextVariableName() over FF-A
>>>>>>    efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
>>>>>>    charset: mark u16_strsize() as __efi_runtime
>>>>>>    corstone1000: enable bootefi selftest
>>>>>>    efi: selftest: add runtime variable tests with non-volatile stora=
ge
>>>>>>    test: dm: add sandbox FF-A runtime transport tests
>>>>>>    doc: arm64: document FF-A runtime path for EFI variables
>>>>>>    doc: bootefi: note two-phase runtime variables selftest
>>>>>>
>>>>>>   arch/arm/cpu/armv8/cache.S                    |   8 +
>>>>>>   arch/arm/cpu/armv8/cache_v8.c                 |  13 +-
>>>>>>   arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
>>>>>>   configs/corstone1000_defconfig                |   3 +
>>>>>>   doc/arch/arm64.ffa.rst                        |  88 ++-
>>>>>>   doc/usage/cmd/armffa.rst                      |  11 +
>>>>>>   doc/usage/cmd/bootefi.rst                     |  31 +
>>>>>>   drivers/firmware/arm-ffa/Kconfig              |  11 +
>>>>>>   drivers/firmware/arm-ffa/Makefile             |   4 +-
>>>>>>   drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
>>>>>>   drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
>>>>>>   drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>>>>>>   drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
>>>>>>   include/arm_ffa.h                             |  16 +-
>>>>>>   include/arm_ffa_priv.h                        |  22 +-
>>>>>>   include/arm_ffa_runtime.h                     | 191 +++++
>>>>>>   include/efi_loader.h                          |   3 +
>>>>>>   lib/charset.c                                 |   2 +-
>>>>>>   lib/efi_loader/Kconfig                        |   4 +
>>>>>>   lib/efi_loader/efi_runtime.c                  |  20 +
>>>>>>   lib/efi_loader/efi_variable_tee.c             | 739 ++++++++++++++=
+---
>>>>>>   .../efi_selftest_variables_runtime.c          | 715 +++++++++++---=
---
>>>>>>   test/dm/Makefile                              |   3 +-
>>>>>>   test/dm/ffa.c                                 |   6 +-
>>>>>>   test/dm/ffa_runtime.c                         | 123 +++
>>>>>>   25 files changed, 2004 insertions(+), 498 deletions(-)
>>>>>>   create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>>>>>>   create mode 100644 include/arm_ffa_runtime.h
>>>>>>   create mode 100644 test/dm/ffa_runtime.c
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>
>> IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
