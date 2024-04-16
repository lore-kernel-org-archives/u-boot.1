Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBDDC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B748E88433;
	Tue, 16 Apr 2024 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SWfDexgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8549788437; Tue, 16 Apr 2024 21:01:58 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A652A8843C
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2348a5d1584so1213100fac.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294112; x=1713898912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkVo32EQxAACzJvJ4Tf4naBa7lbUGMPGg0IdUPYK6rw=;
 b=SWfDexgm+nR8nY7r6q/muM4DPPFev8b4II9cs/NhErl1gAVJj1N1hEK0VKAvPCy3TE
 OT75Jd7eD4byTbWhZ7satALP3gURpbPkIRXQ0BRl5Xg+jS/8ArA3cRRrc0vBnOkLmn1N
 lvIcIaesR94e3iRBqqfAGLbAAFAwSz70qe3z3PlMRCe9A9ElT21XqtKPnmg1v3nHHc/0
 VQYr3NG2lIOpYdVd3qtMCEYkGWSTdE0OMciPFaR1E9NFk/PCkb5BapANjj9AmVL99AER
 RsQ1IPwriaLR3a8mqzx2p72FaTLfZavi5nioWJLF0ICmiCd/we+fzzty3WvmJWyfTmRG
 nOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294112; x=1713898912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qkVo32EQxAACzJvJ4Tf4naBa7lbUGMPGg0IdUPYK6rw=;
 b=wuI43vsnH3vK8G3TDwxZw9CNsBXkQ1Qkh4U1xo+YZgCAFPoD+fuwGAJAmoNuscNiNh
 JBcGLyltq8+yT6BHWVd1cKlyL70TAau8YAKUY+/8aLHhGF+BWSw6RU7cC46C5Je40ouc
 KgP6W89oGNCSBIn+M0DiLHJYW06RF8JxF24dFdjfchORAc559UNAD+Mn8DInAn0aZVOW
 Zd7JTC0xkSnKOiIXUPoGCh7/wJBzzYJ08O0c2EDD3opVIFH5ssqYixAeQBDPdkkTdrh+
 KGTAv5JVwGQW0qU6/0QWA2vOPO1eZBdrEebWJO/K7CxS3Y01U437Iqd3I6mg2xzFBpIQ
 52Zg==
X-Gm-Message-State: AOJu0Yw1wtq4Xm0y8+nWGvMUVr/akbT9WZ6JC9SFGmglf5mj757B37iS
 BrqWJKhXIcTuvhdyjQqJkWVwOH3trccobstntMJpwY6bMQFhoMCKfDaVKtFuZLpT+gNS7FP0ZMh
 2
X-Google-Smtp-Source: AGHT+IEyyb+1O0ISBF8JTHVSZaeZuKvsUb7uPk7in6IYi5+cE3jSK/LYc4zzxOIc46ZS1mOBlolL5A==
X-Received: by 2002:a05:6870:4341:b0:22e:c6b2:84aa with SMTP id
 x1-20020a056870434100b0022ec6b284aamr16372673oah.27.1713294112236; 
 Tue, 16 Apr 2024 12:01:52 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:51 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 10/23] makefile: add mbedtls include directories
Date: Tue, 16 Apr 2024 12:00:06 -0700
Message-Id: <20240416190019.81016-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Add the mbedtls include directories into the build system.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 7321fe1499..80db1dfd8e 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(KBUILD_SRC), \
+		$(if $(CONFIG_MBEDTLS_LIB), \
+			"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+			-I$(srctree)/lib/mbedtls \
+			-I$(srctree)/lib/mbedtls/port \
+			-I$(srctree)/lib/mbedtls/external/mbedtls/include)) \
 	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
@@ -840,6 +846,13 @@ UBOOTINCLUDE    := \
 
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
+ifeq ($(CONFIG_MBEDTLS_LIB),y)
+PLATFORM_CPPFLAGS += "-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+			-I$(srctree)/lib/mbedtls \
+			-I$(srctree)/lib/mbedtls/port \
+			-I$(srctree)/lib/mbedtls/external/mbedtls/include
+endif
+
 # FIX ME
 cpp_flags := $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAGS) $(UBOOTINCLUDE) \
 							$(NOSTDINC_FLAGS)
-- 
2.25.1

