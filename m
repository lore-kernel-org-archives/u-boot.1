Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3D5C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35954871C7;
	Sun, 19 Nov 2023 20:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mpLzbqB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6229871ED; Sun, 19 Nov 2023 20:12:20 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9D78272A
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-357cc880bd8so14077405ab.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421134; x=1701025934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffyijbZj0PYGQJTk2nPZyXM5agjM9ZiGMWAHMtyamfQ=;
 b=mpLzbqB3WGapNBWZhov2nKzh0uvY8W9L1SDcZYp8AI/0htD9gm1LLk9JVHGCDes5cG
 i+YqdF+Nj4V1qzbAgz0zY0SzVqbT44iOoFiiUaPEhiiBZztxDeuH6fVUBngmiLtuuzv0
 R30ZAt6NrL0QfkzzV95uv4qeBbxRialgX3We8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421134; x=1701025934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ffyijbZj0PYGQJTk2nPZyXM5agjM9ZiGMWAHMtyamfQ=;
 b=ZEyKgHc6+BlnmcSrlXTqPkbRwfsgAy+TCYXx7WakZ+EqwxfRdxOu4IWyPs3xB7+RMV
 AiYN6bX0R4e3zCiLnvI0nHWR9GSS14nWPKvhBysPb+JL/ny6S1JgwIUpGJ8fGCSPRr4D
 TPA8eLL1tBh/ahcERPYzoHznFGG2rp0ppDNKRXPjizfl3RVFhANd614zbTIQvLH49Q9X
 YwWZ8fwUhTcQTw8RD4z3OKycepelAD4+KpvfYypsEbTOalaVrY/fsXjEDa7J2zxEpdmF
 5pR6/iXB3j2thGOJCL/B9faV4sqbvrF972wvcu5Z4RGC3SUc84a86++5ZX/jc/FgezYP
 Xeow==
X-Gm-Message-State: AOJu0YyjJWYGmmbjzCVvM0fBodJOp8V6Su62foReC88Kh+q1YqmWK6c5
 OyEkidhY4ptLeCR8tn/GTT7/Q9lfgMdaLz4HjW0NYQ==
X-Google-Smtp-Source: AGHT+IEsYtoy/+16HOuPrQ0+k/r1MtXmDZPymPAd6s4kvwxjWBhycNARj1u+Vztxhl8NnP12UrG3TQ==
X-Received: by 2002:a92:ca0d:0:b0:35a:f715:7a0e with SMTP id
 j13-20020a92ca0d000000b0035af7157a0emr7226432ils.14.1700421134253; 
 Sun, 19 Nov 2023 11:12:14 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 04/12] x86: coreboot: Add a boot script
Date: Sun, 19 Nov 2023 12:11:39 -0700
Message-ID: <20231119121144.v5.4.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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

Provide the user with a list of available boot options. Selecting one
causes it to be booted. Pressing <ESC> causes U-Boot to return to the
command-line prompt.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v3)

Changes in v3:
- Clear the screen before booting

Changes in v2:
- Add new patch to add a coreboot boot script

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 1f1327f5bfec..92cca6e6aaef 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -17,6 +17,7 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 8356bc12659c..3762cde6f3a6 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -15,6 +15,7 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
-- 
2.43.0.rc0.421.g78406f8d94-goog

