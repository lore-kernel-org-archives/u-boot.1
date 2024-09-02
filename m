Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C3C54FC6
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FEE88970;
	Mon,  2 Sep 2024 03:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRrd9qj/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64762888B2; Mon,  2 Sep 2024 03:18:38 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A60A88670
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d22965434so13958855ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239915; x=1725844715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=DRrd9qj/7JPnbZTEqPV2bMF4xGd6RwPYngpokeJ6YyMm1nq6i3MfgdBHuT6OBbllkF
 eio4UrrV90VJnFfCyKQiyIyp4UY0povGKB6kAbfQq6BsLEm11xFgJMDkBhhgiT9fq6O+
 h1cmrqWmTH6lg82LT7ZOu/fJ2cjLNTV66L6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239915; x=1725844715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=OSKkcF4R06cMEvqp+S9upOIbhqEcRSN7jP+dlTzLCZRW905U6okOnm4/Inig/9BQ6M
 r7c6NlB9yAlEoFKeM2HKhMbnDahVl/UL/swF6aGYE1WTUn+bFLi0CtOMaanpppzs0JIq
 u1Y1qEHEWpZrzYEV/TmVsy8Eun9x/RNOU8fuy2hPouQqA0+XYi5QKrM/FjWw+ytAtNFW
 vgcQoWeFR3rRqEx4THZ7yUvJBcYmSeFqWMBZWs4uxS5uP7GHBynM9Ukei8Z1PU0TL6Wf
 QoCb1yUz2JfLLLKQ+Gfb9mTv56T7fgoRDPUX2Epbt4U4rd9S27KLuvM9tf3idnqSvN17
 R8Ww==
X-Gm-Message-State: AOJu0YwF+9+8eL3PrwHXP4ujfVRDj9As/SzZl79ksctoWtT2XB3Hwk9P
 DwA15w7UK9cT4Mv4B+peE19GIfJIJx/kbiqwgEJV5nlwnqe7e5+6BTwOn1N2s9QZPCq/pBdm6ZQ
 =
X-Google-Smtp-Source: AGHT+IE0Os/Si5QnIusja0OWWmns2ZQg5oOfbfT6tA8XSm7QBH3K8on0mqAqjab+LOBUZvVKFcXStQ==
X-Received: by 2002:a05:6e02:3b04:b0:39f:554e:c979 with SMTP id
 e9e14a558f8ab-39f554ecc9cmr20561185ab.6.1725239914658; 
 Sun, 01 Sep 2024 18:18:34 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 01/14] efi_loader: Use puts() in cout so that console
 recording works
Date: Sun,  1 Sep 2024 19:18:12 -0600
Message-Id: <20240902011825.746421-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

At present EFI output to the console uses fputs() which bypasses the
console-recording feature. This makes it impossible for tests to check
the output of an EFI app.

There doesn't seem to be any need to do this bypass, so adjust it to
simply use the puts() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Fix 'use' typo

 lib/efi_loader/efi_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index c944c10b216..cea50c748aa 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -181,7 +181,7 @@ static efi_status_t EFIAPI efi_cout_output_string(
 	}
 	pos = buf;
 	utf16_utf8_strcpy(&pos, string);
-	fputs(stdout, buf);
+	puts(buf);
 	free(buf);
 
 	/*
-- 
2.34.1

