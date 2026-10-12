Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F885CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 10:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4EC780CB1;
	Mon, 12 Oct 2026 10:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpkejkKvtxCT; Mon, 12 Oct 2026 10:48:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CD81C80C66
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791802104;
	b=rReXr1OXE8dJkNSVX4mgAOJ7NrmftmOc1tnVvdFp8SJmhKssd6CiL+csORQJC1/zaoAU
	 OZ8a64Auq5zMcHfcTeWTFVJeSDU63e9VqzNN7/zBmQ1QzZZWOpGoVI51e4BH4kqXR3VCV
	 xK1I13Fn0psWWmediXV0KCbZUvD3Ue8GNPY/l84/3zc5KxvhGQI3qUBLt2o9G5DFYogkN
	 QAUm7G7YwM/6rFgo45+Qh8bHOe+I2zANFoxhF4G69QfDp9yCrZrsdXK1q9yAnjfFEr9Mr
	 wNL+IdAz25H5HD4PPG0Z97TXVzI7EL3z+kXkjxQFS5Z3bKUcc8fVr9dRWFVQvGim17A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791802104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4/UNJed2QfRAIZcVCm5bPj4KB/a6VzzDwkvVOtAWouE=;
	b=NwssBVupdifI56E5nKVAgfpRYgWm8x4uIBM75NZk3ic58LgP+vPaSl8dLikVBz/IHuz0
	 Tir4IIkj9WAZQvGXdFaeb1lH2W0k5cLcRJ23lPFUUXzznCiyiyDa90pFmJ6Gr30bsz+Me
	 zKf7heeQd9GhGpokj3D8+ozewe0vcF6y/EjjT1A/W+PwDK7rhGg3j9khe20AWOlJDaGHo
	 ArHS+SIIPYAGsTUlF8ymdmcjvDMF9PoxebXJR1+NZYCbTx4zDOPDUmT2bR3X/k1ieh4gt
	 6hiB7lcg2plHlw5Y5MKpRIWMbpJU/0+8gV03kywumt+PxvbZ1xP+QfFvsGHpEYB7otg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791802103;
	bh=4/UNJed2QfRAIZcVCm5bPj4KB/a6VzzDwkvVOtAWouE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RdHJJPD3BzMD6XmNsDpHQP+qq7ukyBHvG74NXugH/LOlhUYiodW64jEiNgQuBJquf
	 fyURQEATl5+COc27Es8lTPJ+vNqwewyGFglZBl99ecBDxL0cnSuQa5LQbty5gwE2NS
	 Dpam/gxPj2eikkIECcrSM+R/UtSKzM6kWRc0NGoJSgmJPSZQgbqYU7Q5854F24xtRX
	 YYE934v+yBQJwYlYM/DNOZ6byLUyNFOxzLG6kN9e0kvUflnfpGKcNnk8lUyyfjzpfO
	 wmG42vQiafkuJ/6CV8lZfV8nOhmkKp4IlBz07/EraeL2fLOvaOarjDp8hPVd3lXvmI
	 Av2E4cN/xxR6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD81C80C66;
	Mon, 12 Oct 2026 10:48:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4F2E9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B6A4D605ED
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aozJ2Tjv5cI8 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 59CC4605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791802099;
 b=mWJ6u3KIta8kLTJfkGsDE91F5gL+PWbWmM2MZP6w3g98eOo0LYxsg017W653bM7dYaKE
 v77CbPSnH2hGnSnEp7846RYdtSBje6SC8Amat7epLpmgT+8edMc+OajylSlNZNn3NAbVx
 07Wjq0vWPS2Llav3VH3i2PF2VKm/R8HTAUeLa+GrChBNaRnV19w3ss4XA9B4OEx5t9t/t
 oJ4YRNed7A4vObUWRIksQxYdxR/Wuc1rf4oacfUoD3iEBAmWQxtVuZlZDdmHc/Ac5p0e3
 vrjjmZmSmf9gvUOz4v/rRdWJDdzAvna2LVkqv0tNQIq2Em9TNFQVDRFyHozEHFWaSgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791802099;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=4/UNJed2QfRAIZcVCm5bPj4KB/a6VzzDwkvVOtAWouE=;
 b=XM/V3sfHCGZ/2l8DfYSMnCgZjFAxuJycph+qOzXkI1uWNrRVU+OQVtS4SLO7KSAxj7Qd
 MhLxbVnd45X4pHL8h1/svfSBrqBZD1zU9+F5iAnOxM0UtxlZXg/5HI+gVh/sAc7NQKEfZ
 2d4gjxPC9zKExYUYN5xyd86ps8+6zCY7tqZxXjrORUKFag4KIzI3LQlXSVZDC9ZzvEinH
 eP6VPUYes3AgKTQFqdGbxeNRHcP8piP2heqqeIXbwpvsxK/57p7vsGtEAFisYQQmuSLMO
 6VW2d5oNBaRdhbTL09X4JEJXaVmfGF/3zia4UmXuUgA9dlSKoFggkfL0GbkleMi2kTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=bSMfVhd6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=bSMfVhd6
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59CC4605DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxXGMOQjueIch3XPXFrNqp8hA30BQOGfR9rBVEGxIqvUbZuY8xPSNcVt+Zb33FA1BTY0wuMCg3gL7Kf1QjTUBw4itj4pPCiNNV0kwrbP6MNwW0NhrnIEYJQtz2ujm5PSeE2n2MtLDueQEKrVcP1tuEdY1HAr+c8ie//cmJF3K/o0W5ovdaZKtfyVs7Wvq8texhAcseE9Xr1gqPfiyomgUEer6OeVmgPdorGgp9W7+DQOw/yw9goTTXL5tbiA6iw2+mIYapAUC+mAmQgNcKNO95GwuekWJzf8yDTgjZwZeQBG7oFFDsFdcBTIoGZFrvdj+UM65ArY9OodECbE7/ARDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/UNJed2QfRAIZcVCm5bPj4KB/a6VzzDwkvVOtAWouE=;
 b=dnTQbvE6m3CqMLwjqrLc9c4RsPZwAwaGDoy88ek0jG+k4Sukhem1fNWL5u8J0rH59ADZyEIf2AGvn0JyFmx6TQrq0vryh4RTdjn84YrrOPf1BLanDYyCAjuYBucwtJndANES/L9k4FP7nZSQYx19jOUcPHnqYZ2HlWEYMcevn9pCSxbnvRfKjnK5mbv0OZzjXEkQ8OL+qK3Fhr81G23aMRcaIgJaHU8A4QpWtJ5u65DlkG3A09h14cxpTwetGAqW1ie+xAqLtdx80Fnge0DywB/QEyrdXM9FZvCeQNpaVNj1xgtFyxFPntSnIDp/jS+AlFd1A67hPHfP2tPemqTxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/UNJed2QfRAIZcVCm5bPj4KB/a6VzzDwkvVOtAWouE=;
 b=bSMfVhd6V5CGP3ZE1HEFZbq/H9x8W2g5BTbfMB+0r3lGymNZpXKovcjFZoE9tjZGUoWlXD3g93xI6VJAPWGlAImSI/nqDTbSCy2i++6Oi9PbaN2G+yw7cl7L2xgnqlvQmLPRfPwqcjfBzFL+Zelx5Icdp0ljcNKKjMAT36oy9DYwcLy5Q7kMncABq1JzJmJUtJ8cVh5ui5qyj0UF2DM8lL/T/9Zt6JdA9zTyA6JDU56nm2l73SPds1sz1wfiAvgpWjWmasZAzvZpsEtfZf6LOFoYnslVpnqj41516U7DrOPj6pe3WI/XiPuO/Mt3wWEhHetTYXLir9ErBc8XTlNVSg==
