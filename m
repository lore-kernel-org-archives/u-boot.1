Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97818D42B82
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3012D89431;
	Tue, 12 Nov 2024 14:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CXBHgX1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2982D89452; Tue, 12 Nov 2024 14:59:41 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4F189430
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83aba237c03so229403039f.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419977; x=1732024777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=meZSkW/KpZC3yrnqAzdQzJHpxuq2GB8ec6FamATdohQ=;
 b=CXBHgX1bNdcH/goAEIuJC0/6ZN+/rTda5wMwVOdWAFgX9OuWSsBXKidI/c6ToPDand
 gt4h4bu/Cea7aV27kDktMAZHF8zjHjjFdWQkZmqBtDFXTdSiowtJDXoya9JqQfzM9V1b
 lfd4UtxG3xITf1LymXh+tmaLPSPocvSI0nfII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419977; x=1732024777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meZSkW/KpZC3yrnqAzdQzJHpxuq2GB8ec6FamATdohQ=;
 b=STrXL3weAND9/4yWRRESbmSEN66RDwCaCuha6Rl1DQqjB/Z8gSaGX3xIC5Wdpu3AlE
 6J7SnNZpWJLPFumLDXQzH9rdtSHP6cv5iId3B41I9cFqflfyj3uX6Dl3EgAj2sQqQDmQ
 hkz5+oc5qYKP8wJtu5o+YO8hw10yQekV8w+ZqyCuAroSJyIX6lUbJupyz2vlHAceylnb
 bJns/Pa1AaYFUFmUmn+yXEnwO3ft7LWogL21BDB28KiXBDX5jr4LP8mqnJbHUZlUfRXh
 9JPmwrh9TLH8wUINYIMS8VqHJEd1Q+L5YD9TBGo2Q4SZbDg7YMLEjKAjF7huq0aW09ZM
 NdZg==
X-Gm-Message-State: AOJu0Ywk9gDGNDCKTowEcKJEHVKCCi8hhyNd9jQxJ9LcGN5iG2+CZYdp
 ZNXKrGvf9aDZ96U5YmdkBAIpU7UKbdhoIbUu9uqj9Nmy2u/hLsarYM82zJNpYljnBSUsnVn3fw4
 =
X-Google-Smtp-Source: AGHT+IGGnulNLd2O+ik74tJVc8S+m3d8DlVrueGb4U5VbLkVCda7IZb8VLCIneqkZOwTyIGB0IAFtw==
X-Received: by 2002:a05:6602:29c7:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-83e03068fe6mr2057497739f.0.1731419977025; 
 Tue, 12 Nov 2024 05:59:37 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH 04/18] x86: qemu: Enable dhrystone
Date: Tue, 12 Nov 2024 06:58:57 -0700
Message-Id: <20241112135911.630586-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112135911.630586-1-sjg@chromium.org>
References: <20241112135911.630586-1-sjg@chromium.org>
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 1670c122002..151c5f3e0e7 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -87,4 +87,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 40c2f1cd362..5c5cacd734c 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,4 +62,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.34.1

