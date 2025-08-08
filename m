Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EF1C87FD2
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2889A846F0;
	Fri,  8 Aug 2025 14:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDiOdq61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E81284721; Fri,  8 Aug 2025 14:59:13 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DAE846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55b96b154bdso2035254e87.0
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657951; x=1755262751; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TSU+cOQ3GcOCSnhjXmUG1c3upey30DcyqH6Ac67Ing=;
 b=gDiOdq61LD71KJ39SVcbjb3W4advp3UkzvrScnwFx6KL+4SoNh1TU07lYxhW+MHpgD
 BcPfOhAoc+eVBZSQv6lwTWD5/XvvGEveSmyqOrgLB0aaxJptny2qNAEymZywc1rCngqG
 j6TN8N2CnW7F1xRaztLYQnP5M2l2KzBvZAuxiyl+5jkfjXC7PmZLylictmMoOnvWmw1t
 HtUVbd2mLbSjLCLK0O2QGgJ54S6tU66MrL9mrGDdyvmoVw8lQElwp5+a78l8suAIou++
 HfANJA+qCH2emsA3mOmE9YoOBaH6nm5TtGTr36Uc26x3rPYbVN+TVsNdI0rtZ6K/BY6F
 9SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657951; x=1755262751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2TSU+cOQ3GcOCSnhjXmUG1c3upey30DcyqH6Ac67Ing=;
 b=Maoz7UYqyIaEhtBP7DJP0VOaiU+ALp8/UxOIjpaJbtgNVWvD/RuuPZ/LZXoksyRx4k
 CTfyl2pYRSd1CQDKItUrIORlTAm4E1eO6WNiP8jy2lsgvxjq/u4vM2F0qTNBMRYYW+/N
 rsFPuq4ksbHNXhkmq8+ssvpp0NwVTawfbK2DHeC3dwyv9+bUkkPoaCTzq6rZn6Zu4X9z
 xMfg5DNgC1HB0I4NziPh1QlkC7sUMnDMbpeg2QARDHrweK6q3flRhTBKRARrao8NqN3p
 Rkb5Wr7oBEbANE0R4R/yT7fHggQwaZCkuvtDp2zykBT6fls9YXUhSyFqUkM4PqXk3B+C
 7XMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnsQnbQZzZOx/pjRIaJ6SHohTtYY8Xx+p/Tblbh5FtpQWZM1XZJQD/lfcOqgw6CRdu8dGxtf4=@lists.denx.de
X-Gm-Message-State: AOJu0YxmcDJabhNPFgLtFYHEb3QVb67t7077T/owLtH6iY+Nqf2b6WD9
 CfIUvqlj6U+318PUYk9jIXag5izZAzGrllAzN8MXBhWfs9WaFgJRBixVflDEczI5bWhWGdYYQ9p
 RhBFk+Fsl9nfa0x2orDlo6cAHZdzxLzA=
X-Gm-Gg: ASbGnctv6C3ZIEWePWkC4ph7BemP4y/1piapHnf+rzWF8l/ty34L7GsSsW4z5BDp+8t
 4Pbt6JIH4X9obYpR5I92HT39mWqJMT9eF0lsf7mztxOzYljuOoqOl5fBZVzYzvrAd6aTBKrcQLH
 8bO0O3D9XzQ4mHJl0bP/S4j18LWhmPqb9HpE4sOaZhCLfoVwAE7GC0En49U726t0pr7zOvuQDv5
 V4qOej31rFtHjJJxbhGvIfW0PvydfKxGS9Dvw==
X-Google-Smtp-Source: AGHT+IHQOssCZQ5BLWG26KJ0Gc0aaOJFUmk5A6U+rxZgxL34Mg+K+GjqynXEUV3S+CjMkY6SdKott1EpxpF1U49ntoA=
X-Received: by 2002:a05:6512:3d09:b0:55b:8306:a2d3 with SMTP id
 2adb3069b0e04-55cc009ef8amr770789e87.6.1754657950455; Fri, 08 Aug 2025
 05:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250804-fec_mxc-v2-1-3f99e8a722b0@linaro.org>
In-Reply-To: <20250804-fec_mxc-v2-1-3f99e8a722b0@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:58:58 -0300
X-Gm-Features: Ac12FXwL7A-t_bRlmKOgwY27g5mS1EOBfWjJnMJTyaBdJq0Hfu6NjofFFbNrWtI
Message-ID: <CAOMZO5CLDWoGvXcQETj6=uJTD5_qaNznr0ZUOYeTmjaRq9EszQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fec_mxc: Set error code on error exit
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
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

On Tue, Aug 5, 2025 at 8:31=E2=80=AFAM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> In fecmxc_probe if a timeout is detected when resetting the chip no
> error code is set before taking the error exit. This could lead to a
> silent failure. Instead set an error code.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Applied, thanks.
