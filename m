Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C031CF9C64
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 20:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D202188C86;
	Sun, 22 Sep 2024 22:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.encryp.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=at.encryp.ch header.i=@at.encryp.ch header.b="AhwXFmWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DD4C889B3; Sun, 22 Sep 2024 12:11:15 +0200 (CEST)
Received: from cheems.de.box.skhron.com.ua (cheems.de.box.skhron.com.ua
 [195.201.247.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774A288279
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 12:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=at.encryp.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lekkit@at.encryp.ch
From: lekkit@at.encryp.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.encryp.ch;
 s=20240721-cheems-de-box-skhron-com-ua; t=1726999873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kAGBoRsU/9pR3O1RCFF9oSuFeM35Pz1dZ4iNpqfltVo=;
 b=AhwXFmWjPEsOPVszXc7tsfL8OWIwDG89Vy/wppIBwJcbkwJ0Xdbo1c5rkC1spf3Le3svx7
 ddOw/HEWQf7YV6rxhaBjcJLfLyXza7qmqUYqDD2isQ5LKYNEI1wP0QpQn9TqcjSDSqc6fd
 bez1WwjGR60Xmpfh84reKMk6gyleQr3WA0axx02E6B6IL4wAUnMFVmVjKaDAwL/DSM8+SW
 ukjBccfIVMfbUiaXMjEZ9jG+Fq3oguA/jr5SezClJ2AoTUOPtef5N8b96Cyeu/nv97JuJL
 dE8un5+5NAjvV2r+cofEDC9dqYxwAQI7Bl+ZEeEFL+yeChN7J1ebjnqXi/Itzw==
To: u-boot@lists.denx.de
Cc: nyandarknessgirl@gmail.com
Subject: [PATCH 2/3] riscv: qemu: Enable EFI framebuffer
Date: Sun, 22 Sep 2024 13:11:01 +0300
Message-ID: <20240922101102.7010-2-lekkit@cheems.de.box.skhron.com.ua>
In-Reply-To: <20240922101102.7010-1-lekkit@at.encryp.ch>
References: <20240922101102.7010-1-lekkit@at.encryp.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Sep 2024 22:14:37 +0200
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

From: LekKit <50500857+LekKit@users.noreply.github.com>

Enable framebuffer for better virtual machine integration.
Some guests need EFI FB to work properly.
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index 9538c66e..012ac14a 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -58,6 +58,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply E1000
 	imply PCI
 	imply NVME_PCI
+	imply VIDEO
+	imply VIDEO_SIMPLE
 	imply PCIE_ECAM_GENERIC
 	imply DM_RNG
 	imply DM_RTC
-- 
2.46.0

