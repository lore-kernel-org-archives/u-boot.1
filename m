Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B128C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 09:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50B9803CC;
	Mon, 21 Apr 2025 11:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Mnkyh1s6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F0B8144A; Mon, 21 Apr 2025 11:43:20 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA8380050
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 11:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1A60140006
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745228598;
 bh=2zBe59de8th9k9ZQcw8SXPFK+6qbsM8Fdm1cefTYSvA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Mnkyh1s6DjXsnMdbVZ7sqzECU5fCdD66Ce+1XJkoFytXh1FnNpw0fIQwWJLBHNMwc
 hpY833iUglNCKnHfTpK3StoDubfhp/N3B4PO2FmR+s0ZwXIx2fMuulXtpskHkdDp0M
 Y8U39gtXE2vaekhmZj6kk1eMT9XEoCU50IsqEhZ9GwbUbtKSgCsagBveOm/j7sFjTB
 c8qmUYeuIoq0k3Mw8tn6YURpOMp3Pvs7KzPyn8PGMRNsfQ3v/mrjaZxnrX5dISMRvV
 axEmn2JDhG7QMunqEk+ZaPEow0/tdHvXsXx3UUGtnK6Ga/YrVwQu0B8+Oc8scmzSAL
 UMCW9r15SINyw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so1164966f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 02:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745228597; x=1745833397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zBe59de8th9k9ZQcw8SXPFK+6qbsM8Fdm1cefTYSvA=;
 b=tNMJEQhGtv53aI7SAWhBlO5R8YmpysRzraCxdPazQ5pWgdAoQ3E3lllNZF8o1NxyrL
 DsvRaaNCyZmpav4MtB08Dy2flYwUd0vrV5xbV+c9tikiQtVASXEIq/4UrgzCNal6jzXy
 cb8JIQtc8qyWhWzEe3RUWx4PwIyiXzGJIA9HBNxmpHwEsMOKiNh6CqDDbH0DOhOEScRa
 FwnhYYJ7gOzRByvr6TgVKSUNncXrSUQb17N3vazzvYoOGx1Y74jSQzqWdmB3J9ekdEF9
 eeYYeyqPradXB+HygAJqBLdxErOSAzWTpAMY7xv7YBp7U75phOuJ2plG4DuQRV5r8y+t
 HaFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ASy4H6IvL0BqtI0vOra8ledKsRSOE/Cluaow8FbKUTiEuvPoUMWmdPowvWuixMusHdrnW4g=@lists.denx.de
X-Gm-Message-State: AOJu0YzWjSctIy4XGT4p1YIMANcDgMbiDzwCd+UC3k11KpjcpFfX/ATS
 /SyabgXT5gPYe3dO4s+P/XJqsc4RCFZ/ly57E1frDt2GC7dZRHsTx1t/WdsI/iKDNs7EoqMgTaA
 gg9eLpoFhgisn+p+lDYYMLrKZUP9CeAw7RYGWILNkqWmx5q4A76U5C48KxfNMvWF0nWI=
X-Gm-Gg: ASbGncuzlNPaHsVA0gdd4etClWaBFCoA2a641qPiqxYBTELH7w0JsuROIkBmgWlLXa7
 f4g4s3qe6AJFddP2KKKjnqEZXL0OoMs5zBQ7HQu14kQ+hZPc8cHpEvl/UnhN9KNjOEfAWLHb5/y
 wj73YGyTB9qtxMbWCJmoDRmBj+iFGv5YQmZnkJ8n7T1Nh3bpC621MzXOoOngtTtl30on2DbU4Au
 uLB8HFHhKmtZw46YFLovbpsr4R043fQH6ocp1qOpQSIfR1IcdR8eIr//X1zj7H/5KHnirefJqqo
 QNH9JueEiPFjMYHODbjulTVsrcJMmgDY6DFSy04DaHbYt/EbqT7UTgIheQub2FYVW9Gsp5Mfexf
 qIYFUPDSrGx4MBg==
X-Received: by 2002:a5d:47cb:0:b0:39a:d336:16 with SMTP id
 ffacd0b85a97d-39efba6d8fbmr7929238f8f.34.1745228597522; 
 Mon, 21 Apr 2025 02:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHInyPkej0dBnxA8a6S2uU1y1e/9hq4zBfB3u+TRrGfKBMe6N18kTgTbZk9abomI4H1HePuww==
X-Received: by 2002:a5d:47cb:0:b0:39a:d336:16 with SMTP id
 ffacd0b85a97d-39efba6d8fbmr7929221f8f.34.1745228597169; 
 Mon, 21 Apr 2025 02:43:17 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5accddsm127075785e9.9.2025.04.21.02.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 02:43:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
Date: Mon, 21 Apr 2025 11:43:10 +0200
Message-ID: <20250421094310.764765-1-heinrich.schuchardt@canonical.com>
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

Distros expect the EFI boot manager to run. It falls back to launching
EFI\BOOT\BOOT<ARCH>.EFI from the ESP.

BOOTMETH_EFILOADER is obsolete.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc9..89076220adb 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
 	imply CMD_TFTPBOOT if CMD_NET
 	default y
 	help
+	  This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
+	  launching EFI\BOOT\BOOT<ARCH>.EFI if no boot option matches.
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

