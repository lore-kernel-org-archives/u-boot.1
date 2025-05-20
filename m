Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DE5C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F8B582C30;
	Tue, 20 May 2025 07:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iufjw8Lk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B99F182BD7; Tue, 20 May 2025 07:22:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFBBA82BF2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a36e090102so1046248f8f.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718534; x=1748323334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hd1nfxYzgsiXWY0fAunb5HTMFrTCLpis7HmBV1NZUc=;
 b=iufjw8Lk3k8HV5ZvGF0saYey1qocxxbDG8rhj0BAYTFgWOX14MgUQosHg3zEbvcPgb
 f3B4c82HUtDV/LF0r7MZXRTvEGElrFqgmNJy5QBDlOQfjz2jfSvw4fPSi8mc+W2pfVnC
 /mY87fNRpFJjNdzwVd5ndVKzDhohA3PaEdkHGipnBhGTZTaU/WK6WcNdfBrnkT6GISs4
 kk8VI7AYBftrlW4/6lViFpOFr/umKLyCE2MAsiqjNJBhBaius848YAs4chCGqo6OO3GC
 2P8x5Ka/tTld6eBnJGvakxfAHw8PXa7djOuCroRR0559d6PcnWwSDgciKyRfpH+D+yM1
 I/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718534; x=1748323334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hd1nfxYzgsiXWY0fAunb5HTMFrTCLpis7HmBV1NZUc=;
 b=BLXchKapVXOweWwTsCBtoBk3bMWTO9O2M8CfGgpDVXwhrdHLah/RYqjZI8eHNVH75X
 32Fluth6nz6HoZOGF5PyufQh8TrAiFzGgEodDEn0PUxo1fPlGOYVp2UJD7YqkvxMscT6
 Byaeku5V/t2O//jSJn5p41Xvq3qPrLo5Qq5jDEie4AvAdxhjJ41iQLXWTphZFOtx/NSC
 Ph1Nfa9tXNHEdnIvwG7fFeakljCJRiyMUcmh40uUnR8ZkHflV19THwDm86/qcLYvMMCm
 WvOGZKP7e1qGQJ3tBeBxgRUDr5dR2IVWaxqUq5QpmrHqrovCURerV0X6PElSyvLr20IE
 0RgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbm15JieX3q/7c2Fr+OCVZqg7h35LyRmehC35ihDR+j/oRSEnJAdIQyseJLvrt4GQaHF/v6Tc=@lists.denx.de
X-Gm-Message-State: AOJu0YyKvQmXxtw1Zb/FitWjOhooYa94Fa30N7wvQKWXDEVKP60mMagx
 7QoTkkoL9uPU55muLiFkvAGy1ING4e/rQ0oLlP3QYWuMNYcsEbckoJLXsjweGwU29rs=
X-Gm-Gg: ASbGnctbzj84eYpnor2CnfSZL2cGOIqHjxzUqk4q6Z6nEQUodUaWS4n3y6seshvF4Jb
 EBnMGnfM/K/i0prIUSanrQNCY9gwVZJZltgaH/V4y8PfhNffcury00i2vpzCehM0DFWOElcrODp
 vAnNlNZlpd418EhD31lhA7D19zHC79wbvKcsTgda58/4XVa4NZVtJyg7ibgMUfP75T+sslGHVLj
 dvo2WPl1zfjpXOxKsORP5QgeCw/Wve12lz6IuTykMlueIVLz8IWK7zwUMadIiyOWYbF7B8e5JXY
 Tk1XythStj7oI442a6KuGhii1XGlC05ynSRfs1tdhJs4N+NAvf66/QrlI++/Rn30z/AaMOzugAY
 =
X-Google-Smtp-Source: AGHT+IGolyYlm7LPbRMYOuT5i7//ORKZsUQq4TbtbTVLiBP9AUyLx7aekK/RY06x9oYF6WOtEXzTQw==
X-Received: by 2002:a05:6000:2011:b0:3a3:6f1a:b8f9 with SMTP id
 ffacd0b85a97d-3a36f1aba52mr5132864f8f.15.1747718534265; 
 Mon, 19 May 2025 22:22:14 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 u-boot@lists.denx.de
Subject: [PATCH 06/24] kbuild: skip 'addtree' and 'flags' magic for external
 module build
Date: Tue, 20 May 2025 08:21:17 +0300
Message-ID: <20250520052153.307194-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Backport from kernel
commit 58156ba4468f ("kbuild: skip 'addtree' and 'flags' magic for external module build")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.host |  6 ++++--
 scripts/Makefile.lib  | 10 +++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 7624304e3e9d..bd5ed4c63b7f 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -72,13 +72,15 @@ _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
 _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
                  $(HOSTCXXFLAGS_$(basetarget).o)
 
-ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
 __hostcxx_flags	= $(_hostcxx_flags)
-else
+
+ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_SRC),)
 __hostc_flags	= -I$(obj) $(call flags,_hostc_flags)
 __hostcxx_flags	= -I$(obj) $(call flags,_hostcxx_flags)
 endif
+endif
 
 hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
 hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7690cc61f9a1..f1a78886e84f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -143,15 +143,14 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_KASAN))
 endif
 
-# If building the kernel in a separate objtree expand all occurrences
-# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
-
-ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
 __a_flags	= $(_a_flags)
 __cpp_flags     = $(_cpp_flags)
-else
 
+# If building the kernel in a separate objtree expand all occurrences
+# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
+ifeq ($(KBUILD_EXTMOD),)
+ifneq ($(KBUILD_SRC),)
 # -I$(obj) locates generated .h files
 # $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
 #   and locates generated .h files
@@ -161,6 +160,7 @@ __c_flags	= $(if $(obj),$(call addtree,-I$(src)) -I$(obj)) \
 __a_flags	= $(call flags,_a_flags)
 __cpp_flags     = $(call flags,_cpp_flags)
 endif
+endif
 
 # Modified for U-Boot: LINUXINCLUDE -> UBOOTINCLUDE
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
-- 
2.49.0

