Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A135CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7912B8004F;
	Tue,  4 Nov 2025 16:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OeT93BYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB05B808AF; Tue,  4 Nov 2025 16:04:21 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F458003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso72859295e9.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 07:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268659; x=1762873459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uMu3QD6eLkyRDcUG73DIhbLqu1ezFi1FRyR6CkDfnVY=;
 b=OeT93BYk0bLO1c4f9HNr/ea8TrvUbV1ydnOOhfDgrF9YP/iLsPr8dXrS/lu37LWriq
 Z2ScU/myJsO2EWYH5NZfVaaGHzgjktvlM1gKBm/8Dus5dzV+Y6GB1GLdqZNiTlCYRQt8
 z75+Z57tRhyM3FvJW+55imHZoqXsC2w6y0bfhPTnntb9wAo4lkZWfIaH4RYov7vE3/pC
 FmqWAdbBtQa/dPZ4+EAn+XCtJV6ynazLshYcs9JCtOGa+uLf1D2LNxayDd9lxBXeb7MP
 Q4lOd2LO1rEkuTAOvFDthDPOV1URFbUFURa0DBHBCQzrbu0iAOKpwX6sWG9ZKdRLJNYr
 zC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268659; x=1762873459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uMu3QD6eLkyRDcUG73DIhbLqu1ezFi1FRyR6CkDfnVY=;
 b=EC7c8CeVM11ijz6kqYOi1UGK4QWthicWJ8L30mJ2mAE6APwb3oZdduL9hv3lbxhLS0
 /F+B+cPQGiCTJ6Fiz43bHDrQHXyKaYszWwG7vb0Bu8vhDWBEXfUjkX12scW/vQ3j2/4L
 WanUDh0M2psGgnPvTvaTofgj3NvpwT64JVyzI/vz0AdedbUoJQRXJEVSfN97ECZGPbG7
 kpIBH6Sh7Fv7VDi3OWu64xAMJJXt+gTktSW+OXId9F3udQPTSfAoAG1UrfVyK0evWMaj
 U73TTDjFH5ey7nWY2bHmxrss6uAyQCuLh/OndMMqVXKxrVDVKwIkdFjJNpKlk+fYJ5PS
 qf+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhrgAgQHLKhhldVAKXIGcQ5BUWo7hjFON/bbJdinsbFd8bVIQE/F44guujzvcenME2i87qMKc=@lists.denx.de
X-Gm-Message-State: AOJu0YxdMkR7FwuKyPngOmjC4N/FFkKp5SJhx1MdfkeDGngdDHIOnUw2
 AUch7IGWvC/JofKg8R7SbCxoja9sDqRYcR/H3IRFlb9ssynD9YBF4gLLtHFhOdExnRY=
X-Gm-Gg: ASbGncsv1NvQP+jL3kI6JjJf3UXYpgxJBn5N7MEQLaH98bP0FuD2UOlWTiGiVWKjtL7
 RL9l7msMvACzvgRN1EZ1LR+a3TNuO8iAPxlQBz1XOVurP1FjTgoa1zfskyz8eJmpyBR6Vj8+7CC
 HHE4mxFJ1bCr06ewEcQW+/P9sdpYJhNP+PJ/zye4bUxHZU9nj3lAZRiyCgJLPnt5np9l8WDNR94
 eHM/jfkh161RBHv5sXTHDolDrVFq0u9PAMxmc3nUCX0SpcW4JljqT0GZbB0WKnWEGKqFwm3YhCg
 6oCwRyHZyMI7PGzDklIJ8jaAdwFknY9PZHP9Uv++G5epSTwx+QqE77SSgsu/RTkQlGfoccQeKMb
 RHnJ95Z1gtERKxALO0BGj9PnSBILWPZAxVAJwub9P3MHNBTKFbgeO9OzaW+gwR+RZ5m9kCoLANe
 jcFwiBmlZwqkeKSHI2RaJ2/Y07buo7SZQH6oZ/wig5sPndoIvheC8E6s2Ue8I=
X-Google-Smtp-Source: AGHT+IF/TUSg2c0Pa1YA7j8nSoW4tgWQikwUoKdliWX5K6b05LC6m4bHaWLYY5ChYJyDB8Hhd/yl7A==
X-Received: by 2002:a05:600c:5307:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-47730890cd5mr183268515e9.31.1762268658935; 
 Tue, 04 Nov 2025 07:04:18 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm223581805e9.3.2025.11.04.07.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 07:04:18 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	raymondmaoca@gmail.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xu Zhang <423756212@qq.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH] armv8: Fix transfer list passing with KVM
Date: Tue,  4 Nov 2025 17:04:02 +0200
Message-ID: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

When loading U-Boot in a low memory address, the adpr instruction
to preserve saved_args[] end up within the memory space of QEMUs
mapped pflashes. As a result the following store pair instructions
lead to a crash since instructions that modify more than one registers
can't trap into KVM.

This problem can be solved with loading U-Boot with -kernel
and defining a different text base address. But when running with
-bios we always start from 0x0. So let's postpone the calculation
of saved_args[] post relocation, where we will have an address that
doesn't collide with the QEMU flashes.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/start.S | 8 ++++----
 arch/arm/lib/crt0_64.S     | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 40c342e97e9b..ef335de16b79 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -387,10 +387,10 @@ ENDPROC(c_runtime_cpu_setup)
 WEAK(save_boot_params)
 #if (IS_ENABLED(CONFIG_BLOBLIST))
 	/* Calculate the PC-relative address of saved_args */
-	adrp	x9, saved_args
-	add	x9, x9, :lo12:saved_args
-	stp 	x0, x1, [x9]
-	stp 	x2, x3, [x9, #16]
+	mov     x0, x19
+	mov     x1, x20
+	mov     x2, x21
+	mov     x3, x22
 #endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index 3e7627aa389b..d6246010f368 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -132,6 +132,10 @@ ENTRY(_main)
 	b	relocate_code
 
 relocation_return:
+       adrp    x9, saved_args
+       add     x9, x9, :lo12:saved_args
+       stp     x19, x20, [x9]
+       stp     x21, x22, [x9, #16]
 
 /*
  * Set up final (full) environment
-- 
2.43.0

