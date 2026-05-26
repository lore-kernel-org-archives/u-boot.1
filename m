Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322CACD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A510B83FF5;
	Tue, 26 May 2026 10:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=esd.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=esd.eu header.i=@esd.eu header.b="fbWi8kU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F278F841D7; Tue, 26 May 2026 08:00:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E978039B
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=esd.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.nehrkorn@esd.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVvmJQR0ZmaTq2BYf5BOS8QbO+SPPOfGCSHOr2HXM8DSAePGZF0pSV+C/423LSt2fWFKZwSSG8ybIJuapNWw+t/zJ0iNtIxCQt5GSCD5DsHoW2NWHTIvQgKBYX0prMoDQm5G7GaNAoHeEdX+m7tUCXCn1XQ9NYFMTGu7oxmjREmQhuuz8pFz8sCeC/XmYrV1rgxeWU4yvg+hwTep2Gx+dRzetD5m/BSZL1Zt0IIh7wssff+2LRehq8wQ+WS7BDmW+qIXXxBtDGfiy2W0sPq3wRi14ZkAzGC9Ywae3H1FO55xdYFxArCBElPbXLPQTrs7DDXqh94azsdlnrH8BE3jxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BFkDrI6n2DRu90z+0HffiIvM8lO/66CIiVdI5X20JI=;
 b=Wf8QEa7DFbe6xOK0QpCTFTs0ll789LFJupMwNBZod9rWGeNu8gWWSw4+ACQ/NfLTQg6eTRM8g/sDif7K0hBEbSNQykUy7McxqBNjxZETbPsoYScV3dDV5lrBVvLsBMMxqhn/ZShP98cA2f15VrbAb98Nz7hQEkmFkkJPoY0JQoH0nyILDXz/nXt9rxB4dOlIrBZ4i0oU9m0b0Le1NcdW1iy5wCN5wRtjRxc2klS5JQc1zTb16qMQfyGdmsvKgdPex3hfNnglzcQootrBmaKDluKQBOniGMdjXswgugSvQtpW2dOEFTdzN/+timGGOq0J99Wg/nOGdtgJxGc0cCsMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 80.151.164.27) smtp.rcpttodomain=denx.de smtp.mailfrom=esd.eu; dmarc=fail
 (p=reject sp=reject pct=100) action=oreject header.from=esd.eu; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=esd.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BFkDrI6n2DRu90z+0HffiIvM8lO/66CIiVdI5X20JI=;
 b=fbWi8kU96s8TdPvja9Y+BXAdjAdih+SHwPsVVmLUl/F1IVSh/dT7sME8lV8QxBa6RwPjJE9vQuqEP5RrM3EmeBEjXnXAVm4Aw9rai4BCvsS0xzljzmgFasuw9VTQ+HwCGETiSWEBLxkC/+sT9A2/71JcM3C8eo7DOMPvK/YmuxSNSOS75ZS7iXy+6brfznP0pJOwbcAHSyfqjHDrqDKbbAm3JE7HNhc1dVgNR0gLOFnVDrTNpWIRLeIXgcvddwL5HPuqVu3rribf7uueOsDZ2TsYD08o2oLSdwq2oe/gbXC7owdA+OYyINfBlmav5ShRHjPfSfbhIiqYYd8TQsjGug==
Received: from AS9PR04CA0034.eurprd04.prod.outlook.com (2603:10a6:20b:46a::16)
 by PR3PR03MB6570.eurprd03.prod.outlook.com (2603:10a6:102:7e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:00:43 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a:cafe::84) by AS9PR04CA0034.outlook.office365.com
 (2603:10a6:20b:46a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 06:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 80.151.164.27)
 smtp.mailfrom=esd.eu; dkim=none (message not signed) header.d=none; dmarc=fail
 action=oreject header.from=esd.eu;
Received-SPF: Fail (protection.outlook.com: domain of esd.eu does not
 designate 80.151.164.27 as permitted sender) receiver=protection.outlook.com; 
 client-ip=80.151.164.27; helo=esd-s7.esd;
Received: from esd-s7.esd (80.151.164.27) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server id 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 06:00:42
 +0000
Received: from debby.esd (jenkins.esd.local [10.0.0.190])
 by esd-s7.esd (Postfix) with ESMTP id D1FDB7C16C8;
 Tue, 26 May 2026 08:00:41 +0200 (CEST)
From: daniel.nehrkorn@esd.eu
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, marex@denx.de, hs@denx.de,
 Daniel Nehrkorn <daniel.nehrkorn@esd.eu>
Subject: [PATCH 1/1] Revert: "cmd: eeprom: Do not rewrite EEPROM I2C bus with
 DM I2C enabled"
