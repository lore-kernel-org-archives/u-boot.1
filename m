Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AAAC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979B083955;
	Wed, 28 May 2025 18:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="AV0ISs9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E2F8396C; Wed, 28 May 2025 18:29:37 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E058390C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e7387d4a336so3721712276.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748449774; x=1749054574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJiVt7d71bTCzYBVj/zDSO+zrm1i2MEnV6Ksa2xzEIA=;
 b=AV0ISs9g7SUsLNb4BRY91ZdVZKCnO2p1OGjuI5qEJnz5P6LBGt3nqXukzJSoa/jZtY
 MUq8cjXsr+CKhUI1r/1N8tGzftDjZHkSV7Ej+EFk1IZbhWYOoWfFnj2nf8uPA6q+skIq
 c/xKCbuzO3l4VShY04G0Jvn+vip3jL9F8I29QUEKWIl+0u54k35VryDnrSU96x8Q3u5a
 9yDtQExz37sBXEgCuUcWZulfbgmxpr/zcsX//a1/Zbv06kZFOnsyjldeY3/NRGcUUc22
 y1uZMkNKbitA5pfNkiQgPfnK+Glji8hse56W5hH/FjtpWB56PtTwah2IX3perI1s+gre
 XAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748449774; x=1749054574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJiVt7d71bTCzYBVj/zDSO+zrm1i2MEnV6Ksa2xzEIA=;
 b=YWt+fk2weI1Q80sTUp0KRArW/E3em7BL/L0k9FEC2Q+4CdnJQpXIDucJf/DtBwR4Rd
 SVWyxxmCxsFrDMr7D/zonEqXeci3sB5ECr+FbjVLF37cJ6ShF13Utcibk+UawAc3omNW
 7T0jMv36L70BS7RYp//xngVrmXibUsaSdKsfMNoqR91A458SWnwLeDAP5nU8nq6dNuYU
 5l5Q7DpSOFrk6qc/gy7UvzgWqXvUdXtWLgp59ssXAohZh625QHc0RBUfvrWiL8DNdw99
 out2RcUvqDvJEI84IvRENC5PWyMMGK/ZFLH/0+MBtbT0Yj0kSvgdapS5j5i+e8Jzi/hJ
 GZtw==
X-Gm-Message-State: AOJu0Yz6zSpf3ZRBgPrqQBoczOHv/dlN0LN6T+2VuIIdpVwRWsLGqP0T
 jZdHJW2BSNsZe/wHE95uRDlJLRGPNTbJ4sfRApa1ytici1B2d/tK7tEOmtprg2e59wSbSZwMuHd
 GSue8PCV6iqEN6UD2ZsSSp6CccYhAPYJWyDHKD3RGrpbXOwWntvO5
X-Gm-Gg: ASbGncve29pZpIEbMusVsN1QySL1S0l4yRu7U8rFZYYsqnKNz4fkUcZRMX9H+mZUMmr
 jraodEDIjFHeGn6ghtfOLUIHDd4c0h45nRRIm3FsT1DGhwHXElDK5eI3kY5BNujdw392eSs322e
 FMTTOBhr/n06PtgfiRHCvO2KGNTwyplbJ7
X-Google-Smtp-Source: AGHT+IFtdPIkm11ymqliiIAgRvp517Jxj1r4j3sW+kgoBy3J6Dl1iSUUz5LGlC+1raNZ6zSk27mZk11HVGfrYa7XbBY=
X-Received: by 2002:a05:6902:2b08:b0:e7d:6437:2408 with SMTP id
 3f1490d57ef6-e7d91d4b1f6mr20368925276.40.1748449773367; Wed, 28 May 2025
 09:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU1=maNegZ=DiVR+OQG6B+eaGdn9v9Spz+KhYGCbzhRaFA@mail.gmail.com>
 <2b22423d-36db-4dba-8844-9bab22579158@linaro.org>
In-Reply-To: <2b22423d-36db-4dba-8844-9bab22579158@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 May 2025 09:29:22 -0700
X-Gm-Features: AX0GCFuA8ZWCXQDX0tV-CgkvWGRJ0gWML_aaYCBx5O35JgOtDaOT3YP60U4rA4s
Message-ID: <CAJ+vNU3gNAzCQzcHEY+1dkjpMeZfuxaJaaSLzP4pR_pSAt4Kiw@mail.gmail.com>
Subject: Re: lwIP watchdog not being serviced
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
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

On Wed, May 28, 2025 at 12:57=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Tim,
>
> On 5/27/25 21:07, Tim Harvey wrote:
> > Hi Jerome,
> >
> > In my continued evaluation to see if I want to switch my boards over
> > to use lwIP I've noticed that the watchdog does not get serviced
> > during at least http/tftp which surprised me. This causes board resets
> > when transferring large files such as disk images.
> >
> > It seems lwIP is missing some calls to schedule(). Do you have a
> > suggestion for the right place to call this for lwIP?
>
> That's a good point. Anywhere in the receive loops should be OK, for
> example right after net_lwip_rx(udev, netif). But for simplicity and
> to avoid pattern duplication we may want to call schedule() as well
> as sys_check_timeouts() inside net_lwip_rx():
>
> int net_lwip_rx(struct udevice *udev, struct netif *netif)
> {
>         struct pbuf *pbuf;
>         uchar *packet;
>         int flags;
>         int len;
>         int i;
>
>         /* lwIP timers */
>         sys_check_timeouts();
>         /* Other tasks and actions */
>         schedule();
>
>         if (!eth_is_active(udev))
>                 return -EINVAL;
>         ...
> }
>

Hi Jerome,

I knew you would know exactly where to put it - works great. Shall I
submit a patch authored by you and signed-off by both of us?

Thanks,

Tim
