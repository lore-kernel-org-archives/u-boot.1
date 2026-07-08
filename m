Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B05C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA2E84A1F;
	Wed,  8 Jul 2026 03:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nC4NYMLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B66C8499C; Wed,  8 Jul 2026 03:30:29 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F80084118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9d7464b71so60841a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474226; x=1784079026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UAqohjIi2GhhZ2sbWO/lr7nPLGx1Hl1r6SVwRGiZnuU=;
 b=nC4NYMLTlUMJizZWtCO22BhZ3grwLESxzor/Z+wEv1q/Gyj9uKGJL9qO9aFD2FnL9+
 Q+qG5njCohK0qD6OQAJStc8bHlC3v+pPJXPvZmmgi7w98WOsuaMtoEpH1/jbwMdJ/P66
 zMGzIZQu1Y7+7YfRUKC9/AAw2WIfjqkXCWhIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474226; x=1784079026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UAqohjIi2GhhZ2sbWO/lr7nPLGx1Hl1r6SVwRGiZnuU=;
 b=H+kd2JoLVDQMOVJehlBTAREvvOT8rWyO5zv9QBMHf0b8WkfpKUh6nA2HIunBSkmVak
 HTrGV8c+akGPx8Qx+V59MNyCDjwdHHEUwDUFqP44y5/NXrn46bwbsxz99v19OXk2WhZ8
 65NsHsqRpEFYeLr6zPoyQjhJwqpMnWrX/1NAwiAscUNLBa6xc4OllI2NEYHZtk76igLX
 SM5OCH2csR9GLjzEL+szjUvcA8eFPey9QyD6/CcK4eWjbhenEMcP40CAeUjOYyCG37rv
 kLierCNmyLkMIA6YDP5WUuRIhAA0imIfSzq8dnUH4McgbGKs9MM6nzg+lMHSZHfcKBJu
 dErw==
X-Gm-Message-State: AOJu0Yw1xrvRSK/kjTHLpZbTLHFrMiKerz5KcSqAI93WRvLodgwtKU+5
 Qa/3xQVbhNkZcJ+vNOa/2t/BG06mUT7qVNRMDtT1bLRMiRMWKQ8ffdzTm/YLZjW7arcSjtU1Rf8
 JnrItEL4=
X-Gm-Gg: AfdE7ck0BsVFVJnwBbWU3TV4LX5RXSAAwgkfPaI4UImZX5+flmCKENlnPwc+S7MG781
 waaIypx/ABdu161GoXlQveCISaFGeqzehbGNs3c53aGaLxxis1aybUmT/UECMDRqL2zWsgHtSP+
 L+NzsOj2p39nPhmBfU9tBHCo70K7LQ62UVbCQVnNsm+ZOEf35hTfT5eNU4lypW920XhjPiZOeEO
 SCAYK5tIA6UG54RsVmeuPsrGyRi/3hQ8MU87p4pu3mWmC52XCYS4Ww6LUAYWImOrxsukaX+EZAh
 0f2e34wHi57QsOk7i4ZaYvGxU/I6T3y8GbdidQczHq6I6Kl/111JK1rZTTN6IKQrantvoEMliN1
 QCP/GhaTYPEuLa/7ywIoKm/+hJwsMGnvGf83QQXDrJH/WW5Yk7ty9ldhzfptBh0lWvAUo8NnSS3
 peRflSgHQI/2/9V4H29vFvjImJQflOMjG/BZVWvzDEI8rFASPQcJlLvWBrKhBiRVeOE/g8ppBLc
 iOimKcqnt6JmGS6NB3tfz2d1DJ12QOfl+0dwlHaO2XRK75tI/1rTnCtF2FJKQ==
X-Received: by 2002:a05:6830:83ab:b0:7eb:89e4:8f5c with SMTP id
 46e09a7af769-7ebcfea83dcmr269324a34.14.1783474225705; 
 Tue, 07 Jul 2026 18:30:25 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/7] dts: Correct behavior of OF_OMIT_DTB
Date: Tue,  7 Jul 2026 19:25:13 -0600
Message-ID: <20260708013019.288985-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

When we have enabled CONFIG_OF_OMIT_DTB, we really should then be not
forcing a device tree to be built. This involves two things. First, when
OF_SEPARATE is set, don't say we still need to build dts/dt.dtb. Second,
our init_sp_bss_offset_check check can only cover the non-dtb portion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 56f59c24cf89..bca5a718f2aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,7 +1237,7 @@ INPUTS-$(CONFIG_TPL) += tpl/u-boot-tpl.bin
 INPUTS-$(CONFIG_VPL) += vpl/u-boot-vpl.bin
 
 # Allow omitting the .dtb output if it is not normally used
-INPUTS-$(CONFIG_OF_SEPARATE) += $(if $(CONFIG_OF_OMIT_DTB),dts/dt.dtb,u-boot.dtb)
+INPUTS-$(CONFIG_OF_SEPARATE) += $(if $(CONFIG_OF_OMIT_DTB),,u-boot.dtb)
 ifeq ($(CONFIG_SPL_FRAMEWORK),y)
 INPUTS-$(CONFIG_OF_SEPARATE) += u-boot-dtb.img
 endif
@@ -1614,12 +1614,18 @@ endif
 # The 1/4 margin below is somewhat arbitrary. The likely initial SP usage is
 # so low that the DTB could probably use 90%+ of the available space, for
 # current values of CONFIG_SYS_INIT_SP_BSS_OFFSET at least. However, let's be
-# safe for now and tweak this later if space becomes tight.
+# safe for now and tweak this later if space becomes tight. When we omit the
+# DTB we simply have to have accounted for this when configuring U-Boot.
 # A rejected alternative would be to check that some absolute minimum stack
 # space was available. However, since CONFIG_SYS_INIT_SP_BSS_OFFSET is
 # deliberately build-specific, to take account of build-to-build stack usage
 # differences due to different feature sets, there is no common absolute value
 # to check against.
+ifneq ($(CONFIG_OF_OMIT_DTB),)
+init_sp_bss_offset_check: FORCE
+	space=$(CONFIG_SYS_INIT_SP_BSS_OFFSET) ; \
+	$(subtract_sys_malloc_f_len)
+else
 init_sp_bss_offset_check: u-boot.dtb FORCE
 	@dtb_size=$(shell wc -c u-boot.dtb | awk '{print $$1}') ; \
 	space=$(CONFIG_SYS_INIT_SP_BSS_OFFSET) ; \
@@ -1631,6 +1637,7 @@ init_sp_bss_offset_check: u-boot.dtb FORCE
 		exit 1 ; \
 	fi
 endif
+endif
 
 shell_cmd = { $(call echo-cmd,$(1)) $(cmd_$(1)); }
 
-- 
2.43.0

