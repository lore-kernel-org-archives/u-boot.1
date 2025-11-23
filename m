Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695AACFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 23:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51B8583C14;
	Sun, 23 Nov 2025 23:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n1P/wWBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD1C83CF3; Sun, 23 Nov 2025 23:59:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91DED83B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B103044C63; 
 Sun, 23 Nov 2025 22:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938698;
 bh=cTuCQ/WV5QfkUuBqayb/4bO453FXWi6/i1PeQeUMaJQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=n1P/wWBn6quusxmtF6r1Xes9lSbO63iar3N2SaM+5F2nTJhTes6MU5d9ncxCm479o
 L6fsRnZqCLrAqkM6Z8ms6xPDW3WAYZ2x2at7xIwoLzTyjSFYiebFTysAdqi3Zg4kzo
 FSNHK7z2mR5QPKz0d2KxlHR9YEQfsZAyT4BMwPJJVaKG8adIv0M0WOHMeAcx1bBykf
 jPZPrldzN6MH6c1lQyqzROy7WUqG33eI9dbpQ1Zln7I3Ogaa7ctkfxp6VMv0/LolZG
 xU5xx99FQFGysh7i7cND93Pq5qzIXFjB0f1Wl9ykouYZzV1a53OOzh4vwaOL6wc6JI
 5IrjuFUHUxXp1yK87rYCHnwjceit7e1gB5fFMxqz6xs/AMfzjtqtC5aYmuI6ZltojJ
 5qUb5D8/bpnhaYR370lUFRM9om5skv25k47NptovrZPu23aMmlofR4tlpdqGQjZ65q
 /A4vyf7uIZIQL4nzAG83Wo4eGWAfISWYmP+rUSv5oySR+8yJmGaxO7PdXjgOwSYbWc
 vUVX8ifcp6SzhOqC/LKVga8GHJlJMvLIjw1DKD/4Ei2bVeCR/4yjaIxxd6p0OLz7aY
 65ZeyT4MvaKQCUa2szM+RCCS6fAtW+W/zZdk+CEjfDu4tv7v043PVgfcWlCWqAkFie
 pXYckc55XtZ1WYwB5t0GyXLo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 19/19] test: let UNIT_TEST imply CONSOLE_RECORD
Date: Sun, 23 Nov 2025 23:57:11 +0100
Message-ID: <20251123225711.227016-20-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

The cmd and the log test suites rely on CONFIG_CONSOLE_RECORD.
The log test suite is always built if CONFIG_UNIT_TEST=y.

The print_do_hex_dump test relies on CONFIG_HEXDUMP. Imply it too.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/Kconfig b/test/Kconfig
index 6a4a5fc6708..24105c13304 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -3,6 +3,7 @@ menu "Testing"
 config UNIT_TEST
 	bool "Unit tests"
 	depends on CMDLINE
+	imply CONSOLE_RECORD
 	imply HEXDUMP
 	help
 	  Select this to compile in unit tests for various parts of
-- 
2.51.0

