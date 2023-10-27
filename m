Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C4C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64CDD87718;
	Fri, 27 Oct 2023 22:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="d1g4UwwZ";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="d1g4UwwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FC487726; Fri, 27 Oct 2023 22:40:45 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00ABF876FA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=kc2xFez2nUbfj99i03jVpM//8kuTlME7RforV4eM5mSo8twY47qNGH4YNz+VSNLGGzeZP0UTJzaHe7sVmdir0VC1tAvkzqKAsC0/nJtmRgQE9oOS3ARus5Q8+GKuy2/8HDqfoeuTN90+lfuVH/vvSBBxizyG2bE1wxImzAIC5gcRAVzGGmWwJJpp6L/HkViFtdx9nEZ9Y0O0G2tRusaYysGYEDrszKCINNWY0RqbFh/x4ZVAtA6pS5YOLg+RfYN3/bylN1I4Duku0/0FkibZOPe33QgsmxGefyae6GNMh9907r80zytTJl6WPxXBNfxbursHQEjsVdNn0r7pNsfmCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJaGrgtMeGT3cUiEhoUC9KONVzDKnjbUJPGca3bsKL0=;
 b=KQOz1PIRRlb1ol0OXquJOq3wGMyJk2oeXVXpiYrjkasGQhJPBtY+lgeccXlsdsZ7doKrxjmdT3hLS1iHTF9NqUuUh99tr22issqpSgDsCsTwGc3Q5wMGkk3CmNk87abG/bYAfMom3CcTgyq3iowV+FUBri3tNCcCztpQwLGWtficObmV89J2zruv+cqGC3vSV2AstLoK1but/YBH0bb9o52T60YvkUXAXgyHxrwdgSZ+6JY9WUt1g4fbw7FGTTjTGapRpmKspR5/7AiqCz0mJqfnCigVUVNXSLprGSRntQAfoXLa8ZefAhWBc3Q5C+xRmic7EokrWoYJovH8fNXh9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=arm.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJaGrgtMeGT3cUiEhoUC9KONVzDKnjbUJPGca3bsKL0=;
 b=d1g4UwwZ957bGhf8okTXkPms221Imt7GcJ+syHyn27SwzktXIfsINAfj2pktajPt4nT3SFUNEQAN7c8zkDdicKlnIBzsPu/IijJZs8ivx6GjjaBg57f286aAsGIDtHs/S31m3kVCqCcj9C9XWS10ZGSgG98Zead6EL7YWv/GzV1Ldg4AzSPFI2icf0xIX6yNHw/bQZwdSZ7KtiiebpHwvrCZudAj80ojZLlLfEPKSIHXB5DK5sEMEJ3UwpNDktX/k7qFOb0wbyfBIFss6iM1/vZOs2WB5oiA9Zn7CU1BOJKw/UxmT4/xjCnFywN/64AOWGn23z8JdkqwnCwURAVTrA==
