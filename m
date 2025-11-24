Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC39ACFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72AC483F9C;
	Tue, 25 Nov 2025 09:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gZlvTWJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BCB83F15; Mon, 24 Nov 2025 23:44:38 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C408E83EF5
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-657509d761dso2446261eaf.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764024275; x=1764629075;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lwz40KoESqsU21VcQs+NDavH3wDIOGGRaOOI94QxFBc=;
 b=gZlvTWJAqJ6eZC26CNmsSkH22nP+9MCnde0uqkpGRrv+13+miMlbR/8j0t8TUw7PBZ
 EJuOgd8n71guewSuvWtYWzf1QhBngMl3IjtIXmmUjWqHCCZtrMptprzuk1o5r6dm758C
 iybL/OdVlctiVFjcbirg6zTnC950fXoPOU9IvhBYG8AGmtIMxZF0u8jv9d9+2fZ/3FjD
 yfxp1aZCpdzCJA8yodo5SHInJ4XGRiwuuSKBRGLnsM/Atq0tBv5n9eRp/JD+OTDertqe
 zJV25WnXxDrKli+wpiFCKRI++ZcAoIu1FimHYshKT6JkEjSYh7LWnOlKMp8IAixhwzb9
 McQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764024275; x=1764629075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lwz40KoESqsU21VcQs+NDavH3wDIOGGRaOOI94QxFBc=;
 b=LFPf6q+7JjyDs2SHe5L5V/FpL7PXHis6/Ns0x7191y2k9CoLDXc1qzir3Aw+qd4plw
 TeIJdlakXkK5sbHAZfds0Y84YpZd0WJ44zbSoGtRoaahhlyKvhzpqPFD2x/pnZxmk7ct
 ACmMQq8WpUcYw8OsAhfh+f6AIqEdMs1m2RtC0vNaCEng0LetBmzGecGAEpeWaXpJfZy5
 Owa4G/eZgK5kIGezrzWvNwl40cqiTQQz260IqGIzCfG1NbwUCXRsd50TFzx6Xlf7Skhf
 LaSKYtIY/VnBq/RTCzDM0GbZslAMxV0gUv5mrxzFLpR0hz8InVk0Wd9xcJ17Ci7V1Yp/
 3t6w==
X-Gm-Message-State: AOJu0YwDm1eTljvgBYNXwb5SPGXgHTrbsAfsDiJmMESiqPwWtQfUZxlY
 B88/lVRWzXflwz+iOr5/ORnWueChjQHno6AF8C8VYxp2/6b4l7XK3TQyo4oetMcV3bA=
X-Gm-Gg: ASbGncv+OudboOmNMYYySYp65nti3OvXsXHQn3e/K8l/jmD7+LmDc8MkXQ387x03mNi
 hz7ePPLcvpIdZdZll5EF3gSPsiwONdDVlrVV12XZq99FsTb8WaTwoQxFkkVtFx3FNrz1w3javSe
 EcMZPqzmpNlw043G8j7HwbyS36AN6C1H/73t+AMZaFDSc3ng2dIjz7tLQrGCIU6rd30U8e9fE/j
 9WlB5auRrO8Ln7jEQ8F8rFwqN/ocyFtOxIddq6EVsA7/5gwLa7xSrkhQ1do/syd1Nc/BKzKuVOF
 FZqhI6UzlILFHV4KjiW/kHwig5SkKK+XamBW4EdgeZr1Yzp6Ifxs7K602ZgGj2Xd8k/VL0HJE9D
 IZ1xhktlYiENhK5GeLfUHfhqKr8Zi31JRpwFPp5EF7MM9QL4EFc+oAh4xDpFCBmNl1XBDVFb7Mm
 PvEeeS2WGRlRJ3fQ==
X-Google-Smtp-Source: AGHT+IGAVKoy3VoGdxrBZJYNxFR4J+13g0/9gUvnPKAtVZmZshyabyXab3IXO5YgKaA4KOJUFZiSFw==
X-Received: by 2002:a05:6808:c165:b0:450:794a:6d08 with SMTP id
 5614622812f47-45115b870f2mr5398115b6e.49.1764024275520; 
 Mon, 24 Nov 2025 14:44:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8a36:4d72:5018:118])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe65e6asm4095918b6e.6.2025.11.24.14.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 14:44:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 24 Nov 2025 16:44:07 -0600
Subject: [PATCH 2/2] doc: pytest: add missing hook script env vars
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-doc-pytest-fix-script-env-vars-v1-2-fec5b54007f1@baylibre.com>
References: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
In-Reply-To: <20251124-doc-pytest-fix-script-env-vars-v1-0-fec5b54007f1@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=1AkdKIz6/WtHDT84HCM1EG5DDfgtNQFzBzEZ9JwWgrQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpJN/HtaZ4DEd+XgCfOEk60SUZb8i4XKq1tfCwI
 3PxmsXSYbmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSTfxxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVVQH/0bLm1UlWmTR5yhgV7ocGd2Egzd0fQ9Bhn9SBRm
 Vco4NjfqBt/h0GvrNhVEgujgU8l7vGMb4pemvnzekCpPA2jGWElfAZpGkC133mq+MF3FK4AoKV0
 vuPBIQBzqNV3NS7iXtnxxT3kjNB3oRmXWTRGCya0WwQDwuhrEBQ/5BWAk4X94tgUFDQ4OgwBYxt
 Ju3z4QB9Yokf1HEvfi4teXLx2t65RcK6bNmtxAE3h7vbWPVeCE3tDK3tp8XDxjFxLaogbwB0dJ2
 7Ula80SwN/wRtlznS2/xxL4SH/e+n2EWmbiFelWYL3IAtQb71lXt8PGCIvFHxkPc+ImTh7TuA4J
 3aWA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 25 Nov 2025 09:47:59 +0100
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

Add the _EXTRA variants of U_BOOT_BUILD_DIR and U_BOOT_RESULT_DIR to the
list of environment variables set for hook scripts.

These were added in commit 8f2a9fa7d6e7 ("test: Support testing with two
board-builds") but were not documented.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/pytest/usage.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 7c42a31528fd0ef78d3e24f65ee86ce2d61d6e87..df3821da20dd6e4199947a594e5e2eb2198e6e6d 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -316,11 +316,13 @@ Environment variables
 The following environment variables are set when running hook scripts:
 
 - ``U_BOOT_BOARD_TYPE`` the board type being tested.
+- ``U_BOOT_BOARD_TYPE_EXTRA`` the 2nd board type being tested, if applicable.
 - ``U_BOOT_BOARD_IDENTITY`` the board identity being tested, or ``na`` if none
   was specified.
 - ``U_BOOT_SOURCE_DIR`` the U-Boot source directory.
 - ``U_BOOT_TEST_PY_DIR`` the full path to ``test/py/`` in the source directory.
 - ``U_BOOT_BUILD_DIR`` the U-Boot build directory.
+- ``U_BOOT_BUILD_DIR_EXTRA`` the 2nd U-Boot build directory, if applicable.
 - ``U_BOOT_RESULT_DIR`` the test result directory.
 - ``U_BOOT_PERSISTENT_DATA_DIR`` the test persistent data directory.
 

-- 
2.43.0

