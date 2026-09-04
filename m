Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4D8C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 10:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AA2E406D9;
	Fri,  4 Sep 2026 10:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5o3pPs9LKGL; Fri,  4 Sep 2026 10:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 50D4540B58
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788516595;
	b=QtU1j0bb66UjgUQ1ha6XN1fsMuNmB6u/216IuiVcYlwUEk6x/mdsuxfllwe6ePVTjd0+
	 N1hNW/PJj5dty6yP+efSCwDUMwnJNq9CsLSHutPmRlo5m1tJN1FC/ejR0uDKBHaSqDIdo
	 qOJlzfAbDBlR0lq/EsKlQ/pSJ/60MufIscgDOSItaRrPv+pW1jcqNj4y47OtPoyfC8gUK
	 FHeMLnoEvLNhK7pxG0+Slbo5vPelEhSYU4YQDk3olS2zr5WvuYoF47p/VyyZQA6ZL7Cud
	 eooZBKBkZV1T3+gtzihQIlPLxnzgNKhV0469RP7td+WquZ5s7EoJmb/k7F+D0C1KpHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788516595;
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
	bh=SFCXtt2XJUy4Q/gpNpUcjVlC8CaCN4KBOS+oMUpf86I=;
	b=hSseOl3k7AOHjRw/yjcVqQz5aCD+3cUinLe7TN/Vx1+xtfde9BdV9bR9zGTz68xwK0+l
	 WK3XcGb5SqajZg/Ak/H+7kzLESlE2YVyQqg7QcvZQJWLN4BSrHcxvuF+2b6lA7b+AnnZr
	 0+fWP+Gr95ZH05H85I9ZpAtYvyS6OFPiu8sZf/2Y51ArMqGLsH469vsfPaC0G7S7oty38
	 1cjT9rub7GHRh5Yo8XDZqT1TRdif3tNkNZqVasfDEpL4jMUIc5CiuOJF5wNePj6jygg/h
	 gxwuYnv112p4xRIAGqvWb0ADa0Y7CBD/9c3hN0LVcTLLTUUOPPS9EuBRlT+h3pPEzOA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788516595;
	bh=SFCXtt2XJUy4Q/gpNpUcjVlC8CaCN4KBOS+oMUpf86I=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bBsEkZfQkBDI/OeSyf+kQYZmAvE9ZeeLV9Z7hx40L74YfhjsF8+wdok5AkEbW/PtV
	 0lupnlcuj3HXrVYbpIe/B2odzxaXy9VFn652Fkkvitro251SL/YGssshey3POfocA3
	 Yxjcmg/Je0+j3q7cltqLSbUxvxb1S35tbCsbXx+Jocyl5epD250ZK7uiHsSoWLDc9z
	 S2MAXI+/iA4o4Vvq6BDryOLwS/muOT7Yuru5S2XqvcvgVCnCAa/IOnTsZ6Fzgum0qy
	 16zatHSFDafxrm9wHUyf5l4DvMoViU5jr4cr0IAYiGsH506dXWWhjbtIdUjUVPvMSc
	 GLOqf7YjNv9bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50D4540B58;
	Fri,  4 Sep 2026 10:09:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F941DE
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B8C3400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wkWPLStkfRLb for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 10:09:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0DBA740080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788516592;
 b=gYWdFV4DOvBGvvuWdei7n2hoFj6OtHtblENY8S8DowkWbR6jsnisM1FqX+ewhq/PcIqW
 e+Jb6tJIK+yAwEMNbkoR4VhC7ntI5OsEO7uiC7ApjlW75I6MTtE+YFaCC04SxJcNS0i1h
 CsY/CUJPa5S0qw6GBECwfCmcLjCTLLfhWUb6wqwZGtptFyEl56RzkiCGSDk1zGCdGwH77
 cjDcvfUaVdFt2eGs7uQD/uu6Om+VqvJocGWXC7XJo/y9bdc1TC/JvbJLmBmbMuIw5l/Jx
 nZSRBHmsJtrIAKu81ki9gda1ZcSwAdSeKMBEmDnPUxdEDac9Ox0e2TKbao8pQfyGm1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788516592;
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
 bh=SFCXtt2XJUy4Q/gpNpUcjVlC8CaCN4KBOS+oMUpf86I=;
 b=o5Gvst/HvpItqQkCAci2aRt3LcQvv7tmC1Ye7Ew3GbPtK7GigImIRm7rCE29m2FFfJER
 eRehqzPTTmn0hmdjN4+NBLoVrTKE3Jhhe8YwmRuaAiACcgVEk4wkA7vy9UHvhewV44OP/
 Eck/l9ot5W0Ja/9jYrrnM3BANaVBQrPkXmFQsDZXtlxTJWtn5VckaBg/YgHadjibewDkK
 QcYV7GqyG64xYDthi34nFJ+6sps58TJlt4SdCq+iaohOR0CpaAw4VieieZw5nJCmUjnOp
 v0n9StzzsieZ1AFqhJZP3wVGFpRFJgUBvQRiHyupu5LXqm8E6nedFkxC/11CHsIU+pQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fwMQv2Xu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fwMQv2Xu
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DBA740080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 10:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veePBDa+buQAmJsGvC9OEwDE2M2fu+BGIkWORUfOfCuf8mrFu18TX4B6T7onJM7gpV8dbVGCPCrwFaTRC9wVWn34Ti2cDMCMcow90mOkIEUGs6p7ms2iUBYb9+L/n2IsyvVVhu6V9OX2YMho2ScRKOtLGoA/QuTdIAy0H5n4qYTQT3JwhLMhm6n4gjSm7Ov093jz3XH1p0I7Bfvbd3GqlTSblBN+XBi765IQFQpkBIOOY7GlpUomFNaGMwdyQruw39Vw+Ew446J4Fg/kAVMwvoSJ0FY7P7wMLzGxFriP+k2ZClWBSx0vNuK93xH1AcIxN0O7l1g14489jC9MeqrCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFCXtt2XJUy4Q/gpNpUcjVlC8CaCN4KBOS+oMUpf86I=;
 b=B84PQMouK/cOwxjlObOaasaVK0+foF1wsb6qbA3RWUREkSkMi3MAVgQk3Z6BAvhjWBqnDQ/+fL7DR7yr7Pd8pcMm+Q49yM9wo6PJZb3J3IeBABkjO4ZOng03SdUTfJzmvK+vB5GNaDVT7QEBCuAlgJ/yZ1f08K2Evl/tl/0IUv4YUGtzXKC54eQ6YLC+HVwQTtxwrnm5W+Tk1nLuyU4eOf9jo/nKSmyxlTTQvY/w75LP20VU8rd8mwObBj4Zhjv5a428uUAkpqOrgJUxZi6Eh3cSJmnlLk4UD3Yfmk6hgHQAdWGPoYA+wuMLRVZbMaaMYqmzIRVY2jl6iApleEDcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.87) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFCXtt2XJUy4Q/gpNpUcjVlC8CaCN4KBOS+oMUpf86I=;
 b=fwMQv2XuVeUQi1TebHZwzDuKMHxbcKsj5mAtJsmCccJHFm41aKF/GqOh+012B6lIbR19PzQCEtuTJR057OSGG7xgX14bRShV6m7vrBWsyOvytY8oGCebvpwDK03FBBEWaBqLdtp6pH+WECjApuSm0U9UrTdOVzRpLtqZ3BvaZlpMKcGT2hY/O0hVXx+yWeTPw6TwU2OrwRcxP+DGsaojulI6DQTaiCErn3vlvN5D0XEgAH2LVDyv0xlNnQc7Xqsd93IlBI+txjl9rGZJxRP2ikmQQuiY/+1n7H20wdEWRa3R5iOscUl5NGxpqtUVaBPceXHhVOSL6VWerf5U2azJYg==
