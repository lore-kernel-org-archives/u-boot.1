Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FFAC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C520E870F2;
	Sun, 12 Nov 2023 21:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YZ71lG/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6781787124; Sun, 12 Nov 2023 21:03:10 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B2E86E40
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35742cbb670so14089585ab.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819382; x=1700424182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpXUBZhxM/OKAEHcLaYpvVJJuvJ71rIvw/NO+BMWTvo=;
 b=YZ71lG/XLvtbFEDB8x3LYwrLsd0ZnOUQWtAkH/TlL6yfCeSHk4LEGbr7Ow+W3SJZDA
 C5bxvuzNBXS0GKvWUMQxlB+TfWIqv4KfkQZuUZyov6DtXPUzhHJpmhh2ljDpJHQNtwII
 hVdWQT64noRp3CGBHr3puWIz7rR4wUP5h5qAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819382; x=1700424182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpXUBZhxM/OKAEHcLaYpvVJJuvJ71rIvw/NO+BMWTvo=;
 b=MaP8ZWqNstYjX2ivfqtm4W6hJ+eN8xTt0TvclzYZ/HH9EER1YrS1dEv26AS4b93VrJ
 VkcG74WlvQElEUAGzpuwRVOj0Q3OtXhQ4R//gte9CL0kKwTH3DLtmWDBg4PTR1P+veMm
 D/q5xt3F2FtWlEVo7EDAF2w7ypBifKtw5wiJEZAA6iWX/gQywzNzPR/aTEarXObjfkK+
 Zb0YwO0RIZEOe3cLC0tH6s7i5ufkjkTJLnIO5d++02Jo9Zd7Kwb9DNyKVOSFT5hOFwGu
 W9l64YryGYOnLAxtTPixMRocJiEqfhCY7TzwVankFM8QhTu/x1/4Fs4MWrljZYpqs9v7
 dXaw==
X-Gm-Message-State: AOJu0YyctrrKf4p/w1wK6ZdT0TBCnJevwyOuz6PFGL6fo/bqX2Ikbj6m
 VJei/RmSLs2mHwUZhWEjAmWWbCVZcqVA1Kzx548tvA==
X-Google-Smtp-Source: AGHT+IFq5mF5xvY54UzZvxlBbXkZvEFLF0vx+lRoNxjhsL16FhTDOZxQ1F0WwCsVBNJuzNN9KqI/jQ==
X-Received: by 2002:a05:6e02:15c6:b0:359:3b32:1715 with SMTP id
 q6-20020a056e0215c600b003593b321715mr9594275ilu.18.1699819382824; 
 Sun, 12 Nov 2023 12:03:02 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v4 04/12] x86: coreboot: Add a boot script
Date: Sun, 12 Nov 2023 13:02:41 -0700
Message-ID: <20231112130245.v4.4.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

