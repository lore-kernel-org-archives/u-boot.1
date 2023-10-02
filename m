Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A2E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFBFC8718F;
	Mon,  2 Oct 2023 03:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GnzVJLQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3DD87164; Mon,  2 Oct 2023 03:16:03 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6728487153
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3af64a4c97eso2151759b6e.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209306; x=1696814106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZsx1PqtiCzkneIYC7Xn/D2a59JaElp6aimlo3TEANc=;
 b=GnzVJLQbQrDd8uD4jATcctgho4OrsyLtkjqsNyMVdtSzh2LzxLcIFLdbI1QtfNPfJc
 qr+7O7tK4KcGwaXgt+0vJ/0cUVFwTzqY5FRDd0E9IF4AZBUhpP7il7jfurM68cAToA0s
 jiS0slEloBUponjx1lrhe5zfw2zTHXNUTerKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209306; x=1696814106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZsx1PqtiCzkneIYC7Xn/D2a59JaElp6aimlo3TEANc=;
 b=Gc9AXjnUeC6vRogc7JnJ+NrFYGP0pKFn/zgAujq4DLipjSLmz5Z/tL1JCkEwIKV08Q
 gSMnkm7ih/uYEinne5//u+78QbzB3f3polZDyap64xGrIYFj/UeaA/taLSrikBxsvQUS
 Oh/FWbay+PVxC7oInllmKTF0PPS3QK9lm/mBAvo/4dFKzpfis4D6sJoFJ9dtaZmBL0q/
 /jzIZZDX8DtqgKhK7PpXIz1FtuXnoRkhq2QMGJbvLfj4FnOiNSjr8uO7nPESQExWKfOt
 Zxhn8NCZOXXl8/2LkIqMxxLGXTpB617Hjng4pXM1H1R0edW1B24sdKGbB3Q14sraorbX
 7cIA==
X-Gm-Message-State: AOJu0YzD6mW6HH+kLOqvPhrm+8X7gsgTiQZS5av9i4DR5cy78+z+YAzi
 OtY2yMt6PM5gqkISHXIDBXmsRwja9hgCb32X0WI=
X-Google-Smtp-Source: AGHT+IHVdW8BOf9NaD1vxwGTZZBC2Z1rqppj2F0POA47Gwn32lvLBSojY6ccE9is5ACkKb/vzB9x2g==
X-Received: by 2002:a05:6808:1582:b0:3ad:f8a7:1485 with SMTP id
 t2-20020a056808158200b003adf8a71485mr11295079oiw.18.1696209306216; 
 Sun, 01 Oct 2023 18:15:06 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 12/12] x86: qemu: Enable truetype fonts
Date: Sun,  1 Oct 2023 19:14:47 -0600
Message-ID: <20231002011450.462468-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Enable this feature to provide a larger font choice and more attractive
menus. Expand the ROM for x86_64 to 2MB to make space for the font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 6de3da2d8269..c73d3f96e53d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,6 +83,7 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 4b2787d4aaef..123d5ad63e53 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -60,6 +60,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
-- 
2.42.0.582.g8ccd20d70d-goog

