Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C5606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ylWu5jEx;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RD1oPIp5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41F6881449;
	Fri,  6 Nov 2026 18:11:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2BJuvNJ_WjPY; Fri,  6 Nov 2026 18:11:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8306181404
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988672;
	b=LpLkKwkL+dJNjSxIhUVBVluzWPqAytJszmG9STnEu/9uxitLlcYM2ASj9yO2grLRduDy
	 2BmSvv9vMyUsuoI1mwHzZozGQ0v/q8rLBhl9frhyHuN6MwcmWZ4kPAJf9YxXDVPS70PIl
	 vE4EzNe+5Wqp1mDQr0tY2KoVNAVwS+idIqnCh+QlIX1QvElBu4KYVnvlSHz+vMt9kzsuT
	 50B3J9m/AICpIydYu6Y800hGAJl0crZTHzXd4Qv6oP5zY0ip+zjB3MfAQS0BkIqdzB65E
	 BqDFgbbgk8gYfEU2ZpebsIutR6d0yL1lRXjBP3TGbEAon4Os45xCjyYukdyCtkWB7BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988672;
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
	bh=vF8opmqViaBVGyXBOLnGlR2KrivVcktw+0f8eZ3VcnU=;
	b=BJC067ipDQWfxekYSM6XiE3AjsIzwEPM2bKL0BxX+iGziSVi8L+f5MQKDJ1ifUFzMb6z
	 9YkOIi1k/LYJjQrHUfNharbxwLuavlUN7OALsYv/DXAs1PLiF8plKd8EKfzwT8fGiPo4x
	 H5uArxhC3vyVwXuTcsZnjnnioV4V2BsbCIkLSW9YAhL7z6TtHSZ0m5cWULXVL3LmXPKJq
	 VqzXD+a37UBtfsWCCSO6g/SvnDufmba0W655qqbJ552GIpkhykoV6fp2Yj6s9IBXA49eg
	 FfSlKQz2SkgW9M0KdPwQS6kcIhxKE+xDFaCw4LVE3XmKYshbCYlJWtZA4tMJ0NcohRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RD1oPIp5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988672;
	bh=vF8opmqViaBVGyXBOLnGlR2KrivVcktw+0f8eZ3VcnU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ylWu5jExFClZNYBjQxGQVSREl9QNpH6MhKzytrh/UK+1WwLd1EbylI3o3XDDr1L6J
	 /kcAN6PWnzsOqJNVcWzVOVpjqYqU9hiRp5Lx9Z8wGnSaDezRha1SD93ai6aHcITy+s
	 lkcOO9N0MErUaOHv7hZqpu764JxKU1Om1uRzAqiGw0nhJm7yi03OdSZnI1wFamQxWV
	 LnQ9dUHV+VMfuI2f9Z6Py14gLgfV3KZypNqbA8uJksGR9eAXIoErGza1g2+nNFmbzP
	 aKgoBE4gGkPbCh5AYlO6k8QfvqQSwbsh8yhIRMFpeKT7yi2vAOjtSG+HuPYOC7XG02
	 KLXsp4+7BOBkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8306181404;
	Fri,  6 Nov 2026 18:11:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 918CB4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7763C81404
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TKGPZPtu4Lo for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:11:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF30D812F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=RD1oPIp5
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF30D812F1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF8opmqViaBVGyXBOLnGlR2KrivVcktw+0f8eZ3VcnU=;
 b=RD1oPIp5pZCx8prifOTUmMLkClcuiGsPLT6s/QzHmgbwneHVU0bThFPThMmrIQcP73t6HwK0EdHEXwXK7Fw9B2ybRvPOCKgU0/cEVF9QV8hhDQAjeYCWqIzyzmi7Db0Zx3l0TDjAj6FHpUFw5t8ab62pyjJp3VTCPsTRl0aY7pJHRtWtxkw9ycr9oBN7Er+43f3ipMh/ytMWQqprOk7mlzLqjEGARQAjeET7CADp/cF1JIAov/K3RLFk5IhSUcxY2fO6B9NffXEQmOw/5NgI51zCvFpVueDP3BiDKmVNqpz5bv9HUNIbXyANJf71En0YVe/KGgxYQVIFVZsJ1dZhsA==
Received: from AS8P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::15)
 by AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 18:11:03 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:20b:458:cafe::5d) by AS8P189CA0034.outlook.office365.com
 (2603:10a6:20b:458::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:11:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 18:11:02 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:11:30 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 19:10:59 +0100
Message-ID: <79e03975-a4d4-41ed-8ea9-b561e98b9bcb@foss.st.com>
Date: Fri, 6 Nov 2026 19:10:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] pinctrl: stm32: Support I/O synchronization parameters
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, Fabien Dessenne <fabien.dessenne@foss.st.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, Vincent Jardin
 <vjardin@free.fr>, Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Valentin
 Caron" <valentin.caron@foss.st.com>
