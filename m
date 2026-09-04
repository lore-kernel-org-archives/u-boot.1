Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F46C79F85
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE6C960C05;
	Fri,  4 Sep 2026 08:38:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B4cyBjmnUMqX; Fri,  4 Sep 2026 08:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E6DA60C1A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511072;
	b=LbGUgQKDuqnzvc55TVJFHm5z4b6SsYvqSQ7SYafkI5Gxgzsgt/PVa9+dHW2b94Z0i3o6
	 fRlOW+gZqH1Incbf3WX3I/A+8NWFjbqhToFpV7670XiM98cHphYiBySTukNZiAUNvZHUS
	 RqQYgmnaNc1TLaaDQ9g6jdJw65zi0SMVX1ve5Zumv8ud7e2zwL1EGgBrlFrYBKPF6vxUu
	 qZPZHPUnTAul8BfD1Gyurku0/2bxoFTJGqEdcb0TJO4j52Mqb3aN+FJXasjOKaUz8CfKG
	 uskBPKMsqxOkTCYMELiGzUkpnOVqfj2UKeNKKPie4lZVZpf/Y861n7pktt7LgzNixoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511072;
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
	bh=JhGSdTUwuLOleAcQFKj9utnyl47WBehlyAdE/+cBrqo=;
	b=CTIF08tOj3YxXFoUY8kiGuw0oqNRgnLN1+dKMmaqKJnJ+WYEUtUgKQ4lDnPgwGwZ0PiX
	 NgmOJwrIhAtRKl5tG6premnZ4s3J2KDhfjKO++Li12mLEIPXEX1lsntSXDR6ubG9sqodu
	 /hlsYzMPc8I/Nd7cleZdatZRJAhyyZ0JTSXuNn3q7jVMu6CZrPvezMgVlb1fRojdQa4NU
	 TzBzx05B2FqfoKGBH/0gGYeLtxXo4U9no1t/Q2Ze9PUhPMw3C3BCjsH99ZWuiL3c713W3
	 xyqIRNK8hq+MMkwM+q7bEKfbbb2WCZn3szZbXwTExWBIch0gCkFX+DfapmB1TIrho8w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511072;
	bh=JhGSdTUwuLOleAcQFKj9utnyl47WBehlyAdE/+cBrqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czYwLVJa6ZWg+Fk7ys5SX6Ge5/i3jbBhm9gowf8atfpqhtaux9mno7LetOycMZxp2
	 +Bj1fxKCpNM+2V9SLqRA1oDcNicHTYu3GqOtnbQ1rNTsuCJyBtRCO3ZoXG6pBayaeU
	 TCSDnsikO8tOz8EbuKpzQXDyMLPYaoKaHuKCHC2SWvnqO1Mz66dmrSkJEAAOeJhCbr
	 oA4vvYyZpkDKBYRQFXwWvtgntE7K00x8bFXzoVVak+H1Q09L02pVx/gOZmEusvOdIc
	 R1KZIiTYrwyjYGkXis2Jc62egdeuD1lCygio0HlH/GyBzPWw5zyO0wVqww4A6FKFGN
	 a1A6h9G37kCNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E6DA60C1A;
	Fri,  4 Sep 2026 08:37:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6C6D3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4CBA40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v48dzrqzFaQd for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8B24040376
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511050;
 b=ia9mHaCD7h0UlqVloMBozAC2rPKOKnOy4sBsluC1gRE4br+G0dB/1Xir83bHXpc/A/c+
 vin0bfbdeLvVR28bsxUYGr/U++93xQrqqygf/Om6psSf71CJCCjpr984CLdQtotuhgBRs
 O033mA1tUnk5elSWsOZpFXKJ3s3c0AbWOnioXFdQiczHHRG5fR4/r3gt+HfO/l3dGZKxV
 fco+WmUfHmBRbullwEB3nU6qCmdTO1Z6PJmxZibTYM8ciIKCQo7Reamet88hIdQC8untq
 7qz3V/DVOQujHgnek3P745FAUL/vUWuB9zbKMMbyvHwU9/R4SG1VjstMGgfdhxuZxjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511050;
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
 bh=JhGSdTUwuLOleAcQFKj9utnyl47WBehlyAdE/+cBrqo=;
 b=R4pEQzw5XwiYD3XWyZ41bQsvieyBHvSY7Lmjy4zeHm4bsJpNhlP5mzd1e/Ago+4Nziwg
 KR/zqpeaTgWWXquKYaWHdmzReZiUFxsHHzR0vw2POomR4UUfTVD3cMndwekUJG0Hz50eh
 wZXmDU/A68yLuxLZLafGJIC5wV5BmmY175HAml1Ct1F5WcSedxMTxpSFp2X/jU5vi6t/L
 xB4nKm9zHciTG3AGppVQF4iwbZokGZG4xn3ucQUcwNfq1ICMDj5ApBpJE2S9gKZtsAJqu
 MOlo5TMBHnHhIK5zaNK3Vqf7EkvpNj30KnOq6iXxUP9PwdttRf72v/2e7UaonVbg43w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=gJr9TAyu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=gJr9TAyu
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B24040376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9S6gC6THarhyWjDkZlufRsRiLeKNc2/xVNIz2oGoLEob5/tmtu4ROTpHPLW4P8Yk+nvJ5Jj6IHr41gn75eAUCXaPVRan5T9C51woJFSosSPVrTQEZ62Kp5dICjknJtvoMM38oB2Uc09/pqnf+fAmxSaLoSvuUOJY6ww79SFyf4UfcMLQirqWLERSyoBAdL/YUJs5fi4argCGg1hGg8Y7MdcxdarW4gjZsdcsO73K/qCT1jiU5OdfP0LeE/xs9xyS1uQwgi4k4bX/sQ/1JoyJEvaAv+h7CnWHsA4FLDNZJJzX4appHk6LxE26dmIEmWgmBtPCDu876EY78cwDqH/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhGSdTUwuLOleAcQFKj9utnyl47WBehlyAdE/+cBrqo=;
 b=yhVtwFpqWLsg0+5LXlyomNVVfUoZwbjeEFDU2DxvdX4ttji9YakNF5k+qRyvFmTppXt4HO+PuKuCSA0WhT5zFRwY+L8jg04HcXiAJ5nDcNsWdl3QVlw78MKrAxT35zJ1sLoGB8ETRtKKM0V4Wc1bQKYJjdA8HRN8wlf8JICgafVIQCW9i7e+iXFWAqkQ7GHFG0Z4RKxxj61/mfc/EU33WkGJFj1yEIsTLco1sc1mYjxS9Sxas3c12Xw9VGGK/5sH8qG9iTKwyoqRejU6v7Aqvahx6TjB9H2aCn9zAeiXLAyBMsDuFPqTPHqunmqk5jE6hmIGomUPeA4wSK0bWUZ4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhGSdTUwuLOleAcQFKj9utnyl47WBehlyAdE/+cBrqo=;
 b=gJr9TAyuMm0+IDeiZQTGmtoL3Jjs/DTj8wCRsXZfZa0z7tph7M1SxQF/cUCpVqUDqlSO01MTE2ThbK6fYTExwS/fW3Wpagrd9mmCy41zwudGa59b4BbG6FXhDPY/IM8uJTrHcgnsKSRFGoWSV3HsaoLukCo7dN2HCSr6dYvvyczmOrXLaBaLJdQgwj6N1KAUa5dM6cDQhPqyZY2ejvXHeROl8SrrmlCQJeehwlY68DCNVl0+pE+QiJi7VG2XetZs3mByc7Zfan9xuTZcO4jYOv7Yvd6F5nh+21hTxlyYnLwA4MJ+X2tql58AXaOrFTTPlmFybgiYIbIeaR1+Gi/ogA==
