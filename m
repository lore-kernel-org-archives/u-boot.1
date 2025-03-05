Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1DC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5D481253;
	Wed,  5 Mar 2025 19:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="faZ1NXkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A2280FE2; Wed,  5 Mar 2025 19:37:15 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8293180BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id 263EAC023C;
 Wed,  5 Mar 2025 19:37:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741199833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOZyrBbxgkQNrtNBg1mEQ51us9kzZgXKyuypO2hXD9M=;
 b=faZ1NXkXhDzxaFXaGm5QbET7r37JCM3/2sqTCHzK+rap8jr5gDmvQEWbWjJNqPaEHKKqFj
 zO7eB+uWSS7kRHN7y1YjcfJ9//YZLHKO/K2Mx28crrFgjYjXw3lGa3LyydXJr6LSNLvMh2
 bNQ/f79sD8vPIxdAKzuAiY8y7RZw38b26tFUKg2RcRpEnShqqaA0gI2mShkEWFe244B82T
 tUZrK4V5XVqMl0I+aYyrgLQAYDPXXV066trxfgLujjeagCvS8zopGR6tZwQUZFOEpsADn7
 Vfrz3u+Z8k0RbAOA0JfjebMCAec6a/ACVkIZSaMBV3PTepznChHq62QGMjongA==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id C27FB200059;
 Wed,  5 Mar 2025 19:37:12 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: Hendrik Donner <hd@os-cillation.de>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB build
Date: Wed,  5 Mar 2025 19:35:43 +0100
Message-ID: <20250305183544.40525-3-hd@os-cillation.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305183544.40525-1-hd@os-cillation.de>
References: <20250305183544.40525-1-hd@os-cillation.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Mar 2025 19:54:15 +0100
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

The CONFIG_*PL_BUILD defines are currently not defined when
preprocessing the dts files, leading to build problems with binman. Set
the defines based on the related CONFIG_*PL values.

Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
Signed-off-by: Hendrik Donner <hd@os-cillation.de>
---
 scripts/Makefile.lib | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 54403040f00..dd2c6363224 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -217,6 +217,16 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__
 
+ifeq ($(CONFIG_SPL),y)
+dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_SPL_BUILD
+endif
+ifeq ($(CONFIG_TPL),y)
+dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_TPL_BUILD
+endif
+ifeq ($(CONFIG_VPL),y)
+dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_VPL_BUILD
+endif
+
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(sort $(foreach m,$(multi-used),\
 		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
-- 
2.43.0

