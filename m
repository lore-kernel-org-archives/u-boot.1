Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F167EC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 08:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 635228801A;
	Wed, 10 Jul 2024 10:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T3y+QaP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B606886EE; Wed, 10 Jul 2024 10:40:21 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D58F88703
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 10:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52ea3e499b1so5961578e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720600818; x=1721205618;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qrfRLpkQWFKy4DzZNCz1PQOZcVkuPSBwKo//dBg/If8=;
 b=T3y+QaP64q7jOnoGTkkJM8E8zdzs7FfSQcOz2cW8bAuomDonZ68EAldSV/y2dhcKXr
 S9HrNC6lxJlETJcuoc8nuiRInESoX3DgcxGIjOJFKbRE/evJGKlhWxG/pAN2sdf2McvL
 y7xF+yF4l3XRe9iUpNmPIlNFsUQzcf+C72CA7SvbxyfzXo6DouZQHy9HJP3GgYb9DMC0
 QvwdJC2/BzbdEQnxJEg6enE29VV8gYbYLeYQz1417IWkXvC7dkhfILwRTMB9Jt8zlqyg
 MJ5YpXpdd4pD4W5L8XwgdnQkuAv7Z71FtSgKmXIUDYSvPbpB9fdYoYoFmFN28SKQ/CrF
 la5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720600818; x=1721205618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrfRLpkQWFKy4DzZNCz1PQOZcVkuPSBwKo//dBg/If8=;
 b=NuBCwjsStotXrXvyfoyLPLiUhjJeiagRRpjyZKu7j+EkhVt0DKfAz3rNpFfpOIfase
 zW2vKN2scsFzLGcMFaQU0ZvTD2T2Dcyr/cwhtw9asJHgudSVgkTeWfncUHMbv0nVEpzO
 lyD9wR6m33KBbarIp5J+3kZRWLs8KjPmhEDya133XtSsaj3Psk99Ywh/xXSr0T8Q6n4B
 B2jiyfTO5x/YborSUWTs+LlV5LPXDqUnnegudfawQC4bAwLs81EzjDVfGBEcm0ZX0F5v
 4YOzlniwQ7GHk9GT2QzjC/uCUUKet+F6BK4Is8GO3dUb8Ztfey23BxYrIW/6odgE3Gsx
 0Q4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoLtbdmFsk4bpIM+JG3CqjDg5oZYLnee7tuMZUvizSVKIBkDZrRBUjQlfFlkldU8q4wvtiti9X/WGpS3TDxdcj+/8Pow==
X-Gm-Message-State: AOJu0YyXyaxZzFgBpCoWADa5DOI82E28+FqVX8DBrwYQu3OUS2u8yxpM
 WZsvCIKR+QmaXnpCRFuwa9qyOmjvuSmkK/dTmeuB/Gs6fggNyh+hNOv9n5lFcq0enTZs5hwwPZk
 x
X-Google-Smtp-Source: AGHT+IGcz7F+Hkaz16Ddzih/9CDJLRgAus8vvW+8JUmvGyPkvwFDzXhwe3LXfDcBUeJm0eL14o29hA==
X-Received: by 2002:a05:6512:3d21:b0:52c:ddc0:7a03 with SMTP id
 2adb3069b0e04-52eb99d1feamr3454055e87.55.1720600818359; 
 Wed, 10 Jul 2024 01:40:18 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm39994945e9.20.2024.07.10.01.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:40:17 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 10 Jul 2024 10:40:04 +0200
Subject: [PATCH v3 3/5] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bootmeth-android-v3-3-b99406e22da3@baylibre.com>
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

The only way to configure the load addresses for both bootimg and
vendor_bootimg is by using the "abootimg" command.
If we want to use the C API, there is no equivalent.

Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
specify the load address from C.

This can be useful for implementing an Android bootmethod.

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Reviewed-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/abootimg.c  | 10 ++++++++++
 include/image.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 327712a536c0..ae7a1a7c83b0 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -22,6 +22,11 @@ ulong get_abootimg_addr(void)
 	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
 }
 
+void set_abootimg_addr(ulong addr)
+{
+	_abootimg_addr = addr;
+}
+
 ulong get_ainit_bootimg_addr(void)
 {
 	return _ainit_bootimg_addr;
@@ -32,6 +37,11 @@ ulong get_avendor_bootimg_addr(void)
 	return _avendor_bootimg_addr;
 }
 
+void set_avendor_bootimg_addr(ulong addr)
+{
+	_avendor_bootimg_addr = addr;
+}
+
 static int abootimg_get_ver(int argc, char *const argv[])
 {
 	const struct andr_boot_img_hdr_v0 *hdr;
diff --git a/include/image.h b/include/image.h
index 9daaee15cdbb..dd4042d1bd90 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1971,6 +1971,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
  */
 ulong get_abootimg_addr(void);
 
+/**
+ * set_abootimg_addr() - Set Android boot image address
+ *
+ * Return: no returned results
+ */
+void set_abootimg_addr(ulong addr);
+
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
  *
@@ -1985,6 +1992,13 @@ ulong get_ainit_bootimg_addr(void);
  */
 ulong get_avendor_bootimg_addr(void);
 
+/**
+ * set_abootimg_addr() - Set Android vendor boot image address
+ *
+ * Return: no returned results
+ */
+void set_avendor_bootimg_addr(ulong addr);
+
 /**
  * board_fit_config_name_match() - Check for a matching board name
  *

-- 
2.45.2

