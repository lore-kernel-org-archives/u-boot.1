Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A633AC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBCAF405B7;
	Tue, 15 Sep 2026 15:58:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PS7O_m-WScCQ; Tue, 15 Sep 2026 15:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0147640525
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789487913;
	b=ZfLwi5s4QufalQxHZBWjBzTnEim/8JxOLTpZI9Sa4hZX2mxu2f3+olWZLfQrgtsG+sSS
	 E+j0Xhxg3jSBD5ZbR+IFSPoU/ZabA1RrvZU0YoonBqSWu41A6oAdQTYczNDc2aOUK4fgS
	 aGIITgKRA2GT9ipnKyS66O/zaC6Ag/zjfYzJ+8hDZNmucQTzOWkf5RnuSM1zLkd7u6qpF
	 ATLk03l1+BHK6Y8PIJghYfb91mxpxa2vOyE6hVEYFsHKPW7NX+S2pk8/XoHpRSBTpPWxd
	 YCxqbMW48F2MRjb5zu4J7Ugrk7OHc07h5lYXgvnqv0aYRkpK17oFoPJtPgsMKoJxvOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNaOM=;
	b=CxEtLKkWc/SjZI6goosPwVJwM/SrEOjmTg+EvUf/cyyVxF2ejpuYvX+3JrU1xKvJZUGg
	 i1hjbCI0HFVTkzFTdVzqpGl0t5ZDFQA57jYHp5q9El9vvH1x2LqVrOwHI3v6q9psibcUe
	 nU/gFYNUfl4qoLtIlYxOIfV3hFD29ZyjJ5TDOGYXFdjmRR7lTZ53Zmno11nJ+LZeCJHuK
	 TTxKEqwRiSrn1KOQ4sEe8pwlpWNAw5U0oBHOCngCvq9BirLy5AHKYPQiQRa7uti2ysaYd
	 YB2H9D030yFytwAvJMofDGL29mLXG0naWbPjKz9jIBc2BGjMpadmDeZ1C7QaIQQJzjg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487913;
	bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNaOM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zN/7nlzynCRHrbwSiU5kTU64mlNMEm2JH8CAZDDpCVe6Nuq5Ar8q8qQpbbywSrf5o
	 3y3SSyHzKuaYWaChZWR4Vdxc7H3YHerADEc9H6oKOEJCK5u7pcnS1KozrvbEyqXRO+
	 7pzlofkbNHAWLkwuCdILwtbCBX2XaERcmCXgSBBIfaCBfGQZsF4JlctvrRfmac5k4u
	 uvyqqHd+9H6Uzh/l33soL5WBzrlR6qtR/e+stHhdUxmzHSG+ztcURWfJ+gP/9eCcDy
	 pc31KW61QKJdy1STgZCRcrP/TPaeEFGCDxVFQAzH23UecgLTkQ7aWmozR28jlOoiGW
	 Coe35wGxw8y9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0147640525;
	Tue, 15 Sep 2026 15:58:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21D76109
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12FEC80980
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFyr6sISMHm3 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:58:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92A8980956
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789487910;
 b=OIhOkdhAYyUjy8ZZ77QEphvMFn0//PPAXR/8+9a80zZmoSfOkL3PzCmWU3LoPSUCpZIT
 +d5nIq3Ef7YwrKjxIPWYNuxPOp/bpDMuCC1x+V8pjM9xeDEc3Dfr27l0cQD4aJwMNwxwU
 o/XZDHxvAt+pV00C4TntQKXfwU/G5LQ/vx2H3mX1k4EHmP8RYZLYRVbNaZ+Kv/dZljZd3
 1EgcZPWxyzMXlxbIixLaG6BKafshi/MlDFaAmyfGw4nkVKAecWo8oBE4NSSSWh7H8nqiH
 LHQLPc4zmoxGOUQCIfqufXZNFnUH+IZ18BrvQon7JI9wKFz8yfJxtiOYHIXHzGSIimA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789487910;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNaOM=;
 b=oYKt7Gp4QD7sDRgh4ZtUwcKNWVq5ZCkC/vT2XqwvMJjtIZc6AJzrYI8BBe+0yw1coHzi
 PjmOZUbwrVzdsbWvgVHJ0JHT3ajbH2soFx5CMmmp0t2ZhEFNL8oMBCDqy+PEj452/XwDg
 4PG+vVrV4OfDOAedV37TxqPZUh64r/9dEn+5bXI13fMLfLfuotXefNT47Q3kT6MzVbL+/
 1Bh4y71lNw+P0btEwUQIYbW8ghbhb14Hpd911KegbvWawm2e+GuuYnQ7ejsl3/6GSyfoP
 Zz0BZSa6pKxv8VotF2dMbJMV9FJ77MKc+WvpCxxPcXqV6TaZ20hI/PEcMUMa+HPiIAg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=RZMyZXEt; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=i6eih2aU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=RZMyZXEt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=i6eih2aU
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92A8980956
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:58:28 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68FF784m2095676;
 Tue, 15 Sep 2026 10:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNa
 OM=; b=RZMyZXEtlZ13w9YE5nXzJ4JSlzA/33mdXJIXTXH481wDrOwf7pMqvX4m3
 /g1fWlmdtuNfOIBNnx9hfJI6wkv38spASZWiYah+S+OIO95mYE0VUUHvgLJi13Xy
 1UNaAZKJYG1900VbtbQXB6ezmwmIl5nXTs4V1wn/78gQKFJo2q1zubS027h/rHnL
 lCvwBJWz6p8Dy6G4Posx/1MOhJD3eHOH5QXolxaxRF5UmowNBUjlE4+OHo6oagds
 /pynaK0XNcBZXbJ22caQXnj+t49q2g4rDri6IQXOw0PeLcS9XXxhTWE5w7F5l/el
 8tcu2zT8ryLlcoIuKplPLSUz4qXCw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa4x54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 10:58:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCqdRK0iwqWZOVXMnAbaTpdzvQ2lnubHn3cL5E/upcrbv8q5hLrdHXJctQAI8xcbzqy7Xhj4H+BV5dMI9QTnF3u2ULCUi87CvyLmA3Vz6q5RFmd6D9e9ynJXRHCXc3li1Ft2WD0Bl171qTyGEFkZd5gMd87Kshqcg4A7YC+r9aiOaD69j6W7uTioyoYMoXdDkFNEDBZIRXRb4nfwlc82rbB+mXOOC9m5vXJsWaj9lH3sByu8QbDPrZ+cMMiv/Mx89b6l8bKd79uHe6gv2eLhKe36KuGRHCsP9iG/DuRzyCJLiTsscCzjRCwQbuZtldleQvvrhWrioqEu8CBz5DrXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNaOM=;
 b=n40j6NytgWbxpcD6HPTo0lckaD0rr9xlDzu5rmsYQ0X3FyLWOSHPG0PKwbBRBHqHSqkSr9nYn3zlAHU19VojODMDwoezqvlwqvTZirkb+6ZCScZEnMx9vt5ATG/ubfc3cYLt3fBqq0apTZEmkYSz+LOBRZ8RPwRiDUcWwU65pRYMtwlFY9Rdg54k/HTPeKkRFQwIpOJLwVkyWyZgxCJvxQRCqpcOnibfhCNWuzdHz6a8P9hfF7d3aUiz/ufZQ66YUo2s/TZJNQnRuNRq+v9QGDJ75p7Rr7ZGbPoK57OlwFQafrmmOZCD1YEB6jIh240b/vp0ieQLwo9uQF4o56TXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxOAmADW+obmaKDgncEPFqxUtxHf1S5b4fdekmCNaOM=;
 b=i6eih2aUYl7PI1o3tcHqr5VMCaqMe6tx7fQEWQi0Q63pDTspXXsPhOjNpDkRvEJX5fYNGyZ2m/0bPSlRbXLewPVqgHZvHBTi3xgopx4Bkaf63ghZJ1rPkHybkTfkd2yYwuFhNn4qb1XY5MbUaozDvV6csbnt8vdVFVg5DAxbSmk=
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by IA4PR10MB8447.namprd10.prod.outlook.com (2603:10b6:208:562::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 15:58:13 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::33) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 15:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 15:58:11 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 10:57:44 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 10:57:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 10:57:44 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68FFvcjL283497;
 Tue, 15 Sep 2026 10:57:38 -0500
