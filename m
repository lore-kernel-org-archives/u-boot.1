Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEAC2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F01388591;
	Fri, 21 Jun 2024 01:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hwKL+Fl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930A288551; Fri, 21 Jun 2024 01:06:45 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B1087E13
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7eb895539e3so51908439f.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924802; x=1719529602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=hwKL+Fl/a86uI4nfLrmRqrg8aJX6eYeDcvz8yk0n3rVrule9Ul3W/lYMN2Qn10TdLe
 elFb/b8vEv76KPBiadzF/In/9+eVVjoErez5+6Uscsdk6VvgatLAaWU0hg8KZuqSII8j
 2sGdrA7zrByHoBNgEM8EMCccTt1q3ILMkG3m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924802; x=1719529602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=XJQdLksX79sITfhNf8JTIWLVhY7wtsErAjHr+/hG7C0AyUpL0wqXv2+Jer+FmuHM58
 3Ak8FWSJ4S3J0ZieVkUVzPVvxcDePj5cLMODSjoSv9ZVxMBudC2ZR01kCj4Xe5lH35EL
 AI0FONXAK/0dp7BHXBd508mz+vb/6zfvEIwoRNJgkoAuG1mw9ciMEfyBj41a5uMaT2//
 rXPtq4Omf2Ouh72QdZ0769LEsVRXDbkzK0xOhgIBSJ7CPjZ4SpFwsaHf+TwxKjgYiWtO
 HsFMWfDOnz71u9/HaSRD5jw2hI9lee+mOgGlFmT2MMN2P4xtYSQ9832jSOL1svrPSYMZ
 xQDw==
X-Gm-Message-State: AOJu0YxFlwmsIc0NjqXa7wo+rBlSd4FcVYBkrzsDaSDi5jJt/sEGlVhG
 lLDU9EmasXV8wjBRZq/Jb+3d+eHFXdztLTrtf6RJBpgxsBfZdUVgTMlOqk/uSFI8DJ6banN/kXb
 MMQ==
X-Google-Smtp-Source: AGHT+IEVzJKYLfvIWt3uCIp7nz89qVJjU/gkLZRFLZdCIXvQbCzuZRbAD4Wn+l3+spsYB9e3QFMoHw==
X-Received: by 2002:a05:6602:6b82:b0:7eb:776f:d963 with SMTP id
 ca18e2360f4ac-7f13eddea04mr737866739f.8.1718924802201; 
 Thu, 20 Jun 2024 16:06:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 05/18] binman: Deal with mkeficapsule being missing
Date: Thu, 20 Jun 2024 17:06:12 -0600
Message-Id: <20240620230625.1797397-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

