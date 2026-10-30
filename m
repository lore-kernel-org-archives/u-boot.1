Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03E606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bzm4YZz/;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=Rjttrh3+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41E1360633;
	Fri, 30 Oct 2026 09:48:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Qx9pSKEHUz2; Fri, 30 Oct 2026 09:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 761D560A70
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793353686;
	b=oAGwb2mTFU8vq4ILC0pIHmE57fSSxqrXj8E5SepAjT0NqcIGhxq/cmnI0/8yoOUUVAuM
	 JDaED8pmkn37MAOjDCTTqY3TEubcD2+OXDuMRj6vrY1vwsGM9mlBKFoJoTipl+vKFH587
	 /9xSbpk6vEsXl3L/FHPTVwktKQO1hWj5JkKS2M3KEFC4yXhSWukBYHLit+GMaJ/iRnvE9
	 E5Dtq0ZClhRBcslNjOEOOKm1yJGDaz/MdgJ66Me6akVv2IuUBHYDgK//E/rLz+p3C+hHy
	 pBBIxY+0dlYzUENIVjoazoQc3r1Ch2ilvckmr8/RnRb3fbx4HL5kA7/kriqj1yRYp5g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793353686;
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
	bh=s4+9Ycp2cmFeCA1vZVVCrSGijZcI+yie4Xtng6MkSrs=;
	b=jveycvFL+REDfnOttYqKZL4DfBJJVptryczQUcVXK2n/Qm0AOBwoGV0JhwgMd+EOJSI9
	 kXiQZ8VseXFWWuFtPdFT0gJWQB1kDkoyh4KWcjUWAN6dCmKDXInc2u7TYGz1cSAIvIstC
	 oEjvjtWtkXNoKHYO/HdzNRjrSBFVJO5lIXu4iukPu/8kuY8gEY5wzumJXsy73jr9kpv9d
	 Ui/qb1ZC4M/5JoNX406tT92z0BgdTonW4gpp2SQxW+pDMBgTj4KndH0/HRChtHUhqMafX
	 3zyiEU+DdiDj18ycaEOd4BMrJnix1BmxnSW2sbjuPOGc+IRuE5IW6C/yy0HYRYIxG8g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793353686;
	bh=s4+9Ycp2cmFeCA1vZVVCrSGijZcI+yie4Xtng6MkSrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bzm4YZz/UAeZGHtjUgqHWNzgFfwTp6uGXTys8ry++iB9iLxpg6AyShNVb1Eiv0mH1
	 PNvF+heqvzYIsjiFh5EI2DeDTddSakWQkUn2FiY/ym+RK//V+9oReiq3I4gOf4mrhw
	 wdde9ujszppN0cEmeEKkgLj4nClx8FAFTlDtUrfr6JcckrCZzUHKFIMvhgTsY+pnuY
	 PCdq9n3up9qyYV2LwROJq9H52g/hi5orWSj8oQBrrmZZ8LTZkmxxwy1WjAm0nsnwVr
	 by/u3Gj6goLb5lxBXd7pX7i4o03ziatEHmXHDmtddKMQt58iWM2C3P1qQIqVvtmdBK
	 4ynpkq148hE5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 761D560A70;
	Fri, 30 Oct 2026 09:48:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F8B8235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0CFA64009F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JaY550Ur2IC3 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E2A5840063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793353682;
 b=riwpEENuaKMzAMwuO+GmK/qHz7hbWsvKBOCrs4+CFzxcDiXTqqCJEYO0AT1oJGCVMFWP
 Z5vn3SDGWkIJyZ1Cf/OXKvK1aC62gUTUpnU23HvWTxfQedjFEifvFenV1q53Tg6tM6G8/
 E8ClhAl3E5cAv6Qt6kwjny9HaY37YhfoaqjlYMltdaX62axopov9m5xCPla1oWCZ26yfb
 fVWbpOp1hYGPXOhc5DgT8PM8FmALBhNEbAa/M82+B6cbqlueCTTmWdUWne+reLaAcqrdd
 wlseQzD339t+eNmTCarVHGBh/NKKjbQh66X4yuO616l1563jzoPNTZ489rEcVTvyonQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793353682;
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
 bh=s4+9Ycp2cmFeCA1vZVVCrSGijZcI+yie4Xtng6MkSrs=;
 b=RapwSVPzhyW2WJJjiqCC6383kcbD/Wc44wnLgsDR2vHtvUuTuF+OBFOwk2AixwJiac65
 tMLpemj9grzUW9kogoLh3cWnapOA7UK9PGtV6SriGIOEcQ90kLc8MZzSCFsIxWN/SfYXV
 c5nzhHb9Oob4By03PaIVSJdXOsZLhJCsJQrLTD9kaCFTFAQjmZyM8oL+HN5cd4mnNs6Pa
 iHRDSG2JWagHzYWw3LNWSm0ki/eYs4QuJJ/+oXj9/v3oG8Kl8uNUXs41O1zN/Pdd3yhOI
 lCoAd8EHiMQ1obzF8IiWwkQYAjoXUGmh6s7Biw1RUemC/ABzydQfOnjTfodeDD+0WaQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Rjttrh3+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=Rjttrh3+
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2A5840063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+M7qWXBsbqZTecSnRtUN1EXlIGYm4c9euP0ZwQzJC0OU21DZis5IUGvQaS/6WSd1idpR/LihhE7GIrSWXmXFgJ1UVjDEW2oSWDzlDQ0P+m2U7rY/H+9s0WjxSHvEOyfeu0WVxVH47dEasirMUJrxuWKeaaqDFxzoLh80qczF/1Hfqq8LnTBTsbGxMItLl0eDCUX9V9k0ovUbS+Z+8Gm0PIltUbuRDg3Zk2q0qLuIHkco3EGI4ccxIlQRjb6nL2sPlokvt8JzSWBMQYAj6b6Bbkd9xLHyvxZJF5PPE81BKZOF0oNMLHPTkWEWnK1k85ejbOduylyD7eROFJ4/WLz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4+9Ycp2cmFeCA1vZVVCrSGijZcI+yie4Xtng6MkSrs=;
 b=rYLzrXZSbyFQKUWBb2eXU/Tt0Ypc4K9Udea9Ww5LZXWH3fLk265QL/zNNv76MBYnW7LWDuJEqX9FDlbcPPRdkHF+ENkT9hTb1BAPcWs9XC1BkV54nN86soBcTp2nzRLIZbCNXqzPmhPjyyHQf7wsXobrYeMpvYQxSgyfBaiMFOvxU6vSxtg2W9hMcSmaybyfcd5UfYC2vrhy5DOTZN+dTbvIezgKhQ6hxbL4LvXD5CHMiJnq2jJSytZiZbIyJ1yQOU2Ubl2IK2wDm6KEyidsLHka8kV6uydxzGFRDXeSMJss0+IaJXqOajbwuXf/ghBmPTrlJ7qxyP4CBBoP3S4AkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4+9Ycp2cmFeCA1vZVVCrSGijZcI+yie4Xtng6MkSrs=;
 b=Rjttrh3+ptAK5OHQQOZiRKj+4CtYPhYjZ656uACFK5U/yxfLvRCUpHwuP7+x2PeMexbOa9nBGQVICPpilQSYiJ3n3cmM9kBd35XvQTByLPD5uEGttOsdER45O9QTD5I1wAIHtoKWgmyKTwe881Gcz9VWs2HkjHU2GjombGUE13yoRLK9db4OhwB58v0x6BgPQ2jExQUWVObIeiXLuhEFA7FReMegiNsGDOl43AqcNktSQZSwvccD7li21CvsTIWzzGhTbrg/m0ySEJ0tFXx91lEn8X/2yaUP6l3m3b3R2H4pUDExdqXU6CAbqoFVDwMS8ESuGptfjkXhWyyrjt/3xg==
