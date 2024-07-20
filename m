Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC61C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD74A88C57;
	Sat, 20 Jul 2024 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MRA4941V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEA388C3E; Sat, 20 Jul 2024 12:50:11 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEB0886CC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so16843195e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472609; x=1722077409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWDMFFWDcPMF1rIL8dXHAq/rhvLi+dAmftZyNRstLH8=;
 b=MRA4941VlLm7EZpUQ01PqlKUm63WA/1N7Cx3YK1i6gJ1b8U3Xs8cfDYz0SFmMizAbz
 JGxdz60l42J4/tXHZoG2RNCvGc0m4C+1sILSb+8+h0WV5Q4n6ND821NXC71Ua2dk4C8z
 vD+uCYsUedCCiuJ/xU8cqGiNRUuTwvjHPIkAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472609; x=1722077409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWDMFFWDcPMF1rIL8dXHAq/rhvLi+dAmftZyNRstLH8=;
 b=pmW3d+8Wz6xcKA/peB8A2aFi1D1J4h1t+GlNSaZQDIvLb1K65yCAyCWAz10bpsrKMD
 SiVmLhATDDnNnS/8fGzVAGjjoBa4Ue6Wko3lA0EfdctrSBKSeny57xWfxFYeVULKOlLQ
 77T/2U0a/InpdNh261BP7Ecufe1fuH0QdcCKASDPIFwwpZU0Niuwn0ls0h8QMPGZmW9M
 Gj8A/ltZetT/MhHeu3y69F8JJb5K8koLRtV+Mz1tVO2cJG7vkBE00mtXCvDHBmjmLSAz
 Ak8eLczBfd3WBlGZS8MuddKa6fp3z/20xdchp4e7temlUPayoTdg1T5mbf20eI+Hp/IT
 dK0w==
X-Gm-Message-State: AOJu0YyBrMrn76NsRR/oki0XxNjPxa9I8tsgv/YajiWCLhw2sliKfXSc
 IgFDqpNthY7eDgXucGeRd4yI1ksbSCr6XkVZxwIa7tYNru1wY6cFNhnXu74DZcHDV+d8vauGi+M
 =
X-Google-Smtp-Source: AGHT+IEtZIRhFfBPaamSlpkuZVy5yg8Rp8Mnd2OqktjXXoDgfop97jeHKF+9T4neTwYOGmb3QCKUiA==
X-Received: by 2002:a5d:47a6:0:b0:368:4e86:14cc with SMTP id
 ffacd0b85a97d-369bae3071emr987524f8f.10.1721472608756; 
 Sat, 20 Jul 2024 03:50:08 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/20] binman: Mention expanded entries in u-boot-vpl
Date: Sat, 20 Jul 2024 11:49:39 +0100
Message-Id: <20240720104950.2730773-10-sjg@chromium.org>
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

Add a comment about this entry type being expanded, to match the comment
for SPL and TPL. Drop an unwanted line in the SPL and TPL docs while
here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entries.rst               | 11 +++++------
 tools/binman/etype/u_boot_spl_nodtb.py |  2 --
 tools/binman/etype/u_boot_tpl_nodtb.py |  2 --
 tools/binman/etype/u_boot_vpl.py       |  3 +++
 tools/binman/etype/u_boot_vpl_nodtb.py |  4 ++--
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index bdda1ef2855..38dfe2c7db9 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -2290,8 +2290,6 @@ u-boot-spl-dtb
 
 SPL can access binman symbols at runtime. See :ref:`binman_fdt`.
 
-in the binman README for more information.
-
 The ELF file 'spl/u-boot-spl' must also be available for this to work, since
 binman uses that to look up symbols to write into the SPL binary.
 
@@ -2480,8 +2478,6 @@ u-boot-tpl-dtb
 
 TPL can access binman symbols at runtime. See :ref:`binman_fdt`.
 
-in the binman README for more information.
-
 The ELF file 'tpl/u-boot-tpl' must also be available for this to work, since
 binman uses that to look up symbols to write into the TPL binary.
 
@@ -2571,6 +2567,9 @@ in the binman README for more information.
 The ELF file 'vpl/u-boot-vpl' must also be available for this to work, since
 binman uses that to look up symbols to write into the VPL binary.
 
