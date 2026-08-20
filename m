Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C13BC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 11:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E83160779;
	Thu, 20 Aug 2026 11:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXpk5ZyaAoYF; Thu, 20 Aug 2026 11:49:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787226588;
	bh=1kxyqoQCBkzzOGlFwDD6tIfkUBFpoWFh3qgtOEhyVNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEPbz+vGtkEkO3iJ4ZhUQgNNH50gXXazqZHi2pUU7FTmZMKLIyOyuAVf2M3UBLWPQ
	 0ckSnSA9PfG9TdvvBUJxbNLlnKBXCxevkJTbsA8Kq8ZDblnbEP2dAyR+8bm5ta0cqJ
	 uXeJ7jlQIp7zRYtvHWWoz1T0L+agO2uk7VGBET1k6spab9hajchNHGdnRc+wjY/tNm
	 hR+28c7Aj90sk1FqlBlfMeRSjFpvlYApe+6uvijXycsVj0JOPOCmaFiGcMB7t5XVBn
	 nnNuvMq1cTmpOMbZCCCJ820eZ6xnf2Hp3KtLKTeqCHEXHjv79I3dMhmkySnqV5xzPc
	 MECkthsgQTC/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35F3A6076A;
	Thu, 20 Aug 2026 11:49:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1080B39E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DCBC80CBD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfgousZqSBZu for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 11:49:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RRVpNvWD; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RRVpNvWD
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DF8280CA2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:49:43 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LUplhOLcwVZAkLGWTka/1Qmh6qPE7z23oz8NHwGKOLYbopI5FlOFG2yrmuAAHRGO7ABtBgozlw8Fbn4XtO4nj5bMZLs4G/m4hJ4Y3oEBJn4DdffUawRIednNy5qcpRiR523f9kb/TPvkHC0EcfAsWmdAI2n/DxbK/TCpIQj4sjZ02NZq7VtsnGXkhwjizcFxJZulo2S8wUYpu1aq293nznWJpkzg7AJuQKgxTjyl1rrulR4lqenahWJkvczbDxrTdgkLsD5j23Vk3Iv+JqDvln2E8ezMdJ9YGCj0Y3uESETso0BF2CVnODtM3te30XoFUe/pb0N5sL2XFG5NwdsHbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kxyqoQCBkzzOGlFwDD6tIfkUBFpoWFh3qgtOEhyVNM=;
 b=Nb1T9N8P1njOFH7kfgJxi6XnH4AkSJSTsew3m12o4LOlUSenuuXHzH0kUjV6G6mYJ+MaOl+Yh/z6aVxuRYO8MHIRfJHZL+U+190A1RV+MdK1WQVklX/389KuFbP6gQxKY+qmKQ/ai5kwdkE6aPCoUDd3NdBTGrScG2I8xoCm3IKW9zHLIO92ipDwny7hIEYSLtyLm/fZMZaFWcVJTDrz4umiVALpAYm2ZRmuv55OklbWHDlpPkhGvN4c3xMbgoQI1wVxyWKiEQpN8hb8AC2oF0BvLXTIrd39VttLFNoYtihBOxYkEIpr+N5NjWZ41iy+tPS+8NjRaR2G6hJ37HmbDw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kxyqoQCBkzzOGlFwDD6tIfkUBFpoWFh3qgtOEhyVNM=;
 b=RRVpNvWDrGpQXAkr4sIcg7bG52g01FJZH9xsAs+BxOrduW1LMlGI1Om6+ey3sgSVizMB+faSOx1wNNqMPUzC99Ihn9RHML8IBylEjIhGkiVs6BBzvDE7vUDhRGi8U/GbjLdrHtvQ+XXOtUd/iNwhai8RnxkkubVptbweeTbLpXY=
