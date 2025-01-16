Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D7BC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D9680713;
	Thu, 16 Jan 2025 12:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UT3sFEx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B954C8073F; Thu, 16 Jan 2025 12:39:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABF980214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 603083FA4F
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737027559;
 bh=aTro9zBev9Nr9pYSJ4siLZqw1fqhdb2HBXKsWxuL0R0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=UT3sFEx2rI3bOuJFtlUrYHvxHKxixmol0q9X2vqPX8JftWM6jviV9T7Wp/dsfYaop
 /WlVg4hqWGAtAw/LE4oW+d5+8vK0CNHvtON5dj1H/xILNtDJrui6Mv2CHUu3D/cCWL
 f/vLl2HgrRLz6CyLY61vwOUAoGB4kQq8/rHL1Fu0Ya4ChS8aAmUVjSxy2uEQ776KOa
 W/roSDopl78H0LPk7kpYsYjQjs4O9RuDyigxxtjRUjBqF5hLaIAD1g0flYibtH0teB
 6b7Y+XY3RXqxD05FNGippool4tBKVSTwqcH2bJTtxDCfJTYBFvzTBDF+/TBz3npi5M
 otJXuyT5wptuQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso5056175e9.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 03:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027558; x=1737632358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTro9zBev9Nr9pYSJ4siLZqw1fqhdb2HBXKsWxuL0R0=;
 b=G0Fd81rtxs3sevT/X01rCh7Uk4iY75pNJBeSR5SJlVwJ7YynGUY3r2t7sfHsEXLwA4
 D5F5hgW3N6IT1tQwvuZ9X3Yh0u0dVIuIWM4M6KAxlBLBxFZ5eyJCLmHISRnZx742TWcr
 uNVBrGi9vzuApiREEcGPJoLZcFaGKvWbHyOsl4iqJHwsz4XC3Wd+NHBAFXQozaTK6Wus
 0UgyFPUqunkECWuDZhYwHgWt0m/+lpYxqZiaDJ/KQQawa6Zj8fqDg6WgGqhoFRIfmjND
 Gp+R6ZMMCM9L5eHGqNl8NEh6Tqmr41cEmAl3U1jLlDHETk+FPrybam7oVaH5Ba/EzNb4
 Mahw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrEt8RzxNYnMJsGaRmk33Rh0+oByOaebSa/H/UkSZyhbnCw6lkbFajEEtUHxhF1FsgRT9JbEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwpMpdPaxw2BvQuRx+hAqoy3Q4tbqF6rLeUrOTOGpiFgOC7yMoW
 qjJw2319SSuSohXRpaZomsSVIyyMwk4Jb3LOaXbygClPbEm/LuVsVMOxBaPSbrRUDbLkhfJS5CZ
 H4hJGUNoBM3i8Mc5eTA67RsrOyr1t8oDs0VR7eQHH9LDjdmq2Y8oZ4K0hJNw97LydT+8=
X-Gm-Gg: ASbGncvVfRRFz52B8XWpt9psojxUfBNsrDcXF3bXNBNVtHK58elN6MYz5h25iDhWylR
 YhNgEPY2SA4JMzUlVgFYahwqebAYjvUyvJRX+X0v5BIfeT4cRhAOiffRnG9M9eCKP/iadKQrdBv
 vv6n7//WzJFRVSZW7WR9DToudDfT8214IPhhzmcHgvxv83q+yw16xMaigQMpTz7I2FXdoFzfEE8
 bxND/T5Vcf0mX575NOwV05pr2aiKz6Egc8tRQlD+3w7BBgnEJt8lWg/7GZDGAhsP7OJSJZFBTH1
 2R7yVYTb40PgkA==
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-436e27072a7mr278983225e9.23.1737027558640; 
 Thu, 16 Jan 2025 03:39:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMtlaq9ejGHpAOrzNwqpYQyQ2g0ouqDAU3BjVvpk3ZFNDqs0b/K0CowynolWKCSIi5arACMA==
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-436e27072a7mr278982975e9.23.1737027558251; 
 Thu, 16 Jan 2025 03:39:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3840bfsm20606320f8f.39.2025.01.16.03.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 03:39:17 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/5] scripts/Makefile.lib: add -L option to LD command for
 EFI binaries
Date: Thu, 16 Jan 2025 12:39:06 +0100
Message-ID: <20250116113909.113950-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
References: <20250116113909.113950-1-heinrich.schuchardt@canonical.com>
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

The linker uses the path specified with -L to search for linker scripts
and for linker script includes.

For out-of-tree builds specify the build directory with -L instead of
the absolute path of the linker script. This allows using an INCLUDE
statement.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v2:
	no change
---
 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 54403040f00..18993435eae 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -523,10 +523,10 @@ $(obj)/%.efi: $(obj)/%_efi.so
 KBUILD_EFILDFLAGS = -nostdlib -zexecstack -znocombreloc -znorelro
 KBUILD_EFILDFLAGS += $(call ld-option,--no-warn-rwx-segments)
 quiet_cmd_efi_ld = LD      $@
-cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -T $(EFI_LDS_PATH) \
+cmd_efi_ld = $(LD) $(KBUILD_EFILDFLAGS) -L $(srctree) -T $(EFI_LDS_PATH) \
 		-shared -Bsymbolic -s $^ -o $@
 
-EFI_LDS_PATH = $(srctree)/arch/$(ARCH)/lib/$(EFI_LDS)
+EFI_LDS_PATH = arch/$(ARCH)/lib/$(EFI_LDS)
 
 $(obj)/efi_crt0.o: $(srctree)/arch/$(ARCH)/lib/$(EFI_CRT0:.o=.S) FORCE
 	$(call if_changed_dep,as_o_S)
-- 
2.47.1

