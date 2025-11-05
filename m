Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E010CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 18:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4727883AD1;
	Wed,  5 Nov 2025 19:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kkIbtNhn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABF683AE6; Wed,  5 Nov 2025 19:07:55 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C55583AC5
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 19:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AC5523FAF6; 
 Wed,  5 Nov 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762366073;
 bh=8SxhYu1AnT/jPQjPRevZ6yO/jJIDzv1R3FKIz+npF0k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=kkIbtNhn9Qy8FNZIOXzxouoK/JSK+Mf0AEW9MczdkkP5kAviRiZGtDVhzg6Fn5Elg
 L3db5xSYygRtN8VrZPOWjbP+HMq41roqcLObQiMnnU2yRziJlevP2gh+XfhZiua/+r
 jQG21h7c2wFmhtET8/mKrWJ9iPW/uSHP0Wh6nTAmZudILPjPDJ2UFUIjfr/ArlgvlC
 k2G9qaHtGH4GwENnJQWelqh9cFy5EiIGFtIixIEuqD9D4UR2eYew7kJI3ER7grNmp5
 NsUZgTRJL9RoxiqQYf4Cp6+pZdxcVUP/dguyqjR/YHXu3dqxnjVutwDDcfpCJCEuwy
 eU+rk81EYTnWqM8CLkL6GYTv+C/Wi8eobylLR+jahRAR1EHn6prptHURVyWH94PPv/
 pt3kiLUBMQpzhTpJvKGI50BwqD6JfxTxyOPRhCByzVgMYLTspw2X2TDaXdFPbO2r+J
 9rzjn6s/kH4ruhfTKvNloUPFzZ7eQOJytNA0V2lyShRzZX2Pufy21dqLLvugnTNw0k
 x0GCdK5JWS1tlgnR/4Kq18Fz2KrUl3Ff/uCLIofh0RdXxxNgLFVrNJN9KBRkM3IheM
 Gt8yekz9YdZ0fzn/cQMIWE/2zs69mV7Dz9mGq3OJMryGxJUch2iNAh1ackQk2UwaiZ
 80W4cDEYmF85aYpTlFxi/vQA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] test: do not write to 0x0 except on sandbox
Date: Wed,  5 Nov 2025 19:07:47 +0100
Message-ID: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

ARM and RISC-V do not have memory at 0x0.
On X86 interrupt vectors are stored at 0x0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/fdt.c      | 4 ++++
 test/common/print.c | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 96a8488e172..6b07999c88f 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *uts)
 	uint32_t ts;
 	void *buf;
 
+	/* This test requires low writable memory */
+	if (!IS_ENABLED(CONFIG_SANDBOX))
+		return -EAGAIN;
+
 	/* Original source DT */
 	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
 	ts = fdt_totalsize(fdt);
diff --git a/test/common/print.c b/test/common/print.c
index 76ee851fe6a..389d6bf4069 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -169,7 +169,7 @@ static int print_display_buffer(struct unit_test_state *uts)
 	int i;
 
 	/* This test requires writable memory at zero */
-	if (IS_ENABLED(CONFIG_X86))
+	if (!IS_ENABLED(CONFIG_SANDBOX))
 		return -EAGAIN;
 
 	buf = map_sysmem(0, BUF_SIZE);
@@ -244,6 +244,10 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
+	/* This test requires writable memory at zero */
+	if (!IS_ENABLED(CONFIG_SANDBOX))
+		return -EAGAIN;
+
 	buf = map_sysmem(0, BUF_SIZE);
 	memset(buf, '\0', BUF_SIZE);
 	for (i = 0; i < 0x11; i++)
@@ -270,7 +274,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	int i;
 
 	/* This test requires writable memory at zero */
-	if (IS_ENABLED(CONFIG_X86))
+	if (!IS_ENABLED(CONFIG_SANDBOX))
 		return -EAGAIN;
 
 	buf = map_sysmem(0, BUF_SIZE);
-- 
2.51.0

