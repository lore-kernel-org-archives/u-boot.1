Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318A5C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66D581E72;
	Mon, 21 Apr 2025 18:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZKL6PzLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E233E817C4; Mon, 21 Apr 2025 18:26:23 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC1981E1F
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 03E4041A04
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745252780;
 bh=wEMaePwENpxx2JsKvcxIvVriksKFyqD3vz2W+UPX+UA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ZKL6PzLyAiY5PfQphTf1trNMNL66wWp5g/byyI8KbJNobr9lIevStzvmtxCZdqf+W
 ij0FKV2+pdYJOg0gZWNZLCQKzkC4Nq4PPLAkCEGOLr1yoQNpn2wSDSwlIxvaP5FfF5
 e3xio7fgPcX3QtmopYCNfVIhBTr1GaYzkzsNcv5eQLytELOVaywpGEGKn69t3FA8gI
 gWprgkDj85jZn0wwOm7AmpKm5P3HtHHpfkHbWqiiuBuSf7itzPlkWnb/lME75BWkOV
 XghbFLBgTQTenuek/UPZAv/owZHUSkc0ZpziW1tNI3UTP4a3UpvDCsHU7PbdkwXUsN
 8742j8kmj9ctA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so1318077f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252779; x=1745857579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEMaePwENpxx2JsKvcxIvVriksKFyqD3vz2W+UPX+UA=;
 b=Hh9xqvVfDKFH14wR/NSbsDUU6vXxOYo4Yg0KuRegL1h2HnwuRdbWQBSPstLKg2UwBf
 UG/0r91GiaLifFQQPNzb9vw7XcG204R/EnK9TuDTvp3Y+cSO4Vyw/NmSVnUD9sqi1vil
 6gUC0xazQsVlvNvkz8OUGKZMXX6PAVOavNcgSZvBEWdwCkjkGY8VAECE0ejHJovM6pFG
 8OecblzTQg1pApoNl2YHcJoWuNhZcwAbkIDX4BjkXAKt1P6rVaTqOmhdRPcPM700mIQH
 RfJaaRceOf7kOA3ENUMyFbUjW8lgcvT0oTxWEpiVfDuzrZY8RQi0CzMVGxFPH6g3iffh
 ZWlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNJrB4YvrXcHSbzwPEuYatD4Ds/QePORdxzTORC+tsM8tSIVJq9swUxzB8N7ERdKoV/mUiQ/U=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh1i6qqnYANLboU13QM6WxbZ99KITh/C74gZa2FACfriHLagQ2
 JpQDGqkWUTZ/Rcx40Q+i2PVKI7nyx7k1ISD85BiWUT48GfENQNHuXDpJbZU9sY2GL7GRpurX0l7
 18z9LV5fFYPlDmdmUkh4sd6b7giMkwLIcSovsDvm5ZW8wG9pM204E6wg9cuacz6XVrVM=
X-Gm-Gg: ASbGncuoxM3btFv6QcnzSFiO935CMykWjnVAd27KbGCG1UmS95aDzqBhduECdbIAFUG
 DbbzBbp1xm2pQ0QkDQ+CD22vwNWLZehXkywK2nAFWl8EGx9uoeEB2FJGVDIl86V18mP9i0Il/OZ
 OJ3HE4BnJKOTLr4BLzyr0TSgMH/ie9SpFCMywOLyjb7T+31QBZSKSOsXekJnrfpsSqnx3bwGInD
 I/JlUl/LLTjFOK2pY33T+FwrFvymPydmKUyQbk1xIi1TomQz8MbrwnPTksHJnD/lnOC4SF0dwFt
 OGdCUBwcv7U+hlm6XisWXW6In/gcHl5H9hd/OE5PeWzAS6TsTNl0GXSKl5/+TCdwz5u6Y+9j1et
 +VfDPxC6gy8PKEg==
X-Received: by 2002:a5d:6d87:0:b0:39c:1257:c96e with SMTP id
 ffacd0b85a97d-39efbb02224mr9027268f8f.58.1745252779023; 
 Mon, 21 Apr 2025 09:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWTqGTfJTy4MITXXUYooNmvRWHXCpUzhOpwFevWViY8cxvaNVQE9gxbc8IKdgwHOn3A1vGkA==
X-Received: by 2002:a5d:6d87:0:b0:39c:1257:c96e with SMTP id
 ffacd0b85a97d-39efbb02224mr9027253f8f.58.1745252778701; 
 Mon, 21 Apr 2025 09:26:18 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acce9sm141456225e9.13.2025.04.21.09.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:26:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
Date: Mon, 21 Apr 2025 18:25:49 +0200
Message-ID: <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
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

Distros expect the EFI boot manager to run. It falls back to launching
EFI\BOOT\BOOT<ARCH>.EFI from the ESP.

BOOTMETH_EFILOADER is obsolete.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc9..71ddb37f6bb 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
 	imply CMD_TFTPBOOT if CMD_NET
 	default y
 	help
+	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
+	  launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
+
 	  Enables support for EFI boot using bootdevs. This makes the
 	  bootdevs look for a 'boot<arch>.efi' on each filesystem
 	  they scan. The resulting file is booted after enabling U-Boot's
@@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
 	select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
 	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
 	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
-	select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
+	select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
 
 config SPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (SPL)"
-- 
2.48.1

