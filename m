Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2ED2C559
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE7E88EFB;
	Tue, 22 Oct 2024 15:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EkL7MciS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639D188F4D; Tue, 22 Oct 2024 15:56:03 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A157E88E89
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d49a7207cso4096495f8f.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729605360; x=1730210160;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=jqytGMNoodKhxoNsBEYaeZVAlzC8loOqZEKzXNCIXzA=;
 b=EkL7MciSyav3dDLmgcnILhnE6BQNTW9I1MpYOlYdN7Cy91gcXK8qN+OYuvGIsfLnzR
 IHhteowF7vVLMQdNOw1+z6tAmcfuhdLC0kXscbncWY9jYFZ8ybLuXs0rPRaWi3ebPM0M
 bZvNzqV/FUhpADt66WuAHVEzyvbl6etM97QPdOrHY2VKoeyukQZ/NLUw81xKUAsW9d4M
 VpICGt2+/rl4n7HtktIqRt1XWUPyINk8SE94zHopeIXjnjtjVVLCP6Jy5B1SR23cYUyd
 7WkR3EmE9nKFnXWMrPCYYNHQBKltLEAVWMRgKyLVhZhADG2ndzZdeKOLW+VMRZx1jQYB
 o/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605360; x=1730210160;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqytGMNoodKhxoNsBEYaeZVAlzC8loOqZEKzXNCIXzA=;
 b=oT0aeRbUJc2sO7UVIJRW1XjE+Pl9yJiwLDeJNXR/fiJpcIkWgC8aojtxO6bP61fNrX
 xQUfJOj+E5O3hT8Ie530ZNYdGsEh+2o/gYNyo3WwiQh9rDLlu+edY+voLl8FUQ6Zzr2e
 3DF++k/hg70/Gfr8UhtAfuvRJ4twCNsAsDP1SAH+qFvgI1whz8E+lG3912A0nGaqs+nw
 Yg2t7+ftiQlVdVh9IKBV4f+IT3z0utKXk3sVewIBBDfi4LWA/eN65qmP2dr+UMld3mEy
 m2aNkK/6pETBPpsyBBPR3p+8x9GeJpdIiFtamrV7PSNVwEHZvspcsimyZn7ySROsKrHt
 L/Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmu380KgKZGGDyRAe1iYQo151UoqCJnezKxsEwi2sFGVF4KXl3xSk/ObQglWYkHCRiwcIV9E=@lists.denx.de
X-Gm-Message-State: AOJu0YyG/6dWaM0ElS/+/5PaoimnaLtfo7g/XPc+e0U3SnjOBIzYmXOF
 YlKX6kEbRyStEsssijZOyisk0VttFkU/NHBThNV///QAAm5nVbhYdXwATJt88vQ=
X-Google-Smtp-Source: AGHT+IEU7wjh1YBA/j1p68TP2AvJX+058zhv+zL8n1DZpXBYB+hU1F5CgsNiQ4SzfkLKd3k5pgSKHA==
X-Received: by 2002:adf:a19a:0:b0:37d:507f:c813 with SMTP id
 ffacd0b85a97d-37ea219126bmr8259999f8f.30.1729605359977; 
 Tue, 22 Oct 2024 06:55:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a487bdsm6722425f8f.32.2024.10.22.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 06:55:59 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Ion Agorria <ion@agorria.com>,
 Julien Masson <jmasson@baylibre.com>, Mark Kettenis
 <kettenis@openbsd.org>, Martyn Welch <martyn.welch@collabora.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Vincent =?utf-8?Q?Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Subject: Re: [PATCH v2 24/31] bootmeth: Update the read_file() method to
 include a type
In-Reply-To: <20241019152211.1014896-25-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
 <20241019152211.1014896-25-sjg@chromium.org>
Date: Tue, 22 Oct 2024 15:55:56 +0200
Message-ID: <87iktkutqr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Thank you for the patch.

On sam., oct. 19, 2024 at 09:22, Simon Glass <sjg@chromium.org> wrote:

> We want to record the type of each file which is loaded. Add an new
> parameter for this, to the read_file() method. Update all users.
>
> Make bootmeth_common_read_file() store information about the image that
> is read.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---

[...]
