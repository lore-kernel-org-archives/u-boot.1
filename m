Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF79D606A33F
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M+lEpDtI;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=j2Nnk5jz;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=rOY/wSye
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1D46405CC;
	Tue, 24 Nov 2026 14:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4T_DZBZpcHom; Tue, 24 Nov 2026 14:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B29D405C4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795529426;
	b=RAL1to+begtJ7fbDTSJNja7j1dJKiqPOnFeDy/HdcBBd01okLXh+73nEaoqO31mlw/u9
	 Kch0DozLgOKU9cUNvYW3Pm9DIUsqrB6XPOK5d8FxaIaA8JNZqNFIbYAnfsmMwBcUWiaPY
	 +7mGhqD8m++eONsSog3vnJpkk8dlJdDnuLt6x91UdBgPM/P9Qlmw9mkssmCsd2P3FuUFg
	 gnR1hM78gjwAwKsFLCeLmRV2ZYp17MxSlR0lx+wJjlobbpRlecjlclCeIYYYdMRf+RXl2
	 LIfopIgaWkv27jSB57xb4ms6QdWDGSPHh3BIUKGZ8NvlNFTGXfcaIwIxUIboKekWRuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795529426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kyTUuB4JKOPSPXE00R8gpnRSXe1K6GQ685xcGGukDqE=;
	b=A/TN8kpTXVDtgjRuHR2TSZhMvMMNEp2snuiYF/OSIp2t86RaLKCxIpTjQUQ8VfP517le
	 pWpPeXsNJ4kLKCWRHd02Yv1VD4+BtM2IE2fNefWewolH6dBg8e9mC3TLYFVjP147GCMZV
	 IKokX7p2E2/AD9AWo19MdZi8JGYk7EnmqGMvH1xNKNpYqlhYAAbNBo9sGaDwh87HKIMte
	 ArNjgFdvwsrqMuYEsxqoMqCSV/3YwitT+nZhll+qlAABjJRg+xTM9qIv/B2XILRfTlV06
	 zobD7s/BQvM2Y9u1Q9vOeYswYSgf91Whegf+mgFcEbrHUkz3tpkv/P1qf3APANbJtxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795529426;
	bh=kyTUuB4JKOPSPXE00R8gpnRSXe1K6GQ685xcGGukDqE=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+lEpDtI9of8klUhgrr/uYrhoZXKHXYmGBJfthrPdAofSYVnfPjVWjFy+aT+AltH7
	 XwQ13COn7XTKLk5T15oq2LUveARHYpAkx4eYTdGGQxwkXK12sgs5NMeXDNbIg1lIha
	 BfzW8Jr9uTV5kmtmduJBaj/FE2yTvmp9Vf2O527wujYiMXvATIPQsp8rz4lQFZ2z0s
	 /lxcR7yDcG7QI4bp92WzXvsZThqIquBZkKZJjqP2bD4ASJXBxpKtJkwTxpZM/NvYdl
	 Ob4sccE6KZjbwGKLG8HX3ddC8RVc8rIrHkzzM9qF4LjDt7oQdv40vyQw0sUa++zd5o
	 +31c8J4HfY3Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B29D405C4;
	Tue, 24 Nov 2026 14:10:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FED9371
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B48A80E07
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXDc0TtHU-yt for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 14:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDD5B80DEA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=j2Nnk5jz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=rOY/wSye
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDD5B80DEA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 14:10:21 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AOAu6HS2051680;
 Tue, 24 Nov 2026 08:10:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=kyTUuB4JKOPSPXE00R8gpnRSXe1K6GQ685xcGGukD
 qE=; b=j2Nnk5jzcQ5EhUJbvSkr7V3tdrdrOcNNI9G2tqYLf4rFVYpqfp8VlOaXP
 3ekveQK7Yq7C/2xlZI3BmTO+Lfk1uynoezQhoOZPstR1iKwQVHoXZb8cQ9+GZhH9
 II71i63bBEfCGBMHoFgqf/VHMpcfkaKtrbnRA/TJPCCVNBj7oA7Nfue9AVXY7CWe
 ArySnH6PxN7+TsNSzTeAvPNmmm7Mig9jEBEMmIaE3/H8DnKT9t3KK0lTCkpfzHcx
 n93K5qkaLR9NXmAePLc3KkrxojjwoX87jwNheUQ09gwp/cmu5mrvESwnwMqNGVog
 zYiaGqn908lJ9AdCd9Jd6bKS/+x0g==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by m0380145.ppops.net (PPS) with ESMTPS id 4j4wx5vu2u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 08:10:14 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyTUuB4JKOPSPXE00R8gpnRSXe1K6GQ685xcGGukDqE=;
 b=rOY/wSyejbJnDBtIKzMK5tC+jufBfKcF0+lyOdpcjzCmtF3WTzb7C0NNkBOfSpJ8HKphPFnPYHG6Squy7YcYKlT5LXjIjjg9LVyJ7QMZ+enqRy1t+HV02H/4b66058xmNuokrvluJEL4qwJdDS3KSsSB5x6dseu1Uf4W2HJz2NY=
