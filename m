Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC218CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 17:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327BD83990;
	Mon,  1 Sep 2025 19:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sMDcKzVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013AE83A31; Mon,  1 Sep 2025 19:03:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFC5838C1
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 19:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB8833F28B
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756746234;
 bh=G7c/SWqBjuAsDCkY6nVrcDYycfKQsqgYy2vNBtmhwMg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sMDcKzVZrtHc3QulDV55iwC1EMGRvGYgM8BoQP7onbfBnZcFsqnpmoL5sDmVnXtQU
 bDmiN8ENGtr7RP2lXxQKvIlF5LHmoBK1d2rHcrDXkhNONJzwNDEHXD/znrvmA6lbLE
 S40r5LWFDgWghf3V9dIpkvYHfqA5RSmVpqC6Wg5ynQN9CsOg4h/xsn8olYJYQNDigR
 QntyiXOkzXFxyjMkMA3QkIygBHpWui5SEmzAakiOV4xpUS/MxiuXB/g1AOs1GSymsV
 motABSi3zg1kXbXC8RHVagrkYjEYIs66RTFX6NpqXcsJPLod8KGTK2Gvq9U5tA+d3m
 8458TtGCSCPvQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b869d35e6so12278295e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 10:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746234; x=1757351034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G7c/SWqBjuAsDCkY6nVrcDYycfKQsqgYy2vNBtmhwMg=;
 b=gvhUW/LEeqjkXpfJPPW2i1TUE8ZmjbLxDBakO/irchRhABKqa8OmxodsNyQnR67L74
 ch9I4IgB6qzSfOmPKCyuYf/kOqtbZrjaFc4cDXrbgw/OCsDOnQ4OrNOkv/Ya+u/NKrxl
 SH2yxtavxaZnf0zBEfdIYT1Bnxd7DIMN8G+c5gZRjYthYMWCEjUXRIcQ3Nmll7qtpe5V
 cjkL6dA3+8cs+olPfXBDGYRXTlEq32VKt14ts4nzhKgbydZlhpdndsMDxZiNMBbDx8Lk
 iFPqkA0SnvsTrW3VxpIhLlUlUcAnIHIrlog+IE0C4KQOcuCnuMvCeNKeDMMPAGBlriuN
 aANw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7mbyIFfNX2A+dONBrHaI/X1snVsDeSgCEARn3WfQYeHr4F5sZg4q3YUL8i2Bk8ohPR/K/Zqw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1R4FNJ86947E8Z+ya20XzC4W3c23gQgNSZb2TkXnLoAzp5iVY
 lLQ9S3SPZCWojHflAT6UnTRbLqAq0OsjNrm2b/kbQZkacR57r9yuws0PBKnnH+gvVhetJSphrwm
 IwT0uViOz0oZExDZ0nTFfKvQHrZvZ6uzOdSIBSRQ7QAStNhz068xAwFavNNxtXfw+LK3j5iw=
X-Gm-Gg: ASbGncv1RR5C8A18YlrNcEzRNnbBznAsqBa9M4EZWGxF4zARmKj//4vFwiJzhIP/Bw8
 FdT/x0noZQqurCKETTuVcp76Im6ufrnUvoOPOh2UHIGoZrpxaiIXcFaJ9lEq6iPE5kKFw3LouQz
 qMslddL5AmZs+gqMHFAEnQd/Wz7KCpgM/pdSsg59faKZCdOvPMeP4qfEsvtoODD+zV+CB96pbYd
 0XQFSjQbqPKkO9YLp2DsQ/rFvl8e4409THl/lF/2nQcdanA4CDCwHbwwxXUfea1jXK6xSE+gq7q
 z2vCKK6DBP5B/RNgE3yM+VwOim1L3JRm2okwSFkdwsUJUrHKj82ATjISNVMw4TOxgCVFHD4rpTx
 pnoRDmLjG3gosXAaM549D/UUsOs5OGVE=
X-Received: by 2002:a05:600c:4f89:b0:45b:8d2a:cce7 with SMTP id
 5b1f17b1804b1-45b8e2ee782mr28819545e9.15.1756746233965; 
 Mon, 01 Sep 2025 10:03:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw0OEw6G5QvnWntHqsdXzmDO2jRk7ZUHqJEADG1RutAT28sRUmphk5FJbU/VvvV0ssUkSVXA==
X-Received: by 2002:a05:600c:4f89:b0:45b:8d2a:cce7 with SMTP id
 5b1f17b1804b1-45b8e2ee782mr28819275e9.15.1756746233548; 
 Mon, 01 Sep 2025 10:03:53 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7ef7cfsm163955835e9.6.2025.09.01.10.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:03:52 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Harrison Mutai <harrison.mutai@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alex Shumsky <alexthreed@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Raymond Mao <raymond.mao@linaro.org>, Joshua Watt <jpewhacker@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH] bloblist: adjust default bloblist size after reloc
Date: Mon,  1 Sep 2025 19:03:08 +0200
Message-ID: <20250901170308.805653-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.1
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

If neither CONFIG_BLOBLIST_FIXED NOR CONFIG_BLOBLIST_ALLOC is set,
currently CONFIG_BLOBLIST_SIZE_RELOC defaults to 0 except if
* CONFIG_ARM=y && CONFIG_EFI_LOADER=y && GENERATE_ACPI_TABLE=y.

A size of zero never makes sense for a bloblist.

When using QFW we need more than 64 KiB to host the ACPI table.
In this case CONFIG_BLOBLIST_ALLOC is used.

Set a reasonable default.

Remove the CONFIG_BLOBLIST_SIZE_RELOC in ARM QEMU defconfigs which are
not compatible with ACPI tables passed from QEMU.

Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Fixes: 6f9b015c138b ("common: Enable BLOBLIST_TABLES on arm")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/Kconfig               | 4 ++--
 configs/qemu_arm64_defconfig | 1 -
 configs/qemu_arm_defconfig   | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index a2f653f7e72..7af438a91e7 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1121,8 +1121,8 @@ config BLOBLIST_SIZE
 
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
-	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
-	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
+	default BLOBLIST_SIZE if BLOBLIST_FIXED
+	default 0x20000
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
 	  has a lot more memory available then, it is possible to use a larger
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 358bb1aeeb9..12ed6b61239 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_KVM_VIRT_INS=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_BLOBLIST_SIZE_RELOC=0x2000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
index d5890bf87fb..e6d4414cf0d 100644
--- a/configs/qemu_arm_defconfig
+++ b/configs/qemu_arm_defconfig
@@ -3,7 +3,6 @@ CONFIG_KVM_VIRT_INS=y
 CONFIG_ARM_SMCCC=y
 CONFIG_ARCH_QEMU=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_BLOBLIST_SIZE_RELOC=0x2000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
-- 
2.50.1

