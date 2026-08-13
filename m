Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A051EC5DF64
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 06:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A877608BD;
	Thu, 13 Aug 2026 06:34:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VeHpzDwBtouw; Thu, 13 Aug 2026 06:34:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 347DE608D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786602859;
	bh=coln/i7H3Vwcw/EjVY8vwkM6SzhfvckMVrez++TH79M=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jqar557qg7DO7SOfrj4yC5S99GOpgVaQtuPMZMNPQvWfHVhI29nMOBLUd029EDsPv
	 VEf4P6iT8NgxYllSBsX/u/DswHH4TEfgotxaSIcSyx/lNnp6wwBBRroPf8rC5fFxuA
	 +WBsEyGxbeftu/Q6AhTlf7dPIkH9p9m518T1cyk50cxZDTV73V5EsEAAFekTBGTyfc
	 P9w/R2ofOQD8NK/4zEX7lpQzynjiPXU+rZgbMocFLL/3xoPovcGnXfjYj6hxcHoYTB
	 h70n1fYy8ot0DjlQ11RfL0iPNOun0PvZHj7L/K9UFr8Qd9H9tjSkkpqJ4MOG+FRYI7
	 RZi95CZ3wujIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 347DE608D6;
	Thu, 13 Aug 2026 06:34:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 841623A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A28980C1C
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uobmQ9kiOYyZ for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 06:34:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B274E80BE0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B274E80BE0
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B274E80BE0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:34:16 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5h8Dt1963308; Thu, 13 Aug 2026 01:33:54 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g13fx9mac-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 01:33:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFR7LYIVVZpcoaV8ayWGTjv1Km/fUuihlOInYrqHWRHdc3e5ipKj5OCQqba6CfihG+cUY1IXOva1+HM5u5GD73QGmdkDr8XDLphKEiHR5/150JlUaH/O4DyEpEksrxXOaQNjTvUFfowRYeUEodCPqOHXH5tq0w10LmhDgeGNG+KDU6STI1qKhGaigFmy5dgHJykyE8rKZSnRti8wBSRAyVps2WG2RZo805QyAmSY5Lfby4QLm0YicY8Wv7u0QvJhYdcyg/IaRpGctnZONoiG7ZaHexpOatADvcDHhZyDR7MO7/MwJOJ60jxGH7t7Lwx2Y2dsIbiZvTJ343WExRZaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coln/i7H3Vwcw/EjVY8vwkM6SzhfvckMVrez++TH79M=;
 b=Y3/Fct0rt3OHmS9WmEFP+58w6ZK0I/q2bgWJpVCUbKYJUkmTU21ZArbjAnllY1uEl+ohgECW0LW99lnye9t8fQZtI7ePj11P2WxUM6wDGSeDd25bytbmmU3j5CmBJ15wS5qPie1ClexZp0/Am4oc02QkJZ6I/r5PnD/AikG8VtoDQ//7IGWACVp2LBJS0g6VcwD6LaWpyX5QtRBsolXpi1BrbEWDlNwMuiFer2n8LZEnz3cgiG7Oj4KZUxOpSDn7ilcQvLXfUYLrjWCmijzHhLbgagfnnubvaeBJJFpA+v/2jHoNoEN6x4HfW6OmYTCNY1WXmAgexBNu2m52PsRfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32)
 by DS4PPFECC4F8C68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d55)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:33:43 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::47) by SA0PR11CA0117.outlook.office365.com
 (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 06:33:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 06:33:42 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 01:33:42 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 01:33:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 13 Aug 2026 01:33:41 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67D6XeiN3530887;
 Thu, 13 Aug 2026 01:33:41 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Aug 2026 12:03:40 +0530
Message-ID: <DKNLUCYU412B.2KQXKMTTC3FP5@ti.com>
CC: <u-boot@lists.denx.de>, <marex@denx.de>, <mkorpershoek@kernel.org>,
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>,
 <michal.simek@amd.com>, <alchark@flipper.net>,
 <jerome.forissier@arm.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v5 00/75] usb: dwc3: sync code with Linux v6.16
From: Anshul Dalal <anshuld@ti.com>
To: Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <178602223375.3156999.13542339251028864355.b4-review@b4>
 <anmKNYbNQ73Kv3iX@monster> <DKL6AAZWIDW6.QM05DJXDFOTN@ti.com>
 <anzDvgtMh_7Fl9Ig@monster>
