Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70509E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:39:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FFA8036D;
	Thu, 19 Dec 2024 03:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PcCmV/Qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418868021A; Thu, 19 Dec 2024 03:39:09 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BACA8031D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a7d690479eso2289785ab.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734575945; x=1735180745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxXH5Ri/YhIEF23HfvIzeRqA6ogyvGKOgTlsgr20LBk=;
 b=PcCmV/QupBBzqMvh4UtRq0KOUdXf69KVGboRLWRq6Wi90V46pEEeBxAiWdxgXzV/HS
 feXICDKZWeBcwcPSEW1Psp6ux6roM6BIpopxcUlirhPJoNDLY9Qs2z2i65EEVn4/EKxo
 PvOmxp2ycr+e6eaSAnOGvpgNzkB+CO5O0GyeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734575945; x=1735180745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxXH5Ri/YhIEF23HfvIzeRqA6ogyvGKOgTlsgr20LBk=;
 b=QPewpO1NFCzdytcbV2S0Rc0aKkM0/4rYRmOyTQh5c43RktQr8XDuw9nBl56o9imLQY
 5HafHQ0jeH8OAe2fzR1aghmjD4sGP9A8Ak5f3YNN70n5wZJZIyIzvB/HtCYCN75WeeIq
 SMTmEPQta9XGYbUF5uy/8htbdC7PtBRM44O+Lw3G3fnSxRK4X9AdK8QZOB97PnmRPKDY
 7J5IFDi8QS6X2CmwAU5P7cwoEZcVSuW+EL79wzJn9RbN7eUfxjeo4noQ2YRmJY+JgmW2
 uRxeHCts/bX6qEXlEk1J6PDClhK1WHSjcO8478yA9YxoXDc/lH/P3OEtaIcT34gcajJo
 +jwQ==
X-Gm-Message-State: AOJu0YycD4FiXSkDv+vTi5ojx05ZN1039YInZRQhMNYahTxK/S6C2zhA
 m+jN4YlAxaT3opK0UMPEL9y+500KmH6r3TdYdvmL8KWtbkvQGAunh7iXWua72SA0PC60D1hutOc
 =
X-Gm-Gg: ASbGnctgj9oLv+7/EVEtceXJonu6CWJ7/6LDy3FZ+UyVBknGv5E+jaXKW0AUT+e3qgS
 x1Moh8K5ENVXETVVWkWdl8ef3XZrYAtC6/LAgtwdxsKBUBcOJg6RJ8sB8bTqAwLlSSKrRM8+3Wu
 xqsY/SVzyE9+rOEX6an8+VPGsJjwzZxlXrXjEOinj7iLlq17vAy1WwMmrapVSl/cmekUnhEHWEY
 8uYHLI4p7XAfQzAD3Jta48kklJCwpp7urOrqcaVLkmjWLSLXYTLqRQL58/W+Bjwj0SyJi6SZzFL
 HBPMmJaM+/q9WkTppw==
X-Google-Smtp-Source: AGHT+IH2kKamU8hMYTQbxwfB+SrenMBTFZOScCGhnE1CRV5+f6l2J6aRuKqBVV6b2A/nUb2wfdmmHA==
X-Received: by 2002:a05:6e02:1f08:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3bdc0133223mr60394325ab.1.1734575945358; 
 Wed, 18 Dec 2024 18:39:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6cdcsm712125ab.71.2024.12.18.18.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 18:39:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>
Subject: [PATCH v3 2/7] efi_loader: Make efi_run_image() static
Date: Wed, 18 Dec 2024 19:38:27 -0700
Message-Id: <20241219023832.1098689-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219023832.1098689-1-sjg@chromium.org>
References: <20241219023832.1098689-1-sjg@chromium.org>
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

This function is not called from outside this file and has no entry in
the header file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 5016ba7e225..051d86ef993 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -159,7 +159,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  * @source_size:	size of the UEFI image
  * Return:		status code
  */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
-- 
2.34.1