Received: from AM8P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::34)
 by AM9PR10MB4133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 10:09:45 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::1c) by AM8P190CA0029.outlook.office365.com
 (2603:10a6:20b:219::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 10:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.87)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.87; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.87) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 10:09:44 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:11:39 +0200
Received: from localhost (10.252.0.201) by ENXDAG1NODE3.st.com (10.75.129.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 4 Sep
 2026 12:09:43 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 4 Sep 2026 12:09:37 +0200
Subject: [PATCH 2/2] ARM: dts: Add bootph-all in ltdc node for
 sqtm32mp235f-dk-u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-upstream_fixes_for_v2026-10-v1-2-f8b96c35004d@foss.st.com>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
In-Reply-To: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.252.0.201]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|AM9PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f9ede7-78b6-4e84-441e-08df0a6ca47c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9LWa6A6tnn49hK0whGFE4msMVxwNjVjgK3UZserIoaQCZk5BKUutqC38k4DEDSzYMlbGxrlQr9VtTt1UQea9Wfwl0OgKb2LlW6UsOrNSYs/pKVcYHVa+ks0PyS5UlbhdZsEXrsDkoRKYiR/F2WUUuhQ93zj5gU+nmzWY+ksXYnlqzA63Y1k6YNS16zoR05DlFNY+0MOV+3SofYmxmcyCfdXWURKkoW0bCpcw5nLjd6coAAZTGSn2aGNU9jYNYjxkY2r6+qVEp6sauJk1MyRejX2rSqEtBQa9zka6qbzlMs72XyR+/XaPBayctqXthn9Bekq9k7tWZOKzMFA2tXLzYarKXBd8hPO5m8i9m95pVpP5wt0Ta2tqo5u9a6pGhXdAxbGiCya5LYlVZmrjFGtqEEQMyIByjLM0I1ZdMnQgHkGDfEqFfOPEcgEj5srZntxj3ml5epQaH1PaZXuWcrn48L+k0Zi1Zki8US0wWw5KwAxoN5Q/7njVRZTnGWWBaTwDQVc/NdUSsJAiBFxMXDdS24RwtBESc5+b/uVtCrA23o97oryfQBKzLnXtOSIw1VOf/L8b5lt4HPFtpgMUX0p+rsQ6kfTGrvrN8Bohf9/x/1IxzwtlzJXZZbkcWO9mfAhP/U2FOGyan6+KgTYqEn3oXpe2Z7iuC/M19Zj8DqOTCw4=
X-Forefront-Antispam-Report: CIP:164.130.1.87; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OMDIVdUveNjsUsKN8y4l7bmymO1NvjwZB8fPIPacTkfZ0o2UE0KTcqLWV1ebXkiWFTucxFe2HUmrV8YY+/lr9l6drOEHQszlTiZrURBd/y3f9zVlaYxnpmSq9YfKltxP2tPmwFGQ01fKwLiiK5Qe2T+7QCx0UR2JEYxtLAuY5sh6n/xwSonvYyHGSmxr83T0T/NJky4TVe+tdUAv2RdHrJ/8NwfRaZtC/427ZeB4zcF9t+igTZVTnZdcfj7CCprxXixT8MCWt7Qfp0c9R+py93YWS0H+LfL2JhcxYOxHXGeWGmIbdWsAB9uO5tvEKKddzAiV1/hmyLROSiNHj0xUeeECVcDOtqKquddTpQlIlDu63lx7MJRu7c58EDx7yINvJijNU0iW4yRfNlAySdO0BxsYXl4SpX7CJ30dB7tpkZRGF8dL8uwxZtV6uPP52gwv
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:09:44.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f9ede7-78b6-4e84-441e-08df0a6ca47c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.87];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4133
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

Add bootph-all property in ltdc node to fix the following issue:

...
DRAM:  2 GiB
Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
initcall_run_r(): initcall initr_dm() failed

Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
index 2b41bd29cca..16c9bc652a4 100644
--- a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
@@ -19,6 +19,10 @@
 	};
 };
 
+&ltdc {
+	bootph-all;
+};
+
 &usart2 {
 	bootph-all;
 };

-- 
2.43.0

