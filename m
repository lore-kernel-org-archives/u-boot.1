Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4CAC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5576787D14;
	Mon, 17 Jun 2024 10:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ECKgicm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE6B087D8E; Mon, 17 Jun 2024 10:17:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3E6878ED
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE1213F131
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718612224;
 bh=a+AbFAzKJSxqtzE7JJMz+Scyq30uX0hIJ80Tr3WJXvU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ECKgicm3L9I1faHfSaZ+KvTQ1ZuzgG0yTGQDIrja4+jOFEA+kjMp3hsuq5lB8HPH5
 Spm3XcV7ZgZA4AThOl2k9KCsCDfWRWfOeGKCe1IrIfB8fVEdHcBIAExFdFQ2uOCxVm
 RNIzISwUROLmJuw+SC4FIBUzBqyGX2lYBXmNS4SCySBiEmtzfiPsK4Bh+b0IJsa9hn
 F6YlMuinJBgKJ+z2Az5NKAQ58WvkhWQ4M7XrmOL8PyT/NjRx11za07wzl6m1ha+AIO
 5lMXiTTHzI7vOEYO2KmAJUXki7pZQ6TZfKA0awQ/zsv8meqyFiSL3TvJ7slWffgf//
 HFfh0z97YUegA==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f0fee1f49so225873566b.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718612224; x=1719217024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+AbFAzKJSxqtzE7JJMz+Scyq30uX0hIJ80Tr3WJXvU=;
 b=vH0LoS8Z8ChqAbJPcVlQLMY3k6MjU4/oPS8FDEvWJ4TqGgeDOkIDHiYFZU/PsBIDhR
 sOz9nv8DLebRbEOB+6rHJIZtNfcuhHGcwztIOXvaqCULYaEfvukPy9pWTWRDT+1khH12
 EQWJnTF2Pit5lxvIls2TDyIVo54ASu9eMRnMorxv15paqqF908suGvxaM9DsqOXEYeFG
 FaU0TWNKDXt1rr773EL6IuUl6busotQanWYol0LBKr4lELYKUbOCP83KL7D/PplYljU+
 M7yb4h86Xvmt8N/2G0UOCMcELtTSScaNvrudhPLGXMdYqKRpLahGoySS5uQ3akoBeW4A
 kbjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNSqcy403gcrcplyPnlfBCmJfIZmibaG3mzCqjwzPRTKgxIpQ7ibNTRqn2xBbukm+qxZuAkYjubaSnf5G3oZm85IngpA==
X-Gm-Message-State: AOJu0YxoGpmTZUyUWljEwQlCsw5OjTe7R4iePmdR66kRoEZSNZsA9jhT
 aoRMKaQA/Xq8U7QqNBXmNGvRjxVwi16sfSbQ52TTOeZZY+acX2ux5IDGwp/zha+Xy+XlfQEvGtk
 TZYIprNkk1cMMsgceSO8y+yL3ILVwmj/0wuOrQxvE6JQNFR/ejeo8wMqxJ0W2sX+mbrY=
X-Received: by 2002:a17:906:b0d9:b0:a6e:f8b9:361f with SMTP id
 a640c23a62f3a-a6f60d1d1bamr571932166b.24.1718612224616; 
 Mon, 17 Jun 2024 01:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOgHCyo5bajovP3/1ibYk0J351SsD7yGL8GVb1OfhdPQaRzIlVIGfMByqZPkkrFTMLy3IHCw==
X-Received: by 2002:a17:906:b0d9:b0:a6e:f8b9:361f with SMTP id
 a640c23a62f3a-a6f60d1d1bamr571930866b.24.1718612224176; 
 Mon, 17 Jun 2024 01:17:04 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36098c8c596sm1071895f8f.14.2024.06.17.01.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:17:03 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: informative message if no controller
Date: Mon, 17 Jun 2024 10:16:54 +0200
Message-ID: <20240617081654.74294-1-heinrich.schuchardt@canonical.com>
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

The message 'No working controllers found' provides no clue that this
refers to USB controllers.

Provide a message that refers to USB. Use log_info().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/usb-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index a1cd0ad2d66..e16432a1516 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -388,7 +388,7 @@ int usb_init(void)
 
 	/* if we were not able to find at least one working bus, bail out */
 	if (controllers_initialized == 0)
-		printf("No working controllers found\n");
+		log_info("No USB controller\n");
 
 	return usb_started ? 0 : -ENOENT;
 }
-- 
2.43.0

