Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43932C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 13:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B874A81335;
	Fri,  7 Mar 2025 14:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Vwoa1yiZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 497C980E94; Fri,  7 Mar 2025 14:14:44 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6308380079
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 14:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1F34725D4F;
 Fri,  7 Mar 2025 14:14:41 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y0DtLcCxMX4N; Fri,  7 Mar 2025 14:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741353264; bh=MQBEmaKacJlUle0iM/cy31bEVmWCLLaqjomUtvBDBiU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Vwoa1yiZomlZTckDblFIeZIuNW2Vo/5S7TJjk+Ws0wM3lFluJco9txPJUMDqcy/Io
 TZ+m6aWScGmlwE/UE5fJO2jZkrnwxl6TqQBbKalucvv5iqYykVpb0gugJ7imNSvswi
 QQMZiSNbD03B8oFRV/M+CtZMe2tTfubdGv3Gnkw1iymAppguQSIZLe4sG23CIfxxX0
 tWFZ5bZ1NuTeC7NK86uYYTeR2w8i7xEml6Kx+8dIVGO4BD3N/nyrIGbtI8GqYY8Uzb
 tQxLR4CwYupdX4IYY2kZnMev21D6QnQHOd8lXTKExlHBuIUrtGoDI+7fcxRJKXLA4v
 f4jLB7skG35Xg==
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
Subject: [PATCH v2 2/4] board: qemu: riscv: Remove duplicated
 board_fdt_blob_setup
Date: Fri,  7 Mar 2025 13:13:42 +0000
Message-ID: <20250307131344.43762-3-ziyao@disroot.org>
In-Reply-To: <20250307131344.43762-1-ziyao@disroot.org>
References: <20250307131344.43762-1-ziyao@disroot.org>
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
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
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

