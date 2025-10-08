Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81255CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E0683948;
	Wed,  8 Oct 2025 22:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fyi26ffv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DFE8394A; Wed,  8 Oct 2025 22:41:23 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F280383929
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so372370a91.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759956079; x=1760560879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=IX3LOffebHiEd8vYBHDKNQWEe/xQ2N7ABX2nfb1Sbcw=;
 b=Fyi26ffvu4mIyPzKji501FOFiAYASDGyVQDmZt0zm9EhxPiG044BjT3qReaeNT5H1r
 zvSKUHUWS62Kpa8T0u3rAigl0Vkm7bEDT2ZC6JC3N1KVyHwuNsxu8Qtifg+ke7dKeTLI
 CB5boiEpSUkXCI1ePs0OFcVWziSPVv/NIb/Vmmhne5+70PXZT6gQE7044WUQIE4jIfpG
 +efBu45YgAem5+JmCPJ28/Jxw1n/ziMateu8UMMR2Y8HWbYd64k3NPZNX/ET43trWtJ4
 JTP7109rHrnnQhdNPIlv8Fiq33pOuqJQGnLkkg9GjRP5xgdqSYxXOr78NLG7JgNWqQ+m
 Ibkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759956079; x=1760560879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IX3LOffebHiEd8vYBHDKNQWEe/xQ2N7ABX2nfb1Sbcw=;
 b=kcqkbEuhsiK+xwx7qI/PnLx0oxEb1AWnymoy8QWDjHNDLFhf606gKuVtmlkKzfSvll
 v9Bjr/Hl98t/2IG9CMS8j5U5bnYF5ONHp92sRoj5NkqT2P1vMRuxoyMNW5aQRL8o0OEt
 zEdDO9e/c6MAkteg4dOG14Bv7KJaKWL2ScSbbIsQ0Sjk6g5fWh3oQYVFOPcl7A0v3F4M
 6H28TofAQ2hkrNc/1nSV8wkEoCp7/SZKQjT+aBa2GeEXTrJw19md44jXGm3cAGGgGfPG
 exDk347hTAqVh9vSMILTdXRtwL29UNNEbMDJ5S+qAdpJxKTvMV8po6fiDVUaE9AyQsKz
 UFiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUedOXYLp/7zwctqKXC8ioRJNCl2LWYq1y2pRxa7Ebqs32+wKAtrwBJ8+vhTmyCdnNHsSmvT9A=@lists.denx.de
X-Gm-Message-State: AOJu0YyMw7YoEqrbBxsjC3VfH68PG+uEfMbs5VTNBy/plbSLLb/xkUWs
 76L/BZCOvKhkF9hoMQvgB9fDAgx/zlZgvPYaV9u2Ratnc0LWiXfh5DVb62KhaElY0JpePw==
X-Gm-Gg: ASbGncsG1dvznOShkRxH2RRm14CQuUU+PBsCOZ/P5UpN9pzflLgvlm9zfETgshZU0kl
 6jcT/zgjOkgHmGmjkOBPEzdwi2MJ5+iefb0+3t+ua5GZUMw08NYJVDQDgpfo+1asUC4wgKWK4Ah
 nVN2kkpH8qdLUosvYhpqW8PjVeftX8aHlU7rUMfEAOd6NJMjxA7yo7n7V8Fu6hSVVC6x1xzwTxH
 NkuP8qXFnIMNgUw+0j7+vZEFJaZ69CjL9GHo9QZaqkuEWz728LpjuAWfGenRQkrkazMF74Vy8w+
 axhObXIdAHSM/nRyb7YdElOr3EJy1NDwxodfcK2jgw/e0QTjgmN59xvPjGMMSUCDQd8qSTZgkzF
 7buuLxlffyhbEhChb8q/P2XRVLWvI+ABdAkK5nOjQRpOuMxBgDUd67TDViSWbytyM475SNc5W
X-Google-Smtp-Source: AGHT+IHwVypPgrnAy7NAdUiyTmFDe6yYg8T6BFGxuQB7L7T2uwR5I/7tSK990HlZM/F2NYxNUa85vA==
X-Received: by 2002:a17:90b:4a06:b0:32e:dd8c:dd2a with SMTP id
 98e67ed59e1d1-33b50f2c758mr6469561a91.0.1759956079246; 
 Wed, 08 Oct 2025 13:41:19 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b529eecf9sm1784683a91.4.2025.10.08.13.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:41:18 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] cmd/dma: documentation
Date: Thu,  9 Oct 2025 04:41:03 +0800
Message-ID: <20251008204103.1497-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

This explains how
to use the new U-Boot command 'dmareset'.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 doc/usage/cmd/dmareset.rst | 55 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst        |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 doc/usage/cmd/dmareset.rst

diff --git a/doc/usage/cmd/dmareset.rst b/doc/usage/cmd/dmareset.rst
new file mode 100644
index 00000000000..d30f1d3e8d4
--- /dev/null
+++ b/doc/usage/cmd/dmareset.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: dmareset (command)
+
+dmareset command
+================
+
+Synopsis
+--------
+
+::
+
+    Usage: dmareset <channel 0-7> [<channel 0-7> ...]
+    dmareset - Release PL330 DMA channel reset(s) for SoCFPGA
+
+    Usage:
+    dmareset <channel 0-7> [<channel 0-7> ...]  - release reset for one or more DMA channels
+
+dmareset channel
+----------------
+
+Release the DMA channel reset *channel*.
+
+Parameters
+----------
+
+channel
+    DMA channel number
+
+Example
+-------
+
+Release DMA channel(s)::
+
+    => dmareset 0
+    PL330 DMA channel 0 reset released
+    => dmareset 1
+    PL330 DMA channel 1 reset released
+    => dmareset 0 1
+    PL330 DMA channel 0 reset released
+    PL330 DMA channel 1 reset released
+
+
+Configuration
+-------------
+
+The dmareset command is only available if CONFIG_CMD_C5_PL330_DMA=y in
+"Shell scripting commands".
+
+Return value
+------------
+
+If the command succeds the return PL330 DMA channel $? reset released.
+If an error occurs, the return Error: channel must be 0-7.
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 3a48521d5d5..809bf31b2ac 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -57,6 +57,7 @@ Shell commands
    cmd/cpu
    cmd/cpuid
    cmd/cyclic
+   cmd/dmareset
    cmd/dm
    cmd/ebtupdate
    cmd/echo
-- 
2.47.1.windows.1