Received: from AS9PR05CA0101.eurprd05.prod.outlook.com (2603:10a6:20b:498::15)
 by DBAPR03MB6568.eurprd03.prod.outlook.com (2603:10a6:10:19b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.20; Fri, 27 Oct
 2023 20:40:40 +0000
Received: from VI1EUR05FT019.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:498:cafe::ac) by AS9PR05CA0101.outlook.office365.com
 (2603:10a6:20b:498::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 20:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.81) by
 VI1EUR05FT019.mail.protection.outlook.com (10.233.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.12 via Frontend Transport; Fri, 27 Oct 2023 20:40:40 +0000
Received: from outmta (unknown [192.168.82.132])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 D08682008009A; Fri, 27 Oct 2023 20:40:39 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown
 [104.47.51.168])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 3D1982008006E; 
 Fri, 27 Oct 2023 20:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH+nZR+5+WAKyhFrhgXrc8UQlHYU2hW1iTrtXFMAQytnPAqE03ZVCQ3rHbz/lPSntUsyCL4gAEetca/CloZwr0YkVlmhyIoRIhuEX8bMhAag1RVXvxC5Bx5/gdTnPm2aQlE4xJ8P9R9B/1xZYbiWS+IJHpsKFmJ1XKv2dh0vtKWVFwj98UEyhiGNpepzb2wYKinCW9fdotlbVreS7CO2Jb5iU3XSh93zhng8ak1L+j47wpEaI1dhB3z3lhMdHE2JCay2XkwCaIdeHYUUnh0qUSbl5bQWhibm+MXXHR4AYgIVcIAa69VK4bKsq0ouRoqHptmeAkZcUpMZhs9xQkRxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJaGrgtMeGT3cUiEhoUC9KONVzDKnjbUJPGca3bsKL0=;
 b=OUU/tqpxistLecatLOHLnyoIJ0Olpsy5mBCuzNUonrF+w+DIFbW35dprVl7qOnSYxKH7x8Uj7dUBqRp4PtVWDQvMIfM0WPc07TzL0uQQ/kphNFaShg29GHm9mWlxLH7LuBCx3f7ts6ShjUEoL5h5uuq3GWMYVu39+FgBQq/pqdDTStekPNtsiEvtOdOIx3QLJ/+uSvdxXwv/pAhjZOb8sV38RMB6YQqlvkk3wmXN3Akb20FyMNXU19xNDrXw9hcEGIUVITlWZU3DzMOKDgUox89CSp5fBBR90fr1oaCTfS5qYwmNTIvFyrUdF/Isa9hUzwUPFbG4kaPQZh7BaPka0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJaGrgtMeGT3cUiEhoUC9KONVzDKnjbUJPGca3bsKL0=;
 b=d1g4UwwZ957bGhf8okTXkPms221Imt7GcJ+syHyn27SwzktXIfsINAfj2pktajPt4nT3SFUNEQAN7c8zkDdicKlnIBzsPu/IijJZs8ivx6GjjaBg57f286aAsGIDtHs/S31m3kVCqCcj9C9XWS10ZGSgG98Zead6EL7YWv/GzV1Ldg4AzSPFI2icf0xIX6yNHw/bQZwdSZ7KtiiebpHwvrCZudAj80ojZLlLfEPKSIHXB5DK5sEMEJ3UwpNDktX/k7qFOb0wbyfBIFss6iM1/vZOs2WB5oiA9Zn7CU1BOJKw/UxmT4/xjCnFywN/64AOWGn23z8JdkqwnCwURAVTrA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAVPR03MB9211.eurprd03.prod.outlook.com (2603:10a6:102:325::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 20:40:31 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:40:31 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/3] arm: semihosting: Fix returning from traps on ARMv6 and
 lower
