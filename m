Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F58C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 23:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F468879E0;
	Fri, 16 Feb 2024 00:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="gsEnvFUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD7887B8E; Fri, 16 Feb 2024 00:25:57 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF518765B
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 00:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 8bcf0d32-cc59-11ee-99a2-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8bcf0d32-cc59-11ee-99a2-005056999439;
 Fri, 16 Feb 2024 00:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=oruyYhWL43sGVutmRlVQTIJprjjXr3DzDmOIIXcDQkg=;
 b=gsEnvFUi+z8nAyKnOcR/AiTs344hdLtYdpGjEE4CJmCJkmgV7I7P7VFKHFqH/5dQDTJENu8sl1dHP
 B8alekXFy2/cFKCZBouHWagYi8S97J1tHcImTV+vmpoUMuYLEZOjcRAYoUDgo5sFZDGg+r0f77bgsC
 n0048551F+GXPXT0=
X-KPN-MID: 33|uFSDqjcwHhjV/oXhry9focOHI8DbbuNgRSGQ6UmLO7Vm9r29YHgUs+jECx/55aJ
 KGPdKgJ2XDG3YDa/Lby/evCKx1FZsqoYkNS0RYNY1qsg=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|B1dcmwd9QCwtNb+4z7hRaLqpsfwltR0xgM0faeqTITRMbQUAIw5q6+2MGHtzR13
 ZvoWDZvSj0mYkLlzDFJCmfg==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8f0b491b-cc59-11ee-9e7c-00505699772e;
 Fri, 16 Feb 2024 00:25:52 +0100 (CET)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] efi_loader: Don't carve out memory reservations too early
Date: Fri, 16 Feb 2024 00:25:34 +0100
Message-ID: <20240215232534.61854-1-kettenis@openbsd.org>
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

Moving the efi_carve_out_dt_rsv() call in commit 1be415b21b2d
("efi_loader: create memory reservations in ACPI case")
broke boards that create additional memory reservations in
ft_board_setup() since it is now called before those additional
memory reservations are made.  This is the case for the rk3588
boards and breaks booting OpenBSD on those boards.

Move the call back to its original location and add a call in
the code path used for ACPI.

Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI case")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 lib/efi_loader/efi_helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 5dd9cc876e..58761fae78 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -456,11 +456,11 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
-	/* Create memory reservations as indicated by the device tree */
-	efi_carve_out_dt_rsv(fdt);
-
-	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
+		/* Create memory reservations as indicated by the device tree */
+		efi_carve_out_dt_rsv(fdt);
 		return EFI_SUCCESS;
+	}
 
 	/* Prepare device tree for payload */
 	ret = copy_fdt(&fdt);
@@ -474,6 +474,9 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
+	/* Create memory reservations as indicated by the device tree */
+	efi_carve_out_dt_rsv(fdt);
+
 	efi_try_purge_kaslr_seed(fdt);
 
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
-- 
2.43.0

