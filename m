Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0702C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 20:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AB787F39;
	Mon, 26 Feb 2024 21:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="XawCiF7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C5D87F3B; Mon, 26 Feb 2024 21:35:16 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC61687F38
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 21:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 729878b6-d4e6-11ee-b64d-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 729878b6-d4e6-11ee-b64d-005056994fde;
 Mon, 26 Feb 2024 21:34:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=Haj6vvtJChuTF8KRxQi2+ewf8Au/nejUFo7+3enTVpg=;
 b=XawCiF7sf0+T6+jpUEyxKF1ynipjzqT4aNpjcRZMwuG7AbDta0oq1UaubqGffp+obV5QP2cHPhYck
 wQCfurgTlBVT2jhVqz9opFZJ2Oqov74JFn3r5L1PhC+2U5w9tyKFtaXZFtqLS0sV9reYBBfXB0P61B
 oqg1ush7FvFcGICA=
X-KPN-MID: 33|ATeL0beTsR964gOtsQk0U+gAOm7CxVBa9QPWRCH2Idv86G2AgIZtfV/4LgRQl7F
 mR3C0yUy5nkUJKBJ7nyxfCX0tJLQWzbQuTC6GU9V+LJw=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|CR3Us4sutCsxdD6hP9/Qj/pmU4cA8VXShGW5H8agkA3JEiXcXwyzl89Bu9BEuMx
 uX1QXtZ18gdqCIuGkLdv76g==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 8ad7e447-d4e6-11ee-8952-00505699d6e5;
 Mon, 26 Feb 2024 21:35:13 +0100 (CET)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2] efi_loader: Don't carve out memory reservations too early
Date: Mon, 26 Feb 2024 21:35:09 +0100
Message-ID: <20240226203509.36563-1-kettenis@openbsd.org>
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
the code path used for ACPI after calling image_setup_libfdt()
such that memory reservations made by ft_board_setup() are
applied when booting with ACPI too.

Fixes: 1be415b21b2d ("efi_loader: create memory reservations in ACPI case")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---

ChangeLog:

v2: - Call image_setup_libfdt() in the ACPI code path


 lib/efi_loader/efi_helper.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 5dd9cc876e..5f8d9a17fd 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -456,11 +456,16 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
-	/* Create memory reservations as indicated by the device tree */
-	efi_carve_out_dt_rsv(fdt);
+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE)) {
+		if (image_setup_libfdt(&img, fdt, NULL)) {
+			log_err("ERROR: failed to process device tree\n");
+			return EFI_LOAD_ERROR;
+		}
 
-	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE))
+		/* Create memory reservations as indicated by the device tree */
+		efi_carve_out_dt_rsv(fdt);
 		return EFI_SUCCESS;
+	}
 
 	/* Prepare device tree for payload */
 	ret = copy_fdt(&fdt);
@@ -474,6 +479,9 @@ efi_status_t efi_install_fdt(void *fdt)
 		return EFI_LOAD_ERROR;
 	}
 
+	/* Create memory reservations as indicated by the device tree */
+	efi_carve_out_dt_rsv(fdt);
+
 	efi_try_purge_kaslr_seed(fdt);
 
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
-- 
2.43.0

