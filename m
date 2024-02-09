Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F911C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF18F87E89;
	Fri,  9 Feb 2024 20:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="T3eczxfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CDB87E9E; Fri,  9 Feb 2024 20:21:07 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A70A87E8C
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3be9edf370so132732066b.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506464; x=1708111264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJuZ0JVM1DysdEgoxc8OdPkoqRLE4LUcg4sgmpzGRMs=;
 b=T3eczxfkvIG40c6h/dqMI5pvOBuuc74goDDMltFYZqz+tT1ZiZ0UWFzZzULmp0I7EO
 JO66cydaE6CxyfEkGFXZya7UchOpMoj9rRWdAxxWW6FQ1mexR78S8mUqeL+OTPAvJDjN
 tZjYx09mwdsDlyadx22di3sMU3Wno/rKhzIxilVcyL8DU35gENYq/56qzJpbdSkRFqBS
 sRJ6vVJ2YEOIeZlBLkhm41AAgLiey5I3EMpAs5eRGdyZT311vPrdZuVSDz5S0UscjSr3
 oDyR/aCify3maxdt1MD0dzyC/xLaQGmKjoyVXH5UvFQ5HvCLvKeU8X94O9VcWecyU/sh
 Bw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506464; x=1708111264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJuZ0JVM1DysdEgoxc8OdPkoqRLE4LUcg4sgmpzGRMs=;
 b=ZaZjI/+qNVLxSLzv+s8HShj69ZjuorEHOT6kTR0CToEAEmma9QBuaYWkHaAAxhI0z5
 rrDGaol7WsMiVsjHShQOex+xHJPQjTxHFNX8nS/R9C6df2f0zKUtb0ESsA34tYyppD6P
 YKeQ6FT5JnPkssqjdUBPGHec8DC8TtdWpM4q9MJEvkKhq0TGsYV3N050zbPP6n3SII2o
 TeuRBsnFz8IdoDhyLEOM5J9qiKrBxMbSGJJFT3xx2BdSVM35O8ejks91OEoBVwvB3dLR
 u/tpoSuWccMIw93LSFATef5+wIbFb+USUPQcXvCYx9DJiE1FM6tVLO8Ya71/l1Tqt052
 azgw==
X-Gm-Message-State: AOJu0YyUIbVDG1aLi0GhqS7oe+AinR5cREp7V+bBqdfNcrsUp8q6JTz2
 UwUJM6+v5YwD1a/Hygz6yvP3FZpp/ENMVRTmmwd3DyMyRRVwP35djobJJp6ydfyPyEcXFynXka8
 STEA=
X-Google-Smtp-Source: AGHT+IHG0mXmH8+vnOc5m2Xjxi+cIy/uST0aNNxbzApCptIElR8+XPt8lsfqCdWwQGS/GAqlqvBO1Q==
X-Received: by 2002:a17:906:4691:b0:a3b:b259:aeab with SMTP id
 a17-20020a170906469100b00a3bb259aeabmr29727ejr.25.1707506464205; 
 Fri, 09 Feb 2024 11:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVwSOfQsZzRDXt2Pw7vir/EWsaireH3xFCmJWt4THVv7aEL+2mRBRXdz1vSdD49EIKhECc4tettMxtDN9OVD9O+RUrVfRVAVfuOmBpjM6Sx98RWpSNdm13lA7z6YGoB6fmI9b9XKHa6zGXr4lQIPpP+JR6eOSq3Cf8ZaAqyg2CB7LCNbJgtcKhQnVKi9UtLw8U=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 ps2-20020a170906bf4200b00a39e0196eecsm1040361ejb.26.2024.02.09.11.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:21:03 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/7] common: avb_verify: add
 str_avb_io_error/str_avb_slot_error
Date: Fri,  9 Feb 2024 20:20:43 +0100
Message-Id: <20240209192045.3961832-6-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Introduce str_avb_io_error() and str_avb_slot_error() functions,
that provide a pointer to AVB runtime error message.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Mattijs Korpershoek R-b tag applied

 common/avb_verify.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h |  3 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index ed58239cf8a..cff9117d92f 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -119,6 +119,55 @@ static const unsigned char avb_root_pub[1032] = {
 	0xd8, 0x7e,
 };
 
+const char *str_avb_io_error(AvbIOResult res)
+{
+	switch (res) {
+	case AVB_IO_RESULT_OK:
+		return "Requested operation was successful";
+	case AVB_IO_RESULT_ERROR_IO:
+		return "Underlying hardware encountered an I/O error";
+	case AVB_IO_RESULT_ERROR_OOM:
+		return "Unable to allocate memory";
+	case AVB_IO_RESULT_ERROR_NO_SUCH_PARTITION:
+		return "Requested partition does not exist";
+	case AVB_IO_RESULT_ERROR_RANGE_OUTSIDE_PARTITION:
+		return "Bytes requested is outside the range of partition";
+	case AVB_IO_RESULT_ERROR_NO_SUCH_VALUE:
+		return "Named persistent value does not exist";
+	case AVB_IO_RESULT_ERROR_INVALID_VALUE_SIZE:
+		return "Named persistent value size is not supported";
+	case AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE:
+		return "Buffer is too small for the requested operation";
+	default:
+		return "Unknown AVB error";
+	}
+}
+
+const char *str_avb_slot_error(AvbSlotVerifyResult res)
+{
+	switch (res) {
+	case AVB_SLOT_VERIFY_RESULT_OK:
+		return "Verification passed successfully";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
+		return "Allocation of memory failed";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
+		return "I/O error occurred while trying to load data";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
+		return "Digest didn't match or signature checks failed";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
+		return "Rollback index is less than its stored value";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
+		return "Public keys are not accepted";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA:
+		return "Metadata is invalid or inconsistent";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
+		return "Metadata requires a newer version of libavb";
+	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT:
+		return "Invalid arguments are used";
+	default:
+		return "Unknown AVB slot verification error";
+	}
+}
 /**
  * ============================================================================
  * Boot states support (GREEN, YELLOW, ORANGE, RED) and dm_verity
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 2fb850044d9..5d998b5a302 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -52,7 +52,8 @@ char *avb_set_enforce_verity(const char *cmdline);
 char *avb_set_ignore_corruption(const char *cmdline);
 
 char *append_cmd_line(char *cmdline_orig, char *cmdline_new);
-
+const char *str_avb_io_error(AvbIOResult res);
+const char *str_avb_slot_error(AvbSlotVerifyResult res);
 /**
  * ============================================================================
  * I/O helper inline functions
-- 
2.34.1

