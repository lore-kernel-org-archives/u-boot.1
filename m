Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C7606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XOCiUQxV;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Jz2W+jfG;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=aVw9FaWs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4AFA607DD;
	Tue, 24 Nov 2026 08:21:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eAXQ-R1kS5GH; Tue, 24 Nov 2026 08:21:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB3F1607C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795508483;
	b=Sy6RgiN4JtrVlsLjzGyS/mjt8oHneE0YWW9pzjw01d9fWBQaZYvf35+0pRobuCIc2gCE
	 x35FsB+F5pRV/ZiiWu+1g65EOb5Z7adcHvBTNZNOe1qQBh99IJzQ5wJ5BkDQfLZPWwjxT
	 WwXHLBQZ2+fMXUmt2/TsExkQwsfiYgpkm5eUPyMfhF4Xqvw60CSYr1Xeh8mB0N58p1wE7
	 tMWOiOAVKbuQbo8QhHh/DgdKho1zZhauL6XFU+CLVw36RG9nCXHJDHjmEZGWu91C1wU4O
	 t398onmPHKKfSXQMUO7sul4tM0/4PVC1qmVLSUFqh9es0QnLxZwR1YwpRmAMyvCIkyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795508483;
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
	bh=tRQXviaLmvfhnAmPPuGdYDEf6IEa+T+5Yjfe70ci9Uk=;
	b=IhIZmREqZ6tJDzX8lRLsklR5DNPRC8isVPJt3IlvxRUoQaJMRdkOtl/0lfAF/Q2mi7l5
	 yj1z8sbpbF5Dg6eM4wgP25wKbJJke55bCko9tNO9I+QAqF4yELjwSpQSeWuzbE4at3QDI
	 n4dAEKxYa3u1pH1B14XhN/AKHhKJaQKr1vMnMPiT3Vw6MbemA21qWEJwwxbzV1T2QmaKB
	 U7+gmYx9hpGFbLAelLQ3K1k5NTuHbn86Ce6nNBQ8mh4hrqLmysYGyDwKwxD0busAoPQUZ
	 zUZelOp0aEtXrhqcWnOGg1WXRFyQ8MY3SyeKL+Sgj6091tqjkQ1W1Zbrce5W0SaLWMQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795508482;
	bh=tRQXviaLmvfhnAmPPuGdYDEf6IEa+T+5Yjfe70ci9Uk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XOCiUQxVRqqAmHMffhSnGzSrXGECwKyUUMHFnekdMj7Aj0nUtQbzPbDL/NhjkAFNG
	 Bo5QUdsu+otZa0WTko8+7fCDMHWfCluUoHbudvCWjDPQHGAnWRxqoSWGhb9zg3PKsV
	 wROOz8H/l93mfKhtKY7MpGNfhAycrhqXAB8PHTEfwygGbIBqyam9LBD+Y5PMF7z6/z
	 p8ZflPHVxzDtk00UCBEocN3BP7gvQa8tyytttO1reLNcYNFDvu+KY23zKG/tqNCfCF
	 a9wFUXepiux5YXZGdvjsmCNg4+FdYj01q5P6cYS1w3KAdssR8DXW7y19nZQe1L+9j+
	 UzkBibbN50FeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB3F1607C7;
	Tue, 24 Nov 2026 08:21:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D89C5260
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9DA6402EC
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wg0PyGNZHh44 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 18664400AE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Jz2W+jfG; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=aVw9FaWs
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18664400AE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:21:19 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AO7u6hS1303058;
 Tue, 24 Nov 2026 02:21:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=tRQXviaLmvfhnAmPPuGdYDEf6IEa+T+5Yjfe70ci9
 Uk=; b=Jz2W+jfGazP73aTIqdJggv+8nrlkUSJR/QByihFNkHyRZp2TAO9oUnQp4
 nNpdE6F3Nw3MMRaNbkGREo5l8yu2K4/RTzO/T0lcy32CYM/t2ND3Aie1JewwZHwz
 aC3fS4JlyVUODiIgPJciYHGYyvSDNMgHJeGoElDcgVRQyNZ+lYsEtZLFORH7hZ3/
 ItO3D5QphO4CvryeoPhwfGWqp0TuBpCT6+ga4c0AMUBxI/vhpSZ8QCXmfo2yL5Ot
 it6FYVA4w9/decwfS51vIStTm4K7SYq1i7EBBFyfBqi25Blu2FOUTOxxVQH3TI8c
 4zhkyIpFf4cP3LxG7fdlXabytwepQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j50h822ge-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 02:21:10 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRQXviaLmvfhnAmPPuGdYDEf6IEa+T+5Yjfe70ci9Uk=;
 b=aVw9FaWsXm2eJMvQ0ifW7CbVFwCon081qxfatqtqfdGkpijfVnMcVxsCiVjJRCZ6uQvAsLrB/o+S0Kdpc1j3nMK/u0eckRRQHaocwGiGG2w7dt/QmGltZJS5nQFOChD7VjLyYUuL9hghLIn6qFVPG1awvga8VYouMeSnIwys+58=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:21:07 +0000
