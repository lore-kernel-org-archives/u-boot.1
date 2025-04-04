Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D4AC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 16:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2459582A55;
	Fri,  4 Apr 2025 18:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CIz42zih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336CE82A46; Fri,  4 Apr 2025 18:36:23 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B385829C3
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 18:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c173211feso700056a34.1
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743784579; x=1744389379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i7C/tVGOultyRey4rrRskiS7A1W1im8uzq5hptYqLf0=;
 b=CIz42zihuYKiJ8WusGuDU/qYxTvv4cg5VvD4GGrl+0OD2vM+hG5RW1rNtFuN9uxi23
 GnR8JMASylGRV7oqPY2fXUrOgmqm4bb3AcKFOQR4HoJgVvX01KxUSahx4RuSfLSH4c2D
 GG/ZuAO6nOG943rAH/DmIxjkxB8LCuDxdACYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743784579; x=1744389379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7C/tVGOultyRey4rrRskiS7A1W1im8uzq5hptYqLf0=;
 b=EGVTw5grpexRvEL8oYmOLqTRzyMCBQyN8FxeV002STjoaNpB5vvmaDockj1oePdDxb
 ep6ej5fPHO4RsZv1zkOKfXzk9XTlswyy/WakkkGB5YOFUSLYFB98JhITYS4VCPjzBmd0
 UQTpYApiKIsyT3Mg5UPmuGyI0eZ67NLAlcUk/VP0sm4lmdQj7rzxcw4SWcaMKrjteOd9
 QhzNAplEe6PGi5cSTU9YGVgQMBZL2VB2iNQGLZvTl0Euut6mV3QJrqRiggkQb+dEVM5j
 i6/UL5tg+6lD4bWRlBlbtclYAGt3MZp05JZyZuCF/62hoSMrvnb8yf6qA7ggAStpG+4P
 xapw==
X-Gm-Message-State: AOJu0YwCb6BNWDNDuN69Shd3z6rrcZEVHKvT28bSCap6rXjoLSbtb7Dz
 OoDfoUyDqETsFA16zg7NV0aQ02fdzrpiKrtQX5Yb3NR9bFkXIlzMK52hwBFqYhpCOpYX0Uxrors
 T
X-Gm-Gg: ASbGncsUvaTIEid0PXzDuBwWCcviUIIGY4vJIg4NXodmqFgGyfNVRstv92ajGNKe6x7
 L+W4KXTT635Jytfkgbz7LLTgUmMWtUoQtUU/jp8YM+nfQ0zzwvLXMeiFq3VTkw5cUPfHb09Tnxm
 cbNQPpj+YKNsv2PYTE1isGxuSw9be4hulLRrez19EBkrgeahw1neH932dYbaaVQWMTDQRF+iDgz
 ggN2RCoURyp37tb1Hpd8GqhLiHLdgNgnzj5nENXzpZuACfTp7k1vzESgBotagVnp3rvoIpZnrLK
 YcAD13NCGj0xxR3cIDj2eveV6gEUpR+5gyC4rGcqi4jGpVgMq14oQW/A2iowl8t9GURMP/KBTmj
 543Ni9CnD
X-Google-Smtp-Source: AGHT+IG9wM/v2QexN9toQVdamZzy9UdKv5bh483um0qRFIDgEppG4NM805o8Zw89HvyLsmRmZZd2SQ==
X-Received: by 2002:a05:6830:6418:b0:72b:89ca:5120 with SMTP id
 46e09a7af769-72e366cfb40mr3282245a34.8.1743784579213; 
 Fri, 04 Apr 2025 09:36:19 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3059a457sm714789a34.51.2025.04.04.09.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 09:36:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] x86: emulation: Disable bloblist for now
Date: Fri,  4 Apr 2025 10:36:17 -0600
Message-ID: <20250404163617.2577637-1-trini@konsulko.com>
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

As reported by Niklas Sombert, enabling bloblist on these platforms
means that we currently don't pass SMBIOS tables on to later stages. For
the v2025.04 release, disable bloblists as that is sufficient to restore
functionality and we will address the underlying problem for the next
release.

Link: https://lore.kernel.org/u-boot/c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de
Reported-by: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 configs/qemu-x86_64_defconfig | 5 +----
 configs/qemu-x86_defconfig    | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 792ba06c2b8b..662f97184191 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,7 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
-CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -34,9 +33,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_SPL_LOG=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
-CONFIG_BLOBLIST=y
-CONFIG_BLOBLIST_FIXED=y
-CONFIG_BLOBLIST_ADDR=0x10000
+# CONFIG_BLOBLIST is not set
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 0b0e10c795f6..9948fa6d716c 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -1,7 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xFFF00000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
-CONFIG_BLOBLIST_SIZE_RELOC=0x20000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
@@ -24,9 +23,7 @@ CONFIG_LOG=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
-CONFIG_BLOBLIST=y
-CONFIG_BLOBLIST_FIXED=y
-CONFIG_BLOBLIST_ADDR=0x10000
+# CONFIG_BLOBLIST is not set
 CONFIG_CMD_CPU=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.43.0

