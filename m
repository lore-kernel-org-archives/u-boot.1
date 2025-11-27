Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA9DD11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 12:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E75884380;
	Thu, 27 Nov 2025 13:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iM59Ma6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D94888439E; Thu, 27 Nov 2025 13:19:23 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19F68432D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 13:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so8200265e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 04:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764245961; x=1764850761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IEeGi4F/RXJkIKiKaN3bS1TjW7YCT5mEwA/Plsh7GWg=;
 b=iM59Ma6HTa+bWnIVQjdPrTbzs7kMVDEnUEuszaGV1h3etJJeb4Ih5N4PLrpZecDXH3
 2BfIoGz1AQu7p/tnUMIesvpDIf9BuvpZ+PA5t3/pwKpcqp4XQ+WtwC5g1gXL7Q4W+okk
 zbvdlLXmKm0CzQgnBtZuJtzRUTmnfmxCKl6SLOb17MMvvs4C1p+/TX1igkzLpscjth0q
 SCvfXU7Oq3pJ9FYLwqWUjDg8HNVr95v1B2qhoJaJjaCr6Gtd+Ix/KyUwV/E5tpYnjdM3
 VXPscdOCO4vnaUG87FbUT7Ms1/3x7ISXax4YExSRTdtsy0p92SxiHgVba4+ISuF2B7u+
 pQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764245961; x=1764850761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IEeGi4F/RXJkIKiKaN3bS1TjW7YCT5mEwA/Plsh7GWg=;
 b=KI6xE+Yg56w3HbbZQ7+wbdhaQ1x9ivKB2R24a7jGM+66NwFmAH1nFlvhS17Q68SAik
 DF5cMA7lkMHhvx2UZa1wSfurbH8ICZGX2fXhehuWf5IbBGvHC4EyaE/KH7D/G/GaVtt7
 6w9bwvmCWsVoUYTTnZfwHm0RGm0SwhUDTZ5SpAm8OId/UN2H9tLjOE5EgifpvSfmH9CH
 CCtGJ+gznobevpBbbfbUrCQ5N9WOtaLzlxsTOTjvFlWpeCwaYWUOcWPnXMLQrLdJydbP
 RB+MdC25DQ/mJBe34tajB7QWQQ6TIXg9frrdVLS1BA7AsI8mVpXGC+9fBbkNrvLoj7ma
 5nyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxmw6Byhs8qpblCpWdROH1iqgkp/yvL+1PPupIScragPUBzx28mOlSoKm14PdivJv6TrVfj0E=@lists.denx.de
X-Gm-Message-State: AOJu0YxjwN35mdFEejmoBYOH7X/9ovx33qFosJYO2o4LgTtmG6KOnpVC
 BvdyHQaiaoGxhPmA7gpn++EbN/Oam9r/NPhD5p0+dl6jYRP3MPyD835wrYrzDXgaz70=
X-Gm-Gg: ASbGncujn3UR8eJ9Kth9kyyGUm3AYZ6wNGRkOiicG3n9n7Z6PGMaPpnQZHybXNgZoAE
 58PBPt9C26lrfF3INMNCTLwbYVApaOnyfmZ75kS5p7BXkHDZvs6FNItnPD9pkqQQg4P+OfsPrcy
 rV6jFAq6gLlm94rG8kfjwltk43JBgsynbVlT1BP6Vmc/MLIdVUbpSafwJgF7rkNcKb7tvUT4MRc
 cH+Rjg/k6VcT8wCDS4yGLOPL18fP6DX11LnVOcOnovDa86mZvyW2wtxKVYDda7GYwN7l/RQEDHH
 u9ud2CB4tvGUAye8o8sWu7X/F9vewA4MJgXgtnETSlpJM4cEdNbrM5AeTB3bRXeQMtOq0/JlfjU
 cMFxduuX4qZv6ZFJH1fUDfohLJMkWf+OBPyGItI0JDXrpXv4XJtkjIbaAs6DCoNgPAVQ4DXeEQR
 juCUpKcTpxd5JFc7rHiHMum1Ol3kwJAthelrZBDXt7sKh1WEE9ZuouoZSzKWOMH/WPy54oSA==
X-Google-Smtp-Source: AGHT+IGGdh1vnoDmJUvIOIwo1x+cG7+zC3jagQpyGnrGqCtlyfQB7ENyfwYVzOtfYTAugOGRo8KfLw==
X-Received: by 2002:a05:600c:5489:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-477c112400amr209473245e9.26.1764245959561; 
 Thu, 27 Nov 2025 04:19:19 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751061e60sm1474451a12.32.2025.11.27.04.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 04:19:17 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Fix a memory leak when retrieving device paths
 from boot vars
Date: Thu, 27 Nov 2025 14:19:06 +0200
Message-ID: <20251127121907.1104650-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

get_dp_device() is used to derive the device path from a boot variable.
However, if the last efi_get_variable_int() call fails, we return an
error without freeing 'buf'.

There's no need to call efi_get_variable_int() for variables we don't
know the size since we have the efi_get_var() wrapper.

Replace that in the two instances we use it. The first one will also
fix the memory leak.
A nice sideeffect is that the code size is also reduced, since we are
re-using functions instead of open coding them

$~ bloat-o-meter u-boot u-boot.new
add/remove: 0/0 grow/shrink: 1/2 up/down: 6/-196 (-190)
Function                                     old     new   delta
version_string                                70      76      +6
efi_launch_capsules                         2288    2196     -92
get_dp_device                                244     140    -104
Total: Before=1222331, After=1222141, chg -0.02%

Fixes: c74cd8bd08d1 ("efi_loader: capsule: add capsule_on_disk support")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 31b47a20186e..eafc647f558f 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -857,18 +857,9 @@ static efi_status_t get_dp_device(u16 *boot_var,
 	struct efi_device_path *file_dp;
 	efi_status_t ret;

-	size = 0;
-	ret = efi_get_variable_int(boot_var, &efi_global_variable_guid,
-				   NULL, &size, NULL, NULL);
-	if (ret == EFI_BUFFER_TOO_SMALL) {
-		buf = malloc(size);
-		if (!buf)
-			return EFI_OUT_OF_RESOURCES;
-		ret = efi_get_variable_int(boot_var, &efi_global_variable_guid,
-					   NULL, &size, buf, NULL);
-	}
-	if (ret != EFI_SUCCESS)
-		return ret;
+	buf = efi_get_var(boot_var, &efi_global_variable_guid, &size);
+	if (!buf)
+		return EFI_NOT_FOUND;

 	efi_deserialize_load_option(&lo, buf, &size);

@@ -960,22 +951,11 @@ static efi_status_t find_boot_device(void)

 skip:
 	/* find active boot device in BootOrder */
-	size = 0;
-	ret = efi_get_variable_int(u"BootOrder", &efi_global_variable_guid,
-				   NULL, &size, NULL, NULL);
-	if (ret == EFI_BUFFER_TOO_SMALL) {
-		boot_order = malloc(size);
-		if (!boot_order) {
-			ret = EFI_OUT_OF_RESOURCES;
-			goto out;
-		}
-
-		ret = efi_get_variable_int(u"BootOrder",
-					   &efi_global_variable_guid,
-					   NULL, &size, boot_order, NULL);
-	}
-	if (ret != EFI_SUCCESS)
+	boot_order = efi_get_var(u"BootOrder", &efi_global_variable_guid, &size);
+	if (!boot_order) {
+		ret = EFI_NOT_FOUND;
 		goto out;
+	}

 	/* check in higher order */
 	num = size / sizeof(u16);
--
2.43.0

