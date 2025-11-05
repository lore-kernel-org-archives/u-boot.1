Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE33ECCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E429839DD;
	Wed,  5 Nov 2025 01:43:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bixbV8F2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BFB839DD; Wed,  5 Nov 2025 01:43:14 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9EC83968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63d0692136bso6638855d50.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303392; x=1762908192; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OfPwFOYFHeCPMKyVDPV8AZVDZDeZpY311qC3H3E/Tg=;
 b=bixbV8F2vouoI752axi0M0hDzEplhVxe5wg75FBsihzFYJLl9oKhG5V41QubRnOXDs
 rYCMmPzTwXTHZ+J8VPyshk918b5vOSpb41vo5BIF9EGruS8GYI13N8bz/7yK7hOdK4eK
 7FubDa5Yp5A1wr3E4ZCb9MKEco7wTx0uPJUmhJxnHsFUYFHa78Q/E7lvRGVrkcu/D9CV
 J4aNf8mqEA2sllTHkxHhNTS4U2x6XKZOgera3oV2YRCk8FIoswFbZZq/Tj8W6VSPhpgP
 Pky1vrDlcnvZPH2ZXh8AFBEwKTsBtkcgta0X2vOKTrnL/8RrqjNenpQGesa5Xce+80pL
 xMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303392; x=1762908192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OfPwFOYFHeCPMKyVDPV8AZVDZDeZpY311qC3H3E/Tg=;
 b=LK/V0yyB0cPjqYrA7+vm+lIai369dBd437I2JrANgj1QrMnPFu/kHi0iynMN717N/r
 LN8QBQj9DFEABt1uyjGmFIepbFTo0EpIeDtJ6VNKJEH3DuiaFigFuAen5zsdZglTkzs1
 NHhtvhjjpqgtk3GElla8eP8cplgy2SFYFqsbtPvEuprydgQ5CXmvBNR9HM2kjjUoo+Wa
 AP9wrTkbCeMl7hdjenWOqgSp3zHrcRmt5ZwBN/boimtoTJ0rbVf+lZkqvvui8b925/Qc
 n1wX516GKONDjEytSIxHRrOqVpbGQgp6EllGFqnXupskC6iR7ORaq2Efwev5YVII4HPC
 LMIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWQCBzyJOVC/MtLzVjpkcOCz79MwSRjEeaWqLhNnYN8z13k1/WsiMNU3FEW4sL05F+2snPpkI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6CqOW5u4hjsd5XFJSSL2tn0y8tIQNUU6Q7704DfIuJnX7HqPD
 N256ufZdIXVWO3WI82GCMMOK+bazjslSwwNj7LFedzYARNzElXrS7SMUxOKOvzRaevOjxUX+88y
 gL/OZZNBvszikXhYth/+ew6uskGxHYG8=
X-Gm-Gg: ASbGncv0oNmimrfqwMgOc1cmkPeMAoonKFhO/2bBXBiTdPLm/BevQGavTJFlX+vBUnK
 d4zfa4jJYhhft0gK4XXhxhAy09tRtcp19GlHPpwznLOrc2+SKM/aQMKTUrCvDKIUbkbylqNhTHr
 4DmZrbKEW8/5uA7ozTplwlbw42yR/9lepe4Z9GVynx/Cj52qkJsnMyVZPUq00cwQcR1QVG183kH
 Tjzdbvw5CD3DUBu9y0Dub5oWgqZDKWWkmeqJehLr7nldpBHsA+gCZ2myZN72GbDBoYT1TA=
X-Google-Smtp-Source: AGHT+IGBNZrWTtDwjbh/9aigIq9lqzSedxehOV9eljX/PTsj/zbyzpExCbwKa+WfHWnNsDRFTKW8DnDDpv8uXIW0Q0w=
X-Received: by 2002:a05:690e:d8e:b0:63f:b7da:17b8 with SMTP id
 956f58d0204a3-63fd34e2336mr1192912d50.30.1762303391545; Tue, 04 Nov 2025
 16:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20251105002144.93283-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251105002144.93283-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:43:00 +0800
X-Gm-Features: AWmQ_blnC0iqNJZqSmW_r1rQw8l0Y5jv0jYPb4hZIzRbVD6DGvDmcVf4LUJErBU
Message-ID: <CAEUhbmVgn_ByZenC2rPvop43N+6xFOvU0=hHnUwVLxJJaGpZEA@mail.gmail.com>
Subject: Re: [PATCH 1/1] spl: nand: typo 'destintion'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
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

On Wed, Nov 5, 2025 at 8:21=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/destintion/destination/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/spl/spl_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
