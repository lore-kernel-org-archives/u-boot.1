Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18165C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A58EE88E3A;
	Wed, 21 Aug 2024 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDk6+pN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B3488E2A; Wed, 21 Aug 2024 18:19:52 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7660488E2F
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7093997dffdso2691424a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257189; x=1724861989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcJBMZTHzLm0YSDAU92eJgdx7Ighi91Jqasuw5mnbWY=;
 b=VDk6+pN3O2qaBRip1/xBQFnQ6lQYSm/vsaPEomzWa1Awn1GuCUon0HQXQbdupa/KFD
 zUfAMvjnm5laNaAu2hjR0BNvkKrwJ3JFkcEggoua6qoBf63sflj4AHeN4VyPHDup0XOY
 866WO+FMu2YqFFvQgeb9yenGYPTHRDV418Pno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257189; x=1724861989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EcJBMZTHzLm0YSDAU92eJgdx7Ighi91Jqasuw5mnbWY=;
 b=AEvQShXiWGOvkEiHuXJt67wHU0omdJbm8atZFYTQ/pT6RozVOkFcEslTKqseBmnWPF
 rATqdivIdqb+grzCUQp+bDQrPtRrzGISMluAI1wmu6wixjQ1XEUs4hOA9Suz1Z+9KLwq
 2uepmeF7d7cp0e3iy+iajw7wCapC1jNr6ws1u1NVe2fje+sBm8BCBvMGF+UfnT0EAVrM
 LubCN2KA8xx+PsHMI4ZtSZLbvHi50wGB5Gr8ZQw25fmEKHc0AHLuzetFQMTGGdoSgMDk
 T4yi79JUkqWhpaQkBcwZhnVzed7srwcQvQOMLVaUDKLvatC81Nc70DBU2iOWUMu1NtEV
 e03w==
X-Gm-Message-State: AOJu0YyOA9FB3qZRtMMPtl9NxTkFeyYNra4r9eecp4LzjMXF1v0TJlUm
 hMn3eikJ/SihPHsxmBicxS4nguOK/o7ZLCtYGDVz/nxhZck9+WjxqmqvUOaPGVrQG/t90zlFS2A
 =
X-Google-Smtp-Source: AGHT+IExVRXmz14rEx9i2F/g6eeVjw3+wdnz3Ft7pf4FeDR94Nmb9JuLLGu+prky7L1yWIs6bML3ug==
X-Received: by 2002:a05:6830:448a:b0:709:3462:a4b6 with SMTP id
 46e09a7af769-70df870944fmr2585140a34.9.1724257189110; 
 Wed, 21 Aug 2024 09:19:49 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/35] global_data: Drop pci_bootdelay
Date: Wed, 21 Aug 2024 10:19:07 -0600
Message-Id: <20240821161927.695717-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is not used. Drop the field and the environment code which uses it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/asm-generic/global_data.h | 11 -----------
 include/env_default.h             |  3 ---
 2 files changed, 14 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index b860f3626b8..86e8d654a28 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -297,17 +297,6 @@ struct global_data {
 	 * @malloc_ptr: current address of early malloc()
 	 */
 	unsigned long malloc_ptr;
-#endif
-#ifdef CONFIG_PCI_BOOTDELAY
-	/**
-	 * @pcidelay_done: delay time before scanning of PIC hose expired
-	 *
-	 * If CONFIG_PCI_BOOTDELAY=y, pci_hose_scan() waits for the number of
-	 * milliseconds defined by environment variable pcidelay before
-	 * scanning. Once this delay has expired the flag @pcidelay_done
-	 * is set to 1.
-	 */
-	int pcidelay_done;
 #endif
 	/**
 	 * @cur_serial_dev: current serial device
diff --git a/include/env_default.h b/include/env_default.h
index 076ffdd44e9..aa3dd40f3fa 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -82,9 +82,6 @@ const char default_environment[] = {
 #ifdef	CONFIG_SYS_LOAD_ADDR
 	"loadaddr="	__stringify(CONFIG_SYS_LOAD_ADDR)"\0"
 #endif
-#if defined(CONFIG_PCI_BOOTDELAY) && (CONFIG_PCI_BOOTDELAY > 0)
-	"pcidelay="	__stringify(CONFIG_PCI_BOOTDELAY)"\0"
-#endif
 #ifdef	CONFIG_ENV_VARS_UBOOT_CONFIG
 	"arch="		CONFIG_SYS_ARCH			"\0"
 #ifdef CONFIG_SYS_CPU
-- 
2.34.1

