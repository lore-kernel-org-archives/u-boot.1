Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE2606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lZCprETN;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=J/pBhKTg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1774360601;
	Mon, 16 Nov 2026 14:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0L0ItN2qDyea; Mon, 16 Nov 2026 14:39:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52FDA6075D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794839984;
	b=TGXWppGV34CIMrPuDJWwUO+6RGHTGeQDsrrFpS4aC7toul+27C+ZG6hZ7uCL3DBgqNzT
	 MYWbblxcNjSuwon1QL7yoEMSdwN4wYbxHOEz4MoNtQzNdA4FvLU98N31iUDPYcKcbASAH
	 6s6EzwnkvIhcyJpGlvcPQTKumMf15yg9pz3Ek9KjA0wlK4ZMlqSTlaxRSuNJ4/EhINKwg
	 zflOy0DWAWPVPEjbs70TqvOS0LkYnP+fG2oehfx0bp0VkhmHa6GFe9ogSbdCRP3WhBRNy
	 sTDEFvqW0gDLEuIF4N0clERKPhdZC8VLqQYcrLtFb2cvxTsmMY0vMa3VfQayi0UHC0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794839984;
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
	bh=OfQ8FtQ/hza1En7tGGolp8MyowKdVNxtskNJCvBRuwI=;
	b=Y6RbLBzcbQVtRqc9t5c6IiIXH6rbnN+/mSKrdyzD5cyUU493ZV4c6Q9gMvOIKjeXtiTK
	 Ai1fVCxuoLt04TUQM5DeXSnlv9tahiDE4GV4+bNeBQRU1Lpw2DqvXCW9/kwOfc+uAeW7a
	 xxFAGV+VoWytXitDpkl3326vAwBoibbDTd1YRcDtztCHJvPdEjQY76VwNrshGemT1v/XN
	 dKJRO9mvdIbzl3ixsTI+qaBy7tigJwLppRU9bSIt3Qn7vwFRSvlrQMaiIKwe/vjDso+cE
	 Rr70xijTqZlAUuu65Uj1pYTzwA4h2U9PLyzTXqEgpaZgeTxDHQlmarfy1RHPnuHBAew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="J/pBhKTg";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794839984;
	bh=OfQ8FtQ/hza1En7tGGolp8MyowKdVNxtskNJCvBRuwI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZCprETNgoTdacFHOntHJMz/69MM/R0JUp4eUdUY1i4pOyg0mONCqdyM/JxNUo2G5
	 yRlUam7Gu0+SP50fLAyDryN8MFj6H4SV5lWCGrnRyLPubf7xKCsYGHux8TtwW0/jxc
	 Ayg2kA8x5fhQohJuxtLZ0i5S9wi7NyYSTmyxN3nPuXddrSdBhh1Ho2aPPy7h9OBiWY
	 ok+uKXDWK6eHoFx0Aon2sMf+orma3F1/ulYv/WXo4mUuFPEwl60MXPq92CKQzf8CAL
	 +PRdHRnfF1NGMltCXyg76hvD2Sioh6OMdbudIvOBNPDykPit8+fa7pdmwXo90ZPXWm
	 lmRiNa7FRt1IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52FDA6075D;
	Mon, 16 Nov 2026 14:39:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BB7514DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E10460601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:39:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3rXnpYayX3M for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:39:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A77236079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=J/pBhKTg
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A77236079B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfQ8FtQ/hza1En7tGGolp8MyowKdVNxtskNJCvBRuwI=;
 b=J/pBhKTg1QO+7wR6kgB2fohe0C7EhVq3FpbRlpPXIaq90VRqKHVzm0IweGykIVWko4PAvijorzaZ4iHInUgr3GvthA7YHDFQoycnoR/oMQhSwE4Lf4JEYVB+WD4TMaA0jthvNZmd0IxSbT8I+YclxwWmouDDM3W9hhLnSCvTzdl01mXNfn7JSj0jVg7PhI+S8RrsJPhYnwqmouCQmA/jG+ndTNJVzgvGbH2slWO6SDT8m9LlmIsrxIZj5NFgC7oNzbKZ+5QKW1+RSjvHm2JA+STvlEEusVpjcatft8N2eIwYL0F7lp8+JdGerqEE+J0MjtfqVv8FLinZwUZVW+z3eQ==
