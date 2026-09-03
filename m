Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF23EC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76F4D810DC;
	Thu,  3 Sep 2026 08:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgjsZ1B3Xnhg; Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23E07810D4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423458;
	b=FChaCMpXGeh2fdwmYiDmIY50gR8t+yEWxBeIN++pEjEm6v3UWeFLZr/LQEgki4o8w5nr
	 RZvaZlyuf8TV3CQ2/ZVXx1xUKRen4QKM1mn0azi8bzYjG8jaUVtt8bauhuN9Rm354CkCw
	 WUFtH04CoaVM8wO7WoDDEHLdW7T22Erz7krsZgGS0N4lcHg6QPO4BsvNvKEEDGb4s+mcs
	 oTP0yNE1DtWtW3R6/gxPGyaRuETcqcDI+dpdweCnn4M01WK/TqfhJ9I1mYjnc7S2iPwhI
	 6AHELGrW9teHRPBgRJvs5xsjAPjyDcUdjE1bCVOq3lMfSbCFCx01Ytl/dc8Z6l1KROw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423458;
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
	bh=K6FPFqFaCxxEnT3g2ero1OSTFNY0NYcEKpvmBbOnKao=;
	b=JYWJoVdsnoPh4EdSMItm0nMQlfV3QaveE7wG5bvc+IOSTkbqG6PMKkXUhm/iVNrBkr2T
	 GI50wzxn8dXaVHQ0wD+fiszOI/3+TnJ+JqvL6bAVc5mXXktW7M7udlxvDRSeC2/CUmmz0
	 KqQNjBwxMK4R4YbElNQpZzE0Hl5eRub68ap0RVpUFwLD7elFf0ti9rMt5Rs91xJ4DA8/2
	 mXMElRGkQ5uwtnM08ubQOTR2xomGWoq+eABUgDkG9BkdYbmnwzM1xmqxkke+vFrwXCGwv
	 us5aVlPRTbtl8PASp9EQ1mAU6jVhWXOdDWwpcyKhht2fGtZlWXntaNzKxIMFPa4kGNA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=InKgpo6R;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423458;
	bh=K6FPFqFaCxxEnT3g2ero1OSTFNY0NYcEKpvmBbOnKao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ejn9YiC9FdeGkw1BUkK16ekQyB5zyGdAUqpp5tEyoLCorCXsL2LnNJ/ZM8SkYnFLu
	 JqdNpL3yvPJLIZXrxm3Cbk+aJMsmA8J2TDsYcQSRPptXELSvDIaN23HmcVnnMOMW2Y
	 3fnbcjO9bDb2pmR1ve200/mUtpl4ZH7BwLz7zebzvrOSiPRV9NGfd2J60Z1aJIb1jc
	 jCkXnc7H1TeuWHlWqcoNKRlv7wAON803LyslnB0r4yKqyMKxeGk/ded72YgPF1tS+Z
	 xJwqYqrBfH54pXPjo+CZhYB7Kq/RVz6/HJKq5I3nFIWWPGq3exljOUl6Qk8DDL1lKO
	 AI+vcwGB+efJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23E07810D4;
	Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3022FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 404328081C
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSr5BdEXrZwb for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1058E807A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=Q0Q7GBqyJTfIzUlisZzSPT1ds2RfLalThxxuGjivVBygFV16+rkCDodvwl6qqkxc/2on
 8tKhncCXiIKBnRJm7SOlU81KXj4+wYxILwCSsJq8eSCqoR7BnsBYhhjdyzXfO/MpFH31+
 gN/RbgTxayDEAB2/TW2AOO3Co6r3aIAamsDjWJ07hPlgzk1Q3dGFxe2pqaSQevoefSkdw
 VJoBDmG1C2EK/YFsM5GYqNLFkzAJjAwiw9umBmCRe6YN79vrtciWyi2GaMfNkil3KeLdq
 mgN5XZtm+ywmJu5veIKLG7czzVMWL8R31qS61Vd91eal3IM6+fUdoxpwkekiVQ5cPbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423442;
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
 bh=K6FPFqFaCxxEnT3g2ero1OSTFNY0NYcEKpvmBbOnKao=;
 b=brsp23SyNFIDnP2eAZT99UWMsMfcbgwfOIbfzaPLfFq48rflrvV0JuDYq7hXmht0bhkz
 TndJe9mFDbqXVpawenfQbvXdi9RHlD4waGqEI9dh0WViwDPiicFv0M8t9Z+ahVgNqTRh4
 g9pvHR5n22AZmSpdBcsbPOb2jKk3zdDjeVtu9D/nqV2RSBQo6Lnjr7TejJIS5ZhnKL60x
 QNYOaYiaeX759P3eDvRJ9G4lVt6oXc0/98eUbVeOYlBogQKCD/Qr8rMmDnQKuzMUdNvDS
 zD8SF0duaNaL5C4ztdLhP4ZNQpPsuX3dOcNgeYPR+/fbGbmvo0h5oTie8bKQZcY5GzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=InKgpo6R; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=InKgpo6R
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1058E807A1
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5wFLOBdyRhUkSUjp+khHUIJSU54Dhj/0QpUM8H5P3fZePXnyKrFaLpgjxuHzfjOLBot5jiVF/fMtRdwhq6LBd1VmzxSfgL/sHmF+gFPDOXxsrz1USTm/E2LpjshiufSPlADo9jDMh48v9+xMcLwo2XYLU3GemkGbPpbxVPabkMNly6h7SUgGbVUfDmHh2wSpXSa/5y6dfderoYZwoy0iriyQHOHC4o2jbl9UYZRAsivPYf8mk5NMwFrAcLVNre8sDxGnyia6o8Pa41l38+fM+krK3W5pYZLi4B6gXd/Uy1dTA48n8p+XLa5Jg1jPVlrlSfJPdezNCH2TeQOetK8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6FPFqFaCxxEnT3g2ero1OSTFNY0NYcEKpvmBbOnKao=;
 b=liUgoM8ApLK8HUZZWmi5lZBs4Qfg7SP/cxVuIaLb0XQ0YpdbswXA2X24vWAgqxe8YwUwS6LjzTFvmKklziyViaxQp9/88SL+l6l2y1uF9TksZXIqBXB+mM8XL1vcfXJxqosOZDeHfENmfoeHQuur1RNJuM+b/YqPFXlbZnf4aVKHX+4A742NMygyQP/40Ex9Qiwx+v3bOnt5HVX8C1kGjROrjZEv27Ztvku1kkTnoLrS245w4PSP93hkMQ06AfsmbM3xkDrQH4YX/EWT5HoJaHkedbIC6JikMKQqjT2nCEFbHhVqT8kYqMbgFm4QGIvIV6/xQ1N2SKL8+Tg61xW7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6FPFqFaCxxEnT3g2ero1OSTFNY0NYcEKpvmBbOnKao=;
 b=InKgpo6RICqM1HFMbtDTqG+E/+clvkQCASIY27uuq8FLOZlVvW9VEvTiB2AelkQlmhr7h49TGxXHDZ7BUBdFOExH2VTujr53DlUfFlajlYiP0gf7cuVZHRbhjNR27Z1rI9zpRb9qpAtUw3tU4T7b3guTWLs9BDg2tYJ+GIOsnEmnXJAiU4FQzpiqtRMMfBdxUzs+kYanhWLWu3MJ/QoVKIEaaXgKlQ+FGQo19t3iENXvDpWa6iHw+z/XLWBOuPkMiqyppLtuHKWpCrRT2hfnhj39KLOsdDrzIcrx3+hCw+7oAcXcLb1hnOqqi04tCFvHfaUUNM6GOeypH1VWndWQIg==
