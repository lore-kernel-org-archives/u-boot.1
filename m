Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC13EC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 12:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D24140B2F;
	Mon, 21 Sep 2026 12:06:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMJwja_H0H2Q; Mon, 21 Sep 2026 12:06:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD17E40ADC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789992367;
	b=OKZWC1yT38lL7+Pn1AaOgKDdBbbgV5WfdmhJLt5He4aZBxpOSIeqIsX9MBiKRQYT75Ob
	 VptNAYNUd6dGGhd5dJYEhCw2yHdz9rPy1NaJKx8SHxFJhafpuEhRlKqPQljiJGEG6/FI8
	 jyb7aAraSoIgyOQTyHkjLcGDXSBuSJIXj3aAkghCQPXg8YyOcCP/B382ZN3UDj9NIgBuZ
	 GS5HXVvuDrMCb/gvD6gQKNfgLrYjHRkmnqAsnvLtoWEjdOD+w7htT8rM8XyZfHD4RhU+m
	 2tjgUQFMONxDMNnDFKNUzti4Lb4pkqROYMf5BZiFWMdLuZoHpl4OQEAXHmvyx8TrIFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789992367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
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
	bh=wrPMrYf8zfR6MDKxyrKdedWlBxMusyE1KXsUKWFHC3c=;
	b=dpTT1oysUhcHrfLdFZZpidy2FdYdmT+K3OsTO4XZi8UQnhXIe0rWI+/kR4p5b/vJjp9j
	 Gpwt9HQi2Fvle3GZ95fTz5tVR3CLqJRoWx8yqZ8SjAYHeSESjQA3CL9VlFxC7Cb9s2P6u
	 h+HNKz3tgMZvurfbUPdcxgmDVkyAcRd/aJoXDI0gBgsHaoqRCe1iM/BSaAw2uYA3U1eCs
	 iegJ9xgkfATCviE4JbjrpCuy+S3evYW+XXeH7rvsfbUDAcAK6RTCBmKx8gZXfzUM138pt
	 w2cBe/gk6vgnnRI0kZaqcXZtv6mg3FytjwlV1uc8JAaJLUV8z1wFPokflJQb5g9nRvQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789992367;
	bh=wrPMrYf8zfR6MDKxyrKdedWlBxMusyE1KXsUKWFHC3c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2BIed62bKhyrx2kW0+vM0DzUlkCfktxP1VYLtpvjpSFxPfTWvGAr/lTveuket7d/
	 xK1EtBb4ieaQK7RgEf6mk8kXUU0B+KbpAMgZwKpt5e3pHG7rVUP4nWWMsKVkUnH3ep
	 +/p8yOpwHPUY6Y0ei1WoXV2xAKxx1/oh4KZScPb7zFJAF001sSUbITT5bZqeq2Gh5g
	 0a5xmf4AyOaA5yBE8lO3DrgstwWiCXcTrkk3y9Dt1fJ9/U8YZhi5oF9rbVRHMgRIBe
	 jhs99wuJ3XGnsv/lgPjSzk2XVGyCgBzfp6Epe6Y2x752nolYCysG1wMMfHLZrAbBQ+
	 Ew08MMH/OsGZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD17E40ADC;
	Mon, 21 Sep 2026 12:06:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32CBF224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 247F860714
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_qGV0OAVZ1o for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 12:06:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E84E76070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789992365;
 b=T06e4pvRzk75ReasKbzLcQ5A+xboLEBVd45J01uG64zqF10kR0f8xU0iDsmCITWbk4TC
 TJ6jCmJYik4gMKa+ZYtNnaKJUswt/zoqOIODC/gclgboLkgT0R4JmhTguY2aS5f2Vhzde
 u8R0LEyXSNs1rHhs8gfEQD4cuZiAlY8aAaI8GoJAJm/XR2O0xrkew756cGlhCTJQSc+Oj
 p8gZosibAWcn+cIhrHEyO3rJBhaEYfw+JtgRAysoIc2XmFQJJEOF3EALfKrupFOmgqtbU
 8GM/N8ZPhVgNAqDAA6NRlAvLUYM16StVdGcn3khM9cB1kHFN8L79qXWZeZDUiEC/+kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789992365;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
 bh=wrPMrYf8zfR6MDKxyrKdedWlBxMusyE1KXsUKWFHC3c=;
 b=bUEUD8t4qdZWgTH0RGgcxWoT23+sxk+16qYA6lKbnBHcRsS3rx8W0lCgSOsdVrIcDljI
 jpbxcwDGFrBjuaEtQRFdSasPrQkUvHCrz2qd67A6TEB1G54GsQVWQVhkx5Sp3Yjdn7k4p
 dHiOz+zV2c0ELGa3NYCUw7/xKTU/MEa15pVomsouZ70EuqQirTy7NeWIPDkh75eKfY+t4
 CpIqW+Ti+eGX1PN0ybJWQKn/1XVS1lbP5cy5fOIXPcdra9QGUUGR3pvjoeSsEWqfqaJ9B
 XPeQ7D64DBUsxxDXxuFGVbnEgf2yZmYSZpB1jFNevYZb36MR/Pisu21JJ2XJDqouPeg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=WB8OsoCy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=WB8OsoCy
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E84E76070F
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 12:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8LG8ocJndXdo/GdYEQf9cYszWopePqIS26CVlBjSA0GHEFQNzRB/iP+hxqBcjUPzer0RJ50JSuzOxRKcHA6LaG6JixlHWPwdUqO2QD1AzCJk/7rCbXtiD4+YKSIvHt0jlnLrFf9i1Rq8XwhCfZUhOTE1PCfZ8mY8SiNm+B+KvpG7uw4UVILk2tL+JnwoYPEQeusLX7dimf3owTVgfatpDBankUlk8rL/JtESdEXk5ullyp8AVr+/JGAyVRIRFC+df/z43saCjc98YcCyAKt/x1c4u1loDl09Xcc4/Y/cTm5dMvsQYXq2DIP+F53k3pPF5Q/6ItD75Cv/7bLSkzwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrPMrYf8zfR6MDKxyrKdedWlBxMusyE1KXsUKWFHC3c=;
 b=x+MGWqpNb6HU+lMf+bqTBVbeN2AqaGPwNqARwduIcUIddiwBWQ1D5xTLraxZ9IW1kV8uYB6AOOfeTmHdbOK6K0AhtlBbYWMUsgtYe6x+8STjEJ+Hma/IRtRICY9Vn+8NR0URbmfU0UXffg7arHQeM1uIYiQOKy0/mPbJMCa5jXXVyzw2VpXdzuMdtkmJED5gye6F/hj9RNu1jJIkijFts11cyg2AmGXmMNYM9EAReQEjlSADtFcN+VI8+iEe2SnWb+DTiffjLOUyAwx6A8swvH/niFsYJnNjK1Az2+sud4Mk/u0GMRr0MEdQ9Z33K/y4mElzCY9wy/LT5cT9sCQ1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrPMrYf8zfR6MDKxyrKdedWlBxMusyE1KXsUKWFHC3c=;
 b=WB8OsoCyVPqrTk1N/BbgBOzDLqfiRHawmjai4aV/g0yQmHHiuBKBKvCfOyeKONxRgqyTAeproTB8cTLAS5A4oWzoxgbPJNrX7K8dr2O3lJbE/0pQXjxFFHC4D4S5IFDheEwPrANJK5WFALQLA6wG/RoMeYxmlNFzn6vO8aGcme+qUFpx7nfHcpxUJtHCDciD0Gda5pg9OiMJLRb9uD3N2uWflPfw22FckSS1mfOQTF2l/rlGN5fVp59a+U7j25aLwD/XxJUiHlNEit3PPv2AHK4ophZ/KDYmrlxLyAZTUd4FPTBX6yK+YRFu5z4DgkGvPzR3Gdm32oMdDb3e7tpItw==
