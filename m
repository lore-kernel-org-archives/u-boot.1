Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B2CD98F5
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 16:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1488780287;
	Thu, 18 Jun 2026 18:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iJ8oEIJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52288063E; Thu, 18 Jun 2026 18:09:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4E2938005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 18:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED7E493F;
 Thu, 18 Jun 2026 09:09:37 -0700 (PDT)
Received: from debian (unknown [10.34.129.30])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BB963F632;
 Thu, 18 Jun 2026 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781798982; bh=fO/zbKg77zLD7rBvjCIlk3+KXu7U7hzIG/lL2J7q8PQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJ8oEIJ5pkjToOjHMcXaS0hBEF/+IunhrWD4DFvPWdHhzRPRAEH0PojZeIynZICeX
 /bXAgzOk1HAYzIemPwj0PEYl0CZGYk3AXkVXo4jn8SRRKHIPfMSyQnmZW2Oxm1mM3D
 Cw4/X60CZ4fKgc6ND/j45dgLkfOj3Rq7oxmmYYrs=
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] efi_loader: fix missing EFI_EXIT in
 efi_disconnect_controller
Date: Thu, 18 Jun 2026 18:09:30 +0200
Message-ID: <20260618160930.345040-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618150913.314507-1-vincent.stehle@arm.com>
References: <20260618150913.314507-1-vincent.stehle@arm.com>
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

We are missing a call to EFI_EXIT() when returning from
efi_disconnect_controller(), which we need after having called EFI_ENTRY().

Fix this by jumping to the common error path, which does call EFI_EXIT().

Even though the common error path may try to free child_handle_buffer, this
cannot harm in our case as it always NULL.

This is inspired by a barebox fix. [1]

Link: https://git.pengutronix.de/cgit/barebox/commit/?id=080db65e39a877b000baaf843c997a69821dfe69 [1]
Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole child")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---


Changes for v2:
- Drop the return and jump to the common error path with a goto instead


 lib/efi_loader/efi_boottime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index de57823bd44..bcb01c92cf4 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
 				      &number_of_children,
 				      &child_handle_buffer);
 	if (r != EFI_SUCCESS)
-		return r;
+		goto out;
 	sole_child = (number_of_children == 1);
 
 	if (child_handle) {
-- 
2.53.0

