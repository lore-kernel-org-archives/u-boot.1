Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DDFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80228814A;
	Mon, 15 Apr 2024 13:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="AUTWxVNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56568814A; Mon, 15 Apr 2024 13:47:49 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20DB88158
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5f034b4dcecso1805963a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713181665; x=1713786465; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CNi9Z6qhYiY6/khZlo2Zt6Ucipmh3KxU+hrIbYOjGs=;
 b=AUTWxVNppBfa93fHnkpqzgB4swDFI//aBmA8XuZhtcthslHccDvqM0vowmu6SFx5uS
 nOWzDEjNC+CXHalHn9GMoCF1yJ5aF1Ozn8h9uOXUOvd3klBJaiEv0eRoxFv7sTFmL3UP
 wSvtB2liKKYRgzDEzmf0MeX67J/rUlueEtGYFdOYbo1tWCPad7OCwYaYfAjjMpcL1FIz
 TRQEhYzai5FFLGV12pCwLJpGXzgusmXO2MaHwH1VLSNzLKabRM583hYPPkRlPdrRH7id
 ooYhGvgNNvI09byVijYvREB+bA+Po9HaX9XMJ2/zWwpPhzSLWtIcpPuYhPQLLDD4BLtL
 r+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181665; x=1713786465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CNi9Z6qhYiY6/khZlo2Zt6Ucipmh3KxU+hrIbYOjGs=;
 b=h3dOxd3LeMB/ho7koGAPlDtw1kbpFO8mCF0oMnyAE3dGtpTfwzPrh21DxJlo5onQTE
 pco0M49CYYcR7EJCkSXWCmfSym62co5egG7FF2nIjlB09YBR0LuTJ3P4nxkZiYq7GhXC
 SKB509kZzFl59xIPJh6t9yXxclwtFITlCBOfVTBjFoc/W2kohvlDhsFN63cnv0cQS/bt
 NVKxsFUyJcWo5ONk6b1Xx9RwsKWYT3ZTb+RZJK8lfsNz5aP2fc+D137Gpi4S47QTwJL6
 hLL5itzhL3oRrFD682Dd1CPaNevvikFAybdKg2pH8q2TSi5pb5HoSvfiDzKmx3n7pUHX
 FiGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxPJGEfDo0iP/yW7ekuTlSYhRLxq3D9pCp9+htBlzRw/MBzj1wWIFJ2ztCebTVNwW2433z1VJpfIQVpbAmTTuNH5MEIA==
X-Gm-Message-State: AOJu0YzyEZL3vQb9dbicTzpmZ7LQMn+D5qjizW5+mQPCB1Eh7xNI3Hkl
 xGhV3N52ocMJGQdF2dzksETKCC7tg8X8khio/ApBaeOWiwbr86UBn+NIhEw95TCI4GlxBbc9VeT
 5ldjBd5BN5sxi3/Ac8b6yl2M3fk5EKriXGcxITA==
X-Google-Smtp-Source: AGHT+IED/ufvHqSSIk+t4dueMPPUO+kJvF2eEuXRXlmg3upgKV9ls089EiPXWt1ebeQ71SWbpuwc+C8j8PAEPw4uGSY=
X-Received: by 2002:a17:90b:5387:b0:2a5:506f:161c with SMTP id
 sv7-20020a17090b538700b002a5506f161cmr13363834pjb.4.1713181665134; Mon, 15
 Apr 2024 04:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240415105028.432404-1-robert.marko@sartura.hr>
 <20240415105028.432404-3-robert.marko@sartura.hr>
 <13b88782-4bf8-4800-8eb2-0617dd30083b@linaro.org>
In-Reply-To: <13b88782-4bf8-4800-8eb2-0617dd30083b@linaro.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 15 Apr 2024 13:47:34 +0200
Message-ID: <CA+HBbNFQ6_W76n_PaxG955h2iVNy7Ycb5D3qNdEvn-dpj0yVRw@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: msm_serial: set .clk_bit_rate in debug UART
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@linaro.org, 
 sjg@chromium.org, bmeng.cn@gmail.com, marek.vasut+renesas@mailbox.org, 
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

On Mon, Apr 15, 2024 at 1:46=E2=80=AFPM Caleb Connolly
<caleb.connolly@linaro.org> wrote:
>
>
>
> On 15/04/2024 11:49, Robert Marko wrote:
> > Currently, .clk_bit_rate is not being set in init_serial_data for debug
> > UART, but its then used uart_dm_init() and this breaks debug UART on
> > IPQ40xx.
> >
> > So, lets populate .clk_bit_rate for debug UART as well.
> > IPQ40xx requires special value of 0xff, so set it if ARCH_IPQ40XX is
> > selected, otherwise default to the same value that regular DM UART
> > will use.
>
> Ah, I have a patch lying around to configure this automatically, but
> didn't get around to sending it. Could you give it a test on your IPQ
> board if I send it your way?

Sure, that would be great.
Regards,
Robert

>
> Kind regards,
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/serial/serial_msm.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> > index 8044d38518..80069f5cfb 100644
> > --- a/drivers/serial/serial_msm.c
> > +++ b/drivers/serial/serial_msm.c
> > @@ -242,6 +242,11 @@ U_BOOT_DRIVER(serial_msm) =3D {
> >
> >  static struct msm_serial_data init_serial_data =3D {
> >       .base =3D CONFIG_VAL(DEBUG_UART_BASE),
> > +#ifdef CONFIG_ARCH_IPQ40XX
> > +     .clk_bit_rate =3D 0xff,
> > +#else
> > +     .clk_bit_rate =3D UART_DM_CLK_RX_TX_BIT_RATE,
> > +#endif
> >  };
> >
> >  #include <debug_uart.h>
>
> --
> // Caleb (they/them)



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
