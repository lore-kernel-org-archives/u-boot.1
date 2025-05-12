Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF0C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 15:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B9581DD6;
	Mon, 12 May 2025 17:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JSYaMCrv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F8IzBUbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027C982905; Mon, 12 May 2025 17:59:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 711A980C83
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 17:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zx46W1SjSz9sDW;
 Mon, 12 May 2025 17:59:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747065555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rwKZ+ifANLFlbIo7Op+ffAFrwRDefgWbFcMr+2BS2uw=;
 b=JSYaMCrvHUKU4OblIDTytOk+Bv6L1CdjAYgQp2VWKiLaw9Y1xp0u75/AsFHPIWk+7uzj+z
 6zogsQggAhUxmeCAOZa/g1nwwmfVueRRQyYYPy9dbe5PXt9WxXCUIjSAJR+s9V6h7IMWZd
 0BfZ4iRBnMbh49OH/JHwiO/lTWd8OQ3c410xnOjKLaSp2hjdLLlzIl+G6178XgHf2tpSvg
 r3zkNk8/dJtL3BXdr6GIN9/WErsQNZjzQ9nNV1ll9BUOacaDIsFgDHFew+3srgApQQY0El
 bL4W3UGcdEPDo0uB4dE4wfSh//9DAGVp0YuMLFfQZ3CZ2k21KTshzYe14kwvBA==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747065553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rwKZ+ifANLFlbIo7Op+ffAFrwRDefgWbFcMr+2BS2uw=;
 b=F8IzBUbYNk2R7Q4NvW5uOnX0UmUyVE4txxiwZR2UgaUIvU7vY/61qCAwGvemGgt88KEsDa
 xEBkNFpkPMwa5KVU9UwCxzk9EXGAQkkhmk+d9KiYCOPvHa6MZIJ0Q2rWbUpk7VflqBWKdf
 EhwwvNg+USh/gtciMw1DWqCCyLSYiu/4t/JHNe5nJzALSRNQ37jOKlxb7gYh7k5j304SAd
 u8PVNJyv1S017xwhDZ/quxoiJGY93wwMN3ryxJ2dYoz/uM30cIt3rEQF7EjRo5PPDHHQY1
 5LWHfxc+YtchTWpC3vd6n20gQub00HqtfXAAGduAtup31sGtb79uSJXhSborqg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] image: Fix FIT image loadable section custom processing
Date: Mon, 12 May 2025 17:58:39 +0200
Message-ID: <20250512155859.145717-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6xji49wcuud9xauakiqjsupuuo8sdgkq
X-MBO-RS-ID: a99c6ed40cba6f0d9d7
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

The original commit always generated linker list entries with the same
entry variable name, because _function passed to ll_entry_declare() is
not a variable and therefore was interpreted as fixed string. Change it
to _type which is a variable and which does allow generation of multiple
unique linker list entries, one for each U_BOOT_FIT_LOADABLE_HANDLER().

Fixes: d7be50921ed3 ("image: Add FIT image loadable section custom processing")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index c1db8383459..f09862b636f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -2133,7 +2133,7 @@ struct fit_loadable_tbl {
  * _handler is the handler function to call after this image type is loaded
  */
 #define U_BOOT_FIT_LOADABLE_HANDLER(_type, _handler) \
-	ll_entry_declare(struct fit_loadable_tbl, _function, fit_loadable) = { \
+	ll_entry_declare(struct fit_loadable_tbl, _type, fit_loadable) = { \
 		.type = _type, \
 		.handler = _handler, \
 	}
-- 
2.47.2