In-Reply-To: <anzDvgtMh_7Fl9Ig@monster>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS4PPFECC4F8C68:EE_
X-MS-Office365-Filtering-Correlation-Id: f87c5a33-5127-470c-f9e8-08def904d1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|7416014|376014|56012099006|5023799004|10067099003|6133799003|18002099003|22082099003|3023799007|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: Nh2WksPoukPAJ0ZvESmumf0iN4XiToUjXeoeZdxzr3QHZIOXhgoLmq+BMKahQBelKc9vxIsj12PW4sNWZO4QilV0HGcNrVXP0XypEN++M1mC1tmONhkOtBqjS4SkrRIpiCoYrQNKD6rTaO016c+94EDNpF+wu/J1EbleLAy9UTGApRxtstMimkDYFx4R7x7O/aZmComJGOvxzSDgFAWth3KYFBjdAwLpGl4fuTOk/WVtaOp931bpzI9mf4g5aS8+VNV2TzpyE/7LujfWlQu8rYjt3gomYgoyJsZ+/0B+kCbL4kb25IxqUyc0Cr/iGDWp9ttnisY/1VOUoWzqIoWxfOag9Qq+8GbDI48xHId4LLUdmSAZyao6AXl6tby/JIbCNVSCFdKKa/k34XSZXkYJVSCjTYHKrNcPBIiYtXYgtWRRSxKXfCndkzDa2UKtQpBczXiXRHLvIy4CuMgByQabfuDVoorG2QklX9+/m96AwB1X3ITK4XzjtP1kS50eJMr8jdCjK3vSo/feuO67F0wuZJyMSBowOzVLWib8kwnSKL8gkeubyIp/svmvSPRTEOMWuHRX4M8XFwHAf2X7v5ii0UpFwUP1oYZXJPpTp3F4uDPLTF1wCTEEfA6SquIO0SeZ0apVHAm1YSbavepS1yap2H23knmcJ9DJk3ESJHnpNql3+ZZMWDyaLJ3gWVR+bgbC2H8c4qZExkq9rDQKDRJFnQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(376014)(56012099006)(5023799004)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXHApcPizrlAotTK6xjnomTjw80J55x1gWJ5OKgXnqnGJgpsx+hYfqxD71eVcy6g5s+M7kl4BeB1DccJ1JTmbl48pNYAS8+VPO72q6rH6N2DfvyTSJrLRM0bQLrZeUmQbphnG5ofC85FWW0GCxIhuVcLz7YaTHM02DbLxd3wzdYAcqZZpmb7yrUeLMB8aZEFvdtKwPss3jikcYnaGLqnc20TpK1m0UVRcul2lJYer6bsvZR1GB403B5N2CgxX+UHfVf1868ppYW5Nsxll9cJJkCaRlU3UoF755qUW5vfjuk8s04ehVTMkjEU6518xUBRJ1eaaFarhcGQYRmH2BaVviAHGJZD07FWobF95vXXRKJz7H+dPzrfjj0cdAg2PN/Uno7nIu5+OHhOe/cmFvSxQMeKTQDwzsW2ZSUKSN5TARnBDeOe35KJ0cJ6GA6P80aE
X-Exchange-RoutingPolicyChecked: dZcxv7bIzyet1XHHUqkTmOP9kEpSbn30BPUXrAc9B9seOUsF6FfTfjUrhflSaiB1Yvv3Ua54dFM6Dl926/M+Lf8vYT+HEBspTZ5qObOFH2PoDiiLFY+nePaL00yMw7B//iF+04nDJxqIKtLiNdGGn/DlTs7sSvR7Ld6xvcB7x7sDVW2xa4EZiok/jd8yYPiePdoK4rR5hfgi1pjzXZw9um2e7KYQWUcUXuI/UuQMUCsqoLgIWt0WXbqdnluOCB8tLeBAQtuVDpWCRPJ45lDzDM4jJ+qaQEua0CDA1WXB4abpawPCy3qx7gB/jj7FIPtOYa7OisUnfRarbVH9tQntlA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:33:42.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87c5a33-5127-470c-f9e8-08def904d1de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFECC4F8C68
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA0MyBTYWx0ZWRfX/fluJ1XMnz1c
 g1h7A8GF7RsijriyRtuyH8GrwTDfhq30dY9+up/EKXp2UiBsmjakIIAI20wPtGr/hKgCRz0J5c1
 qd++xzAJfgnOpKfaGt5w31K+KoY7rhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA0MyBTYWx0ZWRfX2bRSYBWDaume
 QMXc6GtaYOI8EhPTJE8eFevE6uiQ1ncP48dreui35HQEAVqvbObqOTVf5m1rrboq6wKNrzrvjm4
 IMFqNhhwa2XC6Wo6Fqp5+8FtlE4+n3igWcwLOPHTug6bkV01AGOATKWg/ImhQlAKnMbHqqOhNq+
 3a2lTgQVfTzMRprOF1TvmlLgvGKhoTCtFNzukVTnfZTa67Y5IXTPQims+UEUfn2gOPZFVVIMkuE
 hk7yf3EWKSEGoqe1W+Qq+YKy03dEkHvw1avzOYwPO/6mY9B3BOTyjhYY5MoPEOWCppuVHAsGVUP
 y8EKMqplRIqT2QsD5VqBycc7lHwE1p4lg9v4oTqkmbdHy9mz379fQM0QmwzyY0WLd1WKE0oT9np
 whV6OlHx7Wd+tL8u57vV9oLrHS8RQQIoAhz0awDoE6e4lOid4iarJZbLt//GGUXLgdhqOz9kLmB
 GTeaRpiddM7iHLsekkQ==
