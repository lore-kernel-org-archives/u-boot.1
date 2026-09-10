Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE13C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 09:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1273540A96;
	Thu, 10 Sep 2026 09:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5c-CWHcntAdc; Thu, 10 Sep 2026 09:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1BCB840A8B
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789032648;
	b=p2T7q0l4dP1erq7huKbTvp4WddhPCwGe4RRuer6N2+s/MAu0GoDMCITGcRAcHVlRo6od
	 RvK4yFRpuMue8NGlmhE8DtVuDCp7UW9cu+ejFA0KeGdXWIJgXOX0LF8BgXSGWfm8Afhfr
	 dcKP7NlEtOKyYW/sqvpSec7SHovla6lHhM0hRYO5y3HXOl6xU/un0x8TkfYoqw0BoI/1d
	 7aMFNEHy8r6kQ7op4p0Uz02KTZAHfiPGEAtW8s2uPBoSDtEqLi8xienZlKi0qgjkQmvoH
	 At3cWFkibkmza0oxXtKE6ewvqPkXpbWZuprYLOUV5FobZ2wis2dswdrFIijkmbwxKqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789032648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 Authentication-Results-Original:x-ms-traffictypediagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2aY/cpjiIocAZ+aoPxmxktDo5eRuWBmfPe5V28UyrQ0=;
	b=gclupwbWxcIACuY9EzJTImrYhD0TPX5ru4kXS1glavgC4QKHjGI//Vy3I+ZvQX3rKGUW
	 PCsf/6CUITl7P8ZiFgyLO0gxZauwNzb/vfhzy+g09iQalB6KGIvjLhJoVErJau5EOiHnZ
	 e4akuo36gt4xXY6rzR8jmMy42hhe0prEC/7E0QS/HYqZJu2sJSkoa2r9vv24C0nC1fSbz
	 jDn+3HMDK1uP8RQuxyJnZqOxLPm17TaJBj4MO/zGFNvA2/8YXFKzPnzpgZCeGPm2pR/5Y
	 S0lQ8hHei+lgU2Cta2HQnxxhUYKOGysSSAhpA6z+DkOgFdRMmdxlzNQBlP5msGFgV2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789032648;
	bh=2aY/cpjiIocAZ+aoPxmxktDo5eRuWBmfPe5V28UyrQ0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sQgCHFAOZLCCZuFBxVvaOkaCPruGS1W3g4IyjmcVr1JdeZ0FKTGyoeP+i1tOKTw/P
	 llNTGgL9PuHp3J7vIXHBVMRYyuC5FyMcrdFH3Rgq5pWxw8kbAvwIHXYF+GEIIM/Xt8
	 S97OiDRsCSXsg+H0jx8gs8GkilEUafHAyGvcxpOMeYlwW8If4VYD2qXWhtwJc81/Qt
	 QB4iLZrrxqvyCaLHGLln5FkNcYH95Avw4QvOPiJYfcluIt9sXvoKz4x5M5KZiklCe3
	 uSY9b2uoO5sr4qD/TAvzAEsx/HCI9Prx/gs6goSfCWJA1EQy8g7oHQQ/iiyRc04zmF
	 9aayvwASHVEHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BCB840A8B;
	Thu, 10 Sep 2026 09:30:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0010D2E3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9CD6608A4
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:30:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NYYOse4qcwx0 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 689676089E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789032646;
 b=nsbctfP9Va8OhRBso/EEYlVxDyKtLqA/ds4BqkgeiPXgVIRzMcL3Z5VbX9xV4opO29v6
 5lHz9IyNwrBlbpt1cJaRn7zQtUXhMu/p12hZqf1DcCzSJ9hWp1wpj42NfwmOavt0m9iC7
 XMPf/TmOlPBxKeCP1Yr8v/MIRlFT7HWIYpoEERom0suaZAMfxrfhIAsxu8N76o6dnC6g2
 qWu1EQpbkEvH+zo47HhtGwipwbuj72IbrxB3snBDFnJfRwkBLgbDoAnTj67H2r8TFvQ/y
 WAsk6H/AEnaz44nJSNOIa6nJCgOZ8fwtFUWXGoK0qcLCdR8FiVNI/ZMY/jaIiMNsDxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789032646;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:Authentication-Results-Original:
 x-ms-traffictypediagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 X-CodeTwoProcessed:X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=2aY/cpjiIocAZ+aoPxmxktDo5eRuWBmfPe5V28UyrQ0=;
 b=KE0GaS4jc4L8Uf1KTApkTTpnLkwzoQhFv6FX5rvIVUaTNqiOWLXz4i/zfudawc//bSs1
 JP9Dm4gg5OQTukXGDashWkHRvLC5RwNtH6ZZupYRlBHz57h47USbS9gSpzTnb3Zo+MluQ
 ytHGXv4ICoeJg+e4+RbVuuanuR4Rc5i/ypFQrIDwrWB2kEfCkJ1z8Qmb6gBkwZBN8gFVg
 lCWyeLx37LJ+MPeEGDVKycn5LXrfWQt23MoAU0TzpuXlbnAIpgU9y3W8yPEhIw9cywYj3
 R3KrOY2YKZw0vc3PZ8ufb7rIf3ubI19BmBJhV9iW8r9h7Tc6NV2gtOZIKBurMQJCpbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=sttls.nl; 
 dkim=pass header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b="k8/UEKL0"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=maarten.brock@sttls.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=k8/UEKL0
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 689676089E
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwQ/Wwluyk/uootxVxgQl1ybI7A4S3x8UR9Jcxa0DZucNrrBtK+MZXhyMbYWbw4UZQiot6bh1McXbydnv5elrNa+5gOv8wtIZUjAGc6H1GQyCMH0uYGLV/HMn7ozjzvrWkIBUYwTOB7mviSAKqtFFIhjtELpZ7jdKT3H/WsB/NSKKFJuutpIsVIFnMvii9ESJ9SzIhAIqCzJLvky5IfaTYWeERtPqP9LjndBkKlib+6ca71M4x+kcDl+UdCXaa2yXEhMUyy4g3dgF5EKPLvMhB3Gm1WD8joiTIIp3jU9n8FNfsNoHvtiXPki9/ub7peXZJCkaH7r9vp+BMj8ZTca8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aY/cpjiIocAZ+aoPxmxktDo5eRuWBmfPe5V28UyrQ0=;
 b=fsZbcj9PCgGX3cCr48zLZCCJQ7Kk5P+nMc+bQqkAioL9cNFU9eS89fKBlwV42o0amlx+b96YzN3skpOajwatk5i5zdQom/VH3Eht//BKz32iBoq657ia4dv1mam1HSlsNGMNXXSroXSwiA/gHZ13ETnp4cNqVBphIPOE8EBLdwHMTlWsPDb9bK13WLJlWg+v/3WCay+00i8xFWhGjGylbBNLT1DkjGA0yxVPKSZqVDs7M8wSqJQm0nkH47B7mC0n/DcCTXahV7qNH2+Nz142gKjn9R32xAnnnIKpzFDB+l04zJPBJaB75cuoq6jQ0EzeEk4gl3QSaKx4Xta5yJFYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aY/cpjiIocAZ+aoPxmxktDo5eRuWBmfPe5V28UyrQ0=;
 b=k8/UEKL05/7tPwWu18dO2UEJwyXy3VbpyVjKtjUUnz9h/iJIC2LplulSDHnoI9VFoj+abqcqRcqErhm4CEWRGYzmloiCs3j/eevxWA0LHOEM9CuaVQxLwCKfbwC7x7+mHeObCJ1mSbH/Rxn0pfItcxKnatszCPfAfOHyAA4pMNH1z4/NhcibLyVKrtXp+cuG91hf1g4swdHa7RDvJShAYtiEGRKbvM5Ha5a09MqMSeWjHNZOsrbckh4Dpo0S8FWpC/QkExQ/c5/ufVT8caCU22ZxuVuQmmHeQ35mxiAzN/chpl2W76W/MbAZ2pVmZUxrequkAAOEq+VNqgYde/BhdA==
