Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A177DE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F898021D;
	Thu, 19 Dec 2024 19:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EXhjAnr+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65348021A; Thu, 19 Dec 2024 19:29:29 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24C580379
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ad272538e8so8253545ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632965; x=1735237765; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWKtId27HRHoTA4nPIebo6hh5rfBC3NImMIXMw+LeI8=;
 b=EXhjAnr+T/rnp3vxawfDvKUjzUab8J4qFIe23yThc2wOsAOnJI+ctVhAESYOf/w+lx
 R3Yo6gS1ccpUuI3pNqrpDpjdETUSZXbIWqFolq6ARC0RbRdD0uGq6tSd/VF3lPRGBND+
 fX2//dDFa8y34EKy687JwhE9dO5/29QGBrvho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632965; x=1735237765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWKtId27HRHoTA4nPIebo6hh5rfBC3NImMIXMw+LeI8=;
 b=NgEN8Urs7NYF005YCi2sEMVPNajySTA+dNAyO5D8Kwy5ugDWkmagT1nzWaYNi9wdNl
 NK4FdGJVanJWUJP/0T2WxmjsBAnKy738eZc0gKF+GU8Op5sK5BT6OH1tyxCZfbSmY8I9
 EiEYsOl57+XU77y7kIISdoWq5kLczfZvxdQV0T5vLdrmV8QPtNjQ6E9t40i0ek3JVNpf
 fSIl/2VyOrfd6CQivdu1wZiagTss1tF1AUj6zHMIbQQpdLVjtMoDe+dgDWvnlB25S/XN
 ZB9HODIS2H9JkwSG3YieAG3o+v3HT/dA+z/tBxliMKb5bexowXOLxtHLGtAgfZliHF8e
 FpAQ==
X-Gm-Message-State: AOJu0YyiT4HSMzxVa8+tySNlf/WvMh9CWK4hIqrvpz2RuZVroqdCyl8I
 Vyj3/wpAIsPWeBnNL89S8/GuSAY+BiwlLecEKJT5LQ31StqEctJwn9TtdNv9go11XYv9dvNoWEc
 =
X-Gm-Gg: ASbGnctN4IgJap1Dv0vSEftlhYmmlkiWi56rEQ0UPx1Q14/nbdlvujKM5zglIygqMzS
 NWE7IIyL/J/V2+7faMZc9dngayoAoVCeY9BgfgI53zsUonNQC8ZKKqculMdusuPeHaSkK5v/m57
 nF4UYEtnUZasf3IvmirNNGLB99BDkmrAjUECgA/F6joqKng3BNXB9V6lr+C2HPPW/3bSYzKKOTE
 aPnaslP4NsHNDQQMjyzbHraEcsQYcK0d8U1Yt/oavh8KX9sKsEf0sjZpTCWq32pOIdV+QHN1qQD
 KRQTb2sH0cvMLgj7Gg==
X-Google-Smtp-Source: AGHT+IEIA8g6Bv+aNuw0LRey/Q0VHCcTGIKYh6KOCglaY+u9kY5SxY+YbHKv+ckn7cDEA3UVaqvpoQ==
X-Received: by 2002:a05:6e02:b4f:b0:3a9:cb4a:842a with SMTP id
 e9e14a558f8ab-3c02ceb248amr43410285ab.5.1734632965634; 
 Thu, 19 Dec 2024 10:29:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/19] boot: Respect the load_op in fit_image_load()
Date: Thu, 19 Dec 2024 11:28:53 -0700
Message-Id: <20241219182907.2609704-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