Received: from AM9P195CA0030.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::35)
 by AS8PR08MB7355.eurprd08.prod.outlook.com (2603:10a6:20b:446::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:49:36 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:21f:cafe::5a) by AM9P195CA0030.outlook.office365.com
 (2603:10a6:20b:21f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 11:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Thu, 20 Aug 2026 11:49:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtZxGL5GY10Iqv40BaEFkfnZ0SZpIt86qwBDjZb0/HVZExZ+00pxgFwetepZhYcknQ+MkRr3Ws7oOtnRUQgWXpJNm/1rcQXQ5fnDU5Ye5zRrhJtRabAJUPGnK9+CZ3vwDtKIpkjTKjVFYWwOZgsuqPfxPrrBpMxJyOrFi3c2walFa8R+yIylPfzFo/aR4sLyuLIMGYsd5HMu4Zv3bOrvfTuS/0HNAsdCLTM9uApnSaX1pp0FCKgdCMH27khNMk99LIvzMBicnh4ObI5KEzB9tH3qvMcfsuCKGAVB2l5xyAoU5mKKimPKnnyRMFRuwZaitfFZfmhxeVjlywla2cAeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kxyqoQCBkzzOGlFwDD6tIfkUBFpoWFh3qgtOEhyVNM=;
 b=crqQfC9mAPjvjY3AkIkJWkx6ohke0zg0B/KAabY8UIQ/GBg/VdfHBuTRR7kU6MmtnFhTvmuWtgHimz4LfazluT3AkDBDVOAmGzgcQ2qsjABStsk3mNl4+a0ZejejasPgPtttARzka/ozfxtxIU3BEnHVN1Wk/06tozsK10XzhNAt5fyKMZ560Z4reCZYzYguVSel6NVpT5k+oKxxeP4pdi4i+9RxopnRsakL8r5JDGI7bvtST3VxJttCvyGuueicplUolXyhZ/m0SskpbjT7VFqR6jwOMZMJuMJdxgSQaYln57wmdh5k5mhUFv3KUBtuMQ8Dth+nL745dSLB7f6uyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kxyqoQCBkzzOGlFwDD6tIfkUBFpoWFh3qgtOEhyVNM=;
 b=RRVpNvWDrGpQXAkr4sIcg7bG52g01FJZH9xsAs+BxOrduW1LMlGI1Om6+ey3sgSVizMB+faSOx1wNNqMPUzC99Ihn9RHML8IBylEjIhGkiVs6BBzvDE7vUDhRGi8U/GbjLdrHtvQ+XXOtUd/iNwhai8RnxkkubVptbweeTbLpXY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB6437.eurprd08.prod.outlook.com
 (2603:10a6:20b:33b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 11:49:03 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 11:49:03 +0000
Message-ID: <a39db98b-50b7-4d4e-9d1d-84d94f9b52e6@arm.com>
Date: Thu, 20 Aug 2026 13:49:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: bootp: bound DHCP option parsing by the received
 packet length
To: Pranav Rajendran <pranavkasthuri@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, nd <nd@arm.com>
References: <20260815220817.11754-1-pranavkasthuri@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260815220817.11754-1-pranavkasthuri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB6437:EE_|AMS0EPF000001A2:EE_|AS8PR08MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 49163f0e-aeda-4e9e-0d7a-08defeb11c30
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info-Original: 7jFOOFc3p5p+lrwqiaTgaaxYytzKR7FHoRyGZ8S5a2l7WnEXNpT904RPepY2rsO2639+rzt7eKMd0wSvR/KeZbb7vHHxhqf4Mdb/Hz4UpboKfWxLWaGbG5t/lZ1+Wt6jB3pK/KuQDzDqtGR3w7K6Y++LRkWG0+LM/h09SE8QdDPVOAyySBj0ggmDvDo3SIFi9BdDlz6ZXVlhqLzIaPSXy0m0eXDjo2ud1zT7Y8c6gU0R+A+jrMm3lTHayi5vefbGOpIxAKDL04ua4O7jnF5+Ln7+IWY3fUwLKEA3SR88C7+C00uH0mCyq4VoYU2Qv9l0VmEgC8BA5nZ7hLGvsX+eC5iddYCgDUtzqkDOKn0Z/pDf+xdCHOxuI/4tPNY9S5ZFkfDTV7Y8aAze466Yu5nk8XHZCSpfOVrBouAT+g0rq12qfvgeS8YcEUsiv5V/ATi4+s+WJ/KLjQiJehXS1ObO/czIpSI0D445I3yEIRt5hRFL+eN153jtdqxt56E7yIzUlepH5HY+uboBZpFU/pbmOPDK4LfayvEFV+4Sa3xoaIqpu4BiNCdT08IHRnZ6aAV/DerukzTPbCRvTzkJes4iY0uqteplFZid1omdtl5Qr/cyw50HTvqSR4Fz2olXAC/OYtOnUU+li59GTAot70FfwWbwrxOn827y4KE6o6cQlf8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oNndQQJY3H+XZ+h0h7L6Te0sweNF95/7dds67B3CAPOdFXskN1crXOYRVpuBgGTjU6I+/7TPwDukPWHdW0YYWaM/gsE15KkXqlYM2KtuscLj8YUC4JFXXkyysWM750BTS8+hJvLS0TmJmaku6l8ix2QLZcSD8Tg4TwA7eiTzq/jaSbL0m/rFQUOUreedVbU1jjq+MhEX2bZhAlmNvylRMdJwco0ncqQJfDW0O9FJPW5hbawo23TozyA1ptKZp9gBeK67gUXQ7xwqFncmQD4v1erzfw1wy+rWoCUOqYc3Fa54qmQZ38R3kigmYNK7JpkMUD7vb/7Q1KLhY+VoUvWy0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6437
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 366ad38c-c53e-4149-4b10-08defeb1086b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|35042699022|14060799003|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 01jKUyMIX19kW+eWbCaN665k7sdQtOZoPIZ2+ZiGvRh9ajS6eydjp3Jc+CQvESQbVSz3ymP/p+ewToytq60vq4VtTd6dqtsn9TNBkpeIoJXIQVdghcEqPdEsndO8uHaHvxClCgAOyqkx0DaaBLzfGEQw9Qpy6klTuBvZH83fS/MGhnbLuIIheNGMLbh8e/6t2u+okxK6MeLQhUvZ6Ung/bUov5Xi/fTgP09x7BK1H8VMj3yq8V/CLkRNeDKn8Jq11rsN2rvvv+qG1SEINgxF/7dsMXxqjLiUbNz5axhuqcz9UGPkIfO/IgahX9WV+cmwA6GgHXSg42ZpzhusJsW1za8u/dS4M8Cy8OzaBlvyVPVFeV7oOddhsEbEDt2wfd9RH90fQ2x3exwUf/YoDI+HOgm4tOYsYzLetNKHHXhkY79ZeeeOvrhF+EvQVsb8gHXiYNbPEF2VRKsXJ1Pp2kganXpPG4IbvIR181HBjXyLjWwObLKtK+8auPIO7ICpWrQMW9pRXOeWhPnXvEZM0p74N0WT54YZ7lbV88lx7JKm9/fRPQ1OR5RPoIIBH9lEPW/eDX9YZMkm2muOMRMIxvu25LGqiPYRZf4wizImzUexiQsAHnmrJD3QRTMO6foi8hF03vCf3XrJoh3AFi3cQGyTIt/ka8umM+RJ29dgl7xNARmnWYXIVx2HW/ttutltDClAgdB/UgEjWFgygyJCXBVuew==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(35042699022)(14060799003)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gjPEeTAyriWbgX6IzBB+xYSReW2T1HI4bvylxu1aAqY0yPPPCAG7NxHgFzJCoMPHH3bJRD4JLJQVyTjrTnsdYQvTLgfAX8z9kyVvqelftIxmkvIlhd4KgRn9C26qu0zkIQn5nWV8FrtWe7TwTZX+714MrlPvIxFnscEIT4gJhheP+0auVdiaS5TmPemu9+Rb4QKLPje4nnMIdGzPdehgmQaQTd0ySi8SbnqTk6m6nRb0pWcykXh8azIwxi1L+DhsJQvhsFfbYmoS75OQfY8IX0hwdiAtVXZhfN6wgt4+JaYY7Irgkbf1X40AWh5L52q/tXJrv0PtgBe9DOavRiwUGV5y9se70D0Y0Gyo8hp5FpNKY26SqFdhxqvYYVt3DaZGKXnNtAL0ltPrKCGu0pe8SW+HR2Rw1J0I0Q+2eGjdTeNORqXAThyINiFL5LZCcSSM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 11:49:36.7824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49163f0e-aeda-4e9e-0d7a-08defeb11c30
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7355
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

Hi Pranav,

On 16/08/2026 00:08, Pranav Rajendran wrote:
> dhcp_packet_process_options() derives the end of the option area from
> BOOTP_HDR_SIZE, a compile-time constant, rather than from the length of
> the packet that was actually received:
> 
> 	uchar *popt = (uchar *)&bp->bp_vend[4];
> 	uchar *end = popt + BOOTP_HDR_SIZE;
> 
> Since popt already starts near the end of the header, 'end' lands
> sizeof(struct bootp_hdr) bytes beyond it, so a short reply leaves
> dhcp_process_options() walking off the end of the received data and
> into whatever the receive buffer held before - typically the remains of
> earlier packets.
> 
> That is not only a disclosure: the options found there are acted on
> like any others, so stale bytes that happen to parse as an option can
> influence the boot file name, the DNS server or the root path.
> 
> The BOOTP path already gets this right and passes the real length to
> bootp_process_vendor(), and both callers here have the length in scope
> - they hand it to dhcp_message_type() on the lines above. Pass it in
> and use it as the limit. The overloaded 'file' and 'sname' areas are
> clamped the same way, as a truncated packet need not contain them
> either.
> 
> Fixes: 774c3e05ec0a ("net: parse DHCP options from overloaded file/sname fields")
> Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
> ---
>  net/bootp.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bootp.c b/net/bootp.c
> index f0dc329d6e4..fdedecb3f50 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -968,32 +968,43 @@ static void dhcp_process_options(uchar *popt, uchar *end)
>  	}
>  }
>  
> -static void dhcp_packet_process_options(struct bootp_hdr *bp)
> +static void dhcp_packet_process_options(struct bootp_hdr *bp, unsigned int len)
>  {
> -	uchar *popt = (uchar *)&bp->bp_vend[4];
> -	uchar *end = popt + BOOTP_HDR_SIZE;
> +	uchar *pkt_end = (uchar *)bp + len;
> +	uchar *popt, *end;
> +
> +	if (len < offsetof(struct bootp_hdr, bp_vend) + 4)
> +		return;
>  
>  	if (net_read_u32((u32 *)&bp->bp_vend[0]) != htonl(BOOTP_VENDOR_MAGIC))
>  		return;
>  
> +	popt = (uchar *)&bp->bp_vend[4];
> +
>  	dhcp_option_overload = 0;
>  
>  	/*
>  	 * The 'options' field MUST be interpreted first, 'file' next,
>  	 * 'sname' last.
>  	 */
> -	dhcp_process_options(popt, end);
> +	dhcp_process_options(popt, pkt_end);

This fixes the outer bound, but I don't think it is sufficient to make the parser
safe for truncated packets.

dhcp_process_options() currently starts with:

	while (popt < end && *popt != 0xff) {
		oplen = *(popt + 1);

If the received packet ends with a single option code byte, popt < end is true but
popt + 1 is already out of bounds.

There is also no validation that the complete option payload is present before the
switch processes it.

So I think a prerequisite patch is needed to fix dhcp_process_options() first.

Thanks,
-- 
Jerome

>  
>  	if (dhcp_option_overload & OVERLOAD_FILE) {
>  		popt = (uchar *)bp->bp_file;
>  		end = popt + sizeof(bp->bp_file);
> -		dhcp_process_options(popt, end);
> +		if (end > pkt_end)
> +			end = pkt_end;
> +		if (popt < end)
> +			dhcp_process_options(popt, end);
>  	}
>  
>  	if (dhcp_option_overload & OVERLOAD_SNAME) {
>  		popt = (uchar *)bp->bp_sname;
>  		end = popt + sizeof(bp->bp_sname);
> -		dhcp_process_options(popt, end);
> +		if (end > pkt_end)
> +			end = pkt_end;
> +		if (popt < end)
> +			dhcp_process_options(popt, end);
>  	}
>  }
>  
> @@ -1124,7 +1135,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  				debug("got BOOTP response; transitioning to BOUND\n");
>  				goto dhcp_got_bootp;
>  			}
> -			dhcp_packet_process_options(bp);
> +			dhcp_packet_process_options(bp, len);
>  			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
>  			    IS_ENABLED(CONFIG_NETDEVICES))
>  				efi_net_set_dhcp_ack(pkt, len);
> @@ -1151,7 +1162,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>  
>  		if (dhcp_message_type((u8 *)bp->bp_vend, (u8 *)pkt + len) == DHCP_ACK) {
>  dhcp_got_bootp:
> -			dhcp_packet_process_options(bp);
> +			dhcp_packet_process_options(bp, len);
>  			/* Store net params from reply */
>  			store_net_params(bp);
>  			dhcp_state = BOUND;

