Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B7DC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80B2E81B4B;
	Tue, 28 Jan 2025 10:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fRrW+/l6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97B2C81BC0; Tue, 28 Jan 2025 10:40:42 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95751819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so35857045e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738057240; x=1738662040;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/aVynyoazDBhAk+zdxUUsc6sVsz77oy7IP+epEWIdG0=;
 b=fRrW+/l6/vRAyzZOo4w3pOvnkRH8xisjCZgRkCcFTGchWA0Vdody7juu/9WFzu/qEj
 QakT04wTbOxQ4Kk37kDDFQ7vdtM+bJf0sDjpqnRjlVD9eExC4hd7vCTeeDup+rV/BwB4
 kasFrtvNGl/bORl9A7ANdCnCHQ0o5w18veCFK4qOuudTGpFDYIgUWObeyZdV6vwRsd6A
 RN3kBRcNM/YgmH4tZZqf4R8TTMh8wRGu/0pcApDOmbBEoGFvNd+ndTiKUq8X71Vqs+h6
 f2kYWQ/hyVqfZoEzpIGeCWcScojhwS15MeQVlcS0SiubFUWdKGr7n4oN60uyRppyO6JP
 ymIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738057240; x=1738662040;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/aVynyoazDBhAk+zdxUUsc6sVsz77oy7IP+epEWIdG0=;
 b=PBoQms/A/a/r7Ksxo1rlCblcA8rzO9rWkzadiIpxhLFmxeEBiRevYf3QqmzqhPZLuY
 kBfz5X06gmFN2fjRT0qoNn9KLEFM0nRlMSgGJBQM1erDXSVYQal1GbJf+OYYeGsFWbFE
 zXj07Nb4Q0Amxsj3cgc7GF2P9yhSdrqukpS3uSHWDNA7mhPoUtR/6YgJWLGoYMgZYNI3
 jP5nKxlyeghmcOl66wwyYNGQu0jm2jC9F+7GEupXoyXMsaQgIzWhJ0LmiAbHQjYqjEkY
 /Dz30Rqn1UrmeKBH8Ijb12Iwglt7QJn5Y6RtnfAS3bW7B3fNXg0cREqMvfQacwngYYaQ
 p2PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgfDv8BsEnd4PJX5rSjGljvKjLEIalJqOquKZUxR+rUHBLWLUPTeicVtKGDNmxnvF5KwN3zrw=@lists.denx.de
X-Gm-Message-State: AOJu0YzmzTlPFR7C7dJCsZJ4+bv9VVSuZsOs2jWlWM3Xb9K8iWO2Pg+U
 HIbEdgRVuyO4xh95ATRgJ7cG8tagWRWkCber6O0AAV6JlWJyafAUGZ0eUoaM7jM=
X-Gm-Gg: ASbGncvbwKmz7INX5p7EpzG86GBoLUgphG+yCy2Cpk70vgcMEBkAhSqI7y84Voe/xNs
 W/3iAZAsKJZVRY24joaeDu8NXE4c2DuXoPVpJqDjESxzqhbUOphoI6eCPy7UiNM+SDoEXNgGeiX
 Wkq+YmyluIbkssLOXs41Zjv6edtC2yMRmcMXgpUyFaJPYjHlbfQ5vixUshCmTPPr+2cxMZZhw2N
 JBP4GWsWxlkgdktnRsNjuAWU5XbxjBcS4RBq1Xnao2tnSpK6Az5fXSDID706RWzxzlmPz1tWAD/
 /mNLMpC3A/qRRDUt6yjHQhic
X-Google-Smtp-Source: AGHT+IHdGRbEEjCCmvWexEHeEoVj5RlzsR6swWYTZ/a0gLZ5FFH/tOAxWKFV+4vVQXX0K+yPh6p0IQ==
X-Received: by 2002:a05:600c:4fc1:b0:437:c3a1:5fe7 with SMTP id
 5b1f17b1804b1-438914340a4mr354945225e9.20.1738057240059; 
 Tue, 28 Jan 2025 01:40:40 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm13812352f8f.10.2025.01.28.01.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 01:40:39 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Michael Ferolito <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Michael Ferolito <michaelsunn101@gmail.com>, Marek Vasut
 <marex@denx.de>, Heiko Schocher <hs@denx.de>, Kyungmin Park
 <kyungmin.park@samsung.com>
Subject: Re: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when
 serial# is unset
In-Reply-To: <20250128030945.1219589-1-michaelsunn101@gmail.com>
References: <20250128030945.1219589-1-michaelsunn101@gmail.com>
Date: Tue, 28 Jan 2025 10:40:38 +0100
Message-ID: <87o6zrqns9.fsf@baylibre.com>
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

Hi Michael,

Thank you for the patch.

On lun., janv. 27, 2025 at 21:09, Michael Ferolito <michaelsunn101@gmail.com> wrote:

> The current behaviour of this function will dereference a null pointer
> if the serial# environment variable is unset. This was discovered on a
> board where U-Boot did not have access to the first 256MB of ram,
> resulting in a board crash.
> In the event that U-Boot has full access to memory, it will still read
> from address 0, which is probably not optimal.
> This simple check is enough to fix it
>
> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/gadget/g_dnl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
> index 631969b340..f2540eb6de 100644
> --- a/drivers/usb/gadget/g_dnl.c
> +++ b/drivers/usb/gadget/g_dnl.c
> @@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
>  static int on_serialno(const char *name, const char *value, enum env_op op,
>  		int flags)
>  {
> -	g_dnl_set_serialnumber((char *)value);
> +	if (value)
> +		g_dnl_set_serialnumber((char *)value);
>  	return 0;
>  }
>  U_BOOT_ENV_CALLBACK(serialno, on_serialno);
> -- 
> 2.48.1
