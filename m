Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E10C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FC083A37;
	Wed, 28 May 2025 10:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQDNQIsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210D283A32; Wed, 28 May 2025 10:37:21 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3552283A2A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a3673e12c4so2706147f8f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421438; x=1749026238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boWLqc3+TMQPj1nXQsV/VEQIcOgYgFeADl/UALbRYuc=;
 b=aQDNQIsBAGzmcJcCYrEwpLsvVFvKMy8bJFcQkSmELL8LpPeWl5w/+1jFfFa5ULU5YW
 884QMb4Nz9x+GgWG+KoolUiekaOXPuO6PkYcSLKXJKhcFYrEwnrCfP9TyyzjYiR6M0Ao
 rnW0N/IGrUEiJZMKk65p2cLWgcxhKk9/6KewKAlhcE0wHngRSexrInzi2LlVbdBNsJOA
 FQ4pbjdN2SJ5GSbs7MneNXhxtoNIUNL4zDmr+M76+uCexMAhoZoYfs+FUtlct4Lp1TvA
 TmprHdaaEIZuSB+9jdUBTqQIIfffgMxXCl1HRv2BFsiRjTomuyWrftE3crtA6IJvnl8r
 bkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421438; x=1749026238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boWLqc3+TMQPj1nXQsV/VEQIcOgYgFeADl/UALbRYuc=;
 b=bSVhRzqd71pcEPcm5sbvcPeVJcND2MUd6cKKHSg6hnvPa3bgjCo4cWDu/bOIO04+C5
 F9LTv5YDrHcyQLmGpn0OzPLfKlnzvRl6MzgWyDmg5xCoxITSHtbI1dzrDH5Ub+Kg+yXi
 PhBYB0xK95y78k6VWFqQ/g2d2qtYX0twsq/W4J0IERRlj3s/QgU8Pbe4spD+vjQbNu9n
 ZjxP7lML2A6nGOyqqKcZn6YLX/7Fmy7PUGJIC+Woreh9yMIs3tN0NiQjulvMh759plqz
 leHK35VjgNycYxvxbY5cqeaUIfJNdDkSU7bXi9gv8y9Q3S5DjsTPQDnbmRm9BM6m+Q9p
 VOww==
X-Gm-Message-State: AOJu0YzffbjefWaUKHuWhqH7arIqC6UZGInbKvCmLGkCNnoIReVmwqDU
 aw4Elp6QbEIUqlSsYvbOyW9UWYh3KxKcUgL6jkQ39zlqQx4GX9TzFQ6Yjebx0UW4jQo=
X-Gm-Gg: ASbGncsFYqzlZdSjPOKTv2TsoGHO7g4YNethIE/TRGzYRR+JtFCscohCRtIC+15jtYp
 ewAOQUKcbrKLpRv//2ZqvuAn0G6OPcRDketYwaTjAK5Edtpzvbht1Myl4laDs/8hcYkEs6e9IlB
 g2MPQCDXgw8Kdu2/ZFmFL0HMjKF1yLGXlIq6v4Li4wJn81KYNljGjSb+OFy+TwxpyPdWqDju/MC
 cgkMggRqPKsG0b9q7xjP4ST8NpqPRtQDOXL5VmXgDwqmZcvNpJY7LbujBz4kFd31uknEf/jTdSv
 HhxJ3CtdQbgm6Ni3GOrZKidDL01Vwwzvq35shjhUX8Lz03ZSES/Y+Z/IoUgYtVeS1JI3AMRA50y
 bbolyuYJIcfX5uywzB1iaNHBGsWU=
X-Google-Smtp-Source: AGHT+IFevNQpFUpeIew2r8UpVHsZWzUc3A8EdWjRyNH60O94oDzl1V/DNGIP8Xv4+C1rPxDU8VXjtQ==
X-Received: by 2002:a05:6000:11c5:b0:3a4:cfd7:dd4d with SMTP id
 ffacd0b85a97d-3a4cfd7deabmr10008922f8f.34.1748421438548; 
 Wed, 28 May 2025 01:37:18 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:18 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 3/9] efi_loader/net: Rename efi_ipconfig.c to
 efi_ip4_config2.c
Date: Wed, 28 May 2025 04:38:15 -0400
Message-ID: <20250528083821.567514-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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

Rename to keep it consistent with the actual EFI protocol name

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/net/Makefile                              | 2 +-
 lib/efi_loader/net/{efi_ipconfig.c => efi_ip4_config2.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename lib/efi_loader/net/{efi_ipconfig.c => efi_ip4_config2.c} (100%)

diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
index ab41f358de9..75131877e30 100644
--- a/lib/efi_loader/net/Makefile
+++ b/lib/efi_loader/net/Makefile
@@ -1,3 +1,3 @@
 obj-y += efi_net.o
-obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
+obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ip4_config2.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
\ No newline at end of file
diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_ip4_config2.c
similarity index 100%
rename from lib/efi_loader/net/efi_ipconfig.c
rename to lib/efi_loader/net/efi_ip4_config2.c
-- 
2.48.1

