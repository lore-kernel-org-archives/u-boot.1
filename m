Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292ACCA0FF2
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 14:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A85883559;
	Wed,  3 Sep 2025 16:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wSty5T5S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J7RvLEHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75CCF835C9; Wed,  3 Sep 2025 16:23:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5255C834AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 16:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cH4Zs6nyyz9sp7;
 Wed,  3 Sep 2025 16:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756909382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oX5NF80I3FjdIM8X7tl1b8FjPKyC1e0B7y6RhtJtUis=;
 b=wSty5T5SYSQ4MrmRtyyT9128bvVJrsmHPRA1cK57SGICB6KDJTOYS3ya9f/y+qK9tD/b34
 IxK6kkbWRgnWh3PyHpjDIw3W0F1TUrfn/Hm4bJiFcBt06JDrqYdDiByUvSx+sKmSmWLi4b
 Q7Y1GKQyaPOsFiep/wdxcjR4s+ZO+ci6+qvy8ZYRcruIVocgRDJsosU5YIvTIVVXaMY1lL
 L5y5aVUL6SENfhMDGgXzISvfu243G8jkomGTIcO59GzsQY0VxCOVwCXw0o5fwK0lNAmNZl
 cmJXsaoS/VjHSNXTsByh2vDKbM/9nsECKwezSTWexrvYcmLOlQn2mnw3dAxTow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756909380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oX5NF80I3FjdIM8X7tl1b8FjPKyC1e0B7y6RhtJtUis=;
 b=J7RvLEHQAv185fG3oHvzhj5VdTQ7DW1p9G1WdkojaDbXK+cU09xsIsfwj0DSWx/iqZ7hSy
 rQUMiVP8cEeW9wuSFzWrRbmZ3F65nZwfnGYImMSdZpZxG1eu+CQJMc6T2LZYMlDYpAqh7T
 arq3GM0kw5XjDrBK/q6C5r6cpf/EUHwPFLIDKa1dpXtcx8FHT7xd1Aj1LreuQtS5yv2606
 HEXF2vb4OM58ujn6F93U7vWj8IscVsXiPrsqlGREAGebFsuITXwbt564uEfYuymJg7vZex
 ujlgk9XpXxS3Cq3o3AZNNNxI9OVLwD6Jte/nInLj2Sa1viWTaPhdZ+G+xPdxCQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] env: Fix up indent
Date: Wed,  3 Sep 2025 16:22:26 +0200
Message-ID: <20250903142245.90689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k39hzezxjzxhsmzayzs1nqpghx5oxwrg
X-MBO-RS-ID: 6f90deb63af221e377b
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

Replace #define<TAB> with #define<space> to be consistent in
the entire file. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Split from env: Remove usb_ignorelist and env_fdt_path from ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
---
 include/env_default.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/env_default.h b/include/env_default.h
index b36aacea90c..7f8dc1c35a7 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -79,10 +79,10 @@ const char default_environment[] = {
 #ifdef CONFIG_USE_BOOTFILE
 	"bootfile="	CONFIG_BOOTFILE			"\0"
 #endif
-#ifdef	CONFIG_SYS_LOAD_ADDR
+#ifdef CONFIG_SYS_LOAD_ADDR
 	"loadaddr="	__stringify(CONFIG_SYS_LOAD_ADDR)"\0"
 #endif
-#ifdef	CONFIG_ENV_VARS_UBOOT_CONFIG
+#ifdef CONFIG_ENV_VARS_UBOOT_CONFIG
 	"arch="		CONFIG_SYS_ARCH			"\0"
 #ifdef CONFIG_SYS_CPU
 	"cpu="		CONFIG_SYS_CPU			"\0"
-- 
2.50.1

