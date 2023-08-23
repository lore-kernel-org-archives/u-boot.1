Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5859C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2906C864BA;
	Wed, 23 Aug 2023 19:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPHTfIl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D21864BA; Wed, 23 Aug 2023 19:26:48 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B29A8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bc9353be9bso557786a34.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692811605; x=1693416405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjvtx/PrVUujqSPdEXAKwjzEZ73Gl9EAUnuHjug1xwQ=;
 b=mPHTfIl3lcLzNWGvC9aIcEK2WWIucqWi1/yvW4tio/JuPP2oshNx0vJQVV7/hhag6n
 Q2skHbJQc3FT70sRc62H4WFntWB95xS+ZtuCjGkhHb9MgRAbeKOmf5u2wiVm9t0+B0T5
 jdgJR8QKmO1nFXAAhXL0IXhgEVGlFW9trEMDqDfj8myitrfjeiygWWXrK8aEfojYSdJ/
 isfn8QFq5R5p1zfPIidtEX++W04tNQePg8v1xicPt8A5DesA9nGJz1CBDkANk5IyLUro
 HhEylDr+sagtr5PlWsrPJG1sj6r5tPyY6SNyzM4ofZiWfkHmRy4ics7L2YKF3XO4q/1Z
 +CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692811605; x=1693416405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjvtx/PrVUujqSPdEXAKwjzEZ73Gl9EAUnuHjug1xwQ=;
 b=lQOpoJiiq17y+klE77u0uAaejpqFNBpIDHk58fq2hHffCXojKvW6I5C6zwxVgbn+Z+
 Qf5fA14Bd4rWD6UUepYM60TJcAGPJPSKGSTB3a3dQElbJ327JVWgdPL2tswLo0Xz36KB
 ElCaUtE+HZaQaRb5A6RpdLZ6i+ejWgQomxqpsMROQknkAJuv5o40B/DF3mSv4MliExBe
 KRILaL9sbhV41yVfit59PpXK+/pGjjl4f0IqcCZOXN68oUdGA7PmnL9bmIZvQ8oVDbvR
 86QEQgyZXvrkXEqIsTQXebRg0U+GtQZqnaIaljHqGSpHwz9sh8rRd6rtpcw91jwVmirM
 2YdQ==
X-Gm-Message-State: AOJu0YwuBIu8iU7V/DqMf7DFvHloObeNqrVUkUtOZy0KgWWGBHqtEUB7
 QcTv+Ahd+wWqXZ73XPLMs3c=
X-Google-Smtp-Source: AGHT+IH6swj/0Fd1sGjUNgFJufzRXnL5TBgtPChgRYX63FdSG+3LJ88mq0b70bTmGYVmFev6qnxP9g==
X-Received: by 2002:a05:6870:330a:b0:1bf:9fa2:bfa3 with SMTP id
 x10-20020a056870330a00b001bf9fa2bfa3mr15007591oae.1.1692811605121; 
 Wed, 23 Aug 2023 10:26:45 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:ae60:b44a:59b3:894f])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a056870734700b001c0e840ebcfsm7158926oal.35.2023.08.23.10.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:26:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/5] imx8mm_evk_defconfig: Select CONFIG_IMX_TMU
Date: Wed, 23 Aug 2023 14:26:33 -0300
Message-Id: <20230823172637.303101-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Fabio Estevam <festevam@denx.de>

Select the i.MX8MM thermal driver as it is useful for displaying
the CPU temperature and its grading:

CPU:   Commercial temperature grade (0C to 95C) at 38C

It also prevents booting when the temperature is above the alert
point.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/imx8mm_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index ac9810fe1b..822c2fbfab 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -104,6 +104,7 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.34.1

