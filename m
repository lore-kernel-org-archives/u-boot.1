Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F641606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W+SY28Pp;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=f/l+Pn1q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6319C40708;
	Mon, 16 Nov 2026 14:57:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vxzNGVAjqK-u; Mon, 16 Nov 2026 14:57:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A609406ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794841038;
	b=hff2cMN4vPhj6elwl0+iFFOSxy+jIBfD5fll/JBCJw3ZwJs22LcS4IAYN1H7eK8lv44r
	 LBaD3oEP8CL+rY2xOQiWoZAfFSB4/fRzJnNonijj1YO0Z3yrs+aiiPo7xt09OFSMiSZVq
	 lcwWdN2d1961kLSH9iOH0o1lbFxfYbNVO9NHyrBBeOS+NNDc/TKnfHJHcC2e9vkX5cofX
	 YuLA7z6oHmbwE3L8gYRmk7V6zMrZtn7qtpx07BkoLS4/q0v4azcaaWivZgjT//W8FzbXn
	 TrV9FMFC/CCmsjF8pCDuj4am7EATnwgv5Pvj+ZZQcip5pGl0OK2EwXca142ZskDWuJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794841038;
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
	bh=hmKBEb2rTHd4KEnlVWRO919X8iaql1l5uJElLaqCuxw=;
	b=YqTuwCqjjdWDd44PHn1etCfqcLiaz4kAZV0qcJ1uMwjhWfZkfQ7kAwy1Mun+yMY+EORR
	 m72svJkXgOa0IS5ZitOOLvVRmWqnkSvuUuo6hry8jku4fOZoqyRzCqRO7jGzifueyqyF2
	 GGvr6aKFTVgNHduEDgXiGCM/m3yiOPsK7bJHkzVTy5wcsvkfu3udCABN2Q9rk+ZSNyhDC
	 KMK4NR0tdjYXXh1Z3XMdAGB3P1Z/XcC+yRKJKvsV5RmOxDdWoI/aQ+i9T69KMbHODyqYc
	 bgAE+67fw6gz6917a4I+LwnM7ZGjVeVFvYLBmyJa4mSFdhyrwEXOIyNWoBzjMy7hzSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794841038;
	bh=hmKBEb2rTHd4KEnlVWRO919X8iaql1l5uJElLaqCuxw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W+SY28Ppvsw/KKyik2X6nHsL41h7qGt0oZQMlWOELisZs9xSO1EC+f4tTKuhYh1ug
	 yGWkZOmSbT7HAt+Nn24bRp8hZm5eSzjvH22DfUNVpg3koZrLerV5DrX1Ef5d/Hex7D
	 u8qYfEd1NGkU1maKIryDSKWGTmzoNrkkPs6BTLA57VtiXSFA7jtg5/kGuzHSWdmTIY
	 02bTgPH0QF48/80YoGR82US8Cs7U9UWw3zLe6V2JVRI3rYhkoTqCrnc93aBU+hOWDP
	 850QdO/nCbZm5PU1YtalPIpQv7/93SVXUBxzcM21WJZDmtMVPmViDqIw4tX6gb4imd
	 Qi9tmcOfef6Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A609406ED;
	Mon, 16 Nov 2026 14:57:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B510F28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97ED5607EB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:57:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ai83F3fFYHRl for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:57:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27491605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=raphael.gallais-pou@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=f/l+Pn1q
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27491605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmKBEb2rTHd4KEnlVWRO919X8iaql1l5uJElLaqCuxw=;
 b=f/l+Pn1qdbT8MQO4A6udhtIvuIadsei8q13WDag/5v6klrMYyNxOu4kiboMrLtUihl3uuawZ5RxckgApdtphgYYt29j1uABIWtCfW0rTJ2sxIeVNUnHcY1VdhborIhBiFf48UbivULkk9PGjtVAi7kSsZqIVt6lqcKgWOILVPQUxjqw+DufCEyb2g1JyatjX1zStvn25EChtYvxt81z5gWiA1aii4s60siYEo+Xez6Uv3i0UWIHgQ+OvbDi06sU0SZWqf5mD4vA1fyRb0M6aJItafAwiphapl/bugfUsEF9fRtQ//BClafPGEUSSGiuQ+89a/63lUjLVoaWwUBbucw==
