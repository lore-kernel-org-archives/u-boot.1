Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEF2C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8754E80C77;
	Wed, 12 Feb 2025 23:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PBvc/6qY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A4080E88; Wed, 12 Feb 2025 23:23:28 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3E8801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c05d75007cso31010485a.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399005; x=1740003805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e8dcMzZrzp4sjhZUPa9eCyfb97JuZ+NAuio2A+fCkyE=;
 b=PBvc/6qYaqf+3fdAya5P4yEirAiZWWta7n4DZ57NdIQ1iT1TKMztj4r/TNwVKBXe3/
 GxIvAlbE++Q3cGo0W6BLbwQXCp/v+tL+1WdmvvSzpjyaXoDP0avs2a9pPy/6sO5bjTgE
 hSjxW78qR7+cWCi8LIAMWeUxaXK6uzAQubBc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399005; x=1740003805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8dcMzZrzp4sjhZUPa9eCyfb97JuZ+NAuio2A+fCkyE=;
 b=sdQMut46BIMT0Oaw30OSAnu9KoFtsmVHXR590bBUWhKo+8gOUo/WxQb0iscIRwpQ+i
 gWQqX/HYER87X4h0fNrqc+hNKkO3OZyxuD9nM+7MtTIg7A8umhafYbshtxZwrAr9EK9r
 KMx29gXCNWJvBI8rG2vkkEgL4UdcAxhtfLnYKSgmeKYM5PCoWz9u3xUgeau3c/luL9gJ
 P9DqVAa+yI4lpcjvEje9s/zg26u+1WYSno5WymMZXdRoFMsUAkN+0D41hFdymwYivyrw
 CnOaegocZ1/pyRSMXoNWIR17NHAHzAOSByqsYF36aY55wKIeegvb5KuasZaYBGDY/BMx
 h2yg==
X-Gm-Message-State: AOJu0YwE2a+IcRLJsOcyYAlLE07Q+MmtvX3EpeyRifGTyMb9sLpP9LG7
 Yx/6LRsCmHevcuIBn7S7TgltpmAgJuC3lTF7X+XgH6I181CZqbdVQMkcVzDRCmZMbQ9s7vfPEGe
 m
X-Gm-Gg: ASbGncv5IdrSfc40rfmyz4EfX/q7AcqOkDcIAwaeQb2anm3APSVBSXF6pMjudJTyFFp
 3SDRkreP0mhebiww3q7NUczfuGIvydxJleSLRia4+5tqz0n6ei63InXo0IOouPkNtTsAj8J0VeE
 H7+/HbZ8GejHcz2iPKtWVyfYgAgWkRESAg3yp+333fcuFh04vhMdRVl8pRLqRJKd1MIcIeFX3qX
 9PrJxmAFOxRbUt3MPxaUCkR03jvAp05IVyuAMl2/zz4yDH3aMQCLs54fzO4izGgGKcDA2wVreiQ
 hdm7aMWdrMyJMlaBAg==
X-Google-Smtp-Source: AGHT+IGg6LmbFOIkp1hkavjhihryc7FlbDiESFbuMnOqZXDqrSdS64+T/eV7ztZdfQH9C9jBSoXkCw==
X-Received: by 2002:ad4:5c4d:0:b0:6d8:e5f4:b969 with SMTP id
 6a1803df08f44-6e65bf45437mr24928536d6.10.1739399005424; 
 Wed, 12 Feb 2025 14:23:25 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e454983d6dsm61994006d6.79.2025.02.12.14.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] tools/microcode-tool.py: Disable some new pylint warnings
Date: Wed, 12 Feb 2025 16:23:23 -0600
Message-ID: <20250212222323.684394-1-trini@konsulko.com>
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

With a newer pylint it is no longer happy with parser.error('....')
(which will cause the program to exit with an exit status of 2) as
sufficient to ensure we won't reference some variables before
assignment. Disable these warnings here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/microcode-tool.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/microcode-tool.py b/tools/microcode-tool.py
index 24c02c4fca14..9acf14f7915c 100755
--- a/tools/microcode-tool.py
+++ b/tools/microcode-tool.py
@@ -287,8 +287,10 @@ def MicrocodeTool():
         parser.error('You must specify a microcode file (or header files)')
 
     if cmd == 'list':
+        # pylint: disable=locally-disabled, possibly-used-before-assignment
         List(date, microcodes, options.model)
     elif cmd == 'license':
+        # pylint: disable=locally-disabled, possibly-used-before-assignment
         print('\n'.join(license_text))
     elif cmd == 'create':
         if not options.model:
-- 
2.43.0

