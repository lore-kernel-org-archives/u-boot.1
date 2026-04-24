Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF85DFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA38843A4;
	Sat, 25 Apr 2026 18:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="crKUu69S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58668841F2; Sat, 25 Apr 2026 18:10:02 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2044843A4
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-6057723d553so4766915137.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777133353; cv=none;
 d=google.com; s=arc-20240605;
 b=LePFLIpEFyt+rKbwQigTiZKOu2YAamPvDwm9OvngY92XuNEajRsQ/Ah2FocIJurtU4
 +3BGHbdLEnlJcr1A2NYjrrwybgTZGx4n94bxrp4qbXyPR0zNbnc5VrY5XwyWOcSCtgiL
 qqT/JamVgjPnr4UlzhqH0O8d9uvZ+uGiCUmsWJ651TH2pak5jC+rZgYXU/QALjssDjbd
 LKDZqtJW0ap8R7RN6WnZN5jO4bFOs17sZM9xceqH3jPFJaZoXmi6k86LtWxJLJgVOGZx
 aNQr5Dv0a/TtXyx4I/kgWiISpYsJKVnAPiY2cggZfUkuLM7v9pirXB0H8AG9Ew5LHzjY
 lSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0KbINUcznTwYUDRhAgDqv8Bvjd9kQmEQ9E4G9BFYiY8=;
 fh=Uf01taF0Q6E+0vaXsyO3wnh4OkZzgaY6NACiptHkhsI=;
 b=KQDjAd26URANNblLGIKlsvbrB8yhJ2I9E1Ze+E/f1by6ZXv01ZgW4ZhhvYFm2XEXEn
 Ftk4u0s6IQ9NHIMhyWzACs+ZpsYKNaNW3ittxKr5YkRpzXw7Nt1awE9qbmFmdSBPN4OZ
 PElb+DAs6BANnneSOKA5vI+HYdgSDV7GnClw8o4sFILd5dMfV+7ta8n0luyqbRPkGSbH
 v7KBGOJqZNtfbCM7p16MDS0qCfjIoiLH6hWTVuW4TIsrasl+sgU4CMvm5IPgzxaRvYze
 ClQXGXzCTk6Cp7hKeOomFgYiu3OHikgJ8WOH+HXwhTUdJ59cBlLRQ2pveFe6TJn/jvSl
 jOJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777133353; x=1777738153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0KbINUcznTwYUDRhAgDqv8Bvjd9kQmEQ9E4G9BFYiY8=;
 b=crKUu69S0h9Dyic0bcUAazKAczLUycuxUixmto+H0vT5b+S7c8oG+Z97jt8Evh3dmT
 K+244wJKQawA7JICvCsenmh4GKJ1NaH7JUk6OlBiX/qou67FRJgxJ6hJRjWVz2bcb1+6
 AdolBKlCIDZcjlOCsjIcDRfl1kUFkZuH6HK9erWpxYT8auQxNTEcSjHaenpBPAQ7bbvG
 rSoA7+0PqwuSqDKYRufmJNoXxDEpp+wIF244GinZ6eceS5zX3ycOKsyMZSEHu2pCVqbv
 f3J81NtFYgkRWrTMvV7LjqrAVHThtlzJpr+StKsYcSdXcsj4AzwEkVQe+CBiF6qnYXHJ
 dZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777133353; x=1777738153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KbINUcznTwYUDRhAgDqv8Bvjd9kQmEQ9E4G9BFYiY8=;
 b=ZJTg4Frn5sk7Kj9ck2a4WYFgF0ZgbnB/pj8ha3EGDXRLVGRCB0Ng5fJJjD5nmBBbow
 lIfAJjSI2zba9I8e0nyQ3HcCNL9QgR5aqXuKgcTy6h+woOCleSc/8WBZwbuy6Tk3xRjp
 bdChl+cIcedpZfVz4vlSokP/52ozoQrsO3YHLVvyrwmbh+A9MiE2LQaWjBhbBXYBZN6G
 t0gFUZtZyqZGW8KP3uh68kkhS8l5eSMn36D3igp+Pc0hZzQ7crRUZIeKLw2Nipll+Nks
 kGEeMHa8w05vgt4ktqzy0Fa2+N9U/QsAK08BA/IoB+rZ3lFKpUCY+V5x5pTv0JG6ZG0o
 H3Kw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u/7en3uQjBVWm4RqYooK5VuLRh7HvtXJvgcsIbqhS3mA0DKUSsNfkWxKSxpoN08caScG77Ns=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi0GJxaCIxjdwx91+YPv25cdsC8ke/w+sW+/v/b2QrS7DkH4dc
 /UnoRgRLrzrbGGrtCQ8FJnhKTJBnGLH/4YnOEzAj4pOq2hSgQ0Bg57leYjaN5OslVJqw38sptXS
 eDwB5J3qTrbTkUOAPX8cZAuU6dZ+JF+N1sA==
X-Gm-Gg: AeBDietkveUAlRWzkhM7DdKOmK0i8vWbDX/dNk+xE6yfdYEBM8o7Xe9FgH8U53Yf6C1
 c2j0SVkPseQYgb0TeSCghtlHqGKtg582xSaUybt+vdAn/w91oUE3GJahA5BewjMcUndwPPw4jqf
 QJalMNdRROwxY58FBQw142kyP139JYlGUloFKEZVG/gSnAmC+kyQCWoyOEobbJqeLUhNp0JGa7J
 wNfzGTQoXxC+zxxTLu9HVfwxsaztAJiWAbDZTJMdtEDqLTJcyvUz2hxKepmPY3qwWmMtxCpcZgO
 ZnESFNjtioEDPOrebho=
X-Received: by 2002:a05:6820:134c:b0:67c:27a7:8c4d with SMTP id
 006d021491bc7-69462f2124dmr17056894eaf.48.1777044469024; Fri, 24 Apr 2026
 08:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260423130323.32533-1-micbis.openwrt@gmail.com>
 <20260423130323.32533-4-micbis.openwrt@gmail.com>
 <f2c539dc-f222-4e2d-92d2-988553ea796a@mailbox.org>
In-Reply-To: <f2c539dc-f222-4e2d-92d2-988553ea796a@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Fri, 24 Apr 2026 17:27:36 +0200
X-Gm-Features: AQROBzC1q6Yww9XRJ4eZgjVixGr8Z5rvl41rvzeLkxmMrBZBX6dshrr-CQAtIIc
Message-ID: <CAP8xZ6kEk6=8V5YxGt2L_+pCtwzh_88mVEsPVPVi0cOHX_BHZg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] usb: gadget: rcar: Add support for RZ/G2L
 (R9A07G044)
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 25 Apr 2026 18:55:44 +0200
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

> Please keep the RB tag from previous round.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Will do.
