Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799B6CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53DE88EA3;
	Mon, 30 Sep 2024 03:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CEj/CQH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD67B88EA7; Mon, 30 Sep 2024 03:50:35 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DB088E89
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a275a1562eso13997115ab.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661031; x=1728265831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSy4qQkYCZY4Vh2qcem7EZ9xRKGgNjQkskIBT2gqlws=;
 b=CEj/CQH2F/vpdy2126vKvsRwdeAeh7qu0ZaYggwSTwPEhk1dETCi/r0vGga1pBnDf0
 wqhSUcUNzw1j3AtLVRT/weqqMGw2kofgmORlXZkScR/9SLOms7IpLXLB/zS9L+1LcdDN
 dADskn45st0Rr0CXzw55/UabaXNyc3PPj3T48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661031; x=1728265831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSy4qQkYCZY4Vh2qcem7EZ9xRKGgNjQkskIBT2gqlws=;
 b=HVZfMzaWJ0BppCyki8Mv0RWblzXlDebQ8nKfHu1QDNBu5Ic21nHa7hbJQoMtyVs03A
 OAydNYE8gQ2TUgA9/ohffm78zYocnEVJPnMTfV+3gZRtXD3IJD332u0/BRLmoRidbTgz
 FE+vjyBXpFJj8HCkSH0eU4ubMjc5cVqZm2olqn/h9bs6IBcnUpSsa61+pTiUTda5XdK5
 Tjx9An75imG+jHJox/46dtLUMDGjKm3RfDsoaoGdOdbr+9i7AHSaGSUkfGNGma3SEPBU
 y1VT/4ichpFCy+gWHbFzW1lemV/kr7Oz0vdHnRJ+nX03LSJ3nD85WxMTDcXS/j6noJA6
 f9eg==
X-Gm-Message-State: AOJu0YzSSdUWeC/zHobB8AVpAQY+0NkuXgFDylpKln+US16EMxqE2cbl
 Jj+A95PnJqpB7St+LgWXW5uT9e1RkqgAgIvhN0m2oYBjumCalpBSh5i7dSN3u8oJXPg7DSmhmpV
 n5A==
X-Google-Smtp-Source: AGHT+IH2fbmFhlZyJPAXATRL8+fe5MX7MjaOfoCuOa4YDIaLUn5zS9Xzn/LUdfa5QaxLKtGsWmv7wQ==
X-Received: by 2002:a05:6e02:1c89:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a3445ec40fmr86445855ab.1.1727661031036; 
 Sun, 29 Sep 2024 18:50:31 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 20/33] README: Drop SoC-specific comment about SPL
Date: Sun, 29 Sep 2024 19:49:43 -0600
Message-Id: <20240930014956.1434060-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

This should not be in the generic README file, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Move to earlier in the series

 README | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/README b/README
index c7ee06a21dd..78d91a2f62d 100644
--- a/README
+++ b/README
@@ -213,15 +213,7 @@ board_init_r():
 		there.
 
 	SPL-specific notes:
-	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined and
-		CONFIG_SYS_FSL_HAS_CCI400
-
-		Defined For SoC that has cache coherent interconnect
-		CCN-400
-
-		CONFIG_SYS_FSL_HAS_CCN504
-
-		Defined for SoC that has cache coherent interconnect CCN-504
+	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
 
 The following options need to be configured:
 
-- 
2.34.1

