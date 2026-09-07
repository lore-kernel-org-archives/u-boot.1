Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4742BC79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 15:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE1B9606E3;
	Mon,  7 Sep 2026 15:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QZfNSos4gBk; Mon,  7 Sep 2026 15:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 183766068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788795432;
	b=LYmAe1Ibq0cycnsU8FY6Fefr1UY12IaJCJlkcLbsvPF2c2u8vUW8f8AN21SvsG5RhEF6
	 bHlfNATmf0EsUTGOH7dMSXqwpngxXln7PLtFEo3FDfD0wpOjn/SjDUslI8BeDf0RLS/52
	 qCmJVQwjUdupNAKG9D/XTN8xRz3rSZnV7Qm4rWe6ysMVg0nLvxaoKqGNpWv1mqFCTbqa0
	 sMpk7UCfquWwxNNu1uO4ysVB62il/edU5H9UEXWgpeeYAmjig1XL/oA/Hix2LCvUsTTbr
	 jgPmyTpa2QY4MAIy8B/yAW4AemTODBjTXe+8BZCqi/ff/C4VJBwiFJOv+6Yp1WFhz1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788795432;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VbIsFQYbXByMkand0FcGpTXgQYsLOvYOqhUPVGkA1cM=;
	b=caJ788dJ1ilDf9MWM1+LLvUDYYgCSbSA6LtIt54T4mGfdjyLACse8ODLkYGKAJCnCD+X
	 iYAJBaDH8dMRMksoPFC8xgkTwb0joQSFw6XUOTV0KVc39Ri3l/Dca6RZ6wFMetCBcJbfG
	 rApWAK3xZeoN+lCk9be8UjEv5y8ImAryXQUexFHzVImr/zVZgQFUuTQ2nzIiIX1CEdupG
	 KJyXn28g+EnjzFjPKA6qfbS2DHWkyCGDvtASr49rSc8q9SApRR2FL7iTBrdxOfwMLtde7
	 TdfUIma6nAu2BJotAeu3kwDI7ETU8PflAeeUZAS0xNBXkizQ2WDDL8jeWyJr+NY1p1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788795432;
	bh=VbIsFQYbXByMkand0FcGpTXgQYsLOvYOqhUPVGkA1cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psJ9kuqSXultU6v0AudTzexT1xHpRhTtlMytWa0e5nR/SAvF4e02fGIjxOjPHg/mU
	 /kGJ7ZLhKymw0k9xyjxFQyIs0tLsMO09jcisEDY8SHIkoUGoxNiHTV59AMrDrozotL
	 ZYnDn2cKL6MF8SNQVBHmsANB/Ud1HlZ4AGe1EzZAX++o6V40hT69cXlCB8iV+i1J2O
	 MioZ1ZgQpCWVxY1/jbEc5G4hkokKMCCax+yM1yh4JdU3NM0GlJcd7cHmsTXZG8NWIP
	 Wd4pvub6pWAP1/gTK0rk5QrxuVr0dNndR+WLIMqV8zE/qE/44wBSVbW/BHeLrQbaqp
	 nXAsmPHPbTATQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 183766068B;
	Mon,  7 Sep 2026 15:37:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D7A649D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EA3580B9D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e4N0COQWwmhb for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 15:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A5EDC808C8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788795429;
 b=ckCn61ggguGfRuxU7ETH5SdoViQpnDtWp1Is/uItQo3kc8ZWSB36EsqsRKl/+ReilvxG
 dFtE6CxkK5xdTrR+lAc84qe4TXrD8qcVeSJIuksz3kQe4x7zt01YsSikD+3kqOCsBzmry
 ZsKyQKMofoDgYcLFiKz1AgNRUpmi1PBR1r4whX0Jj+Q2RsRTlI/bfQVaeWr1fkcARW57S
 u1UBrscrC6CysRuloxR1cABzcVnEiWAOZFfVi2x6UMk7pOliPlB2e78YATTlZ9EYHBLUp
 12Bl1MZVXc0JpHFPRi85C1LiwfrF7648IwZfeBYZNt4qw+fbgK0uwLmdjDBKvX0KF/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788795429;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VbIsFQYbXByMkand0FcGpTXgQYsLOvYOqhUPVGkA1cM=;
 b=Z5FIgx4LMtX3U6Ou7sGaw3XI66XkL3m0dT/cILYiPEPmWD/yac+uVR++K2pqF1Auj6k3
 LERA2nQETA95IUJrOVXdsBd5yVYjCfIq8oXto73h8cDKqYazgkT20NG3V+l+u2FvLRM4t
 KQ/7zsi+wxxlk0dnzM36TYkaFskulC7/iJNauGQ5aluodM8wRKu+T5OeAUd/qaSfV596U
 rPVZTCZx6qnN9FHcf6omaKPvfBkRKYwz580sH9ZWUzzwzUzaKi3gtsm4nYuBJLrrLAXje
 yH9omr++tO82KIDosOlXB507AeTyF4OkFG7TCufm9NKcJEr1Q88z+yXNiaivSobR3Gw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=uLcFFZF1; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=uLcFFZF1
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5EDC808C8
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EE3DEB0055A;
 Mon,  7 Sep 2026 17:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1788795427;
 bh=Vz5JAS6lwNmXdF9e3VcZAJd+9b8U4TrwRaP9StFiuUs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uLcFFZF14/utAr1kfwfjkEmZD9TFBgZlCW29M3ykGvi6uam7MIQ7iN1gP7NvcmcS0
 6Sq/bx1c8D8eIcGVqiYx8Qo5SA1B2A5r+KYVMHvD4mekTgO9Z6gf71P3AoDiNTN/BW
 wER6AOBVmPGnmqgL26EM93jb9OT8POAjuseyX6MYQlmW6XQvAQ6x87ZlEERZ/Zdcjb
 ijkwKz6tPA7xCim4Y4Z/CvkHX/UG6owxEikP59icBWl80XxIZzVCw9Ir5bC5MmQw6G
 cokZDxnRsNlIlwsGjQQ+ExLMHxw8IcqJeXI6OMmmdV+M/tNSx6s+AEq+pOWyX7kpDv
 X7imC332/GuEQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Simon Glass <sjg@chromium.org>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 8/8] board: nbxv3: enable +3V3_FAN rail fixed regulator
