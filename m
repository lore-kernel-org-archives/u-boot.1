Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A505AD3399F
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 16:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 330D489099;
	Mon, 28 Oct 2024 17:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Py/yXWUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 004DA890E9; Mon, 28 Oct 2024 17:48:49 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D942A89098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 17:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso28313176d6.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730134127; x=1730738927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4VcQ4YUIeurz+R7qh7fFZSGxXRmJm8J1WUKnNnH6Ow=;
 b=Py/yXWUhN+lT/aYlnhgofh65OMTZpFSU9J4BORtew+Aw7oxH8GfmRKlwFea4t1G++K
 Mz53eP7q7KsRorTlAO0wyuRVWltZPht2MsLls7tmSFMp92HD3zJe+QlXutTMysPp7TsP
 5+bnH8bi1xHa5ae8E27Ayc+KkIL3xvyrdbW40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134127; x=1730738927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4VcQ4YUIeurz+R7qh7fFZSGxXRmJm8J1WUKnNnH6Ow=;
 b=FjTG9pM746vedrnli9XickheClUZXW+F/WRHm7fFAi5YudHZnqh4w5r0Y7/6cPeYL2
 ax0/aNh/tVArQQsPgsSjcrgprXPkOpoY1PBfP5j3mLb5zvT60ivFcdkJDoClLpR77wyL
 3O6K+FVTPmuYTHHC8iySMGp1mzZvJ/MvFj8MjKX1fHyTowjBymtBAKJ6vHMH8MS8wUue
 PVZcWHuJnPeg+Khcb7Un61fKJeirOJ7CPOGVSmU6Yu7EXNM3T5bBvaFA1coTa/VHLd9J
 UNc5QjpGoxIuYEMFlnO4oomLloAjDrrGcEGR6ZRJafYQY0Yvk5g1iwI5GXYuGLoItvD8
 mzqQ==
X-Gm-Message-State: AOJu0YyFGvnK/oB2UsPUKEO6Huv4UVGga9zq0H/00Zh+gzss6tpHSxgo
 1k2rk19preCaMUFD1wVVhC7/rtQ3M8iwd3ktjuco4P0EO8WnlpXV0alfk6f6AXeDI8Dvu5PborF
 vKIM=
X-Google-Smtp-Source: AGHT+IGGF+4WgKPFw4FNFTsWj06E/e7n5dds6XkSRPlFMMO7THrNA0rdtsC+Otil6VFMP4NpRizbow==
X-Received: by 2002:a05:6214:588b:b0:6d1:7854:ab49 with SMTP id
 6a1803df08f44-6d18566435cmr123319846d6.11.1730134126743; 
 Mon, 28 Oct 2024 09:48:46 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.104.2])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a8455sm34254486d6.32.2024.10.28.09.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 09:48:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] test/cmd: Make some "ut dm" tests only available on
 sandbox
Date: Mon, 28 Oct 2024 10:48:42 -0600
Message-ID: <20241028164844.2308549-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Currently, the "dm" suite in unit tests (ut) is only available on
sandbox. Make sure that all cmd tests that are part of this suite are
only available on sandbox and not attempted to be run on hardware (where
it will fail to be able to be started).

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/cmd/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 4b487c1d2cb4..fe7a2165af22 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -25,16 +25,16 @@ obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
 ifdef CONFIG_CMD_PCI
 obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
 endif
-obj-$(CONFIG_CMD_PINMUX) += pinmux.o
-obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_SEAMA) += seama.o
 ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_MBR) += mbr.o
+obj-$(CONFIG_CMD_PINMUX) += pinmux.o
+obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
+obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_WGET) += wget.o
 endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
-obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
-- 
2.43.0

