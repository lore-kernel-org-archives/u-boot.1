Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7F7C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BF08341C;
	Wed,  6 Aug 2025 16:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lM5seCDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED02683A98; Wed,  6 Aug 2025 16:56:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA4A83A5E
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-741a905439eso16709a34.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754492166; x=1755096966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMhO6um0BRcPvRHEHFLrN1zGCNzN7BHxEsYUBBdCMnw=;
 b=lM5seCDyk0bVgNsNjxC+TsOp0K9lcQMeQFbcNFh3vl7ojv3ovKYoNqSwfbRgmlccZ/
 Cs/Dps8jftQdS2v7REH1y8Ri5lx6HpFy4YTk8AbXs81YH/+RGwunBuhvbJ1nf7uu50vF
 Rt1b3Vqhj0NS2XeMu3J8pRr53fx98+FQK4mFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492166; x=1755096966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMhO6um0BRcPvRHEHFLrN1zGCNzN7BHxEsYUBBdCMnw=;
 b=lPDkyEkNyLR4OKZSDVv8UGnt/6QQbRMhK4h4jDWd0sVOBHKF7Xd8ouVsd5QoFherop
 9BpKQJ91GmiBlG26zLN/8BpEbGwjxcNbjj/QTaEDeap9UspiE27mKyrGBUB8UChUTCQ0
 gHspnrAxGdkKEemNnNf3ofjVwWuMzZTUEBLVF9TibU7IdXt3bxti8DZgtn5DCkdPJQDp
 1VRmWZaPWBi/MG05cmUP+3DuD79RvbQq3yw41sOoBPk6P3hrJkOi26foG5FqFALJ+gtc
 whGP6aCHLFIN01gRX2mI0tmxCp1LKYcph9zioTtuUNiY5yfDhBlkh8Yw7IDrCJtXDgmw
 Nl6w==
X-Gm-Message-State: AOJu0YxmjTyccpX+KGwwmBOlZtb8WDzsAb0TVTF+wntQOxxZdpOUN+l2
 JNfdegUcA4dR9HlzpB+Wp0WUyJB6wr5oHe45tLU8b6MHJBdy+mIJfym8dYY/5WSDBYuBnVhQb+c
 999D5Azk=
X-Gm-Gg: ASbGncvp8x0FhaCjgYo3c/2eoNuIVZxig9Fy4rvFKrU1pvnK2usy+BtAxxP5Izh3kGl
 SnaiNs/cgDByA/OYki+IPY1H6786C5y2Nsqz1CI6aeDGA16VJIZiIfJL1kjsi4lsGv2MPS0/Iuc
 Qx0yIj5/l16LZtHYHw1FmX74ZtOalufTqH9ShmCxapvqr5mikHbnHGdRGau4SgrUrqihvT2Kqj8
 eLgoXZWaVhr0mH5ADrYKAiZijw2G2iZqAtF/QAtB7OeGyTz/MDcG57pW8GmQtUDeO964IYV25fk
 +1THYOucXrtK2uOJ31P0ZICXmnYfmxf/PSguL+LJc8qR9sceM2RLC+D6HXpD5yV2c9+/jeB5kzn
 qixI14HscnvndLseQ7NhmMgqW+uclL+OwC/p6Iq3FWchGpy6n6zTrLvhyNCzOT339c538pw==
X-Google-Smtp-Source: AGHT+IETCoTKpIT4Hit+6vhkyWhsFFkLU7PZ4+6yQV3+ewiJxJ8lbI9hDdxNjv9Z0TUV/Nx05Tl9gw==
X-Received: by 2002:a05:6830:24f:b0:743:48c:5b1 with SMTP id
 46e09a7af769-74308e96cfcmr2047983a34.20.1754492165737; 
 Wed, 06 Aug 2025 07:56:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30ba8228a79sm1925391fac.35.2025.08.06.07.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:56:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 2/7] usb: gadget: Tighten requirements on USB_GADGET_ATMEL_USBA
Date: Wed,  6 Aug 2025 08:55:56 -0600
Message-ID: <20250806145601.1664563-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806145601.1664563-1-trini@konsulko.com>
References: <20250806145601.1664563-1-trini@konsulko.com>
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

This driver requires some mach-at91 specific header files in order to build.
Express that requirement in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/gadget/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 6201663317be..bc6ce6ec8776 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -92,6 +92,7 @@ config USB_GADGET_PRODUCT_NUM
 
 config USB_GADGET_ATMEL_USBA
 	bool "Atmel USBA"
+	depends on ARCH_AT91
 	select USB_GADGET_DUALSPEED
 	help
 	  USBA is the integrated high-speed USB Device controller on
-- 
2.43.0

