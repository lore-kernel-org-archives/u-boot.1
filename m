Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA5606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yP0s7lWt;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=WZVVyk8o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D717F606E9;
	Tue,  3 Nov 2026 02:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZIuknvHwY9e; Tue,  3 Nov 2026 02:18:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1593A6070C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793672303;
	b=j8NfkMz2/LQGvRcWl/1wCkBF4bl647oxiR4Q+w52+vcHZzwAS3AvBMYE470t/0PVHfis
	 zqSChnyRFnFNQ7jUxruBZhA1O+UuCwzYPmvOU8o4r1qfleibNmFGFuz5ZKydVJKcRAC5T
	 IPx9WDH0JUP/07PipTg8PVure8sw/KvqM3L+SkG12nq/9713PIGq2MufUWYotJqb3t1tr
	 jmbC9xbTVm7997JbJdH3ZzqoA1rHxsA5SILMu7hMGt2CiP3Oeb0in5VKK3ow2dsCMUeVN
	 e5uNkNmSBaSlQX9ORuDemiHlGbaf/u0fP/yPVvesfNFt/F0Ej6G9JwIZ84tk52O9mWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793672303;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
	b=UJUru2oAUq1GbSmm54gaUxUVEQhG3pR2wwsWG6H9Kz43f/DvthPuGInqhlPmFZHUy956
	 mVbxCasQzsMEOL+amT9EHP/v5BskipFXUpOD3BvhJYCy1iRsiQzMymLpjDP+G5TqCH5bU
	 00cd8nPCiwPUBwQvYXOrAkcM5N9d5zq0bX1aQ6ESGIRQbn6rwxulGX6PLH41hybCRJODp
	 vLsVISIR0QIYBNF23aWHAukNBHyQ1AF/YD9gLG3LwyhJ7U5RcRmuki6sWpFmRojkJEvzS
	 Z0qp+UQuhflUTlf6xT/EBhsnmNTKw4/S3OlCf3+dANVbQfPAThgIfauonpWmayuSc0Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793672303;
	bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yP0s7lWtGVZMQUovOd8aQYptQhGvjSkdBSDt/KtXTR5aglzILsn+V/x1Djn9xxPzk
	 zMoPxlKJVGygk8OQdK/Hg5crsMeu5yJeqsnaAWTiR5bb2gjTZI6rc9VVFiuW/STX2Z
	 Kub1y/a+SgRy0Q7EXG4ZR987EX3vvidsivl3/FznKSKc29aNnWYuI2z8L88ZE/uK4u
	 AYzc3+/31ZXR4A9srwruaOjSsCv8VDAKmMDfaMusTdr5xxMDECvbG+42rot6XO9pEr
	 NZkz2zsJpRLdmA89Z2VdANh6+4gelrTKjaT7em3nRxpI8r344/9pyeIbDmT/LvAI2X
	 hAyIyVSW7NQYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1593A6070C;
	Tue,  3 Nov 2026 02:18:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8995DB00
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F5D84055A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zgt5vwY3fb3 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 02:18:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DCE04055C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793672300;
 b=Sm+H4PtUIsxARW9zl5z0+S+fUEJzcfj0uK/76UU9UoJrQkfKhJej6I725xrkMIos244U
 oxNHr7jBTfjQI3cD35Qz8DZfHLi8q3bcPo1w16osNxeG2I9hb1d7cFOkDo5+PO/buoeWO
 r4lXE7D7FdF4rxULUkY/eCMWdFMgfbgyNA5RYBIExEMT5tR2e0p+cd9KDajLXBriJ+MX7
 8UFch0OwVrIAaEfGFgCBk3dA7TdCEiq6BgIpji7G0/qkYlTHbCOOyeikq1AhFgKDQIiAA
 B9vjcNn+PE1j7a5VqgDh8dpYfsdTTZXrKHwPsk2D6JPhkp3f8ntt3d82P6mBqo6MTjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793672300;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
 b=FuLl+dOoxu3w+PdjheOdWVTk+INa++zeCb/YOUC/zqBKv7GndW2GCwtLGo56/ToJWdsT
 BLwr0vjw2GGFzcmd8WsitW4L9zkfc7BXTQWsux6l2zf/Isf64Bbb5Zyi4w12MYNup4uX6
 EJBfYHZIqmdqpiAFl7uaw5ixtpAT+daDaWYhfvHinOQ1+pVrzb8yqFvFDRG/3+sAri4o7
 QREx3FHNrV6qf6zUZyWar95l+ZYRFB8mS3WyHYeQQh9NRQjwOVQfHdBEsFrjHOidjaRqp
 FIQkoBoCinTUbzJfofEH5NVtmCLWoCYwpOquH6H2tRJmxPo/0/jhIhDO8hbvF/FDZxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=WZVVyk8o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=WZVVyk8o
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DCE04055C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 02:18:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77011840D8; Tue,  3 Nov 2026 03:18:16 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B8A83E76
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 03:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2cSNPS1fTUGePcqtiCE76Rxn63MiNMTCfUnwl+6fUo3oWR/vouEYTZfkOQGN46MKxmYbjUD9VjLzVs/BMpdYwJVw5p/3HeTj7IejkugT5rrVLT82cLMM9hLCAb02gq/TWs72LCWp4SjKEq9reFQOLmT8wt8OCqoL0haYtrYkp5O7Eh4sK/Twu0oqkrdQeOOVT8JyIeHsV19vUEJokuf4CpWO+icIFhuivXDv2GP3WoUWdByRSW+0JrdQHVtq91clbKPuEEhd4AiAlj6dYmAdS6EJcKjYnYALKzTVmACFsGa00qLZGd61THfPaWCcNylT5hspVjPnZ14TOtTu7NiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
 b=JQHUM3npWnJ1QBUzkS29autCXMn0yyYEufRaVZ2EnCjfizLdAr5/cxReOd2tjYk/h0X3ZyqWAhemxQJyemqH1f8joDTaXjBY3ypo5l1EMVP70rIIeYwfO419R5vcHXMkkEO7Wc/74EvvyaLjhKpX54/0p0UYod221u3CidyZvg9ThEqLIbx/3MopvdQSX9UrpGaoWD53R1kE9QsImrmFzYCcH4LjBEQHLJzl0AF/8TgFd8UKtXaAGRaDijLIHIpGWgbR6d8AcqOA247FW479hZu4Ma0bzdW2YCAk00kmBR3PcWwmki8adUOXykr/G4Y4o2XG7bzq9JL0AOwTPmoiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
 b=WZVVyk8ouWu9n/65eA242z9E23vwcZ/Af9wJQm5txZlMOWWzhYBQeKD+r98uJ9rnNSTQT5JVlUDO4zy+dXjB0pZpstdAYJRsONMQq3otIhW7RQp3eWFSi608g7HTxVAs/CbOXmud65hvOilQYFOLIzQtWZNChMPrGMU5thTv34i65ipJQ8m5X09OCK9zSL/IyglGmryMnH1dSCUHDr0OIrvSNRpnWBPFSvjxZzOP4qbPlye+QYjelyPF85IKk0wATmzBlgLFayAo/OHYthwj7xtttAJwXWVbTsyR2zy1dn1wy5TeiWx6hfYY2U18MAO+7qJDDo4uhn37kXkQNj8X5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DSVPR03MB989637.namprd03.prod.outlook.com (2603:10b6:8:41f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:18:01 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:18:01 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 1/2] i3c: dw: validate device index and clear slot on detach
