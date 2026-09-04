Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83BCC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5243840B59;
	Fri,  4 Sep 2026 10:09:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p75rCxZ_ekA8; Fri,  4 Sep 2026 10:09:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F3273406FA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788516594;
	b=KSI7BckPXpbu2p/dsnk4pZpdB7TeY3cCFyVVtS+sM/D2wZ8p6LqmT86iMAKacbcNty8W
	 66GcujH8QW+QN2OjgUExuZkrZSeQH+V6YFdqt6N9JtOe8msFL3k0zEFdGGHIxHH8+N9QA
	 Q4VS73WjdkVOq6rwQ1m15rC2EgGa9GrXEEJ//cEzyRTq6SXEb00KV0dAHEkEM9pcT5f33
	 xF6fUGKUndHYTbKZdXdM/pHXCMSckHVpj9HXMf2qY/SlEM3z6cqIo4bR9aOeLt9MNghfW
	 neW9ooTxKXXuO+x89GObowT9NDILw47OnBKA6NZ2XPFXUyVP7Yn6jXLaUd0YGNU6GsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788516594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=/bt/bmjGaFQamq86djSyGB2d0q7/C/nYft3b1dPO2HQ=;
	b=R5ihhD+BRYRnrwmL6CIrW0PcVD5aCIOUgE74DiTXrPreKbwkVQ0KKTRjbHJHP3+1UWFY
	 7hIs9xoWlQE9MEipREq/98vh4g5BbG7VkT5YSoyZ6c/FKM4GcWcPGojSY4PPcVfJfq2AC
	 qq0DjARVSCXpbwXFHEy5TJqe9naJ8KxR2vRnKGXEBmcWN0CCohZwUxrgd2g3CV7D+AX91
	 gYV4jniiOeqYQvWSenyDpzEFpt3EraJsr+U3a1wNca8AnEZ65+OAPgpMAplrINkyL76Cw
	 wdEWY8FjbKn47MHZ0PoiqLVkc7XFeKNlD2p+I/qoZncaXSv4R3zCW70NDtcycuaNHFw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ICQBI1Dx;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788516594;
	bh=/bt/bmjGaFQamq86djSyGB2d0q7/C/nYft3b1dPO2HQ=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=atvJlcbn4zMgeq3mT8L0VV8ubRzXCfdo3X0tfbjrGDZYcqmV3YQokbCosqjgDae3T
	 S2kj6Dp9F8nwf8CDxPqsNnCaYKLV/N3DvZ6a5QvZXOf5iecqVmLSSDZeW0KrGrjC5j
	 xSPDctQL8OjZETOoDFCLB+P/CaC7hQ5h7pbYYVnja3kRS0qDJ9XOJ+JZKQ/rciE3Ux
	 PAmCtBp8U6ctn9xyr36vGFrgOWcTqKHc8n+PlC3hnIzLnKKboxNePsfcKGEaeFmig6
	 x+1Er6LsEjzd/e/E9optCG1G6jkY5qe3+yVZLKSiuhTgEEle+smO8E3DZD32m+AziR
	 ZmdC2OIlrd1Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3273406FA;
	Fri,  4 Sep 2026 10:09:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E76977F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5318E406FA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejfs1RyKA21D for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 21204406D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788516590;
 b=g5BF+hdHFF7ymiTv7NJSyrbyCADkd7s32JBN08LFRP2AWzdKSg+zgteXMTtGCY0nx4kP
 TYLrW7ZirUFLHuKuW6pW1GTtoBGaHFTNDMLUdpjOSyF21lesNDEz2+Lqd2gU7g0cqttH5
 6uehLovSG1bb50ViDqc869RDKvI2IaVZYd2cA5XFeCznZsPDL+hdhCNI5cGW3a4RAFftQ
 s74ID+MNUoJRnih3muqSF6eb/txHuq2jxwmlF8Yr4/u3W0at+lfX200/tM+RJM1lcn+TB
 Yxag0phRR4QI/p39Qm55qWTF/PlOL8kdx2vGx6bXQo4prXRziuvhqTjMYQOSXgrsQvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788516590;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=/bt/bmjGaFQamq86djSyGB2d0q7/C/nYft3b1dPO2HQ=;
 b=NBTRIkBqyXhK/w/oM0YgYbSC/LHZLofskspo+ydzohYIqxmKCyaG/hoTWXTAdmQye4gq
 V0HAO/mtu2yidgKoZE3h2ajFKP+qXvHCYykWzfwV9XIg7AwimQTnvMiZMh4/fykmVydlZ
 kfYyMiFmLyYhebTS54mKWHNZfABfn304HMkChxDl+WdJzC1PmdIpc2nGDSiUxZPwIxqAx
 IdN+pP62n6I8j5ZE7g9Grm77u1c/a7T2eqqAPlf2JgY6713cJaZrLWlKKkPn7pqO9TjcB
 hJOqY+gjMS24Zzc5tf71zKLYoIckJLno/WWr1cp0TsYMoT6uaaq7N8clSJSI8Qn+vzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ICQBI1Dx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ICQBI1Dx
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21204406D9
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erwSNZjydm6B6X6gfU3MOlL2G1e6j3dYVktTdEEYg0WjbkThnEuKJyR1jcTRh6kQk87e9U47jYOIZO/qOmcymvKEyl6R63nEWBtDHIBZciJMWxBlxkqcyL9khR8qcbNixIi7nSoQtKN9P4S9wdgDgH02CZjeNy9iNtpUr8dc+ZXNgR25fOILRQbK/42YrBdJE7UAg5Ri0LLdpsNNfVRv3iMaLKEm6R25H9dkthqzrF7LM3qN5o09uTDCzPlLDKvtu0J5scOdXW3JlKsyJzkZLqVU24Dy0eTupmVXVOyizrBL7bvFBUvn9bOa3uJwoKA6jpG6OdukZ+enadzoPD5sGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bt/bmjGaFQamq86djSyGB2d0q7/C/nYft3b1dPO2HQ=;
 b=pE6DyYFUTgQmXD+f+6YpJ0lLi2wPgCXrpqotlYwB0/AS2t1JpkFeNWBa0wR1p8EIiN//wOVbm3Cjj3C3zriYVGH5Ziz631i5G5pRBnERaYQjqe6FaSvzxqk0ZGokzJ2sIuaHxGnf/h26tq7+dBmiv+m+CaqQ1/NVlXfhjV1VTTC977lML4z+GFWRn0EBCEidQo45qvEjGmlh1U/dpXkDBpIryeJuIvvuCJPNE/hio9nblBOjhMLbGhtZ9MI3IYNmAkKchUrG+U29SG6pScK7BpoIWbJViWHHMPx5Ih5PsK3ckiQl1pVGs3DxArLLC+nXBZrbVVVVJ8ISOiHfjqtKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bt/bmjGaFQamq86djSyGB2d0q7/C/nYft3b1dPO2HQ=;
 b=ICQBI1Dx73vqJGrpNYOkzle4zHhYDlzIYC9HVX7cBaoZa7Rkaj2dDLHSlUNxMvJpjwDtCdUG/SloUYTLJArAhs/NXIjmEH6AD+mF0uKxJjkS3GIUpjFw/RyXp3kicSdmLeXTg1BG9ws3Et4Rmr3VWcEspyNtHzx56aeBbTia6/R2gIQ6r1e5dXl8Q75Nkjj1KocSm85zrUQvXjW8HFN9ucML2avmOQ+y6OP9StuarQ+H6purwUfDtVZSZYw/klPa7hRAbdbVW+GwRG4WiXJa9N0eMBtwxAYZuKK2wmERX6NzG7xp7dA2dUA2RyQSyoz7O+7u1B7aU1w61IpjjR3PVw==
