Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62096606A32D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fLxscDY0;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=C9ESqiRP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36A6F81138;
	Wed, 21 Oct 2026 08:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I4so30NZMztv; Wed, 21 Oct 2026 08:08:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54EB58112F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570104;
	b=tMLXRzU5a5rtvxKSd8YaLybqAc5ohA+xlonmkAParDh6wzNbT4F3Y61ANYsuGIn2Q41k
	 c7UHtPTPVdLARZuga9ni46T2440KaU0zj/T5HCCit6oJa3pe7jCE1B3fEIT1oRf6vB3Aj
	 TS9ilf/8e7Kt0gZdMlw/VAVof7xQM468g4aGLEgwytp10qbzgGhdJWbTJuLy6Y5+FAecE
	 9h4Ez9kRCcEImKKtulJN5MGiUfaK4M0hPZXvtDpDLUClxUeTHGOyh1AgVAje4e0S1c6p2
	 GIq1av5fWBDV4bcELmIvF0c3XsrQ/pM7kEmVH51KKTPv0QViAiZMMjIwXE3BLMpNUFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZmFmThp8iIfjQjeVe2HM7xV8zum0x+ernhx3zJxncSA=;
	b=NDHMKhQLPQsM33XCtBmds0whkt7Bvx2Dl+W7QdX875II0XpQgnRARfwgs1LRJ0916Ar2
	 R0tdFCxBnKRB+aMoA7aWh+OBWImKwKXzjN0XVzZk+SeIP4dTgNyA1+FEjbXyJD2cU1Zkh
	 ma/KH5RBsEi3jotq26o5+IDP8sLLitp+i2Ix3a09oqMN7FinBMUVdvR6AqAXw6KmPGley
	 MPqIHd2gSxodQGL8lE3BWdR0RlmKTjB/K3yaydZiEV03Uz217UtDMOM+7BlxoKt3jUxbs
	 GMCrG5x4WZcr0BGeRLNfig9GjR1fXTKeTgVHqKtOfNfyLPGpzaPI3NH36KXBODVxlfw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570104;
	bh=ZmFmThp8iIfjQjeVe2HM7xV8zum0x+ernhx3zJxncSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fLxscDY0cF/SQjGzdXPAyQJ/iyXSOORFNEwh/vHqfLQ9xaUHLYNGtsxS5KXmnf9UV
	 1hq+F2mdZRKpUeJtQb33xTCP1qKvj31RFjgflNXdPBAwyRxKcAd7SahBiyt97B0SDr
	 dI4oqgb8CI3qvyg/ZQ5MLscJ/uxvabWC3lj29YQL0Oxd7S+KQLwIHg2CpXHHfJbCzZ
	 NSjg4aMDT3/KClMJvwCAxKAXYLkMBIFBsnGeQDERDkflzHHi8EE3Uz0mmsSKMD0Yid
	 fR4owVDyJn94LerKqpC3TpyqhXUTc0RpWwHXJL/ZPqzXF5VgzAOrGKelcbg8zdCHxa
	 jRX89Gkr9Hk0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54EB58112F;
	Wed, 21 Oct 2026 08:08:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC5BD769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2E2540077
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJHZm-rvpz4T for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5148A40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=h+ps01SPCwluTM1H0dfzcJRo+gnaJzte0WfAs1hXSJCB7R5t5u0y5FhOosshxfjY+P3E
 FOb3OAj9cqZtkFgkULehDTC2hHCUtQLEjNTaRxdLTK9LgBlq2VzmnFG4tDwacK7Z2PFQc
 VGmYZl66I7QC77A8THdWqIPRikgD2OH6OGgdK2L0LmQhMcOPTGen92TY13WBppd7+1u/W
 wvSxxi27+F4yu5BbM9F3w1O9JOksNRWkpp/5oPxF+1m6rhORaYQ63mMybFZBJgXJ3Or8Y
 4/BpS8EmBUCQlL2HueLoUbi6LZO6zIZNR9WyPw+oCgDmEayw42oAWnSgrzxIQ2NokjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
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
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ZmFmThp8iIfjQjeVe2HM7xV8zum0x+ernhx3zJxncSA=;
 b=LukdK1yApv5WVEDVbkkU4WVJanEHicsEpwW16F2chpYHNkHrH7PkwJ5Xa74kTSyCCYIe
 TqFlqej5vQYhsRIFc+71CUtzhxCbNuCdRGxyCbVjuIjr8V0CFOnUe5TwvzvRJ9/x2CmGY
 ce5ABTmqOWOaBLgmrP+dGcf51ymwSCUA4sL3dUt5X+Z8IPZb3XcebIHLtWS/wmbUq4+nH
 xAFsPh191Cri4WuDNmeSP8OHjgA695TGmqt2cWRjyb+kSYeJv4jN8HB8U7/I9euMADTTN
 VmzonEpCt8KFSKURjgSVH8Zr9kbXCRkJW6+eLX1N9FV3MkTLp/6feAAsHiRUBL71W3Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=C9ESqiRP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=C9ESqiRP
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5148A40050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDWRZ6CKStDBi0RRugjtKBzqUDOAqA/5nXzUz5btCCOipTBRxJv9fqQtm+CVxPL9AtPnnP44PrcDVMoqOdu+87jm5w6QkHjuf69krAgIDLNfBNk2VFL7Pf+FAoGESpRqidMawWw7UHVQkI9h/RqplB9Bhh+Qx3yt/d5r66GJ/99dX1zFCncl0PbNlqcH4Onp0+u6/eUeMs1+6FE6KnRSP+Uoj3GKXz1k3wAk05upEhQZe1ocFdYrj4FNjmgcQ94Zsh682Fmb0J/yrkLzaOr68EFWuGW4dz/boeyrCzi+XEQj4nBhW7bFmsk/qXfuNY5GnjBu08IX1hXtbSkWSJtWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmFmThp8iIfjQjeVe2HM7xV8zum0x+ernhx3zJxncSA=;
 b=y9ZJyBtNjQIQfDZ1RqKBgCBMN8SEyfZxy5VYy3hFlZzQZPkuQvZ65EVHVZED4Ab9yi96L8bHzMJArGK/TB/BAVtsgGMSzpKZoDfqmshXCwTnzFtS2QqlIhrk8Om15JwL1lzWLLaheXtgpsTZrfWDTl8o3HpBAr+VYzhpL/ZrmFrr+/cs8Lz58b7dGe6vYc12FURNxnBTIxtv6Y+Vij0GCwhZVqp/P9iAVpX7SSz9in9qvq671yDemnxI/FISrtcm5JhP2dOk6tkv3SygPMZJNOnCqenqEFdFMMF7fFZ4smBIO+1xC2CI/skJPNUZmMTuF75C+A2cBI+1MXtziZXdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmFmThp8iIfjQjeVe2HM7xV8zum0x+ernhx3zJxncSA=;
 b=C9ESqiRPDRHlLIqgQ+ufgI3TR8hAD+JnIab0MIFib9xn7rksm7q2RqTwLNWYqrrTfqxLOBWz60GVnWzaXTxQQz4cQPA3nxiBoaXnKY1Dx/bnSDSMfEqTziFEicWJFZLs9DNshQ4h9bYf0pPPYg/SCB6SM4UTZO06tke7KSdKyfkkSidnvatnGbEoId7FyV94wKcE3oPkMTOPLVrpxduo+7s3WAphkFaCtkpHyKVN7vrJ2hXf0Cn1tKJaVjX5hQdBFKVZ63v97wS058hJJhqxfzJklrKRWFUUT0TN/m4eo7ZlVnUDO88Pcjiuly8UQ5tT6zmt1cHvWgwFhBiBEqLJFA==
