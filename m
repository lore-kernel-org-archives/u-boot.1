Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B900606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 06:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z9aZwwBF;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=O9XS8+GY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59D5C6081F;
	Tue, 17 Nov 2026 06:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qyt94JsFdJpG; Tue, 17 Nov 2026 06:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09BD660828
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794898731;
	b=Zc4Nl/ALpmvEGGk8KIOJ5ONI0R0iYSCvjE2TFgLIA91Nr8qNUJyf8UsHHDFOfUrv/2Xv
	 GY8IpY9mF7UhowFrr0jJR4vElCZxThqJtsLPJggFdfypccoslI2AoLHFwJ1a1aGJeg3Ro
	 qQGftkut1y+pM68Buux+MkVF6k7oRq7FGdVQI1aioCfQAZWHjqwWb77GBj9APCKaHUDb/
	 BnUQrwSadSzm2HPjpVceKmDdFK0/AuA2/LU4Hq8dQyulaJfqygVtcr+FNWKmlCbo6eO+l
	 ZeuMHpq2Gjnl1nC0Q5m8apOh9DmjdBDe9muxfmvVRUoDid9GSmYMHriqV+eAGxVHqpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794898731;
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
	bh=AVBOjJcl375wAgaicqcMwFu1BXRVgpGc6DhW+ieAkFA=;
	b=h+m+qGM8LtFGAf65M/jMwq/ZG8uscbGrDwGCOevdLY5Wjkz7/aX9kkGLt4DMoLjgf1/T
	 rpQ9qrmysy7HwYYwo++gwgriIPDEzGWQYknKbnsGaY5/TENISrjfEVGQrmLhEcWI1UnNG
	 i0sVlJSIEQIrONOQ5JALpb2VD2+w5TDJx7CPCodsbYKWsA4spoVxNndPtBIZNq2WFK5xE
	 BFOWfQTD4VCetzBFWG9o9+ehwtv5bdvakBgRDr4UGTtVYfhFT8PaY8lp3p+des0QYKD9G
	 8xDrH4qEG04hfjWuvrF2ZYikoPV6+O4VtCKZypt0tq8N5iFAaxGLrCHZZAlwHl4X83g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794898731;
	bh=AVBOjJcl375wAgaicqcMwFu1BXRVgpGc6DhW+ieAkFA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9aZwwBFnuPt5fLP4I1G84uiNYHc3JufU+IKq1tfm5AcGg339Dohm4jDPaO4RrEci
	 g5Y1XVb4kbp/+R1F5pnu27lMhyqZRFGLTNCYPKrDPM6tyg7ZuXbkAXlzA7GVnxkt5v
	 5qEeNjLhXghSOgFvy40hoKMz8KIqhEW/x17H08SmYK79C2fC855HWc0+Vsb07dKfwv
	 KeCMaAhDkRu7gsZy6rNChBsGOE45ZRLgKAD4fV5Bz8YNhm0vAzbVjV/lTrH2yfFwk3
	 Ya8In4K7EPMA85TGroNTdXxYOtC7c2bqVZ8GyYIl2cEG8iFwHhleUVxn7+u9j1WoDD
	 8RcsGiel2xXRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09BD660828;
	Tue, 17 Nov 2026 06:58:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 72A4CA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 512484071D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8TnxXEsAFtm for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 06:58:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4B9440705
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=O9XS8+GY
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4B9440705
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 06:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVBOjJcl375wAgaicqcMwFu1BXRVgpGc6DhW+ieAkFA=;
 b=O9XS8+GYL98E86XRSDRP4FY2yODmvm3Cp4Wyu7fV16FmuACspvfqY9cOLain/6OWuCFxnQcsvuBa5kMvoLLurjhYqHPV9AQkP+pOV0Y7A53pB5SDCXgPqJy2sluX8liOf5/zwNrt04VnK84tR6e+akvYtL4sWMuWYc4/jd3rGgeFtGnP7NCKM/zx3ctx1IGfBxGo1/i/S8HDW8agnVd3zWTneXwaR4DFJM6FjKd18E87uJtg0yXXZnS7/cg6doLucEFxrgiuq74cPpJUJg34Fc/o/p3QTyqoX8qDXbgLNl2lpIsM4SXxDuT6ac1+AjJ6Jj3nKBee6B1+xxDH54D2Ag==
