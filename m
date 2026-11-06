Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5A606D82D
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EJr/wOo+;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ZzKmM/l1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A084C4095F;
	Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MfQqfk1U4Gs0; Fri,  6 Nov 2026 11:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DA9F140954
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793963942;
	b=AV83+G2Ltqpj19dbDuF/yWSVzMdtK+/7q+9OYAgSjpMk+XzmwIBLYWxS8PmwyLnPuh+r
	 OmzNSwdfo14CG4FnMFgnbts/ivpJVFE1CCj4hBQ+opAHPZKlHVzEmiz9JFemCJSQTywJ9
	 MY36v9JhvVZOojZKqkuvgxJD1QKmOJF4xXhxAv2Qv0iJNqbzJXKIGkad7aHUTIoNqTsIV
	 gCyTGwYRxv6gFd0WGJ2p0TXckrEPj0JWqA2ymfIxT3IB7GNWqKSTSNJkx/EFZez1KgTzU
	 9lvUh2QqfCF6060ZSL1mTgrkrakHZvJEkD0jdl3BkmAo8+5ezb4rR2Mbzwx4Sn49sDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793963942;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ngJGhF0cwaAcIUEVyLAHJKdy/P6g4jDyJR2MeouT3dk=;
	b=lEQqVPcuhVXCivTh2qDwQ+iSF2kXMNe/7gmccFZ4+QwaGjjWusUhipHd+GMbn5MjMdjK
	 XX2FdKp9ZfxM3UI7C7poK4XVAGWR5HAghjLO7OZe1abvt+iYI3jEO1tKQSjXjNjyVRraJ
	 +IIhWPBVVKvCSKj1aR9odNC2/hItgv67YlCIKMjkiWYwoFJ9fu6gdyCMOzR/eJtq5lIhs
	 vtrsKY3MSTW3QwQvNxH9ZN5WCuezNx1Ch7m0EyS99lW7vlLyvGYijPO9lC+H0/u/PUReV
	 HPPJiiym1Iv3T6ToXadZwcb+KQlSKN9UXvZbFDva7+M52RVVZrJAl0lOm7s5ebeDSpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793963942;
	bh=ngJGhF0cwaAcIUEVyLAHJKdy/P6g4jDyJR2MeouT3dk=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EJr/wOo+K3yIlWNjeCCmsMfiufu6sCytKSMMcFGungg7xqXGhrVuM2jlb4bQkelqg
	 nq2Vq2cPQs1v/py7krqjLQLnS7WVB1075uEtEuJAjav3J5bvVNP0XDarmevjK8T4kJ
	 CHJQcgHJ6eu2TxaqCafC8onTlWV9I8ARIQHAAE6gXoTyvIIL1jLZeVJDckeWrRsxON
	 q199P/UsnEJds5ULxbBi22T69PTLec8ximxmwRaTs2f5Ep4RveXm30AeWz37MsdR4x
	 NSz28ETdNF8Uea3hXyv3vMmH9xAdVLn48yQ3xYONtRyqxD4JkzBmhz8JobQajWtQmW
	 qvqYc2dJ6IDGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA9F140954;
	Fri,  6 Nov 2026 11:19:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 785BA362
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DE76607CF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncfZZnXgOrUj for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 11:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C42B160640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ZzKmM/l1
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C42B160640
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 11:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngJGhF0cwaAcIUEVyLAHJKdy/P6g4jDyJR2MeouT3dk=;
 b=ZzKmM/l1Tsnh1WU1Txg9+mZApdxKXIShbH625gxyJoUN/QbDGa0fvAdGftIwJD4/0jrfxULXgmDCC72XKQLt+g0/iO9nMAdjibBdzcGVI5taXMnxY7aeZO575O5RolY/lqG0tkrAxh+9MQvHWs9KkNB/d72rsO66xBP5TWjej3cvRRQorhaO+dJTib4j+ByaU1XpZ4yZWer/6howgEHr0VRkR2hw1cLUQtdUdcEaeWDtoAS7zcNl0qg8OpbC22bZtQZdfsExCdmEcQkzCRQsES5XCoR2YeP9Vxn+wzjkfuGWjencdkoqfxgB7VELWSSYg80Z7D05L7L+bmsfA5BMDg==
Received: from PAZP264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::17)
 by AM0PR10MB071704.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:80a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 11:18:52 +0000
Received: from ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
 (2603:10a6:102:1ef:cafe::96) by PAZP264CA0123.outlook.office365.com
 (2603:10a6:102:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 11:18:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6BC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:18:52 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:19:22 +0100
Received: from localhost (10.252.31.114) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 12:18:51 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/5] STM32: gpio/pinctrl driver update
Date: Fri, 6 Nov 2026 12:18:48 +0100
Message-ID: <20261106-upstream_pinctrl_update-v1-0-4f3d4f6e97fc@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJi37WoC/yXMQQrCMBBA0auUWRtISpsWryJS0ulURzSGmUSE0
 rsbdfkW/2+gJEwKx2YDoRcrP2OFOzSA1xAvZHiphta23jnbm5I0C4XHlDhilvtU0hIyGT+MXbA
 rjugHqHUSWvn9O5/Of2uZb4T5u4N9/wCVqbQ+ewAAAA==
