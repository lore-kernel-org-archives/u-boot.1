Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D208FCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7380686E0E;
	Thu, 12 Oct 2023 04:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gb6WWk3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5D686E39; Thu, 12 Oct 2023 03:59:52 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575CE86E43
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66cfef11a25so2689516d6.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075800; x=1697680600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up8zM5vYcSt5mZpHG7aN2sfP2VndAxb0B4KmNoGvH+0=;
 b=gb6WWk3bkaYhb9gukM4EJseWvdWSx5z251OX14RXre7B8YYQwnTciTSfcwOc4mAUnM
 Fht/JeWFbO0lpSn3bKfFLTqST8G2W97cfh6mjitxaccI3wCMGMKb6YoR8DOS448igZec
 jKXa6qZIMsyCKTgCiCoD7MPV8JpitUzAgnm+j+wzUwsxqp4wua5GM8K/actAS50Rhalj
 GxRaDhhCMvI0FQ/6HXRvoC3abeXQNrra6XWH68bmKKHUMg0ZUFgu9Pd43kJ5AeqvvwqZ
 /GoU/ycnnElYAknwLwz7wxlIBWVDjk2oY69+OHwTbbxCKI6G/NTZ6aztSQbu3WurQVz5
 WXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075800; x=1697680600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=up8zM5vYcSt5mZpHG7aN2sfP2VndAxb0B4KmNoGvH+0=;
 b=mP9SW6QIUEP2BS0XM2O6xxKq1T1cdA1nIj0zMOQp0WkSVzlA3Fhfp2jIou4d/ZGNZo
 Ifo5d6ZeKbm69bOZagIMsfEbVpX6fSj8fAb33IeJhB+URJzDDwTfqjuYMvUmXjd1vQOs
 9ybITz0b+1dJJhhByvCCFfMgkgPe3IweVqlcrtOu/Kv6TcD8/MJA2YsXIlrTbT8MfQAg
 yVe8SXDgUFcMr+0vPgQOCQCB3+5s8G5JQVWCjVSMVYw+yXWo9q8ZLUh1+4zVSIov937g
 ooUO6FDWoOQHjgtBQnvWq/fShyva4QStzAjzebPkJPQuNykSwdKG0Trm0pw6t33+2ffD
 8H2A==
X-Gm-Message-State: AOJu0YziG5IxEPk7mFCRU8txdhnvSZRErqH/GtHKTBg4LFJC0Ora4G1w
 6qpyvCIItIC9uMZsnb9AbkWH20PlaAElBg==
X-Google-Smtp-Source: AGHT+IHti1MsGuL37ZdC/zysWMXw6+aoDt+IwXLeZFmnQM16qD9Q4ahclOYe0YcsQgRD7/6MYqTHSA==
X-Received: by 2002:a0c:b35c:0:b0:656:3046:28ab with SMTP id
 a28-20020a0cb35c000000b00656304628abmr18465514qvf.45.1697075800380; 
 Wed, 11 Oct 2023 18:56:40 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 p17-20020a0ccb91000000b006360931c12fsm6128422qvk.96.2023.10.11.18.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:40 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH 10/26] lib: acpi: Fix linking SPL when ACPIGEN is enabled
Date: Wed, 11 Oct 2023 21:56:10 -0400
Message-Id: <20231012015626.3487451-11-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

lib/acpi/acpigen.o is only compiled into SPL when SPL_ACPIGEN is enabled.
Update several files which reference these functions accordingly.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/core/root.c  | 2 +-
 drivers/i2c/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 126b3140666..d4ae652bcfb 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -426,7 +426,7 @@ void dm_get_mem(struct dm_stats *stats)
 		stats->tag_size;
 }
 
-#ifdef CONFIG_ACPIGEN
+#if CONFIG_IS_ENABLED(ACPIGEN)
 static int root_acpi_get_name(const struct udevice *dev, char *out_name)
 {
 	return acpi_copy_name(out_name, "\\_SB");
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index d5b85f398db..a96a8c7e955 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 obj-$(CONFIG_$(SPL_)DM_I2C) += i2c-uclass.o
-ifdef CONFIG_ACPIGEN
+ifdef CONFIG_$(SPL_)ACPIGEN
 obj-$(CONFIG_$(SPL_)DM_I2C) += acpi_i2c.o
 endif
 obj-$(CONFIG_$(SPL_)DM_I2C_GPIO) += i2c-gpio.o
-- 
2.37.1

