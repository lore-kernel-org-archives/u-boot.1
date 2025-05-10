Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FBEC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CC182BB5;
	Sat, 10 May 2025 15:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DW17DOWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A58682BA7; Sat, 10 May 2025 15:43:58 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9BA82BB5
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso580493866b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884635; x=1747489435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/jTjC+N5XyMfxWaReAzXMGn+BB2Jzb4CKHRKW0EUas=;
 b=DW17DOWaO+wGG4p6mKd+7GapynMUMNkVtN3s2XxtatEh6HF2j4Wx/9kshC93lCWlFx
 QI26sCQCroG4crkh5fzMz7hjNc9JAhLyuWvU8rclmQ1NGsoCfmLVLIuSPDbNvG5LS02e
 juB0X8FgdGd1qbDObKeeqYvIMywznMW9hpH+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884635; x=1747489435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/jTjC+N5XyMfxWaReAzXMGn+BB2Jzb4CKHRKW0EUas=;
 b=UHF7POOt7YYNUpkwjjfC6OoBXaqZ8VGu4G65pz40mKLVfumTVj2U+Z/+5GxnW5w8Y1
 VFq5B5m4wOKNHzsxt3BlW8vnZIQ/1eJK00c8s+RM417txpX20T/mHSJnspNXUfD/RwCp
 ggPfQo000GJfl4PtSqp1/39uJ8LlCTchGTUunaMqHi+6ylcrxbi/IK8B7Rtzr2R0cvzS
 EW3wxwiv0sARIjGWlWigutVj9v6yed0WXmZWtyAodTyJOhVRHB9wIj289qRw5v63dNA3
 FaeQmeOhinLbmf/2fiFRf8bXc+B9QueOjM+v/QB/z8pBYErgkabHQa29oE1cVaIEr50k
 ei6Q==
X-Gm-Message-State: AOJu0YyNTW8V2/UbJQuI0tDFn9YMe82ylWtd+80N7CeCtMGLUboJ2ghg
 iMbky8kL6nEOLbzPTvzqAGPtl+WDWAldYRAnHeRlWWwF1zzSjTeySUe+1MBJiXtfka9Nnvc3SMT
 iB19i3UcYoA==
X-Gm-Gg: ASbGncvvNu7AiSSRgDObBmcQgFATeA2ZAUVrGFg8J+RFuHVAksAQGusgNQFc8fQ56f0
 43ri23u77u1lBtv8nqHR356jAZ755bKwpIT0TVoU3VYutJNRon2oa/UWMU3ZNFe7dbvE764Vnh5
 fV4vi5YfnTF2K+pnXvSzo/K7+4aweAaeK6iIjsAE0O8QKnkhZUrHjQzw3cv0foknbe5t8KnOSzx
 5WeDshYSMv64OE/Z2UV5aehpOx7FvzWApfWiLQEjmYlBXZFOtWcKKfavfC5gBe/S2EKs3Gzgxxi
 1h4AIaq7cWkPD9YQtmM9TlOx1uZJOFQIR4EebeCUVE0Fwfh1vu9Pb7D2ZRkMnTMZYwHj
X-Google-Smtp-Source: AGHT+IFs1PR/TNXys3oFtSSaYw8nT2lZrg47HgVPNKrjF39YZ7rTLDdmVaaHe3HIcl1XP7uV3VurJQ==
X-Received: by 2002:a17:906:794c:b0:ac7:b8d0:86c0 with SMTP id
 a640c23a62f3a-ad218e88df2mr695249066b.9.1746884634606; 
 Sat, 10 May 2025 06:43:54 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 11/22] passage: spl: Support passing the passage to U-Boot
Date: Sat, 10 May 2025 15:42:09 +0200
Message-ID: <20250510154214.v4.11.Ifb43052c7d1729d6d1503a74e89abb69ee99cbf3@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

Create a new arch-specific way of creating a standard passage for the
next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Fix 'to' typo

Changes in v2:
- Make the stdpass calling standard arch-specific

 common/spl/spl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6e38f118f48..b705fd5514a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <nand.h>
+#include <passage.h>
 #include <serial.h>
 #include <spl.h>
 #include <spl_load.h>
@@ -398,13 +399,28 @@ int spl_load(struct spl_image_info *spl_image,
 
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
-	typedef void __noreturn (*image_entry_noargs_t)(void);
-
-	image_entry_noargs_t image_entry =
-		(image_entry_noargs_t)spl_image->entry_point;
+	ulong bloblist = 0;
 
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
-	image_entry();
+
+	if (CONFIG_IS_ENABLED(PASSAGE_OUT)) {
+		const void *fdt;
+
+		bloblist = bloblist_get_base();
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+
+		log_debug("passage: sending bloblist %lx dtb %lx\n",
+			  bloblist, (ulong)map_to_sysmem(fdt));
+		arch_passage_entry(spl_image->entry_point,
+				   map_to_sysmem(gd_bloblist()),
+				   map_to_sysmem(fdt));
+	} else {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+
+		image_entry_noargs_t image_entry =
+			(image_entry_noargs_t)spl_image->entry_point;
+		image_entry();
+	}
 }
 
 #if CONFIG_IS_ENABLED(HANDOFF)
-- 
2.43.0

