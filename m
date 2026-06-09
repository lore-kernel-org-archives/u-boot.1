Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA2BCD8C9D
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 01:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8125784874;
	Tue,  9 Jun 2026 03:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ag7Dbaxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8339C84878; Tue,  9 Jun 2026 03:25:48 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC8584825
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 03:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-68d22a95815so996535a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780968346; x=1781573146; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hg1eHM3AlNFEaRvRIZWgNAwSZ2C24CQPknp3y6Wd5aQ=;
 b=ag7Dbaxauk1SF4EnxAh3E4ELbqe/I0yUgPeUIUCZEjCr5GO+KYn9uvy1InY9KRpStH
 gk54rdilaRCEffdyIF1Qu9mW9Jaib1+I/doYBYlaF6yyGE8/Jdl8BAg2m6bc7xYjWE1I
 cUDLppxPHdjWf8awiCdHB140+wzFkq8sRzvIbqZ3OOIu1XXZ+WZB/yG0K2qTusIvQnuO
 fdiw1ItXMS22fGjVHfkfhoWrRvoYYo2M/2+aAqdX7NYn61Fx2ER9WVzTzkupH/VZnxqs
 hLchp0lgjgtb/3hIbUZl9Al9k3Fl8F/+AK2DyGUxVNf9mLk63811jG9tQ4L9RF2XWj2P
 xI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780968346; x=1781573146;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hg1eHM3AlNFEaRvRIZWgNAwSZ2C24CQPknp3y6Wd5aQ=;
 b=jY+BYy2NnoFFLC5O97ZbIde4n+H8nDGMxI3iy52YocrBwlG+fEr9jSX7t+nALKxt6Z
 5HLf5UGkALwZzRe6xFYUG75j72coxp6Amuj0MX0v7FZ1Wm6V9s61bVfkNJyrzzy9VfsT
 5Ir11qfefavIJUWB7yfezYUANPbkTr42FthsiN6h+TIKIEPuC8zZXL5vblFt/5ZeoxDv
 QcRow/kw4LjueEYk/zNCZkGKwOOXD3DHKdt43sr9fmgJa76dIW0OW9pn2FzKO8Hc8dtw
 M2F67tsldrcxCiXq2GEUYTm0pujGQLLFJzpMqfqsNSsa5/oiGFn9NjgcTAhMJ4TgESXv
 aMQQ==
X-Gm-Message-State: AOJu0Yy1kXvGjKo/onqCmW2ZHwb/kwPGfvBDcx6280t7ez2RQiqEGNZG
 BHaYSbuo2p95plB9hbtgPISJLjaSeBX1QpYqv2xCrFVBhNvt48Ra+UQe
X-Gm-Gg: Acq92OHWPzhCJyIrU0uCggOkgERRGAJqe/equ1YJWmnifCaeqGS3hVvr9YQWeqkO9YP
 JW+tIc01ogEU1HhADG1IBcq+W9RkZKJJvOhiL6Wadx/vGcVURfCFxn70X271CAfkfcPjyKZUhgs
 5wBNPIrY5zGHLOR1ltWBx9g7wiQND+3Sz7yiMkt0YNXCXgUpZLhlUo8HLJ9I7YUfxHrz3IDPKeI
 ezSmPLeH3KEjtbmPLGLCAWuJsIuXdKLgMgIMu8ze7zwjJxEdXKE5TR5DRFFWoB7M7StQjnDwZOJ
 yIKiOvenB+QCTyD4tS2MngmUtiRs7g0UO4cOkVQVDM2coLEfpCJjItMRo9usDgtHA+YeVoVdziO
 SFB52zOsWBWskuECOzxznpI1J8irI7xuqt6gXz2cQxY6urv7WhI/LI9z5Y7YpdvCPwf49QPFozY
 lxAvr5fpGH/ec2XJRC9qYDAUz26qJSKLL4UZoMziuHtjN42YvT5K1LrgjgfXHl5XgIM8MiA1s3
X-Received: by 2002:a05:6402:899:b0:691:953d:90f8 with SMTP id
 4fb4d7f45d1cf-691953d93b6mr1564707a12.1.1780968346144; 
 Mon, 08 Jun 2026 18:25:46 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65851fa2sm7679321a12.18.2026.06.08.18.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 18:25:45 -0700 (PDT)
Message-ID: <c56873d6-36fe-48ac-84ea-8f31d174ed82@gmail.com>
Date: Tue, 9 Jun 2026 03:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 5/8] Kconfig: misc: add empty line
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle by adding an empty line between configs.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ea785793d18b..0b52515c7009 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -647,6 +647,7 @@ config IHS_FPGA
 	  gdsys devices, which supply the majority of the functionality offered
 	  by the devices. This driver supports both CON and CPU variants of the
 	  devices, depending on the device tree entry.
+
 config ESM_K3
 	bool "Enable K3 ESM driver"
 	depends on ARCH_K3
--
2.39.5

