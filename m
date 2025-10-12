Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2976CCCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BB9F838E3;
	Sun, 12 Oct 2025 08:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L260GUYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F58838E3; Sun, 12 Oct 2025 08:44:36 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ADBE83885
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-42e726431bdso17396905ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251472; x=1760856272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRDaSi+LBPUy7/hnZ/L1I8a+/leeKT6wguMBSYQYaQs=;
 b=L260GUYZkCQboif3cjsSAKNOuiegL+ikJhvk+9RO6HiCNMaAfqvICmfhAPQCF9ckvD
 V4eMZIZFibuuOgCDG5i8BByLohc8AZnq7dER1BXjlpHPLRDEAIm6iIbU+hRoMIu17FJR
 d4eB099SCndbXGPY9OzLeBqbXZOzYPGhL435M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251472; x=1760856272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRDaSi+LBPUy7/hnZ/L1I8a+/leeKT6wguMBSYQYaQs=;
 b=b0/qLveBTwNOnYDHNAgJWpZD+SN3mb+FKNiuf9h1sudEbdcENnWbalelTHqG6eajxa
 NernvMVM/ABRi2VJqnbz8gWj8OVN18o3huFXN/AnX530dBL7TSJ5XbpfO7b57aKTohQg
 +PPdj8fcTGZM4wg99zNc/Pm2Zx8HRF+ngQFB8XrxhjjkcEZZKg7kWUgokgJEGOSm1yW2
 gAASg7DbuMBBRIyUfnFX7cjVJNL1k0G/sBnYssCpf1hS5Hgtl5sHClZNqWvnQ59tUr0m
 4DEfByxC4FdISUbAa8ln5gIZWbbIyVyCFg0vwpe66FP2MlM2X+FkQsbDkJO4eUtQ866Q
 /G/w==
X-Gm-Message-State: AOJu0Yw+EZnklmKt8aNS9XE37cvlWTLIC6aXrH177MQ7loj8TaFpefXt
 /vYscfMWG1ueLVXnqy3DG5FbwnCFl/EECam+U0oIVjhnR/0wdKigCqII+NXsAWJWCAhUtV6RGjm
 PO2pZRxNkEbY=
X-Gm-Gg: ASbGncsn+f0usbmXYLYtRBzSPBdDpQrOESRYWzJ49/mbeGkKO+1wIThsbbso5Bk9P/Y
 WUAFxjnW9XAXEWHTzcSlpU6M8782nyeLjlMu5KVbmChTdLS0Yi2+RcOHkGf5hT8JrJW8ILtVfwm
 J+0WsajOWyD5rFBJSua14kJZm/9MPeBPvxa0vh05du6JZjs9gl5HSUm7NB3ViorQGyztc3CPiLV
 2Wz1FJOCjZ25m0K3awMwUKXbChicqzSOiKzTnj0X2uSKKQi4czXWrmr04jaMubJLS8308c6/Stv
 v+u5HDhocLlblESwmamTxmq7wRyNUOpinZ9Y9UC9eFrGRmGig2NMKivnfbRcxZYT7QhPCQvWW0L
 CPFtUFcKf2RCndas3uaXwvmv50xX8KWbaOnw=
X-Google-Smtp-Source: AGHT+IFO7plj9J0uEvEvCk4p1XMlFvcfxhR4ABjKTETsKqiANX6c8y0c5qBu7zizIY/874JWUKoaHQ==
X-Received: by 2002:a05:6e02:1d93:b0:42f:8fc8:a8b4 with SMTP id
 e9e14a558f8ab-42f8fc8a910mr172766295ab.9.1760251472214; 
 Sat, 11 Oct 2025 23:44:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42f90343080sm38109625ab.22.2025.10.11.23.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 23:44:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 3/4] boot: Rename usb to ums
Date: Sun, 12 Oct 2025 00:43:55 -0600
Message-ID: <20251012064412.2892979-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012064412.2892979-1-sjg@chromium.org>
References: <20251012064412.2892979-1-sjg@chromium.org>
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

The name 'usb' is quite generic and could apply to any USB device.
Rename it 'ums', for USB Mass Storage.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootflow.c      | 5 ++++-
 include/bootflow.h   | 2 +-
 test/boot/bootflow.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 6485d473d69..13f086167ab 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -1019,7 +1019,10 @@ const char *bootflow_guess_label(const struct bootflow *bflow)
 	if (bflow->dev) {
 		struct udevice *media = dev_get_parent(bflow->dev);
 
-		name = dev_get_uclass_name(media);
+		if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+			name = "ums";
+		else
+			name = dev_get_uclass_name(media);
 	}
 	if (!name)
 		name = "(none)";
diff --git a/include/bootflow.h b/include/bootflow.h
index 657e3731f11..2aa00a9b1db 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -696,7 +696,7 @@ int bootflow_menu_poll(struct expo *exp, int *seqp);
  * bootflow_guess_label() - Produce a plausible label for a bootflow
  *
  * This uses the uclass name or EFI device-path to come up with a useful label
- * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
+ * for display to the user. Ideally it will say "mmc", "ums", nvme", etc.
  */
 const char *bootflow_guess_label(const struct bootflow *bflow);
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 7cd83dc7443..b777708f5d6 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+		"  1  efi          ready   ums          1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.43.0

