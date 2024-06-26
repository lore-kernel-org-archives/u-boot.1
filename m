Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A91C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46022884FF;
	Wed, 26 Jun 2024 18:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GGH4tXNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEC1884F1; Wed, 26 Jun 2024 18:00:09 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230E8884C6
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so1462205e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417606; x=1720022406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=GGH4tXNUYuZz9dlHij6F7z3Lsgh67GN4vWpeqcGhbAoX+a6dO3td/tye1dxqFsWd85
 H/781a23oIKzlBgs2aJg4D8x54n2m82v0EJxQkt+nmafuw+q6b8najIK14hAKpZPffvC
 tYM6VrPRUhtfmEKjBJBFM8CjZBOIKtAhW9pfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417606; x=1720022406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=Zp01Zw9QZ6Cq/FRw3dyzTgMn8DfmkWhGOiEqQe22Sxps8kvYV7Lu1ksYCKza2x5vgK
 1v0BDcrl1gNzEgiENVECNbk/J5jIpRSO3vJsXZJO70iZUk3P9+hTmmE/CcFwaiv7z3W0
 OQxEPQI7MV/0WGKlpScV1KRzvr/MjMEQhLJ3pf3rpVMQbUGVs6bJ+p5Ua8znjVqanfpq
 1kIAg5Q2vt1lNh+tKT9WFG6L0fPEws/LFvbL7mMcHenWUUvwqOWxHKrW0SjupuOy0wqW
 JNXrbHY7l3SsLGDLHOJgrEWhfpzKCHSNA0TwbIoZzySJJcXAzcmDMVz6Z6axZqMkZggm
 ff/w==
X-Gm-Message-State: AOJu0YzC1dcL2SiOWoph0SijPzCfwgFGhqQUZdQ3usGs20BUaN6TIE30
 WtAHtjqMDVFyFSyx+E2N3ywFDCfnypRFtD+sFKxBw9XumFrdC6/gGVVuwR+sCQyqzUU3R5cNfq/
 zcw==
X-Google-Smtp-Source: AGHT+IFiCBfavSNUmN4a3wpU9fGwNvHue3t4+xtCR/RGELAWsTKR5YQurWMNkqBNCAZ7CuHvJwwRIA==
X-Received: by 2002:a7b:cbd0:0:b0:424:ac14:ddc8 with SMTP id
 5b1f17b1804b1-424ac14deddmr19796295e9.17.1719417606386; 
 Wed, 26 Jun 2024 09:00:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v5 03/16] binman: Deal with mkeficapsule being missing
Date: Wed, 26 Jun 2024 16:59:32 +0100
Message-Id: <20240626155945.278640-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

Tools cannot be assumed to be present. Add a check for this with the
mkeficpasule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: b617611b27a ("binman: capsule: Add support for generating...")
---

(no changes since v1)

 tools/binman/etype/efi_capsule.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e3203717822..47da5da324b 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -150,6 +150,10 @@ class Entry_efi_capsule(Entry_section):
         if ret is not None:
             os.remove(payload)
             return tools.read_file(capsule_fname)
+        else:
+            # Bintool is missing; just use the input data as the output
+            self.record_missing_bintool(self.mkeficapsule)
+            return data
 
     def AddBintools(self, btools):
         self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
-- 
2.34.1

