Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41727CF9C69
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 20:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4323388CA2;
	Sun, 22 Sep 2024 22:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=at.encryp.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=at.encryp.ch header.i=@at.encryp.ch header.b="eIsdJ6EH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FC588279; Sun, 22 Sep 2024 12:11:17 +0200 (CEST)
Received: from cheems.de.box.skhron.com.ua (cheems.de.box.skhron.com.ua
 [195.201.247.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E534288953
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 12:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=at.encryp.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lekkit@at.encryp.ch
From: lekkit@at.encryp.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.encryp.ch;
 s=20240721-cheems-de-box-skhron-com-ua; t=1726999875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0VmJLlnlfM0/bj3AFZto43eI2jHvqwU7hB9QNE6Vv0=;
 b=eIsdJ6EHT+eo0psXUrcZEycczNX4GslwkjGo01B5Nl1eOYmo978xTvsj1rIjyRkljA1kLl
 gi2MOLfbMxCgR+OKbi4KJHlFTMcRVc5rsVXx7VZu5xwSwxL5rviSiS8w/sroS1K/mfUWfL
 uTTGxA1j9VebWrBQwlfqgWATwextpxYG0tZftPdCx2928FSMcamG1c09wrctDW8AdUlczF
 bWt25YutNh8pCLckiixdWKg0r93EhQ5ScVm6tnvZqrKVS2zamLaUPioLe88ehHW8T8KeyI
 GWeYQ03acg1ukiorOc4ezk1QXf/SCl8qFbTK/laco8dpBt/mV5rKw/4ih+KrnQ==
To: u-boot@lists.denx.de
Cc: nyandarknessgirl@gmail.com
Subject: [PATCH 3/3] riscv: qemu: Explicitly advertise RVVM support
Date: Sun, 22 Sep 2024 13:11:02 +0300
Message-ID: <20240922101102.7010-3-lekkit@cheems.de.box.skhron.com.ua>
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

This patch series enables full RVVM virtual machine support which was
earlier inconveniently provided as out-of-tree patchset.

This should be cleaner than a separate board config, since both
emulators provide similar feature set.
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c..7c52e666 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -21,7 +21,7 @@ config TARGET_OPENPITON_RISCV64
 	bool "Support RISC-V cores on OpenPiton SoC"
 
 config TARGET_QEMU_VIRT
-	bool "Support QEMU Virt Board"
+	bool "Support QEMU Virt & RVVM Boards"
 	select BOARD_LATE_INIT
 
 config TARGET_SIFIVE_UNLEASHED
-- 
2.46.0

