Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E5AC624D4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B66F810F4;
	Thu,  3 Sep 2026 08:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aGzVy1jj8lG; Thu,  3 Sep 2026 08:17:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1F5E810F7
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423464;
	b=Q7e3D/Am+kZn5i3VoW5vVhqu+F/cHlL5HvmFKT+p7bY5bNsI2Nbg11XN8FjSk2Dw4rbz
	 ZekMAzoaPsUy4yKl/ivwWEmYe1Q7ffonoXZDYXt7eRNEPgto2v8aBPFL/60hd2ZK1Cg3r
	 wts66iMYRSv8R1XM3Tg+eHjG31Z3nCI2nRdVuHzXeQmhUvDbIUWukI9KT7+xr/h/5FAA0
	 strTyi03hsWbtFpHDaJGWWEy1I3FI2+YjriOgAuEqkO3HCCB/jBeeZShJ5fL/VdS3c61V
	 ktoHahD1ysezQ6kH0nUhdbuWjc5XcrM4rCo444Za7Uf8kHXCyK0ZfAtkEVfBtjaQnvQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=ptp8jOWbGPxpSVUMeICZ4pwzB7EuM7uXBKeZLyiCzPQ=;
	b=hZDkpd0MUEJttDSgfXPhN5+IM+AgSR3Fkkl4qhZXqLD9Q13/tXcQBhgm2VLiuR4b+vA8
	 Idqxc22xPNbRmQzwKSdIWhBFT7vYlyfccbFubgDupKBGGjxJZBRboehyzFL06lRj9nZBx
	 uBR9uCHN4OReY2dB73CMGAuf1v6nGiQJrqlkYrz9J6+H1k/FQCN+sbvsX5TBTq9sejTxW
	 g2+hAWrR/2Ok3Zgzi1RxbPVJVGsMtWgf1ev5lCwtBgo5c3+2/vOzdLOIYTz/sbdtd4ahl
	 wgzpFF17yz3aY8P6fzL9rpfZdopdcVsDQFqAeHRk0KfEtg8MknXoFvgfjVrRQLzSGDg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423464;
	bh=ptp8jOWbGPxpSVUMeICZ4pwzB7EuM7uXBKeZLyiCzPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bz8crS6SUlxlKizeV1z77V1hPOQAcNXmdCDwn/zUH5n6ekyxjeADRdkoMeAvSSj7M
	 B5Fm5aNWjC0+Z7qomvTLGaKvEXxNjQwf2nNVLXi06UorA4hnLH1SeCJM7HC3tSIfWy
	 AZhFWPSVkaG+gcnmwmGzw7wwiL2zKddGYp1sWXBO6GhS7qbTY0hUr/cJdY6y9/KE9c
	 s3ZrqwDB5XGoLgriI8wSVBR7YYLZZH65ulU/iyjnuWNgb8qyNUjFXql9mwcg3GidjA
	 EUakdfpfWxUA1YRqDDGmgj4taF5NYPVQL1lkkYHr3D7/I2MmB2qv7bzt0j+sScMC+N
	 Htvtpd5JouhTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1F5E810F7;
	Thu,  3 Sep 2026 08:17:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD8DA118
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF293406E6
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P31vuWMLQzPb for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CB59E40A98
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423443;
 b=grxXrSHAiZuE58fSBVaXddtF0nGY+ap517kQsHOFn/gfRlBPC3T7zusxnZYoh83Cefj6
 3JbJIfsXGu7moSNI/zRBTFt//EovGSfzM0Ve3EwzZ/6UPu+MlFZiUWSHb/PZ8WGJyoi+s
 lq+OBvRRb4EmZtaTbXJQGpYugzqiPKPiU5fqEhFtenkk/5fXIlr1SHhvsEktjO3eidwuA
 VZz8J0yF9VjjT5/p30ufwgyKUV7svM8/nh1PqUL50TadJ0e7kMmJyfi+2kh7dgSfALCxZ
 pKzK9sQ6P4atKk2A4txuC7HXPBIolHDi//DpQM9rTLCnRT+6IcFdv/NqxsIsnZQagjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423443;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ptp8jOWbGPxpSVUMeICZ4pwzB7EuM7uXBKeZLyiCzPQ=;
 b=BDT7fdPCemnW4UhwBURk65GjKm5mWjrgPrIw2C4K9/GZmhxYMnzxZ27wujOygHAjJnaH
 ollQoFslRdN6PaaEoXzTGrHdaEzL+vEEPE3/a1K08kzlngnqCgc+uHd1bHjhUE+x9pJGP
 54Ohx59zNA2IFVqun3jvZcjlREB4m1Mks3xT7k0g2JoELqwDnrsg0nQ/bC3/vGOo4phyK
 c/RLuUuaOAGc7VpqK9wmyGGgRx3ylJzDwdneioLjlKceOO8WewnprnntBu1iQXWWTIJu1
 9Vpoq+UA0lASroeKmucW5Sctodhk36tuONMCqQyX8SHk+19KEopnkGfc/eNDT3HGT0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=J0Uzpmoy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=J0Uzpmoy
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB59E40A98
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdVHXM7ATueQ7zeZxDt2xRK62tGGxOknm2ZHopzO+14tjQlnf0VJ4b/V1svnj5RIRJs8Y7P0N8065C3Jh4j7FCU3u1oLyxwZfgjqwrEnf6TmZ5nZv6GbKKiZJpIHFgMaioeD/bRaT5vGbVrc6yVeHJP+6w35Dp+3THGdenrbQf69pYxQ5LMpeURKmWNwmILXX1zeaAezoafDUkWwBv6STqxjy43zoUsf3Vvw3oVUXapfgJ5GOboCwFeDeagJcYRElkLQKLifkrvp97MugdUJp7QMR0avQ27tDmOZM2HMxA9xYeIhfVbYPsSPVYXHguPkDwRt9XvQRKGpYojU0kuRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptp8jOWbGPxpSVUMeICZ4pwzB7EuM7uXBKeZLyiCzPQ=;
 b=C+2ODjWExjOgf6O9q5LljtnQIWnk8G8zw4gZ46mkKsIu5JOomY+2gHkiiasejEzL/Ok2V32QPog4uN8p4wFxiHwwfUGEezJEeUmDXPBM5c1qIAyCxjcRyXshYKtmqX5M94K3Evp3WcgOdZyKqAguSEGaumjgW8AH+cBiC1Z5pgxSM9grNrvfUBqHty83oRINQl+dQuL9fCvAvUxduosLBxgCRrKzNQkYB/kYN7shNgQOwYP3ZCl3hT3Gtq5doEVpBkfCt1dLiCu1KlZsbbYWWQycRoDGuTKz0OWlG9N2XNpf5HjaeiJLKRPp+ZKIHmiBG5clNbqh4Bl8jvG6tkG1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptp8jOWbGPxpSVUMeICZ4pwzB7EuM7uXBKeZLyiCzPQ=;
 b=J0UzpmoygL2ajXYsc+r6JyBX4gqyscoGhUb5gS2YT/IKH0FK8iEUlgB3stBiTE4O1EVvVrTWTnMgfMUGXDerKH+JbZu6pUIFlBeTzOJ8pqWgAxV2LQmkOcQJBeha6On30xSOi1k5El/4mW5lwE/rc91PB4+qyJhQcWmAFCODqOTPtFZRlibfnE3gQdmcJc6dKAQS9jxMmubQB47qXkqN2L6uQFdHzySemshsmyizTFe0NSSGzvHGR0sS5hPbZfUyaWmL6Inoc+qYiNFYkmlCJVxTK/tDqcdFELj30VDIejrZ3FfIxdpHFks0kFK3dpmI9GqRH+qAE1ymTfxaOalCKg==
