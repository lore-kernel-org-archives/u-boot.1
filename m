Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256A5C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943FF88ADC;
	Thu, 15 Aug 2024 22:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AAqDONLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FD0288ABE; Thu, 15 Aug 2024 22:24:42 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD348870B
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39c2f653efcso4564985ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753468; x=1724358268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=AAqDONLggDPuTB5zWjg3eb4jtOrY02bOA5tMy3z+RGMHfrOFVVyVwgE2T+fnF6mRj3
 OFStnUaDUlTPSlRTeelqTCI+9jUTKOH0VKXg/OHAR9IWK4iCo6n0h9qgLSsuA8IEjygY
 wHx0kWqTZWhPWSZNGAeW8cxC99icIa2GpOUrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753468; x=1724358268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EOgF0fi9K6gWAGi3Z+7iUXQy0Hk2b0EbHWQDBsqJCM=;
 b=alJ5/B8ibkec4PR0hZKaLkWB46ias2ycJGwrCDaDDHv5oj27z8JZdPZkYM+FcvLse5
 60rZoLO0/8L7jaDjuJCBXv/22sblMMRK0eDpoF94IxOa0iHXVQtV5BnYaDMOrdadRX/+
 ODBJW9bJYK/w3i4HaB5rK6LCAPScz0npEb+vHsKePGQB1D3iwQ5UdF60bN7b7hk05WWx
 cp8kjKhi68tZPUcKlEqGodvTDKVLjRg4CqGf4vHXemRgIvuaCnqryIRsJ2QtQCFjI/31
 4J+EauhsgkQHyCFGSI62ToSEvAfy0h6o0+SXv5AeqmIpMNzzpcg8QB8HnzoNHCVGZQNK
 ZsRg==
X-Gm-Message-State: AOJu0Yxxdt3jx94bdWmzpKTuGbRp6Z6qJxHy9vlqfsbPo+XSrXz4xiMX
 iKSHhMq2B2kTBFv0wWa8B8vxFG1P6TmEQlNuOA/9xwhtsJ023E4uxT7pv/yTkjHgEWuu7FW+y6r
 YRA==
X-Google-Smtp-Source: AGHT+IFx0saKzi7tZx5TydNCgKad5G0aqO7CCplBIV6Yg1Q6qDBMkK8cj8zmOjUr3dkoWfbtDn7eTA==
X-Received: by 2002:a05:6e02:1c4b:b0:39b:3b8f:d181 with SMTP id
 e9e14a558f8ab-39d26d17caamr13642425ab.16.1723753468600; 
 Thu, 15 Aug 2024 13:24:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/14] efi_loader: Use puts() in cout so that console
 recording works
Date: Thu, 15 Aug 2024 14:24:11 -0600
Message-Id: <20240815202424.766778-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