Received: from ZR2P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:46::19)
 by PARP264MB6329.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:47:52 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:910:46:cafe::c) by ZR2P278CA0027.outlook.office365.com
 (2603:10a6:910:46::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 09:47:51 +0000
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
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 30 Oct 2026 09:47:51 +0000
Received: from localhost.localdomain (unknown [192.168.72.182])
 by proxy.softathome.com (Postfix) with ESMTPSA id D29462009E;
 Fri, 30 Oct 2026 10:47:50 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 1/4] binman: bintool: Add PKCS#11 HSM signing support
Date: Fri, 30 Oct 2026 10:47:42 +0100
Message-ID: <20261030094744.82142-1-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFLszTiB=8FQhLJY8ywe5V+ZNz0uTeMS38=xDyiaqGXbO4CQGg@mail.gmail.com>
References: <CAFLszTiB=8FQhLJY8ywe5V+ZNz0uTeMS38=xDyiaqGXbO4CQGg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PARP264MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 501c6f49-298c-4719-52c2-08df366add08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|20052099010|17002099007|22082099003|18002099003|6133799003|3023799007|56012099006|261026121527099003|261022113327099003|10067099003|261021121427099003|261022105027099003|261022075727099003|261022115727099003|261021130227099003|261021123027099003|261026140227099003|261028144727099003|261013131602099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: E6QZJxXy/X+SlDZ6RZCD6zk5v8zCSbFmo3IldMhldKKx+LuWhSZWCSiEwbiYvyoI+EwaLZ5DEDRhK0GJgNSzYmvvnK1/tNweLPkstJYA2O9hZQqLvGZ0BxeZtbkH+d2KqnZSc6VTjYJzHMUCMYNRtFDh1luVP0bYK6BitMyXfsrrAxYAnARMgsu4clpc3c7ZWMo2Aa9cJYBYzOtl10fBboJmjGWl0mBtqssy1NkWjh5rEsB0tkzxsK+RqfJ5TFXp8vwSekqbtY75l6NUbY/Asb7mH1SiuaCie22nfYU4BfR5SqYTqS58fnQ9wquybXhMwRGw7ChZEC73p8+2xkhnD6kD0DHxoSYRWRY7GqfgIQ+ppYeht0qamAdGjSuAqQ5gXNEIbFlL2YdWSMHp+a8pMJL34lOdAjI4KpRocRaE2ZrKPO+zvpNqcIwEhkAi5QcyJ1heZ08OpsXEZjXLpDr8omcvME2iY+MrjNXSpl/FCmQ8EAm4aJMigri72cuTnudaVbE4r6X9b7W29NCZGdaiKmA9roBi96UeNt+tPsbLV4OunCrmD8nHe7S5BcYmUECnm68wUk+o4Td+I/qwIS6OstXW6aYIPRBiA+Ko/LQxzEZ8cmVvDNCelc8+s/rENDn4t7coQmdePT6RC/2yh40D5vn7c3kGL9khz6xa79EBjFKZqfRZGpu51Pul87X0jzHHq4130SEJ4oVCAZmlbGqpLQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(20052099010)(17002099007)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(261026121527099003)(261022113327099003)(10067099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(261021130227099003)(261021123027099003)(261026140227099003)(261028144727099003)(261013131602099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q/n1gOv+UIBpFQphCj1OTUX9KfkTZCO3m8IzuK1t2lFOr7TTlOpaYbtLL/m351suOYNkaRWCZR6oR/QcO8zeGw19DoQHl4IyzI+dWCtKIXDDHakQ9b5z9pgwunjCaY3qNQATLTc9aSniaK5VjBn3dSLRkcpwjNF2MmBalVBIK/1dfB/V68KOQHb546X+AzYgbwgaHBXoHgN/8gretJ7QXjfc0Vt5j+BcV9k0rcI++trAeZxC8BNh2jKL4xFyhq4YcxPTc076AMPsLQcdVLpyzjWFqmAA602KJ9hwkpuiIlxQwcxTMgAmjUwoUjYf4KpsJYH8JzbGI1E9032SvmK0TKT8yNzlQOfwbj6KjgOCFrt64DSVAApHYUwXzYUG5cMn4xZDGkt4frIrtur/RcEwOj6G25kV04Kb7QKt/f9FSI5Xu6ZHjNqlzOYzdvv8RFhM
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:47:51.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501c6f49-298c-4719-52c2-08df366add08
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6329
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement signing through pkcs11-tool using the PKCS#11 interface,
allowing binman to use private keys held by an HSM.

bintool.py:
- Add an env keyword argument to Bintool.run_cmd_result(). The given
  variables are merged into the environment of the tool. When
  tools.get_env_with_path() returns None, start from os.environ.

btool/pkcs11_tool.py:
- Add _build_mechanism() to map hash, signing algorithm and padding to a
  PKCS#11 mechanism name and rejects unknown hashes, unsupported algorithm
  families and names that cannot be parsed.
- Add _verify_mechanism() to check the mechanism against the token's
  list from --list-mechanisms, selecting the token by slot index or
  label. It is skipped with a log message if the tool is unavailable,
  exits non-zero or its output cannot be parsed.
- Add the public method find_slot_by_serial() to resolve an
  HSM token serial number to its slot index;
- Add sign(input_file, module, output_file, ...). output_file is a
  required argument, the path where pkcs11-tool writes the signature.
  sign() accepts token_label, token_serial, slot_index, key_label,
  key_id, pin, hash_algo, sign_algo and padding. It:
  - requires a token identifier, a key identifier, a module path and a
    module that exists;
  - resolves token_serial to a slot index before verification;
  - falls back for ECDSA to hashing on the host and signing the digest
    with raw ECDSA when the token has no combined mechanism;
  - requires a PIN. It passes --pin env:BINMAN_PKCS11_PIN with --login
    and sets BINMAN_PKCS11_PIN in the tool's environment, so the PIN is
    never on the command line;
  - raises RuntimeError when the tool is missing, fails, or writes no
    signature.
- Add opensc_version() to read the OpenSC version from the 'Library' line
  of --show-info. It is a best-effort check.
- Add _check_opensc_version(), which refuses to sign with OpenSC older
  than 0.15.0, the first release that accepts 'env:' for --pin.

bintool_test.py:
- Import hashlib and add a _CmdResult namedtuple for mocking
  run_cmd_result().
- Add helpers _make_module_path(), _make_output_path() and
  _make_input_file().
- Add tests for mechanism building, mechanism verification, slot lookup
  by serial, sign() argument validation and failures, successful
  signing with slot index, key id and PIN, ECDSA with HSM and host
  hashing, the no-mechanism and no-PIN cases, OpenSC version parsing and
  refusal, PIN passed only via environment, env handling in
  run_cmd_result(), and token serial lookup and resolution.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Make output_file a required argument of sign(). The caller now controls
  the path; the bintool no longer creates or removes a temporary output
  file, simplifying cleanup and letting the caller keep the file for
  debugging
- Add opensc_version() to parse the OpenSC version from the 'Library' line
  of --show-info. It is a best-effort check (returns None on any failure)
- Add _check_opensc_version() which refuses to sign with OpenSC older than
  0.15.0, the first release that accepts 'env:' for --pin. Older versions
  take 'env:BINMAN_PKCS11_PIN' literally, silently fail or lock the token
- When tools.get_env_with_path() returns None, fall back to os.environ so
  that the subprocess always inherits a usable PATH
- Add tests for: OpenSC version parsing (valid and malformed strings),
  version refusal (< 0.15.0 raises ValueError), PIN passed only via the
  environment, env keyword argument in run_cmd_result(), and token serial
  lookup with resolution through find_slot_by_serial()

 tools/binman/bintool.py           |  10 +-
 tools/binman/bintool_test.py      | 650 ++++++++++++++++++++++++++++++
 tools/binman/btool/pkcs11_tool.py | 379 ++++++++++++++++-
 3 files changed, 1032 insertions(+), 7 deletions(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165b..afc19fe35d8 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -273,7 +273,7 @@ class Bintool:
                 show_status(col.RED, 'Failures', status[FAIL])
         return not status[FAIL]
 
-    def run_cmd_result(self, *args, binary=False, raise_on_error=True):
+    def run_cmd_result(self, *args, binary=False, raise_on_error=True, env=None):
         """Run the bintool using command-line arguments
 
         Args:
@@ -282,6 +282,8 @@ class Bintool:
             binary (bool): True to return output as bytes instead of str
             raise_on_error (bool): True to raise a ValueError exception if the
                 tool returns a non-zero return code
+            env (dict or None): a dict of extra environment variables to set when
+            running the tool, or None for no additions
 
         Returns:
             CommandResult: Resulting output from the bintool, or None if the
@@ -291,10 +293,12 @@ class Bintool:
             return None
         name = os.path.expanduser(self.name)  # Expand paths containing ~
         all_args = (name,) + args
-        env = tools.get_env_with_path()
+        run_env = tools.get_env_with_path() or dict(os.environ)
+        if env:
+            run_env.update(env)
         tout.debug(f"bintool: {' '.join(all_args)}")
         result = command.run_pipe(
-            [all_args], capture=True, capture_stderr=True, env=env,
+            [all_args], capture=True, capture_stderr=True, env=run_env,
             raise_on_error=False, binary=binary)
 
         if result.return_code:
diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
index 7e8dafea94e..25aa6e4d800 100644
--- a/tools/binman/bintool_test.py
+++ b/tools/binman/bintool_test.py
@@ -6,6 +6,7 @@
 """Tests for the Bintool class"""
 
 import collections
+import hashlib
 import os
 import shutil
 import tempfile
@@ -21,6 +22,9 @@ from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
+# Shared namedtuple for mocking run_cmd_result() return values
+_CmdResult = collections.namedtuple('_CmdResult', ['return_code', 'stdout', 'stderr'])
+
 # pylint: disable=R0904
 class TestBintool(unittest.TestCase):
     """Tests for the Bintool class"""
@@ -38,6 +42,22 @@ class TestBintool(unittest.TestCase):
             shutil.rmtree(self._indir)
         self._indir = None
 
+    def _make_module_path(self):
+        """Create and return a path to a fake PKCS#11 module file"""
+        path = os.path.join(self._indir, 'fake_module.so')
+        tools.write_file(path, b'')
+        return path
+
+    def _make_output_path(self):
+        """Return a path where a signature can be written"""
+        return os.path.join(self._indir, 'sign_output.sig')
+
+    def _make_input_file(self, content=b'test data'):
+        """Create and return a path to a fake input file"""
+        path = os.path.join(self._indir, 'sign_input.bin')
+        tools.write_file(path, content)
+        return path
+
     def test_missing_btype(self):
         """Test that unknown bintool types are detected"""
         with self.assertRaises(ValueError) as exc:
@@ -354,6 +374,636 @@ class TestBintool(unittest.TestCase):
             result = btool.run_cmd_result('fred')
         self.assertIsNone(result)
 
+    def test_pkcs11_tool_build_mechanism(self):
+        """Test PKCS#11 mechanism name construction"""
+        btool = Bintool.create('pkcs11_tool')
+
+        # RSA PKCS#1 v1.5 — key-size suffix is stripped
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs1v15'))
+        self.assertEqual('SHA384-RSA-PKCS',
+                         btool._build_mechanism('sha384', 'rsa3072', 'pkcs1v15'))
+        self.assertEqual('SHA512-RSA-PKCS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pkcs1v15'))
+
+        # ECDSA mechanisms
+        self.assertEqual('ECDSA-SHA256',
+                         btool._build_mechanism('sha256', 'ecdsa', ''))
+        self.assertEqual('ECDSA-SHA384',
+                         btool._build_mechanism('sha384', 'ec256', ''))
+
+        # RSA PSS combinations
+        self.assertEqual('SHA256-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pss'))
+        self.assertEqual('SHA512-RSA-PKCS-PSS',
+                         btool._build_mechanism('sha512', 'rsa4096', 'pss'))
+
+        # 'pkcs-1.5' alias is normalised to 'pkcs1v15'
+        self.assertEqual('SHA256-RSA-PKCS',
+                         btool._build_mechanism('sha256', 'rsa2048', 'pkcs-1.5'))
+
+        # Any known hash works with RSA
+        self.assertEqual('SHA224-RSA-PKCS',
+                         btool._build_mechanism('sha224', 'rsa2048', 'pkcs1v15'))
+
+        # Unknown algorithm family raises ValueError
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', 'dsa2048', 'pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # sign_algo with no leading letters cannot be parsed
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('sha256', '2048rsa', 'pkcs1v15')
+        self.assertIn('Cannot parse signing algorithm', str(exc.exception))
+
+        # Unknown hash algorithm raises ValueError
+        with self.assertRaises(ValueError) as exc:
+            btool._build_mechanism('md5', 'rsa2048', 'pkcs1v15')
+        self.assertIn('Unknown hash algorithm', str(exc.exception))
+
+    def test_pkcs11_tool_verify_mechanism(self):
+        """Test mechanism verification against token's allowed mechanisms list"""
+        btool = Bintool.create('pkcs11_tool')
+
+        mechanisms_output = (
+            'Using slot 0 with a present token (0x1)\n'
+            'Supported mechanisms:\n'
+            'SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA384-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n'
+            'SHA256-RSA-PKCS-PSS, keySize={512,4096}, hw, sign, verify\n'
+        )
+
+        def fake_run_ok(*args, **kwargs):
+            return _CmdResult(0, mechanisms_output.encode(), b'')
+
+        # Mechanism present — no error
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_ok):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so')
+
+        # Mechanism absent — raises ValueError
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_ok):
+            with self.assertRaises(ValueError) as exc:
+                btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+            self.assertIn("not in the token's allowed mechanisms",
+                          str(exc.exception))
+            self.assertIn('SHA512-RSA-PKCS', str(exc.exception))
+
+        # Tool unavailable (returns None) — verification skipped silently
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_none):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Non-zero exit code — verification skipped silently
+        def fake_run_error(*args, **kwargs):
+            return _CmdResult(1, b'', b'error')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_error):
+            btool._verify_mechanism('SHA512-RSA-PKCS', '/fake/module.so')
+
+        # Slot index is forwarded to --list-mechanisms
+        received_args = []
+
+        def fake_run_capture(*args, **kwargs):
+            received_args.extend(args)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_capture):
+            btool._verify_mechanism('SHA256-RSA-PKCS', '/fake/module.so',
+                                    slot_index='2')
+        self.assertIn('--slot-index', received_args)
+        idx = received_args.index('--slot-index')
+        self.assertEqual('2', received_args[idx + 1])
+
+    def test_pkcs11_tool_find_slot_by_serial(self):
+        """Test find_slot_by_serial method"""
+        btool = Bintool.create('pkcs11_tool')
+
+        # Real pkcs11-tool output format: 'serial num' (not 'token serial num'),
+        # includes 'pin min/max' line and may include uninitialised slots.
+        slot_output = (
+            'Available slots:\n'
+            'Slot 0 (0x23aea6bb): SoftHSM slot ID 0x23aea6bb\n'
+            '  token label        : test-token\n'
+            '  token manufacturer : SoftHSM project\n'
+            '  token model        : SoftHSM v2\n'
+            '  token flags        : login required, rng, token initialized, PIN initialized\n'
+            '  hardware version   : 2.6\n'
+            '  firmware version   : 2.6\n'
+            '  serial num         : abc123xyz\n'
+            '  pin min/max        : 4/255\n'
+            '\n'
+            'Slot 1 (0x456): SoftHSM slot ID 0x456\n'
+            '  token label        : another-token\n'
+            '  token manufacturer : SoftHSM project\n'
+            '  token model        : SoftHSM v2\n'
+            '  token flags        : login required, rng, token initialized, PIN initialized\n'
+            '  hardware version   : 2.6\n'
+            '  firmware version   : 2.6\n'
+            '  serial num         : def456uvw\n'
+            '  pin min/max        : 4/255\n'
+            '\n'
+            'Slot 2 (0x01): SoftHSM virtual slot\n'
+        )
+
+        def fake_run_cmd_result(*args, **kwargs):
+            return _CmdResult(0, slot_output.encode(), b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_cmd_result):
+            # Finding first slot
+            self.assertEqual('0',
+                             btool.find_slot_by_serial('/fake/module.so', 'abc123xyz'))
+
+            # Finding second slot
+            self.assertEqual('1',
+                             btool.find_slot_by_serial('/fake/module.so', 'def456uvw'))
+
+            # Serial not present — returns None
+            self.assertIsNone(btool.find_slot_by_serial('/fake/module.so', 'nonexistent'))
+
+        # Tool unavailable — returns None
+        def fake_run_none(*args, **kwargs):
+            return None
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_none):
+            self.assertIsNone(btool.find_slot_by_serial('/fake/module.so', 'abc123xyz'))
+
+    def test_pkcs11_tool_sign_errors(self):
+        """Test error handling in pkcs11_tool sign()"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        # Unsupported signing algorithm family
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, output_file, token_label='test',
+                       key_label='test', hash_algo='sha256',
+                       sign_algo='dsa2048', padding='pkcs1v15')
+        self.assertIn('Unsupported signing algorithm', str(exc.exception))
+
+        # Missing token identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, output_file, key_label='test')
+        self.assertIn('Must specify either token_label or token_serial',
+                      str(exc.exception))
+
+        # Missing key identification
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, module_path, output_file, token_label='test')
+        self.assertIn('Must specify either key_label or key_id',
+                      str(exc.exception))
+
+        # Missing module path
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, None, output_file, token_label='test', key_label='test')
+        self.assertIn('PKCS#11 module path is required', str(exc.exception))
+
+        # Module not found
+        with self.assertRaises(ValueError) as exc:
+            btool.sign(input_file, '/nonexistent/module.so', output_file,
+                       token_label='test', key_label='test')
+        self.assertIn('PKCS#11 module not found', str(exc.exception))
+
+    def test_pkcs11_tool_sign_failures(self):
+        """Test pkcs11_tool sign() failure cases"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        # Tool not available
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=None):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, output_file, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('pkcs11-tool not available', str(exc.exception))
+
+        # Non-zero return code
+        err_result = _CmdResult(1, b'', b'Error: PIN incorrect')
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=err_result):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, output_file, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('pkcs11-tool signing failed', str(exc.exception))
+            self.assertIn('PIN incorrect', str(exc.exception))
+
+        # No signature output
+        empty_result = _CmdResult(0, b'', b'')
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=empty_result):
+            with self.assertRaises(RuntimeError) as exc:
+                btool.sign(input_file, module_path, output_file, token_label='test',
+                           key_label='test', pin='1234')
+            self.assertIn('no signature output', str(exc.exception))
+
+    def test_pkcs11_tool_sign_success_slot_index(self):
+        """Test successful signing with slot_index"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, output_file, slot_index='0',
+                             key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--slot-index', sign_args)
+        self.assertEqual('0', sign_args[sign_args.index('--slot-index') + 1])
+        self.assertIn('--login', sign_args)
+        self.assertIn('--label', sign_args)
+        self.assertEqual('test-key', sign_args[sign_args.index('--label') + 1])
+
+    def test_pkcs11_tool_sign_ecdsa_hsm_hash(self):
+        """Test EC signing lets the HSM hash when it offers ECDSA-<HASH>"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x06' * 96
+        seen = {}
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'ECDSA, keySize={256,521}, sign, verify\n'
+                       b'ECDSA-SHA384, keySize={256,521}, sign, verify\n',
+                    b'')
+            if '--sign' in args:
+                seen['mechanism'] = args[args.index('--mechanism') + 1]
+                seen['input'] = args[args.index('--input-file') + 1]
+                tools.write_file(args[args.index('--output-file') + 1],
+                                 fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, output_file, slot_index='0',
+                             key_label='test-key', pin='1234',
+                             hash_algo='sha384', sign_algo='ecdsa384')
+        self.assertEqual(fake_sig, sig)
+        self.assertEqual('ECDSA-SHA384', seen['mechanism'])
+        self.assertEqual(input_file, seen['input'])
+
+    def test_pkcs11_tool_sign_ecdsa_no_mechanism(self):
+        """Test EC signing fails if the token has neither ECDSA mechanism"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'SHA256-RSA-PKCS, keySize={512,4096}, sign\n', b'')
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, output_file, slot_index='0',
+                           key_label='test-key', pin='1234',
+                           hash_algo='sha256', sign_algo='ecdsa256')
+        self.assertIn("neither 'ECDSA-SHA256' nor raw 'ECDSA'",
+                      str(exc.exception))
+        self.assertIsNone(exc.exception.__cause__)
+        self.assertTrue(exc.exception.__suppress_context__)
+
+    def test_pkcs11_tool_sign_success_key_id(self):
+        """Test successful signing with key_id instead of key_label"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x05\x06\x07\x08' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, output_file, token_label='test-token',
+                             key_id='01', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--id', sign_args)
+        self.assertEqual('01', sign_args[sign_args.index('--id') + 1])
+        self.assertIn('--login', sign_args)
+
+    def test_pkcs11_tool_sign_success_with_pin(self):
+        """Test successful signing with PIN provided"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x09\x0a\x0b\x0c' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, output_file, token_label='test-token',
+                             key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--pin', sign_args)
+        self.assertEqual('env:BINMAN_PKCS11_PIN',
+                         sign_args[sign_args.index('--pin') + 1])
+        self.assertIn('--login', sign_args)
+
+    def _fake_pkcs11_run(self, version_line, calls):
+        """Return a fake run_cmd_result() for sign() tests
+
+        Args:
+            version_line (str): Output of '--show-info', or None to fail it
+            calls (list): Receives (args, kwargs) of each --sign invocation
+        """
+        mechs = ('Supported mechanisms:\n'
+                 'SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify\n')
+
+        def fake_run_result(*args, **kwargs):
+            if '--show-info' in args:
+                if version_line is None:
+                    return _CmdResult(1, b'', b'error')
+                return _CmdResult(0, version_line.encode(), b'')
+            if '--list-mechanisms' in args:
+                return _CmdResult(0, mechs.encode(), b'')
+            if '--sign' in args:
+                calls.append((list(args), kwargs))
+                tools.write_file(args[args.index('--output-file') + 1],
+                                 b'\x01' * 256)
+            return _CmdResult(0, b'', b'')
+        return fake_run_result
+
+    def test_pkcs11_tool_opensc_version(self):
+        """Test parsing the OpenSC version from --show-info"""
+        btool = Bintool.create('pkcs11_tool')
+
+        def check(out, expect):
+            with unittest.mock.patch.object(
+                    btool, 'run_cmd_result',
+                    return_value=_CmdResult(0, out.encode(), b'')):
+                self.assertEqual(expect, btool.opensc_version())
+
+        check('Cryptoki version 3.0\n'
+              'Library          OpenSC smartcard framework (ver 0.25)\n',
+              (0, 25, 0))
+        check('Library          OpenSC smartcard framework (ver 0.14.1)\n',
+              (0, 14, 1))
+        # Another module (e.g. SoftHSM) gives no OpenSC version
+        check('Library          SoftHSM slot ID (ver 2.6)\n', None)
+        check('', None)
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        return_value=None):
+            self.assertIsNone(btool.opensc_version())
+
+    def test_pkcs11_tool_sign_old_opensc(self):
+        """Test that signing is refused with OpenSC older than 0.15.0"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        calls = []
+        fake = self._fake_pkcs11_run(
+            'Library          OpenSC smartcard framework (ver 0.14)\n', calls)
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, output_file,
+                           token_label='test-token', key_label='test-key',
+                           pin='1234')
+        self.assertIn('0.14.0 is too old', str(exc.exception))
+        self.assertIn('0.15.0', str(exc.exception))
+        # The PIN must never have been sent to the old tool
+        self.assertEqual([], calls)
+
+    def test_pkcs11_tool_sign_opensc_version_ok(self):
+        """Test signing with a new enough or unknown OpenSC version"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        for line in ('Library          OpenSC smartcard framework (ver 0.15)\n',
+                     'Library          OpenSC smartcard framework (ver 0.25)\n',
+                     'Library          SoftHSM slot ID (ver 2.6)\n',
+                     None):
+            calls = []
+            fake = self._fake_pkcs11_run(line, calls)
+            with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                            side_effect=fake):
+                sig = btool.sign(input_file, module_path, output_file,
+                                 token_label='test-token',
+                                 key_label='test-key', pin='1234')
+            self.assertEqual(b'\x01' * 256, sig, line)
+            self.assertEqual(1, len(calls), line)
+
+    def test_pkcs11_tool_sign_pin_in_env(self):
+        """Test that the PIN is passed via the environment, not the args"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        calls = []
+        fake = self._fake_pkcs11_run(
+            'Library          OpenSC smartcard framework (ver 0.25)\n', calls)
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake):
+            btool.sign(input_file, module_path, output_file,
+                       token_label='test-token', key_label='test-key',
+                       pin='s3cret-pin')
+        args, kwargs = calls[0]
+        self.assertEqual({'BINMAN_PKCS11_PIN': 's3cret-pin'}, kwargs['env'])
+        self.assertEqual('env:BINMAN_PKCS11_PIN',
+                         args[args.index('--pin') + 1])
+        self.assertNotIn('s3cret-pin', args)
+
+    def test_run_cmd_result_env(self):
+        """Test that env reaches the real subprocess, with no search paths"""
+        btool = Bintool.create('pkcs11_tool')
+        btool.name = 'sh'
+        saved = tools.tool_search_paths
+        tools.tool_search_paths = []
+        try:
+            self.assertIsNone(tools.get_env_with_path())
+            result = btool.run_cmd_result(
+                '-c', 'printf %s "$BINMAN_PKCS11_PIN"',
+                env={'BINMAN_PKCS11_PIN': 'abc123'})
+            self.assertEqual('abc123', result.stdout)
+            # Without env the variable is not set
+            result = btool.run_cmd_result(
+                '-c', 'printf %s "$BINMAN_PKCS11_PIN"')
+            self.assertEqual('', result.stdout)
+        finally:
+            tools.tool_search_paths = saved
+
+    def test_pkcs11_tool_sign_token_serial_not_found(self):
+        """Test signing with token_serial when token is not found"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                        return_value=None):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, output_file, token_serial='nonexistent',
+                           key_label='test-key')
+            self.assertIn('Token with serial nonexistent not found',
+                          str(exc.exception))
+
+    def test_pkcs11_tool_sign_token_serial_found(self):
+        """Test that a resolved serial is forwarded as slot-index to sign"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x01\x02\x03\x04' * 64
+
+        sign_args = []
+
+        def fake_run_result(*args, **kwargs):
+            nonlocal sign_args
+            if '--sign' in args:
+                sign_args = list(args)
+                output = args[args.index('--output-file') + 1]
+                tools.write_file(output, fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'find_slot_by_serial',
+                                        return_value='0'):
+            with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                            side_effect=fake_run_result):
+                sig = btool.sign(input_file, module_path, output_file,
+                                 token_serial='SN12345', key_label='test-key', pin='1234')
+        self.assertEqual(fake_sig, sig)
+        self.assertTrue(sign_args, 'sign call never happened')
+        self.assertIn('--slot-index', sign_args)
+        self.assertEqual('0', sign_args[sign_args.index('--slot-index') + 1])
+
+
+    def test_pkcs11_tool_sign_rsa_no_mechanism(self):
+        """Test RSA signing fails if the token lacks the RSA mechanism"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        def fake_run_result(*args, **kwargs):
+            return _CmdResult(
+                0, b'Supported mechanisms:\n'
+                   b'ECDSA, keySize={256,521}, sign, verify\n', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError):
+                btool.sign(input_file, module_path, output_file, slot_index='0',
+                           key_label='test-key', pin='1234',
+                           hash_algo='sha256', sign_algo='rsa2048',
+                           padding='pkcs1v15')
+
+    def test_pkcs11_tool_sign_no_pin(self):
+        """Test signing fails when no PIN is provided"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+
+        def fake_run_result(*args, **kwargs):
+            return _CmdResult(
+                0, b'Supported mechanisms:\n'
+                   b'SHA256-RSA-PKCS, keySize={512,4096}, sign, verify\n',
+                b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            with self.assertRaises(ValueError) as exc:
+                btool.sign(input_file, module_path, output_file, slot_index='0',
+                           key_label='test-key', hash_algo='sha256',
+                           sign_algo='rsa2048', padding='pkcs1v15')
+        self.assertIn('PIN is required', str(exc.exception))
+
+    def test_pkcs11_tool_sign_ecdsa_host_hash(self):
+        """Test EC signing hashes on the host if the token only has raw ECDSA"""
+        btool = Bintool.create('pkcs11_tool')
+        module_path = self._make_module_path()
+        input_file = self._make_input_file()
+        output_file = self._make_output_path()
+        fake_sig = b'\x07' * 64
+        seen = {}
+
+        def fake_run_result(*args, **kwargs):
+            if '--list-mechanisms' in args:
+                return _CmdResult(
+                    0, b'Supported mechanisms:\n'
+                       b'ECDSA, keySize={256,521}, sign, verify\n', b'')
+            if '--sign' in args:
+                seen['mechanism'] = args[args.index('--mechanism') + 1]
+                seen['input'] = args[args.index('--input-file') + 1]
+                seen['output'] = args[args.index('--output-file') + 1]
+                seen['digest'] = tools.read_file(seen['input'])
+                tools.write_file(seen['output'], fake_sig)
+            return _CmdResult(0, b'', b'')
+
+        with unittest.mock.patch.object(btool, 'run_cmd_result',
+                                        side_effect=fake_run_result):
+            sig = btool.sign(input_file, module_path, output_file, output_file,
+                             slot_index='0', key_label='test-key', pin='1234',
+                             hash_algo='sha256', sign_algo='ecdsa256')
+        self.assertEqual(fake_sig, sig)
+        self.assertEqual('ECDSA', seen['mechanism'])
+        self.assertEqual(output_file, seen['output'])
+        self.assertEqual(hashlib.sha256(b'test data').digest(), seen['digest'])
+
+        # The digest sits alongside the input file and is kept
+        self.assertEqual(os.path.dirname(input_file),
+                         os.path.dirname(seen['input']))
+        self.assertTrue(os.path.exists(seen['input']))
+        self.assertTrue(os.path.exists(output_file))
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
index ca80943f98c..0b0be7f7233 100644
--- a/tools/binman/btool/pkcs11_tool.py
+++ b/tools/binman/btool/pkcs11_tool.py
@@ -3,17 +3,30 @@
 #
 """Bintool implementation for pkcs11-tool"""
 
+import hashlib
+import os
+import re
+
 from binman import bintool
+from u_boot_pylib import tout
+
+# First OpenSC release whose pkcs11-tool understands '--pin env:VAR'
+MIN_OPENSC_VERSION = (0, 15, 0)
 
 
 class Bintoolpkcs11_tool(bintool.Bintool):
     """pkcs11-tool -- support tool for managing pkcs#11 tokens
 
     This bintool wraps the `pkcs11-tool` command from the OpenSC project for
-    managing objects stored in PKCS#11 tokens. Binman uses this wrapper only
-    to check that pkcs11-tool is installed (and to fetch it if missing); any
-    actual key or token management for signing FIT images or capsules is done
-    outside binman.
+    managing objects stored in PKCS#11 tokens. Binman uses this wrapper to
+    check that pkcs11-tool is installed (and to fetch it if missing), and to
+    sign data using a private key stored in a PKCS#11 token (HSM, smart card,
+    or software token like SoftHSM).
+
+    The token is selected by label, serial number, or slot index (label takes
+    lowest priority; slot index takes highest). The signing mechanism is derived
+    from the hash algorithm, signing algorithm, and padding scheme, then
+    validated against the token's list of supported mechanisms before signing.
 
     See https://github.com/OpenSC/OpenSC/wiki for more details.
     """
@@ -22,6 +35,364 @@ class Bintoolpkcs11_tool(bintool.Bintool):
                          'PKCS #11 tokens managing tool',
                          version_args='--show-info')
 
