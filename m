Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDA0CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A94C8468A;
	Mon,  4 May 2026 15:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="k6aRCyJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839B584666; Mon,  4 May 2026 15:20:48 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C310F84666
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhs3ht0zhlG;
 Mon,  4 May 2026 15:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900845;
 bh=jQx5wzSKVL4sodbP55s4FKHHYpkU6PXePFItQEC4JtU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k6aRCyJTyh9l3pzJExxyr1+YJChLQVQGOTbS6bZtBU/XVett3nbShRlp85DLRvfxR
 OQ/alJ3lewYKjDN0buqkXpLQeFW4PRYT1UR/R6H5EJu7D9PZIezrZ+fduZ8m6D2WO8
 3hBXNI4oY2OTj4iufBLccLMq5Y+6js/suU60fZ11AFLGEQwEPt7OWP3vxmzXZwAbns
 8Wx7hbTgBsnJyG9OKhlSNlisnZFYyI7IL0Z3I4KA+oXsMcoJUwXu3uKN6M21y5noog
 ImHthjYG3ISWQGCklWh/BPvg4vCLt0djY1BcfZK/wxB1ZVYT5+4nBnyP6JltvfgpoR
 +5AlkEw4c8esA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhr2RlYzCTW; Mon,  4 May 2026 15:20:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:29 +0200
Subject: [PATCH RFC next 02/18] CI: pass clang HOSTCC and CC to pytest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-2-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

test_env_initial_env_file test calls make on the build directory passed
with --build-dir parameter which points at UBOOT_TRAVIS_BUILD_DIR which
is populated with buildman before pytest is run. For "sandbox with clang
test.py" and "sandbox64 with clang test.py" jobs, buildman uses clang-20
toolchain, but pytest isn't configured to use that as well, resulting in
gcc being used with a configuration made with clang-20 toolchain.

Specify the HOSTCC and CC clang make arguments so pytest uses the proper
toolchain, this will be required in a few commits when we'll upgrade to
a newer version of scripts/Makefile.extrawarn which gets rid of checking
whether a clang flag exists (because it's supported by the min clang
version the kernel advertises as being supported) which will be an issue
since GCC for sure doesn't support all clang flags.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..d0ebd9f123b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -288,6 +288,7 @@ sandbox with clang test.py:
     - ${HOST}
   variables:
     TEST_PY_BD: "sandbox"
+    TEST_PY_EXTRA: "--make-args HOSTCC=clang-20 --make-args CC=clang-20"
     OVERRIDE: "-O clang-20"
     # addr2line in Ubuntu 'Noble' and later are broken.
     TEST_PY_TEST_SPEC: "not event_dump"
@@ -313,6 +314,7 @@ sandbox64 with clang test.py:
     - ${HOST}
   variables:
     TEST_PY_BD: "sandbox64"
+    TEST_PY_EXTRA: "--make-args HOSTCC=clang-20 --make-args CC=clang-20"
     OVERRIDE: "-O clang-20"
   <<: *buildman_and_testpy_dfn
 

-- 
2.54.0