References: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
 <20261106-upstream_pinctrl_update-v1-1-4f3d4f6e97fc@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261106-upstream_pinctrl_update-v1-1-4f3d4f6e97fc@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F6:EE_|AM0PR10MB3571:EE_
X-MS-Office365-Filtering-Correlation-Id: a11ad531-586d-4650-7b88-08df3c315124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|3023799007|10067099003|56012099006|4143699003|11063799006|261021123027099003|261009223027099003|261102123227099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: jr5bVcRBqaOXfb7XJ0YIje92Pw7g3SCpoZC3HtYS9ikV2TaHupuCNRfr4XOqSHZA3sYnyQysZSeaV9sjxSFRfMseGu+nePnnSOkiGh2SiU7J9xRkOEZiP+V4f4cKrQRbpHUEjPr5/sidhtGIeepxpveCgIIGLQN3icA0+vtsG+GtlOjOuCqTD+PxXmmzOQNKkBbVrpTsnDERDftWEUsgeNBBCxrNXkOxyIXvwpM2o7qw9wq5Oxc+cjm2iJgnd2RJMJheDJySiGV7aNw3ONYwhnxcb8vd7n+c+iFuqUN5NK33ZZ6+bJnZag2xlk/t7r7jNYW7Kg0zRQApSTaqhk/MivazbNOcJ1Sgh7N7nVI4fsuA8AycfOVkRX/EPWKfuAgWA9j/gB0EulHqt5RxboA2Pyxu735B90PFv5YwhE74IeXeRr90Wg3WTVmpTesKN9qpMIzLCi9iR0+m3i4zKe7jsZ8a2Yp7Q/TqKNi5oSu4mETXNiMhmsb1dugUOb1ZtOPwKgpGkJutkN+bJy9n6Z0shJl0xueAAeMx/c7MhMQq0pEAvaisz18YK68GBC150qD1QYDU/jhhIBytbSy3N4FxlnJ7l0axiszUFr3YcRtq2luMLFsESzvC5V1OAlXoPgAKo7sdcDwRo7WkdLmpuUY1HsnxmBvAd3qTg5iK8vDcX60QWZxWd0Z+uOCRHw/UMjdaEPFtE9nuNtQrEZRObM19H68c69cE8ybnYksH8AixfuIk3OGa2kVw73z/m2/Z2jPKTfSsbtRXKeuULDdcKJWbVA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nr3A5cA7ulDHSKKarMbFl5dG+4bTLHHl+wCKO/kxvKvNlraBS3b6JuPR9AQaDb7cXmU5LJi56NBLNy/oRxdXbRsgVpMVOTYKkLaxAK9QZ3r9DROH3SUq8b+OmKGEB5Gbmi2630xlf5t1EYMsTo84x59WKlbLJdZgo+CgeH6BFZ7+7FwP1S7niUCdnOviqOELIsba1D0wkMd8gQ007wBtuQ9mNsj+a1cxVmAW3loA28ikGzN99ToCpZ4xNvxNLPBB9mg0IWSoBCL2JvQ5s8LdYibJK7Lip0W2DvWX5z8Zxge49cNCaesUXH7qw8XpSgWzVy/nBuqWrMQCL88tXS1Yse9YZtstzFnXIXUCOhvbwjnq4I2W0wv73TqoKmIO/CsSXnSjpXxqfQDgjIiiThPC8cauQILThci/WQaJkOCcCpoceZN1WCrYRGuwhtD6dgZq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:11:02.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a11ad531-586d-4650-7b88-08df3c315124
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3571
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

Hi,

On 11/6/26 12:18, Patrice Chotard wrote:
> From: Antonio Borneo <antonio.borneo@foss.st.com>
>
> Devices in the stm32mp2xx family include an I/O synchronization
> block on each pin that is used to fine tune and improve the I/O
> timing margins of high speed synchronous interfaces.
> It can be configured to provide independently for each pin:
> - skew rate on input direction or latch delay on output direction;
> - inversion of clock signals or re-sampling of data signals.
>
> Add support for the generic properties:
> - skew-delay-input-ps;
> - skew-delay-output-ps.
>
> Add support for the property 'st,io-sync' to configure clock
> inversion or data re-sampling mode.
>
> Enable it for the stm32mp257 pinctrl driver.
>
> Co-developed-by: Valentin Caron <valentin.caron@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> Co-developed-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/gpio/stm32_gpio_priv.h  |  58 +++++++++++++++++--
>   drivers/pinctrl/pinctrl_stm32.c | 120 +++++++++++++++++++++++++++++++++++-----
>   2 files changed, 158 insertions(+), 20 deletions(-)
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

