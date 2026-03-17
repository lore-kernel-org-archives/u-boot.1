Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D404FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2715384214;
	Tue, 17 Mar 2026 02:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N3J3nt+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C617840CF; Tue, 17 Mar 2026 02:24:35 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B920984129
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4672076355aso3578265b6e.2
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710669; x=1774315469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+/M7rR+8k5Fw9jCDYQmA614tCve+0+gRLTJ4EGoTW/g=;
 b=N3J3nt+zjCdFpIYCPKsjACIm1OGjpoI8cbuaDIzba4ryoMRnbRj9DitTjKMO+cEZjA
 HDKvl72xRaA+dUR/EZ8ZHcpYlymL4tDnUzHI+K8kzc3KaRPmnVPTXUlZzkc86hH/aG2t
 Q/hyz2fbafBa6F1lUhZegbD/RA1NGukD/XQGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710669; x=1774315469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+/M7rR+8k5Fw9jCDYQmA614tCve+0+gRLTJ4EGoTW/g=;
 b=fqF2amiRyuGB8mmnNnxUN+a/SpctOo0G5i1PkLSNpJepWV2OSXGcNKGN/FhU8iPlSz
 ib3WFjYp08fmyPHSGgYNJ0Q5PJfagfnwjo3EBn6btPHgh7k00GZoszuqoUXxgtg84Cuy
 kfH6HoN4V+3PedDonjoD4hNw9lKEslTrlzpJDOpsBC1eFbjShdiKWS5jHRU8ywRzkPgh
 ekwh3Ydv8Eki70WHqVdnirjCQcPiJEZn13ytOklvpQh1UH9Qa1yrFccdv0ci/wrUDT0P
 INt7omSqu0h6NBuedz7OjpqShW3Eo/ipTwVWGFO2oYnMUUzoRSqzWZki+SE8APc3DfND
 jBfQ==
X-Gm-Message-State: AOJu0Yw1rRtQhuJN1Dah0j6m97PFOIFcNs/bzt4KLM8LmTcGG+1c/Ea9
 GOKsq+pbi1eGOPzAydp7bi8sZKWIaz2jTs8BOwlx/YYtkfVLaV0NCWaKRxsRN3BzTPxaEZwQjL9
 yRjnOijE=
X-Gm-Gg: ATEYQzxqbY8yv5QLy6zw91LFv/LiIb1XYU5cwXYfUXSeGeJ48rcWANeZOnnfe52iDWd
 WdsSlb5GHkuq6RwbqTeu3WOOlP3aMWsJ3c1J7Y7LvXuXdPUeFdHFkNzxJnUuwbJrRNDht1ZeTv3
 0w6PhoXZGBURNB9ePjsDOER3WBxhZW/isRfnzge1jP0WN7FIcOk1VhQ/ncM3NDkMQMGBFshHuto
 Y5+v35wQsxsFJ2fsIEk+dFcHhjxfxQE/kRINpOcFtBgriUlhUAoiTZaybABwWLWi8zAmT2Pc8t0
 DNsg6cEN46F5E1AwPJSypcdj7LKDEKhAFmGjBdX8P0WjdFlT+tL0U0v0yBwX04UiuxwywN8K06c
 qGYp3BXDZr2SUU2vtQ0D7S9DIHrXdRywk+NqsNFZxNFeCJVa1M9YPQm4q/okN4HobYm7rqqUrk/
 cJL0rUXJg0y7sHZn1O67yiFgUOpvgWNA8gXQelkEQ+mVOBaOj99Zkst5hpgh0dZIAmXz+4hFmbw
 DinTgJfCo8AUvUenNsNpB/YO1S7wEpw7gvOdPZ5TMNn/R1tmPc=
X-Received: by 2002:a05:6808:1802:b0:463:faa3:8dda with SMTP id
 5614622812f47-46757095ef6mr8830676b6e.13.1773710669438; 
 Mon, 16 Mar 2026 18:24:29 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e8185sm18070219fac.12.2026.03.16.18.24.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] boot: Update tests around network symbols in
 BOOT_DEFAULTS_CMDS
Date: Mon, 16 Mar 2026 19:24:28 -0600
Message-ID: <20260317012428.4162476-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issues around a number of
symbols in BOOT_DEFAULTS_CMDS. Due to the nature of how we currently
handle other networking related command options, we need to be testing
for "!NO_NET" (which is the symbol for no networking stack) or "NET ||
NET_LWIP" rather than CMD_NET alone. For consistency and clarity here
use "CMD_NET && !NO_NET" here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 7849928fc37d..afbd0e735163 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -431,12 +431,12 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_FAT
 	select CMD_FS_GENERIC
 	select CMD_PART if PARTITIONS
-	select CMD_DHCP if CMD_NET
-	select CMD_PING if CMD_NET
-	select CMD_PXE if CMD_NET
+	select CMD_DHCP if CMD_NET && !NO_NET
+	select CMD_PING if CMD_NET && !NO_NET
+	select CMD_PXE if CMD_NET && !NO_NET
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
-	imply CMD_MII if NET || NET_LWIP
+	imply CMD_MII if CMD_NET && !NO_NET
 
 config BOOT_DEFAULTS
 	bool  # Common defaults for standard boot and distroboot
-- 
2.43.0

