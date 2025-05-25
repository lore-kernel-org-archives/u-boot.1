Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F1BC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A982E82E28;
	Sun, 25 May 2025 12:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U+Bg26An";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DD882AA7; Sun, 25 May 2025 12:48:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BA882E28
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4c9024117so1005546f8f.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170110; x=1748774910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/P4xb3oAPlDWJu7e7KpdPrzs9t2P2GNK+tNpMQv15w=;
 b=U+Bg26Ank+iUpzR2JV7x/r10VB68aGJ7vQn7iwnOIqh6pJP6lwBymlqq5GN/35brks
 qEkBnU7Bhe8S9EHpr7+cH0eptOwCwhNSRdEd16/m+82nnjbqOLQOY+J9tlgY0R+pK19r
 mYeZe/OOF6PSHvQtqck8abDe00v7bKmYScSyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170110; x=1748774910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/P4xb3oAPlDWJu7e7KpdPrzs9t2P2GNK+tNpMQv15w=;
 b=NAyTfkLOx4yWYd+O0hxFX7KGqHD3PEcghaFmryrA0UpiorC9lsPX3GXBln79hRQm5y
 tXjUWvzy8pIDW2iGpps+m5Gdmz7fjC2XUJC5K+0oHfS+9DbOPY4BV/hMqA4zgW3Ibp+a
 tcewFsH+rnoYIw/TLERm7hFKJ7FP+r5hyYLyDeVzNpLTAtfkGoqkMCJ5ntXeff0n3iPi
 JjEb7UVPnfrZUu/zDtb4MafU1QZMRPJkZqqVkkT1ewhUjj3qCI9vGNVr9lu5flV+kbHr
 hWAQq1AD33C7hI060MoktvBlAEyZQhQ/JNMOxIdFjRPcB1avoFaR09Jk4RxtBNCICJJD
 3//w==
X-Gm-Message-State: AOJu0YzW2ym1jd4Qm1ojLtXilRZNIUywAOLkqzzpD8knfoTfntTTNa8H
 CWkznw9oj4RdR3HNhbr7tePKAW3zD2dfk2nbhf1tMg57Nl2fS90HkaFMMWtTIRRkAMhrm3aSgj1
 YLyB7ZMpk
X-Gm-Gg: ASbGncvR2UxkP/WUVP7BohSQ9ERF62n2OhqcAuP0F6g+OpW3itUzMrFs/dv3g7JEPRm
 g0yxmxma7E+gLQyFvY54jk0TcQlv8an1/AGn5Jt/KYfmEWVfqUayTDK4kVpX4GMPx4KLeHTN0/u
 UJKA4TKeSp2cx/OWheyVKdlx3UoJqi8J+cPntrXihpaJV0CfAy0McKIH9feN43qVXrR5N5FDk96
 kDE9tUZlbKcjlOhmZtVASA0i3J4vE6PkJYVPfNGlGOx7izkUJ6CSUhAaLY14d4bvUA/SjXSPBSN
 tJxr6GYRBWJxLDbAvMJ0BMAEGhy5OhlqyXo8iRPdoxf9N4RZX9+dGNN9XaIlBW2XaJbyz1Q=
X-Google-Smtp-Source: AGHT+IEq4S5Q8dOZcX/BmuLYcfn4b43/o9D+O2JDqs4fi0A4+nL+7ez54cWEskYS3pug71+sglUbGw==
X-Received: by 2002:a5d:4b8d:0:b0:3a4:d038:cb9b with SMTP id
 ffacd0b85a97d-3a4d03934c5mr2675419f8f.7.1748170109757; 
 Sun, 25 May 2025 03:48:29 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 14/25] rockchip: Add symbols for spl_reloc
Date: Sun, 25 May 2025 11:47:50 +0100
Message-Id: <20250525104801.1440260-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Add various symbols so that this feature works as intended. This allows
xPL to copy the relocating-jump code up to the top of memory, then use
it to decompress and start the next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/u-boot-tpl-v8.lds | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
index 958a1b70aef..842bd4eb07f 100644
--- a/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
+++ b/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
@@ -25,10 +25,21 @@ SECTIONS
 	__image_copy_start = ADDR(.text);
 	.text : {
 		. = ALIGN(8);
+		__image_copy_start = .;
 		CPUDIR/start.o (.text*)
+
+		/* put relocation code all together */
+		//. = . + 0xc0;
+		_rcode_start = .;
+		*(.text.rcode)
+		*(.text.rdata)
+		_rcode_end = .;
+
 		*(.text*)
 	}
 
+	_rcode_size = _rcode_end - _rcode_start;
+
 	.rodata : {
 		. = ALIGN(8);
 		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
@@ -48,6 +59,7 @@ SECTIONS
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
+	__image_copy_end = .;
 
 	.bss ALIGN(8) : {
 		__bss_start = .;
@@ -55,6 +67,7 @@ SECTIONS
 		. = ALIGN(8);
 		__bss_end = .;
 	}
+	__bss_size = __bss_end - __bss_start;
 
 	/DISCARD/ : { *(.dynsym) }
 	/DISCARD/ : { *(.dynstr*) }
-- 
2.34.1

