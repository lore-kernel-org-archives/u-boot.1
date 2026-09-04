Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AB2C79F87
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6BC040B4F;
	Fri,  4 Sep 2026 10:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrl6QVu5HnPm; Fri,  4 Sep 2026 10:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 125FF40B9E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788517146;
	b=EC/HgyRTmUjUP1a+jzAgNy0ejGbKZM1CfZp80O9Z8p+VX8fr3MsEcUXQdzcti7i1bWP+
	 BSR+qyrR3fPzvka1Tx/c6G2amdopIxYg9Ua/WanEFkxJG2joUZ8J42DDHpjT+hJf7oRJj
	 3lKKEeTBqTMxARVgjCoYSPd36UgUaEJpQ/SRXGvjrDjuDWmaMRqNK0XxkkOx7hQQNt4Gn
	 wJpyVlXKGZU6uC9cEhVnqSy9PGheXeHX5O4rmiTeKS9qouco3aOLTk0FR+2KOIPtSAVyQ
	 twGe5LrFx/iljjxEDWH20Xl21EMpRE43MbqlnqnSqW6+dZZoi8SvYhbaIJ2k18ZUpqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788517146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	bh=LKszQ0NqmyDkFJsKaP0Gp5URkV0j//0lNwS6ookQZWA=;
	b=lK3jh/Jl6HJ4pIsLZYurmBgaXByKDnql+R8QFVPVxkCz3ZZwrM9slaTcVGWityE/ZCcJ
	 +8mWhSYUSU3aTiufPvZfgUD7tYRxbPKHIQL1/4YB+Ynokll/80zDERfpPYQj2MckOE8gx
	 gQFXn5gHcmq7vD6zKAa7QFPsMbdXFflKol21dJEgmlieKqGC9vD2467kDv2gzxVCakGlZ
	 kin+GyAazZTk5jPdVOESlmX+185jUBT5Z4uxGD9ylCDFNhri9z4s5O4z2RlYAxDZmghKm
	 nK1dG+pR+pFZH0aQkO7u7oY8Pj3QZnPZ4w+s7SiyJNvcayWUrAq3KtrQpTazqhbYD2g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788517146;
	bh=LKszQ0NqmyDkFJsKaP0Gp5URkV0j//0lNwS6ookQZWA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WcKkKhpnaJmI4Vrd37yA0nlNgfpAob9NzD7+KppS2OjVpwb8Bgz95NM20aLPNmupm
	 wqmT9FF02gEsizZt9neLrCkp1TWm/ZBe4R3+QoN5Mz4dOmbpXBgiihMPZcP4QumUIH
	 i5D8pXhn3w6RfFXKvZI/XdyjrTbpg6ka3zkJ5XUgqW361yVyRSOZa59yx6AxvemtUc
	 DrS3fOBiEWX6dOA9nK0rwbKn9eRz681V4STqu670fhmX7ldakoCODCA6d2YB4M9+RK
	 oYMu2BqpXoCOIJXHQuUXaw96CAO224neDyr2rugJ8KHRPyCcmtsFJebhUhpkiaGxtj
	 /tZEox8knD85A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 125FF40B9E;
	Fri,  4 Sep 2026 10:19:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 51E76200E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3879D400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJ1tXmmBUeI8 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5F4FD40080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788517140;
 b=U1jzcC5AclwAqPxzg1ZGW2MtSAqzaxzIDxDJErYAonY+cgDnRBbCdIaGzay10nRW2l4P
 ZERTzfAbUjVckbX38Lf88WgLjr7FPSHZXPsRSGdS2kwd1l9lWKrRfGBPIJGwrd149jgKU
 OyEAhhX4GEXsm/I+LJyzV8VrW+86GMt1mpA1o6ua+BJOBMMpJTNE/4gkKgggbrLc/TFVM
 uafif2s27s24hVDrwJb0cjaRt6YZUlmwgjhZcFOZKQoNpjBt7b23UfJwQuPo9AAuH2qK1
 Spv4qAD18nB7ea7JAKOCeM81+yQu3NAvuunPNU4IokQFWzMYh1qENhTgmKw3Phqs3lQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788517140;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=LKszQ0NqmyDkFJsKaP0Gp5URkV0j//0lNwS6ookQZWA=;
 b=aVv/IdbpoHMvVeZ6NMUkyK9RuiszeIqi+xZG7spJ+0V90fbao4JmtSxwi96tXQq97TL9
 Y7Vv0JuknvSxQHOwXPuunkG0Ub2mdBf1ov5AqRHHmSrkDwBItnOpjPpcLCGU8O8pwhCEJ
 Tv3DYohoKO75tjUVzHROp6Bae6LStoX3cSbTofdKymP87ls/oTUAriNjboWd6EH9reyvI
 VcznbAfWgLYd1/7yhaWJF5dCgCt4+8+/7ao5XmD/So1VYZXonoAfK5sDL09mbwkjAy9en
 i4nUkVrIOVn2x65NjUSyVLPWwXXvQNEdcMgJIsW2WWMCWuuPiplIHnNiWPGnbxkzoaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=S1nq25iO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=S1nq25iO
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F4FD40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCH7dUFBzXLJ+uxUVFbalp5CdnXNIXqhe7jCDfGQBogzQ2fpmBZyW5hDj/BfoRAB/O6LUn4/s8IEfD0NaWl2LnC+DebWDYN560cIMnntKxqa/IH+TourQ7ck3C9UmQfJqzNVw6Xgw9nvyuuP3vFCpablWqSiNEMxAEJtnEDqvUFi32IQe8hPX+38X+BK2Vv4oGKYn+mw36wLeJ4b3s2hNqz2tYPLoNUk77Cu0mf7OuDp2T+82IXPQ60gWg4VF7qpWxXOA7b20WcPM4wpX6bjR7GXPcrlwyLWya4zI8WEVtNlDoWGK9SpxmLapBGLbtYIO0lq4GTjLP/d3vrYgZj3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKszQ0NqmyDkFJsKaP0Gp5URkV0j//0lNwS6ookQZWA=;
 b=YdPJxgfII/kbR5oX7+jp/SqBWn89JEse90t7sIpdAruWLbvDun86EtQ5LqNxgKLKNLqJURSDnYPy90zEFR2vY4SxeFR0aM/kb2DuxkUEFQhu+6+5m7MSaBr3JpMayFf/g//hSg+O8REV3OiAzZZzMPM3G3OyqpEXAnVxeydCHD4uGPHVUAIJVcEWvEvcu4klRDFXLEUnMTDRoW7FHskjgNdqTvXww78sb8NCynJjbM951agPS3sd5vcEMybPsDxsO2Ml1GF9qlyc1Vr/ukdm0H6u38gyLHxHOkR+z7AFJ8PrLp+F7rm1pn0ilFe93K3x5rsLlp7VrNVF8Ih/f8htFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKszQ0NqmyDkFJsKaP0Gp5URkV0j//0lNwS6ookQZWA=;
 b=S1nq25iOi6d/vcRa4TkoZ+xZ6ViGQwvT+SX2RjnfTvp8/mgjTKKx+Q/5yDcJVLownIJ0m6Bf0NShPLVL2hpMzF/u1wwg3cmaUEu7+SvNGN4x0jeEafZ3lxW+ZZOtgVpO4QvkWJXlg1uxJEz+bfYrahiT2AJu0L+hl21S0rFt8qWpl6W2JuZLP36ThPfUymdnHq2jvS5QUCwOqfUYyGcfQ6Wi2Kz/Hq4A9MyLSR+RbAR5vvjRiLrF7YqhZk+h6s7ONf8AoZf2CZu9K2BdRaOkYOtttWCyCJpKKKFaflrQKnxkAmwtTqA9ogfGRo/fcruIwZ4iYHi43lSIl7aA98KP2Q==
