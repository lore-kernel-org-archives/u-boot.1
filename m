Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B56CC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE92B83976;
	Wed, 28 May 2025 10:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KV0CtZys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAE028398D; Wed, 28 May 2025 10:26:10 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E0FE8398D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3da831c17faso13542475ab.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420767; x=1749025567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bHJmoiGVFrfOQh/IiVXG8F4pb61PliK3Knpz9DRMSk=;
 b=KV0CtZysMxWib5xKCJOzCz+hzfWh0JvaymC8RMrEryLKfZnymoxO0+YkrRl/mvVaY+
 67lp+QfgwmLfDgpoaYnoqoAFS/uFKF1TGJ0LXPEVPObeqHLuq63WsfTbE9SCr6lSdwud
 3euVwRBKTtzfKqHIMFyLuh3JW9QdQxLwgdG68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420767; x=1749025567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bHJmoiGVFrfOQh/IiVXG8F4pb61PliK3Knpz9DRMSk=;
 b=RxJLiwKyZNdww7rtEx53BwImNtCPyy8Z+NcWbl0sem5g+CWWBFPk4ZgUeSPQDnkNBY
 Rb3lstFjQYNNMXLiV1y5B8fdBMUvurANVAb+M0erz46OZv+ZAz+/FrxB85VLjWo71ivn
 RJ6n+6iOyReOQhpjDJGQZDCOW62DsXrgMoYCCKMkS48y41BZuFv6eaM7/HeumXyCKhOZ
 EtEFnrqLcwaR5fPmDf3lKP8Iu1M/7st0+tHqT8KOhAgBpixgs7VBi7CtndY1fjaOTPR8
 pnQh6pX+65tCkMt3p6Xmxd8sR+Th1yuIYKHXAIZoemnbYbzBugGGJYZILJjMvIJr0CXq
 XeuQ==
X-Gm-Message-State: AOJu0Yxt4kkh9Gr++gcdj8ZTJ33njxpRzxVKi2ZBk24FyjWySeMTrOqB
 lGxQQOmsIHSdyVWO8qjwsUhS4y2HZKwstyyKoRith+uwXWVT9mQqaYKoCfu82mTszMEKJCFUk3r
 n0Y437A99
X-Gm-Gg: ASbGnctf0qn+DdXK+1pBztOyNHuNylB6xSfvl9196m0FWf+fW9DTfZ1+wd6vKk0g7/h
 yLmtZvhoVWABccMIxy/nrZAqGOhfAKXOA69ZfQQmSnW0BY+e6ff8h5rjssj2HeYT4IAh/Tl6o4p
 6RRwHFvdzsn12/kLO+w9AvP3OXIAfgkTbAFtnU5PMWn1vFcEOa7jsantAXA6lr7pLBMvZhiS+Na
 IcSiEUk5n2Zyb7yomgHq+kSlp7YetrBmBw8EU4pjQa7EYOc7YM+QDKZ1eJBQSohC1k/QKN/02d1
 QEYEVnCXyFlJ8gdPkd0RjUI8om4pWTUnU/WSC4b5YH4DH9TkU/sxU0RCA4RLeHG3JEJTNEcBZNk
 5UBXJg9RcOGDP
X-Google-Smtp-Source: AGHT+IHegNIN67jrKLZaRFWbMMDAHuMHGZ0T69D3/sb7Il9biKciXkiChIZJhHAaOQomLDurrVhAjg==
X-Received: by 2002:a05:6e02:3788:b0:3dc:79e5:e6b7 with SMTP id
 e9e14a558f8ab-3dc9b723ff1mr158734105ab.20.1748420766765; 
 Wed, 28 May 2025 01:26:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/27] efi: Use the correct driver for TPM
Date: Wed, 28 May 2025 02:24:38 -0600
Message-ID: <20250528082520.152391-13-sjg@chromium.org>
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

The TPM driver used in the app here should 'efi_tpm', not 'efi_net'. Fix
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_client/efi_app_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_client/efi_app_init.c b/lib/efi_client/efi_app_init.c
index cc91e1d74b8..25a9b105d63 100644
--- a/lib/efi_client/efi_app_init.c
+++ b/lib/efi_client/efi_app_init.c
@@ -308,7 +308,7 @@ static int setup_tpm(void)
 
 		plat->handle = handle[i];
 		plat->proto = proto;
-		ret = device_bind(dm_root(), DM_DRIVER_GET(efi_net), "efi_tpm",
+		ret = device_bind(dm_root(), DM_DRIVER_GET(efi_tpm), "efi_tpm",
 				  plat, ofnode_null(), &dev);
 		if (ret) {
 			log_warning("- bind TPM %d failed (ret=0x%x)\n", i,
-- 
2.43.0

