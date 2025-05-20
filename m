Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1DAC3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 08:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D57982B7C;
	Tue, 20 May 2025 10:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gyynFDqH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB37382B32; Tue, 20 May 2025 10:55:19 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF90C829F5
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 10:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso40850885e9.0
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747731317; x=1748336117;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/t/RXX3LKf2cxxaphnlNSdMDlPYjI6UkQ8/NXhyzP8=;
 b=gyynFDqHC0JdNy6jiW90M8L1CNdPS0S8jJ6P9zfE26IDaFNpdlUw0WmKare3EoUVSp
 JG+3BqsYxhi64d5MiOIcu/3ZFgpe72+K+35xQBl4rLNAjQPUwUJbaCW/iu4iQ9WB0TbX
 XvSmKdRjImyxSZODjK2wbYPOyMqCvri4rkZJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747731317; x=1748336117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/t/RXX3LKf2cxxaphnlNSdMDlPYjI6UkQ8/NXhyzP8=;
 b=R2sB0ao8zTBNsAHHsHBgZeCvt4td2H/HQ7C7CCUigZowaI+vQA+wkOKb8RidqFHjZc
 0bh4yXiwdGHxJ0+AKXjdyv4cpaLkUJ5bLtuv2XXQKZCTgPThk+PjsbqEm4ip3sGcJX51
 ucibkdH7UTJTJTbWGPyCXqmjC6yAgrDpUIzSOQwjc4aKueoW1k2qaES51vMyfGkJum9F
 THARFNAbzv3ypUyh3KgF7Jbfn2RG6qBxKFA656gLiOaF/OtHux95K7npGn75s826T+p8
 R4zv5VPXNy9u4SJ1XTHphXWSTOPOq9nY3yFs2p1FSNp+jFpMGKrKIxu2HwJ1/oOxpqP0
 SmQQ==
X-Gm-Message-State: AOJu0YzdSeuldM23RhWNjEszPY3BujjnMjTzrqBEQ0fMzprDwEHXMA6B
 uRCkNukPZa6GcML8E7H5bOzT/vSvnvM7SA+qS8cYYQjKEQ2MjQn/qHTgPm9IQOox5VoP4TMo9Tz
 bKRaI
X-Gm-Gg: ASbGncu+wEq7jU0US0ELRHl2E2OLDpH5C6Uk9LXiFTPfyWoVrFNIzktepzaiF1Allw7
 bhYn0j8Gb6OQx6oyLssBWDBzTWRCwYdfRXlVazqlC4d83KTbnu5VgTE8NSVaVsnG4xBxKKMmBcp
 Dd7MhSDrk43jUDLB+ub4w9OU0wrCtJEu+ri2OJUlYeivqMwkEa0FE3RcnuRp49nghdptK0YAA1s
 wjjYozxPWAp0c36CYfFuxdggE2en/PP3IscM7e7TmDSsP+lP5ckanmEWhg4NshcSnMjAQSutM/7
 D3VYjUBGzGHvFQSX6/dTp55pKM7+SQwTrJlhZ4npeMMgstsBGTObptt4H6JVJoRPRicno/DHlaE
 A2W4XaSrwJHd1Tcs=
X-Google-Smtp-Source: AGHT+IFplZQLeXBNEFNFj1pniJWYO6haRTkpxE+ivHAX2vQ4b+RBwzIvbKrfqk5j/gaGA7T+TP2M1w==
X-Received: by 2002:a05:600c:b98:b0:43d:8ea:8d80 with SMTP id
 5b1f17b1804b1-442fefd5f4dmr144018175e9.5.1747731317089; 
 Tue, 20 May 2025 01:55:17 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f062fcsm21541315e9.15.2025.05.20.01.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 01:55:16 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Sven Dembiann <Sven.Dembianny@bshg.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Simon Holesch <simon.holesch@bshg.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/5] board: bsh: imx8mn_bsh_smm_s2/s2pro: let clock system
 enable UART clock
Date: Tue, 20 May 2025 10:54:20 +0200
Message-ID: <20250520085436.925901-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
References: <20250520085436.925901-1-dario.binacchi@amarulasolutions.com>
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

Now that the UART driver can enable the required clocks, remove
the hard-coded clock enable.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Drop patch 4/4 "serial: mxc: restore booting for imx8mn_bsh_smm_s2"
- Add patch 4/5 "board: bsh: imx8mn_bsh_smm_s2/s2pro: enlarge
  CONFIG_SPL_SYS_MALLOC_F_LEN"
- Add patch 5/5 "board: bsh: imx8mn_bsh_smm_s2/s2pro: let clock system
  enable UART clock"

 board/bsh/imx8mn_smm_s2/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/bsh/imx8mn_smm_s2/spl.c b/board/bsh/imx8mn_smm_s2/spl.c
index 5a77d28cb7e1..d36ddd24c635 100644
--- a/board/bsh/imx8mn_smm_s2/spl.c
+++ b/board/bsh/imx8mn_smm_s2/spl.c
@@ -43,8 +43,6 @@ void spl_board_init(void)
 
 int board_early_init_f(void)
 {
-	init_uart_clk(3);
-
 	if (IS_ENABLED(CONFIG_NAND_MXS)) {
 		init_nand_clk();
 	}
-- 
2.43.0