Received: from DS1PR05CA0025.namprd05.prod.outlook.com (2603:10b6:8:23f::15)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 14:10:11 +0000
Received: from DS1PEPF00053451.namprd04.prod.outlook.com
 (2603:10b6:8:23f:cafe::25) by DS1PR05CA0025.outlook.office365.com
 (2603:10b6:8:23f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 14:10:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00053451.mail.protection.outlook.com (10.167.23.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 14:10:09 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 08:09:14 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 08:09:14 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 24 Nov 2026 08:09:13 -0600
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AOE99m41755878;
 Tue, 24 Nov 2026 08:09:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] Exclude TPS65219 drivers from SPL by default
From: Neha Malcom Francis <n-francis@ti.com>
To: Francesco Valla <francesco@valla.it>
CC: "Kumar, Udit" <u-kumar1@ti.com>, Anshul Dalal <anshuld@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 <u-boot@lists.u-boot-project.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Nishanth
 Menon" <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
In-Reply-To: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
Date: Tue, 24 Nov 2026 19:39:06 +0530
Message-ID: <179552934644.3412595.14716622301246399724.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795529349; l=825;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=GmjULFgraMOSz9y5Z1MwVnTH7DDQzsoyWBYhfLAoElk=;
 b=+kvv4w0ITN69aIC3kmrTjbAWVv1AH+0jxeTZI3HnaCSpLbMGjmca9BOyWpsI2YL0xd6vIHYwb
 j/0uS0tRLbaB6chmut2SXrLylbJ7wl2++x3Lt5aAPcKhT3fI1HFpqNJ
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053451:EE_|DS7PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: c93f2cf2-7263-45a8-3fb4-08df4a34a628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102130727099003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: +LqRrOUkATy1qexkqp+Oh0eSTEgYtqALSwaaAM5Uj8ERiDS3KEbXSRsA1y23BuyiPo4SYdBgtXwRmSaO7zHAe+MKq474Y1uKsPt8UlKmP3EcMCYHxcTAsQ6cUqitz/IfHi8IFfJKtbdRIq5ryqiMEFhuypTuGv2xRmH6O5zD8yyNdPw4r5uFRQB8fAPsqFSzZinothKX/pVg4JcNbsIounDlr2RrWMWaEgX32W0fDPFhxlp3p8EVfaE4bZ9+mhBBDOfGTQJD20iC5+lSg+nrjPl0mysU0Hmq6lCUlDJT/XDot+XIRHt1knFp/cGTr1bRRWcNiXY1is9OX9JOziQbatY+DXkMoYkpQiXODTPB4SZxxgKAfP3fngcuXaUJqJnMazTm+6uvoXk2WbIVPEUDJu7UaRsZ/3021drJCFZMJdFEAUq1a6NMIc9CT3LSwls165yxiH3MEzI+ScUuCUgVAg7BZDMGccXm4sQWpeoW/CnmtwsVHgwisOfUyyGRyM902Zznoi6FhsneNLtlRfUciGGfwOXJ3zI8r53spKdgxodlnHdI5cW10hlbAGgn3Mx1eTTs/Ol4WA08ottpGXXwX103XXTjEgCYmADEblmdgasL3YNi1B1ASlrFm2HDyiXRmeGOwETgnryhSrn65C250fDWUJafeglvFDkK65aivi6yhZUkjh9BZ/MnH964/XO62c+9Fmf9Tyjyn47H+TGL/Mt4Qvt+YaqjnV6SNWmPMYXvmRqRCAjGySPVqe4J969AvuRhrQr1+CQBnZzP8NjjRg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102130727099003)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q7RaoOe1l7kmbfwuakk9HL8rjDTyTZhWbOdcZxip85FFWw02irhv3fPOkQekeMfhEtIpYSJAz7jChwJ6/iogLl7lkbY+OV06f2L7GIDjg7ZihHrVWd3aT5rha0Rv7UYM6Nb8cNqkhmT1WU6pVuDKZFUfNfOvLulFXFAMM4iaCyCsLhCAfv+yUZnPT49RitI6m7txE9XEJIlrqg7N8JIQMuRrNx9c2jafgJs5qAMDtVgEotSvm/ZPQzlclGu4E5nuKvt7GEElk+W0iTJH0MbibQZcn4plBHf7S7dPAB7D6r3qCj9reFQBqpJ45pkqv7gUYSuj05u/glLW4b4NstYrA7hc+aBGGF9lJeAGVsX/AfhElHDE+TR/ZJ69PRfEyYFJin1Fm0/xVfac52YLMa4jMH7v0D4ZKJyeExX/L53jKePQlBrKAP5iTmw8BlL9vXAY
X-Exchange-RoutingPolicyChecked: dLFbLCNq/IhEI+Sx46qzDYKu/1WIAc0LkGR9Fo6K+VTyEobKDk3H5xYdC8+aXoxZd47gePq+5+BaDhyPVr/PUTC7bsLKjcuceex75F1bqXEHBXiTK0ZknvZnTiBzeajQbYuC0PRFsZbZhLNt0gCDAX1icRntZAwe/AY75oQi6PTSmlAMHbqAfGWk3Vk0jd0Q+tvtdN5kUbFU1i7FuFpdK4H8LnQq7ZEtuixMY3PiDrunRnm1yG16egq62R9VGCwfT2POfu7wqpE2292bTmUJDgNYM1IeWp9K6aatkcXOSUux8kdTsIvHPBx476RDZ+uTaUiFOk15S6D9ZUmylFmylA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 14:10:09.5344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93f2cf2-7263-45a8-3fb4-08df4a34a628
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053451.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-GUID: GJ7_keBJ0w-0Q_wvE_WOPekJ-AaE6xiI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfX7ZKSDzJR2q8s
 Hlw1TUOfdo1mljj5XqW8UiXVxNr4TKK5USxf6nHVaDnyzmBzHLt4BeS8+sXlWsI3p7UHRX3nT6f
 7rAZVHmXHCkXbHtM3zPM6CXLw25z5sE=
