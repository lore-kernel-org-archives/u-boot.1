Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0FC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 07:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B2CA80E6A;
	Mon, 17 Aug 2026 07:56:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4sAYbZkalPs9; Mon, 17 Aug 2026 07:56:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30BEC80E50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786953386;
	bh=DfhppHxBbFyYFa49zjrVm5tefhpbfRUqTcLpPt+kPuQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=m/OeQ6/C3j2uC02TOBgKHVbf/sNBtOGf6rcFzkzidd6WPFiCJxB8lCn0nYRxp+Kvd
	 BssntgKNfU467PiRcWwlvMDOfQ2JPbhYhYYhGfij16WpIsUz+TrZY5aPa4gyllBLIT
	 eYNjRXj9Cpz7ooBPynjjfrjfECAR99mr69eeMY5vp91F94WB5UiHUWd9w4G7VHEsdB
	 qAXR8YaNxIJQUvqb1Qtb+7v6cGbWOw1fENaGxY1xI1a6falYAymWUsbYiK5tJO05EM
	 Dl47PrGDdK/3h5d1z61koTbWbusCbYNuGrRgmy9OGDjUl+D227Vvvo2FssmyMXhSFN
	 6SMcV96l36VCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30BEC80E50;
	Mon, 17 Aug 2026 07:56:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FFF0194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4261B400EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSuo0Mr65I0x for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 07:56:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 592DF40087
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 592DF40087
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 592DF40087
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV8ypbcNlaMe+KE5ony01d1c1Yyo8emjQV/cVvq3DOuys8+VRyWy2q7wb8V1lYZSBxmWTxXkr9SttsRmyIbq6alX6x6O0S22sgwI/iqVy5g+8E0Mpwa/BOZJYfZDLfHqV/MeOjvy0VitQp/tljE85vv+Z1vC0RzjTjNKfUzMacK4N9yhfxYKiE/NtuqbzJm0IonBLc5ep+txP/iau0x3kWtwhg6MfbXAO/hjtM6t/TLzDtwMeePMIWcmF+DjA5q7d8f+QcLihuazXNQTcL3WNsEwRgWLtvM/nAwMKUPS7hkR+Vd67a/FzXXXmDjgh6AQTrix8yhRUiOBPp6u2qrWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfhppHxBbFyYFa49zjrVm5tefhpbfRUqTcLpPt+kPuQ=;
 b=BBZORZb/uFJzR2srTvC6/C751bWeJG8Q4/54bpQjTpOm/JvpUAYQtAFD1OoWACZ11cyKk5ywfLqFhF5vsaaSkgotH2PKj9a12cyFD39e38eSTf51Et5WCDl+Y+4a0rhw+fepnRsLDda2CxDWxBXM7EavtE4JUBwaCp2cIoxC2iDQvI3TIfhX8Qn0ihQg2lIQ83oy3s984zYOyMTKyxFz3MignjHkohQGVZF+OuwwM44EzI2K3ISbBZD/qYp+r6DrfxYB37ZJ9t6sOHyXG+5zwSSmT58s5Et09WnO9PQ3thTZM1T8AGrGapCxQYeYM9ywBed/k38Q1IkwXwMTRhhwLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AS4P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::7)
 by AM0PR07MB11518.eurprd07.prod.outlook.com (2603:10a6:20b:6f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 17 Aug
 2026 07:56:19 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::4a) by AS4P190CA0001.outlook.office365.com
 (2603:10a6:20b:5de::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 07:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Mon, 17 Aug 2026 07:56:19 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1C0482381F;
 Mon, 17 Aug 2026 10:56:19 +0300 (EEST)
To: sjg@chromium.org
Cc: juuso.rinta@nokia.com,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/5] watchdog: report effective timeout
Date: Mon, 17 Aug 2026 10:56:18 +0300
Message-Id: <20260817075618.2147465-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszThdqj8hPL82RKe5secs1_Vg0N1fSNRcwBX0RuhfUCttzQ@mail.gmail.com>
References: <CAFLszThdqj8hPL82RKe5secs1_Vg0N1fSNRcwBX0RuhfUCttzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AM0PR07MB11518:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0b327f7-75e3-45f4-ab0b-08defc3505ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3O4EN5ATyCWeYKMVr3cqdxty1wpVhVLX5fe+L8VaM6yKhl/mIUYOwT37suwqdTbyJKzRz5UDjCil2aReD3hCsD8BdgRDoDLVLRXnG/5OAq7ruFRgSLU3AcOxRgZPGEiGZk+RauGyOT+dNGcerXP6/sutmTlxrUZBt9iKqpmvbiNvx8W2HmH/N1/xf4AtCmxozTOprw3j+hpKcgHhNbX5X2b4ei0I/J9rh4DFNttr1mGJbawbfJLYzrl+IWSoNF7B1MHsrypFdXEpJqkPhb+0/m/7WcNqjHuLELLjvtroEdba/woDzt/wSNnXeyNnecdy7coSw1LpFbbQVkuvDc+NOuGY55tIIwVQ3Gaw9eA8wKOaMXLRbybIu0MRov43zK7VMM+NCOQxv3tFbeEOmiBLAkzpIldGNd+F+b1uoaqetBF8JX8q0BuiBrrYrudM8vziVVBBSCdIQ2Q7qY0zv86bAlAtXTqSYpD+rJCkgfxzQ+rT+lI4EDTbpjW/wHWb8wsCpm5VAYHTy+CEPIOffRCrB2tX/pOQWXUzVlVTFnp15e0JYpN4DzCwFRTvdd2dW0hs/LOCORzGoig3EdpuCsPgbokW4k80JA5Z17U+UZPtqW+i5DL5d/N+tIx8B5kd64h0dsf1HlQ2aA5cFmq7Ph7admbOZRs1e6If2rdLu58NK6+IZrPcONA4nsbUVSWEJ0wT0P5smqvNBM+a7FB1Lj5OpA==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dom17ttss3j8SATMqPfGk68/gD6pkAvayP+4OIlSX5qhkIAgL9S3U3+nFtdadW5lDL1cPIJMu5hh+MxaI5NQLkTC4xtzC4uStcsGvDw1dz1nGHnsIxBPUk+VJtd1Btx/6L1iX5LVf/ITqYA2WlYE+soR2RRNAw1OTFU6GDYzk+ta2MPRGG+Rnu/FGWtogPaD6UG+Yo3693Xo/YlZZhbRiXTPfJafofF5v6RcScGkfIj6F2S01qhBwtNBJYilSJaBaNl3nvxST9wl6dLwaip9/az5ZItahgvMHBNr6urjV1ig6qRmGNZdRiLYhm8tGdy+a43B+QAEtQ4Q3vka8NC8spyG3EZkeQwzazCVnN2TQW8AIXc4TVpLfZawprYdteVoQarmFFrTzfjEAPXD3usyHKalDyQaKpCN6Dmi3Qqdvnn+kjcy2kzYxgSN9TDun43s
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:56:19.5300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b327f7-75e3-45f4-ab0b-08defc3505ef
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11518
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

Hey Simon,

> Since the uclass now knows both the requested value and the
> driver-reported maximum, would it be cleaner to have the uclass clamp
> timeout_ms before calling ops->start(), rather than reporting a value
> the driver may or may not honour?

Agreed, will be done in v3.

> The sandbox driver has had to grow
> its own clamp in patch 4 purely so the print path is testable. If the
> uclass clamped, real drivers would never see an out-of-range value and
> the sandbox change in patch 4 would not be needed. What do you think?

Sandbox will still need to set max_timeout_ms in probe so the uclass knows
the limit, but v3 will get rid of the extra clamping in sandbox_wdt_start().

Best,
Juuso
