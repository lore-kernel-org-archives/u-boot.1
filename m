Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B78606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X5NJ/oc9;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LGD7If2t
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B58734095D;
	Fri, 27 Nov 2026 13:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOWC1YMq_3Xm; Fri, 27 Nov 2026 13:04:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED1E9408B0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784668;
	b=iq5CgHaukgCLF3M6EV63BA5LxBK1lrYBMYGuV+NzNpxMPJU8qyqetYVo0DE7m2ZIddDx
	 xlV+JhEgojSuaWGm2s2FfKrshALYOvr2QH1vR2o4LMXX397C6NUTWsqwTq2g/0qWaX0Mh
	 O+QV22i4rM0PXdrUEAvs1f0uelA1a8Cd0SdzZz0eyqL6r70GkIhDagXTkj8IyvdTn36Yp
	 01MkQ6I8O1PkFbqghgNQzG/+cHcWYob60l1M5NIgbcyVizK9/imePDA5+pmfQoS44yABf
	 G19puu5f1C8fgZ+IxXyWnuItJvtZU4nVIZNk5mDPS93BkNMtFLIesg7EHb9SuYGwAOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	bh=4ernOmf+6fOAdbbBdPDxj9OVopw5pVjye7WjM44OX6A=;
	b=poRcOFFVeU7J8EZmZsVgK3Jqvce4X6uQqxq5EZDE5Rx1jWDEqVoTjMGH75+hC6W7kRC1
	 525VN3VmNZuAdx/Z1kU1vzvR8HboQMbVGhk8hc+NQj0ye3twJJvoo/vv+69KlhgIC8dG3
	 ILsjlebHrGxPQGTVNBeYX2ASLpqFN5H9pyergQOC9YqcjVnCiPkqk4Fdo/68gSjfjs45X
	 m8UaoKg9vXWsymHXc0oHfRIIsMjXNC9AGwemLbRhhoDkFKCgmEArgAssqn8TEwYuODFzv
	 p6vP61Wy/tyN0gopUm06Y28leCVMqkP0M1FmmFDms84NA95L3nS6wCTGQsMRo7tasuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LGD7If2t;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784668;
	bh=4ernOmf+6fOAdbbBdPDxj9OVopw5pVjye7WjM44OX6A=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X5NJ/oc9c1BoVJD0ALsrVM73u2XFQrVUVAxxn3rwvoRpFcK69Sk3hHUvKgvSteqRY
	 MrM+mRd/QyGoq3dV92MMCPGIDFpcdHL6dt3BBhCHoY9xQPjoxxeRy0Us/Prfk6+cYS
	 hNSwBGey84MOQFTBpDpplpQmgWMbRoBImnFWaZQIeog7fbj67HZpPbDu1qTl85Z2Bl
	 088vL5fUutvQBt8Oee5zVLjg66aVGD3N9TXrC8/meVcvFS2a5+jwO67Zzcdl5MbBv5
	 hwMpiqJ5WkdgFg8vnf3HJrWq2Xpm/6mi8lxfNMvn/4IuFEPvkipOOsm1wIykWbxTmf
	 fEONhwttlSgFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED1E9408B0;
	Fri, 27 Nov 2026 13:04:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 835A8373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6919940874
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABVlGv222tji for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1EA81406C7
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
 header.s=selector2 header.b=LGD7If2t
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1EA81406C7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ernOmf+6fOAdbbBdPDxj9OVopw5pVjye7WjM44OX6A=;
 b=LGD7If2t0TimNXMS8m0mlQVZS8gtxbuE2iADuq48UM00XaJh7LQ7kVnRerPih5VDegM6+nTwICPhzO3L2+shoDboe2T1Md48pJEnfPitNoVAOM/3SZWyW+/GAFL/NukGZlpYvOmkBtP7TMw/9015MMUSLAvExW9o+dXDRuYPeFkUUnOSKXXm3NkJSX73/xna9lwejfjSLUFcMoxhAZKDTMaeF9TetpxiIG7x6zt+4cKCA6ljX7N2z4Fh6CW3Y7UjkpaywJ/AN0u1N9Fc2fsZRyRBZp1U/juLdEeXQuhuyFlD3PASgAIiOA8m4rpfnPp5yAcwabFYaHHn6C/G1enMUw==
