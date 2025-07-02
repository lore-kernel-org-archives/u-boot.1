Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E376C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D6F8304C;
	Wed,  2 Jul 2025 03:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OOANgR1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2901F8304F; Wed,  2 Jul 2025 03:05:14 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CCB82103
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c13802133so1282934a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418310; x=1752023110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=66G9fapzJ81RzS5tUAj0Zga0dRUOr2GyeBipyhRq3yk=;
 b=OOANgR1Yon7onXwPGPGz3Pc//6tbxTEgV+BkHnozAFHU/gQKeoNZSeqb5l82z8sSRB
 uhlRX9ozxesa3sR8HxuZykOvE1uXPtkNlQQB9AljJrmoHfyh91GZw4AZqQVwxofJRCp0
 OZ8+jR/l8fBDNAEvg7J60LLmOwLlGzaRQPHmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418310; x=1752023110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=66G9fapzJ81RzS5tUAj0Zga0dRUOr2GyeBipyhRq3yk=;
 b=t4ivoTLmvSclczqeD22+xO5nqHAOy5R//YnPJDdEuZWsOS1hLrieByDxUAq1jsHUQm
 wHXvkmfBpUwPWF303L86oci8LbVur/+MGbdIX0QiISxO5z34LNVkdjA5oJ028EiONmVh
 fg++HKNI33kBHGjmvxLZrj65OJqGxYpOkWnxCCU75Jnfn2r0sb3z/LUwEvXD1tJm0TrV
 +4zMRoFJ+35w2cY+fnJqL+kI2F/hvLJpfjCB2rknDK71UKRsSxma67NFN6tAgYkVhFFM
 da+j6tJ3tUh7ZkSlDudImByDjSXM0viz2X/Vo7ZWiZripD8qu5BeZs8nYPbCZ1aR3s0L
 K7RQ==
X-Gm-Message-State: AOJu0Yytf0cZ9EZzhKOEjVJvJyj7QHx2diao+47qlQ3xSzuIMn+3k4Y0
 4twyTC3VU5YzTDGsGRlEZs1YAF59sR0Vmh9JERzzV+VNvVvBMhiTUdzvSMkMF2mBC+ghw/9K0Va
 l4enzj14=
X-Gm-Gg: ASbGnctqDW52KdTPpCDA8QdgQUcE8wk4ECZ5PiZZpqj8cNevkxU4ER8bqkYoPfJ8/Kz
 KcF1DSGBZD/RVYQQTiLKp5kv5ml6aiLn9hqIP1aYQLGmhoEXFMcqs7MfuAMEmvpodptv6VlGvwv
 D+dRyYryKjVMYVR5v4rJnVc/FXhTqlJJfe/TSnu6R4Imy1DtJRbqjs/qJqkGXH1EnJ1llbjgaIB
 BMtoEAzcMMamlMZGGrR/keO4duKflMG5RL6uWXec8uE+6k1A0Oo3JD4/4wgl52QnogWkwoh1z9c
 LvrcyrTz3D+d/HJJCCy6KX1OdZAOyAcFKCzL2XaE2h/43PXfE85nyngdSzFA6QvMtOpjoZ/fWvX
 w5ZRy8Wl+nfW4GMXZYNz5+VI=
X-Google-Smtp-Source: AGHT+IGc07dPTE03xtO/L73mS5odDruFybYtELRgpJLHcVUaFUXf5BeqQYN7i3MXpofC0FhzP2qBGg==
X-Received: by 2002:a05:6830:71a1:b0:73a:6d48:dec9 with SMTP id
 46e09a7af769-73b4ca330e0mr894962a34.4.1751418310128; 
 Tue, 01 Jul 2025 18:05:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e338esm2327406a34.40.2025.07.01.18.05.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_SEAMA
Date: Tue,  1 Jul 2025 19:05:08 -0600
Message-ID: <20250702010508.19124-1-trini@konsulko.com>
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

In order to build this command we need to have configured some other
board specific features. Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 89f102855b0f..ceaa86643cb6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -407,7 +407,7 @@ config BOOTM_RTEMS
 
 config CMD_SEAMA
 	bool "Support read SEAMA NAND images"
-	depends on MTD_RAW_NAND
+	depends on (TARGET_BCMNS || TARGET_BCMNS3) && MTD_RAW_NAND
 	help
 	  Support reading NAND Seattle Image (SEAMA) images.
 
-- 
2.43.0

