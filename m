Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709F606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Al80YL53;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QZi1eFKl;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=diRjctVo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 841F8810A6;
	Tue, 17 Nov 2026 21:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_jGC7kLfRRu; Tue, 17 Nov 2026 21:26:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 693C180F79
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794950781;
	b=DrFyNkM76sW3olBe+q6QNnFwHQkJfBF6yAu24SED+U4++jgjNaMckDbYhNuDCS4UaWQG
	 vwvqq6umwiNy603SKoZmLN1zJemrikAFxZaUQaFUjn3ROcCigK6bYl3uHeWxzKINgqwWk
	 iMpV6bzsKMYzumr17nVeQF960FkbL/wl8dcRJZ7CGr3bv2JgZTqH0xSTUKJ0aBBkBck20
	 VPn6bgi3Fjxo3GtizpGnnYf8q6rPjdRU1xJ8jpMui30VRUKh3H/BebmIkXWlRg6QsgCTE
	 fWHSXThlbROiiT7PiYs++XK4jFhNz3YT/WQ+9PoNbsoTz1AJaHxJrFoewEMZpa56onQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794950781;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oqKVzV3mYqSDnT1oRLjUFCu5GYTl8akU0Gm+QKXTdGg=;
	b=XMeh/64JTIvxCKEJlFzP5E6LrShL069NmuV+YF7cKaXsnGmHdBOtLq7OI3c5n9llAsFg
	 tWbtpRvI7kE0EVuj94ktqUnzirnkpUClGKFejoi+6LDNY2mfv2n5bGUNPEIYWolBbpMVZ
	 dyRjPJVIT8Z88kU1P24jcbGTajX4t2/VxoCpyoyYhKfMTA+NXjF14BILB0P1m8uUDWK+q
	 XpNMvSGX/qGpsXf9rKYRXGqjiLZ5p9byFMdWstvyaggRUk6eNBp0VcXZqwVRmPDdt3X8j
	 4i21B+mei0x5G3hj61VpHh8Gs7PtKrqg0ycu9jOOmAbp7qjAK00cpHgdPnQ6B66Pn+Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QZi1eFKl;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=diRjctVo;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794950781;
	bh=oqKVzV3mYqSDnT1oRLjUFCu5GYTl8akU0Gm+QKXTdGg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Al80YL532lAZl15YGO7Y1DLJ1N3xf8FE2Z8q8umw7T+vBDs42m9V1ngUJRqIZ0PXJ
	 qdM8Mm/jVxOccKDoStCdfufVn+Vh4YgTEWaE3tmTNPuJ8mLrN6pndrzhl9hVOlowo8
	 Jwug2td4seBGH/lzp0kM5rNKD+NWjLC0VikKH9Qr51GTQuoW9MK6alw3XB7T6Qwvfl
	 K3xhocsjph8Y0ShFy/28861zBXeNYBIkFOMmX8/qn7bt+F7MA8nJZFxagimpjpj2E4
	 tOlGA7d1NwrYgdIZUZcs3j3Zvm675pbQ+Z7sbcneNAL1Eh/HFtGq4e9Hw3v+e/kfs9
	 tdxixUwU07jvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 693C180F79;
	Tue, 17 Nov 2026 21:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82AED49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68E3B80F79
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TgDs5S3YOi8n for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 21:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7008780F70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QZi1eFKl; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=diRjctVo
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7008780F70
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:26:17 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHKLq5b1177544; Tue, 17 Nov 2026 15:26:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=oqKVzV3mYqSDnT1oRLjUFCu5GYTl8akU0Gm+QKXTd
 Gg=; b=QZi1eFKlT5r5fbl6gSimUvwkf0GL1rpM5voQj3FqugpVRoStST6i9Ggqk
 dl0Dsr3848od/J+qInc8F6XyUEQxn9egagXcBC+N8c0tX5BDYK6vaYjR2HYPhGQv
 kNoHWjD9A8q+FF62aP/Pw/lRO4hli5hP2eVlESiuNnqnoCKHlgP3YCg5uQfcyrMV
 EJM14I0eWKt2fEzv8u46+r5UHfwi8b/7fE3hLD+5RcyJKlFkgcZEcFPIRZQKPlO5
 YedTAUL0qb0QWlamcP9Ia45joAIA+RPdgq0Tz1u94s7SimhMcjQ3YArM9iKYWi+z
 eyhTV7cYb0nT4jggMHnW+vnHHhAjQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j0kxtma3r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 15:26:12 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqKVzV3mYqSDnT1oRLjUFCu5GYTl8akU0Gm+QKXTdGg=;
 b=diRjctVoqY51XyHBIahG1l77Z3xCl7EN0990T2ZUa64qemHiUWXUfC/uHnUeQG3bwMhT9ldbmn631kZCdR4SrBzi9HS4MquFXEP17GpRMA/fMwmiOOcospHPTW2G8aGTGU0UAP3w75dhc76wNqBOQkrBC6SonAFT5ZDUKV9CCUk=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by IA1PR10MB6098.namprd10.prod.outlook.com (2603:10b6:208:3ad::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:25:59 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::69) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 21:25:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 21:25:58 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:25:40 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:25:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 17 Nov 2026 15:25:40 -0600
