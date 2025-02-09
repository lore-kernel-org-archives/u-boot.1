Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22698C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F3280EC0;
	Sun,  9 Feb 2025 22:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nj1GtkAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A936080C96; Sun,  9 Feb 2025 22:16:27 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A4B80EBB
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso39536585ab.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135783; x=1739740583; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD28WeKVfM78jO9PF7WpE7MXq2c5jHpukpElrSf/MFw=;
 b=nj1GtkAFg6FzNVg2R9FsabsUVUOW0xb/nId7wHPa78tCJQTgaOysdDv0hTAFKxrDh3
 K3JYGVvQUZGvOMJvyPMen8fSFc9OFO+5BK5LmDnZF3NElW9sV76I4uuPtg6SMKTK48jU
 /u6+XFcVh2n58Vz+BmKbkxI4xQ0P5oAAF4JW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135783; x=1739740583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD28WeKVfM78jO9PF7WpE7MXq2c5jHpukpElrSf/MFw=;
 b=XRCgUtuUrd+cy9nXdP2/RoFGv7XmeI5qbM9Xkxp485FcmW1sCasgEhOKE4JiSGSpcN
 N2Tq/SqSmTwOUiFx4ogTTz8Tzt7FQaVzFePoE8vtCHogUE2/jiwJxcojbm15xDHsKl/Z
 yAyweLUHujF5XtjbT43diqjOX5fW9BhxH599rGNHCt7bLfA0pqdPwvNSpxKg/N3g+ZVm
 ri6l8wk91D3ptdfJOJxZw7Xi7MCS2oOvcsunOfCjpRQQpksZ2dQUkPdm6b0Rjc5/8Vlq
 myYz+X9OsuOEckatS/8xok/B+YrhloUkyUT6agdsV3JEFFWHkq1AZNn+mb2LQhOvYfNU
 TLDg==
X-Gm-Message-State: AOJu0Yzb1WNdJTrfUW+kW+BnG1ge5FNZzxi7o3RDsGZIH2I7MJxnTfSC
 X6BLO/nfkKFURo19zrdC29johB7s0zbQ+npsuBgwI2NLWSuHYtnpIzBYLviAKoEzrezODShWHQU
 =
X-Gm-Gg: ASbGncv0TyckN37jX1BAbY0yGY6N12mGLrUYsodWGm5iMgSvjuAMO+0fMHoAsHaRFZF
 PEddbybP/YGNaBAfoXSZdS/TLRbmyHOyUzeWJV1+EjcgZ5xd/gLMP9SSv64BfHzJEemqn23At+L
 mvykeFr/35kDedXe05wAlS7Xm24V1HG+TkzpYYXTAKigkMrbRxpd26M7mNm2oTAUk6xvh4/MV1m
 POBcyXvAp7YpYPB7Bef2nW2M5fq8VcLt9QHFU6KiUS43+aBnE0C7NbLr1QbTp6bCvLXpfByVOlG
 Xy5AiVZvUFol2l3/ovrHGiA4rzKxxssofvusSOzb5BZbrU7tJSnz
X-Google-Smtp-Source: AGHT+IFH8ou5fNPIYay/OqNUsEHYIsC7mZ7rVt08hzO77poikn5Kjtnaa26Pym/HHPhRlq/ruc+pxg==
X-Received: by 2002:a05:6e02:1907:b0:3cf:cd79:b24e with SMTP id
 e9e14a558f8ab-3d13dfa704dmr94108455ab.15.1739135782905; 
 Sun, 09 Feb 2025 13:16:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 24/35] rockchip: Add symbols for spl_reloc
Date: Sun,  9 Feb 2025 14:14:45 -0700
Message-ID: <20250209211502.2299245-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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
2.43.0

