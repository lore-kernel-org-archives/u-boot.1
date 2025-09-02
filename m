Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B780CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47EEB83A7A;
	Tue,  2 Sep 2025 10:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PwNfRaDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DD783A84; Tue,  2 Sep 2025 10:19:56 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F6483A64
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7EDAF25BA1;
 Tue,  2 Sep 2025 10:19:53 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GOcpLh6sZSZf; Tue,  2 Sep 2025 10:19:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1756801192; bh=3wdPOW4+ka2vcRo8S32MAohJJDVEFseJT46nYNZixp8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PwNfRaDyg032vsNWQ6YNjWSkbuqVqiFmdt8KMo6VzBJ3m25lvxUCX7+So/rPSg2Ac
 Fk9HyKpy65Kv9YO4lkVkn89FGcXUVBYw+wEw3VHp0pxR92zSBz5DarEBBW2da7txSb
 /ib7zGkCQ+TW5HyMj63J5Z5fQdgYQLtmM/2kT71v2keIoYM6NFx2Wo8ZMTrl6FoWFe
 fMoyZ5Bs95McbAi/hgQtuG+ja8+WSMi74NdZ2QVqQ9gflqFyt4YEYqYXeaevHRFTPS
 LV4vpnPIIfhDn/x8yUY7jZ7Lp8Zo6Ms4HsmfT6gI/O4P3EFJVVe6ObLERQeT4bSNTW
 fROQ4hhdm4m/w==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 2/3] configs: ibex-ast2700: Explicitly disable Zaamo and
 Zalrsc extension
Date: Tue,  2 Sep 2025 08:19:31 +0000
Message-ID: <20250902081932.21103-3-ziyao@disroot.org>
In-Reply-To: <20250902081932.21103-1-ziyao@disroot.org>
References: <20250902081932.21103-1-ziyao@disroot.org>
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

This board supports neither Zaamo nor Zalrsc extension, thus we want to
build it without "a" specified in the ISA string passed to compiler in
case of misused A-extension instructions. With RISCV_ISA_ZAAMO and
RISCV_ISA_ZALRSC Kconfig options introduced, we must explicitly disable
both of them to achieve this.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 configs/ibex-ast2700_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
index 6cb2a21ed2d..ec30fa1ae10 100644
--- a/configs/ibex-ast2700_defconfig
+++ b/configs/ibex-ast2700_defconfig
@@ -23,7 +23,8 @@ CONFIG_SYS_MEM_TOP_HIDE=0x10000000
 CONFIG_BUILD_TARGET=""
 CONFIG_TARGET_ASPEED_AST2700_IBEX=y
 # CONFIG_RISCV_ISA_F is not set
-# CONFIG_RISCV_ISA_A is not set
+# CONFIG_RISCV_ISA_ZAAMO is not set
+# CONFIG_RISCV_ISA_ZALRSC is not set
 # CONFIG_SPL_SMP is not set
 CONFIG_XIP=y
 CONFIG_SPL_XIP=y
-- 
2.50.1

