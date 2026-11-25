Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3827606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TeDAdDIk;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SzSLmt0C;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=jtCZGTf8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ECFD6087A;
	Wed, 25 Nov 2026 01:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id thoXGzk3v1Oo; Wed, 25 Nov 2026 01:57:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3381E60876
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795571833;
	b=lC6syJrlAGGyMsPo0TWD48noWdHyPVIIVqtt8cgx1s/KRx64LuuvxYRmnoD8SUPrKNhl
	 3N9XZbdqxtKetkO2Ah+82QvLUPISudbRZ6NgrS/hEIJ6OWOmkf3j+VTxR61dPoxMJeqxW
	 7xCB7DSnseqeeEj+hnV0E/YnrqaVTQc/1Yswz6pJT5oJ/DCvOWDu6wZuRdYZ/biZVQ3RO
	 4wgaDOo0DM+Az9gKkPPhKBmfyyMKBz1PpuzHdtLXqJyULsCpx+9KvjXODwqIGHUEX5oCL
	 3R4ruKrWgrZ1nBMGAjEYWYPlv5r4FHxFLlXiIvBEoOqh+++uh3lxU3G1w30THz5V3QQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795571833;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J6A8HBVZnmAR6Xw7tjretKDoqbqfAHs4JAZq4pqekoc=;
	b=pIyks4q13sI2HD4x+h6BF0mKWX+hSltfxw5FAeyC7Pwcvm4op9p2OfnacIBMGun9ODsZ
	 qgS1lkbXMtazImK/ETALWc9DDJT2xssevOPtmzfF3dwPVUJ4JeIIaESyk/xgPev9rteEh
	 ihLDmh172zJcwVO5xxuifLvsUqTZ2mt6RFJBtOTcWQtq/TwycMDJVioqh+aNUivbxtF4m
	 LuYRFiQNtCc53EXU/AhgYzwvL4ay/BR0G8IVYBAl3xZBedS2EESaYCr9zYBQvJvv/dgzO
	 U+reTceR8neDCsvtJu5aNSHftK+E+7Nok3VYPS21Y43UXOuTSEwhkYQvKw3tSddH0hQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SzSLmt0C;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=jtCZGTf8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795571833;
	bh=J6A8HBVZnmAR6Xw7tjretKDoqbqfAHs4JAZq4pqekoc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TeDAdDIkvcuO5NS6dSptXPL97dQATQNgFFm/QASi50EHTNH0hFvJuXdorvORaInk2
	 IVtI7THM1OqnWzQUqu10IpQPYgFYoXEgiVvgD/+mI5jYGZIBzeS/GHHPyWUpT++lvq
	 SNllK6X9npqKI36hWy6ICkrPer9wJweSYn4IPzSjV8EDXmDkJvdxCGt2xljMMILvvq
	 rvlOPGMoJ4vpAUloVUB/Yz4GQhhE2WulHh6a1CqeTjSEH+T/4wFTH9UeJ14keRMwK9
	 ih/XSkXbIGvDhVq4gNtR99xFwIRkoBlHxbPZ7NxhMOSFKnEXMtJMgpND+jJTzcEyDC
	 fv0KiJ5IOeaow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3381E60876;
	Wed, 25 Nov 2026 01:57:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E7E10B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A0AB60876
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2qwAEKIo8Ov for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 01:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B1BD605F3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=SzSLmt0C; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=jtCZGTf8
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B1BD605F3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:57:09 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMZuA03781682; Tue, 24 Nov 2026 19:57:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=J6A8HBVZnmAR6Xw7tjretKDoqbqfAHs4JAZq4pqek
 oc=; b=SzSLmt0Cvp9Zp3wMIA9nzByN98gqlTPxv2M9SluT8TAq8sntf3F6c6p9X
 nHXCDzvdslxr3LzEkJzVew3UfiORiiY/2oSWoHkkuVFprzdPjXhaNEUnTFataRfh
 Co2pZCcN3Y6yt9KWIZKFfcjBrlEqUVm44RGVlwflZLgZ7h/VoW9TXNTn9ah+rOr0
 GzYc4g2fD0OGvoT3tRo1F/Kj26RlFPg/Qtqce1yFpx+467FP+wol5j/CNH8bt/YM
 rqiJok8QNZ0Upda6y2J9WcMSm2WjggdLpoebM6IdwRyeGUjxQ8cXEUb+ETwik5/c
 FxnjRYvR0vDhOEDWggIhpKWqG9E2g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j5egqapx0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 19:57:05 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6A8HBVZnmAR6Xw7tjretKDoqbqfAHs4JAZq4pqekoc=;
 b=jtCZGTf83CITo/uzrgviXXE6ZcTbYrkEDNGrlZ5L7wn/NJklC1OCzjOo102BZZOqVn+IIuZtoshf+HA91CzWN4bMoVOG3gLAKCYrp7ytcrNZFQH4ikhvN3kcPTks1EV3U7otT94/xfBvDIeoT2xjDuhZC47s1e6n8FTqMLM7qaM=
