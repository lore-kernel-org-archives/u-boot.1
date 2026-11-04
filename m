Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1564606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KWZKHBn0;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IChSjJi+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 755DF40475;
	Wed,  4 Nov 2026 13:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eDFB5fn_GXt; Wed,  4 Nov 2026 13:57:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6276640512
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793800648;
	b=YlfXLytxVCiD5dVSfcLH9Hs0ocIVUnn7e+Pvjtf3GTKOMTvj6jHpDIgbLPx5rHMAEOX2
	 GvnH+CCYQqoaTe/lHXLEQlDjQNNCSW6yf9jno7TqhDOTBnQms8/9Aimct7/VkWfa4JqSU
	 uWM2FlB2rmwWi/zFdSJ9R0Ik/oPMTqJp3UcjmLxyGf1JICvAgOayT4tdWdiaF9uNapdil
	 1eRHaK3P/blQW+qErVVdF89pt+qKg0ap2lsOE1K+4BcenT3P88KFBWWpAbMqfvs0uPT3K
	 dWTzXL6HJ0j30n8TZP8L8AcxWkIWPLz/d8rOM23tcdYqumF4n1BQGIslCOQtqUrDx2A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793800648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ok/rkPoxL6mwRTQxtfpMhhNqoWpM0SMCD8svQ/U7J9c=;
	b=isdgjoy5/eEc83HkdO3WP7CJdl5W8Y/dXwojtfhMQBPnEO8+ixc77StFhS6izLu59w90
	 9C8SKMf55hMnX0TpCVlopvzqeFpxxW+Pw8qAmLRfFrglyezrapwbnLyYkIxNt6DbaS5bX
	 Q6luzC1JU2KtFP5zFIW2EzG0BSSjookMsSH8Av4VdOI3m/R+WXNEejwqDDmTpdbD9TRQ4
	 iZU0O5XfLgQdQl0zFNR+0Ab9YNyN4mwGHtQY0zcxQGD0+o6kYRZAnzdRh6zMcaenIDkVH
	 Q/Ry7ly0OJvNbBmBi6+vGFq/4/epXyNhT/ShgiDU4KHRv0CM8HFYPfE5rPBFdyFlVnQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793800648;
	bh=ok/rkPoxL6mwRTQxtfpMhhNqoWpM0SMCD8svQ/U7J9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KWZKHBn0F3x/xNQLp8I7GnqUAg9utEM3KewCE5EM2+fUJO09rn78Tb118SZFovPnO
	 2mAI5pxHxROONM43QmXJ8cQxDvKMCXQvL6qO8vHBlOvZ2L67Dwcs5qAG+3iSPFTH2p
	 fND6+FC3dFc7P7jL+sdO7SXuhWEpRD89kUKYG4CCSmBgX6psFVszSG83vCx2WavWhs
	 sSLgzh4tdr/SyWUtzGh9yWO71HtnYsACI0PstGsSbHQG9w0KwX+YxQulqaWGM7VwPh
	 2u3is6MqEIIyW1mo+XUTRkdBD4w08kFgLPimlUbMtsIrXzPDo4tzPhkQGTNQfuUY/J
	 s4c3jMtgE3gpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6276640512;
	Wed,  4 Nov 2026 13:57:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C388334D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C02FB80CBA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1vOqwEK6qOg for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 13:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2546C80CB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.61.63
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793800645;
 b=SdjLLp2BJh23rHmXl64vLIgUwafJwuMKYiq5IxzJE5TCZ/Diu+daGAMfDjP4dF89HjRX
 n/TJUUhH2muuyHFsA9mxDU4O4E4awXqrdWIIH5VCHJwU80E/IYHd01pNoKKFIWeQUg7Jg
 zIHfVAjR+RVGTu5Qk/Xqx1D7X8Xya/mju3C+6+urkzwqVNnm6nT8dP2yag9QDPDGqI0Ch
 vF5m/TcVAJn79J5LpBlm16N6ASjDU8zlwMUzj9twZycoqL+52YS+qoMkhMbhOVG54BOWz
 66NNd4A9fLYdRSJEdSzZQqEElEyGlT9uBmIIp9Y3iwEZ9rmsTqIMKNcSqAuREOb2guA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793800645;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ok/rkPoxL6mwRTQxtfpMhhNqoWpM0SMCD8svQ/U7J9c=;
 b=gyixfXope+HZmb38TJOYFQVYi2itkL4w83Ynca5q7m6CFbcZ6UayS/7wsWuTFnz9S7rt
 LYtMnEUseBbqwdrGNogTH6ncL5BZAzikzsVEjtrF6eKCSU5R9+cKqDpU2KfRZOBAg2RCS
 Aa85narOTe5w9cGlp7trS+kJ2CGtuBhwbWcTwFglpCbBqnYzs7wfMVXY9qJUVkrZrLC5U
 oZmcObh18r8CiLBnlXgs4ku8ZclnM3AggwOBCdFN0p5QqhRRUNZKX0deoWNiHKoWt8AWP
 csQX5Eam0RRcUAyV2YNCu943QZyRxj4hjin2oM9PaOPjO6Jz8/Q2MF3YUVxaRP7QXCg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IChSjJi+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.63
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.61.63;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=IChSjJi+
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2546C80CB2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiA7PSr6EqHJq/kaaROaGv2MqUbXuqllPFowLyiFLZ6qU1z6fynHDKyl8wXCLJHrn/G4MtmuuaQVs0rIK/SyonGcvjeGiYr0XRVG/14maR0mlHRZS8WSqN5fOVibMJ4TtvJ0OCEVdDQovFZAA0uBF3ao10dWENvUYS6T4V3rQYyNBRdKPmiQSKlnajC3YMdfRazXc/WvIELvKLDthsFq1IfJMX7Loaz9NNlmz+5ouiOkwlfLzcHk+R9pRRmWfaGkC4NXpFkOksMkSZ81df12AZA8+WbPKw63YWpkfHvyjVpW88bYdtX1fkrC1l+ZITE1bikJALj7DK2yRBJUwYIoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok/rkPoxL6mwRTQxtfpMhhNqoWpM0SMCD8svQ/U7J9c=;
 b=HOGVdZWQE1zhfzubZlRLgpXwmRBVXbNgti8lAqXDE7Wu6rVx+scSdrpnWD4xuHHvwp3bQAggI3l6Tn3dtzzT6/Z9Kz9152vAEbMeJzeFMP75IrwNGLzntm9m2wLo4x3Ql2J1w70xhSJnKIIHM5Ni6I1eXfLEZ7dky/+jYNRZw4O/b1M9CcG8qv99NQMUEs7/RgTWinwIXoaX0O5LrmdcHulABzkO+VfrOOicOOZnkaUv7jaYztTNzy0ak17+I9lQfYOjKCdNo5wzffDU0GVJ1o7g9hxRiumAaqK8F0v3Dhvr5XaK8A3MUWuGQowHDZMiI2x5bFRUjl2QUV7XuyAwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok/rkPoxL6mwRTQxtfpMhhNqoWpM0SMCD8svQ/U7J9c=;
 b=IChSjJi+q0OjubMuKYEXAZ1fmarWxCF1J521oPHTWu0I5iGiSLG7CDDqajQSXFGUYQf2/x8gXtm8oTg9YjOUy7kZllbB9QjROB74Pb3jbUJUuP9GeDzUt9o+q+h1ccnjj1NFSZs9bPICVJMlsBVXb7emSa2/QGNUuBtELKPyabo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 13:54:12 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 13:54:11 +0000
