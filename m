Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81950606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oKqrEmm9;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=Jm1qAvkj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42C8880AD3;
	Wed, 28 Oct 2026 01:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jul_WdWnAX1t; Wed, 28 Oct 2026 01:33:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 37BF680C53
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793151206;
	b=q2QoRYZQ6uoENdLvORrcqzXSkBn735sJhl6k4F+WT5diglbCdGgLaNgux7O5GH3AVIxG
	 rAXCsxXp5gYI2ggqJJGAobjfmCBNkX+Tqz8lZIdlBUk8UmrmPoSlg4HEZj1K8CV9ODxdz
	 DxTTNUcolw9DZNJGKwADMOPoFw29TMM9U4V+GwDyritshAi5c657cMt0yUNWhDx04GPce
	 Zy9+TragQwtkdtG2tOE4xt6TEX3aX2z/sh8FNmw2kikyE6mdz7IF3Bl4Hwmj5nPkaQ3AG
	 IFHq3pXNbIVbByRFufbCQbs16jM0m4uJxP1ugGVLmcgefbHtg09pAG5Ir1b9/VlmSeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793151206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=m2LKLvbV8wLCJ+s4b0SFyOyQ22Rmx1VMiL/8nFjIcvs=;
	b=P0VhS7tElwVjtO7aAGsp0P/pthdsl5JSd+wNmMihqwlMfcrYCmpMWjmtyf4rGLndvw6W
	 xIte+Cq2TooGdVJmzxtUJu17MOQkNPZwhJEY25o1wFIJ3SL/X4JFWNvDZk7RniXfSiIkO
	 QyOimh89Spv8NDQh5lnzL6z8vrk2zg8KmfCVaa7L+ayBgIxVqjSGk+gahwhGf0tYQ3tMR
	 H45UhqapXS2BP0MLxwDr3fcu01x82XmqaJQpvdYJYjBIdYUj8cqF+d/R9T+exHc2bp3G4
	 4+1/ohxPif9EzwBfhQHs01zzOE9r9do68EtQc4b7626NY5JC2S97V83ReK4JxlbroTA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793151206;
	bh=m2LKLvbV8wLCJ+s4b0SFyOyQ22Rmx1VMiL/8nFjIcvs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oKqrEmm9VD2yEukax8pVZkrPzr0kBsT4GICMEDJ1dmOAz0WnkgFHgQEyFAIDGLCLy
	 vHWTfn5Y/6B2Wmo/eOs6IOyKSggHXZ6Ze6SCTLSmbXAVdd6UHPslZOx3Pa21Ev+wFH
	 rPTIdezAmf9aG7KJbCnoPz5i9i6tJbocA0JDVvQvbURsgRosgRu+SY3hSZdFrJmriv
	 6zz7H3yBO02mUb0ES0rGYNU7UQaQFPGnsLL2mJViOORg563Bzfy9/tQfP+56lx0VUY
	 LDaMnaUr9FY2FTounTSvMCaVuZP3sL4OcCc6MW0rDVd80mxAhKeKJflMYkei1VYDpx
	 iM5jt6dnAZwPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37BF680C53;
	Wed, 28 Oct 2026 01:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27BD34D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19B97401DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N5rmGotwHSoJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 01:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C83884006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793151204;
 b=nixO2fMWQlPggMpPB5uyNibSpwB5gP8+snoEITjWejStYxQnTNmM8SOogE9UitkSb/1Q
 hm1n4ebNLW8qk4EJZe0eJk+DGOdVmEmFLAgzRGfYrxTqei1WYNqDP+o3bDqscvseIbpmX
 q3Wr1nVeNmVswKGhuhXJ85BhWISj6Ra+Tn0AXRcKCmWFykPoXrk2At4oDmUroj/vuWxpf
 UC9sujyuPvEPLyeLrdyQy0zfFIMYjauN0O/YtKYPpeuB8IzmTMihBdrCt58g//n9Pwo5d
 O6neTP5PrXWMWMBSt3HIfsY2+3ZPHD8EQkZ/lLFRJdsXBl6zm25uwDZwojN7k8HlF/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793151204;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=m2LKLvbV8wLCJ+s4b0SFyOyQ22Rmx1VMiL/8nFjIcvs=;
 b=ID2SLbCUIsKrnTjJg+qlgkiqE9z9yz7/fEJpzl0wAxtZxmv8/OaU5KA6p16eitaSCnwj
 b+n0oXoWXNLw61PT3nf2pyOYMCT+RBixy+gMRT/LR2WO+ArmqGk6hHn9t/wQQ7s+kXZS7
 C+9XUL6EHSUshOnR/m4jHoQcwxza9zDtjHbHPgCB2rXEgJf+EN3YfTZQaHdmUWT59kcDC
 ZuAiJDrfkjrfbbMGejedzpihkH1v67UmYocxmEJGBWuNYo/vxYJZ+guYBuKSC50gciqgZ
 numtYgB6k5f0rNOCZS7tqnYCp34lB2TqEjsDqr07kCtPR7b74gZqeAJnjnAn9k8mbMg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Jm1qAvkj; 
 arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=Jm1qAvkj
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C83884006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:33:21 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01AEB84119; Wed, 28 Oct 2026 02:33:19 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE8383108
 for <u-boot@lists.denx.de>; Wed, 28 Oct 2026 02:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhGIysV7+Z3XpECAfNYxdH9XWOSDMMb6ALtMYCPIvu+JyJRzS6IsaeQ8JKkPr7CEQxkbgdz+nz3x90DUjdlHHYmReFTlky4oaU2M71b3QkWhdoFvGKaTXEWno1tnqkm4T14Y4RuhKFo/5DsU6ivUAgcOsqdvnOqA8DqVjXZlA1WDooWb9snSGAf0qPGrLOeu5EzqesX2D/7hYu13QMIHJLqJXUoWEg0mjFHr9qDBszLViIpUiANTy0QLqUEFPjkbH9XKXM8/Bg+qABi0ekNCxAISBpIk9o0z/FOvA14L9DYPvcyGblgHXZRkM+9eXhCGABWDiBq7rk3HbRsGZ69iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2LKLvbV8wLCJ+s4b0SFyOyQ22Rmx1VMiL/8nFjIcvs=;
 b=wEz2gyrgnxGaxCqQywZIl4ojsMRJ7SjotHAOIL9hmGXAMRtDezgTUWd6cM4K880UxFiZNhJkwnlWP09NjOkjHGvc/A3Qpl9PHgFcNvUhYiHCmcsxEe1X5XtbiY6w0NfZe9H32hO5LElex0PkMX51oE+3LMespkJHg4sPF3mZ7kHA5GOp59K4iFgug5+RbnCHWOET0RKuzyhE6FDxdJAn2s50w4DaXY4Kzdwg55a7/DGPnpuZ+iz7Fw84NhRmOnHj+kB4Paxk9CEYl269eEWJuYwVfiEReKZ1zZq8pfpDkoh5lFMzBKp3HxQ5iy+01HmUQUDbAVga3ovfx7NAwfF8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2LKLvbV8wLCJ+s4b0SFyOyQ22Rmx1VMiL/8nFjIcvs=;
 b=Jm1qAvkjeNP2aOVAwer4fgn09qGy03SCp8tLrmQB/RGCx5xXd+h+JyYuEqHnlXWFkrQPlDBpEgx3umF9x1mseVtLOyRvMOoXb5WTLzVMaXd9AMeO8O3NgrmYTMz7XImooIy8/MfMhUTPHpf+1up5DL0hTeSeh/v5eyljnoXiV4jNGVBKwPDpLTXUmCZKBFJXwFC82eSK0n9TqcbskqrR8TTo4rnGtBvKMtBRBapgRD/pc0ovTdGgKMkTyYuXcFveuPAB6Ap8oBMpPV6PAxB8UYWOj92srj3I4EJ+WVL0gvnsJuvh6FsCU+hIIYTfpOSBNucFPOC77E9EGDkZebITRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MWHPR03MB998666.namprd03.prod.outlook.com (2603:10b6:303:2a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Wed, 28 Oct
 2026 01:33:07 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 01:33:07 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Bitao Dai <btdai@terasic.com.cn>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Standard Board Support
Date: Wed, 28 Oct 2026 09:32:57 +0800
Message-ID: <20261028013257.8553-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::31) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MWHPR03MB998666:EE_
X-MS-Office365-Filtering-Correlation-Id: b10f6b07-e7c8-4605-13d8-08df34936ade
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|6133799003|55112099003|3023799007|13003099007|11063799006|56012099006|261021121427099003|261026140227099003|261021123027099003|10067099003|261009223327099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261022113327099003|261022075727099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: cm2TqdWQDHt45uxfZMQ0cAxiwIklk9bOy4K31EhHmjiFiNQeU0TEEP9hrKafr17TkK2yYy1RlRjIwugTRaNcQahFlFJcDx2XhFijtJX/fxunBZ+GpwimlBAO30Boj7TvABjC5z20Eu4WXP7WcQcOnIOGFzJ3phscUlx8hOiSY/gxb7eRTxCTX4c0h+F6GqhprGc/IXuVKWTVI0tgFM4mNsC+rUKjZ7fh0xPHPQBQKa97wqirMOShB6LLm3rLeAMBXzcESSxatff4QXDf+16LlxifGNcBfeyKfG3c/q7NJr16M/aVD6bMGwNLqqDa3p3MZIPLW676GAGS+RY7MwXnPUaMx4zJWHKm52i/wAwyVCBtqCwHKTPXAY0ZnZtUO7T1y4q4m9yJxeFX0rjOe1v+/ehdN2WF2KuX71JQgdbAt9pfkkwT9jV1dfAFkkyeMC9WUy4boehJJr7CbHwBz9Eubsn7K9W/zT3sv8FjE1o3raX4Gg6O1D93eS5yRUhQ6Q3pXCWBlVdgR3O/DQhwx59WtW4j9WbTaCMVzWTI/+cHjlVyf7UOxMChdmZWTa/jw/MY45vcHKJU4dJzzOZGIdqlGoKeQf2DhUE9PRCHF7YADXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(6133799003)(55112099003)(3023799007)(13003099007)(11063799006)(56012099006)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261022113327099003)(261022075727099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UurS3ZEa+1IGF55WlZiJeJib7SldbPEhWsPJI1T5nB8YyyzltmuaJKSqOvh/?=
 =?us-ascii?Q?OcRO0zEiTZR8LoBn1EQUhnCiOue16hYS8Wa/OZbR546HCvVPZpOda6+Z7RcN?=
 =?us-ascii?Q?6oC/+slbzRFxGtOJJZyg9ptRLRfqzbjMMyWpv+J75nrumUTd9WwGxyE9mdn7?=
 =?us-ascii?Q?DmU0+1iMyQLUchffWqGRhc3oEnFuDnXJWU3dHRmbmPcwAdOV4rjs9aFsbuBv?=
 =?us-ascii?Q?4hoqPiXWWaOU8a5cfCKJlcJFvWkabU4cWzf/YLDDyfzoQeTkLYKy1qlkz3+C?=
 =?us-ascii?Q?uQEpbG8qpHLPOHcd2UK/1CE8JlSauP9XQAyk/E9pCiNjxBxWiTszTjHBiHI3?=
 =?us-ascii?Q?wCCQdzloHP/3147f31db8tYyzbvtW0BCJnJ3ohanDTFwIdaM6kB4LDiRLKgI?=
 =?us-ascii?Q?GfF5ByNJU9KjeJEIeQQThNQ0e+ErYaLh6tzqX6DnN9jTYXmnM2680S6k1R+9?=
 =?us-ascii?Q?KbBE2uvFMcKeGEbKBF0sNxueQHK/H5cCAwwUZ8Ql4SgKoj0yBTqwcLLpBW+x?=
 =?us-ascii?Q?K2WCc9pAOZ4FBDKXUEPRldSuqOVGdrSjHRAj0M7+5pUYCBBfgqVSNUq+G/z5?=
 =?us-ascii?Q?ggRSF3vR4rt4O9FBwV8Nq2b0IwscNy46ULfIBbgXZr4pFh/HDKcTMYg7BrUj?=
 =?us-ascii?Q?KyVzZXIfrx2CXoR8bkAoraZoAvQHZVdhS+JgJB+/1r3MMrnisJQojfWBrrBY?=
 =?us-ascii?Q?daPDDM03uifkHU5Jrrfu7NoT/3XNvQTfIifmnmujK5en103qrp3hYqEaOCqC?=
 =?us-ascii?Q?Y3p1qU5WTxyAuUge1XyjH3Sdpj5Z8hhhn5yP5bHEQJ4X1cEC+wtUf2FX3Iuj?=
 =?us-ascii?Q?QUmluzAiJFN5en/gaUYFVRpYkADNBCuFExHKw7zY8YWVSylwLc+8GOSWsS7Y?=
 =?us-ascii?Q?oUM5dNlEyAs2KdgXaBQvcdbPPxspJW0M6V5u1tBFmuFWeJArUIMGyngZYQX/?=
 =?us-ascii?Q?VVKNzHtXpOb2egoEobYQPSNVyialwrFHylZq1iImdhyi8sZX4U/BJXLZG4sm?=
 =?us-ascii?Q?d+h7XYGkCF4AKntYJ//91izDAxm2HvWsVy5wIXtI2R8bEXpmTUB5bZsPp/i1?=
 =?us-ascii?Q?Nm6sAM/my79Z0giiEgwkZT3sPKuCAG94UyARiH7GPP4c47NxgvNyPET3mIZ4?=
 =?us-ascii?Q?jMp/ciBNd1mIH+TTH1+M/NWjw2UUr3cU0cq14OFhI6wzc8rRfT3nIpIUrWeR?=
 =?us-ascii?Q?ya2HfEKLRpLmxVrqf7TztjM1P1F2HaaHz7U/SWSdGKzZBtWdFfH/1o/0zAWP?=
 =?us-ascii?Q?nU90VhqaJM3Snf56NPwFcWJeQSucCJF4u/VPmwspEhviy0t17Bn8H5q+cwm3?=
 =?us-ascii?Q?iih72Lgdh08/K/+Lwy3Gdi+/hovnlJPsxKePGxvqNmWHXZ+H1C4SQhd6HNzg?=
 =?us-ascii?Q?EU6OTnD/9pSzyIrr+dOJOzuU/dg0dCesk7i9STbX/gRJRPXtclP1w6wvBQ/h?=
 =?us-ascii?Q?zfOWJYIRM1EbaP/k1y1h7qbr3bS1wcDUvblndhNPSK25Mq+EOfiHsvV6Cl9m?=
 =?us-ascii?Q?f4IwTCfS9RpAvOvPS9bplAbpq8U0dRfUoKHEvLCkDzMmJk1T5ti1ecsdimri?=
 =?us-ascii?Q?kFk02FeohRoL9msRtHWZHEd9AtjKw7k8qWwyUx2xd6VOgf1n8vk+/kn/G8+p?=
 =?us-ascii?Q?98Z8nRRog6lKfnLZOBI/C5sxJ9y2V5H9OnYsPhMSm98E8lwMOiGwutA5hj/F?=
 =?us-ascii?Q?nU5ygCNGD/Xkuuuxze5BeN03no41eMzsX+jHl5rv6hKighXz7dQXOpsHRXP2?=
 =?us-ascii?Q?lhhaZjOFy5emW0KqMeMCVhANX2xLXR0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10f6b07-e7c8-4605-13d8-08df34936ade
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:33:07.1142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVfmYgA8vPT0MJBVln+GQW8meB4p2dHncBRtfdfAMPsGr/2gpEtqRU6nsZZ6Q0ZfDA79RU6p8gb9u84tZdWdyxzK7JGChDn/OHM6lWTm5aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB998666
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add dedicated device tree support for the Terasic DE-25 Standard board,
which is based on Agilex5.

Following Terasic's Linux device tree for DE-25 Standard configuration in
which UART and board wiring differs from Altera SoCDK boards - enable UART1
instead of UART0, route console through serial0 alias, and expose a single
HPS LED on GPIO port B pin 17 (active-low). Enable only the on-board
peripherals present on this kit: a single RGMII Ethernet interface on gmac0
with PHY MDIO address 1, gpio1, i2c1, spi0, and usb0. The second GMAC,
extra I2C/I3C buses, spi1, usb31, and NAND are left disabled.

MMC retains UHS-I SDR104 mode consistent with the Altera SoCDK reference.
QSPI NOR flash uses the SoCDK-style partition layout on the 256 MB device
(dedicated u-boot and root regions); the QSPI controller is disabled in the
U-Boot SPL device tree so that SD/MMC is the primary boot source. DRAM
base/size come from the HW handoff like SoCDK/Nano (no hardcoded memory
reg override). gmac0 uses phy-mode rgmii-id to match the DE-25 Nano
sibling.

New files added:
- socfpga_agilex5_de25s.dts: Main device tree
- socfpga_agilex5_de25s-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_de25s_defconfig: Board configuration

Build system integration:
- Add build target in Makefile for DE25 Standard device tree binary file

Signed-off-by: Bitao Dai <btdai@terasic.com.cn>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---

Changes in v2:
- Drop hardcoded 1 GiB DRAM reg and rely on handoff following DE-25 Nano
- Use rgmii-id instead of rgmii for gmac0, matching DE-25 Nano
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex5_de25s-u-boot.dtsi | 198 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_de25s.dts        | 157 ++++++++++++++
 configs/socfpga_agilex5_de25s_defconfig       |   3 +
 4 files changed, 359 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s.dts
 create mode 100644 configs/socfpga_agilex5_de25s_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..45709953c94 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex5_de25s.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
new file mode 100644
index 00000000000..bfded3c93cd
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_de25s.dts b/arch/arm/dts/socfpga_agilex5_de25s.dts
new file mode 100644
index 00000000000..6f7666e7a8b
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s.dts
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Terasic DE25-Standard";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart1 {
+	status = "okay";
+	bootph-all;
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0BE00000>;
+			};
+		};
+	};
+};
diff --git a/configs/socfpga_agilex5_de25s_defconfig b/configs/socfpga_agilex5_de25s_defconfig
new file mode 100644
index 00000000000..6b99626f2ab
--- /dev/null
+++ b/configs/socfpga_agilex5_de25s_defconfig
@@ -0,0 +1,3 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_de25s"
-- 
2.43.7

