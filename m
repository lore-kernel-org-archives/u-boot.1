Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5396BC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F4F83019;
	Thu, 17 Apr 2025 15:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GE/OIWr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E90082D18; Thu, 17 Apr 2025 15:49:47 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7164382D32
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac34257295dso153356066b.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744897785; x=1745502585; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oJWnTpd0YMIBRB/WMF8MoCeOktpTk4Apor+QNeor7yY=;
 b=GE/OIWr53HB4ywKx/F7B29gzT9FN61kcP50LzMNiw6wq2ygxYKY5O/lu0fGJEj66/L
 T2jc2hWmcaueWwIv495dHRevH9j5vgfpP64ZR+LeHrjDEUdkflhQcotkTgMzqpBjC5GT
 R0+T0QPEcIy56kGXBBEOtN/Jv/a8UmNupIYWXWc9h4P+GV/e36ULpvGiKgEXXIbcLUkR
 nevw4yn3wB2NB58Ptk7gTvAmYwJadYMmokyTbvol80mDJFqzHp3o+k2m/6gyMfCxvDNT
 Pfud3XfhWjZBFfkVo3J02DGU3KeD0GO1y0n6pWUKA0iwbuYZKzd6EgQfxF4fRV+tQaWc
 bZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744897785; x=1745502585;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJWnTpd0YMIBRB/WMF8MoCeOktpTk4Apor+QNeor7yY=;
 b=Q78z4dVZgen7K1qKqnJZqQNZx7p+z06R2KyZe0QisZTmwFOPngyMZ7og7OCyzNf2v/
 sceo8I9EWJZTR6K1EBFxb5TDF0Qyof2lqk5vXxP9DLIqanVue/TEn++2HQYhven78BLF
 9owuWFVkIHS+DTOteyAdOWsdFye7R8ZGDC2fZf/dfqzz+LQ/r9YIDxANLDWcrROvdvkX
 80RKdaxkCQGwwr4UzYJsOArRCusu3h12kzL9O9zOc0qHHNC8SvsCbLHK3BvnGr0oofbW
 YEZNkGiP7PRN08rFtppr7vtKLPpQ/J7h4bq4vxMKvtpJXhce9nfaOYcbyQwzEKaT8XsA
 783Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSrHh8137UImlu7IOX4gOouE6+EHHxnm51vJvt/XrYua0GDMMYORVDgAmV0DuwUyTbNvp+R2A=@lists.denx.de
X-Gm-Message-State: AOJu0YxxkOFC2mAfd3TpimLRYNldfuVq+vGjxmi8nU5pPy3ZTV5SJpcy
 acK2ZtVhUzXgZ055vrghK1YppmFpFU4GMYT7d10vkDN1+DPvmMLfmwKNcg73H5E=
X-Gm-Gg: ASbGncuTdpDdDZ5FT5yvYjYzA3/uRt232vBIFSsCbODB26zuJ1EnZOVWCEdR3L17RPV
 h1gIPkurqkmXSTV38RNDN17rCOY1AFw4cuMWIbYPMGTw4TGQGhQ3Gg6/K3gmidQMVrP9ZJ8n7xO
 7kMuinJqL0OURhKQgqbwtsEA4i/sKSh4jFtOvAn9X+CcGlsoKLmFF2WAtd3W+MV6cuphIRC09Oy
 cIsiwoJ/GdeyAnWtI35So86lxwFzaqP3CSZ1CSIMyZJ22X2m2yH3HB6yNRZ9epAZO+GjW7UCa2Y
 D8MJjy2oMDhHTnHgMsWMZLsUXUvA3+0hOy17s3RwTBnA3gwpFTsB
X-Google-Smtp-Source: AGHT+IEHNcP1l5uH5qWWOkEjWHz/adLw9iuCgPc+9MuZlpg5/zfSZdC7O69wiFz841ENBpykGbjhXA==
X-Received: by 2002:a17:907:60cb:b0:ac7:f00d:52ec with SMTP id
 a640c23a62f3a-acb42c98490mr496052066b.58.1744897784814; 
 Thu, 17 Apr 2025 06:49:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:893:de18:edbc:9b79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb4d5bc6fesm171515066b.37.2025.04.17.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:49:44 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 17 Apr 2025 15:49:11 +0200
Subject: [PATCH 1/3] board: dragonboard410c: Fix button cmd name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-db410c-fixes2-v1-1-76ad994da152@linaro.org>
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

Commit 359e1d4a57e0 ("board: dragonboard410c: Use button_cmd instead of
custom code") was made in parallel with commit 8f5685d5d32f ("button:
qcom-pmic: prettify and standardise button labels"), which changed the
default button label from "vol_down" to "Volume Down". This is causing
errors in the console during boot now:

  No button labelled 'vol_down'

Fix this by using the new label.

Fixes: 359e1d4a57e0 ("board: dragonboard410c: Use button_cmd instead of custom code")
Fixes: 8f5685d5d32f ("button: qcom-pmic: prettify and standardise button labels")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index 38399d65c640ee18261529ee3101b268700fa004..ab253435ae72019118c4f3f2166ac44823dc2ee6 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -2,5 +2,5 @@
 initrd_high=0xffffffffffffffff
 fastboot=fastboot -l $fastboot_addr_r usb 0
 boot_targets=usb mmc1 mmc0 pxe
-button_cmd_0_name=vol_down
+button_cmd_0_name=Volume Down
 button_cmd_0=run fastboot

-- 
2.47.2

