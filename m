Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E44606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ng+Cy1Zx;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EbkR2hiL;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=GKQ+4upY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 639DC607A6;
	Mon, 23 Nov 2026 16:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4iim1Wvccv5p; Mon, 23 Nov 2026 16:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AA8C60789
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795450209;
	b=M0sfH+X4tDqwSmzO/88J0VBIWTnGNfQCAdv2uJze1XB9j/68yWu+i1cuZIxn4wUOstrK
	 S4uNCgD9u8XQjcoRoSkgFPoblmOEkqZgBOsg1eAliejB8IiZWfoRwdXMmsX66EDUSPFTA
	 DQb7CHKgEaPVKxIzzCFxhEqB8k3LIiEu83JSNlq7BYstcwzC2TPSExwSGJztHEjJPet0+
	 mOo36WzdYePK3LcG41u2g1wQIZEUysIAFQlmGFWGo2kk6YqlMJGpxRd+fHxFmlHRPktsG
	 QxYnKCqvD7zFLrikGqVzYJUCwZuw3+Od6/ltO/0KNmLLalg+PEpAGJ8exmfg5WUr4sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795450209;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DxnRubfUf0HO6O/miP4t6EVM79lW7QxA/4aTuW1yp/U=;
	b=Whg9bPyLrpYwRdr+DNw7C2UZNvnhg9m+qCgKTgsoXPAMu8pBAFEbnHqRILt1oAJMQ4DF
	 D+YNbzgvW4dVBEgcmlNd+rR/yRx0Mx8jl1cY6Ptg3TlZQS5hF8Cx1nTOhi0N/GSrqPIAF
	 Q88kKPukawVZSx0DJUgMWHj1q/veFJhvL3NjAr9qyiCzAvBlVs+wGZSVbLqz6ITtRGBEH
	 YclLWtzOlcCmzZEOUUWmn9SfP6Qrx1NixqCOFdm7GobS1HEKifseFfprv8wAURXgZp1qh
	 ESjabuomZnd/ZAVh2v1C/BNAHuvJgOQN5mFgrbbBXVL0tHERdL01vqKDwicuxsBOcsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795450209;
	bh=DxnRubfUf0HO6O/miP4t6EVM79lW7QxA/4aTuW1yp/U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ng+Cy1ZxMtnPZeAn+lm8anwgXeo1OBivfEWyvuVThIiQMXb1aE4WW7sduTMm4B5C/
	 hpkDJ4h7+OIo0+gSpcdA2ewHkyhKNfCAIalle9sGeWgrE3FNfFTpAbS1n+99C1z8sm
	 Z8js/eM0s6OD/Swp4fKo5GMKf0fO8pMF5FOIS03Wy5kFOjMw9cWKXb1sGp4Srj2sy4
	 +zGQmxlzSTeH1o0FkdRenfPP3LJIyk0z7TWXzObBkhWv2zvglnN/AN1PYMRpw9UUkr
	 +GwOfvhJlaj9XmEe5Hbzqip/eB/nXklyHfHovxd6paCjN2gRpk541KkSNgrX8Hu7Nz
	 KXdk3eCvD3pAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AA8C60789;
	Mon, 23 Nov 2026 16:10:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35183499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11A2E40675
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKO1c4FEhZl5 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 16:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 636204066C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EbkR2hiL; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=GKQ+4upY
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 636204066C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 16:10:05 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDKWVx3363007; Mon, 23 Nov 2026 10:10:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=DxnRubfUf0HO6O/miP4t6EVM79lW7QxA/4aTuW1yp
 /U=; b=EbkR2hiLcfhosnmQYNllKP9QiFDT2Mk7kmsUm29wVmGestND9cCp7IT7v
 Aj1S27e2KVhZDsoHRytnhvblcllqIKyY79tUgUp0g+3hOl9aa5lHBDJ9DMJedjOu
 WkXDu7kyvJAAr4xBpgSlMe5g1X54C4RzKKFMJydhh84CihveSYYz0mCT7YLmExo6
 aQ4C69rh1lfbJvtYUfQqQYvJfvFVHPRbcOYEdYwOH0j3e7iDvpBaiX3C7dJeDnjD
 OB3zC7sBvP4KsGgswpvx4K1rlIfc0YyvW+Bw8g15qQJNcGmLEnvOf8gsd6MtW8Dy
 AbfTQ7jZQG7WDSYx5fWtJ1DfiRK7g==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013033.outbound.protection.outlook.com
 [40.107.201.33])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j3uasqdp2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 10:10:02 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxnRubfUf0HO6O/miP4t6EVM79lW7QxA/4aTuW1yp/U=;
 b=GKQ+4upYT6TJllz7loQ5cC+TJDgj7VKzlx5dqTb66DidpwuCh5FV0MH8ZKYIni3/rT6Xm1sHL0pxG1W4psCczw/WDgK59Ngng10Foz0Y3vuCIUNQGwwesS7lCOvuWrHx5EbB4PuASo5JnfS5U6bI/Gt0WIWiIrfp9nl3DJiXv0c=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by LV3PR10MB8035.namprd10.prod.outlook.com (2603:10b6:408:281::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 16:08:34 +0000
Received: from BN2PEPF0000A98E.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::4a) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 16:08:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A98E.mail.protection.outlook.com (10.167.248.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 16:08:33 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 10:08:09 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 10:08:09 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 10:08:09 -0600
Received: from [10.249.33.32] ([10.249.33.32])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANG88T12987519;
 Mon, 23 Nov 2026 10:08:08 -0600
Message-ID: <df5e2301-787e-43a9-b7bf-4081b0267133@ti.com>
Date: Mon, 23 Nov 2026 10:08:08 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm: dts: k3-am67a-r5: Fix DM2TIFS secproxy thread ID
To: Francesco Valla <francesco@valla.it>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
 <20261123-am67a-ethernet-boot-v1-1-94520ed74c90@valla.it>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-1-94520ed74c90@valla.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A98E:EE_|LV3PR10MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd1c45a-4c5f-4907-4805-08df497c05d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261009223027099003|22082099003|18002099003|13003099007|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261102123227099003|261028144727099003|56012099006|261021123027099003|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: Y3Ypl3tglNGEil0fvBQfy+gKncXKH8o3OIxVyHXFPcdULVKM6iaJEqyse831fNgBAaCpZF0Z4z9fRVXYDtEp5Z7UQnvsAeqIlnGVB77H7XLsqRUntulOSybRuJRLAJTih8HiZQwIyfL9CuqteSUEQ/bDkm0NHdCr23tnsuK5ge6bxkW9PtvWqfW3S9w9Q37G6+IJ3Y3oeJU6/jcNeDZjDZY4NN9y7fXkT1fYuexF9NOcW4wZZEps3oULAv4N/mNMqcfWj9LH1uBQjwtmBjq4zZEv9X5xImcCgRyLlknAk++GYAwTx9HHREtR7AnI/ft0SNCU4jAwpg+C2toLZnLOBae/hMrRmcYpTrCs20kBqYwFAe70F7xP4LdxyEawyjLva8hDlJYeY021vcloxqL0JkqllBMGQHW0Gec5DJ8xTg7yfpVnGvrMEUdfl/Th0XLIMe/j2Gm/faVWVORtpReQlUMpDtPzAV62/gIpQ0xdnSlNMYI4zDCguJjjCVxz7q0u5pDnsljmBxg47WoUntyxobX8CjNRsLmNSfi+dOPlv9c1pZ489Psozt2ZfYkBRNziiFdrxAFYrEwQLO2+ANHa+9Ihqnqs2yPz5nuorsSZqAIOc01wVO5uxjSJhJGmE5e6uQZ9V2zLg8z83hNozOU8xligGgPDuGxVF1MgLahkBbyUPbRfp4OfyLlpZ/ovvlcfJK9K77XQeVwOGNZ/K0iq9Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261009223027099003)(22082099003)(18002099003)(13003099007)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(261021123027099003)(4143699003)(10067099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6SM+qYdfcENfCc+re6dA0BQ4OgOxWzicbquihO7mo3XF/dX99EaRT/bRR9N1Uy0BXs9hcdzu0skR42s9UtPBUZll30AYOljKoug+7EfK9X1lFeDIjOMt8/Sv+xehUAOd6Ef8QguXz0ERKlWWXZW5Yj0TvH0REEb8anWNm1VJmua62i/Vzy6Kv64ww3uL8gX6faKrCeS9JWTycBCQ4xAnOL/lZIVDpaJLS3P+jFkCKqOj2c990LMyMcAfOhpsuPy2snPxHfNpZ4GsX1juzf+S7iPRThNjxM0l2IlKPzt1PEE/5CN7BkqOhrIj0vjcjuSAfHcQ2+sCt6fTLoIwVTmnibl+NL+fG/Iv/MPZA/erWMpXeC4V41YLUV6aUbFyBUWGGgwDx1vWTvTUIhLX2rK65emR1uWDKiq53bPTkkXf8N6sPpELQr77OsjN2F7zI0mV
X-Exchange-RoutingPolicyChecked: idj8ucB81Soz4zeRd2deBev80+2dhuSBGVgJRS0YZCip4Fkq3bVXlYCIdMqDm6hIf2ZlU3DYjqo5hBn9mJMNL56c+RJcEV5ZnfivY03Gjy+iKSogvVw+bZcbSIX5EbhWD/JYRWXdk0cCnNCstWBJyJ3QD5suUfbbl4QQA8alyXxRxZsgjWB91Rz+DNE4z52xh0Q3xaUvQTbA9UxU2Z4hoxcHtm1vwyrBYyzKfp66cS5ztjrnAwhhPHT96g179sDfYSOeue1YAxGLalZFtsnJs9U1gNHnAlIGN+A010eM7/+UlloqjUdr1tc1oEbEaYNb6dPsxCiOfZbKDVeScUUOQQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 16:08:33.1597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd1c45a-4c5f-4907-4805-08df497c05d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A98E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8035
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX4JjRkAIwnCp1
 8JVHtS75aUTNd23GLl8MNLncV85C+Ghx6d0kEZoBUHIPJmV5qoY3BjpdlNnrnly9Tbidc4p/ks+
 lVwFsi06/fVgerUhqJnrr2zdqpop0Qd8vAj/3pEkCAvxNG9PkbM/o803hCIsOJhuS7bROZ2J4I0
 qqt/lm9MQ1bwHQaiOuolZmntYlUebziRy6WW5koeJ62ITVUnls2CBSLuo8JFjopC9ajhZA3JIGs
 R/ASx2g53q6ymEmWGZVX8xaA25YsCZTqmxOJPqklLXWs5aQzi5GAHlO0T9X0sBQEDvLVMBKXt4z
 9CK/esPwd5X70EtP0I8qcZ6AvxWmrGNfzDGuBQPRf0MpGhiHELRcLvspdXxncpZ9S6ql3ZD95DC
 TqoZnNuEg5TaSPr+VwOzceaSpGnIXeno9JxAhkyUvfYYTgnQciqfHbM/aYJXJ8fpOerl6TVKLXf
 Cyp6MjQmaj91rBbnrPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NCBTYWx0ZWRfX/SteIih5yl1q
 9XfsA2yEZFdIP783bBGwuldG8S0yu8LdxK5YAmqgHSeLLwGEWbYPDuJr0VudN7d6TcVsPtEICtY
 UG4HFngV0qWXmY1kwtvdQJDBIi7aqkY=
X-Proofpoint-GUID: FK63WmtgXlZVrqkJ7nJKFxL8UlYtFWEb
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6b04655b cx=c_pps
 a=H8U4Gh8omvmqDI9iB/RWMg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=wzCcmZIUEWaLTjRIvyMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FK63WmtgXlZVrqkJ7nJKFxL8UlYtFWEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230064
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 5:54 PM, Francesco Valla wrote:
> The DM2TIFS secure proxy threads for the AM67A R5F are 28/29, as already
> fixed for the J722S EVM in commit e25900438256

AM67A and J722S are the same device (family name vs market segment name).
Content of `k3-am67a-r5.dtsi` should match `k3-j722s-r5.dtsi`. I wonder
if `k3-am67a-r5-beagley-ai.dts` should just include the latter and we
delete the former.

Andrew

> ("arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread ID"), following
> the TISCI documentation:
> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html
> 
> This went unnoticed because nothing in the BeagleY-AI R5 SPL used the
> dm_tifs channel until now.
> 
> Fixes: b27c94958b97 ("board: beagle: Add support for BeagleY-AI")
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   arch/arm/dts/k3-am67a-r5.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
> index 48bd15f480fc..22471badd321 100644
> --- a/arch/arm/dts/k3-am67a-r5.dtsi
> +++ b/arch/arm/dts/k3-am67a-r5.dtsi
> @@ -33,8 +33,8 @@
>   		ti,host-id = <36>;
>   		ti,secure-host;
>   		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> +		mboxes= <&secure_proxy_main 28>,
> +			<&secure_proxy_main 29>;
>   		bootph-all;
>   	};
>   };
> 

