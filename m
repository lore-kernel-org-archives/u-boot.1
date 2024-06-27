Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B0C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A838855B;
	Thu, 27 Jun 2024 11:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GXeCqT42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01AA78855B; Thu, 27 Jun 2024 11:19:38 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC5388256
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52cdd893e5cso5833969e87.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479975; x=1720084775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7dZ7EgYr0k6vuGV4Zq+HOmn5La1Qr8GHhYneKXIm/g=;
 b=GXeCqT42Jaym2Skan6TupMYxYwshqL6P+WIjZtzLlEQr1UNHoqj/LUZDg5JfaLx8lR
 Sf8HNjxsSq/teboOygHn41MSNI1EUNBaz8UVIhanEQR/NYLWCozP/iCzl2ZlOYMYDRkc
 RfXK7EjK8Ury1C0iyXPRkon0EctW27EQ/+l0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479975; x=1720084775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7dZ7EgYr0k6vuGV4Zq+HOmn5La1Qr8GHhYneKXIm/g=;
 b=YeIlBpz3GiaHJHKMGgRwLqP7Y7QMjdEL9f/lit9twhkM4KzaifIkryOnEV6lly0S9Q
 5JU77Cvy6xAD7qYi8/RbUEIM50Hj4oFox7dp5W07f+pCtHrgYhXCRsSiNygPDm44o2oa
 scez71cYm+x4q5DGk6zMj6ltNye/pYwAdDqYkIW17tQLaJt2TnwQNX3IUfVN5UAUh4H3
 wlBv3zmHk/wolI0pygnWYl1MlBJPK2h3HWvxxs5WC6v+YM9eMaK81nndgna6j+iqwCMZ
 ApyE4RMRNMHJ3VAhqQgkUVbGwk6yxLHDBNVhdVWreuHO5EuAx5xgY1ezvzr8sHJK9MSh
 x+GQ==
X-Gm-Message-State: AOJu0YwbcxUu4yQP5xxE4U5sEqX1quWFzQ34MVmuLMKiJ0IVnhvORKbq
 oVtOjMLeN+Hh4fenDiv4a3BzbuFj2yqr3z/RzX8eAvTFQRZO4KsxDHBDNbW4RIVNvXIKnCGgOFv
 SRw==
X-Google-Smtp-Source: AGHT+IHNP5cUwDnfSDNin7G9bLUmgtMFoakBYJd8yvc4TfT47I7CBWwAZBYa3N8bd8s5ViJNSgRBgg==
X-Received: by 2002:a05:6512:467:b0:52c:da39:87a7 with SMTP id
 2adb3069b0e04-52ce1843951mr10096611e87.41.1719479975149; 
 Thu, 27 Jun 2024 02:19:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v6 5/8] binman: Keep the efi_capsule input file
Date: Thu, 27 Jun 2024 10:19:23 +0100
Message-Id: <20240627091926.374633-6-sjg@chromium.org>
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

There is no need to remove input files. It makes it harder to diagnose
failures. Keep the payload file.

There is no test for this condition, but one could be added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

(no changes since v4)

Changes in v4:
- Drop Fixes tag

 tools/binman/etype/efi_capsule.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 47da5da324b..03e55cbc4d9 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
                                                  self.fw_version,
                                                  self.oem_flags)
         if ret is not None:
-            os.remove(payload)
             return tools.read_file(capsule_fname)
         else:
             # Bintool is missing; just use the input data as the output
-- 
2.34.1