Received: from [128.247.81.105] (hpz2.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AHLPdcR3758664;
 Tue, 17 Nov 2026 15:25:39 -0600
Message-ID: <6449f1bd-4796-438e-bb4a-76c8f854a01a@ti.com>
Date: Tue, 17 Nov 2026 15:25:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
To: Julien Panis <jpanis@baylibre.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, "Peng Fan" <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 "Francis, Sebin" <sebin.francis@ti.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
 <1921fbd4-94f4-45d0-b708-d327fe6631f0@ti.com>
 <d8cc5a71-8293-4efd-bec8-900c8aa8ee56@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <d8cc5a71-8293-4efd-bec8-900c8aa8ee56@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 18574ca7-a295-4790-3219-08df44f15f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|261009223027099003|13003099007|260925021311599003|260925021911599003|56012099006|260925022911599003|4143699003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: jdVZqC7IlzbxEAPFm2JwoByCuL9LJroS1Hb5Mjjgdh1gYgLIZHygOx1Km9W6L4tT5DZ6iQ2giVmx5wbzWiTVKo5qMtoxOew8kPvgFf6K8fUKAeqJ9ZGQCtgpghIAmCP3aPtkJAaQrhXMH0EOaJeoJdAMFVy87oG/m+yX2szc1fQUxExrUSl8Fn5JmUsP8phXkTX8qyn2EnqWI1PhS5X5/fUb8UVyiWROCRZN9dsnkQJEb53oSLnBlPbuE6r+h+kyEq95wuRmyg7X8ZA8x2mJrTt4Z+NXeq2MP07MSx/zMuX9Ai2pJBjPiYkkltMFhXG5N751LPcVbSz6Vn0hFCQU9vf5FyVCW7rB2YOUZdJPNP8wSXolVUdMJRexVbE68SHup0Mw3XdooUc4UT2afE8h6ixLMqHJ3eNvPwcAlPj5Y5NXz4rcfsRul17Va0k4R1AFV9zmMHgXQrYuAXSEmBipsWjytZSk/oeqkPnNs5C86drUhAL6YZYJKMOrvAxlRgT2HxWogo0DqSz6OwdX2fclvZSuGrMx7ciIbIzQwRGlaeDhNodFPD2gYdPbBH9GZroWEawGbTslmWAlAUTkBzuaXnLu+xZ/bK6vdC8Izwh7gb1+3ucl2LOzS7UKZ/vP297oM+b4YyMZL0k/i+wOCk69Rw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(261009223027099003)(13003099007)(260925021311599003)(260925021911599003)(56012099006)(260925022911599003)(4143699003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SQMCRPxvWhHWjldI7+ig1FS0qGHmHLawen89Ip4sJGlCH2Gi4q11z2id7qzogmM4kWUpcEfQxAvY2qN6CBIFzSAqKVW6B/eDzi2TACN9owdxuhsFmeqbWeotV5viRMKuOpoGPaJf7v1myXpPr3AgJUXnx1zW9D3yUi93pNLu02sMcO27bsiK2zVOrEj8udfkfX9XEEiIN9pLcqKYH18MRfmCHIqfI1bmatR8geU8md6SSiZN/q74Nbw/hjAwQgJ2fc0+qN4/+hgaC+1cL5K7SnXCORkzsD9Sk9k/S4e5UPBoHvyshxmuJf0lLwfGdBhurog6fnrbseQhIcFfd6WaZUCdliPuJh2rYgM/ADy0Y+aSgXPAhzt7I81ko8BCo/GIbBfTAX/anQZ9E3vFD7b5d7vFit+Hg7PESxrOh20IKljDDfsOWMkQPL9h5RNTp34D
X-Exchange-RoutingPolicyChecked: UqgT6eitY2ZGTpCfY1sZH4jD2uk9Qh/hGRdhN/cfhrQcqreW8RFeCorm+9PBzp4uHPRr3ulmNEVhf8Lcjeuu86uH9YFLvusXeZZ5bjgUJhDD9z6EuO2yNoRBn0dKn8PgjoWBD1VtPwYAkVW7ctLtvwHG05eiwo6ov9Ls+apw5+fgOj91WG1BQWEdB4LxXuMhKnih72WzMVlFkOoxP7aX6Ygq0z9L6wQXy7oisCJgl9TiI7Ag57WwCwqp0RxlM4I9OYeMUAZg6EWUfc6rbcy3CXcclSWWl9GfqWDpICQk4TwS5e+Ez8iJxwUMQRDTi/mkrLngsbsdIx10UpEJzsIN4A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:25:58.4640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18574ca7-a295-4790-3219-08df44f15f43
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6098
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfX5sKEf1zV5PeU
 OVrTAXzKexRGtexIbRIblCv09XghLkbVeiOdrvLFmdf9U4B29zl8r6iSf48gKRA/NEdoyLRy93J
 Io0ldHrKEcvsSSTM1jhE5BECBx+cgJc=
X-Proofpoint-ORIG-GUID: pS6Z8HkEJ-p_ANSFsJLKn_YK6sw1ssnJ
X-Proofpoint-GUID: pS6Z8HkEJ-p_ANSFsJLKn_YK6sw1ssnJ
X-Authority-Analysis: v=2.4 cv=RYsFmFtv c=1 sm=1 tr=0 ts=6afcc674 cx=c_pps
 a=S2IqtmjrQAXuShkhhqPLog==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8
 a=btEEnFfyzmjitx9pEF0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA4NSBTYWx0ZWRfXytkcxj6HM1Xy
 tzQudbksFHLHez5SafjMONu3aphVhI5zv8HCngdy7xQDyGEl84mVx72VfvmO6McsLqW17odn/+v
 CPc4T1X9bBho4NOvgC7xodm237GGhCPoR+Tpx6SjJi1s7zUsYr6jPmr4S1mg3CCbL54EKrhdjh4
 FCvArqnXMeNtzDrtB6rsGkBiKXKj+nE5bDKXkEbxiH+uDNh3xjGwREWOhOPouTA72gJ5JNkiJnB
 rIhEd24FxHmItm8Pf+o2h85hvkOrM94Bzz93GF4UvURtEbARrHWW/Y5oZn30r8zYSg7KW7v4JIP
 HxkicO+fVEXVHplNe6bbek+zuABFGcAqYvzV5EIYJHUVb72wJUYDoWeLGOacWtKfTMa6ldlTyey
 ypslIg4IOtkU0PrnK6HrDwG1Mdj0kc9sokPwnFf3fhddYwqiOdYgXNwdTYwyc3d1nd3tm1IIaAE
 ujauSk+Q1H/h65PYCpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170085
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Julien,

On 11/17/26 3:23 AM, Julien Panis wrote:
> Hi Judith,
> 
> On 11/17/26 00:28, Judith Mendez wrote:
>> Hi Markus, Julien,
>>
>> On 11/4/26 3:47 AM, Markus Schneider-Pargmann (TI) wrote:
>>> Hi,
>>>
>>> this series does the final changes to switch on OF_UPSTREAM on am43xx.
>>> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
>>> necessary pieces. It changes the defconfigs and removes the old
>>> devicetrees.
>>>
>>> This series does not have any dependencies that are not merged.
>>>
>>> It was tested on am437x industrial EVM with mmc. Help testing is
>>> appreciated.
>>
>>
>> I was able to test SD boot on am437 EVM and AM437 SK boards and I see
>> the following:
>>
>>
>> EVM: https://gist.github.com/jmenti/9c494e63186ad0ddc87aacc974f47336
>> SK: https://gist.github.com/jmenti/a5d5ca0804f6c0f94e640d5fe0b76030
>>
>> With signature:
>>
>> Retrieving file: /extlinux/../am437x-gp-evm.dtb
>> Card did not respond to voltage select! : -110
>> Cannot persist EFI variables without system partition
>> Booting <NULL>
>>
>> and it pauses boot here for a while.
>>
>> Is this expected or are we missing some configuration for SD card boot?
>>
>> Figured id ask before testing uart +  nfs and am437 IDK board.
>>
>> ~ Judith
> 
> Thank you for testing on these boards.
> 
> The error is not expected. I do not observe this on IDK.
> 
> Looks like the second controller (mmc3) was disabled in the old local 
> EVM DT :
> ```
> &mmc3 {
>      /* disable MMC3 as SDIO is not supported in U-Boot */
>      status = "disabled";
>      [...]
> ```
> The old SK DT never enabled mmc3 at all.
> 
> In this v2 series, upstream DT sets status = "okay" for mmc3 in both 
> `am437x-gp-evm.dts:870`
> and `am437x-sk-evm.dts:690`.
> 
> Do you observe the same issue if you disable mmc3 instead ? You can add 
> these lines
> to `arch/arm/dts/am437x-gp-evm-u-boot.dtsi` and `arch/arm/dts/am437x-sk- 
> evm-u-boot.dtsi` :
> ```
> &mmc3 {
>          /* SDIO WiFi module, not supported in U-Boot */
>          status = "disabled";
> };
> ```

It seems like:

Cannot persist EFI variables without system partition
Booting <NULL>

already existing in main branch, the only issue that was introduced was:

Card did not respond to voltage select! : -110

which is fixed by disabling MMC2. But we cannot completely disable MMC2
in Linux DT, so perhaps in u-boot.dtsi or maybe there is a better fix
for this in u-boot env?

Here are the three tests I ran this time:

1. AM437 EVM SD boot test on main:
https://gist.github.com/jmenti/109212c3d186fcdc1225ac5010038844
2. AM437 EVM SD boot test on main with of_upstream patches:
https://gist.github.com/jmenti/7f0eb8fb45ee110c1f522cbbded96212
3. AM437 EVM SD boot test on main with of_upstream patches & MMC2 disable:
https://gist.github.com/jmenti/0f3c59d6fd41b9b810e6ecc908237827

I also wonder what introduced this issue:

"Booting <NULL>"

Do you know?

~ Judith






