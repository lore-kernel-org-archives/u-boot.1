Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1526086DB1;
	Mon, 27 Nov 2023 14:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RTgXWZ5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB21687768; Mon, 27 Nov 2023 14:01:21 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D2987762
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50babce6ff6so2129053e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090079; x=1701694879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRAlY0o1Z3yewjm+0wrKUc0H6nErL27nIXl54G7S/rQ=;
 b=RTgXWZ5IiX1EnAbiihd8H6a2nWUUG+TggVBEXl5GKvuHO8nXUvcywcpWHKI73HapWW
 1T5riYG2aP/I8d8rKaDQqb0Mq2ANHTGJHluzNn1StLR3QVXWDlP6ZhWN5aBmW0/wzkux
 dMPNMkzLHFg1t3Ub+p+CkETcaIA7NmUxBwR75aY+jmf59C0paySKrsEysYbnZ7Vjrfze
 DlLj9NWRr8cMC6HdW4AGz5pdNOY+RM1QW8+wwdEfagnb5ppQMYWXlJVk5K/WD43OUDjy
 0JRNcENXefoQIwfVoKVaOEtGUKYOSOuFPJ73Lwcw3g1pi+nT6deWc2evLGXJDjAeCm7K
 Eaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090079; x=1701694879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRAlY0o1Z3yewjm+0wrKUc0H6nErL27nIXl54G7S/rQ=;
 b=UKqFDsSuKy2H4TQf2AoS+75d19nokNuXJJ+GOVnCYwPykCmAVajG0uA+EiEm3712+Q
 OlQJ/XrnWrKpStBevufb9Z5gm209ri2vw0emOk1dXCLAhqCrT0hLBjCfR9UWhoLkefj9
 Zk+99PPCw6dIlcgWHIRjZ2WOLcd2u4ESftMYkka3kKhCht/XnOJt3OgFHUkRUFUrKt/o
 jVnB/E2RGkGIyOOyDIj4pA6Zx7s0Em2rgmoOWpEDfUtsSqXSjjkrwNwKAnz7zOlTUSUS
 j06Kb6Ht7htK72zQMWuUm/9cU/sqzphM4mnQK54e3NPV3IEEGaJE70e82UaGQaPXzL0C
 C/zQ==
X-Gm-Message-State: AOJu0YwUJQAM4YcW/5ZlfL5gUzbCicE1ZTlQmZpHJtl0HUdo4WSQOA3F
 CSuoHxg+xjZH2zoPWNGliH9nNUG2aWrrrNhiy+x5zg==
X-Google-Smtp-Source: AGHT+IE6BECt3ZI7H0XCMIw6IEZsm97oBtlUv0gBxSbMsAyLbNVKOlbIBmM01GcLep1jLDaeUjRJmA==
X-Received: by 2002:a19:ac03:0:b0:50b:aa2a:23e9 with SMTP id
 g3-20020a19ac03000000b0050baa2a23e9mr4348926lfc.17.1701090078948; 
 Mon, 27 Nov 2023 05:01:18 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:18 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 30/43] configs/sheevaplug_defconfig: enable LTO and inc size
Date: Mon, 27 Nov 2023 18:57:13 +0600
Message-Id: <20231127125726.3735-31-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/sheevaplug_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index 2e4901b840..c0b256f3b0 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -17,7 +17,7 @@ CONFIG_DEFAULT_DEVICE_TREE="kirkwood-sheevaplug"
 CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=524288
+CONFIG_BOARD_SIZE_LIMIT=543744
 CONFIG_BOOTDELAY=3
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; bootm 0x6400000;"
@@ -72,3 +72,4 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_LZMA=y
 CONFIG_BZIP2=y
+CONFIG_LTO=y
-- 
2.30.2

