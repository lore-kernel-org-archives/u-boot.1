Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284A606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rcWn0tdb;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Q37i7sl5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D26C40676;
	Mon,  9 Nov 2026 07:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qf6NGo4ewa3K; Mon,  9 Nov 2026 07:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1C524066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794208975;
	b=eiNvKH8wbCGgP0mOjNIs02Vh/KscQ8M7TEe3P9sM+j+pj61ICPxbcfF5t6q1DJdCBERA
	 FLmZUsE6DvIWv6l7Iwqr9lMZyoQ2/e/ZBPH7KvqFHIZmlq0iR8FQin+Vzn1lmv2Hr0wCF
	 tEeWTFOino+1DelDArISpzBdnimtsulm46pGXjlka9DrO5XkP1DSAdVFVc6rbQuk4QIVs
	 ABrCRVFxV20tj+qvLzReeIRdYO8DYI3TFKH2++6gzTA2MUogUIz585HkZzZ950oZ2CF+H
	 71DyCpW5vk8WpcZgx3uEuxotzO08Guu4BI5uN37jc3ktLP3iweCqcILkkqZX8q78GFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794208975;
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
	bh=ajwBbzxWy8EOWamnYUMhUswdjfDiuIUFIwLGTtl649A=;
	b=UkAMylske9XYB6ERBMdeOGiUZTYx3NTtjxZ7mkw8qOwLS56MxlPqe+Obl7o7ZSqxzU6J
	 PZXsUar0WZb1g2GkogqRQouvsYhZ+JV7Ce1w2brU+aqSXmo01+PB3LCyXoa97ClgQgBF4
	 LHS2ZWJvcG4xCbFH2QSmJrF5E47/hFXdOBnMpOJNopaswuEqt+PrR+9gs4147ucXUD22g
	 iXGMJy2UFeLLYzILnRcOViqZhwKggLV3MRViJldRRMAo3IEqjILGldUVUuAVAmGvVi5ug
	 L+4VWWJbn+/gtZYmsAegZ2Pt6Dw928WlG7sLoNuzgoXT8aCPLTtplDcDMkewUyYRl1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Q37i7sl5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794208975;
	bh=ajwBbzxWy8EOWamnYUMhUswdjfDiuIUFIwLGTtl649A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcWn0tdbI4L0UG9xvaJNSFo2ho52XpS6UDYZKRqNl61uJAk3bplPjstUtE7DlP4j/
	 60oUOJXr6MciYa9oRm9CVhZTJdqE86cxGBlmNkrW31c8AlGHPzB7c6hJ1aSvN5WDsi
	 jWkBNqxR+hfBgCjaWJmu+G9taRgGXE9LWOyukOM+6zgvJrdYPymz8A1Tobehy/f7nA
	 gOisGw2gqphGzWlWUjjesrK+aaWyQnV9F0tDHejn8yQ325odEUMueMnpJDGK5XPSGq
	 dFIL4ldCSGSL+pTZjhQPtbGki9J9w+e9+1kMcOdhfw4/LmYoSirGJMp8ZxRfS/i8on
	 fLrMOZE9YBx+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1C524066C;
	Mon,  9 Nov 2026 07:22:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCFEF2AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2E884066C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bYurmCWtLHaL for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:22:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 345454065D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Q37i7sl5
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 345454065D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajwBbzxWy8EOWamnYUMhUswdjfDiuIUFIwLGTtl649A=;
 b=Q37i7sl5IilotdLHYiu3zRE2sAUYaQzNuLwjn8Fkb7O8OCZNM6WxYl5sTxge2v5ntc9N4PKYrDugOJk9cUivxELuLjU96DQMY7cQZiKs3MLvwdT14/H/fx6pxA3UyIZmvMdasM4JJ49zZmOjJIMYr8/f0kolD8lWol4T697YNWH1LZZXTAnZZ8ql9rPW1HY0gXQ/zf3gfegVRHBzHCjbI7uO5V1iXb5encEi/yycm277TXpRliZjY5mSNiqoBggTpAph5vOafH+EE2JMWSt9sPmEJdMOSHr7syPR+SE9SQeVVljTOnP5RYRi5E4Z/3rnx/0ZxDdEw5aLghCJKPzn6Q==
Received: from MI3PEPF00004E95.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::445)
 by PA2PR10MB8340.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:414::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Mon, 9 Nov 2026
 07:22:45 +0000
Received: from MI3PEPF0000855C.eurprd05.prod.outlook.com (2603:10a6:298:1::98)
 by MI3PEPF00004E95.outlook.office365.com (2603:10a6:298:1::445) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.592.13 via Frontend Transport; Mon, 9 Nov 2026 07:22:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000855C.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 07:22:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 08:23:25 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 08:22:44 +0100
