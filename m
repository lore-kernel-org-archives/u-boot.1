Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECA0C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE3A960BE9;
	Fri,  4 Sep 2026 08:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKCH43ebdmTw; Fri,  4 Sep 2026 08:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4685360C10
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511069;
	b=WFyEpP2HZWzbJFXtzzM3t2O5GkkPWjRMyDbo+GvnkL+ZGdmCVsH4LgdBHSIBDA4RDGX6
	 34pKbTUTg8h/olQZXDTAhoE3fbd5rkplGNOKsKl5i+UK3r2EpdvchiFCPdJ2hrojUGi7d
	 8f4/1RyVUt8hyW6HosgwQAQDY2X+uSq7J8sthe7kc9Bxw3WFF6NpRI3JuOdRLcUYaiNxb
	 drkVAMOWF1pNyHRNdfRGoLc1fMqNmKv7QjZ5Gw5CxROBnlDgTsIiC7gfvpAG1x87grcEJ
	 a2PvvMEE0W6X4o+g/SBRn+2Ywwa9UAwXG1LbCHpCgSdkg+Vbwsj+rOVY3Y9Gbs/3zhg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511069;
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
	bh=M2QLqjHADZvfbJQXVdae1uXQLUObLab6NqHVssR+i2c=;
	b=l+bcMKDiZJRgr0YVCPsSICg7rU91TrGTtqDSPLV1PYbab6DtUL4NaArTTNqXJs0rk4py
	 B1MD9JOacMUm6v+XYcHPOIDYa7UzcWGJm3GTz+RPVikPeRwVpcGZxKD25RdoY9N6kgR21
	 GD/uheb3hHHv7mNNtAIx0OIkWIIEHD+KyRYIA8MC19eUkxJbZwG3H6MFNThrBMKNnS4TH
	 Osu7K0FhQo7aY8w7p/SL6ykPS3FSUnijJt1HZ9i4wVs5Zr5hPHza368Y7g6qfL90yrkM5
	 R2agU7ddFTu/q/A3qrRBba2PKyslTbMEe4DZq6f1fi78S3v3dRsoCIijoNFZ/JXeL1A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511069;
	bh=M2QLqjHADZvfbJQXVdae1uXQLUObLab6NqHVssR+i2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wkLyU+DMDT/FI75pxr6Vxq3ok5vByVFclfaLOpzy46asm+EDgC3iuhUO3WEBR2q15
	 GDMLI20wY+G9q87ZZVutrJKguFX6M/2FAwufFBWwdcVz9FWU/dxJSnSddhRCjKDA8S
	 NyzOZiRDjxyrpGl/d5+ow5sppKXl8ze8b5rKPvf1xhSLR7UW1JgzB6Zvwd663s0Qtx
	 FR/V/CxMY/LgjAGmAxbfZKGUCkLSErwyV1cRXXTptYT0i44Hxvs7FAyFcCDgxDv5ML
	 PGaQOR3MmQnoUwWR0oZOMfxsUqH8rSGJUNgpUtt6IsT5+J1S9qeZklGrtaoom/783p
	 TYLPx9kdDiqYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4685360C10;
	Fri,  4 Sep 2026 08:37:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A36C43DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A162C4013E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nh3CqZGasdiK for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 542D640080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=aMfyGlJQzD9E4nAOo1P8xGPlq2g6E5RHxftHiLZ3usxC3WJgD+9TJC7SIH0Un1vZZJbS
 hxOLNyLxlpvOEVlTEk1Yl0kMkh83kM/ef1pSIvigl77T7Ig55nZZoIiiYThYWE9JYe1Dx
 O2sOkfzloqIySa12ASEyOD38kCYMqck7YGTluCMZxgawJgRcM5IDie71w2kgVN8vVls6O
 orjf5vwEg/hT/dZAZf0HMZGTDcKQMwPN2iQdEKGMjppUb4ulgIqulUcIdoZUyvudwMuOA
 pvWTncLm9ZfvvLaphWlcgTDMLBgYp9AEZqx+Zz5i3A6dshUOuMKeeLk7/ng1cCbnRWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
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
 bh=M2QLqjHADZvfbJQXVdae1uXQLUObLab6NqHVssR+i2c=;
 b=EYlBKGx5HYZ9bgzGQ1nVFY8Zek8JZJNl7qeTPX/YZ2Z8pta6/yUN5w0KS77ces4rQbs0
 KolbRDb1jxocippm/BRis3GObOlks3tImGOHt292+p8yjhcxpjyHSWhzZ1iOd1CXfq/Fd
 E4obnxHs6n2mfsH7CDYB5Q9b9vmTL/DuSu2/iwnZArHOOyD8UjThpJWdipuMA52KoJVHH
 1tyJKBvELJW04snbtIfv18ePtIt3TKlSpZrFz+t6syMW/BJvQQaMJgREBpaa6NRk2uU9S
 Oa3KlQ5YRDJiMaKm3BzNRf6p01WdYHxwnZgsMTas5Q8FlHns4h2fgdqoa5Tbkv5k65w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=iUX6TFiv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=iUX6TFiv
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 542D640080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4RelQYZuQZel47oKl9ZZUIx/bXxkGSxjMAV+9gbIA9snhdkMdujMU9xzgKkZfAZDAUCHtIYLuZytqxEFv4kwcli84y5jUjkzA2XbOgLH8tsgH1sr+z5G32OzorALVjTuRxdj7bbxk1lqIitomrozggel0w9Q9rjseac7MjKgMH01z1Nb5h9WNwMcrKPEdUw2+4066ReZSWqk2oCdSryNYANhcj6jYSXm/2fv0XskJ6WNfXoElsaA19jY5F8kFGoZqfeG497vZVEzpuzLL0JjLB2LNG0gxqtUvY+bj91o4OvFmtr7IbVKLLSpzMdB4ukLdrKDHI0S6TgcsIfjdMigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2QLqjHADZvfbJQXVdae1uXQLUObLab6NqHVssR+i2c=;
 b=RTnB7ynLgtfbUBV2XJ4DskPGeO3DQ7KeojdCI6fQ+4UofGWC1+3068KD7Qcc958J9s2HJg7DrlpqqGJhrYiQkhnr9OdyCqIyrRROoD7h3AbT6YzErBPvKjciP0vnyN6RP9LHSI9wzsNIlXJuYXITNz34WzGi6Zl62Ths9I/nAJLLqt8cOap4JeRMc6FkLZOyyPDREIiN/WQuIuPSmJZ+hmWJ5avdLPkkNodBijQgWjMAeWB6JAtG09aYwjN4xF1Pmgh8S5w3f+lO9L6BsUG2AaWCZIzo/6tmnGnrxM+Mqtu1cn7j51vTXNN2aD3NO1iCCCCWF4eJJmUMKAS6rvemiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2QLqjHADZvfbJQXVdae1uXQLUObLab6NqHVssR+i2c=;
 b=iUX6TFivfPhhZxxMJd1GzB9SG1kVVKuEupDkIQapAihzOEOmBFdT0+aK2IkzIFc6RSey/o/sIemq9nIC3k1wc9pWPDBnItE2mpjOOmXR3ugOV85xXNjE60bY80vOoPiysqomtsEMqC2xPXxLCv8nKA8m0vVfoz9NgbSOuPVWLS6mHgfIPK5G/0OUILCMI3fdh+cbZkjpfWlcefqIMhTvt9FgqjFzpXoTP4fJwTB5tZmuG8taC+BCyurhTYypvkAYOYMq9sADmdSgapq2XwG4RCdd6EOyrBZitYKyk92IvASVytd5Qjs1sYNr29dKUcjX/dSkYYyYfP4yW4jXSpDStA==
