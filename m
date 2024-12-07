Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8CCE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599E08945C;
	Sat,  7 Dec 2024 18:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FaLlrzix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D438B893E0; Sat,  7 Dec 2024 18:26:15 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CB988FB4
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-841837213b1so228137839f.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592372; x=1734197172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWKtId27HRHoTA4nPIebo6hh5rfBC3NImMIXMw+LeI8=;
 b=FaLlrzix6gnWCRvhlMFQPvmoeb/b5eHIC2Cqk2aKfIuvqqdLwWvLTN8U8kC8aBZNEq
 kOtM2ebp1HqERvbM0fOoJ929AbNWT951OElzhNnVMYR7CPnLD1Q3+0uGGJuik82WUbs8
 2T9l0kVdNdzWkEBZyAQAS9RzWUVSK89lLlZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592372; x=1734197172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWKtId27HRHoTA4nPIebo6hh5rfBC3NImMIXMw+LeI8=;
 b=bfcP0qPvPiFf9c5+SbXV+tFUv8Zpcj2MlX3P+hGESMUeiAfb8xx6VDwpZ/ZaysZX2B
 3b6TXmA1c1+25Il6Z6W/LgGS0siMeugL7oPZNbhQuBtQop9JqiE0xCQs8V88OVe7+9ec
 57WVt31P54pgsoSwPgRI7juWdgXGt5AWlOlhMuW6Tpz4EGx8Zq4UErSqSVvI4LuewExF
 yZtT6nfwWr/DtiS4flB69g9e6TBSQTzsQl5E2BR4KmyfukTD4YLB2ZkxEMoHc8QluPEa
 1zOljAxwXC5bet8wS7KFZwTBjGP9kZJmm32hEVTsqt2VreU5kjiZYX2jMri7RrMtnsYI
 dt1Q==
X-Gm-Message-State: AOJu0YztFUrD7yRR1cAO5bptpIb5DeIht187HKKY4uS6JhyEQMJ3PYcv
 g0Ngw5Vw62F3NigMNdd8gIgMnGN3GNQFL50o39asHLIflCKwy0GYvPYeb62N7ZmwjSXivVc5BH0
 =
X-Gm-Gg: ASbGncsCG1TWQbWwm/+o5SPX2y9anMlETbz9IXhcwQyrLXVYns/tgANYca04BR4ZPHs
 D++pketxe9IGrhlmLK4BjkpCR+vhiUl4Azq9R9ZXZNHD5lN1A2tgE3sJGissmNSvkJ1gZLRcxZ/
 n+qjKlcQJe3MBQw5DWCKoacYaIVBVZGYN5CabmouZkqBeXyyct05nx163C4Ddtdhh2394Nf0Dng
 GNmA05+6TzOBGFkGZHjycLpiHx6AyuFk/6FRHJ3sIaUgT2Ql0NvHmDMN/fQr1Uw25fjSWsydCo3
 Z92ky/e045M=
X-Google-Smtp-Source: AGHT+IGMOQfIu6ebzfBeRXjNEQNZ1C3VUDRy4xys7woDlDG50TUs+ByXX605izsQ1O5iQtvXKOYLTw==
X-Received: by 2002:a05:6602:3417:b0:843:ebf1:16df with SMTP id
 ca18e2360f4ac-8447e3bd09bmr680118739f.10.1733592371901; 
 Sat, 07 Dec 2024 09:26:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/19] boot: Respect the load_op in fit_image_load()
Date: Sat,  7 Dec 2024 10:23:58 -0700
Message-Id: <20241207172412.1124558-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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
2.34.1

