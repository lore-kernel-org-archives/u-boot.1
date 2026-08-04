Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E45C55172
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 08:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BD9C80C21;
	Tue,  4 Aug 2026 08:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqiYQHy47mEM; Tue,  4 Aug 2026 08:54:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 115DB80A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785833696;
	bh=QQk/SwX+5xB6JJ01hfGPSnD7eIyHEsdFNYg2R6ayetk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nkIkN0STK64BgWWQY+gqYzfj9VurP4UG9C3kol7fvqsx73V73nm5TT51QhtqopPQJ
	 11J2H4UV0WfJjSBw6iNv+N8629F7UKxFtMy6SdpfdktWaaxCrvXExajNWnAhEs3WN0
	 ADgtnUitUJJesWCDaU1TWzfQvU3TsqGVZXe0rx77mj0+ADxQu30U1mCDq9kIZ0KcGm
	 B+r6l1bJdzkPjK+HQ0M4j5TmdVmLEoudm/7DoGQCxobYXEa26i37xFP6SSsjjdrT/L
	 sKGs2M0QWo/jexPIw21kMhekuJ2He1xMIus33TXqt6UkTNbBPzi92oMS1GrTYNJwRG
	 Zxb+Y6whoIHXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115DB80A91;
	Tue,  4 Aug 2026 08:54:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D15D23F
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4204A4004D
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UgXKIxPW5EZb for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 08:54:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CEF4A4002B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEF4A4002B
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CEF4A4002B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 08:54:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=MBEkvyvCAeNRmmXMG2IA6s9TRzNo0G8tlV/yKZtP0arTQN/xGCF6VykOJ74RhOlP/CLGonZNTQjVjcWRyyGqv79DMEYWEw80BLCey842yJVmAsEzxkQI2mwRRWr3//ga2bvdNP90u5JjZTtn/UikK6Py/BYVC+Yv3mwuuqK9jB65F4TGIxDjG2LCM2WiGLycR+cNW2dNyhEDZWOduGvpNVj7f2HjAJ7cvC03RqiyTDniauEEtgeuXVWOTic+FA9Fqlvjkbz5BKARuNgGXTYdOJhz9DoU1JG4nxyje8MlsipNEL8bDTLhso7xYp/ISEEfcMiVnN25ckmGMDypCymZYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQk/SwX+5xB6JJ01hfGPSnD7eIyHEsdFNYg2R6ayetk=;
 b=kEqgs47YbknEeWNrfxu/9B3dtJebxVRuAgVUJBSg+8s9P+QMSiMSVqHYk+DPQbeFJIUMUQJLAa+ixsa1bPB7PoRODVmko1ExGpfvNVextYv5dizSJV4s3ZJ2YF3pzDaS3u98VIY+O9YzYIdcuR9YTYonFZ1dy5iROm8/ktdMyhXHC8ETje9fuPLIW5ADvO0KDNpkHAnHwAzfUMGSL8QD8ol2HR68usOG6GZwi2d8bmeLuQ6ZDn6IRAr31zzmHyJo9YuRwD3FC2h+eUEm81ICSwJHAfGZ8iJ2C2pvcisGgnnOCL0x7VUgXmc8kHftikb+GUnilqNK4WU/NyV/hPp/FQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS9PR06CA0665.eurprd06.prod.outlook.com (2603:10a6:20b:49c::10)
 by VI0PR08MB10780.eurprd08.prod.outlook.com (2603:10a6:800:204::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 08:54:44 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:49c:cafe::e) by AS9PR06CA0665.outlook.office365.com
 (2603:10a6:20b:49c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 08:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Tue, 4 Aug 2026 08:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKmp1NH83c1fsXeEsJHoyuJ5LcFnyam03FqU6ioazHdGzN8rokDKX4TxQUa9n3Kt16gy+xNjzBjhe0uex1HcabT+fN0GQN89cdWydYdarosvY+/+6FPZQvwh7SnoIF21uRAviPXxX78URlGjyC1CLWDZA7eKRiV37EhrD8EmWr9NrjSkK1CJBKI1hITNxK9vnkV0qvp8+YGZIUchPlhD0GGVhhm7wCf4D4JKuzuNNid5ysu+rseEyDW144PopuNBBQjTRDp7jWISyVwck08YInox7q34rXZp9n83XvMozWpre7ryVOkm/cReF4C9kXMnTjkCt7AgBtniy9H11kjY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQk/SwX+5xB6JJ01hfGPSnD7eIyHEsdFNYg2R6ayetk=;
 b=efiySAf2mWKfJV1GL5XDvOFSW/NRgpJMKwyI/Z7lqJU9GF4BkrHs95JecOiL01q0OuFN+6a3PtKoCUxt5vEUl/Yzc2rQP4SYOVUnMNwBw3BeE5lfUGQ+eNwpcMoUv/sICYbPK2DdjdDphXtQPx5tqwutTew5ioDdH396wRVBP2JE3FM+jsEPc/hq2pOENXlJNpNJbaVRztKW/V1ChZZ/W85+E94Dafi8Ed4NZy393InYu0M1LvkaN1R0iAbGLhUsUgt91sQmeQudS+mjERaHGXK6zvurzvBTtUFCNwh5+K/BihqjjOHciWiOj4oCD5ugQe8hiZRdzs27nDnI+5H7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by FRZPR08MB10952.eurprd08.prod.outlook.com
 (2603:10a6:d10:137::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:54:11 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:54:11 +0000
Message-ID: <a5abb796-bb57-411e-95db-fd85c62308aa@arm.com>
Date: Tue, 4 Aug 2026 10:54:10 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH next v1] net: rtl8169: add support for RTL8126A and
 RTL8127A
To: trini@konsulko.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 Javen <javen_xu@realsil.com.cn>
Cc: u-boot@lists.u-boot-project.org, nd@arm.com
References: <20260722075058.324-1-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260722075058.324-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0380.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|FRZPR08MB10952:EE_|AM3PEPF0000A792:EE_|VI0PR08MB10780:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf0fcad-8416-4dbe-edac-08def2060739
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: aLsGXAAJ5TT5tLooIUAEiEfmia8xZCxYPV2k8myajnlJk8W136csPSFQ+8y8HouJcBRi1H8Y9PTXN/Q7EMl8yrLfgr0hUP6u793FJm10QQ7kG6DgbJAq4CHPDMavddKYGcAlieDSHHo7EGsB5GqbiVdOHuGNqI6sAuzVi+EHsw4ROUG3qTnXv/TEgv8HS88APOQzXCu8RCmN4K8AmMNWb+oYp7O3loMgt/eETfPRHg3gYWVvddwf1K4PtWpwkhwWwoZ9e9nIwJXkw58sxEPdZwTtVi1VZK9jHIMVkZjDXMYf6lntvY2d18j6Gb7dhZGtBUrqYlCC+PBlVVdJEKcb8rqgxb00wjU/4WOO5L2Yw4XXGNx5K62wV4TjpUpEDVZ+Q/wWGJbdQ7sYb6kaWV7Bt8Ukg1N5S57IrYLNjiX7kJdRWPfb5uWC6XJPOvgjv6Ym5mqkWsNvans6PRaUy/4sO0QwziGB8roTj2ehC9umJ5njoWVXUZuF4xAJiRYdqtktKWDjAw+acJewJXHAhsT8Y2lA4O2wh8AizTSdbd90qawGy9Akebf61+pWWNsnA/mU6+RijxWa6Ds+h2Fc5x7ISsTFedTYCO7bNwCugpjiwB7uDEu/fdxsWjbTHwD0rAHmjbFEDYf4UGn2u4PJFeRgoBbGe5ENVBX6v6tUMC2mlmg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: iWSN+IvOlqLp+RWJm5OgNBUhqqUxDXWf4hQktHyr7hFQ77ujWd+3fda8p4wpzfNebukFERI85xzL2P4+Fk5flvd2C76pe51J/anNw+Dh7tJxsxhgkp2r01vY4mU3jHScy/XCfOEgs3jyNWIo82OkEiUd2pogT+r7p/IhoLJ47B1Vqx8KR+/pEOPcO468a1ymfzLyiAHbvWU+TY2aT6bz4w/Ut95zcpSvnqIWfEs7cDOFq8IY7ZyFCyNg5U8E2c8xEfPbKjFGpTtUFoy7UA9efx2jP5B9AI5gPyUDcMNAIMevb2V5u9mp9A53kCmg6o6Ou/I3dwyv7v8uB7o0swHk5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB10952
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7e92b139-2a4d-463e-ca71-08def205f3a1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|35042699022|376014|23010399003|14060799003|1800799024|82310400026|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MA2rdTz95eLlFcNv9/27+rBf3PQtNGEmqE9uNuyLFYSQ9RsKFSm154FDxTc3yD5jKlBgQwD2SCZRdGCkxQved8uKucVQlxdcpZbjoJ2gq0Jjp7SjNSm13B81bjE2YgrKWFXeC9ZB2ltj90tjdjPU0yDPZo0ZFV/Qt/iGeEu0uZgOj72jO2QoV5WbmZFtxLVV7sRme/lvalg3B596V5ckd9EBpnAofBJsrYnVgBps/M6P+VfWPgg/Xh52fUKABT8TBl19aeDcyqkapHfNR9HCySJtEe7PjP8M4i0iVt7Odod7y8JQgNjhOMbUOaxvo5YUrMtUBzhboT6sG8c6a7a9mdP4AN/ZQJT9p/DvW0GLh4ri2JrJ9kymd0gYuD/ldfPEfeThudNCw9wwpkstrSXqSyzuutPaaw9l6T9sB9PqDZjqEQD/6cr3cKbffWcLgnWk/QIc2WrXa5I4aX5S9gGWluHxY+hsqCPB4OEli24Ipwol5K085B19QIVIGvr9ccn7lrRNSADnXuSJ2jeTAQX5y3/ViHAVTP8Al3AY/eEbd/eZZpg5m4dXGR2/YK17SibyHXfuwCVkcNEb0A6yJU1TOtEBTuvIYlaAybasjW5mPzshzA6EdZ3DHP5YicI0wtLKaEv2Ew8+o6gJZtS9qRQfeXsrBhJ2FjGSlPYZ4EpjL8EcjDD5R1SJeQVQnErYK5dx4acPwDREQ+tSXk+KaDo0Og==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(35042699022)(376014)(23010399003)(14060799003)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WVxEJBaJ39GkuZwrEMNkjN/awCkKakVAihgoxN7qTc9KTT1W1/6DTheRwLt4doO1vLgKNS9fcebnpi/tHmfOXV/xdvNLcf1NzBM88OkQtyGCTlX+Hw/uSesoi+1bbt90ybHhrpz+nNI2o7jcTuUMdDgQYhS1Lgu6dY9tmpiVhwJszIl0LHn/Qq4rc5QPQHoyCwcq7F+mBlvTZV3pBKq/D8zQcBGTBuZwaedqGHxlFTla7UVBzenpY206wrLxTiL9PdV1UnNwqqY/HB/T1kRuGepe1pIBPzKUWfWKfNTnYWITDtuQT5KGx0/0Nu1qRDEOxjWRGCKW/5tR8iARxULfK5rTtHyiwRC9G8w6Vu1cbmYd5nvYkRgZpnYQoxgJh2C3mQWandkofUaCAurCQXAcQuxJ6uJvb3J24+B6aTbaMmoYSRw76kGx67ry/quWanst
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:54:43.7235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf0fcad-8416-4dbe-edac-08def2060739
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10780
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQk/SwX+5xB6JJ01hfGPSnD7eIyHEsdFNYg2R6ayetk=;
 b=l/fvBDk6A5OBTKcV+MOVILEMAEGCC7myIZf6lIZWV6WLl6od7lOEFYOzkkuytbHQ3ZfM8WETg+lLrXCRbFqVF0KVcgqLcjspVJJhqez8IwVgFgGVnH/OkXlReNLYTx8VX5VsLFrgnlLsFqOlulTBtAIDXIvL4mW3TftpFxOG1PE=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQk/SwX+5xB6JJ01hfGPSnD7eIyHEsdFNYg2R6ayetk=;
 b=l/fvBDk6A5OBTKcV+MOVILEMAEGCC7myIZf6lIZWV6WLl6od7lOEFYOzkkuytbHQ3ZfM8WETg+lLrXCRbFqVF0KVcgqLcjspVJJhqez8IwVgFgGVnH/OkXlReNLYTx8VX5VsLFrgnlLsFqOlulTBtAIDXIvL4mW3TftpFxOG1PE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=l/fvBDk6; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=l/fvBDk6
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

On Wed, 22 Jul 2026 15:50:57 +0800, Javen wrote:
> RTL8126A and RTL8127A share most of the register layouts and quirks with
> RTL8125 series, but require explicit desc type and CRC-drop setup during
> init.
> 
> This patch adds PCI IDs and MAC versions. RTL8126A is 0x66 and RTL8127A
> is 0x6e. And RTL8127A requires Tx Desc V3 format and an additional RADM
> FIFO protection configuration according to vendor driver.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] net: rtl8169: add support for RTL8126A and RTL8127A
      commit: a1aaacc968ae995b7557a316907c2e2f073b1a17

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

