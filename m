Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F07C80A08;
	Mon,  3 Feb 2025 18:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QGof2/q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8B980A08; Mon,  3 Feb 2025 18:44:28 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C768F800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3eb8bdcac2eso1060843b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604664; x=1739209464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9od8JJ3av9XHhMLKCQlyEMABysLhkgE3NcmD28MW8Q=;
 b=QGof2/q7xjeoRQOzXcNF8Prv3ZUe2tL6cf+fvM0WthSwn6sXf46vhm2YSp3ue/Sz+N
 xtDvWZkTEflrgXbyQwODFJelOBCxAgQJJmbfTaASFZsHlLgSoD1JVnitiKfnWLyvQ99v
 alBMnMxj6r5iARAyfj03DU+Js5GGF3o4OyJqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604664; x=1739209464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9od8JJ3av9XHhMLKCQlyEMABysLhkgE3NcmD28MW8Q=;
 b=tGFWiSU/fafZxt0RdxIxhS/cthzbSaadjRMJW92xZ61EDzjBot9kCw5hIEezb8A5LW
 lYJMfaH6MocGAeCcEGJ8VxpprKGTj5zYFXGOEa2MBYLnnTqrIi3yVNRgrgA5Jqw/jIYf
 S/h4GXBdE7phSwUF7wK+RPyzibRE8X8qZPQa+lbtN3KTv5sYoWRLbxJGM0jx2Pw6e90E
 gU55RMsBy1Iad8HLyfcpX8IO/QJgqbqedsqqdvAfXCLTm6Q24coiU9PQGnChP8uj0x0w
 z5AO0I/Evn7YchT5G1FWzSjTYdXKv1ceJbkBNqJfemV0vdAmllpLaszYXHI03T6sARyK
 BrTg==
X-Gm-Message-State: AOJu0YyUhTMVyuxetsEKHNUapCab9QSt4cVdvJYf7ZSnoCtWl6NwDo1P
 OdUbepjvTUD2RSqYm7p+4Nn148LXz/R6VgYoDL3eMVRAUZBl/3Kb2MvgtlhFfZjnRbgqkcK8Wl0
 =
X-Gm-Gg: ASbGncuNdDhC4Qlt3RTz1+zm3h3Rz5zpIA7AOF/tNxX6N02vfU/Hd3IfM5V53fjdFQz
 mH2/KE8bO2esk9sJnQ8MxBm9/rZcyBti8F71u6UkmOoOwZNVR/90/5jglzg1uPv6Tv6572VsAFm
 c4J9ygcaueWdrF0TavlDmjEI1QJpMSnG+J5vAF93Ya6lqMF8wY/OMese4dgF2RocqvAlocFZPi/
 YCdGCHqKjf2LY+PomAHIzkzn2AX3OaEm+Fg9ybFdrUrdS4MQqYAyeYV9k7Kopg5AClhQWgh0F4d
 DQIxwTjPweQu4wtOEQCXzXD5rMdIFMbQAU2xDZe3GdD3ZnXHunun
X-Google-Smtp-Source: AGHT+IGSpMZlDXHk9QbEhPTF8k6RQVHt3S1TT6DZz2DKUuN7zauY3dtE5CZ88rEmioDN7iJ8yxjX7w==
X-Received: by 2002:a05:6808:f11:b0:3eb:3619:6a90 with SMTP id
 5614622812f47-3f323b6f2b7mr14801520b6e.33.1738604664410; 
 Mon, 03 Feb 2025 09:44:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 26/32] efi: arm: Select the EFI linker script for the app
Date: Mon,  3 Feb 2025 10:42:19 -0700
Message-ID: <20250203174245.1331464-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

The app needs a special linker script, so select that for the app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/config.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 1ee31680106..d2d1a8d2bc2 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -21,3 +21,7 @@ LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
 
 CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
+
+ifeq ($(CONFIG_EFI_APP),y)
+LDSCRIPT := $(LDSCRIPT_EFI)
+endif
-- 
2.43.0

