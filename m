Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB35EF99F3
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 02:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE8383015;
	Sat, 14 Feb 2026 03:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tz4gsYO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD9A83642; Sat, 14 Feb 2026 03:47:50 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8084980B98
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 03:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-662f91bba0fso2615602eaf.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771037265; x=1771642065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KfMJHxth4U29GJsSiRSYU/lA3HZuUckLJxmV2+cxv7s=;
 b=Tz4gsYO7ZWF24m5PqinX35r+bvAGdHCLbfFR6Kq4+yelMGJokj2k1rKgbT75tAIwry
 +v9yJk1E8a7ZSrz9op2aJGCIXtFGE5AgFXti/DCkv8qBBByOHFV2xkekwQ3DrxZWVToE
 /tZG7ViIvFPQmNfJSiZ2m4LFyKcTUIzL+LEMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771037265; x=1771642065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfMJHxth4U29GJsSiRSYU/lA3HZuUckLJxmV2+cxv7s=;
 b=mQ7Kw+P7YWwoo1NR/GiChsfmBGQkJcoDg3ceIbFl23nO4RyM230/u8l+JG05RMbwxG
 Wkf2NQSguSdMifWlx318Mk4tY1mLLEvhFfHvQQ/UJFEcTgFTFGrwdTWlciI//QAAHm8A
 M4AjJlEeEAIAGfS8dcEmu/y3n7/CfDesov5VS37S1hwsU0PdWFjJ2/66+3LvWuj4Tl6v
 UYLF65Kr6VVKwr2wk0rtm5aXt/D9Q3jbFQu5z2j31ZFxY4Z2TGzDdlBtMTwAyunXZPbZ
 78gXghs7QnJlM2BZ4k60sMrFt2zS0ZjEsW8bgxc8dtzMOH7R/WdeDMeoJyj+3rsm4Qt0
 FoBA==
X-Gm-Message-State: AOJu0YyJRujRPV5i4lqGCgzhoZ+LOFUXHu12XWWTImpDTwmoIjiiUYAh
 GTHI0wo3sLGjQgUiMa/Lo2TI8Eii6kFFRUwpAx8/wddhzg1h/kA8K1a3N7+7emrABRC6rboJTX4
 JLJY=
X-Gm-Gg: AZuq6aK0gHh3F1wmjWBm/TcBIRLDH0GuqumTaVLxcWleJAOx6HXCb0lh5eG/JhqXIRY
 2lAwxSGg8EDvYKN/M9a0c9vhXmj0O7wsC9955F0nnFXbv6HL9ymixkptVVpKoQS9fFokTQTEWd7
 FegVPxXHc4iEVnI4emkKwCyTVQBE6dj3umtz281O3oqk7aGnLYwMEoWIdephN4C7OhxZ2xM7w9I
 Le4w4HFgdvav9Sy6a1dkKEsaxfhK1Kwug9yKrYYFdbyDosDfWACJgN3Hw+Jx0Nt3DsWaiF/FEEG
 X33K8WPc0ka3y0z6WviaVbAaESXYKpWeaUZHLgOLaVIzT7SmmTNBqEdsIogHSyKWklCh+zvYs40
 e/seEWo11/YVrqVvh8rGDlOO0fHGEHad6KDEHQnOnu3W+9FIW3IO6erz7L/P5bkUFbTzHkjdt0F
 Enaknfp8sD9Lj+29uoEH5FwNuagz9n
X-Received: by 2002:a05:6820:807:b0:677:f82a:6258 with SMTP id
 006d021491bc7-678208a4ecdmr1128729eaf.14.1771037265554; 
 Fri, 13 Feb 2026 18:47:45 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40ee06756easm4886948fac.13.2026.02.13.18.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 18:47:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] kbuild: unexport sub_make_done to fix child make invocations
Date: Fri, 13 Feb 2026 19:47:34 -0700
Message-ID: <20260214024736.3726811-1-simon.glass@canonical.com>
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

The exported sub_make_done variable leaks into the environment of all
child processes. When make targets like tcheck spawn independent make
invocations with O=, those child makes inherit sub_make_done=1, skip
the KBUILD_OUTPUT setup and try to build in the source tree.

There is a workaround that resets sub_make_done to 0 for specific test
targets, but this isn't great since it has tolist every target that
spawns independent make invocations.

Instead, unexport sub_make_done once we are in the final make
invocation. The direct sub-make already has the value in its
environment from the export, and no further propagation is needed.
This also allows the per-target workaround to be removed.

Fixes: 27529f1cb02d ("kbuild: skip parsing pre sub-make code for recursion")
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index d38fa5d6aca..f539c6f82f3 100644
--- a/Makefile
+++ b/Makefile
@@ -194,6 +194,10 @@ endif # sub_make_done
 # We process the rest of the Makefile if this is the final invocation of make
 ifeq ($(need-sub-make),)
 
+# Do not propagate sub_make_done to non-submake children (e.g. test scripts
+# that invoke make separately with O= need to process the KBUILD_OUTPUT block)
+unexport sub_make_done
+
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
 # so that IDEs/editors are able to understand relative filenames.
@@ -2738,10 +2742,6 @@ help:
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info see the ./README file'
 
-ifneq ($(filter tests pcheck qcheck tcheck,$(MAKECMDGOALS)),)
-export sub_make_done := 0
-endif
-
 tests check:
 	$(srctree)/test/run
 
-- 
2.43.0

base-commit: eae0ca2125933c3d1742deba723d2cc4b4955ef0
branch: fix-kbuild
