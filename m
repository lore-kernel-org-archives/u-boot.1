Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67813C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B068350A;
	Mon, 11 Aug 2025 07:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQ6J1e8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A077832BC; Mon, 11 Aug 2025 01:38:27 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748AF832EA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso2647740f8f.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869104; x=1755473904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5obZvD4Wp2zCXU5IGxpdHxprumgbWrovW0VBw6fTs+U=;
 b=nQ6J1e8YIRYjchEFkTvPiSyFzzIfJmMQZTnqDT8KeOPh0RE/HHk9m2Xm2LdcAvSfZR
 LGigmc9hkVsVmJwE+zb6+m1mwe31Xidotjd8KJanC0YlSIWPAJZxtgoj1YtkUAMcnExY
 ev7FkJDQBIatE/SbGJk/EspCIhhwC8AfRIHO/eyAmmiV2RSo8jHH0sHonv0IKk4KAfmG
 O+SDvN/OeC/+ZzQUJ+JRV84oNLZ7xRZeOH/Azvmd1HztLFB/t1331vPKbzh31k94dUdA
 zw8m43JfoMTrme2Dns/BYdyJP+QctXurBW6STpwOOkfXr5aalpntILTKi0lS+Lulnk0g
 40cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869104; x=1755473904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5obZvD4Wp2zCXU5IGxpdHxprumgbWrovW0VBw6fTs+U=;
 b=eoXzKdjLNi7A19DeLPKex7WG+WLJhGm7y/EDCBQ3CTM1GRwyJ4eHWDzvWpEPVd7K7N
 dbjZBncKwQPOOmQuns6ph3VvfR3pfRudZKqw+9TzubmRHuPgVu3EASssC8eclwyvAtmV
 A1McWypaInzkZ5PkAW3TAFupuUdh2LY69BmwrFAEZFMSA7ua+49B282Vv4T0jHo96Aw4
 qaO+qna+J3sujAlkRZhNDE3onzf4bKR7HRSS9xXUaNqY2l5BMkui10H4NIL+bg1iu4yV
 EXi7LAOUlgLlLJ086jHWTbcpc1ZAD+NGbQuJo9byibf/u4I9NbYuWAlpPF7z4NmiNzfj
 7eWg==
X-Gm-Message-State: AOJu0YxSi+rkkgXLtcwgiJ72NeBibqQJIWVVlEb5SaJ4u9fmPPbVrOt0
 KNqn4UmQRJfuOik8h1OsI5Dhpg1njXMIRNLpMPqbhVOecaHjNvqO8uLJQUK5Xg==
X-Gm-Gg: ASbGncvI5lbMI6LDmoZ6jaf23sWYZkrAgYpz7JzhYImml5WF7XYN4nCB8nQISDkOFLV
 BKmVSu9YMIYtH6LhY8tKnQbv1hwLlTr3SgpMe9fz2bBY37/ICsYUsCMg6M6oqpURYEy1FNUZnU7
 ApKJXRWfg0ft20GnqB4nIzyiayEUKKVXTk4Y/Hz9Is3GIuZZ2Z84vNac4SF/D4Ve7xwCLe0VDwb
 hJPuVqn08dt3e39wz6DQA8ARLi6Q02DmA/Pex5pWLrxAW3us07bL2BwEIAZrz0bgIK3BGamGZDw
 B+ik7zO1mCVirw6QTtJpxZq9CY3vBSO7Lud0WD/vD84BaSHAZOPdgnYimY1ISJ5EaL5cv8NKVWO
 laQk3ONHp+cOcElRvUND5PUv9GW9MkwuwlZo=
X-Google-Smtp-Source: AGHT+IHLlQmwdwFyndfBC1SKsr4JP9CFJfyaV3cM95Sm3cLY8VpZGLUIRVV9aQ4hgyzmXgWQoeeQMg==
X-Received: by 2002:a05:6000:250e:b0:3b7:8ca6:bc15 with SMTP id
 ffacd0b85a97d-3b8f97f5ccfmr12030959f8f.29.1754869104258; 
 Sun, 10 Aug 2025 16:38:24 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:24 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 05/10] doc: Ensure consistency of "buildman" (in the middle of
 a sentence) and "Buildman" (at the beggining of a sentence) in
 tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:36 +0100
Message-ID: <20250810233742.51902-6-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

This pattern was prevalent (although not intirely) in the existing text.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 48938044520..d5d22732088 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -119,7 +119,7 @@ them later using -se. Note that buildman will assume that the source has
 changed, and will build all specified boards in this case.
 
 Buildman is optimised for building many commits at once, for many boards.
-On multi-core machines, Buildman is fast because it uses most of the
+On multi-core machines, buildman is fast because it uses most of the
 available CPU power. When it gets to the end, or if you are building just
 a few commits or boards, it will be pretty slow. As a tip, if you don't
 plan to use your machine for anything else, you can use -T to increase the
@@ -1021,7 +1021,7 @@ cycle through various different configurations, one per board built by the
 thread. Variations in the configuration will force a rebuild of affected source
 files when a thread switches between boards. Ideally, such buildman-induced
 rebuilds would not happen, thus allowing the build to operate as efficiently as
-the build system and source changes allow. buildman's -P flag may be used to
+the build system and source changes allow. Buildman's -P flag may be used to
 enable this; -P causes each board to be built in a separate (board-specific)
 directory, thus avoiding any buildman-induced configuration changes in any
 build directory.
@@ -1130,10 +1130,10 @@ these when present in defconfig files and handle the resuiting Kconfig
 correctly. Thus it is possible to build a board which has a ``#include`` in the
 defconfig file.
 
-For now, Buildman simply includes the files to produce a single output file,
+For now, buildman simply includes the files to produce a single output file,
 using the C preprocessor. It does not call the ``merge_config.sh`` script. The
 redefined/redundant logic in that script could fairly easily be repeated in
-Buildman, to detect potential problems. For now it is not clear that this is
+buildman, to detect potential problems. For now it is not clear that this is
 useful.
 
 To specify the C preprocessor to use, set the ``CPP`` environment variable. The
@@ -1144,7 +1144,7 @@ like::
 
     make qemu_riscv64_defconfig acpi.config
 
-This is partly because there is no way for Buildman to know which fragments are
+This is partly because there is no way for buildman to know which fragments are
 valid on which boards.
 
 Building with clang
@@ -1301,7 +1301,7 @@ with -E, e.g. the migration warnings::
    ...
    ====================================================
 
-When doing builds, Buildman's return code will reflect the overall result::
+When doing builds, buildman's return code will reflect the overall result::
 
     0 (success)     No errors or warnings found
     100             Errors found
-- 
2.48.1

