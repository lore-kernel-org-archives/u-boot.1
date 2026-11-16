Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8A606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3Wcry0J;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=OB6QXFis
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69A5C6071A;
	Mon, 16 Nov 2026 10:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id La5q12EXtYzm; Mon, 16 Nov 2026 10:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A2DD6069D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794823793;
	b=F+k1nVPqJqOzHAcAgt+fg+pzVxw2kIAfaBdIRm94vTuMXMq5xnwbua+2+i5VGrQ3rR2w
	 ehVg+S448QFxLe+oo4QqU8BpUhseDl6YKHUqy2fZqXJ91/zkHkGTg/n8/dMJgHU+V1imM
	 zHnqazLjc9C+1HuRciYyQZGx5UTRsomuY4Y6DY50ir4dOVsj1v2vszQtQRvKOrDTJwBYB
	 fL1L1fejeud0tdb8sxKKhvK75zpTL1UjVlDhXaj6Wo613COSVWbC7Qr4NbeXmsr/rNwyO
	 2Tp/WclCuLg7T2OxLI2KKSvQVz6DSSjHIhywjw9LuJAuht8BPHGPVITr0mfJaYpceFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794823793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0NqphqK7c18yYSL7cen4bXCouC6LsdeUqZEzMbU+N2I=;
	b=n1aH/WhDU2sqq9MimO+jQ8FP2L6yFxtyqH6QfVVTiRQfWytEK1wbe9RmqBRLthO+LjdQ
	 iPDicekTEoTfwhet7EAWPFfFhDTmmlrZbNoE11b3pI4zuciZAgAqQRiiqjqAp9NfNzI9e
	 EOHNy/AF8QFzBDTcVMUtpm5cGhVK2Ri0EgekolNacJBqWOfFVo84wg8Gix80VauKhoIY+
	 dILoc7kmAjcd0KieSiGrtHnBO5lsxG9FAere53aai/RFIi6EozpEUb8dSL+C7M0Z2vK1B
	 kTYdZz4IWaPnc+Fpn2X5eoDuCd9mEIBeIsoqxnbnmNCL39TplNSQrPawL4zZlc7+pLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794823793;
	bh=0NqphqK7c18yYSL7cen4bXCouC6LsdeUqZEzMbU+N2I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3Wcry0JCZVtlAZ44f2qiMYY/5WigiLyIh/QDiGb2nLvcPJtjigocmdp27I/9QMcb
	 NLcnEKjFbKX822bIYC82Wmy55ulbOAcrSXiYMtNoL1anpbB2/Mkj6Z01vG2b4zs+zy
	 tk/ndPeLthrTjgQldzNXRsFncQ4dPDfsPFzGbChuLw5Vpjs3gn966ocWAIhZp6hw6w
	 wNdZfYYckxdf36wn7duYlZGKKqFDgyPwhR/VND34QAjGO4iGpeEAqjJM/YlNAp5IJZ
	 gk+mklWoTagq91VIU1fljHCByajzIRqE27kN/QKGmnTL08p6P44Ixv9ZmJ9sis639V
	 yoChWursDUldg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A2DD6069D;
	Mon, 16 Nov 2026 10:09:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C2D91A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DBF04061A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDjOHRXQ7OQE for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80EDC4061E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=OB6QXFis
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 80EDC4061E
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NqphqK7c18yYSL7cen4bXCouC6LsdeUqZEzMbU+N2I=;
 b=OB6QXFisnIBfKk7boj9l3QuusbCa+eqfdpIQ1JV/ISc1egfui3Gv17Y8cXEkC1vCHPUeh91EXYe1ntkK12+jcK0O7DvGqDQV5hC+z4gubUdmYOsCAgqNTy8cvuRLOuAAAx9yJWVdBYkNV25UY2z1H3Fn0LwJQsFeCCmS+hfu3xOeLbE4fBI94UhsjuJjXz5CdwOk+9IrJS14p53h5IMZ2BRF8LVh6gpcuiPw0RirCowpyMVimBqjwsKkOlgNUkgiNJ0Mb+0T/d+hxhAyfwbAffiI5mPvohprFyOljari20cRHXsGoXQ0MqIaL3R8fxMK3UqwgFJMnmMI9cFarI1lVQ==
Received: from DU6P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::24)
 by DB8PR10MB3481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Mon, 16 Nov
 2026 10:09:46 +0000
