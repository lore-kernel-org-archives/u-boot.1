Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AACC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B6A987AFD;
	Thu, 14 Dec 2023 17:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWbxZThs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5CB87ACF; Thu, 14 Dec 2023 17:51:53 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F8C87ADA
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35f519f3ea9so21594455ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572709; x=1703177509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9Okq7peTTsLcn5PM6r8lIiWCZPLBF0CABSZSykAA8M=;
 b=NWbxZThsM9Zge5TbAjPOoG8azVYtGkNpbSVBJ/5ldveOPF/MF/ZjMv0lh+6RKewGMM
 x9E11QHMvaBZ0JN4Mpon91bBJiWPrxVR90OQL57CDpVbqp4IvneRZyi8Xth2ok977tVM
 EulDsHghtzehTQPTchHEYQ+xfHrbpNeOYhX30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572709; x=1703177509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9Okq7peTTsLcn5PM6r8lIiWCZPLBF0CABSZSykAA8M=;
 b=Ddzlnd63g5WhYoezEtIbDPu0INwMgsyZd9NbP6Ua6ZcRM2Jh+6f82m0PtNg583g34+
 aqt+tbL1JYMZiCA6i1+gvdlbLQr+kSaJZ9De6v9ZD1ykoTmD4Nayx3XrBPLHZk6AKhH2
 zyR7Ie2BEKYLgAi4MB4oR6ilityA2r9eJdJzHWhEo4mRMG8Gb6VSqfJoIS9H9DZvcUMu
 wUkoYGYlFvtiou+pNdVHF618DpNChkEzVtHELSqX1M8RA5Y5AtIVYwN++FKKuYgrGIee
 Y3dPkuXDuynqrDuC5THXIhtiyXtppVHJVCxq5j7nafJzLKc+mHdRrSQWt65tIxdPpZlu
 506g==
X-Gm-Message-State: AOJu0YwwtyUkZEJFys46Wn1smphHW+BB8kkHMr8YOxEsSgXj4Ed6WSez
 q7m2YXXPvjjKs2KnUM/xn8nwHe5EYYb9FW/QY7VRGQ==
X-Google-Smtp-Source: AGHT+IHivnzzJNMKW4XX116vk/Us3ngpGNYo/OmQPSFGPvbnMGLrp+/vDG0LoG1iXgT2Q38PHkcOTw==
X-Received: by 2002:a05:6e02:15c5:b0:35d:59a2:bd3 with SMTP id
 q5-20020a056e0215c500b0035d59a20bd3mr9188697ilu.105.1702572709385; 
 Thu, 14 Dec 2023 08:51:49 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 07/21] sandbox: bootm: Enable more bootm OS methods
Date: Thu, 14 Dec 2023 09:50:16 -0700
Message-ID: <20231214165112.2182274-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

