Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0AFCF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 523378941F;
	Fri, 20 Sep 2024 10:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OVFGYr+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65654893BE; Fri, 20 Sep 2024 10:13:29 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77922893CF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a8a837cec81so117143166b.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820007; x=1727424807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFRg3g07zPk9bQyiEd5iJfrn5GXmIn+TMto1AR2XNxI=;
 b=OVFGYr+lW5MZHzUOtcGFLW8lCKlYz8v8U35EUCslJ4OIhURwNsnWsVDq8tKp5mbFwB
 vIa0JZ6KDmvowRapt/CKjYPT78bRj8TEmvdQ2qoLYx80cig2wmT+EMt4WG+jhnqxtlCs
 qZ7DWlJ5ZtXGeelKXwR2rrVIuCznFErc/nje4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820007; x=1727424807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFRg3g07zPk9bQyiEd5iJfrn5GXmIn+TMto1AR2XNxI=;
 b=Bc1gVUeKRYZgYxcMG4e3cE78JOAp2JVEEPtD/vycrbi2v8ViAaXBJN6v+ySBUxpwCc
 b6SjNJWm2T9HC7y4y57+3uXTQ7/KuBFZJYX6FvHrNTQ8Xt2ZKivk6v51ZdMp4ArABpYG
 uFIWpUWG1eGR5a0MOh3EUbrKXVl5rfLhNCspcENbYXAebbe+0Qgg5z9s8sWPJ6VuEJMS
 CxgMm1hMmk4ek5N7UlJ9yKGxAiFJ624dLM98W54FRBH5o9JHayrQ6Hd+HMhb9bIkDSLb
 uFgWiubl8664vmO9bTmtHvL29/3xOFVOYvJcPrVCGXXX46vNY2fj43+7Gl5VA1/8FltT
 A+0g==
X-Gm-Message-State: AOJu0YxqNWY7pN5k7rMBaB988vX4XeNB3GpekEqN4ZvosfDkKM2Ed9HZ
 fYDqY5PgLRZfFfZG/sCDJBcjaoxfIJhgEg9U7ewGc3QzcEOGZPwqVYmHqMloqKFVJdYngVRjIqr
 cxI9q
X-Google-Smtp-Source: AGHT+IFbyfT9JisrKPHLE3NIRaqYp/3F4aPh+GRSfZneZt5VU1Q+plV8tjsQ+a1uIdZpj/zoU+U9jA==
X-Received: by 2002:a05:6402:3512:b0:5c2:5f24:98bd with SMTP id
 4fb4d7f45d1cf-5c464a3cc68mr1772742a12.10.1726820006670; 
 Fri, 20 Sep 2024 01:13:26 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/18] boot: Respect the load_op in fit_image_load()
Date: Fri, 20 Sep 2024 10:12:43 +0200
Message-ID: <20240920081309.140426-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0

