Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367FAE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB0780713;
	Mon,  6 Jan 2025 15:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JkruYcnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C04A80703; Mon,  6 Jan 2025 15:33:57 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2D5806EB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a8180205f3so55586775ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174033; x=1736778833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq+HElnNK/Nwk9TrltcDY0YsLdmP8y/PfB4CXq8cRT0=;
 b=JkruYcnLoUxBoaN3Cjdl+BiLDPfXHJVzFtRezXe26x2UamVAOZ5r18PSA0j82Iknic
 +eQlsDIVAu+zplNboBt10/8Id+cwIAskWmP8v7etRth8/x34zROZCpztqT+iyVmcmNra
 d9ylmbmJTtSOQpNBjCPvDq6Xx4BN/7tsw4vuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174033; x=1736778833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq+HElnNK/Nwk9TrltcDY0YsLdmP8y/PfB4CXq8cRT0=;
 b=pmxFgslnX3pFocS4jjSB6jk64OH4Vyfjno8VL3ZNkY9syyCDp83ENzB2bHS/pd1Shv
 +KeaLfRZdXPLH+YAGEzSxBfJ1LcbMnrOT7JFiKAxdI0BA4p5UvAZLtyRDS1MY3P/KWtV
 N4iCIYBwHjlV7I4+y0B8CTNzLxfoDyL8y2konEE0iqwE6Z3Q3F17I8B3iaptXGq0DhtM
 f259172zNS3VgUYbF01Ov4qFaf7G4lRIxOW7AO9mqQQltP7j1QIWm+Y8SqEtmVvEDjhk
 Xy0cTtWUzMnWoj4qsht7SaVoHpMzbgHdXALbJShh0CAu7NCW6CjVx7Dsr1CRR+SOiUvL
 3ZLg==
X-Gm-Message-State: AOJu0YzdpTU+H4GcPRBWwioND7mmYA52AdKuW6cvgXF9ryw3FW8qUYQ5
 9Nn3xFjfJVRkZp1wmL61qXxNUdgNgu0CYL8dIowc4otsSNBlk5X+ybCZrnc28UqM5MxTH7+u/iM
 =
X-Gm-Gg: ASbGnctkHVpOGtAN6c/VhKCyaV9TacybZUUvc9fZdtTH+nXm7Qu4TAF0Sz+3gNqV6yX
 Icrp+EhwtoReqqgJ9vJQMERQAN+wmxQtiarqPrwirRNrG73vaZOGUE96OMeddejbHUi8ce4rsRW
 zKNf5ZZ4FQ7gttDNgFAEADCFdYuXqciuhe7V7TC0b36nf5//GBRrwc77DEJ1O+dymvNI3c73LlR
 /NvgEWu0cjNrnnrmhAeS5AI3Ok5tygOnU908DpS7aGIah6qrpzwtmy/6TAwSil9sZeNUWT3863b
 UQ1ajqXB/fqefulY4A==
X-Google-Smtp-Source: AGHT+IFxs6bQ7trCCZ3fSmVRzvetF/sLl6fCOPQQfJ0AO6GmN+KpIzExLVxoOOSL0BPOd8qF4vx3Ow==
X-Received: by 2002:a05:6e02:b4f:b0:3a9:cb4a:842a with SMTP id
 e9e14a558f8ab-3c02ceb248amr524949705ab.5.1736174032815; 
 Mon, 06 Jan 2025 06:33:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/33] x86: Support jumping to a UPL image
Date: Mon,  6 Jan 2025 07:32:22 -0700
Message-Id: <20250106143229.3023771-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Add a function to allow x86 boards to jump to a UPL images. Currently
only 32-bit entry is supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/bootm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index bbd8ee7870f..e7a98bf1590 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -283,3 +283,14 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	return boot_jump_linux(images);
 }
+
+int arch_upl_jump(ulong entry, const struct abuf *buf)
+{
+	typedef EFIAPI void (*h_func)(void *hoff);
+	h_func func;
+
+	func = (h_func)(ulong)entry;
+	func(buf->data);
+
+	return -EFAULT;
+}
-- 
2.34.1

