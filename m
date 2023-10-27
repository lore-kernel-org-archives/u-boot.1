Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A67C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690B18772A;
	Fri, 27 Oct 2023 22:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="WQvzQ6sd";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="WQvzQ6sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3763876FA; Fri, 27 Oct 2023 22:40:45 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B1F87718
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=AnoIX19GvwJQ3Q+uoC6gDvu+jMnIZbZe/2THQkfIhlPbWSokZLQ/nKukXLk7ualORcebfM3byzR2Y6i2cLUEwYudxSHUVDsM5DvOmGfUDST93MqqLUPAAVbRKRnJNEz3DLKddSo57f9T9T1FuzvoR9opJ7GIZWkMTfSvkr0T1jrNxArKJR+1itbhEt5tQ6F/xGyUC114G5SxYPaFbWEBVA0HnlTaz+NYVEKOO0kTV3e+aw1iMRnl7fqxduVWApbNEikb1S2FfpY6X/wpAIAAkMgGWOCq1Z+dtB54p7849xy9tY7kRyK+87CycwYch8AUB5EOuEaHOwgM4RU99x9ewA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmrqterP0zSNrv5O5CFDm3luVPRjO9nDlZ/uLTqnHZQ=;
 b=EN6T6UGUi3x2dwaO03CURtWUolOSOa7YaGGlPmo4V91XZQzKoY30kwnfPgm2ljh9vf07jaBj0mijiowKC4j6gGEGxQc5zEJGTEOrZDWWsOI5wZlJhwM7teZwnMJ4G5B2KJ0uwKboPjZz9hl1vjJWOGgc+nVqd8WjSgbhoSjZCO+73cWuU1ZLPdp2rUBwqutU3bR9O+TTM4XNseTAPAp8bFjPPpC0A2EvzuLtfFzwpogC3a4x2I3+DaSaCWwnfAeF+aKCQ4nST7dFr3iSxUx+6n0TH5LGsSUqziQ2F7td9DlMHeaGTHkVDjTyXqNiQktt/uS3BySIHxl9SyOdN8PkqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=arm.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmrqterP0zSNrv5O5CFDm3luVPRjO9nDlZ/uLTqnHZQ=;
 b=WQvzQ6sdnZi4bFZk8jU3bLVFqGNJ+/hDvhzHzt4S6XBTC7TqXZEkb7mv1rtjcvnHXy0SIV6xxB98vrQkRjC6Doyshyg9ds4u1a9qHo7UkvpJOIvvP5nZUr0bDXZmTI8iNcFIxucocDwpCiR0Rl1RAxVs6SVGe4wM8Df9JsQItSs6Do8d3gGu5uj4AvEifKwzCVpL94iA/waA8CSXeBJsCcA+AaCXubQTnx+DTZ1Mu0L67LsGvVDhUv5H7hdyDfZAZU1N09JE2LvsjRTIHDXEkxoYz53k3V1jKL8gr1Kn0gvdd4F1JNpKJDn8e04Gx3OJOdOCO/PJDZBBx+eQqCgyeg==
