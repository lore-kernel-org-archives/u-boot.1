Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA5C54F32
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 12:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E34183242;
	Sat, 24 May 2025 14:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gntVQvA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A4081F6B; Sat, 24 May 2025 14:09:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B42C831FE
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 14:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso4598755e9.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748088596; x=1748693396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQkKvqnSdyAY8ePbZVBOHHkkESb+xsw7rNXrpNPny4Q=;
 b=gntVQvA2MLBc2S30UswN+k/BrC/LcaGD6BLcKrXivKUU9geSvAeE3b65T3JZocN65Y
 ApJmWGvuoG5Quwj3J35DJq4V9Q9XaMDyS9K6jtJy0X9+DJEPxJoE+gG6ZVrvh7oincqq
 jvSc4zOuqZyXqcE+Y8GWoyr1Fv9CRakwLlerA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748088596; x=1748693396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQkKvqnSdyAY8ePbZVBOHHkkESb+xsw7rNXrpNPny4Q=;
 b=tswHpYPj0FIyUgJNW2VSNqMrYIb7aAdNbDpphBR6jCh5oemWF9BdQ5bSl50sOAxPEm
 wdHrNqzoqBy/Zhq/e/VGkVJ6/9yZVQUF0ILzIiSK4odfgyNfY43NVKLehVURBkh1G7Ub
 rwGuBQSgeFeomPfLteMqLygCppDJAsJd/qGK99G5StBdC+RAChPAttkTGj9fYG+v0CQG
 ox4crgQc9aFg5W84qSAWStnzuyVJ5m4+m3y4cFuLzU5XXBPNi7Z2/bNN4ZKIzU2RcWwQ
 e341eTP9TURy8Ns/ioO8YPDIecfCgYZtB0J4fBA4zEGa/zWG2lo1Tc9R/EP8u13ARCPL
 tcNQ==
X-Gm-Message-State: AOJu0Yzg75MbuI97le7ggCnT8IvIuvvKvSt4KaF/tVSqxGmvHjEhmpfT
 gQ3xyopCdg3ZfZe95irU4vcc0FpAsfe+gMmX4v4ynsWEPnFRiHBNRFVC27LBuobMHRMQTMwqtt+
 SKkJC1eew
X-Gm-Gg: ASbGncsWx6TGZwZC6GuoNUZ/3WCGFWB6xpQmrvJpXPvQDdcsHwOJygqQF5Bt8ipLlcw
 aF87K8NmYF+Yf2fK/uM3eNlR6ThOWV9827cCv4Za3CLDhwUbCiEy03p/lpyHmpx6Becyd3B6mnx
 8JtpPiUUHSYdDeKttB2z42leVcTIliGXT2y0TJX2MlQW6U+5/ri3SXpmyeaoFLOincF+cBH0kj/
 Db6rSrjtRFdbvQBnYlwj+LgD9OvuENHVhqIPLcUoLtxhKVn/XW5RP79ZfotfojHwFqZClamm2W2
 jXe6r1w/zp9mR7hS5PpP1zdcQNJ2cvq+x9WMxhrMOjoq0aK2iJWSIAU5LqxValrEqYvkXL4=
X-Google-Smtp-Source: AGHT+IE6EWi4FihLTKBfMe0s7siZiP8kfxVAEQrVq62JnvUzhzxOWEn/yXY8g5dKN5fJl8NfCcLPwQ==
X-Received: by 2002:a05:600c:5006:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-44c9493e665mr20757245e9.21.1748088596573; 
 Sat, 24 May 2025 05:09:56 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23c07bfsm177028585e9.23.2025.05.24.05.09.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 05:09:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] Revert "doc: Update authenticated capsules documentation"
Date: Sat, 24 May 2025 13:09:03 +0100
Message-Id: <20250524120904.684977-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250524120904.684977-1-sjg@chromium.org>
References: <20250524120904.684977-1-sjg@chromium.org>
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

Restore the documentation for using signatures in the devicetree.

This reverts commit 8082116dff3351277a019f7f35a0aeb62fe235ce.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/uefi.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a9..48d6110b2ad 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -597,6 +597,21 @@ and used by the steps highlighted below.
       [--fit | --raw | --guid <guid-string] \
       <image_blob> <capsule_file_name>
 
+4. Insert the signature list into a device tree in the following format::
+
+    {
+            signature {
+                    capsule-key = [ <binary of signature list> ];
+            }
+            ...
+    }
+
+You can perform step-4 through the Kconfig symbol
+CONFIG_EFI_CAPSULE_CRT_FILE. This symbol points to the signing key
+generated in step-2. As part of U-Boot build, the ESL certificate file will
+be generated from the signing key and automatically get embedded into the
+platform's dtb.
+
 Anti-rollback Protection
 ************************
 
-- 
2.34.1

