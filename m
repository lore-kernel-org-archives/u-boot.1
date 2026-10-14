Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BC8CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20F0280E75;
	Wed, 14 Oct 2026 14:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIU0y6fBY_d6; Wed, 14 Oct 2026 14:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A53D80E46
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791988449;
	b=WLeFb2bqhOok10teAcbrl4HOsZ/fQYOEYGN73JW047PWdhIuYMJ2HaTI7XSNNnUEuaIM
	 BJu8/Fz0AFCz6JodT6ls6Nq2A2LSezvdmsM8JdRnxsKsHikz90Fd/X652HZt+NjOw+oed
	 vT3oFK5Ehv5ww7pnCJAzCqF3tlFlmO7FHUF2L34Y/8vZGt8mY8CyvvMX3KEa98fwvC+87
	 NsHqHuyrOK639+js89ttrTiB2YHWGvWO7piXfUhTf2RhgLxrnmr83VJ8SoYRNS+J3015C
	 QgNxVLKJT+rChbfF8l+7yu3npuSlsj8+TfC8kU4BtU1MOFvg5mNEj6zlwspf1UD/K0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791988449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=meQIaMcdtz8kOeOzw9lyp/6gxJmzq3CiVFT5FLWqrJo=;
	b=T+FMK0YN2PpL60pwNnJXRRyBMuQ/cV9VfgPzEsLerGUN9EuOgnO3X2kwZbdFbfCdM/8X
	 srICiwTnirPcFcIQaCj/DWEl0N9ODJN4pqxV7APwQD/fMy64UFfpXlgYoFXU8l01MZljI
	 Q/ePwcoftMcO2ZZYIYFFqLkx/2/Xc9x+7OuaePtNc3n5MXNhkBK1BYZ9Xl+mpHz000GX5
	 0RMJsFCSesCH3n6GM4RWyFgMLkA8k0tv1eQzDC7yOBmX6BtbpigrVSOxEVqO5/Ty/U1Z7
	 VcBHmUyhzUnqWHL1I4EYSYYNRDExrmyuA1B9jn3Bo1/c1XsAv2mTT5RMtoUifQWTl2Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=phytec.de;
	dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=kDEQXYSL;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791988449;
	bh=meQIaMcdtz8kOeOzw9lyp/6gxJmzq3CiVFT5FLWqrJo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PDUEg4kzalgvk379Vl9BuUgllx6/ll7gA9V3F+YD2jvPxRw8RWmOuG7Nv6NzDQQhG
	 FBUpODP2JyrKKmac0Nj/vOw/NRTAZsooPCCrMnUbqFdflbTB/fhLioCsJeoEprdM97
	 VVRzsA6TSaIRUJz2xUbgwtZToKHGqCROreiUAarmecrSgGIAWznZSXWZ7i6b7VluvV
	 gwXjfpYZuKnnt4mg8l7YQTF28LjoaM3rqi95jbinF5Of0pN6Smp0DutHvvhfWPUJ5j
	 NRo7rKQRw5mUpxA0omq/zoHZvQEectimpClFQIA9KbL+1c1dc5GbvFKYni48e7skj1
	 KmSoU4sZwWPOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A53D80E46;
	Wed, 14 Oct 2026 14:34:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EFBF1255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA76580E62
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W0RgmjwKgiUh for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2746B80E4B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791988446;
 b=IwI1zCaoWc805f/o6sknvpZmUmm3pMDyrkubwwm8ATvfMy2lRUbkCpopbmLmG0g1Et2Q
 NOIEMkOA3pVZeo4Xxad+JcWUOnHSKXawvHp5r4M2CI6s87CaCJKYrcEkTm8tPqzj+xztV
 1Bb+QhYwVfYeutX2YP+iwoYs2JMiykTmxQVe9kOBSHP12uvg55iFxQc+JxTGP4wQKWpo3
 /NzxDzMW+kL9i/9eb3PDF850Ia4qnES6n0SXp6xWU0vW60ayPySU0L9a4tWFoNOh1pak/
 1/DWlnv5CadlnvZ/Bb5K0PpOkEW8S24CF2JoXJ0iABQvaSy7SeKc6Iu6jUoSNGFwWGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791988446;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=meQIaMcdtz8kOeOzw9lyp/6gxJmzq3CiVFT5FLWqrJo=;
 b=AdRDlqIZTbpb9+jF3fIbe1u9SV/7sgnVlD1NgdfLLM7on6WT6RoRXsbf9wYUI6oKqclz
 rPv+2FZH3DUp/46gdn44STyRIGWL9o3LqZnFTVEhaaVP/BTW1jkSTgDDxRlf/q1Iz1MzH
 wOvHu+OdfNZI1Nh/D8Oi0axGVAxkZ2QdkJCOtnvqFd59BQLMEBz6pbonOW6/ZqRT/zxHk
 OA5BZnTV3CcdbefzUh+8Sz7ZevVlKR8fmhtRtcW/ZkoIrciIOiZy/ejjlHopTWTTR9Rdj
 QCsV4rrx6zvVFSt6kTQuigNiB/qoJLtRCAeeRQj3RQ8J0y+wyeA3S5l52tyhGaGLFGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=phytec.de;
 dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=kDEQXYSL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=kDEQXYSL
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2746B80E4B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELaqZjvEyshUTW5fpZyhDCk6JQW/elBHGnkQt5vMU3K3XDBocXHJKhYaCslneFx1wnQ5pkTlRQmKfJLCnnwq4Ft/7n4gZTnXyZzhSZx1hxS9nLVLz9jLJT7iuz3VyHzUiSvgQduDe4LQnMx0//DtBzmv2SlT99WNQdM12gtAKaENIgvXJZueFYPEx1GorM3ElE+x9KmP79OKKO0VabxXGIg7otG5SN2xzfsyGrIOpV1C5sEUU+1ewqQm/rHlVBhSY3mye5XmiaolGNYcWYosebReKsqz99WY7si4PyP/PFJ3fBF/4tHFkCtvSfPykvIaUhRhlCpYkWg4H/aHhW/TmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meQIaMcdtz8kOeOzw9lyp/6gxJmzq3CiVFT5FLWqrJo=;
 b=QQxoETNR8BEKjksBYVQBb+MpCPv/4aj8h6Duk7OHEQiAtb6M16y+ay09kVdgjGnkMKk837cNNy4ddRDgF0J4puN9rIE4nDDL/wvAH46QqaAmCm61SG7Exv5OoXKDaEMvkUVfN4itD+nP0RSOFxFQJ2a0u9hX71avUtjZwZm8v5+bR7zRVDZIYzJ9UanDaGLcyl1RaGj0Y1dFNdZ+4j68oDL+D94ecAPL4bDRzqbwYJZ7+DY1pwFzq93Z3++5aB6BN9+SD++NVNUl8vITmKNQ+LtEqRlL+fboxtHVDlVInlEcbGuSsSUeWoVphYB2QjXoiG+itnqxZhJK23WYwW5ySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meQIaMcdtz8kOeOzw9lyp/6gxJmzq3CiVFT5FLWqrJo=;
 b=kDEQXYSLQJNdsAzMbCVkMn5PcN9+Qxh4XnH1z4TZmGZp14ofQ25EQON1IW5jlO2y0YkJD1fJ7EzLvNz35cwBkaXkH/MB3EDMH6DajKI0VEyFX1Ih/9ZYr+Zii4IpU2UFOLCHX8M0Bp9oKO3HWW6HiEKDadUM/rOmJftZOScq1gtZ+psSHob9HENEhdFR6eGPrllamr/m1NHXXvApubj44unF5vF850Nv1uRCuxKLTaVIEeYpQkI18vfYzZdvO/B04QMACj3Nuvk+Qf0ZKSwRpjlzjhf70+x9hipMwugTMawLTf7H+Ntt+WXmA4Dd3tdWHaAy/PlGPhoIdzFpa4CiRQ==