Received: from DU2PR04CA0182.eurprd04.prod.outlook.com (2603:10a6:10:28d::7)
 by AMBPR05MB444708.eurprd05.prod.outlook.com (2603:10a6:20b:7d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 09:30:40 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::6f) by DU2PR04CA0182.outlook.office365.com
 (2603:10a6:10:28d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 09:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 09:30:40 +0000
Received: from DB3PR08CU002.outbound.protection.outlook.com (40.93.64.81) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 10 Sep 2026 09:30:39 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB3PR0502MB9826.eurprd05.prod.outlook.com
 (2603:10a6:10:43b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 09:30:36 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 09:30:36 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, Sriram Sriram
 <sriramsriram@linux.microsoft.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>
Subject: RE: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Thread-Topic: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Thread-Index: AQHdQJwbo6vaYjctnE+jPPHKOB9Y5bbHdJeAgAAVnlA=
Date: Thu, 10 Sep 2026 09:30:35 +0000
Message-ID: <GV2PR05MB1194135296D564695A241EA6183BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
 <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
In-Reply-To: <2ec7a375-ef8c-4ecb-ad1b-cfbf3ce12b96@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|DB3PR0502MB9826:EE_|DB1PEPF000509F3:EE_|AMBPR05MB444708:EE_
X-MS-Office365-Filtering-Correlation-Id: f4003f95-481e-47de-b27d-08df0f1e2dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|5023799004|4143699003|38070700021|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 1dRBG2YvC8pTwF5FzsWCkGTkg5HSS58QIeCbA+8y7/pLWNhm+WOocyZkV31cOQDMGrPalmdxEgymucOH3UGWKhT6o6k/KJ9Q4od6/VVrlymYmJctsRWTD8hSWg4SIfMPUT6RNv0ZAZtHyuS1Y2lSU1WmZNb7Svr/3dphGrencT1fErELBCbJ13dltrJ4ZwZlmVQEr2+gKvRvUfwCPg0wQs+yySfMyqfbX5T8GtpAW6Uc2c4eDak11WZX21Emt1SHbWfGW9ID6iurbjnXzuw4cp+RwLNUQL466lH43tfoZm219Z1XPvnxQQc++S4IYjctxktDuUWvw+rGHrEW8qxFujZrXZtlTmi+NAVu0nt/Qo9rxsQm8MWKLSq1wb/TgyQrLLkytlGYafcLNAYDRRLpWITOOcAQPKzgYNC6xS5C8dfyw5Oa7HTMz4qtPHbuHRg1nXsXmXQd3BqN3ZDN3+qOHmU83iMVdwQn0JPgB6Yyc0ASR+ZSY7FN2yPPGERrW0UvGp4UpzUuWOi9ciI+vq6S6BFt7KeX4f970oJK5Vubnqb2yc7D+1Urz+HfpaAMMqm6Dk6chwwdrB/Nh+KnGOUnAb9D3tUWEc5mWTTfrRPGXgHPfpfMMW8hnHfjYakB2vRB/PjphZ/g4rAk+35NmvZfVRW9RqnA/1CKx7XVhCw0zj1R6CfYTHZwbl2fWr+TSJ3eAWC6sl4f6jWha/DvKNFnX6RWyHaCkwj6yhwE2cVkDbw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(4143699003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FKTadG/2XHyCKtmC09UQeDSTHbeoLZquiCfu7Y6eC7849ucWu8419daG1DDW6KI61hNlqzW92jmLfylhbbqMmPnnceLDTME3ASUUkooCYgCUK36gH08utWTS/giHe4PGtPZQaG0tc9wdy8arInZe3PtMTjVArsPBltHOSFxLeXmkdLwBSdtDM/n8iX8fAmhOgo8nMuziQfV0oTbPs1+jGQdU9xYSAN4K21l5SrkxFR/sCjjBMc+oeS+5H7iW6/t1XoTJeeDj0jyvSFprnczfjzUgSeEbo12Y+PRMhZuwksbxtKSyoH/pSFXMsq7L9SZXCmkPa97nwaFZtLnN/1j1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB9826
X-CodeTwo-MessageID: 6ec88721-8dfa-4f4b-ac40-688128ad6fed.20260910093039@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d07a8d1-559c-4c61-ccc5-08df0f1e2b44
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|35042699022|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: x9cWayiGYysANXctN0TftEvKm16TGHKzGoanMOPEydh198c6WL6Ww6/70EI3gccAU8i+Y68MI4lIDWyZqp+FApPmRzW+RWU6Q38zPRWsgxSr4DhROPhKyKvuqP1dzn+sX8K4ncI4kSwPk/YoK1akt0RgsfXI12n1OPvsY09qeYwTuyXcpFz36a+vPlkmsbEgTwEhcNGopDfRTr4g0JGVjYhBqB9maxUREQkzRW3KiFNF+cFfviPC4Q0HDhpFb0ePAMsJUhvwEcmW7W9W8CU7H2qNt2hPArUaIyNiaN1oJvNugszUZB/8mxHV74D+Prr7j1+WCUSxrE+Bd8KcJzq/rCMhRdlqgWF/GSMhbcXf3sU64cYiK13MFB8ZxpBjw+/yOHQtSeTQa8OBe1ASyrMxfoaHQyS+kLyqmkZ6crVczCPK5350/7ZdZZnlznkmu0pjn4jotEkyVTR17JE2YVReIT0nNbQN6pKVy1JnBafd+z4aDoGn4fwcIZRuQRkw93Z5PikXZM3vU/SM4eL0Q9Wj2w4tiOXjS5zXs5BoNrBqhOTf56kbLf1TOfulQZMjw6Zn2/v9zpjnOTh9cwCOPXHYSdUxX5R+oFAajgEizMC/qQVxQTaenTWFOC4gncUYF8nMggAz4KcTPXvpJjke/YKwFSdw8jfvLogtaWS8JPMJqSHgBDZazDiuL7Cubl6pPraM2SZojEuXqvMldwfwHV6pFA==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(35042699022)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AyCX89IQ5GW7mFqiXUrsG387HCK/2oIDSBVKPKt+RqlycqkTixxr0IZexKHgPJ1rcC+eD4KoHOcq7ig2q7cqAZ/Tv86fkq13D6lzaaEOEJZB3ORy+7n4HqMnujZksnmx6HSVM3a9UE6v+6z9LlQk1DDOXpBZFQulfLvIj0JGhnXj9C05LJX1rvvIYRvf8cfDk3n+Okq1VCEdSqMv+mj5d9t8MXGOr9F/VNTEtmNdrSpYd+eAvlZ8k34bKyLxdvuhmojdSsewgti2ca9mXCXT2LjT7rrNd/PjgzGrxMz26xbTeAFNnXNiw25MeYd3yA95sHz615H52bD67IHg6r/+8KXzK73LodeYLGHhuHGuuTyjSvW4IJw7ZytCNO8Jt/4BRg0U3jzuZVpbvEI40FRJOjimw4dq4NtygovYphYuqMcxLPkU1C+m14c0wf0ajc2X
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 09:30:40.0833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4003f95-481e-47de-b27d-08df0f1e2dd2
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR05MB444708
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

SGVsbG8gTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1p
Y2hhbCBTaW1layA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5IDEwIFNl
cHRlbWJlciAyMDI2IDk6NTkNCj4gDQo+IE9uIDkvMTAvMjYgMDk6NTYsIE1hYXJ0ZW4gQnJvY2sg
d3JvdGU6DQo+ID4gSGVsbG8gU3JpcmFtIGFuZCBEcmV3LA0KPiA+DQo+ID4gSXQgc2VlbXMgdG8g
bWUgdGhhdCB0aGUgbGltaXQgb2YgNTAgZm9yIE1BWF9OQU1FX0xFTkdUSCBpcyBwcmV0dHkgYXJi
aXRyYXJ5Lg0KPiA+IElmIHlvdSBleHBlY3QgaXQgdG8gZWFzaWx5IG92ZXJmbG93LCB3aHkgbm90
IG1ha2UgdGhhdCBsYXJnZXIgYXMgd2VsbD8NCj4gDQo+IGRvIHlvdSBoYXZlIGEgY2FzZSB3aGVy
ZSB5b3VyIGJvYXJkLCBjYXJyaWVyIGNhcmRzIHdpbGwgcmVxdWlyZSBtb3JlIHRoZW4gNTANCj4g
Y2hhcnM/IFRoaXMgaGFzIGJlZW4gZGVzaWduZWQgZm9yIEtyaWEgU09NIHdoZXJlIHlvdSBoYXZl
IG5hbWUgaW4gYm9hcmQgZWVwcm9tDQo+IGFuZCBjYXJyaWVyIGNhcmQgZWVwcm9tIGFuZCBpdCBp
cyBuZXZlciBvdmVyIDUwIGNoYXJzLg0KDQpObywgSSBkbyBub3QuIEkgd2FzIGp1c3QgZm9sbG93
aW5nIHRoZSBsb2dpYyBpbiB0aGUgcGF0Y2ggY29tbWVudHMuDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4N
Cj4gU2VudDogVGh1cnNkYXkgMTAgU2VwdGVtYmVyIDIwMjYgMTA6MDQNCj4gDQo+IE9uIDkvOS8y
NiAyMToyMCwgU3JpcmFtIFNyaXJhbSB3cm90ZToNCj4gPiBGcm9tOiBEcmV3IEtsdWVta2UgPGFu
a2x1ZW1rQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBib2FyZF9uYW1lX2RlY29kZSgpIGFzc2Vt
YmxlcyB0aGUgYm9hcmQgbmFtZSBpbnRvIGEgY2FsbG9jJ2QgYnVmZmVyIG9mDQo+ID4gTUFYX05B
TUVfTEVOR1RIICg1MCkgYnl0ZXMgdXNpbmcgc3RyY2F0KCkuIEl0IGFwcGVuZHMgQ09ORklHX1NZ
U19CT0FSRA0KPiA+IGFuZCB0aGVuLCBmb3IgZXZlcnkgZGV0ZWN0ZWQgRUVQUk9NIGRlc2NyaXB0
b3IsICItIiwgZGVzYy0+bmFtZSAodXAgdG8NCj4gPiAxNiBjaGFyYWN0ZXJzKSwgIi1yZXYiIGFu
ZCBkZXNjLT5yZXZpc2lvbiAodXAgdG8gOCBjaGFyYWN0ZXJzKS4NCj4gPg0KPiA+IFRoZSBsZW5n
dGggY2hlY2sgcnVucyBvbmx5IGFmdGVyIHRoZSBsb29wLCBzbyBpdCBjYW5ub3QgcHJldmVudCB0
aGUNCj4gPiBvdmVyZmxvdyBpdCBkb2N1bWVudHMuIEVhY2ggZGVzY3JpcHRvciBjb250cmlidXRl
cyB1cCB0byAyOSBjaGFyYWN0ZXJzLA0KPiA+IHNvIGEgYmFzZSBib2FyZCBwbHVzIGEgY2Fycmll
ciBjYXJkIGFscmVhZHkgZXhjZWVkcyB0aGUgYnVmZmVyLCBhbmQgdGhlDQo+ID4gZGF0YSBiZWlu
ZyBjb25jYXRlbmF0ZWQgY29tZXMgZnJvbSB0aGUgRUVQUk9NLg0KDQpUbyBtZSB0aGlzIGluZGlj
YXRlcyBpdCBpcyB2ZXJ5IGVhc3kgdG8gb3ZlcmZsb3cgdGhlIGJ1ZmZlci4NCg0KSSBoYXZlIG5v
dCBmb2xsb3dlZCB3aGVyZSB0aGUgcmVzdWx0IG9mIGJvYXJkX25hbWVfZGVjb2RlKCkgZ29lcw0K
YW5kIHdoZXRoZXIgNTAgaXMgYSBsb2dpY2FsIGJvdW5kIHRoZXJlLiBCdXQgc2luY2UgaXQgaXMg
bG9jYWxseSBkZWZpbmVkDQp3aXRob3V0IGFueSBjb21tZW50cyBpdCBzZWVtcyBhbiBhcmJpdHJh
cnkgY2hvaWNlLg0KDQpBbmQgaWYgYm90aCB0aGVzZSBhc3N1bXB0aW9ucyBhcmUgdHJ1ZSAoZXhw
ZWN0IG92ZXJmbG93IGFuZCBhcmJpdHJhcnkgYm91bmQpDQp0aGVuIGl0IGlzIHByb2JhYmx5IGEg
Z29vZCBpZGVhIHRvIHVzZSBhIGxhcmdlciBib3VuZC4NCg0KPiA+IFVzZSBzdHJsY2F0KCkgYm91
bmRlZCB0byBNQVhfTkFNRV9MRU5HVEggc28gdGhlIHdyaXRlcyBhcmUgdHJ1bmNhdGVkDQo+ID4g
cmF0aGVyIHRoYW4gb3ZlcmZsb3dpbmcgdGhlIGFsbG9jYXRpb24uIFRydW5jYXRpb24gbGVhdmVz
IGEgc3RyaW5nIG9mDQo+ID4gTUFYX05BTUVfTEVOR1RIIC0gMSBjaGFyYWN0ZXJzLCBzbyByZWxh
eCB0aGUgY2hlY2sgYWNjb3JkaW5nbHk7DQo+ID4gYXMgd3JpdHRlbiBpdCBjb3VsZCBuZXZlciBm
aXJlIG9uY2Ugc3RybGNhdCgpIGlzIHVzZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEcmV3
IEtsdWVta2UgPGFua2x1ZW1rQG1pY3Jvc29mdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jp
cmFtIFNyaXJhbSA8c3JpcmFtc3JpcmFtQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+
ID4gICBib2FyZC94aWxpbngvY29tbW9uL2JvYXJkLmMgfCAyMCArKysrKysrKysrKystLS0tLS0t
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQveGlsaW54L2NvbW1vbi9ib2FyZC5jIGIvYm9h
cmQveGlsaW54L2NvbW1vbi9ib2FyZC5jDQo+ID4gaW5kZXggZjQ1Yjg3OTczNmUuLjY5MDk5MWJi
NDM1IDEwMDY0NA0KPiA+IC0tLSBhL2JvYXJkL3hpbGlueC9jb21tb24vYm9hcmQuYw0KPiA+ICsr
KyBiL2JvYXJkL3hpbGlueC9jb21tb24vYm9hcmQuYw0KPiA+IEBAIC01OTAsMzggKzU5MCw0MiBA
QCBjaGFyICogX19tYXliZV91bnVzZWQgX193ZWFrIGJvYXJkX25hbWVfZGVjb2RlKHZvaWQpDQo+
ID4NCj4gPiAgIAkJLyogVGhlIGZpcnN0IHN0cmluZyBzaG91bGQgYmUgc29jIG5hbWUgKi8NCj4g
PiAgIAkJaWYgKCFpZCkNCj4gPiAtCQkJc3RyY2F0KGJvYXJkX2xvY2FsX25hbWUsIENPTkZJR19T
WVNfQk9BUkQpOw0KPiA+ICsJCQlzdHJsY2F0KGJvYXJkX2xvY2FsX25hbWUsIENPTkZJR19TWVNf
Qk9BUkQsDQo+ID4gKwkJCQlNQVhfTkFNRV9MRU5HVEgpOw0KPiANCj4gSSBhY3R1YWxseSBnb3Qg
YSBwYXRoIChjJnAgYmVsb3cpIGZvciB0aGUgc2FtZSBpc3N1ZSBzb21lIGRheXMgYWdvIGludGVy
bmFsbHkNCj4gYW5kIGFsc28gcmV2aWV3ZWQgaXQgYWxyZWFkeS4gQnV0IHVuZm9ydHVuYXRlbHkg
aXQgd2Fzbid0IHNlbnQgb3V0IHlldC4NCj4gVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBpdCBpcyBj
aGVja2luZyBsZW4gYXQgdGhlIGVuZCBvZiBldmVyeSBsb29wIHRvIGdldCBvdXQgb2YNCj4gaXQg
ZWFybGllci4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo+IA0KPiANCj4gDQo+ICAgQXV0aG9y
OiAgICAgUHJhbmF2IFRpbGFrIDxwcmFuYXYudmluYXl0aWxha0BhbWQuY29tPg0KPiAgIEF1dGhv
ckRhdGU6IFdlZCBTZXAgOSAxMDoxMzowOSAyMDI2ICswNTMwDQo+IA0KPiAgICAgICBib2FyZDog
eGlsaW54OiBGaXggaGVhcCBidWZmZXIgb3ZlcmZsb3cgaW4gYm9hcmRfbmFtZV9kZWNvZGUoKQ0K
PiANCj4gICAgICAgYm9hcmRfbmFtZV9kZWNvZGUoKSBidWlsZHMgdGhlIGJvYXJkIG5hbWUgYnkg
cmVwZWF0ZWRseSBhcHBlbmRpbmcNCj4gICAgICAgdG8gYSBmaXhlZCBNQVhfTkFNRV9MRU5HVEgg
KDUwLWJ5dGUpIGJ1ZmZlciB3aXRoIHN0cmNhdCgpLCBhbmQgb25seQ0KPiAgICAgICBjaGVja3Mg
Zm9yIG92ZXJmbG93IG9uY2UsIGFmdGVyIHRoZSBlbnRpcmUgbG9vcCBvdmVyIGFsbCBkZXRlY3Rl
ZA0KPiAgICAgICBudm1lbVggRUVQUk9NIGRldmljZXMgaGFzIGNvbXBsZXRlZC4gSWYgZW5vdWdo
IGRldmljZXMgYXJlIHByZXNlbnQNCj4gICAgICAgYW5kIHRoZWlyIG5hbWUvcmV2aXNpb24gZmll
bGRzIGFyZSBsb25nIGVub3VnaCwgc3RyY2F0KCkgY2FuIHdyaXRlDQo+ICAgICAgIHBhc3QgdGhl
IGVuZCBvZiB0aGUgYnVmZmVyIGJlZm9yZSB0aGUgb3ZlcmZsb3cgY2hlY2sgaXMgcmVhY2hlZCwN
Cj4gICAgICAgcmVzdWx0aW5nIGluIGhlYXAgbWVtb3J5IGNvcnJ1cHRpb24uDQo+IA0KPiAgICAg
ICBGaXggdGhpcyBieSB1c2luZyBzdHJsY2F0KCkgaW5zdGVhZCwgd2hpY2ggYm91bmRzIGV2ZXJ5
IHdyaXRlIHRvDQo+ICAgICAgIHRoZSBkZXN0aW5hdGlvbiBidWZmZXIgc2l6ZSBhbmQgcHJldmVu
dHMgb3ZlcnJ1bm5pbmcgdGhlIGFsbG9jYXRpb24uDQo+ICAgICAgIFVzZSBpdHMgcmV0dXJuIHZh
bHVlIHRvIGRldGVjdCB0cnVuY2F0aW9uIGR1cmluZyBib2FyZCBuYW1lDQo+ICAgICAgIGNvbnN0
cnVjdGlvbiBpbnN0ZWFkIG9mIHJlbHlpbmcgb24gYSBzaW5nbGUgbGVuZ3RoIGNoZWNrIGFmdGVy
IGFsbA0KPiAgICAgICBFRVBST00gZGV2aWNlcyBoYXZlIGJlZW4gcHJvY2Vzc2VkLg0KPiANCj4g
ICAgICAgRml4ZXM6IDUyZmYxNjI2Y2Y0YyAoInhpbGlueDogY29tbW9uOiBFbmFibGluZyBnZW5l
cmljIGZ1bmN0aW9uIGZvciBEVA0KPiByZXNlbGVjdGlvbiIpDQo+ICAgICAgIFNpZ25lZC1vZmYt
Ynk6IFByYW5hdiBUaWxhayA8cHJhbmF2LnZpbmF5dGlsYWtAYW1kLmNvbT4NCj4gDQo+ICAgZGlm
ZiAtLWdpdCBhL2JvYXJkL3hpbGlueC9jb21tb24vYm9hcmQuYyBiL2JvYXJkL3hpbGlueC9jb21t
b24vYm9hcmQuYw0KPiAgIGluZGV4IGJkY2NmMDczMmQyYS4uOTY0ODE3ZDk4ZTY1IDEwMDY0NA0K
PiAgIC0tLSBhL2JvYXJkL3hpbGlueC9jb21tb24vYm9hcmQuYw0KPiAgICsrKyBiL2JvYXJkL3hp
bGlueC9jb21tb24vYm9hcmQuYw0KPiAgIEBAIC01NzEsOCArNTcxLDkgQEAgaW50IF9fbWF5YmVf
dW51c2VkIGJvYXJkX2ZpdF9jb25maWdfbmFtZV9tYXRjaChjb25zdCBjaGFyDQo+ICpuYW1lKQ0K
PiANCj4gICAgY2hhciAqIF9fbWF5YmVfdW51c2VkIF9fd2VhayBib2FyZF9uYW1lX2RlY29kZSh2
b2lkKQ0KPiAgICB7DQo+ICAgLQljaGFyICpib2FyZF9sb2NhbF9uYW1lOw0KPiAgICAJc3RydWN0
IHhpbGlueF9ib2FyZF9kZXNjcmlwdGlvbiAqZGVzYzsNCj4gICArCWNoYXIgKmJvYXJkX2xvY2Fs
X25hbWU7DQo+ICAgKwlzaXplX3QgbGVuID0gMDsNCj4gICAgCWludCBpLCBpZDsNCj4gDQo+ICAg
IAlib2FyZF9sb2NhbF9uYW1lID0gY2FsbG9jKDEsIE1BWF9OQU1FX0xFTkdUSCk7DQo+ICAgQEAg
LTU5MiwzOSArNTkzLDM2IEBAIGNoYXIgKiBfX21heWJlX3VudXNlZCBfX3dlYWsgYm9hcmRfbmFt
ZV9kZWNvZGUodm9pZCkNCj4gDQo+ICAgIAkJLyogVGhlIGZpcnN0IHN0cmluZyBzaG91bGQgYmUg
c29jIG5hbWUgKi8NCj4gICAgCQlpZiAoIWlkKQ0KPiAgIC0JCQlzdHJjYXQoYm9hcmRfbG9jYWxf
bmFtZSwgQ09ORklHX1NZU19CT0FSRCk7DQo+ICAgKwkJCWxlbiA9IHN0cmxjYXQoYm9hcmRfbG9j
YWxfbmFtZSwgQ09ORklHX1NZU19CT0FSRCwgTUFYX05BTUVfTEVOR1RIKTsNCj4gDQo+ICAgIAkJ
LyoNCj4gICAgCQkgKiBGb3IgdHdvIHB1cnBvc2UgaGVyZToNCj4gICAgCQkgKiBzb2NfbmFtZS0g
ZWc6IHp5bnFtcC0NCj4gICAgCQkgKiBhbmQgYmV0d2VlbiBiYXNlIGJvYXJkIGFuZCBDQyBlZzog
Li5yZXZBLXNjay4uLg0KPiAgICAJCSAqLw0KPiAgIC0JCXN0cmNhdChib2FyZF9sb2NhbF9uYW1l
LCAiLSIpOw0KPiAgICsJCWxlbiA9IHN0cmxjYXQoYm9hcmRfbG9jYWxfbmFtZSwgIi0iLCBNQVhf
TkFNRV9MRU5HVEgpOw0KPiANCj4gICAgCQlpZiAoZGVzYy0+bmFtZVswXSkgew0KPiAgICAJCQkv
KiBGb3IgRFQgY29tcG9zaXRpb24gbmFtZSBuZWVkcyB0byBiZSBsb3dlcmNhc2UgKi8NCj4gICAg
CQkJZm9yIChpID0gMDsgaSA8IHNpemVvZihkZXNjLT5uYW1lKTsgaSsrKQ0KPiAgICAJCQkJZGVz
Yy0+bmFtZVtpXSA9IHRvbG93ZXIoZGVzYy0+bmFtZVtpXSk7DQo+IA0KPiAgIC0JCQlzdHJjYXQo
Ym9hcmRfbG9jYWxfbmFtZSwgZGVzYy0+bmFtZSk7DQo+ICAgKwkJCWxlbiA9IHN0cmxjYXQoYm9h
cmRfbG9jYWxfbmFtZSwgZGVzYy0+bmFtZSwgTUFYX05BTUVfTEVOR1RIKTsNCj4gICAgCQl9DQo+
ICAgIAkJaWYgKGRlc2MtPnJldmlzaW9uWzBdKSB7DQo+ICAgLQkJCXN0cmNhdChib2FyZF9sb2Nh
bF9uYW1lLCAiLXJldiIpOw0KPiAgICsJCQlsZW4gPSBzdHJsY2F0KGJvYXJkX2xvY2FsX25hbWUs
ICItcmV2IiwgTUFYX05BTUVfTEVOR1RIKTsNCj4gDQo+ICAgIAkJCS8qIEFuZCByZXZpc2lvbiBu
ZWVkcyB0byBiZSB1cHBlcmNhc2UgKi8NCj4gICAgCQkJZm9yIChpID0gMDsgaSA8IHNpemVvZihk
ZXNjLT5yZXZpc2lvbik7IGkrKykNCj4gICAgCQkJCWRlc2MtPnJldmlzaW9uW2ldID0gdG91cHBl
cihkZXNjLT5yZXZpc2lvbltpXSk7DQo+IA0KPiAgIC0JCQlzdHJjYXQoYm9hcmRfbG9jYWxfbmFt
ZSwgZGVzYy0+cmV2aXNpb24pOw0KPiAgICsJCQlsZW4gPSBzdHJsY2F0KGJvYXJkX2xvY2FsX25h
bWUsIGRlc2MtPnJldmlzaW9uLCBNQVhfTkFNRV9MRU5HVEgpOw0KPiAgICAJCX0NCj4gICAtCX0N
Cj4gDQo+ICAgLQkvKg0KPiAgIC0JICogTG9uZ2VyIHN0cmluZ3Mgd2lsbCBlbmQgdXAgd2l0aCBi
dWZmZXIgb3ZlcmZsb3cgYW5kIHBvdGVudGlhbA0KPiAgIC0JICogYXR0YWNrcyB0aGF0J3Mgd2h5
IGNoZWNrIGl0DQo+ICAgLQkgKi8NCj4gICAtCWlmIChzdHJsZW4oYm9hcmRfbG9jYWxfbmFtZSkg
Pj0gTUFYX05BTUVfTEVOR1RIKQ0KPiAgIC0JCXBhbmljKCJCb2FyZCBuYW1lIGNhbid0IGJlIGRl
dGVybWluZWRcbiIpOw0KPiAgICsJCS8qIFJlamVjdCB0cnVuY2F0ZWQgYm9hcmQgbmFtZXMuICov
DQo+ICAgKwkJaWYgKGxlbiA+PSBNQVhfTkFNRV9MRU5HVEgpDQo+ICAgKwkJCXBhbmljKCJCb2Fy
ZCBuYW1lIGNhbid0IGJlIGRldGVybWluZWRcbiIpOw0KPiAgICsJfQ0KPiANCj4gICAgCWlmIChz
dHJsZW4oYm9hcmRfbG9jYWxfbmFtZSkpDQo+ICAgIAkJcmV0dXJuIGJvYXJkX2xvY2FsX25hbWU7
DQo+IA0KDQpJIHdvdWxkIHByZWZlciB0aGUgcGF0Y2ggZnJvbSBQcmFuYXYgVGlsYWsgd2hpY2gg
ZG9lc24ndCBuZWVkIGFuIGV4dHJhIHN0cmxlbigpIGNhbGwuDQoNCktpbmQgUmVnYXJkcywNCk1h
YXJ0ZW4NCg0K
