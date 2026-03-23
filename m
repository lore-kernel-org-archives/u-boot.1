Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D309F4612E
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 14:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8F98408D;
	Mon, 23 Mar 2026 15:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PFuQUrtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D4E84132; Mon, 23 Mar 2026 15:38:41 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A598783DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 15:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67c2045c0f7so2343666eaf.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774276718; x=1774881518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rFZnwPGD/1aq8lOtoQ7KVbRD6oUyk8Ne3dumq1Ea3A=;
 b=PFuQUrtjGcYyD5Y2LlcmLr9TiSNPaQRlsi/zzyVIs2jd1Mf1ZxGLQnPDLro9sCDw4M
 WYVP6oKI2mYpbujq8XV14LmM9c7yuszcX9VuY5rOvW9OW4GYvoi1nQF9ONgDLuvEtS7j
 7NhqgPf/p9jBDqpDBoQxFOD4YjTtPx+5tKdcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774276718; x=1774881518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rFZnwPGD/1aq8lOtoQ7KVbRD6oUyk8Ne3dumq1Ea3A=;
 b=NFv60cRS3Wovj9ic3aluX+mOZc32anxVrzl9MGE0wfOUx7YqNw83pZYAkhAvD6+beJ
 jJQbqzQ17DLdVpulQyfybhtO9y8ZkigNsNmK5LdRMTWwsrj/amWWF3iVXn1tToqspaXM
 Kqqx8WX57CpCSEdH+WKHTKSzakdywaLRHmlnldZiX9MJHl4xiT8qIl1rs9WAYvJmAydT
 fgVrfXJ0pMJaMNdFa9OXMtUrdCwKbyfiGPGHlHKVkM9mkK06ny2uffZbr7uh1jfjUfEb
 ETnzK7LFQGqESAosBWM62zmuPvYSZU4ryMB7yc4i2WE87Gz4ow3PaEVyqChPV4+IT7jo
 1HUw==
X-Gm-Message-State: AOJu0YzBlYS1akGvbC5v3cQ1d/jYWlBOMC+dM2KGGXpuzEQBZ4uKc9/E
 ryZt3Cq6Y0i7vAYnV/8frkpbW1BKtH8b958aUgd+romrjVU+rRcCYWQ9lcWFIfbgeKIwZwuYwh8
 NdAz2
X-Gm-Gg: ATEYQzyrrUHRXkfh9XZxMziJc76YGx6oBBCCSn6alCsI9PdPNBIliUJW8qT10jQOVXq
 /7ciuUP8AaB900HBWq1zcmORNKauNwNU5JgTQ89VXkbAjK3dCLPl/MWu8aeU8GnL+BeRSJBzPzF
 fIx2VHcjPAKuzjffwCoiI9YCg252FyoW0rcwCZ0FT1Mrq0PO3zid8I9PvD42aYSooA49IwNaB4k
 ci8BDzOMBd72k1oFXNevcLUnRVCO+ENWqI+Q8xyMYr1YulNAeUsHNk03VFY5jzzerTzLuMWyaz4
 lvklvxFKATQLPPXYEMHLNyRMYAv1zlI72YM5kxnpD/60Uj05YcKgwLgUD2/SO5+02+1Ow0VdrOB
 xRSvKGo+aHJqPOX5Co7dzsHeJ/skXL+Hv/4LNt0ykly3Y8Z4wqhoB5VirDNqWx72XwV3NiWopQB
 dsBN4E2XTe5TNsJoL7qUI1U85/rMzFBGnFjiZzD9f8ecnxhehWAQbyI0kJY0vOVikfhWxNmJOWf
 g9UNNuaI8+ySSnB/NIQawarOJQUcwxP5Ygkbx/ToWZuuvIJXvU=
X-Received: by 2002:a05:6820:2287:b0:67b:ab68:b5f2 with SMTP id
 006d021491bc7-67c22ecb3efmr7280515eaf.22.1774276718238; 
 Mon, 23 Mar 2026 07:38:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252dbd05sm6143057eaf.6.2026.03.23.07.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 07:38:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2] usb: Correct dependencies around USB_EMUL
Date: Mon, 23 Mar 2026 08:38:36 -0600
Message-ID: <20260323143836.2274286-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
References: <f6ffc6db-c59d-45c9-964f-7fa56c320047@mailbox.org>
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
Changes in v2:
- Drop erroneous select BLK line, pointed out by Marek

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/emul/Kconfig  | 1 +
 drivers/usb/host/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/emul/Kconfig b/drivers/usb/emul/Kconfig
index 279f6c6d7404..6305f2496c3b 100644
--- a/drivers/usb/emul/Kconfig
+++ b/drivers/usb/emul/Kconfig
@@ -2,6 +2,7 @@ config USB_EMUL
 	bool "Support for USB device emulation"
 	depends on SANDBOX
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

