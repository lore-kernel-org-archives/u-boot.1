Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040CDD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BFA893D1;
	Sun,  1 Dec 2024 16:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l/GPX+kd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3F7893D1; Sun,  1 Dec 2024 16:28:32 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E14888D51
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so110621639f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066904; x=1733671704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9WHgj75TRTYlOQ+pj2tKOmuXZbrHisJ8eTqWmQBhbU=;
 b=l/GPX+kdvZ/K/vOOyBYgy//VPrh/DcvIf4xuNDEr3sxHudZ6y2UeD8ipHn4X1m4CK+
 Q5DpvgExFBHn8YcYgjqr02Jv557Y6pSPmbwet84Ps4sI48dxWwTlEBajlD/B2XIQBS/w
 NDSjNO+Z/K9TdQDtbepLKLhyx3JYYD0NiC9Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066904; x=1733671704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9WHgj75TRTYlOQ+pj2tKOmuXZbrHisJ8eTqWmQBhbU=;
 b=f+msm11ndcZtOIgCANmG/DazbdufEHSbZljaPk49jwmllReAlQNaRT/r2QBou+mjqI
 TfPaAAhvZx4v71+mtgLQH0h3AiHuv01+fZGgerXnjg2MZjfpT4/S+FGXubKZ97ry7X4f
 Ee5SqW0clfnE9DGWQKb6Vc/NWcXUd44h6+sZuZAL0/Rq07HDvsBLjs3sLK73HYUhl4cl
 pEM//1S7O9MrDKLz3RNd3ISeh4vr5tryACDLVkYgd5R9eql4JgcMAu6e6WGlBT+1rNUM
 DhaRS/itcMMHA36LJWdnfFkLafTsBOVFMkY31Mlkt7x7o3GaeoS5NWVbBIGQ/zFCuS6r
 wQ7g==
X-Gm-Message-State: AOJu0YzRLONx3IssgqjUk9aSUVEn16z/HO0qtFpF9l+aqGFZZKzl8jWw
 3/TOiZJzAQGVJvmpqa+om+JRGsml2G3+hyFY4njg2+lQ7Lrhkk15o2bmkeG4JD+8NCQ3Gsir704
 =
X-Gm-Gg: ASbGncsauX5UKZ9fNreqrFzBf5FsFfyEErhqtsNAEaH3QuZe4r8PpCGebmpVIN9nZvG
 cC3AYuwYI16CmY1ju+Tx0I0xpRNEAP1hKEpXssjWKuFfKWtax2PnJu2idmdPwTd8dc+6m6B01PI
 y4tQNpuXy4kDaP5qSZRlHshREyRR+9b0Qwr6jwN8qAhysTFFlLEc2U4RrhvhgB7/b7Nxy0YCDIa
 RwL/yRD2fxf6n+eUuLpHdLWlxI88B+nwNgTWKXH3v1/
X-Google-Smtp-Source: AGHT+IGfGgI0B0q1lUV1/OEf6KVk0H6+2xbKuG5Rvm6YrpgEIamRVO+ozNjTliNLUwhJq4KmfMJ3Lg==
X-Received: by 2002:a5e:8709:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-844015af3d5mr1206413639f.5.1733066904670; 
 Sun, 01 Dec 2024 07:28:24 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v5 2/9] efi: Disable secure boot in bootflow_efi() test
Date: Sun,  1 Dec 2024 08:28:04 -0700
Message-ID: <20241201152815.1668093-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

This does not support secure boot so far, but if a previous test has
enabled it, it will remain enabled, thus causing this test to fail with:

   efi_load_pe() Image not authenticated

Fix this by providing a way to disable secure boot in tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi_loader.h            | 12 ++++++++++++
 lib/efi_loader/efi_var_common.c |  5 +++++
 test/boot/bootflow.c            |  1 +
 3 files changed, 18 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 1269907fa3c..a67d3827812 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1117,6 +1117,18 @@ struct efi_signature_store *efi_sigstore_parse_sigdb(u16 *name);
 
 bool efi_secure_boot_enabled(void);
 
+/**
+ * efi_set_secure_boot_enabled - set whether secure boot is enabled or not
+ *
+ * This should be only be used in tests.
+ *
+ * TODO(sjg@chromium.org): Consider how we can reinit the EFI state without
+ * restarting U-Boot
+ *
+ * @enable: true to enable, false to disable
+ */
+void efi_set_secure_boot_enabled(bool enable);
+
 bool efi_capsule_auth_enabled(void);
 
 void *efi_prepare_aligned_image(void *efi, u64 *efi_size);
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index ea8d2a4cf98..0f0e6e8d792 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -362,6 +362,11 @@ bool efi_secure_boot_enabled(void)
 	return efi_secure_boot;
 }
 
+void efi_set_secure_boot_enabled(bool enable)
+{
+	efi_secure_boot = enable;
+}
+
 enum efi_auth_var_type efi_auth_var_get_type(const u16 *name,
 					     const efi_guid_t *guid)
 {
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index da713d8ed72..f64d91e0d64 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1230,6 +1230,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 	struct udevice *bootstd;
 	const char **old_order;
 
+	efi_set_secure_boot_enabled(false);
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
-- 
2.43.0