Received: from DB9PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:10:1da::21)
 by PR3P195MB1008.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:33:59 +0000
Received: from MA3PEPF00000404.eurprd04.prod.outlook.com
 (2603:10a6:10:1da:cafe::5c) by DB9PR05CA0016.outlook.office365.com
 (2603:10a6:10:1da::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 14:33:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 MA3PEPF00000404.mail.protection.outlook.com (10.167.241.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 14:33:59 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 16:33:52 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 2/3] arm: mach-k3: Set /chosen/bootsource for the next boot
 stage
Date: Wed, 14 Oct 2026 17:33:27 +0300
Message-ID: <20261014143328.3135006-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014143328.3135006-1-w.egorov@phytec.de>
References: <20261014143328.3135006-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000404:EE_|PR3P195MB1008:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a34005-005f-4a69-a1af-08df2a002f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: DvWem+iHbJal02hoMneNt9PKmIT9p2GU2q9dxm7jG8pWCc0nwKdc4vYlO8uGHmSBAkaBvXRAkMSwfyuJfD4Enf2e/y3Sxky0OeyL2NMd0KLrJAs6R0sytJbMP5Z2CeCnB3fVPQvc1MBlqsCI7tNok6kY0eflZUXJgIjgT+lPesmJ3mRzonAFxdk08lW4PfxqUWw8BKUsCcv9CRTa23X2vrFoD1hoSzNemU6yS5t+Z9m5SV1iem0PY2zHM/ngmqtH7sdjeGfcaaMEwqrV6Vxniyu6oLr0lt6IWcSAUUcYF13JK0qeVhDMp3AtZo7RgFmWU2yC8zazBksTVvZPK60Zla8LtYTc2GUNZnK2aDGQQl4TUiXMkEPsxNTLwrr0wAMfDOxdu1uCfJB+MO1LCaMllnMDNaeI/A8UmUrdSwn8NYALwis1dZnnNS3JA+BF69M6fLnaiBTSDjZ3ETduKySdpzbrfL7fW1OwV1hTGXz/pzciX2ZJdCdj1lDXTLwyICVZb3Ze2GtWxv0S0uUIyzk8ipjrcoFwXI1Uf9CWy/cZ8LCDEAdwdPY6ssi5hzqDREXF3yWcyFBCZl77i7/wlQdI5U2x10+FSL3i1Eo+GfVy9I/tljXzdK9f1ErqKI3U+fnwGoakiTOCGE170NkNLvaJfVoXyQkRDS8FBPq7vQ6amCPBpHnlcqAl1KYjfPSNh2Y1hOSYQebv4SyHP3o/j5eiQw==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Icx47qTrwAC/gLEBu6DcewPFqN3ISM1VzdZfWIklYZcpwZiuLvZVHhef6PZCRGVUAsGPIVUvG48nSQT4BRvgPr4DgfwQHgC6NttYArP02HhgU1YZ1pL7zM7qDb1o23hNebKB4Abjytjaul9Po6bZmzRwsEmziZ419S2IrScEVc2b3HoAhrxrZj+prOx28i+CBpEd5kWmGkwrt9jFfA7dA/2JeGTqMxx9AEIxsXjHFk4kG+RQmR5iN3plVSF149pRpf49M6otKNHd4nu8s8pQfpDakgQBiBC6opbtip9MkzKWMrOib8DnbytK3X3AcQ67amprqJU5oT8N4SFBvdFK8yDN+960mkrqOfrlgvqyTU3ffuYSdjVyS4z+KdJprXskzYTEQOl3y3GfbQaDHq+kYyO0RGVc9Ni0ZCp3rZ++o7S5GIfxI6CsAut6fLthpI+i
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:33:59.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a34005-005f-4a69-a1af-08df2a002f76
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB1008
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

Call fdt_fixup_bootsource() from spl_perform_arch_fixups() so the next
boot stage knows the device the ROM booted from.

Implement bootsource_get_ofpath() for AM62x by mapping the boot device
from get_boot_device() to its device tree node. For OSPI boot the path
points to the flash chip and not the controller, since the flash node
is what the OS maps to an MTD device. All AM62 boards name it flash@0.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/am62x/boot.c | 27 +++++++++++++++++++++++++++
 arch/arm/mach-k3/common.c     |  1 +
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/boot.c b/arch/arm/mach-k3/am62x/boot.c
index a3a6cda6bdb..96052f44831 100644
--- a/arch/arm/mach-k3/am62x/boot.c
+++ b/arch/arm/mach-k3/am62x/boot.c
@@ -2,6 +2,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/am62_spl.h>
+#include <fdt_support.h>
 
 static u32 __get_backup_bootmedia(u32 devstat)
 {
@@ -102,6 +103,32 @@ u32 get_boot_device(void)
 	return bootmedia;
 }
 
+const char *bootsource_get_ofpath(void)
+{
+	switch (get_boot_device()) {
+	case BOOT_DEVICE_MMC1:
+		return "/bus@f0000/mmc@fa10000";
+	case BOOT_DEVICE_MMC2:
+		return "/bus@f0000/mmc@fa00000";
+	case BOOT_DEVICE_SPI:
+		/*
+		 * The flash chip is described by the board device tree. All
+		 * AM62 boards name it flash@0, a tree that uses another name
+		 * gets no bootsource property.
+		 */
+		return "/bus@f0000/bus@fc00000/spi@fc40000/flash@0";
+	case BOOT_DEVICE_ETHERNET:
+		return "/bus@f0000/ethernet@8000000/ethernet-ports/port@1";
+	case BOOT_DEVICE_UART:
+		return "/bus@f0000/serial@2800000";
+	case BOOT_DEVICE_USB:
+	case BOOT_DEVICE_DFU:
+		return "/bus@f0000/dwc3-usb@f900000/usb@31000000";
+	}
+
+	return NULL;
+}
+
 const char *get_reset_reason(void)
 {
 	u32 reset_reason = readl(CTRLMMR_MCU_RST_SRC);
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3b..c7fd7b4f44c 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -570,6 +570,7 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 		return;
 
 	fdt_fixup_reserved(fdt);
+	fdt_fixup_bootsource(fdt);
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
 		k3_falcon_fdt_fixup(fdt);
-- 
2.48.1

