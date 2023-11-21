Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E93C61D98
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E0487631;
	Tue, 21 Nov 2023 23:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bedrocksystems.com header.i=@bedrocksystems.com header.b="JG18W77W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EF4870BC; Tue, 21 Nov 2023 23:55:07 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2BE86784
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=bedrocksystems.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry@bedrocksystems.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c2066accc5so2899703a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bedrocksystems.com; s=google; t=1700607303; x=1701212103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pTWisbXcwRmT71j6A/W3LvK+3NyLhRFLC/WMMi8iDn0=;
 b=JG18W77WNYY9CAYrP3j7CMYyyZw9XSSJwndynvTgHkDrkLCRGbk4KtiQueCujdwdcE
 YXmdNPSp9Wxk6hUvY2yjGlF00Xbhn5nkBVJ2KSvujwOTIKiMfMe0EDEYffkqMKkAeCI1
 lUCO+Km/Xgvi48l9TpmRzPy51cvreE8bzZpZX8+cxT4KayiH0hoty8mMj2VBSG0dRjDl
 zGnyywchjLIP06nmRuSn2o8GGhBdkqPzb0YH1AskpM4ndUCTty3hn1fVNBg8m/db90sm
 lfjb6/f4LPwxDkZG4Mn2re+F4Xr8twov6ehxldrXzcuj82FjcGoAJOjtKoDOukh2WFDK
 P5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700607303; x=1701212103;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTWisbXcwRmT71j6A/W3LvK+3NyLhRFLC/WMMi8iDn0=;
 b=GfCDFjLB02wfAFBOyqpVjQ+ts9jNiMxgI70Em4VZAHtAxpIAUciCaxwAoMwutp0Pc5
 kHqdOAUSMiW62vAsXZbJDv8Of8UsFLkyZBm879JYNTSt4EeF9FA1g4zONhO7X4e6AfwW
 VWzkI7EOo5tnPsxAeLVCK6SszYoZBc6oaFyfH80i8akk5JTmoXo2pvTDVwuFClgPpUWO
 Z8bJ6Z1Sp/WpbW5hKDyC05Ju3WMnFKeXFV68mrK8PKa0xmpH6N42sK8Bsmw+lYn9IkP/
 ZFcJmfMYMdB3G1GFxM2XtcmKyI36hYJkP+yDWKaGQoDguKeo8pSRi3DdqN+mzi9iKBY0
 CseA==
X-Gm-Message-State: AOJu0Yy9tkJU8Xuxz2km9SCxXT569ipHOdogU3Ztuh+xWpqLk5RcA5Gy
 lQ9FtgM75RntBqfrW25Ba3GzSNPcXLgetFm0lVKCN2zmkXwQ61C8C11m9w==
X-Google-Smtp-Source: AGHT+IEe8jqyAAKcN16GcFLPVyITkeHE/tYPh63CqAM+v3718JzrXx3gAY69epalB4Aowt78u7Oi50ULmwokcG5dn9k=
X-Received: by 2002:a17:90b:4ace:b0:27c:f80a:2c8a with SMTP id
 mh14-20020a17090b4ace00b0027cf80a2c8amr760276pjb.0.1700607302890; Tue, 21 Nov
 2023 14:55:02 -0800 (PST)
MIME-Version: 1.0
From: Dmitry Malkin <dmitry@bedrocksystems.com>
Date: Tue, 21 Nov 2023 23:54:52 +0100
Message-ID: <CAKRNjQ3YjFQGDmGmowbtbFnpAn7k3nHfbwqpx0_BX-+v_kQkzw@mail.gmail.com>
Subject: [PATCH v2 3/3] rpi5: initial support
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, mbrugger@suse.com, pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Nov 2023 23:57:42 +0100
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

rpi5: get_board is no longer works. Print model name from
 FW FDT

rpi5 deprecated some calls/tags for MBOX. Better to use FW FDT.
However it does not give all information.

Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
---
v2:
      new patch
---
 board/raspberrypi/rpi/rpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index cd823ad746..6b678c5d23 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -429,6 +429,7 @@ static void get_board_revision(void)
     int ret;
     const struct rpi_model *models;
     uint32_t models_count;
+    const char *fdt_model;

     BCM2835_MBOX_INIT_HDR(msg);
     BCM2835_MBOX_INIT_TAG(&msg->get_board_rev, GET_BOARD_REV);
@@ -437,6 +438,11 @@ static void get_board_revision(void)
     if (ret) {
         printf("bcm2835: Could not query board revision\n");
         /* Ignore error; not critical */
+        if (fdt_magic(fw_dtb_pointer) == FDT_MAGIC) {
+            fdt_model = fdt_getprop((void *)fw_dtb_pointer, 0, "model", NULL);
+            if (fdt_model != 0)
+                printf("FW FDT model : %s\n", fdt_model);
+        }
         return;
     }

-- 
2.40.1
