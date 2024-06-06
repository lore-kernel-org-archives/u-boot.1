Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91E2C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E098E8844E;
	Thu,  6 Jun 2024 14:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CV2WizCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0A98844F; Thu,  6 Jun 2024 14:24:21 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D925A883E3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4215fc19abfso3446325e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717676659; x=1718281459;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ap5zzJ2Sgv957PGodavnNyWyvD86GtmSBBet7PiftZo=;
 b=CV2WizCjkdv1O849JQxbHckCaDXwNBIvRnl8jCKcU3km/V1v88sWBjxLp7qQvck1nm
 T1Cm8YrkakSDyEtkqKJQXLpX37DM1tW8mD79bjMHg5+/o0ZxeIlM8qIeKZ6eZ+1szO1o
 xtpojSjeqiI+Lyr5S9H9jSFl074EY1St6pMJQNJUNSAll2dQIjdGrJRmArBCNJ13BUmn
 VmhDO8sewW5z7zyiF4anqeb3rSXORla8PMhwRdf1CVdX+5BSEEs2mrgMAYdsaMOPnsIV
 xPRpUua2ULCN89x3t0wpz+sfgL5IZih2gsmeSFQgh8CXQgIVT7VdHywetQlyaPo7PGnM
 DhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676659; x=1718281459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ap5zzJ2Sgv957PGodavnNyWyvD86GtmSBBet7PiftZo=;
 b=f1IX6uEpDiiNlhf5E/DNgib2RcySkn8jrjQ/cGpUJSQkPLoQiIHLHrIXeZXSZN2GFA
 fD2II5e5ab65ZzimFU4dd5Ac+UMeBQ7rXs8nwH8C8J07TqQbHTE8ce7N7NF2S33xV8lq
 9yuEFgIzBkzKZAjYY/IIwyg6NBa0Y9keEOXRrUDbIs+59ppBYEHx3gOx598gs9/ufmMP
 2v8NSxVGZja3DtGP4eYBcFa+qYYz57dgpT5dLtJ1Q0qOXOpT/45CdYZCVSEdHhnFmQRx
 UgLUxogj+WNXni4sbOm16U1LSTgsDNWaRNtQrgPInm+JSFRZ1XQiD/IsE4vIb0uUOkQX
 bE5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVycLhrEAbKiSJNIDj0ld1nKuMHPLkszv1DS1rXfJSBIRz+UGNikmNL3CqfL7XVLKtBvv7/6a8dO8jtYgb3lzXeUFiWeQ==
X-Gm-Message-State: AOJu0Yz1RwvYq6hDO62Sywo68V+Z+m2r039mcPULFdhNCS/516e7dH0F
 fQn+6zJNptPiml5yT6xE4IgPm6Z6cI7BGhd5LDrW0m3QmEZ3AOvLTDOLyLPcXRM=
X-Google-Smtp-Source: AGHT+IHVsSE+wsT535a7q8Nk+7/qIl1XBnO2SlCukJAIX5h7tSVNLSjVHhRUJEDscelxAU8nVaqp/Q==
X-Received: by 2002:a05:600c:350b:b0:421:2df2:2850 with SMTP id
 5b1f17b1804b1-4215632dd10mr50716015e9.31.1717676659316; 
 Thu, 06 Jun 2024 05:24:19 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm1432828f8f.50.2024.06.06.05.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:18 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 06 Jun 2024 14:23:56 +0200
Subject: [PATCH 4/6] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-bootmeth-android-v1-4-0c69d4457cc5@baylibre.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/abootimg.c  | 10 ++++++++++
 include/image.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 88c77d999290..33381e22dec2 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -21,11 +21,21 @@ ulong get_abootimg_addr(void)
 	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
 }
 
+void set_abootimg_addr(ulong addr)
+{
+	_abootimg_addr = addr;
+}
+
 ulong get_avendor_bootimg_addr(void)
 {
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
index 18e5ced5ab42..6deaf406605e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1977,6 +1977,13 @@ u32 android_image_get_version(const void *hdr);
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
  * get_avendor_bootimg_addr() - Get Android vendor boot image address
  *
@@ -1984,6 +1991,13 @@ ulong get_abootimg_addr(void);
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
2.45.0

