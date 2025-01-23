Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D9FC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA11801B0;
	Thu, 23 Jan 2025 15:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HwU23qsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E6AE80214; Thu, 23 Jan 2025 15:23:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C9780137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so10258245e9.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737642218; x=1738247018;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/XOw0vThPs3ZVeofbJ3AYttcvik5p7h81biqVQG9J8=;
 b=HwU23qsywD878S0xRN63fT8V/uPdoKdjFlH28tb97DF151/wUEUIRg0I7JVVbKuXM5
 R1kN6MpdVVxp/6EfPWCbdYZYjhu9dAHeSO1RlRqKE1ynq0aX6zyIOn3EgAM3W6fUWoU5
 nsPiBB5CleGrDcH/U/hlLmoWHVZU4lyv64Ewyff65kyGP0yzp/r0X/gf0LQrXVLgJ52f
 hnGKxca9phbzqnQu922T742vq38LLyVc9paXb1890STYZq8e7Xwic/tpbXMAPAYf2QZs
 DQv0n5EG9s8ullRbayJY3iiYQtnS9G+5nQK5Dy3sY5gQW9LAHEtNC8Mkpp2fWB6CjQTd
 /tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642218; x=1738247018;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/XOw0vThPs3ZVeofbJ3AYttcvik5p7h81biqVQG9J8=;
 b=cmehXYxhz9hGrDc7OXZKGegUXddCad+yt7BLrepxRJUCUpd23TGJsQpOAcC7gaQQGP
 Inci9e32cIswqfD7DfIMKeJ6In651CZ7DRNYjqnZ0NA60uAxN4NGcdICbKcpYa608LSl
 5I9WYVENOPFoydWLQRhrjIjdANUZw9CSO9RGI6HhA1K6uyA0e87Oo3J811RwSHjbSHqm
 7BJdDXJzTe6jLi4zw1wUuv9Qey/9Ln1qJtieNX7BPI5Vcs8XHBjI0/qSkWHhId8fVPEL
 L6cCW95kdZwXA+pk0qKJwbKGIQIk84DiiiFZvxn/Kn2bfGJ4+ztf1lNk8XGsMJLTBmi1
 9pKA==
X-Gm-Message-State: AOJu0Yz+DrUWvb3KrW/jdvjEXvO/CJciMqtJ8YwqwOxAUgiXgcDZ4JIU
 hddEUF5zG7tXL7S8a47UOu5bNWtDl926pwHcoTgkQTy/qiGQSI7L08IVU08Iw7c=
X-Gm-Gg: ASbGncuKlv3icoGJLVCf90nEF3NNSIn7CXROniyGEXs0Pq1llnmxtDxzw6Rki/Y5kMA
 erlUbF+Vm4FVBgewFC7UBsIZpqz3kT/JviHhdKKEvbsTsJG2DvgkkI1c6GqTyvLwt2jS3fjBz87
 ARMoJBMOiaHOCLA2CJOOHt5wamzE+a49p5L+VvRqDyIf5AmThJCTAlcsNS3NJtCiQmJHavORsx7
 s+T749AYZBzi7LYfBnLdF+6NHJkxfsxxg2F8FeQ35xjDdER8oAicDqBQzaOkgZfrE8odd01IDEy
 Wmld7/jdwMDBYLDn
X-Google-Smtp-Source: AGHT+IHKIrPJsgVqqUDnvflMKEgzu8qqvQ8YUBrLvJCS3PP0BQV/tnEAELQidEV1fDbZcU15kE7Z1Q==
X-Received: by 2002:a05:600c:3b0f:b0:436:e86e:e4ab with SMTP id
 5b1f17b1804b1-4389146e66cmr276566015e9.30.1737642218539; 
 Thu, 23 Jan 2025 06:23:38 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31c8ac5sm65841925e9.39.2025.01.23.06.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:23:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
References: <20250108-avb-disable-verif-v2-0-ba7d3b0d5b6a@baylibre.com>
Subject: Re: [PATCH v2 0/2] bootstd: android: Allow booting with AVB
 failures when unlocked
Message-Id: <173764221748.269330.5680881718967065925.b4-ty@baylibre.com>
Date: Thu, 23 Jan 2025 15:23:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Wed, 08 Jan 2025 15:38:40 +0100, Mattijs Korpershoek wrote:
> Android Verified Boot (AVB) [1] protects Android systems by providing a
> root of trust in the vbmeta partition.
> 
> On unlocked devices, system developers might want to disable the root
> of trust to reflash only some partitions.
> 
> This is officially supported in the Android bootflow [2] but is not
> properly implemented in the Android bootmeth.
> For development purposes
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] bootstd: android: Add missing NULL in the avb partition list
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ae58cd7b39207175c8696d7bf38321b1a4c9957a
[2/2] bootstd: android: Allow boot with AVB failures when unlocked
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6745cbed6edc06fae7fbc4b360e39c3963d57b13

--
Mattijs
