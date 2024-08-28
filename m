Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1718C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43EC88B67;
	Wed, 28 Aug 2024 03:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ddq/yBQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A2CE88AFA; Wed, 28 Aug 2024 03:45:52 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6E088AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81fd925287eso226747139f.3
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809549; x=1725414349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtnmH4ebFa5vWLQEucgyQKceO2m6RTtSZiuTNjMM20M=;
 b=Ddq/yBQek1+sEUqRqPEZ7xB5QFAmjAK/yjVrYSIMPF65dLua6IolAcPBpLW3chrj5t
 g3BlolyXGuf+aYurWbXSryGVQvxAVTDtt0T08K4qjEN3C4sOUfQD6HxWVl70FVoKwcVP
 zoZHevhWjARnFnntnRKHP4UtSQ9agLHJSfyZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809549; x=1725414349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtnmH4ebFa5vWLQEucgyQKceO2m6RTtSZiuTNjMM20M=;
 b=pSrGl7XNIJa6m4r70PTfFc02HLDXkh5p/dyHWbIQqUcD0RxsJwISfGpOEKVdni/URv
 xoAma/syag0ULDLyQiQl7aC1YBJXkYWViv/+gkpboT/ExutFDMpt63RzEjOYJC8/mwJW
 lSy2Qndq0p9w/puuYAUkalIzKKYyVvwVLFMWDrOZSIiogccWiTKgdDXn/0lWkif+irZs
 6KVG8nufRQTLv+KTJ3p2ViFPlPX0Uvvp7t5+AzvBFm+w59/W40dssuhMyfvWGiWB2d6M
 XhooXxIRYmAxTWDFFF8XysLFVEjphb3lcMKvyUqUGWtW5YRBK5nNvFUvOmOsZ5WR36vB
 zpDw==
X-Gm-Message-State: AOJu0YylEWm8qWo9om/GQ/HrpXFZVo1Aa6+GnyVfVvORc0k3Z7rWifgj
 S7n6MjxvfuqOOtP9XExyI9q6WQd1aBdM05Trm2CJL7dNGq8eCjlNfmfQv/s74X2u3Vq7FXc2Mh4
 =
X-Google-Smtp-Source: AGHT+IHFT0uxQqlPwjs48zIuK7dcem/KTHSUu9MFSytBVtv1sgd01m9SlzTY05cwVT1bR98H8a35TQ==
X-Received: by 2002:a05:6602:6218:b0:805:e2bf:f303 with SMTP id
 ca18e2360f4ac-82a03e453b7mr67656339f.8.1724809548929; 
 Tue, 27 Aug 2024 18:45:48 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 02/18] bootstd: Add stub for bootdev_setup_for_sibling_blk()
Date: Tue, 27 Aug 2024 19:45:21 -0600
Message-Id: <20240828014538.3322013-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

When bootstd is not enabled, bootdevs should not be set up. Add a
static inline function to see to this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/bootdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/bootdev.h b/include/bootdev.h
index 2cee8832d26..ad4af0d1310 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -395,6 +395,7 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp);
  */
 int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
 
+#if CONFIG_IS_ENABLED(BOOTSTD)
 /**
  * bootdev_setup_for_sibling_blk() - Bind a new bootdev device for a blk device
  *
@@ -409,6 +410,13 @@ int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
  * Return: 0 if OK, -ve on error
  */
 int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name);
+#else
+static int bootdev_setup_for_sibling_blk(struct udevice *blk,
+					 const char *drv_name)
+{
+	return 0;
+}
+#endif
 
 /**
  * bootdev_get_sibling_blk() - Locate the block device for a bootdev
-- 
2.34.1

