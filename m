Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D003606A33E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GUjzSdTp;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=A0kO/CzH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D4B54083D;
	Thu,  5 Nov 2026 16:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OnB9cFCLMvvx; Thu,  5 Nov 2026 16:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F2CF4083E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793897589;
	b=WCiAMbT8mdLBXctjEUd10EAyzyA1CLb73e4LFZTIjCCMLc8PBfEuzZGJbkpx4vRS2Ap3
	 UnugWBAipWZlyc/7mQ+DMwXb1ejrH/IJ3Ab92OG3tArwInS6bT6RfH4o44NRi/YAVc1OO
	 LpYVTuL1a/ZGpT99dAJnhFw1ClQTOyvBgllBsHx/SAYdaC+9AYAIctBbRriLAATbIVf5Q
	 +ULKvzUxyr1L+TxAnnqouOKl7j5VcwNsCJM7pedxjfyC7qVOn5RJI0912Um4s4yeO87Ng
	 irTp1/tT3YGE5YAOFsmrZrp7KAvWIR5gJcELjm7QwmEnEVgs5I4B+mgFt2LC48EggkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793897589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=Ynw60zlCVOK37ZhFf3tKCEtCw1JTzhr5ApG1Q4wqr5g=;
	b=Hj0SIIr5vqb3ztVHcRgSdJ1wEqCjWfeCsaLiuv2QISrMxyTUx9EYi1EY0nA/SKiw3o9b
	 VuYUC8eYfbA5/DwxXv4GwqORta2qePFfWaZThq/iTeq5LknEm8W+tHCA1cPqR6A8zduQN
	 4VQQRrw4zl6jCdKR/rSKC/7lLimg/zJwqCgovtTSRJcjZ4BuLi2J/ipSvdiVwesPppvJ6
	 bUoUlXbZNtR3aCBS9GhjgZgUp+CH1J2e+sGCCYRXnwqOOXcIl8+ubdMAZgfagiE3tRWgS
	 rMtGDAcBGxlwGupHxj25Jou34MAtIuIw9kJ0jPabaunGrvdrZZVizQqGP+2GQkkRKbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793897589;
	bh=Ynw60zlCVOK37ZhFf3tKCEtCw1JTzhr5ApG1Q4wqr5g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GUjzSdTpTr0HTUNkCQkeQx/Xt0r9MWGnjbkjAadVdpFFa2bDo3HtaSTF9b4Ju9Jrt
	 bG1EAAFJEWn05/RcwNZcEQ9MJGM/xa2krNLkEHIt/GXYQEB3aprdsfoiHx2iHFoqwW
	 M1Os+NfSjJwQ9uyXa52SP3Ru0ds46diaPXn158KuSeKN+rUMYoLzjJY9mz89zeBHi+
	 NoEHR9JC1rE0FbIM5aBi4UB0J0Gstze+dOChAXVTpUH3uUjfd9snQKc21ICTovCrNa
	 VHSYi/4h9QPdEPo7AiaxdK7odFdhGRg1R4xkrnL7lQsYCvvW8VN0XnWDbw/3Wn4y0P
	 fcWZcO4NHFQrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F2CF4083E;
	Thu,  5 Nov 2026 16:53:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 127C831F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03B5A400E6
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 97sjcYsH6EYG for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7256140072
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=antonio.borneo@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=A0kO/CzH
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7256140072
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ynw60zlCVOK37ZhFf3tKCEtCw1JTzhr5ApG1Q4wqr5g=;
 b=A0kO/CzHI2aS195TT6vm8Z7ilGRcJoi66mwD5F6N0anHW4MBRuJx+kH4aTZ78GE8PhCX0BqFi2cLeM7J+6oC7J1DJTXRFp0qf18LfJ9V3lODj0b4htjUqJZ156yyzT6efM0e1fnsmENWIUo6QB12ZbW9CmUaRB2yklusmDgwjrImUiXTRo/SZKCc3qwlULTPGTLeQAnyx3VirCDpxILQsYMUtbRAH43IRQBuNeZqUu2KUKYQyIAlcYDkfpR/zUxG4WLMMknGigvUpv7coXS6sjTYBUBgehSSLgMfAuXzNtQQeKh+UvXBGc+HqVNZmoj5qVdIinOuV8e2XX0dGXsa6w==
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by PAWPR10MB162427.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 16:53:01 +0000
Received: from MAD0EPF000008AB.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::67) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:53:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008AB.mail.protection.outlook.com (10.167.241.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:53:00 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:53:43 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:52:57 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH 3/3] ARM: dts: stm32: disable iwdg2 in stm32mp157c-ed1-u-boot
Date: Thu, 5 Nov 2026 17:52:53 +0100
Message-ID: <20261105165253.587809-3-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105165253.587809-1-antonio.borneo@foss.st.com>
References: <20261105165253.587809-1-antonio.borneo@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AB:EE_|PAWPR10MB162427:EE_
X-MS-Office365-Filtering-Correlation-Id: 09eb397c-b949-4dee-afae-08df3b5d4035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006|261026121527099003|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: wUw3NwqQQkMjVLB7DG47ttxQZrjV9qrAZIBBdIAJx7uaX9Hm6RUBDGudf7SI7A9naL7i8yXZ4jAYM97KIV+ADdx7JaxxhVWb4GGrm4T++2tENC/N3SebeYW5ghlxMtAoeE56OsXjc1J0aAPBK/5iev5Nkfj6tVUaOwQa8z5BwPIcGTLGb36BjazDmBWdWsJ/hm5abyPHpYYkcFMoKpIsGl0C3O13Nq7HYccm8rhAZI8X0yPi3nfolGNTYR1FyAaMQ69W3USK/cecWMPkxOzq0vXsHuw3y1zM0lHNq7yq5ex57kPDB5akhSv5uIkoSJzhYR/wUfQGuwR73LUuCYDRMwCc+bQA39uzJlr69tDO42prYrA7UMarDY5YRi1ZmEAV3opT003XYgfQH2gyNMXcrOdF5E2CjLYtO8B45FwTm7wmXvrPItNmgEW35k+Z+TYa9TEcZ780FPCIo38AijA2CNclLDrpOYot/LinqOzNN6hJ8wkBSh6tKHjOIVQinh9V4a5lTmkF1D1eA3wevVZtKe7Hb20+fwVbwjzRBhcms089d2RTvaaCMcnBjmW1cnTDozXv4+3Mzea5rpKvNvXaKP9he6L31/NTZhQUwFS/VbLbsg916yr/mGMnDqkRcDhIwlw83+hFGw0Dp+4lYQLkvl6WxmRQpwNYu4w8ae1pJUN4v8AqB7IhFqdZFcGwPA1U3SLxOKvad8Prw3zSsm1mjw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sGLTyDToXTWqNU2evyo9wCwI0+P06Rq+YcFwrLuk5NuukqGPMYhdvU3q4Q6+9VplYLvCqdaGQTBTDBvoqx13H4C4dZWVJq/vqosVIW3SqmkXEArI4eLYxDL8AoMUB0uv3o0MnYF9jI74rG4odP1Z0CKXpoSXCJ+H7ho15yxRKaAX9bnxAIxcESWJOzp/BAWTXb1gUyXW5GjA/h9ZF4Awe9WrPIo6XCmy3fcLbowmLnXhfMIEwbEvknbNMBaPOGTQ5x6MD/i/IH1L/ejlN6yv9UCvT5yE8uQ1sR3Lq++d1gArAIjtyJJIlPAkFmjsrVC7VN7DwsNdOwA6M5OvFqOVhKf2x3wEpEXRWBXaTRg8Ttb1T9hrlaSu02MbY+CJwU74cy+UhZ9eDcI+OpHEPnu8BKORJ7CmNyw0P+29VxLmpLiO05fgUSkcwUCyOb9zIdJQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:53:00.4017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09eb397c-b949-4dee-afae-08df3b5d4035
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AB.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB162427
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IWDG2 is not used by U-Boot, but its node is enabled in the device
tree inherited from the upstream Linux kernel.

Disable the node to prevent U-Boot from starting the watchdog when
	CONFIG_WATCHDOG_AUTOSTART=y
as in stm32mp15_basic_defconfig.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
index ef97a1184a9..cc986ccf50b 100644
--- a/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi
@@ -72,6 +72,10 @@
 	};
 };
 
+&iwdg2 {
+	status = "disabled";
+};
+
 &pmic {
 	bootph-all;
 };
-- 
2.34.1

