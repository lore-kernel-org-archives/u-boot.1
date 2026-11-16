Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97B606A335
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u4QkrMRT;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PLSi+mN4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63A1C80EF4;
	Mon, 16 Nov 2026 16:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCCZT-rXYlwX; Mon, 16 Nov 2026 16:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DD7D80E29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846903;
	b=Jjrud547eGUVB+os8pnOYBcZnyqFd2ZmYEPllzaGVrSU/k1xqcD5Ibr1qkpszby+sO5u
	 JdNxCrW3t9g31kCnOSDMWv5RVPhqV8IO8/A41u7MsdZ6yWOvRz2c++PbpdIW+ZErk6Qhg
	 nwZxKD8Vh2Mnf4VXBP2XX68kHGzTg9c9a3pwmj/w5G4bJsjNcfVlWH0ZawxUMNSeGHiP+
	 KlKWz1TxKNWmeKDm3oMpyRyRos1JbxqiRCs2P69LQBYgHXpYxb14Ioqg063JQfpY2pEzf
	 gVYk6Kt/HYaE/bAXhybEU1rqZ1eBHZxhbU76S9A1dhANvbmkg09b+bqvmS1itJAND1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846903;
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
	bh=wgRoAxu7wHPbZdQnLUavRtOuZnX1dciR3OchU/Da5xU=;
	b=L+5t6GIeq3eOVXuO/3vWpqGuDlmAfE55ZO+JuXUU12xnbyNJrF2hE2z9d4SefnGtbQvs
	 pUKfbW3/ZUUEIJ5PcVcQe9co7vHGDLuDdUH16q8zKnwMzNsjnajYjiqMyamJNrGzk2krt
	 1w3lku7uj3AZKAXlwTKoqG91BFXM9zGfLhRWJzlfEnPo0ZK6XK3ZMEZWuM2vmh9AMgVrD
	 oGg37UR4VTmEHuu3giqwsG+GpzzU6vrPTSoBYvUo05kaKMXYxiGugTaB/uKXyGWj25ftz
	 TW6/kFOYcgK++5O34EIUMjgwEQkLwwLdD5Iam3y1IonMmhAmfl5P3XuRyerQqhQaWrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PLSi+mN4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846903;
	bh=wgRoAxu7wHPbZdQnLUavRtOuZnX1dciR3OchU/Da5xU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u4QkrMRT5ENkEm8FzUsYN0QrerGEn6r9iUJfe0GME866lTd3Sdoyro+2Y4XCcrig9
	 Dk+0NMwdZP4LD0/mOFflZZ5eKX5lEjQzptt2FWQucaVB/RkHxf7mK4YdjygPsWx3xn
	 irELeT4VP0lddvt+/htSc9rB9eCbwGVsfkcX4akm0UOofDIYB9vKoOBQAdCIKVLwPE
	 kcMkG8HZgOTnT0byZ/sDLdemhnW6WCnu2w5ph4ZNHgbq7kPdvNqMyPlA3Ehq6wNXoO
	 NRF4ZgVyxP3SsnPb5Sg0DoMf7JlDha72MQ/L6PDYNXzA1+2r4N+vrRMt1uMp7OEZIM
	 3nPx5puXKo07g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DD7D80E29;
	Mon, 16 Nov 2026 16:35:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2EE71E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A7FEE80E29
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDMjYTyhxMtM for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:35:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0714B80E23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=PLSi+mN4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0714B80E23
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgRoAxu7wHPbZdQnLUavRtOuZnX1dciR3OchU/Da5xU=;
 b=PLSi+mN4PjIjtGDsLTPvWvN8BoM1WZlyXb3ctyQ2pWuiFzZLLIKesN23f19yANmdcePLvXTc4H21h6T7qbLS1hfYz48GCdPE3lLhqGpYYzKRIFCpFDhogUlX8qxVXfU6zJXMdMVIAcr1mMRvRuDPYVMpsVnKAuqoTh+fhzgzGdTSD21eslx3mc8V5KexKH6EuOVe2VBehFnJmgPoJq48M6r3yCFsmOgKu2ekVP0kBm1D9/QjtuSEDgDGhMeUPfPZIQ80a9rzlTNszDODhXVaCTnrrNLEKrWkdTVp1ed6Whb2736+IfAAkxQs8BSwRFUpApPL8AxOj7tIykBnIskhuA==
Received: from MR1P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::23)
 by AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 16:34:53 +0000