Message-ID: <e93b8a5a-8b64-4806-980d-ea4a0e580d94@ti.com>
Date: Tue, 15 Sep 2026 21:27:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] arm: mach-k3: j721e: Enable LPM resume flow for
 J7200/J721e SOC
To: Richard GENOUD <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-16-richard.genoud@bootlin.com>
 <989dd99c-c988-46bc-8833-8a6f3d651684@ti.com>
 <b5556ad4-dce0-445d-bbc5-bc6f27a52abb@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <b5556ad4-dce0-445d-bbc5-bc6f27a52abb@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA4PR10MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe0b3e3-fa30-4b2f-cca0-08df134224aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Mei6qwcbmmTidmsbMP+DiS7csO4a5sO/ZE8CMS5uDrBBs9aG5VV+otlQegf06fF5GlxZt9OIuEzVV4vgnQOBiOpkP35mUMrCQWBR65Lt+ro6f0600scdq2GCN0WemrqC1FytjgM+IQ/r8YqR8G4YA3lVS5JbESEsaQ/aPCbw88VB4Pjmhf2hbQ8e9VwSsKMFWXrEb62/fU9WokWiRTsMiWfNsA8clrLACAl6/c9wzo649PC9BP1B88F0gcKvoL8QYfsZN5PwtnxeiA26lesBuBRi71H1fvY6H8yyYYbdBK8xEcShY9ndxYFlg9acSEGIPoT8ZOrWXOlJLvxRwWFmRDWYw1skND9xX3Cq9iem7JEOXsVKUP92fuabiZaFjceZkFVkA3FcfbN1oSvqyKz7WVN5HUjT/NuzN+y4MkFEQaorDyDC63SS0qu7FJ3uxdWHGb3Qrl/gbThZ8RjzJnDfrg/eHtSFNwYCoJW/k0xoL+b2xMOaile/M3qq9U28CrGCJWcnANFkHRFUueanfPJqdl/C7Cs7QEAFb8Qp8F0+d2ZA9xBAHqzerXPfCtvDJCjzr0IDV1x9EMPMI6qOqv9CiDCGvG5MoYENBIQ2QBlYXn8PUMWbDuY+hke8dC1kmPBHYZDAc5gSydZWCQTp3zL2G0OXj2RArIvPHF2C6Kn2L9e5MWIscvV4XiHy6VALmktxYpC8zFiJIXCMIm7jLHFBVA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FCfaUYaXY9kmMI8j2bQ5dRgXepjufRTwK47xcncTLRDM2gawraoSauKuPmduJvfKd4YgAoXHuapBXNROKDMHaSE+kCwy3RmSvvPIBP4PbsAx1kyytfFyIxLTA9wE+Ybqz8OgPFZZV7UINwdwEqvtsPuRROtfYsXEDnkYm+Kq5wWsVlZ6qmYu4et4ZMBaNbHUHKjUcLL824Smqb1cFAmdkwR4BPdMdyYOUroXhlPtHVo5Khl0o6n4WEB2LVKqlBGcFV4WKakcS5FNm/xwF+oNYGCPBsLKM0JAPaiDQB9CqcsZ2gna6D+G7/5C4fV75dSwzK8JrTZ9Zvl6e+1DrdFZ7XIvpYRKWDNcwuxi6EbI1w+xRbg+6ZxrVuszQTsgWts6X3kneP2y6ejhWAbLgGDITJ4/CChPoeilNaurVhFpXq6VBTD95/BGrHHkUh729KGR
