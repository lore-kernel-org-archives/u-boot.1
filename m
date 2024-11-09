Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEB2D5E364
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 10:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0501388B99;
	Sat,  9 Nov 2024 11:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CVc+VJ76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C77E88EAF; Sat,  9 Nov 2024 11:31:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D521A88B99
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 11:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-072.46.114.pool.telefonica.de
 [46.114.106.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2F68240275; 
 Sat,  9 Nov 2024 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731148306;
 bh=3eNFLS3kDBD6jPgmTosBU35CimPVUqp9wW/5wGsRvCA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CVc+VJ76CKtbzkxfrmwGrtLt+E+L2hdD1ClRYVmN0XfJiDjvcm2vY5vMEDQralG6M
 OvkdEX0i6K2m1xHWpEu7V3IuXMsg0AzZc29U9Yi8TEuEmOlCerc7o9eLUA1/L01ng/
 JiMgV2PsVSJYZ9b4aDBvEbArgqBODvkM7rEzOmEk9yPEVCNXtsDpypjPCa4k1f9CVE
 ustF9VUW1abFoJnSwcm1KSKmAyVhOwMh8YVJbJFYsvByEj8AghZYG/jtvyEC8bl7Io
 JIKazNYgDjhPilscjkPRfXLS7NDySv60OcWkq5Il/D3Fzt1TtFTE6ZwfOD7IfZuxIV
 GgKTFCxgUSJMw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: provide valid PXE architecture on sandbox
Date: Sat,  9 Nov 2024 11:31:41 +0100
Message-ID: <20241109103141.33983-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Before this patch the sandbox uses 0xffffffea as PXE architecture.

    => efidebug defaults
    Default boot path: EFI\BOOT\BOOTSBOX.EFI
    PXE arch: 0xffffffea

With this patch it uses the PXE architecture that matches the host.
This allows us to use bootmeth EFI on the sandbox to load an EFI binary.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index bf96f61d3d0..14049378930 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -75,7 +75,7 @@ const char *efi_get_basename(void)
 
 int efi_get_pxe_arch(void)
 {
-	if (efi_use_host_arch())
+	if (IS_ENABLED(CONFIG_SANDBOX))
 		return HOST_PXE_ARCH;
 
 	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
-- 
2.45.2

