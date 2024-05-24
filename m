Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A972C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BCD888D9;
	Fri, 24 May 2024 18:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bI0DP0Tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33CD88640; Fri, 24 May 2024 18:22:28 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C538866B
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42108822e3cso5593685e9.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567744; x=1717172544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdzXC49XiXlNi3mFqaZsgVg+eyG60zpTDzLw8C3mfyw=;
 b=bI0DP0TpuosFfZemp0hKoUfgSB+K3fdnb6CnklJvtmQdly4PVTNOTSPcUFpD9DFspF
 +9NpgVdhBdpc5VpetKp0C0UvQSZ1YoFNLWSVc68QlphNcFNytdcwX+d20GwOmPKemQIF
 7FWAIfnN8cXoYmZyR/TiwWXlb4UW4GGKg+izFdTTHlWrYeBW7wXa+a0RF6GxrHIIkHiW
 PM6ydrnPA29Bn7BS3aGrPYExMPkXf0INUUItm8QwX/7sX6XJKbErMhwF0e+iu5OZOgpV
 CePbvyY5DoRaLqVgP2TM5wkuWJWAysqH5DduBSdLfArENZUK4396CSPuExJsoBjONsUr
 bElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567744; x=1717172544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdzXC49XiXlNi3mFqaZsgVg+eyG60zpTDzLw8C3mfyw=;
 b=MLBbmdOFoYj0ybqBvCRNUFjGesfhOPvUXK5ndKxQM/bYWp57CRDD0EgZznXJnf3oKD
 10K5gaPicCNvGsypLba6m+GK6gdKBOWn8XCjd+ALLLq8VZTmIFpMGY/NYzqLvl+2pLdy
 LVOggoiW3wlW+eRwNamBo+OIBqr/H17OkZHr1DQ+Sp9i+0akceXIssCIofM24w4omyJP
 JPii3WAqYUmlGujmcRrJbajU1Mojni04CJcWKpsql8Wmp9H2AbJTd4Ja9omYgYruQPvi
 rladDZ6HU+EM8bUBqIkeCsK1NyqRwyfJxJIJUKG9Legku/WiiA1YXJ1ri+64J2/jXebx
 vB2Q==
X-Gm-Message-State: AOJu0YzsmbDDWm6nGI8Wg4B36R2MM5fC4/ziHh4UpRRfCe14rN4a7KeH
 FW7Bl5FUcStyyinWIolVcT7HKN+YwmGT0Z1iIub+DOpOjh9Z/VZIduakn/LdRAWZ4y4Dza5eWSL
 Z22OXosk6
X-Google-Smtp-Source: AGHT+IEO5t4IY+vwz+KLuI+p/iC7/TBIJgELpxHBIBUhsvCtucX3bJwNOlQ4Otj/bOGcHwy3VeMobw==
X-Received: by 2002:adf:f805:0:b0:34d:85f4:9485 with SMTP id
 ffacd0b85a97d-354f74ff703mr5387477f8f.7.1716567744203; 
 Fri, 24 May 2024 09:22:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/14] configs: add qemu_arm64_lwip_defconfig
Date: Fri, 24 May 2024 18:20:05 +0200
Message-Id: <b32526607658b4ba1fb5be17e95257b8c7e809a8.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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

Add qemu_arm64_lwip_defconfig based on qemu_arm64_defconfig but
with NET_LWIP instead of NET. The new file was obtained by doing:

 1. make qemu_arm64_defconfig
 2. make menuconfig
    Select NET_LWIP
 3. make savedefconfig
 4. diff -u defconfig configs/qemu_arm64_defconfig
 5. Create configs/qemu_arm64_lwip_defconfig, use #include <> to
    inherit from configs/qemu_arm64_defconfig, append
    'CONFIG_NET_LWIP=y' and '# CONFIG_DFU_TFTP is not set' to reflect
    the diff.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 configs/qemu_arm64_lwip_defconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 configs/qemu_arm64_lwip_defconfig

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
new file mode 100644
index 00000000000..050c93ff97b
--- /dev/null
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -0,0 +1,3 @@
+#include <configs/qemu_arm64_defconfig>
+CONFIG_NET_LWIP=y
+# CONFIG_DFU_TFTP is not set
-- 
2.40.1