Received: from MR1P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3e::31)
 by PASP264MB4849.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e:cafe::22) by MR1P264CA0039.outlook.office365.com
 (2603:10a6:501:3e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8FB2E202C3;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 05/15] drivers: crypto: add software ecdsa support
Date: Thu,  3 Sep 2026 10:16:55 +0200
Message-ID: <20260903081705.12894-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PASP264MB4849:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca2a7441-5e9c-421c-dbfd-08df0993c46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 683ha3GKL543eZFhftPjLjoykDAcSB+FSHvzWwnygWzosrK7hbPW4xrRzhKwcgoWxy/7AoDB+KsSMYuec2baXg0YMQt0Ac8uXj/dhoUIrgqzBQT15AY96aKMYNgxQmpA8ozhN9FqXCxS7rbzxzgiCVpePNAELwScnqmkR0NPtN+5HFy2bqCf+hVh/OmS0zjstIXjioeRmHc2m6rP3oWfHB52NgDwp1dzzIgxtGRHHkzOS4PzsnsCKsMOMz0omdHbW+M4mkJR7e2g6xZxf0VMsDuCltBBFIbcrX3Y0cdLz78nEXI0q7dwulpgpEgyqiE2s3w5lVCzIkahr8Ens6gPpxTUxMkUYlVxsMe0fGIzrh2t/TSOdgz0dLw/WBLiTIusvuASnQTGS/CBsD5Ovb9NOIx0AvPQ1dlUBAJ9oPHXnv8kTi1n7XeibhisU30uX35hno1uDYTc0698w/mhvG6kh3F7/PqsbkpER5VPaqc8Icbca3CWI5vPACu1c8GC1h9izM64Ln3Mdf7mbztJIEFfrWUyI0nWXCWzKUutgWy61aVctViXfH2V5BdrxdU1WC1WYzmiMqDZr4I94jkRR/lXEwf4K8R/Js2CEK4WOSwV9T1N4q3uxBFRKNsf+zNfiI+ghBmONEsRFAu76MBP1ReaEA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kmGoTgeoGUFr75TUEh/m7hiHYglFo8bHRZyTM5O8FURSq5UKJV9A2TnHWJdYUjE2AdqfWlsQnU8+5ooMvFYdWAawnxd01KmpZUbnUGWJIFXDLiH0WuDVUDVukiAIGzYw5ubev2CFt5LBrFK0FPbRkeXjcO/Oh/dmEXBM4tnf8RO/qI/qk01oMnBqa4WljwXF4h2GOUmFwaqMP/UgTU7x6kxwPHD4lPhvBpWQ5xF3jXGgIv/jNEgCa6P0jFGXfnEBcSINSEGcHiAsvTtS+dT4TOyTlKhvL197mTGgNu8+jdyytnOBwUlgQOtl6+32LPwM5MEJ+nJ2LZuuHRpWCXIBqeS4ahilH6eVT58KxcjfXWry9mbNwt8k4cVavHuxOzTzgRuIP6d1QTk7tVTj4gdoXUoGtOaGFeVk8OfO72+r4D3a/we13TsD9vkxTx9HZtgV
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.9425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2a7441-5e9c-421c-dbfd-08df0993c46b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4849
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

