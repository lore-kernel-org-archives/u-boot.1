Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5FD3514B
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 07:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BECA984020;
	Wed,  1 Apr 2026 09:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="b48K56/J";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b48K56/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EC8C84056; Wed,  1 Apr 2026 09:21:51 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38BB83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SvYcGLZTF2o7pFJigw/Pl0Xzy7Eur1/XcsDhI2zdLrh+DMv8bJ26O6apxvn2RTxQMdRbtLVKDA/WSNfKgPi73FuzN7B/PbV0kZvrBMWpUbpYWySkKbnUlhbWVLiU+5ZEbSOsECD5nFWuH+lptjlI+JdRkOWd1g+WGl9eOUR0HG1rBsBfzGSsbIn/AU4McaBYcLlLLUq2S91cc60MClua76TZ/huqdIRtqEg5N5DIaqLmVwrQWnC7/+1i7BIUl18L9c2FLI+w9Zd8QlRuP2mIx83+7f/dKFgMShpG0CI8mQoTfIYR1NPvyoZYpa9FPfp0WjooUmP8wEPx86l9ug+Z2g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YleOTJdIYy7VmMpXlZLN/SSm+6HfYXSeGtUgmkS700=;
 b=FBWlo4CKflQ96DL5sRPROCX4NxS0Ed1AoWZro1eHYKiB0TuGQJ0Tydr10xOAIBu19tNDoebc4P0wvofBznuM62Zp2T8DzE7h/Ns0NTGFY8nFMG9x3EQZkrGNMH308Sq0GTQ8rqsSbEK2OKnvCGj3zG3ZObvtsVkgtfytJgF9jw0GWrQPuzu7Cl9POCqGLi6FjJ7iax5OkHZ0+WlCuvIaMY78pxfD+dOziD/Js48YO3h46wTR1piJmDozyq7pEGdtZv1hS8DYSIYzC4W5AbZcoO6Q9l7R6a92P3upbM//BVMQu7iDdOLHq6qedJYRcFa5bVvL2EVQJhVfRIaBlOTetQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YleOTJdIYy7VmMpXlZLN/SSm+6HfYXSeGtUgmkS700=;
 b=b48K56/J6bVIZqskUdhtfGbbjdObTT/9y+7Ey8xxcuTVDsDY/FvlNJDG6STLTrMbrT4PXlL+b4aNT0uQEp/5ZRtVJHR0KpwPmH7rgQ/AVCoXoPVhnuR4+cacX7n7NkM5pAQu5C0wjN51octWiRJ6I5uZJP8m0PPaT9fMFTS/VMU=
