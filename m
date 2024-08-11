Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D9C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61A388BE6;
	Sun, 11 Aug 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SiHfw1YB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB19B88B1C; Sun, 11 Aug 2024 16:52:53 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9314D88AB6
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b3a4d2577so12271985ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387970; x=1723992770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=SiHfw1YBvhzxEzwyqSJNdqUhWmmKpq1HalV3L25KnTqqg6rRz1St4JVAOCJPN/iqBP
 GQCVZHkgpkyffdNse1zOcicHNTgBfp4tkcmYNYhsP3bgZZqJnbw3ebRBGFOsLp0YBT0Y
 ET8UgnISYo6Uuluh32vNwtV5fRQLorHug5U40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387970; x=1723992770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=cgjbd9vF0LZWNOC76H/C3PZl+pILvuh06G7QVZBzJafOGNH9DdO7VnA3mfyl07JVs+
 D/RDqRMfbGV3FhjIse7T3ZKM+ansVxn/1yMK7bUusq84K9nm8qxt5MOzXQuKMq5g+Evp
 Bxlg5/Cig70kiMyf6Og+T0v6/2Lr9x1xiKOhbNYXOfbCOqps2butPOWGjDzINp1q2Uzz
 GnJiNxThHSrvDr3d7w8/TJP2fA2pFg78Rj7bqsP8oQCB9w5rBPYNJt8SG+C2X4uqrGAv
 Aa8ue+/cemQrY1YZfYEWOfJr7rz4dNk+H+UUXFwtRN/Fu5lyUt64GyJejom6MGLFSiUh
 E+wg==
X-Gm-Message-State: AOJu0Yy5wi3S7Gn5jSwWUk/AEZBEovMHSsRfVj0XkDW8A+yBVZHWgmus
 oQJtz5/WMLDeHxl3unsGE2u7UIEPYqaJZ6vq0I75Yw1kYX3vuJEyQqakJWEor8AaIZ04cq25kGM
 =
X-Google-Smtp-Source: AGHT+IFKkdGHujZW7Ez6bPE4r/k65TfZXLJ2nkIFomUQvW1fdOKAUm9KEq/OyBrOG17vX+7DLezcqA==
X-Received: by 2002:a05:6e02:b26:b0:383:4a12:b77c with SMTP id
 e9e14a558f8ab-39b74968608mr97263335ab.8.1723387970289; 
 Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 25/40] efi: Use puts() in cout so that console recording
 works
Date: Sun, 11 Aug 2024 08:51:54 -0600
Message-Id: <20240811145209.4191404-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