Received: from PA7P264CA0199.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::19)
 by PR0P264MB1548.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:167::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d:cafe::a5) by PA7P264CA0199.outlook.office365.com
 (2603:10a6:102:36d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id C2281202B3;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 11/15] tools: binman: pre-load: add support of ecdsa
Date: Fri,  4 Sep 2026 10:37:15 +0200
Message-ID: <20260904083719.53132-12-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PR0P264MB1548:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ec4b3b5-7fcc-4aae-766d-08df0a5fbda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|18002099003|17002099007|22082099003|56012099006|3023799007|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 0oV9oE3UAIWyFG8uWihdwUUdeP0+bl3YhCkdQb3y1/A3CUAo5YfbKB77SKZh9woL242rHkSX2h59GY7ojyT61QdC7mcijh3dQyPUoJAgALmZSEjsgD/VNk2pBqeUp6oIyYC/8H4cOXq7dHkMtyq19iAVwlOw02Y9Nve4znFGAkheMS8V4KP/oExl6aTfdLQwRZu3qCmSYArU6ePRWIRWYgURY0m1CK129Kc7p+Ro8hdEVDexB+XrRmFsIgxFmFi/5mJ8qHqmRmZNxbPOMqjf7XQUu6C/mhj+OFaT7F+D7FQPaNYHPC3y96XyxsoFBTUxGLYD0neFzJXfc1GFgQYP9YSTTugnlXnjBrr3s+WC54Irx+wTlrk8DDVpLohpyb4cdgOtS3WCHQdSdZGhDL6fXlVXTyfccO7ZUzlFONcDUO2DIVhtZzADk/RECBY9nL6XJ9yMk8C7MSqcWfM7ltKsGxaGfSXJUGV9ZwU8UNqXdmH5/k6IA2huT80uIfn/KfKcO+Fck9QIBbZQpuPAmkJEOnezInkvS5TTJPuoAbFsekxNPfKYb5dD3/bn3QlVD/4kiPl5pxWdvhyNnuqbU7769xYNdoa0ZEj/Hd8rHWsvffvGfPmI5jFNYZ3YqrmSrRsG31+gsSJdG1t16DWmkbC6MYOPMTSdvnx7qSpuRVenttoAV/Np9zpPxWdKdjXO5OJIwh++IMWxJ1EmIppOntpYFg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(17002099007)(22082099003)(56012099006)(3023799007)(4133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1rbv3QHPryMIDEuG7DS5x1cRTCa9JU2kWRk5kPMC0KqEcKSIbaJtNTpIBg0NqdvWwAMY/KKHVa0DsZhslAAAfTrp1gK2E1g0y/hqn02j29YGPpsOpAwhPHDxc0KwgNAlRBxX5I+g9cBmHOrOvAgQgv00uNumrfOlsJCEK9oPrsnogf8ynqDVacoI25xG5MRLjPf/6wePo7mRQPWQ4MfWWjZrnk+hBBK4A8qxtsYYyJYxkZQKk5i+llVWdMsdlREqykXIYb5XBXXA8pI6GiHPf/6cXxf0MhRdDeHERWVuzwx5hQCjkkobH83/9Za/3sWQOs3Ji/YLeyv4dVy1JwTj/wgiE8d1UEzSM3hRIZBbQHWe5WyP/L0rToBOlnApvskL6jgMNPIv2TWtumdb46iS7WPB9qDWcJFWLMidO4bH1Fo2YJ04ozGS5MR9PxM1ceme
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec4b3b5-7fcc-4aae-766d-08df0a5fbda4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1548
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

Right now, binman can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- merge patch 11 that was adding test for ecdsa pre-load
- add key size check
- use exc instead of simply e
- rename dts filaneme
- add a test to check key size
v5:
- compute ecdsa521 sig instead of using hardcoded value 132
- fix english: don't -> doesn't
- avoid line too long
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change
v10:
- no change

 tools/binman/etype/pre_load.py                | 78 ++++++++++++++++---
 tools/binman/ftest.py                         | 50 ++++++++++++
 tools/binman/test/ecdsa521.pem                |  7 ++
 tools/binman/test/security/pre_load_ecdsa.dts | 22 ++++++
 .../security/pre_load_ecdsa_invalid_algo.dts  | 22 ++++++
 .../security/pre_load_ecdsa_invalid_key.dts   | 22 ++++++
 .../security/pre_load_ecdsa_invalid_sha.dts   | 22 ++++++
 7 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..7890c1c62a8 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -16,8 +16,10 @@ from binman.entry import EntryArg
 
 from Cryptodome.Hash import SHA256, SHA384, SHA512
 from Cryptodome.PublicKey import RSA
+from Cryptodome.PublicKey import ECC
 from Cryptodome.Signature import pkcs1_15
 from Cryptodome.Signature import pss
+from Cryptodome.Signature import DSS
 
 PRE_LOAD_MAGIC = b'UBSH'
 
@@ -27,6 +29,12 @@ RSAS = {
     'rsa4096': 4096 / 8
 }
 
+ECDSAS = {
+    'ecdsa256': 256 / 8 * 2,
+    'ecdsa384': 384 / 8 * 2,
+    'ecdsa521': (521 + 7) / 8 * 2
+}
+
 SHAS = {
     'sha256': SHA256,
     'sha384': SHA384,
@@ -86,24 +94,17 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
-    def _CreateHeader(self):
-        """Create a pre load header"""
-        hash_name, sign_name = self.algo_name.split(',')
-        padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
-
+    def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_name):
         # Check hash and signature name/type
         if hash_name not in SHAS:
             self.Raise(hash_name + " is not supported")
-        if sign_name not in RSAS:
-            self.Raise(sign_name + " is not supported")
 
         # Read the key
         key = RSA.import_key(tools.read_file(key_name))
 
         # Check if the key has the expected size
         if key.size_in_bytes() != RSAS[sign_name]:
-            self.Raise("The key " + self.key_name + " don't have the expected size")
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
         # Compute the hash
         hash_image = SHAS[hash_name].new()
@@ -151,6 +152,65 @@ class Entry_pre_load(Entry_collection):
 
         return data + pad
 
+    def _CreateHeaderEcdsa(self, hash_name, sign_name, key_name):
+        # Check hash and signature name/type
+        if hash_name not in SHAS:
+            self.Raise(hash_name + " is not supported")
+
+        # Read the key
+        key = ECC.import_key(tools.read_file(key_name))
+
+        # Check if the key has the expected size
+        if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
+            self.Raise("The key " + self.key_name + " doesn't have the expected size")
+
+        # Compute the hash
+        hash_image = SHAS[hash_name].new()
+        hash_image.update(self.image)
+
+        # Compute the signature
+        signer = DSS.new(key, 'fips-186-3')
+        sig = signer.sign(hash_image)
+
+        hash_sig = SHA256.new()
+        hash_sig.update(sig)
+
+        version = self.version
+        header_size = self.header_size
+        image_size = len(self.image)
+        ofs_img_sig = 64 + len(sig)
+        flags = 0
+        reserved0 = 0
+        reserved1 = 0
+
+        first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
+                                   version, header_size, image_size,
+                                   ofs_img_sig, flags, reserved0,
+                                   reserved1, hash_sig.digest())
+
+        hash_first_header = SHAS[hash_name].new()
+        hash_first_header.update(first_header)
+        sig_first_header = signer.sign(hash_first_header)
+
+        data = first_header + sig_first_header + sig
+        pad  = bytearray(self.header_size - len(data))
+
+        return data + pad
+
+    def _CreateHeader(self):
+        """Create a pre load header"""
+        hash_name, sign_name = self.algo_name.split(',')
+        padding_name = self.padding_name
+        key_name = os.path.join(self.key_path, self.key_name)
+
+        if sign_name in RSAS:
+            return self._CreateHeaderRsa(hash_name, sign_name, padding_name, key_name)
+
+        if sign_name in ECDSAS:
+            return self._CreateHeaderEcdsa(hash_name, sign_name, key_name)
+
+        self.Raise(sign_name + " is not supported")
+
     def ObtainContents(self):
         """Create a placeholder for the header"""
         self.SetContents(tools.get_bytes(0, self.header_size))
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 5f0de4c74a7..a3209bb1595 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5925,12 +5925,62 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
         image_fname = tools.get_output_filename('image.bin')
         is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsa(self):
