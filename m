Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EEFC0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFB780E94;
	Sat,  8 Feb 2025 18:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V4TCJWxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D6880944; Sat,  8 Feb 2025 18:13:13 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A3F80A2A
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d0521f966aso8409135ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034790; x=1739639590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PU7N8gPexW9J2Bq2wzq101wetOCS+3R91t5Rezj6QWg=;
 b=V4TCJWxP6ORbg28FEHLlUOASmlZid28KjxlbphlbeYyUt2XOtXU1NsZVarOuRuS4G5
 wER3m3OWTc92NnJHKuinmvYupUaf9wQbYX0nAfBKKwfVCDtjsG4PX2kII5TE433ODGkJ
 Ye4NN9JKE6jKPLAlYOScN4IHouOm0wbWaZVFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034790; x=1739639590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PU7N8gPexW9J2Bq2wzq101wetOCS+3R91t5Rezj6QWg=;
 b=Fxs0pubhyTATbVU2oZRKokqAAYBJI0rBYAq2i3hpquwTsgOKlhLIL44YJNMhMm2C8w
 h2bAyIP8MTsd36mUBxGF6ioMjKQ1iUOVtab44MQdFM00bhrlMopuTAvDKXpxYeviYu2g
 O9GBn0hh3lSQhTuoEtXwHESOr28Vuum/uaCqSPBJFLTl8LvXInsFJhWpwdC99fVbu/Z+
 uLzTOCBmizjq0bVu/tF27FhExtVaw2HMnW3a4we8hv96lefW3u3debM9G4YwayZJLouz
 ogO9QJz7lIW4ZlYLzCXn64nIqOeatNJJrqNiswKioJn1r9TgSKHyo9NfR9j3KB8Rf38t
 4GtA==
X-Gm-Message-State: AOJu0Yz1V51E+qiLG/HUJF4OmwXV16tz3GvgsPK/Z84RI/EC0zYaq1HH
 hImzU7E6fvs1+s3BEQlvbNLT2obBVwnHfcgN73/yLxG9A1Ie+qA4oGFK4mHBVr+ouqgta4YnK00
 =
X-Gm-Gg: ASbGncu5b/a5Maa1JFR6xZU2kT6Sq2lkq07ojabd2haF9tYVh8ORLBDTMGt9VkS75jh
 6MqyIWSfwlonuVG/iqV8B77YANBrKKMoNjmaS7JxXBoM8ea6vKxYUJ5m2CWI0ZU83WDgdVEGX7v
 +jbH9efO37IRrZhAll3qcwNS/TlhDEFEXriArNa/nOHlGERuMqa8dKVNZEu+vDEwpEGn1ThOExD
 JR3+aYTuor7jOkHQ7lVnrH/gMyB4fPpdGEXyHrAfxs06JIGo6tQW3BE8z8/5OnaLJSim1PXZVuw
 B3dmhlnWbLigTXT8bgbyTBvqODopMFxb2wm69acAf58UIfnBls/y
X-Google-Smtp-Source: AGHT+IGhJG3FzenSdrm5sW8WedIFAIyMe3/fYLSZaEHZnnv12Gay6L/q/bCiAKhnMs6DJB3NNjPxyw==
X-Received: by 2002:a05:6e02:20e2:b0:3cf:b365:dcf0 with SMTP id
 e9e14a558f8ab-3d13df549f7mr56186675ab.19.1739034789874; 
 Sat, 08 Feb 2025 09:13:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:13:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/29] efi: arm: Use EFI flags for all compilation with the
 app
Date: Sat,  8 Feb 2025 10:11:47 -0700
Message-ID: <20250208171154.1305761-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

As opposed to the payload, which is built normally with just an EFI
stub, the app is build homogenously using EFI flags. Update
PLATFORM_CPPFLAGS to enable this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/armv8/config.mk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/cpu/armv8/config.mk b/arch/arm/cpu/armv8/config.mk
index 1ee31680106..0316af306c4 100644
--- a/arch/arm/cpu/armv8/config.mk
+++ b/arch/arm/cpu/armv8/config.mk
@@ -21,3 +21,7 @@ LDFLAGS_EFI_PAYLOAD := -Bsymbolic -Bsymbolic-functions -shared --no-undefined \
 
 CPPFLAGS_REMOVE_crt0-efi-aarch64.o += $(CFLAGS_NON_EFI)
 CPPFLAGS_crt0-efi-aarch64.o += $(CFLAGS_EFI)
+
+ifeq ($(CONFIG_EFI_APP),y)
+PLATFORM_CPPFLAGS += $(CFLAGS_EFI)
+endif
-- 
2.43.0

