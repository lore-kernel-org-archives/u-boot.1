Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582C6D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3092F8918F;
	Mon, 28 Oct 2024 13:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j78yYcAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C030890BC; Mon, 28 Oct 2024 13:48:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B48D989197
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9abe139088so626369466b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119728; x=1730724528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFIZUOZBOnWAGGZCI/wQYkABwEeNwKKsVvb8hmAlSi0=;
 b=j78yYcAZ26JwLvKEu1lztXxJCzjzgCXEwHradvLzxClC/F7yit4a+XoxNSM2HDEC3H
 l3RsOwYodJb3DKY2w8wR+kwaXf2v3F0afhpANo1f/R9EqTiL/P5lv46A+zo6bLUsMHNA
 BoR5soENrqQMOmfH4agzTjo9dmMiluZrx7sVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119728; x=1730724528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFIZUOZBOnWAGGZCI/wQYkABwEeNwKKsVvb8hmAlSi0=;
 b=LG4CQYhzVqsWhJ4ZgnjVQmAxcrGBYlFX1vC4ZFOO1lcokVgjjVnsJTbNjgus0Q5fqG
 4i+Kj07HiQGNwH59qDr80PKRCh5k2V1pgig1/pHgtxz/T1gvKoeo0f1ck7Zsk1Kg25gV
 B0HMoyG/+QNXO0k64eVXdHtZBqGPZqwXK+lk8tk9Z3FAsQJgqndXKy7yhoFdEyNHcYFl
 yVujekf9h13CRyf5tas6Xf1EdcBsfqOWSFNV9UKAA8gUGCthwVtru3XaG+hjMGlQ9ZyI
 88e8T/aOeKFb3ZIF4Axf4dnaHForsOQZOldQFDhfnHIaIFCzzzwdorB63/z0g6+AsFy/
 N/ew==
X-Gm-Message-State: AOJu0YzCseLoXSWZIT1lo5jFi14s8ylsmqoh1tcKArvZB4qSmDARZoPg
 hnu8AisSYLI7l+I0lUlS/ECbo9xWfCQLNkqXMc9J8alqhYh/sfN5diKnHVW4Ub6uSy0KrtHdpYQ
 A5w==
X-Google-Smtp-Source: AGHT+IGDBa29rVEHPIRqbE6YcnTQI18H+a3MN1eLno3EkkjQBj34kEMIRmwa9y5iNjQ6qeTu6zlu1w==
X-Received: by 2002:a17:906:dac9:b0:a9a:c651:e7d9 with SMTP id
 a640c23a62f3a-a9de61677b2mr674973166b.46.1730119728295; 
 Mon, 28 Oct 2024 05:48:48 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH 15/15] efi_loader: Add documentation for the EFI log
Date: Mon, 28 Oct 2024 13:48:06 +0100
Message-ID: <20241028124815.47262-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Add a note in the documentation about this feature.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/uefi/uefi.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 0760ca91d4f..eade13dcfa1 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -963,6 +963,28 @@ This driver is only available if U-Boot is configured with::
     CONFIG_BLK=y
     CONFIG_PARTITIONS=y
 
+Logging
+-------
+
+The EFI subsystem supports logging of boot-services calls to a memory area. The
+log can then be shown using the ``efidebug log`` command. Note that only a few
+calls are logged at present.
+
+To enable this feature::
+
+    CONFIG_EFI_LOG=y
+    CONFIG_EFI_LOG_SIZE=0x4000
+    CONFIG_BLOBLIST_SIZE_RELOC=0x5000
+
+The bloblist size must be set to larger than the EFI size. For now the log size
+is fixed at the start.
+
+Logging is performed within the internal U-Boot functions, not at the
+boot-services interface. This makes it possible to log EFI calls made by U-Boot
+itself, such as memory allocations.
+
+See the :doc:`/usage/cmd/efidebug` (*log* subcommand) for more information.
+
 Miscellaneous
 -------------
 
-- 
2.43.0