Received: from PAZP264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:122::7)
 by PAZP264MB2925.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122:cafe::19) by PAZP264CA0020.outlook.office365.com
 (2603:10a6:102:122::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D20652002B;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 08/15] test: vboot: add test for ecdsa
Date: Thu,  3 Sep 2026 10:16:58 +0200
Message-ID: <20260903081705.12894-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PAZP264MB2925:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e1130a6-587d-433a-d7f2-08df0993c46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6zYAxjJJ833+e3LVqBQ7zqZ5Icaqwtn72sUlsMK8wBOs2sD7+T/Ih8/s0Da1uJHD77PNFNXhBiXgt2T5ueGEwLhwggv4Ksp7i9hzN8QQTxDkibVbPT4I4tXa+M+a4Ffsw0YJWY92KHW9SIEtRo/vNP1yt35HEGyVLm+KBrbfypQRWIaFj0j2B0dLlWfNxvdfyNHoUg00LDY+iosGS+J9Wwq9es17LXroEjBlBa59JXsvZcCn5Hca/8u2NwL/zLaQhcMh2XizkmNlp4EIlL2XaL/BU7fJsCUdPHHhjpAa6zJUyOmP7ZA6Qzdm1FtE1Wi3OJT7F9XlQznKgtiLcn8FAHRSTCU8FovjJUI+lgH9fc3+/vAUbdlP2w+N+rr4cOHunF0ETvqAcVxsjcsrbvImA9ROu3T5cgXUbSyywxHGQVzS0p2C3Sqy9tRmLJXNxzvpV/4KLmzXGHKHZ3mXES37paK3Rnevc8Ul30MWr4Ql4mjFF0/A1Wlk3lrDOZddnIVISr0OH2VfXuaQrpYRKgRitVGbsTdAuMf9TnEMlcfAUZDgkohhtpXJ1o7aK40jMHDP9tlMi9eJVVDXWuXxkoZKz3kmxDHV5PE4dgtIRpnW0xNdP4Q1N7DyK9EbZZV3nO3lF9PPv/e6UH0crc5bbSxpIWRPYkKENKt1dPOzVyhgTWC7SshZaJ8fzml8G0M8mNEXMUypWIZtTE/hQ/qC8OJGcg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cCSHDJjneTpgINWlQusT60oBUOUCGA2OA1hBY7w/6ptFDiORq2dgjz4R27rIIQn/NF76Cps7CXii42wOvlAFk1o9kDCSB0PBoGPjYaqIhpye6tKIm0A0c3Z38AOrHDVoHXeMWafKiyoGqDuuJJ8UbvuVKNQM+nt8ZbaRlhil+IJ/4tM2MrPptgWVUWMQBHJQ5fqcSbZPL49UhpT2vcoQa87MT4ha7d7unL0uwy0L/Qlky3p8fIC0CtIkiWyNJwJQHnqg8CanJyXLJwc1v/a1I+ma14XcMVUUsim3BFpqiA3dJE/5W29zx/jYKmP+plEZl7erJXQILXTTABnGUfjRa8og9kESRRdeitHCb3Zujewv7MlFsV8e9TGhqiNEVUwBu5IFL5mgT+/3tQdZSzsi6yVjn+sjgGmYcmhX+ndEAPFyoXOBswsRDj24DHa1ge0n
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.9909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1130a6-587d-433a-d7f2-08df0993c46f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2925
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

