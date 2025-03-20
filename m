Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1504C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 19:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD12806FC;
	Thu, 20 Mar 2025 20:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="RmRSnNka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA6158070C; Thu, 20 Mar 2025 20:03:51 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id 81EFA803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 20:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742497411;
 bh=43lQRiWzpJRHSVjjc1BuO497xRXI/zrwgWm3lDTqMY8=;
 h=From:To:CC:Subject:Date:From;
 b=RmRSnNkaHzTG7aAdggEUa/JBOcC+ikr4WPZG4h14uD9d/Uf6kTpi9RxMmw7ODt1Fi
 cG+t2VEs8gbnR8U/Df6Vii6EmeWMOZ3aXXyivAdBVwtrsILeN3H1TNBgPb+LHAt4wV
 s7RD/qIsQ45qttJTXJ5tL3f5fwpittw2RQHsLCkSRHerPTNeHGDX07aCcPj85kAxcY
 9KIz76u8G3teRwh24zS74oLwhZha+NCEvD0rHUTO7Sepr7TkBJL8G5jsOh7d2FKTgj
 RwgSeeBxLMWT9HhcsirzvIIGJIYQoEdJv4GzO3lfCP5qGK0umyE1J/V3z3JMJSSFRP
 7hsas3qECtaHQ==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Benedikt Spranger
 <b.spranger@linutronix.de>, Simon Glass <sjg@chromium.org>, John Ogness
 <john.ogness@linutronix.de>, Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH V2] tiny-printf: Improve %X formatting
Date: Thu, 20 Mar 2025 20:01:47 +0100
Message-ID: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
X-klartext: yes
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

If tiny printf is used with 0x%08X (upper case X) the output is
always 0x00000000. It could be confusing if upper case instead
of lower case is used intentionally or accidentally because the
actual value is not output. To avoid this confusion, treat output
of %X as %x. As a compromise for tiny printf, the hex value is
then output correctly, but in lower case. This is done to keep it
tiny printf small.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/tiny-printf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..48db7b1f78f 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -284,6 +284,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				islong = true;
 				/* no break */
 			case 'x':
+			case 'X':
 				if (islong) {
 					num = va_arg(va, unsigned long);
 					div = 1UL << (sizeof(long) * 8 - 4);
-- 
2.30.2

