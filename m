Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5127C46CD2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 22:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE176879A8;
	Mon, 22 Jan 2024 23:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ovXwqd6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A07879A8; Mon, 22 Jan 2024 23:39:25 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE4C87729
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 23:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dbedb1ee3e4so3262336276.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705963161; x=1706567961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8h242WJpIHoqpRaEB3lvJRrHk2ap0mteIeoUCdCpTJs=;
 b=ovXwqd6DtHUK29+WcBK08q5yKSXwGTv76MfnL/isshp6V22Lpi17E53I+9Z9vB3WWq
 QPtTRxxQ43Tl4w957tcDtRtU5lpmSLSzW0zhCaKbpEJufRC95Tc7egsEeH2xzo5Ti214
 nOJyKIUNtJr272kh8Vz6y7c3rmQiChsXHY3Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705963161; x=1706567961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8h242WJpIHoqpRaEB3lvJRrHk2ap0mteIeoUCdCpTJs=;
 b=TxZxdQcn7G9IW5WWCgVrtG2i2fUd9ps9cxMINQc5KdFsfmiCVB7vVig3Xce19DyJes
 v0Tb0RRVUVgGMHvGSd0z5zHqZvp8wIHup3GJeAjzD6iAbnT7z1WImi7Q7s8OG4dbxxpf
 MWYJS0prRXV7UJjQPBguXlwQlEeGbF7yfv3dFLam1zsTsx59R3a1gWhSbgRy43Vpoaw+
 nG+CGHUSjcxsSqk4d+79/md9MBIXfim/uBp8r4Qj4BKtYuTNRMaeHTzdC1lMTDMGzJv3
 0lsrysPmKrVcIk8iQZTVEPIsUbVyWTBd0RIexSCNFJMiVanzz02kQGb25QAEuTLtBSDB
 Zfww==
X-Gm-Message-State: AOJu0Ywraffn0lUP2yraPXPwWjhC6v43yqnUNIPFIvRzGXzqvw1Qx8yL
 nXTrSHzkDhf/r4CSWtwCfrcWSSHAkLe9eF+rlf6eqz4AiHflsnenckva+N5svL+7qYNXezilowQ
 W
X-Google-Smtp-Source: AGHT+IEEGvhA3m90bNKEmnA0LyX6ynqdKdlcA4pp1FpiAgSi5hrwLSAl4riuB4Du2xMtnZ/ZyBHiTA==
X-Received: by 2002:a5b:8ca:0:b0:dc2:4cf0:e7cf with SMTP id
 w10-20020a5b08ca000000b00dc24cf0e7cfmr2807077ybq.64.1705963161572; 
 Mon, 22 Jan 2024 14:39:21 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5b0bd2000000b00dc255105656sm1773243ybr.4.2024.01.22.14.39.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 14:39:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 01/16] kbuild: Allow for CONFIG_SYS_CONFIG_NAME to be unset
Date: Mon, 22 Jan 2024 17:39:05 -0500
Message-Id: <20240122223920.3630168-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

It is possible to have a platform which does not require a board.h file
to build, but today we need an empty one for our generated config.h file
to be valid. Allow for omitting this file if CONFIG_SYS_CONFIG_NAME is
not set.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 scripts/Makefile.autoconf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index 0ade91642ae3..8208ffe22744 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -113,7 +113,7 @@ vpl/include/autoconf.mk: vpl/u-boot.cfg
 define filechk_config_h
 	(echo "/* Automatically generated - do not edit */";		\
 	echo \#define CFG_BOARDDIR board/$(if $(VENDOR),$(VENDOR)/)$(BOARD);\
-	echo \#include \<configs/$(CONFIG_SYS_CONFIG_NAME).h\>;		\
+	$(if $(CONFIG_SYS_CONFIG_NAME),echo \#include \<configs/$(CONFIG_SYS_CONFIG_NAME).h\> ;) \
 	echo \#include \<asm/config.h\>;				\
 	echo \#include \<linux/kconfig.h\>;				\
 	echo \#include \<config_fallbacks.h\>;)
-- 
2.34.1

