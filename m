Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED3C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6AF8799D;
	Thu,  4 Jan 2024 16:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DndJZP/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9EE78798C; Thu,  4 Jan 2024 16:10:51 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2B18798D
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-35fd5a13285so1685625ab.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381047; x=1704985847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IaGA6AvloKPwvMT5+83EeXKKUMvAVdPHvlUKKiFDok=;
 b=DndJZP/ByJyd80FoV7mhqB0ECcvlVCx+UnN1EUuiEHd8K7OWPBcvFdlZ/iqL/3HOqr
 Bgc7lB26GJ87uJAKE9/LmMre1P3+/KkB5AjdJ9McK4tc61bB74lkiHvfXRBx1Ut1PToo
 bVEYsrqFO4GBWBHum9yDpxj4v0jgup7p8qhzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381047; x=1704985847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IaGA6AvloKPwvMT5+83EeXKKUMvAVdPHvlUKKiFDok=;
 b=F/W79+1//s2GOQCpCHmOWygEGHaVAIpN/aUhfnuJG8L4HpbgO4sqkoLJadSMQApMVK
 Y2GGjSmBaAnDhnt0vjXjS2ZnrScmlkoJWcZUpIbrL6q935szPeOYVm42Y0Usv+cMV95D
 /6Xjfrwp9EouNrc81maWFkjWlOD41939qS+wJDKm0xze00+IR8k3RSlO/ztApO4jtLvZ
 ERa99H7+8mTyhfQvKpZEzvOatP5pUK48JVx8fC0c42M1bi+MQ+sn5qFI3yypJAMaUou7
 zstKGsNijme6qbdeIe8kZjpgTByOOuzJqO5fhLzLnkGfTTnULEn/h/IvfbGRXcj9OkMN
 IFOg==
X-Gm-Message-State: AOJu0Yzy6CEAIoViOiLwQav+HhaeisYaji/4KF637fvSFJNZ8PEdMHO8
 wQ55kluw3o18eaYdvVrYZQgbOkVUuXEPYFJA7kYUMkAWq52H
X-Google-Smtp-Source: AGHT+IFHEC3ZisonGCdCGLWuOva4lLwp14H4WygUpWh06ZO300oz5jpHbeM5sC7xyn1LzQoejakIpA==
X-Received: by 2002:a05:6e02:1a45:b0:35f:eb9f:cf93 with SMTP id
 u5-20020a056e021a4500b0035feb9fcf93mr640752ilv.22.1704381046903; 
 Thu, 04 Jan 2024 07:10:46 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v6 1/7] x86: coreboot: Add a boot script
Date: Thu,  4 Jan 2024 08:10:36 -0700
Message-Id: <20240104081037.v6.1.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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

Changes in v6:
- Rebase to -next

Changes in v3:
- Clear the screen before booting

Changes in v2:
- Add new patch to add a coreboot boot script

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index dec9b40a2b3..ace3b63dfd4 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -17,6 +17,7 @@ CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
 CONFIG_SYS_PBSIZE=532
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 8356bc12659..3762cde6f3a 100644
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
2.34.1

