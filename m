Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE5C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:50:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC418885D;
	Sat, 20 Jul 2024 12:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnOMzHg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677FA887FF; Sat, 20 Jul 2024 12:50:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8503E88403
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so12972405e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472603; x=1722077403; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oj9Z7D7IfhuTOKKjwT4Vh7s4xJtjyHS5Rrn6/pwxv0s=;
 b=bnOMzHg2v6Mdl2BVwc7sYtSni1TwKhLCwJDaYFQaYaXEVzTvTIOhCQxK+Qz/Up4yAX
 KefvngDCJY1drl1DTfVh0kDFNbpFgH1dQHjnEYp0j4RyLxBBt9k/PYtt8z0xX1kS6Bes
 Llu6A7z4kpp9rhP/C007kTF+4NrCmM3mwIHjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472603; x=1722077403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oj9Z7D7IfhuTOKKjwT4Vh7s4xJtjyHS5Rrn6/pwxv0s=;
 b=WVoADFraqikjV2PzXB3GUJVCyD2Y/C5vFge0Ze2m70BrEXuLOX47ZuCW/U5VuQDqZO
 e1N88MgQivY3uNPHdwOijzxx6mZfY1tr7OtyY0yPtEvmTItQ2y2LA0IivRKMfdygMNVd
 Tdza01zdh5lbwpcFyicQYlM4z92bPEbu1yEuu2NZvSy5ultfln1YsiuvtsAAXpyCB3xs
 swmQBePwwXBPpBKRoPunwIkWaBHQiCE4xqOwyeXKMYjeZv0g+Yi8PwOLgYMHdrVrkgs4
 EkIIJAMpuJGVOhjiD0uBB5z4F6YliUOrht5jTNYcBxX3AL4ZgQ2w8JklguEHtRTCApCy
 Y9pg==
X-Gm-Message-State: AOJu0YwGxvb3fd3CpHWRUvY9NPHhDhLZO7yF7xOaFyuCf+292VufgYFT
 oR5BWjDgNuL0En649HTiTyk2shkzgdiHLTM2ZnurfoXXZWyz9YxrSjlSi5A6ynOrW4upmcvhqHI
 =
X-Google-Smtp-Source: AGHT+IEJKf+f7mCrX8Hi562YpF3v8cQCCCAmmmihpEaE2VTHEaiSOxUaHHC6tFi8Zl+fLO6ptNdNVg==
X-Received: by 2002:a05:600c:470a:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-427da854e26mr12887245e9.16.1721472602629; 
 Sat, 20 Jul 2024 03:50:02 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/20] binman: Correct an error in the FIT-template example
Date: Sat, 20 Jul 2024 11:49:32 +0100
Message-Id: <20240720104950.2730773-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720104950.2730773-1-sjg@chromium.org>
References: <20240720104950.2730773-1-sjg@chromium.org>
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

The example contains references to an non-existent node. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 872e9746c8c..0cafc36bdcb 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1211,7 +1211,7 @@ Templates provide a simple way to handle this::
 
         spi-image {
             filename = "image-spi.bin";
-            insert-template = <&fit>;
+            insert-template = <&common_part>;
 
             /* things specific to SPI follow */
             footer {
@@ -1224,7 +1224,7 @@ Templates provide a simple way to handle this::
 
         mmc-image {
             filename = "image-mmc.bin";
-            insert-template = <&fit>;
+            insert-template = <&common_part>;
 
             /* things specific to MMC follow */
             footer {
-- 
2.34.1

