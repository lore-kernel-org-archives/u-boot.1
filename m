Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FCC61DBE
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DE4980EAD;
	Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4jqbmK5Fn6r; Sat, 29 Aug 2026 14:34:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014081;
	bh=1FdML7G9ZpjcYM6F7mMDWsVSlivBdHAWHycD5nfdWOY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dMHVZV9NImk5hRMW8xmu73WLmJ+ecxuO0u4Hk++btaByYcrZZHUw8UN39v3sujuWm
	 pLVim5sYUKwM0Keug1IeYNzlEMrnH/KWKRGokjipDS9jtCAH/IrUoylSUQxXnqrY4D
	 xhEPifqm74rQncPMhRRNXlR3hhVcMUmmMmAqW2tWzPqk803tPpZQfocD/w/46iPQBb
	 KZK4o5a1vJOxxIo7o2Y7G5nbkgnsn8yM0vboUg/es62QQ8+sQZOQm0AfzwD0gL68OW
	 A/XTKouaEfdKBabxpvpJopFPqU+1BtxEjiaavq6mfi7b419tlgVvQsJkz7w0AT0XBD
	 jrceql97bxBVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D511580E90;
	Sat, 29 Aug 2026 14:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E9C614F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E899140098
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6vStcOSpgQk for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bxU95443; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Hj9pZR8f
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB66940052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:32 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TDxiMO3258556;
 Sat, 29 Aug 2026 09:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=1FdML7G9ZpjcYM6F7mMDWsVSlivBdHAWHycD5nfdW
 OY=; b=bxU954437utQ888VIdSCL5/IC18j3Nwoc5LAFmJxxj93+ER82YfAs2YXM
 xJOQXMyEb6uDPzqcnLsphZtq1k4k2JWSekioLxs5wHws2tpE9Y9fMb8Zw/fHjZtp
 nQ0MCOL07O6O+YwAw6hZHB84B9gAnUeNKnD/TU65xWy1hwZx6i7OBFLT9OiZ/u1o
 C3d2jWBw9ksnRHvrulashA7zkiB2k2NE/YV5PZoJyoxbJAfBNwZZeAX/7yRjVD3X
 GTSfRWxBWhgbgJAtmzp7y1bzWluufLD6nK28TwmsbQIm7cZ5whaQfBT5f7gXe1sr
 S+iLagjlJp3Q/smHlwgSio0D0CeUg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gbqmmhqs8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvH30ov+jE9R2+j3FOotzLy5v3EiWUCkikf+6CYVwkNWtDXKqvxUeSeGVZyAfQeow9UgAjkkIRfM7dKbGgIapOqw51cVsJlOwNCbjPfy8h5NwjvCxhPSLFo7hbm+lXZWAOi7l2KKjp12Iblef5U5ev/Eg0RSd899IuJ8WrO4YwaOn9+2ws66wqBirEGcozYA6wBMGcb8N17wP8i06rArZDULh4YDl0ZZ+V1aVMT/dl8Z2E8yjBRtLljWJADrHhOW3YZjo739PBbqxOWI/DVPfk1L0/ilgnsLvROVv0evKj+yWz/sPIToVQWyUVrhsxnRx3TRsiNdLPnYzm0nN4F14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FdML7G9ZpjcYM6F7mMDWsVSlivBdHAWHycD5nfdWOY=;
 b=eTHZYKDnKeNV7OJ3hs+hoEogc8CyzB5aoSV6/i/+PSiNFZyN8Duh0Oojo5MiPDhLLixnux14bs2IK2gIHCEplmv919HOYRtgou+WPhYrxDkMJzmk4x5Qy3Fqnbq6MaFTd7o41NkGScWyNSjw+xEUYp/BapS3Pe5whKOvztcLDN48fbKuscX/q90T7nIDcagSlTMOtQ1otX9U4Ka82+islIvcDC33YmLKLX2+EqAnq71MdX3WOj1Ss53L4ffkq7HFWzzijSlbH96Rnv0j0lDausdKY5CDLtVSG5cs2g2Be5M2HPcZ2yYpnJZcV9YQzNT9NlgX/Zn648sR/MCYA/1cfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FdML7G9ZpjcYM6F7mMDWsVSlivBdHAWHycD5nfdWOY=;
 b=Hj9pZR8f1fMa3FjyuCenHbeNCp0tzT0aKlWr5bEPmUdGezllsAgtfpL1r5VRnYTcWqNYK5OlEofAuBALg8Cu5czMK0R5LPmH57PIf9Kb4kI1GBt7ej1Byqke5GJchdZ3bhdKd3E82UYEel+Y5JApLTOUG+xWL8ZQXw51rPdSImA=
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by PH3PPF730141699.namprd10.prod.outlook.com (2603:10b6:518:1::7ab)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:26 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::4f) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.5 via Frontend Transport; Sat, 29
 Aug 2026 14:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:26 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:23 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYNOM530315;
 Sat, 29 Aug 2026 09:34:23 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:21 -0500