Date: Fri, 27 Oct 2023 16:40:14 -0400
Message-Id: <20231027204015.1547595-3-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20231027204015.1547595-1-sean.anderson@seco.com>
References: <20231027204015.1547595-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAVPR03MB9211:EE_|VI1EUR05FT019:EE_|DBAPR03MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: f0aac486-2f45-4acc-25db-08dbd72cfba5
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gz5xKNO/fNelBqRzEITD4eB08U3Kd2VcXLZxU6RzPltdV0AyZgQK4fOQJ9UhEmgXydioPXmcflZ+mxyKJ+zbvu9dohFd2gl7TEEcs2Ml177VxY1JZAFMXCi6RU1L/VPYx5XsXhgmut0K+SvWiOwnd9nNmxEDsN1xBrAABTl51qAvFffOaH+F1BlSeXfjpYbxYUoojw+of1KIJWQ/KbRIMROA8aYT1IBCeBC3gFXl/6+veSOnL1Gfa9Txj9GjCZXPSH7HR40cnkuooBNQLhuaqwrWbF9b8Pt1rze2ktWj2c1B6umRaSh5dMhC4GofDDkzW7rVASXGWQgeQmslY1y/em6w08xvQxLo1ClwzsrTtK2baMbytVj5F6oxdLYihng6+rW/dvVCNJpkhGDroJV3JKVq1GR2q9hLElC65nqRwUqOO0Kw7dWuW+Il7BEgdZmRGXmDWSr5i6Sxu91JirqgXruoGebiO1YUHRE3c8mLQa36i3J9BczCdlAGyE5JEK6x1luz0RbuVJttghtFZuM/GNVVbM9kXcGEodIASLmYhr//2MvcWkddyeShIZ+ikLb6CimOe7GmPbGYOvcj6Hr3xW6lHzMkWj4dim6msKjXvPtF3Rq//FV6UHE7DXNzWl8L
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39850400004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(41300700001)(8936002)(8676002)(54906003)(6486002)(44832011)(4326008)(478600001)(38350700005)(2906002)(5660300002)(316002)(36756003)(66476007)(66946007)(66556008)(86362001)(6916009)(52116002)(6512007)(1076003)(2616005)(26005)(6506007)(83380400001)(38100700002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9211
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT019.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c6392933-e9dd-49be-e16e-08dbd72cf61c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rzo+5N+hB00XljYuy88NgP286bci+ZVLuSpZN3erfR3zedFqylZRjr+hk2B33uflk7kxYujbNIZ+kW9UCUzDF2vji1XmEzU2EcXOhYb/d/q0PtBajIDCU1nB/+FME0HQwPZhvRvz82ipUeYUUJ6XNUFJWcERcx3kF/IUPwgUhr2HprwHzDYd1kvcFFE4V6pqiF4nQiQDRZ5WwJKYNHrLGP72/EegM0YmkWE+8AdXrgmL/kazpcb4Mpg9i6SwoFSuhFpRQDAzQuRwMw1uSSPDmfDnPAo722ZwKeeAErbpBWoUEsxWAnzXeFvleY8iISj7yxrE8CgUEkuA4IC4qRM81qy2vuP+ENpIqEH/faKaPOXNbzf8GKbczifjz0uGq6AiIwuISEBB4yhi9F2kR+hEfwN8TLfdg4G1l5fJlglmJ4FjtCj713xaGelNCSpP0CsYA/VlLu+5nhkMZOvcf/S+bP3hHT3XUW3N04Bbcc9w1qHDMNy9B5E57lXWwVZzQDD/yOsMq/PbgDaU3P92ivg+Y2kv6xyEDW7/Csp6zUYWmVGs8J1xgxfR2BIbxYiQ8AztQurRkuFraxuzi7mVx0pazOdAesbXcV4W3Sv8fjegwBa5T6Teft1ecdTLpbKO8Ia1CBzZ9YBntNU4v5e8SD2ZxRX1tGCxCsOofyTyhf9NkMIIQnnx/MgzEiDYHFAlQ52XXjrm55wupr5NRCU51T+Fk64ZirF5PjRZXyi1IQffE1TJDYg8HiLaIJLMnS/tsmJa
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39850400004)(346002)(396003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(46966006)(36840700001)(40480700001)(44832011)(41300700001)(8676002)(8936002)(5660300002)(2906002)(36756003)(86362001)(4326008)(36860700001)(83380400001)(6666004)(6512007)(6506007)(356005)(336012)(6486002)(7636003)(26005)(7596003)(1076003)(82740400003)(478600001)(2616005)(107886003)(34070700002)(316002)(70206006)(70586007)(6916009)(47076005)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:40:40.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0aac486-2f45-4acc-25db-08dbd72cfba5
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT019.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6568
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

U-Boot runs in supervisor mode. On ARMv6 and lower, software interrupts
are taken in supervisor mode. When entering an interrupt, the link
register is set to the address of the next instruction. However, if we
are already in supervisor mode, this clobbers the link register. The
debugger can't help us, since by the time it notices we've taken a
software interrupt, the link register is already gone. Work around this
by moving the return addres to another register.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm/lib/semihosting.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/lib/semihosting.S b/arch/arm/lib/semihosting.S
index 393aade94a5..6e1691a832c 100644
--- a/arch/arm/lib/semihosting.S
+++ b/arch/arm/lib/semihosting.S
@@ -18,11 +18,17 @@ ENTRY(smh_trap)
 #elif defined(CONFIG_SYS_THUMB_BUILD)
 	svc	#0xab
 #else
+#if CONFIG_SYS_ARM_ARCH < 7
+	/* Before the ARMv7 exception model, svc (swi) clobbers lr */
+	mov	r2, lr
+#endif
 	svc	#0x123456
 #endif
 
 #if defined(CONFIG_ARM64)
 	ret
+#elif CONFIG_SYS_ARM_ARCH < 7
+	bx	r2
 #else
 	bx	lr
 #endif
-- 
2.35.1.1320.gc452695387.dirty

