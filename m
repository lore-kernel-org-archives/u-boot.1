Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC5CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763FD86C4B;
	Sun, 24 Sep 2023 22:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="axFyFU13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6753586AE6; Sun, 24 Sep 2023 22:40:44 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBA286C28
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79fd120eaaeso2746039f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588040; x=1696192840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAvLSqTedZIkl+52nwwF/BRXNpHvi6y9PaiyfxqZlmQ=;
 b=axFyFU13kGKSyz7IHVRRe+yUZu1APvkfpXyQ81iopeMRHdgTJFgjf37gC07sl9N/+r
 Zwa+Nb/UTBKapHg4zZVQuYqOqlUvZIu/9NvNDTt2b07SFT0xNXIByR0sLPT0yJKL3yOl
 oPUJRtv2FDNjJ9Vy3DA8YOpK0x+A3jDqhjVLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588040; x=1696192840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAvLSqTedZIkl+52nwwF/BRXNpHvi6y9PaiyfxqZlmQ=;
 b=tYLCb2g9NZM6Oc5L20L0GCi3Rt72hUgY3camRdiHPah7vdMOMJMWlxuYtpqf6+SsWQ
 xU4bp/QK1kU7jkAYxgCvhe/maPP6W26qjX5j0PAFKOisPvl8xTUE60bxbPkP+9dd8Q/0
 8VzTUiqfajdIidBXyKunmf+FaVNYRP0D1lzbP1Wl7hnMbIou1tGKopEZAIT0URIqU+1k
 0oTJxdTNOBaPb2DevZRTDBDrrvMFrg0X0oINntK+bxugqvAZiIBhpdQUJbYAkFqXz79J
 TVly4gYdaP+NoKiAOW5yGgQ95h4enCZeE5Auxp/IHsRvGgMmUHj/aMmQB6tw7PMQ0MeV
 wwAg==
X-Gm-Message-State: AOJu0YwvySsG2uOr1Xk1UYvWf1Jl00RnaBYbfqtFqBX5DShzqfGEHfkn
 BrhfPbSENNv79aWjVO3nvkUyq1GGwRNdgQsF8y4=
X-Google-Smtp-Source: AGHT+IEiQSGr2cU9YT1OOwTTURwXN8yT2Rvo+t9MPKpaFNL0FUkZ7w8sT5uJZImgy7Jz+X7G/MW/fg==
X-Received: by 2002:a05:6602:4242:b0:79f:a25b:51c with SMTP id
 cc2-20020a056602424200b0079fa25b051cmr5380916iob.11.1695588040536; 
 Sun, 24 Sep 2023 13:40:40 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rick Chen <rick@andestech.com>, Zong Li <zong.li@sifive.com>
Subject: [PATCH 24/25] sandbox: Avoid requiring cmdline
Date: Sun, 24 Sep 2023 14:39:42 -0600
Message-ID: <20230924203953.1829820-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

Use 'imply' rather than 'select' for command-related options, so that
it is possible to build sandbox without CONFIG_CMDLINE enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 19f2891ba1c5..789be7a9f1e8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -134,7 +134,6 @@ config SANDBOX
 	select ARCH_SUPPORTS_LTO
 	select BOARD_LATE_INIT
 	select BZIP2
-	select CMD_POWEROFF
 	select DM
 	select DM_EVENT
 	select DM_FUZZING_ENGINE
@@ -152,10 +151,8 @@ config SANDBOX
 	select PCI_ENDPOINT
 	select SPI
 	select SUPPORT_OF_CONTROL
-	select SYSRESET_CMD_POWEROFF
 	select SYS_CACHE_SHIFT_4
 	select IRQ
-	select SUPPORT_EXTENSION_SCAN
 	select SUPPORT_ACPI
 	imply BITREVERSE
 	select BLOBLIST
@@ -167,6 +164,7 @@ config SANDBOX
 	imply CMD_IO
 	imply CMD_IOTRACE
 	imply CMD_LZMADEC
+	imply CMD_POWEROFF
 	imply CMD_SF
 	imply CMD_SF_TEST
 	imply CRC32_VERIFY
@@ -208,6 +206,8 @@ config SANDBOX
 	imply PHYSMEM
 	imply GENERATE_ACPI_TABLE
 	imply BINMAN
+	imply SYSRESET_CMD_POWEROFF
+	imply SUPPORT_EXTENSION_SCAN
 
 config SH
 	bool "SuperH architecture"
-- 
2.42.0.515.g380fc7ccd1-goog

