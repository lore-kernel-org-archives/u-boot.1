Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C5EC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68032839BB;
	Wed, 28 May 2025 10:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mggkrnpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3467E8399C; Wed, 28 May 2025 10:26:19 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B078399C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3dc75fe4e9bso2201775ab.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420775; x=1749025575; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Xbdd5usXea1Kj7eqWOzPQFdrtYfAGmKuo067Z0I9X4=;
 b=mggkrnpEgZu/l64BaS4BDGTBcBFcFFvSC1qD4eriIUZElutNogx5rN+G9ibQbJ1QuJ
 VA654KIfgJxyS2N55rlVXX3MF9rXFABUF2nn6gGFR/66W06XtHZ7v3iZHlghYKgLDK4p
 2ikhMMYV36fl6NfTHu5xhH0rjf5KhISlZf8gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420775; x=1749025575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Xbdd5usXea1Kj7eqWOzPQFdrtYfAGmKuo067Z0I9X4=;
 b=vx1qt+YD73arABBkD/raTsO5R/wM8oVuau0JNFfSIq/+Z/gbn+AaU9V9oey3jAPO6b
 wIxwspAs0tQtWQhp/XK7rav3/+d40xf75UM0F5zfw2xeWBpt3qdihqMkw0Tb7e17zf8H
 PoM1DY8VTz+aF7TNclXON1Dt2wV9bbNiryzsMFBBV56IsQF/PG/gsGjK1wNts6tfWofh
 pwv1tjT/08pla94GaNjhHUVBj59Sh99G1qimLs5l6LQL7bPPLGXFOXMxX5m2btxt+I94
 h85EXkicR8UJSvTL2j2wyeeeOCy5ZBisjpyaXqLNvEZ6gyWUle3z980Ckx5Reb/wXKa6
 jBFg==
X-Gm-Message-State: AOJu0YweBTJmnigz1iiKQ+pGnYoxVnOPGa5qqchKYAJfITgJKe/KqkAK
 dMAzF8Ez/rZIXYe6UblzXmtNpcz8kdngdt5Yuryqw0YIf3GNOu1N06o8wQtbM2GFXKnpBxuJLrY
 /IWXqsqeJ
X-Gm-Gg: ASbGncsltFbQDvREP+rqly9WF6SEgJHBYz6l4RSZD7ZPttYldBG7WJLRU9Rhc189y+H
 xjsDHH77raJNJV+tMZRjRSbLdtOm8WmxZpEgaUQd/YASvUleEh6lZUDYrOm6MxtrejSIdT75V7b
 PYCDDxN/KDf3ree77UITZ0M4VHZ9nD7SmgVxc4Rhi7L+kU/Ykde3kLEiCLiv6LFWI0hIMO2zy1M
 HtuNXxaKDW8WPmzUknHsRbvY68jg83TzBZAt0HAwXvlF+ntEjTl6oTQL/JmVq8GRULAqUdcskrD
 dVnlo6pKGAj27lBoZfif22vf9WWlVnRHBJWys3d14kqN/NNtyra2+Byt8WeeSzNE/prGEOsybX0
 E22uLS2IKRimGI01/d/Dw2jQ=
X-Google-Smtp-Source: AGHT+IEqB1ZQxTtFkc0ldJcIm8aJZYnP0D4ZbAjXrJOaSWsk6GZ3ukJVlGni1ISEuO65SfL9eM6YuA==
X-Received: by 2002:a05:6e02:17cd:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3dd87682d95mr32813255ab.11.1748420775032; 
 Wed, 28 May 2025 01:26:15 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/27] efi: Allow disabling the TPM in the app
Date: Wed, 28 May 2025 02:24:41 -0600
Message-ID: <20250528082520.152391-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

When the TPM is disabled, avoid trying to use it in the app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_client/efi_app_init.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/efi_client/efi_app_init.c b/lib/efi_client/efi_app_init.c
index ff31266fb12..938b16d14ab 100644
--- a/lib/efi_client/efi_app_init.c
+++ b/lib/efi_client/efi_app_init.c
@@ -347,9 +347,11 @@ int board_early_init_r(void)
 			if (ret)
 				return ret;
 		}
-		ret = setup_tpm();
-		if (ret)
-			return ret;
+		if (IS_ENABLED(CONFIG_TPM)) {
+			ret = setup_tpm();
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.43.0