Received: from LV8PEPF0000006A.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::27) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 08:21:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 LV8PEPF0000006A.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 08:21:06 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 02:20:58 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 02:20:58 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 02:20:57 -0600
Received: from [172.24.21.188] (lt5cg60819vj.dhcp.ti.com [172.24.21.188])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AO8Kq03236640;
 Tue, 24 Nov 2026 02:20:53 -0600
Message-ID: <7694a64d-b082-4e01-9567-728d61aeda38@ti.com>
Date: Tue, 24 Nov 2026 13:50:52 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
To: Francesco Dolcini <francesco@dolcini.it>
CC: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, "Peng
 Fan" <peng.fan@nxp.com>, Kumara Bhimeswararao Matsa
 <bhimesh.matsa@gmail.com>, <u-boot@lists.u-boot-project.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, Johan Jonker
 <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,
 "Nishanth Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-kumar1@ti.com>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
 <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
 <20261124063622.GA5917@francesco-nb>
 <8edb588e-5bba-4808-b50a-2831afa42978@ti.com>
 <20261124080156.GA80059@francesco-nb>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261124080156.GA80059@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000006A:EE_|SJ0PR10MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0680bc-f5b6-4a0d-bc5a-08df4a03e36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|18002099003|22082099003|261009223027099003|3023799007|261021121427099003|261026140227099003|261022105027099003|261102123227099003|261026121527099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info: RvTso5H6kmXgwO4SfDBd6yq/c2s/eicFBJ0cX9hIGXDzbzfqJLQAIGFFlZxUkqz15/0tsBsdyh7wXxzh+rg205YSatdW01NdHKMkvqsH6K8h+0k5yTZMFViWGrRJPZozTlnRfIAvEWhEak4APDByqqLmqnP5CgcBnncdznZAFtqJ2JtDhe/H/YHyZvA9pCEvHbluiVcYwPsOFGSrxL/Xdxiaz24bNGsZbh+uM/A4dhwbsrs4UqmQhJc+Fv8ghBBIJXwB9ZKH1jD4rnODsUSfGMpx3CLxDm3Yn0dNQdmHGpsHkjzCwZljLfNzhwfvOxzL3ZxDh/YgTwgP9oLGjPP3EFxBLKhghKDBv8nlkmXSAGv26ITdAbd/ETTBxLXoJxC2aCg3yr2Opio9ptAAyqEKFBXE8XY2RSGq/WaHKU4TVci3AVk+k4UY2zTCDYSyrK9D3f6fR/IDPKsqwc44NdR1KPm7mhaIU0D3wW0qNXRH/MnP7WICMMzVjUEKvowJWGess5u5kXeyNgx+ii39NkJC4pnmNasg2C4jTyD0oU3t1I/3bBlD4ECWUubsjrjR2KQlh+65NT1AVyR7eA6pqIS7EG1MRRz+NOfW7P3SaK0wtF3FZtRHtBhziYZoUUW5c2tzHKeIwBWcPN74xNAzrei9lzTtgKXVksM/9r1usI6Zlz17Cexbmdsg/xquSMGv62SMm/NgX/PtdrzdjunwxhwevPfk4tsZ+N4vVdBue908m3BTsYdSRX//fBN6HfdebNndkbalq6NWcRwCUaIjdPp2Wg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(261009223027099003)(3023799007)(261021121427099003)(261026140227099003)(261022105027099003)(261102123227099003)(261026121527099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zrdXr+RSUgCf3Gt6UToQTQ0j5K0HoNUqz9jYB+n2FK4cUsdtXXetvqq2e5SVndTp54PPoX7A+Heqj1kPIxsKxe2L2XbentsuXdRYxxPL5mIGCsHRePlM34zzgV8Y8Q4gQ33rnQRPQxtOGPxT2B0/f3R/xozcLQoXoEW+RlwwvN+SA7dYSLjJT1/ruQl6WKG1Kv1nApXnvTsOh7kKJiX+u6AycrDxGos/aIomDdRP9u59DpNyq5i1HVpPkz+DBYSFUY+pZ1+o3oI7DApKcelTIcuMQOmNv2qsWza3nNO2Ez/o9bZCxNcJMPQmGRJxw2GcZMLIqx36Wl6C1i1rOrllaleOfaE8M5J7+XJUjnHULaQleEtEgfgTbcJSWPAEgQzreJqOMaAkRYqn4cTn0y9GWOsXj+vpFbfZIAgoQPNeec74lj2MlI1vg6jxQIIRylEe