X-Exchange-RoutingPolicyChecked: YC9gRY10s9x0soX7eEJ9zfU/6kFpsEV4WjAtJnDzZ1BaSbQ0iZS798ra0HU9dbNa7r8SKMRUiFTPJyuelMB9kjS2ptYNqpJxeDg0NGwfxCypkdypdoMleBVeL7SlT97hAya0bKf1uiKWxk9dq2UkBdbxPrF8nMHv8JYP775snhdzU5K+kCVVf2k5FllIJa2zjlLeCTzP/+EWPyPFadonXvQGeSwquHI80b0v3Q4NvZtARRkPgkqhftxe8ZwqcdXiXzD/Hfxe345Vs6XSRm6woqcyhgr7HL8UmuhVYBCeZ5Bs0FIbJrNMqBdOO6Z5WXqtFHTHpjmOjvUFbQ+Lyem2ZA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 15:58:11.2735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe0b3e3-fa30-4b2f-cca0-08df134224aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8447
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMiBTYWx0ZWRfX4nBOGd8QVBJY
 C4HHpQpULkfz1bArhtkjm6ozN0pDyPsL9GPnMHeW7d2Ue0y/BRVJ/hauDJ6pKAaH7pbgsd/7BKJ
 LQBYnqBI7Rq3iMUFvodSo29w8ljskT57S5YqWTX7JCQ4fGwus/3zPNk5dZTGGdiRlYQUVuSX+6H
 emLYAd+1Pq/6hUznMw2oQVXGcJf4hW7hwtGORu5+xnQb+NIy+lj7hvZl6QkJVRigb7y9DEGGemf
 zVjABDuskKr6mPi/qUyRlOVxciKAalRw+Bx3SL8cJOCKDFX2+uaVH160mNJtG0V27G60dT0VFjL
 CjyzjLGu4KOPBQ9+yunFQjlOx6bjgbJbCkhL8qiAwVepqszXMGCMkelGp6S8AYuqpIcFFcHFll0
 q3WBURDL/0otrRXhIqeGBQRDy3eDTtWUqpHwbaBC/FH6PnaKHgKz23LD+qv37HT2Ri3E6Qw0xKU
 1mMJRDRsqPjtLfmk/og==
