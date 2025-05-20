Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B08C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3948682CB8;
	Tue, 20 May 2025 07:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M2xCMSrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC61682BD7; Tue, 20 May 2025 07:22:35 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0074D82BD7
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a35b7e60cbso3268346f8f.1
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718553; x=1748323353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQrSB16BhDCM3PYdSyclKBO+oD+fpgkkI+/nDZCGFTY=;
 b=M2xCMSrUsQTKLP/nYKnk7Hv/5/S5NG+hOdnRtY6uXlEV4yavIk8XB4YWWiK4egMzO6
 sO4G/2UvGUGuvJAyRwhPXNNvt5VozamMlvZf0ia6EH+HSNua5RDgPfKd99pokQuA6XO4
 KfMWdTsQvBPjN54ESVwFXIdLwFjiaj7kCXthbMH2Z0cvkN2MYH6ePUycpg9X73apn4vk
 XIL6swluMTegH4vKkwhzKXtiW3ELVpvovrupUDv5t5IAu5WVzlV6tezRObuYqyXWHxxo
 Wpo9cD+XUOAv2m2wdlitaDWU0ShB4GEK2ATNiHJMON4L51Gyo7qCBlo1jSO+hnzEStRq
 Y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718553; x=1748323353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQrSB16BhDCM3PYdSyclKBO+oD+fpgkkI+/nDZCGFTY=;
 b=S0w60y90fIkUjqnmzG9megyI7hfZ6nay7lNhOBgKyhvmwt79nnuW/fpx6HpAupnLnq
 TWVijrU/wQW8jS1kTP9PKqcnlHcLdm2zwuKs4d1EFlR9l1VEI1oz+gq4i+3xP2pJm+xZ
 vYfwIyUsAPEjjRU8cSX2pQQlkMC48bZemmxkiEiqJl1Sqvqt92DDtTdDTVNKYMxr0bbP
 VooI0vrBrZGgsDMgP1cFF0t5oTPduPwY/Istnyv3TXBR9N8EaFC28sQyMLEmSrsn1EZP
 Zv9jjeeevijCJZOWhoPZe+Ze/6iITu/P9PbwHkMK0qf8IQNnQkfOdFQtGs93+rozuvB3
 H+Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmYvdDu4OvGTi/KXngZ69DVjIJekBanAxUwOUUN93e81Mlvev/jO9Qo5DkTiRw2uG3Qj30CU=@lists.denx.de
X-Gm-Message-State: AOJu0YxjGpT+/NDb8vmq0gf+YzyM15n+hLoLAnURRXrOq6dInLA8rQdp
 Q6AJESu0acwofnyT2gHLe6XXRvICAlExNfJC8ZyzvrsX5Ky8914R9xpGhuVLu1JyTP8=
X-Gm-Gg: ASbGncteNiLYtvD2Pq/Vd0TlsR9ZV02H9D1h49bv0vj5R8CAdz1sl2HB6ismz/0dQBD
 FYmBDwDyJ6EoJkXEmWgMhz6S18XcLRLFTPHKQDqh3iWFx85yRgLmEO8EWjUUdTFi3XaG5O/7vOv
 T+1y76Wp8rhq2NvSEovXkkaO5R4cUqO30DfGqCxIf29usNrN48WiHZH29v54n8yZYmKn3yJPWVT
 jDcW+pt5kphDnts2vZ28BHATvmS+ZfdGMY1Q1aQu4V9XP6fUl1ij3rrPkyOgN1AuIJlL0pl2PD1
 iEJt2AD9mnr3+JNhwRiJOzwXYMSz/BoYIUwCydseUvV9vuOG/S25H13UkBZlubUcM2opGc6f2DU
 =
X-Google-Smtp-Source: AGHT+IH1g9Iv6xMpMGhaFhEm0xlqLn3af2zIFhiIv1QKCCPPXsds4c4ibFRsVd5huCnsX9SDE/BPYQ==
X-Received: by 2002:a5d:64e8:0:b0:3a3:6c7b:d0ce with SMTP id
 ffacd0b85a97d-3a36c7bd389mr6293102f8f.2.1747718553459; 
 Mon, 19 May 2025 22:22:33 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 14/24] kbuild: change if_changed_rule for multi-line recipe
Date: Tue, 20 May 2025 08:21:25 +0300
Message-ID: <20250520052153.307194-15-ilias.apalodimas@linaro.org>
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
commit 3a2429e1faf4 ("kbuild: change if_changed_rule for multi-line recipe")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Kbuild.include | 12 ++++--------
 scripts/Makefile.build | 12 +++++++-----
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 6ef66c451eb1..c0d3440a4b3e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -226,7 +226,7 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)
 
 # printing commands
-cmd = @$(echo-cmd) $(cmd_$(1))
+cmd = @set -e; $(echo-cmd) $(cmd_$(1))
 
 # Add $(obj)/ for paths that are not absolute
 objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
@@ -268,21 +268,17 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Execute the command and also postprocess generated .d dependencies file.
-if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
-	@set -e;                                                             \
-	$(cmd_and_fixdep), @:)
+if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)),$(cmd_and_fixdep),@:)
 
 cmd_and_fixdep =						             \
-	$(echo-cmd) $(cmd_$(1));                                             \
+	$(cmd);							             \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
 	rm -f $(depfile)
 
 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
 # and if so will execute $(rule_foo).
-if_changed_rule = $(if $(strip $(any-prereq) $(arg-check) ),                 \
-	@set -e;                                                             \
-	$(rule_$(1)), @:)
+if_changed_rule = $(if $(strip $(any-prereq) $(arg-check)),$(rule_$(1)),@:)
 
 ###
 # why - tell why a a target got build
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 639091e7b29c..59ff37a53208 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -236,11 +236,13 @@ endif # -record-mcount
 endif
 
 define rule_cc_o_c
-	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
-	$(call cmd_and_fixdep,cc_o_c)					  \
-	$(cmd_modversions)						  \
-	$(cmd_objtool)							  \
-	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
+	$(call cmd,checksrc)
+	$(call cmd_and_fixdep,cc_o_c)
+	$(call cmd,gen_ksymdeps)
+	$(call cmd,checkdoc)
+	$(call cmd,objtool)
+	$(call cmd,modversions_c)
+	$(call cmd,record_mcount)
 endef
 
 define rule_as_o_S
-- 
2.49.0

