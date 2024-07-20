Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E41BC3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB1788B4C;
	Sat, 20 Jul 2024 12:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e3Is3gkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D6788ACF; Sat, 20 Jul 2024 12:50:07 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39369886F9
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso17915605e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472604; x=1722077404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJ+6pcMOYGGI1gMWlYtkWd2t1T5NPvlT5ETc8P2r6y0=;
 b=e3Is3gkLDzC60GZ5TDlPElq5zEL6bApAbekbdymquFuvjSl44t0sWGs1jPglAa4Zt/
 NmTHlV8rQGIUonM1+7yVMK+IkFyDU+58vSFxCpquWjoKNYIcEFG9h80WlDru4Gyuqah4
 zuNPtDyffK5+rQk7+b4DGhEhE5lEqF++rp5bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472604; x=1722077404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJ+6pcMOYGGI1gMWlYtkWd2t1T5NPvlT5ETc8P2r6y0=;
 b=o8janmLiHA8rZi3J+exsBXn2CHUrQpvbrslvAnM+eZ0Ksy7OEU3YeqRpZuTXUBBvgR
 rqbWr2bcbC/YE9QBK73vZlVBVgFUelbE/6BX1758b7lU2H8Ms6F2tzvVHX3YNlelXUYR
 0qptWB2KviVNxuZTRpz1uQ5NWqlhY0aUzmOWTOdRFeaYDudfoU9G6E/ONdgaJ6lmy8Gc
 tnQmFo5JDeDzKKB3i7npYtwPf0lFPyNcpkHVmaDHXlQw5h8StG4QdIU3XTaNUVkEdpNN
 DhnGRRPFvtwOllInk91H+4OJCUI4O8TNHM6JMtTcccqGCrWsejsZtd8McxRozJZURA16
 drQg==
X-Gm-Message-State: AOJu0YyuGj3i3Ok9JPQX+A5pVxwOtUBNfuAXWxT3MCxREkSZ6CIGP5nt
 HLQuyb5QwJ4nr5xSJ3dfQQ4bkfno06KhpAbSJURWl+kEH1SbPMYkT0mIjP9Y5dyUTJu8RViDVgo
 =
X-Google-Smtp-Source: AGHT+IE5qJQz9pMA4UXtECamOY35CcfiTskC2wG7mPjiKBeH8woxCcYA+2zJK+McwpA4hcILom+Ccw==
X-Received: by 2002:a05:600c:468b:b0:426:5416:67de with SMTP id
 5b1f17b1804b1-427dc58f5bdmr6299665e9.30.1721472604493; 
 Sat, 20 Jul 2024 03:50:04 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:50:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/20] binman: Tidy up comment for Bintoolfdt_add_pubkey.run()
Date: Sat, 20 Jul 2024 11:49:34 +0100
Message-Id: <20240720104950.2730773-5-sjg@chromium.org>
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

This function returns a value, so add documentation for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdt_add_pubkey.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/binman/btool/fdt_add_pubkey.py b/tools/binman/btool/fdt_add_pubkey.py
index a50774200c9..75a9716ad72 100644
--- a/tools/binman/btool/fdt_add_pubkey.py
+++ b/tools/binman/btool/fdt_add_pubkey.py
@@ -32,6 +32,10 @@ class Bintoolfdt_add_pubkey(bintool.Bintool):
                 verified for the image / configuration to be considered valid.
             algo (str): Cryptographic algorithm. Optional parameter,
                 default value: sha1,rsa2048
+
+        Returns:
+            CommandResult: Resulting output from the bintool, or None if the
+                tool is not present
         """
         args = []
         if algo:
-- 
2.34.1

