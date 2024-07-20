Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD1C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D91E288C35;
	Sat, 20 Jul 2024 12:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8pPl7XL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5EF886F9; Sat, 20 Jul 2024 12:50:09 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91EA887DB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so13066135e9.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472607; x=1722077407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5E6k3TeZZrlIyJ3gIf10eDnmMZczp4PKqwvDqSToLE=;
 b=B8pPl7XLhqbZRYXOwiIIZUwhRIBPTMMs5vlnuvu8Qdifr2AchNH8mK+lE5a5BUbxEM
 z2XYVF6fhCOj5EB3CPRK14JiZDUCyBkx5CN9julIO6kz7Jb+EZKq9KitxGClj9Z7exxE
 Ajyx3nKPvUiSOorxVyXa2Lrn22omJn3s859Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472607; x=1722077407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5E6k3TeZZrlIyJ3gIf10eDnmMZczp4PKqwvDqSToLE=;
 b=jat828zZcisdAZfZ2Ataci/QOhz9/CQsby4qF0b+ycbzRiC3HcXwg4gYYHxfjOZbMC
 8E4QvfovStqR0xMTaqB3REhO1iXNzvrn4CvopgCDP/P/gaq0EUmSyudAbzY5nxzul7wi
 OKkBG4xwm7xHjgF6Tynm5p5DtaIFzAkIOpSTxu35w8aRpm1yUvWs1vW/qbDNBwFo3Pvj
 roO77hnmE8qsea2XGZP8A1zV7jncCHGG6I2yrBOAiRO1o8YiryYDJlsRSTBXFF0ZuV7K
 Wbd9nnQYBxXBNvlVA15OiwL+qkAblkxiL2IKUHJpNiGfBStLBBC1Go6lcxAyE3gi0ZQp
 96Bg==
X-Gm-Message-State: AOJu0Yz/GW0Xx6KffX8JJcvmC8edbipU9MxgmlI0wF7DPWxq8w6pBNhI
 5oAY+dMnYxNcHMwRUtUJu7x/CglmiEAfOrSKLwS+AfZUEJxeP8kKBFXKrOVQ5u/4iYmEwNhyUyM
 =
X-Google-Smtp-Source: AGHT+IGdH2qWRVn6cahW0cWeS/eQ0Kl9Rj0afGny1VxBYorxL5t1yaR1ufa3+e5tE6r7qgHDhH7Fng==
X-Received: by 2002:a05:600c:470e:b0:424:8dbe:817d with SMTP id
 5b1f17b1804b1-427d2a95525mr51811605e9.10.1721472607079; 
 Sat, 20 Jul 2024 03:50:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/20] binman: Write the compressed output to a file
Date: Sat, 20 Jul 2024 11:49:37 +0100
Message-Id: <20240720104950.2730773-8-sjg@chromium.org>
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

When an entry is compressed, write the compressed contents to a file so
that it is possible to see what was produced. This aids debugging with
new images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 219d5dcecab..752c584c9a3 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -1199,6 +1199,9 @@ features to produce new behaviours.
             self.uncomp_size = len(indata)
             if self.comp_bintool.is_present():
                 data = self.comp_bintool.compress(indata)
+                uniq = self.GetUniqueName()
+                fname = tools.get_output_filename(f'comp.{uniq}')
+                tools.write_file(fname, data)
             else:
                 self.record_missing_bintool(self.comp_bintool)
                 data = tools.get_bytes(0, 1024)
-- 
2.34.1

