Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B031CF58C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 17:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE548397A;
	Wed, 19 Nov 2025 18:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FH9WdrO+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xi8weEB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9792B83DBF; Wed, 19 Nov 2025 18:44:32 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B067F8391B
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dBTPp3S5nz9tKq;
 Wed, 19 Nov 2025 18:44:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763574270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SKisheS2O7KyB90cfwcskQjL8pPmHy6U4XuykFMTp5g=;
 b=FH9WdrO+/jcdalVswW5FXtibO/xhcX8NOC/4oVuVroxTFMzqyHzMhfIyTcWYOMDoqh6333
 qlsEakSuHXq0jD5xiBAvTRa27IvOuSqF80LAYrLrxG7ZLxTlNO/Yt4psWm7sWNLHaRhbZ3
 EdkVURsIWMYNFN2fIKdkdRWiIYfTTX898t6UPt+bsZgZhNyfBsUHKkDHKgLwb6qc3qDBxe
 IDjfr+9CXJWfZAlxodkDivyA5i2ks0scaZ0AizKI8GxYFy75zhezrpL0ZtLy8LxiyZrBlO
 0l6syISC8aii7BFdeeKbUY7DnELdbINCPUhE218Cbeq/G4IX67zuUC7he15nog==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xi8weEB4;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763574268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SKisheS2O7KyB90cfwcskQjL8pPmHy6U4XuykFMTp5g=;
 b=xi8weEB4YZsBqa7SJpPThMtHfVJPUeQ6PBd464X88RMWulY7MSKeKb2pwu+Owg/wE2xMMX
 tyLVAEVf8Uhx4EjI6UMpgtbGVvvRt7rkRdtvwLBeA9Minht3BMxnh91O3n1gEp1aOMHIU+
 Xi23H+HIXlDnI3CtCdKIwzYIF+4Rr11ms6+IzPNPPHY06sONLEz5i0sFUcyDonl7+AfCvF
 b4bgfvRR+8cDYfPpK5qJOoqGG8H3mKluuGzrj8ySw+imlBnt3TQAHthOfM+wXS/cg+48Fi
 Pv51pZk/OjYzUNSn/dCPKi4+cPJDtTvYQ23Dfv6PIanTmXZ2MkZaCInQHR9zXw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] boot: Warn users about fdt_high=~0 usage
Date: Wed, 19 Nov 2025 18:43:53 +0100
Message-ID: <20251119174425.58535-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a570cf6aefb484495a2
X-MBO-RS-META: uoazbojpoqifbnx68zirzyafms5394zj
X-Rspamd-Queue-Id: 4dBTPp3S5nz9tKq
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

In case the 'fdt_high' environment variable is set to ~0, warn users
about the dangers of the fdt_high usage. This will hopefully lead to
removal of most of the fdt_high ~0 usage over time.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "João Paulo Gonçalves" <joao.goncalves@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Warn unconditionally
---
 boot/image-fdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 3f0ac54f76f..a3a4fb8b558 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -189,6 +189,12 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
 			addr = map_to_sysmem(fdt_blob);
+			printf("WARNING:\n"
+			       "The 'fdt_high' environment variable is set to ~0. This is known to cause\n"
+			       "boot failures due to placement of DT at non-8-byte-aligned addresses.\n"
+			       "This system will likely fail to boot. Unset the 'fdt_high' environment\n"
+			       "variable and submit a fix upstream.\n");
+
 			err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
 					    of_len, LMB_NONE);
 			if (err) {
-- 
2.51.0