Message-ID: <311320fe-253c-4ad0-a221-fa7c2c6e4295@amd.com>
Date: Wed, 4 Nov 2026 14:54:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mach-zynq: Support SPL boot from QSPI in memory-mapped
 mode
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Debbie Horsfall <debbie.horsfall@arm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Shiva Tripathi <s-tripathi1@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.aae8b8df-34c8-4e23-a939-42c96d62f8b7@emailsignatures365.codetwo.com>
 <20260915134726.117834-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260915134726.117834-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7101d24a-410f-4b8e-2bd8-08df3a7b1ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006|261022105027099003|261022075727099003|261022115727099003|261102123227099003|261022113327099003|261028144727099003|261026140227099003|261026130827099003|261026121527099003|261026135527099003|261021130227099003|261021123027099003|261021121427099003|261021135927099003|261009223027099003|261021133027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: 8dMp6T24EktJ6hu42FPE/vprydsK3v5GnbHp0cG8aZeEpqDaHsvxnqu6MthYT/++6miQKPijF6q55FYzGjas1nOH5P5XstTtL7pi6q4TxCQRWEKzqqjHBVpUARHqUUmZu9te8qUG3gCro3+6iRXRDbX42AnHq6LhvL9WWkBp/2L2hvU3agxUdpebLTXCLEYXmbKZzjtXAtmddSms+9uVre1Xsu6p170QSd5oI2jgaghJf0anRLe7qJUvXePk31jr+dtnf1bkf6z4mfPk07KJnxngsIJDx65BkWt5ReJcK5pNYgq8R1nHCmlQZlZnhc6Av0N9vaETBy+pDaMaIzRkxiqXjmNOtMkcSrtPU7AaXxXLCTjyqTq0+jShZcws3mCliDWdbFW2IUJlD5UIe6QOxYwrfn8ccI+3Mvxk8m8X+QyKGxSezn/26HSzUWNz0u3z/waLgnVmfXggOIUahSh68kaNtwZB3lUEJb6gXRpxlqQ9fLZDeUw33yS9KY8jcjeWU0czvZ0eMGlKHEjDL1uRytibzbB7dO6K3wnOpwLQmBitu5dyfddDg2YhnkT4lRmo3rTDAEDlBIi8P67VCnVPbRSawZTAXFIuFcRgcE6smNwjKLX+8FtQeUW4SvqVzBTOlWOM/lT6vqlCIfTGu19FcJGHSpkVzR7/cjU1etjYr50=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261022075727099003)(261022115727099003)(261102123227099003)(261022113327099003)(261028144727099003)(261026140227099003)(261026130827099003)(261026121527099003)(261026135527099003)(261021130227099003)(261021123027099003)(261021121427099003)(261021135927099003)(261009223027099003)(261021133027099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZVZFpSdVRicWhOVUllR3FsRVBoNmw5L1JKUzBKN25ZR1VYcUNvbWpVVnVk?=
 =?utf-8?B?dk1nOXBwaVZMTlY3TFJuTSs2Q0pZdmszVUpkQWxjQ2dMeUQwc1VZcXVVTFFH?=
 =?utf-8?B?MHZFWFVVV1lyRjB0M1ZYUlRqUXBNNDlEK1E2UHNqWEs2SEFTRzJWcXVhK0ZX?=
 =?utf-8?B?WDVmeGxiUk9OYUxoMjU3VEJYVHhyY28xOWsvUG42V282dyt4UmlJdGlSK0xk?=
 =?utf-8?B?N0JDYUQzSzhnMGhjdjZ5RldoTmYzZ0JkYnJNQi9RMEZVdnA0MnZUcm5GUE8y?=
 =?utf-8?B?N2FRQlc1ZTZVOVhSVmxVeDMvUTFSRlJDTmZhM2lDbjJWby9KM0x0emtRc1ls?=
 =?utf-8?B?dEhUNDhnYlV1NnVlaURYK0JycjRvOWlvNXgvNXczQ0ZqdytyL0RNbWdPQzRS?=
 =?utf-8?B?UUNSdnhwblY5ZFZWaCtrQjFMc2RLNmdJSVhYTVR0amltb0Nnek9XZnVsTlc1?=
 =?utf-8?B?bGtVbFJpZ2tIYURnbW9oRkRYRjBnUDNDWFhaR1orTlFWV0wyL1lGdCtHNWta?=
 =?utf-8?B?MmdlQXBBSmNLdXphaGZwemZPdDlhbjRBNW1LMkpYM1FHWW9QWmN1NFNWcHJt?=
 =?utf-8?B?bThaeGx6WEFxNm5jdFZBTzRkaGJvNmNaREFCQm5Vc1BOR2d4b3Joc2hVU1Bm?=
 =?utf-8?B?ZHZwQk9KNUVJRG9XYzF5RGk0VEw5V3k1b09tV2lJYWNXK3piNUhLdE42ZHBm?=
 =?utf-8?B?UFZ1ZmpUYlNhZjF5eVJGZU9wZW9IQXJEK2JGNGVGTEpkWG5EUURKRGUwSmN5?=
 =?utf-8?B?TXVKZy9SWkNwSklnZkdqSWJ2K283eGNINTFSNmtURnBtSm1hTnYvRmFHQ3gw?=
 =?utf-8?B?dzBRQ0ZWdE53bzg1c3V5amhsWmYxNlNlSHpmWHhLMjZ1SVVsN2Mybmt0UkJa?=
 =?utf-8?B?czBMMHFHZU4vSU80RlMvOU5MMVo2VWJWNTVaMlhUallyTXo4SjNYV045ZzJo?=
 =?utf-8?B?K28xOFl3ckowcmt4dXUxWlNWS1BWTEpRU0dOSFVUTDlNT1hXM3JVTFY0d1hm?=
 =?utf-8?B?OGxuM085WWpNdXlVaHhzemdGcDBSSjF0T0pyMlBkVGEwYkV6T1JuSUlld0lM?=
 =?utf-8?B?Y3N5OHNTdThsWW0zVS8rTFhVTk8yNnZ1V1FLU2FqMnYvRXBnNi9kM0piS1hy?=
 =?utf-8?B?SVlncENGamtlM0pmaXhRY2pLOHFGUm13SG40NjRGOGtRT3UreGZyclJZZ1Q3?=
 =?utf-8?B?Tm9aQzl6N1pMTDZjN0JXYldhTDZ2aDE5STNnM0g5U0hRbWZWcS9FdytYY05M?=
 =?utf-8?B?VkZMYkF6RkJqRXdlQXduV005NVF0ckszWW5mZjlGdGYwbUtLVUNJeElZeXhP?=
 =?utf-8?B?SEJ6TUIrMzBqRlNnMzhqYlBDREhaRERRb3VyQmxkQ1ZtNmV5aklZL3hSSnpG?=
 =?utf-8?B?cVhaUmdlOUtsT2J3WFllbFMvTnZIWk1jMU5SWVZkR3BrMDJrMXJCemV5ditV?=
 =?utf-8?B?RGpMR1Q1Tk1Xd1RLUzQ2NXhSRVI3NDEra1ZJclNtS1Q3S2FpVGhPcThKeHN5?=
 =?utf-8?B?aFlZWXE1NHpIV0RiRnNYNVNld0xEMnh4Mld5OHFwRjI3YU5OMjFXdjF6UjV3?=
 =?utf-8?B?ZXZCQmd0R0FaRldhb3o5UmozUU0xbDI0NW03NkEyYncrbThwT3RIL1YvazBw?=
 =?utf-8?B?T2ZOVkhRUkx2YmRFak9uNGtiaGNacGo4Qlc2R2FMYk5PMDhjZUs0bEJwMmNk?=
 =?utf-8?B?ZUpvWWlBOEwvQUFtOE15OWtKOWxUNXlUb0poSmVqK1BnclZ4d0VleE1Ud3By?=
 =?utf-8?B?WUdWRk1jUE52L0lnMnJvUXRxOEd6cFFJcjJmWTg0NlNKdUFXeHRQdFBmOXdV?=
 =?utf-8?B?eDgvQjQ5NmZxL0pzTjJDUE5BYXd1WHJUdlZ1SEpSWCtQRE91TW0vZzJna0Rz?=
 =?utf-8?B?R1hZWG93dDVZTlkyQVVVYWpJckRSajRMYVFldWZGNHEvNU5SM2hteUducGFz?=
 =?utf-8?B?WDJrUjcwTWZlc3NRd3JpRXYrTmNkallRYzh3dEZQbHc4N0pNSkl2eG9VVDk3?=
 =?utf-8?B?VW1HUi8vQi94Zm5SbjdSZ25sMVBBQVNSMmQ3TTh1UjQzQVJGMFg0WkFBOWxL?=
 =?utf-8?B?b2RYUjJEYTczUE5rK2h5OVBHam1yR00wNEpISHhLdVFJeXhzeUV6VmtsWTZK?=
 =?utf-8?B?eXdXUFJnOVRSdnJiYmROSGtKS1E3SW1HUk1iazJycXB0eXp5cU9XZWloNlZ4?=
 =?utf-8?B?TFA1ZUwyNEFaSG5DK0RLT2kwQkhiZlZFTitqazBzWktxZ0VKazRxWlVhTlRH?=
 =?utf-8?B?bG5kU2kzbEJISXlsNnFPdUQ5UDBYS1Fmd21sVmg4Uk41Mm42VUY3QXNlQ1Rl?=
 =?utf-8?B?bzZPSVVxUWpNdWdCaWU3dGNKMktYeGNJeGt4WkF0MURQU2kyR3N0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7101d24a-410f-4b8e-2bd8-08df3a7b1ac9
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:54:11.5712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmSWEiNhL8gyBJRlJgj3G4OQzvsGYfBYQzAUJbhQ9schgmOgCu/CDIl87QtSC22J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/15/26 15:47, Mike Looijmans wrote:
> When the Zynq boots from QSPI NOR flash, the ROM will have set up the
> QSPI NOR in linear mode, and the contents are now memory mapped (the first
> 16MB/32MB at least). All that needs to be done at this stage is to memcpy
> the u-boot code into DDR RAM. This is not only extremely simple, it's also
> the fastest method to read QSPI flash on this platform.
> This corresponds to a standard NOR boot, hence this mode is selected as
> SPL_NOR_SUPPORT.
> 
> Add a menu choice to select which method to use.
> 
> To boot from QSPI NOR, write "boot.bin" to offset 0 and write "u-boot.img"
> to offset SYS_SPI_U_BOOT_OFFS in the flash. Usually SYS_SPI_U_BOOT_OFFS will
> be 0x20000 as the SPL code easily fits in 128k. The offset must fit in the
> accessible range for linear mode, which is 16MB for single and 32MB for
> the dual chip modes. This limitation is not checked explicitly in code.
> 
> Tested on topic_miami boards.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
> Changes in v4:
> Disable SPL_SPI drivers when in memory-mapped mode
> Use SYS_SPI_U_BOOT_OFFS as payload offset default
> Explain why XIP mode is not feasible
> Don't touch ARCH_ZYNQMP  (yet)
> 
> Changes in v3:
> Make the QSPI NOR mode a menu choice as suggested by Michal Simek
> Obtain payload offset from device-tree config in spl_nor_get_uboot_base()
> 
> Changes in v2:
> Reworded and amended commit text
> Add #define for magic QSPI linear mode address
> Use old method by default, use SPL_NOR_SUPPORT to switch to mmap
> 
>   arch/arm/Kconfig              |  2 --
>   arch/arm/mach-zynq/Kconfig    | 34 ++++++++++++++++++++++++++++++----
>   arch/arm/mach-zynq/spl.c      | 20 ++++++++++++++++++++
>   common/spl/Kconfig            |  5 ++++-
>   include/configs/zynq-common.h |  8 ++++++++
>   5 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 514bf2000b4..9473cbbb28b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
>   	select SPL_SOC_INIT if SPL
>   	select SPL_CLK if SPL
>   	select SPL_DM if SPL
> -	select SPL_DM_SPI if SPL
> -	select SPL_DM_SPI_FLASH if SPL
>   	select SPL_OF_CONTROL if SPL
>   	select SPL_SEPARATE_BSS if SPL
>   	select SPL_TIMER if SPL
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index c3f505fa15c..17514761530 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -18,11 +18,37 @@ config SPL_MMC
>   config SPL_SERIAL
>   	default y
>   
> -config SPL_SPI_FLASH_SUPPORT
> -	default y if ZYNQ_QSPI
> +choice
> +	prompt "SPL QSPI boot access method"
> +	depends on SPL && ZYNQ_QSPI
> +	default ZYNQ_SPL_QSPI_DM_SPI
> +	help
> +	  Select how to load u-boot.img (U-Boot proper) into memory from the SPL
> +	  loader when QSPI is the boot device.
> +
> +config ZYNQ_SPL_QSPI_DM_SPI
> +	bool "DM SPI-NOR framework"
> +	select SPL_DM_SPI
> +	select SPL_DM_SPI_FLASH
> +	select SPL_SPI
> +	select SPL_SPI_FLASH_SUPPORT
> +	help
> +	  Use the SPI-NOR drivers to transfer U-Boot proper into main memory
> +	  from the QSPI flash.
> +
> +config ZYNQ_SPL_QSPI_MMAP
> +	bool "Memory-mapped linear (NOR) mode"
> +	select SPL_NOR_SUPPORT
> +	help
> +	  When the Zynq boots from QSPI NOR flash, the ROM will have set up the
> +	  QSPI NOR in linear mode. This option just uses memcpy to transfer
> +	  U-Boot proper into main memory. This reduces the SPL size by about 12k
> +	  and is the fastest boot method. For this to work, u-boot.img must be
> +	  within the first 16MB at offset SYS_SPI_U_BOOT_OFFS, or config value
> +	  "u-boot,spl-payload-offset" in the device-tree.
> +
> +endchoice

I don't like this and it seems to me overengineered.

At the end of day it is between SPL_SPI_FLASH_SUPPORT and SPL_NOR_SUPPORT supports.
If both are selected SPI_FLASH wins because it it in the tree for longer time.

It means this patch should be about enabling SPL_NOR_SUPPORT and to get it work 
you need to disable SPL_SPI_FLASH_SUPPORT first. Obviously make sense to also 
disable drivers, etc.

I hope that doing it in this way will end up not having soc changes in 
common/spl/Kconfig which are visible below.

>   
> -config SPL_SPI
> -	default y if ZYNQ_QSPI
>   
>   config ZYNQ_DDRC_INIT
>   	bool "Zynq DDRC initialization"
> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
> index dc964dc2f9f..0a536c6d98b 100644
> --- a/arch/arm/mach-zynq/spl.c
> +++ b/arch/arm/mach-zynq/spl.c
> @@ -15,6 +15,8 @@
>   #include <asm/arch/sys_proto.h>
>   #include <asm/arch/ps7_init_gpl.h>
>   
> +#include <dm/ofnode.h>

not following u-boot rules about location.

> +
>   #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
>   void board_debug_uart_init(void)
>   {
> @@ -42,6 +44,20 @@ void spl_soc_init(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_SPL_NOR_SUPPORT
> +unsigned long spl_nor_get_uboot_base(void)
> +{
> +	int payload_offs = CONFIG_SYS_SPI_U_BOOT_OFFS;
> +
> +	if (CONFIG_IS_ENABLED(OF_REAL)) {
> +		payload_offs = ofnode_conf_read_int("u-boot,spl-payload-offset",
> +						    payload_offs);
> +	}
> +
> +	return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
> +}
> +#endif
> +
>   u32 spl_boot_device(void)
>   {
>   	u32 mode;
> @@ -51,6 +67,10 @@ u32 spl_boot_device(void)

I think here there should be a change that insetad of SPL_SPI it actually 
depends on SPL_SPI_LOAD which enables that functions which calls SPI.

-#ifdef CONFIG_SPL_SPI
+#if defined(CONFIG_SPL_SPI_LOAD)

>   	case ZYNQ_BM_QSPI:
>   		mode = BOOT_DEVICE_SPI;
>   		break;
> +#elif CONFIG_SPL_NOR_SUPPORT
> +	case ZYNQ_BM_QSPI:
> +		mode = BOOT_DEVICE_NOR;
> +		break;
>   #endif
>   	case ZYNQ_BM_NAND:
>   		mode = BOOT_DEVICE_NAND;
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e49..fb179325f5f 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1140,6 +1140,7 @@ endmenu
>   config SPL_DM_SPI
>   	bool "Support SPI DM drivers in SPL"
>   	depends on SPL_DM
> +	depends on !ZYNQ_SPL_QSPI_MMAP

I don't like this in generic file.

>   	help
>   	  Enable support for SPI DM drivers in SPL.
>   
> @@ -1526,6 +1527,7 @@ config SPL_SERIAL
>   
>   config SPL_SPI
>   	bool "Support SPI drivers"
> +	depends on !ZYNQ_SPL_QSPI_MMAP

I don't like this in generic file.

>   	help
>   	  Enable support for using SPI in SPL. This is used for connecting
>   	  to SPI flash for loading U-Boot. See SPL_SPI_FLASH_SUPPORT for
> @@ -1581,8 +1583,9 @@ endif # SPL_SPI_FLASH_SUPPORT
>   config SYS_SPI_U_BOOT_OFFS
>   	hex "address of u-boot payload in SPI flash"
>   	default 0x8000 if ARCH_SUNXI
> +	default 0x20000 if ARCH_ZYNQ

I don't think this is really necessary. Map will cover the first 16MB and you 
can place it whereever you like that's why make no sense to enforce any offset.
Just define it in your board defconfig.

>   	default 0x0
> -	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI
> +	depends on SPL_SPI_LOAD || SPL_SPI_SUNXI || ZYNQ_SPL_QSPI_MMAP

This is wrong and likely break image creation for brcp1 board.

arch/arm/dts/zynq-binman-brcp1.dtsi:23:                 offset = 
<CONFIG_SYS_SPI_U_BOOT_OFFS>;

  37 unsigned int __weak spl_spi_get_uboot_offs(struct spi_flash *flash)
  38 {
  39         return CONFIG_SYS_SPI_U_BOOT_OFFS;
  40 }



>   	help
>   	 Address within SPI-Flash from where the u-boot payload is fetched
>   	 from.
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index 94273d0deb9..f59af92f3ae 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -35,6 +35,14 @@
>   /* Ethernet driver */
>   
>   /* NOR */

#ifdef CONFIG_SPL_NOR_SUPPORT

> +/*
> + * Memory-mapped address of QSPI flash when in SPL "NOR" mode. The method used
> + * is "NOR" boot, but the data is on SPI media, hence using the SPI offset.
> + * Access to the QSPI controller will break XIP mode, so this cannot be used for
> + * XIP mode when using the QSPI controller in its regular mode.
> + */
> +#define ZYNQ_QSPI0_LINEAR_ADDR 0xfc000000
> +#define CFG_SYS_UBOOT_BASE (ZYNQ_QSPI0_LINEAR_ADDR + CONFIG_SYS_SPI_U_BOOT_OFFS)
>   

#endif


>   #ifdef CONFIG_USB_EHCI_ZYNQ
>   # define DFU_DEFAULT_POLL_TIMEOUT	300
> ---
> base-commit: f7fac14ea6c885eef319f0b97bc4fa6ae462f150
> branch: upstream-topic-miami
> 
M
