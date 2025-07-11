Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D126FC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F0B82F14;
	Fri, 11 Jul 2025 17:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EmdBotsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE5782F14; Fri, 11 Jul 2025 17:16:03 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD69882AE9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73cddf31cb2so628009a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246959; x=1752851759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2oxyQLjDTOH12DnWhglgF6kadcLvnqQ+Vd6871KcPQs=;
 b=EmdBotsJ4wULMatwVu233df533slowt9YijA/gIPhchwQm40N+vMBf2FkwUVTGkdiN
 5aVoxA+UjPfNKFCGj+AK64dLapJ6OW2NPondHIcBcu6rxXxyBZnsraT+cVbLF/cVibYt
 Rv+zXupefmfTeqgF1IQQhJQyt2gNkEEeLRlIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246959; x=1752851759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oxyQLjDTOH12DnWhglgF6kadcLvnqQ+Vd6871KcPQs=;
 b=cEhT/78y2/x2fA5vpe4zps2xB3gIx5B48bcr97v6o1/TSQ3MNORDgi4Az5U+J5WBNP
 k9tXZTlG46Tms8+9QE+C9uVh0tNc/JKHPF0fm1tJ6xtfHCurQ/+we3dLNwjr+QjZaFpl
 9NNpr7V8IHCabt/LPyUdniSHoRp9WLKvuepTH+CEbENA9sUZRgGVFfqblcCNGxOX/TF/
 BDETNXe2G0/GJIJ7GCSPwBMAAqVEM8XTrMGuwCWxQKqOJ6nOKpeoAmZQSeT9CkD1iLrV
 jdVHIxXsqNhYGvdVNhGijdRE3dwlatbn31VOMZINlam6A5XYqL/JIcTXL0P818Bld7+u
 b/jg==
X-Gm-Message-State: AOJu0YysyLgfRD5WOlu3fYRP4nxGdhuPXUK/v/KuYaiNnOmTm4sPnFlc
 YtAGIzL21lDq8szmKfwpnTvRxy1xQBFtfiWGD6uA+5LjLcPoV3ur2lbG2W8Xm8W+5KmpNlZeDSx
 REhIXvUQ=
X-Gm-Gg: ASbGncspZDG03s80pX8qWtAl/zcjQPZqwSZik95bt1WJp8A9gHefaFEHlnILOOEZskB
 yneYgH7DF2Eq4sL46kn3JPgv81qUw8VAXPtimgyWl+7/IBC1+1YUhCWXqM1N2rH8/vmcBy8n8V7
 sTl/ThN7ua5HTaWElY9fwJPOUpHhK2H6rdl2Q8OTuV8/hRha5qkGb7VuCE8BM3dSEoVghcTu9oo
 IUcaio8mszoWZVI2QKngGrG5HeklZxB7XFyoNSw716t1GYrKMh9u5cZc4BeBUAQfnUdFxQYRk4a
 kpMW1rIwXVf2fAfuDURpdO4f2xW0IVk39DhRJ4F8Y9pW+2WdUhqvPnmkGX6TNQ9l8LgUfAGNmkm
 jdQb1mKMDSVpjNhtU0tx4h4UIqGea/KGRb73d9B4lll1r2sRnWcF62jsnMOY=
X-Google-Smtp-Source: AGHT+IErliXFS13tbA0qPJJcjeQTgsrzySeufPTJ0fUX+Vja7sumDDl5ddkOWAuHIS7V6Go5l7raoA==
X-Received: by 2002:a05:6830:6c8b:b0:727:3111:1416 with SMTP id
 46e09a7af769-73cf9f28a0bmr2453284a34.24.1752246959337; 
 Fri, 11 Jul 2025 08:15:59 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064954sm581904a34.11.2025.07.11.08.15.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:15:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] mtd: spi: sf_dataflash.c: Make use of 'z' for printing size_t
Date: Fri, 11 Jul 2025 09:15:57 -0600
Message-ID: <20250711151557.2224209-1-trini@konsulko.com>
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

When printing the contents of an size_t variable we need to use z prefix
to the format character in order to get the correct format type
depending on 32 or 64bit-ness.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/spi/sf_dataflash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi/sf_dataflash.c b/drivers/mtd/spi/sf_dataflash.c
index 438eb3698d5c..9094e008f60f 100644
--- a/drivers/mtd/spi/sf_dataflash.c
+++ b/drivers/mtd/spi/sf_dataflash.c
@@ -138,11 +138,11 @@ static int spi_dataflash_erase(struct udevice *dev, u32 offset, size_t len)
 	memset(dataflash->command, 0 , sizeof(dataflash->command));
 	command = dataflash->command;
 
-	debug("%s: erase addr=0x%x len 0x%x\n", dev->name, offset, len);
+	debug("%s: erase addr=0x%x len 0x%zx\n", dev->name, offset, len);
 
 	div_u64_rem(len, spi_flash->page_size, &rem);
 	if (rem) {
-		printf("%s: len(0x%x) isn't the multiple of page size(0x%x)\n",
+		printf("%s: len(0x%zx) isn't the multiple of page size(0x%x)\n",
 		       dev->name, len, spi_flash->page_size);
 		return -EINVAL;
 	}
@@ -229,7 +229,7 @@ static int spi_dataflash_read(struct udevice *dev, u32 offset, size_t len,
 	memset(dataflash->command, 0 , sizeof(dataflash->command));
 	command = dataflash->command;
 
-	debug("%s: erase addr=0x%x len 0x%x\n", dev->name, offset, len);
+	debug("%s: erase addr=0x%x len 0x%zx\n", dev->name, offset, len);
 	debug("READ: (%x) %x %x %x\n",
 	      command[0], command[1], command[2], command[3]);
 
@@ -287,7 +287,7 @@ int spi_dataflash_write(struct udevice *dev, u32 offset, size_t len,
 	memset(dataflash->command, 0 , sizeof(dataflash->command));
 	command = dataflash->command;
 
-	debug("%s: write 0x%x..0x%x\n", dev->name, offset, (offset + len));
+	debug("%s: write 0x%x..0x%zx\n", dev->name, offset, (offset + len));
 
 	pageaddr = ((unsigned)offset / spi_flash->page_size);
 	to = ((unsigned)offset % spi_flash->page_size);
-- 
2.43.0

