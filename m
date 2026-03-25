Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C83FEA802
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 03:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2675483CE3;
	Wed, 25 Mar 2026 04:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iNfoFPzE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QY3AQcEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE95383E4C; Wed, 25 Mar 2026 04:17:59 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F3B83CE3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 04:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fgXCm69Xlz9sFB;
 Wed, 25 Mar 2026 04:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYsF55XQCAZP5woEcrDYzJuGWjWe+IAX3Jo7TTABReo=;
 b=iNfoFPzEJDVk7f0o7Sc0/95hTl0YINaK5ke74qDDyitSTQA+pDyD/3BV5YETcF6V8zzyXv
 GhJtPG/JnbogG58wdotEPI+UAvKnMSbZgdRHCc4O2RJ9Ghstn3/uWQ0L41gawrAQxRS4OT
 oAt88i9qQPWimGahz8UM7WdgqUmQhr7j8kITVrqLHwNJ0LwWp3joHuGfdEhkWMKOsm0+Jx
 QxvQzQnAviFgAmvhPA1PuaMlubcOymy2YIGH0U8YdqLsFMXrIh7KVw8f7wxW0SThJC2YD4
 W4r7iVB9dr/I4Z7R5rnpDljhKtZHxx0K/UkSFyyEWJmPz3jASDWVjkyjJBTA7Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774408675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYsF55XQCAZP5woEcrDYzJuGWjWe+IAX3Jo7TTABReo=;
 b=QY3AQcECBFtv5FJgTfYZ8MvpmYoVinb6yOYuGDK0B78o8sRGnc9Rk0tz+sR3WSYoahbTe/
 zrIIZVomjDTJ8Sy1bGWTRvBJOMjDI7sMxCLb5WlOQ2N8Rvo4XWvDT9U0+dwTCdhvCB1Dop
 42cjYWi+ltawUqO7NIz9i4qYyLWOISGMlimOmrIRvx0tv4WdL0xBhHNMxZgMDHfvT39FJS
 uI/wvmbGeS2gYgAoJ5xlp5PPYurZNArCobXyls0l/V6GapLXOW2r6osOhkwIT2sLFhh5VN
 881z+Y6jwVBB9JKqlzFmnTnlODsyB00YCRFl32MBT77XaooQltiC07quVGxeNw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC][PATCH 3/3] arm64: renesas: Set gd->ram_top to the end address
 of last DRAM bank
Date: Wed, 25 Mar 2026 04:17:06 +0100
Message-ID: <20260325031743.371728-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
References: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bbcace5f50b6d1b230f
X-MBO-RS-META: czyh91ia87rpfwccww5bi4q7fz1kq6mz
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

Use previously introduced fdtdec_setup_mem_ram_top() function to
determine the topmost address is the topmost DRAM bank and assign
that address into gd->ram_top to assure U-Boot is relocated to the
end of last DRAM bank, which is the end of all available DRAM.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: This currently breaks the platform, because its ethernet
      controller cannot DMA above 4 GiB, and once U-Boot does
      get relocated above 4 GiB, the packet buffer which is built
      into the U-Boot binary is also relocated above 4 GiB.
---
 board/renesas/common/rcar64-common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/renesas/common/rcar64-common.c b/board/renesas/common/rcar64-common.c
index bcb03792494..ed488bf5b91 100644
--- a/board/renesas/common/rcar64-common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -65,6 +65,13 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	fdtdec_setup_mem_ram_top();
+
+	return gd->ram_top;
+}
+
 int __weak board_init(void)
 {
 	return 0;
-- 
2.53.0