+Note that this entry is automatically replaced with u-boot-vpl-expanded
+unless --no-expanded is used or the node has a 'no-expanded' property.
+
 
 
 .. _etype_u_boot_vpl_bss_pad:
@@ -2659,8 +2658,8 @@ Properties / Entry arguments:
 
 This is the U-Boot VPL binary, It does not include a device tree blob at
 the end of it so may not be able to work without it, assuming VPL needs
-a device tree to operate on your platform. You can add a u_boot_vpl_dtb
-entry after this one, or use a u_boot_vpl entry instead, which normally
+a device tree to operate on your platform. You can add a u-boot-vpl-dtb
+entry after this one, or use a u-boot-vpl entry instead, which normally
 expands to a section containing u-boot-vpl-dtb, u-boot-vpl-bss-pad and
 u-boot-vpl-dtb
 
diff --git a/tools/binman/etype/u_boot_spl_nodtb.py b/tools/binman/etype/u_boot_spl_nodtb.py
index e7ec329c902..0e172aec1b0 100644
--- a/tools/binman/etype/u_boot_spl_nodtb.py
+++ b/tools/binman/etype/u_boot_spl_nodtb.py
@@ -23,8 +23,6 @@ class Entry_u_boot_spl_nodtb(Entry_blob):
 
     SPL can access binman symbols at runtime. See :ref:`binman_fdt`.
 
-    in the binman README for more information.
-
     The ELF file 'spl/u-boot-spl' must also be available for this to work, since
     binman uses that to look up symbols to write into the SPL binary.
     """
diff --git a/tools/binman/etype/u_boot_tpl_nodtb.py b/tools/binman/etype/u_boot_tpl_nodtb.py
index 9bb2b5dda30..e0c8a557d07 100644
--- a/tools/binman/etype/u_boot_tpl_nodtb.py
+++ b/tools/binman/etype/u_boot_tpl_nodtb.py
@@ -23,8 +23,6 @@ class Entry_u_boot_tpl_nodtb(Entry_blob):
 
     TPL can access binman symbols at runtime. See :ref:`binman_fdt`.
 
-    in the binman README for more information.
-
     The ELF file 'tpl/u-boot-tpl' must also be available for this to work, since
     binman uses that to look up symbols to write into the TPL binary.
     """
diff --git a/tools/binman/etype/u_boot_vpl.py b/tools/binman/etype/u_boot_vpl.py
index 31d7e8374e2..0797831688f 100644
--- a/tools/binman/etype/u_boot_vpl.py
+++ b/tools/binman/etype/u_boot_vpl.py
@@ -27,6 +27,9 @@ class Entry_u_boot_vpl(Entry_blob):
 
     The ELF file 'vpl/u-boot-vpl' must also be available for this to work, since
     binman uses that to look up symbols to write into the VPL binary.
+
+    Note that this entry is automatically replaced with u-boot-vpl-expanded
+    unless --no-expanded is used or the node has a 'no-expanded' property.
     """
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node, auto_write_symbols=True)
diff --git a/tools/binman/etype/u_boot_vpl_nodtb.py b/tools/binman/etype/u_boot_vpl_nodtb.py
index 64c2767488d..765cf53d164 100644
--- a/tools/binman/etype/u_boot_vpl_nodtb.py
+++ b/tools/binman/etype/u_boot_vpl_nodtb.py
@@ -16,8 +16,8 @@ class Entry_u_boot_vpl_nodtb(Entry_blob):
 
     This is the U-Boot VPL binary, It does not include a device tree blob at
     the end of it so may not be able to work without it, assuming VPL needs
-    a device tree to operate on your platform. You can add a u_boot_vpl_dtb
-    entry after this one, or use a u_boot_vpl entry instead, which normally
+    a device tree to operate on your platform. You can add a u-boot-vpl-dtb
+    entry after this one, or use a u-boot-vpl entry instead, which normally
     expands to a section containing u-boot-vpl-dtb, u-boot-vpl-bss-pad and
     u-boot-vpl-dtb
 
-- 
2.34.1

