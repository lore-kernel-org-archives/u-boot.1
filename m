Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FDCC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC83B87F74;
	Mon, 18 Mar 2024 16:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pZPBfnK/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qGUmgD3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A317C87FDD; Mon, 18 Mar 2024 16:03:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE3F787A80
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Tyym33kWlz9sp0;
 Mon, 18 Mar 2024 16:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WdbWPp0YSX/r+t+MoOg7neU6gS6k1saO7XkQuPzL7eg=;
 b=pZPBfnK/R5V9QrNi/D/9su4IGWPQr0X181gORSiNr8iJIPoDiXgoujkFU2PHO/KRwfA+vX
 sigaFWOdpxYRqjnmbge6YiwQ7ZCdScE2nUIfCFfqMBb+rKpevyqKihlaoHhzPDamFuaTQb
 m+cHrBMtZsyRgVkbAXrr5puBq55rA1yZj0q4A1GoT/Ylhu9fePr8BMPL55A6QEaCouuajS
 ar2XoOCasCfE8eoi36ZTBteRaxBdCNBs4m7ChyoI3HXg/poJM3n0Sp0St6b12XCFfOEI5B
 VuYE/pXRc5aT1n0klK6wCfCebpTwvtdFBsmTYyxE+ij5uniHUZFBJZ0KGkgaSg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WdbWPp0YSX/r+t+MoOg7neU6gS6k1saO7XkQuPzL7eg=;
 b=qGUmgD3BqhQkACWbcoHUVo1JqK6r3+MHEiKrIGcdRoicpRYVFC7SeSnpiqsbrx00OfLk2f
 n3ZvO3X+KoqUiuCB587ZuzdZBq+ud1PqwDMb3WreTkoWsQ/tUKMbBqSGUqkrR3bIysDUKB
 0pI4DY0D6SvYezi1h8oovPc0b2q1LgelTsVMv3xzXVF4Ea5TrjKd3+07lI5gpDIvlzwtko
 VlsxgdM8IGSNB7gtKYsNzCQBewXSWW3Q75EBGFLVnO6IOxXkKN+a2Qn17AjjzqIa+hSej2
 x+NELaliA7SHxKrsG/r8gSZPfrCrMrZe4FqmRwg8tqlBWctBKMveakYYjKhGJA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] Makefile: Add missing OF_UPSTREAM Makefile for 32bit ARM
Date: Mon, 18 Mar 2024 16:03:14 +0100
Message-ID: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db2e8b83567fee90d02
X-MBO-RS-META: 5jd6wh8gxbgxyh53sb8skp7he1g91dzh
X-Rspamd-Queue-Id: 4Tyym33kWlz9sp0
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

Copy dts/upstream/src/arm64/Makefile into dts/upstream/src/arm/Makefile
and create a commit. This makes 32bit ARM buildable with OF_UPSTREAM .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 dts/upstream/src/arm/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 dts/upstream/src/arm/Makefile

diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefile
new file mode 100644
index 00000000000..9a8f6aa3584
--- /dev/null
+++ b/dts/upstream/src/arm/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -a 0x8
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo
-- 
2.43.0

