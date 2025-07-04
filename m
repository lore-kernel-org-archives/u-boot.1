Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE8C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 16:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86578277D;
	Fri,  4 Jul 2025 18:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z1OMUCMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1803B82A76; Fri,  4 Jul 2025 18:54:53 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C349803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 18:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-32ac42bb4e4so10028361fa.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648090; x=1752252890; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuD3NtXpi6Bx2Z6rKi5t7tHr+a7ddMPzV6q81lRjovA=;
 b=Z1OMUCMmoiSSAuYnQIsLgFS76+Yj3PwWaTQuitXMVprikZPsCbqkh+twv3rSLRbZKI
 oNEzL4sJJbd0jJeWVDMmLydZzLhSVmPF7uTl4+3AmZsWGDVYH4X9ZIb4liyKBPaac3Cf
 s9Ol1xeZ+gCsFPsILRtR9NoQ+44HBQ4MmsbT30+QRHbi7qy6VC7yZElvJcfuKtxoHNk9
 AEp47A2zv7LYnCLfran4sXxZ+gBRqowAur0aUCzhutSIOIy6F+iCqwQNnY9QjP/XgPxE
 1oB3XAQ2juRy9d8FuIltyyXKtSAQR0RL9R+R+XikBlyBd3vsYKKrBCvqWOCXqAghMZq2
 TjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648090; x=1752252890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuD3NtXpi6Bx2Z6rKi5t7tHr+a7ddMPzV6q81lRjovA=;
 b=gZBO6fheuWIbwnta9Qf6MoNPM0KawggQwKFPG5iLZf5PeJLVmtQp/qgsTIww6CJCoJ
 L4YPHh+Wnjo5nmMP1Uyen041fZy4L++YfkLC2dfx2E0uWhOBepfLrL75Tug49I+zLt2J
 12RC9YwTSZQ5IfGYDfOp17sOue2Db7VXnxaHXdfIlSJo/VjvXEadbZQGhvWq4OmCtPar
 Z9z4WlWmiWKxicIYTlOZIYGkeKgVNxLnqU1jffBBQGv78MYinyjuigej2sDIq850OjmE
 HWra1ll+eVPK15ZPEAfcXhCVt8c2oR2OOoXfm7WVCxuaJi3B7W6LuwMQsA9LTBIJPom2
 XPuQ==
X-Gm-Message-State: AOJu0YzFfS9ykO1wMqR+YZSiq5akfpRICWCFCOhR6KGt3TRJyQZXiviH
 1A+GhPG799YkARJczR3TwF6vytjC8G812bbduJHogVB37sTHzkkrq+hb5ioBDZ8b0jZp96VNkT7
 +EhJw56zSfaq/yADwq9qj7nQhn2JUxcg=
X-Gm-Gg: ASbGncu6HawSo0R1RgB4K5K6SqAHj3oSiXGF7gaRHAYRYLAMdCZQylyz6kGDAewx+9x
 UoZObmcmjHsp5UaVzduE8XXWSkUqlldCn6uJ/GUZjdPOjHJHYng+MeLQbIHYEp/ZCvN5ptysAns
 mjVPc/FaoXdWyaIsDkcTrBEJdtVY4vlXUH7dTFzP3gQsKB3CAFa7oq7v2FCPE45LSLkL6pOR/uv
 w==
X-Google-Smtp-Source: AGHT+IG83tk+2BUkat5V5idZN+SM8HQ+okibTvijirLUVFxUYGbxtPEXgFTn5hraik/eFqpbUERWTM0XSz3uMzrpj70=
X-Received: by 2002:a2e:a582:0:b0:32b:488a:f519 with SMTP id
 38308e7fff4ca-32f00c889efmr9850581fa.6.1751648090115; Fri, 04 Jul 2025
 09:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250704144022.3946416-1-festevam@gmail.com>
 <20250704155611.GH6424@bill-the-cat>
 <CAOMZO5Ck=ufscXJ8KFyy+Ee-fPJNtHFKTFMCGdQ8t0uWVbFfHg@mail.gmail.com>
 <20250704164655.GI6424@bill-the-cat>
In-Reply-To: <20250704164655.GI6424@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 4 Jul 2025 13:54:37 -0300
X-Gm-Features: Ac12FXxZT26YsAuhIHriZ1cug-L5ns2Kjo50XYJ9uUD31mIceK5z-HHy3FdHeIE
Message-ID: <CAOMZO5BiL7uDjGr767q=DKZGjvP9xpszZYssHDHKEA1QKAYMTA@mail.gmail.com>
Subject: Re: [PATCH v2] mx6sabresd: Reduce U-Boot proper size to fix boot
 regression
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com
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

On Fri, Jul 4, 2025 at 1:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> I think Jerome has the wrong idea here. The previous problem was on
> armv5 CPUs, armv7 CPUs are thumb2 and aren't tripping this problem. I
> suspect that if you used gcc-14.2.0 from kernel.org to build, current
> top of tree mainline would work. I think we should still take this patch
> as it's both correct and saves much more space so that we aren't quite
> so close and so dependent on gcc optimizations.

Okay, I agree.

Please apply this v2 to master to restore the mx6sabresd boot.

Thanks
