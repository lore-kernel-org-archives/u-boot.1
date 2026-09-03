Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89668C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE52B80841;
	Thu,  3 Sep 2026 08:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJKNwy9nRKcx; Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7F0258081C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423444;
	b=T1/quSIOCxy/+e2mlPeR3W1zRizTeHKaZ0yI1Q5ieFIfHHWblYlHZSDzE6lgHhtDbeVS
	 OH2NWRPHcFQfBa4WNnYrbHb4BPKy96M4CSjxuC+Is5XIe2KaiA8dweMAFOISD/OeGxe3n
	 6dzLxNZP1mM8j0csshGq+fFYpGVwk8ZcuIceRPudMCtRKZHDZU2jfhUvUP2i2hG3iZ8sf
	 fXVk38Tx683bT5F72hmAZf+am5+lX7jEzezTv/T5hRw9naRqJQXwszP3KQDEHkiyFE/bT
	 lv0MNuaoe2TOtMBBs+AtKsNxanDwPhZsL05wFxsd96g1COGiEtrqpeUL5OzqkGN/N0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423444;
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
	bh=Qti2fm/0fGHRxaIIiqPQb3AoKcid58/6ZudZVmuAXdM=;
	b=n+uqE8uGYDWkGcZ9pQznKNUJeh2qrDKdwSmDjZtRvnsWEp+a6aWYO/XRQAHy8/BNAbcV
	 t0ZwgWDgajdcn1NhTkULuxmAprBxnYk9PW48peqXQoGHeqBshHfvYe2OxNPxuv0bfSpzD
	 pgQm+5heEdcyunGOqUbWGdFJbilyjwEAqOnil8Cj7xj/kpOrgTvuV2IGyQrxVdhTVkQiZ
	 euH5W0H64/7276ugqFQ+ApZHIkFlmpuhgbjP7ideKhK6AWn8z/hh4XZclcW7YGxdvaAZn
	 q2wCHDpgnAyAZbJCEKh7TxfINmspgJKA8stpIONTQe6aG4e5leZ2WO/cMUXgk/lQ4zw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423444;
	bh=Qti2fm/0fGHRxaIIiqPQb3AoKcid58/6ZudZVmuAXdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGwW6giEwUwlvY0Mvh0ko2bfNacHKxAKj/yTRQoLNaTyJu9YYu/9Bg99eRBD68n45
	 IguGFa37VvT9tKkoOgFbcjvEk32K4xxwvT2UZI71CzUT5HV994WenaZfc6NUTGOqdd
	 Ogtg4nYfqdcN8zfbzvb3xAuIVCn/YwMp7eVgJGlAz3rikQjIgKKHvA7dRKz+g5m7N4
	 qsicxcL01mAB/66ZW8+ez8ETXkFg5gJDv6UkcO2Uti9nJTbAQ9BzoML41SRnyr2aTg
	 rQ955N5IBedptz2TGLPDhYq3F53S2uCiGWceiwmtsmJW1FsQsiUpQ0S9rAUSRXNxc7
	 XYSMVdlUBaWYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F0258081C;
	Thu,  3 Sep 2026 08:17:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B64252FD
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A890D403C7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wfEPkooLBMae for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 458F34002B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423441;
 b=O+eJ7cZ/pRsyrV8/IA2jzeMyrgUfJsaK079FP1UeMWeRBGI6ep1sDNg6yrQQ9tKfHPWS
 k1JLfbuT+fRe6GI09PfC3l/Qbn9BiV2gbWm6ngD0R/Gn6Q245DiNJt5PB9EIwEJYA6JL2
 vqkhk7xWUnlD8bahsNiRVARW5b9nS66lwKyC5eLlsKpBQf7YjImGY7Koa6YAma0jribgJ
 raysimfs3aNg4EwDB1/d/8atAbzByyH1uLq00rXK2+nMTPSMG8du8bPqKwVXfIm/njHKe
 mf26nlGohghlcucjj+S1gMdVOr3mXbFpjmUxpq+OZnNqFZW5iMTqh/godBZC33iwrFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423441;
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
 bh=Qti2fm/0fGHRxaIIiqPQb3AoKcid58/6ZudZVmuAXdM=;
 b=a1wu0CDZzZSzP/9NZqo8asVcj6LFyCELF76pl9s+ntvU1KaUk1yei6sL8rdKlwz0+Ctu
 ybAFxDDWe8PaJH9tpx9Q2KLhXPr9q1iiNXw4dj2KSKRYLF2kFLYrJOP9F8GakszBO/lQL
 +cbh7tAZ0g/DCqlENFMXCcdGGgpgmZM1AZyr2vQu8gvz4rQ4zNtvb5Uf6nIa8irld3Q2f
 /QZzwcTXX7NgtOQ25k8Y1+S2aj9MZq9EF/+SGp5xvM9vaoyeZ4wgzPeheJ0zZJKSUtYu0
 WIRSAOEQM4z8N1UJDgpRLKHlXgq9uaVo6D3BIiJQrYivuRWCbN6ff+baHHPhfdmZETA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=f+32UcTp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=f+32UcTp
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 458F34002B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFzu++RqtldGVuyGLCEoJl2oCLGahk0JpxfeOo1KhK+zNbq2eLrIW6rap5PfznZtnctqzI6wERkjecBz9d7saMErMLZ29TRfYkPGafNZB0ZCkHDZ0TITGl0X9+CwbC9T5dO8l1WMKFORt3VqhVVXWexdMe4jTINev+XzD2Q2eYXpElVNW9nFcgMnBHmid/f1ELpI7v0EODid4s2bo8jA33fWSptWtMw8EDBG3n51mhq0S2CMaZ4pqiIIJQsC/K22Tc1qE6tpPF7iWXlQskzZKWHrv8WiMcT0gz8C89FlTxucNtRHClGC+lN0Z8Ka7pdhq4YN/zAXUUC3Rft4txhhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qti2fm/0fGHRxaIIiqPQb3AoKcid58/6ZudZVmuAXdM=;
 b=i8mtoJZdEzhEebOqj7wgDA+pOo+BbOnRTA4Eu9E9+CjQOLawA48UCqGzNAFSJYK5fseI8ETfqn4/ZwARoK+98/qx4bioaXqMYPNfoIt2NHvWJK8ppynubK/neC18PM+70TQ+84P+l3B7bEcla8Dz5tME21hk8wGaMjFOCb37HvvGgpHwg0kpeD6oDduVSq6cft/K1PC0DkMDgVTsVwYpeZOCcj2WOmmDd78D5+rtlwdTBj1WD6x+1/jrwvXbFw/PnLOQAOI0bWfkkOhITIfGnzIhvo5C0gPpZnqrHBLwzbm8MbBEf2cdSWohazeW8o+0Dxfl7supNc8453CPZgO9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qti2fm/0fGHRxaIIiqPQb3AoKcid58/6ZudZVmuAXdM=;
 b=f+32UcTpY2iijx1rMyveFStRJXaBqbfKDS1itYrfkI0vFbkc+/x0K93ECimPg67f249OR0aPSQ3J7tshNEYp+xvmgIAvbn74/gi74F/iIiA+1ZPBqvJ661TftHHr/7N5i7HkjAc4g9ohoPWBkD1TZjK5eaDYzoELQ4/TteyiFqVbEu5idfPBhxyIBuGeD2uRHO3sg+LIEurr+H+ybQBIaGin5zgg8vO19cxtYezoMXCOP7FYaXYtypcNlHJFSv64OQlfcNO060mIwTSLBumYoimwXrjN2iTAOAIN4RSuD/mLoc55pJ/WbHQCdr8fE6NTPX6JxWFJqnxGm5jSH2KVCg==
