Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC14FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2298460E;
	Tue, 28 Apr 2026 18:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="BnoUrQVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD458460E; Tue, 28 Apr 2026 18:11:08 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DE484255
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 18:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5ZAHdoLP0LYAU3bYtOyMp4t9qDJ5ZploifEBYQe9xUFxusWiiMoTA6zna5CVaCv+9vMG5e7Ye8rR7rPt3R5iKmdyxluFyJ1GlG+kFhOlys+OXXxaFX4qn6VdfVqdDzFAritBT/CAjYLhdGdM0AHWVsY64agwTnyt5wWI7KSIeD3rUtxUkjJo/avPpq7FObVIOiqa5cb8FZSDVhXMx+pdjc9K+6e9xghWVOoHqDmqXRPpnIaPZnaHyPRok5dPsb0WiYPzX7IYYDjzhfyjoQJUP+t5AHQf8QRf8xmTplEFz3k4xEuUubrLnJWYqO032znWpPoPZDZqREXLKKZqwVaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVJg1i3eOnQVshWrhTYdd8W4ru/RmH9DaD1cY8/lijg=;
 b=pfxPf/7rU3cB7kaOybaFhQ6h81CnDVfyEtq6NjErXv+0eZdb2jrjhaJaAuXZvmnJXHKs8dyo/8xRcF3Qc6hD5vJmLemyS4cI+9TVxbCzVMZys0c6/3P2obAH6FLOL6jfpWVfTbLaXYJIspdq4j3DhpMRCVRz/oSNU7sfpmgke77g5igYnS4PO78xKDRrUQjV1SOWxstT1h2Ze7R/pxS6e+2QAGyRQfKxrgAMKgyLs0HjJfYKzoO7ZP5N4GDTb8DeiB9UXgkW0ulp9o9fG5iUoNkRSIrfeXAN8Nl729/nZGmYZW6WcuPvovBV9i7JppOhuWsRweu796NvgK+mR1ORoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVJg1i3eOnQVshWrhTYdd8W4ru/RmH9DaD1cY8/lijg=;
 b=BnoUrQVyJemVBkHI8sFs8TsvGOfYrnmCf04bpEDSsv4p0S5oFBj/HH8f2odAqdobshiZGxjV7E7xlNyMPQay1HPk8JnNYptr1MOYKi/DmomaHDQxb1Hok5wPo6VkQLgEz3tK5EB5+yXQ4t+jtmIE1qjrOGpX6QrprwDoe0RhOwRem0A03r9VmLB3BwtUXF+Hr2JFgI2WKq0kvR4ktIOaEsJPO87FyzylYjEFB2UYE8gGKHUofagYAAo82LM5KX733po38rYv1R9ShylDREWzNzjCRY0Anjnn7oksBMelkdmDhuDnaF6A6PTpVj8gtsRtBCf4kdBxHJlXGXxEDnKB+g==