Date: Mon,  7 Sep 2026 17:34:10 +0200
Message-ID: <20260907153411.2207773-9-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907153411.2207773-1-vjardin@free.fr>
References: <20260907153411.2207773-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add an EVT_LAST_STAGE_INIT hook that drives the +3V3_FAN fixed
regulator on, so the FAN daughterboard's EMC2305 / TMP411 / EEPROM
become visible with the "i2c probe" command.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 board/nxp/lx2160a/nbxv3/Makefile    |  1 +
 board/nxp/lx2160a/nbxv3/fan_power.c | 33 +++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 board/nxp/lx2160a/nbxv3/fan_power.c

diff --git a/board/nxp/lx2160a/nbxv3/Makefile b/board/nxp/lx2160a/nbxv3/Makefile
index bea6b0aae8b..9c93965dc95 100644
--- a/board/nxp/lx2160a/nbxv3/Makefile
+++ b/board/nxp/lx2160a/nbxv3/Makefile
@@ -8,3 +8,4 @@ obj-y += psu_pmbus.o
 obj-y += vid_handoff.o
 obj-y += carrier.o
 obj-y += dpll_zl30733.o
+obj-y += fan_power.o
diff --git a/board/nxp/lx2160a/nbxv3/fan_power.c b/board/nxp/lx2160a/nbxv3/fan_power.c
new file mode 100644
index 00000000000..b569b695ae7
--- /dev/null
+++ b/board/nxp/lx2160a/nbxv3/fan_power.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Enforce Nodebox v3 FAN-daughterboard enable.
+ *
+ * Note: it tequires CONFIG_DM_REGULATOR_FIXED
+ */
+
+#include <dm.h>
+#include <event.h>
+#include <power/regulator.h>
+
+/* `regulator-name = "+3V3_FAN"` in the nbxv3 DTS. */
+#define NBXV3_FAN_REGULATOR_NAME	"+3V3_FAN"
+
+static int nbxv3_fan_power_last_stage_init(void)
+{
+	struct udevice *reg = NULL;
+	int ret;
+
+	if (regulator_get_by_platname(NBXV3_FAN_REGULATOR_NAME, &reg) || !reg)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(reg, true);
+	if (ret)
+		printf("nbxv3: %s enable failed (%d)\n",
+		       NBXV3_FAN_REGULATOR_NAME, ret);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, nbxv3_fan_power_last_stage_init);
-- 
2.43.0

