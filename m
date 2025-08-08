Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDDDC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED743846F0;
	Fri,  8 Aug 2025 14:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UhPPym5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7377B84704; Fri,  8 Aug 2025 14:55:38 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89841846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-333a17be4e0so6886021fa.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657736; x=1755262536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVDfK70HapVinQDEtKbu+Dtyuy/Djkh1yMbrfID7M3o=;
 b=UhPPym5/A0fcSXATVsZUfDFXPM51MXFACF7QXUeVtDxsNtqE9bNhv6S14kz91OSX+H
 fvXasFwJI42XLYA9aP628Hb8SRggh8YWRcgdQGolqmbmNvuQh1rrRuFuww3LiAIyG3JJ
 DuEVE2XF3FNJ1yVBZ94w+t+ZlQKn3Gem3kjUoaVrxZmnvbWHuwcDJ9tcHS5Q5A94MwKq
 shO2OCyExVJxMSs8IzsxFa8gAOcN78RfFEbaK4IomamNq/NI3GEQJchMVWcGDdGQSAtj
 GYkL4hdd6wws1Xl9Kvyfl1FLGKA+nxDT1Hg9P04gvgwk9Ay2uEzWEA4VlLdAOvwhsTnd
 sKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657736; x=1755262536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVDfK70HapVinQDEtKbu+Dtyuy/Djkh1yMbrfID7M3o=;
 b=Dgn7T1i27WeJFdcUZyesCnjf8J4KiEpJ3VuOhMkO179eAwP/M04fwE58hgpcyn+Y9Z
 5ndwT0IZaJYKN6uqUoboWD/rIfwOax9wB+CMHmbmm6qssyNxna41vp6mI+5HbJtO57qh
 gAnTgh3aOrLXu3tUvRQRZj4lgTwyWEAF4u4ZZ8A6H/jdBA/GNLzglFH25P3cWZLiNY6T
 t9hAiW9ygFi6ovo9JOX3SEJdqI5QP6MgTkQkGHwN04hMVjcAr1Gk1jAuScn6oVaYm6tz
 xzbJXcjFxBMQp9uV15nJBexO/97HfNjtn4TV2oSzTEYekIQrxC4PrWZxiZb+7a8tWan9
 M0qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM36QTFNge9ytZKjhmIAdY+Y0b52xqatXnmXX3HiafSBgG+h5RMcHzqBIaiDW52UJfAb53aSY=@lists.denx.de
X-Gm-Message-State: AOJu0YywwQXtkmWaqEd2x7xHlmH5tMh0lq+tAIG/YX2MT3d4pkEhcsSf
 0zNhy+CMFXlXbM+zzLNh3hmsYLMaic5atN4hRIXJEsmwirfXsUtG1UK9fgy5u2IndL+vXF4keHu
 alMtQ/LJW8qopOA8s1/2o7EN8vMMotqY=
X-Gm-Gg: ASbGncsHNXpCqOKdEKy9W2B7c3Gl+nmzAYOtbp0NPY1miTaZAB78asqhIS9tNwqai+H
 QTTt3dAnWWtmRKYcSvZFZLSy/7geHLSstZ8fY9OHbvhHtWptT7u8tnfpSLCyUtiTzuK+SHY/NW5
 xx3qVnfzrqyc6OOWvthFp25wxN3dgAET+zICOflrTLMeIhEKj6O3hjhsAqn+lw+jKYKZH7M5py0
 oYvGihmc3nKHzT06VS4wylVUO5U1iUcQMufkA==
X-Google-Smtp-Source: AGHT+IEkSu6p/cPgFU3HpyS7lAsKkdaPkkngk+EnUBSlP8qNbT28iSXR10MHfnGcV4i5kOShidpsiNCmKnCJPDfgm9s=
X-Received: by 2002:a2e:8a9a:0:b0:32b:805e:20d9 with SMTP id
 38308e7fff4ca-333a230e76fmr4292901fa.38.1754657735482; Fri, 08 Aug 2025
 05:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250723-clk-pll14xx-v1-1-f7c865f81a06@linaro.org>
In-Reply-To: <20250723-clk-pll14xx-v1-1-f7c865f81a06@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:55:23 -0300
X-Gm-Features: Ac12FXzlPhlIf4g5g4xo5tlAigNi4_MX7CdCycz0EDQbgb68ZILfCabtnC3ZlHY
Message-ID: <CAOMZO5Bkxs-rV9suhT9aDLm+7USN=O3GAdbs5_KMKDSqKPqeeg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Free pll on error path
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Jul 23, 2025 at 1:33=E2=80=AFPM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> For an unknown pll type the error path neglects to free the memory just
> allocated. Add the free.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Applied, thanks.
