Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9714AC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE47F84869;
	Sun, 28 Jun 2026 10:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RjRaDeiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1550E849BA; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69194848EB
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AFC6E42099; 
 Sun, 28 Jun 2026 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635294;
 bh=q3kBqJSbHLOLbbPxRqf5P5UXEqzQcsH2dWN5rprKOwQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RjRaDeiQujHzOBtaiz/OHBlZgNKYZ0Pz8LSWSfSzLUzMhHA7McK/NSE170fWkLXQv
 1jAwDkEGghv9Ap0DTR2sXR/dT5tuDN0SETx7gyl89+OROKWXVxBpYkbImmjivKst2B
 ghFurhaBxaQ+9XnkQv6h3cbHQ8+sHKV++Rrm4TlPw9pDC1vDCc0ZwknSlEOIfcVZXt
 xaJb5qbSQ6aJo3p87GYpTkcvFSTtFDIfpStR/rSKDwPToFWgkSDeiJPImkLlARLK1z
 53BiSpxZFuvng7+GBPZiGSLzSaWftmTqleIv9H4yCakXZjf+vlBY9GZOKkMC5xuR8a
 n8kwxK8IXau2EdQyx+ShZHrFB+IKW6ZuidKOyusHMtaWndq/rbCmGlPJbARHCN0HMP
 6VQ3OKLmlXbGo2dj39c/lU6f1wMpg1m7h7yGNdeA1uTSXjm5GIG0WLMnEFpDap1GJw
 GlmJuDxvZUKxmPZ2EDgl3zzf/Rt1OM4kxb1DK7Pj549F2y/nzSfTN8NnEJijNkX4pl
 AXAtph4vz/J4wVTbFUUQRiEjpCOLX1RVXnSfB8g0pEEcLyuQLoM5o2JgpGmZpMZ8fe
 6KSHnUN2ZyJAOvjduufaN1zHE9u+1Kie0NedHQr4LyfP75h6IIqJOCbUbyZxv+MBE6
 Kd4ymvhBUXr99JbYI06Fdeos=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 03/11] efi_loader: smbiosdump: fix starts_with() returning
 NULL
Date: Sun, 28 Jun 2026 10:28:01 +0200
Message-ID: <20260628082810.175862-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
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

starts_with() is declared as returning bool, but the null-argument
guard returned NULL (a pointer cast to bool) instead of false.
While harmless on most platforms where NULL and false both have
value zero, it is technically incorrect.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2:
	new patch
---
 lib/efi_loader/smbiosdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index d7f2ba30a95..974728a43af 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -199,7 +199,7 @@ static u16 *skip_whitespace(u16 *pos)
 static bool starts_with(u16 *string, u16 *keyword)
 {
 	if (!string || !keyword)
-		return NULL;
+		return false;
 
 	for (; *keyword; ++string, ++keyword) {
 		if (*string != *keyword)
-- 
2.53.0

