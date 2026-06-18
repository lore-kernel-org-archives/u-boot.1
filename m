Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2073CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114C5849BB;
	Thu, 18 Jun 2026 17:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iPGyqzXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF7584874; Thu, 18 Jun 2026 17:09:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EA374849BD
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753112BF2;
 Thu, 18 Jun 2026 08:09:13 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.30])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1219B3F62B;
 Thu, 18 Jun 2026 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781795358; bh=15DGNkLn49hQi1XBRr4rYcBVr/FnwfduaWFuDejLAaY=;
 h=From:To:Cc:Subject:Date:From;
 b=iPGyqzXUnlfpkfmCqBdvoZ4dI9K3v5jFLHiCa/hDJoO8RAeHO3AkSto76Xz99CV6v
 Czht6AVnuES9lQYeQOKr3C1THhDEX18AU/XQXqBMiF7ZQnyN5Fue1i1M/HvHNV+tZS
 PJ3wQVVgTYvEo+nW8anygx7H5ZOXUCztqtbn0kl8=
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_loader: add missing EFI_EXIT in efi_disconnect_controller
Date: Thu, 18 Jun 2026 17:09:13 +0200
Message-ID: <20260618150913.314507-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make sure to call EFI_EXIT() in efi_disconnect_controller(), when returning
after having called EFI_ENTRY().

This is inspired by a barebox fix. [1]

Link: https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69 [1]
Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole child")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index de57823bd44..b6966652d97 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
 				      &number_of_children,
 				      &child_handle_buffer);
 	if (r != EFI_SUCCESS)
-		return r;
+		return EFI_EXIT(r);
 	sole_child = (number_of_children == 1);
 
 	if (child_handle) {
-- 
2.53.0

