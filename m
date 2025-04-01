Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265BEC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F4FC8209F;
	Wed,  2 Apr 2025 00:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TwIQhDee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DB482045; Wed,  2 Apr 2025 00:59:08 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7201581F7B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-601ad30bc0cso201668eaf.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743548338; x=1744153138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RIbvJEeP1QJyOK4K48V2S2za5/Ez97pN5xxQcGAPkBM=;
 b=TwIQhDeeV4Revf9jocJ7D9i/C+OPWuBiFUM/Wmdzhnw8dTVqgsuxsYhedOfDFAbXAR
 W4Kd8NswhnQ6XahHAeGNKbTsHBsgfTcxnZ3epSctY0UBiaVOu0uDV2C0bh+NXWUR0pWf
 TejXHACVDuXkUYUEUliJBPIlXiuzX2xfIU/3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743548338; x=1744153138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RIbvJEeP1QJyOK4K48V2S2za5/Ez97pN5xxQcGAPkBM=;
 b=cfwxBD4qs99sS8LEcGicvIFOXWpcLvpD2zbbbbEoetlBD26Z1sSh2wX2H3iCCU0vxF
 C+NpPUhmFHsC18WJr2fdds0Yy9kZSDhaNARBvVimiSjN8VYNl00h2s9/KLwK/gSWFqEi
 ng+Do/vpEJZLoANk5mjWEadZ0mK9BA8apq65c9tnOofMyP9fb7XK88TQBgZTbbafj3lb
 mtOdXv4pOzMp1RY88jqhz+DxM9RzGTJl1r0I/NQMUEnjEvwMmkVAJUGCOdzpJCQGg4dQ
 xUddDboT6fue+iulR4UXDwYBAgKyCdYUfK8SoyC7W3qdaMbLKfjwOSR3XoovjYp3GOXb
 hgxA==
X-Gm-Message-State: AOJu0YzqZ7wAtRAcONZZ88FngO0bz7E2vvwJUwfqgffMhMKSxZIO+M1r
 VmyEaYAnwMOatHjpnqtJC7vxYUQmhiozYOonZ7RaHWloT0gS/FqWneHM8soPT9MvqrkT3n0ApH8
 t
X-Gm-Gg: ASbGnctB/TPmQg29Bpy6f8ZLte7WLSY1L7f4qmIF9s+RS3ZwBSa878We/NAPynqG/A7
 NGD5CmPfgnBZ5oirjypGRdF/Cff80H1yTAxIcPMzLCYj3wOAQwrJ3Tn1Wg0XB0uJoQZ0Zn3pLMy
 NyuV5yKTr9v24WpyiwNpazLLbTEGeF1ytIMiSVZHGPrS2C6FAAistB/IrhaiplxZgQzvAUk9MZX
 4mWGeY/lpLDSUCjBRQ0bT5CJObk7d2R+I+r9r5I5KXG1CKkEkXIGsheIWaGI9gHCQk9tNirwGf4
 mZDqTmQowhHtZlYnk6P3GBEsiA1nHstaGqzQ9vpkk3h+e6C4Vpzz/6N4LF1ZGJixveIe/9sLacb
 tgDLXfoJHqwMEjSMdcRI=
X-Google-Smtp-Source: AGHT+IEl29uAMsL9ltq1C4Kn7HKF80vyZYUy5VyKemjUMaOEagTvagFaq9bWYPmDjvBSNh+mUEfF4A==
X-Received: by 2002:a05:6871:810f:b0:2b8:5d9e:d0d9 with SMTP id
 586e51a60fabf-2cc54f225c5mr1274911fac.4.1743548338126; 
 Tue, 01 Apr 2025 15:58:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a3f3e52sm2528791fac.6.2025.04.01.15.58.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:58:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v3 3/3] doc/develop/codingstyle.rst: Expand to include
 CONFIG_IS_ENABLED and PHASE_
Date: Tue,  1 Apr 2025 16:55:25 -0600
Message-ID: <20250401225851.1125678-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401225851.1125678-1-trini@konsulko.com>
References: <20250401225851.1125678-1-trini@konsulko.com>
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

Expand the conditional compilation section to explain when to use
CONFIG_IS_ENABLED rather than IS_ENABLED and provide an example. Next,
note what the PHASE_ macro is supposed to be used for as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- Reword the start of the new content a bit after talking with Quentin
  Schulz.
Changes in v2:
- New patch.
---
 doc/develop/codingstyle.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 7211e4e4eed1..bc18b2ebb7b0 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -192,6 +192,25 @@ inside the block, and check it for correctness (syntax, types, symbol
 references, etc).  Thus, you still have to use an #ifdef if the code inside the
 block references symbols that will not exist if the condition is not met.
 
+When working with xPL (see :doc:`spl` for more information) we need to take
+further care to use the right macro. In the case where a symbol may be
+referenced with an xPL-specific Kconfig symbol, use the CONFIG_IS_ENABLED macro
+instead, in a similar manner:
+
+.. code-block:: c
+
+	if (CONIG_IS_ENABLED(SOMETHING)) {
+		...
+	}
+
+When dealing with a Kconfig symbol that has both a normal name and one or more
+xPL-prefixed names, the Makefile needs special consideration as well. The
+PHASE\_ macro helps us in this situation thusly:
+
+.. code-block:: make
+
+        obj-$(CONFIG_$(PHASE_)SOMETHING) += something.o
+
 At the end of any non-trivial #if or #ifdef block (more than a few lines),
 place a comment after the #endif on the same line, noting the conditional
 expression used.  For instance:
-- 
2.43.0

