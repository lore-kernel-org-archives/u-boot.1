Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC77AC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 09:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DF98056B;
	Fri, 21 Feb 2025 10:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hEdLa63A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26BA80F5C; Fri, 21 Feb 2025 10:59:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA478007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 10:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E240641974
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740131944;
 bh=Z45RB6gMK1nc1lntlpR1rZS1Y5722z0qKGi7iMyCB/g=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hEdLa63A+wI+vBqvAUjKiLqpj2WwKcOR5QiUrvcnXzRIpVmSXK9L7fMf+v/wef4mw
 7XiMpFrXveeQVfsBlP9A0E0fR1Dw0sWX3wt+AwlNHoJy5mVqFaBkFSOPhMqzp7R78/
 6S4dMxdswFxOqNX+kQ71n7w3qBF/hh2ag1koP+tAQLCdKcZLuXiR93oL8llZQakvZT
 N46foEW0kDqwPfRU0GXRWYKpsHA7vV1K+Gelg/ZmWNVXGMJ+6FHRJZYHJnXMK1QWu4
 7nCVc4wZOujGkwe5BKmvyaqmL0sZsc7cmOSIOpVxR5SevZv2PkWXrrICURq8EGbMYB
 NPQ8ibXQBh76Q==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2f438fb6so2302376f8f.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 01:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740131943; x=1740736743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z45RB6gMK1nc1lntlpR1rZS1Y5722z0qKGi7iMyCB/g=;
 b=w8TOCOKbjid/zSCRbNulyWL7q90wGc4e4kVCnAafJxbm+3uImbFmeTna7lUO7pFuYp
 SOmuF0DgOk400QT1ie/XHF3vlalXfaTBU8dsq9zsgCDhn71SLlCV8af0Lr7EEc8ZCieT
 Y+hKvwQDkMuNYQlS+BSt33+zGKROHPKHEdZQn6TjMvqWWGKcl16KodqC3+T6HSO3xWWl
 xfz4nbYkCVhuD384bhOj6W8LcGf+QK9WsPeOUQAHaC+ARc4iA94GYKm9XxXOMKsAIF2i
 QPW/VHSFN0ZF18lsuU0TPKATXNH+8wqGLMoiGwJ55rnejZFUVTFMJ0zVXf7j9vt/9gRs
 JJ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXREecKuA6CqsDkug9+SpdOhQuv4y/dGLIdW58j6qOMACzPo/8T2BNT0BE+RrCNN5cwBlCeHgo=@lists.denx.de
X-Gm-Message-State: AOJu0YwL+t76zWtDpUO0SsIkkAchP19xYHB7n63d7YpJ/XrAqPh8jPtE
 GXWMj1QnVF4/klRGqtwW7LgWyyXuZ/3tfEqQVOXxC70WlU5npom9CJCV6P6/cWXYxpgqNaV8Cl9
 QNl8XwHwsDioCgZ3+341HZEhEjNfhIwdfCCS1NT/GvcewEiciypQfsFZsh3QxSXwLKD0=
X-Gm-Gg: ASbGncuy/emT02SsX8uD1p8G0o4lI2aVWc6kVOp6mu5E8OIIjHXRVu9kJOeUINSYOUJ
 KVnL73fKUYGBIqKQKCDBqjk93Tm7nGsJjlzwYH8kU8CgMJJbxXH9B+4PxcZtDzKJ8mJbEVA19I9
 UouqUKrrcAkusjWQjl4oAh+cF0PJ00eMrGJKmaQC6i7XxMsAFn05yC/LqE2grG6fRh2vB3fVYMZ
 okz2dSCWaI+JLdpF2cLkeWCiJTtUjogwwDYGn8cIYu++mjkpZWsVc7nyRvnseHV/thEywo58ye7
 TrvdrhyuGFESh/CIhQXi1ki3WrvVaqWpOT9foejq3pk6AsMkbBIo0/gnSBuGC43pzDaIldBpimk
 b9boYGf9l1/9rULTe9A==
X-Received: by 2002:a05:6000:120c:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38f6f056b81mr2125952f8f.33.1740131943595; 
 Fri, 21 Feb 2025 01:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2GDGOqh9dwPvfTh7STYagLVeQM57WzrKvS0jQN/CEIo60H2lRZPzS4CrbR9MZGPORIHIs2g==
X-Received: by 2002:a05:6000:120c:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38f6f056b81mr2125934f8f.33.1740131943227; 
 Fri, 21 Feb 2025 01:59:03 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm3287961f8f.27.2025.02.21.01.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 01:59:02 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, H Bell <dmoo_dv@protonmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/4] riscv: dts: add OF_LIST handling to binman.dtsi
Date: Fri, 21 Feb 2025 10:58:53 +0100
Message-ID: <20250221095856.36530-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
References: <20250221095856.36530-1-heinrich.schuchardt@canonical.com>
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

Binman can automatically generate device-tree and configuration entries in
the FIT image based on CONFIG_MULTI_DTB_FIT if the binman node includes the
right sub-nodes.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	Use CONFIG_MULTI_DTB_FIT instead of CONFIG_OF_LIST to avoid
	build failure for QEMU defconfigs.
v2:
	no change
---
 arch/riscv/dts/binman.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..782ef037f7a 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -82,8 +82,9 @@
 					};
 				};
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@fdt-SEQ {
+					fit,operation = "gen-fdt-nodes";
 					description = "NAME";
 					type = "flat_dt";
 					compression = "none";
@@ -94,7 +95,7 @@
 			configurations {
 				default = "conf-1";
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 				@conf-SEQ {
 #else
 				conf-1 {
@@ -115,7 +116,7 @@
 #endif
 #endif /* CONFIG_OPTEE */
 
-#ifndef CONFIG_OF_BOARD
+#if !defined(CONFIG_OF_BOARD) || defined(CONFIG_MULTI_DTB_FIT)
 					fdt = "fdt-SEQ";
 #endif
 				};
-- 
2.47.1