Received: from PA7P264CA0208.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::10)
 by PR0P264MB3158.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d:cafe::7e) by PA7P264CA0208.outlook.office365.com
 (2603:10a6:102:36d::10) with Microsoft SMTP Server (version=TLS1_3,
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
 via Frontend Transport; Fri, 4 Sep 2026 08:37:23 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id D9EFF202FE;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 12/15] boot: pre-load: add support of ecdsa
Date: Fri,  4 Sep 2026 10:37:16 +0200
Message-ID: <20260904083719.53132-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PR0P264MB3158:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 64533c14-4ca1-4880-a831-08df0a5fbdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6JZ5dN7sIW7zBvk4mPDjPMQrDwwGDgs+fjyU6SUTFlTBOun3uakpjxTbeA/egg0B3fFLxVb4hk/jRbnraY8Dyv9mvuBUcV+6+VVnXPgOFdI0iA3uv0/Bs+x8wDVkXwhqH262mEksIyWfgz6sGtX5xPe/IaZPm1Id6sC0LpSKIEW3IzEgawPgQyajx1yuFAjx+amf7pEqj0VKK0fasCUDIBBRC6D0ZaW62kDjW7IzF5VAwiT6zbvXITDoMUXnvDXRgvQA7GmPWWh7Mni5aSMbkTgqu2WtmF13xUOmVNHv6VC3nndVb1hz/fmyRpVBczCHgLduYwB2FhIGD2WIkQFfTM6qABVHhc6j4Z3bIHJtSQJu7ThYjfRmuiQ3XFuVO/nm81JudciM9+46Dlg2W61lt3bHl5h2JWcT7CLjSxx9KMKfyQr8qmuUiBYmCg/1DzjZ0pV3RYtQzza1C2Py9kVvQS/pTcr3MG3Ds7xmBolHHljF5LVtd+BfSnM9eDRxB3qoQ1CHgGO2s01DrSialcMRn9SEuD/x390UMBjUitLBzEyZdikladxDBRg4FUZSTM0VMcPBVyY2nD4XWnA9w5VI9ce7KHagBNdTY7MX5C9KfwOU/eIHxOTtlhrwM52JAqvq1fooET2vLjOzjLk7Q/JqV8qs8T1GvgNW0en0jCKYY68HOdL0FUScb2MEdmPbc3KzCO13NLMJpUSvdFvf+5oPUg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fbDhHiVCAxH4J/Afvk56oBJU0XXJ+ccmb4TdDwgnA3Wkz7Q11R15dsrCm64biWqqPjWxS42S4ko/ee6DH1vsx8C75y4m01P6LqPPw4qDTfxZwXnx43kXj3G7Zv1+A4NKV7Xh4/DHSQbmBwCHelJnCRlKy/Y/DnK766CYZOhNv6XFeMNut6pSbei6UJCdGgG8GfZa0lbTxuVIrC0j6R0XaLzpg4UE5UZ8HTEaDYXRflD5ex5V4OUtyLBK5hNz4gd4Rh13ay//JIKuccPXZaE5+sycYYZPKkQrMKerEFKKP18qKwy7mxC5MvlUnYdgX3I91JKDulV0xvXJk5DS8eby7i36SRhPselhJV86DndFP3Dqsq02drlV6cpc6GzoSFgyfYjXWstONPg0Xxy6mRlY70T8rP329qQEQyWGz09LKP1qBuD/Y++r377RjsgGjU5x
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:23.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64533c14-4ca1-4880-a831-08df0a5fbdac
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3158
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

