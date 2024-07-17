Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DEC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B58588AA4;
	Wed, 17 Jul 2024 17:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YFzrXXSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 721C2886E2; Wed, 17 Jul 2024 17:57:24 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B62388A67
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso49413125e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231839; x=1721836639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zd+2qAI1yQTOL2KYVNhEhJIK8nuC2Jsh06iLBM+jtAU=;
 b=YFzrXXSPtmv6O3vE4rtMdUd3YENrhy+CqM3hTV/O2KQQgreGsFd/lYRiITpggUaw4/
 +Nb6q09jQ4unda1bo9AqkgZefjDK5yyohf/3QF4mf+T3VKsOvpvloZZNpu2NUzKd6k7B
 0JCdqXI/haK+yHBgkaHdzi/8GXj2pURRMO13c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231839; x=1721836639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zd+2qAI1yQTOL2KYVNhEhJIK8nuC2Jsh06iLBM+jtAU=;
 b=vZBSOkJndHhkVDq3i0PApHc5OUwrnEyRReRv/8uLGQukZuj64tceVBgdlyO+lbMAjy
 LFuiy9zfIW0HDyskEWneiAHNpZ2l51O2/cTSBI2i4s59f/dJGO+WvYRq+fzX18ARvvZO
 KsegH0JLPaWfdIP/wI8FcXDpST1eV9eQ0zsspEzFKdwEcoBzTh8bcD8gmi55wU608awn
 vj8F38jaU/3a5mmTTLym1VgRX+ObL8BOQP5n5d7hgYyloOGHH3YWKgQocRjPzch/dek2
 CJbtfe9VALW+1EyVqIt3Y2Jmm9q1ANzsQoxpXxpENRKnbZOGf5/W7gpfbt0mmlqnyNQ4
 nmAg==
X-Gm-Message-State: AOJu0Yw3K8MaREwNyWHY7/xutXgQXMHV/N5QHlci0y6oim8bGH+sPEhC
 kPFKJCCKBjpog4NokmUIIMxPi9kQRMgHRM3FWWxjIaTPett5Su2X4Rn0BUylz3fU40CzYRK5oKc
 =
X-Google-Smtp-Source: AGHT+IFjtRRm1gUpRLi/rFFJOYXxY/TREblxlOWxF76Qhwkf/zQ91pK0xmxrimRa9KZW7yPcbiCxEA==
X-Received: by 2002:a05:600c:46c3:b0:426:6edf:4f41 with SMTP id
 5b1f17b1804b1-427c2cadfa4mr16514455e9.8.1721231839066; 
 Wed, 17 Jul 2024 08:57:19 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 02/24] qconfig: Drop the try_expand() function
Date: Wed, 17 Jul 2024 16:56:50 +0100
Message-Id: <20240717155712.2913651-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 2492b37444a..7d3989c7c3e 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -29,7 +29,6 @@ import threading
 import time
 import unittest
 
-import asteval
 from buildman import bsettings
 from buildman import kconfiglib
 from buildman import toolchain
@@ -216,26 +215,6 @@ def read_file(fname, as_lines=True, skip_unicode=False):
             print(f"Failed on file '{fname}: {exc}")
             return None
 
-def try_expand(line):
-    """If value looks like an expression, try expanding it
-    Otherwise just return the existing value
-    """
-    if line.find('=') == -1:
-        return line
-
-    try:
-        aeval = asteval.Interpreter( usersyms=SIZES, minimal=True )
-        cfg, val = re.split("=", line)
-        val= val.strip('\"')
-        if re.search(r'[*+-/]|<<|SZ_+|\(([^\)]+)\)', val):
-            newval = hex(aeval(val))
-            print(f'\tExpanded expression {val} to {newval}')
-            return cfg+'='+newval
-    except:
-        print(f'\tFailed to expand expression in {line}')
-
-    return line
-
 
 ### classes ###
 class Progress:
-- 
2.34.1

