Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3481FC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF32C88364;
	Thu, 16 May 2024 01:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfcNJopZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6642B8835C; Thu, 16 May 2024 01:28:57 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60ED788335
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-43df3b00becso28838801cf.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715815734; x=1716420534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FokHb3sZmSBiuNfuQFV8+NFDvBnLGYox2r8kUW6K3fo=;
 b=kfcNJopZYv1dlEwRQ+LyWXXi4z4VBNKUFuGmm9bHyhGrB6fIkGZudkIhwJY4ZV302o
 bLsBYG3IKxnla43UBsjjn6GqF8JLoKtom7DWALkZavT6i+yKD+MH8KEBaketLqdR16b/
 aS3VjShjsAIfpLELRo3Rwawys2aeTLXJnA3L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715815734; x=1716420534;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FokHb3sZmSBiuNfuQFV8+NFDvBnLGYox2r8kUW6K3fo=;
 b=gcj7ULoPkmhfDl5/aCpwzAh943OanEcHiodI9VWLbDjarsyaArVzMZHj84IRHL+UdK
 C2j0irEegoZvPVHq/uL/JwOSe4LNiBUpqdTGGVZb64judmaCPmaBsKq7DpKVTxG6m7sn
 4Hm5py+6HfLk83WPnuziGQDpW4bDVRt+7EVSL7tGSxrjWuausqg2kp69CePNWpxHGlko
 9yAf0ZwPGst5xNuulHdmpEihuDYrBLRdYraR2rusTkpwMLV28nn8XeYfCpt71wqoKSRu
 2BpFgKxFLZG9TUN8jv/dNkb8SYuVY/lfCzNG3v5qWJLOnoBYcxBSYpvWMiT1hBkixVZD
 osJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw6xCzESCfWHh/brG08sd+qpiWN+w6/UO11j8RNxbEuKFgzivTCxBjmt5SGZACTNnuHFeAkpizTVzx1KHhcpi4deEJNQ==
X-Gm-Message-State: AOJu0YzUVry5/2U8nyCcmJbimyVfFi3nKOCYTQfG4CbU3eieGptgSOhp
 BOEVGmrZwln0aRDS3hIQaPIbeZRwS0cPVXDx0yPqY9ABR3jllqqCbFDH3OQpm6w=
X-Google-Smtp-Source: AGHT+IERoXbvWUJ0N0AT2xB26l3jE2YeIjliRkTnvR0ngkTZEVVTcv6WouS2kTUhie3J13SD6QfjXA==
X-Received: by 2002:a05:622a:1906:b0:43a:f441:b3b2 with SMTP id
 d75a77b69052e-43dfdb22321mr244974091cf.17.1715815734155; 
 Wed, 15 May 2024 16:28:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e3935af58sm7978291cf.65.2024.05.15.16.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 16:28:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20240506143846.1252377-1-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
Subject: Re: [PATCH v5 0/6] Add DFU and usb boot for TI am62x SK and beagleplay
Message-Id: <171581573300.812585.12291710364879103682.b4-ty@konsulko.com>
Date: Wed, 15 May 2024 17:28:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 06 May 2024 15:38:40 +0100, Martyn Welch wrote:

> This series adds DFU support for TI AM62 SK and beagleplay boards.
> 
> I have picked this series up from Sjoerd due to time constraints.
> 
> Since the last revision:
> * Removed dwc3 mode setting in favour of reinstating forced peripheral
>   mode for usb0
> * Use of config fragments for both r5 and a53 DFU configuration to
>   reduce duplication
> * Typographical improvements to documentation
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


