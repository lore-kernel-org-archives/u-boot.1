Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBE1C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5442E80F60;
	Sat, 15 Feb 2025 04:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QmRmIkmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2CA980F91; Sat, 15 Feb 2025 04:24:27 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A911780ECC
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d2223fe5a4so1927915ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589864; x=1740194664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU7N8gPexW9J2Bq2wzq101wetOCS+3R91t5Rezj6QWg=;
 b=QmRmIkmC4vBwwHVBLaunVswyIyCRK+FK5LxTsriGIWMW8EoR1ofxFsUqvgWnMn6CIu
 sJ3GSw0KT3G1ZKQPfXFGRLKMQf5ri/UmopPByGJcoTa7MpLxpGDetMP/zvIMeeR/pyse
 Ai6aGUxyK0+gWps/yvmqXRzxl57RT7AW01sOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589864; x=1740194664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PU7N8gPexW9J2Bq2wzq101wetOCS+3R91t5Rezj6QWg=;
 b=MnZTTRnk2ELi+qlz7o9jQo8axfpPyfpX9zJe3xMMb2sSFTMPlF65lJjrm/vH50q2EC
 +j0buevkNvzmQ5KeJ76p1ZgiqjHJYgEbE2LG6gADhJhUqW5uNoHauw5w52NKwT8bT1kH
 FSgyGQg5Rlx9hS/dTJQZbnyVzRccH8XISysFUx13Pu8aGefrwdz271JMyNfb6n5nvWBZ
 u7vAUd+hmko5cwlnU7mD2IAOoX2VO1s50U92ZR3KfooEbc3d7KqwzKT6Fg6/WQewDFxy
 3pixIm9C6aBFsTdtdazkroNjpBLiTMJCZAKXvwfIacWvNeNrmYngwPKd+98PyIewObPD
 AkZg==
X-Gm-Message-State: AOJu0Yz7uw1vQ5We6b1iP/TFmd8x5rOXFs4osahxg+2KHYZWJ+ZgNP+f
 RjOXNnouwPM/xTQUumA/sTJAefQwLPLH1w3GeT7SRFyCKc07PsVdnP1EhGfVagVOnwWF7XIlg6k
 =
X-Gm-Gg: ASbGncuqhpPdH4JUHWXXrtB4tVXak8eyxcvjD1KLHyM6gALxvk+QVJEbeXNnlPIq9EC
 evn3d1+z/hTmGiwTG5ZmbyLt6x1pjwR3ok9XN/wzeMwGyYf2JVJ+Kvj53pdzECStZtEwP3PHGAr
 Fo99EgB1qM4or7WwzGT6KauoL6S0ixEhaoI4p6A151c+V+36+1V8s2GiP/GzXW3NxSQa3IGzDZO
 2K6LQzXj1beV0OzMcxXS+S1Ly+8BCvgoTVr6BR61HxjWWtaBXwsNV92nmxu5Kfz+m+UuDTO+/Uq
 bWf1FBffUo4Fa1a8B+JMJJRtPOrwu/TiEJJgOsOnDiNEFuYn7CJx
X-Google-Smtp-Source: AGHT+IHK7DNjgL7ISqERV/J78kN3cPh4qo7nLDA41/RCy7ogPfV+3Dye6MTZJQfJLN3H7zLwFa9x8g==
X-Received: by 2002:a05:6e02:470e:b0:3d1:5f26:121 with SMTP id
 e9e14a558f8ab-3d18cd1682amr70273135ab.9.1739589863846; 
 Fri, 14 Feb 2025 19:24:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 27/29] efi: arm: Use EFI flags for all compilation with the
 app
Date: Fri, 14 Feb 2025 20:22:48 -0700
Message-ID: <20250215032254.4121030-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

As opposed to the payload, which is built normally with just an EFI
stub, the app is build homogenously using EFI flags. Update
PLATFORM_CPPFLAGS to enable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/armv8/config.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 1ee31680106..0316af306c4 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -21,3 +21,7 @@ LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
 
 CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
+
+ifeq ($(CONFIG_EFI_APP),y)
+PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
+endif
-- 
2.43.0