This commit adds test case for ecdsa on fit, but not (yet) for
the global image signature (preload).

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- some minor changes to fix rebase on next

 test/py/tests/test_vboot.py                   | 29 ++++++++++++
 .../vboot/sign-configs-sha256-ecdsa256.its    | 44 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa384.its    | 44 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa521.its    | 44 +++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa256.its     | 42 ++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa384.its     | 42 ++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa521.its     | 42 ++++++++++++++++++
 7 files changed, 287 insertions(+)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 33cbcea5c24..89876ff030a 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -94,6 +94,9 @@ TESTDATA_IN = [
     ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
     ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
     ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False],
     ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
     ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
@@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
+    def create_ecdsa_pair(name):
+        """Generate a new ECDSA key pair
+
+        Args:
+            name: Name of the key (e.g. 'dev')
+        """
+
+        if sig_algo == "-ecdsa256":
+            curve_name = "secp256r1"
+        elif sig_algo == "-ecdsa384":
+            curve_name = "secp384r1"
+        elif sig_algo == "-ecdsa521":
+            curve_name = "secp521r1"
+        else:
+            curve_name = "unknownCurve"
+
+        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noout -out %s%s.pem' %
+                     (curve_name, tmpdir, name))
+
+        # Create a certificate containing the public key
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.pem '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+
     def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
@@ -570,6 +596,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
         create_rsa_pair('dev')
         create_rsa_pair('prod')
+    elif sig_algo == "-ecdsa256" or sig_algo == "-ecdsa384" or sig_algo == "-ecdsa521":
+        create_ecdsa_pair('dev')
+        create_ecdsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
new file mode 100644
index 00000000000..6bd291a40c2
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
new file mode 100644
index 00000000000..68c482acff2
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
new file mode 100644
index 00000000000..f673accd39a
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
@@ -0,0 +1,44 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
new file mode 100644
index 00000000000..009003bb601
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
new file mode 100644
index 00000000000..567de687a06
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
new file mode 100644
index 00000000000..74ed45b21b8
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
-- 
2.43.0

