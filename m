Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA61C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4473588AA9;
	Wed, 31 Jul 2024 16:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ReGD/Av7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEB2B88A54; Wed, 31 Jul 2024 16:49:17 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3AD889E3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-396db51d140so29430125ab.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437354; x=1723042154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ys/udAHr0DGYgZKWhy8/5aPVMc1LnX2qFCb0HwQhPk=;
 b=ReGD/Av7FdoNx9xw00XYhO6dq8e4IYpzyQA7kNoqNezjmVsSphpfMtzDRrvdCdtsOL
 VYgDYF4BXZOVgNHGlxu7pjeIhgbTycx/ksf2UzS4aqT9JXVkNqgYGBrx14YMvNnLWjZr
 6NaodKc6zlwy92whaGw0M+7zBfaSkjBwoOTdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437354; x=1723042154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ys/udAHr0DGYgZKWhy8/5aPVMc1LnX2qFCb0HwQhPk=;
 b=jWGcmhsHE6dh77A+6fFxUIMLyh8ZfxnlmQag7sIzE/Wz6hs5WUEMHhhgZ2Me3RuEhZ
 GBDYxt5V2QYnsQenpadCfurqKss2LdxNmS3seTZmgd4CbwR0xOe/OjIcBXQCZPvna2Yc
 WqdCDP69iWR0LTiWjLhzsWL7s/lueTXe4o+D4jNCStbPYDFKbR3Vj0mMTMYh551dVVWq
 CpPiTI0RMaUADpzCJawnuJEvsDZ6g9scQnSKKL17aqiITos/ZYlgKpxOKSDXSz4ar6fl
 vyqnh5ujzyaKtHshtm3atqB7fbIIbFjbIqKmiIPdu892Gcu4iN2CSaaJG+6y3R2SU+Wi
 TmDA==
X-Gm-Message-State: AOJu0YyVancQQkt+CY6Pd3i6DYxa455e2/ibm6ytoTyWPDZ6Ja7vwug8
 m5YTtptnxkSQszzQCgs2+SrplS3zKApjxi3L0QWz2UK9P04TpVWPXrpBr3SSIAo5CShQlbKm5zg
 =
X-Google-Smtp-Source: AGHT+IEuWmzzjtXTDMp677db0AkYAW3rLZ33AAN9UwYXrGRXRKKWLcLwLnbChkMOzt/iiXyl3KEQDA==
X-Received: by 2002:a05:6e02:1a4e:b0:383:873c:e2a4 with SMTP id
 e9e14a558f8ab-39aec400f39mr144422895ab.18.1722437354226; 
 Wed, 31 Jul 2024 07:49:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v7 3/8] binman: Deal with mkeficapsule being missing
Date: Wed, 31 Jul 2024 08:49:02 -0600
Message-Id: <20240731144908.795290-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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
index 751f654bf31..1c4d1bb0e2a 100644
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