X-Authority-Analysis: v=2.4 cv=Ae6B2XXG c=1 sm=1 tr=0 ts=6a7d6551 cx=c_pps
 a=lEAAG6kgDLZw1ps4cEx4qA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=dzigSyDH8EnYDIXRuO4A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EgzUi2q50qPGfsxtMiWtqZ-iJ2myA9XI
X-Proofpoint-GUID: EgzUi2q50qPGfsxtMiWtqZ-iJ2myA9XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130043
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=coln/i7H3Vwcw/EjVY8vwkM6SzhfvckMVrez++TH7
 9M=; b=ZdWOo9Pqw5hYvmnDNTrjsPMe6x9z6rRu6/2iIHbXXv7AU33N+3ByFuAND
 xxq8XQ3WVsG2OidMoMquJr6YlMUQOyWEkFyKn6e4s5zBHkM09aJx6GekhNj2A4Tx
 gsEavxU2gc8vfmis5sYfmwExbelosMFAYE4kODmjhkpc1hfBWFYj7+QqZA4JB5uL
 RZPgVnHyEGIVDU1OLfvmintm8ovffYUFL4wqqQM97RokCRujcdZy6kQjyu4tj8cm
 dqD3PlA1vdNvXpek1T72T864rE78VW7y/aIQtJ4VxwC2CbxGIqzd29DE7N2Q8lZf
 7UZw4RVxPZKCgE/L6ybdK53n66ZGg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coln/i7H3Vwcw/EjVY8vwkM6SzhfvckMVrez++TH79M=;
 b=gxZP9t/LS9CVvZd5vHTM0qXk4/Oga3Rq01phoSDtRuOAW6+P/apDUR7cmujhp9VW1QFQyOte9YRuYRNZd1GTPot+qmh883PZwdVWw7/HMnvxwTWEbMH7quC+727cqjWEIsRILlPEpjbQxMJlD+jS3WwHgFmqef2WbG+aWgOyJ3Q=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZdWOo9Pq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=gxZP9t/L
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