Received: from MAD0EPF000008AC.eurprd04.prod.outlook.com
 (2603:10a6:501:2f:cafe::29) by MR1P264CA0036.outlook.office365.com
 (2603:10a6:501:2f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 16:34:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008AC.mail.protection.outlook.com (10.167.241.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 16:34:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:35:51 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 17:34:50 +0100
Message-ID: <d56f0351-8acb-444c-9e03-c3994faa8758@foss.st.com>
Date: Mon, 16 Nov 2026 17:34:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/35] board: engicam: stm32mp2: add splash screen
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-34-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-34-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AC:EE_|AM8PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 38fba34d-8b9c-41b0-d60a-08df43ff8aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|261009223027099003|56012099006|4143699003|11063799006|261102123227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: uDCQXTQ5DRVvC3EI5mByNwxLdLT/RR+yvE86rKCvsJosbwu/oN5Bk1PwVOeL8D2pZYfVGMlsUIfxf0kIP2xDu9tnKLjsN9yBHYeEK8TFoM8e9pEYGt05zi/cNB0awhWiFSjyf454M/FJWwawp6SuiBhAs7eFiDPTZPgagQl60JT1siz+GEWcRGWUqSVqjXLOLacl6gfc2C5asBq4qYE78guRMsKYy9ClMX5+w7EOyLU28cBuh+sV0wlmXrViqgBhLi4ZbL4YQ9mbibErxuNRbczUXFOTEUuF5lPfOpvhgA9OIzFpe6tDzq71ytWNEikxScgiY+M0l7cw2H4au4ne06tLzBngSJTDAMvYooqXfXHuwxyye5KB6VU6C8CEhe+jvmthM4gb0GVqgP5GMemiga9Ka+evNnFCRvAL2VGyHlR/tbjLp6ho0elXKv4qhGDHpSgQEx6f9eWgJOiNEJV5XP+7B/euiMnkCm/dhTfm/9+1K5KFPSclpInmu85AOjdRcbIq0VfEFxsySkKRR8VBz1aJmP1nctCe2xCeXrdtx5x7lIfI+ZUIw/YcNEJtHiKKDMh4pb5/93Hc4W//dQHqcMb1ShIfhnAY9hdoH8uHk9/zmpIewmTUonkziHS5IOt2kUPKqI6nw8WSAmm3dAvz+JGKmYkyAaMrHZD6YBtgNXpc0Aqj5sLMY+hP5nDoGCyVk3iu7AxwJ6zU0V497MGoSQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a3syegIC+ayRlUTmrzPV/XDDddQE45FB4VLaMwNFfsyfkVoaLOTI60QlTlY8ApVShQMUWSQcnmJqLv/axKD1fpf5bMqtfL2XNkaGc9s9VeBwspDfJX9jtPD1XBPf9JTTrH0H/Z8mDElaLzuvIBw+PfXsD0ZVtg0VitCMwBmcFqciN6sOj/IJHbbu7Eq3Gtvgra+eBJYO+F2uv/G0mkafher8I6T6spnNZtB3XZv837H0sdMe/CeF8gdb+5KlbEhEUBcVlvAAUZXqx8JzcINygGtG9SWdYJFo7wq2FgP9+A6pFoXG50HAq9tFdMvz9KlHpx/qGRqg5HIEB6Zk2BIyAePMnpjGZoF9wh9HGN/I72+1RErhFD8wbK/UZM98chf1SI3N1v50ohghmIoPUmc7TVmVIFDT0+kyBVT9bBP/evWVtlrRj6I324RUVTPVmiSH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 16:34:53.0938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fba34d-8b9c-41b0-d60a-08df43ff8aaa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AC.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4130
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
> The U-Boot devicetree includes the overlays of all the supported
> displays. Enable only the one selected by the "display" environment
> variable.
> 
> The customer splash image is loaded from its partition, falling back to
> the built-in logo.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v2:
> - Apply the upstream display overlays to the U-Boot devicetree instead
>   of describing the displays in the -u-boot.dtsi file
> - Do not leave the LTDC RGB pins configured with the LVDS display
> 
>  ...m32mp257d-engicam-microgea-rmm-u-boot.dtsi |   5 +
>  board/engicam/stm32mp2/microgea-stm32mp2.env  |   4 +
>  board/engicam/stm32mp2/stm32mp2.c             | 179 ++++++++++++++++++
>  configs/stm32mp25-microgea-rmm_defconfig      |  16 ++
>  4 files changed, 204 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> index 4cc0d47e999d..8a3723baa116 100644
> --- a/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp257d-engicam-microgea-rmm-u-boot.dtsi
> @@ -12,6 +12,11 @@
>  	};
>  };
>  
> +&ltdc {
> +	clocks = <&rcc CK_KER_LTDC>, <&rcc CK_BUS_LTDC>, <&syscfg>, <&lvds>;
> +	bootph-all;
> +};
> +
>  &usart2 {
>  	bootph-all;
>  };
> diff --git a/board/engicam/stm32mp2/microgea-stm32mp2.env b/board/engicam/stm32mp2/microgea-stm32mp2.env
> index 1f50f68d4972..cbc0a73f5081 100644
> --- a/board/engicam/stm32mp2/microgea-stm32mp2.env
> +++ b/board/engicam/stm32mp2/microgea-stm32mp2.env
> @@ -7,3 +7,7 @@
>  /* Default display of the carrier board */
>  display=rk050hr345-ct106a
>  extension_overlay_addr=0x90300000
> +
> +splashfile=splash.bmp
> +splashimage=CONFIG_SYS_LOAD_ADDR
> +splashpos=m,m
> diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
> index 5f3afd877a11..64317f271ed7 100644
> --- a/board/engicam/stm32mp2/stm32mp2.c
> +++ b/board/engicam/stm32mp2/stm32mp2.c
> @@ -8,12 +8,23 @@
>  
>  #include <alist.h>
>  #include <config.h>
> +#include <dm.h>
>  #include <env.h>
> +#include <event.h>
>  #include <extension_board.h>
>  #include <log.h>
> +#include <splash.h>
> +#include <asm/arch/stm32.h>
> +#include <asm/arch/sys_proto.h>
> +#include <dm/device-internal.h>
>  #include <dm/ofnode.h>
> +#include <dm/ofnode_graph.h>
> +#include <dm/uclass-internal.h>
>  #include <linux/string.h>
>  
> +#define MICROGEA_RK050HR345 "rk050hr345-ct106a"
> +#define MICROGEA_AM1280800W8TZQW "am-1280800w8tzqw-t00h"
> +
>  int checkboard(void)
>  {
>  	const char *fdt_compat;
> @@ -38,6 +49,174 @@ static const char *microgea_get_display(void)
>  	return display;
>  }
>  
> +/* Disable a node and unbind its device, if any */
> +static int microgea_disable_node(ofnode node)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	if (!device_find_global_by_ofnode(node, &dev)) {
> +		ret = device_unbind(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ofnode_set_enabled(node, false);
> +}
> +
> +static int microgea_ltdc_connect(ofnode ltdc, ofnode ep)
> +{
> +	u32 ltdc_phandle, phandle;
> +	ofnode ltdc_ep;
> +	int ret;
> +
> +	ltdc_ep = ofnode_graph_get_endpoint_by_regs(ltdc, -1, -1);
> +	if (!ofnode_valid(ltdc_ep) || !ofnode_valid(ep) ||
> +	    ofnode_read_u32(ltdc_ep, "phandle", &ltdc_phandle) ||
> +	    ofnode_read_u32(ep, "phandle", &phandle))
> +		return -EINVAL;
> +
> +	ret = ofnode_write_u32(ltdc_ep, "remote-endpoint", phandle);
> +	if (ret)
> +		return ret;
> +
> +	return ofnode_write_u32(ep, "remote-endpoint", ltdc_phandle);
> +}
> +
> +static int microgea_disable_compatible(const char *compat)
> +{
> +	return microgea_disable_node(ofnode_by_compatible(ofnode_null(),
> +							  compat));
> +}
> +
> +static const struct microgea_display {
> +	const char *name;	/* value of the "display" env variable */
> +	const char *compatible;	/* compatible of its panel */
> +	const char *bridge;	/* compatible of its bridge, if any */
> +} microgea_displays[] = {
> +	{
> +		.name = MICROGEA_RK050HR345,
> +		.compatible = "rocktech," MICROGEA_RK050HR345,
> +	},
> +	{
> +		.name = MICROGEA_AM1280800W8TZQW,
> +		.compatible = "ampire," MICROGEA_AM1280800W8TZQW,
> +		.bridge = "st,stm32mp25-lvds",
> +	},
> +};
> +
> +static bool microgea_uses_bridge(const struct microgea_display *d,
> +				 const char *bridge)
> +{
> +	return d && d->bridge && !strcmp(d->bridge, bridge);
> +}
> +
> +/*
> + * The U-Boot devicetree includes the overlays of all the displays. Keep
> + * only the one in use, or disable the LTDC if it is not supported.
> + */
> +static int microgea_settings_r(void)
> +{
> +	const char *display = microgea_get_display();
> +	const struct microgea_display *sel = NULL, *d;
> +	struct udevice *video;
> +	ofnode ltdc, node, ep;
> +	int i, ret;
> +
> +	if (uclass_find_first_device(UCLASS_VIDEO, &video) || !video)
> +		return 0;
> +
> +	ltdc = dev_ofnode(video);
> +
> +	for (i = 0; i < ARRAY_SIZE(microgea_displays); i++) {
> +		if (display && !strcmp(display, microgea_displays[i].name)) {
> +			sel = &microgea_displays[i];
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(microgea_displays); i++) {
> +		d = &microgea_displays[i];
> +		if (d == sel)
> +			continue;
> +
> +		ret = microgea_disable_compatible(d->compatible);
> +		if (ret)
> +			return ret;
> +
> +		if (d->bridge && !microgea_uses_bridge(sel, d->bridge)) {
> +			ret = microgea_disable_compatible(d->bridge);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	if (!sel)
> +		return microgea_disable_node(ltdc);
> +
> +	node = ofnode_by_compatible(ofnode_null(), sel->compatible);
> +	if (!ofnode_valid(node))
> +		return microgea_disable_node(ltdc);
> +
> +	/* Connect the RGB panel to the LTDC */
> +	if (!sel->bridge) {
> +		ep = ofnode_graph_get_endpoint_by_regs(node, -1, -1);
> +		return microgea_ltdc_connect(ltdc, ep);
> +	}
> +
> +	/* The bridge does not use the LTDC pins */
> +	ret = ofnode_delete_prop(ltdc, "pinctrl-names");
> +	if (!ret)
> +		ret = ofnode_delete_prop(ltdc, "pinctrl-0");
> +	if (!ret)
> +		ret = ofnode_delete_prop(ltdc, "pinctrl-1");
> +	if (ret)
> +		return ret;
> +
> +	node = ofnode_by_compatible(ofnode_null(), sel->bridge);
> +	if (!ofnode_valid(node))
> +		return -ENODEV;
> +
> +	/* Connect the bridge to the LTDC */
> +	ep = ofnode_graph_get_endpoint_by_regs(node, 0, -1);
> +	return microgea_ltdc_connect(ltdc, ep);
> +}
> +EVENT_SPY_SIMPLE(EVT_SETTINGS_R, microgea_settings_r);
> +
> +#if CONFIG_IS_ENABLED(SPLASH_SOURCE)
> +static struct splash_location microgea_splash_locations[] = {
> +	{
> +		.name = "mmc",
> +		.storage = SPLASH_STORAGE_MMC,
> +		.flags = SPLASH_STORAGE_FS,
> +	},
> +};
> +
> +/* Load the customer splash image from its partition, else the built-in logo */
> +int splash_screen_prepare(void)
> +{
> +	static char devpart[8];
> +	u32 bootmode = get_bootmode();
> +	unsigned int instance = (bootmode & TAMP_BOOT_INSTANCE_MASK) - 1;
> +
> +	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
> +	case BOOT_FLASH_SD:
> +	case BOOT_FLASH_EMMC:
> +		snprintf(devpart, sizeof(devpart), "%u:a", instance);
> +		microgea_splash_locations[0].devpart = devpart;
> +		if (!splash_source_load(microgea_splash_locations,
> +					ARRAY_SIZE(microgea_splash_locations)))
> +			return 0;
> +		break;
> +	}
> +
> +	return splash_video_logo_load();
> +}
> +#endif
> +
>  int board_late_init(void)
>  {
>  	const char *fdt_compat;
> diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
> index 34933f1e7e41..0f1b7db7abc8 100644
> --- a/configs/stm32mp25-microgea-rmm_defconfig
> +++ b/configs/stm32mp25-microgea-rmm_defconfig
> @@ -38,6 +38,7 @@ CONFIG_CMD_PWM=y
>  # CONFIG_CMD_LOADB is not set
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_MTD=y
> +CONFIG_CMD_BMP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_TIME=y
>  CONFIG_CMD_RNG=y
> @@ -48,6 +49,7 @@ CONFIG_CMD_UBI=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>  CONFIG_OF_UPSTREAM_VENDOR="st"
> +CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS="st/stm32mp257d-engicam-microgea-rmm-overlay-rk050hr345-ct106a st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h"
>  CONFIG_ENV_IS_NOWHERE=y
>  CONFIG_ENV_IS_IN_MMC=y
>  CONFIG_ENV_IS_IN_SPI_FLASH=y
> @@ -98,6 +100,20 @@ CONFIG_DM_SPI=y
>  CONFIG_STM32_OSPI=y
>  CONFIG_STM32_SPI=y
>  # CONFIG_OPTEE_TA_AVB is not set
> +CONFIG_VIDEO=y
> +CONFIG_VIDEO_LOGO=y
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_LCD_ILITEK_ILI9806E=y
> +CONFIG_VIDEO_STM32=y
> +CONFIG_VIDEO_STM32_LVDS=y
> +CONFIG_VIDEO_STM32_MAX_XRES=1280
> +CONFIG_VIDEO_STM32_MAX_YRES=854
> +CONFIG_SPLASH_SCREEN=y
> +CONFIG_SPLASH_SCREEN_ALIGN=y
> +CONFIG_SPLASH_SOURCE=y
> +CONFIG_BMP_16BPP=y
> +CONFIG_BMP_24BPP=y
> +CONFIG_BMP_32BPP=y
>  CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
>  CONFIG_WDT_ARM_SMC=y

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice


