Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06028C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C6BA884FC;
	Thu, 27 Jun 2024 11:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OgOU00Ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351DF884A7; Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 435EB884FC
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36703b0f914so1009126f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479973; x=1720084773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=OgOU00IgvABmCdirCI/VFxD2UnkviyDxibv3xAcwlXZJdeaRaQD4D0CTkf+jkwKCS3
 PPxtuxWpFNjAtKXdH5s7eiNc3mlpvqMeHq48INMWuvsXuT5NgGzBzjkMD2ISZxFy7nWH
 43UGi0Hk+yAafgGG9QbuQsKslWmfMQkGOijyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479973; x=1720084773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=FzNT0FDBfgMMRxfMD7dlcac171MPjRQF7qVphRgCBRVfAlY239t8QIRcHBesYf/mY5
 B5CFoBYKMQCcyFLxGUHDKeK7XxpUWiltMkyI7XatEU8fzp5LgoyxCGM8BR7e8LhKHwTL
 bpKdwxJsI9x8qxlY2FWfLfr7rDrpGSq3/afQhvGQSFRYj5RkaOspNzEDrcSbyK2zEPEU
 G9zy3lOPpP3k6BDQvVH9NJAusg5A3CkfdVT8PURu6vo1zm5DBocPa778OrIWRt5bpMh9
 3M2Axhnp8uB0zvbWYtErKXK8kTe93mNWM/XC8TI+xqwOHwB0hR8NBICS4Xv1yuiywaPk
 O0Lw==
X-Gm-Message-State: AOJu0YxTDrtVXdB7tpAvsXc7HVnXXC8qHuBko4hOUxbJISz/3E/f6Mac
 sjJ3HcPNInbx6FXWZIZdHBTPal0upwd0YZNY5Fk+QHjz6sYvGuf7nFIJPZggQa/1qvY008cJa3Z
 Ehg==
X-Google-Smtp-Source: AGHT+IEWDwbwvC1ZTGcV7UzNgogQBy9/Wpqz5vyo0dPG979OwLkui6dlVrVBf5sCQ7B8MO9xct4Utw==
X-Received: by 2002:a5d:64ce:0:b0:366:defe:1b3b with SMTP id
 ffacd0b85a97d-3673cc55d39mr2114698f8f.11.1719479973413; 
 Thu, 27 Jun 2024 02:19:33 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v6 3/8] binman: Deal with mkeficapsule being missing
Date: Thu, 27 Jun 2024 10:19:21 +0100
Message-Id: <20240627091926.374633-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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

Tools cannot be assumed to be present. Add a check for this with the
mkeficpasule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: b617611b27a ("binman: capsule: Add support for generating...")
---

(no changes since v1)

 tools/binman/etype/efi_capsule.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e3203717822..47da5da324b 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -150,6 +150,10 @@ class Entry_efi_capsule(Entry_section):
         if ret is not None:
             os.remove(payload)
             return tools.read_file(capsule_fname)
+        else:
+            # Bintool is missing; just use the input data as the output
+            self.record_missing_bintool(self.mkeficapsule)
+            return data
 
     def AddBintools(self, btools):
         self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
-- 
2.34.1

