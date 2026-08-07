Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE7AC5AC7C
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FF7780F95;
	Fri,  7 Aug 2026 12:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdpkWF5wrUPN; Fri,  7 Aug 2026 12:42:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38F0F80FA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786106573;
	bh=oxKiAY46vXDfKhdXkLNNWcuEl3VM2m4DDy8YXWk+rd8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uXWEkfiRlqKdBgJtJwI2Mz6Lks0ofNYV5A9vHlqY58YZ7Tj8nTfT215nIRn/VShpY
	 oLPkbMb2WFw+vi9Aot7zBdUs7CJ2TkYIcsF1m76Uc5lG7wqSPJzmEpGPAQEpdCt4JK
	 h1bfGIvG0bdtAn7KwOW6Sx5G6D0jRrTo8tN6IJLKbGWl0cdXGSXjmJ5A5mEOcaJK3j
	 HOZ17OTHxtCwfaukIgAI9JuJQwXq+swwuVJ7f67SBckAJAzeMFOGP7KsajvZm+bZG3
	 RbuQr7kKS3ULqFEFQmLxbsgBFS7D7/PvEFzShsy25MpkcHhtbRsW9Pnyg1boForusm
	 IYqNkF1R9+m2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38F0F80FA1;
	Fri,  7 Aug 2026 12:42:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CD06E2F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF09540092
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ScG5pN57M2M5 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:42:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5AE4F40270
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AE4F40270
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AE4F40270
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:42:50 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 677CeC0w3775885;
 Fri, 7 Aug 2026 07:42:48 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fwe988bwb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 07:42:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knpapaX5RD6qP+w8T7LbSaBwqTrnVjsvuCBncIOEdZWKUvzCLB85/vOnZL7HqilacP1AYZiMqp0kRrEuD7WP//H2iBe4kqs8J7jk6UcU8A+is54xm0rrJoHnQlpjjNeJkeABPW37UZyUj7noC/CdRLEf6Ro4jVwfwlucDmlNDa5/PlMbWLkQuGWKqT86a+INGkoGFuHLr20S5zvIMd2/6H/OyblSLYDJD0ytBBkD2wt0tQJ0WfnxxnNNpBQkw4oulRW9uIlYhCJKY8DIGvy1yj4fojbUQ3TUVSuYy8ulO5/B2pkBq+UrXd8Fk2Ccr11oFw0OfDeNOtVb2TFuh7o4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxKiAY46vXDfKhdXkLNNWcuEl3VM2m4DDy8YXWk+rd8=;
 b=MuIrh+dxjhfbqWjh6gBZ5wuBxVhvgDCVBNlot9Nx5VjgganCQgVFRcNUavUs7WDWZkeFmZNj/hYLT/vdnvwLHRN28YxN6Yr8utHRDElN0V6t9oDk+LBLqCTipM7byTIJQ2GRnL7d0pMOsggEt9HECciL7m196ZFl+5ynYeJXd93WLHEM1GmTRwgtYoAJMqNaiFrVl89yxmyPq8mw79N+DHp9JotLjSK8tjp2w+bw6WacnmuPZHUYqSriWmDJaCHJ++mrlYlFkhBF8ZnRfH9Z7U5OORPd2Dk9RVAO6WnOgjHomk5U/ehMqa5+YQd2m4GOBp4xY/kdnDUFztCOSampRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from DS1PR05CA0003.namprd05.prod.outlook.com (2603:10b6:8:457::14)
 by PH3PPF34C504C55.namprd10.prod.outlook.com (2603:10b6:518:1::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 12:42:44 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:457:cafe::4d) by DS1PR05CA0003.outlook.office365.com
 (2603:10b6:8:457::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.10 via Frontend Transport; Fri, 7
 Aug 2026 12:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 12:42:43 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 07:42:37 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 7 Aug
 2026 07:42:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 7 Aug 2026 07:42:37 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 677Cgbgp1833353;
 Fri, 7 Aug 2026 07:42:37 -0500
Date: Fri, 7 Aug 2026 07:42:37 -0500
From: Bryan Brattlof <bb@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v4 07/11] arm: dts: k3-am62lx: Add binman support
Message-ID: <20260807124237.nqqqnej2gbmadybn@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-7-01746157643d@ti.com>
 <CAFLszTgyg2Crj4ksqj5UoSEd1go3Q8-Zb4NnORGq8b=ZTgf+Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAFLszTgyg2Crj4ksqj5UoSEd1go3Q8-Zb4NnORGq8b=ZTgf+Vw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|PH3PPF34C504C55:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d200ff8-269e-4c5d-e9bb-08def481607b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L67rlyskbk9ynmlO36ErDdW4zCYreTk3vfhr8MdZFDSmXd7DnKQ/9Ol7jrgieTm6lA7W1oX4pi0bkSUJgadSxEPF9g/zlj6Nl82XbpGH+GxiomgAbJIfSmYqi1xEJ4/gLXaYcnvQAmx+6M1xtSkQzwRYTDu2VCrxR4vORi4aFSGBgmKQEXGo3fNNAz6pl9hlYH+tpAU+dHuTd5PI7IliJs5jL+2hd6M0fpPeIu3mnMBPofKH7/uPTz9UeW+OgRWkBQfHqj6yimnAbsiMJru2vxGbKsde7YYHvSPm+uF4nVclxqW3JV6C1i44S8dWqQIpit5oX0yIhzRrb2z1pUBwjxn4WnBBMw75RVnOeVHofs35bjQOUIUWSMYlVodmZVdDn9tjwjFPbY2LJuZ4SD3aQMdLo5u3bYjW4f19f8bErb4ncJTH8WCgQ7gj1QhYlP1zk8fXP20JK7IgYtYFnz7LfrEszRzabqfVdqe8nr+E0YpIYD34JH2QQIyx72EyqVynGFVDFQ59nKDv7E4i4n9J6GNBWUs6HAK19rOdAuvT1YBHMaPA8TsX0sNwaZB4yANuvpBkvSUKWr86VgMuaUddmqZJkskA5D8EqQ1yKKXsxaqiKE9FGUINnkpvv6rYfKU8Q8aLzVdHAawfychu5nJt22TbBgqQOLtqsmRdYqoyLAyUh7lggI8bUZyq+o4yANlWtaQ/GlO9q/e7GICEYVjDXQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrRcEdFKyypIC4K6rS1e+6K2gpjXDWIieMG/Bc3db3TgpPXHKbqDFHZYRTILMVgd9IoEJr8iDXANumFTgCyOldVII7FhFJRJaguisQrSkq3TE+gHRh6sNuL/9rNaPn9bsnLsYhAENDHGAfQy4BFoTt2mT2EURnJpVXVZOMIxltMf4bzzCblKbYWgy7Su7E7Kn73RvR0HJ65XnQe5Ss/zRHiDrPBX0bHQpWNaxENjRqquOtbQbDf9ltntEMCR1ylp1ISsFVj7w7OFReFGcnjGzzqF+TffNcVI1A85xmVQ7/2N0/YtilpzPbFnnFZOK5Yh1XiAuJLUU04MZEhckmWJ6K0u4DiT1peZedtF1aJpXrG+wdzZNXmBR0lGv+AbKaW+xEW/ZABH3iVB4QFnBfylmrVfai5GjmgpgTGmt4axPJLpcNP66tPPfDbCrACtXrzH
