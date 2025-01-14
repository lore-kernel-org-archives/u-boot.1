Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD42C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 10:30:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4BC806FD;
	Tue, 14 Jan 2025 11:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EaLVgw7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1748806D6; Tue, 14 Jan 2025 11:30:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC1E480285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 11:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7E41A3FA7B
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736850606;
 bh=J44QvD53E2Ijs4iUClpOqecnpptpWOA/iUvcBB/Wzj8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=EaLVgw7R6cEgF3Bc8LAhKYTSpG7dMbKvGj4f8niIbfSmYpXmV/xJzqqCLgdURnOG0
 Hh1Zc4evd0fvH/fNRbfdcnXI2Mx6C3Y+peXELTRUTLgZkMxmulY8qdRvwrtN/dOAZ0
 Xwc5D/RI8FPbkCDdFhAaXPW9WpHopc5G9UfedD9mq0EhpFFeFq2NYsFUWhI/2/LTSB
 jM22Krfw6QIpa7iIbhCtEAdFjf6sS60n7x9ej99WMJZkpxYp2GklYB2zH+sK5j4Czb
 0yyfzwFqQ8gM0AFs8i2BykaCVGuZjdkIzM53VCc6aKwFxaeARBdLo2khHqhRJodT5+
 NuAQDjPvtovqg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ac607b6so41030845e9.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736850606; x=1737455406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J44QvD53E2Ijs4iUClpOqecnpptpWOA/iUvcBB/Wzj8=;
 b=FvH6qRhYiBEuCB0ESaDZBTqyxkLbTMRQRB5FeyLEjwZYFCigHXX4vSK041fBLMD7uR
 OK/ErVic0Z7DyE+EI+dnyetsTkQLtWe3ViaJaIbpg3UGFSIAgg+wHs0brgOFz9RNaR1m
 9G7rulv18DgnSCEpoAVB/BzLuk211FqUzNthymyT4u6s8PncdUlYgM/MjD4KD/SMRbWi
 omeIY1U32gpWDwgpqi5s3rgCL+WQI3t4NAY/CLg64/q9Mfvj4n9gg8q5Nv7jWWlPZp7L
 vq98XY0UUZGf6QAjmAz4eWyp87WbKt7AQvHVNlArOl+UdPIfk6Umi1GCjAJhbzNq4nf8
 oE2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY8a/LDkHhSGhHNyz4OBjzYEvqFfTkJgG7Jkzi4f0Xz7ub84/DyS1OD+hDHMfsMn97AebcyOc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3rhe1m9jCaDbr6aDViwOwSQQh9aISTodpGzRkcHbKZp8kgXtx
 KPc4K8hof8BEuAKgdHpk+wPFL4+LfE/Lilq44AGbhnc70SnA3VOQeEcLdTeY4VV0qBS1TbBOoWq
 eoja/oZ5f6G7dQBZO5bH+PRMIcCxCU1y/9Fje2sd5rkZp27o/gZfF8W7khsDKEWRSo8g=
X-Gm-Gg: ASbGnctOPi8/a9i5HQ06uVDilLq0W8GIIGZH2lWT+6M5dDq9xoZelbgzUg7NQMBGoTF
 +e/jdqFz2ctPPogkD4KU5aJPPow6KSTwH9tYBMT0wpLbWx2fRpdMl5BzCmF8CEZVm82Ox14m13R
 F1JVux2Qf30lAalvO9eGAid3M9qedFZIYQB4M2mF9bbX4YGW8CbJ/WqdWAr5A3C+PuYV+J3ILGM
 wKBmN0HWq1ullLFSu3TF2BmQ+zc/ZAs/OS8SBIB1mMO1LiVkxkvq5tNWmaXLMWd8oyRTwux/kOk
 bICn+8t7UWBiqaQ=
X-Received: by 2002:a05:600c:1990:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-436e26ae2abmr190725085e9.6.1736850605845; 
 Tue, 14 Jan 2025 02:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVwGJoPhZcbCa54bUsbDKXM4GKPJNyLfXqoyCgIKzwL0aENmmM0JE1mxIbPz2uzBiEkKFmzw==
X-Received: by 2002:a05:600c:1990:b0:436:17e4:ad4c with SMTP id
 5b1f17b1804b1-436e26ae2abmr190724885e9.6.1736850605487; 
 Tue, 14 Jan 2025 02:30:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:642a:6b6a:606c:5383:21d9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc8826sm169996455e9.11.2025.01.14.02.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 02:30:04 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/4] scripts/Makefile.lib: add -L option to LD command for EFI
 binaries
Date: Tue, 14 Jan 2025 11:29:51 +0100
Message-ID: <20250114102953.64381-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
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

