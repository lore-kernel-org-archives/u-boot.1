Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C8C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D501880C7E;
	Sun,  9 Feb 2025 03:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aG385bu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C4180805; Sun,  9 Feb 2025 03:02:39 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A84C80A2A
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cfeff44d94so9206505ab.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066554; x=1739671354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKbF3/UhEHF3lhykifIVw0VytHk+D2WFqF6gzOOKj6I=;
 b=aG385bu7Y4RhjVldeMmzMuGYLIbWBVGq3uXwtzdPEExgWSv3rbUwr8vdkcOCfOrQDa
 EnKj3uDMapl4vK6FtZEdtdJPdmHlOT8Db1gNiy9prqa0uA17E0ihAU1bP51aZeGZHD7G
 Oj20f87SVaPs0dQJReaNlSsby9jC/4q13htxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066554; x=1739671354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKbF3/UhEHF3lhykifIVw0VytHk+D2WFqF6gzOOKj6I=;
 b=K42es70JX7oojHuHGxKcmGJpcuaSV6fWHo17rz6gVvVrOEU40EDW/yE6CmO6g8ek9K
 hq/o9xvBwGDuWksL1zwCSgGMBqvwyHepRULF4OgltZwaQoB5/OJHiAOXAx+piYjnUfJk
 BTVnl7ETxvdlZLHnu8m5QeKtTcQHUYrSjQRi/784TgdmenkOBezoLFHnvknT1KHdKgxD
 cNGwOrceovQ278GHceBHBGILG9Y2ixUlMX/vbyhCqMlhSVk9av2QpM9KU1IIIIxWtvx4
 277IhvkWXJXbhqr5esGhCcilI+GDrC8n7qgsb459jrq+IkhSHfmgu4Z+Om6vUcAh+LAt
 F7Ew==
X-Gm-Message-State: AOJu0Yx1rR29HF7eSkwMDWlFSd3ibIE0uKqRI0PRU0n9d60zDxrGTn/e
 wZEO6ThxC8Ui/jHXCeD/6LwVWR93BExgq+YgpAjJAhDqiCIU+1qMg1WevWT8QhH54PnSwiJhxwY
 =
X-Gm-Gg: ASbGncuGv4LeoWP9AcWtIM0agfNoui4wnr6UYwwSZgwnFA1WaGIXMaR/+thdamDDd1L
 +Mw68+l1bG3s1k8VdenadTohhf6/6R5GhLrq1sUK3fq0nYh72/vOtqXFt8JG5DBICaJM+0/X5SB
 7hA8tbRYE3cs8DlnnPEJ//d4rykf1C0NP4vuY5Y3o2t5uTnyzcw5SiRkJGSFG0bTYD2qSB9p1gf
 tlm7ZiTosGLq5RL8tiosmy16PO92QmfqgVGjhfTRs0CAKSNzSG6lwD1aohuJsoqi5FDnDzcc0sV
 SOB8Yr8pKdsPfXhreGdfSjmjGfI7Z3tkyI8ELdhc5YDtULi7LuKL
X-Google-Smtp-Source: AGHT+IFFjqI6utIW1yPFdiMXvp/8sc39L3ymLkTwqZPX3VBnm2ivxaykCFDjJuakSNf4LM+XEE5VSw==
X-Received: by 2002:a05:6e02:1a23:b0:3ce:6628:3c4 with SMTP id
 e9e14a558f8ab-3d13dd1f184mr62545545ab.6.1739066554389; 
 Sat, 08 Feb 2025 18:02:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 19/29] efi: arm: Drop exception-level code when running as
 EFI app
Date: Sat,  8 Feb 2025 19:01:18 -0700
Message-ID: <20250209020136.4108987-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

The switch_to_non_secure_mode() function cannot be used since EFI is in
charge of managing exception-levels.

Build just the exceptions.S file.

Modify the existing SPL rule to cater to the EFI app too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Rewrite the commit message

 arch/arm/cpu/armv8/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index 2e71ff2dc97..7bd6cf21b19 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -13,7 +13,7 @@ ifndef CONFIG_$(XPL_)SYS_DCACHE_OFF
 obj-y	+= cache_v8.o
 obj-y	+= cache.o
 endif
-ifdef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_XPL_BUILD)$(CONFIG_EFI_APP),)
 obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) += exceptions.o
 else
 obj-y	+= exceptions.o
-- 
2.43.0

