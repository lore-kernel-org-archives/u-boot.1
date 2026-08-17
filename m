Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B243AC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 08:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A127280E76;
	Mon, 17 Aug 2026 08:03:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ph7o87TVexsP; Mon, 17 Aug 2026 08:03:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D41CB80E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786953790;
	bh=GQj/Hj+MFQgjO8MYxdUZ3rH3rxlFC8SBANh1MpB+yIg=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=agRJ5/uv1Q/NSXXqeDICM/4Q7WkpXZYF2xqSKQchMNDgL0QBfVC2hvn+sj8rP1aQm
	 iTLBWm8M8IjSipjLarvRYYWHYUa96o1ISsBpcZoznjqnPdJCJCaTLAlCAFErESj2cL
	 TAJfr962AkAr5nYC2/hUIpO3ocUjHpa91sznGfwJKBhpp9rZ8y8ECpinkNgis7UtHp
	 zF1Y48D81wl6+V/2ZyPRebnFTujm33ZmYX309ypgqq79dLOK19jwM6NF8YNm4SEKa1
	 K1VO/7+mj69dkgw1VW3zU8lUHwUEDwc2WHHhK42zlizvmD8zc6J+tkYMUa2NiaEQ0e
	 pitfrzAHfWaxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D41CB80E2D;
	Mon, 17 Aug 2026 08:03:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8286237
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA4E760710
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0Br_LfeD8Ve for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:03:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EC11C60709
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC11C60709
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC11C60709
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DS8PTkyUxba6jYTg1OVtTrdssLSBouxkdrK4A8GfXkIdIDd1fhqBbHYgm9h6tDbUWAj3/msywhgmBArg+/zLDjQ6brOXoNAPfzVrCOe0k4/sIt1cto2VQdNjjZRRVUbHlL1uRgG8I78dbb8pWhUK0DsnWYdg7Uv/lqiJG2rwxR2PWVLrJ0lHTZLaUg2s/Y88DWplVHF7ZI04mD2BZg0/s9uk4QqenKeMK6/5GnPAQYS0rMNrunMCGSxLC+KT3rPIXU6FbMeUBW+Vo5NlxDdoWHN1hCOMhIYzMjq6si2XiZLCAStiOS32HSkBprb30EJL2BI9Tx1fxYTx15L6Y8Nc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQj/Hj+MFQgjO8MYxdUZ3rH3rxlFC8SBANh1MpB+yIg=;
 b=svIQZazzOFcDaBV89fc9JiKns9toOxVyoLGNN74aUu1HmV2M2cYdX6QXpGY3L1iQHx9L05WVQ9n8mmLS0MaKWHiy/kPZpfDBhuT5DnGyeEkOMx4WGeYEDij/Wbv0fZxLiVxxUVxd0sptkN9TsBEYXPibRxuTrzJ4X5eMulKfnb6fuZBl4pRmLypoaSnuNdvHvifnUev90iO24ZfA9zRXqR/wlxyQXtGCdyUmaodtItO4vvbq8egwbgJyGv3+qplb4vpb9yy+RcbTFfO5XUOMgXXjtt3dYhOjbaAwA8X+nyg7YxX691ub2TQAanO3VQyhdKj3vvq/etBecLIlCaJ2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AM0PR02CA0127.eurprd02.prod.outlook.com (2603:10a6:20b:28c::24)
 by VI0PR07MB11035.eurprd07.prod.outlook.com (2603:10a6:800:2d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 17 Aug
 2026 08:03:01 +0000
Received: from AMS0EPF000001A1.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::8) by AM0PR02CA0127.outlook.office365.com
 (2603:10a6:20b:28c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 08:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001A1.mail.protection.outlook.com (10.167.16.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Mon, 17 Aug 2026 08:03:00 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6AD682360A;
 Mon, 17 Aug 2026 11:03:00 +0300 (EEST)
To: sjg@chromium.org
Cc: aaro.koskinen@nokia.com, antonio.borneo@foss.st.com, juuso.rinta@nokia.com,
 me@ziyao.cc, patrice.chotard@foss.st.com, peng.fan@nxp.com,
 stefan.roese@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v2 5/5] test: wdt: add a test for max_timeout_ms
Date: Mon, 17 Aug 2026 11:03:00 +0300
Message-Id: <20260817080300.2382982-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTi1U9=XihfqRjqMaGhL54d00ux=zYjcfUuk0GX7LLpU7A@mail.gmail.com>
References: <CAFLszTi1U9=XihfqRjqMaGhL54d00ux=zYjcfUuk0GX7LLpU7A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A1:EE_|VI0PR07MB11035:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34475709-08d3-48b7-0aa0-08defc35f524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vruKZ9F5XEePHtvDq8lo8w5HPUhjjPEXg1cT4LIP6qsomeo+YIa8/m0+v3JWdcOYvPfzHNXsWiLlx8SOyEhdn8+TrVSqAenAFdpFaJoTzdrt10Tnc/6+/gVP311rsdaaUZd5UOpBAmB0lXGQSWk+dAvpmLz+2FozciIA2rM3LHuIt2QDW8Rhl0HR0jBdhDMuotq/KISRv1YF0cGyHc+e7ZtQdIMhGLI+RI8jKqTQD/jnuO04R/iu8zpndR6JDDDzcvYst7s6yVIgvvIhgQPSjuLqMT4df7D5apVMRP635oOtDJ+3SEHZe7EQNB+iEVHEVtZiyCVsd/yRkkntmsg46tnG0Z/PN5oyGMM6V0rUItBmNjmT/6hJXSGUWLHx3ErC5hbbeQLTECnkOoeqp/cjXWJ+g3thHPtusaAlRqbev9ci+GnIKgjJ0t5pmg9yQuy9jmSw5klWHdA+PD0VmiI5sI6EtL1YxBu1mUklclYjf4vfPdNLCTf7MBURzI4Nuu1FAWRIpvI7NK6K92x15jjriEXhd47I2sV/q44G3h73EXGxDX35U6/CXoOflTmlPwmX8Vd7tbxaRV/R+3VAus+x16/UEHlaTFt6I4x0kFM73YOx4zRq8ww5vnVwinyws/KftVZooZ/Bn04md6eum86B9nvugmsZ9FG9I7luGnocb17QTmErOhSRqSpzMbp1kX5wcFMQkndVvDxrAPC8Jervxg==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MQ5DFsD1tbWk03KhdQk959oUyGcJ/qerLKMKWeUCjJInI/3/Qg+ZyYnlveNDUIbYIeOE68jh1O5hfqsYYMSMnpkJTtl9lRN+Rcg4ge58rgOKSp2cWrBVvBYad4d7v/94h4TnHcjtg1XXJwaOSZ6waQZToxd4+cijmBMCewXW7uohIS8CWqSWh7qrDA5ru1/CjztqpK8efmwycSvKX2lx9NH0RkPKPzru3rm9R5LdaL98uqqLA0ArLQ7Y1hn/npNqgw9jzsk5c5VzjU+5Mjt+y4aWQj9Bg7bPijVOYI5JKwoTK2sEbl5VINXKlafbeUQDbliLwwN4MJKB9kIcdbEkPhdIqWWx9Oc9cU/QKAHht5xE+GVh+9lTd++2tykGgxJ6EZeyBya0kcZHhZga+QFtt4XmVBynkGfSM+luupfhzGQJJ/q/BGeFD8ci+0RLBr48
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 08:03:00.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34475709-08d3-48b7-0aa0-08defc35f524
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001A1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11035
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: juuso.rinta@nokia.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

> This helper reimplements internal wdt-uclass details (the format
> string, the "every %ldms" text, and the hw_margin_ms / 4 calculation
> from wdt_pre_probe()). If any of that drifts, the tests silently rot
> rather than catching a real change. Please drop the string
> reconstruction and either match against a fixed literal...

Agreed, v3 drops the helper and asserts a fixed literal.

> Sandbox does not select
> CONFIG_WATCHDOG, so I suspect the ut_assert_nextline() calls below
> will not match today.

That would be true from sandbox_defconfig alone, but CONFIG_WDT has
'imply WATCHDOG', so the sandbox build ends up with CONFIG_WATCHDOG=y.
ut dm wdt_base prints:
  WDT:   Started wdt@0 with servicing every 50ms (0s timeout)
v3 will expect that line.

> The clamped case only exercises timeout_ms > max_timeout_ms. The
> uclass code has a second branch, the sub-second difference guard, that
> suppresses req_str when the whole-second value would be unchanged. How
> about a case where timeout_ms is greater than max but rounds to the
> same whole second (e.g. max + 100ms), to lock down that behaviour?

Good idea, will be added to v3.

Best,
Juuso
