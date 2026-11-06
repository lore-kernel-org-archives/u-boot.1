Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB026606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FiQHIory;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=GThr5oVB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C9781239;
	Fri,  6 Nov 2026 18:19:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kNHcMR7EVeRd; Fri,  6 Nov 2026 18:19:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0A7C81228
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989176;
	b=BNlPUsLPfvs98L243f8U+mhZ1Htl22b8uDyiYVfa9FWbirUZGJ0eF47BzOtwgdmADctL
	 ZipvHTZlUuUyfxVSdwuyifKAETe2FTDN8mWjHfSd2VXXwDYew5QlAETSyrkHU8+1S1PvA
	 PMeBcbRyv6bgzbzV9VqGrdVLHQ2no4L32+QA6HO3zGGZ60x10mBPKgsru8U+U2/myOrpG
	 VA9fV+JUr9lbTuKQbLjBvBCsQRBSic/BDqBU/ZwS9iL68VYjMHyMJO8ovBpR1OE+9zXuG
	 E0r6lDF/BpSlA9s40oeCSyuzKWTclSX7Jof3Veph4FAeUjT9cNp6w6ijfL0ZeGxn+9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989176;
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
	bh=gix/wrNRndCkEkcf8EkjZtDev4S+OnMa4jgVEgtHlWA=;
	b=VGp6PW0ne82md0uhkk5dX0nENGaBItP+gkHCt28YN5TsVdxIhMwfaKT32OWHpwXgeX/F
	 fDWhRt6PKL0f7sWNQGkvH3D4H8pp87lhhdM8ZlH2pZEt8WBI+8a3cX6kqPbsH8zysC7Mz
	 6dH/Wa2lAIYlAeMtYzyY7l+lA0hgKczCEfmMj9mBNDTRjJTBaGsP3TrAod+189s0FUj95
	 pOU9fLZwGZR2lZQn8R5F0ohgx4crgBfjCkDTAlsFTKZBJKnhDcm3N/PIf7dqzxo2VYWx4
	 9J27w81yFWZhFY+SuqkzjUlPRNNxsc0jt+78OSAG3wwIuzO9uZoBiBbay/ylU1UcndA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989176;
	bh=gix/wrNRndCkEkcf8EkjZtDev4S+OnMa4jgVEgtHlWA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FiQHIory7fpoOhDwbjUvuoK154EXcuWTiYJBQSv5gf0EzpH/8A0Sul5cxHKWr+94O
	 W/YPiz+g9ZRBpcHL/chq/VK3JRpQCFJGxbb3HMYB6bklVmStNxGaou5c+O08TNXn/s
	 FIx/3nx4Ks7CUaXCFKdDtIqb1JwNz+kpHU1oeiE0vGD8aKrsemmB9ECHzE12ep2ois
	 V1IgPVUJUlEtFBZAU2ZO/z94QI3U3DMdtlR9X1CsYNtsv4y6Asdlpi4AM7J9yoobsH
	 +n2V9PscQkGp2yGM92ezBITfWuZ07SEBJxK3ft4V1NH944wllF988xEXBnl1vjs17g
	 nJxOU5Ty56yRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0A7C81228;
	Fri,  6 Nov 2026 18:19:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E5036235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6E0A4099A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:19:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIp7CoI5SVNW for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:19:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79F1B40996
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=GThr5oVB
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79F1B40996
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gix/wrNRndCkEkcf8EkjZtDev4S+OnMa4jgVEgtHlWA=;
 b=GThr5oVB6YCrdfqG9oxi4gQJDnZPoGo+pFngK9S7ywyrDesJpM2XtZtkh6bDpLig5BGP6mMnCmdDoclcXRlmMFBbqr3GjFI1pBO/8ADoJm6RreTUTZZS06WZK5nSmR4e+e7u5W3FlpUgw48yg0x/PA9j/D9Sq6h+zBqXXiZDsgS5ugqd5j+dhojjk1LZrB2VXaABGQcbngTdhbnp7NfZzuaiCjzznib6JvmIwbOs9j3Ny1TtMkRgvP0+p6uvPNuFgPwOLpmufr/sSXvs8hkwpwXufJ5Ubag5c4QPj6ljYktCOKgPjkEi0HCJocVvfXujsyB0WVBKZLNz0WsCL7Dx1A==
Received: from AM0P309CA0025.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::10)
 by GVUPR10MB9895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:19:27 +0000