X-Change-ID: 20261105-upstream_pinctrl_update-6784a0fc8c67
To: <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Antonio Borneo <antonio.borneo@foss.st.com>, "Fabien
 Dessenne" <fabien.dessenne@foss.st.com>, Mehmet Fide
 <mehmet.fide@screeningeagle.com>, Vincent Jardin <vjardin@free.fr>, "Pranav
 Sanwal" <pranav.sanwal@amd.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Valentin Caron <valentin.caron@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BC:EE_|AM0PR10MB071704:EE_
X-MS-Office365-Filtering-Correlation-Id: 2258a69b-dded-467a-de43-08df3bf7bd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021123027099003|261021121427099003|261009221727099003|261009223027099003|261009220027099003|261009223327099003|261009221227099003|261102123227099003|10067099003|18002099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: 46WSjl5Nwv/7ri/aLsoE1dKuA6blw/cwbuiImsDdZsqPqxckPlfONclREMxk0oc2HCiiNl7iEEgbHLYftZfkU3DbCZE4A9DTAPAk0OBxjYY+Yh0HBfR/BOW6maA9OqgWGPYNBCiVdTePj+UF8auS+HkSLN/yxmOqj6Lmp8+CS+R5GOqjdm9eKhvlpKwVGfeHnirTSOvOuIAMH5eSqY/zPIRxR71IN+164neSWnjQzu9k+8Yp2wye5RP6TLS1Ty0DZIXvOep3ExF1dWYO1HD75Zys03t+NKXEszGZc928M370Tu9xs+c3RfFMSzyNOUDssSmSE1hJDjQ809StNvooJ036pmJOgr7mVh3U6JJ2lyca8PZ9SjtM2L3VEjvRdUz2k25ZVkeVIe8PdW4DqP1tKSOgaqN1Rb8Dyb0bnAKOl6WkHsAq23V0OfnwTiX12VgqEMJr/i7tjOYx0YyYPNOFSWNiGNQrnYoQzPfk8c8Ck+83I1oEsTuc2Pw4PGRcMbgDHIL5QksDb3J0TaPr/lLLQ0m+dOmktB8SbRelsaCpp9e9cGd6pNBiBdB6I6NBifriO8C3SNby4waPlhEoIBGoUpbN1jcqGJVMsHJYpiNIR+59fOpqZMu+eGekKszrTbGhBbDXVnvH2bqCQfL02o1enTIdPdGASvvKmBpU8mv6oH8b3rWT0Vg6iPDMuOqhLDrscBOvdE0OwO8muEnsPF5njvkL9kjuIrbN7Q8mOEaNrjBVhGxd6yjarIcAY9f1FYC7YYD0HIFBW6ZM+BMEvNpkyQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221227099003)(261102123227099003)(10067099003)(18002099003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tPaLTqhYgH14R35S9Zo/iiXXg7NULQkLaQzI+dAvpa4YTD38w+5xJ71nGzUH2YYwHzyIWZQHDafVX9KYK5bdY2c6wPXUrri4+TWcPGQsoj3xeFDN6dkldgnILFVLlFHGwfPL1mczBLmMxkZXKG6ajJ2PD4KFPX9DXs7knBIMBcJKckr+MqVjpfk7fFPZvirACEIEU4ET6P4P+TGxduEe9kPK563GbI/rCG+r9U9MHjkM0/xX4ZtVTVIq57GBhp7mYnNXDjVOz59Gg0yAazrmUCO/eFlWckXoFqg0k+qs8+9ziC17rrx52+X8xXf6P4LGA3Ck8/+qPiWSURw1EQDjC0w36gMGLMqip6MD4Yp5CqVZkGNliFanTkkhZk1UMIOZtjWnfYWctiSkvcR8KwLBvKxnSwyRkgEcklrkC4C2h4gJePx+lhrcERNaryNsNVZx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:18:52.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2258a69b-dded-467a-de43-08df3bf7bd25
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6BC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB071704
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

This series updates STM32 GPIO and pinctrl drivers:
  - add pinctrl I/O synchronisation parameters support.
  - add protected GPIO pin support and sandbox test.
  - add GPIO RIF semaphore handling.
  - release GPIO RIF semaphore before OS boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Antonio Borneo (3):
      pinctrl: stm32: Support I/O synchronization parameters
      gpio: stm32_gpio: support RIF semaphore handling
      gpio: stm32_gpio: release RIF semaphores before OS boot

Fabien Dessenne (2):
      gpio: stm32_gpio: flag secured pin as protected
      dm: gpio: Add GPIOF_PROTECTED flag test

 arch/sandbox/include/asm/gpio.h |   3 +-
 drivers/gpio/gpio-uclass.c      |   1 +
 drivers/gpio/sandbox.c          |  16 +++--
 drivers/gpio/stm32_gpio.c       | 123 ++++++++++++++++++++++++++++++++++++-
 drivers/gpio/stm32_gpio_priv.h  |  65 ++++++++++++++++++--
 drivers/pinctrl/pinctrl_stm32.c | 131 +++++++++++++++++++++++++++++++++++-----
 include/asm-generic/gpio.h      |   1 +
 test/dm/gpio.c                  |   5 ++
 8 files changed, 319 insertions(+), 26 deletions(-)
---
base-commit: e7f12f049ce26276ba4bb2de507a34eb672576ac
change-id: 20261105-upstream_pinctrl_update-6784a0fc8c67

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