Received: from AM8P190CA0025.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::30)
 by DB5PR10MB9691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:656::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:09:43 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::70) by AM8P190CA0025.outlook.office365.com
 (2603:10a6:20b:219::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:09:42 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:11:38 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:09:41 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] STM32MP2: Restore boot for MP23/MP25 DK boards
Date: Fri, 4 Sep 2026 12:09:35 +0200
Message-ID: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+YmmoC/yXMUQrCMBCE4auUfTawCSLoVURCk050Bduy25ZC6
 d1N9fFnhm8jgwqMbs1GikVMhr6GPzWUX23/hJOuNgUOF77y2c2jTYr2E4ussFgGjcsxOs/Oh9A
 loHBCpiqMit+rAvfHv21Ob+TpIGnfvxgsgcx/AAAA
X-Change-ID: 20260904-upstream_fixes_for_v2026-10-122dbeef0bec
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|DB5PR10MB9691:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ed5bf4-474d-4af0-d260-08df0a6ca36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ft/lgxb9qb1me7vbT1Y34lsRFEYPcv6PR1xfFvmA32lMAllLF7aDG1R0tddGd4eEn8JHwYNE9dUFHsYFjlnfq8hjjw0OAw/hicoWea1jPi96kRsY+MaYXj1btKzSK6t2OnCSLbtSEB/M25jSl1uCKCGj2xnQ1/VVUKpdo0jW7ytVFgLtRY1inDgxvPKLztYoYqeivWeK8mKuNImbUgK8ti73KFec+agWZaLK/9ZVRpngllg5/r6PbDdzmhQGkRbccjH/FSZ2FbE7DW/i9lGSW0ltfYbXfB3dtXZd/QS/oN0DXc62OfYld3uo0Vdths089sR2Y0yewLQ7LPbXi+HJkRU9HDN1k4+4jLf2n8yJnKNU+qLFiBaTeqDr7lBbI7QyP9K41fvp828tiQi0Ifq/jRr5qGIiEcAoKZVu8Uajg/ojpbTUHP4I0/0mWsG+akA7Dd2XjHBbTxmujWT7U0E8BoJQ7Uj4pkzMJLI5Pg5aQOrHVr8JbFBJaTXWR5AY0ZHrze01Go7yLpOSi0wtLkgUvvfIm++Br7h7k3x1Y5RL6O71vdCXBwz3/QrUiBWPDrub+P4baS7J2kanchylEwG+g4sZUij8WQcGUdhjTxVCc3hI6TebNfs4yaAi1tgkf70N8gFi73LetLMKwHnV+fBrmKm3drtEmHMeMUDufB9rBoI=
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fR3ZPre2KfdtYE0tV5cJ45GYbKFRojC7FTWrLJcI/J6Favt2JNQpAFieOrE7ZCgjL7+dDwatUvkPMBHRgvCdynid2esbTj1uEKF6ZOke0fkRDNd1qtkNlWH6BSd+whi/ty9MjgQeAndi9XX2EviVzrrJVGcGPkDJO0vM2FaLq4AOu5ImvuzpMfL5TMhVHB/Ue5I4butOnFnah10dSS+TeyMXh0opGV5vHkY8S8FweSqn3YRcaAJaq+77fK71J/3/S7vPcM5jI3Nuk2GfhosX6OXmUzCtXCoQELdEnE5ZanARtJjiYUtA7TnW/wEbV9GyfkjYdeuII2PrX/HMFGOzEHCq899wVCoLYYA4Rax+I9cMwkKlbjyPWP0E86EoczP86jAdo5SXco6s/Bi3tONU5/1zS2VycGedIUeHuRNOrkEtFeqHHLZLEV3TYkc4cUDE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:09:42.3703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ed5bf4-474d-4af0-d260-08df0a6ca36e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB9691
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

Restore boot for stm32mp257f-dk and stm32mp235-dk boards by adding
bootph-all property in ltdc node to allow early framebuffer allocation.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      ARM: dts: Add bootph-all in ltdc node for stm32mp257f-dk-u-boot
      ARM: dts: Add bootph-all in ltdc node for sqtm32mp235f-dk-u-boot

 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 4 ++++
 arch/arm/dts/stm32mp257f-dk-u-boot.dtsi | 4 ++++
 2 files changed, 8 insertions(+)
---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-upstream_fixes_for_v2026-10-122dbeef0bec

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