Right now, u-boot can only boot image with a
pre-load header with rsa. We add the support
of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times
v5:
- simplify the function is_ecdsa
- re-use already computed crypto in function image_pre_load_sig_setup
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

 boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..af72ea6d547 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(struct crypto_algo *crypto)
+{
+	return crypto && !strncmp(crypto->name, "ecdsa", 5);
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	int key_len;
 	int node, ret = 0;
 	char *sig_info_path = NULL;
+	struct crypto_algo *crypto;
 
 	if (!info) {
 		log_err("ERROR: info is NULL for image pre-load sig check\n");
@@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	padding_name = fdt_getprop(gd_fdt_blob(), node,
-				   IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL);
-	if (!padding_name) {
-		log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
-		padding_name = "pkcs-1.5";
+	crypto = image_get_crypto_algo(algo_name);
+	if (!crypto) {
+		printf("ERROR: can't find a valid crypto algo from %s\n",
+		       (char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (is_ecdsa(crypto)) {
+		padding_name = NULL;
+	} else {
+		padding_name = fdt_getprop(gd_fdt_blob(), node,
+					   IMAGE_PRE_LOAD_PROP_PADDING_NAME,
+					   NULL);
+		if (!padding_name) {
+			log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
+			padding_name = "pkcs-1.5";
+		}
 	}
 
 	sig_size = fdt_getprop(gd_fdt_blob(), node,
@@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	key = fdt_getprop(gd_fdt_blob(), node,
-			  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
-	if (!key) {
-		log_err("ERROR: no key for image pre-load sig check\n");
-		ret = -EINVAL;
-		goto out;
+	if (is_ecdsa(crypto)) {
+		key = NULL;
+		key_len = 0;
+	} else {
+		key = fdt_getprop(gd_fdt_blob(), node,
+				  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
+		if (!key) {
+			log_err("ERROR: no key for image pre-load sig check\n");
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	info->algo_name		= (char *)algo_name;
@@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.name     = info->algo_name;
 	info->sig_info.padding  = image_get_padding_algo(info->padding_name);
 	info->sig_info.checksum = image_get_checksum_algo(info->sig_info.name);
-	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
+	info->sig_info.crypto   = crypto;
 	info->sig_info.key      = info->key;
 	info->sig_info.keylen   = info->key_len;
+	if (is_ecdsa(crypto)) {
+		info->sig_info.required_keynode = node;
+		info->sig_info.fdt_blob = gd_fdt_blob();
+	}
 
  out:
 	return ret;
-- 
2.43.0