Received: from DU2PR04CA0332.eurprd04.prod.outlook.com (2603:10a6:10:2b4::20)
 by AS1PR10MB5261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 16:11:01 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::5d) by DU2PR04CA0332.outlook.office365.com
 (2603:10a6:10:2b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 16:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 28 Apr 2026 16:11:00 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 28 Apr
 2026 18:14:11 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 28 Apr
 2026 18:10:59 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 28 Apr 2026 18:10:59 +0200
Subject: [PATCH] reset: stm32: Fix compilation error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260428-fix_mp21_reset-v1-1-d1f2dff3f507@foss.st.com>
X-B4-Tracking: v=1; b=H4sIABLc8GkC/x2MQQqAIBAAvyJ7TrBNsvpKRFhutYdKNCKQ/p50H
 JiZBJECU4ROJAh0c+TzyFAWAubNHitJdpkBFdZKYyMXfsbdYzkGinTJSVeoEU3rrIEc+UDZ+If
 98L4fvMPXpGAAAAA=
X-Change-ID: 20260428-fix_mp21_reset-b43242279da7
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS1PR10MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1867b9-7ebb-4824-6ca7-08dea540bd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: QBayBEsFOpJwPsDpMIfuzYnVoLCr70YqZ+TeleiZutBkKNrz89z2npgrmgmNrYlMWRpkH12/hsIO8l0p9a5EqD5LKezEwA3x3HzJqVklmj39oqpslsoC8YDIPJ7KchEy8W7oQRjV5qyKjLDmELKkObVXkd2q66wUcaTc5wrrjT4mad/loWh2UcOf9wKnjb2bh8+FgsIjh2F04Y+lTWZI4uBX9zORRvruGZSTN0MlYuBkMAfcpTEpKXgyQZ0RkPre5huDK3s48ZcHIeR1si14zwW7xAISabtODJhXQB+bwRWbqN+00btjYDDKrKCKwATlyHwitz4uAc/OFrI84/qGsE0DY7eUl54F9Hp2FTy7OeGLKvVwKHQHkhtaM+ZaWxcOYuuTbWNGd6Y9yKOPtTGKIDNKPmAZAJ1hsbLQxJ8AeMUHv/akNlXIspT07Qm+g6+RGOgS2xV8jpr/U3xvqmxr+ELWqxzm2vQE7b3b2Dx4of7A97qfXwQEsWP/HojbdO4fPVxTyKj1TAwSpRqZ4uY2iwcvxA5hs4/Nrp09sQoUDPWjAKpipk9GTV0DjwHupd1cw7WEO12lapH6Yv0fsNKrxUfvqZ7szVJwmHxakaVC5WkPL6wUxCddJ0frObCJ2ZV5UYYq6fRXC1YKiTO7D5WKEHIimoe8bLsf6/k/xw3bHHywjOuwHbZHvKxrSDupw5ypTsTj3wMLNEN8D0UR4P3AkD4+xA7z9gY34ki1mNHI9Aax0zhiQC/VwYIDqfJM4oV84B3ezNYnPaPbGKA55N+iCA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9/F4QXvWvU+fIGMgweZuW/q3SVjmgSM9UiEDlO8PbwyZkAcxi6mUfMs1jgyR/BAJkwZvOHZtCETo5N0AOMPk61Z8tOU7yGoueKHEV5ozypQQZv/Xjy6cSDIbPRhF7p5c0ItsJJsNnKV2x1/xBfrfywMuUShZdb+jLPoQoLgRi9L8mik8UX5gd+NQu8wMxVaFiDnpGoyjgTpNHSf3rbHQcAdGURexIEL4pXMDeTa7sUlphvpBL/fR/5VNsNADj4fSN5jS5Zb85pfazC7yoJLNrQNF+d6Y5keb5LRqfhEmKgI2SYzZ4hBBYz3QpN66HKjKiRsEp4qwxmzAV/f/YMrcjFB+guAz5JfMx6KWazPpaYt7qIBO8mjaiAAFaWxI0hDtbTFCOIN9G4VStX6HF0ps2QtxswMl0BJoBt6lErwD9px4h7qfJ6cvyFDk1SWb/Jmx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:11:00.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1867b9-7ebb-4824-6ca7-08dea540bd6e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5261
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

The following compilation error occurs when environment variable
KBUILD_OUTPUT is not set :

drivers/reset/stm32/stm32-reset-mp21.c:8:10: fatal error: stm32-reset-core.h: No such file or directory
    8 | #include <stm32-reset-core.h>
      |          ^~~~~~~~~~~~~~~~~~~~

As stm32-reset-core.h is located in same directory than stm32-reset-mp21.c,
we should use #include "stm32-reset-core.h".

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/reset/stm32/stm32-reset-mp21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/stm32/stm32-reset-mp21.c b/drivers/reset/stm32/stm32-reset-mp21.c
index 7d169d7582f..0e92b0f5d5d 100644
--- a/drivers/reset/stm32/stm32-reset-mp21.c
+++ b/drivers/reset/stm32/stm32-reset-mp21.c
@@ -5,7 +5,7 @@
  */
 
 #include <dm.h>
-#include <stm32-reset-core.h>
+#include "stm32-reset-core.h"
 #include <stm32mp21_rcc.h>
 #include <dt-bindings/reset/st,stm32mp21-rcc.h>
 

---
base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
change-id: 20260428-fix_mp21_reset-b43242279da7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

