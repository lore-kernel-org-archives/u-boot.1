Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D98BC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAA18848A;
	Tue, 28 May 2024 18:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cd0pWs8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5712D883F2; Tue, 28 May 2024 08:15:52 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C17883DB
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 08:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=meljbao@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-68053bd4533so20963a12.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716876948; x=1717481748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k+MAQJYl4mCmbGf5zOSquDLah5NskZuka44kJ9lWLjc=;
 b=cd0pWs8VWUrahj1mrPuBzgRE92G//BcysfR9vJ4ddgWGOJpHn37W7EU+3hdoFjUqox
 4+4tXHiaiz2l5Sk/CKeiBwq35Nhm5opooj3Ibq4iKCKfd2Kx0nvJpa8hfB9RnROX6aKm
 PPCS/hq9Tkusq/wYtO9B7TTYhxaQEMVS4scilleo6s49y4mcuRtf9Wz2+KFvMX0i359H
 uaLpz1JoTn7uf/RIRzda5kqs3EMgtPVr4WCe713ddWoVmlCvWzCxI0irgT3RzbXg2M7j
 c2fcU5z//lHocprUJsjNiytngTHoGNNKyoXE5izxvkqq3sPsV9i3DYlP91KaWUICChzs
 fW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716876948; x=1717481748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k+MAQJYl4mCmbGf5zOSquDLah5NskZuka44kJ9lWLjc=;
 b=pjqdEV+K+1A7V2YhOCGKI07AHwvMD3NPqO3cijBZRe3jgZ04GZDWN2gtYlUWw6lell
 u4nK47NtJFx6h3KLHg/16dE4zS1VUns8HjmCzHg9HeYvcrfGTwVQbWAixOU1L8PNeXWo
 zjuwOr70wAcjQizzGNObVNAVkrDlxhWPSuCf8ais2yIitKt6xo4pvzFI6Tj5vy7iHPzO
 YtZyWNBNTMMSCvuwN/oT99qXQNRRzZZwRV8+5cnfrnFdJl80O0ZQAOu3WhxDAaQ8oFLw
 fVJ8K5MT9nB+k7g4vUHxs9QwIe1GtKRSbR3G9Dv/Lm7gTW5JEMQYkKJcn2kkU+UoNRwf
 NXQA==
X-Gm-Message-State: AOJu0YzeoeRK/1hxIwQhU1rRvoyLVnBwod9WO+mf101KObb/YYhYhIO8
 ht9bv6Fv+v0fnxhVUCVY+GiUXlSxxf94/edGawCi/GMjV+vIByGpVRAz1XlGYfuKNWs8
X-Google-Smtp-Source: AGHT+IFh49HDtL3PoBCGSDNntEXox7cBtXPxy8e5y5eLh7RofPz4xAcJ9KV2KA6S7OfQOmu9D/hX9w==
X-Received: by 2002:a05:6a21:616:b0:1ae:42aa:7f1 with SMTP id
 adf61e73a8af0-1b212ccecf3mr11083250637.2.1716876947887; 
 Mon, 27 May 2024 23:15:47 -0700 (PDT)
Received: from localhost.localdomain ([112.96.224.116])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7d1b39sm71679035ad.116.2024.05.27.23.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:15:47 -0700 (PDT)
From: linjunbao <meljbao@gmail.com>
To: u-boot@lists.denx.de
Cc: linjunbao <meljbao@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
Subject: [PATCH] mmc: return immediately once the dwmci data transfer fails
Date: Tue, 28 May 2024 14:15:30 +0800
Message-Id: <20240528061530.675258-1-meljbao@gmail.com>
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

