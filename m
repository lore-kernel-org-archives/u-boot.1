Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DC1C0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 00:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A69380F47;
	Fri, 31 Jan 2025 01:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="ByQWwQCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE4280F4C; Fri, 31 Jan 2025 01:53:13 +0100 (CET)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9830480F44
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738284770; bh=Gd5cOPgL9BLwQ+qoEe35Uqz2SD/bxIOD2jQRZVcAlVg=;
 h=From:To:Cc:Subject:Date;
 b=ByQWwQCGSxyythSMC5U1bpkkA27hHFIv/qcQwGgjuQa150ehsnL1YFRcFnDE7GPDQ
 3OF2TjbGQHch2jlntlM8xLroM+1YD/itSwLF3PKfe/Qrr/FHMGHvD4rCGSIGVZsRgh
 Gcx7PSd0m9kw7yC+SbQz7S//6iWKXC7UF3OJ2BK4=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id D30024F4; Fri, 31 Jan 2025 08:52:48 +0800
X-QQ-mid: xmsmtpt1738284768ta1mgfkfu
Message-ID: <tencent_42B13D5D83646C05C108407F980293053E08@qq.com>
X-QQ-XMAILINFO: NJ7NCr21PgMkCu3gh09nnSTKZKuhSuqYDsVv1UIoZH2R0zwrErRk2hLC0MIvl4
 h8fLRVAnBwhX01xcnDrXEoSTy5DTWt0LO1sM+jMINS+HmJm7+LAZ1btp/xdquQ+S/u5yF5F1jhJd
 +PQ/AUEoEPhB841jkzVMt6sLBW57KXRLWEjWDY0d5H5053wWmdhknKeo39u+nx4nWbzFW8QZqogV
 2Y7d0MHqDzqXyADzpJhZDg1OBe+F6kBRtmZ6TJMPGqEV8SmmEmz6Gr2GbW5N+OnH8lq7AJaR4L8h
 +PXhRhGlm/sUxt6RKQthx81exvCN0qRsPgncie9ZedCJ0rv78Du0pXpUcd7+7NRKFxqpJbxg/kTQ
 Tkw9gV+TrVbUbmNst3FO6npL4+qvqIG5gTwlkZJpqh649C13Fpz0ALG5VQUCHrGDWmO/lHx7DqI0
 Bgzw9wf6otjsziIAAGSdBRYiZ4N3R5cSJlG3Xm9Jb5pszz5ryrQNvybAKyvfJWplKwC/OQHdq28r
 YdHiXRHqXqZvOxCJXQRut0vfvmFecSDCXUkR9Xscw5njdrXOpdGuzcFjePAS+QrIwm2YVoLLi4Te
 6wGL3vnLgpk80+EoFP0lXETh8g+fKMImFgNn/rFuNuEiQrFBEay9sGoxO7zBLT5j5HUWTjZAxl+Y
 ydv+DK9ciL0i4TwW5Url7gNAwz0A/kUTbSe6RbRqyloI+00hby25ZAM1kn9Nt/2GtsxbyV4VGMHu
 2KGLvw7nJh5MXNCQJCq/YKdepL3DH+Hr+CE4hrHAtUn/uGIAqqR4q9641sGJXdZIkebZXblLsRJA
 wjNE4JG7oclzbmpU0gmXZShevLaTf2RwtOtmiuw0fYf8P5mHsh6P0RggsxdjDw3k+Su/Y135M5HB
 Qtpb3FBdgKKfH1uLx1FvdMapYcX0gZnhd+rq8fgcp9LMARIBJCU0TRpdZ+x/lbKdyLKhLhFLE4x2
 /yXG5ertcxnANmqE51Jyx0LxMde4iatMOUhNy8gxE0i0izrul0CtfLGsbmapgv
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v2] siemens: common: Make DDR_SI_TEST depend on
 TARGET_CAPRICORN
Date: Fri, 31 Jan 2025 08:52:43 +0800
X-OQ-MSGID: <20250131005243.337173-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

The DDR_SI_TEST config option is only relevant to the i.MX8 Capricorn
board.
Make DDR_SI_TEST depend on DDR_SI_TEST so that it does not show up
on other targets.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v2:
- Replace depends on ARCH_IMX8 with depends on TARGET_CAPRICORN as suggested
- Modify commit log

 board/siemens/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/siemens/common/Kconfig b/board/siemens/common/Kconfig
index 4ae12b1c973..3808257cd07 100644
--- a/board/siemens/common/Kconfig
+++ b/board/siemens/common/Kconfig
@@ -3,4 +3,5 @@ config FACTORYSET
 
 config DDR_SI_TEST
 	bool "DDR signal integrity test implementations"
+	depends on TARGET_CAPRICORN
 	default y
-- 
2.25.1

