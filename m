Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D3BD69112
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697B689D0E;
	Thu, 28 Nov 2024 15:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="xjAMkKkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671A089D10; Thu, 28 Nov 2024 15:23:06 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 by phobos.denx.de (Postfix) with ESMTP id 631A089D12
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732803778;
 bh=pHHcN3MFP6hprsXIHhKx3F0qWOiXlUiQhCKxds4ZpmY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=xjAMkKkr8m74LrENafLBZCWiORWdEXUO3uyjC1tnFb+Bg6jJKuXkxtJbRGBYK8BRu
 j0UKv196ChHF+64PkqisFnPNuIV+Gv/VWcN6ZYjTQFWsLf8s9IM8Sv/rR02Y706yvG
 wNdMl10/4H2MExI+7viCWShI2nzPJi/ouPAETUKt9szNCu+vUKW/BMjTzC/kqTNlsv
 V28LvbDTakkJ14qfUE/4WyXfsYMkwxlMqlnYYiDSzG4BlP2Pdm6ceAxu5+Os/l7nMW
 3SiZM28xAczxBR5h6ORANtamTqP+US7Z+0oS5NiO3z9xsQf2vt/NB4mIusKgrU8CeD
 rZzix6OjOqyjw==
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Christoph Niedermaier <cniedermaier@dh-electronics.com>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, <u-boot@dh-electronics.com>
Subject: [PATCH V4 4/4] lib: hashtable: Prevent recursive calling of callback
 functions
Date: Thu, 28 Nov 2024 15:20:20 +0100
Message-ID: <20241128142020.35386-5-cniedermaier@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
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

In case there are two variables which each implement env callback
that performs env_set() on the other variable, the callbacks will
call each other recursively until the stack runs out. Prevent such
a recursion from happening.

Example which triggers this behavior:
static int on_foo(...) { env_set("bar", 0); ... }
static int on_bar(...) { env_set("foo", 0); ... }
U_BOOT_ENV_CALLBACK(foo, on_foo);
U_BOOT_ENV_CALLBACK(bar, on_bar);

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Suggested-by: Marek Vasut <marex@denx.de>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>
Cc: u-boot@dh-electronics.com
---
V4: - Add this patch to the series
---
 lib/hashtable.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/lib/hashtable.c b/lib/hashtable.c
index e8a59e2dca..75c263b505 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -221,11 +221,32 @@ static int
 do_callback(const struct env_entry *e, const char *name, const char *value,
 	    enum env_op op, int flags)
 {
+	int ret = 0;
+
 #ifndef CONFIG_XPL_BUILD
-	if (e->callback)
-		return e->callback(name, value, op, flags);
+	static bool in_callback;
+
+	if (!e->callback || in_callback)
+		return 0;
+
+	/*
+	 * In case there are two variables which each implement env callback
+	 * that performs env_set() on the other variable, the callbacks will
+	 * call each other recursively until the stack runs out. Prevent such
+	 * a recursion from happening.
+	 *
+	 * Example which triggers this behavior:
+	 * static int on_foo(...) { env_set("bar", 0); ... }
+	 * static int on_bar(...) { env_set("foo", 0); ... }
+	 * U_BOOT_ENV_CALLBACK(foo, on_foo);
+	 * U_BOOT_ENV_CALLBACK(bar, on_bar);
+	 */
+	in_callback = true;
+	ret = e->callback(name, value, op, flags);
+	in_callback = false;
 #endif
-	return 0;
+
+	return ret;
 }
 
 /*
-- 
2.30.2