X-Exchange-RoutingPolicyChecked: QUw9RWA42Lz94amOox2aXE+uMGtedVk95vHAgrg/Ovs4lxbZo0KyTJXPXpFiHamnWsEwKL+JnGUr4E4+W7c30iINY1g4Zyhu5hNm5XmtqWyHCz2pe5VrA4ChlzdnmHEPDM/so8tc7IkcoiDSxEukGWaDmcb80kEVXeRzLFz0WtZ40jcbOf1sNwms1nsj8O2wJUZm51E3VpL+5tnH2rReFxi7PttQr34LM5pr4nqvISeanqUVITBQbi1TIWt42b9MA0LMqHoOOEshgf4gT7HID7D/dsGWQpK6vYU8nX0D184/V0M1cNeBfa6mV4Vm9ceVrbXZX6gFH8tUX4ctHc1rYA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:21:06.9683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0680bc-f5b6-4a0d-bc5a-08df4a03e36e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000006A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-GUID: qYpf0DJHE3RhUiVNLC477sxcUUiHcJKJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfXy0S5Y9V+uu5V
 hZnpPwR7WU2UxvW0ItFJuCVe81IJlkyZ8mW7nTbRhFiLa3rnY/aCyGqkjF5yH6n3wBLanBLyse9
 OLiLdbRCgDBUGU2MXQSGeBM0pKeuSeEYPEYkhoL2bXAI3r/TPNfDTtymkyqVXN//AYjNLfHOV2W
 C7rsvDyDoVDBqOy4+d3MFgzn8ZEMiAVIuCMsPaWiwjU4fkllzvCjuM6ZF13/5afsZEIx6HzcQQy
 yU+yAvWyV/nYxrkWjJvxXrgL3ZU8BTK4eit1jVDWSUER/BFJCT9zZVvebekHAAk5CgCi7B50LnN
 l5aHhX858O39R1K/R8gZb7GPANxVNczWWMZWcO2+f22AcFak0zDluBZnp1KDU/lb0FlXZgH6cl+
 BzWq1ZdIBDRpDIPCmqB8YMi1T2MfhRcWiMsc3xsfG3DJI91DniBN1dqMMhD56fDWKu8HjKm32EP
 bsOKHuDrPHb+4W1AkXg==
X-Proofpoint-ORIG-GUID: qYpf0DJHE3RhUiVNLC477sxcUUiHcJKJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzMiBTYWx0ZWRfX4qQWfQGSvCd7
 I2z38wwhPSZEBgYMTBV+ZIBEI/aPcKtfXGFIcmyHO88EIms0ONxmjDF7o9HjPtqAcvfKKTMupPy
 BzA3mEPYrIMNPYf5VcAXyLSOnzhZBw4=
X-Authority-Analysis: v=2.4 cv=WNTqzXsR c=1 sm=1 tr=0 ts=6b0548f6 cx=c_pps
 a=LrO9QPEl2oM1zDNvT4V0vg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=-biX-WxI6gqYQRcpE5gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240032
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/2026 1:31 PM, Francesco Dolcini wrote:
> On Tue, Nov 24, 2026 at 01:10:13PM +0530, Kumar, Udit wrote:
>>
>>
>> On 11/24/2026 12:06 PM, Francesco Dolcini wrote:
>>> On Tue, Nov 24, 2026 at 10:16:20AM +0530, Kumar, Udit wrote:
>>>> Hi Francesco,
>>>>
>>>> On 11/23/2026 3:41 AM, Francesco Valla wrote:
>>>>> The TPS65219 is a family of fixed-function PMICs for which the output
>>>>> configuration is determined by the part number. For this reason, usage
>>>>> during the SPL phase is unlikely.
>>>>>
>>>>> Add a SPL-specific option for the drivers of the TPS65219 itself and its
>>>>> regulators, to allow its exclusion during the SPL build. Since none of
>>>>> the supported platforms that have this PMIC onboard modifies its
>>>>> configuration during SPL, default it to N.
>>>>>
>>>>> This fixes boot hangs on the boards compiling this driver but that don't
>>>>> have the regulators sub-node marked as bootph-all; since commit
>>>>> 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>>>> this absence was leading to a silent boot failure.
>>>>>
>>>>> Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
>>>>> the same configs, so it's affected as well.
>>>>>
>>>>> Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
>>>>
>>>> Thanks for update,
>>>>
>>>> I see this PMIC is enabled for below boards,
>>>>
>>>> configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>> configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>> configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>> configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>> configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>> configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y
>>>>
>>>>
>>>> I am wondering, if PMIC is really needed here,
>>>> Do you see possibility to mark PMIC as N in respective board ?
>>>
>>> Verdin AM62 and AM62P are booting fine with
>>> U-Boot 2027.01-rc2+git.eb7af371cb8c (Nov 23 2026 - 15:22:38 +0000)
>>>
>>> No bootph properties on the PMIC node, and I guess also not used on the
>>> SPL. We could save a little SPL size disabling it.
>>>
>>
>> For normal boot purpose, you don't need PMIC in SPL or A core u-boot,
>> unless there is specific need.
> 
> not even for the sdcard voltage switch?
> 

Yes, you will need it, if sd card voltage switch is needed.

> on verdin am62 we have the following
> 
> ```
>  [..]