Received: from PR3P189CA0057.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::32)
 by MRWPR07MB12396.eurprd07.prod.outlook.com (2603:10a6:501:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:102:53:cafe::57) by PR3P189CA0057.outlook.office365.com
 (2603:10a6:102:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 531BB200D8;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:14 +0300
Subject: [PATCH 6/7] watchdog: sandbox_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-6-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=1149;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=YUb926ZAi8QYZmmCec7SFrLnhVt41bBV3ivkIcz4dqo=;
 b=3o9Zv4HMixRE6SlDUmVmlodUQAa+sZpVzK8KUCyquK6LE/ssN4bD9U41tTufnm9yOsAqhaTeS
 OG496VvhB3PDv0A+If9bxavOb/tCqyIEdL54tqsR9AhTccacNHKjHEb
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008556:EE_|MRWPR07MB12396:EE_
X-MS-Office365-Filtering-Correlation-Id: fd37c1b4-1db4-4a4f-33db-08df2f4a72d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: cmLyychjJjuSjnOHtUjxGox3e2++cbA2tyJJRgyxjXmIUSok0zD4Dqk4sMpEf0GoRS8OipcePVUflmKtNhtRJrwiJ5ubgIp3SmCyG9PpVACSR+QwpCV4xuMGydGddfQnFlA0/BSnMOOXOTo4X3yTKlcWBVdeEBs42nSdFxcBVYHClQSEyAI1Can6A4BnIiS04WhWauWOt/NxvjS7P1d7r+5hNSybibVJU4egKMfQZPtqEBrm5sV72TAo+/RekvxkBia2VT2+Yzaz/ykdydtCbmZXwfYCf/cpkc0Efy2OHSj/eK84K4Yih7PZk5CMMfnpovgMOiCy4vz99TOu7AgHXp8CtcOYQBisCoWsHghYFnfHW4sYse+DLD1cJieM+z1fZh4VaZO8xuaLnw9fEXgNCk7ireycXvKUzXOepzLhsfUV+THuqLJyQxOzcC4Kh+o+CvxbXsIMzR0Yjgdmo1IuQQc24edDx91a4aFwMquVOPzcFNoosvTdgA/wwL//r7tPxiesYfQWKD8yKFIP2kFHwznck2hdvsZG/5oAw5FKZJYAQiG+0FRSiOIkVc/xrO6Em9pzPyVymXIh1GQae0snt1k5/UOsTKqor0Fcc20qkOp9A71NvtDqPj9ucrxeoDd5Bt/AP0qmUeBJCyU6afBSR3XRS6c4qzVLP7MOLnN7fe2cLgVAfGhVI22RfzsO/FTO
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AGcZ/vhGbBGtcX5SGDEvp761fKPepVCx/PhqiwPUapV/S+LI8O9iwb+uMiVbdHqBDLaYX1CV/sz3Ny2i9zyRvwU+OBslAvPKF0FV23z14mzR6efDA4V8WgcUUH30FKcd9AT+WSTtc/zk6WCjnwC8ffzxVPZ7IwUvnCAHhtILcwcKJGYmn6Kug8T/uwkur6npMurKkb9Tqusul1zioNHYL7JFciA8K7kmjDtA+PSr57GBO1v+PvuVnp4UC5EMxPjN233ESPnzWrp76GnrhZQGDAVAlQr0aXIrTDvID5uiW+09I6Q9A35sSHrCqoKZc1OcvM2VMHlhp91i8bokbORHwG/OmjX9Zs+qFGXJtJfI8HJg7RRY1trwOKztEfKIE+j/YDdWdwmEUmtz0K4pg+EN/wDHM1HRTmLMc0Lj35JJN5bpcnKdPn7B57rlB7MHIQDH
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.9396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd37c1b4-1db4-4a4f-33db-08df2f4a72d4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB12396
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the get_timeout operation for the sandbox watchdog driver.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sandbox_wdt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index 9a0cdac232a..c9a7b845897 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -7,6 +7,18 @@
 #include <wdt.h>
 #include <asm/state.h>
 
+static int sandbox_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	struct sandbox_state *state = state_get_current();
+
+	if (!state->wdt.running)
+		return -ENODATA;
+
+	*timeout_ms = state->wdt.counter;
+
+	return 0;
+}
+
 static int sandbox_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct sandbox_state *state = state_get_current();
@@ -58,6 +70,7 @@ static const struct wdt_ops sandbox_wdt_ops = {
 	.reset = sandbox_wdt_reset,
 	.stop = sandbox_wdt_stop,
 	.expire_now = sandbox_wdt_expire_now,
+	.get_timeout = sandbox_wdt_get_timeout,
 };
 
 static const struct udevice_id sandbox_wdt_ids[] = {

-- 
2.39.2

