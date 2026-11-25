Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B245606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QNpRSeoX;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kkFlMJsE;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=izV+vWQZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69EDC40609;
	Wed, 25 Nov 2026 01:53:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GmpX44gSIJeb; Wed, 25 Nov 2026 01:53:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69732405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795571595;
	b=EI1z90+57nPKnJa3nSOY7agPxrHkTuelOryf9W8DGYuPJwVm4EPMGNSAjNx47APv+RrJ
	 Ih1HmqCgxtsvBNwcjr7X1iKTLsBV+5JgPJ8kTPQxOyT1Jwy41zEB/gzVCUnK6JzImVr0V
	 uOFgZlQRRxG5DepAX4pU2N8OwJlGzqWnWiS0+2Bitc4563wK8zOAOQoTIpTFCUNaMubXM
	 W7AWMa4iEtbya67aprkO+HxVL8v+Iccg8McBqSCconeiOeaiHmOPA7SCTSVr3iz8OYfKJ
	 KzRuq/UQ8/Qq5hDCI571ym9Eu/YHSKX1QPinkXciDFCHdJ7wRzj6J1VDazELKIGhAWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795571595;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6eMvTvL54q4jXIhVF2BePcBeZQuyjEhFFdnP94Sm9Qc=;
	b=QX+BReutXYSOd+43zh6XNTYGJ8QiCB9eSHKwtZDUnIumSiQcAxOX1IghPafNxAb03G1E
	 SnWOh1oYx35UD/PYN5QSn13AtnFScKHL8a/1obrLSjw1c9ZQNJMI30AnroiN0lN39Ecmj
	 UTvQvTMZyv3VzZS3VQCjdjywtIT7iwLhzzw6G12PfC5mwE6dnbqyxJsTPEoV/Ma3t7mvs
	 ft/BB8BIEYQnQKELkzxBRhgf2OnwJUYO1uwQVutnf4e95ENFifPn3jqTpVPaTegotT9ze
	 2q7eHjnS07GtO/cS0i5OP+GFyJq4zTWa+rfDO8LFQ3ME6NQYgxXfWJWKlnmkfKFKSQA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795571595;
	bh=6eMvTvL54q4jXIhVF2BePcBeZQuyjEhFFdnP94Sm9Qc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QNpRSeoX56tpHK6vPbU0fiH1LPhsjP16123yVQhov+MXlhki8SoSetFloHh1TrCMu
	 txwB4M3TcDz64S8sMd0QnXGEtZkKmdBfUwEwKOue3KRTcGjtdzLYf7gTCSgDkiFvLh
	 5kFTAjObkuuJppRVZ98wUAj4cupio46UHRuBoU3SOhBbpeoTZK+ENeQBgNjokANSK3
	 Baiff5OyAV8z4/JmDrkbOe6VnRKiJgWkTZLrVxDMz7vchDAbWGsUeC1uVfYvg/bmPJ
	 PbQikH25XUGQUBTYIbewlceAmVfHQnOYQEfu0EpkMRlqFOrH/Ighoe1TQQ1CY6vQ54
	 McRO1ZEW2BQpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69732405CF;
	Wed, 25 Nov 2026 01:53:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA81325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26E81401C8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lx3zxW99yWSJ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 01:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8195E401D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kkFlMJsE; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=izV+vWQZ
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8195E401D2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:53:11 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AOMbAaW3538257;
 Tue, 24 Nov 2026 19:53:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=6eMvTvL54q4jXIhVF2BePcBeZQuyjEhFFdnP94Sm9
 Qc=; b=kkFlMJsEbfmONLOHcVNmbFE0s216n0JcaeqfhgIcGLdCodjkKHlEzsUPX
 VeX8n6/hS0fy7g1L40ZIRNMCSEUSMeRu8Gj0N1jawDyerQ5KGhRe9u5ZwItxeBxP
 DkOUNUQ7SEu1SRv1G9maVoPPlBnNqczErMS/dJDda8YZlEjzGhPghhgiomDGZrJi
 FZUGCnxeJDV15S4fYw/a5475UdTtlL9BcroQpcvSW6t9+TVSmQviW/ffOphFGuit
 M1qZ/AsOgGV2b0T1QlLNOofue77ORwa+cNaVxx5Qlftk+PW7dAq4tl2ialCB6/G8
 QiFxn84sAI9WEBaBSUGs8RX51TbpA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j50h882ja-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 19:53:03 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eMvTvL54q4jXIhVF2BePcBeZQuyjEhFFdnP94Sm9Qc=;
 b=izV+vWQZTcuB8D9rJMFEagkTIRi5ZXLPBvztIxD8J+kdPHbRprEJG0PTemniXp/K07iqKkUD/KLVsCY0f3rxEYN4Aba5mcaAhu6MKh0WwbGk1Fap5pgaERAq2qLiNtJsmMGc3XR7iXBLDlmIhBeFUa0aVy9ye65uJyBiBZ5N5W0=
