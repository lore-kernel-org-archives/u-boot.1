Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E3AC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B200B80657;
	Sat, 18 Jan 2025 04:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="z0riSl4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B2B8070C; Sat, 18 Jan 2025 04:39:30 +0100 (CET)
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com
 [203.205.221.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EDD8036F
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737171562; bh=wX7NDpq2/VVBeLcqtHdOnxbR2s9yV/hk4kL7mAXot04=;
 h=From:To:Cc:Subject:Date;
 b=z0riSl4jOqmy6FdwU+To/EbQL5Gwyv79up3qYCa7XUQMQjZUHbXe79A8G+ChJLYhq
 gDFv2Abzl/ovhn8EzkkX7CHVR3ckwaV8AmCxCtQkyVk1GFja86dTKnhPrnWc9Y6JgJ
 cprw2Un2Un8hQFxkkhocri8E/LJRRju7vBlRBm40=
Received: from ubuntu.localdomain ([183.253.34.159])
 by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
 id 9D4BFAFB; Sat, 18 Jan 2025 11:39:20 +0800
X-QQ-mid: xmsmtpt1737171560txmqn7ip7
Message-ID: <tencent_78F00D5010A6F5A48D0F464FC0E026DB5906@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9GxZynDvlwI5UExgyBcs5BCNU2AampfxyrOo+aKqPfr84OFkr2T
 UpKakorvxRKQnpoYIqoB3nD94UPgGMHddjoYL69WRZaDAUzDFEZgfPF6R8pRdD6DlPMWT9WkM6nh
 JnFjR7jjdVOPFHND418NQTXlw48utOMSzptKxIFAZPtliNJxHGuy8L5EULkFEE+BiFFmeqVUHiRu
 wmCss0zWkrXJX++zqfWRioWFVbKsPPUt1j0pOcCKzmPHSMJzbOPcnGY4Mt4UqubMxpoY1mLZDCPr
 mDL6bUwdJNK1sOXS2tzQXOg2Vx1RoPL3nztyFnl8fFeoq5JIxBt74u3Ph1bcW9KphWbv3JnrLJEj
 Q068+WJHrT+K6yNy30dSugFqyz1QyVbcx/xpQYB6V9QIONK0Yrp6fuE8wdpg2BA2ds23KIrFb47j
 zTsdcI7VcidoJbCmd26lHlH7IdPm8lU4OwS/droAKTUFOq+P5AutVTB34tWUmuNFeBIsaUNBNfff
 aPnIRj4MLX6gyBuZF12FMc68aQg8M/v/0Xvh8xlGV1CKA0DimzSbKpgJFCHIhZflyxHrYs5rr+Ia
 AwpODAo7Knu0g748wK+5YNsC1WY8LNZTMJqVM9mLnVcQ0icnFofaQg2gPtbux65CYqs0RGMf/vyv
 jogvqzrwjb9kYrCC38+vNwrGbIZ32a20ibCORBCoHtv80euSsMeAJ4RvVMWr4UHDrgs58Wfc0oIk
 VhQraMYQQWmKH3iGVREp2psf5GfYS2zYixT61ktZBUduDP3sv0cG2ZXvMVa8x59bcEoTh0ZgvVf2
 KBh2fdfUGWSMPTg1B2VhrnkQF/ue/8HYDBU9TFMLDQx2BgnCw395JQUZRQ0lYddts3F1OdCbQhyh
 Ny6kFtTQGRVLiIDTq5ZMu11J+XtKuZE3f07p0q22qZOk5un/FB7qY218aCCFh6dKiRyu3wvbnm0c
 nUUXf0YOSNDVRHIiDXTJ9XjLeHaWQy
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: 1425075683@qq.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Simon Glass <sjg@chromium.org>, Liya Huang <1425075683@qq.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1] arm: Remove redundant loading of image copy start offse
Date: Sat, 18 Jan 2025 11:39:18 +0800
X-OQ-MSGID: <20250118033918.20338-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

Remove redundant loading of image copy start offset.
Because the beginning is already computed

Reviewed-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v1:
- Due to an error, the patch was resubmitted, leaving the code unchanged

 arch/arm/lib/relocate.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index 345e282e3e..bffadfecba 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -83,8 +83,6 @@ relocate_base:
 	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	subs	r4, r0, r1		/* r4 <- Run to copy offset      */
 	beq	relocate_done		/* skip relocation               */
-	ldr	r1, _image_copy_start_ofs
-	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	ldr	r2, _image_copy_end_ofs
 	add	r2, r3			/* r2 <- Run &__image_copy_end   */
 copy_loop:
-- 
2.25.1

