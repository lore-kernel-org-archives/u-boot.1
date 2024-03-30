Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD803C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 20:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246B587DD3;
	Sat, 30 Mar 2024 21:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ETYhqkiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08D387D64; Sat, 30 Mar 2024 21:03:17 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E4087DD3
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 21:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so956038a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828993; x=1712433793; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNr9f8f6QDpyj0sXx4BXXGi17o5MSaDcfyAiSE2I+Ig=;
 b=ETYhqkiRtd3kcAFkKFxkzOlSZYZu04QkFISFzIvIwcn7CJGtSsJxHm4TMJU18VNdGa
 ZKl6Aa6UusFWWUoL031pSkPmPrRwUvyTxuT25PhwThR4YMEYw2OaKOCAZi04Ah75MZT4
 +mX0SQ8FTm8IBYlAlyl3s7ZOrPN5N03rPrKxCVDlhwvVXZKB9d+bDhM+UX/BxAjVFUOI
 4Hf9d2OgAru9zQFSF0qlUpBEazQLw4PwuvpGxc6a6jmnTVjEylmSI/i6DT7ABtyyKTFI
 NTC4iySQe4QCQzJ8Nv3o5Jvy0aniV0KDCW89j6Zhq4LKPKzo6SOwRrqau0ml2LQEpGgp
 7sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828993; x=1712433793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNr9f8f6QDpyj0sXx4BXXGi17o5MSaDcfyAiSE2I+Ig=;
 b=tuROebbJ3by0zJ3d0lQ68wPpC6uTaT//u94EbUHDcAb4Vehtk/bh8IRiT+/UrCnCna
 uOGS+T/aG7au8vBxRksOojAJsZqJ/S3YiM7drfwIQhM8lM4g2ZssnW9+BICg+FqTy0FP
 xvMH4JpTvmk+zff2sVr3t17qIGjVgnDxAq6piao3VXRm6OdHvmvNu7wT+wUfLFdAHv78
 PeWeEggGF39BONZ/kIjSxXklG34g564iHigXSdTR4jPeU58GCXqhGtYrpRCAOA4+5leA
 BiYcGy0sUPNTfqaQk2gS8lYUtTQWop4LO/z6NzG1fQnMn7S88VOEUnu38cGcP/EUr4r3
 sPqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2IBDwqLWQ6UdKmr+UZEte1Sem5ioWiXQojhJqvwp+ESELsdsuEkiGCLneoOhorsArIsRQtjZ1ePgtrgW7QZY4ScYGwg==
X-Gm-Message-State: AOJu0Yy42CjUO1guloGdD1ax4LU7/Eubb8/gkwbsNdWMgS/Vg7cmZ7Mc
 hdGeflK1BHqfDFj6YBQzdG+KFgAhBa9bYDFiXf3e/4qoKeTNsPzo8yrbOw6ITI3JFfzEcK2D0JT
 deBH5PnuVoZt2QVjdiAOUO199fUI=
X-Google-Smtp-Source: AGHT+IHG3r7bspQQMt4yxMupKOeW8TJrppXXX2Al2RP+GpMDlkp7gdzG8WYpsqiW6HGWvL97Le//2wWwhyP8Wg87gCM=
X-Received: by 2002:a17:90a:6ba5:b0:2a2:191a:de72 with SMTP id
 w34-20020a17090a6ba500b002a2191ade72mr4124276pjj.1.1711828993540; Sat, 30 Mar
 2024 13:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DXy8nuVPx-8uSpcVvyLFSb++S6ad64Gg0MWM3guxGZvw@mail.gmail.com>
 <20240323143454.GA3442575@bill-the-cat>
 <20240325203742.kan3xp5i3aqcd5ve@frhdebian>
In-Reply-To: <20240325203742.kan3xp5i3aqcd5ve@frhdebian>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 17:03:03 -0300
Message-ID: <CAOMZO5DqXHd-a6hhL9K9uAN_VF7rHBKaJ67mHX=7x_pXxcttfA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>, Stefano Babic <sbabic@denx.de>
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

Hi Tom,

On Mon, Mar 25, 2024 at 5:37=E2=80=AFPM Hiago De Franco <hiagofranco@gmail.=
com> wrote:

> > How much testing has this seen outside of imx?
>
> Tom, I tested with the AM62 TI arm processor (Toradex Verdin AM62) and
> it works fine.

Do you think this one can be applied to next?

Then we would have time for more testing until 2024.07.