Received: from BN3PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:2af::14)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 01:53:00 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:408:2af:cafe::30) by BN3PR12CA0004.outlook.office365.com
 (2603:10b6:408:2af::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 01:53:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 01:53:00 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 19:52:48 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 19:52:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 19:52:48 -0600
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AP1qfe21770263;
 Tue, 24 Nov 2026 19:52:42 -0600
Message-ID: <b8e01963-b418-4436-91f6-56b0e40e486a@ti.com>
Date: Wed, 25 Nov 2026 07:22:41 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
To: Francesco Valla <francesco@valla.it>
CC: Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, "Kumara
 Bhimeswararao Matsa" <bhimesh.matsa@gmail.com>,
 <u-boot@lists.u-boot-project.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Nishanth
 Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-kumar1@ti.com>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com> <awXws804rjW5jkXL@bywater>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <awXws804rjW5jkXL@bywater>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da44031-f67c-4471-3ae9-08df4a96d617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|7416014|36860700016|376014|6133799003|18002099003|22082099003|3023799007|261026140227099003|56012099006|4143699003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|10067099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: f7wKFbBFp8kRlIiSWNIZU/qYk13nbDGy/YLZ7RP71WMMph9v28V2Vs6pgYTmMiCW6xfHPdITowfrvjbKKXoYshEqIsY2DBBZpxPXCkQkSpRzSt0/9EDda4xfGk0TBs5OcG+C4LDnqwVPmzQN9ljcoVzcU8lFXxJp4uz/YZUESRuGUqzRKmNeQbS6nssUOsIkeLA6mVbDDQ4xTHrJ6Q+aef3j9XGx3sxSCG3++4QWCxwa/k++UOL0OlD3LI9VUDPL1NXgkDC25KxdYSIrrRdpmt/rmtjNsYnIGwTDyTWyCw0P9gCY9UK9SXbBkOh5K0vxLlgb/3GEbAROO6uagPVq91SIsz8H8N34CIp3CeuGTS2LGtyp9d433iuNov6NYMvoJ4VpUgs3i1vqLNjRJD32JikRKI6LX4HnL7xcFU/FHcrFjRk2hVkffwzwY2WWNZbynG2/bIAOXwKlWufweDpDkXcYZCKi7rXWvGWDLNTnMchX3dS5wh0y5iffwC4LSTmbKagKBG1DG7Vgf0ldkJW13UCbZel3z7mLxits2mCRuZd7nDcqFV9otvA/B8g5bKb6xNk41RhmIFZrXm0Ie8N1JFFrrRzXpLhp6Hg73xH/tSxYcQ2R5DAH0umdmGA0myaHEUkhmXR3bvtNKk3ZwWypySP8vtV856HsOq+LhPbg524JwJlOMUeOIZAuC/iB5Wf6lKRLaGNXhlakC9oQuOn+MZhhgYof08PgcFCCBIdSm8g6Jd3O8OSgkEeyUJoV1csn
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(36860700016)(376014)(6133799003)(18002099003)(22082099003)(3023799007)(261026140227099003)(56012099006)(4143699003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fPKZg3O4eD7rIjErDzGpsAsfjv1erm3CKryMm5TtNcmeXS//w1Hl89edjNApCXy1hg1kjfn/1d+dpLah6788/LvAXrsjU5NQ3Fz7fVb6EedxKpunM3Fud8HY2oME6nORC2DpZgrSDyjmCVAchoJ8GCSiOaN1iMwQXlaOh3yKBrfoXfTIEzyisuQKDFifwWfbrrqkGuY8g0Lh2I7q2QB6wvPD4TyX5ssKO96QUl0J41g4kBmuFin9fCuRBG8Iy9o57GoWuM/qoT7x80ilEXWQjC1P7Kspnd940dV8nUsj5Zyi6VYVBUXiIrBVhKT+ayq8UyutZkC5CPABbQqdqT8Y/a//Mn5CkmV925HEBnGm+2rnRyZFpgoLBP2I7pGoQZLMZm7f5TiQobG/tAv/+4/1Qu/tVrTlpfJmxs8hCDZUKZqkoFPfkJXJNXqgCuyKYn1O
X-Exchange-RoutingPolicyChecked: QzLPYA+D38DljwQrcil45prxRN9vIVi3SoasTNml46wzRxWa5+bQzeavLcf8ToH1goqMiULYO3I+M0IvQNlfLnkcPqmjCVAv+puDv8D9Glt4UH5T7kx15+8T0sLks6ihg2C6AIv3JeDZt3T8/IPviyD3eHb2Jb2zUAofY8dfNx0tzY1ghWJUd+xkwygFbuC8z5qiRbFh51Ba8/FDqyNIjf/6eMNeiqqzJbbTrjKPhIBvRDDMLm8B+7hG4XyixqQYO7O6m9q6LFoeEpXftGQi+K1YVhigd+Is2ihYOFV81oJUgaaAJ3NdkVO3Sr912/KLT0sEtc3n9xb5YdKHtCWNwA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 01:53:00.6100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da44031-f67c-4471-3ae9-08df4a96d617
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-GUID: fw0vkO5BBYrDGq9odQmMoK0HarKJDJkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwNyBTYWx0ZWRfX8e2sgQC5or/C
 yH5X65Q25Idulk6b0TLRElSDfmZWju/FZsSrDJR2Dh5o0DXR+WhO51dqVHmGLanyJuuPJ8vSvk4
 sR8omz6z9lCFNWxQdWI8cnibqjDTU0oJoUgwMF91p4kJNk+MLb2CEa51LhXsRs8KO6So+f1Qgw5
 v9PYYqThHZX72G7ur9zedkQVf19WshCPw7sbNZ75HBIMAtpdFUizO5J2eNETJmRkjKZPbek2+EV
 rfhuTdjGPdOAANxbviz1EFmppArfS0d0qwvYC7ICn6FpfM2s2pMs7eEO5LxafVOKgs9Wkyw4844
 9phty81U/QTEZhSvVk2vHNlHBS/1oAz1XbP6eZi89KwiiafUetth4mkLfOp6u+mniF3IJlJnaYQ
 H22u0Gryi2ZDEQMJKPyq6x+vFVvwXQzuYoMhHqcMEoVVl8dnZ5gqw/1+vGCM3c+L7bBogQbPk6P
 p6e4TBd+IzcvYWvIMpg==
X-Proofpoint-ORIG-GUID: fw0vkO5BBYrDGq9odQmMoK0HarKJDJkU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwNyBTYWx0ZWRfXwd/XwIrAcZeU
 GnyD8J+0UuyU3Q7s27ybdFWUNTD7rirMLp5yzs9o4R2aCUek+MtXegEaRosU+IfsEV2Ghs3sUXF
 semQHgvIMy9b3W0BKGvG7Fit54QzPBE=
X-Authority-Analysis: v=2.4 cv=WNTqzXsR c=1 sm=1 tr=0 ts=6b063f7f cx=c_pps
 a=04So32024hOmtaefayDOVw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=ccWlRzxFeorHIXAEEnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250007
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco

On 11/25/2026 1:49 AM, Francesco Valla wrote:
> Hi Kumar,
> 
> On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
>> Hi Francesco,
>>
>> On 11/23/2026 3:41 AM, Francesco Valla wrote:
>>> The TPS65219 is a family of fixed-function PMICs for which the output
>>> configuration is determined by the part number. For this reason, usage
>>> during the SPL phase is unlikely.
>>>
>>> Add a SPL-specific option for the drivers of the TPS65219 itself and its
>>> regulators, to allow its exclusion during the SPL build. Since none of
>>> the supported platforms that have this PMIC onboard modifies its
>>> configuration during SPL, default it to N.
>>>
>>> This fixes boot hangs on the boards compiling this driver but that don't
>>> have the regulators sub-node marked as bootph-all; since commit
>>> 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>> this absence was leading to a silent boot failure.
>>>
>>> Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
>>> the same configs, so it's affected as well.
>>>
>>> Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>
>> Thanks for update,
>>
>> I see this PMIC is enabled for below boards,
>>
>> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
>> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>
>>
>> I am wondering, if PMIC is really needed here,
>> Do you see possibility to mark PMIC as N in respective board ?
>>
> 
> I'll take a look, but PMIC support can probably be dropped altogether
> for them. I still believe the proposed change applies: in case we drop
> the support in U-Boot proper, we can maintain it only in SPL.
> 

Well, for changes in this patch

Acked-by: Udit Kumar <u-kumar1@ti.com>

Irrespective of that, you can review usage of PMIC in your board.


>>
>> If you look at other boards from TI/K3 using PMIC at R5 stage not at A
>> core stage
>>
>> configs/j7200_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
>> configs/j721e_beagleboneai64_r5_defconfig:CONFIG_PMIC_TPS65941=y
>> configs/j721e_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
>> configs/j721s2_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
>> configs/j722s_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
>> configs/j784s4_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
>>
>>
>>
>>> Signed-off-by: Francesco Valla <francesco@valla.it>
>>> ---
>>>  drivers/power/pmic/Kconfig       | 7 +++++++
>>>  drivers/power/pmic/Makefile      | 2 +-
>>>  drivers/power/regulator/Kconfig  | 9 +++++++++
>>>  drivers/power/regulator/Makefile | 2 +-
>>>  4 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> [..]
> 
> Regards,
> Francesco