Subject: [PATCH 03/14] board: ti: am62x: split board variants into separate
 maintainer entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-3-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH3PPF730141699:EE_
X-MS-Office365-Filtering-Correlation-Id: d12e4679-a626-46bc-a819-08df05daa076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tLcokhI2zTxJY3b3MjLgBk4mk8LO44/cTH0f7AjCCon9vB9h0gvBGrkCw7QYY8cN6Zk096t5+qJSSIwvzVuTSj3EIUri6S37BYsuQuTg86oMhW6Gc8JTPf4P6OhMVgyXgBexOGaiGMzQ9Q26N6XLipOkka25Rvm/XWGuSgRWeG+VvXKls+K0J/0pkR4XAwAPI71763Gkz/CLMciWrMfQzQMxZE6DwsKEFORodfmzXrJ/7nwl/iQeDmaGmJ7ElmvbjaRQ/YOLBI0py2OX3MUUVorTVzyTkqO8fi6lakFIqPNvkWVYvUXqRjsvZ7TnWBRaVO+c3uAtA/uzYdYZ6zijWoYJBHkEHM061D6MTmBztQssImuC20jKxBA8fsMP48HMIAQqzF0Ybj9/aMnWJyb4zgWAE4AJxYKXyoxxmyzMSDn3SL+HXh784tFi45+yXaAAYt9qHQ/17FuClAcqP3P1w7Y7yKseL9YkR/p9oXnCbTZ4PhA5+5v/x63F+1LwdPQAoC5LY610/EzARDLaLs5MPYx54dgGzMQkL3O3pTOM7FI+y1qMFqr5BF73SAgEpBtnvmNvxi8jYb0UQm6LlXMQOIlTWBH8pIH9eQOsRu7gRBKbko+W7tBrNYmN/nBl40XmCIl6R9rNMUuyS4vFmUK/V1zFAHwbtzwfi0QLe40XtCyCr2fLtuHC6FXpMrZ7jBBp6WnuinE/Pjxsk8zcSld+rw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y+RCL/ll0KNY55vnTIeJeGUtpwTh7FlrI7hYyAMgfXbS7xGZgb+xE2E/CDsOm/VcyOPKJ4k6W4q0sSEKpo3piqQcLlNoPYIIYLosIHhKwWOju0HgimDY8CNXtAky0ISH+z+0ytVSa31HXIsGhf1UFUwg3DqcCBRx4aXLCtmg4fqnXmZH+KOkMvWeyCZ07aytSt4rni/SjMS0ZqPlZ6P+UfZYxE0z0qedWSwnlNmkqGrp7S+ohgkBmyhZzCT+I6qW4Wx0vIfkFqxuFsk9e01sT9EJdFYrKKxcJ6osvPbgy5MzktVLW4wXd+xZVKem7bbSbHyjghogN0eRQQf6dwqqqcbwKTgc1iKLkmLoJTRgODTg+szKu5DRWH6UWR29KGia/oocJ9YxSHM9NS6ANwLNVXWVIsUTr9A5EKZEYM/uD+bM+mBKPjDnyCwZyR5XHVde
X-Exchange-RoutingPolicyChecked: 4GqKGRWAvZNKDuSYo/1H9C0rxIFlFVBpuLkImnZqb1CdRhMCcFZSqYd17AlnjU2UcB+nbUilxqjbkmk5/hOtqRk6njx3x/Uw9KFy+o/PWBLF3KHlGH8amYuDzBAbs9OQiqp2MKwmh2YjSLgDwOUu5ppYe2QlSbcgWHh8g9pAKSMaUHUOZGyrejE/HtBqoAyVHxY+nx0vJMJGAZL5S01n2UHsjss92L3JUttHeetcUob92pbNKnUPyWUjDXfSom72wvsZFrJZrsKJVykkM9+CThrg592gcm8PosafXsCAUjT/kLVVwtbjXJzH/CHoD7u0SRFyTXQK1wdtuNLIHoKJ4Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:26.1702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e4679-a626-46bc-a819-08df05daa076
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF730141699
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX6x6CXgaBkGaq
 6KzxNP71+Q6UnG8mBx+67loYaGNEsPfvU8wYhME3sxE0RCfKjuMTxJHcQFjxVOnmxUluFglPbb5
 zG84luIfzDl3uPQy8O8k5KxyhLSBKjlfpq1i+k0cuJX87Hc6Cn45/c8SdaguTvBgdrdgoha24eJ
 yTsxXL41whf2J10TAzkXPFGt58yEn3wk0iahUkZttSxGWHV8oQyX1ubpns6odsr/OdmyXXG/LlU
 TjBu8rKLbGHQE/15IFufnIzRjUwdq/3s+2lHQPoOhi///hfLJFf/dffcfANgGHHM4gqcq+euzo5
 qGujexdK4zDD+I3c/NMcplymwNSGYruy0uJV9VjIQmQum3sn/SZSxdwFkYKtAbXSm8XcH+bh92k
 34Q6/T1aVBa6PPLsxpLCWqKAxHCckak6R/4JJV3s7FuCB91p2UksFRSAIX6wGQEy7BeW3XLIa0u
 4+zhisrsgZFStKwJLgQ==
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a92edf6 cx=c_pps
 a=zWRuVz0++A3eh/KBGeICZg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=mU6n_8P2ET0AWpZESegA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNSBTYWx0ZWRfX0pPLqBoJfvfe
 fK2ATW9Yy9LTgvuNVuNBFQEaw9xpgK16v6kHOoxWy4pBEfo9PsDSKjnP5VwZTLKIo3BhMeySoo8
 zE5i/DYphuX7Cbm//6bKNOgyfGArRGU=
