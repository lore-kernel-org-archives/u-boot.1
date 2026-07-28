Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C816C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5954608CB;
	Tue, 28 Jul 2026 13:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u16AAblIlrVM; Tue, 28 Jul 2026 13:00:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4273860A6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243620;
	bh=CcovXjYg4eqW9jeSZ8qxARSx205zraFzux2RyI+G0Do=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRmorosvt0eFGuZe6MWFwyKtlLnzwnz1zhe0leJTB/yg4Z/r90ACNoVQfr79Wd9/E
	 xxCcp88jMYJPUJ3Sck5BlPNj2hyTDHrVvB6gJ+H1OvBgNRjaTT4dHLtO3si7s+y2wT
	 aBKploH/G1snbGGWTDzVJ/XRMXgKwp+LxXw1aLd3KIyIcXp/QoJA5c2gfkLfO5HAzx
	 zwwe6xu+ijmfxEP5LlZdS51ZJOcLc9EG6dix9QCM0+RR2+x0h/lZhXqbzK8yb/RK5T
	 WKnYAiKv9VxD4s9aGOnH0yoXpQ2s1Dx0ICB33Qswg0BtNPBAynERw6Wx9QgHKaFfnL
	 KdyDmDE67HDAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4273860A6A;
	Tue, 28 Jul 2026 13:00:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A4D42A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA85A400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ON2xLBtZ-t-c for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 10:34:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=gehariprasath@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A8529400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8529400D3
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8529400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 10:34:14 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66S901br838718;
 Tue, 28 Jul 2026 05:34:13 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012028.outbound.protection.outlook.com
 [40.107.200.28])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fpsdk0e27-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 05:34:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMlGIXn7NdQka3TA+K4DqCVMLtR/7Cvy/O3059hkuzFjbSBF6yI/4fo7swPPzLDNoS13l5SCxDYrPGd7ekfP3c3QxJPGPOl1XnjegQotd6+f3lQ9kT+7WCrAXT7DLHnVl3nPtDJjJ/pTbqMiEFJikvJ69VdMSnK0u83G/j61zBdSsShyzdat5Ddyf+2yMY8GGJFURQS5JT6SfARJs4KvDdjXG5HgXAnt+sbUQB/KN9MISi0LU5T1AeQ7TXaAZuyuak95w3KWnw/FlFbU3KQFGqD33R+WEoelO2Sy4VrAHFtkz6AUT2/ukrzxjTCi9en78qyYRXumg3Ru7rOOpDlQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcovXjYg4eqW9jeSZ8qxARSx205zraFzux2RyI+G0Do=;
 b=jIPEk/x+JsuhVBXoqJoJNz/e86RdiOSwyVfJgu8QXf+4llUoCr3aPlx3HxDRD+I24+NLY4QKbH9eMZjnaHn3MJ5XTpm7LS7JJABZxwqZG6jIOyDB7KzdKfqLCTqBI4IigiD6XDd8y6s3uwsceD/gU46bMgVU6ZUnEv2qtCUVyFghT4JcHIj8xJnEfDjPJkjVR0SG59BnFiKuqPJ7ogfKefe3gmqsMSO56Yb2e5avlTP0fVgoOWfqnYcfaat5y0s+5XypHb7MnmdoC2R36Rsg2q+o2dZ1Yzed4e2U/zncpHgtT6+uDJVapeizXM8BMFQm1sO0OMrF5ye4iIkN/Iv2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:a03:33e::20)
 by SA1PR10MB7813.namprd10.prod.outlook.com (2603:10b6:806:3a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:34:08 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::4f) by SJ0PR03CA0045.outlook.office365.com
 (2603:10b6:a03:33e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 10:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 10:34:08 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 05:34:07 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 05:34:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 05:34:07 -0500
Received: from [10.24.52.136] (gehariprasath.dhcp.ti.com [10.24.52.136])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SAY5J43137683;
 Tue, 28 Jul 2026 05:34:05 -0500
Message-ID: <8c4618f7-2186-48b0-a206-c8d0d13ffb00@ti.com>
Date: Tue, 28 Jul 2026 16:04:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: j721e: Fix up eMMC OTAP delay for HS200 on
 SR2.0
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
References: <20260728100626.4065232-1-m-shah@ti.com>
Content-Language: en-US
From: Hari Prasath <gehariprasath@ti.com>
In-Reply-To: <20260728100626.4065232-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR10MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 313a10e7-9e6b-44ae-6d86-08deec93c182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|13003099007|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: moJSWjxRufW+/iBjZqBITbRylXmfhQjiA8RvUiCcIO1xQmDU06T2cpuA/b2vwb+byLgQNEfPk741Lo6RjEEJaBCeprzr6FMd5qwyTalTOLTeMoMLQrfDSl48SgXuPOjsbgmImTZ29PhchRa9HVzl8jWyrFVpOVg3VFiNZ6yCAXpiiyRHgf8w64XqgdZugjQicJlV/H1CYlCODPWxAzPPQ4WGommKdSDPkr7KfwMJesW2nRCbBq6tcgQNmQNBFYCKcwCO8NPnSL6m1Y2BD97ZHywObVV74pNrlC80u5h7o/9mzOxKxLx9uoPgka5HrptwD/IHDJn7CBn7n/6CBgPYTvyMyPSPGZpuzfMFkkzvJtaY18FDDn2JSWJ+uwGqa165liUCRmCvxpb4Uj2vsEtODhMg9MZ7ja6I+K0IszO+u+YxjKYmTipmcVySUcUPztAyc1qxELE8rXUvEbgfyXXT7TFTFN5rukMBtZmT1UfcRXfZPw7BX8nlXHFHl0tk1gHuy09Vm3U9XGPmqNmd3DsDLdvvxicDG0/b+B/i2o812Jy3dQyyyEDLjPs7480v7hOIcbohNTXkC5VdCcTVS5KY8ed6pYAanZ3xn3domHm1T8tySYd7e/EYBbJciUSToIRJSt9TziaqJoJl1muVT+4StaYzf/wbuNb4g14ueOu5cus=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(13003099007)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Myi0Df/UCWfi5sl0rOjp5CueE0LqLXHx3Fag//yV5ZwXziyL4AE8+ztdSyAEw97eCeF8VweHzllf7UpVOCN7eKzLNLy3E4e9TtSPxMiVKagWI2VGreSA4CUSgW5LjO2nVCgR2XZt94f+EzqhxTL/ibuVlq7gvgkJ96sW2SK/DoGfOwnc9ei4h8Us4EdfreduuJ8vt6NgL0WW99f/bkWr4Xa2DfNd1eKmESvh8dSi+itFd6RUYyYy4tMqJzAuZIYELwj98O/GF82pq3cH9VAuTcbEzS8jQqIWPD+voE9EtaPwXZ+RaOBS293sLwt045MQKnyODrIv6Q0biW1Yp5swUM1fmUDE1TmfbKNRHL7DNK/xCEdb2UevLHNRK1MGhgtB5hrRwYMI/AdTd6HpRxf0vbK8kmPVL3IKhNdhdQP3oiH56O7XrptjkosSxT4Hc7tJ
X-Exchange-RoutingPolicyChecked: SItUzlBFdBgHtJhYWrLDXID7KUydT++rEZst3zVcujQNGWf/ye9Em/ODN5fAjWmT0+6wsQcn1XQOgZiTMsM4Xkf0SfZ2hpS3iyi6sAPFbY3/8BibUqewcTcIblxS8zEAkMCH73XK6QkMP3pmt6rhrhnkRb5qPpcDYNW0I9AJmISDPDx7i130kOPPaVDLQ5bDywbz11Xm6Wb7ickAT5gY4zHejv1XIkDa+mY72UVdZjWzobmTE5nsAT22UhcxyW5wzJbukC0FvJg+W7dPNgF8dHpK7MlmYH6HcSETv2h0Txp5F4tRBGJ1k5gkoMewJlAX/4mhLeBTMo+HNBzVBf0tfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:34:08.2706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313a10e7-9e6b-44ae-6d86-08deec93c182
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7813
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MiBTYWx0ZWRfX9cw6yVdOnz5T
 rkdTx/h/5umDi9JtuN/6p4Kz5AmZcQd87imnIlSA4cOm6hq+Ik1Af5cbbykujPwjrj7wTBcUGCA
 /pEDYoh8snZ46LQz4fBXGqUoTK45+bk=
X-Authority-Analysis: v=2.4 cv=e9M2j6p/ c=1 sm=1 tr=0 ts=6a6885a5 cx=c_pps
 a=7whtcbPCeBOLW6TxF+pv5A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=N3paxxAF5qrrr868oPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MiBTYWx0ZWRfX7vJSe0YIP3UJ
 jF2iq/IHaJ5PWSM+haVA5pA91aul0Qo4lflNcV4AqDaf6/LyCmt3GlpMUve0C8CPjw+yYww2c0A
 TZ9sgJS7w+qj8T99vxEdJl9xozi0Hvuaxo88NsjgcnUfTY8Wn4gRKyG0JvmznJoy7V7cH+NNtrJ
 dccZck0tAlVJTmzMN27PK+fA6pki5tNuJH9mAC3UuaBGJ/5VLbFesK0d1y+J1CS1JwGA+3TPJNq
 Z4YHfxSDiidmv/Na7jAW1GHv0JRhXfmBLD8fv3U+r7qujhB3DiBswshIqc04tc1UuNDkspjuAb6
 4/eIKb3SuVwIn/pM6e0mgIQ6nChRO/DlCqL351Z+JOo2a4XVz5gNadk36SW9twsonxx/lFfZPCm
 +P+i9+0SdlWeu6mljLbP6LBDvxGucPRzH3nlZgD1iPFrabt09FfaCDOVPhyYVTRMF4pcrAb9sWO
 Lj5uJqqQ9eBp8KkUpmw==
X-Proofpoint-GUID: Zz2jwPzs183nZA2Upl8CPqMN9FVWYpSc
X-Proofpoint-ORIG-GUID: Zz2jwPzs183nZA2Upl8CPqMN9FVWYpSc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280092
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=CcovXjYg4eqW9jeSZ8qxARSx205zraFzux2RyI+G0
 Do=; b=WvXGTNHJ1jqs50SVc5lWKsxsTT3f9zqki0dgeyo0NgiXZh5c9j2tXZthB
 yN13w4OCF3AECmsEJ5bwnIjqxIE9tCLf5t6qZrhvU1+trXHOjAYStDAISwVsgMVW
 uLZSHa1d596ZKHnS/CZKrBrSzmW59SX41AjMO+urS31AIARI94nqr3VVpMSM86bD
 ZYTHt6WWzDNmypikj3wdkEgfJoFeZo0yguKspJ5WE4xPUyIhyAy2L1t/NjfHRevS
 uwDtXEhceMoABDhMCJLNSV1eL6YNeg9Xv/GY/zFEE2BnUwqF+1VAP1KAY+EFnOGD
 062bnvg8ww8V1vn4Lhv+p/p5Bk75A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcovXjYg4eqW9jeSZ8qxARSx205zraFzux2RyI+G0Do=;
 b=D3nXwpBDaq6n3PRwdnzubwlNPgzI2yHdaOEPahgdeO/okbm4SCSGtVEA0Iuj9pgwJ+V5nWXwVkii1dKaZVl/smHyvF4NGMI6t6jIFY6Lut8kctE3Jq5F9FPFMrtPG9RiPYsb8PJbOTWGQ2PAJrdpvkk909m/C1AfmC90KooKMas=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=WvXGTNHJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=D3nXwpBD
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

On 28/07/26 3:36 pm, Moteen Shah wrote:
> The J721E SR2.0 silicon revision requires an OTAP delay of 0x8[0] for
> eMMC HS200 mode instead of the 0x6 default used by earlier revisions.
> Hence, detect the SoC revision at runtime and patch the devicetree
> accordingly.
> 
> [0] https://www.ti.com/lit/ds/symlink/tda4vm.pdf
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
> Changes:
> - Fix error msgs and add error check for getting offset
> 
>   board/ti/j721e/evm.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 881392bd963..da4eec2a44a 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -16,6 +16,7 @@
>   #include <asm/gpio.h>
>   #include <spl.h>
>   #include <dm.h>
> +#include <soc.h>
>   #include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
> @@ -33,6 +34,9 @@
>   /* Max number of MAC addresses that are parsed/processed per daughter card */
>   #define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
>   
> +/* eMMC HS200 mode OTAP delay used by the J721E SR2.0 silicon revision */
> +#define EMMC_HS200_OTAP_DEL_SR2		0x8
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   struct efi_fw_image fw_images[] = {
> @@ -125,11 +129,50 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
>   }
>   #endif
>   
> +static void fixup_emmc_hs200_otap_delay(void *blob)
> +{
> +	struct udevice *soc;
> +	char revision[64];
> +	u32 otap_delay = cpu_to_fdt32(EMMC_HS200_OTAP_DEL_SR2);
> +	int offset;
> +	int ret;
> +
> +	ret = soc_get(&soc);
> +	if (ret) {
> +		pr_err("%s: can't capture SoC details for OTAP reconfiguration\n",
> +		       __func__);
> +		return;
> +	}
> +
> +	ret = soc_get_revision(soc, revision, sizeof(revision));
> +	if (ret) {
> +		pr_err("%s: can't capture SoC revision for OTAP reconfiguration\n",
> +		       __func__);
> +		return;
> +	}
> +
> +	if (strcmp(revision, "SR2.0"))
> +		return;
> +
> +	offset = fdt_node_offset_by_compatible(blob, -1, "ti,j721e-sdhci-8bit");
> +	if (offset < 0) {
> +		pr_err("%s: can't find eMMC node for OTAP reconfiguration\n",
> +		       __func__);
> +		return;
> +	}
> +
> +	ret = fdt_setprop(blob, offset, "ti,otap-del-sel-hs200", &otap_delay,
> +			  sizeof(otap_delay));

Can you explore using fdt_setprop_u32() and get rid of cpu_to_fdt32() 
above ?

Regards,
Hari

> +	if (ret < 0)
> +		pr_err("%s: can't reconfigure OTAP delay\n", __func__);
> +}
> +
>   #if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
>   					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
>   void spl_perform_board_fixups(struct spl_image_info *spl_image)
>   {
>   	detect_enable_hyperflash(spl_image->fdt_addr);
> +	fixup_emmc_hs200_otap_delay(spl_image->fdt_addr);
>   }
>   #endif
>   
> @@ -137,6 +180,7 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
>   	detect_enable_hyperflash(blob);
> +	fixup_emmc_hs200_otap_delay(blob);
>   
>   	return 0;
>   }

