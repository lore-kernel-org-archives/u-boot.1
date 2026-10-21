Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE3606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i+hxrAvR;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=HYAnc8qc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3787140568;
	Wed, 21 Oct 2026 08:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLlbwb3z2PE3; Wed, 21 Oct 2026 08:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6937E40575
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570102;
	b=sRXvRnjPNHenBAw+6Pl4XyxCa9P7COnnYN0X2bHMv2N6JxaReqm2JMV4joMq3K4ijHNr
	 Ty6pR2hS9ucx8/yNmQmzSf8fflhF7ceen2CExAnjexnqsC2xHKdniz6GTtc3+bC/bL0z7
	 oc3brYq0OzMlsRJFMx3BEAwZED0LO5j2Pi8GymriCj4eta1560GOwJkTer2Uk4MmBuKE0
	 +/bZTdvPT3CGowtRkcAyscEcI6NEHS1+xied4tbHsfgPpFtHBZMIn6U0DihQAxWoi3Dxz
	 wLF3mHwK8cik/FHtPbQC3E53xrv6ctkWA5bmkejGC94B0VAOzHXMuh3nJJCV2uKMu2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570102;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g0b2EnXss3CfvzI2iHDz/lJO1WbiPNzSCQYVQuD5W9Y=;
	b=PmKKysF5E2JmAJSCBQlMigzZobKb1bRqRsyRHbpK3WCZV2sidvs0xb3e4hYDDpHrE3nH
	 UEWuUZDQppYnO46Psd8kKKPpvgiyQzas6ft3cUuec3EynuJKcynlGorlZP0ifxBfi4LeC
	 Cqczpnaiq587YX/mr2QlzURoDYknEjedPnqpfTFU7rDJ1zD4h92Do96DCExCBQZ1ui+U3
	 VFiV6l0VsCJtpsvnTJ6RFf6lSLWS+WfrXECrhwg//bdnC4XpB7lat7D9Yh5VS/UjfaXef
	 FKTQ96B7eIGZmgJp18vqJqAEuV2iigkHP0ywRAwlO3U1ZEoUo0/o5X4UqDnzMAalT2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=HYAnc8qc;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570102;
	bh=g0b2EnXss3CfvzI2iHDz/lJO1WbiPNzSCQYVQuD5W9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i+hxrAvRVc/baMNGYALG6aRn+DXVItCgUWvoC2sppwja1T/zKx+UNGSKHLRq1Lc0p
	 o23rY3vu1JDR6WISL61spXIWl14aDoJsGlIKhE/j85etBjybQWhh4eRA2FU5BMtXuK
	 TY3WtRvcBfNX4XcqmBQq0pc0s49Ny/wL5JSiv000YGA0L1SPHT5pZl0T2hdLncOgpe
	 N/KzFj+teWTHM/UN1jaVk+a3P8qlVTTwEt96zMNjVIkZlw1MukY9XeGVJQdGzcw99j
	 OXapm3BsTy0QkRFJH6Mz/zqTCtEHBLQzQHmxhFTdl+XE8PyWNY/E3zqroTM/Ql2MId
	 z+shnCIOD+0Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6937E40575;
	Wed, 21 Oct 2026 08:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1452769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2EF240575
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s62A26dTTOLP for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C95FC40568
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=YE8BTpEZ7C+sg1G9NVltB4IjKD74jsY5SAfmOIKNpRPEvDSLLJOAQQ5qz+Jq7BZDroqa
 jEUzs/qS8IKjr61QQLNGb/3NSSEhBOAnBneRQ5vaaNtYprwCaaXlfWhEJYJQKdzrsRcHI
 N+JAJymFIQDumZbSC10vhNGzRpbpMkMxUMCT7JFtKSJ3nDpcZJ0lwoLJ3L1wy46Yw9tIA
 g06BoypvH0IZkMJX4+0kGh+mJKm+VODYvUYhd0bbVImH69ZwszZrDymWtPyR/Yb2vnUM2
 cW30ceR+2oke7ugJhafHSUzylfYO642opXyvpe/4+m6G3IxrrZ2wEDw2+DQfRIBpMoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=g0b2EnXss3CfvzI2iHDz/lJO1WbiPNzSCQYVQuD5W9Y=;
 b=aDVo0WZlpL1hV+rBa1b5PrhnYCYVptGT2ZrSc1z72D/w0Uqpr5jg5JwmOEMiMvhFboW+
 JbcdHG1/3nMyCCNqKMVllzQVO7Nz4XTNTXwfs3TQCCqIiNgdCiMB3a/a1pkR3NWZ6MVHt
 4XXwJyeevvpjmJbYes7MtGcsEKgTfEd/6IbHMXWoBpOrJ5Euscnj1vEi24s8XNWEEkkBa
 GqBrzBuOKOpDuq9dUXQ+ExkllRGNzvWicDPFWniyIypYujpwDJc/bn9OODQDpE1FILXWZ
 5v2if4XCg+lIAYVhMjws4mAUyMD8/6D/QvuG218XnD9wjDq/aPnJsCDmBLubOCppjfw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=HYAnc8qc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=HYAnc8qc
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C95FC40568
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0Ddjn7kKX0jrfP2/LKqwKXw8JS78w9FDVW4+i3pCV8pH5dt5+Uo0B/l9/U4JmbllAj9XSXyXoxsuhHebZzw57ZhzdOPvBaKUXkovBAUsOVKxglMwSg2cbILJbjeNgpDH9whEzlK0Ec9oNQQd+y4ap7nH4mquesJRlYFYgtlnWfTd+aH7uYOcRRDRC1dfgLq3F8UF9MV/8uvkb43B921PaRrNOeWJe3tH4GP8Vcbk9fNejXIDjOW94lNOhEq76XploxnOdOV6q1RBoSno9ScYHyrHmcXBouOxdJtCR2+GH3MEf91PqLMYesAVq+KW4K1Q97W73XuJJRe6UchqIG1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0b2EnXss3CfvzI2iHDz/lJO1WbiPNzSCQYVQuD5W9Y=;
 b=S3HATBqAlkQ4DwBtYk1hkQXVkzQMzezQPAtn8atOHjsH1Ljy6v+KbcspfOnOYil0J3lZbpuQsA15GkRcGv1/gYbV2RzDJ/BpXUd0Dqx+adXfOF1j8lyRXC9kwS3pHKeV1ywsuIM7J9PO2/Lw97y4uR8BjqVWwQYHcUZlf9VRdQ8ePksn2U4LyXDRqJpZepy1BSMw3TUgFDjjDafN69VcG9PW3LpdvBJMQiLCcJVoSuSjzDg46wZhoB2/Xi5HFIuTb1XAhTR/oCaK7jfYy+qrGfeRC3N+o+xQX/zbsUfOwEBkZJzofAse9fOiXh9a6dcu6oMDAEgczsszjdUlL2yvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0b2EnXss3CfvzI2iHDz/lJO1WbiPNzSCQYVQuD5W9Y=;
 b=HYAnc8qc5hpHspZUfzxRu32EFpQ320ULoDLhFdMvu0ehwRIOqNoqAr1oHVhnnslHJU9/FBZngBqk2FOO9R1gAGXeDd1YEnuCgsZt4jMdweFsFYk7Q8OCLT/o1cAFXHg/HUuwZHIpk8/574bMn37FjpKn4AEHX9tibsm8PHpyzTrh/g64r4/iBmIZZVLvckJXnXMG8e/Qj+jiOYRFkF2l5GggPgOih7lFZR09XEDVzn85jQ+lx2Yd80mXgxL/w2RO24v+CLrhJ5zuIPKTFA324cLXqzVMcgv9idcgUWUmJmoZ7pFNAE8KQSLv6THvkSWRQZMBvkRrItxjqdRht++YuA==