Received: from DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) by MI9PR10MB992259.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:290:b3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:18:53 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::51) by DB9PR01CA0015.outlook.office365.com
 (2603:10a6:10:1d8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:18:53 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:20:49 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:18:52 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 4 Sep 2026 12:18:41 +0200
Subject: [PATCH 2/3] configs: stm32mp21: Enable CMD_BDINFO_EXTRA flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-upstream_update_mp2_defconfig-v1-2-695c0abaac73@foss.st.com>
References: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
In-Reply-To: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|MI9PR10MB992259:EE_
X-MS-Office365-Filtering-Correlation-Id: 496957f4-e551-46fe-befc-08df0a6debd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GLw7wHTiCL4l4zF4D3q1Ldguz2Zo5az685ZP82Y4ptJg1PKvUnU8vufAphiWneC7plwxiKrhmHyRZmTCazRVKJV2TlyEy54NZimuFo1hyCnDr7h5rbrGZlijeYH6fjP0PLwWzuwQSBncV5PUUBkCRKwKe1RbnUrTv/sfqS3Aq/rqTUQkNS45LZ41uJMSATvd/Pqob7pk8syaLVl6+zm8UM8+Wg9TnVhrxKi4DXJIEma8nTCjuV06weW8Si4nSI6JEm/vECzdoKr/EYTW2pz1IXjljyWgVjt+8YQx0FYHMeIqOPwhQ0CiM5vjZcfAmUym1u8cXXTMi64+x5+AJoDKlr1LbPU6oeSGy7r+ecWCEepOcSXadXAsqPJ+p/P5KYyEQ40Bros0IKKtItw2rzcU2de4PJ0nztG2WmmeA5UF4dd+bHuoXSxzNhLjs93wBaQe8PNmj5Fy2id/MGyfb69UOeUwHLw1QiAsxM92PLO5YQrZ2+/Ty5WpElxZzonXxkCs4ItmnggdBHh4oSLNdIBNPnCz1pvQWQkbxqPqOFBQzJTWzcQMs0z0YbqIZXTAXNAlOT9tkDm0IRuZzrhW4QWQZ9yuak+W92iWSor34x6qxtxS5vzF2RytPxpnp0bsp1fmSEWvmBXy+XyjnhDbFZIvNo/czQAP5dJc8IUGshOWIUM=
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jd1KnY9QUWBuDS9BqTzVy0jexAnL7m+TDwiY8ZrMqzM0+1bxYq6vNWbg1HRWyDCBWf7mx/oqoLUK5Cdo8wsVaJ6ycNq514mMB9lOnUx91CtRL5YdUZpY5Uf6yCI4RkZL0zkCvY8ONiYVAmSf9NrWJ8LZ40FvKDWej6Otnjt+kCgKSfagDIvGJpnhiZuedvl7ucCkWwfo1Af8V+ppm2wjiZNw/A08OuQj7tD4hxdr0dx3mMIgc7yBdzbJaVlFQZACvcIG+wj72OC3jOeEuiV5l8bqPyWgRf2X3gKh6tOIvttJm7mJLzw27DKJbYG35bLI9lGMUnB2T0VJgYtOpoTny/+/PZe3hFBECnIvM8OCj22AD4hlvIMDYcSLwgUfqHVejSirfvVk6U+1F/VmVsrsK9VdlfafLB/F390DCLJH57ndZueqQneCnHTR91gG4x6N
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:18:53.3185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496957f4-e551-46fe-befc-08df0a6debd7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992259
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

Enable CMD_BDINFO_EXTRA flag for stm32mp25_defconfig

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp21_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
index 6a74a435f8d..22077e1291b 100644
--- a/configs/stm32mp21_defconfig
+++ b/configs/stm32mp21_defconfig
@@ -20,7 +20,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SYS_PROMPT="STM32MP> "
-# CONFIG_CMD_BDI is not set
+CONFIG_CMD_BDINFO_EXTRA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set

-- 
2.43.0