On Thu Aug 13, 2026 at 12:34 AM IST, Anders Roxell wrote:
> On 2026-08-10 15:26, Anshul Dalal wrote:
>> On Mon Aug 10, 2026 at 1:52 PM IST, Anders Roxell wrote:
>> > On 2026-08-06 18:47, Anshul Dalal wrote:
>> >> On Thu, 16 Jul 2026 15:41:30 +0200, Anders Roxell <anders.roxell@lina=
ro.org> wrote:
>> >> > [...]
>
> [...]
>
>> >
>> > And in dwc3_gadget_uboot_handle_interrupt(), same file:
>> >
>> > -		struct dwc3_event_buffer *evt;
>> > -		dwc3_thread_interrupt(0, dwc);
>> > +		struct dwc3_event_buffer *evt =3D dwc->ev_buf;
>> > +		dwc3_thread_interrupt(0, evt);
>>=20
>> Thanks for the pointers Anders but I encounter a similar failure even
>> with the diff you suggested. I enabled some logging for the SPL by
>> defining the DEBUG macro in the following files (dfu.c spl.c spl_ram.c
>> dwc3-am62.c composite.c g_dnl.c).
>
> Hi Anshul,
>
> Good news. I found two more bugs on top of the two I already sent you
> (the event buffer and allow_connect). With all four the device
> enumerates.
>
>>=20
>> Failure logs:
>>=20
>> 	U-Boot SPL 2026.07-00860-g5a9b7a715be2 (Aug 10 2026 - 15:06:27 +0530)
>> 	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
>> 	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
>> 	SPL initial stack usage: 17104 bytes
>> 	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
>> 	>>SPL: board_init_r()
>> 	spl_init
>> 	Trying to boot from DFU
>> 	g_dnl_register: g_dnl_driver.name =3D usb_dnl_dfu
>> 	g_dnl_bind: gadget: 0x81c44a98 cdev: 0x81c66bc0
>> 	usb_add_config: adding config #1 'usb_dnload'/81c67cc0
>> 	g_dnl_do_config: configuration: 0x81c67cc0 composite dev: 0x81c66bc0
>> 	adding 'dfu'/81c67d34 to config 'usb_dnload'/81c67cc0
>> 	cfg 1/81c67cc0 speeds: high full
>> 	usb_add_config: interface 0 =3D dfu/81c67d34
>> 	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
>> 	usb_dnl_dfu: ready
>>=20
>> <CTRL-C> from user
>>=20
>> 	unbind function 'dfu'/81c67d34
>> 	g_dnl_unbind: calling usb_gadget_disconnect for controller 'dwc3-gadget=
'
>> 	Legacy image
>> 	u_boot_pos =3D ffffffff
>> 	Raw boot image support not enabled, proceeding to other boot methods
>> 	Error: -22
>> 	SPL: Unsupported Boot Device!
>> 	SPL: failed to boot from all boot devices
>> 	### ERROR ### Please RESET the board ###
>>=20
>> Succes logs (same debug symbols ontop of main branch):
>>=20
>> 	U-Boot SPL 2026.10-rc1-00209-g0bdd5e5daf95 (Aug 10 2026 - 14:58:28 +053=
0)
>> 	SYSFW ABI: 4.0 (firmware rev 0x000c '12.1.0--v12.01.00 (Clever Cat)')
>> 	Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'V'
>> 	SPL initial stack usage: 17104 bytes
>> 	SPL malloc() before relocation used 0x64d0 bytes (25 KB)
>> 	>>SPL: board_init_r()
>> 	spl_init
>> 	Trying to boot from DFU
>> 	g_dnl_register: g_dnl_driver.name =3D usb_dnl_dfu
>> 	g_dnl_bind: gadget: 0x81c44aa4 cdev: 0x81c4af40
>> 	usb_add_config: adding config #1 'usb_dnload'/81c4c040
>> 	g_dnl_do_config: configuration: 0x81c4c040 composite dev: 0x81c4af40
>> 	adding 'dfu'/81c4c0b4 to config 'usb_dnload'/81c4c040
>> 	cfg 1/81c4c040 speeds: high full
>> 	usb_add_config: interface 0 =3D dfu/81c4c0b4
>> 	g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
>> 	usb_dnl_dfu: ready
>> 	composite_suspend: suspend
>> 	set_config: high speed config #1: usb_dnload
>> 	non-core control reqa1.03 v0000 i0000 l6
>> 	non-core control req21.01 v0000 i0000 l4096
>> ...(repeated)
>> 	#non-core control reqa1.03 v0000 i0000 l6
>> 	non-core control reqa1.03 v0000 i0000 l6
>> 	DOWNLOAD ... OK
>> 	Ctrl+C to exit ...
>>=20
>> I'm not that familiar with the DW3 driver, let me know if you need me to
>> test with any further changes.
>>=20
>> >
>> > evt was used there without being set as well.
>> >
>> > All of this is in v6 that I plan to send out. I have no AM62p and it i=
s
>> > only compile tested, so please try it on your board so we know if it
>> > solves your issue before I send out v6.
>>=20
>> I was able to reproduce the issue on beagleplay since it uses the same
>> DWC3. You can try it locally if you have that board with you by
>> resetting to DFU mode from U-Boot prompt:
>>=20
>> =3D> mw.w 43000030 53; res
>
> I could not use the mw.w 43000030 53; res trick on the BeagleBoard-X15
> that I found. But I can run DFU directly, it is the same DWC3 gadget
> path you hit.
>
> How I tested on x15:
>
>   env set dfu_alt_info "${dfu_alt_info_ram}"
>   dfu 0 ram 0
>
> On the host dfu-util finds it:
>
>   Found DFU: [0451:d022] ... name=3D"kernel"/"fdt"/"ramdisk"
>
> The two new bugs:
>
> 3. udc-core never sets dwc->async_callbacks. So the gadget setup() is
>    never called and every GET_DESCRIPTOR returns -EINVAL.
>
> 4. ep0. The trb and the ep0 buffers are normal cached memory. In u-boot
>    dma_alloc_coherent is not coherent, so nothing keeps them in sync with
>    the controller dma. The resync dropped the manual flush and invalidate=
,
>    so the controller reads a stale trb and stale buffers.
>
> The patch below is only 3 and 4. Keep the first two you already have,
> this goes on top. It is against v5. I built it and tested it on x15,
> it works.
>
> Can you test it on BeaglePlay with your reset trick? These fixes will
> be part of the coming usb_dwc3_sync_v6 branch.