Received: from DU7P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::18)
 by AM0PR10MB3236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:04:19 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::83) by DU7P190CA0006.outlook.office365.com
 (2603:10a6:10:550::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 13:04:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:19 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:25 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:18 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:15 +0100
Subject: [PATCH 2/8] rng: stm32: update STM32MP15 max RNG clock frequency
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32_rng-v1-2-b8b4a9fdc8a8@foss.st.com>
References: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
In-Reply-To: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?q?Maxime_M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F3:EE_|AM0PR10MB3236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efb9adc-d4dc-4957-1327-08df4c86f2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|261021123027099003|261021121427099003|261102123227099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oIKtHcLUnl+26nRpruA60ULpkjby0LPFAmb+bAznIUaIbuMxR4DJAPFi5kSJd3pYtu/S2eYkeAuPMCTHtN8PIN0QZa+W9wiJYiP9gtUxjhBzplCvldmuezGqVif2BomdSdXJA3pxmtsnsj4oimPJpiwkEd3TjoLuzAJrWQTBYLWKvQlRZlk2/nlM5et362/Px2Ixl4gnIFEzsfWnkqHgU4dS8NlwIRpIzrY6KtWjab23cTCwoOSl4ZHrmXa98HaYOy9Lnkjyj5Aud+8EsSHXnYkglxdxBjuQEsRk1VlYvC/Br7FpXqRSts89j4Wpzx88VtBBC3N5pUsmzKJ/fnARvkXE9s+bekBnXXY+oXPguuXEcSZvjRqr+IWyw3bCHGQUOI/P5khgjLsjMa/I/1hF/oOCo4z1jRegm7Av53emqB1T2ga0mMkrg3sMXH61Ex5m8DuN1mxk99VJBj7MW+g0xuPB5R70Hv+73xzElnM2gCHG45kuSTpFIcsfFKfJVow/TShdW0EdxR1KNSQBVsL1seXdznG2RLg6w314HDQDduEcSwG1fWj9FkgZuGHahBmgU5KkunEKEK4gTW4h+QTbVAt1ElRzHD+MME6M18mq0Dge6+95iJAKwdkJZ/MU+7nBDU4qamvzRK1JanrXdVkFyoGfTZn19shUOCjQeibw9ZNWvNEDHUJ+pTGfWL4rxhaxBqcOUuZvoyyjKaMYiBYgJw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V+HCzX1mjk7mMHLSngBt8jvkDBaKalbioZxOJJZfEGJ/S4rDCN6AEuazArAZ0o0TOKvQ4pIAS1q3XIpgxc5gwQ14Guh9P9V1ivsxHqdhcNV+ixPJ9BnkANrCJe5m9jvDYq49Nf+4z64rSw1mYK/p35MIk5fBtkC/Dt7zdvSo0y9sFchBbgLd7kpiSnu6KMcfLQxdNJ3efq3RvgG771d/zE/Vv1n++fNyAS5f2FX4CRPhMiETHpa6c7jc5pbc4WIfpbeEZRMwiT1WcKCiBMe/Q87xgsUDs9QoIKM4O8zQdO3wh8h9QiFELRQ5x1cfE6+JxtrzXIf4eAY/jzYxr1tTP/HqUoQ035STtZXbK15vwfo2Xjo9WPLm8EcmqtUrnkGkO+qZNOg2LC7ufJOlxGUrwa/z/wmE+cBc07OXCGhuLeXjxk2EiN7/rDYssDvawdXK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:19.1312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb9adc-d4dc-4957-1327-08df4c86f2c9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3236
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

RNG max clock frequency can be updated to 48MHz according to latest
tests.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/rng/stm32_rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rng/stm32_rng.c b/drivers/rng/stm32_rng.c
index 2b2067a5285..503dc545444 100644
--- a/drivers/rng/stm32_rng.c
+++ b/drivers/rng/stm32_rng.c
@@ -381,7 +381,7 @@ static const struct stm32_rng_data stm32mp13_rng_data = {
 
 static const struct stm32_rng_data stm32_rng_data = {
 	.has_cond_reset = false,
-	.max_clock_rate = 3000000,
+	.max_clock_rate = 48000000,
 	/* Not supported */
 	.htcr = 0,
 	.nscr = 0,

-- 
2.43.0

