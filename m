Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29422CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626E9880D6;
	Wed, 20 Mar 2024 21:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UQjx6Sd4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LIqTyfPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43881880B5; Wed, 20 Mar 2024 21:54:38 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E77D8723E
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V0LSC0T98z9sf0;
 Wed, 20 Mar 2024 21:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5/E5Xk4yu5xZJiFnJORgGoWr3cxP7t365w4nNvOH9c=;
 b=UQjx6Sd4xaTWQlH0C3Y+2rHCusBwXqDC5tJMz6ZI4/dMxJQptV95pHdJNc1j7OzAu0hgJe
 vSxemWS4JG1jPaDQ9WSYZru0rmrNxaS7YBDzzKRxoepo6z/e3sWLbhMIRK6qXcofbOfmf3
 /NaMOIvukPKYQE0SeDe+DB7y+xxDas0Yhe5/PFq4lNvJvwgoyXszXtykc8+w5ZECQo9mHT
 DDwZ6CtVf4DoYW+ZsDaHuRrY34PfhZpGGR00yAvtM8BLyDswPmgwZB815QI5dKVXbawQ77
 xQWXGLfO1UWiQ0Se1tvGFgg1YQ87hEhvFAi57GooF23y6dVU+NelGb1RhGQVgA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710968073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5/E5Xk4yu5xZJiFnJORgGoWr3cxP7t365w4nNvOH9c=;
 b=LIqTyfPCwnYWIDih2H/6fg9GP2NTE40BxFoMF6YzZYVa22G92V2pzkK13vvtZTT7KfJo1r
 KYdaA3ZliMrvEz2bHq29bNzENYftWANqcf2gOhdJVFvQWJaGjcR9b+MLBN/Fuz5HKrkkB+
 eyI8olfpPsIiOOWLIafjEqGsXzOTmO8vPMDASn1DbBkdHtsHj9/988JCeW7Zb3GesehLjV
 7KnnOPL9bNufNbteg42EKeWFjz6vdxYBMhdbNuv5S9ZkgM7HzHCOYnNkvlAZ+KN/Jc+/uo
 2xDlLBy8UH4+b29R1CkVH5TLVQ1V4FlxB8rMBKPbxlzEGCqk0v0sDmRhxQl4gg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/5] boot: fdt: Clean up env_get_bootm_mapsize()
Date: Wed, 20 Mar 2024 21:53:07 +0100
Message-ID: <20240320205413.32555-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
References: <20240320205413.32555-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8fa5a03a4a98e67800b
X-MBO-RS-META: bpoqqeezd5etxomjgny9q6tyubyke1zh
X-Rspamd-Queue-Id: 4V0LSC0T98z9sf0
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

Reduce tmp variable use and remove unnecessary type cast in
env_get_bootm_mapsize(). This aligns the env variable parsing
with env_get_bootm_low(). No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V3: - New patch
---
 boot/image-board.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/boot/image-board.c b/boot/image-board.c
index e3d63745299..b036ed764f8 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -149,13 +149,10 @@ phys_size_t env_get_bootm_size(void)
 
 phys_size_t env_get_bootm_mapsize(void)
 {
-	phys_size_t tmp;
 	char *s = env_get("bootm_mapsize");
 
-	if (s) {
-		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
-		return tmp;
-	}
+	if (s)
+		return simple_strtoull(s, NULL, 16);
 
 #if defined(CFG_SYS_BOOTMAPSZ)
 	return CFG_SYS_BOOTMAPSZ;
-- 
2.43.0

