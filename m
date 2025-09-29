Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0BACAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB328319C;
	Mon, 29 Sep 2025 21:19:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="eobG4+bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BF658329F; Mon, 29 Sep 2025 21:19:07 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7454F82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6401f1733d7so2084866eaf.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 12:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1759173543; x=1759778343; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW40jeTs8Q/7J1Z+A8hcR2g4MFXVTMFa7b8qSIKZUsA=;
 b=eobG4+bA4LuTAWNTqY+xSUTJcsaG/zeGhkrLOT8vS0x6PAsWDJ5vigpYIyMvvHs1I+
 gXGtgPTzDdI7dTe2JRJSOfQRW79CuW/Y2ALygiw9HKsXuFsh2665nQlVh/ll20PeeSaW
 no/ryBi6Aayl4jcUktTFHn4PKqUWgo/1F0UPAQ6YUDkQi5ZsRq3jtm015z33PwTDrBCj
 02YBkK9Fy87aKzjLA5repXXbGeTCT6SeZroLphmjiy1/8X7f2/Wl+HA8ni/Bpdv6OgZK
 pRS9DtIKj09lfIUCHtsr2e81ADF1As6udZs3c2WVHNfQB8A0u7Rbjta4jq1b62IIXj6A
 j7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759173543; x=1759778343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TW40jeTs8Q/7J1Z+A8hcR2g4MFXVTMFa7b8qSIKZUsA=;
 b=arHWYGvwlpS4QBS3g7ri2SQd3N9/LIxHpGSg6RVk63AYkHu+EXkgDPPVj6sgaZ4MpO
 bXNiHFAMdaBWleqZ5blqOu/cCNWuu+W1fxowgx8/AyDfJg7DtpABTbUjhS/XwzDVlnI7
 6c4mr7gqABvOzKlMi4kuWOys8JBp+BnQ0hSEN9rvOsVjarCdzLv3RIdUUgary6pvmrbt
 yHLKKypAxyqOkqZIpziAPI5MJFiiPk+lOjo92d1LuUGME1o3rYa45I4g1ZEijqLkLX4l
 aB3g06Z+5ahM737sK0Ue+d+EbBPsoo2jPU3EQE4RVxjVdFVODg/2/7hTp2FOKgdmv/J9
 DpJQ==
X-Gm-Message-State: AOJu0YxPETrmYnfp4juZOUwPChiaUOYRtyS7VGCOpp1Zzu+YqE272FRB
 GuNWcEMgwwVUHvuxKNHftBMWcl31+Lg0pNzB3UKUZf3kzYrZEB6TVhHtSDXVPq5xf68MmOJuEdZ
 K/ydeiz2jf4l7jvAhRiXfk32sQFSAqcpLjyB8qN+rJaEafoiEW8O8gCA=
X-Gm-Gg: ASbGnct508iRSI3GNSSK+WomYdnVTQhx7ddH4am/WKBA+U/vZMYxBz+6LVIbHfohDU7
 L7z5kNmMn/NF6bhXNNo7Q3AhejyASmcqZyj+fjG+hS08e/NfEWKqW3iDEIYEI7LqWcHMEntcLrH
 5A6tAqCHUBwjjDuAJGlK//PnnDwtAookCANInboqBTM/vz4jlQJwaB49v+FgLErSZgOLmzwJ8fz
 SMzzeAoymOaHLr5aA==
X-Google-Smtp-Source: AGHT+IG7J99NtcDAKx+47syWLfdwQpqb2kDrRNYZLGZlnfyWMdgU3sEy4HbT7mXxrb/MuuS1s8O+DAo+PYnSbqlkh6A=
X-Received: by 2002:a4a:bc96:0:b0:63d:bc20:a63f with SMTP id
 006d021491bc7-63dbc20b70amr4822892eaf.3.1759173543126; Mon, 29 Sep 2025
 12:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
 <e0c32dde-f265-42b5-ba4d-29a3deaa7eaf@linaro.org>
 <CAJ+vNU3qmhCJhWbfoRFrSimOJpKxnRjx3sxKAUxqZ6tEX=FP5w@mail.gmail.com>
 <72434802-3196-47fa-ae2b-f83c5c5f6356@linaro.org>
In-Reply-To: <72434802-3196-47fa-ae2b-f83c5c5f6356@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 29 Sep 2025 12:18:52 -0700
X-Gm-Features: AS18NWCSzsJW9rnjCCgup4rpS3dmwFRZt6cbScYLIL8H381A5EQqTRpIAm2tG4g
Message-ID: <CAJ+vNU2nqccaDosgpZpo1Sf0TWFncaoU3GM3e617-=mhBhzJMA@mail.gmail.com>
Subject: Re: LWIP buffer alignment
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>
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

On Tue, Sep 9, 2025 at 12:04=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 9/8/25 18:44, Tim Harvey wrote:
> > On Mon, Sep 8, 2025 at 7:21=E2=80=AFAM Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Hi Tim,
> >>
> >> On 9/5/25 19:45, Tim Harvey wrote:
> >>> Hi Jerome,
> >>>
> >>> I'm working with a board that has an IMX ENETC MAC on it
> >>> drivers/net/fsl_enetc.c and when configured for LWIP it fails and
> >>> warns about RX buffers not being 64B aligned:
> >>> WARNING at drivers/net/fsl_enetc.c:776/enetc_setup_rx_bdr()!
> >>>
> >>> I tried changing MEM_ALIGNMENT to 64 in lib/lwip/u-boot/lwipopts.h bu=
t
> >>> that did not align the buffers to 64B. Where are the lwip buffers
> >>> created and do you have any suggestions for working around this?
> >>
> >> The LwIP RX buffers are created in net-lwip.c. See eth_init_rings().
> >> You might have PKTSIZE_ALIGN and/or PKTALIGN set wrongly.
> >>
> >
> > Hi Jerome,
> >
> > Thanks for pointing me to eth_init_rings(). This function uses
> > net_pkt_buf as the base for the net_rx_packets array which is a static
> > global and not aligned.
> >
> > Looks like we need:
> > diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> > index 660ceb10cbe..aec05d55de6 100644
> > --- a/net/lwip/net-lwip.c
> > +++ b/net/lwip/net-lwip.c
> > @@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) =3D 0;
> >  static int net_try_count;
> >  static int net_restarted;
> >  int net_restart_wrap;
> > -static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
> > +static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN]
> > __attribute__((aligned(PKTALIGN)));
> >  uchar *net_rx_packets[PKTBUFSRX];
> >  uchar *net_rx_packet;
> >  const u8 net_bcast_ethaddr[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff=
 };
> >
> > If you agree I'll submit that. This does resolve the issue I see with
> > the enetc driver using LwIP.
>
> Please do. But then I wonder how come the legacy NET works OK? Or does it=
?
> net/net.c has the same initialization sequence.
>

Hi Jerome,

Sorry for the late reply here. I can't explain how legacy NET aligns
Ok - just lucky I guess as net_pkt_buf does end up with the right
alignment there but definitely does not with lwip.

Best Regards,

Tim
