Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF43C30624
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 14:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BDB86B74;
	Thu, 17 Aug 2023 16:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="STt8TLB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D582786B79; Thu, 17 Aug 2023 16:35:54 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE4B86B71
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 16:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so218094866b.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1692282951; x=1692887751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NlkAFtxQhLvaZ7rwpow3hbB1x3esFEdgWL2EZjRbIUY=;
 b=STt8TLB74OGhcnkqrFeXGx6UINI+hq4NAHfZQkBs6mBbLN7eZDT6w0OCbSKgdKBGhg
 i1zYLv7RUG75y3YDzO27vNAbi7UihsDqxPJyjD5pL0xTnocxmJoVP//o1/U/9LR0YMQi
 6uH8TZXJni6tC8Dufe7iLJLZK3AlkfzqjVXhgdI3LCYOdrjH0cg3o2aWh9NSMDelEX5+
 Xvlu/T/BDaMietulFtMUL9PrXEff2LubvzwkIc1i3QjhNMLT/7XCK67EmULOuJpdG6ED
 6KwpeJML4HrjHeKXZDQAkhGPfQRqQXTXVDAxzXf/6fs7F0a0vVhCktdoAuuVIC0yxqkM
 jojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282951; x=1692887751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlkAFtxQhLvaZ7rwpow3hbB1x3esFEdgWL2EZjRbIUY=;
 b=a+nUHqJy/10UepZdH6H8H3MWhod/qpuECbH8MQ8QESrztclYDj6hmpTamcVIKbKJD4
 y8OBVZP13kMcxcofMOwSTHQdOoirg6tii7kLzR1Cy15V0KU1ndUo++Z+eRWEWHEId6R0
 YLVYM3h7ucHXfpYBReSXvhtl2KA8xQ33AaPEBtSea55kmwJYvpqHnue143SLfyV7MRpn
 Ls/y9cJWcRSAP/EaNUlI2/bXP29y44ryU0TpzO5Nvo+u2m2RuPcJTAuPoPSQbIzpuEm3
 Nedem4lEKeVzbZFRV4ooY5I6mXBx0/DefDaHhigCiC/o97Z1nqm59o8F3OxlotH0UZbP
 szVA==
X-Gm-Message-State: AOJu0Yy4AslXnReq9Ygxgs7Fn5Dal8HhMFm8LYIQotDRALvSzXig2R+T
 Zymmo427MbqQeJZJm6uCRIF0AhLpjWOpp//0794=
X-Google-Smtp-Source: AGHT+IFDzOa3FR4rkscm7nkjX4UpnhnrI+KrjUPt5A9s0z9JRe3zSZJzqCTSJRnz+WYqoSVlzvXXUg==
X-Received: by 2002:a17:907:2bc7:b0:99c:fb4d:a110 with SMTP id
 gv7-20020a1709072bc700b0099cfb4da110mr3272398ejc.7.1692282951222; 
 Thu, 17 Aug 2023 07:35:51 -0700 (PDT)
Received: from localhost.localdomain ([194.104.22.162])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a1709063b8500b009930042510csm10187019ejf.222.2023.08.17.07.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 07:35:50 -0700 (PDT)
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
To: u-boot@lists.denx.de
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Bin Meng <bmeng@tinylab.org>, Devarsh Thakkar <devarsht@ti.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] spl: provide weak empty stub for reset_cpu()
Date: Thu, 17 Aug 2023 17:35:37 +0300
Message-ID: <20230817143540.23525-1-oleksandr.suvorov@foundries.io>
X-Mailer: git-send-email 2.41.0
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

This stub needs to link SPL properly.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
---

 common/spl/spl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9..781858891b9 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -1026,3 +1026,11 @@ ulong bootcount_load(void)
 	return 0;
 }
 #endif
+
+/**
+ * Weak default function for board-specific reset. Provide empty stub only.
+ */
+__weak void reset_cpu(void)
+{
+	/* Nothing to do! */
+}
-- 
2.41.0