Received: from PR3P191CA0033.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::8) by
 MRZP264MB2184.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 08:17:16 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:55:cafe::10) by PR3P191CA0033.outlook.office365.com
 (2603:10a6:102:55::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 33CAA2010C;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v9 01/15] ecdsa: fix support of secp521r1
Date: Thu,  3 Sep 2026 10:16:51 +0200
Message-ID: <20260903081705.12894-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|MRZP264MB2184:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 71c84660-27b1-42b2-f33a-08df0993c40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Wr3fXvo01dOMh2hSSgOWwZN/I4hk+SmexJXs5HpzA7ZgJokji4twSA48YRX3iV5rm/tZlUy/yYstGV57sFP1I7X/mzwB5LXhqHY9xn4xATa0vb00E6mYQ7EFakU6tQ2Kr4pQCYrs2zln03bXZDg+z2fGNk7ntO+7kwMDP2QmHQiRkziw6QG8UA7iv8yhaw4TEpGCMzkEOV2xk7XO7vC/dAtQkFjjjn/4sCICqtqC1LYI+j7xu8i0INsIm4faS4OclDcgcLXque0nKlaf+BlPRcCl15co3Lx9uO4OzNZPqXSt2Fp0+e2fvRfgrAqNQNNUfboNNCrqGgBfNZRpJyNz/Id4kiamM1/+roharIRModmq+ieeODicD8As9zpgou0HI8j3ZPNv80+RBVbg12uYqy31nK8500PyGmtFjNo5LJzzRNCjCukMLvKmVE/EasOT0pr8M5SDzUTHh926aDfXMXgc20YaUK3kqhUO5XxunHdD1IAJtEYKQ75rX6bLbxiCQJfXTfxvFTlqAU3KrcOp486yKBra0zv2YqrrrKJJPkkkcgyMFf4rWFEy58XN9qaLsmLWKp4uVCPBfxPocovW7V1nYTppDUQCKyY8ItRi6p7SJ1dy13Uz1TH0A17WaXXKqVm80lnfIXHr87yhWGBSH29sp0uv8hF5S7U/W2PXeFlX0oIk8MvR9LzIqlRMSFN2Zy8p6VY/2KiuCTM/Q1BXOQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vHppcxgFvYlgqCPiVU5uG+9A0A1iZdKzQIaCNNZ3JpeN+VwuFu0nFBIEbKehX0nLF7ZWJ+AQuM0+R6wKjI38vit+ew9orb3euwWv2P8ZSSk2X1Pr+CGDv/aL/all5Eu9weAmRf5sUNckC+kic15OlN33lF699jwMYOPDysMz+t1fpsbxJSsS7TVyfVItcx3GUzzkEj7ci8wAwgAEo0u12kKqAn/+no5sBd+GF8Qho0pLGNni0Ubf1zjWhH4gcHghyHl+TaGVZlHyl3QZA8UsURyNs3hzmzXK/RIm/YQV9p/+rUUMEbv1Xl7encYrPdvikU/0bATHcDNkpeAzdQnYzkTcy1Xmlv3tPzHlH73CB7dkpPMQu7MnORv1UwP7t0946MzcKOZm+KqX7whTQ+KXDnCmTsIIVoOWMbIiQsVOsrrYY/ScgbhXyfTOAffvWRRw
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:16.3586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c84660-27b1-42b2-f33a-08df0993c40e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2184
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

