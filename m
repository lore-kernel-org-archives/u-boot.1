Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86522D18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2712E89270;
	Tue, 15 Oct 2024 00:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JhNmLDLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B9B89294; Tue, 15 Oct 2024 00:32:33 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500778922C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a3b4663e40so21630675ab.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945147; x=1729549947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31A4pf2UJu7sXN2OTVNmRnpoZ9C09gUVe0pgYrM+fUk=;
 b=JhNmLDLsvYZlOmxk6eZonodHCKjA6Q2daRjsr32K58eU9WYMJ3+6QqPdoPS0Biv5wH
 vkSZBXudZh0mZiwP4eDuFcsrYnexoWtZHYwQa4tiRigkFwbnhEnvKiYpei+fst1XRPDX
 KuIyYV6GOtI/ZAvkgwcBEP/7JvQPjULlVJMZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945147; x=1729549947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31A4pf2UJu7sXN2OTVNmRnpoZ9C09gUVe0pgYrM+fUk=;
 b=CIXIVhRzmZszNemkl7BpzaHxMWf+Esc3UBGMp/6qjxefj4F+ANYLveQfuDaQzv7cMy
 +fH4m3XiMgitHX1tjZRKbuFOlqUgQQ5wvvq6C+kGP5DF4oMaa4v3y+lJfResShfm27PT
 +mM+z5u7Yde1SulgmkMEtQBUWh3MbnYWisBKxywfD5ukDFkJeWopBt2zibZOg3NqUV8r
 2dhQCnGFUXjKxp9Vb129sXRXLuVEM8xw9RxrtzsQAxzkJ4OJDub3hQ8wravMSvbm+q81
 CkPJ6Xs0FptKEKJ6CzoyffeLzeSifWJ8iVu8Gt+GZQ1diEPSjFYUczxbzyWLFrZOC5mS
 gybg==
X-Gm-Message-State: AOJu0YxwiescW+JMZcqXyvkNFqWjXUziQszeZ6YHMQx4V+Pdto6ZLZa3
 I+BBFvlePYqyq2ZUIHzSKYBFevvsd8Ax+xOOpl1NEjrKkI1PbJ0+Msap4w89349mMp1AGIRKy/i
 TRg==
X-Google-Smtp-Source: AGHT+IFExjABfLSj9Oz8z5/cGvumMx9h+NW8+W4Tz8qsuMWN2PE67+EdA2nfqwFP8ZScNHFWkp/HNQ==
X-Received: by 2002:a05:6e02:19cb:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a3bcdc0bdamr83867035ab.9.1728945146973; 
 Mon, 14 Oct 2024 15:32:26 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 12/20] x86: coreboot: Enable unit tests
Date: Mon, 14 Oct 2024 16:32:04 -0600
Message-Id: <20241014223212.2212442-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

Enable unit tests so we can run command-line tests in coreboot. Enable
console recording, with enough space for the 'cbsysinfo' command. Add
to the pre-relocation malloc() space to make room for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 0b103efe16d..fdf978a539a 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -1,6 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -15,6 +16,8 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
@@ -59,3 +62,4 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
 CONFIG_SMBIOS_PARSER=y
+CONFIG_UNIT_TEST=y
-- 
2.34.1

