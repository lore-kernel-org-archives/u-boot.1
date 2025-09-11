Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AA4CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 21:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1208346A;
	Thu, 11 Sep 2025 23:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rh+n9X7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0933283429; Thu, 11 Sep 2025 23:54:24 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DF883438
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 23:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-88776dcac7aso48300639f.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757627660; x=1758232460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8enrJs+zZ4ZeOKbEUsdxg3bgf7A4ZkWchjs9/Fw7Lvw=;
 b=Rh+n9X7Ui8aJv66JgZCRj3OoqkGoEweTjU5D6QVeihix4oHxiFArRBr/t7BkGS/LaA
 rmdqY+hrEda2a3m3Eybn+7ltVxKq7v1AaGXwQVN+Qj4m7+BMTdXgJ+RJ91Bmt1jFzWsW
 SlmO+vkb86Zx8FK1Rx/UdggdJFD7nREpwT9AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757627660; x=1758232460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8enrJs+zZ4ZeOKbEUsdxg3bgf7A4ZkWchjs9/Fw7Lvw=;
 b=PzFmIQSzYXWur70zR3Xei29t5plDW1NRmQqm8ywoEJQhYN2p2ETta+I/EjsfTVFukz
 qqgqzZ2jzKPwY5mzzEUjn2wtbwV95DbL8P1RwZsWB/ej41HCLVUH3BM3U8P4spbkIQKp
 fRE+l5d9F5xxec5/U13vLFO0rOZR2XTxVlb1LiE12ofbs2uVIKzcOTQYfAECKGq96qDj
 HxHMJZ1XlcozJSL9NL+UbOso8fdPG8UJYwQGf0X+VFst6PCtR8t5Hb3HtY5a3W9Rqo8z
 aiXDv88y1osI8JlUwpN9dW+uvwvf0eU9ykNqV6UUERK/W1Ta8AHuot4wbkGLqVIH5INq
 /1NQ==
X-Gm-Message-State: AOJu0YxKotEKnJYAzQBFHdBmlruW3e3gqdim6HjfpFXOeizVMxpKbM2J
 CYoYOJVJn4k23d3NRUfCwOJ4GWyWypEApPyESwyO4EvebWxbYCms3SfuKuCCN+PZrUUur/4ho1t
 0+FaXvBY=
X-Gm-Gg: ASbGnctFKEK73KW1S033Fl1QbluwG1pTQv+OsL+eu/w+e6CzxRWGUqcz6wKyHVNY4qC
 SSafVJv3nj3R8/oAkKG8A+oyQyDEaqm0NtbvZDMhBaB3nNCD5TkzrJmuPtN6MACzBuwngA4wLPO
 o92LwOD3lrKQBtermLyS9DGa4duvc9Eh+2Qh5kHZt4BFnznSs0eiFXpqFMJwLkC37mhCKwXisFh
 b54BdsmNodnjNuZGwLxhmKpGHHs/0OqvN2vYYxLOoRr/dSlHya8CmdKWUnOdWN5Jqr/Gkuox+Mz
 3FHRV3HB5mZW2PAwCy+JpiB+Z4x6eVp1nty627VuqXhDXaQZYfe8ShoStvinpDdPbQ15weMXgAF
 hIZErq4aJXfHSHWOeFWk1/3yDlIWVDxCHepHr/WdDOnWiz5mbP9Bn7pIEl2A=
X-Google-Smtp-Source: AGHT+IEAr+iyyqLPgNL1eaI+T+niU4cjTbbg8z2JRyLCLGxPR+S77k8DWxZ+IGI4Wa1H6IlxXEWVCA==
X-Received: by 2002:a05:6602:7192:b0:886:e168:e087 with SMTP id
 ca18e2360f4ac-89036ec048cmr98706839f.13.1757627660437; 
 Thu, 11 Sep 2025 14:54:20 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88f2a7db2f1sm101517639f.0.2025.09.11.14.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:54:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 6/6] usb: host: Tighten USB musb-new host glue driver
 dependencies
Date: Thu, 11 Sep 2025 15:50:23 -0600
Message-ID: <20250911215404.3955132-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911215404.3955132-1-trini@konsulko.com>
References: <20250911215404.3955132-1-trini@konsulko.com>
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

A few of the USB musb-new host glue drivers cannot build without access
to some platform specific header files. Express those requirements in
Kconfig as well.

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Add Marek's tag
---
 drivers/usb/musb-new/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb-new/Kconfig b/drivers/usb/musb-new/Kconfig
index ad9072a53276..0e2b2b5fb857 100644
--- a/drivers/usb/musb-new/Kconfig
+++ b/drivers/usb/musb-new/Kconfig
@@ -52,9 +52,11 @@ config USB_MUSB_OMAP2PLUS
 
 config USB_MUSB_AM35X
 	bool "AM35x"
+	depends on ARCH_OMAP2PLUS
 
 config USB_MUSB_DSPS
 	bool "TI DSPS platforms"
+	depends on ARCH_OMAP2PLUS
 
 config USB_MUSB_MT85XX
 	bool "Enable Mediatek MT85XX DRC USB controller"
-- 
2.43.0

