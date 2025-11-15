Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB29CEB2D2
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 19:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA6883A1A;
	Sat, 15 Nov 2025 20:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="COdCVEmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A34283A26; Sat, 15 Nov 2025 20:51:19 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B23A839F1
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 20:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59445ee9738so2321480e87.3
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763236276; x=1763841076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtHmCMXP2wOlBoaZxHaQ9WYzz3IJDWvI2aR5CDO+YAY=;
 b=COdCVEmkeI8jlppVGJgkQCvkmkkBB12pLmkZlPnZGRxk24uEw7OsRFeLSssJL56z+7
 7RD8FhFv2CY9aCoMk1Q4s+cc8yN3mHP3lniQcO3HM1mvRRIE4PiGLPCaavKXRgP+jqWm
 TuVns3zmDWYYLj5l0bG3evMmb1StO28qfWczL7y3rjbDJqfu4QfBvo34IuH/nOjtiHmN
 msJV3yHdq1At/yufPcC1OuvLN40FuILkTFJz+ZYzwQXPiifXXZI/xnnXCO2GSk6LAXCB
 FxoBFlWJhENg2fQ9ok0oYPlZo2Q3hThxLY3GpJafPfrPRQId/UZhY6+jVVfESD2WuUUn
 XRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763236276; x=1763841076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rtHmCMXP2wOlBoaZxHaQ9WYzz3IJDWvI2aR5CDO+YAY=;
 b=jVVl/FtXwe65lCgx9TdUloMhTdUKMWKEZtbas2NowPLpmUZTtUplA3qhaWIWV4qFKJ
 GqVcAopPs4Ldc3amTeEZKyFSb8XObGLlzrgqIl1cwRU/rJDE78db+iD+9xrq0QHdx0RN
 A25iKfcKUVT51N4Umsmrm3yh5uiBpjP93t8My2dHPDzXJtkIQ4q5PyvV1YJVNmprjXEF
 O/X1jf/VlJ8l1zx2mP8iE1a4hATHIz1kOSPTqnrX6lhFeOZ1MO/juNTjKZGmlDa/GjWx
 6GMTZ1DtxXoOGVi6wlemGfzFBKAiELQnREk/SkrDxSsoRbPRHPq+O11p1p2nO4M+Zs6Y
 5Lxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ0BA04tZzJ3unNBZN6eHMSY36B1bCcyuVJgG24cg/feCBp73AHC/w3n32TWiMvKwuzp4Hkx0=@lists.denx.de
X-Gm-Message-State: AOJu0YyhOZqTTHjf0QJNi5D0w0JModpVeg9fPPGSICQtHCCvZhTvnlZu
 46FIPtHdCb5Nu8dXFTQVyaridIxVxs0k3vXRaJQPIqH2tfjDTsvtzAzEbrlwPYXqDED4Oj0xsTo
 mX7sq+PUSelNjfFZyRLtFq+EgRZvqcsE=
X-Gm-Gg: ASbGncvwkZlwMVv/crH8H+IbY6Bnr0ETn6n9leQ7BTgWqBW+CFDClxeb3HdI+5EpTs7
 oO3YV5Vsd0ENZ63yT32tbWJsYcvPJA1mkFMPkO3FS1ttLp/5feNd44XmQFZVXUDqP2UgNes8+UF
 pkPznu120gj7+Bd19wQGFQ9l7vWDBTnTd8J39BlhrRmvYcCFxzBRLa6zHjIOgUeJxemYp4SGjbs
 NKJ8KlDd4VAigXzA6+WYMeZKQkp7xXf1RmSFD4npKVgTX6lIakmWYYw/2nap4KUCDXdbOAy89er
 8J5RKbjyrCRvFC7WY4gXSoOYVbs2Z6dmvrReRQ==
X-Google-Smtp-Source: AGHT+IF5/ChX6JuyVZsvQNu5nhvxX0jHn8UEV0qIWzgyB/6Jaig6rvkl1ykschc97pXTCbdBgP8trE3zViJmx7C6sz0=
X-Received: by 2002:a05:6512:4005:b0:595:7fa2:ad1 with SMTP id
 2adb3069b0e04-59584205e1emr1938263e87.35.1763236276167; Sat, 15 Nov 2025
 11:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20251113-imx91_pins_fix-v1-1-820933392e7f@valla.it>
In-Reply-To: <20251113-imx91_pins_fix-v1-1-820933392e7f@valla.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 15 Nov 2025 16:51:04 -0300
X-Gm-Features: AWmQ_bkJf_ka7gMt4n3Q2wYqF_BAsQwWwnAWsuz6x24yO0PSpwFoohY7YRO-hEI
Message-ID: <CAOMZO5DtoGi7J-aNZmGEuWyCkGzSj3ut6w3ptE+Zh_fpXE_qpQ@mail.gmail.com>
Subject: Re: [PATCH] imx91: fix pinmux macros for ENET1_TD3 and I2C2_SCL
To: Francesco Valla <francesco@valla.it>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Javier Viguera <javier.viguera@digi.com>
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

On Thu, Nov 13, 2025 at 2:04=E2=80=AFPM Francesco Valla <francesco@valla.it=
> wrote:
>
> Fix macros for the GPIO function for two pads (ENET1_TD3 and I2C2_SCL),
> aligning them to the functions specified in the datasheet.
>
> Fixes: a9d562daa3c3 ("imx: Add iMX91 support")
>
> Suggested-by: Javier Viguera <javier.viguera@digi.com>
> Signed-off-by: Francesco Valla <francesco@valla.it>

Thanks Javier and Francesco:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
