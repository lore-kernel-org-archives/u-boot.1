Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D48E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B541805EA;
	Mon,  6 Jan 2025 15:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WyGTLnDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9028480600; Mon,  6 Jan 2025 15:33:12 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27AC080601
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a8146a8ddaso53451045ab.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173988; x=1736778788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=po2aAfbffbEV82CCrdgF7VQpKG0lRJ9swXG8eu3xnYo=;
 b=WyGTLnDjU5ql+X3jeVqnR7g925+p9YZXxs+Z6kD1AC4Ma1LYhCIJyxI5OI3W9OHhaj
 gW1TJ/RjWsXysqhuhjXWkzqHBnEgTheI97LKztexx8cVUoYrOyYC5aniJdcXYC4sc14A
 lZj88zdsxvhtaZ/3i8wBWpoWvh+ntL29w3npY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173988; x=1736778788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=po2aAfbffbEV82CCrdgF7VQpKG0lRJ9swXG8eu3xnYo=;
 b=Soe1r0xPzRK1R1kvFKf1/JkT0u3N/M30XuZel/LyMjtciOMc6O2+hT0722vDIbAJbv
 tRo2hiIcDa+rui3Id5YYRkbWOFzCHlgjCmlc1MXQbVE4vABH+V0bR9ju7VLjUjRsGlY1
 WrCuZztoZCudsMEHQUG8QbdlSbyQXWmXymuQwtfakyB2W+fNzBJf46Un+aedl3I66bZz
 JoneAgRDophvA7SOSBK2SOS8yFcTsXGXV78hEMZviKD+SGANj6h2TI7jtMYU+XxMaqGR
 QdqZh/5c4mVzA+9ho9tnAKPhy/t4OxjksQp5px/rNUjYDtIwlBnzt3xamIHtVYHN4aeq
 dBVA==
X-Gm-Message-State: AOJu0Yw7XmH9owcA4qM00y/ybM4e4V9GNg4XOa45bHcK9FrzTrPZ+LGH
 Bs/bFHNR24y03gXcfZBaSKjH4AWVOkmfF+EalzDEEbCM9563BYvF1GK7aRRV63HUc1coEW0tMo0
 =
X-Gm-Gg: ASbGncsSaEHJola+4rQZg28LQmjFRzvsoxQjfnqflYw7cpciv1qoZQTK3CyOqbIXx2f
 9+OUsqLskHfkvgQobcsEoYY1swQJZdWilnFYc1TSnyMZnPoF7XrGfPNCLeJ/tue0JHUED0EA6+S
 tkj8G3/2c+r108v3oQuRza3P6ow4psSEIhgUhRHvC1T0Wg85s779Icpz/1FVa4SmhD3a4xE8kkg
 /gkrplgp4cgFe1pI+7AqiwCEfDmHkbKJbZ45WESGI6NJH4Ht2EJuu9Gwks2TyilwIsWtAxTN1px
 PcW+2VLQUzRHzVfobg==
X-Google-Smtp-Source: AGHT+IHeBfWNa8YWlns5g1VRdyK7z1pD5JWlSDslr8MCfJ+/6nKvcPKP7B6C/TjCDAG+v9gdaYpskw==
X-Received: by 2002:a05:6e02:3042:b0:3a7:fd5a:8b8a with SMTP id
 e9e14a558f8ab-3c2d2d4f1abmr551124175ab.12.1736173988359; 
 Mon, 06 Jan 2025 06:33:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/33] x86: Show the timestamp counter with bdinfo
Date: Mon,  6 Jan 2025 07:32:07 -0700
Message-Id: <20250106143229.3023771-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Add a line to the 'bdinfo' command which shows the current value of the
TSC.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bdinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/bdinfo.c b/arch/x86/lib/bdinfo.c
index bd2cf0b9fcb..4b016d4a0fc 100644
--- a/arch/x86/lib/bdinfo.c
+++ b/arch/x86/lib/bdinfo.c
@@ -33,6 +33,8 @@ void arch_print_bdinfo(void)
 	bdinfo_print_num_l(" high start", gd->arch.table_start_high);
 	bdinfo_print_num_l(" high end", gd->arch.table_end_high);
 
+	bdinfo_print_num_ll("tsc", rdtsc());
+
 	if (IS_ENABLED(CONFIG_EFI_STUB))
 		efi_show_bdinfo();
 }
-- 
2.34.1

