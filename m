Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27AB6D690EF
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 10:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CA38919A;
	Thu, 28 Nov 2024 11:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oJbJ40DX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED3389501; Thu, 28 Nov 2024 11:14:57 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692D589078
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so5614235e9.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 02:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732788894; x=1733393694;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SPQstkYaF8+S8cT0TyP3SWCruN6uY9pnVzfcqeriUkw=;
 b=oJbJ40DXpCVI6tLD54fuSO+3dP4gLu0pZ8VQLshwsS7yAv5sqNJBQDEDFEN7M1IVgJ
 Xyz5M9uy5f/DAthU6Gee3J1vowpL+6n7uuEZOGztMXoiMnWcwCCWiXVJspI9W1mFpt/n
 ugjEwPXOIDoxWmSDLVzuVZEzoSxBGE1M3EVPe/usCUw0AtaPAeToNT4b174NaI1px1nh
 PNj30J0F6lo/47KdqiV6svn+6PWyCOP4g4pFs0yF8Ba49JohL+sZGQnNDX8b7xvNmm3L
 jEpm3yt9+zRyXEafGfXEZiv/jA4A4zn7KcyaAzGPJsEWVM2LSFPOS+8gsXPaq9gSDC+R
 X4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732788894; x=1733393694;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPQstkYaF8+S8cT0TyP3SWCruN6uY9pnVzfcqeriUkw=;
 b=J0gpQiOg8Bzk2OIlD8QUG5ENvLeaCp6Yde7PSuvxEfmWzZMaznECoUnYybJUYJH2TA
 R2i6NkNTotTsjAEZ1iG+xCnJo8GQD/OKK9QiKWvVuGosaUJQLfrT0Kn7JkBRQsWW+x0d
 rFXRq04ZGkHmtv7q+D9liEvGUvt9d3bE4CIg1ejDhrRZsE1NqArrVoMNfPis/Q7uhUY/
 06btkw8Nl7p8DAkwl2QLSF7LBnsjY/MHHXllsaix8k6agEqgoe4qGbZOJs5G23KClrpi
 j6cMEMxP36eZjSkJ/JeGwGVAdCnhZ3GnMlDnvBA6XuGyzbg6tPVjpGdKFsWMt8uApIdg
 YyCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4sIPCgG1m6lUxD0NtT1nUj7k96vNJ3dga4+pJmohjKOzQ6cN7ZMXjSzt6LOecdLneR23IK8Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyJJj7cfpUxOMqjFn8zGrIFMvqlM6vHssWN2wvGg40dy9tAY1DN
 VKa8HeSRjhd90vE86//QIe3/J6rvJDwUewSj1uyGashwCwJ9vaTVa6KqFKj20prVIjzyAQgff/J
 pF/A=
X-Gm-Gg: ASbGncuwtNiuM6SrwJqr8d33esux9hu9HD7WUr8a73F67g6gIx35vuAvYELK6lpMthE
 gdfuC+xC6EngNg7VBqPznVlyvr+gUOdZwjRKtgnPUUd8oXtHKduRVtQQYUKi3MHV7mBTJYiWTRR
 0dadqSc8jG3zQg5x7DsMMzRIrNEAlfVd1u+RjyiT491VLGU54zFB8JNsvnBCOaptNpvdEgh1Xgd
 bFm9AXpa5YEAzHO1b0pSCtF4dEFMeLw5x3UTpJi7XKYhqMg4U7yTw==
X-Google-Smtp-Source: AGHT+IGx3AsM0KZ9G8+zMqWvcBb3yPqyDPIq4K6rEUFsDpq8V3td0vAzHDw59tiekdkgfRtOhZRI7g==
X-Received: by 2002:a05:600c:45c9:b0:434:a196:6377 with SMTP id
 5b1f17b1804b1-434a9dbed9bmr64186895e9.14.1732788894718; 
 Thu, 28 Nov 2024 02:14:54 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:91a7:bd7d:8e99:8990])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74efbesm48554535e9.7.2024.11.28.02.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:14:54 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/2] android: add bootconfig support
Date: Thu, 28 Nov 2024 11:14:46 +0100
Message-Id: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZCSGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3aT8/JLk/Ly0zHRdI3OzVCMT86RUS0sjJaCGgqLUtMwKsGHRsbW
 1AMpvaqFcAAAA
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

This patchset add support of android bootconfig partition[1] in u-boot.
With Android boot image v4, all androidboot.* arguments must be
passed via bootconfig instead of using the kernel commandline.

[1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (1):
      boot: android: Add bootconfig support

Mattijs Korpershoek (1):
      boot: android: import addBootConfigParameters() from AOSP

 boot/image-android.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
---
base-commit: 62224280d9e89648ae90346c0aede76f9b7e7610
change-id: 20241128-bootconfig-276e247be992

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