Current implementation of ecdsa only supports key len aligned on
8 bits. But the curve secp521r1 uses a key of 521 bits which is not
aligned on 8 bits. In this commit, we update the keys management
for ecdsa to support keys that are not aligned on 8 bits.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- intitial version
v3:
- fix typo in comments
v4:
- fix commit message
- clean code with DIV_ROUND_UP-
- duplicate data before shifting
- support ecdsa521 and secp521r1
- clean code
v5:
- check that x and y are not null before using them
- free keys when keys not found
-v6:
- free x and y if x and y are not null
- do not free key when an error has occured
v7:
- no change
v8:
- check the exact size read in the dtb instead of doing a simple
  test on the expected size
- change memdup api to use the same as in the header include/linux/string.h
- code cleanup
v9:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 75 ++++++++++++++++++++++++++++++++++++-
 lib/ecdsa/ecdsa-verify.c    | 71 +++++++++++++++++++++++++++++++++--
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  7 ++++
 4 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..b3fc75fac48 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -26,6 +26,8 @@
 #include <openssl/ec.h>
 #include <openssl/bn.h>
 
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
+
 /* Image signing context for openssl-libcrypto */
 struct signer {
 	EVP_PKEY *evp_key;	/* Pointer to EVP_PKEY object */
@@ -41,10 +43,36 @@ struct ecdsa_public_key {
 	int size_bits;
 };
 
+/*
+ * This function returns a valid pointer so
+ * the caller must then free this pointer.
+ */
+static char *memdup(const void *src, size_t len)
+{
+	char *p;
+
+	p = malloc(len);
+	if (!p)
+		return NULL;
+
+	memcpy(p, src, len);
+
+	return p;
+}
+
+/*
+ * This function fills keys with valid pointers (x and y) so
+ * the caller must then free those pointers with fdt_free_key().
+ */
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
+	const char *x;
+	const char *y;
 	int x_len;
 	int y_len;
+	int expected_len;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name)
@@ -54,6 +82,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		key->size_bits = 256;
 	else if (!strcmp(key->curve_name, "secp384r1"))
 		key->size_bits = 384;
+	else if (!strcmp(key->curve_name, "secp521r1"))
+		key->size_bits = 521;
 	else
 		return -EINVAL;
 
@@ -63,12 +93,45 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	if (x_len < expected_len || y_len < expected_len)
 		return -EINVAL;
 