X-Proofpoint-ORIG-GUID: PI1yl4BqFSGnffYDNRbSNskg6If-LJzd
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa96b18 cx=c_pps
 a=eOcJweQzB5mT18+DdV5GwQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=C0UQ9_O4xCHEqk58IZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PI1yl4BqFSGnffYDNRbSNskg6If-LJzd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMiBTYWx0ZWRfXxjIBBFeFog1P
 V2IM1W322pmZWFGbWXcuiEzuf9bVFlZ8HyUIdxRiKpFwERo5hs4aeZu6siCk9KOmUc8CRj2btPw
 kvUpk2gBx5P/GysNOQL6APQ7o3sqaNs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150232
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



On 9/15/2026 7:29 PM, Richard GENOUD wrote:
>>> +        k3_ddrss_lpddr4_exit_low_power(dev, &regs);
>>> +
>>> +        do_resume();
>>
>> could you check, if caches can be enabled before do_resume() call
> I've tested that on j7200 and j784s4, and it fails at resume:
> U-Boot SPL 2026.10-rc2-00046-g31003eca655b-dirty (Sep 15 2026 - 15:52:55
> +0200)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.12--v11.02.12 (Fancy Rat)')
> Initialized 4 DRAM controllers
> Skipping authentication on GP device
> Starting ATF on ARM64 core...
> 

You need to flush caches before starting DM

> [   82.967460] Enabling non-boot CPUs ...
> ERROR:   Timeout waiting for thread RX_SECURE_TRANSPORT_CHANNEL_ID to fill
> ERROR:   Thread RX_SECURE_TRANSPORT_CHANNEL_ID verification failed (-60)
> ERROR:   Message receive failed (-60)
> ERROR:   Failed to get response (-60)
> ERROR:   Transfer send failed (-60)
> ERROR:   Request to start core failed: -60
> [   83.998938] psci: failed to boot CPU1 (-22)
> [   84.003168] CPU1: failed to boot: -22
> [   84.006989] Error taking CPU1 up: -22