X-Proofpoint-ORIG-GUID: 09ywhjFbfRPibgzgurTa_aUsAzLafMUh
X-Proofpoint-GUID: 09ywhjFbfRPibgzgurTa_aUsAzLafMUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290125
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

There are three board variants based upon the AM62 SoC, The SK-AM62,
SK-AM62-LP and the SK-AM62-SIP. Split their MAINTAINERS entries so we
can better track which files are needed for each board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62x/MAINTAINERS | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index 31ff7dc6522b..295f351364ee 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -3,12 +3,26 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62x/
+F:	configs/am62x_evm_a53_defconfig
+F:	configs/am62x_evm_a53_ethboot_defconfig
+F:	configs/am62x_evm_r5_defconfig
+F:	configs/am62x_evm_r5_ethboot_defconfig
+F:	include/configs/am62x_evm.h
+
+SK-AM62-LP BOARD
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62x/
+F:	configs/am62x_lpsk_a53_defconfig
+F:	configs/am62x_lpsk_r5_defconfig
+F:	include/configs/am62x_evm.h
+
+SK-AM62-SIP BOARD
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62x/
 F:	configs/am6254atl_evm_a53_defconfig
 F:	configs/am6254atl_evm_r5_defconfig
-F:	configs/am62x_evm_a53_defconfig
-F:	configs/am62x_evm_a53_ethboot_defconfig
-F:	configs/am62x_evm_r5_defconfig
-F:	configs/am62x_evm_r5_ethboot_defconfig
-F:	configs/am62x_lpsk_a53_defconfig
-F:	configs/am62x_lpsk_r5_defconfig
 F:	include/configs/am62x_evm.h

-- 
2.54.0

