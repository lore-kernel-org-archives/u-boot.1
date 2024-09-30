Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AC3CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE3D88EF8;
	Mon, 30 Sep 2024 03:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jg87uDTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0FCB88F33; Mon, 30 Sep 2024 03:51:02 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A83988A0D
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-82aa8c36eefso246821339f.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661017; x=1728265817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fP1RmEvIU2Sh7Be5Zg+73FY0r6t2TbCqXiAwHWLxaN4=;
 b=Jg87uDTUciNiDXXHAhjRXKrVTLJhbq8iKsqsvOrms6ww3Vk2y3vv+nJLEcsbz1b4qv
 1H8fNj7juRW5TSouFYw4D88Cx+dhmwWuIV865i5zWN1uk6ZA/smzcEnFlTeEZDyjTWXm
 ItAExaVQSJs4x16WkhE1d1IAF7KYefW1JY/SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661017; x=1728265817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fP1RmEvIU2Sh7Be5Zg+73FY0r6t2TbCqXiAwHWLxaN4=;
 b=F8LYaSeKXm3kRiBCYojos7hirMCM9KbVHBD/Ou9KHDD0aOrJbEu7il2hiXHm8osTmS
 RDop299I17i5Nq2+uXbPPtWr2vmbiU5nLBE2UgJ1nE1c27L07lhu9U/bgfbBER/+KIkp
 xZ24xhgLX4qE2vtjHmQApVoYgi+QZ/nnu0JV4+r4Xx2elTe+J4GF2PZ/bPfgP77CNunr
 PqMYU/PE0y0gJDJ36BJqVqsdfu8kXTLsrcoY208hKwl4sAnRVPbQK48Y/0XJ/wSeq5MX
 wPo38GKzD7aJLeMF2bweEdp7veC9pRxgUk5k0ZMT0yHFEhfmZq15McTqKqOgLx2wFe7c
 Z/rA==
X-Gm-Message-State: AOJu0YyehEwTmVXXQjbD3p6NME2YaUvhceXt8jsvclR1rQV9A07hjV6k
 OiRXMYg3pnWViPzapOvJZXfHHNtRjaTVG8+XK8LLz7vW2s5c1PAIMtbZsmAq0xGFQdtufb04xqG
 rew==
X-Google-Smtp-Source: AGHT+IF+OS4Y/KVk+qcip5U7DecKKi3aix71FA+4Wxuc7bBYtZmFHxkANaZN6QadzphEOCDK2M+ZNw==
X-Received: by 2002:a05:6e02:1aa6:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a3451b9ea5mr89701245ab.21.1727661017235; 
 Sun, 29 Sep 2024 18:50:17 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/33] qconfig: Add XPL_BUILD to ignored symbols
Date: Sun, 29 Sep 2024 19:49:33 -0600
Message-Id: <20240930014956.1434060-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

This now appears in the code base, so add it to the list of ignored
symbols in qconfig

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 8c2fc9efc5f..71e911eeb3b 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -77,7 +77,7 @@ IGNORE_SYMS = ['DEBUG_SECTION_MISMATCH', 'FTRACE_MCOUNT_RECORD', 'GCOV_KERNEL',
                'IS_ENABLED_', 'IS_ENABLED_1', 'IS_ENABLED_2', 'IS_ENABLED_3',
                'SPL_', 'TPL_', 'SPL_FOO', 'TPL_FOO', 'TOOLS_FOO',
                'ACME', 'SPL_ACME', 'TPL_ACME', 'TRACE_BRANCH_PROFILING',
-               'VAL', '_UNDEFINED', 'SPL_BUILD', ]
+               'VAL', '_UNDEFINED', 'SPL_BUILD', 'XPL_BUILD', ]
 
 SPL_PREFIXES = ['SPL_', 'TPL_', 'VPL_', 'TOOLS_']
 
-- 
2.34.1

