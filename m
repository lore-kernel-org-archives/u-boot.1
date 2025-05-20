Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20B5C3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D793B82C7F;
	Tue, 20 May 2025 07:22:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UQKtgX1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9B782C7D; Tue, 20 May 2025 07:22:21 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FB082BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso1655682f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718539; x=1748323339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNw18Apz6e/E3KjGZ+WTdqsXhZKTri/y2r4tNvNh1Qg=;
 b=UQKtgX1uSyNL5nP5CABlnYpDE6jJJe1ZHVpWucobXwjkfjHmNJJGpoJ148h5I/miyi
 /lc1oGHcatXP5Z3xUhSoPZwzpFlmhawqK0sWw4n2d9rHUFE9DjqYMPM2iy5221Wpz48Y
 9Dsp6Otpzh+EztWQZWU4KoB0/02Yx04xzh0DrnVhhrpgkRXHXUzW52iWEjm7dFhrrXlm
 6po1hQztvUBMVgF2iQ+wOtHZYWSDZ3a3uvy7L8Tg2iOLmCcjT0imikJLt5A1EmB9W8An
 FIVgYB//4QIhd7jhFk1jNwHvvknToCGLrKL0MXJki+0B7g4u+zOqmF4AwxYkmja9mCyr
 8MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718539; x=1748323339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNw18Apz6e/E3KjGZ+WTdqsXhZKTri/y2r4tNvNh1Qg=;
 b=IT9g0HhCMNsqeHKAMaxsGdlFkt/pgCaINZbId7WzoKUKRcCeuVd8QE5GD6rlIYgmof
 HR+f5Dx+wr+giTEUZyewfmp50ttLI5JooqUyF7KInc9Y0C+SfI0OXPw295TZ2jcCU407
 /kjJiYhcYspWixI5V2M2qtX/Y5u4opNu415uU70KEzkqhJPg5kdcrP7XfFYGfwV1pSEk
 ZqxRDYI4h13M/30aLuD3U3utvZb+JwKrZh3EAY9AwHtVFIgDc+zp+hdmMVDejsM+GH3v
 YUbrTn4p464gdpjgfo8lIWSUPSKwVjdoTRYwn5Ht6XmINWRwvTPz2/OjNvyyCKFx/1cr
 piFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFM0AZn7VZx6A1ghLue8P6NUlN+UQaK9PYW31I/MvkdUv3BPt5Ado3plzXyKeCrPWFdl12erg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0nAKcgffwloiUaLcN14CrmU3bNLk1CiV/QvrgBzecMA8+ZHdD
 wGTAt5y7aNknFs40LcYkQ935RjHHF2AW9avEtoG1j/dJAJV+dhEehNKcKw8sJPc23Qk=
X-Gm-Gg: ASbGnctlPQYg8fPWTR1c6VusyiQMA3JvEjv4BB4rIrJDNxBMQ+GMVzBqLFAYV2lT/6U
 LROkGimR4ktswE0lIQO2rlMp2r7zB+bVLoG1W6r9dB53vId4gg1aEiSGQAOQDpyEoBlGM4rrfSs
 5yb5G99P/Az+3gb4BgwqTVlefP4aZvlnIxInQrW6ZiAuwOhGRKVJ6GRbEXRKouVhdqoFYHirhqr
 HGbGdf4+wPDVQ+6z3Zv2AKVzfoHthPOHNJI3MNWc2YI81WetqxWr72MXB5iFzLDC2tPcixPgalD
 o1kgjgM62Lyk5Xx0PvwfXf7d0MpvyXwxK9HkKHkwS7lqkC8pkZr/k04EPXvY5nKgehAAPVWYUR4
 =
X-Google-Smtp-Source: AGHT+IHxIX6G6Y8+PQMnPfIATHeMW7fSI98ZFm75POHkzc5GfQhp7JP2YWSLsafZTCihtEBivmt6Sw==
X-Received: by 2002:a05:6000:144f:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3a37ba593dbmr388599f8f.26.1747718538930; 
 Mon, 19 May 2025 22:22:18 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:18 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH 08/24] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
Date: Tue, 20 May 2025 08:21:19 +0300
Message-ID: <20250520052153.307194-9-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit afa974b77128 ("kbuild: add real-prereqs shorthand for $(filter-out FORCE,$^)")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Kbuild.include |  4 ++++
 scripts/Makefile.build |  2 +-
 scripts/Makefile.lib   | 10 +++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 7468223d3233..2ef687ea895a 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -27,6 +27,10 @@ basetarget = $(basename $(notdir $@))
 # filename of first prerequisite with directory and extension stripped
 baseprereq = $(basename $(notdir $<))
 
+###
+# real prerequisites without phony targets
+real-prereqs = $(filter-out $(PHONY), $^)
+
 ###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 10f31a57a0f9..73e1d71e30df 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -356,7 +356,7 @@ $(modorder-target): $(subdir-ym) FORCE
 #
 ifdef lib-target
 quiet_cmd_link_l_target = AR      $@
-cmd_link_l_target = rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(lib-y)
+cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
 
 $(lib-target): $(lib-y) FORCE
 	$(call if_changed,link_l_target)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 6d0cb8e6513f..4861b1332c3c 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -546,7 +546,7 @@ $(obj)/dsdt_generated.c:    $(src)/dsdt.asl
 # append the size as a 32-bit littleendian number as gzip does.
 size_append = printf $(shell						\
 dec_size=0;								\
-for F in $(filter-out FORCE,$^); do
+for F in $(real-prereqs); do
 	fsize=$$(stat -c "%s" $$F);					\
 	dec_size=$$(expr $$dec_size + $$fsize);				\
 done;									\
@@ -560,19 +560,19 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
+cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
+cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
 
 quiet_cmd_lzo = LZO     $@
-cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
+cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
 
 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
+cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
 	$(size_append)) > $@
 
 # U-Boot mkimage
-- 
2.49.0