X-Exchange-RoutingPolicyChecked: P2GUQTpOEjxss6mQY4P4l2ACOjuhYiTJky7hTN3GjQCuXijvxCtOKJWnlLQEUMRkFbbvXNlwJHMvv4E/vh8Ukqv3WwyVNZ/p+2gsX9M3hCmgE+8wMqltLq/dxE+URxuxmDz6DCXJ0Nrk8N9ORf57kPNqr6M/+GZKETlkV+f/ou+ip7+LtKC8pSxIq3bsTbS5KHMC9eFYhUzjZHSaXjV7naiqZiGRAGegfu8wyDmf/e7u7JO7ra9iVNhKusR3+HNd7ew1bRTk7EQAHnfKNP+8AjFge7a8Np6vAA08ck08PNZZifc+489kkPV/UH/aKxMS15G7vP46Fdbpks8a0r/eNQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:42:43.9041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d200ff8-269e-4c5d-e9bb-08def481607b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF34C504C55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfXx4/O3hJSh9jR
 3T+6iI3Gulgeig5ylQoLKpYLlTsw+wg3jJST0YgWz8+Q2qq8hSnNaZ4imJUGBD99l44wagJLyMe
 2wdVwywG6kUbCDFslotbYXYgXoWqeaXImtrSyJAirDOD662ijf8UW/n8n4KR0rOJiqzDxRNHHz7
 In4/ymuc+/ObdB/l9qyhGo7iWbmV9VuUewOg9pRQ3770FPfV3uHIS0xwfBV6m0powrvPWO1xlmr
 S6e8Aakg7g1bJnVdB3I829DWOA3VRTEcgtPIFLSZyO0pRCjx7vYkmvo9tQoKa0A0AWli7w4bQ+T
 weoOaCLDClX7UpNpyg65yHX262XBCaPcLz/hmbYourlOmrilZKGGeCWRCwcFmB/VMale6BwoHx1
 /iAmLDFK/v9NcUb/7LS039u3jiV33lfA6myedASI4yiJCGFivz/vza1opjrnsJkxdramimzsrj9
 2BgX8YDqMDP9igGIBhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5OSBTYWx0ZWRfXyN93wR994g+j
 gbeCG7LWQQ1VZ4YZVHWxuKoF4SXxrynK4jHQNVedhlsQMnJtsRMI2b3nzajTrdQYiKMFCp9vDS5
 FTL8XrihMXHMJmdwjIH++XvXcy/UaVI=
