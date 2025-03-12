Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B5C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25D68141D;
	Wed, 12 Mar 2025 19:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjaJfKIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B138169D; Wed, 12 Mar 2025 19:22:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FAA2807D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d0a5cfd7dso702525e9.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741803757; x=1742408557; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Ph+CeJatHpFnnV/JkM8qJEXycKaExdC/b87Xymt9eo=;
 b=FjaJfKIsdY4zEeSuxUCxHXOuIGS21mDKTkcKjb+AB+dFo3GDc4WL08NeDud8IEBNJF
 Y+19hKApExZZaS/ZWF8M93TLDz9U7NJIvW/myuKXcrLfq+9sQjTSN6MLi1aa1KfhzyHm
 nQVhF5MafjbzcqKbFxhqu8Rs8O1qhFgi9cALEFdWz3IyCFaoPqrcWqT5IMvBLiyYynZE
 g9X62/5w5NEsF+rjb68NjsugIUaALER6co/rnFMl3fRxW17gJOdRXowSLCK37nmG5g0v
 38y/4U9Un6BqJPx4MlxTphyGQWEaq7HbWT7Fo9S88ba73KK6O/WsAD3ip6jNY2znAPBc
 tcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741803757; x=1742408557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ph+CeJatHpFnnV/JkM8qJEXycKaExdC/b87Xymt9eo=;
 b=wp8X3EcB1mR2AODiKjiA55QzzKOXxwpkfTfrFHfzmikkXsnPf/FJ0iUP7dwkgIkC7R
 lmKErw/iEfQjBxeR/goJ4rRAaVOyMdjihddPahFIzbtzOY29fr/k4ILsBd39UfEhSk9/
 C6wIbEB43EEU9YcKMf0nvat7njTD27DCc1dLXUWpxLl2Lb0QZHgjz5Kxt6U3yEWop1zW
 RAjqr2udfJv29RHV/UrV8gJhHre/5tT0GGqy/TRuppA5QIIIOjR8Za/QQsm+ptEnjDcK
 KFo1pDIo+FqfyJsA9tf724ZET7KiOtKKoliOQnNFH+OahYZOMM3COx6G/LEpa5ZgF3g2
 JjZg==
X-Gm-Message-State: AOJu0Yz+1PJ4FLqUczmJGwfDmYjGqlsoRbSoqeuuek77wy2hS+OcJBhE
 IcpnUZ4GnWl/JTYeUYCYxNqycF5R2SVFTFPF6frm52RBCxrEhwCPzJPr36CFg0JII0bEcR2Am44
 w7FRkdkTjXV713Pxadmb/qwjMv+o=
X-Gm-Gg: ASbGncvWNpzTbL1tp5dw0+pf4bM18nUKHcMxGmZY4X4YUhzmU/m45Yc/F8rqxQzSbfS
 jTptofWpTRimKDhiQq12+PTDpmIJsXqszLTAVxcdLOeGSVBRfimTblEy/0vR4t92s4h9XRYxIc5
 XOILxaImFUpwB1szi2r5xPjc/Zem8=
X-Google-Smtp-Source: AGHT+IFy7/82uPtN87UZKxk+EegKDphVlmJ/8z5hkbYxkEm4udcHHNqv4lPAhpfTPtjnctEHPEhIxLse9EzdxzUrG0c=
X-Received: by 2002:a5d:6484:0:b0:391:2c0c:1270 with SMTP id
 ffacd0b85a97d-39132d77726mr16046758f8f.1.1741803757492; Wed, 12 Mar 2025
 11:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250312125452.53671-1-clamor95@gmail.com>
 <20250312181620.GW2640854@bill-the-cat>
In-Reply-To: <20250312181620.GW2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Mar 2025 20:22:26 +0200
X-Gm-Features: AQ5f1Jq_t8C91IuHXm3el0gqa2Safk5A7AI6Xtd0dxQuYNO5DnIv6ssltmDfVR4
Message-ID: <CAPVz0n0jGtmV7tN5VhxiMNQYRauNV9pCTL9WLE=Jnv8+D8c6jw@mail.gmail.com>
Subject: Re: Please pull u-boot-tegra staging
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

=D1=81=D1=80, 12 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 20:16 Tom =
Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Mar 12, 2025 at 02:54:50PM +0200, Svyatoslav Ryhel wrote:
> > Dear Tom,
> >
> > The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf=
71ca:
> >
> >   Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> >
> > for you to fetch changes up to b156a1171e356f16aac88322b3bdcec071543c6c=
:
> >
> >   configs: qc750: add 3 second delay before power off (2025-03-11 19:47=
:07 +0200)
> >
> > ----------------------------------------------------------------
> > Jonas Schw=C3=B6bel (2):
> >       common: edid: update timing selection logic
>
> One thing I would like to see as a future clean-up is if we can go back
> to the old method as a compile time option, if that's reasonable? It's
> adding about 10KiB worth of table the way it is today. Thanks.
>

It should be possible to add a config option to guard standard timings
and enable them only for devices which need them. Will this be an
acceptable solution?

> --
> Tom
