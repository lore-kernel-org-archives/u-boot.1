Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C9C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 16:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A940A82E05;
	Thu, 26 Jun 2025 18:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VprkvifG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244CE82D21; Thu, 26 Jun 2025 18:39:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1A3782D21
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so691022f8f.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750955937; x=1751560737; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+zaz4jqsL/9fxbKN/AXxOQ0QyoZGDSljw4WvKTpvhBU=;
 b=VprkvifGYMI9a6nM0SozvBbSn7GVxFYlSZp/aXKq3quSVitpa0S4EyaZgY7fr4q4Je
 E1t52QKk4ABymtUIa5EUe/HjrbtF2UyAkJriwzWVNaCsZ/AvIBFfhdvLcIvGHhJbTXNU
 QFivwsbrXvJDo9Rx2uEOLVeBRhBs26Uspm2MiqsXzSIRTEGGDyClRw18md15cxESgRFr
 73ol61WC4/7tecVFXKJwKFjre9mv91e+KVOmnKfa+Pftv8Ts2mowQoYSJsTnQjqzLt9y
 KD6xmzFTjWSZb2Gx22rBzGePJ0eUT3Yq/0r3Kk8Hmt5nqK2WD1pYdVNnOqXcTd2BWnvW
 NCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750955937; x=1751560737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zaz4jqsL/9fxbKN/AXxOQ0QyoZGDSljw4WvKTpvhBU=;
 b=ldqqtcNwEyx/Tgicv0XYbiWUaIZbo3XKNq+Uwcx8m6ehIYwS5B0IG9SGObqhEiTZka
 h0bodfsm2k2/rpgUeM3f8Z1Fz34e9eJcEwdPNyK7/9vK7/KDbiFSFfPj0Hr6PAxm6jJ/
 SjKNH57CpxcMltlxv8m5BYbGzeF4BlEEmVWWkU/6UWHWJkGCZDIK5XpGwvMxaeF1tZ5G
 SlkJDNIROh56oQd+VcjOx5MUtjNUdLLQIzrQumCntGO51AqiQKbFy4bL0FUN+hoodHNw
 n87thFrc/g4PyoC1mEXqug8hY4kjn8e2vFhJhmsiaAwdK/6nn3+1pgPCCfx3GVCqa4OI
 WIVg==
X-Gm-Message-State: AOJu0YxQeo1pQe8zTTA3f6mq4IUk1urlOdDDJAA3OqnorBnurSkYzDAg
 M/2fZxC7WbMb61Q6uBduUSrNif7ONR+yjEErnIDVbJexa6EXbmNRW+bUwoqy7WjupChmwvVOhsD
 f9cILn2Jc4w==
X-Gm-Gg: ASbGncvAEicp2iDfiBXzDF/6hPoyb0eGfD56sPDOfL9JmUCogr3w8vSFTfhAh4T3YnV
 RolJvuDWzUnZvfYjA/XdLy4iXljZGZJjRReYSq0+gWTlKX7j+vEhdKs7QxzVMVFyUpaUV3B7xGq
 Piwq3kOaULxeHlJm8rcpd5jQvTzbQJFNZqsVd7lxwpt4hjtNPdRJ2Uo9UojILSMe4agt4tNUvA3
 S4ay3zDXL7yTSXe1+gsq2ERAJ1UqixJFXpSmct3mXSZfatBXYfrMeiOdyA10T6Iq81vY8dBjEH9
 rW2LDOuCCCj67voOHAyqCdU1JOYA18EpOejHb8y7WJLnPjsZdpi5AkC1LPabAmnOz3whg4MTkuR
 yq+/1F74Y7mUzkw==
X-Google-Smtp-Source: AGHT+IEmP+nXFrPQo7nIXbLyqI4wuasYB5QsItg+nMCZUCCHhLChCHGOHv1H/2f+WLPMrxAAssjduQ==
X-Received: by 2002:a5d:64e3:0:b0:3a8:6260:142c with SMTP id
 ffacd0b85a97d-3a90bba866cmr201955f8f.59.1750955937308; 
 Thu, 26 Jun 2025 09:38:57 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52addsm336091f8f.47.2025.06.26.09.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:38:56 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 26 Jun 2025 17:38:55 +0100
Subject: [PATCH v4 2/2] boot: android: Prevent use of unintialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-abootimg_fix-v4-2-df7af00e87b0@linaro.org>
References: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
In-Reply-To: <20250625-abootimg_fix-v4-0-df7af00e87b0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Initialise vhdr to prevent its use when uninitialised.

This issue was found with Smatch.

Fixes: e058176be32b (android: boot: add vendor boot image to prepare for v3, v4 support)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/image-android.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-android.c b/boot/image-android.c
index 459cdb8456c..12bcf7e4fbd 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -677,7 +677,7 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
 {
 	struct andr_image_data img_data;
 	const struct andr_boot_img_hdr_v0 *hdr;
-	const struct andr_vnd_boot_img_hdr *vhdr;
+	const struct andr_vnd_boot_img_hdr *vhdr = NULL;
 
 	hdr = map_sysmem(hdr_addr, sizeof(*hdr));
 	if (vendor_boot_img != -1)

-- 
2.39.5

