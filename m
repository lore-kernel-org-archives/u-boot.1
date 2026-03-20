Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962351099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1DB84197;
	Fri, 20 Mar 2026 21:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VY1p4CcU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 716D883FFF; Fri, 20 Mar 2026 21:53:59 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD18983FA4
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d7c77fd31cso2075912a34.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040034; x=1774644834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OmErMwl3Xifhaoid8pWOi1gug8e0iUux5KnmtYKEmSc=;
 b=VY1p4CcUiwPfMwsfG7yRisgH2pZZw9XELigI/yXpm7sEnWip8M0vlj4JBmBUK6rkVs
 IiurFqu2n0I5zXWe+Wu9RxZxjIQfW1rAEvh+93+Z7TqRxVtUFW8FwP4NOOeRbz898/FZ
 yM7a3xM/bCh1VYCN/og9rvntSChhAXl1P7uqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040034; x=1774644834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmErMwl3Xifhaoid8pWOi1gug8e0iUux5KnmtYKEmSc=;
 b=lB5geKp17RaTTUTFFD43gvwpsZ7NoKVkEGjuchQOv7HPSC2hsQAJSqSPNXAVvd2lCL
 cKowZIYInYdy2NPoeVhXeesfutGWP3H+gljfzWzhsf27s3t052fnqwiDuO3e7yWYU8gi
 qjV6bqwqt230vZcFs7uphaYIMV02Tv14v5ty1vb1qWkXIgBqIpB0hXcyXyajPZaVVvU2
 Tpy9FLF1T3ezT4Q9NQY4U8H+I1X5riNpHqy1yQzcw9sNMofy0HgpyGNTpEnvMqE7XSrd
 l/Nt3MqIV9fMPiGvOIDY+R6X/Jjfk2gDC1Iskl1g+mf4whiptb44ghXniTwkOoCWTws1
 Gc+A==
X-Gm-Message-State: AOJu0YwpoX6CM/mrqbJOMc+94TXmeXaiUpXCFnvikeAk/H8k1oYQum3c
 sjfDoKajUEX3QMcu7PdS29pfJaNpjs5DSy9IKwllVQLzp6QVYYhKafZMiNPD+xa4AO38IOpBk3E
 i5uAYO/c=
X-Gm-Gg: ATEYQzyNnllmoy3dtDO7psw76cIRmVoLpBYGypvpjQ+OktVsugq60jcLAvUMx5QroPI
 a3QOYkylMumgv7JrwqL7Pqgv+7qOKGqVkXvI0A//8zcniy6yRf+IE0UxDXHytZYSBaaTZOjay6v
 JNHrlucMcU4WnypxttsXplTVFa6Gb7+tkXcWs4YB1SBmabBCp8bxhRLw9edx74WFpHZqQ1KDGar
 lZbtBsAInKnj8XwrwAxx1jaXldPGTjPp2Gi9dDCvz8Coduk6v9KQYo7zNdw8u5kC8YEarJhYFXC
 LzvDXNiEQQMlmlcw703Nq5/I8aBgGg6ZUqLzLrBC1VnraKgLHfvlliXCw6McoNQa39AesAEQo1g
 jToi4os/rRhMpXj1qfVE815C0469JWSgOZLpepKLRuOBkMhjRHzIH3q6lnE52NUwAcG6i1zsd6m
 4mbEYOSjLMufXZiyBR/nd8pnh4x9QIuP+ajxiM0djMjMJcN0UKLNpyT9CbRu902FZdF3TZiNywd
 uUTYJVguZHjceNxU4Y5PRpNP4GshJwl428WcDjVQBedSunYq6U=
X-Received: by 2002:a05:6830:6adc:b0:7d7:d11d:3b36 with SMTP id
 46e09a7af769-7d7eaf657ebmr2801461a34.19.1774040034562; 
 Fri, 20 Mar 2026 13:53:54 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadfc678sm2945518a34.19.2026.03.20.13.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] usb: Correct dependencies around USB_EMUL
Date: Fri, 20 Mar 2026 14:53:53 -0600
Message-ID: <20260320205353.3789127-1-trini@konsulko.com>
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

The symbol USB_EMUL is how sandbox has access to USB. It's
implementation however enforces a few other requirements. It must have
SCSI enabled, and in turn that means it must have BLK enabled. Finally,
we should not be using SANDBOX itself as a symbol to decide what to
build or not build here, as SANDBOX is selected for COMPILE_TEST builds
as well and so may not have enabled the sandbox specific USB support.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/emul/Kconfig  | 2 ++
 drivers/usb/host/Makefile | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/emul/Kconfig b/drivers/usb/emul/Kconfig
index 279f6c6d7404..8ba372453e37 100644
--- a/drivers/usb/emul/Kconfig
+++ b/drivers/usb/emul/Kconfig
@@ -1,7 +1,9 @@
 config USB_EMUL
 	bool "Support for USB device emulation"
 	depends on SANDBOX
+	select BLK
 	select DM_USB
+	select SCSI
 	select USB_HOST
 	help
 	  Since sandbox does not have access to a real USB bus, it is possible
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index ef4ce62a680c..9cac53f07c7a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -5,7 +5,7 @@
 
 ifdef CONFIG_$(PHASE_)DM_USB
 obj-y += usb-uclass.o
-obj-$(CONFIG_SANDBOX) += usb-sandbox.o
+obj-$(CONFIG_USB_EMUL) += usb-sandbox.o
 endif
 
 ifdef CONFIG_$(PHASE_)USB_STORAGE
-- 
2.43.0