Received: from BN9PR03CA0982.namprd03.prod.outlook.com (2603:10b6:408:109::27)
 by DM4PR10MB6864.namprd10.prod.outlook.com (2603:10b6:8:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 01:57:02 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::86) by BN9PR03CA0982.outlook.office365.com
 (2603:10b6:408:109::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Wed, 25
 Nov 2026 01:57:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 25 Nov 2026 01:56:59 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 19:56:21 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 19:56:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 19:56:20 -0600
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AP1uFu62762826;
 Tue, 24 Nov 2026 19:56:15 -0600
Message-ID: <5d6b5469-d628-47b4-9ec0-77a8e5eabee6@ti.com>
Date: Wed, 25 Nov 2026 07:26:14 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: dts: k3-am625-beagleplay: drop bootph-all tags
 for regulators
To: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, "Peng
 Fan" <peng.fan@nxp.com>, Kumara Bhimeswararao Matsa
 <bhimesh.matsa@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, "Robert Nelson" <robertcnelson@gmail.com>,
 <u-kumar1@ti.com>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-2-20492ba3f1e9@valla.it>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261122-tsp65219-spl-configs-v1-2-20492ba3f1e9@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM4PR10MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: a21227bc-8c92-4f06-daf7-08df4a976443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|23010399003|18002099003|261009223027099003|22082099003|13003099007|261022105027099003|261021123027099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info: LvSY+zKEFW6Xt3aMURVDwHovAktC3Y/tZBJYj3lOK8LLZjfNNFvu3vInw72KY8lrMXuDSKur/f7MCx3FlhG53HS17N+I4drM2cTjYODfRzE9gV5TSaw0z4t8rQPKZK44zAa82q3awFavXBpe9tAdpT/LqywZGsa1hh5f9APo8JG8INjFJjjo6rSwvnIK98vYgVQ0EXCMHsFhd7/47TnPYjozFu2P68gKRm6M2rJWLrQNU3pbYZBdYX/+glqGs4spV/fCVpf42WfrFVL8eGeS74fxpCBiOsDehbgUpEM+LuSJCWOU+0o2uhcrA+wDQp1j4fQvGkncqwakhOcxpS+9onrwsRZlnDlmMG3KCTXWAz7lb2I4LaZdFRlDSx3uHakBj51I/Nuzv8c6ITxfBI/6hKRWQHeVIgSIlRxqjKzM1ZEvCwlUuBiJJKW+GRUykYtq1v1Rg7QwOmVSE68yBxi1iinOqCaX1/GjazVNBhI+DdjA+8SeQ/1OrURDtahu36aQElINtGaXlAM1J8eKF5XqeUDuIaH2J/+ks6AKavRI1uY19dYCrP69wvJYv/W2kISujzEA/onIsoYcTGjX4Wi1iHAouhxEgHGiFalhAgoepxaht4Gsrx278ugoUwGo5wHmkXvN2jY4en2lZK1KfbZJq+cCMK/YgB0BLWKeupOI0uQ2O1mebilmYmybWGbIPoMju/IDxAUoOzgju2OAPXGxmA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(261009223027099003)(22082099003)(13003099007)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7eNrOx+mpwVGpTI7YAeBZLTffLRO28j+KEsGh4vmXxz/gRjJvHO2bJagI7SdCQcE2i04hmOEIsWfOvmIqZJSB0jgLVptjcQA6mVfj4AGVcOXhEbWw5vLviYKM0CpKKyh6ggbN7zGGJF+XbfYP5gTvrQtetj0rUZB4aGDCe27MQknAwz7FtXhGpDQ53HJRkOeFkUAIlRHWuXy5m7xr1mm9HuAAqyfZ0+ymVRxQba0e6CoX2Ar9Iu1trOGCMqW0GTNzqgUx0/FgvA+/vvTr7Li3QOO3HNwhlaN53kb/+U8Ybooq+uU+Q1sxr37Yx1wZ+ONy4LgiTNLKt88jfzow7VzxIBFBlWU7L2lD6EF55gUiQxY67aZnw0N4DGD0rw48sO2fKDR8fHdzexpYVCZpUuye2vV3C4lHj9o6SXiVJ5hFlZSpyOjtSdMmZf6hp3FCmsr
X-Exchange-RoutingPolicyChecked: HV6R/ypeHpo4GvknwJ8OqVMNQQZcF9PNau4AE2L6QDxwBjN/VS3m7hqzA1lvx5495CuB685nJjzwhFBzJbmfP8kW79yi2WPeS58oa0lUBSzAA373JAMhzvxnFfYG4HFoFpEWOJQ3b+c6cd99wXtDuwFo8TAtmFInRUBs7iQ9KCmHfmywAZDc4XRZQx/rtYWfCtFHZfpCQ3W9HEiaU8zkcCSC6G6hgP0mFdu0NHdPiavld7W89Y1vhtFPL6kEjZBLTAxYhb40jQAmaH483CXLJebiLwQZLDw2omrF62AdgLK3txDDB/J1P1EY356l+9vBlKgr9m+xk2VSnpMLdSsehg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 01:56:59.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a21227bc-8c92-4f06-daf7-08df4a976443
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6864
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAwNyBTYWx0ZWRfX2lVU1xtnJMAb
 sspmjHwBEteCBrQkwggpZX8pYbV++E52mburzCO+iinBDE8o3VQ7b2ji+eaT2rVJkwdRc5N40V4
 WZu3HRJx2aQNr6tTLTCcvzx9tGuOljac812IGYQPv0TBiL4ikWAMqGDWsRZwUvlvsZF1Z3s4Pij
 jfYOLkOwenZ9liLQNW+nGv90nbjXJQMNBpTUywmgB8ffndjpgrTxZ5CoRDQ1sxQ+50Agg8oscLQ
 63c5lJ3UadfCOQJTLgD39G6+st32ms6my/b87prc/wvwMi+z2scHvrvoyrglKVdMEkNkweTpnyf
 /i0/cncevZXfrYNPbyjbTwFYB4z9CpW825BOwnvxZ+WVhVFtQPAZJrrwapBciiCjapXK3eli7sm
 Nv4ASedgLMTcUXrMrD7PxLrLhEgczEs7ZtXXVVKS8LM2E2OeFvpCse7WCT0h6CTSnvsgfISmykh
 B7WhcUi+YmwC7dOWZeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAwNyBTYWx0ZWRfX+6W/ct3Pn+XY
 mC4vdjZSssebhDkT34R8z35XbWpR/5toOED+Xon8hX6tC3tFVmzwWpPg1jBktBZ5ParlntZPD0o
 aeE8mD6oqmi8V0UHSUJyU3a0qF3GKd8=
X-Proofpoint-ORIG-GUID: sPc9AjDB5U_wr7KeYdvsuyAzJm0z9cMF
X-Proofpoint-GUID: sPc9AjDB5U_wr7KeYdvsuyAzJm0z9cMF
X-Authority-Analysis: v=2.4 cv=M8XYuCws c=1 sm=1 tr=0 ts=6b064071 cx=c_pps
 a=WVTIIPXEjO/6WBYygohQVQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=tmHHvO56vfa6rauF4ooA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
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



On 11/23/2026 3:41 AM, Francesco Valla wrote:
> The bootph-all tags on the regulators provided by the TSP65219 PMIC were
> added to solve a boot hang caused by a change in the behavior of the
> underlying driver; now that the driver is no more compiled for the SPL
> they can safely be dropped.
> 
> Link: https://lore.kernel.org/u-boot/20260813-beagleplay_boot_failure_fix-v1-1-01d73d735cbb@ti.com
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> index 2a0b19173c08..d06cbd899c2a 100644
> --- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
> @@ -229,34 +229,6 @@
>  	bootph-all;
>  };
>  
> -&buck1_reg {
> -	bootph-all;
> -};

Acked-by: Udit Kumar <u-kumar1@ti.com>

> -
> -&buck2_reg {
> -	bootph-all;
> [..]
