Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BF8C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 07:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DD982D2B;
	Wed, 21 May 2025 09:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKffKuY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C043482D2B; Wed, 21 May 2025 09:22:06 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C1782BD6
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7884so4416702a12.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 00:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747812124; x=1748416924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qS/euommI8Y+G6EjXa/MkX7zl4Kl1znovNR3oZHFO2U=;
 b=EKffKuY7hRv4yK3vM+UUfNg2dPrA5H9vbKJ4cwIo8Iz/PBfUh7xo/D8vBNNf3TpOOn
 I7Pf4bhTZEAlIlFOXoN+Zt3nI440Mot5nIAlePZtkxM/2aE2gv3F6J/iTDkR9KrDxltL
 WGRfKJ1ZPE30Id9tkbXpGheJG+z/mj4yFCjurCWFgCtwm6yfesftSdZA5VTLBnEFkJZC
 HNfoTTew3I4jZWe5WgfbYfhBq0DfTuzUvwosUsQgPL1BPk2eqn2Ei7X7mNMTg3+yD+D+
 r65kXg4wOzQYQxUt08v5OOMFfkaY/YSPv5Sf5bLwtniNS/yYZQBUuJfRELj+yPPUspuU
 wjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747812124; x=1748416924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qS/euommI8Y+G6EjXa/MkX7zl4Kl1znovNR3oZHFO2U=;
 b=aoYzecZD8G8nWdYUzuWSlSMPAETJD+oy8aXg93JMhxpOz5coBL+0AlIE2PyCjh/zG1
 EBFBJ2+U72WmgmIbgQtb1GV9bTc0vAAnc4Fkcv60Vbxa1jWybYDuPU9oTTVqpfxvxm7+
 xdksQaWIaXojFtBzg7mBDTWOZHO5g9j9BmVfVyCgysDCsLEztFM1JcRIyYfRZebvGUkz
 VUQ+kC+e/cdtUE2U4oWc5Vjs6j5jdcX5fr8XWKIkhCQNve1+qU6CT6uzIn3SnF/va6j5
 e1MEbq6bQb74kyR35ntg+cuc3tqLaC0J7s1uaujTZLUAvhWf/Rk1HM/gqRA7ywyB3iHS
 ooew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtb2Y8tvnczs8moBr2QRiZthCgr+Fuu7IHkRij6ubN3HvGhYIJ90bzSdNateFFzXNBohd6XdA=@lists.denx.de
X-Gm-Message-State: AOJu0YxkRKy3lik6kxCUSPtv91dAMO+P/K7lk4OfB2t0ngNQrYenEtUd
 AZDnXhLo7LxxSvvNzJ+xCa5/cTni+uF5qGbQ31fJI9lngk5PoYqBXbDe
X-Gm-Gg: ASbGncs3J5JHWCGO/CwRzp1nGckuk8kt7tlfliiuPsqj/Aih5n1Ekahx8mKl+fMcUmj
 W2FZH+6gLpMcvJEIfsuCGzYmVUtu2bYuTggI97FifAeZCxjqFghV71CsjezHyGcwi6JSCoiT7+5
 SMeIWGY6P080JALoTpYcJMCs2dinZug5sMdiJmRFqpuLF9aCDyKXjWLaGQFms2vZ1wEWmFRkHr8
 glvVf4cjroS012rSexEiZUuVsGfeWtdoOZqiMtmrqDcvx7icuqYSE4RU1zYE4oj7B4foiHZ4bqy
 i8ziUQ2CM7F9MRl+KVslqCydHB6psCYcrPY/mfmqx6L2zJu7CAcGTS/hieJt7r9vIrVfJMMVooZ
 RGx9L0XFV8jsCGBgqmKvB+esU71x5RdZ9NtZ5t+a0YuHrbH0oUUQJzzSZenQghq28bgQ=
X-Google-Smtp-Source: AGHT+IG3EadjJGjarvTX0j6UH4M6XOmm1ZSdn5+YWBdlZlpdxpSHHrGAWJpZtQQILrN/il2wwEB7OQ==
X-Received: by 2002:a17:907:7252:b0:ad2:39f2:3aa8 with SMTP id
 a640c23a62f3a-ad536f9d574mr1808755766b.38.1747812123960; 
 Wed, 21 May 2025 00:22:03 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d278290sm849926666b.78.2025.05.21.00.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 00:22:03 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Apurva Nandan <a-nandan@ti.com>,
	Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1] arm: mach-k3: j784s4: Call do_board_detect() before DDR
 probing
Date: Wed, 21 May 2025 09:21:43 +0200
Message-ID: <20250521072149.21007-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Call do_board_detect() hook before the K3 DDRSS driver gets probed.
It will allow boards to adjust DDR timings in do_board_detect().

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 787cf6261e42..4e9f823072bb 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -242,6 +242,10 @@ void board_init_f(ulong dummy)
 	int ret;
 
 	k3_spl_init();
+
+	/* Perform board detection */
+	do_board_detect();
+
 	k3_mem_init();
 
 	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
-- 
2.43.0

