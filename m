Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B12EC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E03A86A6D;
	Thu,  7 Sep 2023 17:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LwX1Ws42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A90686A6D; Thu,  7 Sep 2023 17:58:38 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F76F86A47
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso45229039f.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102311; x=1694707111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxhZ/pRLFtHbXtMsrZxWXDS2K/33czG7/yBensY0jKs=;
 b=LwX1Ws42fSe5Sxnyd0SankIGOV5NmGIXqp32uHEZe+FuWvqwzFiJ/n/RYuaNjqWvzy
 LbTd60Q+McMYA+75ZV+ngiHoOTY7WX52XAdT1GOUC1P4VmXcg1ztwKIaaiyBe2tDaZ5H
 78XYQesduqIOnpLdJ0JJdszr943HTj7ZaSYc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694102311; x=1694707111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OxhZ/pRLFtHbXtMsrZxWXDS2K/33czG7/yBensY0jKs=;
 b=OiYD2jCY8T/OnDpioSQK/GutKbKXn6ZlSd5qT5maC9LG1XxIkHlZUXc+jcwm6za4FD
 6O0/9KBJd1WQgHBFZtOGuaHk7D8NTDZxVkQwEAvmg9qgf6TZ44plzS2N80xfeRdfOzpo
 mJoFG4eiiCK4MkK4vyqWwXTts96IYfw8KCLB8JWx5zx+ZBs9/xopuU7gVxF8dZLIhSYG
 +VRDYMy3HNPoXb2s53Jw9BcibbFLFPXumnYelUorxgCUU6UCKBsaRn/X2ybOKulNk7cu
 7VHKEdExwFg7kVoXzPaliQSvpWHdr/SjSPzDb0/0/QzPsJn1voE9X3YQkDtaDM3SsDi7
 HZTA==
X-Gm-Message-State: AOJu0YxllwMgJDDUtS4Sm5/FuUfYKidkR+w9snfTwl+O800FiOht7FtQ
 iQbL2Tw2rn3mzLOEkXdaiKZzc0Fpa16ObcDKRbQ=
X-Google-Smtp-Source: AGHT+IGtBPgQPrxouK1LOARiRKs2qB6l3Ui02uGtAJNZD1gQZFkKDgUnir363okXzESNVqxQbHqGiQ==
X-Received: by 2002:a6b:e014:0:b0:792:70f2:a8ed with SMTP id
 z20-20020a6be014000000b0079270f2a8edmr160056iog.4.1694102311705; 
 Thu, 07 Sep 2023 08:58:31 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 1/9] dm: core: Allow marking driver model as dead
Date: Thu,  7 Sep 2023 09:58:13 -0600
Message-ID: <20230907155825.48056-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

On x86 devices we use CAR (Cache-As-RAM) to hold the malloc() region in
SPL, since SDRAM is not set up yet. This means that driver model stores
its tables in this region.

When preparing to jump from SPL to U-Boot proper, we must disable CAR, so
that the CPU can uses the caches normally. This means that driver model
tables become inaccessible. From there until we jump to U-Boot proper, we
must avoid using driver model.

This is only a problem on boards which operate this way, for example
chromebook_link64

Add a flag to indicate that driver model is dead and should not be used.
It can be used in SPL to avoid hanging the machine.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to allow marking driver model as dead

 common/spl/spl.c                  | 2 +-
 include/asm-generic/global_data.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d9a..045a5e89625d 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -800,7 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	    IS_ENABLED(CONFIG_SPL_ATF))
 		dram_init_banksize();
 
-	if (CONFIG_IS_ENABLED(PCI)) {
+	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
 		ret = pci_init();
 		if (ret)
 			puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8fc205ded1a3..5b11cb17ac03 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -667,6 +667,11 @@ enum gd_flags {
 	 * @GD_FLG_OF_TAG_MIGRATE: Device tree has old u-boot,dm- tags
 	 */
 	GD_FLG_OF_TAG_MIGRATE = 0x200000,
+	/**
+	 * @GD_FLG_DM_DEAD: Driver model is not accessible. This can be set when
+	 * the memory used to holds its tables has been mapped out.
+	 */
+	GD_FLG_DM_DEAD = 0x400000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.42.0.283.g2d96d420d3-goog

