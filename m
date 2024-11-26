Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D818D3B988
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 12:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84B6896AD;
	Tue, 26 Nov 2024 13:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdt8OfEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260B7896AD; Tue, 26 Nov 2024 13:00:04 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BDFC89346
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb388e64b0so59718371fa.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732622399; x=1733227199; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtbV/p3J9ZuSFW4Xpo0gxng1ggDhxw/0RbgBq3b4JjI=;
 b=kdt8OfEzYmtp1IRrUZr9VtacwXjqfROKozrQ/3obX90Jdr35uoInE2g4gdZKKT/xEi
 3KFhraXFogsH/kk9rJG3LL7Xu+UFQ0yvjzPjyeWhuR21pHCbNq5Amf6qtmnozmDDkHdV
 NxVIQOoocYvHtWAhRWz3H1mf6/3O+irslWOt9TJfcXFoWpimChSvnGHBPdYDa1G7/rmb
 vWp70anhgJSeCVriD6mcJF6eqx2hMdWY//Jgx2zE7J54RqQQ8uIRcv0JqfFsVJoS/JEG
 0R9FP/JsWtzK5pBkD2aJOngAQTYEnkWYpbvg0RE2+fnz57SiQUdJaLmx6IVrnw4h1T5n
 cUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732622399; x=1733227199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtbV/p3J9ZuSFW4Xpo0gxng1ggDhxw/0RbgBq3b4JjI=;
 b=M3Yu5iOkFm+HYCnsCELFAR2LNQQVL8uJeE6hl+jLfpsbUtNF9CeozM30uaF0+ikcw2
 AQLUXOxCCGPIlA7sff9psrVxGzZi97fFmFvYZXnsT9IyjoGmZly96aUnOQMYCRyJ2aUa
 oRNtJLg3jCrviImFppcTY2sI3My0UA6BKPyzfyE3KCY60K6M+iMUt4T93ndkJM9Bejfp
 LKFYNJVBj2i54rbB++130DNXFgIOvSMxCw/YL4sG0NGCvCxVmOI1JxbJMVnqoqRd3LyL
 aVtoyxIzZZeT2T6dejsMLZNSDM2xp+9t/POcTAEyrh3XEP2MgENPXUOtWHDgwFsEC+Df
 zXcA==
X-Gm-Message-State: AOJu0Yxr+8Mk2iuznZtIRzckID88JprOZ0lFxAYEbUTZRt8+j2xopzXn
 mjPXeQB74ylOrB4HmUd1gLG9SyZP2XJlLt0IXJQK7aqgtCmFAxRA81+R/9e4+TWp0eDdAoNhERB
 lw4L709K+2PVV9E5ZVEpYlfAqWZOcHQ==
X-Gm-Gg: ASbGnctx+pF8hwkxEpL8QsJj/kjQ3a24otgI142R9O8/IOTWHOKAmGPyynkWTKmrdWR
 YhmF/0syA2c6i4XGwnGjCa8GZS5vYEo57qjOA9O88fxFMUYUPtRDEzWaNgGZF1UM=
X-Google-Smtp-Source: AGHT+IGj6xrSME6NBc51j8jKSfo0fWnUwGUgRYZo46o8ynXdZmmION0phBDk+L84TajN1uRfSrhqtHyevUUHU3U0+VY=
X-Received: by 2002:a2e:be05:0:b0:2ff:c8a1:c4c8 with SMTP id
 38308e7fff4ca-2ffc8a1c708mr32286691fa.35.1732622398750; Tue, 26 Nov 2024
 03:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20241122102938.4080117-1-y.bas@phytec.de>
In-Reply-To: <20241122102938.4080117-1-y.bas@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Nov 2024 08:59:47 -0300
Message-ID: <CAOMZO5B6QDaZatwTP48r=vOLpcHtjr2Th5XayrX5kmgG4BBW6g@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: phycore-imx8mm: Add EEPROM detection
 initialisation
To: Yunus Bas <y.bas@phytec.de>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Nov 22, 2024 at 11:06=E2=80=AFAM Yunus Bas <y.bas@phytec.de> wrote:
>
> Add EEPROM detection initialisation for phyCORE-i.MX8MM.
>
> Signed-off-by: Yunus Bas <y.bas@phytec.de>

Applied for -next, thanks.
