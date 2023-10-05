Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2072BE9370D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80AA886CC3;
	Thu,  5 Oct 2023 15:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b2m1gdEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786E386C5A; Thu,  5 Oct 2023 15:05:23 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 224B8864DD
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40651a72807so8873255e9.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696511069; x=1697115869;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NB5XrK5vPAl89vFQNDRfb2f+B9+CwknqPnYXq80Eoe8=;
 b=b2m1gdEnF4Ivnv1TEU6nTnrev3yIgctLzYhPq4Uc3B4DSsI2S/WsxhHCjNgi5+qXsO
 RmzaN9+6R2KvsSFpH7Q1RdVVlJZYulQ3t4aFkrEgCmxxsGMyyY8VIbPXnW2dzsAfV9g/
 Y2yMsIKENCifg3eS08SBJS9lFc6qKxKduqYNAiS9co4/68QdqoVruEkYxtWMbnW8DvEh
 6vCMrCcKehmXm5cK+kQh8x00QcqTFjnj7VYP3ta5Kz2FnOCwNUgeYLF4oU5I2vVrhlzU
 uw63dhIqJ75XSq1noioEzDdO6+qtwJoGLCbhpXZbI+npEPkYZAoB0u9IPXeqN8cR7myd
 vweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696511069; x=1697115869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NB5XrK5vPAl89vFQNDRfb2f+B9+CwknqPnYXq80Eoe8=;
 b=oYd6PZBtCfy0flHTOSy6jqWue3k1e3d4HU6M/p+E1u+jodhdSANCQMqnuRT412BVdt
 mQsM5ywFK1zq9F12B1UCNdoIzBwKL9yXsPEIA7i9gLL7AhPzqpc00wf+nnS4xZaca8O+
 Pc0JIwz+hCuAXe3M7jK3plRC0qEFzAm1zblTXvi5nOolGiPXpMyuygMP88nltexr9vAv
 YCmxJXgR4081xnIztkfA6UkgZG3wKabh3DwVYOTKDz1Efi2V8bAmv7hKKoRp7Tv6JB7M
 YFFPpUeCyUPZyahaMtbX9SsJuJyF2V/Ppql+0iydli2kZ92D8EjpaX7dNtiArikLtlbq
 C0rw==
X-Gm-Message-State: AOJu0YwGeXZMGK4SNMbLpcbzsftB3k5cBBydexMJHKOX46Kq8CQ/Pg4e
 pqNLYYX1SFKr8ifmBj07tSOC+Q==
X-Google-Smtp-Source: AGHT+IGI5yfToaDg+RO2qDJM/u4XhgBpRSOLRs1H6cBKvaOQD88vUlsfM6Ai8LU/Xn6JZsgJaP2ZoA==
X-Received: by 2002:a05:600c:21d1:b0:405:1c14:9227 with SMTP id
 x17-20020a05600c21d100b004051c149227mr5431329wmj.33.1696511068806; 
 Thu, 05 Oct 2023 06:04:28 -0700 (PDT)
Received: from [192.168.2.35] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003fc0505be19sm1466983wmr.37.2023.10.05.06.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 06:04:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 05 Oct 2023 15:04:25 +0200
Subject: [PATCH 1/2] MAINTAINERS: usb gadget: add Mattijs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-mattijs-usb-v1-1-7e79ab31ca49@baylibre.com>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
In-Reply-To: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

It seems that Lukasz and Marek could get some help in maintaining the
usb gadget drivers.

Assign myself as maintainer.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4df79254dfe1..008c593f30ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -945,6 +945,7 @@ F:	include/cyclic.h
 
 DFU
 M:	Lukasz Majewski <lukma@denx.de>
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/dfu.c

-- 
2.41.0