Message-ID: <881f6319-c99e-4a54-b1ce-08cdc6d26ed7@foss.st.com>
Date: Mon, 9 Nov 2026 08:22:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] Add STM32L4R5 / NUCLEO-L4R5ZI support
To: Vincent Jardin <vjardin@free.fr>,
 <christian.koever-draxl@student.uibk.ac.at>,
 <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>,
 =?UTF-8?Q?Christian_Stefan_K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
 <1a1b6b3b8d0.2728.ffe91ee9dc07baa0c1c4561a0e181c1b@free.fr>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <1a1b6b3b8d0.2728.ffe91ee9dc07baa0c1c4561a0e181c1b@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855C:EE_|PA2PR10MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: c119a369-7b4b-48ac-cfd4-08df3e324047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|32650700020|82310400026|23010399003|376014|22082099003|18002099003|10067099003|4143699003|56012099006|261028144727099003|11063799006|261026140227099003|261022075727099003|261009223027099003|261022105027099003|41080700001;
X-Microsoft-Antispam-Message-Info: kiLjN5ci6kKn8mvLrTEbBOuapoM5NX9b3Ld63wfMnrHRWZyW5al0p4B5N1oMAyXkiCrvZcjCct6VEFyvOI8nGt62OB4BCpQ91SR0V+gXqZ3i5Z3osD3NMaFpGqnXmwsX7PYmuvMo3SNxi/ZYqBEHsVgpMsFYCo3uton/OYq/UWDKlVcTSc+uqwMTC94UObrbrFr04gXBL3vo59wmuugbnZcEg884bxqncbwQWAuN1VhG50ieiA53xehj8dLsyrHKBFXE2Rl+Ns96vR+FBHbAQPV5Zs0meSaRBWFlGVes2kaz0gjYoNudpfqvg1dTbd+F2BfGsj3caPAUcU12z67MiJcD9z2Pw1vH4tPEF8smiBUN4aCngmvdQmAyGBVy/B04yTSZykPP6VhlgFqShYbwGMs/9nqr7xPUXfeESx2tn6btQhLyPue/ad6586NynxNrDrFlCsQAAE7JzGuWUtK/jR22IHbH7Sa2FAmnmSkDLDiPXTmSM7QN3SfZAiWOWUGA0H5ZgdIIIyJcOsCs7olR+t3T1ZdQcOhOXEKzWfwwbCbHCIkuLF9QiJv2d5dewMN4mF1mYgKTnBPBcPIzM7OBcWmH4V4E2nigwDE4auJrVH92t9MDWse79mlkwc1rlBs95c67NM3uN4gdf0Dw8QjYXAjkrlMFlXZ4LK3vA7JFPcxjTlXzZSofD5kGIuxy3dxPzOndxv7S25NF3X1HDUAp5Q==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(32650700020)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(261028144727099003)(11063799006)(261026140227099003)(261022075727099003)(261009223027099003)(261022105027099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tE7q07nsfTBnSvSui8zL4HY6W5BYwrEGttrDBk8BDhMqMFAP9T8lmPOEAhpTou5PBc30mRV2qTk0W7pM/yhp0HXJEPDw7AsvO4NgDb/UrA5vvzw8HfaesPB2rutfCZjL49iTAeyF8FaaSwQGxFO46c/onjuqhOheZYyo5+zgM5zgnhiuEE/vz161IoblZrWuBH0O2AM/uHo+Eg0u3jlVEGDU72MR1xkgDpgywERyNLs0CSyBcuQv0xF4HIF068LO+wO0fDLsNDVaSHQRCK5IgmurRtB0XeYzjKMNto2H4CBp8oqep5UqK0Bo52GdzVI8K2tCIjq01UZ7j0x47ChFdMc1ctZcgXP6Je1AyyE0/wSn8FiyChuv63Zi62aaMiADhBdDRzxiwVYjtErTTwXk3xlTdZa9uXygeBO45rx2pDmn76Am2d3FgyM9V286/q9j
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 07:22:45.7220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c119a369-7b4b-48ac-cfd4-08df3e324047
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8340
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 16:49, Vincent Jardin wrote:
> Hi,
> 
> Why adding uboot for such MCU ? I am concerned about the technology debts and the related maintenance without use cases.
> 
> Thank you,
> 

Hi Christian

As pointed by Vincent, not sure it will be useful to add such platform support in U-Boot.
On Kernel side, all STM32 MCU's platform (F4/F7 and H7) has been removed from kernel v7.4 [1].

Due to device tree synchronization between Kernel and U-Boot, in a near future, all STM32
MCU platform's device tree will be removed from U-Boot as well. 

[1] https://lore.kernel.org/linux-arm-kernel/2afd5f78-0174-4955-8c1b-be18aea3800b@app.fastmail.com/

Patrice
