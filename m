Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7EFC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD36680FE1;
	Thu, 27 Feb 2025 15:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="UNyCyuZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B6A8810F4; Thu, 27 Feb 2025 15:48:17 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C86C80FE1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5F6A625549;
 Thu, 27 Feb 2025 15:48:14 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cX0fPRboAqE; Thu, 27 Feb 2025 15:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740667693; bh=ivVPWeJhSo2RUdoZfYBKqHRZNXGpeCMImHNBK/Ly0+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UNyCyuZUAS4xjWmi1WltaujmibAPdrBje2SvaUYrFCx5og810oojOf3vSYx0yItOj
 rJsbY/pjsjcmmapYbGuh03bS+8xLD/q83j2WXIJCwp+giyqXKquyMmIamzj9YP98q1
 UIBE+Ljd/mQatZF4KwoGPmHdbj8xThU6E03lvgvy+/hKxsqYY4V24LzNnfSSYfSybV
 Myx/KXRGtb3hmp6dwKwYr2wKiL96xeNJ6811273TrmZV9h/sqnLMCUykyrW20QqXXs
 43Fs7+XUEGsHBn0JuBGhGWX6NhasBgbmO+e60oRD+00Yhkw2u0q9oF2/Xkiw/o/P4b
 IGuMQh0Wiknaw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/5] board: qemu: riscv: Remove duplicated board_fdt_blob_setup
Date: Thu, 27 Feb 2025 14:47:30 +0000
Message-ID: <20250227144734.61458-3-ziyao@disroot.org>
In-Reply-To: <20250227144734.61458-1-ziyao@disroot.org>
References: <20250227144734.61458-1-ziyao@disroot.org>
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

The default version should work for RISC-V QEMU.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 board/emulation/qemu-riscv/qemu-riscv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index a90222ea6a4..70190ebe8fc 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -63,11 +63,3 @@ int board_fit_config_name_match(const char *name)
 	return 0;
 }
 #endif
-
-int board_fdt_blob_setup(void **fdtp)
-{
-	/* Stored the DTB address there during our init */
-	*fdtp = (void *)(ulong)gd->arch.firmware_fdt_addr;
-
-	return 0;
-}
-- 
2.48.1

