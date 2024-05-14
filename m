Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D313EC25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 13:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEAAA88312;
	Tue, 14 May 2024 15:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iPfmoiE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683AC882D6; Tue, 14 May 2024 15:37:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDED488311
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 15:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0439so37920465e9.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715693852; x=1716298652;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZpozE+HyQ9arx1P8/tUW4cZhnnAU9lMCVxDjuem/+6M=;
 b=iPfmoiE5DiK38ehQt/8ppj46A7GIyrZ1xq1HG/y7p/VIv/tpJyDATR+AwB0a5MCIz3
 xk9jWgAsPRKu5ajxsPzx/1qJGh9/LKQ4eWO4dm+Kcw4wtKq5PyaO5UzabCLZHjhVLECZ
 2dMmyENuaQ4X4ltkEa3mAcZk7XBc2E3uuu3SpxfDZuFyRUneqitG3gkjLdBO5AywCsyN
 u1v1O5D0+wmhwuUUHBrcAjoMFUeY2UqhXKb6/rrI5NuaMVMrAdDSEfAenxzgcFg7ZU70
 2bvZshk/PXBbi6kQ37JK0S0NHZSBqxykJfCaA/F/+Fezx0lk4IGPpxxgo61jGzhswh/X
 W1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715693852; x=1716298652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpozE+HyQ9arx1P8/tUW4cZhnnAU9lMCVxDjuem/+6M=;
 b=GWcKKEl2PMF7JE5YznTXe1sd2OSJaldbdS8rbXIhmKYd93qC/iS3OxU2mabjWys9Az
 Gkc5AcX6Jw5jFKAQvFS0ehFNnZO15YoGHOuP2hcB2d/bGRdzXsmj7qTfsU8KJCdSw6VZ
 GwH3P8q1JTAdtNpm3gBlTs1qUDe4Lkwi3fzpVKGE/ES88aK0AeeOgIHAkn8KzcsaATXQ
 sU66Py5Otshhe7bkFuNjYW0A6Xy0OQTyc6bFNNEwvAp/ysD/3IxY3nXShtVkOEd+ocpZ
 aThDwGjfAPHTTPIQk5w6/3katYk5Shkuhdkp3Yi9rb6ZfF/S5XHXaRzK9VUAokoo0cyJ
 IrwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZEowohM5kVPhHHvxNnE+6MPA22u50Cy0ZVqouqzLYR7Kilk/E0w08SdL2T6wc8G8DyjrSPI9vtSlu2/5B+6EO66jlGA==
X-Gm-Message-State: AOJu0Yy6B6JtDLEnNoCK+diyguICRkcU4Rho+KFYEl7d3SXu5eKbC8y1
 PIeGNSZLLctywydfigxniaAMpZ27zmx8fbBNVN+hNflHEtn0lmWP+SvektgCS4o=
X-Google-Smtp-Source: AGHT+IH2j3o0wYCZDnw3S5YUonuEjkSRaQnlqBROBLXR1ubRFgaTqUK5o3zuMI3BTIsB98BhKZ+PoQ==
X-Received: by 2002:a05:600c:4ba3:b0:417:fbc2:caf8 with SMTP id
 5b1f17b1804b1-41feaa39374mr94476795e9.23.1715693852446; 
 Tue, 14 May 2024 06:37:32 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42010940845sm113834015e9.35.2024.05.14.06.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 06:37:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Tue, 14 May 2024 15:37:25 +0200
Subject: [PATCH 2/2] MAINTAINERS: add usb gadget regex to u-boot-dfu tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-gadget-maintainer-v1-2-b170f291dc00@baylibre.com>
References: <20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com>
In-Reply-To: <20240514-gadget-maintainer-v1-0-b170f291dc00@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.13.1-dev-5d32f
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

We try to split work with Marek on USB as following:
- Mattijs handles usb gadget
- Marek handles the rest of usb

Add additional gadget patterns to the maintainers file so that I
get cc'ed more often on USB gadget patches.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05217db79f7e..7fd3dd85e0a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1017,8 +1017,10 @@ F:	common/update.c
 F:	doc/api/dfu.rst
 F:	doc/usage/dfu.rst
 F:	drivers/dfu/
+F:	drivers/usb/*/*gadget*
 F:	drivers/usb/gadget/
 F:	include/dfu.h
+F:	include/linux/usb/gadget.h
 
 DRIVER MODEL
 M:	Simon Glass <sjg@chromium.org>

-- 
2.44.0