Date: Tue, 26 May 2026 08:00:41 +0200
Message-ID: <20260526060041.3898125-1-daniel.nehrkorn@esd.eu>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|PR3PR03MB6570:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 47fab175-434d-415c-cd61-08debaec1e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|19092799006|82310400026|6133799003|17002099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: faYsns2/W2Q0SsK0mAHpfs0GrdZAx6YR/Xl0w4JIXBiiXPZAEZxxE5AGhmhKAX9fcV8oxbJfC5XB7PKO4O1CbVbplIGC+1I4sW02Ml28JbF8sarhaOjPDpDFvx7x6j17f7kn3VOxTQQppUCri64CIZ6Fk4anYN82FvfjC2GM0YKyZ3QCFFfJXeXJOIrF7otWBTAJLwi1zpzbL3kfRnXvg3Uc9ktmBdQv1FGCOHyxmGBcU9lcaF83jCl/g8784lH0hlvwuYzVMB5eu8Fja/tof3QbPc2rj/CQ4DJWl619Xbw+vLOPzmSxNFlwXRtwQCxB3JrnrInOLvXQfT/HZJKa+2KXSzw8EyMJAX5MDoRAFj38qWcfaHz2OF1665iKwjLoFTYmCMsuzZgXET2QFbfJ1zYiV3Vpp6+mmZd2f32quKFKzoT711HPKym1ueU9m642N2xumj5i8dnOTQJkfdwBRRNn57uzjX2W02Xt42vGjktU4uxW17Fnw5C2EggYKObJj5BOZbT6hjBB+C8TWnczwmcYThxWafNBRRKqcMUw4BpbRPPYHyH14oZSj3gbc3zDpeESzC0cYIHYuosy8Ezb0NHtonpUiWaBYVZI4bQdjGHTQnvZFM4qzFBEnwuVo7Y0RPUkgQiYDpstsrdzHqqbXGnNNHMgU4aIWmwN5MUlO2jw0Q3KyRd5XjOjYEZzoIxfX6YImUEQvHb5xBZOis3+KXHLj+tJxtyoIRvAloL8N3c=
X-Forefront-Antispam-Report: CIP:80.151.164.27; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:esd-s7.esd; PTR:p5097a41b.dip0.t-ipconnect.de; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(19092799006)(82310400026)(6133799003)(17002099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CaSMY+s6euuA4i3kJvSKGDxV7XL60HaB0oFnAB6jG+7Vmhiezs5+ZddSMeVkIkeZjJHM8jjKuyy2qjtonjP+J2I+YSyXsq0mlRzWOeM08EgjxeBrs9AlE3qBsoE55QUhYYULYr6Xkhha8HgZPrD80cPfbOrZSrTOCB85+Vho3GWyXs9yNuxhZH9DAGEMgU12jWYi9QeFofkD41xziUYJlMe50DgYGFtgzqr8jRjn3pN6mOKGsFWo0VaqTDa/oUiFPEXXaKPyJiwdZ3EXGRrDVLiZ9OTBmxDqYcVVMHA8xjKf5cSnkHVhtEVYZbUJjKy1IOh9Sxw3OBg/n1RskmwR7s8/0kWS/I0L+0QFVJZJ7qucf8MlT3E3rEQIeXPjxmVrpubMebIvMOW7cO6+gDCWjQnjgKUZawgTuRxQPVxZ07RWNwTHMBrfr4E6cFq5qhtF
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:00:42.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fab175-434d-415c-cd61-08debaec1e9e
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b; Ip=[80.151.164.27];
 Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6570
X-Mailman-Approved-At: Tue, 26 May 2026 10:34:48 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Daniel Nehrkorn <daniel.nehrkorn@esd.eu>

We need the EEPROM bus configuration, if we have the env located in EEPROM.
Since there is no eeprom_execute_command() anymore, we have to configure
it implicitly.

This reverts commit e3c2042ae7d188e00e48d984e373a2de505d8b77.

Signed-off-by: Daniel Nehrkorn <daniel.nehrkorn@esd.eu>
---
 cmd/eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index cf89cfce3e4..ac7ed6f58bd 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -151,7 +151,7 @@ static int eeprom_rw(unsigned dev_addr, unsigned offset, uchar *buffer,
 	int rcode = 0;
 	uchar addr[3];
 
-#if !CONFIG_IS_ENABLED(DM_I2C) && defined(CONFIG_SYS_I2C_EEPROM_BUS)
+#if defined(CONFIG_SYS_I2C_EEPROM_BUS)
 	eeprom_init(CONFIG_SYS_I2C_EEPROM_BUS);
 #endif
 
-- 
2.52.0

