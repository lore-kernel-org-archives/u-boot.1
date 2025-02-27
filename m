Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA2BC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 10:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A8F8118A;
	Thu, 27 Feb 2025 11:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zIHfR+tA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCEA8118B; Thu, 27 Feb 2025 11:32:05 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CFFA80FE1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so7112345e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740652319; x=1741257119;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lUFu8+yzEQuKy/XVdp+Vn2+s6amZnQfJNh2Vn9gsGpY=;
 b=zIHfR+tAEkwA8+x8s3hVheLho02iFRhh2rvYP3yAOZz90UHTFocUanxcu3nGBgkFm2
 BG+xfIt8YQaCCr0GdiFbL6TGfoSk/pZNCY0OjkJOD0l5ouIc+UVNErFJD3P4zzKgEAUK
 tmdwiM7pUZWlnhh/4Nw+WQd7wJvVB2FQk7bo6JYZg1vbUiSprRcH70/XwIOWoZRHwXX1
 5AdukJuppq2Egtk6PnRlGbhXW88scVyeGQGnqzN0YHsb02ZfYlmAsQosjdBDNaAOvldC
 PUKfffWPYbW+YykTqwCOULDrDJ46FAcQkS8eqEFd7UV9OCh7uXCvB3LDwvfn3zWhlK1G
 CZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740652319; x=1741257119;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUFu8+yzEQuKy/XVdp+Vn2+s6amZnQfJNh2Vn9gsGpY=;
 b=PG5enfuRok/cbeBpWjN8KXY22k2k5rdFJMrWOf7geeaUuglbftReEBlkn6UkK2A4bk
 8E8/J+mYZn0IeQBUF30u0m7km+BeAPW7G0RLv0sH7bx+DJfdMHLV7V/z4VcPxFjhbm1v
 Cro+FA2cV+o++GOzaI2KyY+7NU+sb4RYt2sWpsUVXYF1VA1j+upbbNoBBmE7wStgc9vp
 HjKdGra59WOheRuQueD12Ix0zlvrIrbtSywomIVPaQN4VdxKkHgbpZbozFWUYFFcMYvV
 TfGU1XwCVqMRyFJV8Imt3j3de7BUnSZhy3++v96Ud5lGWG8P6fhFgs5mtZ1igettiuhU
 ympw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8swjeU6MSzqb4r9YQ5i7f9YwVeDtwLY8Wx4jph442wnEM4IHrzL6UJrA8KBUByZ5GBtBW6sU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1zHwA4wJw4tH5uyT9SpbgYWK5qE6PqOIRy/nqCXKeuRj1xm0P
 /sQ6bP8opZ6sdFzFGZrW3BgBx5jxkpZAjV4W0cbAzczBNK04bsSvywr+vxEg34vLhxm/cCKpKQ1
 J
X-Gm-Gg: ASbGncvSC0d225Q6OyVK9EgeGjMMG6yeMZjfuHvi2hqb3IsZ5TorFmjLsOS7Ulg8YeW
 Ses4tijdPFNzvXbvCZneBW2kffBExXstjdmK981dk2MUvWm3OHoNN4rJrJ4EO3GndCwm0SK4jqF
 sn+1bqsEo+ZByKwDDPeLGIUXLHcNco/Eu+iOZ84kiaUX50g0qXy56I8inV/ku0uVOyx2HPIbVtL
 aUSTwFo2qjq60q2pEf8HFNAZTe63k17URVu4NhKPIFT6wGYY2P+86RiKTIBuAErLsUEE1PiUreo
 7O2iINDMKyFBDeoUsUiecfE15MamOw==
X-Google-Smtp-Source: AGHT+IGOrosOlne0hPSztrvS98XvqPyBwW2oZS7obcc7NeVv25/nGAuhJZ7mJxejzBRgfyCOUBSF4g==
X-Received: by 2002:a05:600c:1c26:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43ab8f72a30mr63406835e9.0.1740652318932; 
 Thu, 27 Feb 2025 02:31:58 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f74f3sm18591115e9.8.2025.02.27.02.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 02:31:57 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, Marek Vasut <marex@denx.de>, Tom
 Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: am62: Use UCLASS_NOP for glue driver
In-Reply-To: <20250227102501.ggyvyzbr63iurrcp@uda0492258>
References: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
 <20250227081406.zkfylkznmlg65nll@uda0492258> <871pvj1yh2.fsf@baylibre.com>
 <20250227102501.ggyvyzbr63iurrcp@uda0492258>
Date: Thu, 27 Feb 2025 11:31:54 +0100
Message-ID: <87y0xrznj9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On jeu., f=C3=A9vr. 27, 2025 at 15:55, Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

[...]

>> I can't write that down, because that's not true. Some glue drivers (like
>> dwc3-meson-g12a) need to be SIMPLE_BUS because they rely on
>> .child_pre_probe() and .child_post_remove().
>
> Understood. Thank you for clarifying and for rephrasing the commit
> message above. Please feel free to add my Reviewed-by tag when posting
> the v2 patch.

Great, will do. Thanks again for the timely and useful review!

>
>
> Regards,
> Siddharth.
