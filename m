Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2FFC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519FA87B1F;
	Thu, 26 Oct 2023 07:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pZnjFIUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D527087AF6; Thu, 26 Oct 2023 07:31:39 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E29A87B11
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-51f64817809so54562a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298293; x=1698903093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfq1FrnLfG/WgO7sHG0nzAgt3mqwveg6HoTHbERWVSc=;
 b=pZnjFIUNcAImjxxvqKj+uMpo2bADd0aEjHJ+BXqIBXrRAkQD5Zq+Y/SBw+migZ/9dw
 78ymg7rNpqfuZN44U3g2MRugptlFwB/rILhFkzgwzmG2ItxlaF3b1O6O43VkOXAH4XHB
 2KCVNxgSUOKIFeVXwCnosC0eFzuPuwPwmINzpk9+kkXvuYzJQfrrw7FfDZWNVqnf/GWb
 Re3Kl1//vmN2t+3MCuFn33E44g5yZST4awy+viLW/8LE9OaoAHqnVX0bLt7seWv0BU+b
 0vmhNNAR6VxAKPmXd/nneCpJIgkEonuN6REb3Hwem/uk4jUjscONr0MHfDE3EEBgpsbC
 VgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298293; x=1698903093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfq1FrnLfG/WgO7sHG0nzAgt3mqwveg6HoTHbERWVSc=;
 b=FZHeMxh5D+tlVmb/VGOFEcz7nKjTi6MiCJrGOGT0kqRju7FjhE/WRz/VABDwbzMwvl
 Fdb5u4UYWjvOsmDO+08wrxCThYeQ6eqrfQo5oQkNfRCITf1N+qvVCvECqj4E3Us/9Zzs
 uBERC1GgJ1bVWaY4HLNu0gGLMhL48um1QT4cA/kMTts8d1lk70SiLmngMIg3fo06C8lc
 HciSRuYBcAh3tQeicyfeuX81T8qXS3AWDC+jS7VTLooQFYDe+47YGx3kU58jdF8LqdSn
 AROoEjJsfBabGJGPPKfYdfZQeHQOGqDTtfV9EWQNnkQjbii8vF98BZG5a7+bs2HO6fJT
 PWpQ==
X-Gm-Message-State: AOJu0YxlfdQC2svMjdMejW2+Nnjo+QGh9jC4t5PSATZ9Sxf+br0jDmRS
 aT39jtnIv6qTzhMqkcmqMtoZQQ==
X-Google-Smtp-Source: AGHT+IGA0CqGpBWZpbiI7XyTn4GeUSqTfVxN+/MahTG9+MIj0vWKVYChuYTzAsoOLq+AiUI25jZZAA==
X-Received: by 2002:a62:e816:0:b0:6bf:1621:ccad with SMTP id
 c22-20020a62e816000000b006bf1621ccadmr17729606pfi.0.1698298293464; 
 Wed, 25 Oct 2023 22:31:33 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:33 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 06/13] cmd: efidebug: ease efi configuration dependency
Date: Thu, 26 Oct 2023 14:30:45 +0900
Message-Id: <20231026053052.622453-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Now it is clear that the command actually depends on interfaces,
not "bootefi bootmgr" command.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/efidebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 201531ac19fc..c2b2b074e094 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1335,7 +1335,7 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 }
 
 static struct cmd_tbl cmd_efidebug_test_sub[] = {
-#ifdef CONFIG_CMD_BOOTEFI_BOOTMGR
+#ifdef CONFIG_BOOTEFI_BOOTMGR
 	U_BOOT_CMD_MKENT(bootmgr, CONFIG_SYS_MAXARGS, 1, do_efi_test_bootmgr,
 			 "", ""),
 #endif
@@ -1526,7 +1526,7 @@ U_BOOT_LONGHELP(efidebug,
 	"  - show UEFI memory map\n"
 	"efidebug tables\n"
 	"  - show UEFI configuration tables\n"
-#ifdef CONFIG_CMD_BOOTEFI_BOOTMGR
+#ifdef CONFIG_BOOTEFI_BOOTMGR
 	"efidebug test bootmgr\n"
 	"  - run simple bootmgr for test\n"
 #endif
-- 
2.34.1