Received: from PR1P264CA0058.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ca::12)
 by AS5PR10MB8123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 06:58:37 +0000
Received: from MAD0EPF000008C6.eurprd05.prod.outlook.com
 (2603:10a6:102:2ca:cafe::7b) by PR1P264CA0058.outlook.office365.com
 (2603:10a6:102:2ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 06:58:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008C6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:58:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:59:21 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:58:35 +0100
Message-ID: <b702d7b5-7615-482e-a38d-8c55b8320b1a@foss.st.com>
Date: Tue, 17 Nov 2026 07:58:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Aspeed BMC SW team
 <BMC-SW@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, "David
 Lechner" <dlechner@baylibre.com>, Eugen Hristev <ehristev@kernel.org>, "Fabio
 Estevam" <festevam@gmail.com>, Janne Grunau <j@jannau.net>, Joel Stanley
 <joel@jms.id.au>, Mark Kettenis <kettenis@openbsd.org>, Matthias Brugger
 <mbrugger@suse.com>, Michal Simek <michal.simek@amd.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 "Peng Fan" <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, Ryan
 Chen <ryan_chen@aspeedtech.com>, Stefan Bosch <stefan_b@posteo.net>, Stefan
 Roese <stefan.roese@mailbox.org>, Stefano Babic <sbabic@nabladev.com>, Tom
 Rini <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261116174048.3488151-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261116174048.3488151-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C6:EE_|AS5PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec184ad-8fbb-4eb3-1c4c-08df44783468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|23010399003|261022105027099003|11063799006|56012099006|261021123027099003|261009221227099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261009223027099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PnNTYWfB8ocMSfizJ7cKw0N7I8ATjVhmQY38fiMNG0Sa9TOXC3qLkKuQ41grOifhdowfF3ZAAQFubljul8vq9dxESD3Ll/v54TNsmS85KGmGzRb3XwJ545qmN8wVr5xgwh2tQ4g+FTKZikiKSPR2vFjdV4Ua+YGQFfgDPczhH7wjbmwEl0NWTDAMyeylbvTKgrFOwmFe5fiCaDy2YVUxTczi0k9dfa41UHh2iXVouGrYrijNdu6ImIXUE2mDFts9DeiEe1ULb/VYqClv+McIU8lwJQapwzpxisUtG/fT2ckS+hSQD0+mPusX5asZArGQ8WrngvssceS8srIcCm2EADYnINphVEy2+IU9+MQ2A5b9jRJQL2FOLdJvE11l/YJNBPDU+toH4lVtonUm0VyN4BUm3qsWAyC6HA/SPYbLTUKQW/yR+66EhHQymxspsdVkoDcZYME5UxS9+GIl29fmUfGSn6CEGCvAolIFS6WbhCrOGAZpXR2Gl7B8kWY24oxs1P0N6AAygkDtcJrVtc5jnM7TKJabvP5395LNvjukDJt9LaBygT8HAD+/xhrCt0pBro2GnHaUqHYJLzQ4WZ0dw6V3DsLOx5xDR5V9WoFLyRcjgt0MH1gxdH7OS7LMTM/Tjuuc4+yyQJJ5zPhB7b10OmAjRJzRaaedmggIIZYSuMF1fj9Cn0NnGiwimTAiGfBKtvphePGCUqt7AZ4V5BlGqA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(23010399003)(261022105027099003)(11063799006)(56012099006)(261021123027099003)(261009221227099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261009223027099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L/FiFlfBysidN08D0yDeyJsQfoq+4bcdh5JMG62rfWcPt7IkK4Po+Bn331CQ8rzlTQu5ildnf9MlUFxoP4bvd2V3mOSUSW8TxTneDzV/eAmrPDkaDluz47KsITY04TsEu6CVqdNTQqLk1HNfoy+IOt3pAPtWZUXO/bXwNHhu5lxtz011KyXjsVEcH2fOkdmmzsaJXjOc7mUePEUag2Y9wpxh2fZPTzh5lJ3EuTDuZsaZ66Rr4NEChFJKu+nEYGsiQwvoi3rrJE+2nbk+ILgv4QrmMQu6WhmN0Sdc+OKsTh7sz4HhFNl/WbcS00193i0KJlI0Sh3c6h4Ix0zmAARrV1PkCNRbkBoXKQiPetDlq5NBe0KSRPQM2unxCbk6r1SMcAqYauESCytm+GS8TSY1B4+BnQsNVhmA8GL48dUOhm53aHm/jnxG1GXWkqKK2Q3Z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:58:37.4818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec184ad-8fbb-4eb3-1c4c-08df44783468
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8123
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



On 11/16/26 18:40, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Janne Grunau <j@jannau.net>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Mark Kettenis <kettenis@openbsd.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/pinctrl/aspeed/pinctrl_ast2500.c    | 2 +-
>  drivers/pinctrl/aspeed/pinctrl_ast2600.c    | 2 +-
>  drivers/pinctrl/broadcom/pinctrl-bcm283x.c  | 2 +-
>  drivers/pinctrl/exynos/pinctrl-exynos7420.c | 2 +-
>  drivers/pinctrl/mvebu/pinctrl-mvebu.c       | 2 +-
>  drivers/pinctrl/nexell/pinctrl-s5pxx18.c    | 2 +-
>  drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c   | 2 +-
>  drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c   | 2 +-
>  drivers/pinctrl/nxp/pinctrl-mxs.c           | 2 +-
>  drivers/pinctrl/pinctrl-apple.c             | 4 ++--
>  drivers/pinctrl/pinctrl-at91.c              | 8 ++++----
>  drivers/pinctrl/pinctrl-scmi.c              | 2 +-
>  drivers/pinctrl/pinctrl-sx150x.c            | 4 ++--
>  drivers/pinctrl/pinctrl-zynqmp.c            | 2 +-
>  drivers/pinctrl/pinctrl_pic32.c             | 2 +-
>  drivers/pinctrl/pinctrl_stm32.c             | 2 +-
>  drivers/pinctrl/renesas/pfc.c               | 2 +-
>  drivers/pinctrl/renesas/pinctrl-rzn1.c      | 2 +-
>  18 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2500.c b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
> index 5ecd3f262b9..69e5d5b5618 100644
> --- a/drivers/pinctrl/aspeed/pinctrl_ast2500.c
> +++ b/drivers/pinctrl/aspeed/pinctrl_ast2500.c
> @@ -104,7 +104,7 @@ static int ast2500_pinctrl_group_set(struct udevice *dev, unsigned selector,
>  	return 0;
>  }
>  
> -static struct pinctrl_ops ast2500_pinctrl_ops = {
> +static const struct pinctrl_ops ast2500_pinctrl_ops = {
>  	.set_state = pinctrl_generic_set_state,
>  	.get_groups_count = ast2500_pinctrl_get_groups_count,
>  	.get_group_name = ast2500_pinctrl_get_group_name,
> diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
> index af3eeacba51..51f2c8e83ef 100644
> --- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
> +++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
> @@ -593,7 +593,7 @@ static int ast2600_pinctrl_group_set(struct udevice *dev, unsigned selector, uns
>  	return 0;
>  }
>  
> -static struct pinctrl_ops ast2600_pinctrl_ops = {
> +static const struct pinctrl_ops ast2600_pinctrl_ops = {
>  	.set_state = pinctrl_generic_set_state,
>  	.get_groups_count = ast2600_pinctrl_get_groups_count,
>  	.get_group_name = ast2600_pinctrl_get_group_name,
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> index 90eee88eb13..ab6306bff14 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -254,7 +254,7 @@ int bcm283x_pinctl_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct pinctrl_ops bcm283x_pinctrl_ops = {
> +static const struct pinctrl_ops bcm283x_pinctrl_ops = {
>  	.set_state	= bcm283x_pinctrl_set_state,
>  	.get_gpio_mux	= bcm283x_pinctrl_get_gpio_mux,
>  };
> diff --git a/drivers/pinctrl/exynos/pinctrl-exynos7420.c b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
> index b1d983fd383..3c73d0e1b7e 100644
> --- a/drivers/pinctrl/exynos/pinctrl-exynos7420.c
> +++ b/drivers/pinctrl/exynos/pinctrl-exynos7420.c
> @@ -48,7 +48,7 @@ static int exynos7420_pinctrl_request(struct udevice *dev, int peripheral,
>  	return 0;
>  }
>  
> -static struct pinctrl_ops exynos7420_pinctrl_ops = {
> +static const struct pinctrl_ops exynos7420_pinctrl_ops = {
>  	.set_state	= exynos_pinctrl_set_state,
>  	.request	= exynos7420_pinctrl_request,
>  };
> diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> index 0d5fa4ceb9c..2d1621d16d7 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
> @@ -214,7 +214,7 @@ int mvebu_pinctl_probe(struct udevice *dev)
>  	return mvebu_pinctrl_set_state_all(dev, dev);
>  }
>  
> -static struct pinctrl_ops mvebu_pinctrl_ops = {
> +static const struct pinctrl_ops mvebu_pinctrl_ops = {
>  	.set_state	= mvebu_pinctrl_set_state
>  };
>  
> diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> index aeed3f1e1e1..a6e9bc0ea0d 100644
> --- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> +++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> @@ -179,7 +179,7 @@ static int s5pxx18_pinctrl_set_state(struct udevice *dev,
>  	return 0;
>  }
>  
> -static struct pinctrl_ops s5pxx18_pinctrl_ops = {
> +static const struct pinctrl_ops s5pxx18_pinctrl_ops = {
>  	.set_state	= s5pxx18_pinctrl_set_state,
>  };
>  
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> index 92513822e70..8d7a9641230 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
> @@ -1594,7 +1594,7 @@ static int npcm7xx_pinconf_set(struct udevice *dev, unsigned int pin,
>  
>  #endif
>  
> -static struct pinctrl_ops npcm7xx_pinctrl_ops = {
> +static const struct pinctrl_ops npcm7xx_pinctrl_ops = {
>  	.set_state	= pinctrl_generic_set_state,
>  	.get_pins_count = npcm7xx_get_pins_count,
>  	.get_pin_name = npcm7xx_get_pin_name,
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
> index 29536f556ad..55c322aa604 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
> @@ -984,7 +984,7 @@ static void npcm8xx_pinctrl_clear_events(struct npcm8xx_pinctrl_priv *priv)
>  	}
>  }
>  
> -static struct pinctrl_ops npcm8xx_pinctrl_ops = {
> +static const struct pinctrl_ops npcm8xx_pinctrl_ops = {
>  	.set_state	= pinctrl_generic_set_state,
>  	.get_pins_count = npcm8xx_get_pins_count,
>  	.get_pin_name = npcm8xx_get_pin_name,
> diff --git a/drivers/pinctrl/nxp/pinctrl-mxs.c b/drivers/pinctrl/nxp/pinctrl-mxs.c
> index 8b764738014..fdecc3f359d 100644
> --- a/drivers/pinctrl/nxp/pinctrl-mxs.c
> +++ b/drivers/pinctrl/nxp/pinctrl-mxs.c
> @@ -145,7 +145,7 @@ static int mxs_pinctrl_set_state(struct udevice *dev, struct udevice *conf)
>  	return 0;
>  }
>  
> -static struct pinctrl_ops mxs_pinctrl_ops = {
> +static const struct pinctrl_ops mxs_pinctrl_ops = {
>  	.set_state = mxs_pinctrl_set_state,
>  };
>  
> diff --git a/drivers/pinctrl/pinctrl-apple.c b/drivers/pinctrl/pinctrl-apple.c
> index 083ea6d6cd5..78999233df4 100644
> --- a/drivers/pinctrl/pinctrl-apple.c
> +++ b/drivers/pinctrl/pinctrl-apple.c
> @@ -96,7 +96,7 @@ static int apple_gpio_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_gpio_ops apple_gpio_ops = {
> +static const struct dm_gpio_ops apple_gpio_ops = {
>  	.get_value = apple_gpio_get_value,
>  	.set_value = apple_gpio_set_value,
>  	.get_function = apple_gpio_get_direction,
> @@ -182,7 +182,7 @@ static int apple_pinctrl_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct pinctrl_ops apple_pinctrl_ops = {
> +static const struct pinctrl_ops apple_pinctrl_ops = {
>  	.set_state = pinctrl_generic_set_state,
>  	.get_pins_count = apple_pinctrl_get_pins_count,
>  	.get_pin_name = apple_pinctrl_get_pin_name,
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 50a130d700f..300c912b928 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -304,13 +304,13 @@ static void at91_mux_sam9x60_set_slewrate(struct at91_port *pio, u32 pin,
>  	writel(tmp, reg);
>  }
>  
> -static struct at91_pinctrl_mux_ops at91rm9200_ops = {
> +static const struct at91_pinctrl_mux_ops at91rm9200_ops = {
>  	.mux_A_periph	= at91_mux_set_A_periph,
>  	.mux_B_periph	= at91_mux_set_B_periph,
>  	.set_deglitch	= at91_mux_set_deglitch,
>  };
>  
> -static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
> +static const struct at91_pinctrl_mux_ops at91sam9x5_ops = {
>  	.mux_A_periph	= at91_mux_pio3_set_A_periph,
>  	.mux_B_periph	= at91_mux_pio3_set_B_periph,
>  	.mux_C_periph	= at91_mux_pio3_set_C_periph,
> @@ -322,7 +322,7 @@ static struct at91_pinctrl_mux_ops at91sam9x5_ops = {
>  	.set_drivestrength = at91_mux_sam9x5_set_drivestrength,
>  };
>  
> -static struct at91_pinctrl_mux_ops sama5d3_ops = {
> +static const struct at91_pinctrl_mux_ops sama5d3_ops = {
>  	.mux_A_periph	= at91_mux_pio3_set_A_periph,
>  	.mux_B_periph	= at91_mux_pio3_set_B_periph,
>  	.mux_C_periph	= at91_mux_pio3_set_C_periph,
> @@ -334,7 +334,7 @@ static struct at91_pinctrl_mux_ops sama5d3_ops = {
>  	.set_drivestrength = at91_mux_sama5d3_set_drivestrength,
>  };
>  
> -static struct at91_pinctrl_mux_ops sam9x60_ops = {
> +static const struct at91_pinctrl_mux_ops sam9x60_ops = {
>  	.mux_A_periph	= at91_mux_pio3_set_A_periph,
>  	.mux_B_periph	= at91_mux_pio3_set_B_periph,
>  	.mux_C_periph	= at91_mux_pio3_set_C_periph,
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> index fa31b573f31..5e4305d7f76 100644
> --- a/drivers/pinctrl/pinctrl-scmi.c
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -196,7 +196,7 @@ static int pinctrl_scmi_pinconf_group_set(struct udevice *dev, u32 group, u32 pa
>  	return scmi_pinctrl_settings_configure_one(dev, SCMI_GROUP, group, param, argument);
>  }
>  
> -static struct pinctrl_ops scmi_pinctrl_ops = {
> +static const struct pinctrl_ops scmi_pinctrl_ops = {
>  	.get_pins_count = pinctrl_scmi_get_pins_count,
>  	.get_pin_name = pinctrl_scmi_get_pin_name,
>  
> diff --git a/drivers/pinctrl/pinctrl-sx150x.c b/drivers/pinctrl/pinctrl-sx150x.c
> index 0d64f4d5ad6..f41656b1b67 100644
> --- a/drivers/pinctrl/pinctrl-sx150x.c
> +++ b/drivers/pinctrl/pinctrl-sx150x.c
> @@ -692,7 +692,7 @@ static int sx150x_gpio_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct dm_gpio_ops sx150x_gpio_ops = {
> +static const struct dm_gpio_ops sx150x_gpio_ops = {
>  	.get_value = sx150x_gpio_get_value,
>  	.set_value = sx150x_gpio_set_value,
>  	.get_function = sx150x_gpio_get_direction,
> @@ -886,7 +886,7 @@ static int sx150x_pinctrl_probe(struct udevice *dev)
>  	return 0;
>  }
>  
> -static struct pinctrl_ops sx150x_pinctrl_ops = {
> +static const struct pinctrl_ops sx150x_pinctrl_ops = {
>  	.set_state = pinctrl_generic_set_state,
>  	.get_pins_count = sx150x_pinctrl_get_pins_count,
>  	.get_pin_name = sx150x_pinctrl_get_pin_name,
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index 0b936684f8a..2a16dec80a2 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -630,7 +630,7 @@ static const struct pinconf_param zynqmp_conf_params[] = {
>  	{"schmitt-cmos", PIN_CONFIG_SCHMITTCMOS, PM_PINCTRL_INPUT_TYPE_SCHMITT},
>  };
>  
> -static struct pinctrl_ops zynqmp_pinctrl_ops = {
> +static const struct pinctrl_ops zynqmp_pinctrl_ops = {
>  	.get_pins_count = zynqmp_pinctrl_get_pins_count,
>  	.get_pin_name = zynqmp_pinctrl_get_pin_name,
>  	.get_pin_muxing = zynqmp_pinctrl_get_pin_muxing,
> diff --git a/drivers/pinctrl/pinctrl_pic32.c b/drivers/pinctrl/pinctrl_pic32.c
> index 090351072d8..00e85b6cbeb 100644
> --- a/drivers/pinctrl/pinctrl_pic32.c
> +++ b/drivers/pinctrl/pinctrl_pic32.c
> @@ -327,7 +327,7 @@ static int pic32_pinctrl_set_state_simple(struct udevice *dev,
>  	return pic32_pinctrl_request(dev, func, 0);
>  }
>  
> -static struct pinctrl_ops pic32_pinctrl_ops = {
> +static const struct pinctrl_ops pic32_pinctrl_ops = {
>  	.set_state_simple	= pic32_pinctrl_set_state_simple,
>  	.request		= pic32_pinctrl_request,
>  	.get_periph_id		= pic32_pinctrl_get_periph_id,
> diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
> index 1758f9a909c..1db111628d9 100644
> --- a/drivers/pinctrl/pinctrl_stm32.c
> +++ b/drivers/pinctrl/pinctrl_stm32.c
> @@ -533,7 +533,7 @@ static int stm32_pinctrl_set_state_simple(struct udevice *dev,
>  }
>  #endif /* PINCTRL_FULL */
>  
> -static struct pinctrl_ops stm32_pinctrl_ops = {
> +static const struct pinctrl_ops stm32_pinctrl_ops = {
>  #if CONFIG_IS_ENABLED(PINCTRL_FULL)
>  	.set_state		= stm32_pinctrl_set_state,
>  #else /* PINCTRL_FULL */
> diff --git a/drivers/pinctrl/renesas/pfc.c b/drivers/pinctrl/renesas/pfc.c
> index 1e0fc3f563d..03f1524e9e4 100644
> --- a/drivers/pinctrl/renesas/pfc.c
> +++ b/drivers/pinctrl/renesas/pfc.c
> @@ -909,7 +909,7 @@ static int sh_pfc_pinconf_group_set(struct udevice *dev,
>  }
>  #endif
>  
> -static struct pinctrl_ops sh_pfc_pinctrl_ops = {
> +static const struct pinctrl_ops sh_pfc_pinctrl_ops = {
>  	.get_pins_count		= sh_pfc_pinctrl_get_pins_count,
>  	.get_pin_name		= sh_pfc_pinctrl_get_pin_name,
>  	.get_groups_count	= sh_pfc_pinctrl_get_groups_count,
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> index fdc43c8e714..2bb00aaab5d 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> @@ -341,7 +341,7 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>  	return 0;
>  }
>  
> -static struct pinctrl_ops rzn1_pinctrl_ops = {
> +static const struct pinctrl_ops rzn1_pinctrl_ops = {
>  	.set_state = rzn1_pinctrl_set_state,
>  };
>  
Hi Marek

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
