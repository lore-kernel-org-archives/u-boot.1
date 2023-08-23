Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0B2C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 19:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1820D86441;
	Wed, 23 Aug 2023 21:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rg8H2osC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ulTI/8s/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F92B86445; Wed, 23 Aug 2023 21:38:02 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B715C86439
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 21:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RWGhm4hZrz9srl;
 Wed, 23 Aug 2023 21:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692819480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n6bal8qFDbgUUtesAFS7Hwxhyt4/kq1n4z6Fff8XEXQ=;
 b=Rg8H2osCLyZ5z44B0K5jaqf1WN7yUzE46afT9fmE+32P+M0zAmJgSzOm7jIpKPlf+b/zJM
 lvR6x1J+l3jyz6qBtkSYD/vWT/hvRPwFAXHHgnbNJr6zDbsZFCy6WhGjYpEdpWBOqub1Ls
 O/lHt3CVs1LZj2suG57zfERR/5JS2kaya1D81g3FP94RMyQ+y4llaeotXck8bXTtf3HYbs
 3C3T0fKFmHrT9xdedkc7j8ZEXaqpGIzfNNCuaels6IJBKY8TOufBB0rQQLUQofhMfUSys9
 p/eM05cCqukEc1OK63sGMKFZj6VjGB1BX9Xfjb6Z4Skz+xxGI/0pTZecCD90hg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692819478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=n6bal8qFDbgUUtesAFS7Hwxhyt4/kq1n4z6Fff8XEXQ=;
 b=ulTI/8s/IGAHfDCYZ16fJ90nRVQNGAxER3WVdkYGBZ7nGL2EmTzq02p2kYf4tM/TSa5rXM
 lSSPUIBSlawZqytQw6Vep3ICsHRY799HkSJtAygtoE2mx8Yw7BStQqMt6hbLqotiAKSIYj
 D9p6eol6P0QjOF9ERa7CxNUqJzzyU7IZ9oT81IQJVo4GI0XaQ5Ptan5ioi0AXnhQ3fWhOZ
 MBYdvgrn10HxtnMrMmsoovuvZlEikUc99Zi7pxx8n2ETKteFlqxPIER0GxW1R4cwjRHrUP
 Vh1oRJx1cpKFLLUjacOwRbh6arPwfCUNm7T4Yi8KCOhZ9GoqgOfcv4K61yP+JA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] test: dm: test-fdt: Use fdtdec_get_int() in dm_check_devices()
Date: Wed, 23 Aug 2023 21:37:44 +0200
Message-Id: <20230823193744.64172-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4cf23473eabc2452eb7
X-MBO-RS-META: jf8sfg7mxnhhnrz1bhwghptjc1apqubs
X-Rspamd-Queue-Id: 4RWGhm4hZrz9srl
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

The current fdtdec_get_addr() takes into consideration #address-cells
and #size-cells for "ping-expect" property which is clearly neither.
Use fdtdec_get_int() instead and return negative one in case the
property is not in DT or the platform under test is not DT based,
i.e. mimic the current fdtdec_get_addr() behavior.

This fixes ut dm dm_test_bus_children test.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Simon Glass <sjg@chromium.org>
---
 test/dm/test-fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/dm/test-fdt.c b/test/dm/test-fdt.c
index eeecd1dc2de..72d0eb57e21 100644
--- a/test/dm/test-fdt.c
+++ b/test/dm/test-fdt.c
@@ -135,8 +135,8 @@ int dm_check_devices(struct unit_test_state *uts, int num_devices)
 		 * want to test the code that sets that up
 		 * (testfdt_drv_probe()).
 		 */
-		base = fdtdec_get_addr(gd->fdt_blob, dev_of_offset(dev),
-				       "ping-expect");
+		base = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
+				      "ping-expect", -1);
 		debug("dev=%d, base=%d: %s\n", i, base,
 		      fdt_get_name(gd->fdt_blob, dev_of_offset(dev), NULL));
 
-- 
2.40.1

