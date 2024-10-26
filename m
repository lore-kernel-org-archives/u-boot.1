Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ADFD10BFF
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E02C890B9;
	Sat, 26 Oct 2024 18:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZcoQ7H07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F6088F92; Sat, 26 Oct 2024 17:53:02 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E6688EA8
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c933d5bdf1so517967a12.0
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957971; x=1730562771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tUMdBtrRJJfkkMZKXd3+L8/bZhUlb5XaVO/1jN6I/o4=;
 b=ZcoQ7H07f/P9XRdCeNgrSJWjtSggKpRQsoxln3plHQT/4Y5qfhyFYXxUT1LfpTLs4q
 yRO/tKLkzIxtpWfUcEmyU29yO8RLCRGLxYgcURZIQaCu+znGKwoyAyLTmYCD4CT0wB4k
 pbuzSujOXG6PTU3+ZHYjg4HI1H+0SfJL/XlrQWXejZe+bFAhtYSRfwX/Sf73YBgTWp0L
 R0NJRiCwvWaryg509+YpwaP/WfLZX92fy1ISvopUvQdHNbekTOLlUx+WVjgZ2tp0cOSC
 VMECqw82kyqXldcz00pETzJkDT0Ha3mv8ZZUvD5rOX5MfcBtH9uQCr6jXOUguEOnX1hX
 PapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957971; x=1730562771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUMdBtrRJJfkkMZKXd3+L8/bZhUlb5XaVO/1jN6I/o4=;
 b=ipIu/tVRdmQAcJ5WQiSXhozMhy/J6GXOy+87FOh9ap8xDfzOLiv8cXZnU4e0l18NEz
 81bJ/i9fcpR4a/s/lCrGcFaiGNTY8k+clzxyZColU5CCJGpqTjPa0ndMvH4j/1XdIPPx
 KyIPVSzycdMJQCc+HsFzwS2XOasDy0KqfJRQA7Hte2piBiFE74kTx59QqFtf/8ptvpaq
 1bE49qTan5SHwByBtalRRWhuc0SwsHPr1sInaCwnZV0ZWGdvWP3Rftq+M0/wnsVaVQ+G
 IzaY7cS1IOEfmRuPNxW4cvKlk1cEQuCuxIexwp65PoI6D/fEy1nLu9GeaiGo35ZfWAgX
 qp7w==
X-Gm-Message-State: AOJu0Ywthx2l4Axq2rAvIYOqGWduJ0Ip/KoBr/s3JDbJvNemInJjkqRW
 uiSGHQjNyJPm28No3ckTTdmmEz+1a93s/+IkqXz2mx0FoFFljl+6I9n6/g==
X-Google-Smtp-Source: AGHT+IHDS25alN3kNm8TpcQungSVanNqAOXGRMdL8crRi5d3OnRYjfNdYn0ZwxfLPeUJ6u+leTNh9A==
X-Received: by 2002:a05:6402:210b:b0:5c2:6850:7b2 with SMTP id
 4fb4d7f45d1cf-5cbbf94932cmr956703a12.6.1729957970373; 
 Sat, 26 Oct 2024 08:52:50 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:49 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 11/11] doc: develop: orthographic delights
Date: Sat, 26 Oct 2024 15:52:20 +0000
Message-Id: <20241026155220.26300-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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

Fix some typos and duplicate words in documentation files.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 doc/develop/gdb.rst      |  2 +-
 tools/binman/binman.rst  |  4 ++--
 tools/binman/entries.rst | 22 +++++++++++-----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
index 4e359c7f22..ebe65492ef 100644
--- a/doc/develop/gdb.rst
+++ b/doc/develop/gdb.rst
@@ -13,7 +13,7 @@ Similarly QEMU can provide a GDB server.
 Preparing build
 ---------------
 
-Building U-Boot with with reduced optimization (-Og) and without link time
+Building U-Boot with reduced optimization (-Og) and without link time
 optimization is recommended for easier debugging::
 
     CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 381e55686f..df682ba86d 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1047,8 +1047,8 @@ Here, a new 'value' property will be written to the 'hash' node containing
 the hash of the 'u-boot' entry. Only SHA256 is supported at present. Whole
 sections can be hased if desired, by adding the 'hash' node to the section.
 
-The has value can be chcked at runtime by hashing the data actually read and
-comparing this has to the value in the device tree.
+The hash value can be checked at runtime by hashing the data actually read and
+comparing this hash to the value in the device tree.
 
 
 Expanded entries
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index e918162fb4..79d93eb22d 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -240,7 +240,7 @@ Properties / Entry arguments:
         lz4: Use lz4 compression (via 'lz4' command-line utility)
 
 This entry reads data from a file and places it in the entry. The
-default filename is often specified specified by the subclass. See for
+default filename is often specified by the subclass. See for
 example the 'u-boot' entry which provides the filename 'u-boot.bin'.
 
 If compression is enabled, an extra 'uncomp-size' property is written to
@@ -286,7 +286,7 @@ Entry: blob-ext-list: List of externally built binary blobs
 This is like blob-ext except that a number of blobs can be provided,
 typically with some sort of relationship, e.g. all are DDC parameters.
 
-If any of the external files needed by this llist is missing, binman can
+If any of the external files needed by this list is missing, binman can
 optionally ignore it and produce a broken image with a warning.
 
 Args:
@@ -1164,7 +1164,7 @@ Properties / Entry arguments:
 
 FMAP is a simple format used by flashrom, an open-source utility for
 reading and writing the SPI flash, typically on x86 CPUs. The format
-provides flashrom with a list of areas, so it knows what it in the flash.
+provides flashrom with a list of areas, that it knows what is in the flash.
 It can then read or write just a single area, instead of the whole flash.
 
 The format is defined by the flashrom project, in the file lib/fmap.h -
@@ -1338,7 +1338,7 @@ Properties / Entry arguments:
 This file contains a binary blob which is used on some devices to set up
 the silicon. U-Boot executes this code in U-Boot proper after SDRAM is
 running, so that it can make full use of memory. Documentation is typically
-not available in sufficient detail to allow U-Boot do this this itself.
+not available in sufficient detail to allow U-Boot do this itself.
 
 An example filename is 'fsp_s.bin'
 
@@ -1411,7 +1411,7 @@ Properties / Entry arguments:
 This file contains code used by the SoC that is required to make it work.
 The Management Engine is like a background task that runs things that are
 not clearly documented, but may include keyboard, display and network
-access. For platform that use ME it is not possible to disable it. U-Boot
+access. For platforms using ME, it is not possible to disable it. U-Boot
 does not directly execute code in the ME binary.
 
 A typical filename is 'me.bin'.
@@ -2303,8 +2303,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'spl/u-boot-spl' must also be available for this to work, since
 binman uses that to look up the BSS address.
@@ -2479,8 +2479,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'tpl/u-boot-tpl' must also be available for this to work, since
 binman uses that to look up the BSS address.
@@ -2678,8 +2678,8 @@ to avoid the data overlapping with U-Boot variables. This entry is useful in
 that case. It automatically pads out the entry size to cover both the code,
 data and BSS.
 
-The contents of this entry will a certain number of zero bytes, determined
-by __bss_size
+The contents of this entry will be filled up with a number of zero bytes,
+determined by __bss_size
 
 The ELF file 'vpl/u-boot-vpl' must also be available for this to work, since
 binman uses that to look up the BSS address.
-- 
2.25.1

