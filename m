Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6E7C79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EEBE60BBD;
	Fri,  4 Sep 2026 10:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvB3lqwfsshn; Fri,  4 Sep 2026 10:19:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 90CE1607FF
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788517144;
	b=M305TrBK2trvV0Wij9ObWPP5G6F+8due5rFbMA6CZ99hxGrpIzH4JsN643djMfk8cSmk
	 bT+zbNwP1upcf85yCfHBm0dt9lHBYNvPgLkFxd/vT1REPxX4xpjRrryTX8so7i6C8rXqO
	 HTAPkX+h/sYbsIIMdf9BdRLW8No2fjFygP/hnwBPr6Spf9vtqvEct4gnKRE9lVjceqDR4
	 K6gvJzdxV6gI64tQjFVGN+GfFGlaeeSq+f2Eyu26JlCpoOz5FuUEGVW7JnvLFTae/g6aA
	 QkPUYbfCLyskVO3lV6yJ4gTQniSHAskkT2hw9+ISYScgtaZJcE/CHXp+HVUfi5YEx2g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788517144;
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
	bh=40/g4bXtTLx3YYvX/+P1dA+MbzfHUxQoMz0bvIoQdY4=;
	b=hRg2Tt1MYOprvZQB6XScS68MPxCTtlqt1MTc4m8wG0VlLqN4kOGUt5F7/BPAEhlS0mHG
	 XyMrSeTYRNtgP4h/wuh2MQiQtD1VMRhFNpfZ8avcPh2U/xhn5d6atuzDuKjS9/dkHcVB2
	 sOk1n9EAzVVIIDSg47CD/HfJAtzzBD0k2pUmnNxqwy4WRPyyDHG2LIY+HsG4UCM9LSB0E
	 DDJJEjgvnGIajdFqtXW+w3K8O7XFpP0F1x7VcpRXI0XxfN3HDgprCIn6jVgrD8TI98Du6
	 G3zl3FN43cqfeJF4E4XSxo/2te/TB/2T+OhGmWMcY6y3A4oG0UGBOw1cADbiMGjNjIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=bRFSCAiW;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788517144;
	bh=40/g4bXtTLx3YYvX/+P1dA+MbzfHUxQoMz0bvIoQdY4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0v+J/pYX0N+1DPBsVJ7V76rUSeUqWJeaYqYX5iO/j0xHS25xYOiXFdv2pmdHtVbk0
	 3kKCKx/W6N2SNJbMD7gJqZvJAdpsy6s7gnQYsAMQkp4DzbUNXb3aQooEfU8EOpn/vn
	 LG+FYhkIAfa079EbimnXhXuUzjM9m64IUtJteCQM7sD7jgZPnWVwXGyPH2hBD+wObT
	 0qrqnBUZGsXuxLypMnEE0Ws49fVJdiIPs5gZWjB2+Uv09bnJ52bmrXMjsN++spTfI7
	 oQO2daU+Wf+fgEBpjgyUZ32H00E6L4bmO/grmYOwSWhAwL9t15iaGzIwTS4UzE/t5Z
	 h1SLgnTZF2s1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90CE1607FF;
	Fri,  4 Sep 2026 10:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 44A0177F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3638E606F1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HzrpjQQpN-ws for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62D16607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788517140;
 b=Ojrd9R0B6QLycGeYaRgzvvVFLZyTUpuUMyjm/KCASDfnbgeqPcenrqJrPC//C3VAgt+v
 Nl4rjI85N81WsY2NkOV/D5a8YSP6Cqe8k5RdfL53NGB1GEnvhI3nji9ueS0WrzAoiUnCP
 CBF6LAPNL5KQ2shqjG/OjNVV5Ycp2P2vBGra7ab9+DkpaxCsLVXlKXgKvQ922ypDuQFYJ
 /GIOeidvYep/xcWqIhrmxA2HZImVNjBWGBibXj77BHVnHJDR+ah58JOT1n8R/CdRYIEYm
 64U8gN165LNWdboenk7yvuV4fftRhlMgRSHeOaRcRSkHz7Zw9kRpbFPhW2ERWlH6LJA==
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
 bh=40/g4bXtTLx3YYvX/+P1dA+MbzfHUxQoMz0bvIoQdY4=;
 b=DanIdCbBol6Eqzn5W+2HRQuhmiEs+Qqgdrz45TJf9q+SeO9z0yMSMfDn2lspLKRB8vx5
 I54AOMWZVle3svlq1ioWodGFgFzJoOOJz7H+QIb8jqoiwo5TyBUT6vP/UGOAxZKuaWoYp
 jAsDY/pEfCU1NHpSIRXnV/tDmkQvmNFgCSmxecpkjqMNEFIUHbXCWM6UKIkrqUwF8bgzK
 ldkw7bJ7CKgTIswh3cqKkwfe37LGjDPrtzP9+OsK+DYFxDeW9kIhTyeAyoeWWIkS07xA9
 XMgHrGbBgWIO2LzSBxVveOd28mcGSmqyus3h6Fm9ybpCMtAJtsWNI7m+RtaB2V1cSqA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=bRFSCAiW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=bRFSCAiW
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62D16607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa/PG6jqnTVg4MIv+T4GS04KFXFfQj2xSacxpwxOrZYpIeP0zdlCAyiwxT62zHFFP7oqaTufEOyekMeSXA9JRpJx+V+eV824V7o4BavdMz9HVCKpTPezQCwinfY/iENVCnSfSpeOH4Dy22QZjVd9C7D30kh4kOkctRVwjxNjzZWZRgMHuXIAg4uJmNgZ9Ugk0XP5CvnHGxLsJF8kdepesAcEfHoae2Ync91M3dnFbIe9iE8Mls4CHvixXBwFbRaXp/+Esr/OI7k03oIwNHyWIsPgt7lBOKC1FK28F5adiD/WqJZSAivZT8T/H8FLJhsHHewmsvuH2GA/efJj3pRDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40/g4bXtTLx3YYvX/+P1dA+MbzfHUxQoMz0bvIoQdY4=;
 b=YsV5z7XXFp9fo1hpm0rQxxLCXXYovxgo68AVP0bgq3SKrtqfso39xxbnqBstjj0SN5fZR8tpyBgUs0IMNlKVgyHvNrnhGwPAbeORB8Rgj4ksm7VpCpUQwuVeYtUzjZJbl0HSGVyjLSqD1jv21mMF1B1zYxRGUEEOzYkPK9QEgiTzEm5+LIIlMXI5csy/jYiM94LE7BZTHwC8XvocMRHUOAwn86wbFfLjCDRGdDrvGkMRmM9RmlQ8VrL3nh0uCQEE6p96JY5TbwHPF9K3xHwbTAZvYpAJAW7kBrPle4O4AYjvvFO9qBWLKvgT4GSWfwUlmJi+WcK+dHDCaLMt8uwdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40/g4bXtTLx3YYvX/+P1dA+MbzfHUxQoMz0bvIoQdY4=;
 b=bRFSCAiWH7ObvhKmwr5i9LpKmzNiGqLFdie07Spyf20Ymxib3O20JVhX8Fk/BzSlCVQfc761tP9NOx0VUW5ozp/A4TMTpmi5LahGaXh0/7FzN/q8op0P6WgqwfLh5/sWpcCSYkOlfnfJ19LEdwCwM/E+XsJaZWWSxy7f89RAFr/fHDH0WL5gcFsPw4pZahxxCT7ky43eQ5WoM6mMobFh89MRyz5QBW8+4i+jVQNg9pyER+hI33i6s2LHDuVkR+qBbBJZz0SdNMbUrn4QCe4hgtRkuoHXK3T0PHtSTMJf0Se3S1/CTWxZJm7hSrmolViNtqtl/hDbAv4R2r8IB/y2Xg==
