Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1445ECCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 877698144A;
	Tue,  4 Nov 2025 10:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="OeqCt46Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AA0836D1; Tue,  4 Nov 2025 10:58:13 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB64F8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 76966C0E607;
 Tue,  4 Nov 2025 09:57:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 42F66606EF;
 Tue,  4 Nov 2025 09:58:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A9EE2102F1CE8; Tue,  4 Nov 2025 10:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762250289; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=4suNRttU9n5ONuwbAVTX51H2+I7rAv7JAGjoDfv83rQ=;
 b=OeqCt46Qzt9YbWN0PG0L4tHLii67LQxADiT9xshHOzADQ02xBOy5kvKDv/gsszLJiBqWKR
 0DuR9sKJzTNMy5fPAdlzrBIxfivaEWEhSN3zl/3benIWwPbf5mU0W0a8yW233JpAKkXUFu
 hvx+E3gpb2lYx9a60GPgY/fCB+KCbHFPvjBG09IwaRToGdf6WUcK4v6CvDQ2yg7jP9DshB
 tHQERtUxjBINkcOdrHWLb1sDa0boiY3gNJfMFHukvf/1ChJgtmTbjZcDmwlx0BUTIRU7b1
 iUwm4v4x9qwEoqkBq7v535uqHT6py//Dko8OK6PJUUK2Vr7PjeiieACAzWmv+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Bajjuri Praneeth <praneeth@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 thomas.petazzoni@bootlin.com, Tom Rini <trini@konsulko.com>
Subject: [PATCH] qfw: Fix segfault from uninitialized variables in sandbox
Date: Tue,  4 Nov 2025 10:58:01 +0100
Message-ID: <20251104095802.1026096-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>

There are cases where qfw_read_entry() does not set the output parameter
passed by address. This occurs with qfw_sandbox_read_entry_dma, which
leaves the size variables uninitialized and causes a segfault when running
bootflow scan in U-Boot sandbox.

$ ./u-boot
...
U-Boot 2026.01-rc1-00199-gc2637036b8f0 (Nov 04 2025 - 10:32:21 +0100)
...
Hit any key to stop autoboot: 0
=> bootflow scan
     efi_var_to_file() Cannot persist EFI variables without system partition
   efi_tcg2_register() Missing TPMv2 device for EFI_TCG_PROTOCOL
    efi_rng_register() Missing RNG device for EFI_RNG_PROTOCOL
scanning bus for devices...
[3]    1015761 segmentation fault (core dumped)  ./u-boot

Initalize all these variables to 0 to fix this issue.

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
 common/qfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/qfw.c b/common/qfw.c
index 45e87d3ae28..14d48952427 100644
--- a/common/qfw.c
+++ b/common/qfw.c
@@ -109,7 +109,7 @@ int qemu_fwcfg_setup_kernel(struct udevice *qfw_dev, ulong load_addr,
 			    ulong initrd_addr)
 {
 	char *data_addr;
-	u32 setup_size, kernel_size, cmdline_size, initrd_size;
+	u32 setup_size = 0, kernel_size = 0, cmdline_size = 0, initrd_size = 0;
 
 	qfw_read_entry(qfw_dev, FW_CFG_SETUP_SIZE, 4, &setup_size);
 	qfw_read_entry(qfw_dev, FW_CFG_KERNEL_SIZE, 4, &kernel_size);
-- 
2.43.0

