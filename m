Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB705C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06C1828C2;
	Thu,  8 May 2025 09:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wi1PCMzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD85982977; Thu,  8 May 2025 09:29:22 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD7B8059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0b9625662so448158f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689360; x=1747294160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dum9ohghTTHxLooofRyq0C6f9VaDoVbZ2lRC+o6oWZ0=;
 b=Wi1PCMzSQPOqPqhbO77LuCbw7GSgaQvPunsnQlKQzlpgk7vb8NrwHiZZnwH1FLudrB
 cI9TjP4fjoNSz4JfPc/VnspZ2JNV4uHmjBPsGCAS+cr6EpzTNEwqvRZ3p6Gwr0nQ9HZN
 VFMqTmtrg9lBD/uXBiHJv8NkIUkTPh/ysUxQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689360; x=1747294160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dum9ohghTTHxLooofRyq0C6f9VaDoVbZ2lRC+o6oWZ0=;
 b=Ho60kvFcypqyCosjnM3nxs6AJnMjBU9iRneU2PGg6RCw252SHxBsUnnSVbZvj2Jy/r
 poKwEjEcM1cgP4ExOw4xatjF9gsJhd6Dc26R6nQHqvx2hCxihYaCJz86k9CUiM2FKXvo
 T/P6qcFtJsNsPB+LGIEoyyP3kLKSFUGZKVFP7hov1Z6Zj/I3YG3SH1o3nKfCVbEctUBz
 47hfgW10oJdWbKJVqgTjNYIXDq2LfYb/5XjPYjOVnJyg0N9+0WPAM6FsPqntWkvb3c47
 kKbSPoIgTcm8Qyzg3F+hRE5/Ga082ESFNPzSbL0pbBdHLvJfnk/Dab5qZISkvJmyBlWH
 u/nA==
X-Gm-Message-State: AOJu0YyVP0IE2GviVeUP8fIph7lI+/HNjAIKHm3eELuPtDSZCKESPL7o
 uUEEUwg300OXPBKMeAXD8J0fixHsmzC9AGIURsiGkT78CtLfZr6l9IBUZpC/ev3ZMGKcb7ikK3q
 KH48cNkpeWA==
X-Gm-Gg: ASbGncvBLHZV4bX4mEATGSiZ3A9k++yITOVaj0+W8zMuokCeCDEHqthPnwWvYo5Cv0x
 m0xM4EDl4Vr0hPDZHHuhX9eIuy9UWZkBuVq2FdR4nTwE2/e4f3gvYO1yRatmgHZZXdvhSEhd+Hk
 UkZUheu0g+LONN8HlMVUMg3qG4G4XeUYTpIxbXpVx593id0l1nm5Jg6mhBbiy1eKPgxfycSx5er
 M+k+MwTbaK1zt0IjrVQGKRYd0/jTh+dvJGd+0AcgIbH0KwpfOXC3zLWgXtRGJ73v702mBa4pbIQ
 Up5XmR7PGpdw8/MZAyYuReBoSKT7O796EpfFEnAqNWQPuFKL
X-Google-Smtp-Source: AGHT+IG8Ury1tHgAmcnxtmGxjtkG3BKYWrDMvsUN7Qcu2cKIyP9m+41PgszOdsYV0ppkIpvzhrfhfA==
X-Received: by 2002:a5d:64ac:0:b0:3a0:7f9c:189a with SMTP id
 ffacd0b85a97d-3a0b4910f42mr5080351f8f.0.1746689359788; 
 Thu, 08 May 2025 00:29:19 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/20] patman: Add all files to __init__.py
Date: Thu,  8 May 2025 09:28:28 +0200
Message-ID: <20250508072907.207175-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Some files are missing from the __all__ list, so add then. Reformat the
list to use more of the width of each line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/patman/__init__.py b/tools/patman/__init__.py
index 6de0e9fba10..14451e35f36 100644
--- a/tools/patman/__init__.py
+++ b/tools/patman/__init__.py
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-__all__ = ['checkpatch', 'commit', 'control', 'func_test', 'get_maintainer',
-           '__main__', 'patchstream', 'project', 'series',
-           'settings', 'setup', 'status', 'test_checkpatch', 'test_settings']
+__all__ = [
+    'checkpatch', 'cmdline', 'commit', 'control', 'func_test',
+    'get_maintainer', '__main__', 'patchstream', 'patchwork', 'project',
+    'send', 'series', 'settings', 'setup', 'status', 'test_checkpatch',
+    'test_settings'
+]
-- 
2.43.0

