Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F01CAC5BE
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28D1800D7;
	Tue, 30 Sep 2025 17:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Of6EoREu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A252B802C1; Tue, 30 Sep 2025 17:19:03 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B30800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-32bd4f1b671so4954114fac.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1759245539; x=1759850339; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkydziAR9o3Jnv5PH+/fdiDn5rLF/j4j3kdkm7mw+XI=;
 b=Of6EoREuPzgYplq7B0ObL0OU99ENoB6Rp/Ijf4W1dxv7JDG6ZINCIuwSj5cyX5mzOw
 abdrZgLMSpgz8fVkz+6pr90EHvwBlyfgPXj9RwfbxodlCbfjg7ZU9ExZxeSj/aM5dMuT
 NeGmWgyJ5ELZ/MWkVqtxwZ+YZAKPUuZ8Q3tUFqKDFNXvTxqVQjzvnrSgaMc3fbwIliGA
 +HAsvPSdLCU9fMsFaJap0MyGg/cyVI/9w5qxxQt2/OnLJdyaNcnNidnqm1G4IJktLjQb
 1oRN8+UCrKniUrpzsJKp+O2HNoIQ7XXrq/kNsepzoLsrEWTGpmYFYE6igR5u5wVHCOGc
 p1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759245539; x=1759850339;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkydziAR9o3Jnv5PH+/fdiDn5rLF/j4j3kdkm7mw+XI=;
 b=rId+pu86Ne6nspvK22eTU5nmWor9xOngfaK+Lbkzhgjf+0Gz77BTeyUCQkOfw/Gvny
 wDPw18mVJ32b0Pgv66J/hTDTZgd8+oG8Wju6Sq/tQOEDi4EWy/dCfsEfDfGY5fj1WpuE
 X7v4LCLnLlO5fRJ34OlWrGYTL5pfZNFsPGjB7bFL7wuVXxNptvEbN3X7NYVuFECCiSXj
 NNIremQq1GWY/sE/6CyD3lG1BY4ShVHbdwuLoMx3XJpkFwK2fmZJLugBrt5M4y8Tyxm3
 SXG+p1FVOEsUBtgSpW1cD1y1wQvqSlB7uRWcOQ2ECo3I4CUSF08nfxG1Jk7Pw196854+
 rajA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8PZhURJgHXSAt49Jij09O5nUG4cQ19/SjyMD4pxsfObEEUwuA0OWvWBG4hIU9R12MpeSHlUg=@lists.denx.de
X-Gm-Message-State: AOJu0YxfP/ulaMYYCyU+5YaVPaYNtY01Ab4EC8Pq+PnBJQbBpRGboMfv
 JiYwL8ia1twzPsFgjbNSnpO2pi1VABuhHkvHxB9Sw3JPiaXNJlxPe61tD0VzX+y4mcM/+mqpetS
 o5rLnfNjMVr3Tr3aKFeeh0h08jzxWS5OLVQeInoBvMw==
X-Gm-Gg: ASbGncv4BAJfhFiiYjGJZZOU1vQWFy9hwaeizPBmzbcpsqU0ghjV5t2NBD5YgBzBgl2
 4E0AH1OahVWs1kjqME+NP2Akmrvy1X4VKYpTssIevSbvJvNoigTxdCrLCA3dQxfJfF1LSJ8D6KZ
 J2u/uhwwi2lHAdvP97JHWZQHW8RcFRf2H80kDDEJW/nIW8yKZA1fb+VtljionLWw0sDpSoP/XYc
 0EITrbvh+Vu/AlM0mRcNjP1S/QM6vY=
X-Google-Smtp-Source: AGHT+IFyE4tH5y9/x7zmRSQIsJpX2UILX9dqrPXioaDQqonT+glaZY/zyH0q0nRGAL9cHIUTtu1lM1WqJEybbXobgBc=
X-Received: by 2002:a05:6870:200e:b0:315:60a6:c28f with SMTP id
 586e51a60fabf-39a8873c874mr179943fac.3.1759245539612; Tue, 30 Sep 2025
 08:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250929192149.3735435-1-tharvey@gateworks.com>
 <d7279d1b-9e6f-4715-af7b-3d30ee8388cc@linaro.org>
In-Reply-To: <d7279d1b-9e6f-4715-af7b-3d30ee8388cc@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 30 Sep 2025 08:18:48 -0700
X-Gm-Features: AS18NWAtMGRqR6jbxoee-ur0mjqjLeraGRfWVtEbxYtQXts0P2UFLXITEXXVKiI
Message-ID: <CAJ+vNU1+ix30XMgM33Q1u0CiQO9ODRTcgCAXGiO-m2K_AS5zhQ@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: ensure alignment of packet buffers
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Tue, Sep 30, 2025 at 2:57=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tim,
>
> On 9/29/25 21:21, Tim Harvey wrote:
> > Network packet buffers should be aligned to PKTALIGN. Add a compiler
> > attribute to ensure this.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  net/lwip/net-lwip.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > index 660ceb10cbe..aec05d55de6 100644
> > --- a/net/lwip/net-lwip.c
> > +++ b/net/lwip/net-lwip.c
> > @@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) =3D 0;
> >  static int net_try_count;
> >  static int net_restarted;
> >  int net_restart_wrap;
> > -static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
> > +static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN] __att=
ribute__((aligned(PKTALIGN)));
> >  uchar *net_rx_packets[PKTBUFSRX];
> >  uchar *net_rx_packet;
> >  const u8 net_bcast_ethaddr[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff=
 };
>
> I'd rather use the __aligned(x) macro from <linux/compiler_attributes.h>.
> No need to resend, I will update the patch locally before sending my next
> pull request for the net subsystem.
>

Hi Jerome,

I'll make note of that - thanks for taking care of it.

Best Regards,

Tim
