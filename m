Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42254C55184
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F291C40527;
	Mon,  3 Aug 2026 12:46:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3FpkvYaKTkbJ; Mon,  3 Aug 2026 12:46:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A21C40293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785761164;
	bh=ge7w6Nb1V6FqY2IsMUB/UiQ++Agog/YPidU6nZjij3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AjwXFtXnjmDjea2U94d3fRoW3wqPjTlHOnDiXMSra7kvjAbdIIV9KoHzvfGCDgxD3
	 3tEYhe2TKWX3dRP1X6RtTza9A9pgUWDe3JfXzNZcPeLJqSP7nsnd8kspHA1OH8L0ns
	 V9Gsxiv/+6BlJ1EAMmCs4WZsNj+4Gm0aa9bqPpUSMDD4r1HHCYlOWffrUAtisIwIpT
	 30CCjHtWtXYDw1xv2MOopvwXRV529/vddiMwfhgseh1D+aiUreQExC0hZXqmdXbt3q
	 hC6iXW1xQ6gx9CmLm9K624H9WaAzVOVS8KJe5FEmhzGTzyWFsMocHzjk/Vn07W6yIT
	 kGzuvfev3EGYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A21C40293;
	Mon,  3 Aug 2026 12:46:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01CA4389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBDEE60703
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rqDC3qxcV4UG for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:46:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2EEDF605DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EEDF605DB
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EEDF605DB
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:45:59 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=agu/mUly/dTSb048sXnHUcElZ6QA5MGCrcNCXkB7KttgAgt5BnBpYMuaaFQqf+fGcM9gKPfRqwNvBaoz6vxpEgrhXJN+30XtwuMb9ungpHFNnw6gEYV1YApaxgZw6v7AcmNzD1Y8Lh+uXhmU/cHdCQl2IydIWZtgsO7/nBEt3iRwtes2I0pZEwiDPc5Hgsvq5WdluSnt4CVrx5vZhkGp+u9G26UQ2+zEOGk4pBv5goDEbd7crXuhzfXBxvS61kXcmU+UeyvE2bNuHB9NfRxKfBqn/8fdB4z/08CHocvQj0bJGpfCEa+Es6Gaxc/wB5sueONBZjqZBAX/jRRQ5pXzYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge7w6Nb1V6FqY2IsMUB/UiQ++Agog/YPidU6nZjij3w=;
 b=g0djRDVfloUsOlJcyfyIPHcVRidGRrEGADlH3XIdZxDZ16HKWULfei3LaMbeNio/Q45yUTxn8O6qZabnvL/6ZwmjYdohNxKOD+CcREFwOBzxeFwo1N30kwt9bfsCJAZkMWYHf6B5XRRnID6Kn1ffrU3Owbzj5Q9eFI5xplZqzOpv1S15FyAHfuREXx+t6afwCyx1owisPm7Wjjxwd0mk2e3Pqr3L28kqq094WL+YkMxn9d+nFnvp789iT6yp0Llplt2bSzn7GWOxp74zmXfSlGVAl5NGcIOrpY+wSQGPbrK5+EhC6/hUv+80pIkdQiDt+R9OErWYs0kIT5TI8PVWQg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=realsil.com.cn smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AM9P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::14)
 by AS2PR08MB9341.eurprd08.prod.outlook.com (2603:10a6:20b:59a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:45:47 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:21d:cafe::2b) by AM9P192CA0009.outlook.office365.com
 (2603:10a6:20b:21d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 12:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Mon, 3 Aug 2026 12:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vC2SWVM10u0+x1e7Dvgd+6h0VardN+U8m4p7xYbrSNXxiCQB5EVgIsluXVJtwh2078ggmks0tptRqwcIbl5NLwDFH37oRGcZvuzmB7Gj9IGi6S3hZBozPt2Spida/iA1owFFUcTXtnLKnaXxiaWXkTX/azs80v6emGClBWFu6ox7gWhLgjZXJxa5o/e3DAtO5Yy7PF+CASSW0mPjtxRzYPtns4dVWO6MdskeOehaBV4gCZZ17c9VY3M/RtYRoEeYZyoO7RdN8Q1xW2fvzwcbhyqa3X+uebnCwGMWdYkQH8vdoMu18Wq6B1c2OJ+Ee7fOhmABqp0Z1OJnyLY3tVy1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ge7w6Nb1V6FqY2IsMUB/UiQ++Agog/YPidU6nZjij3w=;
 b=ZPax6hjuf1NypYP+EBfZs6DJaT6sx5yH21qicExo+dycxQKJUcqFONUGmjVFmto+3aml2oUYU+WFoIc1ey8we6BRXKEqGrOuMKKYTTyasez6F0snGDY/Ml54qkuzmeI5x9KBEya0bOKKnJc3cAte2v6slYgeLHbpdN9Rh9lEXM++if1T+zsUZFlJXiPS2YjnJBXV1SCw1textClQz3Ox86SBhXKhd5F0bjgiMMVBbOohH6M37QXoO6Rl1M2dJiIqvT+usZD0twMVrmKy3AUc7lMGvm82TfvrMSG3jAR9bGv5Pt4ohW+C+q6KKD5dha5k36bxzCfyoXOl15U7tzqGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB11314.eurprd08.prod.outlook.com
 (2603:10a6:150:2c8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 12:45:12 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 12:45:10 +0000
Message-ID: <e6f9fad1-5d68-4b21-9199-f28dfb783b29@arm.com>
Date: Mon, 3 Aug 2026 14:45:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v1] net: rtl8169: add support for RTL8126A and
 RTL8127A
To: Javen <javen_xu@realsil.com.cn>, "trini@konsulko.com"
 <trini@konsulko.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "nd@arm.com" <nd@arm.com>
References: <20260722075058.324-1-javen_xu@realsil.com.cn>
 <cf2dfc40c79047618b42324f5b452932@realsil.com.cn>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <cf2dfc40c79047618b42324f5b452932@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0201.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB11314:EE_|AMS0EPF000001A5:EE_|AS2PR08MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb2fad9-97f3-464a-8d0d-08def15d23b9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|56012099006|5023799004|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: sVew19UwG4CA25G1YORo3HZZWhBpZb2yyIns5LZ+hKzribK3gbBLMw8poDZJLuzYiPOqs28zbKtZnBBQ+vs9ZR/Jv/gLsGAooD2U1TrK17ey6LMrbtnWjzZYRMnyWL0U4XlQJVeBXSNY4Je0Ktob0TYeaC/X0x6VCUKDRrhcyZfze3aNCkU2kAbCmpleUcVx09BxvuT+YJqYVL5H2WYO9n1Hw2ty0bk24amaCkMay8kLA0S9wgy3sr5NcbsxK/hIEgj5m43W7qxe9ON47pHBgdbKcwzOFSbFPOwKQaNVKIoDkyLOsI2YdSMuq9uKHWbsDv3QO657TwRCyXCrtmTdibI6Wi9EegePyKopePKfa8ZkhwW1svAM+ZhLaWeDCNzvjMJVYC2fFvHznDjfPGfxRGjiMCRIwVcV+Ob4iVlty/LiEF7EXnYCBb3sNEUrMeGBC4bvtXKzgjCLQrcpEJKwHXtUJoW4nVxqONWkP3tdL+/saQErsfGyu1IJBbxelxzGu+ugnBM3gugF58PySGQjchPvLH6FMh4lF76olG8Sf+rXugRjjkFggPPUE4Ssg0Jc7MIprHzzfpcHwIJ9DUI8c5p7gN8hulTZe8vK3cj6cUFVgkyEnxmDfcOulVJwKMRpAZnE+IV6qNP8cLNdvJQe8L2CEsO6X+NruzqvI45wTAM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Lftu53UZer0ghebiQYgSk1yz3ycIxfycA9sAnBfM56FJbmAyOpYN4PvdIRJYpFpY34uIB2G/UtLWq2KqfILOlei02s2U1M47xTxZ4u+wZHfGQVOV7xc+36y5Vhn11zN1a7Z+j3LLLFas1gJAd8k8Tnw/8FUlh73urLHhW4DukaxVhGIhX746AHuW37AtXs8AKhiNh1Rk1Grrdn7/kAGAf6yh4cU+MthUmU4evuHlPKsuqsUvfl7bVgsRIdRsD24YEEty+m3x2fJm4b/+edtY4IbIHDFbQnDxkM5jT5B6xCiZWNv99N5TNOWjFaE2Dgvp+gcYyoXeVvVDQhAnTxE5tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11314
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6272efa1-87df-46f5-298b-08def15d0dca
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|23010399003|376014|36860700016|1800799024|14060799003|82310400026|22082099003|18002099003|5023799004|56012099006|4143699003|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: q5JDKKfgJky9H2El1pQIzDOJaFHP164YdlAdd+4ApA7y7dZnLwttshsCh6zmzN/yc4N2PiuZqAH/FFHqaPgQZmbWj9NCXJ0m1zrNmAekfiNWaJu5Q25cromK+ab2j23fGozKQ7jYCGEdLln1heoWJ2xPEiTs0C4i57PZJvfPV2N1tUQGd1rafsIm6Sia4/qAxwr9KyIywvgbaJRXG6veYacOaV4nJ1JPNT/kZmrEwcQebjeuPObyFZs+dJ8DF9Ko8mg0S94JXo8oUnxNnCO9XruhCqzbkDXimLdQXbb0YJ8Dv1Cn9CBGWwFlNnyZ5rmbuGpcpXorzkPMgZVRks+pauQ9c9cxEuW3U5ppyLtpLZWudCfYtdIOZZQS6vGNr4H7G3xubGEYK4YTz7eg6ABfbomHZKZ2ClltmE0gfBmNC+LGOwSnfFTHaruBphI/k82NAqXg2fiB4fygm75mP3/dwI1UFBYA9VxAs52/M43sSUxD0Mq561DvuTnWhSQhc0DF2bjHl4SdUJfCZ/zfISKoTjPqCZ+CB80QML76kV0cqbm+/fabmhxpP/s6jzYYVJZ7edWiNQyGXb2Js5Byzav+gKjsBdW0L6YzelDJ+dCI2iv7hJqmphQbSzon9zFlFIhyjXTVXZVKX6ip1PDYWbW6YwB2+tv5njZLK3WFQ912vpdr71m6n8mdpnWATR8IiEz6k6FhYXErhRSuI/ZZ4btKPA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(23010399003)(376014)(36860700016)(1800799024)(14060799003)(82310400026)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OQkBiico6bxuF9iekVrZHpS/ois21f8pFGApB3a6VPumDebQTrDGLRFkGQY8B4leBNUHkfeOuwZz52dxNTl4cnZQL5l60Quxl97MlbYSKriFiNkM1WH3vAWoRR8GASE+98ueY2XR63jkS0/lYmTONhtoj8xnZ690VC/ZDzAut0pcrdZs+bTuHwSu7BUVhtMKEUxOSVNGx6uspxGRQ4XBcVcklC4e2NA8FMgi2WMAZQ4ZEj7XkbKVBmebjJ34kyBmgJK3rDSTy9yxqwMNlVxthXiJPE3fKr5nNdGbg9XCLJamYXOBQ+Hj6QMfQQvaWx8rkMso1+GE/Gmv0ZzGaG+c6yP4R3QVwm4NZXBpz3hSVocuTHgdf/HLyAYg7+dtnSLrt/n0l/OMbTfee6Mab8XetyytGMybFft/wT/1qQjGGhWvZM1zt+jodbMTGmXvkvn6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 12:45:46.5783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb2fad9-97f3-464a-8d0d-08def15d23b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9341
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge7w6Nb1V6FqY2IsMUB/UiQ++Agog/YPidU6nZjij3w=;
 b=fcDXdF6jpphA/E4WKc74/rAyNAI6XbZK+2sbOq1GapRESDSI5VqCXrRiQsBYjjTQU14yVe6MxppmMx/+vEXr6zhG47b8h6JEHidakYBhI4i83pbDI89CdGb1xvjTPJ2orpkNlcfco/XLpCkp6GYaMSKobPl6v7VBX+YcOkMDpNo=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ge7w6Nb1V6FqY2IsMUB/UiQ++Agog/YPidU6nZjij3w=;
 b=fcDXdF6jpphA/E4WKc74/rAyNAI6XbZK+2sbOq1GapRESDSI5VqCXrRiQsBYjjTQU14yVe6MxppmMx/+vEXr6zhG47b8h6JEHidakYBhI4i83pbDI89CdGb1xvjTPJ2orpkNlcfco/XLpCkp6GYaMSKobPl6v7VBX+YcOkMDpNo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=fcDXdF6j; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=fcDXdF6j
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Javen,

On 29/07/2026 09:27, Javen wrote:
>> RTL8126A and RTL8127A share most of the register layouts and quirks with
>> RTL8125 series, but require explicit desc type and CRC-drop setup during init.
>>
>> This patch adds PCI IDs and MAC versions. RTL8126A is 0x66 and RTL8127A is
>> 0x6e. And RTL8127A requires Tx Desc V3 format and an additional RADM FIFO
>> protection configuration according to vendor driver.
>>
>> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
>> ---
>> drivers/net/rtl8169.c | 103 ++++++++++++++++++++++++++++++++++++++----
>> 1 file changed, 94 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c index
>> 5b093623619..a24cff97801 100644
>> --- a/drivers/net/rtl8169.c
>> +++ b/drivers/net/rtl8169.c
>> @@ -49,6 +49,7 @@
>> #include <asm/cache.h>
>> #include <asm/io.h>
>> #include <pci.h>
>> +#include <linux/bitops.h>
>> #include <linux/delay.h>
>> #include <linux/printk.h>
>>
>> @@ -152,8 +153,24 @@ enum RTL8125_registers {
>> 	IntrMask_8125 = 0x38,
>> 	IntrStatus_8125 = 0x3C,
>> 	TxPoll_8125 = 0x90,
>> +	RX_DESC_MODE = 0xd8,
>> +	MACOCP = 0xb0,
>> +	RADMFIFO_PROTECT = 0x0402,
>> +	TX_DESC_MODE = 0xeb58,
>> };
>>
>> +/* MAC OCP indirect access via the MACOCP register */
>> +#define RTL8125_OCP_WRITE	0x80000000
>> +#define RTL8125_OCP_ADDR_SHIFT	16
>> +#define RX_DESC_CRC_DROP	BIT(0)
>> +#define RX_DESC_TYPE		BIT(1)
>> +
>> +/* TX_DESC_MODE (MAC OCP 0xeb58): TX descriptor format select, bits [1:0]
>> */
>> +#define TX_DESC_FMT_MASK	GENMASK(1, 0)
>> +#define TX_DESC_FMT_STD		BIT(0)
>> +#define TX_DESC_FMT_V3		BIT(1)
>> +#define RX_PAUSE_SLOT_ON	BIT(11)
>> +
>> enum RTL8169_register_content {
>> 	/*InterruptStatusBits */
>> 	SYSErr = 0x8000,
>> @@ -271,6 +288,8 @@ static struct {
>> 	{"RTL-8168h/8111h",	0x54, 0xff7e1880,},
>> 	{"RTL-8125B",		0x64, 0xff7e1880,},
>> 	{"RTL-8125d",		0x6a, 0xff7e5880,},
>> +	{"RTL-8126A",		0x66, 0xff7e5880,},
>> +	{"RTL-8127A",		0x6e, 0xff7e5880,},
>> };
>>
>> enum _DescStatusBit {
>> @@ -355,6 +374,8 @@ static const unsigned int rtl8169_rx_config =
>>
>> static struct pci_device_id supported[] = {
>> 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8125) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8126) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8127) },
>> 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8161) },
>> 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8167) },
>> 	{ PCI_DEVICE(PCI_VENDOR_ID_REALTEK, 0x8168) }, @@ -398,6 +419,33
>> @@ int mdio_read(int RegAddr)
>> 	return value;
>> }
>>
>> +/* RTL8125/8126/8127 share the same register layout and quirks */
>> +static bool rtl_is_8125(struct pci_child_plat *pplat) {
>> +	return pplat->device == 0x8125 || pplat->device == 0x8126 ||
>> +	       pplat->device == 0x8127;
>> +}
>> +
>> +static void rtl_mac_ocp_write(u16 reg_addr, u16 value) {
>> +	u32 data32;
>> +
>> +	data32 = (u32)(reg_addr / 2) << RTL8125_OCP_ADDR_SHIFT;
>> +	data32 += value;
>> +	data32 |= RTL8125_OCP_WRITE;
>> +	RTL_W32(MACOCP, data32);
>> +}
>> +
>> +static u16 rtl_mac_ocp_read(u16 reg_addr) {
>> +	u32 data32;
>> +
>> +	data32 = (u32)(reg_addr / 2) << RTL8125_OCP_ADDR_SHIFT;
>> +	RTL_W32(MACOCP, data32);
>> +
>> +	return (u16)RTL_R32(MACOCP);
>> +}
>> +
>> static int rtl8169_init_board(unsigned long dev_iobase, const char *name)  {
>> 	int i;
>> @@ -571,12 +619,15 @@ static int rtl_recv_common(struct udevice *dev,
>> unsigned long dev_iobase,
>> 		return length;
>>
>> 	} else {
>> -		u32 IntrStatus = IntrStatus_8169;
>> +		u32 sts;
>>
>> -		if (pplat->device == 0x8125)
>> -			IntrStatus = IntrStatus_8125;
>> -		ushort sts = RTL_R8(IntrStatus);
>> -		RTL_W8(IntrStatus, sts & ~(TxErr | RxErr | SYSErr));
>> +		if (rtl_is_8125(pplat)) {
>> +			sts = RTL_R32(IntrStatus_8125);
>> +			RTL_W32(IntrStatus_8125, sts & ~(TxErr | RxErr |
>> SYSErr));
>> +		} else {
>> +			sts = RTL_R16(IntrStatus_8169);
>> +			RTL_W16(IntrStatus_8169, sts & ~(TxErr | RxErr |
>> SYSErr));
>> +		}
>> 		udelay(100);	/* wait */
>> 	}
>> 	tpc->cur_rx = cur_rx;
>> @@ -636,8 +687,8 @@ static int rtl_send_common(struct udevice *dev,
>> unsigned long dev_iobase,
>> 				    ((len > ETH_ZLEN) ? len : ETH_ZLEN));
>> 	}
>> 	rtl_flush_tx_desc(&tpc->TxDescArray[entry]);
>> -	if (pplat->device == 0x8125)
>> -		RTL_W8(TxPoll_8125, 0x1);	/* set polling bit */
>> +	if (rtl_is_8125(pplat))
>> +		RTL_W32(TxPoll_8125, 0x1);	/* set polling bit */
>> 	else
>> 		RTL_W8(TxPoll_8169, 0x40);	/* set polling bit */
>>
>> @@ -697,6 +748,8 @@ static void rtl8169_set_rx_mode(void)
>>
>> static void rtl8169_hw_start(struct udevice *dev)  {
>> +	u8 version = rtl_chip_info[tpc->chipset].version;
>> +	u16 tx_desc_mode;
>> 	u32 i;
>>
>> #ifdef DEBUG_RTL8169
>> @@ -719,6 +772,36 @@ static void rtl8169_hw_start(struct udevice *dev)
>>
>> 	RTL_W8(Cfg9346, Cfg9346_Unlock);
>>
>> +	/*
>> +	 * RTL8125D/8126A/8127A require explicit descriptor-type and CRC-
>> drop setup.
>> +	 * RTL8125B (0x64) is intentionally excluded to avoid regressing
>> working hardware.
>> +	 */
>> +	switch (version) {
>> +	case 0x6a:
>> +	case 0x66:
>> +	case 0x6e:
>> +		/* Reg 0xD8: Disable CRC drop and force legacy 16-byte RX
>> desc */
>> +		RTL_W8(RX_DESC_MODE, RTL_R8(RX_DESC_MODE) &
>> ~(RX_DESC_CRC_DROP |
>> +RX_DESC_TYPE));
>> +
>> +		/* RxConfig 0x44: enable RX pause slot (RTL8125B and later) */
>> +		RTL_W32(RxConfig, RTL_R32(RxConfig) | RX_PAUSE_SLOT_ON);
>> +
>> +		/* MAC OCP 0xEB58: TX descriptor format setup */
>> +		tx_desc_mode = rtl_mac_ocp_read(TX_DESC_MODE) &
>> ~TX_DESC_FMT_MASK;
>> +
>> +		if (version == 0x6e) {
>> +			/* RTL8127A specific: Tx desc V3 and RADM FIFO
>> protection */
>> +			rtl_mac_ocp_write(TX_DESC_MODE, tx_desc_mode |
>> TX_DESC_FMT_V3);
>> +			RTL_W16(RADMFIFO_PROTECT, 0x2001);
>> +		} else {
>> +			/* RTL8125D / RTL8126A specific: standard Tx desc */
>> +			rtl_mac_ocp_write(TX_DESC_MODE, tx_desc_mode |
>> TX_DESC_FMT_STD);
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> 	/* RTL-8169sb/8110sb or previous version */
>> 	if (tpc->chipset <= 5)
>> 		RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb); @@ -860,8
>> +943,8 @@ static void rtl_halt_common(struct udevice *dev)
>> 	RTL_W8(ChipCmd, 0x00);
>>
>> 	/* Disable interrupts by clearing the interrupt mask. */
>> -	if (pplat->device == 0x8125)
>> -		RTL_W16(IntrMask_8125, 0x0000);
>> +	if (rtl_is_8125(pplat))
>> +		RTL_W32(IntrMask_8125, 0x00000000);
>> 	else
>> 		RTL_W16(IntrMask_8169, 0x0000);
>>
>> @@ -1052,6 +1135,8 @@ static int rtl8169_eth_probe(struct udevice *dev)
>>
>> 	switch (pplat->device) {
>> 	case 0x8125:
>> +	case 0x8126:
>> +	case 0x8127:
>> 	case 0x8161:
>> 	case 0x8168:
>> 		region = 2;
>> --
>> 2.43.0
> 
> 
> Hi, all
> 
> Just a gentle ping for this patch.
> I am reaching out to see if any had a chance to review this patch. I wonder if there is anything I need to modify, clarify, or if I missed any submission guidelines. Thanks.

I don't know this driver nor the chips so I'm afraid I can't give useful
feedback. Can you please explain how you tested the change?

Thanks,
-- 
Jerome