Received: from MR1P264CA0184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:58::6) by
 PASP264MB5694.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:497::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.21; Mon, 12 Oct 2026 10:48:14 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58:cafe::26) by MR1P264CA0184.outlook.office365.com
 (2603:10a6:501:58::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 10:48:14 +0000
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
 via Frontend Transport; Mon, 12 Oct 2026 10:48:13 +0000
Received: from localhost.localdomain (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id AFC6C20061;
 Mon, 12 Oct 2026 12:48:13 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot@lists.u-boot-project.org, Yan WANG <yan.wang@softathome.com>
Subject: [PATCH 1/5] binman: Add PKCS#11 signing support to pkcs11_tool
Date: Mon, 12 Oct 2026 12:48:00 +0200
Message-ID: <20261012104805.17297-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012104805.17297-1-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PASP264MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d3d53f-fac8-4a2f-bd86-08df284e50eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|18002099003|22082099003|6133799003|8126099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: Z3BewsvOelSXq2AKeTMI9pLbLnMzLjs844AdYiC7t1IMdlOazPsVwarK1PIpeFf6dBciw2QYJUtOyD2qnCK0zKFs/QXpmsFS5yXxuD25EqRDGIDNGOv3P+jJmC3PrLMly54YS30BlV/vLzge1/SeQrQ7UeGz1cBJAzZoMNV995SGQb23KxgQStvzK87BCHkHpEryTVvypjyUaSkTP45RVhtQgAGKaqqouG5D0Zklo+QJW2vT1YR2Ioasezyc6IR4lEEAmzRrjsm7NpLihpwUQqqlPiDap7m7j3VSqVHecLSqRcjdsxqUCMOjGKVvG1oDONZi751J3hUFM3NirefGaUt72e/sHZB8s0RwESCjZyFTrqJ4SAFQ3VVY/bMTA77ux07O/6qAo555I3jyvg2Mmf6PDQZ0f4sJ7Z8J2a/sHHaTjmciny5llg9dZlRKXo9xwUUyzbMHmT96D7pUVwSFth06tpRZP57IyTmbiAwyXv6rw4LEIBEYh8I+LDgwarYVNAj02XdlUMD0O9io++Y+kLn0uHI/tSxrNMVY9oVuOy6ofl+VJJVLZcZGZbiZqQSayOW7uYPiCcYmnUH0lrUEP6DDhVn/lrcuMFgLJrgKGtpWCANFb3zgyIaK+Fd8RjbZGzV9P7u6OJ9exuLeMpczzl/KNSk4VZHfEK3B5zz2weFZPHcS80H4FjEYXTrenrUjGbXC7t08LUcfoSdhAC20WA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(6133799003)(8126099003)(261009223027099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oD2bRtTO7mW1rRERKTrmHu0ljiyYQx+/pRPRqd/V8qNzgQPz0PPfaMzkrq+dCa9mhq2uMJ56V58cvrlxT/jyYI0K9z4fG0h0/DQ+GJnAZLg0DqjO8Udkmvhg6RU1JsuU3SPvoHsK4NSEHdhdIH7wmjTW/nYoOcW1BlSFU+2BVAcmpI9uHTnL6EZekIcVYATo09Y3ZnJyFZ7eW9pF5lRTabcExluVEk6gmKgDnehRB0x/VWVMPQY6pb/Wam36H6Q/gsiZ6vNFlZm75rUPPLwyu98QoNQTjdVsSZRX3QaLsrFLd6bC1u306sLqffCdrVAwVaC98NvZjcIjsscdsMXuJrXKHK/bTO+HmnUTOOuvzH9e6p8j1hQ+qNvf/0cK3vb3GeK1zorWpYCRSwO8fDBQV5lwUi5dyLtu2jOUPA/iQSALHP9CIwmzOZtpEuiwcEoU
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:48:13.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d3d53f-fac8-4a2f-bd86-08df284e50eb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5694
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

Implement the sign() method in the pkcs11_tool btool to enable
HSM-based cryptographic signing using the PKCS#11 standard.
This provides the core PKCS#11 interface needed for secure signing
with hardware security modules in binman workflows.

Signed-off-by: Yan WANG <yan.wang@softathome.com>
---
 tools/binman/btool/pkcs11_tool.py | 275 ++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)

diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
index ca80943f98c..e380f585fc7 100644
--- a/tools/binman/btool/pkcs11_tool.py
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -3,7 +3,12 @@
 #
 """Bintool implementation for pkcs11-tool"""
 
+import os
+import re
+import tempfile
+
 from binman import bintool
+from u_boot_pylib import tools
 
 
 class Bintoolpkcs11_tool(bintool.Bintool):
@@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
                          'PKCS #11 tokens managing tool',
                          version_args='--show-info')
 
+    def _build_mechanism(self, hash_algo, sign_algo, padding):
+        """Build a PKCS#11 mechanism name from algorithm parameters.
+
+        Derives the mechanism name dynamically from the hash algorithm,
+        signing algorithm, and padding, supporting any PKCS#11-compatible
+        combination without a fixed lookup table.
+
+        The signing algorithm may include a key-size suffix (e.g. 'rsa2048',
+        'ec256') which is stripped; only the algorithm family is used.
+
+        Args:
+            hash_algo (str): Hash algorithm (e.g. 'sha256', 'sha384', 'sha512')
+            sign_algo (str): Signing algorithm (e.g. 'rsa2048', 'rsa4096',
+                'ec256', 'ecdsa384')
+            padding (str): Padding scheme ('pkcs1v15', 'pkcs-1.5', or 'pss')
+
+        Returns:
+            str: PKCS#11 mechanism name (e.g. 'SHA256-RSA-PKCS')
+
+        Raises:
+            ValueError: If the algorithm family cannot be mapped to a mechanism
+        """
+        hash_upper = hash_algo.upper()
+
+        # Strip trailing digits to extract the algorithm family:
+        # 'rsa2048' -> 'RSA', 'ec256' -> 'EC', 'ecdsa384' -> 'ECDSA'
+        m = re.match(r'([a-zA-Z]+)', sign_algo)
+        if not m:
+            raise ValueError(f"Cannot parse signing algorithm: {sign_algo!r}")
+        algo_family = m.group(1).upper()
+
+        # Normalize padding aliases
+        pad = padding.lower()
+        if pad == 'pkcs-1.5':
+            pad = 'pkcs1v15'
+
+        if algo_family == 'RSA':
+            if pad == 'pss':
+                return f'{hash_upper}-RSA-PKCS-PSS'
+            else:
+                return f'{hash_upper}-RSA-PKCS'
+        elif algo_family in ('EC', 'ECDSA'):
+            return f'ECDSA-{hash_upper}'
+        else:
+            raise ValueError(
+                f"Unsupported signing algorithm: {sign_algo!r}"
+            )
+
+    def _verify_mechanism(self, mechanism, module, slot_index=None,
+                          token_label=None):
+        """Verify a mechanism against the token's allowed mechanisms list.
+
+        Calls pkcs11-tool --list-mechanisms to retrieve the set of mechanisms
+        supported by the token and raises an error if the requested mechanism
+        is absent. Verification is silently skipped when the list cannot be
+        retrieved (tool unavailable, non-zero exit, or unparseable output).
+
+        Args:
+            mechanism (str): PKCS#11 mechanism name to verify
+                (e.g. 'SHA256-RSA-PKCS')
+            module (str): Path to PKCS#11 library (.so file)
+            slot_index (str): Slot index to target (optional)
+            token_label (str): Token label (optional, used when no slot_index)
+
+        Raises:
+            ValueError: If mechanism is not in the token's allowed mechanisms
+        """
+        args = ['--list-mechanisms', '--module', module]
+        if slot_index is not None:
+            args += ['--slot-index', slot_index]
+        elif token_label:
+            args += ['--token-label', token_label]
+
+        result = self.run_cmd_result(*args, raise_on_error=False)
+        if result is None or result.return_code != 0:
+            return  # Cannot verify; proceed and let pkcs11-tool report errors
+
+        stdout = (result.stdout.decode('utf-8', errors='replace')
+                  if isinstance(result.stdout, bytes) else result.stdout)
+
+        # Parse mechanism names from lines like:
+        #   SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify
+        # Only accept names that match the PKCS#11 identifier format
+        # (uppercase alphanumeric with dashes, e.g. SHA256-RSA-PKCS).
+        allowed = []
+        for line in stdout.splitlines():
+            line = line.strip()
+            if not line or line.startswith(('Using ', 'Supported ', 'Mechanism')):
+                continue
+            mech_name = line.split(',')[0].strip()
+            if re.match(r'^[A-Z][A-Z0-9-]+$', mech_name):
+                allowed.append(mech_name)
+
+        if allowed and mechanism not in allowed:
+            raise ValueError(
+                f"Mechanism '{mechanism}' is not in the token's allowed "
+                f"mechanisms.\nAllowed: {', '.join(sorted(allowed))}"
+            )
+
+    def find_slot_by_serial(self, module, serial):
+        """Find slot index by token serial number.
+
+        Args:
+            module: Path to PKCS#11 library
+            serial: Token serial number to find
+
+        Returns:
+            Slot index as string, or None if not found
+        """
+        args = ['--module', module, '--list-slots']
+        result = self.run_cmd(*args)
+
+        # Parse output line by line to find matching serial
+        lines = result.stdout.split('\n')
+        current_slot = None
+
+        for line in lines:
+            # Track current slot number
+            slot_match = re.search(r'Slot (\d+)', line)
+            if slot_match:
+                current_slot = slot_match.group(1)
+
+            # Check for serial number match
+            if 'token serial num' in line.lower():
+                serial_match = re.search(r'token serial num\s*:\s*(\S+)', line,
+                                         re.IGNORECASE)
+                if serial_match and serial_match.group(1) == serial:
+                    return current_slot
+
+        return None
+
+    def sign(self, data, module, token_label=None, token_serial=None,
+             slot_index=None, key_label=None, key_id=None, pin=None,
+             hash_algo='sha256', sign_algo='rsa2048', padding='pkcs1v15'):
+        """Sign data using PKCS#11 HSM
+
+        This method signs data using a private key stored in a PKCS#11 token
+        (HSM, smart card, or software token like SoftHSM). The data is hashed
+        and signed by the HSM using the specified mechanism.
+
+        The mechanism name is derived dynamically from the algorithm parameters
+        and validated against the token's allowed mechanisms list before
+        signing.
+
+        Args:
+            data (bytes): Data to sign (will be hashed and signed by the HSM)
+            module (str): Path to PKCS#11 library (.so file)
+            token_label (str): Token label (alternative to token_serial)
+            token_serial (str): Token serial number (alternative to token_label)
+            key_label (str): Private key label (alternative to key_id)
+            key_id (str): Private key ID (alternative to key_label)
+            pin (str): PIN/password to unlock the token
+            hash_algo (str): Hash algorithm ('sha256', 'sha384', 'sha512', …)
+                Default: 'sha256'
+            sign_algo (str): Signature algorithm with optional key size
+                (e.g. 'rsa2048', 'rsa4096', 'ec256')
+                Default: 'rsa2048'
+            padding (str): Padding scheme ('pkcs1v15', 'pkcs-1.5', or 'pss')
+                Default: 'pkcs1v15'
+
+        Returns:
+            bytes: Signature bytes
+
+        Raises:
+            ValueError: If mechanism is unsupported, parameters are invalid,
+                or the mechanism is not in the token's allowed list
+            RuntimeError: If signing operation fails
+        """
+        # Build mechanism name dynamically from algorithm parameters
+        mechanism = self._build_mechanism(hash_algo, sign_algo, padding)
+
+        # Validate token identification
+        if not token_label and not token_serial and not slot_index:
+            raise ValueError(
+                "Must specify either token_label or token_serial or slot_index"
+            )
+
+        # Validate key identification
+        if not key_label and not key_id:
+            raise ValueError(
+                "Must specify either key_label or key_id"
+            )
+
+        # Validate module path
+        if not module:
+            raise ValueError("PKCS#11 module path is required")
+
+        if not os.path.exists(module):
+            raise ValueError(f"PKCS#11 module not found: {module}")
+
+        # Resolve slot from serial number if needed (done early so that
+        # mechanism verification targets the correct token)
+        resolved_slot = slot_index
+        if not slot_index and token_serial:
+            slot_idx = self.find_slot_by_serial(module, token_serial)
+            if slot_idx:
+                resolved_slot = slot_idx
+            else:
+                raise ValueError(
+                    f"Token with serial {token_serial} not found"
+                )
+
+        # Verify mechanism is in the token's allowed mechanisms list
+        self._verify_mechanism(
+            mechanism, module,
+            slot_index=resolved_slot,
+            token_label=token_label if not resolved_slot else None,
+        )
+
+        # Write data to temporary file (pkcs11-tool requires file input)
+        input_fd, input_file = tempfile.mkstemp(suffix='.bin',
+                                                prefix='binman_sign_')
+        try:
+            os.write(input_fd, data)
+            os.close(input_fd)
+
+            # Build pkcs11-tool command
+            args = [
+                '--sign',
+                '--mechanism', mechanism,
+                '--module', module,
+                '--input-file', input_file,
+            ]
+
+            # Add token identification
+            if resolved_slot:
+                args += ['--slot-index', resolved_slot]
+            elif token_label:
+                args += ['--token-label', token_label]
+
+            # Add key identification
+            if key_label:
+                args += ['--label', key_label]
+            elif key_id:
+                args += ['--id', key_id]
+
+            # Add PIN and login
+            if pin:
+                args += ['--pin', pin]
+            args += ['--login']
+
+            # Execute signing (signature goes to stdout in binary format)
+            result = self.run_cmd_result(*args, binary=True,
+                                        raise_on_error=False)
+
+            if result is None:
+                raise RuntimeError(
+                    "pkcs11-tool not available. Install the 'opensc' package"
+                )
+
+            if result.return_code != 0:
+                stderr = (result.stderr.decode('utf-8', errors='replace')
+                          if result.stderr else '')
+                raise RuntimeError(
+                    f"pkcs11-tool signing failed "
+                    f"(exit code {result.return_code}):\n{stderr}"
+                )
+
+            if not result.stdout:
+                raise RuntimeError("pkcs11-tool produced no signature output")
+
+            return result.stdout
+
+        finally:
+            # Clean up temporary file
+            try:
+                os.unlink(input_file)
+            except OSError:
+                pass
+
     def fetch(self, method):
         """Install opensc via APT """
         if method != bintool.FETCH_BIN:
-- 
2.43.0

