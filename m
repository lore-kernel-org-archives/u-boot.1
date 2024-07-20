Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01025C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7702E887DB;
	Sat, 20 Jul 2024 12:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b++QdrdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AF288C35; Sat, 20 Jul 2024 12:50:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94E588881
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso1263301f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472606; x=1722077406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=li1IbXJw6DxJm/ADzdiuFI1KqXBqFMV9qEsClyWdShg=;
 b=b++QdrdFwe5EApCFLIHXXvc2M/hPTsYn+K8pmsLHg30bSZAfi6EjSoKkhC5LUWb+Lk
 wwKOBR8vFQQckMvFQgqzdc6KADrsjpo8zKSB3N7f3Bv8WAzrFmKIhgZXdiOAdyYr+8yY
 4feSkggWLlPSRt8aLW3p8IJorXwVO1bpqpXxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472606; x=1722077406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=li1IbXJw6DxJm/ADzdiuFI1KqXBqFMV9qEsClyWdShg=;
 b=OVVFN1XKImAQSwd4F3kHqX2twrf65zwDABfrnvedXmgCwCNV4v85TctXI3jvKGUUWB
 m8Fox8EpQ7Jm2pdVcbjpa57NMV0zHTrdraUyGtFiKs4QpZC8D6FjknICCe4yYCK7G23d
 nYpTJz2OPCZHkfAvupyur6ieRfqWT797MQmhDndx7XReX5ETt5w2cIM9gXavIfvZUpo2
 fZuwISXkVAa5Kf0ALNivxgRg4hBgAvOwnsN7waP4czCfi+v8HeLGYv4ULoq+d9fs2Cbl
 uzCCR3BpAkwGRLlvr0WruI2Ck03v/VLwL7pUlzZOurQeeX6SQnNRvyvH91gxhWPMZ21O
 3RSQ==
X-Gm-Message-State: AOJu0YzPX8FX6RiE46HaCf9or+x+OxYv43Anu1gznnkiMNAUunC58w00
 /4sSWFBtrKZ4YoUUI64nsyaSDFKqk+zFAv7lCFrI86WBXaif/oZpX2ne3kf6ShaBbttjHRVJtZM
 =
X-Google-Smtp-Source: AGHT+IGsvKFpS6iVqKnwPzwDzsPqRKfryNdHx7awwHctoQEVp9CNo6LTWbjYI14cYGyRIi/xLxo9iQ==
X-Received: by 2002:a5d:5886:0:b0:367:9d2c:9602 with SMTP id
 ffacd0b85a97d-369bb2ea299mr935582f8f.49.1721472606261; 
 Sat, 20 Jul 2024 03:50:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/20] binman: elf: Add more debugging to
 LookupAndWriteSymbols()
Date: Sat, 20 Jul 2024 11:49:36 +0100
Message-Id: <20240720104950.2730773-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

When symbol-writing does not appear to work, it can sometimes be hard to
figure out what is going on. Add some more debugging to help.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/elf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 2ecc95f7eb8..a4694056391 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -275,7 +275,7 @@ def LookupAndWriteSymbols(elf_fname, entry, section, is_elf=False,
         return 0
     base = syms.get(base_sym)
     if not base and not is_elf:
-        tout.debug('LookupAndWriteSymbols: no base')
+        tout.debug(f'LookupAndWriteSymbols: no base: elf_fname={elf_fname}, base_sym={base_sym}, is_elf={is_elf}')
         return 0
     base_addr = 0 if is_elf else base.address
     count = 0
-- 
2.34.1

