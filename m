Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BD0CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 12:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D907A81D6A;
	Wed,  1 Oct 2025 14:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVh6fqU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2E58349B; Wed,  1 Oct 2025 14:02:42 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979F1800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 14:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so26035035e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 05:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759320160; x=1759924960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+bk0fJA28VYDWMdHSPYqnvRmAw77utun3GmQhSqVDA=;
 b=dVh6fqU5H7Kc+bz8mV2n2QPsmXHkFvF1RO+TCsTFEihkYyqyLu7j2REd9bAG1rqd30
 AqmAgd+MguLXgTBs24Rjt5EnuZZfEuS41DSDp89tcfQ4PPahvp2Qk7WvykJB48pxMR5U
 aNI4t6g5VqENDOXWfEqxvkFj2NuUUiYmadOxWYMGqILdHJJ2lw8AnTxQ39i3pLGqOQ2A
 p8NGWvGLxYi4qhFdLmwL+O30sC4P4cEbVhELM625yes1Xm7E1nqEfS/VcVUxf79Hly3M
 DyuAVknrrpb7I0P6CymL/TaYjnXiEJsbREX0DsHS3s+QFTRY0nJ4piYCwni36qpZRUB4
 UjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759320160; x=1759924960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+bk0fJA28VYDWMdHSPYqnvRmAw77utun3GmQhSqVDA=;
 b=Ngb6JXrm6hioBd4IIlNNbS/i02XpXJKSUro/EPa53ehQ/cBNYYgM0eSdqVza8FXXCO
 U2RCSLaHMVdfRKeWdjhv+3kuZV68VSp0bq3vP1FWpkmgG6kqvD7cfLBdP19qYFgYC5u0
 ltaL0XLGQL/7knDgW1Y+NxVBn1myIBEbBCtjutcDTay0IGGKrXbL0Ox2uCLyKi2QVuW0
 sh9CzgAbGO9C5jDYYVOP6x+9PFwd+SY9gy3yvk+rFZ227IZIWXUIpF+bzDsAT8eOKQse
 iKnQowsUkPaRfdi2+K0tiNRuOftR/y+grxWX3n8RwRraOB3G7tc2bE6xJEku++QEjWCi
 yy3Q==
X-Gm-Message-State: AOJu0YwyN85uDC7CV/4mtpxX8DGjYd7udufJB0Wq4IxiaAzmKg49ImcV
 NaRp+sXNvqLGnxZCyxQVfGrt7DUIwQUt8WTN4funYnjHvjJWA9eOVkKd9XY6q8D8wwq7e2643JP
 B3jqgPXidQBkRQnrMyH0JIEYpv500I1I=
X-Gm-Gg: ASbGncsmG2BMdXg/vzX0vkNMxeWlsNmwY3oupyMaJKIQmKbrsfwimrJG6E/DFk9NGLt
 /AMdEGVqILQc5Yw8o7Ehf+P7k6TH8GKjYuaaP0IOfE1sU2eb5N1MZRTE3Mhd9OO/RbVwN7RLbpS
 k47Wn1NSkfpyqr1ObjcQCTGGNhtSDZhXS+Pp90u71k9Aj54FocV4GxAi+ib167RNhycB3hHFy33
 oP4/LOBxb+aYifjHQiZFKv5YxU1+bm4
X-Google-Smtp-Source: AGHT+IE5VrtbWUT0L/vxz9QsJvFDazRM74/G1kjZ4rbxtlIkAAms6xTK7yzme7L7vEqeyZapgmNoKmtR/o6tZ3CQ3Wo=
X-Received: by 2002:a05:6000:2dc3:b0:401:70eb:eec7 with SMTP id
 ffacd0b85a97d-42557808ad0mr2321077f8f.43.1759320159659; Wed, 01 Oct 2025
 05:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
 <20251001-video_tegra-v1-1-faaf48dad062@linaro.org>
In-Reply-To: <20251001-video_tegra-v1-1-faaf48dad062@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 1 Oct 2025 15:02:28 +0300
X-Gm-Features: AS18NWC6IzsDbEV3v2yJqIKhuz_Lo4G9db429iSU8AcyUyABJQybm7zFpXMVzEM
Message-ID: <CAPVz0n2UU_My4-8Q_3m5bQo_Cy5No24A4UPEWNknPouAJKtdCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: tegra: Remove unreachable code
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
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

=D1=81=D1=80, 1 =D0=B6=D0=BE=D0=B2=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:55=
 Andrew Goodbody <andrew.goodbody@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The goto immediately after a return is unreachable. Remove it and its
> target label as redundant.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/video/tegra/tegra124/dp.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