Great news! I applied the diff you suggested and DFU boot seems to be
working now. I have hosted my working tree here[1] with all 4 bug fixes
applied.

Let me know if you would want anything else to be tested before a v6.

[1]: https://github.com/ArchUsr64/u-boot/tree/ti_k3_usb_dwc3_sync_working

Regards,
Anshul

>
> Cheers,
> Anders
>
>
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 0a4f69cbc28a..2ba05fc3f573 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -54,6 +54,9 @@ static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *de=
p,
>  	else
>  		trb->ctrl |=3D (DWC3_TRB_CTRL_IOC
>  				| DWC3_TRB_CTRL_LST);
> +
> +	dwc3_flush_cache((uintptr_t)buf_dma, len);
> +	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
>  }
> =20
>  static int dwc3_ep0_start_trans(struct dwc3_ep *dep)
> @@ -811,6 +814,8 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
>  	int ret =3D -EINVAL;
>  	u32 len;
> =20
> +	dwc3_invalidate_cache((uintptr_t)ctrl, sizeof(*ctrl));
> +
>  	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
>  		goto out;
> =20
> @@ -856,6 +861,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
>  	dwc->ep0_next_event =3D DWC3_EP0_NRDY_STATUS;
>  	trb =3D dwc->ep0_trb;
> =20
> +	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb) * 2);
> +
>  	r =3D next_request(&ep0->pending_list);
>  	if (!r)
>  		return;
> @@ -873,6 +880,9 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
> =20
>  	length =3D trb->size & DWC3_TRB_SIZE_MASK;
>  	transferred =3D ur->length - length;
> +
> +	if (ur->buf && !r->direction)
> +		dwc3_invalidate_cache((uintptr_t)ur->dma, ur->length);
>  	ur->actual +=3D transferred;
> =20
>  	if ((IS_ALIGNED(ur->length, ep0->endpoint.maxpacket) &&
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/u=
dc-core.c
> index 6355931f9ff1..f03ff937dfde 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -941,6 +941,8 @@ static inline void usb_gadget_udc_set_speed(struct us=
b_udc *udc,
>  		gadget->ops->udc_set_speed(gadget, s);
>  }
> =20
> +static inline void usb_gadget_enable_async_callbacks(struct usb_udc *udc=
);
> +
>  static int udc_bind_to_driver(struct usb_udc *udc, struct usb_gadget_dri=
ver *driver)
>  {
>          int ret;
> @@ -960,6 +962,7 @@ static int udc_bind_to_driver(struct usb_udc *udc, st=
ruct usb_gadget_driver *dri
>                  driver->unbind(udc->gadget);
>                  goto err1;
>          }
> +        usb_gadget_enable_async_callbacks(udc);
>          udc->allow_connect =3D true;
>          usb_gadget_connect(udc->gadget);
> =20
> @@ -1156,6 +1159,7 @@ static void usb_gadget_remove_driver(struct usb_udc=
 *udc)
>  			udc->driver->function);
> =20
>  	udc->allow_connect =3D false;
> +	usb_gadget_disable_async_callbacks(udc);
>  	usb_gadget_disconnect(udc->gadget);
>  	udc->driver->disconnect(udc->gadget);
>  	udc->driver->unbind(udc->gadget);

