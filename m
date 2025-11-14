Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41ECECE8D46
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20413838A0;
	Fri, 14 Nov 2025 16:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tOJrxJj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB31B8415B; Fri, 14 Nov 2025 16:28:46 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7697D833C6
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so23680805e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763134124; x=1763738924;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V6/EjzcWJ88grP5ipECyyG+wqeUHFJr1EI6kwGnrniI=;
 b=tOJrxJj/IE8aD119ZmvsuPRedkciGNM8D3UUGCb0r3ULIaMp6BYj/tue1gVZ4wzF/a
 RZHWIeXCm/HxlsPGbgcAFGLTe7fGtqHTVxYJRJkcFYIWMXfbs+KkBKs2JqnqePGQq/l0
 7dS9cqgT8ZPE1sehFlanDVlJ4kab6QQZ7SCsPbzOiORUp1h+gmJyQf8SKpnhsG+uaexI
 34Ys6C5BPohrCbI8EDW9NC+U8VB81QhiOwHTIyJEvLkKjXPDjD5BfZ3U5nipP312KxBG
 9XBNqVfTZ2FojHUnF+z0zUZSQUOZ5FTSxAWUoldlQ6AFuVZoO1OZG9Z0pjykdBkhrWCw
 c/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134124; x=1763738924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V6/EjzcWJ88grP5ipECyyG+wqeUHFJr1EI6kwGnrniI=;
 b=j35MNAiQk/hI45xPJ5p3hwc0ak+tDqDyrlEoPZfkSqL5Q+joir1mB2y6m2PPFgJ7Ik
 fMpGErCjqxsZiJWE0mqCgfUJaR2ZS1OSeDn0/s2v3NocAz4PcLsxHRhhwDT1EjbEQl9X
 B4DLIFhizohBlKMXU7/vGFHFKKT8AtclhkaSrCU7qx539aZ9ehpQ4M9BoCQ663A7rrT1
 uJ7AJPX6OW41qSp3B5XpXaqkSxM0Rnij292IoiHFj8RCVHN79RZlUgToXn0dfRljheUo
 +7rTq/QDRJXLPl6j8E62RPA59V3TGiF2gG5SizdaiIJYjoZUBhCv2LcEZXq9hAnhaSH6
 aq0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3yAmY8lRldyzdplC6jIy1q/I8wPgRWYyXoTUtuM6mgj8WmpRX48lvd/8hoXE+snZDaJSlITU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4un5i+tDUkPdeBcH18LyuqYPHOgtzTYXNuMyaZc5w2vrfucUI
 h0jGuhm1WcVgIFwjsaA4gIpiNNDgWRgpVVMOAXGQq8E94p9CE//XOcNDhOpMTG7cc7I=
X-Gm-Gg: ASbGncvLs2G854aQYJ3MjyRgDXaA9cD1fBSJ5SUvnKqSJ2pAo6NNoBtFFlXy6KkDE2S
 zDlDcXy9t24XQfFgO3bnOc5iavvvIRdYqokEMtxXfr+xj3Kmp2yGZK96NSqCg4IUDJLTDHJWXsb
 vGdZ6YI0n854uWURSdw2+9Nxk5w5ywChQvvwIcSR/nJMuvuqdmtbcGtyP3MDKtBVjd0yZr1+C59
 FpXlJNfc0GCYnpGlMhOXKvgPuFXQL2lbJXm7kHUV2pLfmTvh5U9ax04UWZJB/BWvghfzSBsoUwV
 b7uPJsQ7KpUz2HjWo+FI6bEzbgX0fqvXJEO4dFP1bWfOu48ov4oBZZf+Uay93gQT8RpkPIHPBwr
 TKe8c9A4pZH65LGnSZEeVYAgJD93Vs/jWE58tM7yf9ZrW4d0BGl1KRBU9UUNI2RUQZ+W4WIWR58
 EkVnEm8uAxamU1
X-Google-Smtp-Source: AGHT+IFWQkwPis2rX/pzXhQEHIf5s1T5xc65osNbrCN1wb2phtYBjW2ElZCHzlWihmXxnNbJDdH//g==
X-Received: by 2002:a05:600c:4752:b0:477:7b30:a6fe with SMTP id
 5b1f17b1804b1-4778fe6391amr30708525e9.18.1763134123891; 
 Fri, 14 Nov 2025 07:28:43 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:1ab:5fd8:dd9b:8e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779524d2ffsm15741035e9.3.2025.11.14.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:28:43 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Fri, 14 Nov 2025 16:28:40 +0100
Subject: [PATCH v3 1/5] boot: android: import addBootConfigParameters()
 from AOSP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bootconfig-v3-1-a28b813dba90@baylibre.com>
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>
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
 boot/image-android.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index e46dee0d9b3..3a0a934acc7 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -57,6 +57,44 @@ static ulong add_trailer(ulong bootconfig_start_addr, ulong bootconfig_size)
 	return BOOTCONFIG_TRAILER_SIZE;
 }
 
+/*
+ * Add a string of boot config parameters to memory appended by the trailer.
+ * NOTE: This function expects bootconfig_start_addr to be already mapped.
+ *       It works directly with the mapped pointer, not a physical address.
+ */
+u32 add_bootconfig_parameters(char *params, ulong params_size,
+			      ulong bootconfig_start_addr, u32 bootconfig_size)
+{
+	if (!params || !bootconfig_start_addr)
+		return -1;
+
+	if (params_size == 0)
+		return 0;
+
+	u32 applied_bytes = 0;
+	u32 new_size = 0;
+	ulong end = bootconfig_start_addr + bootconfig_size;
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
+	memcpy((void *)end, params, params_size);
+	applied_bytes += params_size;
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