Received: from VI1PR06CA0198.eurprd06.prod.outlook.com (2603:10a6:802:2c::19)
 by AM8PR10MB4084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 14:57:10 +0000
Received: from MI3PEPF0000847E.eurprd02.prod.outlook.com
 (2603:10a6:802:2c:cafe::3c) by VI1PR06CA0198.outlook.office365.com
 (2603:10a6:802:2c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 14:57:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000847E.mail.protection.outlook.com (10.167.240.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 14:57:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:57:53 +0100
Received: from [10.252.28.159] (10.252.28.159) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:57:08 +0100
Message-ID: <c0732d45-1f34-4d59-9677-32e8967ca65d@foss.st.com>
Date: Mon, 16 Nov 2026 15:57:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] video: stm32: lvds: fix NULL pointer dereference
 on missing data-mapping
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847E:EE_|AM8PR10MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4973f4b2-c5de-430a-0b27-08df43f1e3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006|261028144727099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Q3Xe27nNjCrND7HU0ugjOwQY0E4XPCHSFENZGwJidNO1gnvP2SEOH4QzVbxbtvUPL6i2fLTjTF3QRSmvxk+sO2B1R5GBJOLKM9D+jXgHWAt9ynuRFreLAhEvcv0FTIwO9ruDdppcmr698TrsLcCPPEEfwIcJzDkrG2Pekh6J4fU1ATPsRDBtB0KXWLzaK/AEraXwStVpF37+8PmwO6Mzrjn/051pQfCi+fHxWoUs3jw92c0mjoVL85McDPwXJtIHikpBcCa569NO7WcsW0hMkSt5Fp7zc1Rj6VF9OTrqvdVd/CER/bGJ5IYdeEkpXx7WgtZ2fl1q4Qcpnfzvz5ppM1Yn1uY2aLSEnLvViidGLgdfEBNVkgYAaSUABdj9RJQ/TuMLH26T+Jh8jjRVOLowyYO3jWArs2CD3NxlliaNxSseTEuYiz5ulPfb/B4LRBSQLEkJ88eCgbt/lvFDHXO6B070z0Zl2DbaXZdjANDx14HOgmk5bne9jBAzFN4BTb5usCQLwD5n6fm+WInO8YyvNmnL4F0aYdj3Tkj+PF4qH0+VNSB+lJpDq5qvy58VsXUMEJhS1JZ002mt+lpfMG3uNNgQashXIkq6ygpRGS/1ivPlaOOVoK0r+VRu9ywZBiPWSZ6Y7x4aRk/RDTTP4244NaQjP2VeeVg1PhhPbZGcy/6i6AZSJAvAUWmmZi7egp1P2OGnDzwphQapblPHAWXoOw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFxX+4oiP9QQy2b3cqhl3lA6x4IRmbqVi4i88xeGj64SgYk6PS1r1imRG0hGdUdJQ4uUd/sKDA7w6iX+tDnQFrXL7wTQcYpV7qRFbqgnbEEfKX0gzAFU31voP+VI25TjOWbQzMJmMJiEDFxOO9+DzmhPv7A7ODq6IAIPh4gIq4qKfelZ1ZfmFkGd5V4+Mt3v8qzv6X2d+4AQr4weZ28QK8jFXJFq55tV8HT5VxvpDiD/1VIl8r7dU7Nsc00MkyXS0YZNMXoDaJshFngqR9mIVLVPUwUlSquoZijmc2WZdTHhMvzlh8BjTmZloYehDMW6gBd8k07XkEP1K007zvUvuCgrCC8vchKqa7nxNtRlPxgNLstOgTOhKANNu6eRizAoLhgfbp8StrrAA2EuxC/ArafFdEeZxKjgSOBMHc1Ye1gRx5ByAl3YT5dZXJk+bo3q
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:57:09.9352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973f4b2-c5de-430a-0b27-08df43f1e3ed
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4084
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> The "data-mapping" property is only required by the panel-lvds binding,
> so ofnode_read_string() may return NULL. Avoid a NULL pointer
> dereference in this case by falling back to the VESA mapping, as for any
> value other than "jeida-24".
>
> Fixes: 16cfbbbe2b51 ("video: stm32: STM32 driver support for LVDS")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
>

Hi Dario, 

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks,
Best regards,
Raphaël