Received: from AS4P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::10)
 by GV2PR03MB8851.eurprd03.prod.outlook.com (2603:10a6:150:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 20:40:39 +0000
Received: from AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:5da:cafe::21) by AS4P192CA0015.outlook.office365.com
 (2603:10a6:20b:5da::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Fri, 27 Oct 2023 20:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 AM6EUR05FT040.mail.protection.outlook.com (10.233.241.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.11 via Frontend Transport; Fri, 27 Oct 2023 20:40:39 +0000
Received: from outmta (unknown [192.168.82.140])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 2E2CE200813AA; Fri, 27 Oct 2023 20:40:39 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (unknown
 [104.47.51.233])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 4E1602008006E; 
 Fri, 27 Oct 2023 20:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXmWGRURKAp0PONdi6Y0MGiwt+TsCwGtf6tynZFxP88gQ30osCH1cuVjEp+L6zqo/650d/H5It3dTdnMqyIHtSqKaOhPvaHiw21U5kWLdV/WSW5g+nG8d5q/7blv2M2SXhVbQv9hp+CJzW5GOWqQZrd1BSBxtFh17cZET0Sm1tDlB4+wZO+CptSYt2Th0q0Z1uJEOtZpm2oa7nW02G65yyVJl8vAs0Nr8g2s1UP8urk3pZJBlXmpUYM6ZQQ3vp3MpE2icS7tWBgCbnrQEpRM+pUhkawXduguVOmBUV4bGNRIP6R0ISeLadeMpwwd96qPfJKqR/RH3SrFNiNcTWoBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmrqterP0zSNrv5O5CFDm3luVPRjO9nDlZ/uLTqnHZQ=;
 b=au8RmYvyu2C6A75iL/BeRdpA64GyZEAnJ+WnzqPRlC1GCrUMNHl8UU8TZqGLllDO4js/JuqEH9OTzmEwg0X0KuD/K2qeta8oR7AxjlUZJjgCAw7IEmNbQ9H7jWDtb2dq1SO3WV58fq8xhV45MOGCJj8OiU5Ojj91w9TNmd+l2dIkC0mUBGdos4jbRyOKvcyJbZZrKC0bbPOiifZ5YfT2Aj3aC7AiD8EmP51zgNHnyJMrTMPB/EotzhuMv6C4pdL2VDRgtzuOprYaJNUs1mYVbf0oxPkLV3ypmX4cmJINFBg/4OrKAEGW2lz9iffE3CEMj1OAm4kRwsHVreuqYK4cOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmrqterP0zSNrv5O5CFDm3luVPRjO9nDlZ/uLTqnHZQ=;
 b=WQvzQ6sdnZi4bFZk8jU3bLVFqGNJ+/hDvhzHzt4S6XBTC7TqXZEkb7mv1rtjcvnHXy0SIV6xxB98vrQkRjC6Doyshyg9ds4u1a9qHo7UkvpJOIvvP5nZUr0bDXZmTI8iNcFIxucocDwpCiR0Rl1RAxVs6SVGe4wM8Df9JsQItSs6Do8d3gGu5uj4AvEifKwzCVpL94iA/waA8CSXeBJsCcA+AaCXubQTnx+DTZ1Mu0L67LsGvVDhUv5H7hdyDfZAZU1N09JE2LvsjRTIHDXEkxoYz53k3V1jKL8gr1Kn0gvdd4F1JNpKJDn8e04Gx3OJOdOCO/PJDZBBx+eQqCgyeg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB8911.eurprd03.prod.outlook.com (2603:10a6:10:473::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 20:40:27 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:40:27 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 0/3] arm: Semihosting fixes/improvements for ARMv6 and older
Date: Fri, 27 Oct 2023 16:40:12 -0400
Message-Id: <20231027204015.1547595-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|DU0PR03MB8911:EE_|AM6EUR05FT040:EE_|GV2PR03MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee972e1-8037-4802-d42b-08dbd72cfb04
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 1spvsaS1/nMm27y6OyVgOu0aPzsa9JocyfWX6LDbeBrPDl32auVWzhDjwKRQ7ceXrGoo9VumxHGoNUHbAtlqCvpy+G3EzywvnweKTGl35+w/pCv8FndXqGZXN7xEmIEMlpa29q4zz9khrb5SXxgsmfjtmFlsxIxPNwFv2NSYM9osg9rGReYinJsoVN0e0vg4YxN/tSRmuLtg8npRb/EYEjNOVf2SrvAL/a2Qmw0RNNI7X6Adk7fZ2vIfPVTW4A2zyavZO7Fgb9Xt4NB6mDk+7KcP1hysmExMv5lSTCWOPRlqo29koU6mCHqraERIUvKR31IlZ5qxKwW4TJtsKuhkeWEQ9LlJyw4WTNUz0gYJdKEZpqwaKiLT4P+e6oXahTI0U1kCuTGj48ZypRvE0zx1cN/jBFajSZ/jg71besjH/RlntBY4cZTDMb72wAH0m0TkNqCfeDWnXB9Ae9WD/ugSZKRW32qa8l3jchLwwxx5TmPBc2ZTrSjMMYIG3gj2sfygPCy63LhwcInFX7ctQFttcCw05QYDX8cicVbfC+cfDMWWOZoge4x+32qtYfaQrEz1z3vKNf0cd5pYIZGsq9hOZ6Ead/LNKwp8JOMUlFGZ1xyJyTe2Y7XMIi7FMRd2F2Y1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(39850400004)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(83380400001)(8936002)(26005)(2906002)(44832011)(52116002)(8676002)(36756003)(107886003)(1076003)(38100700002)(2616005)(6512007)(4326008)(66476007)(478600001)(6486002)(6916009)(316002)(6506007)(6666004)(5660300002)(86362001)(54906003)(66946007)(41300700001)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8911
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 201f6dab-5d1f-4b11-3a11-08dbd72cf3ac
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojdifJpr6z6evW+wvHKyHeuFMW2DzwUt7b3MpqzKiAgNp0IC13eDdL9v79aUwaJKumFiavOxt3onRYU3aVd6oZSJFQJur3UewCkBtePuP1r6QoclZA6oLi/58HU/pF7uBrLZGlAmKNN3zVH07OqJAPD+BjA1/66fULfrGZy0Iig9k1vjPjPbzuSr67gmIgByI2YxhYXScL/YVLWTp9bKb1Zgm+ddsaVTtCIhLUnWguX0s9emJa85HhCqZa3G0siHo31QD6a6SUaQYrA0tQSCVgcGSAD/KqPX4qt5HMmWaoeNb1+/ucazy6IMY+g9x7o81Hyey2x3xD2REFy6pItqbnXdi3Bp3YQ592qysfb+u5yrxFDyeYMg/KW1ySP0GS6jTRtC5568n0CESk88stODtthDBX/ZGaBvRc5sqWcWVn2TAaUYWMhr+Ho6rjaRUFDoEWaNnhnmYgzOwKO7/CrfLpb6zMRre+2XQoYjFPP/BrgT5fWpSgFmnT/GwnNk5dACGwKJKQVfu+R/BqZP6cNYYc9Y8HeWN148wcsoojt8v2Xzh/5UCPADBNr5XASETRlxOgwycCUYgaTDegPTF+jgKumyT+arFTON+FVivg6/oBIxlW9R9KPT8uH7+q6MEzuGN+U+asfj4gnemAF9Pp1l3+b11X24p+yFDX6vCQgDzvV9TOQEFsvrp0HTYUfAfKiFnEbkyuv3PQp1UYxw3f1hHC4ys2rkRC/rzbJyCabgXRa9Ie2W500PBKSmnS0TDU2yNzcHnQnJw7HDdtubjIft0A==
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(70206006)(41300700001)(54906003)(316002)(6916009)(1076003)(26005)(107886003)(44832011)(478600001)(8936002)(4326008)(8676002)(70586007)(6486002)(5660300002)(2906002)(6506007)(40460700003)(6666004)(83380400001)(36860700001)(47076005)(36756003)(2616005)(6512007)(336012)(40480700001)(7636003)(34070700002)(7596003)(86362001)(356005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:40:39.2675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee972e1-8037-4802-d42b-08dbd72cfb04
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT040.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8851
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

This series has a few fixes for semihosting on ARMv6 and older CPUs. The
first two patches address problems regarding the stack pointer and link
register. U-Boot runs in supervisor mode, so taking a software interrupt
will clobber sp/lr. I think we really should run in system mode, since
it has separate sp/lr registers. To quote ARM DDI 0100I:

> The remaining mode is System mode, which is not entered by any
> exception and has exactly the same registers available as User mode.
> However, it is a privileged mode and is therefore not subject to the
> User mode restrictions. It is intended for use by operating system
> tasks that need access to system resources, but wish to avoid using
> the additional registers associated with the exception modes. Avoiding
> such use ensures that the task state is not corrupted by the
> occurrence of any exception.

However, the processor mode has been supervisor for such a long time
(since relocation got introduced) that I would rather not touch it.


Sean Anderson (3):
  arm: Fix software interrupt handler
  arm: semihosting: Fix returning from traps on ARMv6 and lower
  arm: semihosting: Support semihosting fallback on 32-bit ARM

 arch/arm/lib/interrupts.c  | 31 +++++++++++++++++++++++++++++++
 arch/arm/lib/semihosting.S |  6 ++++++
 arch/arm/lib/vectors.S     | 21 ++++++++++++++++++++-
 lib/Kconfig                |  4 ++--
 4 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