X-Proofpoint-ORIG-GUID: H-HCCoU01yFjsNqcZM-zmlCF-vu7KRAX
X-Proofpoint-GUID: H-HCCoU01yFjsNqcZM-zmlCF-vu7KRAX
X-Authority-Analysis: v=2.4 cv=bPYm5v+Z c=1 sm=1 tr=0 ts=6a75d2c8 cx=c_pps
 a=EtrKi/+kAVY73poqiPL3VQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=woDhbe-ce_vKyvYmipgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070099
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=oxKiAY46vXDfKhd
 XkLNNWcuEl3VM2m4DDy8YXWk+rd8=; b=M1GEgcJjsZfJ316BhgCxCXK273KZFRc
 kS+RIPU//eQsElQQ+b9ykV0aWDgh08rzLv8Hn5aQM15KoiimT4Nww/84fDE5Dgfm
 P9jM8rKWomyBUlNfUYFOR4EXXFKqbdeiaocT6I+/Ba7rRtSpmLvKsqqXVS4Ld/9a
 rQrlUcs7gdNnPgPXax3KjkBlHytELhZCGXRI1KCpcFO2Ne/u/fmPWa8ZzIU+lpIQ
 73YLDzKdsq4JLU0Uf59NnWyQd0VwFE9OhLa1ogOUEOClYHtNS/Z0cK/x+zemmuEm
 flHb6DWZi/dG2pOl7WkXmVmTjS3mWMtAgx9ZmnfbvQoKQfqd9Ft/LNA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxKiAY46vXDfKhdXkLNNWcuEl3VM2m4DDy8YXWk+rd8=;
 b=X5iH4OknZLKd/LPnYHBe1wityrmobGqwh7D5AxuuTEhiUfuoHRYRrAGbU+qTDfGBJVWRYNEIEMKRbO0nhhALuZ2gnHIqj4T/dIIz2g+uYQGN9Tq8/cQ00YfcoQ959KCjx/KeSY+bZK+uPltH1udysO8X+ouJ6/d4nTQyDQfA3Zo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=M1GEgcJj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=X5iH4Okn
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On August  6, 2026 thus sayeth Simon Glass:
> Hi Vignesh,
> 
> On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > arm: dts: k3-am62lx: Add binman support
> >
> > Add the initial configuration to build the boot binaries for the 
> > AM62L
> > family of devices
> >
> > Tested-by: Anshul Dalal <anshuld@ti.com>
> > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> >
> > arch/arm/dts/k3-am62l3-evm-binman.dtsi | 218 +++++++++++++++++++++++++++++++++
> >  arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  12 ++
> >  arch/arm/mach-k3/Kconfig               |  21 ++++
> >  3 files changed, 251 insertions(+)
> 
> >     arm: dts: k3-am62lx: Add binman support
> >
> >     Add the initial configuration to build the boot binaries for the AM62L
> >     family of devices
> 
> The body needs more context - how this differs from the existing
> k3-binman.dtsi (why AM62L cannot reuse it), and why the new Kconfig
> options are being introduced now.

Sure. I thought this is what documentation was for but I can copy and 
paste it here in the commit body as well.

> 
> > diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
> > @@ -0,0 +1,218 @@
> > +// SPDX-License-Identifier: GPL-2.0-only or MIT
> 
> Per the SPDX spec the operator is upper-case OR, i.e. GPL-2.0-only OR
> MIT. Every other K3 binman dtsi in the tree uses plain GPL-2.0 - is
> there a reason to dual-license this one?
> 

Sure I'll uppercase the operator. Thanks. 

As for the dual license, it's to align the license with what we have on 
the Linux side.

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts

> > diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
> > @@ -0,0 +1,218 @@
> > +             fit {
> > +                     description = "U-Boot fitImage for AM62Lx SK";
> > +
> > +                     images {
> > +                             uboot {
> > +                                     description = "U-Boot for AM62Lx SK";
> 
> This board is the AM62L-EVM, not an SK, isn't it? Please update both
> description strings (the two k3-am62lx-evm ones look correct already).

Ah yeah the board name was changed half way through. I guess I forgot 
some places when updating things.

> 
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > @@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
> > +config K3_TIFS_LOAD_ADDR
> > +     hex "Load address of TI's Foundational Security (TIFS) firmware"
> > +     default 0x40000
> > +     help
> > +       The load address for TI's Foundation Security firmware. This value is
> > +       used to build the x509 certificate to tell boot ROM where to place the
> > +       TIFS firmware in memory.
> > +
> > +       Unless you know what you're doing. Do not change this value.
> 
> The last line reads as two sentence fragments - how about 'Do not
> change this value unless you know what you are doing'.

Sure

> 
> Second, these options are unconditional so they appear for every K3
> SoC, but only AM62L3 consumes them - every other K3 binman dtsi still
> hard-codes 0x40000/0x67000. Either gate the prompt on SOC_K3_AM62L3
> (with per-SoC defaults) or convert the other dtsi files to use these
> too. Introducing a global knob that only one SoC honours is confusing.
> 
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > @@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
> > +config K3_TIFS_DATA_LOAD_ADDR
> > +     hex "Load address of TIFS configuration data"
> > +     default 0x6c000
> > +     help
> > +       The load address for TI's Foundation Security configuration data. This
> > +       value is used to build the x509 certificate to tell ROM where to place
> > +       the TIFS firmware.
> 
> The help text says 'place the TIFS firmware' but this option is the
> load address of the TIFS *data*, not the firmware itself.

Sure I can reword this

~Bryan
