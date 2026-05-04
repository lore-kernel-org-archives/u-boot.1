Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73141CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA31846A0;
	Mon,  4 May 2026 15:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QQyTpAb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341AF8468B; Mon,  4 May 2026 15:20:51 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1605084255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhw5pK2zdqc;
 Mon,  4 May 2026 15:20:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900848;
 bh=wNOe0KBuhA5n0d6iDlQcBO45jZa3Nffb2y5W+Ci/M0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QQyTpAb1NRmv7zHFjN3Udkf9RpYFJGuKl68j6MkDXOC0KkU7yGwjEoJMudvnVw7PF
 Tf+vDxBTQ9qJJQrd/sFQdeAAW/Gg5z1+kcr+SWXffS5G4sVXSFrENhNc2GsgmSo7IJ
 Hl3FNo+aqN7iHdBq0h1q+ztkCX2/ZnrOTBsJBz4QY/Qj7TiDwIZ5gup7UFhLmHzEA/
 dtTDl1D02ABQm1SLdlHEhrcgyYPpEu+/8pb2rjm74FS+QjqWH2ZPfht2MTVzVx2soi
 eJl1tE3DaGV2Wpr7T+zgPb7cUIs0KandeLzchyr0t4xT0IEpQjZxYtaYkjnH3uGlsz
 t1VYND4cplaNg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhv4Pj8z95B; Mon,  4 May 2026 15:20:47 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:32 +0200
Subject: [PATCH RFC next 05/18] kbuild: Don't try to add
 '-fcatch-undefined-behavior' flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-5-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

[ Upstream commit 7eb8e5f073051eebbf55fa6b90ed2246c2274552 ]

Original commit log:

  This is no longer a valid option in clang, it was removed in 3.5, which
  we don't support.

  https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4

[git conflict in context due to commit 52ee1a0294e8 ("global: Disable
 deprecated-non-prototype warning with clang")]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0404657dac6..a0e9406bc59 100644
--- a/Makefile
+++ b/Makefile
@@ -1007,7 +1007,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
-KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
 KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
 else
 

-- 
2.54.0

