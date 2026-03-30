Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A6710F3DCD
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 14:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1507A83E7A;
	Mon, 30 Mar 2026 16:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HCF4PlCb";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HCF4PlCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF3B83EB3; Mon, 30 Mar 2026 16:25:52 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B718C83D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=i9xMW/EpPwDAtprT2c+Iu6Up/Fxq23xvuyeFTavufC/+sDm3AUbMGhK4vjnVdteJXdwLDfd4uObwAS5C4I4kXWuoN/02vn4SwdXdz5HjJFZV7AvvxlCt60tfORtIJAqexAYbJNygyEo1lqzXbu2oIdf8epL2rNR3vdUzku/3v/UFyoJ1UrxU7P2E47Y20CYzUDGyARrfoZk05ZYPjNwKo2kZyZkJbfMSUADIxTAKlpRJOV+lN+qsANx+cW5skil2rYb8sYdc7vj0u3Nmz0FwOmqAVuSKrhacP7AYZllH2gQ8PTrYvM6sveh8qzqOaNNkBVJYIt9Ruh/ky70yovUIgQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSXAervB2SaixKDIyhFNhr/uTV9as9MGpQl1wvD/JBg=;
 b=Sa3265wuOu6Nn18+H/sVCBXHrhDX4Lnqj3rkLz95W+56Vlx/xeEuYizQK22Bo+5PWk4ULP0ntsan7BJX7zJGfjeW5KuVNq2h3jBrYzKBm5dzoP3Tyldi4NIAPd/TghfO7HBhwrHkl1Zbc3/2gHRUHqz/EfRDRd2yodp/AO4UWOFL0Hn2aZ826MBPApNsomefJyEDXSZ8CdrSz0NMccO3HZGPdj1aIX+P708Jjsh5GmB4Qp6rgHYDgxykKNkNK1GclVNCrvfn72zPArjOsHJpieDFtkw+sZEn5RM02sd9g9p51BRCt0hiXP0fRawEQqzLwLJw4SlVxiLYTVc+iUihjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSXAervB2SaixKDIyhFNhr/uTV9as9MGpQl1wvD/JBg=;
 b=HCF4PlCb7FV82nyLqcTMmt7MORQSjnQLiYIpXt2wzzcknpHuMM8GGM+E1C61RfWvEBB1xtwOz3kXbuYwlwX4R/HGWr5Vqc67VqhEpXygEJ/OFHkvLsEay72Cd7gmvBpASKDeU7hxRRotORb2IIGvfidgaqZTHJkbJodl314B4fA=