+	x = memdup(key->x + (x_len - expected_len), expected_len);
+	if (!x) {
+		fprintf(stderr, "Cannot allocate memory for point X");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup(key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		fprintf(stderr, "Cannot allocate memory for point Y");
+		free((char *)x);
+		return -ENOMEM;
+	}
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 {
 	struct ecdsa_public_key pubkey;
@@ -89,8 +152,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		nid = NID_X9_62_prime256v1;
 	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
 		nid = NID_secp384r1;
+	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
+		nid = NID_secp521r1;
 	} else {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -100,6 +166,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	ec_key = EC_KEY_new_by_curve_name(nid);
 	if (!ec_key) {
 		fprintf(stderr, "Failed to allocate EC_KEY for curve %s\n", pubkey.curve_name);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
@@ -108,10 +175,11 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 	if (!point) {
 		fprintf(stderr, "Failed to allocate EC_POINT\n");
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = DIV_ROUND_UP(pubkey.size_bits, 8);
 
 	uint8_t buf[1 + len * 2];
 
@@ -123,6 +191,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to convert (x,y) point to EC_POINT\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
@@ -130,11 +199,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		fprintf(stderr, "Failed to set EC_POINT as public key\n");
 		EC_POINT_free(point);
 		EC_KEY_free(ec_key);
+		fdt_free_key(&pubkey);
 		return -EINVAL;
 	}
 
 	fprintf(stderr, "Successfully loaded ECDSA key from FDT node %d\n", node);
 	EC_POINT_free(point);
+	fdt_free_key(&pubkey);
 	ctx->ecdsa_key = ec_key;
 
 	return 0;
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..494b60b4ab0 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -10,6 +10,7 @@
 
 #include <crypto/ecdsa-uclass.h>
 #include <dm/uclass.h>
+#include <malloc.h>
 #include <u-boot/ecdsa.h>
 
 /*
@@ -24,13 +25,23 @@ static int ecdsa_key_size(const char *curve_name)
 		return 256;
 	else if (!strcmp(curve_name, "secp384r1"))
 		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
 
 	return 0;
 }
 
+/*
+ * This function fills keys with valid pointers (x and y) so
+ * the caller must then free those pointers with fdt_free_key().
+ */
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
-	int x_len, y_len;
+	int expected_read, expected_len, x_len, y_len;
+	const char *x;
+	const char *y;
+
+	memset(key, 0, sizeof(*key));
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name) {
@@ -50,15 +61,50 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	expected_read = DIV_ROUND_UP(key->size_bits, 32) * 4;
+	if (x_len != expected_read || y_len != expected_read) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
 	}
 
+	/*
+	 * The public key is stored as an array of u32, so if the key size is
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = DIV_ROUND_UP(key->size_bits, 8);
+
+	x = memdup(key->x + (x_len - expected_len), expected_len);
+	if (!x) {
+		debug("Cannot allocate memory for point X\n");
+		return -ENOMEM;
+	}
+	key->x = (const uint8_t *)x;
+
+	y = memdup(key->y + (y_len - expected_len), expected_len);
+	if (!y) {
+		debug("Cannot allocate memory for point Y\n");
+		free((char *)x);
+		key->x = NULL;
+		return -ENOMEM;
+	}
+	key->y = (const uint8_t *)y;
+
 	return 0;
 }
 
+static void fdt_free_key(struct ecdsa_public_key *key)
+{
+	if (!key)
+		return;
+	if (key->x)
+		free((char *)key->x);
+	if (key->y)
+		free((char *)key->y);
+}
+
 static int ecdsa_verify_hash(struct udevice *dev,
 			     const struct image_sign_info *info,
 			     const void *hash, const void *sig, uint sig_len)
@@ -76,8 +122,11 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		if (ret < 0)
 			return ret;
 
-		return ops->verify(dev, &key, hash, algo->checksum_len,
-				   sig, sig_len);
+		ret = ops->verify(dev, &key, hash, algo->checksum_len,
+				  sig, sig_len);
+		fdt_free_key(&key);
+
+		return ret;
 	}
 
 	sig_node = fdt_subnode_offset(info->fdt_blob, 0, FIT_SIG_NODENAME);
@@ -93,6 +142,8 @@ static int ecdsa_verify_hash(struct udevice *dev,
 		ret = ops->verify(dev, &key, hash, algo->checksum_len,
 				  sig, sig_len);
 
+		fdt_free_key(&key);
+
 		/* On success, don't worry about remaining keys */
 		if (!ret)
 			return 0;
@@ -135,6 +186,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa521) = {
+	.name = "ecdsa521",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
+U_BOOT_CRYPTO_ALGO(secp521r1) = {
+	.name = "secp521r1",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..090246b44e9 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -10,7 +10,7 @@
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
 		   BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
+	int nwords = (num_bits + 31) / 32;
 	int size;
 	uint32_t *buf, *ptr;
 	BIGNUM *tmp, *big2, *big32, *big2_32;
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..285547994ca 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -83,6 +83,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = ecdsa_add_verify_data,
 		.verify = ecdsa_verify,
 	},
+	{
+		.name = "ecdsa521",
+		.key_len = ECDSA521_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 	{
 		.name = "secp521r1",
 		.key_len = ECDSA521_BYTES,
-- 
2.43.0