+        """Test an image with a pre-load header using ecdsa key"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            'security/pre_load_ecdsa.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname,
+                                       self.TestFile('ecdsa521.pem'),
+                                       'sha256,ecdsa521')
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadEcdsaInvalidSha(self):
+        """Test an image with a pre-load ecdsa header with an invalid hash"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_ecdsa_invalid_sha.dts',
+                                entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': sha2560 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidAlgo(self):
+        """Test an image with a pre-load header with an invalid algo"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_algo.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': ecdsa5210 is not supported",
+                      str(exc.exception))
+
+    def testPreLoadEcdsaInvalidKey(self):
+        """Test an image with a pre-load header with an invalid key size"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            data = self._DoReadFileDtb('security/pre_load_ecdsa_invalid_key.dts',
+                                       entry_args=entry_args)
+        self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/ecdsa521.pem b/tools/binman/test/ecdsa521.pem
new file mode 100644
index 00000000000..ac1904d3955
--- /dev/null
+++ b/tools/binman/test/ecdsa521.pem
@@ -0,0 +1,7 @@
+-----BEGIN EC PRIVATE KEY-----
+MIHcAgEBBEIBM+CNnraGci2/mw1wPq44l2HccHnoBbdP3DiU6zqsBOq8IR8uegz2
+FLzWsjxcW7hwROCdEm6tW99wqsyPE25RZ3egBwYFK4EEACOhgYkDgYYABABu5bWV
+aQ4EgnXFjojX9df3gBEBipphEEFAoG87GuoWBdlimFC8UEEXiKNU37w0wlJn4bG0
+8uOKwDqBk3uF+DrmZwB45lCSKkjdRWsJeDt+iEuFe2O/mbXoL4p5D8MM2OsDV5GT
+srUbxhXq+T/i5lV7XXm2+tT/7zU8ZQce6WRufbd9KQ==
+-----END EC PRIVATE KEY-----
diff --git a/tools/binman/test/security/pre_load_ecdsa.dts b/tools/binman/test/security/pre_load_ecdsa.dts
new file mode 100644
index 00000000000..247b85aad4c
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
new file mode 100644
index 00000000000..be71edbbdcd
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa5210";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
new file mode 100644
index 00000000000..15d71cf0324
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa384";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
new file mode 100644
index 00000000000..1017707375e
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha2560,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

