Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74FC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35EE889CE;
	Wed, 24 Jul 2024 17:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AjIwrlxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E5088962; Wed, 24 Jul 2024 17:09:49 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2733288996
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3993f5d75bbso21762165ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833786; x=1722438586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTib9NQaiYSOn17qwhX8cOmik/fHf53Qcmt0o4OVsKI=;
 b=AjIwrlxgEnB4oZ3+pONTyqocMPs8weTqMQ3rEjvPTlM6DSJqkR0O66F3FRGBFcqI8E
 I9CqqJcyOiZHFbGJ3Gu/SddlpAdIejF1h6r43/BX2glLdsWpUeaSgWaKVn3kg4A5ELmI
 qITaFD0lircs6UuurQDXMOuBEbWaX8kguAn/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833786; x=1722438586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTib9NQaiYSOn17qwhX8cOmik/fHf53Qcmt0o4OVsKI=;
 b=fFbq9yPF8LXhauFilNe2gOJ0385DPTE1u1OohnIin6OJkcipiSTzRrOopS7uUb6FM3
 BddOiUnI3x8Fnp1y9hhcxjpIpi6p2Cm+MWJ5Qy4Y7zREAGK9YNxu0Lb0xsBXmUvqcDI2
 RFjw+dha9D8net6c149xu83ppu+uMF8NQ8VHLNhNhhFf1MlgcAfbJwbk02pS/USAz7+W
 Xul/39ljngYsZkq3HvaVrZmt09y9edRxKf6s+8TlCAinfC1WWl2E7t0Ux5fDeiFRUqkh
 QIBBlrFGNhM4z4PCaW7AGH4xRELygmT8EzVBmA/0vT7ZmrVLuqtz+rKs/6P1g5pZpcDg
 Y/LA==
X-Gm-Message-State: AOJu0YxYNRTEKTDmhwRG3Go8k34buco+Li2XuFXCccOaaa5x/3h+lPEc
 OsOsiKC8PGAfFT4bozE+HqKj81IX46XUT0ktkNuyy3LRNHrwVu/A6B4nV9vnyhCohmoVrrW6UmI
 =
X-Google-Smtp-Source: AGHT+IHBr3HAQJeJSzCRJTiMzMXNCAoZ3K4IZDafdFdSiuRgGiG82HSgzKKOz7rCQwwPaJ8P7sYaMg==
X-Received: by 2002:a92:c542:0:b0:383:290e:6937 with SMTP id
 e9e14a558f8ab-398e51906famr183796735ab.11.1721833785706; 
 Wed, 24 Jul 2024 08:09:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 11/35] global_data: Drop fb_base
Date: Wed, 24 Jul 2024 09:08:58 -0600
Message-Id: <20240724150922.2343249-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This value mirrors information recorded by driver model video drivers,
so can be removed to save space. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 970053892e1..af568e99f47 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -63,12 +63,6 @@ struct global_data {
 	 * @mem_clk: memory clock rate in Hz
 	 */
 	unsigned long mem_clk;
-#if CONFIG_IS_ENABLED(VIDEO)
-	/**
-	 * @fb_base: base address of frame buffer memory
-	 */
-	unsigned long fb_base;
-#endif
 #if defined(CONFIG_POST)
 	/**
 	 * @post_log_word: active POST tests
-- 
2.34.1