Date: Tue,  3 Nov 2026 10:17:42 +0800
Message-ID: <20261103021743.27111-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
References: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0266.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::31) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DSVPR03MB989637:EE_
X-MS-Office365-Filtering-Correlation-Id: 284dba7f-9e01-4020-affc-08df3950af52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|22082099003|261102123227099003|55112099003|18002099003|56012099006|11063799006|261026140227099003|261022105027099003|261021121427099003|261009221227099003|261021123027099003|261009223327099003|261009220027099003|261009221727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: MJ/EolO3lPD8FFO0U+GcIOseLhjd8S8XICbaQ8VCSPR8rLgpdD6Grr73Dv/KLk1ksbSF5zZ3w+gJWdY91WYjLEGUvlpD4sKXV/wfjIFdBFq9awY2810Yw5sxcKZc1tjm3P64xVbw7s1VMMr5bpuvpTUtGtspXOxlNBmiM/3yBJVHrjDTYb9n0yvoY+Cqu256lp2+Qhenlz1hUz98kPXbQK7hxApWFXu2y3cwj0qelLmLk6u70Ia2GWnvs+sz4qcLqm2aQ1CJEjthWhCVDGlfdUAl+uzULkfV0OUYXgn8otD3LyOKC0TSKSwlEkCtb5RLYHRR52YHTPO8I7s7gRPyWHI+anWDPFYSQ6/dml4eLwcs2KmwGm05sGpWbe53zxRggPDBLNRusC9IlwGCYW0GtcLNjOAXwarUvDxZop3rPYiudJLEiUTwgBCKCpNfdR5K6MbDkCGKLWs76AvSnhDdQJMfuc1WxcFynpmiUdeCZZBOgPR+AuXCkvzINIciBG6hDk9s0c4Emsr5hIYCX3AzTV8z9DVgC1Plki1LLpwEo3/03EzIp+/iIMyNR4CbCVcgv2riAIcuKzo/mwAvPZE63lGByUa2rZqr2pV5sEChqdc7CklyA5A8smBD0iOjudBZnPorpL2RIe2u/GR8pOaXjiGmAHgpoVyleDeCZdSh+Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(261102123227099003)(55112099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261009223327099003)(261009220027099003)(261009221727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2D05UCFp5YOREgN8Qe9uNP+P30S4+dw18efG2/6lEWD8qdNgRmdsBBcsbhz1?=
 =?us-ascii?Q?NXv5Ley64ZWeXnnvRiepwdbhInJtdDgW2H9gonZuWj6GX9F7j3UBseNYgT3W?=
 =?us-ascii?Q?LLyASSdXx8ONd/u51FXdLb7nxr6/ZiBclQr4ZcW4Thsb0gv2SMGLbnkwXIhq?=
 =?us-ascii?Q?sVAMmlTJq8GEuMiNKXx/AJjTMAirVZfUSi/xv+0t2twpFhNIY+/b+frxMG42?=
 =?us-ascii?Q?uVAK+9+gCyo1AoZCBFQRIt8b68gl/+6zZSs2Xob6Ihz87BOwOs6+UlNCZ+Br?=
 =?us-ascii?Q?tJnlV1qAEVUmzweKwmOBMuCibPzogpeQpwhi9bs4Zov0wDiJ40ZiTA7oxFfj?=
 =?us-ascii?Q?NpwtCajgHcxKUc6yuZz/MTFaDYTPh/4ejMReAQc+pi+4NKMdXA5EL7HAFRZ0?=
 =?us-ascii?Q?LzD2SNVjiaQBdOLN1Q49m1Pitd62fa8hafwh57LIku+m2g4CW9OsiSwNK+Gk?=
 =?us-ascii?Q?UeW8SagOjDKUCkJF65h/632XwatHeEQ08QGSYWdlzjtgjVyygiccSHWxNfEA?=
 =?us-ascii?Q?Oa+EePvNZrCWyU3Lg8enZ62Iw7Z5W9fbD5X1kc6irZ9/M93n0/VxHoh2pNID?=
 =?us-ascii?Q?1Psk/SaXzL+NFPG6++A5xmeDVR60cldxgFVwfv9G17Ho/lv+cHp2AeQ01uLv?=
 =?us-ascii?Q?3hE0IE+x+hVBTbk1fVbgI0aLbKiy/BCtWNViscpNNYjkZchU+wkciZj2IPWD?=
 =?us-ascii?Q?T6rD+9stP4mfCF4Vhdy3n9abO+8eUGoufpDySj1yaWj/0b2tP+4qGH5AAt10?=
 =?us-ascii?Q?erL0Q99GLE0vfSoK8EFyMWZQjLHBrlQHPDaGsK988Rb3c1ZPpesapYJ3Ay4t?=
 =?us-ascii?Q?L+QdHwEJxhqQr3AqJ8LcTK+tg/uSJGxhOAq4hb8onDsM9PrAC5cMuwTVBXfw?=
 =?us-ascii?Q?uTXGM2JBI8m/H62rg0xAQJ2fjQkMMYk2VpcB9pyMLmPuMI4AQltoI2qFk6tk?=
 =?us-ascii?Q?ziaxud2Wg/I2kt7UeRbU7FO9NojNQkUaTsB45nQdqvJ8n70Z8dAEogoeCI3p?=
 =?us-ascii?Q?iqPzhul/Ewyb47JjywD4xkyoXtO6BohVGoT7x/Bgn5/GRhZ/aJx589xulVgk?=
 =?us-ascii?Q?XcUAFMgvrPhFosiQgqStNKBnVZLElLaw9jDzVUqjH3e8/BJbxzbvpA2WF2Oa?=
 =?us-ascii?Q?Rp9SOd+5WmrCe5FjE8s92FIkDZlibjW5dKNy2VwDWdDBHKol2MjAlsbnyA03?=
 =?us-ascii?Q?Lavb4PNPwcXe57XP0bnucWyq5ZWJLNqzzXhVLfpGZxTurNyTrFO9vyFlTZOp?=
 =?us-ascii?Q?+3WwPgyKoOIx8OcUUrunCrQ6Q5+HobPhGv7MOlFqsl2ce5I93no16x4+Kxnu?=
 =?us-ascii?Q?gveJ2FphsnfA07uHndqMG/bp/AJ8ZQP8wT0LAAnIlQw2lJAgqNqt5xUhxs9T?=
 =?us-ascii?Q?CPf8lwJPJglDofXUpd3aF9cLnA5KTESNtAaAXNtVPhKPxzYynzO2/SROXLQO?=
 =?us-ascii?Q?z3NCVEtu3lcs7+1tiBH2CV9hy+UFPG7E+fxzL8X+0VPlQ9Cn4LsvLz2kuB8a?=
 =?us-ascii?Q?K1N4ev9xQAghiXTLZLRJVIi3CLqUA21JEN/rMmeVL6vmHFQOm884xgAjxl03?=
 =?us-ascii?Q?xwp3CgP+0FUSFE2MPg+CjVnxVM39kgVnMYopLdknlK3EbzQbm+fR3sxzzkNG?=
 =?us-ascii?Q?cV/3sXFjlQHFfKqANfo+y6OqVk8qkZ1/ZbA5ihpLfUbYnAVrQJXv8HnUFY9/?=
 =?us-ascii?Q?7D81BJJGAZbI+IkS/Ca5roMfXYmNrS/P5niFoq6aADCBcpSsLSFZC5oFRz+n?=
 =?us-ascii?Q?syzUpgbsBWBoOwjGJrS3y3Q42BeVrAg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284dba7f-9e01-4020-affc-08df3950af52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:18:01.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bo6YHJSH2G05YFhj9UI2IlWBhFNv4pE/ER0hGEJ2D2+rterT/G3EO1ZiudWc1esJ0R9iS5Fhl8y+b8S/x8/uw1T27eU44AyO8c9MDCVxsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989637
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

dm_i3c_read/write indexed master->i3cdev[] without checking the device
number or a NULL slot, which can crash on a bad index. Reject out-of-
range and empty slots with -EINVAL.

On detach, clear the matching i3cdev[] entry so a later transfer cannot
reuse a stale descriptor pointer. Leave num_i3cdevs unchanged so the
existing dense listing path keeps its prior meaning.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 25933adf010..e5a437781fc 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -826,6 +826,7 @@ static void dw_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
 	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
 
 	i3c_dev_set_master_data(dev, NULL);
+	master->i3cdev[data->index] = NULL;
 	master->addrs[data->index] = 0;
 	master->free_pos |= BIT(data->index);
 	kfree(data);
@@ -1014,9 +1015,14 @@ static int dw_i3c_master_priv_read(struct udevice *dev, u32 dev_number,
 				   u8 *buf, u32 buf_size)
 {
 	struct dw_i3c_master *master = dev_get_priv(dev);
-	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_dev_desc *i3cdev;
 	struct i3c_priv_xfer i3c_xfers;
 
+	if (dev_number >= ARRAY_SIZE(master->i3cdev) ||
+	    !master->i3cdev[dev_number])
+		return -EINVAL;
+
+	i3cdev = master->i3cdev[dev_number];
 	i3c_xfers.data.in = buf;
 	i3c_xfers.len = buf_size;
 	i3c_xfers.rnw = I3C_MSG_READ;
@@ -1028,9 +1034,14 @@ static int dw_i3c_master_priv_write(struct udevice *dev, u32 dev_number,
 				    u8 *buf, u32 buf_size)
 {
 	struct dw_i3c_master *master = dev_get_priv(dev);
-	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_dev_desc *i3cdev;
 	struct i3c_priv_xfer i3c_xfers;
 
+	if (dev_number >= ARRAY_SIZE(master->i3cdev) ||
+	    !master->i3cdev[dev_number])
+		return -EINVAL;
+
+	i3cdev = master->i3cdev[dev_number];
 	i3c_xfers.data.out = buf;
 	i3c_xfers.len = buf_size;
 	i3c_xfers.rnw = I3C_MSG_WRITE;
-- 
2.43.7

