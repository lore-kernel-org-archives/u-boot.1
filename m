Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8DBC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 16:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2507A881A9;
	Fri, 17 May 2024 18:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BoFy/XDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B266881C5; Fri, 17 May 2024 18:06:35 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E2E8818C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 18:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (18.pool62-36-37.static.orange.es [62.36.37.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 73FA73F2B1; 
 Fri, 17 May 2024 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715961991;
 bh=8KIRakQBEwcXhygWkcDqWViyI7UCpc1kYzwuXxm0LOo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BoFy/XDXygKOqg+GfLND8E3Tjr9hz/KvMPFBNM+vQHeXUbPBf7yGe/PkHiGvJ13zl
 TaLFQKGbMzByuBGRitmtSYG35U5ctbECQ04CsKV/+q1EPPAzi3vINrKQYIeIjvOZXR
 x2W7ZXojMm5pszFyqmJeZsm948fR7yHEVzW7Kp2Nw1HsE/hUSbXE6VSyDuztCQyX3V
 Entw788wcKFOcQpwUMaB03rG7XST8FUnI7tJYOc6W5GEZXfTVLsqCsn/RFPn1RsSdB
 UM6I10gOidVxjZvE5VHXC/DynwuYz21lWr8mNB1TUWRrHpEIcZiNYPXTnpUOddhBvw
 Ml/2FToR2UMJg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] defconfig: disable VIDEO_COPY on the sandbox
Date: Fri, 17 May 2024 18:06:24 +0200
Message-ID: <20240517160624.156962-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Since commit a75cf70d23ac ("efi: Correct handling of frame buffer") the EFI
block image transfer is broken on the sandbox.

To test build sandbox_defconfig with CONFIG_EFI_SELFTEST=y and execute

    setenv efi_selftest block image transfer
    bootefi selftest

Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/sandbox_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5c..80c310b8e82 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -318,7 +318,6 @@ CONFIG_USB_ETHER=y
 CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_SUN12X22=y
-CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
-- 
2.43.0

