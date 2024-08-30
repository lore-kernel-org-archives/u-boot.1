Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07260CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BFD889FD;
	Fri, 30 Aug 2024 12:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MrTskOai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6A5888CC; Fri, 30 Aug 2024 12:17:25 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77A0887F3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374b686d62dso129414f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013043; x=1725617843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDVq0/Zv29LqDL7LOh8KnfZqyATDPB5jWwnrFqrVuyw=;
 b=MrTskOaijQxftI9n8H26fhnCTHZxQ/s4fq+CEydRfo4dCyUkv1vHA/DVII9GMsgat7
 ramTlFelyja9dsbjajQYEFYUVO1245WBT0TBHt+QdExLemKFUkMufGC/xKkqUj2MUCCH
 4JJLMRevS3u3SOQkqeXR+FyHLRePuIBYD1qvuICy/sMkFjsnQFnjDVlj6wyAyR6hp9Xa
 LLfr5m8Kz5j8of3H2wPp+CcgMSJGuZCY45N2TyfhJl3b6ZznX1TkdPlV14vKVKNygCfr
 cZPHttj5jaqvFIWrzhrdyZO6DBWpCQ7Vr7mLXiC76jpXzQuss0MMhod9qrfmxzP6kuLQ
 O86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013043; x=1725617843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDVq0/Zv29LqDL7LOh8KnfZqyATDPB5jWwnrFqrVuyw=;
 b=oEu9dF/uDzI3fC3rt4PHREcd3atOjveDpflM7hYXR4DMvGVAVyXpt5WaMvUzp8lxhm
 t0Ys1WO4sc+dWGDgFqkE+I+/GGqV4xSmEEifnBOa+W12zyXI9YWag9a5yAQX6xbMOHWa
 yX6kienVHxstr3+yud70eGA+kuS8YZEkgOC4B5bOSzqan3ZAdpo820Mc1t5Pj5U4BQuv
 2flj5ba6zh1q1cxViUvmxXOLuXZpR/nN5EsXgK4HKBqxPbiggnGbEXbdR+qWzC/Yj6Hy
 5kDRFXF/acghk9YpcVVJ+BWOHq+Q06eJt4Kc+on+UVtY39Ro7cFMa5MWDqBYUen6158J
 dCYA==
X-Gm-Message-State: AOJu0YzVZVz8wh1gPdNOCwVfsposXK2VAwHwjOnxiC81XGJQiAfczcjy
 U/jrIsAV+t2jR4D61d78wlNkU15a9MgEX66Ut4ZdsEwg5qEhGNaVsND6cWAl5WIvDKBOYyexD72
 7PJm6aQ==
X-Google-Smtp-Source: AGHT+IGILDjMSsRsOl1rytb7BnzGE3c/LA72cIFf14WLXNifM+529qoFZ+wU82/XZwWff2nu3dgO4A==
X-Received: by 2002:adf:f84d:0:b0:374:b9d7:5120 with SMTP id
 ffacd0b85a97d-374b9d756a9mr49427f8f.23.1725013042598; 
 Fri, 30 Aug 2024 03:17:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:22 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v2 02/16] buildman/toolchain.py: set CROSS_COMPILE only if
 self.cross is set
Date: Fri, 30 Aug 2024 12:16:45 +0200
Message-Id: <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
or without a full path), optionally prefixed by the toolchain wrapper
defined in ~/.buildman. This is fine when self.cross is not empty, but
it doesn't make sense when it is:
- Either there is no wrapper and we end up with an empty CROSS_COMPILE
which is the same as not defining it (the host compiler will be used),
- Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
which obviously is not a valid compiler, hence an error.

Test case:

 $ sudo apt install ccache
 $ grep -q toolchain-wrapper ~/.buildman || \
     printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
 $ make mrproper
 $ ./tools/buildman/buildman sandbox_noinst
 $ ./tools/buildman/buildman sandbox_noinst
 Building current source for 1 boards (1 thread, 24 jobs per thread)
    sandbox:  +   sandbox_noinst
 +In file included from boot/bootmeth_efi.c:16:
 +include/efi_default_filename.h:20:15: error: operator '==' has no left operand
 +   20 | #if HOST_ARCH == HOST_ARCH_X86_64
 +      |               ^~
 [...]

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 tools/buildman/toolchain.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 324ad0e082..ff987a9eea 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -201,10 +201,10 @@ class Toolchain:
         if self.override_toolchain:
             # We'll use MakeArgs() to provide this
             pass
-        elif full_path:
+        elif full_path and self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
-        else:
+        elif self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
             env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
-- 
2.40.1