+    def _build_mechanism(self, hash_algo, sign_algo, padding):
+        """Build a PKCS#11 mechanism name from algorithm parameters.
+
+        RSA and ECDSA signing algorithms are supported.
+
+        Args:
+            hash_algo (str): Hash algorithm (e.g. 'sha256', 'sha384', 'sha512')
+            sign_algo (str): Signing algorithm with optional key-size suffix
+                (e.g. 'rsa2048', 'rsa4096')
+            padding (str): Padding scheme ('pkcs1v15', 'pkcs-1.5', or 'pss')
+
+        Returns:
+            str: PKCS#11 mechanism name (e.g. 'SHA256-RSA-PKCS')
+
+        Raises:
+            ValueError: If the combination cannot be mapped to a mechanism,
+                or if the hash algorithm is not recognised
+        """
+        known_hashes = {'sha1', 'sha224', 'sha256', 'sha384', 'sha512'}
+        if hash_algo.lower() not in known_hashes:
+            raise ValueError(
+                f"Unknown hash algorithm: {hash_algo!r}. "
+                f"Supported: {', '.join(sorted(known_hashes))}"
+            )
+        hash_upper = hash_algo.upper()
+
+        # Strip trailing digits to extract the algorithm family:
+        # 'rsa2048' -> 'RSA', 'rsa4096' -> 'RSA'
+        m = re.match(r'([a-zA-Z]+)', sign_algo)
+        if not m:
+            raise ValueError(f'Cannot parse signing algorithm: {sign_algo!r}')
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
+            return f'{hash_upper}-RSA-PKCS'
+        if algo_family in ('EC', 'ECDSA'):
+            return f'ECDSA-{hash_upper}'
+        raise ValueError(
+            f'Unsupported signing algorithm: {sign_algo!r}. '
+            f'Supported families: RSA, EC, ECDSA'
+        )
+
+    def _verify_mechanism(self, mechanism, module, slot_index=None,
+                          token_label=None):
+        """Verify a mechanism against the token's allowed mechanisms list.
+
+        Calls pkcs11-tool --list-mechanisms to retrieve the set of mechanisms
+        supported by the token and raises an error if the requested mechanism
+        is absent. Verification is skipped (with a log message) when the list
+        cannot be retrieved (tool unavailable, non-zero exit, or unparseable
+        output).
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
+        if result is None:
+            tout.info('pkcs11-tool: mechanism verification skipped (tool unavailable)')
+            return
+        if result.return_code != 0:
+            tout.info('pkcs11-tool: mechanism verification skipped (non-zero exit)')
+            return
+
+        stdout = (result.stdout.decode('utf-8', errors='replace')
+                  if isinstance(result.stdout, bytes) else result.stdout)
+
+        # Parse mechanism names from lines like:
+        #   SHA256-RSA-PKCS, keySize={512,4096}, hw, sign, verify
+        # Only accept names matching the PKCS#11 identifier format
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
+        if not allowed:
+            tout.info('pkcs11-tool: mechanism verification skipped (could not parse mechanisms list)')
+            return
+
+        if mechanism not in allowed:
+            raise ValueError(
+                f"Mechanism '{mechanism}' is not in the token's allowed "
+                f"mechanisms.\nAllowed: {', '.join(sorted(allowed))}"
+            )
+
+    def find_slot_by_serial(self, module, serial):
+        """Find slot index by token serial number.
+
+        Args:
+            module (str): Path to PKCS#11 library
+            serial (str): Token serial number to find
+
+        Returns:
+            str: Slot index as string, or None if not found
+        """
+        args = ['--module', module, '--list-slots']
+        result = self.run_cmd_result(*args, raise_on_error=False)
+        if result is None or result.return_code != 0:
+            return None
+
+        stdout = (result.stdout.decode('utf-8', errors='replace')
+                  if isinstance(result.stdout, bytes) else result.stdout)
+
+        current_slot = None
+        for line in stdout.split('\n'):
+            # Track current slot number from lines like: Slot 0 (0x23aea6bb): ...
+            slot_match = re.search(r'Slot (\d+)', line)
+            if slot_match:
+                current_slot = slot_match.group(1)
+
+            # Match pkcs11-tool's 'serial num         : <value>' format
+            if re.search(r'(?<!\w)serial num\s*:', line, re.IGNORECASE):
+                serial_match = re.search(r'serial num\s*:\s*(\S+)', line,
+                                         re.IGNORECASE)
+                if serial_match and serial_match.group(1) == serial:
+                    return current_slot
+
+        return None
+
+    def sign(self, input_file, module, output_file, token_label=None,
+             token_serial=None, slot_index=None, key_label=None, key_id=None,
+             pin=None, hash_algo='sha256', sign_algo='rsa2048',
+             padding='pkcs1v15'):
+        """Sign a file using a PKCS#11 HSM.
+
+        The private key is selected by label or ID; the token is selected by
+        label, serial number, or slot index (slot index takes priority when
+        given; serial is resolved to a slot index before signing so mechanism
+        verification always targets the right token).
+
+        The PIN is passed to pkcs11-tool as '--pin env:BINMAN_PKCS11_PIN', so
+        that it does not appear on the command line. This needs OpenSC 0.15.0
+        or later. Older versions do not parse 'env:' and use the literal string
+        'env:BINMAN_PKCS11_PIN' as the PIN, so every signing attempt counts as
+        a failed login and can eventually lock the token.
+
+        Args:
+            input_file (str): Path to the file containing data to sign
+            module (str): Path to PKCS#11 library (.so file)
+            output_file (str): Path of the file to receive the signature. It
+                is left in place after signing, to help with debugging
+            token_label (str): Token label (alternative to token_serial)
+            token_serial (str): Token serial number (alternative to token_label)
+            slot_index (str): Slot index (takes priority over label/serial)
+            key_label (str): Private key label (alternative to key_id)
+            key_id (str): Private key ID (alternative to key_label)
+            pin (str): PIN/password to unlock the token
+            hash_algo (str): Hash algorithm ('sha256', 'sha384', 'sha512', ...)
+                Default: 'sha256'
+            sign_algo (str): Signing algorithm with optional key-size suffix
+                (e.g. 'rsa2048', 'rsa4096')
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
+            RuntimeError: If the signing operation fails
+        """
+        # Build mechanism name from algorithm parameters
+        mechanism = self._build_mechanism(hash_algo, sign_algo, padding)
+
+        is_ec = bool(re.match(r'(ec|ecdsa)', sign_algo, re.IGNORECASE))
+
+        # Validate token identification
+        if not token_label and not token_serial and slot_index is None:
+            raise ValueError(
+                'Must specify either token_label or token_serial or slot_index'
+            )
+
+        # Validate key identification
+        if not key_label and not key_id:
+            raise ValueError('Must specify either key_label or key_id')
+
+        # Validate module path
+        if not module:
+            raise ValueError('PKCS#11 module path is required')
+
+        if not os.path.exists(module):
+            raise ValueError(f'PKCS#11 module not found: {module}')
+
+        # Resolve slot from serial number (done early so mechanism verification
+        # targets the correct token)
+        resolved_slot = slot_index
+        if slot_index is None and token_serial:
+            slot_idx = self.find_slot_by_serial(module, token_serial)
+            if slot_idx is not None:
+                resolved_slot = slot_idx
+            else:
+                raise ValueError(f'Token with serial {token_serial} not found')
+
+        # Verify mechanism is in the token's allowed mechanisms list
+        verify_args = dict(
+            slot_index=resolved_slot,
+            token_label=token_label if resolved_slot is None else None,
+        )
+        host_hash = False
+        try:
+            self._verify_mechanism(mechanism, module, **verify_args)
+        except ValueError as first_err:
+            if not is_ec:
+                raise
+            # Some tokens (e.g. SoftHSM) offer only raw ECDSA and not the
+            # combined hash+ECDSA mechanisms. Fall back to hashing on the host
+            # and signing the digest with raw ECDSA; the private key still
+            # never leaves the token.
+            hsm_mechanism = mechanism
+            mechanism = 'ECDSA'
+            try:
+                self._verify_mechanism(mechanism, module, **verify_args)
+            except ValueError:
+                raise ValueError(
+                    f"Token supports neither '{hsm_mechanism}' nor raw "
+                    f"'ECDSA'.\n{first_err}") from None
+            host_hash = True
+
+        if not pin:
+            raise ValueError('PIN is required for PKCS#11 signing')
+
+        self._check_opensc_version()
+
+        # Hash on the host only when the token lacks a hash+ECDSA mechanism.
+        # The digest is written next to the input file and kept for debugging.
+        if host_hash:
+            with open(input_file, 'rb') as fd:
+                digest = hashlib.new(hash_algo.lower(), fd.read()).digest()
+            digest_file = input_file + '.digest'
+            with open(digest_file, 'wb') as fd:
+                fd.write(digest)
+            input_file = digest_file
+
+        # Build pkcs11-tool command
+        args = [
+            '--sign',
+            '--mechanism', mechanism,
+            '--module', module,
+            '--input-file', input_file,
+        ]
+
+        # Add token identification (slot_index takes priority)
+        if resolved_slot is not None:
+            args += ['--slot-index', str(resolved_slot)]
+        elif token_label:
+            args += ['--token-label', token_label]
+
+        # Add key identification
+        if key_label:
+            args += ['--label', key_label]
+        elif key_id:
+            args += ['--id', key_id]
+
+        # Add PIN and login
+        args += ['--pin', 'env:BINMAN_PKCS11_PIN', '--login']
+        run_env = {'BINMAN_PKCS11_PIN': pin}
+
+        # pkcs11-tool writes signatures to an output file; stdout is
+        # diagnostic text and must not be treated as signature data.
+        args += ['--output-file', output_file]
+        result = self.run_cmd_result(*args, raise_on_error=False, env=run_env)
+
+        if result is None:
+            raise RuntimeError(
+                "pkcs11-tool not available. Install the 'opensc' package"
+            )
+
+        if result.return_code != 0:
+            stderr = (result.stderr.decode('utf-8', errors='replace')
+                      if result.stderr else '')
+            raise RuntimeError(
+                f'pkcs11-tool signing failed '
+                f'(exit code {result.return_code}):\n{stderr}'
+            )
+
+        signature = b''
+        if os.path.exists(output_file):
+            with open(output_file, 'rb') as fd:
+                signature = fd.read()
+
+        if not signature:
+            raise RuntimeError('pkcs11-tool produced no signature output')
+
+        return signature
+
+    def opensc_version(self):
+        """Get the version of the OpenSC library used by pkcs11-tool
+
+        pkcs11-tool has no version option, so this parses the 'Library' line
+        of '--show-info', as reported by its default module (opensc-pkcs11),
+        which is shipped in the same package. This is a best-effort check.
+
+        Returns:
+            tuple of int: (major, minor, patch), or None if it cannot be found
+        """
+        result = self.run_cmd_result('--show-info', raise_on_error=False)
+        if result is None:
+            return None
+        out = ''
+        for stream in (result.stdout, result.stderr):
+            if isinstance(stream, bytes):
+                stream = stream.decode('utf-8', errors='replace')
+            out += (stream or '') + '\n'
+        m_ver = re.search(
+            r'OpenSC smartcard framework \(ver (\d+)\.(\d+)(?:\.(\d+))?', out)
+        if not m_ver:
+            return None
+        return tuple(int(part or 0) for part in m_ver.groups())
+
+    def _check_opensc_version(self):
+        """Check that pkcs11-tool supports '--pin env:VAR'
+
+        Older versions use 'env:VAR' literally as the PIN, so each attempt
+        counts as a failed login and can lock the token. Refuse to sign with
+        such a version. If the version cannot be determined, carry on.
+
+        Raises:
+            ValueError: If OpenSC is older than MIN_OPENSC_VERSION
+        """
+        version = self.opensc_version()
+        if version is None:
+            tout.debug('Cannot determine the OpenSC version; not checking it')
+            return
+        if version < MIN_OPENSC_VERSION:
+            need = '.'.join(str(v) for v in MIN_OPENSC_VERSION)
+            have = '.'.join(str(v) for v in version)
+            raise ValueError(
+                f"OpenSC {have} is too old: '--pin env:VAR' needs OpenSC "
+                f'{need} or later. Older versions take the string literally '
+                f'as the PIN, which counts as a failed login and can lock '
+                f'the token')
+
     def fetch(self, method):
         """Install opensc via APT """
         if method != bintool.FETCH_BIN:
-- 
2.43.0

