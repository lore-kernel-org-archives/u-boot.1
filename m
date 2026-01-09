Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661F9D16810
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 11:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EC384315;
	Fri,  9 Jan 2026 12:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CFNB4oEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C5A8432A; Fri,  9 Jan 2026 12:35:16 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB33D83F56
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 12:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso688328666b.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 03:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767958514; x=1768563314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u5rJWnJ9Jbggroyu/gNZDLddsj37T4LRyM4ufVBVlNI=;
 b=CFNB4oEQKiv3eHHJDszXUsdRPI43qY6mAZcW+hRvSoTmxIDVqjgVEFB0ZmOjIYeHva
 7/rDZEKemI7XrjNgW7/vwgxQTE/pE225IGuRVjGVgbEqbJoCB6AW8s+1iDo3NihlvuHt
 Plm1E9OSYJMfxQDC3IF9qwX10RoN5LZRPUooY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767958514; x=1768563314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5rJWnJ9Jbggroyu/gNZDLddsj37T4LRyM4ufVBVlNI=;
 b=S/hpdPLRUTZMJRgZTh8hbWsTRVDMjD4nfqAyQMtv/R77sjacsDkBJ/afqHKbHEXb0H
 GIR5WE+bayl89xOF/6FEXcRKu75EtifSt0mRy+kq+qyU2xEsXt0VJwC0rJ1z5fB42WWm
 cohleC/FIDGBGjZQKAVwgy8In7+/3CRjbbEDJXKBhk8OVemYb4IhA2gHJO5oySr8ki9f
 gM0ZGGfufNF4nM3mWu+DNTi3GZayHv0nC5DjMpidPSW+Gt5qBY+YOyhLTE3E88YJbg8a
 wj5CvYcKZiUscxqdz6CfUaL7qSbKMUqmAIEai77rzGLPh6ZtJVnrwnVpopSx+tP9r0SO
 0wTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVexsIRLxS5b7Uovdq0R8w8bQrw3iWOleNbks9t8zoVZdEnOq2mO2lkZ0EOQToDqlKnQ7/AWA=@lists.denx.de
X-Gm-Message-State: AOJu0YwUuoPppxRRRhxPuP4s4PsdgZe787o/1wqBYuk0yXLxpslHw+/+
 Homra7lXjEEQ2PcJlst0bRBzKo5hLLIy41e8xAOWI05LAEdzQKcRRAuZ/cvW8YKN5Tp3/Nrwc39
 lilUTVFwExrUk9kqYx60U+nUzG7A+fdoPyUTdec8T
X-Gm-Gg: AY/fxX7Pc4rivQ3dZK8X5sLdmPW48joVSSOWYVtvAgux9g9JPQ/6Mob1vHg9oyGAB7l
 0JgY9TbOw5D2nPAl36yAO89QRUpsRxo6BmwIoIsn5JjZauU8By/8gbTkqrkQZ2c8tZL6GyPWnHX
 +1lfI5wor6JMYrTE0ff9m1nMhQ5q18q+IpVkmA0UsRymenqdXv0GdQ4VSgvWoI7g4le9i1SUxPd
 0QSsiqriWDJ8oRGP5/vObzjSe5yrsetNGnY6ZD1c8camEJCJEBzLErjIyFWvpGS1zzYzg==
X-Google-Smtp-Source: AGHT+IHV9iEtoYtuyUHzmxY2oIPVdPsc555tkE4J2e2TNb4h+LzDyMwm75Kzb6hsJqxwQaggiMZcLUavHmBCiCtZbYY=
X-Received: by 2002:a17:907:971d:b0:b83:a754:928c with SMTP id
 a640c23a62f3a-b8445190226mr960062866b.61.1767958514232; Fri, 09 Jan 2026
 03:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-2-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-2-0fea56f23809@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Jan 2026 04:34:46 -0700
X-Gm-Features: AZwV_QgcAnoo43Go4ExXmM8Ty1WTzdMACc8GeHy6vj9O3jNBFp7U58kGAVEPzs8
Message-ID: <CAFLszTj+60Bumd0SucSK9dzhOHo-FcSWHF5gPax1HrWkvu6iaQ@mail.gmail.com>
Subject: Re: [PATCH next v2 2/4] lib: rsa: use FIT_ALGO_PROP constant instead
 of "algo" in FIT
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Some FIT image properties have their string represented in
> include/image.h via constants. FIT_ALGO_PROP does exist and would fit the
> bill so let's use it instead of using a hardcoded string.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  lib/rsa/rsa-verify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>
