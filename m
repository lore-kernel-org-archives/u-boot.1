Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD2ECEDD87
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 11:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A61C5890B4;
	Wed,  9 Oct 2024 13:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JgccfPbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F84E88216; Wed,  9 Oct 2024 13:56:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D11E890B4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 13:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 637473F73D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728474960;
 bh=o1HdoP3cYdWfFiN8NMMFtTWEL5zReIZ8LkMqeaEav/A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JgccfPbhvB3zuPbc6+RvbiavwamuscBc4nKzmFfjfmnMDhgGN0NiCr8w6l0wzkd1m
 dVjouedvNmGhX1zwt+v6uULOMsC2vj1y/fvzzSasnrqCP9f4Tj089rhLfzmqROBlZt
 JVV73eX5D3Y4oTgSrv/CFri/6U3jD+3nb2cnqxN5OqfCjQqX7HjuXCiflhd2+E48mO
 i+oYGmB2DOf/0nbSQxmkYJGfVK3EU1h/IRNY2kZDUHFdv8+04aCek3gzAC53NmP07N
 qp3vBHuRKBtNXqtD76Y9pr5ZYJGn6gGw12lXqR8w6UYZxiVmG1BH+GOUJ2cOFNw3WM
 Nc0BIhARTqpBw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb998fd32so52541235e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 04:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728474960; x=1729079760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1HdoP3cYdWfFiN8NMMFtTWEL5zReIZ8LkMqeaEav/A=;
 b=J3R9Ler6zzt5c9qhQlpLKekUMB839Tf77EndprUqEUwt/XtIyYfrhl1IThbjICtvpD
 gr7F37CFWrUcoLv6Rk19DOjLj8Q/jXGIABrZmPUKBd9DtTsVdo1sDZa3qInY5XOWY6ca
 +W4mw1TxzY0XZZYb+yQXA7/UzN7tuv9ADQeU4olQppv4x1ZbYctwBu6BRLplhV8O4lMs
 6j9NDpipzh1AfGw47bIiqkjVTVbkHqxqBjNwE6b8NQ10k1WXnBZTKkSW0bMpl2pDSYgQ
 +ExkkUnavGLTZNZR7zvmhMEv7+cDCiZHjo0vNHvAHDfOGjp54zBdZQ3Rj6871izHUfMR
 Qq8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTvcbYUOZ9mE6MAru9bNydbodAbrS7okGmrsCQkP/Ni9XBEWl5sFRHtp+243p4ee5RctXRcIk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq+kOUcB0vREIje4v5o1llOTj7qgvM9CoER5njXoWblL541ztv
 GuNli3JrBYj5fs8YtRVUelhrb7ky9C9jDYCWc/Y9LfmUi0i95IINmLi9T78FqqU41xXUZPrhnwd
 nIDwm/lOzMLlVQh8yqQw7AV/FNBSJ6saoa7XhdOHr9uC2rYP/JAiTpL/A8z3GUQMcBIY=
X-Received: by 2002:a05:600c:1c14:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-430ccf09d61mr18711245e9.9.1728474959816; 
 Wed, 09 Oct 2024 04:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSsQTcErF6Vkhe1L38XkxaHPtQ3OBTbwQGSGzKs4f+bj0CHmEFC1rAhSPhIFrpkZUBNtlpdQ==
X-Received: by 2002:a05:600c:1c14:b0:426:6710:223c with SMTP id
 5b1f17b1804b1-430ccf09d61mr18710985e9.9.1728474959417; 
 Wed, 09 Oct 2024 04:55:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:6e0:2015:3f67:bd94:474d:9e87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1690f34asm10272726f8f.3.2024.10.09.04.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 04:55:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: Show the FirmwareVendor and FirmwareRevision
 in helloworld
Date: Wed,  9 Oct 2024 13:55:52 +0200
Message-ID: <20241009115552.31455-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

From: Simon Glass <sjg@chromium.org>

Show the firmware vendor and revision to make it clear which firmware is
used, e.g. whether U-Boot is providing the boot services.

The output will look like

    Firmware vendor: Das U-Boot
    Firmware revision: 20241000

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/helloworld.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index 586177de0c8..f9154386472 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -71,6 +71,33 @@ static void uint2dec(u32 value, u16 **buf)
 	*buf = pos;
 }
 
+/*
+ * Print an unsigned 32bit value as hexadecimal number to an u16 string
+ *
+ * @value:	value to be printed
+ * @buf:	pointer to buffer address
+ *		on return position of terminating zero word
+ */
+static void uint2hex(u32 value, u16 **buf)
+{
+	u16 *pos = *buf;
+	int i;
+	u16 c;
+
+	for (i = 0; i < 8; ++i) {
+		/* Write current digit */
+		c = value >> 28;
+		value <<= 4;
+		if (c < 10)
+			c += '0';
+		else
+			c += 'a' - 10;
+		*pos++ = c;
+	}
+	*pos = 0;
+	*buf = pos;
+}
+
 /**
  * print_uefi_revision() - print UEFI revision number
  */
@@ -96,6 +123,16 @@ static void print_uefi_revision(void)
 	con_out->output_string(con_out, u"Running on UEFI ");
 	con_out->output_string(con_out, rev);
 	con_out->output_string(con_out, u"\r\n");
+
+	con_out->output_string(con_out, u"Firmware vendor: ");
+	con_out->output_string(con_out, systable->fw_vendor);
+	con_out->output_string(con_out, u"\r\n");
+
+	buf = rev;
+	uint2hex(systable->fw_revision, &buf);
+	con_out->output_string(con_out, u"Firmware revision: ");
+	con_out->output_string(con_out, rev);
+	con_out->output_string(con_out, u"\r\n");
 }
 
 /**
-- 
2.45.2

