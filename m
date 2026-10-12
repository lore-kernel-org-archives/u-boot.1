Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9B0CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 453C680DA2;
	Mon, 12 Oct 2026 10:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bXofC_q0q4K; Mon, 12 Oct 2026 10:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 114DC80D02
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802116;
	b=Q1PN+1zB8XwIhXBRdMK3vXbC6z0XGNOCGgKHH9U+WVh5DgfZ/sMMNXu9jrGlYVDeCa+z
	 6NF2WA72LTKgj2yf7I3wRkc1lmwWMVY0d8yWYqeYdpPJMQnRaFskRHalrB45AM9S+4Yxu
	 uTJQZuLoas0o9KYvrs+BRRlC+smyN7wfTwMgjwX5XX1AcwX6psiib1Mvdh5qweX/7wp8X
	 P22FaRy/z7Pugq3vBT9g6d92XGJqUx/vLwfnht53PV7EsQCXFAbUJL9VXIrJ2tEt6EJiK
	 SvOQdCCDimqM2zhVa1RlFNooQlTVLagm5tSN1Qq6bTwMlXrXkSKr7TfUuewEg8/DmpQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802116;
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
	bh=f+BN9TDbewh7FFVKNJgmTJk0Dhs3wOf+O7uX8sBnCvc=;
	b=aQj5+/oVaHVHnkZ1UCtH+MCatzvcoLiOSO+ynRecTEgCDd5VAV/naFUHdY8tqcWtkKgF
	 4RfyzGQNlp1qVZPA+DlhVS7hB9Vw8k+6yPMhCs/b3YQXOKm5kVLqgrgGjKXmvQg389uJo
	 ASvE6pP0xh/Id9lawR1D4M/xj3Yhu7Pc9FVkTEr7Fl51S7OuvMy6UwTQqYchHshZ9oBxo
	 TxY+q/azIELqTov12Tfzsi6TP4MW7Xhu3TTjChF7Rh6foI6NKPZ/coIFyCWX7+OtACTwr
	 7gyGr+KASfvLIVNwM9az0kWUq+8UaMVMlRmbBGVmTIeN9D+HeA8gW05SVYndwSzE1pg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802116;
	bh=f+BN9TDbewh7FFVKNJgmTJk0Dhs3wOf+O7uX8sBnCvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HUIEwK02wu+RNSGl7SkvxApca2zcn40g5SCGiLA8wIHkK3P1Cm08wv0Kt5CYxSf+d
	 tpzSxg1gYEmIeK6TbyBaBVSQFhRQKuPen+4qHLiuI5t0CWaZkuZ336sWgW0zFTp1Ca
	 RS/iXhyte0ZCVu1EjDwGvMQdDJ4jXuZHRxUrUqgz8Du70n7qpSp6QRPE3E0mOJ2meT
	 ET5txZLCzoRwsnQ4/KK6LgMfAwrtqMdES7PudANGw+tZaG3eEE2aWb7kI65frjNQjw
	 ZBEI356iGCcO3h9l1it2jseikXKeFLPr39NP8KN7WUbAFfF5aErVoC2uk9zQ+xZUwf
	 y7PIO/PgUnZ6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 114DC80D02;
	Mon, 12 Oct 2026 10:48:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12B5CD5E
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF52040558
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXCSyZkGdK5R for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C0C940557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802104;
 b=MQafN1NK4Kjby3Lic9lHRTxX0PbgWMf6YuSUQPIySyttxIDXvvQN25u4Ps2j80Qfrzuw
 T2GlmbvduzhjO+uNLO4MxgcNdm1mIkWGVyKWyPJv07hNfpPiAelg5ToEyjR4fznXTnDmq
 5bOKK2ke1+pqr9B8VJkc4PnVhkxvuDSwjOBFZGErp+7ru4EL6iSC+YN/MR1S7n91DKdDr
 qJ/dv+a/fqhL23BddZZUMA6HVUPIb8AestgDS+MjXZTpz8ne7bZlPrYm+lFfveGzzfW3D
 GI+XFILQXisO/nen5TvOTxYuvhBiif3b+ScxMsE6ZqDvx0FQHW3kBfVOP191Wv6ZZEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802104;
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
 bh=f+BN9TDbewh7FFVKNJgmTJk0Dhs3wOf+O7uX8sBnCvc=;
 b=jW/bw97G2XwAHMz0N/ob7N4n/vG+VreDRZ86POSVwujjWVXSuGgoHYmrleouvUtVZ9Ve
 p/hcMl6w+CBHYrTTQysvfjSriXljGJCin4Dzt92H72tvfeMlvqQt43S9yxiOD0ocjGBiK
 ccI5qKh42v86xpPLbci5mgkRVrEe6B+04oYuJX+EkDOK3CgnCU3jPqU64V6z7kUXIl2S+
 hWJYrjvq6E08OpjyWyrv9h3CyNzxRQDPmZwnSvIPkvGLuOjOHdWIGfNcrhZHU985Tm1Ah
 nAkIo8bSYtbFEPOFlj7zEfe3UOKAGyzeXZ3jXWFJkB5T3Nz5ETzkInI6ooJkG4ElaZg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b="Ls/8PHJD"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Ls/8PHJD
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C0C940557
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/K6jY+BZNayFcue2TC0lQNGabJhdi3JB+rJDnM2q+Nkp2pLUPRBh3pyFpB1c9B8pNZ6sxxTB3qlMdbK1YQVQ4DbY4ZHJk2qK5cIthNv/7QPk0hSYOCjJ6UyeCg/fwpvaTMh5+AZiSd44M9H359mJ3EzYc/Ggfj3Ncn3NVrhpxRPEalYmS8cBORhcLEFMmHBzz5oERIcjf4vvkATlBtXiayQbMSuyjGoUm/qDFgElmIy9nuoadKQmu+5aD5gBiHvRMvbQc7RQGH0KMBTaGya6uLfSyJbnQzKx/oTlrxA4lCNyTm000/RuktDh3cBkIdzb6E5c4oj5Z1cRnQUEqI+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+BN9TDbewh7FFVKNJgmTJk0Dhs3wOf+O7uX8sBnCvc=;
 b=pFj4HmeYP18cbs0jVcvl9pvK/kPKw4rC7dceMXxZtTBPqDOyU65+n5ZIskhhDGaN9cLSM1tPSD8ui3uEtGumcogTMKfEAeaHd0m0NF2hKiUrT/1KtR9EGJF1kNUoOCuzw3jgI9T7WMoasRbWNCHp2GX64mRE0KCVYdZdU9aIB9hXGSn123ONVphTarftrrd3IvlAAhWGpD+JTFpMtuT7C9sZ+FNqLwTCKF4e1Y+1oKzxX8GCROf2VmJlvSySWAfEZmvl+eBFkmqiPJ1G6bem7JGyewZYoJIHCVUxAUR3i0JkjQ9hSyxr12bZtIy/HkxiN8Y9Q8TUIy8C9x5ed5PZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+BN9TDbewh7FFVKNJgmTJk0Dhs3wOf+O7uX8sBnCvc=;
 b=Ls/8PHJDexyC0y1KCtwCQft92tBLYjiiMCt3Cl6JRFG0F+xNA/4siysVsvdASJNy+JeMgq/p0fUFcv//obNL16IWzPQ0beG2vnmRFlsvxrwnIix98lbn5HoJilZi+ZOq9nr8wJS/CdVNBSjZPDbQKGPF/ai8kcIImHlNijFbkmm1v7KZZgq3AEE0YyMgsVszhM6C3PUPJoTJ1Ho00aTDYtmO6nVa6Ih9aYnHehz/1BS99mNJtoeKJQd9VKIzbpiViust4u/gBUX3M0Rn7SX/DWm+jD4t8gD8RI39+vbLuCD2xv9UkY80kUiGiJaNUS9xmEvqwGDev1X3bFED4WKffg==
