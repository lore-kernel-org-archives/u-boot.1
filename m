Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A1BC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 13:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC82D88966;
	Mon, 26 Aug 2024 15:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="k8UElXAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5E16889B3; Mon, 26 Aug 2024 11:13:13 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C9688846
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef27bfd15bso41686651fa.2
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724663591; x=1725268391;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHUleq8kX6BJ6HqOXe8IJWrB45QWwTjpkLds7cySE+Y=;
 b=k8UElXAUPAoOE7eOBWy5gyEKPnwTwVqAYHjcbHyIkytrQ6k07GmGbDpgHt+ztZLQ9L
 WuVnvTWWTgywM/isfN7R/9HF556WsxIYISbFD4f1f1dlcMVsBfcxT7WfRJFQj4bMeDqh
 N+03GGI4MdN/5ICoCfqwFR7cCpDAosn/ZvjQrqsdwZOdE55OLtHfGXL7e18bBNzq+q6D
 vvA5E4IgB3GqXwPRf5JtPVdvb7UCHb9yEEkdaYIcBkOy64ehyYaOWTMdUkH9xVNqMeVs
 z11vOahRSt7DJUzg5vcixt1upKUxUQvMmFP/TZFQc+SetYNt/MKc9OZ7w4UaItOk5i4B
 h+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724663591; x=1725268391;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHUleq8kX6BJ6HqOXe8IJWrB45QWwTjpkLds7cySE+Y=;
 b=V1nn24a7wf7GR5NuTiXg1Z+4NZMQy8z1xs1cq87foFZULCxgBOVPYdiZe/Bvqo04D8
 Z5UFSPzDrkXnP2Isd5pUyteRNh+szogjuAery25iXr9iYsHpEj0UZid+DcNiHZ5201vX
 51A4AJJNeX8wtyWVPaSkvVAInP6FsGcvz+ejSdVu2ibDifzt64m+lFCN3KDtgEHj7zsS
 CLEDXkbGXApv4aoaLxWnNcCO2BU6XV72AojUVY/RHgx2t80HBJrE8rdrgSzHjL6cOUex
 W226S5AXMldxygrhUUsaya1A0qkknM25DKotkxm+rP6ycXgMg9gqxd9nUGRRtqcCEXX3
 WpUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqj8bd+fbuko3L56G6Yr502a3JZCJP3wRzIEe26rAiTMrQyDyC9pRjt7leT4P0WegH71Bpjqo=@lists.denx.de
X-Gm-Message-State: AOJu0YyvSOjbXHc/nKSFLzF5r+9Zp4X2b6XfW0wA3dqt/QpQhrUcPYq+
 2ro81TSo+1L12Weg7vmKyGQYmw9wpAasw57NbmQyAit8R3Vn9bchjheAAJwan+JciYjvN1nTZuc
 JUMXV0HG9/mGSFCvkd9owF+As9y7DLjfYDq8MRGwFqRorALJjDK8=
X-Google-Smtp-Source: AGHT+IHUK0y/JaxiK+6RIApoMI/q8kutEAfdvAISxvkyXZEKV0q384JrkAopmYm4vKlwJyWJtP2v8gZ+8qN/B8biWKs=
X-Received: by 2002:a2e:4c11:0:b0:2f3:eabc:d27a with SMTP id
 38308e7fff4ca-2f4f49424b2mr62609351fa.43.1724663590700; Mon, 26 Aug 2024
 02:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
 <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
 <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
 <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
 <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
 <CA+Gyqeair5Ak2-b32JL9PkoPrJaa9dg1NwQ3s+8+ycCxdv-HDg@mail.gmail.com>
 <5a278214-6343-418d-b1b4-05804585319c@denx.de>
 <c4e92485-439a-4216-a4d9-ab192e0bca80@denx.de>
In-Reply-To: <c4e92485-439a-4216-a4d9-ab192e0bca80@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Mon, 26 Aug 2024 11:12:59 +0200
Message-ID: <CA+GyqeZ+_Lg7Jrga5N2+kAvWcM4Vtkv3hyqEs=+o583PoGw0Gw@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Aug 2024 15:24:29 +0200
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

On Sun, Aug 25, 2024 at 2:13=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> >
> > I am looking at the usb_add_gadget_udc_release() and
> > usb_gadget_probe_driver() and I am thinking, sigh, all that code is
> > ready to be replaced by something cleaner which does not use this
> > special struct usb_udc and udc_list, but instead only uses U-Boot DM
> > udevices . But I am reluctant to ask you to do all that rework, because
> > that is WAY out of scope of the problem you are trying to fix.
>

Thank you for looking into this, refactor udc core could make things clear.

> Maybe this could be a start (compile tested only):
>
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/usb-udc-udev=
ice

Tested no regression with usba_udc.