X-Authority-Analysis: v=2.4 cv=Ht3jiETS c=1 sm=1 tr=0 ts=6b059ac6 cx=c_pps
 a=ZlG836pX3zBvGR9gn4UHEQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=eEfi9yLhK97YtHv1LvQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GJ7_keBJ0w-0Q_wvE_WOPekJ-AaE6xiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1NSBTYWx0ZWRfXwAaDlJD35M3D
 6Msbyut+7W8MxsRTuJk/hoPnusHILO2YT0gUgxNm/sFFPvQWpf6mU8Hn7nTey42InYowNATuTdD
 KvIBH24UJm/Nqh2Xk5DF1ZJAS1R5mrOPm4oHJG+skkq6DAK6IrI+0//Zhrq4tADjKn9jYBXhsOo
 u6hH+VaoE2BQGsGpxNdctQQvLH/pelYPJvFKTGp5Ne4tZ0JZd+w+peyXQY8yMNkeHSZdPmB8QpQ
 u9KNM4Vn8TXIuKA5+utzktvN8pp9ngeQK03SuOVV4kpBroiOAzzsCGtGcP9oh5XOP9Iy6rpOogB
 8DezfrJWoKkNRqVOQcmVfcnVE8rAoIRzRwFk5jwgkrL7uvU0s1miYS0R1OfAnRvO+cIyWjWrDUl
 LL8JiVI3ceqFC78Ao69JxqvRFbcuYLck7VaWeDsXsgcDibd0pqGwnbQsa7nTo1m03hyLVNwHEOF
 8utGLHpZgD6naWVWSYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 23:11:35 +0100, Francesco Valla <francesco@valla.it> wrote:
> Exclude TPS65219 drivers from SPL by default
> 
> Hello,
> 
> this small patch series fixes a boot hang observed on the BeagleY-AI and
> that also affects (at least theoretically, as I don't have one) the
> PocketBeagle 2. The hang is a direct (albeit unwanted) consequence of
> commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
> missing"), after which the "regulators" DT sub-node of the TPS65219 PMIC
> became mandatory. All platforms that lack the bootph-all on such node but
> have the driver built-in hang at SPL startup; if early debug is enabled,
> the following message can be observed:
> 
> [...]

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
