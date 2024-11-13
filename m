Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF07CD462B9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 15:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B63D895A7;
	Wed, 13 Nov 2024 16:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ewWQkR7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBCC989595; Wed, 13 Nov 2024 16:10:01 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA8189417
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 16:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a71a8d0fa0so1717095ab.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731510597; x=1732115397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sFfrLaG1NZ/oMHrC9R9TKZJ96hto7/aostfgQbg03o=;
 b=ewWQkR7CO1FuS42dLyTJCgEbMFhg9MLsVHgD1LbTenWwGuGUslwoVey1AgNUCwWB75
 q+BcVM0fZjbAkx3JevCU5gQbaywA1XvrQ7Rk/liC1/3c7wBIbJEncHqyMaOSeSQKIk1P
 wk2Qkp/8I8LRENEpHfIaZMbw38xuQLdy5kK58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731510597; x=1732115397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sFfrLaG1NZ/oMHrC9R9TKZJ96hto7/aostfgQbg03o=;
 b=iPv9l4CcxOaa7Ig6VdzLuFyI3Jxc80zjU8sZktGn1UH6+DnD9BSOw5203R7kEaVflv
 Ij5HAtzNJaoJqvXUzd1Y7zyNfn+tsJW/CW37Ro258Gm27ew7yd616gjmQAW7BHZ0w+cB
 Y2VnsIKeCofFjj6U2vokSv8D0/tfZtXtDPdWBLXkkB7cSfWidinrsDLHTwGI13Rm/FaM
 8dh/EqOmzvWF1ZiSBHjBqXJ6o8tCqQogCmUcH5W2UqDZhkXAGdRyJXMV21DjzQQp5E+U
 x2Zd/kOpKZ71NSKMmH+NdBkIy4loEFAbWuDMy3FQZpHpx+vPW5kZk4t1UiSzxIxb9Ldc
 /jgA==
X-Gm-Message-State: AOJu0Yyvtr+BWjAUksIlKy5Meorfx1MxIqb1J29VV2MTb4Sw16r5Eri2
 1z3lla0ioLi7GkoL6b0XKDmfcesWuIN0uCPbuR/nnAsfw6mDfDp9OzLgqkK8v3W4YKMmCoSWokQ
 =
X-Google-Smtp-Source: AGHT+IGLaqsV35Qas8kv1vd0jCu9dkukx6p/+rTgXaJc//n7jGxMIf0n53LTNbK42WC8Opr8/Frnhw==
X-Received: by 2002:a05:6e02:214f:b0:3a6:c023:7e35 with SMTP id
 e9e14a558f8ab-3a6f19a00d7mr217700885ab.8.1731510597020; 
 Wed, 13 Nov 2024 07:09:57 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a719d6b62fsm2710105ab.18.2024.11.13.07.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:09:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
Date: Wed, 13 Nov 2024 08:09:33 -0700
Message-Id: <20241113150938.1534931-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113150938.1534931-1-sjg@chromium.org>
References: <20241113150938.1534931-1-sjg@chromium.org>
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

This causes problems with the boot order, so drop it until we can figure
out a better way to know when bootmgr should be used.

Link: https://lore.kernel.org/u-boot/20241112171205.4e80548d@donnerap.manchester.arm.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add new patch to drop bootmgr for sunxi

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index b612360ca55..42c5ed288c5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -583,7 +583,7 @@ config BOOTMETH_EFI_BOOTMGR
 	bool "Bootdev support for EFI boot manager"
 	depends on EFI_BOOTMGR
 	select BOOTMETH_GLOBAL
-	default y
+	default y if !ARCH_SUNXI  # Temporary work-around for sunxi
 	help
 	  Enable booting via the UEFI boot manager. Based on the EFI variables
 	  the EFI binary to be launched is determined. To set the EFI variables
-- 
2.34.1

