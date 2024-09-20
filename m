Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C058CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB858932F;
	Fri, 20 Sep 2024 08:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aAFnyLy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFAA89322; Fri, 20 Sep 2024 08:03:04 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A4C8931B
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so2196908e87.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812181; x=1727416981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USuJFRobrGDAy5YRP/GRrPkrQKUHCIcpx7GrBQq5jbE=;
 b=aAFnyLy99iQLScVrpc2eVKUL6ctMFokJ9H6V1VBRRIcDn9cl09tLWaqiQpQOfLrBcc
 jxgl8iE4ioK4mRf7jqfgEKrFAP1jl/rqr56V74KPBpqljznrV30e+NXLvsd+FVJMNXbk
 pXrLusOSfPq9QjLskWFxFeAdPndjGhidHlNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812181; x=1727416981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USuJFRobrGDAy5YRP/GRrPkrQKUHCIcpx7GrBQq5jbE=;
 b=ElZO/4n7jlPl6wCsOfBnEq7cpnclDS9wdIFRXpUaXq4kZd+I8AOcns0Qhw4tZAtbK4
 V1TySDxjjlrKLIr6ZIrB2M6HAyRyrD+KSaO9VLA8oeL5AdxWUGbFjQwTDzdEwTrIz3dr
 5+o19SpNJQC8szn5X4mbJ+XmgZLJrSFUXDUSJPS3kVTvdWKpytaXN7VNcNimMXZswxKp
 LBetT2p/kh+SGMkt2l9heqHu/2U3XyUJOhkyov96fS7uaUKp0ZoXv9KAYIRaMgWelR9U
 bgr5WS9elNOiMK0ZgHkOdcH3MnQbb4QeWuUDdk/h1MV1FUZGjJNOhJ9zvSbNxeg0tWgo
 bfoA==
X-Gm-Message-State: AOJu0YzYi9M4kFJzTEng8rV0a+1rK7bf1aWuqtvSG80BhFv4cEl7sLxU
 RLrX55XFTBenPX+bBWhoTWYaBN8ODA7MVXMSpA27jh67/3PXQosu6PSjoGwZuD5hWdx5F5H9sii
 I/B73
X-Google-Smtp-Source: AGHT+IHLDdHUClJBCDuZtjhTzI2tWGHzMDTbaBH9W9PH+Dg4NwxuO6UWUhkOi1VBXO0IfYq+Y6SOQg==
X-Received: by 2002:a05:6512:158e:b0:533:d3e:16f5 with SMTP id
 2adb3069b0e04-536ac334255mr934340e87.38.1726812181202; 
 Thu, 19 Sep 2024 23:03:01 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 03/19] test: Release board after tests complete
Date: Fri, 20 Sep 2024 08:01:38 +0200
Message-ID: <20240920060158.106612-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.43.0

