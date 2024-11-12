Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0252D42B86
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF655889D2;
	Tue, 12 Nov 2024 15:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bi5BY5xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D2589479; Tue, 12 Nov 2024 15:13:53 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC328946E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a3c00f2c75so20448685ab.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420829; x=1732025629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IgNcAMEELqrLNWVqunE7un3Wcs3Z91zOOWMVsTLCmBw=;
 b=Bi5BY5xuPA4BnA1xRde08IwmfkT8DprBjjmyCQF+awR0By3tvZJRsXOKO+IZMME7pt
 9a6r7RSOAgv9orO5gaYVYQrjb2PCntrm6kU2w/UQ8UPn6P9CTtEOm9IrW7nDT8pPflSQ
 U/uZOntzw9r/qOs9w66Z4fmvSziLExgwj6z5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420829; x=1732025629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IgNcAMEELqrLNWVqunE7un3Wcs3Z91zOOWMVsTLCmBw=;
 b=OKUSVesVpd17bQG2eAUi1utKj/VGzvU21H9713Ky/u71hxZ9ozBBjZ1e19axr0tFy0
 56a2HxL32gYIRH++OnptSrMidfq0KNAtQmrtiB5I0mXy7jzZVEjDE9/LkZDoKIpk4D21
 AqPO6g0H165u0XBx1aLQ0lr5eQelVVlhtdZkKNYSNIcOQhkToElkSIgOWN4LceJBRrvk
 3S3OlzIqjRCVpbnrJdPPwI7vYlFCb2Q+25+8lRhGxDNBTafwd+NYikk1VH9ZlHaVaXKW
 AKIqecEHIsO7L3cTeSW04E+fGVJO3xyBKw+Xp153O68PBl+mWfhPJqMY0j5XsqH72r7k
 5vFg==
X-Gm-Message-State: AOJu0YzgXyILmBRaXp7/tjWy9/qDZY21ITFLSqwPgVChNG4ZUPeZuPSa
 AIjaDYtyl7uV6NP6opz8jP25XTzEVLRia/MdBdoM46wsZiX3EomTyA77T/laaNZoRZ6jWKTsyS4
 =
X-Google-Smtp-Source: AGHT+IEy62ZeESAAB3uN6VtobMBt1spj0YHO2pbI6q/JXZo08H0gmCjQBYhfnAHUkmMgQr/AZPKgRw==
X-Received: by 2002:a05:6e02:148a:b0:3a4:e74c:1042 with SMTP id
 e9e14a558f8ab-3a6f1a06b3emr165771845ab.9.1731420829563; 
 Tue, 12 Nov 2024 06:13:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>, Padmarao Begari <padmarao.begari@amd.com>
Subject: [PATCH v9 11/12] test: Correct regex string in test_spi
Date: Tue, 12 Nov 2024 07:13:25 -0700
Message-Id: <20241112141326.643128-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Use an 'r' string to avoid a warning:

  test/py/tests/test_spi.py:698: DeprecationWarning: invalid escape
     sequence '\s'

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to correct a regex string in test_spi

 test/py/tests/test_spi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index caca9303271..44e54738dd0 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -695,7 +695,7 @@ def test_spi_negative(u_boot_console):
 
         # Read to relocation address
         output = u_boot_console.run_command('bdinfo')
-        m = re.search('relocaddr\s*= (.+)', output)
+        m = re.search(r'relocaddr\s*= (.+)', output)
         res_area = int(m.group(1), 16)
 
         start = 0
-- 
2.34.1