Received: from MR1P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:58::20)
 by PA0P264MB7396.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:57d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:48:17 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58:cafe::48) by MR1P264CA0187.outlook.office365.com
 (2603:10a6:501:58::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 12 Oct 2026 10:48:16 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4D6EE2010C;
 Mon, 12 Oct 2026 12:48:16 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 5/5] binman: Add functional test for pre-load HSM signing
Date: Mon, 12 Oct 2026 12:48:04 +0200
Message-ID: <20261012104805.17297-6-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PA0P264MB7396:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fba691b1-f9b3-4e0b-f711-08df284e5277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|6133799003|10067099003|22082099003|18002099003|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info: LfU+d3ill4mnci+dBu26sg15n/ecWu4H/pOcdshSy/CIRaRvJ5dnoaX6LlRuimt9ygEDZD2ygYvr7r2xS0Q7aaY6fFFMHf7ahWv6izGgA3hsn0LsN9njFVj25gHG/K1RGdxeC5SYMEo0M95ZrWyQrM9+ZBzuJSRAvTOe/tDFT1/weZ2VzD5bFrzig+FVwDbz+BBmH1+KNKe/Gm22UcsB7MfmrHNnMAw9y7vANS10Z4KV/YDsrNCpUykjQGT7nS4EFqDv5ovvex12oZHQp+7S6Ovm9rr9GTe4lwHrDTp1NYYkDo8guKMlxk75geYwRg9V3ki+9fqKTuEWqTDFPZgMM/TuntsEXCrYJ3RhLhethRj4MdpsmOVZXbFV67n59hyj+Wx1VHSz5MBv7Oc87sepni0hUwA4ICHz6Cak5NxEk/l2PhwrDano3TLeu+SEQxbsuHlgG7rXAKztR0YBQr0tt07fL2ZpzNWwPIIK52UbFg6Lvsg9gsRrG4baVoQgdk44BL7wwRt0OSOL/MGSZYWczrgl5Eme2Cav2Z/SZ+2AeqawRd6908S7GbHGN4NhNvg3JzzWo8GL83rtmuxHhoh9EprJ7xsm1BvGfptEghxllH/e6xTdYKG6sEfvPRcP5VjQS+O2DA1Egtn9kAOGmCHf/JKOKoFWBXJDNMUz1+tZKbcxsJ7VflkjA4um6+jtf2JMwszEEe4OJb5EDW9VB7We7A==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itRVppG3chvCK4EmWOHP/uir+yyVSjtVBvYU24fHo6q5OPASFRzTaCLE4pMhjA8dnbPgwBLG3dw5eIFG1dU82QE3n/9xAHKi77Lf+HGaUotrFyq21VH/I9R4XVJBqfoxllLVtGt8Hc0Zo+22vV/yqkJ42jzq20YrmdHWNjbyvc36WGJdYc/12c/PqtbzMwU5REHaqmS+HYWJrC1gdL9/UDxuKfdLGfcNM2RyiildfEqOxPuPJKf4tignYh19HAjbJrdper7gUGeiyawFi8ZWjaIZaUeTEz2oRyQ3klXQWJGPHdhvES7tI7XigLAj7xKcXF8d0k93ZRaS6SRVvNU2mKiYuE5hrVGrf5TI5130hzzPA61nE7sZ51zFndCT0LbGqsB1DOJCRkZd0n9SJqrjMmQ78Xy2pEXGaq7MgB17Zm8yEhUtQPNKDo/G03RmovJh
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:16.5376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba691b1-f9b3-4e0b-f711-08df284e5277
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7396
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