Received: from DB9PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::23) by DU0PR08MB8229.eurprd08.prod.outlook.com
 (2603:10a6:10:3a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:21:46 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::fe) by DB9PR01CA0018.outlook.office365.com
 (2603:10a6:10:1d8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 07:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Wed, 1 Apr 2026 07:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMhMbRUuMJ6vlTY5kmeiErJd4uDWXogY0CJtpQ8b5DOkCWOHThepyuiyIWjs5pVefYwX1VPzNBtgP++ewcDmNctdDTFlIaQaPDi5+B9QPRoQAbpXimUPJUJgMX2wjlvPZ3e9XTtLcsZD6kBwsR53k+cWoj2zrTOROE6Vlq6pHXqph/RHcA6yynEqTUnaAuvp6f4niO1sJNENkgcQdnJp2A5iwbeygDthhylZ7sX4Ig8zFeE/XJAjt/SfD6aDmMYyJmg4rGFLrsodExZ4ibvPrxdgkOgLTF+IkfFMxKrQnKzjdbTRanddO7ELUOh59dTvsDGPkWBCnnM2UaINaEabJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YleOTJdIYy7VmMpXlZLN/SSm+6HfYXSeGtUgmkS700=;
 b=n6IeMgfjKgEIt+NfKrfRaOKWtuCnr6f4Wj8XF8GZ4Xtm8S/KFRy9IAxjHULVBI1DQvZyqHpadVm2PW08JpIZc2fw97rGgob4YY5dTR3Cjblgv+ufETMGa1gQquxiaB0mYVpl140I1Ua1VGA+MfmVn51vYp3WKxAW/M81a1V3UR8DCdjrlZZ9HGIa1Df6cDYADqqqCOuhCOM4N7GYuNHbjVFzOjutE8WWHD+0PuGLzMommMUAq//T4Z9t6AhG+LOEWwAMZk6xkr5ncL+Op7O2xlo7lzdKnL/YBeXZlV1EtldKpUcAHVnITktnuHO7p5WH+Cy2xOTYTs4G7tdxxfPRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YleOTJdIYy7VmMpXlZLN/SSm+6HfYXSeGtUgmkS700=;
 b=b48K56/J6bVIZqskUdhtfGbbjdObTT/9y+7Ey8xxcuTVDsDY/FvlNJDG6STLTrMbrT4PXlL+b4aNT0uQEp/5ZRtVJHR0KpwPmH7rgQ/AVCoXoPVhnuR4+cacX7n7NkM5pAQu5C0wjN51octWiRJ6I5uZJP8m0PPaT9fMFTS/VMU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB8222.eurprd08.prod.outlook.com
 (2603:10a6:20b:52a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:20:42 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 07:20:42 +0000
Message-ID: <7d08e7ad-bd02-412a-a3d1-30a5edc27bbe@arm.com>
Date: Wed, 1 Apr 2026 09:20:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .mailmap: Fix Jerome's entry
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Heiko Schocher <hs@nabladev.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Linus Walleij <linusw@kernel.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <32f53e6008a389884ee406ebba1a206e73ac29af.1775023814.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB8222:EE_|DB1PEPF000509E3:EE_|DU0PR08MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b5e41f-4fc6-4ad1-195d-08de8fbf5501
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: H+k8PptVXOkUem0MvQgcwittT9CRhDTg6L8Awej0YiEGevtoBRMAo8DNfrY7fERNP+1/NIwHYZZNVHsMl3F5ItGjMwkKZbOumqOFo5Y8c+oy6AopGqW+ilXHVyzHOD4P4Hfqgd+x+UCj7eu44JINYg6cEhvUDgwmSX3cO2Ys9dcBvGtfH2sXk40vy05rMqVu+vKaU8y/PvTvhnVioVQcfTQ18Yo2djLLgG4AP90r3RJN6Fp/LrJzM3SoFaXguiwn3fdKR6pm3n0TMHufSKg0xTWxPJVYeBhQPlpDTCvPsldF52pnDiyYtFL0qGaoh9ohOETakeUU103b1NrXzkLqwBTxQeE5DteFxBzzbnpgLFU9wR4GQHAzzoejEunw4EweM7+XGzXuYmnsmaSoIADjBEllvdhxp4aPRNVuwa5lWkZlmdsfhxWrydBCdOOQhnKdarTLRJP/JG76h33b57SuUzmK/ygNpzlDt6gzv/ZjpkJzsRxx+WQ80R5rxDObT5vwJ1qyLV1G3SlfuPm7kAWJf048L3p8BC8ku8nwtNWVkbOtqHOv48O4tvq0c6dylOIShewXTtkvim+kfqKTATFRHtij4bYY8M6k1ZMpbAWwxyeHeRsF/L32FAKL2w7HsHiRmvU8V7AqW7KySKseYq467D9RVU89hREx7L8kYbfBfRwML0AFIyXXb0rMsEXEc+n3GVFSxnTICK0A5melIGdme7UKhqI/wrnVPu8gjh2d/FI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: FRINZTBWAMFmhX0usUge2uztaEPUNfJVPxr8nsiR3OnFT7BnZpJp8UUc9mMqktzxYJwVmxb5FGlPGECnq+LuvfHbtckGURAUgY7WSDyhox8hPW+pvW35ubc+Fs4iF4SNyGezYOavhI6o/3e+2wFyc0dqL9dm3L3MI7o3CWpqWoFPWM6wQNMlVHOEEvuNNoWhOJ2FX76w4nYChSIv2odFOW4CptihvDqUMdiVeM97ZsAIuhz4OH0PKtf2YtZQmU34Ae9kcJv5feP4gQx9wpiCB3QBa7TvNMJz26LtoTF3zkOS/xVXC5aiUttksawaiVzp+G9/e9RfnUv3AQZcICJq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8222
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9e4dfa4-3786-4304-5311-08de8fbf2eb7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700016|7416014|376014|1800799024|35042699022|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: DeGemE7IlXLI8C12NziWY/maVw4bYyrgC3LBCWLOyUoBbrAJcX+FiQ/9wrCLPyQrmHDs37Bz8ny2k0qAbqAAMuOhpDYJm2mVjEEey/aizQIuv5txs+46crgOMJLohZJi6p8zpjCAwz4J18sEVhoxoSYY3cdMGjOXZzBKfOm8QmSTjeHCgimOw0y0++7C9unLaK5rBW0sleJOPpoqeQ+MO2wg6uew5ffsHV0oE+5cBvvqGvMN0+owv7aJcECDwXy8G2JltLKB4SqVIzp5/ZuzIfmIv3CSN6tJin0yMhGewAVUWVfmYJXHr9u7pvj2insJ75Xov6Ia5JjCNgkIHE8p2xYbujyQfpCILApo4qTwx12tuEUYiiotF+fecepC8GaWQ37m4IL71SadIo/G7bG47dvvHywuiFR/J2YF+VD/Hyg+pAoDh4t9jLaddKObYQIVPDgMuWOtMsLDSTHC7OoOXFJXOMiTT4kF3dWhoHWLA8ZMArj8cHEWtFrTaAwZHLS09qmGhg3K6J44kZ4r3kA8xjULqootW0MDZSHU/sQkIyrCByGjdtaJpqGHI4ltLyejbwCP/lN8FxLIGfv/+ONUMl7D2W2ohSwX98sxnIiPbWPmmcoxgR/+HFjCN2Sw8zsgum9MhyaEGTmmVUmNtby2AjbSL5V9tXvqWTpNa+yU6i3u74+NFWfaO6hz4vtQChZETnUhp4HX3/Gs+PmlNo7rsPGb2AQfs9pGFqBy6e3FTaM+q75UylKy2J8XFtJP0xdXOSK5zjEy8DYz5eeNHF29CA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700016)(7416014)(376014)(1800799024)(35042699022)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M7Gnd4GLB1lXvP/JSb/iFWF1pIJ+FdW8S8/8R8wBodYUrhPWJA/4ZrONtBpjE+BH5ZrBsts45mg3iCej5yapJ69F2NeZe8kLc9orpJQv84k3YWr0RiidU9kHpYzoleHeF/abUgoULVcAEjAJkcg3t26dEtIxcaYYT2sN70HPM+ZmDqr3wJQTAYrv9xeX4OVJ5J1jKdaNNfbY0QHeM1RT/VT4UG45RG7Bx0W9Xqs1fylvnNIBFFQmvqdQIuZhILqrk9qo1uWPWllqkDxGhaXHF1L8euHIakcHK1JNZYe5M/H4Nmxi3kJ4uZ86GoGI8IIjc6X13WvMDKixjEZ68lQDJzw+zT6WLUz//r2cPj7KiP1etqVkY/l55o2mbfo6jPEXPm5WGme6dB+lMEUoE0/Rq5llgXwNj8mQiQNa49/xELEmPqQmIk+O8YRZLgwhxc00
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:21:45.9639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b5e41f-4fc6-4ad1-195d-08de8fbf5501
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8229
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

Hi Michal,

On 01/04/2026 08:10, Michal Simek wrote:
> When patman is used email address is composed together with both email
> address from .mailmal file. Having two commit emails is not proper format.
> 
> Error:
> error: unable to extract a valid address from: Jerome Forissier
> <jerome.forissier@arm.comjerome@forissier.org>
> 
> Fixes: f2566c3a71a5 ("MAINTAINERS: update my email address")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .mailmap | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 31d4970fff77..6ac4b9b9e5ef 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -69,7 +69,8 @@ Jagan Teki <jagannadha.sutradharudu-teki@xilinx.com>
>  Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theobroma-systems.com>
>  Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
>  Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
> -Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org> <jerome.forissier@linaro.org>
> +Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> +Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
>  John Linn <john.linn@amd.com> <john.linn@xilinx.com>
>  Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
>  Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>

Thanks for fixing this.

-- 
Jerome
