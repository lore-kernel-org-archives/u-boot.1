Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86552C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 10:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20FEC888F6;
	Wed, 24 Jul 2024 12:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k3q1zfLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA34288886; Wed, 24 Jul 2024 12:19:41 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22EBC888FB
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 12:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so3487580f8f.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 03:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721816377; x=1722421177;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=msXaV3QB0P1wFjMF+8wM9FGD1dBsJDUrwFsPt+oqlx4=;
 b=k3q1zfLXMPZ3XeyTh+w1OrXJOBMHJGNyama1wcXeyv8P+1QVO8uubt4229rQtYckZo
 Vlnuivzkmp517CJ3tjUWCd1fwmjvQvFrhb8cAlw34XjdxVDZ2PctICZzfB3R8TcG/Uee
 m9G3YgDI7zM6hzqQAgh5wFWFZb4NZkhperf4xW18Ft29eGlkaChxzN9WgdDh8q5YT/Aw
 vEDgLQQMe1JQOECP3p58VQdna8GMw2n9GiUbHHB8s5Pdz/ldAQWSm4v0LLtqumT4WDBX
 PuEvX+B513ujjYFertmaHnMZn5AfPby1sJR5jHm2hsSc+YMfMAqylEIdByW/GYiEl5uC
 e9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816377; x=1722421177;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msXaV3QB0P1wFjMF+8wM9FGD1dBsJDUrwFsPt+oqlx4=;
 b=Nq+I2Znk/2VyrHAtFTHK4vG6sKPTK+cllK/xGbwJ1XGs02nPiSgD4c5lqSvzMhIIYR
 U5nJKJz+tN3AO52kPybvWHvUicKjRoGLn2ouiwvEPI2VF1IXURcuRYIi7T8KkFf9++8v
 4Dm1ms9xv5xixC6Zxm0fuzGm81mB65/+VyDuzKPrKDuZ3v3Hb/JYRuz+s0tvlK9CMaBy
 g8Ml+XnlD35O4+r+AEiXIr0+uEiKib+xBDfPrZIUNABFy3ZwJLbf39u6cQP8wiuJoiF1
 +dWIlHuOMPHzVo7VQr+Szy35I9ILs2ffiiWvvzneCmRMWMsHArObXr7+lyXqvpDvDmHa
 zbMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfsGqzfF3+eGxt8QdinC5WNKmOS525YYVnoKMK3NuuJRqGAjxU2N04LLPkGvH1+dWWXkAtC/N3Ilmew/06Xq+xHm3dYA==
X-Gm-Message-State: AOJu0YyBs1sOioWekAnEMp96FgxzqtZbUMElPkzcajNLhQeY+CQY6FEr
 C0GQP6nUJq6CRK9FTRNUogsfmVLHAD8JmL9q3r4TFmtQ0wjCSBKGirkOMT9fCqE=
X-Google-Smtp-Source: AGHT+IGdw4IZ6PxjLsP/iufK51eIBYyPt5VCsupbDuIra1Cx3672sxt4OKWR0c4gW4PkPOSqPnrwyQ==
X-Received: by 2002:a05:6000:2c3:b0:367:434f:caa2 with SMTP id
 ffacd0b85a97d-369bad3a81amr10023291f8f.0.1721816377290; 
 Wed, 24 Jul 2024 03:19:37 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f937348bsm23336165e9.18.2024.07.24.03.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 03:19:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 6/7] usb: gadget: atmel: Add attach/detach support
In-Reply-To: <19e38775-8e52-4581-8efb-246188b06734@denx.de>
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-7-zli@ogga.fr>
 <19e38775-8e52-4581-8efb-246188b06734@denx.de>
Date: Wed, 24 Jul 2024 12:19:36 +0200
Message-ID: <871q3j5byf.fsf@baylibre.com>
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

On mar., juil. 23, 2024 at 15:36, Marek Vasut <marex@denx.de> wrote:

> On 7/23/24 3:18 PM, Zixun LI wrote:
>> Add controller attach/detach support by using
>> usb_gadget_ops.pullup() method.
>
> It is called 'function' in C, not 'method'. I think 'method' is C++ or 
> maybe Java ?

Agreed, 'function' is more appropriate wording.

Zixun, if you need to respin a v4 please consider using 'function'.

Otherwise I can fix it up while applying !

>
> In any case:
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Thanks !