Received: from MAD0EPF000008BB.eurprd04.prod.outlook.com
 (2603:10a6:10:540:cafe::21) by DU6P191CA0013.outlook.office365.com
 (2603:10a6:10:540::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 10:09:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008BB.mail.protection.outlook.com (10.167.241.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:09:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:10:04 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:09:03 +0100
Message-ID: <33b787df-f911-4abc-9120-1b21bafe9c48@foss.st.com>
Date: Mon, 16 Nov 2026 11:09:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/35] arm: stm32mp: stm32mp2: fix off by one in
 mmc_get_boot()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>, "Tom
 Rini" <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-19-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-19-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008BB:EE_|DB8PR10MB3481:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbb1293-7aaf-42fa-f448-08df43c9b9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2fZuRJnjdYwAtN4Y49hZYkM2ZSvZVEvLHdMHXJXHFjBSX4V/WIdpQaPbXlXtMsEDUzXxhmjZwZbcgg30GhVN9R/4BeiuwIHPUJIxQKLldn2ti7hslet8Rqep1WuOfw5xeq2KwungnFLdFWUirC30V8zXbbqbBsvfIVaFmX67xfkXKc8hjgxAQA9Vdfq8Ob3sqi2UcOHQ5OLnaOTwYk+F/IKeXg3jAb2d0r5S5cffZpVamWEVodjcbxmnTEqA5EB2Ld5ZLsqlf5dFskQCzMhRqQwK3TJsuflmB+BtVddM86NzwJ403osNgvdxb052gCVUc4ZOcmtA9UWiFusmDe8g+M3hZNbgNJh7NiNvR6yb3eH8y/qAvkNUnp4zwKHl6RbrAEJ+CgbwoHgZinPFsqpOJC+RovXMZnEEiB38+JMvOby3LONZmEuJHcOrYX4kANNtUyfqPVqfmJtklrIVTFte3l9KOseNmQVAKrImA0whoXMTF42hwHP2VRVUCipoU35ac0lHpMyLpSPLCG7uQ9Ww5EQShUIiDGzWMz7gS9oWjlaSfpf0dfR8TEVSPBIi/GET5r4plVF5sY/MLEFnHWMNp+gZMhF0ukaJiAOW9+pM21t5qLSkOjIj6DQ2IxWYM8ZG7RAdzpKU5doDKBDqMTv10HZ5z4GjDXDFG8my8fhyRy5E3unxJf4kIuYi/6g5kbpQEkGDuMz0FWFZhApHSSQC7g==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fVjhxnGlAEiAZidlAKkiq73J7Hwl24PuaJLN2fvBxC3ZJTrYL4vrED8WTSMxDKS6zZCUHo7pHxoUgI8hjptIeiH9EDl+dan9Jk7pAJjHyKOSnL22LZ+gaOldfi4cLVss35BVmf2Nbgs14o6ViTSnvfGtvW/3uU1ns2ckx8SOsVC0fUQPScLgET7LvJs3g2SsVk0zWouDIjKitURDA2RkvEGYBwFJzW2seoeNeRYsr/ZxiO1LMX1GAILedXH+ribJAgbT4Qmc7p5GxL0WKNjIStUcX41POw5Hv29csf+JRfIjdQUXLg7IdApfd/p/u9gPHBljErct7YacFZcpOz3RWTiMriDVU6UPui87G9TgIxx0RoBH99WMRev+ZdYF5jlpaTpzkdiWayYaLOoQfX7sO2Wd1EmLr5tExt/bYPUaYCysTXXS4/8XC10XF4uTYUtB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:09:39.0991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbb1293-7aaf-42fa-f448-08df43c9b9c0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3481
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> The > comparison needs to be changed to >= to prevent an out of bounds
> read of the sdmmc_addr[] array.
> 
> Fixes: a3be0ccc4746 ("board: st: stm32mp2: add mmc_get_env_dev()")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  board/st/stm32mp2/stm32mp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index 7bc7d2a608fd..f2575339b990 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -132,7 +132,7 @@ int mmc_get_boot(void)
>  		STM32_SDMMC3_BASE
>  	};
>  
> -	if (instance > ARRAY_SIZE(sdmmc_addr))
> +	if (instance >= ARRAY_SIZE(sdmmc_addr))
>  		return 0;
>  
>  	/* search associated sdmmc node in devicetree */
Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