Received: from OS6P279CA0166.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:38::6) by
 VE1PR10MB118985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1f9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Mon, 16 Nov
 2026 14:39:34 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:e10:38:cafe::6e) by OS6P279CA0166.outlook.office365.com
 (2603:10a6:e10:38::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 14:39:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:39:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:39:43 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:38:59 +0100
Message-ID: <db14571f-f15d-469b-bcc7-f3ebdee26ab5@foss.st.com>
Date: Mon, 16 Nov 2026 15:38:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/35] arm: stm32mp: move FWU multi-bank support to SoC
 code
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-27-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-27-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000520:EE_|VE1PR10MB118985:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe1df21-4771-4b79-9712-08df43ef6e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003|261022075727099003|261026121527099003|261021135927099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: jDnnaBojx8qUV7rDI7k0iK+T+xmyWjs67ydwrKf0/YhXLKZ+szKlhD/oyuOZ4ZP6xLuxRH5nFH3NFZla18j3FLNpqmiAhUERXg5X/+t4VU1aQNj9EAwix3wGxtJBfCoK7PYHsgmJ7QpOIkdLpjP6fCbVpAmRlYERajUVWNOb4cKZCSkG6dSIOkAQfaIE2y59r9w7cLFZ7o4k7U4ZK34/kqOsKz4tHPa7zdL9bXIZBe50tF88UAkzNwbw+kzlnU2VYe3L2/kunK5iA1iDHzH8ZlsNPqPa3aUL8Ap4UPZ3sqoL3zdOD4TT3GTO6EXheTVINUZXn3fqIooeEb31OWng0ibembyRc8MOJ0TOHjGfAAlg/2yeGDkkfZUTrEG5sr6904gHvDTMHnSlyxrsbuK3gNU2/C80CGkpOttxS3JrTxtH0TKA8zyZ4XvlNhmV9LAffinN//M2GoAoimxa+ROTNFrAKLG81Daz3eQEeaL9bwzbd8xYQZbDI+spEJfdSxgOcVUbN3Nd8lWT2OqzVwB8vrW2hnjKON3njPa4myGWXc3LqEbcrqNJ2GdT3y2wJqRQbPW7sNlguLs5eVQm6HiN2mYmbPht/aqsC/gJ93SBl1yxSjMm5jN1gn90E63Cbtd+DAWcG3W1vR2pTc7FRo2j7wJcqGIuIhHDEmH7oxxGENtdC8W71PfO8kTbLa+v3JJoz8fU/bAZptdXwlPhQ0myrA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261026121527099003)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q1wi0145ItPtS0qQdEvrdPh8OTNeOGS/q2kPKXPwkmtSbYZI3bELKhS6xRCyo1Y2FILtUxRciZofMT5MBLsbm3wEIPYkRKBvsLeBvMArAAZZ6qTG2+QsUUaYR6PDAOm5Lc/6qBGSpQwxbDNAF4rO7Zp0KyMIGXpPqRR7SunYfwK1wu2yg/nz7msxSTg3lKt+dz7XqIBTFsHSR70MEnSFbBcaf8B/fhEZ5y8kiXGH087qVMrgBckyy7n8KLegxGazfNa/XMr75xZ9LFzqyTmqYTA8CQfYJBn1cRuGcA2Hvy/hRWv8hCfy7QGI2ooVg/HY9nuj39l0LmZ9Kh5C7HMBZriY27wYRDIosOg/jBRhzEMFUwUzD+u5/skXROcsDDMNAisEEt1q3CLGuBglopoKxX9X1b3P3qM0o5AVeUoEGHr3JyYkcvKJ6aCVFQXYE2AU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:39:33.1445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe1df21-4771-4b79-9712-08df43ef6e0a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB118985
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



On 11/7/26 15:32, Dario Binacchi wrote:
> The FWU multi-bank support, i.e. the boot index read from the TAMP
> backup register and the selection of the partitions of the booted bank,
> only depends on the SoC and the TF-A, so it is not specific to the
> STMicroelectronics boards.
> 
> Move it from board/st/common to the SoC code, renaming it to fwu.c as
> the stm32mp_ prefix is redundant there, so that other vendor boards can
> use it too.
> 
> No functional change intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/Makefile                               | 1 +
>  board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c | 0
>  board/st/common/Makefile                                     | 1 -
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename board/st/common/stm32mp_fwu.c => arch/arm/mach-stm32mp/fwu.c (100%)
> 
> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
> index 853469f3c503..e22207465658 100644
> --- a/arch/arm/mach-stm32mp/Makefile
> +++ b/arch/arm/mach-stm32mp/Makefile
> @@ -22,4 +22,5 @@ ifndef CONFIG_XPL_BUILD
>  obj-y += cmd_stm32prog/
>  obj-$(CONFIG_CMD_STM32KEY) += cmd_stm32key.o
>  obj-$(CONFIG_TFABOOT) += boot_params.o
> +obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
>  endif
> diff --git a/board/st/common/stm32mp_fwu.c b/arch/arm/mach-stm32mp/fwu.c
> similarity index 100%
> rename from board/st/common/stm32mp_fwu.c
> rename to arch/arm/mach-stm32mp/fwu.c
> diff --git a/board/st/common/Makefile b/board/st/common/Makefile
> index 36dfaddfa0eb..122b13c3aa8d 100644
> --- a/board/st/common/Makefile
> +++ b/board/st/common/Makefile
> @@ -9,7 +9,6 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
>  ifeq ($(CONFIG_ARCH_STM32MP),y)
>  obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
>  obj-$(CONFIG_$(PHASE_)DFU_VIRT) += stm32mp_dfu_virt.o
> -obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += stm32mp_fwu.o
>  endif
>  
>  obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