Received: from CWLP265CA0274.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::22)
 by AS8PR08MB9525.eurprd08.prod.outlook.com (2603:10a6:20b:61f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:25:44 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::43) by CWLP265CA0274.outlook.office365.com
 (2603:10a6:401:5c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fserBr5CyxE+fPfQ9dWJoFksW3B81go5MxefR+wiec4pZwHgz9FU/ll2nAS35SBhaaxqSjQkN/mPewQaGZllKMo4weG1mVJYxNV4KPjlcOVqaBOfb/HBTsTdvBqmOUN+Aebdr+HxeM0U8LQLGZzR58PAGtx1n5v7+1pmQq0Jm/3inL+6GvGKmKaJxMF3tXNdfE+abbHjgnoXYlErNIhwdHKk+q0jOBipB2TmdW1z3XcfA7yO6TO38cWd+nMjI8Vlp/vqcJnTkg+UubSqwGGjHbdKxQBN2JIaWIhPYRgoaCZAQrdZ+sVPAEUpQ7G7zRmOtJZ1qb28YYvymE+DubOVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSXAervB2SaixKDIyhFNhr/uTV9as9MGpQl1wvD/JBg=;
 b=AP8wm2WUlqzl5y0O/FJapahSWWCAgRhveqdULSifDNul2id3J6UBq4veFdZ8A7Zr8CDLLPM8525ckyOc4xYtbNNwyn+kGTUu7FXWBe+jDo70lluu+EGfApi8sZuHSH5cwY27emob+D+endg7jcnZ/ftcrFitV49lqvsaDshOAxPiN28mQYZlb4HiWQ+LhszlO1lL2nTaJzOxPUVMDk5W0gonLnV7Oi1VNEk3pBmDDd8gIL1qO1wFATaErY7QMUIngWI2f5ixtd07t1fGkY5vrJDrvCL9GcqJ41Q3DzvVhI6d+BVHIUzOF0jiOzl73eWEioCNAQZzYZ60xD4iYLpbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSXAervB2SaixKDIyhFNhr/uTV9as9MGpQl1wvD/JBg=;
 b=HCF4PlCb7FV82nyLqcTMmt7MORQSjnQLiYIpXt2wzzcknpHuMM8GGM+E1C61RfWvEBB1xtwOz3kXbuYwlwX4R/HGWr5Vqc67VqhEpXygEJ/OFHkvLsEay72Cd7gmvBpASKDeU7hxRRotORb2IIGvfidgaqZTHJkbJodl314B4fA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MRWPR08MB11730.eurprd08.prod.outlook.com
 (2603:10a6:501:99::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 14:24:39 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 14:24:39 +0000
Message-ID: <20259a67-d515-4cb3-acf0-0a6192def8c4@arm.com>
Date: Mon, 30 Mar 2026 16:24:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: cmd: Correct dependencies for CMD_PXE
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <20260323195253.2363485-1-trini@konsulko.com>
Content-Language: en-US
Cc: nd@arm.com
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260323195253.2363485-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0515.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MRWPR08MB11730:EE_|AM3PEPF00009B9F:EE_|AS8PR08MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c94aba3-fc6d-45e8-558e-08de8e683a73
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: fRweFxD6qnHyRoVw9xSe1ir5dL06+N9GFGWVJAdVC/m1edpkJOWy9nzZMPM5iDGHWoggOeSODIDDUOmFEVXH6Xt8Bvp6UDiItHWcsI3oQ7oM6/KRQhTiEqPFNT8vJDQoXL0YIvU0bznnDqApAJK/KMuT3feHjePYcCLD5RtZXpOaI8LdM5TiPKXAIOpY5uxI66G9ZamkFFwMDWPRu7AyhqjTEJmHGBqD50F3EZmosiqsC+iJ8jUM8OXmydvhM9Y/LknEQ1rlVQdkQyzn8RAfHm/yIoSLIGIySWNqIEmj4q2Ta8pzF3MAmZb1IVcq36tlCjfZhJ2Byhe5Vr9cCUEHDHe4PC5t9u1fj+OoIyXzixZzxHrbeJqev7KfnQlUpu815QiS0K/jsRO2Nppr1WhEiN4bk7Sfv0gGmAJYuNi8ElRi2qWINoInmGxtKiYvsqS4SWLZQ2HGD54qJx4mioZiRh2GMDLZN1ZhQmnSYg4AwdLsIcod94Br0yg3VJ9442qjku+U4A+5j8I9Ajf0H7VPEivG82ODE78Zw6cUMq70ecS2jTG3DhWCXwJHRQ1BIrND4QiZXjJtxu00CRDE6oxBzbNkiu3qfQNlUObS2jylKDDdVRQ/mUezI4wJvtsYVUMiWTHbouhTt8PhPsC4MNpQVhCO41XxXkst2SyH8g7ctq2ShyfnsqTMh2lpAELRpY+BxnXoAVAybMnm2Ym8LKD+jp3JA7w/ZBK9K/im5Ox4Ib8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Rs1L+RuXQb37AZIBRkDX8PU5HrWQehMDhslD62nG2n3UEuySNnycWLi2vpiI9L0axyi/u/I77u8H/jO1ABzdmKgLEQmsD5LWtBoR/XeEyrXhb+pXShhkbVViOlkY2uRUqw1dBbVPdFnXGcYfk/7r2sVwkJl2W06be2TzmSp0YaNPX6EpGjpCDPOApFbPJoN8NXZR/Hm8aS60r8+rtJ4TZ8Iu0e08szN6fIz13G4hbKXl2RFtMAfO0vT2nANDxLHdvNBtu3gKIfN8pBCmsVBQ/VHpZwu9yXzAAB5fvrfzAp5L+YufdUdgwIvs+y9k3tJi0Nwwc21g6gYdLMR1srLKow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11730
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e2b150d6-bfc1-4819-24a7-08de8e68139f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|35042699022|36860700016|14060799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: k76wVRfthEJv6a59uoshNsPp7kymTscCkk2JLJeRgMKQMjtWlPQVEE6d9dQS+nGSHc0/K1K/sQbuRTlQPTt5q03xL1jHKq9vhottwca6zYKyj6n4Pe5DCpkvVe3bU+ePUosnwLhdUDjcW1L5guBlfAxkCnMV6eU1/zS/zwsVl5IghwLZa94hKG687zL2EU0OBv+S06r3gFkjdu1F+Q+QVJn/+FrFpXVC64J+kprApz2KE2YIDMIY6aqlT77bSy1qnavNJPBU+rD/GibBtsu/3vk6cFyYctz9AM9pS5oLKOGIrERyU92m7IN7T2xqomU26jvwTFFkDh18tz4vZS1RyCxHyx+H3ANe0B/FrC5wed1HNX3X/YyMRRZxEEMwZ9gvOwAXchqtgBufHxcXm33tLc9YCBK6jbt/w/2iZAOFKPFu5m/f4+8WTYTR+zLxzpSpZBQSJTbvDnxRMf7qDIEXKWORDPEelGWZhV502AGo2io/4GBNBnKlDU2y7kFxF5AZsX4aCIJnfOQbpd3gtPZ5GsaxC5Hf8niKrn23LYT6Z6/ttwVG3G57LYSSL74gRCoGdXXtWFaIPvkB2fR/wwc+lmU3tekfHl8U8XQPH8Eiah73Bw01v7g1kyzQr0Ji0opGGh0zorULwj3APje8eAFY2t+MMCzuP9Jsc5dGnN/Wwy7WHk/YK8YPz5bLBqBTFTcMi2+3zBOs5GrjyPkHJUkTbzMuWChSdsoNDI8XqoTLZwIp4BDszuGuSiP/LQiw/ZhUh/5tVJ3iqWKda9W02INNGA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(35042699022)(36860700016)(14060799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kPyFzFj6R6yyG5Nx1Cvcen28WJ6OkCJyR5Hvx/nYu3LYStH/ORZOtJUnKLEjcgsFFrqfxKM6dk639AVGEY313tlMkujhU3ged9gPtw9YWbP/rS3o5KxkEdD61ssxumZpgqlSVGtxJYDGRPUgOV89tlR08zckM2mtLKMV03Ex6xbvVh/KV6V1dKyyFFV3mdKCZsTwXWAt5qiovUX+WwzwJ+2Fwi1FB7dj6Kwn9YHes498jfOwQd/SPL/1qZAlTuhNulRqE0M0olPVHomBhyxiMqVljm3SFQ8Ul5yTeFfny5uZ8b86dp0dbq/+WMNQegQv0BZUnzEBLfriEnNfKc0WWdfK7njAPEgWD+OZGcJeTqrj/gNmKogWtS+tJYT9neUHayQy/Mc9XbPXKPzmpO1FLQhUapSmKvQ2BIBeVweTB6+w1OsT9F12+ky2UoZcbCwx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:25:44.1117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c94aba3-fc6d-45e8-558e-08de8e683a73
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9525
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



On 23/03/2026 20:52, Tom Rini wrote:
> The CMD_PXE functionality can only build with CMD_TFTPBOOT enabled (or
> we get undefined references to do_tftpb), so express this dependency in
> Kconfig.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Added to net-next, thanks!

-- 
Jerome

> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a90102b8cd73..1210e8b9dae0 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2313,7 +2313,7 @@ config WGET_BUILTIN_CACERT_PATH
>  config CMD_PXE
>  	bool "pxe"
>  	select PXE_UTILS
> -	imply CMD_TFTPBOOT
> +	select CMD_TFTPBOOT
>  	help
>  	  Boot image via network using PXE protocol
>  