Received: from AS4P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::8)
 by AS8PR10MB7706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:18:54 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::71) by AS4P251CA0002.outlook.office365.com
 (2603:10a6:20b:5d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 10:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:18:54 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:16:10 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:18:53 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 4 Sep 2026 12:18:42 +0200
Subject: [PATCH 3/3] configs: stm32mp23: Sync config with STM32MP25 one
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-upstream_update_mp2_defconfig-v1-3-695c0abaac73@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AS8PR10MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: db62010a-6346-4934-ed83-08df0a6dec3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: FooHn9uPOi0kyJFtk4URcS0mJC/xBlDH0uEDc5ADyA+nn7vfDnAYpla/riEBO7PR6up8hrML8ruMwMXSSev9T8ZjzniL1hVxn5i33MFJE74Mn8mlvNOps4GC3CULDUamKQ/G7/xJjec8nF0YQUNzKMAIPh7HCds9+u3o5RfHr+k2HPy2KbLDahpt2ESCnM/xK06sqyDoMPCwHpoPXo4XO2wtkcSZe5zbx2nGZHYPE1FUdL+MSbUwnMZeJwWieRban8lNA1Eyiqjpm6vhnZTD37uqkcn7cXgn6Wlzu9kCOF3L3qD6M4rQz7tqUCtmFRUmugUcb8jzifZc26OD+tD2QB5nQio8k/gyfDZj0hsK/GsT1SNZ/A4Z/XikOe7axkX6pMX7UJWbncHEPrApx4zeE5USoF6Z2nMitOuM9kiASCAnB+SFBjXgmRdEnjnG02tJvBzr4WR/stMIgUzB9m9DZRF+ZHYMSbgriZQL/R7Dh/CMrwzQK1PcrxG1UPKeerx/OSFVk6mxFdJ9gOTkJWjz+0htYW0aZWkHr8GqtbwYRJB1YoEJCShTPiTGwm4EeauTycWp7eCEKJrz80JuQFLN6p0JkynlWhbq+8x6RMRY+apts69LUNNqKO/0Gva4gs/Xcu1rT0Xxa3jMeAuKvkAOROXW6ppuFxKiuKqgfPiE1RI=
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qw122HcAg95Ap6cTNqaFmv72cp9jpbXiIXb2gLbTEe9URU60gZnLUohQjQwVSUprnOZ6AWSm9AX3luxSOdua75svsTZAbjxI2wuKV6kNOmN/dL2V/325ejsXGshWaHY186b8ioCTn+g5OPid+Ul7YF+JD/pwfUHo4XSZdiWm9+lzACBAR3RgNV0YPCeTFryjvXXIKG09pP6m79ov3+SM166NrFR7z2w2iaYDvQh9j7liyFbYct9p8mQ0Y7yGpEzG8hHR4KCFc+pJESjRea1s3vQKEMCUx/hIPv+MbowRGumivKAvP1OJ9SLu+z/0vB9qe4N15F/1ru3RZjjvwyqJ/OAgwb87DpuJ34G3OPDerqy++SfnuI8uzgotkktYD20Z9UVzXFQrSxpmvBCelmKIvmc3BFoewRGwyrxLzOZJ8wyDarKB1WjG20mViIqUjCT2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:18:54.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db62010a-6346-4934-ed83-08df0a6dec3e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7706
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

Synchronize STM32MP23 config with STM32MP25 one.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp23_defconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
index ed6fdd9662e..04aaa0f6b26 100644
--- a/configs/stm32mp23_defconfig
+++ b/configs/stm32mp23_defconfig
@@ -10,6 +10,8 @@ CONFIG_SYS_LOAD_ADDR=0x84000000
 CONFIG_STM32MP23X=y
 CONFIG_DDR_CACHEABLE_SIZE=0x10000000
 CONFIG_CMD_STM32KEY=y
+CONFIG_MFD_STM32_TIMERS=y
+CONFIG_ENV_OFFSET_REDUND=0x940000
 CONFIG_TARGET_ST_STM32MP23X=y
 CONFIG_SYS_MEMTEST_START=0x84000000
 CONFIG_SYS_MEMTEST_END=0x88000000
@@ -20,7 +22,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 CONFIG_SYS_PROMPT="STM32MP> "
-# CONFIG_CMD_BDI is not set
+CONFIG_CMD_BDINFO_EXTRA=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ADTIMG=y
 # CONFIG_CMD_ELF is not set
@@ -29,8 +31,10 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
+CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -45,8 +49,11 @@ CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_UBI_PART="UBI"
 CONFIG_ENV_UBI_VOLUME="uboot_config"
+CONFIG_ENV_UBI_VOLUME_REDUND="uboot_config_r"
+CONFIG_ENV_MMC_DEVICE_INDEX=-1
 CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_BUTTON=y
@@ -58,21 +65,38 @@ CONFIG_SYS_I2C_STM32F7=y
 CONFIG_LED=y
 CONFIG_LED_BOOT=y
 CONFIG_LED_GPIO=y
+CONFIG_STM32_OMM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_STM32_SDMMC2=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_USE_SYS_MAX_FLASH_BANKS=y
-CONFIG_SPI_FLASH=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PINCONF=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_STM32=y
 CONFIG_RAM=y
 # CONFIG_STM32MP1_DDR is not set
 CONFIG_DM_RNG=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
+CONFIG_VIDEO=y
+CONFIG_VIDEO_STM32=y
+CONFIG_VIDEO_STM32_LVDS=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y

-- 
2.43.0

