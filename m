Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F048CF2591
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD36383EFC;
	Wed, 19 Nov 2025 14:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CUh7Rb1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB4B837F2; Wed, 19 Nov 2025 14:17:59 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A52883F6C
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64149f78c0dso9969275a12.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558276; x=1764163076; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pw5aKhMytdnB5bymrWCgYx8AlWdR0uUyCyLPUkFWAiM=;
 b=CUh7Rb1wm/7GfEmTgdTxOvTC9oZ09OwWDu2JiJUDyxCunueLbof9c9TG68/P2YWfDg
 aMfrwLITU3xXDsZ6XTcuTbOfVlOHUc0uOXBfuMTZxVU56CTTV/VStnzH+qFdeEIIa0jX
 cKmGIOxOWDBmPSf63pbfdFCwImQPzpjqMtbvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558276; x=1764163076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pw5aKhMytdnB5bymrWCgYx8AlWdR0uUyCyLPUkFWAiM=;
 b=QqVAH5L0cIlLT2HbaStnF0Tq3wwdMIYhrAGNlyxKVZHuK6MFDGDd1CDIFhmZCNUenY
 Kuv5OckFi05mLlOo7+Cd6aVp7Y1YqBrgy1vSUuumEhXZqdkBng4cha0KOunpnZINYgdd
 j/8siJbxEJY8YBqjMB47SVUZYLR/a3Bl7UqZ2mTdl+NZBjHePrWPNf20EYxBAoj8fUCZ
 vLUjZ9yml9kuFo0+wgo1ayaqOQaIIIJaGEfqP6JpLQhhV69bM06FNbt+jlAht6laXuGY
 RNgS7N/FDNlUhAnZuV4WGIZVgLaHqYysQUakW1oX1woBaDZsJ0co7fVrgs3Am5bJkhkJ
 iAww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgki6ZL0WIlp24On5CMzCmRDt0fXK1n6UJqExlX3wZzsOq4tmA5jzw4G9UA3MeeshI+Li1YGQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+305h7YGrVzsoI1Gk+ZTr8Kq8pp/cIASBWv43PnF7umZtWxOM
 DApjp7RxikynkZrQeId9nqvIBOXZfUUpBEp3pYfLhPeJlEoyND2a2h+1qJjQhbNhhqmhR9lhkUR
 6vFv2M+2xkVEj4dgJXVBaTv7+ffpJ8r2GZojVm8tq
X-Gm-Gg: ASbGncvAGBfbdxltg+AbvA84luLxKquYmO4dwONc2b1DqXkM8iSUrniZsNbRFUNfd5v
 3gon1Wx2TOh1K5CmrrLrvPGrFMgGjAEBIqaW1fdVbhUoWPPDeBbJLKLxUbZKrwJCGZFvAaA8Gjb
 nK9hX1pj8Kq9u/wEABgMZpAs/+8IeWY/kSxHznjoBzvcxTHs2QZBKuZWbR4jYlrk/uzeacPENdK
 jWrt0KwK0EmjHY6gDBp4ZkAxCSXrve9/JU3cNSmLI5j0n+DnzszRN8dQqLxTWFj23QcbQ==
X-Google-Smtp-Source: AGHT+IGFkWfav/IcsJtpjMQckwEXDPYfVnPFrn1iBsrsbLZabI7EKHLS/+hFqe7hIJooORJ0k/2sR8DAPmvyBSQ9DeA=
X-Received: by 2002:a17:906:d25d:b0:b73:6bad:4afd with SMTP id
 a640c23a62f3a-b736bad505bmr1760244566b.46.1763558276509; Wed, 19 Nov 2025
 05:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bootconfig-v3-0-a28b813dba90@baylibre.com>
 <20251114-bootconfig-v3-2-a28b813dba90@baylibre.com>
In-Reply-To: <20251114-bootconfig-v3-2-a28b813dba90@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:17:44 -0700
X-Gm-Features: AWmQ_bnJACQ83R-3Tf6-mbAdk-ya05dwQbEFre9vXdhMullwJ0cjgh3x19eBrbg
Message-ID: <CAFLszTijms9CB_C1sb+A1LZqKigsQChiBu=vnkDTKtiwbOotmg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] boot: android: Add sandbox memory mapping support
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, 
 George Chan <gchan9527@gmail.com>, Sam Day <me@samcday.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 14 Nov 2025 at 08:28, Guillaume La Roque (TI.com)
<glaroque@baylibre.com> wrote:
>
> Use map_to_sysmem() to convert header pointers to physical addresses
> in parse_hdr functions, and add proper map_sysmem()/unmap_sysmem()
> calls in android_image_get_data() for sandbox compatibility.
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> ---
>  boot/image-android.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

It is sometimes easier to do this in the caller and have the function
just take a pointer.
