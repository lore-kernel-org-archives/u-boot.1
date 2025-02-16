Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC0FC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE0D80F0B;
	Sun, 16 Feb 2025 21:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cDdxtf9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7841E807E1; Sun, 16 Feb 2025 21:44:52 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE4C807E1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-855746e8667so54654739f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738688; x=1740343488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=cDdxtf9AAOxFP62YO58RqEm4HAX9qUICiL8SIlQtkASrXVW87QZYKmacMFxJh9yDBF
 DFourbx5+p9jAZYET57sz/NoNGO+m+NfGTfu4wpuRKMP1JTrxWSQ9N75Kd4zDQ86EC/I
 bVroLa9iKikJJSxHFhHkzr+pOZq0o5Gg2aTgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738688; x=1740343488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLjPxxvNwl1Izdu8dNxj7jwuxoUTg5WIavhcch5Y3JA=;
 b=eAsMcOmMnfgHU/qM9INGgTqAAvFGTii/x14H7MQq5bEfPpZSJlyIWl8tYQZKH9R+0P
 SYbeqT0vhGWev6sN0FfbZVnuEBEYPzLKacxQxgmA6LNDbjyk193dI18X33pbC0KpTS6a
 4+kpUhpPXIcibNct0gD4MuwmhRqAi59HNi18J7OooaRbTk/fbqQlL9bsTMJ8Jq3cqwPT
 Kln+oslsopWhW7QYjQmW7VkLcOLTIXONjwMEEKKWnNnhJ0cT7rhMd7mnOo1262QbL6wV
 evouUM8Gmgld0C/OHXxg/snqaBdmQzJQs+6g2NG5g+QI3dFWd14IIUFNj7KZKX/giI0T
 t0vw==
X-Gm-Message-State: AOJu0YzpbyfAKv/l+4momNmZ7v5cVxPl/y8QGsSOrabtHVPDUqfecSoV
 XdQmwWa0LFCLrHeSlZYm3rrfUb3LKEKhMYFZ7+LaOYbJ8Pl+8eHU6aIo5lcjIfTaiqy66Gjy4i8
 =
X-Gm-Gg: ASbGncvGNKMzyriTzVnsw+BZrK+Dex8lhvKlLOtf2r9Ip0WW5u2v9yUkP/s2JphGPid
 L6Vdnt0Syml8mMy+DrT/vniKCD+RXGGM45ej+CO+wQxzs7tWmr/c39bzHHUOIuKQXQiZO+NDUiO
 AlQwf9l+1HILU3kaTfz3PwCQt16gjK2jsolXXFCNnqJQ3nW6OcaFuo5UHyQWcYbkJvjQeaPUFEH
 XzclAe7T74B3iYNWTIW6bb772vFSszDy3XkH4hvlHroSi5uyQ1ND8NrUm2lngNev3Vi3fcXwNHw
 WAwC38Vhi8htV70xFI9hLCnRXvrRJt8Xzu2GhSZ3l/V1CQOKJjdo
X-Google-Smtp-Source: AGHT+IHdbTWVWa5HcCgQ7okQdeohrnDJmVZBVghBl7nl3tqRzQRkcNjVdBEfqgocNo3MvPjup4lhuQ==
X-Received: by 2002:a05:6602:1606:b0:835:4b2a:e52b with SMTP id
 ca18e2360f4ac-8557a15989fmr624166539f.10.1739738688420; 
 Sun, 16 Feb 2025 12:44:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/28] x86: Expand x86_64 early memory
Date: Sun, 16 Feb 2025 13:43:46 -0700
Message-ID: <20250216204421.3560012-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

The SPL and pre-reloc malloc()-space is not large enough to start up
with a display. Expand it.

Switch the order of SPL_SYS_MALLOC_F_LEN and SPL_TEXT_BASE since this
matches what 'savedefconfig' gives us.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 792ba06c2b8..af275e8ce8f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,13 +1,13 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F_LEN=0x1800
 CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4800
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.43.0

