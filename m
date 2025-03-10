Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D40FC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C501D811DF;
	Mon, 10 Mar 2025 09:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QUZuNgrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B98D08122F; Mon, 10 Mar 2025 09:23:42 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D55811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso3181803f8f.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741595020; x=1742199820;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kCng6kHuU6YE7Wos7wm5IjId26fZFyc1olxRT49B4w=;
 b=QUZuNgrl+uPhjHKcWVx3HNcwYQK599xaPBCQvGBiKQJIvxPKMtT2qek36dAPPQERAv
 BxDAhjRnYKYkyXRETo7noAEk2fXdsaEDEISUBERTqNqjz09dmTVyxZj2WjIcS7cgocVB
 yGqcGP09RRQAJSyjkIez8EBVkya7dBhjEEXiEizRuvNTgb3fFF2YLLJGLMm+2ua16inP
 9H0mAKdP0289I3vZiDdPWpqUJHQhmmNQT7NaBC6asP979HKqDZ78kG0BIspe84rIkSQ+
 9WXGWsAAK4eNdmPyGdKDtBy1eW8OdcoHoiafT58vOr0ttk2AV+sOkGEtTrLbC4b/Q/ii
 nYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741595020; x=1742199820;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kCng6kHuU6YE7Wos7wm5IjId26fZFyc1olxRT49B4w=;
 b=jHsQFcP0CSzIEbxduR6SN/303SuwmEggekI+xHXOW8Rm3PcC9u2PBzBZmjT6wps3vi
 /Z+rhgZVwwi1Hn+YOyvmIkxHoTwbn0TWK/WGyq6TE08gze0RA3Ahpkj/Lu5mrY+Gb420
 OGuDkIxyMWpI26E2jG63clZEmxVfKqZle005DW8NPXQ0+IQRHdwxm0+zQMGBnXiD7v8i
 i6CtMjhppfbvmbwNUvZyQtBtzn/Qg23zDcZOFX5w82fowC/0Ggecwn0DB1WMxFG52AKF
 8p09EzkR9+tzFG3rpDEnBsevXTndgSjJVcPOQaZTupPsCIPZ+2WBvX0uZiPR2avI1/Mk
 EzXQ==
X-Gm-Message-State: AOJu0YwBhK4+mhQsYIpCvrvt74vnEr7zgSGfIqkeChI8phkIW+dKvFty
 sB8GskSzDXnnQ40aAs4OOkWOp/IfMeEKKsKON8YQYxJXgUknEvnjf2qQ/tQJhis=
X-Gm-Gg: ASbGncu2dAIZEreXIAdh61LxsAKGv/mppNNO4IJ+zvtzOW74yS45xNEnlykuBxH+0fq
 eSKH8U7MMqLzb8fpHCZtYc7ta/l5YeNQlQpmmpo5mkt/Ly22kFBHzaM1k0OBdqWMF/K0jquSFvH
 M+A3/+9cFoQMS298o33EkkBlragD8qZz8qNKmrbgbR4gExtS8d5ZdCOzUKQNacnxNPqvviHyGnC
 yhil62WpZO+pR12uLSZlMu9r79kkPzCLjroIjaBfRSd93WIXkp/Wljys8Y2w7HWZyUzSu0ugQVC
 FsnpRrJ/mAt7vzSpY6PRW8PDMKCBKyVqmlPeL+Wa2CatZZsmA0nuSqanBeI3
X-Google-Smtp-Source: AGHT+IGi1BxR+dX6tGGhQgp5YK3g9L2PSHt9yEVb+9/5w7esfUQCBmWYeXS5bPcZNSbjvb2MdUKLhg==
X-Received: by 2002:a05:6000:1842:b0:390:f116:d220 with SMTP id
 ffacd0b85a97d-3913af09864mr4114772f8f.17.1741595019659; 
 Mon, 10 Mar 2025 01:23:39 -0700 (PDT)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01952dsm13877372f8f.45.2025.03.10.01.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 01:23:39 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
In-Reply-To: <20250227205101.4127604-1-trini@konsulko.com>
References: <20250227205101.4127604-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] usb: gadget: Remove final remnants of
 CONFIG_USB_DEVICE
Message-Id: <174159501896.23928.2623190250135696495.b4-ty@baylibre.com>
Date: Mon, 10 Mar 2025 09:23:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319
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

Hi,

On Thu, 27 Feb 2025 14:51:00 -0600, Tom Rini wrote:
> The lone user of the legacy USB device framework have been removed for
> some time. Remove the final parts of the code that were missed.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/2] usb: gadget: Remove final remnants of CONFIG_USB_DEVICE
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7f061aba9af99d2e911418939f0dbd5b79911a1e
[2/2] usb: gadget: Remove the legacy usbtty driver
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6689b0c955f1ec885ed1acafc7c5d7c1565dbe63

--
Mattijs
