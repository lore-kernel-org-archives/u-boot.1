Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF53CA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4650983A24;
	Mon,  1 Sep 2025 18:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PQfnYPPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CFD83990; Mon,  1 Sep 2025 16:39:56 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCBC831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 16:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b4c645aaa58so2911240a12.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756737592; x=1757342392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WV+l7CP3ojjm3NjFb6w2D90abQDzZBI6dEjswsrYucY=;
 b=PQfnYPPT23TJVTFM5clQF+60DG49vTpF0PM+zKqnsWB3r/SQz7DQX3pCzip/fXGw1o
 ga8CszTshDWHlBG9w75FqQwSGCLx5FrbwBqgNaVHBQkwFTlZOE3zrHlkOZGEW3RV1rtU
 xBt/QUFkTv/H7jRTTKIY/Cz82GE1dueWzZLq3MiCIk3hW32bXj8DvcrwUdW8RpMOsiKi
 OY9EJIXf88zwzOmcnxcKDYCYszZxGsXnwwfkDfBnkExFHMQBQ860vF5Iqo4uCjl48yl1
 fI9mm/jcUsfRGrX6AJ9A5baKUyFRw8vEuZPAjZy6diHoOLgXjzZ5KZZDMrQAc8bW3nvN
 w2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756737592; x=1757342392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WV+l7CP3ojjm3NjFb6w2D90abQDzZBI6dEjswsrYucY=;
 b=voR7x1EVcWsuC8pLu7mPifoJNH/17D0amJpXA+vTxX4g+ip5SFBPBfsXa3tL0UvKJ0
 ZHXozLMIvIVG1soZuhds7U6vgficxV1o47cLJlBSRwQxMMEXWJv42reoCWUsBU/9VOj6
 M+CiLzIjp8YIzw33sn51nC0dB9NHvMJY3Hdfv3mdyy80atGnjZG7aNevqU6s+5BD6m9M
 Ji8Wj5EOTbWf8z9jUSS/kkpR7+heHiwmg3tB5IDVqRgAL7SC3pVXlAfk4yWZcFJcpk/p
 BGapuZFzqo/NQmSWhleD1SVX8GOJAxDo/64gTkDZD36uXkWx3q4x0khH9I6JcneoR2Gu
 Pwww==
X-Gm-Message-State: AOJu0YyYAucuAHtXQIUEN9l1k8HIjNIq6VRFSq1QyiAn21BgE8x6Do55
 H9r6nqKEpHU8cby7zRSdEjaGgtDcu5DeGG+Dqcn3oty3BTKLxK37Z8I/0HiKXg==
X-Gm-Gg: ASbGncvOh97cpD8nyIkqBUgbww7lB9u4MgqJGVJ21Wq9RctirICbB0JBlRI5thSjexF
 g994z9rtcmdT3PE5DVv36bKu4sX+LSTh7gSUFQtMCqtXFyg1HqrL8WiGDoxy2D+h7os0uwUDAPL
 pWOymTal2drUX60afNahjOrTmftyHSVorMQSmu9DU+RqI3miZJLugxjJfNM2XAJTXmKHvo0HCtl
 A2iUWLjCP3UIxhgB/X91OF1wu5mdS8gLCUufXWds0NIVVcO7KnAE3GRroWgkZaMnDeKHI2ll4PC
 X5qWcR0/yc2dyNZoiAeb0pysKEX+gS2Jqs7fLPfuz3nC9JtYmC2rq9YPGRzGPP90Zh7sHEhjdRv
 0mt/K9YlkanSdpbqRTPx4yJzT8BOxwoU+E+Y9JoZdzmGVXhh0fT1XkVbB+RMwGWto9iCSH6kFzO
 7b1e0eNa+5Qw==
X-Google-Smtp-Source: AGHT+IEr7NYW9x6gev0j/IHdS7aLcY4g0wMSuWH0woTZj5v8DtNoC0MOngPFj/3sbuErxkaAZ9ARlA==
X-Received: by 2002:a17:903:384b:b0:240:84b:a11a with SMTP id
 d9443c01a7336-249448f24abmr110729055ad.17.1756737592497; 
 Mon, 01 Sep 2025 07:39:52 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.220.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490370298dsm107725295ad.4.2025.09.01.07.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 07:39:52 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Subject: [PATCH] board: ti: fdt_ops: make ti_set_fdt_env() const-correct
Date: Mon,  1 Sep 2025 20:09:45 +0530
Message-ID: <20250901143945.82095-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Sep 2025 18:31:50 +0200
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

Make the fdt_map parameter a pointer to const, since the function only
reads the mapping table. This improves API correctness and allows maps
to live in read-only data.

No functional change intended

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 board/ti/common/fdt_ops.c | 2 +-
 board/ti/common/fdt_ops.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/ti/common/fdt_ops.c b/board/ti/common/fdt_ops.c
index 47df5726ff0..0486d2e7802 100644
--- a/board/ti/common/fdt_ops.c
+++ b/board/ti/common/fdt_ops.c
@@ -9,7 +9,7 @@
 #include <stdio.h>
 #include "fdt_ops.h"
 
-void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map)
+void ti_set_fdt_env(const char *board_name, const struct ti_fdt_map *fdt_map)
 {
 	char *fdt_file_name = NULL;
 	char fdtfile[TI_FDT_FILE_MAX];
diff --git a/board/ti/common/fdt_ops.h b/board/ti/common/fdt_ops.h
index 5d304994fb6..5375303ba8e 100644
--- a/board/ti/common/fdt_ops.h
+++ b/board/ti/common/fdt_ops.h
@@ -37,6 +37,6 @@ struct ti_fdt_map {
  * @board_name: match to search with (max of TI_BOARD_NAME_MAX chars)
  * @fdt_map: NULL terminated array of device tree file name matches.
  */
-void ti_set_fdt_env(const char *board_name, struct ti_fdt_map *fdt_map);
+void ti_set_fdt_env(const char *board_name, const struct ti_fdt_map *fdt_map);
 
 #endif /* __FDT_OPS_H */
-- 
2.43.0