Add end-to-end functional test for HSM-based signing of pre-load
headers. The test verifies that binman can use PKCS#11 libraries
to sign data via hardware security modules and can generate pre-load
headers with HSM signatures.

Signed-off-by: Yan WANG <yan.wang@softathome.com>
---
 tools/binman/ftest.py                         | 76 +++++++++++++++++++
 .../security/pre_load_default_padding.dts     | 23 ++++++
 .../security/pre_load_hsm_invalid_padding.dts | 27 +++++++
 .../security/pre_load_hsm_missing_library.dts | 27 +++++++
 .../security/pre_load_hsm_missing_tool.dts    | 27 +++++++
 .../security/pre_load_missing_key_name.dts    | 23 ++++++
 6 files changed, 203 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_default_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_invalid_padding.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_missing_library.dts
 create mode 100644 tools/binman/test/security/pre_load_hsm_missing_tool.dts
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 329b91dfd06..e76a8042f4c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5994,6 +5994,82 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadHsmMissingLibrary(self):
+        """Test HSM signing with missing hsm-library property"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_missing_library.dts')
+        self.assertIn('hsm-library is required for HSM signing',
+                      str(exc.exception))
+
+    def testPreLoadHsmInvalidPadding(self):
+        """Test HSM signing with invalid padding"""
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFile('security/pre_load_hsm_invalid_padding.dts')
+        self.assertIn('Unsupported padding scheme', str(exc.exception))
+
+    def testPreLoadHsmMissingTool(self):
+        """Test HSM signing when pkcs11_tool is not available"""
+        try:
+            with self.assertRaises(ValueError) as exc:
+                self._DoTestFile('security/pre_load_hsm_missing_tool.dts',
+                             force_missing_bintools='pkcs11-tool')
+            self.assertIn('pkcs11-tool btool not available', str(exc.exception))
+        finally:
+            bintool.Bintool.set_missing_list(None)
+
+    def testPreLoadHsmSignError(self):
+        """Test HSM signing with pkcs11-tool ValueError"""
+        from binman.btool import pkcs11_tool
+
+        def mock_sign_value_error(*args, **kwargs):
+            raise ValueError("Mock HSM error")
+
+        with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'is_present',
+                                       return_value=True):
+            with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'sign',
+                                           side_effect=mock_sign_value_error):
+                with self.assertRaises(ValueError) as exc:
+                    self._DoReadFile('security/pre_load_hsm_missing_tool.dts')
+                self.assertIn('HSM signing failed', str(exc.exception))
+
+    def testPreLoadHsmSignRuntimeError(self):
+        """Test HSM signing with pkcs11-tool RuntimeError"""
+        from binman.btool import pkcs11_tool
+
+        def mock_sign_runtime_error(*args, **kwargs):
+            raise RuntimeError("Mock HSM runtime error")
+
+        with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'is_present',
+                                       return_value=True):
+            with unittest.mock.patch.object(pkcs11_tool.Bintoolpkcs11_tool, 'sign',
+                                           side_effect=mock_sign_runtime_error):
+                with self.assertRaises(ValueError) as exc:
+                    self._DoReadFile('security/pre_load_hsm_missing_tool.dts')
+                self.assertIn('HSM signing failed', str(exc.exception))
+
+    def testPreLoadMissingKeyName(self):
+        """Test file-based signing with missing key-name property"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_missing_key_name.dts',
+                               entry_args=entry_args)
+        self.assertIn('key-name is required for file-based signing',
+                      str(exc.exception))
+
+    def testPreLoadDefaultPadding(self):
+        """Test pre-load with no padding-name (should default to pkcs-1.5)"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb('security/pre_load_default_padding.dts',
+                                   entry_args=entry_args,
+                                   extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+
 
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
diff --git a/tools/binman/test/security/pre_load_default_padding.dts b/tools/binman/test/security/pre_load_default_padding.dts
new file mode 100644
index 00000000000..2263df72a25
--- /dev/null
+++ b/tools/binman/test/security/pre_load_default_padding.dts
@@ -0,0 +1,23 @@
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
+			algo-name = "sha256,rsa2048";
+			/* padding-name intentionally omitted to test default */
+			key-name = "dev.key";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_invalid_padding.dts b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
new file mode 100644
index 00000000000..3e735e545a9
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_invalid_padding.dts
@@ -0,0 +1,27 @@
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
+			algo-name = "sha256,rsa2048";
+			padding-name = "invalid-padding";
+			header-size = <4096>;
+			version = <1>;
+			hsm-support;
+			hsm-library = "/usr/lib/softhsm/libsofthsm2.so";
+			hsm-token-label = "uboot-hsm";
+			hsm-key-label = "uboot-key";
+			hsm-pin = "1234";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_missing_library.dts b/tools/binman/test/security/pre_load_hsm_missing_library.dts
new file mode 100644
index 00000000000..34dfd16c163
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_missing_library.dts
@@ -0,0 +1,27 @@
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
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-support;
+			/* hsm-library intentionally missing to test error */
+			hsm-token-label = "uboot-hsm";
+			hsm-key-label = "uboot-key";
+			hsm-pin = "1234";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_hsm_missing_tool.dts b/tools/binman/test/security/pre_load_hsm_missing_tool.dts
new file mode 100644
index 00000000000..451429688fe
--- /dev/null
+++ b/tools/binman/test/security/pre_load_hsm_missing_tool.dts
@@ -0,0 +1,27 @@
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
+			algo-name = "sha256,rsa2048";
+			padding-name = "pss";
+			header-size = <4096>;
+			version = <0x11223344>;
+			hsm-support;
+			hsm-library = "/usr/lib/softhsm/libsofthsm2.so";
+			hsm-token-label = "uboot-hsm";
+			hsm-key-label = "uboot-key";
+			hsm-pin = "1234";
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_missing_key_name.dts b/tools/binman/test/security/pre_load_missing_key_name.dts
new file mode 100644
index 00000000000..b83fa817b0b
--- /dev/null
+++ b/tools/binman/test/security/pre_load_missing_key_name.dts
@@ -0,0 +1,23 @@
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
+			algo-name = "sha256,rsa2048";
+			padding-name = "pkcs-1.5";
+			/* key-name intentionally missing for file-based signing */
+			header-size = <4096>;
+			version = <1>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