Received: from AS4P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::15)
 by GVUPR07MB11832.eurprd07.prod.outlook.com (2603:10a6:150:32e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from AMS0EPF00000569.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::51) by AS4P192CA0021.outlook.office365.com
 (2603:10a6:20b:5e1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF00000569.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 496D8200D3;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:12 +0300
Subject: [PATCH 4/7] watchdog: designware_wdt: add get_timeout operation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-4-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=2048;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=rozVTfW8BXM4rasI/Ja5pIJQXW8KQNn2XXEmEUDGYFY=;
 b=Q+nr2BWQcXcJe9JtcydVmxZW2wx7qbj74QnC/EDqc1W1NsE34VCcJZtbpP3qTmbD+g4AeVF5U
 hS1FmTCI5qqD4PrVOed9GVUur4RSp74f+A0Jy5zoOCP7nlPWbh72hH6
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000569:EE_|GVUPR07MB11832:EE_
X-MS-Office365-Filtering-Correlation-Id: 006dd5f3-f3bb-4a0c-7f19-08df2f4a72a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 94No9ZqY2ekm8WNWk5R9MYGiFrbT0sEplE7eIBx67O2AWvnz434IcA4ipL4q02OLI1Yx3jQuQqJaXZrs2hdvMLcr1bGVmpupU9quyYhiWeZKIpmXPYsjK27w6DKIJwMQ8Vh+aIxY7CvtBWU8Pj58Ss6L1443MJx6w2eWicW+Y6EZeEQtBwdZ0Yfxu3czv9Y3vbOaLvqbXs6LYE2shDdgrgapT2U+VEGsypnRhLPihUcNqtnJO9fOl50HWYcpT8z5jdcV8LnTzEwOzUA1H7vpFhZIAh5pURFidVgbhd5w3993nPcM2/+Bg/howER4cRB+2EVhCPvSLkR1rS4aZ2V2Wtwd/2rvwaQYxApwvleiIdo+eDx2nkR9PQDlv7aSSR5tgIYpeRyluBxlUzrd6Q/UA3GFEwz33roWpnQs19u8y82LI94/71A49SVFctDyBGgdhATM9WnSCixb7D/3dl0rCCt3PVY9dmiN7qAf2o8Dyns41oWAH9bqGB6ARWzIMNZ3vb0Oc4oJW8ek7trCXwZNmteKtRu3Ixg7rCKtV5ZbbUT/62Cy5UngUrbyw684gm24cf5GCbPKaprCkNW/YgZcIMvupGuiE+SjnC5aGf8jcpnfQJQvNv06tN08n200RzHtl+zb6sgjwK2mxAYxhOgpDWuNG9x9fvtn4h0Rf06oZ1ESI5KnLvypu/Jj+DdQhLPYBQNaz4NcQxDdN2PEdjmJYQ==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /zWVnWQejey6/hKJLtxs/aqchlqYpArWVTIwxDmylnpN0Rw7Ch8Hl0dFhAN184QfYXRII0z+opHhcfxhmMtet6yRLKewlEPBPet8SsX9Vft9/EOHZlegg9TlQ8RUzos9HpHQCfcMA2Ni+l2KBf6rfxmIijzzdZpGuuZjMabA8ecgrotUKMjNCjGN7SvnsibGaCCe0Bi/5jMbEnaJKLLmaIv/Dgh+Z97J0D6/FvcAJoBVebmCp09Tx6PG3XeyFCNq7oyJbH1dC4RxvX2/cqdAvo4OnnskcX9mGi7VbZ22oGJXw0XppuEvkpEGtcakjXZiPRNwKyadU7KaVskuE2Yjq1/GLLdwPxIx9G0949BfHZfVxok9TFc+HMF02ZD32L3pp9WxjW7z/X8IDJVsVv/29e0QAi2uZ3reDuJQQUWaY7OK6D8ZqcBG+SEtkd/vV/h6
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.6620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006dd5f3-f3bb-4a0c-7f19-08df2f4a72a7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000569.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11832
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the get_timeout operation for the designware watchdog driver.

Add a define for the timeout shift used by both the getter and the setter
instead of the hardcoded 16.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/designware_wdt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/designware_wdt.c b/drivers/watchdog/designware_wdt.c
index 91228de5e8e..4ced4adb218 100644
--- a/drivers/watchdog/designware_wdt.c
+++ b/drivers/watchdog/designware_wdt.c
@@ -18,6 +18,8 @@
 #define DW_WDT_CR_RMOD_OFFSET	0x01
 #define DW_WDT_CRR_RESTART_VAL	0x76
 
+#define DW_WDT_TIMEOUT_SHIFT	16
+
 struct designware_wdt_priv {
 	void __iomem	*base;
 	unsigned int	clk_khz;
@@ -34,7 +36,7 @@ static int designware_wdt_settimeout(void __iomem *base, unsigned int clk_khz,
 	signed int i;
 
 	/* calculate the timeout range value */
-	i = fls(timeout * clk_khz - 1) - 16;
+	i = fls(timeout * clk_khz - 1) - DW_WDT_TIMEOUT_SHIFT;
 	i = clamp(i, 0, 15);
 
 	writel(i | (i << 4), base + DW_WDT_TORR);
@@ -90,6 +92,22 @@ static int designware_wdt_stop(struct udevice *dev)
 	return 0;
 }
 
+static int designware_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	struct designware_wdt_priv *priv = dev_get_priv(dev);
+	u32 top;
+
+	if (!designware_wdt_is_enabled(priv->base))
+		return -ENODATA;
+	if (!priv->clk_khz)
+		return -EINVAL;
+
+	top = readl(priv->base + DW_WDT_TORR) & 0xF;
+	*timeout_ms = (1ULL << (DW_WDT_TIMEOUT_SHIFT + top)) / priv->clk_khz;
+
+	return 0;
+}
+
 static int designware_wdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct designware_wdt_priv *priv = dev_get_priv(dev);
@@ -151,6 +169,7 @@ static const struct wdt_ops designware_wdt_ops = {
 	.start = designware_wdt_start,
 	.reset = designware_wdt_reset,
 	.stop = designware_wdt_stop,
+	.get_timeout = designware_wdt_get_timeout,
 };
 
 static const struct udevice_id designware_wdt_ids[] = {

-- 
2.39.2

