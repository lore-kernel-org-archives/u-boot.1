Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFC3C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B812B88431;
	Tue, 28 May 2024 18:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7tMXfeK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0AA883FB; Tue, 28 May 2024 08:02:02 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EE5883A0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=meljbao@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2bf196037a7so99419a91.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 23:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716876118; x=1717480918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k+MAQJYl4mCmbGf5zOSquDLah5NskZuka44kJ9lWLjc=;
 b=h7tMXfeKjGIqdiPWjNyF4N9cRwVd+NEwfIQehCsLLT3BWUD4a5/UXp2Xi2HfyUezvE
 FxoH0cuUA+QQiiqMyEQ6wUb7uZXFRE74NWoPwD59PxBbWyDUT+SfbdI0gSg218gPLGom
 4gadYiU5JULToX2dxmKg8n93VuCcMazMB3XcgcJJMUojF24GaG7qxRPZxHVdTvZPQ+lv
 rJLr6P/AsIT9WsI1TJ+62SQkBTGGW3W1IHzoWe44cS0qz8JwL04CGCd4abxeZWMYGLRU
 izVRLZfQZxsUaSmJXIYKvqgQY0LV43Ze1G7NxJmpyzj3MpZwSmzOaGYigqLWOOXKfMmP
 OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716876118; x=1717480918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+MAQJYl4mCmbGf5zOSquDLah5NskZuka44kJ9lWLjc=;
 b=ZluG7yL7NHniHgMhJE53OEYTFysiA1w/fhEeAI0y0+s/KpF3iPEvhCNkSvnmzYDup0
 iyWsUUsrd211ea+kUkzxiKv61ePihOONoEzlFLLUkLARs0IQN5GPL9YTrP/tszpT4+Y9
 +Oc9sRiEkm3/p9sbN0YPbgoB3wS8Lt7zX06da2/7LzAIH2vj/T5PAFZAMtq8zi1SMGkh
 AFnP1BpxlXRhFLLPkYSyLKCLvVTXUi1JJkU4VH4VNJcSSKU3vkmpBWjPL7SOF9U4vjUt
 XCwPSR7e8c6frnsX4fN5Y8k+TQLkAu3tNg+/gF+M0G///35fpjxVf0pJdvGh6At8VJIk
 7hVQ==
X-Gm-Message-State: AOJu0Yytk3fcyY42fcEXmnSlM14zU0d7Ex3/Y46cqM0lORBqtZGp5XgS
 Uy+SkWbi3ZksYFUInEd73qtGlIYd6q65R4j38gBO/Xs0klBZcB5AcNkKAtIhAks=
X-Google-Smtp-Source: AGHT+IE9EAj/0qg3uqfsx/B11N3PDkGaVr3ATO/RAJTbrjuFjEbddBLhiMdid35+KMHogZiJvPOIDA==
X-Received: by 2002:a17:902:e801:b0:1f2:fbc8:643c with SMTP id
 d9443c01a7336-1f448f2e808mr125011805ad.3.1716876118114; 
 Mon, 27 May 2024 23:01:58 -0700 (PDT)
Received: from localhost.localdomain ([112.96.224.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f48fccb7c3sm35180735ad.228.2024.05.27.23.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:01:57 -0700 (PDT)
From: linjunbao <meljbao@gmail.com>
To: u-boot@lists.denx.de
Cc: linjunbao <meljbao@gmail.com>
Subject: [PATCH] mmc: return immediately once the dwmci data transfer fails
Date: Tue, 28 May 2024 14:01:49 +0800
Message-Id: <20240528060149.674310-1-meljbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 28 May 2024 18:47:36 +0200
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

Originally, when the host is in dma mode, the return status of
dwmci_data_transfer() gets overlapped by the latter DWMCI_IDINTEN query.
When the data transfer fails and the query succeeds, the failure gets
escaped. Add quick return when data transfer fails.

Signed-off-by: linjunbao <meljbao@gmail.com>
---

 drivers/mmc/dw_mmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index e103664145..e04872c432 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -372,6 +372,10 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	if (data) {
 		ret = dwmci_data_transfer(host, data);
+		if (ret) {
+			debug("DWMCI data transfer fail.\n");
+			return ret;
+		}
 
 		/* only dma mode need it */
 		if (!host->fifo_mode) {
-- 
2.25.1

