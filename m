Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E3DD6ACE6
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238C483D90;
	Thu, 18 Dec 2025 12:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ADxTlezV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B03F83D7D; Thu, 18 Dec 2025 12:17:10 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6483083D5D
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so3205675e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766056628; x=1766661428;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iOS1PwKT5itepea3GYG5T44wIDCrH7yebLi8XT5FfD0=;
 b=ADxTlezV/LfbfZw4O7Q10mzSpin0ISSok7Bjn1Fhdi1LatZiLeLAEMdDgKXAybur92
 iUyJKKOJQC0PqbQQcx1NsfjBdlV+CbEi8dvfHMKuPMCfp1l57L9U0QHiY+ic0IAV4xVd
 U8F6Y7rFYwFkCMS5el6rbRJzl3XF2u8a+Y7s/y/MAewZArtVwG49akJPU9STm+cpuqs6
 S9uh+Uws76D1FfLYtl/3+ZfWl00sLOeOhCRjH2lmJnffkXa+NvG2DWdyPNeAPlLKKyWM
 XnaqEx2sx3+WE5fY3xhBdoNBrPYqweLAGFThwOJlE6+lL+7EfG7YSBXi0KLKiC8Ibw0m
 w/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766056628; x=1766661428;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iOS1PwKT5itepea3GYG5T44wIDCrH7yebLi8XT5FfD0=;
 b=GZ4BKwTEDrnt+V2SS3WsZa8qANUmivPadiXvBROUOxsBSWK8VYmXZ0T3MjV1dbLdtd
 JY77Asht/nv0lwaNB1Fi7EyzDanStoz8QsEVM06f61froZXdTERXmNPR0CeQbi5og2ul
 A8aZWNl++OpVhyd5rrOIXtaHF6udojLeZVOd5nk+WwL8mEukz6V+O7LidGOhVvU6Xxl+
 NorbmaPSTqaIFs08Ifw29f0wbwbgi6/XKnpg0nkMaYQygD1GWQm8vzB2Q16Wg8Jct9Rm
 10BrDTcmbYO6CDt841V4NcVCpYkId7CABENif5nDgE84/Ceq+RGa0oT2SPu9ickKEJrq
 b8Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO83BbNuKuTiRqDD3G2R9r75eoBYCr3XVJdY+FIV/JDj4UqbgcG1IpGlmYMcctQeyvySluaTU=@lists.denx.de
X-Gm-Message-State: AOJu0YyB7sT+n05nZzLqGb8P7YxcZNCAvpcPAZE3K+zzctDNXrMrc2JP
 5eiQavXKKl2GSuvHB5Pz2SoflXb4y1WAe0n+gbSSPe9D85sUKmAgmREFz4WvfIdYMWk=
X-Gm-Gg: AY/fxX5LrRlmx+HBE7nf+eGttfcprNMUE835zvjPUUkIhWNKmE8Mva88x7vgQNSv7up
 j15BAhv6ONujRoILuoJUKwN8DEp7EwJwcGryfAMpzNODFOfFW3nIhW0GP8/ChTc+lnYke5+WBJt
 I2MkEFa/rh4xja28DIVWbCy/AU+nwepZreAlx/1+i4DM7fqLZ0jagVEmPR9S2kYDeaSy0HnnU4z
 b4G0MnTFgCQ5nmkOg0WGR8xlutUILSsuxMeuoc4w7YmknQneqCr1DQLqeBBEQhJFzZ5itQNZJzD
 OBHxjPPbEBKZn+E2TnSQcnkSDoWanzxiXw7Z9D2piYEpwznMo6NPMjVeChl5cdBJNnGoqZWWKcn
 iV1XVXxfCJGmTd4xAnTiSy9LoqdE/4p/U0sQBVluU8faXQ5ub/1l66rn0MYQPRpPPqwBl/FLOA9
 IiQtBBTKEM5Y9/Mw==
X-Google-Smtp-Source: AGHT+IFGZZ3qkyY5bzjETN8XtTIR8qE64bReFNxqwQl07vmnJEJzQd/brWMMiAkS8UsJ5c/7G8WYfg==
X-Received: by 2002:a05:600c:8b71:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-47a8f90dc36mr213442365e9.30.1766056627748; 
 Thu, 18 Dec 2025 03:17:07 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:3734:1277:36b8:3f57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm38070965e9.7.2025.12.18.03.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 03:17:07 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Thu, 18 Dec 2025 12:16:56 +0100
Subject: [PATCH v4 1/5] boot: android: import addBootConfigParameters()
 from AOSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-bootconfig-v4-1-5bbbdb0be1dc@baylibre.com>
References: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
In-Reply-To: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.3
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

From: "Mattijs Korpershoek (TI.com)" <mkorpershoek@kernel.org>

To properly implement Android boot image v4, U-Boot must be able to
add additional entries to the bootconfig.

Add `add_bootconfig_parameters()` to do so.

This has been imported from Google's U-Boot source[1]
The variables/function names have been reworked to be
compliant with U-Boot's coding style.

[1] https://android.googlesource.com/platform/external/u-boot/+/7af0a0506d4de6f5ea147d10fb0664a8af07d326

Signed-off-by: Mattijs Korpershoek (TI.com) <mkorpershoek@kernel.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 boot/image-android.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index e46dee0d9b3..877cd39fbef 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -57,6 +57,46 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+/*
+ * Add a string of boot config parameters to memory appended by the trailer.
+ * NOTE: This function expects bootconfig_start_addr to be already mapped.
+ *       It works directly with the mapped pointer, not a physical address.
+ */
+static long add_bootconfig_parameters(char *params, long params_len,
+				      ulong bootconfig_start_addr, u32 bootconfig_size)
+{
+	long applied_bytes = 0;
+	long new_size = 0;
+	ulong end;
+
+	if (!params || !bootconfig_start_addr)
+		return -EINVAL;
+
+	if (params_len == 0)
+		return 0;
+
+	end = bootconfig_start_addr + bootconfig_size;
+
+	if (is_trailer_present(end)) {
+		end -= BOOTCONFIG_TRAILER_SIZE;
+		applied_bytes -= BOOTCONFIG_TRAILER_SIZE;
+		memcpy(&new_size, (void *)end, BOOTCONFIG_SIZE_SIZE);
+	} else {
+		/*
+		 * When no trailer is present, the bootconfig_size includes the actual content.
+		 * We should write new parameters right after the existing content.
+		 */
+		end = bootconfig_start_addr + bootconfig_size;
+		new_size = bootconfig_size;
+	}
+
+	memcpy((void *)end, params, params_len);
+	applied_bytes += params_len;
+	applied_bytes += add_trailer(bootconfig_start_addr,
+				     bootconfig_size + applied_bytes);
+	return applied_bytes;
+}
+
 __weak ulong get_avendor_bootimg_addr(void)
 {
 	return -1;

-- 
2.34.1