Received: from PA7P264CA0269.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::19)
 by PA2PR10MB9145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:06:00 +0000
Received: from ZR1PEPF0000E6AE.eurprd05.prod.outlook.com
 (2603:10a6:102:375:cafe::11) by PA7P264CA0269.outlook.office365.com
 (2603:10a6:102:375::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 12:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6AE.mail.protection.outlook.com (10.167.241.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 12:05:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 14:11:47 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 21 Sep
 2026 14:05:58 +0200
Message-ID: <da7701e3-73de-4efa-90bc-852e92854826@foss.st.com>
Date: Mon, 21 Sep 2026 14:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: Add bootph-all in ltdc node for
 sqtm32mp235f-dk-u-boot
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
 <20260904-upstream_fixes_for_v2026-10-v1-2-f8b96c35004d@foss.st.com>
 <bd14f3f7-3841-4b99-900d-e9b5e696eeb8@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <bd14f3f7-3841-4b99-900d-e9b5e696eeb8@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AE:EE_|PA2PR10MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: f397f36c-203f-4d8d-f293-08df17d8b2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: y6d1BEJnZjLoaYv8+eUmfLBmzjqj/oz7HJtTUVC38wzSz71qLvItNAok7jdAomJhd8Zf28C8lMkbtdnZHaMZiE9hHn5kE6u5HytjmIMI1RvE2PWupkxBrGVmNG6EqiFgFx/P88KjoRpSei6iws1SZehozO4e+S8BIeAK9thMlWvJqzEB1zoyU0kCfaRJ5QLhMxEXv+y5vux2Jem4lYwvrKevcX3a5wvA+k7u70p/TN5bBHId20QVc6OTj17MZzbkAZN86428S6JVjzXAC3M7ZVZ0KQ7J5fLguDX3y5JOO2kCCJZH2Sbpq38zRY13/Xckb3mHF95P62Uc6Mxje3LL6Z8AGcRmyok+gIeDiZlQ0p1if4bUeGS7cdvSM/Px9zPTioLphrSMtGF15c2WhHOw5do2WRMxeNrUSTWHWdIb/RDZKxdDrxcWJvd7xRTsMydtl/UEjigvvRCN3cTkIOsRXbxLWwIo/kSNqc1DxX1GhjgYjAKAH9lYpekxAQs9ex82Me0pdJUesqoP/YwDK6zDbLw/Aka3WG6gTBevPig0a8VaHnJT8mACAmkXGzPKvrI0Qe5LADXQVIlR3TN7N6W5rqnC+3Sy3CM7oNDTA1i5oG2XVNswqGs5qzSpT8JIGq30gyGaZqHM7wSwxGeZ5U/ZWNIe1C2h9G44PPtBccaTFU4uwHBji6ygMTzIV2HP2W3wgjtoUzGi+VJsljXW7j+XIQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NOXxmJiOlRzHXAUlMPGi3VxQs2kJGyOKO1StMamwXsv5LTCWSnK/e4w+1shMoLuOfhvBiro9G2x2D5BUDHQOZBYBp7+sATmvtdDy3JRGFTI873WNubc4HS5F8JoQGKRHVN7oyp80tny8svzQZceUTkGE9PYQeukE//1Rtj9PvPNiYYHmsJGZdfvrr0n70S8bTTAjvmAPO3frPXcvMpS7MOlhMTYZqFEIypfzmMCgWRaN4/3V1pW4flcSVXbE8HmwfK5PPbN7Dpj2jW79iyCbaH/EKHhw2lOcHxE4qBWbxb3UfzVHYKnnkWCL6nls2A8OluQeE7VD4kToMcUjFqEebb7l5rWgBaU+o6ntiquszBZLrwwGXqKfSbEfa/G7DbOAYjxzNRufkyd/YsyhIlvCMTwt/0MWS4Kj92w8XmCBkVHzFeXR1ZBzN2MzILQ3jsUB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:05:58.9756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f397f36c-203f-4d8d-f293-08df17d8b2dc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9145
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



On 9/17/26 11:37, Patrick DELAUNAY wrote:
> Hi,
> 
> On 9/4/26 12:09, Patrice Chotard wrote:
>> Add bootph-all property in ltdc node to fix the following issue:
>>
>> ...
>> DRAM:  2 GiB
>> Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
>> initcall_run_r(): initcall initr_dm() failed
>>
>> Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> index 2b41bd29cca..16c9bc652a4 100644
>> --- a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
>> @@ -19,6 +19,10 @@
>>       };
>>   };
>>   +&ltdc {
>> +    bootph-all;
>> +};
>> +
>>   &usart2 {
>>       bootph-all;
>>   };
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/main

Thanks
Patrice
