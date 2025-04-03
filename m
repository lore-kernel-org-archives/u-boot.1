Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F041C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D523682054;
	Thu,  3 Apr 2025 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NyduLBok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1375C82075; Thu,  3 Apr 2025 16:47:48 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF82982006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC945402F0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743691635;
 bh=/xhoR65nSieUPeLlUBxfmm/hqraqUz11QYLxYVtrsO4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NyduLBokhQ8jWdW5Rc9Nkqf97DGFf8kXNv/cpRqWY/z/FrXdbfVanBu/yOY5+9BEf
 fTNj11WyT0xCoTj/T2eOk+11s6/Vb0DM6sPE2Xr9UQoj+V6pg3s5tY5fHhM3Q8eTJ4
 Ym//FZePZ2Ha2HFjlohBSljrsO2FzK4BI1HU+WYBEAzT8O3zL3CTIFhDmydERxoyiE
 E6ROpZzwIHTCt4HCOWiVwfQYkMSDnfaj4a1mP/Achop4XxyDxIY1MapOffyw3mFEzU
 cyz0ef3qefGvV1gQgvNdVzGWOvzDwmKulnMeF0VBcEht8VBc80zgNhzceELiZr2a/P
 7lOOH2y4pExBw==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39c2da64df9so731189f8f.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743691595; x=1744296395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xhoR65nSieUPeLlUBxfmm/hqraqUz11QYLxYVtrsO4=;
 b=g/tH7UGkd4ubTNDaQ8HAKOdllD6Y1MOorvDsKD4FsMFIeeVk9w3gT3Pl4fphVJH+47
 GIyUchxr6LXAWatIg5g/9PkYk4LQWc/58gOIwvwTtYSWDChctgzQphFMMmmMm5LOWGKU
 VAyhzy7NENPbqVXXgGbaNAG4icM9gj/Xkm7eYzXlyrucbambC+Ya6Duf4K/a07VeF5T4
 DjlySM4/s4Kx7PfuCIj/Fq6cepuUjVghj6tJaK9XXqkYn39yta598bImrGVYw2EV7Eyh
 jslNDCnI8UWRoNOLplTWVXMW9N+O1km+AV9vlxEsDKuXqSKIj6mDYt8kVLUp5Qnm1+Op
 Q1hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbrGJDXl6oanNTotObuZyfXPYqM/MZDlvvn6uZBtQtCRfpgpz7/02D/IcyR+pfo5PyL05QqYY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+6gB9iqCkCwOLA9mvfCUDnLLfuRfDR9bWlxSRhsetodOL9v6+
 0nybNYJdfEHraVEWY2lWyicE6AaCLxULMuQZobLXfbj2zB/s/O6fY5iNKJtMVzOdwROCu2RxSe8
 GutvfoHMmRJjkU/Asz8rxY6wi/qI3zssOsFzOXXPSgoaYiXg0XxSXM0t83ZQ9xDei0c8=
X-Gm-Gg: ASbGncu+5kxt2wfGUVLXuqC0DVqNIpHsTXNAefhiPlFWRL2GpSDwdFZSanq7Myl4J5f
 DXNTuAt1ICXDRbNp9gFKEgYqMteXHgqt0CMXHyNI5FZykbNAfs3TPuYXI9MipDtqsLUJj/SRWGc
 VJFvVAIyUcTQOigTSA81uayMV9Vkr2gXU1UrqVI3WAv7HGVgtVQYaT+53KNgnspynAwFIA/7wFc
 Ka5VfRRNIFKuiHoy60bsNfHfP0mAR2QN1MZ05cETgmUeSNJA7EDlFNyH6VVkMuYR2BuLQ0PTOkg
 YQSQD2l1BCuWi0QheoKIMhRrewnhnLfC0Uctkg==
X-Received: by 2002:a05:6000:40db:b0:39c:1257:cc25 with SMTP id
 ffacd0b85a97d-39c2f96420emr2960282f8f.56.1743691594759; 
 Thu, 03 Apr 2025 07:46:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFhglBEGqFZW0vFSlC+2llKSWxge2gJgSudLnS6GaMXB5Ei4QzEhAxqSyxoMo3lwP7FDExGw==
X-Received: by 2002:a05:6000:40db:b0:39c:1257:cc25 with SMTP id
 ffacd0b85a97d-39c2f96420emr2960259f8f.56.1743691594361; 
 Thu, 03 Apr 2025 07:46:34 -0700 (PDT)
Received: from workstation5.. ([2a02:3035:6e0:be7c:f00:839:af81:4bb8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b42besm1971548f8f.41.2025.04.03.07.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 07:46:33 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
Date: Thu,  3 Apr 2025 16:46:27 +0200
Message-ID: <20250403144627.1064873-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The number of memory banks in QEMU is not bounded by 1.

In this example we have two banks:

    qemu-system-aarch64 \
    -machine virt \
    -nographic \
    -cpu cortex-a72 \
    -m 8G \
    -smp 8,sockets=2,cores=4,threads=1 \
    -object memory-backend-ram,id=mem0,size=4G \
    -numa node,cpus=0-3,memdev=mem0 \
    -object memory-backend-ram,id=mem1,size=4G \
    -numa node,cpus=4-7,memdev=mem1 \
    -bios u-boot.bin

Use the default value defined in /Kconfig as 4.

Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/qemu_arm64_defconfig | 1 -
 configs/qemu_arm_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 03028c76acc..6c9d2505a69 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -3,7 +3,6 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_BLOBLIST_SIZE_RELOC=0x2000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index e09f54e0685..2d642f86ba6 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_BLOBLIST_SIZE_RELOC=0x2000
-CONFIG_NR_DRAM_BANKS=1
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
-- 
2.48.1