Received: from AM1PEPF000C1AD9.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f:cafe::3a) by AM0P309CA0025.outlook.office365.com
 (2603:10a6:20b:28f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 18:19:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM1PEPF000C1AD9.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:19:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:20:12 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:19:25 +0100
Message-ID: <22b54ed1-ad16-47ad-9605-2f6fd0578d59@foss.st.com>
Date: Fri, 6 Nov 2026 19:19:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dm: gpio: Add GPIOF_PROTECTED flag test
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Vincent Jardin
 <vjardin@free.fr>, Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
 <20261106-upstream_pinctrl_update-v1-3-4f3d4f6e97fc@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-3-4f3d4f6e97fc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD9:EE_|GVUPR10MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c111979-1b22-4485-b930-08df3c327df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: feMZrOx9PjIddos+tPa1Vz6aty+P9vP4cC9lEUv4akpXdw1BSHyL6NCEQgvQHr5Kvu2a2ZPFFwSNj/Hu0I0NyaXanpArcu2Tf4nq/zXt5/9e8AosM/XQwzAzWdTeDUQ3W4nZjIc1+ZiQINC0YnGz7EqIY/tXuEbpQLp63SZl9MIkfKvxpP+GWLhIsUnS/SIeEZonPoJ9Gl9ZR4ySZ/VAWCObbdX2e0Xa95prPRUzSPIzOq3ylZ5F40WwLJCgnuPs68OeuuAmA0tiPMVZOwjlzkGzAILb/SJ39kMOXXeCWnWY0DGAJH6AvIZdVDHlPuW4GjZgAyIQUAIpD3nNOJFtxTLsdk5AQt3eRbVpbRaY4Hmq2gQpC+2T3z2Ih5ONn7do1PekljFWh8zWWDQ91PSKvwWrShQh7jUq3ysQwh03SxWSE8rLAxvjP5f90IeeZ+5dOiUAQkhxvfRMTIrVPfApzwC0RNGIWFUdhaHCxmS7Hd7N6MC+0FZp7wY92LCdPvjeqtPhwAlxo7f12qky/Kss4yuhYvQaF/+M9pfXD6goy9fFMeyi9KJ/IQOXnEL/N2GaHviXKb+oHdvzSuw0cAM4VToStlwLvVDGz7w8EXP71bJPv8+dnKfBolsOBbWRcRjwg2iXY9fWGz7OgaK30DMIoyhyBOd5P0yAP7YYDCOWW8YTuiIOY2QAWVYCaEFwgTJIkG3hhV0zVF0k2jeYvVhjo+42t4cluQvLJG2KjfMOJInYU4VAYX+fBQp8EWZzJXnm
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G2C7P+jD/X2TwQxqbN4QOyBThHZcc8Df1OgwYl5GK+cTrqqtQP1H86A3yidK2IpvVOmO2q0BGDZmA8T9jxK4Us0z3Gtc2iR6xTOUVK/e9N8jevF5EGgUDSs8T8VfgiiUcmzemp5/jiPiydSQDa4v/sUumw8+v+2QnB0E5nzWdbjOqli4IMxCHoBt4emzN5c5QqZ8uaFwsuj4+Msyn+blfVpPdiOt2QaOhLc+N+hhAK2bbuOHkLAUCirPih2/3R5tD+m2h8ns2S1q/XftYvNplea0eWJQqdXPmWmyCu8kG3UWYioostYhyEB9DY0vpRZFFJZj28Q8FoIbMupnSwzNXF5NHBCr8+Xp/8qnnFGHvdCVpzan9Z4d2hS+rJNnGkl9Cjlq5yN6/4CF9z7XyJ9ysC+k0QV0DYNSTXkny4Q6CbqyBfOlsdvLZubQKPWZJG+n
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:19:26.8099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c111979-1b22-4485-b930-08df3c327df2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9895
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

Hi,

On 11/6/26 12:18, Patrice Chotard wrote:
> From: Fabien Dessenne <fabien.dessenne@foss.st.com>
>
> GPIOF_PROTECTED flag identifies a GPIO which can't be used because it
> has a protected access, this GPIO can only be accessed from the secure
> world.
>
> Add a test and support for GPIO sandbox.
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/sandbox/include/asm/gpio.h |  3 ++-
>   drivers/gpio/sandbox.c          | 16 ++++++++++++----
>   test/dm/gpio.c                  |  5 +++++
>   3 files changed, 19 insertions(+), 5 deletions(-)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