Add a software ecdsa driver so it is
now possible to use ecdsa signature on
board without ecdsa hardware support.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- no change
v3:
- add depends on ECDSA_VERIFY to ECDSA_SW
- change sw_ecdsa_verify to ecdsa_hash_verify
- v4
- use ECDSA_MBEDTLS to build the driver
- clean include (change order)
v5:
- use $(PHASE_) in the Makefile for the driver
v6:
- remove include u-boot/ecdsa.h from ecdsa-sw.c
v7:
- no change
v8:
- no change
v9:
- no change

 drivers/crypto/Makefile         |  1 +
 drivers/crypto/ecdsa/Makefile   |  6 ++++++
 drivers/crypto/ecdsa/ecdsa-sw.c | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..8170e4cae9c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -4,6 +4,7 @@
 #	http://www.samsung.com
 
 obj-$(CONFIG_EXYNOS_ACE_SHA)	+= ace_sha.o
+obj-$(CONFIG_ECDSA) += ecdsa/
 obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
diff --git a/drivers/crypto/ecdsa/Makefile b/drivers/crypto/ecdsa/Makefile
new file mode 100644
index 00000000000..89be50824cb
--- /dev/null
+++ b/drivers/crypto/ecdsa/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+#
+
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa-sw.o
diff --git a/drivers/crypto/ecdsa/ecdsa-sw.c b/drivers/crypto/ecdsa/ecdsa-sw.c
new file mode 100644
index 00000000000..2af1405f73b
--- /dev/null
+++ b/drivers/crypto/ecdsa/ecdsa-sw.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#include <crypto/ecdsa-uclass.h>
+#include <crypto/internal/ecdsa.h>
+#include <dm.h>
+#include <linux/types.h>
+
+static int ops_sw_ecdsa_verify(__always_unused struct udevice *dev,
+			       const struct ecdsa_public_key *pubkey,
+			       const void *hash, size_t hash_len,
+			       const void *signature, size_t sig_len)
+{
+	return ecdsa_hash_verify(pubkey, hash, hash_len, signature, sig_len);
+}
+
+static const struct ecdsa_ops sw_ecdsa_ops = {
+	.verify = ops_sw_ecdsa_verify,
+};
+
+U_BOOT_DRIVER(sw_ecdsa) = {
+	.name	= "sw_ecdsa",
+	.id	= UCLASS_ECDSA,
+	.ops	= &sw_ecdsa_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(sw_ecdsa) = {
+	.name = "sw_ecdsa",
+};
+
-- 
2.43.0

