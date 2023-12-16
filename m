Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F8DC4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1AE87B69;
	Sat, 16 Dec 2023 04:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ShaSqXHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B0E87A9B; Sat, 16 Dec 2023 04:15:18 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4216987B69
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d6c5f9579so5298655ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696514; x=1703301314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwWQlv4WZ3xZOjgMoVOK35t/bc3LkcfRNENxy1RIpq4=;
 b=ShaSqXHYTDE4XqFS80FCSLsZeXkDwVChi+qaIAHFkVJc5Ype6txUc9WDp4SIyBdDz4
 PBMxPSSVXBcMMHjb8qLAtqodMW4Nt6ViPQtqiZoftyAR5WehHOkY2sBSdAES+9WQRMk7
 hyRkT1JvzTHvmHl/0FZTQRNqj2FeBXhnki7MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696514; x=1703301314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwWQlv4WZ3xZOjgMoVOK35t/bc3LkcfRNENxy1RIpq4=;
 b=L9avsJVOZleFVadBY/eZElNcMzOPYsVCtvPXWwhq7rr491E/UMD6aMBcAM3sk+/ZP2
 vwNkZOdKqYjRwrtrw3XB6Sv20GxNfz3wanH1gyV8SYq+XHG645yMHRsa7Q8YOxQZR01c
 Bk7e+o8YjbqkhHkGlINvkYvYR1GLfCfgxXxS2V4zEqUiM9FVyR4U3ikkCREqLS4/Lio1
 5euD3zHmLyg38bGO22YNWkAfPVUf37DJfGF/GkttwbuDtqxlWBXhPhrBkmKgxjRulw6u
 kM7KhXVawhw9eaLoZyltXKjFyPMztMQGY+TCDwU051/s8xTGVcDZcC2KI8ln/xl1WHbF
 kEeg==
X-Gm-Message-State: AOJu0YyDuugYhe6rTpaoVnwHWiCeFF+8u17kxHHPDI4E52VTqFDyDPiD
 9OEQvtCzd20B5I2brg15bx/shr2fJo/oHt/vweQE7Q==
X-Google-Smtp-Source: AGHT+IGfWTE1BZpEJWeAKK5FRfu4XxnolywYpcwr4dvjf2yk3l4BuKUttk1DTk0TjnTVsN+xhtoFuA==
X-Received: by 2002:a92:280a:0:b0:35d:59a2:690c with SMTP id
 l10-20020a92280a000000b0035d59a2690cmr14454394ilf.57.1702696513865; 
 Fri, 15 Dec 2023 19:15:13 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 07/22] sandbox: bootm: Enable more bootm OS methods
Date: Fri, 15 Dec 2023 20:14:11 -0700
Message-ID: <20231216031446.2222362-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

It is useful for sandbox to build as much code as possible. Enable
support for booting various other operating systems. Add the missing
cache functions.

These operating systems do not actually boot on sandbox, of course.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to enable more bootm OS methods in sandbox

 arch/sandbox/cpu/cpu.c    | 8 ++++++++
 configs/sandbox_defconfig | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
index a1c5c7c4311a..d134905e3f5f 100644
--- a/arch/sandbox/cpu/cpu.c
+++ b/arch/sandbox/cpu/cpu.c
@@ -286,6 +286,14 @@ void sandbox_set_enable_pci_map(int enable)
 	enable_pci_map = enable;
 }
 
+void dcache_enable(void)
+{
+}
+
+void dcache_disable(void)
+{
+}
+
 int dcache_status(void)
 {
 	return 1;
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index af3e7d85be39..fd9ca24f8dbe 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -44,10 +44,11 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
 CONFIG_CMD_BOOTM_PRE_LOAD=y
 CONFIG_CMD_BOOTZ=y
+CONFIG_BOOTM_OPENRTOS=y
+CONFIG_BOOTM_OSE=y
 CONFIG_CMD_BOOTEFI_HELLO=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_ABOOTIMG=y
-# CONFIG_CMD_ELF is not set
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_ERASEENV=y
-- 
2.43.0.472.g3155946c3a-goog

