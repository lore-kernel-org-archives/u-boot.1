Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40404C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8B5888FD;
	Sat, 10 Aug 2024 22:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bWz0z6Xi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BDF8891A; Sat, 10 Aug 2024 22:52:38 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544B1888F0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8223685fbe9so110911239f.1
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323148; x=1723927948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDvzew2jmeOD9IJXIEO2/wiKuylyyoimwWfMZYwifCg=;
 b=bWz0z6XieGSmUuw355U3Ju1KyiZFoKHekrtuBKgKS4Q2sxj+cQpK5UlNyviON7z8B0
 7lfx+MogcfZBTDRgyvPrO+mBaT+lOxTJ5M1ZtRV9/1H36k1myOVlWziE8BuxmgEUIYaj
 /Z6AR1nx921wwXGe1I5pEw9mHlTxHyKxrWJnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323148; x=1723927948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDvzew2jmeOD9IJXIEO2/wiKuylyyoimwWfMZYwifCg=;
 b=avq5nscZQmZ/b+kfC42oOKeL0skmTVF2ejFm4TvbANCsJlN15P/Hm67JB780DLgQ5J
 jExFNUv2uH1dFL26Qv2e2WsVlhaVd8Q0/k92RwONCEL+qjm9evhyUNtxqDkj39RJncd3
 nDNg8I8a5lM6nLwFQRYnkvi0Tf4N+XJQQOzJR+4G+jtvLGNFzAzVG6UFAMIoobbMOotg
 hKAw7T0kClBO8YTedDWVZTOyW8B4x6E8+NCweuwAFGKCxFfJTCubrcLbdOt7yT+G3xHs
 vmH+UTyaXyvB2gY/NwefoPl10PUBdfJ2Kp4i/RZgIYEnyDWqLTvynvlB+erfGL8DKx4u
 aMgw==
X-Gm-Message-State: AOJu0YzLRbJ/E+9aMBH3b5yoJ/oEb8NdCTlXKrsr+Wku0HE1PP9mrcQM
 iQ82CFVbqEk8aspT2DGcTy3aN2iAOq8ApkQudRZy9G4Sug8V/gHfOjoZOX/Rv+KGdYBRNnIFQ3o
 =
X-Google-Smtp-Source: AGHT+IETNW4X0KWnCXf7bppjr5aKXlKv7D6OJDb9BzrpTY3BUlZ7cwkhiuaEfyy6dyQCMzoTdRt4ow==
X-Received: by 2002:a05:6602:3f90:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-8225ece249dmr644884739f.2.1723323147959; 
 Sat, 10 Aug 2024 13:52:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH 08/21] sandbox: Enable wget command
Date: Sat, 10 Aug 2024 14:51:52 -0600
Message-Id: <20240810205205.3403177-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

Enable this so that the tests run.

Fix a few warnings in the code so that CI passes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig | 1 +
 net/wget.c  | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8af136d2bd4..43f78a5aeb1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2010,6 +2010,7 @@ config SYS_DISABLE_AUTOLOAD
 config CMD_WGET
 	bool "wget"
 	select PROT_TCP
+	default y if SANDBOX
 	help
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
diff --git a/net/wget.c b/net/wget.c
index 5eabb413116..57fd122fd50 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -243,7 +243,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 		pkt_in_q = (void *)image_load_addr + PKT_QUEUE_OFFSET +
 			(pkt_q_idx * PKT_QUEUE_PACKET_SIZE);
 
-		ptr1 = map_sysmem((phys_addr_t)pkt_in_q, len);
+		ptr1 = map_sysmem((ulong)pkt_in_q, len);
 		memcpy(ptr1, pkt, len);
 		unmap_sysmem(ptr1);
 
@@ -312,9 +312,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 			for (i = 0; i < pkt_q_idx; i++) {
 				int err;
 
-				ptr1 = map_sysmem(
-					(phys_addr_t)(pkt_q[i].pkt),
-					pkt_q[i].len);
+				ptr1 = map_sysmem((ulong)pkt_q[i].pkt,
+						  pkt_q[i].len);
 				err = store_block(ptr1,
 					  pkt_q[i].tcp_seq_num -
 					  initial_data_seq_num,
-- 
2.34.1

