Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA3EC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34E688BC7;
	Sun, 11 Aug 2024 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lHjd7fac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D5088C1F; Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F87688A7E
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39b06af1974so12699065ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387974; x=1723992774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=lHjd7facEJhBqtZL3iM5dHXHfsDxLh131tja2xB9ZRmL/eQpyqqmN6pIA1IGao8pw5
 tCGDmC3MVsiISb65nkjxWgNlINuOa+U2j9H2xvBSocZxhTC3ZKBca+1+4ZXFs+4nj81E
 D95t5UEpWLTvY/DXhRiaSY6vfSQU//4AekGJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387974; x=1723992774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=iBi46rmaoNlr49xCPbvbQTLCYItrCqd5rWBvCHCUAoyn2YNgCWUuDyrWmiIi7cG2aF
 Y4UXTIjfiGp58pMGiI5MVHhVL2ze+D+PekSagq26F1jCWUBAdAazhc8xeYlF0bo53Zpk
 SCyXjJb4QSUE+8EqT9f0he/K9PsLUEDmdJs8PtomrXSHEdP7YssHVDtOPCcUx2Xm/HTU
 bKAJpFilPu3sZzZoJGjNKqL2rwsaXYgeFc3ZydHayDJUpUwNzXbrgaBl+TgFF0wpep7N
 yfITrjotng2Raou7CAe+My/wdDuY/SYI2TGgcm9nqi89jht2+Nuts56pQror6elQRHyz
 Lpeg==
X-Gm-Message-State: AOJu0YxKftL+a9dJKuavMBb4yU6JIIxd0oDUvk7M1dfVsBSROJ2VMEwE
 O+VdpOi9leyBn29TbH3MnPoag1gTEA0fz2y7BBcuF+vV7ZjfTunzR+HQM6h2VL3tOnbWtmz5G8s
 =
X-Google-Smtp-Source: AGHT+IHp0ABd9SEp2+fzQcFF0Mrnk6pgRVn0IilJttWA5LpPKjdVZD4DtLflXlV6CON7L8qgDktpTA==
X-Received: by 2002:a92:c54b:0:b0:397:95c7:6f5d with SMTP id
 e9e14a558f8ab-39b7a410945mr78507035ab.11.1723387973803; 
 Sun, 11 Aug 2024 07:52:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 30/40] efi_loader: Shorten the app rules further
Date: Sun, 11 Aug 2024 08:51:59 -0600
Message-Id: <20240811145209.4191404-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Add a way to factor out the CFLAGS changes for each app, since they are
all the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_loader/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 660368b9d8f..00d18966f9e 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -11,16 +11,6 @@ asflags-y += -I.
 CFLAGS_efi_boottime.o += \
   -DFW_VERSION="0x$(VERSION)" \
   -DFW_PATCHLEVEL="0x$(PATCHLEVEL)"
-CFLAGS_boothart.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_boothart.o := $(CFLAGS_NON_EFI)
-CFLAGS_helloworld.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_helloworld.o := $(CFLAGS_NON_EFI)
-CFLAGS_smbiosdump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_smbiosdump.o := $(CFLAGS_NON_EFI)
-CFLAGS_dtbdump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
-CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
 
 # These are the apps that are built
 apps-$(CONFIG_RISCV) += boothart
@@ -80,5 +70,10 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
 
+# Set the C flags to add and remove for each app
+$(foreach f,$(apps-y),\
+	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
+	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
+
 always += $(foreach f,$(apps-y),$(f).efi)
 targets += $(foreach f,$(apps-y),$(f).o)
-- 
2.34.1

