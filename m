Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3625CE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1521189428;
	Sat,  7 Dec 2024 18:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jGrTZqpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCD488FB4; Sat,  7 Dec 2024 18:26:21 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3FF88DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so117127539f.2
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592377; x=1734197177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j74QLmzUVfx1nYppzT1UpJ4hWHCPdMUetn6Cp+dtlo=;
 b=jGrTZqpEga4YZJTOJSqnXCwNCXragTJ+397q5LurIa5b+vNupYv9VIXK9BGBSZiaLU
 EMyT+BO1qq+9EcXo56CBpHSL2UD87kbtZz/ZDgp8hS1y+dxdstFENncXsWwKVnFCuldu
 ciVDlQy1P/WGASau+pwKptBa63IWihMxbNdqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592377; x=1734197177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j74QLmzUVfx1nYppzT1UpJ4hWHCPdMUetn6Cp+dtlo=;
 b=Or5fn92Yk3uscOFo9Z3HzzdQfbkLqvgqexpyJ7I2wVh3lo5vfRsIr7qKZkWiOly/LA
 Knd1tDHKijc/3EygLd9b3w7b6cxk0fOrUFnCaVnxCl3u5J7nWKuXzZzJnvU0p7W6O1br
 S6uWwo08DRV/paSNrLYCbUI0cBPG4tN83QrD4vw1GAzeb6vJ8kgFh6FRo1DAFZFPAZsh
 gAmhF6Dl6wRU1DAce72jUtKgkAO5E8G26qOL540pe6iv+aVBdkxutCWq6A1ML6qjwlS/
 S35R6rgV5ER2R9pOaxpygT9+vG2wX1jRknRVZXmIBNOrzhZkOsCuVaTmz1blQG+BAMUd
 gwZQ==
X-Gm-Message-State: AOJu0YxpaJ1EJhzOqSgXTdnPVlA7IBTgCYj/WF2VY80xRH6ihIRdx+lO
 lsx1460EslBjUzcXUh6jEKtK0AIYeC1sOcGikxEQUtr+NJ5xFPF4xdEmydd/eRNeO3UfFK/W7JM
 =
X-Gm-Gg: ASbGncu/oQDqy6OIJNmzTJ8AeV5wXwiJQT9et613djAVD2crcio6kk8ZTKNneqxwN4F
 kpldkq2zFyBZmWKp/E8r0Tyaz1ohP5AHJnWLywXRINgAbuczbCEpPX1oU1jPkfn+O4NCbBthKCv
 JKen2elHek+tzRjRfZuBqnqSZCBbMlBWb0ZA1J/yja1TsiYdtjFmarQps1+ehg6ou/8bu5YyZnc
 jLY9bmMlnl9uJRz8qxKlKz0/6v/fU7dHc99n0uDZPdAky8cevEImTKonioHZLhuY9TW9yllpqZ5
 5Rv2txPw+pY=
X-Google-Smtp-Source: AGHT+IET4b4kOyrJ4qvCHRWA3BpXqqiR/z+oH9af3rODXRFhSmeL/MgHmAmnNfQyEi3XOWHGsii8tw==
X-Received: by 2002:a05:6602:6c02:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-8447e376d6amr1050976339f.14.1733592377579; 
 Sat, 07 Dec 2024 09:26:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 07/19] malloc: Provide a simple malloc for VPL
Date: Sat,  7 Dec 2024 10:24:00 -0700
Message-Id: <20241207172412.1124558-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

The VPL phase may want to use the smaller malloc() implementation, so
add an option for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index d06f36d4ee4..3dc0e95e09f 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -222,6 +222,15 @@ config VPL_SPI_FLASH_SUPPORT
 	  lines). This enables the drivers in drivers/mtd/spi as part of a
 	  VPL build. This normally requires VPL_SPI_SUPPORT.
 
+config VPL_SYS_MALLOC_SIMPLE
+	bool "Only use malloc_simple functions in the VPL"
+	default y
+	help
+	  Say Y here to only use the *_simple malloc functions from
+	  malloc_simple.c, rather then using the versions from dlmalloc.c;
+	  this will make the VPL binary smaller at the cost of more heap
+	  usage as the *_simple malloc functions do not re-use free-ed mem.
+
 config VPL_TEXT_BASE
 	hex "VPL Text Base"
 	default 0x0
-- 
2.34.1

