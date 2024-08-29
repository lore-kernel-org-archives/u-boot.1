Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A189CC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8D0C88C71;
	Thu, 29 Aug 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="apBpEvcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CB688C55; Thu, 29 Aug 2024 16:58:23 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8244488C39
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39d311d8091so2721095ab.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943500; x=1725548300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TdSYGK256+/2deGqh9wx5leXr+QjWnQlcourSWu9eXo=;
 b=apBpEvcxIsB9iHVCC+eBRBuBTDW756+pYoAaHbL66+voLvTO/53aZ1p+ff53O6drsc
 Ke3hAm36RKQRMToW/t+JFWOdKjS/eRocyrqb34EiHf0fsx9MLUFRMlRu45UP+UjDIRv5
 SO5U00jNfsgeKwz/P1A0aN/ocdjbz8xW/v+64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943500; x=1725548300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TdSYGK256+/2deGqh9wx5leXr+QjWnQlcourSWu9eXo=;
 b=lhvPyMsffTFTAJmA0BshksFhvXba4wAO7kR9JsSlcVUFEf5sVkBXyZSzjH388Itzeh
 j9cgl1rLzVOQI1MOKACshZO8+76ENMZcH4UqX9H0F7pRddQdkys+9Y8M0ggATdscjecr
 URWAxgvWyuCRrxx37RkP93byWTPIYvyhpWe4AMHl8xkXad6QLS71sg2FvDi3GEz/HLhr
 XUR5/LqaOIn00hcmtF9f/GVCXK3F/VkXotK5lx7wgi1Sn4LUHvG0U3z9YV7aw+Mf7zRu
 dpk+06bFJN/UrDQlQU7ILzgmcoejFR7JgeYg74VRPAWzEneCawqAAUQSMqVQ2yTuUacZ
 lG4g==
X-Gm-Message-State: AOJu0Yy1Ak/Mg0+kWA6RTrQRh56c/T7kLufiXk27q+59aickOQjJuqsh
 Hixu4Dei0cJB5Sm6ZR4RjMbw0AnB4elCNR7QOgrjnuKx2Q9fiVjkNB0zStSKJIxUVyuvsjAl2uQ
 =
X-Google-Smtp-Source: AGHT+IGsviBdscJcxkZdY29bM/eevMWwIoeNqy/fHeLImBzqzeSRlIyLMzjQeW0Tf/eOTnqg2FImiw==
X-Received: by 2002:a05:6e02:4b2:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-39f37837f5fmr33694535ab.18.1724943500134; 
 Thu, 29 Aug 2024 07:58:20 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/19] boot: Respect the load_op in fit_image_load()
Date: Thu, 29 Aug 2024 08:57:48 -0600
Message-Id: <20240829145802.1827952-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

Some code has crept in which ignores this parameter. Fix this and add a
little debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 439ff51edf6..db7fb61bca9 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2226,6 +2226,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	data = map_to_sysmem(buf);
 	load = data;
 	if (load_op == FIT_LOAD_IGNORED) {
+		log_debug("load_op: not loading\n");
 		/* Don't load */
 	} else if (fit_image_get_load(fit, noffset, &load)) {
 		if (load_op == FIT_LOAD_REQUIRED) {
@@ -2262,10 +2263,13 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	/* Kernel images get decompressed later in bootm_load_os(). */
 	if (!fit_image_get_comp(fit, noffset, &comp) &&
 	    comp != IH_COMP_NONE &&
+	    load_op != FIT_LOAD_IGNORED &&
 	    !(image_type == IH_TYPE_KERNEL ||
 	      image_type == IH_TYPE_KERNEL_NOLOAD ||
 	      image_type == IH_TYPE_RAMDISK)) {
 		ulong max_decomp_len = len * 20;
+
+		log_debug("decompressing image\n");
 		if (load == data) {
 			loadbuf = malloc(max_decomp_len);
 			load = map_to_sysmem(loadbuf);
@@ -2280,6 +2284,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 		len = load_end - load;
 	} else if (load != data) {
+		log_debug("copying\n");
 		loadbuf = map_sysmem(load, len);
 		memcpy(loadbuf, buf, len);
 	}
@@ -2289,8 +2294,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		     " please fix your .its file!\n");
 
 	/* verify that image data is a proper FDT blob */
-	if (image_type == IH_TYPE_FLATDT && fdt_check_header(loadbuf)) {
-		puts("Subimage data is not a FDT");
+	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
+	    fdt_check_header(loadbuf)) {
+		puts("Subimage data is not a FDT\n");
 		return -ENOEXEC;
 	}
 
-- 
2.34.1

